--[[
	id: jTfk-1xD6bRO9NJKpDf0U
	name: 3dme server
	description: 3dme server
	time1: 2021-05-22 03:03:54.014845+00
	time2: 2021-05-22 03:03:54.014846+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

-- ## 3dme : server side

-- Command
RegisterCommand('me', function(source, args)
	local name = getIdentity(source)
	local adsoyad = name.firstname .. ' ' .. name.lastname
    local text = "" .. Languages[Config.language].prefix .. table.concat(args, " ") .. ""
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
	TriggerClientEvent("sendProximityMessageMe", -1, source, adsoyad, table.concat(args, " "))

	local ids = ExtractIdentifiers(source)
	local steamname = GetPlayerName(source)
	local _discordID = "Bulunamadı"
	local _steamID = "Bulunamadı"
	local _steamURL = "Bulunamadı"
		
	if ids.discord ~= "" then
		_discordID ="**Discord ID** : <@" ..ids.discord:gsub("discord:", "")..">\n"
	end
	if ids.steam ~= "" then
		_steamID ="**Hex ID** : " ..ids.steam.."\n" 
		_steamURL ="**Steam Profili** : https://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."\n"
	end
	local yazi = "Ad Soyad: "..adsoyad.."\n".._discordID.." ".._steamID.." ".._steamURL.."\n"

	local leave = {
		{
		
			["title"] =  steamname.." : /me "..text.."",
			["description"] = yazi,
			["color"] = "16589887",
			
			["footer"] = {
				["icon_url"] = "https://i.hizliresim.com/fsgqi7l.png",
				["text"] = "Can System"
			},
			["author"] = {
				["name"] = "Can Log System",
				["url"] = "https://discordapp.com",
				["icon_url"] = "https://i.hizliresim.com/fsgqi7l.png"
			}
		
		}
	}
	PerformHttpRequest(GetConvar('CanEmoteLog','https://discord.com/api/webhooks/845492400973152287/OKNwU_SbRmfc-eQdrZQE2qFvSHebwXHqY1J2zyg685Y42vfreGySGGRWInxaZjTarHdU'), function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = leave}), { ['Content-Type'] = 'application/json' })


end)

RegisterCommand('do', function(source, args)
	local name = getIdentity(source)
	local adsoyad = name.firstname .. ' ' .. name.lastname
    local text = "" .. Languages[Config.language].prefix .. table.concat(args, " ") .. ""
    TriggerClientEvent('3dme:shareDisplayDo', -1, text, source)
	TriggerClientEvent("sendProximityMessageDo", -1, source, adsoyad, table.concat(args, " "))

	local ids = ExtractIdentifiers(source)
	local steamname = GetPlayerName(source)
	local _discordID = "Bulunamadı"
	local _steamID = "Bulunamadı"
	local _steamURL = "Bulunamadı"
	if ids.discord ~= "" then
		_discordID ="**Discord ID** : <@" ..ids.discord:gsub("discord:", "")..">\n"
	end
	if ids.steam ~= "" then
		_steamID ="**Hex ID** : " ..ids.steam.."\n" 
		_steamURL ="**Steam Profili** : https://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."\n"
	end
	local yazi = "Ad Soyad: "..adsoyad.."\n".._discordID.." ".._steamID.." ".._steamURL.."\n"

	local leave = {
		{
		
			["title"] =  steamname.." : /do "..text.."",
			["description"] = yazi,
			["color"] = "5301186",
			
			["footer"] = {
				["icon_url"] = "https://i.hizliresim.com/fsgqi7l.png",
				["text"] = "Can System"
			},
			["author"] = {
				["name"] = "Can Log System",
				["url"] = "https://discordapp.com",
				["icon_url"] = "https://i.hizliresim.com/fsgqi7l.png"
			}
		
		}
	}

	PerformHttpRequest(GetConvar('CanEmoteLog','https://discord.com/api/webhooks/845492400973152287/OKNwU_SbRmfc-eQdrZQE2qFvSHebwXHqY1J2zyg685Y42vfreGySGGRWInxaZjTarHdU'), function(err, text, headers) end, 'POST', json.encode({username = "Can System", embeds = leave}), { ['Content-Type'] = 'application/json' })


end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end




function sanitize(string)
	return string:gsub('%@', '')
end

exports('sanitize', function(string)
	sanitize(string)
end)




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

