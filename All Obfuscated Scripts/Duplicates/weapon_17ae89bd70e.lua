--[[
	id: hVs1j9IwF-o8Rf_9aKB7w
	name: 404 weapon
	description: 1
	time1: 2021-04-29 06:39:30.557739+00
	time2: 2021-04-29 06:39:30.557739+00
	uploader: 4539
	uploadersession: Lrnvh5BkzLajMPyH6uMYJFFiiKHob-
	flag: f
--]]

---skyness#4221
---skyness#4221
---skyness#4221
local images = require "gamesense/images" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=22917/", 2)
local csgo_weapons = require "gamesense/csgo_weapons" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=18807/", 2)
local success, surface = pcall(require, 'gamesense/surface')
local surface_measure_text, surface_draw_text = surface.measure_text, surface.draw_text
if not success then
    error('\n\n - 滚去订阅数据库(Subscribe) \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n')
end
local verdana = surface.create_font('verdana', 12, 400, { 0x200 --[[ Outline ]] })
local dragging = (function() local a={} local b,c,d,e,f,g,h,i,j,k,l,m,n,o,dg; local p={__index={drag=function(self,...) local q,r=self:get() local s,t=a.drag(q,r,...) if q~=s or r~=t then self:set(s,t) end; return s,t end, set=function(self,q,r) local j,k = client.screen_size() ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res) end, get=function(self) local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}} function a.new(u,v,w,x)x=x or 10000; local j,k=client.screen_size() local y=ui.new_slider("LUA","A",u.." window position 2",0,x,v/j*x) local z=ui.new_slider("LUA","A","\n"..u.." window position y 2",0,x,w/k*x) ui.set_visible(y,false) ui.set_visible(z,false) return setmetatable({name = u,x_reference = y,y_reference = z,res = x},p) end; function a.drag(q,r,A,B,C,D,E) if globals.framecount()~=b then c = ui.is_menu_open() f,g=d,e; d,e=ui.mouse_position() i=h; h=client.key_state(0x01)==true; m=l; l={} o=n; n=false; j,k=client.screen_size() end; if c and i~=nil then if (not i or o) and h and f>q and g>r and f<q+A and g<r+B then n=true; q,r=q+d-f,r+e-g; if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r)) end end if f>=q and g>=r and f<=q+A and g<=r+B then dg = true else dg = false end else  f,g,d,e = 0,0,0,0 dg = false end; table.insert(l,{q,r,A,B}) return q,r,A,B end;function a.match() return dg end;return a end)()
local dragging_2 = (function() local a={} local b,c,d,e,f,g,h,i,j,k,l,m,n,o,dg; local p={__index={drag=function(self,...) local q,r=self:get() local s,t=a.drag(q,r,...) if q~=s or r~=t then self:set(s,t) end; return s,t end, set=function(self,q,r) local j,k = client.screen_size() ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res) end, get=function(self) local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}} function a.new(u,v,w,x)x=x or 10000; local j,k=client.screen_size() local y=ui.new_slider("LUA","A",u.." window position 2",0,x,v/j*x) local z=ui.new_slider("LUA","A","\n"..u.." window position y 2",0,x,w/k*x) ui.set_visible(y,false) ui.set_visible(z,false) return setmetatable({name = u,x_reference = y,y_reference = z,res = x},p) end; function a.drag(q,r,A,B,C,D,E) if globals.framecount()~=b then c = ui.is_menu_open() f,g=d,e; d,e=ui.mouse_position() i=h; h=client.key_state(0x01)==true; m=l; l={} o=n; n=false; j,k=client.screen_size() end; if c and i~=nil then if (not i or o) and h and f>q and g>r and f<q+A and g<r+B then n=true; q,r=q+d-f,r+e-g; if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r)) end end if f>=q and g>=r and f<=q+A and g<=r+B then dg = true else dg = false end else  f,g,d,e = 0,0,0,0 dg = false end; table.insert(l,{q,r,A,B}) return q,r,A,B end;function a.match() return dg end;return a end)()
local hk_dragger = dragging.new("Running Weapons Indicators", 500, 600)
local hk_dragger_2 = dragging_2.new("Running HeadBaim Indicators", 500, 600)
local function multicolor_log(...)
	local args = {...}
	local len = #args
	for i=1, len do
		local arg = args[i]
		local r, g, b = unpack(arg)

		local msg = {}

		if #arg == 3 then
			table.insert(msg, " ")
		else
			for i=4, #arg do
				table.insert(msg, arg[i])
			end
		end
		msg = table.concat(msg)

		if len > i then
			msg = msg .. "\0"
		end

		client.color_log(r, g, b, msg)
	end
end
multicolor_log({0, 255, 0, '✦ '}, {255, 25, 255, 'Latest update 5.06'})
multicolor_log({0, 255, 0, '✦ '}, {255, 255, 25, 'Latest version V4'})
multicolor_log({0, 255, 0, '✦ '}, {255, 25, 255, 'Discord: skyness#4221'})
multicolor_log({0, 255, 0, '✦ '}, {255, 255, 25, 'QQ: 1061706573'})
multicolor_log({0, 0, 255, '✦ '}, {25, 255, 25, 'Private adaptive weapons lua'})

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
delay_Shot = ui.reference("RAGE", "Other", "Delay shot")
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
forceBodyAim = ui.reference("RAGE", "Other", "Force body aim")
force_safe_hitbox = ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes")
auto_peeking, auto_peek_keys = ui.reference("RAGE", "Other", "Quick peek assist")
resolver, resolver_override = ui.reference("RAGE", "Other", "Anti-aim correction"), ui.reference("RAGE", "Other", "Anti-aim correction override")
ref_resolver_byaw = ui.reference("PLAYERS", "Adjustments", "Force body yaw")
ref_resolver_byaw_val = ui.reference("PLAYERS", "Adjustments", "Force body yaw value")

local lp = entity.get_local_player
local weapon_targets = {"Auto", "Awp", "Scout", "Pistol", "Rifle", "SMG", "Revolver", "Deagle", "Heavy", "Other", "Zeus"}
local weapon_active = ui.new_checkbox("Lua", "a", "Enable adaptive weapons(v4)")
local weapons_acitve_visible = ui.new_combobox("Lua", "a", "Weapons selection", weapon_targets)
local active_config_label = ui.new_label("Lua", "a", "Current weapon: " .. ui.get(weapons_acitve_visible))
local override_damage_key_1 = ui.new_hotkey("Lua", "a", "Minimum damage (override) hotkey 1", false)
local override_damage_key_2 = ui.new_hotkey("Lua", "a", "Minimum damage (override) hotkey 2", false)
local override_hitbox_key = ui.new_hotkey("Lua", "a", "Target hitbox (override) hotkey", false)
local override_hitchance_key = ui.new_hotkey("Lua", "a", "Hitchance (override) hotkey", false)
local override_multipoint_key = ui.new_hotkey("Lua", "a", "Multi-point (override) hotkey", false)
local manual_state = ui.new_slider("Lua", "b", "\n Manual Minimum damage (override)", 0, 2, 0)

ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)

local damage_labels_select = 
	{[0] = "Auto"}
	for i = 1, 126 do
		damage_labels_select[i] = i <= 100 and tostring(i) or "HP+" .. tostring(i - 100)
	end

local active = {}
for i=1, #weapon_targets do
    active[i] = {
        ["target_select"] = ui.new_combobox("Lua", "a", "[" .. weapon_targets[i] .. "]Target selection", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
		["target_hitbox"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["hitbox_override"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Target hitbox (override)", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["accuracy_modes"] = ui.new_combobox("Lua", "a", "[" .. weapon_targets[i] .. "]Accuracy boost", {"Off", "Low", "Medium", "High","Maximum"}),
        ["unsafe_hitbox"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Avoid unsafe hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs"}),
		["mp_hitbox"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Multi-point hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["mp_modes"] = ui.new_combobox("Lua", "a", "\n [" .. weapon_targets[i] .. "]Multi point types", {"Low", "Medium", "High"}),
		["dynamic_mp"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Dynamic multi-point"),
		["mp_scale2"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Multi-point scale (minimum)", 24, 100, 56, true, "%", 1, {[24] = "Auto"}),
        ["mp_scale1"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Multi-point scale (maximum)", 24, 100, 91, true, "%", 1, {[24] = "Auto"}),
		["dynamic_dmg"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Dynamic minimum damage"),
		["damage_wall1"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Minimum damage (minimum)", 0, 126, 20, true, "", 1, damage_labels_select),
		["damage_wall2"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Minimum damage (maximum)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["mp_scale"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Multi-point scale", 24, 100, 35, true, "%", 1, {[24] = "Auto"}),
        ["mp_scale_ove"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Multi-point (override) scale", 24, 100, 61, true, "%", 1, {[24] = "Auto"}),
        ["damage_wall"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Minimum damage (default)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["damage_visible"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Minimum damage (visible)", 0, 126, 20, true, "", 1, damage_labels_select),
        ["damage_override_1"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Override minimum damage 1", 0, 126, 20, true, "", 1, damage_labels_select),
        ["damage_override_2"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Override minimum damage 2", 0, 126, 20, true, "", 1, damage_labels_select),
        ["hitchance"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Hitchance (default)", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["vis_hitchance"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Hitchance (visible)", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["override_hitchance"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Hitchance (override)", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["noscope_hitchance"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Hitchance (noscope)", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["prefer_safe"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Prefer safe point"),
        ["force_safe"] = ui.new_combobox("Lua", "a", "[" .. weapon_targets[i] .. "]Force safe point", {"On hotkey", "Always on", "Toggle", "Off hotkey"}),
        ["prefer_baim"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Prefer body aim"),
        ["baim_disable"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Prefer body aim disablers", {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage"}),
		["forcebaimcheck"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Force baim on key"),
		["forcebodyhk"] = ui.new_hotkey("Lua", "a", "[" .. weapon_targets[i] .. "]Force baim key", true),
		["enabled_peek_baim"] =  ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Force baim on peek"),
		["enabled_dt_baim"] =  ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Force baim on DT"),
        ["quick_stop"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Quick stop"),
        ["stop_select"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Quick stop options", {"Early", "Slow motion", "Duck", "Fake duck", "Move between shots", "Ignore molotov", "Taser"}),
        ["dt_enabled"] =  ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Double tap"),
        ["dt_types"] = ui.new_combobox("Lua", "a", "[" .. weapon_targets[i] .. "]Double tap mode", {"Offensive", "Defensive"}),
        ["dt_hitchance"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Double tap hitchance", 0, 100, 50, true, "%", 1),
        ["dt_fakelag"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]Double tap fakelag limit", 1, 10, 1, true, "t", 1),
        ["dt_stop"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Double tap quick stop", {"Slow motion", "Duck", "Move between shots"}),
		["auto_scope"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Automatic scope"),
		["delay_shot"] = ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Delay shot"),
		["delay_shotkey"] = ui.new_hotkey("Lua", "a", "[" .. weapon_targets[i] .. "]Delay shotkey", true),
        ["fps_disable"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]Low FPS mitigations", {"Force low accuracy boost", "Disable multipoint: feet", "Disable multipoint: arms", "Disable multipoint: legs", "Disable hitbox: feet", "Force low multipoint", "Lower hit chance precision", "Limit targets per tick"}),
        ["jump_dis_label"] =  ui.new_label("Lua", "a", "------- Air based settings -------"),
		["enabled_air_status"] =  ui.new_checkbox("Lua", "a", "[" .. weapon_targets[i] .. "]Enable in air override"),
        ["target_select_air"] = ui.new_combobox("Lua", "a", "[" .. weapon_targets[i] .. "]In air target selection", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
        ["target_hitbox_air"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]In air hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        ["mp_hitbox_air"] = ui.new_multiselect("Lua", "a", "[" .. weapon_targets[i] .. "]In air multi-point hitbox", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
		["mp_scale_air"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]In air multi-point scale", 24, 100, 35, true, "%", 1, {[24] = "Auto"}),
		["mp_modes_air"] = ui.new_combobox("Lua", "a", "\n [" .. weapon_targets[i] .. "]In air multi-point", {"Low", "Medium", "High"}),
        ["damage_air"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]In air minimum damage", 0, 126, 20, true, "", 1, damage_labels_select),
        ["hitchance_air"] = ui.new_slider("Lua", "a", "[" .. weapon_targets[i] .. "]In air hitchance", 0, 100, 60, true, "%", 1, {[0] = "Off"}),
        ["misc_label"] = ui.new_label("Lua", "b", "------------ Extended functions ------------"),
        ["lua_condition"] = ui.new_multiselect("Lua", "b" , "[" .. weapon_targets[i] .. "]Extended functions", {"Minimum damage (visible)", "Minimum damage (override1)", "Minimum damage (override2)",  "Target hitbox (override)", "Hitchance (visible)", "Hitchance (override)", "Hitchance (noscope)", "Multi-point (override)", "Customized double tap"}),
      }
end

local keybinds_listbox = ui.new_multiselect("Lua", "b", "Keybind list", "Minimum damage", "Minimum damage (override)", "Target hitbox (override)", "Hitchance (override)", "Multipoint (override)")
local weapon_indicator = ui.new_multiselect("Lua", "b", "Extended indicators", "Active Weapons", "Minimum damage", "Target hitbox (override)", "Multipoint (override)",  "Text value", "Text crosshair value", "Damage value", "Hitchance value", "Delay shot indicator")
local disabled_scope_hitchance = ui.new_multiselect("Lua", "b", "Noscope hitchance weapons", weapon_targets)
local global_color_label = ui.new_label("Lua", "b", "Global indicators color")
local global_c = ui.new_color_picker("Lua", "b", "Global color C_S", 0, 191, 255, 255)
local dmg_color_label = ui.new_label("Lua", "b", "Damage indicators color")
local dmg_c = ui.new_color_picker("Lua", "b", "DMG color", 0, 255, 27, 255)
local background_color_label = ui.new_label("Lua", "b", "Indicator background color")
local background_c = ui.new_color_picker("Lua", "b", "Indicator background", 20, 20, 20, 125)
local high_priority_dager = ui.new_checkbox("Lua", "a", "Prefer high priority target")
local hide_default_menus = ui.new_checkbox("Lua", "b" ,"Hide skeet default menu")
local active_on_switch = ui.new_checkbox("Lua", "b", "Update to current weapon")
label_start_A = ui.new_label("LUA", "B", "--------------- Hitlogs ---------------")
local misses = ui.new_checkbox("lua", "b", "Log misses")
local hits = ui.new_checkbox("lua", "b", "Log hits")
local logging_enabled_checkbox = ui.new_checkbox( 'LUA', 'b', 'Log in console' )
local label10 = ui.new_label("AA", "Other", "|───────────────────────────────|")
local label20 = ui.new_label("AA", "Other", " ")
local label20 = ui.new_label("AA", "Other", " ")
local label20 = ui.new_label("AA", "Other", " ")
local label4 = ui.new_label("AA", "Other", "       Keep your head.        ")
local label5 = ui.new_label("AA", "Other", "                                 What's done is done.")
local label20 = ui.new_label("AA", "Other", " ")
local label20 = ui.new_label("AA", "Other", " ")
local label20 = ui.new_label("AA", "Other", " ")
local label10 = ui.new_label("AA", "Other", "|───────────────────────────────|")


local data = {}
local history = {}
local chokes = {}
local _V3_MT = {}
local cached_plist
local missLogs = {}
local simTimes = {}
local player_safe = {}
local jitter_delta = 15
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
local weapons_active_idx = 1
local lua_mp_hitbox = "Head"
local hitchance_status = "Def"
local high_priority_danger = false
local active_weapons = "Other"
local fix_out, fix_in, time_fix = - 0.42
local auto_override_damage = "DISABLED"
local shot_circle, rv_circle, fix_in, time_fix = 0, 0, 0, 0
local quickstop_prev, quickstop_allowed, peek_standing
local single_fire_weapons = {"CDeagle", "CWeaponSSG08", "CWeaponAwp"}
local hotkey_prev, peeks_shots, peek_pos_x, peek_pos_y, peek_pos_z = false, 0

require("bit")
ui.set(override_hitbox_key, "Toggle")
ui.set(override_hitchance_key, "Toggle")
ui.set(override_multipoint_key, "Toggle")
ui.set_visible(manual_state, false)

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







client.set_event_callback("paint",function()
	ui.set_visible(global_c, ui.get(weapon_active))
	ui.set_visible(dmg_color_label, ui.get(weapon_active) and has_value(ui.get(weapon_indicator), "Minimum damage"))
	ui.set_visible(background_color_label, ui.get(weapon_active))
	ui.set_visible(background_c, ui.get(weapon_active))
	ui.set_visible(global_color_label, ui.get(weapon_active))
	ui.set_visible(dmg_c, ui.get(weapon_active) and has_value(ui.get(weapon_indicator), "Minimum damage"))
	ui.set_visible(active_on_switch, ui.get(weapon_active))
	ui.set_visible(weapon_indicator, ui.get(weapon_active))
	ui.set_visible(active_config_label, ui.get(weapon_active))
	ui.set_visible(high_priority_dager, ui.get(weapon_active))
	ui.set_visible(override_hitbox_key, ui.get(weapon_active))
	ui.set_visible(hide_default_menus, ui.get(weapon_active))
	ui.set_visible(weapons_acitve_visible, ui.get(weapon_active))
	ui.set_visible(override_hitchance_key, ui.get(weapon_active))
	ui.set_visible(override_damage_key_1, ui.get(weapon_active))
	ui.set_visible(override_damage_key_2, ui.get(weapon_active))
	ui.set_visible(override_multipoint_key, ui.get(weapon_active))
	ui.set_visible(label_start_A, ui.get(weapon_active))
	ui.set_visible(logging_enabled_checkbox, ui.get(weapon_active))
	ui.set_visible(misses, ui.get(weapon_active))
	ui.set_visible(hits, ui.get(weapon_active))
	ui.set_visible(disabled_scope_hitchance, ui.get(weapon_active) and has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Hitchance (noscope)") )
	ui.set_visible(low_fps, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(min_htc, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(min_dmg, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(force_safe, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(delay_Shot, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(quick_stop, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_scale, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(prefer_safe, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(auto_scope, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(prefer_baim, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(quick_mode, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_hitbox, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_hotkey, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(target_select, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(multi_modes, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(accuracy_mode, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(target_hitbox_ref, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(force_peek_baim, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(force_safe_hitbox, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(prefer_baim_disabled, not ui.get(weapon_active) and true or not ui.get(hide_default_menus))
	ui.set_visible(keybinds_listbox, ui.get(weapon_active) and has_value(ui.get(weapon_indicator), "Weapon ultra indicator"))
	ui.set_visible(double_tap_fl, not ui.get(weapon_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	ui.set_visible(double_tap_htc, not ui.get(weapon_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	ui.set_visible(double_tap_stop, not ui.get(weapon_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	ui.set_visible(double_tap_types, not ui.get(weapon_active) and true or not ui.get(hide_default_menus) and ui.get(double_check) or false)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) or not ui.get(weapon_active) then
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
			if high_priority_danger == true then
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
local oldSimTime = 0
local shiftTicks = 0

local function netUpdateEnd()
    if lp() == nil or entity.is_alive(lp()) == false then
        return
    end

    local tickInt = globals.tickinterval()
    local tickCount = globals.tickcount()

    local simTime = entity.get_prop(lp(), "m_flSimulationTime") or 0

    if simTime == nil then
        return
    end

    if simTime ~= oldSimTime then
        shiftTicks = (simTime/tickInt) - tickCount
        oldSimTime = simTime
    end
end
client.set_event_callback("net_update_end", netUpdateEnd)

local function player_will_peek(e)
	local local_player = entity.get_local_player()
	if not local_player or not entity.is_alive(local_player) or not ui.get(weapon_active) or ui.get(quick_stop) then
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

local function visible_enemy(ctx)			
	local local_entindex = entity.get_local_player()
	if entity.get_prop(local_entindex, "m_lifeState") ~= 0 or not entity.is_alive(local_entindex) then	
		weapon_visible = false
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
	weapon_visible = visible and true or false
	stored_target = enemy_entindex
	local enemy_player_number = entity.get_players(true)
end

client.set_event_callback("paint",visible_enemy)

local function weapons_name(c)
	fix_out = 0.32
	local local_player = entity.get_local_player()
	local enemy_players = entity.get_players(true)
	local G_color = { ui.get(global_c) }
	local DMG_color = { ui.get(dmg_c) }
	local BAKCGROUND_color = { ui.get(background_c) }

	hk_dragger_2:drag(200, 20 + #enemy_players * 10)
	for i = 1, #enemy_players do
		enemy_player = enemy_players[i]
		local local_player_origin = {x, y, z}
		local enemy_origin = {x, y, z}
		local_player_origin.x, local_player_origin.y, local_player_origin.z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
		enemy_origin.x, enemy_origin.y, enemy_origin.z = entity.get_prop(enemy_player, "m_vecOrigin")
		distance_value = GetDistanceInMeter(local_player_origin.x, local_player_origin.y, local_player_origin.z, enemy_origin.x, enemy_origin.y, enemy_origin.z)
		local world_distance = adaptive_distance(e)
	end

	for i=1, #weapon_targets do
		
		ui.set_visible(active[i]["misc_label"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["enabled_peek_baim"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["enabled_dt_baim"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["jump_dis_label"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["target_select"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["target_hitbox"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["hitbox_override"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Target hitbox (override)"))
		ui.set_visible(active[i]["accuracy_modes"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["forcebaimcheck"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["forcebodyhk"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[weapons_active_idx]["forcebaimcheck"]))
		ui.set_visible(active[i]["delay_shot"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["delay_shotkey"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[weapons_active_idx]["delay_shot"]))
		ui.set_visible(active[i]["auto_scope"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["damage_wall"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["damage_visible"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Minimum damage (visible)"))
		ui.set_visible(active[i]["damage_override_1"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Minimum damage (override1)"))
		ui.set_visible(active[i]["damage_override_2"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Minimum damage (override2)"))
		ui.set_visible(active[i]["hitchance"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["vis_hitchance"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Hitchance (visible)"))
		ui.set_visible(active[i]["override_hitchance"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Hitchance (override)"))
		ui.set_visible(active[i]["unsafe_hitbox"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["noscope_hitchance"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(disabled_scope_hitchance), ui.get(weapons_acitve_visible)) and has_value(ui.get(active[i]["lua_condition"]), "Hitchance (noscope)"))
		ui.set_visible(active[i]["mp_hitbox"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["mp_modes"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["dynamic_mp"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["mp_scale1"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dynamic_mp"]))
		ui.set_visible(active[i]["mp_scale2"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dynamic_mp"]))
		ui.set_visible(active[i]["mp_scale"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and not ui.get(active[i]["dynamic_mp"]))
		ui.set_visible(active[i]["dynamic_dmg"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["damage_wall1"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dynamic_dmg"]))
		ui.set_visible(active[i]["damage_wall2"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dynamic_dmg"]))
		ui.set_visible(active[i]["damage_wall"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and not ui.get(active[i]["dynamic_dmg"]))
		ui.set_visible(active[i]["mp_scale_ove"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Multi-point (override)"))
		ui.set_visible(active[i]["prefer_safe"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["force_safe"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["prefer_baim"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["baim_disable"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["prefer_baim"]))
		ui.set_visible(active[i]["quick_stop"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["stop_select"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["quick_stop"]))
		ui.set_visible(active[i]["dt_enabled"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and has_value(ui.get(active[i]["lua_condition"]), "Customized double tap"))
		ui.set_visible(active[i]["dt_stop"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and has_value(ui.get(active[i]["lua_condition"]), "Customized double tap"))
		ui.set_visible(active[i]["dt_types"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and has_value(ui.get(active[i]["lua_condition"]), "Customized double tap"))
		ui.set_visible(active[i]["dt_fakelag"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and has_value(ui.get(active[i]["lua_condition"]), "Customized double tap"))
		ui.set_visible(active[i]["dt_hitchance"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["dt_enabled"]) and has_value(ui.get(active[i]["lua_condition"]), "Customized double tap"))
		ui.set_visible(active[i]["fps_disable"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["enabled_air_status"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		ui.set_visible(active[i]["target_select_air"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["target_hitbox_air"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["mp_hitbox_air"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["damage_air"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["hitchance_air"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["mp_modes_air"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["mp_scale_air"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i] and ui.get(active[i]["enabled_air_status"]))
		ui.set_visible(active[i]["lua_condition"], ui.get(weapon_active) and ui.get(weapons_acitve_visible) == weapon_targets[i])
		multiselect_debug(active[i]["target_hitbox_air"], "Head")
		multiselect_debug(active[i]["target_hitbox"], "Head")
		multiselect_debug(active[i]["hitbox_override"], "Head")
	end

	local local_player_origin = {x, y, z}
	local enemy_origin = {x, y, z}
	local inair_flags_override = entity.get_prop(entity.get_local_player(), "m_fFlags") == 256 or entity.get_prop(entity.get_local_player(), "m_fFlags") == 262
	local distance_value = #enemy_players == 0 and 0 or distance_value
	enemy_origin.x, enemy_origin.y, enemy_origin.z = enemy_origin.x, enemy_origin.y, enemy_origin.z
	local_player_origin.x, local_player_origin.y, local_player_origin.z = local_player_origin.x, local_player_origin.y, local_player_origin.z
	if not local_player or not entity.is_alive(local_player) or not ui.get(weapon_active) then
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
		active_weapons = "Auto"
		weapons_active_idx = 1
	elseif active_weapons_coder == 9 then
		active_weapons = "Awp"
		weapons_active_idx = 2
	elseif active_weapons_coder == 40 then
		active_weapons = "Scout"
		weapons_active_idx = 3
	elseif active_weapons_coder == 2 or active_weapons_coder == 3 or active_weapons_coder == 4 or active_weapons_coder == 30 or active_weapons_coder == 32 or active_weapons_coder == 36 or active_weapons_coder == 61 or active_weapons_coder == 63 then
		active_weapons = "Pistol"
		weapons_active_idx = 4
	elseif active_weapons_coder == 7 or active_weapons_coder == 8  or active_weapons_coder == 10 or active_weapons_coder == 13 or active_weapons_coder == 16 or active_weapons_coder == 39 or active_weapons_coder == 60 then
		active_weapons = "Rifle"
		weapons_active_idx = 5
	elseif active_weapons_coder == 17 or active_weapons_coder == 19  or active_weapons_coder == 23 or active_weapons_coder == 24 or active_weapons_coder == 26 or active_weapons_coder == 33 or active_weapons_coder == 34 then
		active_weapons = "SMG"
		weapons_active_idx = 6
	elseif active_weapons_coder == 64 then
		active_weapons = "Revolver"
		weapons_active_idx = 7
	elseif active_weapons_coder == 1 then
		active_weapons = "Deagle"
		weapons_active_idx = 8
	elseif active_weapons_coder == 14 or active_weapons_coder == 28 then
		active_weapons = "Heavy"
		weapons_active_idx = 9
	elseif active_weapons_coder == 31 then
		active_weapons = "Zeus"
		weapons_active_idx = 11
	else
		active_weapons = "Other"
		weapons_active_idx = 10
	end

	local switch_active_name = entity.get_player_weapon(local_player)
	local switch_active_weapons = bit.band(entity.get_prop(switch_active_name, "m_iItemDefinitionIndex"), 0xFFFF)
	if ui.get(active_on_switch) then
		if last_weapon ~= switch_active_weapons then
			ui.set(weapons_acitve_visible, active_weapons)
			last_weapon = switch_active_weapons
		end
	end

	
	local dt_flags_on_grenade = false
	local damage_status = damage_status
	local hitchance_status = hitchance_status
	local active_weapons = active_weapons
	local weapons_csgo_coder_name = entity.get_classname(entity.get_player_weapon(entity.get_local_player()))
	local no_scope_active_weapon = has_value(ui.get(disabled_scope_hitchance), active_weapons) and true or false
	local is_other_weapons = weapons_csgo_coder_name == "CHEGrenade" or weapons_csgo_coder_name == "CSmokeGreade" or weapons_csgo_coder_name == "CIncendiaryGrenade" or weapons_csgo_coder_name == "CFlashbang" or weapons_csgo_coder_name == "CDecoyGrenade" or weapons_csgo_coder_name == "CC4" or weapons_csgo_coder_name == "CKnife"
	local world_distance = adaptive_distance(e)

    local lua_damage = ui.get(active[weapons_active_idx]["dynamic_dmg"]) and lua_dmg_score_ref or ui.get(active[weapons_active_idx]["damage_wall"])
	local scoped_hitchance = entity.get_prop(local_player, "m_bIsScoped") == 0 and true or false
	local multi_visible_damage = #enemy_players == 0 and false or has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Minimum damage (visible)") and weapon_visible == true
	local override_damage_x1 = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Minimum damage (override1)") and ui.get(override_damage_key_1) or has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Minimum damage (override1)") and ui.get(manual_state) == 1
	local override_damage_x2 = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Minimum damage (override2)") and ui.get(override_damage_key_2) or has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Minimum damage (override2)") and ui.get(manual_state) == 2
	local multi_override_damage = override_damage_x1 or override_damage_x2 
	local multi_override_hitbox = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Target hitbox (override)") and ui.get(override_hitbox_key)
	local multi_visible_hitchance = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Hitchance (visible)") and weapon_visible == true
	local multi_override_hitchance = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Hitchance (override)") and ui.get(override_hitchance_key)
	local multi_noscope_hitchance = has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Hitchance (noscope)") and scoped_hitchance
	

	if ui.get(override_damage_key_1) then
		override_damage_types = ui.get(active[weapons_active_idx]["damage_override_1"])
		override_damage_flags = "Ove1"
	elseif ui.get(override_damage_key_2) then
		override_damage_types = ui.get(active[weapons_active_idx]["damage_override_2"])
		override_damage_flags = "Ove2"
	end

	if not multi_noscope_hitchance or not no_scope_active_weapon then
		lua_hitchance = multi_override_hitchance and ui.get(active[weapons_active_idx]["override_hitchance"]) or multi_visible_hitchance == false and ui.get(active[weapons_active_idx]["hitchance"]) or ui.get(active[weapons_active_idx]["vis_hitchance"])
		hitchance_status = multi_override_hitchance and "Ove" or multi_visible_hitchance == false and "Def" or"Vis"
	elseif multi_noscope_hitchance and no_scope_active_weapon then
		lua_hitchance = multi_override_hitchance and ui.get(active[weapons_active_idx]["override_hitchance"]) or ui.get(active[weapons_active_idx]["noscope_hitchance"])
		hitchance_status = multi_override_hitchance and "Ove" or "Nos"
	end
	
	local shouldFBaim = false
	if lp() == nil and entity.is_alive(lp()) == false then
        return
    end

    local weapon = entity.get_player_weapon(lp())
    if weapon == nil then
        return
    end
    
	if ui.get(active[weapons_active_idx]["forcebaimcheck"]) then
		if ui.get(active[weapons_active_idx]["forcebodyhk"]) then
			shouldFBaim = true
		end
	end
	
	--Force body aim on first double tap
	if ui.get(active[weapons_active_idx]["enabled_dt_baim"]) then
		local weapon = entity.get_player_weapon(lp())
		local nextFire = math.max(entity.get_prop(weapon, "m_flNextPrimaryAttack") or 0, entity.get_prop(lp(), "m_flNextAttack") or 0)
		if shiftTicks < 0 and nextFire < globals.curtime() and globals.chokedcommands() <= ui.get(double_tap_fl) then
			shouldFBaim = true
		end
	end
	ui.set(forceBodyAim, shouldFBaim and "Always on" or "On hotkey")

	local vx, vy, vz = entity.get_prop(local_player, "m_vecVelocity")
	local velocity_speed = math.sqrt((vx * vx) + (vy * vy))
	if ui.get(active[weapons_active_idx]["dynamic_mp"]) then
		if distance_value <= 5 then
			local lua_multipoint_first_ref = 30 * distance_value / 5
			lua_multipoint_score_ref = math.max(ui.get(active[weapons_active_idx]["mp_scale2"]), ui.get(active[weapons_active_idx]["mp_scale1"]) - lua_multipoint_first_ref + 1) >= ui.get(active[weapons_active_idx]["mp_scale1"]) and ui.get(active[weapons_active_idx]["mp_scale1"]) or math.max(ui.get(active[weapons_active_idx]["mp_scale2"]), ui.get(active[weapons_active_idx]["mp_scale1"]) - lua_multipoint_first_ref + 1)
		elseif distance_value >= 6 then
			local lua_multipoint_first_ref = math.min(ui.get(active[weapons_active_idx]["mp_scale1"]), ui.get(active[weapons_active_idx]["mp_scale"])) * velocity_speed / 150
			lua_multipoint_score_ref = math.max(ui.get(active[weapons_active_idx]["mp_scale2"]), ui.get(active[weapons_active_idx]["mp_scale1"]) - lua_multipoint_first_ref + 1) >= ui.get(active[weapons_active_idx]["mp_scale1"]) and ui.get(active[weapons_active_idx]["mp_scale1"]) or math.max(ui.get(active[weapons_active_idx]["mp_scale2"]), ui.get(active[weapons_active_idx]["mp_scale1"]) - lua_multipoint_first_ref + 1)
		end
	end

	if ui.get(active[weapons_active_idx]["dynamic_dmg"]) then
		local lua_dmg_first_ref = 30 * distance_value / 180
		lua_dmg_score_ref = math.max(ui.get(active[weapons_active_idx]["damage_wall1"]), ui.get(active[weapons_active_idx]["damage_wall2"]) - lua_dmg_first_ref+1) >= ui.get(active[weapons_active_idx]["damage_wall2"]) and ui.get(active[weapons_active_idx]["damage_wall2"]) or math.max(ui.get(active[weapons_active_idx]["damage_wall1"]), ui.get(active[weapons_active_idx]["damage_wall2"]) - lua_dmg_first_ref+1)
	end

	local lua_mp_hitbox = ui.get(active[weapons_active_idx]["mp_hitbox"])
	local lua_hitbox_ref = ui.get(active[weapons_active_idx]["target_hitbox"])
	local targets_selects = ui.get(active[weapons_active_idx]["target_select"])
	local multi_mode_select = ui.get(active[weapons_active_idx]["mp_modes"])
	local lua_multipoint_scale = ui.get(active[weapons_active_idx]["dynamic_mp"]) and lua_multipoint_score_ref or ui.get(active[weapons_active_idx]["mp_scale"])
	local lua_hitbox = multi_override_hitbox and ui.get(active[weapons_active_idx]["hitbox_override"]) or lua_hitbox_ref

	if ui.get(override_damage_key_1)  then 
	    lua_damage = ui.get(active[weapons_active_idx]["damage_override_1"]) 
	    damage_status = override_damage_flags 
	elseif ui.get(override_damage_key_2) then 
		lua_damage = ui.get(active[weapons_active_idx]["damage_override_2"])
		damage_status = override_damage_flags 
	elseif inair_flags_override == false and not ui.get(active[weapons_active_idx]["dynamic_dmg"])then
		targets_selects = ui.get(active[weapons_active_idx]["target_select"])
		lua_damage = override_dmg_system and override_damage_types or multi_visible_damage == false and ui.get(active[weapons_active_idx]["damage_wall"]) or ui.get(active[weapons_active_idx]["damage_visible"])
		damage_status = override_dmg_system and override_damage_types or multi_visible_damage == false and "Def" or "Vis"
		multi_mode_select = ui.get(active[weapons_active_idx]["mp_modes"])
		lua_multipoint_scale = ui.get(active[weapons_active_idx]["dynamic_mp"]) and lua_multipoint_score_ref or ui.get(active[weapons_active_idx]["mp_scale"])
	elseif inair_flags_override == false and ui.get(active[weapons_active_idx]["dynamic_dmg"]) then
		targets_selects = ui.get(active[weapons_active_idx]["target_select"])
		lua_damage = override_dmg_system and override_damage_types or multi_visible_damage == false and lua_dmg_score_ref or ui.get(active[weapons_active_idx]["damage_visible"])
		damage_status = override_dmg_system and override_damage_types or multi_visible_damage == false and "Dyn" or "Vis"
		multi_mode_select = ui.get(active[weapons_active_idx]["mp_modes"])
		lua_multipoint_scale = ui.get(active[weapons_active_idx]["dynamic_mp"]) and lua_multipoint_score_ref or ui.get(active[weapons_active_idx]["mp_scale"])
	elseif inair_flags_override == true and ui.get(active[weapons_active_idx]["enabled_air_status"]) then
		targets_selects = ui.get(active[weapons_active_idx]["target_select_air"])
		lua_mp_hitbox = ui.get(active[weapons_active_idx]["mp_hitbox_air"])
		lua_damage =  ui.get(active[weapons_active_idx]["damage_air"])
		damage_status =  "Air"
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
	ui.set(target_hitbox_ref, lua_hitbox == nil and "Head" or lua_hitbox)
	ui.set(prefer_safe, ui.get(active[weapons_active_idx]["prefer_safe"]))
	ui.set(force_safe, ui.get(active[weapons_active_idx]["force_safe"]))
	ui.set(low_fps, ui.get(active[weapons_active_idx]["fps_disable"]))
	ui.set(delay_Shot, ui.get(active[weapons_active_idx]["delay_shotkey"]))
	ui.set(auto_scope, ui.get(active[weapons_active_idx]["auto_scope"]))
	ui.set(quick_mode, ui.get(active[weapons_active_idx]["stop_select"]))
	ui.set(prefer_baim, ui.get(active[weapons_active_idx]["prefer_baim"]))
	ui.set(accuracy_mode, ui.get(active[weapons_active_idx]["accuracy_modes"]))
	ui.set(prefer_baim_disabled, ui.get(active[weapons_active_idx]["baim_disable"]))
	ui.set(force_peek_baim, ui.get(active[weapons_active_idx]["enabled_peek_baim"]))
	ui.set(active_config_label, "Current weapon: ".. active_weapons)
	ui.set(force_safe_hitbox, override_unsafe_hitbox and ui.get(active[weapons_active_idx]["unsafe_hitbox_ove"]) or ui.get(active[weapons_active_idx]["unsafe_hitbox"]))
	

	if has_value(ui.get(active[weapons_active_idx]["lua_condition"]), "Customized double tap") and not dt_flags_on_grenade then
		ui.set(double_tap_fl, ui.get(active[weapons_active_idx]["dt_fakelag"]))
		ui.set(double_tap_types, ui.get(active[weapons_active_idx]["dt_types"]))
		ui.set(double_check, ui.get(active[weapons_active_idx]["dt_enabled"]))
		ui.set(double_tap_htc, ui.get(active[weapons_active_idx]["dt_hitchance"]))
		ui.set(double_tap_stop, ui.get(active[weapons_active_idx]["dt_stop"]))
	end

	local client_screen_size = client.screen_size
	local w, h = client_screen_size()
	local weapon_r, weapon_g, weapon_b, weapon_a = ui.get(global_c)

	if has_value(ui.get(weapon_indicator), "Target hitbox (override)") and multi_override_hitbox then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "HB(OR)")
	end


	if has_value(ui.get(weapon_indicator), "Multipoint (override)") and ui.get(override_multipoint_key) then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "MP(OR)")
	end

	if has_value(ui.get(weapon_indicator), "Active Weapons") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "".. active_weapons)
	end

	if has_value(ui.get(weapon_indicator), "Text value") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "D: " ..damage_status .. " & H: " ..hitchance_status)
	end

	if has_value(ui.get(weapon_indicator), "Text crosshair value") then
		renderer.text(w / 2 , h / 2+25 , weapon_r, weapon_g, weapon_b, weapon_a, "cb",0, "D: " ..damage_status .. " | H: " ..hitchance_status)
	end

	if has_value(ui.get(weapon_indicator), "Damage value") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "DMG-> ", ui.get(min_dmg))
	end

	if has_value(ui.get(weapon_indicator), "Hitchance value") then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "HTC-> ", ui.get(min_htc))
	end

	if ui.get(forceBodyAim) then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "BAIM")
	end

	if has_value(ui.get(weapon_indicator), "Delay shot indicator" ) and ui.get(delay_Shot) then
		client.draw_indicator(ctx, weapon_r, weapon_g, weapon_b, weapon_a, "DELAY")
	end

	--[[
	if has_value(ui.get(weapon_indicator), "Minimum damage") then
		if damage_status == "Def" then
			client.draw_indicator(ctx, DMG_color[1], DMG_color[2], DMG_color[3], 255, #enemy_players <= 0 and "Minimum damage: waiting..." or "Minimum damage: " .. ui.get(min_dmg))
		elseif damage_status == "Vis" then
			client.draw_indicator(ctx, DMG_color[1], DMG_color[2], DMG_color[3], 255, #enemy_players <= 0 and "Minimum damage: waiting..." or "Minimum damage: " .. ui.get(min_dmg))
		elseif damage_status == "X1 Ove" or damage_status == "X2 Ove" or damage_status == "X3 Ove" then
			client.draw_indicator(ctx, 255, 0, 0, 255, #enemy_players <= 0 and "Minimum damage: waiting..." or "Minimum damage: " .. ui.get(min_dmg))
		elseif damage_status == "Dis" or damage_status == "Air" then
			client.draw_indicator(ctx, DMG_color[1], DMG_color[2], DMG_color[3], 255, #enemy_players <= 0 and "Minimum damage: waiting..." or "Minimum damage: " .. ui.get(min_dmg))
		end
	end
	]]
	if has_value(ui.get(weapon_indicator), "Minimum damage") then
		if damage_status == "Def" then
			client.draw_indicator(ctx, DMG_color[1], DMG_color[2], DMG_color[3], 255, "DMG: " .. ui.get(min_dmg))
		elseif damage_status == "Vis" then
			client.draw_indicator(ctx, DMG_color[1], DMG_color[2], DMG_color[3], 255, "DMG: " .. ui.get(min_dmg))
		elseif damage_status == "Ove1" or damage_status == "Ove2" then
			client.draw_indicator(ctx, 255, 0, 0, 255, "DMG: " .. ui.get(min_dmg))
		elseif damage_status == "Dis" or damage_status == "Air" then
			client.draw_indicator(ctx, DMG_color[1], DMG_color[2], DMG_color[3], 255, "DMG: " .. ui.get(min_dmg))
		end
	end
end

client.set_event_callback("paint", weapons_name)





local function on_aim_fire(e)
	peeks_shots = peeks_shots + 1
end

client.set_event_callback("aim_fire", on_aim_fire)



client.set_event_callback("player_team", function(c)
	client.update_player_list()
end)

client.set_event_callback("round_prestart", function(c)
	client.update_player_list()
end)

local ffi = require("ffi")
ffi.cdef[[
typedef void***(__thiscall* FindHudElement_t)(void*, const char*);
typedef void(__cdecl* ChatPrintf_t)(void*, int, int, const char*, ...);
]]

local signature_gHud = "\xB9\xCC\xCC\xCC\xCC\x88\x46\x09"
local signature_FindElement = "\x55\x8B\xEC\x53\x8B\x5D\x08\x56\x57\x8B\xF9\x33\xF6\x39\x77\x28"

local match = client.find_signature("client_panorama.dll", signature_gHud) or error("sig1 not found")
local hud = ffi.cast("void**", ffi.cast("char*", match) + 1)[0] or error("hud is nil")

match = client.find_signature("client_panorama.dll", signature_FindElement) or error("FindHudElement not found")
local find_hud_element = ffi.cast("FindHudElement_t", match)
local hudchat = find_hud_element(hud, "CHudChat") or error("CHudChat not found")

local chudchat_vtbl = hudchat[0] or error("CHudChat instance vtable is nil")
local print_to_chat = ffi.cast("ChatPrintf_t", chudchat_vtbl[27])

--[[
\x01 - white
\x02 - red
\x03 - purple
\x04 - green
\x05 - yellow green
\x06 - light green
\x07 - light red
\x08 - gray
\x09 - light yellow
\x0A - gray
\x0C - dark blue
\x10 - gold
]]
function print_chat(text)
	print_to_chat(hudchat, 0, 0, text)
end

local function on_aim_hit(e)
	if ui.get(hits) then

        local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
        local group = hitgroup_names[e.hitgroup + 1] or "?"

        local target_name = entity.get_player_name(e.target)
       
		local entityHealth = entity.get_prop(e.target, "m_iHealth")
		print_chat(" \x08<\x10404 project\x08>" .."\x06hit ".. "\x0Atarget: \x04" .. string.lower(target_name) .. "\x0A hitbox: \x05" .. group .. "\x0A hp: \x09" .. entityHealth .. "\x0A hc: \x09" .. string.format("%d", e.hit_chance) .. "%")
    end
end

local function on_aim_miss(e)
	if ui.get(misses) and e ~= nil then

    local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
    local group = hitgroup_names[e.hitgroup + 1] or "?"
    local target_name = entity.get_player_name(e.target)
    local reason
	local entityHealth = entity.get_prop(e.target, "m_iHealth")
	if (entityHealth == nil) or (entityHealth <= 0) then
		client.log("The player was killed prior to your shot being able to land")
	return
	end
    if e.reason == "?" then
    	reason = "resolver"
    else
    	reason = e.reason
    end
		print_chat(" \x08<\x10404 project\x08>" .. "\x07missed \x04" .. string.lower(target_name) .. "\x04's " .. " \x05" .. group .. "\x01 due to \x02" .. reason.. "\x0A hc: \x09" .. string.format("%d", e.hit_chance) .. "%")
    end
end


client.set_event_callback('aim_hit', on_aim_hit)
client.set_event_callback('aim_miss', on_aim_miss)
local color_log = client.color_log

-- hitgroup name creds: sapphyrus

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




local function on_aim_missed( event )
    if ui.get( logging_enabled_checkbox ) then
      output = '[ 404 project ] missed ' .. entity.get_player_name( event.target ) .. ' | reason: ' .. event.reason .. ' | target hitgroup: '.. hitgroup_names[ event.hitgroup + 1 ] .. ' | hitchance: ' .. event.hit_chance
  
      -- so we can tell what it is without reading it
      if event.reason == 'spread' then
        color_log( 255, 120, 0, output)
      elseif event.reason == 'resolver' then
        color_log( 255, 0, 0, output)
      else
        color_log( 255, 255, 255, output)
      end
    end
end

client.set_event_callback( "aim_miss", on_aim_missed )

local function on_aim_hit( event )
  if ui.get( logging_enabled_checkbox ) then
    output = '[ 404 project ] hit ' .. entity.get_player_name( event.target ) .. ' for ' .. event.damage .. ' | ' .. entity.get_prop( event.target, 'm_iHealth' ) .. ' health left' .. ' | hitgroup: ' .. hitgroup_names[ event.hitgroup + 1 ] .. ' | hitchance: ' .. event.hit_chance
    color_log( 0, 255, 0, output )
  end
end

client.set_event_callback( "aim_hit", on_aim_hit )