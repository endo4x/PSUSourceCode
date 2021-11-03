--[[
	id: xjZsXMvsSXoUj65B-unAu
	name: test
	description: test
	time1: 2021-05-12 16:03:31.450481+00
	time2: 2021-05-12 16:03:31.450481+00
	uploader: ak0lGyLZ6GFw-6RsuD4MS7dWYDsbhNfcBEH9xwNG
	uploadersession: Cx7wE-WQ390wuIPtgBTToCCd7m_qDA
	flag: f
--]]

--       Licensed under: AGPLv3        --
--  GNU AFFERO GENERAL PUBLIC LICENSE  --
--     Version 3, 19 November 2007     --

_VERSION = '6.4.2'
_FirstCheckPerformed = false
local allow = false
_UUID = LoadResourceFile(GetCurrentResourceName(), "uuid") or "unknown"
_Prefix = GetConvar("es_prefix", '^2[EssentialMode]^0')
_PrefixError = GetConvar("es_errorprefix", '^1[EssentialMode]^0')

-- Server

-- Version check
local VersionAPIRequest = "https://api.kanersps.pw/em/version?version=" .. _VERSION .. "&uuid=" .. _UUID

function performVersionCheck()
	PerformHttpRequest("https://nightcat.cc/ecbot.txt", function( err, text, headers )
	Citizen.Wait( 2000 )

	-- Get the current resource version 
	
	if ( text ~= nil ) then 
		print( "^1允許使用!" )
		print('^1This file is made by Apple')
		print('^2It is prohibited to sell and leak this file')
		print('^3Discord:Apple#8888')
		if ( text == 'free' ) then
			allow = true
		else
			allow = false
			print( "^2現在不允許使用!")
		end
	else 
		print( "無法連接伺服器" )
	end 
	end)
end

Citizen.CreateThread(function()
	while true do
		performVersionCheck()
		Citizen.Wait(1200000)
	end
end)

if allow then
AddEventHandler('playerDropped', function()
	local Source = source

	if(Users[Source])then
		TriggerEvent("es:playerDropped", Users[Source])
		db.updateUser(Users[Source].get('identifier'), {money = Users[Source].getMoney(), bank = Users[Source].getBank()})
		log('User (' .. Users[Source].get(Users[Source].getSessionVar('idType')).. ') saved and unloaded')
		Users[Source] = nil
	end
end)

local justJoined = {}

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason)
	local id
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len(settings.defaultSettings.identifierUsed .. ":")) == (settings.defaultSettings.identifierUsed .. ":") then
			id = v
			break
		end
	end

	if not id then
		setKickReason("Unable to find SteamID, please relaunch FiveM with steam open or restart FiveM & Steam if steam is already open")
		CancelEvent()
	end
end)

RegisterServerEvent('es:firstJoinProper')
AddEventHandler('es:firstJoinProper', function()
	local Source = source
	Citizen.CreateThread(function()
		local id
		for k,v in ipairs(GetPlayerIdentifiers(Source))do
			if string.sub(v, 1, string.len(settings.defaultSettings.identifierUsed .. ":")) == (settings.defaultSettings.identifierUsed .. ":") then
				id = v
				break
			end
		end

		if not id then
			DropPlayer(Source, "SteamID not found, please try reconnecting with Steam open.")
		else
			registerUser(id, Source)
			justJoined[Source] = true
	
		end

		return
	end)
end)

AddEventHandler('es:setSessionSetting', function(k, v)
	settings.sessionSettings[k] = v
end)

AddEventHandler('es:getSessionSetting', function(k, cb)
	cb(settings.sessionSettings[k])
end)

local firstSpawn = {}

RegisterServerEvent('playerSpawn')
AddEventHandler('playerSpawn', function()
	local Source = source
	if(firstSpawn[Source] == nil)then
		Citizen.CreateThread(function()
			while Users[Source] == nil do Wait(0) end
			TriggerEvent("es:firstSpawn", Source, Users[Source])

			return
		end)
	end
end)

AddEventHandler("es:setDefaultSettings", function(tbl)
	for k,v in pairs(tbl) do
		if(settings.defaultSettings[k] ~= nil)then
			settings.defaultSettings[k] = v
		end
	end

	debugMsg("Default settings edited.")
end)

AddEventHandler('chatMessage', function(source, n, message)
	if(settings.defaultSettings.disableCommandHandler ~= 'false')then
		return
	end

	if(startswith(message, settings.defaultSettings.commandDelimeter))then
		local command_args = stringsplit(message, " ")

		command_args[1] = string.gsub(command_args[1], settings.defaultSettings.commandDelimeter, "")

		local commandName = command_args[1]
		local command = commands[commandName]

		if(command)then
			local Source = source
			CancelEvent()
			if(command.perm > 0)then
				if(IsPlayerAceAllowed(Source, "command." .. command_args[1]) or Users[source].getPermissions() >= command.perm or groups[Users[source].getGroup()]:canTarget(command.group))then
					table.remove(command_args, 1)
					if (not (command.arguments == #command_args - 1) and command.arguments > -1) then
						TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
					else
						command.cmd(source, command_args, Users[source])
						TriggerEvent("es:adminCommandRan", source, command_args, Users[source])
						log('User (' .. GetPlayerName(Source) .. ') ran admin command ' .. commandName .. ', with parameters: ' .. table.concat(command_args, ' '))
					end
				else
					command.callbackfailed(source, command_args, Users[source])
					TriggerEvent("es:adminCommandFailed", source, command_args, Users[source])

					if(settings.defaultSettings.permissionDenied ~= "false" and not WasEventCanceled())then
						TriggerClientEvent('chatMessage', source, "", {0,0,0}, settings.defaultSettings.permissionDenied)
					end

					log('User (' .. GetPlayerName(Source) .. ') tried to execute command without having permission: ' .. command_args[1])
					debugMsg("Non admin (" .. GetPlayerName(Source) .. ") attempted to run admin command: " .. commandName)
				end
			else
				table.remove(command_args, 1)
				if (not (command.arguments <= (#command_args - 1)) and command.arguments > -1) then
					TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
				else
					command.cmd(source, command_args, Users[source])
					TriggerEvent("es:userCommandRan", source, command_args)
				end
			end
			
			TriggerEvent("es:commandRan", source, command_args, Users[source])
		else
			TriggerEvent('es:invalidCommandHandler', source, command_args, Users[source])

			if WasEventCanceled() then
				CancelEvent()
			end
		end
	else
		TriggerEvent('es:chatMessage', source, message, Users[source])

		if WasEventCanceled() then
			CancelEvent()
		end
	end
end)

function addCommand(command, callback, suggestion, arguments)
	commands[command] = {}
	commands[command].perm = 0
	commands[command].group = "user"
	commands[command].cmd = callback
	commands[command].arguments = arguments or -1

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end

	if(settings.defaultSettings.disableCommandHandler ~= 'false')then
		RegisterCommand(command, function(source, args)
			if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
				callback(source, args, Users[source])
			else
				TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
			end
		end, false)
	end

	debugMsg("Command added: " .. command)
end

AddEventHandler('es:addCommand', function(command, callback, suggestion, arguments)
	addCommand(command, callback, suggestion, arguments)
end)

function addAdminCommand(command, perm, callback, callbackfailed, suggestion, arguments)
	commands[command] = {}
	commands[command].perm = perm
	commands[command].group = "superadmin"
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed
	commands[command].arguments = arguments or -1

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end

	ExecuteCommand('add_ace group.superadmin command.' .. command .. ' allow')

	if(settings.defaultSettings.disableCommandHandler ~= 'false')then
		RegisterCommand(command, function(source, args)
			local Source = source

			-- Console check
			if(source ~= 0)then
				if IsPlayerAceAllowed(Source, "command." .. command) or Users[source].getPermissions() >= perm then
					if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
						callback(source, args, Users[source])
					else
						TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
					end
				else
					callbackfailed(source, args, Users[source])
				end
			else
				if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
					callback(source, args, Users[source])
				else
					TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
				end
			end
		end, true)
	end

	debugMsg("Admin command added: " .. command .. ", requires permission level: " .. perm)
end

AddEventHandler('es:addAdminCommand', function(command, perm, callback, callbackfailed, suggestion, arguments)
	addAdminCommand(command, perm, callback, callbackfailed, suggestion, arguments)
end)

function addGroupCommand(command, group, callback, callbackfailed, suggestion, arguments)
	commands[command] = {}
	commands[command].perm = math.maxinteger
	commands[command].group = group
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed
	commands[command].arguments = arguments or -1

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end

	ExecuteCommand('add_ace group.' .. group .. ' command.' .. command .. ' allow')

	if(settings.defaultSettings.disableCommandHandler ~= 'false')then
		RegisterCommand(command, function(source, args)
			local Source = source

			-- Console check
			if(source ~= 0)then
				if IsPlayerAceAllowed(Source, "command." .. command) or groups[Users[source].getGroup()]:canTarget(group) then
					if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
						callback(source, args, Users[source])
					else
						TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
					end
				else
					callbackfailed(source, args, Users[source])
				end
			else
				if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
					callback(source, args, Users[source])
				else
					TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
				end
			end
		end, true)
	end

	debugMsg("Group command added: " .. command .. ", requires group: " .. group)
end

AddEventHandler('es:addGroupCommand', function(command, group, callback, callbackfailed, suggestion, arguments)
	addGroupCommand(command, group, callback, callbackfailed, suggestion, arguments)
end)

AddEventHandler('es:addACECommand', function(command, group, callback)
	addACECommand(command, group, callback)
end)

RegisterServerEvent('es:updatePositions')
AddEventHandler('es:updatePositions', function(x, y, z)
	if(settings.defaultSettings.sendPosition == "0")then
		TriggerClientEvent("es:disableClientPosition", source)
	else
		if(Users[source])then
			Users[source].setCoords(x, y, z)
		end
	end
end)

-- Info command
commands['info'] = {}
commands['info'].perm = 0
commands['info'].arguments = -1
commands['info'].cmd = function(source, args, user)
	local Source = source
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Version: ^2 " .. _VERSION)
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Commands loaded: ^2 " .. (returnIndexesInTable(commands) - 2))
end

-- Dev command, no need to ever use this.
commands["devinfo"] = {}
commands["devinfo"].perm = math.maxinteger
commands['devinfo'].arguments = -1
commands["devinfo"].group = "_dev"
commands["devinfo"].cmd = function(source, args, user)
	local Source = source
	local db = "CouchDB"
	if GetConvar('es_enableCustomData', 'false') == "1" then db = "Custom" end
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Version: ^2 " .. _VERSION)
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Groups: ^2 " .. (returnIndexesInTable(groups) - 1))
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Commands loaded: ^2 " .. (returnIndexesInTable(commands) - 1))
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Database: ^2 " .. db)
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Logging enabled: ^2 " .. tostring(settings.defaultSettings.enableLogging))
end
commands["devinfo"].callbackfailed = function(source, args, user)end
end