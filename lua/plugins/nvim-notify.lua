local plugin = {
  'rcarriga/nvim-notify',
  config = function() 
    local notify = require('notify')
    notify.setup({
      stages = "fade",
      top_down = false
    })
    vim.notify = notify

    vim.keymap.set('n', '<leader>fn', ':Telescope notify<cr>', { desc = 'Notifications' })
  end
}

return plugin
