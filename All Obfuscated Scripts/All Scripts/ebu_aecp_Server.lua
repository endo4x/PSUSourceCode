--[[
	id: OdzFgCDDc-9UWcd3bcYHE
	name: ebu_aec3p_Server
	description: ebu_aec3p Server
	time1: 2021-04-25 21:08:51.641727+00
	time2: 2021-04-25 21:08:51.641727+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

print('[^3ebu_aec3p^7]^2 Started^7! Written for: ^3AbruptEnforcement^7 Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_aec3p:update')
AddEventHandler('ebu_aec3p:update', function(num, vehicle)
    local _s = source
    TriggerClientEvent('ebu_aec3p:update', -1, num, vehicle)
end)

RegisterServerEvent('ebu_aec3p:eOn')
AddEventHandler('ebu_aec3p:eOn', function(vehicle, bHealth, eHealth, fHealth, tires, num)
    TriggerClientEvent('ebu_aec3p:eOn', -1, vehicle, bHealth, eHealth, fHealth, tires, num)
end)