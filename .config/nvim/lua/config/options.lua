-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 光标十字线
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
-- vim.cmd.colorscheme("base16-dracula")

-- vim.opt.clipboard = "unnamedplus"

-- 初始字号
vim.g.neovide_font_size = 15
vim.o.guifont = "Hurmit Nerd Font:h" .. vim.g.neovide_font_size .. ":b"

-- 放大字体
vim.keymap.set("n", "<C-=>", function()
  vim.g.neovide_font_size = vim.g.neovide_font_size + 0
  vim.o.guifont = "Hurmit Nerd Font:h" .. vim.g.neovide_font_size .. ":b"
end)

-- 缩小字体
vim.keymap.set("n", "<C-->", function()
  vim.g.neovide_font_size = vim.g.neovide_font_size - 0
  vim.o.guifont = "Hurmit Nerd Font:h" .. vim.g.neovide_font_size .. ":b"
end)
