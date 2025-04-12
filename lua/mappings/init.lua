-- Keymappings

local M = {}

M.setup = function()
  -- The 'desc' parameter in vim.keymap.set will automatically be used by which-key
  -- to display descriptions in its popup menu - no need to register separately
  
  -- Telescope mappings
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Find files" })
  vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files({
      hidden = true,
      no_ignore = true,
      prompt_title = "All Files"
    })
  end, { desc = "Find all files (including hidden)" })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
  vim.keymap.set('n', '<leader>fs', function()
    builtin.live_grep({
      additional_args = function()
        return {"--fixed-strings"}
      end
    })
  end, { desc = "Search literal strings" })
  vim.keymap.set('n', '<leader>ff', builtin.oldfiles, { desc = "File search history" })
  
  -- Keymap to copy current file's relative path to clipboard
  vim.keymap.set('n', '<leader>cp', function()
    local relative_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
    vim.fn.setreg('+', relative_path)
    print('Copied to clipboard: ' .. relative_path)
  end, { desc = "Copy relative file path" })
  
  -- Add a which-key mapping to show keymaps
  vim.keymap.set('n', '<leader>?', function()
    require('which-key').show('<leader>', {mode = 'n', auto = true})
  end, { desc = "Show all leader keymaps" })
end

return M 