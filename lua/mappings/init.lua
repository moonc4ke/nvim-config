-- Keymappings

local M = {}

M.setup = function()
  -- The 'desc' parameter in vim.keymap.set will automatically be used by which-key
  -- to display descriptions in its popup menu - no need to register separately
  
  -- Snacks picker mappings (replacing telescope)
  vim.keymap.set('n', '<C-p>', function() require("snacks").picker.files() end, { desc = "Find files" })
  vim.keymap.set('n', '<leader>fa', function() 
    require("snacks").picker.files({ hidden = true }) 
  end, { desc = "Find all files (including hidden)" })
  vim.keymap.set('n', '<leader>fg', function() require("snacks").picker.grep() end, { desc = "Live grep" })
  vim.keymap.set('n', '<leader>fs', function() 
    require("snacks").picker.grep({ fixed_strings = true }) 
  end, { desc = "Search literal strings" })
  vim.keymap.set('n', '<leader>ff', function() require("snacks").picker.recent() end, { desc = "File search history" })
  
  -- Keymap to copy current file's relative path to clipboard
  vim.keymap.set('n', '<leader>cp', function()
    local relative_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
    vim.fn.setreg('+', relative_path)
    print('Copied to clipboard: ' .. relative_path)
  end, { desc = "Copy relative file path" })
  
  -- Zen Mode toggle
  vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { desc = "Toggle Zen Mode" })
  
  -- Buffer navigation
  vim.keymap.set('n', '<leader>bh', ':bprevious<CR>', { desc = "Previous buffer" })
  vim.keymap.set('n', '<leader>bl', ':bnext<CR>', { desc = "Next buffer" })
  vim.keymap.set('n', '<leader>bb', function() require("snacks").picker.buffers() end, { desc = "List buffers" })
  
  -- Diagnostic navigation and display
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
  vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = "Show line diagnostics" })
  vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = "Open diagnostics quickfix list" })
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open diagnostics location list" })
  vim.keymap.set('n', '<leader>da', function() 
    vim.diagnostic.config({
      virtual_text = not vim.diagnostic.config().virtual_text 
    })
    print("Diagnostic virtual text toggled")
  end, { desc = "Toggle diagnostic virtual text" })
  
  -- LSP error messages and logs
  vim.keymap.set('n', '<leader>le', ':LspInfo<CR>', { desc = "LSP Info" })
  vim.keymap.set('n', '<leader>ll', ':LspLog<CR>', { desc = "LSP Log" })
  vim.keymap.set('n', '<leader>lr', ':LspRestart<CR>', { desc = "LSP Restart" })
  vim.keymap.set('n', '<leader>ls', ':LspStart<CR>', { desc = "LSP Start" })
  vim.keymap.set('n', '<leader>lx', ':LspStop<CR>', { desc = "LSP Stop" })
end

return M 