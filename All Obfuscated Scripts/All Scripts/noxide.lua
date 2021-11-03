--[[
	id: 4F46V96Z-vJ5HaQ3m--k8
	name: noxide
	description: noxide lua for gs
	time1: 2021-07-12 07:26:36.388618+00
	time2: 2021-07-12 07:26:36.388619+00
	uploader: VjVCNye1Rtmr8VQGMrKwTHSsmS78rz8iLv3I0iI9
	uploadersession: 1FiXnEOLyWiqXSls9cFIGXA-uRrPYN
	flag: f
--]]

--local variables for API functions. Generated using https://github.com/sapphyrus/gamesense-lua/blob/master/generate_api.lua
local client_latency,
    client_screen_size,
    client_system_time,
    globals_tickinterval,
    math_floor,
    renderer_measure_text,
    renderer_rectangle,
    renderer_text,
    string_format =
    client.latency,
    client.screen_size,
    client.system_time,
    globals.tickinterval,
    math.floor,
    renderer.measure_text,
    renderer.rectangle,
    renderer.text,
    string.format
local client_userid_to_entindex,
    client_set_event_callback,
    client_screen_size,
    client_trace_bullet,
    client_unset_event_callback,
    client_color_log,
    client_reload_active_scripts,
    client_scale_damage,
    client_get_cvar,
    client_camera_position,
    client_create_interface,
    client_random_int,
    client_latency,
    client_set_clan_tag,
    client_find_signature,
    client_log,
    client_timestamp,
    client_delay_call,
    client_trace_line,
    client_register_esp_flag,
    client_get_model_name,
    client_system_time,
    client_visible,
    client_exec,
    client_key_state,
    client_set_cvar,
    client_unix_time,
    client_error_log,
    client_draw_debug_text,
    client_update_player_list,
    client_camera_angles,
    client_eye_position,
    client_draw_hitboxes,
    client_random_float =
    client.userid_to_entindex,
    client.set_event_callback,
    client.screen_size,
    client.trace_bullet,
    client.unset_event_callback,
    client.color_log,
    client.reload_active_scripts,
    client.scale_damage,
    client.get_cvar,
    client.camera_position,
    client.create_interface,
    client.random_int,
    client.latency,
    client.set_clan_tag,
    client.find_signature,
    client.log,
    client.timestamp,
    client.delay_call,
    client.trace_line,
    client.register_esp_flag,
    client.get_model_name,
    client.system_time,
    client.visible,
    client.exec,
    client.key_state,
    client.set_cvar,
    client.unix_time,
    client.error_log,
    client.draw_debug_text,
    client.update_player_list,
    client.camera_angles,
    client.eye_position,
    client.draw_hitboxes,
    client.random_float
local entity_get_local_player,
    entity_is_enemy,
    entity_get_bounding_box,
    entity_get_all,
    entity_set_prop,
    entity_is_alive,
    entity_get_steam64,
    entity_get_classname,
    entity_get_player_resource,
    entity_get_esp_data,
    entity_is_dormant,
    entity_get_player_name,
    entity_get_game_rules,
    entity_get_origin,
    entity_hitbox_position,
    entity_get_player_weapon,
    entity_get_players,
    entity_get_prop =
    entity.get_local_player,
    entity.is_enemy,
    entity.get_bounding_box,
    entity.get_all,
    entity.set_prop,
    entity.is_alive,
    entity.get_steam64,
    entity.get_classname,
    entity.get_player_resource,
    entity.get_esp_data,
    entity.is_dormant,
    entity.get_player_name,
    entity.get_game_rules,
    entity.get_origin,
    entity.hitbox_position,
    entity.get_player_weapon,
    entity.get_players,
    entity.get_prop
local globals_realtime,
    globals_absoluteframetime,
    globals_chokedcommands,
    globals_oldcommandack,
    globals_tickcount,
    globals_commandack,
    globals_lastoutgoingcommand,
    globals_curtime,
    globals_mapname,
    globals_tickinterval,
    globals_framecount,
    globals_frametime,
    globals_maxplayers =
    globals.realtime,
    globals.absoluteframetime,
    globals.chokedcommands,
    globals.oldcommandack,
    globals.tickcount,
    globals.commandack,
    globals.lastoutgoingcommand,
    globals.curtime,
    globals.mapname,
    globals.tickinterval,
    globals.framecount,
    globals.frametime,
    globals.maxplayers
local ui_new_slider,
    ui_new_combobox,
    ui_reference,
    ui_set_visible,
    ui_new_textbox,
    ui_new_color_picker,
    ui_new_checkbox,
    ui_mouse_position,
    ui_new_listbox,
    ui_new_multiselect,
    ui_is_menu_open,
    ui_new_hotkey,
    ui_set,
    ui_update,
    ui_menu_size,
    ui_name,
    ui_menu_position,
    ui_set_callback,
    ui_new_button,
    ui_new_label,
    ui_new_string,
    ui_get =
    ui.new_slider,
    ui.new_combobox,
    ui.reference,
    ui.set_visible,
    ui.new_textbox,
    ui.new_color_picker,
    ui.new_checkbox,
    ui.mouse_position,
    ui.new_listbox,
    ui.new_multiselect,
    ui.is_menu_open,
    ui.new_hotkey,
    ui.set,
    ui.update,
    ui.menu_size,
    ui.name,
    ui.menu_position,
    ui.set_callback,
    ui.new_button,
    ui.new_label,
    ui.new_string,
    ui.get

local images = require "gamesense/images"
local anti_aim = require "gamesense/antiaim_funcs"
local js = panorama.open()

-- antiaim
local enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled")
local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local jitter, jitter_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local body_yaw, body_yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Body Yaw")
local freestand_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge Yaw")
local fakeyaw_slider = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local freestanding, freestanding_key = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
--local freestandingboolean, freestandingmode, freestandinghotkey = ui.reference("AA", "Anti-aimbot angles", freestanding_key)
--fakelag
local enabled_fakelag, enabled_fakelag_key = ui.reference("AA", "Fake lag", "Enabled")
local fakelag_amount = ui.reference("AA", "Fake lag", "Amount")
local fakelag_limit = ui.reference("AA", "Fake lag", "Limit")
--other
local slow_motion, slow_motion_key = ui.reference("AA", "Other", "Slow motion")
local slow_motion_type = ui.reference("AA", "Other", "Slow motion type")
local slidewalk = ui.reference("AA", "Other", "Leg movement")
local quick_peek_assist, quick_peek_assist_key = ui.reference("RAGE", "Other", "Quick peek assist")
local maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
-- exploits
local double_tap, double_tap_key = ui.reference("RAGE", "Other", "Double tap")
local double_tap_hitchance = ui_reference("RAGE", "Other", "Double tap hit chance")
local double_tap_fakelag = ui.reference("RAGE", "Other", "Double tap fake lag limit")
local hideshots, hideshots_key = ui.reference("AA", "Other", "On shot anti-aim")
local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
--aimbot related
local forcesafe_key = ui.reference("RAGE", "Aimbot", "Force safe point")
local forcebaim_key = ui.reference("RAGE", "Other", "Force body aim")
local mindmg = ui.reference("Rage", "Aimbot", "Minimum damage")
local hitchance = ui.reference("Rage", "Aimbot", "Minimum hit chance")
local avoidheadref = ui.reference("Rage", "Aimbot", "Avoid unsafe hitboxes")
local quick_stop_options = ui.reference("Rage", "Other", "Quick stop options")
-- Visuals
local visual_main = ui.reference("Visuals", "Player ESP", "Activation type")

local players = entity.get_players(true)
local names = {}
for i = 1, #players do
    names[#names + 1] = entity.get_player_name(players[i])
end

ui_new_label("LUA", "B", " ")
ui_new_label("LUA", "B", "-------------------------------------------")
ui_new_label("LUA", "B", " ")
ui_new_label("LUA", "B", "noxide [v2.0]")
ui_new_label("LUA", "B", "by scary")
ui_new_label("LUA", "B", " ")

local function join_oce_hvh()
    client_exec("connect 103.1.213.82:27015")
end

local menu = {
    master_switch = ui_new_checkbox("LUA", "B", "Enable"),
    sections = ui_new_combobox("LUA", "B", "Section", "Visuals", "Anti-Aim", "Misc", "Settings", "Servers"),
    spacer = ui_new_label("LUA", "B", " "),
    -- settings
    main_colour_text = ui_new_label("LUA", "B", "Primary Colour"),
    main_colour = ui_new_color_picker("LUA", "B", "Main Lua Colour", 255, 47, 47, 255),
    -- visuals
    crosshair_indicator_switch = ui_new_checkbox("LUA", "B", "Crosshair Indicators"),
    indicator_character_switch = ui_new_checkbox("LUA", "B", "Animated"),
    -- misc
    die_on_hit_switch = ui_new_checkbox("LUA", "B", "Die On Hit"),
    hp_slider = ui_new_slider("LUA", "B", "Min Health", 1, 99, 30, true, "HP"),
    options = ui_new_multiselect("LUA", "B", "Options", "Reset Score", "Message"),
    message_box = ui_new_textbox("LUA", "B", "Message Text"),
    clantag_switch = ui_new_checkbox("LUA", "B", "Clantag Changer"),
    clantag_type = ui_new_combobox("LUA", "B", "Mode", "Static", "Animated"),
    hit_logs_switch = ui_new_checkbox("LUA", "B", "Custom Hitlogs"),
    killsay_switch = ui_new_checkbox("LUA", "B", "Killsay"),
    killsay_message_box = ui_new_textbox("LUA", "B", "Message"),
    remove_default_indicators_switch = ui_new_checkbox("LUA", "B", "Remove Default Indicators"),
    -- antiaim
    fake_yaw_randomizer_switch = ui_new_checkbox("LUA", "B", "Randomize Fake Yaw"),
    fake_yaw_randomizer_slider = ui_new_slider("LUA", "B", "Limit", 0, 60, 0, true, "°"),
    -- servers
    oce_hvh_button = ui_new_button("LUA", "B", "OCE HVH", join_oce_hvh)
}

local w, h = client_screen_size() -- screen size
local p_r, p_g, p_b, p_a = ui_get(menu.main_colour) -- main colour picker (rgba)

local function main_visible(visible)
    ui_set_visible(menu.master_switch, visible)
end

local function settings_visible(visible)
    ui_set_visible(menu.main_colour, visible)
    ui_set_visible(menu.main_colour_text, visible)
end

local function visuals_visible(visible)
    ui_set_visible(menu.crosshair_indicator_switch, visible)
end

local function misc_visible(visible)
    ui_set_visible(menu.die_on_hit_switch, visible)
    ui_set_visible(menu.clantag_switch, visible)
    ui_set_visible(menu.hit_logs_switch, visible)
    ui_set_visible(menu.killsay_switch, visible)
    ui_set_visible(menu.remove_default_indicators_switch, visible)
end

local function antiaim_visible(visible)
    ui_set_visible(menu.fake_yaw_randomizer_switch, visible)
end

local function servers_visibile(visible)
    ui_set_visible(menu.oce_hvh_button, visible)
end

local function set_visible()
    if ui_get(menu.master_switch) then
        ui_set_visible(menu.sections, true)
    else
        ui_set_visible(menu.sections, false)
    end

    if ui_get(menu.sections) == "Settings" and ui_get(menu.master_switch) then
        settings_visible(true)
    else
        settings_visible(false)
    end

    if ui_get(menu.sections) == "Visuals" and ui_get(menu.master_switch) then
        visuals_visible(true)
    else
        visuals_visible(false)
    end

    if ui_get(menu.sections) == "Misc" and ui_get(menu.master_switch) then
        misc_visible(true)
    else
        misc_visible(false)
    end

    if ui_get(menu.sections) == "Anti-Aim" and ui_get(menu.master_switch) then
        antiaim_visible(true)
    else
        antiaim_visible(false)
    end

    if ui_get(menu.sections) == "Servers" and ui_get(menu.master_switch) then
        servers_visibile(true)
    else
        servers_visibile(false)
    end
end

local function watermark()
    if not ui_get(menu.master_switch) then
        return
    end

    local latency = math_floor(client_latency() * 1000 + 0.5)
    local tickrate = 1 / globals_tickinterval()
    local hours, minutes, seconds = client_system_time()
    local username = entity_get_player_name(entity_get_local_player())
    local cheatname = "NOXIDE"
    local version = "[alpha v2.6]"

    local player = entity.get_local_player()
    local steamid3 = entity.get_steam64(player)
    local avatar = images.get_steam_avatar(steamid3)

    local text =
        cheatname ..
        " " .. version .. " " .. username .. " | " .. string_format("%02d:%02d:%02d", hours, minutes, seconds)

    local margin, padding, flags = 18, 5, ""

    local text_width, text_height = renderer_measure_text(flags, text)

    local p_r, p_g, p_b, p_a = ui_get(menu.main_colour)
    renderer.rectangle(
        w - text_width - margin - padding,
        margin - padding,
        text_width + padding * 2,
        text_height + padding * 2,
        30,
        30,
        30,
        180
    )
    renderer.rectangle(
        w - text_width - margin - padding,
        margin - padding,
        text_width + padding * 2,
        1,
        p_r,
        p_g,
        p_b,
        p_a
    )
    renderer.text(w - text_width - margin, margin, 235, 235, 235, 255, flags, 0, text)
end

local function doubletap_charged()
    if not ui_get(double_tap) or not ui_get(double_tap_key) or ui_get(fakeduck) then
        return false
    end

    local me = entity_get_local_player()
    if me == nil or not entity_is_alive(me) then
        return false
    end

    local weapon = entity_get_prop(me, "m_hActiveWeapon")
    if weapon == nil then
        return false
    end

    local next_attack = entity_get_prop(me, "m_flNextAttack") + 0.25
    local next_primary_attack = entity_get_prop(weapon, "m_flNextPrimaryAttack") + 0.5
    if next_attack == nil or next_primary_attack == nil then
        return false
    end

    return next_attack - globals_curtime() < 0 and next_primary_attack - globals_curtime() < 0
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

local time = 0
local x = 1
local character = "$"
local main_text
local delay = 0.6

local indicator_main_text = {}

indicator_main_text[1] = character .. " O X I D E"
indicator_main_text[2] = "N " .. character .. " X I D E"
indicator_main_text[3] = "N O " .. character .. " I D E"
indicator_main_text[4] = "N O X " .. character .. " D E"
indicator_main_text[5] = "N O X I " .. character .. " E"
indicator_main_text[6] = "N O X I D " .. character
indicator_main_text[7] = "N O X I " .. character .. " E"
indicator_main_text[8] = "N O X " .. character .. " D E"
indicator_main_text[9] = "N O " .. character .. " I D E"
indicator_main_text[10] = "N " .. character .. " X I D E"

local function crosshair_indicators()

    local p_r, p_g, p_b, p_a = ui_get(menu.main_colour) -- main colour picker (rgba)
    local me = entity_get_local_player() -- get local player

    local text = "noxide"
    local text_flags = "bc" -- text flags

    ui_set_visible(menu.indicator_character_switch, false)
    if not entity.is_alive(me) then return end

    if not ui.get(menu.master_switch) then return end
    if ui.get(menu.crosshair_indicator_switch) then

        local indicator_flags = "-c" -- indicator flags

        local desync = anti_aim.get_desync(1)
        local offset = 46

        if desync > 0 then
            renderer.text(w / 2 - 7, h / 2 + 22, 255, 255, 255, 255, text_flags, 0, "nox")
            renderer.text(w / 2 + 9, h / 2 + 22, p_r, p_g, p_b, 255, text_flags, 0, "ide")
        else
            renderer.text(w / 2 - 7, h / 2 + 22, p_r, p_g, p_b, 255, text_flags, 0, "nox")
            renderer.text(w / 2 + 9, h / 2 + 22, 255, 255, 255, 255, text_flags, 0, "ide")
        end

        renderer.rectangle(w / 2, h / 2 + 34, 29, 4, 0, 0, 0, 120)
        renderer.rectangle(w / 2, h / 2 + 34, -29, 4, 0, 0, 0, 120)
        renderer.rectangle(w / 2, h / 2 + 34 + 1, desync / 2, 2, p_r, p_g, p_b, 255)
        renderer.rectangle(w / 2, h / 2 + 34 + 1, -desync / 2, 2, p_r, p_g, p_b, 255)

        local me = entity.get_local_player()

        local screen_size = { client.screen_size() }
        local camera_angles = { client.camera_angles() }
    
        local sx, sy = screen_size[1] / 2, screen_size[2] / 2
    
        local by = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(1) - 120)
        local fy = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(2) - 120)
    
        renderer.circle_outline(sx, sy, 0, 0, 0, 120, 10, 0, 1, 3)
        --renderer.circle_outline(sx, sy, 150, 150, 150, 220, 10, by, 0.2, 3)
        renderer.circle_outline(sx, sy, p_r, p_g, p_b, 255, 10, fy, 0.3, 3)

        if ui.get(double_tap) and ui.get(double_tap_key) then
            if not doubletap_charged() then
                renderer.text(w / 2, h / 2 + offset + 2, 255, 255, 255, 255, indicator_flags, 0, "DOUBLETAP")
                offset = offset + 11
            else
                renderer.text(w / 2, h / 2 + offset + 2, p_r, p_g, p_b, 255, indicator_flags, 0, "DOUBLETAP")
                offset = offset + 11
            end
        end

        if ui.get(hideshots) and ui.get(hideshots_key) then
            if ui.get(double_tap_key) or ui.get(fakeduck) then
                renderer.text(w / 2, h / 2 + offset + 2, 255, 255, 255, 255, indicator_flags, 0, "HIDESHOTS")
                offset = offset + 11
            else
                renderer.text(w / 2, h / 2 + offset + 2, p_r, p_g, p_b, 255, indicator_flags, 0, "HIDESHOTS")
                offset = offset + 11
            end
        end

        if ui.get(fakeduck) then
            renderer.text(w / 2, h / 2 + offset + 2, p_r, p_g, p_b, 255, indicator_flags, 0, "FAKEDUCK")
            offset = offset + 11
        end

        if ui.get(quick_peek_assist) and ui.get(quick_peek_assist_key) then
            if ui.get(double_tap_key) then
                renderer.text(w / 2, h / 2 + offset + 2, p_r, p_g, p_b, 255, indicator_flags, 0, "IDEAL TICK")
                offset = offset + 11
            else
                renderer.text(w / 2, h / 2 + offset + 2, p_r, p_g, p_b, 255, indicator_flags, 0, "QUICKPEEK")
                offset = offset + 11
            end
        end
    end
end

local function contains(b, c)
    for d, e in pairs(b) do
        if e == c then
            return true
        end
    end
    return false
end

local function remove_default_indicators()
    if not ui.get(menu.master_switch) then return end
    if not ui.get(menu.remove_default_indicators_switch) then return end
    for i=1, 400 do
        renderer.indicator(0, 0, 0, 0, " ")
    end
end

local function die_on_hit()

    local health = entity.get_prop(me, "m_iHealth")

    ui_set_visible(menu.hp_slider, false)
    ui_set_visible(menu.options, false)
    ui_set_visible(menu.message_box, false)

    if not ui.get(menu.die_on_hit_switch) then
        return
    end
    if ui.get(menu.die_on_hit_switch) then
        if ui_get(menu.sections) == "Misc" then
            ui.set_visible(menu.hp_slider, true)
            ui.set_visible(menu.options, true)
            ui.set_visible(menu.message_box, true)
        end

        local slider_num = ui.get(menu.hp_slider)
        if health < slider_num then
            client.exec("kill")
        end

        if contains(ui.get(menu.options), "Message") then
            ui.set_visible(menu.message_box, true)
            local message = ui.get(menu.message_box)
            if health < slider_num then
                client.exec("say " .. message)
            end
        end
        if contains(ui.get(menu.options), "Reset Score") then
            if health < slider_num then
                client.exec("rs")
            end
        end
    end
end

local time = 0
local x = 1
local clantags = {}

clantags[1] = "n"
clantags[2] = "no"
clantags[3] = "nox"
clantags[4] = "noxi"
clantags[5] = "noxid"
clantags[6] = "noxide"
clantags[7] = "noxide"
clantags[8] = "noxide"
clantags[9] = "noxide"
clantags[10] = "noxide"
clantags[11] = "noxide"
clantags[12] = "oxide"
clantags[13] = "xide"
clantags[14] = "ide"
clantags[15] = "de"
clantags[16] = "e"
clantags[17] = ""

local function clantag()
    ui_set_visible(menu.clantag_type, false)
    if not ui.get(menu.master_switch) then
        return
    end

    if ui.get(menu.clantag_switch) then
        if ui_get(menu.sections) == "Misc" then
            ui_set_visible(menu.clantag_type, true)
        end

        if ui.get(menu.clantag_type) == "Static" then
            client.set_clan_tag("noxide")
        end
        if ui.get(menu.clantag_type) == "Animated" then
            if globals_realtime() >= time then
                client_set_clan_tag(clantags[x]) -- setting the clantag between the tags in the table based on the true or false variable a
                time = globals_realtime() + 0.4 -- you can change the number depending on how fast you want the clantag to show
                x = x + 1
            end

            if x == #clantags + 1 then
                x = 1
            end
        end
    end
end

local function randomize_fake_yaw()
    ui_set_visible(menu.fake_yaw_randomizer_slider, false)
    if not ui_get(menu.master_switch) then
        return
    end
    if not ui_get(menu.fake_yaw_randomizer_switch) then
        return
    end

    if ui_get(menu.fake_yaw_randomizer_switch) and ui_get(menu.sections) == "Anti-Aim" then
        ui_set_visible(menu.fake_yaw_randomizer_slider, true)
    end

    local slider_value = ui_get(menu.fake_yaw_randomizer_slider)
    ui_set(fakeyaw_slider, client_random_int(slider_value, 60))
end

client_set_event_callback(
    "aim_hit",
    function(e)
        if not ui.get(menu.master_switch) then
            return
        end
        if not ui.get(menu.hit_logs_switch) then
            return
        end

        if ui.get(menu.hit_logs_switch) then
            local hitgroup_names = {
                "generic",
                "head",
                "chest",
                "stomach",
                "left arm",
                "right arm",
                "left leg",
                "right leg",
                "neck",
                "?",
                "gear"
            }
            local group = hitgroup_names[e.hitgroup + 1] or "?"

            local ent = e.target
            local hc = e.hit_chance
            local dmg = e.damage
            local health = entity.get_prop(ent, "m_iHealth")
            local name = entity.get_player_name(ent)

            client_color_log(255, 255, 255, "[\0")
            client_color_log(0, 255, 0, "noxide\0")
            client_color_log(255, 255, 255, "]\0")
            client_color_log(255, 255, 255, " Hit \0")
            client_color_log(0, 255, 0, name .. "\0")
            client_color_log(255, 255, 255, " for \0")
            client_color_log(0, 255, 0, dmg .. "\0")
            client_color_log(255, 255, 255, " in the \0")
            client_color_log(0, 255, 0, group .. "\0")
            client_color_log(255, 255, 255, " with \0")
            client_color_log(0, 255, 0, hc .. "%\0")
            client_color_log(255, 255, 255, " hitchance. (\0")
            client_color_log(0, 255, 0, health .. "\0")
            client_color_log(255, 255, 255, " health remaining).")
        end
    end
)

client_set_event_callback(
    "aim_miss",
    function(e)
        if not ui.get(menu.master_switch) then
            return
        end
        if not ui.get(menu.hit_logs_switch) then
            return
        end

        if ui.get(menu.hit_logs_switch) then
            local hitgroup_names = {
                "generic",
                "head",
                "chest",
                "stomach",
                "left arm",
                "right arm",
                "left leg",
                "right leg",
                "neck",
                "?",
                "gear"
            }
            local group = hitgroup_names[e.hitgroup + 1] or "?"

            local ent = e.target
            local reason = e.reason
            local hc = e.hit_chance
            local name = entity.get_player_name(ent)

            if reason == "?" then -- not sure why it missed
                reason = "shit cheat"
            end

            client_color_log(255, 255, 255, "[\0")
            client_color_log(255, 0, 0, "noxide\0")
            client_color_log(255, 255, 255, "]\0")
            client_color_log(255, 255, 255, " Missed \0")
            client_color_log(255, 0, 0, name .. "\0")
            client_color_log(255, 255, 255, "'s \0")
            client_color_log(255, 0, 0, group .. "\0")
            client_color_log(255, 255, 255, " due to \0")
            client_color_log(255, 0, 0, reason .. "\0")
            client_color_log(255, 255, 255, ".")
        end
    end
)

local userid_to_entindex = client.userid_to_entindex
local get_player_name = entity.get_player_name
local get_local_player = entity.get_local_player
local is_enemy = entity.is_enemy
local console_cmd = client.exec

local function show_killsay_message_box()
    if ui_get(menu.killsay_switch) and ui_get(menu.sections) == "Misc" then
        ui_set_visible(menu.killsay_message_box, true)
    else
        ui_set_visible(menu.killsay_message_box, false)
    end
end

-- killsay
local function killsay(e)
    ui_set_visible(menu.killsay_message_box, false)
    if not ui_get(menu.master_switch) then return end
    if not ui_get(menu.killsay_switch) then return end

    local victim_userid, attacker_userid = e.userid, e.attacker
    if victim_userid == nil or attacker_userid == nil then return end

    local victim_entindex = userid_to_entindex(victim_userid)
    local attacker_entindex = userid_to_entindex(attacker_userid)

    if attacker_entindex == get_local_player() and is_enemy(victim_entindex) then
        local command = "say " .. ui_get(menu.killsay_message_box)
        console_cmd(command)
    end
end

local function on_paint_ui()
    set_visible()
    watermark()
    crosshair_indicators()
    clantag()
    die_on_hit()
    randomize_fake_yaw()
    remove_default_indicators()
    show_killsay_message_box()
end

local function on_paint()
end

local function on_run_command()
end

local function main()
    client_set_event_callback("paint", on_paint)
    client_set_event_callback("paint_ui", on_paint_ui)
    client_set_event_callback("run_command", on_run_command)
    client_set_event_callback("player_death", killsay)
end
main()
