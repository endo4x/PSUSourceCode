--[[
	id: wjImpggFxOFzVNKcnBYJo
	name: Bens Cuff Item
	description: Bens Cuff Item
	time1: 2021-07-05 17:19:33.363961+00
	time2: 2021-07-05 17:19:33.363962+00
	uploader: lqGTM7c9511nXgsYGn6GipciWzXeF4k1dlePPmkB
	uploadersession: kei8QVOxGrWrbSu-4mcMQRX3yAF2rK
	flag: f
--]]

Fly = nil
local IsHandcuffed = false

Citizen.CreateThread(function()
	while Fly == nil do
		TriggerEvent('fly:getSharedObject', function(obj) Fly = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNetEvent("bens_nigger_cuffing_item_cool:checkCuff")
AddEventHandler("bens_nigger_cuffing_item_cool:checkCuff", function()
    local player, distance = Fly.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        Fly.TriggerServerCallback("bens_nigger_cuffing_item_cool:isCuffed",function(cuffed)
            if not cuffed then
                TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, 4000, 48, 0, 0, 0, 0) 
                TriggerServerEvent("bens_nigger_cuffing_item_cool:handcuff",GetPlayerServerId(player),true)
            else
                TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8, 5000, 49, 0, 0, 0, 0)
                TriggerServerEvent("bens_nigger_cuffing_item_cool:handcuff",GetPlayerServerId(player),false)
            end
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'busted', 1.0)
        end,GetPlayerServerId(player))
    else
        Fly.ShowNotification("~r~Kein Spieler in der Nähe!")
    end
end)

RegisterNetEvent("bens_nigger_cuffing_item_cool:uncuff")
AddEventHandler("bens_nigger_cuffing_item_cool:uncuff",function()
    local player, distance = Fly.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        TriggerServerEvent("bens_nigger_cuffing_item_cool:uncuff",GetPlayerServerId(player))
    else
        Fly.ShowNotification("~r~Kein Spieler in der Nähe")
    end
end)

RegisterNetEvent('bens_nigger_cuffing_item_cool:forceUncuff')
AddEventHandler('bens_nigger_cuffing_item_cool:forceUncuff',function()
    IsHandcuffed = false
    local playerPed = GetPlayerPed(-1)
    ClearPedSecondaryTask(playerPed)
    SetEnableHandcuffs(playerPed, false)
    DisablePlayerFiring(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed, true)
    FreezeEntityPosition(playerPed, false)
    DisplayRadar(true)
end)

RegisterNetEvent("bens_nigger_cuffing_item_cool:handcuff")
AddEventHandler("bens_nigger_cuffing_item_cool:handcuff",function()
    local playerPed = GetPlayerPed(-1)
    IsHandcuffed = not IsHandcuffed
    Citizen.CreateThread(function()
        if IsHandcuffed then
            ClearPedTasks(playerPed)
            SetPedCanPlayAmbientBaseAnims(playerPed, true)

            Citizen.Wait(10)
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end
            RequestAnimDict('mp_arrest_paired')
            while not HasAnimDictLoaded('mp_arrest_paired') do
                Citizen.Wait(100)
            end
			TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
			Citizen.Wait(5000)
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            DisplayRadar(false)
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
            FreezeEntityPosition(playerPed, false)
            DisplayRadar(true)
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsHandcuffed then
            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            DisplayRadar(false)
            DisableControlAction(0, 140, true)
        end
        if not IsHandcuffed and not IsControlEnabled(0, 140) then EnableControlAction(0, 140, true) end
    end
end)

Citizen.CreateThread(function()
    local wasgettingup = false
    while true do
        Citizen.Wait(250)
        if IsHandcuffed then
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3) or (wasgettingup and not IsPedGettingUp(ped)) then Fly.Streaming.RequestAnimDict("mp_arresting", function() TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0) end) end
            wasgettingup = IsPedGettingUp(ped)
        end
    end
end)