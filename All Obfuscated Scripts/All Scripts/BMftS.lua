--[[
	id: yvahZtBD8xSPjTG7ool1e
	name: BM20ft S
	description: BM20ft Server
	time1: 2021-05-19 23:36:26.681715+00
	time2: 2021-05-19 23:36:26.681716+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
print('[^3ebu_bm20ft^7]^2 Started^7! Written for: ^3BananaDan#1738^7 Visit ^5Theebu\'s Scripts: https://discord.gg/SvxZj2h ^7for more scripts!')

RegisterServerEvent('ebu_bm20ft:updateTrailer')
AddEventHandler('ebu_bm20ft:updateTrailer', function(type, num, vehicle, status)
    TriggerClientEvent('ebu_bm20ft:updateTrailer', -1, type, num, vehicle, status)
end)