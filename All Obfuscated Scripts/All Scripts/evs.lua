--[[
	id: AUSdrmXXNZpt4m0T31V4R
	name: ev-s
	description: ev-server
	time1: 2021-04-24 19:07:32.372682+00
	time2: 2021-04-24 19:07:32.372683+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback("tgiann-ev:ilg-giris", function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        local evivar, evData = oyuncuEvKontrol(xPlayer.PlayerData.citizenid)
        if evivar then
            cb(evData)
        else
            cb(false)
        end
    else
        cb(nil)
    end
end)

RegisterServerEvent('tgiann-ev:satin-al')
AddEventHandler('tgiann-ev:satin-al', function(evId, para)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local evivar = oyuncuEvKontrol(xPlayer.PlayerData.citizenid)
    if not evivar then
        local evSatilmis = EvKontrol(evId)
        if not evSatilmis then
            if xPlayer.Functions.RemoveMoney('bank', para) then
                exports.ghmattimysql:scalarSync("INSERT INTO tgiann_ev (id, anahtar1) VALUES (@evId, @anahtar1)", {
                    ['evId'] = evId, 
                    ['anahtar1'] = xPlayer.PlayerData.citizenid,
                })
                TriggerClientEvent("tgiann-ev:ev-ayarla", src)
                TriggerClientEvent("QBCore:Notify", src, "Evi "..para.."$ Karşılığında Satın Aldın!", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "Bankan Hesabında "..para.."$ Yok", "error")
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "Bu Ev Başkasına Ait!", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "Zaten Bir Evin Var!", "error")
    end
end)

RegisterServerEvent('tgiann-ev:sat')
AddEventHandler('tgiann-ev:sat', function(para, evId, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        xPlayer.Functions.AddMoney('bank', para)
        TriggerClientEvent("QBCore:Notify", src, "Evini "..para.."$ Karşılığında Sattın")
        exports.ghmattimysql:scalar("DELETE FROM tgiann_ev WHERE id = @id", {
            ['@id'] = evId
        })
    end
end)

RegisterServerEvent('tgiann-ev:anahtar-degis')
AddEventHandler('tgiann-ev:anahtar-degis', function(evId, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        exports.ghmattimysql:execute("SELECT * FROM tgiann_ev WHERE id = @id", {
            ['@id'] = evId, 
        }, function(result)
            for anahtar, citizenid in pairs(result[1]) do
                if anahtar ~= "anahtar1" and anahtar ~= "id" then
                    local tPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
                    if tPlayer then
                        TriggerClientEvent("tgiann-ev:sifirla", tPlayer.PlayerData.source)
                    end
                end
            end
            exports.ghmattimysql:scalar("UPDATE tgiann_ev SET anahtar2 = @anahtar, anahtar3 = @anahtar, anahtar4 = @anahtar, anahtar5 = @anahtar WHERE id = @id", {
                ['@id'] = evId, 
                ['@anahtar'] = nil
            })
            TriggerClientEvent("QBCore:Notify", src, "Evinin Anahtarını Değiştirdin", "success")
        end)
    end
end)

RegisterServerEvent('tgiann-ev:anahtar-ver')
AddEventHandler('tgiann-ev:anahtar-ver', function(target, evId, key)
    local src = source
    local anahtarlar = {"anahtar2","anahtar3","anahtar4","anahtar5"}
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local tPlayer = QBCore.Functions.GetPlayer(target)
        if tPlayer then
            exports.ghmattimysql:execute("SELECT * FROM tgiann_ev WHERE (anahtar1 = @anahtar OR anahtar2 = @anahtar OR anahtar3 = @anahtar OR anahtar4 = @anahtar OR anahtar5 = @anahtar)", {
                ['@anahtar'] = tPlayer.PlayerData.citizenid
            }, function(result)
                if result[1] then
                    TriggerClientEvent("QBCore:Notify",src, "Kişinin Bir Evi Zaten Var!", "error") 
                else
                    exports.ghmattimysql:execute("SELECT * FROM tgiann_ev WHERE id = @id", {
                        ['@id'] = evId, 
                    }, function(result)
                        local bosAnahtar = false
                        local bosAnahtarNo = 0
                        for i=1, #anahtarlar do
                            local stringAnahtar = tostring(anahtarlar[i])
                            if result[1][stringAnahtar] == nil then
                                bosAnahtar = true
                                bosAnahtarNo = stringAnahtar
                                break
                            end
                        end
                        if not bosAnahtar then
                            TriggerClientEvent("QBCore:Notify", src, "Evin Anahtarını "..#anahtarlar.." Farklı Kişiye Verdiğin İçin Daha Fazla Anahtar Veremezsin!", "error")
                        else
                            exports.ghmattimysql:scalar("UPDATE tgiann_ev SET "..bosAnahtarNo.." = @anahtar WHERE id = @id", {
                                ['@id'] = evId, 
                                ['@anahtar'] = tPlayer.PlayerData.citizenid
                            })
                            TriggerClientEvent("tgiann-ev:sifirla", tPlayer.PlayerData.source)
                            TriggerClientEvent("QBCore:Notify", tPlayer.PlayerData.source, "Yakınındaki Bir Kişi Sana Evinin Anahtarını Verdi")
                            TriggerClientEvent("QBCore:Notify", src, "Yakınındaki Kişiye Anahtarı Verdin", "success")
                        end
                    end)
                end
            end)
        else
            TriggerClientEvent("QBCore:Notify", src, "Yakınlarda Kimse Yok!", "error") 
        end
    end
end)

RegisterServerEvent('tgiann-ev:anahtar-birak')
AddEventHandler('tgiann-ev:anahtar-birak', function(evId, anahtar)
    local src = source
    exports.ghmattimysql:scalar("UPDATE tgiann_ev SET "..anahtar.." = @anahtar WHERE id = @id", {
        ['@id'] = evId, 
        ['@anahtar'] = nil
    }, function()
        TriggerClientEvent("tgiann-ev:ev-ayarla", src)
        TriggerClientEvent("QBCore:Notify", src, "Evin Anahtarını Bıraktın!", "success")
    end)
end)

function oyuncuEvKontrol(citizenid)
    local result = exports.ghmattimysql:executeSync("SELECT * FROM tgiann_ev WHERE  (anahtar1 = @citizenid OR anahtar2 = @citizenid OR anahtar3 = @citizenid OR anahtar4 = @citizenid OR anahtar5 = @citizenid)", {
        ['@citizenid'] = citizenid
    })

    if result[1] then
        return true, result[1]
    else
        return false
    end
end

function EvKontrol(id)
    local result = exports.ghmattimysql:executeSync("SELECT * FROM tgiann_ev WHERE id = @id", {
        ['@id'] = id
    })

    if result[1] then
        return true
    else
        return false
    end
end