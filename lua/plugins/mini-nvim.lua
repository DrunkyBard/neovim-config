local plugin = {
  'echasnovski/mini.nvim',
  version = '*'
}

plugin.config = function()
  local mini = require('mini.misc')
  mini.setup()
  mini.setup_termbg_sync()
end

return plugin
