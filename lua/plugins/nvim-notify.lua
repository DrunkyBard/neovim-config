local plugin = {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require('notify')
    notify.setup({
      stages = "fade",
      top_down = false,
      timeout = 1000,
      level = 3,
    })
    vim.notify = notify

    vim.keymap.set('n', '<leader>fn', ':Telescope notify<cr>', { desc = 'Notifications' })
    vim.keymap.set('n', '<leader>nc', ':NotificationsClear<cr>', { desc = 'Clear notifications' })
  end
}

return plugin
