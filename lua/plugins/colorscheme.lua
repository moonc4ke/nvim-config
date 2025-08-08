-- Colorscheme plugin configuration

return {
  "catppuccin/nvim", 
  name = "catppuccin", 
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = false,
        neotree = true,
        treesitter = true,
        telescope = false,
        which_key = true,
        mason = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        snacks = {
          enabled = true,
        },
      },
    })
    vim.cmd.colorscheme "catppuccin"
    
    -- Additional transparency settings for all plugins
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Main editor transparency
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        
        -- Lualine transparency
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
        
        -- Bufferline transparency
        vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
        
        -- Snacks transparency
        vim.api.nvim_set_hl(0, "SnacksNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksBackdrop", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksWinBar", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksTitle", { bg = "NONE" })
        
        -- Oil transparency
        vim.api.nvim_set_hl(0, "OilNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "OilFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "OilBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "OilFile", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "OilDir", { bg = "NONE" })
        
        -- Which-key transparency
        vim.api.nvim_set_hl(0, "WhichKey", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WhichKeyGroup", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WhichKeyDesc", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WhichKeySeparator", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WhichKeyValue", { bg = "NONE" })
        
        -- LSP/diagnostic transparency
        vim.api.nvim_set_hl(0, "LspInfoBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "NONE" })
        
        -- Force transparency on all floating windows
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "NONE" })
        
        -- Generic transparency overrides
        local transparent_groups = {
          "Floating", "Float", "Border", "Backdrop", "Background", "Normal",
          "Menu", "Popup", "Dialog", "Modal", "Panel", "Window"
        }
        
        for _, group in ipairs(transparent_groups) do
          pcall(vim.api.nvim_set_hl, 0, group, { bg = "NONE" })
        end
      end,
    })
    
    -- Additional timer-based transparency enforcement
    vim.defer_fn(function()
      -- Force transparency again after all plugins have loaded
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
      
      -- Force snacks transparency
      for i = 0, 50 do
        pcall(vim.api.nvim_set_hl, 0, "Snacks" .. i, { bg = "NONE" })
      end
      
      -- Force oil transparency
      for _, group in ipairs({"OilNormal", "OilFloat", "OilBorder", "OilFile", "OilDir"}) do
        pcall(vim.api.nvim_set_hl, 0, group, { bg = "NONE" })
      end
      
      -- Force which-key transparency
      for _, group in ipairs({"WhichKey", "WhichKeyFloat", "WhichKeyBorder", "WhichKeyGroup", "WhichKeyDesc", "WhichKeySeparator", "WhichKeyValue"}) do
        pcall(vim.api.nvim_set_hl, 0, group, { bg = "NONE" })
      end
    end, 1000)
  end
} 
