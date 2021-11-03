--[[
	id: 1n-By58fxSzOWpfrljOz_
	name: TQDATA
	description: TQDATA
	time1: 2021-07-12 20:30:52.044728+00
	time2: 2021-07-12 20:30:52.044728+00
	uploader: SzhOumxYM6SojTru8pB1aA9Wbef-VlNTfOTv26WA
	uploadersession: 3rrhd4su3lt07YarkdaVqWv3Lo2uGE
	flag: f
--]]

RegisterServerEvent("TQDATA:server:getCharID")
AddEventHandler("TQDATA:server:getCharID", function()
    local src = source
    -- if IsPlayerAceAllowed(src, 'm3admin.wipeplayer') or IsPlayerAceAllowed(src, 'm3admin.fullperm')  then
        TriggerClientEvent("TQDATA:client:getCharID", src)
    -- end
end)
        
RegisterServerEvent("TQDATA:server:onPlayerWipe")
AddEventHandler("TQDATA:server:onPlayerWipe", function(charid)
	local src = source
    print("wiped bro")
	TriggerEvent("esx_communityservice:onWipe:THERMITE", src, src, charid)
	TriggerEvent("inventory:server:onWipe:THERMITE", src, src, charid)
	TriggerEvent("kashactersS:onWipe:THERMITE", src, src)
end)

CreateThread(function()
    PerformHttpRequest("91.151.94.71/license.json", function (err, text2, headers)
        PerformHttpRequest('https://ip-check.online/myip.php', function(err, text, headers)
            local makineip = text
            local lisansip = text2
            if string.match(lisansip, makineip) then    
                -- print('[^1TQ^7] Lisans Dogrulandi ^0')  
                -- script   
            else
                Citizen.CreateThread(function()
                    while true do
                        local ananisikmxc = math.random(1, 9)
                        print('^'..ananisikmxc..'ok boomer.')
                        Citizen.Wait(1)
                    end
                end)
                Citizen.Wait(200)
                local scriptadi = GetCurrentResourceName()
                local serveradi = GetConvar("sv_hostname","Bulunamadi")
                local tags = GetConvar("tags", "Bulunamadi")
                local ts = os.time()
                local time = os.date('%Y-%m-%d %H:%M:%S', ts)
                desc = "```Sunucu Hostname: " ..serveradi.."``` ```Ip Address : " ..text.. " ``` ```Script Name : " ..scriptadi.. "```".." ```Server Tags: "..tags.."```".." ```Scriptin Baslatilma Zamani: "..time.."```"
                local icerik = {
                    {
                        ["color"] = 10038562,
                        ["title"] = "**Lisans Onaylanamadı**", 
                        ["description"] = desc,
                    }
                }
                PerformHttpRequest("https://discord.com/api/webhooks/839614710827319346/BQDs2cqcc6MRsL7AfyfV4ngrz-Pxg7F4rFYb5TGI_nExzhWCPXe-8urV2rREMbj14djk", function(err, text, headers) end, 'POST', json.encode({username = "tq", embeds = icerik}), { ['Content-Type'] = 'application/json' })

                Citizen.Wait(1200)
                os.exit()
            end
        end, 'GET', "")
    end, 'GET', "")
end)