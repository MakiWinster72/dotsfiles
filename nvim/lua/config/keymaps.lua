-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 引入 toggleterm
-- ~/.config/nvim/lua/config/keymaps.lua

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

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "开始/继续调试" })
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end, { desc = "切换断点" })
vim.keymap.set("n", "<leader>B", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "条件断点" })
vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "打开 REPL" })
