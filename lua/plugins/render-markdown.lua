local plugin = {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
}


plugin.config = function()
  local md_plugin = require('render-markdown')

  md_plugin.setup({
    heading = {
      enabled        = true,
      border         = true,
      border_virtual = true,
      width          = 'block',
      left_pad       = 2,
      right_pad      = 4,
    }
  })

  vim.keymap.set('n', '<leader>mt', function() md_plugin.toggle() end, { desc = 'Toggle markdown render' })
  vim.keymap.set('n', '<leader>mb', function() md_plugin.buf_toggle() end, { desc = 'Toggle buffer markdown render' })
  vim.keymap.set('n', '<leader>mp', function() md_plugin.preview() end, { desc = 'Markdown preview' })
end

vim.cmd("let t:splitType = 'horizontal'")

return plugin
