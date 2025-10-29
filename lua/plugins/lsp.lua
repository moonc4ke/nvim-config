return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "ts_ls",
        "angularls",
        "vue_ls",
        "html",
        "cssls",
        "tailwindcss",
        "css_variables",
        "eslint",
        "lua_ls",
        "ruby_lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      local util = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure lua_ls using new API
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        single_file_support = false,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
      vim.lsp.enable("lua_ls")

      -- Configure ts_ls for Vue projects
      local cwd = vim.loop.cwd()
      local is_vue = util.root_pattern(
        "nuxt.config.ts", "nuxt.config.js",
        "vite.config.ts", "vite.config.js",
        "vue.config.ts", "vue.config.js"
      )(cwd) ~= nil
      if is_vue then
        vim.lsp.config("ts_ls", {
          capabilities = capabilities,
          single_file_support = false,
          root_dir = function(fname)
            return util.root_pattern(
              "nuxt.config.ts", "nuxt.config.js",
              "vite.config.ts", "vite.config.js",
              "vue.config.ts", "vue.config.js"
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
        vim.lsp.enable("ts_ls")
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

      -- Global default border for any LSP-related floating window
      local _bordered_float = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return _bordered_float(contents, syntax, opts, ...)
      end

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

