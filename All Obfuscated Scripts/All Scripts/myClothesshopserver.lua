--[[
	id: 4Bh1jrGweGl3fsMLCiaC8
	name: myClothesshop server
	description: just some testing
	time1: 2021-06-24 10:14:21.008984+00
	time2: 2021-06-24 10:14:21.008985+00
	uploader: e-D5uMFGF0SkdELlu7MimbXF5AdCmdzacWpQPOAJ
	uploadersession: SxFcRTKY26-2lkTDRO013s5Ben7Tt0
	flag: f
--]]

-- IP LOCK --

local tokenlegit = false
local globalip1 = nil
local globalip2 = nil
local scriptname = GetCurrentResourceName()
local webhook = "https://discord.com/api/webhooks/857684255910658058/u4cCvBY2k8flWKilsw0VyLySe-qXlDmuz92wSBcV2W7sBhnppw_Yg8yfB1yjGtfgyoI7" -- PUT YOUR DISCORD WEBHOOK URL IN HERE

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.CreateThread(function()
            Citizen.Wait(1000)

            PerformHttpRequest('https://api.script-lock.eu/v2/endpoint.php', function(err, text, headers) -- DO NOT CHANGE ANYTHING IN THIS LINE
                local text2 = json.decode(text)

                for _,v in pairs(text2.results) do
                    local tokenid = v.tokenid
                    local product = v.product
                    local ip1 = v.client_ip
                    globalip1 = v.client_ip
                    if tokenid == ip1 and product == "Script-Lock" then -- DO NOT CHANGE ANYTHING IN THIS LINE
                        if v.isBanned == "1" then
                            tokenlegit = false
                            print("Your account is banned. Reason:")
                            break
                        end
        
                        if v.time ~= "-1" then
                            if v.time == "0" then
                                tokenlegit = false
                                print("Your subscribtion ended")
                                break
                            else
                                local dataee = {
                                    {
                                        ["color"] = "3145472",
                                        ["title"] = "Client access allowed!",
                                        ["description"] = "IP: **"..globalip1.."**\n Script: **"..scriptname.."**\n Action: **Allowed**",
                                    }
                                }
                        
                                PerformHttpRequest(
                                webhook,
                                function(error, texto, cabeceras)
                                end,
                                "POST",
                                json.encode({username = "Script-Lock Logs", embeds = dataee}),
                                {["Content-Type"] = "application/json"}
                                )
                                print("IP authentification succeeded. Thanks for using myClothesshop")
                                print("Days left: " .. v.time)
                                tokenlegit = true
                            end
                        else
                            local dataeaa = {
                                {
                                    ["color"] = "3145472",
                                    ["title"] = "Client access allowed!",
                                    ["description"] = "IP: **"..globalip1.."**\n Script: **"..scriptname.."**\n Action: **Allowed**",
                                }
                            }
                    
                            PerformHttpRequest(webhook, function(error, texto, cabeceras) end, "POST", json.encode({username = "Script-Lock Logs", embeds = dataeaa}), {["Content-Type"] = "application/json"})
                            print("IP authentification succeeded. Thanks for using myClothesshop")
                            tokenlegit = true
                        end
    
                        if v.isAdmin == "1" then
                            tokenlegit = true
                            print("You have an Admin License")
                        end
                        
                        if v.note ~= "None" then
                            print(v.note)
                        end

                    end


                end
                Wait(1000)
                finished = true
        
            end, 'GET', json.encode({tokenid = token, used = "1"}), { ['Content-Type'] = 'application/json' }) -- DO NOT CHANGE ANYTHING IN THIS LINE
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if tokenlegit == false and finished == true then
            print("YOUR IP IS NOT ALLOWED TO USE THIS SCRIPT.")
            ------------------------------------------
            local datae = {
                {
                    ["color"] = "16711680",
                    ["title"] = "Client access denied!",
                    ["description"] = "IP: **"..globalip1.."**\n Script: **"..scriptname.."**\n Action: **Denied**",
                }
            }
            PerformHttpRequest(webhook, function(error, texto, cabeceras) end, "POST", json.encode({username = "Script-Lock Logs", embeds = datae}), {["Content-Type"] = "application/json"})
            -----------------------------------------
            Citizen.SetTimeout(3000, function()
                os.exit(1)
             end)
             return;
        end
    end
end)




ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('myClothesshop:buy')
AddEventHandler('myClothesshop:buy', function()

    local xPlayer = ESX.GetPlayerFromId(source)


    if xPlayer.getMoney() >= Config.Price then

        TriggerClientEvent('myClothesshop:confirm', source, true)
        xPlayer.removeMoney(Config.Price)

    else
        TriggerClientEvent('myClothesshop:confirm', source, false)
    end

end)

ESX.RegisterServerCallback('myClothesshop:checkHavePropertyStore', function(source, cb)

  local found = false
  local xPlayer = ESX.GetPlayerFromId(source)
	
	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		found = true
	end)

	cb(found)

end)

RegisterServerEvent('myClothesshop:saveOutfit')
AddEventHandler('myClothesshop:saveOutfit', function(label, skinRes)

  local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skinRes
		})

		store.set('dressing', dressing)

	end)

end)

ESX.RegisterServerCallback('myClothesshop:getPlayerOutfit', function(source, cb, num)

  local xPlayer  = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local outfit = store.get('dressing', num)
    cb(outfit.skin)
  end)

end)

RegisterServerEvent('myClothesshop:removeOutfit')
AddEventHandler('myClothesshop:removeOutfit', function(index)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

        local dressing = store.get('dressing')

        if dressing == nil then
            dressing = {}
        end

        index = index
        
        table.remove(dressing, index)

        store.set('dressing', dressing)

    end)

end)

ESX.RegisterServerCallback('myClothesshop:getPlayerDressing', function(source, cb)

  local xPlayer  = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

    local count    = store.count('dressing')
    local labels   = {}

    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(labels, entry.label)
    end

    cb(labels)

  end)

end)

RegisterServerEvent('skin:save')
AddEventHandler('skin:save', function(skin)

  local xPlayer = ESX.GetPlayerFromId(source)
	
--print(steamID)
  MySQL.Async.execute(
    'UPDATE users SET `skin` = @skin WHERE identifier = @identifier',
    {
      ['@skin']       = json.encode(skin),
      ['@identifier'] = xPlayer.identifier
    }
  )

end)