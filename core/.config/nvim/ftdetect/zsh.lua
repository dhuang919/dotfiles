vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.zshrc.tmpl", "*.custom.tmpl" },
  callback = function(args)
    vim.bo[args.buf].filetype = "zsh"
  end,
})
