--[[
	id: wePCAvpoeevWeBC-Vq6V6
	name: admin_client
	description: admin_client
	time1: 2021-07-19 01:01:40.782639+00
	time2: 2021-07-19 01:01:40.782641+00
	uploader: jwSAFiyGDZZngdEUyC9KXjXc3kZsqwbIcIgS4G-8
	uploadersession: nL5L49evOF_jJlNEUrxixZuZeT-pDw
	flag: f
--]]

ESX = nil
SolarAdmin = {}
local display, frozen, isSpectating, noclip  = false, false, false, false
playerID = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShilovepizzaaredObjilovepizzaect', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("ban", function(data)
    TriggerServerEvent("SolarAdmin:Ban", data.playerid, tonumber(data.inputData), "You have been put on a timeout")
end)

RegisterNUICallback("permaban", function(data)
    TriggerServerEvent("SolarAdmin:Ban", data.playerid, 0, data.inputData)
end)

RegisterNUICallback("unban", function(data)
    TriggerServerEvent("SolarAdmin:Unban", data.confirmoutput)
    SolarAdmin.GetPlayers()
end)

RegisterNUICallback("addCash", function(data)
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("SolarAdmin:AddCash", data.playerid, amnt)
end)

RegisterNUICallback("addBank", function(data)
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("SolarAdmin:AddBank", data.playerid, amnt)
end)

RegisterNUICallback("inventory", function(data)
    TriggerEvent("inventory:openPlayerInventory", data.playerid)
    SetDisplay(false)
end)

RegisterNUICallback("giveitem", function(data)
    local amnt = tonumber(data.amount)
    print("id: "..data.playerid.." name: "..data.name.." amount: "..data.amount)
    TriggerServerEvent("SolarAdmin:AddItem", data.playerid, data.name, amnt)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

RegisterNUICallback("tp-wp", function(data)
    SolarAdmin.TeleportToWaypoint()
end)

RegisterNUICallback("bring", function(data)
    TriggerServerEvent("SolarAdmin:Teleport", data.playerid, "bring")
end)

RegisterNUICallback("goto", function(data)
    TriggerServerEvent("SolarAdmin:Teleport", data.playerid, "goto")
end)

RegisterNUICallback("kick", function(data)
    TriggerServerEvent("SolarAdmin:Kick", data.playerid, data.inputData)
end)

RegisterNUICallback("spectate", function(data)
	playerID = data.playerid
	SolarAdmin.Spectate(playerID, true)
	isSpectating = true
	SetDisplay(false)
end)

RegisterNUICallback("freeze", function(data)
	TriggerServerEvent("SolarAdmin:Freeze", data.playerid)
end)

RegisterNUICallback("kill", function(data)
	TriggerServerEvent("SolarAdmin:Slay", data.playerid)
end)

RegisterNUICallback("promote", function(data)
	TriggerServerEvent("SolarAdmin:Promote", data.playerid, data.level)
end)

RegisterNUICallback("weapon", function(data)
	TriggerServerEvent("SolarAdmin:GiveWeapon", data.playerid, data.weapon)
end)

RegisterNUICallback("noclip", function(data)
	SolarAdmin.Noclip()
	SetDisplay(false)
end)

RegisterNUICallback("god", function(data)
	TriggerServerEvent("SolarAdmin:God", data.playerid)
end)

RegisterNUICallback("spawnvehicle", function(data)
	SolarAdmin.SpawnVehicle(data.model)
end)

RegisterNUICallback("announce", function(data)
	TriggerServerEvent("SolarAdmin:Announcement", data.inputData)
end)

RegisterNUICallback("setJob", function(data)
	TriggerServerEvent("SolarAdmin:setJob", data.playerid, data.job, data.rank)
end)

RegisterNUICallback("revive", function(data)
	TriggerServerEvent("SolarAdmin:revive", data.playerid)
end)

RegisterNUICallback("setTime", function(data)
	TriggerServerEvent("SolarAdmin:Time", data.inputData)
end)

RegisterNUICallback("freezeTime", function(data)
	TriggerServerEvent("SolarAdmin:freezeTime")
end)

RegisterNUICallback("changeWeather", function(data)
	TriggerServerEvent("SolarAdmin:Weather", data.weather)
end)

RegisterNUICallback("freezeWeather", function(data)
	TriggerServerEvent("SolarAdmin:freezeWeather")
end)

RegisterNUICallback("blackout", function(data)
	TriggerServerEvent("SolarAdmin:Blackout")
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

---Teleport To Waypoint
SolarAdmin.TeleportToWaypoint = function()
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if Config.Perms[playerRank] and Config.Perms[playerRank].CanTpWp then
            local WaypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end
                ESX.ShowNotification("Teleport erfolgreich")
            else
                ESX.ShowNotification("Du musst einen Marker setzen")
            end
        else
            TriggerEvent('chat:addMessage', {args = {"ChapterV", " Du hast keine Berechtigung"}})
        end
    end)
end

SolarAdmin.GetPlayers = function()
    ESX.TriggerServerCallback("SolarAdmin:getPlayers", function(players) 
        SendNUIMessage({type = "data", data = players})
    end)
end

SolarAdmin.GetItemList = function()
	local weapons = ESX.GetWeaponList()
	ESX.TriggerServerCallback("SolarAdmin:getJobs", function(jobs) 
	    ESX.TriggerServerCallback("SolarAdmin:getItemList", function(results) 
	        SendNUIMessage({type = "items", itemslist = results, weaponlist = weapons, vehiclelist = Config.Vehicles, joblist = jobs })

	    end)
	end)
end

RegisterNetEvent('SolarAdmin:Announcement')
AddEventHandler('SolarAdmin:Announcement', function(message)
	exports['notification']:Alert("SERVER BENACHRICHTIGUNG", message, 10000, 'warning')
end)

RegisterNetEvent('SolarAdmin:Freeze')
AddEventHandler('SolarAdmin:Freeze', function(targetPed)
	local player = PlayerId()
	local ped = PlayerPedId()

	frozen = not frozen

	if not frozen then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('SolarAdmin:Slay')
AddEventHandler('SolarAdmin:Slay', function(targetPed)
	SetEntityHealth(PlayerPedId(), 0)
end)

local hasGodmode = false
RegisterNetEvent('SolarAdmin:God')
AddEventHandler('SolarAdmin:God', function(targetPed)
	if not hasGodmode then
		hasGodmode = not hasGodmode
		SetEntityInvincible(PlayerPedId(), true)
	else
		SetEntityInvincible(PlayerPedId(), false)
	end
end)

SolarAdmin.SpawnVehicle = function(model)
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if Config.Perms[playerRank] and Config.Perms[playerRank].CanSpawnVehicle then
			local coords = GetEntityCoords(PlayerPedId())
			local closestVehicle = ESX.Game.GetClosestVehicle(coords)

			ESX.Game.DeleteVehicle(closestVehicle)

			ESX.Game.SpawnVehicle(model, vector3(coords.x + 2.0, coords.y, coords.z), 0.0, function(vehicle) --get vehicle info
				if DoesEntityExist(vehicle) then
					ESX.ShowNotification("Spawned "..model)			
				end		
			end)
		else
            TriggerEvent('chat:addMessage', {args = {"ChapterV", " Du hast keine Berechtigung"}})
        end
	end)
end

SolarAdmin.Spectate = function(target, bool)
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if Config.Perms[playerRank] and Config.Perms[playerRank].CanSpectate then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
			local name = GetPlayerName(GetPlayerFromServerId(target))

			if targetPed ~= PlayerPedId() then
				if (bool) then
					if (not IsScreenFadedOut() and not IsScreenFadingOut()) then
						DoScreenFadeOut(1000)
						while (not IsScreenFadedOut()) do
							Wait(0)
						end

						local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

						RequestCollisionAtCoord(targetx,targety,targetz)
						NetworkSetInSpectatorMode(true, targetPed)

						ESX.ShowNotification("Zuschauen gestartet von "..name)

						if(IsScreenFadedOut()) then
							DoScreenFadeIn(1000)
						end
					end
				else
					if(not IsScreenFadedOut() and not IsScreenFadingOut()) then
						DoScreenFadeOut(1000)
						while (not IsScreenFadedOut()) do
							Wait(0)
						end

						local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

						RequestCollisionAtCoord(targetx,targety,targetz)
						NetworkSetInSpectatorMode(false, targetPed)
						ESX.ShowNotification("Zuschauen von "..name.." beendet")

						if(IsScreenFadedOut()) then
							DoScreenFadeIn(1000)
						end
					end
				end
			else
				ESX.ShowNotification("Du kannst dir nicht selber Zuschauen")
			end
	    else
            TriggerEvent('chat:addMessage', {args = {"ChapterV ", " Du hast keine Berechtigung"}})
        end
    end)
end

SolarAdmin.Noclip = function()
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if Config.Perms[playerRank] and Config.Perms[playerRank].CanNoClip then
		    local player = PlayerId()
			
		    local msg = "disabled"
			if(noclip == false)then
				noclip_pos = GetEntityCoords(PlayerPedId(), false)
			end

			noclip = not noclip

			if(noclip)then
				msg = "enabled"
			end

			TriggerEvent('chat:addMessage', {args = {"ChapterV ", " Noclip has been " .. msg}})
			ESX.ShowNotification(" Noclip has been " .. msg)
			
			local heading = 0
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(0)

					if(noclip)then
						SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

						if(IsControlPressed(1, 34))then
							heading = heading + 1.5
							if(heading > 360)then
								heading = 0
							end

							SetEntityHeading(PlayerPedId(), heading)
						end

						if(IsControlPressed(1, 9))then
							heading = heading - 1.5
							if(heading < 0)then
								heading = 360
							end

							SetEntityHeading(PlayerPedId(), heading)
						end

						if(IsControlPressed(1, 8))then
							noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
						end

						if(IsControlPressed(1, 32))then
							noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, 0.0)
						end

						if(IsControlPressed(1, 27))then
							noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
						end

						if(IsControlPressed(1, 173))then
							noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -1.0)
						end
					else
						Citizen.Wait(200)
					end
				end
			end)
		else
            TriggerEvent('chat:addMessage', {args = {"SolarAdmin ", " Du hast keine Berechtigung"}})
        end
    end)
end


RegisterKeyMapping("admin", "Solar Admin Menu", "keyboard", 'HOME')

RegisterCommand("admin", function(source,args)
	ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if Config.Perms[playerRank] then
        	local coords = round(GetEntityCoords(PlayerPedId()), 2)
        	SendNUIMessage({type = "coords", coordData = coords})
    		SolarAdmin.GetPlayers()
    		SolarAdmin.GetItemList()
    		SetDisplay(true)
    	else
    		TriggerEvent('chat:addMessage', {args = {"ChapterV", " Du hast keine Berechtigung"}})
    	end
    end)
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end


Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 322) and isSpectating then
			SolarAdmin.Spectate(playerID, false)
			isSpectating = false
			playerID = nil
		elseif IsControlJustPressed(0, 322) and noclip then
			SolarAdmin.Noclip()
		end
	end
end)
