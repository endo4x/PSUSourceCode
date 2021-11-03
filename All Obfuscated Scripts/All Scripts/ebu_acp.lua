--[[
	id: mGchPK-oxH77gBhMoamGD
	name: ebu_a3c3p
	description: Abrupt Enforcement Toggler
	time1: 2021-04-25 13:44:31.850171+00
	time2: 2021-04-25 13:44:31.850171+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

local Vehicles = {'pursuit18fpis'}

local vehicle, playerPed, inveh
local vData = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = PlayerPedId()
        inveh = IsPedInAnyVehicle(playerPed,false)
		if inveh  then
			for k,v in pairs(Vehicles) do
				if GetHashKey(v) == GetEntityModel(GetVehiclePedIsIn(playerPed, false)) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
					vehicle = GetVehiclePedIsIn(playerPed, false)
				end
			end
		end
	end
end)

for i = 1, 5, 1 do
	RegisterCommand('+bfdb32452'..i, function()
		if inveh and vehicle  and IsVehicleSirenOn(vehicle) then
			if IsVehicleExtraTurnedOn(vehicle, i) then
				SetVehicleExtra(vehicle, i, 1)
				PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
			else
				TriggerServerEvent('ebu_aec3p:update', i, vehicle)
				PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
			end
		end
	end, false)
	RegisterCommand('-bfdb32452'..i, function()
	end)
end

RegisterCommand('+bfdb324529', function()
	if inveh and vehicle  and IsVehicleSirenOn(vehicle) then
		for i = 1, 5, 1 do
			SetVehicleExtra(vehicle, i, 1)
		end
		PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
	end
end, false)
RegisterCommand('-bfdb324529', function()
end)

function theebuTEN(srcveh,num)
    NetworkRequestControlOfEntity(srcveh)
   
    local tires = {}
    local bHealth = GetVehicleBodyHealth(srcveh)
    local eHealth = GetVehicleEngineHealth(srcveh)
    local fHealth = GetVehiclePetrolTankHealth(srcveh)
    for i = 1, GetVehicleNumberOfWheels(srcveh), 1 do
        if IsVehicleTyreBurst(srcveh, i, 1) then
            tires[i] = 1000
        elseif IsVehicleTyreBurst(srcveh, i, 0) then
            tires[i] = 100
        else
            tires[i] = 0
        end
    end
    TriggerServerEvent('ebu_aec3p:eOn', srcveh, bHealth, eHealth, fHealth, tires, num)
        
end

RegisterNetEvent('ebu_aec3p:eOn')
AddEventHandler('ebu_aec3p:eOn', function(srcveh, bHealth, eHealth, fHealth, tires, num)
    SetVehicleExtra(srcveh, num, 0)
    Citizen.Wait(100)

	SetVehicleFixed(srcveh)
    SetVehicleDeformationFixed(srcveh)
    
    Citizen.Wait(100)
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

RegisterNetEvent('ebu_aec3p:update')
AddEventHandler('ebu_aec3p:update', function(num, srcvehicle)
	theebuTEN(srcvehicle, num)
end)

RegisterKeyMapping('+bfdb324521', 'Front Modules', 'keyboard', '1')
RegisterKeyMapping('+bfdb324522', 'Rear Modules', 'keyboard', '2')
RegisterKeyMapping('+bfdb324523', 'Corner Modules', 'keyboard', '3')
RegisterKeyMapping('+bfdb324524', 'White Secondary Modules', 'keyboard', '4')
RegisterKeyMapping('+bfdb324525', 'Amber Rear Modules', 'keyboard', '5')
RegisterKeyMapping('+bfdb324529', 'All Modules Off', 'keyboard', '9')