--[[
	id: 0lUyk6n7PJreVGHJKBHvI
	name: ebu_nbike C
	description: ebu_nbike C
	time1: 2021-06-25 13:01:58.771581+00
	time2: 2021-06-25 13:01:58.771581+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
print('[^3ebu_nbike^7]^2 Started^7! Written for: ^3Nick_#1381^7 Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')

RegisterServerEvent('ebu_nbike:update')
AddEventHandler('ebu_nbike:update', function(unloadPos)
    local src = source
	TriggerClientEvent('ebu_nbike:actorupdate', src, unloadPos)
end)