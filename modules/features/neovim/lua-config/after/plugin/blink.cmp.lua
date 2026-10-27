local cmp = require("blink.cmp")
-- cmp.build():pwait()
cmp.setup({
	signature = {
		enabled = true,
		window = { show_documentation = true },
	},
	keymap = {
		preset = "none",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

		["<CR>"] = { "select_and_accept", "fallback" },

		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },

		["<C-d>"] = { "scroll_documentation_up", "scroll_signature_up" },
		["<C-c>"] = { "scroll_documentation_down", "scroll_signature_down" },
	},
	completion = {
		menu = {
			auto_show = function(_)
				local row, column = unpack(vim.api.nvim_win_get_cursor(0))
				local success, node = pcall(vim.treesitter.get_node, {
					pos = { row - 1, math.max(0, column - 1) },
					ignore_injections = false,
				})
				local reject =
					{ "comment", "line_comment", "block_comment", "string_start", "string_content", "string_end" }
				if success and node and vim.tbl_contains(reject, node:type()) then
					return false
				end
				-- whatever other logic you want beyond this
				return true
			end,
		},
		trigger = {
			show_on_backspace_after_insert_enter = false,
		},
		list = {
			selection = { auto_insert = false },
		},
		ghost_text = { enabled = true, show_with_menu = true },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
	},
	sources = {
		default = { "lsp", "path", "snippets" },
	},
})
