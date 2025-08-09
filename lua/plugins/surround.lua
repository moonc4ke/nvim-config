return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        -- Default keymaps (more intuitive)
        normal = "ys",        -- ys + motion + char to add surround
        normal_cur = "yss",   -- yss + char to surround current line
        visual = "S",         -- S + char to surround selection
        delete = "ds",        -- ds + char to delete surround
        change = "cs",        -- cs + old_char + new_char to change
        -- Disable insert mode keymaps for simplicity
        insert = false,
        insert_line = false,
        normal_line = false,
        normal_cur_line = false,
        visual_line = false,
        change_line = false,
      },
    })
  end,
}