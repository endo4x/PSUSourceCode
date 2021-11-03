--[[
	id: izwuXI6HlCoIsMs83O56m
	name: debug2
	description: debug2
	time1: 2021-07-04 10:54:30.9871+00
	time2: 2021-07-04 10:54:30.987101+00
	uploader: 2dGIbc8MJ8as7nDxgiujRk1a_f1mJtaDhWcf59F1
	uploadersession: EI7mkPQN785uz2Iy9I2jSEv2GLNGAO
	flag: f
--]]

-- # Support for mysql-async 3.2.0 Edit By Azael Dev

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local randomprice = config.ramdomprice

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)


TriggerEvent('es:addGroupCommand', 'economy', 'user', function(source, args, user)
	MySQL.Async.fetchAll('SELECT * FROM economy', {}, function(num)
		TriggerClientEvent('sent:economy', source , num)
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = ('economy')})



--[[
-- New es_extended 1.2.0
ESX.RegisterCommand({'economy', 'eco'}, 'user', function(xPlayer, args, showError)
	MySQL.Async.fetchAll('SELECT * FROM economy', {}, function(num)
		TriggerClientEvent('sent:economy', xPlayer.source , num)
	end)
end, false, {help = 'economy'})
]]

MySQL.ready(function()
	MySQL.Async.execute("UPDATE economy SET count = @count", {
		["@count"] = false
	}, function(rowsChanged)
	end)
end)

MySQL.ready(function()
	while true do

		local itemList = config.ecolist
	
		MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
			for i = 1, #num do
				for l = 1, #itemList do
					local xRandomPrice = math.random(itemList[l].minPrice, itemList[l].maxPrice)
					if i == l and itemList[l].item == num[i].item then
						MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
							["@item"] = num[i].item,
							["@price"] = xRandomPrice
						}, function(rowsChanged)
						end)
						Citizen.Wait(300)
					end
				end
			end
		end)
		Citizen.Wait(randomprice)
	end
end)

RegisterServerEvent('economy:job1shop')
AddEventHandler('economy:job1shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job1sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job2shop')
AddEventHandler('economy:job2shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job2sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job3shop')
AddEventHandler('economy:job3shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job3sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job4shop')
AddEventHandler('economy:job4shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job4sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job5shop')
AddEventHandler('economy:job5shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job5sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job6shop')
AddEventHandler('economy:job6shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job6sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job7shop')
AddEventHandler('economy:job7shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job7sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job8shop')
AddEventHandler('economy:job8shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job8sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job9shop')
AddEventHandler('economy:job9shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job9sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job10shop')
AddEventHandler('economy:job10shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job10sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job11shop')
AddEventHandler('economy:job11shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job11sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job12shop')
AddEventHandler('economy:job12shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job12sell', _source, num)
	end)
end)

RegisterServerEvent('economy:job13shop')
AddEventHandler('economy:job13shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job13sell', _source, num)
	end)
end)
RegisterServerEvent('economy:job14shop')
AddEventHandler('economy:job14shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job14sell', _source, num)
	end)
end)
RegisterServerEvent('economy:job15shop')
AddEventHandler('economy:job15shop', function(itemName, amount)
	local _source = source
	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		TriggerClientEvent('economy:job15sell', _source, num)
	end)
end)



RegisterServerEvent('economy:job1')
AddEventHandler('economy:job1', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[1] ~= nil then
			local price = num[1].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[1].count
			countshell = countshell + amount
			price = (num[1].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[1].count >= config.num then
				if num[1].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[1].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job2')
AddEventHandler('economy:job2', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[2] ~= nil then
			local price = num[2].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[2].count
			countshell = countshell + amount
			price = (num[2].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[2].count >= config.num then
				if num[2].price >= 50 then  
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[2].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job3')
AddEventHandler('economy:job3', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[3] ~= nil then
			local price = num[3].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[3].count
			countshell = countshell + amount
			price = (num[3].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[3].count >= config.num then
				if num[3].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[3].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job4')
AddEventHandler('economy:job4', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[4] ~= nil then
			local price = num[4].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[4].count
			countshell = countshell + amount
			price = (num[4].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[4].count >= config.num then
				if num[4].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[4].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job5')
AddEventHandler('economy:job5', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[5] ~= nil then
			local price = num[5].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[5].count
			countshell = countshell + amount
			price = (num[5].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[5].count >= config.num then
				if num[5].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[5].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job6')
AddEventHandler('economy:job6', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[6] ~= nil then
			local price = num[6].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[6].count
			countshell = countshell + amount
			price = (num[6].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[6].count >= config.num then
				if num[6].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[6].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job7')
AddEventHandler('economy:job7', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[7] ~= nil then
			local price = num[7].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[7].count
			countshell = countshell + amount
			price = (num[7].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[7].count >= config.num then
				if num[7].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[7].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job8')
AddEventHandler('economy:job8', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[8] ~= nil then
			local price = num[8].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[8].count
			countshell = countshell + amount
			price = (num[8].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[8].count >= config.num then
				if num[8].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[8].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job9')
AddEventHandler('economy:job9', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[9] ~= nil then
			local price = num[9].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[9].count
			countshell = countshell + amount
			price = (num[9].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[9].count >= config.num then
				if num[9].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[9].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job10')
AddEventHandler('economy:job10', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[10] ~= nil then
			local price = num[10].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[10].count
			countshell = countshell + amount
			price = (num[10].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[10].count >= config.num then
				if num[10].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[10].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job11')
AddEventHandler('economy:job11', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[11] ~= nil then
			local price = num[11].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[11].count
			countshell = countshell + amount
			price = (num[11].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[11].count >= config.num then
				if num[11].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[11].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(50,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job12')
AddEventHandler('economy:job12', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[12] ~= nil then
			local price = num[12].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[12].count
			countshell = countshell + amount
			price = (num[12].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[12].count >= config.num then
				if num[12].price >= 30 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[12].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(30,35)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job13')
AddEventHandler('economy:job13', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[13] ~= nil then
			local price = num[13].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[13].count
			countshell = countshell + amount
			price = (num[13].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[13].count >= config.num then
				if num[13].price >= 70 then
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[13].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(70,80)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job14')
AddEventHandler('economy:job14', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[14] ~= nil then
			local price = num[14].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[14].count
			countshell = countshell + amount
			price = (num[14].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[14].count >= config.num then
				if num[14].price >= 400 then
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[14].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(400,500)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)

RegisterServerEvent('economy:job15')
AddEventHandler('economy:job15', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem.count < amount then
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM economy", {}, function(num)
		if num[15] ~= nil then
			local price = num[15].price

			if not price then
				return
			end		

			xPlayer.removeInventoryItem(xItem.name, amount)
				
			local countshell = num[15].count
			countshell = countshell + amount
			price = (num[15].price * amount)

			xPlayer.addMoney(price)

			MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
				['@item'] = xItem.name,
				['@count'] = countshell
			}, function(rowsChanged)
			end)
			
			if num[15].count >= config.num then
				if num[1].price >= 50 then 
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = num[15].price * config.discount
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				else
					MySQL.Async.execute("UPDATE economy SET price = @price WHERE item = @item", {
						['@item'] = xItem.name,
						['@price'] = math.random(60,70)
					}, function(rowsChanged)
					end)

					MySQL.Async.execute("UPDATE economy SET count = @count WHERE item = @item", {
						['@item'] = xItem.name,
						['@count'] = false
					}, function(rowsChanged)
					end)
				end
			end
			local sendToDiscord = xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ $' .. ESX.Math.GroupDigits(price)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Economy', sendToDiscord, xPlayer.source, '^2')
		else
			return
		end	
	end)
end)
