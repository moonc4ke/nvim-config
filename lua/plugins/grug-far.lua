return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      -- Options for grug-far
      windowCreationCommand = "vsplit",
      keymaps = {
        -- Most important actions first
        replace = { n = "<C-r>" },           -- Ctrl+r to Replace All
        refresh = { n = "<C-f>" },           -- Ctrl+f to Refresh

        -- Sync actions
        syncLocations = { n = "<C-s>" },     -- Ctrl+s to Sync All
        syncLine = { n = "<C-l>" },          -- Ctrl+l to Sync Line
        syncNext = { n = "<C-n>" },          -- Ctrl+n to Sync Next
        syncPrev = { n = "<C-p>" },          -- Ctrl+p to Sync Prev
        syncFile = { n = "<C-v>" },          -- Ctrl+v to Sync File

        -- Navigation
        gotoLocation = { n = "<enter>" },    -- Enter to go to location
        openLocation = { n = "<C-o>" },      -- Ctrl+o to open location

        -- Apply changes
        applyNext = { n = "<C-j>" },         -- Ctrl+j to Apply Next
        applyPrev = { n = "<C-k>" },         -- Ctrl+k to Apply Prev

        -- History
        historyOpen = { n = "<C-h>" },       -- Ctrl+h for history
        historyAdd = { n = "<C-a>" },        -- Ctrl+a to add to history
        pickHistoryEntry = { n = "<enter>" }, -- Enter to pick from history

        -- Tools
        qflist = { n = "<C-q>" },            -- Ctrl+q to send to quickfix
        swapEngine = { n = "<C-e>" },        -- Ctrl+e to swap search engine
        previewLocation = { n = "<C-i>" },   -- Ctrl+i to preview
        swapReplacementInterpreter = { n = "<C-x>" }, -- Ctrl+x to swap interpreter
        toggleShowCommand = { n = "<C-w>" }, -- Ctrl+w to toggle search command

        -- Exit
        close = { n = "q" },                 -- q to close
        abort = { n = "<Esc>" },             -- Esc to abort
      },
    })

    -- Keymaps to open grug-far
    vim.keymap.set('n', '<leader>sr', function()
      require("grug-far").open()
    end, { desc = "Search and Replace (project-wide)" })

    vim.keymap.set('v', '<leader>sr', function()
      require("grug-far").with_visual_selection()
    end, { desc = "Search and Replace (with selection)" })

    -- Optional: Replace in current file only
    vim.keymap.set('n', '<leader>sf', function()
      require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
    end, { desc = "Search and Replace (current file)" })
  end,
}
