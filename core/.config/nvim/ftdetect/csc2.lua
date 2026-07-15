vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.csc2" },
  callback = function(args)
    vim.bo[args.buf].filetype = "csc2"
  end,
})
