--[[
	id: mtC0omTxyikgFNk0Etn_I
	name: FOF150 Server
	description: FOF150 Server (Lucky)
	time1: 2021-05-13 14:12:25.95457+00
	time2: 2021-05-13 14:12:25.954571+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
print('[^3ebu_fof150^7]^2 Started^7! Written for: ^3Lucky™#8907^7. Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_fof150:update')
AddEventHandler('ebu_fof150:update', function(num, vehicle)
    local _s = source
    TriggerClientEvent('ebu_fof150:update', -1, num, vehicle)
end)

RegisterServerEvent('ebu_fof150:eOn')
AddEventHandler('ebu_fof150:eOn', function(vehicle, bHealth, eHealth, fHealth, tires, num)
    TriggerClientEvent('ebu_fof150:eOn', -1, vehicle, bHealth, eHealth, fHealth, tires, num)
end)
