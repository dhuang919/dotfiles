return {
  "lewis6991/gitsigns.nvim",

  event = "VeryLazy",

  config = function()
    local on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, { desc = "Gitsigns stage hunk" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Gitsigns reset hunk" })
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Gitsigns stage hunk" })
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Gitsigns reset hunk" })
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Gitsigns stage buffer" })
      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Gitsigns undo stage hunk" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Gitsigns reset buffer" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns preview hunk" })
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, { desc = "Gitsigns blame line" })
      map(
        "n",
        "<leader>tb",
        gs.toggle_current_line_blame,
        { desc = "Gitsigns toggle line blame" }
      )
      map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns diff this" })
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, { desc = "Gitsigns diff this ~" })
      map("n", "<leader>td", gs.toggle_deleted, { desc = "Gitsigns toggle deleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns select hunk" })
    end

    require("gitsigns").setup({
      on_attach = on_attach,
      current_line_blame = false,
      current_line_blame_formatter = "<author> | <author_mail> | <author_time> | <summary>",
      current_line_blame_opts = {
        virt_text_pos = "right_align",
      },
    })
  end,
}
