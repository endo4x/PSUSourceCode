--[[
	id: WM4kyUNSuyP-dFg7RbaVT
	name: LG Diamond tri S
	description: LG Diamond tri Server
	time1: 2021-05-17 16:40:14.645894+00
	time2: 2021-05-17 16:40:14.645894+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
print('[^3ebu_diatri^7]^2 Started^7! Written for: ^3BenjiJewell#0639^7. Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_diatri:updateTrailer')
AddEventHandler('ebu_diatri:updateTrailer', function(type, num, vehicle, status)
    TriggerClientEvent('ebu_diatri:updateTrailer', -1, type, num, vehicle, status)
end)