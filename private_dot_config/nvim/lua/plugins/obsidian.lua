local cursor_on_bbg_link = function()
  local pattern = "bbg://screens/[a-zA-Z0-9%%]+"
  local cur_line = vim.api.nvim_get_current_line()
  local _, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
  cur_col = cur_col + 1 -- nvim_win_get_cursor returns 0-indexed column
  local i, j = string.find(cur_line, pattern)
  if i ~= nil and j ~= nil and i <= cur_col and cur_col <= j then
    print("success")
    return string.sub(cur_line, i, j)
  end
  return nil
end

local smarter_action = function()
  local iter = require("obsidian.itertools").iter
  local search = require("obsidian.search")
  local util = require("obsidian.util")
  local cur_line = vim.api.nvim_get_current_line()
  local link = cursor_on_bbg_link()
  if link then
    print("success 2 " .. link)
    -- os.execute("/usr/local/bin/prlctl exec \"Windows 10 x64\" --current-user c:/blp/Wintrv/BbgProtocolHandler.exe URL")
    vim.fn.system{"/usr/local/bin/prlctl", "exec", "\"Windows 10 x64\"", "--current-user", "c:/blp/Wintrv/BbgProtocolHandler.exe", link}
  end
  return util.smart_action()
  -- if util.cursor_on_markdown_link() then
  --   for match in iter(search.find_refs(cur_line, {})) do
  --   end
  -- end
end

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
        action = smarter_action,
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
      if vim.startswith(url, "bbg://") then
        vim.fn.system{"/usr/local/bin/prlctl", "exec", "\"Windows 10 x64\"", "--current-user", "c:/blp/Wintrv/BbgProtocolHandler.exe", url}
        return
      end
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
    callbacks = {
      post_setup = function(_)
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
