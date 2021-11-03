--[[
	id: 5lnmjzNasMO_Rj8rBQTFL
	name: MDT-S
	description: MDT Server
	time1: 2021-04-24 18:21:23.767071+00
	time2: 2021-04-24 18:21:23.767072+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local players = {}

QBCore.Functions.CreateCallback("tgiann-mdtv2:ilk-data", function(source, cb)
    cb(players)
end)

Citizen.CreateThread(function()
    exports.ghmattimysql:execute("SELECT firstname, lastname, jobname FROM players ", {
    }, function (result)
        players.police = {}
        players.user = {}
        for i=1, #result do
            if result[i].jobname == "police" then
                table.insert(players.police, result[i].firstname .. " " .. result[i].lastname)
            else
                table.insert(players.user, result[i].firstname .. " " .. result[i].lastname)
            end
        end
    end) 
end)

QBCore.Commands.Add("tablet", "Polis Tabletini Aç", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	TriggerClientEvent('tgiann-mdtv2:open', source)
end)

QBCore.Functions.CreateCallback("tgiann-mdtv2:sorgula", function(source, cb, data)
    if data.tip == "isim" then
        exports.ghmattimysql:execute("SELECT * FROM players WHERE CONCAT(firstname, ' ', lastname) LIKE @search LIMIT 30", {
            ['@search'] = '%'..data.data..'%'
        }, function (result)
            if result then
                cb(result)
            end
        end) 
    elseif data.tip == "arac" then
        exports.ghmattimysql:execute("SELECT * FROM owned_vehicles WHERE citizenid = @citizenid", {
            ['@citizenid'] = data.data
        }, function (result)
            if result then
                cb(result)
            end
        end) 
    elseif data.tip == "numara" then
        exports.ghmattimysql:execute("SELECT * FROM players WHERE number LIKE @search LIMIT 30", {
            ['@search'] = '%'..data.data..'%'
        }, function (result)
            if result then
                cb(result)
            end
        end) 
    elseif data.tip == "plaka" then
        exports.ghmattimysql:execute("SELECT * FROM owned_vehicles LEFT JOIN players ON owned_vehicles.citizenid = players.citizenid WHERE owned_vehicles.plate LIKE @plate LIMIT 30", {
            ['@plate'] = '%'..data.data..'%'
        }, function (result)
            if result then
                cb(result)
            end
        end) 
    end
end)

QBCore.Functions.CreateCallback('tgiann-mdtv2:ev', function(source, cb, citizenid)
    exports.ghmattimysql:execute("SELECT * FROM tgiann_ev WHERE (id = @id OR anahtar1 = @id OR anahtar2 = @id OR anahtar3 = @id OR anahtar4 = @id OR anahtar5 = @id)", {
        ['@id'] = citizenid
    }, function(result)
        if result[1] then
            cb(result[1].id)
        else
            cb("Ev Bilgisi Yok!")
        end
    end)
end)

RegisterServerEvent('tgiann-mdtv2:ceza-kaydet')
AddEventHandler('tgiann-mdtv2:ceza-kaydet', function(data)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO tgiann_mdt_olaylar SET aciklama = @aciklama, polis = @polis, zanli = @zanli, esyalar = @esyalar", {
        ["@aciklama"] = data.aciklama,
        ["@polis"] = json.encode(data.polis),
        ["@zanli"] = json.encode(data.zanli),
        ["@esyalar"] = json.encode(data.esyalar),
     }, function(result1)
        for i=1, #data.zanli do
            exports.ghmattimysql:execute("SELECT citizenid FROM players WHERE CONCAT(firstname, ' ', lastname) LIKE @search LIMIT 30", {
                ['@search'] = '%'..data.zanli[i]..'%'
            }, function(result)
                if result[1] then
                   --[[  if data.illegal then
                        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(result[1].citizenid)
                        if tPlayer and not tPlayer.PlayerData.metadata.illegalv2 then
                            tPlayer.Functions.SetMetaData("illegalv2", true)
                            TriggerClientEvent("tgiann-base:set-illegal", tPlayer.PlayerData.source, QBCore.Key)
                        end
                    end ]]

                    if data.ceza.tceza > 0 then
                        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(result[1].citizenid)
                        if tPlayer and tPlayer.PlayerData.metadata.ehliyetceza < 10 then
                            local newValue = tPlayer.PlayerData.metadata.ehliyetceza+data.ceza.tceza
                            tPlayer.Functions.SetMetaData("ehliyetceza", newValue)
                            if newValue > 9 then
                                TriggerClientEvent("QBCore:Notify", tPlayer.PlayerData.source, "Ehliyetine Polis Tarafından El Konuldu", "error", 15000)
                                TriggerClientEvent("QBCore:Notify", src, tPlayer.PlayerData.charinfo.firstname.. " " ..tPlayer.PlayerData.charinfo.lastname.." İsimli Kişinin Ehliyetine El Konuldu", "success", 15000)
                            end
                        end
                    end
                    
                    exports.ghmattimysql:execute("INSERT INTO tgiann_mdt_cezalar SET citizenid = @citizenid, aciklama = @aciklama, ceza = @ceza, polis = @polis, cezalar = @cezalar, zanli = @zanli, olayid = @id", {
                        ["@citizenid"] = result[1].citizenid,
                        ["@aciklama"] = data.aciklama,
                        ["@ceza"] = json.encode(data.ceza),
                        ["@polis"] = json.encode(data.polis),
                        ["@zanli"] = json.encode(data.zanli),
                        ["@cezalar"] = data.cezaisim,
                        ["@id"] = result1.insertId
                    })
                end
            end)
        end
    end)
end)

QBCore.Functions.CreateCallback("tgiann-mdtv2:olaylardata", function(source, cb, data)
    exports.ghmattimysql:execute("SELECT * FROM tgiann_mdt_olaylar ORDER BY id DESC LIMIT 100", {
    }, function (result)
        cb(result)
    end) 
end)

QBCore.Functions.CreateCallback("tgiann-mdtv2:sabikadata", function(source, cb, data)
    exports.ghmattimysql:execute("SELECT * FROM tgiann_mdt_cezalar WHERE citizenid = @citizenid ORDER BY id DESC ", {
        ["@citizenid"] = data
    }, function (result)
        cb(result)
    end) 
end)

RegisterServerEvent('tgiann-mdtv2:sabikasil')
AddEventHandler('tgiann-mdtv2:sabikasil', function(data)
    exports.ghmattimysql:execute("DELETE FROM tgiann_mdt_cezalar WHERE id = @id", {
        ['@id'] = data
    })
end)

RegisterServerEvent('tgiann-mdtv2:setavatar')
AddEventHandler('tgiann-mdtv2:setavatar', function(url, id)
    local xPlayer = QBCore.Functions.GetPlayerByCitizenId(id)
    if xPlayer then
        xPlayer.Functions.SetCharInfo("photo", url)
        xPlayer.Functions.Save()
    end
end)

RegisterServerEvent('tgiann-mdtv2:olaysil')
AddEventHandler('tgiann-mdtv2:olaysil', function(id)
    exports.ghmattimysql:execute("DELETE FROM tgiann_mdt_olaylar WHERE id = @id", {
        ['@id'] = id
    })
    exports.ghmattimysql:execute("DELETE FROM tgiann_mdt_cezalar WHERE olayid = @olayid", {
        ['@olayid'] = id
    })
end)

RegisterServerEvent('tgiann-mdtv2:aranma')
AddEventHandler('tgiann-mdtv2:aranma', function(data, durum)
    local xPlayer = QBCore.Functions.GetPlayerByCitizenId(data.id)
    if durum then
        local saat = os.time() + data.saat * 86400
        if xPlayer then
            xPlayer.Functions.SetAranma(true, data.neden, saat)
            xPlayer.Functions.Save()
        else
            exports.ghmattimysql:execute("UPDATE players SET aranma=@aranma WHERE citizenid = @citizenid", {
                ['@citizenid'] = data.id,
                ['@aranma'] = json.encode({durum = true, sebep=data.neden, suansaat=os.time(), saat=saat})
            })
        end
        exports.ghmattimysql:execute("INSERT INTO tgiann_mdt_arananlar SET citizenid = @citizenid, sebep = @sebep, baslangic = @baslangic, bitis = @bitis, isim = @isim", {
            ["@citizenid"] = data.id,
            ["@sebep"] = data.neden,
            ["@baslangic"] = os.time(),
            ["@bitis"] = saat,
            ["@isim"] = data.isim
        })
    else
        if xPlayer then
            xPlayer.Functions.SetAranma(false)
            xPlayer.Functions.Save()
        else
            exports.ghmattimysql:execute("UPDATE players SET aranma=@aranma WHERE citizenid = @citizenid", {
                ['@citizenid'] = data.id,
                ['@aranma'] = json.encode({durum = false, sebep="", suansaat="", saat=""})
            })
        end
        exports.ghmattimysql:execute("DELETE FROM tgiann_mdt_arananlar WHERE citizenid = @citizenid", {
            ['@citizenid'] = data.id
        })
    end
end)

QBCore.Functions.CreateCallback("tgiann-mdtv2:arananlar", function(source, cb, data)
    exports.ghmattimysql:execute("SELECT * FROM tgiann_mdt_arananlar", {
    }, function (result)
        cb(result)
    end) 
end)

QBCore.Functions.CreateCallback("tgiann-mdtv2:olayara", function(source, cb, data)
    exports.ghmattimysql:execute("SELECT * FROM tgiann_mdt_olaylar WHERE id = @id", {
        ["@id"] = tonumber(data)
    }, function (result)
        cb(result)
    end) 
end)