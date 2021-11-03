--[[
	id: EiQmlQxxgJgr_NIaNjYf4
	name: 404 desync
	description: 123
	time1: 2021-05-10 07:41:36.370991+00
	time2: 2021-05-10 07:41:36.370992+00
	uploader: 4539
	uploadersession: Lrnvh5BkzLajMPyH6uMYJFFiiKHob-
	flag: f
--]]

--[此lua最终解释权归skyness#1106所有]--
--local variables for API functions. Generated using https://github.com/sapphyrus/gamesense-lua/blob/master/generate_api.lua
local notify = {} notify.__index = notify notify.invoke_callback = function(timeout) return setmetatable({ active = false, delay = 0, laycoffset = -11, layboffset = -11 }, notify) end notify.setup_color = function(color, sec_color) if type(color) ~= 'table' then notify:setup() return end if notify.color == nil then notify:setup() end if color ~= nil then notify.color[1] = color end if sec_color ~= nil then notify.color[2] = sec_color end end notify.add = function(time, is_right, ...) if notify.color == nil then notify:setup() end table.insert(notify.__list, { ["tick"] = globals.tickcount(), ["invoke"] = notify.invoke_callback(), ["text"] = { ... }, ["time"] = time, ["color"] = notify.color, ["right"] = is_right, ["first"] = false }) end function notify:setup() notify.color = { { 0, 150, 255 }, { 0, 0, 0 } } if notify.__list == nil then notify.__list = {} client.delay_call(0.05, function() end) end end function notify:listener() local count_left = 0 local count_right = 0 local old_tick = 0 if notify.__list == nil then notify:setup() end for i=1, #notify.__list do local layer = notify.__list[i] if layer.tick ~= old_tick then notify:setup() end if layer.right == true then layer.invoke:show_right(count_right, layer.color, layer.text) if layer.invoke.active then count_right = count_right + 1 end else layer.invoke:show(count_left, layer.color, layer.text) if layer.invoke.active then count_left = count_left + 1 end end if layer.first == false then layer.invoke:start(layer.time) notify.__list[i]["first"] = true end old_tick = layer.tick end end function notify:start(timeout) self.active = true self.delay = globals.realtime() + timeout end function notify:get_text_size(lines_combo) local x_offset_text = 0 for i=1, #lines_combo do local r, g, b, message = unpack(lines_combo[i]) local width, height = renderer.measure_text("", message) x_offset_text = x_offset_text + width end return x_offset_text end function notify:string_ends_with(str, ending) return ending == "" or str:sub(-#ending) == ending end function notify:multicolor_text(x, y, flags, lines_combo) local line_height_temp = 0 local x_offset_text = 0 local y_offset = 0 for i=1, #lines_combo do local r, g, b, message = unpack(lines_combo[i]) message = message .. "\0" renderer.text(x + x_offset_text, y + y_offset, r, g, b, 255, flags, 0, message) if self:string_ends_with(message, "\0") then local width, height = renderer.measure_text(flags, message) x_offset_text = x_offset_text + width else x_offset_text = 0 y_offset = y_offset + line_height_temp end end end function notify:show(count, color, text) if self.active ~= true then return end local x, y = client.screen_size() local y = 5 + (27 * count) local text_w, text_h = self:get_text_size(text) local max_width = text_w local max_width = max_width < 150 and 150 or max_width if color == nil then color = self.color end local factor = 255 / 25 * globals.frametime() if globals.realtime() < self.delay then if self.laycoffset < max_width then self.laycoffset = self.laycoffset + (max_width - self.laycoffset) * factor end if self.laycoffset > max_width then self.laycoffset = max_width end if self.laycoffset > max_width / 1.09 then if self.layboffset < max_width - 6 then self.layboffset = self.layboffset + ((max_width - 6) - self.layboffset) * factor end end if self.layboffset > max_width - 6 then self.layboffset = max_width - 6 end else if self.layboffset > -11 then self.layboffset = self.layboffset - (((max_width-5)-self.layboffset) * factor) + 0.01 end if self.layboffset < (max_width - 11) and self.laycoffset >= 0 then self.laycoffset = self.laycoffset - (((max_width + 1) - self.laycoffset) * factor) + 0.01 end if self.laycoffset < 0 then self.active = false end end renderer.rectangle(self.laycoffset - self.laycoffset, y, self.laycoffset + 16, 25, color[1][1], color[1][2], color[1][3], 255) renderer.rectangle(self.layboffset - self.laycoffset, y, self.layboffset + 22, 25, color[2][1], color[2][2], color[2][3], 255) self:multicolor_text(self.layboffset - max_width + 11, y + 6, "", text) end function notify:show_right(count, color, text) if self.active ~= true then return end local x, y = client.screen_size() local y = 1 + (26 * count) local text_w, text_h = self:get_text_size(text) local max_width = text_w + 22 local max_width = max_width < 150 and 150 or max_width if color == nil then color = self.color end local factor = 255 / 25 * globals.frametime() if globals.realtime() < self.delay then if self.laycoffset < max_width then self.laycoffset = self.laycoffset + (max_width - self.laycoffset) * factor end if self.laycoffset > max_width then self.laycoffset = max_width end if self.laycoffset > max_width / 1.09 then if self.layboffset < max_width - 6 then self.layboffset = self.layboffset + ((max_width - 6) - self.layboffset) * factor end end if self.layboffset > max_width - 6 then self.layboffset = max_width - 6 end else if self.layboffset > 0 then self.layboffset = self.layboffset - (((max_width-5)-self.layboffset) * factor) + 0.01 end if self.layboffset < (max_width - 11) and self.laycoffset >= 0 then self.laycoffset = self.laycoffset - (((max_width + 1) - self.laycoffset) * factor) + 0.01 end if self.laycoffset < 0 then self.active = false end end renderer.gradient(x - self.laycoffset + 3, y, self.laycoffset + 3 + self.laycoffset, 25, 0, 120, 255, 255, 255, 0, 255, 255, true) self:multicolor_text(x - self.layboffset + 10, y + 6, "", text) end
local client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_reload_active_scripts, client_scale_damage, client_get_cvar, client_camera_position, client_create_interface, client_random_int, client_latency, client_set_clan_tag, client_find_signature, client_log, client_timestamp, client_delay_call, client_trace_line, client_register_esp_flag, client_get_model_name, client_system_time, client_visible, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float = client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.reload_active_scripts, client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int, client.latency, client.set_clan_tag, client.find_signature, client.log, client.timestamp, client.delay_call, client.trace_line, client.register_esp_flag, client.get_model_name, client.system_time, client.visible, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float
local entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
local globals_realtime, globals_absoluteframetime, globals_chokedcommands, globals_oldcommandack, globals_tickcount, globals_commandack, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.chokedcommands, globals.oldcommandack, globals.tickcount, globals.commandack, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect, ui_is_menu_open, ui_new_hotkey, ui_set, ui_update, ui_menu_size, ui_name, ui_menu_position, ui_set_callback, ui_new_button, ui_new_label, ui_new_string, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect, ui.is_menu_open, ui.new_hotkey, ui.set, ui.update, ui.menu_size, ui.name, ui.menu_position, ui.set_callback, ui.new_button, ui.new_label, ui.new_string, ui.get
local dragging = (function()local a={}local b,c,d,e,f,g,h,i,j,k,l,m,n,o;local p={__index={drag=function(self,...)local q,r=self:get()local s,t=a.drag(q,r,...)if q~=s or r~=t then self:set(s,t)end;return s,t end,set=function(self,q,r)local j,k=client.screen_size()ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res)end,get=function(self)local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}}function a.new(u,v,w,x)x=x or 10000;local j,k=client.screen_size()local y=ui.new_slider('LUA','A',u..' window position',0,x,v/j*x)local z=ui.new_slider('LUA','A','\n'..u..' window position y',0,x,w/k*x)ui.set_visible(y,false)ui.set_visible(z,false)return setmetatable({name=u,x_reference=y,y_reference=z,res=x},p)end;function a.drag(q,r,A,B,C,D,E)if globals.framecount()~=b then c=ui.is_menu_open()f,g=d,e;d,e=ui.mouse_position()i=h;h=client.key_state(0x01)==true;m=l;l={}o=n;n=false;j,k=client.screen_size()end;if c and i~=nil then if(not i or o)and h and f>q and g>r and f<q+A and g<r+B then n=true;q,r=q+d-f,r+e-g;if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r))end end end;table.insert(l,{q,r,A,B})return q,r,A,B end;return a end)()
local client_set_event_callback = client.set_event_callback
local client_console_log = client.log
local client_console_cmd = client.exec
--end of local variables
--逻辑套用
local me = entity_get_local_player()
local success, surface = pcall(require, 'gamesense/surface')
local anti_aim = require 'gamesense/antiaim_funcs'
local surface_measure_text, surface_draw_text = surface.measure_text, surface.draw_text
if not success then
    error('\n\n - 滚去订阅数据库 \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n')
end
if not anti_aim then
    error('\n\n - 滚去订阅数据库 \n - https://gamesense.pub/forums/viewtopic.php?id=29665\n')
end
local csgo_weapons = require "gamesense/csgo_weapons" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=18807/", 2)
local verdana = surface.create_font('verdana', 12, 400, { 0x200 --[[ Outline ]] })
local verdana3 = surface.create_font('verdana', 13, 400, { 0x200 --[[ Outline ]] })
local verdana4 = surface.create_font('verdana', 18, 700, { 0x80 --[[ Outline ]] })
local custom_font = surface.create_font('Small Pixel', 8, 400, { 0x200 --[[ Outline ]] })
local custom_font1 = surface.create_font('Small Pixel', 14, 400, { 0x200 --[[ Outline ]] })
-- LUA library requirements
local http = require "gamesense/http"
local images = require "gamesense/images" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=22917/", 2)
require 'bit'
--[[
    Menu items
]]
local override_antiaim = ui_new_checkbox("AA", "Anti-aimbot angles", " Enable 404 desync")
local modeswitch = ui.new_combobox("AA", "Anti-Aimbot Angles", "Mode", {"-" ,"Anti-Aim", "Exploits", "Misc", "Visual"})
local aatable = {
    adaptive_fs = ui_new_checkbox("AA", "Anti-aimbot angles", "Ideal body yaw freestanding"),
    manual_aa = ui_new_checkbox("AA", "Anti-aimbot angles", "Manual anti-aim"),
    manual_left = ui_new_hotkey("AA", "Anti-aimbot angles", " < Override manual left"),
    manual_right = ui_new_hotkey("AA", "Anti-aimbot angles", " > Override manual right"),
    manual_back = ui_new_hotkey("AA", "Anti-aimbot angles", " v Override manual back"),
    manual_state = ui_new_slider("AA", "Anti-aimbot angles", "Manual direction", 0, 2, 0),
    change_aa = ui_new_checkbox("AA", "Anti-aimbot angles", "Slow motion dodge"),
    change_aa_on_key = ui.new_hotkey("AA", "Anti-aimbot angles", "Dodge keybind",true),
    legit_aa_use = ui_new_checkbox("AA", "Anti-aimbot angles", "Legit anti-aim on use key"),
    legit_aa_on_key = ui.new_hotkey("AA", "Anti-aimbot angles", "Legit anti-aim rebind"),
    eyeyaw_dt = ui_new_checkbox("AA", "Anti-aimbot angles", "Force eye yaw on DT"),
    forceinair = ui_new_checkbox("AA", "Anti-aimbot angles", "Adaptive body yaw in air"),
}
local exploitstable = {
    enable_slide = ui.new_checkbox("AA", "Anti-aimbot angles", "Better leg movement"),
    fake_up = ui.new_checkbox("AA", "Anti-aimbot angles", "Fake up on land"),
    backtrack = ui.new_checkbox("AA", "Anti-aimbot angles", "Extented backtrack"),
    anti_knife = ui.new_checkbox("AA", "Anti-aimbot angles", "Anti-knife"),
    increase_speed = ui.new_checkbox("AA", "Anti-aimbot angles", "Best DT(recode)"),
    increase_speed_mode = ui.new_combobox("AA", "Anti-aimbot angles", "Speed", {"Stability enhanced", "Speed enhanced"}),
}
local misctable = {
    camcollsion = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Disable Cam Collision"),
    new_slider = ui.new_slider("AA", "Anti-Aimbot Angles", "Thirdperson delta", 0, 150, 150),
    hide_default_inds = ui_new_checkbox("AA", "Anti-aimbot angles", "Hide default indicators"),
    projecttag_enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "404 clan tag"),
}
local duration = 40
local clantags = {
     "     [404 YAW]"
    , "     [404 YAW]"
    , "     [404 YAW]"
    , " |             "
    , " 4|             "
    , " 40|             "
    , " 404|             "
    , " 404 |             "
    , " 404 p|             "
    , " 404 pr|             "
    , " 404 pro|             "
    , " 404 proj|             "
    , " 404 proje|             "
    , " 404 projec|             "
    , " 404 project|             "
    , " 404 project |             "
    , " 404 project |             "
    , " 404 project|             "
    , " 404 projec|             "
    , " 404 proje|             "
    , " 404 proj|             "
    , " 404 pro|             "
    , " 404 pr|             "
    , " 404 p|             "
    , " 404 |             "
    , " 404|             "
    , " 40|             "
    , " 4|             "
    , " |             "
    , "     [404 YAW]"
    , "     [404 YAW]"
    , "     [404 YAW]"
    , }
local visualtable = {
    active = ui.new_checkbox('AA', 'Anti-aimbot angles', 'Watermark | DT indicator'),
    style = ui_new_combobox("AA", "Anti-aimbot angles", "Extends", "Original", "New", "Solus ui"),
    color_picker = ui.new_color_picker('AA', 'Anti-aimbot angles', 'Watermark color picker', 89, 119, 239, 255),
    color_picker1 = ui.new_color_picker('AA', 'Anti-aimbot angles', 'Watermark color picker1', 89, 119, 239, 255),
    debugaa = ui.new_checkbox('AA', 'Anti-aimbot angles', 'Debug anti-aim information'),
    style1 = ui_new_combobox("AA", "Anti-aimbot angles", "Color", "Rainbow", "Colorpicker"),
    color_picker2 = ui.new_color_picker('AA', 'Anti-aimbot angles', 'Watermark color picker1', 89, 119, 239, 255),
    netgraph = ui.new_checkbox('AA', 'Anti-aimbot angles', 'Netgraph'),
    manual_arrows = ui_new_checkbox("AA", "Anti-aimbot angles", "Manual aa indicators"),
    manual_aa_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Override anti-aim", 255, 255, 255, 255),
    side_arrows = ui_new_checkbox("AA", "Anti-aimbot angles", "Body yaw arrows"),
    side_arrows_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Body yaw arrows color", 255, 255, 255, 255),
    on_peek_arrows = ui_new_checkbox("AA", "Anti-aimbot angles", "On peek indicators"),
    on_peek_arrows_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "On peek indicators color", 255, 255, 255, 255),
    indicator_arrow = ui_new_combobox("AA", "Anti-aimbot angles", "Crosshair indicators style", {"Style 1", "Style 2"}),
    arrows_offset = ui.new_slider('AA', 'Anti-aimbot angles', 'Arrows distance', -20, 60, 10),
    font_type = ui_new_combobox("AA", "Anti-aimbot angles", "Font style", {"Style 1", "Style 2"}),
    indicators = ui_new_multiselect("AA", "Anti-aimbot angles", "Indicator list", "Yaw status", "Doubletap",  "Min damage", "Fakeduck", "Hideshots", "Force body aim", "Force safepoint", "Hitrate","Backtrack"),
    indicator_info_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Indicator color1", 255, 255, 255, 255),
    indicator_info_clr1 = ui_new_color_picker("AA", "Anti-aimbot angles", "Indicator color2", 255, 255, 255, 255),
    indicators_offset = ui.new_slider('AA', 'Anti-aimbot angles', 'Indicators distance', -20, 60, -10),

}
fps_prev = 0
frametimes = {}
last_update_time = 0
local function setTableVisibility(table, state)
    for i=1, #table do
        ui.set_visible(table[i], state)
    end
end


local function hsv_to_rgb(h, s, v, a)
	local r, g, b
	local i = math.floor(h * 6);
	local f = h * 6 - i;
	local p = v * (1 - s);
	local q = v * (1 - f * s);
	local t = v * (1 - (1 - f) * s);
	i = i % 6

	if i == 0 then 
		r, g, b = v, t, p
	elseif i == 1 then
		r, g, b = q, v, p
	elseif i == 2 then
		r, g, b = p, v, t
	elseif i == 3 then
		r, g, b = p, q, v
	elseif i == 4 then
		r, g, b = t, p, v
	elseif i == 5 then
		r, g, b = v, p, q
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

local function accumulate_fps()
	local rt, ft = globals.realtime(), globals.absoluteframetime()
	if ft > 0 then
		table.insert(frametimes, 1, ft)
	end

	local count = #frametimes
	if count == 0 then
		return 0
	end

	local accum = 0
	local i = 0
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
		table.remove(frametimes)
	end

	local fps = 1 / accum
	local time_since_update = rt - last_update_time
	if math.abs(fps - fps_prev) > 4 or time_since_update > 1 then
		fps_prev = fps
		last_update_time = rt
	else
		fps = fps_prev
	end

	return math.floor(fps + 0.5)
end
local ffi = require("ffi")
local raw_engine = client.create_interface("engine.dll", "VEngineClient014")
local engine = ffi.cast(ffi.typeof("void***"), raw_engine)[0]

ffi.cdef[[
    typedef void* (__thiscall* get_net_channel)(void*);
    typedef float (__thiscall* get_avg_loss)(void*, int);
    typedef float (__thiscall* get_avg_data)(void*, int);
]]

local get_loss = function()

    local raw_net = ffi.cast("get_net_channel", engine[78])(raw_engine)
    if not raw_net then return 0.0 end
    
    local net = ffi.cast(ffi.typeof("void***"), raw_net)[0]
    local loss = 0.0
    
    loss = loss + ffi.cast("get_avg_loss", net[11])(raw_net, 0)
    loss = loss + ffi.cast("get_avg_loss", net[11])(raw_net, 1)
        
    return loss * 100
    
end

client.set_event_callback("paint", function()
  local w, h = client_screen_size()
	if ui.get(override_antiaim) then
        local loss  = math.floor(get_loss() + 0.5)
        local rainbow_r, rainbow_g, rainbow_b = func_rgb_rainbowize((2 / 10), 1)
        local rainbow_r1, rainbow_g1, rainbow_b1 = func_rgb_rainbowize((1 / 10), 1)
		local system_time = {client.system_time()}
		local steam_avatar = images.get_steam_avatar(entity.get_steam64(entity.get_local_player()))
		local actual_time = string.format("%02d:%02d:%02d", system_time[1], system_time[2], system_time[3])
        local ping_spike_value = string.format("%.f", math.min(999, client.latency() * 1000))
		local text = "[404 desync] PREMIUM USER <VIP> | Update: 2021/05/25" 
        local text1 = "PING  :  " .. ping_spike_value .. "  LOSS  :  " .. loss.. "  FPS  :  " .. accumulate_fps() .. "  TIME  :  " .. actual_time 
		local height = renderer.measure_text(nil, text)
		renderer.text(w/2, h/2 +25 +500, rainbow_r1, rainbow_g1, rainbow_b1, 255, "bc", 0, text)

        local height1 = renderer.measure_text(nil, text1)
        if ui.get(visualtable.netgraph) then
        surface_draw_text(w/2-185, h/2  +480, rainbow_g, rainbow_r, rainbow_b, 255, custom_font1, text1)
        end
       
    end

end)

--lua抬头指标
local function draw_container(x, y, w, h, header, a)
    local c = {10, 60, 40, 40, 40, 60, 20}
    local rainbow_r2, rainbow_g2, rainbow_b2 = func_rgb_rainbowize((1 / 10), 1)
    local rainbow_r1, rainbow_g1, rainbow_b1 = func_rgb_rainbowize((1 / 10), 1)
    for i = 0,6,1 do
        renderer.rectangle(x+i, y+i, w-(i*2), h-(i*2), c[i+1], c[i+1], c[i+1], a)
    end

    if header then
        local x_inner, y_inner = x+7, y+7
        local w_inner = w-14

        renderer.gradient(x_inner, y_inner - 1, math.floor(w_inner/2), 2, m_r, m_g, m_b, a, mt_r, mt_g, mt_b, a, true)
        renderer.gradient(x_inner+math.floor(w_inner/2), y_inner - 1, math.ceil(w_inner/2), 2, mt_r, mt_g, mt_b, a, m_r, m_g, m_b, a, true)

        local a_lower = a
        renderer.gradient(x_inner, y_inner, math.floor(w_inner/2), 2, rainbow_r2, rainbow_g2, rainbow_b2, a_lower, rainbow_r1, rainbow_g1, rainbow_b1, a_lower, true)
        renderer.gradient(x_inner+math.floor(w_inner/2), y_inner, math.ceil(w_inner/2), 2, rainbow_r1, rainbow_g1, rainbow_b1, a_lower, rainbow_r1, rainbow_g1, rainbow_b1, a_lower, true)
    end
end


function skyness_menu_addtitions()
    local rainbow_r, rainbow_g, rainbow_b = func_rgb_rainbowize((2 / 10), 1)
    local rainbow_r1, rainbow_g1, rainbow_b1 = func_rgb_rainbowize((1 / 10), 1)
    local scrsize_x, scrsize_y = client.screen_size( )
    local center_x, center_y = scrsize_x/2, scrsize_y/2
    local scrleft_x, scrleft_y = (( scrsize_x-scrsize_x ) +1 ), (( scrsize_y-scrsize_y ) +1 )
    local c = {10, 60, 40, 40, 40, 60, 20}
    local menu_x, menu_y = ui.menu_position()
    local mouse_x, mouse_y = ui.mouse_position()
    local menu_w, menu_h = ui.menu_size()
    local h = 54
    local conmid_x, conmid_y = (menu_x + (menu_w/2)), menu_y - h/2
    if ui.is_menu_open() and ui.get(override_antiaim)then
        draw_container(menu_x, menu_y - h, menu_w, h - 4,true, 255)
        client.draw_text( c, conmid_x, conmid_y - 2, rainbow_r, rainbow_g, rainbow_b, 255, "bc+", 0, "404 PROJECT" )
        client.draw_text( c, (menu_x+menu_w) - 59, conmid_y + 6, rainbow_b1, rainbow_r, rainbow_g, 255, "bc-", 0, "Welcome,", entity.get_player_name(me))
        client.draw_text( c, (menu_x) + 70, conmid_y + 6, rainbow_r1, rainbow_b, rainbow_g1, 255, "bc-", 0, "What's done is done." )
    end
end
client.set_event_callback("paint_ui", skyness_menu_addtitions)

--[[
    Menu references
]]
ref_md = ui_reference("RAGE", "Aimbot", "Minimum damage")
ref_sp_key = ui_reference("RAGE", "Aimbot", "Force SAFE point")
ref_baim_key = ui_reference("RAGE", "Other", "Force body aim")
ref_fd = ui_reference("RAGE", "Other", "Duck peek assist")
ref_dt, ref_dt_key = ui_reference("RAGE", "Other", "Double tap")
ref_dt_mode = ui_reference("RAGE", "Other", "Double tap mode")
ref_dt_hc = ui_reference("RAGE", "Other", "Double tap hit chance")
ref_dt_fl = ui_reference("RAGE", "Other", "Double tap fake lag limit")
ref_pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch")
ref_yaw, ref_yawadd = ui_reference("AA", "Anti-aimbot angles", "Yaw")
ref_yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base")
ref_yawj, ref_yawjadd = ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")
edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
ref_bodyyaw, ref_bodyyawadd = ui_reference("AA", "Anti-aimbot angles", "Body yaw")
ref_fs_bodyyaw = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
ref_lby_target = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target")
ref_fakelimit = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit")
ref_free, ref_freekey = ui.reference( "AA", "Anti-aimbot angles", "Freestanding")
ref_hs, ref_hs_key= ui_reference("AA", "Other", "On shot anti-aim")
ref_fl = ui_reference("AA", "Fake lag", "Enabled")
ref_fl_amt = ui_reference("AA", "Fake lag", "Amount")
ref_fl_var = ui_reference("AA", "Fake lag", "Variance")
ref_fl_limit = ui_reference("AA", "Fake lag", "Limit")
mindmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
double_tap, double_tap_key = ui.reference("RAGE", "Other", "Double tap")
dt_mode = ui.reference("RAGE", "Other", "Double tap mode")
dt_fake_lag = ui.reference("RAGE", "Other", "Double tap fake lag limit")
sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
default_reference = ui.reference("MISC", "Miscellaneous", "Clan tag spammer")
dt_hit_chance = ui.reference("RAGE", "Other", "Double tap hit chance")
fakelag = ui.reference("AA", "Fake lag", "Limit")
ping, pinghotkey, pingslider = ui.reference("Misc", "Miscellaneous", "Ping spike")

ground_ticks, end_time = 1, 0


--组名
local clantag_prev
function run_tag_animation()
if ui.get(misctable.projecttag_enabled) then
  local cur = math.floor(globals.tickcount() / duration) % #clantags
  local clantag = clantags[cur+1]

  if clantag ~= clantag_prev then
    clantag_prev = clantag
    client.set_clan_tag(clantag)
  end
  end
end


client.set_event_callback("run_command", function(c)
    chokedcmds = c.chokedcommands 
end)

local was_enabled = false
local function on_run_command(c)
    if ui.get(misctable.projecttag_enabled) then
        if (chokedcmds == 0) or not (entity.is_alive(entity.get_local_player())) then
            run_tag_animation()
            was_enabled = true
        end
    elseif (not ui.get(misctable.projecttag_enabled) and not ui.get(default_reference)) and was_enabled then
        client.set_clan_tag("\0")
        was_enabled = false
    end
end
client.set_event_callback("paint", on_run_command)


local best_enemy = nil

local brute = {
    yaw_status = "4 0 4",
    indexed_angle = 0,
    last_miss = 0,
    should_swap = false,
    best_angle = 0,
    misses = { },
    hit_reverse = { }
}

local function includes(table, key)
    for i=1, #table do
        if table[i] == key then
            return true
        end
    end
    return false
end

local wnd = {
    x = database.read("dt_x") or 250,
    y = database.read("dt_y") or 25,
    w = 150,
    dragging = false,
    rx = 0,
}



local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
	local ydelta = local_y - enemy_y
	local xdelta = local_x - enemy_x
	local relativeyaw = math.atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
	return relativeyaw
end

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then return 0 end

    return math.deg(math.atan2(y, x))
end

local vec_3 = function(_x, _y, _z) 
	return { x = _x or 0, y = _y or 0, z = _z or 0 } 
end

local function angle_vector(angle_x, angle_y)
	local sy = math.sin(math.rad(angle_y))
	local cy = math.cos(math.rad(angle_y))
	local sp = math.sin(math.rad(angle_x))
	local cp = math.cos(math.rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function get_damage(me, enemy, x, y,z)
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
	local bestdamage = 0
	local bent = nil
	for i=0, 6 do
		local ent, damage = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
		if damage > bestdamage then
			bent = ent
			bestdamage = damage
		end
	end
	return bent == nil and client_scale_damage(me, 1, bestdamage) or bestdamage
end

local function is_auto_vis(local_player,lx,ly,lz,px,py,pz)
	entindex,dmg = client_trace_bullet(local_player,lx,ly,lz,px,py,pz)
	if entindex == nil then
		return false
	end
	if entindex == local_player then
		return false
	end
	if not entity_is_enemy(entindex) then
		return false
	end
		if dmg >  ref_md then
			return true
		else
			return false
		end
end

local function trace_positions(px,py,pz,px1,py1,pz1,px2,py2,pz2,lx2,ly2,lz2)
	if is_auto_vis(local_player,lx2,ly2,lz2,px,py,pz) then
		return true
	end
	if is_auto_vis(local_player,lx2,ly2,lz2,px1,py1,pz1) then
		return true
	end
	if is_auto_vis(local_player,lx2,ly2,lz2,px2,py2,pz2) then
		return true
	end
	return false
end

local function extrapolate_position(xpos,ypos,zpos,ticks,ent)
	x,y,z = entity_get_prop(ent, "m_vecVelocity")
	for i=0, ticks do
		xpos =  xpos + (x*globals_tickinterval())
		ypos =  ypos + (y*globals_tickinterval())
		zpos =  zpos + (z*globals_tickinterval())
	end
	return xpos,ypos,zpos
end

local function get_best_enemy()
    -- We store the best target in a global variable so we don't have to re run the calculations every time we want to find the best target.
    best_enemy = nil

    local enemies = entity_get_players(true)
    local best_fov = 180

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()
    
    for i=1, #enemies do
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math.abs(normalize_yaw(ang_on_screen(lx - cur_x, ly - cur_y) - view_y + 180))
        if cur_fov < best_fov then
			best_fov = cur_fov
			best_enemy = enemies[i]
		end
    end
end

local function get_best_angle()
    -- Since we run this from run_command no need to check if we are alive or anything.
    local me = entity_get_local_player()

    brute.best_angle = 0

    if not ui_get(override_antiaim) then return end

    if best_enemy == nil then return end

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()
    
    local e_x, e_y, e_z = entity_hitbox_position(best_enemy, 0)

    local yaw = calc_angle(lx, ly, e_x, e_y)
    local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
	local rend_x = lx + rdir_x * 15
    local rend_y = ly + rdir_y * 15
            
    local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
	local lend_x = lx + ldir_x * 15
    local lend_y = ly + ldir_y * 15
            
	local r2dir_x, r2dir_y, r2dir_z = angle_vector(0, (yaw + 90))
	local r2end_x = lx + r2dir_x * 100
	local r2end_y = ly + r2dir_y * 100

	local l2dir_x, l2dir_y, l2dir_z = angle_vector(0, (yaw - 90))
	local l2end_x = lx + l2dir_x * 100
    local l2end_y = ly + l2dir_y * 100      
            
	local ldamage = get_damage(me, best_enemy, rend_x, rend_y, lz)
	local rdamage = get_damage(me, best_enemy, lend_x, lend_y, lz)

	local l2damage = get_damage(me, best_enemy, r2end_x, r2end_y, lz)
	local r2damage = get_damage(me, best_enemy, l2end_x, l2end_y, lz)

    if l2damage > r2damage or ldamage > rdamage then
        if ui_get(aatable.adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 1 or 2)
        else
            brute.best_angle = 1
        end
	elseif r2damage > l2damage or rdamage > ldamage then
        if ui_get(aatable.adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 2 or 1)
        else
            brute.best_angle = 2
        end
	end
end

local function doubletap_charged()
    -- Make sure we have doubletap enabled, are holding our doubletap key & we aren't fakeducking.
    if not ui_get(ref_dt) or not ui_get(ref_dt_key) or ui_get(ref_fd) then return false end

    -- Get our local player.
    local me = entity_get_local_player()

    -- Sanity checks on local player (since paint & a few other events run even when dead).
    if me == nil or not entity_is_alive(me) then return false end

    -- Get our local players weapon.
    local weapon = entity_get_prop(me, "m_hActiveWeapon")

    -- Make sure that it is valid.
    if weapon == nil then return false end

    -- Basic definitions used to calculate if we have recently shot or swapped weapons.
    local next_attack = entity_get_prop(me, "m_flNextAttack") + 0.25
    local next_primary_attack = entity_get_prop(weapon, "m_flNextPrimaryAttack") + 0.5

    -- Make sure both values are valid.
    if next_attack == nil or next_primary_attack == nil then return false end

    -- Return if both are under 0 meaning our doubletap is charged / we can fire (you can also use these values as a 2nd return parameter to get the charge %).
    return next_attack - globals_curtime() < 0 and next_primary_attack - globals_curtime() < 0
end

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



local multi_exec = function(func, list)
    if func == nil then
        return
    end
    
    for ref, val in pairs(list) do
        func(ref, val)
    end
end

local compare = function(tab, val)
    for i = 1, #tab do
        if tab[i] == val then
            return true
        end
    end
    
    return false
end

local bind_system = {
    LEFT = false,
    RIGHT = false,
	BACK = false
}

multi_exec(ui_set_visible, {
    [visualtable.manual_aa_clr] = false,
    [aatable.manual_left] = false,
    [aatable.manual_right] = false,
	[aatable.manual_back] = false,
    [aatable.manual_state] = false,
})

function bind_system:update()
    ui_set(aatable.manual_left, "On hotkey")
    ui_set(aatable.manual_right, "On hotkey")
	ui_set(aatable.manual_back, "On hotkey")

    local m_state = ui_get(aatable.manual_state)

    local left_state, right_state, back_state = 
        ui_get(aatable.manual_left), 
        ui_get(aatable.manual_right),
		ui_get(aatable.manual_back)

    if  left_state == self.LEFT and 
	    back_state == self.BACK and
        right_state == self.RIGHT then
        return
    end

    self.LEFT, self.RIGHT, self.BACK = left_state, right_state, back_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) then
        ui_set(aatable.manual_state, 0)
        return
    end

    if left_state and m_state ~= 1 then
        ui_set(aatable.manual_state, 1)
    end

    if right_state and m_state ~= 2 then
        ui_set(aatable.manual_state, 2)
    end
	if back_state and m_state ~= 0 then
        ui_set(aatable.manual_state, 0)
    end
end

local on_manual_enabled = function(e, menu_call)
    local state = not ui_get(aatable.manual_aa)
    multi_exec(ui_set_visible, {
        [visualtable.manual_aa_clr] = not state,
        [aatable.manual_left] = not state,
        [aatable.manual_right] = not state,
		[aatable.manual_back] = not state,
        [aatable.manual_state] = false,
    })
end

ui_set_callback(aatable.manual_aa, on_manual_enabled)

local function manual_aa_sc()
    if not ui_get(aatable.manual_aa) then
        return
    end

    local direction = ui_get(aatable.manual_state)

    local manual_yaw = {
        [0] = 0,
        [1] = -60, [2] = 60
    }
    local manual_bodyyaw = {
        [0] = 170, [1] = -170, [2] = 170
    }

    if direction == 1 or direction == 2 then
        ui_set(ref_yaw_base, "Local view")
    else
        ui_set(ref_yaw_base, "At targets")
    end

    ui_set(ref_yawadd, manual_yaw[direction])
    if ui.get(aatable.legit_aa_on_key) then
        brute.yaw_status = "LEGIT AA"
        ui.set(ref_yaw_base, "Local view")
        ui.set(ref_pitch, "Off")
		ui.set(ref_yawadd, 180)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_yawj,"Off")
		ui.set(ref_yawjadd, 0)
        ui.set(ref_fs_bodyyaw, false)
		ui.set(ref_lby_target, "Off")
		ui.set(ref_fakelimit, 60)
		ui.set(ref_bodyyawadd, manual_bodyyaw[direction])
    end
end

local function manual_aa_paint()
    on_manual_enabled(true, true)
    bind_system:update()

    local me = entity_get_local_player()
	 local w, h = client_screen_size()
    
    if not entity_is_alive(me) or not ui_get(aatable.manual_aa) then
        return
    end

    local r, g, b, a = ui_get(visualtable.manual_aa_clr)
    local m_state = ui_get(aatable.manual_state)
    
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a

    if m_state == 2 and ui_get(visualtable.indicator_arrow)  == "Style 1" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "<") end
    if m_state == 1 and ui_get(visualtable.indicator_arrow)  == "Style 1" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, ">") end

    if m_state == 1 and ui_get(visualtable.indicator_arrow)   == "Style 1" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "<") end
    if m_state == 2 and ui_get(visualtable.indicator_arrow)   == "Style 1" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, r, g, b, alpha, "+c", 0, ">") end
	
	if m_state == 2 and ui_get(visualtable.indicator_arrow)   == "Style 2" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "‹") end
    if m_state == 1 and ui_get(visualtable.indicator_arrow)   == "Style 2" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "›") end

    if m_state == 1 and ui_get(visualtable.indicator_arrow)   == "Style 2" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "‹") end
    if m_state == 2 and ui_get(visualtable.indicator_arrow)   == "Style 2" and ui_get(visualtable.manual_arrows) then renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "›") end

end
--on peek判定
peeking = false
unpeek = false
is_peeking = false
local is_peeking = function(cmd)

    local lp = entity.get_local_player()
    local pos = { client.eye_position() }
    local vel = { entity.get_prop(lp, "m_vecVelocity") }
    local idx = entity.get_prop(entity.get_player_weapon(lp), "m_iItemDefinitionIndex")
    local speed = 220
    local slider = 128

    predicted_pos = { pos[1] + (vel[1]/speed)*slider, pos[2] + (vel[2]/speed)*slider, pos[3] + (vel[3]/speed)*slider }
    for k, v in pairs(entity.get_players(true)) do
        local head = { entity.hitbox_position(v, 0) }
        local pelvis = { entity.hitbox_position(v, 2) }
        local _, head_ent = client.trace_line(lp, predicted_pos[1], predicted_pos[2], predicted_pos[3], head[1], head[2], head[3])
        local _, pelvis_ent = client.trace_line(lp, predicted_pos[1], predicted_pos[2], predicted_pos[3], pelvis[1], pelvis[2], pelvis[3])

        if head_ent == v or pelvis_ent == v then
            local _, head_ent = client.trace_line(lp, pos[1], pos[2], pos[3], head[1], head[2], head[3])
            local _, pelvis_ent = client.trace_line(lp, pos[1], pos[2], pos[3], pelvis[1], pelvis[2], pelvis[3])
            if head_ent ~= v and pelvis_ent ~= v then
                    peeking = true
                break
            end
        else
            peeking = false
        end
        peeking = false
    end

end
client.set_event_callback("setup_command", is_peeking)
--AA主体

local function set_anti_aim(type)
    brute.should_swap = globals_curtime() - brute.last_miss < 5
    get_best_angle()
    if type == "JITTER" then
        ui.set(ref_yaw, "180")
        ui.set(ref_yawadd, 8)
        ui.set(ref_yawj, "Off")
        ui.set(ref_yawjadd, 0)
        ui.set(ref_bodyyaw, "JITTER")
        ui.set(ref_bodyyawadd, 90)
        ui.set(ref_fs_bodyyaw, false)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 60)
    elseif type == "RIGHT" then
        ui.set(ref_yawadd, -5)
        ui.set(ref_yaw, "180")
		ui.set(ref_yawj,"Offset")
		ui.set(ref_yawjadd, 5)
		ui.set(ref_bodyyaw, "Static")
		ui.set(ref_bodyyawadd, -141)
        ui.set(ref_fs_bodyyaw, false)
		ui.set(ref_lby_target, "Opposite")
		ui.set(ref_fakelimit, 48)
    elseif type == "LEFT" then
        ui.set(ref_yawadd, -5)
        ui.set(ref_yaw, "180")
		ui.set(ref_yawj,"Offset")
		ui.set(ref_yawjadd, 5)
		ui.set(ref_bodyyaw, "Static")
		ui.set(ref_bodyyawadd, 141)
        ui.set(ref_fs_bodyyaw, false)
		ui.set(ref_lby_target, "Opposite")
		ui.set(ref_fakelimit, 48)
    elseif type == "FAKE YAW R" then
        ui.set(ref_yaw, "180")
        ui.set(ref_yawj, "Center")
        ui.set(ref_yawjadd, 3)
        ui.set(ref_bodyyawadd, 95)
        ui.set(ref_fs_bodyyaw, false)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 59)
    elseif type == "FAKE YAW L" then
        ui.set(ref_yaw, "180")
        ui.set(ref_yawj, "Center")
        ui.set(ref_yawjadd, 5)
        ui.set(ref_bodyyawadd, 105)
        ui.set(ref_fs_bodyyaw, false)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 59)
    elseif type == "LOW DELTA" then
        ui.set(ref_yaw, "180")
        ui.set(ref_yawadd, 8)
        ui.set(ref_yawj,"Offset")
        ui.set(ref_yawjadd, 10)
        ui.set(ref_bodyyaw, "Jitter")
        ui.set(ref_bodyyawadd, 128)
        ui.set(ref_fs_bodyyaw, false)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 22)
    end
end

local function is_under_health()
    under_health = false
    if (entity_get_prop(entity.get_local_player(), "m_iHealth") <= 38) then
        under_health = true
    else
        under_health = false
    end
    return under_health
end
--AA逻辑
local function anti_aim1()
    local inair = entity.get_prop(entity.get_local_player(), "m_fFlags") == 256 or entity.get_prop(entity.get_local_player(), "m_fFlags") == 262
    brute.yaw_status = "4 0 4"
    if not ui_get(override_antiaim) then return end


    if ui_get(aatable.manual_aa) and ui_get(aatable.manual_state) == 1 and not ui.get(aatable.legit_aa_on_key) then
        brute.yaw_status = "MANUAL LEFT"
        set_anti_aim("FAKE YAW L")
        return
    elseif ui_get(aatable.manual_aa) and ui_get(aatable.manual_state) == 2 and not ui.get(aatable.legit_aa_on_key) then
            brute.yaw_status = "MANUAL RIGHT"
            set_anti_aim("FAKE YAW R")
            return
    end
       
    if ui.get(aatable.adaptive_fs) then
        if brute.best_angle == 0 then
            if best_enemy == nil then
                brute.yaw_status = "JITTER"
                set_anti_aim("JITTER")
            elseif brute.indexed_angle == 1 then
                if brute.misses[best_enemy] == nil then
                    brute.yaw_status = "PREDICTION"
                    set_anti_aim("RIGHT")
                elseif brute.misses[best_enemy] == 1 then
                    brute.yaw_status = "ANTI-BRUTE"
                    set_anti_aim("LEFT")
                else
                    brute.yaw_status = "PREDICTION"
                    set_anti_aim("RIGHT")
                end
            elseif brute.indexed_angle == 2 then
                if brute.misses[best_enemy] == nil then
                    brute.yaw_status = "PREDICTION"
                    set_anti_aim("LEFT")
                elseif brute.misses[best_enemy] <= 2 then
                    brute.yaw_status = "ANTI-BRUTE"
                    set_anti_aim("RIGHT")
                end
            end
        elseif brute.best_angle == 1 then
            brute.indexed_angle = 1
            if brute.misses[best_enemy] == nil then
                brute.yaw_status = "PREDICTION"
                set_anti_aim("RIGHT")
            elseif brute.misses[best_enemy] == 1 then
                brute.yaw_status = "ANTI-BRUTE"
                set_anti_aim("LEFT")
            else
                brute.yaw_status = "PREDICTION"
                set_anti_aim("RIGHT")
            end
        elseif brute.best_angle == 2 then
            brute.indexed_angle = 2
            if brute.misses[best_enemy] == nil then
                brute.yaw_status = "PREDICTION"
                set_anti_aim("LEFT")
            elseif brute.misses[best_enemy] <= 2 then
                brute.yaw_status = "ANTI-BRUTE"
                set_anti_aim("RIGHT")
            end
        end
    end

    if is_under_health() then
        ui.set(ref_bodyyaw, "Jitter")
        brute.yaw_status = "LOW HP"
    end

    if ui_get(aatable.eyeyaw_dt) then
        if ui_get(ref_dt_key) and ui_get(ref_dt) and not client.key_state(0x45)then
            ui.set(ref_lby_target, "Eye yaw" )
        elseif not ui_get(ref_dt_key) and not ui_get(ref_dt) and client.key_state(0x45)then
            ui.set(ref_lby_target, "Opposite" )
        end
    end
	if ui_get(aatable.legit_aa_use) and client.key_state(0x45) then
	       brute.yaw_status = "LEGIT AA" 
	end

    if ui_get(aatable.legit_aa_on_key) then
        brute.yaw_status = "LEGIT AA"
        ui.set(ref_yaw_base, "Local view")
        ui.set(ref_yawadd, 180)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_yawj,"Off")
		ui.set(ref_yawjadd, 0)
        ui.set(ref_fs_bodyyaw, false)
		ui.set(ref_lby_target, "Off")
		ui.set(ref_fakelimit, 60)
    elseif not ui_get(aatable.legit_aa_on_key) then
        ui.set(ref_pitch, "Default")
        ui.set(ref_yaw_base, "At targets")
    end
    if ui_get(aatable.forceinair) and inair == true and not ui.get(aatable.legit_aa_on_key)then
        brute.yaw_status = "AIR"
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_lby_target, "Eye yaw")
    end
    if ui_get(aatable.change_aa_on_key)  then 
        brute.yaw_status = "SLOW WALK"
        set_anti_aim("LOW DELTA")
    end
end

--fl指示器
local OldChoke = 0
local toDraw4 = 0
local toDraw3 = 0
local toDraw2 = 0
local toDraw1 = 0
local toDraw0 = 0
local function setup_command(cmd)

   if cmd.chokedcommands < OldChoke then --sent
       toDraw0 = toDraw1
       toDraw1 = toDraw2
       toDraw2 = toDraw3
       toDraw3 = toDraw4
       toDraw4 = OldChoke
   end
   
   OldChoke = cmd.chokedcommands

end
client.set_event_callback('setup_command', setup_command)
local notes_pos = function(b)
    local c=function(d,e)
        local f={}
        for g in pairs(d) do 
            table.insert(f,g)
        end;
        table.sort(f,e)
        local h=0;
        local i=function()
            h=h+1;
            if f[h]==nil then 
                return nil 
            else 
                return f[h],d[f[h]]
            end 
        end;
        return i 
    end;
    local j={
        get=function(k)
            local l,m=0,{}
            for n,o in c(package.cnotes) do 
                if o==true then 
                    l=l+1;m[#m+1]={n,l}
                end 
            end;
            for p=1,#m do 
                if m[p][1]==b then 
                    return k(m[p][2]-1)
                end 
            end 
        end,
        set_state=function(q)
            package.cnotes[b]=q;
            table.sort(package.cnotes)
        end,
        unset=function()
            client.unset_event_callback('shutdown',callback)
        end
    }
    client.set_event_callback('shutdown',function()
        if package.cnotes[b]~=nil then package.cnotes[b]=nil end
    end)
    if package.cnotes==nil then 
        package.cnotes={}
    end;
    return j 
end
local note = notes_pos 'b_aa_indicators.v1'
local g_paint_handler = function()
    local w, h = client_screen_size()
    local s_r, s_g, s_b, s_a = ui_get(visualtable.side_arrows_clr)
	local b_r, b_g, b_b, b_a = ui_get(visualtable.on_peek_arrows_clr)
    local _, camera_yaw = client.camera_angles()
    local _, rotation = entity.get_prop(me, 'm_angAbsRotation')
    local body_pos = entity.get_prop(me, "m_flPoseParameter", 11) or 0
    local body_yaw = math.max(-60, math.min(60, body_pos*120-60+0.5))
    body_yaw = (body_yaw < 1 and body_yaw > 0.0001) and math.floor(body_yaw, 1) or body_yaw
    if camera_yaw ~= nil and rotation ~= nil and 60 < math.abs(normalize_yaw(camera_yaw-(rotation+body_yaw))) then
        body_yaw = -body_yaw
    end
    local is_active =  entity.is_alive(me)
    if not is_active then
        locals = {
            last_choke = 0,
            lby_next_think = 0,
        }
    end
    local abs_yaw = math.abs(body_yaw)
    local side = body_yaw < 0 and '>' or (body_yaw > 0.999 and '<' or '-')
    if not is_active then
        return
    end

    -- aa箭头指示
    if not entity_is_alive(entity_get_local_player()) then return end
        if ui_get(override_antiaim) and ui_get(visualtable.side_arrows) then
            if ui_get(visualtable.indicator_arrow) == "Style 1" and ui.get(aatable.adaptive_fs) then
                if not ui_get(aatable.manual_aa) or ui_get(aatable.manual_state) == 0 then
                    if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                        if body_yaw < 0 then
                            renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, 125, "cb+", 0, ">")
                            renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, s_r, s_g, s_b, s_a, "cb+", 0, "<")
                        else
                            renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, s_r, s_g, s_b, s_a, "cb+", 0, ">")
                            renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, 125, "cb+", 0, "<")
                        end 
                        if ui.get(visualtable.on_peek_arrows) and ui.get(aatable.adaptive_fs) and (peeking) and body_yaw < 0 then
                            renderer.text(w / 2 - 50 - ui.get(visualtable.arrows_offset), h / 2, b_r, b_g, b_b, b_a, "cb+", 0, "<")
                        elseif ui.get(visualtable.on_peek_arrows) and ui.get(aatable.adaptive_fs) and (peeking) and body_yaw > 0.999 then
                            renderer.text(w / 2 + 50 + ui.get(visualtable.arrows_offset), h / 2, b_r, b_g, b_b, b_a, "cb+", 0, ">")

                        end
                    end
                end
            end
            if ui_get(visualtable.indicator_arrow) == "Style 2" and ui.get(aatable.adaptive_fs) then
                if not ui_get(aatable.manual_aa) or ui_get(aatable.manual_state) == 0 then
                    if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                        if body_yaw < 0  then
                            renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, 125, "c+", 0, "›")
                            renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, s_r, s_g, s_b, s_a, "c+", 0, "‹")
                        else
                            renderer.text(w / 2 + 40 + ui.get(visualtable.arrows_offset), h / 2, s_r, s_g, s_b, s_a, "c+", 0, "›")
                            renderer.text(w / 2 - 40 - ui.get(visualtable.arrows_offset), h / 2, 125, 125, 125, 125, "c+", 0, "‹")
                        end
                        if ui.get(visualtable.on_peek_arrows) and ui.get(aatable.adaptive_fs) and (peeking) and body_yaw < 0 then
                            renderer.text(w / 2 - 50 - ui.get(visualtable.arrows_offset), h / 2, b_r, b_g, b_b, b_a, "c+", 0, "‹")
                        elseif ui.get(visualtable.on_peek_arrows) and ui.get(aatable.adaptive_fs) and (peeking) and body_yaw > 0.999 then
                            renderer.text(w / 2 + 50 + ui.get(visualtable.arrows_offset), h / 2, b_r, b_g, b_b, b_a, "c+", 0, "›")
                        end
                    end
                end
            end
    end
end
 client.set_event_callback('paint', g_paint_handler)

 local stats = {
	total_shots = 0,
	hits = 0
}
client.set_event_callback("aim_hit", function()
	stats.total_shots = stats.total_shots + 1
	stats.hits = stats.hits + 1
end)

client.set_event_callback("aim_miss", function(e)
	if e.reason ~= "death" and e.reason ~= "unregistered shot" then
		stats.total_shots = stats.total_shots + 1
	end
end)

client.set_event_callback("player_connect_full", function(e)
	if client.userid_to_entindex(e.userid) == entity.get_local_player() then
		stats = {
			total_shots = 0,
			hits = 0
		}
	end
end)

local function draw()
    if not entity_is_alive(entity_get_local_player()) then return end
    local r, g, b, a = ui_get(visualtable.indicator_info_clr)
    local r1, g1, b1, a1 = ui_get(visualtable.indicator_info_clr1)
    local w, h = client_screen_size()
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a
    local me = entity.get_local_player()
    local screen_size = { client.screen_size() }
    local camera_angles = { client.camera_angles() }
    local anti_aim = require 'gamesense/antiaim_funcs'
    local by = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(1) - 120)
    local fy = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(2) - 120)
    local h_index = 0
    local text = string.format("%s/%s  (%s)", stats.hits, stats.total_shots, string.format("%.1f", stats.total_shots ~= 0 and (stats.hits/stats.total_shots*100) or 0))

    if ui.get(visualtable.font_type)== "Style 1" then
        if includes(ui_get(visualtable.indicators), "Yaw status") then
        surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, verdana, "AA")
        surface_draw_text(w / 2 + 30, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 255, 255, 255, verdana, " | ")
        surface_draw_text(w / 2 + 40, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r, g, b, a, verdana, brute.yaw_status)
        h_index = h_index + 1
        end
        if includes(ui_get(visualtable.indicators), "Doubletap") and ui_get(ref_dt_key) and ui_get(ref_dt) then
            if doubletap_charged() then
                surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 154, 255, 31, 255, verdana,  "DT")
                renderer.circle_outline(w / 2 + 38, h / 2 + 42 + (h_index * 12) + ui.get(visualtable.indicators_offset), 0, 0, 0, alpha, 6, -90, 1, 4)
                renderer.circle_outline(w / 2 + 38, h / 2 + 42 + (h_index * 12) + ui.get(visualtable.indicators_offset), 154, 255, 31, alpha, 5, -90, 1, 2)
            else
                surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 54, 31, 255, verdana,  "DT")
                renderer.circle_outline(w / 2 + 38, h / 2 + 42 + (h_index * 12) + ui.get(visualtable.indicators_offset), 0, 0, 0, 255, 6, -90, 1, 4)
                renderer.circle_outline(w / 2 + 38, h / 2 + 42 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 54, 31, 255, 5, -90, math.random(0,1), 2)	
            end
            h_index = h_index + 1
        elseif includes(ui_get(visualtable.indicators), "Doubletap") and not ui_get(ref_dt_key) or not ui_get(ref_dt) then
            surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, verdana,  "FL : ")
            renderer.gradient(w / 2 + 35 , h / 2 + 39 + (h_index * 12) + ui.get(visualtable.indicators_offset) , math.min(OldChoke*2 ), 6, r, g, b, 255, 125, 125, 125, 50, true)
            h_index = h_index + 1
        end

	    if includes(ui_get(visualtable.indicators), "Min damage") then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, verdana, string.format('DMG : ' ))
            surface_draw_text(w / 2 + 47 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r, g, b, a, verdana,  string.format( ui.get(mindmg)))
            h_index = h_index + 1 
	    end

        if includes(ui_get(visualtable.indicators), "Fakeduck") and ui_get(ref_fd) then
            local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 215, 114, 44, alpha, verdana,  "DUCK")
            h_index = h_index + 1
        end

        if includes(ui_get(visualtable.indicators), "Force safepoint") and ui_get(ref_sp_key) then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 125, 225, 255, verdana,  "SAFE")
            h_index = h_index + 1
        end

        if includes(ui.get(visualtable.indicators), "Force body aim") and ui.get(ref_baim_key) then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset),225, 225, 112, 255, verdana,  "BAIM")
            h_index = h_index + 1
        end

        if includes(ui_get(visualtable.indicators), "Hideshots") and ui_get(ref_hs) and ui_get(ref_hs_key) then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 154, 255, 31, alpha, verdana,  "ON-SHOT")
            h_index = h_index + 1
        end

        if includes(ui_get(visualtable.indicators), "Hitrate") then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r, g, b, 255, verdana,  text)
            h_index = h_index + 1
        end

        if includes(ui_get(visualtable.indicators), "Backtrack") then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, verdana, string.format('BACKTRACK' ))
            if ui.get(exploitstable.backtrack) and ui.get(ping) then
            renderer.gradient(w / 2 + 15 , h / 2 + 50 + (h_index * 12) + ui.get(visualtable.indicators_offset) , math.min(math.random(5,19)*math.random(1,3 )), 2, r, g, b, 255, r, g, b, 125, true)
            else
                renderer.gradient(w / 2 + 15 , h / 2 + 50 + (h_index * 12) + ui.get(visualtable.indicators_offset) , math.min(math.random(5,12)*math.random(1,3 )), 2, r, g, b, 255, r, g, b, 125, true)
            end
            h_index = h_index + 1
	    end
    end
    if ui.get(visualtable.font_type)== "Style 2" then
        if includes(ui_get(visualtable.indicators), "Yaw status") then
        surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, custom_font, "AA")
        surface_draw_text(w / 2 + 30, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 255, 255, 255, custom_font, " | ")
        surface_draw_text(w / 2 + 40, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r, g, b, a, custom_font, brute.yaw_status)
        h_index = h_index + 1
        end
        if includes(ui_get(visualtable.indicators), "Doubletap") and ui_get(ref_dt_key) and ui_get(ref_dt) then
            if doubletap_charged() then
                surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 154, 255, 31, 255, custom_font,  "DT")
                renderer.circle_outline(w / 2 + 38, h / 2 + 39 + (h_index * 12) + ui.get(visualtable.indicators_offset), 0, 0, 0, alpha, 6, -90, 1, 4)
                renderer.circle_outline(w / 2 + 38, h / 2 + 39 + (h_index * 12) + ui.get(visualtable.indicators_offset), 154, 255, 31, alpha, 5, -90, 1, 2)
            else
                surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 54, 31, 255, custom_font,  "DT")
                renderer.circle_outline(w / 2 + 38, h / 2 + 39 + (h_index * 12) + ui.get(visualtable.indicators_offset), 0, 0, 0, 255, 6, -90, 1, 4)
                renderer.circle_outline(w / 2 + 38, h / 2 + 39 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 54, 31, 255, 5, -90, math.random(0,1), 2)	
            end
            h_index = h_index + 1
        elseif includes(ui_get(visualtable.indicators), "Doubletap") and not ui_get(ref_dt_key) or not ui_get(ref_dt) then
            surface_draw_text(w / 2 + 15, h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, custom_font,  "FL : ")
            renderer.gradient(w / 2 + 35 , h / 2 + 37 + (h_index * 12) + ui.get(visualtable.indicators_offset) , math.min(OldChoke*2 ), 6, r, g, b, 255, 125, 125, 125, 50, true)
            h_index = h_index + 1
        end
    
        if includes(ui_get(visualtable.indicators), "Min damage") then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, custom_font, string.format('DMG : ' ))
            surface_draw_text(w / 2 + 47 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r, g, b, a, custom_font,  string.format( ui.get(mindmg)))
            h_index = h_index + 1 
        end
            
        if includes(ui_get(visualtable.indicators), "Fakeduck") and ui_get(ref_fd) then
            local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 215, 114, 44, alpha, custom_font,  "DUCK")
            h_index = h_index + 1
        end
    
        if includes(ui_get(visualtable.indicators), "Force safepoint") and ui_get(ref_sp_key) then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 255, 125, 225, 255, custom_font,  "SAFE")
            h_index = h_index + 1
        end
    
        if includes(ui.get(visualtable.indicators), "Force body aim") and ui.get(ref_baim_key) then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset),225, 225, 112, 255, custom_font,  "BAIM")
            h_index = h_index + 1
        end
    
        if includes(ui_get(visualtable.indicators), "Hideshots") and ui_get(ref_hs) and ui_get(ref_hs_key) then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), 154, 255, 31, alpha, custom_font,  "ON-SHOT")
            h_index = h_index + 1
        end

        if includes(ui_get(visualtable.indicators), "Hitrate") then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r, g, b, 255, custom_font,  text)
            h_index = h_index + 1
        end
    
        if includes(ui_get(visualtable.indicators), "Backtrack") then
            surface_draw_text(w / 2 + 15 , h / 2 + 35 + (h_index * 12) + ui.get(visualtable.indicators_offset), r1, g1, b1, a1, custom_font, string.format('BACKTRACK' ))
            if ui.get(exploitstable.backtrack) and ui.get(ping) then
            renderer.gradient(w / 2 + 15 , h / 2 + 48 + (h_index * 12) + ui.get(visualtable.indicators_offset) , math.min(math.random(5,19)*math.random(1,3 )), 2, r, g, b, 255, r, g, b, 125, true)
            else
                renderer.gradient(w / 2 + 15 , h / 2 + 48 + (h_index * 12) + ui.get(visualtable.indicators_offset) , math.min(math.random(5,12)*math.random(1,3 )), 2, r, g, b, 255, r, g, b, 125, true)
            end
            h_index = h_index + 1
        end
    end
    

    if ui.get(misctable.hide_default_inds) then
        for i = 1, 400 do
            renderer.indicator(0, 0, 0, 0, " ")
        end
    end
end




brute.impact = function(e)
    if not ui_get(override_antiaim) then return end

    local me = entity_get_local_player()

    -- Since bullet_impact gets triggered even while we're dead having this check is a good idea.
    if not entity_is_alive(me) then return end

    local shooter_id = e.userid
    local shooter = client_userid_to_entindex(shooter_id)

    -- Distance calculations can sometimes bug when the entity is dormant hence the 2nd check.
    if not entity_is_enemy(shooter) or entity_is_dormant(shooter) then return end

    local lx, ly, lz = entity_hitbox_position(me, "head_0")
    
	local ox, oy, oz = entity_get_prop(me, "m_vecOrigin")
    local ex, ey, ez = entity_get_prop(shooter, "m_vecOrigin")

    local dist = ((e.y - ey)*lx - (e.x - ex)*ly + e.x*ey - e.y*ex) / math.sqrt((e.y-ey)^2 + (e.x - ex)^2)
    
    -- 32 is our miss detection radius and the 2nd check is to avoid adding more than 1 miss for a singular bullet (bullet_impact gets called mulitple times per shot).
    if math.abs(dist) <= 135 and globals_curtime() - brute.last_miss > 0.025 then
        brute.last_miss = globals_curtime()
        if brute.misses[shooter] == nil then
            brute.misses[shooter] = 1 
        elseif brute.misses[shooter] >= 2 then
            brute.misses[shooter] = nil
        else
            brute.misses[shooter] = brute.misses[shooter] + 1
        end
    end
end

brute.hurt = function(e)
    if not ui_get(override_antiaim) or not ui_get(aatable.adaptive_fs) then return end

    local victim_id = e.userid
    local victim = client_userid_to_entindex(victim_id)
    local attacker_id = e.attacker
    local attacker = client_userid_to_entindex(attacker_id)

    if victim ~= entity_get_local_player() or not entity_is_enemy(attacker) or e.hitgroup ~= 1 then return end

    if brute.misses[attacker] == nil or (globals_curtime() - brute.last_miss < 0.025 and brute.misses[attacker] == 1) then
        if brute.hit_reverse[attacker] == nil then
            brute.hit_reverse[attacker] = true
        else
            brute.hit_reverse[attacker] = nil
        end
    end
end

--增强回溯

client.set_event_callback("run_command", function(c)
    if ui.get(exploitstable.backtrack) then
        local local_player = entity.get_local_player()
            if local_player ~= nil then
                local weapon = entity.get_player_weapon(local_player)
                    local item = entity.get_prop(weapon, "m_iItemDefinitionIndex")
                    if item ~= nil then
                    if(item == 40 or item == 9 or item == 38 or item == 11) then -- scar20
                    ui.set(ping, true)
                    ui.set(pingslider, 199)
                    ui.set(pinghotkey, "Always On")
                    else
                    ui.set(ping, false)
                    ui.set(pingslider, 1)
                    ui.set(pinghotkey, "On hotkey")
                end
            end
        end
    end
end)

--落地抬头
client.set_event_callback("pre_render", function()
if entity.is_alive(entity.get_local_player()) then
	
    if ui.get(exploitstable.fake_up) then
        local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1)

        if on_ground == 1 then
            ground_ticks = ground_ticks + 1
        else
            ground_ticks = 0
            end_time = globals.curtime() + 1
        end 
    
        if ground_ticks > ui.get(fakelag)+1 and end_time > globals.curtime() then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
        end
    end
end 
end)

--增强dt
local dt = function()
    local dt, dt_key = ui.reference("RAGE", "Other", "Double tap")
    local dt1 = {ui.reference("RAGE", "Other", "Double tap")}
    local dt_fake_lag = ui.reference("RAGE", "Other", "Double tap fake lag limit")
    local dt_hit_chance = ui.reference("RAGE", "Other", "Double tap hit chance")
    local dt_mode = ui.reference("RAGE", "Other", "Double tap mode")
    local maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

	local a_stored = 240
	local a2_stored = 240

    ui.set_visible(maxusrcmdprocessticks, state)

    local contains = function(table, value)
        for _, v in ipairs(ui.get(table)) do
            if v == value then 
            	return true 
            end
        end
        return false
    end

    local function weaponcontains(list, data)
  		for i, v in pairs(list) do
    		if(v == data) then 
      			return true 
    		end
  		end
  		return false
	end

    local lp = function()
        local real_lp = entity.get_local_player()
        if entity.is_alive(real_lp) then
            return real_lp
        else
            local obvserver = entity.get_prop(real_lp, "m_hObserverTarget")
            return obvserver ~= nil and obvserver <= 64 and obvserver or nil
        end
    end

    local vector = require "vector"
    local calc_dmg = function(local_player, player, distance)
        local weapon_ent = entity.get_player_weapon(local_player)
        if weapon_ent == nil then return end
        
        local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
        if weapon_idx == nil then return end
        
        local weapon = csgo_weapons[weapon_idx]
        if weapon == nil then return end
    
        local dmg_after_range= (weapon.damage * math.pow(weapon.range_modifier, (distance * 0.002))) * 1.25 
        local armor = entity.get_prop(player,"m_ArmorValue")
        if armor == nil then armor = 0 end
        local newdmg = dmg_after_range * (weapon.armor_ratio * 0.5)
        if dmg_after_range - (dmg_after_range * (weapon.armor_ratio * 0.5)) * 0.5 > armor then
            newdmg = dmg_after_range - (armor / 0.5)
        end
        return newdmg
    end

    local data = {
        old_tickbase = 0,
        old_sim_time = 0,
        shifted_ticks = 0,
        old_command_num = 0,
        skip_next_differ = false,
        charged_before = false,
        did_shift_before = false,
        can_shift_tickbase = 0,
        is_cmd_safe = true,
        last_charge = 0,
        validate_cmd = ui.get(maxusrcmdprocessticks),
        lag_state = nil,
        delay = 0
    }
    local player = {
        in_attack = 0,
        command_number = 0,
        choked_commands = 0
    }
    local shift_info = {
        data = {}, 
        shift_time = 0, 
        shift_data = {}
    }
    
    local vulnerable_items = {
        "CKnife",
        "CSmokeGrenade",
        "CFlashbang",
        "CHEGrenade",
        "CDecoyGrenade",
        "CIncendiaryGrenade",
        "CMolotovGrenade",
        "CC4"
    }

    local by = function(bz)
        local b9 = 0
        for _, v in pairs(bz) do
            b9 = b9 + 1
        end
        return b9
    end

    local type=type;local setmetatable=setmetatable;local tostring=tostring;local a=math.pi;local b=math.min;local c=math.max;local d=math.deg;local e=math.rad;local f=math.sqrt;local g=math.sin;local h=math.cos;local i=math.atan;local j=math.acos;local k=math.fmod;local l={}l.__index=l;function Vector3(m,n,o)if type(m)~="number"then m=0.0 end;if type(n)~="number"then n=0.0 end;if type(o)~="number"then o=0.0 end;m=m or 0.0;n=n or 0.0;o=o or 0.0;return setmetatable({x=m,y=n,z=o},l)end;function l.__eq(p,q)return p.x==q.x and p.y==q.y and p.z==q.z end;function l.__unm(p)return Vector3(-p.x,-p.y,-p.z)end;function l.__add(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x+q.x,p.y+q.y,p.z+q.z)elseif r=="table"and s=="number"then return Vector3(p.x+q,p.y+q,p.z+q)elseif r=="number"and s=="table"then return Vector3(p+q.x,p+q.y,p+q.z)end end;function l.__sub(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x-q.x,p.y-q.y,p.z-q.z)elseif r=="table"and s=="number"then return Vector3(p.x-q,p.y-q,p.z-q)elseif r=="number"and s=="table"then return Vector3(p-q.x,p-q.y,p-q.z)end end;function l.__mul(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x*q.x,p.y*q.y,p.z*q.z)elseif r=="table"and s=="number"then return Vector3(p.x*q,p.y*q,p.z*q)elseif r=="number"and s=="table"then return Vector3(p*q.x,p*q.y,p*q.z)end end;function l.__div(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x/q.x,p.y/q.y,p.z/q.z)elseif r=="table"and s=="number"then return Vector3(p.x/q,p.y/q,p.z/q)elseif r=="number"and s=="table"then return Vector3(p/q.x,p/q.y,p/q.z)end end;function l.__tostring(p)return"( "..p.x..", "..p.y..", "..p.z.." )"end;function l:clear()self.x=0.0;self.y=0.0;self.z=0.0 end;function l:unpack()return self.x,self.y,self.z end;function l:length_2d_sqr()return self.x*self.x+self.y*self.y end;function l:length_sqr()return self.x*self.x+self.y*self.y+self.z*self.z end;function l:length_2d()return f(self:length_2d_sqr())end;function l:length()return f(self:length_sqr())end;function l:dot(t)return self.x*t.x+self.y*t.y+self.z*t.z end;function l:cross(t)return Vector3(self.y*t.z-self.z*t.y,self.z*t.x-self.x*t.z,self.x*t.y-self.y*t.x)end;function l:dist_to(t)return(t-self):length()end;function l:is_zero(u)u=u or 0.001;if self.x<u and self.x>-u and self.y<u and self.y>-u and self.z<u and self.z>-u then return true end;return false end;function l:normalize()local v=self:length()if v<=0.0 then return 0.0 end;self.x=self.x/v;self.y=self.y/v;self.z=self.z/v;return v end;function l:normalize_no_len()local v=self:length()if v<=0.0 then return end;self.x=self.x/v;self.y=self.y/v;self.z=self.z/v end;function l:normalized()local v=self:length()if v<=0.0 then return Vector3()end;return Vector3(self.x/v,self.y/v,self.z/v)end;function clamp(w,x,y)if w<x then return x elseif w>y then return y end;return w end;function normalize_angle(z)local A;local B;B=tostring(z)if B=="nan"or B=="inf"then return 0.0 end;if z>=-180.0 and z<=180.0 then return z end;A=k(k(z+360.0,360.0),360.0)if A>180.0 then A=A-360.0 end;return A end;function vector_to_angle(C)local v;local D;local E;v=C:length()if v>0.0 then D=d(i(-C.z,v))E=d(i(C.y,C.x))else if C.x>0.0 then D=270.0 else D=90.0 end;E=0.0 end;return Vector3(D,E,0.0)end;function angle_forward(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))return Vector3(G*I,G*H,-F)end;function angle_right(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))local J=g(e(z.z))local K=h(e(z.z))return Vector3(-1.0*J*F*I+-1.0*K*-H,-1.0*J*F*H+-1.0*K*I,-1.0*J*G)end;function angle_up(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))local J=g(e(z.z))local K=h(e(z.z))return Vector3(K*F*I+-J*-H,K*F*H+-J*I,K*G)end;function get_FOV(L,M,N)local O;local P;local Q;local R;P=angle_forward(L)Q=(N-M):normalized()R=j(P:dot(Q)/Q:length())return c(0.0,d(R))end

    local on_predict_cmd = function(player)
        local shift = 0
        local local_player = entity.get_local_player()
        local local_player_weapon = entity.get_player_weapon(local_player)

        local can_shift = function(local_player, local_player_weapon, buffer)
            if local_player_weapon == nil then return false end
            
            local local_tickbase = entity.get_prop(local_player, "m_nTickBase")
            local interval = globals.tickinterval() * (local_tickbase - buffer)

            if interval < entity.get_prop(local_player, "m_flNextAttack") then
                return false
            end
            if interval < entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") then
                return false
            end

            return true
        end
        
        if data.validate_cmd > 0 then
            data.validate_cmd = data.validate_cmd - 1
        end

        local ushift = can_shift(local_player, local_player_weapon, 13)
        local absshift = can_shift(local_player, local_player_weapon, math.abs(-1 - shift))
        
        if ushift == true or absshift == false and data.did_shift_before == true then
            shift = 13
        else
            shift = 0
        end

        local local_tickbase = entity.get_prop(local_player, "m_nTickBase")
        if data.old_tickbase ~= 0 and local_tickbase < data.old_tickbase then
            if data.old_tickbase - local_tickbase > 11 then
                data.skip_next_differ = true
                data.charged_before = false
                data.can_shift_tickbase = false
            end
        end

        local current_cmd_num = player.command_number - data.old_command_num
        if current_cmd_num >= 11 and current_cmd_num <= ui.get(maxusrcmdprocessticks) then
            data.can_shift_tickbase = not data.skip_next_differ
            data.charged_before = data.can_shift_tickbase
            data.last_charge = current_cmd_num + 1
            data.is_cmd_safe = current_cmd_num > 3 and math.abs(ui.get(maxusrcmdprocessticks) - current_cmd_num) <= 3
            data.delay = math.abs(ui.get(maxusrcmdprocessticks) - data.last_charge)
        end

        if ushift == false then
            data.can_shift_tickbase = false
        else
            data.can_shift_tickbase = data.charged_before
        end

        data.old_tickbase = local_tickbase
        data.old_command_num = player.command_number
        data.skip_next_differ = false
        data.did_shift_before = shift ~= 0
        data.can_shift_tickbase = data.can_shift_tickbase and 2 or 0

        if data.can_shift_tickbase == 0 and data.charged_before == true then
            data.can_shift_tickbase = 1
        end

        if data.can_shift_tickbase == 0 then
            data.last_charge = 0
        end
    end

    local on_setup_cmd = function(player)
        if data.lag_state ~= nil and data.can_break_lby then
            ui.set(dt, data.lag_state)
            data.lag_state = nil
        end

        local is_fast = ui.get(exploitstable.increase_speed_mode) == "Speed enhanced"
        local dt_enabled = ui.get(dt) and ui.get(dt_key)
        local player_can_shift = data.can_shift_tickbase
        local is_offensive = dt_enabled and ui.get(dt_mode) == "Offensive"
        local should_attack = false
        local local_player_velocity = {entity.get_prop(entity.get_local_player(), "m_vecVelocity")}
        local floored_velocity = math.floor(math.sqrt(local_player_velocity[1] ^ 2 + local_player_velocity[2] ^ 2 + local_player_velocity[3] ^ 2) + 0.5)
        local will_attack = false
        data.can_break_lby = false
        
        if shift_info.shift_time > 0 then
            local current_last_charge = data.last_charge
            local shift_info_data_unpacked = shift_info.data[by(shift_info.data)]
            
            if is_fast and by(shift_info.data) > 0 and shift_info_data_unpacked ~= nil then
                player.in_attack = 1
                if shift_info.shift_time == current_last_charge or current_last_charge < 1 then
                    should_attack = true
                    will_attack = true
                end
                if should_attack and player.in_attack == 0 then
                    player.in_attack = 1
                end
            end

            shift_info.shift_data[#shift_info.shift_data + 1] = {
                shift_info.shift_time,
                player_can_shift,
                player.chokedcommands,
                entity.get_prop(entity.get_local_player(), "m_nTickBase"),
                globals.tickcount(),
                "false"
            }

            if shift_info.shift_time ~= 0 and (will_attack == true or shift_info.shift_time == current_last_charge or current_last_charge < 1) then
                shift_info.shift_time = 0
                shift_info.shift_data = {}
                shift_info.data = {}
            else
                shift_info.shift_time = shift_info.shift_time + 1
            end
        end

        if shift_info.shift_time == 0 and should_attack == false and (is_offensive == true and player_can_shift == 0 or floored_velocity <= 1.01 and player_can_shift == 2) then
            data.lag_state = dt_enabled
            if by(shift_info.shift_data) > 0 then
                shift_info.shift_data[by(shift_info.shift_data)][6] = tostring(dt_enabled)
            end
        end
        if data.lag_state ~= nil and data.can_break_lby then
            ui.set(dt, false)
        end
    end

    local vec_data, flip = { }, true
    local length_2d_sqr = function(vec) return (vec[1]*vec[1] + vec[2]*vec[2]) end
    local vec_enemy_vec = function(vec, vec1) return { vec[1]-vec1[1], vec[2]-vec1[2] } end
    local function normalize_yaw(angle)
        angle = (angle % 360 + 360) % 360
        return angle > 180 and angle - 360 or angle
    end
    local function world2screen(xdelta, ydelta)
        if xdelta == 0 and ydelta == 0 then
            return 0
        end
        return math.deg(math.atan2(ydelta, xdelta))
    end

    local best_player  = function()
        local idx = nil
        local close = math.huge
    
        local myorigin = {entity.get_origin(lp())}
        local myview = {client.camera_angles()}
        local enemies = entity.get_players(true)
    
        for i=1, #enemies do 
            if entity.is_alive(i) and entity.is_enemy(i) and entity.is_dormant(i) == false then
                local origin = {entity.get_origin(i)}
                if origin[1] then
                    local fov = math.abs(normalize_yaw(world2screen(origin[1] - myorigin[1], origin[2] - myorigin[2]) - myview[2]))
                    if fov < close then
                        idx = i
                        close = fov
                    end
                end
            end
        end
        return idx
    end

    local lagcomp = function()
        if (vec_data[0] and vec_data[1]) then
            local lag_dst = length_2d_sqr(vec_enemy_vec(vec_data[0], vec_data[1]))

            lag_dst = lag_dst - 64 * 64 
            lag_dst = lag_dst < 0 and 0 or lag_dst / 30
            lag_dst = lag_dst > 62 and 62 or lag_dst

            if lag_dst > 0 then return true end
            return false
        end
    end

    local enemy_vuln = function()
        local enemy = best_player()
        local enemy_weapon = entity.get_player_weapon(enemy)
        local enemy_weapon_classname = entity.get_classname(enemy_weapon)

        if enemy == nil then return false end
        local local_origin = vector(entity.get_prop(entity.get_local_player(), "m_vecAbsOrigin"))
		local distance = local_origin:dist(vector(entity.get_prop(enemy, "m_vecOrigin")))
        local enemy_health = entity.get_prop(enemy, "m_iHealth")
		local damage = calc_dmg(entity.get_local_player(), enemy, distance)

        if enemy_health <= damage then return true end

        for i=0, #vulnerable_items do
            if enemy_weapon_classname == vulnerable_items[i] then 
                return true
            end
        end

        return false
    end

    local local_vuln = function()
        local enemy_weapon = entity.get_player_weapon(best_player())
        local enemy_weapon_classname = entity.get_classname(enemy_weapon)

        local enemy_origin = vector(entity.get_prop(entity.get_local_player(), "m_vecAbsOrigin"))
		local distance = enemy_origin:dist(vector(entity.get_prop(best_player(), "m_vecOrigin")))
		local local_health = entity.get_prop(entity.get_local_player(), "m_iHealth")
		local damage = calc_dmg(best_player(), entity.get_local_player(), distance)

        if best_player() ~= nil then
            if enemy_weapon_classname == "CWeaponAwp" then 
                return true
            end
        end

        return false
    end

    local units_to_feet = function(units)
        local units_to_meters = units * 0.0254
    
        return units_to_meters * 3.281
    end


    local dt_set = function(fl, cmd, clock)
        ui.set(dt_fake_lag, fl)
        ui.set(maxusrcmdprocessticks, cmd)
        cvar.cl_clock_correction:set_int(clock)
    end


    local on_run_cmd = function(cmd)

        if data.lag_state ~= nil and data.can_break_lby then
            ui.set(dt, data.lag_state)
            data.lag_state = nil
        end

        if best_player() ~= nil and cmd.chokedcommands == 0 then
            local x, y, z = entity.get_prop(best_player(), "m_vecOrigin")
            vec_data[flip and 0 or 1] = { x, y }
            flip = not flip
        end

        if ui.get(exploitstable.increase_speed_mode) == "Speed enhanced" then
            dt_set(1, 19, data.is_cmd_safe and 0 or 0)
        end
        

        if ui.get(exploitstable.increase_speed_mode) == "Stability enhanced" then
            dt_set(data.is_cmd_safe and 1 or 2, 17, 1)
        end

        if not ui.get(exploitstable.increase_speed) then
            ui.set(sv_maxusrcmdprocessticks, 16)
        end


    end
     


    local on_shutdown = function()
        ui.set(maxusrcmdprocessticks, 16)
        cvar.cl_clock_correction:set_int(0)
    end
    
    ui.set_callback(exploitstable.increase_speed,function() if not ui.get(exploitstable.increase_speed) then on_shutdown() end end)

    client["set_event_callback"]("predict_command", on_predict_cmd)
    client["set_event_callback"]("setup_command", on_setup_cmd)
    client["set_event_callback"]("run_command", on_run_cmd)
    client["set_event_callback"]("shutdown", on_shutdown)
end
dt()

--反背刺
local event_handler_functions = {
    [true]  = client.set_event_callback,
    [false] = client.unset_event_callback,
}

local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

local function on_run_command()
    local players = entity.get_players(true)
    local lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
	local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
    for i=1, #players do
        local x, y, z = entity.get_prop(players[i], "m_vecOrigin")
        local distance = get_distance(lx, ly, lz, x, y, z)
        local weapon = entity.get_player_weapon(players[i])
        if entity.get_classname(weapon) == "CKnife" and distance <= 164 then
            ui.set(yaw_slider,180)
        end
    end
end

local function on_script_toggle_change()
    local state = ui.get(exploitstable.anti_knife)
    local handle_event = event_handler_functions[state]
    handle_event("run_command", on_run_command)
end

on_script_toggle_change()
ui.set_callback(exploitstable.anti_knife, on_script_toggle_change)



--cam_collision
ui.set_callback(misctable.new_slider, function()
    slider = ui.get(misctable.new_slider)
client.exec("cam_idealdist ", slider)
end)
ui.set_callback(misctable.camcollsion, function()
    client.set_event_callback("paint", function()
    if ui.get(misctable.camcollsion) and ui.get(override_antiaim)then 
        client.exec("cam_collision 0")
    else
        client.exec("cam_collision 1")
    end
end)
end)

--水印以及dt指示器

local client_get_can_exploit = function(localplayer, weapons, tickbase_correct)
	if weapons == nil then
		return
	end

	local tickbase = entity.get_prop(localplayer, "m_nTickBase")
	local curtime = globals.tickinterval() * (tickbase - tickbase_correct)
	if curtime < entity.get_prop(localplayer, "m_flNextAttack") then
		return false
	end
    
	if curtime < entity.get_prop(weapons, "m_flNextPrimaryAttack") then
		return false
	end
    
	return true
end

nickname = entity.get_player_name(me)
ctag = '404 Desync'

ffi.cdef('typedef bool(__thiscall* is_ingame_t)(void*);')
ffi.cdef('typedef void*(__thiscall* get_net_channel_info_t)(void*);')
ffi.cdef('typedef float(__thiscall* get_avg_latency_t)(void*, int);')

local interface_ptr = ffi.typeof('void***')
local rawivengineclient = client.create_interface('engine.dll', 'VEngineClient014') or error('VEngineClient014 wasnt found', 2)
local ivengineclient = ffi.cast(interface_ptr, rawivengineclient) or error('rawivengineclient is nil', 2)

local get_net_channel_info = ffi.cast('get_net_channel_info_t', ivengineclient[0][78]) or error('ivengineclient is nil')
local is_in_game = ffi.cast('is_ingame_t', ivengineclient[0][26]) or error('is_in_game is nil')

local notes_pos = function(b)local c=function(d,e)local f={}for g in pairs(d)do table.insert(f,g)end;table.sort(f,e)local h=0;local i=function()h=h+1;if f[h]==nil then return nil else return f[h],d[f[h]]end end;return i end;local j={get=function(k)local l,m=0,{}for n,o in c(package.cnotes)do if o==true then l=l+1;m[#m+1]={n,l}end end;for p=1,#m do if m[p][1]==b then return k(m[p][2]-1)end end end,set_state=function(q)package.cnotes[b]=q;table.sort(package.cnotes)end,unset=function()client.unset_event_callback('shutdown',callback)end}client.set_event_callback('shutdown',function()if package.cnotes[b]~=nil then package.cnotes[b]=nil end end)if package.cnotes==nil then package.cnotes={}end;return j end
local syn = notes_pos 'a_watermark'
local weapon_names = {
    [1] = "weapon_deagle",
    [2] = "weapon_elite",
    [3] = "weapon_fiveseven",
    [4] = "weapon_glock",
    [7] = "weapon_ak47",
    [8] = "weapon_aug",
    [9] = "weapon_awp",
    [10] = "weapon_famas",
    [11] = "weapon_g3sg1",
    [13] = "weapon_galilar",
    [14] = "weapon_m249",
    [16] = "weapon_m4a1",
    [17] = "weapon_mac10",
    [19] = "weapon_p90",
    [23] = "weapon_mp5sd",
    [24] = "weapon_ump45",
    [25] = "weapon_xm1014",
    [26] = "weapon_bizon",
    [27] = "weapon_mag7",
    [28] = "weapon_negev",
    [29] = "weapon_sawedoff",
    [30] = "weapon_tec9",
    [31] = "weapon_taser",
    [32] = "weapon_hkp2000",
    [33] = "weapon_mp7",
    [34] = "weapon_mp9",
    [35] = "weapon_nova",
    [36] = "weapon_p250",
    [38] = "weapon_scar20",
    [39] = "weapon_sg556",
    [40] = "weapon_ssg08",
    [41] = "weapon_knifegg",
    [42] = "weapon_knife",
    [43] = "weapon_flashbang",
    [44] = "weapon_hegrenade",
    [45] = "weapon_smokegrenade",
    [46] = "weapon_molotov",
    [47] = "weapon_decoy",
    [48] = "weapon_incgrenade",
    [49] = "weapon_c4",
    [50] = "item_kevlar",
    [51] = "item_assaultsuit",
    [52] = "item_heavyassaultsuit",
    [55] = "item_defuser",
    [56] = "item_cutters",
    [57] = "weapon_healthshot",
    [59] = "weapon_knife_t",
    [60] = "weapon_m4a1_silencer",
    [61] = "weapon_usp_silencer",
    [63] = "weapon_cz75a",
    [64] = "weapon_revolver",
    [68] = "weapon_tagrenade",
    [69] = "weapon_fists",
    [70] = "weapon_breachcharge",
    [72] = "weapon_tablet",
    [74] = "weapon_melee",
    [75] = "weapon_axe",
    [76] = "weapon_hammer",
    [78] = "weapon_spanner",
    [80] = "weapon_knife_ghost",
    [81] = "weapon_firebomb",
    [82] = "weapon_diversion",
    [83] = "weapon_frag_grenade",
    [84] = "weapon_snowball",
    [512] = "weapon_knife_falchion",
    [514] = "weapon_knife_survival_bowie",
    [515] = "weapon_knife_butterfly",
    [516] = "weapon_knife_push",
    [503] = "weapon_knifegg",
    [522] = "weapon_knife_stiletto",
    [519] = "weapon_knife_ursus",
    [520] = "weapon_knife_gypsy_jackknife",
    [505] = "weapon_knife_flip",
    [506] = "weapon_knife_gut",
    [507] = "weapon_knife_karambit",
    [508] = "weapon_knife_m9_bayonet",
    [509] = "weapon_knife_tactical",
    [500] = "weapon_bayonet",
    [523] = "weapon_knife_widowmaker"
}

local weapons = {
    shots_1 = {ssg08 = 40, awp = 9,},
    shots_2 = {scar = 38, g3sg1 = 11, deagle = 1, glock = 4, p250 = 36, usp = 61,},
    shots_3 = {dual = 2, fiveseven = 3, ak47 = 7, aug = 8, famas = 10, m4a4 = 16, cz75 = 63,},
    shots_4 = {mp9 = 34, mp7 = 33, mac10 = 17, mp5 = 23,},
    knife_d = {knife1 = 41, knife2 = 42, flash = 43, f2 = 44, f3 = 45, f4 = 46, f5 = 47, f6 = 48, f7 = 81, f8 = 82, f9 = 83, k506 = 506, k507 = 507, k508 = 508, k509 = 509, k510 = 510, k511 = 511, k512 = 512, k513 = 513, k514 = 514, k515 = 515, k516 = 516, k517 = 517, k525 = 525,}
}

local function contains(list, data)
	for i, v in pairs(list) do
		if (v == data) then
			return true
		end
	end

	return false
end

local paint_handler = function()
    syn.set_state(ui.get(visualtable.active))
    syn.get(function(id)
        local sys_time = { client.system_time() }
        local local_player = entity.get_local_player()
        local local_weapon = entity.get_player_weapon(local_player)
        local exploit_can = client_get_can_exploit(local_player, local_weapon, 13)
        local active_weapon = entity.get_player_weapon(local_player) == nil and 1 or entity.get_player_weapon(local_player)
        local weapon = csgo_weapons[entity.get_prop(active_weapon, "m_iItemDefinitionIndex")]
        local weapon_icon = images.get_weapon_icon(weapon)
        local bullet_icons = images.get_panorama_image("icons/ui/bullet.svg")
        local headshot_icons = images.get_panorama_image("icons/ui/elimination_headshot.svg")
        local text = string.format('%s | User: %s ', ctag, nickname)
        local realtime = globals_realtime() % 3
        local alpha1 = math.floor(math.sin(realtime * 4) * (255/2-1) + 255/2) or 255
        local alpha = math.floor(math.sin(realtime * 2) * (175/2-1) + 175/2) or 175
        local weapons_id = entity.get_prop(local_weapon, "m_iItemDefinitionIndex") or 0
        local weapons_item = weapons_id and bit.band(weapons_id, 0xFFFF) or 0
        local weapons_name = weapon_names[weapons_item] or ""
        local m_alpha = 0
        local body_yaw = {0, 0}
        if is_in_game(is_in_game) == true then
            local INetChannelInfo = ffi.cast('void***', get_net_channel_info(ivengineclient)) or error('netchaninfo is nil')
            local get_avg_latency = ffi.cast('get_avg_latency_t', INetChannelInfo[0][10])
            local latency = get_avg_latency(INetChannelInfo, 0) * 1000

            text = string.format('%s (%s%%/%s) | Safety : %.0f%% ', ctag, ui.get(ref_dt_hc),ui.get(mindmg), math.abs((math.max(-60, math.min(60, math.floor((entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) or 0)*120-60+0.5))))/60*100) )
        local r, g, b, a = ui.get(visualtable.color_picker)
        local r1, g1, b1, a1 = ui.get(visualtable.color_picker1)
        local h, w = 18, renderer.measure_text(nil, text)+15
        local x, y = client.screen_size(), 10 + (25*id)

        x = x - w - 10
        
        if ui.get(visualtable.style) == "Solus ui" then
        renderer.rectangle(x, y + 2, w, h, 17, 17, 17, a)
        renderer.gradient(x, y, (w/2)+1, 2, r, g, b, 255, r1, g1, b1, alpha, true)							
        renderer.gradient(x, y, 2, h+2, r, g, b, 255, r, g, b, 255, true)
        renderer.gradient(x+w-2, y, 2, h+2, r, g, b, 255, r, g, b, 255, true)
        renderer.gradient(x, y+h, (w/2)+1, 2, r, g, b, 255, r1, g1, b1, alpha, true)
        renderer.gradient(x + w/2, y, w-w/2, 2, r1, g1, b1, alpha, r, g, b, 255, true)
        renderer.gradient(x + w/2, y+h, w-w/2, 2, r1, g1, b1, alpha, r, g, b, 255, true)
        renderer.text(x+4, y + 4, 255, 255, 255, 255, "b", 0 , text)
        elseif ui.get(visualtable.style) == "Original" then
        renderer.gradient(x, y, (w/2)+1, 2, r, g, b, 255, r1, g1, b1, alpha, true)
        renderer.gradient(x + w/2, y, w-w/2, 2, r1, g1, b1, alpha, r, g, b, 255, true)	
        renderer.rectangle(x, y + 2, w, h, 17, 17, 17, a)
        renderer.text(x+4, y + 4, 255, 255, 255, 255, 'b', 0, text)
        elseif ui.get(visualtable.style) == "New" then
        renderer.rectangle(x - 1, y, w - 11, h, 0, 0, 0, 0)
        renderer.rectangle(x + 6, y, w - 2, 21,  17, 17, 17, a)
        renderer.triangle((x - 5) + 5, y + 8, x + 6, y + 8, x + 6, y,  17, 17, 17, a)
        renderer.rectangle((x - 5) + 5, y + 8, 6, 13,  17, 17, 17, a)
        renderer.line((x - 5) + 5, y + 8, (x + 2) + 5, y, r, g, b, 255)
        renderer.rectangle((x - 5) + 5, y + 8, 1, 13, r, g, b, 255)
        renderer.rectangle(x + 6, y, w - 2, 1, r, g, b, 255)
        renderer.text(x+4, y + 4, 255, 255, 255, 255, 'b', 0, text)
        end
      
        if not entity_is_alive(entity_get_local_player()) then return end
        weapon_icon:draw(x, y + h + 6, nil, 16, 255, 255, 255, 255)
        if ui_get(ref_dt_key) and ui_get(ref_dt) then
            if doubletap_charged() then
                if contains(weapons.shots_1, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, 255)
                elseif contains(weapons.shots_2, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, 255)
                    bullet_icons:draw(x + 66, y + h + 7, nil, 16, 255, 255, 255, 255)
                elseif contains(weapons.shots_3, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, 255)
                    bullet_icons:draw(x + 66, y + h + 7, nil, 16, 255, 255, 255, 255)
                    bullet_icons:draw(x + 79, y + h + 7, nil, 16, 255, 255, 255, 255)
                elseif contains(weapons.shots_4, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, 255)
                    bullet_icons:draw(x + 66, y + h + 7, nil, 16, 255, 255, 255, 255)
                    bullet_icons:draw(x + 79, y + h + 7, nil, 16, 255, 255, 255, 255)
                    bullet_icons:draw(x + 92, y + h + 7, nil, 16, 255, 255, 255, 255)
                end
            elseif not doubletap_charged() then
                if contains(weapons.shots_1, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                elseif contains(weapons.shots_2, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                    bullet_icons:draw(x + 66, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                elseif contains(weapons.shots_3, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                    bullet_icons:draw(x + 66, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                    bullet_icons:draw(x + 79, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                elseif contains(weapons.shots_4, weapons_id) then
                    bullet_icons:draw(x + 53, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                    bullet_icons:draw(x + 66, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                    bullet_icons:draw(x + 79, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                    bullet_icons:draw(x + 92, y + h + 7, nil, 16, 255, 255, 255, alpha1)
                end
            end
        end
    end
    end)
end

client.set_event_callback('paint_ui', paint_handler)
--滑步
local legs_ref = ui.reference("AA", "OTHER", "leg movement")

slidewalk = ui.reference("AA", "other", "leg movement")


client.set_event_callback("net_update_end", function()
	if ui.get(exploitstable.enable_slide) then
		entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
	end
end)

client.set_event_callback("run_command", function(ctx)
    if ui.get(exploitstable.enable_slide) then
	p = client.random_int(1, 3)
	if p == 1 then
		ui.set(slidewalk, "Off")
	elseif p == 2 then
       ui.set(slidewalk, "Always slide")
    elseif p == 3 then
		ui.set(slidewalk, "Off")
    end
    ui.set_visible(slidewalk, false)
else
    ui.set_visible(slidewalk, true)
end
end)

brute.reset = function()
    brute.indexed_angle = 0
    brute.last_miss = 0
    brute.best_angle = 0
    brute.misses = { }
    best_target = nil
end

brute.death = function(e)
    if not ui_get(override_antiaim) then return end
    
    local victim_id = e.userid
    local victim = client_userid_to_entindex(victim_id)

    if victim ~= entity_get_local_player() then return end

    local attacker_id = e.attacker
    local attacker = client_userid_to_entindex(attacker_id)

    if not entity_is_enemy(attacker) then return end

    if not e.headshot then return end

    if brute.misses[attacker] == nil or (globals_curtime() - brute.last_miss < 0.06 and brute.misses[attacker] == 1) then
        if brute.hit_reverse[attacker] == nil then
            brute.hit_reverse[attacker] = true
        else
            brute.hit_reverse[attacker] = nil
        end
    end
end

local function legit_aa(e)
    if ui_get(aatable.legit_aa_use) and e.in_use == 1 then
        if entity_get_classname(entity_get_player_weapon(entity_get_local_player())) == "CC4" then return end

        if e.in_attack == 1 then
            e.in_use = 1
        end
    
        if e.chokedcommands == 0 then
            e.in_use = 0
        end
    end
end

--第三人称debug
local vector = require 'vector'
local entity = require 'gamesense/entity'
tp, tpkey = ui.reference("VISUALS", "Effects", "Force third person (alive)")
local Colors = {
    { 255, 0, 0 },
    { 237, 27, 3 },
    { 235, 63, 6 },
    { 229, 104, 8 },
    { 228, 126, 10 },
    { 220, 169, 16 },
    { 213, 201, 19 },
    { 176, 205, 10 },
    { 124, 195, 13 }
}

local math_num = function(int, max, declspec)
    local int = (int > max and max or int)
    local tmp = max / int;

    if not declspec then declspec = max end

    local i = (declspec / tmp)
    i = (i >= 0 and math.floor(i + 0.5) or math.ceil(i - 0.5))

    return i
end

local get_color = function(number, max)
    local i = math_num(number, max, #Colors)

    return
        Colors[i <= 1 and 1 or i][1], 
        Colors[i <= 1 and 1 or i][2],
        Colors[i <= 1 and 1 or i][3],
        i
end

local function indicator_circle(x, y, r, g, b, a, percentage, outline)
    local outline = outline or true
    local start_degrees, radius = 0, 9

    if outline then
        renderer.circle_outline(x, y, 0, 0, 0, 200, radius, start_degrees, 1.0, 5)
    end
    renderer.circle_outline(x, y, r, g, b, a, radius-1, start_degrees, percentage, 3)
end

old_chkd_cmds = 0
chkd_cmds = 0

client.set_event_callback("setup_command", function(cmd)

    if cmd.chokedcommands == 0 then
        chkd_cmds = old_chkd_cmds
    elseif cmd.chokedcommands > chkd_cmds then
        chkd_cmds = cmd.chokedcommands
    end

    old_chkd_cmds = cmd.chokedcommands

end)

local is_breaking_lc = function() -- not correct always, incorrect velocity maybe a factor

    local localplayer = entity.get_local_player()
    
    if not localplayer then return false end
    if not entity.is_alive(localplayer) then return false end

    local x = entity.get_prop(localplayer, "m_vecVelocity[0]") * globals.tickinterval() * chkd_cmds
    local y = entity.get_prop(localplayer, "m_vecVelocity[1]") * globals.tickinterval() * chkd_cmds

    -- https://github.com/perilouswithadollarsign/cstrike15_src/blob/master/game/server/player_lagcompensation.cpp#L385
    local length_2d_sqr = x * x + y * y
    if length_2d_sqr > 64 * 64 then return true end

    -- TODO: check if shifting tickbase
    return false

end



local on_paint = function()
    local local_player = entity.get_local_player()
    if not entity.is_alive(local_player) then return end

    if ui.get(visualtable.debugaa) and ui.get(tp) and ui.get(tpkey) then
        local lower_body = anti_aim.get_balance_adjust()
        local next_update = lower_body.next_update-globals.curtime()
        local gr = lower_body.updating and next_update > 0 and '\x20\x20\x20\x20\x20' or ''
        local desync = math.abs((math.max(-60, math.min(60, (entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) or 0)*120-60))))
        local health = entity.get_prop(local_player, "m_iHealth") / 100
        local fakelag = globals.chokedcommands() / ui.get(ui.reference("AA", "Fake lag", "Limit"))
        local head_pos = { entity.hitbox_position(local_player, 0) }
        local wts_head = { renderer.world_to_screen(head_pos[1], head_pos[2], head_pos[3]) }
        if wts_head[1] == nil then return end
        local screen_size = { client.screen_size() }
        local camera_angles = { client.camera_angles() }
        local by = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(1) - 120)
        local fy = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(2) - 120)
        local pos = {wts_head[1] + 75, wts_head[2] + 55}
        local rainbow_r, rainbow_g, rainbow_b = func_rgb_rainbowize((2 / 10), 1)
        local r, g, b = get_color(math.abs(anti_aim.get_desync(1)), 28)
        local is_blc  = is_breaking_lc()
        local rr, gg, bb, aa = ui.get(visualtable.color_picker2)
        if ui.get(visualtable.style1) == "Rainbow" then
        client.draw_gradient(ctx, pos[1], pos[2]-2, 130, 3, rainbow_r, rainbow_g, rainbow_b, 255, rainbow_b, rainbow_r, rainbow_g, 255, true) 
        elseif ui.get(visualtable.style1) == "Colorpicker" then
            client.draw_gradient(ctx, pos[1], pos[2]-2, 130, 3, rr, gg, bb, aa, rr, gg, bb, aa, true) 
        end
        client.draw_gradient(ctx, pos[1], pos[2], 130, 45, 35, 35, 35, 155, 35, 35, 35, 155, true)   -- top
        renderer.text(pos[1]+5, pos[2], 255, 225, 255, 255, '-', 0, string.format('A N T I  -  A I M B O T   D E B U G'))
        client.draw_gradient(ctx, pos[1]+5, pos[2]+16, 2, 8, r, g, b, 200, r, g, b, 200, true)
        renderer.text(pos[1]+12, pos[2]+13, 255, 225, 255, 255, '', 0, string.format('%sFAKE (%.1f°)', gr, desync))
        renderer.text(pos[1]+5, pos[2]+30, 255, 225, 255, 255, 'b', 0, string.format('MODE: '),brute.yaw_status)
        renderer.text(pos[1]+88, pos[2]+15, 255, 225, 255, 255, '-', 0, string.format('LC: '))
        if is_blc then
            renderer.text(pos[1]+103, pos[2]+15, 0, 225, 0, 255, '-', 0, string.format('TRUE'))
        else
            renderer.text(pos[1]+103, pos[2]+15, 255, 0, 0, 255, '-', 0, string.format('FALSE'))
        end
        if lower_body.updating and next_update > 0 then
            renderer.circle_outline(pos[1]+17, pos[2]+19, 89, 119, 239, 255, 5, 0, next_update / 1.1,2)
        end
        renderer.circle_outline(pos[1]+118, pos[2]+ 8, 15, 15, 15, 125, 5, 0, 1, 2)
        renderer.circle_outline(pos[1]+118, pos[2]+ 8, 150, 150, 150, 220, 5, by, 0.075, 2)
        renderer.circle_outline(pos[1]+118, pos[2]+ 8, 45, 220, 220, 255, 5, fy, 0.15, 2)
    end
end

client["set_event_callback"]("paint", on_paint)



local string_meta = getmetatable('')

function string_meta:__index( key )
    local val = string[ key ]
    if ( val ) then
        return val
    elseif ( tonumber( key ) ) then
        return self:sub( key, key )
    end
end

local function main()
    -- Our main function where we do our base authentication and event callbacks.
    
	
    client_set_event_callback("paint", function()
        if not ui_get(override_antiaim) then return end
        draw()
        manual_aa_paint()
        
    end)

    client_set_event_callback("run_command", function()
        if not ui_get(override_antiaim) then return end

        get_best_enemy()
        get_best_angle()
        manual_aa_sc()
        anti_aim1()
    
    end)

    client_set_event_callback("setup_command", function(e)
        if not ui_get(override_antiaim) then return end

        legit_aa(e)
    end)

    client_set_event_callback("bullet_impact", function(e)
        if not ui_get(override_antiaim) then return end

        brute.impact(e)
    end)

    client_set_event_callback("player_hurt", function(e)
        if not ui_get(override_antiaim) then return end

        brute.hurt(e)
    end)

    client_set_event_callback("player_death", function(e)
        if not ui_get(override_antiaim) then return end
        brute.reset()
        brute.death(e)
    end)

    client_set_event_callback("round_start", function()
        if not ui_get(override_antiaim) then return end
        
        dt_latency = client.latency() * 1000
        brute.reset()
    end)

    client_set_event_callback("client_disconnect", function()
        if not ui_get(override_antiaim) then return end

        brute.reset()
    end)

    client_set_event_callback("game_newmap", function()
        if not ui_get(override_antiaim) then return end

        brute.reset()
    end)

    client_set_event_callback("cs_game_disconnected", function()
        if not ui_get(override_antiaim) then return end

        brute.reset()
    end)
	

    client_set_event_callback("shutdown", function()
        database.write("dt_x", wnd.x)
        database.write("dt_y", wnd.y)
    end)
end
main()
function set_visible_on_elements()
	    ui.set_visible(ref_pitch, not ui.get(override_antiaim))
	    ui.set_visible(ref_yaw, not ui.get(override_antiaim))
	    ui.set_visible(ref_yaw_base, not ui.get(exploitstable.enable_slide))
	    ui.set_visible(ref_yawadd, not ui.get(override_antiaim))
	    ui.set_visible(ref_yawj, not ui.get(override_antiaim))
	    ui.set_visible(ref_yawjadd, not ui.get(override_antiaim))
	    ui.set_visible(ref_bodyyawadd, not ui.get(override_antiaim))
	    ui.set_visible(ref_bodyyaw, not ui.get(override_antiaim))
	    ui.set_visible(ref_fakelimit, not ui.get(override_antiaim))
        ui.set_visible(ref_lby_target, not ui.get(override_antiaim))
        ui.set_visible(ref_fs_bodyyaw, not ui.get(override_antiaim))
        ui.set_visible(ref_free, not ui.get(override_antiaim))
        ui.set_visible(ref_freekey, not ui.get(override_antiaim))
        ui.set_visible(edge_yaw, not ui.get(override_antiaim))
        ui.set_visible(modeswitch, ui.get(override_antiaim))
        ui.set_visible(sv_maxusrcmdprocessticks, true)

        ui.set_visible(aatable.adaptive_fs, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim))
        ui.set_visible(aatable.manual_aa, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim))
        ui.set_visible(aatable.manual_left, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim) and ui.get(aatable.manual_aa))
        ui.set_visible(aatable.manual_right, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim) and ui.get(aatable.manual_aa))
        ui.set_visible(aatable.manual_back, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim) and ui.get(aatable.manual_aa))
        ui.set_visible(aatable.manual_state, false)
        ui.set_visible(aatable.change_aa, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim))
        ui.set_visible(aatable.change_aa_on_key, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim) and ui.get(aatable.change_aa))
        ui.set_visible(aatable.legit_aa_use, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim))
        ui.set_visible(aatable.legit_aa_on_key, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim))
        ui.set_visible(aatable.eyeyaw_dt, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim))
        ui.set_visible(aatable.forceinair, ui.get(modeswitch) == "Anti-Aim" and ui.get(override_antiaim))

        ui.set_visible(exploitstable.enable_slide, ui.get(modeswitch) == "Exploits" and ui.get(override_antiaim))
        ui.set_visible(exploitstable.fake_up, ui.get(modeswitch) == "Exploits" and ui.get(override_antiaim))
        ui.set_visible(exploitstable.backtrack, ui.get(modeswitch) == "Exploits" and ui.get(override_antiaim))
        ui.set_visible(exploitstable.anti_knife, ui.get(modeswitch) == "Exploits" and ui.get(override_antiaim))
        ui.set_visible(exploitstable.increase_speed, ui.get(modeswitch) == "Exploits" and ui.get(override_antiaim))
        ui.set_visible(exploitstable.increase_speed_mode, ui.get(modeswitch) == "Exploits" and ui.get(override_antiaim) and ui.get(exploitstable.increase_speed))

        ui.set_visible(misctable.hide_default_inds, ui.get(modeswitch) == "Misc" and ui.get(override_antiaim))
        ui.set_visible(misctable.projecttag_enabled, ui.get(modeswitch) == "Misc" and ui.get(override_antiaim))
        ui.set_visible(misctable.camcollsion, ui.get(modeswitch) == "Misc" and ui.get(override_antiaim))
        ui.set_visible(misctable.new_slider, ui.get(modeswitch) == "Misc" and ui.get(override_antiaim) and ui.get(misctable.camcollsion))

        ui.set_visible(visualtable.active, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.color_picker, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.active))
        ui.set_visible(visualtable.color_picker1, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.active))
        ui.set_visible(visualtable.style, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.active))
        ui.set_visible(visualtable.debugaa, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.style1, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.debugaa))
        ui.set_visible(visualtable.color_picker2, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.debugaa) and ui.get(visualtable.style1) == "Colorpicker")
        ui.set_visible(visualtable.netgraph, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.manual_arrows, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.manual_aa_clr, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.manual_arrows))
        ui.set_visible(visualtable.side_arrows, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.side_arrows_clr, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.side_arrows))
        ui.set_visible(visualtable.on_peek_arrows, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.on_peek_arrows_clr, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim) and ui.get(visualtable.on_peek_arrows))
        ui.set_visible(visualtable.indicator_arrow, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.arrows_offset, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.font_type, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.indicators, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.indicator_info_clr, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.indicator_info_clr1, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
        ui.set_visible(visualtable.indicators_offset, ui.get(modeswitch) == "Visual" and ui.get(override_antiaim))
end

client.set_event_callback("paint_menu", set_visible_on_elements)
client.set_event_callback("paint", set_visible_on_elements)
