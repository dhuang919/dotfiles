return {
  {
    "numToStr/Navigator.nvim",
    event = "VeryLazy",
    opts = {
      auto_save = "all",
    },
    keys = {
      { "<C-h>", "<cmd>NavigatorLeft<cr>", desc = "NavigatorLeft" },
      { "<C-j>", "<cmd>NavigatorDown<cr>", desc = "NavigatorDown" },
      { "<C-k>", "<cmd>NavigatorUp<cr>", desc = "NavigatorUp" },
      { "<C-l>", "<cmd>NavigatorRight<cr>", desc = "NavigatorRight" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "nord",
      },
      sections = {
        lualine_b = {
          { "branch" },
        },
        lualine_c = {
          { "filename", path = 3 },
        },
      },
      inactive_sections = {
        lualine_c = {
          { "filename", path = 3 },
        },
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.gitblame_display_virtual_text = 0
      require("gitblame").setup({
        enabled = false,
      })
    end,
    keys = {
      { "<leader>oc", "<cmd>GitBlameOpenCommitURL<cr>" },
      { "<leader>of", "<cmd>GitBlameOpenFileURL<cr>" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = true,
  },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
      require("spectre").setup({
        replace_engine = {
          ["sed"] = { cmd = "sed", args = { "-i", "", "-E" } },
        },
      })
    end,
    keys = {
      {
        "<leader>S",
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "Toggle Spectre",
      },
      {
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        desc = "Search current word",
      },
      {
        "<leader>sw",
        '<esc><cmd>lua require("spectre").open_visual()<CR>',
        "v",
        desc = "Search current word",
      },
      {
        "<leader>sp",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search on current file",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader>??",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Global Keymaps (which-key)",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = {
            "actions.select",
            opts = { vertical = true },
            desc = "Open the entry in a vertical split",
          },
          ["<C-x>"] = {
            "actions.select",
            opts = { horizontal = true },
            desc = "Open the entry in a horizontal split",
          },
          ["<C-t>"] = {
            "actions.select",
            opts = { tab = true },
            desc = "Open the entry in new tab",
          },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = {
            "actions.cd",
            opts = { scope = "tab" },
            desc = ":tcd to the current oil directory",
          },
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = true,
        },
      })
      vim.keymap.set("n", "-", "<cmd>:Oil<cr>")
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = {
      keymaps = {
        disabledDefaults = { "ai", "ii", "aq", "iq", "ao", "io" },
      },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      { "<leader>se", "<cmd>SessionSearch<CR>", desc = "Session search" },
      { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "Restore session" },
    },
    config = function()
      vim.o.sessionoptions =
        "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require("auto-session").setup({
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      })
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set(
        "n",
        "[;",
        dropbar_api.goto_context_start,
        { desc = "Go to start of current context" }
      )
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
  {
    "Vimjas/vim-python-pep8-indent",
    event = "VeryLazy",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      current_line_blame = false,
      current_line_blame_formatter = "<author> | <author_time:%R> | <summary>",
      current_line_blame_opts = { delay = 200 },
    },
    keys = {
      {
        "<leader>tb",
        "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>",
        desc = "Gitsigns toggle line blame",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    opts = {
      use_icons = false,
    },
    keys = {
      { "<leader>hc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>hh", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
      { "<leader>hf", "<cmd>DiffviewFileHistory --follow %<cr>", desc = "File history" },
      { "<leader>hl", "<cmd>.DiffviewFileHistory --follow %<cr>", desc = "Line history" },
      {
        "<leader>hl",
        "<esc><cmd>'<,'>DiffviewFileHistory --follow<cr>",
        mode = "v",
        desc = "Range history",
      },
    },
  },
}
