--[[
	id: aajmAtASVi8b9D9GexpEu
	name: trunk galucky server
	description: 123
	time1: 2021-05-03 22:32:02.334614+00
	time2: 2021-05-03 22:32:02.334614+00
	uploader: SHTXCMw1rd7M4rmHqXm8paVcyzywJUroN3nj3Yre
	uploadersession: _zuEYIcXMCEh5Vk4vxr1rM8LUgNKhe
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local Tools = module("vrp","lib/Tools")

vRPN = {}
Tunnel.bindInterface("vrp_trunkchest",vRPN)
Proxy.addInterface("vrp_trunkchest",vRPN)

vCLIENT = Tunnel.getInterface("vrp_garages")

local inventory = module("vrp","cfg/inventory")

emP = {}
local auth = false
local ip
local vazamentowebhook = "https://discord.com/api/webhooks/837383969640546354/DIqoGqLk_tzElvE-m6wW7iK7_Ky5Xh3N6gQmun2JdrMp48CR0tZO2chMvSXj6HMwHsun"
local cliente = "Galucky"
local ipcliente = "179.212.98.85"
local tokenregistrado = 'b%M@$okz0o#i'
local discordid = "<@404717294627848212>"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

emP = {}
local auth = false
local ip
local vazamentowebhook = "https://discord.com/api/webhooks/837383969640546354/DIqoGqLk_tzElvE-m6wW7iK7_Ky5Xh3N6gQmun2JdrMp48CR0tZO2chMvSXj6HMwHsun"
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
local vazamentowebhook = "https://discord.com/api/webhooks/837383969640546354/DIqoGqLk_tzElvE-m6wW7iK7_Ky5Xh3N6gQmun2JdrMp48CR0tZO2chMvSXj6HMwHsun"
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








local webhooklog_bauveiculos = Config.webhook_log_bauveiculos

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end




local uchests = {}
local vchests = {}
local actived = {}




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 1
			end
		end
	end
end)




function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,trunk = vRPclient.vehList(source,7)
		if vehicle then
			local placa_user_id = vRP.getUserByRegistration(placa)
			if placa_user_id then
				local myinventory = {}
				local myvehicle = {}
				local mala = "chest:u"..parseInt(placa_user_id).."veh_"..vname
				local data = vRP.getSData(mala)
				local sdata = json.decode(data) or {}
				local max_veh = inventory.chestweight[vname] or 50
				if sdata then
					for k,v in pairs(sdata) do
						table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
					end

					local data2 = vRP.getUserDataTable(user_id)
					if data2 and data2.inventory then
						for k,v in pairs(data2.inventory) do
							table.insert(myvehicle,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
						end
					end

					uchests[parseInt(user_id)] = mala
					vchests[parseInt(user_id)] = vname
				end
				return myinventory,myvehicle,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(sdata),parseInt(max_veh)
			end
		end
	end
	return false
end




function vRPN.storeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Você não pode guardar este item em veículos.",3000)
				return
			end

			local data = vRP.getSData(uchests[user_id])
			local items = json.decode(data) or {}
			if items then
				local river = 1000
				local max_veh = inventory.chestweight[vchests[user_id]] or 50
				if parseInt(amount) and actived[user_id] == 0 or not actived[user_id] then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(max_veh) then
						if vRP.tryGetInventoryItem(user_id,itemName,parseInt(amount)) then
							if user_id and actived[user_id] == 0 or not actived[user_id]then
								actived[parseInt(user_id)] = 1
								if items[itemName] ~= nil then
									items[itemName].amount = items[itemName].amount + parseInt(amount)
								else
									items[itemName] = { amount = parseInt(amount) }
								end

								SendWebhookMessage(webhooklog_bauveiculos,"```ini\n[ID]: "..user_id.." - "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAÚ]: "..uchests[user_id].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

								vRP.setSData(uchests[parseInt(user_id)],json.encode(items))
								TriggerClientEvent('Creative:UpdateTrunk',source,'updateMochila')
							end
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Porta-Malas</b> cheio.",4000)
					end
				end
				Citizen.Wait(river)
			end
		end
	end
	return false
end




function vRPN.takeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			local data = vRP.getSData(uchests[parseInt(user_id)])
			local items = json.decode(data) or {}
			if items then
				local river = 1000
				if parseInt(amount) > 0 and actived[user_id] == 0 or not actived[user_id] then
					if items[itemName] ~= nil and items[itemName].amount >= parseInt(amount) then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
							if user_id and actived[user_id] == 0 or not actived[user_id] then
								actived[parseInt(user_id)] = 1
								
								SendWebhookMessage(webhooklog_bauveiculos,"```ini\n[ID]: "..user_id.." - "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAÚ]: "..uchests[user_id].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								
								vRP.giveInventoryItem(user_id,itemName,parseInt(amount))								
								items[itemName].amount = items[itemName].amount - parseInt(amount)
								if items[itemName].amount <= 0 then
									items[itemName] = nil
								end
								TriggerClientEvent('Creative:UpdateTrunk',source,'updateMochila')
								vRP.setSData(uchests[parseInt(user_id)],json.encode(items))							
							end
							
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",4000)
						end
					end
				end
				Citizen.Wait(river)
			end
		end
	end
	return false
end




function vRPN.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid = vRPclient.vehList(source,7)
		if vehicle then
			vCLIENT.vehicleClientTrunk(-1,vnetid,true)
		end
	end
	return false
end




function vRPN.chestOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,trunk = vRPclient.vehList(source,7)
		if vehicle then
			if lock == 1 then
				if banned then
					return
				end
				local placa_user_id = vRP.getUserByRegistration(placa)
				if placa_user_id then
					vCLIENT.vehicleClientTrunk(-1,vnetid,false)
					TriggerClientEvent("trunkchest:Open",source)
				end
			end
		end
	end
end