--[[
	id: OzkhCo0_2-diV3CJtGQvU
	name: tgiann-depo-s
	description: tgiann-depo-s
	time1: 2021-04-24 19:14:40.050389+00
	time2: 2021-04-24 19:14:40.05039+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local depoFiyat = 100000

QBCore.Functions.CreateCallback("tgiann-depo:depolar", function(source, cb)
    exports.ghmattimysql:execute("SELECT * FROM tgiann_depo", {}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('tgiann-depo:satin-al')
AddEventHandler('tgiann-depo:satin-al', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveMoney('bank', depoFiyat) then
        exports.ghmattimysql:execute("SELECT * FROM tgiann_depo WHERE citizenid = @citizenid", {
            ["@citizenid"] = xPlayer.PlayerData.citizenid
        }, function(result)
            if not result[1] then
                exports.ghmattimysql:scalar("INSERT INTO tgiann_depo (citizenid, sifre, isim) VALUES (@citizenid, @sifre, @isim)", {
                    ['citizenid'] = xPlayer.PlayerData.citizenid, 
                    ['sifre'] = data.sifre,
                    ['isim'] = data.depoisim,
                }, function()
                    TriggerClientEvent("tgiann-depo:yenile", src)
                    TriggerClientEvent("QBCore:Notify", src, "Depo "..depoFiyat.."$ Karşılığında Satın Allındı!", "success")
                end)
            end
        end)
    end
end)

RegisterServerEvent('tgiann-depo:sat')
AddEventHandler('tgiann-depo:sat', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.ghmattimysql:execute("SELECT * FROM tgiann_depo WHERE citizenid = @citizenid", {
        ["@citizenid"] = xPlayer.PlayerData.citizenid
    }, function(result)
        if result[1] then
            exports.ghmattimysql:scalar("DELETE FROM tgiann_depo WHERE citizenid = @citizenid", {
                ['@citizenid'] = xPlayer.PlayerData.citizenid,
            }, function()
                local para = depoFiyat*0.5
                xPlayer.Functions.AddMoney('bank', para)
                TriggerClientEvent("QBCore:Notify", src, "Depo "..para.."$ Karşılığında Satıldı!", "success")
                TriggerClientEvent("tgiann-depo:yenile", src)
            end)
        end
    end)
end)