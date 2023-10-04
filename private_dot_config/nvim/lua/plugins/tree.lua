return {
  "nvim-tree/nvim-tree.lua",

  lazy = false,

  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.o.termguicolors = true

    local function on_attach(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)

      -- Remove default ctrl-e to keep scroll down
      vim.keymap.del("n", "<C-e>", { buffer = bufnr })
    end

    require("nvim-tree").setup({
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      on_attach = on_attach,
      filters = {
        git_ignored = false,
      },
      renderer = {
        group_empty = true,
        highlight_diagnostics = true,
        highlight_git = true,
        highlight_modified = "all",
        highlight_opened_files = "all",
        icons = {
          web_devicons = {
            folder = {
              enable = true,
            },
          },
        },
        special_files = {
          ".pre-commit-config.yaml",
          "Cargo.toml",
          "Dockerfile",
          "Makefile",
          "README.md",
          "pyproject.toml",
          "readme.md",
        },
      },
      view = {
        number = true,
        preserve_window_proportions = true,
        width = 40,
      },
      update_focused_file = {
        enable = true,
      },
    })
  end,

  keys = {
    { "<C-n>", ":NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
  },

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
