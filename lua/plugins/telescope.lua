local plugin = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-dap.nvim',
    'nvim-treesitter/nvim-treesitter'
  }
}

plugin.config = function(buf, opts)
  local telescope_builtin = require('telescope.builtin')
  local telescope_actions = require('telescope.actions')

  vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = " Find files" })
  vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Grep" })
  vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Help" })
  vim.keymap.set("n", "<leader>fk", ':Telescope keymaps<cr>', { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols, { desc = "Document symbols" })
  --vim.keymap.set("n", "<leader>fq", telescope_actions.which_key)

  vim.keymap.set("n", "<leader>dc", ":Telescope dap commands<cr>", { desc = "DAP commands" })
  vim.keymap.set("n", "<leader>ds", ":Telescope dap configurations<cr>", { desc = "DAP configurations" })
  vim.keymap.set("n", "<leader>dc", ":Telescope dap list_breakpoints<cr>", { desc = "DAP breakpoints" })
  vim.keymap.set("n", "<leader>dv", ":Telescope dap variables<cr>", { desc = "DAP variables" })
  vim.keymap.set("n", "<leader>df", ":Telescope dap frames<cr>", { desc = "DAP frames" })

  local open_in_trouble = require("trouble.sources.telescope").open
  local action_state = require('telescope.actions.state')
  local actions = require("telescope.actions")
  local trouble = require("trouble")
  local transform_mod = require("telescope.actions.mt").transform_mod
  local custom_actions = transform_mod({
    open_trouble_qflist = function(buf)
      trouble.focus("quickfix")
    end,
  })
  local deleteBuf = function(buffer)
    local selection = action_state.get_current_selection()
    vim.api.nvim_buf_delete(selection.bufnr, { force = false })
  end

  local telescope = require('telescope')
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        -- "--smart-case",
        "--ignore-case"
      },
      mappings = {
        n = {
          ["<M-t>"] = open_in_trouble,
          ["s"] = "select_vertical",
          ["S"] = "select_horizontal",
          -- ["d"] = deleteBuf,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true
      },
      live_grep = {
        additional_args = { '--hidden' }
      },
      grep_string = {
        additional_args = { '--hidden' }
      }
    }
  })
  telescope.load_extension('dap')
end

return plugin
