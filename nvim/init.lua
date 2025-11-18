-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 禁用 Node provider
vim.g.loaded_node_provider = 0
-- 禁用 Perl provider
vim.g.loaded_perl_provider = 0
-- 禁用 Ruby provider
vim.g.loaded_ruby_provider = 0
