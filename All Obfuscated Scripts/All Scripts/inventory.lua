--[[
	id: syEkK84Fz0yZbtXDul6vP
	name: inventory
	description: inventory
	time1: 2021-05-17 11:43:42.382295+00
	time2: 2021-05-17 11:43:42.382296+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

isInInventory = false
ESX = nil
local openableself = true
local secondary = nil
local tradetarget = nil
local PlayerLoaded = false
local currentFast = nil
local fastItems = {
	[1] = nil,
	[2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

local CanOpen = false
local CanOpen2 = true

AddEventHandler('esx:onPlayerSpawn', function()
	--Citizen.CreateThread(function()
	while not PlayerLoaded do
		Citizen.Wait(100)
	end
    CanOpen = true
end)

RegisterNetEvent('t11:wait')
AddEventHandler('t11:wait', function(stat)
    if stat == true then
	    CanOpen2 = false
    else
        CanOpen2 = true
    end
end)

local SlotDelay = false
local CombatMode = false
local bildirim = false
local sended = false
local DupeDelay = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SlotDelay = false
        --print(CanOpen2)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(GetPlayerPed(-1)) then
            CombatMode = true
            bildirim = true
        end
        --print(CombatMode)
        if bildirim and not sended then
            sended = true
            ESX.ShowNotification("~r~Combat Mod~w~'a girdin!")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15000)
        CombatMode = false
        bildirim = false
        sended = false
    end
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0) 
        if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) and not SlotDelay --[[and CanOpen]] then
            if not IsEntityInWater(GetPlayerPed(-1)) and not IsEntityDead(GetPlayerPed(-1)) then
                if CanOpen2 then
                    TriggerEvent('t11_newInventory:client:openStash', 'Güvenli Envanter', 'all')
                    DisplayRadar(false)
                    SlotDelay = true
                else
                    ESX.ShowNotification("Aracın ~r~oluşmadan ~w~ envanterini açamazsın.")
                end
            else
                ESX.ShowNotification("~b~Sudayken ~w~Envanter açamazsın.")
            end
        end
    end
end)

RegisterNetEvent('t11_newInventory:client:forceClose')
AddEventHandler('t11_newInventory:client:forceClose', function()
    closeInventory()
end)

RegisterCommand('envkapat', function()
    closeInventory()
end)

function closeInventory()
    if secondary ~= nil then
        TriggerServerEvent('t11_newInventory:server:closeInv', secondary)
        secondary = nil
        DupeDelay = false
    end

    isInInventory = false
    SendNUIMessage({
        action = "hide"
    })
    SetNuiFocus(false, false)
    DisplayRadar(true)
    openVehicle = nil
end

RegisterNUICallback("NUIFocusOff", function()
    closeInventory()
end)

RegisterNUICallback("GetNearPlayers",function(data, cb)
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
    local foundPlayers = false
    local elements = {}

    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            foundPlayers = true

            table.insert(
                elements,
                {
                    label = GetPlayerName(players[i]),
                    player = GetPlayerServerId(players[i])
                }
            )
        end
    end
    SendNUIMessage(
        {
            action = "nearPlayers",
            foundAny = foundPlayers,
            players = elements,
            item = data.item
        }
    )
    cb("ok")
end)

RegisterCommand('silahsil',function(source,args)
    local ply = PlayerPedId()
    RemoveAllPedWeapons(ply,true)
end)

RegisterNUICallback("UseItem", function(data, cb)
    if data.item.name ~= nil then
        TriggerServerEvent("esx:useItem", data.item.name)
    end
    
    closeInventory()
    loadPlayerInventory()
    cb("ok")
end)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
       if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
        end

        Wait(250)
        loadPlayerInventory()
        cb("ok")
    end
)

RegisterNUICallback("GiveItem", function(data, cb)
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
    local foundPlayer = false
    for i = 1, #players, 1 do
        if players[i] ~= GetPlayerServerId(PlayerId()) then
            if GetPlayerServerId(players[i]) == data.player then
                foundPlayer = true
            end
        end
    end

    if foundPlayer then
        if tonumber(data.number) == 0 then
            data.number = data.item.count
        end

        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        --anim
        ESX.Streaming.RequestAnimDict('mp_common', function()
            TaskPlayAnim(playerPed, 'mp_common', 'givetake1_a', 8.0, -8, -1, 48, 0, 0, 0, 0)
		end)

        if data.item.type == "item_standard" then
            TriggerServerEvent("esx:giveInventoryItemxx", data.player, "item_standard", data.item.name, count)
        end
        Wait(250)
        loadPlayerInventory()
        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
    else
        ESX.ShowNotification("Yakınında kimse yok!")
    end
    cb("ok")
end)

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
    ESX.TriggerServerCallback("t11_newInventory:server:getPlayerInventory", function(data)
        items = {}
        inventory = data.inventory
        weapons = nil

        --if Config.UseWeight then
        --    weight = tonumber(data.weight)
        --    maxWeight = data.maxWeight
--
        --    if weight <= 0 then
        --        weight = 0
        --    end
--
        --    SendNUIMessage({
        --        action = "setWeight",
        --        text = weight.. " / " ..maxWeight.. " kg"
        --    })
        --end

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].count <= 0 then
                    inventory[key] = nil
                else
                    inventory[key].type = "item_standard"
                    if not checkFastSlots(inventory[key]) then
                        table.insert(items, inventory[key])
                    end
                end
            end
        end

        SendNUIMessage({
            action = "setItems",
            itemList = items,
            fastItems = fastItems
        })
    end, GetPlayerServerId(PlayerId()))
end

checkFastSlots = function(item)
    for i=1, 5, 1 do
        if fastItems[i] ~= nil then
            if fastItems[i].name == item.name then
                fastItems[i].count = item.count
                return true
            end
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isInInventory then
            local playerPed = PlayerPedId()
            DisableAllControlActions(0)
        end
    end
end)

DrawText3D = function(x, y, z, scale, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0,0,0,175)
end

--shops
Citizen.CreateThread(function()
    while true do
        sleep = 1000
        if ESX ~= nil and ESX.PlayerData.job ~= nil then
            local playerPed = PlayerPedId()
            local pcoords = GetEntityCoords(playerPed)
            for k, v in pairs(Config.Shops) do
                for z, t in pairs(v.job) do
                    if t == 'all' or ESX.PlayerData.job.name == t then
                        for val, coords in pairs(v.coords) do
                            local distance = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, coords.x, coords.y, coords.z, true)
                            if distance < 10.0 then
                                sleep = 2
                                DrawMarker(v.markerType or 1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markerSize.x or 0.2, v.markerSize.y or 0.2, v.markerSize.z or 0.2, v.markerColour.r or 55, v.markerColour.g or 255, v.markerColour.b or 55, 100, false, true, 2, true, false, false, false)
                                if distance < 1.0 then
                                    if v.use3dtext then
                                        DrawText3D(coords.x, coords.y, coords.z + 0.3, 0.35, v.msg or '[E]')
                                    else
                                        ESX.ShowHelpNotification(v.msg or '~INPUT_CONTEXT~')
                                    end
                                    if IsControlJustPressed(0, 38) then
                                        local level = exports["t11_newLevel"]:level()
                                        if level >= v.PlayerLevel then
                                            OpenShopInventory(v.items, k)
                                        else
                                            ESX.ShowNotification("Bu market için~y~ " ..v.PlayerLevel.." ~w~seviye olman lazım...")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

OpenShopInventory = function(items, label)
    if openableself then
        SendNUIMessage({
            action = "setInfoText",
            text = label
        })
        ESX.TriggerServerCallback('t11_newInventory:server:getItemsInfo', function(table)
            SendNUIMessage({
                action = "setShopInventoryItems",
                itemList = table
            })
            loadPlayerInventory()
            isInInventory = true

            SendNUIMessage({
                action = "display",
                type = "shop",
                text = GetPlayerName(PlayerId())..' - ID:'..GetPlayerServerId(PlayerId())
            })
            SetNuiFocus(true, true)
        end, items)
    else
        ESX.ShowNotification("Şuan açamazsın!")
    end
end

RegisterNUICallback("TakeFromShop", function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("t11_newInventory:server:takeItemFromShop", function(result)
            if result then
                loadPlayerInventory()
                cb("ok")
            end
        end, data.item, tonumber(data.number), tonumber(data.item.price))
    end
end)

--stashs
Citizen.CreateThread( function()
    while true do
        sleep = 1000
        if ESX ~= nil and ESX.PlayerData.job ~= nil then
            local playerPed = PlayerPedId()
            local pcoords = GetEntityCoords(playerPed)
            for k, v in pairs(Config.Stashs) do
                if (v.job == 'all' or ESX.PlayerData.job.name == v.job) and v.useMarker then
                    for val, coords in pairs(v.coords) do
                        local distance = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, coords.x, coords.y, coords.z, true)
                        if distance < 10.0 then
                            sleep = 2
                            DrawMarker(v.markerType or 1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markerSize.x or 0.2, v.markerSize.y or 0.2, v.markerSize.z or 0.2, v.markerColour.r or 55, v.markerColour.g or 255, v.markerColour.b or 55, 100, false, true, 2, true, false, false, false)
                            if distance < 1.0 then
                                if v.use3dtext then
                                    DrawText3D(coords.x, coords.y, coords.z + 0.3, 0.35, v.msg or '[E]')
                                else
                                    ESX.ShowHelpNotification(v.msg or '~INPUT_CONTEXT~')
                                end
                                if IsControlJustPressed(0, 38) then
                                    OpenStash(k, v.job)
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('t11_newInventory:client:openStash')
AddEventHandler('t11_newInventory:client:openStash', function(name, job)
    OpenStash(name, job)
end)

OpenStash = function(name, job)
    if openableself then
        ESX.TriggerServerCallback('F3:Stash:CheckStatus', function(table)
            SendNUIMessage({
                action = "setInfoText",
                text = name
            })

            --if Config.UseWeight then
            --    local weight = 0
            --    local maxWeight = Config.Stashs[name].maxweight
            --    if table ~= nil then
            --        for i=1, #table, 1 do
            --            weight = weight + (table[i].weight * table[i].count)
            --        end
            --    end
    --
            --    SendNUIMessage({
            --        action = "setWeightSecondary",
            --        text = weight.. " / " ..maxWeight.. " kg"
            --    })
            --end
            SendNUIMessage({
                action = "setSecondInventoryItems",
                itemList = table
            })
            loadPlayerInventory()
            isInInventory = true
    
            SendNUIMessage({
                action = "display",
                type = "stash",
                text = GetPlayerName(PlayerId())..' - ID:'..GetPlayerServerId(PlayerId())
            })
            SetNuiFocus(true, true)
            secondary = name
        end, name)
    else
        ESX.ShowNotification("Eşyalarına şuan bir başkası bakıyor!")
    end
end

refreshStash = function(stashname)
    ESX.TriggerServerCallback('F3:Stash:CheckStatus', function(table)
        --if Config.UseWeight then
        --    local weight = 0
        --    local maxWeight = Config.Stashs[stashname].maxweight
        --    if table ~= nil then
        --        for i=1, #table, 1 do
        --            weight = weight + (table[i].weight * table[i].count)
        --        end
        --    end
--
        --    SendNUIMessage({
        --        action = "setWeightSecondary",
        --        text = weight.. " / " ..maxWeight.. " kg"
        --    })
        --end
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = table
        })
    end)
end

RegisterNUICallback("PutIntoStash",function(data, cb)
    if data.number == 0 then
        data.number = data.item.count
    end
    if not CombatMode then
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            ESX.TriggerServerCallback("F3:Stash:PutItem", function(result)
                if result ~= nil then
                    refreshStash(secondary)
                    --Wait(150)
                    loadPlayerInventory()
                    --Wait(150)
                    cb("ok")
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
                    if Config.ItemWeapons.Enabled then
                        if string.match(data.item.name, 'WEAPON_') then
                            RemoveWeapon(data.item.name)
                            currentWeapon = nil
                        end
                    end
                end
            end, data.item, count)
        end
    else
        ESX.ShowNotification("~r~Combat Mode~w~'dayken ~y~Güvenli Envanteri ~w~kullanamazsın!")
    end
end)

RegisterNUICallback("TakeFromStash",function(data, cb)
    if data.number == 0 then
        data.number = data.item.count
    end

    if not CombatMode then
        if not DupeDelay then
            DupeDelay = true
            if type(data.number) == "number" and math.floor(data.number) == data.number then

                if data.item.type == "item_weapon" then
                    count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
                end

                ESX.TriggerServerCallback("F3:Stash:RemoveItem", function(result)
                    if result ~= nil then
                        refreshStash(secondary)
                        Wait(150)
                        loadPlayerInventory()
                        Wait(150)
                        cb("ok")
                        Wait(250)
                        DupeDelay = false
                    else
                        DupeDelay = false
                    end
                end, data.item, data.number)             
            end
        else
            ESX.ShowNotification("Bu şekilde ~r~Spam ~w~Yapamazsın!")
            closeInventory()
        end
    else
        ESX.ShowNotification("~r~Combat Mode~w~'dayken ~y~Güvenli Envanteri ~w~kullanamazsın!")
    end
end)

-- notif
function SendNotify(msg, name, label, qty)
	local data = {}
    table.insert(data, {
        item = {
            label = label,
            itemId = name
        },
        qty = qty,
        message = Config.NotifTexts[msg]
    })
    SendNUIMessage({
        action = 'itemUsed',
        alerts = data
    })
end

RegisterNetEvent('esx:addInventoryItemxx')
AddEventHandler('esx:addInventoryItemxx', function(item, count)
    --print(item)
	for k,v in ipairs(ESX.PlayerData.inventory) do
        if item == "cash" then
        else
            SendNotify('add', item, item.label, count)
            break
        end
    end
end)

Citizen.CreateThread(function()
    if not Config.ItemWeapons.Enabled then
        local currentWeapon
        while true do
            if ESX ~= nil then
                local playerPed = PlayerPedId()
                if currentWeapon ~= GetSelectedPedWeapon(playerPed)then
                    currentWeapon = GetSelectedPedWeapon(playerPed)
                    local _, weapon = GetWeapon(currentWeapon)

                    if weapon ~= nil then

                        local item = {
                            name = weapon.name,
                            label = weapon.label
                        }

                        SendNotify('use', item.name, item.label, 1)
                    end
                end
            end
            Citizen.Wait(500)
        end
    end
end)

GetWeapon = function(weaponHash)
	local weapons = ESX.GetWeaponList()
	for i=1, #weapons, 1 do
		if GetHashKey(weapons[i].name) == weaponHash then
			return i, weapons[i]
		end
	end
end

--fast
RegisterNUICallback("PutIntoFast", function(data, cb)
    for i=1, #fastItems, 1 do
        if i ~= data.slot then
            if fastItems[i].name == data.item.name then
                fastItems[i] = nil
            end
        end
    end

    if data.item.slot ~= nil then
        fastItems[data.item.slot] = nil
    end
    fastItems[data.slot] = data.item
    fastItems[data.slot].slot = data.slot
    loadPlayerInventory()
    cb("ok")
end)
    
RegisterNUICallback("TakeFromFast", function(data, cb)
    fastItems[data.item.slot] = nil
    if Config.ItemWeapons.Enabled then
        if string.match(data.item.name, 'WEAPON_') then
            TriggerEvent('t11_newInventory:client:removeCurrentWeapon', data.item.name)
            currentWeapon = nil
        end
    else
        if currentFast == data.item.slot then
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
        end
    end
    if currentFast == data.item.slot then
        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
    end
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
    loadPlayerInventory()
    cb("ok")
end)

RegisterNetEvent('t11_newInventory:client:clearFast')
AddEventHandler('t11_newInventory:client:clearFast', function()
    for i = 1, 5, 1 do
        fastItems[i] = nil
    end
    RemoveAllPedWeapons(PlayerPedId(), true)
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while true do
        Citizen.Wait(0)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        BlockWeaponWheelThisFrame()
        DisableControlAction(0, 37,true)
        DisableControlAction(1, 37, true)
        DisableControlAction(2, 37, true)
		DisableControlAction(1, 157, true)
		DisableControlAction(1, 158, true)
		DisableControlAction(1, 160, true)
		DisableControlAction(1, 164, true)
		DisableControlAction(1, 165, true)
		DisableControlAction(2, 157, true)-- disable changing weapon
		DisableControlAction(2, 158, true)-- disable changing weapon
		DisableControlAction(2, 159, true)-- disable changing weapon
		DisableControlAction(2, 160, true)-- disable changing weapon
		DisableControlAction(2, 161, true)-- disable changing weapon
		DisableControlAction(2, 162, true)-- disable changing weapon
		DisableControlAction(2, 163, true)-- disable changing weapon
		DisableControlAction(2, 164, true)-- disable changing weapon
		DisableControlAction(2, 165, true)-- disable changing weapon
        
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsDisabledControlJustReleased(1, 19) then
            ToggleActionBar(true,fastItems)
            Citizen.Wait(1000)
            ToggleActionBar(false)
        end
    end
end)

local fastenabled = true
RegisterNetEvent('t11_newInventory:client:invUseable')
AddEventHandler('t11_newInventory:client:invUseable', function(variable)
    fastenabled = variable
end)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)
    end
    while true do
        if not IsPlayerDead(PlayerId()) then
            if IsDisabledControlJustReleased(1, 157) and not SlotDelay and not isInInventory and not IsEntityDead(GetPlayerPed(-1)) then
                if fastItems[1] ~= nil then
                    
                    if fastItems[1].name ~= nil then
                        TriggerServerEvent("esx:useItem", fastItems[1].name)
                        SlotDelay = true
                        if string.match(fastItems[1].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
                            SendNotify('elde', fastItems[1].name, fastItems[1].label, 1)
                        elseif string.match(fastItems[1].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('WEAPON_UNARMED') then
                            SendNotify('belde', fastItems[1].name, fastItems[1].label, 1)
                        else
                            SendNotify('use', fastItems[1].name, fastItems[1].label, 1)
                            Citizen.Wait(150)
                            if fastItems[1].count <= 1 then
                                fastItems[1] = nil
                            end
                        end
                    end
                    
                end
            
            elseif IsDisabledControlJustReleased(1, 158) and not SlotDelay and not isInInventory and not IsEntityDead(GetPlayerPed(-1)) then
                if fastItems[2] ~= nil then
                    
                    if fastItems[2].name ~= nil then
                        TriggerServerEvent("esx:useItem", fastItems[2].name)
                        SlotDelay = true
                        if string.match(fastItems[2].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
                            SendNotify('elde', fastItems[2].name, fastItems[2].label, 1)
                        elseif string.match(fastItems[2].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('WEAPON_UNARMED') then
                            SendNotify('belde', fastItems[2].name, fastItems[2].label, 1)
                        else
                            SendNotify('use', fastItems[2].name, fastItems[2].label, 1)
                            Citizen.Wait(150)
                            if fastItems[2].count <= 1 then
                                fastItems[2] = nil
                            end
                        end
                    end
                    
                end
            
            elseif IsDisabledControlJustReleased(1, 160) and not SlotDelay and not isInInventory and not IsEntityDead(GetPlayerPed(-1)) then
                if fastItems[3] ~= nil then
                    
                    if fastItems[3].name ~= nil then
                        TriggerServerEvent("esx:useItem", fastItems[3].name)
                        SlotDelay = true
                        if string.match(fastItems[3].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
                            SendNotify('elde', fastItems[3].name, fastItems[3].label, 1)
                        elseif string.match(fastItems[3].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('WEAPON_UNARMED') then
                            SendNotify('belde', fastItems[3].name, fastItems[3].label, 1)
                        else
                            SendNotify('use', fastItems[3].name, fastItems[3].label, 1)
                            Citizen.Wait(150)
                            if fastItems[3].count <= 1 then
                                fastItems[3] = nil
                            end
                        end
                    end
                   
                end
            
            elseif IsDisabledControlJustReleased(1, 164) and not SlotDelay and not isInInventory and not IsEntityDead(GetPlayerPed(-1)) then
                if fastItems[4] ~= nil then
                
                    
                    if fastItems[4].name ~= nil then
                        TriggerServerEvent("esx:useItem", fastItems[4].name)
                        SlotDelay = true
                        if string.match(fastItems[4].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
                            SendNotify('elde', fastItems[4].name, fastItems[4].label, 1)
                        elseif string.match(fastItems[4].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('WEAPON_UNARMED') then
                            SendNotify('belde', fastItems[4].name, fastItems[4].label, 1)
                        else
                            SendNotify('use', fastItems[4].name, fastItems[4].label, 1)
                            Citizen.Wait(150)
                            if fastItems[4].count <= 1 then
                                fastItems[4] = nil
                            end
                        end
                    end
                   
                end
            
            elseif IsDisabledControlJustReleased(1, 165) and not SlotDelay and not isInInventory and not IsEntityDead(GetPlayerPed(-1)) then
                if fastItems[5] ~= nil then
                    
                    if fastItems[5].name ~= nil then
                        TriggerServerEvent("esx:useItem", fastItems[5].name)
                        SlotDelay = true
                        if string.match(fastItems[5].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
                            SendNotify('elde', fastItems[5].name, fastItems[5].label, 1)
                        elseif string.match(fastItems[5].name, 'WEAPON_') and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('WEAPON_UNARMED') then
                            SendNotify('belde', fastItems[5].name, fastItems[5].label, 1)
                        else
                            SendNotify('use', fastItems[5].name, fastItems[5].label, 1)
                            Citizen.Wait(150)
                            if fastItems[5].count <= 1 then
                                fastItems[5] = nil
                            end
                        end
                    end
                    
                end
            end
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)


RegisterCommand('komut',function(source,args)
	TriggerServerEvent('F3:Stash:CheckStatus')
end)

--item weapons
local currentWeapon

RegisterNetEvent('t11_newInventory:client:useWeapon')
AddEventHandler('t11_newInventory:client:useWeapon', function(weapon)
    if currentWeapon ~= nil then
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(weapon) then
            RemoveWeapon(currentWeapon)
            currentWeapon = nil
        --     return
        else
            RemoveWeapon(currentWeapon)

            currentWeapon = weapon
            GiveWeapon(currentWeapon)
            ClearPedTasks(PlayerPedId())
        end
    else
        currentWeapon = weapon
        GiveWeapon(currentWeapon)
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent('t11_newInventory:client:removeCurrentWeapon')
AddEventHandler('t11_newInventory:client:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        ClearPedTasks(PlayerPedId())
    end
end)

function RemoveWeapon(weapon)
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
   -- local ammoCount = GetAmmoInPedWeapon(playerPed, hash)
   -- TriggerServerEvent('t11_newInventory:server:updateAmmoCount', hash, ammoCount)
    RemoveWeaponFromPed(playerPed, hash)
    SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
end

function GiveWeapon(weapon)
    local checkh = Config.ItemWeapons.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)

    --ESX.TriggerServerCallback('t11_newInventory:server:getAmmoCount', function(ammoCount)
        GiveWeaponToPed(playerPed, hash, 0, false, true)
        TriggerServerEvent('t11:wepSync')
    --    if checkh[weapon] == hash then
    --        SetPedAmmo(playerPed, hash, 1)
    --    elseif Config.ItemWeapons.FuelCan == hash or 'WEAPON_FIREEXTINGUISHER' == name then
    --        SetPedAmmo(playerPed, hash, 4500)
    --    elseif not ammoCount then
    --        SetPedAmmo(playerPed, hash, 1)
    --    elseif ammoCount < 0 then
    --        SetPedAmmo(playerPed, hash, 1)
    --    else
    --        SetPedAmmo(playerPed, hash, ammoCount)
    --    end
    --end, hash)
end

function ToggleActionBar(what,items)
    if what then
        SendNUIMessage({
            action = 'showActionBar',
            open = what,
            fastItems = items
        })
    elseif not what then
        SendNUIMessage({
            action = 'showActionBar',
            open = what,
        })
    end
end 