return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {"lua", "javascript", "ruby", "php", "typescript", "css", "scss", "html", "embedded_template", "json", "tsx", "angular", "latex", "norg", "svelte", "typst", "regex"},
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
      auto_install = true,
      matchup = {
        enable = true, -- Enable vim-matchup integration
      },
    })

    vim.treesitter.language.register("html", "hbs")
    vim.treesitter.language.register("html", "handlebars")
  end
}
