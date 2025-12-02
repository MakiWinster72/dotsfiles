-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 禁用 Node provider
vim.g.loaded_node_provider = 0
-- 禁用 Perl provider
vim.g.loaded_perl_provider = 0
-- 禁用 Ruby provider
vim.g.loaded_ruby_provider = 0

if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")

  vim.g.clipboard = {
    name = "OSC52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = function()
        return vim.fn.getreg("+")
      end,
      ["*"] = function()
        return vim.fn.getreg("*")
      end,
    },
  }

  vim.opt.clipboard = "unnamedplus"
end
