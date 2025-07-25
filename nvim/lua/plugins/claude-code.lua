return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    vim.o.splitright = true
    vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
    require("claude-code").setup({
      command = "nvm use default && claude",
      window = {
        position = "vertical",
      },
    })
  end
}
