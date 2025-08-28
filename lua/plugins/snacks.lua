return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- Move existing keymaps here
    { "<leader>ff", function() require("snacks").picker.files() end, desc = "Find files" },
    { "<leader>fg", function() require("snacks").picker.grep() end, desc = "Live grep" },
    { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Find buffers" },
    { "<leader>fh", function() require("snacks").picker.help() end, desc = "Find help" },
    { "<leader>fr", function() require("snacks").picker.recent() end, desc = "Recent files" },
    { "<leader>fc", function() require("snacks").picker.commands() end, desc = "Commands" },
    -- Add git file history
    { "<leader>gH", function() require("snacks").picker.git_log_file() end, desc = "Git file history" },
    { "<leader>gv", function() require("snacks").picker.git_diff() end, desc = "Git diff" },
  },
  config = function()
    require("snacks").setup({
      -- Enable all modules
      picker = {
        enabled = true,
      },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
        preset = {
          keys = {
            { icon = "󰈞", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
            { icon = "󰈔", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "󰊄", key = "g", desc = "Find Text", action = ":lua require('snacks').picker.grep({ args = { '--fixed-strings' } })" },
            { icon = "󰋚", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = "󰒓", key = "c", desc = "Config", action = ":lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})" },
            { icon = "󰒲", key = "L", desc = "Lazy", action = ":Lazy" },
            { icon = "󰈆", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      explorer = { enabled = true },
      image = { enabled = true },
      input = { enabled = true },
      lazygit = {
        enabled = true,
        theme = {
          [241]                   = { fg = "Special" },
          activeBorderColor       = { fg = "MatchParen", bold = true },
          cherryPickedCommitBgColor = { fg = "Identifier" },
          cherryPickedCommitFgColor = { fg = "Function" },
          defaultFgColor          = { fg = "Normal" },
          inactiveBorderColor     = { fg = "FloatBorder" },
          optionsTextColor        = { fg = "Function" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor     = { bg = "Visual" },
          unstagedChangesColor    = { fg = "DiagnosticError" },
          activeTabBgColor        = { bg = "CursorLine" },
          activeTabFgColor        = { fg = "@keyword", bold = true },
          inactiveTabBgColor      = { bg = "Normal" },
          inactiveTabFgColor      = { fg = "Comment" },
        },
      },
      scope = { enabled = true },
      scroll = { enabled = false },  -- Disabled to prevent scroll conflicts
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
          bg = "NONE",
        },
        picker = {
          backdrop = false,
          border = "none",
          bg = "NONE",
          wo = {
            winblend = 0,
          },
        },
      }
    })
  end
}
