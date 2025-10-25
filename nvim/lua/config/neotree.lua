-- ~/.config/nvim/lua/config/neotree.lua
require("neo-tree").setup({
  filesystem = {
    -- 显示隐藏文件（以 . 开头）
    filtered_items = {
      visible = true, -- 这里 true 表示显示隐藏文件
      hide_dotfiles = false, -- 关闭隐藏 dotfiles
      hide_gitignored = false, -- 显示 gitignore 忽略的文件
    },
  },
})
