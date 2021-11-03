--[[
	id: p-tNYiH_mZOvNjsmkXi94
	name: Eskiev-C
	description: eskiev client
	time1: 2021-04-24 18:59:33.999494+00
	time2: 2021-04-24 18:59:33.999495+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

local houseCoord = vector3(2337.6091308594, 3050.966796875, 48.151741027832)
local carSpawnCoord = vector3(2351.3017578125, 3038.4077148438, 48.152084350586)
local carModel = GetHashKey("benson")
local minPoliceCount = 6
local busy = false

QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local playerPed = PlayerPedId()
local playerCoord = GetEntityCoords(playerPed)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        playerPed = PlayerPedId()
        playerCoord = GetEntityCoords(playerPed)
    end
end)

Citizen.CreateThread(function()
    local houseBlip = AddBlipForCoord(houseCoord)
    SetBlipSprite(houseBlip, 84)
    SetBlipDisplay(houseBlip, 2)
    SetBlipScale(houseBlip, 0.7)
    SetBlipColour(houseBlip, 47)
    SetBlipAsShortRange(houseBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("İllegal Ev")
    EndTextCommandSetBlipName(houseBlip)

    while true do
        local time = 1000
        local distance = #(houseCoord - playerCoord)
        if distance < 5 and coreLoaded  then
            time = 1
            local text = ""
            if distance < 2 then 
                text = "[E]"
                if IsControlJustPressed(0,38) then
                    QBCore.Functions.TriggerCallback('tgiann-base:polis-sayi', function(AktifPolis)
                        if AktifPolis > minPoliceCount then
                            QBCore.Functions.TriggerCallback('tgiann-eskiev:check-house', function(status)
                                if status then
                                    if QBCore.Functions.IsSpawnPointClear(carSpawnCoord, 3) then
                                        QBCore.Functions.SpawnVehicle(carModel, function(veh)
                                            QBCore.Functions.Notify("Araç Dışarıda Git Al! Yalnız Aracın Arka Kasasındakileri Açman İçin Yeşil Kart Lazım!", "primary", 15000)
                                            local plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(veh))
                                            TriggerServerEvent("tgiann-eskiev:setVehiclePlate", QBCore.Key, plate, false)
                                            TriggerEvent("x-hotwire:give-keys", veh, plate)
                                        end, {x=carSpawnCoord.x, y=carSpawnCoord.y, z=carSpawnCoord.z, h=356.0 }, true)
                                    else
                                        QBCore.Functions.Notify("Araç Çıkarma Noktasının Yakınlarında Bir Araç Olduğu İçin Araç Çıkartılamıyor!", "error")
                                    end
                                end
                            end)
                        else
                            QBCore.Functions.Notify("Yeterli Sayıda Polis Yok!", "error")
                        end
                    end)
                    Citizen.Wait(1000)
                end
            end
            QBCore.Functions.DrawText3D(houseCoord.x, houseCoord.y, houseCoord.z, text.." Soygun Aracının Anahtarını Al!")
        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent('tgiann-eskiev:checkCar')
AddEventHandler('tgiann-eskiev:checkCar', function()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle(playerCoord)
    local vehicleModel = GetEntityModel(vehicle)
    if distance < 10 then
        if vehicleModel == carModel then
            QBCore.Functions.TriggerCallback('tgiann-base:polis-sayi', function(AktifPolis)
                if AktifPolis > minPoliceCount then
                    local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
                    local doorCoord = GetWorldPositionOfEntityBone(vehicle, trunk)
                    if #(doorCoord - playerCoord) < 3 then
                        if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                            local plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
                            busy = true
                            QBCore.Functions.TriggerCallback('tgiann-eskiev:checCarStatus', function(status)
                                if status then
                                    TriggerEvent("Tgiann-PolisBildirim:BildirimGonder", "Madde-X Aracı Soygunu", false)
                                    QBCore.Functions.Progressbar("searchVeh", "Aracın İçi Aranıyor", 900000, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {
                                        animDict = "missexile3",
                                        anim = "ex03_dingy_search_case_base_michael",
                                        flags = 49,
                                    }, {}, {}, function() -- Done
                                        TriggerServerEvent("tgiann-eskiev:giveItem", QBCore.Key, plate)
                                        Citizen.Wait(1000)
                                        busy = false
                                    end, function() -- Cancel
                                        TriggerServerEvent("tgiann-base:soygunKontrolReset", QBCore.Key)
                                        TriggerServerEvent("tgiann-eskiev:setVehiclePlate", QBCore.Key, plate, false)
                                        busy = false
                                    end)
                                else
                                    Citizen.Wait(2000)
                                    busy = false
                                end
                            end, plate)
                        else
                            QBCore.Functions.Notify("Bagaj Kapağı Açık Değil!", "error")
                        end
                    else
                        QBCore.Functions.Notify("Aracın Arka Kapısına Yakın Değilsin!", "error")
                    end
                else
                    QBCore.Functions.Notify("Yeterli Sayıda Polis Yok!", "error")
                end
            end)
        else
            QBCore.Functions.Notify("Yakınlarındaki Araç Doğru Araç Değil!", "error")
        end
    end
end)