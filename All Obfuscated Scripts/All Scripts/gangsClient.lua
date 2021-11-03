--[[
	id: ezzQ1E8fe67HmvPyiG-l5
	name: gangs-Client
	description: Testing obfuscate
	time1: 2021-04-28 14:42:47.556929+00
	time2: 2021-04-28 14:42:47.55693+00
	uploader: 4071
	uploadersession: Wh3Kz-844rs2gt9UkMxq0F1joSmq67
	flag: f
--]]

-----------------
---- Locales ----
-----------------

P = {}
P.loop = true
P.Keys = {['E'] = 38}
P.Funtions = {}


---------------
----- ESX -----
---------------

ESX = nil
local PlayerData = {}
local actGang = 'None'

Citizen.CreateThread(function()
	while ESX == nil do
        if Config.esxTrigger then
            TriggerEvent(Config.esxTrigger, function(obj) ESX = obj end)
            Citizen.Wait(0)
            break;
        else 
            print('^1[py-gangs] - error25^7')
            return false
        end
	end

    while ESX.GetPlayerData().job == nil do 
        Citizen.Wait(0)
    end

	ESX.PlayerData = ESX.GetPlayerData()

    if ESX ~= nil then 
        while P.loop do 
            local _slp = 1000
            if Config and Config.Gangs and type(Config.Gangs) == 'table' then
                for k,v in pairs(Config.Gangs)do
                    if v.jobName and type(v.jobName) == 'string' then
                        if ESX.PlayerData.job.name == v.jobName then
                            if v.Configs ~= nil and v.Configs.JobBlips ~= nil and v.Configs.ClothesMenu and v.Configs.SpawnVehicles ~= nil and v.Configs.DeleteVehicles ~= nil and v.Configs.ArmoryMenu ~= nil and v.Configs.InteractionMenu ~= nil and v.Configs.HelicopterMenu ~= nil and v.Configs.DeleteHelicopters ~= nil and v.Configs.BossMenu ~= nil and v.Configs.MarkersRGB ~= nil and v.Configs.UseCustomPlate ~= nil then
                                if type(v.Configs) == 'table' and type(v.Configs.JobBlips) == 'boolean' and type(v.Configs.ClothesMenu) == 'boolean' and  type(v.Configs.SpawnVehicles) == 'boolean' and type(v.Configs.DeleteVehicles) == 'boolean' and type(v.Configs.ArmoryMenu) == 'boolean' and type(v.Configs.InteractionMenu) == 'boolean' and type(v.Configs.HelicopterMenu) == 'boolean' and type(v.Configs.DeleteHelicopters) == 'boolean' and type(v.Configs.BossMenu) == 'boolean' and type(v.Configs.MarkersRGB) == 'boolean' and type(v.Configs.UseCustomPlate) == 'boolean' then
                                    if v.Configs.JobBlips then
                                        P.Funtions.Blips()
                                    end
                                    if v.Configs.InteractionMenu then
                                        P.Funtions.GangsInteractionMenu()
                                    end
                                    if v.Configs.DeleteVehicles then
                                        P.Funtions.DeleteVehicleMenu()
                                    end
                                    if v.Configs.DeleteHelicopters then
                                        P.Funtions.DeleteHelicopterMenu()
                                    end
                                    if v.Configs.SpawnVehicles then
                                        P.Funtions.SpawnVehicleMenu()
                                    end
                                    if v.Configs.HelicopterMenu then
                                        P.Funtions.SpawnHelicoptersMenu()
                                    end
                                    if v.Configs.ClothesMenu then
                                        P.Funtions.ChangeClothesMenu()
                                    end
                                    if v.Configs.ArmoryMenu then
                                        P.Funtions.ArmoryMenu()
                                    end
                                    if v.Configs.BossMenu then
                                        P.Funtions.BossMenu()
                                    end
                                    P.Funtions.CodeMainLoop()
                                    return
                                else
                                    print('^1Error[code_111168156]')
                                    return
                                end
                            else
                                print('^1Error[code_19973265]')
                                return
                            end
                        end
                    else 
                        print('^1[py-gangs] - error63^7')
                        return
                    end
                end
            else 
                print('^1[py-gangs] - error66^7')
                return
            end
            Citizen.Wait(_slp)
        end
    else
        print('^1Error[code_18617446]')
        return
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Wait(2000)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(xPlayer)
	ESX.PlayerData.job = xPlayer
end)

----------------------------------------------------------------
--------------------- Principal PYFuntions ---------------------
----------------------------------------------------------------

------------------------
----- Blips System -----
------------------------


P.Funtions.Blips = function()
    Citizen.CreateThread(function()
        while P.loop do
            local _slp = 10000
            for k,v in pairs(Config.Gangs) do
                if ESX.PlayerData.job.name == v.jobName then
                    v.blip = AddBlipForCoord(v.Blip.coords.x, v.Blip.coords.y, v.Blip.coords.z)
                    SetBlipSprite(v.blip, v.Blip.id)
                    SetBlipDisplay(v.blip, 4)
                    SetBlipScale(v.blip, 0.8)
                    SetBlipColour(v.blip, v.Blip.Color)
                    SetBlipAsShortRange(v.blip, true)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString(v.Blip.Name)
                    EndTextCommandSetBlipName(v.blip)
                    return
                end
            end
            Citizen.Wait(_slp)
        end
    end)
end

-----------------------------
----- Help Notification -----
-----------------------------

function HelpNotification(_msg, _coords)
    if _msg and type(_msg) == 'string' and _coords then
        AddTextEntry('PY.HelpNotification', _msg)
        SetFloatingHelpTextWorldPosition(1, _coords)
        SetFloatingHelpTextStyle(1, 1, 87, 1, 3, 0)
        BeginTextCommandDisplayHelp('PY.HelpNotification')
        EndTextCommandDisplayHelp(2, false, false, -1)
    else 
        print('^1[py-gangs] - error147^7')
    end
end

----------------------
----- RGB colors -----
----------------------

function rgb(time)
    local result = {}
    local n = GetGameTimer() / 200
    result.r = math.floor(math.sin(n * time + 0) * 127 + 128)
    result.g = math.floor(math.sin(n * time + 2) * 127 + 128)
    result.b = math.floor(math.sin(n * time + 4) * 127 + 128)
    return result
end

------------------------------
----- Notification Types -----
------------------------------

RegisterNetEvent('py-gangs:Client:ErrorNotification')
AddEventHandler('py-gangs:Client:ErrorNotification', function(message)
    if Config.Notifications == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Notifications == 'swt_notifications' then
        exports['swt_notifications']:Negative(message)
    end
end)

RegisterNetEvent('py-gangs:Client:SuccesNotification')
AddEventHandler('py-gangs:Client:SuccesNotification', function(message)
    if Config.Notifications == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Notifications == 'swt_notifications' then
        exports['swt_notifications']:Success(message)
    end
end)

----------------------
----- NUI Events -----
----------------------

RegisterNUICallback('dataPost', function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args)
    cb('ok')
end)

RegisterNUICallback('cancel', function()
    SetNuiFocus(false)
end)


RegisterNetEvent('py-gangs:sendMenu', function(data)
    if  data then 
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'OPEN_MENU',
            data = data
        })
    else 
        print('^1[py-gangs] - error129^7')
    end
end)


----------------------------
----- Menu Interaction -----
----------------------------

P.Funtions.GangsInteractionMenu = function()
    RegisterCommand('OpenGangsMenu', function()
        TriggerEvent('py-gangs:Client:openInteractionMenu')
    end)

    RegisterKeyMapping('OpenGangsMenu', 'Gang openInteraccionMenu', 'KeyBoard', 'F6')

    RegisterNetEvent('py-gangs:Client:openInteractionMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Menu Gang', txt = ''},
            { id = 2, header = 'Interacción ciudadana', txt = 'Presiona aqui', params = { event = 'py-gangs:Client:openInterractionMenuSub'}},
        })
    end)
    
    RegisterNetEvent('py-gangs:Client:openInterractionMenuSub', function(data)
        TriggerEvent('py-gangs:sendMenu', {
            {id = 1,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:openInteractionMenu'}},
            {id = 2, header = 'Carnet de Identidad', txt = '', params = {event = ''}}
        })
    end)
end


-------------------------------
----- Delete Vehicle Menu -----
-------------------------------

P.Funtions.DeleteVehicleMenu = function()
    RegisterNetEvent('py-gangs:Client:deleteVehicle')
    AddEventHandler('py-gangs:Client:deleteVehicle', function()
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        local vehname = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
        
        if veh ~= 0 and type(veh) == 'number' then
            ESX.Game.DeleteVehicle(veh)
            TriggerEvent('py-gangs:Client:SuccesNotification', 'Has eliminado un '.. vehname)
        else
            TriggerEvent('py-gangs:Client:ErrorNotification', 'No estas en un Vehiculo')
        end
    end)
    
    RegisterNetEvent('py-gangs:Client:deleteVehicleMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Menu Vehiculos', txt = ''},
            { id = 2, header = 'Quieres eliminar el vehiculo', txt = 'No podras recuperarlo', params = { event = 'py-gangs:Client:deleteVehicleMenuSub'}},
        })
    end)
    
    RegisterNetEvent('py-gangs:Client:deleteVehicleMenuSub', function(data)
        TriggerEvent('py-gangs:sendMenu', {
            {id = 1,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:deleteVehicleMenu'}},
            {id = 2, header = 'Si', txt = 'Eliminaras el vehiculo', params = {event = 'py-gangs:Client:deleteVehicle'}},
        })
    end)
end

---------------------------------
----- Spawn Vehicles Events -----
---------------------------------

P.Funtions.SpawnVehicleMenu = function()
    RegisterNetEvent('py-gangs:Client:spawnVehicle')
    AddEventHandler('py-gangs:Client:spawnVehicle', function(vehicle)
        for k,v in pairs(Config.Gangs) do
            if ESX.PlayerData.job.name == v.jobName then
                if vehicle and  vehicle ~= '' and type(vehicle) == 'string' then
                    ESX.Game.SpawnVehicle(tostring(vehicle), vector3(v.Markers.spawnVehicle.spawn.x, v.Markers.spawnVehicle.spawn.y, v.Markers.spawnVehicle.spawn.z), v.Markers.spawnVehicle.spawn.h, function(veh)
                        TriggerEvent('py-gangs:Client:SuccesNotification', 'Has spawneado un '.. vehicle)
                        if v.Configs.UseCustomPlate ~= nil and type(v.Configs.UseCustomPlate) == 'boolean'then
                            if v.SpawnVehicles.textPlate and type(v.SpawnVehicles.textPlate) == 'string' then 
                                SetVehicleNumberPlateText(veh, v.SpawnVehicles.textPlate)
                            else
                                print('^1[py-gangs] - error217^7')
                            end
                        else
                            print('^1[py-gangs] - error204^7')
                        end
                        exports['LegacyFuel']:SetFuel(veh, GetRandomIntInRange(80, 90))
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                        SetVehicleEngineOn(veh, true, true, false)
                    end)
                else 
                    print('^1[py-gangs] - error207^7')
                end
            end
        end
    end)


    RegisterNetEvent('py-gangs:Client:spawnVehicleMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Menu Vehiculos', txt = ''},
            { id = 2, header = 'Spawnear Vehiculo', txt = 'Presiona para acceder', params = { event = 'py-gangs:Client:spawnVehicleMenuSub'}},
        })
    end)
    
    RegisterNetEvent('py-gangs:Client:spawnVehicleMenuSub', function(data)
        for k,v in pairs(Config.Gangs) do
            if ESX.PlayerData.job.name == v.jobName then
                local elements = {}
                table.insert(elements, {id = 0,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:spawnVehicleMenu'}})
                if Config.Gangs[k].SpawnVehicles.Vehicles ~= nil then
                    for _k,_v in pairs(Config.Gangs[k].SpawnVehicles.Vehicles) do
                        table.insert(elements,_v)
                    end
                else
                    print('^1[py-gangs] - error234^7')
                end
                TriggerEvent('py-gangs:sendMenu', elements)
            end
        end
    end)
end

-----------------------------------
----- Spawn Helicopter Events -----
-----------------------------------
P.Funtions.SpawnHelicoptersMenu = function()
    RegisterNetEvent('py-gangs:Client:spawnHelicopter')
    AddEventHandler('py-gangs:Client:spawnHelicopter', function(helicopter)
        for k,v in pairs(Config.Gangs) do
            if ESX.PlayerData.job.name == v.jobName then
                if helicopter and  helicopter ~= '' and type(helicopter) == 'string' then
                    ESX.Game.SpawnVehicle(tostring(helicopter), vector3(v.Markers.spawnHelicopter.spawn.x, v.Markers.spawnHelicopter.spawn.y, v.Markers.spawnHelicopter.spawn.z), v.Markers.spawnHelicopter.spawn.h, function(veh)
                        TriggerEvent('py-gangs:Client:SuccesNotification', 'Has spawneado un '.. helicopter)
                        exports['LegacyFuel']:SetFuel(veh, GetRandomIntInRange(80, 90))
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                        SetVehicleEngineOn(veh, true, true, false)
                    end)
                else 
                    print('^1[py-gangs] - error207^7')
                end
            end
        end
    end)


    RegisterNetEvent('py-gangs:Client:spawnHelicopterMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Menu Helicoptero', txt = ''},
            { id = 2, header = 'Spawnear Helicoptero', txt = 'Presiona para acceder', params = { event = 'py-gangs:Client:spawnHelicopterMenuSub'}},
        })
    end)
    
    RegisterNetEvent('py-gangs:Client:spawnHelicopterMenuSub', function(data)
        for k,v in pairs(Config.Gangs) do
            if ESX.PlayerData.job.name == v.jobName then
                local elements = {}
                table.insert(elements, {id = 0,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:spawnHelicopterMenu'}})
                if Config.Gangs[k].SpawnHelicopters.Helicopters ~= nil then
                    for _k,_v in pairs(Config.Gangs[k].SpawnHelicopters.Helicopters) do
                        table.insert(elements,_v)
                    end
                else
                    print('^1[py-gangs] - error234^7')
                end
                TriggerEvent('py-gangs:sendMenu', elements)
            end
        end
    end)
end

----------------------------------
----- Delete Helicopter Menu -----
----------------------------------

P.Funtions.DeleteHelicopterMenu = function()
    RegisterNetEvent('py-gangs:Client:deleteHelicopter')
    AddEventHandler('py-gangs:Client:deleteHelicopter', function()
        local ped = GetPlayerPed(-1)
        local hel = GetVehiclePedIsIn(ped, false)
        local helname = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(hel)))
        
        if hel ~= 0 and type(hel) == 'number' then
            ESX.Game.DeleteVehicle(hel)
            TriggerEvent('py-gangs:Client:SuccesNotification', 'Has eliminado un '.. helname)
        else
            TriggerEvent('py-gangs:Client:ErrorNotification', 'No estas en un Vehiculo')
        end
    end)
    
    RegisterNetEvent('py-gangs:Client:deleteHelicopterMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Menu Vehiculos', txt = ''},
            { id = 2, header = 'Quieres eliminar el vehiculo', txt = 'No podras recuperarlo', params = { event = 'py-gangs:Client:deleteHelicopterMenuSub'}},
        })
    end)
    
    RegisterNetEvent('py-gangs:Client:deleteHelicopterMenuSub', function(data)
        TriggerEvent('py-gangs:sendMenu', {
            {id = 1,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:deleteHelicopterMenu'}},
            {id = 2, header = 'Si', txt = 'Eliminaras el vehiculo', params = {event = 'py-gangs:Client:deleteHelicopter'}},
        })
    end)
end

-------------------------------
----- Change Clothes Menu -----
-------------------------------

P.Funtions.ChangeClothesMenu = function()
    local function SetClothes (value, skk)
        local superSkin = {}

        if value == nil then value = false end

        if Config.Gangs[actGang].clothes.outfits and type(Config.Gangs[actGang].clothes.outfits) == 'table' then
            for k, v in pairs(Config.Gangs[actGang].clothes.outfits)do
                if tonumber(skk[1]) == k then
                    superSkin = v
                end
            end
        else
            print('^1[py-gangs] - error261^7')
        end

        if value then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, superSkin.Male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, superSkin.Female)
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        RequestModel(model)
                        Citizen.Wait(0)
                    end 
                    SetPlayerModel(PlayerId(), model)
                    SetModelAsNoLongerNeeded(model)
                end 
            end)
        else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                local model = nil   
                if skin.sex == 0 then
                    model = GetHashKey('mp_m_freemode_01')
                else
                    model = GetHashKey('mp_f_freemode_01')
                end 
                RequestModel(model)
                while not HasModelLoaded(model) do
                    RequestModel(model)
                    Citizen.Wait(1)
                end
                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model) 
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
            end)
        end
    end

    RegisterNetEvent('py-gangs:Client:SetClothes')
    AddEventHandler('py-gangs:Client:SetClothes', function(id)
        SetClothes(true,id)
    end)

    RegisterNetEvent('py-gangs:Client:SetDFClothes')
    AddEventHandler('py-gangs:Client:SetDFClothes', function()
        SetClothes(false,{0})
    end)

    RegisterNetEvent('py-gangs:Client:clothesMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Gang Menu', txt = ''},
            { id = 2, header = 'Quieres cambiarte de ropa', txt = 'Presiona aqui', params = { event = 'py-gangs:Client:clothesMenuSub'}},
        })
    end)

    RegisterNetEvent('py-gangs:Client:clothesMenuSub', function(data)
        for k,v in pairs(Config.Gangs) do
            if ESX.PlayerData.job.name == v.jobName then
                actGang = tostring(k)
                local elemets = {}
                table.insert(elemets, {id = 0, header = '< Atras',txt = '', params = {event = 'py-gangs:Client:clothesMenu'}})
                table.insert(elemets, {id = 1, header = 'Ropa civil', txt = 'Presiona aqui', params = {event = 'py-gangs:Client:SetDFClothes'}})
                
                if Config and Config.Gangs[k].clothes.menu and type(Config.Gangs[k].clothes.menu) == 'table' then
                    for _k,_v in pairs(Config.Gangs[k].clothes.menu) do
                        table.insert(elemets,_v)
                    end
                else
                    print('^1[py-gangs] - error333^7')
                end

                TriggerEvent('py-gangs:sendMenu',elemets)
            end
        end
    end)
end

-----------------------
----- Armory Menu -----
-----------------------

P.Funtions.ArmoryMenu = function()
    RegisterNetEvent('py-gangs:Client:openArmoryMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Menu Armario', txt = ''},
            { id = 2, header = 'Quieres eliminar el vehiculo', txt = 'No podras recuperarlo', params = { event = 'py-gangs:Client:openArmoryMenuSub'}},
        })
    end)
    
    RegisterNetEvent('py-gangs:Client:openArmoryMenuSub', function(data)
        TriggerEvent('py-gangs:sendMenu', {
            {id = 1,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:openArmoryMenu'}},
            {id = 2, header = 'Si', txt = 'Eliminaras el vehiculo', params = {event = 'py-gangs:Client:deleteVehicle'}},
        })
    end)
end

---------------------
----- Boss Menu -----
---------------------

P.Funtions.BossMenu = function()

    RegisterNetEvent('py-gangs:Client:WashMoney')
    AddEventHandler('py-gangs:Client:WashMoney', function()
        TriggerServerEvent('py-gangs:Server:WashMoney')
    end)


    RegisterNetEvent('py-gangs:Client:openBossMenu', function()
        TriggerEvent('py-gangs:sendMenu', {
            { id = 1, header = 'Menu Boss', txt = ''},
            { id = 2, header = 'Acceder menu jefe', txt = 'Presiona aqui', params = { event = 'py-gangs:Client:openBossMenuSub'}},
            { id = 3, header = 'Lavar dinero', txt = 'Presiona aqui', params = { event = 'py-gangs:Client:openBossMenuSub2'}},
        })
    end)
    
    RegisterNetEvent('py-gangs:Client:openBossMenuSub', function(data)
        TriggerEvent('py-gangs:sendMenu', {
            {id = 1,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:openBossMenu'}},
            {id = 2, header = 'Si', txt = 'Eliminaras el vehiculo', params = {event = 'py-gangs:Client:deleteVehicle'}},
        })
    end)

    RegisterNetEvent('py-gangs:Client:openBossMenuSub2', function(data)
        TriggerEvent('py-gangs:sendMenu', {
            {id = 1,header = '< Volver',txt = '', params = {event = 'py-gangs:Client:openBossMenu'}},
            {id = 2, header = 'Si', txt = 'Lavaras todo el dinero', params = {event = 'py-gangs:Client:WashMoney'}},
        })
    end)
end


--------------------------
----- Code Main Loop -----
--------------------------

P.Funtions.CodeMainLoop = function()
    Citizen.CreateThread(function()
        while P.loop do
            local _slp = 1000
            local _dist = 2
            for k,v in pairs(Config.Gangs) do
                if ESX.PlayerData.job.name == v.jobName then
                    
                    if v.Configs.ClothesMenu then
                        local clothesMenu = v.Markers.clothesMenu
                        if clothesMenu.coords.x and clothesMenu.coords.y and clothesMenu.coords.z and type(clothesMenu.coords.x) == 'number' and type(clothesMenu.coords.y) == 'number' and type(clothesMenu.coords.z) == 'number' then
                            
                            local coords = vector3(clothesMenu.coords.x, clothesMenu.coords.y, clothesMenu.coords.z)
                            local playerloc = vector3(GetEntityCoords(PlayerPedId()))
                            local distance = #(coords - playerloc)

                            if distance < 10 then
                                _slp = 5
                                if v.Configs.MarkersRGB and type(v.Configs.MarkersRGB) == 'boolean' then
                                    markerColor = rgb(0.5)
                                    DrawMarker_2(27, clothesMenu.coords.x, clothesMenu.coords.y, clothesMenu.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, clothesMenu.size[1], clothesMenu.size[2], clothesMenu.size[3], markerColor.r, markerColor.g, markerColor.b, clothesMenu.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                else
                                    DrawMarker_2(27, clothesMenu.coords.x, clothesMenu.coords.y, clothesMenu.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, clothesMenu.size[1], clothesMenu.size[2], clothesMenu.size[3], clothesMenu.rgba[1], clothesMenu.rgba[2], v.Markers.clothesMenu.rgba[3], v.Markers.clothesMenu.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                end
                                if distance < _dist then 
                                    HelpNotification('~b~E~w~ | Menu ropa', vector3(clothesMenu.coords.x, clothesMenu.coords.y, clothesMenu.coords.z +0.5))
                                    if IsControlJustPressed(0, P.Keys['E']) then
                                        TriggerEvent('py-gangs:Client:clothesMenu')
                                    end
                                end
                            end
                        else
                            print('^1[py-gangs] - error418^7')
                            return
                        end
                    end

                    if v.Configs.SpawnVehicles then
                        local spawnVehicle = v.Markers.spawnVehicle
                        if spawnVehicle.coords.x and spawnVehicle.coords.y and spawnVehicle.coords.z and type(spawnVehicle.coords.x) == 'number' and type(spawnVehicle.coords.y) == 'number' and type(spawnVehicle.coords.z) == 'number' then
                            local coords = vector3(spawnVehicle.coords.x, spawnVehicle.coords.y, spawnVehicle.coords.z)
                            local playerloc = vector3(GetEntityCoords(PlayerPedId()))
                            local distance = #(coords - playerloc)

                            if distance < 10 then
                                _slp = 5
                                if v.Configs.MarkersRGB and type(v.Configs.MarkersRGB) == 'boolean' then
                                    markerColor = rgb(0.5)
                                    DrawMarker_2(27, spawnVehicle.coords.x, spawnVehicle.coords.y, spawnVehicle.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, spawnVehicle.size[1], spawnVehicle.size[2], spawnVehicle.size[3], markerColor.r, markerColor.g, markerColor.b, spawnVehicle.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                else
                                    DrawMarker_2(27, spawnVehicle.coords.x, spawnVehicle.coords.y, spawnVehicle.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, spawnVehicle.size[1], spawnVehicle.size[2], spawnVehicle.size[3], spawnVehicle.rgba[1], spawnVehicle.rgba[2], spawnVehicle.rgba[3], spawnVehicle.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                end
                                if distance < _dist then 
                                    HelpNotification('~b~E~w~ | Spawnear vehiculo', vector3(spawnVehicle.coords.x, spawnVehicle.coords.y, spawnVehicle.coords.z +0.5))
                                    if IsControlJustPressed(0, P.Keys['E']) then
                                        TriggerEvent('py-gangs:Client:spawnVehicleMenu')
                                    end
                                end
                            end
                        else
                            print('^1[py-gangs] - error440^7')
                            return
                        end
                    end
                    
                    if v.Configs.DeleteVehicles then
                        local deleteVehicle = v.Markers.deleteVehicle
                        if deleteVehicle.coords.x and deleteVehicle.coords.y and deleteVehicle.coords.z and type(deleteVehicle.coords.x) == 'number' and type(deleteVehicle.coords.y) == 'number' and type(deleteVehicle.coords.z) == 'number' then
                            local coords = vector3(deleteVehicle.coords.x, deleteVehicle.coords.y, deleteVehicle.coords.z)
                            local playerloc = vector3(GetEntityCoords(PlayerPedId()))
                            local distance = #(coords - playerloc)

                            if distance < 10 then
                                _slp = 5
                                if v.Configs.MarkersRGB and type(v.Configs.MarkersRGB) == 'boolean' then
                                    markerColor = rgb(0.5)
                                    DrawMarker_2(27, deleteVehicle.coords.x, deleteVehicle.coords.y, deleteVehicle.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, deleteVehicle.size[1], deleteVehicle.size[2], deleteVehicle.size[3], markerColor.r, markerColor.g, markerColor.b, deleteVehicle.rgba[4], 0, 0, 0, 1, 0, 0, 0)

                                else
                                    DrawMarker_2(27, deleteVehicle.coords.x, deleteVehicle.coords.y, deleteVehicle.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, deleteVehicle.size[1], deleteVehicle.size[2], deleteVehicle.size[3], deleteVehicle.rgba[1], deleteVehicle.rgba[2], deleteVehicle.rgba[3], deleteVehicle.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                end
                                if distance < 1 then
                                    HelpNotification('~b~E~w~ | Eliminar vehiculo', vector3(deleteVehicle.coords.x, deleteVehicle.coords.y, deleteVehicle.coords.z +0.5))
                                    if IsControlJustPressed(0, P.Keys['E']) then 
                                        TriggerEvent('py-gangs:Client:deleteVehicleMenu')
                                    end
                                end
                            end
                        else 
                            print('^1[py-gangs] - error462^7')
                            return
                        end
                    end

                    if v.Configs.ArmoryMenu then 
                        local armoryMenu = v.Markers.armoryMenu
                        if armoryMenu.coords.x and armoryMenu.coords.y and armoryMenu.coords.z and type(armoryMenu.coords.x) == 'number' and type(armoryMenu.coords.y) == 'number' and type(armoryMenu.coords.z) == 'number' then
                            local coords = vector3(armoryMenu.coords.x, armoryMenu.coords.y, armoryMenu.coords.z)
                            local playerloc = vector3(GetEntityCoords(PlayerPedId()))
                            local distance = #(coords - playerloc)

                            if distance < 10 then
                                _slp = 5
                                if v.Configs.MarkersRGB and type(v.Configs.MarkersRGB) == 'boolean' then
                                    markerColor = rgb(0.5)
                                    DrawMarker_2(27, armoryMenu.coords.x, armoryMenu.coords.y, armoryMenu.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, armoryMenu.size[1], armoryMenu.size[2], armoryMenu.size[3], markerColor.r, markerColor.g, markerColor.b, armoryMenu.rgba[4], 0, 0, 0, 1, 0, 0, 0)

                                else
                                    DrawMarker_2(27, armoryMenu.coords.x, armoryMenu.coords.y, armoryMenu.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, armoryMenu.size[1], armoryMenu.size[2], armoryMenu.size[3], armoryMenu.rgba[1], armoryMenu.rgba[2], armoryMenu.rgba[3], armoryMenu.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                end
                                if distance < _dist then 
                                    HelpNotification('~b~E~w~ | Armario Menu', vector3(armoryMenu.coords.x, armoryMenu.coords.y, armoryMenu.coords.z +0.5))
                                    if IsControlJustPressed(0, P.Keys['E']) then 
                                        TriggerEvent('py-gangs:Client:openArmoryMenu')
                                    end
                                end
                            end
                        else 
                            print('^1[py-gangs] - error484^7')
                            return
                        end 
                    end

                    if v.Configs.BossMenu then
                        bossMenu = v.Markers.bossMenu
                        if bossMenu.coords.x and bossMenu.coords.y and bossMenu.coords.z and type(bossMenu.coords.x) == 'number' and type(bossMenu.coords.y) == 'number' and type(bossMenu.coords.z) == 'number' then
                            local coords = vector3(bossMenu.coords.x, bossMenu.coords.y, bossMenu.coords.z)
                            local playerloc = vector3(GetEntityCoords(PlayerPedId()))
                            local distance = #(coords - playerloc)

                            if distance < 10 then
                                _slp = 5
                                if v.Configs.MarkersRGB and type(v.Configs.MarkersRGB) == 'boolean' then
                                    markerColor = rgb(0.5)
                                    DrawMarker_2(27, bossMenu.coords.x, bossMenu.coords.y, bossMenu.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bossMenu.size[1], bossMenu.size[2], bossMenu.size[3], markerColor.r, markerColor.g, markerColor.b, bossMenu.rgba[4], 0, 0, 0, 1, 0, 0, 0)

                                else
                                    DrawMarker_2(27, bossMenu.coords.x, bossMenu.coords.y, bossMenu.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bossMenu.size[1], bossMenu.size[2], bossMenu.size[3], bossMenu.rgba[1], bossMenu.rgba[2], bossMenu.rgba[3], bossMenu.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                end
                                if distance < _dist then 
                                    HelpNotification('~b~E~w~ | Boss Menu', vector3(bossMenu.coords.x, bossMenu.coords.y, bossMenu.coords.z +0.5))
                                    if IsControlJustPressed(0, P.Keys['E']) then
                                        TriggerEvent('py-gangs:Client:openBossMenu')
                                    end
                                end
                            end
                        else 
                            print('^1[py-gangs] - error506^7')
                            return
                        end

                        if v.Configs.HelicopterMenu then
                            if v.HelicopterMenu ~= nil and type(v.HelicopterMenu) == 'boolean' then
                                spawnHelicopter = v.Markers.spawnHelicopter
                                if spawnHelicopter.coords.x and spawnHelicopter.coords.y and spawnHelicopter.coords.z and type(spawnHelicopter.coords.x) == 'number' and type(spawnHelicopter.coords.y) == 'number' and type(spawnHelicopter.coords.z) == 'number' then
                                    if v.HelicopterMenu then
                                        local coords = vector3(spawnHelicopter.coords.x, spawnHelicopter.coords.y, spawnHelicopter.coords.z)
                                        local playerloc = vector3(GetEntityCoords(PlayerPedId()))
                                        local distance = #(coords - playerloc)
            
                                        if distance < 10 then
                                            _slp = 5
                                            if v.Configs.MarkersRGB and type(v.Configs.MarkersRGB) == 'boolean' then
                                                markerColor = rgb(0.5)
                                                DrawMarker_2(27, spawnHelicopter.coords.x, spawnHelicopter.coords.y, spawnHelicopter.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, spawnHelicopter.size[1], spawnHelicopter.size[2], spawnHelicopter.size[3], markerColor.r, markerColor.g, markerColor.b, spawnHelicopter.rgba[4], 0, 0, 0, 1, 0, 0, 0)
            
                                            else
                                                DrawMarker_2(27, spawnHelicopter.coords.x, spawnHelicopter.coords.y, spawnHelicopter.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, spawnHelicopter.size[1], spawnHelicopter.size[2], spawnHelicopter.size[3], spawnHelicopter.rgba[1], spawnHelicopter.rgba[2], spawnHelicopter.rgba[3], spawnHelicopter.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                            end
                                            if distance < _dist then 
                                                HelpNotification('~b~E~w~ | Helicopter Menu', vector3(spawnHelicopter.coords.x, spawnHelicopter.coords.y, spawnHelicopter.coords.z +0.5))
                                                if IsControlJustPressed(0, P.Keys['E']) then 
                                                    TriggerEvent('py-gangs:Client:spawnHelicopterMenu')
                                                end
                                            end
                                        end
                                    end
                                else 
                                    print('^1[py-gangs] - error659^7')
                                    return
                                end
                            else
                                print('^1[py-gangs] - error646^7')
                                return
                            end
                        end

                        if v.Configs.DeleteHelicopters then
                            if v.HelicopterMenu ~= nil and type(v.HelicopterMenu) == 'boolean' then
                                deleteHelicopter = v.Markers.deleteHelicopter
                                if deleteHelicopter.coords.x and deleteHelicopter.coords.y and deleteHelicopter.coords.z and type(deleteHelicopter.coords.x) == 'number' and type(deleteHelicopter.coords.y) == 'number' and type(deleteHelicopter.coords.z) == 'number' then
                                    if v.HelicopterMenu then
                                        local coords = vector3(deleteHelicopter.coords.x, deleteHelicopter.coords.y, deleteHelicopter.coords.z)
                                        local playerloc = vector3(GetEntityCoords(PlayerPedId()))
                                        local distance = #(coords - playerloc)
            
                                        if distance < 10 then
                                            _slp = 5
                                            if v.Configs.MarkersRGB and type(v.Configs.MarkersRGB) == 'boolean' then
                                                markerColor = rgb(0.5)
                                                DrawMarker_2(27, deleteHelicopter.coords.x, deleteHelicopter.coords.y, deleteHelicopter.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, deleteHelicopter.size[1], deleteHelicopter.size[2], deleteHelicopter.size[3], markerColor.r, markerColor.g, markerColor.b, deleteHelicopter.rgba[4], 0, 0, 0, 1, 0, 0, 0)
            
                                            else
                                                DrawMarker_2(27, deleteHelicopter.coords.x, deleteHelicopter.coords.y, deleteHelicopter.coords.z -0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, deleteHelicopter.size[1], deleteHelicopter.size[2], deleteHelicopter.size[3], deleteHelicopter.rgba[1], deleteHelicopter.rgba[2], deleteHelicopter.rgba[3], deleteHelicopter.rgba[4], 0, 0, 0, 1, 0, 0, 0)
                                            end
                                            if distance < 2 then 
                                                HelpNotification('~b~E~w~ | Delete Helicopter', vector3(deleteHelicopter.coords.x, deleteHelicopter.coords.y, deleteHelicopter.coords.z +0.5))
                                                if IsControlJustPressed(0, P.Keys['E']) then 
                                                    TriggerEvent('py-gangs:Client:deleteHelicopterMenu')
                                                end
                                            end
                                        end
                                    end
                                else 
                                    print('^1[py-gangs] - error659^7')
                                    return
                                end
                            else
                                print('^1[py-gangs] - error646^7')
                                return
                            end
                        end
                    end
                end
            end
            Citizen.Wait(_slp)
        end
    end)
end

---------------------------------------------------------------
----------------------------- END -----------------------------
---------------------------------------------------------------