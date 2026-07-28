local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/ibhagwan/fzf-lua
vim.pack.add({
  { src = gh("nvim-mini/mini.icons") },
  { src = gh("ibhagwan/fzf-lua") },
}, { confirm = false })

require("mini.icons").setup()

local fzflua = require("fzf-lua")
local default_rgopts = fzflua.defaults.grep.rg_opts
fzflua.setup({
  actions = {
    files = {
      true,
      ["ctrl-x"] = fzflua.actions.file_split,
    },
  },
  grep = { rg_opts = "--sortr=modified " .. default_rgopts },
  winopts = { preview = { layout = "vertical" } },
})

local dotfiles_dir = vim.fn.expand("~/dotfiles")
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  desc = "Search hidden files with fzf-lua grep while in dotfiles",
  callback = function()
    local cwd = vim.fn.getcwd()
    local in_dotfiles = cwd == dotfiles_dir or vim.startswith(cwd, dotfiles_dir .. "/")
    -- do_not_reset_defaults=true merges onto the setup() above instead of
    -- wiping its actions/winopts back to fzf-lua's built-in defaults
    fzflua.setup({
      grep = { hidden = in_dotfiles },
    }, true)
  end,
})

k.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "fzf buffers" })
k.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "fzf files" })
k.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "fzf live grep" })
k.set("n", "<leader>fr", "<cmd>FzfLua resume<cr>", { desc = "fzf resume" })
k.set(
  { "n", "v"},
  "<leader>fca",
  "<cmd>FzfLua lsp_code_actions<cr>",
  { desc = "fzf lsp code actions" }
)
k.set("n", "<leader>flr", "<cmd>FzfLua lsp_references<cr>", { desc = "fzf lsp refs" })
