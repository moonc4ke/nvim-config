return {
  "tanvirtin/vgit.nvim",
  lazy = false,  -- Load immediately to ensure it's ready for external file opens
  priority = 100,  -- Load early
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons"  -- Optional but recommended
  },
  config = function()
    local vgit = require("vgit")
    vgit.setup({
      keymaps = {},  -- Disable built-in keymaps, we'll set them manually
      settings = {
        git = {
          cmd = "git",
          fallback_cwd = vim.fn.expand("$HOME"),
          fallback_args = {
            "--git-dir",
            vim.fn.expand("$HOME/.git"),
            "--work-tree",
            vim.fn.expand("$HOME"),
          },
        },
        hls = {
          GitBackground = 'Normal',
          GitHeader = 'NormalFloat',
          GitFooter = 'NormalFloat',
          GitBorder = 'FloatBorder',
          GitLineNr = 'LineNr',
          GitComment = 'Comment',
          GitSignsAdd = {
            gui = nil,
            fg = '#8ec07c',
            bg = nil,
            sp = nil,
            override = false,
          },
          GitSignsChange = {
            gui = nil,
            fg = '#fabd2f',
            bg = nil,
            sp = nil,
            override = false,
          },
          GitSignsDelete = {
            gui = nil,
            fg = '#fb4934',
            bg = nil,
            sp = nil,
            override = false,
          },
        },
        live_blame = {
          enabled = false,  -- Keep disabled since we're using git-blame.nvim
        },
        live_gutter = {
          enabled = true,
          edge_navigation = false, -- Disable edge navigation
        },
        authorship_code_lens = {
          enabled = false,
        },
        scene = {
          diff_preference = 'unified',
        },
      },
    })

    -- Set up keymaps with descriptions for which-key
    vim.keymap.set('n', ']h', function() vgit.hunk_down() end, { desc = "Next git hunk" })
    vim.keymap.set('n', '[h', function() vgit.hunk_up() end, { desc = "Previous git hunk" })
    vim.keymap.set('n', '<leader>gn', function() vgit.hunk_down() end, { desc = "Next git change" })
    vim.keymap.set('n', '<leader>gN', function() vgit.hunk_up() end, { desc = "Previous git change" })
    vim.keymap.set('n', '<leader>gs', function() vgit.buffer_hunk_stage() end, { desc = "Stage hunk" })
    vim.keymap.set('n', '<leader>gr', function() vgit.buffer_hunk_reset() end, { desc = "Reset hunk" })
    vim.keymap.set('n', '<leader>gp', function() vgit.buffer_hunk_preview() end, { desc = "Preview hunk" })
    vim.keymap.set('n', '<leader>gP', function() vgit.buffer_blame_preview() end, { desc = "Blame preview (popup)" })
    vim.keymap.set('n', '<leader>gd', function() vgit.buffer_diff_preview() end, { desc = "Diff preview" })
    vim.keymap.set('n', '<leader>gH', function() vgit.buffer_history_preview() end, { desc = "File history" })
    vim.keymap.set('n', '<leader>gS', function() vgit.buffer_stage() end, { desc = "Stage buffer" })
    vim.keymap.set('n', '<leader>gR', function() vgit.buffer_reset() end, { desc = "Reset buffer" })

    -- Ensure vgit attaches to buffers opened from external sources (like lazygit)
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("VGitLazyAttach", { clear = true }),
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
            -- Force vgit to refresh for this buffer
            pcall(function()
              require('vgit').buffer_attach(bufnr)
            end)
          end
        end, 100)
      end,
    })
  end,
}
