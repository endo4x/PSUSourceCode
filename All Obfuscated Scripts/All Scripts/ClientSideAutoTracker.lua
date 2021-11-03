--[[
	id: H59sjEnfjy0oFOahBtYci
	name: Client Side AutoTracker
	description: Client Side AutoTracker
	time1: 2021-04-23 14:38:35.470995+00
	time2: 2021-04-23 14:38:35.470996+00
	uploader: upmaKftPebf1aacTSUlrUVzIhYdYC6Nowa8t9ti2
	uploadersession: res167k3kt5XoYHIb4FdWDI5eEUNQn
	flag: f
--]]

ESX = nil
local time_out = {}
local blips_pos = {}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('EBBE-AutoTracker:checkPlateItem')
AddEventHandler('EBBE-AutoTracker:checkPlateItem', function()
    local playerPed = PlayerPedId()
    local radius = 2.5

    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)
    for k, enity in ipairs(vehicles) do
        local attempt = 0

        if DoesEntityExist(enity) then
           local plate = GetVehicleNumberPlateText(enity)
           local vehicleModel = GetEntityModel(enity)
           print(vehicleModel) 
           if vehicleModel == -921447650 then
            elseif vehicleModel == 113310255 then

            elseif vehicleModel == -208773665 then

            elseif vehicleModel == -877146670 then

            elseif vehicleModel  == 1771953372 then

            elseif vehicleModel == -1282819828 then
                
            elseif vehicleModel == 1068687227 then
            elseif vehicleModel == 1213930789 then
            elseif vehicleModel == -815183343 then
            elseif vehicleModel == 1918131831 then
            elseif vehicleModel == 777670663 then
            elseif vehicleModel == -918345638 then
            elseif vehicleModel == -233545208 then
            elseif vehicleModel == -1604336271 then
            elseif vehicleModel == -873360332 then
            elseif vehicleModel == 1634487993 then
            elseif vehicleModel == -1435272166 then
            elseif vehicleModel == -605984099 then
            elseif vehicleModel == -203953800 then
            elseif vehicleModel == 303009766 then
            elseif vehicleModel == 1961022156 then
            elseif vehicleModel == 1381010856 then
            elseif vehicleModel == 1009772238 then 
           else
                checkVehicle(plate)
           end
        end

    end
end)


Citizen.CreateThread(function()
    while isLoading == true do 
        Citizen.Wait(20000)
            TriggerServerEvent("EBBE-AutoTracker:getActivePlates")
            isLoading = false
    end
end)

RegisterNetEvent("EBBE-AutoTracker:getActivePlates")
AddEventHandler("EBBE-AutoTracker:getActivePlates", function(plates)
    time_out = plates
    for v,k in pairs(time_out) do
        checkVehicle(v)
    end
end)

function checkVehicle(plate)
    local vehicle = ESX.Game.GetVehicles()

    for i=1, #vehicle, 1 do 
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle[i])
        
        if vehicleProps.plate == plate then 
            TriggerServerEvent("EBBE-AutoTracker:setActivePlates", plate)
            time_out[plate] = false
            CreateVehicleTracker(vehicle[i], plate) 

        end 
    end
end


RegisterNetEvent("EBBE-AutoTracker:updateActivePlate")
AddEventHandler("EBBE-AutoTracker:updateActivePlate", function(plate)

    for v,k in pairs(time_out) do 
        if time_out[v] == plate then 
            time_out[plate] = true 
        end
    end
   
end)


function CreateVehicleTracker(vehicle, plate)
    Citizen.CreateThread(function()
        while time_out[plate] == false do
            Wait(50)

            if DoesEntityExist(vehicle) then 
       

                local x, y, z = table.unpack(GetEntityCoords(vehicle))
     

                if prev_pos == table.unpack(GetEntityCoords(vehicle)) then 
            
                else 


                    ESX.ShowNotification('Tracker Geactiveerd - ' .. plate)
                    RemoveBlip(blips_pos[plate])

                    local new_pos_blip = AddBlipForCoord(x,y,z)
                    local playerPed = PlayerPedId()

                    SetBlipSprite(new_pos_blip, 432)
                    SetBlipDisplay(new_pos_blip, 4)
                    SetBlipColour(new_pos_blip, 75)
                    SetBlipScale(new_pos_blip, 1.0)


                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Voertuig " .. plate)
                    EndTextCommandSetBlipName(new_pos_blip)

                    blips_pos[plate] = new_pos_blip
                    prev_pos = table.unpack(GetEntityCoords(vehicle))
                end

            else
                time_out[plate] = time_out[nil]
                TriggerServerEvent("EBBE-AutoTracker:removeActivePlate", plate)
                ESX.ShowNotification("Voertuig Tracker Verloren - " .. plate)
            end
        end 
        RemoveBlip(blips_pos[plate])
        time_out[plate] = time_out[nil]
        TriggerServerEvent("EBBE-AutoTracker:removeActivePlate", plate)
        ESX.ShowNotification("Voertuig Tracker Verloren - " .. plate)
    end)
end