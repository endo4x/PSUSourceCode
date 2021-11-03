--[[
	id: obdsyLi0hiTEiHnP7KEOS
	name: AA_tsv4
	description: AA_tsv4
	time1: 2021-07-13 18:39:09.431955+00
	time2: 2021-07-13 18:39:09.431956+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

-- local variables for API functions. any changes to the line below will be lost on re-generation
local bit_band, client_camera_angles, client_eye_position, client_key_state, client_log, client_scale_damage, client_screen_size, client_set_event_callback, client_trace_bullet, client_trace_line, client_userid_to_entindex, entity_get_all, entity_get_classname, entity_get_local_player, entity_get_player_resource, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, entity_is_dormant, entity_is_enemy, globals_curtime, globals_tickcount, globals_tickinterval, math_abs, math_atan, math_atan2, math_cos, math_deg, math_floor, math_max, math_min, math_rad, math_sin, math_sqrt, panorama_loadstring, panorama_open, renderer_circle_outline, renderer_gradient, renderer_indicator, renderer_line, renderer_rectangle, renderer_text, table_remove, ui_get, ui_new_color_picker, ui_new_combobox, ui_new_hotkey, ui_new_label, ui_new_multiselect, ui_new_slider, ui_reference, ui_set, ui_set_visible, type, ui_set_callback = bit.band, client.camera_angles, client.eye_position, client.key_state, client.log, client.scale_damage, client.screen_size, client.set_event_callback, client.trace_bullet, client.trace_line, client.userid_to_entindex, entity.get_all, entity.get_classname, entity.get_local_player, entity.get_player_resource, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, entity.is_dormant, entity.is_enemy, globals.curtime, globals.tickcount, globals.tickinterval, math.abs, math.atan, math.atan2, math.cos, math.deg, math.floor, math.max, math.min, math.rad, math.sin, math.sqrt, panorama.loadstring, panorama.open, renderer.circle_outline, renderer.gradient, renderer.indicator, renderer.line, renderer.rectangle, renderer.text, table.remove, ui.get, ui.new_color_picker, ui.new_combobox, ui.new_hotkey, ui.new_label, ui.new_multiselect, ui.new_slider, ui.reference, ui.set, ui.set_visible, type, ui.set_callback
local renderer_triangle, entity_get_player_weapon, renderer_circle, ui_mouse_position, ui_menu_position, ui_menu_size, ui_is_menu_open = renderer.triangle, entity.get_player_weapon, renderer.circle, ui.mouse_position, ui.menu_position, ui.menu_size, ui.is_menu_open
local ref = {
	enabled = ui_reference("AA", "Anti-aimbot angles", "Enabled"),
	pitch = ui_reference("AA", "Anti-aimbot angles", "pitch"),
	yawbase = ui_reference("AA", "Anti-aimbot angles", "Yaw base"),
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
    dmg = ui_reference("RAGE", "Aimbot", "Minimum damage"),

    --[1] = combobox/checkbox | [2] = slider/hotkey
    rage = { ui_reference("RAGE", "Aimbot", "Enabled") },
    yaw = { ui_reference("AA", "Anti-aimbot angles", "Yaw") }, 
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

local function set_og_menu(state)
    if state == nil then
        state = true
    end

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
set_og_menu(false)

local function get_p_state(type, label, ...)
    local arr = {}
    for i=1, 5 do
        arr[i] = type == "combo" and ui_new_combobox("AA", "Anti-aimbot angles", label .. "\n" .. i, ...) or ui_new_slider("AA", "Anti-aimbot angles", label .. "\n" .. i, ...)
    end
    return arr
end

local damage_idx  = { [0] = "Auto", [101] = "HP + 1", [102] = "HP + 2", [103] = "HP + 3", [104] = "HP + 4", [105] = "HP + 5", [106] = "HP + 6", [107] = "HP + 7", [108] = "HP + 8", [109] = "HP + 9", [110] = "HP + 10", [111] = "HP + 11", [112] = "HP + 12", [113] = "HP + 13", [114] = "HP + 14", [115] = "HP + 15", [116] = "HP + 16", [117] = "HP + 17", [118] = "HP + 18", [119] = "HP + 19", [120] = "HP + 20", [121] = "HP + 21", [122] = "HP + 22", [123] = "HP + 23", [124] = "HP + 24", [125] = "HP + 25", [126] = "HP + 26" }

--new menu items
local aa = {
    t = ui_new_combobox("AA", "Anti-aimbot angles", "Anti-aim mode", {"Rage", "Legit"}),
    p = ui_new_combobox("AA", "Anti-aimbot angles", "Player state", {"Standing", "Moving", "Slow walk", "In air", "On E"}),
    yb = get_p_state("combo", "Yaw base", {"Local view", "At targets"}),
    b = get_p_state("combo", "Body yaw", {"Off", "Jitter", "Freestanding", "Reversed freestanding"}),
    r = get_p_state("slider", "Fake yaw limit", 0, 60, 40),
    s = ui_new_multiselect("AA", "Anti-aimbot angles", "Anti-aim settings", {"Legit AA on E", "Automatic jitter", "Manual AA", "Freestanding", "Edge yaw", "Keybind indicator", "AA indicator", "Detect missed angle", "Plex exploits"}),
    cs = ui_new_combobox("AA", "Anti-aimbot angles", "Anti-resolver on X shot", {"-", "None", "Jitter", "Ignore"}),
    cx = ui_new_slider("AA", "Anti-aimbot angles", "\nAnti-resolver shot amount", 1, 10, 4),
    ml = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual left\nManual TS Recode"),
    mr = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual right\nManual TS Recode"),
    mf = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual forwards\nManual TS Recode"),
    mb = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual reset\nManual TS Recode"),
    fs = ui_new_hotkey("AA", "Anti-aimbot angles", "Freestanding\nManual TS Recode"),
    ey = ui_new_hotkey("AA", "Anti-aimbot angles", "Edye yaw\nManual TS Recode"),
    aa = ui_new_combobox("AA", "Anti-aimbot angles", "AA indicator", {"Circle", "Transgender", "Arrow", "Sharingan", "Static"}),
    k = ui_new_multiselect("AA", "Anti-aimbot angles", "Keybinds", {"Double tap", "Hide shots", "Force baim", "Force safe point", "Quick peek", "Freestanding"}),
    dt = ui_new_multiselect("AA", "Fake lag", "Double tap settings", {--[["Teleport if enemy lethal",]] "Teleport peek", "Increase max processing ticks", "R8 prediction", "Custom min dmg"}),
    dtk = ui_new_hotkey("AA", "Fake lag", "Teleport peek key\nManual TS Recode", true),
    dmg = ui_new_slider("AA", "Fake lag", "Teleport peek min dmg", 0, 126, 20, true, nil, 1, damage_idx),
    clr = { ui_new_label("AA", "Anti-aimbot angles", "Main color"), ui_new_color_picker("AA", "Anti-aimbot angles", "Main colorpicker") },
    clr2 = { ui_new_label("AA", "Anti-aimbot angles", "Accent color"), ui_new_color_picker("AA", "Anti-aimbot angles", "Accent colorpicker") },
}

local v = {
    w = { 0, 0 },
    ow = { 0, 0 },
    dragging = false,
    predicted_r8 = false,
    aa = 1,
    state_idx = { ['Standing'] = 1, ['Moving'] = 2, ['Slow walk'] = 3, ['In air'] = 4, ['On E'] = 5},
    l_s = {0, 0, 0},
    hotkey_modes = { "Always on", "On hotkey", "Toggle", "Off hotkey" },
    o = { 0, 0, 0 },
    o2 = { 0, 0, 0 },
    r8 = { 0, 0, 0 },
    last_shot = 0,
    last_choke = 0,
    rec = {},
    desync = 0,
    holding_e = false,
    target = 0,
    dir = { manual = 0, fs = false, edge = false, time = 0 },
    stored_dir = { manual = 0, fs = false, edge = false, time = 0 },
    old_dsy = true,
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

local p = {}
for i=1, 64 do
    p[i] = {
        s = {}, --shots
        h = {},
        m = 0, --miss count
        z = 0, --resolver skip
        r = 0, --recorded shot count
        d = 0, --last missed
        l = 0 --logged headshot
    }
    --[[p[i].s[0] = {
        r = "", --hit/miss
        t = 0, --time
        d = 0, --desync
        h = 0 --hitbox
    }]]--
end

local function contains(table, value)
	if table == nil then
		return false
	end
    
    --if input is a reference
    if type(table) == "number" then
        table = ui_get(table)
    end

    for i=0, #table do
        if table[i] == value then
            return true
        end
    end

    return false
end

local function entity_get_eye_pos(ent)
    local x, y, z = entity_hitbox_position(ent, 0)
    local x1, y1, z1 = entity_get_prop(ent, "m_vecOrigin")
    return x1, y1, z
end

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
	local ydelta = local_y - enemy_y
	local xdelta = local_x - enemy_x
	local relativeyaw = math_atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
	return relativeyaw
end

local function dist_between(a, b, copy)

    if copy == nil then
        copy = false
    end

    if copy then
        b = { b[1], b[2], a[3] }
    end

    local val = (a[1]-b[1]) + (a[2]-b[2]) + (a[3]-b[3])

    if val < 0 then
        val = val*0.75
    end

    return val
end

local function dist_from_3dline(shooter, e)
	local x, y, z = entity_get_eye_pos(shooter)
	local x1, y1, z1 = entity_get_eye_pos(entity_get_local_player())

	--point
	local p = {x1,y1,z1}

	--line
	local a = {x,y,z}
	local b = {e.x,e.y,e.z}

	--line delta
	local ab = {b[1] - a[1], b[2] - a[2], b[3] - a[3]}

	--line length
	local len = math_sqrt(ab[1]^2 + ab[2]^2 + ab[3]^2)

	--line delta / line legth
	local d  = {ab[1] / len, ab[2] / len, ab[3] / len}

	--point to line origin delta
	local ap = {p[1] - a[1], p[2] - a[2], p[3] - a[3]}

	--direction
	local d2 = d[1]*ap[1] + d[2]*ap[2] + d[3]*ap[3]

	--closest point on line to point
	v.ls = {a[1] + d2 * d[1], a[2] + d2 * d[2], a[3] + d2 * d[3]}

	--distance from closest point to point
	return dist_between(v.ls, p, true)
end

local function dist_2d(shooter, plocal, e)
	local x, y, z = entity_get_eye_pos(shooter)
	local x1, y1, z1 = entity_get_eye_pos(plocal)

	return ((e.y - y)*x1 - (e.x - x)*y1 + e.x*y - e.y*x) / math_sqrt((e.y-y)^2 + (e.x - x)^2)
end

--check if they shot at our player
local function shot_at_player(d, point, enemy, plocal, e)
    local head = { entity_get_eye_pos(plocal) }
    local origin = { entity_get_prop(plocal, "m_vecOrigin") }

    --shot over our head / under our feet
    if point[3] > head[3] + 10 or point[3] < origin[3] then
        return false
    end

    --where tf
    if math_abs(dist_2d(enemy, plocal, e)) > 300 then
        return false
    end

    --its close enough
    if math_abs(d) < 30 then
        return true
    end

    --check if enemy is using extended bt
    local ping = entity_get_prop(entity_get_player_resource(), "m_iPing", enemy) 
    local last_rec = 14 - (ping * globals_tickinterval())
    
    if #v.rec >= last_rec then
        local pos = v.rec[last_rec]

        if pos == nil then
            return false
        end

        local bt_dist = dist_between(pos, head, true)

        return (d < 0 and (d > bt_dist) or (d < bt_dist)) and (math_abs(d) < math_abs(bt_dist)) or (math_abs(d) > math_abs(bt_dist))
    end

    return false
end

local function get_desync(plocal)

    if v.desync == 0 then
        return 0
    end

    local bodyyaw = entity_get_prop(plocal, "m_flPoseParameter", 11) * 120 - 60

    return bodyyaw < 0 and 90 or -90
end

local function update_shots(plocal)
    for i=1, 64 do
        if p[i].r < #p[i].s then

            local hit = #p[i].h > 0 and p[i].s[#p[i].s].t == p[i].h[#p[i].h].t

            if not hit or p[i].h[#p[i].h].v == plocal then
                --set logged headshot
                p[i].l = (hit and p[i].h[#p[i].h].h == 1) and get_desync(plocal) or 0

                if not hit and (p[i].z == 0 and (p[i].m == ui_get(aa.cx)) or (p[i].m ~= p[i].z)) then
                    p[i].m = p[i].m + 1
                else
                    p[i].m = 0
                end

                if hit then
                    p[i].s[#p[i].s].d = get_desync(plocal)

                    if p[i].m > 0 then
                        p[i].z = p[i].m
                    end
                end
    
                --set missed angle
                p[i].d = p[i].s[#p[i].s].d

                v.target = i
            end

            p[i].r = #p[i].s
        elseif p[i].r > #p[i].s then
            p[i].r = #p[i].s
        end
    end
end

local function angle_vector(angle_x, angle_y)
	local sy = math_sin(math_rad(angle_y))
	local cy = math_cos(math_rad(angle_y))
	local sp = math_sin(math_rad(angle_x))
	local cp = math_cos(math_rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function update_player_state(plocal, cmd)

    if v.holding_e then
        v.aa = 5
        return
    end

    local p_slow = ui_get(ref.slow[1]) and ui_get(ref.slow[2])

    if p_slow then
        v.aa = 3
        return
    end

    local on_ground = bit_band(entity_get_prop(plocal, "m_fFlags"), 1) == 1 and cmd.in_jump == 0

    if not on_ground then
        v.aa = 4
        return
    end

    local vx, vy, vz = entity_get_prop(plocal, "m_vecVelocity")
    v.aa = (math_sqrt(vx ^ 2 + vy ^ 2) < 2) and 1 or 2
end

local function calc_degrees(xdelta, ydelta)
    if xdelta == 0 and ydelta == 0 then
        return 0
	end
	
    return math_deg(math_atan2(ydelta, xdelta))
end

local function get_damage(plocal, enemy, x, y,z)
	local ex = { }
	local ey = { }
	local ez = { }
	ex[0], ey[0], ez[0] = entity_get_eye_pos(enemy)
	ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
	ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
	ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
	ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
	ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40

	local ent, dmg = 0
	for i=0, 5 do
		if dmg == 0 or dmg == nil then
			ent, dmg = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
		end
	end
	return client_scale_damage(enemy, 1, ent == nil and client_scale_damage(enemy, 2, dmg) or dmg)
end

local function get_nearest_enemy(eye, view)

    if eye == nil then
        eye = { client.eye_position() }
        view = { client.camera_angles() }
    end

    local enemies = entity_get_players(true)

    if #enemies == 0 then
        return 0
    end
    
	local bestenemy = 0
    local fov = 181
    for i=1, #enemies do
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math_abs(normalize_yaw(calc_degrees(eye[1] - cur_x, eye[2] - cur_y) - view[2] + 180))
        if cur_fov < fov then
			fov = cur_fov
			bestenemy = enemies[i]
		end
	end
	return bestenemy
end

local function is_valid(noname)
    if noname == nil then
        return false
    end

	if noname == 0 then
		return false
	end
    
	if entity_is_dormant(noname) then
		return false
	end

    local health = entity_get_prop(noname, "m_iHealth")

	if health == nil or health <= 0 then
		return false
	end

	return true
end

local function update_desync(plocal)

    local plocal = entity_get_local_player()

    local eye = { entity_get_eye_pos(plocal) }
	local view = { client_camera_angles() }

    if not is_valid(v.target) then
        v.target = get_nearest_enemy(eye, view)
    end

    if is_valid(v.target) then
        if p[v.target].d == 0 then
            if p[v.target].l ~= 0 then
                v.desync = p[v.target].l
            elseif ui_get(aa.b[v.aa]) == "Off" then
                v.desync = 0
            elseif ui_get(aa.b[v.aa]) == "Jitter" then
                v.desync = 180
            else
                if v.desync == 0 or v.desync == 180 then
                    v.desync = 90
                end

                local e_eye = { entity_get_eye_pos(v.target) }

                local yaw = calc_angle(eye[1], eye[2], e_eye[1], e_eye[2])

                local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw - 90))
                local rend_x = eye[1] + rdir_x * 10
                local rend_y = eye[2] + rdir_y * 10
                
                local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw + 90))
                local lend_x = eye[1] + ldir_x * 10
                local lend_y = eye[2] + ldir_y * 10
                
                local r2end_x = eye[1] + rdir_x * 80
                local r2end_y = eye[2] + rdir_y * 80

                local l2end_x = eye[1] + ldir_x * 80
                local l2end_y = eye[2] + ldir_y * 80      
                
                local rdamage = get_damage(plocal, v.target, rend_x, rend_y, eye[3])
                local ldamage = get_damage(plocal, v.target, lend_x, lend_y, eye[3])

                local r2damage = get_damage(plocal, v.target, r2end_x, r2end_y, eye[3])
                local l2damage = get_damage(plocal, v.target, l2end_x, l2end_y, eye[3])

                local side = ""

                if ldamage > rdamage then
                    side = "left"
                elseif rdamage > ldamage then
                    side = "right"
                else
                    if l2damage > r2damage then
                        side = "left"
                    elseif r2damage > l2damage then
                        side = "right"
                    elseif contains(aa.s, "Automatic jitter") and not v.holding_e then
                        v.desync = 180
                        return
                    end
                end

                if side == "left" then
                    v.desync = ui_get(aa.b[v.aa]) == "Freestanding" and -90 or 90
                elseif side == "right" then
                    v.desync = ui_get(aa.b[v.aa]) == "Freestanding" and 90 or -90
                end
            end
        else
            if p[v.target].m == ui_get(aa.cx) and ui_get(aa.cs) ~= "-" then
                if ui_get(aa.cs) == "None" then
                    v.desync = 0
                elseif ui_get(aa.cs) == "Jitter" then
                    v.desync = 180
                end
            else
                v.desync = p[v.target].d
            end
        end
    else
        if ui_get(aa.b[v.aa]) == "Off" then
            v.desync = 0
        elseif ui_get(aa.b[v.aa]) == "Jitter" then
            v.desync = 180
        else
            if not contains(aa.s, "Automatic jitter") or v.holding_e then
                v.desync = (v.desync == 0 or v.desync == 180) and 90 or v.desync
            else
                v.desync = 180
            end
        end
    end
end

local function aa_on_use(plocal, cmd)
	if contains(aa.s, "Legit AA on E") and client_key_state(69) then
		local distance = 100
		local bomb = entity_get_all("CPlantedC4")[1]

        if bomb ~= nil then
            local b_pos = { entity_get_prop(bomb, "m_vecOrigin") }
            if b_pos ~= nil then
                local p_pos = { entity_get_prop(plocal, "m_vecOrigin") }
                distance = math_abs(dist_between(p_pos, b_pos))
            end
        end
		
		local team_num = entity_get_prop(plocal, "m_iTeamNum")
		local defusing = team_num == 3 and distance < 62
		
		local px, py, pz = client_eye_position()
		local pitch, yaw = client_camera_angles()
	
		local sin_pitch = math_sin(math_rad(pitch))
		local cos_pitch = math_cos(math_rad(pitch))
		local sin_yaw = math_sin(math_rad(yaw))
		local cos_yaw = math_cos(math_rad(yaw))

		local dir_vec = { cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch }

		local fraction, entindex = client_trace_line(plocal, px, py, pz, px + (dir_vec[1] * 8192), py + (dir_vec[2] * 8192), pz + (dir_vec[3] * 8192))

		local using = true

		if entindex ~= nil then
			for i=0, #v.classnames do
				if entity_get_classname(entindex) == v.classnames[i] then
					using = false
				end
			end
		end

		if not using and not defusing then
			cmd.in_use = 0
		end
        return true
	end
    return false
end

local hitboxes = { 0, 3, 2, 5, 4, 6, 7, 8}
local get_hg = {1, 3, 3, 2, 2, 2, 2, 7, 6}
local function scan_dmg(e, p, x, y, z, start)
	for i=start, #hitboxes do
		local h = { entity_hitbox_position(e, hitboxes[i]) }
		local ent, dmg = client_trace_bullet(p, x, y, z, h[1], h[2], h[3])
        dmg = ent == nil and client.scale_damage(e, get_hg[i], dmg) or dmg
		if dmg ~= nil and dmg > 0 then
			return dmg
		end
	end
	return 0
end

local function tp_lethal(plocal)
	if not ui_get(ref.dt[2]) or not contains(aa.dt, "Teleport if enemy lethal") or ui_get(aa.dtk) then
		return
	end

	if v.last_shot + 1 > globals_curtime() then
		ui_set(ref.dt[1], true) 
		return
	end

    local o = { client_eye_position() }

	--movement per tick
	local delta = { o[1] - v.o[1], o[2] - v.o[2], o[3] - v.o[3] }

	local tp_ticks = ui_get(ref.maxprocticks) - ui_get(ref.dt_limit) + (ui_get(ref.fl_limit) / 2)
	
	delta = {delta[1]*tp_ticks, delta[2]*tp_ticks, delta[3]*tp_ticks}

	local po = { o[1] + delta[1], o[2] + delta[2], o[3] - delta[3]}

	v.o = o

	if not is_valid(v.target) then
		ui_set(ref.dt[1], true)
		return
	end

	local dmg = scan_dmg(v.target, plocal, po[1], po[2], po[3], 2)
	if dmg > entity_get_prop(v.target, "m_iHealth") then
		ui_set(ref.dt[1], false)
		return
	end

	ui_set(ref.dt[1], true)
end

local function r8_prediction(plocal)
    local plocal = entity_get_local_player()
    local wpn = entity_get_player_weapon(plocal)
	local wpn_id = entity_get_prop(wpn, "m_iItemDefinitionIndex")
	local m_item = bit_band(wpn_id, 0xFFFF)

    local vx, vy, vz = entity_get_prop(plocal, "m_vecVelocity")

    local speed = math_sqrt(vx^2 + vy^2 + vz^2)

    if m_item ~= 64 or not contains(aa.dt, "R8 prediction") or speed < 2 then

        if v.predicted_r8 then
            ui_set(ref.rage[2], "Always on")
            v.predicted_r8 = false
        end

        return
    end

	local o = { client_eye_position() }

	--movement per tick
	local delta = { o[1] - v.o2[1], o[2] - v.o2[2], o[3] - v.o2[3] }

	local tp_ticks = 7 --charge ticks
	
	delta = {delta[1]*tp_ticks, delta[2]*tp_ticks, delta[3]*tp_ticks}

	v.r8 = { o[1] + delta[1], o[2] + delta[2], o[3] - delta[3]}

	v.o2 = o

	if is_valid(v.target) then
		local dmg = scan_dmg(v.target, plocal, v.r8[1], v.r8[2], v.r8[3], 1)

        if dmg >= ui_get(ref.dmg) then
            ui_set(ref.rage[2], "Always on")
            return
        end
	end

	ui_set(ref.rage[2], "On hotkey")
    v.predicted_r8 = true
end

local function get_key_mode(ref)
	local k = { ui_get(ref) }
	local hk_mode = k[2]
	if hk_mode == nil then
		return "nil"
	end
    return v.hotkey_modes[hk_mode + 1]
end

local ideal_data = {
    o = {0, 0, 0},
    b = "On hotkey",
    q = { false, "On hotkey" },
    dt = { false, "On hotkey" },
    fs = false,
    store = true,
    limit = 0
}

local function ideal_tick(plocal, cmd)
    local target = get_nearest_enemy()
    if not ui_get(aa.dtk) or not contains(aa.dt, "Teleport peek") then
        if not ideal_data.store then
            v.dir.freestand = ideal_data.fs
            ui_set(ref.quickpeek[1], ideal_data.q[1])
            ui_set(ref.quickpeek[2], ideal_data.q[2])
            ui_set(ref.forcebaim, ideal_data.b)
            ui_set(ref.dt[1], ideal_data.dt[1])
            ui_set(ref.dt[2], ideal_data.dt[2])
            ui_set(ref.rage[1], true)
            ideal_data.store = true
        end
        return
    end

    if ideal_data.store then
        ideal_data = {
            o = {0, 0, 0},
            b = get_key_mode(ref.forcebaim),
            q = { ui_get(ref.quickpeek[1]), get_key_mode(ref.quickpeek[2]) },
            dt = { ui_get(ref.dt[1]), get_key_mode(ref.dt[2]) },
            fs = v.dir.freestand,
            store = false
        }
    end

    if v.last_shot + 0.7 < globals_curtime() then
        ui_set(ref.rage[1], true)
        ui_set(ref.dt[2], "Always on")
    end

    v.dir.freestand = not v.holding_e
    ui_set(ref.dt[1], true)
    
    if contains(aa.dt, "Custom min dmg") then
        ui_set(ref.dmg, ui_get(aa.dmg))
    end

    ui_set(ref.forcebaim, "Always on")
    ui_set(ref.quickpeek[1], true)
    ui_set(ref.quickpeek[2], "Always on")
end

local function run_direction(plocal)
    if contains(aa.s, "Manual AA") then
        if ui_get(aa.ml) and v.dir.time + 0.2 < globals_curtime() then
            v.dir.manual = v.dir.manual == -90 and 0 or -90
            v.dir.time = globals_curtime()
        elseif ui_get(aa.mr) and v.dir.time + 0.2 < globals_curtime() then
            v.dir.manual = v.dir.manual == 90 and 0 or 90
            v.dir.time = globals_curtime()
        elseif ui_get(aa.mf) and v.dir.time + 0.2 < globals_curtime() then
            v.dir.manual = v.dir.manual == 180 and 0 or 180
            v.dir.time = globals_curtime()
        elseif ui_get(aa.mb) and v.dir.time + 0.2 < globals_curtime() then
            v.dir.manual = 0
            v.dir.time = globals_curtime()
        elseif v.dir.time > globals_curtime() then
            v.dir.time = globals_curtime()
        end
            
        if v.dir.manual ~= v.stored_dir.manual then
            ui_set(ref.yaw[2], v.dir.manual)
            v.stored_dir.manual = v.dir.manual
        end

        ui_set(ref.yaw[2], v.dir.manual)
    end

    v.dir.edge = contains(aa.s, "Edge yaw") and ui_get(aa.ey) and not v.holding_e
    v.dir.freestand = contains(aa.s, "Freestanding") and ui_get(aa.fs) and not v.holding_e
end

local function rotate_point(x, y, rot, size)
	return math_cos(math_rad(rot)) * size + x, math_sin(math_rad(rot)) * size + y
end

local function renderer_transgender(x, y, r, g, b, a, r1, g1, b1, a1, real_rot, fake_rot, size, side)

    renderer_circle_outline(x, y, r, g, b, a, size/4, 0, 1, 1)

    --Fake
    local x0, y0 = rotate_point(x, y, fake_rot, 35)
    local x1, y1 = rotate_point(x, y, fake_rot, 15)

    local x4, y4 = rotate_point(x, y, fake_rot - 10, 30)
    local x5, y5 = rotate_point(x, y, fake_rot + 10, 30)

    renderer_line(x1, y1, x0, y0, r1, g1, b1, 255)
    renderer_line(x0, y0, x4, y4, r1, g1, b1, 255)
    renderer_line(x0, y0, x5, y5, r1, g1, b1, 255)

    --Real

	x0, y0 = rotate_point(x, y, real_rot, 35)
	x1, y1 = rotate_point(x, y, real_rot, 15)

	local x2, y2 = rotate_point(x, y, real_rot - 12, 25)
	local x3, y3 = rotate_point(x, y, real_rot + 12, 25)

    x4, y4 = rotate_point(x, y, real_rot - 10, 30)
	x5, y5 = rotate_point(x, y, real_rot + 10, 30)

    renderer_line(x1, y1, x0, y0, r, g, b, 255)
    renderer_line(x2, y2, x3, y3, r, g, b, 255)
    renderer_line(x0, y0, x4, y4, r, g, b, 255)
    renderer_line(x0, y0, x5, y5, r, g, b, 255)

    --plus
    x0, y0 = rotate_point(x, y, real_rot - (real_rot-fake_rot)/2 + 180, 35)
	x1, y1 = rotate_point(x, y, real_rot - (real_rot-fake_rot)/2 + 180, 15)

	local x2, y2 = rotate_point(x, y, real_rot - (real_rot-fake_rot)/2 + 180 - 14, 27)
	local x3, y3 = rotate_point(x, y, real_rot - (real_rot-fake_rot)/2 + 180 + 12, 27)

    renderer_line(x1, y1, x0, y0, r, g, b, 255)
    renderer_line(x2, y2, x3, y3, r, g, b, 255)
end

local function renderer_static(cx, cy, r, g, b, a, bodyyaw)
    renderer_triangle(cx + 55, cy + 2, cx + 42, cy - 7, cx + 42, cy + 11, 
    v.dir.manual == 90 and r or 35, 
    v.dir.manual == 90 and g or 35, 
    v.dir.manual == 90 and b or 35, 
    v.dir.manual == 90 and a or 150)

    renderer_triangle(cx - 55, cy + 2, cx - 42, cy - 7, cx - 42, cy + 11, 
    v.dir.manual == -90 and r or 35, 
    v.dir.manual == -90 and g or 35, 
    v.dir.manual == -90 and b or 35, 
    v.dir.manual == -90 and a or 150)
    
    renderer_rectangle(cx + 38, cy - 7, 2, 18, 
    bodyyaw < -10 and r1 or 35,
    bodyyaw < -10 and g1 or 35,
    bodyyaw < -10 and b1 or 35,
    bodyyaw < -10 and a1 or 150)
    renderer_rectangle(cx - 40, cy - 7, 2, 18,			
    bodyyaw > 10 and r1 or 35,
    bodyyaw > 10 and g1 or 35,
    bodyyaw > 10 and b1 or 35,
    bodyyaw > 10 and a1 or 150)
end

local function renderer_arrow(x, y, r, g, b, a, rotation, size)
	local x0, y0 = rotate_point(x, y, rotation, 45)
	local x1, y1 = rotate_point(x, y, rotation + (size / 3.5), 45 - (size / 4))
	local x2, y2 = rotate_point(x, y, rotation - (size / 3.5), 45 - (size / 4))
	renderer_triangle(x0, y0, x1, y1, x2, y2, r, g, b, a)
end

local function renderer_sharingan(x, y, r, g, b, a, rotation)
	local x0, y0 = rotate_point(x, y, rotation - 1, 50 / 3.5)

	local x1, y1 = rotate_point(x, y, rotation + 3, 85/ 3.5)
	local x2, y2 = rotate_point(x, y, rotation + 15, 45/ 3.5)
	local x3, y3 = rotate_point(x, y, rotation - 12, 65/ 3.5)

	renderer_triangle(x1, y1, x2, y2, x3, y3, r, g, b, a)
	renderer_circle(x0, y0, r, g, b, a, 18 / 3.5, 0, 1)
end

local data = {
    chk = 0,
    dst = 0,
    origin = {0, 0, 0},
    sim_time = 0,
    fl = 0,
    dsy = 0,
    lc = 0,
}

local function round(num, decimals)
	local mult = 10^(decimals or 0)
	return math_floor(num * mult + 0.5) / mult
end

local function update_choke(player)
    local sim_time = entity_get_prop(player, "m_flSimulationTime")
    local origin =  { entity_get_prop(player, "m_vecOrigin") }

    if sim_time ~= data.sim_time then

        data.chk = round(math_max(0, sim_time - data.sim_time) / globals_tickinterval())
        data.dst = round(math_abs(dist_between(data.origin, origin)))

        data.origin = origin
        data.sim_time = sim_time
    end
end

local function animate_value(anim, targ, scale)

    if math_abs(anim - targ) > scale then
        anim = anim > targ
        and anim - scale 
        or anim + scale
    end

    return anim
end

local frametimes = {}
local fps_prev = 0
local last_update_time = 0
local globals_absoluteframetime, table_insert, globals_realtime = globals.absoluteframetime, table.insert, globals.realtime
local function get_fps()
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

local function is_dragging(x, y, w, h)
	local mx, my = ui_mouse_position()
	local click = client_key_state(0x01)
	
	local in_x = mx > x and mx < x + w	
	local in_y = my > y and my < y + h 

	return in_x and in_y and click and ui_is_menu_open()
end

local function is_dragging_menu()
	local x, y = ui_mouse_position()
	local px, py = ui_menu_position()
	local sx, sy = ui_menu_size()
	local click = client_key_state(0x01)
	
	local in_x = x > px and x < px + sx	
	local in_y = y > py and y < py + sy 

	return in_x and in_y and click and ui_is_menu_open()
end

local function run_dragging()
	local click = client_key_state(0x01)
	local mx, my = ui_mouse_position()
	local x, y = v.w[1], v.w[2]
	local sx, sy = client_screen_size()

    if not is_dragging_menu() and is_dragging(v.w[1], v.w[2], 300, 20) then
        v.dragging = true
    elseif not click then
        v.dragging = false
    end

	if v.dragging then
		local dx, dy = x - v.ow[1], y - v.ow[2]
        v.w = { math_min(math_max(mx + dx, 0), sx), math_min(math_max(my + dy, 0), sy) }
		v.ow = { mx, my }
	else
		v.ow = { mx, my }
	end
end

local function on_setup_command(cmd)
    local plocal = entity_get_local_player()
    
    v.rec[#v.rec + 1] = { entity_get_eye_pos(plocal) }

    if #v.rec > 28 then
        table_remove(v.rec, 1)
    end

    update_player_state(plocal, cmd)
    update_desync(plocal)

    v.holding_e = aa_on_use(plocal, cmd)

    run_direction(plocal, v.holding_e)

    ui_set(ref.bodyyaw[1], v.desync == 0 and "Off" or (v.desync == 180 and "Jitter" or "Static"))
    ui_set(ref.bodyyaw[2], v.desync == 180 and 0 or (v.holding_e and -v.desync or v.desync))

    local doubletapping = ui_get(ref.dt[1]) and ui_get(ref.dt[2])
	local onshotaa = ui_get(ref.os[1]) and ui_get(ref.os[2])
	local low_legit_fl = ui_get(ref.fl_limit) < 3 and ui_get(aa.t) == "Legit"
	local exploiting = doubletapping or onshotaa or low_legit_fl

    ui_set(ref.fakeyawlimit, ui_get(aa.r[v.aa]))

    ui_set(ref.yaw[1], (ui_get(aa.t) == "Legit" or v.holding_e) and "Off" or "180")
    ui_set(ref.pitch, (ui_get(aa.t) == "Legit" or v.holding_e) and "Off" or "Default")
    ui_set(ref.yawbase, (ui_get(aa.t) == "Legit" or v.dir.manual ~= 0) and "Local view" or ui_get(aa.yb[v.aa]))

    tp_lethal(plocal, v.target)
    r8_prediction(plocal, v.target)
    ideal_tick(plocal, cmd)

    if v.dir.freestand ~= v.stored_dir.freestand then
        ui_set(ref.freestand[1], v.dir.freestand and "Default" or "-")
        ui_set(ref.freestand[2], "Always on")
        v.stored_dir.freestand = v.dir.freestand
    end

    if v.dir.edge ~= v.stored_dir.edge then
        ui_set(ref.edgeyaw, v.dir.edge)
        v.stored_dir.edge = v.dir.edge
    end

    v.last_choke = cmd.chokedcommands
    set_og_menu(false)
end

local function on_bullet_impact(e)
    local plocal = entity_get_local_player()
	local shooter = client_userid_to_entindex(e.userid)

    if not entity_is_enemy(shooter) or not entity_is_alive(plocal) or not is_valid(shooter) then
		return
	end

    local d = dist_from_3dline(shooter, e)
    if shot_at_player(d, v.ls, shooter, plocal, e) then
        local shot = #p[shooter].s > 0 and p[shooter].s[#p[shooter].s].t == globals_curtime() and #p[shooter].s or #p[shooter].s + 1
        local detect = v.desync == 0 or v.desync == 180 or contains(aa.s, "Detect missed angle")
        local new_angle = v.desync == 90 and -90 or 90

        if detect then
            if math_abs(d) < 3 then
                new_angle = v.desync
            else
                new_angle = d > 0 and -90 or 90
            end
        end

        p[shooter].s[shot] = {
            t = globals_tickcount(),
            d = new_angle,
            dis = d
        }
    end
end

local function on_player_hurt(e)
    local plocal = entity_get_local_player()
	local victim = client_userid_to_entindex(e.userid)
	local shooter = client_userid_to_entindex(e.attacker)

	if not entity_is_enemy(shooter) or not entity_is_alive(plocal) then
		return
	end

	for k=1, #v.nonweapons do
		if e.weapon == v.nonweapons[k] then
			return
		end
	end

    local hit = #p[shooter].h > 0 and #p[shooter].h or #p[shooter].h + 1
    
    p[shooter].h[hit] = {
        t = globals_tickcount(),
        d = new_angle,
        h = e.hitgroup,
        v = victim
    }
end

local function on_aim_fire(e)
    v.last_shot = globals_curtime()
    if ui_get(aa.dtk) and contains(aa.dt, "Teleport peek") then
        ui_set(ref.dt[2], "On hotkey")
        ui_set(ref.rage[1], false)
    end
end

local function on_paint()
    local plocal = entity_get_local_player()

    update_shots(plocal)

    if not entity_is_alive(plocal) then
        return
    end

    local sc = { client_screen_size() }
    local ce = { sc[1] / 2, sc[2] / 2 }

    local r, g, b, a = ui_get(aa.clr[2])
    local er, eg, eb, ea = ui_get(aa.clr2[2])

    local height = 20
    if contains(aa.s, "AA indicator") then
        local cam = { client_camera_angles() }

        local head = { entity_hitbox_position(plocal, "head_0") }
        local pelvis = { entity_hitbox_position(plocal, "pelvis") }

        local bodyyaw = (entity_get_prop(plocal, "m_flPoseParameter", 11) * 120 - 60)
        if ui_get(aa.aa) == "Circle" then
                
            local yaw = normalize_yaw(calc_angle(pelvis[1], pelvis[2], head[1], head[2]) - bodyyaw/2 - cam[2] + 120)

            yaw = bodyyaw < 0 and yaw - (36*math_abs(bodyyaw / 58)) or yaw + (36*math_abs(bodyyaw / 58))
        
            renderer_circle_outline(ce[1], ce[2], bodyyaw < 0 and r or er, 
            bodyyaw < 0 and g or eg,
            bodyyaw < 0 and b or eb,
            255,
            30, -(yaw + 36), 0.1 * math_abs(bodyyaw / 58), 5)
        
            renderer_circle_outline(ce[1], ce[2], bodyyaw > 0 and r or er, 
            bodyyaw > 0 and g or eg,
            bodyyaw > 0 and b or eb,
            255,
            30, -(yaw + (36 * (1 - math_abs(bodyyaw / 58)))), (0.1 * math_abs(bodyyaw / 58)), 5)
            height = 25
        elseif ui_get(aa.aa) == "Transgender" then
            
            local yaw = normalize_yaw(calc_angle(pelvis[1], pelvis[2], head[1], head[2]) - cam[2] + 120)

            local real_dir = (yaw) * -1
            local fake_dir = v.desync == 180 and (yaw + bodyyaw/1.9)*-1 or (yaw + bodyyaw/1.5) * -1
			renderer_transgender(ce[1], ce[2], r, g, b, 255, er, eg, eb, 255, real_dir, fake_dir, 60, bodyyaw < 0)
            height = 35
        elseif ui_get(aa.aa) == "Arrow" then
            local yaw = normalize_yaw(calc_angle(pelvis[1], pelvis[2], head[1], head[2]) - cam[2] + 120)
            local fake_dir = v.desync == 180 and (yaw + bodyyaw/1.9)*-1 or (yaw + bodyyaw/1.5) * -1
            renderer_arrow(ce[1], ce[2], r, g, b, 255, (yaw - 15) * -1, 45)
            renderer_arrow(ce[1], ce[2], er, eg, eb, 255, (fake_dir), 30)
            height = 35
        elseif ui_get(aa.aa) == "Sharingan" then
            local yaw = normalize_yaw(calc_angle(pelvis[1], pelvis[2], head[1], head[2]) - cam[2] + 120)
            local fake_dir = v.desync == 180 and (yaw + bodyyaw/1.9)*-1 or (yaw + bodyyaw) * -1
            local real_dir = yaw * -1
            local third = real_dir - (real_dir-fake_dir)/2 + 180

            renderer_circle(ce[1], ce[2], r, g, b, a, 27, 50, 1, 1)
            renderer_circle_outline(ce[1], ce[2], 0, 0, 0, 255, 27, 50, 1, 2)
            renderer_circle(ce[1], ce[2], 0, 0, 0, 255, 4, 50, 1, 1)
            renderer_circle_outline(ce[1], ce[2], 0, 0, 0, 255, 15, 50, 1, 1)

            renderer_sharingan(ce[1], ce[2], 0, 0, 0, 255, real_dir)
            renderer_sharingan(ce[1], ce[2], 0, 0, 0, 255, fake_dir)
            renderer_sharingan(ce[1], ce[2], 0, 0, 0, 255, third)
        elseif ui_get(aa.aa) == "Static" then
            renderer_static(ce[1], ce[2], r, g, b, a, bodyyaw)
        end
    end

    update_choke(plocal)

    if v.w[1] == 0 and v.w[2] == 0 then
        v.w = { ce[1]-150, sc[2]-30 }
    end
    local bodyyaw = math_abs(entity_get_prop(plocal, "m_flPoseParameter", 11) * 120 - 60)

    local w = 300
    renderer_gradient(v.w[1], v.w[2], w, 20, er, eg, eb, a, r, g, b, a, true)
    renderer_rectangle(v.w[1]+1, v.w[2]+1, w-2, 18, 0, 0, 0, a*0.8)

    local lc = math_min(1, math_max(0, data.dst / 100))
    local dsy = math_min(1, math_max(0, bodyyaw / 58))

    data.lc = math_min(1, math_max(0.1, animate_value(data.lc, lc, 0.01)))
    data.dsy = math_min(1, math_max(0, animate_value(data.dsy, dsy, 0.01)))

    renderer_text(v.w[1]+10, v.w[2]+3, 225, 225, 225, 255, "b", 0, "ts recode v1.4 | dsy:                  | lc:                  | fps: " .. tostring(get_fps()))
    renderer_gradient(v.w[1]+114, v.w[2]+7, 50*data.dsy, 6, er, eg, eb, a, r, g, b, a, true)
    renderer_gradient(v.w[1]+188, v.w[2]+7, 50*data.lc, 6, er, eg, eb, a, r, g, b, a, true)

    if contains(aa.s, "Keybind indicator") then
        local keys = {}

        if ui_get(aa.dtk) then
            local ideal_charge = round(math.max(0, math.min(100, (globals_curtime() - v.last_shot) / 0.01)))
            keys[#keys + 1] = {
                t = "ideal tick " .. tostring(ideal_charge) ,
                e = true
            }
        end

        if contains(aa.k, "Double tap") and (ea > 0 or (ui_get(ref.dt[1]) and ui_get(ref.dt[2]))) then
            keys[#keys + 1] = {
                t = "double tap",
                e = ui_get(ref.dt[1]) and ui_get(ref.dt[2])
            }
        end

        if contains(aa.k, "Freestanding") and (ea > 0 or (ui_get(ref.freestand[1]) == "Default" and ui_get(ref.freestand[2]))) then
            keys[#keys + 1] = {
                t = "freestand",
                e = ui_get(ref.freestand[1]) == "Default" and ui_get(ref.freestand[2])
            }
        end

        if contains(aa.k, "Hide shots") and (ea > 0 or (ui_get(ref.os[1]) and ui_get(ref.os[2]))) then
            keys[#keys + 1] = {
                t = "hide shots",
                e = ui_get(ref.os[1]) and ui_get(ref.os[2])
            }
        end

        if contains(aa.k, "Force baim") and (ea > 0 or ui_get(ref.forcebaim)) then
            keys[#keys + 1] = {
                t = "force baim",
                e = ui_get(ref.forcebaim)
            }
        end

        if contains(aa.k, "Force safe point") and (ea > 0 or ui_get(ref.safepoint)) then
            keys[#keys + 1] = {
                t = "force safe",
                e = ui_get(ref.safepoint)
            }
        end

        if contains(aa.k, "Quick peek") and (ea > 0 or (ui_get(ref.quickpeek[1]) and ui_get(ref.quickpeek[2]))) then
            keys[#keys + 1] = {
                t = "quick peek",
                e = ui_get(ref.quickpeek[1]) and ui_get(ref.quickpeek[2])
            }
        end

        for i=1, #keys do
            local clr = (i % 2 ~= 0) and { er, eg, eb, 255 } or {r, g, b, 255}

            renderer_text(ce[1]-1, ce[2] + height + 12 + (i*11), 
            keys[i].e and clr[1] or 100,
            keys[i].e and clr[2] or 100,
            keys[i].e and clr[3] or 100,
            keys[i].e and 255 or ea,
            "bc", 0, keys[i].t)
        end
        
        --renderer_line(ce[1]-40, ce[2] + height + 10, ce[1]+40, ce[2] + height + 10, r, g, b, 200)
        --renderer_line(ce[1]-40, ce[2] + height + 25 + (#keys*11), ce[1]+40, ce[2] + height + 25 + (#keys*11), er, eg, eb, 200)
        --renderer_gradient(ce[1]-40, ce[2] + height + 10, 2, 15 + (#keys*11), r, g, b, 200, er, eg, eb, 200, false)
        --renderer_gradient(ce[1]+38, ce[2] + height + 10, 2, 15 + (#keys*11), r, g, b, 200, er, eg, eb, 200, false)
    end

    if ui_get(aa.dtk) then
        local x, y = renderer.world_to_screen(v.r8[1], v.r8[2], v.r8[3])
        if x ~= nil then
            renderer_text(x, y, 255, 255, 255, 255, "bc", 0, "o")
        end
    end

    run_dragging()
end

local function handle_menu()
    local rage = ui_get(aa.t) == "Rage"

    for i=1, 5 do
        ui_set_visible(aa.yb[i], rage and v.state_idx[ui_get(aa.p)] == i)
        ui_set_visible(aa.b[i], v.state_idx[ui_get(aa.p)] == i)
        ui_set_visible(aa.r[i], v.state_idx[ui_get(aa.p)] == i)
    end

    if not contains(aa.s, "Manual AA") then
        ui_set(ref.yaw[2], 0)
    end

    ui.set(ref.maxprocticks, contains(aa.dt, "Increase max processing ticks") and 18 or 16)
    

    --hide hotkeys when not necessary
    ui_set_visible(aa.ml, rage and contains(aa.s, "Manual AA"))
    ui_set_visible(aa.mr, rage and contains(aa.s, "Manual AA"))
    ui_set_visible(aa.mf, rage and contains(aa.s, "Manual AA"))
    ui_set_visible(aa.mb, rage and contains(aa.s, "Manual AA"))
    ui_set_visible(aa.fs, rage and contains(aa.s, "Freestanding"))
    ui_set_visible(aa.ey, rage and contains(aa.s, "Edge yaw"))
    ui_set_visible(aa.k, contains(aa.s, "Keybind indicator"))
    ui_set_visible(aa.aa, contains(aa.s, "AA indicator"))
    ui_set_visible(aa.dt, contains(aa.s, "Plex exploits"))
    ui_set_visible(aa.dtk, contains(aa.s, "Plex exploits"))
    ui_set_visible(aa.clr[1], contains(aa.s, "AA indicator") or contains(aa.s, "Keybind indicator"))
    ui_set_visible(aa.clr[2], contains(aa.s, "AA indicator") or contains(aa.s, "Keybind indicator"))
    ui_set_visible(aa.clr2[1], contains(aa.s, "AA indicator") or contains(aa.s, "Keybind indicator"))
    ui_set_visible(aa.clr2[2], contains(aa.s, "AA indicator") or contains(aa.s, "Keybind indicator"))
    ui_set_visible(aa.dmg, contains(aa.dt, "Custom min dmg"))
    set_og_menu(false)
end

local function recheck()
    client.unset_event_callback("shutdown", set_og_menu)
    client.unset_event_callback("paint", on_paint)
    client.unset_event_callback("bullet_impact", on_bullet_impact)
    client.unset_event_callback("player_hurt", on_player_hurt)
    client.unset_event_callback("setup_command", on_setup_command)
end

local function reset_data(store)
    if store == nil then
        recheck()
        store = false
    end

    for i=1, 64 do
        local stored_dsy = p[i].d

        p[i] = {
            s = {}, --shots
            h = {},
            r = 0, --recorded shot count
            d = 0, --last missed
            m = 0, --miss count
            l = store and stored_dsy or 0 --logged headshot
        }

        if not store then
            p[i].z = 0
        end
    end
end

local function on_player_spawn(e)
    local plocal = entity_get_local_player()
	local ent = client_userid_to_entindex(e.userid)
    if ent == plocal then
        reset_data(true)
    end
end

local function on_player_connect_full(e)
    local plocal = entity_get_local_player()
	local ent = client_userid_to_entindex(e.userid)
    if ent == plocal then
        reset_data()
    end
end

local function on_shutdown()
    set_og_menu()
    database.write("ts_watermark_position", v.w)
end

local function on_startup()
    handle_menu()

    ui_set_callback(aa.p, handle_menu)
    ui_set_callback(aa.dt, handle_menu)
    ui_set_callback(aa.t, handle_menu)
    ui_set_callback(aa.s, handle_menu)
        
    --functions
    client_set_event_callback("shutdown", on_shutdown)
    client_set_event_callback("paint", on_paint)
    client_set_event_callback("bullet_impact", on_bullet_impact)
    client_set_event_callback("player_hurt", on_player_hurt)
    client_set_event_callback("setup_command", on_setup_command)
    client_set_event_callback("player_spawn", on_player_spawn)
    client_set_event_callback("aim_fire", on_aim_fire)
        
    --reset data
    client_set_event_callback("client_disconnect", reset_data)
    client_set_event_callback("cs_game_disconnected", reset_data)
    client_set_event_callback("game_newmap", reset_data)
    client_set_event_callback("player_connect_full", on_player_connect_full)

    local stored = database.read("ts_watermark_position")
    if stored ~= nil then
        v.w = stored
    end
end
on_startup()