local utils = require("utils")

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  cond = not utils.is_ssh(), -- don't install on spaces
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "saghen/blink.cmp",
    "ibhagwan/fzf-lua",
  },
  opts = {
    ui = { enable = false },
    footer = { enabled = false },
    legacy_commands = false,
    workspaces = {
      {
        name = "notes",
        path = "~/dev/notes",
      },
    },
    picker = { name = "fzf-lua" },
    frontmatter = { enabled = false },
    callbacks = {
      enter_note = function(_)
        vim.keymap.set("n", "<leader>ch", function()
          require("obsidian.api").toggle_checkbox()
        end, { buffer = true, desc = "Toggle checkbox" })
      end,

      post_setup = function()
        -- hack NakedUrl so it takes bbg://screens into account
        -- remove after https://github.com/obsidian-nvim/obsidian.nvim/pull/328
        local search = require("obsidian.search")
        search.Patterns.NakedUrl =
          "[a-zA-Z][a-zA-Z0-9+.-]*://[a-zA-Z0-9._-]+[a-zA-Z0-9._#/=&?:+%%-]*[a-zA-Z0-9/]"
      end,
    },
  },
  keys = {
    {
      "<leader>qs",
      "<cmd>Obsidian quick_switch<cr>",
      desc = "Obsidian Quick Switch",
      { silent = true, noremap = true },
    },
  },
}
