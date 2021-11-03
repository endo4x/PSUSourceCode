--[[
	id: X-ITEXue2kop6t6Ro1Gaf
	name: C_Visuals5
	description: C_Visuals6
	time1: 2021-07-13 18:48:54.097291+00
	time2: 2021-07-13 18:48:54.097292+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

local csgo_weapons = require("gamesense/csgo_weapons")
local images = require("gamesense/images")

nadeesp = ui.new_checkbox("VISUALS", "Player ESP", "Show nades")
nadeespclr = ui.new_color_picker("VISUALS", "Player ESP", "Show nades", 255, 255, 255, 255)

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function table_contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

local function average(t) -- these 2 funcs str8 from stack overflow 
    local sum = 0

    for _,v in pairs(t) do
        sum = sum + v
    end

    return sum / #t
end

local player_items = {}

client.set_event_callback("level_init", function()
    player_items = {}
end)

client.set_event_callback("player_death", function(e)
    player_items[client.userid_to_entindex(e.userid)] = {}
end)

client.set_event_callback("player_spawn", function(e)
    player_items[client.userid_to_entindex(e.userid)] = {}
end)

local nadenames = {
    "weapon_molotov",
    "weapon_smokegrenade",
    "weapon_hegrenade",
    "weapon_incgrenade"
}

local icons = {
	moly = images.get_weapon_icon(nadenames[1]),
	smoke = images.get_weapon_icon(nadenames[2]),
	nade = images.get_weapon_icon(nadenames[3]),
	incin = images.get_weapon_icon(nadenames[4]),
}

local sizes = {
	nade = { icons.nade:measure() },
	smoke = { icons.smoke:measure() },
	moly = { icons.moly:measure() },
	incin = { icons.incin:measure() },
}

for k, v in pairs(sizes) do
	sizes[k][1] = math.floor(v[1] * 0.7)
	sizes[k][2] = math.floor(v[2] * 0.7)
end

client.set_event_callback("item_remove", function(e)
    
    local plyr = client.userid_to_entindex(e.userid)
    local name = entity.get_player_name(plyr)
    if entity.is_enemy(plyr) then
        if player_items[plyr] ~= nil then
            local weapon = "weapon_".. e.item
            
            local newtable = {}
            for i, v in ipairs(player_items[plyr]) do
                if v == weapon then
                    weapon = "nothin"
                else
                    table.insert(newtable, v)
                end
            end
            
            player_items[plyr] = newtable 
        else
            player_items[plyr] = {}
        end
    end
end)

client.set_event_callback("item_pickup", function(e)
    
    local plyr = client.userid_to_entindex(e.userid)
    local name = entity.get_player_name(plyr)
    if entity.is_enemy(plyr) then
        if player_items[plyr] == nil then
            player_items[plyr] = {}
        end
        
        local weapon = "weapon_".. e.item
       
        if table_contains(nadenames, weapon) then
            table.insert(player_items[plyr], weapon)
        end
    end
end)

client.set_event_callback("paint", function()
    local teamcheck = false
    local localplayer = entity.get_local_player()
    local obsmode = entity.get_prop(localplayer, "m_iObserverMode")
   	if not entity.is_alive(localplayer) then
   		if obsmode == 4 or obsmode == 5 then
           	if entity.is_enemy(entity.get_prop(localplayer, "m_hObserverTarget")) then
           		teamcheck = true
           	end
        end
   	end

    local player_recources = entity.get_player_resource()
    for player = 1, globals.maxplayers() do
        if entity.get_prop(player_recources, 'm_bConnected', player) == 1 then
            if (entity.is_enemy(player) and not teamcheck) or (not entity.is_enemy(player) and teamcheck) then
                if player_items[player] == nil then
                    player_items[player] = {}
                end

                if entity.is_alive(player) then
                    if not entity.is_dormant(player) then
                       
                        local weapons = {}
                        for index = 0, 64 do
                            local a = entity.get_prop(player, "m_hMyWeapons", index)
                            if a ~= nil then
                                local wep = csgo_weapons(a)
                                if wep ~= nil and wep.type == "grenade" and wep.console_name ~= "weapon_flashbang" and wep.console_name ~= "weapon_decoy" then
                                    table.insert(weapons, wep.console_name)
                                end
                            end
                        end
                        player_items[player] = weapons
                        
                    end
                    
                    if #player_items[player] > 0 and ui.get(nadeesp) then
                        local x1, y1, x2, y2, alpha_multiplier = entity.get_bounding_box(player)
                        if x1 ~= nil and alpha_multiplier ~= 0 then
                            local width = x2 - x1

                            local moly, nade, smoke, incin = false, false, false, false
                            for i, v in ipairs(player_items[player]) do
                                if v == "weapon_molotov" then
                                    moly = true
                                elseif v == "weapon_smokegrenade" then
                                    smoke = true
                                elseif v == "weapon_hegrenade" then
                                    nade = true
                                elseif v == "weapon_incgrenade" then
                                    incin = true
                                end
                            end

                            local length = 0
                            if nade then
                                length = length + 11
                            end
                            if moly then
                                length = length + 11
                            end
                            if incin then
                                length = length + 9
                            end
                            if smoke then
                                length = length + 9
                            end
                            local start = ((width/2) - (length/2)) + 3
                            local spot = 0 
                            
                            local r, g, b, alph = ui.get(nadeespclr)

                            if alpha_multiplier == nil or alpha_multiplier < 1 then
                                local avg = round(average({r, g, b}))
                                r = avg
                                b = avg
                                g = avg
                            end
                            local a = alph * alpha_multiplier
                            if nade then
                                icons.nade:draw(round(x1 + start + spot), y2 + 26, sizes.nade[1], sizes.nade[2], r, g, b, a, false, "f")
                                spot = spot + 11
                            end
                            if moly then
                                icons.moly:draw(round(x1 + start + spot), y2 + 26, sizes.moly[1], sizes.moly[2], r, g, b, a, false, "f")
                                spot = spot + 11
                            end
                            if incin then
                                icons.incin:draw(round(x1 + start + spot),y2 + 26, sizes.incin[1], sizes.incin[2], r, g, b, a, false, "f")
                                spot = spot + 9
                            end
                            if smoke then
                                icons.smoke:draw(round(x1 + start + spot), y2 + 26, sizes.smoke[1], sizes.smoke[2], r, g, b, a, false, "f")
                            end
                        end
                    end
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')

--in game hud changer
local client_set_event_callback, client_get_cvar, renderer_indicator, renderer_text, client_screensize = client.set_event_callback, client.get_cvar, renderer.indicator, renderer.text, client.screen_size
local console = client.exec
local ui_new_combobox = ui.new_combobox
local ui_get, ui_set, ui_set_visible, ui_ref, ui_set_callback = ui.get, ui.set, ui.set_visible, ui.reference, ui.set_callback
local ui_new_multiselect = ui.new_multiselect
local hud_color = ui_new_combobox('lua', 'b', "Hud Color", "Default", "White", "Light Blue", "Blue", "Purple", "Red", "Orange", "Yellow", "Green", "Aqua", "Pink")
ui.set_callback(hud_color, function()
	if ui_get(hud_color) == "Default" then
			cvar.cl_hud_color:set_raw_int(0)
	elseif ui_get(hud_color) == "White" then
			cvar.cl_hud_color:set_raw_int(1)
	elseif ui_get(hud_color) == "Light Blue" then
			cvar.cl_hud_color:set_raw_int(2)
	elseif ui_get(hud_color) == "Blue" then
			cvar.cl_hud_color:set_raw_int(3)
	elseif ui_get(hud_color) == "Purple" then
			cvar.cl_hud_color:set_raw_int(4)
	elseif ui_get(hud_color) == "Red" then
			cvar.cl_hud_color:set_raw_int(5)
	elseif ui_get(hud_color) == "Orange" then
			cvar.cl_hud_color:set_raw_int(6)
	elseif ui_get(hud_color) == "Yellow" then
			cvar.cl_hud_color:set_raw_int(7)
	elseif ui_get(hud_color) == "Green" then
			cvar.cl_hud_color:set_raw_int(8)
	elseif ui_get(hud_color) == "Aqua" then
			cvar.cl_hud_color:set_raw_int(9)
	elseif ui_get(hud_color) == "Pink" then
			cvar.cl_hud_color:set_raw_int(10)
		end
	end)
	
---------
local rectile = ui.reference("VISUALS", "Other ESP", "Penetration reticle")

local function refugee420()
	local isscoped = entity.get_prop(entity.get_local_player(), "m_bIsScoped")

	if isscoped == 1 then
		ui.set(rectile, true)
	else
		ui.set(rectile, false)
	end
end

client.set_event_callback("run_command", refugee420)
-------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

local label = ui.new_label("Lua", "b", '-----------------------------------------------------------')
