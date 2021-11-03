--[[
	id: 67jMrex-LJv8sOHTuRgZ0
	name: Anti-aims
	description: 1.0.1
	time1: 2021-07-24 19:53:21.917869+00
	time2: 2021-07-24 19:53:21.91787+00
	uploader: 1161
	uploadersession: 8bb6vPAEu246Bk-5VdMlrrdLiVqpVA
	flag: f
--]]

-- localize vars
local type         = type;
local setmetatable = setmetatable;
local tostring     = tostring;

local math_pi   = math.pi;
local math_min  = math.min;
local math_max  = math.max;
local math_deg  = math.deg;
local math_rad  = math.rad;
local math_sqrt = math.sqrt;
local math_sin  = math.sin;
local math_cos  = math.cos;
local math_atan = math.atan;
local math_acos = math.acos;
local math_fmod = math.fmod;

-- set up vector3 metatable
local _V3_MT   = {};
_V3_MT.__index = _V3_MT;

--
-- create Vector3 object
--
local function Vector3( x, y, z )
    -- check args
    if( type( x ) ~= "number" ) then
        x = 0.0;
    end

    if( type( y ) ~= "number" ) then
        y = 0.0;
    end

    if( type( z ) ~= "number" ) then
        z = 0.0;
    end

    x = x or 0.0;
    y = y or 0.0;
    z = z or 0.0;

    return setmetatable(
        {
            x = x,
            y = y,
            z = z
        },
        _V3_MT
    );
end


function _V3_MT.__sub( a, b ) -- subtract another vector or number
    local a_type = type( a );
    local b_type = type( b );

    if( a_type == "table" and b_type == "table" ) then
        return Vector3(
            a.x - b.x,
            a.y - b.y,
            a.z - b.z
        );
    elseif( a_type == "table" and b_type == "number" ) then
        return Vector3(
            a.x - b,
            a.y - b,
            a.z - b
        );
    elseif( a_type == "number" and b_type == "table" ) then
        return Vector3(
            a - b.x,
            a - b.y,
            a - b.z
        );
    end
end

function _V3_MT:length_sqr() -- squared 3D length
    return ( self.x * self.x ) + ( self.y * self.y ) + ( self.z * self.z );
end

function _V3_MT:length() -- 3D length
    return math_sqrt( self:length_sqr() );
end

function _V3_MT:dot( other ) -- dot product
    return ( self.x * other.x ) + ( self.y * other.y ) + ( self.z * other.z );
end

function _V3_MT:cross( other ) -- cross product
    return Vector3(
        ( self.y * other.z ) - ( self.z * other.y ),
        ( self.z * other.x ) - ( self.x * other.z ),
        ( self.x * other.y ) - ( self.y * other.x )
    );
end

function _V3_MT:dist_to( other ) -- 3D length to another vector
    return ( other - self ):length();
end

function _V3_MT:normalize() -- normalizes this vector and returns the length
    local l = self:length();
    if( l <= 0.0 ) then
        return 0.0;
    end

    self.x = self.x / l;
    self.y = self.y / l;
    self.z = self.z / l;

    return l;
end


function _V3_MT:normalized() -- returns a normalized unit vector
    local l = self:length();
    if( l <= 0.0 ) then
        return Vector3();
    end

    return Vector3(
        self.x / l,
        self.y / l,
        self.z / l
    );
end

local function angle_forward( angle ) -- angle -> direction vector (forward)
    local sin_pitch = math_sin( math_rad( angle.x ) );
    local cos_pitch = math_cos( math_rad( angle.x ) );
    local sin_yaw   = math_sin( math_rad( angle.y ) );
    local cos_yaw   = math_cos( math_rad( angle.y ) );

    return Vector3(
        cos_pitch * cos_yaw,
        cos_pitch * sin_yaw,
        -sin_pitch
    );
end


local function get_FOV( view_angles, start_pos, end_pos ) -- get fov to a vector (needs client view angles, start position (or client eye position for example) and the end position)
    local type_str;
    local fwd;
    local delta;
    local fov;

    fwd   = angle_forward( view_angles );
    delta = ( end_pos - start_pos ):normalized();
    fov   = math_acos( fwd:dot( delta ) / delta:length() );

    return math_max( 0.0, math_deg( fov ) );
end
local ffi = require("ffi")

local line_goes_through_smoke

do
    local success, match = client.find_signature("client_panorama.dll", "\x55\x8B\xEC\x83\xEC\x08\x8B\x15\xCC\xCC\xCC\xCC\x0F\x57")

    if success and match ~= nil then
        local lgts_type = ffi.typeof("bool(__thiscall*)(float, float, float, float, float, float, short);")

        line_goes_through_smoke = ffi.cast(lgts_type, match)
    end
end
--endregion

--region math
function math.round(number, precision)
    local mult = 10 ^ (precision or 0)

    return math.floor(number * mult + 0.5) / mult
end
--endregion

--region angle
--- @class angle_c
--- @field public p number Angle pitch.
--- @field public y number Angle yaw.
--- @field public r number Angle roll.
local angle_c = {}
local angle_mt = {
    __index = angle_c
}


--- Create a new vector object.
--- @param p number
--- @param y number
--- @param r number
--- @return angle_c
local function angle(p, y, r)
    return setmetatable(
        {
            p = p or 0,
            y = y or 0,
            r = r or 0
        },
        angle_mt
    )
end
-- VECTOR LIBRARY ABOVE --

-- reference library
local ui_set, ui_get, ui_ref, ui_callback, ui_visibile = ui.set, ui.get, ui.reference, ui.set_callback
local ui_new_checkbox, ui_new_color_picker, ui_new_slider =  ui.new_checkbox, ui.new_color_picker, ui.new_slider
local entity_get_player_name, entity_get_bounding_box, entity_is_alive, entity_get_prop, entity_get_local_player, entity_get_player_weapon, entity_get_players = entity.get_player_name, entity.get_bounding_box, entity.is_alive, entity.get_prop, entity.get_local_player, entity.get_player_weapon, entity.get_players
local client_set_event_callback, client_unset_event_callback, client_log, client_color_log, client_screensize, client_draw_indicator, client_draw_text = client.set_event_callback, client.unset_event_callback, client.log, client.color_log, client.screen_size, client.draw_indicator, client.draw_text
local string_format, math_floor, bit_band = string.format, math.floor, bit.band
local renderer_text, renderer_measure_text = renderer.text, renderer.measure_text
-- endregion


-- end of lua / console logs

-- menu reference
local aatab = { "LUA", "B" }
local luatab = { "LUA", "B" }

-- steamid 32 to 64 and protection system 0_0
local ffi = require( "ffi" )

-- menu
-- start of actual LUA
-- start ui

local nickname = "rose"
local usertype = ""



if nickname == 'rose' then nickname = 'admin' end

if nickname == 'admin' then usertype = '[dev]' else usertype = '[alpha]' end


-- anti-aim options ui
local aa = 
{
    enable_checkbox = ui.new_checkbox( aatab[1], aatab[2], "exscord extensions - " ..nickname ),
    
    -- exscord UI
    configure_combobox = ui.new_combobox( aatab[1], aatab[2], "Current tab: ",  
    "Anti-aim",
    "Ragebot",
    "Indicators",
    "Config" ),

    -- Ragebot UI
   -- increase_speed = ui.new_checkbox( aatab[1], aatab[2] , "[+] Extend doubletap speed" ),
  --  dt_accuracy = ui.new_checkbox( aatab[1], aatab[2] , "[+] Improve DT accuracy" ),
    ideal_peek = ui.new_hotkey( aatab[1], aatab[2], "[+] Ideal peek" ),

    -- Anti-aim UI
    jitter_checkbox = ui.new_checkbox( aatab[1], aatab[2], "[+] Extend anti-aimbot settings" ),
    freestand_mode_combobox = ui.new_combobox( aatab[1], aatab[2], "[+] Custom DSY Freestanding", "Default", "Reversed" ),
    lowdelta_slow_walk_checkbox = ui.new_checkbox( aatab[1], aatab[2], "[+] Smart delta on slow-walk" ),
    in_air_checkbox = ui.new_checkbox( aatab[1], aatab[2] , "[+] Air anti-aim changes"),
    edge_yaw_checkbox = ui.new_checkbox (aatab[1], aatab[2], "[+] Smart edge-yaw" ),
    legmovement_checkbox = ui.new_checkbox( aatab[1], aatab[2], "[+] Adaptive leg breaker" ),
    legit_aa_on_e = ui.new_checkbox( aatab[1], aatab[2], "[+] Legit anti-aim on E key" ),
    legit_aa_hotkey = ui.new_hotkey( aatab[1], aatab[2], " [-] Custom key", false ),

    --Manual anti-aim ui
    manualaa_checkbox = ui.new_checkbox( aatab[1], aatab[2], "[+] Manual anti-aim" ),
    manual_left_hotkey = ui.new_hotkey( aatab[1], aatab[2], " [-] Left", false ),
    manual_back_hotkey = ui.new_hotkey( aatab[1], aatab[2], " [-] Backwards", false ),
    manual_right_hotkey = ui.new_hotkey( aatab[1], aatab[2]," [-] Right", false ),
    manual_state = ui.new_slider("AA", "Other", "Manual direction", 0, 3, 0)
}

-- visual options start ui
local visuals = 
{
    configure_vis_combobox = ui.new_combobox( aatab[1], aatab[2], "Indicator customization ",  
    "Text & Indicators"),

    -- visual indicator colours ui
    -- visual indicators ui
    indicators_multiselect = ui.new_multiselect( aatab[1], aatab[2], "Indicators", {
        "Screen indicators", 
        "Arrows"} ),
    
    -- visual text indicators choice ui
    textindicators_multiselect = ui.new_multiselect( aatab[1], aatab[2], "Text display", {
        "LUA Name",
        "AA State",
        "Ragebot state indicators" } ),
    
    
    -- visual indicator y position ui
    indicatorypos_slider = ui.new_slider( aatab[1], aatab[2], "Indicator Y Positon", -100, 100, 0, true, "px" ),

    fontstyle_combobox = ui.new_combobox( aatab[1], aatab[2], "Font style", {
        "Block",
        "Default",
        "Bold" } ),

    centered_text = ui.new_checkbox( aatab[1], aatab[2], "Centered text" ),

    banepa_label = ui.new_label( aatab[1], aatab[2], "LUA Name color" ),
    banepa_colourpicker = ui.new_color_picker( aatab[1], aatab[2], "byc", 255, 255, 255, 255 ),

    arrow_label = ui.new_label( aatab[1], aatab[2], "Arrow color" ),
    arrow_colourpicker = ui.new_color_picker( aatab[1], aatab[2], "cac", 255, 151, 0, 255 ),
}

local set_cfg = ui.new_button(aatab[1], aatab[2], "Set default config", function()
    ui.set(aa.enable_checkbox, true)
    ui.set(aa.jitter_checkbox, true)
    ui.set(aa.lowdelta_slow_walk_checkbox, true)
    ui.set(aa.in_air_checkbox, true)
    ui.set(aa.legmovement_checkbox, true)
    ui.set(aa.legit_aa_on_e, true)


    ui.set(visuals.configure_vis_combobox, "Text & Indicators")
    ui.set(visuals.indicators_multiselect, "Screen indicators", "Arrows")
    ui.set(visuals.textindicators_multiselect, "Screen indicators",  "LUA Name", "AA State", "Ragebot state indicators")
    ui.set(visuals.indicatorypos_slider, "-38")

    ui.set(visuals.fontstyle_combobox, "Bold")
    ui.set(visuals.centered_text, true)
end)

local reset_cfg = ui.new_button(aatab[1], aatab[2], "Reset config", function()
    ui.set(aa.enable_checkbox, true)
    ui.set(aa.jitter_checkbox, false)
    ui.set(aa.lowdelta_slow_walk_checkbox, false)
    ui.set(aa.in_air_checkbox, false)
    ui.set(aa.legmovement_checkbox, false)
    ui.set(aa.legit_aa_on_e, false)

  --  ui.set(aa.increase_speed, false)
  --  ui.set(aa.dt_accuracy, false)

    ui.set(visuals.configure_vis_combobox, "Text & Indicators")
    ui.set(visuals.indicators_multiselect, "Screen indicators", "")
    ui.set(visuals.textindicators_multiselect, "Screen indicators")
    ui.set(visuals.indicatorypos_slider, "0")


    ui.set(visuals.fontstyle_combobox, "Block")
    ui.set(visuals.centered_text, false)
end)

-- anti-aim references
local ref_aa_enabled = ui.reference( "AA", "Anti-aimbot angles", "Enabled" )
local ref_body_freestanding = ui.reference( "AA", "Anti-aimbot angles", "Freestanding body yaw" )
local ref_pitch = ui.reference( "AA", "Anti-aimbot angles", "Pitch" )
local ref_yaw, ref_yaw_offset = ui.reference( "AA", "Anti-aimbot angles", "Yaw" )
local ref_body_yaw, ref_body_yaw_offset = ui.reference( "AA", "Anti-aimbot angles", "Body yaw" )
local ref_yaw_base = ui.reference( "AA", "Anti-aimbot angles", "Yaw base" )
local ref_jitter, ref_jitter_slider = ui.reference( "AA", "Anti-aimbot angles", "Yaw jitter" )
local ref_fake_limit = ui.reference( "AA", "Anti-aimbot angles", "Fake yaw limit" )
local ref_edge_yaw = ui.reference( "AA", "Anti-aimbot angles", "Edge yaw" )
local ref_freestanding, ref_freestanding_key = ui.reference( "AA", "Anti-aimbot angles", "Freestanding" )
local ref_fake_lag = ui.reference ( "AA", "Fake lag", "Amount" )
local ref_fake_lag_limit = ui.reference ( "AA", "Fake lag", "Limit" )
local ref_fakeduck = ui.reference ( "RAGE", "Other", "Duck peek assist" )
local ref_legmovement = ui.reference ( "AA", "Other", "Leg movement" )
local ref_slow_walk, ref_slow_walk_key = ui.reference ( "AA", "Other", "Slow motion" )

-- rage references
local ref_doubletap = { ui.reference( "RAGE", "Other", "Double Tap" ) }
local ref_doubletaptwo = ui.reference( "RAGE", "Other", "Double Tap" )
local ref_dt_hit_chance = ui.reference( "RAGE", "Other", "Double tap hit chance" )
local ref_osaa, ref_osaa_hkey = ui.reference( "AA", "Other", "On shot anti-aim" )
local ref_mindmg = ui.reference( "RAGE", "Aimbot", "Minimum damage" )
local ref_fba_key = ui.reference( "RAGE", "Other", "Force body aim" )
local ref_fsp_key = ui.reference( "RAGE", "Aimbot", "Force safe point" )

-- misc references
local sv_maxusrcmdprocessticks = ui.reference( "MISC", "Settings", "sv_maxusrcmdprocessticks" )
-- end of menu references and menu creation

 
-- main vars
-- anti-aim vars
local predict_ticks         = 17
local in_yaw                = -5
local out_yaw               = -3
local randomiser_allowed    = true
local aa_yaw                = -5
local allow_reset_hit       = true
local static_yaw            = 0
local shooting_low_delta    = false
local low_delta_hit         = false
local should_swap           = false
local last_time_peeked      = nil

-- indicator vars
local dtState_y             = 0
local hsState_y             = 0
local baimstate_y           = 0
local spstate_y             = 0
local freestandState_y      = 0
local cur_alpha             = 255
local target_alpha          = 0
local max_alpha             = 255
local min_alpha             = 0
local speed                 = 0.04

-- log info vars
local AASTATE_INFO          = "UNKNOWN"
local INVERTS_INFO          = 0
local ANTIBF_INFO           = "NOT_INVERTED"


-- dt hitchance vars
local hitchance             = 0
local vel                   = 0
local spread_compensation   = 0

-- dt vars
local next_attack           = 0
local next_shot_secondary   = 0
local next_shot             = 0
-- end of vars

-- create the table where info will be stored
local data = {
    side = 1,
    last_side = 0,
    last_hit = 0,
    hit_side = 0
}
-- end of table

-- start of FUNCTIONS

-- this will check what is chosen in the multiselect box for indicators

local function draw_circle( ctx, x, y, r, g, b, a, radius, start_degrees, percentage )
    client.draw_circle( ctx,  x, y, r, g, b, a, radius, start_degrees, percentage )
end

local function draw_rectangle(x, y, w, h, r, g, b, a)
    renderer.rectangle(x, y, w, h, r, g, b, a)
end

local function draw_gradient( ctx, x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr )
    client.draw_gradient( ctx, x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr )
end

local function draw_circle_outline( ctx, x, y, r, g, b, a, radius, start_degrees, percentage, thickness )
    client.draw_circle_outline( ctx, x, y, r, g, b, a, radius, start_degrees, percentage, thickness )
end

local function contains( tab, val )
    for index, value in ipairs( tab ) do
        if value == val then return true end
    end
    return false
end

--function dt_speed( )
  --  ui.set_visible( sv_maxusrcmdprocessticks, true )
  --  ui.set_callback( aa.increase_speed, function( ) ui.set( sv_maxusrcmdprocessticks, ui.get( aa.increase_speed ) and 18 or 16 ) cvar.cl_clock_correction:set_int( ui.get( aa.increase_speed ) and 0 or 1 ) end )
  --  ui.set_callback( ref_fake_lag_limit, function( ) ui.set( ref_fake_lag_limit, math.min( 14, ui.get( ref_fake_lag_limit ) ) ) end )
--end
-- get nearest function


-- distance conversion
local function units_to_meters( units )

    return math.floor( ( units*0.0254 )+0.5)
end

local function units_to_feet( units )

    return math.floor( ( units_to_meters( units )*3.281 )+0.5 )
end
-- end of distance conversion

-- this gets the closest target -- thanks to peer
local function get_nearest( )
    local me = Vector3( entity.get_prop( entity.get_local_player( ), "m_vecOrigin" ) )
    
    local nearest_distance
    local nearest_entity

    for _, player in ipairs( entity.get_players( true ) ) do
        local target = Vector3( entity.get_prop( player, "m_vecOrigin") )
        local _distance = me:dist_to( target )

        if ( nearest_distance == nil or _distance < nearest_distance ) then
            nearest_entity = player
            nearest_distance = _distance
        end  
    end

    if ( nearest_distance ~= nil and nearest_entity ~= nil ) then
        return ( { target = nearest_entity, distance = units_to_feet( nearest_distance ) } )
    end
end
-- end of getting closest target



-- start of dt function to check whether dt is charged or not
local function is_dt( )

    local dt = false

    local local_player = entity.get_local_player()

    if local_player == nil then
        return
    end

    if not entity.is_alive( local_player ) then
        return
    end

    local active_weapon = entity.get_prop( local_player, "m_hActiveWeapon" )

    if active_weapon == nil then
        return
    end

    next_attack = entity.get_prop( local_player,"m_flNextAttack" )
    next_shot = entity.get_prop( active_weapon,"m_flNextPrimaryAttack" )
    next_shot_secondary = entity.get_prop( active_weapon,"m_flNextSecondaryAttack" )

    if next_attack == nil or next_shot == nil or next_shot_secondary == nil then
        return
    end

    next_attack = next_attack+0.5
    next_shot = next_shot+0.5
    next_shot_secondary = next_shot_secondary+0.5

    if ui.get( ref_doubletap[ 1 ] ) and ui.get( ref_doubletap[ 2 ] ) then
        if math.max( next_shot, next_shot_secondary ) < next_attack then
            if next_attack-globals.curtime( ) > 0.00 then
                dt = false
            else
                dt = true
            end
        else -- shooting or just shot
            if math.max( next_shot, next_shot_secondary )-globals.curtime( ) > 0.00  then
                dt = false
            else
                if math.max( next_shot, next_shot_secondary )-globals.curtime( ) < 0.00  then
                    dt = true
                else
                    dt = true
                end
            end
        end
    end

    return dt
end
-- end of dt function to check whether dt is charged or not

-- start of the anti-aim peeking function for smart jitter
local function get_near_target( )
    local enemy_players = entity.get_players( true )
    if #enemy_players ~= 0 then
        local own_x, own_y, own_z = client.eye_position( )
        local own_pitch, own_yaw = client.camera_angles( )
        local closest_enemy = nil
        local closest_distance = 999999999

        for i = 1, #enemy_players do
            local enemy = enemy_players[i]
            local enemy_x, enemy_y, enemy_z = entity.get_prop( enemy, "m_vecOrigin" )

            local x = enemy_x - own_x
            local y = enemy_y - own_y
            local z = enemy_z - own_z

            local yaw = ( ( math.atan2( y, x )*180/math.pi ) )
            local pitch = -( math.atan2( z, math.sqrt( math.pow( x, 2 ) + math.pow( y, 2 ) ) )*180/math.pi )

            local yaw_dif = math.abs( own_yaw%360-yaw%360 )%360
            local pitch_dif = math.abs( own_pitch-pitch )%360

            if yaw_dif > 180 then yaw_dif = 360-yaw_dif end
            local real_dif = math.sqrt( math.pow( yaw_dif, 2)+math.pow( pitch_dif, 2 ) )

            if closest_distance > real_dif then
                closest_distance = real_dif
                closest_enemy = enemy
            end
        end

        if closest_enemy ~= nil then
            return closest_enemy, closest_distance
        end
    end

    return nil, nil
end
-- end of the anti-aim peeking function for smart jitter

-- this is a function to help with on peeking and getting peeked functions
local function distance_3d( x1, y1, z1, x2, y2, z2 )

        return math.sqrt( ( x1-x2 )*( x1-x2 )+( y1-y2 )*( y1-y2 ) )
end

-- function for extrapolating player
local function extrapolate( player , ticks , x, y, z )
    local xv, yv, zv =  entity.get_prop( player, "m_vecVelocity" )
    local new_x = x+globals.tickinterval( )*xv*ticks
    local new_y = y+globals.tickinterval( )*yv*ticks
    local new_z = z+globals.tickinterval( )*zv*ticks
    return new_x, new_y, new_z

end
-- end of functions to help with on peeking and getting peeked functions

-- this is the start of a function for detecting whether the local player is peeking an enemy
local function is_enemy_peeking( player )
    local vx,vy,vz = entity.get_prop( player, "m_vecVelocity" )
    local speed = math.sqrt( vx*vx+vy*vy+vz*vz )
    if speed < 5 then
        return false
    end
    local ex, ey, ez = entity.get_origin( player ) 
    local lx, ly, lz = entity.get_origin( entity.get_local_player ( ) )
    local start_distance = math.abs( distance_3d( ex, ey, ez, lx, ly, lz ) )
    local smallest_distance = 999999
    for ticks = 1, predict_ticks do
        local tex,tey,tez = extrapolate( player, ticks, ex, ey, ez )
        local distance = math.abs( distance_3d( tex, tey, tez, lx, ly, lz ) )

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
-- this is the end of a function for detecting whether the local player is peeking an enemy

-- this is the start of a function for detecting whether the enemy is peeking the local player
local function is_local_peeking_enemy( player )
    local vx,vy,vz = entity.get_prop( entity.get_local_player(), "m_vecVelocity")
    local speed = math.sqrt( vx*vx+vy*vy+vz*vz )
    if speed < 5 then
        return false
    end
    local ex,ey,ez = entity.get_origin( player )
    local lx,ly,lz = entity.get_origin( entity.get_local_player() )
    local start_distance = math.abs( distance_3d( ex, ey, ez, lx, ly, lz ) )
    local smallest_distance = 999999
    if ticks ~= nil then
        TICKS_INFO = ticks
    else
    end
    for ticks = 1, predict_ticks do

        local tex,tey,tez = extrapolate( entity.get_local_player(), ticks, lx, ly, lz )
        local distance = distance_3d( ex, ey, ez, tex, tey, tez )

        if distance < smallest_distance then
            smallest_distance = math.abs(distance)
        end
    if smallest_distance < start_distance then
            return true
        end
    end
    return smallest_distance < start_distance
end
-- this is the end of a function for detecting whether the enemy is peeking the local player


function in_air( )
    return ( bit.band( entity.get_prop( entity.get_local_player( ), "m_fFlags" ), 1 ) == 0 )
end

local function get_closest_point(A, B, P)
   local a_to_p = { P[1] - A[1], P[2] - A[2] }
   local a_to_b = { B[1] - A[1], B[2] - A[2] }
   local ab = a_to_b[1]^2 + a_to_b[2]^2
   local dots = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
   local t = dots / ab
    
   return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end

local function vec3_dot(ax, ay, az, bx, by, bz)

    return ax*bx + ay*by + az*bz
end

local function vec3_normalize(x, y, z)
    local len = math.sqrt(x * x + y * y + z * z)
    if len == 0 then
        return 0, 0, 0
    end
    local r = 1 / len
    return x*r, y*r, z*r
end

local function angle_to_vec(pitch, yaw)
    local p, y = math.rad(pitch), math.rad(yaw)
    local sp, cp, sy, cy = math.sin(p), math.cos(p), math.sin(y), math.cos(y)
    return cp*cy, cp*sy, -sp
end

local function get_fov_cos(ent, vx,vy,vz, lx,ly,lz)
    local ox,oy,oz = entity.get_prop(ent, "m_vecOrigin")
    if ox == nil then
        return -1
    end

    -- get direction to player
    local dx,dy,dz = vec3_normalize(ox-lx, oy-ly, oz-lz)
    return vec3_dot(dx,dy,dz, vx,vy,vz)
end

local function Angle_Vector(angle_x, angle_y)
    local sp, sy, cp, cy = nil
    sy = math.sin(math.rad(angle_y));
    cy = math.cos(math.rad(angle_y));
    sp = math.sin(math.rad(angle_x));
    cp = math.cos(math.rad(angle_x));
    return cp * cy, cp * sy, -sp;
end
-- start of MAIN FUNCTIONS

-- TARGET CAN SEE OUR HEAD
function can_enemy_hit_head( ent )
    if ent == nil then return end
    if in_air( ent ) then return false end
    
    local origin_x, origin_y, origin_z = entity_get_prop( ent, "m_vecOrigin" )
    if origin_z == nil then return end
    origin_z = origin_z + 64

    local hx,hy,hz = entity.hitbox_position( entity.get_local_player( ), 0 ) 
    local _, head_dmg = client.trace_bullet( ent, origin_x, origin_y, origin_z, hx, hy, hz, true )
        
    return head_dmg ~= nil and head_dmg > 25
end

-- this gets the current bomb time if planted
local function get_bomb_time( )
    local bomb = entity.get_all( "CPlantedC4" )[1]
    if bomb == nil then 
        return 0  
    end
    local bomb_time = entity.get_prop( bomb, "m_flC4Blow" )-globals.curtime( ) 
    if bomb_time == nil then 
        return 0
    end
    if bomb_time > 0 then
        return bomb_time
    end
    return 0
end
-- end of function for getting bomb time

-- checks if the local player has a defuser
local function has_defuser( player )

    return entity.get_prop( player, "m_bHasDefuser" ) == 1
end
-- end of checking if the local player has a defuser

local function side_freestanding( cmd )
    -- gets the local player
    local local_player = entity.get_local_player( )
    -- checks if our local player is dead
    if ( not local_player or entity.get_prop( local_player, "m_lifeState" ) ~= 0 ) or not ui.get( aa.enable_checkbox ) == true then
        return
    end
    
    local server_time = globals.curtime( )
    -- check if we have invert desync on side is done
    if data.hit_side ~= 0 and server_time - data.last_hit > 5 then
        -- if so set the last side to '0' so the anti-aim updates
        data.last_side = 0

        -- And reset the smart mode info
        data.last_hit = 0
        data.hit_side = 0
    end

    -- Get what mode our freestanding is using
    local _mode = ui.get( aa.freestand_mode_combobox )

    -- Get some properties
    local x, y, z = client.eye_position( )
    local _, yaw = client.camera_angles( )

    -- Create a table where the trace data will be stored
    local trace_data = { left = 0, right = 0 }

    for i = yaw-120, yaw+120, 30 do
        -- don't do any calculations if the yaw is the correct value
        -- this means that this is the center point
        if i ~= yaw then
            -- Convert our yaw to radians in order to do further calculations
            local rad = math.rad( i )

            -- Calculate our destination point
            local px, py, pz = x+256*math.cos( rad ), y+256*math.sin( rad ), z

            -- Trace a line from our eye position to the previously calculated point
            local fraction = client.trace_line( local_player, x, y, z, px, py, pz )
            local side = i < yaw and "left" or "right"

            -- Add the trace's fraction to the trace table
            trace_data[ side ] = trace_data[ side ]+fraction
        end
    end

    -- Get which side has the lowest fraction amount, which means that it is closer to us.
    data.side = trace_data.left < trace_data.right and 1 or 2

    -- If our side didn't change from the last tick then there's no need to update our anti-aim
    if data.side == data.last_side then
        return
    end

    -- If it did change, then update our cached side to do further checks
    data.last_side = data.side

    -- Check if we should override our side due to the smart mode
    if data.hit_side ~= 0 then
        data.side = data.hit_side == 1 and 2 or 1
    end

    -- Get the fake angle's maximum length and calculate what our next body offset should be
    local limit = 90
    local lby = _mode == "Reversed" and ( data.side == 1 and limit or -limit ) or ( data.side == 1 and -limit or limit )
    static_yaw = lby
    
    -- Update our body yaw settings
    ui.set( ref_body_yaw_offset, limit )
end

-- this is the check for checking if we should use eye yaw or opposite

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
--#endregion /helpers

local bind_system = {
    left = false,
    right = false,
    back = false,
}

function bind_system:update()
    ui.set( aa.manual_left_hotkey, "On hotkey" )
    ui.set( aa.manual_right_hotkey , "On hotkey" )
    ui.set( aa.manual_back_hotkey, "On hotkey" )

    local m_state = ui.get( aa.manual_state )

    local left_state, right_state, backward_state = 
        ui.get( aa.manual_left_hotkey ), 
        ui.get( aa.manual_right_hotkey ),
        ui.get( aa.manual_back_hotkey )

    if  left_state == self.left and 
        right_state == self.right and
        backward_state == self.back then
        return
    end

    self.left, self.right, self.back = 
        left_state, 
        right_state, 
        backward_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) or (backward_state and m_state == 3) then
        ui.set( aa.manual_state , 0)
        return
    end

    if left_state and m_state ~= 1 then
        ui.set( aa.manual_state , 1)
    end

    if right_state and m_state ~= 2 then
        ui.set( aa.manual_state , 2)
    end

    if backward_state and m_state ~= 3 then
        ui.set( aa.manual_state , 3)
    end
end

local menu_callback = function(e, menu_call)
    local state = not ui.get( aa.manualaa_checkbox ) -- or (e == nil and menu_call == nil)
    multi_exec(ui.set_visible, {
        [ aa.manual_left_hotkey ] = not state,
        [ aa.manual_right_hotkey ] = not state,
        [ aa.manual_back_hotkey ] = not state,
        [ aa.manual_state ] = false,
    })
end

ui.set_callback( aa.manualaa_checkbox , menu_callback)

function handle_manual_anti_aim()
    local direction = ui.get( aa.manual_state )

    manual_yaw = 
    {
        [0] = 0,
        [1] = -90, 
        [2] = 90,
        [3] = 0,
    }

    if ui.get( aa.manualaa_checkbox ) then
        if direction == 1 or direction == 2 then
            ui.set( ref_yaw_base, "Local view" )
        else
            ui.set( ref_yaw_base, "At targets" )
        end
    end

    if ui.get( aa.manualaa_checkbox ) then
        ui.set( ref_yaw_offset, manual_yaw[direction] )
    end


    local callback = enabled and client.set_event_callback or client.unset_event_callback
end

-- start of setup_command
local reset = false
local function on_setup_command( cmd )

    if ui.get( aa.legit_aa_on_e ) then
        local gun = entity.get_player_weapon( entity.get_local_player( ) )
        if gun ~= nil and entity.get_classname( gun ) == "CC4" then
            if cmd.in_attack == 1 then
                cmd.in_attack = 0 
                cmd.in_use = 1
            end
        else
            if cmd.chokedcommands == 0 then
                cmd.in_use = 0
            end
        end
    end

    -- this gets the desync angle of the local player
    if cmd.chokedcommands == 0 then
        angle = cmd.in_use == 0 and ui.get( ref_aa_enabled ) and ui.get( ref_body_yaw ) ~= "Off" and math.min( 57, math.abs( entity.get_prop( entity.get_local_player( ), "m_flPoseParameter", 11 )*120-60 ) ) or 0
    end


    --fakelag
    choked_commands = cmd.chokedcommands


    local bFreezePeriod = entity.get_prop(entity.get_game_rules(), "m_bFreezePeriod")
    if bFreezePeriod then
        INVERTS_INFO = 0
        ui.set( ref_fake_limit, 58 )
    end

    if ui.get(aa.ideal_peek) then
        ui.set(ref_doubletap[1], true)
        ui.set(ref_doubletap[2], "Always on")
        ui.set(ref_freestanding_key, "Always on")
        ui.set(ref_freestanding, "Default")
        ui.set(ref_fake_lag_limit, 1)
        reset = false
    else
        if not reset then
            ui.set(ref_doubletap[1], true)
            ui.set(ref_doubletap[2], "Toggle")
            ui.set(ref_freestanding_key, "On hotkey")
            ui.set(ref_freestanding, "Default")
            ui.set(ref_fake_lag_limit, 14)
            reset = true
        end
    end

    -- start of closest to crosshair check
    ui.set( ref_body_freestanding, false ) 
    local entindex = entity_get_local_player( )
    if entindex == nil then return end
    local lx,ly,lz = entity_get_prop( entindex, "m_vecOrigin" )
    if lx == nil then return end

    -- get closest player to crosshair
    local players = entity.get_players( true )    
    local pitch, yaw = client.camera_angles( )
    local vx, vy, vz = angle_to_vec( pitch, yaw )
    local closest_fov_cos = -1
    enemyclosesttocrosshair = nil
    for i=1, #players do
        local idx = players[ i ]
        if entity_is_alive( idx ) then
            local fov_cos = get_fov_cos( idx, vx, vy, vz, lx, ly, lz )
            if fov_cos > closest_fov_cos then
                closest_fov_cos = fov_cos
                enemyclosesttocrosshair = idx
            end
        end
    end
    -- end of closest to crosshair
end
-- end of setup command

-- start of on bullet impact function
-- this is for anti-bruteforcing ( detecting whether an enemy shot near you )
local function on_bullet_impact( c )
    if entity.is_alive( entity.get_local_player( ) ) then
        local ent = client.userid_to_entindex( c.userid )
        if not entity.is_dormant( ent ) and entity.is_enemy( ent ) then
            local ent_shoot = { entity.get_prop( ent, "m_vecOrigin" ) }
            ent_shoot[ 3 ] = ent_shoot[ 3 ]+entity.get_prop( ent, "m_vecViewOffset[2]" )
            local player_head = { entity.hitbox_position( entity.get_local_player( ), 0 ) }
            local closest = get_closest_point( ent_shoot, { c.x, c.y, c.z }, player_head )
            local delta = { player_head[ 1 ]-closest[ 1 ], player_head[ 2 ]-closest[ 2 ] }
            local delta_2d = math.sqrt( delta[ 1 ]^2+delta[ 2 ]^2 )
            if math.abs( delta_2d ) < 32 then
                INVERTS_INFO = INVERTS_INFO + 1
                should_swap = true
            end
        end
    end
end
-- end of on bullet impact function

function resethit( )
    allow_reset_hit = true
    low_delta_hit = false
end

function on_hit_low_delta( )
    if should_swap == true then
        low_delta_hit = true
        if is_in_range == true then
            if data.side == 1 then
                ui.set( ref_fake_limit, ( math.random( 25, 40 ) ) )
            elseif data.side == 2 then
                ui.set( ref_fake_limit, ( math.random( 22, 35 ) ) )
            end
        elseif is_in_range == false then
            if data.side == 1 then
                ui.set( ref_fake_limit, ( math.random( 28, 39 ) ) )
             elseif data.side == 2 then
                ui.set( ref_fake_limit, ( math.random( 40, 52 ) ) )
            end
        end
        should_swap = false
        allow_reset_hit = false
        local reset = 58
        client.delay_call( 2, resethit )
        client.delay_call( 2, ui_set, ref_fake_limit, reset )
    end
end

function in_air_anti( )
    if in_air( ) then
        ui.set( ref_yaw_offset, 0 )
        ui.set( ref_body_yaw, "Jitter" )
        ui.set( ref_body_yaw_offset, -74)
        ui.set( ref_fake_limit, 45)
        ui.set( ref_body_freestanding, true)
        AASTATE_INFO = "STATE : ( AIR : S3 )"
    end
end

function menu( )
    ui.set_visible( ref_pitch,                  false )
    ui.set_visible( ref_yaw,                    false )
    ui.set_visible( ref_yaw_offset,             false )
    ui.set_visible( ref_body_yaw,               false )
    ui.set_visible( ref_body_yaw_offset,        false )
    ui.set_visible( ref_yaw_base,               false )
    ui.set_visible( ref_jitter,                 false )
    ui.set_visible( ref_jitter_slider,          false )
    ui.set_visible( ref_fake_limit,             false )
    ui.set_visible( ref_freestanding,           false )
    ui.set_visible( ref_edge_yaw,               false )
    ui.set_visible( ref_body_freestanding,      false )
end
client.set_event_callback( "paint", menu )

-- this is what stops the client_delay_call function from overlapping and causing fps issues
function resetshot( )
    SHOOTING_INFO = "FALSE"
end

-- this gets called back when the aimbot fires
function invert_anti_aim( g )
    SHOOTING_INFO = "TRUE"
    client.delay_call( 1, resetshot )
end

function legitaa( )
    ui.set( ref_yaw_base, "Local view" )
    ui.set( ref_yaw_offset, 180 )
    ui.set( ref_pitch, "Off" )
    ui.set( ref_body_yaw, "Static" )
    ui.set( ref_jitter, "Off" )
    ui.set( ref_jitter_slider, 0 )
    ui.set( ref_fake_limit, 58 )
    sj_r, sj_g, sj_b = 255, 0, 0
    ePeeking = true
    once_change = true
    if data.side == 1 then
        ui.set( ref_body_yaw_offset, 60 )
    else
    end
    if data.side == 2 then
        ui.set( ref_body_yaw_offset, -60 )
    else
    end
    AASTATE_INFO = "STATE : ( LEGIT AA )"

    -- this checks if you havent got the legit aakey pressed and sets data.side
    if ui.get( aa.legit_aa_hotkey ) == false and once_change == true and ui.get( aa.enable_checkbox ) == true then
        if ui.get( aa.freestand_mode_combobox ) == "Default" then
            if data.side == 1 then
                ui.set( ref_body_yaw_offset, -60 )
            end
            if data.side == 2 then
                ui.set( ref_body_yaw_offset, 60 )
            end
        end
        if ui.get( aa.freestand_mode_combobox ) == "Reversed" then
            if data.side == 1 then
                ui.set( ref_body_yaw_offset, 60 )
            end
            if data.side == 2 then
                ui.set( ref_body_yaw_offset, -60 )
            end
        end
        once_change = false
    end
    -- end of check
end

local callback = client.set_event_callback or client.unset_event_callback
callback("net_update_end", function( )
    if ui.get( aa.legmovement_checkbox ) then
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
    end
end)

function legfucker( )
    local z = math.random( 1, 3 )
    if z == 1 then
        ui.set( ref_legmovement, "Never slide" )
    elseif z == 2 then
        ui.set( ref_legmovement, "Always slide" )
    elseif z == 3 then
        ui.set( ref_legmovement, "Never slide" )
    end
end

function is_slow_walking( )
    local slow_walking = false
    if not ui.get(ref_slow_walk_key) then
        slow_walking = false
    elseif ui.get(ref_slow_walk_key) then
        slow_walking = true
    end

    return slow_walking
end

function low_delta_slow_walk( )
    if is_slow_walking( ) then
        ui.set( ref_fake_limit, 28 )
        if force_left == 1 then
            data.side = 1
        end
    end
end

function dormancy_fix( )
    if enemy_dormant == true then
        ui.set( ref_yaw_offset, in_yaw )
        ui.set( ref_body_yaw, "Static" )  
    end
end

function handle_basics( )
    -- basic checkboxes and anti_aims
    if ui.get( aa.in_air_checkbox ) then
        in_air_anti( )
    end
  --  if ui.get( aa.increase_speed ) then
    --    dt_speed()
--end

    if ui.get( aa.legit_aa_on_e ) then
        if client.key_state( 0x45 ) then
            ePeeking = true
            ui.set( ref_body_yaw, "Static" )
            if data.side == 1 then 
                ui.set( ref_body_yaw_offset, -58 )
            elseif data.side == 2 then
                ui.set( ref_body_yaw_offset, 58 )
            end
        elseif not client.key_state( 0x45 ) then
            ePeeking = false
        end
    elseif not ui.get( aa.legit_aa_on_e ) then
        ePeeking = false
    end

    -- updates our anti-aim for after legit aa on key
    ui.set( ref_pitch, "Default" )
    -- end of check

    -- checks if the enemy is dormant
    if not entity.is_dormant( player ) and entity.is_alive( player ) then
        enemy_dormant = false
    else
        enemy_dormant = true
    end
    -- end of dormancy check

    -- checks if the smart jitter is on and if you are dormant it forces your yaw bac to inrange yaw so the e-peeking still works
    if ui.get( aa.jitter_checkbox ) and enemy_dormant == true and not ui.get(aa.manualaa_checkbox) then
        dormancy_fix( )
    else
    end
    -- end of check

    -- this checks if you have the legmovement option on and what it should do
    if ui.get( aa.legmovement_checkbox ) == true then
        legfucker( )
    end
    -- end of check

    -- this checks if you have pressed the legit aa key and if you have it sets your aa to a "legit aa" format
    if ui.get( aa.legit_aa_hotkey ) == true and ui.get( aa.legit_aa_on_e ) and ui.get( aa.enable_checkbox ) == true then
        legitaa( )
    else
    end
    -- end of legit aa check
end

function handle_indicator_colours( )
    -- this changes the colour of the arrows depending on what delta you have
    if allow_reset_hit == true then
        dr, dg, db, da = cac_r, cac_g, cac_b, cac_a
    else
        if ui.get( ref_fake_limit ) <= 37 then
            dr, dg, db, da = cac_r, cac_g, cac_b, alpha
        elseif ui.get( ref_fake_limit ) > 37 then
            dr, dg, db, da = cac_r, cac_g, cac_b, alpha
        end
    end
    -- end of check
end

local function is_under_health( )
    under_health = false
    if ( entity_get_prop( entity.get_local_player( ), "m_iHealth" ) <= 28 ) then
        under_health = true
    else
        under_health = false
    end
    return under_health
end


local function compensate_spread( )
    -- this gets your velocity and if your velocity is < 0 (aka going forwards) it will convert your velocity back to positive
    vel = entity.get_prop( entity.get_local_player( ), "m_vecVelocity" )
    if vel < 0 then
        vel = vel*-1
    end

    -- spread compensation calculation for dt_hitchance
    spread_compensation = ( vel * 0.037 )
    if spread_compensation < 1 then
        spread_compensation = 1
    end

    return spread_compensation
end

function handle_anti_aims( )
  

    if ui.get( aa.lowdelta_slow_walk_checkbox ) then
        if is_slow_walking( ) then
            ui.set(ref_body_yaw_offset, 90)
        end
    end

    -- if you are out of range of the enemy it sets your yaw to the out of range yaw
    if is_in_range == false and ui.get( aa.jitter_checkbox ) then
        if not ui.get( aa.manualaa_checkbox ) then
            if ePeeking == false then
                ui.set( ref_yaw_offset, out_yaw )
            end
        else
        end
    end
    -- end of check


    -- checks if you have safeyaw enabled and if you are under under health
    -- it also checks if you have peek out or safe head on
    if is_under_health( ) then
        safe_yaw = 15
    elseif data.side == 2 then
        safe_yaw = -15
    end
    -- end of safe yaw check
end




-- start of on run command
local on_run_command = function( cmd )
    -- Checks if the local player is alive
    local local_player = entity.get_local_player( )
    if ( not entity.is_alive( local_player ) ) then
        return     
    end
    -- This applies the fake_limit_randomisation 
    if ui.get( aa.jitter_checkbox ) then
        fake_limit_randomisation( )
    end

    -- Slow walk anti-aim
    if is_slow_walking( ) then -- If slow walking and anti-aim right hybrid is not enabled
        slow_walking_aa( )
    end

    if ePeeking == true then ui.set( ref_freestanding, "-" ) else ui.set( ref_freestanding, "Default" ) end
   -- if ui.get( aa.dt_accuracy ) then adaptive_dt_hitchance( ) end
    if ui.get( aa.lowdelta_slow_walk_checkbox ) then low_delta_slow_walk( ) end

    if not ui.get( aa.manualaa_checkbox) then
        ui.set( ref_yaw_base, "At targets" )
    end

    handle_manual_anti_aim()

    -- forces should_swap to false so bruteforce resets
    should_swap = false

    -- handle functions
    menu( )
    side_freestanding( )
    handle_indicator_colours( )
    handle_anti_aims( )
    handle_basics( )

    -- data check if the nearest option is nil and if not it ends the function
    data2 = get_nearest( )
    if ( data2 == nil ) then
        return
    end
    if ( data2.distance < 120 ) then
        is_in_range = true
    else
        is_in_range = false
    end
    -- end of check
end

function fake_randomisation( )
    ui.set(ref_fake_limit, math.random( 25, 40 ) ) randomiser_allowed = true
end

function fake_limit_randomisation( )
    -- This is for fake limit ( low delta ) randomisation
    if ui.get( aa.jitter_checkbox ) then
        if randomiser_allowed == true then
            client.delay_call( 0.02, fake_randomisation ) randomiser_allowed = false
        end
    end
    -- This will only be called in static anti-aim scenarios
end

function slow_walking_aa( )
    ui.set( ref_yaw_offset, -5 )
    ui.set( ref_jitter, "Offset" )
    ui.set( ref_jitter_slider, 11 )
    ui.set( ref_body_yaw, "Static" )
    ui.set( ref_body_yaw_offset, 28 )
end

function right_static( )
    -- Actual anti-aim
    if ui.get( aa.freestand_mode_combobox ) == "Default" then
        body_yaw = -116
    elseif ui.get( aa.freestand_mode_combobox ) == "Reversed" then
        body_yaw = 116
    end
    -- Changes yaw if safe yaw combobox is enabled
    if is_under_health( ) then
        peek_yaw = 17
        AASTATE_INFO = "STATE : ( RIGHT : S3 )"
    else
        peek_yaw = ( in_yaw + 1 )
        AASTATE_INFO = "STATE : ( RIGHT : S1 )"
    end
    -- If you should anti-bruteforce it will change your body yaw to the opposite side.
    if should_swap == true and ui.get( aa.jitter_checkbox ) then
        body_yaw = body_yaw * -1
        should_swap = false
        ANTIBF_INFO = "RP_S1-3_INVERT"
        client.delay_call( 3 , ui_set, ref_body_yaw_offset, -116 )
    end
    -- Sets your yaw to the correct yaw
    ui.set( ref_yaw_offset, peek_yaw )
    ui.set( ref_body_yaw_offset, body_yaw )
    ui.set( ref_body_yaw, "Static" )
    ui.set( ref_jitter, "Random" )
    ui.set( ref_jitter_slider, 2 )
end

function right_static_alternative( )
    -- Actual anti-aim
    if ui.get( aa.freestand_mode_combobox ) == "Default" then
        body_yaw = -132
    elseif ui.get( aa.freestand_mode_combobox ) == "Reversed" then
        body_yaw = 132
    end
    -- Changes yaw if safe yaw combobox is enabled
    if is_under_health( ) then
        peek_yaw = 17
        AASTATE_INFO = "STATE : ( RIGHT : S4 )"
    else
        peek_yaw = ( in_yaw + 1 )
        AASTATE_INFO = "STATE : ( RIGHT : S2 )"
    end
    -- If you should anti-bruteforce it will change your body yaw to the opposite side.
    if should_swap == true and ui.get( aa.jitter_checkbox ) then
        body_yaw = body_yaw * -1
        should_swap = false
        ANTIBF_INFO = "RP_S2-4_INVERT"
        client.delay_call( 3 , ui_set, ref_body_yaw_offset, -116 )
    end
    -- Sets your yaw to the correct yaw
    ui.set( ref_yaw_offset, peek_yaw )
    ui.set( ref_body_yaw_offset, body_yaw )
    ui.set( ref_body_yaw, "Static" )
    ui.set( ref_jitter, "Off" )
    ui.set( ref_jitter_slider, 0 )
end

function left_static( )
    -- Actual anti-aim
    if ui.get( aa.freestand_mode_combobox ) == "Default" then
        body_yaw = 113
    elseif ui.get( aa.freestand_mode_combobox ) == "Reversed" then
        body_yaw = -113
    end
    -- Changes yaw if safe yaw combobox is enabled
    if is_under_health( ) then
        peek_yaw = -17
        AASTATE_INFO = "STATE : ( LEFT : S3 )"
    else
        peek_yaw = ( in_yaw )
        AASTATE_INFO = "STATE : ( LEFT : S1 )"
    end
    if should_swap == true and ui.get( aa.jitter_checkbox ) then
        body_yaw = body_yaw * -1
        should_swap = false
        ANTIBF_INFO = "LP_S1-3_INVERT"
        client.delay_call( 3, ui_set,  ref_body_yaw_offset, 113 )
    end
    ui.set( ref_yaw_offset, peek_yaw )
    ui.set( ref_body_yaw_offset, body_yaw )
    ui.set( ref_body_yaw, "Static" )
    ui.set( ref_jitter, "Random" )
    ui.set( ref_jitter_slider, 2 )
end

function left_static_alternative( )
    -- Actual anti-aim
    if ui.get( aa.freestand_mode_combobox ) == "Default" then
        body_yaw = 116
    elseif ui.get( aa.freestand_mode_combobox ) == "Reversed" then
        body_yaw = -116
    end
    -- Changes yaw if safe yaw combobox is enabled
    if is_under_health( ) then
        peek_yaw = -17
        AASTATE_INFO = "STATE : ( LEFT : S4 )"
    else
        peek_yaw = ( in_yaw )
        AASTATE_INFO = "STATE : ( LEFT : S2 )"
    end
    if should_swap == true and ui.get( aa.jitter_checkbox ) then
        body_yaw = body_yaw * -1
        should_swap = false
        ANTIBF_INFO = "LP_S2-4_INVERT"
        client.delay_call( 3, ui_set,  ref_body_yaw_offset, 113 )
    end
    ui.set( ref_yaw_offset, peek_yaw )
    ui.set( ref_body_yaw_offset, body_yaw )
    ui.set( ref_body_yaw, "Static" )
    ui.set( ref_jitter, "Off" )
    ui.set( ref_jitter_slider, 0 )
end


-- useless, just for testing new offsets
-- jittertestrj = ui.new_slider( aatab[1], aatab[2], "test side jitters", 0, 180, 0, true, ""  ) -- ui.get( jittertestrj )
-- backtestjt = ui.new_slider( aatab[1], aatab[2], "test back jitters", 0, 180, 0, true, "" ) -- ui.get( backtestjt )

function back_jitter( )
    if is_in_range == true then
        if is_under_health( ) then
            if data.side == 1 then
                local yaw_offset = 15
                ui.set( ref_yaw_offset, yaw_offset )
                AASTATE_INFO = "STATE : ( DYNAMIC : S3 )"
            elseif data.side == 2 then
                local yaw_offset = -15
                ui.set( ref_yaw_offset, yaw_offset )
                AASTATE_INFO = "STATE : ( DYNAMIC : S1 )"
            end
        else
            ui.set( ref_yaw_offset, in_yaw )
            AASTATE_INFO = "STATE : ( DYNAMIC : S1 )"
        end
        AASTATE_INFO = "STATE : ( DYNAMIC : S2 )"
    elseif is_in_range == false and ePeeking == false then
        ui.set( ref_yaw_offset, out_yaw )
        AASTATE_INFO = "STATE : ( DYNAMIC : S4 )"
    end
    ui.set( ref_body_yaw, "Jitter" )
    ui.set( ref_jitter, "Offset" )
    ui.set( ref_jitter_slider, 14 )
end

function static_freestanding( )
    -- Actual anti-aim
    if is_in_range == true then
        ui.set(ref_body_yaw, "Static")
        if data.side == 1 then
            if should_swap == true and ui.get( aa.jitter_checkbox ) then
                static_yaw = static_yaw * -1
                should_swap = false
                ANTIBF_INFO = "FS_S1_INVERT"
            end
            ui.set(ref_body_yaw_offset, static_yaw)
            AASTATE_INFO = "STATE : ( ADAPTIVE : S1 )"
        elseif data.side == 2 then
            if should_swap == true and ui.get( aa.jitter_checkbox ) then
                static_yaw = static_yaw * -1
                should_swap = false
                ANTIBF_INFO = "FS_S1_INVERT"
            end
            ui.set(ref_body_yaw_offset, static_yaw)
            AASTATE_INFO = "STATE : ( ADAPTIVE : S1 )"
        end
    end
    if is_in_range == true then
        if is_under_health( ) then
            if data.side == 1 then
                local yaw_offset = 15
                ui.set( ref_yaw_offset, yaw_offset )
                AASTATE_INFO = "STATE : ( ADAPTIVE : S4 )"
            elseif data.side == 2 then
                local yaw_offset = -15
                ui.set( ref_yaw_offset, yaw_offset )
                AASTATE_INFO = "STATE : ( ADAPTIVE : S4 )"
            end
        else
            AASTATE_INFO = "STATE : ( ADAPTIVE : S2 )"
            ui.set( ref_yaw_offset, in_yaw )
        end
    elseif is_in_range == false and ePeeking == false then
        AASTATE_INFO = "STATE : ( ADAPTIVE : S3 )"
        ui.set( ref_yaw_offset, out_yaw )
    end
    ui.set( ref_body_yaw, "Jitter" )
    ui.set( ref_jitter, "Offset" )
    ui.set( ref_jitter_slider, 14 )
end

function handle_dt_indicator( )
    -- checks if dt is inactive, charging or charged
    if ui.get( ref_doubletap[ 1 ] ) and ui.get( ref_doubletap[ 2 ] ) then
        if is_dt( ) then
            doubletap_one = true
            doubletap_two = false
            doubletap_three = false
        else
            doubletap_one = false
            doubletap_two = true
            doubletap_three = false
        end
    else
        doubletap_one = false
        doubletap_two = false
        doubletap_three = true
    end

    -- this checks what DT msg should be displayed for the DT indicator and what colours it show be
    -- if the double tap is charged show the colour we have chosen for that
    if doubletap_one == true then
        dt_r, dt_g, dt_b = 154, 255, 31
        dtalpha = 255
        dtmsg = "DT"
    else
    end

    -- if the doubletap is charging display this colour
    if doubletap_two == true then
        dt_r, dt_g, dt_b = 255, 0, 0
        dtalpha = 255
        dtmsg = "DT"
    else
    end

    -- if doubletap is inactive then do not display any text
    if doubletap_three == true then
        dt_r, dt_g, dt_b = 255, 0, 0
        dtalpha = 0
        dtmsg = "  "
    else
    end
    -- end of dt checks
end

function handle_indicator_positions( )
    -- the worlds messiest and hardest code to follow for changing where the indicators should be on the screen
    banepa_y = 65
    if show_ln == 1 then
        animState_y = 75
        if show_aas == 1 then
            dtState_y = 85
        elseif show_aas == 0 then
            dtState_y = 75
        end
    elseif show_ln == 0 then
        animState_y = 65
        if show_aas == 1 then
            dtState_y = 75
        elseif show_aas == 0 then
            dtState_y = 65
        end 
    end
    if not ui.get( ref_osaa_hkey ) then
        if ( doubletap_one == true or doubletap_two == true ) then
            if show_ln == 1 then
                if show_aas == 1 then
                    freestandState_y = 95
                elseif show_aas == 0 then
                    freestandState_y = 85
                end
            elseif show_ln == 0 then
                if show_aas == 1 then
                    freestandState_y = 85
                elseif show_aas == 0 then
                    freestandState_y = 75
                end
            end
        elseif doubletap_three == true then
            if show_ln == 1 then
                if show_aas == 1 then
                    freestandState_y = 85
                elseif show_aas == 0 then
                    freestandState_y = 75
                end
            elseif show_ln == 0 then
                if show_aas == 1 then
                    freestandState_y = 75
                elseif show_aas == 0 then
                    freestandState_y = 65
                end
            end
        end
    elseif ui.get( ref_osaa_hkey ) then
        if ( doubletap_one == true or doubletap_two == true ) then
            if show_ln == 1 then
                if show_aas == 1 then
                    hsState_y = 95
                elseif show_aas == 0 then
                    hsState_y = 85
                end
            elseif show_ln == 0 then
                if show_aas == 1 then
                    hsState_y = 85
                elseif show_aas == 0 then
                    hsState_y = 75
                end
            end
        elseif doubletap_three == true then
            if show_ln == 1 then
                if show_aas == 1 then
                    hsState_y = 85
                elseif show_aas == 0 then
                    hsState_y = 75
                end
            elseif show_ln == 0 then
                if show_aas == 1 then
                    hsState_y = 75
                elseif show_aas == 0 then
                    hsState_y = 65
                end
            end
        end
        if ( doubletap_one == true or doubletap_two == true ) then
            if show_ln == 1 then
                if show_aas == 1 then
                    freestandState_y = 105
                    spstate_y = 115
                elseif show_aas == 0 then
                    freestandState_y = 95
                    spstate_y = 105
                end
            elseif show_ln == 0 then
                if show_aas == 1 then
                    freestandState_y = 95
                elseif show_aas == 0 then
                    freestandState_y = 85
                end
            end
        elseif doubletap_three == true then
            if show_ln == 1 then
                if show_aas == 1 then
                    freestandState_y = 95
                    spstate_y = 105
                elseif show_aas == 0 then
                    freestandState_y = 85
                    spstate_y = 95
                end
            elseif show_ln == 0 then
                if show_aas == 1 then
                    freestandState_y = 85
                    spstate_y = 95
                elseif show_aas == 0 then
                    freestandState_y = 75
                    spstate_y = 85
                end
            end
        end
    end
    -- the end of the worlds messiest and hardest code to follow for changing where the indicators should be on the screen
end

function handle_colours_and_alpha( )
    -- these are the colours for each indicator
    cac_r, cac_g, cac_b, cac_a = ui.get( visuals.arrow_colourpicker ) -- Peeking arrows
    byc_r, byc_g, byc_b, byc_a = ui.get( visuals.banepa_colourpicker ) -- exscord text indicator
    --end
    
    -- pulsating alpha ( yoinked from sigmas lua )
    if ( cur_alpha < min_alpha+2 ) then
        target_alpha = max_alpha
    elseif ( cur_alpha > max_alpha-2 ) then
        target_alpha = min_alpha
    end
    cur_alpha = cur_alpha+( target_alpha-cur_alpha )*speed*( globals.absoluteframetime( )*60 )
    alpha = math.min( 255, cur_alpha )
end

function handle_multi_selects( )
    -- setting variables for multiselect
    mid_text = 0 crooked_arrows = 0 crooked_arrows_two = 0 show_ln = 0 show_aas = 0 show_be = 0 in_air_fl = 0 wh_mov_fl = 0 on_sta_fl = 0 on_vis_fl = 0 wh_vis_fl = 0
    -- end
    -- references for multiselects
    local _inds = ui.get( visuals.indicators_multiselect ) -- Indicators multiselect
    local _textinds = ui.get( visuals.textindicators_multiselect ) -- Text indicators multiselect
    -- End of references

    -- this is what sets the variables  for the indicators multiselect
    if contains( _inds, "Screen indicators" ) then mid_text = 1 end -- Middle text indicators option
    if contains( _inds, "Arrows" ) then crooked_arrows = 1 end -- Peeking arrows indicators option
    -- end of variables for indicators multiselect
    -- sets the variables for text indicators multi select
    if contains( _textinds, "LUA Name" ) then show_ln = 1 end -- LUA name middle indicators option
    if contains( _textinds, "AA State" ) then show_aas = 1 end -- Anti-aim state middle indicators option
    if contains( _textinds, "Ragebot state indicators" ) then show_be = 1 end -- Bind and exploits middle indicators option
    -- end of variables for text indicators multi select
end

function handle_main_indicators( )
    --this gets the client screensize
    local scrsize_x, scrsize_y = client_screensize( )
    local center_x, center_y = scrsize_x/2, scrsize_y/2
    local scrleft_x, scrleft_y = (( scrsize_x-scrsize_x ) +1 ), (( scrsize_y-scrsize_y ) +1 )
    --end
    local x, x2 = 18, 2

    local tags =
     {
        [0] = "",
        [1] = "3",
        [2] = "e",
        [3] = "e|",
        [4] = "e|-",
        [5] = "ex",
        [6] = "ex5",
        [7] = "exs",
        [8] = "exs<",
        [9] = "exsc",
        [10] = "exsc*",
        [11] = "exsc0",
        [12] = "exsco",
        [13] = "exsco|",
        [14] = "exsco|-",
        [15] = "exscor",
        [16] = "exscor|",
        [17] = "exscord",
        [18] = "exscord",
        [19] = "exscord",
        [20] = "exscor|",
        [21] = "exscor",
        [22] = "exsco|-",
        [23] = "exsco|",
        [24] = "exsco",
        [25] = "exsc*",
        [26] = "exsc",
        [27] = "exs<",
        [28] = "exs",
        [29] = "ex5",
        [30] = "ex",
        [31] = "e|-",
        [32] = "e|",
        [33] = "e",
        [34] = "3",
        [35] = "",
        [36] = "",
        [37] = "",
}
    draw_gradient( c, center_x, scrsize_y-x, 120, x2, mt_r, mt_g, mt_b, 125, m_r, m_g, m_b, m_a, true)
    draw_gradient( c, center_x, scrsize_y-x, -120, x2, mt_r, mt_g, mt_b, 255, m_r, m_g, m_b, m_a, true)
    draw_gradient( c, center_x, scrsize_y-x, 120, x, 0, 0, 0, 175, 120, 0, 0, 0, true)
    draw_gradient( c, center_x, scrsize_y-x, -120, x, 0, 0, 0, 175, 120, 0, 0, 0, true)
    renderer.text(center_x, scrsize_y - 8, 250, 255, 255, 255, "c", 0, tags[math.floor((globals.curtime() * 4.5) % 37)] .. " | " .. nickname .. " " .. usertype .. "")
    renderer.text(scrsize_x - 1, scrsize_y - 3, 250, 255, 255, 255, "c", 0, ANTIBF_INFO)
    if  entity.is_alive( entity.get_local_player( ) ) then
        -- this checks what font we should use for our indicators
        -- indicator font style block
        if ui.get( visuals.fontstyle_combobox ) == "Block" then
            if ui.get( visuals.centered_text ) then
                fontstyle = "dc-"
            else
                fontstyle = "d-"
            end
        end

        -- indicator font style default
        if ui.get( visuals.fontstyle_combobox ) == "Default" then
            if ui.get( visuals.centered_text ) then
                fontstyle = "dc"
            else
                fontstyle = "d"
            end
        end

        -- indicator font style bold
        if ui.get( visuals.fontstyle_combobox ) == "Bold" then
            if ui.get( visuals.centered_text ) then
                fontstyle = "bc"
            else
                fontstyle = "b"
            end
        end

        client.set_event_callback( "aim_fire", invert_anti_aim )


        -- this checks if we should draw the write yaw info and what side our data.side is to show if yaw is correct
        if show_yaw == 1 then
            if data.side == 1 then
                client_draw_text( c, center_x+10, center_y+( ui.get( visuals.indicatorypos_slider )+freestandState_y+10 ), 255, 255, 255, 255, "dc-", 0, ui.get( ref_body_yaw_offset ) )
            else
                client_draw_text( c, center_x+10, center_y+( ui.get( visuals.indicatorypos_slider )+freestandState_y+10 ), 255, 255, 255, 255, "dc-", 0, "0" )
            end
            if data.side == 2 then
                client_draw_text( c, center_x-10, center_y+( ui.get( visuals.indicatorypos_slider )+freestandState_y+10 ), 255, 255, 255, 255, "dc-", 0, ui.get( ref_body_yaw_offset ) )
            else
                client_draw_text(c, center_x-10, center_y+( ui.get( visuals.indicatorypos_slider )+freestandState_y+10 ), 255, 255, 255, 255, "dc-", 0, "0" )
            end
        else
        end
        -- end of check

        -- indicators good luck  lol
        if mid_text == 1 and show_ln == 1 then                                                                                       -- this shows that we have the LUA name chosen in indicators
            client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+banepa_y ), byc_r, byc_g, byc_b, byc_a, fontstyle, 0, "EXSCORD" )
        else
        end
        
        -- this shows that we have the On-shot jitter option chosen in indicators
        if mid_text == 1 and show_aas == 1 then -- ANIM shows that we are in a state where our head is fakelagging or we are in a weapon_fire event
            if ui.get( ref_fakeduck ) and ePeeking == false then
            client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+animState_y ), 0, 0, 0, 255, fontstyle, 0, "DUCKING" )
            client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+animState_y ), 255, 179, 71, alpha, fontstyle, 0, "DUCKING" )
            end
            if ePeeking == false and not is_under_health( ) and not ui.get(ref_fakeduck) then -- DYNAMIC shows that we are in a state where our head is safe and we can't be onshotted or we are not fakelagging
                client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+animState_y ), 208, 160, 210, 255, fontstyle, 0, AASTATE_INFO )
            else
            end
            if is_under_health( ) and ePeeking == false and not ui.get(ref_fakeduck) then
                client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+animState_y ), 208, 160, 210, 255, fontstyle, 0, "STATE : ( UNSAFE : 28 )" )
            else
            end
            if ePeeking == true then 
                client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+animState_y ), 208, 160, 210, 255, fontstyle, 0, "STATE : ( USAGE : S1 )" )
            else
            end
        end
        -- end of mix text


        -- displays the dt indicators
        if mid_text == 1 and show_be == 1 then
            client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+dtState_y), dt_r, dt_g, dt_b, dtalpha, fontstyle, 0, dtmsg )
        else
        end

        if mid_text == 1 and ui.get( ref_osaa_hkey ) and show_be == 1 then
            client_draw_text( c, center_x+0, center_y+(ui.get( visuals.indicatorypos_slider )+hsState_y ), 124, 195, 13, 255, fontstyle, 0, "ON-SHOT" )
        else
        end
        if ui.get( ref_freestanding_key ) then fstand = 1 else fstand = 0 end

        if mid_text == 1 and fstand == 1 and show_be == 1 then
            client_draw_text( c, center_x+0, center_y+( ui.get( visuals.indicatorypos_slider )+freestandState_y ), 97, 223, 255, 255, fontstyle, 0, "FREESTANDING" )
        else
        end
        -- end

        -- setup arrow indicator
        arrowleft = "<"
        arrowright = ">"
        arrowdown = "v"
        darrowleft = "<"
        darrowright = ">"
        dplacementx = 69
        dplacementxtwo = 70
        dplacementy = 1
        dplacementytwo = 0
        darrowsize = "cb+"
        -- setup end
    end
end

function handle_main_anti_aim( )
        local scrsize_x, scrsize_y = client_screensize( )
        local center_x, center_y = scrsize_x/2, scrsize_y/2
        local scrleft_x, scrleft_y = (( scrsize_x-scrsize_x ) +1 ), (( scrsize_y-scrsize_y ) +1 )

        if ui.get( aa.edge_yaw_checkbox ) and not can_enemy_hit_head( enemyclosesttocrosshair ) and not in_air() and not ui.get( ref_fakeduck ) and ePeeking == false then
            ui_set( ref_edge_yaw, true )
        else
            ui_set( ref_edge_yaw, false )
        end

        if ui.get( aa.jitter_checkbox ) and ui.get( aa.enable_checkbox ) == true then
            local inverter_enemy        = { }
            local old_inverter_enemy    = { }
            for i = 1 , 66 do
                inverter_enemy[i]       = 1
                old_inverter_enemy[i]   = 1
            end

            local current_inverter      = 1
            local current_old_inverter  = 1
            local closest_fov           = 100000
            local needed_player         = -1
            local player_list           = entity.get_players( true )
            local x,y,z                 = client.eye_position( )
            local eye_pos               = Vector3( x, y, z )
            x,y,z                       = client.camera_angles( )
            local cam_angles            = Vector3( x, y, z )
            local is_local_alive        = entity.is_alive( entity.get_local_player( ) )

            for i = 1 , #player_list do
                player                  = player_list[ i ]
                if not entity.is_dormant( player ) and entity.is_alive( player ) then
                    if is_enemy_peeking( player ) or is_local_peeking_enemy( player ) then
                        last_time_peeked        = globals.curtime( )
                        local enemy_head_pos    = Vector3( entity.hitbox_position( player, 0 ) )
                        local current_fov       = get_FOV( cam_angles,eye_pos, enemy_head_pos )
                        --client.log(current_fov)
                        if current_fov < closest_fov then
                            closest_fov         = current_fov
                            needed_player       = player
                        end
                    end
                end
            end

            if best_player ~= nil and entity.is_alive( best_player ) and entity.is_enemy( best_player ) and not entity.is_dormant( best_player ) then
                needed_player   = best_player
            else
                best_player     = nil
            end
            
            if needed_player ~= -1 and is_local_alive then
                current_inverter        = inverter_enemy[ needed_player ]
                current_old_inverter    = old_inverter_enemy[ needed_player ]
                --change_aa(needed_player)
                local color_left = data.side == 2
                local color_right = not color_left
                if not entity.is_dormant( player ) and entity.is_alive( player ) and ePeeking == false then
                    if ui.get( aa.jitter_checkbox) and ( ( is_enemy_peeking( player ) or is_local_peeking_enemy( player ) ) ) == true and is_in_range == true and not in_air( ) then
                        if color_right then
                            if crooked_arrows == 1 then
                            client_draw_text( c, center_x+50, center_y-3, dr, dg, db, da, "c+", 0, arrowright )
                            client_draw_text( c, center_x-50, center_y-3, 255, 255, 255, 255, "c+", 0, arrowleft )
                            else
                            end
                            right_static( )    
                        else
                            if crooked_arrows == 1 then
                            client_draw_text( c, center_x-50, center_y-3, dr, dg, db, da, "c+", 0, arrowleft )
                            client_draw_text( c, center_x+50, center_y-3, 255, 255, 255, 255, "c+", 0, arrowright )
                            else
                            end
                            left_static( )
                        end
                    else
                        if ui.get( aa.enable_checkbox ) and is_in_range == true and ePeeking == false and not in_air( ) then
                            if color_right then
                                if crooked_arrows == 1 then
                                client_draw_text( c, center_x+63, center_y-3, dr, dg, db, da, "c+", 0, arrowright )
                                client_draw_text( c, center_x+50, center_y-3, dr, dg, db, da, "c+", 0, arrowright )
                                client_draw_text( c, center_x-50, center_y-3, 255, 255, 255, 255, "c+", 0, arrowleft )
                                else
                                end
                                right_static_alternative( )
                            else
                                if crooked_arrows == 1 then
                                client_draw_text( c, center_x-63, center_y-3, dr, dg, db, da, "c+", 0, arrowleft )
                                client_draw_text( c, center_x-50, center_y-3, dr, dg, db, da, "c+", 0, arrowleft )
                                client_draw_text( c, center_x+50, center_y-3, 255, 255, 255, 255, "c+", 0, arrowright )
                                else
                                end
                                left_static_alternative( )
                            end
                        elseif ePeeking == false and not in_air( ) then
                            back_jitter( )
                        end
                    end
                end
            else
                if ePeeking == false and not in_air( ) then
                    static_freestanding( )
                end
            end
        end
end

local function draw_container(x, y, w, h, header, a)
    local c = {10, 60, 40, 40, 40, 60, 20}

    for i = 0,6,1 do
        renderer.rectangle(x+i, y+i, w-(i*2), h-(i*2), c[i+1], c[i+1], c[i+1], a)
    end

    if header then
        local x_inner, y_inner = x+7, y+7
        local w_inner = w-14

        renderer.gradient(x_inner, y_inner, math.floor(w_inner/2), 1, m_r, m_g, m_b, a, mt_r, mt_g, mt_b, a, true)
        renderer.gradient(x_inner+math.floor(w_inner/2), y_inner, math.ceil(w_inner/2), 1, mt_r, mt_g, mt_b, a, m_r, m_g, m_b, a, true)

        local a_lower = a*0.2
        renderer.gradient(x_inner, y_inner+1, math_floor(w_inner/2), 1, 59, 175, 222, a_lower, 202, 70, 205, a_lower, true)
        renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
    end
end

-- this is the paint function
local on_paint = function( )
    if ui.get( aa.configure_combobox ) == "Anti-aim" then
        menu_callback( true, true )
    end
    bind_system:update( )

    -- this is for low delta changing
    if ui.get( aa.enable_checkbox ) and ui.get( aa.jitter_checkbox ) and allow_reset_hit == true then
        on_hit_low_delta( )
    end
    -- end of low delta change
    handle_dt_indicator( )
    handle_indicator_positions( )
    handle_colours_and_alpha( )
    handle_multi_selects( )
    handle_main_indicators( )
    handle_main_anti_aim( )
end

local on_player_hurt = function( e )
    -- checks if the invert_desync_checkbox is on and if it doesnt then it returns
    if not ui.get( aa.jitter_checkbox ) then
        return
    end
    -- checks who is shooting at us and if we get hit or not
    local me = entity.get_local_player( )
    local userid, attacker = client.userid_to_entindex( e.userid ), client.userid_to_entindex( e.attacker )

    -- check if we're the one who got hurt and not the one who hurt us
    if me == userid and me ~= attacker then
        -- if so, set the last side to '0' so the anti-aim updates
        data.last_side = 0
        -- update our smart mode info
        data.last_hit = globals.curtime( )
        data.hit_side = data.side
    end

    local hitgroups = { "generic body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "unsure", "gear" }
    local attN = entity.get_player_name(client.userid_to_entindex( e.attacker ) )
    if client.userid_to_entindex( e.userid ) == entity.get_local_player( ) then
        local attN = entity.get_player_name(client.userid_to_entindex( e.attacker ) )
        if entity.get_player_name( client.userid_to_entindex( e.attacker ) ) == "unknown" then attN = "world" end
        if hitgroups[e.hitgroup + 1] == "HEAD" then
            webhook_two( "User: " .. nickname .. " was " .. "hit in " .. ( hitgroups[e.hitgroup + 1] or '?' ) .. " for " .. e.dmg_health .. " ( anti-bruteforce: " .. ANTIBF_INFO .. "[" .. INVERTS_INFO .. "]" .. " │ anti-aim_state: " .. AASTATE_INFO .. " │ is shooting: " .. SHOOTING_INFO .. ")")
        end
    end
end

-- callback variable
local callback = client.set_event_callback or client.unset_event_callback
-- register / unregister our callbacks
client.set_event_callback( "setup_command", on_setup_command )
client.set_event_callback( "run_command", on_run_command )
client.set_event_callback( "paint", on_paint )
client.set_event_callback( "player_hurt", on_player_hurt )
client.set_event_callback( "bullet_impact", on_bullet_impact )

-- Execute this whenever the script is first enabled

local handle_aa_visibility = function( )
    local enabled = ui.get( aa.enable_checkbox )

    -- Update the anti-aim elements visibility
  --  ui.set_visible( aa.increase_speed, ui.get( aa.configure_combobox ) == "Ragebot" and enabled )
   -- ui.set_visible( aa.dt_accuracy, ui.get( aa.configure_combobox ) == "Ragebot" and enabled )
    ui.set_visible( aa.ideal_peek, ui.get( aa.configure_combobox ) == "Ragebot" and enabled )

    ui.set_visible( aa.freestand_mode_combobox, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.jitter_checkbox, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.manualaa_checkbox, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.manual_right_hotkey, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.manual_back_hotkey, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.manual_left_hotkey, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.legit_aa_on_e, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.legit_aa_hotkey, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.legmovement_checkbox, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.lowdelta_slow_walk_checkbox, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.in_air_checkbox, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )
    ui.set_visible( aa.edge_yaw_checkbox, ui.get( aa.configure_combobox ) == "Anti-aim" and enabled )

    ui.set_visible( aa.manual_state, false )

    local valid_cfg = ui.get(  aa.configure_combobox ) == "Config" and enabled
    ui.set_visible( set_cfg, valid_cfg )
    ui.set_visible( reset_cfg, valid_cfg )
end

local handle_visuals_visibility = function( )
    local enabled = ui.get( aa.enable_checkbox ) and ui.get( aa.configure_combobox ) == "Indicators"

    ui.set_visible( visuals.configure_vis_combobox, enabled )

    local valid_indicator_cfg = ui.get( visuals.configure_vis_combobox ) == "Text & Indicators" and enabled
    ui.set_visible( visuals.arrow_label, valid_indicator_cfg )
    ui.set_visible( visuals.arrow_colourpicker, valid_indicator_cfg )

    ui.set_visible( visuals.banepa_label, valid_indicator_cfg )
    ui.set_visible( visuals.banepa_colourpicker, valid_indicator_cfg )

    ui.set_visible( visuals.fontstyle_combobox, valid_indicator_cfg )
    ui.set_visible( visuals.centered_text, valid_indicator_cfg )

    ui.set_visible( visuals.indicators_multiselect, valid_indicator_cfg )
    ui.set_visible( visuals.textindicators_multiselect, valid_indicator_cfg )
    ui.set_visible( visuals.indicatorypos_slider, valid_indicator_cfg )
end

client.set_event_callback( "paint", handle_aa_visibility )
client.set_event_callback( "paint", handle_visuals_visibility )

ui.set_callback( aa.freestand_mode_combobox, function( self )
    -- Set the last side to '0' so the anti-aim updates
    data.last_side = 0
end)