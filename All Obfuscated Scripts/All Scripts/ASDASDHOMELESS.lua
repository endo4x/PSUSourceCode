--[[
	id: H0Glxwu1lfmLfEN495uup
	name: ASDASD HOMELESS
	description: ASDASD HOMELESS
	time1: 2021-05-24 23:46:41.882241+00
	time2: 2021-05-24 23:46:41.882242+00
	uploader: fBZ7JE4HlNXVYKdmQhUI8c0AeYPNu-IoVaUNGlsE
	uploadersession: MhzULNaGxjfRzpekKGntbkcuVgfNei
	flag: f
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local authorized = false

CreateThread(function()
	while true do
	authorized = json.decode(getauthorized())
	Wait(5000)
	end
end)

ESX.RegisterServerCallback('asdasd_getauthorized', function(source, cb)
cb(json.encode(authorized))
end)

ESX.RegisterServerCallback('asdasd_homelessgetmyinventory', function(source, cb)
if authorized == true then
	local xPlayer = ESX.GetPlayerFromId(source)
	local inventory = xPlayer.inventory
    cb(inventory)
end
end)

ESX.RegisterServerCallback('asdasd_getsafe', function(source, cb)
if authorized == true then
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./database.json")
	local tablazat = json.decode(loadFile)

	cb(tablazat)
end
end)

RegisterServerEvent('asdasd_putinsafe')
AddEventHandler('asdasd_putinsafe', function(itemname, count)
if authorized == true then
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local itemlabel = ESX.GetItemLabel(itemname)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./database.json")
	local tablazat = json.decode(loadFile)

	if isintable(itemname, tablazat) then
		for i,v in ipairs(tablazat) do
			if v.itemname == itemname then
				v.count = v.count + count
			end
		end
	else	
	table.insert(tablazat, {itemname = itemname, count = count, label = itemlabel})
	end

	SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(tablazat), -1)
	
	xPlayer.removeInventoryItem(itemname, count)
	xPlayer.showNotification(_U('youdeposit', count, ESX.GetItemLabel(itemname)))
	end
end)

RegisterServerEvent('asdasd_takeoutsafe')
AddEventHandler('asdasd_takeoutsafe', function(itemname, count)
if authorized == true then

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.canCarryItem(itemname, count) then
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./database.json")
	local tablazat = json.decode(loadFile)

	for i,v in ipairs(tablazat) do
		if v.itemname == itemname then
			if v.count == count then
			table.remove(tablazat, i)
			else
			v.count = v.count - count
			end
		end
	end

	SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(tablazat), -1)
	xPlayer.addInventoryItem(itemname,count)
	xPlayer.showNotification(_U('youwithdraw', count, ESX.GetItemLabel(itemname)))
	else
	xPlayer.showNotification(_U('inventorylimit'))
	end
end	
end)

function isintable(name, tablazat)
	for i,v in ipairs(tablazat) do
		if v.itemname == name then
			return true
		end
	end
	return false
end