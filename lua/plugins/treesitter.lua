-- Treesitter plugin configuration

return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {"lua", "javascript", "ruby", "php", "typescript", "css", "scss", "html", "embedded_template", "json", "tsx", "angular", "vue"},
      highlight = { enable = true },
      indent = { enable = true }
    })
    vim.treesitter.language.register("html", "hbs")
    vim.treesitter.language.register("html", "handlebars")
    
    -- Ensure Vue files are detected properly
    vim.filetype.add({
      extension = {
        vue = "vue",
      },
    })
  end
} 
