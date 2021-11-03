--[[
	id: BXI-oayAycvRqPV86G5UD
	name: onshotv2
	description: aa
	time1: 2021-07-03 03:36:34.901953+00
	time2: 2021-07-03 03:36:34.901954+00
	uploader: s2j_sOIPT8EV7Rmr-sVCb60G9-Uc7_NMIp0KIjjd
	uploadersession: -q_XqniSfQ1Ckooerw3yLViEReVDH-
	flag: f
--]]


-- [x]==[ Requires ]==[x]
local ffi = require "ffi"

-- [x]=====================[ C Defenitions ]=====================[x]
ffi.cdef[[	
    typedef void*( __thiscall* get_client_entity_fn_87692764296 )( void*, int );

	struct CCSGOPlayerAnimstate_67813985419 {
		char pad[ 3 ];
		char m_bForceWeaponUpdate; //0x4
		char pad1[ 91 ];
		void* m_pBaseEntity; //0x60
		void* m_pActiveWeapon; //0x64
		void* m_pLastActiveWeapon; //0x68
		float m_flLastClientSideAnimationUpdateTime; //0x6C
		int m_iLastClientSideAnimationUpdateFramecount; //0x70
		float m_flAnimUpdateDelta; //0x74
		float m_flEyeYaw; //0x78
		float m_flPitch; //0x7C
		float m_flGoalFeetYaw; //0x80
		float m_flCurrentFeetYaw; //0x84
		float m_flCurrentTorsoYaw; //0x88
		float m_flUnknownVelocityLean; //0x8C
		float m_flLeanAmount; //0x90
		char pad2[ 4 ];
		float m_flFeetCycle; //0x98
		float m_flFeetYawRate; //0x9C
		char pad3[ 4 ];
		float m_fDuckAmount; //0xA4
		float m_fLandingDuckAdditiveSomething; //0xA8
		char pad4[ 4 ];
		float m_vOriginX; //0xB0
		float m_vOriginY; //0xB4
		float m_vOriginZ; //0xB8
		float m_vLastOriginX; //0xBC
		float m_vLastOriginY; //0xC0
		float m_vLastOriginZ; //0xC4
		float m_vVelocityX; //0xC8
		float m_vVelocityY; //0xCC
		char pad5[ 4 ];
		float m_flUnknownFloat1; //0xD4
		char pad6[ 8 ];
		float m_flUnknownFloat2; //0xE0
		float m_flUnknownFloat3; //0xE4
		float m_flUnknown; //0xE8
		float m_flSpeed2D; //0xEC
		float m_flUpVelocity; //0xF0
		float m_flSpeedNormalized; //0xF4
		float m_flFeetSpeedForwardsOrSideWays; //0xF8
		float m_flFeetSpeedUnknownForwardOrSideways; //0xFC
		float m_flTimeSinceStartedMoving; //0x100
		float m_flTimeSinceStoppedMoving; //0x104
		bool m_bOnGround; //0x108
		bool m_bInHitGroundAnimation; //0x109
		float m_flTimeSinceInAir; //0x10A
		float m_flLastOriginZ; //0x10E
		float m_flHeadHeightOrOffsetFromHittingGroundAnimation; //0x112
		float m_flStopToFullRunningFraction; //0x116
		char pad7[ 4 ]; //0x11A
		float m_flMagicFraction; //0x11E
		char pad8[ 60 ]; //0x122
		float m_flWorldForce; //0x15E
		char pad9[ 462 ]; //0x162
		float m_flMaxYaw; //0x334
	};
]]

-- [x]=====================================================[ Interfaces ]=====================================================[x]
local entity_list = ffi.cast( ffi.typeof( "void***" ), client.create_interface( "client.dll", "VClientEntityList003" ) )

-- [x]==========================[ Interface Functions ]==========================[x]
local get_client_entity = ffi.cast( "get_client_entity_fn_87692764296", entity_list[ 0 ][ 3 ] )

-- [x]=================================[ UI References ]=================================[x]
local resolver = ui.reference( "Rage", "Other", "Anti-aim correction" )
local playerlist = ui.reference( "Players", "Players", "Player list" )
local rage_ref = ui.new_checkbox("Rage","other","Enabled Hitler resolver boost")

-- [x]===================[ Data Structures ]===================[x]
local function vec_3( _x, _y, _z ) 
	return { x = _x or 0, y = _y or 0, z = _z or 0 } 
end

local function color( _r, _g, _b, _a ) 
	return { r = _r or 0, g = _g or 0, b = _b or 0, a = _a or 0 } 
end

-- [x]=============================================[ Math ]=============================================[x]
local function calc_angle( x_src, y_src, z_src, x_dst, y_dst, z_dst ) -- credits xboxlivegold
    x_delta = x_src - x_dst
    y_delta = y_src - y_dst
    z_delta = z_src - z_dst
    hyp = math.sqrt( x_delta^2 + y_delta^2 )
    x = math.atan2( z_delta, hyp ) * 57.295779513082
    y = math.atan2( y_delta , x_delta ) * 180 / math.pi

    if y > 180 then
        y = y - 180
    end
    if y < -180 then
        y = y + 180
    end
    return y
end

function round( x ) -- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    return x >= 0 and math.floor( x+0.5 ) or math.ceil( x-0.5 )
end

local function normalize_as_yaw( yaw )
	if yaw > 180 or yaw < -180 then
		local revolutions = round( math.abs( yaw / 360 ) )

		if yaw < 0 then
			yaw = yaw + 360 * revolutions
		else
			yaw = yaw - 360 * revolutions
		end
	end

	return yaw
end

local function anglemod( a )
	a = ( 360 / 65536 ) * bit.band( ( a * ( 65536 / 360 ) ), 65535 )
	return a
end

local function approach_angle( target, value, speed )
	target = anglemod( target )
	value = anglemod( value )
	
	delta = target - value

	if speed < 0 then
		speed = -speed
	end
	
	if delta < -180 then
		delta = delta + 360
	elseif delta > 180 then
		delta = delta - 360
	end
	
	if delta > speed then
		value = value + speed
	elseif delta < -speed then
		value = value - speed
	else 
		value = target
	end
	
	return value;
end

local function angle_diff( destAngle, srcAngle )
	local delta = math.fmod( destAngle - srcAngle, 360.0 )
	if destAngle > srcAngle then
		if delta >= 180 then
			delta = delta - 360
		end
	else
		if delta <= -180 then
			delta = delta + 360
		end
	end
	
	return delta
end

-- [x]==================================================================================[ Local Functions ]==================================================================================[x]
local function get_max_feet_yaw( player )
    local player_ptr = ffi.cast( "void***", get_client_entity( entity_list, player ) )
	local animstate_ptr = ffi.cast( "char*" , player_ptr ) + 0x3914
	local state = ffi.cast( "struct CCSGOPlayerAnimstate_67813985419**", animstate_ptr )[ 0 ]
	local eye_angles = vec_3( entity.get_prop( player, "m_angEyeAngles" ) )
	
	local duckammount = state.m_fDuckAmount
	local speedfraction = math.max( 0, math.min( state.m_flFeetSpeedForwardsOrSideWays, 1. ) )
	local speedfactor = math.max( 0, math.max( 1, state.m_flFeetSpeedUnknownForwardOrSideways ) )
	local unk1 = ( ( state.m_flStopToFullRunningFraction * -0.30000001 ) - 0.19999999 ) * speedfraction
	local unk2 = unk1 + 1

	if duckammount > 0 then
		unk2 = unk2 + ( ( duckammount * speedfactor ) * ( 0.5 - unk2 ) )
	end

	return ( state.m_flMaxYaw ) *  unk2;
end



abs_yaw_set = { }
latest_bullet_impact = { }
latest_shot_yaw = { }
old_simulation_time = { }
local function resolve_onshot_records( )
	local enemies = entity.get_players( true )
	if not enemies then
		return
	end
	
    for i = 1, #enemies do
		local player = enemies[ i ]
		local weapon = entity.get_player_weapon( player )
		if weapon then	
			local last_shot_time = entity.get_prop( weapon, "m_fLastShotTime" )
			if last_shot_time then
				local simulation_time = entity.get_prop( player, "m_flSimulationTime" )
				if old_simulation_time[ player ] then
					if last_shot_time > old_simulation_time[ player ] and last_shot_time <= simulation_time then				
						if latest_bullet_impact[ player ] and latest_shot_yaw[ player ] and latest_bullet_impact[ player ] ~= vec_3( 0, 0, 0 ) then
							local origin = vec_3( entity.get_prop( player, "m_vecOrigin" ) )
							local view_offset = vec_3( entity.get_prop( player, "m_vecViewOffset" ) )
							local eye_position = vec_3( origin.x + view_offset.x, origin.y + view_offset.y, origin.z + view_offset.z )
							local eye_angles = vec_3( entity.get_prop( player, "m_angEyeAngles" ) )
							local abs_yaw_positive = normalize_as_yaw( eye_angles.y + math.abs( get_max_feet_yaw( player ) ) ) -- eye_angles.y +
							local abs_yaw_negetive = normalize_as_yaw( eye_angles.y - math.abs( get_max_feet_yaw( player ) ) ) --  eye_angles.y -
	
							-- Credits to rave1337 and Aviarita (cba to directly set animstate abs yaw)
							client.update_player_list()
							--if not plist.get(player,"correction active") then return end
							plist.set( player, "Force body yaw", true )
							if math.abs( normalize_as_yaw( eye_angles.y - latest_shot_yaw[ player ] ) ) < 5 then
								plist.set( player, "Force body yaw value", 0 )
							elseif math.abs( normalize_as_yaw( abs_yaw_positive - latest_shot_yaw[ player ] ) ) > math.abs( normalize_as_yaw( abs_yaw_negetive - latest_shot_yaw[ player ] ) ) then
								plist.set( player, "Force body yaw value", -math.abs( get_max_feet_yaw( player ) ) )
								--client.log( "negetive: "..-math.abs( get_max_feet_yaw( player ) ) )
							else
								plist.set( player, "Force body yaw value", math.abs( get_max_feet_yaw( player ) ) )
								--client.log( "positive: "..math.abs( get_max_feet_yaw( player ) ) )
							end
							abs_yaw_set[ player ] = true
						end
					else
						--if plist.get(player,"correction active") then return end
						if abs_yaw_set[ player ] then
							plist.set( player, "Force body yaw", false )
							plist.set( player, "Force body yaw value", 0 )
							abs_yaw_set[ player ] = false
						end
					end
				end
				old_simulation_time[ player ] = simulation_time
			end
		end
	end
end
client.color_log(100, 245, 255, "Resolver-Extra by Hitler Q3487510691")
-- [x]========================================================[ Callbacks ]========================================================[x]
client.set_event_callback( "bullet_impact", function( event_data )
	local player = client.userid_to_entindex( event_data.userid )	
	latest_bullet_impact[ player ] = vec_3( event_data.x, event_data.y, event_data.z )
	
	local origin = vec_3( entity.get_prop( player, "m_vecOrigin" ) )
	local view_offset = vec_3( entity.get_prop( player, "m_vecViewOffset" ) )
	local eye_position = vec_3( origin.x + view_offset.x, origin.y + view_offset.y, origin.z + view_offset.z )
	latest_shot_yaw[ player ] = calc_angle( eye_position.x, eye_position.y, eye_position.z, event_data.x, event_data.y, event_data.z )
end )

client.set_event_callback( "run_command", function( cmd )
	local plocal = entity.get_local_player()
	if not ui.get(rage_ref) then return end
	if not entity.is_alive(plocal) then return end
	resolve_onshot_records( )
end )


--local playerlist = ui.reference("PLAYERS", "Players", "Player list")
--local high_priority = ui.reference("PLAYERS", "Adjustments", "High priority")
--local glow_slider = ui.new_slider("PLAYERS", "Players", "Glow alpha", -1, 5000, -1, true, "", 1, {[-1] = "Off"})
local high_priority_ents = {  }
local hackers_ents = {  }
local clean_ents = {  }

local function normalize_yaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end
    return yaw
end

local function calc_anglee(localplayerxpos, localplayerypos, enemyxpos, enemyypos)
	local ydelta = localplayerypos - enemyypos
	local xdelta = localplayerxpos - enemyxpos
    local relativeyaw = math.atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
    return relativeyaw
end

local function ent_speed(index)
	local x,y,z = entity.get_prop(index, "m_vecVelocity")
	if x == nil then
		return 0
	end
	return math.sqrt(x * x + y * y + z * z)
end

client.set_event_callback("run_command", function(c)
	    local plocal = entity.get_local_player()
		if not ui.get(rage_ref) then return end
		if not entity.is_alive(plocal) then return end
		high_priority_ents = { }
        hackers_ents = {  }
        clean_ents = {  }
        for _, v in pairs(entity.get_players(true)) do
            if plist.get(v,"Force body yaw") then
                table.insert(high_priority_ents, v)
            end
		end
		for _, v in pairs(entity.get_players(true)) do
            if plist.get(v,"Correction active") and (not plist.get(v,"Force body yaw")) then
                table.insert(hackers_ents, v)
            end
		end
		for _, v in pairs(entity.get_players(true)) do
            if (not plist.get(v,"Correction active")) and (not plist.get(v,"Force body yaw")) then
                table.insert(clean_ents, v)
            end
        end
end)

client.set_event_callback("paint", function()
	local plocal = entity.get_local_player()
	if not ui.get(rage_ref) then return end
	if not entity.is_alive(plocal) then return end
    for _, v in pairs(high_priority_ents) do
        local bounding_box = {entity.get_bounding_box(v)}
        if #bounding_box == 5 and bounding_box[5] ~= 0 then
			local center = bounding_box[1]+(bounding_box[3]-bounding_box[1])/2
			renderer.text(center - 15, bounding_box[2]-19, 0, 255, 0, 255*bounding_box[5], "cb", 0, "⬤")
            renderer.text(center + 3, bounding_box[2]-18, 255, 255, 0, 255*bounding_box[5], "cb", 0, plist.get(v,"Force body yaw value").."°")
        end
	end
	for _, v in pairs(hackers_ents) do
		local bounding_box = {entity.get_bounding_box(v)}
		local pitch, yaw, roll = entity.get_prop(v, "m_angEyeAngles")
		local eox, eoy, eoz = entity.get_prop(v, "m_vecOrigin")
		local lox, loy, loz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
		local enemy_side_ways = false
		local safedo = false
		local enemy_duck_head_T = false
		local team = entity.get_prop(v,"m_iTeamNum")
			if team == 2 then
				local duck_ammount = entity.get_prop(v, "m_flDuckAmount")
			    enemy_duck_head_T = duck_ammount >= 0.7
			end
		if eox ~= nil and yaw ~= nil then
			local at_targets = normalize_yaw(calc_anglee(lox, loy, eox, eoy) + 180)
			local left_delta = math.abs(normalize_yaw(yaw - (at_targets - 90)))
			local right_delta = math.abs(normalize_yaw(yaw - (at_targets + 90)))
			enemy_side_ways = left_delta < 30 or right_delta < 30
		end
		local safedo = enemy_side_ways or (ent_speed(v) > 137) or enemy_duck_head_T
        if #bounding_box == 5 and bounding_box[5] ~= 0 then
			local center = bounding_box[1]+(bounding_box[3]-bounding_box[1])/2
			renderer.text(center - 15, bounding_box[2]-19, safedo and 0 or 255, safedo and 255 or 0, 0, 255*bounding_box[5], "cb", 0, "⬤")
            renderer.text(center + 3, bounding_box[2]-18, 255, 255, 0, 255*bounding_box[5], "cb", 0, math.floor(entity.get_prop(v,"m_flPoseParameter",11)*120-60).."°")
        end
	end
	for _, v in pairs(clean_ents) do
        local bounding_box = {entity.get_bounding_box(v)}
        if #bounding_box == 5 and bounding_box[5] ~= 0 then
			local center = bounding_box[1]+(bounding_box[3]-bounding_box[1])/2
			renderer.text(center - 15, bounding_box[2]-19, 0, 255, 0, 255*bounding_box[5], "cb", 0, "⬤")
            renderer.text(center + 3, bounding_box[2]-18, 255, 255, 0, 255*bounding_box[5], "cb", 0, math.floor(entity.get_prop(v,"m_flPoseParameter",11)*120-60).."°")
        end
    end
end)

client.set_event_callback( "shutdown", function( )
	local enemies = entity.get_players( true )
	if not enemies then
		return
	end
	
    for i = 1, #enemies do
		local player = enemies[ i ]
		local weapon = entity.get_player_weapon( player )
		plist.set( player, "Force body yaw", false )
		plist.set( player, "Force body yaw value", 0 )
		abs_yaw_set[ player ] = false
	end
end )