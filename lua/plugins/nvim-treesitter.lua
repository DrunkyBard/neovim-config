return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  build = ":TSUpdate",
  
init = function()
      local highlight = function(bufnr, lang)
        -------------------[ treesitter highlights ]-------------------------------
        if not vim.treesitter.language.add(lang) then
          return vim.notify(
            string.format("Treesitter cannot load parser for language: %s", lang),
            vim.log.levels.INFO,
            { title = "Treesitter" }
          )
        end
        vim.treesitter.start(bufnr)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo.filetype
          local bt = vim.bo.buftype
          local buf = args.buf

          if bt ~= "" then
            return
          end -- don't run further.

          local ok, treesitter = pcall(require, "nvim-treesitter")
          if not ok then
            return
          end

          ---------------------[ treesitter indent ]-------------------------------

          if not vim.tbl_contains({"vimdoc", "javascript", "typescript", "c", "cpp", "lua", "rust",
"jsdoc", "bash", "c_sharp", "xml", "cmake", "zig"
}, ft) then
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end

          --------------------[ treesitter parsers ]-------------------------------
          if vim.fn.executable "tree-sitter" ~= 1 then
            vim.api.nvim_echo({
              {
                "tree-sitter CLI not found. Parsers cannot be installed.",
                "ErrorMsg",
              },
            }, true, {})
            return false
          end

          if not vim.treesitter.language.get_lang(ft) then
            return
          end

          if vim.list_contains(treesitter.get_installed(), ft) then
            highlight(buf, ft)
          elseif vim.list_contains(treesitter.get_available(), ft) then
            treesitter.install(ft):await(function()
              highlight(buf, ft)
            end)
          end
        end,
      })
    end,


--   init = function()
--     local ensure_installed = {
--       "vimdoc", "javascript", "typescript", "c", "cpp", "lua", "rust",
--       "jsdoc", "bash", "c_sharp", "xml", "cmake", "zig"
--     }
--     -- local alreadyInstalled = require('nvim-treesitter.config').get_installed()
--     -- local parsersToInstall = vim.iter(ensure_installed)
--     --     :filter(function(parser)
--     --       return not vim.tbl_contains(alreadyInstalled, parser)
--     --     end)
--     --     :totable()
--     -- require('nvim-treesitter').install(parsersToInstall)
-- --
--
--     require('nvim-treesitter').install(ensure_installed)
--
--     vim.api.nvim_create_autocmd('FileType', {
--       callback = function(args)
--         -- Enable treesitter highlighting and disable regex syntax
--         -- pcall(vim.treesitter.start)
--         -- Enable treesitter-based indentation
--         -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--
--         local filetype = args.match
--         local lang = vim.treesitter.language.get_lang(filetype)
--         if vim.treesitter.language.add(lang) then
--           vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--           vim.treesitter.start()
--         end
--       end,
--     })
--   end,
  -- config = function()
  --   require("nvim-treesitter.configs").setup({
  --     -- A list of parser names, or "all"
  --     ensure_installed = {
  --       "vimdoc", "javascript", "typescript", "c", "cpp", "lua", "rust",
  --       "jsdoc", "bash", "c_sharp", "xml", "cmake", "zig"
  --     },
  --
  --     -- Install parsers synchronously (only applied to `ensure_installed`)
  --     sync_install = false,
  --
  --     -- Automatically install missing parsers when entering buffer
  --     -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
  --     auto_install = true,
  --
  --     indent = {
  --       enable = true
  --     },
  --
  --     highlight = {
  --       -- `false` will disable the whole extension
  --       enable = true,
  --       disable = function(lang, buf)
  --         if lang == "html" then
  --           print("disabled")
  --           return true
  --         end
  --
  --         local max_filesize = 10000 * 1024           -- 10 MB
  --         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  --         if ok and stats and stats.size > max_filesize then
  --           vim.notify(
  --             "File larger than 100KB treesitter disabled for performance. Current file size: " .. stats.size,
  --             vim.log.levels.WARN,
  --             { title = "Treesitter" }
  --           )
  --           return true
  --         end
  --       end,
  --
  --       -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  --       -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
  --       -- Using this option may slow down your editor, and you may see some duplicate highlights.
  --       -- Instead of true it can also be a list of languages
  --       additional_vim_regex_highlighting = { "markdown" },
  --     },
  --   })
  --
  --   local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  --   treesitter_parser_config.templ = {
  --     install_info = {
  --       url = "https://github.com/vrischmann/tree-sitter-templ.git",
  --       files = { "src/parser.c", "src/scanner.c" },
  --       branch = "master",
  --     },
  --   }
  --
  --   vim.treesitter.language.register("templ", "templ")
  -- end
}
