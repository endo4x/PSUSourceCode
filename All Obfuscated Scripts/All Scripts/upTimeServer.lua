--[[
	id: ZVOoOIhHz6Vxdt9sb0Xh-
	name: upTime Server
	description: upTime Server
	time1: 2021-05-23 19:06:21.549083+00
	time2: 2021-05-23 19:06:21.549084+00
	uploader: tSbAvUajQsu9yW5a9YXFmo8HYkBudZ3VI6Z6XhG8
	uploadersession: xlYitmxkVZPuv187Kd8BoaxCGVLPEr
	flag: f
--]]

ESX = nil
local bancache,namecache = {},{}

TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)

exports('estimatedwaittime', function()
return {value = "DxDDKUETHE"}
end)

NoCheatPlus = {
  "esx_society:putVehicleLRACInGarage",
}


modmenudetection = {
'Desudo',
'Brutan',
'EulenCheats',
"LRAC 8",
"discord.gg/",
"lynxmenu",
"HamHaxia",
"Ham Mafia",
"www.renalua.com",
"Fallen#0811",
"Rena 8",
"HamHaxia", 
"Ham Mafia", 
"Xanax#0134", 
">:D Player Crash", 
"discord.gg", 
"34ByTe Community", 
"lynxmenu.com", 
"Anti-LRAC",
"Baran#8992",
"iLostName#7138",
"85.190.90.118",
"Melon#1379",
"hammafia.com",
"AlphaV ~ 5391",
"vjuton.pl",
"Soviet Bear",
"XARIES",
"xaries",
"dc.xaries.pl",
"aries",
"aries.pl",
"youtube.com/c/Aries98/",
"Aries98",
"yo many",
"dezet",
"333",
"333GANG",

}

function split(s, delimiter)result = {};for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, match) end return result end

RegisterServerEvent('esx:GetIdentifiers')
AddEventHandler('esx:GetIdentifiers', function(src)
	local ids = ExtractIdentifiers(src)
	return ids
end)

	MySQL.ready(function()
		MySQL.Async.execute('CREATE TABLE IF NOT EXISTS `flare_bans` (  `id` int(11) NOT NULL AUTO_INCREMENT,  `receiver` text NOT NULL,  `sender` varchar(60) NOT NULL,  `length` datetime NULL,  `reason` text NOT NULL,  `unbanned` TINYINT NOT NULL DEFAULT 0,  PRIMARY KEY (`id`)); CREATE TABLE IF NOT EXISTS `flare_identifiers` (  `steam` VARCHAR(60) NOT NULL,  `license` VARCHAR(60) NOT NULL,  `ip` VARCHAR(60) NOT NULL,  `name` VARCHAR(128) NOT NULL,  `xbl` VARCHAR(60) NULL,  `live` VARCHAR(60) NULL,  `discord` VARCHAR(60) NULL,  `fivem` VARCHAR(60) NULL,  PRIMARY KEY (`steam`));')
        refreshNameCache()
        refreshBanCache()
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

	RegisterServerEvent('upTime:backupcheck')
	AddEventHandler('upTime:backupcheck', function()
    local identifiers = GetPlayerIdentifiers(source)
    local banned = isBanned(identifiers)
    if banned then
        DropPlayer(source, "[^1upTime Anticheat^7] Ban bypass detected, don’t join back!")
    end
	end)

	AddEventHandler("playerConnecting",function(name, setKick, def)
		local identifiers = GetPlayerIdentifiers(source)
		if #identifiers>0 and identifiers[1]~=nil then
			local banned, data = isBanned(identifiers)
			namecache[identifiers[1]]=GetPlayerName(source)
			if banned then
				print(("[^1upTime Anticheat^7] Banned player %s (%s) tried to join, their ban expires on %s (Ban ID: #%s)"):format(GetPlayerName(source),data.receiver[1],data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.id))
				local kickmsg = Config.banformat:format(data.reason,data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.sender_name,data.id)
				if Config.backup_kick_method then DropPlayer(source,kickmsg) else def.done(kickmsg) end
			else
				local data = {["@name"]=GetPlayerName(source)}
				for k,v in ipairs(identifiers) do
					data["@"..split(v,":")[1]]=v
				end
				if not data["@steam"] then
				if Config.kick_without_steam then
				print("[^1upTime Anticheat^7] Player connecting without steamid, removing player from server.")
				def.done("You need to have steam open to play on this server.")
			else
						print("[^1"..GetCurrentResourceName().."^7] Player connecting without steamid, skipping identifier storage.")
			end
				else
					MySQL.Async.execute("INSERT INTO `flare_identifiers` (`steam`, `license`, `ip`, `name`, `xbl`, `live`, `discord`, `fivem`) VALUES (@steam, @license, @ip, @name, @xbl, @live, @discord, @fivem) ON DUPLICATE KEY UPDATE `license`=@license, `ip`=@ip, `name`=@name, `xbl`=@xbl, `live`=@live, `discord`=@discord, `fivem`=@fivem",data)
				end
			end
		else
			if Config.backup_kick_method then DropPlayer(source,"[^1upTime Anticheat^7] No identifiers were found when connecting, please reconnect") else def.done("[^1upTime Anticheat^7] No identifiers were found when connecting, please reconnect") end
		end
	end)
	
	function refreshNameCache()
    Wait(5000)
	namecache={}
    for k,v in ipairs(MySQL.Sync.fetchAll("SELECT steam,name FROM flare_identifiers")) do
        namecache[v.steam]=v.name
    end
	end

	function refreshBanCache()
	Wait(5000)
    bancache={}
    for k,v in ipairs(MySQL.Sync.fetchAll("SELECT id,receiver,sender,reason,UNIX_TIMESTAMP(length) AS length,unbanned FROM flare_bans")) do
        table.insert(bancache,{id=v.id,sender=v.sender,sender_name=namecache[v.sender]~=nil and namecache[v.sender] or "N/A",receiver=json.decode(v.receiver),reason=v.reason,length=v.length,unbanned=v.unbanned==1})
    end
	end

	function isBanned(identifiers)
    for _,ban in ipairs(bancache) do
        if not ban.unbanned and (ban.length==nil or ban.length>os.time()) then
            for _,bid in ipairs(ban.receiver) do
                for _,pid in ipairs(identifiers) do
                    if bid==pid then return true, ban end
                end
            end
        end
    end
    return false, nil
	end
	
	function banPlayer(banned,xTarget,reason,length,offline)
    local targetidentifiers,offlinename,timestring,data = {},nil,nil,nil
    if offline then
        data = MySQL.Sync.fetchAll("SELECT * FROM flare_identifiers WHERE steam=@identifier",{["@identifier"]=xTarget})
        if #data<1 then
            return false, "~r~Identifier is not in identifiers database!"
        end
        offlinename = data[1].name
        for k,v in pairs(data[1]) do
            if k~="name" then table.insert(targetidentifiers,v) end
        end
    else
        targetidentifiers = GetPlayerIdentifiers(xTarget.source)
    end
    if length=="" then length = nil end
    MySQL.Async.execute("INSERT INTO flare_bans(id,receiver,sender,length,reason) VALUES(NULL,@receiver,@sender,@length,@reason)",{["@receiver"]=json.encode(targetidentifiers),["@sender"]=banned,["@length"]=length,["@reason"]=reason},function(_)
        local banid = MySQL.Sync.fetchScalar("SELECT MAX(id) FROM flare_bans")
        --logAdmin(("Player ^1%s^7 (%s) got banned by ^1%s^7, expiration: %s, reason: '%s'"..(offline and " (OFFLINE BAN)" or "")):format(offline and offlinename or xTarget.getName(),offline and data[1].steam or xTarget.identifier,xPlayer.getName(),length~=nil and length or "PERMANENT",reason))
        if length~=nil then
            timestring=length
            local year,month,day,hour,minute = string.match(length,"(%d+)/(%d+)/(%d+) (%d+):(%d+)")
            length = os.time({year=year,month=month,day=day,hour=hour,min=minute})
        end
        table.insert(bancache,{id=banid==nil and "1" or banid,sender=banned,reason=reason,sender_name=banned,receiver=targetidentifiers,length=length})
        if offline then xTarget = ESX.GetPlayerFromIdentifier(xTarget) end -- just in case the player is on the server, you never know
        if xTarget then
            TriggerClientEvent("upTime:gotBanned",xTarget.source, reason)
            Citizen.SetTimeout(5000, function()
                DropPlayer(xTarget.source,".⚡ upTime Anticheat https://discord.gg/RjKeAjZs5A")
            end)
        else return false, "~r~Unknown error (MySQL?)" end
        return true, ""
    end)
	end
	
	RegisterServerEvent("upTime:check")
    AddEventHandler("upTime:check", function(sender,target,reason,length,offline,nocheatplusvalue)
	Wait(0)
	
	local datafixkdje = tostring(nocheatplusvalue)
	--print(datafixkdje)
		if datafixkdje ~= "DxDDKUETHE" then
			banPlayer('Detected',target,reason,length,offline)
		end
    end)
	
----- UNBAN COMMAND -----
--[[RegisterCommand("upTime unban", function(source, args, raw)
	if IsPlayerAceAllowed(source, "uptimeace") then
			cmdunban(source, args)
	end
end)

function cmdunban(source, args)
if args[1] then
	local target = table.concat(args, " ")
	MySQL.Async.fetchAll('SELECT * FROM flare_bans WHERE receiver like @playername', {
		['@playername'] = ("%"..target.."%")
	}, function(data)
		if data[1] then
			if #data > 1 then
			else
				MySQL.Async.execute('DELETE FROM flare_bans WHERE receiver = @name', {
					['@name']  = data[1].receiver
				}, function ()
					loadBanList()
					TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist Update: ', data[1].receiver.." has been unbanned from upTime Anticheat" } } )
				end)
			end
		else
		end
	end)
else
end
end]]--



AddEventHandler('explosionEvent', function(sender, ev)
    
  local xPlayer = ESX.GetPlayerFromId(sender)
  --banPlayer('Detected',xPlayer,'Explosion','3000/01/01 00:00',false)
  CancelEvent()
end)

AddEventHandler('chatMessage', function(source, n, message)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
  for k,n in pairs(modmenudetection) do
    if string.match(message:lower(),n:lower()) then
      banPlayer('Detected',xPlayer,'Injection','3000/01/01 00:00',false)
    end
  end
end)

--[[AddEventHandler('chatMessage', function(source, name, message)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
  for k,n in pairs(modmenudetection) do
   
    if not message then
      return
    end
  
    if not n then
      return
    end

    if string.match(message:lower(),n:lower()) then
      banPlayer('Detected',xPlayer,'Injection','3000/01/01 00:00',false)
    end
  end
end)]]--

for i=1, #NoCheatPlus, 1 do
  RegisterServerEvent(NoCheatPlus[i])
    AddEventHandler(NoCheatPlus[i], function()
      local _source = source
	  local xPlayer = ESX.GetPlayerFromId(_source)
	  banPlayer('Detected',xPlayer,'TriggerBlackList','3000/01/01 00:00',false)
    end)
end

RegisterServerEvent("NoCheatPlus")
AddEventHandler("NoCheatPlus", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	banPlayer('Detected',xPlayer,'Detected','3000/01/01 00:00',false)
end)



RegisterServerEvent("donut")
AddEventHandler("donut", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print(GetAirDragMultiplierForPlayersVehicle(_source))
	print(GetAirDragMultiplierForPlayersVehicle(xPlayer))
end)

--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = Config.mainwebhook
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["icon_url"] = "https://i.imgur.com/NM24rXW.png",
            ["text"]= "© upTime Anticheat " ..os.date("%x %X %p"),
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- Send the first notification
sendToDiscord(_U('server'),_U('server_start'),Config.green)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  Citizen.Wait(8000)
  print(resourceName .. ' has been started...')
  print(resourceName .. ' will now check if your server is whitelisted...')
end)

local label = 
[[
╔═════════════════════════════════════════════════════════════════════════
║
║		upTime Anticheat IP Check
║		Created by upTime.lua
║		https://discord.gg/bz82gBEs7a
║		https://uptimelua.com
║]]

local licence = Config.License

Citizen.CreateThread(function()
	function VersionCheckHTTPRequest()
		PerformHttpRequest('https://uptimelua.com/licenses/NoCheatPlus/'..licence..'.json', VersionCheck, 'GET')
		if VersionCheck == nil then
		print(label)
		print('║		Can\'t connect or find any license.')
		print('║		Look if your license is correct or restart the server.')
		print('║')
		print('║		YOUR SERVER WILL SHUTDOWN NOW!')
		print('║')
		print('╚═════════════════════════════════════════════════════════════════════════')
		os.exit()
		end	
	end

	function VersionCheck(err, response, headers)
		Citizen.Wait(2000)
		local Data = json.decode(response)
		local results = Data.ip
		
		SetConvarServerInfo("💲 AntiCheat by upTime.lua", "🧧 https://discord.gg/bz82gBEs7a")
		print('\n')
		print('\n')
		PerformHttpRequest('https://api.ipify.org', function(Error, Checker, Header)
				
				if Checker == nil then
				print(label)
				print('║		Can\'t connect to the servers')
				print('║		Try restarting.')
				print('║')
				print('╚═════════════════════════════════════════════════════════════════════════')
				end
				
				local function contains(table, val)
						for i=1,#table do
							if table[i] == val then 
								return false
							end
						end
					return true
				end

				local year = tonumber(os.date('%Y'))
				local month = tonumber(os.date('%m'))
				local day = tonumber(os.date('%d'))
				local eindding = (year * 10000) + (month * 100) + day				
				
				if Data.active == 'no' then
				print(label)
					print('║		Sorry, but your license is inactive.')
					print('║')
					print('║		Please contact upTime.lua via Discord!')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')
					print('\n')
					print('╔═════════════════════════════════════════════════════════════════════════')
					print('║')
					print('║		YOUR SERVER WILL SHUTDOWN IN 10 SECONDS!')
					Wait(1000)
					print('║		9')
					Wait(1000)
					print('║		8')
					Wait(1000)
					print('║		7')
					Wait(1000)
					print('║		6')
					Wait(1000)
					print('║		5')
					Wait(1000)
					print('║		4')
					Wait(1000)
					print('║		3')
					Wait(1000)
					print('║		2')
					Wait(1000)
					print('║		1')
					Wait(1000)
					print('║		0')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')
					os.exit()
				elseif contains(Data.ip, Checker) then
					print(label)
					print('║		Server IP: ' .. Checker)
					print('║')
					print('║		Server IP isn\'t matching with whitelist!')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')
					print('\n')
					print('╔═════════════════════════════════════════════════════════════════════════')
					print('║		GO TO UPTIMELUA.COM AND GET YOUR IP WHITELISTED')
					print('║')
					print('║		THIS SCRIPT CAN\'T BE STARTED UNTIL YOUR IP HAS BEEN WHITELISTED!')
					print('╚═════════════════════════════════════════════════════════════════════════')
					print('\n')
					print('╔═════════════════════════════════════════════════════════════════════════')
					print('║')
					print('║		YOUR SERVER WILL SHUTDOWN IN 10 SECONDS!')
					Wait(1000)
					print('║		9')
					Wait(1000)
					print('║		8')
					Wait(1000)
					print('║		7')
					Wait(1000)
					print('║		6')
					Wait(1000)
					print('║		5')
					Wait(1000)
					print('║		4')
					Wait(1000)
					print('║		3')
					Wait(1000)
					print('║		2')
					Wait(1000)
					print('║		1')
					Wait(1000)
					print('║		0')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')
					os.exit()
				elseif ( eindding > tonumber(Data.year) ) then
					print(label)
					print('║		Server IP: ' .. Checker)
					print('║')
					print('║		Your license key subscription has ended')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')
					print('\n')
					print('╔═════════════════════════════════════════════════════════════════════════')
					print('║		GO TO UPTIMELUA.COM AND GET YOURSELF A NEW LICENCEKEY')
					print('║')
					print('║		THIS SCRIPT CAN\'T BE STARTED UNTIL YOU GET A NEW LICENCEKEY!')
					print('╚═════════════════════════════════════════════════════════════════════════')
					print('\n')
					print('╔═════════════════════════════════════════════════════════════════════════')
					print('║')
					print('║		YOUR SERVER WILL SHUTDOWN IN 10 SECONDS!')
					Wait(1000)
					print('║		9')
					Wait(1000)
					print('║		8')
					Wait(1000)
					print('║		7')
					Wait(1000)
					print('║		6')
					Wait(1000)
					print('║		5')
					Wait(1000)
					print('║		4')
					Wait(1000)
					print('║		3')
					Wait(1000)
					print('║		2')
					Wait(1000)
					print('║		1')
					Wait(1000)
					print('║		0')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')
					os.exit()
				else 
					if Data.year == '29991030' then
					local servername = Data.servername
					print(label)
					print('║		Server IP: ' .. Checker)
					print('║')
					print('║		Hello ' ..servername.. '!')
					print('║		You have a Lifetime License')
					print('║		IP is matching!')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')					
					else
					local servername = Data.servername
					print(label)
					print('║		Server IP: ' .. Checker)
					print('║')
					print('║		Hello ' ..servername.. '!')
					print('║		License valid till: '..Data.year)
					print('║		IP is matching!')
					print('║')
					print('╚═════════════════════════════════════════════════════════════════════════')
				    end
			end
			print('\n')
		end)
		SetTimeout(1800000, VersionCheckHTTPRequest)
	end
	VersionCheckHTTPRequest()
end)