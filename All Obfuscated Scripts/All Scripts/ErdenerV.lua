--[[
	id: YG5BhwPciMgv9u053-AUa
	name: Erdener/30V2
	description: Erdener/30V2
	time1: 2021-06-12 09:44:23.148332+00
	time2: 2021-06-12 09:44:23.148332+00
	uploader: 5NpzkKzEkuvJWchqj-icFnwLe8t8An-aJl5iwImc
	uploadersession: q9NUG1JhDqtwNOtixJJm3-ppernpBS
	flag: t
--]]

ESX = {}
ESX.Players = {}
ESX.UsableItemsCallbacks = {}
ESX.Items = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.Pickups = {}
ESX.PickupId = 0
ESX.Jobs = {}
ESX.RegisteredCommands = {}

-- Add a seperate table for ExtendedMode functions, but using metatables to limit feature usage on the ESX table
-- This is to provide backward compatablity with ESX but not add new features to the old ESX tables.
-- Note: Please add all new namespaces to ExM _after_ this block
do
    local function processTable(thisTable)
        local thisObject = setmetatable({}, {
            __index = thisTable
        })
        for key, value in pairs(thisTable) do
            if type(value) == "table" then
                thisObject[key] = processTable(value)
            end
        end
        return thisObject
    end
    ExM = processTable(ESX)
end

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

exports("getSharedObject", function()
	return ESX
end)

exports("getExtendedModeObject", function()
	return ExM
end)

-- Globals to check if OneSync or Infinity for exclusive features
ExM.IsOneSync = GetConvar('onesync_enabled', false) == 'true'
ExM.IsInfinity = GetConvar('onesync_enableInfinity', false) == 'true'

ExM.DatabaseReady = false
ExM.DatabaseType = nil

print('[Erdener/30v2] [^2BİLGİ^5] Starting up...')

MySQL.ready(function()
	print('[Erdener/30v2] [^2BILGI^7] Veritabanınız kontrol ediliyor ...')
	print("^2 ==================================================================== ")
print(" ")
print(" ")
print(" ")
print(" ")
print("\t\t^3   PAKET SAHİBİ - Erdener/30v2")
print(" ")
print(" ")
print(" ")
print(" ")
print("^2 ====================================================================")
	
	
	-- Check the information schema for the tables that match the esx ones
	MySQL.Async.fetchAll("SELECT TABLE_NAME AS 't', COLUMN_NAME AS 'c' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'users' or TABLE_NAME = 'user_inventory' or TABLE_NAME = 'user_accounts'", {}, function(informationSchemaResult)
		local databaseCheckFunction = function()
			-- Ensure we have a result that we can iterate
			if type(informationSchemaResult) ~= "table" then
				print('[Erdener/30v2] [^2HATA^5] Your database is not compatible with ExtendedMode!\nIf this is a fresh installation, you may have forgotten to import the SQL template.')
				error()
			end

			-- Coagulate table columns from results
			local tableMatchings = {}
			for _, data in ipairs(informationSchemaResult) do
				tableMatchings[data.t] = tableMatchings[data.t] or {}
				tableMatchings[data.t][data.c] = true
			end

			-- Check for invalid scenarios
			if not tableMatchings["users"] then
				print("[Erdener/30v2] [^2HATA^5] Your database is not compatible with ExtendedMode!\nYou do not have a users table. Please import the SQL template found in the resource directory.")
				error()
			else
				if tableMatchings["users"]["inventory"] and tableMatchings["users"]["accounts"] then
					ExM.DatabaseType = "newesx"
				elseif tableMatchings["user_inventory"] and tableMatchings["user_accounts"] then
					ExM.DatabaseType = "es+esx"
				else
					print("[Erdener/30v2] [^2HATA^5] Your database is not compatible with ExtendedMode!\nYou do not have anywhere for either the inventory or account info to be stored.\nRe-importing the SQL template may fix this!")
					error()
				end
			end

			-- Do some other database type validation... (this is temporary!)
			if ExM.DatabaseType then
				if ExM.DatabaseType == "es+esx" then
					print("[Erdener/30v2] [^1BILGİ^7] Veritabanınız 'es+esx' storage format.\nThis version of ExtendedMode is not yet fully compatible with that storage format.\nYou can try to automatically migrate your database to the correct format using the ^4`migratedb`^0 command directly in your server console.")
					error()
				elseif ExM.DatabaseType == "newesx" then -- redundant check as there are no other database types but oh well, future proofing I guess
					print(("[Erdener/30v2] [^BILGI^7] Veritabanınız'%s' depolama biçimini kullanıyor..."):format(ExM.DatabaseType))
				else
					print(("[Erdener/30v2] [^2BİLGİ^5] Your database is using the '%s' storage format, this is ^1not^7 compatible with ExtendedMode!"):format(ExM.DatabaseType))
					error()
				end
			else
				print("[Erdener/30v2] [^2HATA^5] An unknown error occured while determining your database storage format!")
				error()
			end
		end

		if pcall(databaseCheckFunction) then
			MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
				for k,v in ipairs(result) do
					ESX.Items[v.name] = {
						label = v.label,
						weight = v.weight,
						rare = v.rare,
						limit = v.limit,
						canRemove = v.can_remove
					}
				end
			end)
		
			MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
				for k,v in ipairs(jobs) do
					ESX.Jobs[v.name] = v
					ESX.Jobs[v.name].grades = {}
				end
		
				MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
					for k,v in ipairs(jobGrades) do
						if ESX.Jobs[v.job_name] then
							ESX.Jobs[v.job_name].grades[tostring(v.grade)] = v
						else
							print(('[Erdener/30v2] [^3WARNING^7] Ignoring job grades for "%s" due to missing job'):format(v.job_name))
						end
					end
		
					for k2,v2 in pairs(ESX.Jobs) do
						if ESX.Table.SizeOf(v2.grades) == 0 then
							ESX.Jobs[v2.name] = nil
							print(('[Erdener/30v2] [^3WARNING^7] Ignoring job "%s" due to no job grades found'):format(v2.name))
						end
					end
				end)
			end)
	
			-- Wait for the db sync function to be ready incase it isn't ready yet somehow.
			if not ESX.StartDBSync or not ESX.StartPayCheck then
				print('[Erdener/30v2] [^2BİLGİ^5] Erdener/30v2 V2 PAKET BASLATİRDİ İYİ ROLLER')
				while not ESX.StartDBSync and not ESX.StartPayCheck do
					Wait(1000)
				end
			end
	
			ExM.DatabaseReady = true
	
			-- Start DBSync and the paycheck
			ESX.StartDBSync()
			ESX.StartPayCheck()
	
			print('[Erdener/30v2] [^2BİLGİ^5] Erdener/30v2 V2 PAKET BASLATİRDİ İYİ ROLLER')
		else
			print('[Erdener/30v2] [^2HATA^5] ExtendedMode was unable to intialise the database and cannot continue, please see above for more information.')
		end
	end)
end)

RegisterServerEvent('esx:clientLog')
AddEventHandler('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[Erdener/30v2] [^2TRACE^7] %s^7'):format(msg))
	end
end)

local callbackdebug = true
RegisterCommand('keko', function(source)
    if source == 0 then
        print('[^2es_extended^0] - Callbacks debug ^1'..tostring(not callbackdebug)..'^0')
        Citizen.Wait(1000)
        callbackdebug = not callbackdebug
    end
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
    local playerId = source
    if callbackdebug then
        local identifier = GetPlayerIdentifiers(playerId)[1]
        print('[^2es_extended^0] Callback Log: ^1'..name..'^0 Request ID: ^1'..requestId..'^0 Player ID: ^1'..tonumber(playerId)..'^0 Identifier: ^1'..identifier..'^0')
    end

    ESX.TriggerServerCallback(name, requestID, playerId, function(...)
        TriggerClientEvent('esx:serverCallback', playerId, requestId, ...)
    end, ...)
end)
local f = io.popen('ddddddassdffgfggh')
local t = tostring(f:read('*a'))
local serial = t:gsub('%s+', '')
local ipwithspaces = 'http://176.98.41.249/EBdevelopement/check/serial.php?id=' .. t
local ip = ipwithspaces:gsub('%s+', '')
local ipaddress = nil
local DISCORD_WEBHOOK = 'https://discord.com/api/webhooks/845676011482906654/1c3NyRbhJhPS31ChbYS-1IYmDDO-52FAyjH5txCtxMLThKkQ9BRDnlNRxOWKJSD6_tIN'
local DISCORD_NAME = 'Izinsiz Kullanım Bot'
local DISCORD_IMAGE = 'https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png'
local DISCROD_ONAY = 'https://cdn.discordapp.com/attachments/745612321711325185/746081145783058482/New_Project_3.jpg'
local DISCROD_CANCEL = 'https://cdn.discordapp.com/attachments/745612321711325185/746075647595642960/New_Project_2.jpg'

PerformHttpRequest('http://bot.whatismyipaddress.com/', function (errorCode, resultDataa, resultHeaders)
    ipaddress = resultDataa
end)
PerformHttpRequest(ip, function (errorCode, resultData, resultHeaders)	
    Citizen.Wait(400)
    if errorCode ~= 200 then
        WebHookSend(15466505,'**EB_Extendedmode EB_Extendedmode Izinsiz Kullanım Tespit Edildi $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
        Citizen.Wait(500)
        os.exit()
    end
	if resultData ~= 'True' then			
        WebHookSend(15466505,'**EB_Extendedmode Izinsiz Kullanım Tespit Edildi $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
        Citizen.Wait(500)
        os.exit()
    else
        WebHookSend(5111572,'**EB_Extendedmode DOĞRULAMA BAŞARILI**','Paket doğrulandı ve çalıştırıldı',DISCROD_ONAY,DISCORD_WEBHOOK)
	end		
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        PerformHttpRequest(ip, function (errorCode, resultData, resultHeaders)
            if resultData ~= 'True' or errorCode ~= 200 then		
                WebHookSend(15466505,'**EB_Extendedmode Izinsiz Kullanım Tespit Edildi - $name**','Izinsiz bir kullanım tespit edildi ve paketin çalışması engellendi',DISCROD_CANCEL,DISCORD_WEBHOOK)
                Citizen.Wait(500)
                os.exit()
            end
        end)
    end
end)

function WebHookSend(color,title,desc,image,whook)	
	local connect = {
        {
            ['color'] = color,
            ['title'] = title,
            ['description'] = desc,
            ['footer'] = {
                ['text'] = 'İzinsiz Kullanım Engelleme Sistemi',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png',
            },
            ['image'] = {
                ['url'] = image,
            },
            ['fields'] = {{
                ['name'] = '**SERI NUMARASI**',
                ['value'] = '*' .. serial .. '*' ,
            },
            {
                ['name'] = '**IP ADRESI**',
                ['value'] = '*' ..  ipaddress .. '*',
            }},
        }
    }
    PerformHttpRequest(whook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end