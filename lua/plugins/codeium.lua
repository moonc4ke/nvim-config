return {
  "Exafunction/windsurf.nvim",
  event = "InsertEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("codeium").setup({
      enable_chat = false,         -- disable chat
      enable_cmp_source = false,   -- turn off cmp source (no duplicate AI in popup)
      virtual_text = {
        enabled = true,            -- enable ghost text
        default_filetype_enabled = true, -- enable for all filetypes
        idle_delay = 75,           -- ms after typing stops
        map_keys = true,           -- let Windsurf set its keymaps
        key_bindings = {
          accept = "<Tab>",        -- accept ghost suggestion
          next = "<M-]>",          -- cycle next
          prev = "<M-[>",          -- cycle prev
        },
      },
    })
  end,
}

