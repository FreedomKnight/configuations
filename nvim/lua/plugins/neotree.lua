return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
  },
  keys = {
    {
      "<C-n>",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Toggle NeoTree",
    },
  },
  config = function()
    require('neo-tree').setup { 
      window = {
        mappings = {
          ["o"] = {
            "open",
            nowait = true,
          },
          ["?"] = {
            "show_help",
            nowait = false,
            config = { title = "Order by", prefix_key = "o" },
          },
        },
      }
    }
  end,
}
