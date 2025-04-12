-- Treesitter plugin configuration

return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {"lua", "javascript", "ruby", "php", "typescript", "css", "scss", "html", "embedded_template"},
      highlight = { enable = true },
      indent = { enable = true }
    })
    vim.treesitter.language.register("html", "hbs")
    vim.treesitter.language.register("html", "handlebars")
  end
} 
