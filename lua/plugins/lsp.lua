return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({ PATH = "prepend" })
    end,
  },

  -- Angular: use handlers (includes ts_ls for Angular only)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      local lspconfig   = require("lspconfig")
      local util        = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function is_angular_workspace()
        local cwd = vim.loop.cwd()
        return util.root_pattern("angular.json", "nx.json", "tsconfig.base.json")(cwd) ~= nil
      end
      local IS_ANGULAR = is_angular_workspace()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "angularls",
          "vue_ls",
          "html",
          "cssls",
          "eslint",
          "lua_ls",
        },
        automatic_installation = true,
        handlers = {
          -- default handler for all other servers
          function(server_name)
            if server_name == "ts_ls" then return end -- we special-case below
            if server_name == "angularls" then
              if not IS_ANGULAR then return end
              lspconfig.angularls.setup({
                capabilities = capabilities,
                root_dir = function(fname)
                  local angular_root = util.root_pattern("angular.json", "nx.json", "tsconfig.base.json")(fname)
                  local vue_root = util.root_pattern("vue.config.js", "vite.config.ts", "vite.config.js", "nuxt.config.ts", "nuxt.config.js")(fname)
                  if vue_root then return nil end -- Never attach to Vue projects
                  return angular_root
                end,
                filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" }, -- Exclude .vue
              })
              return
            end
            if server_name == "vue_ls" then
              lspconfig.vue_ls.setup({
                capabilities = capabilities,
                filetypes = { "vue" },
                root_dir = function(fname)
                  return util.root_pattern("vue.config.js", "vite.config.ts", "vite.config.js")(fname)
                end,
              })
              return
            end
            lspconfig[server_name].setup({ capabilities = capabilities })
          end,

          -- Angular-only tsserver (configured here, per your constraint)
          ts_ls = function()
            if not IS_ANGULAR then return end
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              -- strict Angular/Nx root to avoid nested clients
              root_dir = function(fname)
                return util.root_pattern("angular.json", "nx.json", "tsconfig.base.json")(fname)
                    or util.find_git_ancestor(fname)
              end,
              -- no .vue here — Angular templates handled by angularls
              filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
              settings = { typescript = { preferences = { disableSuggestions = false } } },
            })
          end,
        },
      })
    end,
  },

  -- Vue: configure ts_ls with @vue/typescript-plugin here (not in handlers)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      local lspconfig   = require("lspconfig")
      local util        = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function is_vue_workspace()
        local cwd = vim.loop.cwd()
        return util.root_pattern(
          "nuxt.config.ts","nuxt.config.js",
          "vite.config.ts","vite.config.js",
          "vue.config.js"
        )(cwd) ~= nil
      end
      local IS_VUE = is_vue_workspace()

      -- Vue tsserver (with Volar TS plugin). Only runs in Vue workspaces.
      if IS_VUE then
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
          root_dir = function(fname)
            return util.root_pattern(
              "nuxt.config.ts","nuxt.config.js",
              "vite.config.ts","vite.config.js",
              "vue.config.js"
            )(fname) or util.find_git_ancestor(fname)
          end,
          filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = vim.fn.stdpath("data")
                  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
              },
            },
          },
          settings = { typescript = { preferences = { disableSuggestions = false } } },
        })
      end

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "always", header = "", prefix = "" },
      })

      -- Keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set("n", "K",  vim.lsp.buf.hover,      { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,     { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
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
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, { { name = "buffer" } }),
      })
      cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
}

