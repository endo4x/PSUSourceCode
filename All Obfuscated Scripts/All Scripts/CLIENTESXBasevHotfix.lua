--[[
	id: zN0LBQ0oF2-m1i8zQFZSu
	name: [CLIENT] ESX Base v1 Hotfix 0.1 
	description: Hotfix for ESX Base v1 client-side
	time1: 2021-07-05 01:33:10.900533+00
	time2: 2021-07-05 01:33:10.900533+00
	uploader: Gdlq7NyYKvrvg0YCtr7YXY9IewXCotTZr15Em4O-
	uploadersession: DrSLcEihmrvTMjXxyHKWqR-mkuZWbo
	flag: f
--]]

AIRES = {}
AIRES.Functions = {}
AIRES.PlayerData = {}
AIRES.Shared = AIRESShared
AIRES.Config = AIRESConfig
AIRES.ServerCallbacks = {}

isLoggedIn = false

AIRES.Functions.GetPlayerData = function(cb)
    if cb ~= nil then
        cb(AIRES.PlayerData)
    else
        return AIRES.PlayerData
    end
end

function getAIRES()
    return AIRES
end

RegisterNetEvent('AIRES-base:getSharedObject')
AddEventHandler('AIRES-base:getSharedObject', function(cb)
    cb(getAIRES())
end)

RegisterNetEvent('AIRES-base:playerLoaded')
AddEventHandler('AIRES-base:playerLoaded', function()
    ShutdownLoadingScreenNui()
    isLoggedIn = true
end)

RegisterNetEvent('AIRES-base:playerUnloaded')
AddEventHandler('AIRES-base:playerUnloaded', function ()
    isLoggedIn = false
end)

RegisterNetEvent('AIRES-base:setPlayerData')
AddEventHandler('AIRES-base:setPlayerData', function(upval)
    AIRES.PlayerData = upval
end)

RegisterNetEvent('AIRES-base:useItem')
AddEventHandler('AIRES-base:useItem', function (item)
    TriggerServerEvent('AIRES-base:useItem', item)
end)

AIRES.Functions.GetPlayerData = function(cb)
    if cb ~= nil then
        cb(AIRES.PlayerData)
    else
        return AIRES.PlayerData
    end
end

RegisterNetEvent('AIRES:Client:TriggerCallback')
AddEventHandler('AIRES:Client:TriggerCallback', function(name, ...)
	if AIRES.ServerCallbacks[name] ~= nil then
		AIRES.ServerCallbacks[name](...)
		AIRES.ServerCallbacks[name] = nil
	end
end)

AIRES.GetPlayerData = function (cb)
    if cb ~= nil then
        cb(AIRES.PlayerData)
    else
        return AIRES.PlayerData
    end
end

AIRES.Functions.TriggerCallback = function(name, cb, ...)
	AIRES.ServerCallbacks[name] = cb
    TriggerServerEvent("AIRES:Server:TriggerCallback", name, ...)
end

AIRES.progressBar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    exports['mythic_progbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish ~= nil then
                onFinish()
            end
        else
            if onCancel ~= nil then
                onCancel()
            end
        end
    end)
end

AIRES.Functions.GetClosestVehicle = function(coords)
	local vehicles        = AIRES.Functions.GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle
end

AIRES.Functions.GetVehicles = function()
    local vehicles = {}
	for vehicle in AIRES.Functions.EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle) do
		table.insert(vehicles, vehicle)
	end
	return vehicles
end

AIRES.Functions.GetCoords = function(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        a = heading
    }
end

AIRES.Functions.SpawnVehicle = function(model, cb, coords, isnetworked)
    local model = (type(model)=="number" and model or GetHashKey(model))
    local coords = coords ~= nil and coords or AIRES.Functions.GetCoords(GetPlayerPed(-1))
    local isnetworked = isnetworked ~= nil and isnetworked or true

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end

    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.a, isnetworked, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)

	SetVehicleHasBeenOwnedByPlayer(vehicle,  true)
	SetNetworkIdCanMigrate(netid, true)
    --SetEntityAsMissionEntity(veh, true, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, "OFF")

    SetModelAsNoLongerNeeded(model)

    if cb ~= nil then
        cb(veh)
    end
end

AIRES.Functions.DeleteVehicle = function(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
end

AIRES.Functions.Progressbar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    exports['mythic_progbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish ~= nil then
                onFinish()
            end
        else
            if onCancel ~= nil then
                onCancel()
            end
        end
    end)
end

AIRES.DrawText3D = function(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) 
    SetTextScale(scale, scale) 
    SetTextFont(4) 
    SetTextProportional(1) 
    SetTextEntry("STRING") 
    SetTextCentre(true) 
    SetTextColour(255, 255, 255, 215) 
    AddTextComponentString(text) 
    DrawText(_x, _y) 
end

RegisterNetEvent('AIRES:Notify')
AddEventHandler('AIRES:Notify', function(text, type, length)
	exports['mythic_notify']:DoCustomHudText(type, text, length)
end)

AIRES.Functions.Notify = function(text, textype, length) 
    exports['mythic_notify']:DoCustomHudText(type, text, length)
end

AIRES.Functions.GetClosestPed = function(coords, ignoreList)
	local ignoreList      = ignoreList or {}
	local peds            = AIRES.Functions.GetPeds(ignoreList)
	local closestDistance = -1
    local closestPed      = -1
    
    if coords == nil then
        coords = GetEntityCoords(GetPlayerPed(-1))
    end

	for i=1, #peds, 1 do
		local pedCoords = GetEntityCoords(peds[i])
		local distance  = GetDistanceBetweenCoords(pedCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestPed      = peds[i]
			closestDistance = distance
		end
	end

	return closestPed, closestDistance
end

AIRES.Functions.GetPeds = function(ignoreList)
    local ignoreList = ignoreList or {}
	local peds       = {}
	for ped in AIRES.Functions.EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed) do
		local found = false

        for j=1, #ignoreList, 1 do
			if ignoreList[j] == ped then
				found = true
			end
		end

		if not found then
			table.insert(peds, ped)
		end
	end

	return peds
end

AIRES.Functions.EnumerateEntities = function(initFunc, moveFunc, disposeFunc)
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