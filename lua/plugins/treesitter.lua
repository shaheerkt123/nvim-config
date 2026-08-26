return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      install = { "lua", "python", "javascript", "bash", "json", "c", "go", "rust" },
      auto_install = true,
    },
  },
}
