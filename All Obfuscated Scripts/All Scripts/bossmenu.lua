--[[
	id: zJetatcEQlu8RXZG51wVf
	name: bossmenu
	description: server-side
	time1: 2021-05-23 03:01:28.451782+00
	time2: 2021-05-23 03:01:28.451783+00
	uploader: pomU5ZHdYsjiW7IQRZ9Ow0grNWYy6qhp9lboTjvz
	uploadersession: 3hg6TA53Lrz7TrrmwkUpwUuRnnU0PQ
	flag: f
--]]

-- NZ-DEV

QBCore = nil

TriggerEvent(Config.Core, function(obj) QBCore = obj end)

society = {}

local fatturaInattesa = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        print('---------------------------------------------------')
        print('BOSSMENU BY NZ-DEVELOPMENT IS SUCCESSFULLY STARTED!')
        print('discord.io/nzshop')
        print('ENJOY!')
        print('---------------------------------------------------')
    end
end)

RegisterNetEvent('nz-bossmenu:ChiediFattura')
AddEventHandler('nz-bossmenu:ChiediFattura', function(id, reason, amount, cb)
    local _source = source

    fatturaInattesa[id] = {senderId = _source, reason = reason, amount = amount}

    TriggerClientEvent('nz-bossmenu:ChiediFattura', id, reason, amount)
end)

RegisterNetEvent('nz-bossmenu:rispondiFattura')
AddEventHandler('nz-bossmenu:rispondiFattura', function(hasAccepted) 
    local _source = source

    if(fatturaInattesa[_source]) then

        TriggerClientEvent('nz-bossmenu:rispondiFattura', fatturaInattesa[_source].senderId, hasAccepted, _source, fatturaInattesa[_source].reason, fatturaInattesa[_source].amount)

        fatturaInattesa[_source] = nil
    end
end)

QBCore.Functions.CreateCallback('nz-bossmenu:trovaTargetFattura', function(source, cb, target)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(target))
    local Target = OtherPlayer.PlayerData.citizenid

    if Player then
        QBCore.Functions.ExecuteSql(false, "SELECT amount, invoiceid, reason, societylabel  FROM phone_invoices WHERE `citizenid` = '"..Target.."'", function(result)
            cb(result)
        end)
    else
        cb({})
    end
end)

RegisterServerEvent("nz-bossmenu:ControllaSoldiSocietaEvento")
AddEventHandler("nz-bossmenu:ControllaSoldiSocietaEvento", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local societa = Player.PlayerData.job.name
    if Player then
        QBCore.Functions.ExecuteSql(false, "SELECT amount FROM society_invoice WHERE `society` = '"..societa.."'", function(result)
            print(result)
            cb(result)
        end)
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback('nz-bossmenu:controllaSoldiSocieta', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local societa = Player.PlayerData.job.name

    if Player then
        QBCore.Functions.ExecuteSql(false, "SELECT amount FROM society_invoice WHERE `society` = '"..societa.."'", function(result)
            cb(result)
        end)
    else
        cb({})
    end
end)


RegisterNetEvent('nk_bossmenu:DepositaSoldiSocieta')
AddEventHandler('nk_bossmenu:DepositaSoldiSocieta', function(amount, societa, tota, importosocieta)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local nuovosaldo = importosocieta + amount
    local msg = string.format(Config.language["have_deposited"], amount, nuovosaldo)

        QBCore.Functions.ExecuteSql(false, "UPDATE society_invoice SET amount = '"..importosocieta + amount.."' WHERE society = '"..societa.."'")

        xPlayer.Functions.RemoveMoney('cash', amount)
        TriggerEvent("qb-log:server:CreateLog", "deposito-società", "DEPOSITO SOCIETA'", "green", GetPlayerName(source).."["..source.."] Ha Depositato: ``"..amount.."$`` Nella Società: ****__" ..societa.."__**** ** Citizen ID : **"..xPlayer.PlayerData.citizenid.." Soldi nella società: "..importosocieta + amount.."$")
        TriggerClientEvent(Config.Notify, src, msg, 'success')
end)


RegisterNetEvent('nk_bossmenu:AggiungiSoldiSocieta')
AddEventHandler('nk_bossmenu:AggiungiSoldiSocieta', function(amount, societa, tota, importosocieta)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

        QBCore.Functions.ExecuteSql(false, "UPDATE society_invoice SET amount = '"..importosocieta + amount.."' WHERE society = '"..societa.."'")

end)

RegisterNetEvent('nk_bossmenu:PrelevaSoldiSocieta')
AddEventHandler('nk_bossmenu:PrelevaSoldiSocieta', function(amount, societa, tota, importosocieta)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local nuovosaldo = importosocieta - amount
    local msg = string.format(Config.language["have_withdraw"], amount, nuovosaldo)


       
        QBCore.Functions.ExecuteSql(false, "UPDATE society_invoice SET amount = '"..importosocieta - amount.."' WHERE society = '"..societa.."'")
        TriggerEvent("qb-log:server:CreateLog", "ritiro-società", "RITIRO SOCIETA'", "red", GetPlayerName(source).."["..source.."] Ha Ritirato: ``"..amount.."$`` Dalla Società: ****__" ..societa.."__**** ** Citizen ID : **"..xPlayer.PlayerData.citizenid.." Soldi rimanenti nella società: "..importosocieta - amount.."$")
        xPlayer.Functions.AddMoney('cash', amount)
        TriggerClientEvent(Config.Notify, src, msg, 'success')
end)


RegisterNetEvent('nk_bossmenu:UtilizzaContoSocieta')
AddEventHandler('nk_bossmenu:UtilizzaContoSocieta', function(TotalPrice, societa, tota, importosocieta)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local msg = string.format(Config.language["society_paid"], TotalPrice)
    local msg2 = string.format(Config.language["not_enough_money"])


    if TotalPrice <= importosocieta then
        QBCore.Functions.ExecuteSql(false, "UPDATE society_invoice SET amount = '"..importosocieta - TotalPrice.."' WHERE society = '"..societa.."'")
        TriggerClientEvent(Config.Notify, src, msg, 'success')
    else
        TriggerClientEvent(Config.Notify, src, msg2, 'error')
    end
end)

RegisterNetEvent('nk_bossmenu:InviaFattura')
AddEventHandler('nk_bossmenu:InviaFattura', function(aPlayer, amount, societa, reason)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(aPlayer))
    local Target = OtherPlayer.PlayerData.citizenid
    local societa = Player.PlayerData.job.name
    local societalabel = Player.PlayerData.job.label
    local msg = string.format(Config.language["invoice_received"], amount, societalabel)
    
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `phone_invoices` (`citizenid`, `amount`, `invoiceid`, `society`, `societylabel`, `reason`) VALUES ('"..Target.."', '"..amount.."', '"..CitizenId.."', '"..societa.."', '"..societalabel.."', '"..reason.."')")
    TriggerClientEvent(Config.Notify, aPlayer, msg)
end)

RegisterNetEvent('nk_bossmenu:AssumiPersonaVicina')
AddEventHandler('nk_bossmenu:AssumiPersonaVicina', function(playerId, grado, societa, societalabel)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
    local Target = OtherPlayer.PlayerData.citizenid
    local societa = Player.PlayerData.job.name
    local societalabel = Player.PlayerData.job.label
    local msg = string.format(Config.language["have_been_hired_job"], societalabel, grado)

    OtherPlayer.Functions.SetJob(societa, grado)
    TriggerClientEvent(Config.Notify, playerId, msg)
end)

RegisterNetEvent('nk_bossmenu:ReclutaPersonaVicina')
AddEventHandler('nk_bossmenu:ReclutaPersonaVicina', function(playerId, grado, gang, ganglabel)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
    local Target = OtherPlayer.PlayerData.citizenid
    local gang = Player.PlayerData.gang.name
    local ganglabel = Player.PlayerData.gang.label
    local msg = string.format(Config.language["have_been_hired_gang"], ganglabel, grado)

    OtherPlayer.Functions.SetGang(gang, grado)
    TriggerClientEvent(Config.Notify, playerId, msg)
end)


RegisterNetEvent('nk_bossmenu:LicenziaPersona')
AddEventHandler('nk_bossmenu:LicenziaPersona', function(playerId, societa, societalabel)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
    local Target = OtherPlayer.PlayerData.citizenid
    local societa = Player.PlayerData.job.name
    local societaAltroPlayer = OtherPlayer.PlayerData.job.name
    local societalabel = Player.PlayerData.job.label
    local msg = string.format(Config.language["you_have_been_fired"], societalabel)
    local msg2 = string.format(Config.language["not_part_of_your_company"])
    local msg3 = string.format(Config.language["YouAreSuccessfullyFiring"], playerId)

    if societaAltroPlayer == societa then
        OtherPlayer.Functions.SetJob('unemployed', 0)
        TriggerClientEvent(Config.Notify, playerId, msg)
        TriggerClientEvent(Config.Notify, source, msg3)
    else
        TriggerClientEvent(Config.Notify, source, msg2, 'error')
    end


end)

RegisterNetEvent('nk_bossmenu:DefazionaPersona')
AddEventHandler('nk_bossmenu:DefazionaPersona', function(playerId, gang, ganglabel)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
    local Target = OtherPlayer.PlayerData.citizenid
    local gang = Player.PlayerData.gang.name
    local gangAltroPlayer = OtherPlayer.PlayerData.gang.name
    local ganglabel = Player.PlayerData.gang.label
    local msg = string.format(Config.language["you_have_been_defaced"], ganglabel)
    local msg2 = string.format(Config.language["not_part_of_your_gang"])

    if gangAltroPlayer == gang then
        OtherPlayer.Functions.SetGang('geen', 0)
       TriggerClientEvent(Config.Notify, playerId, msg)
    else
        TriggerClientEvent(Config.Notify, source, msg2, 'error')
    end
end)

RegisterServerEvent("ControllaGang")
AddEventHandler("ControllaGang", function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.gang.name ~= 'geen' and Player.PlayerData.gang.isboss == true then
        TriggerClientEvent('ApriMenuGang:client', source)
    end
end)

QBCore.Commands.Add(Config.MenuGangCommand, Config.SuggestionGangMenu, {}, false, function(source, args)
	TriggerClientEvent('ControllaGang:client', source)
end)