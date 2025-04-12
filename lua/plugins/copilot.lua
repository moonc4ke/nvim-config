-- GitHub Copilot and CopilotChat plugin configuration

return {
  -- Copilot main plugin
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      "zbirenbaum/copilot-cmp", -- Optional: For completion integration
    },
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          ["."] = false,
        },
      })
      
      -- Keymapping for panel
      vim.keymap.set("n", "<leader>ai", function()
        require("copilot.panel").open()
      end, { desc = "Open Copilot panel" })
    end,
  },
  
  -- CopilotChat plugin
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    cmd = {
      "CopilotChat",
      "CopilotChatToggle", 
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatReset"
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Ask about code" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
    },
    opts = {
      -- See Configuration section for options
    },
  }
} 