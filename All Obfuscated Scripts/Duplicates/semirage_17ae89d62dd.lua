--[[
	id: zNZME5vXnmTRsUYBCYFkG
	name: 404semirage
	description: 123
	time1: 2021-05-13 05:47:02.637126+00
	time2: 2021-05-13 05:47:02.637127+00
	uploader: 4539
	uploadersession: Lrnvh5BkzLajMPyH6uMYJFFiiKHob-
	flag: f
--]]

--数据库
--skyness#4221
local client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_reload_active_scripts, client_scale_damage, client_get_cvar, client_camera_position, client_create_interface, client_random_int, client_latency, client_set_clan_tag, client_find_signature, client_log, client_timestamp, client_delay_call, client_trace_line, client_register_esp_flag, client_get_model_name, client_system_time, client_visible, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float = client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.reload_active_scripts, client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int, client.latency, client.set_clan_tag, client.find_signature, client.log, client.timestamp, client.delay_call, client.trace_line, client.register_esp_flag, client.get_model_name, client.system_time, client.visible, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float
local success, surface = pcall(require, 'gamesense/surface')
local anti_aim = require 'gamesense/antiaim_funcs'
local surface_measure_text, surface_draw_text = surface.measure_text, surface.draw_text
local math_ceil, math_tan, math_log10, math_randomseed, math_cos, math_sinh, math_random, math_huge, math_pi, math_max, math_atan2, math_ldexp, math_floor, math_sqrt, math_deg, math_atan, math_fmod = math.ceil, math.tan, math.log10, math.randomseed, math.cos, math.sinh, math.random, math.huge, math.pi, math.max, math.atan2, math.ldexp, math.floor, math.sqrt, math.deg, math.atan, math.fmod 
local globals_realtime, globals_absoluteframetime, globals_tickcount, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.tickcount, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers 
local entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
local cl = {
	log = client.log,
	exec = client.exec,
	indicator = renderer.indicator,
	circle_outline = client.draw_circle_outline,
	circle = client.draw_circle,
	eye_pos = client.eye_position,
	camera_angles = client.camera_angles,
	color_log = client.color_log,
	client_screen_size = client.screen_size,
	client_draw_text = client.draw_text
}
local ent = {
	get_local = entity.get_local_player,
	get_prop = entity.get_prop,
	get_all = entity.get_all,
	get_players = entity.get_players,
	hitbox_pos = entity.hitbox_position,
	is_alive = entity.is_alive
}
if not success then
    error('\n\n - 滚去订阅数据库 \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n')
end
local verdana = surface.create_font('verdana', 12, 400, { 0x200 --[[ Outline ]] })
local custom_font = surface.create_font('Small Pixel', 8, 400, { 0x200 --[[ Outline ]] })
local images = require "gamesense/images" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=22917/", 2)
local AA_info = {}
local vector = function(x, y, z)
    x = x ~= nil and x or 0
    y = y ~= nil and y or 0
    z = z ~= nil and z or 0

    return {
        ["x"] = x,
        ["y"] = y,
        ["z"] = z
    }
end

local vector_add = function(vector1, vector2)
    return { 
        ["x"] = vector1.x + vector2.x, 
        ["y"] = vector1.y + vector2.y, 
        ["z"] = vector1.z + vector2.z
    }
end

local vector_substract = function(vector1, vector2)
    return { 
        ["x"] = vector1.x - vector2.x, 
        ["y"] = vector1.y - vector2.y, 
        ["z"] = vector1.z - vector2.z
    }
end

local mcl, mcr = false, false
local function leftkey_press(key) 
	if key and not mcl then
		mcl = true
		return true
	end
	
	if not key and mcl then
		mcl = false
	end
	return false
end

local rad2deg = function(rad) return (rad * 180 / math.pi) end
local deg2rad = function(deg) return (deg * math.pi / 180) end

local trace_line = function(entity, start, _end)
    return client.trace_line(entity, start.x, start.y, start.z, _end.x, _end.y, _end.z)
end

local world_to_screen = function(x, y, z, func)
    local x, y = renderer.world_to_screen(x, y, z)
    if x ~= nil and y ~= nil then 
        func(x, y)
    end
end

local clamp_angles = function(angle)
    angle = angle % 360 
    angle = (angle + 360) % 360

    if angle > 180 then
        angle = angle - 360
    end

    return angle
end

local contains = function(tab, val, sys)
    for index, value in ipairs(tab) do
        if sys == 1 and index == val then 
            return true
        elseif value == val then
            return true
        end
    end
 
    return false
end

--on peek判定
peeking = false
unpeek = false
is_peeking = false
local is_peeking = function(cmd)

    local lp = entity.get_local_player()
    local pos = { client.eye_position() }
    local vel = { entity.get_prop(lp, "m_vecVelocity") }
    local idx = entity.get_prop(entity.get_player_weapon(lp), "m_iItemDefinitionIndex")
    local speed = 220
    local slider = 128

    predicted_pos = { pos[1] + (vel[1]/speed)*slider, pos[2] + (vel[2]/speed)*slider, pos[3] + (vel[3]/speed)*slider }
    for k, v in pairs(entity.get_players(true)) do
        local head = { entity.hitbox_position(v, 0) }
        local pelvis = { entity.hitbox_position(v, 2) }
        local _, head_ent = client.trace_line(lp, predicted_pos[1], predicted_pos[2], predicted_pos[3], head[1], head[2], head[3])
        local _, pelvis_ent = client.trace_line(lp, predicted_pos[1], predicted_pos[2], predicted_pos[3], pelvis[1], pelvis[2], pelvis[3])

        if head_ent == v or pelvis_ent == v then
            local _, head_ent = client.trace_line(lp, pos[1], pos[2], pos[3], head[1], head[2], head[3])
            local _, pelvis_ent = client.trace_line(lp, pos[1], pos[2], pos[3], pelvis[1], pelvis[2], pelvis[3])
            if head_ent ~= v and pelvis_ent ~= v then
                    peeking = true
                break
            end
        else
            peeking = false
        end
        peeking = false
    end

end
client.set_event_callback("setup_command", is_peeking)

local ui_mset = function(list)
    for ref, val in pairs(list) do
        ui.set(ref, val)
    end
end
local get_local, ui_get, ui_set, get_prop = entity.get_local_player, ui.get, ui.set, entity.get_prop
local manual = 0
local aim_active
local var_direction = {
    "Safe",
    "Maximum",
    "Anti-resolver"
}

local var_direction2 = {
    "Static",

}

local aamode = {
    "Edge prediction",
	"Manual override", 
}
local Hitscan = {
	head = { 0, 1 },
	chest = { 2, 3, 4 },
	stomach = { 5, 6 },
	arms = { 13, 14, 15, 16, 17, 18 },
	legs = { 7, 8, 9, 10 },
	feet = { 11, 12 }
}


local edge_count = { [1] = 7, [2] = 12, [3] = 15, [4] = 19, [5] = 23, [6] = 28, [7] = 29, [8] = 35, [9] = 38, [10] = 42,  [11] = 45, [12] = 48, [13] = 52, [14] = 58, [15] = 62, [16] = 65, [17] = 69, [18] = 74, [19] = 78, [20] = 83}
local near = { "Head", "Chest", "Stomach", "Arms", "Legs", "Feet" }
local dynamicfov_new_fov = 0
local autowallvar1 = false
local autowallvar2 = false


--local ui
local masterswitch = ui.new_checkbox("AA", "Anti-aimbot angles", "404 semirage")
local modeswitch = ui.new_combobox("AA", "Anti-Aimbot Angles", "\nMode", {"-" ,"Anti-Aim", "Ragebot", "Misc", "Visual"})
local label = ui.new_label("AA", "Anti-Aimbot Angles", "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
local aa = {
    enabled = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Legit anti-aim"),
    hot1key_reference = ui.new_hotkey("AA", "Anti-aimbot angles", "legit aa", true),
    direction_by = ui.new_combobox("AA", "Anti-Aimbot Angles", "Body Yaw", var_direction2),
	direction = ui.new_combobox("AA", "Anti-Aimbot Angles", "Mode", var_direction),
    direction_mode = ui.new_combobox("AA", "Anti-Aimbot Angles", "AA switch mode", aamode),
	override_key = ui.new_hotkey("AA", "Anti-Aimbot Angles", "Override switch"),
}
local ragebot = {
    nearesthitbox_hitscan = ui.new_multiselect("AA", "Anti-Aimbot Angles", "Nearest hitbox", near),
    dynamicfov_mode = ui.new_combobox("AA", "Anti-Aimbot Angles", "Dynamic FOV",  "Off", "Static", "Auto"),
    dynamicfov_min = ui.new_slider("AA", "Anti-Aimbot Angles", "Minimal FOV", 1, 180, 3, true, "°", 1),
    dynamicfov_max = ui.new_slider("AA", "Anti-Aimbot Angles", "Maximum FOV", 1, 180, 21, true, "°", 1),
    dynamicfov_auto_factor = ui.new_slider("AA", "Anti-Aimbot Angles", "Automatic factor", 0, 250, 30, true, "x", 0.01),
    autowallbutton = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Legit autowall ▪ Autowall override"),
	autowalltoggle = ui.new_hotkey("AA", "Anti-Aimbot Angles", "Automatic Penetration Toggle", true),
	auto_autowall = ui.new_combobox("AA", "Anti-Aimbot Angles", "Auto autowall modes", "-","Edge autowall"),
    legit_pen_threshold_ref = ui.new_slider("AA", "Anti-Aimbot Angles", "Awall if visible X hitbox(s)", 0, 18, 4, true),
    overridebutton = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Legit aa resolver"),
    resolverselect = ui.new_combobox("AA", "Anti-Aimbot Angles", "\nLegit aa resolver", "Override resolver"),
    overridekey = ui.new_hotkey("AA", "Anti-Aimbot Angles", "Override key: RIGHT ▪ LEFT ▪ AUTO"),

}
local visual = {
    indication = ui.new_combobox("AA", "Anti-aimbot angles", "Anti-aim indicator", "Off", "Style 1", "Style 2", "Style 3"),
    arrows_offset = ui.new_slider("AA", "Anti-aimbot angles", 'Arrows distance', 10, 200, 50),
    ui_indicator_color_picker4 = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator colour", "0", "115", "255", "255"),
    flag_enable = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Reslover flags"),
    flag_color = ui.new_color_picker("AA", "Anti-Aimbot Angles", "\n flags"),
    flag_select = ui.new_combobox("AA", "Anti-Aimbot Angles", "\n flags", "-","Override resolver arrow","Debug indicator"),
    font_type = ui.new_combobox("AA", "Anti-aimbot angles", "Font style", {"Style 1", "Style 2"}),
    indicators_type =  ui.new_multiselect("AA", "Anti-aimbot angles", 'Indicators types', "Body side", "Fakelag", "Min damage", "Autowall", "Resolver", "Fakeduck", "FOV", "Force body aim", "Force safepoint"),
    indicator_info_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color1", 255, 255, 255, 255),
    indicator_info_clr1 = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color2", 255, 255, 255, 255),
    indicators_offset = ui.new_slider('AA', 'Anti-aimbot angles', 'Indicators distance', -20, 60, -10),

}
local misc = {
    checkbox = ui.new_combobox('AA', 'Anti-aimbot angles', "Quickswap", {"-", "AWP + Scout", "Deagle", "All"}),
    mode = ui.new_combobox('AA', 'Anti-aimbot angles', "Quickswap Condition", {"Shot", "Kill"}),
    camcollsion = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Disable Cam Collision"),
    new_slider = ui.new_slider("AA", "Anti-Aimbot Angles", "Thirdperson delta", 0, 150, 150),
    hide_default_inds = ui.new_checkbox("AA", "Anti-aimbot angles", "Hide default indicators"),
    projecttag_enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "404 clan tag"),
}
local duration = 40
local clantags = {
     "     [Aqua7']"
    , "     [Aqua7']"
    , "     [Aqua7']"
    , " |             "
    , " 4|             "
    , " 40|             "
    , " 404|             "
    , " 404 |             "
    , " 404 p|             "
    , " 404 pr|             "
    , " 404 pro|             "
    , " 404 proj|             "
    , " 404 proje|             "
    , " 404 projec|             "
    , " 404 project|             "
    , " 404 project |             "
    , " 404 project |             "
    , " 404 project|             "
    , " 404 projec|             "
    , " 404 proje|             "
    , " 404 proj|             "
    , " 404 pro|             "
    , " 404 pr|             "
    , " 404 p|             "
    , " 404 |             "
    , " 404|             "
    , " 40|             "
    , " 4|             "
    , " |             "
    , "     [Aqua7']"
    , "     [Aqua7']"
    , "     [Aqua7']"
    , }


--reference
aaenablers = ui.reference("AA", "Anti-aimbot angles", "Enabled")
mindmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
ref_sp_key = ui.reference("RAGE", "Aimbot", "Force SAFE point")
ref_baim_key = ui.reference("RAGE", "Other", "Force body aim")
ref_fd = ui.reference("RAGE", "Other", "Duck peek assist")
legit_active, legit_key = ui.reference("Legit", "Aimbot", "Enabled")
rage_active, active_key = ui.reference("RAGE", "Aimbot", "Enabled")
rage_selection = ui.reference("RAGE", "Aimbot", "Target selection")
local rage_hitbox = ui.reference("RAGE", "Aimbot", "Target hitbox")
rage_recoil = ui.reference("RAGE", "Other", "Remove recoil")
rage_fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
infinite_duck = ui.reference("MISC", "Movement", "Infinite duck")
auto_pistols = ui.reference("MISC", "Miscellaneous", "Automatic weapons")
autofire = ui.reference("RAGE", "Aimbot", "Automatic fire")
psilent = ui.reference("RAGE", "Aimbot", "Silent aim")
aimstep = ui.reference("RAGE", "Aimbot", "Reduce aim step")
maximum_fov = ui.reference("RAGE", "Aimbot", "Maximum FOV")
flag_limit = ui.reference("AA", "Fake lag", "Limit")
pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
yaw, yaw_num = ui.reference("AA", "Anti-aimbot angles", "Yaw")
yaw_jitter = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
body, body_num = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
lby = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
autowall = ui.reference("RAGE", "Aimbot", "Automatic Penetration")
selectedplayer = ui.reference("players", "players", "player list")
forcebody1, body_slider1 = ui.reference("players", "adjustments", "force body yaw")
resetlist = ui.reference("players", "players", "reset all")
applyall = ui.reference("players", "adjustments", "Apply to all")
forcebody = ui.reference("players", "adjustments", "force body yaw")
body_slider = ui.reference("PLAYERS", "Adjustments", "Force body yaw value")
resetlist = ui.reference("players", "players", "reset all")
applyall = ui.reference("players", "adjustments", "Apply to all")
force_body = ui.reference("PLAYERS", "Adjustments", "Force body yaw")
default_reference = ui.reference("MISC", "Miscellaneous", "Clan tag spammer")
ref_pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
ref_yaw, ref_yawadd = ui.reference("AA", "Anti-aimbot angles", "Yaw")
ref_yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
ref_yawj, ref_yawjadd = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
ref_bodyyaw, ref_bodyyawadd = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
ref_fs_bodyyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
ref_lby_target = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
ref_fakelimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
ref_free, ref_freekey = ui.reference( "AA", "Anti-aimbot angles", "Freestanding")
--local visible
local function set_visible()
    local active = ui_get(aa.enabled)
    local autowallenable = ui.get(ragebot.autowallbutton)
    ui.set_visible(modeswitch, ui.get(masterswitch))
    ui.set_visible(label, ui.get(masterswitch) and ui.get(modeswitch) ~= "-")
    ui.set_visible(aa.enabled, ui.get(modeswitch) == "Anti-Aim" and ui.get(masterswitch))
    ui.set_visible(aa.hot1key_reference, active and ui.get(modeswitch) == "Anti-Aim" and ui.get(masterswitch))
    ui.set_visible(aa.direction_by, false)
    ui.set_visible(aa.direction_mode, active and ui.get(modeswitch) == "Anti-Aim" and ui.get(masterswitch))
    ui.set_visible(aa.direction, active and ui.get(aa.direction_by) == var_direction2[1] and ui.get(modeswitch) == "Anti-Aim" and ui.get(masterswitch))
	ui.set_visible(aa.override_key, active and ui.get(aa.direction_mode) == aamode[2] and ui.get(modeswitch) == "Anti-Aim" and ui.get(masterswitch))

	ui.set_visible(visual.indication, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.arrows_offset, ui.get(modeswitch) == "Visual" and ui.get(masterswitch) and ui.get(visual.indication) ~= "Off")
    ui.set_visible(visual.ui_indicator_color_picker4, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.indicators_type, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.flag_enable, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.flag_color, ui.get(modeswitch) == "Visual" and ui.get(masterswitch) and ui.get(visual.flag_enable))
    ui.set_visible(visual.flag_select, ui.get(modeswitch) == "Visual" and ui.get(masterswitch) and ui.get(visual.flag_enable))
    ui.set_visible(visual.font_type, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.indicators_type, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.indicator_info_clr, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.indicator_info_clr1, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    ui.set_visible(visual.indicators_offset, ui.get(modeswitch) == "Visual" and ui.get(masterswitch))
    
    ui.set_visible(ragebot.nearesthitbox_hitscan, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch))
    ui.set_visible(ragebot.dynamicfov_mode, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch))
    ui.set_visible(ragebot.dynamicfov_min, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and ui.get(ragebot.dynamicfov_mode) ~= "Off")
    ui.set_visible(ragebot.dynamicfov_max, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and ui.get(ragebot.dynamicfov_mode) ~= "Off")
    ui.set_visible(ragebot.dynamicfov_auto_factor, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and ui.get(ragebot.dynamicfov_mode) ~= "Off")
    ui.set_visible(ragebot.autowallbutton, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch))
    ui.set_visible(ragebot.autowalltoggle, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and autowallenable)
    ui.set_visible(ragebot.auto_autowall, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and autowallenable)
    ui.set_visible(ragebot.legit_pen_threshold_ref, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and autowallenable and ui.get(ragebot.auto_autowall) ~= "-")
    ui.set_visible(ragebot.overridebutton, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch))
    ui.set_visible(ragebot.resolverselect, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and ui.get(ragebot.overridebutton))
    ui.set_visible(ragebot.overridekey, ui.get(modeswitch) == "Ragebot" and ui.get(masterswitch) and ui.get(ragebot.overridebutton) and ui.get(ragebot.resolverselect) == "Override resolver")

    ui.set_visible(misc.camcollsion, ui.get(modeswitch) == "Misc" and ui.get(masterswitch))
    ui.set_visible(misc.new_slider, ui.get(modeswitch) == "Misc" and ui.get(masterswitch) and ui.get(misc.camcollsion))
    ui.set_visible(misc.hide_default_inds, ui.get(modeswitch) == "Misc" and ui.get(masterswitch))
    ui.set_visible(misc.projecttag_enabled, ui.get(modeswitch) == "Misc" and ui.get(masterswitch))
    ui.set_visible(misc.checkbox, ui.get(modeswitch) == "Misc" and ui.get(masterswitch))
    ui.set_visible(misc.mode, ui.get(modeswitch) == "Misc" and ui.get(masterswitch) and ui.get(misc.checkbox) ~= "-")

    ui.set_visible(ref_pitch, not ui.get(masterswitch))
    ui.set_visible(ref_yaw, not ui.get(masterswitch))
    ui.set_visible(ref_yaw_base, not ui.get(masterswitch))
    ui.set_visible(ref_yawadd, not ui.get(masterswitch))
    ui.set_visible(ref_yawj, not ui.get(masterswitch))
    ui.set_visible(ref_yawjadd, not ui.get(masterswitch))
    ui.set_visible(ref_bodyyawadd, not ui.get(masterswitch))
    ui.set_visible(ref_bodyyaw, not ui.get(masterswitch))
    ui.set_visible(ref_fakelimit, not ui.get(masterswitch))
    ui.set_visible(ref_lby_target, not ui.get(masterswitch))
    ui.set_visible(ref_fs_bodyyaw, not ui.get(masterswitch))
    ui.set_visible(ref_free, not ui.get(masterswitch))
    ui.set_visible(ref_freekey, not ui.get(masterswitch))
    ui.set_visible(edge_yaw, not ui.get(masterswitch))
end


--ui
local client_screen_size, entity_get_all, entity_get_local_player, entity_get_prop, set_event_callback, math_sqrt, math_min, math_floor, draw_text, measure_text, globals_frametime = client.screen_size, entity.get_all, entity.get_local_player, entity.get_prop, client.set_event_callback, math.sqrt, math.min, math.floor, renderer.text, globals.frametime
local speed, last_onground_speed, last_flags, fade_time, old_onground_speed = 0, 0, 0, 0, 0

local function hsv_to_rgb(h, s, v, a)
	local r, g, b
	local i = math.floor(h * 6);
	local f = h * 6 - i;
	local p = v * (1 - s);
	local q = v * (1 - f * s);
	local t = v * (1 - (1 - f) * s);
	i = i % 6

	if i == 0 then 
		r, g, b = v, t, p
	elseif i == 1 then
		r, g, b = q, v, p
	elseif i == 2 then
		r, g, b = p, v, t
	elseif i == 3 then
		r, g, b = p, q, v
	elseif i == 4 then
		r, g, b = t, p, v
	elseif i == 5 then
		r, g, b = v, p, q
	end
  
	return r * 255, g * 255, b * 255, a * 255
end

local function func_rgb_rainbowize(frequency, rgb_split_ratio)
	local r, g, b, a = hsv_to_rgb(globals.realtime() * frequency, 1, 1, 1)
	r = r * rgb_split_ratio
	g = g * rgb_split_ratio
	b = b * rgb_split_ratio
	return r, g, b
end
    
round = function(num, numDecimalPlaces)

    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
  
  end
function on_paint()
    local w, h = client_screen_size()
   
if entity_get_local_player() == nil then
	return
end

if ui.get(masterswitch) then
local local_player = entity_get_local_player()
local vel_x, vel_y = entity_get_prop(local_player, "m_vecVelocity")

    if vel_x ~= nil then
    local velocity = math_sqrt(vel_x*vel_x + vel_y*vel_y)

    velocity = math_min(9999, velocity) + 0.2
    velocity = round(velocity, 0)
    local rainbow_r1, rainbow_g1, rainbow_b1 = func_rgb_rainbowize((1 / 10), 1) 
        renderer.text(w/2, h/2 +25 +500, rainbow_r1, rainbow_g1, rainbow_b1, 255, "bc", 0, string.format("[404 semirage] Velocity:           | Update: 2021/05/23"))   
        renderer.gradient(w/2-7, h/2 +22 +500, math_min(velocity/12), 8, rainbow_r1, rainbow_g1, rainbow_b1, 255, 125, 125, 125, 125, true)
    end
    end
end
client.set_event_callback("paint", on_paint)

--lua抬头指标
local function draw_container(x, y, w, h, header, a)
    local c = {10, 60, 40, 40, 40, 60, 20}
    local rainbow_r2, rainbow_g2, rainbow_b2 = func_rgb_rainbowize((1 / 10), 1)
    local rainbow_r1, rainbow_g1, rainbow_b1 = func_rgb_rainbowize((1 / 10), 1)
    for i = 0,6,1 do
        renderer.rectangle(x+i, y+i, w-(i*2), h-(i*2), c[i+1], c[i+1], c[i+1], a)
    end

    if header then
        local x_inner, y_inner = x+7, y+7
        local w_inner = w-14

        renderer.gradient(x_inner, y_inner - 1, math.floor(w_inner/2), 2, m_r, m_g, m_b, a, mt_r, mt_g, mt_b, a, true)
        renderer.gradient(x_inner+math.floor(w_inner/2), y_inner - 1, math.ceil(w_inner/2), 2, mt_r, mt_g, mt_b, a, m_r, m_g, m_b, a, true)

        local a_lower = a
        renderer.gradient(x_inner, y_inner, math.floor(w_inner/2), 2, rainbow_r2, rainbow_g2, rainbow_b2, a_lower, rainbow_r1, rainbow_g1, rainbow_b1, a_lower, true)
        renderer.gradient(x_inner+math.floor(w_inner/2), y_inner, math.ceil(w_inner/2), 2, rainbow_r1, rainbow_g1, rainbow_b1, a_lower, rainbow_r1, rainbow_g1, rainbow_b1, a_lower, true)
    end
end


function skyness_menu_addtitions()
    local rainbow_r, rainbow_g, rainbow_b = func_rgb_rainbowize((2 / 10), 1)
    local rainbow_r1, rainbow_g1, rainbow_b1 = func_rgb_rainbowize((1 / 10), 1)
    local scrsize_x, scrsize_y = client.screen_size( )
    local center_x, center_y = scrsize_x/2, scrsize_y/2
    local scrleft_x, scrleft_y = (( scrsize_x-scrsize_x ) +1 ), (( scrsize_y-scrsize_y ) +1 )
    local c = {10, 60, 40, 40, 40, 60, 20}
    local menu_x, menu_y = ui.menu_position()
    local mouse_x, mouse_y = ui.mouse_position()
    local menu_w, menu_h = ui.menu_size()
    local h = 54
    local conmid_x, conmid_y = (menu_x + (menu_w/2)), menu_y - h/2
    if ui.is_menu_open() and ui.get(masterswitch)then
        draw_container(menu_x, menu_y - h, menu_w, h - 4,true, 255)
        client.draw_text( c, conmid_x, conmid_y - 2, rainbow_r, rainbow_g, rainbow_b, 255, "bc+", 0, "404 SEMIRAGE+" )
        client.draw_text( c, (menu_x+menu_w) - 59, conmid_y + 6, rainbow_b1, rainbow_r, rainbow_g, 255, "bc-", 0, "skyness<admin>")
        client.draw_text( c, (menu_x) + 70, conmid_y + 6, rainbow_r1, rainbow_b, rainbow_g1, 255, "bc-", 0, "What's done is done." )
    end
end
client.set_event_callback("paint_ui", skyness_menu_addtitions)
--组名
local clantag_prev
function run_tag_animation()
if ui.get(misc.projecttag_enabled) then
  local cur = math.floor(globals.tickcount() / duration) % #clantags
  local clantag = clantags[cur+1]

  if clantag ~= clantag_prev then
    clantag_prev = clantag
    client.set_clan_tag(clantag)
  end
  end
end


client.set_event_callback("run_command", function(c)
    chokedcmds = c.chokedcommands 
end)

local was_enabled = false
local function on_run_command(c)
    if ui.get(misc.projecttag_enabled) then
        if (chokedcmds == 0) or not (entity.is_alive(entity.get_local_player())) then
            run_tag_animation()
            was_enabled = true
        end
    elseif (not ui.get(misc.projecttag_enabled) and not ui.get(default_reference)) and was_enabled then
        client.set_clan_tag("\0")
        was_enabled = false
    end
end
client.set_event_callback("paint", on_run_command)
local function get_near_target()
	local enemy_players = entity.get_players(true)
	if #enemy_players ~= 0 then
		local own_x, own_y, own_z = client.eye_position()
		local own_pitch, own_yaw = client.camera_angles()
		local closest_enemy = nil
		local closest_distance = 999999999

		for i = 1, #enemy_players do
			local enemy = enemy_players[i]
			local enemy_x, enemy_y, enemy_z = entity.get_prop(enemy, "m_vecOrigin")

			local x = enemy_x - own_x
			local y = enemy_y - own_y
			local z = enemy_z - own_z

			local yaw = ((math.atan2(y, x) * 200 / math.pi))
			local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 200 / math.pi)

			local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
			local pitch_dif = math.abs(own_pitch - pitch ) % 360

			if yaw_dif > 180 then yaw_dif = 360 - yaw_dif end
			local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))

			if closest_distance > real_dif then
				closest_distance = real_dif
				closest_enemy = enemy
			end
		end

		if closest_enemy ~= nil then
			return closest_enemy, closest_distance
		end
	end

	return nil, nil
end


--legit aa
local function do_legit_aa(local_player)
    if not local_player or not entity.is_alive(local_player) then
        return
    end

    local m_vecOrigin = vector(get_prop(local_player, "m_vecOrigin"))
    local m_vecViewOffset = vector(get_prop(local_player, "m_vecViewOffset"))

    local m_vecOrigin = vector_add(m_vecOrigin, m_vecViewOffset)

    local radius = 20 + 200 + 0.1
    local step = math.pi * 2.0 / edge_count[10]

    local camera = vector(client.camera_angles())
    local central = deg2rad(math.floor(camera.y + 0.5))

    local data = {
        fraction = 1,
        surpassed = false,
        angle = vector(0, 0, 0),
        var = 0,
        side = "LAST KNOWN"
    }

    for a = central, math.pi * 3.0, step do
        if a == central then
            central = clamp_angles(rad2deg(a))
        end

        local clm = clamp_angles(central - rad2deg(a))
        local abs = math.abs(clm)

        if abs < 90 and abs > 1 then
            local side = "LAST KNOWN"
            local location = vector(
                radius * math.cos(a) + m_vecOrigin.x, 
                radius * math.sin(a) + m_vecOrigin.y, 
                m_vecOrigin.z
            )

            local _fr, entindex = trace_line(local_player, m_vecOrigin, location)

            if math.floor(clm + 0.5) < -21 then side = "LEFT" end
            if math.floor(clm + 0.5) > 21 then side = "RIGHT" end

            local fr_info = {
                fraction = _fr,
                surpassed = (_fr < 1),
                angle = vector(0, clamp_angles(rad2deg(a)), 0),
                var = math.floor(clm + 0.5),
                side = side --[ 0 - center / 1 - left / 2 - right ]
            }

            if data.fraction > _fr then data = fr_info end

        end
    end

    return data
end

local inverse_time = 0
local function spread_aa(mode)
	if mode == "Safe" then
		ui_set(lby, "Eye yaw")
        ui_set(body, "Static")
	elseif mode == "Maximum" then
		ui_set(lby, "Opposite")
        ui_set(body, "Static")
    elseif mode == "Anti-resolver" then
        ui_set(limit, math.random(58,60))
        p = client.random_int(1, 3)
        if p == 1 then
		ui_set(lby, "Opposite")
        elseif p == 2 then
            ui_set(lby, "Sway")
        elseif p == 3 then
            ui_set(lby, "Off")
            if (peeking) then
                ui_set(body, "Jitter")
            else
                ui_set(body, "Static")
            end
        end
	end
end


local cache = { }
local cache_process = function(name, condition, should_call, a, b)
    cache[name] = cache[name] ~= nil and cache[name] or ui_get(condition)

    if should_call then
        if type(a) == "function" then a() else
            ui_set(condition, a)
        end
    else
        if cache[name] ~= nil then
            if b ~= nil and type(b) == "function" then
                b(cache[name])
            else
                ui_set(condition, cache[name])
            end

            cache[name] = nil
        end
    end
end


local midx ,midy = client.screen_size()
local midx2 , midy2 = midx/2 ,midy/2
client.set_event_callback("paint", function()
    local local_player = get_local()

	
    if not ui_get(aa.enabled) or not local_player then
        return
    end
	spread_aa(ui_get(aa.direction))

	if ui.get(aa.direction_mode) == aamode[2] and leftkey_press(ui_get(aa.override_key)) then
		if manual ~= -1 then
			manual = -1
        elseif manual ~= 1 then
            manual = 1
		end
	end


    local data = do_legit_aa(local_player)
    if data == nil then
        return
    end
	local by_mode = ui_get(aa.direction_by) 
	
    if not aim_active then
        ui_set(pitch, 'Off')
        ui_set(yaw_base, 'Local view')
        ui_set(yaw, '180')
        ui_set(yaw_num, 180)
        ui_set(yaw_jitter, 'Off')
    
		if by_mode == var_direction2[1] then
			if data.fraction < 1 and manual == 0 then
				ui_set(body_num, data.var > 0 and 180 or -180)
			elseif manual ~= 0 then
				ui_set(body_num, manual > 0 and 180 or -180)
			end
		end
		
    end

    local clamp = function(int, min, max)
        local vl = int

        vl = vl < min and min or vl
        vl = vl > max and max or vl

        return vl
    end

    local vl = { get_prop(local_player, "m_vecVelocity") }
    local vl_sqrt = math.sqrt(vl[1]*vl[1] + vl[2]*vl[2])
    local vl_actual = math.floor(math.min(10000, vl_sqrt + 0.5))
	local scrsize_x, scrsize_y = client.screen_size()
	local center_x, center_y = scrsize_x / 2, scrsize_y / 2
    local by = ui_get(body_num) 
    local max_dsn = clamp(59 - 58 * vl_actual / 580, 0, 60)
    local byaw_value = clamp(by, by < 0 and -60 or 0, by > 0 and 60 or 0)
    local end_byaw = clamp(byaw_value, by < 0 and -max_dsn or 0, by > 0 and max_dsn or 0)
    local indicator_r, indicator_g, indicator_b, indicator_a = ui.get(visual.ui_indicator_color_picker4)
    if ui.get(masterswitch) and ui.get(aaenablers) then
        if ui_get(visual.indication) == "Style 1" then
            if ui.get(body_num) > 0 then
                client.draw_text(c, center_x + 45 + ui.get(visual.arrows_offset), center_y, indicator_r, indicator_g, indicator_b, indicator_a, "c+", 0, "⯈"); --left
                client.draw_text(c, center_x - 45 - ui.get(visual.arrows_offset), center_y, 125, 125, 125, 125, "c+", 0, "⯇"); --right ]]
            else
                client.draw_text(c, center_x + 45 + ui.get(visual.arrows_offset), center_y, 125, 125, 125, 125, "c+", 0, "⯈"); --left
                client.draw_text(c, center_x - 45 - ui.get(visual.arrows_offset), center_y, indicator_r, indicator_g, indicator_b, indicator_a,  "c+", 0, "⯇"); --right
            end
        elseif ui_get(visual.indication) == "Style 2" then
            if ui.get(body_num) > 0 then
                client.draw_text(c, center_x + 45 + ui.get(visual.arrows_offset), center_y, indicator_r, indicator_g, indicator_b, indicator_a, "c+", 0, "⮚"); --left
                client.draw_text(c, center_x - 45 - ui.get(visual.arrows_offset), center_y, 125, 125, 125, 125, "c+", 0, "⮘"); --right ]]
            else
                client.draw_text(c, center_x + 45 + ui.get(visual.arrows_offset), center_y, 125, 125, 125, 125, "c+", 0, "⮚"); --left
                client.draw_text(c, center_x - 45 - ui.get(visual.arrows_offset), center_y, indicator_r, indicator_g, indicator_b, indicator_a,  "c+", 0, "⮘"); --right
            end
        elseif ui_get(visual.indication) == "Style 3" then
            if ui.get(body_num) > 0 then
                client.draw_text(c, center_x + 45 + ui.get(visual.arrows_offset), center_y, indicator_r, indicator_g, indicator_b, indicator_a, "c+", 0, "❯"); --left
                client.draw_text(c, center_x - 45 - ui.get(visual.arrows_offset), center_y, 125, 125, 125, 125, "c+", 0, "❮"); --right ]]
            else
                client.draw_text(c, center_x + 45 + ui.get(visual.arrows_offset), center_y, 125, 125, 125, 125, "c+", 0, "❯"); --left
                client.draw_text(c, center_x - 45 - ui.get(visual.arrows_offset), center_y, indicator_r, indicator_g, indicator_b, indicator_a,  "c+", 0, "❮"); --right
            end
        end
    end
end)
--nearhitbox
local function inArr(tab, val)
    for index, value in ipairs(tab) do
        if value == val then return true end
    end

    return false
end



local function getNearestEnemy()
	local enemy_players = ent.get_players(true)
	if #enemy_players ~= 0 then
		local own_x, own_y, own_z = cl.eye_pos()
		local own_pitch, own_yaw = cl.camera_angles()
		local closest_enemy = nil
		local closest_distance = 999999999
		        
		for i = 1, #enemy_players do
			local enemy = enemy_players[i]
			local enemy_x, enemy_y, enemy_z = ent.hitbox_pos(enemy, 0)
		            
			local x = enemy_x - own_x
			local y = enemy_y - own_y
			local z = enemy_z - own_z 

			local yaw = ((math.atan2(y, x) * 180 / math.pi))
			local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 180 / math.pi)

			local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
			local pitch_dif = math.abs(own_pitch - pitch ) % 360
	            
			if yaw_dif > 180 then yaw_dif = 360 - yaw_dif end
			local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))

			if closest_distance > real_dif then
				closest_distance = real_dif
				closest_enemy = enemy
			end
		end

		if closest_enemy ~= nil then
			return closest_enemy, closest_distance
		end
	end

	return nil, nil
end

local function nearestHitbox() 
	if table.getn(ui.get(ragebot.nearesthitbox_hitscan)) > 0 then 
		scanlist = {} 

		if inArr(ui.get(ragebot.nearesthitbox_hitscan), near[1]) then
			table.insert(scanlist, "0")
			table.insert(scanlist, "1")
		end

		if inArr(ui.get(ragebot.nearesthitbox_hitscan), near[2]) then
			table.insert(scanlist, "5")
			table.insert(scanlist, "6")
		end

		if inArr(ui.get(ragebot.nearesthitbox_hitscan), near[3]) then
			table.insert(scanlist, "2")
			table.insert(scanlist, "3")
			table.insert(scanlist, "4")
		end

		if inArr(ui.get(ragebot.nearesthitbox_hitscan), near[4]) then
			table.insert(scanlist, "13")
			table.insert(scanlist, "14")
			table.insert(scanlist, "15")
			table.insert(scanlist, "16")
			table.insert(scanlist, "17")
			table.insert(scanlist, "18")
		end

		if inArr(ui.get(ragebot.nearesthitbox_hitscan), near[5]) then
			table.insert(scanlist, "7")
			table.insert(scanlist, "8")
			table.insert(scanlist, "9")
			table.insert(scanlist, "10")
		end

		if inArr(ui.get(ragebot.nearesthitbox_hitscan), near[6]) then
			table.insert(scanlist, "11")
			table.insert(scanlist, "12")
		end

		closest_enemy, closest_distance = getNearestEnemy()

		if closest_enemy ~= nil then

			local table_size = table.getn(scanlist)

			local besthitbox = nil
			local besthitbox_dist = 999999999

			for i = 1, table_size do

				local own_x, own_y, own_z = cl.eye_pos()
				local own_pitch, own_yaw = cl.camera_angles()

				local enemy_x, enemy_y, enemy_z = ent.hitbox_pos(closest_enemy, tonumber(scanlist[i]))
			            
				local x = enemy_x - own_x
				local y = enemy_y - own_y
				local z = enemy_z - own_z 

				local yaw = ((math.atan2(y, x) * 180 / math.pi))
				local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 180 / math.pi)

				local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
				local pitch_dif = math.abs(own_pitch - pitch ) % 360
		            
				if yaw_dif > 180 then yaw_dif = 360 - yaw_dif end
				local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))

				if besthitbox_dist > real_dif then
					besthitbox = tonumber(scanlist[i])
					besthitbox_dist = real_dif
				end

			end

			if besthitbox ~= nil then

				if besthitbox == 0 or besthitbox == 1 then ui.set(rage_hitbox, "Head") end
				if besthitbox == 5 or besthitbox == 6 then ui.set(rage_hitbox, "Chest") end
				if besthitbox == 2 or besthitbox == 3 or besthitbox == 4 then ui.set(rage_hitbox, "Stomach") end

				if besthitbox == 13 or besthitbox == 14 or besthitbox == 16 or besthitbox == 17 or besthitbox == 18 then
					ui.set(rage_hitbox, "Arms")
				end

				if besthitbox == 7 or besthitbox == 8 or besthitbox == 9 or besthitbox == 10 then
					ui.set(rage_hitbox, "Legs")
				end

				if besthitbox == 11 or besthitbox == 12 then
					ui.set(rage_hitbox, "Feet")
				end

			end

		end
	end
end

local function doDynamicFOV()
	local mode = ui.get(ragebot.dynamicfov_mode)
	if mode ~= 'Off' then

	 	local old_fov = ui.get(maximum_fov)
	    local min_fov = ui.get(ragebot.dynamicfov_min)
	    local max_fov = ui.get(ragebot.dynamicfov_max)

	    local own_x, own_y, own_z = cl.eye_pos()
	   	closest_enemy, closest_distance = getNearestEnemy()
	        
		if closest_enemy ~= nil then
			local closest_enemy_x, closest_enemy_y, closest_enemy_z = ent.hitbox_pos(closest_enemy, 0)
			local real_distance = math.sqrt(math.pow(own_x - closest_enemy_x, 2) + math.pow(own_y - closest_enemy_y, 2) + math.pow(own_z - closest_enemy_z, 2))

			if mode == "Static" then
				dynamicfov_new_fov = max_fov - ((max_fov - min_fov) * (real_distance - 250) / 1000)
			elseif mode == "Auto"  then
				dynamicfov_new_fov = (3800 / real_distance) * (ui.get(ragebot.dynamicfov_auto_factor) * 0.01)
			end

			if (dynamicfov_new_fov > max_fov) then
				dynamicfov_new_fov = max_fov
			elseif dynamicfov_new_fov < min_fov then
				dynamicfov_new_fov = min_fov
			end
	    else 
	        dynamicfov_new_fov = min_fov
	    end

	    dynamicfov_new_fov = math.floor(dynamicfov_new_fov)
	    if dynamicfov_new_fov ~= old_fov then
	    	ui.set(maximum_fov, dynamicfov_new_fov)
	    end
	    
	end
end

function table_contains(tbl, value)
    for i=1, #tbl do
        if tbl[i] == value then
            return true
        end
    end
    return false
end


-- autowall
function on_paint(ctx)
	if not ui.get(ragebot.autowallbutton, true) then
    autowallvar1 = false
	end
	if ui.get(masterswitch) and ui.get(ragebot.autowallbutton, true) then
	else return
	end

	if ui.get(ragebot.autowalltoggle) then
	
		autowallvar1 = true
		
	else 
		
		autowallvar1 = false
		
	end
end

client.set_event_callback("paint", on_paint)

range = false


selectedplayer = ui.reference("players", "players", "player list")
player_list = ui.reference("PLAYERS", "Players", "Player list")
edgeawplayer = { }



client.set_event_callback("player_connect_full", function(c)
    if client.userid_to_entindex(c) == entity.get_local_player() then
        edgeawplayer = { }
    end
end)

local client_camera_angles, client_trace_line, entity_get_local_player, entity_get_players, entity_get_prop, entity_hitbox_position, math_acos, math_cos, math_sin, math_sqrt = client.camera_angles, client.trace_line, entity.get_local_player, entity.get_players, entity.get_prop, entity.hitbox_position, math.acos, math.cos, math.sin, math.sqrt

maximum_fov_ref = ui.reference("RAGE", "Aimbot", "Maximum FOV")

PI = 3.14159265358979323846
DEG_TO_RAD = PI / 180.0
RAD_TO_DEG = 180.0 / PI

function vec3_normalize(x, y, z)
	local len = math_sqrt(x*x + y*y + z*z)
	if len == 0 then
		return 0, 0, 0
	end
	local r = 1 / len
	return x*r, y*r, z*r
end

function vec3_dot(ax, ay, az, bx, by, bz)
	return ax*bx + ay*by + az*bz
end

function angle_to_vec(pitch, yaw)
	local pitch_rad, yaw_rad = DEG_TO_RAD*pitch, DEG_TO_RAD*yaw
	local sp, cp, sy, cy = math_sin(pitch_rad), math_cos(pitch_rad), math_sin(yaw_rad), math_cos(yaw_rad)
	return cp*cy, cp*sy, -sp
end

function calculate_fov_to_player(ent, lx, ly, lz, fx, fy, fz)
    local px, py, pz = entity_get_prop(ent, "m_vecOrigin")
    local dx, dy, dz = vec3_normalize(px-lx, py-ly, lz-lz)
    local dot_product = vec3_dot(dx, dy, dz, fx, fy, fz)
    local cos_inverse = math_acos(dot_product)
	return RAD_TO_DEG*cos_inverse
end

function get_closest_player_to_crosshair(lx, ly, lz, pitch, yaw)
    local fx, fy, fz = angle_to_vec(pitch, yaw)
    local enemy_players = entity_get_players(true)
    
    local nearest_player = nil
    local nearest_player_fov = math.huge

    for i=1, #enemy_players do
        local enemy_ent = enemy_players[i]

        local fov_to_player = calculate_fov_to_player(enemy_ent, lx, ly, lz, fx, fy, fz)

        if fov_to_player <= nearest_player_fov then
            nearest_player = enemy_ent
            nearest_player_fov = fov_to_player
        end
    end

    return nearest_player, nearest_player_fov
end

function is_player_visible(local_player, lx, ly, lz, ent)
    local visible_hitboxes = 0
    local visible_hitbox_threshold = ui.get(ragebot.legit_pen_threshold_ref)

    for i=0, 18 do
        local ex, ey, ez = entity_hitbox_position(ent, i)
                local _, entindex = client_trace_line(local_player, lx, ly, lz, ex, ey, ez)

        if entindex == ent then
            visible_hitboxes = visible_hitboxes + 1
        end
    end

    return visible_hitboxes >= visible_hitbox_threshold
end

function on_run_command()
    local state = ui.get(ragebot.auto_autowall) == "Edge autowall"

        local maximum_fov = ui.get(maximum_fov_ref)
        local local_player = entity_get_local_player()

        local pitch, yaw = client_camera_angles()
        local lx, ly, lz = entity_get_prop(local_player, "m_vecOrigin")

        local nearest_player, nearest_player_fov = get_closest_player_to_crosshair(lx, ly, lz, pitch, yaw)

        local view_offset = entity_get_prop(local_player, "m_vecViewOffset[2]")
        local lz = lz + view_offset

		if nearest_player ~= nil and nearest_player_fov <= maximum_fov and ui.get(masterswitch) and ui.get(ragebot.autowallbutton, true) and state then
			autowallvar2 = is_player_visible(local_player, lx, ly, lz, nearest_player)
		else
			autowallvar2 = false
		end
	end


client.set_event_callback("run_command", on_run_command)

selectedplayer = ui.reference("players", "players", "player list")
player_list = ui.reference("PLAYERS", "Players", "Player list")
autowallplayer = { }

function AWHandler()
	if ui.get(masterswitch) and ui.get(ragebot.autowallbutton, true) then
	else return
	end
	if autowallvar1 or autowallvar2 then

		ui.set(autowall, true)
	
	else 
	
		ui.set(autowall, false)
	
	end
	
end
client.set_event_callback("paint", AWHandler)

--resolver
--override key

local canManual
local target
local targetx
local targety
local targetz
local screenposx
local screenposy

function reset_target(r)
    --not working for some reason, useless atm
    if ui.get(ragebot.overridebutton, true) and ui.get(ragebot.resolverselect) == "Override resolver" then
    else
        return
    end
    client.log(r)
    ui.set(selectedplayer, r)
    ui.set(forcebody, false)
    ui.set(body_slider, 0)
    ui.set(applyall, true)

end
function setbodyyaw()
    if ui.get(masterswitch) and ui.get(ragebot.overridebutton, true) and ui.get(ragebot.resolverselect) == "Override resolver" then
	
    --client.delay_call(3, reset_target(selectedplayer))
    --client.delay_call(5, reset_all)  works?

        if ui.get(body_slider) == 0 and canManual == true then
            ui.set(forcebody, true)
            ui.set(body_slider, 60)
            ui.set(applyall, true)
            canManual = false
        end

        if ui.get(body_slider) == 60 and canManual == true then
            ui.set(forcebody, true)
            ui.set(body_slider, -60)
            ui.set(applyall, true)
            canManual = false
        end

        if ui.get(body_slider) == -60 and canManual == true then
            ui.set(forcebody, false)
            ui.set(body_slider, 0)
            ui.set(applyall, true)
            canManual = false
        end
    
    end


end
function on_paint()
    if ui.get(ragebot.overridebutton, true) and ui.get(ragebot.resolverselect) == "Override resolver" then
        if ui.get(ragebot.overridekey) then
            if canManual == true then
                setbodyyaw()
                canManual = false
            end
        else
            canManual = true
        end
    end

end

client.set_event_callback("paint", on_paint)

--bruteforce indicator/resolver indicator
aacorrect = ui.reference("RAGE", "OTHER", "Anti-aim correction")
playerlistplayers = ui.reference("PLAYERS", "Players", "Player list")
bruteforce_ents = {  }

client.set_event_callback("run_command", function(c)
    local overrideselect = ui.get(visual.flag_select) == "Override resolver arrow"
    if ui.get(ragebot.overridebutton, true or false) and ui.get(ragebot.resolverselect) == "Override resolver" and ui.get(visual.flag_enable, true) and overrideselect then
    end
    if not ui.is_menu_open() then
        bruteforce_ents = { }
        client.update_player_list()
        for _, v in pairs(entity.get_players(true)) do
            if ui.get(body_slider) == -60 or ui.get(body_slider) == 60 or ui.get(force_body) == false then
                table.insert(bruteforce_ents, v)
                entity.set_prop(v, "m_flDetectedByEnemySensorTime")
            else
                entity.set_prop(v, "m_flDetectedByEnemySensorTime", 0)
            end
        end
    end
end)


client.set_event_callback("paint", function()
    local r, g, b, a = ui.get(visual.flag_color)
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (255/2-1) + 255/2) or 255
    local alpha1 = math.floor(math.sin(realtime * 2) * (255/2-1) + 255/2) or 255
    local overrideselect = ui.get(visual.flag_select) == "Override resolver arrow"
    local overrideselect1 = ui.get(visual.flag_select) == "Debug indicator"
    if ui.get(masterswitch) and ui.get(ragebot.overridebutton, true) and ui.get(visual.flag_enable, true) and overrideselect then
        for _, v in pairs(bruteforce_ents) do
            local bounding_box = { entity.get_bounding_box(v) }
            if #bounding_box == 5 and bounding_box[5] ~= 0 then
                local center = bounding_box[1] + (bounding_box[3] - bounding_box[1]) / 2
                if ui.get(body_slider) == 60 then
                    renderer.text(center, bounding_box[2] - 25, r, g, b, alpha*bounding_box[5] , "cb+", 0, "❮ ❮ ❮")
                elseif ui.get(body_slider) == -60 then
                    renderer.text(center, bounding_box[2] - 25, r, g, b, alpha*bounding_box[5] , "cb+", 0, "❯ ❯ ❯")
                elseif ui.get(force_body) == false then
                    renderer.text(center, bounding_box[2] -25, r, g, b, alpha*bounding_box[5] , "cb+", 0, "⯆")
                    
                end
            end
        end
    elseif ui.get(masterswitch) and ui.get(ragebot.overridebutton, true) and ui.get(visual.flag_enable, true) and overrideselect1 then
        for _, v in pairs(bruteforce_ents) do
            local bounding_box = { entity.get_bounding_box(v) }
            if #bounding_box == 5 and bounding_box[5] ~= 0 then
                local center = bounding_box[1] + (bounding_box[3] - bounding_box[1]) / 2
                if ui.get(body_slider) == 60 then
                    client.draw_gradient(ctx, center-35, bounding_box[2] - 57, 70, 3, r, g, b, 255, b, r, g, 255, true) 
                    client.draw_gradient(ctx, center-35, bounding_box[2] - 55, 70, 35, 35, 35, 35, 155, 35, 35, 35, 155, true) 
                    renderer.text(center-13, bounding_box[2] - 55, r, g, b, 255*bounding_box[5] , "b", 0, "4")
                    renderer.text(center-3, bounding_box[2] - 55, b, r, g, 255*bounding_box[5] , "b", 0, "0")
                    renderer.text(center+7, bounding_box[2] - 55, g, b, r, 255*bounding_box[5] , "b", 0, "4")
                    renderer.text(center-35, bounding_box[2] - 45, 255, 255, 255, 255*bounding_box[5] , "-", 0, "R E S O L V E R :")
                    renderer.text(center+15, bounding_box[2] - 45, 225, 255, 25, alpha*bounding_box[5] , "b", 0, "‹‹‹")
                    renderer.text(center-35, bounding_box[2] - 30, 255, 255, 255, 255*bounding_box[5] , "-", 0, "O N P E E K ")
                    if (peeking) then
                    renderer.text(center+5, bounding_box[2] - 35, 15, 255, 15, 255*bounding_box[5] , "b", 0, "√")
                    else    
                    renderer.text(center+5, bounding_box[2] - 35, 255, 25, 15, 255*bounding_box[5] , "b", 0, "×")
                    end
                    renderer.text(center, bounding_box[2] -18, 225, 200, 255, alpha1*bounding_box[5] , "cb", 0, "⯆")
                elseif ui.get(body_slider) == -60 then
                    client.draw_gradient(ctx, center-35, bounding_box[2] - 57, 70, 3, r, g, b, 255, b, r, g, 255, true) 
                    client.draw_gradient(ctx, center-35, bounding_box[2] - 55, 70, 35, 35, 35, 35, 155, 35, 35, 35, 155, true) 
                    renderer.text(center-13, bounding_box[2] - 55, r, g, b, 255*bounding_box[5] , "b", 0, "4")
                    renderer.text(center-3, bounding_box[2] - 55, b, r, g, 255*bounding_box[5] , "b", 0, "0")
                    renderer.text(center+7, bounding_box[2] - 55, g, b, r, 255*bounding_box[5] , "b", 0, "4")
                    renderer.text(center-35, bounding_box[2] - 45, 255, 255, 255, 255*bounding_box[5] , "-", 0, "R E S O L V E R :")
                    renderer.text(center+15, bounding_box[2] - 45, 225, 255, 25, alpha*bounding_box[5] , "b", 0, "›››")
                    renderer.text(center-35, bounding_box[2] - 35, 255, 255, 255, 255*bounding_box[5] , "-", 0, "O N P E E K ")
                    if (peeking) then
                    renderer.text(center+5, bounding_box[2] - 35, 15, 255, 15, 255*bounding_box[5] , "b", 0, "√")
                    else    
                    renderer.text(center+5, bounding_box[2] - 35, 255, 25, 15, 255*bounding_box[5] , "b", 0, "×")
                    end
                    renderer.text(center, bounding_box[2] -18, 225, 200, 255, alpha1*bounding_box[5] , "cb", 0, "⯆")
                elseif ui.get(force_body) == false then
                    client.draw_gradient(ctx, center-35, bounding_box[2] - 57, 70, 3, r, g, b, 255, b, r, g, 255, true) 
                    client.draw_gradient(ctx, center-35, bounding_box[2] - 55, 70, 35, 35, 35, 35, 155, 35, 35, 35, 155, true) 
                    renderer.text(center-13, bounding_box[2] - 55, r, g, b, 255*bounding_box[5] , "b", 0, "4")
                    renderer.text(center-3, bounding_box[2] - 55, b, r, g, 255*bounding_box[5] , "b", 0, "0")
                    renderer.text(center+7, bounding_box[2] - 55, g, b, r, 255*bounding_box[5] , "b", 0, "4")
                    renderer.text(center-35, bounding_box[2] - 45, 255, 255, 255, 255*bounding_box[5] , "-", 0, "R E S O L V E R :")
                    renderer.text(center+15, bounding_box[2] - 45, 225, 255, 25, alpha*bounding_box[5] , "b", 0, "•••")
                    renderer.text(center-35, bounding_box[2] - 35, 255, 255, 255, 255*bounding_box[5] , "-", 0, "O N P E E K ")
                    if (peeking) then
                    renderer.text(center+5, bounding_box[2] - 35, 15, 255, 15, 255*bounding_box[5] , "b", 0, "√")
                    else    
                    renderer.text(center+5, bounding_box[2] - 35, 255, 25, 15, 255*bounding_box[5] , "b", 0, "×")
                    end
                    renderer.text(center, bounding_box[2] -18, 225, 200, 255, alpha1*bounding_box[5] , "cb", 0, "⯆")
                    
                end
            end
        end
    end
end)
--指示器
--fl指示器
local OldChoke = 0
local toDraw4 = 0
local toDraw3 = 0
local toDraw2 = 0
local toDraw1 = 0
local toDraw0 = 0
local function setup_command(cmd)

   if cmd.chokedcommands < OldChoke then --sent
       toDraw0 = toDraw1
       toDraw1 = toDraw2
       toDraw2 = toDraw3
       toDraw3 = toDraw4
       toDraw4 = OldChoke
   end
   
   OldChoke = cmd.chokedcommands

end
client.set_event_callback('setup_command', setup_command)
client.set_event_callback("player_connect_full", function(c)
    if client.userid_to_entindex(c) == entity.get_local_player() then
        saved_enable = { }
    end
end)

local function includes(table, key)
    for i=1, #table do
        if table[i] == key then
            return true
        end
    end
    return false
end

local function draw()
    if not entity_is_alive(entity_get_local_player()) then return end
    local r, g, b, a = ui_get(visual.indicator_info_clr)
    local r1, g1, b1, a1 = ui_get(visual.indicator_info_clr1)
    local w, h = client_screen_size()
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (255/2-1) + 255/2) or 255
    local me = entity.get_local_player()
    local screen_size = { client.screen_size() }
    local h_index = 0
    local side = "AA | OFF"
    if ui.get(body_num) > 0 and ui.get(aa.hot1key_reference) then
        side = "AA | RIGHT"
    elseif ui.get(body_num) < 0 and ui.get(aa.hot1key_reference) then
        side = "AA | LEFT"
    end
    local brute = "AUTO"
    if ui.get(body_slider) == 60 then
        brute = "LEFT"
    elseif ui.get(body_slider) == -60 then
        brute = "RIGHT"
    elseif ui.get(force_body) == false then
        brute = "OFF"
    end
    local awall = "OFF"
    if ui.get(ragebot.autowallbutton) and ui.get(ragebot.autowalltoggle) then
        awall = "OVERRIDE"
    elseif ui.get(ragebot.autowallbutton) and ui.get(ragebot.auto_autowall) ~= "-" then
        awall = "LEGIT"
    elseif not ui.get(ragebot.autowallbutton) then
        awall = "OFF"
    end
    if ui.get(masterswitch) then
        if ui.get(visual.font_type)== "Style 1" then
            if includes(ui_get(visual.indicators_type), "Body side") then
            surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), b, g, r, a, verdana, side)
            h_index = h_index + 1
            end
            if includes(ui_get(visual.indicators_type), "Fakelag") then
                surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), g, r, b, a, verdana,  "FL : ")
                renderer.gradient(w / 2 + 38 , h / 2 + 39 + (h_index * 12) + ui.get(visual.indicators_offset) , math.min(OldChoke*4 ), 6, r1, g1, b1, 255, 125, 125, 125, 50, true)
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Min damage") then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), r, b, g, a, verdana, string.format('DMG : '..ui.get(mindmg)))
                h_index = h_index + 1 
            end

            if includes(ui_get(visual.indicators_type), "FOV")  then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), b, r, g, a, verdana,  'FOV: ' ..ui.get(maximum_fov))
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Resolver") then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), r, b, g, a, verdana, string.format('BRUTE : '..brute))
                h_index = h_index + 1 
            end

            if includes(ui_get(visual.indicators_type), "Autowall")  then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), b, r, g, a, verdana,  'AW: ' ..awall)
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Fakeduck") and ui_get(ref_fd) then
                local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), 215, 114, 44, alpha, verdana,  "DUCK")
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Force safepoint") and ui_get(ref_sp_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), 255, 125, 225, 255, verdana,  "SAFE")
                h_index = h_index + 1
            end

            if includes(ui.get(visual.indicators_type), "Force body aim") and ui.get(ref_baim_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset),225, 225, 112, 255, verdana,  "BAIM")
                h_index = h_index + 1
            end
        end
        if ui.get(visual.font_type)== "Style 2" then
            if includes(ui_get(visual.indicators_type), "Body side") then
            surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), b, g, r, a, custom_font, side)
            h_index = h_index + 1
            end
            if includes(ui_get(visual.indicators_type), "Fakelag") then
                surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), g, r, b, a, custom_font,  "FL : ")
                renderer.gradient(w / 2 + 35 , h / 2 + 36 + (h_index * 12) + ui.get(visual.indicators_offset) , math.min(OldChoke*4 ), 7, r1, g1, b1, 255, 125, 125, 125, 50, true)
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Min damage") then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), r, b, g, a, custom_font, string.format('DMG : '..ui.get(mindmg)))
                h_index = h_index + 1 
            end

            if includes(ui_get(visual.indicators_type), "FOV")  then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), b, r, g, a, custom_font,  'FOV: ' ..ui.get(maximum_fov))
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Resolver") then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), r, b, g, a, custom_font, string.format('BRUTE : '..brute))
                h_index = h_index + 1 
            end

            if includes(ui_get(visual.indicators_type), "Autowall")  then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), b, r, g, a, custom_font,  'AW: ' ..awall)
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Fakeduck") and ui_get(ref_fd) then
                local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), 215, 114, 44, alpha, custom_font,  "DUCK")
                h_index = h_index + 1
            end

            if includes(ui_get(visual.indicators_type), "Force safepoint") and ui_get(ref_sp_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset), 255, 125, 225, 255, custom_font,  "SAFE")
                h_index = h_index + 1
            end

            if includes(ui.get(visual.indicators_type), "Force body aim") and ui.get(ref_baim_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visual.indicators_offset),225, 225, 112, 255, custom_font,  "BAIM")
                h_index = h_index + 1
            end
        end
        if ui.get(misc.hide_default_inds) then
            for i = 1, 400 do
                renderer.indicator(0, 0, 0, 0, " ")
            end
        end
    end
end

--cam_collision
ui.set_callback(misc.new_slider, function()
    slider = ui.get(misc.new_slider)
client.exec("cam_idealdist ", slider)
end)
ui.set_callback(misc.camcollsion, function()
    client.set_event_callback("paint", function()
    if ui.get(misc.camcollsion) and ui.get(masterswitch)then 
        client.exec("cam_collision 0")
    else
        client.exec("cam_collision 1")
    end
end)
end)

--quickswitch
ui_new_combobox, ui_get, entity_get_player_weapon, entity_get_local_player, entity_get_prop, globals_tickinterval, client_exec, client_set_event_callback = ui.new_combobox, ui.get, entity.get_player_weapon, entity.get_local_player, entity.get_prop, globals.tickinterval, client.exec, client.set_event_callback
client_draw_indicator = client.draw_indicator
client_delay_call = client.delay_call
client_userid_to_entindex = client.userid_to_entindex
last_swap = 0; 
globals_curtime = globals.curtime
local m_fLastShotTime;
local play = false
local playdeag = false
local function death_check(e)
	if ui_get(misc.mode) == "Kill" then
		if client_userid_to_entindex(e.attacker) == entity_get_local_player() then
			if  ui_get(misc.checkbox) == "-" then return 
			elseif ui_get(misc.checkbox) == "AWP + Scout" then
				if bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 9 or bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 40  then
					play = true		
					client_exec("slot3")
				end
			elseif ui_get(misc.checkbox) == "Deagle" then
				if bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 1 then
					playdeag = true		
					client_exec("slot3")
				end
			elseif ui_get(misc.checkbox) == "All" then
				if bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 9 or bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 40  then
					play = true		
					client_exec("slot3")
				end
				if bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 1 then
					playdeag = true		
					client_exec("slot3")
				end
			end
		end
	end
end
local function run_command(e)
	if play then
		client_exec("slot1")
		play = false

	end
	if playdeag then
		client_exec("slot2")
		playdeag = false

	end
	play = false
	playdeag = false

	local current_weapon = entity_get_player_weapon(entity_get_local_player())
	m_fLastShotTime = entity_get_prop(current_weapon, "m_fLastShotTime")
	if ui_get(misc.mode) == "Shot" then
		if  ui_get(misc.checkbox) == "-" then return 
		elseif ui_get(misc.checkbox) == "AWP + Scout" then
			if bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 9 or bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 40  then
				if m_fLastShotTime + .05 > globals_curtime() then
					play = true		
					client_exec("slot3")
		
				end
			end
		elseif ui_get(misc.checkbox) == "Deagle" then
			if bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 1 then
				if m_fLastShotTime + .05 > globals_curtime() then
					playdeag = true		
					client_exec("slot3")
		
				end
			end
		elseif ui_get(misc.checkbox) == "All" then
			if bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 9 or bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 40  then
				if m_fLastShotTime + .05 > globals_curtime() then
					play = true		
					client_exec("slot3")
		
				end
			elseif bit.band(65535, entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex")) == 1 then
				if m_fLastShotTime + .05 > globals_curtime() then
					playdeag = true		
					client_exec("slot3")
		
				end
			end
		end
	end
end
client_set_event_callback("player_death", death_check)
client_set_event_callback("setup_command", run_command)

client.set_event_callback("run_command", function(c)
    nearestHitbox() 
	doDynamicFOV()
end)
client.set_event_callback("paint", function()
    ui.set(aaenablers, ui.get(aa.hot1key_reference))
    draw()
end)
client.set_event_callback("paint_ui", set_visible)

function get()
	_info = {}
	_info["AA_manual"] = manual
	_info["AA_Dir"] = ui_get(body_num) 
	return _info
end
AA_info.get = get
return AA_info


