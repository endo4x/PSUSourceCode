--[[
	id: 427-oc2R0QOpEdReLFKAD
	name: Can Emlak - Server
	description: Can Emlak - Server
	time1: 2021-04-29 23:03:41.688531+00
	time2: 2021-04-29 23:03:41.688532+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('can:parakontrol')
AddEventHandler('can:parakontrol', function(miktar)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
local para = xPlayer.getAccount('black_money').money

if para >= miktar then
local yuzde = miktar / Config.Yuzde
xPlayer.removeAccountMoney('black_money', miktar)
xPlayer.addMoney(yuzde)
-- xPlayer.giveitem
else
	TriggerClientEvent('notification', src, 'Üstünde bu kadar kara para yok!', 2)
end
end)