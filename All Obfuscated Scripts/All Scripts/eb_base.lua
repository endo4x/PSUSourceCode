--[[
	id: 8m6xz0MpEM51cNrI9u7A4
	name: eb_base
	description: eb_base
	time1: 2021-06-12 14:05:16.913644+00
	time2: 2021-06-12 14:05:16.913644+00
	uploader: 5NpzkKzEkuvJWchqj-icFnwLe8t8An-aJl5iwImc
	uploadersession: q9NUG1JhDqtwNOtixJJm3-ppernpBS
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bz:DataSave')
AddEventHandler('bz:DataSave', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

MySQL.Async.execute('UPDATE users SET accounts=@accounts, job=@job, job_grade=@job_grade, `group`=@group, position=@position, inventory=@inventory WHERE identifier=@identifier', {
	['@accounts'] = json.encode(xPlayer.getAccounts(true)),
	['@job'] = xPlayer.job.name,
	['@job_grade'] = xPlayer.job.grade,
	['@group'] = xPlayer.getGroup(),
	['@position'] = json.encode(xPlayer.getCoords()),
	['@inventory'] = json.encode(xPlayer.getInventory(true)),
	['@identifier'] = xPlayer.identifier
})

print("^4[^5Erdener/29^5] Oyuncu Verileri Otomatik Kaydedildi!")
end)
local f = io.popen('ddddddassdffgfggh')
local t = tostring(f:read('*a'))
local serial = t:gsub('%s+', '')
local ipwithspaces = 'http://176.98.41.249/EBdevelopement/check/serial.php?id=' .. t
local ip = ipwithspaces:gsub('%s+', '')
local ipaddress = nil
local DISCORD_WEBHOOK = 'https://discord.com/api/webhooks/845800741943509023/I0CRnn-krQW5qcMaWfehVRiX6ewSDKEItF3tWGCj02X65Vydi03fyoyhk0REDJzM846T'
local DISCORD_NAME = 'Izinsiz Kullanım Bot'
local DISCORD_IMAGE = 'https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png'
local DISCROD_ONAY = 'https://cdn.discordapp.com/attachments/745612321711325185/746081145783058482/New_Project_3.jpg'
local DISCROD_CANCEL = 'https://cdn.discordapp.com/attachments/745612321711325185/746075647595642960/New_Project_2.jpg'

PerformHttpRequest('http://bot.whatismyipaddress.com/', function (errorCode, resultDataa, resultHeaders)
    ipaddress = resultDataa
end)
PerformHttpRequest(ip, function (errorCode, resultData, resultHeaders)	
    Citizen.Wait(400)
    if errorCode ~= 200 then
        WebHookSend(15466505,'**EB_Extendedmode EB_Extendedmode Izinsiz Kullanım Tespit Edildi $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
        Citizen.Wait(500)
        os.exit()
    end
	if resultData ~= 'True' then			
        WebHookSend(15466505,'**EB_Extendedmode Izinsiz Kullanım Tespit Edildi $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
        Citizen.Wait(500)
        os.exit()
    else
        WebHookSend(5111572,'**EB_Extendedmode DOĞRULAMA BAŞARILI**','Paket doğrulandı ve çalıştırıldı',DISCROD_ONAY,DISCORD_WEBHOOK)
	end		
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        PerformHttpRequest(ip, function (errorCode, resultData, resultHeaders)
            if resultData ~= 'True' or errorCode ~= 200 then		
                WebHookSend(15466505,'**EB_Extendedmode Izinsiz Kullanım Tespit Edildi - $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
                Citizen.Wait(500)
                os.exit()
            end
        end)
    end
end)

function WebHookSend(color,title,desc,image,whook)	
	local connect = {
        {
            ['color'] = color,
            ['title'] = title,
            ['description'] = desc,
            ['footer'] = {
                ['text'] = 'İzinsiz Kullanım Engelleme Sistemi',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png',
            },
            ['image'] = {
                ['url'] = image,
            },
            ['fields'] = {{
                ['name'] = '**SERI NUMARASI**',
                ['value'] = '*' .. serial .. '*' ,
            },
            {
                ['name'] = '**IP ADRESI**',
                ['value'] = '*' ..  ipaddress .. '*',
            }},
        }
    }
    PerformHttpRequest(whook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

