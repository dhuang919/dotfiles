local M = {}

local IS_SSH = (vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY) ~= nil

function M.is_ssh()
  return IS_SSH
end

function M.gh(x)
  return "https://github.com/" .. x
end

return M
