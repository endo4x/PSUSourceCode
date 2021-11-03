--[[
	id: Ps8apZd4BGgn8pC6Se5gP
	name: esx_lscustom
	description: lscastom
	time1: 2021-04-24 17:58:34.937327+00
	time2: 2021-04-24 17:58:34.937328+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

PlayerData = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local lastMenu = "mainMenu"
local fullPrice = 0
local currentPrice = 0
local currentMod = -1
local selectedColor1 = 0
local selectedColor2 = 0
local selectedColor3 = 0
local selectedColor4 = 0
local vehPrice = Config.DefaultCarPrice
local opened = false
local isInCar = false
local hasLights = false
local useHorn = false
local inBody = false
local doorsOpen = false
local mecanoMenu = false
local jobOnly = true
local cam = nil
local previousMods = nil
local currentMenu = nil
local currentCategory = nil
local currentModCategory = nil
local currentVehicle = nil
local ownedMods = {}
local modsToBuy = {}
local choosenMods = {}
local engine = {
    mods = {39,40,41,11,18,13,12,15},
    has = {}
}
local performance = {
    mods = {11,18,13,12,15},
    has = {}
}
local body = {
    mods = {0,1,2,3,4,6,7,8,10,42,43,44,45,46,5},
    has = {}
}
local interior = {
    mods = {27,28,29,30,31,32,34,35,36,37,38},
    has = {}
}

Citizen.CreateThread(function()
    isInCar = IsPedInAnyVehicle(GetPlayerPed(-1))
    while ESX == nil do
        Citizen.Wait(100)
    end
    while true do
        Citizen.Wait(0)
        if isInCar and opened == false then
            local ped = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsUsing(ped)
            local coords = GetEntityCoords(vehicle)
            for i=1, #Config.Shops do
                local dis = GetDistanceBetweenCoords(coords, Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z, false)
                if dis <= 4 then

                    ESX.ShowHelpNotification(Config.Language.press.." ~INPUT_PICKUP~ "..Config.Language.openShop)
                    if IsDisabledControlJustReleased(0, 38) then -- E
                        OpenTuningMenu(Config.Shops[i])
                    end
                    DrawMarker(1, Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z + (-0.1), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 6.8, 6.8, 0.8, Config.Markers.active[1], Config.Markers.active[2], Config.Markers.active[3], Config.Markers.active[4], false, true, 2, nil, nil, false)
                elseif dis < Config.DrawDistance then
                    DrawMarker(1, Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z + (-0.1), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 6.8, 6.8, 0.8, Config.Markers.inactive[1], Config.Markers.inactive[2], Config.Markers.inactive[3], Config.Markers.inactive[4], false, true, 2, nil, nil, false)
                end
            end
        end
        if mecanoMenu then
            
        end
        if opened then
            
            if useHorn then
                ESX.ShowHelpNotification(Config.Language.press.." ~INPUT_PICKUP~ "..Config.Language.hornPreview)

            elseif inBody then
                local check = Config.Language.openDoors
                if doorsOpen then
                    check = Config.Language.closeDoors
                end
                ESX.ShowHelpNotification(Config.Language.press.." ~INPUT_VEH_FLY_DUCK~ "..check)

                if IsDisabledControlJustReleased(0, 120) then
                    if doorsOpen then
                        CloseDoors()
                    else
                        OpenDoors(true)
                    end
                end
            else
                ESX.ShowHelpNotification(Config.Language.press.." ~INPUT_NEXT_CAMERA~ "..Config.Language.changeCam)
            end

            if IsDisabledControlJustReleased(0, 177) then
                MenageBackSpace()
            end
            if IsDisabledControlJustReleased(0, 174) then -- left
                SendNUIMessage({
                    action = "swipe",
                    side = "left",
                    element = "#"..currentMenu
                })
            elseif IsDisabledControlJustReleased(0, 175) then -- right
                SendNUIMessage({
                    action = "swipe",
                    side = "right",
                    element = "#"..currentMenu
                })
            elseif IsDisabledControlJustReleased(0, 176) then -- enter
                EnterPressed()
            elseif IsDisabledControlJustReleased(0, 172) then -- up
                SendNUIMessage({
                    action = "scroll",
                    direct = "up"
                })
            elseif IsDisabledControlJustReleased(0, 173) then -- down
                SendNUIMessage({
                    action = "scroll",
                    direct = "down"
                })
            end
        end
    end
end)

function OpenMecanoInstallMenu(jobName)
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    previousMods = ESX.Game.GetVehicleProperties(veh)
    ESX.TriggerServerCallback('esx_lscustom:getVehicleTuning', function(array, price)
        if array ~= nil then
            if #array > 0 then
                InstallModsMecano(array)
                local elementsBuy = {}
                if jobName == "none" then
                    table.insert(elementsBuy, {label = Config.Language.yes.." - "..Config.Language.price..": "..price.."€", value='yes'})
                    table.insert(elementsBuy, {label = Config.Language.no, value='no'})
                else
                    table.insert(elementsBuy, {label = Config.Language.yes.." - "..Config.Language.value..": "..price.."€ - "..Config.Language.price..": "..math.floor(price * Config.Discount).."€", value='yes'})
                    table.insert(elementsBuy, {label = Config.Language.no, value='no'})
                end
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'install_mods', {
                    title    = Config.Language.installPrompt,
                    align    = Config.MenuAlign,
                    elements = elementsBuy
                }, function(data2, menu2)
                    local action = data2.current.value
                    if action == 'yes' then
                        local newProps = ESX.Game.GetVehicleProperties(veh)
                        ESX.TriggerServerCallback('esx_lscustom:payForTuning', function(cb)
                            if cb == false then
                                ESX.Game.SetVehicleProperties(veh, previousMods)
                            end
                            ESX.UI.Menu.CloseAll()
                            SetVehicleLightsMode(veh, 0)
                            mecanoMenu = false
                            
                            if cb == false then
                                return
                            end
                            local new = ESX.Game.GetVehicleProperties(veh)
                            new.model = GetEntityModel(veh)
                            local take = 0
                            while new.model == 0 do
                                new.model = GetEntityModel(veh)
                                take = take + 1
                                Citizen.Wait(10)
                                if take >= 50 then
                                    break
                                end
                            end
                            previousMods = nil
                        end, price, previousMods.plate, previousMods, newProps)
                    elseif action == 'no' then
                        ESX.Game.SetVehicleProperties(veh, previousMods)
                        ESX.UI.Menu.CloseAll()
                        SetVehicleLightsMode(veh, 0)
                        mecanoMenu = false
                        
                        previousMods = nil
                    end
                end, function(data2, menu2)
                    ESX.Game.SetVehicleProperties(veh, previousMods)
                    ESX.UI.Menu.CloseAll()
                    mecanoMenu = false
                    
                    previousMods = nil
                end)
            else
                TriggerEvent('esx_lscustom:clientNotify', {text = Config.Language.noSavedMods, type='false'})
                ESX.UI.Menu.CloseAll()
                mecanoMenu = false
                
            end
        else
            TriggerEvent('esx_lscustom:clientNotify', {text = Config.Language.noSavedMods, type='false'})
            ESX.UI.Menu.CloseAll()
            mecanoMenu = false
            
        end
    end, previousMods.plate)
end

function InstallModsMecano(array)
    local v = array
    Reset()
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    ESX.Game.SetVehicleProperties(veh, previousMods)
    ToggleVehicleMod(veh, 22, previousMods.modXenon)
    SetVehicleHeadlightsColour(veh, light_color)
    SetVehicleMod(veh, 46, previousMods.modWindows, false)
    SetVehicleWindowTint(veh, previousMods.windowTint)
    SetVehicleTyreSmokeColor(veh, table.unpack(previousMods.tyreSmokeColor))
    local color1 = previousMods.color1
    local color2 = previousMods.color2
    local pearlColor = previousMods.pearlescentColor
    local wheelColor = previousMods.wheelColor
    if v ~= nil then
        if #v > 0 then
            for i=1, #v do
                local check = tostring(v[i].category)
                local part = tonumber(v[i].part)
                if check == '11' or check == '18' or check == '13' or check == '12' then
                    -- 18 -- turbo
                    -- 11 -- silnik
                    -- 13 -- skrzynia
                    -- 23 -- hamulce
                    if check == '18' then
                        if part == 1 then
                            ToggleVehicleMod(veh, 18, false)
                        else
                            ToggleVehicleMod(veh, 18, true)
                        end
                    else
                        SetVehicleMod(veh, tonumber(v[i].category), part, false)
                    end
                elseif check == '22' then -- światła
                    SetVehicleLights(veh, 2)
                    ToggleVehicleMod(veh, 22, true)
                    SetVehicleHeadlightsColour(veh, part)
                elseif check == '46' then -- szyby
                    SetVehicleMod(veh, tonumber(v[i].category), part, false)
                    SetVehicleWindowTint(veh, part)
                elseif check == 'tires' then
                    SetVehicleTyreSmokeColor(veh, table.unpack(Modyfikacje['tires'][part+2].smokecolor))
                elseif check == 'tablice' then
                    SetVehicleNumberPlateTextIndex(veh, tonumber(Modyfikacje['tablice'][part+2].plateindex))
                elseif check == 'neon' then
                    SetVehicleNeonLightEnabled(veh, 0, Modyfikacje['neon'][part+2].neons[1])
                    SetVehicleNeonLightEnabled(veh, 1, Modyfikacje['neon'][part+2].neons[2])
                    SetVehicleNeonLightEnabled(veh, 2, Modyfikacje['neon'][part+2].neons[3])
                    SetVehicleNeonLightEnabled(veh, 3, Modyfikacje['neon'][part+2].neons[4])
                elseif check == 'neonColor' then
                    SetVehicleNeonLightsColour(veh, table.unpack(Modyfikacje['neonColor'][part+2].neon))
                elseif check == "color1" then
                    printf('cambia '..check..' sopra '..part)
                    color1 = Modyfikacje['colors'][part+4].colorindex
                elseif check == "color2" then
                    printf('cambia '..check..' sopra '..part)
                    color2 = Modyfikacje['colors'][part+4].colorindex
                elseif check == "color3" then
                    printf('cambia '..check..' sopra '..part)
                    pearlColor = Modyfikacje['colors'][part+4].colorindex
                elseif check == "wheelsColor" then
                    printf('cambia '..check..' sopra '..part)
                    wheelColor = Modyfikacje['colors'][part+4].colorindex
                elseif check == 'frontWheel' or check == 'backWheel' or check == 'sportWheel' or check == 'suvWheel' or check == 'offroadWheel' or check == 'tunerWheel' or check == 'highWheel' or check =='lowriderWheel' or check == 'muscleWheel' then
                    SetVehicleWheelType(veh, Modyfikacje[check][part+4].wtype)
                    if check == 'backWheel' then
                        SetVehicleMod(veh, 24, Modyfikacje[check][part+4].mod)
                    else
                        SetVehicleMod(veh, 23, Modyfikacje[check][part+4].mod)
                    end
                else -- reszta
                    SetVehicleMod(veh, tonumber(v[i].category), part)
                end
                SetVehColorsMecano(color1, color2, pearlColor, wheelColor)
            end
        end
    end
end

function SetVehColorsMecano(x, y, z, v)
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    local color1 = ownedMods.color1
    local color2 = ownedMods.color2
    local pearlColor = ownedMods.pearlescentColor
    local wheelColor = ownedMods.wheelColor
    if x ~= nil then
        color1 = x
    end
    if y ~= nil then
        color2 = y
    end
    if z ~= nil then
        pearlColor = z
    end
    if v ~= nil then
        wheelColor = v
    end
    SetVehicleColours(veh, color1, color2)
    SetVehicleExtraColours(veh, pearlColor, wheelColor)
end

function Reset()
    vehPrice = Config.DefaultCarPrice
    ownedMods = {}
    opened = false
    hasLights = false
    jobOnly = true
    lastMenu = "mainMenu"
    currentMenu = nil
    currentCategory = nil
    currentModCategory = nil
    currentVehicle = nil
    choosenMods = {}
    fullPrice = 0
    currentPrice = 0
    currentMod = -1
    modsToBuy = {}
    selectedColor1 = 0
    selectedColor2 = 0
    selectedColor3 = 0
    selectedColor4 = 0
end

function GetVehicleMods(vehicle)
    local veh = vehicle
    ownedMods = ESX.Game.GetVehicleProperties(veh)
    SetVehicleModKit(vehicle, 0)
    for i = 0, 48 do
        if i == 18 then -- turbina
            SendNUIMessage({
                action = "show",
                id = 18,
                modCount = 1
            })
        elseif i == 46 then
            hasWindows = false
            if IsMotorcycle() then -- szyby
                SendNUIMessage({
                    action = "hide",
                    id = 46,
                    modCount = 5
                })
            else
                hasWindows = true
                SendNUIMessage({
                    action = "show",
                    id = 46,
                    modCount = 5
                })
            end
        elseif i == 22 then -- światła
            if IsMotorcycle() then
                hasLights = false
                SendNUIMessage({
                    action = "hide",
                    id = 22,
                    modCount = 0
                })
            else
                hasLights = true
                SendNUIMessage({
                    action = "show",
                    id = 22,
                    modCount = 13
                })
            end
        elseif i == 14 then
            SendNUIMessage({
                action = "show",
                id = 14,
                modCount = 35
            })
        elseif i == 15 then
            SendNUIMessage({
                action = "show",
                id = 15,
                modCount = 4
            })
        else
            local int = GetNumVehicleMods(veh, i)
            if int ~= nil and int ~= false and int > 0 and int ~= 46 then
                ContainAdd(i)
                SendNUIMessage({
                    action = "show",
                    id = i,
                    modCount = int
                })
            else
                SendNUIMessage({
                    action = "hide",
                    id = i
                })
            end
        end
    end
    SendNUIMessage({
        action = "show",
        id = "tires",
        modCount = 9
    })
    SendNUIMessage({
        action = "show",
        id = "tablice",
        modCount = 4
    })
    if IsMotorcycle() then
        hasLights = false
        SendNUIMessage({
            action = "hide",
            id = "neon",
            modCount = 0
        })
        SendNUIMessage({
            action = "hide",
            id = "neonColor",
            modCount = 0
        })
    else
        hasLights = true
        SendNUIMessage({
            action = "show",
            id = "neon",
            modCount = 3
        })
        SendNUIMessage({
            action = "show",
            id = "neonColor",
            modCount = 12
        })
    end
    SendNUIMessage({
        action = "show",
        id = "color1",
        modCount = #Modyfikacje['colors'] - 3
    })
    SendNUIMessage({
        action = "show",
        id = "color2",
        modCount = #Modyfikacje['colors'] - 3
    })
    SendNUIMessage({
        action = "show",
        id = "color3",
        modCount = #Modyfikacje['colors'] - 3
    })
    SendNUIMessage({
        action = "show",
        id = "wheelsColor",
        modCount = #Modyfikacje['colors'] - 3
    })
    -- felgi
    if IsMotorcycle() then
        SendNUIMessage({
            action = "show",
            id = "frontWheel",
            modCount = #Modyfikacje['frontWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "backWheel",
            modCount = #Modyfikacje['backWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "sportWheel",
            modCount = #Modyfikacje['sportWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "suvWheel",
            modCount = #Modyfikacje['suvWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "offroadWheel",
            modCount = #Modyfikacje['offroadWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "tunerWheel",
            modCount = #Modyfikacje['tunerWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "highWheel",
            modCount = #Modyfikacje['highWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "lowriderWheel",
            modCount = #Modyfikacje['lowriderWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "muscleWheel",
            modCount = #Modyfikacje['muscleWheel']
        })
    else
        SendNUIMessage({
            action = "hide",
            id = "frontWheel",
            modCount = #Modyfikacje['frontWheel']
        })
        SendNUIMessage({
            action = "hide",
            id = "backWheel",
            modCount = #Modyfikacje['backWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "sportWheel",
            modCount = #Modyfikacje['sportWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "suvWheel",
            modCount = #Modyfikacje['suvWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "offroadWheel",
            modCount = #Modyfikacje['offroadWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "tunerWheel",
            modCount = #Modyfikacje['tunerWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "highWheel",
            modCount = #Modyfikacje['highWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "lowriderWheel",
            modCount = #Modyfikacje['lowriderWheel']
        })
        SendNUIMessage({
            action = "show",
            id = "muscleWheel",
            modCount = #Modyfikacje['muscleWheel']
        })
    end
    HideCategories()
end

function IsMotorcycle()
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    return IsThisModelABike(GetEntityModel(veh))
end

function ClearCategories()
    engine.has = {}
    performance.has = {}
    body.has = {}
    interior.has = {}
    hasLights = false
    hasWindows = false
end

function ContainAdd(int)
    for i=1, #engine.mods do
        if engine.mods[i] == int then
            table.insert(engine.has, int)
            return
        end
    end
    for i=1, #performance.mods do
        if performance.mods[i] == int then
            table.insert(performance.has, int)
            return
        end
    end
    for i=1, #body.mods do
        if body.mods[i] == int then
            table.insert(body.has, int)
            return
        end
    end
    for i=1, #interior.mods do
        if interior.mods[i] == int then
            table.insert(interior.has, int)
            return
        end
    end
end

function HideCategories()
    if #performance.has > 0 then
        SendNUIMessage({
            action = "show",
            id = "catPerformance"
        })
    else
        SendNUIMessage({
            action = "hide",
            id = "catPerformance"
        })
    end
    if #engine.has > 0 then
        SendNUIMessage({
            action = "show",
            id = "catEngine"
        })
        SendNUIMessage({
            action = "show",
            id = "catPerformance"
        })
    else
        SendNUIMessage({
            action = "hide",
            id = "catEngine"
        })
    end
    if #body.has > 0 then
        SendNUIMessage({
            action = "show",
            id = "catBody"
        })
    else
        SendNUIMessage({
            action = "hide",
            id = "catBody"
        })
    end
    if #interior.has > 0 then
        SendNUIMessage({
            action = "show",
            id = "catInterior"
        })
    else
        SendNUIMessage({
            action = "hide",
            id = "catInterior"
        })
    end
    if hasLights then
        SendNUIMessage({
            action = "show",
            id = "catLights"
        })
    else
        SendNUIMessage({
            action = "hide",
            id = "catLights"
        })
    end
end

function UpdatePrice()
    fullPrice = 0
    if modsToBuy ~= nil then
        if #modsToBuy > 0 then
            for i=1, #modsToBuy do
                fullPrice = fullPrice + modsToBuy[i].price
            end
        end
    end
    SendNUIMessage({
        action = "updatePrice",
        price = fullPrice
    })
end

function OpenTuningMenu(this)
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    printf("Config job: "..this.job.."; My job = "..tostring(PlayerData.job.name))
    if (PlayerData.job ~= nil and PlayerData.job.name == this.job) or (this.job == "none") then
        jobOnly = true
        if this.job == "none" then
            jobOnly = false
        end
        mecanoMenu = true
        -- wybór
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_option2', {
			title    = Config.Language.mainMenu,
			align    = Config.MenuAlign,
			elements = {
                {label = Config.Language.openModsList, value='preview'},
                {label = Config.Language.installMods, value='install'},
            }
        }, function(data, menu)
            local action = data.current.value
            if action == 'preview' then
                ESX.TriggerServerCallback('esx_lscustom:getVehiclePrice', function(price)
                    if price ~= nil then
                        vehPrice = price
                    end
                    mecanoMenu = false
                    
                    ESX.UI.Menu.CloseAll()
                    Citizen.Wait(100)
                    ClearCategories()
                    GetVehicleMods(veh)
                    opened = true
                    currentMenu = "mainMenu"
                    SendNUIMessage({
                        action = "open",
                        menu = currentMenu
                    })
                end, GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))
            elseif action == 'install' then
                OpenMecanoInstallMenu(this.job)
            end
        end, function(data, menu)
            mecanoMenu = false
            
			menu.close()
		end)
    else
        ESX.TriggerServerCallback('esx_lscustom:getVehiclePrice', function(price)
            if price ~= nil then
                vehPrice = price
            end
            ClearCategories()
            GetVehicleMods(veh)
            opened = true
            currentMenu = "mainMenu"
            SendNUIMessage({
                action = "open",
                menu = currentMenu
            })
        end, GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))
    end
end

function ReOpenMenu()
    if currentMenu == "menuKaroseria" then
        inBody = true
        doorsOpen = false
    else
        inBody = false
        doorsOpen = false
    end
    SendNUIMessage({
        action = "open",
        menu = currentMenu
    })
end

function MenageBackSpace()
    if currentMenu == "mainMenu" then
        CloseTuningMenu(false)
    else
        if currentMenu == "menuOsiagi" then
            currentMenu = "mainMenu"
            ReOpenMenu()
            InstallCurrentMods()
            CloseDoors()
        elseif currentMenu == "menuOsiagiSilnik" then
            currentMenu = "menuOsiagi"
            ReOpenMenu()
            InstallCurrentMods()
            CloseDoors()
        elseif currentMenu == "menuKola" then
            currentMenu = "mainMenu"
            ReOpenMenu()
        elseif currentMenu == "menuFelgi" then
            currentMenu = "menuKola"
            ReOpenMenu()
        else
            currentMenu = lastMenu
            ReOpenMenu()
        end
    end
end

function CloseTuningMenu(bypass)
    if bypass then
        opened = false
        SendNUIMessage({
            action = "close"
        })
        local veh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        ESX.Game.SetVehicleProperties(veh, ownedMods)
        SetVehicleLightsMode(veh, 0)
        Reset()
        
    else
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_exit_lscm', {
            title    = Config.Language.leaveGarage,
            align    = Config.MenuAlign,
            elements = {
                {label = Config.Language.no, value='no'},
                {label = Config.Language.yes, value='yes'},
            }
        }, function(data, menu)
            local action = data.current.value
            if action == 'yes' then
                menu.close()
                opened = false
                SendNUIMessage({
                    action = "close"
                })
                local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
                ESX.Game.SetVehicleProperties(veh, ownedMods)
                SetVehicleLightsMode(veh, 0)
                Reset()
                
            else
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
    end
end

function EnterPressed()
    if onCategory == true then
        if currentCategory ~= nil then
            if currentCategory == 'save' then
                if modsToBuy ~= nil then
                    if #modsToBuy > 0 then
                        local plate = GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1)))
                        TriggerServerEvent('esx_lscustom:saveTuningPreset', modsToBuy, plate, fullPrice, jobOnly)
                    else
                        TriggerEvent('esx_lscustom:clientNotify', {text = Config.Language.noModsChosen, type="false"})
                    end
                else
                    TriggerEvent('esx_lscustom:clientNotify', {text = Config.Language.noModsChosen, type="false"})
                end
            else
                currentMenu = currentCategory
                onCategory = false
                currentCategory = nil
                ReOpenMenu()
                SendNUIMessage({
                    action = "swipe",
                    side = "none",
                    element = "#"..currentMenu
                })
            end
        end
    else
        CheckMod()
    end
end

function InstallCurrentMods()
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    ESX.Game.SetVehicleProperties(veh, ownedMods)
    ToggleVehicleMod(veh, 22, ownedMods.modXenon)
    SetVehicleHeadlightsColour(veh, light_color)
    SetVehicleMod(veh, 46, ownedMods.modWindows, false)
    SetVehicleWindowTint(veh, ownedMods.windowTint)
    SetVehicleTyreSmokeColor(veh, table.unpack(ownedMods.tyreSmokeColor))
    local color1 = ownedMods.color1
    local color2 = ownedMods.color2
    local pearlColor = ownedMods.pearlescentColor
    local wheelColor = ownedMods.wheelColor
    if modsToBuy ~= nil then
        if #modsToBuy > 0 then
            for i=1, #modsToBuy do
                local check = tostring(modsToBuy[i].category)
                local part = tonumber(modsToBuy[i].part)
                if check == '11' or check == '18' or check == '13' or check == '12' then
                    --printf("Tego nie montujemy bo nie ma po co")
                elseif check == '22' then -- światła
                    SetVehicleLights(veh, 2)
                    ToggleVehicleMod(veh, 22, true)
                    SetVehicleHeadlightsColour(veh, part)
                elseif check == '46' then -- szyby
                    SetVehicleMod(veh, tonumber(modsToBuy[i].category), part, false)
                    SetVehicleWindowTint(veh, part)
                elseif check == 'tires' then
                    SetVehicleTyreSmokeColor(veh, table.unpack(Modyfikacje['tires'][part+2].smokecolor))
                elseif check == 'tablice' then
                    SetVehicleNumberPlateTextIndex(veh, tonumber(Modyfikacje['tablice'][part+2].plateindex))
                elseif check == 'neon' then
                    SetVehicleNeonLightEnabled(veh, 0, Modyfikacje['neon'][part+2].neons[1])
                    SetVehicleNeonLightEnabled(veh, 1, Modyfikacje['neon'][part+2].neons[2])
                    SetVehicleNeonLightEnabled(veh, 2, Modyfikacje['neon'][part+2].neons[3])
                    SetVehicleNeonLightEnabled(veh, 3, Modyfikacje['neon'][part+2].neons[4])
                elseif check == 'neonColor' then
                    SetVehicleNeonLightsColour(veh, table.unpack(Modyfikacje['neonColor'][part+2].neon))
                elseif check == "color1" then
                    color1 = selectedColor1
                elseif check == "color2" then
                    color2 = selectedColor2
                elseif check == "color3" then
                    pearlColor = selectedColor3
                elseif check == "wheelsColor" then
                    wheelColor = selectedColor4
                elseif check == 'frontWheel' or check == 'backWheel' or check == 'sportWheel' or check == 'suvWheel' or check == 'offroadWheel' or check == 'tunerWheel' or check == 'highWheel' or check =='lowriderWheel' or check == 'muscleWheel' then
                    SetVehicleWheelType(veh, Modyfikacje[check][part+4].wtype)
                    if check == 'backWheel' then
                        SetVehicleMod(veh, 24, Modyfikacje[check][part+4].mod)
                    else
                        SetVehicleMod(veh, 23, Modyfikacje[check][part+4].mod)
                    end
                else -- reszta
                    SetVehicleMod(veh, tonumber(modsToBuy[i].category), part)
                end
                SendNUIMessage({
                    action = "installNewMod",
                    modNewCategory = modsToBuy[i].category
                })
                SendNUIMessage({
                    action = "installedMod",
                    installed = modsToBuy[i].part,
                    modCategory = modsToBuy[i].category
                })
                ManageVehColors(nil, nil, nil, nil)
            end
        end
    end
end

function ManageVehColors(one, two, three, four)
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    local color1 = ownedMods.color1
    local color2 = ownedMods.color2
    local pearlColor = ownedMods.pearlescentColor
    local wheelColor = ownedMods.wheelColor
    if modsToBuy ~= nil then
        if #modsToBuy > 0 then
            for i=1, #modsToBuy do
                local check = tostring(modsToBuy[i].category)
                local part = tonumber(modsToBuy[i].part)
                printf("[ManageVehColors] part = "..part)
                if check == "color1" then
                    color1 = Modyfikacje['colors'][part+4].colorindex
                    printf('[ManageVehColors] color1 = '..color1)
                elseif check == "color2" then
                    color2 = Modyfikacje['colors'][part+4].colorindex
                    printf('[ManageVehColors] color2 = '..color2)
                elseif check == "color3" then
                    pearlColor = Modyfikacje['colors'][part+4].colorindex
                    printf('[ManageVehColors] pearlColor = '..pearlColor)
                elseif check == "wheelsColor" then
                    wheelColor = Modyfikacje['colors'][part+4].colorindex
                    printf('[ManageVehColors] wheelColor = '..wheelColor)
                end
            end
        end
    end
    if one ~= nil then
        color1 = one
    end
    if two ~= nil then
        color2 = two
    end
    if three ~= nil then
        pearlColor = three
    end
    if four ~= nil then
        wheelColor = four
    end
    SetVehicleColours(veh, color1, color2)
    SetVehicleExtraColours(veh, pearlColor, wheelColor)
end

function CheckMod()
    local prc = currentPrice
    local insert = {
        category = currentModCategory,
        part = tostring(currentMod),
        price = prc
    }
    if modsToBuy ~= nil then
        if #modsToBuy > 0 then
            for i=1, #modsToBuy do
                if modsToBuy[i] ~= nil then
                    if modsToBuy[i].category ~= nil then
                        if modsToBuy[i].category == currentModCategory then
                            table.remove(modsToBuy, i)
                            break
                        end
                    end
                end
            end
            table.insert(modsToBuy, insert)
        else
            modsToBuy = {
                [1] = {
                    category = currentModCategory,
                    part = currentMod,
                    price = currentPrice
                }
            }
        end
    else
        modsToBuy = {
            [1] = {
                category = currentModCategory,
                part = currentMod,
                price = currentPrice
            }
        }
    end
    currentPrice = 0
    UpdatePrice()
    InstallCurrentMods()
end

function GetLabel()
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    local check = tostring(currentModCategory)
    local label = ''
    local part = 0
    local color1 = ownedMods.color1
    local color2 = ownedMods.color2
    local pearlColor = ownedMods.pearlescentColor
    local wheelColor = ownedMods.wheelColor
    if check ~= '22' and check ~= '18' and check ~= '15' and check ~= '14' and check ~= '13' and check ~= '12' and check ~= '11' and check ~= '46' and check ~= 'tires' and check ~= 'tablice' and check ~= 'neon' and check ~= 'neonColor' and check ~= 'color1' and check ~= 'color2' and check ~= 'color3' and check ~= 'wheelsColor' and check ~= 'frontWheel' and check ~= 'backWheel' and check ~= 'sportWheel' and check ~= 'suvWheel' and check ~= 'offroadWheel' and check ~= 'tunerWheel' and check ~= 'highWheel' and check ~= 'lowriderWheel' and check ~= 'muscleWheel' then
        label = GetModTextLabel(veh, tonumber(currentModCategory), tonumber(currentMod))
        if label ~= nil then
            label = tostring(GetLabelText(label))
            if label == "NULL" then
                label = Config.Language.notFoundInCdImages
            end
        else
            label = Config.Language.stock
        end
    else
        part = math.abs(tonumber(currentMod) + 2)
        if Modyfikacje[check] ~= nil then
            label = tostring(Modyfikacje[check][part].name)
        else
            if check == 'color1' or check == 'color2' or check == 'color3' or check == 'wheelsColor' then
                label = tostring(Modyfikacje['colors'][part+2].name)
            end
        end
    end
    if check == '11' or check == '18' or check == '13' or check == '12' then
        currentPrice = (tonumber(currentMod) + 1) * math.floor(0.11 * vehPrice)
        --printf("Tego nie pokazujemy bo nie ma po co")
        -- 18 -- turbo
        -- 11 -- silnik
        -- 13 -- skrzynia
        -- 12 -- hamulce
    elseif check == '22' then -- światła
        currentPrice = math.floor(0.03 * vehPrice)
        SetVehicleLights(veh, 2)
        ToggleVehicleMod(veh, 22, true)
        SetVehicleHeadlightsColour(veh, tonumber(currentMod))
    elseif check == '46' then -- szyby
        currentPrice = math.floor(0.03 * vehPrice)
        SetVehicleWindowTint(veh, tonumber(currentMod))
    elseif check == 'tires' then
        currentPrice = 30000
        SetVehicleTyreSmokeColor(veh, table.unpack(Modyfikacje[check][part].smokecolor))
        TaskVehicleTempAction(GetPlayerPed(-1), veh, 30, 1000)
    elseif check == 'tablice' then
        currentPrice = math.floor(0.01 * vehPrice)
        SetVehicleNumberPlateTextIndex(veh, tonumber(Modyfikacje['tablice'][part].plateindex))
    elseif check == 'neon' then
        currentPrice = 50000
        SetVehicleNeonLightEnabled(veh, 0, Modyfikacje['neon'][part].neons[1])
        SetVehicleNeonLightEnabled(veh, 1, Modyfikacje['neon'][part].neons[2])
        SetVehicleNeonLightEnabled(veh, 2, Modyfikacje['neon'][part].neons[3])
        SetVehicleNeonLightEnabled(veh, 3, Modyfikacje['neon'][part].neons[4])
    elseif check == 'neonColor' then
        currentPrice = 27500
        SetVehicleNeonLightsColour(veh, table.unpack(Modyfikacje['neonColor'][part].neon))
    elseif check == "color1" then
        currentPrice = math.floor(0.03 * vehPrice)
        ManageVehColors(Modyfikacje['colors'][part+2].colorindex, nil, nil, nil)
        selectedColor1 = Modyfikacje['colors'][part+2].colorindex
        printf('[GetLabel] '..check..' = '..selectedColor1)
    elseif check == "color2" then
        currentPrice = math.floor(0.03 * vehPrice)
        ManageVehColors(nil, Modyfikacje['colors'][part+2].colorindex, nil, nil)
        selectedColor2 = Modyfikacje['colors'][part+2].colorindex
        printf('[GetLabel] '..check..' = '..selectedColor2)
    elseif check == "color3" then
        currentPrice = math.floor(0.03 * vehPrice)
        ManageVehColors(nil, nil, Modyfikacje['colors'][part+2].colorindex, nil)
        selectedColor3 = Modyfikacje['colors'][part+2].colorindex
        printf('[GetLabel] '..check..' = '..selectedColor3)
    elseif check == "wheelsColor" then
        currentPrice = math.floor(0.02 * vehPrice)
        ManageVehColors(nil, nil, nil, Modyfikacje['colors'][part+2].colorindex)
        selectedColor4 = Modyfikacje['colors'][part+2].colorindex
        printf('[GetLabel] '..check..' = '..selectedColor4)
    elseif check == 'frontWheel' or check == 'backWheel' or check == 'sportWheel' or check == 'suvWheel' or check == 'offroadWheel' or check == 'tunerWheel' or check == 'highWheel' or check =='lowriderWheel' or check == 'muscleWheel' then
        currentPrice = math.floor(0.03 * vehPrice)
        SetVehicleWheelType(veh, Modyfikacje[check][part+2].wtype)
        if check == 'backWheel' then
            SetVehicleMod(veh, 24, Modyfikacje[check][part+2].mod)
        else
            SetVehicleMod(veh, 23, Modyfikacje[check][part+2].mod)
        end
    elseif check == '14' then -- klakson
        currentPrice = math.floor(0.01 * vehPrice)
        SetVehicleMod(veh, tonumber(currentModCategory), tonumber(currentMod))
        useHorn = true
    else -- reszta
        currentPrice = math.floor(0.05 * vehPrice)
        SetVehicleMod(veh, tonumber(currentModCategory), tonumber(currentMod))
    end
    SendNUIMessage({
        action = "modLabel",
        modLabel = label,
        modPrice = tostring(currentPrice)
    })
end

function CloseDoors()
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    if GetVehicleDoorAngleRatio(veh, 0) > 0.0 then
        SetVehicleDoorShut(veh, 0, 0)
    end
    if GetVehicleDoorAngleRatio(veh, 1) > 0.0 then
        SetVehicleDoorShut(veh, 1, 0)
    end
    if GetVehicleDoorAngleRatio(veh, 2) > 0.0 then
        SetVehicleDoorShut(veh, 2, 0)
    end
    if GetVehicleDoorAngleRatio(veh, 3) > 0.0 then
        SetVehicleDoorShut(veh, 3, 0)
    end
    if GetVehicleDoorAngleRatio(veh, 4) > 0.0 then
        SetVehicleDoorShut(veh, 4, 0)
    end
    if GetVehicleDoorAngleRatio(veh, 5) > 0.0 then
        SetVehicleDoorShut(veh, 5, 0)
    end
    if GetFollowVehicleCamViewMode() ~= 0 then
        SetFollowVehicleCamViewMode(0)
    end
    doorsOpen = false
end

function OpenDoors(all)
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    if all == false then
        local b = currentCategory
        local c = currentModCategory
        if c ~= nil then
            if tonumber(c) then
                if (tonumber(c) >= 39 and tonumber(c) <= 41) then -- silnik itp
                    SetVehicleDoorOpen(veh, 5, 0, 0)
                    SetVehicleDoorOpen(veh, 4, 0, 0)
                else
                    if tonumber(c) >= 27 and tonumber(c) <= 37 then
                        if tonumber(c) == 31 or tonumber(c) == 36 or tonumber(c) == 32 then
                            SetVehicleDoorOpen(veh, 0, 0, 0)
                            SetVehicleDoorOpen(veh, 1, 0, 0)
                            SetFollowVehicleCamViewMode(0)
                        else
                            SetFollowVehicleCamViewMode(4)
                        end
                    end
                end
            end
        end
    elseif all == true then
        doorsOpen = true
        SetVehicleDoorOpen(veh, 0, 0, 0)
        SetVehicleDoorOpen(veh, 1, 0, 0)
        SetVehicleDoorOpen(veh, 2, 0, 0)
        SetVehicleDoorOpen(veh, 3, 0, 0)
        SetVehicleDoorOpen(veh, 4, 0, 0)
        SetVehicleDoorOpen(veh, 5, 0, 0)
    end
end

RegisterNUICallback('previewMod', function(data, cb)
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    currentMod = data.id
    GetLabel()
    cb("OK")
end)

RegisterNUICallback('getCurrentCategory', function(data, cb)
    local i = data.number
    local id = data.name
    InstallCurrentMods()
    CloseDoors()
    onCategory = false
    currentCategory = ''
    currentModCategory = ''
    useHorn = false
    if id ~= nil then
        if id == "mainMenu" then
            onCategory = true
            currentCategory = "mainMenu"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "save" then
            onCategory = true
            currentCategory = "save"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "osiagi" then
            onCategory = true
            currentCategory = "menuOsiagi"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "silnik" then
            onCategory = true
            currentCategory = "menuOsiagiSilnik"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "karoseria" then
            onCategory = true
            currentCategory = "menuKaroseria"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "interior" then
            onCategory = true
            currentCategory = "menuInterior"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "swiatla" then
            onCategory = true
            currentCategory = "menuSwiatla"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "lakier" then
            onCategory = true
            currentCategory = "menuLakier"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "kola" then
            onCategory = true
            currentCategory = "menuKola"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        elseif id == "felgi" then
            onCategory = true
            currentCategory = "menuFelgi"
            SendNUIMessage({
                action = "modLabel",
                modLabel = '',
                modPrice = 0
            })
        else
            onCategory = false
            currentCategory = id
            currentModCategory = data.mod
            local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
            local installedMod = GetVehicleMod(veh, data.mod)
            SendNUIMessage({
                action = "installedMod",
                installed = installedMod,
                modCategory = currentModCategory
            })
            currentMod = -1
            GetLabel()
        end
        OpenDoors(false)
    else
        SendNUIMessage({
            action = "modLabel",
            modLabel = '',
            modPrice = 0
        })
    end
    cb("OK")
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if not isInCar and not IsPlayerDead(PlayerId()) then
            if IsPedInAnyVehicle(ped, false) then
                isInCar = true
                currentVehicle = GetVehiclePedIsIn(ped, false)
			end
		elseif isInCar then
			if not IsPedInAnyVehicle(ped, false) or IsPlayerDead(PlayerId()) then
                isInCar = false
                currentVehicle = nil
                SetVehicleLightsMode(GetVehiclePedIsIn(ped, true), 0)
                if opened then
                    CloseTuningMenu(true)
                end
			end
		end
		Citizen.Wait(150)
	end
end)

function printf(text)
    if Config.DebugPrint then
        print(text)
    end
end
