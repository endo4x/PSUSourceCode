--[[
	id: o98E1-8_E_OeuU020CSkL
	name: server-pizza
	description: server-pizza
	time1: 2021-06-11 13:58:35.953404+00
	time2: 2021-06-11 13:58:35.953404+00
	uploader: CPUG6VTvptq0yUHZMqFjxaXUceBN5FGMrRUsQ6ST
	uploadersession: ViA8IomNgnZ5bOlTCpE1Puo4WP439R
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
feijontsPizza = {}
Tunnel.bindInterface("feijonts_pizza",feijontsPizza)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookpizza = "https://discord.com/api/webhooks/812750999844028416/OUyDDUWhtiRWzB6_rUPdLyoswIRkcAXik6lHo_QkJT_DtRlpSMOkdnYkUb5pmXZHnXDN"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function feijontsPizza.gerarRecompensa()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		randmoney = math.random(1200,1500)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
		SendWebhookMessage(webhookpizza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GANHOU NA PIZZA]: $"..randmoney.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		return true
	end
end