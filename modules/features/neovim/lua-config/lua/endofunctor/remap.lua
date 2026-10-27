vim.g.mapleader = " "

-- Escape key turns off hlsearch
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch)

-- Move visual blocks of text with indenting
vim.keymap.set("v", "<S-j>", function()
	return ":m '>+" .. vim.v.count1 .. "<CR>gv=gv"
end, { expr = true })
vim.keymap.set("v", "K", function()
	return ":m '<-" .. (1 + vim.v.count1) .. "<CR>gv=gv"
end, { expr = true })

-- Different copy paste keybinds for OS clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

-- Disable deleting to registers (except x in visual mode)
vim.api.nvim_set_keymap("n", "d", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("v", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true })
vim.api.nvim_set_keymap("n", "c", '"_c', { noremap = true })
vim.api.nvim_set_keymap("v", "c", '"_c', { noremap = true })

-- Adjust o and O functionalities
vim.api.nvim_set_keymap("n", "o", "o<Esc>", { noremap = true })
vim.keymap.set("n", "O", function()
	local num_up_keystrokes = vim.v.count1 - 1
	local esc = vim.keycode("<Esc>")
	local cmd_string = "O" .. esc
	if num_up_keystrokes > 0 then
		cmd_string = (num_up_keystrokes + 1) .. cmd_string .. num_up_keystrokes .. "k"
	end
	vim.api.nvim_feedkeys(cmd_string, "n", false)
end, { noremap = true })

-- Make append ("a") automatically indent
vim.keymap.set("n", "a", function()
	local line = vim.api.nvim_get_current_line()
	if line:match("^%s*$") then
		-- return '0"_c$<Esc>aa<Esc><S-V>=$"_cl'
		return '0"_c$<BS><CR>'
	else
		return "a"
	end
end, { expr = true })
