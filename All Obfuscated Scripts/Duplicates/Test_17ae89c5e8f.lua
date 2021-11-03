--[[
	id: XnkFBtVbutU45-RQMVoIR
	name: Test
	description: Test
	time1: 2021-04-27 21:56:07.482967+00
	time2: 2021-04-27 21:56:07.482967+00
	uploader: jBE_Mrb8QxLgpi5bPGvb1h1UXZsRKWCjkBNU1RGL
	uploadersession: I6FA74QXmeKkaPPL6ENB05DRDKD5Qd
	flag: f
--]]

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
    end

    while ESX.IsPlayerLoaded() do
        Citizen.Wait(500)
    end

    ESX.PlayerData = ESX.GetPlayerData()
    PlayerData = ESX.GetPlayerData()
end)

RegisterCommand("override_audio", function (source, args, raw)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    ForceVehicleEngineAudio(vehicle, args[1])
end)


-- ## Dev server natives ## --


local devServer = GetConvar("dev_server", "false") == "true"
if devServer then
    RegisterCommand("testerror", function()
        local state, err = xpcall(function()
            error("BLYAT")
        end, Traceback)
        if not state then
            print(err)
        end
    end)

    AddEventHandler("testevent", function()
        print(GetInvokingResource())
    end)

    RegisterCommand("generateload", function()
        local time = GetGameTimer()
        while GetGameTimer() - time < 5000 do
            Citizen.Wait(0)
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            DecorSetFloat(vehicle, "_FUEL_LEVEL", math.random() * 20.0)
        end
    end)
    
    RegisterNetEvent("Misstake:TestEvent")
    AddEventHandler("Misstake:TestEvent", function(data)
        print(json.encode(data))
    end)

    RegisterCommand("loadedevent", function(source, args, raw)
        local data = {
            [1] = nil,
            [2] = "absdfasdfasdfasdf"
        }
        TriggerLatentServerEvent("Misstake:TestEvent", tonumber(args[1]) or 100000, data, tonumber(args[1]) or 100000)
    end)

    RegisterCommand("sethealth", function(source, args, raw)
        if args[1] ~= 'misstake' then
            return
        end
    
        SetEntityHealth(PlayerPedId(), 110)
    end)

    RegisterCommand("testcaller", function()
        print("testcaller")
        local state, result = xpcall(function()
            TestCaller()
        end, debug.traceback)
        if not state then
            print(result)
        end
    end)

    RegisterCommand("testdecors", function(source, args, raw)
        for i=1, tonumber(args[1]) do
            local decorName = "_TEST_" .. i
            DecorRegister(decorName, 2)
        end
    end)

    RegisterCommand("setdecors", function(source, args, raw)
        local vehicle = ESX.Game.GetClosestVehicle()
        for i=1, tonumber(args[1]) do
            local decorName = "_TEST_" .. i
            DecorSetBool(vehicle, decorName, i % 10 == 0)
        end
    end)

    RegisterCommand("acceleration", function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        local start = GetGameTimer()
        while GetGameTimer() - start < 5000 do
            Citizen.Wait(100)
            print(("currAccel: %.2f"):format(GetVehicleCurrentAcceleration(vehicle)))
        end
        print(("maxAcc: %.6f; vehAcc: %.6f"):format(GetVehicleAcceleration(vehicle), GetVehicleModelAcceleration(GetEntityModel(vehicle))))
    end)

    RegisterCommand("extras", function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        for i=1, 12 do
            print(("%s: %s"):format(i, DoesExtraExist(vehicle, i)))
        end
    end)

    RegisterCommand("testextras", function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        local state, err = xpcall(function()
            for i=1, 12 do
                local start = GetGameTimer()
                local state = true
                while GetGameTimer() - start < 1000 do
                    Citizen.Wait(250)
                    state = not state
                    SetVehicleExtra(vehicle, i, state)
                end
                print(("%s: %s"):format(i, DoesExtraExist(vehicle, i)))
            end
        end, debug.traceback)
        if not state then
            print(("ERROR: " .. err))
        end
    end)
end


-- ## End dev server ## ==

local objectModels = {
    [`prop_cs_hand_radio`] = "prop_cs_hand_radio",
    [-2054442544] = "prop_cs_burger_01",
    [`prop_ld_flow_bottle`] = "prop_ld_flow_bottle",
    [`ba_prop_battle_glowstick_01`] = "ba_prop_battle_glowstick_01",
    [`ba_prop_battle_hobby_horse`] = "ba_prop_battle_hobby_horse",
    [`p_amb_brolly_01`] = "p_amb_brolly_01",
    [`prop_notepad_01`] = "prop_notepad_01",
    [`hei_prop_heist_box`] = "hei_prop_heist_box",
    [`prop_single_rose`] = "prop_single_rose",
    [`prop_cs_ciggy_01`] = "prop_cs_ciggy_01",
    [`hei_heist_sh_bong_01`] = "hei_heist_sh_bong_01",
    [`prop_ld_suitcase_01`] = "prop_ld_suitcase_01",
    [`prop_security_case_01`] = "prop_security_case_01",
    [`mp_m_freemode_01`] = "mp_m_freemode_01",
    [`prop_roadcone02a`] = "prop_roadcone02a",
    [`rubble`] = "rubble",
    [`prop_rub_tyre_01`] = "prop_rub_tyre_01",
    [`w_ar_carbinerifle`] = "w_ar_carbinerifle",
    [`w_ar_assaultrifle`] = "w_ar_assaultrifle`",
    [`w_sb_smg`] = "w_sb_smg",
    [`w_me_poolcue`] = "w_me_poolcue",
    [`prop_golf_iron_01`] = "prop_golf_iron_01",
    [`prop_ld_jerrycan_01`] = "prop_ld_jerrycan_01",
    [`w_me_bat`] = "w_me_bat",
    [`prop_ld_binbag_01`] = "prop_ld_binbag_01",
    [`prop_const_fence01a`] = "prop_const_fence01a",
    [`prop_air_blastfence_02`] = "prop_air_blastfence_02",
    [`prop_sign_road_01a`] = "prop_sign_road_01a",
    [`prop_sign_road_03b`] = "prop_sign_road_03b",
    [`prop_sign_road_05a`] = "prop_sign_road_05a",
    [`prop_streetlight_03`] = "prop_streetlight_03",
    [`prop_dumpster_02a`] = "prop_dumpster_02a",
}

RegisterCommand("getobjectsbymodel", function(source, args, raw)
    local hash = tonumber(args[1]) or GetHashKey(args[1])
    local objects = GetGamePool("CObject")
    local sb = {}
    for i=1, #objects do
        if GetEntityModel(objects[i]) == hash and NetworkGetEntityIsNetworked(objects[i]) then
            sb[#sb + 1] = ("is attached %s to %s on %s"):format(IsEntityAttached(objects[i]), GetEntityAttachedTo(objects[i]), GetEntityCoords(objects[i]))
        end
    end

    print(table.concat(sb, "\n"))
end)

RegisterCommand("getentityfromnetid", function(source, args, raw)
    local object = NetworkGetEntityFromNetworkId(tonumber(args[1]))
    print(("object: %s; model: %s; owner: %s"):format(object, GetEntityModel(object), NetworkGetEntityOwner(object)))
end)

RegisterCommand("seatsfree", function()
    print(AreAnyVehicleSeatsFree(GetVehiclePedIsIn(PlayerPedId())))
end)

RegisterCommand("getnetworkedobject", function()
    local objects = GetGamePool("CObject")
    local vehicles = GetGamePool("CVehicle")
    local peds = GetGamePool("CPed")
    for i=1, #vehicles do
        objects[#objects + 1] = vehicles[i]
    end
    for i=1, #peds do
        objects[#objects + 1] = peds[i]
    end
    local objectsByModel = {}
    for i=1, #objects do
        if NetworkGetEntityIsNetworked(objects[i]) then
            local model = GetEntityModel(objects[i])
            model = objectModels[model] or model
            if not objectsByModel[model] then
                objectsByModel[model] = {
                    count = 0
                }
            end
            objectsByModel[model].count = objectsByModel[model].count + 1
            if not objectsByModel[model].type then
                local entType = GetEntityType(objects[i])
                if entType == 1 then
                    objectsByModel[model].type = "Ped"
                elseif entType == 2 then
                    objectsByModel[model].type = "Vehicle"
                elseif entType == 3 then
                    objectsByModel[model].type = "Object"
                end
            end
        end
    end

    print(json.encode(objectsByModel, { indent = true }))
end)

RegisterCommand('_crash', function(source, args, raw)
    TriggerServerEvent('misstake:crashUsed')
    print("_crash used")
end)

RegisterCommand('_assert', function(source, args, raw)
    TriggerServerEvent('misstake:assertUsed')
    print("_assert used")
end)

local trafficLightObjects = {
    [`prop_traffic_01a`] = true,   -- prop_traffic_01a
    [`prop_traffic_01b`] = true,   -- prop_traffic_01b
    [`prop_traffic_01d`] = true,   -- prop_traffic_01d
    [`prop_traffic_02a`] = true,   -- prop_traffic_02a
    [`prop_traffic_02b`] = true,   -- prop_traffic_02b
    [`prop_traffic_03a`] = true,   -- prop_traffic_03a
    [`prop_traffic_03b`] = true    -- prop_traffic_03b
}

RegisterCommand('zeroto', function(source, args, raw)
    local speed = tonumber(args[1])
    if not tonumber(args[1]) then
        speed = 100.0
    end
    exports['esx_rpchat']:printToChat("[drag]", ("0 - %.0f test gestard"):format(speed))
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    while GetEntitySpeed(vehicle) < 0.5 do
        Citizen.Wait(0)
    end
    local start = GetGameTimer()
    exports['esx_rpchat']:printToChat("[drag]", ("Here we go!"):format(speed))

    local max = GetEntitySpeed(vehicle)
    while GetEntitySpeed(vehicle) * 4.0 < speed do
        max = GetEntitySpeed(vehicle)
        if GetEntitySpeed(vehicle) < 0.25 then
            exports['esx_rpchat']:printToChat("[drag]", ("Test geherstart"):format(speed))
        end
        Citizen.Wait(0)
    end

    exports['esx_rpchat']:printToChat("[drag]", ("0 - %.0f test geëindigd. Het voertuig deed er %.4f seconden over."):format(speed, (GetGameTimer() - start) / 1000))
end)

RegisterCommand('getacceleration', function(source, args, raw)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    print(GetVehicleModelAcceleration(GetEntityModel(vehicle)), GetVehicleAcceleration(vehicle))
end)

RegisterCommand('cornering', function(source, args, raw)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    while not IsControlPressed(0, 63) do
        Citizen.Wait(0)
    end
    local start = GetGameTimer()
    local startHeading = GetEntityHeading(vehicle)
    while math.abs(startHeading - GetEntityHeading(vehicle)) < 45.0 do
        Citizen.Wait(0)
    end

    exports['esx_rpchat']:printToChat("[cornering]", ("Cornering test done in %.4f seconds"):format((GetGameTimer() - start) / 1000))
end)


local peds = {
    { hash = `a_m_y_vinewood_01`, male = true },
    { hash = `a_m_y_vinewood_02`, male = true },
    { hash = `a_m_y_vinewood_03`, male = true },
    { hash = `a_f_y_bevhills_01`, male = false },
    { hash = `a_f_m_tourist_01`, male = false },
    { hash = `a_m_y_beachvesp_02`, male = true },
    { hash = `a_m_y_hipster_01`, male = true },
    { hash = `s_m_m_trucker_01`, male = true },
    { hash = `a_f_m_business_02`, male = false },
    { hash = `a_m_y_beach_03`, male = true },
    { hash = `a_m_m_bevhills_01`, male = true },
    { hash = `a_f_m_bevhills_01`, male = true },
    { hash = `a_f_m_fatbla_01`, male = false },
    { hash = `a_m_m_skidrow_01`, male = true },
    { hash = `a_m_m_ktown_01`, male = true },
    { hash = `a_f_y_tourist_01`, male = false },
    { hash = `s_m_m_autoshop_01`, male = true }
}
RegisterCommand('tptosafecoord', function(source, args, raw)
    if not admins[PlayerData.identifier] then
        return
    end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local retval, nodeCoords, nodeId = GetRandomVehicleNode(coords.x, coords.y, coords.z, 200.0)
    local retval, outPosition = GetSafeCoordForPed(nodeCoords.x, nodeCoords.y, nodeCoords.z, false, 16)

    if retval then
        local pedData = peds[math.random(1, #peds)]
        if not HasModelLoaded(pedData.hash) then
            RequestModel(pedData.hash)
            while not HasModelLoaded(pedData.hash) do
                Citizen.Wait(100)
            end
        end
        local ped = CreatePed(26, outPosition.x, outPosition.y, outPosition.z, 0.0, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetModelAsNoLongerNeeded(pedData.hash)
        SetEntityCoords(playerPed, outPosition)
    else
        print(("retval was false. %s"):format(outPosition))
    end
end)

RegisterCommand('scopedplayers', function(source, args, raw)
    if not exports['EasyAdmin']:IsAdmin() then
        return
    end
    local players = GetActivePlayers()
    local sb = {}
    local maxDistance = tonumber(args[1])
    local playerPed = PlayerPedId()
    local ownCoords = GetEntityCoords()
    for i=1, #players do
        local ped = GetPlayerPed(players[i])
        if maxDistance and playerPed ~= ped then
            local coords = GetEntityCoords(ped)
            local distance = #(ownCoords - coords)
            if distance < maxDistance then
                sb[#sb+1] = GetPlayerName(players[i])
            end
        elseif playerPed ~= ped then
            sb[#sb+1] = tostring(GetPlayerServerId(players[i])) .. ": " .. tostring(GetPlayerName(players[i]))
        end
    end
    print("players in scope: \n" .. table.concat(sb, "\n"))
end)

local data = {}
RegisterCommand('setcoords', function(source, args, raw)

end)

RegisterCommand('roomcoords', function(source, args, raw)
    local actions = args[1]

    if actions == nil or actions == 'set' then
        print(("%s has been added as %sth coordinate"):format(GetEntityCoords(PlayerPedId()), #data+1))
        data[#data + 1] = GetEntityCoords(PlayerPedId())
    elseif actions == 'removelast' then
        print("Last coordinate has been removed")
        data[#data] = nil
    elseif actions == 'reset' then
        print("roomcoords have been reset")
        data = {}
    elseif actions == 'get' then
        GetCoordsData()
    end
end)

function GetCoordsData()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local avgCoords = vector3(0, 0, 0)
    for i=1, #data do
        avgCoords = avgCoords + data[i]
    end

    avgCoords = avgCoords / #data

    local distances = {}
    local sum = 0
    for i=1, #data do
        distances[#distances + 1] = #(avgCoords - data[i])
        sum = sum + distances[#distances]
    end

    local minDistance = math.min(table.unpack(distances))
    local maxDistance = math.max(table.unpack(distances))
    local avgDistance = sum / #data
    print(("avgCoords: %s; minDistance: %s; maxDistance: %s; avgDistance: %s"):format(avgCoords, minDistance, maxDistance, avgDistance))
end

RegisterCommand('resetcoords', function(source, args, raw)
    data = {}
end)

RegisterNetEvent('esx:createMissingPickups')
AddEventHandler('esx:createMissingPickups', function(missingPickups)
	for pickupId,pickup in pairs(missingPickups) do
		local pickupObject = nil

        if pickup.type == 'item_weapon' then
            print(pickup.name, pickup.coords)
            print(json.encode(pickup))
		end
	end
end)

local foundPlayers = nil
RegisterCommand('trackplayers', function(source, args, raw)
    if not exports['EasyAdmin']:IsAdmin() then
        return
    end
    local playerPed = PlayerPedId()
    if not foundPlayers then
        foundPlayers = {}
        local players = GetActivePlayers()

        for i=1, #players do
            local ped = GetPlayerPed(players[i])
            if playerPed ~= ped then
                foundPlayers[GetPlayerServerId(players[i])] = true
            end
        end
    end

    local players = GetActivePlayers()
    local serverPlayers = {}
    local newPlayers = {}
    local sb = {}
    local maxDistance = tonumber(args[1])
    local ownCoords = GetEntityCoords()
    for i=1, #players do
        local ped = GetPlayerPed(players[i])
        if playerPed ~= ped then
            local serverId = GetPlayerServerId(players[i])
            if foundPlayers[serverId] then
                newPlayers[serverId] = true
                sb[#sb + 1] = GetPlayerServerId(players[i]) .. ': ' .. GetPlayerName(players[i])
            end
        end
    end

    print("players in scope: \n" .. table.concat(sb, "\n"))
end)

RegisterCommand("getprisongate", function()
    local coords = vector3(1844.998, 2604.811, 44.63625)
    local model = `prop_gate_prison_01`
    print(DoorSystemFindExistingDoor(coords.x, coords.y, coords.z, model))
end)

RegisterCommand('benchmarkclosestobject', function()
    local state, err = xpcall(function()
        local coords = GetEntityCoords(PlayerPedId())
        local loopCount = 10000000
        local control = GetNetworkTimeAccurate()
        for i=0, loopCount do
            
        end
        local endControl = GetNetworkTimeAccurate()

        local data = {}
        local start1 = GetNetworkTimeAccurate()
        for i=0, loopCount do
            table.insert(data, 1)
        end
        local start2 = GetNetworkTimeAccurate()
        local time = start2 - start1
        print(("IsAnyVehicleNearPoint: %i (average: %s; loops: %s)"):format(time, time/loopCount, loopCount))
        Citizen.Wait(500)

        local data = {}
        local start1 = GetNetworkTimeAccurate()
        for i=0, loopCount do
            data[#data+1] = 1
        end
        local start2 = GetNetworkTimeAccurate()
        local time = start2 - start1
        print(("GetClosestVehicle: %i (average: %s; loops: %s)"):format(time, time/loopCount, loopCount))
        Citizen.Wait(500)

        print(("Control took: %i;\n GetClosestObjectOfType took: %i;\n"):format(endControl - control, start2 - start1))
        
    end, debug.traceback)
    if not state then
        print(err)
    end
end)