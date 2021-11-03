--[[
	id: uH-DGzVbglfQoY-Xq5dQ5
	name: client
	description: Dit is een test
	time1: 2021-06-22 10:02:18.865476+00
	time2: 2021-06-22 10:02:18.865477+00
	uploader: y9DyyHo4QrK4M1hkrdiPhNz3MLxqunvBn6bvEme-
	uploadersession: RU0pyWGgYwGM6aENS_txK-zyt4fdd4
	flag: f
--]]

ESX = nil 

NS = {}

ingeklokt = false
currentjob = 1
Jobsdone = 0

-------------------------------------
------- Created by mn#0810 ----------
-------------------------------------

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(10)
    ESX.TriggerServerCallback('ns-treinjob:GetConfig', function(table, table2)
        NS.Locations = table
        NS.JobLocations = table2
    end)
end)

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        while NS.Locations == nil do Wait(500) end
        for k,v in pairs(NS.Locations) do
            local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z,true)
            if dist < 20 then 
                DrawMarker(20,v.x, v.y, v.z - 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.2, 147,112,219, 100, false, true, 2, true, nil, nil, false)
                if dist < 1.0 then 
                    if v.functie == "inklok" then
                        if not ingeklokt then
                            DrawScriptText(vector3(v.x, v.y, v.z), "~p~E ~w~· Inklokken")
                            if IsControlJustReleased(0, Keys["E"]) then 
                                inklokken()
                            end
                        else
                            DrawScriptText(vector3(v.x, v.y, v.z), "~p~E ~w~· Uitklokken")
                            if IsControlJustReleased(0, Keys["E"]) then 
                                inklokken()
                            end
                        end
                    elseif v.functie == "loonstrook" then
                        if ingeklokt then
                            DrawScriptText(vector3(v.x, v.y, v.z), "~p~E ~w~· Loonstrook ophalen")
                            if IsControlJustReleased(0, Keys["E"]) then 
                                GetPayed()
                            end 
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        if ingeklokt then
            if NS.JobLocations[currentjob] ~= nil then
                local dist = GetDistanceBetweenCoords(coords, NS.JobLocations[currentjob].x,NS.JobLocations[currentjob].y, NS.JobLocations[currentjob].z , true)
                if dist < 3 then 
                    DrawScriptText(vector3(NS.JobLocations[currentjob].x,NS.JobLocations[currentjob].y, NS.JobLocations[currentjob].z), '~p~E ~w~· Elektriciteit fixen')
                    if IsControlJustReleased(0, Keys["E"]) then
                        Progressbar("fix_job", "Elektriciteit fixen..", 10000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@gangops@facility@servers@",
                            anim = "hotwire",
                            flags = 16,
                        }, {}, {}, function() 
                            currentjob = currentjob + 1
                            Jobsdone = Jobsdone + 1 
                            exports['mn-notify']:notification("Elektriciteit Succesvol gefixt, Ga door naar de volgende locatie", "primary", "2500")
                            CreateJobBlip()
                        end, function() 
                        end)
                    end
                end
            else 
                exports['mn-notify']:notification("U bent alle locaties afgegaan, Je kan je loonstrook gaan ophalen!", "primary", "5000")
                CreateBlipBack()
                RemoveBlip(currentBlip)
                return
            end
        end
    end
end)


CreateBlipBack = function()
    if not DoesBlipExist(blipback) then
        local blipback = AddBlipForCoord(vector3(NS.Locations[2].x, NS.Locations[2].y, NS.Locations[2].z))

        SetBlipSprite (blipback, 277)
        SetBlipDisplay(blipback, 4)
        SetBlipScale  (blipback, 0.6)
        SetBlipAsShortRange(blipback, true)
        SetBlipColour (blipback, 1)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Loonstrook ophalen')
        EndTextCommandSetBlipName(blipback)
    else
        RemoveBlip(blipback)
    end
end


Citizen.CreateThread(function()
    while true do 
        while NS.Locations == nil do Wait(500) end
        if PlayerData.job.name == 'treinjob' then
            if not DoesBlipExist(blop) then 
                blop = AddBlipForCoord(NS.Locations[1].x,NS.Locations[1].y, NS.Locations[1].z)

                SetBlipSprite (blop, 354)
                SetBlipDisplay(blop, 4)
                SetBlipScale  (blop, 1.2)
                SetBlipAsShortRange(blop, true)
                SetBlipColour(blop, 1)
            
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('Trein Werk')
                EndTextCommandSetBlipName(blop)
            end
        end
        Citizen.Wait(20000)
    end
end)


CreateJobBlip = function()
    if NS.JobLocations[currentjob] ~= nil then
        if DoesBlipExist(currentBlip) then
            RemoveBlip(currentBlip)
        end
        currentBlip = AddBlipForCoord(NS.JobLocations[currentjob].x,NS.JobLocations[currentjob].y, NS.JobLocations[currentjob].z)

        SetBlipSprite (currentBlip, 402)
        SetBlipDisplay(currentBlip, 4)
        SetBlipScale  (currentBlip, 0.8)
        SetBlipAsShortRange(currentBlip, true)
        SetBlipColour(currentBlip, 1)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Trein Werk')
        EndTextCommandSetBlipName(currentBlip)
    end
end


GetPayed = function()
    local rand = 427482674628759759265
    if Jobsdone == 0 then 
        exports['mn-notify']:notification("U heeft nog geen werk verricht", "error", "2500")
    else
        TriggerServerEvent('NS-Trainjob:GetPayed', rand, Jobsdone)
        RemoveBlip(blipback)
        Jobsdone = 0
    end
end

inklokken = function()
    if PlayerData.job.name == 'treinjob' then
        if ingeklokt then 
            ingeklokt = false
            exports["mn-notify"]:notification("U bent succesvol uitgeklokt", "primary", "2500")
            currentjob = 1 
            RemoveBlip(blipback)
            RemoveBlip(currentBlip)
        else
            ingeklokt = true
            exports["mn-notify"]:notification("U bent succesvol ingeklokt", "primary", "2500")
            CreateJobBlip()
            exports['mn-notify']:notification("Eerste locatie is ingesteld op uw map!", "primary", "2500")
        end
    else
        exports["mn-notify"]:notification("U bent geen medewerker van dit bedrijf", "error", "2500")
    end
end

function DrawScriptText(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 65)
end

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





