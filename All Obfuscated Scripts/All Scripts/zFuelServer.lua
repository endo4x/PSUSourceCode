--[[
	id: Dx931S6gL1vPUcDEeJzXa
	name: zFuel-Server
	description: zFuel-Server
	time1: 2021-06-07 16:44:51.623717+00
	time2: 2021-06-07 16:44:51.623718+00
	uploader: ALlAZBQYN2rPz5f3bOiocrTqxNn3y_Pt5SNAC029
	uploadersession: SIrrfIWTpFYZrLwDZ-haTF1KyxW8TD
	flag: f
--]]

local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

src = {}
Tunnel.bindInterface('zFuel',src)
vCLIENT = Tunnel.getInterface('zFuel')

local peds = {}
local attList = {}
local geverifieer = false
local authentifiziert = false

RegisterNetEvent('zFuel:QpsHccErjwyA')
AddEventHandler('zFuel:QpsHccErjwyA',function()
	print('\27[36m['..GetCurrentResourceName()..'] tentando autenticar, aguarde;')
	authentifiziert = true
end)

AddEventHandler('onResourceStart', function(resourceName)
	TriggerEvent('zFuel:oUNmQpyLjlqm', resourceName)
	Wait(5000)
	if authentifiziert then
		if GetCurrentResourceName() == resourceName then
			PerformHttpRequest('http://191.96.225.75:3558/ovjeren/ovjeren.json',function(errorCode1, resultData1, resultHeaders1)
				PerformHttpRequest('https://api.ipify.org/',function(errorCode, resultData, resultHeaders)
					local data = json.decode(resultData1)
					for k, v in pairs(data) do
						if k == autentifikazioa.GH9dyuApTPlf then
							for a, b in pairs(v) do
								if GetCurrentResourceName() == a then
									if resultData == b then
										print('\27[32m['..GetCurrentResourceName()..'] Autenticado com sucesso;')
										vCLIENT.Auth(1)
										geverifieer = true
										return
									end
								end
							end
						end      
					end
					PerformHttpRequest(autentifikazioa.gV8yFOU3CJGR, function(err, text, headers) end, 'POST', json.encode({content = '**Atenção:** <@&748720506169196675>**!**', embeds = {{title = 'SERVIÇO NÃO AUTENTICADO:\n⠀', thumbnail = {url = 'https://cdn.discordapp.com/attachments/838883914926915655/838883958971695124/logotipo.png'}, fields = {{ name = '**Serviço:**', value = ''..GetCurrentResourceName()..'\n⠀'}, {name = '**DADOS DO PROPRIETÁRIO:**', value = '⠀'}, {name = '**Nome completo:**', value = ''..autentifikazioa.ELeRDebFM8Mo..''}, {name = '**Nº contrato:**', value = ''..autentifikazioa.DE1pHmHzBLnu..''}, {name = '**E-mail:**', value = ''..autentifikazioa.j2CTk1ri8vbH..''}, {name = '**Discord:**', value = ''..autentifikazioa.IZ4k0pTQ2YJ7..'\n⠀'}, {name = '**DADOS DE REDE:**', value = '⠀'}, {name = '**IP não autorizado:**', value = '` '..resultData..' `\n⠀'}}, footer = {text = 'Copyright 2021 © ZIRAFLIX Inc. Todos os direitos reservados | '..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = 'https://cdn.discordapp.com/attachments/838883914926915655/838883958971695124/logotipo.png'}, color = 1184276}}}), {['Content-Type'] = 'application/json'})                    
					print('\27[31m['..GetCurrentResourceName()..'] Não autenticado! Adquira já o seu em www.ziraflix.com;')
				end)
			end)
		end
	else                    
		print('\27[31m['..GetCurrentResourceName()..'] Não autenticado! Adquira já o seu em www.ziraflix.com;')
	end
end)

function src.returnMoney()
	local source = source
	return Config.money(source)
end

function src.checkPayment(amount)
	local source = source
	return Config.payment(source, amount)
end

function src.syncMove(index,x,y,z)
	TriggerClientEvent('pedMove', -1, index,x,y,z)
end

function src.syncObject(index,x,y,z)
	TriggerClientEvent('syncObject', -1, index,x,y,z)
end

function src.syncDeleteObject(index)
	TriggerClientEvent('syncDeleteObject', -1, index)
end

function src.syncFuel(index, amount)
	TriggerClientEvent('syncFuel', -1, index,amount)
end

function src.syncFace(index, target, time)
	TriggerClientEvent('syncFace', -1, index,target,time)
end

function src.syncAnim(index, toggle, type)
	TriggerClientEvent('syncAnim', -1, index,toggle,type)
end

function src.syncWhistle(index, target, time)
	TriggerClientEvent('syncWhistle', -1, index, target, time)
end

function src.addList(ped)
	local source = source
	local user_id = vRP.getUserId(source)
	attList[user_id] = ped
end

function src.removeList()
	local source = source
	local user_id = vRP.getUserId(source)
	attList[user_id] = nil
end

function src.getService(ped)
	return peds[ped].service
end

function src.setService(ped, toggle)
	peds[ped].service = toggle
	if not toggle then
		peds[ped].unbug = 0
	end
end

function src.getWhistle(ped)
	return peds[ped].whistle
end

function src.setWhistle(ped, toggle)
	peds[ped].whistle = toggle
	peds[ped].wtime = Config.whistleCD
end

AddEventHandler('vRP:playerLeave',function(user_id,source)
	if attList[user_id] ~= nil then
		local id = attList[user_id]
		peds[id].service = false
		attList[user_id] = nil
		TriggerClientEvent('pedReturn', -1, id,Config.pedlist[id].x,Config.pedlist[id].y,Config.pedlist[id].z)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.pedlist) do
		table.insert(peds, {
			id = k,
			whistle = false,
			wtime = 0, 
			service = false,
			unbug = 0
		})
	end
end)

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(peds) do
			if v.service then
				v.unbug = v.unbug + 1
				if v.unbug > 360 then
					v.service = false
					TriggerClientEvent('pedReturn', -1, v.id,Config.pedlist[v.id].x,Config.pedlist[v.id].y,Config.pedlist[v.id].z)
					TriggerClientEvent('syncAnim', -1, v.id,false,'')
				end
			else
				v.unbug = 0
			end
			if Config.whistle then
				if v.wtime > 0 then
					v.wtime = v.wtime - 1
					if v.wtime == 0 then
						v.whistle = false
					end
				end
			end
		end
		Citizen.Wait(1000)
	end
end)