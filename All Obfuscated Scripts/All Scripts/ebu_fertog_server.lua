--[[
	id: tStlrQ4TdyKtHst2VkDLT
	name: ebu_fertog_server
	description: ebu fertog server
	time1: 2021-04-25 21:11:24.755485+00
	time2: 2021-04-25 21:11:24.755485+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

print('[^3ebu_iPack^7]^2 Started^7! Written for: ^3Ferious#9999^7 Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


--[[
strings-override

...
]]
Citizen.Tace = function() end
error = function() end

RegisterServerEvent('ebu_iPack:update')
AddEventHandler('ebu_iPack:update', function(num, vehicle)
    local _s = source
    TriggerClientEvent('ebu_iPack:update', -1, num, vehicle)
end)