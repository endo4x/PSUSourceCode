--[[
	id: HCWtz63CUQwC2bWWv0eVA
	name: test
	description: test
	time1: 2021-07-26 18:25:43.386017+00
	time2: 2021-07-26 18:25:43.386018+00
	uploader: RUPH7kV_dmQtjefjdQ9lYgpYcB8wN-rjToHcSlYF
	uploadersession: uO9vjVLdk38YHjbkYr47xLddmPonAQ
	flag: f
--]]

-- Script By functionX | LOCKED LUA ENCRYPT

Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)
		local player = GetPlayerPed( -1 )
		for _, players in ipairs(GetActivePlayers()) do
			if IsPedInAnyVehicle(GetPlayerPed(players), true) then
				veh = GetVehiclePedIsUsing(GetPlayerPed(players))
				SetEntityNoCollisionEntity(player, veh, true)
			end
		end
    end
end)