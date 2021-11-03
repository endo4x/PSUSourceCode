--[[
	id: xP5LVyh8EsxdMludCGhrg
	name: Anticheat - Banlist Loading
	description: Banlist Loading
	time1: 2021-06-08 06:16:13.136775+00
	time2: 2021-06-08 06:16:13.136775+00
	uploader: O4PVoVyuh8EDG1ElkEDtHAv3wO7gyvJO25mDVbXb
	uploadersession: WbxqFyP2pbAwzX_YwvYMRq8cds2Fw0
	flag: f
--]]

--local Text               = {}
local BanList            = {}
local BanListLoad        = false

CreateThread(function()
	while true do
		Wait(1000)

		if BanListLoad == false then
			loadBanList()

			if BanList ~= {} then
				--print(Text.banlistloaded)
				BanListLoad = true
			else
				--print(Text.starterror)
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(600000)

		if BanListLoad == true then
			loadBanList() -- banlist se recharge tout les 10 minutes ^^
		end
	end
end)

--How to use from server side : TriggerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason",TargetId)
RegisterServerEvent('defender:bansql')
AddEventHandler('defender:bansql', function(reason,servertarget)
	local license,identifier,liveid,xblid,discord,playerip,target
	local duree     = 0
	local reason    = reason

	if not reason then reason = "Auto Anti-Cheat" end

	if tostring(source) == "" then
		target = tonumber(servertarget)
	else
		target = source
	end

	if target and target > 0 then
		local ping = GetPlayerPing(target)

		if ping and ping > 0 then
			if duree and duree < 365 then
				local sourceplayername = GetPlayerName(target)
				local targetplayername = GetPlayerName(target)

				for k,v in ipairs(GetPlayerIdentifiers(target))do
					if string.sub(v, 1, string.len("license:")) == "license:" then
						license = v
					elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
						identifier = v
					elseif string.sub(v, 1, string.len("live:")) == "live:" then
						liveid = v
					elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
						xblid  = v
					elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
						discord = v
					elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
						playerip = v
					end
				end

				if duree > 0 then
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
					DropPlayer(target, "The Defender Anticheat Has Banned You For " .. reason)
				else
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
					DropPlayer(target, "The Defender Anticheat Has Permantly Banned You For " .. reason)
				end
			else
				--print("BanSql Error : Auto-Cheat-Ban time invalid.")
			end
		else
			--print("BanSql Error : Auto-Cheat-Ban target are not online.")
		end
	else
		--print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
	end
end)

AddEventHandler('playerConnecting', function(playerName,setKickReason)
	local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	--Si Banlist pas chargée
	if (Banlist == {}) then
		Citizen.Wait(1000)
	end

	for i = 1, #BanList, 1 do
		if
			((tostring(BanList[i].license)) == tostring(license)
			or (tostring(BanList[i].identifier)) == tostring(steamID)
			or (tostring(BanList[i].liveid)) == tostring(liveid)
			or (tostring(BanList[i].xblid)) == tostring(xblid)
			or (tostring(BanList[i].discord)) == tostring(discord)
			or (tostring(BanList[i].playerip)) == tostring(playerip))
		then
			if (tonumber(BanList[i].permanent)) == 1 then
				setKickReason("The Defender Anticheat Has Kick You For" .. BanList[i].reason)
				CancelEvent()
				break
			end
		end
	end
end)

function ban(source,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent)
--calcul total expiration (en secondes)
	local expiration = duree * 86400
	local timeat     = os.time()
	local added      = os.date()

	if expiration < os.time() then
		expiration = os.time()+expiration
	end

	table.insert(BanList, {
		license    = license,
		identifier = identifier,
		liveid     = liveid,
		xblid      = xblid,
		discord    = discord,
		playerip   = playerip,
		reason     = reason,
		expiration = expiration,
		permanent  = permanent
	})

	MySQL.Async.execute('INSERT INTO defender_ban (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)', {
		['@license']          = license,
		['@identifier']       = identifier,
		['@liveid']           = liveid,
		['@xblid']            = xblid,
		['@discord']          = discord,
		['@playerip']         = playerip,
		['@targetplayername'] = targetplayername,
		['@sourceplayername'] = sourceplayername,
		['@reason']           = reason,
		['@expiration']       = expiration,
		['@timeat']           = timeat,
		['@permanent']        = permanent,
	}, function()
	end)

	BanListHistoryLoad = false
end

function loadBanList()
	MySQL.Async.fetchAll('SELECT * FROM defender_ban', {}, function(data)
		BanList = {}

		for i=1, #data, 1 do
			table.insert(BanList, {
				license    = data[i].license,
				identifier = data[i].identifier,
				liveid     = data[i].liveid,
				xblid      = data[i].xblid,
				discord    = data[i].discord,
				playerip   = data[i].playerip,
				reason     = data[i].reason,
				expiration = data[i].expiration,
				permanent  = data[i].permanent
			})
		end
	end)
end

AddEventHandler('playerConnecting', function()
	local color = "^"..math.random(0,9)
	print(color.."The Defender - ".. GetPlayerName(source) .." connecting into the server")
end)