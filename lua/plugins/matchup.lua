return {
  "andymass/vim-matchup",
  config = function()
    -- Enable matching for HTML/XML tags
    vim.g.matchup_matchparen_offscreen = {
      method = "popup"
    }
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_hi_surround_always = 1

    -- Show tag path in status line (optional context info)
    vim.g.matchup_matchparen_status_offscreen = 1

    -- Enable for specific filetypes
    vim.g.matchup_matchparen_enabled = 1
    vim.g.matchup_motion_enabled = 1
    vim.g.matchup_text_obj_enabled = 1
  end,
}
