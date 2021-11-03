--[[
	id: SBgnO7uhNXjwZX4mMPdB5
	name: C20 Server
	description: Vinny - C20 Server
	time1: 2021-05-17 17:11:15.631278+00
	time2: 2021-05-17 17:11:15.631278+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
print('[^3ebu_c20^7]^2 Started^7! Written for:^3 Vinny#2133^7. Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_c20:updateTrailer')
AddEventHandler('ebu_c20:updateTrailer', function(type, num, vehicle, status)
    TriggerClientEvent('ebu_c20:updateTrailer', -1, type, num, vehicle, status)
end)