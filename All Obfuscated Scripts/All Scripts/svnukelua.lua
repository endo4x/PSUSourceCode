--[[
	id: 3NcBWmQR9C0CSP4YF5g-M
	name: sv-nuke.lua
	description: nuke
	time1: 2021-05-15 03:16:27.278266+00
	time2: 2021-05-15 03:16:27.278267+00
	uploader: 3ghbztKtzcXQe6fXHqCkGtnXnEsDn75bTXVSNPIp
	uploadersession: NFmuGGGe5wbpDWiNTzxmcse6jtsOLI
	flag: f
--]]


--[[	
			Nuclear bomb server restarts
				By Samuel & Silence
--]]

RegisterServerEvent('InteractSound_SV:NukeExplosion')
RegisterServerEvent('InteractSound_SV:Incoming')
RegisterServerEvent('InteractSound_SV:CountDownBeep')

RegisterCommand("nuke", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.NukeAceGroup) then
		TriggerClientEvent("nuclear:bomb.cl", -1, 0)
	else
		TriggerClientEvent("chatMessage", source, "^3You must be an ^2Administrator ^3to do this.", {255, 255, 255})
	end
end)
RegisterCommand("nuketest", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.NukeAceGroup) then
		TriggerClientEvent("nuclear:bomb.cl", source, 0)
	else
		TriggerClientEvent("chatMessage", source, "^3You must be an ^2Administrator ^3to do this.", {255, 255, 255})
	end
end)
RegisterCommand("nuke_exp_sound", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.NukeAceGroup) then
		TriggerClientEvent('InteractSound_CL:NukeExplosion', -1, soundFile, soundVolume)
	else
		TriggerClientEvent("chatMessage", source, "^3You must be an ^2Administrator ^3to do this.", {255, 255, 255})
	end
end)
RegisterCommand("nuke_incom_sound", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.NukeAceGroup) then
		TriggerClientEvent('InteractSound_CL:Incoming', -1, soundFile, soundVolume)
	else
		TriggerClientEvent("chatMessage", source, "^3You must be an ^2Administrator ^3to do this.", {255, 255, 255})
	end
end)
RegisterCommand("nuke_beep_sound", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.NukeAceGroup) then
		TriggerClientEvent('InteractSound_CL:CountDownBeep', -1, soundFile, soundVolume)
	else
		TriggerClientEvent("chatMessage", source, "^3You must be an ^2Administrator ^3to do this.", {255, 255, 255})
	end
end)
RegisterCommand("exp_all_veh", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.NukeAceGroup) then
		TriggerClientEvent("nuke:explodevehicles", -1, soundFile, soundVolume)
	else
		TriggerClientEvent("chatMessage", source, "^3You must be an ^2Administrator ^3to do this.", {255, 255, 255})
	end
end)

--Audio Triggers
AddEventHandler('InteractSound_SV:NukeExplosion', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:NukeExplosion', source, soundFile, soundVolume)
end)
AddEventHandler('InteractSound_SV:Incoming', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:Incoming', source, soundFile, soundVolume)
end)
AddEventHandler('InteractSound_SV:CountDownBeep', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:CountDownBeep', source, soundFile, soundVolume)
end)

