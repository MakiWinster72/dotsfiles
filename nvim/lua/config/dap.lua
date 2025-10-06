local dap = require("dap")
local dapui = require("dapui")
local dappy = require("dap-python")

-- 启动 dap-ui
dapui.setup()
dappy.setup("python3") -- 让 debugpy 用系统 python3

-- 调试开始/结束时自动打开/关闭 UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
