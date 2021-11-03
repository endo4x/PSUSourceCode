--[[
	id: pr6edEwEVqsso9iGRPNzd
	name: can_adminchatv2 client
	description: can_adminchatv2 client
	time1: 2021-05-10 13:51:38.140823+00
	time2: 2021-05-10 13:51:38.140824+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

--[[

  Made with love by Cheleber, you can join my RP Server here: www.grandtheftlusitan.com
  You can add this lines do your esx_rpchat.

--]]

local UserGroup

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('sendMessageAdmin')
AddEventHandler('sendMessageAdmin', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
	-- local canid = GetPlayerGroup(PlayerId())
	ESX.TriggerServerCallback('esx_chatforadmin:GetGroup', function(Group)
		UserGroup = Group
		if pid == myId then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " [YETKİLİ] | " .. name .."  "..":^0  " .. message)
			-- TriggerEvent('chatMessage', "", {255, 0, 0}, " [ ".. Group .." ] ^2  ^0" .. name .." "..":^0  " .. message)
			-- TriggerEvent('chatMessage', "", {255, 0, 0}, "^0" .. name .." "..":^0  " .. message)

		elseif UserGroup ~= 'user' and pid ~= myId then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " [YETKİLİ] | " .. name .."  "..":^0  " .. message)
			-- TriggerEvent('chatMessage', "", {255, 0, 0}, " [ ".. Group .." ] ^2  ^0" .. name .." "..":^0  " .. message)
			-- TriggerEvent('chatMessage', "", {255, 0, 0}, "^0" .. name .." "..":^0  " .. message)


		end
  end)
end)


