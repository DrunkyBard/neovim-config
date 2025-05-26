local plugin = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

plugin.config = function()
  local wk = require('which-key')
  wk.setup({
    win = {
      border = 'double',
      title = false,
      no_overlap = true,
      padding = { 0, 0 },
    },
  })

  wk.add({
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    }
  })

  -- vim.api.nvim_set_hl(0, 'WhichKeyNormal', { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, 'WhichKeyBorder', { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, 'WhichKeyDesc', { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, 'WhichKeyGroup', { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, 'WhichKeyValue', { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, 'WhichKeySeparator', { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, 'WhichKeyTitle', { link = 'Normal' })
end

return plugin

