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
              -- taken from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
              on_init = function(client)
                if client.workspace_folders then
                  local path = client.workspace_folders[1].name
                  if
                    path ~= vim.fn.stdpath("config")
                    and (
                      vim.loop.fs_stat(path .. "/.luarc.json")
                      or vim.loop.fs_stat(path .. "/.luarc.jsonc")
                    )
                  then
                    return
                  end
                end
                client.config.settings.Lua =
                  vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = { version = "LuaJIT" },
                    workspace = {
                      checkThirdParty = false,
                      library = { vim.env.VIMRUNTIME },
                    },
                  })
              end,
              settings = {
                Lua = {},
              },
            })
          end,
          pyright = function()
            lspconfig.pyright.setup({
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
