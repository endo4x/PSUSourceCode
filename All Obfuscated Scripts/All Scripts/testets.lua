--[[
	id: tggZrp52zgMmLit-FN9GD
	name: testets
	description: dddd
	time1: 2021-04-29 08:50:22.471537+00
	time2: 2021-04-29 08:50:22.471537+00
	uploader: g6KJoLQmPLzjEwJWd17PcfGlu5zxMP3uvs44iwLL
	uploadersession: QP-dqqWdvlE-QpAPBGFBAP-jjX9ZyH
	flag: f
--]]

client_latency, client_log, client_draw_rectangle, client_draw_circle_outline, client_userid_to_entindex, client_draw_indicator, client_draw_gradient, client_set_event_callback, client_screen_size, client_eye_position = client.latency, client.log, client.draw_rectangle, client.draw_circle_outline, client.userid_to_entindex, client.draw_indicator, client.draw_gradient, client.set_event_callback, client.screen_size, client.eye_position
client_draw_circle, client_color_log, client_delay_call, client_draw_text, client_visible, client_exec, client_trace_line, client_set_cvar = client.draw_circle, client.color_log, client.delay_call, client.draw_text, client.visible, client.exec, client.trace_line, client.set_cvar
client_world_to_screen, client_draw_hitboxes, client_get_cvar, client_draw_line, client_camera_angles, client_draw_debug_text, client_random_int, client_random_float = client.world_to_screen, client.draw_hitboxes, client.get_cvar, client.draw_line, client.camera_angles, client.draw_debug_text, client.random_int, client.random_float
entity_get_local_player, entity_is_enemy, entity_hitbox_position, entity_get_player_name, entity_get_steam64, entity_get_bounding_box, entity_get_all, entity_set_prop = entity.get_local_player, entity.is_enemy, entity.hitbox_position, entity.get_player_name, entity.get_steam64, entity.get_bounding_box, entity.get_all, entity.set_prop
entity_is_alive, entity_get_player_weapon, entity_get_prop, entity_get_players, entity_get_classname = entity.is_alive, entity.get_player_weapon, entity.get_prop, entity.get_players, entity.get_classname
globals_realtime, globals_absoluteframetime, globals_tickcount, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.tickcount, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_is_menu_open, ui_new_color_picker, ui_set_callback, ui_set, ui_new_checkbox, ui_new_hotkey, ui_new_button, ui_new_multiselect, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.is_menu_open, ui.new_color_picker, ui.set_callback, ui.set, ui.new_checkbox, ui.new_hotkey, ui.new_button, ui.new_multiselect, ui.get
math_ceil, math_tan, math_log10, math_randomseed, math_cos, math_sinh, math_random, math_huge, math_pi, math_max, math_atan2, math_ldexp, math_floor, math_sqrt, math_deg, math_atan, math_fmod = math.ceil, math.tan, math.log10, math.randomseed, math.cos, math.sinh, math.random, math.huge, math.pi, math.max, math.atan2, math.ldexp, math.floor, math.sqrt, math.deg, math.atan, math.fmod
math_acos, math_pow, math_abs, math_min, math_sin, math_frexp, math_log, math_tanh, math_exp, math_modf, math_cosh, math_asin, math_rad = math.acos, math.pow, math.abs, math.min, math.sin, math.frexp, math.log, math.tanh, math.exp, math.modf, math.cosh, math.asin, math.rad
table_maxn, table_foreach, table_sort, table_remove, table_foreachi, table_move, table_getn, table_concat, table_insert = table.maxn, table.foreach, table.sort, table.remove, table.foreachi, table.move, table.getn, table.concat, table.insert
string_find, string_format, string_rep, string_gsub, string_len, string_gmatch, string_dump, string_match, string_reverse, string_byte, string_char, string_upper, string_lower, string_sub = string.find, string.format, string.rep, string.gsub, string.len, string.gmatch, string.dump, string.match, string.reverse, string.byte, string.char, string.upper, string.lower, string.sub
eventcb, ui_set, ui_ref = client.set_event_callback, ui.set, ui.reference

type         = type;
setmetatable = setmetatable;
tostring     = tostring;

math_pi   = math.pi;
math_min  = math.min;
math_max  = math.max;
math_deg  = math.deg;
math_rad  = math.rad;
math_sqrt = math.sqrt;
math_sin  = math.sin;
math_cos  = math.cos;
math_atan = math.atan;
math_acos = math.acos;
math_fmod = math.fmod;

-- set up vector3 metatable
local _V3_MT   = {};
_V3_MT.__index = _V3_MT;

--
-- create Vector3 object
--
function Vector3( x, y, z )
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

--
-- metatable operators
--
function _V3_MT.__eq( a, b ) -- equal to another vector
    return a.x == b.x and a.y == b.y and a.z == b.z;
end

function _V3_MT.__unm( a ) -- unary minus
    return Vector3(
        -a.x,
        -a.y,
        -a.z
    );
end

function _V3_MT.__add( a, b ) -- add another vector or number
    local a_type = type( a );
    local b_type = type( b );

    if( a_type == "table" and b_type == "table" ) then
        return Vector3(
            a.x + b.x,
            a.y + b.y,
            a.z + b.z
        );
    elseif( a_type == "table" and b_type == "number" ) then
        return Vector3(
            a.x + b,
            a.y + b,
            a.z + b
        );
    elseif( a_type == "number" and b_type == "table" ) then
        return Vector3(
            a + b.x,
            a + b.y,
            a + b.z
        );
    end
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

function _V3_MT.__mul( a, b ) -- multiply by another vector or number
    local a_type = type( a );
    local b_type = type( b );

    if( a_type == "table" and b_type == "table" ) then
        return Vector3(
            a.x * b.x,
            a.y * b.y,
            a.z * b.z
        );
    elseif( a_type == "table" and b_type == "number" ) then
        return Vector3(
            a.x * b,
            a.y * b,
            a.z * b
        );
    elseif( a_type == "number" and b_type == "table" ) then
        return Vector3(
            a * b.x,
            a * b.y,
            a * b.z
        );
    end
end

function _V3_MT.__div( a, b ) -- divide by another vector or number
    local a_type = type( a );
    local b_type = type( b );

    if( a_type == "table" and b_type == "table" ) then
        return Vector3(
            a.x / b.x,
            a.y / b.y,
            a.z / b.z
        );
    elseif( a_type == "table" and b_type == "number" ) then
        return Vector3(
            a.x / b,
            a.y / b,
            a.z / b
        );
    elseif( a_type == "number" and b_type == "table" ) then
        return Vector3(
            a / b.x,
            a / b.y,
            a / b.z
        );
    end
end

function _V3_MT.__tostring( a ) -- used for 'tostring( vector3_object )'
    return "( " .. a.x .. ", " .. a.y .. ", " .. a.z .. " )";
end

--
-- metatable misc funcs
--
function _V3_MT:clear() -- zero all vector vars
    self.x = 0.0;
    self.y = 0.0;
    self.z = 0.0;
end

function _V3_MT:unpack() -- returns axes as 3 seperate arguments
    return self.x, self.y, self.z;
end

function _V3_MT:length_2d_sqr() -- squared 2D length
    return ( self.x * self.x ) + ( self.y * self.y );
end

function _V3_MT:length_sqr() -- squared 3D length
    return ( self.x * self.x ) + ( self.y * self.y ) + ( self.z * self.z );
end

function _V3_MT:length_2d() -- 2D length
    return math_sqrt( self:length_2d_sqr() );
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

function _V3_MT:is_zero( tolerance ) -- is the vector zero (within tolerance value, can pass no arg if desired)?
    tolerance = tolerance or 0.001;

    if( self.x < tolerance and self.x > -tolerance and
        self.y < tolerance and self.y > -tolerance and
        self.z < tolerance and self.z > -tolerance ) then
        return true;
    end

    return false;
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

function _V3_MT:normalize_no_len() -- normalizes this vector (no length returned)
    local l = self:length();
    if( l <= 0.0 ) then
        return;
    end

    self.x = self.x / l;
    self.y = self.y / l;
    self.z = self.z / l;
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

--
-- other math funcs
--
function clamp( cur_val, min_val, max_val ) -- clamp number within 'min_val' and 'max_val'
    if( cur_val < min_val ) then
        return min_val;

    elseif( cur_val > max_val ) then
        return max_val;
    end

    return cur_val;
end

function normalize_angle( angle ) -- ensures angle axis is within [-180, 180]
    local out;
    local str;

    -- bad number
    str = tostring( angle );
    if( str == "nan" or str == "inf" ) then
        return 0.0;
    end

    -- nothing to do, angle is in bounds
    if( angle >= -180.0 and angle <= 180.0 ) then
        return angle;
    end

    -- bring into range
    out = math_fmod( math_fmod( angle + 360.0, 360.0 ), 360.0 );
    if( out > 180.0 ) then
        out = out - 360.0;
    end

    return out;
end

function vector_to_angle( forward ) -- vector -> euler angle
    local l;
    local pitch;
    local yaw;

    l = forward:length();
    if( l > 0.0 ) then
        pitch = math_deg( math_atan( -forward.z, l ) );
        yaw   = math_deg( math_atan( forward.y, forward.x ) );
    else
        if( forward.x > 0.0 ) then
            pitch = 270.0;
        else
            pitch = 90.0;
        end

        yaw = 0.0;
    end

    return Vector3( pitch, yaw, 0.0 );
end

function angle_forward( angle ) -- angle -> direction vector (forward)
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

function angle_right( angle ) -- angle -> direction vector (right)
    local sin_pitch = math_sin( math_rad( angle.x ) );
    local cos_pitch = math_cos( math_rad( angle.x ) );
    local sin_yaw   = math_sin( math_rad( angle.y ) );
    local cos_yaw   = math_cos( math_rad( angle.y ) );
    local sin_roll  = math_sin( math_rad( angle.z ) );
    local cos_roll  = math_cos( math_rad( angle.z ) );

    return Vector3(
        -1.0 * sin_roll * sin_pitch * cos_yaw + -1.0 * cos_roll * -sin_yaw,
        -1.0 * sin_roll * sin_pitch * sin_yaw + -1.0 * cos_roll * cos_yaw,
        -1.0 * sin_roll * cos_pitch
    );
end

function angle_up( angle ) -- angle -> direction vector (up)
    local sin_pitch = math_sin( math_rad( angle.x ) );
    local cos_pitch = math_cos( math_rad( angle.x ) );
    local sin_yaw   = math_sin( math_rad( angle.y ) );
    local cos_yaw   = math_cos( math_rad( angle.y ) );
    local sin_roll  = math_sin( math_rad( angle.z ) );
    local cos_roll  = math_cos( math_rad( angle.z ) );

    return Vector3(
        cos_roll * sin_pitch * cos_yaw + -sin_roll * -sin_yaw,
        cos_roll * sin_pitch * sin_yaw + -sin_roll * cos_yaw,
        cos_roll * cos_pitch
    );
end

function get_FOV( view_angles, start_pos, end_pos ) -- get fov to a vector (needs client view angles, start position (or client eye position for example) and the end position)
    local type_str;
    local fwd;
    local delta;
    local fov;

    fwd   = angle_forward( view_angles );
    delta = ( end_pos - start_pos ):normalized();
    fov   = math_acos( fwd:dot( delta ) / delta:length() );

    return math_max( 0.0, math_deg( fov ) );
end

--local variables for API functions. Generated using https://github.com/sapphyrus/gamesense-lua/blob/master/generate_api.lua
client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_reload_active_scripts, client_scale_damage, client_get_cvar, client_camera_position, client_create_interface, client_random_int, client_latency, client_set_clan_tag, client_find_signature, client_log, client_timestamp, client_delay_call, client_trace_line, client_register_esp_flag, client_get_model_name, client_system_time, client_visible, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float = client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.reload_active_scripts, client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int, client.latency, client.set_clan_tag, client.find_signature, client.log, client.timestamp, client.delay_call, client.trace_line, client.register_esp_flag, client.get_model_name, client.system_time, client.visible, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float
entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
globals_realtime, globals_absoluteframetime, globals_chokedcommands, globals_oldcommandack, globals_tickcount, globals_commandack, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.chokedcommands, globals.oldcommandack, globals.tickcount, globals.commandack, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect, ui_is_menu_open, ui_new_hotkey, ui_set, ui_update, ui_menu_size, ui_name, ui_menu_position, ui_set_callback, ui_new_button, ui_new_label, ui_new_string, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect, ui.is_menu_open, ui.new_hotkey, ui.set, ui.update, ui.menu_size, ui.name, ui.menu_position, ui.set_callback, ui.new_button, ui.new_label, ui.new_string, ui.get
-- local variables for API functions. any changes to the line below will be lost on re-generation
bit_band, client_camera_angles, client_color_log, client_create_interface, client_delay_call, client_exec, client_eye_position, client_key_state, client_log, client_random_int, client_scale_damage, client_screen_size, client_set_event_callback, client_trace_bullet, client_userid_to_entindex, database_read, database_write, entity_get_local_player, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, entity_is_enemy, math_abs, math_atan2, require, error, globals_absoluteframetime, globals_curtime, globals_realtime, math_atan, math_cos, math_deg, math_floor, math_max, math_min, math_rad, math_sin, math_sqrt, print, renderer_circle_outline, renderer_gradient, renderer_measure_text, renderer_rectangle, renderer_text, renderer_triangle, string_find, string_gmatch, string_gsub, string_lower, table_insert, table_remove, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_hotkey, ui_new_multiselect, ui_reference, tostring, ui_is_menu_open, ui_mouse_position, ui_new_combobox, ui_new_slider, ui_set, ui_set_callback, ui_set_visible, tonumber, pcall = bit.band, client.camera_angles, client.color_log, client.create_interface, client.delay_call, client.exec, client.eye_position, client.key_state, client.log, client.random_int, client.scale_damage, client.screen_size, client.set_event_callback, client.trace_bullet, client.userid_to_entindex, database.read, database.write, entity.get_local_player, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, entity.is_enemy, math.abs, math.atan2, require, error, globals.absoluteframetime, globals.curtime, globals.realtime, math.atan, math.cos, math.deg, math.floor, math.max, math.min, math.rad, math.sin, math.sqrt, print, renderer.circle_outline, renderer.gradient, renderer.measure_text, renderer.rectangle, renderer.text, renderer.triangle, string.find, string.gmatch, string.gsub, string.lower, table.insert, table.remove, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_hotkey, ui.new_multiselect, ui.reference, tostring, ui.is_menu_open, ui.mouse_position, ui.new_combobox, ui.new_slider, ui.set, ui.set_callback, ui.set_visible, tonumber, pcall
ui_menu_position, ui_menu_size, math_pi, renderer_indicator, entity_is_dormant, client_set_clan_tag, client_trace_line, entity_get_all, entity_get_classname = ui.menu_position, ui.menu_size, math.pi, renderer.indicator, entity.is_dormant, client.set_clan_tag, client.trace_line, entity.get_all, entity.get_classname
plist_set = plist.get
--end of local variables

-- LUA library requirements
local http = require "gamesense/http"
--[[
    Menu items
]]
ui_new_label("AA", "Anti-aimbot angles", "-----------[ephemeral]-----------")
local master_switch = ui_new_checkbox("AA", "Anti-aimbot angles", "Enable")
local master_box = ui_new_combobox("AA", "Anti-aimbot angles", "config", "Anti-aim", "Double tap improments", "Visuals")
local override_antiaim = ui_new_checkbox("AA", "Anti-aimbot angles", "override anti-aim")
--local reset_stages = ui_new_hotkey("AA", "Anti-aimbot angles", "Reset bruteforce stages")
local adaptive_fs = ui_new_checkbox("AA", "Anti-aimbot angles", "dynamic freestanding")
local manual_aa = ui_new_checkbox("AA", "Anti-aimbot angles", "manual anti-aim")
local manual_aa_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Manual anti-aim", 255, 255, 255, 255)
local manual_left = ui_new_hotkey("AA", "Anti-aimbot angles", "Left")
local manual_right = ui_new_hotkey("AA", "Anti-aimbot angles", "Right")
local manual_state = ui_new_slider("AA", "Anti-aimbot angles", "Manual direction", 0, 2, 0)
local faster_dt = ui_new_checkbox("AA", "Anti-aimbot angles", "faster doubletap")
local adaptive_dt = ui_new_checkbox("AA", "Anti-aimbot angles", "Ping based tick shift")
local legit_aa_use = ui_new_checkbox("AA", "Anti-aimbot angles", "legit aa on e")
local low_deltakey = ui_new_hotkey("AA", "Anti-aimbot angles", "Low delta key")
local first_gradient = ui_new_label("AA", "Anti-aimbot angles", "first gradient")
local primary_gradient = ui_new_color_picker("AA", "Anti-aimbot angles", "primary gradient", 255, 255, 255, 255)
local sec_gradient = ui_new_label("AA", "Anti-aimbot angles", "second gradient")
local secondary_gradient = ui_new_color_picker("AA", "Anti-aimbot angles", "secondary gradient", 0, 0, 0, 0)
local side_arrows = ui_new_checkbox("AA", "Anti-aimbot angles", "side arrows")
local side_arrows_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Side arrows color", 255, 255, 255, 255)
local ephemeral_clr = ui_new_label("AA", "Anti-aimbot angles", "ephemeral color")
local shandy_yaw_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "ephemeral color", 255, 255, 255, 255)
ui_new_label("AA", "Anti-aimbot angles", "-----------[ephemeral]-----------")


--[[
    Menu references
]]
local ref_md = ui_reference("RAGE", "Aimbot", "Minimum damage")
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
local ref_lby_target = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local ref_fakelimit = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local ref_hs, ref_hs_key = ui_reference("AA", "Other", "On shot anti-aim")

local ref_fl = ui_reference("AA", "Fake lag", "Enabled")
local ref_fl_amt = ui_reference("AA", "Fake lag", "Amount")
local ref_fl_var = ui_reference("AA", "Fake lag", "Variance")
local ref_fl_limit = ui_reference("AA", "Fake lag", "Limit")
local ref_maxprocessticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

-- menu
local function paint_ui()

    if ui.get(master_box) == "Anti-aim" and ui.get(master_switch) then
        ui_set_visible(override_antiaim, true)
        ui_set_visible(adaptive_fs, true)
        ui_set_visible(manual_aa, true)
        ui_set_visible(manual_aa_clr, true)
        ui_set_visible(manual_left, true)
        ui_set_visible(manual_right, true)
        ui_set_visible(low_deltakey, true)
        ui_set_visible(legit_aa_use, true)
    else 
        ui_set_visible(override_antiaim, false)
        ui_set_visible(adaptive_fs, false)
        ui_set_visible(manual_aa, false)
        ui_set_visible(manual_aa_clr, false)
        ui_set_visible(manual_left, false)
        ui_set_visible(manual_right, false)
        ui_set_visible(low_deltakey, false)
        ui_set_visible(legit_aa_use, false)
    end

    if ui.get(master_box) == "Double tap improments" and ui.get(master_switch) then
        ui_set_visible(faster_dt, true)
        ui_set_visible(adaptive_dt, true)
    else 
        ui_set_visible(faster_dt, false)
        ui_set_visible(adaptive_dt, false)
    end

    if ui.get(master_box) == "Visuals" and ui.get(master_switch) then
        ui_set_visible(primary_gradient, true)
        ui_set_visible(first_gradient, true)
        ui_set_visible(sec_gradient, true)
        ui_set_visible(secondary_gradient, true)
        ui_set_visible(ephemeral_clr, true)
        ui_set_visible(shandy_yaw_clr, true)
        ui_set_visible(side_arrows, true)
        ui_set_visible(side_arrows_clr, true)
    else 
        ui_set_visible(primary_gradient, false)
        ui_set_visible(first_gradient, false)
        ui_set_visible(sec_gradient, false)
        ui_set_visible(secondary_gradient, false)
        ui_set_visible(ephemeral_clr, false)
        ui_set_visible(shandy_yaw_clr, false)
        ui_set_visible(side_arrows, false)
        ui_set_visible(side_arrows_clr, false)
    end
    ui_set_visible(ref_pitch, false)
    ui_set_visible(ref_yaw, false)
    ui_set_visible(ref_yawadd, false)
    ui_set_visible(ref_yaw_base, false)
    ui_set_visible(ref_yawj, false)
    ui_set_visible(ref_yawjadd, false)
    ui_set_visible(ref_bodyyaw, false)
    ui_set_visible(ref_bodyyawadd, false)
    ui_set_visible(ref_fs_bodyyaw, false)
    ui_set_visible(ref_lby_target, false)
    ui_set_visible(ref_fakelimit, false)
    ui.set_visible(manual_state, false)

end
client_set_event_callback("paint_ui", paint_ui)

local best_enemy = nil

local brute = {
    yaw_status = "default",
    indexed_angle = 0,
    last_miss = 0,
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

ui_set_callback(manual_aa, on_manual_enabled)

local function manual_aa_sc()
    if not ui_get(manual_aa) then
        return
    end

    local direction = ui_get(manual_state)

    local manual_yaw = {
        [0] = 0,
        [1] = -100, [2] = 100
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

    local x, y = client_screen_size()
    local r, g, b, a = ui_get(manual_aa_clr)
    local m_state = ui_get(manual_state)
    
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a

    local desync_strength = math.floor(math.min(58, math.abs(entity_get_prop(entity_get_local_player(), "m_flPoseParameter", 11)*120-60)))

    renderer.text(x/2 - 45, y / 2 - 1, 255, 255, 255, 255, "+c", 0, "<")
    renderer.text(x/2 + 45, y / 2 - 1, 255, 255, 255, 255, "+c", 0, ">")
    renderer.text(x/2, y / 2 + 30, r, g, b, 255, "+c", 0, "v")

    if m_state == 1 then renderer.text(x/2 - 45, y / 2 - 1, r, g, b, 255, "+c", 0, "<") end
    if m_state == 1 then renderer.text(x/2 + 45, y / 2 - 1, 255, 255, 255, 255, "+c", 0, ">") end
    if m_state == 2 then renderer.text(x/2 + 45, y / 2 - 1, r, g, b, 255, "+c", 0, ">") end
    if m_state == 2 then renderer.text(x/2 - 45, y / 2 - 1, 255, 255, 255, 255, "+c", 0, "<") end

end

local function set_anti_aim(type)
    if type == "jitter" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 1)
        ui_set(ref_yawj, "Random")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Jitter")
        ui_set(ref_bodyyawadd, 1)
        ui_set(ref_fs_bodyyaw, true)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 59)
    elseif type == "left" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 10)
        ui_set(ref_yawj, "Offset")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 170)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 59)
    elseif type == "right" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, -15)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, -170)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 40)
    elseif type == "safe" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 17)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 180)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 23)
    elseif type == "jittervisR" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 10)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, -170)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
		ui_set(ref_fakelimit, math.random(25, 40))
    elseif type == "jittervisL" then
        ui_set(ref_yawadd, -15)
        ui_set(ref_yaw, "180")
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 170)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
		ui_set(ref_fakelimit, math.random(25, 40))
    elseif type == "lowdelta" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 17)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 180)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 27)
    end
end

local function anti_aim()

    if ui.get(low_deltakey) then
        brute.yaw_status = "lowdelta"
        set_anti_aim("lowdelta")
        return
    end

    brute.yaw_status = "default"

    if not ui_get(override_antiaim) then return end

    --if ui_get(reset_stages) then
        --brute.misses = { }
        --brute.hit_reverse = { }
    --end

    if ui_get(manual_aa) and ui_get(manual_state) ~= 0 then
        brute.yaw_status = "safe"
        set_anti_aim("safe")
        return
    end
    
    if brute.best_angle == 0 then
        if best_enemy == nil then
            brute.yaw_status = "jitter"
            brute.indexed_angle = 0
            set_anti_aim("jitter")
        elseif brute.indexed_angle ~= 0 then
            if brute.indexed_angle == 1 then
                if brute.misses[best_enemy] == nil then
                    brute.yaw_status = "jitter"
                    set_anti_aim("jitter")
                elseif brute.misses[best_enemy] == 1 then
                    brute.yaw_status = "jitter"
                    set_anti_aim("jitter")
                else
                    brute.yaw_status = "jitter"
                    set_anti_aim("jitter")
                end
            else
                if brute.misses[best_enemy] == nil then
                    brute.yaw_status = "jitter"
                    set_anti_aim("jitter")
                else
                    brute.yaw_status = "jitter"
                    set_anti_aim("jitter")
                end
            end
        end
    elseif brute.best_angle == 1 then
        brute.indexed_angle = 1
        if brute.misses[best_enemy] == nil then
            brute.yaw_status = "left"
            set_anti_aim("left")
        elseif brute.misses[best_enemy] == 1 then
            brute.yaw_status = "right : S"
            set_anti_aim("jittervisR")
        else
            brute.yaw_status = "left : S"
            set_anti_aim("jittervisL")
        end
    else
        brute.indexed_angle = 2
        if brute.misses[best_enemy] == nil then
            brute.yaw_status = "right"
            set_anti_aim("right")
        else
            brute.yaw_status = "left : S"
            set_anti_aim("jittervisL")
        end
    end
end

local function renderer_arrow(x, y, r, g, b, a, rotation, size)
	local x0, y0 = rotate_point(x, y, rotation, 45)
	local x1, y1 = rotate_point(x, y, rotation + (size / 3.5), 45 - (size / 4))
	local x2, y2 = rotate_point(x, y, rotation - (size / 3.5), 45 - (size / 4))
	renderer_triangle(x0, y0, x1, y1, x2, y2, r, g, b, a)
end

local normalize_yaw = function(angle)
    angle = (angle % 360 + 360) % 360
    return angle > 180 and angle - 360 or angle
end

vector = require "vector"

local w, h = client.screen_size()
-- >> callbacks
local function on_paint()
    if not ui.get(master_switch) then return end
    local me = entity.get_local_player()

    -- If our local player is invalid or if we're dead, return
    if not me or entity.get_prop(me, "m_lifeState") ~= 0 then
        return
    end
    if entity.get_local_player() == nil or entity.is_alive(entity.get_local_player()) == false then return end
    local lp_pos = vector(entity.get_origin(entity.get_local_player()))
    local _, head_rot = entity.get_prop(entity.get_local_player(), "m_angAbsRotation");local _, fake_rot = entity.get_prop(entity.get_local_player(), "m_angEyeAngles");local lby_rot = entity.get_prop(entity.get_local_player(), "m_flLowerBodyYawTarget");local _, cam_rot = client.camera_angles()
    local c3d = { degrees=60, start_at=head_rot, start_at2=fake_rot, start_at3=lby_rot }
    local body_pos = entity_get_prop(me, "m_flPoseParameter", 11) or 0
    local _, camera_yaw = client_camera_angles()
    local _, rotation = entity_get_prop(me, 'm_angAbsRotation')
    local body = math.max(-60, math.min(60, body_pos*120 - 60))
    local perc = math.abs(body) / 60
    
    if camera_yaw ~= nil and rotation ~= nil and 60 < math_abs(normalize_yaw(camera_yaw-(rotation+body))) then
        body = -body
    end
    side = body > 0 and -1 or 1

    local r2, g2, b2 = 192 - (perc * 71), 32 + (perc * 146), 28

    -- Lua name (center screen)

end
client.set_event_callback("paint", on_paint)

local function on_paint(c)
    if not ui.get(master_switch) then return end
    local doubletap = { ui.reference("rage", "Other", "Double tap") }
        --start of dt
        local local_player = entity.get_local_player()
        local width, height = client.screen_size()
        local center_x = width/2
        local center_y = height/2

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
    
        nextAttack = nextAttack + 14 * globals.tickinterval()
        nextShot = nextShot + 14 * globals.tickinterval()
        nextShotSecondary = nextShotSecondary + 14 * globals.tickinterval()
        local r, g, b, a = ui_get(shandy_yaw_clr)
        local realtime = globals_realtime() % 3
        local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a

        if ui.get(doubletap[1]) then
            if not ui.get(doubletap[2]) then
                renderer.text(center_x, center_y+40, 255, 255, 255, alpha, "c", 0, " ")
            end
        end

        if ui.get(doubletap[2]) then
            had_dt = true
            if math.max(nextShot,nextShotSecondary) < nextAttack then -- swapping
                if nextAttack - globals.curtime() > 0.00 then
                    renderer.text(center_x, center_y+40, 255, 0, 0, 255, "c", 0, " ")
                else
                    renderer.text(center_x, center_y+40, 255, 255, 255, 255, "c", 0, " ")
    
                end
            else -- shooting or just shot
                if math.max(nextShot,nextShotSecondary) - globals.curtime() > 0.00  then
                    renderer.text(center_x, center_y+40, 255,255,47, 255, "c", 0, " ")
                    renderer.text(center_x, center_y+40, 255, 0, 0, alpha, "c", 0, " ")
                    --renderer.circle_outline(center_x+17, center_y+41, 150, 200, 60, 255, 4, 270, 1.0 - (3 * math.abs(math.max(nextShot,nextShotSecondary) - globals.curtime())), 2)
                    recharging = true
                else
                    recharging = false
                    if math.max(nextShot,nextShotSecondary) - globals.curtime() < 0.00  then
                        renderer.text(center_x, center_y+40, 255, 255, 255, 255, "c", 0, " ")
                    else
                        renderer.text(center_x, center_y+40, 255, 255, 255, 255, "c", 0, " ")
                    end
                end
            end  
        end
end

client.set_event_callback('paint', on_paint)

local active = ui.new_checkbox('AA', 'Anti-aimbot angles', 'Watermark')
local color_picker = ui.new_color_picker('AA', 'Anti-aimbot angles', 'Watermark color picker', 89, 119, 239, 255)

local nickname = 'premium v.2'
local ctag = 'skeet.cc [ephemeral.lua]'

-- Things
local ffi = require 'ffi'
local interface_ptr = ffi.typeof('void***')
local latency_ptr = ffi.typeof('float(__thiscall*)(void*, int)')

local rawivengineclient = client.create_interface('engine.dll', 'VEngineClient014') or error('VEngineClient014 wasnt found', 2)
local ivengineclient = ffi.cast(interface_ptr, rawivengineclient) or error('rawivengineclient is nil', 2)

local get_net_channel_info = ffi.cast('void*(__thiscall*)(void*)', ivengineclient[0][78]) or error('ivengineclient is nil')
local is_in_game = ffi.cast('bool(__thiscall*)(void*)', ivengineclient[0][26]) or error('is_in_game is nil')

local notes = (function(b)local c=function(d,e)local f={}for g in pairs(d)do table.insert(f,g)end;table.sort(f,e)local h=0;local i=function()h=h+1;if f[h]==nil then return nil else return f[h],d[f[h]]end end;return i end;local j={get=function(k)local l,m=0,{}for n,o in c(package.cnotes)do if o==true then l=l+1;m[#m+1]={n,l}end end;for p=1,#m do if m[p][1]==b then return k(m[p][2]-1)end end end,set_state=function(q)package.cnotes[b]=q;table.sort(package.cnotes)end,unset=function()client.unset_event_callback('shutdown',callback)end}client.set_event_callback('shutdown',function()if package.cnotes[b]~=nil then package.cnotes[b]=nil end end)if package.cnotes==nil then package.cnotes={}end;return j end)('a_watermark')

-- Local vars
local ui_get = ui.get
local string_format = string.format
local client_screen_size = client.screen_size
local client_system_time = client.system_time
local globals_tickinterval = globals.tickinterval
local renderer_measure_text = renderer.measure_text
local renderer_rectangle = renderer.rectangle
local renderer_text = renderer.text

local paint_handler = function()
    notes.set_state(ui_get(active))
    notes.get(function(id)
        local sys_time = { client_system_time() }
        local actual_time = string_format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

        local text = string_format('%s | %s | %s', ctag, nickname, actual_time)

        if is_in_game(is_in_game) == true then
            local INetChannelInfo = ffi.cast(interface_ptr, get_net_channel_info(ivengineclient)) or error('netchaninfo is nil')
            local get_avg_latency = ffi.cast(latency_ptr, INetChannelInfo[0][10])
            local latency = get_avg_latency(INetChannelInfo, 0) * 1000
            local tick = 1/globals_tickinterval()

            text = string_format('%s | %s | delay: %dms | %dtick | %s', ctag, nickname, latency, tick, actual_time)
        end

        local r, g, b, a = ui_get(color_picker)
        local h, w = 18, renderer_measure_text(nil, text) + 8
        local x, y = client_screen_size(), 10 + (25*id)

        x = x - w - 10

        renderer_rectangle(x, y, w, 2, r, g, b, 255)
        renderer_rectangle(x, y + 2, w, h, 17, 17, 17, a)
        renderer_text(x+4, y + 4, 255, 255, 255, 255, '', 0, text)
    end)
end

client.set_event_callback('paint_ui', paint_handler)


local function draw()
    if not entity_is_alive(entity_get_local_player()) then return end

    local w, h = client_screen_size()

    local p_r, p_g, p_b, p_a = ui_get(primary_gradient)
    local a_r, a_g, a_b, a_a = ui_get(secondary_gradient)
    local s_r, s_g, s_b, s_a = ui_get(side_arrows_clr)
    local m_r, m_g, m_b, m_a = ui_get(shandy_yaw_clr)
    local sx, sy = client_screen_size()
	local cx, cy = sx / 2, sy / 2 - 2

    math_abs = math.abs
    local body_pos = entity_get_prop(me, "m_flPoseParameter", 11) or 0
    local _, camera_yaw = client_camera_angles()
    local _, rotation = entity_get_prop(me, 'm_angAbsRotation')
    local body = math.max(-60, math.min(60, body_pos*120 - 60))
    local perc = math.abs(body) / 60

    local desync_strength = math.floor(math.min(58, math.abs(entity_get_prop(entity_get_local_player(), "m_flPoseParameter", 11)*120-60)))

    -- Desync bar
    --renderer.gradient(w / 2 - desync_strength, h / 2 + 30, desync_strength, 3, a_r, a_g, a_b, a_a, p_r, p_g, p_b, p_a, true)
    --renderer.gradient(w / 2, h / 2 + 30, desync_strength, 3, p_r, p_g, p_b, p_a, a_r, a_g, a_b, a_a, true)

    -- Desync degrees indicator
    local r, g, b, a = ui_get(shandy_yaw_clr)
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a

    --renderer.text(w / 2, h / 2 + 20, 255, 255, 255, 255, "c", 0, string.format(" %s°", desync_strength))
    --renderer.text(w / 2, h / 2 + 40, m_r, m_g, m_b, alpha, "c", 0, "ephemeral")
    		-- draw gif at top right corner of the menu

    local r, g, b, a = ui_get(manual_aa_clr)

    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a
    
    --local desync_strength = math.floor(math.min(58, math.abs(entity_get_prop(entity_get_local_player(), "m_flPoseParameter", 11)*120-60)))
    -- Side arrows
    if ui_get(side_arrows) then
        if not ui_get(manual_aa) or ui_get(manual_state) == 0 then
                -- Way easier to just do the body yaw check rather than checking indexed angles and stuff.
                if brute.yaw_status == "left" then
                    renderer.text(w / 2 + 35, h / 2, 255, 255, 255, 255, "cb+", 0, ">")
                    renderer.text(w / 2 - 35, h / 2, s_r, s_g, s_b, s_a, "cb+", 0, "<")
                elseif brute.yaw_status == "right" then
                    renderer.text(w / 2 + 35, h / 2, s_r, s_g, s_b, s_a, "cb+", 0, ">")
                    renderer.text(w / 2 - 35, h / 2, 255, 255, 255, 255, "cb+", 0, "<")
                elseif brute.yaw_status == "left : S" then
                    renderer.text(w / 2 + 35, h / 2, 255, 255, 255, 255, "cb+", 0, ">")
                    renderer.text(w / 2 - 35, h / 2, s_r, s_g, s_b, 255, "cb+", 0, "<<")
                elseif brute.yaw_status == "right : S" then
                    renderer.text(w / 2 + 35, h / 2, s_r, s_g, s_b, 255, "cb+", 0, ">>")
                    renderer.text(w / 2 - 35, h / 2, 255, 255, 255, 255, "cb+", 0, "<")
                elseif brute.yaw_status == "lowdelta" then
                    renderer.text(w / 2 + 38, h / 2, 150,165,60, alpha, "cb+", 0, "⯈")
                    renderer.text(w / 2 - 38, h / 2, 150,165,60, alpha, "cb+", 0, "⯇")
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

local dt_latency = 0
local function doubletap()
    if not ui_get(faster_dt) then
        ui_set(ref_maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        return
    end

    ui_set(ref_dt_fl, 1)
    ui_set(ref_fl_limit, math.min(14, ui_get(ref_fl_limit)))

    if ui_get(ref_fd) or not ui_get(ref_dt_key) then
        ui_set(ref_maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        ui_set(ref_dt_hc, 0)
    else
        if ui_get(adaptive_dt) then
            if dt_latency <= 20 then
                ui_set(ref_maxprocessticks, 18)
                cvar.cl_clock_correction:set_int(0)
                ui_set(ref_dt_hc, 15)
            elseif dt_latency <= 40 then
                ui_set(ref_maxprocessticks, 18)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 20)
            elseif dt_latency <= 65 then
                ui_set(ref_maxprocessticks, 18)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 10)
            elseif dt_latency <= 95 then
                ui_set(ref_maxprocessticks, 17)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 20)
            else
                ui_set(ref_maxprocessticks, 17)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 15)
            end
        else
            ui_set(ref_maxprocessticks, 18)
            cvar.cl_clock_correction:set_int(0)
            ui_set(ref_dt_hc, 20)
        end
    end
end

local end_choke_cycle = 0

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
    if ui_get(legit_aa_use) and e.in_use == 1 then
        if entity_get_classname(entity_get_player_weapon(entity_get_local_player())) == "CC4" then return end

        if e.in_attack == 1 then
            e.in_use = 1
        end
    
        if e.chokedcommands == 0 then
            e.in_use = 0
        end
    end
end

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
        doubletap()
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
        
        dt_latency = client.latency() * 1000
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
end
main()