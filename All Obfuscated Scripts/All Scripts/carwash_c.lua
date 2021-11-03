--[[
	id: Om8BSlSLxAh4lO2aJCh1m
	name: carwash_c
	description: PIXEL FRAMEWORK
	time1: 2021-06-04 10:54:11.176412+00
	time2: 2021-06-04 10:54:11.176412+00
	uploader: tiKc3ysC5ZC9eL7S7qRlI25_fk_pbZrCtwIHU795
	uploadersession: 9Z4OTJ-XlplT1dxyQ3lOpJNw1gHg2O
	flag: f
--]]

PIXELCore = nil

Citizen.CreateThread(function()
    while PIXELCore == nil do
        TriggerEvent('PIXELCore:GetObject', function(obj) PIXELCore = obj end)
        Citizen.Wait(0)
    end
end)

local washingVehicle = false

RegisterNetEvent('pixel-target:client:washCar')
AddEventHandler('pixel-target:client:washCar', function()
    local PlayerPed = PlayerPedId()
    local PlayerPos = GetEntityCoords(PlayerPed)
    local PedVehicle = GetVehiclePedIsIn(PlayerPed)
    local Driver = GetPedInVehicleSeat(PedVehicle, -1)

    if IsPedInAnyVehicle(PlayerPed) then
        if Driver == PlayerPed then
            if not washingVehicle then
                TriggerServerEvent('pixel-autopesu:server:washCar')
            end
        end
    end
end)

RegisterNetEvent('pixel-autopesu:client:washCar')
AddEventHandler('pixel-autopesu:client:washCar', function()
    local PlayerPed = PlayerPedId()
    local PedVehicle = GetVehiclePedIsIn(PlayerPed)
    local Driver = GetPedInVehicleSeat(PedVehicle, -1)

    washingVehicle = true

    PIXELCore.Functions.Progressbar("search_cabin", "Pestään autoa..", math.random(4000, 8000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetVehicleDirtLevel(PedVehicle)
        SetVehicleUndriveable(PedVehicle, false)
        WashDecalsFromVehicle(PedVehicle, 1.0)
        washingVehicle = false
    end, function() -- Cancel
        PIXELCore.Functions.Notify("Toiminto Peruuntui!", "error")
        washingVehicle = false
    end)
end)