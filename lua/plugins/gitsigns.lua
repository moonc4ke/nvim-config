return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "‾" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,

      -- Inline blame like “You, 6 days ago — message”
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 250,
      },
      -- ✅ robust, built-in formatter (handles nil timestamps etc.)
      current_line_blame_formatter = "<author>, <author_time:%R> — <summary>",

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Hunk nav
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")

        -- Hunk ops
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gd", gs.diffthis, "Diff this")

        -- Blame
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame (popup)")
        map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")
      end,
    },
  },
}

