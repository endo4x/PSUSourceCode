--[[
	id: NvELOpTpmnwwthjEGbG53
	name: holo_lua1.3
	description: holo_lua1.3
	time1: 2021-06-06 00:11:33.126271+00
	time2: 2021-06-06 00:11:33.126272+00
	uploader: 9D26QYAXY-_KkpZ_WxiDk_5EAkt05vWY7Nrua9im
	uploadersession: F_LNUIWFcWnqZAzNEkB2-YOIrDEeDw
	flag: f
--]]

-- Events
RegisterNetEvent('HologramSpeed:SetTheme')

-- Constants
local ResourceName       = GetCurrentResourceName()
local HologramURI        = string.format("nui://%s/ui/hologram.html", ResourceName)
local AttachmentOffset   = vec3(2.5, -1, 0.85)
local AttachmentRotation = vec3(0, 0, -15)
local HologramModel      = 'hologram_box_model'
local UpdateFrequency    = 0 -- If less than average frame time, there will be an update every tick regardless of the actual number specified.
local SettingKey         = string.format("%s:profile", GetCurrentServerEndpoint()) -- The key to store the current theme setting in. As themes are per server, this key is also.
local DBG                = true -- Enables debug information, not very useful unless you know what you are doing!

-- Variables
local duiObject      = false -- The DUI object, used for messaging and is destroyed when the resource is stopped
local duiIsReady     = false -- Set by a callback triggered by DUI once the javascript has fully loaded
local hologramObject = 0 -- The current DUI anchor. 0 when one does not exist
local usingMetric, shouldUseMetric = ShouldUseMetricMeasurements() -- Used to track the status of the metric measurement setting
local textureReplacementMade = false -- Due to some weirdness with the experimental replace texture native, we need to make the replacement after the anchor has been spawned in-game

-- Preferences
local displayEnabled = false
local currentTheme   = GetConvar("hsp_defaultTheme", "default")

local function DebugPrint(...)
	if DBG then
		print(...)
	end
end

local function EnsureDuiMessage(data)
	if duiObject and duiIsReady then
		SendDuiMessage(duiObject, json.encode(data))
		return true
	end

	return false
end

local function SendChatMessage(message)
	TriggerEvent('chat:addMessage', {args = {message}})
end

-- Register a callback for when the DUI JS has loaded completely
RegisterNUICallback("duiIsReady", function(_, cb)
	duiIsReady = true
    cb({ok = true})
end)

local function LoadPlayerProfile()
	local jsonData = GetResourceKvpString(SettingKey)
	if jsonData ~= nil then
		jsonData           = json.decode(jsonData)
		displayEnabled     = jsonData.displayEnabled
		currentTheme       = jsonData.currentTheme
		AttachmentOffset   = vec3(jsonData.attachmentOffset.x, jsonData.attachmentOffset.y, jsonData.attachmentOffset.z)
		AttachmentRotation = vec3(jsonData.attachmentRotation.x, jsonData.attachmentRotation.y, jsonData.attachmentRotation.z)
	end
end

local function SavePlayerProfile()
	local jsonData = {
		displayEnabled     = displayEnabled,
		currentTheme       = currentTheme,
		attachmentOffset   = AttachmentOffset,
		attachmentRotation = AttachmentRotation,
	}
	SetResourceKvp(SettingKey, json.encode(jsonData))
end

local function ToggleDisplay()
	displayEnabled = not displayEnabled
	SendChatMessage("Holographic speedometer " .. (displayEnabled and "^2enabled^r" or "^1disabled^r") .. ".") 
	SavePlayerProfile()
end

local function SetTheme(newTheme)
	if newTheme ~= currentTheme then
		EnsureDuiMessage {theme = newTheme}
		SendChatMessage(newTheme == "default" and "Holographic speedometer theme ^5reset^r." or ("Holographic speedometer theme set to ^5" .. newTheme .. "^r."))
		currentTheme = newTheme
		SavePlayerProfile()
	end
end

local function UpdateEntityAttach()
	local playerPed, currentVehicle
	playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed) then
		currentVehicle = GetVehiclePedIsIn(playerPed, false)
		-- Attach the hologram to the vehicle
		AttachEntityToEntity(hologramObject, currentVehicle, GetEntityBoneIndexByName(currentVehicle, "chassis"), AttachmentOffset, AttachmentRotation, false, false, false, false, false, true)
		DebugPrint(string.format("DUI anchor %s attached to %s", hologramObject, currentVehicle))
	end
end

local function CheckRange(x, y, z, minVal, maxVal)
	if x == nil or y == nil or z == nil or minVal == nil or maxVal == nil then
		return false
	else
		return not (x < minVal or x > maxVal or y < minVal or y > maxVal or z < minVal or z > maxVal)
	end
end

-- Command Handler

local function CommandHandler(args)

	local msgErr = "^1The the acceptable range for ^0%s ^1is ^0%f^1 ~ ^0%f^1, reset to default setting.^r"
	local msgSuc = "^2Speedometer ^0%s ^2changed to ^0%f, %f, %f^r"
	
	if args[1] == "theme" then
		if #args >= 2 then
			TriggerServerEvent('HologramSpeed:CheckTheme', args[2])
		else
			SendChatMessage("^1Invalid theme! ^0Usage: /hsp theme <name>^r")
		end
	elseif args[1] == "offset" then
		local nx, ny, nz = 2.5, -1, 0.85
		if #args >= 4 then
			nx, ny, nz = tonumber(args[2]), tonumber(args[3]), tonumber(args[4])
			if not CheckRange(nx, ny, nz, -5.0, 5.0) then
				nx, ny, nz = 2.5, -1, 0.85
				SendChatMessage(string.format(msgErr, args[1], -5.0, 5.0))
			end
		else
			SendChatMessage("Offset reset. To change the offset, use: /hsp offset <X> <Y> <Z>")
		end
		AttachmentOffset = vec3(nx, ny, nz)
		UpdateEntityAttach()
		SavePlayerProfile()
		SendChatMessage(string.format(msgSuc, args[1], nx, ny, nz))
	elseif args[1] == "rotate" then
		local nx, ny, nz = 0, 0, -15
		if #args >= 4 then
			nx, ny, nz = tonumber(args[2]), tonumber(args[3]), tonumber(args[4])
			if not CheckRange(nx, ny, nz, -45.0, 45.0) then
				nx, ny, nz = 0, 0, -15
				SendChatMessage(string.format(msgErr, args[1], -45.0, 45.0))
			end
		else
			SendChatMessage("Rotation reset. To change the rotation, use: /hsp rotate <X> <Y> <Z>")
		end
		AttachmentRotation = vec3(nx, ny, nz)
		UpdateEntityAttach()
		SavePlayerProfile()
		SendChatMessage(string.format(msgSuc, args[1], nx, ny, nz))
	else
		SendChatMessage("^1Usage: ^0/hsp <theme|offset|rotate> [args...]^r")
	end
end

-- Network events

AddEventHandler('HologramSpeed:SetTheme', function(theme)
	SetTheme(theme)
end)

-- Register command

RegisterCommand("hsp", function(_, args)	
	if #args == 0 then
		ToggleDisplay()
	else
		CommandHandler(args)
	end
end, false)

TriggerEvent('chat:addSuggestion', '/hsp', 'Toggle the holographic speedometer', {
    { name = "command",  help = "Allow command: theme, offset, rotate" },
})

-- RegisterKeyMapping("hsp", "Toggle Holographic Speedometer", "keyboard", "end") -- default: `

-- Initialise the DUI. We only need to do this once.
local function InitialiseDui()
	DebugPrint("Initialising...")

	duiObject = CreateDui(HologramURI, 512, 512)

	DebugPrint("\tDUI created")

	repeat Wait(0) until duiIsReady

	DebugPrint("\tDUI available")

	EnsureDuiMessage {
		useMetric = usingMetric,
		display = false,
		theme = currentTheme
	}

	DebugPrint("\tDUI initialised")

	local txdHandle  = CreateRuntimeTxd("HologramDUI")
	local duiHandle  = GetDuiHandle(duiObject)
	local duiTexture = CreateRuntimeTextureFromDuiHandle(txdHandle, "DUI", duiHandle)
	DebugPrint("\tRuntime texture created")

	DebugPrint("Done!")
end

-- Main Loop
CreateThread(function()
	-- Sanity checks
	if string.lower(ResourceName) ~= ResourceName then
		return
	end

	if not IsModelInCdimage(HologramModel) or not IsModelAVehicle(HologramModel) then
		SendChatMessage("^1Could not find `hologram_box_model` in the game... ^rHave you installed the resource correctly?")
		return
	end
	
	LoadPlayerProfile()
	
	InitialiseDui()

	-- This thread watches for changes to the user's preferred measurement system
	CreateThread(function()	
		while true do
			Wait(1000)
	
			shouldUseMetric = ShouldUseMetricMeasurements()
	
			if usingMetric ~= shouldUseMetric and EnsureDuiMessage {useMetric = shouldUseMetric} then
				usingMetric = shouldUseMetric
			end
		end
	end)

	local playerPed, currentVehicle, vehicleSpeed

	while true do
		playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed) then
			currentVehicle = GetVehiclePedIsIn(playerPed, false)

			-- When the player is in the drivers seat of their current vehicle...
			if GetPedInVehicleSeat(currentVehicle, -1) == playerPed then
				-- Ensure the display is off before we start
				EnsureDuiMessage {display = false}

				-- Load the hologram model
				RequestModel(HologramModel)
				repeat Wait(0) until HasModelLoaded(HologramModel)

				-- Create the hologram object
				hologramObject = CreateVehicle(HologramModel, GetEntityCoords(currentVehicle), 0.0, false, true)
				SetVehicleIsConsideredByPlayer(hologramObject, false)
				SetVehicleEngineOn(hologramObject, true, true)
				SetEntityCollision(hologramObject, false, false)
				DebugPrint("DUI anchor created "..tostring(hologramObject))

				-- Odd hacky fix for people who's textures won't replace properly
				if not textureReplacementMade then
					AddReplaceTexture("hologram_box_model", "p_hologram_box", "HologramDUI", "DUI")
					DebugPrint("Texture replacement made")
					textureReplacementMade = true
				end

				SetModelAsNoLongerNeeded(HologramModel)

				-- If the ped's current vehicle still exists and they are still driving it...
				if DoesEntityExist(currentVehicle) and GetPedInVehicleSeat(currentVehicle, -1) == playerPed then
					-- Attach the hologram to the vehicle
					AttachEntityToEntity(hologramObject, currentVehicle, GetEntityBoneIndexByName(currentVehicle, "chassis"), AttachmentOffset, AttachmentRotation, false, false, false, false, false, true)
					DebugPrint(string.format("DUI anchor %s attached to %s", hologramObject, currentVehicle))

					-- Wait until the engine is on before enabling the hologram proper
					repeat Wait(0) until IsVehicleEngineOn(currentVehicle)

					-- Until the player is no longer driving this vehicle, update the UI
					repeat
						vehicleSpeed = GetEntitySpeed(currentVehicle)

						vehicleClass = GetVehicleClass(currentVehicle)

						EnsureDuiMessage {
							display  = displayEnabled and IsVehicleEngineOn(currentVehicle),
							rpm      = GetVehicleCurrentRpm(currentVehicle),
							gear     = GetVehicleCurrentGear(currentVehicle),
							abs      = (GetVehicleWheelSpeed(currentVehicle, 0) == 0.0) and (vehicleSpeed > 0.0),
							hBrake   = GetVehicleHandbrake(currentVehicle),
							fuel     = GetVehicleFuelLevel(currentVehicle),
							rawSpeed = vehicleSpeed,
							vehicleClass = vehicleClass,
							engineHealth = GetVehicleEngineHealth(currentVehicle),
							bodyHealth = GetVehicleBodyHealth(currentVehicle)
						}

						-- Wait for the next frame or half a second if we aren't displaying
						Wait(displayEnabled and UpdateFrequency or 500)
					until GetPedInVehicleSeat(currentVehicle, -1) ~= PlayerPedId()
				end
			end
		end

		-- At this point, the player is no longer driving a vehicle or was never driving a vehicle this cycle 

		-- If there is a hologram object currently created...
		if hologramObject ~= 0 and DoesEntityExist(hologramObject) then
			-- Delete the hologram object
			DeleteVehicle(hologramObject)
			DebugPrint("DUI anchor deleted "..tostring(hologramObject))
		else
			-- Instead of setting this in the above block, clearing the handle here ensures that the entity must not exist before it's handle is lost.
			hologramObject = 0
		end

		-- We don't need to check every single frame for the player being in a vehicle so we check every second
		Wait(1000)
	end
end)
 
-- Resource cleanup
AddEventHandler("onResourceStop", function(resource)
	if resource == ResourceName then
		DebugPrint("Cleaning up...")

		displayEnabled = false
		DebugPrint("\tDisplay disabled")

		if DoesEntityExist(hologramObject) then
			DeleteVehicle(hologramObject)
			DebugPrint("\tDUI anchor deleted "..tostring(hologramObject))
		end

		RemoveReplaceTexture("hologram_box_model", "p_hologram_box")
		DebugPrint("\tReplace texture removed")

		if duiObject then
			DebugPrint("\tDUI browser destroyed")
			DestroyDui(duiObject)
			duiObject = false
		end
	end
end)

-- Seatbelt
local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end
 
 
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
  
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    
    if car ~= 0 and (wasInCar or IsCar(car)) then
      wasInCar = true
             if isUiOpen == false and not IsPlayerDead(PlayerId()) then
                EnsureDuiMessage{
            	   displayWindow = 'true'
            	   }
                isUiOpen = true 			
            end

      if beltOn then DisableControlAction(0, 75) end

      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)
      
      if speedBuffer[2] ~= nil 
         and not beltOn
         and GetEntitySpeedVector(car, true).y > 1.0  
         and speedBuffer[1] > 19.25 
         and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
         
        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(1)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end
        
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
        
      if IsControlJustReleased(0, 311) and GetLastInputMethod(0) then
        beltOn = not beltOn 
        if beltOn then 
		  TriggerEvent("pNotify:SendNotification", {text = "Seatbelt On", type = "success", timeout = 1400, layout = "centerLeft"})
			
		  EnsureDuiMessage{
		    displayWindow = 'false'
		    }
		  isUiOpen = true 
		else 
		  TriggerEvent("pNotify:SendNotification", {text = "Seatbelt Off", type = "error", timeout = 1400, layout = "centerLeft"}) 

		  EnsureDuiMessage{
		     displayWindow = 'true'
		     }
		  isUiOpen = true  
		end
      end
      
    elseif wasInCar then
      wasInCar = false
      beltOn = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
             if isUiOpen == true and not IsPlayerDead(PlayerId()) then
                EnsureDuiMessage{
            	   displayWindow = 'false'
            	   }
                isUiOpen = false 
            end
    end
    
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if IsPlayerDead(PlayerId()) and isUiOpen == true then
            EnsureDuiMessage{
                    displayWindow = 'false'
               }
            isUiOpen = false
        end    

    end
end)   
-- Seatbelt

-- Cruise Control

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if IsControlJustPressed(1, 243) then
			TriggerEvent('pv:setCruiseSpeed')
			EnsureDuiMessage{
				cruiseControl = 'true'
				}
		end
	end
end)

local cruise = 0

AddEventHandler('pv:setCruiseSpeed', function()
	if cruise == 0 and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		if GetEntitySpeedVector(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)['y'] > 0 then
			cruise = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
			local cruiseKm = math.floor(cruise * 3.6 + 0.5)
			local cruiseMph = math.floor(cruise * 2.23694 + 0.5)
			
			
			Citizen.CreateThread(function()
				while cruise > 0 and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) do
					local cruiseVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if IsVehicleOnAllWheels(cruiseVeh) and GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > (cruise - 2.0) then
						SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cruise)
					else
						EnsureDuiMessage{
							cruiseControl = 'false'
							}
						cruise = 0
						break
					end
					if IsControlPressed(1, 8) then
						EnsureDuiMessage{
							cruiseControl = 'false'
							}
						cruise = 0
					end
					if IsControlPressed(1, 32) then
						EnsureDuiMessage{
							cruiseControl = 'false'
							}
						cruise = 0
						TriggerEvent('pv:setNewSpeed')
					end
					if cruise > 44 then
						EnsureDuiMessage{
							cruiseControl = 'false'
							}
						cruise = 0
						break
					end
					Wait(200)
				end
				EnsureDuiMessage{
					cruiseControl = 'false'
					}
				cruise = 0
			end)
		else
			EnsureDuiMessage{
				cruiseControl = 'false'
				}
			cruise = 0
		end
	else
		if cruise > 0 then
		end
		EnsureDuiMessage{
			cruiseControl = 'false'
			}
		cruise = 0
	end
end)

AddEventHandler('pv:setNewSpeed', function()
	Citizen.CreateThread(function()
		while IsControlPressed(1, 32) do
			Wait(1)
		end
		TriggerEvent('pv:setCruiseSpeed')
		EnsureDuiMessage{
			cruiseControl = 'true'
			}
	end)
end)

function NotificationMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

-- Cruise Control