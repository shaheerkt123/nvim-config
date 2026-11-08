-- lua/config/keymaps.lua

-- System Clipboard Pasting
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from system clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard (replace selection)" })
vim.keymap.set("v", "<leader>P", '"+P', { desc = "Paste before selection from system clipboard" })

-- System Clipboard Yanking
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank motion to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Moving lines in Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Line joining and centering movements
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below (keep cursor position)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search match (centered)" })

-- Blackhole Register Deletes
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete motion to blackhole register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete selection to blackhole register" })
