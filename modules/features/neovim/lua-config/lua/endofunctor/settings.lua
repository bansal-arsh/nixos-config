-- Setting relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Wrapped lines stay at same indentation level as original line
vim.opt.breakindent = true

-- Smartly indent based on bracekts
vim.opt.smartindent = true

-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

-- Time taken before carrying out neovim processes (kinda like refresh rate)
vim.opt.updatetime = 100

-- Default splitting directions
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Highlights line with cursor
vim.opt.cursorline = true

-- Disable Neovim from displaying current mode (Statusline already does that)
vim.opt.showmode = false

-- Number of lines to keep as cushion when scrolling at the top or bottom
vim.opt.scrolloff = 7

-- Confirm for saving or deleting modified buffers when quitting
vim.opt.confirm = true

-- Incremental highlighting for finding and substituting
vim.opt.inccommand = "split"
vim.opt.incsearch = true

-- Ignore casing for finding and substituting unless a capital letter is in search string
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable sign column
vim.opt.signcolumn = "yes"

-- Turn off autocomment for next line
vim.schedule(function()
	vim.opt.formatoptions = vim.opt.formatoptions:remove({ "c", "r", "o" })
end)

-- Set deafult window border for floating windows
vim.opt.winborder = "rounded"

-- Folds only start after this many nests (practically makes unfolding default behaviour)
vim.opt.foldlevelstart = 99

-- Only save folds when creating view
vim.opt.viewoptions = "folds"
