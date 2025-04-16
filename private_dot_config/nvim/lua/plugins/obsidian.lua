local notes = vim.fn.expand("~/dev/notes/*.md")

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
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "saghen/blink.cmp",
    "ibhagwan/fzf-lua",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/dev/notes",
      },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
    picker = {
      name = "fzf-lua",
    },
    notes_subdir = "zk",
    mappings = {
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    new_notes_location = "notes_subdir",
    preferred_link_style = "wiki",
    disable_frontmatter = true,
    templates = {
      folder = "templates",
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url }) -- open in default browser (mac os)
    end,
    follow_img_func = function(img)
      vim.fn.jobstart({ "qlmanage", "-p", img }) -- mac os quick look preview
    end,
    use_advanced_uri = false,
    open_app_foreground = false,
    sort_by = "modified",
    sort_reversed = true,
    search_max_lines = 1000,
    open_notes_in = "vsplit",
    attachments = {
      img_folder = "assets",
    },
    callbacks = {
      --@param client obsidian.Client
      post_setup = function()
        local util = require("obsidian.util")
        local old_is_url = util.is_url
        -- override to treat bb urls as urls
        local _is_url = function(s)
          if string.match(util.strip_whitespace(s), "^bbg://screens/[a-zA-Z0-9%%]+$") then
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
      ":ObsidianQuickSwitch<cr>",
      { silent = true, noremap = true, description = "Obsidian [Q]uick[S]witch" },
    },
  },
}
