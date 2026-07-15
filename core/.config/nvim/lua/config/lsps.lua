local utils = require("utils")

local M = {}

M.bashls = {}

M.clangd = {}

M.docker_language_server = {}

-- Don't install go lsps in spaces
if not utils.is_ssh() then
  M.golangci_lint_ls = {}

  M.gopls = {
    -- chatgpt recommendations
    on_attach = function(_, bufnr)
      local grp = vim.api.nvim_create_augroup("GoLspFormat", { clear = false })
      vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = grp,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
        end,
      })
    end,
    settings = {
      gopls = {
        staticcheck = false,
        gofumpt = true,
        directoryFilters = {
          "-**/node_modules",
          "-**/vendor",
          "-**/dist",
          "-**/bazel-out",
          "-**/.git",
        },
        usePlaceholders = true,
        analyses = { unusedparams = true },
      },
    },
  }
end

M.jsonls = {}

M.lua_ls = {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          },
        },
      })
    end,
  settings = {
    Lua = {},
  },
}

M.ruff = {
  capabilities = {
    general = {
      -- ruff was using utf-8 while pyright was using utf-16 (preferred)
      -- https://github.com/astral-sh/ruff/issues/14483
      positionEncodings = { "utf-16" },
    },
  },
}

M.sqlls = {}

M.ts_ls = {}

M.ty = {}

M.yamlls = {}

return M
