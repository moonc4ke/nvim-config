return {
  "echasnovski/mini.statusline",
  version = "*",
  config = function()
    local statusline = require("mini.statusline")

    statusline.setup({
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })

          -- Custom git branch display
          local git_info = ""
          local git_head = vim.b.gitsigns_head or vim.g.gitsigns_head

          -- Ensure git_head is a string, not a table
          if git_head and type(git_head) == "string" then
            git_info = " " .. git_head
          elseif not git_head then
            -- Fallback to git command
            local handle = io.popen("git branch --show-current 2>/dev/null")
            if handle then
              local branch = handle:read("*l")
              handle:close()
              if branch and branch ~= "" then
                git_info = " " .. branch
              end
            end
          end

          -- Custom diagnostics without git diff info
          local diagnostics = ""
          local diag_counts = vim.diagnostic.count(0)
          if diag_counts[vim.diagnostic.severity.ERROR] and diag_counts[vim.diagnostic.severity.ERROR] > 0 then
            diagnostics = diagnostics .. " E" .. diag_counts[vim.diagnostic.severity.ERROR]
          end
          if diag_counts[vim.diagnostic.severity.WARN] and diag_counts[vim.diagnostic.severity.WARN] > 0 then
            diagnostics = diagnostics .. " W" .. diag_counts[vim.diagnostic.severity.WARN]
          end
          local filename = statusline.section_filename({ trunc_width = 140 })
          local location = "%l:%c"  -- Just line:column
          local progress = "%2p%%"  -- Just percentage

          return statusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineGit", strings = { git_info } },
            { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
            "%<", -- Mark general truncate point  
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { location, progress } },
          })
        end,
        inactive = function()
          local filename = statusline.section_filename({ trunc_width = 140 })
          return statusline.combine_groups({
            { hl = "MiniStatuslineInactive", strings = { filename } },
          })
        end,
      },
      use_icons = true,
      set_vim_settings = true,
    })

    -- Apply catppuccin integration
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "catppuccin*",
      callback = function()
        local colors = require("catppuccin.palettes").get_palette()
        -- Mode colors
        vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { bg = colors.blue, fg = colors.base, bold = true })
        vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { bg = colors.green, fg = colors.base, bold = true })
        vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { bg = colors.mauve, fg = colors.base, bold = true })
        vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { bg = colors.red, fg = colors.base, bold = true })
        vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { bg = colors.peach, fg = colors.base, bold = true })
        vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { bg = colors.teal, fg = colors.base, bold = true })
        -- Section backgrounds with better colors
        vim.api.nvim_set_hl(0, "MiniStatuslineGit", { bg = colors.green, fg = colors.base, bold = true })  -- Green for git branch
        vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { bg = colors.mauve, fg = colors.base })
        vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "NONE", fg = colors.text }) -- Transparent background
        vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { bg = colors.blue, fg = colors.base, bold = true }) -- Blue background with base text
        vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = "NONE", fg = colors.overlay1 }) -- Transparent background
      end,
    })

    -- Apply colors immediately if catppuccin is already loaded
    if vim.g.colors_name and vim.g.colors_name:match("catppuccin") then
      vim.cmd("doautocmd ColorScheme catppuccin")
    end

    -- Ensure statusline appears when opening files from external sources (like lazygit)
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TermClose" }, {
      group = vim.api.nvim_create_augroup("MiniStatuslineRefresh", { clear = true }),
      callback = function()
        -- Force statusline to be visible and redraw
        vim.opt.laststatus = 2
        vim.cmd("redrawstatus")
      end,
    })
  end,
}
