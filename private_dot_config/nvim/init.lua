local plug_install_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"
if vim.fn.empty(plug_install_path) > 0 then
  vim.fn.system({
    'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim',
    "--create-dirs",
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
  })
end

local Plug = vim.fn["plug#"]
vim.call("plug#begin", vim.fn.stdpath("data") .. "/site")
Plug "SmiteshP/nvim-navic"
Plug "christoomey/vim-tmux-navigator"
Plug "editorconfig/editorconfig-vim"
Plug "folke/trouble.nvim"
Plug "neovim/nvim-lspconfig"
Plug "nvim-lua/plenary.nvim"
Plug "nvim-lualine/lualine.nvim"
Plug "nvim-telescope/telescope.nvim"
Plug "nvim-tree/nvim-tree.lua"
Plug "nvim-tree/nvim-web-devicons"
Plug "tpope/vim-surround"
Plug "williamboman/mason-lspconfig.nvim"
Plug "williamboman/mason.nvim"
Plug "windwp/nvim-autopairs"
Plug("catppuccin/nvim", {as = "catppuccin"})
Plug("nvim-treesitter/nvim-treesitter", {['do'] = ":TSUpdate"})
vim.call("plug#end")


local autopairs = require("nvim-autopairs")
autopairs.setup()


-- vim-tmux-navigator
vim.g.tmux_navigator_save_on_switch = 1


-- trouble settings
local trouble = require("trouble")
vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xw", function() trouble.open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() trouble.open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.open("loclist") end)
vim.keymap.set("n", "gR", function() trouble.open("lsp_references") end)


vim.opt.backspace = {"indent", "eol", "start"}
vim.opt.clipboard = {"unnamed", "unnamedplus"}
vim.o.expandtab = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")


-- disable stuff
vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "q:", "<Nop>")
vim.keymap.set("n", "q", "<Nop>")


local lualine = require("lualine")
lualine.setup {
  options = {
    theme = "dracula",
  },
  sections = {
    lualine_a = {
      {
        "filename",
        path = 1,
      },
    },
  },
}


local catppuccin = require("catppuccin")
catppuccin.setup({
  flavour = "mocha",
  color_overrides = {
    mocha = {
      base = "#000000",
      mantle = "#000000",
      crust = "#000000",
    },
  },
})
vim.cmd.colorscheme("catppuccin")


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
local nvim_tree = require("nvim-tree")
nvim_tree.setup()


local mason = require("mason")
local mason_lspcfg = require("mason-lspconfig")
mason.setup()
mason_lspcfg.setup {
  ensure_installed = {
    "clangd",
    "gopls",
    "jsonls",
    "lua_ls",
    "pyright",
    "yamlls",
  }
}

local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

local lspcfg = require("lspconfig")
mason_lspcfg.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn"t have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    if server_name == "lua_ls" then
      lspcfg[server_name].setup {
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
    else
      lspcfg[server_name].setup {
        on_attach = on_attach,
      }
    end
  end
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --   require("rust-tools").setup {}
  -- end
}

-- Lsp global mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- nvim-tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<cr>")


-- Easily view and switch buffers
vim.keymap.set("n", "gb", ":ls<CR>:b<Space>", { noremap = true })


-- telescope
local telescope = require("telescope")
telescope.setup {
  find_files = {
    hidden = true,
  },
}

-- Find files using Telescope command-line sugar
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })


-- File change settings stolen from https://unix.stackexchange.com/a/383044/517031
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
  pattern = {"*"},
})


-- Notification after file change
vim.api.nvim_create_autocmd({"FileChangedShellPost"}, {
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
  pattern = {"*"},
})

