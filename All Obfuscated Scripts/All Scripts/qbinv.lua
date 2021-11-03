--[[
	id: R8kM_OPgFQW6vgNTI-9K4
	name: qb-inv
	description: server
	time1: 2021-07-16 19:25:34.133571+00
	time2: 2021-07-16 19:25:34.133572+00
	uploader: SzhOumxYM6SojTru8pB1aA9Wbef-VlNTfOTv26WA
	uploadersession: 3rrhd4su3lt07YarkdaVqWv3Lo2uGE
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Drops = {}
Trunks = {}
Gloveboxes = {}

Stashes = {}
ShopItems = {}
local ownedcars = {}
local Garbages = {}
local gloveboxdata, trunkdata, stashdata = {}, {}, {}

craftid = {}

RegisterServerEvent("fizzfau:setcraftid")
AddEventHandler("fizzfau:setcraftid", function(id)
	local player = ESX.GetPlayerFromId(source)
	local identifier = player.identifier
	craftid[identifier] = id
end)

RegisterServerEvent('tq-inventory:hotbarFix')
AddEventHandler('tq-inventory:hotbarFix', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.updateData()
end)

RegisterServerEvent("inventory:server:LoadDrops")
AddEventHandler('inventory:server:LoadDrops', function()
	local src = source
	if next(Drops) ~= nil then
		TriggerClientEvent("inventory:client:AddDropItem", -1, dropId, source)
		TriggerClientEvent("inventory:client:AddDropItem", src, Drops)
	end
end)

RegisterServerEvent("inventory:server:addTrunkItems")
AddEventHandler('inventory:server:addTrunkItems', function(plate, items)
	Trunks[plate] = {}
	Trunks[plate].items = items
end)
RegisterServerEvent('qb-inventory:server:freezeGarbages')
AddEventHandler('qb-inventory:server:freezeGarbages', function()
	for i=1, #Config.GarbageProps, 1 do
		if Config.GarbageProps[i] ~= nil then
			TriggerClientEvent('qb-inventory:client:freezeGarbage', source, Config.GarbageProps[i])
		end
	end
end)

RegisterServerEvent("inventory:server:combineItem")
AddEventHandler('inventory:server:combineItem', function(item, fromItem, toItem)
	local src = source
	local ply = ESX.GetPlayerFromId(src)

	ply.addInventoryItem(item, 1)
	ply.removeInventoryItem(fromItem, 1)
	ply.removeInventoryItem(toItem, 1)
end)

RegisterServerEvent("inventory:server:CraftItems")
AddEventHandler('inventory:server:CraftItems', function(itemName, itemCosts, count, toSlot, points)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local count = tonumber(count)
	if itemName ~= nil and itemCosts ~= nil then
		for k, v in pairs(itemCosts) do
			Player.removeInventoryItem(k, (v*count))
		end
		Player.addInventoryItem(itemName, count, toSlot)
		TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
	end
end)

RegisterServerEvent('inventory:server:CraftAttachment')
AddEventHandler('inventory:server:CraftAttachment', function(itemName, itemCosts, count, toSlot, points)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local count = tonumber(count)
	if itemName ~= nil and itemCosts ~= nil then
		for k, v in pairs(itemCosts) do
			Player.removeInventoryItem(k, (v*count))
		end
		Player.addInventoryItem(itemName, count, toSlot)
		TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
	end
end)

RegisterServerEvent("inventory:server:SetIsOpenState")
AddEventHandler('inventory:server:SetIsOpenState', function(IsOpen, type, id)
	if not IsOpen then
		if type == "stash" then
			Stashes[id].isOpen = false
		elseif type == "trunk" then
			Trunks[id].isOpen = false
		elseif type == "glovebox" then
			Gloveboxes[id].isOpen = false
		end
	end
end)

RegisterServerEvent("inventory:server:OpenInventory")
AddEventHandler('inventory:server:OpenInventory', function(name, id, other)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local PlayerAmmo = {}
		if Player ~= nil then
			if name ~= nil and id ~= nil then
				local secondInv = {}
				if name == "stash" then
					if Stashes[id] ~= nil then
						if Stashes[id].isOpen then
							local Target = ESX.GetPlayerFromId(Stashes[id].isOpen)
							if Target ~= nil then
								TriggerClientEvent('inventory:client:CheckOpenState', Stashes[id].isOpen, name, id, Stashes[id].label)
							else
								Stashes[id].isOpen = false
							end
						end
					end
					local maxweight = 1000000
					local slots = 100
					if other ~= nil then 
						maxweight = other.maxweight ~= nil and other.maxweight or 1000000
						slots = other.slots ~= nil and other.slots or 50
					end
					secondInv.name = "stash-"..id
					secondInv.label = "Stash-"..id
					secondInv.maxweight = maxweight
					secondInv.inventory = {}
					secondInv.slots = slots
					if Stashes[id] ~= nil and Stashes[id].isOpen then
						secondInv.name = "none-inv"
						secondInv.label = "Stash-None"
						secondInv.maxweight = 1000000
						secondInv.inventory = {}
						secondInv.slots = 0
					else
						local stashItems = GetStashItems(id)
						if next(stashItems) ~= nil then
							secondInv.inventory = stashItems
							Stashes[id] = {}
							Stashes[id].items = stashItems
							Stashes[id].isOpen = src
							Stashes[id].label = secondInv.label
						else
							Stashes[id] = {}
							Stashes[id].items = {}
							Stashes[id].isOpen = src
							Stashes[id].label = secondInv.label
						end
					end
				elseif name == "trunk" then
					if Trunks[id] ~= nil then
						if Trunks[id].isOpen then
							local Target = ESX.GetPlayerFromId(Trunks[id].isOpen)
							if Target ~= nil then
								TriggerClientEvent('inventory:client:CheckOpenState', Trunks[id].isOpen, name, id, Trunks[id].label)
							else
								Trunks[id].isOpen = false
							end
						end
					end
					secondInv.name = "trunk-"..id
					secondInv.label = "Trunk-"..id
					secondInv.maxweight = other.maxweight ~= nil and other.maxweight or 60000
					secondInv.inventory = {}
					secondInv.slots = other.slots ~= nil and other.slots or 50
					if (Trunks[id] ~= nil and Trunks[id].isOpen) or (SplitStr(id, "PD")[2] ~= nil and Player.job.name ~= "police") then
						secondInv.name = "none-inv"
						secondInv.label = "Trunk-None"
						secondInv.maxweight = other.maxweight ~= nil and other.maxweight or 60000
						secondInv.inventory = {}
						secondInv.slots = 0
					else
						if id ~= nil then 
							local ownedItems
							if IsVehicleOwned(id) then
								ownedItems = GetOwnedVehicleItems(id)
							end
							if IsVehicleOwned(id) and next(ownedItems) ~= nil then
								secondInv.inventory = ownedItems
								Trunks[id] = {}
								Trunks[id].items = ownedItems
								Trunks[id].isOpen = src
								Trunks[id].label = secondInv.label
							elseif Trunks[id] ~= nil and not Trunks[id].isOpen then
								secondInv.inventory = Trunks[id].items
								Trunks[id].isOpen = src
								Trunks[id].label = secondInv.label
							else
								Trunks[id] = {}
								Trunks[id].items = {}
								Trunks[id].isOpen = src
								Trunks[id].label = secondInv.label
							end
						end
					end
				elseif name == "glovebox" then
					if Gloveboxes[id] ~= nil then
						if Gloveboxes[id].isOpen then
							local Target = ESX.GetPlayerFromId(Gloveboxes[id].isOpen)
							if Target ~= nil then
								TriggerClientEvent('inventory:client:CheckOpenState', Gloveboxes[id].isOpen, name, id, Gloveboxes[id].label)
							else
								Gloveboxes[id].isOpen = false
							end
						end
					end
					secondInv.name = "glovebox-"..id
					secondInv.label = "Glovebox-"..id
					secondInv.maxweight = 7.5
					secondInv.inventory = {}
					secondInv.slots = 5
					if Gloveboxes[id] ~= nil and Gloveboxes[id].isOpen then
						secondInv.name = "none-inv"
						secondInv.label = "Glovebox-None"
						secondInv.maxweight = 10000
						secondInv.inventory = {}
						secondInv.slots = 0
					else
						local ownedItems
						if IsVehicleOwned(id) then
							ownedItems = GetOwnedVehicleGloveboxItems(id)
						end
						if Gloveboxes[id] ~= nil and not Gloveboxes[id].isOpen then
							secondInv.inventory = Gloveboxes[id].items
							Gloveboxes[id].isOpen = src
							Gloveboxes[id].label = secondInv.label
						elseif IsVehicleOwned(id) and next(ownedItems) ~= nil then
							secondInv.inventory = ownedItems
							Gloveboxes[id] = {}
							Gloveboxes[id].items = ownedItems
							Gloveboxes[id].isOpen = src
							Gloveboxes[id].label = secondInv.label
						else
							Gloveboxes[id] = {}
							Gloveboxes[id].items = {}
							Gloveboxes[id].isOpen = src
							Gloveboxes[id].label = secondInv.label
						end
					end
				elseif name == "shop" then
					secondInv.name = "itemshop-"..id
					secondInv.label = other.label
					secondInv.maxweight = 900000
					secondInv.inventory = SetupShopItems(id, other.items)
					ShopItems[id] = {}
					ShopItems[id].items = other.items
					secondInv.slots = #other.items
				elseif name == "traphouse" then
					secondInv.name = "traphouse-"..id
					secondInv.label = other.label
					secondInv.maxweight = 900000
					secondInv.inventory = other.items
					secondInv.slots = other.slots
				elseif name == "crafting" then
					secondInv.name = "crafting"
					secondInv.label = other.label
					secondInv.maxweight = 900000
					secondInv.inventory = other.items
					secondInv.slots = #other.items
				elseif name == 'garbage' then
					secondInv.name = "garbage-"..id
					secondInv.label = other.label
					secondInv.maxweight = 900000
					secondInv.inventory = other.items
					secondInv.slots = 15
				elseif name == "attachment_crafting" then
					secondInv.name = "attachment_crafting"
					secondInv.label = other.label
					secondInv.maxweight = 900000
					secondInv.inventory = other.items
					secondInv.slots = #other.items
				elseif name == "otherplayer" then
					local OtherPlayer = ESX.GetPlayerFromId(tonumber(id))
					if OtherPlayer ~= nil then
						secondInv.name = "otherplayer-"..id
						secondInv.label = "Oyuncu-"..id
						secondInv.maxweight = OtherPlayer.maxWeight
						secondInv.inventory = OtherPlayer.inventory
						if Player.job.name == "police" then
							secondInv.slots = 41
						else
							secondInv.slots = 41
						end
						Citizen.Wait(250)
					end
				else
					if Drops[id] ~= nil and not Drops[id].isOpen then
						secondInv.name = id
						secondInv.label = "Zemin-"..tostring(id)
						secondInv.maxweight = Config.DropMaxWeight
						secondInv.inventory = Drops[id].items
						secondInv.slots = 30
						Drops[id].isOpen = src
						Drops[id].label = secondInv.label
					else
						secondInv.name = "none-inv"
						secondInv.label = "Birakilan-Yok"
						secondInv.maxweight = Config.DropMaxWeight
						secondInv.inventory = {}
						secondInv.slots = 0
					end
				end
				TriggerClientEvent("inventory:client:OpenInventory", src, PlayerAmmo, Player.inventory, secondInv, other, id)
			else
				TriggerClientEvent("inventory:client:OpenInventory", src, PlayerAmmo, Player.inventory)
			end
		end
	--end)
end)

RegisterServerEvent("inventory:server:SaveInventory")
AddEventHandler('inventory:server:SaveInventory', function(type, id)
	if type == "trunk" then
		if (IsVehicleOwned(id)) then
			SaveOwnedVehicleItems(id, Trunks[id].items)
		else
			Trunks[id].isOpen = false
		end
	elseif type == "glovebox" then
		if (IsVehicleOwned(id)) then
			SaveOwnedGloveboxItems(id, Gloveboxes[id].items)
		else
			Gloveboxes[id].isOpen = false
		end
	elseif type == "stash" then
		SaveStashItems(id, Stashes[id].items)
	elseif type == "drop" then
		if Drops[id] ~= nil then
			Drops[id].isOpen = false
			if Drops[id].items == nil or next(Drops[id].items) == nil then
				Drops[id] = nil
				TriggerClientEvent("inventory:client:RemoveDropItem", -1, id)
			end
		end
	end
end)

RegisterServerEvent("inventory:server:UseItemSlot")
AddEventHandler('inventory:server:UseItemSlot', function(slot)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local itemData = Player.GetItemBySlot(slot)
	if itemData ~= nil then
		local itemInfo =  ESX.GetItems()[tostring(itemData.name)]
		if itemData.type == "weapon" then
			if itemData.info.quality ~= nil then
				if itemData.info.quality >= 0 then
					TriggerClientEvent("inventory:client:UseWeapon", src, itemData, true)
				else
					TriggerClientEvent("inventory:client:UseWeapon", src, itemData, false)
				end
			else
				TriggerClientEvent("inventory:client:UseWeapon", src, itemData, true)
			end
		elseif itemData.usable  then
			TriggerClientEvent("inventory:client:useitemkkkkk",src,itemData)
			TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "use")
			if itemData.name == "vehiclekey" then
				TriggerClientEvent('tq-vehiclekey:client:arabayikilitlememlazim', src, itemData.info.plaka)
			end
		end
	end
end)





RegisterServerEvent("inventory:server:UseItem")
AddEventHandler('inventory:server:UseItem', function(inventory, item)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local kullanilabiliritem = Player.GetItemByName(item.name)
	if inventory == "player" or inventory == "hotbar" then
		if kullanilabiliritem ~= nil then
		 	if kullanilabiliritem.usable then
				local itemData = Player.GetItemBySlot(item.slot)
				TriggerClientEvent('inventory:client:ItemBox', src, itemData, "use")
				TriggerClientEvent("inventory:client:useitemkkkkk",src,itemData)
				if item.name == "vehiclekey" then
					TriggerClientEvent('tq-vehiclekey:client:arabayikilitlememlazim', src, item.info.plaka)
				end
			end
		end
	end
end)


RegisterServerEvent("inventory:server:SetInventoryData")
AddEventHandler('inventory:server:SetInventoryData', function(fromInventory, toInventory, fromSlot, toSlot, fromcount, tocount)
	
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local identifier = Player.identifier
	local fromSlot = tonumber(fromSlot)
	local toSlot = tonumber(toSlot)
	local name = GetPlayerName(src)
	local firstname, lastname = Player.get("firstName"), Player.get("lastName")
	if (fromInventory == "player" or fromInventory == "hotbar") and (SplitStr(toInventory, "-")[1] == "itemshop" or toInventory == "crafting") then
		return
	end
	if fromInventory == "player" or fromInventory == "hotbar" then
		local fromItemData = Player.GetItemBySlot(fromSlot)
		local fromcount = tonumber(fromcount) ~= nil and tonumber(fromcount) or fromItemData.count
		if fromItemData ~= nil and fromItemData.count >= fromcount then
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.GetItemBySlot(toSlot)
				Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						Player.removeInventoryItem(toItemData.name, tocount, toSlot)
						Player.addInventoryItem(toItemData.name, tocount, fromSlot, toItemData.info)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil gardeş selamün aleyküm babba
				end
				Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
			elseif SplitStr(toInventory, "-")[1] == "otherplayer" then
				local playerId = tonumber(SplitStr(toInventory, "-")[2])
				local OtherPlayer = ESX.GetPlayerFromId(playerId)
				local toItemData = OtherPlayer.inventory[toSlot]
				Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						OtherPlayer.removeInventoryItem(itemInfo.name, tocount, fromSlot)
						Player.addInventoryItem(toItemData.name, tocount, fromSlot, toItemData.info)
					end
				else
					local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				end
				local itemInfo =  ESX.GetItems()[tostring(fromItemData.name)]
				OtherPlayer.addInventoryItem(itemInfo.name, fromcount, toSlot, fromItemData.info)
			elseif SplitStr(toInventory, "-")[1] == "trunk" then
				local plate = SplitStr(toInventory, "-")[2]
				local toItemData = Trunks[plate].items[toSlot]
				Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						RemoveFromTrunk(plate, fromSlot, itemInfo.name, tocount)
						Player.addInventoryItem(toItemData.name, tocount, fromSlot, toItemData.info)
						----exports["fizzfau-base"]:dclog(webhook.trunk, "Envanter Log", "***__EŞYA SWAPLENDI:__ *** ["..fromItemData.name.. " " ..fromcount.. "x - " ..toItemData.name.. " " ..tocount.. "x] \n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="trunk1", toName=toItemData.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=plate})
						--TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo.name.."**, count: **" .. tocount .. "** with name: **" .. fromItemData.name .. "**, count: **" .. fromcount .. "** - plate: *" .. plate .. "*")
					end
				else
					local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
					----exports["fizzfau-base"]:dclog(webhook.trunk, "Envanter Log", "**EÅŸya Bagaja Koyuldu: **"..fromItemData.name.. " " ..fromcount.. "x\n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="trunk2", name=fromItemData.name, count=fromcount, target=plate})
					--TriggerEvent("qb-log:server:CreateLog", "trunk", "Dropped Item", "red", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo.name.."**, count: **" .. fromcount .. "** - plate: *" .. plate .. "*")
				end
				local itemInfo =  ESX.GetItems()[tostring(fromItemData.name)]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo.name, fromcount, fromItemData.info)
			elseif SplitStr(toInventory, "-")[1] == "glovebox" then
				local plate = SplitStr(toInventory, "-")[2]
				local toItemData = Gloveboxes[plate].items[toSlot]
				Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						RemoveFromGlovebox(plate, fromSlot, itemInfo.name, tocount)
						Player.addInventoryItem(toItemData.name, tocount, fromSlot, toItemData.info)
						----exports["fizzfau-base"]:dclog(webhook.glovebox, "Envanter Log", "***__EÅYA SWAPLENDI:__ *** ["..fromItemData.name.. " " ..fromcount.. "x - " ..toItemData.name.. " " ..tocount.. "x] \n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="glovebox1", toName=toItemData.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=plate})
						--TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo.name.."**, count: **" .. tocount .. "** with name: **" .. fromItemData.name .. "**, count: **" .. fromcount .. "** - plate: *" .. plate .. "*")
					end
				else
					local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
					----exports["fizzfau-base"]:dclog(webhook.glovebox, "Envanter Log", "**EÅŸya Torpidoya Koyuldu: **"..fromItemData.name.. " " ..fromcount.. "x\n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
				--	TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="glovebox2", name=fromItemData.name, count=fromcount, target=plate})
				--	TriggerEvent("qb-log:server:CreateLog", "glovebox", "Dropped Item", "red", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo.name.."**, count: **" .. fromcount .. "** - plate: *" .. plate .. "*")
				end
				local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo.name, fromcount, fromItemData.info)
			elseif SplitStr(toInventory, "-")[1] == "stash" then
				local stashId = SplitStr(toInventory, "-")[2]
				local toItemData = Stashes[stashId].items[toSlot]
				local essxItem = ESX.GetItems()
				Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
				--exports["fizzfau-base"]:dclog(webhook.stash, "Envanter Log", "**EÅŸya Depoya Koyuldu: **" ..fromItemData.name.. " " ..fromcount.. "x\n **Depo NumarasÄ±: ** "..stashId.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
				TriggerClientEvent('inventory:client:ItemBox', src, essxItem[fromItemData.name], 'remove', fromcount)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local essxItem = ESX.GetItems()
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						RemoveFromStash(stashId, fromSlot, itemInfo.name, tocount)
						Player.addInventoryItem(toItemData.name, tocount, fromSlot, toItemData.info)
						--TriggerClientEvent('inventory:client:ItemBox',src,essxItem[toItemData.name],'add',tocount)
						----exports["fizzfau-base"]:dclog(webhook.stash, "Envanter Log", "***__EÅYA SWAPLENDI:__ *** ["..fromItemData.name.. " " ..fromcount.. "x - " ..toItemData.name.. " " ..tocount.. "x] \n **Depo NumarasÄ±: ** "..stashId.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="stash1", toName=toItemData.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=stashId})
						--TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo.name.."**, count: **" .. tocount .. "** with name: **" .. fromItemData.name .. "**, count: **" .. fromcount .. "** - stash: *" .. stashId .. "*")
					end
				else
					local itemInfo = ESX.GetItems()[(tostring(fromItemData.name))]
					----exports["fizzfau-base"]:dclog(webhook.stash, "Envanter Log", "**EÅŸya Depoya Koyuldu: **" ..fromItemData.name.. " " ..fromcount.. "x\n **Depo NumarasÄ±: ** "..stashId.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="stash2", name=fromItemData.name, count=fromcount, target=stashId})
					--TriggerEvent("qb-log:server:CreateLog", "stash", "Dropped Item", "red", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo.name.."**, count: **" .. fromcount .. "** - stash: *" .. stashId .. "*")
				end
				local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				AddToStash(stashId, toSlot, fromSlot, itemInfo.name, fromcount, fromItemData.info)
			elseif SplitStr(toInventory, "-")[1] == "traphouse" then
				-- Traphouse
				local traphouseId = SplitStr(toInventory, "-")[2]
				local toItemData = exports['qb-traphouses']:GetInventoryData(traphouseId, toSlot)
				local IsItemValid = exports['qb-traphouses']:CanItemBeSaled(fromItemData.name:lower())
				if IsItemValid then
					Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
						local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
						if toItemData.name ~= fromItemData.name then
							exports['qb-traphouses']:RemoveHouseItem(traphouseId, fromSlot, itemInfo.name, tocount)
							Player.addInventoryItem(toItemData.name, tocount, fromSlot, toItemData.info)
							--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="traphouse1", toName=toItemData.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=traphouseId})
							--TriggerEvent("qb-log:server:CreateLog", "traphouse", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo.name.."**, count: **" .. tocount .. "** with name: **" .. fromItemData.name .. "**, count: **" .. fromcount .. "** - traphouse: *" .. traphouseId .. "*")
						end
					else
						local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="traphouse2", name=fromItemData.name, count=fromcount, target=traphouseId})
						--TriggerEvent("qb-log:server:CreateLog", "traphouse", "Dropped Item", "red", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo.name.."**, count: **" .. fromcount .. "** - traphouse: *" .. traphouseId .. "*")
					end
					local itemInfo =  ESX.GetItems()[tostring(fromItemData.name)]
					exports['qb-traphouses']:AddHouseItem(traphouseId, toSlot, itemInfo.name, fromcount, fromItemData.info, src)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bu esyayi satamassin..', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				end
			else
				-- drop
				toInventory = tonumber(toInventory)
				if toInventory == nil or toInventory == 0 then
					CreateNewDrop(src, fromSlot, toSlot, fromcount)
					----exports["fizzfau-base"]:dclog(webhook.drop, "Envanter Log", "**EÅŸya Yere AtÄ±ldÄ±: **" ..fromItemData.name.. " " ..fromcount.. "x\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
				else
					local toItemData = Drops[toInventory].items[toSlot]
					Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
						local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
						if toItemData.name ~= fromItemData.name then
							Player.addInventoryItem(toItemData.name, tocount, fromSlot, toItemData.info)
							RemoveFromDrop(toInventory, fromSlot, itemInfo.name, tocount)
							----exports["fizzfau-base"]:dclog(webhook.drop, "Envanter Log", "***__EÅYA SWAPLENDI (DUPE ALERT!!!):__ *** ["..fromItemData.name.. " " ..fromcount.. "x - " ..toItemData.name.. " " ..tocount.. "x] \n **EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)

							--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="drop1", toName=toItemData.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=toInventory})
							--TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo.name.."**, count: **" .. tocount .. "** with name: **" .. fromItemData.name .. "**, count: **" .. fromcount .. "** - dropid: *" .. toInventory .. "*")
						end
					else
						local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="drop2", name=fromItemData.name, count=fromcount, target=toInventory})
						--TriggerEvent("qb-log:server:CreateLog", "drop", "Dropped Item", "red", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo.name.."**, count: **" .. fromcount .. "** - dropid: *" .. toInventory .. "*")
					end

					local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
					AddToDrop(toInventory, toSlot, itemInfo.name, fromcount, fromItemData.info)
					if itemInfo.name == "gps" then
						--TriggerClientEvent('qb-radio:onRadioDrop', src)
						TriggerClientEvent('exelds:GPSStop', src)
					elseif itemInfo.name == 'radio' then
						TriggerClientEvent('sup_radio:close-radio', src)
					end
				end
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bu esyaya sahip degilsin!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		end
	elseif SplitStr(fromInventory, "-")[1] == "otherplayer" then
		local playerId = tonumber(SplitStr(fromInventory, "-")[2])
		local OtherPlayer = ESX.GetPlayerFromId(playerId)
		local fromItemData = OtherPlayer.inventory[fromSlot]
		local fromcount = tonumber(fromcount) ~= nil and tonumber(fromcount) or fromItemData.count
		if fromItemData ~= nil and fromItemData.count >= fromcount then
			local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.GetItemBySlot(toSlot)
				OtherPlayer.removeInventoryItem(itemInfo.name, fromcount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", OtherPlayer.source, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						Player.removeInventoryItem(toItemData.name, tocount, toSlot)
						OtherPlayer.addInventoryItem(itemInfo.name, tocount, fromSlot, toItemData.info)
					--	TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2citizen1", toName=itemInfo.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=OtherPlayer.PlayerData.citizenid})
					--	TriggerEvent("qb-log:server:CreateLog", "robbing", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** with item; **"..itemInfo.name.."**, count: **" .. tocount .. "** from player: **".. GetPlayerName(OtherPlayer.PlayerData.source) .. "** (citizenid: *"..OtherPlayer.PlayerData.citizenid.."* | *"..OtherPlayer.PlayerData.source.."*)")
					end
				else
					--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2citizen2", name=fromItemData.name, count=fromcount, target=OtherPlayer.PlayerData.citizenid})
					--TriggerEvent("qb-log:server:CreateLog", "robbing", "Retrieved Item", "green", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) took item; name: **"..fromItemData.name.."**, count: **" .. fromcount .. "** from player: **".. GetPlayerName(OtherPlayer.PlayerData.source) .. "** (citizenid: *"..OtherPlayer.PlayerData.citizenid.."* | *"..OtherPlayer.PlayerData.source.."*)")
				end
				Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
				----local discord = exports["fizzfau-base"]:getid(OtherPlayer.source)["discord"]
				----local discord2 = exports["fizzfau-base"]:getid(Player.source)["discord"]
				----exports["fizzfau-base"]:dclog(webhook.search, "Search Log", "**Alan Kişi: ** "..discord2.. "\n **Veren Kişi:** "..discord.. "\n **Alınan Eşya: **" ..itemInfo.name.. "\n **Eşya Sayısı:** " ..fromcount)

				if itemInfo.name == 'radio' then
					TriggerClientEvent('sup_radio:close-radio', OtherPlayer.source)
				end
			else
				local toItemData = OtherPlayer.inventory[toSlot]
				OtherPlayer.removeInventoryItem(itemInfo.name, fromcount, fromSlot)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					--Player.PlayerData.items[fromSlot] = toItemData
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
						OtherPlayer.removeInventoryItem(itemInfo.name, tocount, toSlot)
						OtherPlayer.addInventoryItem(itemInfo.name, tocount, fromSlot, toItemData.info)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				OtherPlayer.addInventoryItem(itemInfo.name, fromcount, toSlot, fromItemData.info)
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nesne mevcut degil??', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		end
	elseif SplitStr(fromInventory, "-")[1] == "trunk" then
		local plate = SplitStr(fromInventory, "-")[2]
		local fromItemData = Trunks[plate].items[fromSlot]
		local fromcount = tonumber(fromcount) ~= nil and tonumber(fromcount) or fromItemData.count
		if fromItemData ~= nil and fromItemData.count >= fromcount then
			local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.GetItemBySlot(toSlot)
				RemoveFromTrunk(plate, fromSlot, itemInfo.name, fromcount)
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						Player.removeInventoryItem(toItemData.name, tocount, toSlot)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo.name, tocount, toItemData.info)
						----exports["fizzfau-base"]:dclog(webhook.trunk, "Envanter Log", "***__EÅYA SWAPLENDI:__ *** ["..toItemData.name.. " " ..tocount.. "x - " ..fromItemData.name.. " " ..fromcount.. "x] \n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2trunk1", toName=itemInfo.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=plate})
						--TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** with item; name: **"..itemInfo.name.."**, count: **" .. tocount .. "** plate: *" .. plate .. "*")
					else
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2trunk3", name=toItemData.name, count=tocount, target=plate})
						--TriggerEvent("qb-log:server:CreateLog", "trunk", "Stacked Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** from plate: *" .. plate .. "*")
					end
				else
					----exports["fizzfau-base"]:dclog(webhook.trunk, "Envanter Log", "**EÅŸya Bagajdan AlÄ±ndÄ±: **"..itemInfo.name.. " " ..fromcount.. "x\n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2trunk2", name=fromItemData.name, count=fromcount, target=plate})
					--TriggerEvent("qb-log:server:CreateLog", "trunk", "Received Item", "green", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) reveived item; name: **"..fromItemData.name.."**, count: **" .. fromcount.. "** plate: *" .. plate .. "*")
				end
				Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
			else
				local toItemData = Trunks[plate].items[toSlot]
				RemoveFromTrunk(plate, fromSlot, itemInfo.name, fromcount)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					--Player.PlayerData.items[fromSlot] = toItemData
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
						RemoveFromTrunk(plate, toSlot, itemInfo.name, tocount)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo.name, tocount, toItemData.info)
						----exports["fizzfau-base"]:dclog(webhook.trunk, "Envanter Log", "**EÅŸya Bagaja Konuldu: **"..itemInfo.name.. " " ..tocount.. "x\n **AraÃ§ PlakasÄ±: ** "..plate.."**EÅŸyayÄ± BÄ±rakan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo.name, fromcount, fromItemData.info)
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nesne mevcut degil??', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		end
	elseif SplitStr(fromInventory, "-")[1] == "glovebox" then
		local plate = SplitStr(fromInventory, "-")[2]
		local fromItemData = Gloveboxes[plate].items[fromSlot]
		local fromcount = tonumber(fromcount) ~= nil and tonumber(fromcount) or fromItemData.count
		if fromItemData ~= nil and fromItemData.count >= fromcount then
			local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.GetItemBySlot(toSlot)
				RemoveFromGlovebox(plate, fromSlot, itemInfo.name, fromcount)
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						Player.removeInventoryItem(toItemData.name, tocount, toSlot)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo.name, tocount, toItemData.info)
						----exports["fizzfau-base"]:dclog(webhook.glovebox, "Envanter Log", "***__EÅYA SWAPLENDI:__ *** ["..fromItemData.name.. " " ..fromcount.. "x - " ..toItemData.name.. " " ..tocount.. "x] \n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2glovebox1", toName=itemInfo.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=plate})
						--TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src..")* swapped item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** with item; name: **"..itemInfo.name.."**, count: **" .. tocount .. "** plate: *" .. plate .. "*")
					else
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2glovebox3", name=toItemData.name, count=tocount, target=plate})
						--TriggerEvent("qb-log:server:CreateLog", "glovebox", "Stacked Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** from plate: *" .. plate .. "*")
					end
				else
					----exports["fizzfau-base"]:dclog(webhook.glovebox, "Envanter Log", "**EÅŸya Torpidodan AlÄ±ndÄ±: **"..fromItemData.name.. " " ..fromcount.. "x\n **AraÃ§ PlakasÄ±: ** "..plate.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2glovebox2", name=fromItemData.name, count=fromcount, target=plate})
					--TriggerEvent("qb-log:server:CreateLog", "glovebox", "Received Item", "green", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) reveived item; name: **"..fromItemData.name.."**, count: **" .. fromcount.. "** plate: *" .. plate .. "*")
				end
				Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
			else
				local toItemData = Gloveboxes[plate].items[toSlot]
				RemoveFromGlovebox(plate, fromSlot, itemInfo.name, fromcount)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					--Player.PlayerData.items[fromSlot] = toItemData
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
						RemoveFromGlovebox(plate, toSlot, itemInfo.name, tocount)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo.name, tocount, toItemData.info)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo.name, fromcount, fromItemData.info)
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'İtem mevcut değil!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		end
	elseif SplitStr(fromInventory, "-")[1] == "stash" then
		local stashId = SplitStr(fromInventory, "-")[2]
		local fromItemData = Stashes[stashId].items[fromSlot]
		local fromcount = tonumber(fromcount) ~= nil and tonumber(fromcount) or fromItemData.count
		if fromItemData ~= nil and fromItemData.count >= fromcount then
			local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.GetItemBySlot(toSlot)
				RemoveFromStash(stashId, fromSlot, itemInfo.name, fromcount)
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						Player.removeInventoryItem(toItemData.name, tocount, toSlot)
						AddToStash(stashId, fromSlot, toSlot, itemInfo.name, tocount, toItemData.info)
						----exports["fizzfau-base"]:dclog(webhook.trunk, "Envanter Log", "***__EÅYA SWAPLENDI:__ *** ["..toItemData.name.. " " ..tocount.. "x - " ..fromItemData.name.. " " ..fromcount.. "x] \n **Depo NumarasÄ±: ** "..stashId.."\n**EÅŸyayÄ± Koyan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					--	TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2stash1", toName=toItemData.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=stashId})
					--	TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** with item; name: **"..fromItemData.name.."**, count: **" .. fromcount .. "** stash: *" .. stashId .. "*")
					else
					--	TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2stash3", name=toItemData.name, count=tocount, target=stashId})
					--	TriggerEvent("qb-log:server:CreateLog", "stash", "Stacked Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** from stash: *" .. stashId .. "*")
					end
				else
					----exports["fizzfau-base"]:dclog(webhook.stash, "Envanter Log", "**EÅŸya Depodan AlÄ±ndÄ±: **"..fromItemData.name.. " " ..fromcount.. "x\n **Depo NumarasÄ±: ** "..stashId.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
				--	TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2stash2", name=fromItemData.name, count=fromcount, target=stashId})
				--	TriggerEvent("qb-log:server:CreateLog", "stash", "Received Item", "green", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) reveived item; name: **"..fromItemData.name.."**, count: **" .. fromcount.. "** stash: *" .. stashId .. "*")
				end
				Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
			else
				local toItemData = Stashes[stashId].items[toSlot]
				RemoveFromStash(stashId, fromSlot, itemInfo.name, fromcount)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					--Player.PlayerData.items[fromSlot] = toItemData
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
						RemoveFromStash(stashId, toSlot, itemInfo.name, tocount)
						AddToStash(stashId, fromSlot, toSlot, itemInfo.name, tocount, toItemData.info)
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				AddToStash(stashId, toSlot, fromSlot, itemInfo.name, fromcount, fromItemData.info)
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nesne mevcut degil??', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		end
		
	elseif SplitStr(fromInventory, "-")[1] == "itemshop" then
		local shopType = SplitStr(fromInventory, "-")[2]
		local itemData = ShopItems[shopType].items[fromSlot]
		local itemInfo = ESX.GetItems()[tostring(itemData.name)]
		local bankBalance = Player.getMoney()
		local price = tonumber((itemData.price *fromcount))
		if SplitStr(shopType, "_")[1] == "Dealer" then
			if SplitStr(itemData.name, "_")[1] == "weapon" then
				price = tonumber(itemData.price)
				if bankBalance >= price then
					itemData.info.serie = tostring(Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
					Player.addInventoryItem(itemData.name, 1, toSlot, itemData.info)
					Player.removeMoney(price)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli nakitin yok!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				end
			else
				if bankBalance >= price then
					Player.removeMoney(price)
					Player.addInventoryItem(itemData.name, fromcount, toSlot, itemData.info)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli nakitin yok!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				end
			end
		elseif SplitStr(shopType, "_")[1] == "Itemshop" then
			local EsxItems = ESX.GetItems()
			local name = getIdentity(source)
			local walletinfo = {
				firstname = name.firstname,
				lastname = name.lastname,
				birthdate = name.dateofbirth,
				nationality = name.height,
			}
			if bankBalance >= price then
				if itemData.type == 'weapon' and Player.job.name ~= "police" and Player.job.name ~= "sheriff" then
					itemData.info.serie =  tostring(Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
				elseif itemData.type == 'weapon' and Player.job.name == "police" then
					itemData.info.serie =  tostring('PD-'.. name.firstname ..'-'.. name.lastname ..'-'.. Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
				elseif itemData.type == 'weapon' and Player.job.name == "sheriff" then
					itemData.info.serie =  tostring('SD-'.. name.firstname ..'-'.. name.lastname ..'-'.. Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
				end
				if itemData.name == "wallet" then
					Player.removeMoney(price)
					Player.addInventoryItem(itemData.name, fromcount, toSlot, walletinfo)
					----exports["fizzfau-base"]:dclog(webhook.shop, "Envanter Log", "**EÅŸya Marketten AlÄ±ndÄ±: **"..itemData.name.. " " ..fromcount.. "x\n **Market Tipi: ** "..shopType.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					TriggerClientEvent("inventory:client:ItemBox",src,EsxItems[itemData.name],'add',fromcount)
					TriggerClientEvent("qb-inventory:close-inventory", src)
				else
					Player.removeMoney(price)
					Player.addInventoryItem(itemData.name, fromcount, toSlot, itemData.info)
					----exports["fizzfau-base"]:dclog(webhook.shop, "Envanter Log", "**EÅŸya Marketten AlÄ±ndÄ±: **"..itemData.name.. " " ..fromcount.. "x\n **Market Tipi: ** "..shopType.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
					TriggerClientEvent("inventory:client:ItemBox",src,EsxItems[itemData.name],'add',fromcount)
					TriggerClientEvent("qb-inventory:close-inventory", src)
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Yeterli nakitin yok!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end
		else
			if bankBalance >= price then
				Player.removeMoney(price)
				Player.addInventoryItem(itemData.name, fromcount, toSlot, itemData.info)
				----exports["fizzfau-base"]:dclog(webhook.shop, "Envanter Log", "**EÅŸya Marketten AlÄ±ndÄ±: **"..itemData.name.. " " ..fromcount.. "x\n **Market Tipi: ** "..shopType.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
				TriggerClientEvent("inventory:client:ItemBox",src,EsxItems[itemData.name],'add',fromcount)
			elseif bankBalance >= price then
				Player.removeMoney(price)
				Player.addInventoryItem(itemData.name, fromcount, toSlot, itemData.info)
				----exports["fizzfau-base"]:dclog(webhook.shop, "Envanter Log", "**EÅŸya Marketten AlÄ±ndÄ±: **"..itemData.name.. " " ..fromcount.. "x\n **Market Tipi: ** "..shopType.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
				TriggerClientEvent("inventory:client:ItemBox",src,EsxItems[itemData.name],'add',fromcount)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Yeterli nakitin yok!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end
		end
	elseif fromInventory == "crafting" then
		local itemData = Config.CraftingItems[fromSlot]
		if hasCraftItems(src, itemData.costs, fromcount) then
			TriggerClientEvent("inventory:client:CraftItems", src, itemData.name, itemData.costs, fromcount, toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli eşyalara sahip değilsin!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		end
	elseif fromInventory == "attachment_crafting" then
		local identifier = Player.identifier
			local itemData = Config.AttachmentCrafting[craftid[identifier]][fromSlot]
			if hasCraftItems(src, itemData.costs, fromcount) then
				TriggerClientEvent("inventory:client:CraftAttachment", src, itemData.name, itemData.costs, fromcount, toSlot, itemData.points)
			else
				TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli eşyalara sahip değilsin!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end
	
	elseif SplitStr(fromInventory, "-")[1] == "garbage" then
		local garbageId = 	fromInventory:sub(9)
		local toItemData = Garbages[garbageId].items[fromSlot]
		local essxItem = ESX.GetItems()
		if toItemData.name ~= nil then
			Player.addInventoryItem(toItemData.name, fromcount, toSlot, toItemData.info)
			RemoveFromGarbage(garbageId, fromSlot, toItemData.name, fromcount)
			TriggerClientEvent('inventory:client:ItemBox',src,essxItem[toItemData.name],'add',fromcount)
		end
		----exports["fizzfau-base"]:dclog(webhook.inventorygarbage, "Envanter Log", "**KiÅŸi Ã‡Ã¶p Topluyor: **"..toItemData.name.. " " ..fromcount.. "x\n **Koordinat: ** "..garbageId.."\n**EÅŸyayÄ± Alan: **" ..firstname.. " " ..lastname.. " \n **Discord Id:** " ..id.discord.. " \n **Identifier: **" ..id.license)
	else
		fromInventory = tonumber(fromInventory)
		if fromSlot == nil or fromInventory == nil then print("cylex_inventory :1015 nil cikti.") return end
		local fromItemData = Drops[fromInventory].items[fromSlot]
		local fromcount = tonumber(fromcount) ~= nil and tonumber(fromcount) or fromItemData.count
		if fromItemData ~= nil and fromItemData.count >= fromcount then
			local itemInfo = ESX.GetItems()[fromItemData.name:lower()]

			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.GetItemBySlot(toSlot)

				--Player.removeInventoryItem(fromItemData.name, fromcount, fromSlot)
				RemoveFromDrop(fromInventory, fromSlot, fromItemData.name, fromcount)
				if toItemData ~= nil then
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					--bÃ„Â±rakÃ„Â±lan slot
					 --slotun ÃƒÂ¶nceki yeri
					if toItemData.name ~= fromItemData.name then
						--print("2. yer")
						-- print("========siliniyor=======")
						-- print(toItemData.name, tocount, toSlot)
						Player.removeInventoryItem(toItemData.name, tocount, toSlot)
						-- print("=====================")

						-- print("========veriliyor=========")
						-- print(fromItemData.name, fromcount, toSlot)
						-- print("=====================")
						-- print(toItemData.name)
						AddToDrop(fromInventory, fromSlot, toItemData.name, tocount, toItemData.info)
						if itemInfo.name == "gps" then
							TriggerClientEvent('exelds:GPSStop', src)
						elseif itemInfo.name == 'radio' then
							TriggerClientEvent('sup_radio:close-radio', src)
						end
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2drop1", toName=toItemData.name, tocount=tocount, fromName=fromItemData.name, fromcount=fromcount, target=fromInventory})
						--TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** with item; name: **"..fromItemData.name.."**, count: **" .. fromcount .. "** - dropid: *" .. fromInventory .. "*")
					else
						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2drop3", name=toItemData.name, count=tocount, target=fromInventory})
						--TriggerEvent("qb-log:server:CreateLog", "drop", "Stacked Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) stacked item; name: **"..toItemData.name.."**, count: **" .. tocount .. "** - from dropid: *" .. fromInventory .. "*")
					end
				else
					--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="2drop2", name=fromItemData.name, count=fromcount, target=fromInventory})
					--TriggerEvent("qb-log:server:CreateLog", "drop", "Received Item", "green", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) reveived item; name: **"..fromItemData.name.."**, count: **" .. fromcount.. "** -  dropid: *" .. fromInventory .. "*")
				end
				-- Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
				-- return
				--Player.addInventoryItem(toItemData.name, tocount, toSlot, toItemData.info)
				--Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
				
				Player.addInventoryItem(fromItemData.name, fromcount, toSlot, fromItemData.info)
			else
				toInventory = tonumber(toInventory)
				local toItemData = Drops[toInventory].items[toSlot]
				RemoveFromDrop(fromInventory, fromSlot, itemInfo.name, fromcount)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
					--Player.PlayerData.items[fromSlot] = toItemData
					local tocount = tonumber(tocount) ~= nil and tonumber(tocount) or toItemData.count
					if toItemData.name ~= fromItemData.name then
						local itemInfo = ESX.GetItems()[tostring(toItemData.name)]
						RemoveFromDrop(toInventory, toSlot, itemInfo.name, tocount)
						AddToDrop(fromInventory, fromSlot, itemInfo.name, tocount, toItemData.info)
						if itemInfo.name == "gps" then
							TriggerClientEvent('exelds:GPSStop', src)
						elseif itemInfo.name == 'radio' then
							TriggerClientEvent('sup_radio:close-radio', src)
						end
					end
				else
					--Player.PlayerData.items[fromSlot] = nil
				end
				local itemInfo = ESX.GetItems()[tostring(fromItemData.name)]
				AddToDrop(toInventory, toSlot, itemInfo.name, fromcount, fromItemData.info)
				if itemInfo.name == "gps" then
					TriggerClientEvent('exelds:GPSStop', src)
				elseif itemInfo.name == 'radio' then
					TriggerClientEvent('sup_radio:close-radio', src)
				end
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Item yok??', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		end
	end
end)

function hasCraftItems(source, CostItems, count)
	local Player = ESX.GetPlayerFromId(source)
	for k, v in pairs(CostItems) do
		if Player.GetItemByName(k) ~= nil then
			if Player.GetItemByName(k).count < (v * count) then
				return false
			end
		else
			return false
		end
	end
	return true
end

RegisterServerEvent("inventory:refreshownedvehicles")
AddEventHandler("inventory:refreshownedvehicles",function(plate)
	local platess = plate:gsub(" ", "")
	local data = {
		plate = platess,
	}
	ownedcars[platess] = data
end)

MySQL.ready(function()
	while ESX == nil do; Citizen.Wait(0); end
	local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles")
		if (result[1] ~= nil) then
			for _, v in pairs(result) do
				local plates = v.plate:gsub(" ", "")
				ownedcars[plates] = v
			end
		end
end)

function IsVehicleOwned(plate)
	local val = false
	local plate = plate:gsub(" ", "")
	for _, v in pairs(ownedcars) do
		local plates = v.plate:gsub(" ", "")
		if plates == plate then
			val = true
			break
		end
	end
	return val

end

local function escape_str(s)
	local in_char  = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
	local out_char = {'\\', '"', '/',  'b',  'f',  'n',  'r',  't'}
	for i, c in ipairs(in_char) do
	  s = s:gsub(c, '\\' .. out_char[i])
	end
	return s
end

-- Shop Items
function SetupShopItems(shop, shopItems)
	local Player = ESX.GetPlayerFromId(source)
	local items = {}
	if shopItems ~= nil and next(shopItems) ~= nil then
		for k, item in pairs(shopItems) do
			local itemInfo = ESX.GetItems()[tostring(item.name)]
			items[item.slot] = {
				name = itemInfo.name,
				count = item.count,
				info = item.info ~= nil and item.info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				price = item.price,
				image = itemInfo.image,
				slot = item.slot,
			}
		end
	end
	return items
end



-- Stash Items
function GetStashItems(stashId)
	local Player = ESX.GetPlayerFromId(source)
	local items = {}
	-- local result = MySQL.Sync.fetchAll("SELECT * FROM `stashitemsnew` WHERE `stash` = '"..stashId.."'")
				-- if result[1] ~= nil then 
					-- if result[1].items ~= nil then
					if stashdata[stashId] ~= nil then
						stashh = json.decode(stashdata[stashId])
						for k, item in pairs(stashh) do
							local itemInfo = ESX.GetItems()[tostring(item.name)]
							items[item.slot] = {
								name = itemInfo.name,
								count = tonumber(item.count),
								info = item.info ~= nil and item.info or "",
								label = itemInfo.label,
								description = itemInfo.description ~= nil and itemInfo.description or "",
								weight = itemInfo.weight, 
								type = itemInfo.type, 
								unique = itemInfo.unique, 
								usable = itemInfo.usable, 
								image = itemInfo.image,
								slot = item.slot,
							}
						end
					end
					-- end
				-- end
	return items
end




function RemoveFromGarbage(garbageId, slot, itemName, count)
	local count = tonumber(count)
	if Garbages[garbageId].items[slot] ~= nil and Garbages[garbageId].items[slot].name == itemName then
		if Garbages[garbageId].items[slot].count > count then
			Garbages[garbageId].items[slot].count = Garbages[garbageId].items[slot].count - count
		else
			Garbages[garbageId].items[slot] = nil
			if next(Garbages[garbageId].items) == nil then
				Garbages[garbageId].items = {}
			end
		end
	else
		Garbages[garbageId].items[slot] = nil
		if Garbages[garbageId].items == nil then
			Garbages[garbageId].items[slot] = nil
		end
	end
end

ESX.RegisterServerCallback('qb-inventory:server:GetStashItems', function(source, cb, stashId)
	cb(GetStashItems(stashId))
end)

RegisterServerEvent('qb-inventory:server:SaveStashItems')
AddEventHandler('qb-inventory:server:SaveStashItems', function(stashId, items)
	stashdata[stashId] = json.encode(items)
	SaveResourceFile(GetCurrentResourceName(), "stash.json", json.encode(stashdata))
end)

function SaveStashItems(stashId, items)
	if Stashes[stashId].label ~= "Stash-None" then
		if items ~= nil then
			for slot, item in pairs(items) do
				item.description = nil
			end
			stashdata[stashId] = json.encode(items)
			SaveResourceFile(GetCurrentResourceName(), "stash.json", json.encode(stashdata))
			Stashes[stashId].isOpen = false
		end
	end
end

function AddToStash(stashId, slot, otherslot, itemName, count, info)
	local count = tonumber(count)
	local Player = ESX.GetPlayerFromId(source)
	local ItemData = ESX.GetItems()[tostring(itemName)]
	if not ItemData.unique then
		if Stashes[stashId].items[slot] ~= nil and Stashes[stashId].items[slot].name == itemName then
			Stashes[stashId].items[slot].count = Stashes[stashId].items[slot].count + count
		else
			local itemInfo = ESX.GetItems()[tostring(itemName)]
			Stashes[stashId].items[slot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = slot,
			}
		end
	else
		if Stashes[stashId].items[slot] ~= nil and Stashes[stashId].items[slot].name == itemName then
			local itemInfo = ESX.GetItems()[tostring(itemName)]
			Stashes[stashId].items[otherslot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = otherslot,
			}
		else
			local itemInfo = ESX.GetItems()[tostring(itemName)]
			Stashes[stashId].items[slot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = slot,
			}
		end
	end
	--// Sonradan eklemeler 
	if itemName == 'cash' then
		TriggerClientEvent('esx:onremoveMoney', source, count)
	end
end

function RemoveFromStash(stashId, slot, itemName, count)
	local count = tonumber(count)
	if Stashes[stashId].items[slot] ~= nil and Stashes[stashId].items[slot].name == itemName then
		if Stashes[stashId].items[slot].count > count then
			Stashes[stashId].items[slot].count = Stashes[stashId].items[slot].count - count
		else
			Stashes[stashId].items[slot] = nil
			if next(Stashes[stashId].items) == nil then
				Stashes[stashId].items = {}
			end
		end
	else
		Stashes[stashId].items[slot] = nil
		if Stashes[stashId].items == nil then
			Stashes[stashId].items[slot] = nil
		end
	end
	--// Sonradan eklemeler 
	if itemName == 'cash' then
		TriggerClientEvent('esx:onaddMoney', source, count)
	end
end

-- Trunk items
function GetOwnedVehicleItems(plate)
	local Player = ESX.GetPlayerFromId(source)
	local items = {}

		if trunkdata[plate] ~= nil then
				trunkitemss = json.decode(trunkdata[plate])
				for k, item in pairs(trunkitemss) do
					local itemInfo = ESX.GetItems()[tostring(item.name)]
					items[item.slot] = {
						name = itemInfo.name,
						count = tonumber(item.count),
						info = item.info ~= nil and item.info or "",
						label = itemInfo.label,
						description = itemInfo.description ~= nil and itemInfo.description or "",
						weight = itemInfo.weight, 
						type = itemInfo.type, 
						unique = itemInfo.unique, 
						usable = itemInfo.usable, 
						image = itemInfo.image,
						slot = item.slot,
					}
				end
			end
	return items
end

function SaveOwnedVehicleItems(plate, items)
    if Trunks[plate].label ~= "Trunk-None" then
        if items ~= nil then
            for slot, item in pairs(items) do
                item.description = nil
            end

			trunkdata[plate] = json.encode(items)
			SaveResourceFile(GetCurrentResourceName(), "trunk.json", json.encode(trunkdata))
			Trunks[plate].isOpen = false
        end
    end
end

function AddToTrunk(plate, slot, otherslot, itemName, count, info)
	local Player = ESX.GetPlayerFromId(source)
	local count = tonumber(count)
	local ItemData =  ESX.GetItems()[tostring(itemName)]

	if not ItemData.unique then
		if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
			Trunks[plate].items[slot].count = Trunks[plate].items[slot].count + count
		else
			local itemInfo = ESX.GetItems()[tostring(itemName)]
			Trunks[plate].items[slot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = slot,
			}
		end
	else
		if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
			local itemInfo = ESX.GetItems()[tostring(itemName)]
			Trunks[plate].items[otherslot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = otherslot,
			}
		else
			local itemInfo = ESX.GetItems()[tostring(itemName)]
			Trunks[plate].items[slot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = slot,
			}
		end
	end
	--// Sonradan eklemeler 
	if itemName == 'cash' then
		TriggerClientEvent('esx:onremoveMoney', source, count)
	end
end

function RemoveFromTrunk(plate, slot, itemName, count)
	if Trunks[plate].items[slot] ~= nil and Trunks[plate].items[slot].name == itemName then
		if Trunks[plate].items[slot].count > count then
			Trunks[plate].items[slot].count = Trunks[plate].items[slot].count - count
		else
			Trunks[plate].items[slot] = nil
			if next(Trunks[plate].items) == nil then
				Trunks[plate].items = {}
			end
		end
	else
		Trunks[plate].items[slot]= nil
		if Trunks[plate].items == nil then
			Trunks[plate].items[slot] = nil
		end
	end
	--// Sonradan eklemeler 
	if itemName == 'cash' then
		TriggerClientEvent('esx:onaddMoney', source, count)
	end
end

-- Glovebox items
function GetOwnedVehicleGloveboxItems(plate)
	local Player = ESX.GetPlayerFromId(source)
	local items = {}
		if gloveboxdata[plate] ~= nil then
			gloveboxitemss = json.decode(gloveboxdata[plate])
			for k, item in pairs(gloveboxitemss) do
				local itemInfo = ESX.GetItems()[tostring(item.name)]
				items[item.slot] = {
					name = itemInfo.name,
					count = tonumber(item.count),
					info = item.info ~= nil and item.info or "",
					label = itemInfo.label,
					description = itemInfo.description ~= nil and itemInfo.description or "",
					weight = itemInfo.weight, 
					type = itemInfo.type, 
					unique = itemInfo.unique, 
					usable = itemInfo.usable, 
					image = itemInfo.image,
					slot = item.slot,
				}
			end
		end
	return items
end

function SaveOwnedGloveboxItems(plate, items)
	if Gloveboxes[plate].label ~= "Glovebox-None" then
		if items ~= nil then
			for slot, item in pairs(items) do
				item.description = nil
			end

			gloveboxdata[plate] = json.encode(items)
			SaveResourceFile(GetCurrentResourceName(), "glovebox.json", json.encode(gloveboxdata))
			Gloveboxes[plate].isOpen = false
		end
	end
end



function AddToGlovebox(plate, slot, otherslot, itemName, count, info)
	local Player = ESX.GetPlayerFromId(source)
	local count = tonumber(count)
	local ItemData = ESX.GetItems()[tostring(itemName)]

	if not ItemData.unique then
		if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
			Gloveboxes[plate].items[slot].count = Gloveboxes[plate].items[slot].count + count
		else
			local itemInfo =  ESX.GetItems()[tostring(itemName)]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = slot,
			}
		end
	else
		if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
			local itemInfo =  ESX.GetItems()[tostring(itemName)]
			Gloveboxes[plate].items[otherslot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = otherslot,
			}
		else
			local itemInfo =  ESX.GetItems()[tostring(itemName)]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo.name,
				count = count,
				info = info ~= nil and info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = slot,
			}
		end
	end
	--// Sonradan eklemeler 
	if itemName == 'cash' then
		TriggerClientEvent('esx:onremoveMoney', source, count)
	end
end

function RemoveFromGlovebox(plate, slot, itemName, count)
	if Gloveboxes[plate].items[slot] ~= nil and Gloveboxes[plate].items[slot].name == itemName then
		if Gloveboxes[plate].items[slot].count > count then
			Gloveboxes[plate].items[slot].count = Gloveboxes[plate].items[slot].count - count
		else
			Gloveboxes[plate].items[slot] = nil
			if next(Gloveboxes[plate].items) == nil then
				Gloveboxes[plate].items = {}
			end
		end
	else
		Gloveboxes[plate].items[slot]= nil
		if Gloveboxes[plate].items == nil then
			Gloveboxes[plate].items[slot] = nil
		end
	end
	--// Sonradan eklemeler 
	if itemName == 'cash' then
		TriggerClientEvent('esx:onaddMoney', source, count)
	end
end

ESX.RegisterServerCallback('garbage:ac',function(source,cb,garbageId)
	if Garbages[garbageId] ~= nil then
		cb(Garbages[garbageId].items)
	else
		local items = {}
			for k, item in pairs(Config.GarbageItems) do
				local itemInfo = ESX.GetItems()[tostring(item.name)]
				local random = math.random(#Config.GarbageItems)
				items[random] = {
				name = itemInfo.name,
				count = tonumber(item.count),
				info = item.info ~= nil and item.info or "",
				label = itemInfo.label,
				description = itemInfo.description ~= nil and itemInfo.description or "",
				weight = itemInfo.weight, 
				type = itemInfo.type, 
				unique = itemInfo.unique, 
				usable = itemInfo.usable, 
				image = itemInfo.image,
				slot = random,
				}
			end
			Garbages[garbageId] = {}
			Garbages[garbageId].items = items
		cb(items)
	end
end)



-- Drop items
function AddToDrop(dropId, slot, itemName, count, info)
	local Player = ESX.GetPlayerFromId(source)
	local count = tonumber(count)
	if Drops[dropId].items[slot] ~= nil and Drops[dropId].items[slot].name == itemName then
		Drops[dropId].items[slot].count = Drops[dropId].items[slot].count + count
	else
		local itemInfo = ESX.GetItems()[tostring(itemName)]
		Drops[dropId].items[slot] = {
			name = itemInfo.name,
			count = count,
			info = info ~= nil and info or "",
			label = itemInfo.label,
			description = itemInfo.description ~= nil and itemInfo.description or "",
			weight = itemInfo.weight, 
			type = itemInfo.type, 
			unique = itemInfo.unique, 
			usable = itemInfo.usable, 
			image = itemInfo.image,
			slot = slot,
			id = dropId,
		}
	end
	--// Sonradan eklenmeler
	if itemName == 'cash' then
		TriggerClientEvent('esx:onremoveMoney', source, count)
	-- elseif itemName == 'wallet' then
	-- 	print(count)
	end
	TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()[itemName],'remove', count)
end

function RemoveFromDrop(dropId, slot, itemName, count)

	if Drops[dropId].items[slot] ~= nil and Drops[dropId].items[slot].name == itemName then
		if Drops[dropId].items[slot].count > count then
			Drops[dropId].items[slot].count = Drops[dropId].items[slot].count - count
		else
			Drops[dropId].items[slot] = nil
			if Drops[dropId].items == nil then
				Drops[dropId].items = {}
				--TriggerClientEvent("inventory:client:RemoveDropItem", -1, dropId)
			end
		end
	else
		Drops[dropId].items[slot] = nil
		if Drops[dropId].items == nil then
			Drops[dropId].items[slot] = nil
			--TriggerClientEvent("inventory:client:RemoveDropItem", -1, dropId)
		end
	end
	--// Sonradan eklemeler
	if itemName == 'cash' then
		TriggerClientEvent('esx:onaddMoney', source, count)
	end
	TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()[itemName],'add', count)
end

function CreateDropId()
	if Drops ~= nil then
		local id = math.random(10000, 99999)
		local dropid = id
		while Drops[dropid] ~= nil do
			id = math.random(10000, 99999)
			dropid = id
		end
		return dropid
	else
		local id = math.random(10000, 99999)
		local dropid = id
		return dropid
	end
end

function CreateNewDrop(source, fromSlot, toSlot, itemcount)
	local Player = ESX.GetPlayerFromId(source)
	local itemData = Player.GetItemBySlot(fromSlot)
	local player = GetPlayerPed(source)
	local coord = GetEntityCoords(player)
	

	if Player.removeInventoryItem(itemData.name, itemcount, itemData.slot) then
		TriggerClientEvent("inventory:client:CheckWeapon", source, itemData.name)
		local itemInfo =   ESX.GetItems()[tostring(itemData.name)]
		local dropId = CreateDropId()
		TriggerClientEvent('inventory:client:ItemBox', source, ESX.GetItems()[itemData.name],'remove', itemcount)
		Drops[dropId] = {}
		Drops[dropId].items = {}

		Drops[dropId].items[toSlot] = {
			name = itemInfo.name,
			count = itemcount,
			info = itemData.info ~= nil and itemData.info or "",
			label = itemInfo.label,
			description = itemInfo.description ~= nil and itemInfo.description or "",
			weight = itemInfo.weight, 
			type = itemInfo.type, 
			unique = itemInfo.unique, 
			usable = itemInfo.usable, 
			image = itemInfo.image,
			slot = toSlot,
			id = dropId,
		}

		TriggerClientEvent("inventory:client:DropItemAnim", source)
		TriggerClientEvent("inventory:client:AddDropItem", -1, dropId, coord, source)
		if itemData.name == "gps" then
			TriggerClientEvent('exelds:GPSStop', source)
		elseif itemData.name == 'radio' then
			TriggerClientEvent('sup_radio:close-radio', source)
		elseif itemData.name == 'cash' then
			TriggerClientEvent('esx:onremoveMoney', source, itemcount)
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bu esyaya sahip degilsin!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		return
	end
end

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

RandomStr = function(length)
	if length > 0 then
		return RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

RandomInt = function(length)
	if length > 0 then
		return RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

SplitStr = function(str, delimiter)
	local result = { }
	local from  = 1
	local delim_from, delim_to = string.find( str, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( str, from , delim_from-1 ) )
		from  = delim_to + 1
		delim_from, delim_to = string.find( str, delimiter, from  )
	end
	table.insert( result, string.sub( str, from  ) )
	return result
end


CreateThread(function()
    local result = json.decode(LoadResourceFile(GetCurrentResourceName(), "glovebox.json"))
	local result2 = json.decode(LoadResourceFile(GetCurrentResourceName(), "trunk.json"))
	local result3 = json.decode(LoadResourceFile(GetCurrentResourceName(), "stash.json"))

    if result then
        gloveboxdata = result
    end

	if result2 then
		trunkdata = result2
	end

	if result3 then
		stashdata = result3
	end
end)