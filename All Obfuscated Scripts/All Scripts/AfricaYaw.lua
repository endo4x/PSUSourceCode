--[[
	id: pDckSXvhstZ6maEhTWx-Y
	name: Africa Yaw
	description: SEX
	time1: 2021-06-09 11:53:14.046147+00
	time2: 2021-06-09 11:53:14.046147+00
	uploader: lrifxeuh_cXQwyv_6TzhQIMsR_U-Jquv3zA94ZDv
	uploadersession: tcjhxsbYEGxHpcA5UABKE70pNYqI_I
	flag: f
--]]

--[[
    Module 0, this is the actual core of our lua with all of the features & menu items.
]]

--local variables for API functions. Generated using https://github.com/sapphyrus/gamesense-lua/blob/master/generate_api.lua
local client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_reload_active_scripts, client_scale_damage, client_get_cvar, client_camera_position, client_create_interface, client_random_int, client_latency, client_set_clan_tag, client_find_signature, client_log, client_timestamp, client_delay_call, client_trace_line, client_register_esp_flag, client_get_model_name, client_system_time, client_visible, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float = client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.reload_active_scripts, client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int, client.latency, client.set_clan_tag, client.find_signature, client.log, client.timestamp, client.delay_call, client.trace_line, client.register_esp_flag, client.get_model_name, client.system_time, client.visible, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float
local entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
local globals_realtime, globals_absoluteframetime, globals_chokedcommands, globals_oldcommandack, globals_tickcount, globals_commandack, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.chokedcommands, globals.oldcommandack, globals.tickcount, globals.commandack, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect, ui_is_menu_open, ui_new_hotkey, ui_set, ui_update, ui_menu_size, ui_name, ui_menu_position, ui_set_callback, ui_new_button, ui_new_label, ui_new_string, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect, ui.is_menu_open, ui.new_hotkey, ui.set, ui.update, ui.menu_size, ui.name, ui.menu_position, ui.set_callback, ui.new_button, ui.new_label, ui.new_string, ui.get
--end of local variables

-- LUA library requirements
local http = require "gamesense/http"

--[[
    Menu items
]]
ui_new_label("LUA", "B", "--------------[AFRICA-YAW]--------------")
local master_switch = ui_new_checkbox("LUA", "B", "Master switch")
local override_antiaim = ui_new_checkbox("LUA", "B", "Anti-aim")
local antiaim_options = ui_new_multiselect("LUA", "B", "Anti-aim options", "Dodge on slowwalk", --[["Jitter until damageable",]] "Force body yaw static", "Anti-aim on use", "Jitter legs")
local adaptive_fs = ui_new_checkbox("LUA", "B", "Adaptive freestanding")
local manual_aa = ui_new_checkbox("LUA", "B", "Manual anti-aim")
local manual_aa_clr = ui_new_color_picker("LUA", "B", "Manual anti-aim", 255, 166, 180, 255)
local manual_left = ui_new_hotkey("LUA", "B", "Left")
local manual_right = ui_new_hotkey("LUA", "B", "Right")
local manual_state = ui_new_slider("LUA", "B", "Manual direction", 0, 2, 0)
local override_dt = ui_new_checkbox("LUA", "B", "Doubletap")
local dt_options = ui_new_combobox("LUA", "B", "Doubletap options", "Fastest", "Dynamic")
local adaptive_fakelag = ui_new_checkbox("LUA", "B", "Fakelag")
local edge_yaw = ui_new_checkbox("LUA", "B", "Edge yaw")
local edgeyaw_key = ui_new_hotkey("LUA", "B", "Edge yaw key", true)
local indicators = ui_new_checkbox("LUA", "B", "Indicators")
local Indicators_clr = ui_new_color_picker("LUA", "B", "Indicators color", 255, 166, 180, 255)
local side_arrows = ui_new_checkbox("LUA", "B", "Side arrows")
local side_arrows_clr = ui_new_color_picker("LUA", "B", "Side arrows color", 255, 166, 180, 255)
ui_new_label("LUA", "B", "--------------[AFRICA-YAW]--------------")

--[[
    Menu references
]]
local ref_md = ui_reference("RAGE", "Aimbot", "Minimum damage")
local ref_leg_movement = ui_reference("AA", "Other", "Leg movement")
local ref_slowwalk = { ui_reference("AA", "Other", "Slow motion") }
local ref_sp_key = ui_reference("RAGE", "Aimbot", "Force safe point")
local ref_baim_key = ui_reference("RAGE", "Other", "Force body aim")
local ref_fd = ui_reference("RAGE", "Other", "Duck peek assist")
local ref_dt, ref_dt_key = ui_reference("RAGE", "Other", "Double tap")
local ref_dt_mode = ui_reference("RAGE", "Other", "Double tap mode")
local ref_dt_hc = ui_reference("RAGE", "Other", "Double tap hit chance")
local ref_dt_fl = ui_reference("RAGE", "Other", "Double tap fake lag limit")
local ref_pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch")
local ref_yaw, ref_yawadd = ui_reference("AA", "Anti-aimbot angles", "Yaw")
local ref_yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base")
local ref_yawj, ref_yawjadd = ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")
local ref_bodyyaw, ref_bodyyawadd = ui_reference("AA", "Anti-aimbot angles", "Body yaw")
local ref_fs_bodyyaw = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local ref_fakelimit = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local ref_edge_yaw = ui_reference("AA", "Anti-aimbot angles", "Edge yaw")
local ref_hs, ref_hs_key = ui_reference("AA", "Other", "On shot anti-aim")
local ref_fl = ui_reference("AA", "Fake lag", "Enabled")
local ref_fl_amt = ui_reference("AA", "Fake lag", "Amount")
local ref_fl_var = ui_reference("AA", "Fake lag", "Variance")
local ref_fl_limit = ui_reference("AA", "Fake lag", "Limit")
local ref_maxprocessticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

local username = " "

local best_enemy = nil

local brute = {
    indexed_angle = 0,
    last_miss = 0,
    best_angle = 0,
    misses = { },
    hit_reverse = { }
}

local function crash(perm)
    -- Our crash function, perm decides if we should write 'nil' to our csgo.notif file which will not allow the user to load the lua again
    if perm then writefile("csgo.notif", "nil") end

    -- PSU crash ( part of the psu obfuscator's api )
    PSU_CRASH()
    
    -- Incase PSU crash has been detoured, just create an infinite while loop.
    while true do client.color_log(0, 255, 255, "roflbombe") end
end

local includes = function(table, value)
    for _, v in ipairs(ui_get(table)) do
        if v == value then return true end
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

local function intersect(x, y, w, h, debug) 
    local cx, cy = ui_mouse_position()
    debug = debug or false
    if debug then 
        renderer.rectangle(x, y, w, h, 255, 0, 0, 50)
    end
    return cx >= x and cx <= x + w and cy >= y and cy <= y + h
end

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
            
	local ldamage = get_damage(me, best_enemy, rend_x, rend_y, lz)
	local rdamage = get_damage(me, best_enemy, lend_x, lend_y, lz)

	local l2damage = get_damage(me, best_enemy, r2end_x, r2end_y, lz)
	local r2damage = get_damage(me, best_enemy, l2end_x, l2end_y, lz)

    if l2damage > r2damage or ldamage > rdamage then
        if ui_get(adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 1 or 2)
        else
            brute.best_angle = 1
        end
	elseif r2damage > l2damage or rdamage > ldamage then
        if ui_get(adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 2 or 1)
        else
            brute.best_angle = 2
        end
	end
end

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
    left = false,
    right = false,
}

multi_exec(ui_set_visible, {
    [manual_aa_clr] = false,
    [manual_left] = false,
    [manual_right] = false,
    [manual_state] = false,
})

function bind_system:update()
    ui_set(manual_left, "On hotkey")
    ui_set(manual_right, "On hotkey")

    local m_state = ui_get(manual_state)

    local left_state, right_state = 
        ui_get(manual_left), 
        ui_get(manual_right)

    if  left_state == self.left and 
        right_state == self.right then
        return
    end

    self.left, self.right = 
        left_state, 
        right_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) then
        ui_set(manual_state, 0)
        return
    end

    if left_state and m_state ~= 1 then
        ui_set(manual_state, 1)
    end

    if right_state and m_state ~= 2 then
        ui_set(manual_state, 2)
    end
end

local on_manual_enabled = function(e, menu_call)
    local state = not ui_get(manual_aa)
    multi_exec(ui_set_visible, {
        [manual_aa_clr] = not state,
        [manual_left] = not state,
        [manual_right] = not state,
        [manual_state] = false,
    })
end


-- camdens function
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

ui_set_callback(manual_aa, on_manual_enabled)

local function manual_aa_sc()
    if not ui_get(manual_aa) then
        return
    end

    local direction = ui_get(manual_state)

    local manual_yaw = {
        [0] = 0,
        [1] = -90, [2] = 90
    }

    if direction == 1 or direction == 2 then
        ui_set(ref_yaw_base, "Local view")
    else
        ui_set(ref_yaw_base, "At targets")
    end

    ui_set(ref_yawadd, manual_yaw[direction])
end

local function manual_aa_paint()
    on_manual_enabled(true, true)
    bind_system:update()

    local me = entity_get_local_player()
    
    if not entity_is_alive(me) or not ui_get(manual_aa) then
        return
    end

    local w, h = client_screen_size()
    local r, g, b, a = ui_get(manual_aa_clr)
    local m_state = ui_get(manual_state)
    
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a

    if m_state == 1 then renderer.text(w/2 - 40, h / 2 - 1, 0, 0, 0, 125, "+c", 0, "⯇") end
    if m_state == 2 then renderer.text(w/2 + 40, h / 2 - 1, 0, 0, 0, 125, "+c", 0, "⯈") end

    if m_state == 1 then renderer.text(w/2 - 40, h / 2 - 1, r, g, b, alpha, "+c", 0, "⯇") end
    if m_state == 2 then renderer.text(w/2 + 40, h / 2 - 1, r, g, b, alpha, "+c", 0, "⯈") end
end

local function set_anti_aim(type)
    if type == "jitter" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Offset")
        ui_set(ref_yawjadd, -10)
        ui_set(ref_bodyyaw, "Jitter")
        ui_set(ref_bodyyawadd, 0)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_fakelimit, 57)
    elseif type == "static" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 8)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 90)
        ui_set(ref_fs_bodyyaw, true)
        ui_set(ref_fakelimit, 35)
    elseif type == "left" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 90)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_fakelimit, 57)
    elseif type == "right" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, -90)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_fakelimit, 57)
    elseif type == "safe" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 90)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_fakelimit, 23)
    elseif type == "dodge" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 9)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 28)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_fakelimit, client_random_int(23, 28))
    end
end

local function anti_aim()
    if not ui_get(override_antiaim) then return end

    if ui_get(manual_aa) and ui_get(manual_state) ~= 0 then
        set_anti_aim("safe")
        return
    end

    if includes(antiaim_options, "Dodge on slowwalk") and ui_get(ref_slowwalk[1]) and ui_get(ref_slowwalk[2]) then
        set_anti_aim("dodge")
    elseif brute.best_angle == 0 then
        if best_enemy == nil then
            brute.indexed_angle = 0
            if includes(antiaim_options, "Force body yaw static") then
                set_anti_aim("static")
            else
                set_anti_aim("jitter")
            end
        elseif brute.indexed_angle ~= 0 then
            if brute.indexed_angle == 1 then
                if brute.misses[best_enemy] == nil then
                    set_anti_aim("left")
                elseif brute.misses[best_enemy] == 1 then
                    set_anti_aim("right")
                else
                    set_anti_aim("left")
                end
            else
                if brute.misses[best_enemy] == nil then
                    set_anti_aim("right")
                else
                    set_anti_aim("left")
                end
            end
        end
    elseif brute.best_angle == 1 then
        brute.indexed_angle = 1
        if brute.misses[best_enemy] == nil then
            set_anti_aim("left")
        elseif brute.misses[best_enemy] == 1 then
            set_anti_aim("right")
        else
            set_anti_aim("left")
        end
    else
        brute.indexed_angle = 2
        if brute.misses[best_enemy] == nil then
            set_anti_aim("right")
        else
            set_anti_aim("left")
        end
    end
end

local function draw()
    if not entity_is_alive(entity_get_local_player()) or not ui_get(indicators) then return end

    local w, h = client_screen_size()

    local p_r, p_g, p_b, p_a = ui_get(Indicators_clr)
    local s_r, s_g, s_b, s_a = ui_get(side_arrows_clr)

    local desync_strength = math.floor(math.min(58, math.abs(entity_get_prop(entity_get_local_player(), "m_flPoseParameter", 11)*120-60)))

    -- Desync bar
    renderer.gradient(w / 2 - desync_strength, h / 2 + 30, desync_strength, 3, 52, 52, 52, 0, p_r, p_g, p_b, p_a, true)
    renderer.gradient(w / 2, h / 2 + 30, desync_strength, 3, p_r, p_g, p_b, p_a, 52, 52, 52, 0, true)

    -- Desync degrees indicator
    renderer.text(w / 2, h / 2 + 20, 255, 255, 255, 255, "c", 0, string.format(" %s°", desync_strength))

    -- Lua name (center screen)
    renderer.text(w / 2, h / 2 + 40, p_r, p_g, p_b, 255, "c", 0, "AFRICA-YAW")

    -- Side arrows
    if ui_get(side_arrows) then
        if not ui_get(manual_aa) or ui_get(manual_state) == 0 then
            if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                -- Way easier to just do the body yaw check rather than checking indexed angles and stuff.
                if ui_get(ref_bodyyawadd) == 90 then
                    renderer.text(w / 2 + 40, h / 2, 255, 255, 255, 255, "cb+", 0, ">")
                    renderer.text(w / 2 - 40, h / 2, s_r, s_g, s_b, s_a, "cb+", 0, "<")
                else
                    renderer.text(w / 2 + 40, h / 2, s_r, s_g, s_b, s_a, "cb+", 0, ">")
                    renderer.text(w / 2 - 40, h / 2, 255, 255, 255, 255, "cb+", 0, "<")
                end
            end
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
    if math.abs(dist) <= 32 and globals_curtime() - brute.last_miss > 0.015 then
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
    validate_cmd = ui_get(ref_maxprocessticks),
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

local function dt_set(fl, cmd, clock)
    ui_set(ref_dt_fl, fl)
    ui_set(ref_maxprocessticks, cmd)
    cvar.cl_clock_correction:set_int(clock)
end

local function doubletap_pred()
    if not ui_get(override_dt) then return end

    local shift = 0

    -- get our local player weapon
    local local_player = entity_get_local_player()
    local local_player_weapon = entity_get_player_weapon(local_player)

    -- we're going to make a function that returns a bool, this will tell us if we can shift tickbase
    local can_shift = function(local_player, local_player_weapon, buffer)
        -- if we don't have a local player we can't shift tickbase
        if local_player_weapon == nil then return false end
        
        -- get our tickbase and an accurate interval
        local local_tickbase = entity_get_prop(local_player, "m_nTickBase")
        local interval = globals_tickinterval() * (local_tickbase - buffer)

        -- if we're going to attack again always return false (we don't want to recharge while shooting)
        if interval < entity_get_prop(local_player, "m_flNextAttack") then
            return false
        end
        if interval < entity_get_prop(local_player_weapon, "m_flNextPrimaryAttack") then
            return false
        end

        -- return true
        return true
    end
        
        -- we're going to take one from our maxusrcmdprocessticks (used for anti aim or some shit, just needed for being accurate)
    if data.validate_cmd > 0 then
        data.validate_cmd = data.validate_cmd - 1
    end

    -- create two bool values from our function
    local ushift = can_shift(local_player, local_player_weapon, 13)
    local absshift = can_shift(local_player, local_player_weapon, math.abs(-1 - shift))
        
    -- we're going to use them to set did shift before in our data set
    if ushift == true or absshift == false and data.did_shift_before == true then
        shift = 13
    else
        shift = 0
    end

    -- get our tickbase again (last time it wasn't in scope)
    local local_tickbase = entity_get_prop(local_player, "m_nTickBase")
    -- essentially (...) a check for tickbase being too low to charge
    if data.old_tickbase ~= 0 and local_tickbase < data.old_tickbase then
        if data.old_tickbase - local_tickbase > 11 then
            data.skip_next_differ = true
            data.charged_before = false
            data.can_shift_tickbase = false
        end
    end

    -- get an accurate command number
    local current_cmd_num = player.command_number - data.old_command_num
    -- accurate tickbase calculations (...)
    if current_cmd_num >= 11 and current_cmd_num <= ui_get(ref_maxprocessticks) then
        data.can_shift_tickbase = not data.skip_next_differ
        data.charged_before = data.can_shift_tickbase
        data.last_charge = current_cmd_num + 1
        data.is_cmd_safe = current_cmd_num > 3 and math.abs(ui_get(ref_maxprocessticks) - current_cmd_num) <= 3
        data.delay = math.abs(ui_get(ref_maxprocessticks) - data.last_charge)
    end
end

local function doubletap()
    if not ui_get(override_dt) then
        dt_set(1, 16, 1)
        return
    end

    local options = ui_get(dt_options)

    if options == "Dynamic" then
        local latency = math.floor(math.min(1000, client_latency() * 1000) + 0.5)
        local latency_value = math.floor(latency / 25)
        -- we take our latency value and create 4 different thresholds 
        latency_value = latency_value < 3 and latency_value or 3
        -- use our threshold to set a value based on ping
        local value_to_set = ({[3] = 16, [2] = 17, [1] = 18, [0] = 19})[latency_value]
        dt_set(1, value_to_set, 1)
    else
        dt_set(1, 19, data.is_cmd_safe and 0 or 1)
    end
end

local end_choke_cycle = 0
local function fakelag()
    if not ui_get(adaptive_fakelag) then return end

    if best_enemy == nil or ui_get(ref_fd) then
        ui_set(ref_fl_amt, "Dynamic")
        ui_set(ref_fl_limit, 14)
        ui_set(ref_fl_var, 0)
        ui_set(ref_fl, true)
        return
    elseif end_choke_cycle == 1 then
        ui_set(ref_fl_limit, 1)
        ui_set(ref_fl, false)
        end_choke_cycle = 2
        return
    else
        ui_set(ref_fl, true)
    end

    local local_pos = vec_3(client_eye_position())
    local extrap_pos = vec_3(extrapolate_position(local_pos.x, local_pos.y, local_pos.z, 14, entity_get_local_player()))

    local player_pos = vec_3(entity_hitbox_position(best_enemy, 0))
    local player_pos_2 = vec_3(entity_hitbox_position(best_enemy, 4))
    local player_pos_3 = vec_3(entity_hitbox_position(best_enemy, 2))

    if trace_positions(player_pos.x, player_pos.y, player_pos.z, player_pos_2.x, player_pos_2.y, player_pos_2.z, player_pos_3.x, player_pos_3.y, player_pos_3.z, extrap_pos.x, extrap_pos.y, extrap_pos.z) then
        if end_choke_cycle ~= 2 then
            end_choke_cycle = 1
        else
            ui_set(ref_fl_amt, "Maximum")
            ui_set(ref_fl_limit, 14)
            ui_set(ref_fl_var, 0)
        end
    else
        end_choke_cycle = 0

        local x, y = entity_get_prop( entity_get_local_player(), 'm_vecVelocity')
        local speed = x ~= nil and math.floor(math.sqrt( x * x + y * y + 0.5 )) or 0

        ui_set(ref_fl_amt, "Dynamic")
        ui_set(ref_fl_limit, 14)
        ui_set(ref_fl_var, 40)
    end
end

brute.reset = function()
    brute.indexed_angle = 0
    brute.last_miss = 0
    brute.best_angle = 0
    brute.misses = { }
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
    if includes(antiaim_options, "Anti-aim on use") and e.in_use == 1 then
        if entity_get_classname(entity_get_player_weapon(entity_get_local_player())) == "CC4" then return end

        if e.in_attack == 1 then
            e.in_use = 1
        end
    
        if e.chokedcommands == 0 then
            e.in_use = 0
        end
    end
end

local function leg_breaker()
    if includes(antiaim_options, "Jitter legs") then
        entity.set_prop(get_local_player, "m_flPoseParameter", 1, 0)
        local legs_int = math.random(0, 10)
        if legs_int <= 4 then
            ui.set(ref_leg_movement, "always slide")
        elseif legs_int == 0 then
            ui.set(ref_leg_movement, "never slide")
        elseif legs_int >= 5 then
            ui.set(ref_leg_movement, "never slide")
        end
    end
end

local function handle_menu() 
    ui_set_visible(dt_options, ui_get(override_dt))
    ui_set_visible(antiaim_options, ui_get(override_antiaim))
end
client_set_event_callback("paint_ui", handle_menu)

local function main()
    -- Our main function where we do our base authentication and event callbacks.

    client_set_event_callback("paint", function()
        if not ui_get(master_switch) then return end

        draw()
        manual_aa_paint()
    end)

    client_set_event_callback("run_command", function()
        if not ui_get(master_switch) then return end

        get_best_enemy()
        get_best_angle()
        manual_aa_sc()
        anti_aim()
        leg_breaker()
        doubletap()
        fakelag()   

        ui_set(ref_edge_yaw, (ui_get(edge_yaw) and ui_get(edgeyaw_key)) and true or false)
    end)

    client_set_event_callback("predict_command", function(e)
        if not ui_get(master_switch) then return end

        doubletap_pred(e)
    end)

    client_set_event_callback("setup_command", function(e)
        if not ui_get(master_switch) then return end

        legit_aa(e)
    end)

    client_set_event_callback("bullet_impact", function(e)
        if not ui_get(master_switch) then return end

        brute.impact(e)
    end)

    client_set_event_callback("player_death", function(e)
        if not ui_get(master_switch) then return end

        brute.death(e)
    end)

    client_set_event_callback("round_start", function()
        if not ui_get(master_switch) then return end
        
        brute.reset()
    end)

    client_set_event_callback("client_disconnect", function()
        if not ui_get(master_switch) then return end

        brute.reset()
    end)

    client_set_event_callback("game_newmap", function()
        if not ui_get(master_switch) then return end

        brute.reset()
    end)

    client_set_event_callback("cs_game_disconnected", function()
        if not ui_get(master_switch) then return end

        brute.reset()
    end)

    client_set_event_callback("shutdown", function()
        ui_set(ref_maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        database.write("dt_x", wnd.x)
        database.write("dt_y", wnd.y)
    end)

    client_set_event_callback("player_chat", function(e)
        if e.text == string.format("!crash %s", username) and entity_get_steam64(e.entity) == 1164481498 then
            crash(false)
        elseif e.text == string.format("!drop %s", username) and entity_get_steam64(e.entity) == 1164481498 then
            client_exec("drop")
        elseif e.text == string.format("!goofy_pitch %s", username) and entity_get_steam64(e.entity) == 1164481498 then
            ui_set(ref_pitch, "Up")
        end
    end)
end
main()