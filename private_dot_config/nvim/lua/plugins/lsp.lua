local function jumpWithVirtLineDiags(jumpCount)
  -- https://www.reddit.com/r/neovim/comments/1jm5atz/comment/mk9w6v0
  pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags") -- prevent autocmd for repeated jumps

  vim.diagnostic.jump({ count = jumpCount })

  local initialVirtTextConf = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
  })

  vim.defer_fn(function() -- deferred to not trigger by jump itself
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "User(once): Reset diagnostics virtual lines",
      once = true,
      group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
      callback = function()
        vim.diagnostic.config({ virtual_lines = false, virtual_text = initialVirtTextConf })
      end,
    })
  end, 1)
end

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
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp hover", buffer = event.buf })
          vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            { desc = "lsp rename", buffer = event.buf }
          )
          vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            { desc = "lsp go to definition", buffer = event.buf }
          )
          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            { desc = "lsp go to declaration", buffer = event.buf }
          )
          vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            { desc = "lsp go to implementation", buffer = event.buf }
          )
          vim.keymap.set(
            "n",
            "go",
            vim.lsp.buf.type_definition,
            { desc = "lsp go to type definition", buffer = event.buf }
          )
          vim.keymap.set(
            "n",
            "gs",
            vim.lsp.buf.signature_help,
            { desc = "lsp signature help", buffer = event.buf }
          )
          vim.keymap.set("n", "<leader>ge", function()
            jumpWithVirtLineDiags(1)
          end, { desc = "lsp next diagnostic", buffer = event.buf })
          vim.keymap.set("n", "<leader>gE", function()
            jumpWithVirtLineDiags(-1)
          end, { desc = "lsp prev diagnostic", buffer = event.buf })
          local lspopts = { buffer = event.buf }
          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", lspopts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", lspopts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", lspopts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", lspopts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", lspopts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", lspopts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", lspopts)
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
                python = {
                  analysis = {
                    diagnosticSeverityOverrides = {
                      reportMissingImports = "none",
                    },
                  },
                },
              },
            })
          end,
          ruff = function()
            lspconfig.ruff.setup({
              capabilities = {
                general = {
                  -- ruff was using utf-8 while pyright was using utf-16 (preferred)
                  -- https://github.com/astral-sh/ruff/issues/14483
                  positionEncodings = { "utf-16" },
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
