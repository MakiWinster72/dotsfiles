-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 默认字体大小
vim.g.neovide_scale_factor = 1.0

-- Neovide 字号放大（Ctrl + =）
vim.keymap.set("n", "<C-=>", function()
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) + 0.1
end)

-- Neovide 字号缩小（Ctrl + -）
vim.keymap.set("n", "<C-->", function()
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) - 0.1
end)

-- 重置字号（Ctrl + 0）
vim.keymap.set("n", "<C-0>", function()
  vim.g.neovide_scale_factor = 1.0
end)

-- 设置字体为 Recursive Mono Linear Static，初始字号 14
vim.o.guifont = "Hurmit Nerd Font Mono:h16"

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
