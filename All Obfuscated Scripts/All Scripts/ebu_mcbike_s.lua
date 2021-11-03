--[[
	id: yukwe3IaGsIX4XzKOhcPN
	name: ebu_mcbike_s
	description: Mcgarret bike server
	time1: 2021-04-28 17:37:51.243191+00
	time2: 2021-04-28 17:37:51.243192+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

print('[^3ebu_mcbike^7]^2 Started^7! Written for: ^3Mcgarret#2384^7 Visit ^5https://discord.gg/SvxZj2h ^7for more scripts!')


RegisterServerEvent('ebu_mcbike:update')
AddEventHandler('ebu_mcbike:update', function(coords)
    local _s = source
    TriggerClientEvent('ebu_mcbike:actorupdate', _s, coords)
end)