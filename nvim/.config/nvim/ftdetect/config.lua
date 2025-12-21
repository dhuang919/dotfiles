vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".*config", "*gitconfig*" },
  callback = function(args)
    vim.bo[args.buf].filetype = "config"
  end,
})
