--[[
	id: tinWh9IZiCcXq5V-U4b1H
	name: can Esx_cloteshop - server
	description: can Esx_cloteshop - server
	time1: 2021-04-29 23:34:09.644674+00
	time2: 2021-04-29 23:34:09.644674+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_clotheshop:saveOutfit')
AddEventHandler('esx_clotheshop:saveOutfit', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
		store.save()
	end)
end)

ESX.RegisterServerCallback('esx_clotheshop:buyClothes', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price then
		xPlayer.removeMoney(Config.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', Config.Price))
		cb(true)
	else
		TriggerClientEvent('notification', source, 'Paran Yetersiz!', 2)
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_clotheshop:checkPropertyDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('esx_bz_clotheshop:getPlayerDressing', function(source, cb)
  local xPlayer  = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local count    = store.count('dressing')
    local labels   = {}

    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(labels, entry.label)
    end

    cb(labels)
  end)
end)

ESX.RegisterServerCallback('esx_bz_clotheshop:getPlayerOutfit', function(source, cb, num)
  local xPlayer  = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local outfit = store.get('dressing', num)
    cb(outfit.skin)
  end)
end)

RegisterServerEvent('esx_bz_clotheshop:deleteOutfit')
AddEventHandler('esx_bz_clotheshop:deleteOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		label = label
		
		table.remove(dressing, label)

		store.set('dressing', dressing)
	end)
end)
