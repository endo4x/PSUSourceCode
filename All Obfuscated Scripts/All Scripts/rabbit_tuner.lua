--[[
	id: a6IW9C3ugAjGPwSb0Rp-D
	name: rabbit_tuner
	description: rabbit_tuner
	time1: 2021-06-05 12:13:26.182524+00
	time2: 2021-06-05 12:13:26.182524+00
	uploader: ZH4u5LG9MD3BlPHFzMXwA1YMRpSby5UU2AErUrhR
	uploadersession: qjU71wXM--x4nAuJonEbvdGN2UwxGP
	flag: f
--]]

ESX = nil
scriptName = GetCurrentResourceName()
local Config = {}
local lastVeh = false
local lastData = false
local gotOut = false
local lastStats = nil
local firstStats = nil
local focus = false
local showUI = false

local myDefaultVehicle = {}
local myLastVehicle = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)

        ESX.TriggerServerCallback(scriptName .. ':sv:getConfig', function(config)
            if config then
                Config = config
                Wait(1000)
                LoadScript()
            end
        end)
    end
end)

function LoadScript()

    RegisterNetEvent(scriptName .. ":cl:use_tuner")
    AddEventHandler(scriptName .. ":cl:use_tuner", function()
        if not showUI then
            onShowUI()
        else
            return
        end
    end)

    -- Controls
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if IsControlJustReleased(1, 19) then
                Citizen.Wait(300)
                onFocus()
            end
            if IsControlJustReleased(1, 73) then
                Citizen.Wait(300)
                SendNUIMessage({
                    app = "REACTNUI",
                    method = "clearTrackerData"
                })
            end

        end
    end)

    function checkHasItem(item_name, item_amount)
        local inventory = ESX.GetPlayerData().inventory
        for i = 1, #inventory do
            local item = inventory[i]
            if item_name == item.name and tonumber(item.count) >= tonumber(item_amount) then
                return true
            end
        end
        return false
    end

    function onFocus()
        if showUI then
            if not focus then
                SetNuiFocus(true, true)
            else
                SetNuiFocus(false, false)
            end
            focus = not focus
        end
    end

    function onShowUI()

        if showUI then
            closeUI()
        end

        local ped = GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped then
            local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local currSpd = GetEntitySpeed(veh)
            speed = math.floor(currSpd * 3.6)
            if speed > 0 then
                textNotification("error",
                    "กรุณาจอดรถให้อยู่นิ่งๆ ก่อนทำการจูน",
                    5500)
                return false
            end

            showUI = true
            focus = false
            Wait(100)
            onFocus()
            SendNUIMessage({
                app = "REACTNUI",
                method = "setVisibility",
                data = true
            })

            local vehDefault = myDefaultVehicle[lastData.plate]
            local vehLast = myLastVehicle[lastData.plate] or vehDefault

            local min = Config.MinDefault
            if Config.Vehicles[string.lower(lastData.modelName)] then
                if Config.Vehicles[string.lower(lastData.modelName)].min ~= nil then
                    min = Config.Vehicles[string.lower(lastData.modelName)].min
                end
            end

            local max = Config.MaxDefault
            if Config.Vehicles[string.lower(lastData.modelName)] then
                if Config.Vehicles[string.lower(lastData.modelName)].max ~= nil then
                    max = Config.Vehicles[string.lower(lastData.modelName)].max
                end
            end

            dprint(vehLast.secret)

            SendNUIMessage({
                app = "REACTNUI",
                method = "setVehicleData",
                data = {
                    setData = true,
                    modelName = lastData.modelName or "",
                    plate = lastData.plate or "",
                    minData = {
                        boost = min.boost,
                        intertia = min.intertia,
                        topSpeed = min.topSpeed,
                        braking = min.braking,
                        drivetrain = min.drivetrain,
                        brakeforce = min.brakeforce
                    },
                    maxData = {
                        boost = max.boost,
                        intertia = max.intertia,
                        topSpeed = max.topSpeed,
                        braking = max.braking,
                        drivetrain = max.drivetrain,
                        brakeforce = max.brakeforce
                    },
                    defaultData = {
                        secret = false,
                        boost = vehDefault.boost,
                        intertia = vehDefault.intertia,
                        topSpeed = vehDefault.topSpeed,
                        braking = vehDefault.braking,
                        drivetrain = vehDefault.drivetrain,
                        brakeforce = vehDefault.brakeforce
                    },
                    data = {
                        secret = vehLast.secret,
                        boost = vehLast.boost,
                        intertia = vehLast.intertia,
                        topSpeed = vehLast.topSpeed,
                        braking = vehLast.braking,
                        drivetrain = vehLast.drivetrain,
                        brakeforce = vehLast.brakeforce
                    }
                }
            })
        else
            textNotification("error", "ขึ้นรถก่อน ก่อนทำการจูน", 5500)
        end
    end

    function closeUI()
        showUI = false
        SetNuiFocus(false, false)
        SendNUIMessage({
            app = "REACTNUI",
            method = "setVisibility",
            data = false
        })
    end

    function dprint(message)
        local dbug = false
        if dbug then
            print(tostring(message))
        end
    end

    function textNotification(type, text)
        if type and text then
            exports['mythic_notify']:SendAlert(type, text, 5500, true)
        end
    end

    function getVehData(veh)
        if not DoesEntityExist(veh) then
            return nil
        end

        local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
        dprint('modelName: ' .. modelName)

        local lvehstats = {
            plate = GetVehicleNumberPlateText(veh),
            modelName = modelName,
            boost = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce"),
            intertia = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia"),
            topSpeed = 1.0,
            braking = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront"),
            drivetrain = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront"),
            brakeforce = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce")
        }

        dprint(json.encode(lvehstats))
        if myDefaultVehicle[lvehstats.plate] == nil then
            myDefaultVehicle[lvehstats.plate] = lvehstats
        end
        lastData = lvehstats
        dprint(json.encode(myDefaultVehicle))
        return lvehstats
    end

    function setVehData(veh, data, save)
        if not DoesEntityExist(veh) or not data then
            return false
        end
        SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost * 1.0)
        SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", data.intertia * 1.0)
        SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.braking * 1.0)
        SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", data.drivetrain * 1.0)
        SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", data.brakeforce * 1.0)
        ModifyVehicleTopSpeed(veh, data.topSpeed * 1.0)
        local lvehstats = {
            plate = GetVehicleNumberPlateText(veh),
            modelName = GetDisplayNameFromVehicleModel(GetEntityModel(veh)),
            boost = data.boost * 1.0,
            intertia = data.intertia * 1.0,
            topSpeed = data.topSpeed * 1.0,
            braking = data.braking * 1.0,
            drivetrain = data.drivetrain * 1.0,
            brakeforce = data.brakeforce * 1.0,
            secret = data.secret
        }

        myLastVehicle[lvehstats.plate] = lvehstats

        dprint('myLastVehicle : ' .. json.encode(myLastVehicle))

        local vehDefault = myDefaultVehicle[lastData.plate]

        local defaultData = {
            boost = vehDefault.boost,
            intertia = vehDefault.intertia,
            topSpeed = vehDefault.topSpeed,
            braking = vehDefault.braking,
            drivetrain = vehDefault.drivetrain,
            brakeforce = vehDefault.brakeforce
        }

        if save then
            TriggerServerEvent(scriptName .. ':sv:setData', data, defaultData, lvehstats.plate)
            myLastVehicle[lvehstats.plate].secret = 'no'
        end
    end

    RegisterNUICallback("OnSave", function(data, cb)
        dprint(json.encode(data))
        if checkHasItem("tuning_laptop", 1) then

            local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local currSpd = GetEntitySpeed(veh)
            speed = math.floor(currSpd * 3.6)

            if speed > 0 then
                textNotification("error",
                    "กรุณาจอดรถให้อยู่นิ่งๆ ก่อนทำการจูน",
                    5500)
                return false
            end

            ESX.TriggerServerCallback(scriptName .. ':sv:save', function(isHave)
                if isHave then
                    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                    if not IsPedInAnyVehicle(GetPlayerPed(-1)) or GetPedInVehicleSeat(veh, -1) ~= GetPlayerPed(-1) then
                        return
                    end
                    setVehData(veh, data.data, true)
                    lastVeh = veh
                    lastStats = data.data
                else
                    textNotification("error", "คุณไม่มีที่จูน", 5500)
                end
            end)
        else
            textNotification("error", "คุณไม่มีที่จูน", 5500)
        end
    end)

    RegisterNUICallback("Close", function(data, cb)
        closeUI()
    end)

    Citizen.CreateThread(function(...)
        while not ESX do
            Citizen.Wait(0);
        end
        while not ESX.IsPlayerLoaded() do
            Citizen.Wait(0);
        end
        while true do
            local sleep = 1000
            if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                Citizen.Wait(300)
                sleep = 0
                local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                if veh ~= lastVeh or gotOut then
                    local xvehStat = getVehData(veh)
                    if gotOut then
                        gotOut = false;
                    end
                    local responded = false
                    ESX.TriggerServerCallback(scriptName .. ':sv:getData', function(doTune, stats, default)
                        if doTune then
                            if stats then
                                myDefaultVehicle[GetVehicleNumberPlateText(veh)] = default
                                setVehData(veh, stats, false)
                                lastStats = default
                                dprint(json.encode(stats))
                                dprint '-----'
                                dprint(json.encode(default))
                            else
                                setVehData(veh, xvehStat, false)
                                lastStats = xvehStat
                            end
                        end
                        lastVeh = veh
                        responded = true
                    end, GetVehicleNumberPlateText(veh))
                    while not responded do
                        Citizen.Wait(0);
                    end
                end
            else
                if not gotOut then
                    gotOut = true
                end
                if showUI then
                    closeUI()
                end
            end
            Citizen.Wait(sleep)
        end
    end)

    local startTime = 0
    local oneHundred = false
    local oneHundredScore = 0
    local twoHundred = false
    local twoHundredScore = 0
    local time = false

    Citizen.CreateThread(function()
        while true do
            local sleep = 1000
            if IsPedInAnyVehicle(GetPlayerPed(-1)) and showUI then
                sleep = 0
                local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                local currSpd = GetEntitySpeed(veh)
                speed = math.floor(currSpd * 3.6)

                if speed > 0 and startTime <= 0 then
                    startTime = GetGameTimer()
                    time = true
                end

                local time_label = ("%.3fs"):format((GetGameTimer() - startTime) / 1000)
                if speed >= 100 and not oneHundred then
                    oneHundred = true
                    SendNUIMessage({
                        app = "REACTNUI",
                        method = "setSpeedTracker",
                        data = {
                            type = "100",
                            value = time_label
                        }
                    })
                elseif speed >= 200 and oneHundred and not twoHundred then
                    twoHundred = true
                    SendNUIMessage({
                        app = "REACTNUI",
                        method = "setSpeedTracker",
                        data = {
                            type = "200",
                            value = time_label
                        }
                    })
                end

                if speed <= 0 then
                    twoHundred = false
                    oneHundred = false
                    startTime = 0
                end

            end
            Citizen.Wait(sleep)
        end
    end)
end

