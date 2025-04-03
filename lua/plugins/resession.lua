local plugin = {
  {
    'stevearc/resession.nvim',
    dependencies = {
      { 'scottmckendry/telescope-resession.nvim' }
    },
    opts = {},

    config = function(_, opts)
      local resession = require('resession')
      local telescope = require('telescope')
      resession.setup({
        autosave = {
          enabled = true,
          interval = 60,
          notify = false
        }
      })

      vim.keymap.set("n", "<leader><S-s>s", resession.save, { desc="Save session" })
      vim.keymap.set("n", "<leader><S-s>l", telescope.extensions.resession.resession, { desc="Load session" })
      vim.keymap.set("n", "<leader><S-s>d", resession.delete, { desc="Delete session" })
      --vim.keymap.set("n", "<leader><S-s>i", resession.list{ desc="List session" })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          -- Always save a special session named "lastsession"
          resession.save(vim.fn.getcwd(), { dir = "lastsession", notify = false })
        end,
      })
    end
  },
  {
    'scottmckendry/telescope-resession.nvim',
    dependencies = {
      {'nvim-telescope/telescope.nvim'}
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          resession = {
            prompt_title = "Find sessions. <C-d> to delete.",
            dir = "session"
          }
        }
      })
    end
  }
}


return plugin
