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
    require("snacks").picker.grep({ args = { "--fixed-strings" } })
  end, { desc = "Search literal strings" })

  -- Keymap to copy current file's relative path to clipboard
  vim.keymap.set('n', '<leader>cp', function()
    local relative_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
    vim.fn.setreg('+', relative_path)
    print('Copied to clipboard: ' .. relative_path)
  end, { desc = "Copy relative file path" })


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
  vim.keymap.set('n', '<leader>lc', function()
    vim.fn.system('rm -f ~/.cache/nvim/lsp.log ~/.local/state/nvim/lsp.log ~/.local/share/nvim/lsp.log')
    print("LSP log files cleared")
  end, { desc = "Clear LSP Log" })
  vim.keymap.set('n', '<leader>lr', ':LspRestart<CR>', { desc = "LSP Restart" })
  vim.keymap.set('n', '<leader>ls', ':LspStart<CR>', { desc = "LSP Start" })
  vim.keymap.set('n', '<leader>lx', ':LspStop<CR>', { desc = "LSP Stop" })

  -- Git/Lazygit
  vim.keymap.set('n', '<leader>gg', function() require("snacks").lazygit() end, { desc = "Lazygit" })


  -- Floating window helper for messages
  local function open_messages_floating()
    local ok, result = pcall(vim.api.nvim_exec2, "messages", { output = true })
    if not ok then
      vim.notify("Error getting messages: " .. result, vim.log.levels.ERROR)
      return
    end

    local messages = vim.split(result.output or "", "\n")

    if #messages == 0 or (messages[1] == "" and #messages == 1) then
      vim.notify("No messages", vim.log.levels.INFO)
      return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, messages)
    vim.bo[buf].modifiable = false
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.5)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
      title = "Messages",
      title_pos = "center",
    })

    -- Add key mappings to close the window
    vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
    vim.keymap.set('n', '<Esc>', function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
  end

  -- Diagnostics / Debugging: Messages popup
  vim.keymap.set('n', '<leader>dm', open_messages_floating, { desc = "Show :messages in popup" })
end

return M
