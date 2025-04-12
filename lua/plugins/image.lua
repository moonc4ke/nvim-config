-- Image.nvim plugin configuration

return {
  "3rd/image.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local status, image = pcall(require, "image")
        if status and image then
          image.setup({
            backend = "kitty",
            kitty_method = "normal",
            render_in_place = false,  -- Prevents overlapping with other UI elements
            window_overlap_clear_enabled = true,  -- Clear images when windows change
            editor_only_render_when_focused = true,  -- Only render when window is focused
          })
        end
      end,
    })
  end
} 