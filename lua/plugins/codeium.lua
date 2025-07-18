-- Codeium AI code completion plugin

return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      -- Enable codeium in all filetypes
      enable_chat = true,
      -- Key mappings
      config_path = vim.fn.stdpath("config") .. "/codeium/config.json",
      bin_path = vim.fn.stdpath("cache") .. "/codeium/bin",
      api = {
        host = "server.codeium.com",
        port = 443,
      },
    })

    -- Key mappings for Codeium
    vim.keymap.set('i', '<Tab>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })

    vim.keymap.set('i', '<C-;>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true, desc = "Next Codeium suggestion" })

    vim.keymap.set('i', '<C-,>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })

    vim.keymap.set('i', '<C-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })

    vim.keymap.set('n', '<leader>cd', function()
      return vim.fn['codeium#Chat']()
    end, { expr = true, silent = true, desc = "Open Codeium Chat" })

    -- Codeium status in statusline
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_enabled = true
  end,
}