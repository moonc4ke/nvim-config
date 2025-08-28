return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 100,
      },
      preview_config = {
        border = 'single',
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc="Next git hunk"})

        map('n', '[h', function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc="Previous git hunk"})

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, {desc="Stage hunk"})
        map('n', '<leader>gr', gs.reset_hunk, {desc="Reset hunk"})
        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc="Stage hunk"})
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc="Reset hunk"})
        map('n', '<leader>gS', gs.stage_buffer, {desc="Stage buffer"})
        map('n', '<leader>gu', gs.undo_stage_hunk, {desc="Undo stage hunk"})
        map('n', '<leader>gR', gs.reset_buffer, {desc="Reset buffer"})
        map('n', '<leader>gp', gs.preview_hunk, {desc="Preview hunk"})
        map('n', '<leader>gP', function() gs.blame_line{full=true} end, {desc="Blame line"})
        map('n', '<leader>gB', gs.toggle_current_line_blame, {desc="Toggle inline blame"})
        map('n', '<leader>gd', gs.diffthis, {desc="Diff this"})
        map('n', '<leader>gD', function() gs.diffthis('~') end, {desc="Diff this ~"})
        map('n', '<leader>gt', gs.toggle_deleted, {desc="Toggle deleted"})

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc="Select hunk"})
      end
    })

    -- Ensure gitsigns attaches to buffers opened from external sources (like lazygit)
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("GitSignsLazyAttach", { clear = true }),
      callback = function(args)
        local bufnr = args.buf

        -- Check if buffer is valid and is a normal file
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        local buftype = vim.bo[bufnr].buftype
        if buftype ~= "" then
          return
        end

        local file = vim.api.nvim_buf_get_name(bufnr)
        if file == "" or vim.fn.isdirectory(file) == 1 then
          return
        end

        -- Defer to ensure everything is loaded
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            -- Force gitsigns to refresh for this buffer
            pcall(function()
              require('gitsigns').attach(bufnr)
            end)
          end
        end, 100)
      end,
    })

    -- Auto-refresh gitsigns after git operations
    local refresh_gitsigns = function()
      pcall(function()
        require('gitsigns').refresh()
        -- Also refresh all visible buffers
        for _, winid in ipairs(vim.api.nvim_list_wins()) do
          local bufnr = vim.api.nvim_win_get_buf(winid)
          if vim.bo[bufnr].buftype == "" then
            require('gitsigns').attach(bufnr)
          end
        end
      end)
    end

    -- Manual refresh keymap
    vim.keymap.set('n', '<leader>gF', function()
      refresh_gitsigns()
      vim.notify("GitSigns refreshed")
    end, { desc = "Refresh/Force update Git status" })
  end
}