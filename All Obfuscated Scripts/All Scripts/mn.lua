--[[
	id: 9NzIWnmT9S-XcZ05O1pth
	name: mn-
	description: mn
	time1: 2021-05-26 19:17:54.936599+00
	time2: 2021-05-26 19:17:54.936599+00
	uploader: A9CBWIbo5Q6vKFRuY5pwexbRm8hPvAysjjYX62CT
	uploadersession: rq5hmeWphhKyh6hPaKB_NKAeJZDZWw
	flag: f
--]]

ESX = nil

Houses = {}
Garages = nil

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
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(10)
    Resync()
end)


Resync = function()
    ESX.TriggerServerCallback('mn-ganghousing:client:GetHouses', function(result)
        Houses = result
    end)
end


RegisterNetEvent('mn-ganghousing:client:ResyncHousing')
AddEventHandler('mn-ganghousing:client:ResyncHousing', function(table)
    Houses = table
end)



RegisterNUICallback('PinpadClose', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('ErrorMessage', function(data)
    exports["mythic_notify"]:DoHudText('error', data.message)
end)

RegisterNUICallback('EnterPincode', function(d)
    ESX.TriggerServerCallback("mn-ganghousing:GetHousePincode", function(pin)
        if d.pin == pin then
            TriggerServerEvent('mn-ganghousing:server:enter', currenthouse)
        else
            exports["mythic_notify"]:DoHudText('error', 'Deze code is incorrect..')
        end
    end, currenthouse)
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        while Houses == nil do Wait(500) end
        goodnight = true
        for k,v in pairs(Houses) do
            local dist = GetDistanceBetweenCoords(coords, v.housecoords.x, v.housecoords.y, v.housecoords.z, true)
            if dist < 10 then
                goodnight = false
                DrawMarker(20,v.housecoords.x, v.housecoords.y, v.housecoords.z - 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.2, MN.RGB.r,MN.RGB.g,MN.RGB.b, 100, false, true, 2, true, nil, nil, false)
                if dist < 1.5 then
                    currenthouse = k
                    if v.owner == 'Leeg' then
                        DrawScriptText(vector3(v.housecoords.x, v.housecoords.y, v.housecoords.z), MN.ColorText .. "E ~w~Â· Gang huis Kopen | ID: " .. v.id)
                        huizenprijs = Houses[k].houseprijs
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("mn-ganghousing:buyhouse", currenthouse, huizenprijs)
                        end
                    else
                        DrawScriptText(vector3(v.housecoords.x, v.housecoords.y, v.housecoords.z), MN.ColorText .."E ~w~Â· Binnengaan | ID: " .. v.id)
                        if IsControlJustReleased(0, Keys["E"]) then
                            SendNUIMessage({
                                action = "open"
                            })
                            SetNuiFocus(true, true)
                        end
                    end
                end
            end
        end
        if goodnight then 
            Wait(500)
        end
    end
end)


local dialog = function(cb)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'price', {
        title = 'Hoeveelheid?'
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

function openDooranimation()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(400)
    ClearPedTasks(GetPlayerPed(-1))
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function loadModel(x)

    local x = GetHashKey(x)
    if IsModelValid(x) then
        RequestModel(x)
        while not HasModelLoaded(x) do
            ESX.ShowNotification("Housing Shell aan het inladen...")
            Citizen.Wait(0)
        end
    else
        return
    end
end

function spawnShell(shell, coord, cb)
    local model = GetHashKey(shell)



    object = CreateObject(model, coord.x, coord.y, coord.z, false, false)
    FreezeEntityPosition(object, true)
    SetEntityAsMissionEntity(object, true, true)

    local x,y,z = MN.OffSets[shell].exit.x, MN.OffSets[shell].exit.y, MN.OffSets[shell].exit.z
    local offset = GetOffsetFromEntityInWorldCoords(object, x, y, z)
    DoScreenFadeOut(200)
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    SetEntityCoords(GetPlayerPed(-1), offset.x, offset.y, offset.z)
    Citizen.Wait(1000)
    DoScreenFadeIn(200)
    cb(object)
end

RegisterNetEvent("mn-ganghousing:client:enter")
AddEventHandler("mn-ganghousing:client:enter", function(current, coord)
    local housedata = Houses[current]
    local shell     = housedata.shell

    loadModel(shell)

    spawnShell(shell, coord, function(object)
        local insideEntity = object
        insideLoopStart(insideEntity, shell, current)
    end)
end)

teleportOutHouse = function(current)
    local ped = GetPlayerPed(-1)
    local x = Houses[current]
    local x,y,z = x.housecoords.x, x.housecoords.y, x.housecoords.z
    DoScreenFadeOut(200)
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    SetEntityCoords(ped, x,y,z)
    Citizen.Wait(1000)
    DoScreenFadeIn(200)
    ESX.Game.DeleteVehicle(currentveh)
    DeleteEntity(kluisobj)
    inside = false
end

insideLoopStart = function(insideEntity, shell, current)
    if inside then
        return
    end

    inside = true
    for k,v in pairs(MN.OffSets[shell]) do 
        local x,y,z = v.x, v.y, v.z
        local pos = GetEntityCoords(ped)
        local offset = GetOffsetFromEntityInWorldCoords(insideEntity, x, y, z)
        local dist   = GetDistanceBetweenCoords(pos, offset)
        if k == "carspot" then 
            if MN.OffSets[shell].carspot.Enabled then
                if Houses[currenthouse].vehmodel ~= nil then
                    ESX.Game.SpawnLocalVehicle(Houses[currenthouse].vehmodel, vector3(offset.x, offset.y, offset.z), 271.67, function(veh)
                        currentveh = veh
                        FreezeEntityPosition(veh, true)
                    end)
                end
            end
        elseif k == "wapenkluis" then 
            if MN.OffSets[shell].wapenkluis.Enabled then
                if IsModelValid(`prop_ld_int_safe_01`) then 
                    if not DoesEntityExist(kluisobj) then
                        loadModel(`prop_ld_int_safe_01`)
                        kluisobj = CreateObject(`prop_ld_int_safe_01`, offset.x, offset.y, offset.z, true, true, false)
                        PlaceObjectOnGroundProperly(kluisobj)
                        SetEntityHeading(kluisobj, 181.93)
                        FreezeEntityPosition(kluisobj, true)
                    end
                end
            end
        end
    end
    local ped = GetPlayerPed(-1)
    while inside do
        Citizen.Wait(0)
        for k,v in pairs(MN.OffSets[shell]) do
            local x,y,z = v.x, v.y, v.z
            local pos = GetEntityCoords(ped)
            local offset = GetOffsetFromEntityInWorldCoords(insideEntity, x, y, z)
            local dist   = GetDistanceBetweenCoords(pos, offset)
            if v.Enabled then
                if dist < 1.5 then
                    DrawScriptText(vector3(offset.x, offset.y, offset.z), v.draw)
                    if IsControlJustPressed(0, Keys['E']) then
                        if k == "exit" then
                            teleportOutHouse(current)
                            DeleteObject(object)
                            TriggerServerEvent("lefthouse", current)
                            break
                        elseif k == "stash" then 
                            openandDrop()
                            openstash()
                        elseif k == "pc" then 
                            SendNUIMessage({
                                action = "openpc",
                            })
                            SetNuiFocus(true, true)
                        elseif k == "carspot" then
                            if currentveh ~= nil then
                                if IsPedInVehicle(ped, currentveh) then 
                                    if Houses[currenthouse].garagecoords ~= nil then 
                                        SpawnWaggieOutside()
                                    else
                                        exports["mythic_notify"]:DoHudText("error", "Er zijn nog geen garagecoords ingesteld voor dit huis. Vraag een admin voor verdere info")
                                    end
                                else
                                    exports["mythic_notify"]:DoHudText("error", "U moet in het voertuig zitten")
                                end
                            else
                                exports["mythic_notify"]:DoHudText("error", "Er is nog geen gangauto ingesteld voor dit huis. Vraag een admin voor verdere info")
                            end
                        elseif k == "wapenkluis" then 
                            openandDrop()
                            OpenWeaponSafe()
                        end
                    end
                else
                    DrawMarker(20, offset.x, offset.y, offset.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.2, MN.RGB.r,MN.RGB.g,MN.RGB.b, 100, false, true, 2, true, nil, nil, false)
                end
            end
        end
    end
end



OpenWeaponSafe = function()
    Weapondata = {}
    local playerdata = ESX.GetPlayerData()

    exports["mn-nui"]:SetTitle("Wapen Opslag")
    for k,v in pairs(playerdata.loadout) do 
        if v ~= nil then 
            Weapondata[k] = v
            exports["mn-nui"]:AddButton(v.label, v.ammo .. "x" , "mn-ganghousing:client:DropWeapon", k, "opbergen")
        end
    end
    if Houses[currenthouse].loadout[1] == nil then 
        Houses[currenthouse].loadout = {}
    end
    for k,v in pairs(Houses[currenthouse].loadout) do 
        if v ~= nil then 
            Weapondata[k] = v
            exports["mn-nui"]:AddButton(v.label, v.ammo .. "x" , "mn-ganghousing:client:pickWeapon", k, "pakken")
        end
    end

    exports['mn-nui']:SubMenu("Opslag" , "Wapens Pakken" , "pakken" )
    exports['mn-nui']:SubMenu("Broekzak" , "Wapens Opbergen" , "opbergen")
end

RegisterNetEvent("mn-ganghousing:client:DropWeapon")
AddEventHandler("mn-ganghousing:client:DropWeapon", function(x)
    TriggerServerEvent("mn-ganghousing:server:DropWeapon", Weapondata, tonumber(x), currenthouse)
end)

RegisterNetEvent("mn-ganghousing:client:pickWeapon")
AddEventHandler("mn-ganghousing:client:pickWeapon", function(data)
    TriggerServerEvent("mn-ganghousing:server:pickWeapon", Weapondata, tonumber(data), currenthouse)
end)



openstash = function()
    local playerdata = ESX.GetPlayerData()


    exports["mn-nui"]:SetTitle("Stash")
    for k,v in pairs(playerdata.inventory) do 
        if v.count > 0 then 
            exports["mn-nui"]:AddButton(v.name, v.count .. "x" , "mn-ganghousing:client:dropItems", v.name, "opbergen")
        end
    end

    for k,v in pairs(Houses[currenthouse].stash) do 
        if v.count > 0 then 
            exports["mn-nui"]:AddButton(v.name, v.count .. "x" , "mn-ganghousing:client:putItems", v.name, "pakken")
        end
    end
    exports['mn-nui']:SubMenu("Opslag" , "Spullen Pakken" , "pakken" )
    exports['mn-nui']:SubMenu("Broekzak" , "Spullen Opbergen" , "opbergen")
end


RegisterNetEvent("mn-ganghousing:client:dropItems")
AddEventHandler("mn-ganghousing:client:dropItems", function(item)
    dialog(function(x)
        TriggerServerEvent("mn-ganghousing:server:dropItems", item, x, currenthouse)
    end)
end)

RegisterNetEvent("mn-ganghousing:client:putItems")
AddEventHandler("mn-ganghousing:client:putItems", function(item)
    dialog(function(x)
        TriggerServerEvent("mn-ganghousing:server:putItems", item, x, currenthouse)
    end)
end)

SpawnWaggieOutside = function()
    DeleteEntity(kluisobj)
    DoScreenFadeOut(200)
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    ESX.Game.DeleteVehicle(currentveh)
    SetEntityCoords(GetPlayerPed(-1), Houses[currenthouse].garagecoords.x,Houses[currenthouse].garagecoords.y,Houses[currenthouse].garagecoords.z)
    ESX.Game.SpawnVehicle(Houses[currenthouse].vehmodel, vector3(Houses[currenthouse].garagecoords.x,Houses[currenthouse].garagecoords.y,Houses[currenthouse].garagecoords.z), 342, function(veh) 
        Citizen.Wait(1000)
        DoScreenFadeIn(200)
        inside = false
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
    end)
end

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
end)


RegisterNUICallback("TryLogin", function(data)
    SetNuiFocus(false, false)
    ESX.TriggerServerCallback("mn-ganghousing:server:getpclogin", function(login) 
        if json.decode(login) ~= nil then
            local info = json.decode(login)
            if data.username == info.username and data.password == info.password then 
                exports["mythic_notify"]:DoHudText("success", "Login Succes")
                SendNUIMessage({
                    action = "loginsucces",
                    username = info.username
                })
                SetNuiFocus(true,true)
            else
                exports["mythic_notify"]:DoHudText("error", "Login poging gefaald")
            end
        else
            exports["mythic_notify"]:DoHudText("error", "[mn-ganghousing]: </br> Deze PC heeft nog geen login geregistreerd </br> Gebruik de mn-ganghousing:setpclogin [houseid] command")
        end
    end, Houses[currenthouse].id)
end)


RegisterNUICallback("OpenBank", function(data)
    ESX.TriggerServerCallback("mn-ganghousing:server:GetBankInfo", function(geld)
        SendNUIMessage({
            action = "OpenBank",
            balance = geld
        })
    end, Houses[currenthouse].id)
end)


RegisterNUICallback("BankOpnemen", function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent("mn-ganghousing:server:BankOpnemen", data.amount, Houses[currenthouse].id)
end)

RegisterNUICallback("BankStorten", function(data)
    SetNuiFocus(false,false)
    TriggerServerEvent("mn-ganghousing:bankstorten", data.amount, Houses[currenthouse].id)
end)


------------------------------------------Commands-----------------------------------------------------


RegisterCommand('mn-ganghousing:createhouse', function(source, args)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local number = args[1]
    local shell = args[2]
    local pin = args[3]
    if number == -1 or number == nil then
        exports['mythic_notify']:DoHudText("error", 'Syntax niet geldig --> /mn-ganghousing:createhouse [prijs] [shell] [pin]')
    else
        TriggerServerEvent('mn-ganghousing:server:registernewhouse', coords, number, shell, pin)
    end
end)



RegisterCommand("mn-ganghousing:deletehouse", function(source, args)
    local id = args[1]
    TriggerServerEvent("mn-ganghousing:deletehouse", id)
    Citizen.Wait(500)
    Resync()
end)

RegisterCommand("mn-ganghousing:setgaragespawn", function(source, args)
    local id = args[1]
    if currenthouse ~= nil then 
        TriggerServerEvent("mn-ganghousing:setgaragespawn", id, GetEntityCoords(GetPlayerPed(-1)), currenthouse)
        Citizen.Wait(1000)
        Resync()
    else
        print("foutje")
    end
end)

RegisterCommand("mn-ganghousing:setvehmodel", function(source, args)
    local id = args[1]
    local voertuig = args[2]
    if id ~= nil and voertuig ~= nil then 
        TriggerServerEvent("mn-ganghousing:setvehmodel", id, voertuig, currenthouse)
        Citizen.Wait(1000)
        Resync()
    else
        exports["mythic_notify"]:DoHudText("error", "Syntax niet geldig --> /mn-ganghousing:setvehmodel [houseid] [vehmodel]")
    end
end)

RegisterCommand("mn-ganghousing:setpclogin", function(source, args)
    local houseid = args[1]
    local username = args[2]
    local password = args[3]
    if houseid ~= nil and username ~= nil and password ~= nil then 
        TriggerServerEvent("mn-ganghousing:server:registerloginpc", houseid, username, password)
        Citizen.Wait(1000)
        Resync()
    else
        exports["mythic_notify"]:DoHudText("error", "Syntax niet geldig --> /mn-ganghousing:setpclogin [houseid] [Gebruikersnaam] [Wachtwoord]")
    end
end)




-------------------------------------------Animatie----------------------------------------------------------

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

function openandDrop()
    loadAnimDict("pickup_object")
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end
