-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.clipboard = "unnamedplus"
-- 初始字号
vim.g.neovide_font_size = 16
vim.o.guifont = "JetBrains Mono:h" .. vim.g.neovide_font_size .. ":b" -- :b 表示 Bold

-- 放大字体
vim.keymap.set("n", "<C-=>", function()
  vim.g.neovide_font_size = vim.g.neovide_font_size + 1
  vim.o.guifont = "JetBrains Mono:h" .. vim.g.neovide_font_size .. ":b"
end)

-- 缩小字体
vim.keymap.set("n", "<C-->", function()
  vim.g.neovide_font_size = vim.g_neovide_font_size - 1
  vim.o.guifont = "JetBrains Mono:h" .. vim.g.neovide_font_size .. ":b"
end)
