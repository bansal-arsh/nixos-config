local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.setup({
	check_ts = true,
	fast_wrap = {},
})

-- Moves over > in a HTML tag
-- Before: <div|>, Input: >, After: <div>|
npairs.add_rules({
	Rule("<.*", ">", { "html" })
		:with_pair(cond.none())
		:with_del(cond.none())
		:with_move(function(opts)
			return opts.char == ">"
		end)
		:use_regex(true, ">"),

	-- $ → $|$
	Rule("$", "$", "typst"):with_pair(cond.not_before_text("\\")):with_move(cond.done()):with_del(cond.done()),

	-- Space inside $|$ → $ | $
	Rule(" ", " ", { "typst", "markdown", "latex" })
		:with_pair(function(opts)
			return opts.line:sub(opts.col - 1, opts.col) == "$$"
		end)
		:with_move(cond.none())
		:with_cr(cond.none())
		:with_del(function(opts) -- <BS> in $ | $ deletes both spaces
			local col = vim.api.nvim_win_get_cursor(0)[2]
			return opts.line:sub(col - 1, col + 2) == "$  $"
		end),
})

-- Moves over punctuation when creating a new line
--   Before         Input             After
-- {                                {
--    hello|,       <CR>                hello,
-- }                                    |
--                                  }
-- Moves over punctuation when inserting punctuation
--   Before         Input             After
-- {                                {
--    hello|,         ,                 hello,|
-- }                                }
-- for _, punct in pairs({ ",", ";" }) do
-- 	npairs.add_rules({
-- 		Rule(".+", punct, { "-text" })
-- 			:with_pair(cond.none())
-- 			:with_del(cond.none())
-- 			:with_move(function(opts)
-- 				return string.sub(opts.line, opts.col + 1, opts.col + 1) == punct
-- 			end)
-- 			:with_cr(cond.after_regex("%s*$"))
-- 			:use_regex(true, punct)
-- 			:replace_map_cr(function(_)
-- 				return "<C-g>u<Esc>o"
-- 			end),
-- 	})
-- end
