-- Neovim configuration entry point
-- Organized following the single responsibility principle

-- Load core options
require('core.options')

-- Set up plugin manager
require('core.lazy').setup()

-- Load key mappings
require('mappings').setup() 
