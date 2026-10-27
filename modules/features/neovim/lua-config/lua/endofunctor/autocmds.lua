local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking
autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = augroup("yank-highlight", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Remove "cro" from formatoptions even when Neovim forcefully adds it
autocmd("FileType", {
	group = augroup("FormatOptionsOverride", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

local function isValidFileBuffer()
	-- A view is only meaningful for a normal buffer backed by a real file.
	if vim.bo.buftype ~= "" then
		return false
	end

	-- Check if file is an actual file
	local buf = vim.api.nvim_get_current_buf()
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" or vim.fn.filereadable(name) == 0 then
		return false
	end

	return true
end

local fold_group = augroup("RememberFolds", { clear = true })

-- Save folds when leaving a buffer
autocmd("BufWinLeave", {
	group = fold_group,
	pattern = "*",
	callback = function()
		if not isValidFileBuffer() then
			return
		end
		vim.cmd("mkview")
	end,
})

-- Load folds when entering a buffer
autocmd("BufWinEnter", {
	group = fold_group,
	pattern = "*",
	callback = function()
		if not isValidFileBuffer() then
			return
		end

		local currentPos = vim.api.nvim_win_get_cursor(0) -- loadview messes up cursor for some reason, so we manually fix it

		-- Scheduling this after main event loop so that loadview is called AFTER treesitter loads
		vim.schedule(function()
			vim.cmd("silent! loadview")
			vim.api.nvim_win_set_cursor(0, currentPos)
		end)
	end,
})

-- Selectively enable two-space indenting for chosen filetypes
autocmd("FileType", {
	group = augroup("SetIndentation", { clear = true }),
	pattern = "*",
	callback = function()
		if not isValidFileBuffer() then
			return
		end

		local two_indent_ft = {
			"html",
			"yaml",
			"json",
			"nix",
			"typst",
		}

		local indent = 4
		if vim.tbl_contains(two_indent_ft, vim.bo.filetype) then
			indent = 2
		end

		-- Setting options for tab spacing
		vim.schedule(function()
			vim.opt.tabstop = indent
			vim.opt.softtabstop = indent
			vim.opt.shiftwidth = indent
			vim.opt.expandtab = true
		end)
	end,
})
