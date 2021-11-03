--[[
	id: nKwkpLNwGfUDnjPZXkuFV
	name: C_Visuals1
	description: C_Visuals1
	time1: 2021-07-13 18:47:49.313142+00
	time2: 2021-07-13 18:47:49.313143+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

local client_visible, client_eye_position, client_log, client_trace_bullet, entity_get_bounding_box, entity_get_local_player, entity_get_origin, entity_get_player_name, entity_get_player_resource, entity_get_player_weapon, entity_get_prop, entity_is_dormant, entity_is_enemy, globals_curtime, globals_maxplayers, globals_tickcount, math_max, renderer_indicator, string_format, ui_get, ui_new_checkbox, ui_new_hotkey, ui_reference, ui_set_callback, sqrt, unpack, entity_is_alive, plist_get = client.visible, client.eye_position, client.log, client.trace_bullet, entity.get_bounding_box, entity.get_local_player, entity.get_origin, entity.get_player_name, entity.get_player_resource, entity.get_player_weapon, entity.get_prop, entity.is_dormant, entity.is_enemy, globals.curtime, globals.maxplayers, globals.tickcount, math.max, renderer.indicator, string.format, ui.get, ui.new_checkbox, ui.new_hotkey, ui.reference, ui.set_callback, sqrt, unpack, entity.is_alive, plist.get
local table_insert,table_remove = table.insert,table.remove
local ffi = require "ffi"
local vector = require "vector"
local weapons = require "gamesense/csgo_weapons"

local native_GetClientEntity = vtable_bind("client.dll", "VClientEntityList003", 3, "void*(__thiscall*)(void*,int)")
local native_IsWeapon = vtable_thunk(165, "bool(__thiscall*)(void*)")
local native_GetInaccuracy = vtable_thunk(482, "float(__thiscall*)(void*)")


local ref = {
	mindmg = ui_reference("RAGE", "Aimbot", "Minimum damage"),
	dormantEsp = ui_reference("VISUALS", "Player ESP", "Dormant"),
}

local menu = {
	dormant_switch = ui_new_checkbox("RAGE", "Aimbot", "Dormant aimbot"),
	dormant_key = ui_new_hotkey("RAGE", "Aimbot", "Dormant aimbot", true),
	dormant_mindmg = ui.new_slider("RAGE", "Aimbot", "Dormant minimum damage", 0, 100, 10, true),
	dormant_alpha = ui.new_slider("RAGE", "Aimbot", "Dormant alpha", 0, 100, 78.5, true,"%",1),
	dormant_indicator = ui_new_checkbox("RAGE", "Aimbot", "Dormant indicator"),
	dormant_log_clr = ui.new_color_picker("RAGE", "Aimbot", "Dormant log color", 255,0,0,255)
}

local player_info_prev = {}
local roundStarted = 0

local function modify_velocity(e, goalspeed)
	local minspeed = math.sqrt((e.forwardmove * e.forwardmove) + (e.sidemove * e.sidemove))
	if goalspeed <= 0 or minspeed <= 0 then
		return
	end

	if e.in_duck == 1 then
		goalspeed = goalspeed * 2.94117647
	end

	if minspeed <= goalspeed then
		return
	end

	local speedfactor = goalspeed / minspeed
	e.forwardmove = e.forwardmove * speedfactor
	e.sidemove = e.sidemove * speedfactor
end

local aimtarget_dormant = { }

local function on_setup_command(cmd)
	if not ui_get(menu.dormant_switch) then
		return
	end
	
	local lp = entity_get_local_player()

	local my_weapon = entity_get_player_weapon(lp)
	if not my_weapon then
		return
	end

	local ent = native_GetClientEntity(my_weapon)
	if ent == nil or not native_IsWeapon(ent) then
		return
	end

	local inaccuracy = native_GetInaccuracy(ent)
	if inaccuracy == nil then
		return
	end

	local tickcount = globals_tickcount()
	local player_resource = entity_get_player_resource()
	local eyepos = vector(client_eye_position())
	local simtime = entity_get_prop(lp, "m_flSimulationTime")
	local weapon = weapons(my_weapon)
	local scoped = entity_get_prop(lp, "m_bIsScoped") == 1
	local onground = bit.band(entity_get_prop(lp, 'm_fFlags'), bit.lshift(1, 0))
	if tickcount < roundStarted then return end -- to prevent shooting at ghost dormant esp @ the beginning of round

	local can_shoot
	if weapon.is_revolver then -- for some reason can_shoot returns always false with r8 despite all 3 props being true, no idea why
		can_shoot = simtime > entity_get_prop(my_weapon, "m_flNextPrimaryAttack") -- doing this fixes it ><
	elseif weapon.is_melee_weapon then
		can_shoot = false
	else
		can_shoot = simtime > math_max(entity_get_prop(lp, "m_flNextAttack"), entity_get_prop(my_weapon, "m_flNextPrimaryAttack"), entity_get_prop(my_weapon, "m_flNextSecondaryAttack"))
	end

	-- new player info
	local player_info = {}

	-- loop through all players and continue if they're connected
	for player=1, globals_maxplayers() do
		if entity_get_prop(player_resource, "m_bConnected", player) == 1 then
			if plist_get(player, "Add to whitelist") then goto skip end
			if entity_is_dormant(player) and entity_is_enemy(player) then
				local can_hit
				local origin = vector(entity_get_origin(player))
				local x1, y1, x2, y2, alpha_multiplier = entity_get_bounding_box(player) -- grab alpha of the dormant esp
				
				if player_info_prev[player] ~= nil and origin.x ~= 0 and alpha_multiplier > 0 then -- if origin / dormant esp is valid
					
					local old_origin, old_alpha, old_hittable = unpack(player_info_prev[player])

					-- update check

					
					local dormant_accurate = alpha_multiplier <= ui_get(menu.dormant_alpha) / 10 -- for debug purposes lower this to 0.1

					if dormant_accurate then
						
						local target = origin + vector(0, 0, 40)
						local pitch, yaw = eyepos:to(target):angles()
						local ent, dmg = client_trace_bullet(lp, eyepos.x, eyepos.y, eyepos.z, target.x, target.y, target.z, true)
						can_hit = (dmg > ui_get(menu.dormant_mindmg)) and (not client_visible(target.x, target.y, target.z)) -- added visibility check to mitigate shooting at anomalies?
						if can_shoot and can_hit and ui_get(menu.dormant_key) then
							modify_velocity(cmd, (scoped and weapon.max_player_speed_alt or weapon.max_player_speed)*0.33)

							-- autoscope
							if not scoped and weapon.type == "sniperrifle" and cmd.in_jump == 0 and onground == 1 then
								cmd.in_attack2 = 1
							end
							
							if inaccuracy < 0.009 and cmd.chokedcommands == 0 then
								cmd.pitch = pitch
								cmd.yaw = yaw
								cmd.in_attack = 1

								by_dormant_aimbot = true
								local findtarget = false

								for j = 1,#aimtarget_dormant do
									if aimtarget_dormant[j] == player then 
										findtarget = true
									end
								end

								if not findtarget then
									table_insert(aimtarget_dormant,player)
								end

							can_shoot = false
							end
						end
					end

					for j = 1,#aimtarget_dormant do
						if aimtarget_dormant[j] == player and not dormant_accurate then 
							table_remove(aimtarget_dormant,j)
						end
					end
				end

				player_info[player] = {origin, alpha_multiplier, can_hit}
			end
			
			if entity_is_enemy(player) and (not entity_is_dormant(player) or not entity_is_alive(player)) then

				for j = 1,#aimtarget_dormant do
					if aimtarget_dormant[j] == player then 
						table.remove(aimtarget_dormant,j)
					end
				end

			end
		end
		::skip::
	end

	player_info_prev = player_info
end

client.register_esp_flag("DA", 255, 255, 255, function(player)
	if ui.get(menu.dormant_switch) and entity.is_enemy(player) and player_info_prev[player] ~= nil and entity.is_alive(entity_get_local_player()) then
		local _, _, can_hit = unpack(player_info_prev[player])

		return can_hit
	end
end)

local function painter()
	if not entity_is_alive(entity_get_local_player()) then return end -- dont draw if dead :lowiqq:
	if ui_get(menu.dormant_switch) and ui_get(menu.dormant_key) and ui_get(menu.dormant_indicator) then
		local colors = {132,196,20,245}
		for k, v in pairs(player_info_prev) do 
			if k ~= nil then 
				if v[3] == true then 
					colors = {252,222,30,245}
					break
				end
			end
		end
		renderer_indicator(colors[1],colors[2],colors[3],colors[4], "Chr1s DA V2")
	end
end
local function resetter()
	local freezetime = (cvar.mp_freezetime:get_float()+1) / globals.tickinterval() -- get freezetime plus 1 second and disable dormantbob for that amount of ticks
	roundStarted = globals_tickcount() + freezetime
end

ui_set_callback(menu.dormant_switch, function()
	local czechbox = ui_get(menu.dormant_switch)
	local update_callback = czechbox and client.set_event_callback or client.unset_event_callback

	if czechbox then ui.set(ref.dormantEsp, czechbox) end -- enable dormant ESP on ui toggle ( dumb proofing )
	update_callback("setup_command", on_setup_command)
	update_callback("paint", painter)
	update_callback("round_prestart", resetter)
	ui.set_visible(menu.dormant_indicator, ui_get(menu.dormant_switch))
	ui.set_visible(menu.dormant_mindmg, ui_get(menu.dormant_switch))
	ui.set_visible(menu.dormant_alpha, ui_get(menu.dormant_switch))
end)
ui.set(menu.dormant_indicator, true)
ui.set_visible(menu.dormant_indicator, ui_get(menu.dormant_switch)) -- yes
ui.set_visible(menu.dormant_mindmg, ui_get(menu.dormant_switch)) -- yes^2

client.set_event_callback("molotov_detonate", function()
    local model = materialsystem.find_material("particle/fire_burning_character/fire_env_fire_depthblend")
    if model == nil then
        return
    end
    model:set_material_var_flag(15, true)
end)--燃烧弹穿墙透视
------------------------------



local label = ui.new_label("Lua", "b", '=======================================')
local label = ui.new_label("Lua", "b", '----------------Chr1s Visuals Lua----------------')

local globals_frametime = globals.frametime
local globals_tickinterval = globals.tickinterval
local entity_is_enemy = entity.is_enemy
local entity_get_prop = entity.get_prop
local entity_is_dormant = entity.is_dormant
local entity_is_alive = entity.is_alive
local entity_get_origin = entity.get_origin
local entity_get_local_player = entity.get_local_player
local entity_get_player_resource = entity.get_player_resource
local table_insert = table.insert
local math_floor = math.floor
local vector = require 'vector'
-------------------------------------------------

-----------------------------
local label = ui.new_label("Lua", "b", '                    =1.Hit log=')
local fakelag_limit = ui.reference("AA", "Fake lag", "Limit")
local force_safe = ui.reference("Rage", "Aimbot", "Force safe point")
local neverlose_hitlog = ui.new_multiselect("Lua", "b", "Hitlog", {"Hits Log", "Miss Log"})
local neverlose_hitlog_seat = ui.new_combobox("Lua", "b", "Hitlog Seat", {"Left Up", "Left Down", "Right Up", "Right Down","Crosshair"})
local hits_color_label = ui.new_label("Lua", "b", "Hit Log Colors")
local hits_color_c = ui.new_color_picker("Lua", "b", "\n Hit Log Color_C", 0, 255, 255, 255)
local missed_color_label = ui.new_label("Lua", "b", "Miss Log Colors")
local missed_color_c = ui.new_color_picker("Lua", "b", "\n Miss Log Color_C", 255, 0, 0, 255)

local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")

local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(neverlose_hitlog,false)
		ui.set_visible(neverlose_hitlog_seat,false)
		ui.set_visible(hits_color_c,false)
    else
        ui.set_visible(neverlose_hitlog,true)
		ui.set_visible(neverlose_hitlog_seat,true)
		ui.set_visible(hits_color_c,true)
    end
end
--client.set_event_callback("paint",HIDE_MEAN)


local notify = {}
notify.__index = notify
local aimbot_data_count = {}
local global_hit_numbers = 0
local fired_attack_bullet_id = 0
local global_missed_numbers = 0
local surface = require "gamesense/surface"
local lag_chokedcommad = ui.get(fakelag_limit)
local tickbase_data = {tick_shifted = false, tick_base = 0}
local bestkim_font = surface.create_font("BestKim", 16, 500, {0x200}) -- 4是字体大小 自己尝试修改
local hitboxer_names = {"身体", "头部", "胸口", "胃部", "左手", "右手", "左腿", "右腿", "脖子", "?", "gear"}
local function multi_select(search_table, search_value)
	for _, table_value in pairs(search_table) do
		if (search_value == table_value) then
			return true
		end
	end

	return false
end

local calculate_flags = function(function_data, fired_data_count)
	if not entity.is_alive(entity.get_local_player()) then
		return "D"
	end

	local m_ntickbase = entity.get_prop(entity.get_local_player(), "m_nTickBase")
	if m_ntickbase ~= nil and tickbase_data.tick_base ~= m_ntickbase then
		tickbase_data.tick_shifted = tickbase_data.tick_base ~= 0 and (m_ntickbase + 1) < tickbase_data.tick_base
		tickbase_data.tick_base = m_ntickbase
	end

	return function_data.refined and "R" or function_data.expired and "X" or function_data.noaccept and "N" or tickbase_data.tick_shifted and "S" or fired_data_count.boosted and "B" or fired_data_count.teleported and "T" or fired_data_count.interpolated and "I" or fired_data_count.extrapolated and "E" or fired_data_count.high_priority and "H" or ""
end

client.set_event_callback("paint_ui", function()
	if entity.is_alive(entity.get_local_player()) then
		notify:listener()
	end

	ui.set_visible(neverlose_hitlog_seat, #ui.get(neverlose_hitlog) ~= 0)
	ui.set_visible(hits_color_c, multi_select(ui.get(neverlose_hitlog), "Hits Log"))
	ui.set_visible(hits_color_label, multi_select(ui.get(neverlose_hitlog), "Hits Log"))
	ui.set_visible(missed_color_c, multi_select(ui.get(neverlose_hitlog), "Miss Log"))
	ui.set_visible(missed_color_label, multi_select(ui.get(neverlose_hitlog), "Miss Log"))

	HIDE_MEAN()
end)

client.set_event_callback("setup_command", function(cmd)
	if #ui.get(neverlose_hitlog) == 0 or not entity.is_alive(entity.get_local_player()) then
		return
	end

	lag_chokedcommad = cmd.chokedcommands
end)

client.set_event_callback("aim_fire", function(e)
	if #ui.get(neverlose_hitlog) == 0 or not entity.is_alive(entity.get_local_player()) then
		return
	end

	fired_attack_bullet_id = e.id
	aimbot_data_count[fired_attack_bullet_id] = e
end)

notify.invoke_callback = function(timeout)
	return setmetatable({active = false, delay = 0, laycoffset = -11, layboffset = -11}, notify)
end

notify.setup_color = function(color, sec_color)
	if type(color) ~= 'table' then
		notify:setup()
		return
	end

	if notify.color == nil then
		notify:setup()
	end

	if color ~= nil then
		notify.color[1] = color
	end

	if sec_color ~= nil then
		notify.color[2] = sec_color
	end
end

notify.add = function(time, is_right, ...)
	if notify.color == nil then
		notify:setup()
	end

	table.insert(notify.__list, {
		["tick"] = globals.tickcount(),
		["invoke"] = notify.invoke_callback(),
		["text"] = { ... },
		["time"] = time,
		["color"] = notify.color,
		["right"] = is_right,
		["first"] = false
	})
end

function notify:setup()
	notify.color = {{150, 185, 1},{0, 0, 0}}
	if notify.__list == nil then
		notify.__list = {}
	end
end

function notify:listener()
	local old_tick = 0
	local count_left = 0
	local count_right = 0
	if notify.__list == nil then
		notify:setup()
	end

	for i = 1, #notify.__list do
		local layer = notify.__list[i]
		if layer.tick ~= old_tick then
			notify:setup()
		end

		if layer.right == true then
			layer.invoke:show_right(count_right, layer.color, layer.text)
			if layer.invoke.active then
				count_right = count_right + 1
			end
		else
			layer.invoke:show(count_left, layer.color, layer.text)
			if layer.invoke.active then
				count_left = count_left + 1
			end
		end

		if layer.first == false then
			layer.invoke:start(layer.time)
			notify.__list[i]["first"] = true
		end

		old_tick = layer.tick
	end
end

function notify:start(timeout)
	self.active = true
	self.delay = globals.realtime() + timeout
end

function notify:get_text_size(lines_combo)
	local x_offset_text = 0
	for i = 1, #lines_combo do
		local r, g, b, message = unpack(lines_combo[i])
		local width, height = renderer.measure_text("", message)
		x_offset_text = x_offset_text + width
	end

	return x_offset_text
end

function notify:string_ends_with(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

function notify:multicolor_text(x, y, flags, lines_combo)
	local y_offset = 0
	local x_offset_text = 0
	local line_height_temp = 0
	for i = 1, #lines_combo do
		local r, g, b, message = unpack(lines_combo[i])
		message = message .. "\0"
		surface.draw_text(x + x_offset_text, y + y_offset, r, g, b, 255, bestkim_font, message)
		-- renderer.text(x + x_offset_text, y + y_offset, r, g, b, 255, flags, 0, message)
		if self:string_ends_with(message, "\0") then
			local width, height = surface.get_text_size(bestkim_font, message)
			-- local width, height = renderer.measure_text(flags, message)
			x_offset_text = x_offset_text + width
		else
			x_offset_text = 0
			y_offset = y_offset + line_height_temp
		end
	end
end

function notify:show(count, color, text)
	if self.active ~= true then
		return
	end

	local y = 5 + (27 * count)
	local text_w, text_h = self:get_text_size(text)
	local screen_x, screen_y = client.screen_size()
	local max_width = text_w < 150 and 150 or text_w
	if color == nil then
		color = self.color
	end

	local real_x, real_y = 0, 0
	local factor = 255 / 25 * globals.frametime()
	if globals.realtime() < self.delay then
		if self.laycoffset < max_width then
			self.laycoffset = self.laycoffset + (max_width - self.laycoffset) * factor
		end

		if self.laycoffset > max_width then
			self.laycoffset = max_width
		end

		if self.laycoffset > max_width / 1.09 then
			if self.layboffset < max_width - 6 then
				self.layboffset = self.layboffset + ((max_width - 6) - self.layboffset) * factor
			end
		end

		if self.layboffset > max_width - 6 then
			self.layboffset = max_width - 6
		end
	else
		if self.layboffset > -11 then
			self.layboffset = self.layboffset - (((max_width-5)-self.layboffset) * factor) + 0.01
		end

		if self.layboffset < (max_width - 11) and self.laycoffset >= 0 then
			self.laycoffset = self.laycoffset - (((max_width + 1) - self.laycoffset) * factor) + 0.01
		end

		if self.laycoffset < 0 then 
			self.active = false
		end
	end

	if ui.get(neverlose_hitlog_seat) == "Left Up" then
		real_x, real_y = (self.layboffset - max_width + 14), (y - (y * 0.25))
	elseif ui.get(neverlose_hitlog_seat) == "Left Down" then
		real_x, real_y = (self.layboffset - max_width + 11), screen_y - (y - (y * 0.3)) - 11
	elseif ui.get(neverlose_hitlog_seat) == "Right Up" then
		real_x, real_y = (screen_y * 1.78) - (self.layboffset + 11), (y - (y * 0.3))
	elseif ui.get(neverlose_hitlog_seat) == "Right Down" then
		real_x, real_y = (screen_y * 1.78) - (self.layboffset + 11), screen_y - (y - (y * 0.3)) - 11
	elseif ui.get(neverlose_hitlog_seat) == "Crosshair" then
		real_x, real_y = (self.layboffset - max_width + 765), (y - (y * 0.3) + 750)
	end

	self:multicolor_text(real_x, real_y, "", text)
end

local function neverlose_hit_function(e)
	local attacker_id = client.userid_to_entindex(e.attacker)
	if not multi_select(ui.get(neverlose_hitlog), "Hits Log") or attacker_id == nil or attacker_id ~= entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
		return
	end

	local r, g, b = ui.get(hits_color_c)
	global_hit_numbers = global_hit_numbers + 1
	local target_id = client.userid_to_entindex(e.userid)
	local group = hitboxer_names[e.hitgroup + 1] or "?"
	local target_name = entity.get_player_name(target_id)
	local breaking_pos = entity.get_prop(target_id, "m_flPoseParameter", 11) or 0
	local breaking_angle = math.max(- 60, math.min(60, breaking_pos * 120 - 60 + 0.5)) or "Unknown"
	notify.setup_color({r, g, b})

	local by_dormant_aimbot = false

	for i = 1,#aimtarget_dormant do
		if aimtarget_dormant[i] == target_id then
			by_dormant_aimbot = true
		end
	end

	if by_dormant_aimbot then
		return
	end

	local remain_string = tostring(e.health)
	if e.health <= 0 then
		remain_string = remain_string .. " *击杀*"
	end

	notify.add(5, false,
		{r, g, b, " √ "},
		{r, g, b, "[正常射击]"},
		{0, 255, 0, " 击中"},
		{255, 255, 255,  " " .. string.lower(target_name) .. "" },
		{0, 255, 0,  " 的 " },
		{255, 255, 255,  " " .. group .. ""},
		{0, 255, 0," 造成 " },
		{255, 0, 0,"" .. (e.dmg_health == nil and 0 or e.dmg_health)},
		{255, 255, 255, " 伤害 剩余血量 "},
		{r, g, b, "(".. remain_string .. ")"}
	)
	
	local function clienthitlog()
		return {
			 client.color_log(r, g, b, " √[正常射击] \0"), 
			 client.color_log(0, 255, 0, "击中 \0"), 
			 client.color_log(255, 255, 255,  "" ..string.lower(target_name).." 的 " .. group .." 造成 " .. (e.dmg_health == nil and 0 or e.dmg_health).." 伤害 剩余血量(".. remain_string .. ")"), 
			}	
		end
		local Hittest = clienthitlog()
	print(Hittest)
end
--------------------------------------------------miss log
local function neverlose_missed_function(e)
	if not multi_select(ui.get(neverlose_hitlog), "Miss Log") or e == nil or not entity.is_alive(entity.get_local_player()) then
		return
	end

	local r, g, b = ui.get(missed_color_c)
	local group = hitboxer_names[e.hitgroup + 1] or "?"
	local target_name = entity.get_player_name(e.target)
	global_missed_numbers = global_missed_numbers + 1
	local reason = e.reason == "?" and "resolver" or e.reason
	local breaking_pos = entity.get_prop(e.target, "m_flPoseParameter", 11) or 0
	local breaking_angle = math.max(- 60, math.min(60, breaking_pos * 120 - 60 + 0.5)) or "Unknown"
	local safe_point_state = ui.get(force_safe) and "开" or (plist.get(e.target, "Override safe point") == "-" and "关" or plist.get(e.target, "Override safe point"))
	local flags_state = calculate_flags(e, aimbot_data_count[fired_attack_bullet_id])
	notify.setup_color({r, g, b})
	notify.add(5, false,
		{r, g, b, " × "},
		{r, g, b, "[正常空枪]"},
		{0, 255, 0, " 空了 "},
		{255, 255, 255,  "".. string.lower(target_name) ..""},
		{0, 255, 0,   " 的 " },
		{255, 255, 255,   "".. group .. ""},
		{255, 255, 255,   " 原因: " },
		{0, 255, 0,   "" .. reason},
		{255, 255, 255, " [空枪角度 : " .. math.floor(breaking_angle) .. "° ]"}
		
	)
	local function clientmisslog()
		return {
			 client.color_log(r, g, b, " ×[正常空枪]\0"), 
			 client.color_log(0, 255, 0, " 空了\0"), 
			 client.color_log(0, 255, 0, "\0"), 
			 client.color_log(255, 255, 255,  "" .. string.lower(target_name) .. " 的 " .. group .. " 原因: " .. reason.." [空枪角度 : " .. math.floor(breaking_angle) .. "°]" ), 
			}	
		end
		local misstest = clientmisslog()
	print(misstest)
end

local function e_player_hurt(e)
	if ui.get(menu.dormant_switch) then
		local attacker_id = client.userid_to_entindex(e.attacker)
		if attacker_id == nil then
			return
		end
	
		if attacker_id ~= entity.get_local_player() then
			return
		end

		local target_id = client.userid_to_entindex(e.userid)
		local by_dormant_aimbot = false

		for i = 1,#aimtarget_dormant do
			if aimtarget_dormant[i] == target_id then
				by_dormant_aimbot = true
			end
		end

		if not by_dormant_aimbot then
			return
		end
	
		local hitgroup_names = { "身体", "头部", "胸部", "胃部", "左手臂", "右手臂", "左腿", "右腿", "脖子", "?", "?" }
		local group = hitgroup_names[e.hitgroup + 1] or "?"
		local target_name = entity.get_player_name(target_id)
		local name_string = string.lower(target_name)
		local group_string = group
		local dmged_string = tostring(e.dmg_health)
		local remain_string = tostring(e.health)

			if e.health <= 0 then
				remain_string = remain_string .. " *击杀*"
			end

			local r,g,b,a = ui.get(menu.dormant_log_clr)

			notify.setup_color({r, g, b})
		
			notify.add(5, false,
				{255, 255, 0, "[>休眠射击<]"},
				{0, 255, 0, " 击中"},
				{255, 255, 255,  " " .. string.lower(name_string) .. "" },
				{0, 255, 0,  " 的 " },
				{255, 255, 255,  " " .. group_string .. ""},
				{0, 255, 0," 造成 " },
				{255, 0, 0,"" .. dmged_string },
				{0, 255, 0, " 伤害 剩余血量 ( ".. remain_string .. ")"}
			)

			client.color_log(255, 255, 0, "[>休眠射击<]\0")

			client.color_log(0, 255, 0, " 击中\0")

			client.color_log(255, 255, 255, " ".. name_string .. " 的 " .. group_string .. " 造成 " .. dmged_string .. " 伤害 剩余血量(" .. remain_string .. ")")

		end
end
client.set_event_callback('player_hurt', e_player_hurt)

client.set_event_callback("player_hurt", neverlose_hit_function)
client.set_event_callback("aim_miss", neverlose_missed_function)
local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------





-------
local client_camera_angles, client_create_interface, client_find_signature, client_set_event_callback, entity_get_classname, entity_get_local_player, entity_get_player_weapon, entity_get_prop, string_match, ui_get, error, ui_new_combobox, ui_new_slider = client.camera_angles, client.create_interface, client.find_signature, client.set_event_callback, entity.get_classname, entity.get_local_player, entity.get_player_weapon, entity.get_prop, string.match, ui.get, error, ui.new_combobox, ui.new_slider
local get_cvar, vo_hand, vfov, vo_x, vo_y, vo_z = client.get_cvar, cvar.cl_righthand, cvar.viewmodel_fov, cvar.viewmodel_offset_x, cvar.viewmodel_offset_y, cvar.viewmodel_offset_z
local label = ui.new_label("Lua", "b", '                    =2.Viewmodel=')
local dir, restore = { 'Lua', 'b', 4000, { '-', 'Left hand', 'Right hand' } }

local menu = {
    kpos = ui_new_combobox(dir[1], dir[2], 'Knife positioning', dir[4]),
    fov = ui_new_slider(dir[1], dir[2], 'Viewmodel FOV', -dir[3], dir[3], 0, true, '', 0.01),

    x = ui_new_slider(dir[1], dir[2], 'Viewmodel offset X', -dir[3], dir[3], 0, true, '', 0.01),
    y = ui_new_slider(dir[1], dir[2], 'Viewmodel offset Y', -dir[3], dir[3], 0, true, '', 0.01),
    z = ui_new_slider(dir[1], dir[2], 'Viewmodel offset Z', -dir[3], dir[3], 0, true, '', 0.01),
    roll = ui_new_slider(dir[1], dir[2], 'Viewmodel offset Roll', -180, 180, 0, true),
}

local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")

local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(menu.kpos,false)
		ui.set_visible(menu.fov,false)
		ui.set_visible(menu.x,false)
		ui.set_visible(menu.y,false)
		ui.set_visible(menu.z,false)
		ui.set_visible(menu.roll,false)
	
    else
        ui.set_visible(menu.kpos,true)
		ui.set_visible(menu.fov,true)
		ui.set_visible(menu.x,true)
		ui.set_visible(menu.y,true)
		ui.set_visible(menu.z,true)
		ui.set_visible(menu.roll,true)

    end

end

client_set_event_callback("paint",HIDE_MEAN)

local ffi, bit = require 'ffi', require 'bit'
local ffi_to = {
    classptr = ffi.typeof('void***'), 
    client_entity = ffi.typeof('void*(__thiscall*)(void*, int)'),
    
    set_angles = (function()
        ffi.cdef('typedef struct { float x; float y; float z; } vmodel_vec3_t;')

        return ffi.typeof('void(__thiscall*)(void*, const vmodel_vec3_t&)')
    end)()
}

local rawelist = client_create_interface('client_panorama.dll', 'VClientEntityList003') or error('VClientEntityList003 is nil', 2)
local ientitylist = ffi.cast(ffi_to.classptr, rawelist) or error('ientitylist is nil', 2)
local get_client_entity = ffi.cast(ffi_to.client_entity, ientitylist[0][3]) or error('get_client_entity is nil', 2)

local set_angles = client_find_signature('client_panorama.dll', '\x55\x8B\xEC\x83\xE4\xF8\x83\xEC\x64\x53\x56\x57\x8B\xF1') or error('Couldn\'t find set_angles signature!')
local set_angles_fn = ffi.cast(ffi_to.set_angles, set_angles) or error('Couldn\'t cast set_angles_fn')

local get_original = function()
    return {
        rhand = get_cvar('cl_righthand'),
        fov = get_cvar('viewmodel_fov'),
        
        x = get_cvar('viewmodel_offset_x'),
        y = get_cvar('viewmodel_offset_y'),
        z = get_cvar('viewmodel_offset_z')
    }
end

local g_handler = function(...)
    local shutdown = #({...}) > 0

    local multiplier = shutdown and 0 or 0.0025
    local original, data = get_original(), 
    {
        rhand = ui_get(menu.kpos),
        fov = ui_get(menu.fov) * multiplier,
        x = ui_get(menu.x) * multiplier,
        y = ui_get(menu.y) * multiplier,
        z = ui_get(menu.z) * multiplier
    }

    vfov:set_raw_float(original.fov + data.fov)
    vo_x:set_raw_float(original.x + data.x)
    vo_y:set_raw_float(original.y + data.y)
    vo_z:set_raw_float(original.z + data.z)

    vo_hand:set_raw_int(original.rhand)

    if not shutdown and data.rhand ~= dir[4][1] then
        local is_holding_knife = false
        local me = entity_get_local_player()
        local wpn = entity_get_player_weapon(me)
    
        if me ~= nil and wpn ~= nil then
            is_holding_knife = string_match((entity_get_classname(wpn) or ''), 'Knife')
        end
    
        vo_hand:set_raw_int((
            {
                [dir[4][2]] = is_holding_knife and 0 or 1,
                [dir[4][3]] = is_holding_knife and 1 or 0,
            }
        )[data.rhand])
    end
end

local g_override_view = function()
    --[[
        Credits: 
        * tank (rave1337): proper viewmodel roll
    ]]

    local me = entity_get_local_player()
    local viewmodel = entity_get_prop(me, 'm_hViewModel[0]')

    if me == nil or viewmodel == nil then
        return
    end

    local viewmodel_ent = get_client_entity(ientitylist, viewmodel)

    if viewmodel_ent == nil then
        return
    end

    local camera_angles = { client_camera_angles() }
    local angles = ffi.cast('vmodel_vec3_t*', ffi.new('char[?]', ffi.sizeof('vmodel_vec3_t')))

    angles.x, angles.y, angles.z = 
        camera_angles[1], camera_angles[2], ui_get(menu.roll)

    set_angles_fn(viewmodel_ent, angles)
end


client_set_event_callback('pre_render', g_handler)
client_set_event_callback('override_view', g_override_view)
client_set_event_callback('shutdown', function() g_handler(true) end)

local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')



