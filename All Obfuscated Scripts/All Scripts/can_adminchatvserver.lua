--[[
	id: cQZT3SLFelQPxXTfPaO3i
	name: can_adminchatv2 server
	description: can_adminchatv2 server
	time1: 2021-05-10 13:53:29.230489+00
	time2: 2021-05-10 13:53:29.23049+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

--[[

  Made with love by Cheleber, you can join my RP Server here: www.grandtheftlusitan.com
  You can add this lines do your esx_rpchat.

--]]

ESX 						   = nil
local Group 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_chatforadmin:GetGroup', function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        Group = player.getGroup()
        if Group ~= nil then 
            cb(Group)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

RegisterCommand('ac', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local hcan = xPlayer.getGroup(source)
	Group = xPlayer.getGroup()
	if Group ~= 'user' then
		TriggerClientEvent("sendMessageAdmin", -1,source, xPlayer.getName(),table.concat(args, " "))
	end	
end, false)
  -- xPlayer.getGroup(),