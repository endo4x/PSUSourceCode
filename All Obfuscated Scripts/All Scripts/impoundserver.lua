--[[
	id: _fkSyRzoJpT3jQY_S6Ge0
	name: impoundserver
	description: impoundserver
	time1: 2021-07-20 18:00:42.519684+00
	time2: 2021-07-20 18:00:42.519684+00
	uploader: 0leAz68-e4gSPU14oZJalCmBKAwiAZxO6Ivk8kbd
	uploadersession: RhendJUyQoj6l6fkq_oKH9udVSD6Wt
	flag: f
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('cl_impound:loadVehicles', function(source, cb)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND stored = 0', {['@owner'] = x.identifier}, function(vehicles)
		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('cl_impound:loadVehicle', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(vehicle)
		cb(vehicle)
	end)
end)

ESX.RegisterServerCallback('cl_impound:isOwned', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate AND owner = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(vehicle)
		if next(vehicle) then
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterNetEvent('cl_impound:changeState')
AddEventHandler('cl_impound:changeState', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles SET stored=@state WHERE plate=@plate", {['@state'] = state, ['@plate'] = plate})
end)

RegisterNetEvent('cl_impound:saveProps')
AddEventHandler('cl_impound:saveProps', function(plate, props)
	local xProps = json.encode(props)
	MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@props WHERE plate=@plate", {['@plate'] = plate, ['@props'] = xProps})
end)