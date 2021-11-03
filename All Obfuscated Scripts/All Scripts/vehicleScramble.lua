--[[
	id: Lu_aOT6NEIKppLWYMYfF8
	name: vehicleScramble
	description: vehicleScramble
	time1: 2021-05-22 14:33:30.703972+00
	time2: 2021-05-22 14:33:30.703972+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
        TriggerEvent('KKBGaYWAm', function(obj) 
            ESX = obj 
        end)
		Citizen.Wait(0)
    end
    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('akOAwEOOO')
AddEventHandler('akOAwEOOO', function(xPlayer)
    PlayerData = xPlayer
end)

local Delay = false
local DelayCounter = 3000
local canSpawn = true
local DupeDelayVeh = false
----------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
		if DupeDelayVeh then
            DisableControlAction(0, 311,true)
        else
            EnableControlAction(0, 311,true)
        end
	end
end)
RegisterNetEvent('PRZtIrVMP')
AddEventHandler('PRZtIrVMP', function(vehicleModel)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(playerPed)
    DupeDelayVeh = true
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
      Citizen.Wait(0)
      TriggerEvent('zjPMtAuKi',true)
    end
    plate = math.random(0000001, 9999999)
    if 
        GetDistanceBetweenCoords(coords, -1831.901, -1220.13, 13.70545, true) < 30 or
        GetDistanceBetweenCoords(coords, 342.4698, -1398.107, 32.50964, true) < 30 or
        GetDistanceBetweenCoords(coords, 2132.95, 4782.288, 40.44, true) < 30 or
        GetDistanceBetweenCoords(coords, 1468.519, 6357.824, 23.25, true) < 30 or
        GetDistanceBetweenCoords(coords, 2768.77, 3473.263, 55.51377, true) < 30 or --IKEA
        GetDistanceBetweenCoords(coords, 324.984, -211.1148, 54.11214, true) < 30 or --MOTEL
        GetDistanceBetweenCoords(coords, -1678.865, -297.577, 51.81211, true) < 30 or 
        IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) or not canSpawn then
        ESX.ShowNotification("Burada Araç ~r~Çıkaramazsın! ")
        TriggerEvent('zjPMtAuKi',false)
        Citizen.Wait(2500)
        DupeDelayVeh = false
    else
        if not Delay then
            Delay = true
            DupeDelayVeh = true
            veh = CreateVehicle(vehicleModel, coords.x, coords.y, coords.z, heading, true, false)
            SetVehicleNumberPlateText(veh, plate)
            SetEntityVisible(playerPed, true)
            TaskWarpPedIntoVehicle(playerPed, veh, -1)
            Citizen.Wait(100)
            if DoesEntityExist(veh) then 
                TriggerServerEvent('AKSMYErPc', vehicleModel)
                TriggerEvent('zjPMtAuKi',false)
                Citizen.Wait(2500)
                DupeDelayVeh = false
                Citizen.Wait(DelayCounter)
                Delay = false
            else
                ESX.ShowNotification("Araç Oluşturulamadı!")
                TriggerEvent('zjPMtAuKi',false)
                Citizen.Wait(2500)
                DupeDelayVeh = false
                Citizen.Wait(DelayCounter)
                Delay = false
            end
        else
            ESX.ShowNotification("Daha yeni araç çıkardın! ")
            TriggerEvent('zjPMtAuKi',false)
            Citizen.Wait(2500)
            DupeDelayVeh = false
            Citizen.Wait(DelayCounter)
            Delay = false
        end
    end
end)

----------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not DupeDelayVeh then
            if IsControlJustReleased(0, 311) then
                DupeDelayVeh = true
                if not IsEntityDead(GetPlayerPed(-1)) then
                    local playerPed = GetPlayerPed(-1)
                    local veh = GetVehiclePedIsIn(playerPed)
                    if DoesEntityExist(veh) then 
                        if IsPedInAnyVehicle(playerPed) then 
                            if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
                                if GetEntitySpeed(veh) * 3.6 < 20 then
                                local veh = GetVehiclePedIsUsing(playerPed)
                                    vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
                                    deleteCar(veh)
                                    Wait(5)
                                    if not DoesEntityExist(veh) then 
                                        if vehName == "wastlndr" then
                                            store = 'wastelander' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        elseif vehName == "annihl" then
                                            store = 'annihilator' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        elseif vehName == "bfinject" then
                                            store = 'bfinjection' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        elseif vehName == "sanchez01" then
                                            store = 'sanchez' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        elseif vehName == "valkyri2" then
                                            store = 'valkyrie2' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        elseif vehName == "niteshad" then
                                            store = 'nightshade' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        elseif vehName == "washingt" then
                                            store = 'washington' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        elseif vehName == "trophy" then
                                            store = 'trophytruck' 
                                            TriggerServerEvent('dAOWbeKlD', store)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        else
                                            TriggerServerEvent('MVfuwEaNV', vehName)
                                            Delay = true
                                            Citizen.Wait(500)
                                            DupeDelayVeh = false
                                            Citizen.Wait(DelayCounter)
                                            Delay = false
                                        end
                                    else
                                        ESX.ShowNotification("Araç ~r~depolanamadı!")
                                        Citizen.Wait(500)
                                        DupeDelayVeh = false
                                        Citizen.Wait(DelayCounter)
                                        Delay = false
                                    end
                                else
                                    ESX.ShowNotification("Aracı ~r~hareket halindeyken ~w~depolayamazsın!")
                                    Citizen.Wait(500)
                                    DupeDelayVeh = false
                                    Citizen.Wait(DelayCounter)
                                    Delay = false
                                end
                            else
                                ESX.ShowNotification("Aracı depolamak için ~y~sürücü koltuğunda ~w~olman lazım!")
                                Citizen.Wait(500)
                                DupeDelayVeh = false
                                Citizen.Wait(DelayCounter)
                                Delay = false
                            end
                        end
                    end
                else
                    MenuOpen = false
                    ESX.ShowNotification("~r~Ölüyken yapamazsın!")
                    Citizen.Wait(500)
                    DupeDelayVeh = false
                end   
            end      
        else
            Citizen.Wait(1000)
            DupeDelayVeh = false         
        end
    end
end)

function deleteCar(entity)
    local timeout = 0 
    SetEntityAsMissionEntity(entity, true, true )
	ESX.Game.DeleteVehicle(entity)
   --Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
   -- Citizen.Wait(500)
   -- DupeDelayVeh = false
   -- if DoesEntityExist(entity) then
   --     
   --     Citizen.Wait(500)
   --     DupeDelayVeh = false
   -- else
   -- end
end

----

function shouldDisableCarSpawn()
	local playerPed = PlayerPedId()
	local playerModel = GetEntityModel(playerPed)
	local interiorId = GetInteriorFromEntity(playerPed)
	if interiorId ~= 0 then
		return true
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Wait(5)
		local inInterior = shouldDisableCarSpawn()
		if inInterior then
			canSpawn = false
		else
            canSpawn = true
			Wait(300)
		end
	end
end)