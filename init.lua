local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"

-- disabling netrw is advised by nvim-tree plugin (:h nvim-tree-netrw)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd.source(vimrc)
vim.hl = vim.highlight -- https://github.com/neovim/neovim/issues/31675

require("config.lazy")
require("remap")

vim.filetype.add({
  extension = {
    xaml = "xml",
  },
})

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
}
