--[[
	id: 8V7PkJy5MUSFEGGdXoH1f
	name: Checking
	description: Test 
	time1: 2021-06-10 21:43:13.899991+00
	time2: 2021-06-10 21:43:13.899993+00
	uploader: rwoIAc3eIWORlPkbvRDtu4Ip0JKNzlFu2cvuBxsg
	uploadersession: JmA-jCU35FyZMNpf6ENmf_L5C283Kh
	flag: f
--]]

local kmh = 3.6
local mph = 2.23693629
local carspeed = 0
-----------------
--   E D I T   --
-----------------
local driftmode = true -- on/off speed
local speed = kmh -- or mph
local drift_speed_limit = 100.0 
local toggle = 118 -- Numpad 9

-- Thread
Citizen.CreateThread(function()

	while true do

		Citizen.Wait(1)

		if IsControlJustPressed(1, 118) then

			driftmode = not driftmode

			if driftmode then
				exports['mythic_notify']:SendAlert('success', 'Drift ON')
			else
				exports['mythic_notify']:SendAlert('error', 'Drift OFF')
			end
		end

		if driftmode then

			if IsPedInAnyVehicle(GetPed(), false) then

				CarSpeed = GetEntitySpeed(GetCar()) * speed

				if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then

					if CarSpeed <= drift_speed_limit then  

						if IsControlPressed(1, 21) then
		
							SetVehicleReduceGrip(GetCar(), true)
		
						else
		
							SetVehicleReduceGrip(GetCar(), false)
		
						end
					end
				end
			end
		end
	end
end)


-- Function
function GetPed() return GetPlayerPed(-1) end
function GetCar() return GetVehiclePedIsIn(GetPlayerPed(-1),false) end