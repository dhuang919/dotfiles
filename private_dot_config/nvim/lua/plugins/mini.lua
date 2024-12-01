return {
  {
    "echasnovski/mini.ai",
    dependencies = { "echasnovski/mini.extra", version = "*" },
    event = "VeryLazy",
    version = "*",
    config = function()
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          ["%"] = "",
          s = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          i = require("mini.extra").gen_ai_spec.indent(),
          g = require("mini.extra").gen_ai_spec.buffer(),
        },
      })
    end,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
}
