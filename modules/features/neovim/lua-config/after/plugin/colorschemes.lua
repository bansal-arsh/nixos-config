-- Colorschemes
require("cyberdream").setup({
	-- colors = {
	-- 	dark = {
	-- 		bg = "#000000"
	-- 	}
	-- }
})

-- require("silkcircuit").setup()
--
-- require("cyberpunk").setup({
-- 	-- Theme variant
-- 	style = "storm", -- storm, night, neon
--
-- 	-- Transparency
-- 	transparent = false,
--
-- 	-- Terminal colors
-- 	terminal_colors = true,
--
-- 	-- Style customization
-- 	styles = {
-- 		comments = { italic = true },
-- 		keywords = { bold = true },
-- 		functions = { bold = true },
-- 		variables = {},
-- 		sidebars = "dark", -- dark, transparent
-- 		floats = "dark", -- dark, transparent
-- 	},
--
-- 	-- Plugin integrations
-- 	plugins = {
-- 		-- Core editing
-- 		treesitter = true,
-- 		lsp = true, -- enables LSP semantic token highlights
--
-- 		-- File exploration
-- 		telescope = true,
-- 		nvim_tree = true,
-- 		oil = true,
--
-- 		-- UI enhancements
-- 		lualine = true,
-- 		which_key = true,
--
-- 		-- Code completion
-- 		blink_cmp = true,
--
-- 		-- Git integration
-- 		gitsigns = true,
-- 		-- fugitive = true,
--
-- 		-- Code display
-- 		indent_blankline = true,
-- 	},
-- })

-- Colorscheme manager
require("themery").setup({
	livePreview = true,
	themes = {
		"cyberdream",
		-- "silkcircuit",
		-- "cyberpunk",
	},
})

-- Enable default colorscheme
vim.cmd.colorscheme("cyberdream")
