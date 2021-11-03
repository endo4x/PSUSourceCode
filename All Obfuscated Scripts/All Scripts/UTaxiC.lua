--[[
	id: okRXZ3_YDcGr28oh_oJuB
	name: UTaxi C
	description: UTaxi Client
	time1: 2021-05-19 23:15:04.386764+00
	time2: 2021-05-19 23:15:04.386765+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local vehicle, playerPed, inveh
local vData = {}
local sirenOn = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = PlayerPedId()
        inveh = IsPedInAnyVehicle(playerPed,false)
		vehicle = GetVehiclePedIsIn(playerPed,false)
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
        local sleep = true
        if inveh and IsVehicleSirenOn(vehicle) and sirenOn == false and GetEntityModel(vehicle) == GethashKey(Config.model) then
			SetVehicleExtra(vehicle, 3, 1)
			TriggerServerEvent('ebu_utaxi:update', 3, vehicle)
			sirenOn = true
		elseif not IsVehicleSirenOn(vehicle) and sirenOn == true and GetEntityModel(vehicle) == GethashKey(Config.model) then
			SetVehicleExtra(vehicle, 3, 1)
			sirenOn = false
        end
    end
end)

function theebuTEN(srcveh,num)
    NetworkRequestControlOfEntity(srcveh)
   
    local tires = {}
    local bHealth = GetVehicleBodyHealth(srcveh)
    local eHealth = GetVehicleEngineHealth(srcveh)
    local fHealth = GetVehiclePetrolTankHealth(srcveh)
    for i = 1, 50, 1 do
        if IsVehicleTyreBurst(srcveh, i, 1) then
            tires[i] = 1000
        elseif IsVehicleTyreBurst(srcveh, i, 0) then
            tires[i] = 100
        else
            tires[i] = 0
        end
    end
    
    TriggerServerEvent('ebu_utaxi:eOn', srcveh, bHealth, eHealth, fHealth, tires, num)
        
end

RegisterNetEvent('ebu_utaxi:eOn')
AddEventHandler('ebu_utaxi:eOn', function(srcveh, bHealth, eHealth, fHealth, tires, num)
    SetVehicleExtra(srcveh, num, 0)
    Citizen.Wait(200)

	SetVehicleFixed(srcveh)
    SetVehicleDeformationFixed(srcveh)
    
    Citizen.Wait(200)
    SetVehicleExtra(srcveh, num, 0)
    SetVehicleBodyHealth(srcveh, bHealth)
    SetVehicleEngineHealth(srcveh, eHealth)
    SetVehiclePetrolTankHealth(srcveh, fHealth)
    for i = 1, #tires, 1 do
        if tires[i] > 0 then
            SetVehicleTyreBurst(srcveh, i, 0, tires[i]+0.0)
        end
    end
end)

RegisterNetEvent('ebu_utaxi:update')
AddEventHandler('ebu_utaxi:update', function(num, srcvehicle)
	theebuTEN(srcvehicle, num)
end)
