--[[
	id: Ndow7vP5YNDwHozBjfmzb
	name: C_Visuals4
	description: C_Visuals4
	time1: 2021-07-13 18:48:27.488636+00
	time2: 2021-07-13 18:48:27.488637+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
local label = ui.new_label("Lua", "b", '                      =8.Thirdperson=')
local ui_get = ui.get
local ui_set = ui.set
local ui_ref = ui.reference
local ui_hotkey = ui.new_hotkey
local client_set_event_callback = client.set_event_callback
local client_console_log = client.log
local client_console_cmd = client.exec

local new_button = ui.new_checkbox("lua", "b", "Disable collision")
local new_slider = ui.new_slider("lua", "b", "Thirdperson delta", 30, 200, 150)

ui.set_callback(new_slider, function()
    slider = ui.get(new_slider)
client.exec("cam_idealdist ", slider)
--client.set_cvar("cam_idealdist",slider)
end)

    ui.set_callback(new_button, function()
        client.set_event_callback("paint", function()
        if ui.get(new_button) then 
            client.exec("cam_collision 0")
            client.exec("cam_idealdist ", slider)
        else
            client.exec("cam_collision 1")
            client.exec("cam_idealdist ", slider)
        end
    end)
end)

local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")

local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(new_button,false)
		ui.set_visible(new_slider,false)
	
    else
        ui.set_visible(new_button,true)
		ui.set_visible(new_slider,true)
		

    end
end

client_set_event_callback("paint",HIDE_MEAN)
-------------------------------------------------------------------------------------------------
local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')
local label = ui.new_label("Lua", "b", '                   =9.Custom ESP=')

local success, surface = pcall(require, 'gamesense/surface')

if not success then
    error('\n\n - Surface library is required \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n')
end

-- Initialization
local verdana = surface.create_font('Verdana', 15, 400, { 0x000 --[[ Outline ]] })
local small = surface.create_font('Small Fonts', 8, 450, { 0x200 --[[ Outline ]] })

-- Plugin elements
local refer = { 'lua', 'b' }
local health_bar = { 'off', 'default', 'custom color' }
local flag_list = { 'fake', 'delay', 'helm', 'scoped', 'duck', 'bomb', 'host', 'pin' }

local duck_ticks = { }
local menu = {
    team = ui.reference('Visuals', 'Player ESP', 'Teammates'),

    names = {
        a = ui.new_checkbox(refer[1], refer[2], 'names'),
        b = ui.new_color_picker(refer[1], refer[2], 'names color', 255, 255, 255, 150)
    },

    healthbar = { 
        c = ui.new_combobox(refer[1], refer[2], 'healthbar', health_bar),
        d = ui.new_color_picker(refer[1], refer[2], 'healthbar color', 255, 255, 255, 255)
    },

    number_enable = ui.new_checkbox(refer[1], refer[2], 'Show Health(Number)'),
    number_color = ui.new_color_picker(refer[1], refer[2], 'Number Color', 255, 255, 255, 255),

    flags = ui.new_multiselect(refer[1], refer[2], 'flags', flag_list),
}

-- Local variables & functions
local entity_get_local_player = entity.get_local_player
local entity_get_player_weapon = entity.get_player_weapon
local entity_get_player_resource = entity.get_player_resource

local entity_is_enemy = entity.is_enemy

local entity_get_prop = entity.get_prop
local entity_get_bounding_box = entity.get_bounding_box
local entity_get_player_name = entity.get_player_name
local entity_get_classname = entity.get_classname

local globals_tickcount = globals.tickcount
local globals_maxplayers = globals.maxplayers
local table_insert = table.insert
local math_min = math.min
local ui_get = ui.get


local surface_measure_text = surface.measure_text
local surface_draw_text = surface.draw_text
local surface_draw_filled_rect = surface.draw_filled_rect

local function get_entities(enemy_only, alive_only)
	local enemy_only = enemy_only ~= nil and enemy_only or false
    local alive_only = alive_only ~= nil and alive_only or true
    
    local result = {}

    local me = entity_get_local_player()
    local player_resource = entity_get_player_resource()
    
	for player = 1, globals_maxplayers() do
		if entity_get_prop(player_resource, 'm_bConnected', player) == 1 then
            local is_enemy, is_alive = true, true
            
			if enemy_only and not entity_is_enemy(player) then is_enemy = false end
			if is_enemy then
				if alive_only and entity_get_prop(player_resource, 'm_bAlive', player) ~= 1 then is_alive = false end
				if is_alive then table_insert(result, player) end
			end
		end
	end

	return result
end

client.set_event_callback('paint', function()
    local me = entity_get_local_player()
    local player_resource = entity_get_player_resource()

	local observer_mode = entity_get_prop(me, "m_iObserverMode")
	local active_players = {}

	if (observer_mode == 0 or observer_mode == 1 or observer_mode == 2 or observer_mode == 6) then
		active_players = get_entities(true, true)
	elseif (observer_mode == 4 or observer_mode == 5) then
		local all_players = get_entities(false, true)
		local observer_target = entity_get_prop(me, "m_hObserverTarget")
		local observer_target_team = entity_get_prop(observer_target, "m_iTeamNum")

		for test_player = 1, #all_players do
			if (
				observer_target_team ~= entity_get_prop(all_players[test_player], "m_iTeamNum") and
				all_players[test_player ] ~= me
			) then
				table_insert(active_players, all_players[test_player])
			end
		end
	end

    if #active_players == 0 then
        return
    end

    for i=1, #active_players do
        local player = active_players[i]
        local x1, y1, x2, y2, a_multiplier = entity_get_bounding_box(c, player)

        if x1 ~= nil and a_multiplier > 0 then
            local center = x1 + (x2-x1)/2

            local pflags = ui_get(menu.flags)
            local weapon = entity_get_player_weapon(player)

            if ui_get(menu.names.a) then
                local name = entity_get_player_name(player):lower()
                local w = surface_measure_text(nil, name)

                local r, g, b, a = ui_get(menu.names.b)

                a = a_multiplier*a

                if a_multiplier < 1 then
                    r, g, b, a = 255, 255, 255, a_multiplier*180
                end

                surface_draw_text(center - w/2, y1 - 15, r, g, b, a_multiplier*255, verdana, name)
            end

            if ui_get(menu.healthbar.c) ~= 'off' then
                local health = entity_get_prop(player, 'm_iHealth')
                local hp = math_min(health, 100)

                hp = hp == 0 and 100 or hp

                local a = a_multiplier*255
                local r, g, b = 63, 208, 64

                if hp < 50 then r, g, b = 175, 163, 63 end
                if hp < 35 then r, g, b = 208, 35, 63 end

                if ui_get(menu.healthbar.c) == health_bar[3] then
                    r, g, b, a = ui_get(menu.healthbar.d)
                    a = a_multiplier*a
                end

                if a_multiplier < 1 then
                    r, g, b, a = 255, 255, 255, a_multiplier*180
                end

                local height = y2 - y1 - 1
                local bar_height = (hp / 100) * height

                surface_draw_filled_rect(x1 - 6, y1 - 1, 4, height + 3, 0, 0, 0, a_multiplier*200)
                surface_draw_filled_rect(x1 - 5, y2 - bar_height - 1, 2, bar_height + 1, r, g, b, a)
        
                if hp <= 95 then
                    surface_draw_text(x1 - 9, y2 - bar_height - 6, 255, 255, 255, a_multiplier*255, small, tostring(hp))
                end
            end

            if ui.get(menu.number_enable) then
                
                local health = entity_get_prop(player, 'm_iHealth')
                local hp = math_min(health, 100)

                hp = hp == 0 and 100 or hp

                local r, g, b, a = ui.get(menu.number_color)
                a = a_multiplier * a

                surface_draw_text((x1 + x2) / 2 - 18, y1 - 45, r,g,b,a, verdana, tostring(hp))
                surface_draw_text((x1 + x2) / 2 + 8, y1 - 45, r,g,b,a, verdana, "HP")
            end

            if #pflags ~= 0 then
                local offset = 0

                local m_iPlayerC4 = entity_get_prop(player_resource, 'm_iPlayerC4')
                local m_iPing = entity_get_prop(player_resource, 'm_iPing', player)

                -- { 'fake', 'delay', 'helm', 'scoped', 'blind', 'duck', 'bomb', 'host', 'pin', 'vulnerable' }

                for j=1, #pflags do
                    local flag = pflags[j]

                    if flag == 'fake' and plist.get(player, 'Correction active') then
                        surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 255, 255, 255, a_multiplier*255, small, 'FAKE')
                        offset = offset + 1
                    end

                    if flag == 'delay' and m_iPing > 75 then
                        surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 103, 107, 142, a_multiplier*255, small, m_iPing .. ' MS')
                        offset = offset + 1
                    end

                    if flag == 'helm' then
                        local helm, kev = 
                            entity_get_prop(player, 'm_bHasHelmet') == 1, 
                            entity_get_prop(player, 'm_ArmorValue') ~= 0

                        if helm or kev then
                            local text = helm and 'HELM' or (kev and 'KEV' or '')
                            surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 255, 255, 255, a_multiplier*255, small, text)
                            offset = offset + 1
                        end
                    end

                    if flag == 'scoped' and weapon ~= nil then
                        local wpn_name = entity_get_classname(weapon)
                        local zoom_lvl = entity_get_prop(weapon, 'm_zoomLevel')

                        if wpn_name ~= nil and zoom_lvl ~= 0 and (wpn_name:lower():match("ssg08") or wpn_name:lower():match("awp") or wpn_name:lower():match("scar20") or wpn_name:lower():match("g3sg1")) then
                            surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 242, 229, 176, a_multiplier*255, small, 'SCOPED')
                            offset = offset + 1
                        end
                    end

                    if flag == 'duck' then
                        local toBits = function(num) local t = { }; while num > 0 do rest = math.fmod(num,2); t[#t+1] = rest; num = (num-rest) / 2 end return t end

                        local duck_amt = entity_get_prop(player, 'm_flDuckAmount')
                        local duck_speed = entity_get_prop(player, 'm_flDuckSpeed')
                        local m_fFlags = entity_get_prop(player, 'm_fFlags')

                        if duck_ticks == nil then
                            duck_ticks = { }
                        end

                        if duck_ticks[player] == nil then duck_ticks[player] = 0 end
                        if duck_speed ~= nil and duck_amt ~= nil then
                            if duck_speed == 8 and duck_amt <= 0.9 and duck_amt > 0.01 and toBits(m_fFlags)[1] == 1 then
                                if storedTick ~= globals_tickcount() then
                                    duck_ticks[player] = duck_ticks[player] + 1
                                    storedTick = globals_tickcount()
                                end
            
                                if duck_ticks[player] >= 5 then 
                                    surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 255, 255, 255, a_multiplier*255, small, 'DUCK')
                                    offset = offset + 1
                                end
                            else
                                duck_ticks[player] = 0
                            end
                        end
                    end

                    if flag == 'bomb' and m_iPlayerC4 == player then
                        surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 255, 0, 0, a_multiplier*255, small, 'B')
                        offset = offset + 1
                    end

                    if flag == 'host' and entity_get_prop(player, 'm_hCarriedHostage') ~= nil then
                        surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 255, 0, 0, a_multiplier*255, small, 'VIP')
                        offset = offset + 1
                    end

                    if flag == 'pin' and entity_get_prop(weapon, 'm_bPinPulled') == true then
                        surface_draw_text(x2 + 2, y1 + (offset * 10) - 2, 255, 0, 0, a_multiplier*255, small, 'PIN')
                        offset = offset + 1
                    end
                end
            end
        end
    end
end)


local entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_get_classname = entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.get_classname

local g_command = function(c)
    local me = entity_get_local_player()
    local wpn = entity_get_player_weapon(me)

    local should_fast_plant = 
        entity_get_prop(me, 'm_iTeamNum') == 2 and
        entity_get_classname(wpn) == 'CC4'

    if (c.in_attack == 1 or c.in_use == 1) and should_fast_plant then
        local bomb_zone = entity_get_prop(me, 'm_bInBombZone') == 1

        c.in_use = bomb_zone and 1 or 0
        c.in_attack = bomb_zone and 1 or 0
    end
end

client.set_event_callback('setup_command', g_command)

--helper flag
local interface = {
    flags_select = ui.new_multiselect("lua", "b", "Helper flags", { "High K/D", "Minus K/D", "Low ping", "High ping" }),

    dangerous_label = ui.new_label("lua", "b", "Dangerous flag"),
    dangerous_clr = ui.new_color_picker("lua", "b", "dangerous_clr", 245, 50, 37, 155),

    safe_label = ui.new_label("lua", "b", "Safe flag"),
    safe_clr = ui.new_color_picker("lua", "b", "safe_clr", 65, 245, 37, 255),
}

-- Global variables
local var = {
    enemies = { },
}

-- Setup global variables
local function setup_vars()
    -- Get enemies
    var.enemies = entity.get_players(true)

    -- Set everything to false
    for i, v in ipairs(var.enemies) do
        var.enemies[i] = {
            index = v,

            low_ping = false,
            high_ping = false,
            
            high_kd = false,
            low_kd = false,

            toe_aim = false,
        }
    end
end

local function contains(table, value)
	if table == nil then
		return false
	end
	
    table = ui.get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end


local function get_kd(kills, deaths)
    if kills == 0 then return 0 end

    return kills / deaths
end

local function draw_flag(ent, flag, clr, index)
    local x1, y1, x2, y2, alpha_mult = entity.get_bounding_box(ent)

    if alpha_mult == 0 then return end

    if x1 == nil or y1 == nil or x2 == nil or y2 == nil then return end

    local x = (x1 + x2) / 2
    local y = y1 - 15 - (8 * index)

    renderer.text(x, y, clr[1], clr[2], clr[3], clr[4], "c-", nil, flag)
end

-- Get enemy flags
local function get_flags()
    for i, v in ipairs(var.enemies) do
        local player_resource = entity.get_player_resource()

        local ping = entity.get_prop(player_resource, "m_iPing", var.enemies[i].index)
        local kills = entity.get_prop(player_resource, "m_iKills", var.enemies[i].index)
        local deaths = entity.get_prop(player_resource, "m_iDeaths", var.enemies[i].index)
        local kd = get_kd(kills, deaths)

        if ping < 15 and contains(interface.flags_select, "Low ping") then
            var.enemies[i].low_ping = true
        elseif ping > 60 and contains(interface.flags_select, "High ping") then
            var.enemies[i].high_ping = true
        end

        if kd > 1.5 and contains(interface.flags_select, "High K/D") then
            var.enemies[i].high_kd = true
        elseif kd < 1 and not (kills == 0 and deaths == 0) and contains(interface.flags_select, "Minus K/D") then
            var.enemies[i].low_kd = true
        end
    end
end

local function draw_flags()
    local safe_clr = { ui.get(interface.safe_clr) }
    local dangerous_clr = { ui.get(interface.dangerous_clr) }

    for i, v in ipairs(var.enemies) do
        local index = 0

        if var.enemies[i].high_ping then
            draw_flag(var.enemies[i].index, "HIGH PING", safe_clr, index)
            index = index + 1
        elseif var.enemies[i].low_ping then
            draw_flag(var.enemies[i].index, "LOW PING", dangerous_clr, index)
            index = index + 1
        end

        if var.enemies[i].high_kd then
            draw_flag(var.enemies[i].index, "HIGH KD", safe_clr, index)
            index = index + 1
        elseif var.enemies[i].low_kd then
            draw_flag(var.enemies[i].index, "MINUS KD", safe_clr, index)
            index = index + 1
        end
    end
end

client.set_event_callback("paint", function()
    setup_vars()
    get_flags()
    draw_flags()
end)

local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")

local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(menu.names.a,false)
        ui.set_visible(menu.names.b,false)
        ui.set_visible(menu.healthbar.c,false)
        ui.set_visible(menu.healthbar.d,false)
        ui.set_visible(menu.number_enable,false)
        ui.set_visible(menu.number_color,false)
        ui.set_visible(menu.flags,false)
        ui.set_visible(interface.flags_select,false)
        ui.set_visible(interface.dangerous_label,false)
        ui.set_visible(interface.safe_label,false)
        ui.set_visible(interface.safe_clr,false)
	
    else
        ui.set_visible(menu.names.a,true)
        ui.set_visible(menu.names.b,true)
        ui.set_visible(menu.healthbar.c,true)
        ui.set_visible(menu.healthbar.d,true)
        ui.set_visible(menu.number_enable,true)
        ui.set_visible(menu.number_color,true)
        ui.set_visible(menu.flags,true)
        ui.set_visible(interface.flags_select,true)
        ui.set_visible(interface.dangerous_label,true)
        ui.set_visible(interface.safe_label,true)
        ui.set_visible(interface.safe_clr,true)
	

    end
end

client_set_event_callback("paint",HIDE_MEAN)
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')
local label = ui.new_label("Lua", "b", '                    =10.Zeus flag=')

local style = ui.new_combobox("lua", "b", "Zeus flag", "Off","Icon", "Text")
local stylecolor = ui.new_color_picker("Visuals", "Player ESP", "\n", 235, 229, 52, 255)
local textureid = renderer.load_svg("<svg id=\"svg\" version=\"1.1\" width=\"608\" height=\"689\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" ><g id=\"svgg\"><path id=\"path0\" d=\"M185.803 18.945 C 184.779 19.092,182.028 23.306,174.851 35.722 C 169.580 44.841,157.064 66.513,147.038 83.882 C 109.237 149.365,100.864 163.863,93.085 177.303 C 88.686 184.901,78.772 202.072,71.053 215.461 C 63.333 228.849,53.959 245.069,50.219 251.505 C 46.480 257.941,43.421 263.491,43.421 263.837 C 43.421 264.234,69.566 264.530,114.025 264.635 L 184.628 264.803 181.217 278.618 C 179.342 286.217,174.952 304.128,171.463 318.421 C 167.974 332.714,160.115 364.836,153.999 389.803 C 147.882 414.770,142.934 435.254,143.002 435.324 C 143.127 435.452,148.286 428.934,199.343 364.145 C 215.026 344.243,230.900 324.112,234.619 319.408 C 238.337 314.704,254.449 294.276,270.423 274.013 C 286.397 253.750,303.090 232.582,307.519 226.974 C 340.870 184.745,355.263 166.399,355.263 166.117 C 355.263 165.937,323.554 165.789,284.798 165.789 C 223.368 165.789,214.380 165.667,214.701 164.831 C 215.039 163.949,222.249 151.366,243.554 114.474 C 280.604 50.317,298.192 19.768,298.267 19.444 C 298.355 19.064,188.388 18.576,185.803 18.945 \" stroke=\"none\" fill=\"#ffffff\" fill-rule=\"evenodd\"></path></g></svg>", 25, 25) -- icon from sandvich
client.set_event_callback("paint", function()
    local plist = entity.get_players(true)
    for i = 1, #plist do
        local enemy = plist[i]
        if not entity.is_alive(enemy) then return end
        local weapon = entity.get_player_weapon(enemy)
        local wepclass = entity.get_classname(weapon)
        if wepclass ~= "CWeaponTaser" then return end
        local bbox = { entity.get_bounding_box(enemy) }
        if bbox[1] == nil then return end
        local textsize = { renderer.measure_text("d-", "ZEUS") }
        local rgba = { ui.get(stylecolor) }
        if ui.get(style) == "Icon" then
            renderer.texture(textureid, bbox[1] - textsize[1], bbox[2], 25, 25, rgba[1], rgba[2], rgba[3], rgba[4])
        elseif ui.get(style) == "Text" then
            renderer.text(bbox[1] - textsize[1] / 2, bbox[2], rgba[1], rgba[2], rgba[3], rgba[4], "rd-", 0, "ZEUS")
        end
    end
end)

local moneybutton = ui.reference("Visuals", "Player ESP", "Money")
function moneyespdisabler()
  if client.key_state(0x09) then
    ui.set(moneybutton, true)
  else
    ui.set(moneybutton, false)
  end
end
client.set_event_callback("paint", moneyespdisabler)
local hide_mean = ui.new_checkbox("lua", "b" ,"！！！！！Hide Mean")


local function HIDE_MEAN()
    if ui.get(hide_mean) then

        ui.set_visible(style,false)
		ui.set_visible(stylecolor,false)
	
    else
        ui.set_visible(style,true)
		ui.set_visible(stylecolor,true)
    end
end

client_set_event_callback("paint",HIDE_MEAN)

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')

local ui_get = ui.get
local entity_get_all = entity.get_all
local entity_get_prop = entity.get_prop
local entity_get_local_player = entity.get_local_player
local globals_tickcount = globals.tickcount
local globals_tickinterval = globals.tickinterval
local client_world_to_screen = client.world_to_screen
local client_draw_text = client.draw_text
local client_get_cvar = client.get_cvar
local client_userid_to_entindex = client.userid_to_entindex
local string_format = string.format

local molotov_duration = 7
local enabled_reference = ui.reference("Visuals", "Other ESP", "Grenades")

local projectile_previous = {}
local projectile_current = {}
local projectile_thrown_by_localplayer = {}
local molotovs_team = {}
local molovots_created = {}
local molotov_thrown_at = 0

local function on_grenade_thrown(e)
	userid, grenade = e.userid, e.weapon

	if client_userid_to_entindex(userid) == entity_get_local_player() then
		if grenade == "molotov" or grenade == "incgrenade" then
			molotov_thrown_at = globals_tickcount()
		end
	end
end

local function on_paint(ctx)
	if not ui_get(enabled_reference) then
		return
	end

	local ticks_current = globals_tickcount()
	local seconds_per_tick = globals_tickinterval()
	local molotov_owner = nil

	local projectiles = entity_get_all("CMolotovProjectile")
	local projectile_current = {}
	local existing_projectiles

	if projectiles ~= nil then
		for i=1, #projectiles do
			local projectile = projectiles[i]
			if molotov_thrown_at == ticks_current then
				if projectile_previous[projectile] == nil then
					projectile_thrown_by_localplayer[projectile] = true
				end
			end
			if projectile_thrown_by_localplayer[projectile] then
				projectile_current[projectile] = 0
			else
				projectile_current[projectile] = entity_get_prop(projectile, "m_iTeamNum")
			end
		end
	end

	for key,value in pairs(projectile_previous) do
	  if projectile_current[key] == nil then
	  	--client.log("Projectile with id ", key, " landed at ", ticks_current, ", teamid is ", value)
	  	molotov_owner = value
	  	projectile_previous[key] = nil
	  	projectile_thrown_by_localplayer[key] = nil
	  	molotovs_team[key] = nil
	  	break
	  end
	end

	local molotov_grenades = entity_get_all("CInferno")

	local existing_molotovs = {}

	if molotov_grenades ~= nil then
		local own_team = entity_get_prop(entity_get_local_player(), "m_iTeamNum")
		local friendlyfire = client_get_cvar("mp_friendlyfire")

		for i=1, #molotov_grenades do
			local molotov_grenade = molotov_grenades[i]
			local molotov_team = molotovs_team[molotov_grenade]
			local molotov_created = molovots_created[molotov_grenade]
			if molotov_team == nil then
				molotov_team = molotov_owner
				molotovs_team[molotov_grenade] = molotov_team
				molovots_created[molotov_grenade] = ticks_current
				molotov_created = molovots_created[molotov_grenade]
			end

			local time_since_explosion = seconds_per_tick * (ticks_current - molotov_created)

			--client.log(molotov_created)

			local progress = 1 - time_since_explosion / molotov_duration

			--client.log("molotov ", molotov_grenade, " with teamid ", molotov_team)
			local safe = (molotov_team == own_team)
			if tonumber(friendlyfire) ~= 0 then
				safe = false
			end

			local x, y, z = entity_get_prop(molotov_grenade, "m_vecOrigin")
			local worldX, worldY = client_world_to_screen(ctx, x, y, z)

			if (worldX ~= nil and worldY ~= nil) then

				local message = string_format("%.1fS LEFT", molotov_duration-time_since_explosion)
				client_draw_text(ctx, worldX, worldY+20, 255, 255, 255, 20 + progress * 235, "c-", 150, message)

				local second_string_opacity = 255
				if progress < 0.15 then
					second_string_opacity = (progress)*6.6*255
					if second_string_opacity < 0 then
						second_string_opacity = 0
					end
				end

				if safe then
					client_draw_text(ctx, worldX, worldY-12, 149, 184, 6, second_string_opacity, "c", 150, "SAFE")
				else
					client_draw_text(ctx, worldX, worldY-12, 230, 21, 21, second_string_opacity, "c", 150, "UNSAFE")
				end
			end
			existing_molotovs[molotov_grenade] = true

		end

	end

	for key,value in pairs(molotovs_team) do
		
		if existing_molotovs[key] == nil then
			molotovs_team[key] = nil
			--client.log("Molotov ", key, " disappeared")
		end
	end

	projectile_previous = projectile_current

end

client.set_event_callback("paint", on_paint)
client.set_event_callback("grenade_thrown", on_grenade_thrown)

