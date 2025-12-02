local notes = vim.fn.expand("~") .. "/dev/notes/**.md"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre " .. notes,
    "BufNewFile " .. notes,
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "saghen/blink.cmp",
    "ibhagwan/fzf-lua",
  },
  opts = {
    ui = {
      enable = false,
    },
    legacy_commands = false,
    workspaces = {
      {
        name = "notes",
        path = "~/dev/notes",
      },
    },
    picker = {
      name = "fzf-lua",
    },
    notes_subdir = "zk",
    new_notes_location = "notes_subdir",
    frontmatter = {
      enabled = false,
    },
    open_notes_in = "vsplit",
    attachments = {
      img_folder = "assets",
    },
    callbacks = {
      enter_note = function(note)
        vim.keymap.set("n", "<leader>ch", function()
          local line = vim.api.nvim_get_current_line()
          -- Check if unchecked (- [ ]) or in progress (- [>])
          local before, after = line:match("^(%s*%- %[)[ >]?(%].*)$")
          if before then
            vim.api.nvim_set_current_line(before .. "x" .. after)
            return
          end

          -- Uncheck if checked
          before, after = line:match("^(%s*%- %[)x(].*)$")
          if before then
            vim.api.nvim_set_current_line(before .. " " .. after)
            return
          end
        end, { buffer = note.bufnr, desc = "Obsidian: check checkbox" })
      end,

      --@param client obsidian.Client
      post_setup = function()
        local util = require("obsidian.util")
        local old_is_url = util.is_url
        -- override to treat bb urls as urls
        local _is_url = function(s)
          if string.match(util.rstrip_whitespace(s), "^bbg://screens/[a-zA-Z0-9%%]+$") then
            return true
          end
          return old_is_url(s)
        end
        util.is_url = _is_url
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
