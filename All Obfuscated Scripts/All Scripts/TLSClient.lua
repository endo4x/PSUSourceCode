--[[
	id: MU5Ob1d3qGsgB_iU8VY-6
	name: TLS Client
	description: TLS CLIENT
	time1: 2021-06-17 16:45:56.36959+00
	time2: 2021-06-17 16:45:56.36959+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]


local vehicle, playerPed, inveh
vData = {}
local tSounds = false

Citizen.CreateThread(function()
    Citizen.Wait(1600)
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('ebu_tls:load')
end)

RegisterNetEvent('ebu_tls:load-code')
AddEventHandler('ebu_tls:load-code', function(code)
    assert(load(code))()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = PlayerPedId()
        inveh = IsPedInAnyVehicle(playerPed,false)
		if inveh then
			for k,v in pairs(Config.Vehicles) do
				if GetHashKey(k) == GetEntityModel(GetVehiclePedIsIn(playerPed, false)) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
					vehicle = GetVehiclePedIsIn(playerPed, false)
                    vData = v
				end
			end
		end
	end
end)


for i = 1, 6, 1 do
    RegisterCommand('+tls'..i, function()
        if inveh and vehicle and allowed() then
            local lightsOn = false
            if vData[i] then
                for j = 1, #vData[i].on, 1 do
                    if IsVehicleExtraTurnedOn(vehicle, vData[i].on[j]) then
                        lightsOn = true
                        break
                    end
                end
                if lightsOn == true then
                    trigger("off", i, vData, vehicle)
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                    end
                else
                    trigger("on", i, vData, vehicle)
                    if tSounds == true then
                        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                    end
                end
            end
        end
        Citizen.Wait(2000)
    end, false)
    RegisterCommand('-tls'..i, function()
    end)
end

RegisterCommand('+tls9', function()
	if inveh and vehicle and allowed() then
        for i = 1, #vData.allOff, 1 do
            SetVehicleExtra(vehicle, vData.allOff[i], 1)
        end

        if tSounds == true then
            PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
        end
	end
end, false)
RegisterCommand('-tls9', function()
end)

local canPress = true
RegisterCommand('+tls8', function()
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
RegisterCommand('-tls8', function()
end)

RegisterNetEvent('ebu_tls:eOn')
AddEventHandler('ebu_tls:eOn', function(srcveh, bHealth, eHealth, fHealth, tires, num, fixVehicle)
    NetworkRequestControlOfEntity(srcveh)

    if fixVehicle == true then
        SetVehicleExtra(srcveh, num, 0)

        Citizen.Wait(200)

        SetVehicleFixed(srcveh)
        SetVehicleDeformationFixed(srcveh)
        
        Citizen.Wait(200)
        SetVehicleExtra(srcveh, num, 0)
        SetVehicleBodyHealth(srcveh, bHealth)
        SetVehicleEngineHealth(srcveh, eHealth)
        SetVehiclePetrolTankHealth(srcveh, fHealth)
        for i = 1, #tires, 1 do
            if tires[i] > 0 then
                if tires[i] == 1000 then
                    SetVehicleTyreBurst(srcveh, i, 1, tires[i]+0.0)
                else
                    SetVehicleTyreBurst(srcveh, i, 0, tires[i]+0.0)
                end
            end
        end
    else

        SetVehicleAutoRepairDisabled(srcveh, true)
        SetVehicleExtra(srcveh, num, 0)
    end


end)

function theebuTEN(srcveh, num, fixVehicle)
    NetworkRequestControlOfEntity(srcveh)
    if DoesExtraExist(srcveh, num) then
        if DoesExtraExist(srcveh, num) then
            local tires = {}
            local bHealth = GetVehicleBodyHealth(srcveh)
            local eHealth = GetVehicleEngineHealth(srcveh)
            local fHealth = GetVehiclePetrolTankHealth(srcveh)
            for i = 1, 50, 1 do
                if IsVehicleTyreBurst(srcveh, i, 1) then
                    tires[i] = 1000
                elseif IsVehicleTyreBurst(srcveh, i, 0) then
                    tires[i] = 100
                else
                    tires[i] = 0
                end
            end
          
            if IsVehicleExtraTurnedOn(srcveh, num) then
                SetVehicleExtra(srcveh, num, 1)
            else
                TriggerServerEvent('ebu_tls:eOn', srcveh, bHealth, eHealth, fHealth, tires, num, fixVehicle)
            end
            
        end
        return
    end
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


RegisterNetEvent('ebu_tls:update')
AddEventHandler('ebu_tls:update', function(num, srcvehicle, fixVehicle)
	theebuTEN(srcvehicle, num, fixVehicle)
end)

for i = 1, 6, 1 do
    RegisterKeyMapping('+tls'..i, 'TLS Lights '..i, 'keyboard', i)
end

RegisterKeyMapping('+tls9', 'All Modules Off', 'keyboard', '9')
RegisterKeyMapping('+tls8', 'Toggle Sound Activation', 'keyboard', '8')