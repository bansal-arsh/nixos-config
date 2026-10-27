local conform = require("conform")

local function first(bufnr, ...)
	for i = 1, select("#", ...) do
		local formatter = select(i, ...)
		if conform.get_formatter_info(formatter, bufnr).available then
			return formatter
		end
	end
	return select(1, ...)
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		html = function(bufnr)
			return { first(bufnr, "prettierd", "prettier"), "remove_self_closing_tag", stop_after_first = false }
		end,
		nix = { "alejandra" },
		css = { "prettierd", "prettier" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		jsx = { "prettierd", "prettier" },
		tsx = { "prettierd", "prettier" },
		go = { "gofmt" },
		python = { "ruff" },
	},

	formatters = {
		ruff = {
			command = "ruff",
			args = { "format", "$FILENAME" },
			stdin = false,
		},
		remove_self_closing_tag = {
			command = "sed",
			args = { "-i", "s|\\(\\S\\)\\s/>|\\1>|g; s|/>|>|g", "$FILENAME" },
			stdin = false,
		},
	},

	default_format_opts = {
		lsp_format = "fallback",
		stop_after_first = true,
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 1000,
	},
})
