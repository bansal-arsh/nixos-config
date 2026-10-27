local function Plug(repo, options)
	if options then
		vim.fn["plug#"](repo, options)
	else
		vim.fn["plug#"](repo)
	end
end

vim.call("plug#begin")

-- =============================================
--                Dependencies
-- =============================================

-- Nerd Font Icons (Dependency)
Plug("nvim-tree/nvim-web-devicons")

-- Predefined Lua Functions
Plug("nvim-lua/plenary.nvim")

-- =============================================
--               Core IDE Stuff
-- =============================================

-- Treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

-- Preset LSP configurations
Plug("neovim/nvim-lspconfig")

-- Mason
Plug("mason-org/mason.nvim")
Plug("mason-org/mason-lspconfig.nvim")
Plug("WhoIsSethDaniel/mason-tool-installer.nvim")

-- Completion engine
Plug("saghen/blink.lib")
Plug("saghen/blink.cmp")

-- Formatting
Plug("stevearc/conform.nvim")

-- Linting
Plug("mfussenegger/nvim-lint")

-- =============================================
--                 Utilities
-- =============================================

-- Telescope
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "*" })

-- Undotree
Plug("mbbill/undotree")

-- Indentation Guide
Plug("lukas-reineke/indent-blankline.nvim")

-- LSP File-based refactoring
Plug("antosha417/nvim-lsp-file-operations")

-- Autopairing (for brackets and quotes)
Plug("windwp/nvim-autopairs")

-- Git Signs
Plug("lewis6991/gitsigns.nvim") -- Also a dependency

-- Keymap display
Plug("folke/which-key.nvim")

-- Sidebar File Tree
Plug("nvim-tree/nvim-tree.lua")

-- Buffer FS Editor
Plug("stevearc/oil.nvim")

-- =============================================
--                    Rice
-- =============================================

-- Colorscheme Manager
Plug("zaldih/themery.nvim")

-- Colorschemes
Plug("scottmckendry/cyberdream.nvim")
Plug("hyperb1iss/silkcircuit")
Plug("pablobfonseca/cyberpunk-theme")

-- Statusline
Plug("nvim-lualine/lualine.nvim")

-- =============================================
--             Language Specific
-- =============================================

-- Typst Preview
Plug("chomosuke/typst-preview.nvim", { ["tag"] = "v1.*" })

-- =============================================
--              Miscellaneous
-- =============================================

-- VimBeGood Game
Plug("ThePrimeagen/vim-be-good")

vim.call("plug#end")
