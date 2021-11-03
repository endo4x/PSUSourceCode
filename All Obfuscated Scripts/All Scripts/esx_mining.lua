--[[
	id: FGVM7SsTuXQfw_BXCXBEW
	name: esx_mining
	description: script minatore
	time1: 2021-04-24 14:06:05.123904+00
	time2: 2021-04-24 14:06:05.123905+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

ESX = nil
local mining = false

Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    for k, v in pairs(Config.MiningPositions) do
    end
    addBlip(Config.Sell, 207, 2, Strings['sell_mine'])
    Citizen.CreateThread(function()
        while true do
            local sleep = 250
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Sell, true) <= 3.0 then
                sleep = 0
                helpText(Strings['e_sell'])
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('esx_mining:sell')
                end
            end
            Wait(sleep)
        end
    end)
    while true do
        local closeTo = 0
        for k, v in pairs(Config.MiningPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
                closeTo = v
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 2.5 do
                Wait(0)
                helpText(Strings['press_mine'])
                if IsControlJustReleased(0, 38) then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance == -1 or distance >= 4.0 then
                        mining = true
                        SetEntityCoords(PlayerPedId(), closeTo.coords)
                        SetEntityHeading(PlayerPedId(), closeTo.heading)
                        FreezeEntityPosition(PlayerPedId(), true)

                        local model = loadModel(GetHashKey(Config.Objects['pickaxe']))
                        local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                        AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

                        while mining do
                            Wait(0)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'))
                            helpText(Strings['mining_info'])
                            DisableControlAction(0, 24, true)
                            if IsDisabledControlJustReleased(0, 24) then
                                local dict = loadDict('melee@hatchet@streamed_core')
                                TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
                                local timer = GetGameTimer() + 800
                                while GetGameTimer() <= timer do Wait(0) DisableControlAction(0, 24, true) end
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('esx_mining:getItem')
                            elseif IsControlJustReleased(0, 194) then
                                break
                            end
                        end
                        mining = false
                        DeleteObject(axe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        ESX.ShowNotification(Strings['someone_close'])
                    end
                end
            end
        end
        Wait(250)
    end
end)

loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

addBlip = function(coords, sprite, colour, text)
    --local blip = AddBlipForCoord(coords)
    --SetBlipSprite(blip, 0)
    --SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end