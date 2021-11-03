--[[
	id: KsIL3l83Lc3M51SxDpmxJ
	name: C_dormant goods
	description: C_dormant goods
	time1: 2021-07-13 18:42:13.598738+00
	time2: 2021-07-13 18:42:13.598739+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

local csgo_weapons = require 'gamesense/csgo_weapons'
local drop_esp = ui.reference("VISUALS", "Other ESP", "Dropped weapons")
local x, y, z, dormant, seen, ent_weapon_index = {}, {}, {}, {}, {}, {}

--修改右边的内容就是显示内容(基本上的武器已经包含)
local Chinese_ToEnglish = {
	["沙漠之鹰"] = "Deagle",
	["双持贝瑞塔"] = "Elite",
	["格洛克 18 型"] = "Glock",
	["法玛斯"] = "Famas",
	["加利尔 AR"] = "Galil",
	["排斥装置"] = "Repulsion device",
	["PP-野牛"] = "Bizom",
	["内格夫"] = "Negev",
	["截短霰弹枪"] = "Sawed off",
	["宙斯 X27 电击枪"] = "Zeus",
	["新星"] = "Nova",
	["防弹盾"] = "Bulletproof device",
	["匕首"] = "Knife",
	["闪光震撼弹"] = "Flash",
	["高爆手雷"] = "Grenade",
	["烟雾弹"] = "Smoke",
	["燃烧瓶"] = "Fire",
	["诱饵手雷"] = "Decoy",
	["燃烧弹"] = "Fire",
	["防弹背心"] = "Armor",
	["防弹背心 + 头盔"] = "Armor",
	["重型护甲"] = "Heavy Armor",
	["营救工具包"] = "Save Kit",
	["医疗针"] = "Health Kit",
	["M4A1 消音型"] = "M4A1",
	["USP 消音版"] = "USP",
	["R8 左轮手枪"] = "Revolver",
	["斧头"] = "Axe",
	["锤子"] = "Hammer",
	["雪球"] = "Snow Ball",
}

--这里修改左边的就不显示了
local should_diplay_name = {
	["--沙漠之鹰"] = true,
	["--双持贝瑞塔"] = true,
	["--FN57"] = true,
	["--格洛克 18 型"] = true,
	["--AK-47"] = true,
	["--AUG"] = true,
	["AWP"] = true,
	["--法玛斯"] = true,
	["Auto"] = true,
	["--加利尔 AR"] = true,
	["--M249"] = true,
	["--M4A4"] = true,
	["--MAC-10"] = true,
	["--P90"] = true,
	["--排斥装置"] = true,
	["--MP5-SD"] = true,
	["--UMP-45"] = true,
	["--XM1014"] = true,
	["--PP-野牛"] = true,
	["--MAG-7"] = true,
	["--内格夫"] = true,
	["--截短霰弹枪"] = true,
	["--Tec-9"] = true,
	["--宙斯 X27 电击枪"] = true,
	["--P2000"] = true,
	["--MP7"] = true,
	["--MP9"] = true,
	["--新星"] = true,
	["--P250"] = true,
	["--防弹盾"] = true,
	["--SG 553"] = true,
	["SSG 08"] = true,
	["匕首"] = true,
	["匕首"] = true,
	["--闪光震撼弹"] = true,
	["高爆手雷"] = true,
	["烟雾弹"] = true,
	["燃烧瓶"] = true,
	["--诱饵手雷"] = true,
	["燃烧弹"] = true,
	["C4"] = true,
	["--防弹背心"] = true,
	["--防弹背心 + 头盔"] = true,
	["--重型护甲"] = true,
	["Kit"] = true,
	["营救工具包"] = true,
	["医疗针"] = true,
	["--匕首"] = true,
	["--M4A1 消音型"] = true,
	["--USP 消音版"] = true,
	["--CZ75"] = true,
	["--R8 左轮手枪"] = true,
	["--战术探测手雷"] = true,
	["--徒手"] = true,
	["--遥控炸弹"] = true,
	["--特训助手"] = true,
	["--匕首"] = true,
	["--斧头"] = true,
	["--锤子"] = true,
	["--扳手"] = true,
	["--幽灵之刃"] = true,
	["火焰弹"] = true,
	["--干扰型武器"] = true,
	["--破片手雷"] = true,
	["--雪球"] = true,
	["--弹射地雷"] = true
}

local name_replacements = {
	[csgo_weapons.weapon_c4.name] = "C4",
	[csgo_weapons.item_defuser.name] = "Kit",
}

client.set_event_callback("paint", function()
	if #ui.get(drop_esp) == 0 then return end

	for i = 1, #csgo_weapons do
		if csgo_weapons[i] and dormant[i] and x[i] then
			local name = name_replacements[csgo_weapons[i].name] or csgo_weapons[i].name
			local xa, ya = renderer.world_to_screen(x[i], y[i], z[i])
			
			if(name == "SCAR-20" or name == "G3SG1") then
				name = "Auto"
			end

			if(should_diplay_name[name] == true) then
				if(Chinese_ToEnglish[name]) then
					name = Chinese_ToEnglish[name]
				end
				
				renderer.text(xa, ya, 255, 0, 0, 255, "+", 0, string.upper(name))
				
			end
		end
	end
end)

client.set_event_callback("net_update_start", function()
	if #ui.get(drop_esp) == 0 then return end
	if not entity.get_local_player() then return end
	if entity.get_prop(entity.get_game_rules(), "m_bWarmupPeriod") == 1 then return end
	if cvar.game_type:get_int() == 1 and cvar.game_mode:get_int() == 2 then return end
	local entities = entity.get_all()
	local ignore = {}
	for _, ent in ipairs(entities) do
		local weapon_idx = entity.get_prop(ent, "m_iItemDefinitionIndex")
		if csgo_weapons[weapon_idx] then
			seen[ent] = true
			ent_weapon_index[ent] = weapon_idx
			if not entity.get_prop(ent, "m_hOwnerEntity") then
				x[weapon_idx], y[weapon_idx], z[weapon_idx] = entity.get_prop(ent, "m_vecOrigin")
				dormant[weapon_idx] = false
				ignore[weapon_idx] = true
			end
		end
	end
	for ent, _ in pairs(seen) do
		if entity.is_dormant(ent) and not ignore[ent_weapon_index[ent]] then
			dormant[ent_weapon_index[ent]] = true
		end
	end
end)

local function reset()
	x, dormant, seen, ent_weapon_index = {}, {}, {}, {}
end
client.set_event_callback("round_start", reset)
client.set_event_callback("player_connect_full", reset)