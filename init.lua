-- Neovim configuration entry point
-- Organized following the single responsibility principle

-- Disable Ruby provider to avoid warning
vim.g.loaded_ruby_provider = 0

-- Set Node.js provider to use npm instead of pnpm
vim.g.node_host_prog = '/home/kami/.asdf/installs/nodejs/20.18.0/lib/node_modules/neovim/bin/cli.js'

-- Load Lua paths for magick
require('core.magick_path')

-- Load core options
require('core.options')

-- Set up plugin manager
require('core.lazy').setup()

-- Load key mappings
require('mappings').setup()
