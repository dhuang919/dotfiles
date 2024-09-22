return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/dev/notes/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/dev/notes/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/dev/notes",
      },
    },
    notes_subdir = "zk",
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
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
          local smarter_action = function()
            local util = require("obsidian").util
            -- TODO: detect bbg url and send to terminal
            return util.smart_action()
          end
          return smarter_action()
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
    picker = {
      name = "telescope.nvim",
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
    sort_by = "modified",
    sort_reversed = true,
    search_max_lines = 1000,
    open_notes_in = "vsplit",
    attachments = {
      img_folder = "assets",
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
