--[[
	id: WXG_isw-1d0FTxO-PQkXX
	name: aaa
	description: aaa
	time1: 2021-07-19 23:36:23.034017+00
	time2: 2021-07-19 23:36:23.034017+00
	uploader: rVteJdqLrFoVla1DK6wCZwRG_FIt92uTzdvKGXcP
	uploadersession: 5Qd-H4oXHrkS7xhu4H3A0kDb1pJq5l
	flag: f
--]]

local bit = require("bit")
local vector = require("vector")
local ffi = require("ffi")
local http = require("gamesense/http")
local surface = require("gamesense/surface")
local steamworks = require("gamesense/steamworks")
local ISteamNetworking = steamworks.ISteamNetworking

local interface_ptr = ffi.typeof('void***')
local latency_ptr = ffi.typeof('float(__thiscall*)(void*, int)')

local rawivengineclient = client.create_interface('engine.dll', 'VEngineClient014') or error('VEngineClient014 wasnt found', 2)
local ivengineclient = ffi.cast(interface_ptr, rawivengineclient) or error('rawivengineclient is nil', 2)

local get_net_channel_info = ffi.cast('void*(__thiscall*)(void*)', ivengineclient[0][78]) or error('ivengineclient is nil')
local is_in_game = ffi.cast('bool(__thiscall*)(void*)', ivengineclient[0][26]) or error('is_in_game is nil')

local notes = (function(b)local c=function(d,e)local f={}for g in pairs(d)do table.insert(f,g)end;table.sort(f,e)local h=0;local i=function()h=h+1;if f[h]==nil then return nil else return f[h],d[f[h]]end end;return i end;local j={get=function(k)local l,m=0,{}for n,o in c(package.cnotes)do if o==true then l=l+1;m[#m+1]={n,l}end end;for p=1,#m do if m[p][1]==b then return k(m[p][2]-1)end end end,set_state=function(q)package.cnotes[b]=q;table.sort(package.cnotes)end,unset=function()client.unset_event_callback('shutdown',callback)end}client.set_event_callback('shutdown',function()if package.cnotes[b]~=nil then package.cnotes[b]=nil end end)if package.cnotes==nil then package.cnotes={}end;return j end)('technology_watermark')

local aa_state = ui.reference("AA", "Anti-aimbot angles", "Enabled")
local aa_yaw, aa_yaw_offset = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local aa_yaw_jitter, aa_yaw_jitter_offset = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local aa_yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local aa_fake_yaw, aa_fake_yaw_slider = ui.reference("AA", "Anti-aimbot angles", "body yaw")
local aa_fs_byaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local aa_fs_triggers, aa_fs_key = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local aa_body_limit = ui.reference("AA", "Anti-aimbot angles", "fake yaw limit")
local aa_edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
local aa,fake_walk = ui.reference("AA", "other", "slow motion")
local aa_pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local misc_doubletap,doubletap = ui.reference("rage", "other", "double tap")
local misc_onshot, misc_onshot_aa = ui.reference("AA", "Other", "On shot anti-aim")
local misc_fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
local fl_amount = ui.reference("AA", "fake lag", "amount")
local fl_limit = ui.reference("AA", "fake lag", "limit")
local fl_var = ui.reference("AA", "fake lag", "variance")
local sw, slowmotion = ui.reference("AA", "other", "slow motion")
local silentaa = ui.reference("RAGE", "Aimbot", "Silent aim")
local legm = ui.reference("AA", "Other", "Leg movement")

local data = {
    side = 1,
    last_side = 0,

    last_hit = 0,
    hit_side = 0
}
local angle = 0
local change = globals.curtime()
local js = panorama.open()
local _ = js['$']
local MyPersonaAPI = js.MyPersonaAPI

local enable = ui.new_checkbox("AA","Anti-aimbot angles","-> Active Anti-Aim <-")
local attargets = ui.new_hotkey("AA","Anti-aimbot angles","-> At Target Key <-")
local freestandtype = ui.new_combobox("AA","Anti-aimbot angles","-> Freestand Type <-","Peek Fake","Peek Real")
local autodiradd = ui.new_multiselect("AA","Anti-aimbot angles","-> Freestanding Additions <-", "Better yaw for peek", "Jitter if dangerous")
local legfucker = ui.new_combobox("AA","Anti-aimbot angles","-> Leg Movement <-","Jitter","Random","Always slide","Default")
local ui_left = ui.new_hotkey("AA","Anti-aimbot angles", "-> Left Key <-")
local ui_right = ui.new_hotkey("AA","Anti-aimbot angles", "-> Right Key <-")
local ui_back = ui.new_hotkey("AA","Anti-aimbot angles", "-> Backward Key <-")
local label = ui.new_label("AA","Anti-aimbot angles","-> Color <-")
local color0 = ui.new_color_picker("AA","Anti-aimbot angles","Indicator",130, 165, 255, 255)
local dton = ui.new_checkbox("AA","Anti-aimbot angles","-> Enable doubletap <-")
local dttypes = ui.new_combobox("AA","Anti-aimbot angles","-> Double tap mode <-", "Dynamic", "Standart", "Fast", "Instant")
local sv_clockcorrection_msecs = ui.reference("MISC", "Settings", "sv_clockcorrection_msecs")
local sv_maxunlag_reference = ui.reference("MISC", "Settings", "sv_maxunlag")
local sv_maxusrcmdprocessticks_holdaim = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim")
local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local flon = ui.new_checkbox("AA","Fake lag","-> Techno lag <-")
local sendpacket = ui.new_slider("AA","Fake lag","-> Send Amount <-",1,15,11)
local chokepacket = ui.new_slider("AA","Fake lag","-> Choke Amount <-",1,16,15)
local dangerouslaggin = ui.new_checkbox("AA","Fake lag","-> Dangerous Lag On Peek <-")
local dangerouslagamount = ui.new_slider("AA","Fake lag","-> Dangerous Lag Amount <-",17,60,24)
local dangerouslagfq = ui.new_slider("AA","Fake lag","-> Dangerous Lag Frequency <-",30,200,30)
local enableflchams = ui.new_checkbox("AA","Fake lag","Enable Fake Lag Chams")

luauser = "unknown"
build = "unknown"
left_dir = false
right_dir = false
back_dir = true
should_swap = 0
flipJitter = true
real_antibruteforce = false
real_freestand = false
right_side = false
left_side = false
adopted = 0
ui.set_visible(aa_yaw,false)
ui.set_visible(aa_yaw_offset,false)
ui.set_visible(aa_yaw_jitter,false)
ui.set_visible(aa_yaw_jitter_offset,false)
ui.set_visible(aa_yaw_base,false)
ui.set_visible(aa_fake_yaw,false)
ui.set_visible(aa_fake_yaw_slider,false)
ui.set_visible(aa_fs_byaw,false)
ui.set_visible(aa_body_limit,false)
ui.set_visible(fl_amount,false)
ui.set_visible(fl_limit,false)
ui.set_visible(fl_var,false)

http.get("https://pastebin.com/raw/ck2srHKk", function(success, response)
    if not success or response.status ~= 200 then
      return
    end
    steamidcloud1 = response.body
end)

http.get("https://pastebin.com/raw/EsEniDes", function(success, response)
    if not success or response.status ~= 200 then
      return
    end
    steamidcloud2 = response.body
end)

http.get("https://pastebin.com/raw/FKYDxNeE", function(success, response)
    if not success or response.status ~= 200 then
      return
    end
    steamidcloud3 = response.body
end)

http.get("https://pastebin.com/raw/Xn8KKcAW", function(success, response)
    if not success or response.status ~= 200 then
      return
    end
    steamidcloud4 = response.body
end)

http.get("https://pastebin.com/raw/h0cFLCKx", function(success, response)
    if not success or response.status ~= 200 then
      return
    end
    steamidcloud5 = response.body
end)

http.get("https://pastebin.com/raw/GYxNT9v6", function(success, response)
    if not success or response.status ~= 200 then
      return
    end
    steamidcloud6 = response.body
end)

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
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

local function is_crouching(player)
    local flags = entity.get_prop(player, "m_fFlags")
    
    if bit.band(flags, 4) == 4 then
        return true
    end
    
    return false
end

local function in_air(player)
    local flags = entity.get_prop(player, "m_fFlags")
    
    if bit.band(flags, 1) == 0 then
        return true
    end
    
    return false
end

local function getspeed(player_index)
    return vector(entity.get_prop(player_index, "m_vecVelocity")):length()
end

local function distance_3d(x1,y1,z1,x2,y2,z2)
    return math.sqrt( (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) )
end

local function extrapolate(player , ticks , x,y,z )
local xv,yv,zv =  entity.get_prop(player, "m_vecVelocity")
local new_x = x + globals.tickinterval() * xv * ticks
local new_y = y + globals.tickinterval() * yv * ticks
local new_z = z + globals.tickinterval() * zv * ticks
return new_x,new_y,new_z

end

local function is_enemy_peeking(player)
    local vx,vy,vz = entity.get_prop(player, "m_vecVelocity")
    local speed = math.sqrt(vx*vx + vy*vy + vz*vz)
    if speed < 5 then
        return false
    end
    local ex,ey,ez = entity.get_origin(player)
    local lx,ly,lz = entity.get_origin(entity.get_local_player())
    local start_distance = math.abs(distance_3d(ex,ey,ez,lx,ly,lz))
    local smallest_distance = 999999
    for ticks = 1,25 do

        local tex,tey,tez = extrapolate(player,ticks,ex,ey,ez)
        local distance = math.abs(distance_3d(tex,tey,tez,lx,ly,lz))

        if distance < smallest_distance then
            smallest_distance = distance
        end
        if smallest_distance < start_distance then
            return true
        end
    end
    --client.log(smallest_distance .. "      " .. start_distance)
    return smallest_distance < start_distance
end

local function is_local_peeking_enemy(player)
    local vx,vy,vz = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
    local speed = math.sqrt(vx*vx + vy*vy + vz*vz)
    if speed < 5 then
        return false
    end
    local ex,ey,ez = entity.get_origin(player)
    local lx,ly,lz = entity.get_origin(entity.get_local_player())
    local start_distance = math.abs(distance_3d(ex,ey,ez,lx,ly,lz))
    local smallest_distance = 999999
    for ticks = 1,25 do

        local tex,tey,tez = extrapolate(entity.get_local_player(),ticks,lx,ly,lz)
        local distance = distance_3d(ex,ey,ez,tex,tey,tez)

        if distance < smallest_distance then
            smallest_distance = math.abs(distance)
        end
    if smallest_distance < start_distance then
            return true
        end
    end
    return smallest_distance < start_distance
end

local function GetClosestPoint(A, B, P)
    local a_to_p = { P[1] - A[1], P[2] - A[2] }
    local a_to_b = { B[1] - A[1], B[2] - A[2] }

    local atb2 = a_to_b[1]^2 + a_to_b[2]^2

    local atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
    local t = atp_dot_atb / atb2
        
    return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end

client.set_event_callback("bullet_impact", function(c)
    if entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
            local ab_range = 32
            if math.abs(delta_2d) < ab_range then
                should_swap = globals.curtime()
                if ui.get(aa_fake_yaw_slider) < 0 then
                    left_side = true
                    right_side = false
                elseif ui.get(aa_fake_yaw_slider) > 0 then
                    right_side = true
                    left_side = false
                end
            end
        end
    end
end)

local last_press_t = globals.curtime()

client.set_event_callback("setup_command", function(e)
    if steamworks.SteamID(MyPersonaAPI.GetXuid()) == "76561199190566658" then
        luauser = "zajzol"
        build = "BETA"
        adopted = 1
    elseif steamworks.SteamID(MyPersonaAPI.GetXuid()) == steamidcloud2 then
        luauser = "White"
        build = "BETA"
        adopted = 1
	elseif steamworks.SteamID(MyPersonaAPI.GetXuid()) == steamidcloud3 or steamworks.SteamID(MyPersonaAPI.GetXuid()) == steamidcloud4 then 
        luauser = "Relize"
        build = "BETA"
        adopted = 1
    elseif steamworks.SteamID(MyPersonaAPI.GetXuid()) == steamidcloud5 then 
        luauser = "davvid"
        build = "BETA"
        adopted = 1
    elseif steamworks.SteamID(MyPersonaAPI.GetXuid()) == steamidcloud6 then 
        luauser = "starix"
        build = "BETA"
        adopted = 1
    else
        luauser = "unknown"
        build = "unknown"
        adopted = 0
    end
    if adopted == 1 and ui.get(enable) then
    if ui.get(ui_back) then
        back_dir = true
        right_dir = false
        left_dir = false
        last_press_t = globals.curtime()
    elseif ui.get(ui_right) then
        if right_dir == true and last_press_t + 0.02 < globals.curtime() then
        back_dir = true
        right_dir = false
        left_dir = false
        elseif right_dir == false and last_press_t + 0.02 < globals.curtime() then
        right_dir = true
        back_dir = false
        left_dir = false
        end
        last_press_t = globals.curtime()
    elseif ui.get(ui_left) then
        if left_dir == true and last_press_t + 0.02 < globals.curtime() then
        back_dir = true
        right_dir = false
        left_dir = false
        elseif left_dir == false and last_press_t + 0.02 < globals.curtime() then
        left_dir = true
        back_dir = false
        right_dir = false
        end
        last_press_t = globals.curtime()
    end
    local weaponn = entity.get_player_weapon()
        if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
            if e.in_attack == 1 then
                e.in_attack = 0 
                e.in_use = 1
            end
        else
            if e.chokedcommands == 0 then
                e.in_use = 0
            end
        end
	if e.chokedcommands == 0 then
		if e.in_use == 1 then
			angle = 0
		else
			angle = math.min(60, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))
		end
	end
    local me = entity.get_local_player()
    if (not me or entity.get_prop(me, "m_lifeState") ~= 0) then
        return
    end
    
    local player_list = entity.get_players(true)
    for t = 1 , #player_list do
        player = player_list[t]
    end
    
    
    local now = globals.curtime()
    
    if data.hit_side ~= 0 and now - data.last_hit > 5 then
    
        data.last_side = 0
    
        data.last_hit = 0
        data.hit_side = 0
    end
    
    local x, y, z = client.eye_position()
    local _, yaw = client.camera_angles()
    
    local trace_data = {left = 0, right = 0}
    
    for i = yaw - 120, yaw + 120, 30 do
    
        if i ~= yaw then
    
            local rad = math.rad(i)
    
            local px, py, pz = x + 256 * math.cos(rad), y + 256 * math.sin(rad), z
    
            local fraction = client.trace_line(me, x, y, z, px, py, pz)
            local side = i < yaw and "left" or "right"
    
            trace_data[side] = trace_data[side] + fraction
        end
    end
    
    data.side = trace_data.left < trace_data.right and 1 or 2
    
    if data.side == data.last_side then
        return
    end
    
    data.last_side = data.side
    
    if data.hit_side ~= 0 then
        data.side = data.hit_side == 1 and 2 or 1
    end
end
end)

local function antiaim()
    if real_freestand == true then
        ui.set(aa_fake_yaw,"Jitter")
        if ui.get(freestandtype) == "Peek Fake" then
        ui.set(aa_fake_yaw_slider,(data.side == 1 and 62 or 31))
        ui.set(aa_body_limit,59)
        elseif ui.get(freestandtype) == "Peek Real" then
        ui.set(aa_fake_yaw_slider,(data.side == 1 and 31 or 62))
        ui.set(aa_body_limit,59)
        end
        ui.set(aa_yaw_jitter_offset,9)
        ui.set(aa_yaw_jitter,"Random")
    elseif real_antibruteforce == true then
        ui.set(aa_fake_yaw,"Static")
        if right_side == true then
            ui.set(aa_fake_yaw_slider,-180)
            ui.set(aa_body_limit,47)
        elseif left_side == true then
            ui.set(aa_fake_yaw_slider,180)
            ui.set(aa_body_limit,33)
        end
        ui.set(aa_yaw_jitter_offset,0)
        ui.set(aa_yaw_jitter,"Off")
    elseif is_dangerous == true then
        ui.set(aa_fake_yaw,"Jitter")
        ui.set(aa_fake_yaw_slider,(flipJitter and 0 or 90))
        ui.set(aa_body_limit,(flipJitter and 25 or 45))
        ui.set(aa_yaw_jitter,"off")
        ui.set(aa_yaw_jitter_offset,0)
    elseif ui.get(slowmotion) then
        ui.set(aa_fake_yaw,"Jitter")
        ui.set(aa_fake_yaw_slider,95)
        ui.set(aa_body_limit,25)
        ui.set(aa_yaw_jitter_offset,2)
        ui.set(aa_yaw_jitter,"Offset")
    elseif in_air(entity.get_local_player()) then
        ui.set(aa_fake_yaw,"Jitter")
        ui.set(aa_fake_yaw_slider,180)
        ui.set(aa_body_limit,42)
        ui.set(aa_yaw_jitter_offset,0)
        ui.set(aa_yaw_jitter,"Off")
        --ui.set(aa_fake_yaw,"Jitter")
        --ui.set(aa_fake_yaw_slider,-74)
        --ui.set(aa_body_limit,45)
        --ui.set(aa_yaw_jitter,"Off")
        --ui.set(aa_yaw_jitter_offset,0)
    else
        ui.set(aa_fake_yaw,"Jitter")
        ui.set(aa_fake_yaw_slider,0)
        ui.set(aa_body_limit,(flipJitter and 49 or 45))
        ui.set(aa_yaw_jitter_offset,0)
        ui.set(aa_yaw_jitter,"Off")
    end
end

local function freestanddetect() 
    local player_list = entity.get_players(true)
    for i = 1 , #player_list do
        player = player_list[i]
    if (is_local_peeking_enemy(player) or not contains(ui.get(autodiradd), "Jitter if dangerous") and is_enemy_peeking(player)) and should_swap + 2 < globals.curtime() and not in_air(entity.get_local_player()) and not ui.get(slowmotion) then
        real_freestand = true
        if is_local_peeking_enemy(player) and not is_enemy_peeking(player) then
            yawswitch = true
        else 
            yawswitch = false
        end
    else
        real_freestand = false
    if should_swap + 2 > globals.curtime() and not in_air(entity.get_local_player()) and not ui.get(slowmotion) then
        real_antibruteforce = true
    else
        real_antibruteforce = false
    if contains(ui.get(autodiradd),"Jitter if dangerous") and entity.get_prop(entity.get_local_player(), 'm_iHealth') >= 91 and is_enemy_peeking(player) then
        is_dangerous = true
    else
        is_dangerous = false
    end
    end
    end
    end
end

local function tickbase()
    if ui.get(dton) then
        local player_list = entity.get_players(true)
        for i = 1 , #player_list do
            player = player_list[i]
            if ui.get(dttypes) == "Dynamic" then
                ui.set(sv_clockcorrection_msecs,30)
                ui.set(sv_maxusrcmdprocessticks_holdaim,true)
                if is_enemy_peeking(player) and not is_local_peeking_enemy(player) then
                ui.set(sv_maxusrcmdprocessticks,17)
                elseif is_local_peeking_enemy(player) and not is_enemy_peeking(player) then
                ui.set(sv_maxusrcmdprocessticks,21)
                elseif is_local_peeking_enemy(player) and is_enemy_peeking(player) then
                ui.set(sv_maxusrcmdprocessticks,19)
                else
                ui.set(sv_maxusrcmdprocessticks,18)
                end
            elseif ui.get(dttypes) == "Standart" then
                ui.set(sv_maxusrcmdprocessticks,16)
                ui.set(sv_clockcorrection_msecs,30)
                ui.set(sv_maxusrcmdprocessticks_holdaim,true)
            elseif ui.get(dttypes) == "Fast" then
                ui.set(sv_maxusrcmdprocessticks,18)
                ui.set(sv_clockcorrection_msecs,30)
                ui.set(sv_maxusrcmdprocessticks_holdaim,true)
            elseif ui.get(dttypes) == "Instant" then
                ui.set(sv_maxusrcmdprocessticks,62)
                ui.set(sv_clockcorrection_msecs,30)
                ui.set(sv_maxusrcmdprocessticks_holdaim,true)
            end
        end
    else
        ui.set(sv_maxusrcmdprocessticks,16)
        ui.set(sv_clockcorrection_msecs,30)
        ui.set(sv_maxusrcmdprocessticks_holdaim,true)
    end
end

momenttodangerous = globals.curtime()

local function fakelag() 
    if ui.get(flon) then
        local player_list = entity.get_players(true)
        for i = 1 , #player_list do
            player = player_list[i]
            if ui.get(misc_fakeduck) then
                ui.set(fl_limit,14)
            else
            if is_enemy_peeking(player) and not is_local_peeking_enemy(player) then
                ui.set(fl_limit,(flipJitter and ui.get(sendpacket) or ui.get(chokepacket)))
                ui.set(fl_amount,(flipJitter and "Maximum" or "Dynamic"))
                ui.set(fl_var, 0)
            elseif is_local_peeking_enemy(player) then
                if momenttodangerous + ui.get(dangerouslagamount)/100 < globals.curtime() and not ui.get(doubletap) and not ui.get(misc_onshot_aa) and not ui.get(misc_fakeduck) and ui.get(dangerouslaggin) then
                ui.set(sv_maxusrcmdprocessticks,ui.get(dangerouslagamount)+2)
                ui.set(fl_limit,(flipJitter and ui.get(dangerouslagamount) or 16))
                ui.set(fl_var,ui.get(dangerouslagfq)/2)
                momenttodangerous = globals.curtime()
                ui.set(fl_amount,"Maximum")
                if entity.is_alive(entity.get_local_player()) and ui.get(enableflchams) then
                client.draw_hitboxes(entity.get_local_player(), globals.tickinterval()+0.2, 255, 255, 0, 35)
                end
                elseif ui.get(misc_onshot_aa) then
                ui.set(fl_limit,1)
                ui.set(fl_amount,"Maximum")
                ui.set(fl_var, 100)
                elseif ui.get(doubletap) then
                ui.set(fl_limit,15)
                ui.set(fl_amount,"Maximum")
                ui.set(fl_var, 100)
                else
                ui.set(fl_limit,(flipJitter and ui.get(sendpacket) or ui.get(chokepacket)))
                ui.set(fl_amount,(flipJitter and "Maximum" or "Dynamic"))
                ui.set(fl_var, 0)
                end
            end
        end
        end
    end
end

client.set_event_callback("round_start", function()
    real_antibruteforce = false
    real_freestand = false
    ui.set(sv_maxusrcmdprocessticks,16)
end)

client.set_event_callback("paint", function()
    if adopted == 1 and ui.get(enable) then
    local color1, color2, color3, color4 = ui.get(color0)
    freestanddetect()
    tickbase()
    fakelag()
    local scrsize_x, scrsize_y = client.screen_size()
    local center_x, center_y = scrsize_x / 2, scrsize_y / 2
    local plocal = entity.get_local_player()
	local vel = entity.get_prop(plocal, "m_vecVelocity")
	local cam = vector(client.camera_angles())
	local h = vector(entity.hitbox_position(plocal, "head_0"))
	local p = vector(entity.hitbox_position(plocal, "pelvis"))
	local yaw = normalize_yaw(calc_angle(p.x, p.y, h.x, h.y) - cam.y + 120)
	local bodyyaw = entity.get_prop(plocal, "m_flPoseParameter", 11) * 120 - 60
	local fakeangle = normalize_yaw(yaw + bodyyaw)
    local blinding = 0
    local a = 255 + (0 - 255) * 0.04 * (globals.absoluteframetime() * 100)
    local realtime = globals.realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2)
    local local_player = entity.get_local_player()
    local randomlegs = math.random(1,3)

    if ui.get(legfucker) == "Random" then
        if randomlegs == 1 then
            ui.set(legm,"Always slide")
        elseif randomlegs == 2 then
            ui.set(legm, "Never slide")
        elseif randomlegs == 3 then
            ui.set(legm, "Off")
        end
    elseif ui.get(legfucker) == "Jitter" then
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0)
        flipJitter = not flipJitter
        ui.set(legm,(flipJitter and "Never slide" or "Always slide"))
    elseif ui.get(legfucker) == "Always slide" then
        ui.set(legm,"Always slide")
    elseif ui.get(legfucker) == "Default" then
        ui.set(legm,"Never slide")
    end

	local active_weapon = entity.get_prop(local_player, "m_hActiveWeapon")
		
	if active_weapon == nil then
		return
	end
		
	local nextAttack = entity.get_prop(local_player,"m_flNextAttack") 
	local nextShot = entity.get_prop(active_weapon,"m_flNextPrimaryAttack")
	local nextShotSecondary = entity.get_prop(active_weapon,"m_flNextSecondaryAttack")
	
	if nextAttack == nil or nextShot == nil or nextShotSecondary == nil then
		return
	end
	
	nextAttack = nextAttack + 0.5
	nextShot = nextShot + 0.5
	nextShotSecondary = nextShotSecondary + 0.5
if not ui.is_menu_open() then
    if back_dir == true then
        if ui.get(attargets) then
        ui.set(aa_yaw_base,"At targets")
        else
        ui.set(aa_yaw_base,"Local view")
        end
        if real_freestand == true and yawswitch == true and contains(ui.get(autodiradd), "Better yaw for peek") then
        if ui.get(freestandtype) == "Peek Fake" then
        ui.set(aa_yaw_offset,(data.side == 1 and -15 or 15))
        elseif ui.get(freestandtype) == "Peek Real" then
        ui.set(aa_yaw_offset,(data.side == 1 and 15 or -15))
        end
        elseif ui.get(slowmotion) then
        ui.set(aa_yaw_offset,8)
        else
        ui.set(aa_yaw_offset,0)
        end
    elseif right_dir == true then
        ui.set(aa_yaw_base,"Local view")
        ui.set(aa_yaw_offset,90)
    elseif left_dir == true then
        ui.set(aa_yaw_base,"Local view")
        ui.set(aa_yaw_offset,-90)
    end
if back_dir == true then
    if math.max(nextShot) - globals.curtime() > 1.35 then
        ui.set(aa_fake_yaw,"Static")
        ui.set(aa_fake_yaw_slider,180)
        ui.set(aa_body_limit,60)
    else
        antiaim()
    end
else
    ui.set(aa_fake_yaw,"Static")
    ui.set(aa_fake_yaw_slider,180)
    ui.set(aa_body_limit,60)
end
end
notes.set_state(ui.get(enable))
notes.get(function(id)
    local sys_time = { client.system_time() }
    local actual_time = string.format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

    local text = string.format('%s | %s | %s', "technology ["..build.."]", luauser, actual_time)

    if is_in_game(is_in_game) == true then
        local INetChannelInfo = ffi.cast(interface_ptr, get_net_channel_info(ivengineclient)) or error('netchaninfo is nil')
        local get_avg_latency = ffi.cast(latency_ptr, INetChannelInfo[0][10])
        local latency = get_avg_latency(INetChannelInfo, 0) * 1000
        if ui.get(dttypes) == "Instant" then
        curtickbase = "19"
        else
        curtickbase = ui.get(sv_maxusrcmdprocessticks) - 2
        end

        text = string.format('%s | %s | %dms | %s', "technology ["..build.."]", luauser, latency, actual_time)
        if ui.get(doubletap) and not ui.get(misc_onshot_aa) then
        text2 = string.format("tickbase v("..curtickbase..")")
        xp = 145
        elseif not ui.get(doubletap) and not ui.get(misc_onshot_aa) then
        text2 = string.format("fakelag amount "..ui.get(fl_limit))
        xp = 123
        end
    end

    local h, w = 18, renderer.measure_text(nil, text) + 8
    local h2, w2 = 18, renderer.measure_text(nil, text2) + 8
    local x, y = client.screen_size(), 10 + (25*id)

    x = x - w - 10

    renderer.gradient(x, y, w, 2, color1, color2, color3, 255, 17,17,17,255, true)
    renderer.rectangle(x, y + 2, w, h, 17, 17, 17, color4)
    renderer.text(x+4, y + 4, 255, 255, 255, 255, '', 0, text)
    if is_in_game(is_in_game) == true then
    if ui.get(doubletap) and ui.get(misc_onshot_aa) or not ui.get(doubletap) and not ui.get(misc_onshot_aa) or ui.get(doubletap) then
    renderer.gradient(x + xp, y + 23, w2, 2, color1, color2, color3, 255, 17,17,17,255, true)
    renderer.rectangle(x + xp, y + 25, w2, h2, 17, 17, 17, color4)
    renderer.text(x+xp+4, y + 27, 255, 255, 255, 255, '', 0, text2)
    else

    end
    end
end)
client.draw_text(ctx, center_x, center_y + 30, color1, color2, color3, 255, "-", 0, "TECHNOLOGY")	
if real_freestand == true then
if bodyyaw > 0 then
client.draw_text(ctx, center_x - 55, center_y - 15, color1, color2, color3, 255, "+", 0, "<")	
client.draw_text(ctx, center_x + 45, center_y - 15, 17, 17, 17, 50, "+", 0, ">")	
elseif bodyyaw < 0 then
client.draw_text(ctx, center_x - 55, center_y - 15, 17, 17, 17, 50, "+", 0, "<")	
client.draw_text(ctx, center_x + 45, center_y - 15, color1, color2, color3, 255, "+", 0, ">")
end
client.draw_text(ctx, center_x, center_y + 40, color1, color2, color3, 255, "-", 0, "AA {FREESTAND}")
elseif real_antibruteforce == true then
    client.draw_text(ctx, center_x, center_y + 40, color1, color2, color3, 255, "-", 0, "AA {ANTI BRUTEFORCING}")
elseif is_dangerous == true then
    client.draw_text(ctx, center_x, center_y + 40, color1, color2, color3, 255, "-", 0, "AA {DANGEROUS}")
elseif in_air(entity.get_local_player()) then
    client.draw_text(ctx, center_x, center_y + 40, color1, color2, color3, 255, "-", 0, "AA {AERIAL AURA}")
elseif ui.get(slowmotion) then
    client.draw_text(ctx, center_x, center_y + 40, color1, color2, color3, 255, "-", 0, "AA {SAFE HEAD}")
else
    client.draw_text(ctx, center_x, center_y + 40, color1, color2, color3, 255, "-", 0, "AA {REGULAR}")
end
if ui.get(attargets) then
   client.draw_text(ctx, center_x, center_y + 50, color1, color2, color3, 255, "-", 0, "TARGET {DYNAMIC}")
else
    client.draw_text(ctx, center_x, center_y + 50, color1, color2, color3, 255, "-", 0, "TARGET {DEFAULT}")
end
if ui.get(misc_fakeduck) then
    client.draw_text(ctx, center_x, center_y + 60, color1, color2, color3, 255, "-", 0, "DUCK PEEK ASSIST")
elseif ui.get(doubletap) and not ui.get(misc_fakeduck) then
    client.draw_text(ctx, center_x, center_y + 60, color1, color2, color3, 255, "-", 0, "EXPLOIT {DT}")
elseif ui.get(misc_onshot_aa) and not ui.get(doubletap) and not ui.get(misc_fakeduck) then
    client.draw_text(ctx, center_x, center_y + 60, color1, color2, color3, 255, "-", 0, "EXPLOIT {OSAA}")
else
    client.draw_text(ctx, center_x, center_y + 60, color1, color2, color3, 255, "-", 0, "FL {"..ui.get(fl_limit).."}")
end
elseif adopted == 0 then
    renderer.indicator(255, 0, 0, 255, "Invalid user: DM zajzol#4104 if this is mistake")
end
end)

client.set_event_callback("shutdown", function()
    ui.set_visible(aa_yaw,true)
    ui.set_visible(aa_yaw_offset,true)
    ui.set_visible(aa_yaw_jitter,true)
    ui.set_visible(aa_yaw_jitter_offset,true)
    ui.set_visible(aa_yaw_base,true)
    ui.set_visible(aa_fake_yaw,true)
    ui.set_visible(aa_fake_yaw_slider,true)
    ui.set_visible(aa_fs_byaw,true)
    ui.set_visible(aa_body_limit,true)
    ui.set_visible(fl_amount,true)
    ui.set_visible(fl_limit,true)
    ui.set_visible(fl_var,true)
end)