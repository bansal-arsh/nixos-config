require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git/",
			".venv",
			"__pycache__",
			".ruff_cache",
		},
	},
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = "Telescope find files" })

vim.keymap.set("n", "<leader>tg", builtin.git_files, { desc = "Telescope find git files" })

vim.keymap.set("n", "<leader>ts", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope search grep string in project" })
