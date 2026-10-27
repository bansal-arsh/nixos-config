require("lint").linters_by_ft = {
	python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("Linting", { clear = true }),
	desc = "Lint after save",
	callback = function()
		require("lint").try_lint()
	end,
})
