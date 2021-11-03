--[[
	id: gXG9WiAVxY5_Fi7WZk-TU
	name: DEV
	description: DEV
	time1: 2021-07-02 18:40:04.339931+00
	time2: 2021-07-02 18:40:04.339932+00
	uploader: 9XgKdhjwFcpWXMYmR7Gf62vAMh86ZXOMHIFmFxaW
	uploadersession: g2tdBKrU_7EPA-WVFWE2lYG-OKtsz6
	flag: f
--]]

Utils = {}

Utils.CreateMissionBlip = function (coords, sprite, colour, text)
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipSprite(blip, sprite)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.1)
	SetBlipColour(blip, colour)
	SetBlipAsShortRange(blip, false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
	SetBlipRoute(blip, true) --Add the route to the blip
	return blip
end

Utils.CreateBlip = function (coords, sprite, colour, text, scale, shortRange, setRoute)
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipSprite(blip, sprite)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, scale or 1.0)
	SetBlipColour(blip, colour)
	SetBlipAsShortRange(blip, shortRange or false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
	SetBlipRoute(blip, setRoute or false)
	return blip
end

Utils.CreatePed = function (model, coords, scenario, networked)
	local hash = GetHashKey(model)
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(10)
	end

	while not HasCollisionForModelLoaded(hash) do
		Wait(0)
  end

	local ped =  CreatePed(4, hash, coords.x, coords.y, coords.z, coords.h, networked, false)

	while not HasCollisionLoadedAroundEntity(ped) do
		Wait(0)
  end

	local _, ground = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0)
	SetEntityCoords(ped, coords.x, coords.y, ground, 0, 0, 0, false)
	SetEntityHeading(ped, coords.h)

	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	TaskStartScenarioInPlace(ped, scenario, 0, true)
	return ped
end

Utils.copy = function (table)
	local copy = {}
	for k,v in pairs(table) do
		if type(v) ~= 'function' then
			copy[k] = v
		end
	end
	return copy
end

Utils.takeControlOfEntity = function(entity)
    while not NetworkHasControlOfEntity(entity) do
		NetworkRequestControlOfEntity(entity)
		Wait(50)
	end
end

Utils.deleteObjects = function(objects)
	for i = 1, #objects do
		Utils.takeControlOfEntity(objects[i])
        DeleteObject(objects[i])
	end
end

Utils.DistanceBetweenCoords = function(coordsA, coordsB)
	return #(vector3(coordsA.x, coordsA.y, coordsA.z).xy - vector3(coordsB.x, coordsB.y, coordsB.z).xy)
end
