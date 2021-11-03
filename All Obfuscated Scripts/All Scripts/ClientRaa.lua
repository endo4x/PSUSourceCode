--[[
	id: yBMij0SBtckwTfUaAdiml
	name: ClientRaa
	description: Raamwas
	time1: 2021-05-24 15:53:24.89598+00
	time2: 2021-05-24 15:53:24.89598+00
	uploader: A9CBWIbo5Q6vKFRuY5pwexbRm8hPvAysjjYX62CT
	uploadersession: rq5hmeWphhKyh6hPaKB_NKAeJZDZWw
	flag: f
--]]

    local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
EncoreHelper = {}
Rocket = {}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Rocket.Sharedobject, function(obj) ESX = obj end) 
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(10)
end)

local PlayerData = {}
local LaatstePlek = nil
local NuBezig = false
local NuBezigBericht = nil
local klaar = false
local SpulletjesGepakt = false
local autoweggezet = false
huidigeraam = 1
RamenGewassen = 0



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

--Code-- 
Citizen.CreateThread(function()
    while true do
        goodnight = true
        Citizen.Wait(5)
        local pos = GetEntityCoords(PlayerPedId())
        local takeDist = GetDistanceBetweenCoords(pos, Rocket.FactuurInleveren.x, Rocket.FactuurInleveren.y, Rocket.FactuurInleveren.z)
        if takeDist <= 11 then
            goodnight = false
        DrawMarker(2, Rocket.FactuurInleveren.x, Rocket.FactuurInleveren.y, Rocket.FactuurInleveren.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, 100, false, true, 2, true, false, false, false)
                end
        if takeDist <= 2 then
            goodnight = false
        DrawText3Ds(Rocket.FactuurInleveren.x, Rocket.FactuurInleveren.y, Rocket.FactuurInleveren.z, Rocket.DrawTextKleur ..'E~w~ - Factuur Inleveren!')
        if IsControlJustPressed(0, 38) then
            local aantal = 54584434443523427432743527423742775237523752372747834633255323542342432654323265432432654523423423324352344323452342
                    TriggerServerEvent('kdgnfsj,gsnfn:djfgnbskfnfrn', aantal)
                end
            end
        if goodnight then
            Citizen.Wait(1000)
        end   
    end     
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local pos = GetEntityCoords(PlayerPedId())
        local takeDist = GetDistanceBetweenCoords(pos, Rocket.Start.x, Rocket.Start.y, Rocket.Start.z)
        if takeDist <= 11 then
        DrawMarker(2, Rocket.Start.x, Rocket.Start.y, Rocket.Start.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, 100, false, true, 2, true, false, false, false)
    else
        Citizen.Wait(1000)
                end
        if takeDist <= 2 then
                DrawText3Ds(Rocket.Start.x, Rocket.Start.y, Rocket.Start.z, Rocket.DrawTextKleur ..'E~w~ - Job Beginnen!')
        if IsControlJustPressed(0, 38) then
            if not NuBezig then
            SpawnAuto()
            TriggerEvent('rocket-notify:grootnotify', 'Raamwas Job', 'Je hebt je voertuig gekregen, ga nu aan de slag!', 'fas fa-soap', '3000', '26ff92', '1000')
            CreateJobBlip()
            NuBezig = true
            autoweggezet = false
        else
            TriggerEvent('rocket-notify:grootnotify', 'Raamwas Job', 'Je bent al bezig met een ronde', 'fas fa-soap', '3000', '26ff92', '1000')
                    end 
                end
            end
    end     
end)

RegisterCommand('d', function(source, args, RawCommand)
    print(source)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
    local coords = GetEntityCoords(PlayerPedId())
    if NuBezig then
        if Rocket.Loc[huidigeraam] ~= nil then
            local dist = GetDistanceBetweenCoords(coords, Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z , true)
                if dist < 11 then
                    DrawMarker(2, Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, 100, false, true, 2, true, false, false, false)
                if dist < 5 and not IsPedInVehicle(PlayerPedId(), kankerautoneef, false) then 
                    DrawText3Ds(Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z, Rocket.DrawTextKleur ..'E~w~ - Raam Wassen!')
                    DrawMarker(2, Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, 100, false, true, 2, true, false, false, false)
                        if IsControlJustReleased(0, Keys["E"]) then
                            if SpulletjesGepakt then
                                local Player = PlayerPedId()
                                local prop1 = "prop_sponge_01"
                                local x,y,z = table.unpack(GetEntityCoords(Player))
                                prop = CreateObject(GetHashKey("prop_sponge_01"), x, y, z+0.2,  true,  true, true)
                                AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, 28422), 0.0, 0.0, -0.01, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
                                SetModelAsNoLongerNeeded(prop1)
                            Progressbar("ramenwassen", "Raam wassen..", 10000, false, true, {
                                disableMovement = true,
                                disableControls = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "amb@world_human_maid_clean@",
                                anim = "idle_e",
                                flags = 16,
                            }, {}, {}, function() 
                                    huidigeraam = huidigeraam + 1
                                    RamenGewassen = RamenGewassen + 1
                                    ClearPedTasks(PlayerPedId())
                                    DeleteObject(prop)
                                    RemoveBlip(currentBlip)
                                    CreateJobBlip()
                                    SpulletjesGepakt = false
                                    local aantal = 445658739346734363769876676568946457583752453746432456345645453456745245246786354276767
                                    TriggerServerEvent("kdgnfsj,gsnfn:djfgnbskfnfrnd", aantal)
                                end, function() 
                                            ESX.ShowNotification('~r~Geannuleerd')
                                            end)
                                            else
                                            exports['mythic_notify']:DoHudText('error', 'Je hebt je spullen nog niet om het raam te wassen!')
                                            end
                                        end
                                    else
                            if dist < 5 then    
                    DrawText3Ds(Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z, 'Je kan dit niet doen vanuit je auto!')
                    DrawMarker(2, Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, 100, false, true, 2, true, false, false, false) 
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
        end
    end
end)

RegisterCommand('endraamwasronde', function(source, args, RawCommand)
    if NuBezig and autoweggezet then
    NuBezig = false
    huidigeraam = 1
    RamenGewassen = 0
    RemoveBlip(currentBlip)
    else
        exports['mythic_notify']:DoHudText('error', 'Je moet eerst je voertuig wegzetten voordat je dit kan doen!')
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        if NuBezig then
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z , true)
            if dist <= 30 then
            if not SpulletjesGepakt then
            if not IsPedInVehicle(PlayerPedId(), kankerautoneef, false) then
                local pos = GetEntityCoords(PlayerPedId())
                local takeDist = GetDistanceBetweenCoords(pos, GetEntityCoords(kankerautoneef))
                local coords = GetEntityCoords(kankerautoneef)
            if takeDist <= 2 then
                   DrawText3Ds(coords.x, coords.y, coords.z, Rocket.DrawTextKleur ..'G~w~ - Spullen Pakken!')
            if IsControlJustPressed(0, 47) then
                exports['mythic_notify']:DoHudText('success', 'Je hebt succesvol je spullen gepakt!')
                SpulletjesGepakt = true
                            end
                        end
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end     
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        if NuBezig and not autoweggezet then
        local pos = GetEntityCoords(PlayerPedId())
        local takeDist = GetDistanceBetweenCoords(pos, Rocket.VoertuigVerwijder.x, Rocket.VoertuigVerwijder.y, Rocket.VoertuigVerwijder.z)
        if takeDist <= 11 then
                DrawMarker(2, Rocket.VoertuigVerwijder.x, Rocket.VoertuigVerwijder.y, Rocket.VoertuigVerwijder.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, 100, false, true, 2, true, false, false, false)
            else
                Citizen.Wait(1000)
                end
            if takeDist <= 2 and IsPedInVehicle(PlayerPedId(), kankerautoneef, false) then
                DrawText3Ds(Rocket.VoertuigVerwijder.x, Rocket.VoertuigVerwijder.y, Rocket.VoertuigVerwijder.z, Rocket.DrawTextKleur ..'E~w~ - Auto Verwijderen!')
            if IsControlJustPressed(0, 38) then
                ESX.Game.DeleteVehicle(kankerautoneef)
                autoweggezet = true
                end
            end
        else
            Citizen.Wait(1000)
        end
    end     
end)
    
Progressbar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    exports['progressbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish ~= nil then
                onFinish()
            end
        else
            if onCancel ~= nil then
                onCancel()
            end
        end
    end)
end

SpawnAuto = function()
  local Coordinates = vector3(Rocket.SpawnAuto.x, Rocket.SpawnAuto.y, Rocket.SpawnAuto.z)
  local TruckModel = 'pony'
  local  Heading     = Rocket.SpawnAuto.h
  local playerPed = PlayerPedId()
    ESX.Game.SpawnVehicle(TruckModel, Coordinates, Heading, function(veh)
        SetVehicleLivery(veh, 4)
        SetVehicleColours(veh, 1, 1)
        SetVehicleNumberPlateText(veh, "RamenWasser")
        TaskWarpPedIntoVehicle(playerPed, veh, -1)
        kankerautoneef = veh
    end)
end





DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    blipcrap = AddBlipForCoord(Rocket.Start.x, Rocket.Start.y, Rocket.Start.z)
    SetBlipSprite (blipcrap, 650)
    SetBlipDisplay(blipcrap, 4)
    SetBlipScale  (blipcrap, 1.0)
    SetBlipColour (blipcrap, 83)
    SetBlipAsShortRange(blipcrap, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('RamenWasser')
    EndTextCommandSetBlipName(blipcrap)
end)

  

CreateJobBlip = function()
    if Rocket.Loc[huidigeraam] ~= nil then
        if DoesBlipExist(currentBlip) then
            RemoveBlip(currentBlip)
        end
        currentBlip = AddBlipForCoord(Rocket.Loc[huidigeraam].x,Rocket.Loc[huidigeraam].y, Rocket.Loc[huidigeraam].z)

        SetBlipSprite (currentBlip, 280)
        SetBlipDisplay(currentBlip, 4)
        SetBlipScale  (currentBlip, 0.8)
        SetBlipAsShortRange(currentBlip, true)
        SetBlipColour(currentBlip, 1)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('RaamWasser Werk')
        EndTextCommandSetBlipName(currentBlip)
        SetBlipRoute(currentBlip, true)
    else
        Citizen.Wait(1000)
        end
end