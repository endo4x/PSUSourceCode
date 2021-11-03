--[[
	id: gK9Zpqr9IXxXf9SUcFQhV
	name: server-lixeiro
	description: server-lixeiro
	time1: 2021-06-11 13:55:18.339672+00
	time2: 2021-06-11 13:55:18.339673+00
	uploader: CPUG6VTvptq0yUHZMqFjxaXUceBN5FGMrRUsQ6ST
	uploadersession: ViA8IomNgnZ5bOlTCpE1Puo4WP439R
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emp = {}
Tunnel.bindInterface("feijonts_lixeiro",emp)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooklixeiro = "https://discord.com/api/webhooks/812749520537911368/90_6Y8ilbCv93fUyPj3K2kc_f0djw4G0kkshP093cECbRBPsh_vGjdsUa4tMDRz-0CyB"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function emp.GerarRecompensa(bonus)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if user_id then
        local money = math.random(25000,30000)
        vRP.giveMoney(user_id,parseInt(money))
        TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voçê recebeu $"..money.." dólares")
		SendWebhookMessage(webhooklixeiro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GANHOU NO LIXEIRO]: $"..money.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    end
end