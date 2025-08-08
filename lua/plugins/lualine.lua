-- Lualine status line configuration

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
  config = function()
    local colors = require("catppuccin.palettes").get_palette()
    
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local mode_map = {
                NORMAL = "N",
                INSERT = "I", 
                VISUAL = "V",
                ["V-LINE"] = "VL",
                ["V-BLOCK"] = "VB",
                COMMAND = "C",
                REPLACE = "R",
                TERMINAL = "T",
              }
              return mode_map[str] or str:sub(1,1)
            end,
            padding = { left = 1, right = 1 },
          }
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = colors.lavender },
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 1, -- relative path
            symbols = {
              modified = "●",
              readonly = "",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.blue },
              hint = { fg = colors.teal },
            },
          },
        },
        lualine_y = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            padding = { left = 1, right = 1 },
          },
        },
        lualine_z = {
          {
            "progress",
            padding = { left = 1, right = 0 },
          },
          {
            "location",
            padding = { left = 0, right = 1 },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 
          {
            "filename",
            file_status = true,
            path = 1,
          }
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "oil", "mason", "lazy" },
    })
  end,
}