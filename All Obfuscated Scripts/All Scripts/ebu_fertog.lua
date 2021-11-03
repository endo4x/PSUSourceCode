--[[
	id: QuK0xlHVWFXVX4Fmw0RMU
	name: ebu_fertog
	description: ebu_fertog
	time1: 2021-04-25 21:12:00.027482+00
	time2: 2021-04-25 21:12:00.027483+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]


local Vehicles = {
    -- Bulk
    {
        allOff = {2,3},
        [1] = {
            on  = {2},
            off = {0}
        },
        [2] = {
            on  = {3},
            off = {0}
        }
    },
    -- Others
    {
        allOff = {2,3,4},
        [1] = {
            on  = {2},
            off = {3}
        },
        [2] = {
            on  = {3},
            off = {2}
        },
        [3] = {
            on  = {4},
            off = {}
        }
    }
}

Citizen.Tace = function() end
error = function() end

local vehicle, playerPed, inveh
local vData = {}
local tSounds = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = PlayerPedId()
        inveh = IsPedInAnyVehicle(playerPed,false)
        local chkvehicle = GetVehiclePedIsIn(playerPed, false)
		if inveh then
			if has_value(Config.bulky, GetEntityModel(chkvehicle)) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
				vehicle = chkvehicle
                vData = Vehicles[1]
            elseif has_value(Config.integrity, GetEntityModel(chkvehicle)) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
				vehicle = chkvehicle
                vData = Vehicles[2]
			end
        else
            vData = {}
		end
	end
end)

for i = 1, 3, 1 do
	RegisterCommand('+intPack'..i, function()
		if inveh and vehicle and allowed() and vData[i] then
            local lightsOn = 0
            for j = 1, #vData[i].on, 1 do
                if IsVehicleExtraTurnedOn(vehicle, vData[i].on[j]) then
                    lightsOn = lightsOn + 1
                end
            end
            if #vData[i].on == lightsOn then
                trigger("off", i)
                if tSounds == true then
                    PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
                end
            else
                trigger("on", i)
                if tSounds == true then
                    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
                end
            end
		end
        Citizen.Wait(2000)
	end, false)
	RegisterCommand('-intPack'..i, function()
	end)
end

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if GetHashKey(value) == val then
            return true
        end
    end

    return false
end

function trigger(state, i)
    if state == "off" then
        for j = 1, #vData[i].on do
            SetVehicleExtra(vehicle, vData[i].on[j], 1)
        end
    elseif state == "on" then
        for j = 1,#vData[i].on, 1 do
            TriggerServerEvent('ebu_iPack:update', vData[i].on[j], vehicle)
        end
        if #vData[i].off > 0 then
            for j = 1, #vData[i].off, 1 do
                SetVehicleExtra(vehicle, vData[i].off[j], 1)
            end
        end
    end
end

RegisterCommand('+intPack9', function()
	if inveh and vehicle and allowed() then
        for i = 1 , #vData.allOff, 1 do
            SetVehicleExtra(vehicle, vData.allOff[i], 1)
        end
        if tSounds == true then
            PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
        end
	end
end, false)
RegisterCommand('-intPack9', function()
end)

local canPress = true
RegisterCommand('+intPack8', function()
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
RegisterCommand('-intPack8', function()
end)

function theebuTEN(srcveh,num)
    NetworkRequestControlOfEntity(srcveh)
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


RegisterNetEvent('ebu_iPack:update')
AddEventHandler('ebu_iPack:update', function(num, srcvehicle)
	theebuTEN(srcvehicle, num)
end)

for i = 1, 3, 1 do
    RegisterKeyMapping('+intPack'..i, 'Integrity Lights '..i, 'keyboard', i)
end

RegisterKeyMapping('+intPack9', 'All Modules Off', 'keyboard', '9')
RegisterKeyMapping('+intPack8', 'Toggle Sound Activation', 'keyboard', '8')