--[[
	id: wsKyveBocRDcCZTHh3W4N
	name: Ipad Server Lua
	description: Server
	time1: 2021-07-03 22:51:36.076275+00
	time2: 2021-07-03 22:51:36.076275+00
	uploader: endILJ7HNjVIZCz1DajtBSeklWVeOgx1J3h9pS6d
	uploadersession: pPgYfyAQ9sdYSqaqndOnhd6Gu11Uxe
	flag: f
--]]

ESX = nil
local IsHandcuffed2 = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNetEvent("bens_cuff_item2:checkCuff2")
AddEventHandler("bens_cuff_item2:checkCuff2", function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        ESX.TriggerServerCallback("bens_cuff_item2:isCuffed2",function(cuffed2)
            if not cuffed2 then
                TriggerServerEvent("bens_cuff_item:handcuff",GetPlayerServerId(player),false)
                FreezeEntityPosition(PlayerPedId(), true)
                TriggerServerEvent("bens_cuff_item2:handcuff2",GetPlayerServerId(player),true)
                Citizen.Wait(4500)
                FreezeEntityPosition(PlayerPedId(), false)
            else
                TriggerServerEvent("bens_cuff_item2:uncufffürbeamte2",GetPlayerServerId(player))
            end
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'busted', 1.0)
        end,GetPlayerServerId(player))
    else
        exports['grv_notify']:SendAlert('error', 'Keine Spieler in der Nähe')
    end
end)
      

RegisterNetEvent("bens_cuff_item2:uncuff2")
AddEventHandler("bens_cuff_item2:uncuff2",function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        TriggerServerEvent("bens_cuff_item2:uncuff2",GetPlayerServerId(player))
    else
        exports['grv_notify']:SendAlert('error', 'Keine Spieler in der Nähe')
    end
end)

RegisterNetEvent("bens_cuff_item2:uncufffürbeamte2")
AddEventHandler("bens_cuff_item2:uncufffürbeamte2",function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        TriggerServerEvent("bens_cuff_item2:uncufffürbeamte2",GetPlayerServerId(player))
    else
        exports['grv_notify']:SendAlert('error', 'Keine Spieler in der Nähe')
    end
end)


RegisterNetEvent('bens_cuff_item2:forceUncuff2')
AddEventHandler('bens_cuff_item2:forceUncuff2',function()
    IsHandcuffed2 = false
    local playerPed = GetPlayerPed(-1)
    ClearPedSecondaryTask(playerPed)
    SetEnableHandcuffs(playerPed, false)
    DisablePlayerFiring(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed, true)
    FreezeEntityPosition(playerPed, false)
    DisplayRadar(true)
end)

--[[RegisterNetEvent("bens_cuff_item2:handcuff2")
AddEventHandler("bens_cuff_item2:handcuff2",function()
    local playerPed = GetPlayerPed(-1)
    IsHandcuffed2 = not IsHandcuffed2
    Citizen.CreateThread(function()
        if IsHandcuffed2 then
            ClearPedTasks(playerPed)
            SetPedCanPlayAmbientBaseAnims(playerPed, true)

            Citizen.Wait(10)
            RequestAnimDict('anim@move_m@prisoner_cuffed')
            while not HasAnimDictLoaded('anim@move_m@prisoner_cuffed') do
                Citizen.Wait(0)
            end
			Citizen.Wait(0)
            TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            DisplayRadar(false)
        end
    end)
end)--]]


RegisterNetEvent("bens_cuff_item2:handcuff2")
AddEventHandler("bens_cuff_item2:handcuff2",function()
    local playerPed = GetPlayerPed(-1)
    IsHandcuffed2 = not IsHandcuffed2
    Citizen.CreateThread(function()
        if IsHandcuffed2 then
            ClearPedTasks(playerPed)
            SetPedCanPlayAmbientBaseAnims(playerPed, true)

            Citizen.Wait(10)
            RequestAnimDict('anim@move_m@prisoner_cuffed')
            while not HasAnimDictLoaded('anim@move_m@prisoner_cuffed') do
                Citizen.Wait(100)
            end
            RequestAnimDict('anim@move_m@prisoner_cuffed')
            while not HasAnimDictLoaded('anim@move_m@prisoner_cuffed') do
                Citizen.Wait(100)
            end
			TaskPlayAnim(playerPed, "anim@move_m@prisoner_cuffed", "idle", 8.0, -8, -1, 32, 0, 0, 0, 0)
			Citizen.Wait(5000)
            TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(false)
        else
            Citizen.Wait(5000)
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
            DisplayRadar(false)
            FreezeEntityPosition(playerPed, false)
        end
    end)
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsHandcuffed2 then
            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            DisplayRadar(false)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 74, true)
			DisableControlAction(0, 2, true) -- Disable pan
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
            DisableControlAction(1, 254, true)
			DisableControlAction(0, 47, true)  -- Disable weapon
        end
        if not IsHandcuffed2 and not IsControlEnabled(0, 140) then EnableControlAction(0, 140, true)  end
        if not IsHandcuffed2 and not IsControlEnabled(0, 74) then EnableControlAction(0, 74, true)  end
    end
end)

