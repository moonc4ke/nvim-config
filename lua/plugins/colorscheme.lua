-- Colorscheme plugin configuration

return {
  "catppuccin/nvim", 
  name = "catppuccin", 
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = false, -- Disable transparency
      term_colors = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        which_key = true,
      },
    })
    vim.cmd.colorscheme "catppuccin"
    
  end
} 