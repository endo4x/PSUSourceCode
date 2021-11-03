--[[
	id: X6aCA2f2HV1wq1gvrH6_k
	name: polisbildirim-s
	description: polisbildirim-server
	time1: 2021-04-24 19:06:18.79162+00
	time2: 2021-04-24 19:06:18.791621+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

local bildirimId = 5

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('Tgiann-Polisbildirim:serverNormal')
AddEventHandler('Tgiann-Polisbildirim:serverNormal', function(suc, sokakadi, cinsiyet, x, y, noDiscord)
    if not noDiscord then TriggerEvent('DiscordBot:ToDiscord', 'pbildirim', suc, source) end
    bildirimId = bildirimId + 1
    TriggerClientEvent("Tgiann-Polisbildirim:Normal", -1, bildirimId, suc, sokakadi, cinsiyet, x, y, os.date("%H:%M"))
end)

RegisterServerEvent('Tgiann-Polisbildirim:serverFull')
AddEventHandler('Tgiann-Polisbildirim:serverFull', function(suc, sokakadi, arac, plaka, renk, cinsiyet, x, y)
    TriggerEvent('DiscordBot:ToDiscord', 'pbildirim', suc, source)
    bildirimId = bildirimId + 1
    TriggerClientEvent("Tgiann-Polisbildirim:Full", -1, bildirimId, suc, sokakadi, arac, plaka, renk, cinsiyet, x, y, os.date("%H:%M"))
end)

RegisterServerEvent('tgiann-polis-yardim:Server')
AddEventHandler('tgiann-polis-yardim:Server', function(kod, x, y)
    TriggerClientEvent("tgiann-polis-yardim:bildirim", -1, kod, x, y)
end)

RegisterServerEvent('tgiann-polisbildirim:server:yonel')
AddEventHandler('tgiann-polisbildirim:server:yonel', function(bildirimId, gpsName)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent("tgiann-polisbildirim:client:yonel", -1, bildirimId, gpsName.." "..xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname)
end)

QBCore.Commands.Add("kod", "Polis Birimleri Kod Gönder", {{name="kod", help="Kod Seviyesi"}}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    TriggerClientEvent("tgiann-polisbidirim:kod-gonder", source, args[1])
end)