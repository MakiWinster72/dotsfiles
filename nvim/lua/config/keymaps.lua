-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 引入 toggleterm
-- ~/.config/nvim/lua/config/keymaps.lua

-- vim.keymap.set("v", "<C-c>", '"+y')

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

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 启动/继续
map("n", "<F5>", require("dap").continue, opts)
-- 暂停/中断
map("n", "<F6>", require("dap").pause, opts)
-- 停止调试
map("n", "<F7>", require("dap").terminate, opts)
-- 重启
map("n", "<F8>", require("dap").restart, opts)
-- 设置断点
map("n", "<F9>", require("dap").toggle_breakpoint, opts)
-- 条件断点
map("n", "<leader>b", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
-- 单步跳入
map("n", "<F10>", require("dap").step_into, opts)
-- 单步跳出
map("n", "<F11>", require("dap").step_out, opts)
-- 单步跳过
map("n", "<F12>", require("dap").step_over, opts)
-- Rust: <leader> r r
vim.api.nvim_set_keymap("n", "<leader>rr", "", {
  noremap = true,
  callback = function()
    vim.cmd("w") -- 保存当前文件
    local file = vim.fn.expand("%:p")
    local filename = vim.fn.expand("%:t:r")
    vim.cmd("split | terminal rustc " .. file .. " -o " .. filename .. " && ./" .. filename)
    vim.cmd("startinsert")
  end,
  silent = true,
})

-- C: <leader> r c
vim.api.nvim_set_keymap("n", "<leader>rc", "", {
  noremap = true,
  callback = function()
    vim.cmd("w") -- 保存当前文件
    local file = vim.fn.expand("%:p")
    local filename = vim.fn.expand("%:t:r")
    vim.cmd("split | terminal gcc " .. file .. " -o " .. filename .. " && ./" .. filename)
    vim.cmd("startinsert")
  end,
  silent = true,
})

-- Python: <leader> r p
vim.api.nvim_set_keymap("n", "<leader>rp", "", {
  noremap = true,
  callback = function()
    vim.cmd("w") -- 保存当前文件
    local file = vim.fn.expand("%:p")
    vim.cmd("split | terminal python3 " .. file)
    vim.cmd("startinsert")
  end,
  silent = true,
})

-- C++: <leader> r C
vim.api.nvim_set_keymap("n", "<leader>rC", "", {
  noremap = true,
  callback = function()
    vim.cmd("w") -- 保存当前文件
    local file = vim.fn.expand("%:p")
    local filename = vim.fn.expand("%:t:r")
    -- 编译并运行 C++ 程序
    vim.cmd("split | terminal g++ " .. file .. " -o " .. filename .. " && ./" .. filename)
    vim.cmd("startinsert")
  end,
  silent = true,
})
