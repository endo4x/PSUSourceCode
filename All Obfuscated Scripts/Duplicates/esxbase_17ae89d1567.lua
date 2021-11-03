--[[
	id: aCxXNXbgLg_xubK3tInLO
	name: esx base
	description: esx base server
	time1: 2021-05-08 20:52:57.632776+00
	time2: 2021-05-08 20:52:57.632777+00
	uploader: Gdlq7NyYKvrvg0YCtr7YXY9IewXCotTZr15Em4O-
	uploadersession: DrSLcEihmrvTMjXxyHKWqR-mkuZWbo
	flag: f
--]]

--[[
ICEMALLOWS SHOP
]]
AIRES = {}
AIRES.Commands = {}
AIRES.Commands.List = {}
AIRES.Functions = {}
AIRES.Config = AIRESConfig
AIRES.Shared = AIRESShared
AIRES.UseableItems = {}
AIRES.Players = {}
AIRES.Player = {}
AIRES.ServerCallbacks = {}

ESX = nil
TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

function getAIRES()
    return AIRES
end

RegisterNetEvent("AIRES-base:getSharedObject")
AddEventHandler(
    "AIRES-base:getSharedObject",
    function(cb)
        cb(getAIRES())
    end
)

local label =
    [[
^3//
^3||	  ^1___ ____ _____ __  __    _    _     _     _____        __
^3||	 ^1|_ _/ ___| ____|  \/  |  / \  | |   | |   / _ \ \      / /
^3||	 ^1 | | |   |  _| | |\/| | / _ \ | |   | |  | | | \ \ /\ / / 
^3||	 ^1 | | |___| |___| |  | |/ ___ \| |___| |__| |_| |\ V  V /  
^3||	 ^1|___\____|_____|_|  |_/_/   \_\_____|_____\___/  \_/\_/   
^3||
^3\\			^2 License verified. Have a good day!
]]

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end

        if
            AIRESConfig.License == "" or AIRESConfig.License == "" and AIRESConfig.ApiKey == "" or
                AIRESConfig.ApiKey == ""
         then
            io.popen("msg %username% Please put your License Key and API Key to config.lua")
            os.exit()
        else
            PerformHttpRequest(
                "http://panel.icemallows.shop/api/v1",
                function(errorCode, resultData, headers)
                    local data = json.decode(resultData)
                    print(data)
                    if data.status == "success" then
                        print(label)
                    else
                        io.popen(
                            "msg %username% License could not be verified. Please buy it from https://icemallows.shop or contact us on Discord: https://discord.gg/9ua6Fx46ZB"
                        )
                        os.exit()
                    end
                end,
                "POST",
                json.encode(
                    {license = AIRESConfig.License, version = "1.0.0", plugin = "ESX V1 Base", hwid = "Atakan 31 sj"}
                ),
                {["Content-Type"] = "application/json", ["Authorization"] = AIRESConfig.APIKey}
            )
        end
    end
)

AIRES.Commands.Add = function(name, help, arguments, argsrequired, callback, permission) -- [name] = command name (ex. /givemoney), [help] = help text, [arguments] = arguments that need to be passed (ex. {{name="id", help="ID of a player"}, {name="amount", help="amount of money"}}), [argsrequired] = set arguments required (true or false), [callback] = function(source, args) callback, [permission] = rank or job of a player
    AIRES.Commands.List[name:lower()] = {
        name = name:lower(),
        permission = permission ~= nil and permission:lower() or "user",
        help = help,
        arguments = arguments,
        argsrequired = argsrequired,
        callback = callback
    }
end

AIRES.Commands.Refresh = function(source)
    local Player = AIRES.GetPlayerFromId(tonumber(source))
    if Player ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(source))
        for command, info in pairs(AIRES.Commands.List) do
            if
                AIRES.Functions.HasPermission(source, "admin") or
                    AIRES.Functions.HasPermission(source, AIRES.Commands.List[command].permission)
             then
                TriggerClientEvent("chat:addSuggestion", source, "/" .. command, info.help, info.arguments)
            end
        end
    end
end

AIRES.Functions.CreateCallback = function(name, cb)
    AIRES.ServerCallbacks[name] = cb
end

AIRES.Functions.TriggerCallback = function(name, source, cb, ...)
    if AIRES.ServerCallbacks[name] ~= nil then
        AIRES.ServerCallbacks[name](source, cb, ...)
    end
end

RegisterServerEvent("AIRES:Server:TriggerCallback")
AddEventHandler(
    "AIRES:Server:TriggerCallback",
    function(name, ...)
        local src = source
        AIRES.Functions.TriggerCallback(
            name,
            src,
            function(...)
                TriggerClientEvent("AIRES:Client:TriggerCallback", src, name, ...)
            end,
            ...
        )
    end
)

AIRES.Functions.HasPermission = function(source, permission)
    local retval = false
    local xPlayer = ESX.GetPlayerFromId(tonumber(source))
    local steamid = GetPlayerIdentifiers(source)[1]
    local licenseid = GetPlayerIdentifiers(source)[2]
    local permission = tostring(permission:lower())
    if permission == "user" then
        retval = true
    else
        if
            tostring(xPlayer.getGroup():lower()) == permission or tostring(xPlayer.getGroup():lower()) == "superadmin" or
                tostring(xPlayer.getGroup():lower()) == "admin"
         then
            retval = true
        end
    end
    return retval
end

AIRES.ExecuteSql = function(wait, query, cb)
    local rtndata = {}
    local waiting = true
    MySQL.Async.execute(
        query,
        {},
        function(data)
            if cb ~= nil and wait == false then
                cb(data)
            end
            rtndata = data
            waiting = false
        end
    )
    if wait then
        while waiting do
            Citizen.Wait(5)
        end
        if cb ~= nil and wait == true then
            cb(rtndata)
        end
    end
    return rtndata
end

AIRES.FetchSql = function(wait, query, cb)
    local rtndata = {}
    local waiting = true
    MySQL.Async.fetchAll(
        query,
        {},
        function(data)
            if cb ~= nil and wait == false then
                cb(data)
            end
            rtndata = data
            waiting = false
        end
    )
    if wait then
        while waiting do
            Citizen.Wait(5)
        end
        if cb ~= nil and wait == true then
            cb(rtndata)
        end
    end
    return rtndata
end

AIRES.RegisterUsableItem = function(item, cb)
    AIRES.UseableItems[item] = cb
end

AIRES.canCarryItem = function(item)
    return AIRES.UseableItems[item] ~= nil
end

AIRES.useItem = function(source, item)
    AIRES.UseableItems[item.name](source, item)
end

AIRES.getSource = function(identifier)
    for src, player in pairs(AIRES.Players) do
        local idens = GetPlayerIdentifiers(src)
        for _, id in pairs(idens) do
            if identifier == id then
                return src
            end
        end
    end
    return 0
end

AIRES.GetPlayerFromId = function(source)
    if type(source) == "number" then
        --print(AIRES.Players[source])
        return AIRES.Players[source]
    else
        --print(AIRES.Players[AIRES.getSource(source)])
        return AIRES.Players[AIRES.getSource(source)]
    end
end

AIRES.Functions.GetPlayer = function(source)
    if type(source) == "number" then
        --print(AIRES.Players[source])
        return AIRES.Players[source]
    else
        --print(AIRES.Players[AIRES.getSource(source)])
        return AIRES.Players[AIRES.getSource(source)]
    end
end

AIRES.GetPlayerFromPhone = function(number)
    for src, player in pairs(AIRES.Players) do
        -- local cid = citizenid
        if AIRES.Players[src].PlayerData.charinfo.phone == number then
            return AIRES.Players[src]
        end
    end
    return nil
end

AIRES.GetPlayerFromCitizenId = function(citizenid)
    for src, player in pairs(AIRES.Players) do
        local cid = citizenid
        if AIRES.Players[src].PlayerData.citizenid == cid then
            return AIRES.Players[src]
        end
    end
    return nil
end

AIRES.GetPlayerFromIds = function()
    return AIRES.Players
end

AIRES.getIdentifier = function(source, idtype)
    local idtype = idtype ~= nil and idtype or AIRESConfig.IdentifierType
    for _, identifier in pairs(GetPlayerIdentifiers(source)) do
        if string.find(identifier, idtype) then
            return identifier
        end
    end
    return nil
end

-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(
    "Test",
    function(source)
        local src = source
        local xPlayer = GetPlayerIdentifiers(source)
        local steamID
        for k, v in pairs(xPlayer) do
            if string.match(v, "steam:") then
                steamID = v
            end
        end
        MySQL.Async.fetchAll(
            "SELECT metadata FROM `users` WHERE `identifier` = @identifier",
            {
                ["@identifier"] = steamID
            },
            function(result)
                if result[1].metadata == "" then
                    print("Enai moxa v1")
                    if AIRES.Login(src, false, data) then
                    end
                else
                    print("Enai moxa v2")
                    if AIRES.Login(src, steamID) then
                    end
                end
            end
        )
    end
)

-- /do Moxhanın enayi olduğu her yerden görülebilir

AddEventHandler(
    "esx:playerLoaded",
    function(id, xPlayer)
        MySQL.Async.fetchAll(
            "SELECT metadata FROM `users` WHERE `identifier` = @identifier",
            {
                ["@identifier"] = xPlayer.identifier
            },
            function(result)
                if result[1].metadata == "" then
                    if AIRES.Login(xPlayer.source, false, data) then
                    end
                else
                    if AIRES.Login(xPlayer.source, xPlayer.identifier) then
                    end
                end
            end
        )
    end
)

-- RegisterNetEvent('AIRES-base:createPlayer')
-- AddEventHandler('AIRES-base:createPlayer', function(playerId, xPlayer)
-- 	MySQL.Async.fetchAll('SELECT metadata FROM `users` WHERE `identifier` = @identifier', {
-- 		['@identifier'] = xPlayer.identifier
-- 	}, function(result)
-- 		if result[1].metadata == "" then
-- 			if AIRES.Login(xPlayer.source,false,data) then end
-- 		else
-- 			if AIRES.Login(xPlayer.source, xPlayer.identifier) then  end
-- 		end
-- 	end)
-- end)

AIRES.Login = function(source, citizenid, newData)
    local xPlayer = ESX.GetPlayerFromId(source)
    if source ~= nil then
        if citizenid then
            AIRES.FetchSql(
                true,
                "SELECT * FROM `users` WHERE `identifier` = '" .. citizenid .. "'",
                function(result)
                    local PlayerData = result[1]
                    if PlayerData ~= nil then
                        PlayerData.metadata = json.decode(PlayerData.metadata)
                    end
                    PlayerData.job = xPlayer.job
                    PlayerData.job.onduty = true
                    -- TriggerEvent('kashactersload', citizenid)
                    AIRES.checkPlayerData(source, PlayerData)
                end
            )
        else
            AIRES.checkPlayerData(source, newData)
        end
        return true
    else
        return false
    end
end

AIRES.checkPlayerData = function(source, PlayerData)
    --print("1")
    PlayerData = PlayerData ~= nil and PlayerData or {}
    --print("2")
    PlayerData.source = source
    --print("3")
    PlayerData.citizenid = PlayerData.steam ~= nil and PlayerData.steam or AIRES.getIdentifier(source, "steam")
    --print("4")
    PlayerData.steam = PlayerData.steam ~= nil and PlayerData.steam or AIRES.getIdentifier(source, "steam")
    --print("5")
    PlayerData.license = PlayerData.license ~= nil and PlayerData.license or AIRES.getIdentifier(source, "license")
    --print("6")
    PlayerData.name = GetPlayerName(source)

    PlayerData.job = PlayerData.job
    --print("7")
    PlayerData.cid = PlayerData.cid ~= nil and PlayerData.cid or 1
    --print("8")
    PlayerData.metadata = PlayerData.metadata ~= nil and PlayerData.metadata or {}
    --print("9")
    PlayerData.metadata["dealerrep"] = PlayerData.metadata["dealerrep"] ~= nil and PlayerData.metadata["dealerrep"] or 0
    --print("10")
    PlayerData.metadata["craftingrep"] =
        PlayerData.metadata["craftingrep"] ~= nil and PlayerData.metadata["craftingrep"] or 0
    --print("11")
    PlayerData.metadata["attachmentcraftingrep"] =
        PlayerData.metadata["attachmentcraftingrep"] ~= nil and PlayerData.metadata["attachmentcraftingrep"] or 0

    PlayerData.metadata["ishandcuffed"] =
        PlayerData.metadata["ishandcuffed"] ~= nil and PlayerData.metadata["ishandcuffed"] or false

    PlayerData.metadata["tracker"] = PlayerData.metadata["tracker"] ~= nil and PlayerData.metadata["tracker"] or false
    --print("12")
    PlayerData.LoggedIn = true
    --print("13")
    PlayerData = AIRES.LoadInventory(PlayerData)
    --print("14")
    AIRES.CreatePlayer(PlayerData)
    --TriggerClientEvent('kashactersload', source, PlayerData.citizenid)
end

AIRES.CreatePlayer = function(PlayerData)
    local self = {}
    self.Functions = {}
    --print("10")
    self.PlayerData = PlayerData
    --print("11")
    self.UpdatePlayerData = function()
        TriggerClientEvent("AIRES-base:setPlayerData", self.PlayerData.source, self.PlayerData)
    end
    --print("12")
    self.SetMetaData = function(meta, val)
        local meta = meta:lower()
        if val ~= nil then
            self.PlayerData.metadata[meta] = val
            self.UpdatePlayerData()
        end
    end
    --print("13")
    self.addItem = function(item, amount, slot, info)
        local totalWeight = AIRES.GetTotalWeight(self.PlayerData.items)
        local itemInfo = AIRES.Shared.Items[item:lower()]
        if itemInfo == nil then
            TriggerClientEvent("chatMessage", -1, "SYSTEM", "warning", "No item found??")
            return
        end
        local amount = tonumber(amount)
        local slot = tonumber(slot) ~= nil and tonumber(slot) or AIRES.GetFirstSlotByItem(self.PlayerData.items, item)
        if itemInfo["type"] == "weapon" and info == nil then
            info = {
                serie = tostring(
                    AIRES.Shared.RandomInt(2) ..
                        AIRES.Shared.RandomStr(3) ..
                            AIRES.Shared.RandomInt(1) ..
                                AIRES.Shared.RandomStr(2) .. AIRES.Shared.RandomInt(3) .. AIRES.Shared.RandomStr(4)
                )
            }
        end
        if (totalWeight + (itemInfo["weight"] * amount)) <= AIRES.Config.Player.MaxWeight then
            if
                (slot ~= nil and self.PlayerData.items[slot] ~= nil) and
                    (self.PlayerData.items[slot].name:lower() == item:lower()) and
                    (itemInfo["type"] == "item" and not itemInfo["unique"])
             then
                self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount + amount
                self.UpdatePlayerData()
                return true
            elseif (not itemInfo["unique"] and slot or slot ~= nil and self.PlayerData.items[slot] == nil) then
                self.PlayerData.items[slot] = {
                    name = itemInfo["name"],
                    amount = amount,
                    info = info ~= nil and info or "",
                    label = itemInfo["label"],
                    description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                    weight = itemInfo["weight"],
                    type = itemInfo["type"],
                    unique = itemInfo["unique"],
                    useable = itemInfo["useable"],
                    image = itemInfo["image"],
                    shouldClose = itemInfo["shouldClose"],
                    slot = slot,
                    combinable = itemInfo["combinable"]
                }
                self.UpdatePlayerData()
                return true
            elseif (itemInfo["unique"]) or (not slot or slot == nil) or (itemInfo["type"] == "weapon") then
                for i = 1, AIRES.Config.Player.MaxInvSlots, 1 do
                    if self.PlayerData.items[i] == nil then
                        self.PlayerData.items[i] = {
                            name = itemInfo["name"],
                            amount = amount,
                            info = info ~= nil and info or "",
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            shouldClose = itemInfo["shouldClose"],
                            slot = i,
                            combinable = itemInfo["combinable"]
                        }
                        self.UpdatePlayerData()
                        return true
                    end
                end
            end
        end
        return false
    end
    --print("14")

    self.Functions.RemoveMoney = function(account, count, reason)
        local xPlayer = ESX.GetPlayerFromId(self.PlayerData.source)
        if account ~= "cash" then
            local paradurumu = xPlayer.getAccount(account).money - count
            xPlayer.setAccountMoney(account, paradurumu)
        else
            xPlayer.addMoney(count)
        end
    end

    self.removeItem = function(item, amount, slot)
        local itemInfo = AIRES.Shared.Items[item:lower()]
        local amount = tonumber(amount)
        local slot = tonumber(slot)
        if slot ~= nil then
            if self.PlayerData.items[slot].amount > amount then
                self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amount
                self.UpdatePlayerData()
                return true
            else
                self.PlayerData.items[slot] = nil
                self.UpdatePlayerData()
                return true
            end
        else
            local slots = AIRES.GetSlotsByItem(self.PlayerData.items, item)
            local amountToRemove = amount
            if slots ~= nil then
                for _, slot in pairs(slots) do
                    if self.PlayerData.items[slot].amount > amountToRemove then
                        self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amountToRemove
                        self.UpdatePlayerData()
                        return true
                    elseif self.PlayerData.items[slot].amount == amountToRemove then
                        self.PlayerData.items[slot] = nil
                        self.UpdatePlayerData()
                        return true
                    end
                end
            end
        end
        return false
    end

    self.Functions.AddItem = function(item, amount, slot, info)
        local totalWeight = AIRES.GetTotalWeight(self.PlayerData.items)
        local itemInfo = AIRES.Shared.Items[item:lower()]
        if itemInfo == nil then
            TriggerClientEvent("chatMessage", -1, "SYSTEM", "warning", "No item found??")
            return
        end
        local amount = tonumber(amount)
        local slot = tonumber(slot) ~= nil and tonumber(slot) or AIRES.GetFirstSlotByItem(self.PlayerData.items, item)
        if itemInfo["type"] == "weapon" and info == nil then
            info = {
                serie = tostring(
                    AIRES.Shared.RandomInt(2) ..
                        AIRES.Shared.RandomStr(3) ..
                            AIRES.Shared.RandomInt(1) ..
                                AIRES.Shared.RandomStr(2) .. AIRES.Shared.RandomInt(3) .. AIRES.Shared.RandomStr(4)
                )
            }
        end
        if (totalWeight + (itemInfo["weight"] * amount)) <= AIRES.Config.Player.MaxWeight then
            if
                (slot ~= nil and self.PlayerData.items[slot] ~= nil) and
                    (self.PlayerData.items[slot].name:lower() == item:lower()) and
                    (itemInfo["type"] == "item" and not itemInfo["unique"])
             then
                self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount + amount
                self.UpdatePlayerData()
                return true
            elseif (not itemInfo["unique"] and slot or slot ~= nil and self.PlayerData.items[slot] == nil) then
                self.PlayerData.items[slot] = {
                    name = itemInfo["name"],
                    amount = amount,
                    info = info ~= nil and info or "",
                    label = itemInfo["label"],
                    description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                    weight = itemInfo["weight"],
                    type = itemInfo["type"],
                    unique = itemInfo["unique"],
                    useable = itemInfo["useable"],
                    image = itemInfo["image"],
                    shouldClose = itemInfo["shouldClose"],
                    slot = slot,
                    combinable = itemInfo["combinable"]
                }
                self.UpdatePlayerData()
                return true
            elseif (itemInfo["unique"]) or (not slot or slot == nil) or (itemInfo["type"] == "weapon") then
                for i = 1, AIRES.Config.Player.MaxInvSlots, 1 do
                    if self.PlayerData.items[i] == nil then
                        self.PlayerData.items[i] = {
                            name = itemInfo["name"],
                            amount = amount,
                            info = info ~= nil and info or "",
                            label = itemInfo["label"],
                            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                            weight = itemInfo["weight"],
                            type = itemInfo["type"],
                            unique = itemInfo["unique"],
                            useable = itemInfo["useable"],
                            image = itemInfo["image"],
                            shouldClose = itemInfo["shouldClose"],
                            slot = i,
                            combinable = itemInfo["combinable"]
                        }
                        self.UpdatePlayerData()
                        return true
                    end
                end
            end
        end
        return false
    end
    --print("14")

    self.Functions.RemoveItem = function(item, amount, slot)
        local itemInfo = AIRES.Shared.Items[item:lower()]
        local amount = tonumber(amount)
        local slot = tonumber(slot)
        if slot ~= nil then
            if self.PlayerData.items[slot].amount > amount then
                self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amount
                self.UpdatePlayerData()
                return true
            else
                self.PlayerData.items[slot] = nil
                self.UpdatePlayerData()
                return true
            end
        else
            local slots = AIRES.GetSlotsByItem(self.PlayerData.items, item)
            local amountToRemove = amount
            if slots ~= nil then
                for _, slot in pairs(slots) do
                    if self.PlayerData.items[slot].amount > amountToRemove then
                        self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amountToRemove
                        self.UpdatePlayerData()
                        return true
                    elseif self.PlayerData.items[slot].amount == amountToRemove then
                        self.PlayerData.items[slot] = nil
                        self.UpdatePlayerData()
                        return true
                    end
                end
            end
        end
        return false
    end

    self.Functions.SetMetaData = function(meta, val)
        local meta = meta:lower()
        if val ~= nil then
            self.PlayerData.metadata[meta] = val
            self.UpdatePlayerData()
        end
    end
    --print("15")

    self.SetInventory = function(items)
        self.PlayerData.items = items
        self.UpdatePlayerData()
    end
    --print("16")

    self.ClearInventory = function()
        self.PlayerData.items = {}
        self.UpdatePlayerData()
    end
    --print("16")

    self.GetItemByName = function(item)
        local item = tostring(item):lower()
        local slot = AIRES.GetFirstSlotByItem(self.PlayerData.items, item)
        if slot ~= nil then
            return self.PlayerData.items[slot]
        end
        return nil
    end

    self.Functions.GetItemByName = function(item)
        local item = tostring(item):lower()
        local slot = AIRES.GetFirstSlotByItem(self.PlayerData.items, item)
        if slot ~= nil then
            return self.PlayerData.items[slot]
        end
        return nil
    end
    --print("17")

    self.Functions.GetItemBySlot = function(slot)
        local slot = tonumber(slot)
        if self.PlayerData.items[slot] ~= nil then
            return self.PlayerData.items[slot]
        end
        return nil
    end

    self.GetItemBySlot = function(slot)
        local slot = tonumber(slot)
        if self.PlayerData.items[slot] ~= nil then
            return self.PlayerData.items[slot]
        end
        return nil
    end
    --print("18")

    self.Save = function()
        AIRES.Save(self.PlayerData.source)
    end
    --print("19")

    AIRES.Players[self.PlayerData.source] = self
    AIRES.Save(self.PlayerData.source)
    self.UpdatePlayerData()
    -- TriggerEvent('kashactersload', PlayerData.citizenid)
end

AIRES.Save = function(source)
    local PlayerData = AIRES.Players[source].PlayerData
    if PlayerData ~= nil then
        AIRES.FetchSql(
            true,
            "SELECT * FROM `users` WHERE `identifier` = '" .. PlayerData.citizenid .. "'",
            function(result)
                if result[1] == nil then
                    AIRES.ExecuteSql(
                        true,
                        "INSERT INTO `users` ( `identifier`, `metadata`) VALUES ('" ..
                            PlayerData.citizenid .. "', '" .. "', '" .. json.encode(PlayerData.metadata) .. "')"
                    )
                else
                    AIRES.ExecuteSql(
                        true,
                        "UPDATE `users` SET metadata='" ..
                            json.encode(PlayerData.metadata) ..
                                "' WHERE  `identifier` = '" .. PlayerData.citizenid .. "'"
                    )
                end
                AIRES.SaveInventory(source)
            end
        )
    end
end

RegisterServerEvent("AIRES:Server:SetMetaData")
AddEventHandler(
    "AIRES:Server:SetMetaData",
    function(meta, data)
        local src = source
        local Player = AIRES.Functions.GetPlayer(src)
        if Player ~= nil then
            Player.Functions.SetMetaData(meta, data)
        end
        TriggerClientEvent(
            "hud:client:UpdateNeeds",
            src,
            Player.PlayerData.metadata["hunger"],
            Player.PlayerData.metadata["thirst"]
        )
    end
)

AIRES.LoadInventory = function(PlayerData)
    PlayerData.items = {}
    AIRES.FetchSql(
        true,
        "SELECT * FROM `users` WHERE `identifier` = '" .. PlayerData.citizenid .. "'",
        function(result)
            if result[1] ~= nil then
                if result[1].inventory ~= nil then
                    plyInventory = json.decode(result[1].inventory)
                    if next(plyInventory) ~= nil then
                        for _, item in pairs(plyInventory) do
                            if item ~= nil then
                                local itemInfo = AIRES.Shared.Items[item.name:lower()]
                                PlayerData.items[item.slot] = {
                                    name = itemInfo["name"],
                                    amount = item.amount,
                                    info = item.info ~= nil and item.info or "",
                                    label = itemInfo["label"],
                                    description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                                    weight = itemInfo["weight"],
                                    type = itemInfo["type"],
                                    unique = itemInfo["unique"],
                                    useable = itemInfo["useable"],
                                    image = itemInfo["image"],
                                    shouldClose = itemInfo["shouldClose"],
                                    slot = item.slot,
                                    combinable = itemInfo["combinable"]
                                }
                            end
                        end
                    end
                end
            end
        end
    )
    return PlayerData
end

AIRES.SaveInventory = function(source)
    if AIRES.Players[source] ~= nil then
        local PlayerData = AIRES.Players[source].PlayerData
        local items = PlayerData.items
        local ItemsJson = {}
        if items ~= nil and next(items) ~= nil then
            for slot, item in pairs(items) do
                if items[slot] ~= nil then
                    table.insert(
                        ItemsJson,
                        {
                            name = item.name,
                            amount = item.amount,
                            info = item.info,
                            type = item.type,
                            slot = slot
                        }
                    )
                end
            end

            AIRES.ExecuteSql(
                true,
                "UPDATE `users` SET `inventory` = '" ..
                    AIRES.EscapeSqli(json.encode(ItemsJson)) ..
                        "' WHERE  `identifier` = '" .. PlayerData.citizenid .. "'"
            )
        end
    end
end

AIRES.GetTotalWeight = function(items)
    local weight = 0
    if items ~= nil then
        for slot, item in pairs(items) do
            weight = weight + (item.weight * item.amount)
        end
    end
    return tonumber(weight)
end

AIRES.GetSlotsByItem = function(items, itemName)
    local slotsFound = {}
    if items ~= nil then
        for slot, item in pairs(items) do
            if item.name:lower() == itemName:lower() then
                table.insert(slotsFound, slot)
            end
        end
    end
    return slotsFound
end

AIRES.GetFirstSlotByItem = function(items, itemName)
    if items ~= nil then
        for slot, item in pairs(items) do
            if item.name:lower() == itemName:lower() then
                return tonumber(slot)
            end
        end
    end
    return nil
end

AIRES.CreateSerialNumber = function()
    local UniqueFound = false
    local SerialNumber = nil

    while not UniqueFound do
        SerialNumber = math.random(11111111, 99999999)
        AIRES.FetchSql(
            true,
            "SELECT COUNT(*) as count FROM users WHERE metadata LIKE '%" .. SerialNumber .. "%'",
            function(result)
                if result[1].count == 0 then
                    UniqueFound = true
                end
            end
        )
    end
    return SerialNumber
end

RegisterServerEvent("AIRES-base:playerLoaded")
AddEventHandler(
    "AIRES-base:playerLoaded",
    function()
        local src = source
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local src = source
        if reason ~= "Reconnecting" and src > 60000 then
            return false
        end
        if (src == nil or (AIRES.Players[src] == nil)) then
            return false
        end
        AIRES.Players[src].Save()
        AIRES.Players[src] = nil
        TriggerClientEvent("AIRES-base:playerUnloaded", src)
    end
)

RegisterServerEvent("AIRES-base:useItem")
AddEventHandler(
    "AIRES-base:useItem",
    function(item)
        local src = source
        local xPlayer = AIRES.GetPlayerFromId(src)
        if item ~= nil and item.amount > 0 then
            if AIRES.canCarryItem(item.name) then
                AIRES.useItem(src, item)
            end
        end
    end
)

-- ESX.RegisterServerCallback('AIRES-base:hasItem', function(source, cb, itemName)
-- 	local retval = false
-- 	local xPlayer = AIRES.GetPlayerFromId(source)
-- 	if xPlayer ~= nil then
-- 		if xPlayer.getItemName(itemName) ~= nil then
-- 			retval = true
-- 		end
-- 	end

-- 	cb(retval)
-- end)

RegisterServerEvent("AIRES-base:removeItem")
AddEventHandler(
    "AIRES-base:removeItem",
    function(itemName, amount, slot)
        local src = source
        local xPlayer = AIRES.GetPlayerFromId(src)
        xPlayer.removeItem(itemName, amount, slot)
    end
)

RegisterServerEvent("AIRES-base:addItem")
AddEventHandler(
    "AIRES-base:addItem",
    function(itemName, amount, slot, info)
        local src = source
        local xPlayer = AIRES.GetPlayerFromId(src)
        xPlayer.addItem(itemName, amount, slot, info)
    end
)

RegisterServerEvent("AIRES-base:setMetadata")
AddEventHandler(
    "AIRES-base:setMetadata",
    function(meta, data)
        local src = source
        local xPlayer = AIRES.GetPlayerFromId(src)
        if meta == "hunger" or meta == "thirst" then
            if data > 100 then
                data = 100
            end
        end
        if xPlayer ~= nil then
            xPlayer.SetMetaData(meta, data)
        end
    end
)

AIRES.EscapeSqli = function(str)
    local replacements = {['"'] = '\\"', ["'"] = "\\'"}
    return str:gsub('[\'"]', replacements) -- or string.gsub( source, "['\"]", replacements )
end

AIRES.Functions.CreateUseableItem = function(item, cb)
    AIRES.UseableItems[item] = cb
end

AddEventHandler(
    "chatMessage",
    function(source, n, message)
        if string.sub(message, 1, 1) == "/" then
            CancelEvent()
            local args = AIRES.Shared.SplitStr(message, " ")
            local command = string.gsub(args[1]:lower(), "/", "")
            if AIRES.Commands.List[command] ~= nil then
                local Player = AIRES.Functions.GetPlayer(tonumber(source))
                if Player ~= nil then
                    table.remove(args, 1)
                    if
                        (AIRES.Functions.HasPermission(source, "admin") or
                            AIRES.Functions.HasPermission(source, AIRES.Commands.List[command].permission))
                     then
                        if
                            (AIRES.Commands.List[command].argsrequired and #AIRES.Commands.List[command].arguments ~= 0 and
                                args[#AIRES.Commands.List[command].arguments] == nil)
                         then
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "SYSTEM",
                                "error",
                                "All arguments must be filled out!"
                            )
                            local agus = ""
                            for name, help in pairs(AIRES.Commands.List[command].arguments) do
                                agus = agus .. " [" .. help.name .. "]"
                            end
                            TriggerClientEvent("chatMessage", source, "/" .. command, false, agus)
                        else
                            AIRES.Commands.List[command].callback(source, args)
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "SYSTEM", "error", "No access to this command!")
                    end
                end
            end
        end
    end
)
