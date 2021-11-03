--[[
	id: jjq5_TNgPKl8uWGwQKO5P
	name: Canary
	description: lua
	time1: 2021-04-23 14:57:34.41985+00
	time2: 2021-04-23 14:57:34.419851+00
	uploader: 0cTDt5EWPQxOeQ_2X-HASILp8OS5sFhkNHeQmXmf
	uploadersession: 9IglLs9LoTnjPpycx0zePF3kMHMXoo
	flag: f
--]]

--local variables for API functions. Generated using https://github.com/sapphyrus/gamesense-lua/blob/master/generate_api.lua
local client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_reload_active_scripts, client_scale_damage, client_get_cvar, client_camera_position, client_create_interface, client_random_int, client_latency, client_set_clan_tag, client_find_signature, client_log, client_timestamp, client_delay_call, client_trace_line, client_register_esp_flag, client_get_model_name, client_system_time, client_visible, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float = client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.reload_active_scripts, client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int, client.latency, client.set_clan_tag, client.find_signature, client.log, client.timestamp, client.delay_call, client.trace_line, client.register_esp_flag, client.get_model_name, client.system_time, client.visible, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float
local entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
local globals_realtime, globals_absoluteframetime, globals_chokedcommands, globals_oldcommandack, globals_tickcount, globals_commandack, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.chokedcommands, globals.oldcommandack, globals.tickcount, globals.commandack, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect, ui_is_menu_open, ui_new_hotkey, ui_set, ui_update, ui_menu_size, ui_name, ui_menu_position, ui_set_callback, ui_new_button, ui_new_label, ui_new_string, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect, ui.is_menu_open, ui.new_hotkey, ui.set, ui.update, ui.menu_size, ui.name, ui.menu_position, ui.set_callback, ui.new_button, ui.new_label, ui.new_string, ui.get
local renderer_load_svg, renderer_world_to_screen, renderer_circle_outline, renderer_rectangle, renderer_gradient, renderer_circle, renderer_text, renderer_line, renderer_load_jpg, renderer_load_png, renderer_triangle, renderer_measure_text, renderer_load_rgba, renderer_indicator, renderer_texture = renderer.load_svg, renderer.world_to_screen, renderer.circle_outline, renderer.rectangle, renderer.gradient, renderer.circle, renderer.text, renderer.line, renderer.load_jpg, renderer.load_png, renderer.triangle, renderer.measure_text, renderer.load_rgba, renderer.indicator, renderer.texture
local math_ceil, math_tan, math_cos, math_sinh, math_pi, math_max, math_atan2, math_floor, math_sqrt, math_deg, math_atan, math_fmod, math_acos, math_pow, math_abs, math_min, math_sin, math_log, math_exp, math_cosh, math_asin, math_rad = math.ceil, math.tan, math.cos, math.sinh, math.pi, math.max, math.atan2, math.floor, math.sqrt, math.deg, math.atan, math.fmod, math.acos, math.pow, math.abs, math.min, math.sin, math.log, math.exp, math.cosh, math.asin, math.rad
local string_find, string_format, string_len, string_gsub, string_gmatch, string_match, string_reverse, string_upper, string_lower, string_sub = string.find, string.format, string.len, string.gsub, string.gmatch, string.match, string.reverse, string.upper, string.lower, string.sub
--end of local variables

local menu = {
    ui_new_label("LUA", "B", "--------------[CANARY]--------------"),
    master_switch = ui_new_checkbox("LUA", "B", "Master switch"),
    anti_aim = ui_new_checkbox("LUA", "B", "Anti-aim"),
    anti_aim_opts = ui_new_multiselect("LUA", "B", "Anti-aim options", "Reversed freestanding", "Force static body yaw", "Max delta in air", "Dodge on slowwalk"),
    doubletap = ui_new_checkbox("LUA", "B", "Doubletap"),
    doubletap_opts = ui_new_multiselect("LUA", "B", "Doubletap options", "Latency based", "Refine hitchance", "Instant"),
    on_use_aa = ui_new_checkbox("LUA", "B", "On use anti-aim"),
    on_use_aa_key = ui_new_hotkey("LUA", "B", "On use anti-aim", true, 0x45),
    on_use_aa_mode = ui_new_combobox("LUA", "B", "On use anti-aim mode", "Low delta", "Max delta"),
    debug_panel = ui_new_checkbox("LUA", "B", "Debug panel"),
    keybind_list = ui_new_checkbox("LUA", "B", "Keybind list"),
    keybind_clr = ui_new_color_picker("LUA", "B", "Keybind list color"),
    indicators = ui_new_checkbox("LUA", "B", "Indicators"),
    indicators_clr = ui_new_color_picker("LUA", "B", "Indicator color"),
    ui_new_label("LUA", "B", "--------------[CANARY]--------------")
}

local refs = {
    dt = { ui_reference("RAGE", "Other", "Double tap") },
    yaw = { ui_reference("AA", "Anti-aimbot angles", "Yaw") },
    yawj = { ui_reference("AA", "Anti-aimbot angles", "Yaw jitter") },
    bodyyaw = { ui_reference("AA", "Anti-aimbot angles", "Body yaw") },
    fs = { ui_reference("AA", "Anti-aimbot angles", "Freestanding") },
    slowwalk = { ui_reference("AA", "Other", "Slow motion") },
    leg_movement = ui_reference("AA", "Other", "Leg movement"),
    hs = { ui_reference("AA", "Other", "On shot anti-aim") },
    quickpeek = { ui_reference("RAGE", "Other", "Quick peek assist") },
    quickpeek_clr = ui_reference("RAGE", "Other", "Quick peek assist display"),
    edge_yaw = ui_reference("AA", "Anti-aimbot angles", "Edge yaw"),
    md = ui_reference("RAGE", "Aimbot", "Minimum damage"),
    sp_key = ui_reference("RAGE", "Aimbot", "Force safe point"),
    baim_key = ui_reference("RAGE", "Other", "Force body aim"),
    fd = ui_reference("RAGE", "Other", "Duck peek assist"),
    dt_mode = ui_reference("RAGE", "Other", "Double tap mode"),
    dt_hc = ui_reference("RAGE", "Other", "Double tap hit chance"),
    dt_fl = ui_reference("RAGE", "Other", "Double tap fake lag limit"),
    pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base"),
    fs_bodyyaw = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    lby_target = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target"),
    fakelimit = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    fl = ui_reference("AA", "Fake lag", "Enabled"),
    fl_amt = ui_reference("AA", "Fake lag", "Amount"),
    fl_var = ui_reference("AA", "Fake lag", "Variance"),
    fl_limit = ui_reference("AA", "Fake lag", "Limit"),
    maxprocessticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    holdaim = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim")
}

local vars = {
    best_enemy = nil,
    best_angle = 0,
    misses = { },
    last_miss = 0,
    on_use_aa = false,
    dt_restore = false
}

local vec_3 = function(_x, _y, _z) 
	return { x = _x or 0, y = _y or 0, z = _z or 0 } 
end

local color = function(_r, _g, _b, _a) 
	return { r = _r or 0, g = _g or 0, b = _b or 0, a = _a or 0 } 
end

local includes = function(table, value)
    for _, v in ipairs(ui_get(table)) do
        if v == value then return true end
    end

    return false
end

local function entity_has_c4(ent)
	local bomb = entity_get_all("CC4")[1]
	return bomb ~= nil and entity_get_prop(bomb, "m_hOwnerEntity") == ent
end

local function normalize_yaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end

    return yaw
end

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then return 0 end

    return math_deg(math_atan2(y, x))
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
	local ydelta = local_y - enemy_y
	local xdelta = local_x - enemy_x
	local relativeyaw = math_atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math_pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
	return relativeyaw
end

local function angle_vector(angle_x, angle_y)
	local sy = math_sin(math_rad(angle_y))
	local cy = math_cos(math_rad(angle_y))
	local sp = math_sin(math_rad(angle_x))
	local cp = math_cos(math_rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function get_best_enemy()
    vars.best_enemy = nil

    local enemies = entity_get_players(true)
    if #enemies == 0 then return end

    local eye_pos, cam_ang = vec_3(client_eye_position()), vec_3(client_camera_angles())
    local best_fov = 180

    for i=1, #enemies do
        local enemy_pos = vec_3(entity_get_prop(enemies[i], "m_vecOrigin"))
        local cur_fov = math_abs(normalize_yaw(ang_on_screen(eye_pos.x - enemy_pos.x, eye_pos.y - enemy_pos.y) - cam_ang.y + 180))
        if cur_fov < best_fov then
            best_fov = cur_fov
            vars.best_enemy = enemies[i]
        end
    end
end

local function get_best_angle()
    vars.best_angle = 0

    if not ui_get(menu.anti_aim) or vars.best_enemy == nil then return end

    local me = entity_get_local_player()

    local local_pos, enemy_pos = vec_3(entity_hitbox_position(me, 0)), vec_3(entity_hitbox_position(vars.best_enemy, 0))

    local yaw = calc_angle(local_pos.x, local_pos.y, enemy_pos.x, enemy_pos.y)
    local l_dir, r_dir = vec_3(angle_vector(0, (yaw + 90))), vec_3(angle_vector(0, (yaw - 90)))
    local l_pos, r_pos = vec_3(local_pos.x + l_dir.x * 110, local_pos.y + l_dir.y * 110, local_pos.z), vec_3(local_pos.x + r_dir.x * 110, local_pos.y + r_dir.y * 110, local_pos.z)

    local fraction, hit_ent = client_trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, l_pos.x, l_pos.y, l_pos.z)
    local fraction_s, hit_ent_s = client_trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, r_pos.x, r_pos.y, r_pos.z)

    if fraction > fraction_s then
        if vars.on_use_aa then
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 1 or 2
        else
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 2 or 1
        end
    elseif fraction_s > fraction then
        if vars.on_use_aa then
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 2 or 1
        else
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 1 or 2
        end
    elseif fraction == fraction_s then
        vars.best_angle = 3
    end
end

local function set_anti_aim(pitch, yaw, yaw_add, yawj, yawj_add, bodyyaw, bodyyaw_add, fs, lby, fakelimit)
    ui_set(refs.pitch, pitch)
    ui_set(refs.yaw[1], yaw)
    ui_set(refs.yaw[2], yaw_add)
    ui_set(refs.yawj[1], yawj)
    ui_set(refs.yawj[2], yawj_add)
    ui_set(refs.bodyyaw[1], bodyyaw)
    ui_set(refs.bodyyaw[2], bodyyaw_add)
    ui_set(refs.fs_bodyyaw, fs)
    ui_set(refs.lby_target, lby)
    ui_set(refs.fakelimit, fakelimit)
end

local function anti_aim()
    if not ui_get(menu.anti_aim) then return end

    local should_md = bit.band(entity_get_prop(entity_get_local_player(), "m_fFlags"), 1) ~= 1 and includes(menu.anti_aim_opts, "Max delta in air")

    if includes(menu.anti_aim_opts, "Dodge on slowwalk") and ui_get(refs.slowwalk[1]) and ui_get(refs.slowwalk[2]) then
        set_anti_aim("Down", "180", 6, "Random", 8, "Static", 90, false, "Eye yaw", 21)
    elseif vars.best_angle == 0 then
        if includes(menu.anti_aim_opts, "Force static body yaw") then
            set_anti_aim("Down", "180", 11, "Off", 0, "Static", 90, true, "Eye yaw", 23)
        else
            set_anti_aim("Down", "180", 4, "Off", 0, "Jitter", 70, false, "Eye yaw", 60)
        end
    elseif vars.best_angle == 1 then
        if vars.misses[vars.best_enemy] == nil then
            set_anti_aim("Down", "180", -2, "Off", 0, "Static", -90, false, "Eye yaw", should_md and 60 or 21)
        else
            set_anti_aim("Down", "180", 8, "Off", 0, "Static", 90, false, "Eye yaw", should_md and 60 or 23)
        end
    elseif vars.best_angle == 2 then
        if vars.misses[vars.best_enemy] == nil or vars.misses[vars.best_enemy] == 2  then
            set_anti_aim("Down", "180", 8, "Off", 0, "Static", 90, false, "Eye yaw", should_md and 60 or 23)
        else
            set_anti_aim("Down", "180", -2, "Off", 0, "Static", -90, false, "Eye yaw", should_md and 60 or 21)
        end
    else
        -- best_angle 3, triggered when both fractions amount to the same value meaning we can't decide a freestanding side. I'll add indexed angles to improve this later.
        set_anti_aim("Down", "180", 6, "Random", 8, "Static", 90, false, "Eye yaw", should_md and 60 or 21)
    end

    if vars.on_use_aa then
        ui_set(refs.pitch, "Off")
        ui_set(refs.yaw[1], "Off")
        if ui_get(menu.on_use_aa_mode) == "Max delta" then
            ui_set(refs.fakelimit, 60)
        end
    end
end

local function miss_detection(e)
    if not ui_get(menu.anti_aim) then return end

    local me, shooter = entity_get_local_player(), client_userid_to_entindex(e.userid)

    if not entity_is_alive(me) or not entity_is_enemy(shooter) or entity_is_dormant(shooter) then return end

    local enemy_pos = vec_3(entity_get_prop(shooter, "m_vecOrigin"))

    for i=1, 19 do
        local local_pos = vec_3(entity_hitbox_position(me, i - 1))
        local dist = ((e.y - enemy_pos.y)*local_pos.x - (e.x - enemy_pos.x)*local_pos.y + e.x*enemy_pos.y - e.y*enemy_pos.x) / math_sqrt((e.y-enemy_pos.y)^2 + (e.x - enemy_pos.x)^2)

        if math_abs(dist) <= 35 and globals_curtime() - vars.last_miss > 0.005 then
            vars.last_miss = globals_curtime()
            if vars.misses[shooter] == nil then
                vars.misses[shooter] = 1 
            elseif vars.misses[shooter] >= 2 then
                vars.misses[shooter] = nil
            else
                vars.misses[shooter] = vars.misses[shooter] + 1
            end
            return
        elseif math_abs(dist) > 250 then
            return -- Just optimizations so we don't run checks for bullets that are nowhere near us 
        end
    end
end

local function brute_reset()
    vars.misses = { }
    vars.last_miss = 0
end

local function anti_aim_on_use(e)
    vars.on_use_aa = false
    if not ui_get(menu.on_use_aa) or not ui_get(menu.on_use_aa_key) or not ui_get(menu.anti_aim) then return end

    local me = entity_get_local_player()

    local dist, c4 = 100, entity_get_all("CPlantedC4")[1]
    local c4_pos = vec_3(entity_get_prop(c4, "m_vecOrigin"))

    if c4_pos.x ~= nil and c4_pos.y ~= nil and c4_pos.z ~= nil then
        local local_pos = vec_3(entity_get_prop(me, "m_vecOrigin"))
        dist = math_sqrt((local_pos.x-c4_pos.x)*(local_pos.x-c4_pos.x) + (local_pos.y-c4_pos.y)*(local_pos.y-c4_pos.y) + (local_pos.z-c4_pos.z)*(local_pos.z-c4_pos.z))
    end

    local team = entity_get_prop(me, "m_iTeamNum")
    local defusing = team == 3 and dist < 62
    local in_bombzone, is_bomb_carrier = entity_get_prop(me, "m_bInBombZone"), entity_has_c4(me)
    local planting = in_bombzone ~= 0 and team == 2 and is_bomb_carrier

    local eye_pos = vec_3(client_eye_position())
    local pitch, yaw = client_camera_angles()
    local dir_vec = vec_3(angle_vector(pitch, yaw))

    local fraction, hit_ent = client_trace_line(me, eye_pos.x, eye_pos.y, eye_pos.z, eye_pos.x + (dir_vec.x * 8192), eye_pos.y + (dir_vec.y * 8192), eye_pos.z + (dir_vec.z * 8192))

    local classname = entity_get_classname(me)
    local using = classname ~= "CWorld" and classname ~= "CCSPlayer" and classname ~= "CFuncBrush"

    if not using and not planting and not defusing then
        e.in_use = 0
        vars.on_use_aa = true
    end
end

local function draw()
    local me = entity_get_local_player()
    if me == nil or not entity_is_alive(me) then return end

    local desync_amt = math_floor(math_min(58, math_abs(entity_get_prop(me, "m_flPoseParameter", 11)*120-60)))
    local screen_w, screen_h = client_screen_size()

    local indicators_clr = color(ui_get(menu.indicators_clr))
    local keybind_clr = color(ui_get(menu.keybind_clr))

    if ui_get(menu.indicators) then
        renderer_gradient(screen_w / 2 - desync_amt, screen_h / 2 + 30, desync_amt, 3, 52, 52, 52, 0, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, true)
        renderer_gradient(screen_w / 2, screen_h / 2 + 30, desync_amt, 3, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, 52, 52, 52, 0, true)
        renderer_text(screen_w / 2, screen_h / 2 + 20, 255, 255, 255, 255, "c", 0, string_format(" %s°", desync_amt))

        -- Of course we could just use inline conditional statements here but the code would end up looking terrible
        if ui_get(refs.bodyyaw[2]) > 0 then
            renderer_text(screen_w / 2 - 10, screen_h / 2 + 40, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "cb", 0, "CAN")
            renderer_text(screen_w / 2 + 11, screen_h / 2 + 40, 255, 255, 255, 255, "cb", 0, "ARY")
        else
            renderer_text(screen_w / 2 + 11, screen_h / 2 + 40, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "cb", 0, "ARY")
            renderer_text(screen_w / 2 - 10, screen_h / 2 + 40, 255, 255, 255, 255, "cb", 0, "CAN")
        end
    end

    if ui_get(menu.debug_panel) then
        local items = { }

        items[#items + 1] = "canary.lua debug panel"
        items[#items + 1] = string_format("best enemy: %s", entity_get_player_name(vars.best_enemy))
        items[#items + 1] = string_format("best angle: %s", vars.best_angle)
        items[#items + 1] = string_format("brute stage: %s", vars.misses[vars.best_enemy] == nil and 0 or vars.misses[vars.best_enemy])
        items[#items + 1] = string_format("last miss: %ss", math_floor(vars.last_miss == 0 and 0 or globals_curtime() - vars.last_miss))
        
        for i=1, #items do
            renderer_text(5, screen_h / 2 + i * 12, 255, 255, 255, 255, nil, 0, string_format("[ %s ]", items[i]))
        end
    end

    if ui_get(menu.keybind_list) then
        local keybinds = { }

        if ui_get(refs.dt[2]) and ui_get(refs.dt[1]) then
            keybinds[#keybinds + 1] = "DT"
        end

        if ui_get(refs.hs[2]) and ui_get(refs.hs[1]) then
            keybinds[#keybinds + 1] = "HIDE"
        end

        if ui_get(refs.sp_key) then
            keybinds[#keybinds + 1] = "SAFE"
        end

        if ui_get(refs.baim_key) then
            keybinds[#keybinds + 1] = "BAIM"
        end

        for i=1, #keybinds do
            renderer_text(screen_w / 2, screen_h / 2 + (ui_get(menu.indicators) and 43 or 13) + i * 9, keybind_clr.r, keybind_clr.g, keybind_clr.b, 255, "c-", 0, keybinds[i])
        end
    end
end

local function doubletap()
    if not ui_get(menu.doubletap) or not ui_get(refs.dt[1]) or not ui_get(refs.dt[2]) and dt_restore then
        ui_set(refs.maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        vars.dt_restore = false
    else
        vars.dt_restore = true

        if includes(menu.doubletap_opts, "Latency based") then
            local latency = math_floor((client_latency() * 1000) / 25)
            latency = latency < 3 and latency or 3
            cvar.cl_clock_correction:set_int(1)
            ui_set(refs.maxprocessticks, ({[3] = 16, [2] = 17, [1] = 18, [0] = 19})[latency])
        else
            cvar.cl_clock_correction:set_int(includes(menu.doubletap_opts, "Instant") and 0 or 1)
            ui_set(refs.maxprocessticks, includes(menu.doubletap_opts, "Instant") and 19 or 18)
        end

        ui_set(refs.dt_hc, includes(menu.doubletap_opts, "Refine hitchance") and 20 or 0)
        ui_set(refs.dt_fl, 1)
        ui_set(refs.dt_mode, "Offensive")
    end
end

local function handle_visibility()
    ui_set_visible(menu.anti_aim_opts, ui_get(menu.anti_aim))
    ui_set_visible(menu.doubletap_opts, ui_get(menu.doubletap))
    ui_set_visible(menu.on_use_aa_key, ui_get(menu.on_use_aa))
    ui_set_visible(menu.on_use_aa_mode, ui_get(menu.on_use_aa))
end

local function on_paint()
    draw()
end

local function on_run_command()
    get_best_enemy()
    get_best_angle()
    anti_aim()
    doubletap()
end

local function on_bullet_impact(e)
    miss_detection(e)
end

local function on_setup_command(e)
    anti_aim_on_use(e)
end

local function event_handling()
    local set_event_callback = ui_get(menu.master_switch) and client_set_event_callback or client_unset_event_callback

    set_event_callback("paint", on_paint)
    set_event_callback("run_command", on_run_command)
    set_event_callback("setup_command", on_setup_command)
    set_event_callback("bullet_impact", on_bullet_impact)
    set_event_callback("client_disconnect", brute_reset)
    set_event_callback("game_newmap", brute_reset)
    set_event_callback("cs_game_disconnected", brute_reset)
    set_event_callback("round_start", brute_reset)
    client_set_event_callback("paint_ui", handle_visibility)
end
event_handling()
ui_set_callback(menu.master_switch, event_handling)