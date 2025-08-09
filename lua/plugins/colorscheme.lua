return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true, -- let terminal show through
      term_colors = false,
      default_integrations = true,
      integrations = {
        cmp = true,
        treesitter = true,
        which_key = true,
        mason = true,
        neotree = true,
        snacks = { enabled = true },
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
      },

      -- ✅ Do all transparency here so it's applied with the colorscheme
      custom_highlights = function(colors)
        local none = { bg = "NONE" }
        return {
          -- Core
          Normal = none,
          NormalNC = none,
          NormalFloat = none,
          FloatBorder = none,
          SignColumn = none,
          StatusLine = none,
          StatusLineNC = none,

          -- Popups / menus
          Pmenu = none,
          PmenuSel = none,
          PmenuKind = none,
          PmenuExtra = none,
          PmenuBorder = none,

          -- Bufferline
          BufferLineFill = none,
          BufferLineBackground = none,

          -- WhichKey
          WhichKey = none,
          WhichKeyFloat = none,
          WhichKeyBorder = { bg = "NONE", fg = colors.blue },
          WhichKeyGroup = none,
          WhichKeyDesc = none,
          WhichKeySeparator = none,
          WhichKeyValue = none,

          -- LSP info/diagnostics in floats
          LspInfoBorder = none,
          DiagnosticFloatingError = none,
          DiagnosticFloatingWarn = none,
          DiagnosticFloatingInfo = none,
          DiagnosticFloatingHint = none,

          -- Snacks (common groups)
          SnacksNormal = none,
          SnacksBorder = none,
          SnacksFloat = none,
          SnacksBackdrop = none,
          SnacksWinBar = none,
          SnacksTitle = none,

          -- Oil
          OilNormal = none,
          OilFloat = none,
          OilBorder = { bg = "NONE", fg = colors.blue },
          OilFile = none,
          OilDir = none,


          -- Float titles & winbars
          FloatTitle = { bg = "NONE", fg = colors.blue, bold = true },
          WinBar = none,
          OilTitle = none,

          -- Transparent tabline with visible text
          TabLine     = { bg = "NONE", fg = colors.blue },   -- inactive tabs
          TabLineSel  = { bg = "NONE", fg = colors.lavender, bold = true }, -- active tab
          TabLineFill = { bg = "NONE" }, -- empty space in tabline
        }
      end,
    })

    vim.cmd.colorscheme("catppuccin")

    -- Helper to keep any new float windows transparent without a timer
    local function normalize_float_win()
      local cfg = vim.api.nvim_win_get_config(0)
      if cfg and cfg.relative ~= "" then
        -- make the float use Normal for backgrounds and remove blending
        vim.wo.winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder,Normal:Normal"
        vim.wo.winblend = 0
      end
    end

    -- 1) Re-apply links whenever colorscheme changes (no delay needed)
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("TransparencyReload", { clear = true }),
      callback = function()
        -- Link common groups to Normal so they inherit transparency even if a plugin relinks later
        local link = function(from, to)
          pcall(vim.api.nvim_set_hl, 0, from, { link = to })
        end
        link("NormalFloat", "Normal")
        link("Pmenu", "Normal")
        link("SnacksNormal", "Normal")
        link("WhichKeyFloat", "Normal")
        link("OilFloat", "Normal")
      end,
    })

    -- 2) Any time a new window is created or focused, fix floats immediately
    vim.api.nvim_create_autocmd({ "WinNew", "BufWinEnter" }, {
      group = vim.api.nvim_create_augroup("TransparencyFloats", { clear = true }),
      callback = normalize_float_win,
    })

    -- 3) Make completion/doc popups non-blended
    vim.o.pumblend = 0
    vim.o.winblend = 0

    -- 4) Ensure truecolor (helps with transparent terms)
    vim.o.termguicolors = true
  end,
}

