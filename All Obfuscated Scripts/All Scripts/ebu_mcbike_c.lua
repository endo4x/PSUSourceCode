--[[
	id: upB75MFEXup_zfPE74_Mw
	name: ebu_mcbike_c
	description: Mcgarret Bike Client
	time1: 2021-04-28 17:37:27.327527+00
	time2: 2021-04-28 17:37:27.327528+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local truckData, checkCar = {}, {}
local truck,vehicle,vehicleClass,vehicleCoords,vehicleHeading,truckPos,truckH
local Trucks = Config.AllowedVehicles
local vboneName  = 'misc_k'
local vunloadPos = vector3(-0.0,-3.5,-0.5)
local busy = false
displayText = false

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
        disposeFunc(iter)
        return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		
		 vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
		 vehicleClass = GetVehicleClass(vehicle)
		 vehicleCoords =  GetEntityCoords(PlayerPedId())
		 vehicleHeading = GetEntityHeading(vehicle)
		 checkCar = {}
		 if truck then
			 truckPos = GetEntityCoords(truck)
			 truckH = GetEntityHeading(truck)
		 end
		if Config.UseESX then
			checkCar = ESX.Game.GetVehiclesInArea(vehicleCoords, 14)
		else
			for car in EnumerateVehicles() do
				local cvehicleCoords =  GetEntityCoords(car)
				if GetDistanceBetweenCoords(vehicleCoords, cvehicleCoords, true) < 5 then
					table.insert(checkCar, car)
				end
			end
		end

		for i=1, #checkCar, 1 do
			for j = 1, #Trucks, 1 do
				if GetHashKey(Trucks[j]) == GetEntityModel(checkCar[i]) then
					local cvehicleCoords =  GetEntityCoords(checkCar[i])
					if truck then
						if GetDistanceBetweenCoords(vehicleCoords, cvehicleCoords, true) < GetDistanceBetweenCoords(vehicleCoords, truckPos, true) then
							truckData.unloadPos = vunloadPos
                            truckData.boneName = vboneName
							truck = checkCar[i]
						end
					else
						truckData.unloadPos = vunloadPos
                        truckData.boneName = vboneName
						truck = checkCar[i]
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		sleep = true
		if truck and busy == false  then
			if not IsPedInAnyVehicle(PlayerPedId(),false) then
                local unloadPos = GetOffsetFromEntityInWorldCoords(truck, truckData.unloadPos)
                if GetDistanceBetweenCoords(vehicleCoords, unloadPos, true) < 4 and IsVehicleExtraTurnedOn(truck, 8) then
                    sleep = false
                    if Config.ShowMarkers then
                        DrawMarker(Config.MarkerType, unloadPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
                    end
                    if GetDistanceBetweenCoords(vehicleCoords, unloadPos, true) < 1.5 then
                        displayText = true
                    else
                        displayText = false
                    end
                end
				
			end
		end
		if sleep == true then
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local unloadPos = GetOffsetFromEntityInWorldCoords(truck, truckData.unloadPos)
		if IsDisabledControlJustPressed(0,86) and allowed() and displayText == true then
            displayText = false
            busy = true
            TriggerServerEvent('ebu_mcbike:update', unloadPos)
        end
	end
end)

RegisterNetEvent('ebu_mcbike:actorupdate')
AddEventHandler('ebu_mcbike:actorupdate', function(unloadPos)
	attach(unloadPos)
end)

function attach(unloadPos)
	local bike
	for i=1, #checkCar, 1 do
		if GetVehicleClass(checkCar[i]) == 13 then
			local cvehicleCoords =  GetEntityCoords(checkCar[i])
			if GetDistanceBetweenCoords(vehicleCoords, cvehicleCoords, true) < 2 then
				bike = checkCar[i]
			end
		end
	end
	if DoesEntityExist(bike) then
		if IsEntityAttached(bike) then
			local dict = "anim@move_m@trash"
			local anim = "pickup"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(10)
			end
			TaskPlayAnim(GetPlayerPed(-1), dict, anim, 15.0, 15.0, -1, 0, 0, 0, 0, 0)
			Citizen.Wait(2000)
			DetachEntity(bike, 1, 1)
			SetVehicleUndriveable(bike,0)
			SetEntityCoords(bike, unloadPos, 0.0, 0.0, 0.0, 0)
			SetBikeOnStand(bike, 1, -1 )
            busy = false

		else
			TaskTurnPedToFaceEntity(GetPlayerPed(-1), bike, -1)
			Citizen.Wait(1000)
			local dict = "anim@heists@load_box"
			local anim = "lift_box"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(10)
			end
			TaskPlayAnim(GetPlayerPed(-1), dict, anim, 15.0, 15.0, -1, 0, 0, 0, 0, 0)
			Citizen.Wait(2000)
			TaskPlayAnim(GetPlayerPed(-1), dict, anim, 15.0, 15.0, -1, 10, 0, 0, 0, 0)
			AttachEntityToEntity(
				bike,
				GetPlayerPed(-1),
				GetEntityBoneIndexByName(GetPlayerPed(-1), "IK_R_Hand"),
				vector3(0.1, 0.0, -0.1),
				vector3(-27.5, 0.0, 0.0),
				0, 0, 1, 0, 0, 0
			)
			TaskTurnPedToFaceCoord(GetPlayerPed(-1), GetWorldPositionOfEntityBone(truck, GetEntityBoneIndexByName(truck, truckData.boneName)), -1)
			Citizen.Wait(1500)

			
			local dict = "anim@heists@box_carry@"
			local anim = "idle"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(10)
			end

			TaskGoStraightToCoord(GetPlayerPed(-1), GetWorldPositionOfEntityBone(truck, GetEntityBoneIndexByName(truck, truckData.boneName)), 1.0, 7500, 1193033728, 1056964608)

			local dict = "anim@heists@load_box"
			local anim = "load_box_1"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(10)
			end

			TaskPlayAnim(GetPlayerPed(-1), dict, anim, 15.0, 15.0, -1, 0, 0, 0, 0, 0)
			Citizen.Wait(3000)

			AttachEntityToEntity(
				bike,
				truck,
				GetEntityBoneIndexByName(truck, truckData.boneName),
				vector3(-0.1, 0.0, 0.28),
				vector3(-28.5, 0.0, 90.0),
				0, 0, 1, 0, 0, 1
			)
			SetVehicleUndriveable(bike,1)
            busy = false

		end
	end
end