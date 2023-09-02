return {
  {
    "echasnovski/mini.splitjoin",

    event = "VeryLazy",

    version = false,

    config = function(_, opts)
      local msj = require("mini.splitjoin")
      msj.setup(opts)

      local gen_hook = msj.gen_hook
      local brackets = { brackets = {'%b{}', '%b[]'} }
      local add_comma = gen_hook.add_trailing_separator(brackets)
      local del_comma = gen_hook.del_trailing_separator(brackets)
      local pad_brackets = gen_hook.pad_brackets(brackets)

      vim.b.minisplitjoin_config = {
        split = { hooks_post = { add_comma } },
        join = { hooks_post = { del_comma, pad_brackets } },
      }
    end
  },
}
