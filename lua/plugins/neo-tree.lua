local plugin = {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
}

plugin.config = function()
  require('neo-tree').setup({
    commands = {
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if node:has_children() and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else                           -- if expanded and has children, seleect the next child
            if node.type == "file" then
              state.commands.open(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        else -- if has no children
          state.commands.open(state)
        end
      end,
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local vals = {
          ["BASENAME"] = modify(filename, ":r"),
          ["EXTENSION"] = modify(filename, ":e"),
          ["FILENAME"] = filename,
          -- ["PATH (CWD)"] = modify(filepath, ":."),
          ["PATH (HOME)"] = modify(filepath, ":~"),
          ["PATH"] = filepath,
          ["URI"] = vim.uri_from_fname(filepath),
        }

        local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
        if vim.tbl_isempty(options) then
          vim.notify("No values to copy", vim.log.levels.WARN)
          return
        end
        table.sort(options)
        vim.ui.select(options, {
          prompt = "Choose to copy to clipboard:",
          format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
        }, function(choice)
          local result = vals[choice]
          if result then
            vim.notify(("Copied: `%s`"):format(result))
            vim.fn.setreg("+", result)
          end
        end)
      end,
    },
    bind_to_cwd = true,
    window = {
      position = 'right',
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["[b"] = "prev_source",
        ["]b"] = "next_source",
        ["Y"] = "copy_selector",
        ["h"] = "parent_or_close",
        ["<Left>"] = "parent_or_close",
        ["l"] = "child_or_open",
        ["<Right>"] = "child_or_open",
        ["<C-s>"] = "set_root",
      }
    },
    filesystem = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      -- follow_current_file = {
      --   enabled = true,
      --   leave_dirs_open = false,
      -- }
    },
  })

  local revealCurrentFile = function()
    local cur_file_path = vim.fn.expand('%:p')

    if (cur_file_path == '') then
      vim.notify('Not a file', vim.log.levels.WARN)
      -- reveal_file = vim.fn.getcwd()
    else
      local command = 'Neotree reveal_file=' .. cur_file_path
      print(command)
      vim.api.nvim_exec2(command, {})
    end

    -- require('neo-tree.command').execute({
    --   action = "focus",          -- OPTIONAL, this is the default value
    --   source = "filesystem",     -- OPTIONAL, this is the default value
    --   -- position = "left",         -- OPTIONAL, this is the default value
    --   reveal_file = cur_file_path, -- path to file or folder to reveal
    --   reveal_force_cwd = false,   -- change cwd without asking if needed
    -- })
  end

  vim.keymap.set("n", "<leader>hi", "<cmd>NvimWebDeviconsHiTest<cr>", { desc = "Show icons" })
  vim.keymap.set("n", "<leader>et", "<cmd>Neotree toggle<cr>", { desc = "Neotree toggle" })
  vim.keymap.set("n", "<leader>ef", "<cmd>Neotree focus<cr>", { desc = "Neotree focus" })
  vim.keymap.set("n", "<leader>er", revealCurrentFile, { desc = "Show file in NeoTree" })
end

return plugin
