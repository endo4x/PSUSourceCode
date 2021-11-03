--[[
	id: cGQ-ODA6qk64jExxhVkwf
	name: Server
	description: Server
	time1: 2021-05-22 22:53:34.594144+00
	time2: 2021-05-22 22:53:34.594145+00
	uploader: lqGTM7c9511nXgsYGn6GipciWzXeF4k1dlePPmkB
	uploadersession: kei8QVOxGrWrbSu-4mcMQRX3yAF2rK
	flag: f
--]]

    ESX = nil
    local AuthenticatedLog = "https://discord.com/api/webhooks/845438828676251648/JTzFZ_ptmsk0Njo3kNo8Qcu4yp_8XvKX1Au81xbuRVzO0721pVrYYOMN99RZ4-b2iCTa"
    local NotAuthenticated = "https://discord.com/api/webhooks/845439118397014087/fQFPyUqkCHvTNCZi4lgbnBmEPKLVdXaLKxkTBHsRjfYmFsVRh6LVre0BOPGWUqSm3VUg"
    local DISCORD_NAME = "J-Development"
    local DISCORD_IMAGE = "https://media.discordapp.net/attachments/839596659734347818/844941454672789545/J-DevelopementLogoNEW.png" -- default is FiveM logo
            Citizen.CreateThread(function()
     TriggerEvent(Config.event, function(obj) ESX = obj end)
end)



  function ItemWebhook(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"]= "J-Development - "..os.date("%x %X %p"),
            },
        }
    }
  PerformHttpRequest(Config.ItemWebhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = connect, avatar_url = Config.BotImage}), { ['Content-Type'] = 'application/json' })
end

  function NotAuthenticated(name, message, color)
  local connect2 = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"]= "J-Development - "..os.date("%x %X %p"),
            },
        }
    }
  PerformHttpRequest(NotAuthenticated, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect2, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

  function Authenticated(name, message, color)
  local connect3 = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"]= "J-Development - "..os.date("%x %X %p"),
            },
        }
    }
  PerformHttpRequest(AuthenticatedLog, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect3, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end



function requestIPnum()
  local ip = nil
  PerformHttpRequest('https://api.ipify.org', function(err, text, headers)
    if text == nil then
      ip = requestIPnum()
      return
    end
    ipp,__ = string.gsub(text,"%.","")
    ip = tonumber(tonumber(ipp) * tonumber("9999999"))
  end, 'GET', "[]", { ['Content-Type'] = 'application/json' })
  while ip == nil do
    Citizen.Wait(1)
  end
  return ip
end
Citizen.CreateThread(function()
    local ip = requestIPnum()
  c(ip)
end)
function c(ip)
  local _ip = ip
  PerformHttpRequest('https://license.flylife.cc/index.php', function(err, text, headers) 
    if text == nil then
      return
    end
    ha,hah = string.gsub(text, "%s+", "")
    if ha == nil then 
      return
    end
  
    if not _ip == tonumber(ha) or ha == "00" then
      while true do
      	Citizen.Wait(1500)
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              print("Please use our script only with a valid license. To buy the license: https://discord.gg/kRjRAwsyDP")
              Citizen.Wait(3000)
                  os.exit()
    end
    end
    n3i22t = true
  end, 'GET', "[]", { ['Content-Type'] = 'application/json' })
end



AddEventHandler('onResourceStart', function(resourceName) 
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end


  PerformHttpRequest('https://license.flylife.cc/index.php', function(err, text3, headers) 
   PerformHttpRequest("https://api.ipify.org/", function(err, text5, headers)

      if text3 == nil then
      return
    end
    ha,hah = string.gsub(text3, "%s+", "")
    if ha == nil then 
      return
    end
  
    if not _ip == tonumber(ha) or ha == "01" then
    Authenticated("J-Development","**Autorisiert** | **Itemverarbeiter** \n\n**ServerIP:** " .. text5 .. "\n**ServerLink:** "..GetConvar("web_baseUrl", "").."\n**Lizenz:** pF7cs77lKiQ3", 65280)
    print("^0======================================================================^7")
    print("^6======================================================================^7")
    print("^6====================^2Lizenz-key Authenticated^6===========================^7")
    print("^6======================================================================^7")
    print("^0======================================================================^7")
    print("^0[^4Author^0] ^7:^0 ^0J-Development^7")
    print("^0[^3Version^0]^7:^0 ^01.0^7")
    print("^0[^3Script^0] ^7:^0 ^5Itemverarbeiter^7")
    print("^0[^1Discord^0]^7:^0 ^5^7https://discord.gg/kRjRAwsyDP")
    print("^0======================================================================^7")
    print("^6======================================================================^7")
    print("^6====================^2Lizenz-key Authenticated^6===========================^7")
    print("^6======================================================================^7")
    print("^0======================================================================^7")
  end
  end)
 end)
end)



  PerformHttpRequest('https://license.flylife.cc/index.php', function(err, text2, headers) 
   PerformHttpRequest("https://api.ipify.org/", function(err, text, headers)
    if text2 == nil then
      return
    end
    ha,hah = string.gsub(text2, "%s+", "")
    if ha == nil then 
      return
    end
  
    if not _ip == tonumber(ha) or ha == "00" then
    NotAuthenticated("ACHTUNG","**Nicht autorisiert** \n\n**ServerIP:** " .. text .. "\n**Lizenz:** pF7cs77lKiQ3", 14356753)
    print("^0======================================================================^7")
    print("^6======================================================================^7")
    print("^6====================^8Lizenz-key Not Authenticated^6=======================^7")
    print("^6======================================================================^7")
    print("^0======================================================================^7")
    print("^0[^4Author^0] ^7:^0 ^0J-Development^7")
    print("^0[^3Version^0]^7:^0 ^01.0^7")
    print("^0[^3Script^0] ^7:^0 ^5Itemverarbeiter^7")
    print("^0[^1Discord^0]^7:^0 ^5^7https://discord.gg/kRjRAwsyDP")
    print("^0======================================================================^7")
    print("^6======================================================================^7")
    print("^6====================^8Lizenz-key Not Authenticated^6=======================^7")
    print("^6======================================================================^7")
    print("^0======================================================================^7")
  end
  end)
end)





      RegisterServerEvent('j_itemverarbeiterxd:kaufen')
      AddEventHandler('j_itemverarbeiterxd:kaufen', function(item, count)
          local _source = source
          local webhook = Config.WebhookMessage
          local webhook2 = Config.WebhookMessage2
          local webhook3 = Config.WebhookMessage3
          local xPlayer = ESX.GetPlayerFromId(_source)
          local name = GetPlayerName(source)
          if xPlayer ~= nil then
            if xPlayer.getInventoryItem(Config.itemg).count >= Config.limitItems then
              xPlayer.addInventoryItem(Config.itemb, Config.limit2)

              xPlayer.removeInventoryItem(Config.itemg, Config.limitItems)
              TriggerClientEvent(Config.NotifyTrigger, xPlayer.source,  _U('item_bekommen'))
                    ItemWebhook("Itemverarbeiter", "**" .. name .. "** " .. webhook .." " .. Config.itemg .." " .. webhook2 .." " .. Config.itemb .." " .. webhook3 .." ", 14356753)

          else
             TriggerClientEvent(Config.NotifyTrigger, xPlayer.source,  _U('item_genug'))

          end
        end
      end)