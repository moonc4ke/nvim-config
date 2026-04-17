return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "lua", "javascript", "ruby", "php", "typescript", "css", "scss",
      "html", "embedded_template", "json", "tsx", "angular", "latex",
      "svelte", "typst", "regex", "vue", "bash",
      "markdown", "markdown_inline",
    }

    local installed = require("nvim-treesitter.config").get_installed()
    local to_install = vim.tbl_filter(function(lang)
      return not vim.tbl_contains(installed, lang)
    end, ensure_installed)

    if #to_install > 0 then
      require("nvim-treesitter.install").install(to_install)
    end

    -- Enable treesitter highlighting for all buffers with a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    vim.treesitter.language.register("html", "hbs")
    vim.treesitter.language.register("html", "handlebars")
  end
}
