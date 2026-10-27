-- [[ Configure Treesitter ]]
--  Used to highlight, edit, and navigate code
--
--  See `:help nvim-treesitter-intro`

-- Ensure basic parsers are installed
-- local parsers = {
-- 	"bash",
-- 	"zsh",
-- 	"c",
-- 	"python",
-- 	"go",
-- 	"typst",
-- 	"diff",
-- 	"html",
-- 	"css",
-- 	"javascript",
-- 	"lua",
-- 	"luadoc",
-- 	"markdown",
-- 	"markdown_inline",
-- 	"query",
-- 	"vim",
-- 	"vimdoc",
-- }
-- require("nvim-treesitter").install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
	-- Check if a parser exists and load it
	if not vim.treesitter.language.add(language) then
		return
	end
	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo.foldmethod = "expr"

	-- Links to Claude Opus code below: Needs review
	vim.o.foldtext = "v:lua.pretty_foldtext()"
	vim.opt.fillchars:append({ fold = " " })

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

	-- Enable treesitter based indentation
	if has_indent_query then
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

local available_parsers = require("nvim-treesitter").get_available()
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then
			return
		end

		local installed_parsers = require("nvim-treesitter").get_installed("parsers")

		if vim.tbl_contains(installed_parsers, language) then
			-- Enable the parser if it is already installed
			treesitter_try_attach(buf, language)
			-- elseif vim.tbl_contains(available_parsers, language) then
			-- 	-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
			-- 	require("nvim-treesitter").install(language):await(function()
			-- 		treesitter_try_attach(buf, language)
			-- end)
		else
			-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})

-- CLAUDE OPUS CODE: NEEDS REVIEW
-- most-specific capture at a byte position (0-indexed row/col)
local function capture_hl(buf, row, col)
	local caps = vim.treesitter.get_captures_at_pos(buf, row, col)
	if #caps == 0 then
		return "Normal"
	end
	return "@" .. caps[#caps].capture
end

local function char_len(b)
	if b < 0x80 then
		return 1
	elseif b < 0xE0 then
		return 2
	elseif b < 0xF0 then
		return 3
	else
		return 4
	end
end

-- turn `str` (a slice starting at byte `start_col` of buffer line `row`)
-- into {text, hlgroup} chunks grouped by Treesitter capture
local function to_chunks(buf, row, str, start_col, out)
	local text, hl, i = "", nil, 0
	while i < #str do
		local clen = char_len(str:byte(i + 1))
		local ch = str:sub(i + 1, i + clen)
		local h = capture_hl(buf, row, start_col + i)
		if h ~= hl then
			if text ~= "" then
				out[#out + 1] = { text, hl }
			end
			text, hl = "", h
		end
		text = text .. ch
		i = i + clen
	end
	if text ~= "" then
		out[#out + 1] = { text, hl }
	end
end

-- innermost node that starts on the fold's first line and reaches its last line
local function fold_node(buf, srow, erow)
	local first = vim.fn.getline(srow + 1)
	local scol = #(first:match("^%s*") or "")
	local node = vim.treesitter.get_node({ bufnr = buf, pos = { srow, scol } })
	while node do
		local ns, _, ne, _ = node:range()
		if ns == srow and ne >= erow then
			return node
		end
		node = node:parent()
	end
	return nil
end

-- descend the last-child chain; the fold has a real closing delimiter iff the
-- final leaf ending on `erow` is an anonymous token (}, ), end, ...) rather
-- than a named node (a Python body statement, etc.)
local function has_closer(node, erow)
	while node do
		local _, _, ne = node:range()
		if ne ~= erow then
			return false
		end
		local n = node:child_count()
		if n == 0 then
			return not node:named()
		end
		node = node:child(n - 1)
	end
	return false
end

function _G.pretty_foldtext()
	local buf = vim.api.nvim_get_current_buf()
	local srow = vim.v.foldstart - 1
	local erow = vim.v.foldend - 1
	local first = vim.fn.getline(vim.v.foldstart)
	local last = vim.fn.getline(vim.v.foldend)

	local chunks = {}
	to_chunks(buf, srow, first, 0, chunks) -- whole first line, real syntax hl
	chunks[#chunks + 1] = { " ... ", "Folded" } -- ONLY this is Folded

	local node = fold_node(buf, srow, erow)
	if node and has_closer(node, erow) then
		-- there IS a closing delimiter: take the full trimmed last line so nested
		-- closers (`})`, `end)`) are included, each with its own capture hl
		local ws, closer = last:match("^(%s*)(.-)%s*$")
		if closer ~= "" then
			to_chunks(buf, erow, closer, #ws, chunks)
		end
	elseif not node then
		-- no Treesitter node found: fall back to leading closing brackets only
		local ws, closer = last:match("^(%s*)([%)%]}]+)")
		if closer then
			to_chunks(buf, erow, closer, #ws, chunks)
		end
	end
	-- (delimiter-less blocks like Python bodies append nothing  `def foo(): .`)

	local sp = string.rep(" ", vim.bo.tabstop)
	for _, c in ipairs(chunks) do
		c[1] = c[1]:gsub("\t", sp)
	end
	return chunks
end
