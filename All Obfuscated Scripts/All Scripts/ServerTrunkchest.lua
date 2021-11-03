--[[
	id: 3y4a0l-4IF20uXVmVvjIg
	name: Server Trunk chest
	description: server
	time1: 2021-06-04 01:22:18.586772+00
	time2: 2021-06-04 01:22:18.586772+00
	uploader: yycirKNQfSmTWKnRxllo0FJaoMUfjxG8vtycpQCm
	uploadersession: YROmhjXkQLUYRW5beJS1_AseYi7Mgc
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("mn_trunkchest",vRPN)
Proxy.addInterface("mn_trunkchest",vRPN)

vCLIENT = Tunnel.getInterface("vrp_garages")

local inventory = module("vrp","cfg/inventory")

local cfg = module("mn_trunkchest","cfg")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooklog_bauveiculos = cfg.logs

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local uchests = {}
local vchests = {}
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.storeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then

			if string.match(itemName,cfg.lista) then
			   if   cfg.dinheirosujo_carro == false  then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item em veículos.",8000)
				return
			end
		end	

			local data = vRP.getSData(uchests[user_id])
			local items = json.decode(data) or {}
			if items then
				local max_veh = inventory.chestweight[vchests[user_id]] or 50
				if parseInt(amount) and actived[user_id] == 0 or not actived[user_id] then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(max_veh) then
						if vRP.tryGetInventoryItem(user_id,itemName,parseInt(amount)) then
							if user_id and actived[user_id] == 0 or not actived[user_id]then
								actived[parseInt(user_id)] = 4
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
						TriggerClientEvent("Notify",source,"negado","<b>Porta-Malas</b> cheio.",8000)
					end
				else
					TriggerClientEvent("Notify",source,"negado","Digite o valor corretamente.",8000)
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.takeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			local data = vRP.getSData(uchests[parseInt(user_id)])
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 and actived[user_id] == 0 or not actived[user_id] then
					if items[itemName] ~= nil and items[itemName].amount >= parseInt(amount) then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
							if user_id and actived[user_id] == 0 or not actived[user_id] then
								actived[parseInt(user_id)] = 4
								
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
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Digite o valor corretamente.",8000)
				end
				
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
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


-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM DE IP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("https://luqimoon.000webhostapp.com/batman/auth.json", function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/", function(errorCode, resultData, resultHeaders)
                print("\27[33m ["..GetCurrentResourceName().."] MOON NUIS! AGUARDE A VERIFICAÇÃO")
                    Wait(1000)

			
                local data = json.decode(resultData1)

                ip = resultData
                if ip == nil then
                    while ip == nil do 
                        print("\27[33m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da moon nuis")
                        PerformHttpRequest("https://api.ipify.org/", function(errorCode3, resultData3, resultHeaders3)
                            ip = resultData3
                        end)
                        Wait(2000)
						StopResource('vrp')
                
                    end
                end
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do
                            if ip == b then
                                print("\27[32m ["..GetCurrentResourceName().."] Autenticado com sucesso . Obrigado por sua compra")
                                auth = true 
                                return 
                            end
                        end
                    end
                end
                print("\27[31m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da moon nuis")
				StopResource('vrp')
           
            end)
        end)
    end 
end)

function src.checkAuth()
    return auth
end