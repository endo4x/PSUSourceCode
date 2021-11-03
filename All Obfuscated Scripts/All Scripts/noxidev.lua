--[[
	id: CThzPMX4w4_oddANDoAEf
	name: noxide v3
	description: noxide v3
	time1: 2021-07-24 08:19:50.722964+00
	time2: 2021-07-24 08:19:50.722965+00
	uploader: VjVCNye1Rtmr8VQGMrKwTHSsmS78rz8iLv3I0iI9
	uploadersession: 1FiXnEOLyWiqXSls9cFIGXA-uRrPYN
	flag: f
--]]

local client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet,
    client_unset_event_callback, client_color_log, client_scale_damage, client_get_cvar, client_camera_position,
    client_create_interface, client_random_int, client_latency, client_find_signature, client_delay_call,
    client_trace_line, client_register_esp_flag, client_exec, client_set_cvar, client_error_log,
    client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float,
    entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive,
    entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_is_dormant, entity_get_player_name,
    entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop, globals_tickcount,
    globals_curtime, globals_tickinterval, ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox,
    ui_new_color_picker, ui_new_checkbox, ui_new_listbox, ui_new_multiselect, ui_new_hotkey, ui_set, ui_set_callback,
    ui_new_button, ui_new_label, ui_new_string, ui_get, renderer_world_to_screen, renderer_circle_outline,
    renderer_rectangle, renderer_gradient, renderer_circle, renderer_text, renderer_line, renderer_triangle,
    renderer_measure_text, renderer_indicator, math_ceil, math_tan, math_randomseed, math_cos, math_sinh, math_random,
    math_huge, math_pi, math_max, math_atan2, math_ldexp, math_floor, math_sqrt, math_deg, math_atan, math_fmod,
    math_acos, math_pow, math_abs, math_min, math_sin, math_frexp, math_log, math_tanh, math_exp, math_modf, math_cosh,
    math_asin, math_rad, table_clear, table_move, table_pack, table_foreach, table_sort, table_remove, table_foreachi,
    table_unpack, table_concat, table_insert, string_format, string_len, string_gsub, string_match, string_byte,
    string_char, string_upper, string_lower, string_sub, bit_band, panorama_loadstring = client.userid_to_entindex,
    client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log,
    client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int,
    client.latency, client.find_signature, client.delay_call, client.trace_line, client.register_esp_flag, client.exec,
    client.set_cvar, client.error_log, client.update_player_list, client.camera_angles, client.eye_position,
    client.draw_hitboxes, client.random_float, entity.get_local_player, entity.is_enemy, entity.get_bounding_box,
    entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname,
    entity.get_player_resource, entity.is_dormant, entity.get_player_name, entity.hitbox_position,
    entity.get_player_weapon, entity.get_players, entity.get_prop, globals.tickcount, globals.curtime,
    globals.tickinterval, ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox,
    ui.new_color_picker, ui.new_checkbox, ui.new_listbox, ui.new_multiselect, ui.new_hotkey, ui.set, ui.set_callback,
    ui.new_button, ui.new_label, ui.new_string, ui.get, renderer.world_to_screen, renderer.circle_outline,
    renderer.rectangle, renderer.gradient, renderer.circle, renderer.text, renderer.line, renderer.triangle,
    renderer.measure_text, renderer.indicator, math.ceil, math.tan, math.randomseed, math.cos, math.sinh, math.random,
    math.huge, math.pi, math.max, math.atan2, math.ldexp, math.floor, math.sqrt, math.deg, math.atan, math.fmod,
    math.acos, math.pow, math.abs, math.min, math.sin, math.frexp, math.log, math.tanh, math.exp, math.modf, math.cosh,
    math.asin, math.rad, table.clear, table.move, table.pack, table.foreach, table.sort, table.remove, table.foreachi,
    table.unpack, table.concat, table.insert, string.format, string.len, string.gsub, string.match, string.byte,
    string.char, string.upper, string.lower, string.sub, bit.band, panorama.loadstring
    
local antiaim_funcs = require("gamesense/antiaim_funcs")    

local images = require "gamesense/images"
local anti_aim = require "gamesense/antiaim_funcs"
local cheatname, build, version = "noxide.lua", "alpha", "v3.1"

local ref = {
    dt = {ui.reference("RAGE", "Other", "Double tap")},
    yaw = {ui.reference("AA", "Anti-aimbot angles", "Yaw")},
    yawj = {ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")},
    bodyyaw = {ui.reference("AA", "Anti-aimbot angles", "Body yaw")},
    fs = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")},
    slowwalk = {ui.reference("AA", "Other", "Slow motion")},
    leg_movement = ui.reference("AA", "Other", "Leg movement"),
    hs = {ui.reference("AA", "Other", "On shot anti-aim")},
    quickpeek = {ui.reference("RAGE", "Other", "Quick peek assist")},
    edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    md = ui.reference("RAGE", "Aimbot", "Minimum damage"),
    sp_key = ui.reference("RAGE", "Aimbot", "Force safe point"),
    baim_key = ui.reference("RAGE", "Other", "Force body aim"),
    fd = ui.reference("RAGE", "Other", "Duck peek assist"),
    dt_mode = ui.reference("RAGE", "Other", "Double tap mode"),
    dt_hc = ui.reference("RAGE", "Other", "Double tap hit chance"),
    dt_fl = ui.reference("RAGE", "Other", "Double tap fake lag limit"),
    pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
    fs_bodyyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    fakelimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    fl = ui.reference("AA", "Fake lag", "Enabled"),
    fl_amt = ui.reference("AA", "Fake lag", "Amount"),
    fl_var = ui.reference("AA", "Fake lag", "Variance"),
    fl_limit = ui.reference("AA", "Fake lag", "Limit"),
    unlag = ui.reference("MISC", "Settings", "sv_maxunlag"),
    maxprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    holdaim = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim"),
    aa_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled")
}

local function reset_clan_tag()
    client.set_clan_tag("\0")
end

local menu = {
    spacer = ui.new_label("LUA", "B", " "),
    line = ui.new_label("LUA", "B", "---  x  ---  x  ---  x  ---  x  ---  x  ---"),
    spacer2 = ui.new_label("LUA", "B", " "),
    master_switch = ui.new_checkbox("LUA", "B", "Enable"),
    maintext = ui.new_label("LUA", "B", cheatname.." ["..version.."] "..build),
    coder = ui.new_label("LUA", "B", "by scary"),

    -- Mode
    mode = ui.new_combobox("LUA", "B", " ", "Rage", "Legit", "Settings"),
    --spacer3 = ui.new_label("LUA", "B", " "),

    -- Rage Sections
    rage_sections = ui.new_combobox("LUA", "B", "Section", "Aimbot", "Anti-Aim", "Visuals", "Misc", "Settings", "Servers"),
    -- Legit Sections
    legit_sections = ui.new_combobox("LUA", "B", "Section", "Legit Aimbot", "Legit Anti-Aim", "Legit Visuals", "Legit Misc", "Legit Settings", "Legit Servers"),
    spacer3 = ui.new_label("LUA", "B", " "),

    rage_aimbot_checkbox = ui.new_checkbox("LUA", "B", "Aimbot"),
    rage_antiaim_checkbox = ui.new_checkbox("LUA", "B", "Anti-Aim"),
    rage_settings_checkbox = ui.new_checkbox("LUA", "B", "Settings"),
    rage_servers_checkbox = ui.new_checkbox("LUA", "B", "Servers"),

    legit_aimbot_checkbox = ui.new_checkbox("LUA", "B", "Legit Aimbot"),
    legit_visuals_checkbox = ui.new_checkbox("LUA", "B", "Legit Visuals"),
    legit_misc_checkbox = ui.new_checkbox("LUA", "B", "Legit Misc"),
    legit_settings_checkbox = ui.new_checkbox("LUA", "B", "Legit Settings"),
    legit_servers_checkbox = ui.new_checkbox("LUA", "B", "Legit Servers"),

    main_colour_text = ui.new_label("LUA", "B", "Primary Colour"),
    main_colour = ui.new_color_picker("LUA", "B", "Main Lua Colour", 255, 47, 47, 255),

    -- rage visuals
    crosshair_indicator_switch = ui.new_checkbox("LUA", "B", "Crosshair Indicators"),
    debug_info_switch = ui.new_checkbox("LUA", "B", "Debug Info"),

    -- rage misc
    clantag_changer_switch = ui.new_checkbox("LUA", "B", "Clantag"),
    hit_logs_switch = ui.new_checkbox("LUA", "B", "Custom Hitlogs"),
    show_kd_switch = ui.new_checkbox("LUA", "B", "Show K/D (Needs Hitlogs)"),
    reset_clan_tag_button = ui.new_button("LUA", "B", "Reset Clantag", reset_clan_tag),

    -- Legit Anti-Aim

    spacerlast = ui.new_label("LUA", "B", " "),
    linelast = ui.new_label("LUA", "B", "---  x  ---  x  ---  x  ---  x  ---  x  ---"),

}

local wnd = {
    x = database.read("dt_x") or 250,
    y = database.read("dt_y") or 25,
    w = 200,
    dragging = false,
    rx = 0,
}

local function intersect(x, y, w, h, debug) 
    local cx, cy = ui.mouse_position()
    debug = debug or false
    if debug then 
        renderer.rectangle(x, y, w, h, 255, 0, 0, 50)
    end
    return cx >= x and cx <= x + w and cy >= y and cy <= y + h
end

local c_r, c_g, c_b, c_a = ui.get(menu.main_colour)
local local_player = entity.get_local_player()
local local_player_name = entity.get_player_name(local_player)

local function mode_visible(visible)
    ui.set_visible(menu.mode, visible)
end

local function rage_visible(visible)
    ui.set_visible(menu.rage_sections, visible)
end

local function legit_visible(visible)
    ui.set_visible(menu.legit_sections, visible)
end

local function rage_aimbot_visible(visible)
    ui.set_visible(menu.rage_aimbot_checkbox, visible)
end

local function rage_visuals_visible(visible)
    ui.set_visible(menu.crosshair_indicator_switch, visible)
    ui.set_visible(menu.debug_info_switch, visible)
end

local function rage_antiaim_visible(visible)
    ui.set_visible(menu.rage_antiaim_checkbox, visible)
end

local function rage_misc_visible(visible)
    ui.set_visible(menu.clantag_changer_switch, visible)
    ui.set_visible(menu.reset_clan_tag_button, visible)
    ui.set_visible(menu.hit_logs_switch, visible)
    ui.set_visible(menu.show_kd_switch, visible)
end

local function rage_settings_visible(visible)
    ui.set_visible(menu.rage_settings_checkbox, visible)
end

local function rage_servers_visible(visible)
    ui.set_visible(menu.rage_servers_checkbox, visible)
end

local function legit_aimbot_visible(visible)
    ui.set_visible(menu.legit_aimbot_checkbox, visible)
end

local function legit_visuals_visible(visible)
    ui.set_visible(menu.legit_visuals_checkbox, visible)
end

local function legit_antiaim_visible(visible)
    --ui.set_visible(menu.legit_aa_switch, visible)
end

local function legit_misc_visible(visible)
    ui.set_visible(menu.legit_misc_checkbox, visible)
end

local function legit_settings_visible(visible)
    ui.set_visible(menu.legit_settings_checkbox, visible)
end

local function legit_servers_visible(visible)
    ui.set_visible(menu.legit_servers_checkbox, visible)
end

local console_msg = {
    ' ',
    '                              $$\\       $$\\           ',
    '                              \\__|      $$ |          ',
    '$$$$$$$\\   $$$$$$\\  $$\\   $$\\ $$\\  $$$$$$$ | $$$$$$\\  ',
    '$$  __$$\\ $$  __$$\\ \\$$\\ $$  |$$ |$$  __$$ |$$  __$$\\ ',
    '$$ |  $$ |$$ /  $$ | \\$$$$  / $$ |$$ /  $$ |$$$$$$$$ |',
    '$$ |  $$ |$$ |  $$ | $$  $$<  $$ |$$ |  $$ |$$   ____|',
    '$$ |  $$ |\\$$$$$$  |$$  /\\$$\\ $$ |\\$$$$$$$ |\\$$$$$$$\\ ',
    '\\__|  \\__| \\______/ \\__/  \\__|\\__| \\_______| \\_______|',
    ' ',
}

for i = 1, #console_msg do
    client.color_log(255, 255, 255, console_msg[i])
end

if local_player_name == "unknown" then
    local_player_name = "user"
end

client.color_log(255, 255, 255, "[\0")
client.color_log(c_r, c_g, c_b, "noxide\0")
client.color_log(255, 255, 255, "]\0")
client.color_log(255, 255, 255, " welcome back, \0")
client.color_log(c_r, c_g, c_b, local_player_name.."\0")
client.color_log(255, 255, 255, ".")

client.color_log(255, 255, 255, "[\0")
client.color_log(c_r, c_g, c_b, "noxide\0")
client.color_log(255, 255, 255, "]\0")
client.color_log(255, 255, 255, " version [\0")
client.color_log(c_r, c_g, c_b, version.."\0")
client.color_log(255, 255, 255, "]")

client.color_log(255, 255, 255, "[\0")
client.color_log(c_r, c_g, c_b, "noxide\0")
client.color_log(255, 255, 255, "]\0")
client.color_log(255, 255, 255, " build [\0")
client.color_log(c_r, c_g, c_b, build.."\0")
client.color_log(255, 255, 255, "]\0")
client.color_log(255, 255, 255, " ")

local function set_visible()

    -- RAGE STUFF

    if ui.get(menu.master_switch) then
        mode_visible(true)
    else
        mode_visible(false)
    end

    if ui.get(menu.mode) == "Settings" and ui.get(menu.master_switch) then
        ui.set_visible(menu.main_colour, true)
        ui.set_visible(menu.main_colour_text, true)
    else
        ui.set_visible(menu.main_colour, false)
        ui.set_visible(menu.main_colour_text, false)
    end


    if ui.get(menu.mode) == "Rage" and ui.get(menu.master_switch) then
        rage_visible(true)
    else
        rage_visible(false)
    end

    if ui.get(menu.mode) == "Legit" and ui.get(menu.master_switch) then
        legit_visible(true)
    else
        legit_visible(false)
    end

    if ui.get(menu.rage_sections) == "Aimbot" and ui.get(menu.mode) == "Rage" and ui.get(menu.master_switch)  then
        rage_aimbot_visible(true)
    else
        rage_aimbot_visible(false)
    end

    if ui.get(menu.rage_sections) == "Anti-Aim" and ui.get(menu.mode) == "Rage" and ui.get(menu.master_switch)  then
        rage_antiaim_visible(true)
    else
        rage_antiaim_visible(false)
    end

    if ui.get(menu.rage_sections) == "Visuals" and ui.get(menu.mode) == "Rage" and ui.get(menu.master_switch)  then
        rage_visuals_visible(true)
    else
        rage_visuals_visible(false)
    end

    if ui.get(menu.rage_sections) == "Misc" and ui.get(menu.mode) == "Rage" and ui.get(menu.master_switch)  then
        rage_misc_visible(true)
    else
        rage_misc_visible(false)
    end

    if ui.get(menu.rage_sections) == "Settings" and ui.get(menu.mode) == "Rage" and ui.get(menu.master_switch)  then
        rage_settings_visible(true)
    else
        rage_settings_visible(false)
    end

    if ui.get(menu.rage_sections) == "Servers" and ui.get(menu.mode) == "Rage" and ui.get(menu.master_switch)  then
        rage_servers_visible(true)
    else
        rage_servers_visible(false)
    end

    -- LEGIT STUFF

    if ui.get(menu.legit_sections) == "Legit Aimbot" and ui.get(menu.mode) == "Legit" and ui.get(menu.master_switch)  then
        legit_aimbot_visible(true)
    else
        legit_aimbot_visible(false)
    end

    if ui.get(menu.legit_sections) == "Legit Anti-Aim" and ui.get(menu.mode) == "Legit" and ui.get(menu.master_switch)  then
        legit_antiaim_visible(true)
    else
        legit_antiaim_visible(false)
    end

    if ui.get(menu.legit_sections) == "Legit Visuals" and ui.get(menu.mode) == "Legit" and ui.get(menu.master_switch)  then
        legit_visuals_visible(true)
    else
        legit_visuals_visible(false)
    end

    if ui.get(menu.legit_sections) == "Legit Misc" and ui.get(menu.mode) == "Legit" and ui.get(menu.master_switch)  then
        legit_misc_visible(true)
    else
        legit_misc_visible(false)
    end

    if ui.get(menu.legit_sections) == "Legit Settings" and ui.get(menu.mode) == "Legit" and ui.get(menu.master_switch)  then
        legit_settings_visible(true)
    else
        legit_settings_visible(false)
    end

    if ui.get(menu.legit_sections) == "Legit Servers" and ui.get(menu.mode) == "Legit" and ui.get(menu.master_switch)  then
        legit_servers_visible(true)
    else
        legit_servers_visible(false)
    end

end

local function watermark()

    if not ui.get(menu.master_switch) then return end

    local width, height = client.screen_size()
    local width_center, height_center = width/2, height/2
    local local_player = entity.get_local_player()
    local local_player_name = entity.get_player_name(local_player)
    local latency = math.floor(client.latency() * 1000 + 0.5)
    local hours, minutes, seconds = client.system_time()
    local width, height = client.screen_size()
    local c_r, c_g, c_b, c_a = ui.get(menu.main_colour)

    local text = "["..cheatname.."] "..version.." ["..build.."] | "..local_player_name.." | "..string.format("%02d:%02d:%02d", hours, minutes, seconds)

    local margin, padding, flags = 18, 5, ""
    local text_width, text_height = renderer.measure_text(flags, text)

    renderer.rectangle(width - text_width - margin - padding, margin - padding, text_width + padding * 2, text_height + padding * 2, 30, 30, 30, 180)
    renderer.rectangle(width - text_width - margin - padding, margin - padding, text_width + padding * 2, 1, c_r, c_g, c_b, 255)
    renderer.text(width - text_width - margin, margin, 235, 235, 235, 255, flags, 0, text)

end

local function doubletap_charged()

    local double_tap, double_tap_key = ui.reference("RAGE", "Other", "Double tap")
    local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")

    if not ui.get(double_tap) or not ui.get(double_tap_key) or ui.get(fakeduck) then
        return false
    end

    local me = entity.get_local_player()
    if me == nil or not entity.is_alive(me) then
        return false
    end

    local weapon = entity.get_prop(me, "m_hActiveWeapon")
    if weapon == nil then
        return false
    end

    local next_attack = entity.get_prop(me, "m_flNextAttack") + 0.25
    local next_primary_attack = entity.get_prop(weapon, "m_flNextPrimaryAttack") + 0.5
    if next_attack == nil or next_primary_attack == nil then
        return false
    end

    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end

local nonweapons_c = {
    "CKnife",
    "CHEGrenade",
    "CMolotovGrenade",
    "CIncendiaryGrenade",
    "CFlashbang",
    "CDecoyGrenade",
    "CSmokeGrenade",
    "CWeaponTaser",
    "CC4"
}

local function crosshair_indicators()

    if not ui.get(menu.crosshair_indicator_switch) or not ui.get(menu.master_switch) or ui.get(menu.mode) == "Legit" then return end

    local local_player = entity.get_local_player()

    if not ui.get(menu.master_switch) then return end
    if not ui.get(menu.mode) == "Rage" or not ui.get(menu.mode) == "Settings" then return end
    if not entity.is_alive(local_player) then return end

    local desync = anti_aim.get_desync(1)
    local offset = 49
    local c_r, c_g, c_b, c_a = ui.get(menu.main_colour)
    local indicator_flags = "c-"
    local text_flags = "bc"

    local width, height = client.screen_size()
    local width_center, height_center = width/2, height/2
    local camera_angles = { client.camera_angles() }
    local by = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(1) - 120)
    local fy = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(2) - 120)

    --renderer.text(width_center, height_center + 22, 255, 255, 255, 255, text_flags, 0, "noxide°")

    if desync < 0 then
        renderer.text(width_center - 10, height_center + 22, 255, 255, 255, 255, text_flags, 0, "nox")
        renderer.text(width_center + 9.5, height_center + 22, c_r, c_g, c_b, 255, text_flags, 0, "ide°")
    else
        renderer.text(width_center - 10, height_center + 22, c_r, c_g, c_b, 255, text_flags, 0, "nox")
        renderer.text(width_center + 9.5, height_center + 22, 255, 255, 255, 255, text_flags, 0, "ide°")
    end

    renderer.rectangle(width_center, height_center + 34, 29, 4, 0, 0, 0, 120)
    renderer.rectangle(width_center, height_center + 34, -29, 4, 0, 0, 0, 120)
    renderer.rectangle(width_center, height_center + 34 + 1, desync / 2, 2, c_r, c_g, c_b, 255)
    renderer.rectangle(width_center, height_center + 34 + 1, -desync / 2, 2, c_r, c_g, c_b, 255)

    renderer.circle_outline(width_center, height_center, 0, 0, 0, 120, 10, 0, 1, 3)
    renderer.circle_outline(width_center, height_center, c_r, c_g, c_b, 255, 10, fy, 0.3, 3)

    if ui.get(ref.dt[1]) and ui.get(ref.dt[2]) then
        if not doubletap_charged() then
            renderer.text(width_center, height_center + offset, 255, 255, 255, 255, indicator_flags, 0, "DOUBLETAP")
            offset = offset + 11
        else
            renderer.text(width_center, height_center + offset, c_r, c_g, c_b, 255, indicator_flags, 0, "DOUBLETAP")
            offset = offset + 11
        end
    end

    if ui.get(ref.hs[1]) and ui.get(ref.hs[2]) then
        if ui.get(ref.dt[2]) or ui.get(ref.fd) then
            renderer.text(width_center, height_center + offset, 255, 255, 255, 255, indicator_flags, 0, "HIDESHOTS")
            offset = offset + 11
        else
            renderer.text(width_center, height_center + offset, c_r, c_g, c_b, 255, indicator_flags, 0, "HIDESHOTS")
            offset = offset + 11
        end
    end

    if ui.get(ref.fd) then
        renderer.text(width_center, height_center + offset, c_r, c_g, c_b, 255, indicator_flags, 0, "FAKEDUCK")
        offset = offset + 11
    end

    if ui.get(ref.quickpeek[1]) and ui.get(ref.quickpeek[2]) then
        if ui.get(ref.dt[2]) then
            renderer.text(width_center, height_center + offset, c_r, c_g, c_b, 255, indicator_flags, 0, "IDEAL TICK")
            offset = offset + 11
        else
            renderer.text(width_center, height_center + offset, c_r, c_g, c_b, 255, indicator_flags, 0, "QUICKPEEK")
            offset = offset + 11
        end
    end
end

local function debug_info()

    if not ui.get(menu.debug_info_switch) or not ui.get(menu.master_switch) or ui.get(menu.mode) == "Legit" then return end
    if not entity.is_alive(local_player) then return end

    local cx, cy = ui.mouse_position()
    local left_click = client.key_state(0x01)
    local c_r, c_g, c_b, c_a = ui.get(menu.main_colour)

        if ui.is_menu_open() then 
            if wnd.dragging and not left_click then
                wnd.dragging = false
            end
        
            if wnd.dragging and left_click then
                wnd.x = cx - wnd.drag_x
                wnd.y = cy - wnd.drag_y
            end
        
            if intersect(wnd.x, wnd.y, wnd.w, 25) and left_click then 
                wnd.dragging = true
                wnd.drag_x = cx - wnd.x
                wnd.drag_y = cy - wnd.y
            end
        end

    local margin, padding, flags = 18, 5, ""
    local text_width, text_height = renderer.measure_text(flags, text)

    local vx, vy, vz = entity.get_prop(local_player, "m_vecVelocity")
	local speed = math.floor(math.sqrt(vx ^ 2 + vy ^ 2))
    local desync_strength = math.floor(math.min(58, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60)))

    if speed == 249 then
        speed = 250
    end

    if speed == 1 then
        speed = 0
    end

    local visual_speed = speed
    if visual_speed > 166 then
        visual_speed = 166
    end

    local visual_desync_strength = desync_strength
    if visual_desync_strength == 57 then
        visual_desync_strength = 60
    end

    wnd.w = 200 -- width of box

    renderer.rectangle(wnd.x, wnd.y + 1, wnd.w, text_height+padding*20, 15, 15, 15, 255)
    renderer.rectangle(wnd.x, wnd.y + 1, wnd.w, text_height+padding*3, 10, 10, 10, 255)
    renderer.rectangle(wnd.x, wnd.y + 1, wnd.w, 1, c_r, c_g, c_b, 255)
    renderer.text(wnd.x + wnd.w / 2, wnd.y + 14, 255, 255, 255, 255, "-c", 0, "DEBUG INFORMATION")
    renderer.text(wnd.x + wnd.w / 2, wnd.y + 40, 255, 255, 255, 255, "-c", 0, "VELOCITY   "..speed)
    renderer.rectangle(wnd.x + 15, wnd.y + 52, 170, 10, 10, 10, 10, 255)
    renderer.rectangle(wnd.x + 17, wnd.y + 54, visual_speed, 6, c_r, c_g, c_b, 255)

    renderer.text(wnd.x + wnd.w / 2, wnd.y + 40 + 35, 255, 255, 255, 255, "-c", 0, "DESYNC   "..visual_desync_strength)
    renderer.rectangle(wnd.x + 15, wnd.y + 52 + 35, 170, 10, 10, 10, 10, 255)
    renderer.rectangle(wnd.x + 17, wnd.y + 54 + 35, desync_strength * 2.92, 6, c_r, c_g, c_b, 255)


end

local time = 0
local x = 1

local function clantag_changer()

    if not ui.get(menu.clantag_changer_switch) or not ui.get(menu.master_switch) or ui.get(menu.mode) == "Legit" then return end
    local clantags = {
        'N',
        'NO',
        'NOX',
        'NOXI',
        'NOXID',
        'NOXIDE',
        'NOXIDE.LUA',
        'NOXIDE',
        'NOXIDE.LUA',
        'NOXIDE',
        'NOXID',
        'NOXI',
        'NOX',
        'NO',
        'N',
        '',
    }

    if globals.realtime() >= time then
        client.set_clan_tag(clantags[x]) -- setting the clantag between the tags in the table based on the true or false variable a
        time = globals.realtime() + 0.5 -- you can change the number depending on how fast you want the clantag to show
        x = x + 1
    end

    if x == #clantags + 1 then
        x = 1
    end
end

local hits = 0
local misses = 0

client.set_event_callback("aim_hit", function(e)

    if not ui.get(menu.hit_logs_switch) or not ui.get(menu.master_switch) or ui.get(menu.mode) == "Legit" then return end

        local hitgroup_names = { "generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
        local group = hitgroup_names[e.hitgroup + 1] or "?"

        local ent = e.target
        local hc = e.hit_chance
        local dmg = e.damage
        local health = entity.get_prop(ent, "m_iHealth")
        local name = entity.get_player_name(ent)

            hits = hits + 1

        client.color_log(255, 255, 255, "[\0")
        client.color_log(118, 255, 101, "noxide\0")
        client.color_log(255, 255, 255, "]\0")
        client.color_log(255, 255, 255, " Hit \0")
        client.color_log(118, 255, 101, name .. "\0")
        client.color_log(255, 255, 255, " for \0")
        client.color_log(118, 255, 101, dmg .. "\0")
        client.color_log(255, 255, 255, " in the \0")
        client.color_log(118, 255, 101, group .. "\0")
        client.color_log(255, 255, 255, " with \0")
        client.color_log(118, 255, 101, hc .. "%\0")
        client.color_log(255, 255, 255, " hitchance. (\0")
        client.color_log(118, 255, 101, health .. "\0")
        client.color_log(255, 255, 255, " health remaining).")
end)

client.set_event_callback("aim_miss", function(e)

    if not ui.get(menu.hit_logs_switch) or not ui.get(menu.master_switch) or ui.get(menu.mode) == "Legit" then return end

    local hitgroup_names = { "generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
    local group = hitgroup_names[e.hitgroup + 1] or "?"

    local ent = e.target
    local reason = e.reason
    local hc = e.hit_chance
    local name = entity.get_player_name(ent)

    if reason == "?" then -- not sure why it missed
        reason = "shit cheat"
    end

        misses = misses + 1

    client.color_log(255, 255, 255, "[\0")
    client.color_log(255, 47, 47, "noxide\0")
    client.color_log(255, 255, 255, "]\0")
    client.color_log(255, 255, 255, " Missed \0")
    client.color_log(255, 47, 47, name .. "\0")
    client.color_log(255, 255, 255, "'s \0")
    client.color_log(255, 47, 47, group .. "\0")
    client.color_log(255, 255, 255, " due to \0")
    client.color_log(2255, 47, 47, reason .. "\0")
    client.color_log(255, 255, 255, ".")
end)

local function kd_calculator()
    local p_r, p_g, p_b, p_a = ui.get(menu.main_colour)

    if not ui.get(menu.show_kd_switch) or not ui.get(menu.master_switch) or ui.get(menu.mode) == "Legit" then return end

    local width, height = client.screen_size()
    local width_center, height_center = width/2, height/2
    local box_height = 70
    local hit_miss_ratio = hits / misses

    renderer.gradient(width_center, height - box_height, 300, box_height, 0, 0, 0, 120, 0, 0, 0, 0, true)
    renderer.gradient(width_center - 300, height - box_height, 300, box_height, 0, 0, 0, 0, 0, 0, 0, 120, true)
    renderer.text(width_center, height - box_height / 2 - 13, 255, 255, 255, 255, "bc", 0, "HITS: "..hits)
    renderer.text(width_center, height - box_height / 2, 255, 255, 255, 255, "bc", 0, "MISSES: "..misses)
    if misses == 0 then
        hit_miss_ratio = hits
    else
        hit_miss_ratio = hits / misses
    end
    renderer.text(width_center, height - box_height / 2 + 13, p_r, p_g, p_b, 255, "bc", 0, "RATIO: "..math.floor(hit_miss_ratio * 100) / 100)
end

local function on_paint_ui()
    set_visible()
    watermark()
    clantag_changer()
end

local function on_paint()
    kd_calculator()
    debug_info()
    crosshair_indicators()
    debug_info()
end

local function on_run_command()

end

local function main()
    client.set_event_callback("paint_ui", on_paint_ui)
    client.set_event_callback("paint", on_paint)
    client.set_event_callback("run_command", on_run_command)
end
main()
