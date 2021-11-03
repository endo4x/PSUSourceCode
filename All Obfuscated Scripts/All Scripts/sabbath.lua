--[[
	id: trZg1CSHl9FxA-r6NvIrE
	name: sabbath
	description: sabbath anti-aim lua
	time1: 2021-07-08 17:39:04.750499+00
	time2: 2021-07-08 17:39:04.7505+00
	uploader: KuFGslhKMQ5K3wc8VwQhYL3HSWjjg1IvuumBras5
	uploadersession: dwCs4j725gfbBPX4Eeu0IILKhwVSoC
	flag: f
--]]

-- local variables for API functions. any changes to the line below will be lost on re-generation
local bit_band, client_camera_angles, client_color_log, client_create_interface, client_delay_call, client_exec, client_eye_position, client_key_state, client_log, client_random_int, client_scale_damage, client_screen_size, client_set_event_callback, client_trace_bullet, client_userid_to_entindex, database_read, database_write, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, entity_is_enemy, math_abs, math_atan2, require, error, globals_absoluteframetime, globals_curtime, globals_realtime, math_atan, math_cos, math_deg, math_floor, math_max, math_min, math_rad, math_sin, math_sqrt, print, renderer_circle_outline, renderer_gradient, renderer_measure_text, renderer_rectangle, renderer_text, renderer_triangle, string_find, string_gmatch, string_gsub, string_lower, table_insert, table_remove, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_hotkey, ui_new_multiselect, ui_reference, tostring, ui_is_menu_open, ui_mouse_position, ui_new_combobox, ui_new_slider, ui_set, ui_set_callback, ui_set_visible, tonumber, pcall = bit.band, client.camera_angles, client.color_log, client.create_interface, client.delay_call, client.exec, client.eye_position, client.key_state, client.log, client.random_int, client.scale_damage, client.screen_size, client.set_event_callback, client.trace_bullet, client.userid_to_entindex, database.read, database.write, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, entity.is_enemy, math.abs, math.atan2, require, error, globals.absoluteframetime, globals.curtime, globals.realtime, math.atan, math.cos, math.deg, math.floor, math.max, math.min, math.rad, math.sin, math.sqrt, print, renderer.circle_outline, renderer.gradient, renderer.measure_text, renderer.rectangle, renderer.text, renderer.triangle, string.find, string.gmatch, string.gsub, string.lower, table.insert, table.remove, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_hotkey, ui.new_multiselect, ui.reference, tostring, ui.is_menu_open, ui.mouse_position, ui.new_combobox, ui.new_slider, ui.set, ui.set_callback, ui.set_visible, tonumber, pcall
local ui_menu_position, ui_menu_size, math_pi, renderer_indicator, entity_is_dormant, client_set_clan_tag, client_trace_line, entity_get_all, entity_get_classname = ui.menu_position, ui.menu_size, math.pi, renderer.indicator, entity.is_dormant, client.set_clan_tag, client.trace_line, entity.get_all, entity.get_classname
local local_player = entity.get_local_player()
local plist_set = plist.get
local vector = require('vector')
local images = require 'gamesense/surface'

local ffi = require('ffi')
local ffi_cast = ffi.cast

local js = panorama.open()
local persona_api = js.MyPersonaAPI
local name = persona_api.GetName()

client.color_log(42, 233, 36, "|--------------------------------------------------------|")
client.color_log(147, 52, 235,  "                             ")
client.color_log(147, 52, 235, "           _   _       _   _   ")
client.color_log(147, 52, 235,  "   ___ ___| |_| |_ ___| |_| |_ ")
client.color_log(147, 52, 235,  "  |_ -| .'| . | . | .'|  _|   |      intellectual being!")
client.color_log(147, 52, 235, "  |___|__,|___|___|__,|_| |_|_|")
client.color_log(147, 52, 235,  "                               ")
client.color_log(42, 233, 36, "|--------------------------------------------------------|")

local function includes(table, key)
    local state = false
    for i=1, #table do
        if table[i] == key then
            state = true
            break 
        end
    end
    return state
end

local extra_log = function(fn, ...)
	local data = { ... }

	for i=1, #data do
		if i==1 then
			local clr = {
				{ 255, 255, 0 },
				{ 255, 0, 0 },
			}

			client.color_log(clr[fn][1], clr[fn][2], clr[fn][3], ' - \0')
		end

		client.color_log(data[i][1], data[i][2], data[i][3],  string.format('%s\0', data[i][4]))

        if i == #data then
            client.color_log(255, 255, 255, ' ')
        end
	end
end

local create_callback = function(name, func)
    local get_func_index = function(fn)
        return ffi.cast("int*", ffi.cast(ffi.typeof("void*(__thiscall*)(void*)"), fn))[0]
    end

    local DEC_HEX = function(IN)
        local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
        while IN>0 do
            I=I+1
            IN,D=math.floor(IN/B),math.fmod(IN,B)+1
            OUT=string.sub(K,D,D)..OUT
        end
        return OUT
    end

    

    client.delay_call(0.1, function()
        client.set_event_callback(name, func)
    end)
end

local ref = {
	enabled = ui_reference("AA", "Anti-aimbot angles", "Enabled"),
	pitch = ui_reference("AA", "Anti-aimbot angles", "pitch"),
	yawbase = ui_reference("AA", "Anti-aimbot angles", "Yaw base"),
	yaw = { ui_reference("AA", "Anti-aimbot angles", "Yaw") },
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
	dt_limit = ui_reference("RAGE", "Other", "Double tap fake lag limit"),

	quickpeek = { ui_reference("RAGE", "Other", "Quick peek assist") },
	yawjitter = { ui_reference("AA", "Anti-aimbot angles", "Yaw jitter") },
	bodyyaw = { ui_reference("AA", "Anti-aimbot angles", "Body yaw") },
	freestand = { ui_reference("AA", "Anti-aimbot angles", "Freestanding") },
	os = { ui_reference("AA", "Other", "On shot anti-aim") },
	slow = { ui_reference("AA", "Other", "Slow motion") },
	dt = { ui_reference("RAGE", "Other", "Double tap") },
	ps = { ui_reference("RAGE", "Other", "Double tap") },
	fakelag = { ui_reference("AA", "Fake lag", "Enabled") }
}

local references = {
	aa_enable = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
	yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
	fyawlimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
	pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
	freestanding_byaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
	safe_point = ui.reference("RAGE", "Aimbot", "Force safe point"),
	double_tap_mode = ui.reference("RAGE", "Other", "Double tap mode"),
	double_tap_fake_lag_limit = ui.reference("RAGE", "Other", "Double tap fake lag limit"),
	double_tap_hc = ui.reference("RAGE", "Other", "Double tap hit chance"),
	fake_variance = ui.reference("AA", "Fake lag", "Variance"),
	fake_lag = ui.reference("AA", "Fake lag", "Limit"),
	fake_lag_type = ui.reference("AA", "Fake lag", "Amount"),
	legmovement = ui.reference("AA", "OTHER", "leg movement"),
	tickstoprocess = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
	holdaim = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim"),
	tomi = ui.reference("Rage", "Other", "Force body aim"),
	fakeduck = ui.reference("Rage", "Other", "Duck peek assist"),
	onShot = {ui.reference("AA", "Other", "On shot anti-aim")},
}

local yaw2, yaw = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local bodyyaw, bodyyaw2 = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local jyaw, jyawslide = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")

local variables = {
	legit_changed = false,
	player_states = {"global", "standing", "moving", "slow motion", "air", "on-key", "crouched", "moving two", "dormant", "freestanding"},
	state_to_idx = {["global"] = 1, ["standing"] = 2, ["moving"] = 3, ["slow motion"] = 4, ["air"] = 5, ["on-key"] = 6, ["crouched"] = 7, ["moving two"] = 8, ["dormant"] = 9, ["freestanding"] = 10},
	aa_dir   = 0,
	auto_rage = false,
	active_i = 1,
	last_press_t = 0,
	forward = false,
	p_state = 0,
	last_sway_time = 0,
	choked_cmds = 0,
	miss = {},
	hit = {},
	shots = {},
	last_hit = {},
	stored_misses = {},
	stored_shots = {},
	last_nn = 0,
	best_value = 180,
	flip_value = 90,
	bestenemy = 0,
	flip_once = false,
	classnames = {
	"CWorld",
	"CCSPlayer",
	"CFuncBrush"
	},
	nonweapons = {
	"knife",
	"hegrenade",
	"inferno",
	"flashbang",
	"decoy",
	"smokegrenade",
	"taser"
	},
}

local nonweapons_c = 
{
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

local mshit = {
	active = ui.new_checkbox("AA", "Anti-aimbot angles", 'watermark'),
	color_picker = ui.new_color_picker("AA", "Anti-aimbot angles", 'watermark color picker', 147, 52, 235, 1),
	autobuy = ui.new_checkbox("AA", "Anti-aimbot angles", "fastest autobuy"),
	autobuy_options = ui.new_combobox("AA", "Anti-aimbot angles", "autobuy:", { "awp", "scout", }),
	autobuy_slider = ui.new_slider("AA", "Anti-aimbot angles", "autobuy speed", 0, 100, 25, true, "ms"),
	faster_dt = ui.new_checkbox("AA", "Anti-aimbot angles", "faster doubletap"),
	adaptive_dt = ui.new_checkbox("AA", "Anti-aimbot angles", "ping based doubletap"),
	TwinTower_enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "clantag"),
	
	enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "enable aa"),
	legit_aa_key = ui_new_hotkey("AA", "Anti-aimbot angles", "legit aa on key"),
	manual_left = ui_new_hotkey("AA", "Anti-aimbot angles", "manual left"),
	manual_right = ui_new_hotkey("AA", "Anti-aimbot angles", "manual right"),
	manual_back = ui_new_hotkey("AA", "Anti-aimbot angles", "manual back"),
	manual_forward = ui_new_hotkey("AA", "Anti-aimbot angles", "manual forward"),

	freestand = { ui_new_checkbox("AA", "Anti-aimbot angles", "freestanding\nTS"),
				ui_new_hotkey("AA", "Anti-aimbot angles", "freestanding key", true),
	},

	edge = { ui_new_checkbox("AA", "Anti-aimbot angles", "edge yaw\nTS"), 
			ui_new_hotkey("AA", "Anti-aimbot angles", "edge yaw key", true),
	},

	leg_breaker = ui.new_checkbox("AA", "Other", "leg movement"),

	indicator_enable = ui.new_combobox("AA", "Anti-aimbot angles", "indicators", { "off", "on" }),
	extra_indicators = ui.new_checkbox("AA", "Anti-aimbot angles", "extra skeet indicators"),
	visual_arrows = ui.new_checkbox("AA", "Anti-aimbot angles", "arrow indication"),
	desync = ui.new_checkbox("AA", "Anti-aimbot angles", "desync indicator"),
	desync_where = ui.new_combobox("AA", "Anti-aimbot angles", "desync indicator location", "at crosshair", "at indicators"),
	x_slider = ui.new_slider("VISUALS", "Other ESP", "desync indicator x offset", 0, 960, 87),
	y_slider = ui.new_slider("VISUALS", "Other ESP", "desync indicator y offset", 0, 540, 20),
	visual_text = ui.new_checkbox("AA", "Anti-aimbot angles", "text indication"),
	indicators = ui.new_multiselect("AA", "Anti-aimbot angles", "indicator list", "aa states", "doubletap", "fakeduck", "safepoint", "hideshots", "force body aim", "fakelag", "desync bar", "doubletap icons"),
	doubletap_icons = ui.new_combobox("AA", "Anti-aimbot angles", "doubletap icon type", "classic", "whack"),
	doubletap_icons_ideal = ui.new_checkbox("AA", "Anti-aimbot angles", "compatible with sabbath ideal tick"),

	label = ui.new_label("VISUALS", "Other ESP", "manual aa arrows color"),
	color  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color", 194, 87, 116, 255),
	label2 = ui.new_label("VISUALS", "Other ESP", "sabbath indicator color"),
	color2  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color2", 147, 52, 235, 255),

	label3 = ui.new_label("VISUALS", "Other ESP", "normal aa type color"),
	color3  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color3", 98, 52, 235, 255),

	label4 = ui.new_label("VISUALS", "Other ESP", "opposite aa type color"),
	color4  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color4", 255, 59, 59, 255),

	label5 = ui.new_label("VISUALS", "Other ESP", "low delta aa type color"),
	color5  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color5", 66, 66, 245, 255),

	label6 = ui.new_label("VISUALS", "Other ESP", "jitter aa type color"),
	color6  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color6", 235, 52, 153, 255),

	label15 = ui.new_label("VISUALS", "Other ESP", "crouched aa type color"),
	color15  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color14", 158, 235, 52, 255),

	label7 = ui.new_label("VISUALS", "Other ESP", "legit aa type color"),
	color7  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color7", 52, 128, 235, 255),
	
	label21 = ui.new_label("VISUALS", "Other ESP", "dormant aa type color"),
	color21  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color21", 255, 255, 255, 255),
	
	label22 = ui.new_label("VISUALS", "Other ESP", "freestanding aa type color"),
	color22  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color22", 255, 255, 255, 255),

	label9 = ui.new_label("VISUALS", "Other ESP", "doubletap (not charged color)"),
	color9  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color9", 254, 148, 148, 255),

	label10 = ui.new_label("VISUALS", "Other ESP", "doubletap (charged color)"),
	color10 = ui.new_color_picker("VISUALS", "Other ESP", "indicator color10", 148, 252, 153, 255),

	label11 = ui.new_label("VISUALS", "Other ESP", "fakeduck color"),
	color11  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color11", 255, 255, 255, 255),

	label12 = ui.new_label("VISUALS", "Other ESP", "safepoint color"),
	color12  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color12", 255, 255, 255, 255),

	label13 = ui.new_label("VISUALS", "Other ESP", "hideshots color"),
	color13  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color13", 255, 255, 255, 255),

	label14 = ui.new_label("VISUALS", "Other ESP", "force body aim color"),
	color14  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color13", 255, 255, 255, 255),

	label8 = ui.new_label("VISUALS", "Other ESP", "fakelag color"),
	color8  = ui.new_color_picker("VISUALS", "Other ESP", "indicator color8", 255, 255, 255, 255),

	label16 = ui.new_label("VISUALS", "Other ESP", "bar color"),
	color16 = ui.new_color_picker("VISUALS", "Other ESP", 'bar color', 255, 255, 255, 0.5),
	label17 = ui.new_label("VISUALS", "Other ESP", "second bar color"),
	color17 = ui.new_color_picker("VISUALS", "Other ESP", 'second color bar', 0, 0, 0, 0),
	label18 = ui.new_label("VISUALS", "Other ESP", "bodyyaw indicator color"),
	color18 = ui.new_color_picker("VISUALS", "Other ESP", 'bodyyaw indicator color bar', 158, 235, 52, 0),
	
	label19 = ui.new_label("VISUALS", "Other ESP", "doubletap bullet icon color"),
	color19 = ui.new_color_picker("VISUALS", "Other ESP", 'indicator color19', 255, 255, 255, 255),
	
	label20 = ui.new_label("VISUALS", "Other ESP", "weapon icon color"),
	color20 = ui.new_color_picker("VISUALS", "Other ESP", 'indicator color20', 255, 255, 255, 255),
}

local yaw2, yaw = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local bodyyaw, bodyyaw2 = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local quick_peek_box, quick_peek_key = ui.reference( "Rage", "Other", "Quick peek assist" )

local deez_nutz = { }

deez_nutz[0] = {
	deez_nutz_mode = ui_new_combobox("AA", "Anti-aimbot angles", "Anti-aim mode", {"rage", "legit", "automatic rage"}),
	player_state = ui_new_combobox("AA", "Anti-aimbot angles", "Player state", variables.player_states),
}
ui_set_visible(ref.maxprocticks, true)

for i=1, 10 do
	deez_nutz[i] = {
        enable_shit = i == 6 and ui.get(mshit.legit_aa_key) or ui_new_checkbox("AA", "Anti-aimbot angles", "enable shit" .. string_lower(variables.player_states[i]) .. " anti-aim"),
		pitch_shit = ui_new_combobox("AA", "Anti-aimbot angles", "pitch\n\n shit" .. variables.player_states[i], { "Off", "Default", "Up", "Down", "Minimal", "Random" }),
		yawbase_shit = ui_new_combobox("AA", "Anti-aimbot angles", "yaw base\n shit" .. variables.player_states[i], { "Local view", "At targets" }),
		yaw_shit = ui_new_combobox("AA", "Anti-aimbot angles", "yaw\n shit" .. variables.player_states[i], { "Off", "180", "Spin", "Static", "180 Z", "Crosshair" }),
		yawadd_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nyaw add shit" .. variables.player_states[i], -180, 180, 0),
		yawjitter_shit = ui_new_combobox("AA", "Anti-aimbot angles", "yaw jitter shit\n" .. variables.player_states[i], { "Off", "Offset", "Center", "Random" }),
		yawjitteradd_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nyaw jitter add shit" .. variables.player_states[i], -180, 180, 0),
		aa_mode_shit = ui_new_combobox("AA", "Anti-aimbot angles", "body yaw type shit\n" .. variables.player_states[i], {"sabbath", "gamesense"}),
		gs_bodyyaw_shit = ui_new_combobox("AA", "Anti-aimbot angles", "body yaw\n gs shit" .. variables.player_states[i], { "Off", "Opposite", "Jitter", "Static" }),
		gs_bodyyawadd_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nbody yaw add shit" .. variables.player_states[i], -180, 180, 0),
		bodyyaw_shit = ui_new_combobox("AA", "Anti-aimbot angles", "body yaw shit\n" .. variables.player_states[i], { "off", "opposite", "freestanding", "reversed freestanding", "jitter", "random", "max", "max jitter", "max jitter freestand", "ideal"}),
		bodyyaw_settings_shit = ui_new_multiselect("AA", "Anti-aimbot angles", "body yaw settings shit\n" .. variables.player_states[i], { "jitter when vulnerable", "anti-resolver", "detect missed angle"}),
		fakeyawlimit_shit = ui_new_slider("AA", "Anti-aimbot angles", "fake yaw limit shit\n" .. variables.player_states[i], 0, 60, 60),
		fakeyawmode_shit = ui_new_combobox("AA", "Anti-aimbot angles", "customize fake yaw limit shit\n" .. variables.player_states[i], { "off", "jitter", "random", "smart", "custom right" }),
		fakeyawamt_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nfake yaw randomization shit" .. variables.player_states[i], 0, 60, 0),
	}
end
ui_set(deez_nutz[1].enable_shit, true)
ui_set_visible(deez_nutz[1].enable_shit, false)

deez_nutz[11] = {
	aa_settings = ui_new_multiselect("aa", "fake lag", "anti-aim settings shit", {"anti-aim on use", "disable use to plant"}),
}

for i=1, 64 do
    variables.miss[i], variables.hit[i], variables.shots[i], variables.last_hit[i], variables.stored_misses[i], variables.stored_shots[i] = {}, {}, {}, 0, 0, 0
	for k=1, 3 do
		variables.miss[i][k], variables.hit[i][k], variables.shots[i][k] = {}, {}, {}
		for j=1, 1000 do
			variables.miss[i][k][j], variables.hit[i][k][j], variables.shots[i][k][j] = 0, 0, 0
		end
	end
	variables.miss[i][4], variables.hit[i][4], variables.shots[i][4] = 0, 0, 0
end

local function contains(table, value)

	if table == nil then
		return false
	end
	
    table = ui_get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local ctag = 'sabbath'

-- Things
local ffi = require 'ffi'
local interface_ptr = ffi.typeof('void***')
local latency_ptr = ffi.typeof('float(__thiscall*)(void*, int)')

local rawivengineclient = client.create_interface('engine.dll', 'VEngineClient014') or error('VEngineClient014 wasnt found', 2)
local ivengineclient = ffi.cast(interface_ptr, rawivengineclient) or error('rawivengineclient is nil', 2)

local get_net_channel_info = ffi.cast('void*(__thiscall*)(void*)', ivengineclient[0][78]) or error('ivengineclient is nil')
local is_in_game = ffi.cast('bool(__thiscall*)(void*)', ivengineclient[0][26]) or error('is_in_game is nil')

local notes = (function(b)local c=function(d,e)local f={}for g in pairs(d)do table.insert(f,g)end;table.sort(f,e)local h=0;local i=function()h=h+1;if f[h]==nil then return nil else return f[h],d[f[h]]end end;return i end;local j={get=function(k)local l,m=0,{}for n,o in c(package.cnotes)do if o==true then l=l+1;m[#m+1]={n,l}end end;for p=1,#m do if m[p][1]==b then return k(m[p][2]-1)end end end,set_state=function(q)package.cnotes[b]=q;table.sort(package.cnotes)end,unset=function()client.unset_event_callback('shutdown',callback)end}client.set_event_callback('shutdown',function()if package.cnotes[b]~=nil then package.cnotes[b]=nil end end)if package.cnotes==nil then package.cnotes={}end;return j end)('a_watermark')

local paint_handler = function()
    notes.set_state(ui.get(mshit.active))
    notes.get(function(id)
        local sys_time = { client.system_time() }
        local actual_time = string.format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

        local text = string.format('%s | %s | %s', ctag, 'sabbath', actual_time)

        if is_in_game(is_in_game) == true then
            local INetChannelInfo = ffi.cast(interface_ptr, get_net_channel_info(ivengineclient)) or error('netchaninfo is nil')
            local get_avg_latency = ffi.cast(latency_ptr, INetChannelInfo[0][10])
            local latency = get_avg_latency(INetChannelInfo, 0) * 1000
            local tick = 1/globals.tickinterval()
			local ticks = ui.get(references.tickstoprocess)
            
			if ui.get(references.tickstoprocess) == 62 then
				text = string.format('%s | %s | Ticks Shifted: 16 | Ping: %dms | %dTick | %s', entity.get_player_name(entity.get_local_player()), 'sabbath', latency, tick, actual_time)
			else
				text = string.format('%s | %s | Ticks Shifted: 16 | Ping: %dms | %dTick | %s', entity.get_player_name(entity.get_local_player()), 'sabbath', latency, tick, actual_time)
			end
			
        local r, g, b, a = ui.get(mshit.color_picker)
        local h, w = 18, renderer.measure_text(nil, text) + 8
        local x, y = client.screen_size(), 10 + (25*id)

        x = x - w - 10

        renderer.rectangle(x, y, w, 2, r, g, b, 255)
        renderer.rectangle(x, y + 2, w, h, 17, 17, 17, a)
        renderer.text(x+4, y + 4, 255, 255, 255, 255, '', 0, text)
    end
	end)
end

local bought
local test = 0
local world_time = 0

function jew()
if not ui.get(mshit.autobuy) then return end
local weapon_name = entity_get_classname(entity.get_player_weapon(local_player))
	world_time2 = globals.curtime()
	difference = world_time2 - world_time

	if entity.is_alive(local_player) then
		if ui.get(mshit.autobuy_options) == "awp" then
			if weapon_name ~= "CWeaponAWP" then
				client.exec("buy awp;")
				client.color_log(3, 252, 119, "[sabbath] tried buying awp at: ", difference)
			end
		elseif ui.get(mshit.autobuy_options) == "scout" then
			if weapon_name ~= "CWeaponSSG08" then
				client.exec("buy ssg08;")
				client.color_log(3, 252, 119, "[sabbath] tried buying scout at: ", difference)
			end
		end
	end
end

local function autobuy_paint()
	crackers = ui.get(mshit.autobuy_slider) / 100
	if not bought then
		client.delay_call(test - crackers - 0.01, jew)
		client.delay_call(test - crackers - 0.0005, jew)
		client.delay_call(test - crackers - 0.0005, jew)
		client.delay_call(test, jew)
		client.delay_call(test + crackers + 0.0005, jew)
		client.delay_call(test + crackers + 0.0005, jew)
		client.delay_call(test + crackers + 0.01, jew)
		bought = true
	end
end

create_callback("round_end", function ()
if not ui.get(mshit.autobuy) then return end
	test = cvar.mp_round_restart_delay:get_float()
	if ui.get(mshit.autobuy_options) == "awp" then
		if weapon_name ~= "CWeaponAWP" then
			bought = false
		end
	elseif ui.get(mshit.autobuy_options) == "scout" then
		if weapon_name ~= "CWeaponSSG08" then
			bought = false
		end
	else
		bought = true
	end
end)

create_callback("round_prestart", function ()
if not ui.get(mshit.autobuy) then return end
	world_time = globals.curtime()
	print("Preround: ", globals.curtime())
	jew()
	client.delay_call(0.010, jew)
	client.delay_call(0.025, jew)
	client.delay_call(0.045, jew)
end)

local TwinTowerClantag = 
{
	"",
    "s",
    "sa",
    "sab",
    "sabb",
    "sabba",
    "sabbat",
    "sabbath",
    "sabbath ",
    "sabbath ",
    "sabbath ",
    "sabbath",
	"sabbat",
	"sabba",
    "sabb",
    "sab",
    "sa",
    "s",
    "",
} 
local cur = 1
local oldTick = globals.tickcount()
local function get_twint(e)
    if not ui.get(mshit.TwinTower_enabled) then return end
	
    if globals.tickcount() - oldTick > 5 then
        cur = math.floor(globals.curtime() % 19 + 1)
        client.set_clan_tag(TwinTowerClantag[cur])
        oldTick = globals.tickcount()
    end
end
create_callback("player_connect_full", function(e)
    oldTick = globals.tickcount()
	
	if client.userid_to_entindex(e) == local_player then
		test = 0
		bought = false
	end
end)

local dt_latency = 0
local function doubletap()
    if not ui.get(mshit.faster_dt) then return end
	
	ui.set(references.fake_lag, math.min(15, ui.get(references.fake_lag)))
	ui.set_visible(references.tickstoprocess, false)

    if ui.is_menu_open() or ui.get(references.fakeduck) or not entity.is_alive(local_player) or not (ui_get(ref.dt[1]) and ui_get(ref.dt[2])) then
        ui.set(references.tickstoprocess, 16)
    elseif ui.get(quick_peek_box) and ui.get(quick_peek_key) then
		ui.set(references.tickstoprocess, 62)
	else
        if ui.get(mshit.adaptive_dt) then
            if dt_latency <= 20 then
                ui.set(references.tickstoprocess, 18)
            elseif dt_latency <= 40 then
                ui.set(references.tickstoprocess, 18)
            elseif dt_latency <= 65 then
                ui.set(references.tickstoprocess, 18)
            elseif dt_latency <= 95 then
                ui.set(references.tickstoprocess, 17)
            else
                ui.set(references.tickstoprocess, 17)
            end
        else
            ui.set(references.tickstoprocess, 18)
			
			--[[
			cvar.cl_clock_correction:set_int(1)
			cvar.cl_clock_correction_adjustment_max_amount:set_int(200)
			cvar.cl_clock_correction_adjustment_max_offset:set_int(90)
			cvar.cl_clock_correction_adjustment_min_offset:set_int(10)
			cvar.cl_clock_correction_force_server_tick:set_int(999)
			cvar.cl_clockdrift_max_ms:set_int(150)
			-]]
        end
    end
end
create_callback("run_command", doubletap) --setup command to have perfect dt target switch, run command to have fastest dt possible (laggy?)

local function desync_on()
	ui.set(references.aa_enable, true)
end

local function desync_off()
	ui.set(references.aa_enable, false)
end

local jafeth = false

local function delaytimer()
	jafeth = true
end

local function aimFire()
	if not ui.get(mshit.enabled) then return end
	if variables.p_state == 6 then return end
	
	kneegrow = math.random(1, 5)
	kneegrow2 = math.random(5, 12)

	if not (ui_get(ref.dt[1]) and ui_get(ref.dt[2])) and (ui_get(ref.os[1]) and ui_get(ref.os[2])) or ui.get(ref.fakeduck) then else
	--[[
		client.delay_call(0.07, desync_off)
		client.delay_call(0.15, desync_on)
	--]]
		--client.delay_call((kneegrow/100), desync_off)
		--client.delay_call((kneegrow2/100), desync_on)
	end
	--[[
	
	if jafeth == true then
		jafeth = false
	else
		jafeth = true
	end
	--]]
end
create_callback("aim_fire", aimFire)


local function set_og_menu(state)
	ui_set_visible(ref.pitch, state)
	ui_set_visible(ref.yawbase, state)
	ui_set_visible(ref.yaw[1], state)
	ui_set_visible(ref.yaw[2], state)
	ui_set_visible(ref.yawjitter[1], state)
	ui_set_visible(ref.yawjitter[2], state)
	ui_set_visible(ref.bodyyaw[1], state)
	ui_set_visible(ref.bodyyaw[2], state)
	ui_set_visible(ref.fakeyawlimit, state)
	ui_set_visible(ref.fsbodyyaw, state)
	ui_set_visible(ref.edgeyaw, state)
	ui_set_visible(ref.freestand[1], state)
	ui_set_visible(ref.freestand[2], state)
end

local function menu_elements()
	set_og_menu(false)

	ui_set_visible(deez_nutz[0].player_state, false)
	ui_set_visible(deez_nutz[0].deez_nutz_mode, false)
	ui_set_visible(deez_nutz[11].aa_settings, false)

    for i=1, 10 do
		ui_set_visible(deez_nutz[i].enable_shit, false)
		
        ui_set_visible(deez_nutz[i].pitch_shit, false)
		ui_set_visible(deez_nutz[i].yawbase_shit, false)
		ui_set_visible(deez_nutz[i].yaw_shit, false)
		ui_set_visible(deez_nutz[i].yawadd_shit, false)
		ui_set_visible(deez_nutz[i].yawjitter_shit, false)
		ui_set_visible(deez_nutz[i].yawjitteradd_shit, false)

		ui_set_visible(deez_nutz[i].aa_mode_shit, false)

		ui_set_visible(deez_nutz[i].gs_bodyyaw_shit, false)
		ui_set_visible(deez_nutz[i].gs_bodyyawadd_shit, false)

		ui_set_visible(deez_nutz[i].bodyyaw_shit, false)
		ui_set_visible(deez_nutz[i].bodyyaw_settings_shit, false)
		
		ui_set_visible(deez_nutz[i].fakeyawlimit_shit, false)
		ui_set_visible(deez_nutz[i].fakeyawmode_shit, false)
		ui_set_visible(deez_nutz[i].fakeyawamt_shit, false)
	end
end

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function round(num, decimals)
	local mult = 10^(decimals or 0)
	return math_floor(num * mult + 0.5) / mult
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
	local ydelta = local_y - enemy_y
	local xdelta = local_x - enemy_x
	local relativeyaw = math_atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math_pi )
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

local function calc_shit(xdelta, ydelta)
    if xdelta == 0 and ydelta == 0 then
        return 0
	end
	
    return math_deg(math_atan2(ydelta, xdelta))
end

local function get_damage(plocal, enemy, x, y,z)
	local ex = { }
	local ey = { }
	local ez = { }
	ex[0], ey[0], ez[0] = entity_hitbox_position(enemy, 1)
	ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
	ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
	ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
	ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
	ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
	ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
	local ent, dmg = 0
	for i=0, 6 do
		if dmg == 0 or dmg == nil then
			ent, dmg = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
		end
	end
	return ent == nil and client_scale_damage(plocal, 1, dmg) or dmg
end

local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

local function get_nearest_enemy(plocal, enemies)
	local lx, ly, lz = client_eye_position()
	local view_x, view_y, roll = client_camera_angles()

	local bestenemy = nil
    local fov = 180
    for i=1, #enemies do
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math_abs(normalize_yaw(calc_shit(lx - cur_x, ly - cur_y) - view_y + 180))
        if cur_fov < fov then
			fov = cur_fov
			bestenemy = enemies[i]
		end
	end

	return bestenemy
end

local function get_entities(enemy_only, alive_only)
	local enemy_only = enemy_only ~= nil and enemy_only or false
    local alive_only = alive_only ~= nil and alive_only or true
    
    local result = {}
    local player_resource = entity.get_player_resource()
    
	for player = 1, globals.maxplayers() do
		if entity.get_prop(player_resource, 'm_bConnected', player) == 1 then
            local is_enemy, is_alive = true, true
            
			if enemy_only and not entity.is_enemy(player) then is_enemy = false end
			if is_enemy then
				if alive_only and entity.get_prop(player_resource, 'm_bAlive', player) ~= 1 then is_alive = false end
				if is_alive then table.insert(result, player) end
			end
		end
	end

	return result
end

local function is_valid(nn)
	if nn == 0 then
		return false
	end

	if not entity_is_alive(nn) then
		return false
	end

	if entity_is_dormant(nn) then
		return false
	end

	return true
end


local function get_best_desync()
	local plocal = entity.get_local_player()
	
    local lx, ly, lz = client_eye_position()
	local view_x, view_y, roll = client_camera_angles()

	local enemies = entity_get_players(true)

	if #enemies == 0 then
		if not variables.auto_rage then
			if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "opposite" then
				variables.best_value = 180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "jitter" then
				variables.best_value = 0
			else
				if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "random" then
					variables.best_value = math.random(0, 60)
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max" then
					variables.best_value = 180
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter" then
					variables.best_value = 90
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter freestand" then
					variables.best_value = -90
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "ideal" then
					variables.best_value = -141
				else
					variables.best_value = 90
				end
			end
		else
			if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "random" then
				variables.best_value = math.random(0, 60)
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max" then
				variables.best_value = 180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter" then
				variables.best_value = 90
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter freestand" then
					variables.best_value = -90
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "ideal" then
				variables.best_value = -141
			else
				variables.best_value = 90
			end
		end

		return variables.best_value
    end

	variables.bestenemy = is_valid(variables.last_nn) and variables.last_nn or get_nearest_enemy(plocal, enemies)

    if variables.bestenemy ~= nil and variables.bestenemy ~= 0 and entity_is_alive(variables.bestenemy) then
        local calc_hit = variables.last_hit[variables.bestenemy] ~= 0 and contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "anti-resolver")
        local calc_miss = variables.miss[variables.bestenemy][4] > 0 and contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "anti-resolver")

		if not calc_hit and not calc_miss then
            local e_x, e_y, e_z = entity_hitbox_position(variables.bestenemy, 0)

            local yaw = calc_angle(lx, ly, e_x, e_y)
            local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
			local rend_x = lx + rdir_x * 10
            local rend_y = ly + rdir_y * 10
            
            local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
			local lend_x = lx + ldir_x * 10
            local lend_y = ly + ldir_y * 10
            
			local r2dir_x, r2dir_y, r2dir_z = angle_vector(0, (yaw + 90))
			local r2end_x = lx + r2dir_x * 100
			local r2end_y = ly + r2dir_y * 100

			local l2dir_x, l2dir_y, l2dir_z = angle_vector(0, (yaw - 90))
			local l2end_x = lx + l2dir_x * 100
            local l2end_y = ly + l2dir_y * 100      
			
			local ldamage = get_damage(plocal, variables.bestenemy, rend_x, rend_y, lz)
			local rdamage = get_damage(plocal, variables.bestenemy, lend_x, lend_y, lz)

			local l2damage = get_damage(plocal, variables.bestenemy, r2end_x, r2end_y, lz)
			local r2damage = get_damage(plocal, variables.bestenemy, l2end_x, l2end_y, lz)

			if not variables.auto_rage and ldamage > 0 and rdamage > 0 and contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "jitter when vulnerable") then
				variables.best_value = 0
			else
				if not variables.auto_rage then
					if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "opposite" then
						variables.best_value = 180
					elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "jitter" then
						variables.best_value = 0
					elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "random" then
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = math.random(-60, 0)
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = math.random(0, 60)
						end
					elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max" then
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -180
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 180
						end
					elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter" then
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -90
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 90
						end
					elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter freestand" then
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = 90
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = -90
						end
					elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "ideal" then
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -141
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 141
						end
					else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "freestanding" and -90 or 90
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "freestanding" and 90 or -90
						end
					end
				else
					if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
						variables.best_value = 90
					elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
						variables.best_value = -90
					end
				end
			end
        elseif calc_hit then
			if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "ideal" then
				variables.best_value = variables.last_hit[variables.bestenemy] == -141 and 141 or -141
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max" then
				variables.best_value = variables.last_hit[variables.bestenemy] == 180 and -180 or 180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "random" then
				variables.best_value = variables.last_hit[variables.bestenemy] == math.random(150, 180) and math.random(-180, 150) or math.random(150, 180)
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter" then
				variables.best_value = variables.last_hit[variables.bestenemy] == -90 and 90 or -90
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter freestand" then
				variables.best_value = variables.last_hit[variables.bestenemy] == 90 and -90 or 90
			else
				variables.best_value = variables.last_hit[variables.bestenemy] == 90 and -90 or 90
			end
        elseif calc_miss then
			if variables.stored_misses[variables.bestenemy] ~= variables.miss[variables.bestenemy][4] then
                variables.best_value = variables.miss[variables.bestenemy][2][variables.miss[variables.bestenemy][4]]
                variables.stored_misses[variables.bestenemy] = variables.miss[variables.bestenemy][4]
            end
        end
	else
		if not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "opposite" then
			variables.best_value = 180
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "jitter" then
			variables.best_value = 0
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "ideal" then
			variables.best_value = -141
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max" then
			variables.best_value = 180
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "random" then
			variables.best_value = math.random(0, 60)
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter" then
			variables.best_value = -90
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter freestand" then
			variables.best_value = 90
		else
			variables.best_value = 90
		end
	end
	
    return variables.best_value
end

local function run_direction()

	ui_set(ref.freestand[2], "always on")
	ui_set(mshit.manual_back, "on hotkey")
	ui_set(mshit.manual_forward, "on hotkey")
	ui_set(mshit.manual_left, "on hotkey")
	ui_set(mshit.manual_right, "on hotkey")
	
	local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1 and not client.key_state(0x20)
	local p_key = ui.get(mshit.legit_aa_key)

	local fs_e = ui_get(mshit.freestand[2]) and ui_get(mshit.freestand[1]) and on_ground and not p_key
	local edge_e = ui_get(mshit.edge[2]) and ui_get(mshit.edge[1]) and on_ground and not p_key
	
	ui_set(ref.freestand[1], fs_e and "Default" or "-")
	ui_set(ref.edgeyaw, edge_e)

	
		if ui_get(mshit.manual_back) then
			if fs_e then
				variables.last_press_t = globals_curtime()
			end
			variables.aa_dir = 0
		elseif ui_get(mshit.manual_right) and variables.last_press_t + 0.2 < globals_curtime() then
			variables.aa_dir = variables.aa_dir == 90 and 0 or 90
			variables.last_press_t = globals_curtime()
		elseif ui_get(mshit.manual_left) and variables.last_press_t + 0.2 < globals_curtime() then
			variables.aa_dir = variables.aa_dir == -90 and 0 or -90
			variables.last_press_t = globals_curtime()
		elseif ui_get(mshit.manual_forward) and variables.last_press_t + 0.2 < globals_curtime() then
			variables.aa_dir = variables.aa_dir == 180 and 0 or 180
			variables.last_press_t = globals_curtime()
		elseif variables.last_press_t > globals_curtime() then
			variables.last_press_t = globals_curtime()
		end
end

local timeToShoot = 0
local shooting = false
local record_shit = 10
local function run_shit(c)
	local has_knife
	local vx, vy, vz = entity_get_prop(entity.get_local_player(), "m_vecVelocity")
	local is_scoped = entity_get_prop(entity.get_local_player(), "m_bIsScoped")
	local p_still = math_sqrt(vx ^ 2 + vy ^ 2) < 2
	local p_still2 = math_sqrt(vx ^ 2 + vy ^ 2) < 90
	local on_ground = bit_band(entity_get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1 and c.in_jump == 0
	local p_slow = ui_get(ref.slow[1]) and ui_get(ref.slow[2])
	local p_key = ui.get(mshit.legit_aa_key)
	local p_duck = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
	local weapon = entity.get_player_weapon(entity.get_local_player())
    local weapon_id = bit_band(entity_get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)
	local camera_angles = vector(client_camera_angles())
    local eye_position_x, eye_position_y, eye_position_z = client_eye_position()
	local hitbox_pos_x, hitbox_pos_y, hitbox_pos_z = entity_hitbox_position(entity.get_local_player(), 0)
    local substract = hitbox_pos_z - eye_position_z
	local local_player_weapon = entity.get_player_weapon(entity.get_local_player())
	local cur = globals.curtime()
	
	shooting = false
	
    if cur < entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") then
		if weapon_id == 9 then
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 1.2
		elseif weapon_id == 40 then
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 1
		elseif weapon_id == 64 then
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 0.2
		else
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 0.08 --shooting
		end
		shooting = true
    elseif cur < entity.get_prop(entity.get_local_player(), "m_flNextAttack") then
        timeToShoot = entity.get_prop(entity.get_local_player(), "m_flNextAttack") - cur - 0.022 --swapping
	end
	
	--client.log(record_shit)
	--client.log(weapon_id)
	--client.log(timeToShoot)

    if math.floor((timeToShoot * 1000) + 0.5) <= 10 then
        timeToShoot = 0
    end

    if timeToShoot > 1.9 then
        timeToShoot = 0
    end
	
	--client.log(shooting)
	--client.log(timeToShoot)
	--client.log(substract)

	local fs_e = ui_get(mshit.freestand[2]) and ui_get(mshit.freestand[1]) and on_ground and not p_key
	local nigger = math.random(0, 2) -- 0, 10
	variables.p_state = p_key and 6 or 9
	
	local enemies = get_entities(true, true)
	
    for i=1, #enemies do
        local player = enemies[i]
        local x, y, z = entity.get_prop(player, "m_vecOrigin")
		local lx, ly, lz = entity_get_prop(entity.get_local_player(), "m_vecOrigin")
        local distance = get_distance(lx, ly, lz, x, y, z)
		
		if x == nil or y == nil or z == nil or lx == nil or ly == nil or lz == nil or distance == nil then 
			ass = false 
		else 
			ass = true 
		end
		
        local weapon = entity.get_player_weapon(player)
		
		--if p_key or ((entity_get_classname(weapon) == "CKnife" and distance <= 270) and variables.aa_dir ~= 180 and ass) then
		
		if ((entity_get_classname(weapon) == "CKnife" and distance <= 270) and variables.aa_dir ~= 180 and ass) then
			has_knife = true
		else
			has_knife = false
		end
		
		if p_key or has_knife then  --if ((substract > -4) and on_ground and not (p_duck >= 0.7) and not p_key) or not entity.is_alive(player) and not p_key then
			variables.p_state = 6
		else
			if timeToShoot >= 0.022 or not entity.is_alive(player) then
				variables.p_state = 9
			else
				if not on_ground and ui_get(deez_nutz[5].enable_shit) then
					variables.p_state = 5
				else
					if fs_e then
						variables.p_state = 10
					else
						if (p_duck >= 0.7 or ui.get(references.fakeduck)) and ui_get(deez_nutz[7].enable_shit) then
							variables.p_state = 7
						else
							if p_slow and ui_get(deez_nutz[4].enable_shit) and not p_still then
								variables.p_state = 4
							else
								if p_still and ui_get(deez_nutz[2].enable_shit) then
									variables.p_state = 2
								elseif not p_still and ui_get(deez_nutz[3].enable_shit) and ui_get(deez_nutz[8].enable_shit) then
									if is_scoped == 1 then -- and not p_still2 then
										variables.p_state = 8
									else
										variables.p_state = 3
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	--[[
	if ui.get(mshit.leg_breaker) then
		if (bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1) then
			if nigger <= 5 then
				ui.set(references.legmovement, "never slide") --never slide
			else
				ui.set(references.legmovement, "always slide")
			end
		else 
			ui.set(references.legmovement, "off")
		end
	end--]]
	
	if ui.get(mshit.leg_breaker) then
		if (bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1) then
			if nigger <= 2 then --5
				ui.set(references.legmovement, "always slide") --never slide
			end
			if nigger == 1 then
				ui.set(references.legmovement, "never slide")
			end
		else 
			ui.set(references.legmovement, "off")
		end
	end
end

create_callback("pre_render", function()
	if not entity.is_alive(entity.get_local_player()) then return end
    if ui.get(mshit.leg_breaker) then
		on_ground = bit_band(entity_get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1
		entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, on_ground and 0 or 6) --legs
    end
end)

local function distance3d(x1, y1, z1, x2, y2, z2)
	return math_sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
end

local function entity_has_c4(ent)
	local bomb = entity_get_all("CC4")[1]
	return bomb ~= nil and entity_get_prop(bomb, "m_hOwnerEntity") == ent
end

local function aa_on_use(c)

	if contains(deez_nutz[11].aa_settings, "Anti-aim on use") then
		local distance = 100
		local bomb = entity_get_all("CPlantedC4")[1]
		local bomb_x, bomb_y, bomb_z = entity_get_prop(bomb, "m_vecOrigin")

		if bomb_x ~= nil then
			local player_x, player_y, player_z = entity_get_prop(entity.get_local_player(), "m_vecOrigin")
			distance = distance3d(bomb_x, bomb_y, bomb_z, player_x, player_y, player_z)
		end
		
		local team_num = entity_get_prop(entity.get_local_player(), "m_iTeamNum")
		local defusing = team_num == 3 and distance < 62

		local on_bombsite = entity_get_prop(entity.get_local_player(), "m_bInBombZone")

		local has_bomb = entity_has_c4(entity.get_local_player())
		local trynna_plant = on_bombsite ~= 0 and team_num == 2 and has_bomb and not contains(deez_nutz[11].aa_settings, "disable use to plant")
		
		local px, py, pz = client_eye_position()
		local pitch, yaw = client_camera_angles()
	
		local sin_pitch = math_sin(math_rad(pitch))
		local cos_pitch = math_cos(math_rad(pitch))
		local sin_yaw = math_sin(math_rad(yaw))
		local cos_yaw = math_cos(math_rad(yaw))

		local dir_vec = { cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch }

		local fraction, entindex = client_trace_line(entity.get_local_player(), px, py, pz, px + (dir_vec[1] * 8192), py + (dir_vec[2] * 8192), pz + (dir_vec[3] * 8192))

		local using = true

		if entindex ~= nil then
			for i=0, #variables.classnames do
				if entity_get_classname(entindex) == variables.classnames[i] then
					using = false
				end
			end
		end

		if not using and not trynna_plant and not defusing then
			c.in_use = 0
		end
	end
end

local function handle_shots()
	local enemies = entity_get_players(true)

	for i=1, #enemies do
		local idx = enemies[i]
		local s = variables.shots[idx][4]
		local h = variables.hit[idx][4]

		if s ~= variables.stored_shots[idx] then
			local missed = true
			
			if variables.shots[idx][1][s] == variables.hit[idx][1][h] then
				if variables.hit[idx][2][h] ~= 0 and variables.hit[idx][2][h] ~= 180 then
					variables.last_hit[idx] = variables.hit[idx][2][h]
				end
				missed = false
			end

			if missed then
				variables.last_hit[idx] = 0
				variables.hit[idx][2][h] = 0
				variables.miss[idx][4] = variables.miss[idx][4] + 1
				variables.miss[idx][2][variables.miss[idx][4]] = variables.shots[idx][2][s]
			end

			variables.last_nn = idx
			variables.stored_shots[idx] = s
		end
	end
end

local OldChoke = 0
--local toDraw5 = 0
local toDraw4 = 0
local toDraw3 = 0
local toDraw2 = 0
local toDraw1 = 0
local toDraw0 = 0
local angle = 0

local function fakelag_visuals(c)
	if c.chokedcommands < OldChoke then --sent
		toDraw0 = toDraw1
		toDraw1 = toDraw2
		toDraw2 = toDraw3
		toDraw3 = toDraw4
		toDraw4 = OldChoke
		--toDraw5 = ui.get(ref.fake_variance)
	end
	OldChoke = c.chokedcommands
	
	if c.chokedcommands == 0 then
		angle = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))
	end
end

local function on_setup_command(c)

    if not ui_get(ref.enabled) then
        return
	end

	run_shit(c)
	run_direction()
	handle_shots()
	aa_on_use(c)
	--doubletap()
	fakelag_visuals(c)
	
	local best_desync = get_best_desync()

	local k = { ui_get(mshit.legit_aa_key) }

	local doubletapping = ui_get(ref.dt[1]) and ui_get(ref.dt[2])
	local onshotaa = ui_get(ref.os[1]) and ui_get(ref.os[2])
	local low_legit_fl = ui_get(ref.fl_limit) < 3 and ui_get(deez_nutz[0].deez_nutz_mode) == "Legit"
	local exploiting = doubletapping or onshotaa or low_legit_fl

	local holding_e = (k[1] and k[3] == 69) or (variables.auto_rage and client_key_state(69))
	local yaw_to_add = holding_e and 0 or variables.aa_dir
	variables.forward = ui_get(ref.yaw[2]) == 180

	if ui_get(deez_nutz[0].deez_nutz_mode) == "rage" then
		ui_set(ref.pitch, ui_get(deez_nutz[variables.p_state].pitch_shit))
		ui_set(ref.yawbase, variables.aa_dir == 180 and "At targets" or variables.aa_dir == 0 and ui_get(deez_nutz[variables.p_state].yawbase_shit) or "Local view")
		ui_set(ref.yaw[1], ui_get(deez_nutz[variables.p_state].yaw_shit))
		ui_set(ref.yaw[2], normalize_yaw(ui_get(deez_nutz[variables.p_state].yawadd_shit) + yaw_to_add))
		ui_set(ref.yawjitter[1], ui_get(deez_nutz[variables.p_state].yawjitter_shit))
		ui_set(ref.yawjitter[2], ui_get(deez_nutz[variables.p_state].yawjitteradd_shit))
	elseif holding_e or ui_get(deez_nutz[0].deez_nutz_mode) == "legit" then
		ui_set(ref.pitch, "Off")
		ui_set(ref.yawbase, "Local view")
		ui_set(ref.yaw[1], "Off")
		ui_set(ref.yaw[2], 180)
	else
		ui_set(ref.pitch, "Default")
		ui_set(ref.yawbase, variables.aa_dir == 0 and "At targets" or "Local view")
		ui_set(ref.yaw[1], "180")
		ui_set(ref.yaw[2], yaw_to_add)
		ui_set(ref.yawjitter[1], "Off")
	end

	local fakelimit = variables.auto_rage and 60 or ui_get(deez_nutz[variables.p_state].fakeyawlimit_shit)
	local fakemode = variables.auto_rage and "random" or ui_get(deez_nutz[variables.p_state].fakeyawmode_shit)
	local fakeamt = variables.auto_rage and 30 or ui_get(deez_nutz[variables.p_state].fakeyawamt_shit)
	local testnigger = 0

	if fakemode == "jitter" then
		if testnigger == 0 then
			testnigger = 1
		else
			testnigger = 0
		end
		fakelimit = testnigger == 1 and fakeamt or fakelimit
	elseif fakemode == "random" then
		fakelimit = client_random_int(math_max(math_min(60, fakelimit - fakeamt), 0), fakelimit)
	elseif fakemode == "smart" then
		fakelimit = best_desync == 90 and 40 or fakelimit
	end

	ui_set(ref.fakeyawlimit, holding_e and 60 or fakelimit)

	if variables.auto_rage then
		if best_desync == 0 or best_desync == 180 then
			ui_set(ref.bodyyaw[1], best_desync == 0 and "Jitter" or "Opposite")
			ui_set(ref.bodyyaw[2], 0)
		else
			ui_set(ref.bodyyaw[1], "Static")
			ui_set(ref.bodyyaw[2], variables.forward and -best_desync or best_desync)
		end
	else
		if ui_get(deez_nutz[variables.p_state].aa_mode_shit) == "sabbath" then
			if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) ~= "Off" then
				if best_desync == 0 or best_desync == 180 then
					ui_set(ref.bodyyaw[1], best_desync == 0 and "Jitter" or "Opposite")
					ui_set(ref.bodyyaw[2], 0)
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter" or ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "max jitter freestand" then
					ui_set(ref.bodyyaw[1], "Jitter")
					ui_set(ref.bodyyaw[2], variables.forward and -best_desync or best_desync)
				else
					ui_set(ref.bodyyaw[1], "Static")
					ui_set(ref.bodyyaw[2], variables.forward and -best_desync or best_desync)
				end
			else
				ui_set(ref.bodyyaw[1], "Off")
			end
		else
			ui_set(ref.bodyyaw[1], ui_get(deez_nutz[variables.p_state].gs_bodyyaw_shit))
			ui_set(ref.bodyyaw[2], ui_get(deez_nutz[variables.p_state].gs_bodyyawadd_shit))
		end
	end
	
	variables.choked_cmds = c.chokedcommands
	set_og_menu(false)
end

local screen = {client.screen_size()}
local center = {screen[1]/2, screen[2]/2}

local function doubletap_charged()
    -- Make sure we have doubletap enabled, are holding our doubletap key & we aren't fakeducking.
    if not ui_get(ref.dt[1]) or not ui_get(ref.dt[2]) or ui.get(references.fakeduck) then return false end

    -- Sanity checks on local player (since paint & a few other events run even when dead).
    if not entity.is_alive(entity.get_local_player()) or entity.get_local_player() == nil then return end

    -- Get our local players weapon.
    local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")

    -- Make sure that it is valid.
    if weapon == nil then return false end

    -- Basic definitions used to calculate if we have recently shot or swapped weapons.
    local next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
	local jewfag = entity.get_prop(weapon, "m_flNextPrimaryAttack")
	
	if jewfag == nil then return end
	
    local next_primary_attack = jewfag + 0.5

    -- Make sure both values are valid.
    if next_attack == nil or next_primary_attack == nil then return false end

    -- Return if both are under 0 meaning our doubletap is charged / we can fire (you can also use these values as a 2nd return parameter to get the charge %).
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end

local function on_paint()
    if not ui.get(mshit.enabled) or ui.get(mshit.indicator_enable) == "Off" or entity.get_local_player() == nil or not entity.is_alive(entity.get_local_player()) then return end
	
	h_index = 0

    color_g = {ui.get(mshit.color)}
	color_g2 = {ui.get(mshit.color2)}
	color_g3 = {ui.get(mshit.color3)}
	color_g4 = {ui.get(mshit.color4)}
	color_g5 = {ui.get(mshit.color5)}
	color_g6 = {ui.get(mshit.color6)}
	color_g7 = {ui.get(mshit.color7)}
	color_g8 = {ui.get(mshit.color8)}
	color_g9 = {ui.get(mshit.color9)}
	color_g10 = {ui.get(mshit.color10)}
	color_g11 = {ui.get(mshit.color11)}
	color_g12 = {ui.get(mshit.color12)}
	color_g13 = {ui.get(mshit.color13)}
	color_g14 = {ui.get(mshit.color14)}
	color_g15 = {ui.get(mshit.color15)}
	color_g16 = {ui.get(mshit.color16)}
	color_g17 = {ui.get(mshit.color17)}
	color_g18 = {ui.get(mshit.color18)}
	color_g19 = {ui.get(mshit.color19)}
	color_g20 = {ui.get(mshit.color20)}
	color_g21 = {ui.get(mshit.color21)}
	color_g22 = {ui.get(mshit.color22)}
	
	if ui.get(mshit.visual_arrows) then
		--renderer.text(center[1], center[2] + 43, 45, 45, 45, 75, "cb+", 0, "⮟" )
		renderer.text(center[1] - 43, center[2] - 3, 45, 45, 45, 75, "c+", 0, "⮜" )
		renderer.text(center[1] + 43, center[2] - 3, 45, 45, 45, 75, "c+", 0, "⮞" )

		--if mode == "back" then
		--renderer.text(center[1], center[2] + 43, color_g[1], color_g[2], color_g[3], color_g[4], "cb+", 0, "⮟" )
		if variables.aa_dir == -90 then
			renderer.text(center[1] - 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "c+", 0, "⮜" )
		elseif variables.aa_dir == 90 then
			renderer.text(center[1] + 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "c+", 0, "⮞" )
		end
	end

	if ui.get(mshit.visual_text) then	
		renderer.text(center[1], center[2] + 17,  color_g2[1], color_g2[2], color_g2[3], color_g2[4], "-c", 0, "SABBATH  AA" )
		
		if includes(ui.get(mshit.indicators), "aa states") then
			if variables.p_state == 2 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "-c", 0, "NORMAL" )
			elseif variables.p_state == 4 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g5[1], color_g5[2], color_g5[3], color_g5[4], "-c", 0, "LOW DELTA")
			elseif variables.p_state == 3 or variables.p_state == 8 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g4[1], color_g4[2], color_g4[3], color_g4[4], "-c", 0, "OPPOSITE" )
			elseif variables.p_state == 5 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g6[1], color_g6[2], color_g6[3], color_g6[4], "-c", 0, "JITTER" )
			elseif variables.p_state == 6 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g7[1], color_g7[2], color_g7[3], color_g7[4], "-c", 0, "LEGIT" )
			elseif variables.p_state == 7 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g15[1], color_g15[2], color_g15[3], color_g15[4], "-c", 0, "CROUCHED" )
			elseif variables.p_state == 9 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g21[1], color_g21[2], color_g21[3], color_g21[4], "-c", 0, "DORMANT" )
			elseif variables.p_state == 10 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g22[1], color_g22[2], color_g22[3], color_g22[4], "-c", 0, "FREESTANDING" )
			end
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "doubletap") and ui_get(ref.dt[1]) and ui_get(ref.dt[2]) then
			if doubletap_charged() then
				renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g10[1], color_g10[2], color_g10[3], color_g10[4], "c-", 0, "DOUBLETAP")
			else
				renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g9[1], color_g9[2], color_g9[3], color_g9[4], "c-", 0, "DOUBLETAP")
			end
			local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")
			local next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
			local jewfag = entity.get_prop(weapon, "m_flNextPrimaryAttack")
			
			if jewfag == nil then return end
			
			local next_primary_attack = jewfag + 0.5
			
			if next_primary_attack - globals.curtime() < 0 and next_attack - globals.curtime() < 0 then
				nigaro = 0
			else
				nigaro = next_primary_attack - globals.curtime()
			end
			
			local jewjewjew = math.abs((nigaro * 10/6) - 1)

			renderer.circle_outline(center[1] + 28, center[2] + 25 + (h_index * 8), 0, 0, 0, jewjewjew == 1 and 1 or color_g10[4], 3, 270, 5, 1)
			renderer.circle_outline(center[1] + 28, center[2] + 25 + (h_index * 8), color_g9[1], color_g9[2], color_g9[3], jewjewjew == 1 and 1 or 255, 3, 270, jewjewjew, 1)
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "fakeduck") and ui.get(references.fakeduck) then
			local duck_amt = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g11[1], color_g11[2], color_g11[3], color_g11[4] - duck_amt * 155, "c-", 0, "DUCK")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "safepoint") and ui.get(references.safe_point) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g12[1], color_g12[2], color_g12[3], color_g12[4], "c-", 0, "SAFE")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "hideshots") and ui.get(references.onShot[1]) and ui.get(references.onShot[2]) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g13[1], color_g13[2], color_g13[3], color_g13[4], "c-", 0, "HIDE")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "force body aim") and ui.get(references.tomi) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g14[1], color_g14[2], color_g14[3], color_g14[4], "c-", 0, "BAIM")
			h_index = h_index + 1
		end
		
		if includes(ui.get(mshit.indicators), "fakelag") then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g8[1], color_g8[2], color_g8[3], color_g8[4], "-c", 0, string.format('%i-%i-%i-%i-%i' ,toDraw4,toDraw3,toDraw2,toDraw1,toDraw0) )
			--renderer.text(center[1], center[2] + 37, color_g8[1], color_g8[2], color_g8[3], color_g8[4], "-c", 0, string.format('%i-%i-%i-%i-%i %d' ,toDraw4,toDraw3,toDraw2,toDraw1,toDraw0, toDraw5) )
			h_index = h_index + 1
		end
		
		if includes(ui.get(mshit.indicators), "desync bar") then
			fyawlimit2 = math.max(-40, math.min(40, round((entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) or 0)*120-60+0.5, 1)))
			
			if fyawlimit2 < 0 then
				renderer.text(center[1] + fyawlimit2, center[2] + 25 + (h_index * 8), color_g18[1], color_g18[2], color_g18[3], color_g18[4], "cb", 0, "|")
			else
				renderer.text(center[1] + 1 + fyawlimit2, center[2] + 25 + (h_index * 8), color_g18[1], color_g18[2], color_g18[3], color_g18[4], "cb", 0, "|")
			end
			
			if ui.get(bodyyaw2) > 0 then
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), -fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
			else
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), -fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
			end
			h_index = h_index + 1
		end
		
		-- Check if our doubletap is fully charged/ready to shoot.
		if includes(ui.get(mshit.indicators), "doubletap icons") then
			-- Return if we aren't holding our doubletap key
			if not ui_get(ref.dt[1]) or not ui_get(ref.dt[2]) then else
				-- The paint event (where we are calling this) gets triggered even while the localplayer is dead, so it's nice to have this check.
				if entity.get_local_player() == nil or not entity_is_alive(entity.get_local_player()) then return end

				-- Get our weapon index (stored in a variable for later use)
				local weapon_idx = entity_get_player_weapon(entity.get_local_player())
				-- Get our weapons item definition index.
				local weapon = entity_get_prop(weapon_idx, "m_iItemDefinitionIndex")

				-- Return if our weapon does not exist.
				if weapon == nil then return end

				-- Get our weapon name for later use relating to if we are using an auto or not. (makes the code alot more readable)
				local weapon_name = entity_get_classname(weapon_idx)
				-- Get our current weapons icon.
				local weapon_icon = images.get_weapon_icon(weapon)
				-- Get a bullet icon.
				local bullet_icon = images.get_panorama_image("icons/ui/bullet_burst.svg")
				local bullet_icon2 = images.get_panorama_image("icons/ui/bullet_burst_outline.svg")
				local bullet_icon3 = images.get_panorama_image("icons/ui/bullet.svg")

				-- Get our weapon & bullet width to dynamically make it smaller/larger without using ghetto hardcoded values when drawing.
				local weapon_w, weapon_h = weapon_icon:measure()
				local bullet_w, bullet_h = bullet_icon:measure()

				-- Flashing/pulsing alpha to indicate a recharge.
				local alpha = math.floor(math.sin(globals_realtime() * 12) * (255/2-1) + 255/2) or 255
				
				-- Get the color of our icons
				
				
				-- Check if we have a valid weapon out
				for i=1, #nonweapons_c do
					if weapon_name == nonweapons_c[i] then
						-- It's fine to return here since the last part of this function is for the bullet icons anyway.
						return
					end
				end
			
				if (ui.get(mshit.doubletap_icons) == "whack") then
					if doubletap_charged() then
						-- Display 2 bullet icons next to eachother
						bullet_icon:draw(center[1] - 25, center[2] - 0, bullet_w / 2, bullet_h / 2, color_g19[1], color_g19[2], color_g19[3], color_g19[4])
						bullet_icon:draw(center[1] + 10, center[2] - 0, bullet_w / 2, bullet_h / 2, color_g19[1], color_g19[2], color_g19[3], color_g19[4])
					else
						-- Display 2 bullet icons next to eachwither with a flashing alpha.
						bullet_icon2:draw(center[1] - 25, center[2] - 0, bullet_w / 2, bullet_h / 2, color_g19[1], color_g19[2], color_g19[3], color_g19[4] * (alpha/255))
						bullet_icon2:draw(center[1] + 10, center[2] - 0, bullet_w / 2, bullet_h / 2, color_g19[1], color_g19[2], color_g19[3], color_g19[4] * (alpha/255))
					end
				else
					if ui.get(mshit.doubletap_icons_ideal) and ui.get(quick_peek_box) and ui.get(quick_peek_key) then
						if doubletap_charged() then			
							-- Draw the localplayers current weapon icon.
							weapon_icon:draw(center[1] - weapon_w / 2.5, center[2] - 25, weapon_w / 2.5, weapon_h / 2.5, color_g20[1], color_g20[2], color_g20[3], color_g20[4])
						else
							-- Draw the localplayers current weapon icon.
							weapon_icon:draw(center[1] - weapon_w / 2.5, center[2] - 25, weapon_w / 2.5, weapon_h / 2.5, color_g20[1], color_g20[2], color_g20[3], color_g20[4] * (alpha/255))
						end
					else
						if doubletap_charged() then			
							-- Draw the localplayers current weapon icon.
							weapon_icon:draw(center[1] - weapon_w / 3, center[2] + 25 + (h_index * 8), weapon_w / 2.5, weapon_h / 2.5, color_g20[1], color_g20[2], color_g20[3], color_g20[4])
							-- Display 2 bullet icons next to eachother
							bullet_icon3:draw(center[1] + bullet_w / 3, center[2] + 25 + (h_index * 8), bullet_w / 2.5, bullet_h / 2.5, color_g19[1], color_g19[2], color_g19[3], color_g19[4])
							bullet_icon3:draw(center[1] + bullet_w / 3 + 10, center[2] + 25 + (h_index * 8), bullet_w / 2.5, bullet_h / 2.5, color_g19[1], color_g19[2], color_g19[3], color_g19[4])
						else
							-- Draw the localplayers current weapon icon.
							weapon_icon:draw(center[1] - weapon_w / 3, center[2] + 25 + (h_index * 8), weapon_w / 2.5, weapon_h / 2.5, color_g20[1], color_g20[2], color_g20[3], color_g20[4] * (alpha/255))
							-- Display 2 bullet icons next to eachother
							bullet_icon3:draw(center[1] + bullet_w / 3, center[2] + 25 + (h_index * 8), bullet_w / 2.5, bullet_h / 2.5, color_g19[1], color_g19[2], color_g19[3], color_g19[4] * (alpha/255))
							bullet_icon3:draw(center[1] + bullet_w / 3+ 10, center[2] + 25 + (h_index * 8), bullet_w / 2.5, bullet_h / 2.5, color_g19[1], color_g19[2], color_g19[3], color_g19[4] * (alpha/255))
						end
						h_index = h_index + 1
					end
				end
			end
		end
	end
	
	if ui.get(mshit.extra_indicators) then
		if ui.get(references.onShot[1]) and ui.get(references.onShot[2]) then
			cy = renderer.indicator(141, 232, 49, 255, "HS")+ui.get(mshit.y_slider)
		end
		
		if ui.get(references.tomi) then
			cy = renderer.indicator(235, 146, 52, 255, "FB")+ui.get(mshit.y_slider)
		end
		
		if ui.get(references.safe_point) then
			cy = renderer.indicator(50, 123, 168, 255, "SP")+ui.get(mshit.y_slider)
		end
	end

	if ui.get(mshit.desync) and entity.is_alive(entity.get_local_player()) then
		color = { 255-(angle*2.29824561404), angle*3.42105263158, angle*0.22807017543 }	
		--renderer.text(center[1] + 25, center[2] + 25 + (h_index * 8), 255, 255,255,255, "cb", 0, jewfaggotnigger)

		y = renderer.indicator(color[1], color[2], color[3], 255, "FAKE")+ui.get(mshit.y_slider)
		x = ui.get(mshit.x_slider)
		if ui.get(mshit.desync_where) == "at crosshair" then
			renderer.circle_outline(center[1], center[2], 0, 0, 0, 155, 10, 270, 5, 2)
			renderer.circle_outline(center[1], center[2], color[1], color[2], color[3], 255, 10, 270, angle*0.01754385964, 2)
		end
		if ui.get(mshit.desync_where) == "at indicators" then
			renderer.circle_outline(x, y, 0, 0, 0, 155, 10, 0, 1, 5)
			renderer.circle_outline(x, y, color[1], color[2], color[3], 255, 10, 0, angle*0.01754385964, 5)
		end
	end
end

local function dist_from_3dline(shooter, e)
	local x, y, z = entity_hitbox_position(shooter, 0)
	local x1, y1, z1 = client_eye_position()

	return ((e.y - y)*x1 - (e.x - x)*y1 + e.x*y - e.y*x) / math_sqrt((e.y-y)^2 + (e.x - x)^2)
end

local function on_bullet_impact(e)
	local shooter = client_userid_to_entindex(e.userid)

	if not entity_is_enemy(shooter) or not entity_is_alive(entity.get_local_player()) then
		return
	end

	local d = dist_from_3dline(shooter, e)

	if math_abs(d) < 110 then
		local dsy = variables.forward and (ui_get(ref.bodyyaw[2]) * -1) or ui_get(ref.bodyyaw[2])

		local previous_record = variables.shots[shooter][1][variables.shots[shooter][4]] == globals_curtime()
		variables.shots[shooter][4] = previous_record and variables.shots[shooter][4] or variables.shots[shooter][4] + 1

		variables.shots[shooter][1][variables.shots[shooter][4]] = globals_curtime()

		local dtc = contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "detect missed angle") or dsy == 0 or dsy == 180

		if dtc then
			variables.shots[shooter][2][variables.shots[shooter][4]] = math_abs(d) > 0.5 and (d < 0 and 90 or -90) or dsy
		else
			variables.shots[shooter][2][variables.shots[shooter][4]] = (dsy == 90 and -90 or 90)
		end
	end
end

local function on_player_hurt(e)
	local victim = client_userid_to_entindex(e.userid)
	local attacker = client_userid_to_entindex(e.attacker)

	if not entity_is_enemy(attacker) or not entity_is_alive(entity.get_local_player()) then
		return
	end

	for i=1, #variables.nonweapons do
		if e.weapon == variables.nonweapons[i] then
			return
		end
	end

	local dsy = variables.forward and (ui_get(ref.bodyyaw[2]) * -1) or ui_get(ref.bodyyaw[2])

	variables.hit[attacker][4] = variables.hit[attacker][4] + 1
	variables.hit[attacker][1][variables.hit[attacker][4]] = globals_curtime()
	variables.hit[attacker][2][variables.hit[attacker][4]] = victim ~= entity.get_local_player() and 0 or dsy
	variables.hit[attacker][3][variables.hit[attacker][4]] = e.hitgroup
end

local function reset_data(keep_hit)
	for i=1, 64 do -- 64
		variables.last_hit[i], variables.stored_misses[i], variables.stored_shots[i] = (keep_hit and variables.hit[i][2][variables.hit[i][4]] ~= 0) and variables.hit[i][2][variables.hit[i][4]] or 0, 0, 0
		for k=1, 3 do
			for j=1, 100 do --1000
				variables.miss[i][k][j], variables.hit[i][k][j], variables.shots[i][k][j] = 0, 0, 0
			end
		end
		variables.miss[i][4], variables.hit[i][4], variables.shots[i][4], variables.last_nn, variables.best_value = 0, 0, 0, 0, 180
	end
end

local function disable_aa()
	--global
	ui_set(deez_nutz[1].pitch_shit, "Off")
	ui_set(deez_nutz[1].yawbase_shit, "Local view")
	ui_set(deez_nutz[1].yaw_shit, "Off")
	ui_set(deez_nutz[1].yawadd_shit, 0)
	ui_set(deez_nutz[1].yawjitter_shit, "Off")
	ui_set(deez_nutz[1].yawjitteradd_shit, 0)
	ui_set(deez_nutz[1].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[1].bodyyaw_shit, "Off")
	ui_set(deez_nutz[1].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[1].fakeyawmode_shit, "Off")
	
	ui_set(deez_nutz[2].enable_shit, false)
	ui_set(deez_nutz[3].enable_shit, false)
	ui_set(deez_nutz[4].enable_shit, false)
	ui_set(deez_nutz[5].enable_shit, false)
	ui_set(deez_nutz[6].enable_shit, false)
	ui_set(deez_nutz[7].enable_shit, false)
	ui_set(deez_nutz[8].enable_shit, false)
	ui_set(deez_nutz[9].enable_shit, false)
	ui_set(deez_nutz[10].enable_shit, false)
	
	ui_set(references.fake_lag_type, "Dynamic")
	ui_set(references.fake_variance, 0)
	ui_set(deez_nutz[11].aa_settings, {"-"})
end

local marcel = 0

local function enable_aa()
	local p_slow = ui_get(ref.slow[1]) and ui_get(ref.slow[2])
	local p_duck = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
	local vx, vy, vz = entity_get_prop(entity.get_local_player(), "m_vecVelocity")
	local p_still2 = math_sqrt(vx ^ 2 + vy ^ 2) < 90
	local velocity_speed = math.sqrt((vx * vx) + (vy * vy))
	
	local lua_hc_score_ref = (velocity_speed / 720) * 250
	
	if lua_hc_score_ref > 60 then
		lua_hc_score_ref = 60
	end

	marcel = marcel + 1
	
	if marcel > 50 then
		marcel = 0
	end
	
	ui_set(references.fake_lag_type, marcel >= 25 and "Dynamic" or "Maximum")
	ui_set(references.fake_variance, marcel >= 25 and 14 or 0)

	--global
	ui_set(deez_nutz[1].pitch_shit, "Default")
	ui_set(deez_nutz[1].yawbase_shit, "At targets")
	ui_set(deez_nutz[1].yaw_shit, "Off")
	ui_set(deez_nutz[1].yawadd_shit, 0)
	ui_set(deez_nutz[1].yawjitter_shit, "Off")
	ui_set(deez_nutz[1].yawjitteradd_shit, 0)
	ui_set(deez_nutz[1].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[1].bodyyaw_shit, "Off")
	ui_set(deez_nutz[1].fakeyawlimit_shit, 59)
	ui_set(deez_nutz[1].fakeyawmode_shit, "Off")
	
	--standing
	ui_set(deez_nutz[2].enable_shit, true)
	ui_set(deez_nutz[2].pitch_shit, "Default")
	ui_set(deez_nutz[2].yawbase_shit, "At targets")
	ui_set(deez_nutz[2].yaw_shit, "180")
	ui_set(deez_nutz[2].yawadd_shit, 5)
	ui_set(deez_nutz[2].yawjitter_shit, "Off")
	ui_set(deez_nutz[2].yawjitteradd_shit, 0)
	ui_set(deez_nutz[2].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[2].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[2].bodyyaw_settings_shit, {"anti-resolver"})
	ui_set(deez_nutz[2].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[2].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[2].fakeyawamt_shit, 45)
	
	--[[
	--moving
	ui_set(deez_nutz[3].enable_shit, true)
	ui_set(deez_nutz[3].pitch_shit, "Default")
	ui_set(deez_nutz[3].yawbase_shit, "At targets")
	ui_set(deez_nutz[3].yaw_shit, "180")
	ui_set(deez_nutz[3].yawadd_shit, 5)
	ui_set(deez_nutz[3].yawjitter_shit, "Center")
	ui_set(deez_nutz[3].yawjitteradd_shit, -23)
	ui_set(deez_nutz[3].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[3].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Detect missed angle"})
	ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[3].fakeyawamt_shit, 0)

	--moving
	ui_set(deez_nutz[3].enable_shit, true)
	ui_set(deez_nutz[3].pitch_shit, "Default")
	ui_set(deez_nutz[3].yawbase_shit, "At targets")
	ui_set(deez_nutz[3].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[3].yawadd_shit, 12)
	else
		ui_set(deez_nutz[3].yawadd_shit, -12)
	end
	ui_set(deez_nutz[3].yawjitter_shit, "Center")
	ui_set(deez_nutz[3].yawjitteradd_shit, -23)
	ui_set(deez_nutz[3].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[3].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[3].fakeyawamt_shit, 0)
	--]]
	
	if p_still2 then
		--moving
		ui_set(deez_nutz[3].enable_shit, true)
		ui_set(deez_nutz[3].pitch_shit, "Default")
		ui_set(deez_nutz[3].yawbase_shit, "At targets")
		ui_set(deez_nutz[3].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[3].yawadd_shit, 5)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		else
			ui_set(deez_nutz[3].yawadd_shit, -5)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		end
		ui_set(deez_nutz[3].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[3].bodyyaw_shit, "freestanding")
		ui_set(deez_nutz[3].bodyyaw_settings_shit, {"anti-resolver"})
		ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[3].fakeyawamt_shit, 57)
	else
		--moving
		ui_set(deez_nutz[3].enable_shit, true)
		ui_set(deez_nutz[3].pitch_shit, "Default")
		ui_set(deez_nutz[3].yawbase_shit, "At targets")
		ui_set(deez_nutz[3].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[3].yawadd_shit, 0)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		else
			ui_set(deez_nutz[3].yawadd_shit, 0)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		end
		ui_set(deez_nutz[3].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[3].bodyyaw_shit, "reversed freestanding")
		ui_set(deez_nutz[3].bodyyaw_settings_shit, {"anti-resolver"})
		ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[3].fakeyawamt_shit, 57)
	end
	
	--[[
	--moving (scoped)
		ui_set(deez_nutz[8].enable_shit, true)
		ui_set(deez_nutz[8].pitch_shit, "Default")
		ui_set(deez_nutz[8].yawbase_shit, "At targets")
		ui_set(deez_nutz[8].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[8].yawadd_shit, 20)
			ui_set(deez_nutz[8].yawjitteradd_shit, -5)
			ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		else
			ui_set(deez_nutz[8].yawadd_shit, -7)
			ui_set(deez_nutz[8].yawjitteradd_shit, lua_hc_score_ref)
			ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		end
		ui_set(deez_nutz[8].yawjitter_shit, "Center")
		ui_set(deez_nutz[8].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[8].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[8].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[8].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[8].fakeyawamt_shit, 35)
	--]]
	
	if p_still2 then
		--moving (scoped)
		ui_set(deez_nutz[8].enable_shit, true)
		ui_set(deez_nutz[8].pitch_shit, "Default")
		ui_set(deez_nutz[8].yawbase_shit, "At targets")
		ui_set(deez_nutz[8].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[8].yawadd_shit, 20)
			ui_set(deez_nutz[8].yawjitteradd_shit, -5)
		else
			ui_set(deez_nutz[8].yawadd_shit, -5)
			ui_set(deez_nutz[8].yawjitteradd_shit, 5)	
		end
		ui_set(deez_nutz[8].yawjitter_shit, "Center")
		ui_set(deez_nutz[8].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[8].bodyyaw_shit, "freestanding")
		ui_set(deez_nutz[8].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[8].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[8].fakeyawamt_shit, 35)
	else
		--moving
		ui_set(deez_nutz[8].enable_shit, true)
		ui_set(deez_nutz[8].pitch_shit, "Default")
		ui_set(deez_nutz[8].yawbase_shit, "At targets")
		ui_set(deez_nutz[8].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[8].yawadd_shit, 0)
			ui_set(deez_nutz[8].yawjitteradd_shit, 0)
			ui_set(deez_nutz[8].yawjitter_shit, "Off")
		else
			ui_set(deez_nutz[8].yawadd_shit, 0)
			ui_set(deez_nutz[8].yawjitteradd_shit, 0)
			ui_set(deez_nutz[8].yawjitter_shit, "Off")
		end
		ui_set(deez_nutz[8].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[8].bodyyaw_shit, "reversed freestanding")
		ui_set(deez_nutz[8].bodyyaw_settings_shit, {"anti-resolver"})
		ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[8].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[8].fakeyawamt_shit, 57)
	end
	
	--[[
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -5)
		ui_set(deez_nutz[4].yawjitteradd_shit, 7)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 60)
	else
		ui_set(deez_nutz[4].yawadd_shit, 5)
		ui_set(deez_nutz[4].yawjitteradd_shit, 7)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 60)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Center")
	ui_set(deez_nutz[4].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[4].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawamt_shit, 45)
	ui_set(deez_nutz[4].fakeyawmode_shit, "Random")
	
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -10)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 45)
	else
		ui_set(deez_nutz[4].yawadd_shit, 10)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 45)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Center")
	ui_set(deez_nutz[4].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[4].bodyyaw_shit, "Reversed Freestanding")
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawamt_shit, 30)
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	
	
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -11)
		ui_set(deez_nutz[4].yawjitteradd_shit, 3)
	else
		ui_set(deez_nutz[4].yawadd_shit, 11)
		ui_set(deez_nutz[4].yawjitteradd_shit, 3)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Off")
	ui_set(deez_nutz[4].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[4].bodyyaw_shit, "Freestanding") --Freestanding
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	
	
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -20)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 15)
	else
		ui_set(deez_nutz[4].yawadd_shit, 9)
		ui_set(deez_nutz[4].yawjitteradd_shit, 0)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 35)	
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Offset")
	ui_set(deez_nutz[4].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[4].bodyyaw_shit, "Freestanding") --Freestanding
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	
	
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, 0)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 42)
	else
		ui_set(deez_nutz[4].yawadd_shit, 7)
		ui_set(deez_nutz[4].yawjitteradd_shit, -5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 42)	
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Random")
	ui_set(deez_nutz[4].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[4].bodyyaw_shit, "Ideal")
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	--]]
	
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -20)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 15)
	else
		ui_set(deez_nutz[4].yawadd_shit, 14)
		ui_set(deez_nutz[4].yawjitteradd_shit, -5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 42)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Offset")
	ui_set(deez_nutz[4].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[4].bodyyaw_shit, "reversed freestanding") --Freestanding
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"anti-resolver"})
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
		
	--air
	ui_set(deez_nutz[5].enable_shit, true)
	ui_set(deez_nutz[5].pitch_shit, "Default")
	ui_set(deez_nutz[5].yawbase_shit, "At targets")
	ui_set(deez_nutz[5].yaw_shit, "180")
	if variables.best_value <= -90 then
		ui_set(deez_nutz[5].yawadd_shit, -8)
		ui_set(deez_nutz[5].yawjitteradd_shit, 0) --30
		ui_set(deez_nutz[5].fakeyawlimit_shit, 58)
	else
		ui_set(deez_nutz[5].yawadd_shit, 8)
		ui_set(deez_nutz[5].yawjitteradd_shit, 0) --30
		ui_set(deez_nutz[5].fakeyawlimit_shit, 58)
	end
	ui_set(deez_nutz[5].yawjitter_shit, "Off")
	ui_set(deez_nutz[5].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[5].bodyyaw_shit, "jitter")
	ui_set(deez_nutz[5].bodyyaw_settings_shit, {"anti-resolver", "detect missed angle"})
	ui_set(deez_nutz[5].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[5].fakeyawamt_shit, 25)
	
	--[[
	--on-key
	ui_set(deez_nutz[6].enable_shit, true)
	ui_set(deez_nutz[6].pitch_shit, "Off")
	ui_set(deez_nutz[6].yawbase_shit, "At targets")
	ui_set(deez_nutz[6].yaw_shit, "180")
	ui_set(deez_nutz[6].yawadd_shit, 180)
	ui_set(deez_nutz[6].yawjitter_shit, "Off")
	ui_set(deez_nutz[6].yawjitteradd_shit, 0)
	ui_set(deez_nutz[6].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[6].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[6].bodyyaw_settings_shit, {"Detect missed angle"})
	ui_set(deez_nutz[6].fakeyawlimit_shit, 59)
	ui_set(deez_nutz[6].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[6].fakeyawamt_shit, 0)
	--]]
	
	
	--on-key
	ui_set(deez_nutz[6].enable_shit, true)
	ui_set(deez_nutz[6].pitch_shit, "Off")
	ui_set(deez_nutz[6].yawbase_shit, "At targets")
	ui_set(deez_nutz[6].yaw_shit, "180")
	ui_set(deez_nutz[6].yawadd_shit, 180)
	ui_set(deez_nutz[6].yawjitter_shit, "Off")
	ui_set(deez_nutz[6].yawjitteradd_shit, 0)
	ui_set(deez_nutz[6].aa_mode_shit, "sabbath")
	--if p_slow or p_duck >= 0.7 or p_still2 then
	ui_set(deez_nutz[6].bodyyaw_shit, "freestanding")
	--else
		--ui_set(deez_nutz[6].bodyyaw_shit, "Max Jitter")
	--end
	ui_set(deez_nutz[6].bodyyaw_settings_shit, {"Detect missed angle", "Jitter when vulnerable"})
	ui_set(deez_nutz[6].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[6].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[6].fakeyawamt_shit, 0)
	
	if entity.get_prop(entity.get_local_player(), 'm_iTeamNum') == 2 then 
		--- T SIDE
		--crouched
		--[[
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 0)
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "sabbath")
		if p_still2 then
			ui_set(deez_nutz[7].bodyyaw_shit, "Reversed Freestanding")
		else
			ui_set(deez_nutz[7].bodyyaw_shit, "Jitter")
		end
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 5)
		--]]
		
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 5)
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[7].bodyyaw_shit, "reversed freestanding")
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"anti-resolver", "jitter when vulnerable"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 5)
	else 
		--CT SIDE
		--crouched
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 0)
		ui_set(deez_nutz[7].yawjitter_shit, "Center")
		ui_set(deez_nutz[7].yawjitteradd_shit, math.random(-3, 19))
		ui_set(deez_nutz[7].aa_mode_shit, "gamesense")
		ui_set(deez_nutz[7].gs_bodyyaw_shit, "jitter")
		ui_set(deez_nutz[7].gs_bodyyawadd_shit, math.random(-7, 13))
		ui_set(deez_nutz[7].fakeyawlimit_shit, math.random(38, 55))
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 5)
		
		--[[
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		if variables.best_value <= -90 then
			ui_set(deez_nutz[7].yawadd_shit, -5)
		else
			ui_set(deez_nutz[7].yawadd_shit, 10) --10
		end
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[7].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 25)
		--]]
		--[[
		--CT SIDE
		--crouched
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 5)
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[7].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 25)
		--]]
	end
	
	--[[--dormant
	ui_set(deez_nutz[9].enable_shit, true)
	ui_set(deez_nutz[9].pitch_shit, "Default")
	ui_set(deez_nutz[9].yawbase_shit, "At targets")
	ui_set(deez_nutz[9].yaw_shit, "180")
	if variables.best_value <= -90 then
		ui_set(deez_nutz[9].yawadd_shit, 75)
	else
		ui_set(deez_nutz[9].yawadd_shit, -75)
	end
	ui_set(deez_nutz[9].yawjitter_shit, "Center")
	ui_set(deez_nutz[9].yawjitteradd_shit, 180)
	ui_set(deez_nutz[9].aa_mode_shit, "sabbath")
	if jafeth == true then
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter")
	else
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter Freestand")
	end
	ui_set(deez_nutz[9].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[9].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[9].fakeyawamt_shit, 25)
	
	--dormant
	ui_set(deez_nutz[9].enable_shit, true)
	ui_set(deez_nutz[9].pitch_shit, "Default")
	ui_set(deez_nutz[9].yawbase_shit, "At targets")
	ui_set(deez_nutz[9].yaw_shit, "180")
	if variables.best_value <= -90 then
		ui_set(deez_nutz[9].yawadd_shit, 12)
	else
		ui_set(deez_nutz[9].yawadd_shit, -12)
	end
	ui_set(deez_nutz[9].yawjitter_shit, "Off")
	ui_set(deez_nutz[9].yawjitteradd_shit, 0)
	ui_set(deez_nutz[9].aa_mode_shit, "sabbath")
	if jafeth == true then
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter")
	else
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter Freestand")
	end
	ui_set(deez_nutz[9].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[9].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[9].fakeyawamt_shit, 25)
	
	--dormant
	ui_set(deez_nutz[9].enable_shit, true)
	ui_set(deez_nutz[9].pitch_shit, "Default")
	ui_set(deez_nutz[9].yawbase_shit, "At targets")
	ui_set(deez_nutz[9].yaw_shit, "180")
	if variables.best_value <= -90 then
		ui_set(deez_nutz[9].yawadd_shit, 0)
	else
		ui_set(deez_nutz[9].yawadd_shit, 0)
	end
	ui_set(deez_nutz[9].yawjitter_shit, "Off")
	ui_set(deez_nutz[9].yawjitteradd_shit, 0)
	ui_set(deez_nutz[9].aa_mode_shit, "sabbath")
	if jafeth == true then
		ui_set(deez_nutz[9].bodyyaw_shit, "Reversed Freestanding")
	else
		ui_set(deez_nutz[9].bodyyaw_shit, "Freestanding")
	end
	ui_set(deez_nutz[9].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[9].fakeyawmode_shit, "Jitter")
	ui_set(deez_nutz[9].fakeyawamt_shit, 40)
	
	--]]
	if shooting then
		if jafeth == false then
			ui_set(deez_nutz[9].gs_bodyyaw_shit, "Static")
			ui_set(deez_nutz[9].gs_bodyyawadd_shit, 90)
			client.delay_call(0.01, delaytimer)
		else
			ui_set(deez_nutz[9].gs_bodyyaw_shit, "Static")
			ui_set(deez_nutz[9].gs_bodyyawadd_shit, -60)
			jafeth = false
		end
	end
	
	if shooting then
		--onshot aa
		ui_set(deez_nutz[9].enable_shit, true)
		ui_set(deez_nutz[9].pitch_shit, "Default")
		ui_set(deez_nutz[9].yawbase_shit, "At targets")
		ui_set(deez_nutz[9].yaw_shit, "180")
		if variables.best_value <= -90 then
			ui_set(deez_nutz[9].yawadd_shit, 12)
		else
			ui_set(deez_nutz[9].yawadd_shit, 0)
		end
		ui_set(deez_nutz[9].yawjitter_shit, "Off")
		ui_set(deez_nutz[9].yawjitteradd_shit, 0)
		ui_set(deez_nutz[9].aa_mode_shit, "gamesense")
		--ui_set(deez_nutz[9].bodyyaw_settings_shit, {"-"})
		ui_set(deez_nutz[9].fakeyawlimit_shit, 35)
		ui_set(deez_nutz[9].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[9].fakeyawamt_shit, 40)
	else
		--dormant and weapon swap
		ui_set(deez_nutz[9].enable_shit, true)
		ui_set(deez_nutz[9].pitch_shit, "Default")
		ui_set(deez_nutz[9].yawbase_shit, "At targets")
		ui_set(deez_nutz[9].yaw_shit, "180")
		if variables.best_value <= -90 then
			ui_set(deez_nutz[9].yawadd_shit, 0)
		else
			ui_set(deez_nutz[9].yawadd_shit, 0)
		end
		ui_set(deez_nutz[9].yawjitter_shit, "Off")
		ui_set(deez_nutz[9].yawjitteradd_shit, 0)
		ui_set(deez_nutz[9].aa_mode_shit, "sabbath")
		ui_set(deez_nutz[9].bodyyaw_shit, "reversed freestanding")
		ui_set(deez_nutz[9].bodyyaw_settings_shit, {"jitter when vulnerable"})
		ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[9].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[9].fakeyawamt_shit, 25)
	end
	
	--freestanding
	ui_set(deez_nutz[10].enable_shit, true)
	ui_set(deez_nutz[10].pitch_shit, marcel == 1 and "Default" or "Minimal")
	ui_set(deez_nutz[10].yawbase_shit, "At targets")
	ui_set(deez_nutz[10].yaw_shit, "180")
	ui_set(deez_nutz[10].yawadd_shit, 0)
	ui_set(deez_nutz[10].yawjitter_shit, "Off")
	ui_set(deez_nutz[10].yawjitteradd_shit, 5)
	ui_set(deez_nutz[10].aa_mode_shit, "sabbath")
	ui_set(deez_nutz[10].bodyyaw_shit, "jitter")
	ui_set(deez_nutz[10].bodyyaw_settings_shit, {"anti-resolver"})
	ui_set(deez_nutz[10].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[10].fakeyawmode_shit, "jitter")
	ui_set(deez_nutz[10].fakeyawamt_shit, 20)

	ui_set(deez_nutz[11].aa_settings, {"anti-aim on use", "disable use to plant"})
end

local function paint_ui()
	if ui.get(mshit.faster_dt) then
		if ui.is_menu_open() or ui.get(references.fakeduck) or not entity.is_alive(entity.get_local_player()) or not (ui_get(ref.dt[1]) and ui_get(ref.dt[2])) then
			ui.set(references.tickstoprocess, 16)
			cvar.cl_clock_correction:set_int(1)
		end
	end
	
	penis = ui.get(mshit.autobuy)
	ui.set_visible(mshit.autobuy_options, penis)
	ui.set_visible(mshit.autobuy_slider, penis)

	if ui.get(mshit.enabled) then
		ui.set_visible(mshit.legit_aa_key, true)
		ui.set_visible(mshit.manual_back, true)
		ui.set_visible(mshit.manual_forward, true)
		ui.set_visible(mshit.manual_left, true)
		ui.set_visible(mshit.manual_right, true)
		ui.set_visible(mshit.freestand[1], true)
		ui.set_visible(mshit.freestand[2], true)
		ui.set_visible(mshit.edge[1], true)
		ui.set_visible(mshit.edge[2], true)
		ui.set_visible(mshit.indicator_enable, true)
	else
		ui.set_visible(mshit.legit_aa_key, false)
		ui.set_visible(mshit.manual_back, false)
		ui.set_visible(mshit.manual_forward, false)
		ui.set_visible(mshit.manual_left, false)
		ui.set_visible(mshit.manual_right, false)
		ui.set_visible(mshit.freestand[1], false)
		ui.set_visible(mshit.freestand[2], false)
		ui.set_visible(mshit.edge[1], false)
		ui.set_visible(mshit.edge[2], false)
		ui.set_visible(mshit.indicator_enable, false)
		ui.set(mshit.indicator_enable, "off")
	end

	ui.set_visible(references.tickstoprocess, false)
	
	nigga = ui.get(mshit.faster_dt)
	ui.set_visible(mshit.adaptive_dt, nigga)
	
	turnedon = ui.get(mshit.desync)
	ui.set_visible(mshit.desync_where, turnedon)
	ui.set_visible(mshit.x_slider, turnedon)
	ui.set_visible(mshit.y_slider, turnedon)
	
	if ui.get(mshit.indicator_enable) == "on" then
		ui.set_visible(mshit.extra_indicators, true)
		ui.set_visible(mshit.visual_arrows, true)
		ui.set_visible(mshit.visual_text, true)
		ui.set_visible(mshit.desync, true)
	else
		ui.set_visible(mshit.extra_indicators, false)
		ui.set_visible(mshit.visual_arrows, false)
		ui.set_visible(mshit.visual_text, false)
		ui.set_visible(mshit.desync, false)
		ui.set_visible(mshit.desync_where, false)
		ui.set_visible(mshit.x_slider, false)
		ui.set_visible(mshit.y_slider, false)
	end
	
	if ui.get(mshit.indicator_enable) == "on" and ui.get(mshit.visual_arrows) then
		ui.set_visible(mshit.color, true)
		ui.set_visible(mshit.label, true)
	else
		ui.set_visible(mshit.color, false)
		ui.set_visible(mshit.label, false)
	end
	
	if ui.get(mshit.doubletap_icons) == "whack" and includes(ui.get(mshit.indicators), "doubletap icons") then
		ui.set_visible(mshit.doubletap_icons_ideal, false)
		ui.set_visible(mshit.label19, true)
		ui.set_visible(mshit.color19, true)
		ui.set_visible(mshit.label20, false)
		ui.set_visible(mshit.color20, false)
	elseif ui.get(mshit.doubletap_icons) == "classic" and includes(ui.get(mshit.indicators), "doubletap icons") then
		ui.set_visible(mshit.doubletap_icons_ideal, true)
		ui.set_visible(mshit.label19, true)
		ui.set_visible(mshit.color19, true)
		ui.set_visible(mshit.label20, true)
		ui.set_visible(mshit.color20, true)
	else
		ui.set_visible(mshit.doubletap_icons_ideal, false)
		ui.set_visible(mshit.label19, false)
		ui.set_visible(mshit.color19, false)
		ui.set_visible(mshit.label20, false)
		ui.set_visible(mshit.color20, false)
	end
	
	ui.set_visible(mshit.leg_breaker, true)
end

local function handleGUI2()
	if ui.get(mshit.indicator_enable) == "on" and ui.get(mshit.visual_text) then
		ui.set_visible(mshit.indicators, true)
		ui.set_visible(mshit.color2, true)
		ui.set_visible(mshit.label2, true)
		if includes(ui.get(mshit.indicators), "aa states") then
			ui.set_visible(mshit.color3, true)
			ui.set_visible(mshit.label3, true)
			ui.set_visible(mshit.color4, true)
			ui.set_visible(mshit.label4, true)
			ui.set_visible(mshit.color5, true)
			ui.set_visible(mshit.label5, true)
			ui.set_visible(mshit.color6, true)
			ui.set_visible(mshit.label6, true)
			ui.set_visible(mshit.color7, true)
			ui.set_visible(mshit.label7, true)
			ui.set_visible(mshit.color15, true)
			ui.set_visible(mshit.label15, true)
			ui.set_visible(mshit.color21, true)
			ui.set_visible(mshit.label21, true)
			ui.set_visible(mshit.color22, true)
			ui.set_visible(mshit.label22, true)
		else
			ui.set_visible(mshit.color3, false)
			ui.set_visible(mshit.label3, false)
			ui.set_visible(mshit.color4, false)
			ui.set_visible(mshit.label4, false)
			ui.set_visible(mshit.color5, false)
			ui.set_visible(mshit.label5, false)
			ui.set_visible(mshit.color6, false)
			ui.set_visible(mshit.label6, false)
			ui.set_visible(mshit.color7, false)
			ui.set_visible(mshit.label7, false)
			ui.set_visible(mshit.color15, false)
			ui.set_visible(mshit.label15, false)
			ui.set_visible(mshit.color21, false)
			ui.set_visible(mshit.label21, false)
			ui.set_visible(mshit.color22, false)
			ui.set_visible(mshit.label22, false)
		end
		if includes(ui.get(mshit.indicators), "desync bar") then
			ui.set_visible(mshit.label16, true)
			ui.set_visible(mshit.color16, true)
			ui.set_visible(mshit.label17, true)
			ui.set_visible(mshit.color17, true)
			ui.set_visible(mshit.label18, true)
			ui.set_visible(mshit.color18, true)			
		else
			ui.set_visible(mshit.label16, false)
			ui.set_visible(mshit.color16, false)
			ui.set_visible(mshit.label17, false)
			ui.set_visible(mshit.color17, false)
			ui.set_visible(mshit.label18, false)
			ui.set_visible(mshit.color18, false)			
		end
		if includes(ui.get(mshit.indicators), "doubletap") then
			ui.set_visible(mshit.color9, true)
			ui.set_visible(mshit.label9, true)
			ui.set_visible(mshit.color10, true)
			ui.set_visible(mshit.label10, true)
		else
			ui.set_visible(mshit.color9, false)
			ui.set_visible(mshit.label9, false)
			ui.set_visible(mshit.color10, false)
			ui.set_visible(mshit.label10, false)
		end
		if includes(ui.get(mshit.indicators), "fakeduck") then
			ui.set_visible(mshit.color11, true)
			ui.set_visible(mshit.label11, true)
		else
			ui.set_visible(mshit.color11, false)
			ui.set_visible(mshit.label11, false)
		end
		if includes(ui.get(mshit.indicators), "safepoint") then
			ui.set_visible(mshit.color12, true)
			ui.set_visible(mshit.label12, true)
		else
			ui.set_visible(mshit.color12, false)
			ui.set_visible(mshit.label12, false)
		end
		if includes(ui.get(mshit.indicators), "hideshots") then
			ui.set_visible(mshit.color13, true)
			ui.set_visible(mshit.label13, true)
		else
			ui.set_visible(mshit.color13, false)
			ui.set_visible(mshit.label13, false)
		end
		if includes(ui.get(mshit.indicators), "force body aim") then
			ui.set_visible(mshit.color14, true)
			ui.set_visible(mshit.label14, true)
		else
			ui.set_visible(mshit.color14, false)
			ui.set_visible(mshit.label14, false)
		end
		if includes(ui.get(mshit.indicators), "fakelag") then
			ui.set_visible(mshit.color8, true)
			ui.set_visible(mshit.label8, true)
		else
			ui.set_visible(mshit.color8, false)
			ui.set_visible(mshit.label8, false)
		end
		if includes(ui.get(mshit.indicators), "doubletap icons") then
			ui.set_visible(mshit.doubletap_icons, true)
		else
			ui.set_visible(mshit.doubletap_icons, false)
		end
	else
		ui.set_visible(mshit.indicators, false)
		ui.set_visible(mshit.doubletap_icons, false)
		ui.set_visible(mshit.doubletap_icons_ideal, false)
		ui.set_visible(mshit.color2, false)
		ui.set_visible(mshit.label2, false)
		ui.set_visible(mshit.color3, false)
		ui.set_visible(mshit.label3, false)
		ui.set_visible(mshit.color4, false)
		ui.set_visible(mshit.label4, false)
		ui.set_visible(mshit.color5, false)
		ui.set_visible(mshit.label5, false)
		ui.set_visible(mshit.color6, false)
		ui.set_visible(mshit.label6, false)
		ui.set_visible(mshit.color7, false)
		ui.set_visible(mshit.label7, false)
		ui.set_visible(mshit.color8, false)
		ui.set_visible(mshit.label8, false)
		ui.set_visible(mshit.color9, false)
		ui.set_visible(mshit.label9, false)
		ui.set_visible(mshit.color10, false)
		ui.set_visible(mshit.label10, false)
		ui.set_visible(mshit.color11, false)
		ui.set_visible(mshit.label11, false)
		ui.set_visible(mshit.color12, false)
		ui.set_visible(mshit.label12, false)
		ui.set_visible(mshit.color13, false)
		ui.set_visible(mshit.label13, false)
		ui.set_visible(mshit.color14, false)
		ui.set_visible(mshit.label14, false)
		ui.set_visible(mshit.color15, false)
		ui.set_visible(mshit.label15, false)
		ui.set_visible(mshit.color16, false)
		ui.set_visible(mshit.label16, false)
		ui.set_visible(mshit.color17, false)
		ui.set_visible(mshit.label17, false)
		ui.set_visible(mshit.color18, false)
		ui.set_visible(mshit.label18, false)
		ui.set_visible(mshit.label19, false)
		ui.set_visible(mshit.color19, false)
		ui.set_visible(mshit.label20, false)
		ui.set_visible(mshit.color20, false)
		ui.set_visible(mshit.label21, false)
		ui.set_visible(mshit.color21, false)
		ui.set_visible(mshit.label22, false)
		ui.set_visible(mshit.color22, false)
	end
	
	if ui.get(mshit.enabled) then
		ui.set_visible(mshit.indicator_enable, true)
	else
		ui.set_visible(mshit.indicator_enable, false)
		ui.set_visible(mshit.doubletap_icons, false)
		ui.set_visible(mshit.doubletap_icons_ideal, false)
		ui.set_visible(mshit.color, false)
		ui.set_visible(mshit.label, false)
		ui.set_visible(mshit.color2, false)
		ui.set_visible(mshit.label2, false)
		ui.set_visible(mshit.color3, false)
		ui.set_visible(mshit.label3, false)
		ui.set_visible(mshit.color4, false)
		ui.set_visible(mshit.label4, false)
		ui.set_visible(mshit.color5, false)
		ui.set_visible(mshit.label5, false)
		ui.set_visible(mshit.color6, false)
		ui.set_visible(mshit.label6, false)
		ui.set_visible(mshit.color7, false)
		ui.set_visible(mshit.label7, false)
		ui.set_visible(mshit.color8, false)
		ui.set_visible(mshit.label8, false)
		ui.set_visible(mshit.color9, false)
		ui.set_visible(mshit.label9, false)
		ui.set_visible(mshit.color10, false)
		ui.set_visible(mshit.label10, false)
		ui.set_visible(mshit.color11, false)
		ui.set_visible(mshit.label11, false)
		ui.set_visible(mshit.color12, false)
		ui.set_visible(mshit.label12, false)
		ui.set_visible(mshit.color13, false)
		ui.set_visible(mshit.label13, false)
		ui.set_visible(mshit.color14, false)
		ui.set_visible(mshit.label14, false)
		ui.set_visible(mshit.color15, false)
		ui.set_visible(mshit.label15, false)
		ui.set_visible(mshit.color16, false)
		ui.set_visible(mshit.label16, false)
		ui.set_visible(mshit.color17, false)
		ui.set_visible(mshit.label17, false)
		ui.set_visible(mshit.color18, false)
		ui.set_visible(mshit.label18, false)
		ui.set_visible(mshit.label19, false)
		ui.set_visible(mshit.color19, false)
		ui.set_visible(mshit.label20, false)
		ui.set_visible(mshit.color20, false)
		ui.set_visible(mshit.label21, false)
		ui.set_visible(mshit.color21, false)
		ui.set_visible(mshit.label22, false)
		ui.set_visible(mshit.color22, false)
	end
end

local function paint_all()
	autobuy_paint()
	get_twint()
	on_paint()
end

local function paintui_all()
	paint_handler()
	menu_elements()
	paint_ui()
	handleGUI2()
end

local function turnshiton()
	if ui.get(mshit.enabled) then
		enable_aa()
	else
		disable_aa()
	end
end

local function shutdown()
	if ui.get(mshit.TwinTower_enabled) then
		client.set_clan_tag("")
	end
	
	ui.set(ref.pitch, "Default")
	ui.set(yaw2, "180")
	ui.set(yaw, 0)
	ui.set(jyaw, "Random")
	ui.set(jyawslide, 0)
    ui.set(bodyyaw, "Static")
	ui.set(bodyyaw2, 0)
	ui.set(references.freestanding_byaw, false)
	ui.set(references.fyawlimit, 0)
	
	ui.set_visible(references.aa_enable, true)
	set_og_menu(true)
	
	ui.set(references.tickstoprocess, 16)
	cvar.r_3dsky:set_int(1)
	cvar.r_3dskyinreflection:set_int(1)
end

create_callback("bullet_impact", on_bullet_impact)
create_callback("player_hurt", on_player_hurt)
create_callback("paint_ui", paintui_all)
create_callback("setup_command", on_setup_command)
create_callback("setup_command", turnshiton)
create_callback("paint", paint_all)
create_callback("shutdown", shutdown)

create_callback("player_death", function(e)
	if client_userid_to_entindex(e.userid) == entity.get_local_player() then
		reset_data(true)
	end
end)

create_callback("round_start", function()
	reset_data(true)
	dt_latency = client.latency() * 1000
end)

create_callback("client_disconnect", function()
	reset_data(false)
end)

create_callback("game_newmap", function()
	reset_data(false)
end)

create_callback("cs_game_disconnected", function()
	reset_data(false)
end)

local function handle_callbacks()
    ui_set_callback(deez_nutz[11].aa_settings, menu_elements)
	ui_set_callback(deez_nutz[0].player_state, menu_elements)
	ui_set_callback(mshit.edge[1], menu_elements)
	ui_set_callback(mshit.freestand[1], menu_elements)

	for i=1, 10 do
		ui_set_callback(deez_nutz[i].aa_mode_shit, menu_elements)
		ui_set_callback(deez_nutz[i].yaw_shit, menu_elements)
		ui_set_callback(deez_nutz[i].yawadd_shit, menu_elements)
		ui_set_callback(deez_nutz[i].bodyyaw_shit, menu_elements)
        ui_set_callback(deez_nutz[i].yawjitter_shit, menu_elements)
        ui_set_callback(deez_nutz[i].fakeyawmode_shit, menu_elements)
	end
	
	-- Optimize Shit --
	cvar.r_3dsky:set_int(0)
	cvar.r_3dskyinreflection:set_int(0)
end
handle_callbacks()