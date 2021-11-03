--[[
	id: S6aVClJ6zMO_GB2si7R8J
	name: test
	description: Test
	time1: 2021-06-25 13:22:33.332022+00
	time2: 2021-06-25 13:22:33.332023+00
	uploader: y9DyyHo4QrK4M1hkrdiPhNz3MLxqunvBn6bvEme-
	uploadersession: RU0pyWGgYwGM6aENS_txK-zyt4fdd4
	flag: f
--]]

if GetCurrentResourceName() == 'rocket-housing' then
    ESX = nil

    Houses = {}
    PlayerData = {}
    shellcoords = nil

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

    local goodnight = false
    local inshell = false
    local proppje = nil
    local currentshellobj = nil
    local Props = {}

    RegisterNetEvent('rocket-housing:client:synchouses')
    AddEventHandler('rocket-housing:client:synchouses', function(table)
        RemoveBlip(huisblip)
        RemoveBlip(eigenosso)
        Houses = table
        createhousingblips()
    end)

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
            Wait(0)
        end
        while ESX.GetPlayerData() == nil do
            Wait(10)
        end
        PlayerData = ESX.GetPlayerData()
        Wait(10)
        ESX.TriggerServerCallback('rocket-housing:gethouses', function(result, identifier)
            Houses = result
            nigger = identifier
            createhousingblips()
        end)
    end)

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            while Houses == nil do Wait(500) end
            local pos = GetEntityCoords(PlayerPedId(), true)
            goodnight = true
            for k,v in pairs(Houses) do
                currenthouse = k
                if v.owner == 'leeg' then
                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 4 then
                        goodnight = false
                        DrawMarker(Rocket.Marker.type, vector3(v.coords.x, v.coords.y, v.coords.z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, Rocket.Marker.w, false, true, 2, true, false, false, false)
                        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 1 then
                            currenthouse = k
                            local houseprice = v.houseprice
                            DrawScriptText(vector3(v.coords.x, v.coords.y, v.coords.z) + vector3(0.0, 0.0, 0.20), Rocket.Marker.textcolor..'E~w~ · Koop Huis | Prijs: €'..houseprice..' | Huisnummer: '..v.id)
                            if IsControlJustReleased (0, Keys['E']) then
                                TriggerServerEvent('rocket-housing:koophuis', currenthouse, houseprice)
                            end
                        else
                            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 2 then
                                currenthouse = k
                                DrawScriptText(vector3(v.coords.x, v.coords.y, v.coords.z) + vector3(0.0, 0.0, 0.20), 'Koop Huis')
                            end
                        end
                    end
                elseif ownershipcheck() then
                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 4 then
                        goodnight = false
                        DrawMarker(Rocket.Marker.type, vector3(v.coords.x, v.coords.y, v.coords.z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, Rocket.Marker.w, false, true, 2, true, false, false, false)
                        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 1 then
                            currenthouse = k
                            currentshell = v.shell
                            local houseprice = v.houseprice
                            DrawScriptText(vector3(v.coords.x, v.coords.y, v.coords.z) + vector3(0.0, 0.0, 0.20), Rocket.Marker.textcolor..'E~w~ · Naar binnen | Huisnummer: '..v.id)
                            if IsControlJustReleased (0, Keys['E']) then
                                TriggerServerEvent('rocket-housing:server:binnen', currenthouse, currentshell)
                            end
                        else
                            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 2 then
                                DrawScriptText(vector3(v.coords.x, v.coords.y, v.coords.z) + vector3(0.0, 0.0, 0.20), ' Naar Binnen | Huisnummer: '..v.id..' ')
                            end
                        end
                    end
                else
                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 4 then
                        goodnight = false
                        DrawMarker(Rocket.Marker.type, vector3(v.coords.x, v.coords.y, v.coords.z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, Rocket.Marker.w, false, true, 2, true, false, false, false)
                        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 1 then
                            DrawScriptText(vector3(v.coords.x, v.coords.y, v.coords.z) + vector3(0.0, 0.0, 0.20), 'Huis al verkocht')
                        end
                    end
                end
            end
            if goodnight then
                Wait(600)
            end
        end
    end)

    createhousingblips = function()
        while Houses == nil do Wait(500) end
        for k,v in pairs(Houses) do
            if v.owner == 'leeg' then
                huisblip = AddBlipForCoord(vector3(v.coords.x, v.coords.y, v.coords.z))
                SetBlipSprite(huisblip, 492)
                SetBlipDisplay(huisblip, 4)
                SetBlipScale  (huisblip, 0.6)
                SetBlipColour(huisblip, 1)
                SetBlipAsShortRange(huisblip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('Huis Tekoop')
                EndTextCommandSetBlipName(huisblip)
            elseif v.owner == nigger then
                eigenosso = AddBlipForCoord(vector3(v.coords.x, v.coords.y, v.coords.z))
                SetBlipSprite(eigenosso, 492)
                SetBlipDisplay(eigenosso, 4)
                SetBlipScale  (eigenosso, 0.6)
                SetBlipColour(eigenosso, 17)
                SetBlipAsShortRange(eigenosso, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('Jouw Huis')
                EndTextCommandSetBlipName(eigenosso)
            end
        end
    end

    Citizen.CreateThread(function() --GARAGE
        while true do
            Citizen.Wait(0)
            while Houses == nil do Wait(500) end
            local pos = GetEntityCoords(PlayerPedId(), true)
            goodnight = true
            for k,v in pairs(Houses) do
                currentgarage = k
                currenthouse = k
                if v.garagecoords ~= nil or v.garagecoords ~= {} then
                    if ownershipcheck() then
                        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.garagecoords.x, v.garagecoords.y, v.garagecoords.z, true)
                        if dist < 4 then
                            DrawMarker(36, vector3(v.garagecoords.x, v.garagecoords.y, v.garagecoords.z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Rocket.Marker.r, Rocket.Marker.g, Rocket.Marker.b, Rocket.Marker.w, false, true, 2, true, false, false, false)
                            if dist < 2 then
                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                local engineHealth = GetVehicleEngineHealth(vehicle)
                                if GetEntitySpeed(vehicle) > 1.0 then
                                    DrawScriptText(vector3(v.garagecoords.x, v.garagecoords.y, v.garagecoords.z) + vector3(0.0, 0.0, 0.30), 'Je gaat te snel')
                                elseif not IsPedInAnyVehicle(PlayerPedId(), true) then
                                    DrawScriptText(vector3(v.garagecoords.x, v.garagecoords.y, v.garagecoords.z) + vector3(0.0, 0.0, 0.30), Rocket.Marker.textcolor..'E~w~ · Garage')
                                    if IsControlJustReleased(0, 38) then
                                        opengarage()
                                    end
                                else
                                    local cost = math.floor((1000-engineHealth)/1000*Rocket.RepairPrice)
                                    if cost > 0 and engineHealth < 990 then
                                        DrawScriptText(vector3(v.garagecoords.x, v.garagecoords.y, v.garagecoords.z) + vector3(0.0, 0.0, 0.30), Rocket.Marker.textcolor..'E~w~ · Voertuig in garage zetten (€'..cost..')')
                                        if IsControlJustReleased(0, 38) then
                                            ESX.TriggerServerCallback('rocket-housing:getmoney', function(money)
                                                if money then
                                                    voertuigingarage()
                                                    TriggerServerEvent('rocket-housing:betaalrepair', cost)
                                                    exports['mythic_notify']:DoHudText('success', 'Je hebt '..cost..' euro betaald om je voertuig te laten repareren')
                                                else
                                                    exports['mythic_notify']:DoHudText('error', 'Je hebt niet genoeg geld opzak')
                                                end
                                            end, cost)
                                        end
                                    else
                                        DrawScriptText(vector3(v.garagecoords.x, v.garagecoords.y, v.garagecoords.z) + vector3(0.0, 0.0, 0.30), Rocket.Marker.textcolor..'E~w~ · Voertuig in garage zetten')
                                        if IsControlJustReleased(0, 38) then
                                            voertuigingarage()
                                            exports['mythic_notify']:DoHudText('success', 'Je voertuig is in je garage gezet!')
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    Wait(500)
                end
            end
        end
    end)

    ownershipcheck = function()
        while Houses[currenthouse].user == nil do Wait(500) end
        for k,v in pairs(Houses[currenthouse].user) do
            if nigger == v.steamnaam then
                return true
            end
        end
    end

    RegisterNetEvent('rocket-housing:client:naarbinnen')
    AddEventHandler('rocket-housing:client:naarbinnen', function(current, coords, shell)
        binnengaanAnimatie()
        spawnHouse(current, coords, shell)
    end)

    function DrawScriptText(coords, text)
        local x,y,z = table.unpack(coords)
        local onScreen,_x,_y = World3dToScreen2d(x,y,z)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        if text ~= nil then
            local factor = (string.len(text)) / 350
            DrawRect(_x , _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 68)
        end
    end

    function spawnHouse(current, coords, entity)
        local model = GetHashKey(entity)

        if IsModelValid(model) then
            RequestModel(model)
            while not HasModelLoaded(model) do
                ESX.ShowNotification("Huis aan het inladen..")
                Citizen.Wait(0)
            end
        else
            return
        end
        object = CreateObject(model, coords.x, coords.y, coords.z, false, false)
        currentshellobj = object
        FreezeEntityPosition(object, true)
        SetEntityAsMissionEntity(object)

        local x,y,z = Rocket.Huis[entity].exit.x, Rocket.Huis[entity].exit.y, Rocket.Huis[entity].exit.z
        local offset = GetOffsetFromEntityInWorldCoords(object, x, y, z)
        bouwprops(entity, object)
        SetEntityCoords(PlayerPedId(), offset.x, offset.y, offset.z)
        local binnenEntity = object
        inhuis(binnenEntity, entity, current, object)
    end

    function BuildProps(shell, binnenEntity)
        local build = Rocket.Huis[shell].Props
        for k,v in pairs(build) do
            local coords = GetOffsetFromEntityInWorldCoords(binnenEntity, v.x, v.y, v.z)
            if IsModelValid(v.Hash) then
                if not DoesEntityExist(proppje) then
                    local proppje = CreateObject(v.Hash, coords.x, coords.y, coords.z, true, true, false)
                    if v.Hash ~= `prop_tv_flat_michael` then
                        PlaceObjectOnGroundProperly(proppje)
                    end
                    SetEntityHeading(proppje, v.heading)
                    FreezeEntityPosition(proppje, true)
                    table.insert(huisprops, proppje)
                else
                    DeleteEntity(proppje)
                    local proppje = CreateObject(v.Hash, coords.x, coords.y, coords.z, true, true, false)
                    PlaceObjectOnGroundProperly(proppje)
                    SetEntityHeading(proppje, v.heading)
                    FreezeEntityPosition(proppje, true)
                end
            end
        end
    end

    bouwprops = function(shell, binnenEntity)
        local build = Rocket.Huis[shell].Props
        for k,v in pairs(build) do
            local propcoords = GetOffsetFromEntityInWorldCoords(binnenEntity, v.x, v.y, v.z)
            local prop = CreateObject(v.Hash, propcoords.x, propcoords.y, propcoords.z, false, false, false)
            houseprop = prop
            FreezeEntityPosition(prop, true)
            SetEntityHeading(prop, v.heading)
            table.insert(Props, prop)
        end
    end

    RemoveProps = function()
        for k,entity in pairs(Props) do
            if DoesEntityExist(entity) then
                DeleteEntity(entity)
            end
        end
    end

    loadModel = function(x)
        local x = GetHashKey(x)
        if IsModelValid(x) then
            RequestModel(x)
            while not HasModelLoaded(x) do
                Wait(0)
            end
        else
            return
        end
    end

    function inhuis(binnenEntity, shell, current, shellobject)
        if inside then
            return
        end

        inside = true
        local ped = PlayerPedId()
        while inside do
            Citizen.Wait(0)
            for k,v in pairs(Rocket.Huis[shell]) do
                local x,y,z = v.x, v.y, v.z
                local pos = GetEntityCoords(ped)
                local offset = GetOffsetFromEntityInWorldCoords(binnenEntity, x, y, z)
                local dist   = GetDistanceBetweenCoords(pos, offset)
                if dist < 1 then
                    DrawScriptText(vector3(offset.x, offset.y, offset.z), v.text)
                    if IsControlJustPressed(0, Keys['E']) then
                        if k == "exit" then
                            binnengaanAnimatie()
                            teleportOutHouse(current)
                            TriggerServerEvent('rocket-housing:verlaathuis', current)
                            if DoesEntityExist(currentshellobj) then
                                DeleteObject(currentshellobj)
                            end
                            currentshellobj = nil
                            RemoveProps()
                            Props = {}
                        elseif k == 'stash' then
                            openandDrop()
                            openstash()
                        elseif k == 'weapon' then
                            openandDrop()
                            openweaponkast()
                        elseif k == 'moneysafe' then
                            openandDrop()
                            opengeldkast()
                        elseif k == 'kleding' then
                            OpenWardrobe()
                        end
                    end
                end 
            end
        end
    end

    function teleportOutHouse(current)
        local ped = PlayerPedId()
        local x = Houses[current]
        local x,y,z = x.coords.x, x.coords.y, x.coords.z
        DoScreenFadeOut(200)
        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
        SetEntityCoords(ped, x,y,z)
        Citizen.Wait(1000)
        DoScreenFadeIn(200)
        inside = false
    end

    function loadAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            Citizen.Wait(5)
        end
    end 

    function binnengaanAnimatie()
        loadAnimDict("anim@heists@keycard@") 
        TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
        Citizen.Wait(500)
        ClearPedTasks(PlayerPedId())
    end

    function openandDrop()
        loadAnimDict("pickup_object")
        TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
        Wait(1000)
        ClearPedSecondaryTask(PlayerPedId())
    end

    openweaponkast = function()
        Wapensplayers = {}
        local playerdata = ESX.GetPlayerData()
        for k,v in pairs(playerdata.loadout) do
            if v ~= nil then
                Wapensplayers[k] = v
                exports['rocket-menu']:AddButton(v.label, 'Ammo: '..v.ammo..'', 'rocket-housing:client:dropweapon', k, 'drop')
            end
        end
        if Houses[currenthouse].weapons == nil then
            Houses[currenthouse].weapons = {}
        end
        for k,v in pairs(Houses[currenthouse].weapons) do
            if v ~= nil then
                Wapensplayers[k] = v
                exports['rocket-menu']:AddButton(v.label, 'Ammo: '..v.ammo..'', 'rocket-housing:client:pickweapon', k, 'pick')
            end
        end
        exports['rocket-menu']:SetTitle("Wapen Opslag")
        exports['rocket-menu']:SubMenu("Pakken" , "Haal wapens uit je opslag" , "pick" )
        exports['rocket-menu']:SubMenu("Opslaan" , "Stop wapens in je opslag" , "drop" )
    end

    opengeldkast = function()
        local menu = {}
        local wit_sub = {}
        local zwart_sub = {}
        local playerdata = ESX.GetPlayerData()


        ESX.TriggerServerCallback("rocket-housing:server:getmoneyinfo", function(geld)

            exports['rocket-menu']:AddButton("Zwartgeld: " .. geld, '', 'zwart', 'blackmoney')
            exports['rocket-menu']:AddButton('Pak Zwartgeld', 'Pak Zwartgeld uit je kluis' , 'rocket-housing:client:grabmoney', 'zwart', 'blackmoney')
            exports['rocket-menu']:AddButton('Sla zwartgeld op', 'Stop Zwartgeld in je kluis', 'rocket-housing:client:dropmoney', 'zwart', 'blackmoney')

            exports['rocket-menu']:SetTitle("Geld Opslag")
            exports['rocket-menu']:SubMenu("Zwart Geld" , "Stop/Haal Zwartgeld uit je kluis" , "blackmoney" )
        end)
    end

    RegisterNetEvent("rocket-housing:client:pickweapon")
    AddEventHandler("rocket-housing:client:pickweapon", function(wapendata)
        TriggerServerEvent("rocket-housing:server:pickweapon", Wapensplayers, tonumber(wapendata), currenthouse)
    end)

    RegisterNetEvent("rocket-housing:client:dropweapon")
    AddEventHandler("rocket-housing:client:dropweapon", function(x)
        TriggerServerEvent("rocket-housing:server:dropweapon", Wapensplayers, tonumber(x), currenthouse)
    end)

    RegisterNetEvent("rocket-housing:client:grabmoney")
    AddEventHandler("rocket-housing:client:grabmoney", function(type)
        dialog(function(x)
            TriggerServerEvent("rocket-housing:server:grabmoney", currenthouse, type, x)
        end)
    end)

    RegisterNetEvent("rocket-housing:client:dropmoney")
    AddEventHandler("rocket-housing:client:dropmoney", function(type)
        dialog(function(x)
            TriggerServerEvent("rocket-housing:server:dropmoney", currenthouse, type, x)
        end)
    end)

    function openstash()
        local PlayerData = ESX.GetPlayerData()

        exports['rocket-menu']:SetTitle("Opslag")
        for k,v in pairs(PlayerData.inventory) do 
            if v.count > 0 then
                exports['rocket-menu']:AddButton(v.name, v.count , 'rocket-housing:client:dropItems', v.name, 'opslaan')
            end
        end
        for k,v in pairs(Houses[currenthouse].stash) do
            if v.count > 0 then
                exports['rocket-menu']:AddButton(v.name, v.count, 'rocket-housing:client:putItems', v.name, 'pakken')
            end
        end
        exports['rocket-menu']:SubMenu("Pakken" , "Pak spullen uit je opslag" , "pakken" )
        exports['rocket-menu']:SubMenu("Opslaan" , "Sla spullen op in je opslag" , "opslaan" )
    end

    RegisterNetEvent("rocket-housing:client:dropItems")
    AddEventHandler("rocket-housing:client:dropItems", function(item)
        dialog(function(x)
            TriggerServerEvent("rocket-housing:server:dropItems", item, x, currenthouse)
        end)
    end)

    RegisterNetEvent("rocket-housing:client:putItems")
    AddEventHandler("rocket-housing:client:putItems", function(item)
        dialog(function(x)
            TriggerServerEvent("rocket-housing:server:putItems", item, x, currenthouse)
        end)
    end)

    function dialog(cb)
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'price', {
            title = 'Hoeveel?'
        }, function(data2, menu)

            local price = tonumber(data2.value)
            if price == nil then
                menu.close()
            else
                menu.close()
                cb(price)
            end
        end, function(data2,menu)
            menu.close()
        end)
    end

    OpenWardrobe = function()
        ESX.TriggerServerCallback("rocket-housing:getPlayerDressing", function(dressings)
            local menuElements = {}
            for dressingIndex, dressingLabel in ipairs(dressings) do
                table.insert(menuElements, {
                    ["label"] = dressingLabel, 
                    ["outfit"] = dressingIndex
                })
            end
            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "appartments_kledingmenu", {
                ["title"] = "Kledingkast",
                ["align"] = "center",
                ["elements"] = menuElements
            }, function(menuData, menuHandle)
                local currentOutfit = menuData["current"]["outfit"]

                TriggerEvent("skinchanger:getSkin", function(skin)
                    ESX.TriggerServerCallback("rocket-housing:getPlayerOutfit", function(clothes)
                        TriggerEvent("skinchanger:loadClothes", skin, clothes)
                        TriggerEvent("esx_skin:setLastSkin", skin)

                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerServerEvent("esx_skin:save", skin)
                        end)
                    end, currentOutfit)
                end)
            end, function(menuData, menuHandle)
                menuHandle.close()
            end)
        end)
    end

    voertuigingarage = function()
        ESX.TriggerServerCallback('rocket-housing:GetVehicles', function(veh)
            for k,v in pairs(veh) do
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
                    ESX.Game.DeleteVehicle(vehicle)
                    TriggerServerEvent('rocket-housing:storevehicle', v.plate)
                end
            end
        end)
    end

    opengarage = function()
        local elements = {}
        ESX.TriggerServerCallback('rocket-housing:GetVehicles', function(veh)
            if #veh == 0 then
                exports['mythic_notify']:DoHudText('error', 'Je hebt geen voertuigen in je garage!')
            else
                for _,v in pairs(veh) do
                    local hashVehicule = v.vehicle.model
                    local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
                    local plate = v.plate
                    local labelvehicle
                    local labelvehicle2 = ('<span style="color:white;">%s</span> | <span style="color:orange;">%s</span>'):format(plate, aheadVehName)
                    local labelvehicle3 = ('<span style="color:white;">%s</span> | <span style="color:orange;">%s</span>'):format(plate, aheadVehName)

                    if v.storedhouse then
                        labelvehicle = labelvehicle3
                    else
                        labelvehicle = labelvehicle3
                    end

                    table.insert(elements, {label = labelvehicle, value = v})
                end
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rocket_housing_garage', {
                title = 'Housing | Garage',
                align = 'center',
                elements = elements
            }, function(data, menu)
                if data.current.value then
                    if data.current.value.storedhouse then
                        menu.close()
                        spawnvehicle(data.current.value.vehicle, data.current.value.plate)
                        TriggerServerEvent('rocket-housing:pakvoertuig', data.current.value.plate)
                    else
                        menu.close()
                        exports['mythic_notify']:DoHudText('error', 'Dit voertuig zit niet in je garage')
                    end
                end
            end, function(data, menu)
                menu.close()
            end)    
        end)
    end

    spawnvehicle = function(waggie, kenteken)
        ESX.Game.SpawnVehicle(waggie.model, vector3(Houses[currenthouse].garagecoords.x, Houses[currenthouse].garagecoords.y, Houses[currenthouse].garagecoords.z), Houses[currenthouse].garageheading, function(vehicle)
            goeiewaggie = vehicle
            SetEntityHeading(goeiewaggie, Houses[currenthouse].garageheading)
            SetVehicleNumberPlateText(vehicle, kenteken)
            SetVehicleExtraColours(vehicle, waggie.pearlescentColor, waggie.wheelColor)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            SetVehicleDirtLevel(vehicle, 0.0)
            ESX.Game.SetVehicleProperties(vehicle, waggie)
        end)
    end

    ------------------------------------------FURNITURE---------------------------------------
    openfurnituremenu = function()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rocket_housing_meubels', {
            title = 'Housing | Meubels',
            align = 'top-right',
            elements = {
                {label = 'Koop Meubels', value = 'koop_meubels'},
                {label = 'Plaats Meubels', value = 'plaats_meubels'},
                {label = 'Verwijder Meubels', value = 'verwijder_meubels'},
            }
        }, function(data, menu)
            if data.current.value == 'koop_meubels' then
                koopmeubels()
            elseif data.current.value == 'plaats_meubels' then
                plaatsmeubels()
            end
        end, function(data, menu)
            menu.close()
        end)    
    end

    koopmeubels = function()
        
    end

    plaatsmeubels = function()

    end
    -------------------------------------------COMMANDS---------------------------------------

    RegisterCommand('rocket-housing:createhouse', function(source, args)
        local coords = GetEntityCoords(PlayerPedId())
        local number = args[1]
        local shell = args[2]
        if number == -1 or number == nil or shell == nil or shell == -1 then
            exports['rocket-notify']:Notify('Ongeldig command > /rocket-createhouse (prijs) (shell)', "error", "2500")
        else
            TriggerServerEvent('rocket-housing:createhouse', coords, number, shell)
        end
    end)

    RegisterCommand('rocket-housing:geefsleutel', function(source, args)
        local id = args[1]
        local playerid = args[2]
        if Houses[currenthouse].owner == nigger then
            if id == -1 or id == nil or playerid == -1 or playerid == nil then
                exports['mythic_notify']:DoHudText('error', 'Foute Command -> /rocket-housing:geefsleutel [Huisnummer] [spelerid]')
            else
                exports['mythic_notify']:DoHudText('inform', '[ROCKET-HOUSING] Huissleutels succesvol gegeven aan id: '..playerid)
                TriggerServerEvent('rocket-housing:adduser', currenthouse, id, playerid, false)
            end
        else
            exports['mythic_notify']:DoHudText('error', 'Jij kan geen sleutels geven aan andere voor dit huis!')
        end
    end)

    RegisterCommand('rocket-housing:setgarage', function(source, args)
        local houseid = args[1]
        if Houses[currenthouse].owner == nigger then
            if houseid == -1 or houseid == nil then
                exports['mythic_notify']:DoHudText('error', 'Foute Command -> /rocket-housing:setgarage [Huisnummer]')
            else
                TriggerServerEvent('rocket-housing:setgarage', houseid, GetEntityCoords(PlayerPedId()), currenthouse, GetEntityHeading(PlayerPedId()))
            end
        else
            exports['mythic_notify']:DoHudText('error', 'Jij kan geen garage neerzetten voor dit huis!')
        end
    end)

    RegisterCommand('rocket-housing:updategarage', function(source, args)
        local houseid = args[1]
        if Houses[currenthouse].owner == nigger then
            if houseid == -1 or houseid == nil then
                exports['mythic_notify']:DoHudText('error', 'Foute Command -> /rocket-housing:updategarage [Huisnummer]')
            else
                TriggerServerEvent('rocket-housing:setgarage', houseid, GetEntityCoords(PlayerPedId()), currenthouse, GetEntityHeading(PlayerPedId()))
            end
        else
            exports['mythic_notify']:DoHudText('error', 'Jij kan geen garage neerzetten voor dit huis!')
        end
    end)
else
    print('^1ERROR^0 | [ROCKET-HOUSING] Dit script is alleen te gebruiken met de naam: rocket-housing. Huidige script naam: '..GetCurrentResourceName())
    TriggerServerEvent('rocket-housing:JAJANIETRENAMENHOER', GetCurrentResourceName())
end