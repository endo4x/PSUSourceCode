--[[
	id: tOdcfCNUDsLQzmy7YAMOb
	name: C_Visuals7
	description: C_Visuals7
	time1: 2021-07-13 18:49:05.356378+00
	time2: 2021-07-13 18:49:05.356379+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Menu
local tracer = ui.new_checkbox("Lua", "b", "Bullet tracers redux")
local color = ui.new_color_picker("Lua", "b", "Color", 255, 255, 255, 255)

-- Variables and constants
local queue = {}

-- Game event handling
client.set_event_callback("bullet_impact", function(e)
    if not ui.get(tracer) then
        return
    end
    if client.userid_to_entindex(e.userid) ~= entity.get_local_player() then
        return
    end
    local lx, ly, lz = client.eye_position()
    queue[globals.tickcount()] = {lx, ly, lz, e.x, e.y, e.z, globals.curtime() + 2}
end)

client.set_event_callback("paint", function()
    if not ui.get(tracer) then
        return
    end
    for tick, data in pairs(queue) do
        if globals.curtime() <= data[7] then
            local x1, y1 = renderer.world_to_screen(data[1], data[2], data[3])
            local x2, y2 = renderer.world_to_screen(data[4], data[5], data[6])
            if x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil then
                renderer.line(x1, y1, x2, y2, ui.get(color))
            end
        end
    end
end)

client.set_event_callback("round_prestart", function()
    if not ui.get(tracer) then
        return
    end
    queue = {}
end)

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


local client_userid_to_entindex, entity_get_local_player, entity_hitbox_position, globals_curtime, globals_tickcount, math_sqrt, renderer_line, renderer_world_to_screen, pairs, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_slider, ui_set_callback, ui_set_visible = client.userid_to_entindex, entity.get_local_player, entity.hitbox_position, globals.curtime, globals.tickcount, math.sqrt, renderer.line, renderer.world_to_screen, pairs, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_slider, ui.set_callback, ui.set_visible

local success, surface = pcall(require, 'gamesense/surface')

if not success then
    error('\n\n - Surface library is required \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n')
end

local shot_data = {}
local segoe = surface.create_font('Verdana', 20, 500, { 0x010 })
local hit_marker = ui_new_checkbox("Lua", "b", "Hit marker 3D")

local function paint()
    if not ui_get(hit_marker) then
        return
    end

    local size = 3.5
    local size2 = 2.5

    for tick, data in pairs(shot_data) do
        if data.draw then
            if globals_curtime() >= data.time then
                data.alpha = data.alpha - 2
            end

            if data.alpha <= 0 then
                data.alpha = 0
                data.draw = false
            end

            local sx, sy = renderer_world_to_screen(data.x, data.y, data.z)
            if sx ~= nil then
                local color = { 255, 255, 255 }

                if data.hs then
                    color = { 255, 0, 0 }
                end

                local damage_text = data.damage .. ''
                local w, h = surface.get_text_size(segoe, damage_text)

                surface.draw_text(sx - w/2, sy - size*2 - h*1.1, color[1], color[2], color[3], data.alpha, segoe, damage_text)

                renderer_line(sx + size, sy + size, sx + (size * size2), sy + (size * size2), 0, 0, 0, data.alpha)
                renderer_line(sx + size, sy + size, sx + (size * size2), sy + (size * size2), 255, 255, 255, math.max(0, data.alpha-35))

                renderer_line(sx - size, sy + size, sx - (size * size2), sy + (size * size2), 0, 0, 0, data.alpha)
                renderer_line(sx - size, sy + size, sx - (size * size2), sy + (size * size2), 255, 255, 255, math.max(0, data.alpha-35))

                renderer_line(sx + size, sy - size, sx + (size * size2), sy - (size * size2), 0, 0, 0, data.alpha)
                renderer_line(sx + size, sy - size, sx + (size * size2), sy - (size * size2), 255, 255, 255, math.max(0, data.alpha-35))

                renderer_line(sx - size, sy - size, sx - (size * size2), sy - (size * size2), 0, 0, 0, data.alpha)
                renderer_line(sx - size, sy - size, sx - (size * size2), sy - (size * size2), 255, 255, 255, math.max(0, data.alpha-35))
            end
        end
    end
end

local function player_hurt(e)
    if not ui_get(hit_marker) then
        return
    end

    local victim_entindex = client_userid_to_entindex(e.userid)
    local attacker_entindex = client_userid_to_entindex(e.attacker)

    if attacker_entindex ~= entity_get_local_player() then
        return
    end

    local tick = globals_tickcount()
    local data = shot_data[tick]

    if shot_data[tick] == nil or data.impacts == nil then
        return
    end

    local hitgroups = { 
        [1] = {0, 1}, 
        [2] = {4, 5, 6}, 
        [3] = {2, 3}, 
        [4] = {13, 15, 16}, 
        [5] = {14, 17, 18}, 
        [6] = {7, 9, 11}, 
        [7] = {8, 10, 12}
    }

    local impacts = data.impacts
    local hitboxes = hitgroups[e.hitgroup]
    
    local hit = nil
    local closest = math.huge

    for i=1, #impacts do
        local impact = impacts[i]

        if hitboxes ~= nil then
            for j=1, #hitboxes do
                local x, y, z = entity_hitbox_position(victim_entindex, hitboxes[j])
                local distance = math_sqrt((impact.x - x)^2 + (impact.y - y)^2 + (impact.z - z)^2)

                if distance < closest then
                    hit = impact
                    closest = distance
                end
            end
        end
    end

    if hit == nil then
        return
    end

    shot_data[tick] = {
        x = hit.x,
        y = hit.y,
        z = hit.z,
        time = globals_curtime() + 1 - 0.25,
        alpha = 255,
        damage = e.dmg_health,
        hs = e.hitgroup == 0 or e.hitgroup == 1,
        draw = true,
    }
end

local function bullet_impact(e)
    if not ui_get(hit_marker) then
        return
    end

    if client_userid_to_entindex(e.userid) ~= entity_get_local_player() then
        return
    end

    local tick = globals_tickcount()

    if shot_data[tick] == nil then
        shot_data[tick] = {
            impacts = { }
        }
    end

    local impacts = shot_data[tick].impacts

    if impacts == nil then
        impacts = { }
    end

    impacts[#impacts + 1] = {
        x = e.x,
        y = e.y,
        z = e.z
    }
end

local function round_start()
    if not ui_get(hit_marker) then
        return
    end

    shot_data = { }
end

client.set_event_callback("paint", paint)
client.set_event_callback("player_hurt", player_hurt)
client.set_event_callback("round_start", round_start)
client.set_event_callback("bullet_impact", bullet_impact)

----------------------------------------------------------------------------------------------------------------------------------

local ui_get = ui.get
local ui_set = ui.set
local ui_set_visible = ui.set_visible
local globals_tickcount = globals.tickcount
local globals_tickinterval = globals.tickinterval
local globals_realtime = globals.realtime
local client_world_to_screen = client.world_to_screen
local client_draw_text = client.draw_text
local string_format = string.format
local globals_tickcount = globals.tickcount
local entity_get_prop = entity.get_prop
local table_insert = table.insert
 
local display_duration = 2
local speed = 1
 
local enabled_reference = ui.new_checkbox("Lua", "b", "Damage Indicator")
local duration_reference = ui.new_slider("Lua", "b", "Display Duration", 1, 10, 4)
local speed_reference = ui.new_slider("Lua", "b", "Speed", 1, 8, 2)
local minimum_damage_reference = ui.reference("RAGE", "Aimbot", "Minimum damage")
local aimbot_enabled_reference = ui.reference("RAGE", "Aimbot", "Enabled")
 
local damage_indicator_displays = {}
 
local function on_player_hurt(e)
    if not ui_get(enabled_reference) then
        return
    end
    --local userid, attacker, health, armor, weapon, damage, dmg_armor, hitgroup = e.userid, e.attacker, e.health, e.armor, e.weapon, e.dmg_damage, e.dmg_armor, e.hitgroup
    local userid, attacker, damage, health = e.userid, e.attacker, e.dmg_health, e.health
    if userid == nil or attacker == nil or damage == nil then
        return
    end
 
    local player = client.userid_to_entindex(userid)
    local x, y, z = entity_get_prop(player, "m_vecOrigin")
    if x == nil or y == nil or z == nil then
        return
    end
    local voZ = entity_get_prop(player, "m_vecViewOffset[2]")
 
    table_insert(damage_indicator_displays, {damage, globals_realtime(), x, y, z + voZ, e})
end
 
local function on_enabled_change()
    local enabled = ui_get(enabled_reference)
    ui_set_visible(duration_reference, enabled)
    ui_set_visible(speed_reference, enabled)
end
on_enabled_change()
ui.set_callback(enabled_reference, on_enabled_change)
 
local function on_paint(ctx)
 
    if not ui_get(enabled_reference) then
        return
    end
 
    local damage_indicator_displays_new = {}
    local max_time_delta = ui_get(duration_reference) / 2
    local speed = ui_get(speed_reference) / 3
    local realtime = globals_realtime()
    local max_time = realtime - max_time_delta / 2
    local aimbot_enabled = ui_get(aimbot_enabled_reference)
    local minimum_damage = 0
    if aimbot_enabled then
        minimum_damage = ui_get(minimum_damage_reference)
    end
 
    for i=1, #damage_indicator_displays do
        local damage_indicator_display = damage_indicator_displays[i]
        local damage, time, x, y, z, e = damage_indicator_display[1], damage_indicator_display[2], damage_indicator_display[3], damage_indicator_display[4], damage_indicator_display[5], damage_indicator_display[6]
        local r, g, b, a = 255, 255, 255, 255
        if time > max_time then
            local sx, sy = client_world_to_screen(ctx, x, y, z)
 
            if e.hitgroup == 1 then
                r, g, b = 149, 184, 6
            end
            if damage < minimum_damage and e.health ~= 0 then
                r, g, b = 255, 0, 0
            end
           
            if (time - max_time) < 0.7 then
                a = (time - max_time) / 0.7 * 255
            end
 
            if not (sx == nil or sy == nil) then
                client_draw_text(ctx, sx, sy, r, g, b, a, "c", 0, damage)
            end
            table_insert(damage_indicator_displays_new, {damage, time, x, y, z+0.4*speed, e})
        end
    end
 
    damage_indicator_displays = damage_indicator_displays_new
end
 
client.set_event_callback("player_hurt", on_player_hurt)
client.set_event_callback("paint", on_paint)


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
local bit_band, client_set_event_callback, entity_get_bounding_box, entity_get_local_player, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, math_ceil, math_pow, math_sqrt, renderer_line, renderer_text, renderer_world_to_screen, ui_get, ui_new_checkbox = bit.band, client.set_event_callback, entity.get_bounding_box, entity.get_local_player, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, math.ceil, math.pow, math.sqrt, renderer.line, renderer.text, renderer.world_to_screen, ui.get, ui.new_checkbox

local revolver_helper = ui_new_checkbox("lua", "b", "Enable revolver helper")

local function Vector(x,y,z) 
	return {x=x or 0,y=y or 0,z=z or 0} 
end

local function Distance(from_x,from_y,from_z,to_x,to_y,to_z)  
  return math_ceil(math_sqrt(math_pow(from_x - to_x, 2) + math_pow(from_y - to_y, 2) + math_pow(from_z - to_z, 2)))
end

local function check_revolver_distance(player,victim)
	if player == nil then return end
	if victim == nil then return end
	
	local weap = entity_get_prop(entity_get_prop(player, "m_hActiveWeapon"), "m_iItemDefinitionIndex")
	if weap == nil then return end
	local vnum = bit_band(weap, 0xFFFF)
	local player_origin = Vector(entity_get_prop(player, "m_vecOrigin"))
	local victim_origin = Vector(entity_get_prop(victim, "m_vecOrigin"))

	local units = Distance(player_origin.x, player_origin.y, player_origin.z, victim_origin.x, victim_origin.y, victim_origin.z)
	local no_kevlar = entity_get_prop(victim, "m_ArmorValue") == 0	

	if not (vnum == 64 and no_kevlar) then
		return 0
	end
	
	if units < 585 and units > 511 then
		return 1
	elseif units < 511 then
		return 2
	else
		return 0
	end
end


local function draw_status(player, status)
	local x1, y1, x2, y2, alpha_multiplier = entity_get_bounding_box(player)

	if (x1 == nil or alpha_multiplier == 0) then
		return
	end
	
	local x_center = x1 / 2 + x2 / 2
	local y_additional = name == "" and -8 or 0

	if status == 1 then
		renderer_text(x_center, y1 - 20 + y_additional, 255, 0, 0, 255, "cb", 0, "DMG")
	else
		renderer_text(x_center, y1 - 20 + y_additional, 50, 205, 50, 255, "cb", 0, "DMG+")
	end
end

local function paint()
	if not ui_get(revolver_helper) then return end
	local lp = entity_get_local_player()
	if lp == nil then return end
	if not entity_is_alive(lp) then return end
	
    local players = entity_get_players(true)
	if #players == nil or #players == 0 then
		return
	end
	for i = 1, #players do
		local entindex = players[i]	
		if (entindex ~= nil and entindex ~= entity_get_local_player()) then
			local line_start = Vector(entity_hitbox_position(entindex, 13))
			local line_stop = Vector(entity_hitbox_position(lp, 3))
			local x1, y1 = renderer_world_to_screen(line_start.x,line_start.y,line_start.z)
			local x2, y2 = renderer_world_to_screen(line_stop.x,line_stop.y,line_stop.z)

			local revolver = check_revolver_distance(lp,entindex)
			local enemy_revolver = check_revolver_distance(entindex,lp)
			
			if revolver ~= 0 and revolver ~= nil then
				draw_status(entindex,revolver)
			end
			
			if enemy_revolver ~= 0 and enemy_revolver ~= nil then
				if x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil then
					renderer_line(x1, y1, x2, y2, 255,0,0,255)
				end
			end
		end
	end
	
end

local function setup_callback(i)
    if ui.get(i) then
        client.set_event_callback("paint", paint)
    else
        client.unset_event_callback("paint", paint)
    end
end

ui.set_callback(revolver_helper, setup_callback)

----------------------------------------------------------------------------------------------------


local enable = ui.new_checkbox("lua", "b", "Show hit/miss ratio indicator")

local stats = {
	total_shots = 0,
	hits = 0
}

client.set_event_callback("paint", function()
	local lp = entity.get_local_player()
	if not ui.get(enable) then return end
	if not lp then return end
	if entity.get_prop(lp, "m_lifeState") ~= 0 then return end

	renderer.indicator(132,196,20,245, string.format("%s / %s (%s)", stats.hits, stats.total_shots, string.format("%.1f", stats.total_shots ~= 0 and (stats.hits/stats.total_shots*100) or 0)))
end)

client.set_event_callback("aim_fire", function(e)
	stats.total_shots = stats.total_shots + 1
end)

client.set_event_callback("aim_hit", function()
	stats.hits = stats.hits + 1
end)

client.set_event_callback("aim_miss", function(e)
	if e.reason == "death" then
		stats.total_shots = stats.total_shots - 1
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

-------------------------------------------------

local userid_to_entindex = client.userid_to_entindex
local get_player_name = entity.get_player_name
local get_local_player = entity.get_local_player
local is_enemy = entity.is_enemy
local console_cmd = client.exec
local ui_get = ui.get
local trashtalk = ui.new_checkbox('lua', 'b', "Killsay")

local baimtable = {
    '您被克里斯4年HVHER顶参击杀 QQ:1209761807 免费摸参qun：730060595',
	

}

local hstable = {
    '您被克里斯4年HVHER顶参击杀 QQ:1209761807 免费摸参qun：730060595',
  

}
local deathtable = {
    '',
}


local function get_table_length(data)
  if type(data) ~= 'table' then
    return 0
  end
  local count = 0
  for _ in pairs(data) do
    count = count + 1
  end
  return count
end

local num_quotes_baim = get_table_length(baimtable)
local num_quotes_hs = get_table_length(hstable)
local num_quotes_death = get_table_length(deathtable)

local function on_player_death(e)
	if not ui_get(trashtalk) then
		return
	end
	local victim_userid, attacker_userid = e.userid, e.attacker
	if victim_userid == nil or attacker_userid == nil then
		return
	end

	local victim_entindex   = userid_to_entindex(victim_userid)
	local attacker_entindex = userid_to_entindex(attacker_userid)
	if attacker_entindex == get_local_player() and is_enemy(victim_entindex) then
		if e.headshot then
			    local commandhs = 'say ' .. hstable[math.random(num_quotes_hs)]
                console_cmd(commandhs)
		else
			    local commandbaim = 'say ' .. baimtable[math.random(num_quotes_baim)]
                console_cmd(commandbaim)
		end
	end
	if victim_entindex == get_local_player() and attacker_entindex ~= get_local_player() then
			console_cmd("GG")
	elseif victim_entindex == get_local_player() and attacker_entindex == get_local_player() then
			console_cmd("say EZ")
	end
end

client.set_event_callback("player_death", on_player_death)

local label = ui.new_label("Lua", "b", '=======================================')