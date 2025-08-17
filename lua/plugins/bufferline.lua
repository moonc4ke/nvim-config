return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
  opts = {
    options = {
      close_command = function(n)
        vim.api.nvim_buf_delete(n, { force = false })
      end,
      right_mouse_command = function(n)
        vim.api.nvim_buf_delete(n, { force = false })
      end,
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_buffer_icons = false,
      show_tab_indicators = false,
      separator_style = { "", "" },
      indicator = {
        style = 'none',
      },
      enforce_regular_tabs = false,
      tab_size = 0,
      max_name_length = 30,
      modified_icon = '●',
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
