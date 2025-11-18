-- ~/.config/nvim/lua/config/font.lua
-- 默认字体大小
vim.g.neovide_scale_factor = 1.0

-- 放大字体
vim.keymap.set("n", "<C-S-=>", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end, { desc = "Increase font size" })

-- 缩小字体
vim.keymap.set("n", "<C-S--> ", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
end, { desc = "Decrease font size" })
