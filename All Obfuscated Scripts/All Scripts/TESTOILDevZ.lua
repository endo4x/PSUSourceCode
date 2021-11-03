--[[
	id: itom7o9ShGH2EM2IWB-6Z
	name: TEST OIL DevZ
	description: TEST OIL DevZ
	time1: 2021-05-12 09:11:37.214512+00
	time2: 2021-05-12 09:11:37.214512+00
	uploader: N-jXzeZS6oIjI8r0Bj2T0MQLZfS_rwgVeb64Gt8E
	uploadersession: 2npRlbj9ii5-sLy8PCktD-HWguiDX-
	flag: f
--]]

local reset_duration = Config['Settingsteal'].DelaySteal.CemntDelay
local ESX = nil
local cacheCement = {}
local cacheCement2 = {}
script_name = GetCurrentResourceName()
ServerEvent = {[1] = ':server:GetItem'}
Token = 'BookbigCement:check:token:hack:a35wpallwe:s88'

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent(script_name .. ':server:LoadConfig')
AddEventHandler(script_name .. ':server:LoadConfig', function()
    local l = source;
    TriggerClientEvent(script_name .. ':client:GetConfig', l, {
        se = ServerEvent,
        to = Token,
    })
end)

function sanitize(string)
    return string:gsub('%@', '')
end

RegisterServerEvent(script_name .. ServerEvent[1])
AddEventHandler(script_name .. ServerEvent[1], function(netid,Tokenhack)
    local _source = source

	if Token == Tokenhack then
		if cacheCement2[netid] and cacheCement2[netid] > GetGameTimer() then
			TriggerClientEvent('esx:showNotification', _source, "~r~There's no cement left")
			return
		end
		
		local item = Config['Item'].Name
		local countitem = math.random(Config['Item'].count[1],Config['Item'].count[2])
		local xPlayer = ESX.GetPlayerFromId(source)
		local xItem = xPlayer.getInventoryItem(item)

		if not xItem then
			return
		end

		if xItem.limit ~= -1 and (xItem.count) >= xItem.limit then
			Config['Alert']['Notify'].ItemFull()
		else
			cacheCement2[netid] = GetGameTimer() + (reset_duration * 1000)
			xPlayer.addInventoryItem(item, countitem)
			sendToDiscord(sanitize(GetPlayerName(source)).." ได้รับ "..item.." จำนวน "..countitem.." ถุง  ", Config_discord['Webhook']['Additem'].color, source, Config_discord['Webhook']['Additem'].webhook)
			TriggerClientEvent("DevZ_Oil:fetchCooldown", -1, netid, reset_duration)
		end
	else
		sendToDiscord(sanitize(GetPlayerName(source)).." ตรวจสอบพบความผิดปกติของ Event นี้กรุณาตรวจสอบ ", Config_discord['Webhook']['CheckHack'].color, source, Config_discord['Webhook']['CheckHack'].webhook)
        if Config_discord['DropPlayer'] then
            DropPlayer(source,'ระบบตรวจสอบพบสิ่งผิด ปกติ กรุณาติดต่อ Admin ด้วย')
        end
	end
end)

RegisterServerEvent("DevZ_Oil:fetchCement")
AddEventHandler("DevZ_Oil:fetchCement", function(netid)
	if cacheCement[netid] then return end
	cacheCement[netid] = GetGameTimer() + (reset_duration * 1000)
	local src = source
	TriggerClientEvent("DevZ_Oil:fetchCement", -1, netid, src)
end)

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(cacheCement) do
			if v < GetGameTimer() then
				cacheCement[k] = nil
			end
		end
		Citizen.Wait(30000)
	end
end)

function sendToDiscord(name, color, src, discord_webhook)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    local ids = ExtractIdentifiers(src)

    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = "Identifier:** ".. identifiers.steam .."**\nLink Steam: **https://steamcommunity.com/profiles/".. tonumber(ids.steam:gsub("steam:", ""),16) .."**\n IP Address: **".. GetPlayerEndpoint(src) .."**",
              ["footer"] = {
                  ["text"] = "เวลา: ".. os.date ("%X") .." - ".. os.date ("%x") .."",
              },
          }
      }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end


