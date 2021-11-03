--[[
	id: yMeXTzadJg2Gc5FvCAzgt
	name: C_Visuals5
	description: C_Visuals5
	time1: 2021-07-13 18:48:37.576996+00
	time2: 2021-07-13 18:48:37.576996+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


local ui_get, ui_set = ui.get, ui.set

local entity_get_local_player = entity.get_local_player

local entity_get_player_weapon = entity.get_player_weapon

local entity_get_prop = entity.get_prop

local entity_is_alive = entity.is_alive



local globals_frametime = globals.frametime

local client_screen_size = client.screen_size

local renderer_gradient = renderer.gradient



local global_alpha = 0

local clamp = function(v, min, max)

    local num = v



    num = num < min and min or num

    num = num > max and max or num



    return num

end



local scope_overlay = ui.reference('Visuals', 'Effects', 'Remove scope overlay')
local label = ui.new_label("Lua", "b", '         =11.Custom scope lines=')
local master_switch = ui.new_checkbox('lua', 'b', 'Custom scope lines')

local color_picker = ui.new_color_picker('lua', 'b', '\n scope_lines_color_picker', 0, 0, 0, 255) --[[ 3D55D6FF / 9BABFDFF ]]



local overlay_position = ui.new_slider('lua', 'b', '\n scope_lines_initial_pos', 0, 500, 250)

local overlay_offset = ui.new_slider('lua', 'b', '\n scope_lines_offset', 0, 500, 15)



local fade_time = ui.new_slider('lua', 'b', 'Fade animation speed', 4, 20, 12, true, 'fr', 1, { [4] = 'Off' })

local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")

local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(master_switch,false)
		ui.set_visible(color_picker,false)
		ui.set_visible(overlay_position,false)
		ui.set_visible(overlay_offset,false)
		ui.set_visible(fade_time,false)

	
    else
		ui.set_visible(master_switch,true)
		ui.set_visible(color_picker,true)
		ui.set_visible(overlay_position,true)
		ui.set_visible(overlay_offset,true)
		ui.set_visible(fade_time,true)

    end
end

client.set_event_callback("paint",HIDE_MEAN)

local g_paint_ui = function()

    ui_set(scope_overlay, true)

end



local g_paint = function()

    local offset, initial_position, fade_time, color =

        ui_get(overlay_offset), ui_get(overlay_position),

        ui_get(fade_time), { ui_get(color_picker) }



    local FT = fade_time > 4 and (globals_frametime()*fade_time) or 1

    local width, height = client_screen_size()



    -- DO STUFF

    local me = entity_get_local_player()

    local wpn = entity_get_player_weapon(me)



    local scope_level = entity_get_prop(wpn, 'm_zoomLevel')

    local scoped = entity_get_prop(me, 'm_bIsScoped') == 1

    local resume_zoom = entity_get_prop(me, 'm_bResumeZoom') == 1



    local is_valid = entity_is_alive(me) and wpn ~= nil and scope_level ~= nil



    if is_valid and scope_level > 0 and scoped and not resume_zoom then

        global_alpha = clamp(global_alpha+FT, 0, 1)

    else

        global_alpha = clamp(global_alpha-FT, 0, 1)

    end



    renderer_gradient(width/2 - initial_position, height / 2, initial_position - offset, 1, color[1], color[2], color[3], 0, color[1], color[2], color[3], global_alpha*color[4], true)

    renderer_gradient(width/2 + offset, height / 2, initial_position - offset, 1, color[1], color[2], color[3], global_alpha*color[4], color[1], color[2], color[3], 0, true)



    renderer_gradient(width / 2, height/2 - initial_position, 1, initial_position - offset, color[1], color[2], color[3], 0, color[1], color[2], color[3], global_alpha*color[4], false)

    renderer_gradient(width / 2, height/2 + offset, 1, initial_position - offset, color[1], color[2], color[3], global_alpha*color[4], color[1], color[2], color[3], 0, false)



    ui_set(scope_overlay, false)

end



local ui_callback = function(c)

    local master_switch = ui_get(c)

    

    if not master_switch then

        global_alpha = 0

    end



    client[(not master_switch and 'un' or '') .. 'set_event_callback']('paint_ui', g_paint_ui)

    client[(not master_switch and 'un' or '') .. 'set_event_callback']('paint', g_paint)

end



ui.set_callback(master_switch, ui_callback)

ui_callback(master_switch)

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')

local ffi = require("ffi")

ffi.cdef[[
    typedef struct {
        float x,y,z;
    } vec3_t_aojnsfdghuinfasiugnhiusfnghsfghsfgh;

    struct tesla_info_t_ioajdngfhijafgidjnhuangfdhargh {
        vec3_t_aojnsfdghuinfasiugnhiusfnghsfghsfgh  m_pos;
        vec3_t_aojnsfdghuinfasiugnhiusfnghsfghsfgh  m_ang;
        int m_entindex;
        const char *m_spritename;
        float m_flbeamwidth;
        int m_nbeams;
        vec3_t_aojnsfdghuinfasiugnhiusfnghsfghsfgh m_color;
        float m_fltimevis;
        float m_flradius;
    };

    typedef void(__thiscall* FX_TeslaFn_iosjfdnghjusfgiuhisfgihsfgjshfgshfj)(struct tesla_info_t_ioajdngfhijafgidjnhuangfdhargh&);
]]

local match = client.find_signature("client_panorama.dll", "\x55\x8B\xEC\x81\xEC\xCC\xCC\xCC\xCC\x56\x57\x8B\xF9\x8B\x47\x18")
local fs_tesla = ffi.cast("FX_TeslaFn_iosjfdnghjusfgiuhisfgihsfgjshfgshfj", match)

local hitbox_pos = entity.hitbox_position
local uidtoentindex = client.userid_to_entindex
local get_local_player = entity.get_local_player

-- https://www.unknowncheats.me/forum/counterstrike-global-offensive/278624-adding-shit-Colored models.html


local label = ui.new_label("Lua", "b", '                    =12.Tesla hit=')
local tesla = ui.new_checkbox('lua', 'b', "Tesla on hit")
local color = ui.new_color_picker('lua', 'b', "color", 255,255,255,255)
local beam_width = ui.new_slider('lua', 'b', "Tesla width", 0, 30, 10)
local beam_radius = ui.new_slider('lua', 'b', "Tesla radius", 0, 1000, 500)
local beams = ui.new_slider('lua', 'b', "Beams", 0, 100, 12)

client.set_event_callback("player_hurt", function(event)
    if ui.get(tesla) then 
        local me = get_local_player()
        local attacker = uidtoentindex(event.attacker)
        if attacker == me then 
            local hurt = uidtoentindex(event.userid)
            local r,g,b,a = ui.get(color)
            local x = client.random_float(-1000, 1000)
            local y = client.random_float(-x, x)
            local z = client.random_float(-y, y)

            local tesla_info = ffi.new("struct tesla_info_t_ioajdngfhijafgidjnhuangfdhargh")
            tesla_info.m_flbeamwidth = ui.get(beam_width)
            tesla_info.m_flradius = ui.get(beam_radius)
            tesla_info.m_entindex = attacker
            tesla_info.m_color = {r/255, g/255, b/255}
            tesla_info.m_pos = { hitbox_pos(hurt, 6) }
            tesla_info.m_ang = {x,y,z}
            tesla_info.m_fltimevis = 0.75
            tesla_info.m_nbeams = ui.get(beams)
            tesla_info.m_spritename = "sprites/physbeam.vmt"
            fs_tesla(tesla_info)
        end
    end
end) 

local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")

local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(tesla,false)
		ui.set_visible(color,false)
		ui.set_visible(beam_width,false)
		ui.set_visible(beam_radius,false)
		ui.set_visible(beams,false)
		
	
    else
		ui.set_visible(tesla,true)
		ui.set_visible(color,true)
		ui.set_visible(beam_width,true)
		ui.set_visible(beam_radius,true)
		ui.set_visible(beams,true)

    end
end

client.set_event_callback("paint",HIDE_MEAN)


-------------------------------------------------

local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')
-----------------------------

local key_state, userid_to_entindex, read, write, get_local_player, get_player_name, get_prop, get_steam64, rectangle, text, get, is_menu_open, mouse_position, new_hotkey, new_checkbox, new_combobox, pairs, set_callback, mp_td_dmgtokick, get_player_resource, _set, _unset, min, remove = client.key_state, client.userid_to_entindex, database.read, database.write, entity.get_local_player, entity.get_player_name, entity.get_prop, entity.get_steam64, renderer.rectangle, renderer.text, ui.get, ui.is_menu_open, ui.mouse_position, ui.new_hotkey, ui.new_checkbox, ui.new_combobox, pairs, ui.set_callback, cvar.mp_td_dmgtokick, entity.get_player_resource, client.set_event_callback, client.unset_event_callback, math.min, table.remove
local is_inside = function(a, b, x, y, w, h) return a >= x and a <= w and b >= y and b <= h end
local tbl_len = function(t) local n=0 for _ in pairs(t) do n=n+1 end return n end
local pos = read('teamdmg_pos')or{300,30} local tX,tY=pos[1],pos[2] local oX,oY,_d local drag_menu=function(x,y,w,h)if not is_menu_open()then return tX,tY end local mouse_down=key_state(0x01)if mouse_down then local X,Y=mouse_position()if not _d then local w,h=x+w,y+h if is_inside(X,Y,x,y,w,h)then oX,oY,_d=X-x,Y-y,true end else tX,tY=X-oX,Y-oY end else _d=false end return tX,tY end
local label = ui.new_label("Lua", "b", '           =13.Teammates Damage=')
local mode = new_combobox('lua', 'b', 'Show Teammates Damage/Kills', 'Off', 'Without Colors', 'Matchmaking Colors', 'Matchmaking Color Names')
local key = new_hotkey('lua', 'b', 'hotkey', true)
local rem = new_checkbox('lua', 'b', 'Remove from list when over amount')
local last_p = read('teamdmg_pos_last') or {}
local h, m, s = client.system_time()
local players = last_p[h .. m] or {}
local num_of_players = tbl_len(players)

local white, color_mode = {255,255,255,255}
local colors = {
	{200, 200, 200, 255, 'BOT'},
	{200, 200, 200, 255, 'Gray'},
	{255, 255, 0, 255, 	 'Yellow'},
	{110, 0, 255, 255, 	 'Purple'},
	{0, 200, 0, 255, 	 'Green'},
	{0, 75, 255, 255, 	 'Blue'},
	{255, 145, 0, 255, 	 'Orange'}
}

local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")

local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(mode,false)
		ui.set_visible(key,false)
		ui.set_visible(rem,false)
	

	
    else
		ui.set_visible(mode,true)
		ui.set_visible(key,true)
		ui.set_visible(rem,true)
	

    end
end

client.set_event_callback("paint",HIDE_MEAN)

local function on_player_stuff(e)
	local attacker, victim, local_player = userid_to_entindex(e.attacker), userid_to_entindex(e.userid), get_local_player()

	if attacker == victim then
		return
	end

	local player_resource = get_player_resource()
	local local_player_team = get_prop(player_resource, 'm_iTeam', local_player)
	local attacker_team = get_prop(player_resource, 'm_iTeam', attacker)
	local victim_team = get_prop(player_resource, 'm_iTeam', victim)
	if attacker_team ~= local_player_team or victim_team ~= local_player_team then
		return
	end

	local steamID3 = get_steam64(attacker)
	if steamID3 == 0 then
		return
	end

	if not players[steamID3] then
		players[steamID3] = {0, 0, get_player_name(attacker), white, colors[get_prop(player_resource, 'm_iCompTeammateColor', attacker) + 3], attacker}
		num_of_players = num_of_players + 1
	end

	if not e.health then
		players[steamID3][1] = players[steamID3][1] + 1
	else
		players[steamID3][2] = players[steamID3][2] + e.dmg_health
	end

	players[steamID3][4] = color_mode == 'Without Colors' and white or players[steamID3][5]
	players[steamID3][3] = color_mode == 'Matchmaking Color Names' and players[steamID3][5][5] or get_player_name(attacker)
end

local function on_paint()
	if not get(key) then
		return
	end

	local x, y = drag_menu(tX, tY, 200, 20)

	rectangle(x, y, 200, 20, 37, 37, 37, 250)
	text(x + 100, y + 10, 255,255,255,255, 'cd', 0, 'Team Damage')
	rectangle(x, y + 20, 200, (num_of_players * 10) + 10, 33, 33, 33, 180)

	local y = y + 25
	local dmg_to_kick = mp_td_dmgtokick:get_int()
	local list_clear = get(rem)
	local gap = 0

	local player_resource = get_player_resource()
	local local_player_team = get_prop( player_resource, 'm_iTeam', get_local_player() )

	for steamid, stuff in pairs(players) do
		local m = min(stuff[2] / dmg_to_kick, 1)
		local c = stuff[4]

		text(x + 5, y + gap, c[1], c[2], c[3], c[4] , 'ld', 42, stuff[3])

		rectangle(x + 50, (y + gap - 3) + 7, 100, 6, 13, 13, 13, 230)
		rectangle(x + 51, (y + gap - 2) + 7, 98*m, 4, 49, 233, 93, 255)

		text(x + 100, y + gap + 7, 255,255,255,255, 'c-d', 0, stuff[2]..'/'..dmg_to_kick)

		text(x + 195, y + gap, 255,255,255,255, 'rd', 0, stuff[1].. ' Kills')

		gap = gap + 11

		if list_clear then
			if stuff[1] >= 3 or stuff[2] >= dmg_to_kick then
				remove(players, steamid)
			end
		end

		if get_prop(player_resource, 'm_iTeam', stuff[6]) ~= local_player_team then
			remove(players, steamid)
		end
	end
end

local function reset_list(e) players,num_of_players={},0 end
local function on_shutdown()
	write('teamdmg_pos', {tX, tY})
	local h, m = client.system_time()
	write('teamdmg_pos_last', {[h .. m] = players})
end

local function on_change(s)
	local e = get(s)
	local callback = e ~= 'Off' and _set or _unset
	color_mode = e

	callback('player_hurt', on_player_stuff)
	callback('player_death', on_player_stuff)
	callback('paint', on_paint)
	callback('cs_win_panel_match', reset_list)
	callback('shutdown', on_shutdown)
end

on_change(mode)
set_callback(mode, on_change)
ui.new_button('lua', 'b', 'Reset List', reset_list)



