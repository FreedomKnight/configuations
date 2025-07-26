return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-phpunit"
  },
  keys = {
    {
      "t<C-n>",
      function()
        require("neotest").run.run()
      end,
      desc = "Run the nearest test",
    },
    {
      "t<C-f>",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run the current file",
    },
    {
      "t<C-s>",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle testing summary",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-phpunit")({
          phpunit_cmd = function()
            return "vendor/bin/phpunit"
          end,
          root_files = { "phpunit.xml", "phpunit.xml.dist", "composer.json" },
          filter_dirs = { "vendor" },
        }),
      },
      discovery = {
        enabled = true,
        concurrent = 1,
      },
      diagnostic = {
        enabled = true,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = true,
      },
    })
  end
}
