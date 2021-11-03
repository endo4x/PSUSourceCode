--[[
	id: hnRVfAbPgrRoGAH8hihCK
	name: PHEUTHAI
	description: PHEUTHAI SCRIPT
	time1: 2021-06-19 20:13:43.168208+00
	time2: 2021-06-19 20:13:43.168209+00
	uploader: lbtUGuJcVzC6OweYJDaZ3iDWZKftz1sggnfp5UWT
	uploadersession: u1ttgf_qtV4uU5JRDwXr2meCpJBCKU
	flag: f
--]]

-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('meeta_banana:pickedUp')
AddEventHandler('meeta_banana:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.ItemName)
	local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<span class="red-text">กล้วยคุณเต็ม</span> ',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		}) 
	else

		if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
			xPlayer.setInventoryItem(xItem.name, xItem.limit)
		else
			xPlayer.addInventoryItem(xItem.name, xItemCount)
			local xItemBalance = xPlayer.getInventoryItem(xItem.name).count

			local sendToDiscord = '**' .. xPlayer.name .. '** ได้รับ **' .. xItem.label .. '** จำนวน **' .. xItemCount .. '** รวมเป็น **' .. ESX.Math.GroupDigits(xItemBalance) .. '**'
			TriggerEvent('azael_discordlogs:sendToDiscord', 'Job', sendToDiscord, source, '^2') -- Webhook Name, Message, source, color
		end

		-- Bonus
		if Config.ItemBonus ~= nil then
			for k,v in pairs(Config.ItemBonus) do
				if math.random(1, 100) <= v.Percent then
					xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
					local xItemBalance = xPlayer.getInventoryItem(v.ItemName).count

					local sendToDiscord = '**' .. xPlayer.name .. '** ได้รับ โบนัส **' .. ESX.GetItemLabel(v.ItemName) .. '** จำนวน **' .. v.ItemCount .. '** รวมเป็น **' .. ESX.Math.GroupDigits(xItemBalance) .. '**'
					TriggerEvent('azael_discordlogs:sendToDiscord', 'WorkingAllJob', sendToDiscord, source, '^9') -- Webhook Name, Message, source, color
				end
			end
		end

	end
end)

ESX.RegisterServerCallback('meeta_banana:checkItem', function(source, cb, item2)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem2 = xPlayer.getInventoryItem(item2)
	cb((xItem2.count >= xItem2.limit))
end)

ESX.RegisterServerCallback('meeta_banana:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)