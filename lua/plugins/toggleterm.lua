local plugin = {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup({
      -- shade_terminals = false
    })

    vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical size=70<cr>', { desc = 'Toggle terminal vertical split' })
    vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<cr>', { desc = 'Toggle terminal horizontal split' })
    vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<cr>', { desc = 'Toggle floating terminal' })
  end
}

return plugin
