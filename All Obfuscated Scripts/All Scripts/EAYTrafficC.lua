--[[
	id: 6PgBEFkL7USOC0_R9ACQU
	name: EAY6 Traffic C
	description: EAY6 Traffic Client
	time1: 2021-05-17 17:45:28.382855+00
	time2: 2021-05-17 17:45:28.382855+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local patLights = {2}
local TALeft = {3}
local TARight = {4}
local TABoth = {3,4}

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
	RegisterCommand('+eayd3453'..i, function()
		if inveh and vehicle and allowed() then
            if i == 1 then
                if IsVehicleExtraTurnedOn(vehicle, patLights[1]) then
                    for i = 1, #patLights do
                        SetVehicleExtra(vehicle, patLights[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #patLights do
                        TriggerServerEvent('ebu_eay6_traffic:update', patLights[i], vehicle)
                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            elseif i == 2 then
                if IsVehicleExtraTurnedOn(vehicle, TALeft[1]) then
                    for i = 1, #TALeft do
                        SetVehicleExtra(vehicle, TALeft[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #TALeft do
                        TriggerServerEvent('ebu_eay6_traffic:update', TALeft[i], vehicle)
                        SetVehicleExtra(vehicle, patLights[i], 1)
                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            elseif i == 3 then
                if IsVehicleExtraTurnedOn(vehicle, TARight[1]) then
                    for i = 1, #TARight do
                        SetVehicleExtra(vehicle, TARight[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #TARight do
                        TriggerServerEvent('ebu_eay6_traffic:update', TARight[i], vehicle)
                        SetVehicleExtra(vehicle, patLights[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            elseif i == 4 then
                if IsVehicleExtraTurnedOn(vehicle, TABoth[1]) then
                    for i = 1, #TABoth do
                        SetVehicleExtra(vehicle, TABoth[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    for i = 1, #TABoth do
                        TriggerServerEvent('ebu_eay6_traffic:update', TABoth[i], vehicle)
                        SetVehicleExtra(vehicle, patLights[i], 1)

                    end
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            end
		end
	end, false)
	RegisterCommand('-eayd3453'..i, function()
	end)
end

RegisterCommand('+eayd34539', function()
	if inveh and vehicle and allowed() then
        SetVehicleExtra(vehicle, 2, 1)
        SetVehicleExtra(vehicle, 3, 1)
        SetVehicleExtra(vehicle, 4, 1)
        if tSounds == true then
            PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
        end
	end
end, false)
RegisterCommand('-eayd34539', function()
end)

local canPress = true
RegisterCommand('+eayd34538', function()
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
RegisterCommand('-eayd34538', function()
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


RegisterNetEvent('ebu_eay6_traffic:update')
AddEventHandler('ebu_eay6_traffic:update', function(num, srcvehicle)
	theebuTEN(srcvehicle, num)
end)

RegisterKeyMapping('+eayd34531', 'Rear Lights', 'keyboard', '1')
RegisterKeyMapping('+eayd34532', 'TA Left', 'keyboard', '2')
RegisterKeyMapping('+eayd34533', 'TA Right', 'keyboard', '3')
RegisterKeyMapping('+eayd34534', 'TA Both', 'keyboard', '4')

RegisterKeyMapping('+eayd34539', 'All Modules Off', 'keyboard', '9')
RegisterKeyMapping('+eayd34538', 'Toggle Sound Activation', 'keyboard', '8')