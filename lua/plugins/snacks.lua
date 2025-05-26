local plugin = {
  'folke/snacks.nvim',
  enabled = true,
  opts = {}
}

plugin.config = function()
end

plugin.opts.picker = {
  enabled = true,
  win = {
    input = {
      keys = {
      }
    }
  }
}

return plugin
