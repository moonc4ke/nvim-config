return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    require("git-conflict").setup({
      default_mappings = false, -- disable mappings, we'll set our own
      default_commands = true, -- create plugin commands
      disable_diagnostics = false, -- This plugin sets some vim diagnostic config values
      list_opener = 'copen', -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    })

    -- Set up keymaps
    vim.keymap.set('n', '<leader>co', '<Plug>(git-conflict-ours)', { desc = 'Choose ours (current changes)' })
    vim.keymap.set('n', '<leader>ct', '<Plug>(git-conflict-theirs)', { desc = 'Choose theirs (incoming changes)' })
    vim.keymap.set('n', '<leader>cb', '<Plug>(git-conflict-both)', { desc = 'Choose both' })
    vim.keymap.set('n', '<leader>c0', '<Plug>(git-conflict-none)', { desc = 'Choose none' })
    vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Previous conflict' })
    vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Next conflict' })
  end,
}