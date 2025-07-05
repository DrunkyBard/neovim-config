return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  enabled = false,
  lazy = false,
  git = { enable = false },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function change_root_to_global_cwd()
      local api = require("nvim-tree.api")
      local global_cwd = vim.fn.getcwd(-1, -1)
      api.tree.change_root(global_cwd)
    end

    local function change_root_and_update_nvtree(cmd)
      vim.cmd('cd ' .. cmd.args)
      change_root_to_global_cwd()
    end

    require("nvim-tree").setup({
      git = {
        enable = false,
        show_on_dirs = false,
      },
      view = {
        side = "right",
        width = 50,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function edit_or_open()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            api.node.open.edit()
          else
            api.node.open.edit()
          end
        end

        -- open as vsplit on current node
        local function vsplit_preview()
          local node = api.tree.get_node_under_cursor()
          api.node.open.edit()

          -- if node.nodes ~= nil then
          --   -- expand or collapse folder
          --   api.node.open.edit()
          -- else
          --   -- open file as vsplit
          --   api.node.open.vertical()
          -- end

          api.tree.focus()
        end

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.events.subscribe(api.events.Event.FileCreated, function(file)
          vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
        end)

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
        vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open vertical"))
        vim.keymap.set("n", "S", api.node.open.horizontal, opts("Open horizontal"))
        vim.keymap.set("n", "<C-f>", api.tree.search_node, opts("Open horizontal"))
        vim.keymap.set("n", "h", api.tree.collapse_all, opts("Collapse All"))
        vim.keymap.set("n", "<C-M-h>", change_root_to_global_cwd, opts("Set NVimTree to cwd"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      end
    })

    vim.keymap.set('n', '<leader>et', ':NvimTreeToggle<CR>', { desc = 'Toggle NVimTree' })
    vim.keymap.set('n', '<leader>ef', ':NvimTreeFocus<CR>', { desc = 'Focus NVimTree' })
    vim.keymap.set('n', '<leader>er', ':NvimTreeFindFile<CR>', { desc = 'Find in NVimTree' })

    vim.api.nvim_create_user_command(
      'Nvcd',
      change_root_and_update_nvtree,
      {
        desc = 'Change CWD and updates Nvim-tree to the new CWD',
        nargs = '?' -- idk why '1' doesn't work
      })
  end,
}
