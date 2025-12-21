return {
  "chrisgrieser/nvim-various-textobjs",
  lazy = false,
  opts = {
    keymaps = {
      -- conflicts with mini.ai
      -- ai/ii: indentation
      -- aq/iq: anyQuote (mini.ai q)
      -- ao/io: anyBracket (mini.ai b)
      disabledDefaults = { "ai", "ii", "aq", "iq", "ao", "io" },
      useDefaults = true,
    },
  },
}
