--[[
	id: W_Z7sYdFJVbkYZS5LQx_A
	name: client
	description: .
	time1: 2021-07-10 11:15:16.211419+00
	time2: 2021-07-10 11:15:16.211419+00
	uploader: mZn7F0dj22BsLDmzW6tnvE8OJu4ywZw2R6QpUY3O
	uploadersession: QmPvWHMdliGnIioI85XGH3AK4j-FSW
	flag: f
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('deep_support:getReport')
AddEventHandler('deep_support:getReport', function(text, name)
    TriggerClientEvent('deep_support:sendReport', -1, text, name)
end)

ESX.RegisterServerCallback('deep_support:getGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    if group ~= nil then
        if group == 'superadmin' or group == 'admin'  or group == 'mod'  or group == 'support'  or group == '_dev' then
            cb(true)
        end
    end

end)

local tokenlegit = false
local globalip1 = nil
local globalip2 = nil
local scriptname = GetCurrentResourceName()
local webhook = "https://discord.com/api/webhooks/857966308209852436/2SFY2VXE6cVoP0iBdDhUKc5xaEtul3lx7bFNVFZBimcFvc-Ka4PepBC8OkuAWswdsG4J" -- PUT YOUR DISCORD WEBHOOK URL IN HERE

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
                    if tokenid == ip1 and product == "Script-Lock-1" then -- DO NOT CHANGE ANYTHING IN THIS LINE
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
                                print("[Deep Development] Deine IP wurde zugelassen. Viel spaß!")
                                TriggerClientEvent('deep_support:ipyes', -1)
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
                            print("[Deep Development] Deine IP wurde zugelassen. Viel spaß!")
                            TriggerClientEvent('deep_support:ipyes', -1)
                            tokenlegit = true
                        end
    
                        if v.isAdmin == "1" then
                            tokenlegit = true
                            print("[Deep Development] Du hast eine Admin-Lizenz!")
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
            print("[Deep Development] Deine IP wurde NICHT zugelassen. discord.gg/deep für Support!")
            TriggerClientEvent('deep_support:ipno', -1)
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
                --os.exit(1)
             end)
             return;
        end
    end
end)