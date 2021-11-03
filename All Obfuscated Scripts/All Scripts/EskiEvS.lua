--[[
	id: 8xrz7-M3P9ta56018847d
	name: EskiEv-S
	description: eskiev server
	time1: 2021-04-24 19:01:59.436301+00
	time2: 2021-04-24 19:01:59.436302+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

local houseData = {
    lastRob = 0,
    cars = {
       -- {plate = "43UNH457", robbed = false}
    }
}

local regItem = "yesil_kart"

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback("tgiann-eskiev:check-house", function(source, cb)
    if (os.time() - houseData.lastRob) < 10800 and houseData.lastRob ~= 0 then
        TriggerClientEvent("QBCore:Notify", source, "Aracı Senden Önce Başkası Aldı!", "error")
        cb(false)
    else
        cb(true)
    end
end)

RegisterServerEvent('tgiann-eskiev:setVehiclePlate')
AddEventHandler('tgiann-eskiev:setVehiclePlate', function(key, plate, bool)
    if QBCore.Functions.kickHacKer(source, key) then
        for i=1, #houseData.cars do
            if houseData.cars[i].plate == plate then
                houseData.cars[i].robbed = bool
                return
            end
        end
        table.insert(houseData.cars, {plate = plate, robbed = bool})
    end
end)

QBCore.Functions.CreateUseableItem(regItem, function(source, item)
    TriggerClientEvent("tgiann-eskiev:checkCar", source)
end)

QBCore.Functions.CreateCallback("tgiann-eskiev:checCarStatus", function(source, cb, plate)
    for i=1, #houseData.cars do
        if houseData.cars[i].plate == plate then
            if not houseData.cars[i].robbed then
                if not exports["tgiann-base"]:soygunKontrol(source) then 
                    cb(false)
                    return 
                end

                houseData.cars[i].robbed = true
                houseData.lastRob = os.time()
                cb(true)
                return
            else
                TriggerClientEvent("QBCore:Notify", source, "Aracı Başkası Soyuyor veya Araç Daha Önce Soyuldu!", "error")
                break
            end
        end
    end
    TriggerClientEvent("QBCore:Notify", source, "Aracın İçi Boş!", "error")
    cb(false)
end)

RegisterServerEvent('tgiann-eskiev:giveItem')
AddEventHandler('tgiann-eskiev:giveItem', function(key, plate)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer.Functions.RemoveItem(regItem, 1) then
            for i=1, #houseData.cars do
                if houseData.cars[i].plate == plate then
                    houseData.cars[i] = nil
                end
            end

            local random = math.random(evConfig.MaddXAdet.r1, evConfig.MaddXAdet.r2)
            xPlayer.Functions.AddItem("madde_x", random)
            if math.random(1, 100) < 26 and evConfig.kartVer then
                xPlayer.Functions.AddItem(evConfig.kartAdi, 1)
                TriggerClientEvent("QBCore:Notify", src, random.." Madde X ve Bir Tane "..QBCore.Shared.Items[evConfig.kartAdi].label" Aldın!")
            else
                TriggerClientEvent("QBCore:Notify", src, random.." Madde X Aldın!")
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "Üzerinde Yeşil Kart Yok!", "error")
        end
    end
end)