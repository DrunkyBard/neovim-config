local alpha_c = function()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  local image = require('alpha-images/choose-starter-image').choose_starter_image()

  dashboard.section.header.val = image.header
  dashboard.section.header.opts = { position = "center", hl = image.hl }

  dashboard.section.buttons.val = {
    dashboard.button("SPC e e", "  New file", "<Cmd>ene <CR>"),
    dashboard.button("SPC f f", "  Find file"),
    dashboard.button("SPC S l", "  Load session"),
    dashboard.button("SPC q q", "  Quit", "<Cmd>qa<CR>"),
  }
  for _, a in ipairs(dashboard.section.buttons.val) do
    a.opts.width = 49
    a.opts.cursor = -2
  end

  alpha.setup(dashboard.config)
end

return {
  'goolord/alpha-nvim',
  dependencies = {
    "catppuccin/nvim"
  },
  config = function()
    local dashboard = require('alpha.themes.dashboard')

    require('alpha').setup(dashboard.config)

    alpha_c()
  end
}
