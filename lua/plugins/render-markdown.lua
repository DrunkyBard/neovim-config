local plugin = {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
}


plugin.config = function()
  local md_plugin = require('render-markdown')

  local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
  vim.api.nvim_set_hl(0, 'CustomMDH1', { bg = normal_hl.fg, fg = normal_hl.bg })

  md_plugin.setup({
    heading = {
      enabled        = true,
      border         = true,
      border_virtual = true,
      width          = 'full',
      left_pad       = 2,
      right_pad      = 4,
      backgrounds    = {
        'CustomMDH1',
        'RenderMarkdownCode',
        'RenderMarkdownH2Bg',
        'RenderMarkdownH3Bg',
        'RenderMarkdownH4Bg',
        'RenderMarkdownH5Bg',
        'RenderMarkdownH6Bg',
      },
      foregrounds    = {
        'CustomMDH1',
        'RenderMarkdownH2',
        'RenderMarkdownH3',
        'RenderMarkdownH4',
        'RenderMarkdownH5',
        'RenderMarkdownH6',
      },
    }
  })

  vim.keymap.set('n', '<leader>mt', function() md_plugin.toggle() end, { desc = 'Toggle markdown render' })
  vim.keymap.set('n', '<leader>mb', function() md_plugin.buf_toggle() end, { desc = 'Toggle buffer markdown render' })
  vim.keymap.set('n', '<leader>mp', function() md_plugin.preview() end, { desc = 'Markdown preview' })
end

return plugin
