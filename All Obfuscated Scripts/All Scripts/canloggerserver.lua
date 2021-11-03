--[[
	id: 6Jhc1PxFi4JMSU9l3z1Fz
	name: canlogger - server
	description: canlogger - server
	time1: 2021-05-22 03:59:51.352873+00
	time2: 2021-05-22 03:59:51.352873+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local communityname = "Can System"

-- RegisterServerEvent('disc-inventoryhud:GiveItem')
-- AddEventHandler('disc-inventoryhud:GiveItem', function(data)
-- 	local playerId = source
-- 	local sourceXPlayer = ESX.GetPlayerFromId(playerId)
-- 	local targetXPlayer = ESX.GetPlayerFromId(data.target)
-- 	local transfer = {
-- 		{
-- 			["color"] = "697551",
-- 			["title"] = 'Eşyayı Başkasına Verdi',
-- 			["description"] = "Item: **"..data.originItem.id.."\n**Miktar: **"..data.count.."\n**Veren: **"..sourceXPlayer.name.."**\nAlan: **"..targetXPlayer.name.."**\nVerenin Hexi: **"..sourceXPlayer.identifier.."**\nAlanın Hexi: **"..targetXPlayer.identifier.."**",
-- 			["footer"] = {
-- 				["text"] = communityname,
-- 				["icon_url"] = Config.Loggerlogo,
-- 			},
-- 		}
-- 	}

-- PerformHttpRequest(Config.WebhookEnvanter, function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = transfer}), {['Content-Type'] = 'application/json'})
-- end)


-- RegisterServerEvent('disc-inventoryhud:DropItem')
-- AddEventHandler('disc-inventoryhud:DropItem', function(data)
-- 	local playerId = source
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local SteamHex2 = GetPlayerIdentifier(source)
-- 	local itemsil = {
-- 		{
-- 			["color"] = "697551",
-- 			["title"] ='Eşyayı Yere Attı',
-- 			["description"] = "Item: **"..data.originItem.id.."**\n Miktar: **"..data.qty.."\n**Itemi Silen: **"..xPlayer.name.."**\nSteam Hex: **"..SteamHex2.."**",
-- 			["footer"] = {
-- 				["text"] = communityname,
-- 				["icon_url"] = Config.Loggerlogo,
-- 			},
-- 		}
-- 	}

-- PerformHttpRequest(Config.WebhookEnvanter, function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = itemsil}), {['Content-Type'] = 'application/json'})
-- end)


-- AddEventHandler('chatMessage', function(source, name, message) 
-- 	local SteamHexChat = GetPlayerIdentifier(source)
-- 	local chatlog = {
-- 		{
-- 			["color"] = "697551",
-- 			["title"] = 'Nick: ' .. name,
-- 			["description"] = "Mesaj: **"..message.."**\nSteam Hex: **"..SteamHexChat.."**",
-- 			["footer"] = {
-- 				["text"] = communityname,
-- 				["icon_url"] = Config.Loggerlogo,
-- 			},
-- 		}
-- 	}

-- 	if string.match(message, "@everyone") then
-- 		message = message:gsub("@everyone", "`@everyone`")
-- 	end
-- 	if string.match(message, "@here") then
-- 		message = message:gsub("@here", "`@here`")
-- 	end

-- PerformHttpRequest(Config.WebhookChat, function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = chatlog, tts = false}), {['Content-Type'] = 'application/json'})
-- end)

AddEventHandler('playerConnecting', function()
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local connect = {
        {
            ["color"] = "52258",
            ["title"] = "Oyuna Girdi",
            ["description"] = "Oyuncu: **"..name.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**",
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = Config.Loggerlogo,
            },
            ["author"] = {
            	["name"] = "Can System",
            	["icon_url"] = Config.Loggerlogo,
            },
        }
    }

PerformHttpRequest(Config.WebhookJoin, function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local disconnect = {
        {
            ["color"] = "15728640",
            ["title"] = "Oyundan Çıktı",
            ["description"] = "Oyuncu: **"..name.."** \nSebep: **"..reason.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**\n ID: **"..source.."**",
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = Config.Loggerlogo,
            },
        }
    }

    PerformHttpRequest(Config.WebhookJoin, function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('KendiOlen')
AddEventHandler('KendiOlen', function(message)
	local xOlen = GetPlayerName(source)
	local SteamHexOlum = GetPlayerIdentifier(source)
	local olumlog = {
		{
			["color"] = "697551",
			["title"] = 'Ölüm Logu',
			["description"] = "Ölen: **"..xOlen.."**\nÖlüm Sebebi: **"..message.."**\nSteam Hex: **"..SteamHexOlum.."**",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = Config.Loggerlogo,
			},
		}
	}

PerformHttpRequest(Config.WebhookOlen, function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = olumlog}), {['Content-Type'] = 'application/json'})
end)

RegisterServerEvent('Oldurulen')
AddEventHandler('Oldurulen', function(message)
	local SteamHexOlduren = GetPlayerIdentifier(source)
	local olumlog = {
		{
			["color"] = "697551",
			["title"] = 'Ölüm Logu',
			["description"] = "**"..message.."**\nSteam Hex: **"..SteamHexOlduren.."**",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = Config.Loggerlogo,
			},
		}
	}

PerformHttpRequest(Config.WebhookOlduren, function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = olumlog}), {['Content-Type'] = 'application/json'})
end)