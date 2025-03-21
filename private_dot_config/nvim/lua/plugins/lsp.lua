return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "saghen/blink.cmp" },
    },
    init = function()
      -- reserve a space in the gutter
      -- this will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function(_, opts)
      require("mason").setup()
      local mason_lspcfg = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local lspopts = { buffer = event.buf }
          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", lspopts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", lspopts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", lspopts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", lspopts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", lspopts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", lspopts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", lspopts)
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", lspopts)
          vim.keymap.set(
            { "n", "x" },
            "<F3>",
            "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
            lspopts
          )
          vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", lspopts)
        end,
      })

      mason_lspcfg.setup({
        ensure_installed = {
          "clangd",
          "docker_compose_language_service",
          "dockerls",
          "gopls",
          "jsonls",
          "lua_ls",
          "pyright",
          "ruff",
          "rust_analyzer",
          "sqlls",
          "ts_ls",
          "yamlls",
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            lspconfig[server_name].setup({})
          end,
          lua_ls = function()
            lspconfig.lua_ls.setup({
              -- taken from https://lsp-zero.netlify.app/docs/guide/neovim-lua-ls.html
              settings = {
                Lua = {
                  telemetry = { enable = false },
                },
              },
              on_init = function(client)
                local join = vim.fs.joinpath
                local path = client.workspace_folders[1].name

                -- don't do anything if there is project local config
                if
                  vim.uv.fs_stat(join(path, ".luarc.json"))
                  or vim.uv.fs_stat(join(path, ".luarc.jsonc"))
                then
                  return
                end

                -- apply neovim specific settings
                local runtime_path = vim.split(package.path, ";")
                table.insert(runtime_path, join("lua", "?.lua"))
                table.insert(runtime_path, join("lua", "?", "init.lua"))

                local nvim_settings = {
                  runtime = {
                    version = "LuaJIT",
                    path = runtime_path,
                  },
                  diagnostics = {
                    -- get the language server to recognize the `vim` global
                    globals = { "vim" },
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      -- make the server aware of neovim runtime files
                      vim.env.VIMRUNTIME,
                      vim.fn.stdpath("config"),
                    },
                  },
                }

                client.config.settings.Lua =
                  vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
              end,
            })
          end,
          pyright = function()
            lspconfig.pyright.setup({
              settings = {
                pyright = {
                  disableOrganizeImports = true, -- use ruff
                },
                -- python = {
                --   analysis = {
                --     ignore = { "*" }, -- use ruff
                --   },
                -- },
              },
            })
          end,
        },
      })
      -- blink.cmp setup
      for server, config in pairs(opts.servers or {}) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
