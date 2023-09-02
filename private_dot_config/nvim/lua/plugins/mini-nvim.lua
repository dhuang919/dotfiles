return {
  {
    "echasnovski/mini.splitjoin",

    event = "VeryLazy",

    version = false,

    config = function(_, opts)
      local msj = require("mini.splitjoin")
      msj.setup(opts)

      local gen_hook = msj.gen_hook

      local all = { brackets = { '%b()', '%b[]', '%b{}' } }
      local add_trailing_comma = gen_hook.add_trailing_separator(all)
      local del_trailing_comma = gen_hook.del_trailing_separator(all)
      -- local pad_separator = gen_hook.add_trailing_separator(all)

      -- local curly = { brackets = { '%b{}' } }
      -- local add_curly_trailing_comma = gen_hook.add_trailing_separator(curly)
      -- local del_curly_trailing_comma = gen_hook.del_trailing_separator(curly)
      -- local pad_curly_brackets = gen_hook.pad_brackets(curly)

      -- local parens = { brackets = { '%b()' } }
      -- local add_parens_trailing_comma = gen_hook.add_trailing_separator(curly)
      -- local del_parens_trailing_comma = gen_hook.del_trailing_separator(curly)
      -- local pad_curly_brackets = gen_hook.pad_brackets(curly)

      -- local square = { brackets = { '%b[]' } }
      -- local add_curly_trailing_comma = gen_hook.add_trailing_separator(curly)
      -- local del_curly_trailing_comma = gen_hook.del_trailing_separator(curly)
      -- local pad_curly_brackets = gen_hook.pad_brackets(curly)

      vim.b.minisplitjoin_config = {
        split = {
          hooks_post = {
            add_trailing_comma,
          }
        },
        join = {
          hooks_post = {
            del_trailing_comma,
            -- pad_separator,
          }
        },
      }
    end
  },
}
