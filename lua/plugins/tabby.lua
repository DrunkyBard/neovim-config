return {
  enabled = true,
  'nanozuki/tabby.nvim',
  config = function()
    require('tabby').setup({
      preset = 'active_wins_at_tail',
      option = {
        theme = {
          fill = 'TabLineFill',       -- tabline background
          head = 'TabLine',           -- head element highlight
          current_tab = 'TabLineSel', -- current tab label highlight
          tab = 'TabLine',            -- other tab label highlight
          win = 'TabLine',            -- window highlight
          tail = 'TabLine',           -- tail element highlight
        },
        nerdfont = true,              -- whether use nerdfont
        lualine_theme = auto,          -- lualine theme name
        buf_name = {
          mode = 'shorten', -- or 'relative', 'tail', 'shorten'
        },
      },
    })
  end
}
