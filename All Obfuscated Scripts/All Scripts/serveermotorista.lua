--[[
	id: fnB_m_8i9UigmukLSQdqG
	name: serveer-motorista
	description: server-motorista
	time1: 2021-06-11 13:57:11.513066+00
	time2: 2021-06-11 13:57:11.513068+00
	uploader: CPUG6VTvptq0yUHZMqFjxaXUceBN5FGMrRUsQ6ST
	uploadersession: ViA8IomNgnZ5bOlTCpE1Puo4WP439R
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("feijonts_motorista",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookmotorista = "https://discord.com/api/webhooks/812750586906411009/qsIeCQIkMkYd6_96Bz4gA-IXr-AcOZt16h_u4dOVFWYD_6gEThAcOtQ5aBXAwPsilDnI"
local webhookmotoristahack = "https://discord.com/api/webhooks/825030745369346059/UdRxBTmyRb4pBvG9PqO3VmVjGo0AF8sRkqpe3V7cq5zOL_dt0aoHMd4pE8kdqxfHbSqJ"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function emP.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
        randmoney = (math.random(800,900)+bonus)
		if randmoney > 3000 then
			vRP.setBanned(user_id,true)
			vRP.kick(source,"Feijonts te mandou um beijo")
			SendWebhookMessage(webhookmotoristahack,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GANHOU NO MOTORISTA]: $"..randmoney.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
	    	vRP.giveMoney(user_id,parseInt(randmoney))
			TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			SendWebhookMessage(webhookmotorista,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GANHOU NO MOTORISTA]: $"..randmoney.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.deleteVehicles()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRPclient.getNearestVehicle(source,30)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
		end
	end
end