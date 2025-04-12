-- Colorscheme plugin configuration

return {
  "catppuccin/nvim", 
  name = "catppuccin", 
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true, -- Enable transparency
      term_colors = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        which_key = true,
      },
    })
    vim.cmd.colorscheme "catppuccin"
    
    -- Additional transparency settings
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  end
} 