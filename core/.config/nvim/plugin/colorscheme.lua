local gh = require("utils").gh

-- https://github.com/arnauKL/south.nvim
vim.pack.add({
  { src = gh("arnauKL/south.nvim") },
}, { confirm = false })

require("south").setup({
  transparent = true,
})

-- south has no override option and reapplies its own highlights on every load,
-- so custom groups must be re-set via a ColorScheme autocmd to survive.
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "south",
  callback = function()
    -- Dim inactive splits to match tmux's inactive pane bg (window-style in
    -- tmux.conf). tmux dims panes, not splits within a pane, so this covers the
    -- case of two nvim splits in one tmux pane. Opaque bg intentionally overrides
    -- transparency for inactive splits.
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#d3d9e6" })

    -- flash.nvim links its groups to Search/IncSearch/Substitute/Comment, which
    -- are too pale on this light theme (and south leaves Substitute undefined).
    -- Set them explicitly so jump labels and matches stand out.
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#fcfcfd", bg = "#c1293d", bold = true })
    vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#323b45", bg = "#f29130" })
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#323b45", bg = "#93bcf5" })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#9097a6" })

    -- south only sets LineNr/CursorLineNr, so relative numbers all fall back to
    -- plain grey. Color them directionally: blue above, red below. italic matches
    -- south's line-number styling.
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#1D5AB5", italic = true })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#c1293d", italic = true })
  end,
})

vim.cmd.colorscheme("south")
