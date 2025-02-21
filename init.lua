local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"

-- disabling netrw is advised by nvim-tree plugin (:h nvim-tree-netrw)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd [[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]]

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
