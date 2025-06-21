local plugin = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-dap.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'folke/trouble.nvim',
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
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

  local trouble = require('trouble')
  trouble.setup()

  local open_in_trouble = require("trouble.sources.telescope").open
  -- local action_state = require('telescope.actions.state')
  -- local actions = require("telescope.actions")
  -- local transform_mod = require("telescope.actions.mt").transform_mod
  -- local custom_actions = transform_mod({
  --   open_trouble_qflist = function(buf)
  --     trouble.focus("quickfix")
  --   end,
  -- })
  -- local deleteBuf = function(buffer)
  --   local selection = action_state.get_current_selection()
  --   vim.api.nvim_buf_delete(selection.bufnr, { force = false })
  -- end

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
          ["<C-h>"] = open_in_trouble,
          -- ["d"] = deleteBuf,
        },
        i = {
          ["<C-h>"] = open_in_trouble,
        }
      },
      layout_strategy = "horizontal",
      layout_config = {
          horizontal = {
            width = { padding = 0 },
            height = { padding = 0 },
            preview_width = 0.6,
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
