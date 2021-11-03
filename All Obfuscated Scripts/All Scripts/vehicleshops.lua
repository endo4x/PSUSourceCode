--[[
	id: gvleYcK8g3fmg76IuI4u0
	name: vehicleshop-s
	description: vehicleshop server
	time1: 2021-04-29 17:54:13.667155+00
	time2: 2021-04-29 17:54:13.667156+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    
    local categories, vehicles = {}, {}
    local bugraDurum = true
    
    QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
    
    Citizen.CreateThread(function()
        local char = Config.PlateLetters
        char = char + Config.PlateNumbers
        if Config.PlateUseSpace then char = char + 1 end
    end)
    
    function RemoveOwnedVehicle(plate)
        exports.ghmattimysql:execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        })
    end
    
    function getVehicleLabelFromModel(model)
        for k,v in ipairs(vehicles) do
            if v.model == model then
                return v.name
            end
        end
    
        return
    end
    
    RegisterNetEvent('esx_vehicleshop:setVehicleOwnedPlayerId')
    AddEventHandler('esx_vehicleshop:setVehicleOwnedPlayerId', function(playerId, vehicleProps, model, label, vehicle, key)
        if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
            local xPlayer, xTarget = QBCore.Functions.GetPlayer(source), QBCore.Functions.GetPlayer(playerId)
            if xPlayer.PlayerData.job.name == "cardealer2" and xTarget then
                exports.ghmattimysql:execute('SELECT id FROM cardealer_vehicles WHERE vehicle = @vehicle LIMIT 1', {
                    ['@vehicle'] = model
                }, function(result)
                    if result[1] then
                        local id = result[1].id
                        exports.ghmattimysql:execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
                            ['@id'] = id
                        }, function(result)
                            if result.affectedRows == 1 then
                                exports.ghmattimysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle) VALUES (@citizenid, @plate, @vehicle)', {
                                    ['@citizenid']   = xTarget.PlayerData.citizenid,
                                    ['@plate']   = vehicleProps.plate,
                                    ['@vehicle'] = json.encode(vehicleProps)
                                }, function()
                                    TriggerClientEvent("x-hotwire:give-keys", xTarget.PlayerData.source, vehicle, vehicleProps.plate)
                                    TriggerClientEvent("esx_vehicleshop:exp", xTarget.PlayerData.source, "arac-satin-alma", QBCore.Key)
                                    TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, vehicleProps.plate.." plakalı araç "..xTarget.PlayerData.charinfo.firstname.. " " ..xTarget.PlayerData.charinfo.lastname.." kişisine devredildi")
                                    TriggerClientEvent("QBCore:Notify", xTarget.PlayerData.source, vehicleProps.plate.." plakalı araç artık senin")
                                    TriggerEvent('DiscordBot:ToDiscord', 'aracalma', model..' - Model Aracı Sattı!', xPlayer.PlayerData.source, xTarget.PlayerData.source)
                                end)
    
                                exports.ghmattimysql:execute('INSERT INTO vehicle_sold (client, model, plate, soldby, date) VALUES (@client, @model, @plate, @soldby, @date)', {
                                    ['@client'] = xTarget.PlayerData.charinfo.firstname.. " " ..xTarget.PlayerData.charinfo.lastname,
                                    ['@model'] = label,
                                    ['@plate'] = vehicleProps.plate,
                                    ['@soldby'] = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname,
                                    ['@date'] = os.date('%Y-%m-%d %H:%M')
                                })
                            end
                        end)
                    end
                end)
            end
        end
    end)
    
    RegisterNetEvent('esx_vehicleshop:setVehicleOwned')
    AddEventHandler('esx_vehicleshop:setVehicleOwned', function(vehicleProps, model, label, vehicle, key)
        if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
            local xPlayer = QBCore.Functions.GetPlayer(source)
    
            exports.ghmattimysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle) VALUES (@citizenid, @plate, @vehicle)', {
                ['@citizenid']   = xPlayer.PlayerData.citizenid,
                ['@plate']   = vehicleProps.plate,
                ['@vehicle'] = json.encode(vehicleProps)
            }, function()
                TriggerClientEvent("x-hotwire:give-keys", xPlayer.PlayerData.source, vehicle)
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, vehicleProps.plate.." plakalı araç artık senin")
            end)
    
            exports.ghmattimysql:execute('INSERT INTO vehicle_sold (client, model, plate, soldby, date) VALUES (@client, @model, @plate, @soldby, @date)', {
                ['@client'] = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname,
                ['@model'] = label,
                ['@plate'] = vehicleProps.plate,
                ['@soldby'] = "Sülayman",
                ['@date'] = os.date('%Y-%m-%d %H:%M')
            })
        end
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:getSoldVehicles', function(source, cb)
        exports.ghmattimysql:execute('SELECT client, model, plate, soldby, date FROM vehicle_sold', {}, function(result)
            cb(result)
        end)
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:getCategories', function(source, cb)
        cb(categories)
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:getVehicles', function(source, cb)
        cb(vehicles)
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:checkCarData', function(source, cb)
        cb(QBCore.Shared.Vehicles)
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:buyVehicle', function(source, cb, model, key, category, hash)
        if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
            local xPlayer = QBCore.Functions.GetPlayer(source)
            local modelPrice = QBCore.Shared.Vehicles[category][hash].price
            if QBCore.Shared.Vehicles[category][hash].count > 0 then
                if xPlayer.Functions.RemoveMoney('bank', modelPrice) then
                    QBCore.Functions.addJobMoney("cardealer2", (modelPrice/100)*15)
                    QBCore.Shared.Vehicles[category][hash].count = QBCore.Shared.Vehicles[category][hash].count - 1
                    TriggerEvent("qb-core:set-car-count", category, hash, QBCore.Shared.Vehicles[category][hash].count)
                    TriggerEvent('DiscordBot:ToDiscord', 'aracalma', QBCore.Shared.Vehicles[category][hash].name..' - '..QBCore.Shared.Vehicles[category][hash].price ..'(bugra!)', source)
                    cb(true)
                else
                    TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Yeterli Paran Yok")
                    cb(false)
                end
            else
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Stokta Bu Araçtan Yok!")
                cb(false)
            end
        end
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:getCommercialVehicles', function(source, cb)
        exports.ghmattimysql:execute('SELECT price, vehicle FROM cardealer_vehicles ORDER BY vehicle ASC', {}, function(result)
            cb(result)
        end)
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:buyCarDealerVehicle', function(source, cb, model, key, category, hash)
        if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
            local xPlayer = QBCore.Functions.GetPlayer(source)
            
            if xPlayer.PlayerData.job.name == "cardealer2" then
                local modelPrice = QBCore.Shared.Vehicles[category][hash].price
                if QBCore.Shared.Vehicles[category][hash].count > 0 then
                    if QBCore.Functions.removeJobMoney("cardealer2", modelPrice/100*75) then
                        QBCore.Shared.Vehicles[category][hash].count = QBCore.Shared.Vehicles[category][hash].count - 1
                        TriggerEvent("qb-core:set-car-count", category, hash, QBCore.Shared.Vehicles[category][hash].count)
                        TriggerEvent('DiscordBot:ToDiscord', 'aracalma', QBCore.Shared.Vehicles[category][hash].name..' - '..QBCore.Shared.Vehicles[category][hash].price ..'(Galerici Stoğa Aldı!)', source)
                        exports.ghmattimysql:execute('INSERT INTO cardealer_vehicles (vehicle, price) VALUES (@vehicle, @price)', {
                            ['@vehicle'] = model,
                            ['@price'] = modelPrice
                        }, function()
                            cb(true)
                        end)
                    else
                        cb(false)
                    end
                else
                    TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Stokta Bu Araçtan Yok!")
                    cb(false)
                end
            
            end
        end
    end)
    
    function getVehicleLabelFromModel(model)
        for k,v in pairs(QBCore.Shared.Vehicles) do
            for kk,vv in pairs(v) do
                if vv.model == model then
                    return vv.name
                end
            end
        end
        return "Bilinmiyor"
    end
    
    function getVehicleCategoryToModel(model)
        for k,v in pairs(QBCore.Shared.Vehicles) do
            for kk,vv in pairs(v) do
                if vv.model == model then
                    return k
                end
            end
        end
        return "Bilinmiyor"
    end
    
    function getVehicleCategoryToHash(hash)
        for k,v in pairs(QBCore.Shared.Vehicles) do
            for kk,vv in pairs(v) do
                if kk == hash then
                    return k
                end
            end
        end
        return "Bilinmiyor"
    end
    
    RegisterNetEvent('esx_vehicleshop:returnProvider')
    AddEventHandler('esx_vehicleshop:returnProvider', function(vehicleModel)
        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer.PlayerData.job.name == "cardealer2" then
            exports.ghmattimysql:execute('SELECT * FROM cardealer_vehicles WHERE vehicle = @vehicle LIMIT 1', {
                ['@vehicle'] = vehicleModel
            }, function(result)
                if result[1] then
                    local id = result[1].id
                    local model = getVehicleLabelFromModel(result[1].vehicle)
                    local price = result[1].price
                    exports.ghmattimysql:execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
                        ['@id'] = id
                    }, function(result2)
                        if result2.affectedRows == 1 then
                            local price = QBCore.Shared.Round(result[1].price * 0.75)
                            TriggerClientEvent("esx_vehicleshop:exp", src, "arac-geri-iade", QBCore.Key)
                            QBCore.Functions.addJobMoney("cardealer2", price)
                            TriggerClientEvent("QBCore:Notify", src, QBCore.Shared.GroupDigits(price).. "$ karşılığında satıldı")
                            TriggerEvent('DiscordBot:ToDiscord', 'aracalma', model..' - '..price ..'(Galerici Geri İade!)', src)
                            local vehicleCategory = getVehicleCategoryToModel(result[1].vehicle)
                            QBCore.Shared.Vehicles[vehicleCategory][GetHashKey(result[1].vehicle)].count = QBCore.Shared.Vehicles[vehicleCategory][GetHashKey(result[1].vehicle)].count + 1
                            TriggerEvent("qb-core:set-car-count", vehicleCategory, GetHashKey(result[1].vehicle), QBCore.Shared.Vehicles[vehicleCategory][GetHashKey(result[1].vehicle)].count)
                        end
                    end)
                end
            end)
        end
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:resellVehicle', function(source, cb, plate, model, key, price)
        if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
            local src = source
            local xPlayer, resellPrice = QBCore.Functions.GetPlayer(src), price
    
            if not resellPrice then
                cb(false)
            else
                exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid AND @plate = plate', {
                    ['@citizenid'] = xPlayer.PlayerData.citizenid,
                    ['@plate'] = plate
                }, function(result)
                    if result[1] then -- does the citizenid match?
                        local vehicle = json.decode(result[1].vehicle)
                        if vehicle.model == model then
                            if vehicle.plate == plate then
                                xPlayer.Functions.AddMoney('bank', resellPrice)
                                RemoveOwnedVehicle(plate)
                                TriggerEvent('DiscordBot:ToDiscord', 'aracalma', vehicle.carName..' - '..resellPrice ..'(Arkaya Araç Sattı!)', src)
                                local vehicleCategory = getVehicleCategoryToHash(vehicle.model)
                                QBCore.Shared.Vehicles[vehicleCategory][vehicle.model].count = QBCore.Shared.Vehicles[vehicleCategory][vehicle.model].count + 1
                                TriggerEvent("qb-core:set-car-count", vehicleCategory, vehicle.model, QBCore.Shared.Vehicles[vehicleCategory][vehicle.model].count)
                                cb(true)
                            else
                                cb(false)
                            end
                        else
                            cb(false)
                        end
                    else
                        cb(false)
                    end
                end)
            end
    
        end
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:isPlateTaken', function(source, cb, plate)
        exports.ghmattimysql:execute('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(result)
            cb(result[1] ~= nil)
        end)
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:retrieveJobVehicles', function(source, cb, type)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid AND type = @type AND job = @job', {
            ['@citizenid'] = xPlayer.PlayerData.citizenid,
            ['@type'] = type,
            ['@job'] = xPlayer.PlayerData.job.name
        }, function(result)
            cb(result)
        end)
    end)
    
    RegisterNetEvent('esx_vehicleshop:setJobVehicleState')
    AddEventHandler('esx_vehicleshop:setJobVehicleState', function(plate, state)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        exports.ghmattimysql:execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
            ['@stored'] = state,
            ['@plate'] = plate,
            ['@job'] = xPlayer.PlayerData.job.name
        })
    end)
    
    QBCore.Functions.CreateCallback('esx_vehicleshop:bugraDurum', function(source, cb)
        cb(bugraDurum)
    end)
    
    RegisterServerEvent("esx_vehicleshop:bugraDurumDuzenle")
    AddEventHandler("esx_vehicleshop:bugraDurumDuzenle", function(durum, key)
        if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
            bugraDurum = durum
        end
    end)
    
    QBCore.Commands.Add("sekle", "Araç Stoğunu Düzenle", {{name="model", help="Araç Model Adı"},{name="adet", help="Yeni Adet Sayısı"}}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
        if args[1] and args[2] then
            if type(tonumber(args[2])) == "number" then
                local sCarHash = GetHashKey(args[1])
                for category, data in pairs(QBCore.Shared.Vehicles) do
                    for carHash, cData in pairs(data) do
                        if carHash == sCarHash then
                            QBCore.Shared.Vehicles[category][sCarHash].count = tonumber(args[2])
                            TriggerEvent("qb-core:set-car-count", category, sCarHash, tonumber(args[2]))
                            TriggerClientEvent("QBCore:Notify", source, "Araç Adeti Değiştirildi")
                            TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/sekle '..args[1]..' '..args[2], source)
                            break
                        end
                    end
                end
            else
                TriggerClientEvent("QBCore:Notify", source, "Girdiğiniz Araç Adeti Değeri Bir Sayı Olmalıdır!", "error")
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Araç Modeli veya Adeti Boş Olamaz!", "error")
        end
    end, "admin")
    
    end)