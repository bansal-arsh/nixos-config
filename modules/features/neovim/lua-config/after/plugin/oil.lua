local oil = require("oil")

oil.setup({
	constrain_cursor = "name",
	watch_for_changes = false,
	view_options = {
		show_hidden = true,
	},
	float = {
		border = "double",
	},
})

vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
