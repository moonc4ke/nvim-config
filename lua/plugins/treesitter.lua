-- Treesitter plugin configuration

return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    -- Suppress tree-sitter CLI warning
    require("nvim-treesitter.install").prefer_git = false
    
    require("nvim-treesitter.configs").setup({
      ensure_installed = {"lua", "javascript", "ruby", "php", "typescript", "css", "scss", "html", "embedded_template", "json", "tsx", "angular"},
      highlight = { enable = true },
      indent = { enable = true }
    })
    vim.treesitter.language.register("html", "hbs")
    vim.treesitter.language.register("html", "handlebars")
  end
} 
