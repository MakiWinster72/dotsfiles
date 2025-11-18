return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- 推荐使用
    lazy = false, -- 立即加载
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}
