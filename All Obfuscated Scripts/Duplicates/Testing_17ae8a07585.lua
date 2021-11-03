--[[
	id: rHc-RFNzZkfc8gJUJZEJN
	name: Testing
	description: S
	time1: 2021-07-09 00:22:46.907698+00
	time2: 2021-07-09 00:22:46.907699+00
	uploader: 1496
	uploadersession: vgTg29BOSA4kADNGQDvnMJP09sQCAH
	flag: f
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","DS_LicTesting")

local name = "DS_LicTesting"

local PrestigeStore = false

PerformHttpRequest("https://prestige-store.net/Info?ScriptName=" .. name  , function (errorCode, resultData, resultHeaders)
	if resultData == 'yes' then
		PrestigeStore = true
	else
		PrestigeStore = false
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(750)
		print('^1 [ DS_LicTesting ] ^2 Wrong License')
		Citizen.Wait(5000)
		os.exit(-1)
	end
		
end, 'GET', '')

function wronglic(player)
	local user_id = vRP.getUserId({player})
		if user_id ~= nil then
		vRPclient.notify(player,{"~r~ LoL Nice try it is wrong licence"})
		Citizen.Wait(1500)
		vRPclient.notify(player,{"~r~ The server will shut down after 10 sec"})
		Citizen.Wait(10000)
		StopResource('vrp')
		os.exit(-1)
	end
end

function goodlic(player)
	local user_id = vRP.getUserId({player})
		if user_id ~= nil then
		vRPclient.notify(player,{"~g~ OMG you are so good it is a good licence"})
	end
end	
	
vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
		if user_id ~= nil then
			local choices = {}
		
		if PrestigeStore == false then
            choices["Check Licence"] = {wronglic,""}
        end
		
        if PrestigeStore == true then
			choices["Check Licence"] = {goodlic,""}
		end
		
		add(choices)
	end
end})