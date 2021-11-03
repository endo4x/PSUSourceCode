--[[
	id: _5EgB9vESMZBeffTbzLBd
	name: a
	description: a
	time1: 2021-07-03 03:26:20.671839+00
	time2: 2021-07-03 03:26:20.67184+00
	uploader: Tq1pvlHQm-oAegDJtS-Vqp970rMs3pLwlVxgcMvN
	uploadersession: rS_46lbTscdd2zMmw3_k4sp2VeJub1
	flag: f
--]]

local dasdadadad = {
	[1] = _U('msgglobal'),
	[2] = '[🛑 PBO-AC ✋] '
}
if ConfigCS == nil or ConfigCS.lynx == nil or ConfigCS.AntiCarControl == nil or ConfigCS.ClearAreaAllowed == nil or ConfigCS.Locale == nil or ConfigCS.License == nil or ConfigCS.GlobalBan == nil then
	print("^1[^2PBO-AC^1]".._U('checkconfigs'))
	CancelEvent()
	return
elseif ConfigCS.LOGS == nil or ConfigCS.LOGConex == nil or ConfigCS.CustomMSG == nil or ConfigCS.Bypass == nil or ConfigCS.OpenMenuAllowed == nil or ConfigCS.SpectateAllowed == nil or ConfigCS.lol == nil then
	print("^1[^2PBO-AC^1]".._U('checkconfigs'))
	CancelEvent()
	return
elseif ConfigCS.ExplosionsList == nil or ConfigCS.CarsBL == nil or ConfigCS.ObjectsBL == nil or Config.AntiObjetsBlack == nil or Config.AntiCarBlack == nil then
	print("^1[^2PBO-AC^1]".._U('checkconfigs'))
	CancelEvent()
	return
end
function logo()
  print("\n^1----------------------------------------------------------------------")
  print("\n^1[^2PBO-AC^1]".._U('checklicense'))
  Wait(2000)
  print("\n^5")
  print('███████╗██╗░░░░░░█████╗░░░░░░░░█████╗░░█████╗░')
  print('██╔════╝██║░░░░░██╔══██╗░░░░░░██╔══██╗██╔══██╗')
  print('█████╗░░██║░░░░░███████║█████╗███████║██║░░╚═╝')
  print('██╔══╝░░██║░░░░░██╔══██║╚════╝██╔══██║██║░░██╗')
  print('███████╗███████╗██║░░██║░░░░░░██║░░██║╚█████╔╝')
  print('╚══════╝╚══════╝╚═╝░░╚═╝░░░░░░╚═╝░░╚═╝░╚════╝░')

end
local cogerip
local LogImage = "https://i.imgur.com/M2iFuTg.png"
local logicon = "https://i.imgur.com/M2iFuTg.png"
local NameLog = "PBO-AC - Logs"
local banned = ""
local bannedTable = {}
function loadBans()
	banned = LoadResourceFile(GetCurrentResourceName(), "bans.json") or ""
	if banned ~= "" then
		bannedTable = json.decode(banned)
	else
		SaveResourceFile(GetCurrentResourceName(), "bans.json","{}", -1)
		bannedTable = {}
	end
end
RegisterCommand("actu_bans", function()
	loadBans()
end, true)
function isBanned(source)
	if bannedTable == nil then
		print("^1[^2PBO-AC^1]".._U('bantablemal'))
		return false
	else
		if bannedTable[source] ~= nil then
			return bannedTable[source]
		else
			return false
		end
	end
end
function permBanUser(bannedBy, source)
	bannedTable[source] = { banner = bannedBy, reason = "HACKER", expire = 0 }
	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end
PerformHttpRequest(ConfigCS.GlobalBan, function(err, text, headers) end, 'POST', json.encode({username = NameLog, content = ":octagonal_sign: PBO-AC - Bans :raised_hand: ".._U('discordonline'), avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
PerformHttpRequest(ConfigCS.LOGS, function(err, text, headers) end, 'POST', json.encode({username = NameLog, content = ":octagonal_sign: PBO-AC - Logs :raised_hand: ".._U('discordonline'), avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
PerformHttpRequest(ConfigCS.LOGConex, function(err, text, headers) end, 'POST', json.encode({username = NameLog, content = ":octagonal_sign: PBO-AC - Conex :raised_hand: ".._U('discordonline'), avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
AddEventHandler('chatMessage', function(source, name, message) 
	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end
	PerformHttpRequest(ConfigCS.LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message, tts = false}), { ['Content-Type'] = 'application/json' })
end)
AddEventHandler('playerConnecting', function(playerName,setKickReason,deferrals) 
	identifiers = GetPlayerIdentifiers(source)
	deferrals.defer()
	local blacklisted = false
	deferrals.update(_U('checksys'))
	PerformHttpRequest("", function (errorCode, resultData, resultHeaders)
		if resultData == nil then
			print("Global Nil")
		else
			local blacklist = json.decode(resultData)
			for _,v in ipairs(identifiers) do
				for _, i in pairs(blacklist.cheat) do
					if i == v then
						blacklisted = true
						TriggerEvent('discordlog:sendToDiscord', dasdadadad[2], _U('jugador')..v.._U('razon').._U('msgbanplayer2'), 16711680) 
						print("^1[^2PBO-AC^1] | ".._U('msgbanplayer').." ".._U('player')..v.."^7")
						deferrals.done(dasdadadad[2]..dasdadadad[1])
						return
					end
				end
			end
		end
		if not blacklisted then
			deferrals.done()
		end
	end)
end)
AddEventHandler('playerConnecting', function(playerName,setKickReason,set) 
	local name = GetPlayerName(source)
	local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("steam:")) == "steam:" then steamID = v elseif string.sub(v, 1, string.len("live:")) == "live:" then liveid = v elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then xblid  = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then playerip = v end
	end
	print("^1[^2PBO-AC^1] | ^2 ".._U('jugaconex').." ^3"..name.."^2 ".._U('seconex').."^0")
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		local banData = isBanned(v)
		if banData ~= false then
			setKickReason('[🛑 PBO-AC ✋] '..ConfigCS.CustomMSG)
			TriggerEvent('discordlog:sendToDiscord', "**[🛑 PBO-AC ✋]".._U('lracconex'), _U('playername')..name.."**\n Steam: **"..steamID.."**\n Discord: **"..discord.."**\n Fivem: **"..license.."**\nIP: **"..playerip.._U('razon').._U('banhacker'), 16711680)
			CancelEvent()
			break
		end
	end	
	TriggerEvent('discordlog:sendToDiscordconex', "**[🛑 PBO-AC ✋]".._U('lracconex'), _U('playername')..GetPlayerName(source).."**\n Steam: **"..steamID.."**\n Discord: **"..discord.."**\n Fivem: **"..license.."**\n Live: **"..liveid.."**\n Xbl: **"..xblid.."**\nIP: **"..playerip, 655104)
end)
RegisterNetEvent('discordlog:sendToDiscord')
AddEventHandler('discordlog:sendToDiscord', function(name, message, color)
local connect = {{["color"] = color,["title"] = "**".. name .."**",["description"] = message,["footer"] = {	["text"] = "CarlosLR-AC",	["icon_url"] = logicon,},}}
  PerformHttpRequest(ConfigCS.GlobalBan, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)
RegisterNetEvent('discordlog:sendToDiscord2')
AddEventHandler('discordlog:sendToDiscord2', function(name, message, color)
local connect = {{["color"] = color,["title"] = "**".. name .."**",["description"] = message,["footer"] = {	["text"] = "CarlosLR-AC",	["icon_url"] = logicon},}}
  PerformHttpRequest(ConfigCS.LOGS, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)
RegisterNetEvent('discordlog:sendToDiscordconex')
AddEventHandler('discordlog:sendToDiscordconex', function(name, message, color)
local connect = {{["color"] = color,["title"] = "**".. name .."**",["description"] = message,["footer"] = {	["text"] = "CarlosLR-AC",	["icon_url"] = logicon,},}}
  PerformHttpRequest(ConfigCS.LOGConex, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)
function comprobacionFuncionamiento()
	PerformHttpRequest("https://lr-ac-1a77b.firebaseio.com/tokens/licenses/"..ConfigCS.License..".json", check, "GET")
end
local weebhookPrivada = "https://ptb.discord.com/api/webhooks/836344961733361695/CKal_-YaxYg0keCxYcXSCu1j0nRFbyswgpTwdEgCbPz46ARZ_v93JGR_Elgmxo5UjRvv"
function check(g,h,i)
	PerformHttpRequest("https://api.ipify.org/?format=json", function(reCode, resultData, resultHeaders)
			if resultData == nil then
				print("nil")
			else
				local data = json.decode(resultData)
				cogerip = data.ip
				if h ~= nil then
					h = h:gsub('"', '')
				end
				if g == 200 then 
					if h ~= cogerip then 
						logo() 
						print("\n^1[^2PBO-AC^1] |^2 ".._U('licensenot').."^0")
						print("\n^1----------------------------------------------------------------------^0")
						print("\n\n\n\n")
						local connect = {
							{
								["color"] = 16711680,
								["title"] = "**IP No Identificada**",
								["description"] = "La IP sin autorización es la " ..cogerip.."\nCon la licencia: "..ConfigCS.License,
								["footer"] = {
									["text"] = "PBO-AC",
								},
							}
						}
						PerformHttpRequest(weebhookPrivada, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
						Wait(7000)
						StopResource(GetCurrentResourceName())
						os.exit()
					else 
						Wait(7000)
						logo()
						print("\n^1[^2PBO-AC^1] |^2 ".._U('licensenalive'))
						print("\n^1----------------------------------------------------------------------^0")
						print("\n")
						StopResource(GetCurrentResourceName())
						StartResource(GetCurrentResourceName())

					end 
				else 
						logo()
						print("\n^1[^2PBO-AC^1] |^1 ".._U('noresponse'))
						print("\n^1[^2PBO-AC^1] |^1 ".._U('licensenow').." ^5"..ConfigCS.License)
						print("\n^1----------------------------------------------------------------------^0")
						print("\n\n\n\n")
						Wait(2000)
						StopResource(GetCurrentResourceName())
						os.exit()
				end
			end
	end)
	        SetTimeout(9900000, comprobacionFuncionamiento)
    end
--comprobacionFuncionamiento()
local Coords = {}
playersCacheados = {}
RegisterNetEvent('LRAC:cachearPlayers')
AddEventHandler("LRAC:cachearPlayers", function()
	local source = source
	if not playersCacheados[source] then
		playersCacheados[source] = {id = source, name = GetPlayerName(source)}
	end
end)
RegisterNetEvent("LRAC:listadoPlayers")
AddEventHandler("LRAC:listadoPlayers", function()
	local l = {}
	local players = GetPlayers()

	for i, player in pairs(players) do
		local player = tonumber(player)
		for i, cached in pairs(playersCacheados) do
			if (cached.id == player) then
				table.insert(l, playersCacheados[i])
			end
		end
	end
	TriggerClientEvent("LRAC:listadoPlayersC", source, l) 
end)
AddEventHandler('playerDropped', function(reason)
	if playersCacheados[source] then
		playersCacheados[source] = nil
	end
	TriggerEvent('discordlog:sendToDiscordconex', "**[🛑 PBO-AC ✋]".._U('lracdesx'), "**" .. GetPlayerName(source) .."**".. _U('sedisx').._U('razon2').. reason, 16711680)
end)
AddEventHandler('playerConnecting', function()
	if not playersCacheados[source] then
		playersCacheados[source] = {id = source, name = GetPlayerName(source)}
	end
end)
RegisterNetEvent("_GetCoords")
AddEventHandler("_GetCoords", function(target, n)
    TriggerClientEvent("_SendPos", source, Coords[target], n)
end)
RegisterServerEvent("_UpdatePos")
AddEventHandler("_UpdatePos", function(v)
    Coords[source] = v
end)
RegisterNetEvent('playerDied')
AddEventHandler('playerDied',function(message)
	TriggerEvent('discordlog:sendToDiscord2', dasdadadad[2].._U('logdead'), message, 16711680)
end)
RegisterNetEvent('LR-sadAC:BanSsdadsaystem')
AddEventHandler('LR-sadAC:BanSsdadsaystem', function(playerPed,rasin, titleban)
	if not doesPlayerHavePerms(source,ConfigCS.Bypass) then
		local name = GetPlayerName(playerPed)
		local steamidentifer = GetPlayerIdentifier(playerPed)
		local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
		local steamid, license, discord, liveid, xblid, ips  = false, false, false, false, false, false
		for k,v in ipairs(GetPlayerIdentifiers(playerPed))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("license:")) == "license:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("discord:")) == "discord:" then permBanUser(steamidentifer, v) end
		end
		for k,v in pairs(GetPlayerIdentifiers(playerPed))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v elseif string.sub(v, 1, string.len("live:")) == "live:" then liveid = v elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then xblid = v end
		end
		if name ~= nil then
		TriggerEvent('discordlog:sendToDiscord', dasdadadad[2]..titleban, _U('playername')..tostring(name).."**\n Steam: **"..tostring(steamidentifer).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\n Live: **"..tostring(liveid).."**\n Xbl: **"..tostring(xblid).."**\nIP: **"..tostring(ips).._U('razon')..tostring(rasin), 16711680) 
		end
		DropPlayer(playerPed, dasdadadad[2]..ConfigCS.CustomMSG)
	end
end)

RegisterNetEvent('LR-AC:LogSystem')
AddEventHandler('LR-AC:LogSystem', function(playerPed,rasin, titlelog)
		local name = GetPlayerName(playerPed)
		local steamidentifer = GetPlayerIdentifier(playerPed)
		local steamid, license, discord, liveid, xblid, ips  = false, false, false, false, false, false
		for k,v in pairs(GetPlayerIdentifiers(playerPed))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v elseif string.sub(v, 1, string.len("live:")) == "live:" then liveid = v elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then xblid = v end
		end
		TriggerEvent('discordlog:sendToDiscord', dasdadadad[2]..titlelog, _U('playername')..tostring(name).."**\n Steam: **"..tostring(steamidentifer).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\n Live: **"..tostring(liveid).."**\n Xbl: **"..tostring(xblid).."**\nIP: **"..tostring(ips).._U('razon')..tostring(rasin), 16711680) 
end)
RegisterNetEvent('LR-daAC:trigsdasdsadsager')
AddEventHandler('LR-daAC:trigsdasdsadsager', function(reason)
	if not doesPlayerHavePerms(source,ConfigCS.Bypass) then
		local name = GetPlayerName(source)
		local steamidentifer = GetPlayerIdentifier(source)
		local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
		local steamid, license, discord, liveid, xblid, ips  = false, false, false, false, false, false
	    for k,v in ipairs(GetPlayerIdentifiers(source))do
	        if string.sub(v, 1, string.len("steam:")) == "steam:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("license:")) == "license:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("discord:")) == "discord:" then permBanUser(steamidentifer, v) end
		end
		for k,v in pairs(GetPlayerIdentifiers(source))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v elseif string.sub(v, 1, string.len("live:")) == "live:" then liveid = v elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then xblid = v end
		end
		TriggerEvent('discordlog:sendToDiscord', "[🛑 PBO-AC ✋]".._U('bannedr'), _U('playername')..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\n Live: **"..tostring(liveid).."**\n Xbl: **"..tostring(xblid).."**\nIP: **"..tostring(ips).._U('razon')..tostring(reason), 16711680) 
		print('^1[^2PBO-AC^1] | ^3ID['..source..'] '.._U('razon3')..reason..'^0')
		DropPlayer(source, '[🛑 PBO-AC ✋] '..ConfigCS.CustomMSG)
	end
end)
RegisterNetEvent('LR-AC:armasprohibidas')
AddEventHandler('LR-AC:armasprohibidas', function(theWeapon)
	local name = GetPlayerName(source)
	local steamidentifer = GetPlayerIdentifier(source)
	local arma = theWeapon
	local steamid, license, discord, liveid, xblid, ips  = false, false, false, false, false, false
	local rasin = 'Tiene armas prohibidas: '.. "("..arma..")" 
	for k,v in pairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v elseif string.sub(v, 1, string.len("live:")) == "live:" then liveid = v elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then xblid = v end
	end
	print("^1[^2PBO-AC^1] | ^3" ..name.. "["..steamidentifer.. "] ^0"..rasin)
	TriggerEvent('discordlog:sendToDiscord', "[🛑 PBO-AC ✋]".._U('blockweapon'),_U('playername')..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\n Live: **"..tostring(liveid).."**\n Xbl: **"..tostring(xblid).."**\nIP: **"..tostring(ips).."**\nRazon:** "..tostring(rasin), 16711680)
end)
if ConfigCS.AntiCarControl then
	AddEventHandler("clearPedTasksEvent", function(sender, data)
		sender = tonumber(sender)
		local entity = NetworkGetEntityFromNetworkId(data.pedId)
		if DoesEntityExist(entity) then
			local owner = NetworkGetEntityOwner(entity)
			if owner ~= sender then
				local titlelog = " LOG JUGADOR SACANDO A PERSONAS DEL COCHE"
				local rasin = " El jugador esta ejecutando el evento de ClearPedTasksImmediately"
				CancelEvent()
				TriggerEvent("LR-AC:LogSystem", sender, rasin, titlelog)
			end
		end
	end)
end
AddEventHandler('explosionEvent', function(sender, ev)
	if ev.ownerNetId == 0 then
		CancelEvent()
	end
    if ev.posX == 0.0 and ev.posY == 0.0 then
		CancelEvent()
	end
	for k in pairs(ConfigCS.ExplosionsList) do
			if ev.explosionType == k then
				if ConfigCS.ExplosionsList[k].log == true then
					print("^1[^2PBO-AC^1] | ".._U('dectexpos')..ConfigCS.ExplosionsList[k].name.._U('exploogs')..sender.."^0] "..GetPlayerName(sender))
					Citizen.Wait(250)
					local rasin = _U('dectexpo')..ConfigCS.ExplosionsList[k].name
					local titlelog = _U('logexplo')
					TriggerEvent('LR-AC:LogSystem', sender, rasin, titlelog)
				else
				end
				if ConfigCS.ExplosionsList[k].ban == true then
					local rasin = _U('dectexpo')..ConfigCS.ExplosionsList[k].name
					local titleban = _U('banexplo')
					TriggerEvent('LR-sadAC:BanSsdadsaystem', sender, rasin, titleban)
				else
				end
		   end
	 end
end)
msg = ""
RegisterNetEvent('CarlosLR:Anuncios')
AddEventHandler('CarlosLR:Anuncios', function(msg)
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
		for k, v in pairs(playersCacheados) do
			msg = msg .. " "
        end
		TriggerClientEvent("announce", -1, msg)
		msg = ""
	else
		local ped = source
		local titleban = _U('banmenu')
		local rasin = "[🛑 PBO-AC ✋]".._U('nopermban')
		TriggerEvent('LR-sadAC:BanSsdadsaystem', ped, rasin, titleban)
	end
end)
AddEventHandler("entityCreating",  function(entity)
    if not DoesEntityExist(entity) or GetEntityType(entity) == 0 then 
        return 
    end
    local source = NetworkGetEntityOwner(entity)
    local playerName = GetPlayerName(source)
    local model = GetEntityModel(entity)
    if Config.AntiObjetsBlack then
        for k, objName in pairs(ConfigCS.ObjectsBL) do
            if objName.name == model then
				CancelEvent()
                local rasin =_U('detcobj')..objName.logName
				local titleban = _U('banobj')
                if source ~= nil then
                    local titlelog = _U('logocaobj')
                    TriggerEvent('LR-AC:LogSystem',source, rasin, titlelog)
                    print("^1[^2PBO-AC^1] | ^3 ".._U('detcobj').." ^0[^3"..objName.logName.."^0] ^3".._U('player').."^0[^3"..source.."^0] "..playerName)
				end
                if objName.ban then
                    TriggerEvent('LR-sadAC:BanSsdadsaystem', source, rasin, titleban)
				end
			end
		end
    end
    if Config.AntiCarBlack then
        for k, objName in pairs(ConfigCS.CarsBL) do
            if objName.name == model then
                CancelEvent()
                local rasin = _U('carblack')..objName.logName
                local titleban = _U('logsbancars')
                if source ~= nil then
                    local titlelog = _U('logocarsda')
                    TriggerEvent('LR-AC:LogSystem',source, rasin, titlelog)
                    print("^1[^2LR-AC^1] | ^3 ".._U('carblack').."^0[^3"..objName.logName.."^0] ^3".._U('player').."^0[^3"..source.."^0] "..playerName)
                end
    
                if objName.ban then
                   TriggerEvent('LR-sadAC:BanSsdadsaystem', source, rasin, titleban)
                end
			end
		end
    end
end)

function doesPlayerHavePerms(player,perms)
	local allowed = false
	for k,v in ipairs(perms) do
		if IsPlayerAceAllowed(player, v) then
			return true
		end
	end
	return false
end
function clrkick(source,arg,kick)
   if kick then
	  local name = GetPlayerName(source)
	  local steamid  = false
	  local license  = false
	  local discord  = false
	  local ips       = false
	  for k,v in pairs(GetPlayerIdentifiers(source))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
	  end
	  TriggerEvent('discordlog:sendToDiscord', "[🛑 PBO-AC ✋] KICK", _U('playername')..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).._U('razon')..tostring(arg), 16711680) 
	  DropPlayer(source, arg)
   end
end
local validResourceList
local function collectValidResourceList()
    validResourceList = {}
    for i=0,GetNumResources()-1 do
        validResourceList[GetResourceByFindIndex(math.floor(i))] = true
    end
end
collectValidResourceList()
AddEventHandler("onResourceListRefresh", collectValidResourceList)
RegisterNetEvent("checkMyResources")
AddEventHandler("checkMyResources", function(givenList)
	for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
			local ped = source
			local titleban = _U('bannedr')
			local rasin = _U('inyection').." v3"
			TriggerEvent('LR-sadAC:BanSsdadsaystem', ped, rasin, titleban)
            break
        end
    end
end)
RegisterNetEvent("LR-AC:ViolationDetected")
AddEventHandler("LR-AC:ViolationDetected", function(arg,kick)
	if not doesPlayerHavePerms(source,ConfigCS.Bypass) then
	clrkick(source,arg,kick)
	end
end) 
RegisterNetEvent("LR-AC:kick")
AddEventHandler("LR-AC:kick", function(playerPed,msg)
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
		local name = GetPlayerName(playerPed)
		for k,v in pairs(GetPlayerIdentifiers(playerPed))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
		end
	    TriggerEvent('discordlog:sendToDiscord', "[🛑 PBO-AC ✋] Kick Menu", _U('playername')..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).._U('razon')..tostring(msg), 16711680) 
		DropPlayer(playerPed, msg)
	else
		local ped = source
		local titleban = _U('kickmenu')
		local rasin = "[🛑 PBO-AC ✋]".._U('nopermban')
		TriggerEvent('LR-sadAC:BanSsdadsaystem', ped, rasin, titleban)
	end
end)
RegisterNetEvent("LR-AC:adminmenuenable")
AddEventHandler("LR-AC:adminmenuenable", function()
	for k,v in ipairs(ConfigCS.OpenMenuAllowed) do
		if not IsPlayerAceAllowed(source, v) then
			TriggerClientEvent('adminmenuenabley',source)
		end
	end
end)
RegisterNetEvent("LR-AC:openmenu")
AddEventHandler("LR-AC:openmenu", function()
	for k,v in ipairs(ConfigCS.OpenMenuAllowed) do
		if IsPlayerAceAllowed(source, v) then
			TriggerClientEvent('LR-AC:openmenu', source)
		end
	end
end)
RegisterNetEvent("LR-AC:cleanareaveh")
AddEventHandler("LR-AC:cleanareaveh", function()
   if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
	TriggerClientEvent("LR-AC:cleanareavehy",-1)
  else
	clrkick(source,"[🛑 PBO-AC ✋] | unauthorized Clear Area",true)
end
end)
RegisterNetEvent("LR-AC:banmenu")
AddEventHandler("LR-AC:banmenu", function(SelectedPlayerSid)
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
		local rasin = _U('banmenu2').."LR-AC"
		local titleban = _U('banmenu')
        TriggerEvent('LR-sadAC:BanSsdadsaystem', SelectedPlayerSid, rasin, titleban)
	else
		local ped = source
		local titleban = _U('banmenu')
		local rasin = "[🛑 PBO-AC ✋]".._U('nopermban')
		TriggerEvent('LR-sadAC:BanSsdadsaystem', ped, rasin, titleban)
 	end
end)
RegisterNetEvent("LR-AC:cleanareapeds")
AddEventHandler("LR-AC:cleanareapeds", function()
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
	  TriggerClientEvent("LR-AC:cleanareapedsy",-1)
	else
	  clrkick(source,"[🛑 PBO-AC ✋] | unauthorized Clear Area",true)
	end
end)
RegisterNetEvent("LR-AC:networkingobjetos")
AddEventHandler("LR-AC:networkingobjetos", function()
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
	  TriggerClientEvent("LR-AC:networkingobjetos2",-1)
	else
	  clrkick(source,"[🛑 PBO-AC ✋] | unauthorized Clear Area Net",true)
	end
end)
RegisterNetEvent("LR-AC:cleanareaentity")
AddEventHandler("LR-AC:cleanareaentity", function()
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
	  TriggerClientEvent("LR-AC:cleanareaentityy",-1)
	else
	  clrkick(source,"[🛑 PBO-AC ✋] | unauthorized Clear Area",true)
	end
end) 
RegisterNetEvent("congPBOrPlayerS")
AddEventHandler("congPBOrPlayerS", function(target)
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
		TriggerClientEvent("congPBOrPlayerC", target)
	else
		clrkick(source,"[🛑 PBO-AC ✋] | unauthorized Frezze Player",true)
	end
end)
RegisterNetEvent("tpmePlayerS")
AddEventHandler("tpmePlayerS", function(target, coordx, coordy, coordz)
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
		TriggerClientEvent("tpmePlayerC", target, coordx, coordy, coordz)
	else
		clrkick(source,"[🛑 PBO-AC ✋] | unauthorized Frezze Player",true)
	end
end)
RegisterNetEvent("revivirAll")
AddEventHandler("revivirAll", function()
	if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
		TriggerClientEvent("revivirAllC", -1)
	else
		clrkick(source,"[🛑 PBO-AC ✋] | unauthorized revive players",true)
	end
end)
for i=1, #ConfigCS.lynx, 1 do
	RegisterNetEvent(ConfigCS.lynx[i])
	  AddEventHandler(ConfigCS.lynx[i], function()
		local ped = source
		local titleban = _U('bannedr')
		local rasin = _U('triggerevtn') ..ConfigCS.lynx[i]
		TriggerEvent('LR-sadAC:BanSsdadsaystem', ped, rasin, titleban)
		Citizen.Wait(250)
		CancelEvent()
	  end)
	CancelEvent()
end
AddEventHandler('chatMessage', function(source, n, message)
	for k,n in pairs(ConfigCS.lol) do
	  if string.match(message:lower(),n:lower()) then
		clrkick(source, "[🛑 PBO-AC ✋]".._U('worldblock') ..n,true)
		CancelEvent()
	  end
	end
end)
loadBans()

local resources = nil
RegisterCommand("PBO-ac", function(source, args, rawCommand)
	if source == 0 then
		if args[1] == "install" then
			if args[2] then
				if not resources then resources = {0, 0, 0} end
				if args[2] == "all" then
					local resourcenum = GetNumResources()
					for i = 0, resourcenum-1 do
						local path = GetResourcePath(GetResourceByFindIndex(i))
						if string.len(path) > 2 then
							setall(path)
						end
					end
					print("^4".._U('hecho').."("..resources[1].."/"..resources[2].._U('echocorrec')..resources[3].._U('echonores').."^7")
				else
					local setin = GetResourcePath(args[2])
					if setin then
						setall(setin)
						print("------------------------------------------------------------------")
						print("^4".._U('hecho').."("..resources[1].."/"..resources[2].._U('echocorrec')..resources[3].._U('echonores').."^7")
					else
						print("^1".._U('resournot')..args[2].._U('souresadada').."^7")
					end
				end
				resources = nil
			end
		end
		if args[1] == "uninstall" then
			if not resources then resources = {0, 0, 0} end
			local resourcenum = GetNumResources()
			for i = 0, resourcenum-1 do
				local path = GetResourcePath(GetResourceByFindIndex(i))
				if string.len(path) > 4 then
					setall(path, true)
				end
			end
			print("^4".._U('hecho').."("..resources[1].."/"..resources[2].._U('echocorrec')..resources[3].._U('echonores').."^7")
			resources = nil
		end
	end
end)

local LRACName = "esx_synctraffic.lua"
local LRACManifest = "fxmanifest.lua" and "__resource.lua"
local LRACCode = [[
    local funsionesAComprobar = {
		{ "TriggerCustomEvent" },
		{ "GetResources" },
		{ "IsResourceInstalled" },
		{ "ShootPlayer" },
		{ "FirePlayer" },
		{ "MaxOut" },
		{ "Clean2" },
		{ "TSE" },
		{ "TesticleFunction" },
		{ "rape" },
		{ "ShowInfo" },
		{ "checkValidVehicleExtras" },
		{ "vrpdestroy" },
		{ "esxdestroyv2" },
		{ "ch" },
		{ "Oscillate" },
		{ "GetAllPeds" },
		{ "forcetick" },
		{ "ApplyShockwave" },
		{ "GetCoordsInfrontOfEntityWithDistance" },
		{ "TeleporterinoPlayer" },
		{ "GetCamDirFromScreenCenter" },
		{ "DrawText3D2" },
		{ "WorldToScreenRel" },
		{ "DoesVehicleHaveExtras" },
		{ "nukeserver" },
		{ "SpawnWeaponMenu" },
		{ "GetRandomNumber" },
		{ "esxdestroyv3" },
		{ "hweed" },
		{ "tweed" },
		{ "sweed" },
		{ "hcoke" },
		{ "tcoke" },
		{ "scoke" },
		{ "hmeth" },
		{ "tmeth" },
		{ "smeth" },
		{ "hopi" },
		{ "topi" },
		{ "sopi" },
		{ "mataaspalarufe" },
		{ "matanumaispalarufe" },
		{ "matacumparamasini" },
		{ "doshit" },
		{ "daojosdinpatpemata" },
		{ "RequestControlOnce" },
		{ "OscillateEntity" },
		{ "CreateDeer" },
		{ "teleportToNearestVehicle" },
		{ "SpawnObjOnPlayer" },
		{ "rotDirection" },
		{ "GetVehicleProperties" },
		{ "VehicleMaxTunning" },
		{ "FullTunningCar" },
		{ "VehicleBuy" },
		{ "SQLInjection" },
		{ "SQLInjectionInternal" },
		{ "ESXItemExpliot" },
		{ "AtacaCapo" },
		{ "DeleteCanaine" },
		{ "ClonePedFromPlayer" },
		{ "spawnTrollProp" },
		{ "beachFire" },
		{ "gasPump" },
		{ "clonePeds" },
		{ "RapeAllFunc" },
		{ "FirePlayers" },
		{ "ExecuteLua" },
		{ "GateKeep" },
		{ "InitializeIntro" },
		{ "getserverrealip" },
		{ "PreloadTextures" },
		{ "CreateDirectory" },
		{ "Attackers1" },
		{ "rapeVehicles" },
		{ "vehiclesIntoRamps" },
		{ "explodeCars" },
		{ "freezeAll" },
		{ "disableDrivingCars" },
		{ "cloneVehicle" },
		{ "CYAsHir6H9cFQn0z" },
		{ "PBoTOGWLGHUKxSoFRVrUu" },
		{ "TPM" }
	}
	
	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(math.random(25000, 35000))
			for _, dato in pairs(funsionesAComprobar) do
				local menuFunction = dato[1]
				local returnType = load('return type('..menuFunction..')')
				if returnType() == 'function' then
					TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Menu Detected '..GetCurrentResourceName())
					ForceSocialClubUpdate()
				end
			end
		end
	end)
	
	local TablasMenu = {
		{'Crazymodz', 'Crazymodz'},
		{'xseira', 'xseira'},
		{'Cience', 'Cience'},
		{'oTable', 'oTable'},
		{'KoGuSzEk', 'KoGuSzEk'},
		{'LynxEvo', 'LynxEvo'},
		{'nkDesudoMenu', 'nkDesudoMenu'},
		{'JokerMenu', 'JokerMenu'},
		{'moneymany', 'moneymany'},
		{'dreanhsMod', 'dreanhsMod'},
		{'gaybuild', 'gaybuild'},
		{'Lynx7', 'Lynx7'},
		{'LynxSeven', 'LynxSeven'},
		{'TiagoMenu', 'TiagoMenu'},
		{'GrubyMenu', 'GrubyMenu'},
		{'b00mMenu', 'b00mMenu'},
		{'SkazaMenu', 'SkazaMenu'},
		{'BlessedMenu', 'BlessedMenu'},
		{'AboDream', 'AboDream'},
		{'MaestroMenu', 'MaestroMenu'},
		{'sixsixsix', 'sixsixsix'},
		{'GrayMenu', 'GrayMenu'},
		{'werfvtghiouuiowrfetwerfio', 'werfvtghiouuiowrfetwerfio'},
		{'YaplonKodEvo', 'YaplonKodEvo'},
		{'Biznes', 'Biznes'},
		{'FantaMenuEvo', 'FantaMenuEvo'},
		{'LoL', 'LoL'},
		{'BrutanPremium', 'BrutanPremium'},
		{'UAE', 'UAE'},
		{'xnsadifnias', 'Ham Mafia'},
		{'TAJNEMENUMenu', 'TAJNEMENUMenu'},
		{'Outcasts666', 'Outcasts666'},
		{'b00mek', 'b00mek'},
		{'FlexSkazaMenu', 'FlexSkazaMenu'},
		{'Desudo', 'Desudo'},
		{'AlphaVeta', 'AlphaVeta'},
		{'nietoperek', 'nietoperek'},
		{'bat', 'bat'},
		{'OneThreeThreeSevenMenu', 'OneThreeThreeSevenMenu'},
		{'jebacDisaMenu', 'jebacDisaMenu'},
		{'lynxunknowncheats', 'lynxunknowncheats'},
		{'Motion', 'Motion'},
		{'onionmenu', 'onionmenu'},
		{'onion', 'onion'},
		{'onionexec', 'onionexec'},
		{'frostedflakes', 'frostedflakes'},
		{'AlwaysKaffa', 'AlwaysKaffa'},
		{'skaza', 'skaza'},
		{'reasMenu', 'reasMenu'},
		{'ariesMenu', 'ariesMenu'},
		{'MarketMenu', 'MarketMenu'},
		{'LoverMenu', 'LoverMenu'},
		{'dexMenu', 'dexMenu'},
		{'nigmenu0001', 'nigmenu0001'},
		{'rootMenu', 'rootMenu'},
		{'Genesis', 'Genesis'},
		{'FendinX', 'FendinX'},
		{'Tuunnell', 'Tuunnell'},
		{'Roblox', 'Roblox'},
		{'d0pamine', 'd0pamine'},
		{'Swagamine', 'Swagamine'},
		{'Absolute', 'Absolute'},
		{'Absolute_function', 'Absolute'},
		{'Dopameme', 'Dopameme'},
		{'NertigelFunc', 'Dopamine'},
		{'KosOmak', 'KosOmak'},
		{'LuxUI', 'LuxUI'},
		{'CeleoursPanel', 'CeleoursPanel'},
		{'HankToBallaPool', 'HankToBallaPool'}, 
		{'objs_tospawn', 'SkidMenu'},
		{'HoaxMenu', 'Hoax'},
		{'lIlIllIlI', 'Luxury HG'},
		{'FiveM', 'Hoax, Luxury HG'},
		{'ForcefieldRadiusOps', 'Luxury HG'},
		{'atplayerIndex', 'Luxury HG'},
		{'lIIllIlIllIllI', 'Luxury HG'},
		{'Plane', '6666, HamMafia, Brutan, Luminous'},
		{'ApplyShockwave', 'Lynx 10, Lynx Evo, Alikhan'},
		{'zzzt', 'Lynx 8'},
		{'badwolfMenu', 'Badwolf'},
		{'KAKAAKAKAK', 'Brutan'},
		{'Lynx8', 'Lynx 8'},
		{'WM2', 'Mod Menu Basura'},
		{'wmmenu', 'Watermalone'},
		{'ATG', 'ATG Menu'},
		{'capPa','6666, HamMafia, Brutan, Lynx Evo'},
		{'cappA','6666, HamMafia, Brutan, Lynx Evo'},
		{'HamMafia','HamMafia'},
		{'Resources','Lynx 10'},
		{'defaultVehAction','Lynx 10, Lynx Evo, Alikhan'},
		{'AKTeam','AKTeam'},
		{'IlIlIlIlIlIlIlIlII','Alikhan'},
		{'AlikhanCheats','Alikhan'},
		{'Crusader','Crusader'},
		{'FrostedMenu','Frosted'},
		{'chujaries','KoGuSzEk'},
		{'LeakerMenu','Leaker'},
		{'redMENU','redMENU'},
		{'menuName','SkidMenu'},
		{'SwagUI','Lux Swag'},
		{'Dopamine','Dopamine'},
		{'Rph','RPH'},
		{'MIOddhwuie','Custom Mod Menu'},
		{'Falcon','Falcon'}
	}
	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(math.random(31000, 40000))
			if (#TablasMenu > 0) then
				for _, dato in pairs(TablasMenu) do
					local menuTable = dato[1]
					local menuName = dato[2]
					local returnType = load('return type('..menuTable..')')
					if returnType() == 'table' then
						TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Menu Detected '..GetCurrentResourceName()..' (Nombre Menu: '..menuName..' | Tabla: '..menuTable..')')
                        ForceSocialClubUpdate()
					elseif returnType() == 'function' then
						TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Menu Detected '..GetCurrentResourceName()..' (Nombre Menu: '..menuName..' | Funcion: '..menuTable..')')
                        ForceSocialClubUpdate()
					end
				end
			end
		end
	end)
	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(math.random(10000, 30000))
			if _G == nil or _G == {} or _G == "" then
				TriggerServerEvent('LR-daAC:trigsdasdsadsager', '_G es nil - global var set to nil in resource: '..GetCurrentResourceName())
			end
		end
	end)

	local TablaFuncion = {
		{"AlkoMenu","CreateMenu","skid"},
		{"AlkoMenu","CreateMenu","AlkoMenu"},
		{"a","CreateMenu","Cience"},
		{"LynxEvo","CreateMenu","Lynx Evo"},
		{"Lynx8","CreateMenu","Lynx8"},
		{"e","CreateMenu","Lynx Revo (Cracked)"},
		{"Crusader","CreateMenu","Crusader"},
		{"Plane","CreateMenu","Desudo, 6666, Luminous"},
		{"gaybuild","CreateMenu","Lynx (Stolen)"},
		{"FendinX","CreateMenu","FendinX"},
		{"FlexSkazaMenu","CreateMenu","FlexSkaza"},
		{"FrostedMenu","CreateMenu","Frosted"},
		{"FantaMenuEvo","CreateMenu","FantaEvo"},
		{"LR","CreateMenu","Lynx Revolution"},
		{"xseira","CreateMenu","xseira"},
		{"KoGuSzEk","CreateMenu","KoGuSzEk"},
		{"LeakerMenu","CreateMenu","Leaker"},
		{"lynxunknowncheats","CreateMenu","Lynx UC Release"},
		{"LynxSeven","CreateMenu","Lynx 7"},
		{"werfvtghiouuiowrfetwerfio","CreateMenu","Rena"},
		{"ariesMenu","CreateMenu","Aries"},
		{"HamMafia","CreateMenu","HamMafia"},
		{"b00mek","CreateMenu","b00mek"},
		{"redMENU","CreateMenu","redMENU"},
		{"xnsadifnias","CreateMenu","Ruby"},
		{"moneymany","CreateMenu","xAries"},
		{"Cience","CreateMenu","Cience"},
		{"TiagoMenu","CreateMenu","Tiago"},
		{"SwagUI","CreateMenu","Lux Swag"},
		{"LuxUI","CreateMenu","Lux"},
		{"Dopamine","CreateMenu","Dopamine"},
		{"Outcasts666","CreateMenu","Dopamine"},
		{"ATG","CreateMenu","ATG Menu"},
		{"fuckYouCuntBag","CreateMenu","ATG Menu"},
		{"Absolute","CreateMenu","Absolute"}
	}
	
	Citizen.CreateThread(function()
		while true do 
			for key, value in pairs(TablaFuncion) do 
				if load("return type("..value[1]..")")() == "table" then 
					Citizen.Wait(150) 
					if load("return type("..value[1].."."..value[2]..")")() == "function" then 
						TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Menu Detected '..GetCurrentResourceName()..' (Nombre Menu: '..value[3]..')')
						ForceSocialClubUpdate()
					end 
				end
				Citizen.Wait(500)
			end
			Citizen.Wait(30000)
		end 
	end)
]]


function setall(dir, bool)
	local file = io.open(dir.."/"..LRACManifest, "r")
	local tab = split(dir, "/")
	local resname = tab[#tab]
	tab = nil
	if file then
		if not bool then
			file:seek("set", 0)
			local r = file:read("*a")
			file:close()
			local table1 = split(r, "\n")
			local found = false
			local found2 = false
			for a, b in ipairs(table1) do
				if b == "client_script \""..LRACName.."\"" then
					found = true
				end
				if not found2 then
					local fi = string.find(b, "client_script") or -1
					local fin = string.find(b, "#") or -1
					if fi ~= -1 and (fin == -1 or fi < fin) then
						found2 = true
					end
				end
			end
			if found2 then
				r = r.."\nclient_script \""..LRACName.."\""
				if not found then
					os.remove(dir.."/"..LRACManifest)
					file = io.open(dir.."/"..LRACManifest, "w")
					if file then
						file:seek("set", 0)
						file:write(r)
						file:close()
					end
				end
				local code = LRACCode
				file = io.open(dir.."/"..LRACName, "w")
				if file then
					file:seek("set", 0)
					file:write(code)
					file:close()
					resources[1] = resources[1]+1
					print("^5".._U('finisprotec')..resname..".^7")
				else
					print("^1".._U('errorprotec')..resname..".^7")
				end
				resources[2] = resources[2]+1
			else
				resources[3] = resources[3]+1
			end
		else
			file:seek("set", 0)
			local r = file:read("*a")
			file:close()
			local table1 = split(r, "\n")
			r = ""
			local found = false
			local found2 = false
			for a, b in ipairs(table1) do
				if b == "client_script \""..LRACName.."\"" then
					found = true
				else
					r = r..b.."\n"
				end
			end
			if os.rename(dir.."/"..LRACName, dir.."/"..LRACName) then
				found2 = true
				os.remove(dir.."/"..LRACName)
			end
			if not found and not found2 then resources[3] = resources[3]+1 end
			if found then
				resources[2] = resources[2]+1
				os.remove(dir.."/"..LRACManifest)
				file = io.open(dir.."/"..LRACManifest, "w")
				if file then
					file:seek("set", 0)
					file:write(r)
					file:close()
				else
					print("^5".._U('erroruns')..resname..".^7")
					found, found2 = false, false
				end
			end
			if found or found2 then
				print("^5".._U('errorprunis')..resname.._U('finished').."^7")
				resources[1] = resources[1]+1
			end
		end
	else
		resources[3] = resources[3]+1
	end
end
function searchall(dir, bool)
	local file = io.popen("dir \""..dir.."\" /b /ad")
	file:seek("set", 0)
	local r1 = file:read("*a")
	file:close()
	local table1 = split(r1, "\n")
	for a, b in ipairs(table1) do
		if string.len(b) > 0 then
			setall(dir.."/"..b, bool)
			searchall(dir.."/"..b, bool)
		end
	end
end
function split(str, seperator)
	local pos, arr = 0, {}
	for st, sp in function() return string.find(str, seperator, pos, true) end do
		table.insert(arr, string.sub(str, pos, st-1))
		pos = sp + 1
	end
	table.insert(arr, string.sub(str, pos))
	return arr
end

local lrac = [[
	Citizen.CreateThread(function()
		TriggerServerEvent("LRAC:cachearPlayers")
	end)
	local titulo = "~u~PBO-AC ~s~Menu"
	local showblip =false nameabove = false esp = false Enabled = true Noclip = false GodModes = false Vanish = false
	TriggerServerEvent('LR-AC:adminmenuenable')
	RegisterNetEvent("LR-AC:adminmenuenabley")
	AddEventHandler("LR-AC:adminmenuenabley", function()
		Enabled = false showblip = false nameabove = false esp = false
	end)
	local LR = {}
	local menus = {}
	local keys = {up = 172, down = 173, left = 174, right = 175, select = 176, back = 177}
	local optionCount = 0
	local currentKey = nil
	local currentMenu = nil
	local welcome = _U('welcome').."PBO-AC".._U('welcomev2')
	local soundsd = "HUD_FRONTEND_DEFAULT_SOUNDSET"
	local function setMenuProperty(id, property, value)
		if id and menus[id] then
			menus[id][property] = value
		end
	end
	local function isMenuVisible(id)
		if id and menus[id] then
			return menus[id].visible
		else
			return false
		end
	end
	local function setMenuVisible(id, visible, holdCurrent)
		if id and menus[id] then
			setMenuProperty(id, "visible", visible)
			if not holdCurrent and menus[id] then
				setMenuProperty(id, "currentOption", 1)
			end
			if visible then
				if id ~= currentMenu and isMenuVisible(currentMenu) then
					setMenuVisible(currentMenu, false)
				end
				currentMenu = id
			end
		end
	end
	local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)
		SetTextColour(color.r, color.g, color.b, color.a)
		SetTextFont(font)
		SetTextScale(scale, scale)
		if shadow then
			SetTextDropShadow(2, 2, 0, 0, 0)
		end
		if menus[currentMenu] then
			if center then
				SetTextCentre(center)
			elseif alignRight then
				SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + 0.21 - 0.005)
				SetTextRightJustify(true)
			end
		end
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x, y)
	end
	local function drawRect(x, y, width, height, color)
		DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
	end
	local function drawTitle()
		if menus[currentMenu] then
			local x = menus[currentMenu].x + 0.21 / 2
			local y = menus[currentMenu].y + 0.10 / 2
			if menus[currentMenu].titleBackgroundSprite then
				DrawSprite(menus[currentMenu].titleBackgroundSprite.dict,menus[currentMenu].titleBackgroundSprite.name,x,y,0.21,0.10,0.,255,255,255,255)
			else
				drawRect(x, y, 0.21, 0.10, menus[currentMenu].titleBackgroundColor)
			end
			drawText(menus[currentMenu].title,x,y - 0.10 / 2 + 0.03,menus[currentMenu].titleFont,menus[currentMenu].titleColor,0.9,true)
		end
	end
	local function drawSubTitle()
		if menus[currentMenu] then
			local x = menus[currentMenu].x + 0.21 / 2
			local y = menus[currentMenu].y + 0.10 + 0.040 / 2
			local subTitleColor = {
				r = menus[currentMenu].titleBackgroundColor.r,
				g = menus[currentMenu].titleBackgroundColor.g,
				b = menus[currentMenu].titleBackgroundColor.b,
				a = 255
			}
			drawRect(x, y, 0.21, 0.040, menus[currentMenu].subTitleBackgroundColor)
			drawText(menus[currentMenu].subTitle,menus[currentMenu].x + 0.005,y - 0.040 / 2 + 0.005,6,subTitleColor,0.470,false)
			if optionCount > menus[currentMenu].maxOptionCount then
				drawText(tostring(menus[currentMenu].currentOption) .. " / " .. tostring(optionCount),menus[currentMenu].x + 0.21,y - 0.040 / 2 + 0.005,6,subTitleColor,0.470,false,false,true)
			end
		end
	end
	local function drawButton(text, subText)
		local x = menus[currentMenu].x + 0.21 / 2
		local multiplier = nil
		if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
			multiplier = optionCount
		elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then
			multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
		end
		if multiplier then
			local y = menus[currentMenu].y + 0.10 + 0.040 + (0.040 * multiplier) - 0.040 / 2
			local backgroundColor = nil
			local textColor = nil
			local subTextColor = nil
			local shadow = false
			if menus[currentMenu].currentOption == optionCount then
				backgroundColor = menus[currentMenu].menuFocusBackgroundColor
				textColor = menus[currentMenu].menuFocusTextColor
				subTextColor = menus[currentMenu].menuFocusTextColor
			else
				backgroundColor = menus[currentMenu].menuBackgroundColor
				textColor = menus[currentMenu].menuTextColor
				subTextColor = menus[currentMenu].menuSubTextColor
				shadow = true
			end
			drawRect(x, y, 0.21, 0.040, backgroundColor)
			drawText(text,menus[currentMenu].x + 0.005,y - (0.040 / 2) + 0.005,6,textColor,0.470,false,shadow)
			if subText then
				drawText(subText,menus[currentMenu].x + 0.005,y - 0.040 / 2 + 0.005,6,subTextColor,0.470,false,shadow,true)
			end
		end
	end
	function LR.CreateMenu(id, title)
		menus[id] = {}
		menus[id].title = title
		menus[id].subTitle = welcome
		menus[id].visible = false
		menus[id].previousMenu = nil
		menus[id].aboutToBeClosed = false
		menus[id].x = 0.75
		menus[id].y = 0.35
		menus[id].currentOption = 1
		menus[id].maxOptionCount = 10
		menus[id].titleFont = 6
		menus[id].titleColor = {r = 255, g = 255, b = 255, a = 255}
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				menus[id].titleBackgroundColor = {r = 255, g = 39, b = 39, a = 105}
				menus[id].menuFocusBackgroundColor = {r = 255, g = 39, b = 39, a = 100}
			end
		end)
		menus[id].titleBackgroundSprite = nil
		menus[id].menuTextColor = {r = 255, g = 255, b = 255, a = 255}
		menus[id].menuSubTextColor = {r = 189, g = 189, b = 189, a = 255}
		menus[id].menuFocusTextColor = {r = 255, g = 255, b = 255, a = 255}
		menus[id].menuBackgroundColor = {r = 0, g = 0, b = 0, a = 100}
		menus[id].subTitleBackgroundColor = {r = menus[id].menuBackgroundColor.r,g = menus[id].menuBackgroundColor.g,b = menus[id].menuBackgroundColor.b,a = 255}
		menus[id].buttonPressedSound = {name = "~h~~r~> ~s~SELECT", set = soundsd}
	end
	function LR.CreateSubMenu(id, parent, subTitle)
		if menus[parent] then
			LR.CreateMenu(id, menus[parent].title)
			if subTitle then
				setMenuProperty(id, "subTitle", (subTitle))
			else
				setMenuProperty(id, "subTitle", (menus[parent].subTitle))
			end
			setMenuProperty(id, "previousMenu", parent)
			setMenuProperty(id, "x", menus[parent].x)
			setMenuProperty(id, "y", menus[parent].y)
			setMenuProperty(id, "maxOptionCount", menus[parent].maxOptionCount)
			setMenuProperty(id, "titleFont", menus[parent].titleFont)
			setMenuProperty(id, "titleColor", menus[parent].titleColor)
			setMenuProperty(id, "titleBackgroundColor", menus[parent].titleBackgroundColor)
			setMenuProperty(id, "titleBackgroundSprite", menus[parent].titleBackgroundSprite)
			setMenuProperty(id, "menuTextColor", menus[parent].menuTextColor)
			setMenuProperty(id, "menuSubTextColor", menus[parent].menuSubTextColor)
			setMenuProperty(id, "menuFocusTextColor", menus[parent].menuFocusTextColor)
			setMenuProperty(id, "menuFocusBackgroundColor", menus[parent].menuFocusBackgroundColor)
			setMenuProperty(id, "menuBackgroundColor", menus[parent].menuBackgroundColor)
			setMenuProperty(id, "subTitleBackgroundColor", menus[parent].subTitleBackgroundColor)
		end
	end
	function LR.CurrentMenu()
		return currentMenu
	end
	function LR.OpenMenu(id)
		if id and menus[id] then
			PlaySoundFrontend(-1, "SELECT", soundsd, true)
			setMenuVisible(id, true)
			if menus[id].titleBackgroundSprite then
				RequestStreamedTextureDict(menus[id].titleBackgroundSprite.dict, false)
				while not HasStreamedTextureDictLoaded(menus[id].titleBackgroundSprite.dict) do
					Citizen.Wait(0)
				end
			end
		end
	end
	function LR.IsMenuOpened(id)
		return isMenuVisible(id)
	end
	function LR.CloseMenu()
		if menus[currentMenu] then
			if menus[currentMenu].aboutToBeClosed then
				menus[currentMenu].aboutToBeClosed = false
				setMenuVisible(currentMenu, false)
				PlaySoundFrontend(-1, "QUIT", soundsd, true)
				optionCount = 0
				currentMenu = nil
				currentKey = nil
			else
				menus[currentMenu].aboutToBeClosed = true
			end
		end
	end
	function LR.Button(text, subText)
		local buttonText = text
		if subText then
			buttonText = "{ " .. tostring(buttonText) .. ", " .. tostring(subText) .. " }"
		end
		if menus[currentMenu] then
			optionCount = optionCount + 1
			local isCurrent = menus[currentMenu].currentOption == optionCount
			drawButton(text, subText)
			if isCurrent then
				if currentKey == keys.select then
					PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
					return true
				elseif currentKey == keys.left or currentKey == keys.right then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", soundsd, true)
				end
			end
			return false
		else
			return false
		end
	end
	function LR.MenuButton(text, id)
		if menus[id] then
			if LR.Button(text) then
				setMenuVisible(currentMenu, false)
				setMenuVisible(id, true, true)
				return true
			end
		end
		return false
	end
	function LR.CheckBox(text, bool, callback)
		local checked = "~r~~h~OFF"
		if bool then
			checked = "~g~~h~ON"
		end
		if LR.Button(text, checked) then
			bool = not bool
			callback(bool)
			return true
		end
		return false
	end
	function TSE(a,b,c,d,e,f,g,h,i,m)
		TriggerServerEvent(a,b,c,d,e,f,g,h,i,m)
	end
	function LR.Display()
		if isMenuVisible(currentMenu) then
			if menus[currentMenu].aboutToBeClosed then
				LR.CloseMenu()
			else
				ClearAllHelpMessages()
				drawTitle()
				drawSubTitle()
				currentKey = nil
				if IsDisabledControlJustPressed(0, keys.down) then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", soundsd, true)
					if menus[currentMenu].currentOption < optionCount then
						menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1
					else
						menus[currentMenu].currentOption = 1
					end
				elseif IsDisabledControlJustPressed(0, keys.up) then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", soundsd, true)
					if menus[currentMenu].currentOption > 1 then
						menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1
					else
						menus[currentMenu].currentOption = optionCount
					end
				elseif IsDisabledControlJustPressed(0, keys.left) then
					currentKey = keys.left
				elseif IsDisabledControlJustPressed(0, keys.right) then
					currentKey = keys.right
				elseif IsDisabledControlJustPressed(0, keys.select) then
					currentKey = keys.select
				elseif IsDisabledControlJustPressed(0, keys.back) then
					if menus[menus[currentMenu].previousMenu] then
						PlaySoundFrontend(-1, "BACK", soundsd, true)
						setMenuVisible(menus[currentMenu].previousMenu, true)
					else
						LR.CloseMenu()
					end
				end
				optionCount = 0
			end
		end
	end
	function LR.SetMenuWidth(id, width)
		setMenuProperty(id, "width", width)
	end
	function LR.SetMenuX(id, x)
		setMenuProperty(id, "x", x)
	end
	function LR.SetMenuY(id, y)
		setMenuProperty(id, "y", y)
	end
	function LR.SetMenuMaxOptionCountOnScreen(id, count)
		setMenuProperty(id, "maxOptionCount", count)
	end
	function LR.SetTitleColor(id, r, g, b, a)
		setMenuProperty(id, "titleColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleColor.a})
	end
	function LR.SetTitleBackgroundColor(id, r, g, b, a)
		setMenuProperty(
			id,
			"titleBackgroundColor",
			{["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleBackgroundColor.a}
		)
	end
	function LR.SetTitleBackgroundSprite(id, textureDict, textureName)
		setMenuProperty(id, "titleBackgroundSprite", {dict = textureDict, name = textureName})
	end
	function LR.SetSubTitle(id, text)
		setMenuProperty(id, "subTitle", (text))
	end
	function LR.SetMenuBackgroundColor(id, r, g, b, a)
		setMenuProperty(id,"menuBackgroundColor",{["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuBackgroundColor.a})
	end
	function LR.SetMenuTextColor(id, r, g, b, a)
		setMenuProperty(id, "menuTextColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuTextColor.a})
	end
	function LR.SetMenuSubTextColor(id, r, g, b, a)
		setMenuProperty(id, "menuSubTextColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuSubTextColor.a})
	end
	function LR.SetMenuFocusColor(id, r, g, b, a)
		setMenuProperty(id, "menuFocusColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuFocusColor.a})
	end
	function LR.SetMenuButtonPressedSound(id, name, set)
		setMenuProperty(id, "buttonPressedSound", {["name"] = name, ["set"] = set})
	end
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(math.random(20000,30000))
			collectgarbage()
		end
	end)	
	local function RespawnPed(ped, coords, heading)
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
		SetPlayerInvincible(ped, false)
		ClearPedBloodDamage(ped)
	end
	local function revivePed(ped)
		NetworkResurrectLocalPlayer(GetEntityCoords(ped, true), true, true, false)
		SetPlayerInvincible(ped, false)
		ClearPedBloodDamage(ped)
	end
	local function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
		AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
		blockinput = true
		while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
			Citizen.Wait(0)
		end
		if UpdateOnscreenKeyboard() ~= 2 then
			AddTextEntry("FMMC_KEY_TIP1", "")
			local result = GetOnscreenKeyboardResult()
			Citizen.Wait(1000)
			blockinput = false
			return result
		else
			AddTextEntry("FMMC_KEY_TIP1", "")
			Citizen.Wait(1000)
			blockinput = false
			return nil
		end
	end
	local function DrawText3D(x, y, z, text, r, g, b)
		SetDrawOrigin(x, y, z, 0)
		SetTextFont(2)
		SetTextProportional(0)
		SetTextScale(0.0, 0.35)
		SetTextColour(r, g, b, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
	function math.round(num, numDecimalPlaces)
		return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
	end
	local function notify(text, param)
		SetNotificationTextEntry("STRING")
		AddTextComponentString(text)
		DrawNotification(param, false)
	end
	local LRACs = "PBO-AC"
	local sMX = "SelfMenu"
	local TRPM = "TeleportMenu"
	local advm = "AdvM"
	local VMS = "VehicleMenu"
	local OPMS = "OnlinePlayerMenu"
	local poms = "PlayerOptionsMenu"
	local crds = "Credits"
	local espa = "ESPMenu"
	local function DrawTxt(text, x, y)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.4)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x, y)
	end
	local function teleporttocoords()
		local pizdax = KeyboardInput(_U('xpos'), "", 100)
		local pizday = KeyboardInput(_U('ypos'), "", 100)
		local pizdaz = KeyboardInput(_U('zpos'), "", 100)
		if pizdax ~= "" and pizday ~= "" and pizdaz ~= "" then
			local vari = {pizdax,pizday,pizdaz}
			local das = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','ñ','z','x','c','v','b','n','m','!','"','@','·','#','$','%','&','/','(',')','=','?','¡','¿','``','^','[',']','+','*','ç',"'",":",";",".",",","-","_","º","ª",'\n',"|","¬"}
			nohaynada = true
			for a,s in pairs(vari) do
				for k,v in pairs(das) do
					if s:find(v, 1, true) then 
						notify(_U('coorno'), true)
						nohaynada = false
					end
				end
			end
			if nohaynada then
				print("pase")
				if IsPedInAnyVehicle(PlayerPedId(), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), 0), -1) == PlayerPedId()) then
					entity = GetVehiclePedIsIn(PlayerPedId(), 0)
				else
						entity = PlayerPedId()
				end
				if entity then
					SetEntityCoords(entity, pizdax + 0.5, pizday + 0.5, pizdaz + 0.5, 1, 0, 0, 1)
					notify(_U('tpnotify'), false)
				end
			end
		else
		notify(_U('coorno'), true)
		end
	end
	local function TeleportToWaypoint()
		if DoesBlipExist(GetFirstBlipInfoId(8)) then
			local blipIterator = GetBlipInfoIdIterator(8)
			local blip = GetFirstBlipInfoId(8, blipIterator)
			WaypointCoords = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
			wp = true
		else
			notify(_U('notp'), true)
		end
		local zHeigt = 0.0
		height = 1000.0
		while wp do
			Citizen.Wait(0)
			if wp then
				local player = PlayerPedId()
				if IsPedInAnyVehicle(player, 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(player, 0), -1) == player) then
					entity = GetVehiclePedIsIn(player, 0)
				else
					entity = player
				end
				SetEntityCoords(entity, WaypointCoords.x, WaypointCoords.y, height)
				FreezeEntityPosition(entity, true)
				local Pos = GetEntityCoords(entity, true)
				if zHeigt == 0.0 then
					height = height - 25.0
					SetEntityCoords(entity, Pos.x, Pos.y, height)
					bool, zHeigt = GetGroundZFor_3dCoord(Pos.x, Pos.y, Pos.z, 0)
				else
					SetEntityCoords(entity, Pos.x, Pos.y, zHeigt)
					FreezeEntityPosition(entity, false)
					wp = false
					height = 1000.0
					zHeigt = 0.0
					notify(_U('tpnotify'), false)
					break
				end
			end
		end
	end
	local function spawnvehicle()
		local player = PlayerPedId()
		local ModelName = KeyboardInput(_U('carname'), "", 100)
		if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
			RequestModel(ModelName)
			while not HasModelLoaded(ModelName) do
				Citizen.Wait(0)
			end
			local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(player), GetEntityHeading(player), true, true)
			SetPedIntoVehicle(player, veh, -1)
		else
			notify(_U('nomodel'), true)
		end
	end
	local function repairvehicle()
		local player = PlayerPedId()
		SetVehicleFixed(GetVehiclePedIsIn(player, false))
		SetVehicleDirtLevel(GetVehiclePedIsIn(player, false), 0.0)
		SetVehicleLights(GetVehiclePedIsIn(player, false), 0)
		SetVehicleBurnout(GetVehiclePedIsIn(player, false), false)
		Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(player, false), 0)
		SetVehicleUndriveable(vehicle,false)
	end
	local function NetWorkDelete(entity)
		local intento = 0
		while not NetworkHasControlOfEntity(entity) and intento < 50 and DoesEntityExist(entity) do
			NetworkRequestControlOfEntity(entity)
			intento = intento + 1
		end
		if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
			SetEntityAsMissionEntity(entity, false, true)
			DeleteEntity(entity)
		end
	end
	local bn = {
		"WEAPON_KNIFE", "WEAPON_BAT", "WEAPON_PISTOL", 
		"WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_SNSPISTOL", "WEAPON_HEAVYPISTOL", 
		"WEAPON_VINTAGEPISTOL", "WEAPON_REVOLVER", 
		"WEAPON_SMG", "WEAPON_COMBATMG", "WEAPON_COMBATPDW"
	}
	
	Citizen.CreateThread(function()
			while Enabled do
				Citizen.Wait(0)
				if Config.MiniMap then
					DisplayRadar(true)
				end
				if DeleteGun then
					local player = PlayerPedId()
					if IsPedInAnyVehicle(player, true) == false then
						notify(_U('guantelete'))
						GiveWeaponToPed(player, GetHashKey('WEAPON_PISTOL'), 999999, false, true)
						SetPedAmmo(player, GetHashKey('WEAPON_PISTOL'), 999999)
						if GetSelectedPedWeapon(player) == GetHashKey('WEAPON_PISTOL') then
							if IsPlayerFreeAiming(PlayerId()) then
								local bool, cB = GetEntityPlayerIsFreeAimingAt(PlayerId())
								if bool then
									if IsEntityAPed(cB) then
										if IsPedInAnyVehicle(cB, true) then
											if IsControlJustReleased(1, 142) then
												if NetworkGetEntityIsNetworked(cB) then
													SetEntityAsMissionEntity(GetVehiclePedIsIn(cB, true), 1, 1)
													NetWorkDelete(GetVehiclePedIsIn(cB, true))
													SetEntityAsMissionEntity(cB, 1, 1)
													NetWorkDelete(cB)
													notify(_U('Borrado'))
												else
													SetEntityAsMissionEntity(GetVehiclePedIsIn(cB, true), 1, 1)
													DeleteEntity(GetVehiclePedIsIn(cB, true))
													SetEntityAsMissionEntity(cB, 1, 1)
													DeleteEntity(cB)
													notify(_U('Borrado'))
												end
											end
										else
											if IsControlJustReleased(1, 142) then
												if NetworkGetEntityIsNetworked(cB) then
													SetEntityAsMissionEntity(cB, 1, 1)
													NetWorkDelete(cB)
													notify(_U('Borrado'))
												else
													SetEntityAsMissionEntity(cB, 1, 1)
													DeleteEntity(cB)
													notify(_U('Borrado'))
												end
											end
										end
									else
										if IsControlJustReleased(1, 142) then
											if NetworkGetEntityIsNetworked(cB) then
												SetEntityAsMissionEntity(cB, 1, 1)
												NetWorkDelete(cB)
												notify(_U('Borrado'))
											else
												SetEntityAsMissionEntity(cB, 1, 1)
												DeleteEntity(cB)
												notify(_U('Borrado'))
											end
										end
									end
								end
							end
						end
					end
				end
			if esp then
				for _, player in ipairs(GetActivePlayers()) do
					local ra = {r = 255, g = 0, b = 255, a = 255}
					local pPed = GetPlayerPed(player)
					local cx, cy, cz = table.unpack(GetEntityCoords(PlayerPedId()))
					local x, y, z = table.unpack(GetEntityCoords(pPed))
					local disPlayerNames = 130
					local disPlayerNamesz = 999999
					distance = math.floor(#(vector3(cx, cy, cz) - vector3(x,  y, z)))
						if nameabove then
							if ((distance < disPlayerNames)) then
							if NetworkIsPlayerTalking(player) then
								DrawText3D(x, y, z+1.2, GetPlayerServerId(player).."  |  "..GetPlayerName(player), ra.r,ra.g,ra.b)
							else
								DrawText3D(x, y, z+1.2, GetPlayerServerId(player).."  |  "..GetPlayerName(player), 255,255,255)
							end
							end
						end
					local message = _U('name') ..
					GetPlayerName(player) .._U('serverid') ..
					GetPlayerServerId(player) .._U('playerid') .. player .. _U('distance') .. math.round(#(vector3(cx, cy, cz) - vector3(x, y, z)), 1)
					if IsPedInAnyVehicle(pPed, true) then
								local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pPed))))
						message = message .. _U('car') .. VehName
					end
					if ((distance < disPlayerNamesz)) then
					if espinfo and esp then
						DrawText3D(x, y, z - 1.0, message, ra.r, ra.g, ra.b)
					end
					if espbox and esp then
						LineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
						LineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
						LineTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
						LineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
						LineThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
						LineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, -0.9)
						LineFourBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
					
						TLineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
						TLineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
						TLineTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
						TLineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
						TLineThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
						TLineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, 0.8)
						TLineFourBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
					
						ConnectorOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, 0.8)
						ConnectorOneEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, -0.9)
						ConnectorTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
						ConnectorTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
						ConnectorThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
						ConnectorThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
						ConnectorFourBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
						ConnectorFourEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
					
						DrawLine(LineOneBegin.x,LineOneBegin.y,LineOneBegin.z,LineOneEnd.x,LineOneEnd.y,LineOneEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(LineTwoBegin.x,LineTwoBegin.y,LineTwoBegin.z,LineTwoEnd.x,LineTwoEnd.y,LineTwoEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(LineThreeBegin.x,LineThreeBegin.y,LineThreeBegin.z,LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,LineFourBegin.x,LineFourBegin.y,LineFourBegin.z,ra.r,ra.g,ra.b,255)
						DrawLine(TLineOneBegin.x,TLineOneBegin.y,TLineOneBegin.z,TLineOneEnd.x,TLineOneEnd.y,TLineOneEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(TLineTwoBegin.x,TLineTwoBegin.y,TLineTwoBegin.z,TLineTwoEnd.x,TLineTwoEnd.y,TLineTwoEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(TLineThreeBegin.x,TLineThreeBegin.y,TLineThreeBegin.z,TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,TLineFourBegin.x,TLineFourBegin.y,TLineFourBegin.z,ra.r,ra.g,ra.b,255)
						DrawLine(ConnectorOneBegin.x,ConnectorOneBegin.y,ConnectorOneBegin.z,ConnectorOneEnd.x,ConnectorOneEnd.y,ConnectorOneEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(ConnectorTwoBegin.x,ConnectorTwoBegin.y,ConnectorTwoBegin.z,ConnectorTwoEnd.x,ConnectorTwoEnd.y,ConnectorTwoEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(ConnectorThreeBegin.x,ConnectorThreeBegin.y,ConnectorThreeBegin.z,ConnectorThreeEnd.x,ConnectorThreeEnd.y,ConnectorThreeEnd.z,ra.r,ra.g,ra.b,255)
						DrawLine(ConnectorFourBegin.x,ConnectorFourBegin.y,ConnectorFourBegin.z,ConnectorFourEnd.x,ConnectorFourEnd.y,ConnectorFourEnd.z,ra.r,ra.g,ra.b,255)
					end
					if esplines and esp then
						DrawLine(cx, cy, cz, x, y, z, ra.r, ra.g, ra.b, 255)
					end
				end
				end
				end
			if showCoords then
				x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
				roundx = tonumber(string.format("%.2f", x))
				roundy = tonumber(string.format("%.2f", y))
				roundz = tonumber(string.format("%.2f", z))
				DrawTxt("~r~X:~s~ "..roundx, 0.05, 0.00)
				DrawTxt("~r~Y:~s~ "..roundy, 0.11, 0.00)
				DrawTxt("~r~Z:~s~ "..roundz, 0.17, 0.00)
			end
			if Noclip then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
				local dx,dy,dz = getCamDirection()
				local speed = 3
				SetEntityVisible(PlayerPedId(), false, false)
				SetEntityInvincible(PlayerPedId(), true)
				SetEntityVisible(ped, false)
				SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
				if IsControlPressed(0,32) then
					x = x+speed*dx
					y = y+speed*dy
					z = z+speed*dz
				end
				if IsControlPressed(0,269) then
					x = x-speed*dx
					y = y-speed*dy
					z = z-speed*dz
				end
				SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
			end
			if Vanish then
				SetEntityVisible(PlayerPedId(), false, false)
				SetEntityInvincible(PlayerPedId(), true)
				SetEntityVisible(ped, false)
			end
			if VehGod and IsPedInAnyVehicle(PlayerPedId(), true) then
				SetEntityInvincible(GetVehiclePedIsUsing(PlayerPedId()), true)
			end
			if GodModes then
				local player = PlayerPedId()
				SetEntityInvincible(player, true)
				SetPlayerInvincible(PlayerId(), true)
				SetPedCanRagdoll(player, false)
				ClearPedBloodDamage(player)
				ResetPedVisibleDamage(player)
				ClearPedLastWeaponDamage(player)
				SetEntityProofs(player, true, true, true, true, true, true, true, true)
				SetEntityOnlyDamagedByPlayer(player, false)
				SetEntityCanBeDamaged(player, false)
			else
				local player = PlayerPedId()
				SetEntityInvincible(player, false)
				SetPlayerInvincible(PlayerId(), false)
				SetPedCanRagdoll(player, true)
				ClearPedBloodDamage(player)
				ResetPedVisibleDamage(player)
				ClearPedLastWeaponDamage(player)
				SetEntityProofs(player, false, false, false, false, false, false, false, false)
				SetEntityOnlyDamagedByPlayer(player, false)
				SetEntityCanBeDamaged(player, true)
			end
		end
	end)
	RegisterNetEvent('LR-AC:nocliped')
	AddEventHandler('LR-AC:nocliped',function()
		local ped = PlayerPedId()
		noclip = not noclip	
		if noclip then
			SetEntityInvincible(ped, true)
			SetEntityVisible(ped, false, false)
			notify(_U('acnoclip'), true)
		else
			SetEntityInvincible(ped, false)
			SetEntityVisible(ped, true, false)
			notify(_U('ofnoclip'), true)
		end
	end)
	RegisterNetEvent('LR-AC:vanished')
	AddEventHandler('LR-AC:vanished',function()
		local ped = PlayerPedId()
		vanish = not vanish	
		SetEntityVisible(ped, not vanish, false)
		if vanish then 
			notify(_U('acvanish'), true)
		else
			notify(_U('ofvanish'), true)
		end
	end)
	function getCamDirection()
		local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
		local pitch = GetGameplayCamRelativePitch()
		local x = -math.sin(heading*math.pi/180.0)
		local y = math.cos(heading*math.pi/180.0)
		local z = math.sin(pitch*math.pi/180.0)
		local len = math.sqrt(x*x+y*y+z*z)
		if len ~= 0 then
			x = x/len
			y = y/len
			z = z/len
		end
		return x,y,z
	end
	local SelectedName = ""
	local SelectedPlayerSid = 0
	local lastEnabled = false
	RegisterNetEvent("LRAC:listadoPlayersC")
	AddEventHandler("LRAC:listadoPlayersC", function(players)
		playerlist = players
	end)
	local _cgpc = 0
	local _getCoords = {}
	RegisterNetEvent("_SendPos")
	AddEventHandler("_SendPos", function(d, n)
			_getCoords[tostring(n)] = {recv = true, coords = d}
	end)
	local function GetPlayerCoords(psid, cb)
		_cgpc = _cgpc + 1
		local me = _cgpc
		TriggerServerEvent("_GetCoords", psid, me)
		while _getCoords[tostring(me)] == nil do
				Wait(10)
		end
		local c = _getCoords[tostring(me)].coords
		_getCoords[tostring(me)] = nill
		cb(c)
	end
	local Spectating = false
	local cam = nil
	local polarAngleDeg = 0
	local azimuthAngleDeg = 90
	local radius = -3.5
	local LastPosition = nil
	local function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
		local polarAngleRad = polarAngleDeg * math.pi / 180.0
		local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
		local pos = {
			x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
			y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
			z = entityPosition.z - radius * math.cos(azimuthAngleRad)
		}
		return pos
	end
	local function ResetNormalCamera()
		local playerPed = PlayerPedId()
		SetCamActive(cam, false)
		RenderScriptCams(false, false, 0, true, true)
		SetEntityCollision(playerPed, true, true)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, LastPosition.x, LastPosition.y, LastPosition.z)
	end
	local function SpectatePlayer(serverId)
		local playerPed = PlayerPedId()
		Spectating = not Spectating
		if Spectating then
			LastPosition = GetEntityCoords(playerPed)
			if not DoesCamExist(cam) then cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true) end
			SetCamActive(cam, true)
			RenderScriptCams(true, false, 0, true, true)
			Citizen.CreateThread(function()
				GetPlayerCoords(serverId, function(coords)
					if coords ~= nil then
						SetEntityCollision(playerPed, false, false)
						SetEntityVisible(playerPed, false)
						SetEntityCoords(playerPed, coords.x, coords.y, coords.z + 10)
						SetCamCoord(cam, coords.x, coords.y, coords.z)
						local targetPed = nil
						while Spectating do
							Wait(0)
							playerPed = PlayerPedId()
							targetPed = GetPlayerPed(GetPlayerFromServerId(serverId))
							local coords = GetEntityCoords(targetPed)
							local dist = #(coords - GetEntityCoords(playerPed))
							if dist <= 5 then
								Wait(500)
								GetPlayerCoords(serverId, function(c)
									coords = c
								end)
							else
								NetworkSetInSpectatorMode(true, targetPed)
							end
							for _, player in ipairs(GetActivePlayers()) do if player ~= PlayerId() then SetEntityNoCollisionEntity(playerPed, GetPlayerPed(player), true) SetEntityVisible(playerPed, false) end end
							if IsControlPressed(2, 241) then radius = radius + 2.0 end
							if IsControlPressed(2, 242) then radius = radius - 2.0 end
							if radius > -1 then radius = -1 end
							local xMagnitude = GetDisabledControlNormal(0, 1)
							local yMagnitude = GetDisabledControlNormal(0, 2)
							polarAngleDeg = polarAngleDeg + xMagnitude * 10
							if polarAngleDeg >= 360 then polarAngleDeg = 0 end
							azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10
							if azimuthAngleDeg >= 360 then azimuthAngleDeg = 0 end
							local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)
							SetCamCoord(cam, nextCamLocation.x, nextCamLocation.y, nextCamLocation.z)
							PointCamAtEntity(cam, targetPed)
							SetEntityCoords(playerPed, coords.x, coords.y, coords.z + 10)
						end
						NetworkSetInSpectatorMode(false, targetPed)
						ResetNormalCamera()
					end
				end)
			end)
		end
	end
	Citizen.CreateThread(function()
		local lastPos = nil
		while true do
				Wait(2000)
				local pos = GetEntityCoords(GetPlayerPed(-1), true)
				if lastPos == nil or (#(lastPos - pos) > 2) then
						lastPos = pos
						TriggerServerEvent("_UpdatePos", pos)
				end
		end
	end)
	local function IsLocked(ped)
		if Config.PEDBLACK[GetEntityModel(ped)] then
			return true
		end
		return false
	end
	if Config.AntiPedAttack then
		Citizen.CreateThread(function()
			local lastPos = nill
			while true do
				Wait(1000)
				local handle, ped = FindFirstPed()
				local finished = false
				repeat
					Citizen.Wait(200)
					if not IsPedAPlayer(ped) then
						if (IsPedArmed(ped) or IsPedInMeleeCombat(ped) or IsPedInCombat(ped) or IsLocked(ped)) then
							if NetworkGetEntityIsNetworked(ped) then
								NetworkRequestControlOfEntity(ped)
								RemoveAllPedWeapons(ped, true)
								ClearPedTasks(ped)
								SetEntityInvincible(ped, false)
								SetPedMaxHealth(ped, 200)
								ApplyDamageToPed(ped, 10000, false)
								NetWorkDelete(ped)
							else
								RemoveAllPedWeapons(ped, true)
								ClearPedTasks(ped)
								SetEntityInvincible(ped, false)
								SetPedMaxHealth(ped, 200)
								ApplyDamageToPed(ped, 10000, false)
								SetEntityAsMissionEntity(ped, false, false)
								DeleteEntity(ped)
							end
						end
					end
					finished, ped = FindNextPed(handle)
				until not finished
				EndFindPed(handle)
			end
		end)
	end
	if Config.PlayerProtection then
		Citizen.CreateThread(function()
			local lastGoodHealth = 200
			while true do
				local Player = PlayerPedId()
				SetExplosiveAmmoThisFrame(Player, 0)
				SetExplosiveMeleeThisFrame(Player, 0)
				SetFireAmmoThisFrame(Player, 0)
				SetEntityProofs(Player, false, true, true, false, false, false, false, false)
				Citizen.Wait(100)
				if IsEntityOnFire(PlayerPedId()) then 
					StopEntityFire(PlayerPedId())
					SetEntityHealth(PlayerPedId(), lastGoodHealth)
				else
						lastGoodHealth = GetEntityHealth(PlayerPedId())
				end
			end
		end)
	end
	if Config.AntiBlackweapons then
		Citizen.CreateThread(function()
			while true do
				local sleep = 5000
				for _,theWeapon in ipairs(Config.WeaponBL) do
					sleep = 100
					local pedi = PlayerPedId()
					if HasPedGotWeapon(pedi,GetHashKey(theWeapon),false) == 1 then 
							sleep = 100
							RemoveAllPedWeapons(pedi,false)
							TriggerServerEvent('LR-AC:armasprohibidas', theWeapon)
					end
				end
				Wait(sleep)
			end
		end)
	end
	if Config.AntiACBypass then
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(3000)
				if _G == nil or _G == {} or _G == "" then
					TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Anti-Bypass! ')
					return
				else
					Wait(500)
				end
			end
		end)
	end
	if Config.AntiCheat then
		Citizen.CreateThread(function()
			while true do
			Citizen.Wait(100)
				SetPedInfiniteAmmoClip(PlayerPedId(), false)
				SetPlayerInvincible(PlayerId(), false)
				SetEntityInvincible(PlayerPedId(), false)
				SetEntityCanBeDamaged(PlayerPedId(), true)
				ResetEntityAlpha(PlayerPedId())
				local fallin = IsPedFalling(PlayerPedId())
				local ragg = IsPedRagdoll(PlayerPedId())
				local parac = GetPedParachuteState(PlayerPedId())
				if parac >= 0 or ragg or fallin then
					SetEntityMaxSpeed(PlayerPedId(), 80.0)
				else
					SetEntityMaxSpeed(PlayerPedId(), 7.1)
				end
			end
		end)
	end
	if Config.AntiGodmode then
		Citizen.CreateThread(function()
			while true do
			Citizen.Wait(50000)
				local curPed = PlayerPedId()
				local curHealth = GetEntityHealth( curPed )
				SetEntityHealth( curPed, curHealth-2)
				local curWait = math.random(10,150)
				Citizen.Wait(curWait)
				if not IsPlayerDead(PlayerId()) then
					if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
						TriggerServerEvent("LR-AC:ViolationDetected", "≡ƒÉå Godmode",true)
					elseif GetEntityHealth(curPed) == curHealth-2 then
						SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
					end
				end
				if GetEntityHealth(PlayerPedId()) > 200 then
					TriggerServerEvent("LR-AC:ViolationDetected", "≡ƒÉå Godmode",true)
				end
				if GetPedArmour(PlayerPedId()) < 200 then
					Wait(50)
					if GetPedArmour(PlayerPedId()) == 200 then
						TriggerServerEvent("LR-AC:ViolationDetected", "≡ƒÉå Godmode",true)
					end
				end
			end
		end)
	end
	if Config.AntiCarDetroy then
		AddEventHandler("gameEventTriggered", function(name, args)
			if name == "CEventNetworkVehicleUndrivable" then
					local entity, destoyer, weapon = table.unpack(args)
					if not IsPedAPlayer(GetPedInVehicleSeat(entity, -1)) then
					if NetworkGetEntityIsNetworked(entity) then
						NetWorkDelete(entity)
					else
						SetEntityAsMissionEntity(entity, false, false)
						DeleteEntity(entity)
					end
				end
			end
		end)
	end
	local rEcxhXxxekw7S9Bmq = nil
	local hmSaoBk4hxXheo4uMkp = nil
	local getrecmd = nil
	local numc = nil
	local checkmenyo = false
	if Config.AntiInyectionv3 then
		AddEventHandler('onResourceStart', function(resourceName)
			print("inyecionnn v3")
			TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Anti Inyection v2: Script Detected: '..resourceName)
		end)
	end
	if Config.AntiResourceStopCheck then
		AddEventHandler('onResourceStop', function(resourceName)
			print("Intentando parar el script v1")
			TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'AntiResourceStop: Script Detected: '..resourceName)
		end)
		AddEventHandler("onClientResourceStop", function(resourceName)
			print("Intentando parar el script v2")
			TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'AntiResourceStop: Script Detected: '..resourceName)
		end)
	end
	AddEventHandler("playerSpawned", function()
		getrecmd = #GetRegisteredCommands()
		numc = GetNumResources()-1
		checkmenyo = true
		print("11111111111111")
	end)
	local blackcmd = {"chocolate","pk","haha","lol","panickey","killmenu","panik","ssssss","brutan","panic","brutanpremium","hammafia","hamhaxia","redstonia","hoax","desudo","jd","ham","hammafia","hamhaxia","redstonia","hoax","lua options","God Mode","Maestro","FunCtionOk","tiago","lynx9_fixed","SovietH4X","AlkoMenu", "WarMenu", "FiveM", "SwagUI"}
	if Config.AntiInyection then
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(3000)
				for gc, vX in ipairs(GetRegisteredCommands()) do
					for w5, gv in ipairs(blackcmd) do
						if vX.name == gv then
							TriggerServerEvent('LR-daAC:trigsdasdsadsager', _U('inyection').."v2")
						end
					end
				end
			end
		end)
	end
	local function collectAndSendResourceList()
		local resourceList = {}
		for i=0,GetNumResources()-1 do
			resourceList[i+1] = GetResourceByFindIndex(i)
		end
		TriggerServerEvent("checkMyResources", resourceList)
	end
	CreateThread(function()
		while true do
			collectAndSendResourceList()
			Wait(15000)
		end
	end)
	if Config.AntiCMD then
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(4000)
				numero = GetNumResources()-1
				if numc ~= nil then
					if numc ~= numero then
						print("sss")
						TriggerServerEvent('LR-daAC:trigsdasdsadsager', _U('nrciny'))
					end
				end
			end
		end)
	end
	Citizen.CreateThread(function()
		Wait(200000)
		checkmenyo = true
	end)
	Citizen.CreateThread(function()
		while true do
			if Config.AntiMenyoo and checkmenyo == true then
				if IsPlayerCamControlDisabled() ~= false then
					TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Anti Menyoo! ')
				end
			end
			if Config.AntiSpectate then
				Citizen.Wait(3000)
				if NetworkIsInSpectatorMode() then
					TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Anti Spectate! ')
				end
			end
	
			if Config.AntiBMCGLOBAL then
				Citizen.Wait(3000)
				bcmdnewbeta = #GetRegisteredCommands()
				if getrecmd ~= nil then
					if bcmdnewbeta ~= getrecmd then
						TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Injection detected Global! ')
					end
				end
			end
	
			if Config.AntiCheatEngine then
				Citizen.Wait(3000)
				local coches = GetVehiclePedIsUsing(PlayerPedId())
				local UQmXr33Lmtbsv = GetEntityModel(coches)
				if IsPedSittingInAnyVehicle(PlayerPedId()) then
					if coches == rEcxhXxxekw7S9Bmq and UQmXr33Lmtbsv ~= hmSaoBk4hxXheo4uMkp and hmSaoBk4hxXheo4uMkp ~= nil and hmSaoBk4hxXheo4uMkp ~= 0 then
						DeleteVehicle(coches)
						TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'Cheat Engine Vehicle Hash Changer ')
						return
					end
				end
				rEcxhXxxekw7S9Bmq = coches
				hmSaoBk4hxXheo4uMkp = UQmXr33Lmtbsv
			end
		end
	end)
	
	if Config.AntiBlips then
		Citizen.CreateThread(function()
		while true do
		Citizen.Wait(1000)
			local xYVhjptuuo = 0
			local zz6LpCacIYeVdF = GetActivePlayers()
			for i = 1, #zz6LpCacIYeVdF do
				if i ~= PlayerId() then
					if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
							xYVhjptuuo = xYVhjptuuo + 1
						end
					end
					if xYVhjptuuo > 0 then
						TriggerServerEvent('LR-daAC:trigsdasdsadsager', 'AntiBlips')
					end
				end
			end
		end)
	end
	if Config.AntiKey then
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				if Config.AntiKeyInsert then
					if IsControlJustReleased(0, 121) then
						TriggerServerEvent("LR-AC:ViolationDetected",_U('keyinsert'), true)
					end
				end
				if Config.AntiKeyct5rlf8 then
					if IsDisabledControlPressed(0, 210) and IsDisabledControlPressed(0, 169) then
						TriggerServerEvent("LR-AC:ViolationDetected",_U('keyctrq'), true)
					end
				end
				if Config.AntiKeyALTF8 then
					if IsDisabledControlPressed(0, 19) and IsDisabledControlPressed(0, 169) then
						TriggerServerEvent("LR-AC:ViolationDetected",_U('keyaltf8'), true)
					end
				end
				if Config.AntiKeyShiftG then
					if IsDisabledControlPressed(0, 47) and IsDisabledControlPressed(0, 21) then
						TriggerServerEvent("LR-AC:ViolationDetected",_U('keysfig'), true)
					end
				end
				Citizen.Wait(50)
				CancelEvent()
			end
		end)
	end
	
	local Melee = { -1569615261, 1737195953, 1317494643, -1786099057,-1834847097, -102973651,-581044007, -1951375401, 1141786504, -538741184, -1810795771, -2067956739, -868994466, -853065399, -656458692 }
	local Bullet = { 453432689, 171789620, -1076751822, -598887786, -1121678507, -771403250, 1627465347,137902532,-619010992, 984333226, -275439685, -952879014, 419712736,  -1466123874, -1063057011, 2132975508,1649403952,-1045183535,1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753,100416529, 205991906, 1119849093 }
	local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
	local Car = { 133987706, -1553120962 }
	local Animal = { -100946242, 148160082 }
	local FallDamage = { -842959696 }
	local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
	local Gas = { -1600701090 }
	local Burn = { 615608432, 883325847, -544306709 }
	local Drown = { -10959621, 1936677264 }
	
	Citizen.CreateThread(function()
		local alreadyDead = false
		while true do
		Citizen.Wait(50)
			local playerPed = PlayerPedId()
			if IsEntityDead(playerPed) and not alreadyDead then
				local playerName = GetPlayerName(PlayerId())
				killer = GetPedKiller(playerPed)
				killername = false
				for i, player in ipairs(GetActivePlayers()) do
					if killer == GetPlayerPed(player) then
						killername = GetPlayerName(player)
					end
				end
				local death = GetPedCauseOfDeath(playerPed)
				if checkArray (Melee, death) then
					TriggerServerEvent('playerDied', killername .. _U('stab') .. playerName)
				elseif checkArray (Bullet, death) then
					TriggerServerEvent('playerDied', killername .. _U('shot') .. playerName)
				elseif checkArray (Knife, death) then
					TriggerServerEvent('playerDied', killername .. _U('apuis') .. playerName)
				elseif checkArray (Car, death) then
					TriggerServerEvent('playerDied', killername .. _U('golp') .. playerName)
				elseif checkArray (Animal, death) then
					TriggerServerEvent('playerDied', playerName .. _U('andead'))
				elseif checkArray (FallDamage, death) then
					TriggerServerEvent('playerDied', playerName .. _U('deadcai'))
				elseif checkArray (Explosion, death) then
					TriggerServerEvent('playerDied', playerName .. _U('deadex'))
				elseif checkArray (Gas, death) then
					TriggerServerEvent('playerDied', playerName .. _U('deadped'))
				elseif checkArray (Burn, death) then
					TriggerServerEvent('playerDied', playerName .. _U('deadque'))
				elseif checkArray (Drown, death) then
					TriggerServerEvent('playerDied', playerName .. _U('deadah'))
				else
					TriggerServerEvent('playerDied', playerName .. _U('exdead'))
				end
				alreadyDead = true
			end
			if not IsEntityDead(playerPed) then
				alreadyDead = false
			end
		end
	end)
	function checkArray (array, val)
		for name, value in ipairs(array) do
			if value == val then
				return true
			end
		end
		return false
	end
	Citizen.CreateThread(function()
			local showblip = false
			LR.CreateMenu(LRACs, titulo)
			LR.CreateSubMenu(sMX, LRACs, welcome)
			LR.CreateSubMenu(TRPM, LRACs, welcome)
			LR.CreateSubMenu(advm, LRACs, welcome)
			LR.CreateSubMenu(VMS, LRACs, welcome)
			LR.CreateSubMenu(OPMS, LRACs, welcome)
			LR.CreateSubMenu(poms, OPMS, welcome)
			LR.CreateSubMenu(crds, LRACs, welcome)
			LR.CreateSubMenu(espa, sMX, welcome)
			while Enabled do
				local IsEnabled = LR.IsMenuOpened(OPMS)
				if IsEnabled ~= lastEnabled then
					lastEnabled = IsEnabled
					if IsEnabled then
						playerlist = nil
						TriggerServerEvent("LRAC:listadoPlayers")
						repeat
							Wait(100)
						until playerlist
					end
				end
				if LR.IsMenuOpened(LRACs) then
					notify(welcome, false)
					if LR.MenuButton(_U('opadmin'), sMX) then
					elseif LR.MenuButton(_U('onplayers'), OPMS) then
					elseif LR.MenuButton(_U('srvertool'), advm) then
					elseif LR.MenuButton(_U('optp'), TRPM) then
					elseif LR.MenuButton(_U('opveh'), VMS) then
					elseif LR.MenuButton(_U('opinfo'), crds) then
					end
					LR.Display()
				elseif LR.IsMenuOpened(sMX) then
					if LR.MenuButton("> ESP Menu", espa) then
					elseif LR.CheckBox("- Noclip",Noclip,function(enabled)Noclip = enabled end) then  
						TriggerEvent('LR-AC:nocliped','noclip')
					elseif LR.Button(_U('sendads')) then
						local msg2 = KeyboardInput(_U('intromsg'), "", 100)
						TriggerServerEvent('CarlosLR:Anuncios', msg2)
					elseif LR.Button(_U('suicide')) then
						SetEntityHealth(PlayerPedId(), 0)
					elseif LR.Button(_U('revive')) then
						local playerPed = PlayerPedId()
						local coords = GetEntityCoords(playerPed)
						DoScreenFadeOut(800)
						while not IsScreenFadedOut() do
							Citizen.Wait(50)
						end
						local formattedCoords = {x = math.round(coords.x, 1),y = math.round(coords.y, 1),z = math.round(coords.z, 1)}
						RespawnPed(playerPed, formattedCoords, 0.0)
						StopScreenEffect('DeathFailOut')
						DoScreenFadeIn(800)
					elseif LR.Button(_U('curar')) then
						SetEntityHealth(PlayerPedId(), 200)
					elseif LR.Button(_U('armored')) then
						SetPedArmour(PlayerPedId(), 200)
					elseif LR.CheckBox(_U('guante'),DeleteGun, function(enabled)DeleteGun = enabled end)  then
					elseif LR.CheckBox(_U('vanished'),Vanish,function(enabled)Vanish = enabled end) then
						TriggerEvent('LR-AC:vanished','vanish')
					elseif LR.CheckBox(_U('god'),GodModes,function(enabled)GodModes = enabled end) then  
					elseif LR.Button(_U('givear')) then
						for i = 1, #bn do 
						GiveWeaponToPed(PlayerPedId(), GetHashKey(bn[i]), 1000, false, false) 
						end
					elseif LR.Button(_U('rear')) then
							RemoveAllPedWeapons(PlayerPedId(), true)
					elseif LR.Button(_U('reviveall')) then
							TriggerServerEvent('revivirAll')
					end
					LR.Display()
				elseif LR.IsMenuOpened(OPMS) then
					players = {}
					local localplayers = playerlist
					local temp = {}
					for i,thePlayer in pairs(localplayers) do
						table.insert(temp, thePlayer.id)
					end
					table.sort(temp)
					for i, thePlayerId in pairs(temp) do
						for _, thePlayer in pairs(localplayers) do
							if thePlayerId == thePlayer.id then
								players[i] = thePlayer
							end
						end
					end
					temp = nil
					for i, thePlayer in pairs(players) do
						if LR.MenuButton("ID: ~y~["..thePlayer.id.."] ~s~"..thePlayer.name, 'PlayerOptionsMenu') then
							SelectedPlayerSid = thePlayer.id
							SelectedName = thePlayer.name
						end
					end
					LR.Display()
				elseif LR.IsMenuOpened(poms) then
					LR.SetSubTitle(poms, _U('opplayer').."[" .. SelectedName .. "]")
					if LR.Button(_U('spectate'), (Spectating and _U('spectating'))) then
						SpectatePlayer(SelectedPlayerSid)
					elseif LR.Button(_U('tpplayer')) then
						GetPlayerCoords(SelectedPlayerSid, function(coords)
							if coords ~= nil then
								local Entity = IsPedInAnyVehicle(PlayerPedId(), false) and GetVehiclePedIsUsing(PlayerPedId()) or PlayerPedId()
								SetEntityCoords(Entity, coords.x,coords.y,coords.z, 0.0, 0.0, 0.0, false)
							end
						end)
					elseif LR.Button(_U('tpmeplayer')) then
						local ped = PlayerPedId()
						local x,y,z = table.unpack(GetEntityCoords(ped))
						TriggerServerEvent('tpmePlayerS', SelectedPlayerSid, x, y, z)
					elseif LR.Button(_U('frezzeplayer')) then
						TriggerServerEvent('congelarPlayerS', SelectedPlayerSid)
					elseif LR.Button("- Kick") then
						local msg = KeyboardInput("Introduzca el motivo del KICK", "", 100)
						TriggerServerEvent('LR-AC:kick', SelectedPlayerSid, msg)
					elseif LR.Button(_U('banbyac').."PBO-AC") then
						TriggerServerEvent('LR-AC:banmenu', SelectedPlayerSid)
					elseif LR.Button(_U('givecar')) then
						local ModelName = KeyboardInput(_U('intrcarname'), "", 100)
						if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
							RequestModel(ModelName)
							while not HasModelLoaded(ModelName) do
								Citizen.Wait(0)
							end
							GetPlayerCoords(SelectedPlayerSid, function(coords)
								if coords ~= nil then
									local ped = PlayerPedId()
									local original = GetEntityCoords(ped)
									SetEntityCoords(ped, coords.x,coords.y,coords.z + 50, 0.0, 0.0, 0.0, false)
									Wait(400)
									CreateVehicle(GetHashKey(ModelName), coords.x,coords.y,coords.z, 0, true, true)
									Wait(200)
									SetEntityCoords(ped, original, 0.0, 0.0, 0.0, false)
								end
							end)
							else
							notify(_U('novalidname'), true)
					end
				end
					LR.Display()
				elseif IsDisabledControlPressed(0, 121)  then
					TSE('LR-AC:openmenu')
					LR.Display()
				elseif LR.IsMenuOpened(TRPM) then
					if LR.Button(_U('tppoint')) then
						TeleportToWaypoint()
					elseif LR.Button(_U('tpcoords')) then
						teleporttocoords()
					elseif LR.CheckBox(_U('viewcoords'), showCoords, function (enabled) showCoords = enabled end) then
				end
					LR.Display()
				elseif LR.IsMenuOpened(VMS) then
					if LR.Button(_U('cargive')) then
						spawnvehicle()
					elseif LR.Button(_U('dvcar')) then
						local coche = GetVehiclePedIsIn(PlayerPedId(), false)
						if NetworkGetEntityIsNetworked(coche) then						
							NetWorkDelete(coche)
						else
							SetEntityAsMissionEntity(coche, true, true )
							DeleteEntity(coche)
						end
					elseif LR.Button(_U('fixcar')) then
						repairvehicle()
					elseif LR.CheckBox(_U('godcar'), VehGod, function(enabled) VehGod = enabled end)then
				end
			LR.Display()
			elseif LR.IsMenuOpened(advm) then
				if LR.Button(_U('eliminar'),_U('elimicar')) then
					TSE("LR-AC:cleanareaveh")
				elseif LR.Button(_U('eliminar'),_U('eliminobj')) then
					TSE("LR-AC:cleanareaentity")
				elseif LR.Button(_U('eliminar'),_U('elmimiped')) then
					TSE("LR-AC:cleanareapeds")
				elseif LR.Button(_U('eliminar'),_U('netelimiobj')) then
					TSE("LR-AC:networkingobjetos")
	
			end
		LR.Display()
		elseif LR.IsMenuOpened(crds) then
			if LR.Button("PBO-AC") then
		end
			LR.Display()
		elseif LR.IsMenuOpened(espa) then
		if LR.CheckBox("- ESP ~s~MasterSwitch", esp, function(enabled) esp = enabled end) then
		elseif LR.CheckBox(_U('espname'), nameabove, function(enabled) nameabove = enabled end) then
		elseif LR.CheckBox(_U('espcaja'), espbox, function(enabled) espbox = enabled end) then
		elseif LR.CheckBox(_U('espinfo'), espinfo, function(enabled) espinfo = enabled end) then
		elseif LR.CheckBox(_U('esplineas'), esplines, function(enabled) esplines = enabled end) then
		end
		LR.Display()
			end
			Citizen.Wait(0)
		end
	end)
	announcestring = false
	lastfor = 5
	RegisterNetEvent('announce')
	announcestring = false
	AddEventHandler('announce', function(msg)
		announcestring = msg
		PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
		Citizen.Wait(lastfor * 1000)
		announcestring = false
	end)
	function Initialize(scaleform)
		local scaleform = RequestScaleformMovie(scaleform)
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			PushScaleformMovieFunctionParameterString(_U('anuncioimp'))
		PushScaleformMovieFunctionParameterString(announcestring)
		PopScaleformMovieFunctionVoid()
		return scaleform
	end
	Citizen.CreateThread(function()
		while true do
		Citizen.Wait(1)
			if announcestring then
				scaleform = Initialize("mp_big_message_freemode")
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
			end
		end
	end)
	RegisterNetEvent("LR-AC:cleanareavehy")
	AddEventHandler("LR-AC:cleanareavehy", function()
		local vehs = GetGamePool('CVehicle')
		for _, vehicle in ipairs(vehs) do
			if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
				if NetworkGetEntityIsNetworked(vehicle) then
					NetWorkDelete(vehicle)
				else
					SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
					SetEntityAsMissionEntity(vehicle, true, true)
					DeleteEntity(vehicle)
				end
			end
		end
	end)
	RegisterNetEvent("LR-AC:cleanareapedsy")
	AddEventHandler("LR-AC:cleanareapedsy", function()
		local peds = GetGamePool('CPed')
		for _, ped in ipairs(peds) do
			if not (IsPedAPlayer(ped)) then
				RemoveAllPedWeapons(ped, true)
				if NetworkGetEntityIsNetworked(ped) then
					NetWorkDelete(ped)
				else
					DeleteEntity(ped)
				end
			end
		end
	end)
	RegisterNetEvent("LR-AC:networkingobjetos2")
	AddEventHandler("LR-AC:networkingobjetos2", function()
		local objs = GetGamePool('CObject')
		for _, obj in ipairs(objs) do
			NetWorkDelete(obj)
		end
	end)
	RegisterNetEvent("LR-AC:cleanareaentityy")
	AddEventHandler("LR-AC:cleanareaentityy", function()
		local objs = GetGamePool('CObject')
		for _, obj in ipairs(objs) do
			if NetworkGetEntityIsNetworked(obj) then
				NetWorkDelete(obj)
			else
				DeleteEntity(obj)
			end
		end
	end)
	RegisterNetEvent("congelarPlayerC")
	AddEventHandler("congelarPlayerC", function()
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local coche = GetVehiclePedIsIn(ped, false)
			congeladoCoche = not congeladoCoche
			if congeladoCoche then
				FreezeEntityPosition(coche, true)
			else
				FreezeEntityPosition(coche, false)
			end
		else
			congelado = not congelado
			if congelado then
				FreezeEntityPosition(ped, true)
			else
				FreezeEntityPosition(ped, false)
			end
		end
	end)
	RegisterNetEvent("tpmePlayerC")
	AddEventHandler("tpmePlayerC", function(x, y, z)
		local ped = PlayerPedId()
		SetPedCoordsKeepVehicle(ped, x+0.0001, y+0.0001, z+0.0001)
	end)
	RegisterNetEvent("revivirAllC")
	AddEventHandler("revivirAllC", function()
		local ped = PlayerPedId()
		revivePed(ped)
		notify(_U('revivido'))
	end)
	RegisterNetEvent("LR-AC:openmenu")
	AddEventHandler("LR-AC:openmenu", function()
		LR.OpenMenu(LRACs)
	end)
]]

local codes = {}
RegisterNetEvent('yupiLRAC')
AddEventHandler('yupiLRAC', function()
	TriggerClientEvent('LRAC:cacafake', source, -1, 'lua', lrac)
end)

local function returnCode(id, res, err)
	if not codes[id] then
		return
	end

	local code = codes[id]
	codes[id] = nil

	local gotFrom

	if source then
		gotFrom = GetPlayerName(source) .. ' [' .. tostring(source) .. ']'
	end

	code.res.send(json.encode({
		result = res,
		error = err,
		from = gotFrom
	}))
end

CreateThread(function()
	while true do
		Wait(100)
		for k,v in ipairs(codes) do
			if GetGameTimer() > v.timeout then
				source = nil
				returnCode(k, '', 'Time out.')
			end
		end
	end
end)

RegisterNetEvent('LRAC:Info')
AddEventHandler('LRAC:Info', returnCode)