--[[
	id: CSZbcco7E0eouAR-GeK2a
	name: nig-yaw.recode
	description: recode
	time1: 2021-05-16 05:40:24.20924+00
	time2: 2021-05-16 05:40:24.20924+00
	uploader: m7NKuVV0AK8pAbxEXM5bXS7dbOytkSI4qEkhXhy-
	uploadersession: X_6akyXNlAOc4QtWx762aHJmPlTVYy
	flag: f
--]]

-- start
local client_userid_to_entindex,
    client_set_event_callback,
    client_screen_size,
    client_trace_bullet,
    client_unset_event_callback,
    client_color_log,
    client_scale_damage,
    client_get_cvar,
    client_camera_position,
    client_create_interface,
    client_random_int,
    client_latency,
    client_find_signature,
    client_delay_call,
    client_trace_line,
    client_register_esp_flag,
    client_exec,
    client_set_cvar,
    client_error_log,
    client_update_player_list,
    client_camera_angles,
    client_eye_position,
    client_draw_hitboxes,
    client_random_float,
    entity_get_local_player,
    entity_is_enemy,
    entity_get_bounding_box,
    entity_get_all,
    entity_set_prop,
    entity_is_alive,
    entity_get_steam64,
    entity_get_classname,
    entity_get_player_resource,
    entity_is_dormant,
    entity_get_player_name,
    entity_hitbox_position,
    entity_get_player_weapon,
    entity_get_players,
    entity_get_prop,
    globals_tickcount,
    globals_curtime,
    globals_tickinterval,
    ui_new_slider,
    ui_new_combobox,
    ui_reference,
    ui_set_visible,
    ui_new_textbox,
    ui_new_color_picker,
    ui_new_checkbox,
    ui_new_listbox,
    ui_new_multiselect,
    ui_new_hotkey,
    ui_set,
    ui_set_callback,
    ui_new_button,
    ui_new_label,
    ui_new_string,
    ui_get,
    renderer_world_to_screen,
    renderer_circle_outline,
    renderer_rectangle,
    renderer_gradient,
    renderer_circle,
    renderer_text,
    renderer_line,
    renderer_triangle,
    renderer_measure_text,
    renderer_indicator,
    math_ceil,
    math_tan,
    math_randomseed,
    math_cos,
    math_sinh,
    math_random,
    math_huge,
    math_pi,
    math_max,
    math_atan2,
    math_ldexp,
    math_floor,
    math_sqrt,
    math_deg,
    math_atan,
    math_fmod,
    math_acos,
    math_pow,
    math_abs,
    math_min,
    math_sin,
    math_frexp,
    math_log,
    math_tanh,
    math_exp,
    math_modf,
    math_cosh,
    math_asin,
    math_rad,
    table_clear,
    table_move,
    table_pack,
    table_foreach,
    table_sort,
    table_remove,
    table_foreachi,
    table_unpack,
    table_concat,
    table_insert,
    string_format,
    string_len,
    string_gsub,
    string_match,
    string_byte,
    string_char,
    string_upper,
    string_lower,
    string_sub,
    bit_band,
    panorama_loadstring =
    client.userid_to_entindex,
    client.set_event_callback,
    client.screen_size,
    client.trace_bullet,
    client.unset_event_callback,
    client.color_log,
    client.scale_damage,
    client.get_cvar,
    client.camera_position,
    client.create_interface,
    client.random_int,
    client.latency,
    client.find_signature,
    client.delay_call,
    client.trace_line,
    client.register_esp_flag,
    client.exec,
    client.set_cvar,
    client.error_log,
    client.update_player_list,
    client.camera_angles,
    client.eye_position,
    client.draw_hitboxes,
    client.random_float,
    entity.get_local_player,
    entity.is_enemy,
    entity.get_bounding_box,
    entity.get_all,
    entity.set_prop,
    entity.is_alive,
    entity.get_steam64,
    entity.get_classname,
    entity.get_player_resource,
    entity.is_dormant,
    entity.get_player_name,
    entity.hitbox_position,
    entity.get_player_weapon,
    entity.get_players,
    entity.get_prop,
    globals.tickcount,
    globals.curtime,
    globals.tickinterval,
    ui.new_slider,
    ui.new_combobox,
    ui.reference,
    ui.set_visible,
    ui.new_textbox,
    ui.new_color_picker,
    ui.new_checkbox,
    ui.new_listbox,
    ui.new_multiselect,
    ui.new_hotkey,
    ui.set,
    ui.set_callback,
    ui.new_button,
    ui.new_label,
    ui.new_string,
    ui.get,
    renderer.world_to_screen,
    renderer.circle_outline,
    renderer.rectangle,
    renderer.gradient,
    renderer.circle,
    renderer.text,
    renderer.line,
    renderer.triangle,
    renderer.measure_text,
    renderer.indicator,
    math.ceil,
    math.tan,
    math.randomseed,
    math.cos,
    math.sinh,
    math.random,
    math.huge,
    math.pi,
    math.max,
    math.atan2,
    math.ldexp,
    math.floor,
    math.sqrt,
    math.deg,
    math.atan,
    math.fmod,
    math.acos,
    math.pow,
    math.abs,
    math.min,
    math.sin,
    math.frexp,
    math.log,
    math.tanh,
    math.exp,
    math.modf,
    math.cosh,
    math.asin,
    math.rad,
    table.clear,
    table.move,
    table.pack,
    table.foreach,
    table.sort,
    table.remove,
    table.foreachi,
    table.unpack,
    table.concat,
    table.insert,
    string.format,
    string.len,
    string.gsub,
    string.match,
    string.byte,
    string.char,
    string.upper,
    string.lower,
    string.sub,
    bit.band,
    panorama.loadstring

local dependencies = {
    ["gamesense/antiaim_funcs"] = "https://gamesense.pub/forums/viewtopic.php?id=29665"
}

local missing_libs = {}

for i, v in pairs(dependencies) do
    if not pcall(require, i) then
        missing_libs[#missing_libs + 1] = dependencies[i]
    end
end

for i = 1, #missing_libs do
    error("Please subscribe to the following libraries! \n" .. table_concat(missing_libs, ", \n"))
end

local antiaim_funcs = require("gamesense/antiaim_funcs")

--menu elements and references

local menu = {
    master_switch = ui_new_checkbox("AA", "Anti-aimbot angles", "nig-yaw.recode"),
    options = ui_new_multiselect(
        "AA",
        "Anti-aimbot angles",
        "\n",
        "Freestanding",
        "Edge yaw",
        "Safe head",
        "Dodge on slowwalk",
        "Force static body yaw",
        "Low delta",
        "On use anti-aim",
        "Ideal tick",
        "Doubletap enhancements",
        "Adaptive fakelag ~ Not working",
        "Resolver improvements",
        "Indicators",
        "Debug logs"
    ),
    freestanding_key = ui_new_hotkey("AA", "Anti-aimbot angles", "Freestanding key", false),
    edgeyaw_key = ui_new_hotkey("AA", "Anti-aimbot angles", "Edge yaw key", false),
    on_use_aa_key = ui_new_hotkey("AA", "Anti-aimbot angles", "On use anti-aim", false, 0x45),
    on_use_aa_mode = ui_new_combobox("AA", "Anti-aimbot angles", "On use anti-aim mode", "Regular", "Max delta"),
    ideal_tick_key = ui_new_hotkey("AA", "Anti-aimbot angles", "Ideal tick key", false),
    ideal_tick_weps = ui_new_multiselect(
        "AA",
        "Anti-aimbot angles",
        "Ideal tick weapons",
        "AWP",
        "SSG 08",
        "R8 Revolver"
    ),
    primary_label = ui_new_label("AA", "Anti-aimbot angles", "Primary ascent"),
    primary_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Primary ascent", 255, 166, 180, 255),
    secondary_label = ui_new_label("AA", "Anti-aimbot angles", "Secondary ascent"),
    secondary_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Primary ascent", 52, 52, 52, 0),
    idc_options = ui_new_multiselect(
        "AA",
        "Anti-aimbot angles",
        "Indicator options",
        "doubletap",
        "hideshots",
        "freestand",
        "fakeduck",
        "slowmotion"
    ),
    resolver_override = ui_new_checkbox("LUA", "B", "Resolver override"),
    resolver_override_key = ui_new_hotkey("LUA", "B", "Resolver override", true),
    resolver_override_visualise = ui_new_checkbox("LUA", "B", "Visualize bruteforce"),
    maxprocticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
}

local refs = {
    dt = {ui_reference("RAGE", "Other", "Double tap")},
    yaw = {ui_reference("AA", "Anti-aimbot angles", "Yaw")},
    yawj = {ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")},
    bodyyaw = {ui_reference("AA", "Anti-aimbot angles", "Body yaw")},
    fs = {ui_reference("AA", "Anti-aimbot angles", "Freestanding")},
    slowwalk = {ui_reference("AA", "Other", "Slow motion")},
    leg_movement = ui_reference("AA", "Other", "Leg movement"),
    hs = {ui_reference("AA", "Other", "On shot anti-aim")},
    quickpeek = {ui_reference("RAGE", "Other", "Quick peek assist")},
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
    holdaim = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim"),
    aa_enabled = ui_reference("AA", "Anti-aimbot angles", "Enabled"),
    ref_fl = ui_reference("AA", "Fake lag", "Enabled"),
    ref_fl_amt = ui_reference("AA", "Fake lag", "Amount"),
    ref_fl_var = ui_reference("AA", "Fake lag", "Variance"),
    ref_fl_limit = ui_reference("AA", "Fake lag", "Limit")
}

-- resovler start
local best_enemy = nil

-- resolver calculations
local function normalize_yaw(yaw)
    while yaw > 180 do
        yaw = yaw - 360
    end
    while yaw < -180 do
        yaw = yaw + 360
    end
    return yaw
end

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then
        return 0
    end

    return math_deg(math_atan2(y, x))
end

local function get_best_enemy()
    best_enemy = nil

    local enemies = entity_get_players(true)
    local best_fov = 180

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()

    for i = 1, #enemies do
        plist.set(enemies[i], "Force body yaw", false)
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math_abs(normalize_yaw(ang_on_screen(lx - cur_x, ly - cur_y) - view_y + 180))
        if cur_fov < best_fov then
            best_fov = cur_fov
            best_enemy = enemies[i]
        end
    end
end

local vec_3 = function(_x, _y, _z)
    return {x = _x or 0, y = _y or 0, z = _z or 0}
end

local function angle_vector(angle_x, angle_y)
    local sy = math_sin(math_rad(angle_y))
    local cy = math_cos(math_rad(angle_y))
    local sp = math_sin(math_rad(angle_x))
    local cp = math_cos(math_rad(angle_x))
    return cp * cy, cp * sy, -sp
end

local function get_damage(me, enemy, x, y, z)
    local ex = {}
    local ey = {}
    local ez = {}
    ex[0], ey[0], ez[0] = entity_hitbox_position(enemy, 1)
    ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
    ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
    ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
    ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
    ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
    ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
    local bestdamage = 0
    local bent = nil
    for i = 0, 6 do
        local ent, damage = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
        if damage > bestdamage then
            bent = ent
            bestdamage = damage
        end
    end
    return bent == nil and client_scale_damage(me, 1, bestdamage) or bestdamage
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
    local ydelta = local_y - enemy_y
    local xdelta = local_x - enemy_x
    local relativeyaw = math_atan(ydelta / xdelta)
    relativeyaw = normalize_yaw(relativeyaw * 180 / math_pi)
    if xdelta >= 0 then
        relativeyaw = normalize_yaw(relativeyaw + 180)
    end
    return relativeyaw
end

local function get_best_angle()
    local me = entity_get_local_player()

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()

    local e_x, e_y, e_z = entity_hitbox_position(best_enemy, 0)

    local yaw = calc_angle(e_x, e_y, lx, ly)
    local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
    local rend_x = e_x + rdir_x * 10
    local rend_y = e_y + rdir_y * 10

    local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
    local lend_x = e_x + ldir_x * 10
    local lend_y = e_y + ldir_y * 10

    local r2dir_x, r2dir_y, r2dir_z = angle_vector(0, (yaw + 90))
    local r2end_x = e_x + r2dir_x * 100
    local r2end_y = e_y + r2dir_y * 100

    local l2dir_x, l2dir_y, l2dir_z = angle_vector(0, (yaw - 90))
    local l2end_x = e_x + l2dir_x * 100
    local l2end_y = e_y + l2dir_y * 100

    local ldamage = get_damage(best_enemy, me, rend_x, rend_y, e_z)
    local rdamage = get_damage(best_enemy, me, lend_x, lend_y, e_z)

    local l2damage = get_damage(best_enemy, me, r2end_x, r2end_y, e_z)
    local r2damage = get_damage(best_enemy, me, l2end_x, l2end_y, e_z)

    if l2damage > r2damage or ldamage > rdamage then
        return 1
    elseif r2damage > l2damage or rdamage > ldamage then
        return 2
    else
        return 0
    end
end

local best_angle = 0

local function resolver()
    get_best_enemy()

    if not includes(menu.options, "Resolver improvements") then
        return
    end
    

    -- check for weapon scout
    local weapon_id = entity_get_prop(weapon, "m_iItemDefinitionIndex")
    if weapon_id == 40 then

    if best_enemy == nil then
        return
    end
    
    -- detect side
    best_angle = get_best_angle()

    -- resolver sides
    if best_angle == 2 then
        plist.set(best_enemy, "Force body yaw", true)
        plist.set(best_enemy, "Force body yaw value", -60)
    elseif best_angle == 1 then
        plist.set(best_enemy, "Force body yaw", true)
        plist.set(best_enemy, "Force body yaw value", 60)
    else
        plist.set(best_enemy, "Force body yaw", false)
        plist.set(best_enemy, "Force body yaw value", 0)
    end
end
end

local function draw()
    if best_enemy == nil or not includes(menu.options, "Resolver improvements") then
        return
    end

    local enemy_pos = vec_3(entity_hitbox_position(best_enemy, 0))

    local w2s_x, w2s_y = renderer_world_to_screen(enemy_pos.x, enemy_pos.y, enemy_pos.z)

    local alpha = math.floor(math.sin(globals_realtime() * 12) * (255 / 2 - 1) + 255 / 2) or 255

    renderer_text(w2s_x, w2s_y, 255, 122, 122, alpha, "c", 0, "STAGE: " .. best_angle)

    renderer_indicator(236, 255, 0, 255, "#SOLVED " .. entity_get_player_name(best_enemy))
end

-- aa variables
local vars = {
    best_enemy = nil,
    best_angle = 0,
    last_miss = 0,
    misses = {},
    on_use_aa = false,
    ideal_tick = false
}

local function console_log(msg)
    local r, g, b = ui_get(menu.watermark_clr)
    client_color_log(r, g, b, "[ghetto.technology] \0")
    client_color_log(215, 215, 215, msg)
end

local vec_3 = function(_x, _y, _z)
    return {x = _x or 0, y = _y or 0, z = _z or 0}
end

local color = function(_r, _g, _b, _a)
    return {r = _r or 0, g = _g or 0, b = _b or 0, a = _a or 0}
end

local includes = function(table, value)
    for _, v in ipairs(ui_get(table)) do
        if v == value then
            return true
        end
    end

    return false
end

local function entity_has_c4(ent)
    local bomb = entity_get_all("CC4")[1]
    return bomb ~= nil and entity_get_prop(bomb, "m_hOwnerEntity") == ent
end

local function normalize_yaw(yaw)
    while yaw > 180 do
        yaw = yaw - 360
    end
    while yaw < -180 do
        yaw = yaw + 360
    end

    return yaw
end

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then
        return 0
    end

    return math_deg(math_atan2(y, x))
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
    local ydelta = local_y - enemy_y
    local xdelta = local_x - enemy_x
    local relativeyaw = math_atan(ydelta / xdelta)
    relativeyaw = normalize_yaw(relativeyaw * 180 / math_pi)
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
    if #enemies == 0 then
        return
    end

    local eye_pos, cam_ang = vec_3(client_eye_position()), vec_3(client_camera_angles())
    local best_fov = 180

    for i = 1, #enemies do
        local enemy_pos = vec_3(entity_get_prop(enemies[i], "m_vecOrigin"))
        local cur_fov =
            math_abs(normalize_yaw(ang_on_screen(eye_pos.x - enemy_pos.x, eye_pos.y - enemy_pos.y) - cam_ang.y + 180))
        if cur_fov < best_fov then
            best_fov = cur_fov
            vars.best_enemy = enemies[i]
        end
    end
end

local function get_best_angle()
    vars.best_angle = 0

    if vars.best_enemy == nil then
        return
    end

    local me = entity_get_local_player()

    local local_pos, enemy_pos = vec_3(entity_hitbox_position(me, 0)), vec_3(entity_hitbox_position(vars.best_enemy, 0))

    local yaw = calc_angle(local_pos.x, local_pos.y, enemy_pos.x, enemy_pos.y)
    local l_dir, r_dir = vec_3(angle_vector(0, (yaw + 90))), vec_3(angle_vector(0, (yaw - 90)))
    local l_pos, r_pos =
        vec_3(local_pos.x + l_dir.x * 110, local_pos.y + l_dir.y * 110, local_pos.z),
        vec_3(local_pos.x + r_dir.x * 110, local_pos.y + r_dir.y * 110, local_pos.z)

    local fraction, hit_ent =
        client_trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, l_pos.x, l_pos.y, l_pos.z)
    local fraction_s, hit_ent_s =
        client_trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, r_pos.x, r_pos.y, r_pos.z)

    if vars.on_use_aa then
        if fraction > fraction_s then
            vars.best_angle = includes(menu.options, "Safe head") and 1 or 2
        elseif fraction_s > fraction then
            vars.best_angle = includes(menu.options, "Safe head") and 2 or 1
        end
    else
        if fraction > fraction_s then
            vars.best_angle = includes(menu.options, "Safe head") and 2 or 1
        elseif fraction_s > fraction then
            vars.best_angle = includes(menu.options, "Safe head") and 1 or 2
        end
    end
end

local function miss_detection(e)
    local me, shooter = entity_get_local_player(), client_userid_to_entindex(e.userid)

    if not entity_is_alive(me) or not entity_is_enemy(shooter) or entity_is_dormant(shooter) then
        return
    end

    local enemy_pos = vec_3(entity_get_prop(shooter, "m_vecOrigin"))

    for i = 1, 19 do
        local local_pos = vec_3(entity_hitbox_position(me, i - 1))
        local dist =
            ((e.y - enemy_pos.y) * local_pos.x - (e.x - enemy_pos.x) * local_pos.y + e.x * enemy_pos.y -
            e.y * enemy_pos.x) /
            math_sqrt((e.y - enemy_pos.y) ^ 2 + (e.x - enemy_pos.x) ^ 2)

        if math_abs(dist) <= 35 and globals_curtime() - vars.last_miss > 0.005 then
            vars.last_miss = globals_curtime()
            if vars.misses[shooter] == nil then
                vars.misses[shooter] = 1
            elseif vars.misses[shooter] >= 2 then
                vars.misses[shooter] = nil
            else
                vars.misses[shooter] = vars.misses[shooter] + 1
            end
            if includes(menu.options, "Debug logs") then
                console_log(
                    string_format(
                        "miss detected from %s ( distance: %s | hb: %s )",
                        entity_get_player_name(shooter),
                        math_floor(math_abs(dist)),
                        i - 1
                    )
                )
            end
            return
        elseif math_abs(dist) > 250 then
            return -- Just optimizations so we don't run checks for bullets that are nowhere near us
        end
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

aa_state = "default"
safety = "undefined"

-- aa start
local function anti_aim()
    if includes(menu.options, "Dodge on slowwalk") and ui_get(refs.slowwalk[1]) and ui_get(refs.slowwalk[2]) then
        set_anti_aim("Minimal", "180", 9, "Off", 0, "Static", 28, false, "Opposite", client.random_int(17, 20))
        aa_state = "dodge"
        safety = "safe"
    elseif vars.best_angle == 0 then
        if includes(menu.options, "Force static body yaw") then
            set_anti_aim("Minimal", "180", 8, "Off", 0, "Static", 90, true, "Eye yaw", 35)
            aa_state = "static"
            safety = "unsafe"
        else
            set_anti_aim("Minimal", "180", 2, "Off", 0, "Jitter", 20, false, "Eye yaw", 57)
            aa_state = "jitter"
            safety = "unsafe"
        end
    elseif vars.best_angle == 1 then
        if vars.misses[vars.best_enemy] == nil or vars.misses[vars.best_enemy] == 2 then
            set_anti_aim(
                "Minimal",
                "180",
                includes(menu.options, "Low delta") and 8 or 12,
                "Off",
                0,
                "Static",
                90,
                false,
                "Eye yaw",
                includes(menu.options, "Low delta") and 30 or 57
            )
            aa_state = "ideal"
            safety = "safe"
        else
            set_anti_aim("Minimal", "180", 9, "Off", 0, "Static", 27, false, "Opposite", 27)
            aa_state = "ideal"
            safety = "safe"
        end
    else
        if vars.misses[vars.best_enemy] == nil then
            if includes(menu.options, "Low delta") then
                set_anti_aim("Minimal", "180", 9, "Off", 0, "Static", 90, false, "Eye yaw", 35)
                aa_state = "bruteforce"
                safety = "safe"
            else
                set_anti_aim("Minimal", "180", 1, "Off", 0, "Static", -90, false, "Eye yaw", 35)
                aa_state = "bruteforce"
                safety = "safe"
            end
        else
            set_anti_aim(
                "Minimal",
                "180",
                includes(menu.options, "Low delta") and 8 or 12,
                "Off",
                0,
                "Static",
                90,
                false,
                "Eye yaw",
                includes(menu.options, "Low delta") and 35 or 57
            )
            aa_state = "default"
            safety = "unsafe"
        end
    end
    if vars.on_use_aa then
        ui_set(refs.pitch, "Off")
        ui_set(refs.yaw[1], "Off")
        if ui_get(menu.on_use_aa_mode) == "Max delta" then
            ui_set(refs.fakelimit, 57)
            aa_state = "legit"
            safety = "safe"
        end
    end
    if includes(menu.options, "Debug logs") then
        client.log("aa mode changed to ", aa_state)
    end
end

-- main resolver start
local function resolver()
    get_best_enemy()

    if includes(menu.options, "Resolver improvements") then

        if best_enemy == nil then
            return
        end

        best_angle = get_best_angle()

        if best_angle == 2 then
            plist.set(best_enemy, "Force body yaw", true)
            plist.set(best_enemy, "Force body yaw value", -58)
        elseif best_angle == 1 then
            plist.set(best_enemy, "Force body yaw", true)
            plist.set(best_enemy, "Force body yaw value", 58)
        else
            plist.set(best_enemy, "Force body yaw", false)
            plist.set(best_enemy, "Force body yaw value", 0)
        end
    end
end

-- draw resolver


-- indicators
local function indicators()
    if not entity_is_alive(entity_get_local_player()) then
        return
    end
    if includes(menu.options, "Indicators") then
        -- variables
        local w, h = client_screen_size()
        local wm_clr = color(ui_get(menu.secondary_clr))
        local wn_clr = color(ui_get(menu.primary_clr))
        local desync_strength =
            math.floor(
            math.min(58, math.abs(entity_get_prop(entity_get_local_player(), "m_flPoseParameter", 11) * 120 - 60))
        )

        --indicators

        -- renderer.text(w / 2 - 2, h / 2 + 38, 255, 255, 255, 255, "c-", 0, aa_state)
        renderer.text(w / 2, h / 2 + 40, wn_clr.r, wn_clr.g, wn_clr.b, wn_clr.a, "c", 0, "NIG-YAW")
        renderer.text(w / 2, h / 2 + 20, 255, 255, 255, 255, "c", 0, string.format(" %s°", desync_strength))

        renderer.gradient(
            w / 2 - desync_strength,
            h / 2 + 28,
            desync_strength,
            3,
            wm_clr.r,
            wm_clr.g,
            wm_clr.b,
            wm_clr.a,
            wn_clr.r,
            wn_clr.g,
            wn_clr.b,
            wn_clr.a,
            true
        )
        renderer.gradient(
            w / 2,
            h / 2 + 28,
            desync_strength,
            3,
            wn_clr.r,
            wn_clr.g,
            wn_clr.b,
            wn_clr.a,
            wm_clr.r,
            wm_clr.g,
            wm_clr.b,
            wm_clr.a,
            true
        )

        if aa_state == "jitter" then return
        else
            if bodyyaw_add == 90 then
                renderer.text(w / 2 + 40, h / 2, 255, 255, 255, 255, "cb+", 0, ">")
                renderer.text(w / 2 - 40, h / 2, wn_clr.r, wn_clr.g, wn_clr.b, wn_clr.a, "cb+", 0, "<")
            else
                renderer.text(w / 2 + 40, h / 2, wn_clr.r, wn_clr.g, wn_clr.b, wn_clr.a, "cb+", 0, ">")
                renderer.text(w / 2 - 40, h / 2, 255, 255, 255, 255, "cb+", 0, "<")
            end
        end
    end
end

-- aa debug logs

-- dt variables

local maxprocessticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

-- dt improvements

-- fakelag

-- legit aa on use
local function anti_aim_on_use(e)
    vars.on_use_aa = false
    if not includes(menu.options, "On use anti-aim") or not ui_get(menu.on_use_aa_key) then
        return
    end

    local me = entity_get_local_player()

    local dist, c4 = 100, entity_get_all("CPlantedC4")[1]
    local c4_pos = vec_3(entity_get_prop(c4, "m_vecOrigin"))

    if c4_pos.x ~= nil and c4_pos.y ~= nil and c4_pos.z ~= nil then
        local local_pos = vec_3(entity_get_prop(me, "m_vecOrigin"))
        dist =
            math_sqrt(
            (local_pos.x - c4_pos.x) * (local_pos.x - c4_pos.x) + (local_pos.y - c4_pos.y) * (local_pos.y - c4_pos.y) +
                (local_pos.z - c4_pos.z) * (local_pos.z - c4_pos.z)
        )
    end

    local team = entity_get_prop(me, "m_iTeamNum")
    local defusing = team == 3 and dist < 62
    local in_bombzone, is_bomb_carrier = entity_get_prop(me, "m_bInBombZone"), entity_has_c4(me)
    local planting = in_bombzone ~= 0 and team == 2 and is_bomb_carrier

    local eye_pos = vec_3(client_eye_position())
    local pitch, yaw = client_camera_angles()
    local dir_vec = vec_3(angle_vector(pitch, yaw))

    local fraction, hit_ent =
        client_trace_line(
        me,
        eye_pos.x,
        eye_pos.y,
        eye_pos.z,
        eye_pos.x + (dir_vec.x * 250),
        eye_pos.y + (dir_vec.y * 250),
        eye_pos.z + (dir_vec.z * 250)
    )

    local using = false
    if hit_ent ~= -1 then
        local classname = entity_get_classname(hit_ent)
        using = classname ~= "CWorld" and classname ~= "CCSPlayer" and classname ~= "CFuncBrush"
    end

    if not using and not planting and not defusing then
        e.in_use = 0
        vars.on_use_aa = true
    end
end

-- fakelag
local function fakelag()
    if not includes(menu.options, "Adaptive fakelag") then
        return
    end

    if best_enemy == nil or ui_get(refs.fd) then
        ui.set(refs.ref_fl_amt, "Dynamic")
        ui.set(refs.ref_fl_limit, 14)
        ui.set(refs.ref_fl_var, 0)
        ui.set(refs.ref_fl, true)
        return
    elseif end_choke_cycle == 1 then
        ui.set(refs.ref_fl_limit, 1)
        ui.set(refs.ref_fl, false)
        end_choke_cycle = 2
        return
    else
        ui.set(refs.ref_fl, true)
    end

    local local_pos = vec_3(client_eye_position())
    local extrap_pos = vec_3(extrapolate_position(local_pos.x, local_pos.y, local_pos.z, 14, entity_get_local_player()))

    local player_pos = vec_3(entity_hitbox_position(best_enemy, 0))
    local player_pos_2 = vec_3(entity_hitbox_position(best_enemy, 4))
    local player_pos_3 = vec_3(entity_hitbox_position(best_enemy, 2))

    if
        trace_positions(
            player_pos.x,
            player_pos.y,
            player_pos.z,
            player_pos_2.x,
            player_pos_2.y,
            player_pos_2.z,
            player_pos_3.x,
            player_pos_3.y,
            player_pos_3.z,
            extrap_pos.x,
            extrap_pos.y,
            extrap_pos.z
        )
     then
        if end_choke_cycle ~= 2 then
            end_choke_cycle = 1
        else
            ui_set(refs.ref_fl_amt, "Maximum")
            ui_set(refs.ref_fl_limit, 14)
            ui_set(refs.ref_fl_var, 0)
        end
    else
        end_choke_cycle = 0

        local x, y = entity_get_prop(entity_get_local_player(), "m_vecVelocity")
        local speed = x ~= nil and math.floor(math.sqrt(x * x + y * y + 0.5)) or 0

        ui_set(refs.ref_fl_amt, "Dynamic")
        ui_set(refs.ref_fl_limit, 14)
        ui_set(refs.ref_fl_var, 40)
    end
end

-- ideal tick
local function ideal_tick()
    vars.ideal_tick = false
    if not includes(menu.options, "Ideal tick") then
        return
    end

    if
        not includes(menu.options, "Ideal tick") or not ui_get(menu.ideal_tick_key) or ui_get(refs.fd) or
            ui_get(refs.hs[1]) and ui_get(refs.hs[2])
     then
        ui_set(refs.quickpeek[2], "On hotkey")
        ui_set(refs.dt[2], "Toggle")
    else
        local me = entity_get_local_player()
        local weapon = entity_get_player_weapon(me)
        local weapon_id = entity_get_prop(weapon, "m_iItemDefinitionIndex")

        if
            weapon_id == 9 and includes(menu.ideal_tick_weps, "AWP") or
                weapon_id == 64 and includes(menu.ideal_tick_weps, "R8 Revolver") or
                weapon_id == 40 and includes(menu.ideal_tick_weps, "SSG 08")
         then
            ui_set(refs.quickpeek[1], true)
            ui_set(refs.quickpeek[2], "Always on")
            ui_set(refs.dt[2], "Always on")
            ui_set(refs.edge_yaw, not vars.on_use_aa)
            ui_set(refs.fs[2], not vars.on_use_aa and "Always on")
            vars.ideal_tick = true
        end
    end
end

local i_index = 0
local kk_index = 0


-- showcase box
-- showcase box
local kk_index = 0
local i_index = 0

local function draw_infobox()
    if includes(menu.options, "Indicators") then
        -- renderer.rectangle(x: number, y: number, w: number, h: number, r: number, g: number, b: number, a: number)
        local h_index = 0
        local k_index = 0
    
        -- colours
        local wn_clr = color(ui.get(menu.primary_clr))
    
        -- index shit
    
    
        -- ref fakelag
        local fl_indicator = globals.chokedcommands() * 8
    
        -- x and y values
        local scrx, scry = client.screen_size()
        local x, y = scrx / 2, scry / 2

        -- dynamic box
        local player = entity.get_player_name(vars.best_enemy)
        local length = renderer.measure_text(nil, entity.get_player_name(vars.best_enemy)) / 4
    
        -- Info Box
        --renderer.rectangle(x - 950, y, 150, 29 + (i_index * 12), 25, 25, 25, 255) -- base
        renderer.gradient(x - 950, y, 150, 29 + (i_index * 12), 25, 25, 25, 50, 25, 25, 25, 255, false)
    
        renderer.rectangle(x - 950, y + 29 + (i_index * 12), 150, 2, wn_clr.r, wn_clr.g, wn_clr.b, 255) -- bottom
    
        renderer.gradient(x - 950, y, 2, 29 + (i_index * 12), 0, 0, 0, 0, wn_clr.r, wn_clr.g, wn_clr.b, 255, false) -- left
        renderer.gradient(x - 802, y, 2, 29 + (i_index * 12), 0, 0, 0, 0, wn_clr.r, wn_clr.g, wn_clr.b, 255, false) -- right
    
        renderer.text(x - 944, y + 2, 255, 255, 255, 255, "", 0, "status")
        renderer.text(x - 806 - renderer.measure_text(nil, aa_state), y + 2, wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, aa_state)
    
        renderer.text(x - 944, y + 14, 255, 255, 255, 255, "", 0, "choke")
    
        -- fl gradient
        renderer.gradient(x - 806 - fl_indicator, y + 18, fl_indicator, 3, 0, 0, 0, 0, wn_clr.r, wn_clr.g, wn_clr.b, 255, true)
        
        if vars.best_enemy ~= nil then
            renderer.text(x - 944, y + 26, 255, 255, 255, 255, "", 0, "target")
            renderer.text(x - 806 - renderer.measure_text(15, entity.get_player_name(vars.best_enemy)), y + 26, wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, entity.get_player_name(vars.best_enemy))
            h_index = h_index + 1
        end
    
        renderer.text(x - 944, y + 26 + (h_index * 12), 255, 255, 255, 255, "", 0, "safety")
        renderer.text(x - 806 - renderer.measure_text(nil, safety), y + 26 + (h_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, safety)
        h_index = h_index + 1
    
        --renderer.text(x - 944, y + 2, 255, 255, 255, 255, "", 0, "status")
        --renderer.text(x - 836, y + 2, 255, 255, 255, 255, "", 0, "status")
    
        i_index = h_index
    
        -- Keybinds
        if kk_index > 0 then
            -- renderer.rectangle(x - 950, y + 39 + (i_index * 12), 150, 8 + (kk_index * 12), 25, 25, 25, 255) -- base
            -- renderer.gradient(x - 950, y + 39 + (i_index * 12), 150, 8 + (kk_index * 12), 25, 25, 255, 25, 25, 25, 125, true
            renderer.gradient(x - 950, y + 39 + (i_index * 12), 150, 8 + (kk_index * 12), 25, 25, 255, 25, 25, 25, 125, false)
            renderer.gradient(x - 950, y + 39 + (i_index * 12), 150, 8 + (kk_index * 12), 25, 25, 25, 255, 25, 25, 25, 25, false)
    
            renderer.rectangle(x - 950, y + 39 + (i_index * 12), 150, 2, wn_clr.r, wn_clr.g, wn_clr.b, 255) -- top
    
            renderer.gradient(x - 950, y + 39 + (i_index * 12), 2, 8 + (kk_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, 0, 0, 0, 0, false) -- left
            renderer.gradient(x - 802, y + 39 + (i_index * 12), 2, 8 + (kk_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, 0, 0, 0, 0, false) -- right
        end

        if includes(menu.idc_options, "doubletap") and ui_get(refs.dt[2]) then
            renderer.text(x - 944, y + 43 + (i_index * 12) + (k_index * 12), 255, 255, 255, 255, "", 0, "doubletap")
            renderer.text(x - 806 - renderer.measure_text(nil, "[" ..ui_get(maxprocessticks).. "/" ..ui_get(refs.dt_hc).. "]"), y + 43 + (i_index * 12) + (k_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, "[" ..ui_get(refs.maxprocessticks).. "/" ..ui_get(refs.dt_hc).. "]")
            k_index = k_index + 1
        end
    
        if includes(menu.idc_options, "hideshots") and ui_get(refs.hs[2]) then
            renderer.text(x - 944, y + 43 + (i_index * 12) + (k_index * 12), 255, 255, 255, 255, "", 0, "onshot-aa")
            renderer.text(x - 806 - renderer.measure_text(nil, "[on]"), y + 43 + (i_index * 12) + (k_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, "[on]")
            k_index = k_index + 1
        end
    
        if includes(menu.idc_options, "freestand") and ui_get(menu.freestanding_key) then
            renderer.text(x - 944, y + 43 + (i_index * 12) + (k_index * 12), 255, 255, 255, 255, "", 0, "freestand")
            renderer.text(x - 806 - renderer.measure_text(nil, "[on]"), y + 43 + (i_index * 12) + (k_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, "[on]")
            k_index = k_index + 1
        end
    
        if includes(menu.idc_options, "fakeduck") and ui_get(refs.fd) then
            renderer.text(x - 944, y + 43 + (i_index * 12) + (k_index * 12), 255, 255, 255, 255, "", 0, "fakeduck")
            renderer.text(x - 806 - renderer.measure_text(nil, "[on]"), y + 43 + (i_index * 12) + (k_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, "[on]")
            k_index = k_index + 1
        end

    
        if includes(menu.idc_options, "slowmotion") and ui_get(refs.slowwalk[2]) then
            renderer.text(x - 944, y + 43 + (i_index * 12) + (k_index * 12), 255, 255, 255, 255, "", 0, "slow-walk")
            renderer.text(x - 806 - renderer.measure_text(nil, "[on]"), y + 43 + (i_index * 12) + (k_index * 12), wn_clr.r, wn_clr.g, wn_clr.b, 255, "", 0, "[on]")
            k_index = k_index + 1
        end
    
        kk_index = k_index
    end
end

local function ideal_tick_ind()
    local me = entity_get_local_player()
    if not entity_is_alive(me) or not vars.ideal_tick then
        return
    end

    local w, h = client_screen_size()
    local qp_clr = color(ui_get(refs.quickpeek_clr))

    if antiaim_funcs.get_double_tap() then
        renderer_text(w / 2, h / 2 - 23, qp_clr.r, qp_clr.g, qp_clr.b, 255, "b", 0, "IDEAL TICK : CHARGED")
    else
        renderer_text(
            w / 2,
            h / 2 - 23,
            qp_clr.r,
            qp_clr.g,
            qp_clr.b,
            math_sin(math_abs(-math_pi + (globals_curtime() * (1 / 0.3)) % (math_pi * 2))) * 255,
            "b",
            0,
            "IDEAL TICK CHARGING"
        )
    end
end

-- aa logging


local function brute_reset()
    vars.misses = {}
    vars.last_miss = 0
end

local function on_paint()
    ideal_tick_ind()
    indicators()
    draw_infobox()
end

local function on_run_command()
    ui_set(refs.fs[1], "Default")
    ui_set(
        refs.fs[2],
        (includes(menu.options, "Freestanding") and ui_get(menu.freestanding_key)) and "Always on" or "On hotkey"
    )
    ui_set(refs.edge_yaw, (includes(menu.options, "Edge yaw") and ui_get(menu.edgeyaw_key)) and true or false)

    get_best_enemy()
    get_best_angle()
    anti_aim()
    ideal_tick()
    resolver()
    fakelag()
end

local function on_bullet_impact(e)
    miss_detection(e)
end

local function on_setup_command(e)
    anti_aim_on_use(e)
end

-- menu item visibility
local function handle_visbility()
    local master_switch = ui_get(menu.master_switch)

    for i, v in pairs(menu) do
        if menu[i] ~= menu.master_switch then
            ui_set_visible(menu[i], master_switch)
        end
    end

    ui_set_visible(refs.aa_enabled, not master_switch)
    ui_set_visible(refs.pitch, not master_switch)
    ui_set_visible(refs.yaw_base, not master_switch)
    ui_set_visible(refs.yaw[1], not master_switch)
    ui_set_visible(refs.yaw[2], not master_switch)
    ui_set_visible(refs.yawj[1], not master_switch)
    ui_set_visible(refs.yawj[2], not master_switch)
    ui_set_visible(refs.bodyyaw[1], not master_switch)
    ui_set_visible(refs.bodyyaw[2], not master_switch)
    ui_set_visible(refs.fs_bodyyaw, not master_switch)
    ui_set_visible(refs.lby_target, not master_switch)
    ui_set_visible(refs.fakelimit, not master_switch)
    ui_set_visible(refs.edge_yaw, not master_switch)
    ui_set_visible(refs.fs[1], not master_switch)
    ui_set_visible(refs.fs[2], not master_switch)

    if master_switch then
        ui_set_visible(menu.secondary_clr, includes(menu.options, "Indicators"))
        ui_set_visible(menu.secondary_label, includes(menu.options, "Indicators"))
        ui_set_visible(menu.primary_clr, includes(menu.options, "Indicators"))
        ui_set_visible(menu.primary_label, includes(menu.options, "Indicators"))
        ui_set_visible(menu.on_use_aa_key, includes(menu.options, "On use anti-aim"))
        ui_set_visible(menu.on_use_aa_mode, includes(menu.options, "On use anti-aim"))
        ui_set_visible(menu.edgeyaw_key, includes(menu.options, "Edge yaw"))
        ui_set_visible(menu.freestanding_key, includes(menu.options, "Freestanding"))
        ui_set_visible(menu.ideal_tick_key, includes(menu.options, "Ideal tick"))
        ui_set_visible(menu.ideal_tick_weps, includes(menu.options, "Ideal tick"))
        ui_set_visible(menu.maxprocticks, includes(menu.options, "Doubletap enhancements"))
        ui_set_visible(menu.idc_options, includes(menu.options, "Indicators"))
    end
end

-- callbacks
local function main()
    local set_event_callback = ui_get(menu.master_switch) and client_set_event_callback or client_unset_event_callback

    set_event_callback("paint", on_paint)
    set_event_callback("run_command", on_run_command)
    set_event_callback("bullet_impact", on_bullet_impact)
    set_event_callback("setup_command", on_setup_command)
    set_event_callback("client_disconnect", brute_reset)
    set_event_callback("game_newmap", brute_reset)
    set_event_callback("cs_game_disconnected", brute_reset)
    set_event_callback("round_start", brute_reset)
end
main()
ui_set_callback(menu.master_switch, main)
client_set_event_callback("paint_ui", handle_visbility)
client_set_event_callback(
    "shutMinimal",
    function()
        ui_set_visible(refs.aa_enabled, true)
        ui_set_visible(refs.pitch, true)
        ui_set_visible(refs.yaw_base, true)
        ui_set_visible(refs.yaw[1], true)
        ui_set_visible(refs.yaw[2], true)
        ui_set_visible(refs.yawj[1], true)
        ui_set_visible(refs.yawj[2], true)
        ui_set_visible(refs.bodyyaw[1], true)
        ui_set_visible(refs.bodyyaw[2], true)
        ui_set_visible(refs.fs_bodyyaw, true)
        ui_set_visible(refs.lby_target, true)
        ui_set_visible(refs.fakelimit, true)
        ui_set_visible(refs.edge_yaw, true)
        ui_set_visible(refs.fs[1], true)
        ui_set_visible(refs.fs[2], true)
    end
)