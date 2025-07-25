vim.o.termguicolors = true
return {
  "catppuccin/nvim",
  name = "catppuccin", 
  proority = 1000,
  integrations = {
    coc_nvim = true,
    neotree = true,
    gitsigns = true,
    barbar = true,
  },
}
