return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 5,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = nil,
      zindex = 20,
      on_attach = nil,
    })

    -- Use a subtle background from Catppuccin surface0 color
    vim.api.nvim_set_hl(0, 'TreesitterContext', {
      bg = '#313244',  -- Catppuccin surface0 for subtle distinction
      fg = '#cdd6f4'   -- Ensure text is visible
    })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
      fg = '#585b70',  -- Catppuccin overlay1
      bg = '#313244'   -- Same background as context
    })
    -- Bottom line highlights without underline
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {
      bg = '#313244'
    })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', {
      bg = '#313244',
      fg = '#585b70'
    })
  end
}
