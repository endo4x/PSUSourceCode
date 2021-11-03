--[[
	id: dEBdjBtDaGaiuYe8oZqr-
	name: inv client
	description: inv c
	time1: 2021-05-13 17:03:49.951742+00
	time2: 2021-05-13 17:03:49.951742+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

ESX = nil
local InventoryOpen, isPlayerSpawned,LastStash = false, false, "protected"
local Slot = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {}
}

-- TODO: add export
userlevel = 20

function GetUserLevel()
    local level = exports["kaves_levelsistemi"]:level()
    return level
end

AddEventHandler('esx:onPlayerDeath', function(data)
    for k,v in pairs(Slot) do
        Slot[k] = {}
    end
    CloseInventory()
end)

local firstspawn = false
AddEventHandler("playerSpawned", function()
    if not firstspawn then
        firstspawn = true
        isPlayerSpawned = true
    end
end)

RegisterCommand("shopac", function()
TriggerEvent("a51z_newinv:OpenShop", "gundealer")
end)

RegisterNetEvent("a51z_newinv:OpenShop")
AddEventHandler(
    "a51z_newinv:OpenShop",
    function(shop)
        OpenNPC(shop)
    end
)

OpenNPC = function(shop)
    SendNUIMessage(
        {
            action = "npcshop",
            items = Config.Shops[shop],
            userlevel = GetUserLevel(),
            shop = shop,
            shopName = Config.ShopNames[shop]
        }
    )
    SetNuiFocus(true, true)
    InventoryOpen = true
end

--[[
RegisterCommand(
    "opennpc",
    function()
        OpenNPC("gundealer")
    end
) ]]--

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        ESX.PlayerData = ESX.GetPlayerData()

        TriggerServerEvent("a51z_newinv:Init")
    end
)

local HotbarKeys = {
    [157] = 1,
    [158] = 2,
    [160] = 3,
    [164] = 4,
    [165] = 5,
    [159] = 6
}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for k, v in pairs(HotbarKeys) do
                if IsDisabledControlJustReleased(1, k) then
                    if (Slot[v].name) then
                        UseItem(Slot[v].name)
                    end
                end
            end
        end
    end
)

RegisterNUICallback(
    "slottomain",
    function(data, cb)
        local Item = data.Item
        local ItemCount = data.count
        local ID = data.slot
        if (Slot[ID].count - ItemCount > 0) then
            Slot[ID].count = Slot[ID].count - ItemCount
        else
            Slot[ID] = {}
        end

        OpenInventory()
        cb("ok")
    end
)
RegisterNUICallback(
    "slotchange",
    function(data, cb)
        local ItemCount = data.count
        local ItemName = data.Item
        local ID = data.slot
        local LocalItem = GetInventoryItem(ItemName)
        if (data.slotSwitch) then
            local OriginSlot = data.slotSwitch
            if (Slot[ID].name == Slot[OriginSlot].name) then
                Slot[ID].count = Slot[ID].count + Slot[OriginSlot].count
                Slot[OriginSlot] = {}
            else
                local x = Slot[ID]
                local y = Slot[OriginSlot]
                Slot[ID] = y
                Slot[OriginSlot] = x
            end
        else
            if (Slot[ID].name) then
                if (Slot[ID].name == ItemName) then
                    if (LocalItem.count - ItemCount > 0) then
                        if (Slot[ID].count + ItemCount >= LocalItem.count) then
                            Slot[ID].count = LocalItem.count
                        else
                            Slot[ID].count = Slot[ID].count + ItemCount
                        end
                    else
                        Slot[ID].count = LocalItem.count
                    end
                else
                    Slot[ID] = {
                        name = LocalItem.name,
                        label = LocalItem.label,
                        count = ItemCount
                    }
                end
            else
                Slot[ID] = {
                    name = LocalItem.name,
                    label = LocalItem.label,
                    count = ItemCount
                }
            end
        end
        OpenInventory()
        cb("ok")
    end
)

RegisterNUICallback(
    "close",
    function(data, cb)
        CloseInventory()
        cb("ok")
    end
)

CloseInventory = function()
    InventoryOpen = false
    IsMarketOpen = false
    SendNUIMessage(
        {
            action = "close"
        }
    )
    SetNuiFocus(false, false)
end

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        UseItem(data.item)
        cb("ok")
    end
)
WeaponData = {
    hash = GetHashKey("WEAPON_UNARMED")
}

UseItem = function(item)
    local type = GetType(item)
    if (type == "normal") then
        TriggerServerEvent("esx:useItem", item)
        return
    end

    if (type == "weapon") then
        local ped = PlayerPedId()
        local weapon = GetHashKey(item)
        if (WeaponData.hash == weapon) then

            
            TriggerServerEvent('a51z_newinv:UpdateAmmo', weapon, GetAmmoInPedWeapon(ped, WeaponData.hash))
            RemoveWeaponFromPed(ped, WeaponData.hash)
            GiveWeaponToPed(ped, GetHashKey("WEAPON_UNARMED"), 0, false, true)
            WeaponData.hash = GetHashKey("WEAPON_UNARMED")


        else
            WeaponData.hash = GetHashKey(item)
            ESX.TriggerServerCallback(
                "a51z_newinv:RequestAmmo",
                function(ammo)
                    GiveWeaponToPed(ped, WeaponData.hash, 0, false, true)
                    local Components = RequestComponents()
                   -- print(json.encode(Components), WeaponData.hash)
                    if Components[WeaponData.hash] then
                        for k,v in pairs(Components[WeaponData.hash]) do 
                            GiveWeaponComponentToPed(PlayerPedId(), WeaponData.hash, Config.Components[WeaponData.hash][k].hash)
                        end
                    end
                    SetPedAmmo(ped, WeaponData.hash, ammo)

                    
                end,
                WeaponData.hash
            )
        end
        return
    end

    if (type == "money") then
        return
    end
end

GetType = function(item)
    local type
    if (string.match(item, "WEAPON_")) then
        type = "weapon"
    elseif (string.match(item, "money")) then
        type = "money"
    else
        type = "normal"
    end

    return type
end

OpenInventory = function(stashname, stashlabel)
    InventoryOpen = true
    IsMarketOpen = false
    SendNUIMessage(
        {
            action = "open",
            inventory = ESX.GetPlayerData().inventory,
            slot = Slot,
            stash = PrepareStash(stashname, stashlabel),
            money = GetMoney()
        }
    )
    SetNuiFocus(true, true)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            BlockWeaponWheelThisFrame()
            HideHudComponentThisFrame(19)
            HideHudComponentThisFrame(20)
            DisableControlAction(0, 37, true) --Disable Tab

            if IsDisabledControlJustPressed(1, 37) then
                OpenInventory()
            end
        end
    end
)
RegisterNetEvent("esx:addInventoryItem")
AddEventHandler(
    "esx:addInventoryItem",
    function(...)
        Sleep(200)
        UpdateInventory()
    end
)

RegisterNetEvent("esx:removeInventoryItem")
AddEventHandler(
    "esx:removeInventoryItem",
    function(item, count)
        for k, v in pairs(Slot) do
            if v.name and v.name == item then
                if v.count - 1 > 0 then
                    Slot[k].count = Slot[k].count - 1
                else
                    Slot[k] = {}
                end
            end
        end
        if string.match(item, 'WEAPON_') then
            if WeaponData.hash == GetHashKey(item) then
               -- print('silah elinde')
                if 0 >= count then
                    --print('envanterde kalmamış amm')
                    local ped = PlayerPedId()
                    TriggerServerEvent('a51z_newinv:UpdateAmmo', weapon, GetAmmoInPedWeapon(ped, WeaponData.hash))
                    RemoveWeaponFromPed(ped, WeaponData.hash)
                    GiveWeaponToPed(ped, GetHashKey("WEAPON_UNARMED"), 0, false, true)
                    WeaponData.hash = GetHashKey("WEAPON_UNARMED")
                end
            end
        end
        Sleep(100)
        UpdateInventory()
    end
)

RegisterNUICallback(
    "requestInventory",
    function(data, cb)
        if isPlayerSpawned then
            Citizen.Wait(100)
            IsMarketOpen = false
            cb(
                {
                    inventory = ESX.GetPlayerData().inventory,
                    slot = Slot,
                    stash = PrepareStash(),
                    money = GetMoney()
                }
            )
        end
    end
)

function Sleep(ms)
    local p = promise.new()
    Citizen.Wait(ms)
    p:resolve()
    return Citizen.Await(p)
end

GetMoney = function()
    local accs = ESX.GetPlayerData().accounts
    for i=1,#accs,1 do
        if accs[i].name == "money" then
            return accs[i].money
        end
    end
    return 0
end

UpdateInventory = function()
    if InventoryOpen and not IsMarketOpen then
        local stash
        if UsingCustomStash then
            stash = PrepareStash(LastStash)
        else
            stash = PrepareStash()
        end
        SendNUIMessage(
            {
                action = "updateInventory",
                inventory = ESX.GetPlayerData().inventory,
                slot = Slot,
                stash = stash,
                money = GetMoney()
            }
        )
    end
end

RegisterNUICallback('GetNearPlayers', function(data, cb)
    cb({
        players = GetNearbyPlayers()
    })
end)

GetNearbyPlayers = function()
    local p = promise:new()

    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
    local ids = {}
    for i=1, #players,1 do
        ids[#ids + 1] = GetPlayerServerId(players[i])
    end
    ESX.TriggerServerCallback('a51z_newinv:GetPlayersAround', function(data)
       -- print(json.encode(data))
        p:resolve(data)
    end, ids)
    return Citizen.Await(p)
end


PrepareStash = function(stashname, stashlabel)
    local stash = {}
    if not stashname then
        LastStash = "protected"
        stash = {
            label = Config.Stash["protected"].label,
            items = GetStash("protected"),
            name = "protected",
            maxWeight = Config.Stash["protected"].maxWeight
        }
    else
        LastStash = stashname
        stash = {
            label = Config.Stash[stashname].label,
            items = GetStash(stashname),
            name = stashname,
            maxWeight = Config.Stash[stashname].maxWeight
        }
    end
    return stash
end

UsingCustomStash = function()
    return LastStash == "protected"
end

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if account.name == "money" then
        if InventoryOpen and LastStash ~= "protected" then
            UpdateInventory()
        end
    end
end)

RegisterNUICallback('GiveItem', function(data, cb)
    ESX.TriggerServerCallback('a51z_newinv:GiveItemToPlayer', function(data) cb(data) end, data.target, data.item, data.count)
end)

RegisterNetEvent('a51z_newinv:UsedAmmo')
AddEventHandler('a51z_newinv:UsedAmmo', function(ammo)
    UsedAmmo(ammo)
end)

UsedAmmo = function(ammo)
    local ped = PlayerPedId()
    local PlayerWeapon = GetSelectedPedWeapon(ped)
    if(PlayerWeapon == GetHashKey('WEAPON_UNARMED')) then return end

    local pass = IncludesAmmo(PlayerWeapon, ammo)
    if not pass then return end

    local MaxAmmo = Config.Ammo[ammo].maxClipAmmo
    local UserAmmo = GetAmmoInPedWeapon(ped, PlayerWeapon)
    if (UserAmmo + Config.Ammo[ammo].count >= MaxAmmo) then return end 

    ESX.TriggerServerCallback('a51z_newinv:server:UsedAmmo', function(count)
        SetPedAmmo(ped, PlayerWeapon, count)
        TaskReloadWeapon(ped)
    end, PlayerWeapon, ammo)
end


IncludesAmmo = function(weapon, ammo)
    local AmmoData = Config.Ammo[ammo].allowed
    for i=1, #AmmoData,1 do
        if GetHashKey(AmmoData[i]) == weapon then
            return true
        end 
    end
    return false
end

local UserComponents = {}
local components = {
    ["components_clip"] = "clip",
    ["components_grip"] = "grip",
    ["components_scope"] = "scope",
    ["components_suppressor"] = "suppressor",
    ["components_flashlight"] = "flashlight",
	["components_skin"] = "skin",
}


RegisterNetEvent('a51z_newinv:SetupComponents')
AddEventHandler('a51z_newinv:SetupComponents', function(data)
    UserComponents = data
end)

RequestComponents = function()
    return UserComponents
end

RegisterCommand('eklenticikar', function(source, args)
    local ped = PlayerPedId()
    local PlayerWeapon = GetSelectedPedWeapon(ped)
    if(PlayerWeapon == GetHashKey('WEAPON_UNARMED')) then return end
    component = components[component]
    local WeaponComponents = Config.Components[PlayerWeapon]
    ESX.TriggerServerCallback('a51z_newinv:RemoveComponent', function(data)
        if data then
            RemoveWeaponFromPed(ped, PlayerWeapon)
            UserComponents[PlayerWeapon] = {}
            WeaponData.hash = GetHashKey('WEAPON_UNARMED')
        end
    end, PlayerWeapon)
end)

RegisterNetEvent('a51z_newinv:UsedComponent')
AddEventHandler('a51z_newinv:UsedComponent', function(component)
    local ped = PlayerPedId()
    local PlayerWeapon = GetSelectedPedWeapon(ped)
    if(PlayerWeapon == GetHashKey('WEAPON_UNARMED')) then return end
    component = components[component]
    local WeaponComponents = Config.Components[PlayerWeapon]
    if not (WeaponComponents[component]) then return end
    if(HasPedGotWeaponComponent(ped, PlayerWeapon, WeaponComponents[component].hash)) then
        return
    end
    ESX.TriggerServerCallback('a51z_newinv:server:UsedComponent', function(done)
        if done then
            if not UserComponents[PlayerWeapon] then
                UserComponents[PlayerWeapon] = {}
            end
            UserComponents[PlayerWeapon][component] = 1
            GiveWeaponComponentToPed(PlayerPedId(), PlayerWeapon, WeaponComponents[component].hash)
        else
            UserComponents[PlayerWeapon][component] = nil
        end
    end, PlayerWeapon, component)
end)

IsMarketOpen = false
RegisterNUICallback('PutItemToSale', function(data, cb)
    ESX.TriggerServerCallback('a51z_newinv:AddMarketItemCB', function(data)
        cb(data)
    end,
    data.item, 
    tonumber(data.priceperunit), 
    tonumber(data.count))
end)

RegisterNetEvent('a51z_newinv:GlobalMarketUpdate')
AddEventHandler('a51z_newinv:GlobalMarketUpdate', function()
    if IsMarketOpen then
        SendNUIMessage({
            action = "marketupdate",
            marketdata = GetMarketItems(),
        })
    end
end)
RegisterNUICallback('RequestMarketUpdate', function(data, cb)
    SendNUIMessage({
        action = "marketupdate",
        marketdata = GetMarketItems(),
    })
    cb('ok')
end)

RegisterNUICallback('GetMarketItem', function(data, cb)
    cb({
        ItemData = GetMarketItem(data.item),
        LocalID = ESX.GetPlayerData().identifier
    }) 
end)

RegisterNUICallback('RemoveItemFromSale', function(data, cb)
    ESX.TriggerServerCallback('a51z_newinv:RemoveMarketItemCB', function(data) 
        cb(data)
    end, data.item)
end)

RegisterNUICallback('BuyItem', function(data, cb)
    ESX.TriggerServerCallback('a51z_newinv:BuyMarketItemCB', function(data)
        cb(data)
    end, data.item, data.seller, data.count)
end)

RegisterNetEvent('a51z_newinv:LocalMarketUpdate')
AddEventHandler('a51z_newinv:LocalMarketUpdate', function()
    if IsMarketOpen then
        SendNUIMessage({
            action = "marketupdate",
            marketdata = GetMarketItems(),
            userdata = GetMyItemsOnSale()
        })
    end
end)

RegisterNUICallback('GetMarketData', function(data, cb)
    cb({
        action = "marketupdate",
        marketdata = GetMarketItems(),
        userdata = GetMyItemsOnSale()
    })
end)

RegisterNUICallback('SetMarketOpen', function(data, cb)
    IsMarketOpen = true; cb('ok')
end)

RegisterNUICallback('GetMyItemsOnSale', function(data, cb)
    cb({
        userdata = GetMyItemsOnSale()
    })
end)

RegisterNUICallback('npcMarketBuy', function(data, cb)
    if(tonumber(data.level) > GetUserLevel()) then
        return cb({
            success = false,
            text = "Bunu yapmak için seviyen yetmiyor",
            type = "error"
        })
    end
    ESX.TriggerServerCallback('a51z_newinv:BuyNPCItem', function(data)
        cb(data)
    end, data.item, tonumber(data.count), data.shop)
end)

Stashes = {}
RegisterNetEvent('a51z_newinv:SyncStash')
AddEventHandler('a51z_newinv:SyncStash', function(data)
    Stashes = data
end)

RegisterNetEvent('a51z_newinv:UpdateStash')
AddEventHandler('a51z_newinv:UpdateStash', function(stash, item, data)
    if(not Stashes[stash]) then
        Stashes[stash] = {}
    end
    if(not Stashes[stash][item]) then
        Stashes[stash][item] = {}
    end
    Stashes[stash][item] = data
    UpdateInventory()
end)

RegisterCommand("openstash", function()
    OpenInventory("depo")
end)

RegisterNUICallback('MoveToSecondInventory', function(data, cb)
   -- local CombatMode = exports['a51z_core']:CombatMode()
  --  if not CombatMode then
        local Item = data.item
        local stash = data.stash
        local count = data.count
        TriggerServerEvent('a51z_newinv:addItemToStash', stash, Item, count)
        UpdateInventory()
        cb('ok')
   -- else
     --   ESX.ShowNotification("Combat mode!")
   -- end
end)

RegisterNUICallback('MoveToMain', function(data, cb)
    local Item = data.item
    local stash = data.stash
    local count = data.count
    TriggerServerEvent('a51z_newinv:removeItemFromStash', stash, Item, count)
    UpdateInventory()
    cb('ok')
end)

GetStash = function(stash)
    local p = promise.new() 
    if(Stashes[stash]) then
        p:resolve(Stashes[stash])
    else
        ESX.TriggerServerCallback('a51z_newinv:GetStash', function(data)
            p:resolve(data)
        end, stash)
    end
    return Citizen.Await(p)
end

GetInventoryItem = function(Item)
    for _,v in pairs(ESX.GetPlayerData().inventory) do
        if v.name == Item then
            return v
        end
    end
end

GetMarketItems = function()
    local p = promise.new()
    ESX.TriggerServerCallback('a51z_newinv:GetMarketItems', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

GetMarketItem = function(item)
    local p = promise.new()
    ESX.TriggerServerCallback('a51z_newinv:GetMarketItem', function(data)
        p:resolve(data)
    end, item)
    return Citizen.Await(p)
end

GetMyItemsOnSale = function()
    local p = promise.new()
    ESX.TriggerServerCallback('a51z_newinv:GetMyItemsOnSale', function(data)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end