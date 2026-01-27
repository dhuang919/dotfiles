local utils = require("utils")

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  cond = not utils.is_ssh(), -- don't install on spaces
  ft = { "markdown" },
  build = ":call mkdp#util#install()",
}
