--[[
	id: kkgEdl41V373TroRpepe_
	name: FOF150 Client
	description: FOF150 Client (Lucky)
	time1: 2021-05-13 14:11:28.516751+00
	time2: 2021-05-13 14:11:28.516751+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local vehicle, playerPed, inveh
local vData = 3
local tSounds = false
local canPress = true

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

function killBoard()
    for i = 3, 9,1 do
        SetVehicleExtra(vehicle, i, 1)
    end
end

RegisterCommand('+hfdd3453k', function()
    if inveh and vehicle then
        canPress = false

        vData = vData + 1
        if vData > 9 then
            vData = 3
        end
        killBoard()
        TriggerServerEvent('ebu_fof150:update', vData, vehicle)
        if tSounds == true then
            PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
        end
    end
end)
RegisterCommand('-hfdd3453k', function()
end) 
RegisterCommand('+hfdd3453j', function()
    if inveh and vehicle then
        canPress = false
        vData = vData - 1
        if vData < 3 then
            vData = 9
        end
        killBoard()
        TriggerServerEvent('ebu_fof150:update', vData, vehicle)
        if tSounds == true then
            PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
        end
    end
end)
RegisterCommand('-hfdd3453j', function()
end)

RegisterCommand('+hfdd3453u', function()
	if inveh and vehicle then
        canPress = false

        if IsVehicleExtraTurnedOn(vehicle, 1) then
            SetVehicleExtra(vehicle, 1, 1)
            TriggerServerEvent('ebu_fof150:update', 2, vehicle)
        elseif IsVehicleExtraTurnedOn(vehicle, 2) then
            SetVehicleExtra(vehicle, 2, 1)
            TriggerServerEvent('ebu_fof150:update', 1, vehicle)
        else
            SetVehicleExtra(vehicle, 1, 1)
            TriggerServerEvent('ebu_fof150:update', 2, vehicle)
        end
	end
end, false)
RegisterCommand('-hfdd3453u', function()
end)

RegisterCommand('+hfdd3453s', function()
    if tSounds == true and canPress == true then
        canPress = false
        tSounds = false
        draw2dText("off")
        Citizen.Wait(2000)
        canPress = true
    elseif canPress == true then
        canPress = false
        tSounds = true
        draw2dText("on")
        Citizen.Wait(2000)
        canPress = true
	end
end, false)
RegisterCommand('-hfdd3453s', function()
end)

function theebuTEN(srcveh,num)
    NetworkRequestControlOfEntity(srcveh)
   
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
    
    TriggerServerEvent('ebu_fof150:eOn', srcveh, bHealth, eHealth, fHealth, tires, num)
        
end

RegisterNetEvent('ebu_fof150:eOn')
AddEventHandler('ebu_fof150:eOn', function(srcveh, bHealth, eHealth, fHealth, tires, num)
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
            SetVehicleTyreBurst(srcveh, i, 0, tires[i]+0.0)
        end
    end
    canPress = true
end)

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


RegisterNetEvent('ebu_fof150:update')
AddEventHandler('ebu_fof150:update', function(num, srcvehicle)
	theebuTEN(srcvehicle, num)
end)

RegisterKeyMapping('+hfdd3453k', 'Cycle Board Patterns Forward', 'keyboard', 'k')
RegisterKeyMapping('+hfdd3453j', 'Cycle Board Patterns Back', 'keyboard', 'j')

RegisterKeyMapping('+hfdd3453u', 'Raise/Lower Board', 'keyboard', 'u')

RegisterKeyMapping('+hfdd3453s', 'Toggle Sound Activation', 'keyboard', '8')