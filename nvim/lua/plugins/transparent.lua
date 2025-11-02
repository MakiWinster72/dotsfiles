return {
  "xiyaowong/transparent.nvim",
  lazy = false, -- 在启动时加载
  config = function()
    require("transparent").setup({
      groups = {
        "Normal",
        "NormalNC",
        "SignColumn",
        "StatusLine",
        "CursorLineNr",
        "EndOfBuffer",
      },
      extra_groups = { "NeoTreeNormal", "NeoTreeNormalNC" }, -- 如果你用 NeoTree 插件
      exclude_groups = {}, -- 不透明的高亮组
    })
  end,
}
