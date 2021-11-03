--[[
	id: 1SplgYVM2tujLbCW5kGCY
	name: ebu_STTog_client
	description: Speedtech Toggle
	time1: 2021-05-06 22:27:35.084966+00
	time2: 2021-05-06 22:27:35.084967+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local forwardTD = {11, 12}
local fullTD = {9,10,11,12}
local alleyTD = {9,10}
local cruise = {4,5}

local vehicle, playerPed, inveh
local vData = {}
local tSounds = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = PlayerPedId()
        inveh = IsPedInAnyVehicle(playerPed,false)
		if inveh then
			for k,v in pairs(Config.Vehicles) do
				if GetHashKey(v) == GetEntityModel(GetVehiclePedIsIn(playerPed, false)) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
					vehicle = GetVehiclePedIsIn(playerPed, false)
				end
			end
		end
	end
end)

for i = 1, 4, 1 do
	RegisterCommand('+hfdd3453'..i, function()
		if inveh and vehicle and allowed() then
            if i == 1 then
                if IsVehicleExtraTurnedOn(vehicle, forwardTD[1]) then
                    for i = 1, #forwardTD do
                        SetVehicleExtra(vehicle, forwardTD[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #forwardTD do
                        TriggerServerEvent('ebu_STTog:update', forwardTD[i], vehicle)
                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            elseif i == 2 then
                if IsVehicleExtraTurnedOn(vehicle, fullTD[1]) then
                    for i = 1, #fullTD do
                        SetVehicleExtra(vehicle, fullTD[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #fullTD do
                        TriggerServerEvent('ebu_STTog:update', fullTD[i], vehicle)
                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            elseif i == 3 then
                if IsVehicleExtraTurnedOn(vehicle, alleyTD[1]) then
                    for i = 1, #alleyTD do
                        SetVehicleExtra(vehicle, alleyTD[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #alleyTD do
                        TriggerServerEvent('ebu_STTog:update', alleyTD[i], vehicle)
                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            elseif i == 4 then
                if IsVehicleExtraTurnedOn(vehicle, cruise[1]) then
                    for i = 1, #cruise do
                        SetVehicleExtra(vehicle, cruise[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #cruise do
                        TriggerServerEvent('ebu_STTog:update', cruise[i], vehicle)
                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            end
		end
	end, false)
	RegisterCommand('-hfdd3453'..i, function()
	end)
end

RegisterCommand('+hfdd34539', function()
	if inveh and vehicle and allowed() then
        SetVehicleExtra(vehicle, 4, 1)
        SetVehicleExtra(vehicle, 5, 1)
        SetVehicleExtra(vehicle, 9, 1)
        SetVehicleExtra(vehicle, 10, 1)
        SetVehicleExtra(vehicle, 11, 1)
        SetVehicleExtra(vehicle, 12, 1)

        if tSounds == true then
            PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
        end
	end
end, false)
RegisterCommand('-hfdd34539', function()
end)

local canPress = true
RegisterCommand('+hfdd34538', function()
    if tSounds == true and canPress == true and allowed() then
        canPress = false
        tSounds = false
        draw2dText("off")
        Citizen.Wait(2000)
        canPress = true
    elseif canPress == true and allowed() then
        canPress = false
        tSounds = true
        draw2dText("on")
        Citizen.Wait(2000)
        canPress = true
	end
end, false)
RegisterCommand('-hfdd34538', function()
end)

function theebuTEN(srcveh,num)
    NetworkRequestControlOfEntity(srcveh)
    SetVehicleAutoRepairDisabled(srcveh, true)

    SetVehicleExtra(srcveh, num, 0)
        
end

function draw2dText(state)
    Citizen.CreateThread(function()
        local timer = 100
        while timer > 1 do
            timer = timer -1
		    Citizen.Wait(0)
            SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(0.0, 0.3)
            SetTextColour(128, 128, 128, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            if state == "on" then
                AddTextComponentString("🔊")
            elseif state == "off" then
                AddTextComponentString("🔇")
            end
            DrawText(0.003, 0.955)
        end
        if timer == 0 then
            return
        end
    end)
end


RegisterNetEvent('ebu_STTog:update')
AddEventHandler('ebu_STTog:update', function(num, srcvehicle)
	theebuTEN(srcvehicle, num)
end)

RegisterKeyMapping('+hfdd34531', 'Forward Takedowns', 'keyboard', '1')
RegisterKeyMapping('+hfdd34532', 'Alley Lights', 'keyboard', '2')
RegisterKeyMapping('+hfdd34533', 'Takedowns & Alley', 'keyboard', '3')
RegisterKeyMapping('+hfdd34534', 'Cruise Lights', 'keyboard', '4')

RegisterKeyMapping('+hfdd34539', 'All Modules Off', 'keyboard', '9')
RegisterKeyMapping('+hfdd34538', 'Toggle Sound Activation', 'keyboard', '8')