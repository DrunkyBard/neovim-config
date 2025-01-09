return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    local highlight = {
      "CursorColumn",
      "Whitespace",
    }

    local ibl = require('ibl')
    ibl.setup({
      indent = { highlight = highlight, char = "" },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = { enabled = false },
    });
    ibl.update { enabled = false }

    vim.keymap.set('n', '<leader>ci', ':IBLToggle<cr>', { desc = "Toggle line guides" })
  end
}
