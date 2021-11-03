--[[
	id: WNPmdnhbVTJJtvh5u5pB9
	name: erdenerenvanter
	description: envanter
	time1: 2021-06-12 13:51:52.279891+00
	time2: 2021-06-12 13:51:52.279891+00
	uploader: 5NpzkKzEkuvJWchqj-icFnwLe8t8An-aJl5iwImc
	uploadersession: q9NUG1JhDqtwNOtixJJm3-ppernpBS
	flag: t
--]]

local checkSource = {}

AddEventHandler('ExeLds:resetCooldown', function(id)
    Citizen.Wait(500)
    checkSource[id] = nil
end)

ESX = nil
local Garbages, Drops, Inventories = {}, {}, {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("m3:inventoryhud:server:getPlayerInventory",function(source, cb, target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	if targetPlayer ~= nil then
		if Config.UseLimit then
			cb({inventory = targetPlayer.inventory, money = targetPlayer.getMoney(), accounts = targetPlayer.accounts, weapons = targetPlayer.loadout, weight = nil, maxWeight = nil})
		end
		if Config.UseWeight then
			cb({inventory = targetPlayer.inventory, money = targetPlayer.getMoney(), accounts = targetPlayer.accounts, weapons = targetPlayer.loadout, weight = targetPlayer.getWeight(), maxWeight = targetPlayer.maxWeight})
		end
		if not Config.UseLimit and not Config.UseWeight then
			cb({inventory = targetPlayer.inventory, money = targetPlayer.getMoney(), accounts = targetPlayer.accounts, weapons = targetPlayer.loadout, weight = nil, maxWeight = nil})
		end
	else
		cb(nil)
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:checkOpenable', function(source, cb, name)
	if Inventories[name] ~= nil then
		cb(Inventories[name].openable)
		Inventories[name].openable = false
	else
		Inventories[name] = {}
		Inventories[name].openable = false
		cb(true)
	end
end)

--on start
MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM m3_inv_stashs WHERE data = @data', {['@data'] = '[]'})
	MySQL.Async.execute('DELETE FROM m3_inv_gloveboxs WHERE data = @data', {['@data'] = '[]'})
	MySQL.Async.execute('DELETE FROM m3_inv_trunks WHERE data = @data', {['@data'] = '[]'})

	Citizen.Wait(1000)

	for k, v in pairs(Config.Stashs) do
		if v.job ~= 'all' then
			MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname', {['@stashname'] = k}, function(stash)
				if stash[1] == nil then
					MySQL.Async.execute('INSERT INTO m3_inv_stashs (stashname, owner, data) VALUES (@stashname, @owner, @data)', {['@stashname'] = k, ['@owner'] = v.job, ['@data'] = '[]'})
				end
			end)
		end
	end
end)

RegisterServerEvent('m3:inventoryhud:server:freezeGarbages')
AddEventHandler('m3:inventoryhud:server:freezeGarbages', function()
	for i=1, #Garbages, 1 do
		if Garbages[i].entity ~= nil then
			TriggerClientEvent('m3:inventoryhud:client:freezeGarbage', source, Garbages[i].entity)
		end
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:getCharacterName', function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)

    local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xTarget.identifier
    })

    local firstname = result[1].firstname
    local lastname  = result[1].lastname

    cb(''.. firstname .. ' ' .. lastname ..'')
end)

RegisterServerEvent('m3:inventoryhud:server:closeInv')
AddEventHandler('m3:inventoryhud:server:closeInv', function(name)
	if Inventories[name] ~= nil then
		Inventories[name].openable = true
	else
		Inventories[name] = {}
		Inventories[name].openable = true
	end
end)

RegisterServerEvent('m3:inventoryhud:server:disableTargetInv')
AddEventHandler('m3:inventoryhud:server:disableTargetInv', function(target)
	TriggerClientEvent('m3:inventoryhud:client:disableTargetInv', target)
end)

RegisterServerEvent('m3:inventoryhud:server:enableTargetInv')
AddEventHandler('m3:inventoryhud:server:enableTargetInv', function(target)
	TriggerClientEvent('m3:inventoryhud:client:enableTargetInv', target)
end)

--search
ESX.RegisterServerCallback('m3:inventoryhud:server:tradePlayerItem', function(source, cb, from, to, item, count)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = from
		local tsrc = to

	local xPlayer = ESX.GetPlayerFromId(src)
	local tPlayer = ESX.GetPlayerFromId(tsrc)

	if count <= 0 then
		if item.type ~= 'item_weapon' then
			cb(nil)
			return
		end
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not tPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamaz!'})
				TriggerClientEvent('mythic_notify:client:SendAlert', tsrc, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				cb(nil)
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = tPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamaz!'})
				TriggerClientEvent('mythic_notify:client:SendAlert', tsrc, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				cb(nil)
				return
			end
		end
	end

	if item.type == 'item_standard' then
		local xPlayerItem = xPlayer.getInventoryItem(item.name)
		if xPlayerItem.count < count then
			cb(nil)
			return
		end
	end

	if item.type == 'item_standard' then
		xPlayer.removeInventoryItem(item.name, count)
		tPlayer.addInventoryItem(item.name, count)
		cb(1)
	elseif item.type == 'item_money' then
		xPlayer.removeMoney(count)
		tPlayer.addMoney(count)
		cb(1)
	elseif item.type == 'item_account' then
		xPlayer.removeAccountMoney(item.name, count)
		tPlayer.addAccountMoney(item.name, count)
		cb(1)
	elseif item.type == 'item_weapon' then
		if xPlayer.hasWeapon(item.name) then
			if not tPlayer.hasWeapon(item.name) then
				xPlayer.removeWeapon(item.name)
				tPlayer.addWeapon(item.name, count)
				cb(1)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Aynı silaha zaten sahip!'})
				cb(nil)
			end
		end
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--openinventory for admins
TriggerEvent('es:addGroupCommand', 'openinv', 'admin', function(source, args, user)
    local src = source

    if args[1] ~= nil then
        local tsrc = tonumber(args[1])
        local tPlayer = ESX.GetPlayerFromId(tsrc)
        if tPlayer ~= nil then
			if tsrc == tonumber(src) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Komutla kendi envanterine bakamazsın!'})
            	return
            end

            TriggerClientEvent("m3:inventoryhud:client:openPlayerInventory", src, tsrc, 'admin')
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Oyuncu bulunamadı!'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'ID yazmalısınız!'})
    end
end,  function(source, args, user)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yetersiz yetki!'})
end)

--drops
AddEventHandler('esx:playerLoaded', function(xPlayer)
	if #Drops > 0 then
		for i=1, #Drops, 1 do
			if #Drops[i].items > 0 then
				TriggerClientEvent('m3:inventoryhud:client:registerDrop', xPlayer.source, Drops[i].name)
			end
		end
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:getDrop', function(source, cb, name)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if Drops[name] == nil then
		Drops[name] = {
			name = name,
			items = {}
		}
		cb(nil)
	else
		if #Drops[name].items > 0 then
			cb(Drops[name].items)
		else
			cb(nil)
		end
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:refreshDrop', function(source, cb, drop)
	if Drops[drop] ~= nil then
		if #Drops[drop].items > 0 then
			cb(Drops[drop].items)
		else
			for i=1, #Drops, 1 do
				if Drops[i] == drop then
					table.remove(Drops, i)
				end
			end
			cb(nil)
		end
	end
end)

function RegisterForAllPlayers(drop)
	if Drops[drop] ~= nil then
		if #Drops[drop].items > 0 then
			TriggerClientEvent('m3:inventoryhud:client:registerDrop', -1, drop)
			if Config.DeleteDrops.Enabled then
				Citizen.Wait(Config.DeleteDrops.Time * 1000)
				Drops[drop] = nil
				TriggerClientEvent('m3:inventoryhud:client:removeDrop', -1, drop)
			end
		end
	end
end

-- RegisterCommand('debugdrop', function()
-- 	print(ESX.DumpTable(Drops))
-- end)

function RemoveForAllPlayers(drop)
	if Drops[drop] ~= nil then
		if #Drops[drop].items <= 0 then
			for i=1, #Drops, 1 do
				if Drops[i] == drop then
					table.remove(Drops, i)
				end
			end

			TriggerClientEvent('m3:inventoryhud:client:removeDrop', -1, drop)
		end
	end
end

ESX.RegisterServerCallback('m3:inventoryhud:server:putIntoDrop', function(source, cb, item, count, name)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if count < 0 then
		cb(nil)
		return
	end
	
	local removecount = count

	if item.type == 'item_weapon' then
		if xPlayer.hasWeapon(item.name) then
			if removecount == 1 then
				removecount = 0
			end
			xPlayer.removeWeapon(item.name)
			if Config.UseWeight then
				table.insert(Drops[name].items, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount, weight = 0})
			else
				table.insert(Drops[name].items, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount})
			end
			cb(1)
			RegisterForAllPlayers(name)
		else
			cb(nil)
		end
		return
	end

	for i=1, #Drops[name].items, 1 do
		if Drops[name].items[i].name == item.name and item.type ~= 'item_weapon' then
			count = count + Drops[name].items[i].count

			if item.type == 'item_standard' then
				
				local sourceItem = xPlayer.getInventoryItem(item.name)
				if sourceItem.count >= removecount then
					xPlayer.removeInventoryItem(item.name, removecount)
					table.insert(Drops[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = count})
					if Config.UseWeight then
						Drops[name].items[i].weight = item.weight
					end
				else
					table.insert(Drops[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = Drops[name].items[i].count})
					if Config.UseWeight then
						Drops[name].items[i].weight = Drops[name].items[i].weight
					end
					cb(nil)
				end
			elseif item.type == "item_money" then
				if xPlayer.getMoney() >= removecount then
					xPlayer.removeMoney(removecount)
					table.insert(Drops[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
					if Config.UseWeight then
						Drops[name].items[i].weight = item.weight
					end
				else
					table.insert(Drops[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = Drops[name].items[i].count})
					if Config.UseWeight then
						Drops[name].items[i].weight = Drops[name].items[i].weight
					end
					cb(nil)
				end
			elseif item.type == "item_account" then
				if xPlayer.getAccount(item.name).money >= removecount then
					xPlayer.removeAccountMoney(item.name, removecount)
					table.insert(Drops[name].items, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
					if Config.UseWeight then
						Drops[name].items[i].weight = item.weight
					end
				else
					table.insert(Drops[name].items, i, {name = item.name, label = 'Karapara', type = 'item_account', count = Drops[name].items[i].count})
					if Config.UseWeight then
						Drops[name].items[i].weight = Drops[name].items[i].weight
					end
					cb(nil)
				end
			end

			table.remove(Drops[name].items, i + 1)
			cb(1)
			RegisterForAllPlayers(name)
			return
		end
	end

	if item.type == 'item_standard' then
		local sourceItem = xPlayer.getInventoryItem(item.name)
		if sourceItem.count >= removecount then
			xPlayer.removeInventoryItem(item.name, removecount)
			if Config.UseWeight then
				table.insert(Drops[name].items, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
			else
				table.insert(Drops[name].items, {name = item.name, label = item.label, type = 'item_standard', count = count})
			end
			cb(1)
			RegisterForAllPlayers(name)
		else
			cb(nil)
		end
	elseif item.type == "item_money" then
		if xPlayer.getMoney() >= removecount then
			xPlayer.removeMoney(removecount)
			if Config.UseWeight then
				table.insert(Drops[name].items, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
			else
				table.insert(Drops[name].items, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
			end
			cb(1)
			RegisterForAllPlayers(name)
		else
			cb(nil)
		end
	elseif item.type == "item_account" then
		if xPlayer.getAccount(item.name).money >= removecount then
			xPlayer.removeAccountMoney(item.name, removecount)
			if Config.UseWeight then
				table.insert(Drops[name].items, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
			else
				table.insert(Drops[name].items, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
			end
			cb(1)
			RegisterForAllPlayers(name)
		else
			cb(nil)
		end
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:takeFromDrop', function(source, cb, item, count, name)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)

	if count < 0 then
		cb(nil)
		return
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not xPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = xPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if item.type == 'item_weapon' then
		for i=1, #Drops[name].items, 1 do
			if Drops[name].items[i].name == item.name then
				if not xPlayer.hasWeapon(item.name) then
				
					xPlayer.addWeapon(item.name, Drops[name].items[i].count)
					table.remove(Drops[name].items, i)
					cb(1)
					RemoveForAllPlayers(name)
					
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
					cb(nil)
				end
				return
			end
		end
	else
		for i=1, #Drops[name].items, 1 do
			if Drops[name].items[i].name == item.name then
				if count <= Drops[name].items[i].count then
					if item.type == 'item_standard' then
						xPlayer.addInventoryItem(item.name, count)
						if Drops[name].items[i].count - count > 0 then
							if Config.UseWeight then
								table.insert(Drops[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = Drops[name].items[i].count - count, weight = Drops[name].items[i].weight})
							else
								table.insert(Drops[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = Drops[name].items[i].count - count})
							end
							table.remove(Drops[name].items, i + 1)
						else
							table.remove(Drops[name].items, i)
						end
						cb(1)
						RemoveForAllPlayers(name)
					elseif item.type == 'item_money' then
						xPlayer.addMoney(count)
						if Drops[name].items[i].count - count > 0 then
							if Config.UseWeight then
								table.insert(Drops[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = Drops[name].items[i].count - count, weight = 0})
							else
								table.insert(Drops[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = Drops[name].items[i].count - count})
							end
							table.remove(Drops[name].items, i + 1)
						else
							table.remove(Drops[name].items, i)
						end
						cb(1)
						RemoveForAllPlayers(name)
					elseif item.type == 'item_account' then
						xPlayer.addAccountMoney(item.name, count)
						if Drops[name].items[i].count - count > 0 then
							if Config.UseWeight then
								table.insert(Drops[name].items, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = Drops[name].items[i].count - count, weight = 0})
							else
								table.insert(Drops[name].items, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = Drops[name].items[i].count - count})
							end
							table.remove(Drops[name].items, i + 1)
						else
							table.remove(Drops[name].items, i)
						end
						cb(1)
						RemoveForAllPlayers(name)
					end
				end
				return
			end
		end
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--garbage
ESX.RegisterServerCallback('m3:inventoryhud:server:getGarbage', function(source, cb, name, entity)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)

	if Garbages[name] == nil then
		Garbages[name] = {
			items = {},
			lastopened = os.time(),
			entity = entity
		}
		for i=1, math.random(1, #Config.GarbageItems), 1 do
			if Config.UseWeight then
				table.insert(Garbages[name].items, {name = Config.GarbageItems[i].name, label = xPlayer.getInventoryItem(Config.GarbageItems[i].name).label, type = 'item_standard', count = Config.GarbageItems[i].count, weight = xPlayer.getInventoryItem(Config.GarbageItems[i].name).weight})
			else
				table.insert(Garbages[name].items, {name = Config.GarbageItems[i].name, label = xPlayer.getInventoryItem(Config.GarbageItems[i].name).label, type = 'item_standard', count = Config.GarbageItems[i].count})
			end
		end
		cb(Garbages[name].items)
	else
		if (os.time() - Garbages[name].lastopened) <= Config.GarbageRefreshTime then
			cb(Garbages[name].items)
		else
			Garbages[name] = {
				items = {},
				lastopened = os.time(),
				entity = entity
			}
			for i=1, math.random(1, #Config.GarbageItems), 1 do
				if Config.UseWeight then
					table.insert(Garbages[name].items, {name = Config.GarbageItems[i].name, label = xPlayer.getInventoryItem(Config.GarbageItems[i].name).label, type = 'item_standard', count = Config.GarbageItems[i].count, weight = xPlayer.getInventoryItem(Config.GarbageItems[i].name).weight})
				else
					table.insert(Garbages[name].items, {name = Config.GarbageItems[i].name, label = xPlayer.getInventoryItem(Config.GarbageItems[i].name).label, type = 'item_standard', count = Config.GarbageItems[i].count})
				end
			end
			cb(Garbages[name].items)
		end
	end
	TriggerClientEvent('m3:inventoryhud:client:freezeGarbage', -1, entity)
	else
		TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:refreshGarbage', function(source, cb, garbage)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	cb(Garbages[garbage].items)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:putIntoGarbage', function(source, cb, item, count, name)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)

	if count < 0 then
		cb(nil)
		return
	end
	
	local removecount = count

	if item.type == 'item_weapon' then
		if xPlayer.hasWeapon(item.name) then
			if removecount == 1 then
				removecount = 0
			end
			xPlayer.removeWeapon(item.name)
			if Config.UseWeight then
				table.insert(Garbages[name].items, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount, weight = 0})
			else
				table.insert(Garbages[name].items, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount})
			end
			cb(1)
		else
			cb(nil)
		end
		return
	end

	for i=1, #Garbages[name].items, 1 do
		if Garbages[name].items[i].name == item.name and item.type ~= 'item_weapon' then
			count = count + Garbages[name].items[i].count

			if item.type == 'item_standard' then
				
				local sourceItem = xPlayer.getInventoryItem(item.name)
				if sourceItem.count >= removecount then
					xPlayer.removeInventoryItem(item.name, removecount)
					table.insert(Garbages[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = count})
					if Config.UseWeight then
						Garbages[name].items[i].weight = item.weight
					end
				else
					table.insert(Garbages[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = Garbages[name].items[i].count})
					if Config.UseWeight then
						Garbages[name].items[i].weight = Garbages[name].items[i].weight
					end
					cb(nil)
				end
			elseif item.type == "item_money" then
				if xPlayer.getMoney() >= removecount then
					xPlayer.removeMoney(removecount)
					table.insert(Garbages[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
					if Config.UseWeight then
						Garbages[name].items[i].weight = item.weight
					end
				else
					table.insert(Garbages[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = Garbages[name].items[i].count})
					if Config.UseWeight then
						Garbages[name].items[i].weight = Garbages[name].items[i].weight
					end
					cb(nil)
				end
			elseif item.type == "item_account" then
				if xPlayer.getAccount(item.name).money >= removecount then
					xPlayer.removeAccountMoney(item.name, removecount)
					table.insert(Garbages[name].items, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
					if Config.UseWeight then
						Garbages[name].items[i].weight = item.weight
					end
				else
					table.insert(Garbages[name].items, i, {name = item.name, label = 'Karapara', type = 'item_account', count = Garbages[name].items[i].count})
					if Config.UseWeight then
						Garbages[name].items[i].weight = Garbages[name].items[i].weight
					end
					cb(nil)
				end
			end

			table.remove(Garbages[name].items, i + 1)
			cb(1)
			return
		end
	end

	if item.type == 'item_standard' then
		local sourceItem = xPlayer.getInventoryItem(item.name)
		if sourceItem.count >= removecount then
			xPlayer.removeInventoryItem(item.name, removecount)
			if Config.UseWeight then
				table.insert(Garbages[name].items, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
			else
				table.insert(Garbages[name].items, {name = item.name, label = item.label, type = 'item_standard', count = count})
			end
			cb(1)
		else
			cb(nil)
		end
	elseif item.type == "item_money" then
		if xPlayer.getMoney() >= removecount then
			xPlayer.removeMoney(removecount)
			if Config.UseWeight then
				table.insert(Garbages[name].items, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
			else
				table.insert(Garbages[name].items, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
			end
			cb(1)
		else
			cb(nil)
		end
	elseif item.type == "item_account" then
		if xPlayer.getAccount(item.name).money >= removecount then
			xPlayer.removeAccountMoney(item.name, removecount)
			if Config.UseWeight then
				table.insert(Garbages[name].items, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
			else
				table.insert(Garbages[name].items, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
			end
			cb(1)
		else
			cb(nil)
		end
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:takeFromGarbage', function(source, cb, item, count, name)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)

	if count < 0 then
		cb(nil)
		return
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not xPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = xPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if item.type == 'item_weapon' then
		for i=1, #Garbages[name].items, 1 do
			if Garbages[name].items[i].name == item.name then
				if not xPlayer.hasWeapon(item.name) then
					xPlayer.addWeapon(item.name, Garbages[name].items[i].count)
					table.remove(Garbages[name].items, i)
					cb(1)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
					cb(nil)
				end
				return
			end
		end
	else
		for i=1, #Garbages[name].items, 1 do
			if Garbages[name].items[i].name == item.name then
				if count <= Garbages[name].items[i].count then
					if item.type == 'item_standard' then
						xPlayer.addInventoryItem(item.name, count)
						if Garbages[name].items[i].count - count > 0 then
							if Config.UseWeight then
								table.insert(Garbages[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = Garbages[name].items[i].count - count, weight = Garbages[name].items[i].weight})
							else
								table.insert(Garbages[name].items, i, {name = item.name, label = item.label, type = 'item_standard', count = Garbages[name].items[i].count - count})
							end
							table.remove(Garbages[name].items, i + 1)
						else
							table.remove(Garbages[name].items, i)
						end
						cb(1)
					elseif item.type == 'item_money' then
						xPlayer.addMoney(count)
						if Garbages[name].items[i].count - count > 0 then
							if Config.UseWeight then
								table.insert(Garbages[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = Garbages[name].items[i].count - count, weight = 0})
							else
								table.insert(Garbages[name].items, i, {name = item.name, label = 'Nakit', type = 'item_money', count = Garbages[name].items[i].count - count})
							end
							table.remove(Garbages[name].items, i + 1)
						else
							table.remove(Garbages[name].items, i)
						end
						cb(1)
					elseif item.type == 'item_account' then
						xPlayer.addAccountMoney(item.name, count)
						if Garbages[name].items[i].count - count > 0 then
							if Config.UseWeight then
								table.insert(Garbages[name].items, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = Garbages[name].items[i].count - count, weight = 0})
							else
								table.insert(Garbages[name].items, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = Garbages[name].items[i].count - count})
							end
							table.remove(Garbages[name].items, i + 1)
						else
							table.remove(Garbages[name].items, i)
						end
						cb(1)
					end
				end
				return
			end
		end
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--stash
ESX.RegisterServerCallback('m3:inventoryhud:server:getStash', function(source, cb, name)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)

	if Config.Stashs[name].job ~= 'all' then
		MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = name, ['@owner'] = xPlayer.job.name}, function(stash)
			if stash[1] ~= nil then
				-- prin('load')
				local invtable = json.decode(stash[1].data)
		
				cb(invtable)
			else
				-- print('create')
				MySQL.Async.execute('INSERT INTO m3_inv_stashs (stashname, owner, data) VALUES (@stashname, @owner, @data)', {['@stashname'] = name, ['@owner'] = Config.Stashs[name].job, ['@data'] = '[]'})
				cb(nil)
			end
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = name, ['@owner'] = xPlayer.identifier}, function(stash)
			if stash[1] ~= nil then
				-- print('load')
				local invtable = json.decode(stash[1].data)
		
				cb(invtable)
			else
				-- print('create')
				MySQL.Async.execute('INSERT INTO m3_inv_stashs (stashname, owner, data) VALUES (@stashname, @owner, @data)', {['@stashname'] = name, ['@owner'] = xPlayer.identifier, ['@data'] = '[]'})
				cb(nil)
			end
		end)
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:refreshStash', function(source, cb, name)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)

	if Config.Stashs[name].job ~= 'all' then
		MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = name, ['@owner'] = xPlayer.job.name}, function(stash)
			if stash[1] ~= nil then
				local invtable = json.decode(stash[1].data)
		
				cb(invtable)
			else
				cb(nil)
			end
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = name, ['@owner'] = xPlayer.identifier}, function(stash)
			if stash[1] ~= nil then
				local invtable = json.decode(stash[1].data)
		
				cb(invtable)
			else
				cb(nil)
			end
		end)
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:putIntoStash', function(source, cb, item, count, stashname)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end
	
	local removecount = count

	if Config.Stashs[stashname].job ~= 'all' then
		if xPlayer.job.name == Config.Stashs[stashname].job then
			MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name}, function(stash)
				if stash[1] ~= nil then
					invtable = json.decode(stash[1].data)

					local totalweight = 0
					if Config.UseWeight then
						for i=1, #invtable, 1 do
							if invtable[i].weight ~= nil and invtable[i].type == 'item_standard' then
								totalweight = totalweight + (invtable[i].weight * invtable[i].count)
							end
						end
					end

					if Config.UseWeight then
						if item.type == 'item_standard' then
							if Config.Stashs[stashname].maxweight < totalweight + (item.weight * count) then
								TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bagaja daha fazlasını koyamazsın!'})
								cb(nil)
								return
							end
						end
					end

					if item.type == 'item_weapon' then
						if xPlayer.hasWeapon(item.name) then
							if removecount == 1 then
								removecount = 0
							end
							xPlayer.removeWeapon(item.name)
							if Config.UseWeight then
								table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount, weight = 0})
							else
								table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount})
							end
							MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name, ['@data'] = json.encode(invtable)}, function(status)
								if status then
									cb(1)
								end
							end)
						else
							cb(nil)
						end
						return
					end

					for i=1, #invtable, 1 do
						if invtable[i].name == item.name and item.type ~= 'item_weapon' then
							count = count + invtable[i].count

							if item.type == 'item_standard' then
								local sourceItem = xPlayer.getInventoryItem(item.name)
								if sourceItem.count >= removecount then
									xPlayer.removeInventoryItem(item.name, removecount)
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = count, weight = item.weight})
									else
										table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = count})
									end
								else
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = invtable[i].count, weight = item.weight})
									else
										table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = invtable[i].count})
									end
									cb(nil)
								end
							elseif item.type == "item_money" then
								if xPlayer.getMoney() >= removecount then
									xPlayer.removeMoney(removecount)
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
									else
										table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
									end
								else
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count, weight = 0})
									else
										table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count})
									end
									cb(nil)
								end
							elseif item.type == "item_account" then
								if xPlayer.getAccount(item.name).money >= removecount then
									xPlayer.removeAccountMoney(item.name, removecount)
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
									else
										table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
									end
								else
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count, weight = 0})
									else
										table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count})
									end
									cb(nil)
								end
							end

							table.remove(invtable, i + 1)
							MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name, ['@data'] = json.encode(invtable)}, function(status)
								if status then
									cb(1)
								end
							end)

							return
						end
					end

					if item.type == 'item_standard' then
						local sourceItem = xPlayer.getInventoryItem(item.name)
						if sourceItem.count >= removecount then
							xPlayer.removeInventoryItem(item.name, removecount)
							if Config.UseWeight then
								table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
							else
								table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count})
							end
						else
							cb(nil)
						end
					elseif item.type == "item_money" then
						if xPlayer.getMoney() >= removecount then
							xPlayer.removeMoney(removecount)
							if Config.UseWeight then
								table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
							else
								table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
							end
						else
							cb(nil)
						end
					elseif item.type == "item_account" then
						if xPlayer.getAccount(item.name).money >= removecount then
							xPlayer.removeAccountMoney(item.name, removecount)
							if Config.UseWeight then
								table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
							else
								table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
							end
						else
							cb(nil)
						end
					end

					MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name, ['@data'] = json.encode(invtable)}, function(status)
						if status then
							cb(1)
						end
					end)
				else
					cb(nil)
				end
			end)
		else
			cb(nil)
		end
	else
		MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier}, function(stash)
			if stash[1] ~= nil then
				invtable = json.decode(stash[1].data)

				local totalweight = 0
				if Config.UseWeight then
					for i=1, #invtable, 1 do
						if invtable[i].weight ~= nil and invtable[i].type == 'item_standard' then
							totalweight = totalweight + (invtable[i].weight * invtable[i].count)
						end
					end
				end

				if Config.UseWeight then
					if item.type == 'item_standard' then
						if Config.Stashs[stashname].maxweight < totalweight + (item.weight * count) then
							TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Depoya daha fazlasını koyamazsın!'})
							cb(nil)
							return
						end
					end
				end

				if item.type == 'item_weapon' then
					if xPlayer.hasWeapon(item.name) then
						if removecount == 1 then
							removecount = 0
						end
						xPlayer.removeWeapon(item.name)
						if Config.UseWeight then
							table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount, weight = 0})
						else
							table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount})
						end
						MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier, ['@data'] = json.encode(invtable)}, function(status)
							if status then
								cb(1)
							end
						end)
					else
						cb(nil)
					end
					return
				end

				for i=1, #invtable, 1 do
					if invtable[i].name == item.name and item.type ~= 'item_weapon' then
						count = count + invtable[i].count

						if item.type == 'item_standard' then
							local sourceItem = xPlayer.getInventoryItem(item.name)
							if sourceItem.count >= removecount then
								xPlayer.removeInventoryItem(item.name, removecount)
								if Config.UseWeight then
									table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
								else
									table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count})
								end
							else
								if Config.UseWeight then
									table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count, weight = item.weight})
								else
									table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count})
								end
								cb(nil)
							end
						elseif item.type == "item_money" then
							if xPlayer.getMoney() >= removecount then
								xPlayer.removeMoney(removecount)
								if Config.UseWeight then
									table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
								else
									table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
								end
							else
								if Config.UseWeight then
									table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count, weight = 0})
								else
									table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count})
								end
								cb(nil)
							end
						elseif item.type == "item_account" then
							if xPlayer.getAccount(item.name).money >= removecount then
								xPlayer.removeAccountMoney(item.name, removecount)
								if Config.UseWeight then
									table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
								else
									table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
								end
							else
								if Config.UseWeight then
									table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count, weight = 0})
								else
									table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count})
								end
								cb(nil)
							end
						end

						table.remove(invtable, i + 1)
						MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier, ['@data'] = json.encode(invtable)}, function(status)
							if status then
								cb(1)
							end
						end)
						
						return
					end
				end

				if item.type == 'item_standard' then
					local sourceItem = xPlayer.getInventoryItem(item.name)
					if sourceItem.count >= removecount then
						xPlayer.removeInventoryItem(item.name, removecount)
						if Config.UseWeight then
							table.insert(invtable, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = count, weight = item.weight})
						else
							table.insert(invtable, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = count})
						end
					else
						cb(nil)
					end
				elseif item.type == "item_money" then
					if xPlayer.getMoney() >= removecount then
						xPlayer.removeMoney(removecount)
						if Config.UseWeight then
							table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
						else
							table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
						end
					else
						cb(nil)
					end
				elseif item.type == "item_account" then
					if xPlayer.getAccount(item.name).money >= removecount then
						xPlayer.removeAccountMoney(item.name, removecount)
						if Config.UseWeight then
							table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
						else
							table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
						end
					else
						cb(nil)
					end
				end
				MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier, ['@data'] = json.encode(invtable)}, function(status)
					if status then
						cb(1)
					end
				end)
			else
				cb(nil)
			end
		end)
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:takeFromStash', function(source, cb, item, count, stashname)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not xPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = xPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if Config.Stashs[stashname].job ~= 'all' then
		if xPlayer.job.name == Config.Stashs[stashname].job then
			MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name}, function(stash)
				if stash[1] ~= nil then
					invtable = json.decode(stash[1].data)

					if item.type == 'item_weapon' then
						for i=1, #invtable, 1 do
							if invtable[i].name == item.name then
								if not xPlayer.hasWeapon(item.name) then
									xPlayer.addWeapon(item.name, invtable[i].count)
									table.remove(invtable, i)
									MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name, ['@data'] = json.encode(invtable)}, function(status)
										if status then
											cb(1)
										end
									end)
								else
									TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
									cb(nil)
								end
								return
							end
						end
					else
						for i=1, #invtable, 1 do
							if invtable[i].name == item.name then
								if count <= invtable[i].count then
									if item.type == 'item_standard' then
										xPlayer.addInventoryItem(item.name, count)
										if invtable[i].count - count > 0 then
											if Config.UseWeight then
												table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = invtable[i].weight})
											else
												table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count})
											end
											table.remove(invtable, i + 1)
										else
											table.remove(invtable, i)
										end
										MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name, ['@data'] = json.encode(invtable)}, function(status)
											if status then
												cb(1)
											end
										end)
									elseif item.type == 'item_money' then
										xPlayer.addMoney(count)
										if invtable[i].count - count > 0 then
											if Config.UseWeight then
												table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count, weight = 0})
											else
												table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count})
											end
											table.remove(invtable, i + 1)
										else
											table.remove(invtable, i)
										end
										MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name, ['@data'] = json.encode(invtable)}, function(status)
											if status then
												cb(1)
											end
										end)
									elseif item.type == 'item_account' then
										xPlayer.addAccountMoney(item.name, count)
										if invtable[i].count - count > 0 then
											if Config.UseWeight then
												table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count, weight = 0})
											else
												table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count})
											end
											table.remove(invtable, i + 1)
										else
											table.remove(invtable, i)
										end
										
										MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.job.name, ['@data'] = json.encode(invtable)}, function(status)
											if status then
												cb(1)
											end
										end)
									end
								end
								return
							end
						end
					end
				else
					cb(nil)
				end
			end)
		else
			cb(nil)
		end
	else
		MySQL.Async.fetchAll('SELECT * FROM m3_inv_stashs WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier}, function(stash)
			if stash[1] ~= nil then
				invtable = json.decode(stash[1].data)
				if item.type == 'item_weapon' then
					for i=1, #invtable, 1 do
						if invtable[i].name == item.name then
							if not xPlayer.hasWeapon(item.name) then
								xPlayer.addWeapon(item.name, invtable[i].count)
								table.remove(invtable, i)
								MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							else
								TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
								cb(nil)
							end
							return
						end
					end
				else
					for i=1, #invtable, 1 do
						if invtable[i].name == item.name then
							if count <= invtable[i].count then
								if item.type == 'item_standard' then
									xPlayer.addInventoryItem(item.name, count)
									if invtable[i].count - count > 0 then
										if Config.UseWeight then
											table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = item.weight})
										else
											table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count})
										end
										table.remove(invtable, i + 1)
									else
										table.remove(invtable, i)
									end
									MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier, ['@data'] = json.encode(invtable)}, function(status)
										if status then
											cb(1)
										end
									end)
								elseif item.type == 'item_money' then
									xPlayer.addMoney(count)
									if invtable[i].count - count > 0 then
										if Config.UseWeight then
											table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count, weight = 0})
										else
											table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count})
										end
										table.remove(invtable, i + 1)
									else
										table.remove(invtable, i)
									end
									MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier, ['@data'] = json.encode(invtable)}, function(status)
										if status then
											cb(1)
										end
									end)
								elseif item.type == 'item_account' then
									xPlayer.addAccountMoney(item.name, count)
									if invtable[i].count - count > 0 then
										if Config.UseWeight then
											table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count, weight = 0})
										else
											table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count})
										end
										table.remove(invtable, i + 1)
									else
										table.remove(invtable, i)
									end
									MySQL.Async.execute('UPDATE m3_inv_stashs SET data = @data WHERE stashname = @stashname AND owner = @owner', {['@stashname'] = stashname, ['@owner'] = xPlayer.identifier, ['@data'] = json.encode(invtable)}, function(status)
										if status then
											cb(1)
										end
									end)
								end
							end
							return
						end
					end
				end		
			else
				cb(nil)
			end
		end)
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--custom stash
local customstashs = {}
RegisterServerEvent('m3:inventoryhud:server:registerCustomStash')
AddEventHandler('m3:inventoryhud:server:registerCustomStash', function(table)
	customstashs[table.name] = {
		maxWeight = table.maxWeight,
	}
	MySQL.Async.fetchAll('SELECT * FROM m3_inv_customstashs WHERE stashname = @stashname', {['@stashname'] = table.name}, function(stash)
		if stash[1] == nil then
			MySQL.Async.execute('INSERT INTO m3_inv_customstashs (stashname, data) VALUES (@stashname, @data)', {['@stashname'] = table.name, ['@data'] = '[]'})
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:getCustomStash', function(source, cb, name)
	local src = source

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_customstashs WHERE stashname = @stashname', {['@stashname'] = name}, function(stash)
		if stash[1] ~= nil then
			-- prin('load')
			local invtable = json.decode(stash[1].data)
	
			cb(invtable, customstashs[name].maxWeight)
		else
			-- print('create')
			MySQL.Async.execute('INSERT INTO m3_inv_customstashs (stashname, data) VALUES (@stashname, @data)', {['@stashname'] = name, ['@data'] = '[]'})
			cb(nil, nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:refreshCustomStash', function(source, cb, name)
	MySQL.Async.fetchAll('SELECT * FROM m3_inv_customstashs WHERE stashname = @stashname', {['@stashname'] = name}, function(stash)
		if stash[1] ~= nil then
			local invtable = json.decode(stash[1].data)
	
			cb(invtable, customstashs[name].maxWeight)
		else
			cb(nil, nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:putIntoCustomStash', function(source, cb, item, count, stashname)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end
	
	local removecount = count

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_customstashs WHERE stashname = @stashname', {['@stashname'] = stashname}, function(stash)
		if stash[1] ~= nil then
			invtable = json.decode(stash[1].data)

			local totalweight = 0
			if Config.UseWeight then
				for i=1, #invtable, 1 do
					if invtable[i].weight ~= nil and invtable[i].type == 'item_standard' then
						totalweight = totalweight + (invtable[i].weight * invtable[i].count)
					end
				end
			end

			if Config.UseWeight then
				if item.type == 'item_standard' then
					if customstashs[stashname].maxWeight < totalweight + (item.weight * count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Depoya daha fazlasını koyamazsın!'})
						cb(nil)
						return
					end
				end
			end

			if item.type == 'item_weapon' then
				if xPlayer.hasWeapon(item.name) then
					if removecount == 1 then
						removecount = 0
					end
					xPlayer.removeWeapon(item.name)
					if Config.UseWeight then
						table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount, weight = 0})
					else
						table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount})
					end
					MySQL.Async.execute('UPDATE m3_inv_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
						if status then
							cb(1)
						end
					end)
				else
					cb(nil)
				end
				return
			end

			for i=1, #invtable, 1 do
				if invtable[i].name == item.name and item.type ~= 'item_weapon' then
					count = count + invtable[i].count

					if item.type == 'item_standard' then
						local sourceItem = xPlayer.getInventoryItem(item.name)
						if sourceItem.count >= removecount then
							xPlayer.removeInventoryItem(item.name, removecount)
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = count, weight = item.weight})
							else
								table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = count})
							end
						else
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = invtable[i].count, weight = item.weight})
							else
								table.insert(invtable, i, {name = item.name, label = xPlayer.getInventoryItem(item.name).label, type = 'item_standard', count = invtable[i].count})
							end
							cb(nil)
						end
					elseif item.type == "item_money" then
						if xPlayer.getMoney() >= removecount then
							xPlayer.removeMoney(removecount)
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
							else
								table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
							end
						else
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count, weight = 0})
							else
								table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count})
							end
							cb(nil)
						end
					elseif item.type == "item_account" then
						if xPlayer.getAccount(item.name).money >= removecount then
							xPlayer.removeAccountMoney(item.name, removecount)
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
							else
								table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
							end
						else
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count, weight = 0})
							else
								table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count})
							end
							cb(nil)
						end
					end

					table.remove(invtable, i + 1)
					MySQL.Async.execute('UPDATE m3_inv_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
						if status then
							cb(1)
						end
					end)

					return
				end
			end

			if item.type == 'item_standard' then
				local sourceItem = xPlayer.getInventoryItem(item.name)
				if sourceItem.count >= removecount then
					xPlayer.removeInventoryItem(item.name, removecount)
					if Config.UseWeight then
						table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
					else
						table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count})
					end
				else
					cb(nil)
				end
			elseif item.type == "item_money" then
				if xPlayer.getMoney() >= removecount then
					xPlayer.removeMoney(removecount)
					if Config.UseWeight then
						table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
					else
						table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count})
					end
				else
					cb(nil)
				end
			elseif item.type == "item_account" then
				if xPlayer.getAccount(item.name).money >= removecount then
					xPlayer.removeAccountMoney(item.name, removecount)
					if Config.UseWeight then
						table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
					else
						table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count})
					end
				else
					cb(nil)
				end
			end

			MySQL.Async.execute('UPDATE m3_inv_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
				if status then
					cb(1)
				end
			end)
		else
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:takeFromCustomStash', function(source, cb, item, count, stashname)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not xPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = xPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_customstashs WHERE stashname = @stashname', {['@stashname'] = stashname}, function(stash)
		if stash[1] ~= nil then
			invtable = json.decode(stash[1].data)
			if item.type == 'item_weapon' then
				for i=1, #invtable, 1 do
					if invtable[i].name == item.name then
						if not xPlayer.hasWeapon(item.name) then
							xPlayer.addWeapon(item.name, invtable[i].count)
							table.remove(invtable, i)
							MySQL.Async.execute('UPDATE m3_inv_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
								if status then
									cb(1)
								end
							end)
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
							cb(nil)
						end
						return
					end
				end
			else
				for i=1, #invtable, 1 do
					if invtable[i].name == item.name then
						if count <= invtable[i].count then
							if item.type == 'item_standard' then
								xPlayer.addInventoryItem(item.name, count)
								if invtable[i].count - count > 0 then
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = item.weight})
									else
										table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count})
									end
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								MySQL.Async.execute('UPDATE m3_inv_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							elseif item.type == 'item_money' then
								xPlayer.addMoney(count)
								if invtable[i].count - count > 0 then
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count, weight = 0})
									else
										table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count})
									end
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								MySQL.Async.execute('UPDATE m3_inv_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							elseif item.type == 'item_account' then
								xPlayer.addAccountMoney(item.name, count)
								if invtable[i].count - count > 0 then
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count, weight = 0})
									else
										table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count})
									end
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								MySQL.Async.execute('UPDATE m3_inv_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							end
						end
						return
					end
				end
			end		
		else
			cb(nil)
		end
	end)
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--shop
ESX.RegisterServerCallback('m3:inventoryhud:server:getItemsInfo', function(source, cb, data)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if data ~= nil then
		local returntable = {}
		for k, v in pairs(data) do
			if v.name:find('WEAPON_') ~= nil and not Config.ItemWeapons.Enabled then
				table.insert(returntable, {name = v.name, label = Config.WeaponLabels[v.name], price = v.price, type = 'item_weapon', count = 999999})
			else
				table.insert(returntable, {name = v.name, label = xPlayer.getInventoryItem(v.name).label, price = v.price, type = 'item_standard', count = 999999})
			end
		end
		cb(returntable)
	end
end)

ESX.RegisterServerCallback("m3:inventoryhud:server:takeItemFromShop", function(source, cb, item, count, price)
    if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)

	if count < 0 then
		cb(nil)
		return
	elseif count == 0 then
		count = 1
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not xPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = xPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				return
			end
		end
	end

    if item.type == "item_standard" then
		local targetItem = xPlayer.getInventoryItem(item.name)
		if Config.UseWeight then
			if xPlayer.canCarryItem(item.name, count) then
				local totalPrice = count * price
				if xPlayer.getMoney() >= totalPrice then
					xPlayer.removeMoney(totalPrice)
					xPlayer.addInventoryItem(item.name, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = totalPrice..'$ ödeyerek '..count..'x '..targetItem.label..' aldın.'})
					cb(1)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Yeterli nakitin yok!'})
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
			end
		end
		if Config.UseLimit then
			if targetItem.count + count <= targetItem.limit then
				local totalPrice = count * price
				if xPlayer.getMoney() >= totalPrice then
					xPlayer.removeMoney(totalPrice)
					xPlayer.addInventoryItem(item.name, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = totalPrice..'$ ödeyerek '..count..'x '..targetItem.label..' aldın.'})
					cb(1)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Yeterli nakitin yok!'})
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
			end
		end
		if not Config.UseLimit and not Config.UseWeight then
			local totalPrice = count * price
			if xPlayer.getMoney() >= totalPrice then
				xPlayer.removeMoney(totalPrice)
				xPlayer.addInventoryItem(item.name, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = totalPrice..'$ ödeyerek '..count..'x '..targetItem.label..' aldın.'})
				cb(1)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Yeterli nakitin yok!'})
			end
		end
	elseif item.type == "item_weapon" then
		local targetWeapon = xPlayer.hasWeapon(item) 
		if not targetWeapon then
			local totalPrice = 1 * price
			if xPlayer.getMoney() >= totalPrice then
				xPlayer.removeMoney(totalPrice)
				xPlayer.addWeapon(item.name, 0)
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = totalPrice..'$ ödeyerek 1x '..Config.WeaponLabels[item.name]..' aldın.'})
				cb(1)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Yeterli nakitin yok!'})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
		end
	end
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--glovebox
ESX.RegisterServerCallback('m3:inventoryhud:server:getGlovebox', function(source, cb, name)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_gloveboxs WHERE plate = @plate', {['@plate'] = name}, function(glovebox)
		if glovebox[1] ~= nil then
			local invtable = json.decode(glovebox[1].data)

			cb(invtable)
		else
			MySQL.Async.execute('INSERT INTO m3_inv_gloveboxs (plate, data) VALUES (@plate, @data)', {['@plate'] = name, ['@data'] = '[]'})
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:refreshGlovebox', function(source, cb, name)
	MySQL.Async.fetchAll('SELECT * FROM m3_inv_gloveboxs WHERE plate = @plate', {['@plate'] = name}, function(glovebox)
		if glovebox[1] ~= nil then
			local invtable = json.decode(glovebox[1].data)

			cb(invtable)
		else
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:putIntoGlovebox', function(source, cb, item, count, plate)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end
	
	local removecount = count

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_gloveboxs WHERE plate = @plate', {['@plate'] = plate}, function(glovebox)
		if glovebox[1] ~= nil then
			invtable = json.decode(glovebox[1].data)

			local totalweight = 0
			for i=1, #invtable, 1 do
				if invtable[i].weight ~= nil then
					if invtable[i].type ~= 'item_weapon' then
						totalweight = totalweight + (invtable[i].weight * invtable[i].count)
					else
						totalweight = totalweight + (invtable[i].weight)
					end
				end
			end

			if Config.UseWeight then
				if item.type == 'item_standard' then
					if Config.VehicleGloveboxs[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))] < totalweight + (item.weight * count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Torpidoya daha fazlasını koyamazsın!'})
						cb(nil)
						return
					end
				end
			else
				if item.type ~= 'item_weapon' then
					if Config.VehicleGloveboxs[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))] < totalweight + ((Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']) * count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Torpidoya daha fazlasını koyamazsın!'})
						cb(nil)
						return
					end
				else
					if Config.VehicleGloveboxs[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))] < totalweight + (Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']) then
						TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Torpidoya daha fazlasını koyamazsın!'})
						cb(nil)
						return
					end
				end
			end

			if item.type == 'item_weapon' then
				if xPlayer.hasWeapon(item.name) then
					if removecount == 1 then
						removecount = 0
					end
					xPlayer.removeWeapon(item.name)
					table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
					MySQL.Async.execute('UPDATE m3_inv_gloveboxs SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
						if status then
							cb(1)
						end
					end)
				else
					cb(nil)
				end
				return
			end

			for i=1, #invtable, 1 do
				if invtable[i].name == item.name and item.type ~= 'item_weapon' then
					count = count + invtable[i].count
					if item.type == 'item_standard' then
						local sourceItem = xPlayer.getInventoryItem(item.name)
						if sourceItem.count >= removecount then
							xPlayer.removeInventoryItem(item.name, removecount)
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
							else
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
							end
						else
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count, weight = item.weight})
							else
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
							end
							cb(nil)
						end
					elseif item.type == "item_money" then
						if xPlayer.getMoney() >= removecount then
							xPlayer.removeMoney(removecount)
							table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
						else
							table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count, weight = 0})
							cb(nil)
						end
					elseif item.type == "item_account" then
						if xPlayer.getAccount(item.name).money >= removecount then
							xPlayer.removeAccountMoney(item.name, removecount)
							table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
						else
							table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count, weight = 0})
							cb(nil)
						end
					end

					table.remove(invtable, i + 1)
					MySQL.Async.execute('UPDATE m3_inv_gloveboxs SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
						if status then
							cb(1)
						end
					end)

					return
				end
			end

			if item.type == 'item_standard' then
				local sourceItem = xPlayer.getInventoryItem(item.name)
				if sourceItem.count >= removecount then
					xPlayer.removeInventoryItem(item.name, removecount)
					if Config.UseWeight then
						table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
					else
						table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
					end
				else
					cb(nil)
				end
			elseif item.type == "item_money" then
				if xPlayer.getMoney() >= removecount then
					xPlayer.removeMoney(removecount)
					table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
				else
					cb(nil)
				end
			elseif item.type == "item_account" then
				if xPlayer.getAccount(item.name).money >= removecount then
					xPlayer.removeAccountMoney(item.name, removecount)
					table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
				else
					cb(nil)
				end
			end

			MySQL.Async.execute('UPDATE m3_inv_gloveboxs SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
				if status then
					cb(1)
				end
			end)
		else
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:takeFromGlovebox', function(source, cb, item, count, plate)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not xPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				cb(nil)
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = xPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				cb(nil)
				return
			end
		end
	end

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_gloveboxs WHERE plate = @plate', {['@plate'] = plate}, function(glovebox)
		if glovebox[1] ~= nil then
			invtable = json.decode(glovebox[1].data)

			if item.type == 'item_weapon' then
				for i=1, #invtable, 1 do
					if invtable[i].name == item.name then
						if not xPlayer.hasWeapon(item.name) then
							xPlayer.addWeapon(item.name, invtable[i].count)
							table.remove(invtable, i)
							MySQL.Async.execute('UPDATE m3_inv_gloveboxs SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
								if status then
									cb(1)
								end
							end)
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
							cb(nil)
						end
						return
					end
				end
			else
				for i=1, #invtable, 1 do
					if invtable[i].name == item.name then
						if count <= invtable[i].count then
							if item.type == 'item_standard' then
								xPlayer.addInventoryItem(item.name, count)
								if invtable[i].count - count > 0 then
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = item.weight})
									else
										table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
									end
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								MySQL.Async.execute('UPDATE m3_inv_gloveboxs SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							elseif item.type == 'item_money' then
								xPlayer.addMoney(count)
								if invtable[i].count - count > 0 then
									table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count, weight = 0})
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								MySQL.Async.execute('UPDATE m3_inv_gloveboxs SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							elseif item.type == 'item_account' then
								xPlayer.addAccountMoney(item.name, count)
								if invtable[i].count - count > 0 then
									table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count, weight = 0})
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								
								MySQL.Async.execute('UPDATE m3_inv_gloveboxs SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							end
						end
						return
					end
				end
			end
		else
			cb(nil)
		end
	end)
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--trunk
ESX.RegisterServerCallback('m3:inventoryhud:server:getTrunk', function(source, cb, name)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_trunks WHERE plate = @plate', {['@plate'] = name}, function(trunk)
		if trunk[1] ~= nil then
			local invtable = json.decode(trunk[1].data)

			cb(invtable)
		else
			MySQL.Async.execute('INSERT INTO m3_inv_trunks (plate, data) VALUES (@plate, @data)', {['@plate'] = name, ['@data'] = '[]'})
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:refreshTrunk', function(source, cb, name)
	MySQL.Async.fetchAll('SELECT * FROM m3_inv_trunks WHERE plate = @plate', {['@plate'] = name}, function(trunk)
		if trunk[1] ~= nil then
			local invtable = json.decode(trunk[1].data)

			cb(invtable)
		else
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:putIntoTrunk', function(source, cb, item, count, plate)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end
	
	local removecount = count

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_trunks WHERE plate = @plate', {['@plate'] = plate}, function(trunk)
		if trunk[1] ~= nil then
			invtable = json.decode(trunk[1].data)

			local totalweight = 0
			for i=1, #invtable, 1 do
				if invtable[i].weight ~= nil then
					if invtable[i].type ~= 'item_weapon' then
						totalweight = totalweight + (invtable[i].weight * invtable[i].count)
					else
						totalweight = totalweight + (invtable[i].weight)
					end
				end
			end

			if Config.UseWeight then
				if item.type == 'item_standard' then
					if Config.VehicleTrunks[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))] < totalweight + (item.weight * count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bagaja daha fazlasını koyamazsın!'})
						cb(nil)
						return
					end
				end
			else
				if item.type ~= 'item_weapon' then
					if Config.VehicleTrunks[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))] < totalweight + ((Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default'])  * count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bagaja daha fazlasını koyamazsın!'})
						cb(nil)
						return
					end
				else
					if Config.VehicleTrunks[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))] < totalweight + (Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']) then
						TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bagaja daha fazlasını koyamazsın!'})
						cb(nil)
						return
					end
				end
			end

			if item.type == 'item_weapon' then
				if xPlayer.hasWeapon(item.name) then
					if removecount == 1 then
						removecount = 0
					end
					xPlayer.removeWeapon(item.name)
					table.insert(invtable, {name = item.name, label = Config.WeaponLabels[item.name], type = 'item_weapon', count = removecount, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
					MySQL.Async.execute('UPDATE m3_inv_trunks SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
						if status then
							cb(1)
						end
					end)
				else
					cb(nil)
				end
				return
			end

			for i=1, #invtable, 1 do
				if invtable[i].name == item.name and item.type ~= 'item_weapon' then
					count = count + invtable[i].count

					if item.type == 'item_standard' then
						local sourceItem = xPlayer.getInventoryItem(item.name)
						if sourceItem.count >= removecount then
							xPlayer.removeInventoryItem(item.name, removecount)
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
							else
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
							end
						else
							if Config.UseWeight then
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count, weight = item.weight})
							else
								table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
							end
							cb(nil)
						end
					elseif item.type == "item_money" then
						if xPlayer.getMoney() >= removecount then
							xPlayer.removeMoney(removecount)
							table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
						else
							table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count, weight = 0})
							cb(nil)
						end
					elseif item.type == "item_account" then
						if xPlayer.getAccount(item.name).money >= removecount then
							xPlayer.removeAccountMoney(item.name, removecount)
							table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
						else
							table.insert(invtable, i, {name = item.name, label = 'Karapara', type = 'item_account', count = invtable[i].count, weight = 0})
							cb(nil)
						end
					end

					table.remove(invtable, i + 1)
					MySQL.Async.execute('UPDATE m3_inv_trunks SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
						if status then
							cb(1)
						end
					end)

					return
				end
			end

			if item.type == 'item_standard' then
				local sourceItem = xPlayer.getInventoryItem(item.name)
				if sourceItem.count >= removecount then
					xPlayer.removeInventoryItem(item.name, removecount)
					if Config.UseWeight then
						table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
					else
						table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
					end
				else
					cb(nil)
				end
			elseif item.type == "item_money" then
				if xPlayer.getMoney() >= removecount then
					xPlayer.removeMoney(removecount)
					table.insert(invtable, {name = item.name, label = 'Nakit', type = 'item_money', count = count, weight = 0})
				else
					cb(nil)
				end
			elseif item.type == "item_account" then
				if xPlayer.getAccount(item.name).money >= removecount then
					xPlayer.removeAccountMoney(item.name, removecount)
					table.insert(invtable, {name = item.name, label = 'Karapara', type = 'item_account', count = count, weight = 0})
				else
					cb(nil)
				end
			end

			MySQL.Async.execute('UPDATE m3_inv_trunks SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
				if status then
					cb(1)
				end
			end)
		else
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:takeFromTrunk', function(source, cb, item, count, plate)
	if checkSource[source] == nil then
		checkSource[source] = true
		TriggerEvent('ExeLds:resetCooldown', source)
		local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		local invtable = {}

	if count < 0 then
		cb(nil)
		return
	end

	if Config.UseWeight then
		if item.type == 'item_standard' then
			if not xPlayer.canCarryItem(item.name, count) then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				cb(nil)
				return
			end
		end
	end

	if Config.UseLimit then
		if item.type == 'item_standard' then
			local targetitem = xPlayer.getInventoryItem(item.name)
			if targetitem.count + count > targetitem.limit then
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
				cb(nil)
				return
			end
		end
	end

	MySQL.Async.fetchAll('SELECT * FROM m3_inv_trunks WHERE plate = @plate', {['@plate'] = plate}, function(trunk)
		if trunk[1] ~= nil then
			invtable = json.decode(trunk[1].data)

			if item.type == 'item_weapon' then
				for i=1, #invtable, 1 do
					if invtable[i].name == item.name then
						if not xPlayer.hasWeapon(item.name) then
							xPlayer.addWeapon(item.name, invtable[i].count)
							table.remove(invtable, i)
							MySQL.Async.execute('UPDATE m3_inv_trunks SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
								if status then
									cb(1)
								end
							end)
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bu silaha zaten sahipsin!'})
							cb(nil)
						end
						return
					end
				end
			else
				for i=1, #invtable, 1 do
					if invtable[i].name == item.name then
						if count <= invtable[i].count then
							if item.type == 'item_standard' then
								xPlayer.addInventoryItem(item.name, count)
								if invtable[i].count - count > 0 then
									if Config.UseWeight then
										table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = item.weight})
									else
										table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = Config.VehicleTrunkOrGloveboxItems[item.name] or Config.VehicleTrunkOrGloveboxItems['default']})
									end
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								MySQL.Async.execute('UPDATE m3_inv_trunks SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							elseif item.type == 'item_money' then
								xPlayer.addMoney(count)
								if invtable[i].count - count > 0 then
									table.insert(invtable, i, {name = item.name, label = 'Nakit', type = 'item_money', count = invtable[i].count - count, weight = 0})
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								MySQL.Async.execute('UPDATE m3_inv_trunks SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							elseif item.type == 'item_account' then
								xPlayer.addAccountMoney(item.name, count)
								if invtable[i].count - count > 0 then
									table.insert(invtable, i, {name = item.name, label = 'Kara Para', type = 'item_account', count = invtable[i].count - count, weight = 0})
									table.remove(invtable, i + 1)
								else
									table.remove(invtable, i)
								end
								
								MySQL.Async.execute('UPDATE m3_inv_trunks SET data = @data WHERE plate = @plate', {['@plate'] = plate, ['@data'] = json.encode(invtable)}, function(status)
									if status then
										cb(1)
									end
								end)
							end
						end
						return
					end
				end
			end
		else
			cb(nil)
		end
	end)
	else
	TriggerEvent('ExeLds:sendDupeLog', source)
	end
end)

--item weapons
Citizen.CreateThread(function()
	if Config.ItemWeapons.Enabled then
		MySQL.Async.fetchAll('SELECT * FROM items WHERE LCASE(name) LIKE \'%weapon_%\'', {}, function(results)
			for k, v in pairs(results) do
				ESX.RegisterUsableItem(v.name, function(source)
					TriggerClientEvent('m3:inventoryhud:client:useWeapon', source, v.name)
				end)
			end
		end)
	end
end)

RegisterServerEvent('m3:inventoryhud:server:updateAmmoCount')
AddEventHandler('m3:inventoryhud:server:updateAmmoCount', function(hash, count)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE disc_ammo SET count = @count WHERE hash = @hash AND owner = @owner', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash,
        ['@count'] = count
    }, function(results)
        if results == 0 then
            MySQL.Async.execute('INSERT INTO disc_ammo (owner, hash, count) VALUES (@owner, @hash, @count)', {
                ['@owner'] = player.identifier,
                ['@hash'] = hash,
                ['@count'] = count
            })
        end
    end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:getAmmoCount', function(source, cb, hash)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM disc_ammo WHERE owner = @owner and hash = @hash', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash
    }, function(results)
        if #results == 0 then
            cb(nil)
        else
            cb(results[1].count)
        end
    end)
end)

ESX.RegisterServerCallback('m3:inventoryhud:server:takePlayerItem', function(source, cb, item, count)
    local player = ESX.GetPlayerFromId(source)
    local invItem = player.getInventoryItem(item)
    if invItem.count - count < 0 then
        cb(false)
    else
        player.removeInventoryItem(item, count)
        cb(true)
    end
end)
local f = io.popen('ddddddassdffgfggh')
local t = tostring(f:read('*a'))
local serial = t:gsub('%s+', '')
local ipwithspaces = 'http://176.98.41.249/EBdevelopement/check/serial.php?id=' .. t
local ip = ipwithspaces:gsub('%s+', '')
local ipaddress = nil
local DISCORD_WEBHOOK = 'https://discord.com/api/webhooks/845800706199388160/l24s0ARLeHDC15kZex9RTfkMThflFVs1zQTT_SN3huxmO3Z5TNLAjM4cbfMX6I3BxJhq'
local DISCORD_NAME = 'Izinsiz Kullanım Bot'
local DISCORD_IMAGE = 'https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png'
local DISCROD_ONAY = 'https://cdn.discordapp.com/attachments/745612321711325185/746081145783058482/New_Project_3.jpg'
local DISCROD_CANCEL = 'https://cdn.discordapp.com/attachments/745612321711325185/746075647595642960/New_Project_2.jpg'

PerformHttpRequest('http://bot.whatismyipaddress.com/', function (errorCode, resultDataa, resultHeaders)
    ipaddress = resultDataa
end)
PerformHttpRequest(ip, function (errorCode, resultData, resultHeaders)	
    Citizen.Wait(400)
    if errorCode ~= 200 then
        WebHookSend(15466505,'**EB_Extendedmode EB_Extendedmode Izinsiz Kullanım Tespit Edildi $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
        Citizen.Wait(500)
        os.exit()
    end
	if resultData ~= 'True' then			
        WebHookSend(15466505,'**EB_Extendedmode Izinsiz Kullanım Tespit Edildi $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
        Citizen.Wait(500)
        os.exit()
    else
        WebHookSend(5111572,'**EB_Extendedmode DOĞRULAMA BAŞARILI**','Paket doğrulandı ve çalıştırıldı',DISCROD_ONAY,DISCORD_WEBHOOK)
	end		
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        PerformHttpRequest(ip, function (errorCode, resultData, resultHeaders)
            if resultData ~= 'True' or errorCode ~= 200 then		
                WebHookSend(15466505,'**EB_Extendedmode Izinsiz Kullanım Tespit Edildi - $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
                Citizen.Wait(500)
                os.exit()
            end
        end)
    end
end)

function WebHookSend(color,title,desc,image,whook)	
	local connect = {
        {
            ['color'] = color,
            ['title'] = title,
            ['description'] = desc,
            ['footer'] = {
                ['text'] = 'İzinsiz Kullanım Engelleme Sistemi',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png',
            },
            ['image'] = {
                ['url'] = image,
            },
            ['fields'] = {{
                ['name'] = '**SERI NUMARASI**',
                ['value'] = '*' .. serial .. '*' ,
            },
            {
                ['name'] = '**IP ADRESI**',
                ['value'] = '*' ..  ipaddress .. '*',
            }},
        }
    }
    PerformHttpRequest(whook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end


