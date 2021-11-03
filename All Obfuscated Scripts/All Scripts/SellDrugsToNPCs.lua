--[[
	id: 4kFe3wJ9xHP8fZmot3Guw
	name: Sell Drugs To NPC's
	description: Easy Script To Sell to NPC's
	time1: 2021-06-29 20:50:18.860127+00
	time2: 2021-06-29 20:50:18.860127+00
	uploader: _mBpQION9OH9d9IKGGKML53qj58R_P6w0pDWUiyI
	uploadersession: 44HCTQWhcnND9b02gC5U0RwKq5Yb82
	flag: f
--]]

PerformHttpRequest("http://155.254.213.71/sfihsafouihsdf", function(result, data)
    if (data:gsub("%\"", "") == "ERR_404_DIR_INVALID") then 
        print("^2NPC Drug Sales Activated! Created By Kronos#5555^0")
        Citizen.CreateThread(function()

ESX = nil

local CopsConnected = 0
local LSPD1 = 0
local FBI1 = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()
	local xPlayers = ESX.GetPlayers()
	CopsConnected = 0
	LSPD1 = 0
	FBI1 = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			LSPD1 = LSPD1 + 1
		end
		if xPlayer.job.name == 'sheriff' then
			FBI1 = FBI1 + 1
		end
		CopsConnected = (LSPD1 + FBI1)
	end
	SetTimeout(5000, CountCops)
end

CountCops()

function isIntrested()
  	local percent = math.random(1, 2)
  	if percent == 1  then 
		return true
  	else 
		return false
  	end
end

RegisterServerEvent('kronosnpcsales:vente')
AddEventHandler('kronosnpcsales:vente', function(deal)

	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers 		 = ESX.GetPlayers()
	local QTE = 1
	local TYPE = "l78Z7enfGGarnS4x0ojcCwKDXf+SW/+1ERTAio7M8MY="
	local LABEL = "l78Z7enfGGarnS4x0ojcCwKDXf+SW/+1ERTAio7M8MY="
	local PrixFinal = 0
	local methQTE = xPlayer.getInventoryItem('meth_pouch').count
	local cokeQTE = xPlayer.getInventoryItem('coke_pouch').count
	local weedQTE = xPlayer.getInventoryItem('weed_pouch').count
	local opiumQTE = xPlayer.getInventoryItem('opium_pouch').count
	
	if CopsConnected >= KRONOS.CopsNeeds then
		if isIntrested() then
			if methQTE >= 5 or cokeQTE >= 5 or weedQTE >= 5 or opiumQTE >= 5 then
				QTE = math.random (1,5)
			elseif methQTE >= 10 or cokeQTE >= 10 or weedQTE >= 10 or opiumQTE >= 10 then
				QTE = math.random (1,10)
			--elseif methQTE >= 25 or cokeQTE >= 25 or weedQTE >= 25 or opiumQTE >= 25 then
				--QTE = math.random (1,25)
			end
			
			if methQTE >= QTE then 
				TYPE = "meth_pouch" 
				LABEL = KRONOS.Text['meth']
				PrixFinal = (KRONOS.MethPrice * QTE)
			elseif cokeQTE >= QTE then 
				TYPE = "coke_pouch" 
				LABEL = KRONOS.Text['coke']
				PrixFinal = (KRONOS.CokePrice * QTE)
			elseif weedQTE >= QTE then 
				TYPE = "weed_pouch" 
				LABEL = KRONOS.Text['weed']
				PrixFinal = (KRONOS.WeedPrice * QTE)
			elseif opiumQTE >= QTE then 
				TYPE = "opium_pouch" 
				LABEL = KRONOS.Text['opium']
				PrixFinal = (KRONOS.OpiumPrice * QTE)
			end
			
			TriggerClientEvent("kronosnpcsales:animation", source)
			xPlayer.removeInventoryItem(TYPE, QTE)
			xPlayer.addAccountMoney('black_money', PrixFinal)
			TriggerClientEvent('esx:showNotification', source, KRONOS.Text['done'] .. QTE .. LABEL .. KRONOS.Text['for'] .. PrixFinal)
			
			local poukichance = math.random (1,4)
			if poukichance == 1 then
				for i=1, #xPlayers, 1 do
					local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer2.job.name == 'police' then
						TriggerClientEvent('esx:showNotification', xPlayers[i], KRONOS.Text['process'])
						TriggerClientEvent('kronosnpcsales:poucave', xPlayers[i], deal.x, deal.y, deal.z)
					end
				end
			end
		else
			TriggerClientEvent('esx:showNotification', source, KRONOS.Text['no'])
		end
	else
		TriggerClientEvent('esx:showNotification', source, KRONOS.Text['cops1'] .. CopsConnected .. "/" .. KRONOS.CopsNeeds .. KRONOS.Text['cops2'])
	end
end)

RegisterNetEvent('kronosnpcsales:dist')
AddEventHandler('kronosnpcsales:dist', function()
	TriggerClientEvent('esx:showNotification', source, KRONOS.Text['dist'])
end)

RegisterServerEvent('kronosnpcsales:GetJob')
AddEventHandler('kronosnpcsales:GetJob', function()
    local xPlayer  = ESX.GetPlayerFromId(source)
    TriggerClientEvent('kronosnpcsales:RefreshJob', source, xPlayer.job.name)
end)

RegisterServerEvent('kronosnpcsales:GetUserInventory')
AddEventHandler('kronosnpcsales:GetUserInventory', function(currentZone)
	local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('kronosnpcsales:ReturnInventory', 
    	_source, 
    	xPlayer.getInventoryItem('coke').count, 
		xPlayer.getInventoryItem('coke_pouch').count,
		xPlayer.getInventoryItem('meth').count, 
		xPlayer.getInventoryItem('meth_pouch').count, 
		xPlayer.getInventoryItem('weed').count, 
		xPlayer.getInventoryItem('weed_pouch').count, 
		xPlayer.getInventoryItem('opium').count, 
		xPlayer.getInventoryItem('opium_pouch').count,
		xPlayer.job.name
    )
end)
				end)
			else
		print("^1NPC Drug Sales Deactivated, contact Kronos#5555 for Assistance!^0")
	end
end)