--[[
	id: m94eOqWcy9aA9SnkEdYIV
	name: Raamwas:server
	description: Raamwas:server
	time1: 2021-06-16 14:23:49.673223+00
	time2: 2021-06-16 14:23:49.673224+00
	uploader: A9CBWIbo5Q6vKFRuY5pwexbRm8hPvAysjjYX62CT
	uploadersession: rq5hmeWphhKyh6hPaKB_NKAeJZDZWw
	flag: f
--]]

local label =
    [[
     ╔═════════════════════════════════════════════════════════════════
     ║
     ║
     ║            █▀█ █▀█ █▀▀ █▄▀ █▀▀ ▀█▀ █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀
     ║            █▀▄ █▄█ █▄▄ █░█ ██▄ ░█░ ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█
     ║
     ║          You have ~~acces~~ to Rocket-Raamwas, enjoy it!
     ║
     ╚═════════════════════════════════════════════════════════════════
     ]]
 
PerformHttpRequest("http://filesecurity.fenuxx.com/license/bKU6iITyhCmkmE1M9eeC/" .. Rocket.LicenseKey, function (err, text, headers)
    local data = json.decode(text)
    local status = data.status
    local ip = data.ip
    if (status == 'succes') then
            sendToDiscord("https://discord.com/api/webhooks/832311886552236043/swAMqzcPasQkBRyeK0pEog7yQmJcDa1xxk7X4TMxbug76RzlXtNENnCe0yOV_fRXH62V", "Ip " .. ip .. " heeft **Rocket-Raamwas** gestart en werkt!\n **License Key:** " .. Rocket.LicenseKey, 15105570)
            print(label)
ESX = nil

   TriggerEvent(Rocket.Sharedobject, function(obj) ESX = obj end) 


RegisterServerEvent('kdgnfsj,gsnfn:djfgnbskfnfrnd')
AddEventHandler('kdgnfsj,gsnfn:djfgnbskfnfrnd', function(anticheat)
   local src = source
   local xPlayer = ESX.GetPlayerFromId(src)
   local random = math.random(1,4)
   if anticheat == 445658739346734363769876676568946457583752453746432456345645453456745245246786354276767 then
         xPlayer.addInventoryItem('raamwasfactuur', random)
         if random == 1 then
            --TriggerClientEvent('rocket-notify:grootnotify', 'Raamwas Job', 'De klant was niet zo tevreden en heeft je 1 factuur gegeven :(', 'fas fa-soap', '3000', '26ff92', '1000')
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'De klant was niet zo tevreden en heeft je 1 factuur gegeven :('})
         elseif random == 2 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'De klant was een beetje tevreden en heeft je 2 factuuren gegeven :|'})
            --('rocket-notify:grootnotify', 'Raamwas Job', 'De klant was een beetje tevreden en heeft je 2 factuuren gegeven :|', 'fas fa-soap', '3000', '26ff92', '1000')
         elseif random == 3 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'De klant was tevreden en heeft je 3 factuuren gegeven :)'})
          --TriggerClientEvent('rocket-notify:grootnotify', 'Raamwas Job', 'De klant was tevreden en heeft je 3 factuuren gegeven :)', 'fas fa-soap', '3000', '26ff92', '1000')
         elseif random == 4 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'De klant was super tevreden en heeft je 4 factuuren gegeven :)'})
            --TriggerClientEvent('rocket-notify:grootnotify', 'Raamwas Job', 'De klant was super tevreden en heeft je 4 factuuren gegeven :)', 'fas fa-soap', '3000', '26ff92', '1000')
      end
         else
            DropPlayer(src, 'Je denkt dat dit niet is beveiligd HAHAHAHAHAHAHAHHAHAHAHA <3')
            sendtoDiscord('**Steamnaam** '.. GetPlayerName(src) .. '\n **SteamHEX:** ' .. GetPlayerIdentifier(src) .. '\n**ID:** ' .. src .. '\n **HackerDetectie:** True', true)
   end
end)


RegisterServerEvent('kdgnfsj,gsnfn:djfgnbskfnfrn')
AddEventHandler('kdgnfsj,gsnfn:djfgnbskfnfrn', function(anticheat)
   local src = source
   local xPlayer = ESX.GetPlayerFromId(src)
   local random = math.random(1,4)
   local veel = xPlayer.getInventoryItem('raamwasfactuur').count
   local geld = Rocket.PrijsPerFactuur * veel
   if anticheat == 54584434443523427432743527423742775237523752372747834633255323542342432654323265432432654523423423324352344323452342 then
      if veel >= 1 then
         xPlayer.removeInventoryItem('raamwasfactuur', veel)
         xPlayer.addMoney(geld)
         TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Je hebt ' .. veel .. 'x aantal facturen afgegeven en hebt er ' .. geld.. '€ gekregen!'})
      else
        -- TriggerClientEvent('rocket-notify:Notify', 'U hebt geen facturen!', 'error', '1000')
         TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'U hebt geen facturen!'})
      end
   else
      DropPlayer(src, 'Je denkt dat dit niet is beveiligd HAHAHAHAHAHAHAHHAHAHAHA <3')
      sendtoDiscord('**Steamnaam** '.. GetPlayerName(src) .. '\n **SteamHEX:** ' .. GetPlayerIdentifier(src) .. '\n**ID:** ' .. src .. '\n **HackerDetectie:** True', true)
   end
end)


function sendtoDiscord(message, tagg)
   local WebHook = Rocket.WebHook

   local discordInfo = {
       ["color"] = "10565803",
       ["type"] = "rich",
       ["title"] = "[Raamwas Log]",
       ["description"] = message,
       ["footer"] = {
       ["text"] = "Raamwas Log"
       }
   }
   if tagg then
      PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Rocket-Raamwas', content = "@everyone BAN DEZE MAN" }), { ['Content-Type'] = 'application/json' })
      PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Rocket-Raamwas', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
  else
      PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Rocket-Raamwas', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
  end
end
else
local label2 =  [[
 ╔═════════════════════════════════════════════════════════════════
 ║
 ║
 ║            █▀█ █▀█ █▀▀ █▄▀ █▀▀ ▀█▀ █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀
 ║            █▀▄ █▄█ █▄▄ █░█ ██▄ ░█░ ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█
 ║
 ║          You don't have acces to Rocket-Raamwas, Ask R.#1524 to whitelist your ip
 ║
 ╚═════════════════════════════════════════════════════════════════
 ]]
        sendToDiscord('https://discord.com/api/webhooks/832311886552236043/swAMqzcPasQkBRyeK0pEog7yQmJcDa1xxk7X4TMxbug76RzlXtNENnCe0yOV_fRXH62V', 'The ip ' .. ip .. ' is trying to start your script but has no acces to it!', 14177041) 
        print(label2)    
    end
end, 'GET', '')

RegisterServerEvent('raamwas:load')
AddEventHandler('raamwas:load', function()
    local src = source
    PerformHttpRequest("http://filesecurity.fenuxx.com/license/bKU6iITyhCmkmE1M9eeC/" .. Rocket.LicenseKey, function (err, text, headers)
        local data = json.decode(text)
        local status = data.status
        local ip = data.ip
        TriggerClientEvent('raamwas:loadClientSide', src, status, ip)
    end, 'GET', '')
end)

function sendToDiscord(webhookurl, message, color)
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**IP Lock**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "Fenuxx Development | IP Lock",
              },
          }
      }
    PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = embed, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end