--[[
	id: QBz_Kfu572ipFXcCwTwRP
	name: multichar-s
	description: multi karakter server
	time1: 2021-04-26 06:54:44.40804+00
	time2: 2021-04-26 06:54:44.408041+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('qb-multicharacter:server:disconnect')
AddEventHandler('qb-multicharacter:server:disconnect', function()
    local src = source
    DropPlayer(src, "Ex-RolePlay Sunucusundan Çıkış Yaptın!")
end)

RegisterServerEvent('qb-multicharacter:server:loadUserData')
AddEventHandler('qb-multicharacter:server:loadUserData', function(cData)
    local src = source
    if QBCore.Player.Login(src, cData.citizenid) then
        print('^2[qb-core]^7 '..GetPlayerName(src)..' (Citizen ID: '..cData.citizenid..') has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        TriggerClientEvent('qb-spawn:client:setupSpawns',src, cData, false, nil)
        TriggerClientEvent("qb-spawn:client:openUI", src, true)
	end
end)

RegisterServerEvent('qb-multicharacter:server:createCharacter')
AddEventHandler('qb-multicharacter:server:createCharacter', function(data)
    local src = source
    local newData = {}
    newData.cid = data.cid
    newData.charinfo = data
    --QBCore.Player.CreateCharacter(src, data)
    if QBCore.Player.Login(src, false, newData) then
        print('^2[qb-core]^7 '..GetPlayerName(src)..' has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        TriggerClientEvent("qb-multicharacter:client:closeNUI", src)

        --TriggerClientEvent('qb-spawn:client:setupSpawns', src, cData, true, nil)
       -- TriggerClientEvent('qb-spawn:client:openUI', src, true)
        TriggerClientEvent("qb-clothes:client:CreateFirstCharacter", src)
        GiveStarterItems(src)
	end
end)

local randomSpawnFood = {
    "tburgerxl",
    "burgerxl",
    "hotdogxl",
    "tacoxl",
}

function GiveStarterItems(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(QBCore.Shared.StarterItems) do
        Player.Functions.AddItem(v.item, 1)
    end
    Player.Functions.AddItem(math.random(1, #randomSpawnFood), 2)
    Player.Functions.AddItem("atom", 2)
    TriggerEvent('DiscordBot:ToDiscord', 'karakterlog', 'Karakter Açtı', src)
end

RegisterServerEvent('qb-multicharacter:server:deleteCharacter')
AddEventHandler('qb-multicharacter:server:deleteCharacter', function(citizenid, key)
    local src = source
    local cid = citizenid
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        QBCore.Player.DeleteCharacter(src, cid)
    end
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetUserCharacters", function(source, cb)
    local steamId = GetPlayerIdentifier(source, 0)

    exports['ghmattimysql']:execute('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetServerLogs", function(source, cb)
    exports['ghmattimysql']:execute('SELECT * FROM server_logs', function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("test:yeet", function(source, cb)
    local steamId = GetPlayerIdentifiers(source)[1]
    local plyChars = {}
    
    exports['ghmattimysql']:execute('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)
            plyChars[result[i].cid] = result[i]
        end
        cb(plyChars)
    end)
end)

QBCore.Commands.Add("char", "Give item to a player", {{name="id", help="Player ID"},{name="item", help="Name of the item (not a label)"}, {name="amount", help="Amount of items"}}, false, function(source, args)
    QBCore.Player.Logout(source)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', source)
end, "admin")

QBCore.Functions.CreateCallback("qb-multicharacter:server:getSkin", function(source, cb, cid)
    local src = source

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `citizenid` = '"..cid.."' AND `active` = 1", function(result)
        if result[1] ~= nil then
            cb(result[1].model, result[1].skin)
        else
            cb(nil)
        end
    end)
end)