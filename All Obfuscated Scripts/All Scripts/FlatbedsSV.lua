--[[
	id: EZ2Gqbty0ENowLYBwUEAP
	name: Flatbeds S V2
	description: Ebu Auth Flatbeds
	time1: 2021-06-03 01:09:12.280994+00
	time2: 2021-06-03 01:09:12.280995+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local license_key = Config.license_key
local license_key2 = Config.license_key2 or ''
local script = 'ebu_flatbeds'

Citizen.Tace = function() end
error = function() end

PerformHttpRequest("74.91.121.153/verify.txt", function (errorCode, resultData, resultHeaders)
    if errorCode == 200 then
      assert(load("local script  = '"..script.."';".. resultData))()
    else
      print('^1'..script..' - Unable to reach auth server - Error : '..errorCode..'^0')
    end
  end)
  
  RegisterServerEvent('ebu:updateTrailer')
  AddEventHandler('ebu:updateTrailer', function(type, num, vehicle, status)
      TriggerClientEvent('ebu:updateTrailer', -1, type, num, vehicle, status)
  end)

RegisterServerEvent('ebu_flatbeds:connectRopes')
AddEventHandler('ebu_flatbeds:connectRopes', function(truck, winchBone, loadCar)
    TriggerClientEvent("ebu_flatbed:connectRopes", -1, truck, winchBone, loadCar)
end)

RegisterServerEvent('ebu_flatbeds:deleteWind')
AddEventHandler('ebu_flatbeds:deleteWind', function(ropeInt)
    TriggerClientEvent("ebu_flatbeds:deleteWind", -1, ropeInt)
end)

RegisterServerEvent('ebu_flatbeds:windRope')
AddEventHandler('ebu_flatbeds:windRope', function(ropeInt)
    TriggerClientEvent("ebu_flatbeds:windRope", -1, ropeInt)
end)

RegisterServerEvent('ebu_flatbeds:unwindRope')
AddEventHandler('ebu_flatbeds:unwindRope', function(ropeInt)
    TriggerClientEvent("ebu_flatbeds:unwindRope", -1, ropeInt)
end)