--[[
	id: UmUH6aWxSOlMHiyjCB_11
	name: Nico
	description: Nico
	time1: 2021-05-04 07:38:05.415568+00
	time2: 2021-05-04 07:38:05.415569+00
	uploader: 1928
	uploadersession: DLGgUHrAc4FzPyeougySgWEmSoT4iM
	flag: f
--]]

client.color_log(255, 255, 255, "---------------------------------------------------------------------------")
client.log("     Get good Get gamesense")
client.color_log(0, 255, 216, "[gamesense]  Lua for Nico (Hana) edit :2021/05/17 ")
client.color_log(0, 255, 216, "[gamesense]  Discord: Kagura#2906 ")
client.color_log(0, 255, 216, "[gamesense]  Join Discord server https://discord.gg/zttB747 ")
client.color_log(255, 255, 255, "---------------------------------------------------------------------------")

ui.new_label("config", "lua", "----------------------------------------------------------")
ui.new_label("config", "lua", "Update for 2021-05-17 ")
ui.new_label("config", "lua", "change Anti-Aim lua")
ui.new_label("config", "lua", "Delete various indicators")
ui.new_label("config", "lua", "Optimize FPS and vision")
ui.new_label("config", "lua", "----------------------------------------------------------")

require("Hana/adaptive_weapon2")  --武器自适应
require("Hana/draw_purchases") --显示敌方购买
require("Hana/Hana") -- 杂项lua
require("Hana/Anti-Aim") -- AA lua
require("Hana/wall dmg")   --穿墙指示器
require("Hana/nadeESP")  --道具ESP
require("Hana/zeus waring") --宙斯警告
require("Hana/custom player model") -- 换模型
require("Hana/color_changer") -- 上色
require("Hana/#new NETG") -- Netg
require("Hana/hand chams") -- 武器线条
require("Hana/wireframe_hands") -- 手臂线条
