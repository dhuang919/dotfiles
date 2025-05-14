return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("moonfly")

    -- flash.nvim highlight overrides for moonfly
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#080808", bg = "#5fafdf", bold = true }) -- blue
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#080808", bg = "#ff8700", bold = true }) -- orange
    vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#080808", bg = "#87d700", bold = true }) -- green
    vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#444444" }) -- dim gray
  end,
}
