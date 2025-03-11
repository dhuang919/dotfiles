return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        event = "VeryLazy",
      },
      {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
      },
    },
    opts = {
      servers = {
        lua_ls = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mason_lspcfg = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
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
      })
      local on_attach = function(_, bufnr)
        local key_opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, key_opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, key_opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, key_opts)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, key_opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
        -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, key_opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, key_opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, key_opts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, key_opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, key_opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, key_opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, key_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, key_opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, key_opts)
      end
      mason_lspcfg.setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn"t have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup({
            on_attach = on_attach,
          })
        end,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
        pyright = function()
          lspconfig.pyright.setup({
            on_attach = on_attach,
            settings = {
              pyright = {
                disableOrganizeImports = true, -- use ruff
              },
              python = {
                analysis = {
                  ignore = { "*" }, -- use ruff
                },
              },
            },
          })
        end,
      })

      -- blink.cmp setup
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
