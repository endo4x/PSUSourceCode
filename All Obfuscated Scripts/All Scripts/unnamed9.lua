--[[
	id: tMaF96lRnX0GCqBovMbaS
	name: 1231354
	description: 123523145143
	time1: 2021-06-30 21:39:51.251158+00
	time2: 2021-06-30 21:39:51.251159+00
	uploader: d8EWlDT4PMRavyWovXahxCimsEWFBSD5OUmmJ3P3
	uploadersession: Vi7ZxVHDLrqvkHKzCf-kf38NKihILy
	flag: f
--]]

﻿-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_visible, entity_hitbox_position, math_abs, math_atan, table_remove = client.visible, entity.hitbox_position, math.abs, math.atan, table.remove
local ui_new_label, ui_reference, ui_new_checkbox, ui_new_combobox, ui_new_hotkey, ui_new_multiselect, ui_new_slider, ui_set, ui_get, ui_set_callback, ui_set_visible = ui.new_label, ui.reference, ui.new_checkbox, ui.new_combobox, ui.new_hotkey, ui.new_multiselect, ui.new_slider, ui.set, ui.get, ui.set_callback, ui.set_visible
local client_log, client_color_log, client_set_event_callback = client.log, client.color_log, client.set_event_callback
local entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_get_players, entity_is_alive = entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.get_players, entity.is_alive
local bit_band, bit_bend = bit.band, validate
local client_screen_size, renderer_text = client.screen_size, renderer.text

local config_names = { "Global", "Taser", "Revolver", "Pistol", "Auto", "Scout", "AWP", "Rifle", "SMG", "Shotgun", "Deagle" }
local name_to_num = { ["Global"] = 1, ["Taser"] = 2, ["Revolver"] = 3, ["Pistol"] = 4, ["Auto"] = 5, ["Scout"] = 6, ["AWP"] = 7, ["Rifle"] = 8, ["SMG"] = 9, ["Shotgun"] = 10, ["Deagle"] = 11 }
local weapon_idx = { [1] = 11, [2] = 4,[3] = 4,[4] = 4,[7] = 8,[8] = 8,[9] = 7,[10] = 8,[11] = 5,[13] = 8,[14] = 8,[16] = 8,[17] = 9,[19] = 9,[23] = 9,[24] = 9,[25] = 10,[26] = 9,[27] = 10,[28] = 8,[29] = 10,[30] = 4,[31] = 2,  [32] = 4,[33] = 9,[34] = 9,[35] = 10,[36] = 4,[38] = 5,[39] = 8,[40] = 6,[60] = 8,[61] = 4,[63] = 4,[64] = 3}
local damage_idx  = { [0] = "Auto", [101] = "HP + 1", [102] = "HP + 2", [103] = "HP + 3", [104] = "HP + 4", [105] = "HP + 5", [106] = "HP + 6", [107] = "HP + 7", [108] = "HP + 8", [109] = "HP + 9", [110] = "HP + 10", [111] = "HP + 11", [112] = "HP + 12", [113] = "HP + 13", [114] = "HP + 14", [115] = "HP + 15", [116] = "HP + 16", [117] = "HP + 17", [118] = "HP + 18", [119] = "HP + 19", [120] = "HP + 20", [121] = "HP + 21", [122] = "HP + 22", [123] = "HP + 23", [124] = "HP + 24", [125] = "HP + 25", [126] = "HP + 26" }
local high_pitch, side_ways, min_damage, custom_damage, last_weapon = false, false, "visible", false, 0

local master_switch = ui_new_checkbox("LUA", "A", "Enable adaptive wpn")
local ovr_head = ui_new_hotkey("LUA", "A", "Force head hitbox")
local active_wpn = ui_new_combobox("LUA", "A", "View weapon", config_names)
local global_dt_hc = ui_new_checkbox("LUA", "A", "Global double tap hitchance")
local rage = {}
local active_idx = 1

local multi_point_ove_key = ui.new_hotkey("LUA", "B", "● Multipoint Override Key", false)
local hitchance_ove_key = ui.new_hotkey("LUA", "B", "● Hitchance Override Key", false)
local damage_ove_key = ui.new_hotkey("LUA", "B", "● Damage Override Key", false)
local damage_ove_key2 = ui.new_hotkey("LUA", "B", "● Damage Override Key2", false)
local hitbox_ove_key = ui.new_hotkey("LUA", "B", "● Hitbox Override Key", false)

local damage_labels_select = {[0] = "Auto"}
for i = 1, 126 do
	damage_labels_select[i] = i <= 100 and tostring(i) or "HP+" .. tostring(i - 100)
end

local function multi_select(tab, val)
	for index, value in ipairs(ui.get(tab)) do
		if value == val then
			return true
		end
	end

	return false
end

for i=1, #config_names do
    rage[i] = {
        enabled = ui_new_checkbox("LUA", "A", "Enable " .. config_names[i] .. " config"),
        target_selection = ui_new_combobox("LUA", "A", "[" .. config_names[i] .. "] Target selection", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
        accuracy_boost = ui_new_combobox("LUA", "A", "[" .. config_names[i] .. "] Accuracy boost", {"Off", "Low", "Medium", "High", "Maximum"}),
        multipoint = ui_new_multiselect("LUA", "A", "[" .. config_names[i] .. "] Multi-point", { "Head", "Chest", "Arms", "Stomach", "Legs", "Feet" }), 
        multimode = ui_new_combobox("LUA", "A", "\n[" .. config_names[i] .. "] Multi-point mode", { "Low", "Medium", "High" }),
        dt_mp_enable = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Custom DT multipoint"),
        dt_multipoint = ui_new_multiselect("LUA", "A", "[" .. config_names[i] .. "] DT Multi-point", { "Head", "Chest", "Arms", "Stomach", "Legs", "Feet" }),   
        dt_multimode = ui_new_combobox("LUA", "A", "\n[" .. config_names[i] .. "] DT Multi-point mode", { "Low", "Medium", "High" }),   
        prefer_safe_point = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Prefer safe point"),
        dt_prefer_safe_point = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Prefer safe point on DT"),
        unsafe_hitboxes_multipoint = ui_new_multiselect("LUA", "A", "[" .. config_names[i] .. "] Avoid unsafe hitboxes", { "Head", "Chest", "Arms", "Stomach", "Legs" }),   
        force_safe_point = ui_new_hotkey("LUA", "A", "[" .. config_names[i] .. "] Force safe point"),
        automatic_fire = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Automatic fire"),
        automatic_penetration = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Automatic penetration"),
        automatic_scope = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Automatic scope"),
        silent_aim = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Silent aim"),
        quick_stop = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Quick stop"),
        quick_stop_options = ui_new_multiselect("LUA", "A", "[" .. config_names[i] .. "] Quick stop options", {"Early", "Slow motion", "Duck", "Fake duck", "Move between shots", "Ignore molotov", "Taser"}),
        prefer_baim = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Prefer body aim"),
        prefer_baim_disablers = ui_new_multiselect("LUA", "A", "[" .. config_names[i] .. "] Prefer body aim disablers", {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage", "High pitch", "Sideways"}),
        delay_shot = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Delay shot"),
        force_baim_peek = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Force body aim on peek"),
        doubletap = ui_new_checkbox("LUA", "A", "[" .. config_names[i] .. "] Double tap"),
        doubletap_hc = ui_new_slider("LUA", "A", "[" .. config_names[i] .. "] Double tap hit chance", 0, 100, 0, true, "%", 1),
		--doubletap_hitchance = ui_new_slider("LUA", "A", "[" .. config_names[i] .. "] Double tap rhit chance scale", 0, 100, 0, true, "%", 1),
        doubletap_stop = ui_new_multiselect("LUA", "A", "[" .. config_names[i] .. "] Double tap quick stop", { "Slow motion", "Duck", "Move between shots" }),


	multi_point_override = ui.new_checkbox("LUA", "B", "[" .. config_names[i] .. "] ● Multipoint Override"),
	multi_point_options = ui.new_multiselect("LUA", "B", "[" .. config_names[i] .. "] ● Multi Point Opotion", {"On Key", "FD", "DT"}),
	multi_point_default = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Multi-Point Scale [Def]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),
	multi_point_on_key = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Multi-Point Scale [On Key]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),
	multi_point_on_fd = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Multi-Point Scale [FD]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),
	multi_point_on_dt = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Multi-Point Scale [DT]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),

	hitchance_override = ui.new_checkbox("LUA", "B", "[" .. config_names[i] .. "] ● Hitchance Override"),
	 hitchance_options = ui.new_multiselect("LUA", "B", "[" .. config_names[i] .. "] ● Hitchance Opotion", {"On Key", "FD", "In Air", "No Scope"}),
	hitchance_default = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Hitchance [Def]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
	hitchance_on_key = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Hitchance [On Key]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
	hitchance_on_fd = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Hitchance [FD]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
	 hitchance_on_air = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Hitchance [In Air]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
	hitchance_on_nos = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Hitchance [NoS]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),

	damage_override = ui.new_checkbox("LUA", "B", "[" .. config_names[i] .. "] ● Damage Override"),
	damage_options = ui.new_multiselect("LUA", "B", "[" .. config_names[i] .. "] ● Damage Opotion", {"On Key", "On Key2", "Visible", "In Air", "DT"}),
	damage_default = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Damage [Def]", 0, 126, 20, true, "", 1, damage_labels_select),
	damage_on_key = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Damage [On Key]", 0, 126, 20, true, "", 1, damage_labels_select),
	damage_on_key2 = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Damage [On Key2]", 0, 126, 20, true, "", 1, damage_labels_select),
	damage_on_vis = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Damage [Visible]", 0, 126, 20, true, "", 1, damage_labels_select),
	damage_on_air = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Damage [In Air]", 0, 126, 20, true, "", 1, damage_labels_select),
	damage_on_dt = ui.new_slider("LUA", "B", "[" .. config_names[i] .. "] ● Damage [DT]", 0, 126, 20, true, "", 1, damage_labels_select),

	hitbox_override = ui.new_checkbox("LUA", "B", "[" .. config_names[i] .. "] ● Hitbox Override"),
	 hitbox_options = ui.new_multiselect("LUA", "B", "[" .. config_names[i] .. "] ● Hitbox Opotion", {"On Key", "DT"}),
	hitbox_default = ui.new_multiselect("LUA", "B", "[" .. config_names[i] .. "] ● Hitbox [Def]", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
	hitbox_on_key = ui.new_multiselect("LUA", "B", "[" .. config_names[i] .. "] ● Hitbox [On Key]", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
	hitbox_on_dt = ui.new_multiselect("LUA", "B", "[" .. config_names[i] .. "] ● Hitbox [DT]", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),

    }
end

local state_indicator = ui.new_multiselect("LUA", "B", "● Indicators", {"Text Value", "Text Value[Crosshair]", "Damage Value", "Damage Value[Crosshair]", "Hitchance Value", "Hitchance Value[Crosshair]"})
local indicator_color = ui.new_color_picker("LUA", "B", "\n ● Global Indicators Colors", 255, 255, 255, 255)

local prioritize_awp = ui_new_checkbox("LUA", "A", "Prioritize awpers")

--References
local ref_enabled, ref_enabledkey = ui_reference("RAGE", "Aimbot", "Enabled")
local ref_target_selection = ui_reference("RAGE", "Aimbot", "Target selection")
local ref_target_hitbox = ui_reference("RAGE", "Aimbot", "Target hitbox")
local ref_multipoint, ref_multipointkey, ref_multipoint_mode = ui_reference("RAGE", "Aimbot", "Multi-point")
local ref_multipoint_scale = ui_reference("RAGE", "Aimbot", "Multi-point scale")
local ref_prefer_safepoint = ui_reference("RAGE", "Aimbot", "Prefer safe point")
local ref_avoid_unsafe_hitboxes = ui_reference("RAGE", "Aimbot", "Avoid unsafe hitboxes")
local ref_force_safepoint = ui_reference("RAGE", "Aimbot", "Force safe point")
local ref_automatic_fire = ui_reference("RAGE", "Aimbot", "Automatic fire")
local ref_automatic_penetration = ui_reference("RAGE", "Aimbot", "Automatic penetration")
local ref_silent_aim = ui_reference("RAGE", "Aimbot", "Silent aim")
local ref_hitchance = ui_reference("RAGE", "Aimbot", "Minimum hit chance")
local ref_mindamage = ui_reference("RAGE", "Aimbot", "Minimum damage")
local ref_automatic_scope = ui_reference("RAGE", "Aimbot", "Automatic scope")
local ref_reduce_aimstep = ui_reference("RAGE", "Aimbot", "Reduce aim step")
local ref_log_spread = ui_reference("RAGE", "Aimbot", "Log misses due to spread")
local ref_low_fps_mitigations = ui_reference("RAGE", "Aimbot", "Low FPS mitigations")
local ref_remove_recoil = ui_reference("RAGE", "Other", "Remove recoil")
local ref_accuracy_boost = ui_reference("RAGE", "Other", "Accuracy boost")
local ref_delay_shot = ui_reference("RAGE", "Other", "Delay shot")
local ref_quickstop, ref_quickstopkey = ui_reference("RAGE", "Other", "Quick stop")
local ref_quickstop_options = ui_reference("RAGE", "Other", "Quick stop options")
local ref_antiaim_correction = ui_reference("RAGE", "Other", "Anti-aim correction")
local ref_antiaim_correction_override = ui_reference("RAGE", "Other", "Anti-aim correction override")
local ref_prefer_bodyaim = ui_reference("RAGE", "Other", "Prefer body aim")
local ref_prefer_bodyaim_disablers = ui_reference("RAGE", "Other", "Prefer body aim disablers")
local ref_force_baim_peek = ui_reference("RAGE", "Other", "Force body aim on peek")
local ref_force_bodyaim = ui_reference("RAGE", "Other", "Force body aim")
local ref_duck_peek_assist = ui_reference("RAGE", "Other", "Duck peek assist")
local ref_doubletap, ref_doubletapkey = ui_reference("RAGE", "Other", "Double tap")
local ref_doubletap_hc = ui_reference("RAGE", "Other", "Double tap hit chance")
local ref_doubletap_stop = ui_reference("RAGE", "Other", "Double tap quick stop")
local ref_doubletap_mode = ui_reference("RAGE", "Other", "Double tap mode")

local load_text = "[adaptive] THE LUA HAS SUCCESSFULY LOADED!"
local fail_text = "[adaptive] unauthorized steamid3. ID: "

local function contains(table, val)
    if #table > 0 then
        for i=1, #table do
            if table[i] == val then
                return true
            end
        end
    end
    return false
end

local function pos_in_table(table, val)
    if #table > 0 then
        for i=1, #table do
            if table[i] == val then
                return i
            end
        end
    end
    return 0
end

local function normalize_yaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end
    return yaw
end

local function calc_angle(localplayerxpos, localplayerypos, enemyxpos, enemyypos)
	local ydelta = localplayerypos - enemyypos
	local xdelta = localplayerxpos - enemyxpos
    local relativeyaw = math_atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
    return relativeyaw
end

local function enemy_visible(idx)
    for i=0, 8 do
        local cx, cy, cz = entity_hitbox_position(idx, i)
        if client_visible(cx, cy, cz) then
            return true
        end
    end
    return false
end

local failed = false
local print_once = false
local function valid_user(plocal)

    if not bit_bend then 
        return
    end

    entity.get_local_player = function()
        return 101
    end    
	
	local id = entity.get_steam64(plocal)

	entity.get_local_player = function()
		return entity_get_local_player()
	end
	
	local found = false
	for k, v in pairs(steamids) do
		if plocal ~= nil then
			if v == id then
				if v == id then
					user = k

					found = true

					if not print_once then
						client_color_log(0, 255, 0, load_text)
						print_once = true
					end
				end
			end
		end
	end

	if not found then
		user = 0
	end

	if user == 0 and not failed then
        client_color_log(255, 0, 0, fail_text .. tostring(id))

		failed = true
	end
end

local plist_set, plist_get = plist.set, plist.get

local timer = 20
local function run_adjustments()

    local plocal = entity_get_local_player()

    timer = timer + 1

    if timer >= 20 then
        valid_user(plocal)
        timer = 0
    end

    if not entity_is_alive(plocal) or not ui_get(master_switch) or user == 0 then
        return
    end


    local players = entity_get_players(true)
    if #players == 0 or user == 0 then
        return false
    end

    local lox, loy, loz = entity_get_prop(plocal, "m_vecOrigin")

    local enemies_visible = false

    for i=1, #players do

        local idx = players[i]

        if enemy_visible(idx) then
            enemies_visible = true
        end
        
        local pitch, yaw, roll = entity_get_prop(idx, "m_angEyeAngles")
        local enemy_high_pitch, enemy_side_ways = false, false

        if high_pitch then
            if pitch ~= nil then
                enemy_high_pitch = pitch < 10
            end
        end

        if side_ways then
            local eox, eoy, eoz = entity_get_prop(idx, "m_vecOrigin")
            if eox ~= nil and yaw ~= nil then

                local at_targets = normalize_yaw(calc_angle(lox, loy, eox, eoy) + 180)
                local left_delta = math_abs(normalize_yaw(yaw - (at_targets - 90)))
                local right_delta = math_abs(normalize_yaw(yaw - (at_targets + 90)))
                enemy_side_ways = left_delta < 30 or right_delta < 30
            end
        end

        local enemy_baim = enemy_high_pitch or enemy_side_ways
        plist_set(idx, "Override prefer body aim", enemy_baim and "Off" or "-")

        if ui_get(prioritize_awp) then
            local weapon = entity_get_player_weapon(idx)
            if weapon ~= nil then
                local weapon_id = bit_band(entity_get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)
                plist_set(idx, "High priority", config_names[weapon_idx[weapon_id]] == "AWP")
            end
        end
    end
end


local function handle_menu()
    local enabled = ui_get(master_switch)
    ui_set_visible(active_wpn, enabled)
    ui_set_visible(ovr_head, enabled)
    ui_set_visible(global_dt_hc, enabled)
    ui_set_visible(prioritize_awp, enabled)
    for i=1, #config_names do
        local show = ui_get(active_wpn) == config_names[i] and enabled
	local idx = i
	ui.set_visible(rage[idx].multi_point_override, show)
	ui.set_visible(rage[idx].hitchance_override, show)
	ui.set_visible(rage[idx].damage_override, show)
	ui.set_visible(rage[idx].hitbox_override, show)
	ui.set_visible(rage[idx].multi_point_options, ui.get(rage[idx].multi_point_override) and show)
	ui.set_visible(rage[idx].multi_point_default, ui.get(rage[idx].multi_point_override) and show)
	ui.set_visible(rage[idx].multi_point_on_key, ui.get(rage[idx].multi_point_override) and multi_select(rage[idx].multi_point_options, "On Key") and show)
	ui.set_visible(rage[idx].multi_point_on_fd, ui.get(rage[idx].multi_point_override) and multi_select(rage[idx].multi_point_options, "FD") and show)
	ui.set_visible(rage[idx].multi_point_on_dt, ui.get(rage[idx].multi_point_override) and multi_select(rage[idx].multi_point_options, "DT") and show)
	ui.set_visible(rage[idx].hitchance_options, ui.get(rage[idx].hitchance_override) and show)
	ui.set_visible(rage[idx].hitchance_default, ui.get(rage[idx].hitchance_override) and show)
	ui.set_visible(rage[idx].hitchance_on_key, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "On Key") and show)
	ui.set_visible(rage[idx].hitchance_on_fd, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "FD") and show)
	ui.set_visible(rage[idx].hitchance_on_air, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "In Air") and show)
	ui.set_visible(rage[idx].hitchance_on_nos, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "No Scope") and show)
	ui.set_visible(rage[idx].damage_options, ui.get(rage[idx].damage_override) and show)
	ui.set_visible(rage[idx].damage_default, ui.get(rage[idx].damage_override) and show)
	ui.set_visible(rage[idx].damage_on_key, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "On Key") and show)
	ui.set_visible(rage[idx].damage_on_key2, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "On Key2") and show)
	ui.set_visible(rage[idx].damage_on_vis, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "Visible") and show)
	ui.set_visible(rage[idx].damage_on_air, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "In Air") and show)
	ui.set_visible(rage[idx].damage_on_dt, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "DT") and show)
	ui.set_visible(rage[idx].hitbox_options, ui.get(rage[idx].hitbox_override) and show)
	ui.set_visible(rage[idx].hitbox_default, ui.get(rage[idx].hitbox_override) and show)
	ui.set_visible(rage[idx].hitbox_on_key, ui.get(rage[idx].hitbox_override) and multi_select(rage[idx].hitbox_options, "On Key") and show)
	ui.set_visible(rage[idx].hitbox_on_dt, ui.get(rage[idx].hitbox_override) and multi_select(rage[idx].hitbox_options, "DT") and show)
	ui.set_visible(multi_point_ove_key, ui.get(master_switch))
	ui.set_visible(hitchance_ove_key, ui.get(master_switch))
	ui.set_visible(damage_ove_key, ui.get(master_switch))
	ui.set_visible(damage_ove_key2, ui.get(master_switch))
	ui.set_visible(hitbox_ove_key, ui.get(master_switch))
	ui.set_visible(state_indicator, ui.get(master_switch))
	ui.set_visible(indicator_color, ui.get(master_switch) and #ui.get(state_indicator) ~= 0)

        ui_set_visible(rage[i].enabled, show and i > 1)
        ui_set_visible(rage[i].target_selection, show)
        ui_set_visible(rage[i].multipoint, show)
        ui_set_visible(rage[i].multimode, show and #{ui_get(rage[i].multipoint)} > 0)
		ui_set_visible(rage[i].unsafe_hitboxes_multipoint, show)
        ui_set_visible(rage[i].dt_mp_enable, show)
        ui_set_visible(rage[i].dt_multipoint, show and ui_get(rage[i].dt_mp_enable))
        ui_set_visible(rage[i].dt_multimode, show and ui_get(rage[i].dt_mp_enable) and #{ui_get(rage[i].multipoint)} > 0)
        ui_set_visible(rage[i].prefer_safe_point, show)
        ui_set_visible(rage[i].dt_prefer_safe_point, show)
        ui_set_visible(rage[i].force_safe_point, show)
        ui_set_visible(rage[i].automatic_fire, show)
        ui_set_visible(rage[i].automatic_penetration, show)
        ui_set_visible(rage[i].silent_aim, show)
        ui_set_visible(rage[i].automatic_scope, show)
        ui_set_visible(rage[i].accuracy_boost, show)
        ui_set_visible(rage[i].delay_shot, show)
        ui_set_visible(rage[i].quick_stop, show)
        ui_set_visible(rage[i].quick_stop_options, show and ui_get(rage[i].quick_stop))
        ui_set_visible(rage[i].prefer_baim, show)
        ui_set_visible(rage[i].prefer_baim_disablers, show and ui_get(rage[i].prefer_baim))
        ui_set_visible(rage[i].force_baim_peek, show)
        ui_set_visible(rage[i].doubletap, show)
        ui_set_visible(rage[i].doubletap_hc, show and ui_get(rage[i].doubletap) and not ui_get(global_dt_hc))
        ui_set_visible(rage[i].doubletap_stop, show and ui_get(rage[i].doubletap))
    end
end
handle_menu()

local idx = 1
client.set_event_callback("paint", function()
	if not entity.is_alive(entity.get_local_player()) then
		idx = 1
		return
	end

	local function vector(val)
		return val == nil and 1 or val
	end

	idx = vector(weapon_idx[bit.band(entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex"), 0xFFFF)])
end)


local closest_player = 0
local stored_target = nil
local function vec2_distance(f_x, f_y, t_x, t_y)
	local delta_x, delta_y = f_x - t_x, f_y - t_y
	return math.sqrt(delta_x*delta_x + delta_y*delta_y)
end


local function can_see(ent)
	for i = 0, 18 do
		if client.visible(entity.hitbox_position(ent, i)) then
			return true
		end
	end

	return false
end

local function get_all_player_positions(ctx, screen_width, screen_height, enemies_only)
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
	local fov_limit = 250
	local screen_width, screen_height = client.screen_size()
	local screen_center_x, screen_center_y = screen_width * 0.5, screen_height * 0.5
	if get_all_player_positions(ctx, screen_width, screen_height, true) == nil then
		return false
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
	for i = 1, #enemy_coords do
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

local function visible_enemys(e)
	local local_entindex = entity.get_local_player()
	if entity.get_prop(local_entindex, "m_lifeState") ~= 0 or not entity.is_alive(local_entindex) then	
		return false
	end
	
	local enemy_visible, enemy_entindex = check_fov(ctx)
	if enemy_entindex == nil then
		return false
	end

	if enemy_visible and enemy_entindex ~= nil and stored_target ~= enemy_entindex then
		stored_target = enemy_entindex
	end

	stored_target = enemy_entindex
	return can_see(enemy_entindex)
end


local calculate_multi_point = function(e)
	local i = ui_get(rage[idx].enabled) and idx or 1
	local ref_mpscale = ui.get(rage[i].multi_point_default)
	local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
	local double_check, double_key = ui.reference("RAGE", "Other", "Double tap")
	if ui.get(multi_point_ove_key) and multi_select(rage[i].multi_point_options, "On Key") then
		ref_mpscale = ui.get(rage[i].multi_point_on_key)
	elseif ui.get(fakeduck) and multi_select(rage[i].multi_point_options, "FD") then
		ref_mpscale = ui.get(rage[i].multi_point_on_fd)
	elseif ui.get(double_check) and ui.get(double_key) and multi_select(rage[i].multi_point_options, "DT") then
		ref_mpscale = ui.get(rage[i].multi_point_on_dt)
	else
		ref_mpscale = ui.get(rage[i].multi_point_default)
	end

	return ref_mpscale
end

local calculate_hitchance = function(e)
	local i = ui_get(rage[idx].enabled) and idx or 1
	local hc_state = "Def"
	local ref_hc = ui.get(rage[i].hitchance_default)
	local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
	if ui.get(hitchance_ove_key) and multi_select(rage[i].hitchance_options, "On Key") then
		hc_state = "Key"
		ref_hc = ui.get(rage[i].hitchance_on_key)
	elseif entity.is_alive(entity.get_local_player()) and (entity.get_prop(entity.get_local_player(), "m_fFlags") == 256 or entity.get_prop(entity.get_local_player(), "m_fFlags") == 262) and multi_select(rage[i].hitchance_options, "In Air") then
		hc_state = "Air"
		ref_hc = ui.get(rage[i].hitchance_on_air)
	elseif entity.get_prop(entity.get_local_player(), "m_bIsScoped") == 0 and multi_select(rage[i].hitchance_options, "No Scope") then
		hc_state = "NoS"
		ref_hc = ui.get(rage[i].hitchance_on_nos)
	elseif ui.get(fakeduck) and multi_select(rage[i].hitchance_options, "FD") then
		hc_state = "FD"
		ref_hc = ui.get(rage[i].hitchance_on_fd)
	else
		hc_state = "Def"
		ref_hc = ui.get(rage[i].hitchance_default)
	end

	return {hc_state, ref_hc}
end

local calculate_damage = function(e)
	local dmg_state = "Def"
	
	local i = ui_get(rage[idx].enabled) and idx or 1
	local calc_ref_dmg = ui.get(rage[i].damage_default)
	local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
	local double_check, double_key = ui.reference("RAGE", "Other", "Double tap")

    local players = entity_get_players(true)
    local enemies_visible = false
    for i=1, #players do
        local idx = players[i]
        if enemy_visible(idx) then
            enemies_visible = true
        end
 end

	if ui.get(damage_ove_key2) and multi_select(rage[i].damage_options, "On Key2") then
		dmg_state = "Key2"
		calc_ref_dmg = ui.get(rage[i].damage_on_key2)
	elseif ui.get(damage_ove_key) and multi_select(rage[i].damage_options, "On Key") then
		dmg_state = "Key"
		calc_ref_dmg = ui.get(rage[i].damage_on_key)
	elseif entity.is_alive(entity.get_local_player()) and (entity.get_prop(entity.get_local_player(), "m_fFlags") == 256 or entity.get_prop(entity.get_local_player(), "m_fFlags") == 262) and multi_select(rage[i].damage_options, "In Air") then
		dmg_state = "Air"
		calc_ref_dmg = ui.get(rage[i].damage_on_air)
	elseif ui.get(double_check) and ui.get(double_key) and multi_select(rage[i].damage_options, "DT") then
		dmg_state = "DT"
		calc_ref_dmg = ui.get(rage[i].damage_on_dt)
	elseif enemies_visible and multi_select(rage[i].damage_options, "Visible") then
		dmg_state = "Vis"
		calc_ref_dmg = ui.get(rage[i].damage_on_vis)
		return {"Vis", ui.get(rage[i].damage_on_vis)}
	end

	return {dmg_state, calc_ref_dmg}
end

local calculate_hitbox = function(e)
	local i = ui_get(rage[idx].enabled) and idx or 1
	if #ui.get(rage[i].hitbox_default) <= 0 then
		ui.set(rage[i].hitbox_default, "Head")
	end

	if #ui.get(rage[i].hitbox_on_key) <= 0 then
		ui.set(rage[i].hitbox_on_key, "Head")
	end

	if #ui.get(rage[i].hitbox_on_dt) <= 0 then
		ui.set(rage[i].hitbox_on_dt, "Head")
	end

	local ref_hitbox = ui.get(rage[i].hitbox_default)
	local double_check, double_key = ui.reference("RAGE", "Other", "Double tap")
	if ui.get(hitbox_ove_key) and multi_select(rage[i].hitbox_options, "On Key") then
		ref_hitbox = ui.get(rage[i].hitbox_on_key)
	elseif ui.get(double_check) and ui.get(double_key) and multi_select(rage[i].hitbox_options, "DT") then
		ref_hitbox = ui.get(rage[i].hitbox_on_dt)
	else
		ref_hitbox = ui.get(rage[i].hitbox_default)
	end

	return #ref_hitbox <= 0 and "Head" or ref_hitbox
end

local function set_config(idx)
	if not ui.get(master_switch) then return end
    local i = ui_get(rage[idx].enabled) and idx or 1


    local table_prefer_baim = ui_get(rage[i].prefer_baim_disablers)
    
    high_pitch = contains(table_prefer_baim, "High pitch")

    if high_pitch then
        table_remove(table_prefer_baim, pos_in_table(table_prefer_baim, "High pitch"))
    end

    side_ways = contains(table_prefer_baim, "Sideways")

    if side_ways then
        table_remove(table_prefer_baim, pos_in_table(table_prefer_baim, "Sideways"))
    end


	local hitbox = calculate_hitbox(e)
	local mp_scale = calculate_multi_point(e)
	local ref_hitbox = ui.reference("RAGE", "Aimbot", "Target hitbox")
	local ref_damage = ui.reference("RAGE", "Aimbot", "Minimum damage")
	local ref_multi_scale = ui.reference("RAGE", "Aimbot", "Multi-point scale")
	local ref_hitchance = ui.reference("RAGE", "Aimbot", "Minimum hit chance")
	local damage_state, damage_value = calculate_damage(e)[1], calculate_damage(e)[2]
	local hitchance_state, hitchance_value = calculate_hitchance(e)[1], calculate_hitchance(e)[2]

    local onground = (bit_band(entity_get_prop(entity_get_local_player(), "m_fFlags"), 1) == 1)


    local doubletapping = ui_get(ref_doubletap) and ui_get(ref_doubletapkey)
    local custom_mp = ui_get(rage[i].dt_mp_enable) and doubletapping  
    local custom_psp = ui_get(rage[i].dt_prefer_safe_point) and doubletapping

    local mp_val = custom_mp and ui_get(rage[i].dt_multipoint) or ui_get(rage[i].multipoint)
    local mpm_val = custom_mp and ui_get(rage[i].dt_multimode) or ui_get(rage[i].multimode)


	if ui.get(rage[i].multi_point_override) then
		ui.set(ref_multi_scale, mp_scale)
	end

	if ui.get(rage[i].damage_override) then
		ui.set(ref_damage, damage_value)
	end

	if ui.get(rage[i].hitchance_override) then
		ui.set(ref_hitchance, hitchance_value)
	end

	if ui.get(rage[i].hitbox_override) then
		ui.set(ref_hitbox, ui_get(ovr_head) and "Head" or hitbox)
	end


    ui_set(ref_target_selection, ui_get(rage[i].target_selection))
    ui_set(ref_multipoint, mp_val)
	ui.set(ref_avoid_unsafe_hitboxes, ui_get(rage[i].unsafe_hitboxes_multipoint))
    ui_set(ref_multipoint_mode, mpm_val)
    ui_set(ref_prefer_safepoint, custom_psp and true or ui_get(rage[i].prefer_safe_point))
    ui_set(ref_force_safepoint, ui_get(rage[i].force_safe_point) and "Always on" or "On hotkey")
    ui_set(ref_automatic_fire, ui_get(rage[i].automatic_fire))
    ui_set(ref_automatic_penetration, ui_get(rage[i].automatic_penetration))
    ui_set(ref_silent_aim, ui_get(rage[i].silent_aim))
    ui_set(ref_automatic_scope, ui_get(rage[i].automatic_scope))
    ui_set(ref_accuracy_boost, ui_get(rage[i].accuracy_boost))
    ui_set(ref_delay_shot, ui_get(rage[i].delay_shot))
    ui_set(ref_quickstop, ui_get(rage[i].quick_stop))
    ui_set(ref_quickstop_options, ui_get(rage[i].quick_stop_options))
    ui_set(ref_prefer_bodyaim, ui_get(rage[i].prefer_baim))
    ui_set(ref_prefer_bodyaim_disablers, table_prefer_baim)
    ui_set(ref_force_baim_peek, ui_get(rage[i].force_baim_peek))
    ui_set(ref_doubletap, ui_get(rage[i].doubletap))
    if not ui_get(global_dt_hc) then
        ui_set(ref_doubletap_hc, ui_get(rage[i].doubletap_hc))
    end
    ui_set(ref_doubletap_stop, ui_get(rage[i].doubletap_stop))
    active_idx = i
end


client.set_event_callback("paint", function(e)

	if not ui.get(master_switch) then return end
	local crosshair_index = 0
	local hitbox = calculate_hitbox(e)
	local mp_scale = calculate_multi_point(e)
	local ref_hitbox = ui.reference("RAGE", "Aimbot", "Target hitbox")
	local ref_damage = ui.reference("RAGE", "Aimbot", "Minimum damage")
	local ref_multi_scale = ui.reference("RAGE", "Aimbot", "Multi-point scale")
	local ref_hitchance = ui.reference("RAGE", "Aimbot", "Minimum hit chance")
	local damage_state, damage_value = calculate_damage(e)[1], calculate_damage(e)[2]
	local hitchance_state, hitchance_value = calculate_hitchance(e)[1], calculate_hitchance(e)[2]

	local r, g, b, a = ui.get(indicator_color)
	local screen_x, screen_y = client.screen_size()
	if not entity.is_alive(entity.get_local_player()) then
		return
	end

	if multi_select(state_indicator, "Text Value") then
		client.draw_indicator(c, r, g, b, a, "D: " .. damage_state .. " H: " .. hitchance_state)
	end

	if multi_select(state_indicator, "Text Value[Crosshair]") then
		crosshair_index = crosshair_index + 1
		renderer.text(screen_x / 2, screen_y / 2 + 35, r, g, b, a, "c", 0, damage_state .. " D|H " .. hitchance_state)
	end

	if multi_select(state_indicator, "Damage Value") then
		client.draw_indicator(c, r, g, b, a, "DMG-> " .. (ui.get(ref_damage) <= 100 and ui.get(ref_damage) or ("HP+" .. (ui.get(ref_damage) - 100))))
	end

	if multi_select(state_indicator, "Damage Value[Crosshair]") then
		crosshair_index = crosshair_index + 1
		renderer.text(screen_x / 2, screen_y / 2 + (multi_select(state_indicator, "Text Value[Crosshair]") and 50 or 35), r, g, b, a, "c", 0, "DMG-> " .. (ui.get(ref_damage) <= 100 and ui.get(ref_damage) or ("HP+" .. (ui.get(ref_damage) - 100))))
	end

	if multi_select(state_indicator, "Hitchance Value") then
		client.draw_indicator(c, r, g, b, a, "HTC-> " .. ui.get(ref_hitchance))
	end

	if multi_select(state_indicator, "Hitchance Value[Crosshair]") then
		renderer.text(screen_x / 2, screen_y / 2 + 35 + (crosshair_index * 15), r, g, b, a, "c", 0, "HTC-> " .. ui.get(ref_hitchance))
	end
end)


client_set_event_callback("setup_command", function(c)
    local plocal = entity_get_local_player()
    local weapon = entity_get_player_weapon(plocal)
    local weapon_id = bit_band(entity_get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)

    local wpn_text = config_names[weapon_idx[weapon_id]]

    if wpn_text ~= nil and user ~= 0 then
        if last_weapon ~= weapon_id then
            ui_set(active_wpn, ui_get(rage[weapon_idx[weapon_id]].enabled) and wpn_text or "Global")
            last_weapon = weapon_id
        end
        set_config(weapon_idx[weapon_id])
    else
        if last_weapon ~= weapon_id then
            ui_set(active_wpn, "Global")
            last_weapon = weapon_id
        end
        set_config(1)
    end
end)

client_set_event_callback("paint", run_adjustments)


local function init_callbacks()
    ui_set_callback(master_switch, handle_menu)
    ui_set_callback(active_wpn, handle_menu)

    for i=1, #config_names do
        ui.set_callback(rage[i].multi_point_options, handle_menu)
        ui.set_callback(rage[i].multi_point_override, handle_menu)
        ui.set_callback(rage[i].hitchance_options, handle_menu)
        ui.set_callback(rage[i].hitchance_override, handle_menu)
        ui.set_callback(rage[i].damage_override, handle_menu)
        ui.set_callback(rage[i].damage_options, handle_menu)
        ui.set_callback(rage[i].hitbox_override, handle_menu)
        ui.set_callback(rage[i].hitbox_options, handle_menu)
        ui.set_callback(state_indicator, handle_menu)
        ui_set_callback(rage[i].multipoint, handle_menu)
        ui_set_callback(rage[i].prefer_baim, handle_menu)
        ui_set_callback(rage[i].quick_stop, handle_menu)
        ui_set_callback(rage[i].dt_mp_enable, handle_menu)
        ui_set_callback(rage[i].doubletap, handle_menu)
    end
end

init_callbacks()


-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_eye_position, client_set_event_callback, client_userid_to_entindex, entity_get_classname, entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_is_alive, math_atan2, math_cos, math_deg, math_rad, math_sin, math_sqrt, renderer_line, renderer_triangle, renderer_world_to_screen, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_hotkey, ui_new_multiselect, ui_new_slider, ui_reference, ui_set, ui_set_callback, ui_set_visible = client.eye_position, client.set_event_callback, client.userid_to_entindex, entity.get_classname, entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.is_alive, math.atan2, math.cos, math.deg, math.rad, math.sin, math.sqrt, renderer.line, renderer.triangle, renderer.world_to_screen, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_hotkey, ui.new_multiselect, ui.new_slider, ui.reference, ui.set, ui.set_callback, ui.set_visible
local stored_target = nil 
local quickstop_reference = ui_reference("RAGE", "Other", "Quick stop")

local enabled_reference = ui_new_checkbox("LUA", "B", "Quick peek")
local hotkey_reference = ui_new_hotkey("LUA", "B", "Quick peek hotkey", true)
local triggers_reference = ui_new_multiselect("LUA", "B", "\nQuick peek triggers", {"X shots", "Kill", "Standing still"})
local shots_reference = ui_new_slider("LUA", "B", "\nQuick peek shots", 1, 6, 1)
local draw_reference = ui_new_checkbox("VISUALS", "Other ESP", "Draw quick peek")
local color_reference = ui_new_color_picker("VISUALS", "Other ESP", "Quick peek color", 198, 70, 70, 146)

local single_fire_weapons = {
	"CDeagle",
	"CWeaponSSG08",
	"CWeaponAWP"
}

local function draw_circle_3d(x, y, z, radius, r, g, b, a, accuracy, width, outline, start_degrees, percentage, fill_r, fill_g, fill_b, fill_a)
	local accuracy = accuracy ~= nil and accuracy or 3
	local width = width ~= nil and width or 1
	local outline = outline ~= nil and outline or false
	local start_degrees = start_degrees ~= nil and start_degrees or 0
	local percentage = percentage ~= nil and percentage or 1

	local center_x, center_y
	if fill_a then
		center_x, center_y = renderer_world_to_screen(x, y, z)
	end

	local screen_x_line_old, screen_y_line_old
	for rot=start_degrees, percentage*360, accuracy do
		local rot_temp = math_rad(rot)
		local lineX, lineY, lineZ = radius * math_cos(rot_temp) + x, radius * math_sin(rot_temp) + y, z
		local screen_x_line, screen_y_line = renderer_world_to_screen(lineX, lineY, lineZ)
		if screen_x_line ~=nil and screen_x_line_old ~= nil then
			if fill_a and center_x ~= nil then
				renderer_triangle(screen_x_line, screen_y_line, screen_x_line_old, screen_y_line_old, center_x, center_y, fill_r, fill_g, fill_b, fill_a)
			end
			for i=1, width do
				local i=i-1
				renderer_line(screen_x_line, screen_y_line-i, screen_x_line_old, screen_y_line_old-i, r, g, b, a)
				renderer_line(screen_x_line-1, screen_y_line, screen_x_line_old-i, screen_y_line_old, r, g, b, a)
			end
			if outline then
				local outline_a = a/255*160
				renderer_line(screen_x_line, screen_y_line-width, screen_x_line_old, screen_y_line_old-width, 16, 16, 16, outline_a)
				renderer_line(screen_x_line, screen_y_line+1, screen_x_line_old, screen_y_line_old+1, 16, 16, 16, outline_a)
			end
		end
		screen_x_line_old, screen_y_line_old = screen_x_line, screen_y_line
	end
end

local function distance3d(x1, y1, z1, x2, y2, z2)
	return math_sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
end

local function table_contains(tbl, val)
	for i = 1, #tbl do
		if tbl[i] == val then
			return true
		end
	end
	return false
end

local function vector_angles(x1, y1, z1, x2, y2, z2)
	--https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/mathlib/mathlib_base.cpp#L535-L563
	local origin_x, origin_y, origin_z
	local target_x, target_y, target_z
	if x2 == nil then
		target_x, target_y, target_z = x1, y1, z1
		origin_x, origin_y, origin_z = client_eye_position()
		if origin_x == nil then
			return
		end
	else
		origin_x, origin_y, origin_z = x1, y1, z1
		target_x, target_y, target_z = x2, y2, z2
	end

	local delta_x, delta_y, delta_z = target_x-origin_x, target_y-origin_y, target_z-origin_z

	if delta_x == 0 and delta_y == 0 then
		return (delta_z > 0 and 270 or 90), 0
	else
		local yaw = math_deg(math_atan2(delta_y, delta_x))
		local hyp = math_sqrt(delta_x*delta_x + delta_y*delta_y)
		local pitch = math_deg(math_atan2(-delta_z, hyp))

		return pitch, yaw
	end
end

local hotkey_prev, shots, pos_x, pos_y, pos_z = false, 0
local quickstop_prev, quickstop_allowed, standing

local function update_visiblity()
	local enabled = ui_get(enabled_reference) and ui.get(master_switch)
	ui_set_visible(triggers_reference, enabled)
	ui_set_visible(shots_reference, enabled and table_contains(ui_get(triggers_reference), "X shots"))
	ui_set_visible(enabled_reference, ui.get(master_switch))
	ui_set_visible(hotkey_reference, enabled)
	ui_set_visible(draw_reference, enabled)
	ui_set_visible(color_reference, enabled and ui.get(draw_reference))

	if not enabled then
		hotkey_prev = false
		shots = 0
		pos_x = nil
	end
end


client_set_event_callback("paint_ui", update_visiblity)


local function on_paint()
	if not ui.get(master_switch) or not entity.is_alive(entity.get_local_player()) then return end

	local is_enabled = ui_get(enabled_reference) and ui_get(hotkey_reference) and pos_x ~= nil and entity_is_alive(entity_get_local_player())

	if quickstop_allowed or not is_enabled then
		if quickstop_prev ~= nil then
			ui_set(quickstop_reference, true)
			quickstop_prev = nil
		end
		quickstop_allowed = nil
	end

	if not is_enabled or not ui_get(draw_reference) then
		return
	end

	local wx, wy = renderer_world_to_screen(pos_x, pos_y, pos_z)

	if wx ~= nil then
		local r, g, b, a = ui_get(color_reference)
		draw_circle_3d(pos_x, pos_y, pos_z, 14, r, g, b, a, 3, 2, false, 0, 1, r, g, b, a*0.6)
	end
end
client_set_event_callback("paint", on_paint)

local function on_aim_fire(e)
	shots = shots + 1
end
client_set_event_callback("aim_fire", on_aim_fire)

local function on_player_death(e)
	if table_contains(ui_get(triggers_reference), "Kill") and client_userid_to_entindex(e.attacker) == entity_get_local_player() then
		shots = -1
	end
end
client_set_event_callback("player_death", on_player_death)

local function on_setup_command(cmd)
	if not ui.get(master_switch) or not entity.is_alive(entity.get_local_player()) then return end

	if not ui_get(enabled_reference) then
		return
	end

	local hotkey = ui_get(hotkey_reference)

	if hotkey then
		local local_player = entity_get_local_player()
		if not hotkey_prev then
			pos_x, pos_y, pos_z = entity_get_prop(local_player, "m_vecAbsOrigin")
			shots = 0
		end

		if cmd.in_attack == 1 then
			shots = -1
		end

		local is_single_fire_weapon = table_contains(single_fire_weapons, entity_get_classname(entity_get_player_weapon(local_player)))
		local shots_min = is_single_fire_weapon and 1 or ui_get(shots_reference)
		local triggers = ui_get(triggers_reference)

		if table_contains(triggers, "Standing still") then
			if not standing and distance3d(0, 0, 0, entity_get_prop(local_player, "m_vecVelocity")) < 15 then
				standing = true
			elseif cmd.sidemove ~= 0 or cmd.forwardmove ~= 0 then
				standing = false
			end
		else
			standing = false
		end

		if (table_contains(triggers, "X shots") and (shots >= shots_min or shots == -1)) or standing then
			local x, y, z = entity_get_prop(local_player, "m_vecAbsOrigin")

			if 15 > distance3d(x, y, z, pos_x, pos_y, pos_z) then
				shots = 0
				quickstop_allowed = true
			else
				local pitch, yaw = vector_angles(x, y, z, pos_x, pos_y, pos_z)
				local require_moving = false
				if not require_moving or cmd.forwardmove ~= 0 or cmd.sidemove ~= 0 then
					cmd.in_forward = 1
					cmd.in_back = 0
					cmd.in_moveleft = 0
					cmd.in_moveright = 0
					cmd.in_speed = 0

					cmd.forwardmove = 450
					cmd.sidemove = 0

					cmd.move_yaw = yaw

					if ui_get(quickstop_reference) then
						quickstop_prev = true
						ui_set(quickstop_reference, false)
					end
				end
			end
		else
			quickstop_allowed = true
		end
	else
		shots = 0
		pos_x = nil
	end

	hotkey_prev = hotkey
end
client_set_event_callback("setup_command", on_setup_command)

local hdf_dog = ui.new_checkbox("VISUALS", "Other ESP", "Text indicator for quick peek")

client.set_event_callback("paint", function()
	if not ui.get(master_switch) or not entity.is_alive(entity.get_local_player()) then return end

if ui_get(enabled_reference) then
if ui_get(hdf_dog) then
	if ui_get(hotkey_reference) then
		local r, g, b, a = ui_get(color_reference)
			renderer.indicator(r, g, b, 255, "QUICK")
		else
			return
		end
	else
		return
	end
else
	return
end
end)

local function on_shutdown()
	if quickstop_prev ~= nil then
		ui_set(quickstop_reference, true)
		quickstop_prev = nil
	end
end

client_set_event_callback("shutdown", on_shutdown)
