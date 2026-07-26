local plugin = {
  'nvim-mini/mini.nvim',
  version = '*'
}

plugin.config = function()
  local mini = require('mini.misc')
  mini.setup()
  -- mini.setup_termbg_sync()

  require('mini.cursorword').setup()
end

return plugin
