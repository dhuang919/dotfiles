-- Cutlass overrides the delete operations to actually just delete and not affect the current yank.

return {
  "gbprod/cutlass.nvim",
  opts = {
    exclude = { "ns", "nS" }, -- flash.nvim
    registers = {
      delete = "d",
      change = "c",
    },
  },
}
