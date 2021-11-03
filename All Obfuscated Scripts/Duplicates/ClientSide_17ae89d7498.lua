--[[
	id: r6dnOlIHUNPOvhtedw306
	name: Client Side
	description: Client Side
	time1: 2021-05-23 21:26:56.123571+00
	time2: 2021-05-23 21:26:56.123571+00
	uploader: upmaKftPebf1aacTSUlrUVzIhYdYC6Nowa8t9ti2
	uploadersession: res167k3kt5XoYHIb4FdWDI5eEUNQn
	flag: f
--]]

local noclip = false
local noclip_speed = 1.0
local noclipEntity

function admin_no_clip()
	noclip = not noclip
	local ped = GetPlayerPed(-1)
	if noclip then
		notification("Noclip ~g~geactiveerd")
	else
		SetEntityVisible(ped, true, false)
		notification("Noclip ~r~gedeactiveerd")
		local noclip_speed = 1.0
		local ped = PlayerPedId()
		local inVehicle = IsPedInAnyVehicle( ped, false )

		if IsPedInAnyVehicle(PlayerPedId(), false) then
			noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
			print(noclipEntity)
			SetEntityVisible(noclipEntity, true, 0)
		else
			noclipEntity = PlayerPedId()
		end

		SetEntityCollision(noclipEntity, not noclip, not noclip)
		FreezeEntityPosition(noclipEntity, noclip)
		SetEntityInvincible(noclipEntity, noclip)
		SetVehicleRadioEnabled(noclipEntity, not noclip)
	end
end

function isNoclip()
	return noclip
end

function getPosition()
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	return x,y,z
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)

	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end

	return x,y,z
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if noclip then
			local ped = GetPlayerPed(-1)
			local x,y,z = getPosition()
			local dx,dy,dz = getCamDirection()
			local speed = noclip_speed

			SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
			SetEntityRotation( ped, 0, 0, 0, 0, false )

			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped, false) then
                noclipEntity = GetVehiclePedIsIn(ped, false)
            else
                noclipEntity = ped
            end

            SetEntityCollision(noclipEntity, not noclip, not noclip)
            FreezeEntityPosition(noclipEntity, noclip)
			SetEntityVisible(noclipEntity, false, false)
            SetVehicleRadioEnabled(noclipEntity, not noclip) -- [[Stop radio from appearing when going upwards.]]

			if IsControlPressed(0,32) then
				x = x+speed*dx
				y = y+speed*dy
				z = z+speed*dz
			end

			if IsControlPressed(0, 21) then
				noclip_speed = 6.0
			else
				noclip_speed = 1.0
			end
			
			
		if IsControlPressed(0,269) then
				x = x-speed*dx
				y = y-speed*dy
				z = z-speed*dz
		end

		SetEntityCoordsNoOffset(noclipEntity,x,y,z,true,true,true)
		end
	end
end)

RegisterNetEvent("ebbecore:noclip")
AddEventHandler("ebbecore:noclip", function()
	admin_no_clip()
end)

function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

RegisterCommand("noclip", function(source, args, rawCommand)
    TriggerEvent("ebbecore:noclip")
end, true)