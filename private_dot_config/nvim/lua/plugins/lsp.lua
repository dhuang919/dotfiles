local servers = {
  bashls = {},
  clangd = {},
  docker_compose_language_service = {},
  dockerls = {},
  gopls = {},
  jsonls = {},
  lua_ls = {
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
  },
  pyright = {
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
  },
  ruff = {
    capabilities = {
      general = {
        -- ruff was using utf-8 while pyright was using utf-16 (preferred)
        -- https://github.com/astral-sh/ruff/issues/14483
        positionEncodings = { "utf-16" },
      },
    },
  },
  rust_analyzer = {},
  sqlls = {},
  ts_ls = {},
  yamlls = {},
}

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
    config = function()
      require("mason").setup()
      local mason_lspcfg = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          -- prefer lsp fold over treesitter (from :h vim.lsp.foldexpr)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
          end

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
        end,
      })

      mason_lspcfg.setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name]
            server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)
            lspconfig[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
