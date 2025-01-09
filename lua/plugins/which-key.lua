local plugin = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      --{ "<leader>f", group = "file", icon = '󰈙' }
      --{ "<leader>f", group = "file", icon = { icon = "", color = 'white' } }
    },
    --icons = { mappings = false }
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

return plugin
