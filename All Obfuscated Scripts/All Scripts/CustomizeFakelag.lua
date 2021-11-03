--[[
	id: AJxeQrPeB5_oNC1fEQk_w
	name: Customize Fakelag
	description: Customize Fakelag
	time1: 2021-05-04 05:40:23.0093+00
	time2: 2021-05-04 05:40:23.0093+00
	uploader: 1928
	uploadersession: DLGgUHrAc4FzPyeougySgWEmSoT4iM
	flag: f
--]]

local fakelag_enabled = ui.new_checkbox("AA", "Fake lag", "Enabled Hana Fakelag")
local fakelag_types = ui.new_combobox("AA", "Fake lag", "Fakelag Types", {"Gamesense", "Boost Fakelag"})
local amount_mode = ui.new_combobox("AA", "Fake lag", "Fakelag Amount", {"Dynamic", "Maximum", "Fluctuate"})
local variance_slider = ui.new_slider("AA", "Fake lag", "Fakelag Variance", 0, 100, 0, true, "%")
local fakelag_limit = ui.new_slider("AA", "Fake lag", " Fakelag Limit", 1, 16, 13, true)
local fakelag_fluctuate_limit = ui.new_slider("AA", "Fake lag", " Fakelag Fluctuate Limit", 1, 16, 1, true)
local variance_mode = ui.new_combobox("AA", "Fake lag", "Fakelag Variance Types", "Random", "Fluctuate")
local boost_mode = ui.new_combobox("AA", "Fake lag", "Fakelag Boost Amount", {"Adaptive", "Cycle Fakelag", "Test Factor", "Dynamic", "Maximum", "Fluctuate", "Normal Random", "Breaking Random", "Static Random", "Alternative", "Jitter Maximum", "Distance Step", "Safety Fakelag", "Shooting Fakelag", "Reset Fakelag", "Breaking Factor"})
local boost_normal_limit = ui.new_slider("AA", "Fake lag", "Boost Normal Limit", 1, 16, 1, true)
local boost_condition = ui.new_multiselect("AA", "Fake lag", "Boost Alternative Condition", {"Standing", "Moving", "Slow Walk", "Jumping", "Crouching"})
local boost_choke_types = ui.new_combobox("AA", "Fake lag", "Boost Alternative Choked Types", {"Alternative Force Factor", "Alternative Force Jitter", "Alternative Force OneTap V2"})
local boost_send_limit = ui.new_slider("AA", "Fake lag", "Boost Send Limit", 1, 16, 1, true)
local boost_choke_limit = ui.new_slider("AA", "Fake lag", "Boost Choked Limit", 1, 16, 1, true)
local boost_triggers = ui.new_multiselect("AA", "Fake lag", "Boost Trigger Condition", {"Jumping", "On Peeking", "On Shot", "On Land"})
local boost_triggers_jump = ui.new_slider("AA", "Fake lag", "Boost Trigger Jumping Limit", 1, 16, 15, true)
local boost_triggers_peek = ui.new_slider("AA", "Fake lag", "Boost Trigger Peeking Limit", 1, 16, 15, true)
local boost_triggers_shot = ui.new_slider("AA", "Fake lag", "Boost Trigger Shooting Limit", 1, 16, 1, true)
local boost_triggers_land = ui.new_slider("AA", "Fake lag", "Boost Trigger Land Limit", 1, 16, 13, true)
local fakelag_slider_trigger = ui.new_multiselect("AA", "Fake lag", "Fakelag Limit Trigger", {"Avoid Standing Limit", "Avoid Aerial Limit", "Avoid Fired Limit", "Avoid Wall Peek", "Avoid Visible Peek"})
local trigger_standing_limit = ui.new_slider("AA", "Fake lag", "Aerial Limit[Standing]", 1, 16, 3, true)
local trigger_aerial_limit = ui.new_slider("AA", "Fake lag", "Aerial Limit[Jumping]", 1, 16, 15, true)
local trigger_fired_limit = ui.new_slider("AA", "Fake lag", "Fired Limit[Shooting]", 1, 16, 1, true)
local trigger_wall_limit = ui.new_slider("AA", "Fake lag", "Peek Limit[Avoid Wall]", 1, 16, 15, true)
local trigger_visible_limit = ui.new_slider("AA", "Fake lag", "Peek Limit[Avoid Visible]", 1, 16, 16, true)
local fakelag_trigger_enabled = ui.new_checkbox("AA", "Fake lag", "Customized Fakelag Triggers")
local fakelag_tick_always_types = ui.new_combobox("AA", "Fake lag", "Fakelag Server Packet Types", {"Maximum Packet", "Dynamic Packet"})
local fakelag_trigger_types = ui.new_combobox("AA", "Fake lag", "Fakelag Trigger Types", {"Fakelag Limit Trigger", "Fakelag Send Packet Trigger"})
local fakelag_send_packet_trigger = ui.new_multiselect("AA", "Fake lag", "Fakelag Triggers Settings", {"On Standing", "While Moving", "On Duck", "On High Speed", "On Jump", "On Exploit", "On Use", "On Freezetime", "Weapon Switch", "Weapon Reload", "Weapon Fired", "On Land", "While Climbing Ladder"})
local fakelag_limit_trigger_limit = ui.new_slider("AA", "Fake lag", "Fakelag Limit Trigger Not Select Flags Limit", 1, 16, 3, true)
local lagcomp_break = ui.new_checkbox("AA", "Fake lag", "Fakelag Break Lag Compstation")
local distance_value_condition = ui.new_slider("AA", "Fake lag", "Override Distance Value", - 5, 1000, 0, true)

local limit = ui.reference("AA", "Fake lag", "Limit")
local amount = ui.reference("AA", "Fake lag", "Amount")
local variance = ui.reference("AA", "Fake lag", "Variance")
local ref_fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
local slow_walk, slow_hotkey =  ui.reference("AA", "Other", "Slow motion")
local on_shot, on_shot_hotkey = ui.reference("AA", "Other", "On shot anti-aim")
local double_tap, double_tap_hotkey = ui.reference("RAGE", "Other", "Double tap")
local fakelag_urmaxprocess = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

local end_time = 0
local is_land = false
local factor_limit = 1
local ground_ticks = 1
local directionadd = 0
local choke_system = 1
local noenemies = false
local LEFT, RIGHT = 1, 2
local aadirection = "LEFT"
local stored_target = false
local aadirection = "BACK"
local flags_on_land = false
local boost_fakelag_limit = 1
local SYR_State = "SYR-Default"
local syr_weapon_visible = false
local last_manual_presstime = 0
local trigger_send_packet = true
local allow_packet_trigger = true
local fakelag_limit_trigget_status = 3
local delay_correct = globals.tickcount()
local boost_fakelag_amount = "Maximum"

local lag_info = {
    current_phase = 1,
    prev_choked = 15
}

local lag_amount = {{
    variance = 0,
    limit = 13,
    break_lagcomp = true,
    amount = "Dynamic"
},

{
    variance = 0,
    limit = 13,
    break_lagcomp = false,
    amount = "Dynamic"
}}

local weapons_disabled = {
    "CKnife",
    "CWeaponTaser",
    "CC4",
    "CHEGrenade",
    "CSmokeGrenade",
    "CMolotovGrenade",
    "CSensorGrenade",
    "CFlashbang",
    "CDecoyGrenade",
    "CIncendiaryGrenade"
}

local cache = { }
local data = {
    threshold = false,
    stored_last_shot = 0,
    stored_item = 0
}

local function resert_fakelag_data(e)
	choke_system = 1
end

local function multi_select(tab, val, sys)
	for index, value in ipairs(tab) do
		if sys == 1 and index == val then
			return true
		elseif value == val then
			return true
		end
	end

	return false
end

local function vec_3(_x, _y, _z)
	return {x = _x or 0, y = _y or 0, z = _z or 0}
end

local function ticks_to_time(ticks)
	return globals.tickinterval() * ticks
end

local function GetDistanceInMeter(a_x, a_y, a_z, b_x, b_y, b_z)
	return math.ceil(math.sqrt(math.pow(a_x - b_x, 2) + math.pow(a_y - b_y, 2) + math.pow(a_z - b_z, 2)) * 0.0254)
end

local function player_will_peek(e)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) then
		return
	end

	local enemies = entity.get_players(true)
	if not enemies then
		return false
	end

	local eye_position = vec_3(client.eye_position())
	local velocity_prop_local = vec_3( entity.get_prop(entity.get_local_player(), "m_vecVelocity"))
	local predicted_eye_position = vec_3( eye_position.x + velocity_prop_local.x * ticks_to_time(16), eye_position.y + velocity_prop_local.y * ticks_to_time(16), eye_position.z + velocity_prop_local.z * ticks_to_time(16))

	for i = 1, #enemies do
		local player = enemies[i]
		local velocity_prop = vec_3(entity.get_prop(player, "m_vecVelocity"))
		local origin = vec_3(entity.get_prop(player, "m_vecOrigin"))
		local predicted_origin = vec_3(origin.x + velocity_prop.x * ticks_to_time(16), origin.y + velocity_prop.y * ticks_to_time(16), origin.z + velocity_prop.z * ticks_to_time(16))
		entity.get_prop(player, "m_vecOrigin", predicted_origin)
		local head_origin = vec_3(entity.hitbox_position(player, 0))
		local predicted_head_origin = vec_3( head_origin.x + velocity_prop.x * ticks_to_time(16), head_origin.y + velocity_prop.y * ticks_to_time(16), head_origin.z + velocity_prop.z * ticks_to_time(16))
		local trace_entity, damage = client.trace_bullet( entity.get_local_player(), predicted_eye_position.x, predicted_eye_position.y, predicted_eye_position.z, predicted_head_origin.x, predicted_head_origin.y, predicted_head_origin.z)
		entity.get_prop(player, "m_vecOrigin", origin)

		if damage > 0 then
			return true
		end
	end

	return false
end


local function vec2_distance(f_x, f_y, t_x, t_y)
	local delta_x, delta_y = f_x - t_x, f_y - t_y
	return math.sqrt(delta_x*delta_x + delta_y*delta_y)
end

local function get_all_player_positions(ctx, screen_width, screen_height, enemies_only)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) then
		return
	end

	local player_indexes = {}
	local player_positions = {}
	local players = entity.get_players(enemies_only)

	if #players == 0 then
		return
	end

	for i=1, #players do
		local player = players[i]
		local px, py, pz = entity.get_prop(player, "m_vecOrigin")
		local vz = entity.get_prop(player, "m_vecViewOffset[2]")
		if pz ~= nil and vz ~= nil then
		pz = pz + (vz*0.5)

		local sx, sy = client.world_to_screen(ctx, px, py, pz)
			if sx ~= nil and sy ~= nil then
				if sx >= 0 and sx <= screen_width and sy >= 0 and sy <= screen_height then 
					player_indexes[#player_indexes+1] = player
					player_positions[#player_positions+1] = {sx, sy}
				end
			end
		end
	end
		return player_indexes, player_positions
	end

local function check_fov(ctx)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) then
		return
	end

	local screen_width, screen_height = client.screen_size()
	local screen_center_x, screen_center_y = screen_width*0.5, screen_height*0.5
	local fov_limit = 250
	
	if get_all_player_positions(ctx, screen_width, screen_height, true) == nil then
		return
	end

	local enemy_indexes, enemy_coords = get_all_player_positions(ctx, screen_width, screen_height, true)
	if #enemy_indexes <= 0 then
		return true
	end

	if #enemy_coords == 0 then
		return true
	end

	local closest_fov = 133337
	local closest_entindex = 133337

	for i=1, #enemy_coords do
		local x = enemy_coords[i][1]
		local y = enemy_coords[i][2]
		local current_fov = vec2_distance(x, y, screen_center_x, screen_center_y)

		if current_fov < closest_fov then
			closest_fov = current_fov
			closest_entindex = enemy_indexes[i]
		end
	end
		return closest_fov > fov_limit, closest_entindex
	end

local function can_see(ent)	
	for i=0, 18 do
		if client.visible(entity.hitbox_position(ent, i)) then
			return true
		end
	end
		return false
	end

local function syr_visible_enemy(ctx)
	local local_entindex = entity.get_local_player()
	if entity.get_prop(local_entindex, "m_lifeState") ~= 0 then	
		syr_weapon_visible = false
		return
	end
	
	local enemy_visible, enemy_entindex = check_fov(ctx)
	if enemy_entindex == nil then
		return
	end
	
	if enemy_visible and enemy_entindex ~= nil and stored_target ~= enemy_entindex then
		stored_target = enemy_entindex
	end

	local visible = can_see(enemy_entindex)
	syr_weapon_visible = visible and true or false
	stored_target = enemy_entindex
	local enemy_player_number = entity.get_players(true)
end

client.set_event_callback("paint",syr_visible_enemy)

client.set_event_callback("weapon_fire", function(e)
	local localplayer = entity.get_local_player()
	if not localplayer or not entity.is_alive(localplayer) or not client.userid_to_entindex(e.userid) == localplayer then
		return
	end

	flags_weapon_reload = true
	client.delay_call(0.45, function(reload)
		flags_weapon_reload = false
	end)
end)

local function status_lag_shift(e)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) or not ui.get(fakelag_enabled) or not ui.get(fakelag_types) == "Gamesense" then
		return
	end

	if ui.get(fakelag_urmaxprocess) <= 18 then
		ui.set(fakelag_urmaxprocess, 18)
	end

	local vx, vy, vz = entity.get_prop(local_player, "m_vecVelocity")
	local velocity_speed = math.sqrt((vx * vx) + (vy * vy))
	local player_move_type = entity.get_prop(local_player, "m_movetype")
	local flags_status = entity.get_prop(local_player, "m_fFlags")
	local flags_climbing_adder = player_move_type == 9
	local can_fire_wall = player_will_peek()

	if ui.get(amount_mode) == "Dynamic" then
		lag_new_amo = "Dynamic"
		lag_get_limit = - ui.get(variance_slider) * 0.01
		lag_variance_limit = - lag_get_limit * ui.get(fakelag_limit)
		lag_variance_fixer = lag_variance_limit <= 0 and lag_variance_limit or lag_variance_limit
		lag_variance_status = ui.get(variance_mode) == "Random" and math.random(ui.get(fakelag_limit) - lag_variance_fixer, ui.get(fakelag_limit)) or ui.get(fakelag_limit) - ui.get(variance_slider) * 0.01 * ui.get(fakelag_limit)
		lag_first_limit = lag_variance_status
		lag_two_limit = ui.get(fakelag_limit)
	elseif ui.get(amount_mode) == "Maximum" then
		lag_new_amo = "Maximum"
		lag_get_limit = - ui.get(variance_slider) * 0.01
		lag_variance_limit = - lag_get_limit * ui.get(fakelag_limit)
		lag_variance_fixer = lag_variance_limit <= 0 and lag_variance_limit or lag_variance_limit
		lag_variance_status = ui.get(variance_mode) == "Random" and math.random(ui.get(fakelag_limit) - lag_variance_fixer, ui.get(fakelag_limit)) or ui.get(fakelag_limit) - ui.get(variance_slider) * 0.01 * ui.get(fakelag_limit)
		lag_first_limit = lag_variance_status
		lag_two_limit = ui.get(fakelag_limit)
	elseif ui.get(amount_mode) == "Fluctuate" then
		lag_new_amo = "Fluctuate"
		lag_get_limit = - ui.get(variance_slider) * 0.01
		lag_variance_limit = - lag_get_limit * ui.get(fakelag_limit)
		lag_variance_fixer = lag_variance_limit <= 0 and lag_variance_limit or lag_variance_limit
		lag_variance_status = ui.get(variance_mode) == "Random" and math.random(ui.get(fakelag_limit) - lag_variance_fixer, ui.get(fakelag_limit)) or ui.get(fakelag_limit) - ui.get(variance_slider) * 0.01 * ui.get(fakelag_limit)
		lag_first_limit = lag_variance_status
		lag_two_limit = ui.get(fakelag_fluctuate_limit)
	end

	if multi_select(ui.get(fakelag_slider_trigger), "Avoid Standing Limit") and velocity_speed < 5 then
		lag_first_limit = ui.get(amount_mode) == "Fluctuate" and ui.get(fakelag_fluctuate_limit) or ui.get(trigger_standing_limit)
		lag_two_limit = ui.get(trigger_standing_limit)
	else
		lag_first_limit = lag_first_limit < 1 and 1 or lag_first_limit
		lag_two_limit = lag_two_limit < 1 and 1 or lag_two_limit
	end

	if multi_select(ui.get(fakelag_slider_trigger), "Avoid Wall Peek") and can_fire_wall == true and syr_weapon_visible == false and velocity_speed > 5 then
		lag_first_limit = ui.get(amount_mode) == "Fluctuate" and ui.get(fakelag_fluctuate_limit) or ui.get(trigger_wall_limit)
		lag_two_limit = ui.get(trigger_wall_limit)
	else
		lag_first_limit = lag_first_limit < 1 and 1 or lag_first_limit
		lag_two_limit = lag_two_limit < 1 and 1 or lag_two_limit
	end

	if multi_select(ui.get(fakelag_slider_trigger), "Avoid Visible Peek") and syr_weapon_visible == true and velocity_speed > 5 then
		lag_first_limit = ui.get(amount_mode) == "Fluctuate" and ui.get(fakelag_fluctuate_limit) or ui.get(trigger_visible_limit)
		lag_two_limit = ui.get(trigger_visible_limit)
	else
		lag_first_limit = lag_first_limit < 1 and 1 or lag_first_limit
		lag_two_limit = lag_two_limit < 1 and 1 or lag_two_limit
	end

	if multi_select(ui.get(fakelag_slider_trigger), "Avoid Aerial Limit") and flags_status == 256 and not flags_climbing_adder and velocity_speed > 5 then
		lag_first_limit = ui.get(amount_mode) == "Fluctuate" and ui.get(fakelag_fluctuate_limit) or ui.get(trigger_aerial_limit)
		lag_two_limit = ui.get(trigger_aerial_limit)
	else
		lag_first_limit = lag_first_limit < 1 and 1 or lag_first_limit
		lag_two_limit = lag_two_limit < 1 and 1 or lag_two_limit
	end


	local lag_break_choke = ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative" and ui.get(boost_choke_types) == "Alternative Force Jitter"
	local lag_break_choke_otc_v2 = ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative" and ui.get(boost_choke_types) == "Alternative Force OneTap V2"
	lag_amount = {{
		variance = 0,
		limit = lag_first_limit,
		break_lagcomp = lag_break_choke_otc_v2 and false or true,
		amount = lag_new_amo
	},
	{
		variance = 0,
		limit = lag_two_limit,
		break_lagcomp = false,
		amount = lag_new_amo
	},
	{
		variance = 0,
		limit = lag_first_limit,
		break_lagcomp = lag_break_choke_otc_v2 and false or not lag_break_choke,
		amount = lag_new_amo
	},
	{
		variance = 0,
		limit = lag_two_limit,
		break_lagcomp = lag_break_choke_otc_v2 and true or lag_break_choke,
		amount = lag_new_amo
	}}
end

client.set_event_callback("setup_command", status_lag_shift)

client.set_event_callback("predict_command", function(e)
	local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1)
	if on_ground == 1 then
		ground_ticks = ground_ticks + 1
	else
		ground_ticks = 0
		end_time = globals.curtime() + 1
	end
    
	if ground_ticks > ui.get(limit) + 1 and end_time > globals.curtime() then
    		is_land = true
		return
	end

    	is_land = false
end)

local function boost_fakelag(cmd)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) or not ui.get(fakelag_enabled) or ui.get(fakelag_types) == "Gamesense" then
		return
	end

	if ui.get(fakelag_urmaxprocess) <= 18 then
		ui.set(fakelag_urmaxprocess, 18)
	end

	local vx, vy, vz = entity.get_prop(local_player, "m_vecVelocity")
	local velocity_speed = math.sqrt((vx * vx) + (vy * vy))
	local onground = (bit.band(entity.get_prop(local_player, "m_fFlags"), 1) == 1)
	local infiniteduck = (bit.band(entity.get_prop(local_player, "m_fFlags"), 2) == 2)
	local weapon = entity.get_player_weapon(local_player)
	local slowwalking = ui.get(slow_walk) and ui.get(slow_hotkey)
	if velocity_speed < 5 and not slowwalking and onground and not infiniteduck then 
		player_flags = "Standing"
	elseif velocity_speed > 2 and not slowwalking and onground and not infiniteduck then
		player_flags = "Moving"
	elseif velocity_speed > 2 and slowwalking and onground and not infiniteduck then
		player_flags = "Slow Walk"
	elseif onground and infiniteduck then
		player_flags = "Crouching"
	elseif not onground then
		player_flags = "Jumping"
	end

	if ui.get(boost_mode) == "Adaptive" then
		if player_flags == "Standing" then
			boost_limit = ui.get(lagcomp_break) and 3 or 1
		elseif player_flags == "Moving" then
			boost_limit = ui.get(boost_normal_limit)
		elseif player_flags == "Slow Walk" then
			boost_limit = math.max(1, ui.get(boost_normal_limit) - 1)
		elseif player_flags == "Crouching" and velocity_speed < 5 then
			boost_limit = ui.get(lagcomp_break) and 3 or 5
		elseif player_flags == "Crouching" and velocity_speed >= 5 then
			boost_limit = math.max(1, ui.get(boost_normal_limit) - (velocity_speed / 25))
		elseif player_flags == "Jumping" and velocity_speed < 5 then
			boost_limit = ui.get(lagcomp_break) and 14 or 13
		elseif player_flags == "Jumping" and velocity_speed >= 5 then
			boost_limit = 15
		end

		boost_amount = player_flags == "Standing" and "Maximum" or boost_limit > 13 and "Maximum" or "Dynamic"
	elseif ui.get(boost_mode) == "Cycle Fakelag" then
		local players = entity.get_players(true)
		for i = 1, #players do
			client.update_player_list()
			local player = players[i]
			local local_player_origin = {x, y, z}
			local enemy_origin = {x, y, z}
			local_player_origin.x, local_player_origin.y, local_player_origin.z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
			enemy_origin.x, enemy_origin.y, enemy_origin.z = entity.get_prop(player, "m_vecOrigin")
			distance_value = GetDistanceInMeter(local_player_origin.x, local_player_origin.y, local_player_origin.z, enemy_origin.x, enemy_origin.y, enemy_origin.z)
			ui.set(distance_value_condition, distance_value)
		end

		boost_amount = player_flags == "Standing" and "Maximum" or "Dynamic"
		boost_cycle_lag = player_flags == "Standing" and 3 or ui.get(distance_value_condition) <= 5 and 14 or math.max(1, (velocity_speed / 200 * 13) > 13 and math.random(13, 14) or (velocity_speed / 200 * 13))
		boost_limit = ui.get(lagcomp_break) and boost_cycle_lag or ui.get(boost_normal_limit)
	elseif ui.get(boost_mode) == "Test Factor" then
		boost_amount = "Maximum"
		local weapons = entity.get_player_weapon(local_player)
		local next_attack = entity.get_prop(weapons, "m_flNextPrimaryAttack")
		local tickbase_shift = entity.get_prop(local_player, "m_nTickBase")
		local fired_shoot = next_attack <= tickbase_shift * globals.tickinterval() - 0.12
		boost_limit = player_flags == "Standing" and 3 or fired_shoot and ui.get(boost_normal_limit) or ui.get(lagcomp_break) and 16 or 15
	elseif ui.get(boost_mode) == "Dynamic" then
		boost_limit = player_flags == "Standing" and 3 or ui.get(lagcomp_break) and ui.get(boost_normal_limit) or math.max(1, ui.get(boost_normal_limit) - 1)
		boost_amount = player_flags == "Standing" and "Maximum" or ui.get(lagcomp_break) and "Maximum" or "Dynamic"
	elseif ui.get(boost_mode) == "Maximum" then
		boost_amount = "Maximum"
		boost_limit = ui.get(lagcomp_break) and math.max(1, ui.get(boost_normal_limit) - 1) or ui.get(boost_normal_limit)
	elseif ui.get(boost_mode) == "Fluctuate" then
		boost_amount = "Dynamic"
		boost_limit = ui.get(lagcomp_break) and 1 or ui.get(boost_normal_limit)
	elseif ui.get(boost_mode) == "Normal Random" then
		boost_amount = "Maximum"
		boost_limit = math.random(1, ui.get(boost_normal_limit))
	elseif ui.get(boost_mode) == "Breaking Random" then
		boost_amount = "Maximum"
		boost_limit = ui.get(lagcomp_break) and ui.get(boost_normal_limit) or math.random(1, ui.get(boost_normal_limit))
	elseif ui.get(boost_mode) == "Static Random" then
		if cmd.chokedcommands == ui.get(boost_normal_limit) - 1 then
			boost_limit = math.random(1, ui.get(boost_normal_limit))
		elseif cmd.chokedcommands < ui.get(boost_normal_limit) + 1 then 
			boost_limit = math.max(1, math.random(ui.get(boost_normal_limit) - 1, ui.get(boost_normal_limit)))
		end

		boost_amount = "Dynamic"
	elseif ui.get(boost_mode) == "Distance Step" then
		local players = entity.get_players(true)
		for i = 1, #players do
			client.update_player_list()
			local player = players[i]
			local local_player_origin = {x, y, z}
			local enemy_origin = {x, y, z}
			local_player_origin.x, local_player_origin.y, local_player_origin.z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
			enemy_origin.x, enemy_origin.y, enemy_origin.z = entity.get_prop(player, "m_vecOrigin")
			distance_value = GetDistanceInMeter(local_player_origin.x, local_player_origin.y, local_player_origin.z, enemy_origin.x, enemy_origin.y, enemy_origin.z)
			ui.set(distance_value_condition, distance_value)
		end

		boost_limit = ui.get(distance_value_condition) <= 5 and ui.get(boost_normal_limit) or math.max(1, 15 - ui.get(distance_value_condition))
		boost_amount = "Dynamic"
	elseif ui.get(boost_mode) == "Alternative" then
		boost_amount = "Maximum"
		local boost_send_overlap = ui.get(boost_send_limit) == 1 and ui.get(boost_choke_limit) or ui.get(boost_send_limit) - 1
		if multi_select(ui.get(boost_condition), "Standing") and player_flags == "Standing" then
			boost_limit = ui.get(lagcomp_break) and boost_send_overlap or ui.get(boost_choke_limit)
		elseif multi_select(ui.get(boost_condition), "Moving") and player_flags == "Moving" then
			boost_limit = ui.get(lagcomp_break) and boost_send_overlap or ui.get(boost_choke_limit)
		elseif multi_select(ui.get(boost_condition), "Slow Walk") and player_flags == "Slow Walk" then
			boost_limit = ui.get(lagcomp_break) and boost_send_overlap or ui.get(boost_choke_limit)
		elseif multi_select(ui.get(boost_condition), "Jumping") and player_flags == "Jumping" then
			boost_limit = ui.get(lagcomp_break) and boost_send_overlap or ui.get(boost_choke_limit)
		elseif multi_select(ui.get(boost_condition), "Crouching") and player_flags == "Crouching" then
			boost_limit = ui.get(lagcomp_break) and boost_send_overlap or ui.get(boost_choke_limit)
		else
			boost_limit = ui.get(boost_normal_limit)
		end

	elseif ui.get(boost_mode) == "Jitter Maximum" then
		boost_amount = "Maximum"
		boost_limit = ui.get(lagcomp_break) and math.random(3, 6) or ui.get(boost_normal_limit)
	elseif ui.get(boost_mode) == "Safety Fakelag" then
		boost_amount = "Maximum"
		boost_limit = player_will_peek() == true and ui.get(boost_normal_limit) or ui.get(lagcomp_break) and 3 or 1
	elseif ui.get(boost_mode) == "Shooting Fakelag" then
		local weapons = entity.get_player_weapon(local_player)
		local next_attack = entity.get_prop(weapons, "m_flNextPrimaryAttack")
		local tickbase_shift = entity.get_prop(local_player, "m_nTickBase")
		local fired_shoot = next_attack <= tickbase_shift * globals.tickinterval() - 0.12
		boost_amount = "Maximum"
		boost_limit = player_flags == "Standing" and 3 or fired_shoot and 1 or ui.get(boost_normal_limit)
	elseif ui.get(boost_mode) == "Reset Fakelag" then
		if cmd.chokedcommands == 0 then
			choke_system = choke_system + 1
		end

		if choke_system == (ui.get(boost_normal_limit) + 1) then
			resert_fakelag_data(e)
		end

		boost_amount = "Maximum"
		boost_limit = player_flags == "Standing" and 3 or math.min(16, choke_system)

	elseif ui.get(boost_mode) == "Breaking Factor" then
		if cmd.chokedcommands == 0 then
			factor_limit = factor_limit + 1
		end

		if factor_limit == 31 then
			factor_limit = 1
		end

		local factor_table = {[1] = ui.get(boost_normal_limit), [2] = 1, [3] = ui.get(boost_normal_limit), [4] = 2, [5] = ui.get(boost_normal_limit), [6] = 3, [7] = ui.get(boost_normal_limit), [8] = 4, [9] = ui.get(boost_normal_limit), [10] = 5, [11] = ui.get(boost_normal_limit), [12] = 6, [13] = ui.get(boost_normal_limit), [14] = 7, [15] = ui.get(boost_normal_limit), [16] = 8, [17] = ui.get(boost_normal_limit), [18] = 9, [19] = ui.get(boost_normal_limit), [20] = 10, [21] = ui.get(boost_normal_limit), [22] = 11, [23] = ui.get(boost_normal_limit), [24] = 12, [25] = ui.get(boost_normal_limit), [26] = 13, [27] = ui.get(boost_normal_limit), [28] = 14, [29] = ui.get(boost_normal_limit), [30] = 15}
		boost_amount = "Maximum"
		boost_limit = player_flags == "Standing" and 3 or factor_table[factor_limit]
	end

	local boost_fakelag_limit = boost_limit
	local boost_fakelag_amount = boost_amount
	if multi_select(ui.get(boost_triggers), "Jumping") and player_flags == "Jumping" and ui.get(boost_mode) == "Alternative" then
		boost_fakelag_amount = "Maximum"
		boost_fakelag_limit = ui.get(boost_triggers_jump)
	end

	if multi_select(ui.get(boost_triggers), "On Peeking") and player_will_peek() == true and ui.get(boost_mode) == "Alternative" then
		boost_fakelag_amount = "Maximum"
		boost_fakelag_limit = ui.get(boost_triggers_peek)
	end

	if multi_select(ui.get(boost_triggers), "On Land") and is_land == true and ui.get(boost_mode) == "Alternative" then
		boost_fakelag_amount = "Maximum"
		boost_fakelag_limit = ui.get(boost_triggers_land)
	end

	ui.set(variance, 0)
	ui.set(amount, ui.get(ref_fakeduck) and "Maximum" or boost_fakelag_amount)
	ui.set(limit, ui.get(ref_fakeduck) and 15 or math.max(1, boost_fakelag_limit) > 16 and 16 or math.max(1, boost_fakelag_limit))
end

client.set_event_callback("setup_command", boost_fakelag)

client.set_event_callback("setup_command", function(cmd)
	local localplayer = entity.get_local_player()
	if not localplayer or not entity.is_alive(localplayer) or not ui.get(fakelag_enabled) or not ui.get(fakelag_trigger_enabled) then
		return
	end

	local flags_weapon_switch = cmd.weaponselect
	local flags_on_use = cmd.in_use
	local trigger_choked = cmd.chokedcommands
	local vx, vy, vz = entity.get_prop(localplayer, "m_vecVelocity")
	local velocity_speed = math.sqrt((vx * vx) + (vy * vy))
	local onground = (bit.band(entity.get_prop(localplayer, "m_fFlags"), 1) == 1)
	local infiniteduck = (bit.band(entity.get_prop(localplayer, "m_fFlags"), 2) == 2)
	local slowwalking = ui.get(slow_walk) and ui.get(slow_hotkey)
	local exploit = ui.get(on_shot) and ui.get(on_shot_hotkey) or ui.get(double_tap) and ui.get(double_tap_hotkey) or ui.get(ref_fakeduck)
	local weapons = entity.get_player_weapon(localplayer)
	local next_attack = entity.get_prop(weapons, "m_flNextPrimaryAttack")
	local tickbase_shift = entity.get_prop(localplayer, "m_nTickBase")
	local fired_shoot = next_attack <= tickbase_shift * globals.tickinterval() - 0.12
	local in_freeze_time = entity.get_prop(entity.get_game_rules(), "m_bFreezePeriod") == 1
	local player_move_type = entity.get_prop(localplayer, "m_movetype")
	local flags_climbing_adder = player_move_type == 9

	local flags_on_land = false
	if not onground then
		client.delay_call(0.75, function(land)
			flags_on_land = true
		end)

		client.delay_call(0.9, function(land)
			flags_on_land = false
		end)
	end

	if velocity_speed < 5 and not slowwalking and onground and not infiniteduck and velocity_speed < 190 and not exploit and fired_shoot == true and flags_on_use == 0 and not in_freeze_time and flags_weapon_switch <= 0 and flags_on_land == false and not flags_climbing_adder then 
		SYR_State = "SYR-Default"
	elseif velocity_speed > 2 and not slowwalking and onground and not infiniteduck and velocity_speed < 190 and not exploit and fired_shoot == true and flags_on_use == 0 and not in_freeze_time and flags_weapon_switch <= 0 and flags_on_land == false and not flags_climbing_adder then
		SYR_State = "SYR-Running"
	elseif velocity_speed > 2 and slowwalking and onground and not infiniteduck and velocity_speed < 190 and not exploit and fired_shoot == true and flags_on_use == 0 and not in_freeze_time and flags_weapon_switch <= 0 and flags_on_land == false and not flags_climbing_adder then
		SYR_State = "SYR-Slow Motion"
	elseif velocity_speed > 190 and onground and not infiniteduck and not exploit and fired_shoot == true and flags_on_use == 0 and flags_weapon_switch <= 0 and flags_on_land == false and not flags_climbing_adder then
		SYR_State = "SYR-High Speed"
	elseif not onground and not exploit and fired_shoot == true and flags_on_use == 0 and not in_freeze_time and flags_weapon_switch <= 0 and flags_on_land == false and not flags_climbing_adder then
		SYR_State = "SYR-Air"
	elseif infiniteduck and velocity_speed < 190 and not exploit and fired_shoot == true and flags_on_use == 0 and not in_freeze_time and flags_weapon_switch <= 0 and flags_on_land == false and not flags_climbing_adder then
		SYR_State = "SYR-Crouching"
	elseif exploit and flags_on_use == 0 and not in_freeze_time and flags_weapon_switch <= 0 and not flags_climbing_adder then
		SYR_State = "SYR-Exploit"
	elseif flags_on_use == 1 and fired_shoot == true and not in_freeze_time and flags_weapon_switch <= 0 and not flags_climbing_adder then
		SYR_State = "SYR-In Use"
	elseif fired_shoot == false and not in_freeze_time and flags_weapon_switch <= 0 and flags_weapon_reload == true and not flags_climbing_adder then
		SYR_State = "SYR-Fired"
	elseif flags_weapon_switch >= 0.001 and not in_freeze_time and onground and flags_on_land == false and not flags_climbing_adder then
		SYR_State = "SYR-Weapon Switch"
	elseif fired_shoot == false and flags_weapon_reload == false and onground and not in_freeze_time and flags_on_land == false and flags_weapon_switch <= 0 and not flags_climbing_adder then
		SYR_State = "SYR-Weapon Reload"
	elseif flags_on_land == true and flags_weapon_switch <= 0 and not in_freeze_time and fired_shoot == false and not flags_climbing_adder then
		SYR_State = "SYR-On Land"
	elseif flags_climbing_adder and not in_freeze_time then
		SYR_State = "SYR-Climbing Ldder"
	elseif in_freeze_time then
		SYR_State = "SYR-Freeze Time"
	end

	local trigger_always_packet = true
	local trigger_send_packet = true
	if multi_select(ui.get(fakelag_send_packet_trigger), "On Standing") and SYR_State == "SYR-Default" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "While Moving") and SYR_State == "SYR-Running" or multi_select(ui.get(fakelag_send_packet_trigger), "While Moving") and SYR_State == "SYR-Slow Motion" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "On Duck") and SYR_State == "SYR-Crouching" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "On High Speed") and SYR_State == "SYR-High Speed" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "On Jump") and SYR_State == "SYR-Air" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "On Exploit") and SYR_State == "SYR-Exploit" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "Weapon Fired") and SYR_State == "SYR-Fired" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "On Use") and SYR_State == "SYR-In Use" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "On Freezetime") and SYR_State == "SYR-Freeze Time" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "Weapon Switch") and SYR_State == "SYR-Weapon Switch" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "Weapon Reload") and SYR_State == "SYR-Weapon Reload" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "On Land") and SYR_State == "SYR-On Land" then
		trigger_always_packet = false
	end

	if multi_select(ui.get(fakelag_send_packet_trigger), "While Climbing Ladder") and SYR_State == "SYR-Climbing Ldder" then
		trigger_always_packet = false
	end

	if ui.get(fakelag_trigger_types) == "Fakelag Limit Trigger" then
		allow_packet_trigger = false
		fakelag_limit_trigget_status = trigger_always_packet == true and ui.get(fakelag_limit_trigger_limit) or lag_amount[lag_info.current_phase].limit
	elseif ui.get(fakelag_trigger_types) == "Fakelag Send Packet Trigger" then
		allow_packet_trigger = ui.get(amount_mode) == "Fluctuate" and false or trigger_always_packet
		fakelag_limit_trigget_status = lag_amount[lag_info.current_phase].limit
	end

	if ui.get(fakelag_tick_always_types) == "Maximum Packet" then
		cmd.allow_send_packet = allow_packet_trigger
	elseif ui.get(fakelag_tick_always_types) == "Dynamic Packet" then
		if delay_correct < globals.tickcount() then
			cmd.allow_send_packet = true
			delay_correct = globals.tickcount() + ui.get(limit)
		else
			cmd.allow_send_packet = allow_packet_trigger
		end
	end
end)

local function choke_cycle(cmd)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) then
		return
	end

	if cmd.chokedcommands < lag_info.prev_choked then
		lag_info.current_phase = lag_info.current_phase + 1
		if lag_info.current_phase > #lag_amount then
			lag_info.current_phase = 1
		end
	end

	if ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Gamesense" then
		if ui.get(fakelag_urmaxprocess) <= 18 then
			ui.set(fakelag_urmaxprocess, 18)
		end

		ui.set(amount, ui.get(ref_fakeduck) and "Maximum" or lag_amount[lag_info.current_phase].amount)
		ui.set(variance, ui.get(ref_fakeduck) and 0 or lag_amount[lag_info.current_phase].variance)
		ui.set(limit, ui.get(ref_fakeduck) and 15 or fakelag_limit_trigget_status)
	end

	ui.set(lagcomp_break, not lag_amount[lag_info.current_phase].break_lagcomp)
	lag_info.prev_choked = cmd.chokedcommands
end

client.set_event_callback("setup_command", choke_cycle)

local set_cache = function(self)
	local localplayer = entity.get_local_player()
	local weapon = entity.get_player_weapon(localplayer)
	local player_move_type = entity.get_prop(localplayer, "m_movetype")
	local flags_status = entity.get_prop(localplayer, "m_fFlags")
	local flags_climbing_adder = player_move_type == 9
	local aerial_flags = not flags_climbing_adder and flags_status == 256 or not flags_climbing_adder and flags_status == 262
	local boost_alternative_shooting = ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative" and multi_select(ui.get(boost_triggers), "On Shot")
	local gamesense_shooting = ui.get(fakelag_types) == "Gamesense" and multi_select(ui.get(fakelag_slider_trigger), "Avoid Fired Limit")
	local muti_exec_shooting = ui.get(fakelag_types) == "Boost Fakelag" and boost_alternative_shooting or gamesense_shooting
	if not localplayer or not entity.is_alive(localplayer) or not ui.get(fakelag_enabled) or ui.get(ref_fakeduck) or weapon == nil or multi_select(weapons_disabled, entity.get_classname(weapon)) or aerial_flags or not muti_exec_shooting then
		return
	end

	local process = function(name, condition, should_call, VAR)
	local hotkey_modes = {
		[0] = "always on",
		[1] = "on hotkey",
		[2] = "toggle",
		[3] = "off hotkey"
	}

	local _cond = ui.get(condition)
	local _type = type(_cond)

	local value, mode = ui.get(condition)
	local finder = mode ~= nil and mode or (_type == "boolean" and tostring(_cond) or _cond)
	cache[name] = cache[name] ~= nil and cache[name] or finder

	if should_call then ui.set(condition, mode ~= nil and hotkey_modes[VAR] or VAR) else
		if cache[name] ~= nil then
			local _cache = cache[name]
			if _type == "boolean" then
				if _cache == "true" then 
					_cache = true 
				end

				if _cache == "false" then 
					_cache = false 
				end
			end
    
				ui.set(condition, mode ~= nil and hotkey_modes[_cache] or _cache)
				cache[name] = nil
			end
		end
	end

	process("limit", limit, (self == nil and false or self), ui.get(fakelag_types) == "Gamesense" and ui.get(trigger_fired_limit) or ui.get(boost_triggers_shot))
end

client.set_event_callback("shutdown", set_cache)

client.set_event_callback("setup_command", function(cmd)
	local localplayer = entity.get_local_player()
	local weapon = entity.get_player_weapon(localplayer)
	local player_move_type = entity.get_prop(localplayer, "m_movetype")
	local flags_status = entity.get_prop(localplayer, "m_fFlags")
	local flags_climbing_adder = player_move_type == 9
	local aerial_flags = not flags_climbing_adder and flags_status == 256 or not flags_climbing_adder and flags_status == 262
	local boost_alternative_shooting = ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative" and multi_select(ui.get(boost_triggers), "On Shot")
	local gamesense_shooting = ui.get(fakelag_types) == "Gamesense" and multi_select(ui.get(fakelag_slider_trigger), "Avoid Fired Limit")
	local muti_exec_shooting = ui.get(fakelag_types) == "Boost Fakelag" and boost_alternative_shooting or gamesense_shooting
	if not localplayer or not entity.is_alive(localplayer) or not ui.get(fakelag_enabled) or ui.get(ref_fakeduck) or weapon == nil or multi_select(weapons_disabled, entity.get_classname(weapon)) or aerial_flags or not muti_exec_shooting then
		return
	end

	local last_shot_time = entity.get_prop(weapon, "m_fLastShotTime")
	local m_iItem = bit.band(entity.get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)
	local limitation = function(cmd)
	local in_accel = function()
		local localplayer = entity.get_local_player()
		local x, y = entity.get_prop(localplayer, "m_vecVelocity")
		return math.sqrt(x^2 + y^2) ~= 0
	end

	local max_commands = in_accel() and 1 or 2
	if not data.threshold and last_shot_time ~= data.stored_last_shot then
		data.stored_last_shot = last_shot_time
		if not onshot_mode then
			data.threshold = true
		end

		return true
	end

	if data.threshold and cmd.chokedcommands >= max_commands then
		data.threshold = false
		return true
	end
		return false
	end
    
	if data.stored_item ~= m_iItem then
		data.stored_last_shot = last_shot_time
		data.stored_item = m_iItem
	end

	set_cache(limitation(cmd))
end)

client.set_event_callback("paint",function(e)
	ui.set_visible(lagcomp_break, false)
	ui.set_visible(distance_value_condition, false)
	ui.set_visible(limit, not ui.get(fakelag_enabled))
	ui.set_visible(amount, not ui.get(fakelag_enabled))
	ui.set_visible(variance, not ui.get(fakelag_enabled))
	ui.set_visible(fakelag_types, ui.get(fakelag_enabled))
	ui.set_visible(fakelag_trigger_enabled, ui.get(fakelag_enabled))
	ui.set_visible(amount_mode, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(boost_mode, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag")
	ui.set_visible(fakelag_limit, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(variance_mode, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(variance_slider, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(fakelag_trigger_types, ui.get(fakelag_enabled) and ui.get(fakelag_trigger_enabled))
	ui.set_visible(fakelag_tick_always_types, ui.get(fakelag_enabled) and ui.get(fakelag_trigger_enabled))
	ui.set_visible(fakelag_slider_trigger, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(boost_normal_limit, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag")
	ui.set_visible(fakelag_send_packet_trigger, ui.get(fakelag_enabled) and ui.get(fakelag_trigger_enabled))
	ui.set_visible(boost_triggers, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative")
	ui.set_visible(boost_condition, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative")
	ui.set_visible(fakelag_fluctuate_limit, ui.get(fakelag_enabled) and ui.get(amount_mode) == "Fluctuate" and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(fakelag_limit_trigger_limit, ui.get(fakelag_enabled) and ui.get(fakelag_trigger_types) == "Fakelag Limit Trigger" and ui.get(fakelag_trigger_enabled))
	ui.set_visible(trigger_wall_limit, ui.get(fakelag_enabled) and multi_select(ui.get(fakelag_slider_trigger), "Avoid Wall Peek") and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(trigger_fired_limit, ui.get(fakelag_enabled) and multi_select(ui.get(fakelag_slider_trigger), "Avoid Fired Limit") and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(trigger_aerial_limit, ui.get(fakelag_enabled) and multi_select(ui.get(fakelag_slider_trigger), "Avoid Aerial Limit") and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(trigger_visible_limit, ui.get(fakelag_enabled) and multi_select(ui.get(fakelag_slider_trigger), "Avoid Visible Peek") and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(trigger_standing_limit, ui.get(fakelag_enabled) and multi_select(ui.get(fakelag_slider_trigger), "Avoid Standing Limit") and ui.get(fakelag_types) == "Gamesense")
	ui.set_visible(boost_send_limit, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative" and #ui.get(boost_condition) >= 1)
	ui.set_visible(boost_choke_limit, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative" and #ui.get(boost_condition) >= 1)
	ui.set_visible(boost_choke_types, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and ui.get(boost_mode) == "Alternative" and #ui.get(boost_condition) >= 1)
	ui.set_visible(boost_triggers_shot, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and multi_select(ui.get(boost_triggers), "On Shot") and ui.get(boost_mode) == "Alternative")
	ui.set_visible(boost_triggers_land, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and multi_select(ui.get(boost_triggers), "On Land") and ui.get(boost_mode) == "Alternative")
	ui.set_visible(boost_triggers_jump, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and multi_select(ui.get(boost_triggers), "Jumping") and ui.get(boost_mode) == "Alternative")
	ui.set_visible(boost_triggers_peek, ui.get(fakelag_enabled) and ui.get(fakelag_types) == "Boost Fakelag" and multi_select(ui.get(boost_triggers), "On Peeking") and ui.get(boost_mode) == "Alternative")
end)

client.delay_call(0.5, function(e)
	client.color_log(0, 125, 255, "[gamesense]HVH Fakelag Lua 加载完毕 Version: 2.0 Last Update Time: 1.21")
end)