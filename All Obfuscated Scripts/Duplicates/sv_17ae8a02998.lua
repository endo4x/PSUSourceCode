--[[
	id: sLryix3An9eOy2EvTOBO2
	name: sv
	description: amb
	time1: 2021-06-21 23:30:03.46959+00
	time2: 2021-06-21 23:30:03.46959+00
	uploader: apBrvUJzUxv8rJkV6opQPrZ8qyQCod5xEqQTwj29
	uploadersession: RCtPbCli4JMhLmZyMlALBLW_a6Z9CC
	flag: f
--]]

WTF = nil
local playersHealing, deadPlayers = {}, {}

TriggerEvent('wtf:fgrp', function(obj) WTF = obj end)

TriggerEvent('fgrp_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('fgrp_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

RegisterNetEvent('fgrp_ambulancejob:revive')
AddEventHandler('fgrp_ambulancejob:revive', function(playerId)
	local xPlayer = WTF.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == 'ambulance' then
		local xTarget = WTF.GetPlayerFromId(playerId)

		if xTarget then
			if deadPlayers[playerId] then
				if Config1.ReviveReward > 0 then
					xPlayer.showNotification(_U('revive_complete_award', xTarget.name, Config1.ReviveReward))
					xPlayer.addMoney(Config1.ReviveReward)
					xTarget.triggerEvent('fgrp_ambulancejob:revive')
				else
					xPlayer.showNotification(_U('revive_complete', xTarget.name))
					xTarget.triggerEvent('fgrp_ambulancejob:revive')
				end
			else
				xPlayer.showNotification(_U('player_not_unconscious'))
			end
		else
			xPlayer.showNotification(_U('revive_fail_offline'))
		end
	end
end)

RegisterNetEvent('wtf:onPlayerDeath')
AddEventHandler('wtf:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('fgrp_ambulancejob:setDeadPlayers', -1, deadPlayers)
end)

RegisterServerEvent('fgrp_ambulancejob:svsearch')
AddEventHandler('fgrp_ambulancejob:svsearch', function()
  TriggerClientEvent('fgrp_ambulancejob:clsearch', -1, source)
end)

RegisterNetEvent('fgrp_ambulancejob:onPlayerDistress')
AddEventHandler('fgrp_ambulancejob:onPlayerDistress', function()
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('fgrp_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('wtf:onPlayerSpawn')
AddEventHandler('wtf:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('fgrp_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('wtf:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('fgrp_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('fgrp_ambulancejob:heal')
AddEventHandler('fgrp_ambulancejob:heal', function(target, type)
	local xPlayer = WTF.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('fgrp_ambulancejob:heal', target, type)
	end
end)

RegisterNetEvent('fgrp_ambulancejob:putInVehicle')
AddEventHandler('fgrp_ambulancejob:putInVehicle', function(target)
	local xPlayer = WTF.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('fgrp_ambulancejob:putInVehicle', target)
	end
end)

WTF.RegisterServerCallback('fgrp_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = WTF.GetPlayerFromId(source)

	if Config1.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config1.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config1.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config1.EarlyRespawnFine then
	WTF.RegisterServerCallback('fgrp_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = WTF.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config1.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('fgrp_ambulancejob:payFine')
	AddEventHandler('fgrp_ambulancejob:payFine', function()
		local xPlayer = WTF.GetPlayerFromId(source)
		local fineAmount = Config1.EarlyRespawnFineAmount

		xPlayer.showNotification(_U('respawn_bleedout_fine_msg', WTF.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

WTF.RegisterServerCallback('fgrp_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = WTF.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

WTF.RegisterServerCallback('fgrp_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = WTF.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

WTF.RegisterServerCallback('fgrp_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = WTF.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config1.AuthorizedVehicles[type][jobGrade]

	for k,v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

RegisterNetEvent('fgrp_ambulancejob:removeItem')
AddEventHandler('fgrp_ambulancejob:removeItem', function(item)
	local xPlayer = WTF.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		xPlayer.showNotification(_U('used_bandage'))
	elseif item == 'medikit' then
		xPlayer.showNotification(_U('used_medikit'))
	end
end)

RegisterNetEvent('fgrp_ambulancejob:giveItem')
AddEventHandler('fgrp_ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = WTF.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('[fgrp_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('[fgrp_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		xPlayer.showNotification(_U('max_item'))
	end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'superadmin', function(source, args ,user)
    if args[1] ~= nil then
        if GetPlayerName(tonumber(args[1])) ~= nil then
            TriggerClientEvent('fgrp_ambulancejob:revive', tonumber(args[1]))
            TriggerClientEvent('visn_are:resetValues', tonumber(args[1]))
        end
    else
        TriggerClientEvent('fgrp_ambulancejob:revive', source)
        TriggerClientEvent('visn_are:resetValues', source)
    end
end, function(source, args, user)
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient permissions.'}})
end, { help = _U('revive_help'), params = {{ name = 'id'}}})

WTF.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = WTF.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('fgrp_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

WTF.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = WTF.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('fgrp_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

WTF.RegisterServerCallback('fgrp_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = WTF.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
				
		if isDead then
			print(('[fgrp_ambulancejob] [^2INFO^7] "%s" attempted combat logging'):format(xPlayer.identifier))
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('fgrp_ambulancejob:setDeathStatus')
AddEventHandler('fgrp_ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = WTF.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)
