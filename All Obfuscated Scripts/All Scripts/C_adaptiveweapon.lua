--[[
	id: MonW9i7gv-qfzfqy7JxMW
	name: C_adaptive weapon2
	description: C_adaptive weapon2
	time1: 2021-07-13 18:40:40.262223+00
	time2: 2021-07-13 18:40:40.262225+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

﻿local function hsv_to_rgb(h, s, v, a)
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

local function func_rgb_rainbowize(frequency, rgb_split_ratio)
    local r, g, b, a = hsv_to_rgb(globals.realtime() * frequency, 1, 1, 1)

    r = r * rgb_split_ratio
    g = g * rgb_split_ratio
    b = b * rgb_split_ratio

    return r, g, b
end

local function handle_paint(ctx)
    local r, g, b = func_rgb_rainbowize(0.1, 1)
    client.draw_indicator(ctx, r, g, b,255, "Invincible CFG")
end

client.set_event_callback("paint", handle_paint)

local images = require "gamesense/images" or error("Images库 https://gamesense.pub/forums/viewtopic.php?id=22917")
local csgo_weapons = require "gamesense/csgo_weapons" or error("Csgo_Weapons库 https://gamesense.pub/forums/viewtopic.php?id=18807")
local dragging = (function() local a={} local b,c,d,e,f,g,h,i,j,k,l,m,n,o,dg; local p={__index={drag=function(self,...) local q,r=self:get() local s,t=a.drag(q,r,...) if q~=s or r~=t then self:set(s,t) end; return s,t end, set=function(self,q,r) local j,k = client.screen_size() ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res) end, get=function(self) local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}} function a.new(u,v,w,x)x=x or 10000; local j,k=client.screen_size() local y=ui.new_slider("LUA","A",u.." window position 2",0,x,v/j*x) local z=ui.new_slider("LUA","A","\n"..u.." window position y 2",0,x,w/k*x) ui.set_visible(y,false) ui.set_visible(z,false) return setmetatable({name = u,x_reference = y,y_reference = z,res = x},p) end; function a.drag(q,r,A,B,C,D,E) if globals.framecount()~=b then c = ui.is_menu_open() f,g=d,e; d,e=ui.mouse_position() i=h; h=client.key_state(0x01)==true; m=l; l={} o=n; n=false; j,k=client.screen_size() end; if c and i~=nil then if (not i or o) and h and f>q and g>r and f<q+A and g<r+B then n=true; q,r=q+d-f,r+e-g; if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r)) end end if f>=q and g>=r and f<=q+A and g<=r+B then dg = true else dg = false end else  f,g,d,e = 0,0,0,0 dg = false end; table.insert(l,{q,r,A,B}) return q,r,A,B end;function a.match() return dg end;return a end)()
local dragging_2 = (function() local a={} local b,c,d,e,f,g,h,i,j,k,l,m,n,o,dg; local p={__index={drag=function(self,...) local q,r=self:get() local s,t=a.drag(q,r,...) if q~=s or r~=t then self:set(s,t) end; return s,t end, set=function(self,q,r) local j,k = client.screen_size() ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res) end, get=function(self) local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}} function a.new(u,v,w,x)x=x or 10000; local j,k=client.screen_size() local y=ui.new_slider("LUA","A",u.." window position 2",0,x,v/j*x) local z=ui.new_slider("LUA","A","\n"..u.." window position y 2",0,x,w/k*x) ui.set_visible(y,false) ui.set_visible(z,false) return setmetatable({name = u,x_reference = y,y_reference = z,res = x},p) end; function a.drag(q,r,A,B,C,D,E) if globals.framecount()~=b then c = ui.is_menu_open() f,g=d,e; d,e=ui.mouse_position() i=h; h=client.key_state(0x01)==true; m=l; l={} o=n; n=false; j,k=client.screen_size() end; if c and i~=nil then if (not i or o) and h and f>q and g>r and f<q+A and g<r+B then n=true; q,r=q+d-f,r+e-g; if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r)) end end if f>=q and g>=r and f<=q+A and g<=r+B then dg = true else dg = false end else  f,g,d,e = 0,0,0,0 dg = false end; table.insert(l,{q,r,A,B}) return q,r,A,B end;function a.match() return dg end;return a end)()
local hk_dragger = dragging.new("Running SYR Weapons Indicators", 500, 600)
local hk_dragger_2 = dragging_2.new("Running SYR HeadBaim Indicators", 500, 600)


target_select = ui.reference("RAGE", "Aimbot", "Target selection")
ref_plist = ui.reference("PLAYERS", "Players", "Player list")
target_hitbox_ref = ui.reference("RAGE", "Aimbot", "Target hitbox")
multi_hitbox, multi_hotkey, multi_modes = ui.reference("RAGE", "Aimbot", "Multi-point")
multi_scale = ui.reference("RAGE", "Aimbot", "Multi-point scale")
prefer_safe = ui.reference("RAGE", "Aimbot", "Prefer safe point")
force_safe = ui.reference("RAGE", "Aimbot", "Force safe point")
min_htc = ui.reference("RAGE", "Aimbot", "Minimum hit chance")
min_dmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
auto_scope = ui.reference("RAGE", "Aimbot", "Automatic scope")
low_fps = ui.reference("RAGE", "Aimbot", "Low FPS mitigations")
delay_shot = ui.reference("RAGE", "Other", "Delay shot")
accuracy_mode = ui.reference("RAGE", "Other", "Accuracy boost")
quick_stop = ui.reference("RAGE", "Other", "Quick stop")
quick_mode = ui.reference("RAGE", "Other", "Quick stop options")
prefer_baim = ui.reference("RAGE", "Other", "Prefer body aim")
slow_walk, slow_key = ui.reference("AA", "Other", "Slow motion")
prefer_baim_disabled = ui.reference("RAGE", "Other", "Prefer body aim disablers")
hide_check, hide_key = ui.reference("AA", "Other", "On shot anti-aim")
double_check, double_key = ui.reference("RAGE", "Other", "Double tap")
double_tap_types = ui.reference("RAGE", "Other", "Double tap mode")
double_tap_htc = ui.reference("RAGE", "Other", "Double tap hit chance")
double_tap_fl = ui.reference("RAGE", "Other", "Double tap fake lag limit")
double_tap_stop = ui.reference("RAGE", "Other", "Double tap quick stop")
ref_pref_baim = ui.reference("PLAYERS", "Adjustments", "Override prefer body aim")
ref_pref_safe = ui.reference("PLAYERS", "Adjustments", "Override safe point")
force_peek_baim = ui.reference("RAGE", "Other", "Force body aim on peek")
force_safe_hitbox = ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes")
auto_peeking, auto_peek_keys = ui.reference("RAGE", "Other", "Quick peek assist")
resolver, resolver_override = ui.reference("RAGE", "Other", "Anti-aim correction"), ui.reference("RAGE", "Other", "Anti-aim correction override")
ref_resolver_byaw = ui.reference("PLAYERS", "Adjustments", "Force body yaw")
ref_resolver_byaw_val = ui.reference("PLAYERS", "Adjustments", "Force body yaw value")

local dormant_min_damage = ui.reference("Rage", "Aimbot", "Dormant minimum damage")
local dormant_alpha = ui.reference("Rage", "Aimbot", "Dormant alpha")

local options = ui.new_multiselect("RAGE", "Other", "[Lua]Prefer Baim", "Backwards/Forwards", "Moving targets", "Slow targets", "Shooting", "x2 HP", "<x HP", "Big desync", "Walking jitter desync", "Always on", "Override /X M", "E Peeking Player")
local headaim_options = ui.new_multiselect("RAGE", "Other" , "[Lua]Prefer Headshot", "Sideways targets", "Crouching targets", "Fast targets", "Shooting", "Small desync", "Override /X M", "E Peeking Player")
local force_options = ui.new_multiselect("RAGE", "Other" , "[Lua]Force Baim", "Backwards/Forwards", "Sideways targets", "Slow targets", "Shooting", "x1 HP", "x2 HP", "<x HP", "Walking jitter desync", "1 miss", "2 miss", "On Double Tap", "On Hide Shot", "Override /X M", "E Peeking Player")
local safe_options = ui.new_multiselect("RAGE", "Other" , "[Lua]Force Safety", "Backwards/Forwards", "Sideways targets", "Slow targets", "Shooting", "x1 HP", "x2 HP", "<x HP", "Walking jitter desync", "1 miss", "2 miss", "On Double Tap", "On Hide Shot", "Override /X M", "E Peeking Player")
local indicator = ui.new_checkbox("RAGE", "Other", "Indicator")
local reset_misses = ui.new_checkbox("RAGE", "Other" , "Automatically reset misses")
local predictive_baim = ui.new_checkbox("RAGE", "Other" , "Predictive Body Aim")
local ref_desync = ui.new_slider("RAGE", "Other", "Desync limit", 290, 580, 290, true, "°", 0.1)
local range_slider = ui.new_slider("RAGE","Other", "Range",1 ,70, 30, true, "°")
local jitter_sensitivity = ui.new_slider("RAGE", "Other" , "Jitter Sensitivity", 1, 10, 6, true)
local ref_hp_slider = ui.new_slider("RAGE", "Other", "HP", 1, 100)
local reset_hotkey = ui.new_hotkey("RAGE", "Other", "Reset enemy")
local force_hotkey = ui.new_hotkey("RAGE", "Other", "Force body aim nearest")
local safety_condition = ui.new_slider("RAGE", "Other", "Safety Ammount", 1, 2)
local smart_footaim = ui.new_checkbox("RAGE", "Other", "Smart Shooting")
local based_override_damage = ui.new_checkbox("RAGE", "Other" , "Damage >= Health", false)
local weapon_targets = {"Auto", "AWP", "Scout", "Pistol", "Rifle", "SMG", "R8 Revolver", "Eagle", "Heavy", "Other", "Taser Zeus", "Global"}
local syr_active = ui.new_checkbox("Rage", "Aimbot", "Enabled Adaptive Weapons")
local global_c = ui.new_color_picker("Rage", "Aimbot", "Global Color C_S", 0, 255, 255, 255)
local keybinds_listbox = ui.new_multiselect("Rage", "Aimbot", "Weapons Keybinds Listbox", "Min Damage", "Damage Override", "Hitbox Override", "Hitchance Override", "MultiPoint Override", "AvoidHitbox Override")
local weapon_indicator = ui.new_multiselect("Rage", "Aimbot", "Weapon Indicators", "Active Weapons", "Min Damage", "Damage Override", "Hitbox Override", "Hitchance Override", "MultiPoint Override", "AvoidHitbox Override", "Distance", "D & H", "Damage Value", "Hitchance Value", "Active Boxer", "Resolver Angles", "Prefer HeadBaim Boxer", "HeadBaim Boxer Breaking Color")
local disabled_scope_hitchance = ui.new_multiselect("Rage", "Aimbot", "Active UnScope Hitchance Weapons", weapon_targets)
local weapons_acitve_visible = ui.new_combobox("Rage", "Aimbot", "Weapons Selection", weapon_targets)
local auto_peeking_key = ui.new_hotkey("Rage", "Aimbot", "Auto Peeking Hotkey", false)
local override_damage_key_1 = ui.new_hotkey("Rage", "Aimbot", "Override Damage Hotkey /X1", false)
local override_damage_key_2 = ui.new_hotkey("Rage", "Aimbot", "Override Damage Hotkey /X2", false)
local override_damage_key_3 = ui.new_hotkey("Rage", "Aimbot", "Override Damage Hotkey /X3", false)
local forcehead_key = ui.new_hotkey("Lua", "A", "Force Head Hitbox", false)
local override_hitbox_key = ui.new_hotkey("Rage", "Aimbot", "Override Hitbox Hotkey", false)
local override_hitchance_key = ui.new_hotkey("Rage", "Aimbot", "Override Hitchance Hotkey", false)
local override_multipoint_key = ui.new_hotkey("Rage", "Aimbot", "Override MultiPoint Hotkey", false)
local override_unsafehitbox_key = ui.new_hotkey("Rage", "Aimbot", "Override UnSafe Hitbox Hotkey", false)
local high_priority_dager = ui.new_checkbox("Rage", "Aimbot", "Prefer Attack Dangerous Targets")
local lua_headbaim_indicator = ui.new_checkbox("Rage", "Other" ,"Enabled Prefer HitPriority Indicator")
local head_shoter_label = ui.new_label("Rage", "Other", "Prefer Head Color")
local head_shoter_c = ui.new_color_picker("Rage", "Other", "Head Color c", 0, 50, 255, 255)
local preferbaim_shoter_label = ui.new_label("Rage", "Other", "Prefer Baim Color")
local preferbaim_shoter_c = ui.new_color_picker("Rage", "Other", "Prefer Color c", 0, 255, 0, 255)
local prefer_shoter_label = ui.new_label("Rage", "Other", "Force Baim Color")
local forcebaim_shoter_c = ui.new_color_picker("Rage", "Other", "Force Color c", 0, 255, 125, 255)
local safe_shoter_label = ui.new_label("Rage", "Other", "Force Safety Color")
local forcesafe_shoter_c = ui.new_color_picker("Rage", "Other", "Safety Color c", 0, 180, 255, 255)
local manual_state = ui.new_slider("Rage", "Other", "\n Manual Override Damage", 0, 3, 0)
local damage_labels_select = {[0] = "Auto"}
for i = 1, 126 do
	damage_labels_select[i] = i <= 100 and tostring(i) or "HP+" .. tostring(i - 100)
end

local active = {}
for i = 1, #weapon_targets do
    active[i] = {
        ["global_enabled_config"] = ui.new_checkbox("Rage", "Aimbot", "Enabled [" .. weapon_targets[i] .. "] Adaptive Weapon Configs"),
        ["target_select"] = ui.new_combobox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Target Selection", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
        ["target_hitbox"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["dt_hitbox"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Double Tap Hitboxes", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["hitbox_override"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override Hitboxes", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["accuracy_modes"] = ui.new_combobox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Accuracy Boost Mode", {"Off", "Low", "Medium", "High","Maximum"}),
        ["unsafe_hitbox"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Avoid UnSafety Hitboxes", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["unsafe_hitbox_ove"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override Avoid UnSafety Hitboxes", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["delay_shot"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Delay Shot"),
        ["auto_scope"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Automatic Scope"),
	["damage_dormant"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Minimum Damage (Dormant)", 0, 100, 20, true, "", 1),
	["alpha_dormant"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Dormant Alpha", 0, 100, 20, true, "", 1),	
        ["global_active_states"] = ui.new_combobox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Active D & H & M Types", {"Default", "Double Tap", "Hide Shot"}),
        ["damage_wall"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Minimum Damage (Autowall)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["damage_visible"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Minimum Damage (Visible)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["damage_override_1"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override Minimum Damage /X1", 0, 126, 20, true, "", 1, damage_labels_select),
        ["damage_override_2"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override Minimum Damage /X2", 0, 126, 20, true, "", 1, damage_labels_select),
        ["damage_override_3"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override Minimum Damage /X3", 0, 126, 20, true, "", 1, damage_labels_select),
        ["hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Wall Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["vis_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Visible Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["override_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["noscope_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]NoScope Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["mp_hitbox"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Multi-Point Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["mp_modes"] = ui.new_combobox("Rage", "Aimbot", "\n [" .. weapon_targets[i] .. "]Multi Point Types", {"Low", "Medium", "High"}),
        ["dynamic_mp"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Dynamic Multi-point"),
        ["dynamic_types"] = ui.new_combobox("Rage", "Aimbot", "\n [" .. weapon_targets[i] .. "]Dynamic Multi-Point Types", {"Based Distance", "Based Velocity", "Advanced Adaptive"}),
        ["mp_scale"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Multi-Point Scale", 24, 100, 35, true, "%", 1, {[24] = "Auto"}),
        ["mp_scale_ove"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override Multi-Point Scale", 24, 100, 61, true, "%", 1, {[24] = "Auto"}),
        ["dt_damage_wall"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Minimum Damage (Autowall)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["dt_damage_visible"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Minimum Damage (Visible)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["dt_wall_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Wall Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["dt_vis_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Visible Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["dt_override_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Override Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["dt_noscope_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT NoScope Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["dt_mp_hitbox"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Multi-Point Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["dt_mp_modes"] = ui.new_combobox("Rage", "Aimbot", "\n [" .. weapon_targets[i] .. "]DT Multi Point Types", {"Low", "Medium", "High"}),
        ["dt_mp_scale"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Multi-Point Scale", 24, 100, 35, true, "%", 1, {[24] = "Auto"}),
        ["dt_prefer_safe"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]DT Prefer Safe Point"),
        ["hide_damage_wall"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Minimum Damage (Autowall)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["hide_damage_visible"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Minimum Damage (Visible)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["hide_wall_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Wall Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["hide_vis_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Visible Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["hide_override_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Override Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["hide_noscope_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide NoScope Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["hide_mp_hitbox"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Multi-Point Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["hide_mp_modes"] = ui.new_combobox("Rage", "Aimbot", "\n [" .. weapon_targets[i] .. "]Hide Multi Point Types", {"Low", "Medium", "High"}),
        ["hide_mp_scale"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Multi-Point Scale", 24, 100, 35, true, "%", 1, {[24] = "Auto"}),
        ["hide_prefer_safe"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Hide Prefer Safe Point"),
        ["prefer_safe"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Prefer Safe Point"),
        ["force_safe"] = ui.new_combobox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Force Safe Point", {"Always on", "On Hotkey", "Toggle", "Off Hotkey"}),
        ["prefer_baim"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Prefer Body Aim"),
        ["baim_disable"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Prefer Body Aim Disablers", {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage"}),
        ["quick_stop"] = ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Quick Stop"),
        ["stop_select"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Quick Stop Options", {"Early", "Slow motion", "Duck", "Fake duck", "Move between shots", "Ignore molotov", "Taser"}),
        ["dt_enabled"] =  ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Double Tap"),
        ["dt_types"] = ui.new_combobox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Double Tap Stypes", {"Offensive", "Defensive"}),
        ["dt_hitchance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Double Tap Hitchance", 0, 100, 50, true, "%", 1),
        ["dt_fakelag"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Double Tap Fakelag Limit", 1, 10, 1, true, "t", 1),
        ["dt_stop"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Double Tap quick stop", {"Slow motion", "Duck", "Move between shots"}),
        ["fps_disable"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Low FPS Mitigations", {"Force low accuracy boost", "Disable multipoint: feet", "Disable multipoint: arms", "Disable multipoint: legs", "Disable hitbox: feet", "Force low multipoint", "Lower hit chance precision", "Limit targets per tick"}),
        ["enabled_air_status"] =  ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]● Enabled Jumping Override ●"),
        ["target_select_air"] = ui.new_combobox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Jumping Target Selection", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
        ["target_hitbox_air"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Jumping Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["mp_hitbox_air"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Jumping Multi-Point Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["damage_air"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Jumping Minimum Damage", 0, 126, 20, true, "", 1, damage_labels_select),
        ["hitchance_air"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Jumping Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["mp_modes_air"] = ui.new_combobox("Rage", "Aimbot", "\n [" .. weapon_targets[i] .. "]Jumping MultiPoint", {"Low", "Medium", "High"}),
        ["mp_scale_air"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Jumping Multi-Point Scale", 24, 100, 35, true, "%", 1, {[24] = "Auto"}),
        ["jump_dis_label"] =  ui.new_label("Rage", "Aimbot", "-------  [" .. weapon_targets[i] .. "]Jump And Distance Override Values -------"),
        ["enabled_dis_status"] =  ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]● Enabled Distance Override ●"),
        ["enemy_distance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Override While Enemy Distance", 0, 50, 0, true, "M", 1),
        ["target_select_dis"] = ui.new_combobox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Distance Target Selection", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
        ["target_hitbox_distance"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Distance Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["mp_hitbox_distance"] = ui.new_multiselect("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Distance Multi-Point Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["damage_distance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Distance Minimum Damage", 0, 126, 20, true, "", 1, damage_labels_select),
        ["hitchance_distance"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Distance Hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["mp_modes_dis"] = ui.new_combobox("Rage", "Aimbot", "\n [" .. weapon_targets[i] .. "]Distance MultiPoint", {"Low", "Medium", "High"}),
        ["mp_scale_dis"] = ui.new_slider("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Distance Multi-Point Scale", 24, 100, 35, true, "%", 1, {[24] = "Auto"}),
        ["enabled_peek_baim"] =  ui.new_checkbox("Rage", "Aimbot", "[" .. weapon_targets[i] .. "]Force Baim On Peek"),
        ["lua_prefer_baim"] = ui.new_multiselect("Rage", "Other", "[" .. weapon_targets[i] .. "]Prefer Baim", {"Backwards/Forwards", "Moving targets", "Slow targets", "Shooting", "x2 HP", "<x HP", "Big desync", "Walking jitter desync", "Always on", "Override /X M", "E Peeking Player"}),
        ["lua_prefer_head"] = ui.new_multiselect("Rage", "Other" , "[" .. weapon_targets[i] .. "]Prefer Head Shot", {"Sideways targets", "Crouching targets", "Fast targets", "Shooting", "Small desync", "Override /X M", "E Peeking Player"}),
        ["lua_force_baim"] = ui.new_multiselect("Rage", "Other" , "[" .. weapon_targets[i] .. "]Force Baim", {"Backwards/Forwards","Sideways targets", "Slow targets", "Shooting", "x1 HP", "x2 HP", "<x HP", "Walking jitter desync", "1 miss", "2 miss", "On Double Tap", "On Hide Shot", "Override /X M", "E Peeking Player"}),
        ["lua_force_safe"] = ui.new_multiselect("Rage", "Other" , "[" .. weapon_targets[i] .. "]Force Safe Point", {"Backwards/Forwards","Sideways targets", "Slow targets", "Shooting", "x1 HP", "x2 HP", "<x HP", "Walking jitter desync", "1 miss", "2 miss", "On Double Tap", "On Hide Shot", "Override /X M", "E Peeking Player"}),
        ["lua_preferbaim_m"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Prefer Baim /X M", 0, 50, 0, true, "M", 1),
        ["lua_preferhead_m"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Prefer Head /X M", 0, 50, 0, true, "M", 1),
        ["lua_forcebaim_m"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Force Baim /X M", 0, 50, 0, true, "M", 1),
        ["lua_forcesafety_m"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Prefer Safety /X M", 0, 50, 0, true, "M", 1),
        ["lua_prediction_baim"] = ui.new_checkbox("Rage", "Other", "[" .. weapon_targets[i] .. "]Predictive Body Aim"),
        ["lua_desync_limit"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Desync Limit",290, 580, 290,true,"°",0.1),
        ["lua_range"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Range", 1, 70, 30,true,"°"),
        ["lua_jitter_sensitivity"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Jitter Sensitivity",1,10,6,true),
        ["lua_min_hp"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]<X HP",1,100),
        ["enabled_smart_footaim"] =  ui.new_checkbox("Rage", "Other", "[" .. weapon_targets[i] .. "]Smart Foot Aim"),
        ["misc_label"] = ui.new_label("Rage", "Other", "--------------------  Weapon Lua Misc --------------------"),
        ["faster_peeking"] =  ui.new_checkbox("Rage", "Other", "[" .. weapon_targets[i] .. "]Quicky Shooting Peeking"),
        ["adaptive_damage_override"] =  ui.new_checkbox("Rage", "Other", "[" .. weapon_targets[i] .. "]Auto Damage Override"),
        ["lua_auto_stop"] =  ui.new_checkbox("Rage", "Other", "[" .. weapon_targets[i] .. "]Lua Auto Stop"),
        ["lua_auto_stop_speed"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Lua Auto Stop Speed", 1, 100, 50, true, "Sp"),
        ["lua_condition"] = ui.new_multiselect("Rage", "Other" , "[" .. weapon_targets[i] .. "]Extra's", {"Dormant damage","Dormant alpha","Visible Damage", "Override Damage /X1", "Override Damage /X2", "Override Damage /X3", "Override Hitbox", "Visible Hitchance", "Override Hitchance", "NoScope Hitchance", "Override Multi-Point", "Override UnSafety Hitbox", "Prefer Hitbox Attack Condition", "Customized Double Tap", "Check DT(D & H & M) Condition", "Check Hide Shot(D & H & M) Condition"}),
        ["lua_auto_peek"] =  ui.new_checkbox("Rage", "Other", "[" .. weapon_targets[i] .. "]Auto Peeking"),
        ["lua_auto_peek_triggers"] = ui.new_multiselect("Rage", "Other" , "\n [" .. weapon_targets[i] .. "]Auto Peeking Triggers", {"X Shots", "Kill", "Standing Still"}),
        ["lua_auto_peek_shots"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Auto Peeking Shots", 1, 7, 1, true, "S"),
        ["lua_auto_peek_speed"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Auto Peeking Circle Speed", 1, 50, 1, true, "L"),
        ["lua_auto_peek_length"] = ui.new_slider("Rage", "Other", "[" .. weapon_targets[i] .. "]Auto Peeking Circle Length", 1, 50, 15, true, "L"),
      }
end

local disabled_de_on_greaner = ui.new_checkbox("Rage", "Other", "Disabled Double Tap On Other Weapons")
local hide_default_menus = ui.new_checkbox("Rage", "Other" ,"Hide Skeet Default Rage Aimbot Debug Menu")
local enabled_adaptive_hitchance = ui.new_checkbox("Rage", "Other", "Adaptive Double Tap Hitchance")
local resert_attack_key = ui.new_hotkey("Rage", "Other" ,"Resert Prefer Attack Hitbox Keys")
local active_on_switch = ui.new_checkbox("Rage", "Other", "Change Weapons Select On Switch Active")
local active_config_label = ui.new_label("RAGE", "Other", "Active Weapon Config Name: " .. ui.get(weapons_acitve_visible))
local lua_resolver = ui.new_checkbox("Rage", "Other", "[Resolver]Enabled HvH Anti-Aim Correction")
local lua_resolver_types = ui.new_combobox("Rage", "Other", "\n HvH Anti-Aim Correction Types", "Adversary Prediction", "Adversary Random", "Random Angles")
local lua_resolver_logs = ui.new_checkbox("Rage", "Other", "[Resolver]HvH Anti-Aim Correction Logs")

local data = {}
local history = {}
local chokes = {}
local _V3_MT = {}
local cached_plist
local missLogs = {}
local simTimes = {}
local player_safe = {}
local jitter_delta = 15
local lua_damage = 1
local last_weapon = 1
local notifications = {}
local oldSimTimes = {}
local lua_hitchance = 1
local closest_player = 0
local stored_target = nil
local distance_value = 0
local headaim_delay = {}
local weapons_coder = 1
local lua_hitbox = "Head"
local player_preference = {}
local damage_status = "Def"
local lua_mp_hitbox = "Head"
local hitchance_status = "Def"
local weapons_active_idx = 12
local high_priority_danger = false
local syr_active_weapons = "Global"
local fix_out, fix_in, time_fix = - 0.42
local restart_auto_peeking_length = 0
local auto_override_damage = "DISABLED"
local shot_circle, rv_circle, fix_in, time_fix = 0, 0, 0, 0
local quickstop_prev, quickstop_allowed, peek_standing
local single_fire_weapons = {"CDeagle", "CWeaponSSG08", "CWeaponAWP"}
local hotkey_prev, peeks_shots, peek_pos_x, peek_pos_y, peek_pos_z = false, 0

require("bit")
ui.set_visible(options, false)
ui.set_visible(indicator, false)
ui.set_visible(ref_desync, false)
ui.set_visible(range_slider, false)
ui.set_visible(reset_misses, false)
ui.set_visible(safe_options, false)
ui.set_visible(ref_hp_slider, false)
ui.set_visible(reset_hotkey, false)
ui.set_visible(force_hotkey, false)
ui.set_visible(manual_state, false)
ui.set_visible(force_options, false)
ui.set_visible(smart_footaim, false)
ui.set_visible(jitter_sensitivity, false)
ui.set_visible(predictive_baim, false)
ui.set_visible(safety_condition, false)
ui.set(override_hitbox_key, "Toggle")
ui.set_visible(headaim_options, false)
ui.set(override_hitchance_key, "Toggle")
ui.set(override_multipoint_key, "Toggle")
ui.set(override_unsafehitbox_key, "Toggle")
ui.set_visible(based_override_damage, false)
ui.set(active[#weapon_targets]["global_enabled_config"], true)
ui.set_visible(active[#weapon_targets]["global_enabled_config"], false)

_V3_MT.__index = _V3_MT
function Vector3( x, y, z )
	if (type(x) ~= "number") then
		x = 0.0;
	end

	if (type(y) ~= "number") then
		y = 0.0;
	end

	if (type(z) ~= "number") then
		z = 0.0;
	end

	x = x or 0.0
	y = y or 0.0
	z = z or 0.0
	return setmetatable({x = x, y = y, z = z}, _V3_MT)
end

function _V3_MT.__eq(a, b)
	return a.x == b.x and a.y == b.y and a.z == b.z
end

function _V3_MT.__unm(a)
	return Vector3(
		-a.x,
		-a.y,
		-a.z
	)
end

function _V3_MT.__add(a, b)
	local a_type = type(a)
	local b_type = type(b)
	if (a_type == "table" and b_type == "table") then
		return Vector3(
			a.x + b.x,
			a.y + b.y,
			a.z + b.z
		)

	elseif (a_type == "table" and b_type == "number") then
		return Vector3(
			a.x + b,
			a.y + b,
			a.z + b
		)

	elseif (a_type == "number" and b_type == "table") then
		return Vector3(
			a + b.x,
			a + b.y,
			a + b.z
		)
	end
end

function _V3_MT.__sub(a, b)
	local a_type = type(a)
	local b_type = type(b)
	if (a_type == "table" and b_type == "table") then
		return Vector3(
			a.x - b.x,
			a.y - b.y,
			a.z - b.z
		)

	elseif (a_type == "table" and b_type == "number") then
		return Vector3(
			a.x - b,
			a.y - b,
			a.z - b
		)

	elseif (a_type == "number" and b_type == "table") then
		return Vector3(
			a - b.x,
			a - b.y,
			a - b.z
		)
	end
end

function _V3_MT.__mul(a, b)
	local a_type = type(a)
	local b_type = type(b)
	if (a_type == "table" and b_type == "table") then
		return Vector3(
			a.x * b.x,
			a.y * b.y,
			a.z * b.z
		)

	elseif (a_type == "table" and b_type == "number") then
		return Vector3(
			a.x * b,
			a.y * b,
			a.z * b
		)

	elseif (a_type == "number" and b_type == "table") then
		return Vector3(
			a * b.x,
			a * b.y,
			a * b.z
		)
	end
end

function _V3_MT.__div(a, b)
	local a_type = type(a)
	local b_type = type(b)
	if (a_type == "table" and b_type == "table") then
		return Vector3(
			a.x / b.x,
			a.y / b.y,
			a.z / b.z
		)

	elseif (a_type == "table" and b_type == "number") then
		return Vector3(
			a.x / b,
			a.y / b,
			a.z / b
		)

	elseif (a_type == "number" and b_type == "table") then
		return Vector3(
			a / b.x,
			a / b.y,
			a / b.z
		)
	end
end

function _V3_MT.__tostring(a)
	return "(" .. a.x .. ", " .. a.y .. ", " .. a.z .. ")"
end

function _V3_MT:clear()
	self.x = 0.0
	self.y = 0.0
	self.z = 0.0
end

function _V3_MT:unpack()
	return self.x, self.y, self.z
end

function _V3_MT:length_2d_sqr()
	return (self.x * self.x) + (self.y * self.y)
end

function _V3_MT:length_sqr()
	return (self.x * self.x) + (self.y * self.y) + (self.z * self.z)
end

function _V3_MT:length_2d()
	return math.sqrt(self:length_2d_sqr())
end

function _V3_MT:length()
	return math.sqrt(self:length_sqr())
end

function _V3_MT:dot(other)
	return (self.x * other.x) + (self.y * other.y) + (self.z * other.z)
end

function _V3_MT:cross(other)
	return Vector3(
		(self.y * other.z) - (self.z * other.y),
		(self.z * other.x) - (self.x * other.z),
		(self.x * other.y) - (self.y * other.x)
	)
end

function _V3_MT:dist_to(other)
	return (other - self):length()
end

function _V3_MT:is_zero(tolerance)
	tolerance = tolerance or 0.001
	if (self.x < tolerance and self.x > -tolerance and self.y < tolerance and self.y > -tolerance and self.z < tolerance and self.z > -tolerance) then
		return true
	end

	return false
end

function _V3_MT:normalize()
	local l = self:length()
	if (l <= 0.0) then
		return 0.0
	end

	self.x = self.x / l
	self.y = self.y / l
	self.z = self.z / l
	return l
end

function _V3_MT:normalize_no_len()
	local l = self:length()
	if (l <= 0.0) then
		return
	end

	self.x = self.x / l
	self.y = self.y / l
	self.z = self.z / l
end

function _V3_MT:normalized()
	local l = self:length()
	if (l <= 0.0) then
		return Vector3()
	end

	return Vector3(
		self.x / l,
		self.y / l,
		self.z / l
	)
end

function clamp(cur_val, min_val, max_val)
	if (cur_val < min_val) then
		return min_val
	elseif (cur_val > max_val) then
		return max_val
	end

	return cur_val
end

function normalize_angle(angle)
	local out
	local str

	str = tostring(angle)
	if (str == "nan" or str == "inf") then
		return 0.0
	end

	if (angle >= -180.0 and angle <= 180.0) then
		return angle
	end

	out = math.fmod(math.fmod(angle + 360.0, 360.0), 360.0)
	if (out > 180.0) then
		out = out - 360.0
	end

	return out
end

function vector_to_angle(forward)
	local l
	local pitch
	local yaw

	l = forward:length()
	if(l > 0.0) then
		pitch = math.deg(math.atan(-forward.z, l))
		yaw   = math.deg(math.atan(forward.y, forward.x))
	else
		if (forward.x > 0.0) then
			pitch = 270.0
		else
			pitch = 90.0
		end

		yaw = 0.0
	end

	return Vector3(pitch, yaw, 0.0)
end

function angle_forward(angle)
	local sin_pitch = math.sin(math.rad(angle.x))
	local cos_pitch = math.cos(math.rad(angle.x))
	local sin_yaw   = math.sin(math.rad(angle.y))
	local cos_yaw   = math.cos(math.rad(angle.y))
	return Vector3(
		cos_pitch * cos_yaw,
		cos_pitch * sin_yaw,
		-sin_pitch
	)
end

function angle_right(angle)
	local sin_pitch = math.sin(math.rad(angle.x ))
	local cos_pitch = math.cos(math.rad(angle.x ))
	local sin_yaw = math.sin(math.rad(angle.y ))
	local cos_yaw = math.cos(math.rad(angle.y))
	local sin_roll = math.sin(math.rad(angle.z))
	local cos_roll = math.cos(math.rad(angle.z))
	return Vector3(
		-1.0 * sin_roll * sin_pitch * cos_yaw + -1.0 * cos_roll * -sin_yaw,
		-1.0 * sin_roll * sin_pitch * sin_yaw + -1.0 * cos_roll * cos_yaw,
		-1.0 * sin_roll * cos_pitch
	)
end

function angle_up(angle)
	local sin_pitch = math.sin(math.rad(angle.x))
	local cos_pitch = math.cos(math.rad(angle.x))
	local sin_yaw = math.sin(math.rad(angle.y))
	local cos_yaw = math.cos(math.rad(angle.y))
	local sin_roll = math.sin(math.rad(angle.z))
	local cos_roll = math.cos(math.rad(angle.z))
	return Vector3(
		cos_roll * sin_pitch * cos_yaw + -sin_roll * -sin_yaw,
		cos_roll * sin_pitch * sin_yaw + -sin_roll * cos_yaw,
		cos_roll * cos_pitch
	)
end

function get_FOV(view_angles, start_pos, end_pos)
	local type_str
	local fwd
	local delta
	local fov
	fwd = angle_forward(view_angles)
	delta = (end_pos - start_pos):normalized()
	fov = math.acos(fwd:dot(delta) / delta:length())
	return math.max(0.0, math.deg(fov))
end

local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local between = function(v, min, max)
	return v > min and v < max
end

local function distance3d(x1, y1, z1, x2, y2, z2)
	return math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
end

local function GetDistanceInMeter(a_x, a_y, a_z, b_x, b_y, b_z)
	return math.ceil(math.sqrt(math.pow(a_x - b_x, 2) + math.pow(a_y - b_y, 2) + math.pow(a_z - b_z, 2)) * 0.0254)
end

local notify = function(_x, _y, _duration, _r, _g, _b, _a, _text)
	 _duration = _duration > 10 and 10 or _duration
	local real_time = globals.curtime() + _duration
	local not_data = {x = _x, y = _y, duration = real_time, r = _r, g = _g, b = _b, a = _a, text = _text}
	notifications[globals.tickcount()] = not_data
end

local function getDistance(from, to, unit)
	local xDist, yDist, zDist = to[1] - from[1], to[2] - from[2], to[3] - from[3]
	local m1, m2 = 0, 0
	if(unit ~= nil and unit == "feet") then
		m1 = 2
		m2 = 30.48
	end

	return math.sqrt( (xDist ^ 2) + (yDist ^ 2) + (zDist ^ 2) ) * m1 / m2
end

local function multiselect_debug(multiselect, string)
	local number = ui.get(multiselect)
	if #number == 0 then
		ui.set(multiselect, string)
	end
end

local function distance_offset(old_x, old_y, new_x, new_y)
	local sqrt_x, sqrt_y = old_x - new_x, old_y - new_y
	return math.sqrt(sqrt_x * sqrt_x + sqrt_y * sqrt_y)
end

local function ent_speed_2d(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	return math.sqrt(x * x + y * y)
end

local function max_desync(entityindex)
	local spd = math.min(260, ent_speed_2d(entityindex))
	local walkfrac = math.max(0, math.min(1, spd / 135))
	local mult = 1 - 0.5*walkfrac
	local duckamnt = entity.get_prop(entityindex, "m_flDuckAmount")
	
	if duckamnt > 0 then
		local duckfrac = math.max(0, math.min(1, spd / 88))
		mult = mult + ((duckamnt * duckfrac) * (0.5 - mult))
	end
	
	return (58 * mult)
end

client.set_event_callback("weapon_fire", function(e)
	local localplayer = client.userid_to_entindex(e.userid)
	if localplayer ~= entity.get_local_player() then return end
	if -fix_out < globals.realtime() * time_fix then 
		fix_in = globals.realtime() + fix_out
	end 
end)

local function setMath(int, max, declspec)
	local int = (int > max and max or int)
	local tmp = max / int;
	local i = (declspec / tmp)
	i = (i >= 0 and math.floor(i + 0.5) or math.ceil(i - 0.5))
	return i
end

local function get_screen_offset(e, offset_y, offset_z, player)
	local other_x = {}
	local other_y = {}
	local get_players = entity.get_players(player)
	if #get_players == 0 then
		return
	end

	for i = 1, #get_players do
		local enemy = get_players[i]
		local enemy_x, enemy_y, enemy_z = entity.get_prop(enemy, "m_vecOrigin")
		local enemy_offset = entity.get_prop(enemy, "m_vecViewOffset[2]")
		if enemy_z ~= nil and enemy_offset ~= nil then
			enemy_z = enemy_z + enemy_offset * 0.5
			local screen_enemy_x, screen_enemy_y = client.world_to_screen(ctx, enemy_x, enemy_y, enemy_z)
			if screen_enemy_x ~= nil and screen_enemy_y ~= nil then
				if screen_enemy_x >= 0 and screen_enemy_x <= offset_y and screen_enemy_y >= 0 and screen_enemy_y <= offset_z then
					other_x[#other_x + 1] = enemy
					other_y[#other_y + 1] = {
						screen_enemy_x,
						screen_enemy_y
					}
				end
			end
		end
	end

	return other_x, other_y
end

local function get_world_screen(e)
	local screen_x, screen_y = client.screen_size()
	local real_x, real_y = screen_x * 0.5, screen_y * 0.5
	if get_screen_offset(e, screen_x, screen_y, true) == nil then
		return
	end

	local scree_offset_x, scree_offset_y = get_screen_offset(e, screen_x, screen_y, true)
	if #scree_offset_x <= 0 or #scree_offset_y == 0 then
		return true
	end

	local max_screen = 133337
	local max_offset = 133337
	for i = 1, #scree_offset_y do
		local offset_x = scree_offset_y[i][1]
		local offset_y = scree_offset_y[i][2]
		local abs_screen = distance_offset(offset_x, offset_y, real_x, real_y)
		if abs_screen < max_screen then
			max_screen = abs_screen
			max_offset = scree_offset_x[i]
		end
	end

	return max_offset
end

local function adaptive_distance(e)
	local vec_origin_value = get_world_screen(e)
	local local_player = entity.get_local_player()
	local player_vec = Vector3(entity.get_prop(local_player, "m_VecOrigin"))
	local world_vec = Vector3(entity.get_prop(vec_origin_value, "m_VecOrigin"))
	local global_vec = player_vec:dist_to(world_vec)
	if global_vec ~= nil then
		local value_vec_ref = global_vec * 0.0254
		local value_vec = value_vec_ref * 3.281
		return value_vec
	end
end

local function draw_circle_3d(x, y, z, radius, r, g, b, a, accuracy, width, outline, start_degrees, percentage, fill_r, fill_g, fill_b, fill_a)
	local accuracy = accuracy ~= nil and accuracy or 3
	local width = width ~= nil and width or 1
	local outline = outline ~= nil and outline or false
	local start_degrees = start_degrees ~= nil and start_degrees or 0
	local percentage = percentage ~= nil and percentage or 1
	local center_x, center_y
	if fill_a then
		center_x, center_y = renderer.world_to_screen(x, y, z)
	end

	local screen_x_line_old, screen_y_line_old
	for rot = start_degrees, percentage * 360, accuracy do
		local rot_temp = math.rad(rot)
		local lineX, lineY, lineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
		local screen_x_line, screen_y_line = renderer.world_to_screen(lineX, lineY, lineZ)
		if screen_x_line ~=nil and screen_x_line_old ~= nil then
			if fill_a and center_x ~= nil then
				renderer.triangle(screen_x_line, screen_y_line, screen_x_line_old, screen_y_line_old, center_x, center_y, fill_r, fill_g, fill_b, fill_a)
			end

			for i=1, width do
				local i = i - 1
				renderer.line(screen_x_line, screen_y_line - i, screen_x_line_old, screen_y_line_old - i, r, g, b, a)
				renderer.line(screen_x_line - 1, screen_y_line, screen_x_line_old - i, screen_y_line_old, r, g, b, a)
			end

			if outline then
				local outline_a = a / 255 * 160
				renderer.line(screen_x_line, screen_y_line - width, screen_x_line_old, screen_y_line_old - width, 16, 16, 16, outline_a)
				renderer.line(screen_x_line, screen_y_line + 1, screen_x_line_old, screen_y_line_old + 1, 16, 16, 16, outline_a)
			end
		end

		screen_x_line_old, screen_y_line_old = screen_x_line, screen_y_line
	end
end

local bind_system = {
    left = false,
    right = false,
    back = false,
}

function bind_system:update()
	ui.set(override_damage_key_1, "On hotkey")
	ui.set(override_damage_key_2, "On hotkey")
	ui.set(override_damage_key_3, "On hotkey")

	local m_state = ui.get(manual_state)
	local left_state, right_state, backward_state = 
		ui.get(override_damage_key_1), 
		ui.get(override_damage_key_2),
		ui.get(override_damage_key_3)
	if  left_state == self.left and 
		right_state == self.right and
		backward_state == self.back then
		return
	end

	self.left, self.right, self.back = 
		left_state, 
		right_state, 
		backward_state
	if (left_state and m_state == 1) or (right_state and m_state == 2) or (backward_state and m_state == 3) then
		ui.set(manual_state, 0)
		return
	end

	if left_state and m_state ~= 1 then
		ui.set(manual_state, 1)
	end

	if right_state and m_state ~= 2 then
		ui.set(manual_state, 2)
	end

	if backward_state and m_state ~= 3 then
		ui.set(manual_state, 3)
	end
end

client.set_event_callback("paint",function()
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) or not ui.get(syr_active) then
		return
	end

	local players = entity.get_players(true)
	for i = 1, #players do
		enemy_player = players[i]
		if enemy_player == nil or not entity.is_alive(enemy_player) then
			return
		end

		local weapon_enemy = entity.get_player_weapon(enemy_player)
		if weapon_enemy == nil then
			return
		end

		local enemy_weapon_id = bit.band(entity.get_prop(weapon_enemy, "m_iItemDefinitionIndex"), 0xFFFF)
		if ui.get(high_priority_dager) and enemy_weapon_id == 9 or weapon_id == 31 then
			plist.set(enemy_player, "High priority", true)
			high_priority_danger = true
		else
			plist.set(enemy_player, "High priority", false)
			high_priority_danger = false
		end

		local x1, y1, x2 , y2 , mult = entity.get_bounding_box(enemy_player)
		if x1 ~= nil and mult > 0 then
			y1 = y1 - 17
			x1 = x1 + ((x2 - x1) / 2)
			if high_priority_danger then
				renderer.text(x1, y1 - 10, 255, 255, 0, 255, "cb", 0, "High Priority")
			end
		end
	end
end)

local function vec_3(_x, _y, _z)
	return {x = _x or 0, y = _y or 0, z = _z or 0}
end

local function ticks_to_time(ticks)
	return globals.tickinterval() * ticks
end

local function vec2_distance(f_x, f_y, t_x, t_y)
	local delta_x, delta_y = f_x - t_x, f_y - t_y
	return math.sqrt(delta_x*delta_x + delta_y*delta_y)
end

local function setSpeed(newSpeed)
	if client.get_cvar("cl_sidespeed") == 450 and newSpeed == 450 then
		return
	end

	client.set_cvar("cl_sidespeed", newSpeed)
	client.set_cvar("cl_forwardspeed", newSpeed)
	client.set_cvar("cl_backspeed", newSpeed)
end

local function player_will_peek(e)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) or not ui.get(syr_active) or ui.get(quick_stop) then
		return
	end

	local enemies = entity.get_players(true)
	if not enemies then
		return false
	end

	local eye_position = vec_3(client.eye_position())
	local velocity_prop_local = vec_3( entity.get_prop(entity.get_local_player(), "m_vecVelocity"))
	local predicted_eye_position = vec_3( eye_position.x + velocity_prop_local.x * ticks_to_time(16), eye_position.y + velocity_prop_local.y * ticks_to_time(16), eye_position.z + velocity_prop_local.z * ticks_to_time(16))
	for i = 1, #enemies do
		local player = enemies[i]
		local velocity_prop = vec_3(entity.get_prop(player, "m_vecVelocity"))
		local origin = vec_3(entity.get_prop(player, "m_vecOrigin"))
		local predicted_origin = vec_3(origin.x + velocity_prop.x * ticks_to_time(16), origin.y + velocity_prop.y * ticks_to_time(16), origin.z + velocity_prop.z * ticks_to_time(16))
		entity.get_prop(player, "m_vecOrigin", predicted_origin)
		local head_origin = vec_3(entity.hitbox_position(player, 0))
		local predicted_head_origin = vec_3(head_origin.x + velocity_prop.x * ticks_to_time(16), head_origin.y + velocity_prop.y * ticks_to_time(16), head_origin.z + velocity_prop.z * ticks_to_time(16))
		local trace_entity, damage = client.trace_bullet(entity.get_local_player(), predicted_eye_position.x, predicted_eye_position.y, predicted_eye_position.z, predicted_head_origin.x, predicted_head_origin.y, predicted_head_origin.z)
		entity.get_prop(player, "m_vecOrigin", origin)
		if damage > ui.get(min_dmg) + 1 then
			return true
		end
	end

	return false
end

local function vector_angles(x1, y1, z1, x2, y2, z2)
	local origin_x, origin_y, origin_z
	local target_x, target_y, target_z
	if x2 == nil then
		target_x, target_y, target_z = x1, y1, z1
		origin_x, origin_y, origin_z = client.eye_position()
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
		local yaw = math.deg(math.atan2(delta_y, delta_x))
		local hyp = math.sqrt(delta_x*delta_x + delta_y*delta_y)
		local pitch = math.deg(math.atan2(-delta_z, hyp))
		return pitch, yaw
	end
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
	local screen_center_x, screen_center_y = screen_width*0.5, screen_height*0.5
	if get_all_player_positions(ctx, screen_width, screen_height, true) == nil then
		return
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

	for i=1, #enemy_coords do
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

local angle_to_resolve = function(byaw, misses)
	local inverted = byaw > 25
	if between(byaw, -15, 15) then
		return 0
	end

	if inverted then 
		if misses > 1 then
			return - 45
		end

		return byaw / 2
	end

	if misses > 1 then
		return 45
	end

	return - byaw / 2
end

local function can_see(ent)
	for i=0, 18 do
		if client.visible(entity.hitbox_position(ent, i)) then
			return true
		end
	end

	return false
end

local function syr_visible_enemy(ctx)
	local local_entindex = entity.get_local_player()
	if entity.get_prop(local_entindex, "m_lifeState") ~= 0 or not entity.is_alive(local_entindex) then	
		syr_weapon_visible = false
		return
	end
	
	local enemy_visible, enemy_entindex = check_fov(ctx)
	if enemy_entindex == nil then
		return
	end

	if enemy_visible and enemy_entindex ~= nil and stored_target ~= enemy_entindex then
		stored_target = enemy_entindex
	end

	local visible = can_see(enemy_entindex)
	syr_weapon_visible = visible and true or false
	stored_target = enemy_entindex
end

client.set_event_callback("paint", syr_visible_enemy)

client.set_event_callback("paint_ui", function(e)
	ui.set(reset_misses, true)
	ui.set_visible(global_c, ui.get(syr_active))
	ui.set_visible(lua_resolver, ui.get(syr_active))
	ui.set(active[12]["global_enabled_config"], true)
	ui.set_visible(active_on_switch, ui.get(syr_active))
	ui.set_visible(resert_attack_key, ui.get(syr_active))
	ui.set_visible(weapon_indicator, ui.get(syr_active))
	ui.set_visible(auto_peeking_key, ui.get(syr_active))
	ui.set_visible(active_config_label, ui.get(syr_active))
	ui.set_visible(high_priority_dager, ui.get(syr_active))
	ui.set_visible(override_hitbox_key, ui.get(syr_active))
	ui.set_visible(hide_default_menus, ui.get(syr_active))
	ui.set_visible(weapons_acitve_visible, ui.get(syr_active))
	ui.set_visible(active[12]["global_enabled_config"], false)
	ui.set_visible(override_hitchance_key, ui.get(syr_active))
	ui.set_visible(lua_headbaim_indicator, ui.get(syr_active))
	ui.set_visible(override_damage_key_1, ui.get(syr_active))
	ui.set_visible(override_damage_key_2, ui.get(syr_active))
	ui.set_visible(override_damage_key_3, ui.get(syr_active))
	ui.set_visible(override_multipoint_key, ui.get(syr_active))
	ui.set_visible(disabled_de_on_greaner, ui.get(syr_active))
	ui.set_visible(disabled_scope_hitchance, ui.get(syr_active))
	ui.set_visible(override_unsafehitbox_key, ui.get(syr_active))
	ui.set_visible(enabled_adaptive_hitchance, ui.get(syr_active))
	ui.set_visible(head_shoter_c, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(safe_shoter_label, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(head_shoter_label, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(forcesafe_shoter_c, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(prefer_shoter_label, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(forcebaim_shoter_c, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(lua_resolver_logs, ui.get(syr_active) and ui.get(lua_resolver))
	ui.set_visible(preferbaim_shoter_c, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(lua_resolver_types, ui.get(syr_active) and ui.get(lua_resolver))
	ui.set_visible(preferbaim_shoter_label, ui.get(syr_active) and ui.get(indicator))
	ui.set_visible(low_fps, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(min_htc, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(min_dmg, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(force_safe, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(delay_shot, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(quick_stop, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_scale, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(prefer_safe, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(auto_scope, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(prefer_baim, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(quick_mode, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_hitbox, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_hotkey, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(target_select, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_modes, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(accuracy_mode, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(target_hitbox_ref, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(force_peek_baim, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(force_safe_hitbox, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(prefer_baim_disabled, not ui.get(syr_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(keybinds_listbox, ui.get(syr_active) and has_value(ui.get(weapon_indicator), "Active Boxer"))
	ui.set_visible(double_tap_fl, not ui.get(syr_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	ui.set_visible(double_tap_htc, not ui.get(syr_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	ui.set_visible(double_tap_stop, not ui.get(syr_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	ui.set_visible(double_tap_types, not ui.get(syr_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	for i=1, #weapon_targets do
		local get_desync_select = has_value(ui.get(active[i]["lua_prefer_baim"]),"Big desync") or has_value(ui.get(active[i]["lua_prefer_head"]),"Small desync")
		local get_sideways_select = has_value(ui.get(active[i]["lua_force_baim"]),"Sideways targets") or has_value(ui.get(active[i]["lua_prefer_head"]),"Sideways targets")
		local get_jitter_select = has_value(ui.get(active[i]["lua_force_baim"]),"Walking jitter desync") or has_value(ui.get(active[i]["lua_prefer_baim"]),"Walking jitter desync")
		local get_health_select = has_value(ui.get(active[i]["lua_prefer_baim"]),"x2 HP") or has_value(ui.get(active[i]["lua_prefer_baim"]),"<x HP") or has_value(ui.get(active[i]["lua_force_baim"]),"x1 HP") or has_value(ui.get(active[i]["lua_force_baim"]),"x2 HP") or has_value(ui.get(active[i]["lua_force_baim"]),"<x HP") or has_value(ui.get(active[i]["lua_force_safe"]),"<x HP") or has_value(ui.get(active[i]["lua_force_safe"]),"x2 HP") or has_value(ui.get(active[i]["lua_force_safe"]),"x1 HP")
		ui.set_visible(active[i]["misc_label"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["faster_peeking"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["enabled_peek_baim"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["jump_dis_label"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["target_select"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["global_enabled_config"], i ~= 12 and (ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i]))
		ui.set_visible(active[i]["target_hitbox"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["dt_hitbox"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["hitbox_override"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Override Hitbox"))
		ui.set_visible(active[i]["accuracy_modes"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["delay_shot"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["auto_scope"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["damage_dormant"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Dormant damage"))
		ui.set_visible(active[i]["alpha_dormant"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Dormant alpha"))
		ui.set_visible(active[i]["global_active_states"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["damage_wall"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["damage_visible"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Visible Damage") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["damage_override_1"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Override Damage /X1") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["damage_override_2"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Override Damage /X2") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["damage_override_3"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Override Damage /X3") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["vis_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Visible Hitchance") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["override_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Override Hitchance") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["dt_damage_wall"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_damage_visible"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_wall_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_vis_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_override_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_noscope_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_mp_hitbox"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_mp_modes"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_mp_scale"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["dt_prefer_safe"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Double Tap")
		ui.set_visible(active[i]["hide_damage_wall"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_damage_visible"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_wall_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_vis_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_override_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_noscope_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_mp_hitbox"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_mp_modes"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_mp_scale"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["hide_prefer_safe"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Hide Shot")
		ui.set_visible(active[i]["enabled_smart_footaim"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["adaptive_damage_override"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["unsafe_hitbox"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["unsafe_hitbox_ove"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Override UnSafety Hitbox"))
		ui.set_visible(active[i]["noscope_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(disabled_scope_hitchance), ui.get(weapons_acitve_visible)) and has_value(ui.get(active[i]["lua_condition"]), "NoScope Hitchance") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["mp_hitbox"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["mp_modes"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["dynamic_mp"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["mp_scale"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and not ui.get(active[i]["dynamic_mp"]) and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["dynamic_types"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dynamic_mp"]) and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["mp_scale_ove"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Override Multi-Point") and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["prefer_safe"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["global_active_states"]) == "Default")
		ui.set_visible(active[i]["force_safe"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["prefer_baim"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["baim_disable"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["prefer_baim"]))
		ui.set_visible(active[i]["quick_stop"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["stop_select"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["quick_stop"]))
		ui.set_visible(active[i]["dt_enabled"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Customized Double Tap"))
		ui.set_visible(active[i]["dt_stop"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and has_value(ui.get(active[i]["lua_condition"]), "Customized Double Tap"))
		ui.set_visible(active[i]["dt_types"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and has_value(ui.get(active[i]["lua_condition"]), "Customized Double Tap"))
		ui.set_visible(active[i]["dt_fakelag"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and has_value(ui.get(active[i]["lua_condition"]), "Customized Double Tap"))
		ui.set_visible(active[i]["dt_hitchance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and not ui.get(enabled_adaptive_hitchance) and has_value(ui.get(active[i]["lua_condition"]), "Customized Double Tap"))
		ui.set_visible(active[i]["fps_disable"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["enabled_air_status"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["target_select_air"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["target_hitbox_air"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["mp_hitbox_air"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["damage_air"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["hitchance_air"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["mp_modes_air"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["mp_scale_air"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["enabled_dis_status"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["target_select_dis"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["target_hitbox_distance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["mp_hitbox_distance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["damage_distance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["hitchance_distance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["mp_modes_dis"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["mp_scale_dis"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["enemy_distance"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_dis_status"]))
		ui.set_visible(active[i]["lua_prefer_baim"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_prefer_head"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_force_baim"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_force_safe"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_prediction_baim"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_auto_stop"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["lua_desync_limit"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and get_desync_select and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_range"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and get_sideways_select and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_jitter_sensitivity"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and get_jitter_select and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_min_hp"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and get_health_select and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_auto_stop_speed"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["lua_auto_stop"]))
		ui.set_visible(active[i]["lua_condition"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["lua_preferbaim_m"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_prefer_baim"]), "Override /X M") and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_preferhead_m"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_prefer_head"]), "Override /X M") and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_forcebaim_m"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_force_baim"]), "Override /X M") and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_forcesafety_m"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_force_safe"]), "Override /X M") and has_value(ui.get(active[i]["lua_condition"]), "Prefer Hitbox Attack Condition"))
		ui.set_visible(active[i]["lua_auto_peek"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["lua_auto_peek_triggers"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["lua_auto_peek"]))
		ui.set_visible(active[i]["lua_auto_peek_speed"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["lua_auto_peek"]))
		ui.set_visible(active[i]["lua_auto_peek_length"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["lua_auto_peek"]))
		ui.set_visible(active[i]["lua_auto_peek_shots"], ui.get(syr_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["lua_auto_peek"]) and has_value(ui.get(active[i]["lua_auto_peek_triggers"]), "X Shots"))
		multiselect_debug(active[i]["dt_hitbox"], "Head")
		multiselect_debug(active[i]["target_hitbox_air"], "Head")
		multiselect_debug(active[i]["target_hitbox_distance"], "Head")
		multiselect_debug(active[i]["target_hitbox"], "Head")
		multiselect_debug(active[i]["hitbox_override"], "Head")
	end
end)

local function syr_weapons_name(c)
	fix_out = 0.32
	local weapons_active_idx = 12
	local syr_active_weapons = "Global"
	local local_player = entity.get_local_player()
	local enemy_players = entity.get_players(true)
	if has_value(ui.get(weapon_indicator), "HeadBaim Boxer Breaking Color") then
		local shot_circle = fix_in > globals.realtime() and (setMath(fix_in - globals.realtime(), fix_out, 40) * 0.004) or 0
		local white_anim = shot_circle * 620
		local weapon_r_ref, weapon_g_ref, weapon_b_ref, weapon_a_ref = ui.get(global_c)
		weapon_r, weapon_g, weapon_b, weapon_a = math.min(255, weapon_r_ref + white_anim), math.min(255, weapon_g_ref + white_anim), math.min(255, weapon_b_ref + white_anim), math.min(255, weapon_a_ref + white_anim) 
	elseif not has_value(ui.get(weapon_indicator), "HeadBaim Boxer Breaking Color") then
		weapon_r, weapon_g, weapon_b, weapon_a = ui.get(global_c)
	end

	local x_4, y_4 =  hk_dragger_2:get()
	local alpha = 1 + math.sin(math.abs(-math.pi + globals.realtime() % (math.pi * 2))) * 219
	local pulse = 8 + math.sin(math.abs(-math.pi + (globals.realtime() * (0.6 / 1)) % (math.pi * 2))) * 12
	local headaim_check = has_value(ui.get(weapon_indicator), "Prefer HeadBaim Boxer") and has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Prefer Hitbox Attack Condition") and entity.is_alive(local_player) and ui.get(syr_active)
	if headaim_check then
		local addiction_y = headaim_check and (#enemy_players * 10) or 0
		client.draw_gradient(ctx, x_4 + 5, y_4, 200, 10, 0, 0, 0, 20, 10, 10, 10, 30, true)
		client.draw_gradient(ctx, x_4, y_4, 205, 20 + addiction_y, 0, 0, 0, 200, 10, 10, 10, 30, true)
		client.draw_gradient(ctx, x_4, y_4 - 2, 40 + pulse * 3, 2, weapon_r, weapon_g, weapon_b, 255, 25, 25, 25, 5, true)
		client.draw_gradient(ctx, x_4, y_4, pulse * 0.7, 20 + addiction_y, weapon_r, weapon_g, weapon_b, 255, 25, 25, 25, 5, true)
		client.draw_gradient(ctx, x_4, y_4 + 20 + addiction_y, 120 + pulse * 5, 2, weapon_r, weapon_g, weapon_b, 255, 25, 25, 25, 20, true)
		renderer.text(x_4 + 10, y_4 + 2, 255, 155, 155, 180, "", 0, "HEADBAIM")
		renderer.text(#enemy_players <= 0 and x_4 + 80 or x_4 + 85, y_4 + 2, #enemy_players <= 0 and weapon_r or 255, #enemy_players <= 0 and weapon_g or 155, #enemy_players <= 0 and weapon_b or 155, alpha, "", 0, #enemy_players <= 0 and "WAITING..." or "ACTIVE")
		renderer.text(x_4 + 155, y_4 + 2, 128, 183, 255, 255, "", 0, "RE START")
	end

	hk_dragger_2:drag(200, 20 + #enemy_players * 10)
	for i = 1, #enemy_players do
		enemy_player = enemy_players[i]
		local local_player_origin = {x, y, z}
		local enemy_origin = {x, y, z}
		local_player_origin.x, local_player_origin.y, local_player_origin.z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
		enemy_origin.x, enemy_origin.y, enemy_origin.z = entity.get_prop(enemy_player, "m_vecOrigin")
		distance_value = GetDistanceInMeter(local_player_origin.x, local_player_origin.y, local_player_origin.z, enemy_origin.x, enemy_origin.y, enemy_origin.z)
		override_damage_smart_x1 = entity.get_prop(enemy_player, "m_iHealth") + 1 > ui.get(active[weapons_active_idx]["damage_override_1"]) and entity.get_prop(enemy_player, "m_iHealth") + 1 < ui.get(active[weapons_active_idx]["damage_override_2"]) and entity.get_prop(enemy_player, "m_iHealth") + 1 < ui.get(active[weapons_active_idx]["damage_override_3"])
		override_damage_smart_x2 = entity.get_prop(enemy_player, "m_iHealth") + 1 > ui.get(active[weapons_active_idx]["damage_override_2"]) and entity.get_prop(enemy_player, "m_iHealth") + 1 < ui.get(active[weapons_active_idx]["damage_override_3"])
		ui.set(based_override_damage, (override_damage_smart_x1 == true or override_damage_smart_x2 == true) and true or false)
		if has_value(ui.get(weapon_indicator), "Distance") and entity.is_alive(enemy_player) and enemy_player and entity.is_alive(local_player) and ui.get(syr_active) then
			local get_x, get_y = entity.get_bounding_box(enemy_player)
			local get_x = get_x == nil and 0 or get_x local get_y = get_y == nil and 0 or get_y
			renderer.text(get_x + 45, get_y + 5, 255, 255, 255, entity.is_alive(enemy_player) and 255 or 0, "c", 0, distance_value .. "/M")
		end

		if has_value(ui.get(weapon_indicator), "Resolver Angles") and entity.is_alive(enemy_player) and enemy_player and entity.is_alive(local_player) and ui.get(syr_active) then
			local enemy_desync_angles = plist.get(enemy_player, "Correction active") and max_desync(enemy_player) or 0
			local get_x, get_y = entity.get_bounding_box(enemy_player)
			local get_x = get_x == nil and 0 or get_x local get_y = get_y == nil and 0 or get_y
			renderer.text(get_x + 45, get_y + 15, 255, 255, 255, entity.is_alive(enemy_player) and 255 or 0, "c", 0, ui.get(resolver) and string.format("%.f", enemy_desync_angles)  .. "/DSY" or "0" .. "/DSY")
		end

		if plist.get(enemy_player, "Override prefer body aim") == "Off" and plist.get(enemy_player, "Override safe point") == "-" or plist.get(enemy_player, "Override prefer body aim") == "Off" and plist.get(enemy_player, "Override safe point") == "Off" then
			player_resolver_flags = "HEAD"	
		elseif plist.get(enemy_player, "Override prefer body aim") == "On" and plist.get(enemy_player, "Override safe point") == "-" or plist.get(enemy_player, "Override prefer body aim") == "On" and plist.get(enemy_player, "Override safe point") == "Off" then
			player_resolver_flags = "PREFER"	
		elseif plist.get(enemy_player, "Override prefer body aim") == "Force" and plist.get(enemy_player, "Override safe point") == "-" or plist.get(enemy_player, "Override prefer body aim") == "Force" and plist.get(enemy_player, "Override safe point") == "Off" then
			player_resolver_flags = "FORCE"
		elseif plist.get(enemy_player, "Override safe point") == "On" then
			player_resolver_flags = "SAFETY"
		else
			player_resolver_flags = not ui.get(active[weapons_active_idx]["lua_prediction_baim"]) and "DEFAULT" or player_will_peek() == true and "DEFAULT" or "PREDICT"
		end

		if enemy_player >= 1 and headaim_check then
			renderer.text(x_4 + 10, y_4 + 5 + (i * 10), 255, 155, 155, 180, "", 0, "0")
			renderer.text(x_4 + 25, y_4 + 5 + (i * 10), 255, 155, 155, 180, "", 0, "Target: ")
			renderer.text(x_4 + 65, y_4 + 5 + (i * 10), 215, 155, 155, 210, "", 0, entity.get_player_name(enemy_player))
			renderer.text(x_4 + 148, y_4 + 5 + (i * 10), 0, 255, 0, 255, "", 0, "● ")
			renderer.text(x_4 + 156, y_4 + 5 + (i * 10), 255, 155, 155, 180, "", 0, player_resolver_flags)
		end
	end

	local enemy_origin = {x, y, z}
	local local_player_origin = {x, y, z}
	local inair_flags_override = entity.get_prop(entity.get_local_player(), "m_fFlags") == 256 or entity.get_prop(entity.get_local_player(), "m_fFlags") == 262
	local distance_value = #enemy_players == 0 and 0 or distance_value
	local override_damage_smart_x1 = override_damage_smart_x1
	local override_damage_smart_x2 = override_damage_smart_x2
	enemy_origin.x, enemy_origin.y, enemy_origin.z = enemy_origin.x, enemy_origin.y, enemy_origin.z
	local_player_origin.x, local_player_origin.y, local_player_origin.z = local_player_origin.x, local_player_origin.y, local_player_origin.z
	if not local_player or not entity.is_alive(local_player) or not ui.get(syr_active) then
		return
	end

	local active_weapon = entity.get_prop(local_player, "m_hActiveWeapon")
	if active_weapon == nil then
		return
	end

	local weapon_real_active = entity.get_prop(active_weapon, "m_iItemDefinitionIndex")
	if weapon_real_active == nil then
		return
	end

	local active_weapons_coder = bit.band(weapon_real_active, 0xFFFF)
	if active_weapons_coder == 11 or active_weapons_coder == 38 then
		syr_active_weapons = "Auto"
		weapons_active_idx = 1
	elseif active_weapons_coder == 9 then
		syr_active_weapons = "AWP"
		weapons_active_idx = 2
	elseif active_weapons_coder == 40 then
		syr_active_weapons = "Scout"
		weapons_active_idx = 3
	elseif active_weapons_coder == 2 or active_weapons_coder == 3 or active_weapons_coder == 4 or active_weapons_coder == 30 or active_weapons_coder == 32 or active_weapons_coder == 36 or active_weapons_coder == 61 or active_weapons_coder == 63 then
		syr_active_weapons = "Pistol"
		weapons_active_idx = 4
	elseif active_weapons_coder == 7 or active_weapons_coder == 8  or active_weapons_coder == 10 or active_weapons_coder == 13 or active_weapons_coder == 16 or active_weapons_coder == 39 then
		syr_active_weapons = "Rifle"
		weapons_active_idx = 5
	elseif active_weapons_coder == 17 or active_weapons_coder == 19  or active_weapons_coder == 23 or active_weapons_coder == 24 or active_weapons_coder == 26 or active_weapons_coder == 33 or active_weapons_coder == 34 then
		syr_active_weapons = "SMG"
		weapons_active_idx = 6
	elseif active_weapons_coder == 64 then
		syr_active_weapons = "R8 Revolver"
		weapons_active_idx = 7
	elseif active_weapons_coder == 1 then
		syr_active_weapons = "Eagle"
		weapons_active_idx = 8
	elseif active_weapons_coder == 14 or active_weapons_coder == 28 then
		syr_active_weapons = "Heavy"
		weapons_active_idx = 9
	elseif active_weapons_coder == 31 then
		syr_active_weapons = "Taser Zeus"
		weapons_active_idx = 11
	else
		syr_active_weapons = "Other"
		weapons_active_idx = 10
	end

	weapons_active_idx = (weapons_active_idx ~= 12 and ui.get(active[weapons_active_idx]["global_enabled_config"])) and weapons_active_idx or 12
	syr_active_weapons = (weapons_active_idx ~= 12 and ui.get(active[weapons_active_idx]["global_enabled_config"])) and syr_active_weapons or "Global"
	local switch_active_name = entity.get_player_weapon(local_player)
	local switch_active_weapons = bit.band(entity.get_prop(switch_active_name, "m_iItemDefinitionIndex"), 0xFFFF)
	if ui.get(active_on_switch) then
		if last_weapon ~= switch_active_weapons then
			ui.set(weapons_acitve_visible, syr_active_weapons)
			last_weapon = switch_active_weapons
		end
	end

	bind_system:update()
	local dt_flags_on_grenade = false
	local damage_status = damage_status
	local hitchance_status = hitchance_status
	local syr_active_weapons = syr_active_weapons
	local weapons_csgo_coder_name = entity.get_classname(entity.get_player_weapon(entity.get_local_player()))
	local no_scope_active_weapon = has_value(ui.get(disabled_scope_hitchance), syr_active_weapons) and true or false
	local is_other_weapons = weapons_csgo_coder_name == "CHEGrenade" or weapons_csgo_coder_name == "CSmokeGreade" or weapons_csgo_coder_name == "CIncendiaryGrenade" or weapons_csgo_coder_name == "CFlashbang" or weapons_csgo_coder_name == "CDecoyGrenade" or weapons_csgo_coder_name == "CC4" or weapons_csgo_coder_name == "CKnife"
	if ui.get(disabled_de_on_greaner) and is_other_weapons then
		ui.set(double_check, false)
		dt_flags_on_grenade = true
	end

	local world_distance = adaptive_distance(e)
	local dt_adaptive_hitchance = ui.get(active[weapons_active_idx]["dt_hitchance"])
	if world_distance ~= nil and ui.get(enabled_adaptive_hitchance) and weapons_active_idx == 1 then
		if world_distance <= 40 then
			dt_adaptive_hitchance = 1
		elseif world_distance >= 200 then
			dt_adaptive_hitchance = 61
		elseif world_distance >= 41 and world_distance <= 199 then
			dt_adaptive_hitchance = 1 + (world_distance - 1) / 160 * 59
		end
	end

	local speicher_hitchance = false
	local scoped_hitchance = entity.get_prop(local_player, "m_bIsScoped") == 0 and true or false
	local multi_visible_damage = #enemy_players == 0 and false or has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Visible Damage") and syr_weapon_visible == true
	local set_dormant_damage = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Dormant damage")
	local set_dormant_alpha = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Dormant alpha")
	local override_damage_x1 = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X1") and ui.get(override_damage_key_1) or has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X1") and ui.get(manual_state) == 1
	local override_damage_x2 = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X2") and ui.get(override_damage_key_2) or has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X2") and ui.get(manual_state) == 2
	local override_damage_x3 = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X3") and ui.get(override_damage_key_3) or has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X3") and ui.get(manual_state) == 3
	local multi_override_damage = override_damage_x1 or override_damage_x2 or override_damage_x3
	local multi_override_hitbox = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Hitbox") and ui.get(override_hitbox_key)
	local multi_visible_hitchance = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Visible Hitchance") and syr_weapon_visible == true
	local multi_override_hitchance = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Hitchance") and ui.get(override_hitchance_key)
	local multi_noscope_hitchance = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "NoScope Hitchance") and scoped_hitchance
	local override_dmg_system = ui.get(active[weapons_active_idx]["adaptive_damage_override"]) and ui.get(based_override_damage) or multi_override_damage
	local distance_override_status = #enemy_players <= 0 and false or distance_value <= ui.get(active[weapons_active_idx]["enemy_distance"]) and true or false
	local automatic_override_1 = ui.get(active[weapons_active_idx]["adaptive_damage_override"]) and ui.get(based_override_damage) and override_damage_smart_x1
	local automatic_override_2 = ui.get(active[weapons_active_idx]["adaptive_damage_override"]) and ui.get(based_override_damage) and override_damage_smart_x2
	local global_check_condition = (has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Check DT(D & H & M) Condition") and ui.get(double_check) and ui.get(double_key)) and "DT" or (has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Check Hide Shot(D & H & M) Condition") and ui.get(hide_check) and ui.get(hide_key)) and "Hide Shot" or "Default"
	if not has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X1") and not has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X2") and not has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override Damage /X3") then
		ui.set(manual_state, 0)
	end

	if set_dormant_damage then 
		ui.set(dormant_min_damage,ui.get(active[weapons_active_idx]["damage_dormant"]))
	end

	if set_dormant_alpha then
		ui.set(dormant_alpha,ui.get(active[weapons_active_idx]["alpha_dormant"]))
	end

	if ui.get(manual_state) == 1 or automatic_override_1 then
		override_damage_types = ui.get(active[weapons_active_idx]["damage_override_1"])
		override_damage_flags = "X1 Ove"
	elseif ui.get(manual_state) == 2 or automatic_override_2 then
		override_damage_types = ui.get(active[weapons_active_idx]["damage_override_2"])
		override_damage_flags = "X2 Ove"
	elseif ui.get(manual_state) == 3 then
		override_damage_types = ui.get(active[weapons_active_idx]["damage_override_3"])
		override_damage_flags = "X3 Ove"
	end

local screen_x, screen_y = client.screen_size()
	local real_x, real_y = screen_x * 0.5, screen_y * 0.5
	if ui.get(manual_state) ~= 0 then
		renderer.text(real_x + 15, real_y + 15, 255, 255, 255, 255, "cb", 0, ui.get(min_dmg))
	end

	if not multi_noscope_hitchance or not no_scope_active_weapon then
		speicher_hitchance = false
		lua_hitchance = multi_override_hitchance and ui.get(active[weapons_active_idx]["override_hitchance"]) or multi_visible_hitchance == false and ui.get(active[weapons_active_idx]["hitchance"]) or ui.get(active[weapons_active_idx]["vis_hitchance"])
		hitchance_status = multi_override_hitchance and "Ove" or multi_visible_hitchance == false and "Def" or"Vis"
	elseif multi_noscope_hitchance and no_scope_active_weapon then
		speicher_hitchance = true
		lua_hitchance = multi_override_hitchance and ui.get(active[weapons_active_idx]["override_hitchance"]) or ui.get(active[weapons_active_idx]["noscope_hitchance"])
		hitchance_status = multi_override_hitchance and "Ove" or "Nsp"
	end

	local vx, vy, vz = entity.get_prop(local_player, "m_vecVelocity")
	local velocity_speed = math.sqrt((vx * vx) + (vy * vy))
	if ui.get(active[weapons_active_idx]["dynamic_types"]) == "Based Distance" then
		local lua_multipoint_first_ref = 35 * distance_value / 30
		lua_multipoint_score_ref = math.max(56, 91 - lua_multipoint_first_ref) >= 91 and 91 or math.max(56, 91 - lua_multipoint_first_ref)
	elseif ui.get(active[weapons_active_idx]["dynamic_types"]) == "Based Velocity" then
		local lua_multipoint_first_ref = 35 * velocity_speed / 160
		lua_multipoint_score_ref = math.max(56, 91 - lua_multipoint_first_ref) >= 91 and 91 or math.max(56, 91 - lua_multipoint_first_ref)
	elseif ui.get(active[weapons_active_idx]["dynamic_types"]) == "Advanced Adaptive" then
		if distance_value <= 5 then
			local lua_multipoint_first_ref = 30 * distance_value / 5
			lua_multipoint_score_ref = math.max(56, 91 - lua_multipoint_first_ref) >= 91 and 91 or math.max(56, 91 - lua_multipoint_first_ref)
		elseif distance_value >= 6 then
			local lua_multipoint_first_ref = math.min(56, ui.get(active[weapons_active_idx]["mp_scale"])) * velocity_speed / 150
			lua_multipoint_score_ref = math.max(56, 91 - lua_multipoint_first_ref) >= 91 and 91 or math.max(56, 91 - lua_multipoint_first_ref)
		end
	end

	local lua_mp_hitbox = ui.get(active[weapons_active_idx]["mp_hitbox"])
	local lua_hitbox_ref = (ui.get(double_check) and ui.get(double_key)) and ui.get(active[weapons_active_idx]["dt_hitbox"]) or ui.get(active[weapons_active_idx]["target_hitbox"])
	local targets_selects = ui.get(active[weapons_active_idx]["target_select"])
	local multi_mode_select = ui.get(active[weapons_active_idx]["mp_modes"])
	local lua_prefer_safe_condition = ui.get(active[weapons_active_idx]["prefer_safe"])
	local override_unsafe_hitbox = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Override UnSafety Hitbox") and ui.get(override_unsafehitbox_key)
	local lua_multipoint_scale = ui.get(active[weapons_active_idx]["dynamic_mp"]) and lua_multipoint_score_ref or ui.get(active[weapons_active_idx]["mp_scale"])
	local lua_hitbox = multi_override_hitbox and ui.get(active[weapons_active_idx]["hitbox_override"]) or lua_hitbox_ref
	if inair_flags_override == false and distance_override_status == false then
		targets_selects = ui.get(active[weapons_active_idx]["target_select"])
		if global_check_condition == "Default" then
			lua_damage = override_dmg_system and override_damage_types or multi_visible_damage == false and ui.get(active[weapons_active_idx]["damage_wall"]) or ui.get(active[weapons_active_idx]["damage_visible"])
			damage_status = override_dmg_system and override_damage_flags or multi_visible_damage == false and "Def" or "Vis"
			multi_mode_select = ui.get(active[weapons_active_idx]["mp_modes"])
			lua_multipoint_scale = ui.get(active[weapons_active_idx]["dynamic_mp"]) and lua_multipoint_score_ref or ui.get(active[weapons_active_idx]["mp_scale"])
		elseif global_check_condition == "DT" then
			lua_damage = syr_weapon_visible and ui.get(active[weapons_active_idx]["dt_damage_visible"]) or ui.get(active[weapons_active_idx]["dt_damage_wall"])
			damage_status = syr_weapon_visible and "DT[Vis]" or "DT[Def]"
			multi_mode_select = ui.get(active[weapons_active_idx]["dt_mp_modes"])
			lua_multipoint_scale = ui.get(active[weapons_active_idx]["dt_mp_scale"])
			lua_hitchance = (ui.get(override_hitchance_key) and ui.get(active[weapons_active_idx]["dt_override_hitchance"])) or speicher_hitchance and ui.get(active[weapons_active_idx]["dt_noscope_hitchance"]) or (syr_weapon_visible and ui.get(active[weapons_active_idx]["dt_vis_hitchance"]) or ui.get(active[weapons_active_idx]["dt_wall_hitchance"]))
			hitchance_status = ui.get(override_hitchance_key) and "DT[Ove]" or speicher_hitchance and "DT[Nos]" or (syr_weapon_visible and "DT[Vis]" or "DT[Wall]")
			lua_mp_hitbox = ui.get(active[weapons_active_idx]["dt_mp_hitbox"])
			lua_prefer_safe_condition = ui.get(active[weapons_active_idx]["dt_prefer_safe"])
		elseif global_check_condition == "Hide Shot" then
			lua_damage = syr_weapon_visible and ui.get(active[weapons_active_idx]["hide_damage_visible"]) or ui.get(active[weapons_active_idx]["hide_damage_wall"])
			damage_status = syr_weapon_visible and "Hide[Vis]" or "Hide[Def]"
			multi_mode_select = ui.get(active[weapons_active_idx]["hide_mp_modes"])
			lua_multipoint_scale = ui.get(active[weapons_active_idx]["hide_mp_scale"])
			lua_hitchance = (ui.get(override_hitchance_key) and ui.get(active[weapons_active_idx]["hide_override_hitchance"])) or speicher_hitchance and ui.get(active[weapons_active_idx]["hide_noscope_hitchance"]) or (syr_weapon_visible and ui.get(active[weapons_active_idx]["hide_vis_hitchance"]) or ui.get(active[weapons_active_idx]["hide_wall_hitchance"]))
			hitchance_status = ui.get(override_hitchance_key) and "Hide[Ove]" or speicher_hitchance and "Hide[Nos]" or (syr_weapon_visible and "Hide[Vis]" or "Hide[Wall]")
			lua_mp_hitbox = ui.get(active[weapons_active_idx]["hide_mp_hitbox"])
			lua_prefer_safe_condition = ui.get(active[weapons_active_idx]["hide_prefer_safe"])
		end

	elseif distance_override_status == true and inair_flags_override == false and ui.get(active[weapons_active_idx]["enabled_dis_status"]) and #enemy_players >= 1 then
		targets_selects = ui.get(active[weapons_active_idx]["target_select_dis"])
		lua_mp_hitbox = ui.get(active[weapons_active_idx]["mp_hitbox_distance"])
		lua_damage = override_dmg_system and override_damage_types or ui.get(active[weapons_active_idx]["damage_distance"])
		damage_status = override_dmg_system and override_damage_flags or "Dis"
		lua_hitbox = multi_override_hitbox and ui.get(active[weapons_active_idx]["hitbox_override"]) or ui.get(active[weapons_active_idx]["target_hitbox_distance"])
		lua_hitchance = multi_override_hitchance and ui.get(active[weapons_active_idx]["override_hitchance"]) or ui.get(active[weapons_active_idx]["hitchance_distance"])
		hitchance_status = multi_override_hitchance and "Ove" or "Dis"
		lua_multipoint_scale = ui.get(active[weapons_active_idx]["mp_scale_dis"])
		multi_mode_select = ui.get(active[weapons_active_idx]["mp_modes_dis"])
	elseif inair_flags_override == true and ui.get(active[weapons_active_idx]["enabled_air_status"]) then
		targets_selects = ui.get(active[weapons_active_idx]["target_select_air"])
		lua_mp_hitbox = ui.get(active[weapons_active_idx]["mp_hitbox_air"])
		lua_damage = override_dmg_system and override_damage_types or ui.get(active[weapons_active_idx]["damage_air"])
		damage_status = override_dmg_system and override_damage_flags or "Air"
		lua_hitbox = multi_override_hitbox and ui.get(active[weapons_active_idx]["hitbox_override"]) or ui.get(active[weapons_active_idx]["target_hitbox_air"])
		lua_hitchance = multi_override_hitchance and ui.get(active[weapons_active_idx]["override_hitchance"]) or ui.get(active[weapons_active_idx]["hitchance_air"])
		hitchance_status = multi_override_hitchance and "Ove" or "Air"
		lua_multipoint_scale = ui.get(active[weapons_active_idx]["mp_scale_air"])
		multi_mode_select = ui.get(active[weapons_active_idx]["mp_modes_air"])
	end

	ui.set(min_htc, lua_hitchance)
	ui.set(min_dmg, lua_damage)
	ui.set(multi_hitbox, lua_mp_hitbox)
	ui.set(target_select, targets_selects)
	ui.set(multi_scale, ui.get(override_multipoint_key) and ui.get(active[weapons_active_idx]["mp_scale_ove"]) or lua_multipoint_scale)
	ui.set(multi_modes, multi_mode_select)
	ui.set(prefer_safe, lua_prefer_safe_condition)
	ui.set(indicator, ui.get(lua_headbaim_indicator))
	ui.set(target_hitbox_ref, (lua_hitbox == nil or ui.get(forcehead_key)) and "Head" or lua_hitbox)
	ui.set(force_safe, ui.get(active[weapons_active_idx]["force_safe"]))
	ui.set(low_fps, ui.get(active[weapons_active_idx]["fps_disable"]))
	ui.set(delay_shot, ui.get(active[weapons_active_idx]["delay_shot"]))
	ui.set(auto_scope, ui.get(active[weapons_active_idx]["auto_scope"]))
	ui.set(quick_mode, ui.get(active[weapons_active_idx]["stop_select"]))
	ui.set(prefer_baim, ui.get(active[weapons_active_idx]["prefer_baim"]))
	ui.set(options, ui.get(active[weapons_active_idx]["lua_prefer_baim"]))
	ui.set(force_options, ui.get(active[weapons_active_idx]["lua_force_baim"]))
	ui.set(safe_options, ui.get(active[weapons_active_idx]["lua_force_safe"]))
	ui.set(ref_desync, ui.get(active[weapons_active_idx]["lua_desync_limit"]))
	ui.set(range_slider, ui.get(active[weapons_active_idx]["lua_range"]))
	ui.set(ref_hp_slider, ui.get(active[weapons_active_idx]["lua_min_hp"]))
	ui.set(accuracy_mode, ui.get(active[weapons_active_idx]["accuracy_modes"]))
	ui.set(reset_hotkey, ui.get(resert_attack_key) and "Always on" or "On hotkey")
	ui.set(headaim_options, ui.get(active[weapons_active_idx]["lua_prefer_head"]))
	ui.set(jitter_sensitivity, ui.get(active[weapons_active_idx]["lua_jitter_sensitivity"]))
	ui.set(prefer_baim_disabled, ui.get(active[weapons_active_idx]["baim_disable"]))
	ui.set(predictive_baim, ui.get(active[weapons_active_idx]["lua_prediction_baim"]))
	ui.set(force_peek_baim, ui.get(active[weapons_active_idx]["enabled_peek_baim"]))
	ui.set(smart_footaim, ui.get(active[weapons_active_idx]["enabled_smart_footaim"]))
	ui.set(active_config_label, "Active Weapon Config Name: ".. syr_active_weapons)
	ui.set(force_safe_hitbox, override_unsafe_hitbox and ui.get(active[weapons_active_idx]["unsafe_hitbox_ove"]) or ui.get(active[weapons_active_idx]["unsafe_hitbox"]))
	if not ui.get(syr_active) or not ui.get(lua_resolver) then
		client.update_player_list()
		local targets_players = entity.get_players(true)
		for i = 1, #targets_players do
			local enemy_targets = targets_players[i]
			plist.set(enemy_targets, "Force body yaw", false)
			plist.set(enemy_targets, "Force body yaw value", 0)
		end
	end

	if has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Customized Double Tap") and not dt_flags_on_grenade then
		ui.set(double_tap_htc, dt_adaptive_hitchance)
		ui.set(double_tap_fl, ui.get(active[weapons_active_idx]["dt_fakelag"]))
		ui.set(double_tap_types, ui.get(active[weapons_active_idx]["dt_types"]))
		ui.set(double_check, ui.get(active[weapons_active_idx]["dt_enabled"]))
		ui.set(double_tap_stop, ui.get(active[weapons_active_idx]["dt_stop"]))
	end

	if ui.get(active[weapons_active_idx]["lua_auto_stop"]) then
		ui.set(slow_key, player_will_peek() and "Always on" or "On hotkey")
		setSpeed(player_will_peek() and 250 * ui.get(active[weapons_active_idx]["lua_auto_stop_speed"]) / 100 or 450)
	elseif not ui.get(active[weapons_active_idx]["lua_auto_stop"]) then
		setSpeed(450)
		ui.set(slow_key, "On hotkey")
	end

	local weapon_r, weapon_g, weapon_b, weapon_a = ui.get(global_c)
	if has_value(ui.get(weapon_indicator),"Damage Override") and override_dmg_system then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "Damage Override")
	end

	if has_value(ui.get(weapon_indicator), "Hitbox Override") and multi_override_hitbox then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "Hitbox Override")
	end

	if has_value(ui.get(weapon_indicator), "Hitchance Override") and multi_override_hitchance then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "Hitchance Override")
	end

	if has_value(ui.get(weapon_indicator), "MultiPoint Override") and ui.get(override_multipoint_key) then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "MultiPoint Override")
	end

	if has_value(ui.get(weapon_indicator), "AvoidHitbox Override") and override_unsafe_hitbox then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "AvoidHitbox Override")
	end

	if has_value(ui.get(weapon_indicator), "Active Weapons") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "Weapon: ".. syr_active_weapons)
	end

	if has_value(ui.get(weapon_indicator), "D & H") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "D: " ..damage_status .. " & H: " ..hitchance_status)
	end

	if has_value(ui.get(weapon_indicator), "Damage Value") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "DMG-> ", ui.get(min_dmg))
	end

	if has_value(ui.get(weapon_indicator), "Hitchance Value") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "HTC-> ", ui.get(min_htc))
	end

	if has_value(ui.get(weapon_indicator), "Active Boxer") then
		local indicators = {}
		if has_value(ui.get(keybinds_listbox), "Damage Override") and override_dmg_system then
			indicators[#indicators + 1] = override_damage_flags == nil and "Damage Override [Disabled]" or "Damage Override " .. "[" .. override_damage_flags .. "]"
		end

		if has_value(ui.get(keybinds_listbox), "Hitbox Override") and multi_override_hitbox then
			indicators[#indicators + 1] = "Hitbox Override"
		end

		if has_value(ui.get(keybinds_listbox), "Hitchance Override") and multi_override_hitchance then
			indicators[#indicators + 1] = "Hitchance Override"
		end

		if has_value(ui.get(keybinds_listbox), "MultiPoint Override") and ui.get(override_multipoint_key) then
			indicators[#indicators + 1] = "MultiPoint Override"
		end

		if has_value(ui.get(keybinds_listbox), "AvoidHitbox Override") and override_unsafe_hitbox then
			indicators[#indicators + 1] = "AvoidHitbox Override"
		end

		local real_x, real_y =  hk_dragger:get()
		local steamid_64 = entity.get_steam64(local_player)
		local steam_avatar = images.get_steam_avatar(steamid_64)
		local active_weapon = entity.get_player_weapon(local_player) == nil and 1 or entity.get_player_weapon(local_player)
		local weapon = csgo_weapons[entity.get_prop(active_weapon, "m_iItemDefinitionIndex")]
		local weapon_icon = images.get_weapon_icon(weapon)
		renderer.rectangle(real_x, real_y, 155, 25, 20, 20, 20, 150)
		renderer.rectangle(real_x, real_y, 155, 2, weapon_r, weapon_g, weapon_b, weapon_a)
		renderer.text(real_x + 80, real_y + 13, 255, 255, 255, 255, "c", 0, "Active Weapon")
		weapon_icon:draw(real_x + 25, real_y + 28, nil, 22)
		steam_avatar:draw(real_x, real_y + 30, nil, 18)
		renderer.text(real_x + 110, real_y + 25, 255, 255, 255, 255, "", 0, "HTC: " .. ui.get(min_htc))
		renderer.text(real_x + 110, real_y + 38, 255, 255, 255, 255, "", 0, "DMG: " .. ui.get(min_dmg))
		if #indicators > 0 then
			for i = 1, #indicators do
				renderer.text(real_x + 75, real_y + (13.5 * i) + 45, 255, 255, 255, 255, "c", 0, indicators[i])
			end
		end

		hk_dragger:drag(140, 25)
	end

	if has_value(ui.get(weapon_indicator), "Min Damage") then
		if damage_status == "Def" then
			client.draw_indicator(ctx, 102, 255, 102, 255, #enemy_players <= 0 and "Min Damage: Loader" or "Min Damage: " .. ui.get(min_dmg))
		elseif damage_status == "Vis" then
			client.draw_indicator(ctx, 50, 255, 200, 255, #enemy_players <= 0 and "Min Damage: Loader" or "Min Damage: " .. ui.get(min_dmg))
		elseif damage_status == "X1 Ove" or damage_status == "X2 Ove" or damage_status == "X3 Ove" then
			client.draw_indicator(ctx, 255, 155, 255, 255, #enemy_players <= 0 and "Min Damage: Loader" or "Min Damage: " .. ui.get(min_dmg))
		elseif damage_status == "Dis" or damage_status == "Air" then
			client.draw_indicator(ctx, 255, 235, 170, 255, #enemy_players <= 0 and "Min Damage: Loader" or "Min Damage: " .. ui.get(min_dmg))
		else
			client.draw_indicator(ctx, 102, 255, 102, 255, #enemy_players <= 0 and "Min Damage: Loader" or "Min Damage: " .. ui.get(min_dmg))
		end
	end

	get_fixer_active_index = function(e)
		return weapons_active_idx
	end
end

client.set_event_callback("paint", syr_weapons_name)

client.set_event_callback("aim_miss", function(e)
	client.update_player_list()
	local targets_players = entity.get_players(true)
	if not ui.get(syr_active) or not ui.get(lua_resolver) or not entity.is_alive(entity.get_local_player()) or #targets_players == 0 then
		for i = 1, #targets_players do
			local enemy_targets = targets_players[i]
			plist.set(enemy_targets, "Force body yaw", false)
			plist.set(enemy_targets, "Force body yaw value", 0)
		end

		return
	end

	if ui.get(lua_resolver_types) == "Adversary Prediction" then
		client.update_player_list()
		local ent = e.target
		local reason = e.reason
		local hc = e.hit_chance 
		if not ent or reason == "?" or hc < 95 then
			return
		end

		if data[ent] == nil then
			data[ent] = {misses = 0, yaw = nil}
		end

		local entity_data = data[ent] or {misses = 0, yaw = nil}
		local lby_yaw = math.floor(entity.get_prop(ent, "m_flPoseParameter", 11) * 120 - 60 )
		local _misses = entity_data.misses or 0
		ui.set(ref_plist, ent)
		local flags = entity.get_prop()
		entity_data.misses = _misses + 1
		if _misses < 1 then
			entity_data.yaw = lby_yaw
			if ui.get(lua_resolver_logs) then
				client.log("Resolver Correction Overlord: Cached Angles")
			end
		end

		local angle = angle_to_resolve(entity_data.yaw, entity_data.misses)
		ui.set(ref_resolver_byaw, true)
		ui.set(ref_resolver_byaw_val, angle)
		local sx, sy = client.screen_size()
		local text = "Overlord: Correcting " .. entity.get_player_name(e.target) .. " For " .. angle .. " Degrees."
		notify(sx, sy - 100 - #notifications * 50, 5, 255, 0, 0, 255, text)
		client.delay_call(10, function(ent)
			if ui.get(lua_resolver_logs) then
				client.log("Resolver Anti-Aim Correction Data Reset")
			end

			data[ent] = {}
				ui.set(ref_plist, ent)
				ui.set(ref_resolver_byaw, false)
				ui.set(ref_resolver_byaw_val, 0)
			end,
		ent)

	elseif ui.get(lua_resolver_types) == "Adversary Random" then
		if ui.get(lua_resolver_logs) then
			client.log("Resolver Correction Overlord: Cached Angles")
		end

		local vx, vy, vz = entity.get_prop(e.target, "m_vecVelocity")
		local target_velocity_speed = math.sqrt((vx * vx) + (vy * vy))
		if target_velocity_speed <= 5 then
			local resolver_angles_list = {[1] = - 56, [2] = 0, [3] = 56}
			ui.set(ref_resolver_byaw, true)
			ui.set(ref_resolver_byaw_val, resolver_angles_list[math.random(1, 3)])
		elseif target_velocity_speed > 5 and target_velocity_speed <= 50 then
			local resolver_angles_list = {[1] = - 38, [2] = 0, [3] = 38}
			ui.set(ref_resolver_byaw, true)
			ui.set(ref_resolver_byaw_val, resolver_angles_list[math.random(1, 3)])
		elseif target_velocity_speed > 50 and target_velocity_speed <= 100 then
			local resolver_angles_list = {[1] = - 34, [2] = 0, [3] = 34}
			ui.set(ref_resolver_byaw, true)
			ui.set(ref_resolver_byaw_val, resolver_angles_list[math.random(1, 3)])
		elseif target_velocity_speed > 100 and target_velocity_speed <= 150 then
			local resolver_angles_list = {[1] = - 31, [2] = 0, [3] = 31}
			ui.set(ref_resolver_byaw, true)
			ui.set(ref_resolver_byaw_val, resolver_angles_list[math.random(1, 3)])
		elseif target_velocity_speed > 150 and target_velocity_speed <= 200 then
			local resolver_angles_list = {[1] = - 28, [2] = 0, [3] = 28}
			ui.set(ref_resolver_byaw, true)
			ui.set(ref_resolver_byaw_val, resolver_angles_list[math.random(1, 3)])
		elseif target_velocity_speed > 200 then
			local resolver_angles_list = {[1] = math.random(- 14, - 26), [2] = 0, [3] = math.random(14, 26)}
			ui.set(ref_resolver_byaw, true)
			ui.set(ref_resolver_byaw_val, resolver_angles_list[math.random(1, 3)])
		end

		client.delay_call(3, function(r)
			if ui.get(lua_resolver_logs) then
				client.log("Resolver Anti-Aim Correction Data Reset")
			end

			ui.set(ref_resolver_byaw, false)
			ui.set(ref_resolver_byaw_val, 0)
		end)

	elseif ui.get(lua_resolver_types) == "Random Angles" then
		if ui.get(lua_resolver_logs) then
			client.log("Resolver Correction Overlord: Cached Angles")
		end

		local resolver_angles_list = {[1] = - 58, [2] = - 24, [3] = 0, [4] = 24, [5] = 58}
		ui.set(ref_resolver_byaw, true)
		ui.set(ref_resolver_byaw_val, resolver_angles_list[math.random(1, 5)])
		client.delay_call(3, function(r)
			if ui.get(lua_resolver_logs) then
				client.log("Resolver Anti-Aim Correction Data Reset")
			end

			ui.set(ref_resolver_byaw, false)
			ui.set(ref_resolver_byaw_val, 0)
		end)
	end
end)

client.set_event_callback("round_end", function(e)
	if not ui.get(syr_active) or not ui.get(lua_resolver) or not entity.is_alive(entity.get_local_player()) then
		return
	end

	notifications = {}
end)

local function on_aim_fire(e)
	peeks_shots = peeks_shots + 1
end

client.set_event_callback("aim_fire", on_aim_fire)

local function reset_on_peek_death(e)
	if has_value(ui.get(active[weapons_active_idx]["lua_auto_peek_triggers"]), "Kill") and client.userid_to_entindex(e.attacker) == entity.get_local_player() then
		peeks_shots = - 1
	end
end

client.set_event_callback("player_death", reset_on_peek_death)

client.set_event_callback("paint", function(e)
	if not ui.get(syr_active) then
		return
	end

	if not ui.get(active[weapons_active_idx]["lua_auto_peek"]) then
		peeks_shots = 0
		peek_pos_x = nil
		hotkey_prev = false
		restart_auto_peeking_length = 0
		return
	end

	if ui.get(active[weapons_active_idx]["lua_auto_peek"]) and ui.get(auto_peeking_key) then
		restart_auto_peeking_length = restart_auto_peeking_length + ui.get(active[weapons_active_idx]["lua_auto_peek_speed"])
		if restart_auto_peeking_length >= ui.get(active[weapons_active_idx]["lua_auto_peek_length"]) then
			restart_auto_peeking_length = ui.get(active[weapons_active_idx]["lua_auto_peek_length"])
		end

	elseif not ui.get(active[weapons_active_idx]["lua_auto_peek"]) or not ui.get(auto_peeking_key) then
		restart_auto_peeking_length = restart_auto_peeking_length - ui.get(active[weapons_active_idx]["lua_auto_peek_speed"])
		if restart_auto_peeking_length <= 0 then
			restart_auto_peeking_length = 0
		end
	end

	local auto_peeking_is_enabled = restart_auto_peeking_length ~= 0 and peek_pos_x ~= nil and entity.is_alive(entity.get_local_player())
	if ui.get(active[weapons_active_idx]["lua_auto_peek"]) and ui.get(auto_peeking_key) then
		ui.set(auto_peeking, false)
	elseif not ui.get(active[weapons_active_idx]["lua_auto_peek"]) or not ui.get(auto_peeking_key) then
		ui.set(auto_peeking, ui.get(active[weapons_active_idx]["faster_peeking"]))
	end

	if quickstop_allowed or not auto_peeking_is_enabled then
		if quickstop_prev ~= nil then
			ui.set(quick_stop, ui.get(active[weapons_active_idx]["quick_stop"]))
			quickstop_prev = nil
		end

		quickstop_allowed = nil
	end

	if not auto_peeking_is_enabled then
		return
	end

	local wx, wy = renderer.world_to_screen(peek_pos_x, peek_pos_y, peek_pos_z)
	if wx ~= nil then
		local weapon_r, weapon_g, weapon_b, weapon_a = ui.get(global_c)
		draw_circle_3d(peek_pos_x, peek_pos_y, peek_pos_z, restart_auto_peeking_length, weapon_r, weapon_g, weapon_b, weapon_a, 3, 2, false, 0, 1, weapon_r, weapon_g, weapon_b, weapon_a * 0.5)
	end
end)

local function auto_peek_run_command(cmd)
	if not ui.get(syr_active) or not ui.get(active[weapons_active_idx]["lua_auto_peek"]) then
		return
	end

	if restart_auto_peeking_length ~= 0 then
		local local_player = entity.get_local_player()
		if not hotkey_prev then
			peeks_shots = 0
			peek_pos_x, peek_pos_y, peek_pos_z = entity.get_prop(local_player, "m_vecAbsOrigin")
		end

		if cmd.in_attack == 1 then
			peeks_shots = - 1
		end

		local is_single_fire_weapon = has_value(single_fire_weapons, entity.get_classname(entity.get_player_weapon(local_player)))
		local shots_min = is_single_fire_weapon and 1 or ui.get(active[weapons_active_idx]["lua_auto_peek_shots"])
		local peek_triggers = ui.get(active[weapons_active_idx]["lua_auto_peek_triggers"])
		if has_value(peek_triggers, "Standing Still") then
			if not peek_standing and distance3d(0, 0, 0, entity.get_prop(local_player, "m_vecVelocity")) < 15 then
				peek_standing = true
			elseif cmd.sidemove ~= 0 or cmd.forwardmove ~= 0 then
				peek_standing = false
			end
		else
			peek_standing = false
		end

		if (has_value(peek_triggers, "X Shots") and (peeks_shots >= shots_min or peeks_shots == - 1)) or peek_standing then
			local peeks_x, peeks_y, peeks_z = entity.get_prop(local_player, "m_vecAbsOrigin")
			if 15 > distance3d(peeks_x, peeks_y, peeks_z, peek_pos_x, peek_pos_y, peek_pos_z) then
				peeks_shots = 0
				quickstop_allowed = true
			else
				local require_moving = false
				local player_pitch, player_yaw = vector_angles(peeks_x, peeks_y, peeks_z, peek_pos_x, peek_pos_y, peek_pos_z)
				if not require_moving or cmd.forwardmove ~= 0 or cmd.sidemove ~= 0 then
					cmd.in_forward = 1
					cmd.in_back = 0
					cmd.in_moveleft = 0
					cmd.in_moveright = 0
					cmd.in_speed = 0
					cmd.forwardmove = 450
					cmd.sidemove = 0
					cmd.move_yaw = player_yaw
					if ui.get(quick_stop) then
						quickstop_prev = true
						ui.set(quick_stop, false)
					end
				end
			end
		else
			quickstop_allowed = true
		end
	else
		peeks_shots = 0
		peek_pos_x = nil
	end

	hotkey_prev = restart_auto_peeking_length ~= 0
end

client.set_event_callback("setup_command", auto_peek_run_command)

for i=1, 64 do
	missLogs[i] = 0
end

local function extrapolate_position(xpos,ypos,zpos,ticks,ent)
	x,y,z = entity.get_prop(ent, "m_vecVelocity")
	for i = 0, ticks do
		xpos =  xpos + (x*globals.tickinterval())
		ypos =  ypos + (y*globals.tickinterval())
		zpos =  zpos + (z*globals.tickinterval()  + (9.81 * ((globals.tickinterval())* (globals.tickinterval()) / 2)))
	end

	return xpos,ypos,zpos
end

local function normalise_angle(angle)
	angle =  angle % 360 
	angle = (angle + 360) % 360
	if (angle > 180)  then
		angle = angle - 360
	end

	return angle
end

local function is_moving(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	return math.sqrt(x * x + y * y + z * z) > 1.0
end

local function ent_speed(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	return math.sqrt(x * x + y * y + z * z)
end

local function body_yaw(entityindex)
	bodyyaw = entity.get_prop(entityindex, "m_flPoseParameter", 11)
	if bodyyaw ~= nil then
		bodyyaw = bodyyaw * 120 - 60
	else
		return nil
	end

	return bodyyaw
end

local function get_body_yaw(entityindex)
	_, model_yaw = entity.get_prop(entityindex, "m_angAbsRotation")
	_, eye_yaw = entity.get_prop(entityindex, "m_angEyeAngles")
	return normalise_angle(model_yaw - eye_yaw)
end

local function vec3_normalize(x, y, z)
	local len = math.sqrt(x * x + y * y + z * z)
	if len == 0 then
		return 0, 0, 0
	end
	local r = 1 / len
	return x*r, y*r, z*r
end

local function vec3_dot(ax, ay, az, bx, by, bz)
	return ax*bx + ay*by + az*bz
end

local function angle_to_vec(pitch, yaw)
	local p, y = math.rad(pitch), math.rad(yaw)
	local sp, cp, sy, cy = math.sin(p), math.cos(p), math.sin(y), math.cos(y)
	return cp*cy, cp*sy, -sp
end

local function ent_speed(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	if x == nil then
		return 0
	end

	return math.sqrt(x * x + y * y + z * z)
end

local function get_fov_cos(ent, vx,vy,vz, lx,ly,lz)
	local ox,oy,oz = entity.get_prop(ent, "m_vecOrigin")
	if ox == nil then
		return -1
	end

	local dx,dy,dz = vec3_normalize(ox-lx, oy-ly, oz-lz)
	return vec3_dot(dx,dy,dz, vx,vy,vz)
end

local function vec_length(x,y,z)
	temp = x*x + y*y + z*z 
	if temp < 0 then 
		return 0
	else
		return math.sqrt(temp)
	end
end

local function vec3_normalize(x, y, z)
	local len = math.sqrt(x * x + y * y + z * z)
	if len == 0 then
		return 0, 0, 0
	end

	local r = 1 / len
	return x*r, y*r, z*r
end

local function vec3_dot(ax, ay, az, bx, by, bz)
	return ax*bx + ay*by + az*bz
end

local function angle_to_vec(pitch, yaw)
	local p, y = math.rad(pitch), math.rad(yaw)
	local sp, cp, sy, cy = math.sin(p), math.cos(p), math.sin(y), math.cos(y)
	return cp*cy, cp*sy, -sp
end

local function ent_speed(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	if x == nil then
		return 0
	end

	return math.sqrt(x * x + y * y + z * z)
end


local function get_fov_cos(ent, vx,vy,vz, lx,ly,lz)
	local ox,oy,oz = entity.get_prop(ent, "m_vecOrigin")
	if ox == nil then
		return -1
	end

	local dx,dy,dz = vec3_normalize(ox-lx, oy-ly, oz-lz)
	return vec3_dot(dx,dy,dz, vx,vy,vz)
end

local function vec_length(x,y,z)
	temp = x*x + y*y + z*z 
	if temp < 0 then 
		return 0
	else
		return math.sqrt(temp)
	end
end

local function comp_angle(sx, sy, sz, dsx, dsy, dsz)
	local dx,dy,dz = sx - dsx,sy - dsy,sz - dsz
	local rx,ry,rz = math.asin((dz / vec_length(dx, dy, dz)) * radpi), (math.atan(dy / dx) * radpi) , 0
	if dx > 0.0 then
		ry = ry + 180.0
	end

	return ry
end

local function is_x_shots(local_player, target, shots)
	local px, py, pz = entity.hitbox_position(target, 6)
	local px1, py1, pz1 = entity.hitbox_position(target, 4)
	local px2, py2, pz2 = entity.hitbox_position(target, 2)
	local lx,ly,lz = client.eye_position()
	if is_moving(local_player) and ui.get(predictive_baim) then
		lx,ly,lz = extrapolate_position(lx, ly, lz, 20, local_player)
	end
	
	for i = 0, 2 do
		if i == 0 then
			entindex,dmg = client.trace_bullet(local_player, lx, ly, lz, px, py, pz)
		else 
			if i == 1 then
				entindex,dmg = client.trace_bullet(local_player, lx, ly, lz, px1, py1, pz1)
			else
				entindex,dmg = client.trace_bullet(local_player, lx, ly, lz, px2, py2, pz2)
			end
		end

		if entindex == nil or entindex == local_player or not entity.is_enemy(entindex) then
			return false
		end

		if dmg >= (entity.get_prop(target, "m_iHealth") / shots) then
			return true
		end
	end

	return false
end

local function is_auto_vis(local_player,lx,ly,lz,px,py,pz)
	entindex,dmg = client.trace_bullet(local_player,lx,ly,lz,px,py,pz)
	if entindex == nil then
		return false
	end
	
	if entindex == local_player then
		return false
	end
	
	if not entity.is_enemy(entindex) then
		return false
	end
	
	if dmg >=  5 then
		return true
	else
		return false
	end
end

local function is_damage_vis(local_player,lx,ly,lz,px,py,pz)
	entindex,dmg = client.trace_bullet(local_player,lx,ly,lz,px,py,pz)
	if entindex == nil then
		return false
	end
	
	if entindex == local_player then
		return false
	end
	
	if not entity.is_enemy(entindex) then
		return false
	end
	
	if dmg >=  ui.get(min_dmg) then
		return true
	else
		return false
	end
end

local function trace_positions(local_player,px,py,pz,px1,py1,pz1,lx2,ly2,lz2)
	if is_auto_vis(local_player,lx2,ly2,lz2,px,py,pz) then
		return true
	end

	if is_auto_vis(local_player,lx2,ly2,lz2,px1,py1,pz1) then
		return true
	end

	return false
end

local function is_auto_vis_enemy(enemy,lx,ly,lz,px,py,pz)
	entindex,dmg = client.trace_bullet(enemy,lx,ly,lz,px,py,pz)
	if entindex == nil then
		return false
	end

	if dmg >= 1 then
		return true
	end
	
	return false
end

local function trace_positions_enemy(eyeposx, eyeposy, eyeposz, lpx, lpy, lpz, lpx1, lpy1, lpz1, lpx2, lpy2, lpz2, enemy_index)
	if is_auto_vis_enemy(enemy_index, eyeposx, eyeposy, eyeposz, lpx, lpy, lpz) then
		return true
	end

	if is_auto_vis_enemy(enemy_index, eyeposx, eyeposy, eyeposz, lpx1, lpy1, lpz1) then
		return true
	end

	if is_auto_vis_enemy(enemy_index, eyeposx, eyeposy, eyeposz, lpx2, lpy2, lpz2) then
		return true
	end
	
	return false
end

local function detect_jitter(i)
	local length = #history[i]
	if length == nil then 
		return 
	end
	
	if length < 65 then
		return 
	end

	local count = 0
	for j=(length - 64), length do
		if history[i][j] ~= nil and history[i][j - 1] ~= nil then
			if (history[i][j] > 0 and history[i][j - 1] > 0) or (history[i][j] < 0 and history[i][j - 1] < 0) then
				if math.abs((history[i][j] - history[i][j - 1])) > jitter_delta then
					count = count + 1
				end
			else

				if (history[i][j] > 0 and history[i][j - 1] < 0) or (history[i][j] < 0 and history[i][j - 1] > 0)  then 
					if math.abs((history[i][j] + history[i][j - 1])) > jitter_delta then
						count = count + 1
					end
				end
			end	
		end
	end
	
	if count >= (10 - ui.get(jitter_sensitivity)) then 
		return true
	else
		return false
	end
end

local function hitbox_fast_indicator(c)
	local entindex = entity.get_local_player()
	if not ui.get(syr_active) or not ui.get(indicator) or not entity.is_alive(entindex) then
		return
	end

	local lx, ly, lz = entity.get_prop(entindex, "m_vecOrigin")
	if lx == nil then
		return
	end

	local players = entity.get_players(true)
	local pitch, yaw = client.camera_angles()
	local vx, vy, vz = angle_to_vec(pitch, yaw)
	local closest_fov_cos = -1
	for i=1, #players do
		entindex = players[i]
		local fov_cos = get_fov_cos(entindex, vx,vy,vz, lx,ly,lz)
		if fov_cos > closest_fov_cos then
			closest_fov_cos = fov_cos
			closest_player = entindex
		end
	end

	local local_player = entity.get_local_player()
	if local_player == nil or not entity.is_alive(local_player) then
		return
	end

	local players = entity.get_players(true)
	local weapons_active_idx = get_fixer_active_index() == nil and 12 or get_fixer_active_index()
	if players == nil or not has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Prefer Hitbox Attack Condition") then
		return
	end

	local lx,ly,lz = client.eye_position()
	if lx == nil then
		return
	end
	
	for i=1, #players do
		local player_index = players[i]
		if not entity.is_enemy(player_index) then
			return
		end
		
		local pos_x, pos_y, pos_z = entity.get_prop(player_index, "m_vecAbsOrigin")
		if pos_x == nil then
			return
		end

		local selected = player_preference[player_index]
		local safety_point_ove = player_safe[player_index]
		if safety_point_ove == 1 then
			if selected == "-" then
				selected_text = "DEFAULT"
				r,g,b = ui.get(global_c)
			elseif selected == "Off" then
				selected_text = "HEAD"
				r,g,b = ui.get(head_shoter_c)
			elseif selected == "On" then
				selected_text = "PREFER"
				r,g,b = ui.get(preferbaim_shoter_c)
			elseif selected == "Force" then
				selected_text = "FORCE"
				r,g,b = ui.get(forcebaim_shoter_c)
			end
		end

		local safety_r,safety_g,safety_b = ui.get(forcesafe_shoter_c)
		local x1, y1, x2 , y2 , mult = entity.get_bounding_box(player_index)
		if x1 ~= nil and mult > 0 then
			y1 = y1 - 17
			x1 = x1 + ((x2 - x1) / 2)
			if  y1 ~= nil then
				renderer.text(x1, y1, safety_point_ove == 2 and safety_r or r, safety_point_ove == 2 and safety_g or g, safety_point_ove == 2 and safety_b or b, 255, "cb", 0, safety_point_ove == 2 and "SAFETY" or selected_text)
			end
		end
	end
	
	if ui.get(reset_hotkey) then
		if closest_player ~= 0 then
			missLogs[closest_player] = 0
		end
	end
end

client.set_event_callback("paint", hitbox_fast_indicator)

local function run_command(cmd)
	local local_player = entity.get_local_player()
	if not ui.get(syr_active) or not entity.is_alive(local_player) or not has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Prefer Hitbox Attack Condition") then
		return
	end

	local weapons_active_idx = get_fixer_active_index() == nil and 12 or get_fixer_active_index()
	local players = entity.get_players(true)
	if players == nil then
		return
	end

	local lx,ly,lz = client.eye_position()
	if lx == nil then
		return
	end

	local player_is_e_peeking = false
	local lpx, lpy, lpz = entity.hitbox_position(local_player, 0)
	local lpx1, lpy1, lpz1 = entity.hitbox_position(local_player, 4)
	local lpx2, lpy2, lpz2 = entity.hitbox_position(local_player, 2)
	cached_plist = ui.get(ref_plist)
	local active_weapon = entity.get_prop(local_player, "m_hActiveWeapon")
	if active_weapon == nil then
		return
	end
		
	local idx = entity.get_prop(active_weapon, "m_iItemDefinitionIndex")
	if idx == nil then 
		return
	end
		
	local item = bit.band(idx, 0xFFFF)
	if item == nil then
		return
	end
	
	for i=1, #players do	
		client.update_player_list()
		local player_index = players[i]
		local local_player_origin = {x, y, z}
		local enemy_origin = {x, y, z}
		local_player_origin.x, local_player_origin.y, local_player_origin.z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
		enemy_origin.x, enemy_origin.y, enemy_origin.z = entity.get_prop(player_index, "m_vecOrigin")
		distance_override_m = GetDistanceInMeter(local_player_origin.x, local_player_origin.y, local_player_origin.z, enemy_origin.x, enemy_origin.y, enemy_origin.z)
		local pos_x, pos_y, pos_z = entity.get_prop(player_index, "m_vecAbsOrigin")
		if pos_x ~= nil then
			local t = body_yaw(player_index)
			if t ~= nil then
				if history[player_index] == nil then
					history[player_index] = {}
				end

				list_len = #history[player_index]
				history[player_index][list_len+ 1] = t
			end

			if not entity.is_dormant(player_index) and entity.is_alive(player_index) then
				ui.set(ref_plist, player_index)
				ui.set(ref_pref_baim, "-")
				ui.set(ref_pref_safe, "-")
				local selected_options = ui.get(options)
				local forced = false
				local prefer = false
				local head = false
				local safety = false
				if item == 31 then
					ui.set(ref_pref_baim, "Force")
					forced = true
				end

				if entity.is_alive(player_index) then
					local function vector_angles(x1, y1, z1, x2, y2, z2)
						local origin_x, origin_y, origin_z
						local target_x, target_y, target_z
						if x2 == nil then
							target_x, target_y, target_z = x1, y1, z1
							origin_x, origin_y, origin_z = client.eye_position()
							if origin_x == nil then
								return
							end
						else
							origin_x, origin_y, origin_z = x1, y1, z1
							target_x, target_y, target_z = x2, y2, z2
						end

						local delta_x, delta_y, delta_z = target_x - origin_x, target_y - origin_y, target_z - origin_z
						if delta_x == 0 and delta_y == 0 then
							return (delta_z > 0 and 270 or 90), 0
						else
							local yaw = math.deg(math.atan2(delta_y, delta_x))
							local hyp = math.sqrt(delta_x * delta_x + delta_y * delta_y)
							local pitch = math.deg(math.atan2(- delta_z, hyp))
							return pitch, yaw
						end
					end

					local function normalise_angle(angle)
						angle =  angle % 360 
						angle = (angle + 360) % 360
						if (angle > 180)  then
							angle = angle - 360
						end

						return angle
					end

					local function normalize(angle)
						while angle > 180 do
							angle = angle - 360
						end

						while angle < -180 do
							angle = angle + 360
						end

						return angle
					end

					local lx, ly, lz = client.eye_position()
					local pos_x, pos_y, pos_z = entity.get_prop(player_index, "m_vecAbsOrigin")
					local pitch, yaw = vector_angles(pos_x, pos_y, pos_z, lx, ly, lz)
					local _, model_yaw = entity.get_prop(player_index, "m_angEyeAngles")
					local delta = math.abs(normalise_angle(yaw - model_yaw))
					local get_x = get_x == nil and 0 or get_x local get_y = get_y == nil and 0 or get_y
					local weapon = entity.get_player_weapon(player_index)
					local next_attack = entity.get_prop(weapon, "m_flNextPrimaryAttack") == nil and 0 or entity.get_prop(weapon, "m_flNextPrimaryAttack")
					local tickbase_shift = entity.get_prop(player_index, "m_nTickBase") == nil and 0 or entity.get_prop(player_index, "m_nTickBase")
					local fired_shoot = (next_attack <= tickbase_shift * globals.tickinterval() - 0.12) == nil and false or (next_attack <= tickbase_shift * globals.tickinterval() - 0.12)
					if math.floor(delta) >= 0 and math.floor(delta) <= 45 and plist.get(player_index, "Correction active") and not fired_shoot then
						client.update_player_list()
						player_is_e_peeking = true
					elseif math.floor(delta) >= 46 or not plist.get(player_index, "Correction active") or fired_shoot then
						client.update_player_list()
						player_is_e_peeking = false
					end
				end

				local is_hide_shot = ui.get(hide_check) and ui.get(hide_key)
				local is_double_tap = ui.get(double_check) and ui.get(double_key)
				if not forced then
					if ui.get(ref_pref_baim) ~= "On" then
						if has_value(selected_options, "Backwards/Forwards") then
							local pitch, yaw = vector_angles(pos_x, pos_y, pos_z, lx,ly,lz)
							local _,model_yaw = entity.get_prop(player_index, "m_angEyeAngles")
							local delta = math.abs(normalise_angle(yaw - model_yaw))
							if delta > 90 + ui.get(range_slider) or delta < 90 - ui.get(range_slider) then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end

						if has_value(selected_options, "Override /X M") and not prefer then
							if distance_override_m < ui.get(active[weapons_active_idx]["lua_preferbaim_m"]) then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end

						if has_value(selected_options, "E Peeking Player") and not prefer then
							if player_is_e_peeking then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end


						if has_value(selected_options,"Moving targets") and not prefer then
							if is_moving(player_index) then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end

						if has_value(selected_options,"Slow targets") and not prefer then
							if ent_speed(player_index) > 1.0 and ent_speed(player_index) < 80 then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end

						if has_value(selected_options,"x2 HP") and not prefer then
							if  is_x_shots(local_player,player_index,2) then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end

						if has_value(selected_options,"<x HP") and not prefer then
							if entity.get_prop(player_index,"m_iHealth") <= ui.get(ref_hp_slider) then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end

						if has_value(selected_options,"Shooting") and not prefer then
							local wep = entity.get_player_weapon(player_index)
							if wep ~= nil then
								local last_shot = entity.get_prop(wep,"m_fLastShotTime")
								if (last_shot + 0.500) > globals.curtime() then
									ui.set(ref_pref_baim, "On")
									prefer = true
								end
							end
						end

						if has_value(selected_options,"Big desync") and not prefer then
							local t = max_desync(player_index)
							if t > ui.get(ref_desync) / 10 then
								ui.set(ref_pref_baim, "On")
								prefer = true
							end
						end

						if has_value(selected_options,"Walking jitter desync") and not prefer then
							if ent_speed(player_index) > 2.0 and ent_speed(player_index) < 100 then
								if detect_jitter(player_index) then
									ui.set(ref_pref_baim, "On")
									prefer = true
								end
							end
						end

						if has_value(selected_options,"Always on") and not prefer then
							ui.set(ref_pref_baim, "On")
							prefer = true
						end
					end

					local selected_options = ui.get(headaim_options)
					if ui.get(ref_pref_baim) ~= "Off" then
						if has_value(selected_options,"Sideways targets") then
							local pitch, yaw = vector_angles(pos_x, pos_y, pos_z, lx,ly,lz)
							local _,model_yaw = entity.get_prop(player_index, "m_angEyeAngles")
							local delta = math.abs(normalise_angle(yaw - model_yaw))
							if delta < 90 + ui.get(range_slider) and delta > 90 - ui.get(range_slider) then
								ui.set(ref_pref_baim, "Off")
								head = true
							end
						end

						if has_value(selected_options, "Override /X M") and not head then
							if distance_override_m < ui.get(active[weapons_active_idx]["lua_preferhead_m"]) then
								ui.set(ref_pref_baim, "Off")
								head = true
							end
						end

						if has_value(selected_options, "E Peeking Player") and not head then
							if player_is_e_peeking then
								ui.set(ref_pref_baim, "Off")
								head = true
							end
						end

						if has_value(selected_options,"Crouching targets") and not head then
							local duck_ammount = entity.get_prop(player_index, "m_flDuckAmount")
							if duck_ammount >= 0.7 then
								ui.set(ref_pref_baim, "Off")
								head = true
							end
						end

						if has_value(selected_options,"Fast targets") and not head then
							if ent_speed(player_index) > 170 then
								ui.set(ref_pref_baim, "Off")
								head = true
							end
						end

						if has_value(selected_options,"Small desync") and not head  then
							local t = max_desync(player_index)
							if t <= ui.get(ref_desync) / 10 then
								ui.set(ref_pref_baim, "Off")
								head = true
							end
						end

						if has_value(selected_options,"Shooting") and not head then
							local wep = entity.get_player_weapon(player_index)
							if wep ~= nil then
								local last_shot = entity.get_prop(wep,"m_fLastShotTime")
								if (last_shot + 0.500) > globals.curtime() then
									ui.set(ref_pref_baim, "Off")
									head = true
								end
							end
						end
					end
				
				
					local selected_options = ui.get(force_options)
					if ui.get(ref_pref_baim) ~= "Force" then
						if has_value(selected_options,"Backwards/Forwards") then
							local pitch, yaw = vector_angles(pos_x, pos_y, pos_z, lx,ly,lz)
							local _,model_yaw = entity.get_prop(player_index, "m_angEyeAngles")
							local delta = math.abs(normalise_angle(yaw - model_yaw))
							if delta > 90 + ui.get(range_slider) or delta < 90 - ui.get(range_slider) then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options, "Override /X M") and not forced then
							if distance_override_m < ui.get(active[weapons_active_idx]["lua_forcebaim_m"]) then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options, "E Peeking Player") and not forced then
							if player_is_e_peeking then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options,"Sideways targets") and not forced then
							local pitch, yaw = vector_angles(pos_x, pos_y, pos_z, lx,ly,lz)
							local _,model_yaw = entity.get_prop(player_index, "m_angEyeAngles")
							local delta = math.abs(normalise_angle(yaw - model_yaw))
							if delta < 90 + ui.get(range_slider) and delta > 90 - ui.get(range_slider) then
								if ent_speed(player_index) > 10 then
									ui.set(ref_pref_baim, "Force")
									forced = true
								end
							end
						end

						if has_value(selected_options,"Slow targets") and not forced then
							if ent_speed(player_index) > 1.0 and ent_speed(player_index) < 80 then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options, "On Double Tap") then
							if is_double_tap then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options, "On Hide Shot") then
							if is_hide_shot then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options,"x1 HP") and not forced then
							if is_x_shots(local_player,player_index,1) then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options,"<x HP") and not forced then
							if entity.get_prop(player_index,"m_iHealth") <= ui.get(ref_hp_slider) then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options,"1 miss") and not forced then
							if missLogs[player_index] >= 1 then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options,"2 miss") and not forced then
							if missLogs[player_index] >= 2 then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options,"x2 HP")  and not forced then
							if is_x_shots(local_player,player_index,2) then
								ui.set(ref_pref_baim, "Force")
								forced = true
							end
						end

						if has_value(selected_options,"Shooting") and not forced then
							local wep = entity.get_player_weapon(player_index)
							if wep ~= nil then
								local last_shot = entity.get_prop(wep,"m_fLastShotTime")
								if (last_shot + 0.500) > globals.curtime() then
									ui.set(ref_pref_baim, "Force")
									forced = true
								end
							end
						end

						if has_value(selected_options,"Walking jitter desync") then
							if ent_speed(player_index) > 1.0 and ent_speed(player_index) < 100 then
								if detect_jitter(player_index) then
									ui.set(ref_pref_baim, "Force")
									forced = true
								end
							end
						end
					end

					local selected_options = ui.get(safe_options)
					if ui.get(ref_pref_safe) ~= "On" then
						if has_value(selected_options,"Backwards/Forwards") then
							local pitch, yaw = vector_angles(pos_x, pos_y, pos_z, lx,ly,lz)
							local _,model_yaw = entity.get_prop(player_index, "m_angEyeAngles")
							local delta = math.abs(normalise_angle(yaw - model_yaw))
							if delta > 90 + ui.get(range_slider) or delta < 90 - ui.get(range_slider) then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options, "Override /X M") and not safety then
							if distance_override_m < ui.get(active[weapons_active_idx]["lua_forcesafety_m"]) then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options, "E Peeking Player") and not safety then
							if player_is_e_peeking then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"Sideways targets") and not safety then
							local pitch, yaw = vector_angles(pos_x, pos_y, pos_z, lx,ly,lz)
							local _,model_yaw = entity.get_prop(player_index, "m_angEyeAngles")
							local delta = math.abs(normalise_angle(yaw - model_yaw))
							if delta < 90 + ui.get(range_slider) and delta > 90 - ui.get(range_slider) then
								if ent_speed(player_index) > 10 then
									ui.set(ref_pref_safe, "On")
									safety = true
								end
							end
						end

						if has_value(selected_options,"Slow targets") and not safety then
							if ent_speed(player_index) > 1.0 and ent_speed(player_index) < 80 then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"x1 HP") and not safety then
							if is_x_shots(local_player,player_index,1) then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"<x HP") and not safety then
							if entity.get_prop(player_index,"m_iHealth") <= ui.get(ref_hp_slider) then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"1 miss") and not safety then
							if missLogs[player_index] >= 1 then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"2 miss") and not safety then
							if missLogs[player_index] >= 2 then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"x2 HP")  and not safety then
							if is_x_shots(local_player,player_index,2) then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"On Double Tap") then
							if is_double_tap then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"On Hide Shot") then
							if is_hide_shot then
								ui.set(ref_pref_safe, "On")
								safety = true
							end
						end

						if has_value(selected_options,"Shooting") and not safety then
							local wep = entity.get_player_weapon(player_index)
							if wep ~= nil then
								local last_shot = entity.get_prop(wep,"m_fLastShotTime")
								if (last_shot + 0.500) > globals.curtime() then
									ui.set(ref_pref_safe, "On")
									safety = true
								end
							end
						end

						if has_value(selected_options,"Walking jitter desync") then
							if ent_speed(player_index) > 1.0 and ent_speed(player_index) < 100 then
								if detect_jitter(player_index) then
									ui.set(ref_pref_safe, "On")
									safety = true
								end
							end
						end
					end
				end

				ui.set(safety_condition, safety and 2 or 1)
				if ui.get(smart_footaim) then
					local can1shot = is_x_shots(local_player,player_index,1)
					local trace1x,trace1y,trace1z = entity.hitbox_position(player_index, 0) -- head
					local can_hit_head = is_damage_vis(local_player,lx,ly,lz,trace1x,trace1y,trace1z)
					if can_hit_head and not can1shot then
						ui.set(ref_pref_baim, "Force")
						forced = true
					end

					local trace1x,trace1y,trace1z = entity.hitbox_position(player_index, 11) -- left ankle
					local trace2x,trace2y,trace2z = entity.hitbox_position(player_index, 12) -- right ankle	
					local can_hit_current = trace_positions(local_player,trace1x,trace1y,trace1z,trace2x,trace2y,trace2z,lx,ly,lz)

					if is_moving(player_index) then
						trace1x,trace1y,trace1z = extrapolate_position(trace1x,trace1y,trace1z,10,player_index)
						trace2x,trace2y,trace2z = extrapolate_position(trace2x,trace2y,trace2z,10,player_index)
					end
						
					if (trace_positions_enemy(trace1x,trace1y,trace1z,lpx, lpy, lpz, lpx1, lpy1, lpz1 , lpx2, lpy2, lpz2, player_index) or trace_positions_enemy(trace2x,trace2y,trace2z,lpx, lpy, lpz, lpx1, lpy1, lpz1 , lpx2, lpy2, lpz2, player_index)) and not can_hit_current then
						ui.set(ref_pref_baim, "Force")
					end
				end

				player_preference[player_index] = ui.get(ref_pref_baim)
				player_safe[player_index] = ui.get(safety_condition)
				if not forced then
					local entindex = entity.get_local_player()
					if entindex == nil then
						return
					end
						
					local lx,ly,lz = entity.get_prop(entindex, "m_vecOrigin")
					if lx == nil then
						return
					end

					local closest_fov_cos = -1
					local players = entity.get_players(true)
					local pitch, yaw = client.camera_angles()
					local vx, vy, vz = angle_to_vec(pitch, yaw)
					for i=1, #players do
						entindex = players[i]
						local fov_cos = get_fov_cos(entindex, vx,vy,vz, lx,ly,lz)
						if fov_cos > closest_fov_cos then
							closest_fov_cos = fov_cos
							closest_player = entindex
						end
					end
						

					if ui.get(force_hotkey) then
						if closest_player ~= 0 then
							if closest_player == player_index then
								ui.set(ref_plist, closest_player)
								ui.set(ref_pref_baim, "Force")
								player_preference[closest_player] = "Force"
								forced = true
							end
						end
					end
				end
			end
		end
	end
	
	if cached_plist ~= nil then
		ui.set(ref_plist,cached_plist)
	end
end

local function clear_misses(index)
	missLogs[index] = 0
end

client.set_event_callback("aim_miss", function(c)
	local options = ui.get(force_options)
	if c.reason ~= "spread" then
		local t = c.target
		if missLogs[t] == nil then
			missLogs[t] = 1
			if ui.get(reset_misses) then
				if has_value(options,"1 miss") then
					client.delay_call(5,clear_misses,t)
				end
			end
		else
			missLogs[t] = missLogs[t] + 1
			if ui.get(reset_misses) then
				if has_value(options,"2 miss") or has_value(options,"1 miss") then
					client.delay_call(5,clear_misses,t)
				end
			end
		end
	end

	local options_2 = ui.get(safe_options)
	if c.reason ~= "spread" then
		local t = c.target
		if missLogs[t] == nil then
			missLogs[t] = 1
			if ui.get(reset_misses) then
				if has_value(options_2,"1 miss") then
					client.delay_call(5,clear_misses,t)
				end
			end
		else
			missLogs[t] = missLogs[t] + 1
			if ui.get(reset_misses) then
				if has_value(options_2,"2 miss") or has_value(options_2,"1 miss") then
					client.delay_call(5,clear_misses,t)
				end
			end
		end
	end
end)

client.set_event_callback("player_hurt", function(c)
	local i = client.userid_to_entindex(c.userid)
	if c.health == 0 then
		missLogs[i] = 0
	end
end)

client.set_event_callback("round_end", function(c)
	for i=1, 64 do
		missLogs[i] = 0
		player_preference[i] = ""
		cached_plist = nil
		closest_player = 0
	end
end)

client.set_event_callback("cs_game_disconnected", function(c) 
	ui.set(ui.reference("PLAYERS", "Players", "Reset all"), true)
	
	for i=1, 64 do
		missLogs[i] = 0
		player_preference[i] = ""
		cached_plist = nil
		closest_player = 0
	end
end)

client.set_event_callback("game_newmap", function(c) 
	ui.set(ui.reference("PLAYERS", "Players", "Reset all"), true)
	
	for i=1, 64 do
		missLogs[i] = 0
		player_preference[i] = ""
		cached_plist = nil
		closest_player = 0
	end
	
end)

client.set_event_callback("player_team", function(c)
	client.update_player_list()
end)

client.set_event_callback("round_prestart", function(c)
	client.update_player_list()
end)

client.set_event_callback('run_command', run_command)
