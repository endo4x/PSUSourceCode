--[[
	id: TwhnQmtwpV-_dTJqXUnCD
	name: KuwaitCity_RAKANCTO
	description: KuwaitCity_RAKANCTO
	time1: 2021-05-21 05:02:32.726359+00
	time2: 2021-05-21 05:02:32.726359+00
	uploader: 338
	uploadersession: M6JI_ewz98DfnVAErszqbtsD8vvcSc
	flag: f
--]]

PerformHttpRequest("https://api.ipify.org/", function (err, text, head)
        Citizen.Wait(400)
        if text == "45.137.71.32" then
			print("^7==================================== Rakan_CTO By Rakan#3431 ====================================")
			print("^7==================================== Rakan_CTO By Rakan#3431 ====================================")
			print("^7==================================== Rakan_CTO By Rakan#3431 ====================================")
        else
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			print("^7==================================== RAKAN_CTO ISN'T WORKING !!!!!!!!!!!!!!!!!! ====================================")
			Citizen.Wait(3000)
			StopResource(GetCurrentResourceName())
        end
end, 'GET', '')


RegisterServerEvent("CTO")
AddEventHandler("CTO", function()
	ping = GetPlayerPing(source)
	playername = GetPlayerName(source)
	Citizen.Wait(5000)
	if ping == "-1" then
		DropPlayer(source, "Disconnected . (1)")
		print("^6----------------------------------------------------------------\n^6"..playername.." Disconnected Because (MQIQF)\n^5BY Rakan#3431\n^6----------------------------------------------------------------\n")
	end
end)
