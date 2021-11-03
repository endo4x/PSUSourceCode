--[[
	id: 2utF5aTw6Y0kKBivvIFGW
	name: Base-S
	description: Tgiann Base Server
	time1: 2021-04-24 18:56:47.839858+00
	time2: 2021-04-24 18:56:47.839858+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

local testPolice = false
local npcOn = true
local sifirPolis = false

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("clear", "Chat Geçmişini Temizle", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	TriggerClientEvent('chat:clear', source)
end)

RegisterServerEvent('tgiann-base:mesaj')
AddEventHandler('tgiann-base:mesaj', function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local nick = GetPlayerName(src)
    TriggerEvent('DiscordBot:ToDiscord', 'hile', '@here ```Nick: ('.. nick .. ') Steam İd: (' .. identifier .. ') Muhtemel Dumpcı```')
    DropPlayer(src, "Pinginiz Çok Fazla :)") 
end)

QBCore.Functions.CreateCallback('tgiann-base:removeItem', function(source, cb, item, amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.Functions.RemoveItem(item, amount) then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('tgiann-base:xplayer-kullanici-bilgi', function(source, cb, id)
    local xPlayer = QBCore.Functions.GetPlayer(id)
    if xPlayer then
        local data = {
            firstname = xPlayer.PlayerData.charinfo.firstname,
            lastname = xPlayer.PlayerData.charinfo.lastname,
            kelepce = xPlayer.PlayerData.metadata.kelepce,
            pkelepce = xPlayer.PlayerData.metadata.pkelepce,
            is_dead = xPlayer.PlayerData.metadata.isdead,
            job = xPlayer.PlayerData.job.name,
            onduty = xPlayer.PlayerData.job.onduty,
        }
        cb(data)
    end
end) 

RegisterServerEvent('tgiann-base:ana-siken')
AddEventHandler('tgiann-base:ana-siken', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return; end
    local idedentifier = GetPlayerIdentifiers(src)
    local discord = nil
    for i=1, #idedentifier do
        if string.find(idedentifier[i], "discord") then
            discord = string.sub(idedentifier[i], 9)
        end
    end
	exports.ghmattimysql:execute('UPDATE whitelist SET songiris = @songiris, discord = @discord WHERE identifier = @identifier', {
        ['@songiris'] = os.date("%d-%m-%Y"),
        ['@identifier'] = xPlayer.PlayerData.steam,
        ['@discord'] = discord
	})
end)

-- Polis Sayısı
--QBCore.Functions.TriggerCallback('tgiann-base:polis-sayi', function(AktifPolis)
QBCore.Functions.CreateCallback('tgiann-base:polis-sayi', function(source, cb)
    if sifirPolis then
        cb(0)
    elseif testPolice then
        cb(100)
    else
        cb(getJobCount("police"))
    end
end)

-- EMS Sayısı
--QBCore.Functions.TriggerCallback('tgiann-base:ems-sayi', function(AktifEMS)
QBCore.Functions.CreateCallback('tgiann-base:ems-sayi', function(source, cb)
    cb(getJobCount("ambulance"))
end)

-- Mekanik Sayısı
--QBCore.Functions.TriggerCallback('tgiann-base:mekanik-sayi', function(AktifMekanik)
QBCore.Functions.CreateCallback('tgiann-base:mekanik-sayi', function(source, cb)
    cb(getJobCount("mechanic"))
end)

-- Geleri Sayısı
--QBCore.Functions.TriggerCallback('tgiann-base:mekanikb-sayi', function(AktifMekanikB)
QBCore.Functions.CreateCallback('tgiann-base:galeri-sayi', function(source, cb)
    cb(getJobCount("cardealer"))
end)

QBCore.Functions.CreateCallback('tgiann-base:ems-police-sayi', function(source, cb)
    local policeC = getJobCount("police")
    local emsC = getJobCount("ambulance")
    cb(emsC+policeC)
end)

function getJobCount(jobName)
    local sayi = 0
    local xPlayers = QBCore.Functions.GetPlayers()
	for i=1, #xPlayers, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
        if jobName == "mechanic" then
            if xPlayer.PlayerData.job.onduty and (xPlayer.PlayerData.job.name == "mechanic" or xPlayer.PlayerData.job.name == "mechanic_gabz" or xPlayer.PlayerData.job.name == "mechanic_hayes" or xPlayer.PlayerData.job.name == "mechanic_bennys") then
                sayi = sayi + 1
            end
        else
            if xPlayer.PlayerData.job.name == jobName and xPlayer.PlayerData.job.onduty then
                sayi = sayi + 1
            end
        end
    end
    return sayi
end

--[[İtem Sayısı Kontrol
QBCore.Functions.TriggerCallback('tgiann-base:item-kontrol', function(qtty)
    if qtty > 0 then
    end
end, item)]]
QBCore.Functions.CreateCallback('tgiann-base:item-kontrol', function(source, cb, item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then  
        local items = xPlayer.Functions.GetItemByName(item)
        if items == nil then
            cb(0)
        else
            cb(items.amount)
        end
    end
end)

RegisterServerEvent("tgiann-base:KullanciPara")
AddEventHandler("tgiann-base:KullanciPara", function(key, durum, nere, miktar)
    if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key

        local xPlayer = QBCore.Functions.GetPlayer(source)
        if not xPlayer then return; end

        if durum == "ekle" then
            TriggerEvent('DiscordBot:ToDiscord', 'eventpara', 'tgiann-base paraver ' .. durum.. ' ' .. nere ..' '.. miktar, source)
            if nere == "üst" then
                xPlayer.Functions.AddMoney('cash', miktar)
            elseif nere == "banka" then
                xPlayer.Functions.AddMoney('bank', miktar)
            end
        elseif durum == "sil" then
            if nere == "üst" then
                xPlayer.Functions.RemoveMoney('cash', miktar)
            elseif nere == "banka" then
                xPlayer.Functions.RemoveMoney('bank', miktar)
            end
        end
    end

end)

QBCore.Commands.Add("polisadmin", "Test Polis Sayısını Artırır veya Azaltır", {}, false, function(source, args)
    testPolice = not testPolice
	TriggerClientEvent('chatMessage', source, "SYSTEM", "normal", "Polis Test: ".. tostring(testPolice))
end, "god")

QBCore.Commands.Add("polis", "Bütün Polisleri Mesaiden Çıkarır veya Mesaiye Geri Sokar", {}, false, function(source, args)
--[[     local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.job.name == "police" and xPlayer.PlayerData.job.boss then ]]
        if not sifirPolis then
            sifirPolis = true
            TriggerClientEvent('chatMessage', source, "SYSTEM", "normal", "Bütün polisler mesaiden çıkarıldı!")
        else
            sifirPolis = false
            TriggerClientEvent('chatMessage', source, "SYSTEM", "normal", "Aktif polisler tekrar mesaiye sokuldu!")
        end
--[[     else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Bu Komutu Kullanamazsın!")
    end ]]
end, "god")

QBCore.Commands.Add("npc", "NPC'leri açıp kapatır", {}, false, function(source, args)
    npcOn = not npcOn
    TriggerClientEvent("set-npc", -1, npcOn)
    if npcOn then 
        TriggerClientEvent('chatMessage', -1, "SYSTEM", "normal", "Yerli vatandaşların araçlarıyla dolaşmasını kısıtlayan yasak kaldırıldı!")
    else
        TriggerClientEvent('chatMessage', -1, "SYSTEM", "normal", "İkinci bir emre kadar yerli vatandaşların araçla dolaşmaları yasaklandı!")
    end
end, "god")

QBCore.Functions.CreateCallback('check-npc-on', function(source, cb)
	cb(npcOn)
end)

local soygunTime = 0
local soygunCoolDown = 3600

--[[ 
if not exports["tgiann-base"]:soygunKontrol(source) then
    cb(false)
    return
end 
]]
exports('soygunKontrol', function(src)
    if (os.time() - soygunTime) < soygunCoolDown and soygunTime ~= 0 then
        TriggerClientEvent("QBCore:Notify", src, "Şuan Şehirde Bir Soygun Yapılıyor! Daha Sonra Tekrar Dene!", "error")
        return false
    else
        soygunTime = os.time()
        return true
    end
end)

exports('soygunKontrolReset', function()
    soygunTime = 0
end)

RegisterServerEvent("tgiann-base:soygunKontrolReset")
AddEventHandler("tgiann-base:soygunKontrolReset", function(key)
    if QBCore.Functions.kickHacKer(source, key) then
        soygunTime = 0
    end
end)

QBCore.Functions.CreateCallback('tgiann-base:araclarim', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid', {
            ['@citizenid'] = xPlayer.PlayerData.citizenid,
        }, function(data)
            cb(data)
        end)
    end
end)

QBCore.Commands.Add("kit", "PVP Kiti!", {{name="id", help="Oyuncu ID"}, {name="kit", help="1 AK, 2 TEC9"}}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna 
    if args[1] and args[2] then
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if args[2] == "1" then
            xPlayer.Functions.AddItem("weapon_assaultrifle_mk2", 1)
            xPlayer.Functions.AddItem("rifle_ammo", 3)
        elseif args[2] == "2" then
            xPlayer.Functions.AddItem("weapon_smg_mk2", 1)
            xPlayer.Functions.AddItem("smg_ammo", 5)
        end

        xPlayer.Functions.AddItem("armor", 5)
        xPlayer.Functions.AddItem("walkie_lspd", 1)
        xPlayer.Functions.AddItem("bandage", 10)

        TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/kit '..args[1]..' '..args[2], source, tonumber(args[1]))
    end
end, "admin")

RegisterServerEvent('rogue')
AddEventHandler('rogue', function(data)
    TriggerClientEvent("rogue:delete", -1, data)
end)