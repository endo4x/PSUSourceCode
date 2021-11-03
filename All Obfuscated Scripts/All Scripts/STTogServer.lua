--[[
	id: Cq2Iiox23ifqw7xjuNFk2
	name: STTog Server
	description: Speedtech Server
	time1: 2021-05-06 22:29:14.205178+00
	time2: 2021-05-06 22:29:14.205178+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

print('[^3ebu_STTog^7]^2 Started^7! Written for: ^3Mcgarret#2384^7 pack. Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_STTog:update')
AddEventHandler('ebu_STTog:update', function(num, vehicle)
    local _s = source
    TriggerClientEvent('ebu_STTog:update', -1, num, vehicle)
end)

RegisterServerEvent('ebu_STTog:eOn')
AddEventHandler('ebu_STTog:eOn', function(vehicle, bHealth, eHealth, fHealth, tires, num)
    TriggerClientEvent('ebu_STTog:eOn', -1, vehicle, bHealth, eHealth, fHealth, tires, num)
end)
