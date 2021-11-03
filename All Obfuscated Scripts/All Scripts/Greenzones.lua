--[[
	id: aiuNJJtEFuiHrB2bDTpMb
	name: Greenzones
	description: Greenzones
	time1: 2021-06-26 17:51:43.512036+00
	time2: 2021-06-26 17:51:43.512037+00
	uploader: Mx2VVlbAlz0EXGKqXkDv_vnJyY1-1hWKvifwu6if
	uploadersession: 9Lo26w2_H8CLQC1dPe-1NVAxRhJEV_
	flag: f
--]]

local inside_zone = false

local greenzones = Config.Greenzones

local function ShowInfo(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(true, false)
end

Citizen.CreateThread(function()
  while true do
    local playerPed = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(playerPed, false)
    for k, v in pairs(greenzones) do
      local location = vector3(v.location.x, v.location.y, v.location.z)
      if #(plyCoords - location) < (v.diameter) - (v.diameter / 150) then
        if (not inside_zone) then
          local temp_append = ""
          ShowInfo("You are ~r~not allowed~w~ to do any ~r~violent~w~ or ~r~illegal~w~ roleplay in this area.")
          inside_zone = true
          if (v.customrestrictions.enabled and v.customrestrictions.loop == false) then
            Config.Greenzones[k].customrestrictions.run(v)
          end
        end
        -- Enforce Restrictions.
        if (v.restrictions.blockattack) then
          SetEntityCanBeDamaged(playerPed, false)
          SetPlayerCanDoDriveBy(playerPed, false)
          DisablePlayerFiring(playerPed, true)
          DisableControlAction(0, 140) -- Melee R
        end
        if (v.restrictions.speedlimit ~= nil and tonumber(v.restrictions.speedlimit)) then
          SetEntityMaxSpeed(GetVehiclePedIsIn(playerPed, false), tonumber(v.restrictions.speedlimit) / 2.237)
        end
        if (v.customrestrictions.enabled and v.customrestrictions.loop == true) then
          Config.Greenzones[k].customrestrictions.run(v)
        end
      elseif (inside_zone) then
        -- Remove Restrictions.
        -- The reason why we do inside_zone == true is so that if the first if statement fails,
        -- We can restore the normal functions outside of the zone without looping through this constantly.

        -- Since the natives used to restrict attacks are called per frame, we don't need to put anything here to reset that.
        ShowInfo("You are ~g~allowed~w~ to do any ~g~violent~w~ or ~g~illegal~w~ roleplay in this area.")

        SetEntityCanBeDamaged(playerPed, true)
        SetEntityMaxSpeed(GetVehiclePedIsIn(playerPed, false), 99999.9)

        -- NOTE: This doesn't increase the speed of vehicles.
        -- This only removes the cap/speedlimit that was applied while inside the restricted zone.

        Config.Greenzones[k].customrestrictions.stop(v)

        inside_zone = false

      end
    end
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do
    local playerPed = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(playerPed, false)
    for k, v in pairs(greenzones) do
      local location = vector3(v.location.x, v.location.y, v.location.z)
      if #(plyCoords - location) < (v.diameter) - (v.diameter / 150) then
        DrawMarker(28, v.location.x, v.location.y, v.location.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, 0, 0, 0, 0, 0)
      elseif (#(plyCoords - location) < (v.diameter) - (v.diameter / 150) + v.visabilitydistance) then
        DrawMarker(28, v.location.x, v.location.y, v.location.z, 0, 0, 0, 0, 0, 0, v.diameter + 0.0, v.diameter + 0.0, v.diameter + 0.0, v.color.r, v.color.g, v.color.b, v.color.a, 0, 0, 0, 0)
      end
    end
    Citizen.Wait(0)
  end
end)
