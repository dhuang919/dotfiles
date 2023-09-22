return {
  "nvim-tree/nvim-tree.lua",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.o.termguicolors = true

    local function on_attach(bufnr)
      local api = require('nvim-tree.api')
      api.config.mappings.default_on_attach(bufnr)

      -- Remove default ctrl-e to keep scroll down
      vim.keymap.del('n', '<C-e>', { buffer = bufnr })
    end

    require("nvim-tree").setup({
      on_attach = on_attach,
      view = {
        width = 35,
      },
      update_focused_file = {
        enable = true,
      },
    })
  end,

  keys = {
    { "<C-n>", ":NvimTreeToggle<cr>" },
  },
}
