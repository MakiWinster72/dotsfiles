local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- 禁用 Wayland，强制使用 X11
config.enable_wayland = false

-- 字体配置
config.font = wezterm.font_with_fallback({
	"DepartureMono Nerd Font",
	"Fusion Pixel 12px M zh_hans",
	"HarmonyOS Sans SC",
	"JetBrains Mono NL",
})
config.font_size = 16

-- 颜色和透明度
config.color_scheme = "Catppuccin Macchiato"
-- config.window_background_opacity = 0.7
-- config.text_background_opacity = 0.7
config.window_decorations = "RESIZE"

-- 快捷键说明（Leader键为 ALT + q，按下后2秒内触发后续快捷键）
-- 标签页管理
--   LEADER + c: 新建标签页
--   LEADER + x: 关闭当前面板（确认）
--   LEADER + b: 切换到上一个标签页
--   LEADER + n: 切换到下一个标签页
--   LEADER + 数字(0-9): 切换到对应标签页
-- 面板拆分
--   LEADER + Shift + \（即 |）: 横向拆分面板
--   LEADER + -: 纵向拆分面板
-- 面板导航
--   LEADER + h/j/k/l: 分别切换左/下/上/右面板
-- 面板调整大小
--   LEADER + 方向键: 按5单位调整对应方向面板大小

config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }

config.keys = {
	{ mods = "LEADER", key = "c", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ mods = "LEADER", key = "b", action = wezterm.action.ActivateTabRelative(-1) },
	{ mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
	{ mods = "LEADER|SHIFT", key = "\\", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
	{ mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	{ mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
	{ mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
	{ mods = "LEADER", key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ mods = "LEADER", key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ mods = "LEADER", key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ mods = "LEADER", key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
}

for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- 鼠标右键粘贴
config.mouse_bindings = config.mouse_bindings or {}
table.insert(config.mouse_bindings, {
	event = { Down = { streak = 1, button = "Right" } },
	mods = "NONE",
	action = wezterm.action.PasteFrom("Clipboard"),
})

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

wezterm.on("update-right-status", function(window, _)
	local prefix = ""
	if window:leader_is_active() then
		prefix = " 🌊"
	end
	window:set_right_status(wezterm.format({ { Text = prefix } }))
end)

return config
