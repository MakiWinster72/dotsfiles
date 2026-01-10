-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.tmux")
vim.g.neovide_opacity = 0.95
vim.g.neovide_floating_blur_amount_x = 6.0
vim.g.neovide_floating_blur_amount_y = 6.0
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 8.0
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

-- 设置字体
vim.o.guifont = "Recursive Mono Casual Static:h18"

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

vim.treesitter.language.register("json", "jsonc")
