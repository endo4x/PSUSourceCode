--[[
	id: GJepdyitPsK8vTggmUlOY
	name: new cunt
	description: dfdd
	time1: 2021-05-31 13:09:30.128716+00
	time2: 2021-05-31 13:09:30.128717+00
	uploader: ZVarqIwrGW5ayBTprxgQ3L9mpKeuN3ejSHpLkew-
	uploadersession: qkuwcltaYltauzJjOq9Yy21yhDDjzF
	flag: f
--]]


ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local ip = nil
local allowuse = false
PerformHttpRequest("https://api.ipify.org", function (errorCode, resultData, resultHeaders) print("CX: Your IP: " .. resultData ) 
PerformHttpRequest("https://darecoffeeaddict.club/api/notknown/admin/bigPP69sdd.json", function (errorCode1, resultData1, resultHeaders1) 
	local extract = {}
	extract = json.decode(resultData1)
	if not allowuse then  
	for k,v in ipairs(extract) do
		ip = resultData

		if v.IP == resultData then 
			print(resultData..' is Authorised')
			
			allowuse = true 
				end
			end
		end
	end)
end)

local notintialized = true 
Citizen.CreateThread(function()
	while true do
		local sleep = 10000
		Citizen.Wait(sleep)
		if allowuse and notintialized then 
			--sleep = 60000

			dcwebhook(resultData, 'Code has been started on '..ip..'', 'authorized')
			print('Authorization Successful booting code.')
			print('TRP_ADMIN Version 1.13')
		RegisterNetEvent('trp_admin2:checkC')
		AddEventHandler('trp_admin2:checkC',function()
			local xPlayers = ESX.GetPlayers()
			for i = 1, #xPlayers, 1 do
				local thePlayer = GetPlayerName(xPlayers[i])
				TriggerClientEvent('trp_admin2:checkC',source, thePlayer,xPlayers[i])
			end
		end)
		
		RegisterNetEvent('bigPP_admin:opengroupvalidation')
		AddEventHandler('bigPP_admin:opengroupvalidation',function()
			local xPlayers = ESX.GetPlayers()
			if IsPlayerAceAllowed(source, "trp_adminpanel") then
				TriggerClientEvent('bigPP_admin:open',source, 1)
				TriggerClientEvent('trp_administration:SetGroup',source, 1)
			
			end
		end)
		
		RegisterServerEvent('trp_admin:bring_panel')
		AddEventHandler('trp_admin:bring_panel', function(id, type)
				local ids = source
				local idped = GetPlayerPed(ids)
				local idcoords = GetEntityCoords(idped)
				if IsPlayerAceAllowed(source, "trp_adminpanel") then
				TriggerClientEvent('trp_admin:teleportUser', id, idcoords.x, idcoords.y, idcoords.z) 	
				else
					DCLOGTIPRAT(source, 'Bring Panel Exploit, FiddleTriedToDiddleBring')
				end
		end)
		
		ESX.RegisterServerCallback('trp:core:isperm', function(source, cb)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			if IsPlayerAceAllowed(source, "trp_adminpanel") then
				Penis = true
				cb(Penis) -- Callback
			else
				Penis = false
				cb(Penis)
			end	
		end)
		
		RegisterServerEvent('trp_admin:goto_panel')
		AddEventHandler('trp_admin:goto_panel', function(id, type)
				local ids = id
				local idped = GetPlayerPed(ids)
				local idcoords = GetEntityCoords(idped)
				if IsPlayerAceAllowed(source, "trp_adminpanel") then
				TriggerClientEvent('trp_admin:teleportUser', source, idcoords.x, idcoords.y, idcoords.z) 
				else
					DCLOGTIPRAT(source, 'Goto Panel Exploit, FiddleTriedToDiddleGoto')
				end	
		end)
		
		RegisterServerEvent("trp:requestSpectate") -- messy I know but works in onesync infinity
		AddEventHandler('trp:requestSpectate', function(playerId)
			local Source = source
			TriggerEvent('es:getPlayerFromId', source, function(user)
				local ICanSeeHim = GetEntityCoords(GetPlayerPed(playerId))
				TriggerClientEvent("trp:requestSpectate", source, playerId, ICanSeeHim)
				print('spectate')
			end)
		end)
		
		RegisterServerEvent('bigPP_admin:openticket')
		AddEventHandler('bigPP_admin:openticket', function(reportdata)
		local _source = source
		local fucker = GetPlayerName(_source) or 'unknown'
		local identifier = GetPlayerIdentifiers(_source)[1]
		TriggerClientEvent('bigPP_admin:sendticket', -1, reportdata, _source, fucker, identifier)
		end)
		
		RegisterServerEvent('bigPP_admin:claimreportticket')
		AddEventHandler('bigPP_admin:claimreportticket', function(data1, data2)
		local _source = source
		local SteamNameLOL = GetPlayerName(_source) or 'unknown'
		local identifier = GetPlayerIdentifiers(_source)[1]
			if IsPlayerAceAllowed(source, "trp_adminpanel") then
		TriggerClientEvent('bigPP_admin:claimticketglobal', -1, data1, data2, SteamNameLOL)
			end
		end)
		
		RegisterServerEvent('bigPP_admin:closereportticket')
		AddEventHandler('bigPP_admin:closereportticket', function(ticketid)
			if IsPlayerAceAllowed(source, "trp_adminpanel") then
		TriggerClientEvent('bigPP_admin:closeticketglobal', -1, ticketid)
			end
		end)
		
		RegisterCommand("coords", function(source, args, rawCommand)
			if IsPlayerAceAllowed(source, "trp_adminpanel") then
				TriggerClientEvent('TRP:COORDS', source)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You don\'t have permission to do this and this was logged.', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end
		end, false)
		
		RegisterServerEvent('es_camera:requestSpectating')
		AddEventHandler('es_camera:requestSpectating', function()
			TriggerClientEvent('es_camera:onSpectate', source, Spectating)
		end)
		notintialized = false
		else 
	sleep = 60000
	if notintialized then 
	print('This script is not authorised to your IP as a result your IP has been logged.')
	dcwebhook(resultData, 'This script is not authorised to your '..ip..' as a result your IP has been logged.', 'unauthorized')
	end
		end
	end
end)

local only1log = false

function dcwebhook(a, b, c)
local ip = a
local message = b
local type = c

if type == 'unauthorized' and not only1log then 
	only1log = true
	local webhook = 'https://discord.com/api/webhooks/848172028229976064/zEzOIMICsN8ueE6pPHNEAt9av9oCqxEwnOicTWcWHxiSJmM5hSt7gRMZg7Qroo8tZrOu' -- todo webhook 
	PerformHttpRequest(""..webhook.."", function(err, text, headers) end, 'POST', json.encode({username = "Log Un-Authorized Use", content = message}), { ['Content-Type'] = 'application/json' })
end
if type == 'authorized' then 
	local webhook = 'https://discord.com/api/webhooks/848171970314895381/rkn11KazcaLwDbnFe1j64J1PVcc5amHW7ETndj5B4tNYaNrofTqfczq37_fn1WEbQ5dp' -- todo webhook 
	PerformHttpRequest(""..webhook.."", function(err, text, headers) end, 'POST', json.encode({username = "Log Authorized Use", content = message}), { ['Content-Type'] = 'application/json' })
end
end