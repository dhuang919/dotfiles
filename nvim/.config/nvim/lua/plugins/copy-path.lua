-- https://github.com/hong4rc/copy-path.nvim?tab=readme-ov-file#configuration
return {
  "hong4rc/copy-path.nvim",
  event = "VeryLazy",
  opts = {
    -- Default is f but using c to avoid fzf-lua conflicts
    picker_keymap = "<leader>cp",
    keymaps = {
      relative    = "<leader>cy",     -- src/foo/Bar.tsx
      full        = "<leader>cY",     -- /home/user/project/src/foo/Bar.tsx
      filename    = "<leader>cN",     -- Bar.tsx
      line        = "<leader>cl",     -- src/foo/Bar.tsx:42
      github      = "<leader>cg",     -- https://github.com/.../Bar.tsx
      github_line = "<leader>cG",     -- https://github.com/.../Bar.tsx#L42
    },
  },
}
