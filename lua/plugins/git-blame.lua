return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  config = function()
    require("gitblame").setup({
      enabled = false,  -- Start disabled, toggle with keymap
      message_template = " <author> • <date> • <summary>",
      date_format = "%r",  -- Relative date like "2 hours ago"
      message_when_not_committed = " Not committed yet",
      highlight_group = "Comment",
      set_extmark_options = {
        priority = 7,
      },
      display_virtual_text = true,
      ignored_filetypes = {},
      delay = 0,  -- No delay for faster response
      virtual_text_column = nil,  -- Display at end of line
    })
    
    -- Toggle keymap
    vim.keymap.set("n", "<leader>gB", "<cmd>GitBlameToggle<CR>", { desc = "Toggle inline blame" })
    
    -- Additional commands with different prefix to avoid conflicts
    vim.keymap.set("n", "<leader>go", "<cmd>GitBlameOpenCommitURL<CR>", { desc = "Open commit URL" })
    vim.keymap.set("n", "<leader>gc", "<cmd>GitBlameCopySHA<CR>", { desc = "Copy commit SHA" })
  end,
}