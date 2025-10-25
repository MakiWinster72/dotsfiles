-- ~/.config/nvim/lua/plugins/render-markdown.lua
return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = false, -- ⚠️ 确保启动时加载
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.nvim", -- 如果你用的是 mini.nvim 套件
    -- "nvim-mini/mini.icons",  -- 如果你用独立 mini 插件
    -- "nvim-tree/nvim-web-devicons",  -- 如果你用图标支持
  },
  opts = {
    -- 可以写你的自定义配置
    -- 例如：
    -- open_cmd = "tabedit"  -- 打开预览的方式
  },
}
