-- LSP Configuration

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend",
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      -- Initialize capabilities once at the top
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",        -- TypeScript/JavaScript LSP
          "angularls",    -- Angular Language Service
          "vue_ls",       -- Vue.js Language Server
          "html",         -- HTML LSP
          "cssls",        -- CSS LSP
          "eslint",       -- ESLint LSP
          "lua_ls",       -- Lua LSP
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          -- Custom TypeScript/JavaScript LSP with Vue support
          ts_ls = function()
            require("lspconfig").ts_ls.setup({
              capabilities = capabilities,
              filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
              init_options = {
                plugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                    languages = { "vue" },
                  }
                }
              },
              settings = {
                typescript = {
                  preferences = {
                    disableSuggestions = false,
                  },
                },
              },
            })
          end,
        }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      -- Configure diagnostics to always show virtual text
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      -- Key mappings for LSP
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>']    = cmp.mapping.scroll_docs(-4),
          ['<C-f>']    = cmp.mapping.scroll_docs(4),
          ['<C-Space>']= cmp.mapping.complete(),
          ['<C-e>']    = cmp.mapping.abort(),
          ['<CR>']     = cmp.mapping.confirm({ select = true }),
          -- no <Tab>/<S-Tab> here → leaves <Tab> for Windsurf inline accept
          ['<C-n>']    = cmp.mapping.select_next_item(),
          ['<C-p>']    = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
      })

      -- optional: cmdline completion
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
      })
    end,
  },
}
