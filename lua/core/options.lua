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

vim.opt.termguicolors = true  -- Enable true color support
vim.opt.laststatus = 2  -- Always show statusline
vim.opt.ruler = false  -- Disable built-in ruler since we show it in statusline

-- Enable tabline for bufferline plugin
vim.opt.showtabline = 2

-- Function to toggle bufferline visibility
function _G.toggle_bufferline()
  if vim.o.showtabline == 0 then
    vim.o.showtabline = 2
    print("Bufferline shown")
  else
    vim.o.showtabline = 0
    print("Bufferline hidden")
  end
end

-- Keymap to toggle bufferline
vim.keymap.set('n', '<leader>bt', toggle_bufferline, { desc = 'Toggle Bufferline' })

-- Smooth scrolling and performance settings
vim.opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns visible left/right of cursor
vim.opt.smoothscroll = true   -- Enable smooth scrolling (Neovim 0.10+)
vim.opt.lazyredraw = false    -- Don't redraw while executing macros
vim.opt.redrawtime = 1500     -- Time in milliseconds for redrawing
vim.opt.updatetime = 250      -- Faster completion
vim.opt.timeoutlen = 300      -- Time to wait for mapped sequence
vim.opt.ttimeoutlen = 5       -- Time to wait for key codes
vim.opt.ttyfast = true        -- Faster terminal connection

