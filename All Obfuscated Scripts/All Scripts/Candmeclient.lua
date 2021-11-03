--[[
	id: KI_17v--s2fLgtO-rrDdc
	name: Can 3dme -client
	description: Can 3dme -client
	time1: 2021-05-03 01:51:38.569336+00
	time2: 2021-05-03 01:51:38.569337+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

-- ## 3dme : client side

-- ## Variables
local pedDisplaying = {}

-- ## Functions

-- OBJ : draw text in 3d
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    local c = Config.visual.color
    SetTextColour(c.r, c.g, c.b, c.a)
    SetTextScale(0.0, Config.visual.scale * scale)
    -- SetTextSize(0.3)
    SetTextFont(Config.visual.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end

local function DrawText3Ds(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    local c = Config.visuals.color
    SetTextColour(c.r, c.g, c.b, c.a)
    SetTextScale(0.0, Config.visuals.scale * scale)
    SetTextFont(Config.visuals.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end

-- OBJ : handle the drawing of text above a ped head
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function Display(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= Config.visual.dist then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(Config.visual.time)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z-0.1), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

local function DisplayDo(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= Config.visual.dist then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(Config.visual.time)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3Ds(vector3(x, y, z-0.5), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

-- ## Events

-- Share the display of 3D text
RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text)
    end
end)

RegisterNetEvent('3dme:shareDisplayDo')
AddEventHandler('3dme:shareDisplayDo', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        DisplayDo(ped, text)
    end
end)

local LANGUAGE = Config.language
TriggerEvent('chat:addSuggestion', '/' .. Languages[LANGUAGE].commandName, Languages[LANGUAGE].commandDescription, Languages[LANGUAGE].commandSuggestion)

-- ### CHAT MESSAGE


RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
	TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(55, 120, 105, 1.0); border-radius: 6px;"><i class="fas fa-bell"style="font-size:15px"></i>^*{0}^r {1}</font></i></b></div>',
            args = { name , message }
			})
  
  elseif pid ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 5.0 then
	TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(55, 120, 105, 1.0); border-radius: 6px;"><i class="fas fa-bell"style="font-size:15px"></i>^*{0}^r {1}</font></i></div>',
            args = { name , message }
			})
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(136, 75, 116, 1.0); border-radius: 6px;"><i class="fas fa-bell"style="font-size:15px"></i>{1} ^*({0})</font></i></b></div>',
            args = { name , message }
			})
  elseif pid ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 5.0 then
    TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(136, 75, 116, 1.0); border-radius: 6px;"><i class="fas fa-bell"style="font-size:15px"></i>{1} ^*({0})</font></i></b></div>',
            args = { name , message }
			})
  end
end)


-- GANG BÖLGELERİNE BLIP

-- blips = {
--     -- {id = "green", x= -72.41, y = -1567.95, z = 31.1, width = 300.0, height = 100.0, color = 2, rotation = 200.4},
--     -- {id = "ballas", x= 7.95, y = -1860.03, z = 24.84, width = 100.0, height = 345.0, color = 7, rotation = 195.88},
--     -- {id = "vagos", x= 955.64, y = -2219.9, z = 30.55, width = 100.0, height = 250.0, color = 46, rotation = 199.28},
--     -- {id = "bloodz", x= -1471.15, y = -658.1, z = 29.34, width = 100.0, height = 200.0, color = 1, rotation = 199.62},
--     -- {id = "triads", x= -1009.92, y = -999.59, z = 2.22, width = 100.0, height = 200.0, color = 16, rotation = 199.62},
--     -- {id = "aztecas", x= 327.0, y = -2033.47, z = 20.94, width = 250.0, height = 150.0, color = 68, rotation = 195.78}
-- }

-- Citizen.CreateThread(function()
--     for i = 1, #blips, 1 do
--         local blip = AddBlipForArea(blips[i].x, blips[i].y, blips[i].z, blips[i].width, blips[i].height)
--         SetBlipAlpha(blip, 100)
--         SetBlipColour(blip, blips[i].color)
--         SetBlipRotation(blip, blips[i].rotation)
--         SetBlipDisplay(blip, 3)
--         SetBlipAsShortRange(blip, true)
--     end
-- end)
