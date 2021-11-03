--[[
	id: D_qHLftQrJqJ9ZbXlQHvO
	name: esx_ets
	description: camion import
	time1: 2021-04-24 17:41:02.271779+00
	time2: 2021-04-24 17:41:02.27178+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

ESX = nil
local PlayerData, startBlip, working = {}, nil, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local lastTested = 0
Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    PlayerData = ESX.GetPlayerData()
    while true do
        local me, sleep, hasjob = PlayerPedId(), 250, true
        if Config.Job['jobRequired'] then
            if PlayerData.job.name ~= Config.Job['jobName'] then
                hasjob = false
            end
        end
        if working then hasjob = false end
        if hasjob then
            if not DoesBlipExist(startBlip) then
                startBlip = addBlip(Config.JobCenter, 545, 0, Strings['start_job'])
            end
        else
            if DoesBlipExist(startBlip) then
                RemoveBlip(startBlip)
            end
        end
        local distance = GetDistanceBetweenCoords(GetEntityCoords(me), Config.JobCenter, true)
        if distance <= 25.0 and hasjob then
            sleep = 0
            DrawMarker(27, Config.JobCenter, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 0, 255, 150, false, false, 2, false, false, false)
            if distance <= 1.5 then
                helpText(Strings['e_browse_jobs'])
                if IsControlJustPressed(0, 38) then
                    if  GetGameTimer() - lastTested > 0 * 60000 then
						lastTested = GetGameTimer()
							TriggerServerEvent('esx_ets:jobMenu')
					else
						local timerNewChop = 0 * 60000 - (GetGameTimer() - lastTested)
						exports.pNotify:SendNotification({
							text = "Comeback in " ..math.floor(timerNewChop / 60000).. " minute(s)",
							type = "error",
							timeout = 1000,
							layout = "centerRight",
							queue = "right",
							killer = true,
							animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
						})
					end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('esx_ets:start')
AddEventHandler('esx_ets:start', function(data, jobid)
    working = true
    local truck, trailer = loadVehicle(data.vehicles[1], data.start[1], data.start[2]), loadVehicle(data.vehicles[2], data.trailer[1], data.trailer[2])
    local destinationBlip, truckBlip, trailerBlip = addBlip(data.arrive, 38, 3, Strings['destination'])
    while true do
        local sleep, distance = 250, GetDistanceBetweenCoords(data.arrive, GetEntityCoords(trailer), true)
        if not IsPedInVehicle(PlayerPedId(), truck, false) then
            text(Strings['get_to_truck'], 250)
            if not DoesBlipExist(truckBlip) then
                truckBlip = addBlip(GetEntityCoords(truck), 477, 5, Strings['truck']) 
                SetBlipRoute(truckBlip, true) 
            end
            if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
        else
            if not IsVehicleAttachedToTrailer(truck, trailer) then
                text(Strings['get_to_trailer'], 250)
                if not DoesBlipExist(trailerBlip) then 
                    trailerBlip = addBlip(GetEntityCoords(trailer), 479, 5, Strings['trailer']) 
                    SetBlipRoute(trailerBlip, true) 
                end
                if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
            else
                if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end

                if not DoesBlipExist(destinationBlip) then
                    destinationBlip = addBlip(data.arrive, 38, 3, Strings['destination'])
                    SetBlipRoute(destinationBlip, true)
                end
            end
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
        end
        if distance <= 45.0 and IsPedInVehicle(PlayerPedId(), truck, false) and IsVehicleAttachedToTrailer(truck, trailer) then
            sleep = 0
            DrawMarker(1, data.arrive, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 255, 50, 150, false, false, 2, false, false, false)
            if distance <= 10.0 then
                while IsVehicleAttachedToTrailer(truck, trailer) do 
                    text(Strings['detach'], 250)
                    Wait(250)
                end
                break
            else
                text(Strings['park'])
            end
        else
            if IsPedInVehicle(PlayerPedId(), truck, false) and IsVehicleAttachedToTrailer(truck, trailer) then
                text(Strings['drive_destination'], 250)
            end
        end
        Wait(sleep)
    end
    -- DeleteVehicle(trailer)
    RemoveBlip(destinationBlip)
    RemoveBlip(trailerBlip)
    RemoveBlip(truckBlip)
    while true do
        local sleep, distance = 250, GetDistanceBetweenCoords(GetEntityCoords(truck), data.start[1], true)
        if not IsPedInVehicle(PlayerPedId(), truck, false) and distance >= 10.0 then
            text(Strings['get_to_truck'], 250)
            if not DoesBlipExist(truckBlip) then
                truckBlip = addBlip(GetEntityCoords(truck), 477, 5, Strings['truck']) 
                SetBlipRoute(truckBlip, true) 
            end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
        else
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
            if not DoesBlipExist(destinationBlip) then
                destinationBlip = addBlip(data.start[1], 38, 3, Strings['destination'])
                SetBlipRoute(destinationBlip, true)
            end
            if distance <= 30.0 then
                sleep = 0
                DrawMarker(1, data.start[1], vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 255, 50, 150, false, false, 2, false, false, false)
                if distance <= 10.0 then
                    if IsPedInVehicle(PlayerPedId(), truck, false) then
                        text(Strings['get_out'])
                    else
                        if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
                        if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
                        break
                    end
                else
                    text(Strings['park_truck'])
                end
            else
                text(Strings['drive_back'], 250)
            end
        end
        Wait(sleep)
    end
    local damages = {['windows'] = {}, ['tires'] = {}, ['doors'] = {}, ['body_health'] = GetVehicleBodyHealth(truck), ['engine_health'] = GetVehicleEngineHealth(truck)}
    for i = 0, GetVehicleNumberOfWheels(truck) do
        if IsVehicleTyreBurst(truck, i, false) then table.insert(damages['tires'], i) end 
    end
    for i = 0, 13 do
        if not IsVehicleWindowIntact(truck, i) then table.insert(damages['windows'], i) end
    end
    for i = 0, GetNumberOfVehicleDoors(truck) do 
        if IsVehicleDoorDamaged(truck, i) then table.insert(damages['doors'], i) end 
    end
    DeleteVehicle(truck)
    DeleteVehicle(trailer)
    working = false
    TriggerServerEvent('esx_ets:jobFinished', jobid, damages)
end)

RegisterNetEvent('esx_ets:menu')
AddEventHandler('esx_ets:menu', function(data)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'choose_job',
        {
            title = Strings['menu_title'],
            align = 'top-left',
            elements = data
        },
        function(data, menu)
            TriggerServerEvent('esx_ets:startJob', data.current.value)
            menu.close()
        end,
    function(data, menu)
        menu.close()
    end)
end)

text = function(text, duration)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(duration, 1)
end


loadVehicle = function(vehicle, coords, heading)
    local model
    if type(vehicle) == 'number' then model = vehicle else model = GetHashKey(vehicle) end
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    local car = CreateVehicle(model, coords, heading, true, false)
    SetEntityAsMissionEntity(car, true, true)
    return car
end

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

addBlip = function(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end