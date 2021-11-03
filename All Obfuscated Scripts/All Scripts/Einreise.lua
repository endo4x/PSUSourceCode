--[[
	id: 3KdueRKrm50yJgfyKdiY0
	name: Einreise
	description: dw
	time1: 2021-07-03 22:38:14.214955+00
	time2: 2021-07-03 22:38:14.214956+00
	uploader: endILJ7HNjVIZCz1DajtBSeklWVeOgx1J3h9pS6d
	uploadersession: pPgYfyAQ9sdYSqaqndOnhd6Gu11Uxe
	flag: f
--]]

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}
ESX = nil

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        PlayerData = ESX.GetPlayerData()
    end
)
local loaded = false
RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
    "esx:playerLoaded",
    function(xPlayer)
        loaded = true
    end
)

local enable = false
function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage(
            {
                action = "open"
            }
        )
    else
        SendNUIMessage(
            {
                action = "close"
            }
        )
    end
end


RegisterNetEvent("showMoney")
AddEventHandler("showMoney", function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    ESX.TriggerServerCallback('LL_inventory:loadmoney', function(money)

        TriggerEvent('notify', 1, "System", "Bargeld: " .. money .. "$", 5000)

    end)
end)

--RegisterNetEvent("schlüssel")
--AddEventHandler("schlüssel", function()
    --PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

    --local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    --if closestPlayer == -1 or closestDistance > 1.0 then
        --TriggerEvent('notify', 4, "System", "Kein Spieler In deiner Nähe", 5000)    
      --else
        --TriggerEvent('esx_givecarkeys:keys', GetPlayerServerId(closestPlayer))
    --end
--end)


RegisterNetEvent("kabelbinder")
AddEventHandler("kabelbinder", function()
        TriggerServerEvent('nexus:fesselnt')
end)

RegisterNetEvent("suchen")
AddEventHandler("suchen", function()
    local playerPed = GetPlayerPed(-1)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~=-1 and distance <= 2.0 then
        ESX.TriggerServerCallback("bens_cuff_item:isCuffed",function(cuffed)
            if not cuffed then
                TriggerEvent('notify', 1, "System", "Der Spieler ist nicht gefesselt!", 5000)
            else
                TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
                exports['vue_progress']:startUI(10000, text) 
                Wait(10000)   
                        ESX.TriggerServerCallback('PommesMitWasser:getOtherPlayerData', function(data)            
                            local blackMoney = 0
                            local elements = {}

                            print('Data' .. json.encode(data))
            
                            for i=1, #data.accounts, 1 do
                                if data.accounts[i].name == 'black_money' then
                                    blackMoney = data.accounts[i].money
                                end
                            end
        
        
        
                            table.insert(elements, {label = '--- Waffen ---', value = nil})
            
                            for i=1, #data.weapons, 1 do
                                table.insert(elements, {
                                label          = ESX.GetWeaponLabel(data.weapons[i].name),
                                value          = data.weapons[i].name,
                                itemType       = 'item_weapon',
                                amount         = data.ammo,
                                })
                            end
            
                            table.insert(elements, {label = '--- Inventar ---', value = nil})
            
                            for i=1, #data.inventory, 1 do
                                if data.inventory[i].count > 0 then
                                table.insert(elements, {
                                    label          =  data.inventory[i].count .. ' ' .. data.inventory[i].label,
                                    value          = data.inventory[i].name,
                                    itemType       = 'item_standard',
                                    amount         = data.inventory[i].count,
                                })
                                end
                            end
            
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
                                title    = 'Inventar',
                                align    = 'top-left',
                                elements = elements
                            }, function(data, menu)
                            end, function(data, menu)
                                menu.close()
                            end)
                        end, GetPlayerServerId(player))
                    end
               -- end)
           -- end
           ClearPedTasksImmediately(playerPed)
           ClearPedTasks(playerPed)
        end, GetPlayerServerId(player))
    else
        ESX.ShowNotification("Kein Spieler in der Nähe!")
    end
end)

RegisterNetEvent("giveMoney")
AddEventHandler("giveMoney", function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        
        TriggerEvent('notify', 4, "System", "Kein Spieler In deiner Nähe", 5000)      
      else
        ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'asas',
            {
              title = "Geldbetrag"
            },
        function(data2, menu2)
            menu2.close()

            if closestPlayer == -1 or closestDistance > 1.0 then
                TriggerEvent('notify', 4, "System", "Kein Spieler In deiner Nähe", 5000) 
            else
                TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_money", "money", tonumber(data2.value))
            end
        end, function(data2, menu2)
          menu2.close()
      end)
    end
end)

RegisterNetEvent("giveausweis")
AddEventHandler("giveausweis", function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        TriggerEvent('notify', 4, "System", "Kein Spieler In deiner Nähe", 5000) 
    else
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent("kabelbinderr")
AddEventHandler("kabelbinderr", function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        TriggerEvent('notify', 4, "System", "Kein Spieler In deiner Nähe", 5000) 
    else 
        TriggerEvent("bens_cuff_item:checkCuff",GetPlayerServerId(closestPlayer) )

    end
end)

RegisterNetEvent("kabelbindervorne")
AddEventHandler("kabelbindervorne", function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        TriggerEvent('notify', 4, "System", "Kein Spieler In deiner Nähe", 5000) 
    else 
        TriggerEvent("bens_cuff_item:checkCuff3",GetPlayerServerId(closestPlayer) )

    end
end)

RegisterNetEvent("lizenz")
AddEventHandler("lizenz", function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then                    
    TriggerServerEvent('ps_lizenzen:load', GetPlayerServerId(player))
    else
        TriggerServerEvent('ps_lizenzen:load', GetPlayerServerId(PlayerId()))
    end
end)

RegisterNetEvent("id")
AddEventHandler("id", function()
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
	local player, distance = ESX.Game.GetClosestPlayer()

	if distance ~= -1 and distance <= 3.0 then
        TriggerEvent('notify', 1, "System", "Support-ID vom Spieler ist ".. GetPlayerServerId(player), 8000)
        TriggerEvent('notify', 1, "System", "Der Spieler heißt: ".. GetPlayerName(player) , 8000)  
	else
        TriggerEvent('notify', 4, "System", "Kein Spieler In deiner Nähe", 5000) 

	end
end)

RegisterNetEvent("ausweis")
AddEventHandler("ausweis", function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent("abschließen")
AddEventHandler("abschließen", function()
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    TriggerEvent("esx_carlock:lock")
end)

RegisterNetEvent("stopanim")
AddEventHandler(
    "stopanim",
    function()
        SetNuiFocus(false, false)
        ClearPedTasks(PlayerPedId())
    end
)

AddEventHandler(
    "onResourceStop",
    function(name)
        if GetCurrentResourceName() ~= name then
            return
        end
        SetNuiFocus(false, false)
    end
)

CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 252) then
                if loaded then
                    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                        TriggerServerEvent("getPlayerMenu")
                    end
                end
            end
        end
    end
)
