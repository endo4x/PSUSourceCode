--[[
	id: BU_AsUzujrhR7CzZ_G6jH
	name: EAY6 Traffic S
	description: EAY6 Traffic Server
	time1: 2021-05-17 17:45:49.878886+00
	time2: 2021-05-17 17:45:49.878887+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
print('[^3ebu_eay6_traffic^7]^2 Started^7! Written for: ^3Paul Modifications^7 pack. Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_eay6_traffic:update')
AddEventHandler('ebu_eay6_traffic:update', function(num, vehicle)
    local _s = source
    TriggerClientEvent('ebu_eay6_traffic:update', -1, num, vehicle)
end)

RegisterServerEvent('ebu_eay6_traffic:eOn')
AddEventHandler('ebu_eay6_traffic:eOn', function(vehicle, bHealth, eHealth, fHealth, tires, num)
    TriggerClientEvent('ebu_eay6_traffic:eOn', -1, vehicle, bHealth, eHealth, fHealth, tires, num)
end)
