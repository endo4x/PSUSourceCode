--[[
	id: a8cFhYfjspY5Ev7IYssn1
	name: god aa
	description: aa
	time1: 2021-04-25 12:00:15.816243+00
	time2: 2021-04-25 12:00:15.816243+00
	uploader: s2j_sOIPT8EV7Rmr-sVCb60G9-Uc7_NMIp0KIjjd
	uploadersession: -q_XqniSfQ1Ckooerw3yLViEReVDH-
	flag: f
--]]

local vector = require("vector")

local ui_get, ui_set, ui_reference, ui_set_visible, ui_set_callback = ui.get, ui.set, ui.reference, ui.set_visible, ui.set_callback
local math_floor, math_sqrt = math.floor, math.sqrt
local client_log, client_color_log = client.log, client.color_log
local entity_get_local_player, entity_get_prop = entity.get_local_player, entity.get_prop
local renderer_text = renderer.text
local bit_band, string_format = bit.band, string.format
local ui_new_checkbox, ui_new_slider, ui_new_color_picker, table_remove, entity_get_prop, bit_band, entity_get_player_name, client_set_event_callback, ui_get, client_screen_size, entity_get_all, entity_is_enemy, renderer_text, renderer_rectangle, renderer_gradient, client_userid_to_entindex, globals_curtime = ui.new_checkbox, ui.new_slider, ui.new_color_picker, table.remove, entity.get_prop, bit.band, entity.get_player_name, client.set_event_callback, ui.get, client.screen_size, entity.get_all, entity.is_enemy, renderer.text, renderer.rectangle, renderer.gradient, client.userid_to_entindex, globals.curtime
local entity_get_local_player = entity.get_local_player

local steam_ids = {
	pEA = "76561198185023781",
	HTL = "76561198009990735",
}

client.color_log(0, 245, 255, "Anti-aim by Hitler Q3487510691")


local ref_minimum_damage = ui.reference("rage", "aimbot", "Minimum damage")
local ref_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled")
local ref_pitch = ui.reference("AA", "Anti-aimbot angles", "pitch")
local ref_yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local ref_yaw, ref_yawadd = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local ref_yawjitter, ref_yawjitteradd = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local ref_bodyyaw, ref_bodyyawadd = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local ref_fakeyawlimit = ui.reference("aa", "anti-aimbot angles", "Fake yaw limit")
local ref_fsbodyyaw = ui.reference("aa", "anti-aimbot angles", "Freestanding body yaw")
local ref_lowerbodyyaw = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local ref_edgeyaw = ui.reference("aa", "Anti-aimbot angles", "Edge yaw")
local ref_freestand, ref_freestandkey = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local ref_maxprocticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local ref_dt, ref_dtkey = ui.reference("RAGE", "Other", "Double tap")
local ref_os, ref_oskey = ui.reference("AA", "Other", "On shot anti-aim")
local ref_legyaw = ui.reference("aa", "other", "Leg movement")
local ref_safe = ui.reference("RAGE", "Aimbot", "Force safe point")
local ref_fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
local ref_slow, ref_slowkey = ui.reference("AA", "Other", "Slow motion")
local ref_safepoint     = ui.reference("RAGE", "Aimbot", "Force safe point")
local ref_forcebaim     = ui.reference("RAGE", "Other", "Force body aim")

local manual_freestand = ui.new_hotkey("AA", "Anti-aimbot angles", "Hitler freestanding")
local manual_edge = ui.new_hotkey("AA", "Anti-aimbot angles", "Hitler manual edge")
local manual_left = ui.new_hotkey("AA", "Anti-aimbot angles", "Hitler manual left")
local manual_right = ui.new_hotkey("AA", "Anti-aimbot angles", "Hitler manual right")
local manual_legit_aa = ui.new_hotkey("AA", "Anti-aimbot angles", "Hitler legit aa")
local manual_legit_peek = ui.new_hotkey("AA", "Anti-aimbot angles", "Hitler legit peek")
local manual_peek_choose = ui.new_checkbox("AA", "Anti-aimbot angles", "Hitler legit peek only DT")
local ref_anti_bruteforce = ui.new_checkbox("AA", "Anti-aimbot angles", "Hitler anti-bruteforce jitter")
local ref_hide_leg = ui.new_checkbox("AA", "Anti-aimbot angles", "Hitler hide legs")
local manual_slow_walk = ui.new_checkbox("AA", "Anti-aimbot angles", "Hitler slow walk")
local manual_slow_walk_type = ui.new_combobox("AA", "Anti-aimbot angles", "Hitler slow walk body yaw", {"Static", "Jitter"})
local manual_anti_knife_type = ui.new_combobox("AA", "Anti-aimbot angles", "Hitler anti knife", {"Off", "Safe", "Always"})

local aa_dir = 0
local xuid = ""

local LOA = 0
local legit_aa_time_bool = false
local anti_knife_time = false
local players_anti = {}


local miss, hit, shots, last_hit, stored_misses, stored_shots = {}, {}, {}, {}, {}, {}
for i=1, 64 do
	players_anti[i] = false
    miss[i], hit[i], shots[i], last_hit[i], stored_misses[i], stored_shots[i] = {}, {}, {}, 0, 0, 0
	for k=1, 3 do
		miss[i][k], hit[i][k], shots[i][k] = {}, {}, {}
		for j=1, 1000 do
			miss[i][k][j], hit[i][k][j], shots[i][k][j] = 0, 0, 0
		end
	end
	miss[i][4], hit[i][4], shots[i][4] = 0, 0, 0
end

local weapons_ignored = {
    "CKnife",
    "CWeaponTaser",
    "CC4",
    "CHEGrenade",
    "CSmokeGrenade",
    "CMolotovGrenade",
    "CSensorGrenade",
    "CFlashbang",
    "CDecoyGrenade",
    "CIncendiaryGrenade"
}

local nonweapons = 
{
	"knife",
	"hegrenade",
	"inferno",
	"flashbang",
	"decoy",
	"smokegrenade",
	"taser"
}

local function contains(table, value)
    table = ui.get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local function tablecont(table, item)
    for i=1, #table do
        if table[i] == item then
            return true
        end
    end
    return false
end

local function set_og_menu(state)
	ui.set_visible(ref_pitch, state)
	ui.set_visible(ref_yawbase, state)
	ui.set_visible(ref_yaw, state)
	ui.set_visible(ref_yawadd, state)
	ui.set_visible(ref_yawjitter, state)
	ui.set_visible(ref_yawjitteradd, state)
	ui.set_visible(ref_bodyyaw, state)
	ui.set_visible(ref_bodyyawadd, state)
	ui.set_visible(ref_fakeyawlimit, state)
	ui.set_visible(ref_fsbodyyaw, state)
	ui.set_visible(ref_edgeyaw, state)
	ui.set_visible(ref_freestand, state)
	ui.set_visible(ref_freestandkey, state)
	ui.set_visible(ref_lowerbodyyaw, state)
end
set_og_menu(false)

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function extrapolate_position(xpos,ypos,zpos,ticks,ent)
	x,y,z = entity.get_prop(ent, "m_vecVelocity")
	for i=0, ticks do
		xpos =  xpos + (x*globals.tickinterval())
		ypos =  ypos + (y*globals.tickinterval())
		zpos =  zpos + (z*globals.tickinterval()  + (9.81 * ((globals.tickinterval())* (globals.tickinterval()) / 2)))
	end
	return xpos,ypos,zpos
end

local function is_moving(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	return math.sqrt(x * x + y * y + z * z) > 1.0
end

local function ent_speed(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	if x == nil then
		return 0
	end
	return math.sqrt(x * x + y * y + z * z)
end

local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
end

local function is_dt()

    local dt = false

    local local_player = entity.get_local_player()

    if local_player == nil then
        return
    end

    if not entity.is_alive(local_player) then
        return
    end

    local active_weapon = entity.get_prop(local_player, "m_hActiveWeapon")

    if active_weapon == nil then
        return
    end

    nextAttack = entity.get_prop(local_player,"m_flNextAttack")
    nextShot = entity.get_prop(active_weapon,"m_flNextPrimaryAttack")
    nextShotSecondary = entity.get_prop(active_weapon,"m_flNextSecondaryAttack")

    if nextAttack == nil or nextShot == nil or nextShotSecondary == nil then
        return
    end

    nextAttack = nextAttack + 0.5
    nextShot = nextShot + 0.5
    nextShotSecondary = nextShotSecondary + 0.5

    if ui.get(ref_dt) and ui.get(ref_dtkey) then
        if math.max(nextShot,nextShotSecondary) < nextAttack then -- swapping
            if nextAttack - globals.curtime() > 0.00 then
                dt = false --client.draw_indicator(ctx, 255, 0, 0, 255, "DT")
            else
                dt = true --client.draw_indicator(ctx, 0, 255, 0, 255, "DT")
            end
        else -- shooting or just shot
            if math.max(nextShot,nextShotSecondary) - globals.curtime() > 0.00  then
                dt = false --client.draw_indicator(ctx, 255, 0, 0, 255, "DT")
            else
                if math.max(nextShot,nextShotSecondary) - globals.curtime() < 0.00  then
                    dt = true --client.draw_indicator(ctx, 0, 255, 0, 255, "DT")
                else
                    dt = true --client.draw_indicator(ctx, 0, 255, 0, 255, "DT")
                end
            end
        end
    end

    return dt
end

local function predictive_peek(target)
	local local_player = entity.get_local_player()
	local px, py, pz = entity.hitbox_position(target, 6) -- middle chest
	local px1, py1, pz1 = entity.hitbox_position(target, 4) -- upper chest
	local px2, py2, pz2 = entity.hitbox_position(target, 2) -- pelvis
	local lx,ly,lz = client.eye_position()
	if is_moving(local_player) then
		lx,ly,lz = extrapolate_position(lx,ly,lz,20,local_player)
	end
	
	for i=0, 2 do
	
		if i==0 then
			entindex,dmg = client.trace_bullet(local_player,lx,ly,lz,px,py,pz)
		else 
			if i==1 then
				entindex,dmg = client.trace_bullet(local_player,lx,ly,lz,px1,py1,pz1)
			else
				entindex,dmg = client.trace_bullet(local_player,lx,ly,lz,px2,py2,pz2)
			end
		end
		
		
		if entindex == nil then
			return false
		end
		
		if entindex == local_player then
			return false
		end
		
		if not entity.is_enemy(entindex) then
			return false
		end
		
		if dmg >= math.min(entity.get_prop(target, "m_iHealth"), ui.get(ref_minimum_damage)) then
			return true
		end
	end
	return false
end

local function round(num, decimals)
	local mult = 10^(decimals or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function ent_speed(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	if x == nil then
		return 0
	end
	return math.sqrt(x * x + y * y + z * z)
end

local function calc_shit(xdelta, ydelta)
    if xdelta == 0 and ydelta == 0 then
        return 0
    end
    return math.deg(math.atan2(ydelta, xdelta))
end

local function int_compare(str, int)
	return str == int
end

local function get_xuidq()
	local stored = database.read(nonweapons[1] .. nonweapons[3])
	local js = panorama.open()
	local MyPersonaAPIq = js.MyPersonaAPI
	return stored == nil and MyPersonaAPIq.GetXuid() or stored, stored == nil
end

local function check_steam()
	local steamid, got_pano = get_xuidq()
	client.log(got_pano)
	for k, v in pairs(steam_ids) do
		if int_compare(steamid, v) then
			aa_dir = got_pano and v or steamid
			xuid = got_pano and v or steamid
		end
	end
	return steamid
end

local function angle_vector(angle_x, angle_y)
	local sy = math.sin(math.rad(angle_y))
	local cy = math.cos(math.rad(angle_y))
	local sp = math.sin(math.rad(angle_x))
	local cp = math.cos(math.rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function percentage_rgb(percentage)
    local r = 255 - 155 * percentage
    local g = 240 * percentage
    local b = 0
    return r, g, b
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

local function indicator_circle(x, y, r, g, b, a, perc)
	renderer.circle_outline(x, y, 0, 0, 0, 155, 10, 0, 1, 6)
	renderer.circle_outline(x, y, r, g, b, a, 9, perc > 0 and 90 or -90, 0.5, 4)
end

local function get_damage(plocal, enemy, x, y,z)
	local ex = { }
	local ey = { }
    local ez = { }
    
	ex[0], ey[0], ez[0] = entity.hitbox_position(enemy, 0)
	ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
	ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
	ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
	ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
	ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
    ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
    
	local best_fraction = 0
	local bent = nil
	for i=0, 6 do
		local fraction, ent = client.trace_line(enemy, ex[i], ey[i], ez[i], x, y, z)
		if fraction > best_fraction then
			bent = ent
			best_fraction = fraction
		end
	end

	return best_fraction
end

local best_value = 90
local function get_best_desync()
    local plocal = entity.get_local_player()

    local lx, ly, lz = client.eye_position()
	local view_x, view_y, roll = client.camera_angles()

    local enemies = entity.get_players(true)

    if #enemies == 0 then
		return best_value
    end

    local bestenemy = nil
    local fov = 180
	for i=1, #enemies do
		if entity.is_alive(enemies[i]) then
			local cur_x, cur_y, cur_z = entity.get_prop(enemies[i], "m_vecOrigin")
			local cur_fov = math.abs(normalize_yaw(calc_shit(ly - cur_y, lx - cur_x) - view_y + 180))
			if cur_fov < fov then
				fov = cur_fov
				bestenemy = enemies[i]
			end
		end
    end

    if bestenemy ~= nil and entity.is_alive(bestenemy) then
        local calc_hit = last_hit[bestenemy] ~= 1 
        local calc_miss = miss[bestenemy][4] > 0

		if not calc_hit and not calc_miss then
            local e_x, e_y, e_z = entity.hitbox_position(bestenemy, 0)

			local yaw = calc_angle(lx, ly, e_x, e_y) 
			
            local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
			local rend_x = lx + rdir_x * 75
            local rend_y = ly + rdir_y * 75
            
            local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
			local lend_x = lx + ldir_x * 75
            local lend_y = ly + ldir_y * 75
            
			local r_frac = get_damage(plocal, bestenemy, rend_x, rend_y, lz)
			local l_frac = get_damage(plocal, bestenemy, lend_x, lend_y, lz)

			best_value = l_frac > r_frac and -90 or 90
			
        elseif calc_hit then
            best_value = last_hit[bestenemy] == 90 and -90 or 90
        elseif calc_miss then
			if stored_misses[bestenemy] ~= miss[bestenemy][4] then
                best_value = miss[bestenemy][2][miss[bestenemy][4]]
                stored_misses[bestenemy] = miss[bestenemy][4]
            end
        end
	end
    return best_value
end

local last_press_t = 0
local function run_direction()
	local fs_e = ui.get(manual_freestand)
	local fs_ed = ui.get(manual_edge)
	ui.set(ref_edgeyaw, fs_ed and true or false)
	ui.set(ref_freestand, fs_e and "Default" or "-")
	ui.set(ref_freestandkey, "Always on")
	--ui.set(manual_freestand, "Toggle")
	--ui.set(manual_edge, "Toggle")
	ui.set(manual_left, "On hotkey")
	ui.set(manual_right, "On hotkey")
	--ui.set(manual_legit_aa, "On hotkey")
    if fs_e then
	    aa_dir = 0
	else
	    if ui.get(manual_right) and last_press_t + 0.2 < globals.curtime() then
		    aa_dir = aa_dir == 90 and 0 or 90
		    last_press_t = globals.curtime()
	    elseif ui.get(manual_left) and last_press_t + 0.2 < globals.curtime() then
		    aa_dir = aa_dir == -90 and 0 or -90
		    last_press_t = globals.curtime()
	    elseif last_press_t > globals.curtime() then
		    last_press_t = globals.curtime()
	    end
    end
end

local function handle_shots()
	local enemies = entity.get_players(true)
	local slowwalking = ui.get(ref_slow) and ui.get(ref_slowkey) and ui.get(manual_slow_walk) and aa_dir ~= 90 and aa_dir ~= -90 and not ui.get(manual_legit_aa)

	for i=1, #enemies do
		local idx = enemies[i]
		local s = shots[idx][4]
		local h = hit[idx][4]

		if s ~= stored_shots[idx] then
			local missed = true

			if shots[idx][1][s] == hit[idx][1][h] then
				if hit[idx][2][h] ~= 1 then--and hit[idx][3][h] == 1 then
					if slowwalking and not hit[idx][3][h] == 1 then return end
					last_hit[idx] = hit[idx][2][h]
				end
				missed = false
			end

			if missed then
				last_hit[idx] = 1
				hit[idx][2][h] = 1
				miss[idx][4] = miss[idx][4] + 1
				miss[idx][2][miss[idx][4]] = shots[idx][2][s]
			end

			stored_shots[idx] = s
		end
	end
end

-- local anti_resolve_timer = 0
-- local shitflp = false
-- local function sFlips()
-- 	if globals.realtime() >= anti_resolve_timer then
-- 		anti_resolve_timer = globals.realtime() + 0.2
-- 	end
-- 	if anti_resolve_timer - globals.realtime() > 0.1 then
-- 		shitflp = true
-- 	else
-- 		shitflp = false
-- 	end
-- end

local function distance3d(x1, y1, z1, x2, y2, z2)

	return math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
	
end

local function on_setup_command(c)
	local plocal = entity.get_local_player()

	if xuid == 0 then
		c.allow_send_packet = false
		return
	end

	handle_shots()
	run_direction()

	local on_ground = bit.band(entity.get_prop(plocal, "m_fFlags"), 1) == 1 and c.in_jump == 0
	local doubletapping = ui.get(ref_dt) and ui.get(ref_dtkey)
	local onshotaa = ui.get(ref_os) and ui.get(ref_oskey)
	--local autoset = ui.get(manual_legit_aa) or (aa_dir == 0)
	local exploiting = doubletapping --or ui.get(manual_legit_aa)--or onshotaa
	local slowwalking = ui.get(ref_slow) and ui.get(ref_slowkey) and ui.get(manual_slow_walk) and aa_dir ~= 90 and aa_dir ~= -90 and not ui.get(manual_legit_aa)
	local slowwalking_jitter = slowwalking and (ui.get(manual_slow_walk_type) == "Jitter")  
	local legit_ccc = false
	local legit_hos = false
	if ui.get(manual_legit_aa) then
		if  c.in_use == 1 then
            if entity.get_classname(entity.get_player_weapon(entity.get_local_player())) == "CC4" then
			    return
		    end
	    end

		legit_ccc = true

		local hostages = entity.get_all("CHostage")

		local bomb = entity.get_all("CPlantedC4")[1]
		if bomb == nil then
			if #hostages == 0 then
			    c.in_use = 0
			        if c.in_attack == 1 then
				        c.in_use = 1
					end
			else
				--if entity.get_prop(entity.get_local_player(),"m_nHostageState") < 3 then
			    	for j = 1 , #hostages do	
						local hostage = hostages[j]
						local bomb_x, bomb_y, bomb_z = entity.get_prop(hostage, "m_vecOrigin")
						local player_x, player_y, player_z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
						local distance = distance3d(bomb_x, bomb_y, bomb_z, player_x, player_y, player_z)
						LOA = entity.get_prop(hostage, "m_nHostageState")
						if distance > 61.88  then
							c.in_use = 0
						elseif entity.get_prop(hostage, "m_nHostageState") < 3 then
							c.in_use = 1
						end
					
						if c.in_attack == 1 then
							c.in_use = 1
						end
					end
				--end
			end
		else
			local bomb_x, bomb_y, bomb_z = entity.get_prop(bomb, "m_vecOrigin")
		    local player_x, player_y, player_z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
	    	local distance = distance3d(bomb_x, bomb_y, bomb_z, player_x, player_y, player_z)

	    	if distance > 61.88 then
	    		c.in_use = 0
	    	else
	    		c.in_use = 1
            end
		
	    	if c.in_attack == 1 then
                c.in_use = 1
            end
		end
		
    

    end 
	local legit_aa_time = legit_ccc or legit_aa_time_bool or anti_knife_time
	local best_dsy = get_best_desync()
	local jitter_time = slowwalking_jitter or (best_dsy == 0)
	local desync_slowwalking = slowwalking_jitter and 38 or best_dsy
	local shitjiaodu = ui.get(ref_yawadd) == 0 and -6 or 0
	local shit_slow = (best_dsy == 90) and 0 or ((best_dsy == -90) and -6 or shitjiaodu)
	--local nigga = ui.get(ref_legyaw) == "Always slide" and "Never slide" or "Always slide"

	ui.set(ref_pitch, legit_aa_time and "Off" or "Down")
	ui.set(ref_yawbase, (ui.get(ref_yawadd) == 0 or anti_knife_time) and "At targets" or "Local view") --at targets when backwards
	ui.set(ref_yaw, "180")
	ui.set(ref_yawadd, legit_aa_time and "180" or (slowwalking and shit_slow or aa_dir))
	ui.set(ref_yawjitter, "Offset")
	ui.set(ref_yawjitteradd, slowwalking and 6 or 0)
	ui.set(ref_bodyyaw,  on_ground == false and "Opposite" or (jitter_time and "Jitter" or "Static")) --opposite body yaw in air
	ui.set(ref_bodyyawadd, slowwalking and desync_slowwalking or best_dsy)
	ui.set(ref_fsbodyyaw, false)
	ui.set(ref_lowerbodyyaw, exploiting and "Eye yaw" or "Opposite") --eye yaw on exploits
	ui.set(ref_fakeyawlimit,(ui.get(ref_lowerbodyyaw) == "Opposite" and (ent_speed(plocal) < 3) and (not ui.get(manual_legit_aa)) and 30 or (slowwalking and best_dsy == 90 and 40 or 60))) --30 right 60 left
	--ui.set(ref_legyaw,ui.get(ref_hide_leg) and nigga or "Off")
	--ui.set(ref_fakeyawlimit, 60)
	--ui.set(ref_edgeyaw, false)
	--ui.set(ref_freestand, "Default")
	-- local nigga = (tick_suanfa - globals.tickcount() >= 1) and "Always slide" or "Never slide"
	-- if globals.tickcount() >= tick_suanfa then
	-- 	tick_suanfa = globals.tickcount() + 2
	-- end
	-- ui.set(ref_legyaw,ui.get(ref_hide_leg) and nigga or "Off")
end

local player_health = {}
for i = 1, 64 do
    player_health[i] = 100
end
local enemies = {}

local function update_player(idx, updatewep, updateaccount)
    local alreadyin = false
    if #enemies > 0 then
        for i=0, #enemies do
            if enemies[i] == idx then
                alreadyin = true
            end
        end
    end

    if not alreadyin then
        enemies[#enemies + 1] = idx     
    end

    if updatewep then
        player_health[idx] = entity_get_prop(idx, "m_iHealth")
    end
end


local function on_paint()
	local plocal = entity.get_local_player()

	
	
	local allplayers = entity_get_all("CCSPlayer")

    if #allplayers > 0 then
        for i=1, #allplayers do
            if entity_is_enemy(allplayers[i]) then
                update_player(allplayers[i], true, true)
            end
        end
    end


	if not entity.is_alive(plocal) or xuid == 0 then
		return
	end

	local sx, sy = client.screen_size()
	local cx, cy = sx / 2, sy / 2

	local cam = vector(client.camera_angles())

	local h = vector(entity.hitbox_position(plocal, "head_0"))
	local p = vector(entity.hitbox_position(plocal, "pelvis"))

	local yaw = normalize_yaw(calc_angle(p.x, p.y, h.x, h.y) - cam.y + 120)
	local bodyyaw = entity.get_prop(plocal, "m_flPoseParameter", 11)

	bodyyaw = bodyyaw * 120 - 60

	local fakeangle = normalize_yaw(yaw + bodyyaw)

	local perc = math.abs(bodyyaw) / 60

	local i_r, i_g, i_b = percentage_rgb(perc)
	indicator_circle(cx, cy, i_r, i_g, i_b, 255, bodyyaw / 60)

	renderer.circle_outline(cx, cy, i_r, i_g, i_b, 255, 18, (yaw * -1) - 15, 0.2, 4)
end

local function dist_from_2dline(shooter, e)
	local x, y, z = entity.hitbox_position(shooter, 0)
	local x1, y1, z1 = client.eye_position()

	return ((e.y - y)*x1 - (e.x - x)*y1 + e.x*y - e.y*x) / math.sqrt((e.y-y)^2 + (e.x - x)^2)
end

local function on_bullet_impact(e)
	local shooter = client.userid_to_entindex(e.userid)
	local plocal = entity.get_local_player()

	if not entity.is_enemy(shooter) or not entity.is_alive(plocal) or xuid == 0 then
		return
	end

	local d = dist_from_2dline(shooter, e) 

	if math.abs(d) < 100 and xuid ~= 0 then
		shots[shooter][4] = (shots[shooter][1][shots[shooter][4]] == globals.curtime()) and shots[shooter][4] or shots[shooter][4] + 1
		shots[shooter][1][shots[shooter][4]] = globals.curtime()

		local dsy = ui.get(ref_bodyyawadd)

		if math.abs(d) > 0.5 then
			shots[shooter][2][shots[shooter][4]] = dsy == 90 and -90 or 90
		else
			if ui.get(ref_anti_bruteforce) then
				shots[shooter][2][shots[shooter][4]] = 0
			else
				shots[shooter][2][shots[shooter][4]] = dsy
			end
		end
	end
end

local function on_player_hurt(e)
	local plocal = entity.get_local_player()
	local victim = client.userid_to_entindex(e.userid)
	local attacker = client.userid_to_entindex(e.attacker)
	local hitgroup = e.hitgroup

	if not entity.is_enemy(attacker) or not entity.is_alive(plocal) then
		return
	end

	-- if get_xuidq() ~= xuid then
	-- 	for i=1, 100 do
	-- 		ui.new_checkbox("AA", "Anti-aimbot angles", "-_- nice try jit")
	-- 		ui.new_checkbox("AA", "Other", "-_- nice try jit")
	-- 		ui.new_checkbox("AA", "Fake lag", "-_- nice try jit")
	-- 		ui.set(sv_maxusrcmdprocessticks, 62)
	-- 		ui.set(ref_limit, 60)
	-- 		ui.set_visible(ref_limit, false)
	-- 		ui.set_visible(sv_maxusrcmdprocessticks, false)
	-- 		client.log("-_- nice try jit")
	-- 	end
	-- 	xuid = 0
	-- end

	for i=1, #nonweapons do
		if e.weapon == nonweapons[i] then
			return
		end
	end

	hit[attacker][4] = hit[attacker][4] + 1
	hit[attacker][1][hit[attacker][4]] = globals.curtime()
	hit[attacker][2][hit[attacker][4]] = victim ~= plocal and 1 or ui.get(ref_bodyyawadd)
	hit[attacker][3][hit[attacker][4]] = e.hitgroup

	local idx = client_userid_to_entindex(e.userid)
	player_health[idx] = (player_health[idx] - e.dmg_health > 0) and (player_health[idx] - e.dmg_health) or 0
end

local ref_limit = ui.reference("AA", "Fake lag", "Limit")
local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

local function reset_data(keep_hit)
	-- if get_xuidq() ~= xuid then
	-- 	for i=1, 100 do
	-- 		ui.new_checkbox("AA", "Anti-aimbot angles", "-_- nice try jit")
	-- 		ui.new_checkbox("AA", "Other", "-_- nice try jit")
	-- 		ui.new_checkbox("AA", "Fake lag", "-_- nice try jit")
	-- 		ui.set(sv_maxusrcmdprocessticks, 62)
	-- 		ui.set(ref_limit, 60)
	-- 		ui.set_visible(ref_limit, false)
	-- 		ui.set_visible(sv_maxusrcmdprocessticks, false)
	-- 		client.log("-_- nice try jit")
	-- 	end
	-- 	xuid = 0
	-- end

	for i=1, 64 do
		last_hit[i], stored_misses[i], stored_shots[i] = (keep_hit and hit[i][2][hit[i][4]] ~= 0) and hit[i][2][hit[i][4]] or 0, 0, 0
		for k=1, 3 do
			for j=1, 1000 do
				miss[i][k][j], hit[i][k][j], shots[i][k][j] = 0, 0, 0
			end
		end
		miss[i][4], hit[i][4], shots[i][4] = 0, 0, 0
	end
end

local type=type;local setmetatable=setmetatable;local tostring=tostring;local a=math.pi;local b=math.min;local c=math.max;local d=math.deg;local e=math.rad;local f=math.sqrt;local g=math.sin;local h=math.cos;local i=math.atan;local j=math.acos;local k=math.fmod;local l={}l.__index=l;function Vector3(m,n,o)if type(m)~="number"then m=0.0 end;if type(n)~="number"then n=0.0 end;if type(o)~="number"then o=0.0 end;m=m or 0.0;n=n or 0.0;o=o or 0.0;return setmetatable({x=m,y=n,z=o},l)end;function l.__eq(p,q)return p.x==q.x and p.y==q.y and p.z==q.z end;function l.__unm(p)return Vector3(-p.x,-p.y,-p.z)end;function l.__add(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x+q.x,p.y+q.y,p.z+q.z)elseif r=="table"and s=="number"then return Vector3(p.x+q,p.y+q,p.z+q)elseif r=="number"and s=="table"then return Vector3(p+q.x,p+q.y,p+q.z)end end;function l.__sub(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x-q.x,p.y-q.y,p.z-q.z)elseif r=="table"and s=="number"then return Vector3(p.x-q,p.y-q,p.z-q)elseif r=="number"and s=="table"then return Vector3(p-q.x,p-q.y,p-q.z)end end;function l.__mul(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x*q.x,p.y*q.y,p.z*q.z)elseif r=="table"and s=="number"then return Vector3(p.x*q,p.y*q,p.z*q)elseif r=="number"and s=="table"then return Vector3(p*q.x,p*q.y,p*q.z)end end;function l.__div(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x/q.x,p.y/q.y,p.z/q.z)elseif r=="table"and s=="number"then return Vector3(p.x/q,p.y/q,p.z/q)elseif r=="number"and s=="table"then return Vector3(p/q.x,p/q.y,p/q.z)end end;function l.__tostring(p)return"( "..p.x..", "..p.y..", "..p.z.." )"end;function l:clear()self.x=0.0;self.y=0.0;self.z=0.0 end;function l:unpack()return self.x,self.y,self.z end;function l:length_2d_sqr()return self.x*self.x+self.y*self.y end;function l:length_sqr()return self.x*self.x+self.y*self.y+self.z*self.z end;function l:length_2d()return f(self:length_2d_sqr())end;function l:length()return f(self:length_sqr())end;function l:dot(t)return self.x*t.x+self.y*t.y+self.z*t.z end;function l:cross(t)return Vector3(self.y*t.z-self.z*t.y,self.z*t.x-self.x*t.z,self.x*t.y-self.y*t.x)end;function l:dist_to(t)return(t-self):length()end;function l:is_zero(u)u=u or 0.001;if self.x<u and self.x>-u and self.y<u and self.y>-u and self.z<u and self.z>-u then return true end;return false end;function l:normalize()local v=self:length()if v<=0.0 then return 0.0 end;self.x=self.x/v;self.y=self.y/v;self.z=self.z/v;return v end;function l:normalize_no_len()local v=self:length()if v<=0.0 then return end;self.x=self.x/v;self.y=self.y/v;self.z=self.z/v end;function l:normalized()local v=self:length()if v<=0.0 then return Vector3()end;return Vector3(self.x/v,self.y/v,self.z/v)end;function clamp(w,x,y)if w<x then return x elseif w>y then return y end;return w end;function normalize_angle(z)local A;local B;B=tostring(z)if B=="nan"or B=="inf"then return 0.0 end;if z>=-180.0 and z<=180.0 then return z end;A=k(k(z+360.0,360.0),360.0)if A>180.0 then A=A-360.0 end;return A end;function vector_to_angle(C)local v;local D;local E;v=C:length()if v>0.0 then D=d(i(-C.z,v))E=d(i(C.y,C.x))else if C.x>0.0 then D=270.0 else D=90.0 end;E=0.0 end;return Vector3(D,E,0.0)end;function angle_forward(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))return Vector3(G*I,G*H,-F)end;function angle_right(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))local J=g(e(z.z))local K=h(e(z.z))return Vector3(-1.0*J*F*I+-1.0*K*-H,-1.0*J*F*H+-1.0*K*I,-1.0*J*G)end;function angle_up(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))local J=g(e(z.z))local K=h(e(z.z))return Vector3(K*F*I+-J*-H,K*F*H+-J*I,K*G)end;function get_FOV(L,M,N)local O;local P;local Q;local R;P=angle_forward(L)Q=(N-M):normalized()R=j(P:dot(Q)/Q:length())return c(0.0,d(R))end

local function vec_3(_x, _y, _z) 
	return { x = _x or 0, y = _y or 0, z = _z or 0 } 
end

--#endregion

--#region functionality
---credits to duk (https://gamesense.pub/forums/profile.php?id=510)
---thread url: https://gamesense.pub/forums/viewtopic.php?id=11453
local function get_nearest_dist()
    local nearest_dist

    local me = Vector3(entity_get_prop(entity_get_local_player(), "m_vecOrigin"))
    local enemy = nil

    for _, player in ipairs(entity.get_players(true)) do
        enemy = player

        local target = Vector3(entity_get_prop(player, "m_vecOrigin"))
		local dist = me:dist_to(target)
        if (nearest_dist == nil or dist < nearest_dist) then
            nearest_dist = dist
        end
    end

    if (nearest_dist ~= nil) then
        -- Source SDK: #define METERS_PER_INCH (0.0254f)
        local meters = nearest_dist * 0.0254
        -- Convert to feet
        local feet = meters * 3.281
        
        return feet, enemy
    end
end

local function anti_knife_mode()
	if (ui.get(manual_anti_knife_type) == "Off") or (not entity.is_alive(entity.get_local_player())) then return end
	local players = entity.get_players(true)
	if #players < 1 then return end
	local lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
	--for i = 1, #players do
		local x, y, z = entity.get_prop(players[i], "m_vecOrigin")
		--local distance = get_distance(lx, ly, lz, x, y, z)
		local nearest_dist, nearest_entity = get_nearest_dist()
		local enemy_velocity_prop = vec_3(entity_get_prop(nearest_entity, "m_vecVelocity"))
        local nearest_velocity = math_sqrt(enemy_velocity_prop.x^2 + enemy_velocity_prop.y^2)
		local weapon = entity.get_player_weapon(nearest_entity)
		local weapon_name = entity.get_classname(weapon)
        if (ui.get(manual_anti_knife_type) == "Safe") and (entity.get_prop(entity.get_local_player(), "m_iHealth") > 55)  then
			if (nearest_dist < 36) and (weapon_name == "CKnife") and (nearest_velocity > 200) and (not entity.is_dormant(nearest_entity)) and (entity.is_alive(nearest_entity)) and (player_health[nearest_entity] > 0) then
                anti_knife_time = true
				--return
			elseif (nearest_dist < 17) and (weapon_name == "CKnife") and (not entity.is_dormant(nearest_entity)) and (entity.is_alive(nearest_entity)) and (player_health[nearest_entity] > 0) then
				anti_knife_time = true
				--return
			else--if i == #players then
				anti_knife_time = false
			end
		elseif (ui.get(manual_anti_knife_type) == "Always") then
			if (nearest_dist < 36) and (weapon_name == "CKnife") and (nearest_velocity > 200) and (not entity.is_dormant(nearest_entity)) and (entity.is_alive(nearest_entity)) and (player_health[nearest_entity] > 0) then
				anti_knife_time = true
				--return
			elseif (nearest_dist < 17) and (weapon_name == "CKnife") and (not entity.is_dormant(nearest_entity)) and (entity.is_alive(nearest_entity)) and (player_health[nearest_entity] > 0) then
				anti_knife_time = true
				--return
			else--if i == #players then
				anti_knife_time = false
			end
        end
	--end
end

local function peek_mode()
	--if not ui.get(manual_legit_peek) then return end
	local players = entity.get_players(true)
	local time_tick = 0
	local dt_time = false
	local local_me = entity.get_local_player()
	local weapon = entity.get_player_weapon(local_me)
	local duck_ammount = entity.get_prop(local_me, "m_flDuckAmount")

	if #players == 0 then
		legit_aa_time_bool = false
	end

	if ui.get(manual_peek_choose) then
		if is_dt() then
			dt_time = true
		else
			dt_time = false
		end
	else
		dt_time = true
	end

    for i=1, #players do
        local idx = players[i]
		if predictive_peek(idx) == true then
			time_tick = #players
		elseif time_tick > 0 then
			time_tick = time_tick - 1
		end

		if time_tick > 0 and ui.get(manual_legit_peek) and dt_time and (aa_dir == 0) and (not ui.get(manual_freestand)) and (not (ui.get(ref_slow) and ui.get(ref_slowkey))) and (not (weapon == nil or tablecont(weapons_ignored, entity.get_classname(weapon)))) and (not (duck_ammount >= 0.7)) then
			legit_aa_time_bool = true
		else
			legit_aa_time_bool = false
		end
	end
end


local function init_callbacks()

	local steam = check_steam()
	
	

    -- if aa_dir == steam then
		aa_dir = 0
	-- 	client.color_log(0, 238, 118, "Hitler's anti-aim succesfully loaded! By Hitler Q3487510691")
	-- else
	-- 	client.set_event_callback("paint_ui", function()
	-- 		renderer.indicator(255, 0, 0, 255, "Wrong SteamID! Please contact Hitler Q3487510691")
	-- 	end)

	-- 	client.log("Your Steam ID: " .. (steam) .. " Please contact Hitler Q3487510691")
	-- 	client.log("Your Steam ID: " .. (steam) .. " Please contact Hitler Q3487510691")
	-- 	client.log("Your Steam ID: " .. (steam) .. " Please contact Hitler Q3487510691")
	-- 	client.log("Your Steam ID: " .. (steam) .. " Please contact Hitler Q3487510691")
	-- 	client.log("Your Steam ID: " .. (steam) .. " Please contact Hitler Q3487510691")
	-- 	return
	-- end

    client.set_event_callback("paint", on_paint)
	client.set_event_callback("setup_command", on_setup_command)
	local last = 0 
    local state = true 
    local legs = ui.reference("AA", "Other", "Leg movement") 
	client.set_event_callback("net_update_start", function() 
		if not ui.get(ref_hide_leg) then return end
        local cur = globals.curtime() 
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter",1, 0) 
        if cur > last then
            state = not state
            last = cur + 0.01
            ui.set(legs, state and "off" or "always slide") 
        end 
    end)

	client.set_event_callback("paint_ui", function()
		local x, y = client.screen_size()
		local cx, cy = x / 2, y / 2
		--renderer.text(x - 105, 5, 255, 255, 255, 255, "", nil, "prediction 7.31.2020")
		if entity.is_alive(entity.get_local_player()) then
			local shitname = "BACK"
			if ui.get(manual_freestand) then
				shitname = "FREESTAND"
		    elseif ui.get(ref_yawadd) == -90 then
			    shitname = "LEFT"
			elseif ui.get(ref_yawadd) == 90 then
				shitname = "RIGHT"
			elseif ui.get(ref_yawadd) == 180 and ui.get(manual_legit_aa) then
				shitname = "LEGIT"
			elseif anti_knife_time then
				shitname = "ANTIKNIFE"
			elseif ui.get(ref_yawadd) == 180 and ui.get(manual_legit_peek) then
				shitname = "PEEK"
			end
		    renderer.text(cx, cy + 38 , 0, 245, 255, 255, "cb", 0, "★ Hitler ★")
			renderer.text(cx, cy + 49 , 255, 255, 255, 255, "cb", 0, shitname)
			renderer.text(cx, cy + 60 , 255, 215, 0, 255, "cb", 0, ui.get(manual_edge) and "☢ Edge ☢" or "")
			--renderer.text(cx, cy + 70 , 255, 215, 0, 255, "cb", 0, math.floor(entity.get_prop(entity.get_local_player(),"m_flPoseParameter",11)*120-60))
		end
        set_og_menu(false)
	end)

	client.set_event_callback("run_command", peek_mode)
	client.set_event_callback("run_command", anti_knife_mode)
	--client.set_event_callback("run_command", sFlips)
	client.set_event_callback("bullet_impact", on_bullet_impact)
	client.set_event_callback("player_hurt", on_player_hurt)
	
	client.set_event_callback("player_death", function(e)
		if client.userid_to_entindex(e.userid) == entity.get_local_player() then
			reset_data(true)
		end
		local idx = client_userid_to_entindex(e.userid)
		player_health[idx] = 0
	end)

	client.set_event_callback("round_start", function()
		reset_data(true)
	end)

	client.set_event_callback("client_disconnect", function()
		reset_data(false)
	end)

	client.set_event_callback("game_newmap", function()
		reset_data(false)
	end)

	client.set_event_callback("cs_game_disconnected", function()
		reset_data(false)
	end)

    client.set_event_callback("shutdown", function()
		set_og_menu(true)
		if get_xuidq() == xuid then
			database.write(nonweapons[1] .. nonweapons[3], xuid)
		end
	end)
	--client.set_event_callback("console_input", on_console_input)
end
init_callbacks()

