-- Matching tag highlighting

return {
  "andymass/vim-matchup",
  config = function()
    -- Enable matching for HTML/XML tags
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_hi_surround_always = 1
    
    -- Show tag path in status line
    vim.g.matchup_matchparen_status_offscreen = 1
    
    -- Enable for specific filetypes
    vim.g.matchup_matchparen_enabled = 1
    vim.g.matchup_motion_enabled = 1
    vim.g.matchup_text_obj_enabled = 1
    
    -- Custom highlighting colors
    vim.api.nvim_set_hl(0, "MatchParen", { bg = "#45475a", bold = true })
    vim.api.nvim_set_hl(0, "MatchWord", { bg = "#313244", underline = true })
    vim.api.nvim_set_hl(0, "MatchParenCur", { bg = "#585b70", bold = true })
  end,
}