--[[
	id: XvTjqKTdJPCfiFmxcGiLq
	name: emergencyblips-s
	description: emergencyblips-server
	time1: 2021-04-24 19:03:46.860524+00
	time2: 2021-04-24 19:03:46.860525+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local empActive = false
local activeBlips, activeCarsBlips = {}, {}

RegisterNetEvent('tgiann-denizalti:server:emp')
AddEventHandler('tgiann-denizalti:server:emp', function(active)
	empActive = active
    if empActive then
        TriggerClientEvent("tgiann-emerhencyblips:forceClose", -1)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local src = source 
    removeBlip(src) 
end)

RegisterNetEvent('tgiann-gps:gizli-gps-ekle')
AddEventHandler('tgiann-gps:gizli-gps-ekle', function()
	local src = source
	if empActive then 	
		TriggerClientEvent("QBCore:Notify", src, 'GPS Açılamadı', "error")
	else
		addBlip("Bilinmiyor", 39, src, 0.75, 4)
		TriggerClientEvent("QBCore:Notify", src, 'GPS Açıldı')
		TriggerClientEvent("tgiann-emergencyblips:toggle", src, true, src.."-Bilinmiyor")
        Citizen.Wait(15000)
        TriggerEvent("tgiann-gps:acikgps-kapat", false, src)
		TriggerClientEvent("tgiann-emergencyblips:toggle", src, true, text, true)
	end
end)

RegisterNetEvent('tgiann-gps:polis-ekle')
AddEventHandler('tgiann-gps:polis-ekle', function(polisno)
	local src = source
	if empActive then 	
		TriggerClientEvent("QBCore:Notify", src, 'GPS Açılamadı', "error")
	else
		if polisno == nil then polisno = "LSPD" end
        local isim = getPlayerName(src)
        local text = '.'..polisno..' ['.. isim..']'
		addBlip(text, 0, src, 0.55, 3)
		TriggerClientEvent("QBCore:Notify", src, 'GPS Açıldı')
        TriggerClientEvent("tgiann-polisbildirim:setGpsName", src, polisno)
		TriggerClientEvent("tgiann-emergencyblips:toggle", src, true, text, true)
	end
end)

RegisterNetEvent('tgiann-gps:ems-ekle')
AddEventHandler('tgiann-gps:ems-ekle', function(emsNo)
	local src = source
	if empActive then 	
		TriggerClientEvent("QBCore:Notify", src, 'GPS Açılamadı', "error")
    else
        if emsNo == nil then emsNo = "EMS" end
        local isim = getPlayerName(src, nil)
		addBlip('!'..emsNo..' ['..isim..']', 1, src, 1.0, 1)
        TriggerClientEvent("QBCore:Notify", src, 'GPS Açıldı')
        TriggerClientEvent("tgiann-emergencyblips:toggle", src, true, text, false)
	end
end)

RegisterNetEvent('tgiann-gps:acikgps-kapat')
AddEventHandler('tgiann-gps:acikgps-kapat', function(duty, id)
	local src = source
	if id then src = id end
	if duty then 
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer.PlayerData.job.onduty and (xPlayer.PlayerData.job.name == "ambulance" or xPlayer.PlayerData.job.name == "police") then
			xPlayer.Functions.SetJobDuty(false)
			TriggerClientEvent('QBCore:Notify', src, "Yaralandığın İçin Mesai Dışına Çıkarıldın!", 'error', 15000)
		end
	else
        TriggerClientEvent("tgiann-emergencyblips:toggle", src, false)
        TriggerClientEvent("QBCore:Notify", src, 'GPS Kapatıldı', 'error')
		removeBlip(src)
	end
end)

RegisterNetEvent('tgiann-emergencyblips:carBlips')
AddEventHandler('tgiann-emergencyblips:carBlips', function(plate, number)
    if activeCarsBlips[plate] then
        activeCarsBlips[plate].number = number
    else
        activeCarsBlips[plate] = {
            text = "",
            number = number,
            players = {},
        }
    end
	TriggerClientEvent("tgiann-emergencyblips:updateAllData", -1, activeBlips, activeCarsBlips)
end)

RegisterNetEvent('tgiann-emergencyblips:updatePlayerGps')
AddEventHandler('tgiann-emergencyblips:updatePlayerGps', function(updateCarBlip, plate, open, blipType)
    local src = source
    if updateCarBlip then
        if open then
            if activeBlips[tostring(src)] then
                local xPlayer = QBCore.Functions.GetPlayer(src)
                activeCarsBlips[plate].players[tostring(src)] = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
                activeBlips[tostring(src)].carBlip = true
                activeBlips[tostring(src)].carPlate = plate
            end	
        else
            activeCarsBlips[plate].players[tostring(src)] = nil
            if activeBlips[tostring(src)] then
                activeBlips[tostring(src)].carBlip = false
                activeBlips[tostring(src)].carPlate = ""
            end
        end
        updateCarText(plate)
        TriggerClientEvent('QBCore:Notify', src, "GPS Güncellendi!", "primary", 2000)
    end

    if activeBlips[tostring(src)] then
        activeBlips[tostring(src)].blipType = blipType
    end
    
    TriggerClientEvent("tgiann-emergencyblips:updateAllData", -1, activeBlips, activeCarsBlips)
end)

RegisterNetEvent('EmergencyBlips:black-market-open')
AddEventHandler('EmergencyBlips:black-market-open', function()
    addBlip('!İllegal Eşya Satın Alımı ['..source..']', 0, source, 0.75, 4)
end)

RegisterNetEvent('EmergencyBlips:black-market-close')
AddEventHandler('EmergencyBlips:black-market-close', function()
    removeBlip(source)
end)

function getPlayerName(src)
    local xPlayer = QBCore.Functions.GetPlayer(src)
	return xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
end

function addBlip(text, color, src, scale, type)
    if activeBlips[tostring(src)] then removeBlip(src) end
    activeBlips[tostring(src)] = {
        blipText = text,
        blipColor = color,
        carBlip = false,
        carPlate = "",
        blipScale = scale,
        blipType = type
    }
    TriggerClientEvent("tgiann-emergencyblips:updateAllData", -1, activeBlips, activeCarsBlips)
end

function removeBlip(src)
	if activeBlips[tostring(src)] then
        activeBlips[tostring(src)] = nil
        for plate, data in pairs(activeCarsBlips) do
            for pSrc, players in pairs(data.players) do
                if pSrc == tostring(src) then
                    activeCarsBlips[plate].players[tostring(src)] = nil
                    updateCarText(plate)
                    break
                end
            end
        end
        TriggerClientEvent("tgiann-emergencyblips:removePlayerGps", -1, src, activeBlips, activeCarsBlips)
	end
end

function updateCarText(plate)
    local first = true
    if next(activeCarsBlips[plate].players) then
        for x,playerName in pairs(activeCarsBlips[plate].players) do
            if first then
                first = false
                text = "."..activeCarsBlips[plate].number.." ["..playerName
            else
                text = text .. ","..playerName
            end
        end
        text = text.."]"
    else
        text = ""
    end
    activeCarsBlips[plate].text = text
end