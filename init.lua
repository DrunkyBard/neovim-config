local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
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
