return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})

    -- Disable unwanted keymaps (v4 keymaps are set outside of setup)
    vim.keymap.del("i", "<C-g>s")
    vim.keymap.del("i", "<C-g>S")
  end,
}