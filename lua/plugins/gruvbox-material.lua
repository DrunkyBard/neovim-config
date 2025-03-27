local plugin = {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_dim_inactive_windows = true
    vim.g.gruvbox_material_background = 'medium' -- hard medium soft
    vim.g.gruvbox_material_foreground = 'material' -- material mix original
    vim.g.gruvbox_material_cursor = 'auto' -- auto red orange yellow greenaqua blue purple    
    vim.cmd.colorscheme('gruvbox-material')
  end
}

return plugin
