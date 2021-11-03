--[[
	id: 3ospOcLBpnKzEYgCHqjqO
	name: AP05
	description: AP05
	time1: 2021-06-10 15:24:07.605192+00
	time2: 2021-06-10 15:24:07.605193+00
	uploader: 1MZZVPT0tsVlgj051NaNLe7l9doxVJqrAji2UzZr
	uploadersession: ow6ifAGCQJKn1m1rOvhPpKVpwEu_jr
	flag: f
--]]

local weapons_names = {
    "Global", "USP-S", --[[ "P2000",  ]] "Glock-18", "Dual Berettas", --[[ "P250", ]] --[[ "CZ75-Auto", ]] "Tec-9", "Five-SeveN", "R8 Revolver", "Desert Eagle",
    "MP9", "MAC-10", --[[ "MP7", ]] --[[ "MP5-SD", ]] --[[ "UMP-45", ]] --[[ "P90", "PP-Bizom", ]] --[[ "Galil AR", "FAMAS", ]] "M4A1-S", "M4A4", "AK-47", "SSG 08", --[[ "SG 553", "AUG", ]]
    "AWP", "SCAR-20", "G3SG1", --[[ "Nova", ]] --[[ "XM1014", ]] --[[ "Sawed-Off", ]] "MAG-7", "M249", --[[ "Negev", ]]}
local WeaponsName_To_Num = {
    ["Global"] = 1,
    ["USP-S"] = 2,
    ["Glock-18"] = 3,
    ["Dual Berettas"] = 4,
    ["Tec-9"] = 5,
    ["Five-SeveN"] = 6,
    ["R8 Revolver"] = 7,
    ["Desert Eagle"] = 8,
    ["MP9"] = 9,
    ["MAC-10"] = 10,
    ["M4A1-S"] = 11,
    ["M4A4"] = 12,
    ["AK-47"] = 13,
    ["SSG 08"] = 14,
    ["AWP"] = 15,
    ["SCAR-20"] = 16,
    ["G3SG1"] = 17,
    ["MAG-7"] = 18,
    ["M249"] = 19,
--[[ ["P2000"] = 3, ]]
--[[     ["Negev"] = 35, ]]
--[[     ["Nova"] = 30, ]]
--[[     ["XM1014"] = 31, ]]
--[[     ["Sawed-Off"] = 32, ]]
--[[     ["SG 553"] = 25, ]]
--[[     ["AUG"] = 26, ]]
--[[     ["MP7"] = 14, ]]
--[[     ["MP5-SD"] = 15, ]]
--[[     ["UMP-45"] = 16, ]]
--[[     ["P90"] = 17, ]]
--[[     ["PP-Bizom"] = 18, ]]
--[[     ["Galil AR"] = 19, ]]
--[[     ["FAMAS"] = 20, ]]
--[[     ["P250"] = 6, ]]
--[[     ["CZ75-Auto"] = 7, ]]
}
local Exceptions = {
    "CKnife",
    "CSmokeGrenade",
    "CFlashbang",
    "CHEGrenade",
    "CDecoyGrenade",
    "CIncendiaryGrenade",
    "CMolotovGrenade",
    "CC4"
}
local Weapon_idx = {
        --[[ CT ]]
        [61] = "USP-S",
        --[[         [32] = "P2000", ]]
        --[[         [63] = "CZ75-Auto", ]]
        [3] = "Five-SeveN",
        [34] = "MP9",
        --[[         [23] = "MP5-SD", ]]
        --[[         [10] = "FAMAS", ]]
        [60] = "M4A1-S",
        [16] = "M4A4",
        --[[         [8] = "AUG", ]]
        [38] = "SCAR-20",
        [27] = "MAG-7",
        --[[ C ]]
        [4] = "Glock-18",
        [2] = "Dual Berettas",
        --[[         [36] = "P250", ]]
        [30] = "Tec-9",
        [64] = "R8 Revolver",
        [1] = "Desert Eagle",
        [17] = "MAC-10",
        --[[         [33] = "MP7", ]]
        --[[         [24] = "UMP-45", ]]
        --[[         [19] = "P90", ]]
        --[[         [26] = "PP-Bizom", ]]
        --[[         [13] = "Galil AR", ]]
        [7] = "AK-47",
        [40] = "SSG 08",
        --[[         [39] = "SG 553", ]]
        [9] = "AWP",
        [11] = "G3SG1",
        --[[         [35] = "Nova", ]]
        --[[         [25] = "XM1014", ]]
        --[[         [29] = "Sawed-Off", ]]
        [14] = "M249",
--[[         [28] = "Negev", ]]
}



local function HSV_RGB(h, s, v, a)
    local r, g, b
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return r * 255, g * 255, b * 255, a * 255
end
local function rgb(speed, r_g_b)
    local r, g, b, a = HSV_RGB(globals.realtime() * speed, 1, 1, 1)
    r = r * r_g_b
    g = g * r_g_b
    b = b * r_g_b
    return r, g, b
end

local function log(s)
    local r, g, b = rgb(1, 1)
    client.color_log(r, g, b, "[AegisWeapons]: " .. s .. "")
end


log("Global -> Five-SeveN To RAGE-Aimbot")
log("R8 Revolver -> M4A4 To RAGE-Other")
log("AK-47 -> M249 To LUA-A")

local function advertising()
    local LocalPlayer = entity.get_local_player()
    log("Welcome To AegisWeapons _VERSION 0.5 BATE")
    log("Welcome To AegisWeapons _VERSION 0.5 BATE")
    log("Welcome To AegisWeapons _VERSION 0.5 BATE")
end

advertising()

local CurvePlayerWeapons = "Global"
local main_menu = {"Rage", "Aimbot"}
local Weapons_miss = 0
local aegis = {}

--[[ miss ]]
local function on_aim_miss(e)
    if e ~= nil then
        Weapons_miss = Weapons_miss + 1
    end
end

client.set_event_callback("aim_miss", on_aim_miss)


local function on_aim_hit(e)
    if e ~= nil then
        Weapons_miss = 0
    end
end
client.set_event_callback("aim_hit", on_aim_hit)

local function DMG_SHOW(dmg_value)
    if dmg_value < 1 then
        return "Auto"
    elseif dmg_value > 100 then
        return "HP + " .. (dmg_value - 100) .. ""
    end
    return dmg_value
end


local function setWeaponsV(i, v)
    ui.set_visible(aegis[i].Enabled, v)
    ui.set_visible(aegis[i].Target_selection, v)
    ui.set_visible(aegis[i].Ttarget_hitbox, v)
    ui.set_visible(aegis[i].Multi_point, v)
    --[[ ui.set_visible(aegis[i].Multi_point_mode, v) ]]
    ui.set_visible(aegis[i].Multi_point_scale, v)
    ui.set_visible(aegis[i].Prefer_safe_point, v)
    ui.set_visible(aegis[i].Avoid_unsafe_hitboxes, v)
    ui.set_visible(aegis[i].Automatic_fire, v)
    ui.set_visible(aegis[i].Automatic_penetration, v)
    ui.set_visible(aegis[i].Silent_aim, v)
    ui.set_visible(aegis[i].Minimum_hit_chance, v)
    ui.set_visible(aegis[i].Minimum_damage, v)
    ui.set_visible(aegis[i].Automatic_scope, v)
    ui.set_visible(aegis[i].Reduce_aim_step, v)
    ui.set_visible(aegis[i].Log_misses_due_to_spread, v)
    ui.set_visible(aegis[i].Low_FPS_mitigations, v)
    ui.set_visible(aegis[i].Remove_recoil, v)
    ui.set_visible(aegis[i].Accuracy_boost, v)
    ui.set_visible(aegis[i].Delay_shot, v)
    ui.set_visible(aegis[i].Quick_stop, v)
    ui.set_visible(aegis[i].Quick_stop_options, v)
    
    ui.set_visible(aegis[i].Target_selection_X1, v)
    ui.set_visible(aegis[i].Ttarget_hitbox_X1, v)
    ui.set_visible(aegis[i].Multi_point_X1, v)
    --[[ ui.set_visible(aegis[i].Multi_point_mode_X1, v) ]]
    ui.set_visible(aegis[i].Multi_point_scale_X1, v)
    ui.set_visible(aegis[i].Prefer_safe_point_X1, v)
    ui.set_visible(aegis[i].Avoid_unsafe_hitboxes_X1, v)
    ui.set_visible(aegis[i].Automatic_fire_X1, v)
    ui.set_visible(aegis[i].Automatic_penetration_X1, v)
    ui.set_visible(aegis[i].Silent_aim_X1, v)
    ui.set_visible(aegis[i].Minimum_hit_chance_X1, v)
    ui.set_visible(aegis[i].Minimum_damage_X1, v)
    ui.set_visible(aegis[i].Automatic_scope_X1, v)
    ui.set_visible(aegis[i].Reduce_aim_step_X1, v)
    ui.set_visible(aegis[i].Log_misses_due_to_spread_X1, v)
    ui.set_visible(aegis[i].Low_FPS_mitigations_X1, v)
    ui.set_visible(aegis[i].Remove_recoil_X1, v)
    ui.set_visible(aegis[i].Accuracy_boost_X1, v)
    ui.set_visible(aegis[i].Delay_shot_X1, v)
    ui.set_visible(aegis[i].Quick_stop_X1, v)
    ui.set_visible(aegis[i].Quick_stop_options_X1, v)
    
    ui.set_visible(aegis[i].Target_selection_X2, v)
    ui.set_visible(aegis[i].Ttarget_hitbox_X2, v)
    ui.set_visible(aegis[i].Multi_point_X2, v)
    --[[ ui.set_visible(aegis[i].Multi_point_mode_X2, v) ]]
    ui.set_visible(aegis[i].Multi_point_scale_X2, v)
    ui.set_visible(aegis[i].Prefer_safe_point_X2, v)
    ui.set_visible(aegis[i].Avoid_unsafe_hitboxes_X2, v)
    ui.set_visible(aegis[i].Automatic_fire_X2, v)
    ui.set_visible(aegis[i].Automatic_penetration_X2, v)
    ui.set_visible(aegis[i].Silent_aim_X2, v)
    ui.set_visible(aegis[i].Minimum_hit_chance_X2, v)
    ui.set_visible(aegis[i].Minimum_damage_X2, v)
    ui.set_visible(aegis[i].Automatic_scope_X2, v)
    ui.set_visible(aegis[i].Reduce_aim_step_X2, v)
    ui.set_visible(aegis[i].Log_misses_due_to_spread_X2, v)
    ui.set_visible(aegis[i].Low_FPS_mitigations_X2, v)
    ui.set_visible(aegis[i].Remove_recoil_X2, v)
    ui.set_visible(aegis[i].Accuracy_boost_X2, v)
    ui.set_visible(aegis[i].Delay_shot_X2, v)
    ui.set_visible(aegis[i].Quick_stop_X2, v)
    ui.set_visible(aegis[i].Quick_stop_options_X2, v)
    
    ui.set_visible(aegis[i].Target_selection_X3, v)
    ui.set_visible(aegis[i].Ttarget_hitbox_X3, v)
    ui.set_visible(aegis[i].Multi_point_X3, v)
    --[[ ui.set_visible(aegis[i].Multi_point_mode_X3, v) ]]
    ui.set_visible(aegis[i].Multi_point_scale_X3, v)
    ui.set_visible(aegis[i].Prefer_safe_point_X3, v)
    ui.set_visible(aegis[i].Avoid_unsafe_hitboxes_X3, v)
    ui.set_visible(aegis[i].Automatic_fire_X3, v)
    ui.set_visible(aegis[i].Automatic_penetration_X3, v)
    ui.set_visible(aegis[i].Silent_aim_X3, v)
    ui.set_visible(aegis[i].Minimum_hit_chance_X3, v)
    ui.set_visible(aegis[i].Minimum_damage_X3, v)
    ui.set_visible(aegis[i].Automatic_scope_X3, v)
    ui.set_visible(aegis[i].Reduce_aim_step_X3, v)
    ui.set_visible(aegis[i].Log_misses_due_to_spread_X3, v)
    ui.set_visible(aegis[i].Low_FPS_mitigations_X3, v)
    ui.set_visible(aegis[i].Remove_recoil_X3, v)
    ui.set_visible(aegis[i].Accuracy_boost_X3, v)
    ui.set_visible(aegis[i].Delay_shot_X3, v)
    ui.set_visible(aegis[i].Quick_stop_X3, v)
    ui.set_visible(aegis[i].Quick_stop_options_X3, v)
    
    ui.set_visible(aegis[i].Target_selection_Air, v)
    ui.set_visible(aegis[i].Ttarget_hitbox_Air, v)
    ui.set_visible(aegis[i].Multi_point_Air, v)
    --[[ ui.set_visible(aegis[i].Multi_point_mode_Air, v) ]]
    ui.set_visible(aegis[i].Multi_point_scale_Air, v)
    ui.set_visible(aegis[i].Prefer_safe_point_Air, v)
    ui.set_visible(aegis[i].Avoid_unsafe_hitboxes_Air, v)
    ui.set_visible(aegis[i].Automatic_fire_Air, v)
    ui.set_visible(aegis[i].Automatic_penetration_Air, v)
    ui.set_visible(aegis[i].Silent_aim_Air, v)
    ui.set_visible(aegis[i].Minimum_hit_chance_Air, v)
    ui.set_visible(aegis[i].Minimum_damage_Air, v)
    ui.set_visible(aegis[i].Automatic_scope_Air, v)
    ui.set_visible(aegis[i].Reduce_aim_step_Air, v)
    ui.set_visible(aegis[i].Log_misses_due_to_spread_Air, v)
    ui.set_visible(aegis[i].Low_FPS_mitigations_Air, v)
    ui.set_visible(aegis[i].Remove_recoil_Air, v)
    ui.set_visible(aegis[i].Accuracy_boost_Air, v)
    ui.set_visible(aegis[i].Delay_shot_Air, v)
    ui.set_visible(aegis[i].Quick_stop_Air, v)
    ui.set_visible(aegis[i].Quick_stop_options_Air, v)
    
    ui.set_visible(aegis[i].Target_selection_Duck, v)
    ui.set_visible(aegis[i].Ttarget_hitbox_Duck, v)
    ui.set_visible(aegis[i].Multi_point_Duck, v)
    --[[ ui.set_visible(aegis[i].Multi_point_mode_Duck, v) ]]
    ui.set_visible(aegis[i].Multi_point_scale_Duck, v)
    ui.set_visible(aegis[i].Prefer_safe_point_Duck, v)
    ui.set_visible(aegis[i].Avoid_unsafe_hitboxes_Duck, v)
    ui.set_visible(aegis[i].Automatic_fire_Duck, v)
    ui.set_visible(aegis[i].Automatic_penetration_Duck, v)
    ui.set_visible(aegis[i].Silent_aim_Duck, v)
    ui.set_visible(aegis[i].Minimum_hit_chance_Duck, v)
    ui.set_visible(aegis[i].Minimum_damage_Duck, v)
    ui.set_visible(aegis[i].Automatic_scope_Duck, v)
    ui.set_visible(aegis[i].Reduce_aim_step_Duck, v)
    ui.set_visible(aegis[i].Log_misses_due_to_spread_Duck, v)
    ui.set_visible(aegis[i].Low_FPS_mitigations_Duck, v)
    ui.set_visible(aegis[i].Remove_recoil_Duck, v)
    ui.set_visible(aegis[i].Accuracy_boost_Duck, v)
    ui.set_visible(aegis[i].Delay_shot_Duck, v)
    ui.set_visible(aegis[i].Quick_stop_Duck, v)
    ui.set_visible(aegis[i].Quick_stop_options_Duck, v)
    
    ui.set_visible(aegis[i].Target_selection_Peek, v)
    ui.set_visible(aegis[i].Ttarget_hitbox_Peek, v)
    ui.set_visible(aegis[i].Multi_point_Peek, v)
    --[[ ui.set_visible(aegis[i].Multi_point_mode_Peek, v) ]]
    ui.set_visible(aegis[i].Multi_point_scale_Peek, v)
    ui.set_visible(aegis[i].Prefer_safe_point_Peek, v)
    ui.set_visible(aegis[i].Avoid_unsafe_hitboxes_Peek, v)
    ui.set_visible(aegis[i].Automatic_fire_Peek, v)
    ui.set_visible(aegis[i].Automatic_penetration_Peek, v)
    ui.set_visible(aegis[i].Silent_aim_Peek, v)
    ui.set_visible(aegis[i].Minimum_hit_chance_Peek, v)
    ui.set_visible(aegis[i].Minimum_damage_Peek, v)
    ui.set_visible(aegis[i].Automatic_scope_Peek, v)
    ui.set_visible(aegis[i].Reduce_aim_step_Peek, v)
    ui.set_visible(aegis[i].Log_misses_due_to_spread_Peek, v)
    ui.set_visible(aegis[i].Low_FPS_mitigations_Peek, v)
    ui.set_visible(aegis[i].Remove_recoil_Peek, v)
    ui.set_visible(aegis[i].Accuracy_boost_Peek, v)
    ui.set_visible(aegis[i].Delay_shot_Peek, v)
    ui.set_visible(aegis[i].Quick_stop_Peek, v)
    ui.set_visible(aegis[i].Quick_stop_options_Peek, v)

--[[    ui.set_visible(aegis[i].Target_selection_Miss, v)
ui.set_visible(aegis[i].Ttarget_hitbox_Miss, v)
ui.set_visible(aegis[i].Multi_point_Miss, v) ]]
--[[ ui.set_visible(aegis[i].Multi_point_mode_Miss, v) ]]
--[[     ui.set_visible(aegis[i].Multi_point_scale_Miss, v)
ui.set_visible(aegis[i].Prefer_safe_point_Miss, v)
ui.set_visible(aegis[i].Avoid_unsafe_hitboxes_Miss, v)
ui.set_visible(aegis[i].Automatic_fire_Miss, v)
ui.set_visible(aegis[i].Automatic_penetration_Miss, v)
ui.set_visible(aegis[i].Silent_aim_Miss, v)
ui.set_visible(aegis[i].Minimum_hit_chance_Miss, v)
ui.set_visible(aegis[i].Minimum_damage_Miss, v)
ui.set_visible(aegis[i].Automatic_scope_Miss, v)
ui.set_visible(aegis[i].Reduce_aim_step_Miss, v)
ui.set_visible(aegis[i].Log_misses_due_to_spread_Miss, v)
ui.set_visible(aegis[i].Low_FPS_mitigations_Miss, v)
ui.set_visible(aegis[i].Remove_recoil_Miss, v)
ui.set_visible(aegis[i].Accuracy_boost_Miss, v)
ui.set_visible(aegis[i].Delay_shot_Miss, v)
ui.set_visible(aegis[i].Quick_stop_Miss, v)
ui.set_visible(aegis[i].Quick_stop_options_Miss, v) ]]
end




local function isInAir()
    local fv = entity.get_prop(entity.get_local_player(), "m_flFallVelocity")
    if fv < -1 or fv > 1 then
        return true
    end
    return false
end



local Skeet_Checkbox_Base = {
        --[[ AimBot ]]
        Target_selection = {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"},
        Ttarget_hitbox = {"Head", "Chest", "Arms", "Stomach", "Legs", "Feet"},
        Multi_point = {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"},
        Multi_point_mode = {"Low", "Medium", "High"},
        
        Avoid_unsafe_hitboxes = {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"},
        Low_fps_mitigations = {"Force low accuracy boost", "Disable multipoint: feet", "Disable multipoint: arms", "Disable multipoint: legs", "Disable hitbox: feet", "Force low multipoint", "Lower hit chance precision", "Limit targets per tick"},
        --[[ Other ]]
        Accuracy_boost = {"Off", "Low", "Medium", "High", "Maximum"},
        Prefer_body_aim_disablers = {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage"},
        Quick_stop_options = {"Early", "Slow motion", "Duck", "Fake duck", "Move between shots", "Ignore molotov", "Taser"},
}



local Reference = {
        --[[ AimBot ]]
        enabled = ui.reference("RAGE", "Aimbot", "Enabled"),
        enabled_key = ui.reference("RAGE", "Aimbot", "Enabled"),
        target_selection = ui.reference("RAGE", "Aimbot", "Target selection"),
        target_hitbox = ui.reference("RAGE", "Aimbot", "Target hitbox"),
        multipoint = ui.reference("RAGE", "Aimbot", "Multi-point"),
        multipoint_key = ui.reference("RAGE", "Aimbot", "Multi-point"),
        multipoint_mode = ui.reference("RAGE", "Aimbot", "Multi-point"),
        multipoint_scale = ui.reference("RAGE", "Aimbot", "Multi-point scale"),
        prefer_safepoint = ui.reference("RAGE", "Aimbot", "Prefer safe point"),
        avoid_unsafe_hitboxes = ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"),
        force_safepoint = ui.reference("RAGE", "Aimbot", "Force safe point"),
        automatic_fire = ui.reference("RAGE", "Aimbot", "Automatic fire"),
        automatic_penetration = ui.reference("RAGE", "Aimbot", "Automatic penetration"),
        silent_aim = ui.reference("RAGE", "Aimbot", "Silent aim"),
        hitchance = ui.reference("RAGE", "Aimbot", "Minimum hit chance"),
        mindamage = ui.reference("RAGE", "Aimbot", "Minimum damage"),
        automatic_scope = ui.reference("RAGE", "Aimbot", "Automatic scope"),
        reduce_aimstep = ui.reference("RAGE", "Aimbot", "Reduce aim step"),
        log_spread = ui.reference("RAGE", "Aimbot", "Log misses due to spread"),
        low_fps_mitigations = ui.reference("RAGE", "Aimbot", "Low FPS mitigations"),
        --[[ Other ]]
        remove_recoil = ui.reference("RAGE", "Other", "Remove recoil"),
        accuracy_boost = ui.reference("RAGE", "Other", "Accuracy boost"),
        delay_shot = ui.reference("RAGE", "Other", "Delay shot"),
        quickstop = ui.reference("RAGE", "Other", "Quick stop"),
        quickstop_key = ui.reference("RAGE", "Other", "Quick stop"),
        quick_peek_assist_end = ui.reference("RAGE", "Other", "Quick peek assist"),
        quickstop_options = ui.reference("RAGE", "Other", "Quick stop options"),
        antiaim_correction = ui.reference("RAGE", "Other", "Anti-aim correction"),
        antiaim_correction_override = ui.reference("RAGE", "Other", "Anti-aim correction override"),
        prefer_bodyaim = ui.reference("RAGE", "Other", "Prefer body aim"),
        prefer_bodyaim_disablers = ui.reference("RAGE", "Other", "Prefer body aim disablers"),
        force_baim_peek = ui.reference("RAGE", "Other", "Force body aim on peek"),
        force_body_aim = ui.reference("RAGE", "Other", "Force body aim"),
        duck_peek_assist = ui.reference("RAGE", "Other", "Duck peek assist"),
}

ui.set_visible(Reference.avoid_unsafe_hitboxes, false)
ui.set_visible(Reference.target_selection, false)
ui.set_visible(Reference.target_hitbox, false)
ui.set_visible(Reference.multipoint_scale, false)
ui.set_visible(Reference.prefer_safepoint, false)
ui.set_visible(Reference.automatic_fire, false)
ui.set_visible(Reference.automatic_penetration, false)
ui.set_visible(Reference.silent_aim, false)
ui.set_visible(Reference.hitchance, false)
ui.set_visible(Reference.mindamage, false)
ui.set_visible(Reference.automatic_scope, false)
ui.set_visible(Reference.reduce_aimstep, false)
ui.set_visible(Reference.log_spread, false)
ui.set_visible(Reference.low_fps_mitigations, false)

local Aegis_Weapons_Enabled = ui.new_checkbox(main_menu[1], main_menu[2], "Enable Aegis Weapons")

ui.set(Aegis_Weapons_Enabled, true)

local Aegis_Weapons_Indicator_Enabled = ui.new_checkbox(main_menu[1], main_menu[2], "Enable Aegis Weapons Indicator")




local Aegis_Weapons_GroupList = ui.new_combobox(main_menu[1], main_menu[2], "Weapons_Groups", weapons_names)
local Aegis_Weapons_Override = ui.new_hotkey(main_menu[1], main_menu[2], "Override")
local Aegis_Weapons_Override_X2 = ui.new_hotkey(main_menu[1], main_menu[2], "Override X2")
local Aegis_Weapons_Override_X3 = ui.new_hotkey(main_menu[1], main_menu[2], "Override X3")
local Aegis_Weapons_Override_Air = ui.new_checkbox(main_menu[1], main_menu[2], "Override Air")
local Aegis_Weapons_Override_Duck = ui.new_checkbox(main_menu[1], main_menu[2], "Override Duck")
local Aegis_Weapons_Override_Peek = ui.new_checkbox(main_menu[1], main_menu[2], "Override Peek")
local Aegis_Weapons_Override_Peek_key = ui.new_hotkey(main_menu[1], main_menu[2], "Override Peek key", true)

--[[ local Aegis_Weapons_Override_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "Override MissX2") ]]
local Aegis_Weapons_Dyn_Override_Enabled = ui.new_checkbox(main_menu[1], main_menu[2], "Dyn Override (Maintenance)")

local function initUI()
    for i = 1, #weapons_names do
        local v1, v2 = main_menu[1], main_menu[2]
        if i > 6 then
            v1 = "RAGE"
            v2 = "Other"
            if i > 12 then
                v1 = "LUA"
                v2 = "A"
            end
        end
        
        aegis[i] = {
            Enabled = ui.new_checkbox(v1, v2, "Enable " .. weapons_names[i] .. " cfg"),
            Target_selection = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (def) Target selection", Skeet_Checkbox_Base.Target_selection),
            Ttarget_hitbox = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (def) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
            Multi_point = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (def) Multi point", Skeet_Checkbox_Base.Multi_point),
            --[[ Multi_point_mode = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (def) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
            Multi_point_scale = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (def) Multi point scale", 25, 100),
            Prefer_safe_point = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Prefer safe point"),
            Avoid_unsafe_hitboxes = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (def) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
            Automatic_fire = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Automatic fire"),
            Automatic_penetration = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Automatic penetration"),
            Silent_aim = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Silent aim"),
            Minimum_hit_chance = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (def) Minimum hit chance", 0, 100),
            Minimum_damage = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (def) Minimum damage", 0, 126),
            Automatic_scope = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Automatic scope"),
            Reduce_aim_step = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Reduce aim step"),
            Log_misses_due_to_spread = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Log misses due to spread"),
            Low_FPS_mitigations = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (def) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
            Remove_recoil = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Remove recoil"),
            Accuracy_boost = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (def) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
            Delay_shot = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Delay shot"),
            Quick_stop = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (def) Quick stop"),
            Quick_stop_options = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (def) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options),
            
            
            Target_selection_X1 = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Target selection", Skeet_Checkbox_Base.Target_selection),
            Ttarget_hitbox_X1 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X1) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
            Multi_point_X1 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X1) Multi point", Skeet_Checkbox_Base.Multi_point),
            --[[ Multi_point_mode_X1 = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (X1) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
            Multi_point_scale_X1 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X1) Multi point scale", 25, 100),
            Prefer_safe_point_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Prefer safe point"),
            Avoid_unsafe_hitboxes_X1 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X1) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
            Automatic_fire_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Automatic fire"),
            Automatic_penetration_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Automatic penetration"),
            Silent_aim_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Silent aim"),
            Minimum_hit_chance_X1 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X1) Minimum hit chance", 0, 100),
            Minimum_damage_X1 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X1) Minimum damage", 0, 126),
            Automatic_scope_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Automatic scope"),
            Reduce_aim_step_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Reduce aim step"),
            Log_misses_due_to_spread_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Log misses due to spread"),
            Low_FPS_mitigations_X1 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X1) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
            Remove_recoil_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Remove recoil"),
            Accuracy_boost_X1 = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
            Delay_shot_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Delay shot"),
            Quick_stop_X1 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X1) Quick stop"),
            Quick_stop_options_X1 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X1) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options),
            
            
            Target_selection_X2 = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Target selection", Skeet_Checkbox_Base.Target_selection),
            Ttarget_hitbox_X2 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X2) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
            Multi_point_X2 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X2) Multi point", Skeet_Checkbox_Base.Multi_point),
            --[[ Multi_point_mode_X2 = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (X2) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
            Multi_point_scale_X2 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X2) Multi point scale", 25, 100),
            Prefer_safe_point_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Prefer safe point"),
            Avoid_unsafe_hitboxes_X2 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X2) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
            Automatic_fire_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Automatic fire"),
            Automatic_penetration_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Automatic penetration"),
            Silent_aim_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Silent aim"),
            Minimum_hit_chance_X2 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X2) Minimum hit chance", 0, 100),
            Minimum_damage_X2 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X2) Minimum damage", 0, 126),
            Automatic_scope_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Automatic scope"),
            Reduce_aim_step_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Reduce aim step"),
            Log_misses_due_to_spread_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Log misses due to spread"),
            Low_FPS_mitigations_X2 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X2) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
            Remove_recoil_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Remove recoil"),
            Accuracy_boost_X2 = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
            Delay_shot_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Delay shot"),
            Quick_stop_X2 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X2) Quick stop"),
            Quick_stop_options_X2 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X2) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options),
            
            Target_selection_X3 = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Target selection", Skeet_Checkbox_Base.Target_selection),
            Ttarget_hitbox_X3 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X3) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
            Multi_point_X3 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X3) Multi point", Skeet_Checkbox_Base.Multi_point),
            --[[ Multi_point_mode_X3 = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (X3) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
            Multi_point_scale_X3 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X3) Multi point scale", 25, 100),
            Prefer_safe_point_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Prefer safe point"),
            Avoid_unsafe_hitboxes_X3 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X3) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
            Automatic_fire_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Automatic fire"),
            Automatic_penetration_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Automatic penetration"),
            Silent_aim_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Silent aim"),
            Minimum_hit_chance_X3 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X3) Minimum hit chance", 0, 100),
            Minimum_damage_X3 = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (X3) Minimum damage", 0, 126),
            Automatic_scope_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Automatic scope"),
            Reduce_aim_step_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Reduce aim step"),
            Log_misses_due_to_spread_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Log misses due to spread"),
            Low_FPS_mitigations_X3 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X3) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
            Remove_recoil_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Remove recoil"),
            Accuracy_boost_X3 = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
            Delay_shot_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Delay shot"),
            Quick_stop_X3 = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (X3) Quick stop"),
            Quick_stop_options_X3 = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (X3) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options),
            
            
            Target_selection_Air = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Target selection", Skeet_Checkbox_Base.Target_selection),
            Ttarget_hitbox_Air = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Air) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
            Multi_point_Air = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Air) Multi point", Skeet_Checkbox_Base.Multi_point),
            --[[ Multi_point_mode_Air = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Air) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
            Multi_point_scale_Air = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Air) Multi point scale", 25, 100),
            Prefer_safe_point_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Prefer safe point"),
            Avoid_unsafe_hitboxes_Air = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Air) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
            Automatic_fire_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Automatic fire"),
            Automatic_penetration_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Automatic penetration"),
            Silent_aim_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Silent aim"),
            Minimum_hit_chance_Air = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Air) Minimum hit chance", 0, 100),
            Minimum_damage_Air = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Air) Minimum damage", 0, 126),
            Automatic_scope_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Automatic scope"),
            Reduce_aim_step_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Reduce aim step"),
            Log_misses_due_to_spread_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Log misses due to spread"),
            Low_FPS_mitigations_Air = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Air) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
            Remove_recoil_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Remove recoil"),
            Accuracy_boost_Air = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
            Delay_shot_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Delay shot"),
            Quick_stop_Air = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Air) Quick stop"),
            Quick_stop_options_Air = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Air) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options),
            
            
            Target_selection_Duck = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Target selection", Skeet_Checkbox_Base.Target_selection),
            Ttarget_hitbox_Duck = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
            Multi_point_Duck = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Multi point", Skeet_Checkbox_Base.Multi_point),
            --[[ Multi_point_mode_Duck = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Duck) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
            Multi_point_scale_Duck = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Multi point scale", 25, 100),
            Prefer_safe_point_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Prefer safe point"),
            Avoid_unsafe_hitboxes_Duck = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
            Automatic_fire_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Automatic fire"),
            Automatic_penetration_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Automatic penetration"),
            Silent_aim_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Silent aim"),
            Minimum_hit_chance_Duck = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Minimum hit chance", 0, 100),
            Minimum_damage_Duck = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Minimum damage", 0, 126),
            Automatic_scope_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Automatic scope"),
            Reduce_aim_step_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Reduce aim step"),
            Log_misses_due_to_spread_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Log misses due to spread"),
            Low_FPS_mitigations_Duck = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
            Remove_recoil_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Remove recoil"),
            Accuracy_boost_Duck = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
            Delay_shot_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Delay shot"),
            Quick_stop_Duck = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Quick stop"),
            Quick_stop_options_Duck = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Duck) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options),
            
            
            Target_selection_Peek = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Target selection", Skeet_Checkbox_Base.Target_selection),
            Ttarget_hitbox_Peek = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
            Multi_point_Peek = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Multi point", Skeet_Checkbox_Base.Multi_point),
            --[[ Multi_point_mode_Peek = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Peek) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
            Multi_point_scale_Peek = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Multi point scale", 25, 100),
            Prefer_safe_point_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Prefer safe point"),
            Avoid_unsafe_hitboxes_Peek = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
            Automatic_fire_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Automatic fire"),
            Automatic_penetration_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Automatic penetration"),
            Silent_aim_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Silent aim"),
            Minimum_hit_chance_Peek = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Minimum hit chance", 0, 100),
            Minimum_damage_Peek = ui.new_slider(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Minimum damage", 0, 126),
            Automatic_scope_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Automatic scope"),
            Reduce_aim_step_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Reduce aim step"),
            Log_misses_due_to_spread_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Log misses due to spread"),
            Low_FPS_mitigations_Peek = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
            Remove_recoil_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Remove recoil"),
            Accuracy_boost_Peek = ui.new_combobox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
            Delay_shot_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Delay shot"),
            Quick_stop_Peek = ui.new_checkbox(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Quick stop"),
            Quick_stop_options_Peek = ui.new_multiselect(v1, v2, "[" .. weapons_names[i] .. "] (Peek) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options),
        
        
        --[[             Target_selection_Miss = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Target selection", Skeet_Checkbox_Base.Target_selection),
        Ttarget_hitbox_Miss = ui.new_multiselect(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Ttarget hitbox", Skeet_Checkbox_Base.Ttarget_hitbox),
        Multi_point_Miss = ui.new_multiselect(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Multi point", Skeet_Checkbox_Base.Multi_point), ]]
        --[[ Multi_point_mode_Miss = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Multi point mode", Skeet_Checkbox_Base.Multi_point_mode), ]]
        --[[             Multi_point_scale_Miss = ui.new_slider(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Multi point scale", 25, 100),
        Prefer_safe_point_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Prefer safe point"),
        Avoid_unsafe_hitboxes_Miss = ui.new_multiselect(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Avoid unsafe hitboxes", Skeet_Checkbox_Base.Avoid_unsafe_hitboxes),
        Automatic_fire_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Automatic fire"),
        Automatic_penetration_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Automatic penetration"),
        Silent_aim_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Silent aim"),
        Minimum_hit_chance_Miss = ui.new_slider(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Minimum hit chance", 0, 100),
        Minimum_damage_Miss = ui.new_slider(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Minimum damage", 0, 126),
        Automatic_scope_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Automatic scope"),
        Reduce_aim_step_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Reduce aim step"),
        Log_misses_due_to_spread_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Log misses due to spread"),
        Low_FPS_mitigations_Miss = ui.new_multiselect(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Low FPS mitigations", Skeet_Checkbox_Base.Low_fps_mitigations),
        Remove_recoil_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Remove recoil"),
        Accuracy_boost_Miss = ui.new_combobox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Accuracy boost", Skeet_Checkbox_Base.Accuracy_boost),
        Delay_shot_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Delay shot"),
        Quick_stop_Miss = ui.new_checkbox(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Quick stop"),
        Quick_stop_options_Miss = ui.new_multiselect(main_menu[1], main_menu[2], "[" .. weapons_names[i] .. "] (Miss) Quick stop options", Skeet_Checkbox_Base.Quick_stop_options), ]]
        }
        
        
        setWeaponsV(i, false)
    end
end

initUI();


ui.set_callback(Aegis_Weapons_Enabled, function()
    ui.set_visible(Aegis_Weapons_GroupList, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Override, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Override_X2, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Override_X3, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Override_Air, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Override_Duck, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Override_Peek, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Override_Peek_key, ui.get(Aegis_Weapons_Enabled))
    --[[ ui.set_visible(Aegis_Weapons_Override_Miss, ui.get(Aegis_Weapons_Enabled)) ]]
    ui.set_visible(Aegis_Weapons_Indicator_Enabled, ui.get(Aegis_Weapons_Enabled))
    ui.set_visible(Aegis_Weapons_Dyn_Override_Enabled, ui.get(Aegis_Weapons_Enabled))
    if not ui.get(Aegis_Weapons_Enabled) then
        for i = 1, #aegis do
            setWeaponsV(i, false)
        end
        return
    end
    
    if ui.get(Aegis_Weapons_Enabled) then
        local WeaponGroupName = ui.get(Aegis_Weapons_GroupList)
        for i = 1, #aegis do
            if WeaponsName_To_Num[WeaponGroupName] ~= i then
                setWeaponsV(i, false)
            else
                
                setWeaponsV(i, true)
            end
        end
        ui.set_visible(Reference.avoid_unsafe_hitboxes, false)
        ui.set_visible(Reference.target_selection, false)
        ui.set_visible(Reference.target_hitbox, false)
        ui.set_visible(Reference.multipoint_scale, false)
        ui.set_visible(Reference.prefer_safepoint, false)
        ui.set_visible(Reference.automatic_fire, false)
        ui.set_visible(Reference.automatic_penetration, false)
        ui.set_visible(Reference.silent_aim, false)
        ui.set_visible(Reference.hitchance, false)
        ui.set_visible(Reference.mindamage, false)
        ui.set_visible(Reference.automatic_scope, false)
        ui.set_visible(Reference.reduce_aimstep, false)
        ui.set_visible(Reference.log_spread, false)
        ui.set_visible(Reference.low_fps_mitigations, false)
    else
        ui.set_visible(Reference.avoid_unsafe_hitboxes, true)
        ui.set_visible(Reference.target_selection, true)
        ui.set_visible(Reference.target_hitbox, true)
        ui.set_visible(Reference.multipoint_scale, true)
        ui.set_visible(Reference.prefer_safepoint, true)
        ui.set_visible(Reference.automatic_fire, true)
        ui.set_visible(Reference.automatic_penetration, true)
        ui.set_visible(Reference.silent_aim, true)
        ui.set_visible(Reference.hitchance, true)
        ui.set_visible(Reference.mindamage, true)
        ui.set_visible(Reference.automatic_scope, true)
        ui.set_visible(Reference.reduce_aimstep, true)
        ui.set_visible(Reference.log_spread, true)
        ui.set_visible(Reference.low_fps_mitigations, true)
    end
end)


ui.set_callback(Aegis_Weapons_GroupList, function()
    local WeaponGroupName = ui.get(Aegis_Weapons_GroupList)
    
    for i = 1, #aegis do
        if WeaponsName_To_Num[WeaponGroupName] ~= i then
            setWeaponsV(i, false)
        else
            
            setWeaponsV(i, true)
        end
    end
end)


client.set_event_callback("setup_command", function()
    if not ui.get(Aegis_Weapons_Enabled) or not entity.is_alive(entity.get_local_player()) then
        return
    end
    local LocalPlayer = entity.get_local_player()
    local LocalPlayerWeapons = entity.get_player_weapon(LocalPlayer)
    local LocalPlayerWpnIdx = bit.band(65535, entity.get_prop(LocalPlayerWeapons, "m_iItemDefinitionIndex"))
    if Weapon_idx[LocalPlayerWpnIdx] == nil then
        CurvePlayerWeapons = "Global"
    else
        CurvePlayerWeapons = Weapon_idx[LocalPlayerWpnIdx]
    end
end)

local isOpenMenuRefWeaponGroup = false


client.set_event_callback("paint", function()
    if not ui.get(Aegis_Weapons_Enabled) or not entity.is_alive(entity.get_local_player()) then
        return
    end
    if ui.is_menu_open() and not isOpenMenuRefWeaponGroup then
        
        ui.set(Aegis_Weapons_GroupList, CurvePlayerWeapons)
        isOpenMenuRefWeaponGroup = true
    end
    
    if not ui.is_menu_open() then
        isOpenMenuRefWeaponGroup = false
    end
end
)
client.set_event_callback("paint", function(ctx)
    if not ui.get(Aegis_Weapons_Enabled) or not entity.is_alive(entity.get_local_player()) then
        return
    end
    
    if not ui.get(Aegis_Weapons_Indicator_Enabled) then
        return
    end
    local r, g, b = rgb(1, 1)
    client.draw_indicator(ctx, r, g, b, 255, CurvePlayerWeapons)
    
    
    if ui.get(Aegis_Weapons_Override) then
        client.draw_indicator(ctx, r, g, b, 255, "Override Default")
    end
    
    if ui.get(Aegis_Weapons_Override_X2) then
        client.draw_indicator(ctx, r, g, b, 255, "Override X2")
    end
    
    --[[     if Weapons_miss > 1 and ui.get(Aegis_Weapons_Override_Miss) then
    client.draw_indicator(ctx, r, g, b, 255, "MISS Override ~> " .. Weapons_miss)
    end ]]
    if ui.get(Aegis_Weapons_Override_Peek) and ui.get(Reference.quick_peek_assist_end) then
        if ui.get(Aegis_Weapons_Override_Peek_key) then
            client.draw_indicator(ctx, r, g, b, 255, "Peek Override")
        end
    end
    
    if ui.get(Aegis_Weapons_Override_Duck) and ui.get(Reference.duck_peek_assist) then
        client.draw_indicator(ctx, r, g, b, 255, "Duck Override")
    end
    
    if isInAir() and ui.get(Aegis_Weapons_Override_Air) then
        client.draw_indicator(ctx, r, g, b, 255, "Air Override")
    end
    
    if ui.get(Aegis_Weapons_Override_X3) then
        client.draw_indicator(ctx, r, g, b, 255, "Override X3")
    end
    
    
    client.draw_indicator(ctx, r, g, b, 255, "HC -> " .. ui.get(Reference.hitchance) .. " ")
    client.draw_indicator(ctx, r, g, b, 255, "DMG -> " .. DMG_SHOW(ui.get(Reference.mindamage)) .. " ")
    client.draw_indicator(ctx, r, g, b, 255, "Aegis Weapons")
end
)
local function timeOverride()
    if not ui.get(Aegis_Weapons_Enabled) or not entity.is_alive(entity.get_local_player()) then
        return
    end
    
    local var_Target_selection, var_Ttarget_hitbox, var_Multi_point, --[[ var_Multi_point_mode, ]] var_Multi_point_scale, var_Prefer_safe_point,
        var_Avoid_unsafe_hitboxes, var_Automatic_fire, var_Automatic_penetration, var_Silent_aim, var_Minimum_hit_chance, var_Minimum_damage,
        var_Automatic_scope, var_Reduce_aim_step, var_Log_misses_due_to_spread, var_Low_FPS_mitigations, var_Remove_recoil, var_Accuracy_boost, var_Delay_shot, var_Quick_stop, var_Quick_stop_options
    
    local WeaponsCFG = aegis[WeaponsName_To_Num[CurvePlayerWeapons]]
    if not ui.get(WeaponsCFG.Enabled) then
        WeaponsCFG = aegis[1]
    end
    
    
    var_Target_selection = ui.get(WeaponsCFG.Target_selection)
    var_Ttarget_hitbox = ui.get(WeaponsCFG.Ttarget_hitbox)
    var_Multi_point = ui.get(WeaponsCFG.Multi_point)
    --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode) ]]
    var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale)
    var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point)
    var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes)
    var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire)
    var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration)
    var_Silent_aim = ui.get(WeaponsCFG.Silent_aim)
    var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance)
    var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage)
    var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope)
    var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step)
    var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread)
    var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations)
    var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil)
    var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost)
    var_Delay_shot = ui.get(WeaponsCFG.Delay_shot)
    var_Quick_stop = ui.get(WeaponsCFG.Quick_stop)
    var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options)
    
    if ui.get(Aegis_Weapons_Override) then
        var_Target_selection = ui.get(WeaponsCFG.Target_selection_X1)
        var_Ttarget_hitbox = ui.get(WeaponsCFG.Ttarget_hitbox_X1)
        var_Multi_point = ui.get(WeaponsCFG.Multi_point_X1)
        --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode_X1) ]]
        var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale_X1)
        var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point_X1)
        var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes_X1)
        var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire_X1)
        var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration_X1)
        var_Silent_aim = ui.get(WeaponsCFG.Silent_aim_X1)
        var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance_X1)
        var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage_X1)
        var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope_X1)
        var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step_X1)
        var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread_X1)
        var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations_X1)
        var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil_X1)
        var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost_X1)
        var_Delay_shot = ui.get(WeaponsCFG.Delay_shot_X1)
        var_Quick_stop = ui.get(WeaponsCFG.Quick_stop_X1)
        var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options_X1)
    end
    
    if ui.get(Aegis_Weapons_Override_X2) then
        var_Target_selection = ui.get(WeaponsCFG.Target_selection_X2)
        var_Ttarget_hitbox = ui.get(WeaponsCFG.Ttarget_hitbox_X2)
        var_Multi_point = ui.get(WeaponsCFG.Multi_point_X2)
        --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode_X2) ]]
        var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale_X2)
        var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point_X2)
        var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes_X2)
        var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire_X2)
        var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration_X2)
        var_Silent_aim = ui.get(WeaponsCFG.Silent_aim_X2)
        var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance_X2)
        var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage_X2)
        var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope_X2)
        var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step_X2)
        var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread_X2)
        var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations_X2)
        var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil_X2)
        var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost_X2)
        var_Delay_shot = ui.get(WeaponsCFG.Delay_shot_X2)
        var_Quick_stop = ui.get(WeaponsCFG.Quick_stop_X2)
        var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options_X2)
    end
    
    --[[     if Weapons_miss > 1 and ui.get(Aegis_Weapons_Override_Miss) then
    var_Target_selection = ui.get(WeaponsCFG.Ttarget_selection_Miss)
    var_Ttarget_hitbox = ui.get(WeaponsCFG.Target_hitbox_Miss)
    var_Multi_point = ui.get(WeaponsCFG.Multi_point_Miss) ]]
    --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode_Miss) ]]
    --[[         var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale_Miss)
    var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point_Miss)
    var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes_Miss)
    var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire_Miss)
    var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration_Miss)
    var_Silent_aim = ui.get(WeaponsCFG.Silent_aim_Miss)
    var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance_Miss)
    var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage_Miss)
    var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope_Miss)
    var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step_Miss)
    var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread_Miss)
    var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations_Miss)
    var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil_Miss)
    var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost_Miss)
    var_Delay_shot = ui.get(WeaponsCFG.Delay_shot_Miss)
    var_Quick_stop = ui.get(WeaponsCFG.Quick_stop_Miss)
    var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options_Miss)
    end ]]
    if ui.get(Reference.quick_peek_assist_end) then
        if ui.get(Aegis_Weapons_Override_Peek_key) then
            var_Target_selection = ui.get(WeaponsCFG.Target_selection_Peek)
            var_Ttarget_hitbox = ui.get(WeaponsCFG.Ttarget_hitbox_Peek)
            var_Multi_point = ui.get(WeaponsCFG.Multi_point_Peek)
            --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode_Peek) ]]
            var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale_Peek)
            var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point_Peek)
            var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes_Peek)
            var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire_Peek)
            var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration_Peek)
            var_Silent_aim = ui.get(WeaponsCFG.Silent_aim_Peek)
            var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance_Peek)
            var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage_Peek)
            var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope_Peek)
            var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step_Peek)
            var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread_Peek)
            var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations_Peek)
            var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil_Peek)
            var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost_Peek)
            var_Delay_shot = ui.get(WeaponsCFG.Delay_shot_Peek)
            var_Quick_stop = ui.get(WeaponsCFG.Quick_stop_Peek)
            var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options_Peek)
        end
    end
    
    if ui.get(Aegis_Weapons_Override_Duck) and ui.get(Reference.duck_peek_assist) then
        var_Target_selection = ui.get(WeaponsCFG.Target_selection_Duck)
        var_Ttarget_hitbox = ui.get(WeaponsCFG.Ttarget_hitbox_Duck)
        var_Multi_point = ui.get(WeaponsCFG.Multi_point_Duck)
        --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode_Duck) ]]
        var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale_Duck)
        var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point_Duck)
        var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes_Duck)
        var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire_Duck)
        var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration_Duck)
        var_Silent_aim = ui.get(WeaponsCFG.Silent_aim_Duck)
        var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance_Duck)
        var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage_Duck)
        var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope_Duck)
        var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step_Duck)
        var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread_Duck)
        var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations_Duck)
        var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil_Duck)
        var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost_Duck)
        var_Delay_shot = ui.get(WeaponsCFG.Delay_shot_Duck)
        var_Quick_stop = ui.get(WeaponsCFG.Quick_stop_Duck)
        var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options_Duck)
    end
    
    if isInAir() and ui.get(Aegis_Weapons_Override_Air) then
        var_Target_selection = ui.get(WeaponsCFG.Target_selection_Air)
        var_Ttarget_hitbox = ui.get(WeaponsCFG.Ttarget_hitbox_Air)
        var_Multi_point = ui.get(WeaponsCFG.Multi_point_Air)
        --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode_Air) ]]
        var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale_Air)
        var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point_Air)
        var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes_Air)
        var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire_Air)
        var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration_Air)
        var_Silent_aim = ui.get(WeaponsCFG.Silent_aim_Air)
        var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance_Air)
        var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage_Air)
        var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope_Air)
        var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step_Air)
        var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread_Air)
        var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations_Air)
        var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil_Air)
        var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost_Air)
        var_Delay_shot = ui.get(WeaponsCFG.Delay_shot_Air)
        var_Quick_stop = ui.get(WeaponsCFG.Quick_stop_Air)
        var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options_Air)
    end
    
    if ui.get(Aegis_Weapons_Override_X3) then
        var_Target_selection = ui.get(WeaponsCFG.Target_selection_X3)
        var_Ttarget_hitbox = ui.get(WeaponsCFG.Ttarget_hitbox_X3)
        var_Multi_point = ui.get(WeaponsCFG.Multi_point_X3)
        --[[ var_Multi_point_mode = ui.get(WeaponsCFG.Multi_point_mode_X3) ]]
        var_Multi_point_scale = ui.get(WeaponsCFG.Multi_point_scale_X3)
        var_Prefer_safe_point = ui.get(WeaponsCFG.Prefer_safe_point_X3)
        var_Avoid_unsafe_hitboxes = ui.get(WeaponsCFG.Avoid_unsafe_hitboxes_X3)
        var_Automatic_fire = ui.get(WeaponsCFG.Automatic_fire_X3)
        var_Automatic_penetration = ui.get(WeaponsCFG.Automatic_penetration_X3)
        var_Silent_aim = ui.get(WeaponsCFG.Silent_aim_X3)
        var_Minimum_hit_chance = ui.get(WeaponsCFG.Minimum_hit_chance_X3)
        var_Minimum_damage = ui.get(WeaponsCFG.Minimum_damage_X3)
        var_Automatic_scope = ui.get(WeaponsCFG.Automatic_scope_X3)
        var_Reduce_aim_step = ui.get(WeaponsCFG.Reduce_aim_step_X3)
        var_Log_misses_due_to_spread = ui.get(WeaponsCFG.Log_misses_due_to_spread_X3)
        var_Low_FPS_mitigations = ui.get(WeaponsCFG.Low_FPS_mitigations_X3)
        var_Remove_recoil = ui.get(WeaponsCFG.Remove_recoil_X3)
        var_Accuracy_boost = ui.get(WeaponsCFG.Accuracy_boost_X3)
        var_Delay_shot = ui.get(WeaponsCFG.Delay_shot_X3)
        var_Quick_stop = ui.get(WeaponsCFG.Quick_stop_X3)
        var_Quick_stop_options = ui.get(WeaponsCFG.Quick_stop_options_X3)
    end
    
    ui.set(Reference.target_selection, var_Target_selection)
    if #var_Ttarget_hitbox > 0 then
        ui.set(Reference.target_hitbox, var_Ttarget_hitbox)
    end
    
    
    ui.set(Reference.multipoint_mode, var_Multi_point)
    --[[ ui.set(Reference.multipoint_key, var_Multi_point_mode) ]]
    ui.set(Reference.multipoint_scale, var_Multi_point_scale)
    
    
    ui.set(Reference.prefer_safepoint, var_Prefer_safe_point)
    ui.set(Reference.avoid_unsafe_hitboxes, var_Avoid_unsafe_hitboxes)
    ui.set(Reference.automatic_fire, var_Automatic_fire)
    ui.set(Reference.automatic_penetration, var_Automatic_penetration)
    ui.set(Reference.silent_aim, var_Silent_aim)
    ui.set(Reference.hitchance, var_Minimum_hit_chance)
    ui.set(Reference.mindamage, var_Minimum_damage)
    ui.set(Reference.automatic_scope, var_Automatic_scope)
    ui.set(Reference.reduce_aimstep, var_Reduce_aim_step)
    ui.set(Reference.log_spread, var_Log_misses_due_to_spread)
    ui.set(Reference.low_fps_mitigations, var_Low_FPS_mitigations)
    ui.set(Reference.remove_recoil, var_Remove_recoil)
    ui.set(Reference.delay_shot, var_Delay_shot)
    ui.set(Reference.accuracy_boost, var_Accuracy_boost)
    
    ui.set(Reference.quickstop, var_Quick_stop)
    ui.set(Reference.quickstop_options, var_Quick_stop_options)

end

client.set_event_callback("setup_command", timeOverride)
