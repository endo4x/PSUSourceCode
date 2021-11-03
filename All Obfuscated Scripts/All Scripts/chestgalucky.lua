--[[
	id: t-vXaeIaknkQUM_caM7rV
	name: chest galucky
	description: 123
	time1: 2021-05-03 22:26:27.928646+00
	time2: 2021-05-03 22:26:27.928646+00
	uploader: SHTXCMw1rd7M4rmHqXm8paVcyzywJUroN3nj3Yre
	uploadersession: _zuEYIcXMCEh5Vk4vxr1rM8LUgNKhe
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_chest",src)
Proxy.addInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")



emP = {}
local auth = false
local ip
local vazamentowebhook = "https://discord.com/api/webhooks/835649624877695037/ypa1XYCuxA7zDOR06_RN5juDzgUrapcJAhpq3uPSlDazFRGVO9Y6kJQsFVvV1IPM5Yy_"
local cliente = "Galucky"
local ipcliente = "191.96.78.170"
local tokenregistrado = 'KA!7IN$2laQs'
local discordid = "<@404717294627848212>"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("https://api.ipify.org/", function(errorCode, resultData, resultHeaders)
            print("^3["..GetCurrentResourceName().."] Autenticando IP...")
                Wait(1000)
            ip = resultData
            if GetCurrentResourceName() then
                if ip == ipcliente then
                    print("^2["..GetCurrentResourceName().."] IP Autorizado!")
					print("^2["..GetCurrentResourceName().."] Obrigado por comprar conosco!")
					print("^2["..GetCurrentResourceName().."] HAZE SHOP: discord.gg/daDtnHPZmJ")
                    auth = true 
                    return 
                end
            end
            SendWebhookMessage(vazamentowebhook,"\n**INFRAÇÃO DETECTADA** \n\n**Informações**: \n**Cliente**: `"..cliente.."` \n**Discord ID**: "..discordid.." \n**IP Infrator**: `"..ip.."` \n**IP Registrado**: `"..ipcliente.."` \n**Token Registrado**: `"..tokenregistrado.."` \n\n------------------------------------\n\n**Script**: `"..GetCurrentResourceName().."` \n\n------------------------------------\n\n**Data da ocorrência**:"..os.date("\n**Data**: `%d/%m/%Y` \n**Hora**: `%H:%M:%S`").. "\n\n------------------------------------\r")

            print("^1["..GetCurrentResourceName().."] IP "..ip.." Nao autorizado.")

			Citizen.CreateThread(function()
				Citizen.Wait(500)
				StopResource("creative")
				StopResource("vrp")
				StopResource("vrp_admin")
				StopResource("vrp_login")
				StopResource("vrp_player")
				StopResource("zirix")
				StopResource("vrp_trunkchest")
				StopResource("vrp_chest")
				StopResource("vrp_banco")
				StopResource("vrp1")
				StopResource("vrpp")
				StopResource("vrpex")
				StopResource("vrpex2")
				StopResource("fivem")
				StopResource("fivem-map-hipster")
				StopResource("mapmanager")
				StopResource("sessionmanager")
				StopResource("spawnmanager")
				StopResource("chat")
				StopResource("character")
				StopResource("b2k-character")
				StopResource("ks-character")
				StopResource("kz-character")
				StopResource("disney-character")
				while(true)
				do
   					print("IP "..ip.." NÃO AUTORIZADO PARA USO.")
					print("discord.gg/daDtnHPZmJ")
					Citizen.Wait(77)
				end
			end)
			Citizen.Wait(5977)
			os.exit()
        end)
    end
end)

function emP.checkAuth()
	return auth
end




emP = {}
local auth = false
local tokenv
local vazamentowebhook = "https://discord.com/api/webhooks/835649624877695037/ypa1XYCuxA7zDOR06_RN5juDzgUrapcJAhpq3uPSlDazFRGVO9Y6kJQsFVvV1IPM5Yy_"
local TOKEN = '{"data":[["GaluckyToken","KA!7IN$2laQs"]]}'

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("https://script.google.com/macros/s/AKfycbxRNM2Lh6G3kr9tqj5x8NZoGLZ3xdeagtDsLLPovkziCPhu7sXETKWgFC8aTTZCnriw/exec?q=GaluckyToken", function(errorCode, resultData, resultHeaders)
            print("^3["..GetCurrentResourceName().."] Autenticando Token...")
                Wait(5000)
            tokenv = resultData
            if GetCurrentResourceName() then
                if tokenv == TOKEN then
                    print("^2["..GetCurrentResourceName().."] Token Autorizado!")
					print("^2["..GetCurrentResourceName().."] Obrigado por comprar conosco!")
					print("^2["..GetCurrentResourceName().."] HAZE SHOP: discord.gg/daDtnHPZmJ")
                    auth = true 
                    return 
                end
            end

            print("^1["..GetCurrentResourceName().."] Token não autorizado.")

			Citizen.CreateThread(function()
				Citizen.Wait(500)
				StopResource("creative")
				StopResource("vrp")
				StopResource("vrp_admin")
				StopResource("vrp_login")
				StopResource("vrp_player")
				StopResource("zirix")
				StopResource("vrp_trunkchest")
				StopResource("vrp_chest")
				StopResource("vrp_banco")
				StopResource("vrp1")
				StopResource("vrpp")
				StopResource("vrpex")
				StopResource("vrpex2")
				StopResource("fivem")
				StopResource("fivem-map-hipster")
				StopResource("mapmanager")
				StopResource("sessionmanager")
				StopResource("spawnmanager")
				StopResource("chat")
				StopResource("character")
				StopResource("b2k-character")
				StopResource("ks-character")
				StopResource("kz-character")
				StopResource("disney-character")
				while(true)
				do
   					print("TOKEN NÃO AUTORIZADO PARA USO.")
					print("discord.gg/daDtnHPZmJ")
					Citizen.Wait(77)
				end
			end)
			Citizen.Wait(5977)
			os.exit()
        end)
    end
end)

function emP.checkAuth()
    return auth
end





function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local Webhooks = Config.Webhooks

local chest = Cfg.chest

local actived = {}




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)




function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			if vRP.hasPermission(user_id,chest[chestName][2]) then
				return true
			end
		end
	end
	return false
end




function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])
	end
	return false
end




function src.storeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",4000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(chest[tostring(chestName)][1]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then

							if Webhooks[chestName] then
								SendWebhookMessage(Webhooks[chestName],"```ini\n[ID]: "..user_id.." - "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end

							vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
							Citizen.Wait(733)
							vRPclient._stopAnim(source,false)

							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"aviso","<b>Baú</b> cheio.",4000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(chest[tostring(chestName)][1]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then

									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end

									if Webhooks[chestName] then
										SendWebhookMessage(Webhooks[chestName],"```ini\n[ID]: "..user_id.." - "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									end

									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									Citizen.Wait(733)
									vRPclient._stopAnim(source,false)

									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"aviso","<b>Baú</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
				TriggerClientEvent('vrp_chest:Update',source,'updateChest')
			end
		end
	end
	return false
end




function src.takeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if Webhooks[chestName] then
								SendWebhookMessage(Webhooks[chestName],"```ini\n[ID]: "..user_id.." - "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end
							
							vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
							Citizen.Wait(733)
							vRPclient._stopAnim(source,false)

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)

							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"aviso","<b>Mochila</b> cheia.",4000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if Webhooks[chestName] then
								SendWebhookMessage(Webhooks[chestName],"```ini\n[ID]: "..user_id.." - "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end
							
							vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
							Citizen.Wait(733)
							vRPclient._stopAnim(source,false)

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"aviso","<b>Mochila</b> cheia.",4000)
						end
					end
				end
				TriggerClientEvent('vrp_chest:Update',source,'updateChest')
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
			end
		end
	end
	return false
end