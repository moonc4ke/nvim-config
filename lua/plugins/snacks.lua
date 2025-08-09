-- Snacks.nvim plugin configuration

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("snacks").setup({
      -- Enable all modules
      picker = { enabled = true },
      dashboard = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      bigfile = { enabled = true },
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
        },
      },
      scope = { enabled = true },
      scroll = { enabled = true },
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
    
    -- Key mappings for snacks picker (replacing telescope)
    vim.keymap.set("n", "<leader>ff", function() require("snacks").picker.files() end, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", function() require("snacks").picker.grep() end, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", function() require("snacks").picker.buffers() end, { desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fh", function() require("snacks").picker.help() end, { desc = "Find help" })
    vim.keymap.set("n", "<leader>fr", function() require("snacks").picker.recent() end, { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fc", function() require("snacks").picker.commands() end, { desc = "Commands" })
  end
}