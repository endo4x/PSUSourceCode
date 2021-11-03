--[[
	id: h4zFh-IS8n2lMunfHx8Cb
	name: ssss
	description:  
	time1: 2021-05-15 21:19:15.746382+00
	time2: 2021-05-15 21:19:15.746382+00
	uploader: n5M3WSh2R6KWVFbR1T4uwiIRhlNHlPU3TC0nTRod
	uploadersession: 0Rm5lUJKfAFD4_n4q37ukdK-kqLUEE
	flag: f
--]]

ESX = nil

TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)

local location = Config.textlocation
local locationspawner1 = Config.spawnlocation1
local locationspawner2 = Config.spawnlocation2
local dist = nil
local begin = true
local zettext = "~b~~b~Druk op ~b~[E]~b~ voor een ~b~Wager"
local inprogress = false
local full = false
local repawnlocation = Config.respawnlocation
local colored3d = {
    r = 0, g = 128, b = 255
}

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNetEvent('uptime:revive')
AddEventHandler('uptime:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent("uptime:heal")
AddEventHandler("uptime:heal", function()
    local playerPed = PlayerPedId()    
    local maxHealth = GetEntityMaxHealth(playerPed)
    SetEntityHealth(playerPed, maxHealth)
end)

function notify(str)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandThefeedPostTicker(true, false)
end

RegisterNetEvent("updatetextclient")
AddEventHandler("updatetextclient", function(info)
    zettext = "~b~~b~Wager voor $~b~" .. info .. " ~b~1/2 (Klik ~b~[E]~b~)"
    colored3d = {
        r = 252, g = 148, b = 78
    }
    inprogress = true
    print("update")
end)

RegisterNetEvent("playerwon")
AddEventHandler("playerwon", function(amount, ped)
    notify("~b~~b~Je hebt $~b~" .. amount .. " ~b~gewonnen")
    SetEntityCoords(ped, repawnlocation.x, repawnlocation.y, repawnlocation.z, 0, 0, 0, false)
end)

RegisterNetEvent("playerlost")
AddEventHandler("playerlost", function(amount, ped)
    notify("~b~~b~Je hebt -$~r~" .. amount .. " ~b~verloren")
    SetEntityCoords(ped, repawnlocation.x, repawnlocation.y, repawnlocation.z, 0, 0, 0, false)
end)

RegisterNetEvent("startmatchspeler1")
AddEventHandler("startmatchspeler1", function(ped)
    startplayer1(ped)
end)

RegisterNetEvent("startmatchspeler2")
AddEventHandler("startmatchspeler2", function(ped)
    startplayer2(ped)
end)

RegisterNetEvent("matchstarted")
AddEventHandler("matchstarted", function()
    zettext = "~b~~b~Er is al een ~b~Wager ~b~bezig"
    colored3d = {
        r = 255, g = 0, b = 0
    }
    full = true
end)

RegisterNetEvent("resetmatch")
AddEventHandler("resetmatch", function()
    zettext = "~b~~b~Druk op ~b~[E]~b~ voor een ~b~Wager"
    colored3d = {
        r = 0, g = 128, b = 255
    }
    full = false
    inprogress = false
end)

Citizen.CreateThread(function()

    while begin do 
        Citizen.Wait(0)
        
        local ped = PlayerPedId() 
        local pedloc = GetEntityCoords(ped)

        dist = #(pedloc.xy - location.xy)

        if dist < 45 then 
        Draw3DText(location.x, location.y, location.z, 0.5, zettext)
        DrawMarker(20, location.x, location.y, location.z - 0.4, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, colored3d.r, colored3d.g, colored3d.b, 155, false, true, 2, nil, nil, false)
        
        if dist < 1.5 and not full then
            if not inprogress then
                if IsControlJustReleased(0, 38) then
                    openbetmenu()
                    --start()
                end
            else
                if IsControlJustReleased(0, 38) then
                    print("werkt2")
                    TriggerServerEvent("getsecondplayer", PlayerPedId())
                end
            end
        end


        end
    end

end)

function openbetmenu()
	local player = PlayerPedId()
	local elements = {}

	local value1 = Config.geldamount1
    local value2 = Config.geldamount2
    local value3 = Config.geldamount3
    local value4 = Config.geldamount4
    local value5 = Config.geldamount5

    table.insert(elements,{label = value1.label, value = "setone"})
	table.insert(elements,{label = value2.label, value = "settwo"})
    table.insert(elements,{label = value3.label, value = "settree"})
    table.insert(elements,{label = value4.label, value = "setfour"})
    table.insert(elements,{label = value5.label, value = "setfive"})
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "choose_bet_menu",
		{
			title    = "Choose bet amount",
			align    = "center",
			elements = elements
		},
	function(data, menu)
	
			if data.current.value == "setone" then
                TriggerServerEvent("updatetext", value1.amount)
                TriggerServerEvent("getfirstplayer", PlayerPedId())
                menu.close()
            elseif data.current.value == "settwo" then
                TriggerServerEvent("updatetext", value2.amount)
                TriggerServerEvent("getfirstplayer", PlayerPedId())
                menu.close()
            elseif data.current.value == "settree" then
                TriggerServerEvent("updatetext", value3.amount)
                TriggerServerEvent("getfirstplayer", PlayerPedId())
                menu.close()
            elseif data.current.value == "setfour" then
                TriggerServerEvent("updatetext", value4.amount)
                TriggerServerEvent("getfirstplayer", PlayerPedId())
                menu.close()
            elseif data.current.value == "setfive" then
                TriggerServerEvent("updatetext", value5.amount)
                TriggerServerEvent("getfirstplayer", PlayerPedId())
                menu.close()
            end
			
	end, function(data, menu)
		menu.close()
		ClearPedTasks(player)
		FreezeEntityPosition(player,false)
	end, function(data, menu)
	end)
end


function startplayer1(ped)
    SetEntityCoords(ped, locationspawner1.x, locationspawner1.y, locationspawner1.z, 0, 0, 0, false)
    SetEntityHeading(ped, 103.95)    
end

function startplayer2(ped)
    SetEntityCoords(ped, locationspawner2.x, locationspawner2.y, locationspawner2.z, 0, 0, 0, false)
    SetEntityHeading(ped, 284.54)
end





