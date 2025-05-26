local plugin = {
  'mbbill/undotree',
  config = function()
    if vim.fn.has('macunix') == 0 and vim.fn.has('unix') == 0 then
      vim.g.undotree_DiffCommand = "FC"
    end

    vim.keymap.set('n', '<leader>ou', vim.cmd.UndotreeToggle, { desc = 'UndoTree' })
  end
}

return plugin
