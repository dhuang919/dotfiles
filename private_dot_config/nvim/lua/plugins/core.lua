return {
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  {
    "Vimjas/vim-python-pep8-indent",
    event = "VeryLazy",
  },
  {
    "christoomey/vim-tmux-navigator",
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
      { "<leader>co", "<cmd>GitBlameOpenCommitURL<cr>" },
      { "<leader>fo", "<cmd>GitBlameOpenFileURL<cr>" },
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
          ["sed"] = {
            cmd = "sed",
            args = {
              "-i",
              "",
              "-E",
            },
          },
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
    "kylechui/nvim-surround",
    version = "*",
    config = true,
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
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = {
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
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
