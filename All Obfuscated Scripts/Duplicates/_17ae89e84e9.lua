--[[
	id: CTbxOsWb-buPx4CgNnKLr
	name: 3
	description: 132
	time1: 2021-06-26 02:35:41.255376+00
	time2: 2021-06-26 02:35:41.255376+00
	uploader: d8EWlDT4PMRavyWovXahxCimsEWFBSD5OUmmJ3P3
	uploadersession: Vi7ZxVHDLrqvkHKzCf-kf38NKihILy
	flag: f
--]]

local config_names = { "Global", "Taser", "Heavy Pistol", "Pistol", "Auto", "Scout", "AWP", "Rifle", "SMG", "Shotgun","Desert Eagle" }
local name_to_num = { ["Global"] = 1, ["Taser"] = 2, ["Heavy Pistol"] = 3, ["Pistol"] = 4, ["Auto"] = 5, ["Scout"] = 6, ["AWP"] = 7, ["Rifle"] = 8, ["SMG"] = 9, ["Shotgun"] = 10,["Desert Eagle"] = 11 }
local weapon_idx = { [1] = 11, [2] = 4,[3] = 4,[4] = 4,[7] = 8,[8] = 8,[9] = 7,[10] = 8,[11] = 5,[13] = 8,[14] = 8,[16] = 8,[17] = 9,[19] = 9,[23] = 9,[24] = 9,[25] = 10,[26] = 9,[27] = 10,[28] = 8,[29] = 10,[30] = 4,[31] = 2,  [32] = 4,[33] = 9,[34] = 9,[35] = 10,[36] = 4,[38] = 5,[39] = 8,[40] = 6,[60] = 8,[61] = 4,[63] = 4,[64] = 3}
local damage_idx  = { [0] = "Auto", [101] = "HP + 1", [102] = "HP + 2", [103] = "HP + 3", [104] = "HP + 4", [105] = "HP + 5", [106] = "HP + 6", [107] = "HP + 7", [108] = "HP + 8", [109] = "HP + 9", [110] = "HP + 10", [111] = "HP + 11", [112] = "HP + 12", [113] = "HP + 13", [114] = "HP + 14", [115] = "HP + 15", [116] = "HP + 16", [117] = "HP + 17", [118] = "HP + 18", [119] = "HP + 19", [120] = "HP + 20", [121] = "HP + 21", [122] = "HP + 22", [123] = "HP + 23", [124] = "HP + 24", [125] = "HP + 25", [126] = "HP + 26" }
local last_weapon =  0
local close_ui = false

local debug_ui          = ui.new_multiselect("Rage","Aimbot","Debug - ui","Aimbot","Other")
local active_wpn        = ui.new_combobox("Rage","Aimbot", "Weapon select", config_names)


local override_hitbox_key = ui.new_hotkey("Rage","Aimbot","Override hitbox")
local override_unsafehitboxes_key = ui.new_hotkey("Rage","Aimbot","Override Unsafe hitboxes")
local override_multi_point_key = ui.new_hotkey("Rage","Aimbot","Override Mulit-Point")
local override_hitchance_key = ui.new_hotkey("Rage","Aimbot","Override hitchance")
local override_dmg_1      = ui.new_hotkey("Rage","Aimbot","Override 1 dmg")
local override_dmg_2 = ui.new_hotkey("Rage","Aimbot","Override 2 dmg")
local override_dmg_3 = ui.new_hotkey("Rage","Aimbot","Override 3 dmg")

local rage = {}
local active_idx = 1

for i=1, #config_names do
    rage[i] = {
        enabled                                                 = ui.new_checkbox("Rage","Aimbot", "Enable " .. config_names[i] .. " config"),
        target_selection                                        = ui.new_combobox("Rage","Aimbot", "[" .. config_names[i] .. "] Target sledction", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
        target_hitbox                                           = ui.new_multiselect("Rage","Aimbot", "[" .. config_names[i] .. "] Target hitbox", { "Head", "Chest", "Stomach", "Arms", "Legs", "Feet" }),
        multipoint                                              = ui.new_multiselect("Rage","Aimbot", "[" .. config_names[i] .. "] Multi-point", { "Head", "Chest", "Stomach", "Arms", "Legs", "Feet" }), 
        multipoint_scale                                        = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Multi-point scale", 24, 100, 60, true, "%", 1, { [24] = "Auto" }),
        prefer_safe_point                                       = ui.new_checkbox("Rage","Aimbot", "[" .. config_names[i] .. "] Prefer safe point"),
        avoid_unsafe_hitbox                                     = ui.new_multiselect("Rage","Aimbot", "[" .. config_names[i] .. "] Avoid unsafe hitboxes", { "Head", "Chest", "Stomach", "Arms", "Legs"}), 
        automatic_scope                                         = ui.new_checkbox("Rage","Aimbot", "[" .. config_names[i] .. "] Automatic scope"),

        hitchance                                               = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Minimum hit chance", 0, 100, 60, true, "%", 1, {"Off"}),
        min_damage                                              = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Default Minimum damage", 0, 126, 20, true, nil, 1, damage_idx),  
        
        extend_aimbot                                           = ui.new_multiselect("Rage", "Aimbot", "[" .. config_names[i] .. "] Extend aimbot", {"Override hitbox","No scope HC","Jump HC","Override HC","Visible dmg","No scope dmg","Jump dmg","Override 1 dmg","Override 2 dmg","Override 3 dmg","Override Mulit-Point","Override Unsafe hitboxes"}),

        ov_hitbox                                               = ui.new_multiselect("Rage", "Aimbot", "[" .. config_names[i] .. "] Override hitbox",{"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
		ov_avoid_unsafe_hitbox                                  = ui.new_multiselect("Rage","Aimbot", "[" .. config_names[i] .. "] Override unsafe hitboxes", { "Head", "Chest", "Stomach", "Arms", "Legs"}), 
        override_multi_point                                    = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Override Multi-point scale", 24, 100, 60, true, "%", 1, { [24] = "Auto" }),
		noscope_hitchance                                       = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] No scope hc", 0, 100, 40, true, "%", 1, {"Off"}),
        jp_hitchance                                            = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Jump hc", 0, 100, 40, true, "%", 1, {"Off"}),
        override_hitchance                                      = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Override hc", 0, 100, 40, true, "%", 1, {"Off"}),
        vs_min_damage                                           = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Visible damage", 0, 126, 1, true, nil, 1, damage_idx),
        noscope_min_damage                                      = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] No scope damage", 0, 126, 1, true, nil, 1, damage_idx),
        jp_min_damage                                           = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Jump damage", 0, 126, 1, true, nil, 1, damage_idx), 
        ov1_min_damage                                          = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Override-1 damage", 0, 126, 1, true, nil, 1, damage_idx), 
        ov2_min_damage                                          = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Override-2 damage", 0, 126, 1, true, nil, 1, damage_idx), 
        ov3_min_damage                                          = ui.new_slider("Rage","Aimbot", "[" .. config_names[i] .. "] Override-3 damage", 0, 126, 1, true, nil, 1, damage_idx), 
        
        accuracy_boost                                          = ui.new_combobox("Rage","Other", "[" .. config_names[i] .. "] Accuracy boost", {"Off", "Low", "Medium", "High", "Maximum"}),
        delay_shot                                              = ui.new_checkbox("Rage","Other", "[" .. config_names[i] .. "] Delay shot"),
        quick_stop                                              = ui.new_checkbox("Rage","Other", "[" .. config_names[i] .. "] Quick stop"),
        quick_stop_options                                      = ui.new_multiselect("Rage","Other", "[" .. config_names[i] .. "] Quick stop options", {"Early", "Slow motion", "Duck", "Fake duck","Move between shots", "Ignore molotov"}),
        noscope_quick_stop                                      = ui.new_checkbox("Rage","Other", "[" .. config_names[i] .. "] No scope quick stop"),
        noscope_quick_stop_options                              = ui.new_multiselect("Rage","Other", "[" .. config_names[i] .. "] No scope quick stop options", {"Early", "Slow motion", "Duck", "Fake duck","Move between shots", "Ignore molotov"}),
        prefer_baim                                             = ui.new_checkbox("Rage","Other", "[" .. config_names[i] .. "] Prefer body aim"),
        prefer_baim_disablers                                   = ui.new_multiselect("Rage","Other", "[" .. config_names[i] .. "] Prefer body aim disablers", {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage"}),
        force_baim_peek                                         = ui.new_checkbox("Rage","Other", "[" .. config_names[i] .. "] Force body aim on peek"),
		dt                                         				= ui.new_checkbox("Rage","Other", "[" .. config_names[i] .. "] Double Tap"),
		doubletap_hitchance                                     = ui.new_slider("Rage","Other", "[" .. config_names[i] .. "] Double tap hit chance", 0, 100, 60, true, "%", 1, {"Off"}),
		doubletap_stop                                          = ui.new_multiselect("Rage","Other", "[" .. config_names[i] .. "] Double tap quick stop", {"Slow motion", "Duck","Move between shots"})
    }
end

local ref_enable, ref_enable_key                                = ui.reference("RAGE", "Aimbot", "Enabled")
local ref_target                                                = ui.reference("RAGE", "Aimbot", "Target selection")
local ref_hitbox                                                = ui.reference("RAGE", "Aimbot", "Target hitbox")
local ref_multipoint, ref_multipointkey, ref_multipoint_mode    = ui.reference("RAGE", "Aimbot", "Multi-point")
local ref_multipoint_scale                                      = ui.reference("RAGE", "Aimbot", "Multi-point scale")
local ref_prefer_safepoint                                      = ui.reference("RAGE", "Aimbot", "Prefer safe point")
local ref_force_safepoint                                       = ui.reference("RAGE", "Aimbot", "Force safe point")
local ref_avoid_hitbox                                          = ui.reference("Rage", "Aimbot","Avoid unsafe hitboxes")
local ref_automatic_fire                                        = ui.reference("RAGE", "Aimbot", "Automatic fire")
local ref_automatic_penetration                                 = ui.reference("RAGE", "Aimbot", "Automatic penetration")
local ref_silent_aim                                            = ui.reference("RAGE", "Aimbot", "Silent aim")
local ref_hitchance                                             = ui.reference("RAGE", "Aimbot", "Minimum hit chance")
local ref_mindamage                                             = ui.reference("RAGE", "Aimbot", "Minimum damage")
local ref_automatic_scope                                       = ui.reference("RAGE", "Aimbot", "Automatic scope")
local ref_reduce_aimstep                                        = ui.reference("RAGE", "Aimbot", "Reduce aim step")
local ref_max_fov                                               = ui.reference("Rage", "Aimbot","Maximum FOV")
local ref_log_spread                                            = ui.reference("RAGE", "Aimbot", "Log misses due to spread")
local ref_low_fps_mitigations                                   = ui.reference("RAGE", "Aimbot", "Low FPS mitigations")

local ref_remove_recoil                                         = ui.reference("RAGE", "Other", "Remove recoil")
local ref_accuracy_boost                                        = ui.reference("RAGE", "Other", "Accuracy boost")
local ref_delay_shot                                            = ui.reference("RAGE", "Other", "Delay shot")
local ref_quickstop, ref_quickstopkey                           = ui.reference("RAGE", "Other", "Quick stop")
local ref_quickstop_options                                     = ui.reference("RAGE", "Other", "Quick stop options")
local ref_quick_peek , ref_quick_peek_key                       = ui.reference("Rage", "Other","Quick peek assist")
local ref_antiaim_correction                                    = ui.reference("RAGE", "Other", "Anti-aim correction")
local ref_antiaim_correction_override                           = ui.reference("RAGE", "Other", "Anti-aim correction override")
local ref_prefer_bodyaim                                        = ui.reference("RAGE", "Other", "Prefer body aim")
local ref_prefer_bodyaim_disablers                              = ui.reference("RAGE", "Other", "Prefer body aim disablers")
local ref_force_baim_peek                                       = ui.reference("RAGE", "Other", "Force body aim on peek")
local ref_force_bodyaim                                         = ui.reference("RAGE", "Other", "Force body aim")

local fd_key                                                    = ui.reference("RAGE", "Other", "Duck peek assist")
local dt, dt_key                                                = ui.reference("RAGE", "Other", "Double tap")
local dt_mode                                                   = ui.reference("RAGE", "Other", "Double tap mode")
local ref_doubletap_hitchance      								= ui.reference("rage","other","Double tap hit chance")
local ref_doubletap_stop      									= ui.reference( "RAGE", "Other", "Double tap quick stop" )

local function contains(table, val)if #table > 0 then for i=1, #table do if table[i] == val then return true end end end return false end
local function avoid_hitbox()
    local avoid_list = {}
    if #ui.get(rage[active_idx].target_hitbox) > 0 then
        for i = 1 , #ui.get(rage[active_idx].target_hitbox) do
            if ui.get(rage[active_idx].target_hitbox)[i] == "Head" or ui.get(rage[active_idx].target_hitbox)[i] == "Chest" or ui.get(rage[active_idx].target_hitbox)[i] == "Stomach" then
                avoid_list[i] = ui.get(rage[active_idx].target_hitbox)[i]
            end
        end
        if #avoid_list == 0 then
            avoid_list[1] = "Head"
        end
    end
    return avoid_list
end
local function get_distance(x1, y1, z1, x2, y2, z2) return math.sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2) end
local function get_closest_player()
    local local_player = entity.get_local_player()
    local lx, ly, lz = entity.get_prop(local_player, "m_vecOrigin")
    local players = entity.get_players(true)
    if #players == 0 then 
        return 0,0,0,0 
    end
    local close_idx
    local closest_distance = math.huge
    for i=1, #players do
        local ent = players[i]
        local x, y, z = entity.get_prop(ent, "m_vecOrigin")
        local distance = get_distance(lx, ly, lz, x, y, z)
        if distance <= closest_distance then
            close_idx = ent
            closest_distance = distance
        end
    end
    local close_name = entity.get_player_name(close_idx)
    local vec_vel = { entity.get_prop(close_idx, 'm_vecVelocity') }
    local close_vel = math.floor(math.sqrt(vec_vel[1]^2 + vec_vel[2]^2) + 0.5)
    local flags = entity.get_prop(close_idx, "m_fFlags")
    local close_jump = bit.band(flags, 1) ~= 1
    return close_idx , close_name , close_vel , close_jump
end
local function refresh_ui()

    for i=1, #config_names do

        local show = ui.get(active_wpn) == config_names[i]

        ui.set_visible(rage[i].enabled, show and i > 1)
        ui.set_visible(rage[i].target_selection, show)
        ui.set_visible(rage[i].target_hitbox, show)
        ui.set_visible(rage[i].multipoint, show)
        ui.set_visible(rage[i].multipoint_scale, show and #{ui.get(rage[i].multipoint)} > 0)
        ui.set_visible(rage[i].prefer_safe_point, show)
        ui.set_visible(rage[i].avoid_unsafe_hitbox, show)
        ui.set_visible(rage[i].hitchance, show)

        ui.set_visible(rage[i].min_damage, show)
--[[         ui.set_visible(rage[i].ov_min_damage, show) ]]
        ui.set_visible(rage[i].automatic_scope, show)

        --         

        ui.set_visible(rage[i].extend_aimbot, show)
        ui.set_visible(rage[i].ov_hitbox, show)
		ui.set_visible(rage[i].ov_avoid_unsafe_hitbox, show)
		--ui.set_visible(rage[i].override_multi_point, show)

        local ex_table = ui.get(rage[i].extend_aimbot)
        --{,,,,,,,,}
        
        ui.set_visible(rage[i].ov_hitbox, show and contains(ex_table,"Override hitbox"))
		ui.set_visible(rage[i].ov_avoid_unsafe_hitbox, show and contains(ex_table,"Override Unsafe hitboxes"))
		ui.set_visible(rage[i].override_multi_point, show and contains(ex_table,"Override Mulit-Point"))
        ui.set_visible(rage[i].noscope_hitchance, show and contains(ex_table,"No scope HC"))
        ui.set_visible(rage[i].jp_hitchance, show and contains(ex_table,"Jump HC"))
        ui.set_visible(rage[i].override_hitchance, show and contains(ex_table,"Override HC"))
        ui.set_visible(rage[i].vs_min_damage, show and contains(ex_table,"Visible dmg"))
        ui.set_visible(rage[i].noscope_min_damage, show and contains(ex_table,"No scope dmg"))
        ui.set_visible(rage[i].jp_min_damage, show and contains(ex_table,"Jump dmg"))
        ui.set_visible(rage[i].ov1_min_damage, show and contains(ex_table,"Override 1 dmg"))
        ui.set_visible(rage[i].ov2_min_damage, show and contains(ex_table,"Override 2 dmg"))
        ui.set_visible(rage[i].ov3_min_damage, show and contains(ex_table,"Override 3 dmg"))

        ui.set_visible(rage[i].accuracy_boost, show)
        ui.set_visible(rage[i].delay_shot, show)
        ui.set_visible(rage[i].quick_stop, show)
        ui.set_visible(rage[i].quick_stop_options, show and ui.get(rage[i].quick_stop))
        ui.set_visible(rage[i].noscope_quick_stop, show)
        ui.set_visible(rage[i].noscope_quick_stop_options, show and ui.get(rage[i].noscope_quick_stop))
        ui.set_visible(rage[i].prefer_baim, show)
        ui.set_visible(rage[i].prefer_baim_disablers, show and ui.get(rage[i].prefer_baim))
        ui.set_visible(rage[i].force_baim_peek, show)
		ui.set_visible(rage[i].dt, show)
		ui.set_visible(rage[i].doubletap_hitchance, show and ui.get(rage[i].dt))
		ui.set_visible(rage[i].doubletap_stop, show and ui.get(rage[i].dt))
		--ui.set_visible(rage[i].ref_doubletap_hitchance, show)
		--ui.set_visible(rage[i].ref_doubletap_stop, show)
    end
    local aimbot_visible = contains(ui.get(debug_ui),"Aimbot") or false
    local other_visible = contains(ui.get(debug_ui),"Other") or false
    if close_ui then other_visible = true;aimbot_visible = true end
--[[     ui.set_visible(ref_enable       ,aimbot_visible)
    ui.set_visible(ref_enable_key  ,aimbot_visible) ]]
    ui.set_visible(ref_target ,aimbot_visible)
    ui.set_visible(ref_hitbox           ,aimbot_visible)
    ui.set_visible(ref_multipoint       ,aimbot_visible)
    ui.set_visible(ref_multipointkey    ,aimbot_visible)
    ui.set_visible(ref_multipoint_mode  ,aimbot_visible)
    ui.set_visible(ref_multipoint_scale ,aimbot_visible)
    ui.set_visible(ref_prefer_safepoint ,aimbot_visible)
    --[[ ui.set_visible(force_safe,aimbot_visible) ]] -- force safepoint key
    ui.set_visible(ref_avoid_hitbox     ,aimbot_visible)
    ui.set_visible(ref_automatic_fire   ,aimbot_visible)
    ui.set_visible(ref_automatic_penetration    ,aimbot_visible)
    ui.set_visible(ref_silent_aim       ,aimbot_visible)
    ui.set_visible(ref_hitchance        ,aimbot_visible)
    ui.set_visible(ref_mindamage        ,aimbot_visible)
    ui.set_visible(ref_automatic_scope  ,aimbot_visible)
    ui.set_visible(ref_reduce_aimstep   ,aimbot_visible)
    ui.set_visible(ref_max_fov          ,aimbot_visible)
    ui.set_visible(ref_log_spread       ,aimbot_visible)
    ui.set_visible(ref_low_fps_mitigations  ,aimbot_visible)
    -- set_visible rage - other
    ui.set_visible(ref_remove_recoil    ,other_visible)
    ui.set_visible(ref_accuracy_boost   ,other_visible)
    ui.set_visible(ref_delay_shot       ,other_visible)
    ui.set_visible(ref_quickstop        ,other_visible)
    ui.set_visible(ref_quickstopkey     ,other_visible)
    ui.set_visible(ref_quickstop_options,other_visible)
--[[     ui.set_visible(ref_quick_peek,other_visible)
    ui.set_visible(ref_quick_peek_key,other_visible)
    ui.set_visible(ref_quick_peek_color,other_visible) ]]
--[[     ui.set_visible(ref_antiaim_correction,other_visible)
    ui.set_visible(ref_antiaim_correction_override,other_visible) -- resolver override key ]]
    ui.set_visible(ref_prefer_bodyaim,other_visible)
    ui.set_visible(ref_prefer_bodyaim_disablers,other_visible)
    ui.set_visible(ref_force_baim_peek,other_visible)
	ui.set_visible(ref_doubletap_stop,other_visible)
    --[[ ui.set_visible(force_baim,other_visible) ]] -- force baim key
    --[[ ui.set_visible(fd_key,other_visible) ]] -- fake duck key
    --[[ ui.set_visible(dt,other_visible) ]] -- dt 
    --[[ ui.set_visible(dt_key,other_visible) ]] -- dt key
--[[     ui.set_visible(dt_mode,other_visible)
    ui.set_visible(dt_hit_chance,other_visible)
    ui.set_visible(dt_speed,other_visible)
    ui.set_visible(dt_stop,other_visible) ]]
end
local function enemy_visible()
    for _, idx in pairs(entity.get_players(true)) do
        for i=0, 18 do
            local cx, cy, cz = entity.hitbox_position(idx, i)
            if client.visible(cx, cy, cz) then
                return true
            end
        end
    end
    return false
end
local function set_config(idx)
    local i = ui.get(rage[idx].enabled) and idx or 1
    
    local rage_hitboxes = ui.get(rage[i].target_hitbox)
    if #rage_hitboxes == 0 then
        ui.set(rage[i].target_hitbox, "Head")
    end
    local me = entity.get_local_player()
    local scoped = entity.get_prop(me, 'm_bIsScoped') == 1
    local close_idx , close_name , close_vel , close_jump = get_closest_player()
    ui.set(ref_target,                  ui.get(rage[i].target_selection))

    local hitbox = {}
    local damage = 0
    local hitchance = 0
	local muilts = 50
    local ex_table = ui.get(rage[i].extend_aimbot)

    local flags = entity.get_prop(entity.get_local_player(), "m_fFlags")
    local jump = bit.band(flags, 1) ~= 1

    local vis_damage = false
    if enemy_visible() then
        vis_damage = true
    end
    if ui.get(override_hitbox_key) and contains(ex_table,"Override hitbox") then
        hitbox = #ui.get(rage[i].ov_hitbox) == 0 and {"Head"} or ui.get(rage[i].ov_hitbox)
    else
        hitbox = ui.get(rage[i].target_hitbox)
    end
	--[[if contains(ex_table,"Override Mulit-Point") and ui.get(override_multi_point_key) then
	    ui.set(ref_multipoint_scale, ui.get(rage[i].override_multi_point))
    end--]]
    if contains(ex_table,"Override HC") and ui.get(override_hitchance_key) then
        hitchance = ui.get(rage[i].override_hitchance)
    elseif contains(ex_table,"Jump HC") and jump then
        hitchance = ui.get(rage[i].jp_hitchance)
    elseif not scoped and contains(ex_table,"No scope HC") then
        hitchance = ui.get(rage[i].noscope_hitchance)
    else
        hitchance = ui.get(rage[i].hitchance)
    end
    if contains(ex_table,"Override 3 dmg") and ui.get(override_dmg_3) then
        damage = ui.get(rage[i].ov3_min_damage)
    elseif contains(ex_table,"Override 2 dmg") and ui.get(override_dmg_2) then
        damage = ui.get(rage[i].ov2_min_damage)
    elseif contains(ex_table,"Override 1 dmg") and ui.get(override_dmg_1) then
        damage = ui.get(rage[i].ov1_min_damage)
    elseif contains(ex_table,"Jump dmg") and jump then
        damage = ui.get(rage[i].jp_min_damage)
    elseif not scoped and contains(ex_table,"No scope dmg") then
        damage = ui.get(rage[i].noscope_min_damage)
    elseif vis_damage and contains(ex_table,"Visible dmg") then
        damage = ui.get(rage[i].vs_min_damage)
    else
        damage = ui.get(rage[i].min_damage)
    end

    ui.set(ref_hitbox,                  hitbox)
    ui.set(ref_multipoint,              ui.get(rage[i].multipoint))
    --ui.set(ref_multipoint_scale,        ui.get(rage[i].multipoint_scale))
    ui.set(ref_multipoint_mode,         "High")
    ui.set(ref_prefer_safepoint,        ui.get(rage[i].prefer_safe_point))
    --ui.set(ref_avoid_hitbox,            ui.get(rage[i].avoid_unsafe_hitbox))
    ui.set(ref_automatic_fire, true)
    ui.set(ref_automatic_penetration, true)
    ui.set(ref_silent_aim, true)
	--ui.set(ref_multipoint_scale, muilts)
	if ui.get(override_multi_point_key) and contains(ex_table,"Override Mulit-Point")  then
        ui.set(ref_multipoint_scale, ui.get(rage[i].override_multi_point))
    else
        ui.set(ref_multipoint_scale,        ui.get(rage[i].multipoint_scale))
    end
	if ui.get(override_unsafehitboxes_key) and contains(ex_table,"Override Unsafe hitboxes")  then
        ui.set(ref_avoid_hitbox, ui.get(rage[i].ov_avoid_unsafe_hitbox))
    else
        ui.set(ref_avoid_hitbox,            ui.get(rage[i].avoid_unsafe_hitbox))
    end
	--client.log(muilts)
    ui.set(ref_hitchance, hitchance)
    ui.set(ref_mindamage, damage)

    ui.set(ref_automatic_scope, ui.get(rage[i].automatic_scope))
    ui.set(ref_accuracy_boost, ui.get(rage[i].accuracy_boost))
    ui.set(ref_delay_shot, ui.get(rage[i].delay_shot))
    ui.set(ref_quickstop, ui.get(rage[i].quick_stop))
    if ui.get(rage[i].noscope_quick_stop) then
        ui.set(ref_quickstop_options, scoped and ui.get(rage[i].quick_stop_options) or ui.get(rage[i].noscope_quick_stop_options))
    else
        ui.set(ref_quickstop_options, ui.get(rage[i].quick_stop_options))
    end
    ui.set(ref_prefer_bodyaim, ui.get(rage[i].prefer_baim))
    ui.set(ref_prefer_bodyaim_disablers, ui.get(rage[i].prefer_baim_disablers))
    ui.set(ref_force_baim_peek, ui.get(rage[i].force_baim_peek))
	ui.set(dt, ui.get(rage[i].dt))
	ui.set(ref_doubletap_hitchance, ui.get(rage[i].doubletap_hitchance))
	ui.set(ref_doubletap_stop, ui.get(rage[i].doubletap_stop))
    ui.set(ref_remove_recoil, true)

    active_idx = i
end

local function weapon_switch(c)
    local plocal = entity.get_local_player()
    local weapon = entity.get_player_weapon(plocal)
    local weapon_id = bit.band(entity.get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)

    local wpn_text = config_names[weapon_idx[weapon_id]]

    if wpn_text ~= nil then
        if last_weapon ~= weapon_id then
            ui.set(active_wpn, ui.get(rage[weapon_idx[weapon_id]].enabled) and wpn_text or "Global")
            last_weapon = weapon_id
        end
        set_config(weapon_idx[weapon_id])
        local plocal = entity.get_local_player()
    else
        if last_weapon ~= weapon_id then
            ui.set(active_wpn, "Global")
            last_weapon = weapon_id
        end
        set_config(1)
    end
end

local function run_visuals()
    refresh_ui()
    if not ui.get(ref_enable) then return end
    if not ui.get(ref_enable_key) then return end
    local x, y = client.screen_size()
    if ui.get(override_dmg_3) then
        renderer.text(x/2 + 10, y/2 + 10, 
        255, 
        255, 
        255, 
        255,
        "C", 0,ui.get(ref_mindamage))
    elseif ui.get(override_dmg_2) then
        renderer.text(x/2 + 10, y/2 + 10, 
        255, 
        255, 
        255, 
        255,
        "C", 0,ui.get(ref_mindamage))
    elseif ui.get(override_dmg_1) then
        renderer.text(x/2 + 10, y/2 + 10, 
        255, 
        255, 
        255, 
        255,
        "C", 0,ui.get(ref_mindamage))

    end

	if ui.get(override_hitbox_key) then
		renderer.indicator(150,200,60,255,"Hitbox")
	end
	if ui.get(override_unsafehitboxes_key) then
		renderer.indicator(150,200,60,255,"Unsafe Hitbox")
	end
	if ui.get(override_multi_point_key) then
		renderer.indicator(150,200,60,255,"Multi-Point Scale")
	end
	if ui.get(override_hitchance_key) then
		renderer.indicator(150,200,60,255,"Hitchance")
	end
    
end

client.set_event_callback("setup_command", weapon_switch)
client.set_event_callback("paint", run_visuals)
client.set_event_callback("shutdown",function()
    close_ui = true
    refresh_ui()
end)