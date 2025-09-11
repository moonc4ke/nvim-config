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
        gitsigns = true,
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
          Normal     = { bg = "NONE", fg = colors.text },
          NormalNC   = { bg = "NONE", fg = colors.text },
          NormalFloat = none,
          FloatBorder    = { bg = "NONE", fg = colors.blue },
          SignColumn = none,
          StatusLine = none,
          StatusLineNC = none,

          -- Popups / menus
          Pmenu = none,
          PmenuSel = none,
          PmenuKind = none,
          PmenuExtra = none,
          PmenuBorder = none,

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

          -- Snacks picker highlights
          SnacksPickerIcon = { fg = colors.overlay1 },
          SnacksPickerIconFile = { fg = colors.overlay1 },
          SnacksPickerIconBuffer = { fg = colors.overlay1 },
          SnacksPickerSpecial = { fg = colors.overlay1 },

          -- Oil
          OilNormal = none,
          OilFloat = none,
          OilBorder = { bg = "NONE", fg = colors.blue },
          OilFile = none,
          OilDir = none,

          -- Float titles & winbars
          FloatTitle = { bg = "NONE", fg = colors.blue },
          WinBar = none,
          OilTitle = none,

          -- Complete bufferline colors: active = blue bg, inactive = transparent
          BufferLineBackground = { bg = "NONE", fg = colors.overlay1 },         -- inactive buffers
          BufferLineBufferSelected = { bg = colors.blue, fg = colors.base },    -- active buffer: blue bg + dark text
          BufferLineBufferVisible = { bg = "NONE", fg = colors.overlay1 },      -- visible buffers (in another window)
          BufferLineModified = { bg = "NONE", fg = colors.overlay1 },           -- inactive modified
          BufferLineModifiedSelected = { bg = colors.blue, fg = colors.base },  -- active modified: blue bg + dark text
          BufferLineModifiedVisible = { bg = "NONE", fg = colors.overlay1 },    -- visible modified
          BufferLineFill = { bg = "NONE" },                                     -- background fill
          BufferLineTab = { bg = "NONE", fg = colors.overlay1 },                -- tabs
          BufferLineTabSelected = { bg = colors.blue, fg = colors.base },       -- selected tab
          BufferLineTabClose = { bg = "NONE", fg = colors.overlay1 },           -- tab close button
          BufferLineSeparator = { bg = "NONE", fg = "NONE" },                   -- separator
          BufferLineSeparatorSelected = { bg = "NONE", fg = "NONE" },           -- selected separator
          BufferLineSeparatorVisible = { bg = "NONE", fg = "NONE" },            -- visible separator
          BufferLineCloseButton = { bg = "NONE", fg = colors.overlay1 },        -- close button
          BufferLineCloseButtonSelected = { bg = colors.blue, fg = colors.base }, -- selected close button
          BufferLineCloseButtonVisible = { bg = "NONE", fg = colors.overlay1 }, -- visible close button

          -- Directory/path highlights for duplicate filenames
          BufferLineNumbers = { bg = "NONE", fg = colors.overlay1 },            -- buffer numbers
          BufferLineNumbersSelected = { bg = colors.blue, fg = colors.base },   -- selected buffer numbers
          BufferLineNumbersVisible = { bg = "NONE", fg = colors.overlay1 },     -- visible buffer numbers
          BufferLineDuplicateSelected = { bg = colors.blue, fg = colors.base }, -- selected duplicate path
          BufferLineDuplicate = { bg = "NONE", fg = colors.overlay1 },          -- inactive duplicate path
          BufferLineDuplicateVisible = { bg = "NONE", fg = colors.overlay1 },   -- visible duplicate path

          -- Windsurf (Codeium) ghost text
          CodeiumSuggestion = { fg = colors.overlay0 },

          -- Lazygit-related highlight groups (make sure fg is set)
          Comment        = { bg = "NONE", fg = colors.overlay1 },
          Function       = { bg = "NONE", fg = colors.blue },
          Identifier     = { bg = "NONE", fg = colors.peach },
          MatchParen     = { bg = "NONE", fg = colors.teal },
          Visual         = { bg = colors.surface0, fg = colors.text },
          CursorLine     = { bg = colors.surface0 },
          ["@keyword"]   = { fg = colors.mauve },
          DiagnosticError = { fg = colors.red },

          -- Git signs + blame
          GitSignsAdd    = { fg = colors.green,  bg = "NONE" },
          GitSignsChange = { fg = colors.peach,  bg = "NONE" },
          GitSignsDelete = { fg = colors.red,    bg = "NONE" },
          GitSignsCurrentLineBlame = { fg = colors.overlay1 }, -- inline blame text

          -- Lazy.nvim highlights
          LazyButton = { bg = colors.surface0, fg = colors.text },
          LazyButtonActive = { bg = colors.surface2, fg = colors.blue, bold = true },
          LazyH1 = { bg = colors.blue, fg = colors.base, bold = true },
          LazySpecial = { fg = colors.blue },
          LazyProgressDone = { fg = colors.green },
          LazyProgressTodo = { fg = colors.overlay0 }
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

