--[[
	id: rouX8VFvYcusfOpREDg6S
	name: senza
	description: senza
	time1: 2021-06-12 20:40:10.852453+00
	time2: 2021-06-12 20:40:10.852453+00
	uploader: iV3nx7nQD7CLjRr8MeQZFqm25MCv-r6q8s4PuGqi
	uploadersession: pWmWltTLwUEaVTQ82qvkxK1-UtHy_O
	flag: f
--]]

-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_color_log, client_set_event_callback, panorama_open, pairs, func, type, next =
    client.color_log,
    client.set_event_callback,
    panorama.open,
    pairs,
    func,
    type,
    next
local js = panorama_open()
local api = js.MyPersonaAPI
local name = api.GetName()
local userid_to_entindex = client.userid_to_entindex
local get_player_name = entity.get_player_name
local get_local_player = entity.get_local_player
local is_enemy = entity.is_enemy
local console_cmd = client.exec
local ui_get = ui.get

Latency = client.latency
LocalPlayer, GetProp = entity.get_local_player, entity.get_prop
min, abs, sqrt, floor = math.min, math.abs, math.sqrt, math.floor
RealTime = globals.realtime
TimeStart = RealTime

client_color_log(255, 0, 255, "senza.lua")
client_color_log(255, 255, 255, "Welcome back " .. name .. "!")
client_color_log(255, 255, 255, "Last update: In 13.06.2021")
client_color_log(255, 0, 255, "best legit-semi lua")

---[ API ]---
local client_camera_angles,
    client_color_log,
    client_create_interface,
    client_delay_call,
    client_draw_hitboxes,
    client_eye_position,
    client_find_signature,
    client_get_cvar,
    client_latency,
    client_log,
    client_screen_size,
    client_set_cvar,
    client_set_event_callback,
    client_update_player_list,
    client_userid_to_entindex,
    client_visible,
    entity_get_classname,
    entity_get_local_player,
    entity_get_player_name,
    entity_get_player_weapon,
    entity_get_players,
    entity_get_prop,
    entity_hitbox_position,
    globals_absoluteframetime,
    globals_realtime,
    globals_tickinterval,
    math_abs,
    math_atan2,
    math_floor,
    math_pow,
    math_sqrt,
    renderer_circle,
    renderer_circle_outline,
    renderer_indicator,
    renderer_text,
    renderer_world_to_screen,
    require,
    string_format,
    string_match,
    table_concat,
    table_insert,
    table_remove,
    ui_get,
    ui_new_button,
    ui_new_checkbox,
    ui_new_color_picker,
    ui_new_combobox,
    ui_new_hotkey,
    ui_new_multiselect,
    ui_new_slider,
    ui_reference,
    ui_set,
    ui_set_callback,
    ui_set_visible,
    error,
    pairs =
    client.camera_angles,
    client.color_log,
    client.create_interface,
    client.delay_call,
    client.draw_hitboxes,
    client.eye_position,
    client.find_signature,
    client.get_cvar,
    client.latency,
    client.log,
    client.screen_size,
    client.set_cvar,
    client.set_event_callback,
    client.update_player_list,
    client.userid_to_entindex,
    client.visible,
    entity.get_classname,
    entity.get_local_player,
    entity.get_player_name,
    entity.get_player_weapon,
    entity.get_players,
    entity.get_prop,
    entity.hitbox_position,
    globals.absoluteframetime,
    globals.realtime,
    globals.tickinterval,
    math.abs,
    math.atan2,
    math.floor,
    math.pow,
    math.sqrt,
    renderer.circle,
    renderer.circle_outline,
    renderer.indicator,
    renderer.text,
    renderer.world_to_screen,
    require,
    string.format,
    string.match,
    table.concat,
    table.insert,
    table.remove,
    ui.get,
    ui.new_button,
    ui.new_checkbox,
    ui.new_color_picker,
    ui.new_combobox,
    ui.new_hotkey,
    ui.new_multiselect,
    ui.new_slider,
    ui.reference,
    ui.set,
    ui.set_callback,
    ui.set_visible,
    error,
    pairs,
    client_set_clan_tag,
    client.set_clan_tag
-------------

local surface_success, surface = pcall(require, "gamesense/surface")
local csgo_weapons_success, csgo_weapons = pcall(require, "gamesense/csgo_weapons")

if not surface_success or not csgo_weapons_success then
    error(
        "Missing the following dependency(s)" ..
            (not surface_success and
                "\n\n - Surface renderer library \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n" or
                "") ..
                (not csgo_weapons_success and
                    "\n\n - CS:GO weapon data library \n - https://gamesense.pub/forums/viewtopic.php?id=18807\n") or ""
    )
end

local plist_set = plist.get
local vector = require("vector")
local ffi = require("ffi")
local ffi_cast = ffi.cast

local vars = {
    name_player = nil,
    dynamicfov_new = 0,
    bool_in_fov = false,
    closest_enemy = nil,
    visible = false,
    fire = false,
    penetration_shotme = false,
    cached_target,
    oldcfg = nil
}

local weapon_classes = {
    ["CWeaponG3SG1"] = "Snipers",
    ["CWeaponSCAR20"] = "Snipers",
    ["CWeaponAWP"] = "Snipers",
    ["CWeaponSSG08"] = "Snipers",
    ["CDEagle"] = "Deagle",
    ["CWeaponFiveSeven"] = "Pistols",
    ["CWeaponHKP2000"] = "Pistols",
    ["CWeaponP250"] = "Pistols",
    ["CWeaponGlock"] = "Pistols",
    ["CWeaponElite"] = "Pistols",
    ["CWeaponTec9"] = "Pistols",
    ["CAK47"] = "Rifles",
    ["CWeaponAug"] = "Rifles",
    ["CWeaponFamas"] = "Rifles",
    ["CWeaponGalilAR"] = "Rifles",
    ["CWeaponM4A1"] = "Rifles",
    ["CWeaponSG556"] = "Rifles",
    ["CWeaponMP7"] = "SMG",
    ["CWeaponMP9"] = "SMG",
    ["CWeaponBizon"] = "SMG",
    ["CWeaponP90"] = "SMG",
    ["CWeaponUMP45"] = "SMG",
    ["CWeaponM249"] = "Machine gun",
    ["CWeaponNegev"] = "Machine gun",
    ["CWeaponMag7"] = "Shotgun",
    ["CWeaponNOVA"] = "Shotgun",
    ["CWeaponSawedoff"] = "Shotgun",
    ["CWeaponXM1014"] = "Shotgun"
}

local function table_contains(tbl, val)
    for i = 1, #tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end

local function can_see(ent)
    for i = 0, 18 do
        if client_visible(entity_hitbox_position(ent, i)) then
            return true
        end
    end
    return false
end

local function FpsTable()
    local Fps_Table = {}
    Fps_Table[59] = "Tickrate"
    for i = 1, 241 do
        Fps_Table[59 + i] = 59 + i .. "fps"
    end
    return Fps_Table
end

local function setName(delay, name)
    client_delay_call(
        delay,
        function()
            client_set_cvar("name", name)
        end
    )
end
--------------

---[ References ]---
local rage = {
    ragebot = {ui_reference("RAGE", "Aimbot", "Enabled")},
    fire = ui_reference("RAGE", "Aimbot", "Automatic fire"),
    penetration = ui_reference("RAGE", "Aimbot", "Automatic penetration"),
    fov = ui_reference("RAGE", "Aimbot", "Maximum FOV"),
    miss = ui_reference("RAGE", "Aimbot", "Log misses due to spread"),
    force_safe_point = ui_reference("RAGE", "Aimbot", "Force safe point"),
    force_body_aim = ui_reference("RAGE", "Other", "Force body aim"),
    override = ui_reference("RAGE", "Other", "Anti-aim correction override")
}

local ref = {
    aa = {
        enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
        pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
        yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
        yaw_mode = ui.reference("AA", "Anti-aimbot angles", "Yaw"),
        yaw = select(2, ui.reference("AA", "Anti-aimbot angles", "Yaw")),
        yaw_jitter_mode = ui.reference("AA", "Anti-aimbot angles", "Yaw Jitter"),
        yaw_jitter = select(2, ui.reference("AA", "Anti-aimbot angles", "Yaw Jitter")),
        body_yaw_mode = ui.reference("AA", "Anti-aimbot angles", "Body yaw"),
        body_yaw = select(2, ui.reference("AA", "Anti-aimbot angles", "Body yaw")),
        frstnd_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
        fake_yaw_limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
        edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
        frstnd = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
    }
}

local fl = {
    fakelag = {ui_reference("AA", "Fake lag", "Enabled")},
    limit = ui_reference("AA", "Fake lag", "Limit")
}

local misc = {
    cfg = {ui_reference("CONFIG", "Presets", "Presets")},
    damage = ui_reference("MISC", "Miscellaneous", "Log damage dealt"),
    namesteal = ui_reference("MISC", "Miscellaneous", "Steal player name")
}

local players = {
    lists = ui_reference("PLAYERS", "Players", "Player list"),
    whitelist = ui_reference("PLAYERS", "Adjustments", "Add to whitelist"),
    reset_all = ui_reference("PLAYERS", "Players", "Reset all")
}

local useless = {
    pitch = {ui_reference("AA", "Anti-aimbot angles", "Pitch")},
    yaw_base = {ui_reference("AA", "Anti-aimbot angles", "Yaw base")},
    yaw = {ui_reference("AA", "Anti-aimbot angles", "Yaw")},
    yaw_jitter = {ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")},
    edge_yaw = ui_reference("AA", "Anti-aimbot angles", "Edge yaw"),
    fake_yaw_limit = {ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit")},
    fs = {ui_reference("AA", "Anti-aimbot angles", "Freestanding")},
    onshot_aa = {ui_reference("AA", "Other", "On shot anti-aim")},
    fake_peek = {ui_reference("AA", "Other", "Fake peek")},
    double_tap = {ui_reference("RAGE", "Other", "Double tap")}
}
gamesense = ui.reference("MISC", "Miscellaneous", "Clan tag spammer")
--------------------

---[ Menu ]---
local semirage = {
    header = ui.new_label("RAGE", "Other", "⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯"),
    lite = ui_new_checkbox("RAGE", "Other", "8=D                   SENZA.lua                   8=D"),
    header = ui.new_label("RAGE", "Other", "⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯"),
    fire = ui_new_checkbox("RAGE", "Other", "Triggerio Magnetirio"),
    fire_hotkey = ui_new_hotkey("RAGE", "Other", "Automatic fire", true),
    penetration = ui_new_checkbox("RAGE", "Other", "Waller Shooter"),
    penetration_hotkey = ui_new_hotkey("RAGE", "Other", "Automatic penetration", true),
    penetration_mode = {ui_new_multiselect("RAGE", "Other", "\nPenetration mode", "On Key", "Visible", "If shotta me")},
    penetration_delay_turnson = ui_new_slider("RAGE", "Other", "Turns on if shotta me", 0, 120, 1, true, "s"),
    penetration_delay_stayson = ui_new_slider("RAGE", "Other", "Stays on if shotta me", 1, 180, 50, true, "s"),
    dynamicfov = ui_new_checkbox("RAGE", "Other", "Magic FOV"),
    dynamicfov_mode = {ui_new_combobox("RAGE", "Other", "\nDynamic FOV", "Off", "Static", "Auto")},
    dynamicfov_restrict = ui_new_checkbox("RAGE", "Other", "Restrict updates"),
    dynamicfov_min = ui_new_slider("RAGE", "Other", "Minimal FOV", 1, 180, 3, true, "°", 1),
    dynamicfov_max = ui_new_slider("RAGE", "Other", "Maximum FOV", 1, 180, 6, true, "°", 1),
    dynamicfov_auto_factor = ui_new_slider("RAGE", "Other", "Automatic Factor", 0, 250, 30, true, "x", 0.01),
    dynamicfov_indicators1 = {ui_new_combobox("RAGE", "Other", "\nIndicators1", "Off", "Circle", "Outline")},
    dynamicfov_colors1 = ui_new_color_picker("RAGE", "Other", "\nIndicators1", 123, 194, 21, 50),
    improvements = ui_new_checkbox("RAGE", "Other", "Improvements"),
    improvements_mode = {
        ui_new_multiselect(
            "RAGE",
            "Other",
            "Aimbotter improvements",
            "Snipers",
            "Deagle",
            "Pistols",
            "Rifles",
            "SMGs",
            "Machine guns",
            "Shotguns"
        )
    },
    improvements_hotkey = ui_new_hotkey("RAGE", "Other", "\nAimbotter improvements", true, 0x01),
    improvements_nades = {ui_new_multiselect("RAGE", "Other", "Disable shooting", "Smokerino", "Flasherino")},
    indicators = ui_new_checkbox("RAGE", "Other", "Indicators"),
    indicators_mode = {
        ui_new_multiselect(
            "RAGE",
            "Other",
            "\nIndicators",
            "Automatic fire",
            "Automatic penetration",
            "Force body aim",
            "Force safe point",
            "Override"
        )
    },
    indicators_color = ui_new_color_picker("RAGE", "Other", "\nIndicators", 123, 194, 21, 255),
    advanced_logs = ui_new_checkbox("RAGE", "Other", "Console logs"),
    logs_mode = {ui_new_multiselect("RAGE", "Other", "\nConsole logs", "Shotted", "Missed")},
    hide_useless_features = ui_new_checkbox("RAGE", "Other", "Hide shit useless features"),
    trashtalk = ui.new_checkbox("MISC", "Miscellaneous", "Killsay"),
    enabled_reference = ui.new_checkbox("Misc", "Miscellaneous", "Senza.lua clantag"),
    aa = {
        enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "Anti Aimerio"),
        mode = ui.new_combobox(
            "AA",
            "Anti-aimbot angles",
            "\nanti shootz mode",
            "Automaticarino",
            "Manuarino",
            "Jitterio"
        ),
        hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "Anti aimerio fakerio swappik", false)
    }
}

ui.set(semirage.aa.hotkey, "Toggle")

--------------------------------------------------------------------------------
-- Watermark
--------------------------------------------------------------------------------
function on_paint()
    local x, y
    local screenWidth, screenHeight = client.screen_size()
    local x = screenWidth - 981
    local x2 = screenWidth - 955

    renderer.text(x, 550, 255, 255, 255, 255, "-", 0, "SENZA.")
    renderer.text(x2, 550, 102, 102, 255, 255, "-", 0, "LUA")
end
client.set_event_callback("paint", on_paint)
--------------------------------------------------------------------------------
-- Clan tag animations
--------------------------------------------------------------------------------

local function time_to_ticks(time)
    return math.floor(time / globals.tickinterval() + .5)
end

local function gamesense_anim(text, indices)
    local text_anim = "               " .. text .. "                      "
    local tickinterval = globals.tickinterval()
    local tickcount = globals.tickcount() + time_to_ticks(client.latency())
    local i = tickcount / time_to_ticks(0.19)
    i = math.floor(i % #indices)
    i = indices[i + 1] + 1
    return string.sub(text_anim, i, i + 15)
end

local function run_tag_animation()
    if ui.get(semirage.enabled_reference) then
        local clan_tag =
            gamesense_anim(
            "senza.lua",
            {
                0,
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                11,
                11,
                11,
                11,
                11,
                11,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22
            }
        )
        if clan_tag ~= clan_tag_prev then
            client.set_clan_tag(clan_tag)
        end
        clan_tag_prev = clan_tag
    end
end

client.set_event_callback(
    "run_command",
    function(c)
        chokedcmds = c.chokedcommands
    end
)

local was_enabled = false
local function on_run_command(c)
    if ui.get(semirage.enabled_reference) then
        if (chokedcmds == 0) or not (entity.is_alive(entity.get_local_player())) then
            run_tag_animation()
            was_enabled = true
        end
    elseif (not ui.get(semirage.enabled_reference) and not ui.get(gamesense)) and was_enabled then
        client.set_clan_tag("\0")
        was_enabled = false
    end
end
client.set_event_callback("paint", on_run_command)
--------------------------------------------------------------------------------
--  Anti-Aim
--------------------------------------------------------------------------------

local function handle_menu()
    local aa_enabled = ui.get(semirage.aa.enabled)
    ui.set_visible(semirage.aa.mode, aa_enabled)

    local aa_is_manual = ui.get(semirage.aa.mode) == "Manuarino"
    ui.set_visible(semirage.aa.hotkey, aa_enabled and aa_is_manual)
end

handle_menu()
ui.set_callback(semirage.aa.mode, handle_menu)

local function establish(ref, event, func)
    ui.set_callback(
        ref,
        function()
            if ui.get(ref) then
                client.set_event_callback(event, func)
            else
                client.unset_event_callback(event, func)
            end

            handle_menu()
        end
    )
end

local function establish_mult(ref, tab)
    ui.set_callback(
        ref,
        function()
            if ui.get(ref) then
                for event, func in pairs(tab) do
                    client.set_event_callback(event, func)
                end
            else
                for event, func in pairs(tab) do
                    client.unset_event_callback(event, func)
                end
            end

            for event, func in pairs(tab) do
                if event == "ui" then
                    func()
                end
            end

            handle_menu()
        end
    )
end

local function aa()
    local mode = ui.get(semirage.aa.mode)

    ui.set(ref.aa.enabled, true)
    ui.set(ref.aa.pitch, "Off")
    ui.set(ref.aa.yaw_base, "Local view")
    ui.set(ref.aa.yaw_mode, "180")
    ui.set(ref.aa.yaw, 180)
    ui.set(ref.aa.yaw_jitter_mode, "Off")

    ui.set(
        ref.aa.body_yaw_mode,
        mode == "Automaticarino" and "Opposite" or mode == "Manuarino" and "Static" or "Jitter"
    )

    ui.set(
        ref.aa.body_yaw,
        (mode == "Manuarino" and (ui.get(semirage.aa.hotkey) and -180 or 180)) or
            (mode == "Jitterio" and client.random_int(-180, 180)) or
            0
    )

    ui.set(ref.aa.frstnd_body_yaw, mode == "Automaticarino")
    ui.set(ref.aa.edge_yaw, false)
    ui.set(ref.aa.frstnd, "")
end

establish(semirage.aa.enabled, "paint", aa)

--------------------------------------------------------------------------------
--  NameSpam senza
--------------------------------------------------------------------------------

local spam =
    ui_new_button(
    "RAGE",
    "Other",
    "Get Good Get SENZA.lua",
    function()
        local player = entity_get_local_player()
        local player_name = entity_get_player_name(player)
        vars.name_player = player_name
        local name = vars.name_player
        ui_set(misc.namesteal, true)
        client_set_cvar("name", name)
        setName(0.1, "Get")
        setName(0.2, "Get Good")
        setName(0.3, "Get Good Get")
        setName(0.4, "Get Good Get SENZA.lua")
        setName(0.5, name)
    end
)
--------------

---[ Function #1 ]---
local function visibility()
    local lite = ui_get(semirage.lite)
    local improvements = ui_get(semirage.improvements)
    local fire = ui_get(semirage.fire)
    local trashtalk = ui_get(semirage.trashtalk)
    local enabled_reference = ui_get(semirage.enabled_reference)
    local penetration = ui_get(semirage.penetration)
    local penetration_onhotkey = table_contains(ui_get(semirage.penetration_mode[1]), "On Key")
    local penetration_shotme = table_contains(ui_get(semirage.penetration_mode[1]), "If shotta me")
    local dynamicfov = ui_get(semirage.dynamicfov)
    local dynamic_off = (ui_get(semirage.dynamicfov_mode[1]) == "Off")
    local dynamic_static = (ui_get(semirage.dynamicfov_mode[1]) == "Static")
    local dynamic_auto = (ui_get(semirage.dynamicfov_mode[1]) == "Auto")
    local dynamic_indicators1 = (ui_get(semirage.dynamicfov_indicators1[1]) == "Off")
    local indicators = ui_get(semirage.indicators)
    local logs = ui_get(semirage.advanced_logs)
    local logs_hit = table_contains(ui_get(semirage.logs_mode[1]), "Shotted")
    local logs_miss = table_contains(ui_get(semirage.logs_mode[1]), "Missed")
    local hide_useless = ui_get(semirage.hide_useless_features)
    local enabled = ui_get(semirage.aa.enabled)
    local mode = ui_get(semirage.aa.mode)
    local hotkey = ui_get(semirage.aa.hotkey)

    if lite == true then
        ui_set_visible(semirage.fire, true)
        ui_set_visible(semirage.trashtalk, true)
        ui_set_visible(semirage.penetration, true)
        ui_set_visible(semirage.dynamicfov, true)
        ui_set_visible(semirage.indicators, true)
        ui_set_visible(semirage.hide_useless_features, true)
        ui_set_visible(semirage.advanced_logs, true)
        ui_set_visible(semirage.improvements, true)
        ui_set_visible(spam, true)
        ui_set_visible(semirage.enabled_reference, true)
        ui_set_visible(semirage.aa.enabled, true)
        ui_set_visible(semirage.aa.mode, true)
        ui_set_visible(semirage.aa.hotkey, true)
    else
        ui_set(semirage.fire, false)
        ui_set_visible(semirage.fire, false)
        ui_set_visible(semirage.trashtalk, false)
        ui_set(semirage.penetration, false)
        ui_set_visible(semirage.penetration, false)
        ui_set(semirage.dynamicfov, false)
        ui_set_visible(semirage.dynamicfov, false)
        ui_set(semirage.indicators, false)
        ui_set_visible(semirage.indicators, false)
        ui_set(semirage.hide_useless_features, false)
        ui_set_visible(semirage.hide_useless_features, false)
        ui_set(semirage.advanced_logs, false)
        ui_set_visible(semirage.advanced_logs, false)
        ui_set(semirage.improvements, false)
        ui_set_visible(semirage.improvements, false)
        ui_set_visible(spam, false)
        ui_set_visible(semirage.enabled_reference, false)
        ui_set_visible(semirage.aa.enabled, false)
        ui_set_visible(semirage.aa.mode, false)
        ui_set_visible(semirage.aa.hotkey, false)
    end

    if improvements then
        ui_set_visible(semirage.improvements_mode[1], true)
        ui_set_visible(semirage.improvements_hotkey, true)
        ui_set_visible(semirage.improvements_nades[1], true)
    else
        ui_set_visible(semirage.improvements_mode[1], false)
        ui_set_visible(semirage.improvements_hotkey, false)
        ui_set_visible(semirage.improvements_nades[1], false)
    end

    if fire then
        ui_set_visible(semirage.fire_hotkey, true)
    else
        ui_set_visible(semirage.fire_hotkey, false)
    end

    if penetration then
        ui_set_visible(semirage.penetration_mode[1], true)
    else
        ui_set(semirage.penetration_mode[1], "-")
        ui_set_visible(semirage.penetration_mode[1], false)
    end

    if dynamicfov then
        ui_set_visible(semirage.dynamicfov_mode[1], true)
    else
        ui_set(semirage.dynamicfov_mode[1], "OFf")
        ui_set_visible(semirage.dynamicfov_mode[1], false)
        ui_set(semirage.dynamicfov_indicators1[1], "Off")
    end

    if penetration_onhotkey then
        ui_set_visible(semirage.penetration_hotkey, true)
    else
        ui_set_visible(semirage.penetration_hotkey, false)
    end

    if penetration_shotme then
        ui_set_visible(semirage.penetration_delay_stayson, true)
        ui_set_visible(semirage.penetration_delay_turnson, true)
    else
        ui_set_visible(semirage.penetration_delay_stayson, false)
        ui_set_visible(semirage.penetration_delay_turnson, false)
    end

    if dynamic_off then
        ui_set_visible(semirage.dynamicfov_min, false)
        ui_set_visible(semirage.dynamicfov_max, false)
        ui_set_visible(semirage.dynamicfov_auto_factor, false)
        ui_set_visible(semirage.dynamicfov_restrict, false)
        ui_set_visible(semirage.dynamicfov_indicators1[1], false)
    end

    if dynamic_static then
        ui_set_visible(semirage.dynamicfov_min, true)
        ui_set_visible(semirage.dynamicfov_max, true)
        ui_set_visible(semirage.dynamicfov_auto_factor, false)
        ui_set_visible(semirage.dynamicfov_restrict, true)
        ui_set_visible(semirage.dynamicfov_indicators1[1], true)
    end

    if dynamic_auto then
        ui_set_visible(semirage.dynamicfov_min, true)
        ui_set_visible(semirage.dynamicfov_max, true)
        ui_set_visible(semirage.dynamicfov_auto_factor, true)
        ui_set_visible(semirage.dynamicfov_restrict, true)
        ui_set_visible(semirage.dynamicfov_indicators1[1], true)
    end

    if dynamic_indicators1 then
        ui_set_visible(semirage.dynamicfov_colors1, false)
    else
        ui_set_visible(semirage.dynamicfov_colors1, true)
    end

    if indicators then
        ui_set_visible(semirage.indicators_mode[1], true)
        ui_set_visible(semirage.indicators_color, true)
    else
        ui_set_visible(semirage.indicators_mode[1], false)
        ui_set_visible(semirage.indicators_color, false)
    end

    if logs then
        ui_set_visible(semirage.logs_mode[1], true)
    else
        ui_set(semirage.logs_mode[1], "-")
        ui_set_visible(semirage.logs_mode[1], false)
    end

    if logs_hit then
        ui_set(misc.damage, false)
        ui_set_visible(misc.damage, false)
    else
        ui_set_visible(misc.damage, true)
    end

    if logs_miss then
        ui_set(rage.miss, false)
        ui_set_visible(rage.miss, false)
    else
        ui_set_visible(rage.miss, true)
    end

    if hide_useless then
        ui_set_visible(useless.onshot_aa[1], false)
        ui_set_visible(useless.onshot_aa[2], false)
        ui_set_visible(useless.fake_peek[1], false)
        ui_set_visible(useless.fake_peek[2], false)
        ui_set_visible(useless.double_tap[1], false)
        ui_set_visible(useless.double_tap[2], false)
    else
        ui_set_visible(useless.onshot_aa[1], true)
        ui_set_visible(useless.onshot_aa[2], true)
        ui_set_visible(useless.fake_peek[1], true)
        ui_set_visible(useless.fake_peek[2], true)
        ui_set_visible(useless.double_tap[1], true)
        ui_set_visible(useless.double_tap[2], true)
    end
end
client_set_event_callback("pre_render", visibility)
---------------------

---[ Function #2 ]---
local function on_paint(ctx)
    local r, g, b, a = ui_get(semirage.indicators_color)
    local current_weapon = weapon_classes[entity_get_classname(entity_get_player_weapon(entity_get_local_player()))]

    local enabled, fov, penetration, fire =
        ui_get(rage.ragebot[1]),
        ui_get(rage.fov),
        ui_get(rage.penetration),
        ui_get(rage.fire)
    local improvements_hotkey = ui_get(semirage.improvements_hotkey)
    local FireOn, PenetrationOn = ui_get(semirage.fire), ui_get(semirage.penetration)
    local IsFire = ui_get(semirage.fire_hotkey)
    local IsPenetration = ui_get(semirage.penetration_hotkey)
    local IsForceSafePoint = ui_get(rage.force_safe_point)
    local IsForceBodyAim = ui_get(rage.force_body_aim)
    local IsOverride = ui_get(rage.override)
    local indicator_fire = table_contains(ui_get(semirage.indicators_mode[1]), "Automatic fire")
    local indicator_penetration = table_contains(ui_get(semirage.indicators_mode[1]), "Automatic penetration")
    local indicator_baim = table_contains(ui_get(semirage.indicators_mode[1]), "Force body aim")
    local indicator_safe = table_contains(ui_get(semirage.indicators_mode[1]), "Force safe point")
    local indicator_override = table_contains(ui_get(semirage.indicators_mode[1]), "Override")

    if enabled then
        renderer_indicator(r, g, b, a, "FOV: ", fov, "°")
    end

    if penetration and indicator_penetration then
        renderer_indicator(r, g, b, a, "A-Wallerino")
    end

    if fire and indicator_fire then
        renderer_indicator(r, g, b, a, "Triggerino")
    end

    if IsForceBodyAim and indicator_baim then
        renderer_indicator(r, g, b, a, "Baimerino")
    end

    if IsForceSafePoint and indicator_safe then
        renderer_indicator(r, g, b, a, "Safepointik")
    end

    if IsOverride and indicator_override then
        renderer_indicator(r, g, b, a, "Overrider")
    end

    if IsFire or improvements_hotkey and table_contains(ui_get(semirage.improvements_mode[1]), current_weapon) then
        vars.fire = true
    else
        vars.fire = false
    end

    if PenetrationOn and vars.penetration_shotme or PenetrationOn and IsPenetration or PenetrationOn and vars.visible then
        ui_set(rage.penetration, true)
    else
        ui_set(rage.penetration, false)
    end

    if vars.fire and FireOn then
        ui_set(rage.ragebot[2], "Always on")
        ui_set(rage.fire, true)
    else
        ui_set(rage.ragebot[2], "On hotkey")
        ui_set(rage.fire, false)
    end
end

client_set_event_callback("paint", on_paint)
---------------------

---[ Function #3 ]---
local function DynamicFOV()
    local mode = ui_get(semirage.dynamicfov_mode[1])
    if mode ~= "Off" then
        local old_fov = ui_get(rage.fov)
        vars.dynamicfov_new_fov = old_fov
        local enemy_players = entity_get_players(true)

        local min_fov = ui_get(semirage.dynamicfov_min)
        local max_fov = ui_get(semirage.dynamicfov_max)

        if min_fov > max_fov then
            local store_min_fov = min_fov
            min_fov = max_fov
            max_fov = store_min_fov
        end

        if #enemy_players ~= 0 then
            local own_x, own_y, own_z = client_eye_position()
            local own_pitch, own_yaw = client_camera_angles()
            vars.closest_enemy = nil
            local closest_distance = 999999999

            for i = 1, #enemy_players do
                local enemy = enemy_players[i]
                local enemy_x, enemy_y, enemy_z = entity_hitbox_position(enemy, 0)

                local x = enemy_x - own_x
                local y = enemy_y - own_y
                local z = enemy_z - own_z

                local yaw = (math_atan2(y, x) * 180 / math.pi)
                local pitch = -(math_atan2(z, math_sqrt(math_pow(x, 2) + math_pow(y, 2))) * 180 / math.pi)

                local yaw_dif = math_abs(own_yaw % 360 - yaw % 360) % 360
                local pitch_dif = math_abs(own_pitch - pitch) % 360

                if yaw_dif > 180 then
                    yaw_dif = 360 - yaw_dif
                end

                local real_dif = math_sqrt(math_pow(yaw_dif, 2) + math_pow(pitch_dif, 2))

                if closest_distance > real_dif then
                    closest_distance = real_dif
                    vars.closest_enemy = enemy
                end
            end

            if vars.closest_enemy ~= nil then
                local closest_enemy_x, closest_enemy_y, closest_enemy_z = entity_hitbox_position(vars.closest_enemy, 0)
                local real_distance =
                    math_sqrt(
                    math_pow(own_x - closest_enemy_x, 2) + math_pow(own_y - closest_enemy_y, 2) +
                        math_pow(own_z - closest_enemy_z, 2)
                )

                if mode == "Static" then
                    vars.dynamicfov_new = max_fov - ((max_fov - min_fov) * (real_distance - 250) / 1000)
                elseif mode == "Auto" then
                    vars.dynamicfov_new = (3800 / real_distance) * (ui_get(semirage.dynamicfov_auto_factor) * 0.01)
                end

                if (vars.dynamicfov_new > max_fov) then
                    vars.dynamicfov_new = max_fov
                elseif vars.dynamicfov_new < min_fov then
                    vars.dynamicfov_new = min_fov
                end
            end

            vars.dynamicfov_new = math_floor(vars.dynamicfov_new + 0.5)

            if (vars.dynamicfov_new > closest_distance) then
                vars.bool_in_fov = true
            else
                vars.bool_in_fov = false
            end
        else
            vars.dynamicfov_new = min_fov
            vars.bool_in_fov = false
        end

        if vars.dynamicfov_new ~= old_fov then
            ui_set(rage.fov, vars.dynamicfov_new)
        end
    end
end

local function DynamicFOV_drawing()
    local mode = ui_get(semirage.dynamicfov_mode[1])

    if mode ~= "Off" then
        local indicators_mode = ui_get(semirage.dynamicfov_indicators1[1])

        local r, g, b, a = ui_get(semirage.dynamicfov_colors1)

        if indicators_mode ~= "Off" then
            if (indicators_in_fov == "Change circle color") and (vars.bool_in_fov) then
                r, g, b, a = r2, g2, b2, a2
            end

            if string_match(indicators_mode, "Circle") or string_match(indicators_mode, "Outline") then
                local w, h = client_screen_size()
                local w_mid, h_mid = w / 2, h / 2
                local model_fov = client_get_cvar("viewmodel_fov")
                local fov_radius = vars.dynamicfov_new / model_fov * w / 2

                if string_match(indicators_mode, "Circle") then
                    renderer_circle(w_mid, h_mid, r, g, b, a, fov_radius, 0, 1)
                elseif string_match(indicators_mode, "Outline") then
                    if vars.bool_in_fov then
                        renderer_circle_outline(
                            w_mid,
                            h_mid,
                            r,
                            g,
                            b,
                            a,
                            fov_radius,
                            0,
                            1,
                            math_floor(1 + vars.dynamicfov_new / 10) * 2
                        )
                    else
                        renderer_circle_outline(
                            w_mid,
                            h_mid,
                            r,
                            g,
                            b,
                            a,
                            fov_radius,
                            0,
                            1,
                            math_floor(1 + vars.dynamicfov_new / 10)
                        )
                    end
                end
            end
        end

        if (indicators_in_fov == "Draw hitboxes") then
            if vars.bool_in_fov and (vars.closest_enemy ~= nil) then
                client_draw_hitboxes(vars.closest_enemy, 0.01, 19, r2, g2, b2)
            end
        end
    end
end

local function on_run_command()
    if ui_get(semirage.dynamicfov_restrict) then
        DynamicFOV()
    end
end
client_set_event_callback("run_command", on_run_command)

local function dynamicfov_paint()
    local restrict = ui_get(semirage.dynamicfov_restrict)

    if not restrict then
        DynamicFOV()
    end
    DynamicFOV_drawing()
end
client_set_event_callback("paint", dynamicfov_paint)
---------------------

---[ Function #4 ]---
local function vec2_dist(f_x, f_y, t_x, t_y)
    local delta_x, delta_y = f_x - t_x, f_y - t_y
    return math_sqrt(delta_x * delta_x + delta_y * delta_y)
end

local function get_all_player_locations(w, h, enemy)
    local indexes = {}
    local positions = {}
    local players = entity_get_players(enemy)
    if #players == 0 or not (#players) then
        return
    end

    for i = 1, #players do
        local p = players[i]

        local px, py, pz = entity_get_prop(p, "m_vecOrigin")
        local vz = entity_get_prop(p, "m_vecViewOffset[2]")

        if pz ~= nil and vz ~= nil then
            pz = pz + (vz * 0.5)
            local sx, sy = renderer_world_to_screen(px, py, pz)
            if sx ~= nil and sy ~= nil then
                if sx >= 0 and sx < w and sy >= 0 and sy <= h then
                    indexes[#indexes + 1] = p
                    positions[#positions + 1] = {sx, sy}
                end
            end
        end
    end

    return indexes, positions
end

local function check_fov()
    local w, h = client_screen_size()
    local sx, sy = w * 0.5, h * 0.5
    local fov_limit = 250

    if get_all_player_locations(w, h, true) == nil then
        return
    end

    local enemy_indexes, enemy_coords = get_all_player_locations(w, h, true)
    if #enemy_indexes <= 0 then
        return true
    end
    if #enemy_coords == 0 then
        return true
    end

    local closest_fov = 133337
    local closest_entindex = 133337
    for i = 1, #enemy_coords do
        local x = enemy_coords[i][1]
        local y = enemy_coords[i][2]

        local cur_fov = vec2_dist(x, y, sx, sy)
        if cur_fov < closest_fov then
            closest_fov = cur_fov
            closest_entindex = enemy_indexes[i]
        end
    end

    return closest_fov > fov_limit, closest_entindex
end

local function enable_penetration_shotme()
    vars.penetration_shotme = true
end

local function disable_penetration_shotme()
    vars.penetration_shotme = false
end

local function penetration_shotme(e)
    local userid = e.userid
    local entindex = client_userid_to_entindex(userid)
    if entindex == entity_get_local_player() then
        local shot_me = table_contains(ui_get(semirage.penetration_mode[1]), "If shotta me")

        if not shot_me then
            vars.penetration_shotme = false
            return
        end

        client_delay_call(ui_get(semirage.penetration_delay_turnson), enable_penetration_shotme)
        client_delay_call(ui_get(semirage.penetration_delay_stayson), disable_penetration_shotme)
    end
end
client_set_event_callback("player_hurt", penetration_shotme)

client_set_event_callback(
    "paint",
    function()
        local visible = table_contains(ui_get(semirage.penetration_mode[1]), "Visible")

        if visible then
            local enemy_visible, enemy_entindex = check_fov()
            if enemy_entindex == nil then
                return
            end
            if enemy_visible and enemy_entindex ~= nil and vars.cached_target ~= enemy_entindex then
                vars.cached_target = enemy_entindex
            end
            local _ = can_see(enemy_entindex)
            if _ then
                vars.visible = true
            else
                vars.visible = false
            end
            vars.cached_target = enemy_entindex
        else
            return
        end
    end
)

client_set_event_callback(
    "round_start",
    function()
        vars.visible = false
        vars.penetration_shotme = false
        vars.name_player = nil
    end
)
---------------------

---[ Function #5 ]---
local frametimes = {}
local fps_prev = 0
local last_update_time = 0

local function AccumulateFps()
    local ft = globals_absoluteframetime()
    if ft > 0 then
        table_insert(frametimes, 1, ft)
    end
    local count = #frametimes
    if count == 0 then
        return 0
    end
    local i, accum = 0, 0
    while accum < 0.5 do
        i = i + 1
        accum = accum + frametimes[i]
        if i >= count then
            break
        end
    end
    accum = accum / i
    while i < count do
        i = i + 1
        table_remove(frametimes)
    end
    local fps = 1 / accum
    local rt = globals_realtime()
    if math_abs(fps - fps_prev) > 4 or rt - last_update_time > 2 then
        fps_prev = fps
        last_update_time = rt
    else
        fps = fps_prev
    end
    return math_floor(fps + 0.5)
end

ffi.cdef [[
    typedef void*(__thiscall* get_net_channel_info_t)(void*);
    typedef const char*(__thiscall* get_name_t)(void*);
    typedef const char*(__thiscall* get_address_t)(void*);
    typedef float(__thiscall* get_local_time_t)(void*);
    typedef float(__thiscall* get_time_connected_t)(void*);
    typedef float(__thiscall* get_avg_latency_t)(void*, int);
    typedef float(__thiscall* get_avg_loss_t)(void*, int);
    typedef float(__thiscall* get_avg_choke_t)(void*, int);
]]

local interface_ptr = ffi.typeof("void***")
local rawivengineclient =
    client_create_interface("engine.dll", "VEngineClient014") or error("VEngineClient014 wasnt found", 2)
local ivengineclient = ffi.cast(interface_ptr, rawivengineclient) or error("rawivengineclient is nil", 2)
local get_net_channel_info = ffi.cast("get_net_channel_info_t", ivengineclient[0][78]) or error("ivengineclient is nil")
local FLOW_OUTGOING = 0
local FLOW_INCOMING = 1
local MAX_FLOWS = 2
---------------------

---[ Function #6 ]---
local function time_to_ticks(t)
    return math_floor(0.5 + (t / globals_tickinterval()))
end

local hitgroups_names = {
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

local function on_fire(e)
    local logs = ui_get(semirage.advanced_logs) and table_contains(ui_get(semirage.logs_mode[1]), "Shotted")

    if logs and e ~= nil then
        local flags = {
            e.teleported and "T" or "",
            e.interpolated and "I" or "",
            e.extrapolated and "E" or "",
            e.boosted and "B" or "",
            e.high_priority and "H" or ""
        }
        local group = hitgroups_names[e.hitgroup + 1] or "?"

        client_log(
            string_format(
                "Shotted at %s in the %s for %d damage (hitchance = %d%%, bt=%2d, flags=%s)",
                entity_get_player_name(e.target),
                group,
                e.damage,
                math_floor(e.hit_chance + 0.5),
                time_to_ticks(e.backtrack),
                table_concat(flags)
            )
        )
    end
end
client_set_event_callback("aim_fire", on_fire)

local function on_hit(e)
    local logs = ui_get(semirage.advanced_logs) and table_contains(ui_get(semirage.logs_mode[1]), "Hit")

    if logs and e ~= nil then
        local group = hitgroups_names[e.hitgroup + 1] or "?"

        client_log(
            string_format(
                "Hit %s in the %s for %d damage (%d health remaining)",
                entity_get_player_name(e.target),
                group,
                e.damage,
                entity_get_prop(e.target, "m_iHealth")
            )
        )
    end
end
client_set_event_callback("aim_hit", on_hit)

local function on_miss(e)
    local logs = ui_get(semirage.advanced_logs) and table_contains(ui_get(semirage.logs_mode[1]), "Missed")

    if logs and e ~= nil then
        local group = hitgroups_names[e.hitgroup + 1] or "?"
        local reason

        if e.reason == "?" then
            reason = "unknown"
        else
            reason = e.reason
        end

        client_log(string_format("Missed %s in the %s due to %s", entity_get_player_name(e.target), group, reason))
    end
end
client_set_event_callback("aim_miss", on_miss)
---------------------

---[ Function #7 ]---
ffi.cdef [[
    typedef bool(__thiscall* lgts)(float, float, float, float, float, float, short);
]]

local signature = "\x55\x8B\xEC\x83\xEC\x08\x8B\x15\xCC\xCC\xCC\xCC\x0F\x57"
local match = client_find_signature("client.dll", signature) or error("client_find_signature fucked up")
local line_goes_through_smoke = ffi.cast("lgts", match) or error("ffi.cast fucked up")

client_set_event_callback(
    "run_command",
    function()
        local smoke_check = table_contains(ui_get(semirage.improvements_nades[1]), "Smoke")

        if smoke_check then
            client_update_player_list()
            local local_player = entity_get_local_player()
            local local_head = {entity_hitbox_position(local_player, 0)}
            for _, v in pairs(entity_get_players(true)) do
                ui_set(players.lists, v)
                local entity_head = {entity_hitbox_position(v, 0)}
                ui_set(
                    players.whitelist,
                    line_goes_through_smoke(
                        local_head[1],
                        local_head[2],
                        local_head[3],
                        entity_head[1],
                        entity_head[2],
                        entity_head[3],
                        1
                    )
                )
            end
        end
    end
)

client_set_event_callback(
    "player_blind",
    function(e)
        local flash_check = table_contains(ui_get(semirage.improvements_nades[1]), "Flash")

        local player = entity_get_local_player()
        local useridEnt = (client_userid_to_entindex(e.userid))

        if useridEnt == player and flash_check then
            client_delay_call(
                0.1,
                function()
                    local flash_duration = entity_get_prop(player, "m_flFlashDuration")
                    if flash_duration >= 1 then
                        ui_set(rage.ragebot[1], false)
                        client_delay_call(
                            flash_duration - 2,
                            function()
                                ui_set(rage.ragebot[1], true)
                            end
                        )
                    end
                end
            )
        end
    end
)

client_set_event_callback(
    "shutdown",
    function()
        ui_set(players.reset_all, true)
    end
)
---------------------

---------------------
local limit_ref = ui.reference("AA", "Fake lag", "Limit")
local duck_peek_ref = ui.reference("RAGE", "Other", "Duck peek assist")
local normal_limit_ref = ui.new_slider("AA", "Fake lag", "Fake Duck limit", 1, 14, 14)

local MAX_FAKE_DUCK_LIMIT = 14

local function on_setup_command()
    ui.set(limit_ref, ui.get(duck_peek_ref) and ui.get(normal_limit_ref) or MAX_FAKE_DUCK_LIMIT)
end

client.set_event_callback("setup_command", on_setup_command)

--------------------------------------------------------------------------------
-- Caching common functions
--------------------------------------------------------------------------------
local client_set_clan_tag,
    client_set_event_callback,
    client_system_time,
    entity_get_local_player,
    entity_get_player_resource,
    entity_get_prop,
    entity_is_alive,
    globals_curtime,
    math_floor,
    string_format,
    string_rep,
    table_insert,
    table_sort,
    ui_get,
    ui_new_checkbox,
    ui_new_combobox,
    ui_new_slider,
    ui_new_textbox,
    ui_set_callback,
    ui_set_visible,
    pairs =
    client.set_clan_tag,
    client.set_event_callback,
    client.system_time,
    entity.get_local_player,
    entity.get_player_resource,
    entity.get_prop,
    entity.is_alive,
    globals.curtime,
    math.floor,
    string.format,
    string.rep,
    table.insert,
    table.sort,
    ui.get,
    ui.new_checkbox,
    ui.new_combobox,
    ui.new_slider,
    ui.new_textbox,
    ui.set_callback,
    ui.set_visible,
    pairs

--------------------------------------------------------------------------------
-- Utility functions
--------------------------------------------------------------------------------
local function collect_keys(tbl, custom)
    local keys = {}
    for k in pairs(tbl) do
        keys[#keys + 1] = k
    end
    table_sort(keys)
    if custom then
        table_insert(keys, 1, "Disabled")
        table_insert(keys, "Custom")
    end
    return keys
end

--------------------------------------------------------------------------------
-- Trashtalk
-------------------------------------------------------------------------------
local baimtable = {
    "Baim'd by Harry, yikers.",
    "I baked you a pie, oh boy what flavor AVADA KEDAVRA",
    "INCENDIO! LIGHT IT UP",
    "I broke your wand lol",
    "Harry legit never loses",
    "Hermione hit legit owned you.",
    "Well, you were a death eater.",
    "RIDDIKULUS! Oh wait, nothing changed.",
    "Sorcering stones do not work on me.",
    "I mean, Hagrid approves.",
    "ALOHAMORA, Azkaban awaits.",
    "ACCIO, oh wait do I really need a muggle weapon?",
    "Cry to Dumbledore. ",
    "LIGHT APPEARS FROM THE END OF YOUR CHEST, LUMOS",
    "1 on my screen",
    "Get Good. Get Gamesense or you know, become a mudblood.",
    '˜" ° • .˜ "° • 1 • °" ˜. • ° "˜',
    "Hermione is hittin",
    "Sectumsperma, damn right owned.",
    "EXPECTO PATRONUM NIGGER",
    "WINGARDIUM LEVIOSA NOW U DEAD",
    "Sit dog lmaooooo owned!!!",
    "I fucked you through the wall",
    "ESC -> Help and Options -> How to Play",
    "Go take a bath and give me a blowjob",
    "You're a bitch from the village looking for ravens with a bag",
    "I'm a famous shepherd, give you my dick to graze",
    "FUCKIN WHITE NIGGER GET 1 LMAOOOO",
    "LGBT SUPPORTER GOT OWNED LMAOO",
    "KYS LGBT NIGGER",
    "senza.lua best semi lua",
    "senza.lua owned u"
}
local hstable = baimtable

local function get_table_length(data)
    if type(data) ~= "table" then
        return 0
    end
    local count = 0
    for _ in pairs(data) do
        count = count + 1
    end
    return count
end

local num_quotes_baim = get_table_length(baimtable)
local num_quotes_hs = get_table_length(hstable)
local num_quotes_death = get_table_length(deathtable)

local function on_player_death(e)
    if not ui_get(semirage.trashtalk) then
        return
    end
    local victim_userid, attacker_userid = e.userid, e.attacker
    if victim_userid == nil or attacker_userid == nil then
        return
    end

    local victim_entindex = userid_to_entindex(victim_userid)
    local attacker_entindex = userid_to_entindex(attacker_userid)
    if attacker_entindex == get_local_player() and is_enemy(victim_entindex) then
        if e.headshot then
            local commandhs = "say " .. hstable[math.random(num_quotes_hs)]
            console_cmd(commandhs)
        else
            local commandbaim = "say " .. baimtable[math.random(num_quotes_baim)]
            console_cmd(commandbaim)
        end
    end
    if victim_entindex == get_local_player() and attacker_entindex ~= get_local_player() then
    elseif victim_entindex == get_local_player() and attacker_entindex == get_local_player() then
    end
end

client.set_event_callback("player_death", on_player_death)

--------------------------------------------------------------------------------
-- Game event handling
--------------------------------------------------------------------------------

client_set_event_callback(
    "shutdown",
    function()
        client_color_log(255, 0, 255, "senza.lua")
        client_color_log(255, 255, 255, "FUCK YOU " .. name .. "!")
        client_color_log(255, 0, 255, "best legit-semi lua")
    end
)
