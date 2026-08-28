return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    -- Basic Harpoon Keymaps
    { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
    { "<C-e>", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },

    { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon select 1" },
    { "<C-j>", function() require("harpoon"):list():select(2) end, desc = "Harpoon select 2" },
    { "<C-k>", function() require("harpoon"):list():select(3) end, desc = "Harpoon select 3" },
    { "<C-l>", function() require("harpoon"):list():select(4) end, desc = "Harpoon select 4" },

    -- Toggle previous & next buffers
    { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon prev" },
    { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon next" },

    -- Telescope Integration
    {
      "<leader>h",
      function()
        local harpoon = require("harpoon")
        local conf = require("telescope.config").values
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({ results = file_paths }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end,
      desc = "Open harpoon window in Telescope",
    },
  },
  opts = {},
}
