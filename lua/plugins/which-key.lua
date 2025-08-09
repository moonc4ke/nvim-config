return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "modern",
      delay = 500,
      expand = 1,
      notify = true,
      triggers = {
        { "<auto>", mode = "nxsot" },
      },
      win = {
        border = "none",
        padding = { 1, 2 },
      },
    })

    -- Popular Vim motions and commands help menu
    wk.add({
      {
        "<leader>h",
        function()
          -- Clear command line and display help
          vim.cmd('redraw!')
          
          local help_text = {
            "📖 VIM HELP & COMMANDS",
            "═══════════════════════",
            "",
            "🚀 MOVEMENT:",
            "  h/j/k/l - Arrow keys | w/b/e - Word navigation",
            "  0/$ - Line start/end | gg/G - File top/bottom", 
            "  Ctrl+u/d - Half page up/down | Ctrl+f/b - Full page",
            "",
            "✏️  EDITING:",
            "  i/a - Insert/Append | o/O - New line below/above",
            "  x - Delete char | dd - Delete line | yy - Copy line",
            "  p/P - Paste after/before | u - Undo | Ctrl+r - Redo",
            "",
            "🔍 SEARCH:",
            "  / - Search forward | n/N - Next/previous result",
            "  * - Search word under cursor | :%s/old/new/g - Replace all",
            "",
            "🔧 LSP & DIAGNOSTICS:",
            "  gd - Go to definition | gr - Go to references | K - Hover",
            "  <leader>ca - Code actions | <leader>rn - Rename",
            "  [d/]d - Previous/next diagnostic",
            "",
            "📁 FILES & BUFFERS:",
            "  - - File explorer | :w - Save | :q - Quit",
            "  Shift+H/L - Previous/next buffer | <leader>bd - Delete buffer",
            "",
            "🔭 SNACK:",
            "  <leader>ff - Find files | <leader>fg - Live grep",
            "  <leader>fb - Buffers | <leader>fh - Help tags",
            "",
            "🎯 MULTI-CURSOR:",
            "  <leader>m - Create multi-cursor on word/selection",
            "  MCstart/MCclear - Start/clear multi-cursors",
            "",
            "🔄 SURROUND (quotes/brackets):",
            "  cs\"' - Change \" to ' | cs'( - Change ' to (",
            "  ds\" - Delete quotes | ysiw\" - Add quotes around word",
            "  Visual + S\" - Surround selection with quotes",
            ""
          }
          
          -- Create a new buffer for help display
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, help_text)
          
          -- Create floating window
          local width = 60
          local height = #help_text + 2
          local win = vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = width,
            height = height,
            col = (vim.o.columns - width) / 2,
            row = (vim.o.lines - height) / 2,
            style = 'minimal',
            border = 'rounded',
            title = ' Vim Help ',
            title_pos = 'center'
          })
          
          -- Set buffer options
          vim.api.nvim_buf_set_option(buf, 'modifiable', false)
          vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
          
          -- Close on any key press
          vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '<cmd>close<CR>', {silent = true})
          vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<cmd>close<CR>', {silent = true})
          vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<CR>', {silent = true})
          
          -- Auto-close when focus is lost
          vim.api.nvim_create_autocmd('BufLeave', {
            buffer = buf,
            once = true,
            callback = function()
              if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
              end
            end
          })
        end,
        desc = "Show Vim Help & Commands",
        mode = "n",
      },
    })

    -- Add existing leader key mappings
    wk.add({
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    })
  end,
}
