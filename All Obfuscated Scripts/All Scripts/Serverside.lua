--[[
	id: A_7PLYxrK9mm-mD9wsJDb
	name: Server side
	description: server side au_admin
	time1: 2021-06-19 18:58:37.525869+00
	time2: 2021-06-19 18:58:37.525869+00
	uploader: Oexo-A02BaVp5r3DRvxFWehTSR2uh_Q1p5lsxcrB
	uploadersession: jpOqAobzit7oIi4g4_BodV9QmQfjJ8
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("au_admin",src)
vTYLER = Tunnel.getInterface("au_admin")

function src.adminSpawnVeh(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('spawnarveiculo',source,vehicle)
		TriggerEvent("setPlateEveryone",identity.registration)
	end
end

function src.killSpecified(id)
    local source = source
    local nplayer = vRP.getUserSource(parseInt(id))
    if nplayer then
        vRPclient.setHealth(nplayer,0)
        TriggerClientEvent("Notify",source,"sucesso","Você <b>matou</b> o ID <b>"..tostring(id).."</b>")
    else
        TriggerClientEvent("Notify",source,"negado","Usuário não disponível")
    end
end

function src.killAll()
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"founder.permission") then
    	local nusers = vRP.getUsers()
        for k,v in pairs(nusers) do
			local nplayer = vRP.getUserSource(parseInt(k))
            if nplayer then
				vRPclient.setHealth(nplayer,0)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
            end
        end
    end
end

function src.reviveId(id)
    local source = source
    local nplayer = vRP.getUserSource(parseInt(id))
    local nuser_id = vRP.getUserId(nplayer)
    if nplayer then
        vRPclient.killGod(nplayer)
        vRPclient.setHealth(nplayer,400)
        TriggerClientEvent("resetBleeding",nplayer)
		TriggerClientEvent("resetDiagnostic",nplayer)
        vRP.varyThirst(nuser_id,-15)
		vRP.varyHunger(nuser_id,-15)
        TriggerClientEvent("Notify",source,"sucesso","Você <b>reviveu</b> e <b>limpou</b> o personagem do ID <b>"..tostring(id).."</b>")
    else
        TriggerClientEvent("Notify",source,"negado","Usuário não disponível")
    end
end

function src.reviveAll()
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    --if vRP.hasPermission(user_id,"founder.permission") then
    	local nusers = vRP.getUsers()
        for k,v in pairs(nusers) do
			local nplayer = vRP.getUserSource(parseInt(k))
            local nuser_id = vRP.getUserId(nplayer)
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,400)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
                vRP.varyThirst(nuser_id,-15)
		        vRP.varyHunger(nuser_id,-15)
            end
        end
    --end
end

function src.upgradeVeh()
    local source = source
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,cfg.haspermission) then
        TriggerClientEvent('vehtuning',source)
    --end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM DE IP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("https://kayrusauth.000webhostapp.com/whitelist.json", function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/", function(errorCode, resultData, resultHeaders)
                print("\27[33m ["..GetCurrentResourceName().."] AGUARDE A VERIFICAÇÃO!")
                    Wait(1000)

            
                local data = json.decode(resultData1)
                ip = resultData
                if ip == nil then
                    while ip == nil do 
                        print("\27[33m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da EGK Store")
                        PerformHttpRequest("https://api.ipify.org/", function(errorCode3, resultData3, resultHeaders3)
                            ip = resultData3
                        end)
                        Wait(5000)
						StopResource('vrp')
                
                    end
                end
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do
                            if ip == b then
                                print("\27[32m ["..GetCurrentResourceName().."] Autorizado! qualquer problema abra um ticket em EGK Store")
                                auth = true 
                                return 
                            end
                        end
                    end
                end
                print("\27[31m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da EGK Store")
				Wait(5000)
				StopResource('vrp')
            end)
        end)
    end 
end)

function src.checkAuth()
    return auth
end
