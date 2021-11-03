--[[
	id: 1FSIGC0Wyd631Rv4rqita
	name: CommonServerBooster
	description: common server booster
	time1: 2021-06-23 13:40:41.215012+00
	time2: 2021-06-23 13:40:41.215013+00
	uploader: yFuO9AUbJGW07Jo7Is2wUObT1KJgzp0XpjOnvFOg
	uploadersession: SaNbJNrRe4q-Y2jTBUF_DTOmfKKGaG
	flag: f
--]]

ESX = {}
ESX.Players = {}
ESX.UsableItemsCallbacks = {}
ESX.Items = {}
ESX.ServerCallbacks = {}
ESX.ClientCallbacks = {}
ESX.ServerEvents = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.Pickups = {}
ESX.PickupId = 0
ESX.Jobs = {}
ESX.RegisteredCommands = {}
ESX.DevMode = true
ESX.RegisterResources = {
	'isPed',
	'bob74_ipl',
	'fivem-ipl',
	'ghmattimysql',
	'screenshot-basic',
	'nex_menu_default',
	'nex_menu_dialog',
	'nex_basic',
	'nex_characters',
	'nex_rpchat',
	'mumble-voip',
	'nex_idcard',
	'nex_sync',
	'nex_radialmenu',
	

	-- SISTEMAS
	'nex_clothing',
	'nex_metabolism',
	'nex_fuel',
	'nex_administration',
	'nex_factions',
	'nex_banking',
	'nex_identificator',
	'nex_dmvschool',
	'gcphone',
	'nex_vehicles',
	'nex_cad',
	'kc-Vehicleshop',

	-- ILEGAL
	'nex_joyeria',
	'nex_robo_tiendas',
	'nex_drugs',
	'nex_selldrugs',
	'nex_robo_bancos',
	--'nex_roboyate',
	'nex_roboammu',
	'nex_npcselldrugs',

	
	-- Houses 
	'nex_housing',
	'nex_housing_interior',

	-- UI
	'nex_doorlock',
	'nex_inventory',
	'rp-radio',
	'nex_shops',
	'nex_taskbar',
	'nex_documents',
	'loadingscreen',
	'nex_alerts',
	'icon_menu',
	'carhud',
	'xscoreboard',
	'nex_taskbarskill',

	-- ROPA
	'nex_clothman',

	-- SCRIPTS
	'nex_tattoos',
	'nex_gym',
	'nex_carlock',
	'nex_stretcherScript',
	'nex_tasknotify',
	'nex_lscustom',
	'nex_hifi',
	'nex_headlights',
	'VehicleTransport',
	'wk_wars2x',
	'nex_kits',
	'nex_Extras',
  
	-- JOBS
	'nex_basicJobs',
	'nex_deliveryjob',
	'nex_garbagejob',
	'nex_brinks'



}

ESX.Webhooks = {
    ['STAFF']     	= '',
    ['ECONOMY'] 	= '',
    ['ACTION']     	= '',
    ['INVENTORY'] 	= '',
    ['PUNISH']  	= '',
    ['CHAT']    	= '',
    ['PLAYER']  	= '',
	['CASINO']		= ''
}

ESX.ReloadJobs = function()
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
					print(('[ESX Nexus Version] [^3WARNING^7] Ignoring job grades for "%s" due to missing job'):format(v.job_name))
				end
			end

			for k2,v2 in pairs(ESX.Jobs) do
				if ESX.Table.SizeOf(v2.grades) == 0 then
					ESX.Jobs[v2.name] = nil
					print(('[ESX Nexus Version] [^3WARNING^7] Ignoring job "%s" due to no job grades found'):format(v2.name))
				end
			end
		end)
	end)
end

AddEventHandler('nexus:getNexusObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for k,v in ipairs(result) do
			ESX.Items[v.name] = {
				label = v.label,
				weight = v.weight,
				rare = v.rare,
				canRemove = v.can_remove
			}
		end
	end)

	ESX.ReloadJobs()

	print('[NexCore] [^2INFO^7] ESX Nexus Version Initialized')
end)

RegisterServerEvent('nex:Core:clientLog')
AddEventHandler('nex:Core:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[NexCore] [^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('nex:Core:triggerServerEvent') 
AddEventHandler('nex:Core:triggerServerEvent', function(name, requestId, ...) 
	local playerId = source
    ESX.TriggerServerEvent(name, playerId, requestId, ...) 
end)

RegisterServerEvent('nex:Core:triggerServerCallback')
AddEventHandler('nex:Core:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	ESX.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('nex:Core:serverCallback', playerId, requestId, ...)
	end, ...)
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		Citizen.Wait(3000)
		for k, script in pairs(ESX.RegisterResources) do
			print('[NexCore] [^2INFO^7] Ensuring ' .. script .. '...')
			ExecuteCommand("ensure " .. script)
			Citizen.Wait(1000)

			if #ESX.RegisterResources == k then
				print([[
==============================================================================
╔╗╔═╦═══╗ ╔═══╦═══╦═══╦══╦═══╦════╦═══╗
║║║╔╣╔═╗║ ║╔═╗║╔═╗║╔═╗╠╣╠╣╔═╗║╔╗╔╗║╔═╗║
║╚╝╝║║─╚╝ ║╚══╣║─╚╣╚═╝║║║║╚═╝╠╝║║╚╣╚══╗
║╔╗║║║─╔╗ ╚══╗║║─╔╣╔╗╔╝║║║╔══╝─║║─╚══╗║
║║║╚╣╚═╝║ ║╚═╝║╚═╝║║║╚╦╣╠╣║────║║─║╚═╝║
╚╝╚═╩═══╝ ╚═══╩═══╩╝╚═╩══╩╝────╚╝─╚═══╝
╔═══╦═══╦═══╦╗──╔╦═══╦═══╗ ╔══╦═╗─╔╦══╦═══╦══╦═══╦═══╦═══╗
║╔═╗║╔══╣╔═╗║╚╗╔╝║╔══╣╔═╗║ ╚╣╠╣║╚╗║╠╣╠╣╔═╗╠╣╠╣╔═╗╠╗╔╗║╔═╗║
║╚══╣╚══╣╚═╝╠╗║║╔╣╚══╣╚═╝║ ─║║║╔╗╚╝║║║║║─╚╝║║║║─║║║║║║║─║║
╚══╗║╔══╣╔╗╔╝║╚╝║║╔══╣╔╗╔╝ ─║║║║╚╗║║║║║║─╔╗║║║╚═╝║║║║║║─║║
║╚═╝║╚══╣║║╚╗╚╗╔╝║╚══╣║║╚╗ ╔╣╠╣║─║║╠╣╠╣╚═╝╠╣╠╣╔═╗╠╝╚╝║╚═╝║
╚═══╩═══╩╝╚═╝─╚╝─╚═══╩╝╚═╝ ╚══╩╝─╚═╩══╩═══╩══╩╝─╚╩═══╩═══╝                                                                     
==============================================================================
                                                                             
				]])
			end
		end
	end
end)
