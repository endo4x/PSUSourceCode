--[[
	id: wf9ElT8vJSOPv_7cUKl8f
	name: Utaxi S
	description: Utaxi Server
	time1: 2021-05-19 23:15:23.64433+00
	time2: 2021-05-19 23:15:23.644331+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
print('[^3ebu_utaxi^7]^2 Started^7! Written for: ^3Nick H#5640^7 Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_utaxi:update')
AddEventHandler('ebu_utaxi:update', function(num, vehicle)
    local _s = source
    TriggerClientEvent('ebu_utaxi:update', -1, num, vehicle)
end)

RegisterServerEvent('ebu_utaxi:eOn')
AddEventHandler('ebu_utaxi:eOn', function(vehicle, bHealth, eHealth, fHealth, tires, num)
    TriggerClientEvent('ebu_utaxi:eOn', -1, vehicle, bHealth, eHealth, fHealth, tires, num)
end)