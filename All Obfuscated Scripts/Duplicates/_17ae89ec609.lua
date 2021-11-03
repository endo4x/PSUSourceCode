--[[
	id: e4cBY_F5Awsqd7njt246v
	name: 1
	description: 1
	time1: 2021-06-29 21:02:17.309544+00
	time2: 2021-06-29 21:02:17.309544+00
	uploader: 3474
	uploadersession: INDKP3ujE0-DJ36u8RfoKrrGdvgtSW
	flag: f
--]]

-- Double Tap Script Creative By SYR QQ3207523762
-- Double Tap Script Creative By SYR QQ3207523762
-- Double Tap Script Creative By SYR QQ3207523762

local ffi = require("ffi")
local images = require "gamesense/images"
local csgo_weapons = require "gamesense/csgo_weapons"
local dragging = (function()local a={}local b,c,d,e,f,g,h,i,j,k,l,m,n,o;local p={__index={drag=function(self,...)local q,r=self:get()local s,t=a.drag(q,r,...)if q~=s or r~=t then self:set(s,t)end;return s,t end,set=function(self,q,r)local j,k=client.screen_size()ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res)end,get=function(self)local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}}function a.new(u,v,w,x)x=x or 10000;local j,k=client.screen_size()local y=ui.new_slider("AA", "Fake lag",u.." pos",0,x,v/j*x)local z=ui.new_slider("AA", "Fake lag","\n"..u.." pos 2",0,x,w/k*x)ui.set_visible(y,false)ui.set_visible(z,false)return setmetatable({name=u,x_reference=y,y_reference=z,res=x},p)end;function a.drag(q,r,A,B,C,D,E)if globals.framecount()~=b then c=ui.is_menu_open()f,g=d,e;d,e=ui.mouse_position()i=h;h=client.key_state(0x01)==true;m=l;l={}o=n;n=false;j,k=client.screen_size()end;if c and i~=nil then if(not i or o)and h and f>q and g>r and f<q+A and g<r+B then n=true;q,r=q+d-f,r+e-g;if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r))end end end;table.insert(l,{q,r,A,B})return q,r,A,B end;return a end)()
local hk_dragger = dragging.new("SYR [0 0 7} Double Tap Indicators Daragger", 10, 550)

local double_tap, double_tap_key = ui.reference("RAGE", "Other", "Double tap")
local double_tap_mode = ui.reference("RAGE", "Other", "Double tap mode")
local double_tap_fake_lag_limit = ui.reference("RAGE", "Other", "Double tap fake lag limit")
local fake_lag = ui.reference("AA", "Fake lag", "Limit")
local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local increase_speed = ui.new_checkbox("RAGE", "Other", "Increase double tap speed")
local dt_active_color = ui.new_color_picker("LUA", "A", "\n Indicators Color", "0", "255", "255", "255")
local increase_speed_mode = ui.new_combobox("RAGE", "Other", "Increase double tap speed mode", {"Safe (Slower)", "Unsafe (Faster)"})
ui.set_visible(sv_maxusrcmdprocessticks, true)

local text_color_a = 255
local normal_alpha = 272
local default_alpha = 120
local old_x, old_y, last_delay
local maximum_alpha = 220
local text_carrys = "Molotov" --- �����DT������ָʾ�������� ���Ը�  ��Ҫ��"�ķ���ȥ����
local text_boxer_alpha = 0 ------ ������Ǹ� ������ͬһ�еĿ���͸���� һ�������80͸���� ���255͸���� ���0͸���� Ŀǰ0͸���� ��ȫ͸��

local function do_shit()
	ui.set(fake_lag, math.min(14, ui.get(fake_lag)))

	if ui.get(increase_speed) then
		ui.set(double_tap, true)
		ui.set(double_tap_fake_lag_limit, 1)
		ui.set(double_tap_mode, "Offensive")
		
		if ui.get(increase_speed_mode) == "Unsafe (Faster)" then
			ui.set(sv_maxusrcmdprocessticks, 20)
			cvar.cl_clock_correction:set_int(0)
			return
		end
	end
	
	ui.set(sv_maxusrcmdprocessticks, 18)
	cvar.cl_clock_correction:set_int(1)
end

ui.set_callback(increase_speed, do_shit)
ui.set_callback(increase_speed_mode, do_shit)
ui.set_callback(fake_lag, do_shit)

local function contains(list, data)
	for i, v in pairs(list) do
		if(v == data) then return true end
	end

	return false
end


local weapon_names = {
    [1] = "weapon_deagle",
    [2] = "weapon_elite",
    [3] = "weapon_fiveseven",
    [4] = "weapon_glock",
    [7] = "weapon_ak47",
    [8] = "weapon_aug",
    [9] = "weapon_awp",
    [10] = "weapon_famas",
    [11] = "weapon_g3sg1",
    [13] = "weapon_galilar",
    [14] = "weapon_m249",
    [16] = "weapon_m4a1",
    [17] = "weapon_mac10",
    [19] = "weapon_p90",
    [23] = "weapon_mp5sd",
    [24] = "weapon_ump45",
    [25] = "weapon_xm1014",
    [26] = "weapon_bizon",
    [27] = "weapon_mag7",
    [28] = "weapon_negev",
    [29] = "weapon_sawedoff",
    [30] = "weapon_tec9",
    [31] = "weapon_taser",
    [32] = "weapon_hkp2000",
    [33] = "weapon_mp7",
    [34] = "weapon_mp9",
    [35] = "weapon_nova",
    [36] = "weapon_p250",
    [38] = "weapon_scar20",
    [39] = "weapon_sg556",
    [40] = "weapon_ssg08",
    [41] = "weapon_knifegg",
    [42] = "weapon_knife",
    [43] = "weapon_flashbang",
    [44] = "weapon_hegrenade",
    [45] = "weapon_smokegrenade",
    [46] = "weapon_molotov",
    [47] = "weapon_decoy",
    [48] = "weapon_incgrenade",
    [49] = "weapon_c4",
    [50] = "item_kevlar",
    [51] = "item_assaultsuit",
    [52] = "item_heavyassaultsuit",
    [55] = "item_defuser",
    [56] = "item_cutters",
    [57] = "weapon_healthshot",
    [59] = "weapon_knife_t",
    [60] = "weapon_m4a1_silencer",
    [61] = "weapon_usp_silencer",
    [63] = "weapon_cz75a",
    [64] = "weapon_revolver",
    [68] = "weapon_tagrenade",
    [69] = "weapon_fists",
    [70] = "weapon_breachcharge",
    [72] = "weapon_tablet",
    [74] = "weapon_melee",
    [75] = "weapon_axe",
    [76] = "weapon_hammer",
    [78] = "weapon_spanner",
    [80] = "weapon_knife_ghost",
    [81] = "weapon_firebomb",
    [82] = "weapon_diversion",
    [83] = "weapon_frag_grenade",
    [84] = "weapon_snowball",
    [512] = "weapon_knife_falchion",
    [514] = "weapon_knife_survival_bowie",
    [515] = "weapon_knife_butterfly",
    [516] = "weapon_knife_push",
    [503] = "weapon_knifegg",
    [522] = "weapon_knife_stiletto",
    [519] = "weapon_knife_ursus",
    [520] = "weapon_knife_gypsy_jackknife",
    [505] = "weapon_knife_flip",
    [506] = "weapon_knife_gut",
    [507] = "weapon_knife_karambit",
    [508] = "weapon_knife_m9_bayonet",
    [509] = "weapon_knife_tactical",
    [500] = "weapon_bayonet",
    [523] = "weapon_knife_widowmaker"
}

local weapons = {
    shots_1 = {ssg08 = 40, awp = 9,},
    shots_2 = {scar = 38, g3sg1 = 11, deagle = 1, glock = 4, p250 = 36, usp = 61,},
    shots_3 = {dual = 2, fiveseven = 3, ak47 = 7, aug = 8, famas = 10, m4a4 = 16, cz75 = 63,},
    shots_4 = {mp9 = 34, mp7 = 33, mac10 = 17, mp5 = 23,},
    knife_d = {knife1 = 41, knife2 = 42, flash = 43, f2 = 44, f3 = 45, f4 = 46, f5 = 47, f6 = 48, f7 = 81, f8 = 82, f9 = 83, k506 = 506, k507 = 507, k508 = 508, k509 = 509, k510 = 510, k511 = 511, k512 = 512, k513 = 513, k514 = 514, k515 = 515, k516 = 516, k517 = 517, k525 = 525,}
}

local cmove = {
	old_tickbase = 0,
	old_sim_time = 0,
	old_command_num = 0,
	skip_next_differ = false,
	charged_before = false,
	did_shift_before = false,
	can_shift_tickbase = 0,
	is_cmd_safe = true,
	last_charge = 0,
	validate_cmd = 0,
	lag_state = nil,
	delay = 0
}

local client_get_can_exploit = function(localplayer, weapons, tickbase_correct)
	if weapons == nil then
		return
	end

	local tickbase = entity.get_prop(localplayer, "m_nTickBase")
	local curtime = globals.tickinterval() * (tickbase - tickbase_correct)
	if curtime < entity.get_prop(localplayer, "m_flNextAttack") then
		return false
	end
    
	if curtime < entity.get_prop(weapons, "m_flNextPrimaryAttack") then
		return false
	end
    
	return true
end

local function exploit_crooked(e)
	local next_shift_amount = 0
	local should_break_tbc = false
	local localplayer = entity.get_local_player()
	if not localplayer or not entity.is_alive(localplayer) then
		return
	end

	if cmove.validate_cmd > 0 then
		cmove.validate_cmd = cmove.validate_cmd - 1
		if ui.get(double_tap) and ui.get(double_tap_key) then
			should_break_tbc = true
		end
	end

	::begin_command::
	local weapons = entity.get_player_weapon(localplayer)
	local ready_to_shift = client_get_can_exploit(localplayer, weapons, 13)
	local weapon_ready = client_get_can_exploit(localplayer, weapons, math.abs(- 1 - next_shift_amount))
	if ready_to_shift == true or weapon_ready == false and cmove.did_shift_before == true then
		next_shift_amount = 13
	else
		next_shift_amount = 0
	end

	local tickbase = entity.get_prop(localplayer, "m_nTickBase")
	if cmove.old_tickbase ~= 0 and tickbase < cmove.old_tickbase then
		if cmove.old_tickbase-tickbase > 11 then
			cmove.skip_next_differ = true
			cmove.charged_before = false
			cmove.can_shift_tickbase = false
		end
	end

	local difference = e.command_number - cmove.old_command_num
	if difference >= 11 and difference <= ui.get(sv_maxusrcmdprocessticks) then
		cmove.can_shift_tickbase = not cmove.skip_next_differ
		cmove.charged_before = cmove.can_shift_tickbase
		cmove.last_charge = difference+1
		cmove.is_cmd_safe = difference > 3 and math.abs(ui.get(sv_maxusrcmdprocessticks) - difference) <= 3
		cmove.delay = math.abs(ui.get(sv_maxusrcmdprocessticks) - cmove.last_charge)
	end

	cmove.can_shift_tickbase = ready_to_shift == false and false or cmove.charged_before
	cmove.old_tickbase = tickbase
	cmove.old_command_num = e.command_number
	cmove.skip_next_differ = false
	cmove.did_shift_before = next_shift_amount ~= 0
	cmove.can_shift_tickbase = cmove.can_shift_tickbase and 2 or 0
	if cmove.can_shift_tickbase == 0 and cmove.charged_before == true then
		cmove.can_shift_tickbase = 1
	end

	if cmove.can_shift_tickbase == 0 then
		cmove.last_charge = 0
	end
end


local function creative_indicator(e)
	ui.set_visible(dt_active_color, ui.get(increase_speed))
	ui.set_visible(increase_speed_mode, ui.get(increase_speed))

	local local_player = entity.get_local_player()
	local local_weapon = entity.get_player_weapon(local_player)
	local weapons_id = entity.get_prop(local_weapon, "m_iItemDefinitionIndex") or 0
	local weapons_item = weapons_id and bit.band(weapons_id, 0xFFFF) or 0
	local exploit_can = client_get_can_exploit(local_player, local_weapon, 13)
	local weapons_name = weapon_names[weapons_item] or ""
	if not ui.get(increase_speed) or not entity.is_alive(local_player) or not ui.get(double_tap) or not ui.get(double_tap_key) then
		return
	end

	local color_r, color_g, color_b, color_a = ui.get(dt_active_color)
	local color_r_2, color_g_2, color_b_2, color_a_2 = ui.get(dt_active_color)
	if not exploit_can or not ui.get(double_tap) or not ui.get(double_tap_key) then
		color_r, color_g, color_b = 150, 150, 150
		normal_alpha = normal_alpha - 15.6
		maximum_alpha = maximum_alpha - 15.6
		if normal_alpha < 46 then
			normal_alpha = 46
		end
	else
		if normal_alpha < color_a then
			if normal_alpha < 30 or maximum_alpha < 0 then
				normal_alpha = 46
				maximum_alpha = 0
			end

			normal_alpha = normal_alpha + 15.6
			maximum_alpha = maximum_alpha + 15.6
		end

		local _, _, _, color_a = 0, 255, 255, 255
	end

	local x, y = hk_dragger:get()
	local shot_breaking_color = 50
	local steamid_64 = entity.get_steam64(local_player)
	local steam_avatar = images.get_steam_avatar(steamid_64)
	local headshot_icons = images.get_panorama_image("icons/ui/elimination_headshot.svg")
	local global_text = string.format("Goforit [%s] | Tickbase(17tick): %s", text_carrys, not exploit_can and "Chaging" or "godbin")
	local active_weapon = entity.get_player_weapon(local_player) == nil and 1 or entity.get_player_weapon(local_player)
	local weapon = csgo_weapons[entity.get_prop(active_weapon, "m_iItemDefinitionIndex")]
	local weapon_icon = images.get_weapon_icon(weapon) == nil and images.get_weapon_icon("weapon_ak47") or images.get_weapon_icon(weapon)
	local bullet_icons = images.get_panorama_image("icons/ui/bullet.svg")
	local width, widthb, steam_avatar_height = weapon_icon:measure(), 20, steam_avatar:measure()
	local h, w = 17, renderer.measure_text(nil, global_text) + steam_avatar_height + 8
	renderer.rectangle(x - 1, y - 2, w - 11, 2, 100 + shot_breaking_color, 100 + shot_breaking_color, 100 + shot_breaking_color, 100 + shot_breaking_color)
	renderer.rectangle(x - 1, y - 2, math.max(0, maximum_alpha / 218.38 * (w - 11)), 2, color_r_2, color_g_2, color_b_2, cmove.last_charge >= 16 and color_a_2 or 0)
	renderer.rectangle(x - 1, y, w - 11, h, 0, 0, 0, text_boxer_alpha)
	renderer.text(x + 4, y + 2, 255, 255, 255, 255, "", 0, global_text)
	hk_dragger:drag(w, h * 1.1)

	weapon_icon:draw(x, y + h + 6, nil, 16, 255, 255, 255, exploit_can and 255 or 150)
	steam_avatar:draw(x + w - 30, y + 3, nil, 11, 255, 255, 255, 255)
	if contains(weapons.shots_2, weapons_id) then
		bullet_icons:draw(x + width / 2 + 5, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
		bullet_icons:draw(x + width / 2 + widthb / 2 + 8, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
	elseif contains(weapons.shots_1, weapons_id) then
		headshot_icons:draw(x + width / 2 + 7, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
	elseif contains(weapons.shots_3, weapons_id) then
		bullet_icons:draw(x + width / 2 + 7, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
		bullet_icons:draw(x + width / 2 + widthb / 2 + 10, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
		bullet_icons:draw(x + width / 2 + widthb / 2 + 10 + widthb / 2, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
	elseif contains(weapons.shots_4, weapons_id) then
		bullet_icons:draw(x + width / 2 + 7, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
		bullet_icons:draw(x + width / 2 + widthb / 2 + 10, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
		bullet_icons:draw(x + width / 2 + widthb / 2 + 10 + widthb / 2 , y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
		bullet_icons:draw(x + width / 2 + widthb / 2 + 10 + widthb / 2 + widthb / 2, y + h + 7, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
	else
		bullet_icons:draw(x + width / 2 + 6, y + h + 6, nil, 16, 255, 255, 255, cmove.last_charge <= 15 and 1 + math.sin(math.abs(-math.pi + (globals.curtime() * (1 / 0.5)) % (math.pi * 2))) * 200 or maximum_alpha / 226 * 255)
	end
end

client.set_event_callback("predict_command", exploit_crooked)
client.set_event_callback("paint", creative_indicator)