-- lua/plugins/fugitive.lua
return {
  "tpope/vim-fugitive",
  lazy = false, -- Force plugin to load immediately on startup
  config = function()
    vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
    vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff split" })
    vim.keymap.set("n", "<leader>gl", "<cmd>Gclog<cr>", { desc = "Git log (current file)" })
    vim.keymap.set("n", "<leader>gL", "<cmd>Gclog --<cr>", { desc = "Git log (entire project)" })
    vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
    vim.keymap.set("n", "<leader>gP", "<cmd>Git pull<cr>", { desc = "Git pull" })
  end,
}
