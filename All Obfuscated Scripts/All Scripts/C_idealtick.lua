--[[
	id: 9mdSkZ23ftLTEOQ9MA9Gv
	name: C_idealtick
	description: C_idealtick
	time1: 2021-07-13 18:42:59.833832+00
	time2: 2021-07-13 18:42:59.833834+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

--local variables for API functions. any changes to the line below will be lost on re-generation
local bit_band, client_camera_angles, client_eye_position, client_key_state, client_log, client_scale_damage, client_screen_size, client_set_event_callback, client_trace_bullet, client_trace_line, client_userid_to_entindex, entity_get_all, entity_get_classname, entity_get_local_player, entity_get_player_resource, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, entity_is_dormant, entity_is_enemy, globals_curtime, globals_tickcount, globals_tickinterval, math_abs, math_atan, math_atan2, math_cos, math_deg, math_floor, math_max, math_min, math_rad, math_sin, math_sqrt, panorama_loadstring, panorama_open, renderer_circle_outline, renderer_gradient, renderer_indicator, renderer_line, renderer_rectangle, renderer_text, table_remove, ui_get, ui_new_color_picker, ui_new_combobox, ui_new_hotkey, ui_new_label, ui_new_multiselect, ui_new_slider, ui_reference, ui_set, ui_set_visible, type, ui_set_callback = bit.band, client.camera_angles, client.eye_position, client.key_state, client.log, client.scale_damage, client.screen_size, client.set_event_callback, client.trace_bullet, client.trace_line, client.userid_to_entindex, entity.get_all, entity.get_classname, entity.get_local_player, entity.get_player_resource, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, entity.is_dormant, entity.is_enemy, globals.curtime, globals.tickcount, globals.tickinterval, math.abs, math.atan, math.atan2, math.cos, math.deg, math.floor, math.max, math.min, math.rad, math.sin, math.sqrt, panorama.loadstring, panorama.open, renderer.circle_outline, renderer.gradient, renderer.indicator, renderer.line, renderer.rectangle, renderer.text, table.remove, ui.get, ui.new_color_picker, ui.new_combobox, ui.new_hotkey, ui.new_label, ui.new_multiselect, ui.new_slider, ui.reference, ui.set, ui.set_visible, type, ui.set_callback
local renderer_triangle, entity_get_player_weapon, renderer_circle, ui_mouse_position, ui_menu_position, ui_menu_size, ui_is_menu_open = renderer.triangle, entity.get_player_weapon, renderer.circle, ui.mouse_position, ui.menu_position, ui.menu_size, ui.is_menu_open
local ref = {
	enabled = ui_reference("AA", "Anti-aimbot angles", "Enabled"),
	pitch = ui_reference("AA", "Anti-aimbot angles", "pitch"),
	yawbase = ui_reference("AA", "Anti-aimbot angles", "Yaw base"),
    fakeyawlimit = ui_reference("AA", "anti-aimbot angles", "Fake yaw limit"),
    fsbodyyaw = ui_reference("AA", "anti-aimbot angles", "Freestanding body yaw"),
    edgeyaw = ui_reference("AA", "Anti-aimbot angles", "Edge yaw"),
    maxprocticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    fakeduck = ui_reference("RAGE", "Other", "Duck peek assist"),
    safepoint = ui_reference("RAGE", "Aimbot", "Force safe point"),
	forcebaim = ui_reference("RAGE", "Other", "Force body aim"),
	player_list = ui_reference("PLAYERS", "Players", "Player list"),
	reset_all = ui_reference("PLAYERS", "Players", "Reset all"),
	apply_all = ui_reference("PLAYERS", "Adjustments", "Apply to all"),
	load_cfg = ui_reference("Config", "Presets", "Load"),
	fl_limit = ui_reference("AA", "Fake lag", "Limit"),
    rage = { ui_reference("RAGE", "Aimbot", "Enabled") },
    yaw = { ui_reference("AA", "Anti-aimbot angles", "Yaw") }, 
	quickpeek = { ui_reference("RAGE", "Other", "Quick peek assist") },
	yawjitter = { ui_reference("AA", "Anti-aimbot angles", "Yaw jitter") },
	bodyyaw = { ui_reference("AA", "Anti-aimbot angles", "Body yaw") },
	freestand = { ui_reference("AA", "Anti-aimbot angles", "Freestanding") },
	os = { ui_reference("AA", "Other", "On shot anti-aim") },
	slow = { ui_reference("AA", "Other", "Slow motion") },
	dt = { ui_reference("RAGE", "Other", "Double tap") },
	fakelag = { ui_reference("AA", "Fake lag", "Enabled") }
}
local exploit = ui.new_checkbox('AA', 'Fake lag', 'ideal tick')
local luaBYFiveFive = ui.new_hotkey('AA', 'Fake lag', 'ideal tick key', true)
local fakelaglimit =  ui.new_slider("aa", "fake lag", "Fl Limit", 0, 20, 10, true)

local v = {
    hotkey_modes = { "Always on", "On hotkey", "Toggle", "Off hotkey" },
    holding_e = false,
    dir = { manual = 0, fs = false, edge = false, time = 0 },
    last_shot = 0
}

local ideal_data = {
    o = {0, 0, 0},
    b = "On hotkey",
    q = { false, "On hotkey" },
    dt = { false, "On hotkey" },
    fs = false,
    store = true,
    limit = 0
}

local function round(num, decimals)
	local mult = 10^(decimals or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function get_key_mode(ref)
	local k = { ui_get(ref) }
	local hk_mode = k[2]
	if hk_mode == nil then
		return "nil"
	end
    return v.hotkey_modes[hk_mode + 1]
end

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function calc_degrees(xdelta, ydelta)
    if xdelta == 0 and ydelta == 0 then
        return 0
	end
	
    return math_deg(math_atan2(ydelta, xdelta))
end

local function get_nearest_enemy(eye, view)

    if eye == nil then
        eye = { client.eye_position() }
        view = { client.camera_angles() }
    end

    local enemies = entity_get_players(true)

    if #enemies == 0 then
        return 0
    end
    
	local bestenemy = 0
    local fov = 181
    for i=1, #enemies do
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math_abs(normalize_yaw(calc_degrees(eye[1] - cur_x, eye[2] - cur_y) - view[2] + 180))
        if cur_fov < fov then
			fov = cur_fov
			bestenemy = enemies[i]
		end
	end
	return bestenemy
end

local function ideal_tick(plocal, cmd)
    local target = get_nearest_enemy()
    if not ui_get(luaBYFiveFive) or not ui_get(exploit) or not ui_get(ref.dt[2]) then
        if not ideal_data.store then
            v.dir.freestand = ideal_data.fs
            ui_set(ref.quickpeek[1], ideal_data.q[1])
            ui_set(ref.quickpeek[2], ideal_data.q[2])
            ui_set(ref.forcebaim, ideal_data.b)
            ui_set(ref.dt[1], ideal_data.dt[1])
            ui_set(ref.dt[2], ideal_data.dt[2])
            ui_set(ref.rage[1], true)
            ideal_data.store = true
            ui_set(ref.fl_limit,ui_get(fakelaglimit))
        end
        return
    end

    if ideal_data.store then
        ideal_data = {
            o = {0, 0, 0},
            b = get_key_mode(ref.forcebaim),
            q = { ui_get(ref.quickpeek[1]), get_key_mode(ref.quickpeek[2]) },
            dt = { ui_get(ref.dt[1]), get_key_mode(ref.dt[2]) },
            fs = v.dir.freestand,
            store = false
        }
    end

    if v.last_shot + 0.7 < globals_curtime() then
        --ui_set(ref.rage[1], true)
        --ui_set(ref.dt[2], "Always on")
    end

    v.dir.freestand = not v.holding_e
    ui_set(ref.dt[1], true)

    ui_set(ref.fl_limit, 1)
    ui_set(ref.quickpeek[1], true)
    ui_set(ref.quickpeek[2], "Always on")
end

local function on_aim_fire(e)
    v.last_shot = globals_curtime()
end

local function indicator()
    local x,y = client.screen_size()
    local ideal_charge = round(math.max(0, math.min(100, (globals_curtime() - v.last_shot) / 0.01)))
    if ui_get(luaBYFiveFive) and ui_get(exploit) and ui_get(ref.dt[2]) then
        renderer_text(x/2, y/2-35, 255, 255, 255, 255, "c-", 0, "IDEAL TICK"..tostring(ideal_charge)..'%')
    end
end

local function on_setup_command(cmd)
    local plocal = entity_get_local_player()
    ideal_tick(plocal, cmd)
end
local function start()
    client_set_event_callback("setup_command", on_setup_command)
    client_set_event_callback('paint',indicator)
    client_set_event_callback("aim_fire", on_aim_fire)
end
start()