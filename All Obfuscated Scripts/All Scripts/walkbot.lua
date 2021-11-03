--[[
	id: OSPsPHVRsJi-c1gvi0aEk
	name: walkbot
	description: walkbot
	time1: 2021-05-25 19:27:28.417276+00
	time2: 2021-05-25 19:27:28.417276+00
	uploader: vw-ii3VpZy5S2RdEkXGuFmP3cV4mRBhRakNhQE32
	uploadersession: VeC9BQhBtBCS_73KUMaVBbMkwixXX_
	flag: f
--]]

--Made by Spongyguy
local walkbot_data = require "walkbot_data"
local walkbot_all = walkbot_data.get()

local entity_get_prop       			= entity.get_prop
local entity_set_prop       			= entity.set_prop
local ui_get           					= ui.get
local ui_set                			= ui.set
local get_local_player 					= entity.get_local_player
local client_draw_indicator 			= client.draw_indicator
local uid_to_entindex 					= client.userid_to_entindex
local globals_mapname					= globals.mapname
local client_log 						= client.log
local client_exec           			= client.exec
local GetAll                			= entity.get_all
local client_eye_position   			= client.eye_position
local string_lower          			= string.lower
local client_delay_call     			= client.delay_call
local entity_get_player_resource 		= entity.get_player_resource()
local entity_get_player_name 			= entity.get_player_name
local client_set_cvar 					= client.set_cvar
local globals_tickcount      			= globals.tickcount
local globals_maxplayers 				= globals.maxplayers
local globals_curtime 					= globals.curtime
-- math stuff 
local math_ceil, math_tan, math_cos, math_sinh, math_pi, math_max, math_atan2, math_floor, math_sqrt, math_deg, math_atan, math_fmod, math_acos = math.ceil, math.tan, math.cos, math.sinh, math.pi, math.max, math.atan2, math.floor, math.sqrt, math.deg, math.atan, math.fmod, math.acos 
local math_pow, math_abs, math_min, math_sin, math_log, math_exp, math_cosh, math_asin, math_rad = math.pow, math.abs, math.min, math.sin, math.log, math.exp, math.cosh, math.asin, math.rad 

-- extra variables for drawing window 
local SetVisible = ui.set_visible
local screenx, screeny = client.screen_size()
local left = screenx - screenx
local right = screenx
local top = screeny - screeny
local bottom = screeny
local DrawText = client.draw_text
local DrawRect = client.draw_rectangle
local DrawCircle = client.draw_circle

local spots = { } -- [1] = x , [2] = y , [3] = z , [4] = onground
local forward = false
local current_spot = 1
local bestSpot = 1
local moving_yaw = 0
local moving_pitch = 0
local isOnGround = 1
local kill_switch = 0
local myKills = 0
local spot_yaw = 0
local spot_pitch = 0
local vote_option = { }
local team_name = ""
local current_tickcount = 0
local client_userid_to_entindex = client.userid_to_entindex

-- anti kick variables
local call_first_vote = true
local cooldown_callvote_swapteams = 0 
local cooldown_callvote_changelevel = 0 
local callvote_swapteams_start_time = 0
local callvote_changelevel_start_time = 0
local swapteams_cooldown = false
local changelevel_cooldown = false
local any_vote_started_start_time = 0
local any_vote_started_cooldown = false

-- adding stuff to menu
local walkbot = ui.new_checkbox("MISC", "Miscellaneous", "Walkbot Active")
local walkbot_move = ui.new_checkbox("MISC", "Miscellaneous", "Walkbot Move")
local walkbot_move_hotkey = ui.new_hotkey("MISC", "Miscellaneous", "Walkbot Move", true)
local walkbot_load_custom_spots = ui.new_checkbox("MISC", "Miscellaneous", "Walkbot load custom spot")
local walkbot_auto_add_point = ui.new_checkbox("MISC", "Miscellaneous", "Walkbot auto add point")
local walkbot_nospread = ui.new_checkbox("MISC", "Miscellaneous", "Walkbot Nospread")
local walkbot_kill_limiter_amount = ui.new_slider("MISC", "Miscellaneous", "Walkbot kill limiter", 0, 50)
local walkbot_anti_kick = ui.new_checkbox("MISC", "Miscellaneous", "Walkbot Anti-kick")

-- referencing menu
local menu_aimbot_enable = ui.reference("RAGE", "Aimbot", "Enabled")
local menu_steal_name = ui.reference("MISC", "Miscellaneous", "Steal player name")  

-- Mathematics
local function round(b,c)local d=10^(c or 0)return math_floor(b*d+0.5)/d end

local function distance3D(x1, y1, z1, x2, y2, z2)
  	return math_floor(math_sqrt((x2-x1)^2  + (y2-y1)^2 + (z2 - z1)^2) * 0.0833) 
end

local function distance2D(x1, y1, z1, x2, y2, z2)
    return math_floor(math_sqrt((x2-x1)^2  + (y2-y1)^2) * 0.0833)
end

local function draw_circle(ctx, x, y, r, g, b, a)
    local radius = 9
    local start_degrees = 0
    -- draw outline
    DrawCircle(ctx, x, y, 0, 0, 0, 200, radius, start_degrees, 1.0) 
    -- draw inner circle
    DrawCircle(ctx, x, y, r, g, b, a, radius-1, start_degrees, 1.0)
end

local function roundToNearest( number, multiple )
    local half = multiple/2
    return number+half - (number+half) % multiple
end

local function normaliseAngle(y)
	while y < 0 do
        y = y + 360
    end
    while y > 360 or y == 360 do
        y = y - 360
    end
    return y
end

local function vector_angles(x1, y1, z1, x2, y2, z2)
    --https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/mathlib/mathlib_base.cpp#L535-L563
    local origin_x, origin_y, origin_z
    local target_x, target_y, target_z
    if x2 == nil then
        target_x, target_y, target_z = x1, y1, z1
        origin_x, origin_y, origin_z = client_eye_position()
        if origin_x == nil then
            return
        end
    else
        origin_x, origin_y, origin_z = x1, y1, z1
        target_x, target_y, target_z = x2, y2, z2
    end

    --calculate delta of vectors
    local delta_x, delta_y, delta_z = target_x-origin_x, target_y-origin_y, target_z-origin_z

    if delta_x == 0 and delta_y == 0 then
        return (delta_z > 0 and 270 or 90), 0
    else
        --calculate yaw
        local yaw = math_deg(math_atan2(delta_y, delta_x))

        --calculate pitch
        local hyp = math_sqrt(delta_x*delta_x + delta_y*delta_y)
        local pitch = math_deg(math_atan2(-delta_z, hyp))

        return pitch, yaw
    end
end

local function ticks_to_seconds(ticks)
    return ticks*1/64
end

--Methods
local function draw_container(context, x, y, w, h)
    local c = {10, 60, 40, 40, 40, 60, 20}
    for i = 0,6,1 do
        DrawRect(context, x + i, y + i, w - (i * 2), h - (i * 2), c[i + 1], c[i + 1], c[i + 1], 255)
    end
end

local function on_setup_command(cmd)
    ---chokedcommands, command_number, pitch, yaw, forwardmove, sidemove, allow_send_packet, all buttons and in_, weaponselect, weaponsubtype, move_yaw
    local yaw = moving_yaw
    if ui_get(walkbot) and ui_get(walkbot_move) and #spots > 0 then
        if ui_get(walkbot_move_hotkey) then
        	cmd.move_yaw = yaw
        end
    end
    if cmd.in_jump == 1  then -- not using flags beccause you want to detect of spacebar is pressed
        isOnGround = 0
    else
        isOnGround = 1
    end

    if ui_get(walkbot) and ui_get(walkbot_move) then --walkup ladder fix
        if ui_get(walkbot_move_hotkey) then
	        local MOVETYPE_LADDER = 9
	        if entity_get_prop(get_local_player(), "m_MoveType") == MOVETYPE_LADDER then
	            cmd.yaw = moving_yaw
	            cmd.pitch = moving_pitch
        	end
	    end
    end
end

local function kill_switch_start()
	local playerResource = entity.get_player_resource()	
	if playerResource ~= nil then
		myKills = entity_get_prop(playerResource, "m_iKills", get_local_player())
	else
		myKills = 0
	end
    
    if ui_get(walkbot_kill_limiter_amount) > 0 then
        if myKills > ui_get(walkbot_kill_limiter_amount) or myKills == ui_get(walkbot_kill_limiter_amount) then
            ui_set(menu_aimbot_enable, false) 
        else
            ui_set(menu_aimbot_enable, true) 
        end
    end

    kill_switch = ui_get(walkbot_kill_limiter_amount) - myKills
end

local function custom_spots_start()
    local map = globals_mapname()
    local walkbot_all = walkbot_data.get()
    local walkbot_map = walkbot_all[map]
    local name, x, y, z, onground = { }, { }, { }, { }, { }

    if walkbot_map ~= nil then
        for i=1, #walkbot_map do
            local walkbot_meta = walkbot_map[i]

            name, x, y, z, onground  = walkbot_meta["name"], walkbot_meta["x"], walkbot_meta["y"], walkbot_meta["z"], walkbot_meta["onground"]

            if ui_get(walkbot_load_custom_spots) then
            spots[i] = { x, y, z, onground}
            end
        end
    end
end

local function on_vote_options(event)
	if ui_get(walkbot_anti_kick) then
		vote_option[0] = event.option1
		vote_option[1] = event.option2
		vote_option[2] = event.option3
		vote_option[3] = event.option4
		vote_option[4] = event.option5
	end
	current_tickcount = globals.tickcount()
end

local function on_vote_cast(event)
	local userid = event.entityid
	if userid == nil then
		return
	end
	local map = globals_mapname()

	if ui_get(walkbot_anti_kick) then
		if get_local_player() == userid then
			if current_tickcount == globals_tickcount() then
				if vote_option[event.vote_option] == "No" then		
					if call_first_vote == false and changelevel_cooldown == false and any_vote_started_cooldown == false then 
						client_exec("callvote changelevel ".. map)
						call_first_vote = true
						changelevel_cooldown = true
						callvote_changelevel_start_time = globals_curtime()

						any_vote_started_start_time = globals_curtime()
						any_vote_started_cooldown = true
						ui_set(menu_steal_name, true)
						ui_set(menu_steal_name, false)

					elseif swapteams_cooldown == false and any_vote_started_cooldown == false then
						client_exec("callvote swapteams")
						call_first_vote = false						
						swapteams_cooldown = true
						callvote_swapteams_start_time = globals_curtime()

						any_vote_started_start_time = globals_curtime()
						any_vote_started_cooldown = true
						ui_set(menu_steal_name, true)
						ui_set(menu_steal_name, false)
					end

				end
			end
		end
	end
end

local function draw_walkbot_data_start(context)
    local header_r, header_g, header_b, header_a    = 159, 202, 43, 255
    local text_r, text_g, text_b, text_a            = 255, 255, 255, 255
    local values_r, values_g, values_b, values_a    = 255, 0, 60, 255
    local lines_r, lines_g, lines_b, lines_a        = 255, 0, 60, 255

    local box_x = left + 1774 --Walkbot Data Box Posistion x
    local box_y = top + 471   --Walkbot Data Box Posistion y
    local box_height = 88
    local box_width = 140

    local index = 1
    local value = 4

    --anti-kick stuff
    -- cooldown timer calculation
	local lowest_cooldown = 0
    if ui_get(walkbot_anti_kick) then
	    local curtime = globals_curtime()
	    local cooldown_callvote_swapteams_static = 300 - (curtime - callvote_swapteams_start_time)
	    local cooldown_callvote_changelevel_static = 300 - (curtime - callvote_changelevel_start_time)
	    -- run timer, counts down
	    if swapteams_cooldown == true then
	    	if cooldown_callvote_swapteams_static < 0 then
	    		swapteams_cooldown = false
	    	end
	    	cooldown_callvote_swapteams = cooldown_callvote_swapteams_static
	    else
	    	cooldown_callvote_swapteams = 0
	    end

	    if changelevel_cooldown == true then  
	    	if cooldown_callvote_changelevel_static < 0 then
	    		changelevel_cooldown = false
	    	end
	    	cooldown_callvote_changelevel = cooldown_callvote_changelevel_static
	    else
	    	cooldown_callvote_changelevel = 0
	    end

		if any_vote_started_cooldown == true then
			if math_min(cooldown_callvote_swapteams, cooldown_callvote_changelevel) < 90 then
				lowest_cooldown = 90 - (curtime - any_vote_started_start_time)
				if lowest_cooldown < 0 then
					any_vote_started_cooldown = false
				end
			else
				lowest_cooldown = math_min(cooldown_callvote_swapteams, cooldown_callvote_changelevel)
			end
		else
			lowest_cooldown = math_min(cooldown_callvote_swapteams, cooldown_callvote_changelevel)
		end
	end


    draw_container(context, box_x, box_y, box_width, box_height)

    DrawText(context, box_x + (box_width / 2), box_y + ((index + 1 )* 5) + 1, header_r, header_g, header_b, header_a, "c", box_width, "Walkbot Data")

    DrawRect(context, box_x + 9, box_y + (index * 10) + 6, box_width - 18, 1, lines_r, lines_g, lines_b, lines_a) --draw line
    index = index + 1
    
    DrawText(context, box_x + 10, box_y + (index * 10) - value, text_r, text_g, text_b, text_a, "", box_width, "Kills:")
    DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, myKills)
    index = index + 1

    DrawText(context, box_x + 10, box_y + (index * 10) - value, text_r, text_g, text_b, text_a, "", box_width, "Spot:")
    DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, current_spot)
    index = index + 1


    DrawText(context, box_x + 10, box_y + (index * 10) - value, text_r, text_g, text_b, text_a, "", box_width, "Kill switch:")
    if ui_get(walkbot_kill_limiter_amount) == 0 then
        DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, "OFF")
    elseif kill_switch < 0 or kill_switch == 0 then
        DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, "ON")
    else
        DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, kill_switch , "K")
    end
    index = index + 1


    DrawText(context, box_x + 10, box_y + (index * 10) - value, text_r, text_g, text_b, text_a, "", box_width, "On ground:")
    DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, isOnGround) 	
    index = index + 1

    DrawText(context, box_x + 10, box_y + (index * 10) - value, text_r, text_g, text_b, text_a, "", box_width, "Anti-kick cooldown:")
    if ui_get(walkbot_anti_kick) then
    	DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, roundToNearest(lowest_cooldown, 1))
    else
    	DrawText(context, box_x + (box_width - 9), box_y + (index * 10) - value, values_r, values_g, values_b, values_a, "r", box_width, "OFF")
    end
    index = index + 1

    DrawRect(context, box_x + 9, box_y + (index * 10) - value + 2, box_width - 18, 1, lines_r, lines_g, lines_b, lines_a) --draw line
    index = index + 1
end

local function draw_to_world(context, i)
    local x, y = client.world_to_screen(context, spots[i][1], spots[i][2], spots[i][3])
    if x == nil then
    else
        if i == current_spot then
             draw_circle(context, x, y, 255, 128, 0, 150)
        end
        
        if i == 1 then
            draw_circle(context, x, y, 0, 255, 0, 150)
        end

        if i == #spots then
            draw_circle(context, x, y, 255, 0, 0, 150)
        end
        
        if i ~= 1 then
            local x_1, y_1 = client.world_to_screen(context, spots[i - 1][1], spots[i - 1][2], spots[i - 1][3])
            if x_1 ~= nil and y_1 ~= nil then
                client.draw_line(context, x, y, x_1, y_1, 255,255,255,255 )
            end
        end
    end
end

local function forward_movement_start()
    if not ui_get(walkbot_move) or not ui_get(walkbot_move_hotkey) then 
        if forward == true then
            client_exec("-forward")
            client_exec("-jump")
            forward = false
        end
        current_spot = bestSpot
        return
    end

    if not forward then
        if #spots > 0 then 
            client_exec("+forward")
        end
         forward = true
    end
end
--on paint
local function on_paint_walkbot(context)
	--if walk bot is on
   if not ui_get(walkbot) then
        return
    end
	--if localplayer is valid
    local localplayer = get_local_player()
	if localplayer == nil then
		return
    end
    local lx, ly, lz = entity_get_prop(localplayer, "m_vecOrigin")
    if lx == nil then
        return
    end

    --Start Methods
    kill_switch_start()
    custom_spots_start()
    draw_walkbot_data_start(context)
    forward_movement_start()

   --drawing the marker and calculating best spot
    for i=1, #spots do
        draw_to_world(context, i)

        local dist = distance3D(lx, ly, lz, spots[i][1], spots[i][2], spots[i][3])
        local dist_bestspot = distance3D(lx, ly, lz, spots[bestSpot][1], spots[bestSpot][2], spots[bestSpot][3])      
        --calculating best spot
        if dist < dist_bestspot then
    		bestSpot = i		
    	end      
    end	

    -- Walkbot Settings
    if #spots > 0 then
        if ui_get(walkbot_nospread) then --nospread walkbot
             --auto add points
            if ui_get(walkbot_auto_add_point) then
            	if not ui_get(walkbot_move_hotkey) or not ui_get(walkbot_move) then
	                local dist_to_last_spot = distance2D(lx, ly, lz, spots[#spots][1], spots[#spots][2], spots[#spots][3])
	                if dist_to_last_spot > 1 then 
	                    spots[#spots + 1] = { lx, ly, lz, isOnGround}
	                end
            	end
            end      
            
            --calculating/setting angle for walkbot pathway
            if distance2D(lx, ly, lz, spots[current_spot][1], spots[current_spot][2], spots[current_spot][3]) > 3 then
                local pitch_1, yaw_1 = vector_angles(lx, ly, lz, spots[current_spot][1], spots[current_spot][2], spots[current_spot][3])
                moving_yaw = normaliseAngle(yaw_1)
                moving_pitch = pitch_1
            else --finding next spot
                if current_spot == #spots then
                    current_spot = 1
                else
                    current_spot = current_spot + 1
                end
            end

            if ui_get(walkbot_move) and ui_get(walkbot_move_hotkey) then
                client_exec("+jump")
            end
        else
        --normal walkbot         
            --auto add points
            if ui_get(walkbot_auto_add_point) then
            	if not ui_get(walkbot_move_hotkey) or not ui_get(walkbot_move) then
	                local dist_to_last_spot = distance3D(lx, ly, lz, spots[#spots][1], spots[#spots][2], spots[#spots][3])
	                if dist_to_last_spot > 5 then 
	                    spots[#spots + 1] = { lx, ly, lz, isOnGround}
	                end
	                 -- jump accuracy
	              	if isOnGround == 0 then
	                    if dist_to_last_spot > 1 then
	                        spots[#spots + 1] = { lx, ly, lz, isOnGround}
	                    end
	                end 
                end
            end      
            
            --calculating/setting angle for walkbot pathway
            if distance3D(lx, ly, lz, spots[current_spot][1], spots[current_spot][2], spots[current_spot][3]) > 5 then
                local pitch_1, yaw_1 = vector_angles(lx, ly, lz, spots[current_spot][1], spots[current_spot][2], spots[current_spot][3])
    			moving_yaw = normaliseAngle(roundToNearest(yaw_1, 1))
    		    moving_pitch = roundToNearest(pitch_1, 1)
            else --finding next spot
                if current_spot == #spots then
                    current_spot = 1
                else
                    current_spot = current_spot + 1
                end
            end
            if ui_get(walkbot_move) then
            	if ui_get(walkbot_move_hotkey) then
	                if current_spot - 2 > 0 then -- need to - 2 because current spot is actually in front of player
	                   if spots[current_spot - 2][4] == 0 then 
	                        client_exec("+jump")
	                        client_delay_call(ticks_to_seconds(16), client_exec, "-jump")
	                    end
	                end
	            end
            end
        end 
    end
end

local function print_coordinates()
    local entindex = get_local_player()
    if entindex == nil then
        return
    end
    local lx, ly, lz = entity_get_prop(entindex, "m_vecOrigin")
    if lx == nil then
        return
    end

    local map = globals_mapname()
    client_log("Printed_coordinates")
    client_exec("echo ")

    for i=1, #spots do
        client_exec("echo " .. '{map=' .. map .. ', name="spot' .. i ..", onground=" .. spots[i][4] .. ", x=".. spots[i][1] .. ", y=" .. spots[i][2] .. ", z=" .. spots[i][3] .. "},")
    
    end
end

--if marker is pressed
local function add_spot_walkbot()
    local entindex = get_local_player()
	if entindex == nil then
		return
    end
    local lx, ly, lz = entity_get_prop(entindex, "m_vecOrigin")
    if lx == nil then
        return
    end

    spots[#spots + 1] = { lx, ly, lz, isOnGround}
end

--removing spot
local function clear_spots_walkbot()
    spots = {}
    bestSpot = 1
end

--adding buttons
local add_spot = ui.new_button("MISC", "Miscellaneous", "Walkbot Add Spot", add_spot_walkbot)
local clear_spots = ui.new_button("MISC", "Miscellaneous", "Walkbot Clear Spots", clear_spots_walkbot)
local print_location = ui.new_button("MISC", "Miscellaneous", "Walkbot Print Spots", print_coordinates)

local function set_currspot_to_bestspot()
     current_spot = bestSpot
end
local function on_round_prestart(e)
	client_delay_call(ticks_to_seconds(64), set_currspot_to_bestspot)
end

local function on_player_spawn(e)
    if uid_to_entindex(e.userid) == get_local_player() then
    	client_delay_call(ticks_to_seconds(32), set_currspot_to_bestspot)
    end
end

local function on_player_connect_full(event)
    if uid_to_entindex(event.userid) == get_local_player() then
        spots = { }
        bestSpot = 1
        callvote_swapteams_start_time = 0
        callvote_changelevel_start_time = 0
        any_vote_started_start_time = 0
        call_first_vote = true
        swapteams_cooldown = false
        changelevel_cooldown = false
        any_vote_started_cooldown = false
    end
end

client.set_event_callback("vote_options", on_vote_options)
client.set_event_callback("vote_cast", on_vote_cast)
client.set_event_callback("paint", on_paint_walkbot)
client.set_event_callback("round_prestart", on_round_prestart)
client.set_event_callback("player_spawn", on_player_spawn)
client.set_event_callback("player_connect_full", on_player_connect_full)
client.set_event_callback("setup_command", on_setup_command)