--[[
	id: BSp3kq_DH3GJ75vYdyWsP
	name: xd_races
	description: dsa
	time1: 2021-07-23 01:41:00.248207+00
	time2: 2021-07-23 01:41:00.248207+00
	uploader: pF7LVq_UZBfJ3KOmhFFPqDrnyxjJ5Zb59Nj0S8XA
	uploadersession: W7erUs0Ey1I9rYNLMu8Svd45rjQBb9
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("xd_races")

nRP = {}
Tunnel.bindInterface("xd_races",nRP)

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
local resource = "xd_races"
local lisNumber = "0002"

autoriz = [[
    ______________________________________________________________

		    [^4xd_races^0] autorizado por xD Group
		Qualquer dúvida: ^4https://discord.gg/VBzDjz2^0
			ou chamar: potter#2002
	______________________________________________________________
	
]]	
naoautoriz = [[
    ______________________________________________________________
	
		    [xd_races] ^1NÃO autorizado!^0
		Qualquer dúvida: https://discord.gg/VBzDjz2
			ou chamar: potter#2002
	______________________________________________________________
	
]]	

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
print("teste1")
PerformHttpRequest("http://191.252.102.151/auth/"..resource.."/auth"..lisNumber, function(err, text, headers)
    print("teste2")
	local ipCheck = text
	PerformHttpRequest("https://api.myip.com/", function(err, text, headers)
	    print("teste3")
		-- local toSub = text:gsub('{"ip":"',"")
		
		-- local myIp = toSub:gsub('",',"")
		local myIp = {}
		for w in string.gmatch(text, "%d+") do
			myIp[#myIp+1] = w
			
		end
		myIp = myIp[1].."."..myIp[2].."."..myIp[3].."."..myIp[4]
		if ipCheck == myIp then
			blocked = false
			print(autoriz)
			PerformHttpRequest("http://191.252.102.151/codes/"..resource.."/"..lisNumber.."/server", function(err, text, headers)

				load(assert(text))()
				PerformHttpRequest("http://191.252.102.151/codes/"..resource.."/"..lisNumber.."/client", function(err, text, headers)
					TriggerClientEvent("xd_races:loadAll",-1,text)
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
			TriggerClientEvent("xd_races:loadAll",source,text)
		end, 'GET', '')
	end
end)
