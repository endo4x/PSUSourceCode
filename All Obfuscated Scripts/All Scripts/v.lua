--[[
	id: wxlEJtICJFWUHZZvcsTlj
	name: v
	description: v
	time1: 2021-06-16 14:52:02.082526+00
	time2: 2021-06-16 14:52:02.082526+00
	uploader: WjR0EplC6unhMu6yc6CYfcielOfPKlUpl3OQqHSi
	uploadersession: pyPLklwh5lEUzdaU9TL0aOo6jzb1CS
	flag: f
--]]

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(1)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

Config = {}
Config.locations = {}

Config.locations = {
    {
        label = '<b style="color:#1F397A;font-size:20px;"> كراج لوس سانتوس', 
        pos = {
            x = 198.93, 
            y = -1473.52, 
            z = 29.14, 
            heading = 49.32
        }
    },
    {
        label = '<b style="color:orange;font-size:20px;"> حجز لوس سانتوس', 
        pos = {
            x = 404.01, 
            y = -1627.33, 
            z = 29.29, 
            heading = 220.42
        }
    },
    {
        label = '<b style="color:#1F397A;font-size:20px;"> كراج ساندي شورز', 
        pos = {
            x = 1734.85, 
            y = 3712.58, 
            z = 34.14, 
            heading = 109.22
        }
    },
    {
        label = '<b style="color:orange;font-size:20px;"> حجز ساندي شورز', 
        pos = {
            x = 1734.33, 
            y = 3624.82, 
            z = 34.87, 
            heading = 21.18
        }
    },
    {
        label = '<b style="color:#1F397A;font-size:20px;"> كراج بوليتو', 
        pos = {
        x = -213.82, 
        y = 6254.91, 
        z = 31.49, 
        heading = 142.17
        }
    },
    {
        label = '<b style="color:orange;font-size:20px;"> حجز بوليتو', 
        pos = {
        x = -352.12, 
        y = 6071.13, 
        z = 31.5, 
        heading = 55.19
        }
    },
}

local used = false


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustReleased(1, 344) then
            if used == false then
                OpenTeleportMenu()
            else
                exports.pNotify:SendNotification({
                    text = '<center><b style="color:orange;font-size:20px;"> لايمكنك الإنتقال مرة أخرى ',
                    type = "alert",
                    timeout = (2000),
                    layout = "centerleft",
                    queue = "global"
                })
            end
        end
    end
end)

OpenTeleportMenu = function()
    local elements = {}
    for k,v in pairs(Config.locations) do
        table.insert(elements, {label = v.label, value = k})
    end
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "الانــتــقــالات",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
        local playerPed = PlayerPedId()
        local pos = Config.locations[data.current.value].pos
        ESX.Game.Teleport(playerPed, {x = pos.x, y = pos.y, z = pos.z, heading = pos.heading},function()
            print('Teleported')
            TriggerEvent("JoinTransistion:start")
        end)
        used = true
    end, function(data, menu)
        menu.close()
    end)
end


local cooldown = 10

RegisterNetEvent('UpdateHold:UpdateHold')
AddEventHandler('UpdateHold:UpdateHold', function(newishold)
    cooldown = newishold
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if cooldown > 0 then
            DrawText2("[ ~w~ﻖﺋﺎﻗﺩ "..cooldown.."~b~ : ﻝﺎﻘﺘﻧﻹﺍ ﺔﻴﺻﺎﺧ ]")
        else
            return
		end
	end
end)

function DrawText2(text)
    RegisterFontFile('A9eelsh')
    fontId = RegisterFontId('A9eelsh')
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextScale(0.0, 0.40)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.427, 0.87)
end