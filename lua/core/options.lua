-- Core Neovim settings

-- Set clipboard to use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Configure provider priorities for Wayland
vim.g.clipboard = {
  name = 'WL-Clipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste',
    ['*'] = 'wl-paste',
  },
  cache_enabled = 1,
}

-- Make sure clipboard functionality works properly
vim.api.nvim_create_autocmd('VimLeave', {
  pattern = '*',
  callback = function()
    vim.cmd('sleep 10m')  -- Small delay to ensure clipboard contents are saved
  end
})

-- Tab and indentation settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set leader key
vim.g.mapleader = " "

-- Filetype detection for handlebars files
vim.filetype.add({
  extension = {
    handlebars = "handlebars",
    hbs = "handlebars",
  },
})

-- Add handlebars file pattern matching
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.handlebars", "*.hbs"},
  callback = function()
    vim.bo.filetype = "handlebars"
  end,
}) 