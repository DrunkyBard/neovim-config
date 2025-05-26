local M = {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
    config = function()
      vim.api.nvim_set_hl(0, 'MasonNormal', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'MasonBackdrop', { link = 'Normal' })
      require('mason').setup({
        ui = {
          border = 'double'
        }
      })
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "rcarriga/cmp-dap" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "onsails/lspkind.nvim" },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      }
    },
    event = 'InsertEnter',
    config = function()
      local dap = require('dap')
      dap.adapters.coreclr = {
        type = 'executable',
        command = 'd:\\NetCoreDbg\\netcoredbg',
        args = { '--interpreter=vscode' }
      }
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }

      local lspkind = require('lspkind')
      local cmp = require('cmp')

      local window_style = {
        border = 'single',
        -- winhighlight = 'NormalNC:PmenuMatch,Normal:PmenuMatch,FloatBorder:PmenuMatch,CursorLine:PmenuSel,Search:None',
        side_padding = 1,
      }

      cmp.setup({
        completion = {
          autocomplete = false,
        },
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
              or require("cmp_dap").is_dap_buffer()
        end,
        sources = {
          { name = 'nvim_lsp' },
          { name = "path" },
          { name = 'buffer' },
          {
            name = 'lazydev',
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          },
        },
        filetype = {
          { "dap-repl", "dapui_watches", "dapui_hover" },
          {
            sources = {
              { name = "dap" },
            },
          }
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-a>'] = cmp.mapping.complete(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50,              -- leading text (labelDetails)
              abbr = 50,              -- actual suggestion item
            },
            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              -- ...
              return vim_item
            end
          })
        },
        window = {
          completion = cmp.config.window.bordered(window_style),
          documentation = cmp.config.window.bordered(window_style),
        }
      })
    end
  },
  -- {
  --   'rcarriga/cmp-dap',
  --   config = function()
  --     -- :lua= require("dap").session().capabilities.supportsCompletionsRequest <- to check that adapter supports completion requests
  --     require("cmp").setup({
  --       enabled = function()
  --         return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  --             or require("cmp_dap").is_dap_buffer()
  --       end
  --     })
  --
  --     require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  --       sources = {
  --         { name = "dap" },
  --       },
  --     })
  --   end
  -- },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'p00f/clangd_extensions.nvim' }
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }
          local win_opts = {
            border = 'double',
          }

          -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'K', function() vim.lsp.buf.hover(win_opts) end, opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help(win_opts) end, opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      -- require('mason').setup({
      --   ui = {
      --     border = 'single'
      --   }
      -- })

      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'clangd', 'vimls', 'neocmake', 'ts_ls', 'zls' },
        automatic_installation = false,
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          neocmake = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            require('lspconfig').neocmake.setup {
              capabilities = capabilities,
              cmd = {
                "neocmakelsp",
                "--stdio"
              },
              filetypes = { 'cmake' },
              root_dir = function(fname)
                local util = require('lspconfig.util')

                return util.root_pattern(unpack({ '.git', 'build', 'cmake' }))(fname)
              end,
              single_file_support = true,
            }
          end,
          ts_ls = function()
            require('lspconfig').ts_ls.setup({
            })
          end,
          clangd = function()
            require('lspconfig').clangd.setup({
              cmd = {
                'clangd',
                '--background-index',
                '--clang-tidy',
              },
              init_options = {
                fallbackFlags = { '-std=c++17' },
              },
              on_attach = function(client, bufnr)
                local toggleInlayHint = function()
                  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end

                vim.keymap.set('n', '<leader>ti', toggleInlayHint, { desc = 'Toggle inlay hints' })
                vim.keymap.set('n', 'gh', ':ClangdTypeHierarchy<cr>', { desc = 'Type hierarchy' })
                vim.keymap.set('n', 'g.', ':ClangdSwitchSourceHeader<cr>', { desc = 'Switch source/header' })
              end
            })
          end,
          vimls = function()
            require('lspconfig').vimls.setup({})
          end,
          lua_ls = function()
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  telemetry = {
                    enable = false
                  },
                  format = {
                    enable = true,
                    defaultConfig = {
                      indent_style = "space",
                      indent_size = "2"
                    }
                  }
                },
              },
              on_attach = function(client, bufnr)
                --config.on_attach(client, bufnr)
                client.server_capabilities.documentFormattingProvider = true
                client.server_capabilities.documentRangeFormattingProvider = true
              end,
              on_init = function(client)
                local join = vim.fs.joinpath
                local path = client.workspace_folders[1].name

                -- Don't do anything if there is project local config
                if vim.uv.fs_stat(join(path, '.luarc.json'))
                    or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
                then
                  return
                end

                -- Apply neovim specific settings
                local runtime_path = vim.split(package.path, ';')
                table.insert(runtime_path, join('lua', '?.lua'))
                table.insert(runtime_path, join('lua', '?', 'init.lua'))

                local nvim_settings = {
                  runtime = {
                    -- Tell the language server which version of Lua you're using
                    version = 'LuaJIT',
                    path = runtime_path
                  },
                  diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' }
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      -- Make the server aware of Neovim runtime files
                      vim.env.VIMRUNTIME,
                      vim.fn.stdpath('config'),
                    },
                  },
                }

                client.config.settings.Lua = vim.tbl_deep_extend(
                  'force',
                  client.config.settings.Lua,
                  nvim_settings
                )
              end,
            })
          end,
          zls = function()
            vim.notify('zls setup', vim.log.levels.INFO)
            require('lspconfig').zls.setup({
              cmd = { 'zls' },
              filetypes = { 'zig', 'zir' },
              root_markers = { 'zls.json', 'build.zig', '.git' },
              workspace_required = false
            })
          end
        }
      })
    end
  }
}

return M
