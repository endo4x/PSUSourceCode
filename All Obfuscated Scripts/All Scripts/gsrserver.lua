--[[
	id: Lu97Fw5TbI2wV4gSOfprZ
	name: gsr-server
	description: This is Server.lua for GSR
	time1: 2021-05-26 22:24:26.433675+00
	time2: 2021-05-26 22:24:26.433676+00
	uploader: Hm0CQXSn_h2AlUpdKgA7rdKUeFqoGBfGgKovtaqN
	uploadersession: SVAc5l4ljl6nKaJBAwZf5HX9zIZkpo
	flag: f
--]]

RegisterNetEvent("gsr:doTest")
AddEventHandler("gsr:doTest", function(target)
	local src = source
	TriggerClientEvent('gsr:requestGSR', target, src)	
end)

RegisterNetEvent("gsr:returnGSR")
AddEventHandler("gsr:returnGSR", function(shotRecently, policeId)
	local src = source
	local result = '~r~NEGATIVE'
	if shotRecently then result = '~g~POSITIVE'; end
	TriggerClientEvent('notify', policeId, "The GSR Test has returned "..result)
end)