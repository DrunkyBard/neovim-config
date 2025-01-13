vim.g.mapleader = " "

--vim.keymap.set({'i', 'v'}, 'jk', '<esc>', { desc = 'to normal mode' })
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

vim.keymap.set('n', '<C-j>', 'j<C-e>', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-k>', 'k<C-y>', { desc = 'Clear selection' })

vim.keymap.set('n', '<C-S-M-Left>', ':vertical resize -2<cr>', { desc = 'Vertical left border resize' })
vim.keymap.set('n', '<C-S-M-Right>', ':vertical resize +2<cr>', { desc = 'Vertical right border resize' })
vim.keymap.set('n', '<C-S-M-Up>', ':resize -2<cr>', { desc = 'Vertical top border resize' })
vim.keymap.set('n', '<C-S-M-Down>', ':resize +2<cr>', { desc = 'Vertical bottom border resize' })

vim.keymap.set('n', '<C-h>', '<cmd>noh<cr>', { desc = 'Clear selection' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('v', '<S-k>', ':m \'>-2<cr>gv=gv', { desc = 'Clear selection' })
vim.keymap.set('v', '<S-j>', ':m \'>+1<cr>gv=gv', { desc = 'Clear selection' })

vim.keymap.set('n', '<C-M-left>', '<C-w>h', { desc = 'Select left window' })
vim.keymap.set('n', '<C-M-h>', '<C-w>h', { desc = 'Select left window' })
vim.keymap.set('n', '<C-M-right>', '<C-w>l', { desc = 'Select right window' })
vim.keymap.set('n', '<C-M-l>', '<C-w>l', { desc = 'Select right window' })
vim.keymap.set('n', '<C-M-down>', '<C-w>j', { desc = 'Select bottom window' })
vim.keymap.set('n', '<C-M-j>', '<C-w>j', { desc = 'Select bottom window' })
vim.keymap.set('n', '<C-M-up>', '<C-w>k', { desc = 'Select top window' })
vim.keymap.set('n', '<C-M-k>', '<C-w>k', { desc = 'Select top window' })

vim.keymap.set('n', '<leader>ol', ':Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>om', ':Mason<cr>', { desc = 'Mason' })

vim.keymap.set('n', '<leader>bn', ':ene <bar> startinsert<cr>', { desc = 'New buffer' })

local isTempBuffer = function(buf)
  local bufName = vim.api.nvim_buf_get_name(buf)

  if bufName == '' then
    return true
  else
    local f = io.open(bufName, 'r')

    if (f) then
      f.close(f)

      return false
    else
      return true
    end
  end
end

local function create_directory_recursive(path)
  local parent = vim.fn.fnamemodify(path, ":h") -- Get the parent directory
  if not vim.uv.fs_stat(parent) then
    create_directory_recursive(parent)          -- Create the parent directory first
  end

  if not vim.loop.fs_stat(path) then
    local success, err = vim.loop.fs_mkdir(path, 493) -- 0755
    if not success then
      print("Error creating directory:", err)

      return false
    end
  end

  return true
end

local tryCloseBuffer = function(buf)
  -- local isModified = vim.api.nvim_get_option_value('modified', { buf = vim.api.nvim_get_current_buf() })
  vim.api.nvim_set_current_buf(buf)

  local isModified = vim.api.nvim_get_option_value('modified', { buf = buf })

  if isModified then
    local input = vim.fn.input('Buffer has unsaved changes. Save this buffer? y / n: ')
    input = string.lower(tostring(input))
    input = string.gsub(input, "%s+", "")

    -- vim.api.nvim_create_buf(true, true)
    -- vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")

    -- string.match('sdf.txt', "(.*[/\\])")
    if input == 'y' then
      if isTempBuffer(buf) then
        local newFileName = vim.fn.input('New file name: ')
        if newFileName == '' or newFileName == nil then
          return
        else
          local dir = string.match(newFileName, "(.*[/\\])")

          if dir ~= '' and dir ~= nil then
            local success = create_directory_recursive(dir)

            if success == false then
              return
            end
          end

          vim.cmd('w ' .. newFileName)
          vim.api.nvim_buf_delete(buf, { force = false })
        end
        return
      else
        vim.api.nvim_buf_call(buf, function() vim.cmd('w') end)
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    elseif input == 'n' then
      vim.api.nvim_buf_delete(buf, { force = true })
    else
    end
  else
    vim.api.nvim_buf_delete(buf, { force = false })
  end
end

local tryCloseCurrentBuffer = function()
  tryCloseBuffer(vim.api.nvim_get_current_buf())
end

local closeAllBuffers = function()
  vim.cmd("only")

  local bufs = vim.api.nvim_list_bufs()

  for _, bufnr in ipairs(bufs) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
      tryCloseBuffer(bufnr)
      -- local name = vim.api.nvim_buf_get_name(bufnr)
      -- vim.notify("Buffer ID: " .. bufnr .. " Name: " .. (name ~= "" and name or "[No Name]"))
    end
  end
end

-- vim.keymap.set('n', '<C-F4>', ':bp<bar>sp<bar>bn<bar>bd<cr>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<C-F4>', tryCloseCurrentBuffer, { desc = 'Close current buffer' })
vim.keymap.set('n', '<C-w><S-x>', closeAllBuffers, { desc = 'Close all buffers' })
vim.keymap.set('n', '<C-w>s', ':vsplit<cr>', { desc = 'Split vertically' })
vim.keymap.set('n', '<C-w><S-s>', ':split<cr>', { desc = 'Split horizontally' })
