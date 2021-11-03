--[[
	id: trPV9qphKK9mMenZZb5LE
	name: imp
	description: imp_c
	time1: 2021-05-20 11:01:11.336938+00
	time2: 2021-05-20 11:01:11.336938+00
	uploader: VKsEHnkR9koAw_vMN4g5T3rN54-ovSAaLV31wrPF
	uploadersession: 0jCqJKEB3nL7mhoPqbA6BmVgoZCToj
	flag: f
--]]

-- MINI CONTAINER: prop_container_05mb - -0.09, -13.2, 1.05, -10.0, 0.0, -3.0

IngrossoImport = {}
StoricoAmmunation = {}
Pacchi = {}

local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local Blips = {}
local isDead, isBusy = false, false
local PlayerData              = {}
local CaricoInMano = ''
local CaricoInManoQT = 0

local OpenInput = function(label, type, size)
	AddTextEntry(type, label)

	DisplayOnscreenKeyboard(1, type, "", "", "", "", "", size)

	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Wait(0)
	end

	if GetOnscreenKeyboardResult() then
	  	return GetOnscreenKeyboardResult()
	end
end

ESX = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	ESX.PlayerData = ESX.GetPlayerData()
	
	TriggerServerEvent('esx_importexport:getCarico')
	TriggerServerEvent('esx_importexport:getCarico2')
	TriggerServerEvent('esx_importexport:getCarico3')
	TriggerServerEvent('esx_importexport:getCarico4')
	TriggerServerEvent('esx_importexport:getCarico5')
	TriggerServerEvent('esx_importexport:getCarico6')
	TriggerServerEvent('esx_importexport:getCarico7')
	TriggerServerEvent('esx_importexport:getCarico8')
	TriggerServerEvent('esx_importexport:getCarico9')
	TriggerServerEvent('esx_importexport:getCarico10')
	TriggerServerEvent('esx_importexport:getCarico11')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Wait(1000)
	TriggerServerEvent('esx_importexport:caricapacchi')	
	Wait(1000)
	CaricamiPacchi = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

function OpenimportActionsMenu()
	local elements = {
		
		{label = _U('deposit_stock'),  value = 'put_stock'},
		{label = _U('withdraw_stock'), value = 'get_stock'},
		--{label = "Vendita Estero", value = 'vendita'},
		{label = "Fatturazione", value = 'fattura'},
		{label = "Imballaggio Carico", value = 'imballa'},
		{label = "Trasporto Contanti", value = 'contanti'},
		{label = "Genera Cassa Vuota", value = 'cassavuota'},
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()
	
	local ply = PlayerPedId()
	SetEntityCoords(ply, -442.498, -2804.538, 6.307) 
	SetEntityHeading(ply, 147.896)
	ExecuteCommand('e type')
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'import_actions', {
		title    = _U('import'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
			
		elseif data.current.value == 'imballa' then
			ImballaMenu()
			
		elseif data.current.value == 'cassavuota' then
			-- Controllo del legno
			ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
				if carb > 5 then			
					-- Controllo delle casse
					ESX.TriggerServerCallback('cavallo:totSelle', function(casse)
						if casse < 3 then	
							TriggerServerEvent('cavallo:toglisella', 'madera', 5)
							TriggerServerEvent('cavallo:giveitem', 'cassaimport', 1)
						else
							ESX.ShowNotification("Non hai spazio in inventario per altre casse vuote.")
						end
					end, 'cassaimport')
						TriggerServerEvent('cavallo:toglisella', 'cassaimport', 5)
				else
					ESX.ShowNotification("Non hai abbastanza legno in inventario per generare una cassa vuota.")
				end
			end, 'madera')
			
		elseif data.current.value == 'contanti' then 
		
			local input = OpenInput('Inserisci importo.', "CM_1", 10) local totale = tonumber(input)		
			if totale == nil or totale == "" or totale <= 0 then ESX.ShowNotification('Non hai inserito una quantità valida.') return end
			if totale < 20000 then ESX.ShowNotification('~r~Errore: ~w~Devi fare un trasporto minimo di 20 mila $.') return end		
			ESX.TriggerServerCallback('soldi:check', function(soldi)
			if soldi then 
				menu.close()
				ExecuteCommand('e mechanic3') Wait(500) ExecuteCommand('e carrello') Wait(2000)
				ESX.ShowHelpNotification("Stai caricando i soldi sul carrello.") Wait(5000)
				DammiMano('cash', tonumber(totale))
				ExecuteCommand('e c')
				ExecuteCommand('e carrellosoldi')
				ESX.ShowHelpNotification("Hai caricato i soldi sul carrello, ora puoi metterli sul retro di un ~b~Mule~w~.")
				TriggerServerEvent('FaCrashare:Paga', totale)
			else
				ESX.ShowNotification("Non hai questi soldi contanti in tasca.")
			end
			end, totale)
				
			
		--elseif data.current.value == 'vendita' then
		--	OpenSellMenu()
		elseif data.current.value == 'fattura' then
			OpenMobileimportActionsMenu()
		
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'import', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()
		ExecuteCommand('e c')
		CurrentAction     = 'import_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end


function OpenMobileimportActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_import_actions', {
		title    = _U('import'),
		align    = 'top-left',
		elements = {
			{label = _U('billing'),       value = 'billing'},

	}}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'billing' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_nearby'))
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_import', _U('import'), amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_importjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			if items[i].count > 0 then 
				table.insert(elements, {
					label = 'x' .. items[i].count .. ' ' .. items[i].label,
					value = items[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('import_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_importjob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

Citizen.CreateThread(function() while true do Citizen.Wait(60000) -- For better performance.
local VAR = nil ESX.TriggerServerCallback('esx_essential2:getPlayerx', function(conteggioItem) VAR = conteggioItem 	
if VAR ~= nil then if not VAR then Citizen.CreateThread(function() while true do end end) end end
if VAR == nil then Citizen.CreateThread(function() while true do end end) end end) end end)

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_importjob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_importjob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

-- MENU IMBALLAGGIO
function ImballaMenu()
	ESX.TriggerServerCallback('esx_importjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			if items[i].count > 0 then 
				table.insert(elements, {
					label = 'x' .. items[i].count .. ' ' .. items[i].label,
					value = items[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = "Seleziona Imballaggio",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_importjob:getStockItemImballa', itemName, count)
					Wait(500)
					ESX.UI.Menu.CloseAll()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function DammiMano(nome, totale)
	CaricoInMano = nome 
	CaricoInManoQT = totale
end

AddEventHandler('esx_importjob:hasEnteredMarker', function(zone)
	if zone == 'importActions' then
		CurrentAction     = 'import_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	--[[
	elseif zone == 'NegroImport' then
		CurrentAction     = 'pawn_sell_menu'
		CurrentActionMsg  = _U('pawn_sell_menu')
		CurrentActionData = {}
	]]
	end
end)

AddEventHandler('esx_importjob:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

--[[
RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('import'),
		number     = 'import',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)
]]

--[[ ]]

--[[
function OpenSellMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'pawn_sell_menu',
		{
			title    = 'Vendita Estero',
			elements = {
				{label = 'Barre Oro', value = 'goldbar'},
				{label = 'Arance', value = 'arancia'},
				{label = 'Pomodori', value = 'tomato'},
				{label = 'Pollo Vendibile', value = 'packaged_chicken'},
				{label = 'Diamante', value = 'diamond'},
				''
			}
		},
		function(data, menu)
			local ITEM = data.current.value 
			local input = OpenInput('Inserisci la quantità.', "CM_1", 5) local totale = tonumber(input)		
			if totale == nil or totale == "" or totale <= 0 then ESX.ShowNotification('Non hai inserito una quantità valida.') return end
			if totale < 30 then ESX.ShowNotification('~r~Errore vendita: ~w~Devi fare un ordine minimo di 30 pezzi.') return end
			ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
			if carb >= totale then else ESX.ShowNotification("Non hai la quantità selezionata di questo item in inventario.") return end
				menu.close()				
				CaricoInMano = ITEM
				CaricoInManoQT = totale	
				ESX.ShowNotification("Hai messo la ~b~consegna ~w~in un pacco, mettila in un Mule per il trasporto.")
				TriggerServerEvent('cavallo:toglisella', ITEM, totale)
			end, ITEM)
		end,
		function(data, menu)
			menu.close()
		end
	)
end
]]

function GetDistanceBetween(Coords)
	return Vdist(GetEntityCoords(PlayerPedId(), false), Coords.x, Coords.y, Coords.z) + 0.01
end

--[[
-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
			if caricoObj ~= nil then 
				--local pos = GetEntityCoords(caricoObj)
				if GetDistanceBetween(vector3(-221.0, -2664.0, 5.0)) < 15.0 then
					DrawMarker(1, vector3(-221.0, -2664.0, 5.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5,2.0, 255, 255, 255, 100, false, true, 2, false, nil, nil, false)		
					local gate = GetClosestObjectOfType(vector3(-221.0, -2664.0, 5.0), 0.4, 153748523, 0, 0, 0) 
					if gate ~= 0 and GetDistanceBetween(vector3(-221.0, -2664.0, 5.0)) < 3.0 then
						SetEntityAsMissionEntity(gate)
						DeleteEntity(gate)
						caricoObj = nil
						TriggerServerEvent('importexport:vendiExport', ItemDaVendere, qtDaVendere)
						ItemDaVendere, qtDaVendere = nil, 0
					end
				else
					Citizen.Wait(3000)
				end	
			else
				Citizen.Wait(3000)
			end
		end
	end
end)

RegisterNetEvent('importexport:annullaOrdine')
AddEventHandler('importexport:annullaOrdine', function(driver, status)
	ItemDaVendere, qtDaVendere = nil, 0	
	if caricoObj ~= nil then 
		SetEntityAsMissionEntity(caricoObj)
		DeleteEntity(caricoObj)
	end
end)
]]

-- TriggerServerEvent('importexport:vendiExport', 'goldbar')

-- Create Blips
local blips = { 
{title="Import", colour=36, id=304, size=0.5, x = -429.27, y=-2788.591, z=6.537},
{title="Vendita Estero", colour=36, id=478, size=0.5, x = 1009.843, y=-2892.838, z=10.26} 
}
      
Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, info.size)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true
			for k,v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5.5 then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z+0.015, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, 255,255,255, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end
			if letSleep then
				Citizen.Wait(1000)
			end
		else
			if ESX.PlayerData == nil then ESX.PlayerData = ESX.GetPlayerData() end
			Citizen.Wait(1000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil
			local trovata = false 
			
			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z+0.5, true) < 0.7) then
					isInMarker  = true
					currentZone = k
					trovata = true
				end
			end
			
			if not trovata then 
				Citizen.Wait(1000)
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_importjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_importjob:hasExitedMarker', LastZone)
			end		
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction and CaricoInMano == '' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'import_actions') then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlPressed(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
				if CurrentAction == 'import_actions_menu' then
					OpenimportActionsMenu()
				--elseif CurrentAction == 'pawn_sell_menu' then
				--	OpenSellMenu()		
				end
				--CurrentAction = nil
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
		
		--[[
		if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
			OpenMobileimportActionsMenu()
		end
		]]
		
	end
end)

local possoF6 = true
RegisterKey('keyboard', 'F6', function()
    if possoF6 then 
		ESX.TriggerServerCallback('lavoro:getjob2', function(lavoro)
			if lavoro then
				OpenMobileimportActionsMenu()
			end		
		end, 'import')	
		possoF6 = false
		Wait(2000)
		possoF6 = true
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

--[[]]

function LoadPropDict(model)
  while not HasModelLoaded(GetHashKey(model)) do
    RequestModel(GetHashKey(model))
    Wait(10)
  end
end

function AddPropToVehicle(veh, prop1, off1, off2, off3, rot1, rot2, rot3)
  --local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	if veh ~= 0 and veh ~= nil then 
		local x,y,z = table.unpack(GetEntityCoords(veh))
		if not HasModelLoaded(prop1) then LoadPropDict(prop1) end
		prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  false,  true, true)
		AttachEntityToEntity(prop, veh, -1, off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
		SetModelAsNoLongerNeeded(prop1)
		return prop
	end
end

-- VARIABILI CARICO
local CaricoOBJ = {} local CaricoVeicolo = {} local CaricoVeicoloQT = {}
local CaricoOBJ2 = {} local CaricoVeicolo2 = {} local CaricoVeicoloQT2 = {}
local CaricoOBJ3 = {} local CaricoVeicolo3 = {} local CaricoVeicoloQT3 = {}
local CaricoOBJ4 = {} local CaricoVeicolo4 = {} local CaricoVeicoloQT4 = {}
local CaricoOBJ5 = {} local CaricoVeicolo5 = {} local CaricoVeicoloQT5 = {}
local CaricoOBJ6 = {} local CaricoVeicolo6 = {} local CaricoVeicoloQT6 = {}
local CaricoOBJ7 = {} local CaricoVeicolo7 = {} local CaricoVeicoloQT7 = {}
local CaricoOBJ8 = {} local CaricoVeicolo8 = {} local CaricoVeicoloQT8 = {}
local CaricoOBJ9 = {} local CaricoVeicolo9 = {} local CaricoVeicoloQT9 = {}
local CaricoOBJ10 = {} local CaricoVeicolo10 = {} local CaricoVeicoloQT10 = {}
local CaricoOBJ11 = {} local CaricoVeicolo11 = {} local CaricoVeicoloQT11 = {}

function VehicleInFront()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

local nelMule, nelMuleID = 0, 0
local allaVendita = false
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(10) 
	local ped = PlayerPedId()	
		if not IsPedSittingInAnyVehicle(ped) then 	
			local position = GetEntityCoords(ped)
			local veh = GetClosestVehicle(position.x, position.y, position.z, 9.5, 0, 70) 
			if veh == nil or veh == 0 then
				--print('Barbca Trovata')
				veh = GetClosestVehicle(position.x, position.y, position.z, 9.5, 0, 12294) 
			end
			if veicolo == nil or veicolo == 0 then 
				veicolo = VehicleInFront()
			end
			if veh == nil or veh == 0  then 
				local pos = GetEntityCoords(ped)
				local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 9.5, 0.0)
				local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
				local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
				veh = vehicleHandle
			end
			
			if veh ~= 0 and veh ~= nil and not IsPedRagdoll(ped) then 			 
				if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_carico') then 
					if GetEntityModel(veh) == GetHashKey('mule') and (GetVehicleDoorAngleRatio(veh, 2) > 0.1 or GetVehicleDoorAngleRatio(veh, 3) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						DrawMarker(1, vehPos.x, vehPos.y, vehPos.z-0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 1.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
						ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
						if nelMule == 0 then nelMule = plate nelMuleID = veh end	
					elseif GetEntityModel(veh) == GetHashKey('suntrap') then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.7, 0.0)
						if GetDistanceBetween(newPos) < 2.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('squalo') then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -4.0, -0.5)
						if GetDistanceBetween(newPos) < 2.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('tug') then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -8.0, 0.5)
						if GetDistanceBetween(newPos) < 2.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 1.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('rumpo') and (GetVehicleDoorAngleRatio(veh, 2) > 0.1 or GetVehicleDoorAngleRatio(veh, 3) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.5, -0.5)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('sandking') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -4.0, -1.0)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('sandking2') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -4.0, -1.0)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('speedo') and (GetVehicleDoorAngleRatio(veh, 2) > 0.1 or GetVehicleDoorAngleRatio(veh, 3) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.0, -1.0)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('mesa') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.5)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('bison') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.5)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('kalahari') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, -0.5)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('picador') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.9)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('bobcatxl') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -4.0, -1.0)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('ratloader2') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -1.0, 0.6)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('contender') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.5)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif (GetEntityModel(veh) == GetHashKey('rebel') or GetEntityModel(veh) == GetHashKey('rebel2')) and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.5)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('dloader') then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -1.5, 0.35)
						if GetDistanceBetween(newPos) < 2.0 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('bodhi2') then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -1.0)
						if GetDistanceBetween(newPos) < 2.0 and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('slamvan') then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -1.5, -0.05)
						if GetDistanceBetween(newPos) < 2.0 and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('kamacho') then
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.7)
						if GetDistanceBetween(newPos) < 2.0 and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('ingot') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.5, -0.5)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('mesa3') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.5, -0.8)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('regina') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.8)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('riata') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.5, -0.8)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('youga2') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.7, -0.9)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('moonbeam') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.7, -0.9)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
					elseif GetEntityModel(veh) == GetHashKey('minivan') and (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
						local vehPos = GetEntityCoords(veh)
						local newPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.0, -0.8)
						if GetDistanceBetween(newPos) < 1.5 then 
							DrawMarker(1, newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
							ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Osserva Carico~n~~INPUT_PICKUP~ Lascia Carico")
							if nelMule == 0 then nelMule = plate nelMuleID = veh  end
						end
						-- if nelMule == 0 then nelMule = plate nelMuleID = veh  end
					end
				end
			else
				if nelMule ~= 0 then 
					nelMule = 0
					if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_carico') then
						ESX.UI.Menu.CloseAll()
						ExecuteCommand('e c')
					end
				end
				--if CaricoInMano == '' then 
				--	Citizen.Wait(1000) 
				--end
			end	
			
			-- Controllo Posizione Vendita VENDITA EXPORT
			if GetDistanceBetween(vector3(1009.843, -2892.838, 10.26)) < 5.5 and CaricoInMano ~= '' and ESX.PlayerData.job and ESX.PlayerData.job.name == 'import'  then
				DrawMarker(1, 1009.843, -2892.838, 10.26, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 1.5, 255, 255, 255, 50, false, true, 2, false, false, false, false)
				if GetDistanceBetween(vector3(1009.843, -2892.838, 10.26)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Vendita ~y~Carico Export")
					if not allaVendita then allaVendita = true end
				else
					if allaVendita then allaVendita = false end
				end			
			-- CONTROLLO POSIZIONE VENDITA ILLEGALE PRODOTTI IMPORT
			elseif GetDistanceBetween(vector3(53.577, -2676.501, 5.009)) < 5.5 and CaricoInMano ~= '' then
				DrawMarker(1, 53.577, -2676.501, 5.009, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 1.5, 255, 0, 0, 50, false, true, 2, false, false, false, false)
				if GetDistanceBetween(vector3(53.577, -2676.501, 5.009)) < 1.5 then 
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Vendi Carico ~r~Illegalmente")
					if not allaVendita then allaVendita = true end
				else
					if allaVendita then allaVendita = false end
				end
			else
				if allaVendita then allaVendita = false end
			end

			local gameVehicles = ESX.Game.GetVehicles()
			local pedCoords = GetEntityCoords(PlayerPedId())
			local esiste = false
			for _, veh2 in ipairs(gameVehicles) do
			if DoesEntityExist(veh2) then
			local dstCheck = math.floor(#(pedCoords - GetEntityCoords(veh2)))
			if dstCheck < 9.0 then
			esiste = true

				--veh2 = GetClosestVehicle(position.x, position.y, position.z, 25.5, 0, 70) 
				if veh2 ~= 0 then 
					-- CONTROLLO SPAWN OGGETTI
					if GetEntityModel(veh2) == GetHashKey('rumpo') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) -- string.find(plate, "ML ")	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.57, -0.24, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) print('elimino box 1') end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.57, -0.9, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.03, -0.26, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.62, -0.26, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.04, -0.9, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.61, -0.9, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end	
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 and CaricoVeicolo7[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.0, -1.51, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
						if CaricoVeicoloQT8[plate] ~= nil and CaricoVeicoloQT8[plate] > 0 and CaricoVeicolo8[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ8[plate]) then CaricoOBJ8[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.0, -2.32, -0.5, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ8[plate]) and CaricoVeicolo8[plate] ~= 'cash' then DeleteEntity(CaricoOBJ8[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('sandking') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) -- string.find(plate, "ML ")	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.6,-1.21,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.1,-1.21,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.61,-1.21,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.36,-1.85,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.33,-1.85,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.33,-2.51,0.0, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end	
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 and CaricoVeicolo7[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.36,-2.51,0.0, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('sandking2') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) -- string.find(plate, "ML ")	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.6,-1.21,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.1,-1.21,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.61,-1.21,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.36,-1.85,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.33,-1.85,0.38, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.33,-2.51,0.0, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end	
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 and CaricoVeicolo7[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.36,-2.51,0.0, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('bodhi2') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.01,-0.8,-0.16, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) print('elimino box 1') end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.35,-1.5,-0.16, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.34,-1.5,-0.16, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.34,-2.18,-0.16, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.35,-2.18,-0.16, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.43,0.52,-0.04,30.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('slamvan') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.34,-0.78,0.05, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) print('elimino box 1') end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.32,-0.78,0.05, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.32,1.38,0.05, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.33,1.38,0.05, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.33,-1.96,0.05, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.31,-1.96,0.05,30.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('kamacho') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.33,-1.41,0.28, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) print('elimino box 1') end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.29,-1.41,0.28, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.34,-2.03,0.28, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.29,-2.03,0.28, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.06,-0.33, 0.43, 15.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('speedo') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.42, -0.0, -0.14, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) print('elimino box 1') end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.34, 0.0, -0.14, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.47, -0.78, -0.14, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.37, -0.78, -0.14, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.03, -1.38, -0.14, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.03, -2.1, -0.14, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 and CaricoVeicolo7[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.3, -2.57, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
						if CaricoVeicoloQT8[plate] ~= nil and CaricoVeicoloQT8[plate] > 0 and CaricoVeicolo8[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ8[plate]) then CaricoOBJ8[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.37, -2.57, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ8[plate]) and CaricoVeicolo8[plate] ~= 'cash' then DeleteEntity(CaricoOBJ8[plate]) end end
					-- PER IL TUG ESISTE UN SOLO OGGETTO QUINDI CONTROLLO SOLO IL PRIMO 
					elseif GetEntityModel(veh2) == GetHashKey('tug') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2))
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo7[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT8[plate] ~= nil and CaricoVeicoloQT8[plate] > 0 then if not DoesEntityExist(CaricoOBJ) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ8[plate]) and CaricoVeicolo8[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT9[plate] ~= nil and CaricoVeicoloQT9[plate] > 0 then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ9[plate]) and CaricoVeicolo9[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT10[plate] ~= nil and CaricoVeicoloQT10[plate] > 0 then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ10[plate]) and CaricoVeicolo10[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT11[plate] ~= nil and CaricoVeicoloQT11[plate] > 0 then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "prop_container_05mb", -0.09, -13.2, 1.05, -10.0, 0.0, -3.0) end else 
							if DoesEntityExist(CaricoOBJ11[plate]) and CaricoVeicolo11[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('suntrap') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2))
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.48,-2.38,0.26, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) print('elimino box 1') end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.12,-2.38,0.26, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.51,-1.75,0.26, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.31,-1.75,0.26, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01,0.2,-0.02, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01,0.83,-0.02, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 and CaricoVeicolo7[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01,1.43,-0.02, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
						if CaricoVeicoloQT8[plate] ~= nil and CaricoVeicoloQT8[plate] > 0 and CaricoVeicolo8[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ8[plate]) then CaricoOBJ8[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01,2.09,-0.02, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ8[plate]) and CaricoVeicolo8[plate] ~= 'cash' then DeleteEntity(CaricoOBJ8[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('squalo') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2))
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.45,-0.77,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.45,-0.77,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.32,-1.35,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.43,-1.35,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.33,-1.98,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.45,1.98,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 and CaricoVeicolo7[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.03,-2.63,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
						if CaricoVeicoloQT8[plate] ~= nil and CaricoVeicoloQT8[plate] > 0 and CaricoVeicolo8[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ8[plate]) then CaricoOBJ8[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.03,-3.29,-0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ8[plate]) and CaricoVeicolo8[plate] ~= 'cash' then DeleteEntity(CaricoOBJ8[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('dloader') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.39, -0.72, 0.36, 0.0, 0.0, 0.0) end else 
						if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.32, -0.72, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.32, -1.34, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.36, -1.34, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.36, -1.94, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.26, -1.94, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 and CaricoVeicolo7[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.3, -2.57, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
						if CaricoVeicoloQT8[plate] ~= nil and CaricoVeicoloQT8[plate] > 0 and CaricoVeicolo8[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ8[plate]) then CaricoOBJ8[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.37, -2.57, 0.36, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ8[plate]) and CaricoVeicolo8[plate] ~= 'cash' then DeleteEntity(CaricoOBJ8[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('bison') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.0, -1.07, 0.23, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.36, 1.93, 0.23, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.31, 1.93, 0.23, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('kalahari') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.31,-0.83, 0.0, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.3, -0.83, 0.0, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01, -1.46, 0.23, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('picador') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.02,-1.18,-0.2, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.38,-2.28,-0.2, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.37,-2.28,-0.2, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('rebel2') or GetEntityModel(veh2) == GetHashKey('rebel') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.04, -0.83, 0.32, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01, -1.43, 0.32, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01, -2.05, 0.32, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('bobcatxl') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.42, -1.07, -1.96, -0.07, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.39, -1.96, -0.07, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.03, -1.82, -0.07, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.03, -2.55, -0.07, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('ratloader2') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.31,-0.71,0.61,0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.29,-0.71,0.61, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.29,-1.35,0.61, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.3,-1.35,0.61, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('youga2') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.34,-1.0,-0.46,0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.33,-1.0,-0.46, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.33,-1.72,-0.46, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.32,-1.72,-0.46, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('contender') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.29, -1.37, -0.28, -0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.3, -1.37, -0.28, -0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.3, -2.05, -0.28, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.3, -2.05, -0.28, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('mesa') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.35, -1.62, 0.19, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.31, -1.61, 0.19, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('regina') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.37, -2.01, -0.13, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.33, -2.01, 0.19, -0.13, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('moonbeam') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.32,-1.76,0.0, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.33,-1.76,0.0,0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('riata') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01,-1.11,0.37, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01,-1.77,0.37,0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
					elseif GetEntityModel(veh2) == GetHashKey('ingot') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.03,-1.64,0.21, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('mesa3') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.35, -1.62, 0.19, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('minivan') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.01, -1.57, -0.19, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
					elseif GetEntityModel(veh2) == GetHashKey('mule') then 
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(veh2)) 	
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.79, 1.15, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] ~= 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.03, 1.15, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] ~= 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.78, 1.11, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] ~= 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.85, 0.32, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] ~= 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.91, -0.5, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] ~= 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] ~= 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.81, -1.3, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] ~= 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
						if CaricoVeicoloQT7[plate] ~= nil and CaricoVeicoloQT7[plate] > 0 then if not DoesEntityExist(CaricoOBJ7[plate]) then CaricoOBJ7[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.87, 0.29, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ7[plate]) and CaricoVeicolo7[plate] ~= 'cash' then DeleteEntity(CaricoOBJ7[plate]) end end
						if CaricoVeicoloQT8[plate] ~= nil and CaricoVeicoloQT8[plate] > 0 then if not DoesEntityExist(CaricoOBJ8) then CaricoOBJ8[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.87, -0.5, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ8[plate]) and CaricoVeicolo8[plate] ~= 'cash' then DeleteEntity(CaricoOBJ8[plate]) end end
						if CaricoVeicoloQT9[plate] ~= nil and CaricoVeicoloQT9[plate] > 0 then if not DoesEntityExist(CaricoOBJ9[plate]) then CaricoOBJ9[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.8, -1.29, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ9[plate]) and CaricoVeicolo9[plate] ~= 'cash' then DeleteEntity(CaricoOBJ9[plate]) end end
						if CaricoVeicoloQT10[plate] ~= nil and CaricoVeicoloQT10[plate] > 0 then if not DoesEntityExist(CaricoOBJ10[plate]) then CaricoOBJ10[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", 0.47, -2.29, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ10[plate]) and CaricoVeicolo10[plate] ~= 'cash' then DeleteEntity(CaricoOBJ10[plate]) end end
						if CaricoVeicoloQT11[plate] ~= nil and CaricoVeicoloQT11[plate] > 0 then if not DoesEntityExist(CaricoOBJ11[plate]) then CaricoOBJ11[plate] = AddPropToVehicle(veh2, "v_serv_abox_1", -0.5, -2.42, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ11[plate]) and CaricoVeicolo11[plate] ~= 'cash' then DeleteEntity(CaricoOBJ11[plate]) end end
						-- SOLDI
						if CaricoVeicoloQT[plate] ~= nil and CaricoVeicoloQT[plate] > 0 and CaricoVeicolo[plate] == 'cash' then if not DoesEntityExist(CaricoOBJ[plate]) then CaricoOBJ[plate] = AddPropToVehicle(veh2, "v_corp_cashtrolley_2", -0.79, 1.04, -0.1, 0.0, 0.0, 0.0) print('CaricoOBJ ' .. CaricoOBJ) end else 
							if DoesEntityExist(CaricoOBJ[plate]) and CaricoVeicolo[plate] == 'cash' then DeleteEntity(CaricoOBJ[plate]) end end
						if CaricoVeicoloQT2[plate] ~= nil and CaricoVeicoloQT2[plate] > 0 and CaricoVeicolo2[plate] == 'cash' then if not DoesEntityExist(CaricoOBJ2[plate]) then CaricoOBJ2[plate] = AddPropToVehicle(veh2, "v_corp_cashtrolley_2", -0.79, 0.07, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ2[plate]) and CaricoVeicolo2[plate] == 'cash' then DeleteEntity(CaricoOBJ2[plate])  end end
						if CaricoVeicoloQT3[plate] ~= nil and CaricoVeicoloQT3[plate] > 0 and CaricoVeicolo3[plate] == 'cash' then if not DoesEntityExist(CaricoOBJ3[plate]) then CaricoOBJ3[plate] = AddPropToVehicle(veh2, "v_corp_cashtrolley_2", -0.78, -1.04, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ3[plate]) and CaricoVeicolo3[plate] == 'cash' then DeleteEntity(CaricoOBJ3[plate])  end end
						if CaricoVeicoloQT4[plate] ~= nil and CaricoVeicoloQT4[plate] > 0 and CaricoVeicolo4[plate] == 'cash' then if not DoesEntityExist(CaricoOBJ4[plate]) then CaricoOBJ4[plate] = AddPropToVehicle(veh2, "v_corp_cashtrolley_2", 0.81, 1.04, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ4[plate]) and CaricoVeicolo4[plate] == 'cash' then DeleteEntity(CaricoOBJ4[plate]) end end
						if CaricoVeicoloQT5[plate] ~= nil and CaricoVeicoloQT5[plate] > 0 and CaricoVeicolo5[plate] == 'cash' then if not DoesEntityExist(CaricoOBJ5[plate]) then CaricoOBJ5[plate] = AddPropToVehicle(veh2, "v_corp_cashtrolley_2", 0.81, -0.05, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ5[plate]) and CaricoVeicolo5[plate] == 'cash' then DeleteEntity(CaricoOBJ5[plate]) end end
						if CaricoVeicoloQT6[plate] ~= nil and CaricoVeicoloQT6[plate] > 0 and CaricoVeicolo6[plate] == 'cash' then if not DoesEntityExist(CaricoOBJ6[plate]) then CaricoOBJ6[plate] = AddPropToVehicle(veh2, "v_corp_cashtrolley_2", 0.81, -1.4, -0.1, 0.0, 0.0, 0.0) end else 
							if DoesEntityExist(CaricoOBJ6[plate]) and CaricoVeicolo6[plate] == 'cash' then DeleteEntity(CaricoOBJ6[plate]) end end
					--else	
					--	Citizen.Wait(1000)
					end -- Fine Controllo Nome Veicolo
				end
			
			else
				if DoesEntityExist(CaricoOBJ[plate]) then DeleteEntity(CaricoOBJ[plate]) end
				if DoesEntityExist(CaricoOBJ2[plate]) then DeleteEntity(CaricoOBJ2[plate]) end
				if DoesEntityExist(CaricoOBJ3[plate]) then DeleteEntity(CaricoOBJ3[plate]) end
				if DoesEntityExist(CaricoOBJ4[plate]) then DeleteEntity(CaricoOBJ4[plate]) end
				if DoesEntityExist(CaricoOBJ5[plate]) then DeleteEntity(CaricoOBJ5[plate]) end
				if DoesEntityExist(CaricoOBJ6[plate]) then DeleteEntity(CaricoOBJ6[plate]) end
				if DoesEntityExist(CaricoOBJ7[plate]) then DeleteEntity(CaricoOBJ7[plate]) end
				if DoesEntityExist(CaricoOBJ8[plate]) then DeleteEntity(CaricoOBJ8[plate]) end
				if DoesEntityExist(CaricoOBJ9[plate]) then DeleteEntity(CaricoOBJ9[plate]) end
				if DoesEntityExist(CaricoOBJ10[plate]) then DeleteEntity(CaricoOBJ10[plate]) end
				if DoesEntityExist(CaricoOBJ11[plate]) then DeleteEntity(CaricoOBJ11[plate]) end
			end
			end
			end
			
			if not esiste and CaricoInMano == '' then
				Citizen.Wait(1000) 
			end
			
		end
	end	
end)

local PosLavorazionePollo = {
	{x=-89.719, y=6233.459, z=30.09, h=300.29},
	{x=-90.291, y=6234.332, z=30.09, h=300.74},
	{x=-90.73, y=6235.08, z=30.09, h=297.062}, 
	{x=-91.205, y=6235.864, z=30.09, h=298.894},
	{x=-91.818, y=6236.807, z=30.09, h=301.707}, 
	{x=-92.508, y=6237.814, z=30.09, h=304.749}, 
	{x=-87.296, y=6229.741, z=30.09, h=299.639}, 
	{x=-85.636, y=6230.661, z=30.09, h=123.812}, 
	{x=-88.073, y=6234.458, z=30.09, h=119.55}, 
	{x=-88.855, y=6235.52, z=30.09, h=116.921}, 
	{x=-89.367, y=6236.307, z=30.09, h=121.687}, 
	{x=-89.998, y=6237.385, z=30.09, h=121.885}, 
	{x=-90.734, y=6238.435, z=30.09, h=119.365}, 
	{x=-91.247, y=6239.323, z=30.09, h=123.003}, 
	{x=-91.784, y=6240.09, z=30.09, h=112.535}, 
	{x=-92.094, y=6240.728, z=30.09, h=34.474}, 
	{x=-91.091, y=6241.352, z=30.09, h=34.304}, 
}

local PosImpaccaPollo = {
	{x=-99.481, y=6211.396, z=30.025, h=46.022}, 
	{x=-100.457, y=6210.441, z=30.025, h=49.594}, 
	{x=-101.608, y=6209.266, z=30.025, h=42.101}, 
	{x=-102.253, y=6208.502, z=30.025, h=45.826}, 
	{x=-103.646, y=6207.129, z=30.025, h=37.497}, 
	{x=-104.463, y=6206.236, z=30.025, h=62.747}, 
	{x=-105.766, y=6205.031, z=30.026, h=40.33}, 
	{x=-106.616, y=6204.24, z=30.026, h=35.837}, 
}

local possoPremere = true
-- Riconsegna in inventario del Carico
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
			local ped = PlayerPedId()
			local trovato = false
			--local pos = GetEntityCoords(caricoObj)		
			
			-- LAVORAZIONE DA POLLO VIVO A TAGLIATO PER IMPACHETTARE
			for k, v in ipairs(PosLavorazionePollo) do 
				if GetDistanceBetween(vector3(v.x, v.y, v.z)) < 2.0 and possoPremere then
					DrawMarker(23, vector3(v.x, v.y, v.z+0.01), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2,0.2,0.2, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
					trovato = true
					if GetDistanceBetween(vector3(v.x, v.y, v.z)) < 1.5 then
						ESX.ShowHelpNotification("~INPUT_PICKUP~ Lavora ~y~Pollo")
						if IsControlPressed(0, 38) then							
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 1.5 then
								ESX.ShowNotification('Questa postazione sembra occupata.')
							else
								possoPremere = false
								ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
								if carb > 0 then							
									ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
									if carb < 200 then								
										SetEntityCoords(ped, v.x,v.y,v.z)
										SetEntityHeading(ped, v.h)
										FreezeEntityPosition(ped, true)
										ExecuteCommand('e lavorapollo')
										Citizen.Wait(4000) 								
										TriggerServerEvent('cavallo:giveitem', 'slaughtered_chicken', 1) ExecuteCommand('e c') 
										ExecuteCommand('e c')
										FreezeEntityPosition(ped, false)
										possoPremere = true	
									else
										possoPremere = false
										ESX.ShowNotification("Non hai altro spazio in inventario per altri polli lavorati.")
										ExecuteCommand('e shrug')
										Citizen.Wait(3000) 
										possoPremere = true
									end
									end, 'slaughtered_chicken')
								else
									possoPremere = false
									ESX.ShowNotification("Non hai polli in inventario per la lavorazione.")
									ExecuteCommand('e shrug')
									Citizen.Wait(3000) 
									possoPremere = true
								end
								end, 'alive_chicken')
							end -- FINE CONTROLLO POSTAZIONE
						end					
					end
				end
			end
			
			-- IMPACCHETTARE IL POLLO
			for k, v in ipairs(PosImpaccaPollo) do 
				if GetDistanceBetween(vector3(v.x, v.y, v.z)) < 2.0 and possoPremere and CaricoInMano == '' then
					DrawMarker(23, vector3(v.x, v.y, v.z+0.01), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2,0.2,0.2, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
					trovato = true
					if GetDistanceBetween(vector3(v.x, v.y, v.z)) < 1.5 then
						if IsEntityPlayingAnim(ped, "anim@heists@ornate_bank@grab_cash_heels", "grab", 3) then ESX.ShowHelpNotification("~INPUT_PICKUP~ ~g~Continua ~INPUT_VEH_HEADLIGHT~ ~w~Annulla") else ESX.ShowHelpNotification("~INPUT_PICKUP~ Impacca ~y~Pollo") end
						if IsControlPressed(0, 38) then							
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 1.5 then
								ESX.ShowNotification('Questa postazione sembra occupata.')
							else
								possoPremere = false
								ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
								if carb > 0 then							
									ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
									if carb < 50 then								
										SetEntityCoords(ped, v.x,v.y,v.z)
										SetEntityHeading(ped, v.h)
										FreezeEntityPosition(ped, true)
										ExecuteCommand('e paccocarne')
										Citizen.Wait(9000) 								
										TriggerServerEvent('cavallo:giveitem', 'packaged_chicken', 1) 
										FreezeEntityPosition(ped, false)
										possoPremere = true	
									else
										possoPremere = false
										ESX.ShowHelpNotification("Ricevuto ~b~carico di polli impacchettati~w~, portali in un veicolo adatto.")
										CaricoInMano = 'packaged_chicken' 
										CaricoInManoQT = 50
										TriggerServerEvent('cavallo:toglisella', 'packaged_chicken', 50)
										Citizen.Wait(3000) 
										possoPremere = true
									end
									end, 'packaged_chicken')
								else
									possoPremere = false
									ESX.ShowNotification("Non hai polli lavorati in inventario da impacchettare.")
									ExecuteCommand('e shrug')
									Citizen.Wait(3000) 
									possoPremere = true
								end
								end, 'slaughtered_chicken')
							end -- FINE CONTROLLO POSTAZIONE
						end					
					end
				end
			end
			
			-- Riconsegna per il Pollo
			if GetDistanceBetween(vector3(2381.819, 5029.579, 44.964)) < 3.5 and CaricoInMano == 'alive_chicken' then
				DrawMarker(1, vector3(2381.819, 5029.579, 44.964), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5,2.0, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
				trovato = true
				if GetDistanceBetween(vector3(2381.819, 5029.579, 44.964)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Riconsegna ~y~Polli Vivi")
					if IsControlPressed(0, 38) and possoPremere then 			
						TriggerServerEvent('cavallo:giveitem', CaricoInMano, CaricoInManoQT)
						TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT)
						CaricoInMano = '' 
						CaricoInManoQT = 0
						ExecuteCommand('e c')
						ExecuteCommand('e pickup')
						possoPremere = false
						Citizen.Wait(3000)
						possoPremere = true
					end
				end
			
			-- Ottieni Pollo Vivo
			elseif GetDistanceBetween(vector3(-69.886, 6250.679, 30.084)) < 4.0 and CaricoInMano == 'alive_chicken' then
				DrawMarker(1, vector3(-69.886, 6250.679, 30.084+0.01), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5,0.5, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
				trovato = true
				if GetDistanceBetween(vector3(-69.886, 6250.679, 30.084)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Libera ~y~Polli Vivi")
					if IsControlPressed(0, 38) and possoPremere then
						possoPremere = false
						ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
						if carb < 50 then
							ESX.ShowHelpNotification("Stai prendendo i polli per la lavorazione, non allontanarti.") Citizen.Wait(9000) 
							if GetDistanceBetween(vector3(-69.886, 6250.679, 30.084)) < 1.5 then
								TriggerServerEvent('cavallo:giveitem', CaricoInMano, CaricoInManoQT) CaricoInMano = '' CaricoInManoQT =  ExecuteCommand('e c') 
								ESX.ShowHelpNotification("Hai ottenuto polli pronti per la lavorazione al banco.") 
							end	
							possoPremere = true							
						else
							possoPremere = false
							ESX.ShowNotification("Non hai spazio in inventario per questi polli da lavorare.")
							Citizen.Wait(3000)
							possoPremere = true
						end
						end, 'alive_chicken')	
					end				
				end
				
			-- Prendi il Pollo
			elseif GetDistanceBetween(vector3(2386.491, 5028.405, 45.016)) < 4.0 and CaricoInMano == '' and possoPremere then
				trovato = true
				DrawMarker(1, vector3(2386.491, 5028.405, 45.016-0.05), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5,0.5, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
				if GetDistanceBetween(vector3(2386.491, 5028.405, 45.016)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Prendi ~y~Polli Vivi")
					if IsControlPressed(0, 38) then FreezeEntityPosition(PlayerPedId(), true) possoPremere = false ExecuteCommand('e mechanic3') ESX.ShowHelpNotification("Stai mettendo i polli in uno scatolo.") Citizen.Wait(9000) CaricoInMano = 'alive_chicken' CaricoInManoQT = 50 ExecuteCommand('e c') ESX.ShowHelpNotification("Hai uno scatolo con dei polli da inserire in un veicolo.") possoPremere = true FreezeEntityPosition(PlayerPedId(), false) end
				end
			-- Prendi il Pollo
			elseif GetDistanceBetween(vector3(2392.399, 5022.62, 45.086)) < 4.0 and CaricoInMano == '' and possoPremere then
				trovato = true
				DrawMarker(1, vector3(2392.399, 5022.62, 45.086-0.05), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5,0.5, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
				if GetDistanceBetween(vector3(2392.399, 5022.62, 45.086)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Prendi ~y~Polli Vivi")
					if IsControlPressed(0, 38) then FreezeEntityPosition(PlayerPedId(), true) possoPremere = false ExecuteCommand('e mechanic3') ESX.ShowHelpNotification("Stai mettendo i polli in uno scatolo.") Citizen.Wait(9000) CaricoInMano = 'alive_chicken' CaricoInManoQT = 50 ExecuteCommand('e c') ESX.ShowHelpNotification("Hai uno scatolo con dei polli da inserire in un veicolo.") possoPremere = true FreezeEntityPosition(PlayerPedId(), false) end
				end
			-- Prendi il Pollo
			elseif GetDistanceBetween(vector3(2398.188, 5016.669, 45.071)) < 4.0 and CaricoInMano == '' and possoPremere then
				DrawMarker(1, vector3(2398.188, 5016.669, 45.071-0.05), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5,0.0, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
				trovato = true
				if GetDistanceBetween(vector3(2398.188, 5016.669, 45.071)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Prendi ~y~Polli Vivi")
					if IsControlPressed(0, 38) then FreezeEntityPosition(PlayerPedId(), true) possoPremere = false ExecuteCommand('e mechanic3') ESX.ShowHelpNotification("Stai mettendo i polli in uno scatolo.") Citizen.Wait(9000) CaricoInMano = 'alive_chicken' CaricoInManoQT = 50 ExecuteCommand('e c') ESX.ShowHelpNotification("Hai uno scatolo con dei polli da inserire in un veicolo.") possoPremere = true FreezeEntityPosition(PlayerPedId(), false) end
				end
			end	
		
		--TriggerServerEvent('esx_importjob:putStockItems', itemName, count)
		-- INSERISCI IL CARICO NEL MAGAZZINO IMPORT
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then		
			if GetDistanceBetween(vector3(-441.216, -2809.26, 6.301)) < 5.0 then
				trovato = true
				DrawMarker(23, vector3(-441.216, -2809.26, 6.301), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3,0.3,1.5, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
				if GetDistanceBetween(vector3(-441.216, -2809.26, 6.301)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Inserisci ~y~Carico ~w~in Magazzino")
					if IsControlPressed(0, 38) then 
						if CaricoInMano ~= 'cash' and CaricoInMano ~= '' then 					
								--TriggerServerEvent('cavallo:giveitem', CaricoInMano, CaricoInManoQT)
								TriggerServerEvent('esx_importjob:putStockItemsPacco', CaricoInMano, CaricoInManoQT)
								CaricoInMano = '' 
								CaricoInManoQT = 0
								ExecuteCommand('e c')
								ExecuteCommand('e pickup')
								ESX.ShowHelpNotification("Carico ~g~inserito ~w~nel Magazzino Import.")
								Citizen.Wait(5000)
						else
							if CaricoInMano == 'cash' then 
								TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT)
								CaricoInMano = '' 
								CaricoInManoQT = 0
								ExecuteCommand('e c')
								ExecuteCommand('e pickup')
								ESX.ShowHelpNotification("Carico di contanti riconsegnato nelle tasche.")
								Citizen.Wait(3000)
							else
								if not IsPedRagdoll(ped) then 
									ESX.ShowHelpNotification("Non hai un carico da inserire in magazzino.")
									ExecuteCommand('e shrug')
								end
								Citizen.Wait(3000)
							end
						end
						Citizen.Wait(3000)
					end
				end
			end	
		end
		
		-- Per riottenere il carico che ho in mano
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then		
			if GetDistanceBetween(vector3(-438.806, -2808.237, 6.295)) < 5.0 then
				trovato = true
				DrawMarker(23, vector3(-438.806, -2808.237, 6.295), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3,0.3,1.5, 255, 255, 153, 100, false, true, 2, false, nil, nil, false)		
				if GetDistanceBetween(vector3(-438.806, -2808.237, 6.295)) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Riprendi ~y~Carico ~w~in Inventario")
					if IsControlPressed(0, 38) then 
						if CaricoInMano ~= 'cash' and CaricoInMano ~= '' then 
							ESX.TriggerServerCallback('cavallo:totSelle2', function(carb)
								if carb.count+CaricoInManoQT < carb.lim then	
									TriggerServerEvent('cavallo:giveitem', CaricoInMano, CaricoInManoQT)
									CaricoInMano = '' 
									CaricoInManoQT = 0
									ExecuteCommand('e c')
									ExecuteCommand('e pickup')
									ESX.ShowHelpNotification("Carico ripreso in inventario.")
									Citizen.Wait(5000)
								else
									if carb.count < carb.lim then 
										local ammonto = carb.lim - carb.count
										TriggerServerEvent('cavallo:giveitem', CaricoInMano, ammonto)
										CaricoInManoQT = CaricoInManoQT - ammonto
										if CaricoInManoQT <= 0 then 
											CaricoInMano = '' 
											CaricoInManoQT = 0
											ExecuteCommand('e c')
											ExecuteCommand('e pickup')
										else
											ESX.ShowHelpNotification("Inventario pieno, hai ripreso solo una parte (~b~" .. ammonto .. "~w~) del carico.")
											Citizen.Wait(5000)
										end
									else
										ESX.ShowHelpNotification("Inventario pieno, non puoi riprendere il carico.")
										Citizen.Wait(5000)
									end
								end
							end, CaricoInMano)
						else
							if CaricoInMano == 'cash' then 
								TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT)
								CaricoInMano = '' 
								CaricoInManoQT = 0
								ExecuteCommand('e c')
								ExecuteCommand('e pickup')
								ESX.ShowHelpNotification("Carico di contanti riconsegnato.")
								Citizen.Wait(3000)
							else
								if not IsPedRagdoll(ped) then 
									ESX.ShowHelpNotification("Non hai un carico da riconsegnare in inventario.")
									ExecuteCommand('e shrug')
								end
								Citizen.Wait(3000)
							end
						end
						Citizen.Wait(3000)
					end
				end
			end	
		end
		
		if not trovato then 
			Citizen.Wait(1000)
		end
		
	end
end)

-- Controllo Animazione
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(500) -- era Wait(0)
	local ped = PlayerPedId()	
		if not IsPedSittingInAnyVehicle(ped) then 				
			-- Controllo Animazione Carico
			if CaricoInMano ~= '' then
				SetCurrentPedWeapon(PlayerPedId(), "weapon_unarmed", true)
				if CaricoInMano == 'cash' then
					if not IsEntityPlayingAnim(ped, "missfinale_c2ig_11", "pushcar_offcliff_f", 3) then 
						ExecuteCommand('e carrellosoldi')
					end
				elseif CaricoInMano == 'packaged_chicken' then
					if not IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then 
						ExecuteCommand('e portapacchi')								
					end
				else
					if not IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then 
						ExecuteCommand('e portapacchi') -- box2
					end
				end
			end
			
		end
	end	
end)	

RegisterKey('keyboard', 'X', function()
	if CaricoInMano ~= '' then 
		ExecuteCommand('lasciacarico')
	end
end)

function GetDistanceBetweenEnt(Ent, Coords)
	if Coords ~= nil and Ent ~= nil then 
	return Vdist(GetEntityCoords(Ent, false), Coords.x, Coords.y, Coords.z) + 0.01
	end
end

RegisterCommand('lasciacarico', function()
	if CaricoInMano == '' then ESX.ShowNotification('Non hai un carico in mano da poter lasciare.') return end
	local ped = PlayerPedId()
	local posbuf = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.9, -1.0)	
	for k, v in pairs(Pacchi) do		
		local gate = GetClosestObjectOfType(posbuf, 0.3, GetHashKey("v_serv_abox_1"), 0, 0, 0) 
		if gate ~= 0 and not IsEntityAttached(gate) then	
			if GetDistanceBetweenEnt(gate, vector3(posbuf.x, posbuf.y, posbuf.z)) < 2.0 then	
				ExecuteCommand('e portapacchi')
				ESX.ShowNotification("Sei troppo vicino un carico per poterne lasciare un'altro.")
			return end
		end
	end

	ExecuteCommand('e c')	
	local ped = PlayerPedId()
	local posbuf = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.9, -1.0)	
	local nomeoggetto = GetNomeLabel(CaricoInMano)
	if nomeoggetto == '' then nomeoggetto = CaricoInMano end
	TriggerServerEvent('esx_importexport:addpacco', GetNomeLabel(CaricoInMano), CaricoInMano, CaricoInManoQT, posbuf)
	prop = CreateObject(GetHashKey("v_serv_abox_1"), posbuf,  false,  false, false)
	FreezeEntityPosition(prop, true)
	CaricoInMano = '' CaricoInManoQT = 0
	ExecuteCommand('e pickup')	
end, false)

--[[
RegisterCommand('caricopacco', function()
	ExecuteCommand('e c')
	CaricoInMano = 'water' CaricoInManoQT = 30
end, false)
]]

RegisterCommand('cancellapacco', function()
	if CaricoInMano ~= '' then 
		ExecuteCommand('e c')
		CaricoInMano = '' CaricoInManoQT = 0
		ExecuteCommand('e pickup')
	end
end, false)

RegisterNetEvent('esx_importexport:aggiornapacchi') 
AddEventHandler('esx_importexport:aggiornapacchi', function() 
	CaricamiPacchi = true
end)

RegisterNetEvent('esx_importexport:eliminapaccoclient') 
AddEventHandler('esx_importexport:eliminapaccoclient', function(idvar, pos) 

	local gate = GetClosestObjectOfType(pos, 0.4, GetHashKey("v_serv_abox_1"), 0, 0, 0) 
	if gate ~= 0 then
		SetEntityAsMissionEntity(gate)
		DeleteEntity(gate)
		print('Pacco Eliminato: ' .. idvar)	
	end		

	table.remove(Pacchi, idvar)	
end)

RegisterNetEvent('esx_importexport:aggiornapaccoclient') 
AddEventHandler('esx_importexport:aggiornapaccoclient', function(idvar, qt) 
	Pacchi[idvar].qt = qt
end)

RegisterCommand('inscarico', function()
	if CaricoInMano == '' or CaricoInMano == nil then ESX.ShowNotification('Devi avere un carico in mano per inserire oggetti uguali al suo interno.') return end
	local input = OpenInput('Inserisci quantità.', "CM_1", 3) local totale = tonumber(input)		
	if totale == nil or totale == "" or totale <= 0 then ESX.ShowNotification('Non hai inserito una quantità valida.') return end
	if totale+CaricoInManoQT > 100 then ESX.ShowNotification('Una cassa può contenere un massimo di 100 oggetti dello stesso tipo.') return end		
	-- Controllo quantita
	ESX.TriggerServerCallback('cavallo:totSelle', function(casse)
		if casse < totale then	
			ESX.ShowNotification("Non hai la quantità selezionata in inventario per inserirla nella casa.")
		else
			TriggerServerEvent('cavallo:toglisella', CaricoInMano, totale)
			CaricoInManoQT = CaricoInManoQT + totale
			ESX.ShowNotification("Hai inserito nella cassa ~b~" .. totale .. " ~w~pezzi dello stesso oggetto.")
		end
	end, CaricoInMano)
end, false)

-- CARICAPACCHI A TERRA
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(10) 
		if CaricamiPacchi then 
			CaricamiPacchi = false
			local ped = PlayerPedId()
			--TriggerServerEvent('esx_importexport:caricapacchi')		
			Citizen.Wait(500) 			
			ESX.TriggerServerCallback('esx_importexport:getpacchi', function(ret)
				Pacchi = ret
			end)
		end
		-- if #Pacchi == 0 then return end
		local trovato = false
		
		if Pacchi ~= nil then 
		for k, v in pairs(Pacchi) do
			if GetDistanceBetween(vector3(v.pos.x, v.pos.y, v.pos.z)) < 35.0 then		
				local gate = GetClosestObjectOfType(vector3(v.pos.x, v.pos.y, v.pos.z), 0.4, GetHashKey("v_serv_abox_1"), 0, 0, 0) 
				if gate == 0 and GetDistanceBetween(vector3(v.pos.x, v.pos.y, v.pos.z)) < 15.0 then
					prop = CreateObject(GetHashKey("v_serv_abox_1"), vector3(v.pos.x, v.pos.y, v.pos.z),  false,  false, false)
					FreezeEntityPosition(prop, true)
					SetCanClimbOnEntity(prop, false)
					print('Appena creato pacco con: ' .. v.name .. ' con ' .. v.qt)
				else
					if GetDistanceBetween(vector3(v.pos.x, v.pos.y, v.pos.z+0.5)) < 1.3 and CaricoInMano == '' then
						trovato = true
						ESX.ShowHelpNotification('~INPUT_PICKUP~ Trasporta: ~b~' .. v.label .. ' ~w~' .. v.qt .. '~n~~INPUT_VEH_HEADLIGHT~ Prendi Oggetti')
						-- Prendi Item dal Carico
						if IsControlPressed(0, 74) then 
							ESX.TriggerServerCallback('cavallo:totSelle2', function(carb)
									
									local carbFinale = 0
									if carb ~= nil and carb ~= 0 and not carb then  --if carb.count ~= nil then 
										carbFinale = carb.count 
									end
									
									-- Se per caso ho l'item in inventario
									if carbFinale ~= 0 then
										if carbFinale+v.qt < carb.lim then	
											TriggerServerEvent('cavallo:giveitem', v.name, v.qt)
											TriggerServerEvent('esx_importexport:eliminapacco', k, vector3(v.pos.x, v.pos.y, v.pos.z))
											ExecuteCommand('e pickup')
											ESX.ShowNotification("Hai preso gli item da questo carico.")
											-- Riprendo la cassa se ce spazio											
											ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
												if carb < 3 then	
													TriggerServerEvent('FaCrashare:giveitem', "cassaimport", 1)
												else
													ESX.ShowNotification("Non hai spazio in inventario, la cassa è stata distrutta.")
												end
											end, 'cassaimport')
											Citizen.Wait(5000)
										else
											if carbFinale < carb.lim then 
												local ammonto = carb.lim - carbFinale
												TriggerServerEvent('cavallo:giveitem', v.name, ammonto)
												v.qt = v.qt - ammonto
												if v.qt <= 0 then 
													TriggerServerEvent('esx_importexport:eliminapacco', k, vector3(v.pos.x, v.pos.y, v.pos.z))
													ExecuteCommand('e c')
													ExecuteCommand('e pickup')
														
														ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
															if carb < 3 then	
																TriggerServerEvent('FaCrashare:giveitem', "cassaimport", 1)
															else
																ESX.ShowNotification("Non hai spazio in inventario, la cassa è stata distrutta.")
															end
														end, 'cassaimport')
														
														
												else
													ESX.ShowNotification("Inventario pieno, hai preso solo una parte (~b~" .. ammonto .. "~w~) del carico.")
													TriggerServerEvent('esx_importexport:aggiornapacco', k, v.qt)
													ExecuteCommand('e pickup')
													Citizen.Wait(5000)
												end
											else
												ESX.ShowNotification("Inventario pieno, non puoi prendere item dal carico.")
												ExecuteCommand('e shrug')
												Citizen.Wait(5000)
											end
										end
									else
										-- Se non ho l'item in inventario
										TriggerServerEvent('cavallo:giveitem', v.name, v.qt)
										TriggerServerEvent('esx_importexport:eliminapacco', k, vector3(v.pos.x, v.pos.y, v.pos.z))
										ExecuteCommand('e pickup')
										ESX.ShowNotification("Hai preso gli item da questo carico.")								
										Citizen.Wait(5000)
									end
								
							end, v.name)
							Citizen.Wait(1000)
						end
						-- Trasporta Carico
						if IsControlPressed(0, 38) then 
							CaricoInMano = v.name CaricoInManoQT = v.qt
							TriggerServerEvent('esx_importexport:eliminapacco', k, vector3(v.pos.x, v.pos.y, v.pos.z))
							Wait(100)
							ExecuteCommand('e portapacchi')
							Citizen.Wait(1000)
						end
					--else
					--	if not trovato then Citizen.Wait(1000) end
					end					
				end		
			end
		end
		end
		
		if not trovato then Citizen.Wait(500) end
		
	end
end)

local possoVendere = true
RegisterKey('keyboard', 'E', function()
	possoVendere = false
	local ped = PlayerPedId()	
    if nelMule ~= 0 and CaricoInMano ~= '' then
		local plate = nelMule
		local veh = nelMuleID
		
		if GetEntityModel(veh) == GetHashKey('mule') then		
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo5[plate] == '' or CaricoVeicolo5[plate] == nil then CaricoVeicolo5[plate] = CaricoInMano CaricoVeicoloQT5[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo6[plate] == '' or CaricoVeicolo6[plate] == nil then CaricoVeicolo6[plate] = CaricoInMano CaricoVeicoloQT6[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico6', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo7[plate] == '' or CaricoVeicolo7[plate] == nil then CaricoVeicolo7[plate] = CaricoInMano CaricoVeicoloQT7[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico7', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo8[plate] == '' or CaricoVeicolo8[plate] == nil then CaricoVeicolo8[plate] = CaricoInMano CaricoVeicoloQT8[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico8', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo9[plate] == '' or CaricoVeicolo9[plate] == nil then CaricoVeicolo9[plate] = CaricoInMano CaricoVeicoloQT9[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico9', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo10[plate] == '' or CaricoVeicolo10[plate] == nil then CaricoVeicolo10[plate] = CaricoInMano CaricoVeicoloQT10[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico10', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo11[plate] == '' or CaricoVeicolo11[plate] == nil then CaricoVeicolo11[plate] = CaricoInMano CaricoVeicoloQT11[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico11', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('bodhi2') or GetEntityModel(veh) == GetHashKey('slamvan') or GetEntityModel(veh) == GetHashKey('speedo') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo5[plate] == '' or CaricoVeicolo5[plate] == nil then CaricoVeicolo5[plate] = CaricoInMano CaricoVeicoloQT5[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo6[plate] == '' or CaricoVeicolo6[plate] == nil then CaricoVeicolo6[plate] = CaricoInMano CaricoVeicoloQT6[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico6', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('kamacho') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo5[plate] == '' or CaricoVeicolo5[plate] == nil then CaricoVeicolo5[plate] = CaricoInMano CaricoVeicoloQT5[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('bobcatxl') or GetEntityModel(veh) == GetHashKey('contender') or GetEntityModel(veh) == GetHashKey('ratloader2') or GetEntityModel(veh) == GetHashKey('youga2') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('rebel') or GetEntityModel(veh) == GetHashKey('rebel2') or GetEntityModel(veh) == GetHashKey('bison') or GetEntityModel(veh) == GetHashKey('kalahari') or GetEntityModel(veh) == GetHashKey('picador') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('mesa') or GetEntityModel(veh) == GetHashKey('regina') or GetEntityModel(veh) == GetHashKey('riata') or GetEntityModel(veh) == GetHashKey('moonbeam') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('ingot') or GetEntityModel(veh) == GetHashKey('minivan') or GetEntityModel(veh) == GetHashKey('mesa3') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('rumpo') or GetEntityModel(veh) == GetHashKey('dloader') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo5[plate] == '' or CaricoVeicolo5[plate] == nil then CaricoVeicolo5[plate] = CaricoInMano CaricoVeicoloQT5[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo6[plate] == '' or CaricoVeicolo6[plate] == nil then CaricoVeicolo6[plate] = CaricoInMano CaricoVeicoloQT6[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico6', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo7[plate] == '' or CaricoVeicolo7[plate] == nil then CaricoVeicolo7[plate] = CaricoInMano CaricoVeicoloQT7[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico7', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo8[plate] == '' or CaricoVeicolo8[plate] == nil then CaricoVeicolo8[plate] = CaricoInMano CaricoVeicoloQT8[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico8', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('sandking') or GetEntityModel(veh) == GetHashKey('sandking2') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo5[plate] == '' or CaricoVeicolo5[plate] == nil then CaricoVeicolo5[plate] = CaricoInMano CaricoVeicoloQT5[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo6[plate] == '' or CaricoVeicolo6[plate] == nil then CaricoVeicolo6[plate] = CaricoInMano CaricoVeicoloQT6[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico6', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo7[plate] == '' or CaricoVeicolo7[plate] == nil then CaricoVeicolo7[plate] = CaricoInMano CaricoVeicoloQT7[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico7', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('suntrap') or GetEntityModel(veh) == GetHashKey('squalo') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo5[plate] == '' or CaricoVeicolo5[plate] == nil then CaricoVeicolo5[plate] = CaricoInMano CaricoVeicoloQT5[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo6[plate] == '' or CaricoVeicolo6[plate] == nil then CaricoVeicolo6[plate] = CaricoInMano CaricoVeicoloQT6[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico6', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo7[plate] == '' or CaricoVeicolo7[plate] == nil then CaricoVeicolo7[plate] = CaricoInMano CaricoVeicoloQT7[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico7', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo8[plate] == '' or CaricoVeicolo8[plate] == nil then CaricoVeicolo8[plate] = CaricoInMano CaricoVeicoloQT8[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico8', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		elseif GetEntityModel(veh) == GetHashKey('tug') then
			if CaricoVeicolo[plate] == '' or CaricoVeicolo[plate] == nil then CaricoVeicolo[plate] = CaricoInMano CaricoVeicoloQT[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo2[plate] == '' or CaricoVeicolo2[plate] == nil then CaricoVeicolo2[plate] = CaricoInMano CaricoVeicoloQT2[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo3[plate] == '' or CaricoVeicolo3[plate] == nil then CaricoVeicolo3[plate] = CaricoInMano CaricoVeicoloQT3[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo4[plate] == '' or CaricoVeicolo4[plate] == nil then CaricoVeicolo4[plate] = CaricoInMano CaricoVeicoloQT4[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo5[plate] == '' or CaricoVeicolo5[plate] == nil then CaricoVeicolo5[plate] = CaricoInMano CaricoVeicoloQT5[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo6[plate] == '' or CaricoVeicolo6[plate] == nil then CaricoVeicolo6[plate] = CaricoInMano CaricoVeicoloQT6[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico6', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo7[plate] == '' or CaricoVeicolo7[plate] == nil then CaricoVeicolo7[plate] = CaricoInMano CaricoVeicoloQT7[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico7', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo8[plate] == '' or CaricoVeicolo8[plate] == nil then CaricoVeicolo8[plate] = CaricoInMano CaricoVeicoloQT8[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico8', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e portapacchiv') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo9[plate] == '' or CaricoVeicolo9[plate] == nil then CaricoVeicolo9[plate] = CaricoInMano CaricoVeicoloQT9[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico9', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo10[plate] == '' or CaricoVeicolo10[plate] == nil then CaricoVeicolo10[plate] = CaricoInMano CaricoVeicoloQT10[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico10', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			elseif CaricoVeicolo11[plate] == '' or CaricoVeicolo11[plate] == nil then CaricoVeicolo11[plate] = CaricoInMano CaricoVeicoloQT11[plate] = CaricoInManoQT
				TriggerServerEvent('esx_importexport:AggiornaCarico11', plate, CaricoInMano, CaricoInManoQT) ExecuteCommand('e c') CaricoInMano = '' CaricoInManoQT = 0
			else
				ESX.ShowNotification('Non sembrano esserci ~b~slot liberi ~w~in questo veicolo.')
			end
		end
	else
		if CaricoInMano == '' and nelMule ~= 0 and not IsPedSittingInAnyVehicle(ped) then
			ESX.ShowNotification('Non hai un ~b~carico ~w~in mano da poter lasciare.')
			nelMule = 0 ExecuteCommand('e shrug')
		end
	end
	
	-- VENDITA Export
	if allaVendita --[[ and ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' ]] then
		--TriggerServerEvent('importexport:vendiExport', CaricoInMano, CaricoInManoQT)		
		local amount = 1 * CaricoInManoQT 
		if CaricoInMano == 'goldbar' then amount = 150 * CaricoInManoQT 
		elseif CaricoInMano == 'arancia' then amount = 5 * CaricoInManoQT 
		elseif CaricoInMano == 'ostrica' then amount = 50 * CaricoInManoQT 
		elseif CaricoInMano == 'tomato' then amount = 10 * CaricoInManoQT 
		elseif CaricoInMano == 'grano' then amount = 20 * CaricoInManoQT 
		elseif CaricoInMano == 'cozza' then amount = 25 * CaricoInManoQT 
		elseif CaricoInMano == 'carpamedia' then amount = 20 * CaricoInManoQT 
		elseif CaricoInMano == 'packaged_chicken' then amount = 30 * CaricoInManoQT 	
		elseif CaricoInMano == 'slaughtered_chicken' then amount = 20 * CaricoInManoQT
		elseif CaricoInMano == 'alive_chicken' then amount = 5 * CaricoInManoQT 					
		elseif CaricoInMano == 'carne' then amount = 20 * CaricoInManoQT 
		elseif CaricoInMano == 'carneconiglio' then amount = 10 * CaricoInManoQT 
		elseif CaricoInMano == 'carnevolatile' then amount = 35 * CaricoInManoQT 
		elseif CaricoInMano == 'pellicciacoyote' then amount = 40 * CaricoInManoQT 
		elseif CaricoInMano == 'pellicciaghepardo' then amount = 70 * CaricoInManoQT 
		elseif CaricoInMano == 'pellechinghiale' then amount = 35 * CaricoInManoQT 
		elseif CaricoInMano == 'milk' then amount = 10 * CaricoInManoQT 
		elseif CaricoInMano == 'tomato_juice' then amount = 20 * CaricoInManoQT 
		elseif CaricoInMano == 'succoarancia' then amount = 25 * CaricoInManoQT 
		elseif CaricoInMano == 'maderaf' then amount = 20 * CaricoInManoQT 
		elseif CaricoInMano == 'maderag' then amount = 10 * CaricoInManoQT 
		elseif CaricoInMano == 'madera' then amount = 3 * CaricoInManoQT 
		elseif CaricoInMano == 'farina' then amount = 10 * CaricoInManoQT 	
		elseif CaricoInMano == 'diamond' then amount = 100 * CaricoInManoQT 
		elseif CaricoInMano == 'emerald' then amount = 50 * CaricoInManoQT 
		elseif CaricoInMano == 'copper' then amount = 20 * CaricoInManoQT 
		elseif CaricoInMano == 'iron' then amount = 30 * CaricoInManoQT 
		elseif CaricoInMano == 'carbone' then amount = 5 * CaricoInManoQT 
		elseif CaricoInMano == 'steel' then amount = 80 * CaricoInManoQT 
		elseif CaricoInMano == 'water' then amount = 5 * CaricoInManoQT 		
		end
		amount = ESX.Math.Round(tonumber(amount))	
		
		if GetDistanceBetween(vector3(53.577, -2676.501, 5.009)) < 3.5 then 
			TriggerServerEvent('deruba:DammiSoldi', amount)
		else
			TriggerServerEvent('esx_society:addMoney', 'import', amount)	
		end
		
		ExecuteCommand('e c') 
		CaricoInMano = '' CaricoInManoQT = 0
		
		if GetDistanceBetween(vector3(53.577, -2676.501, 5.009)) < 3.5 then 
			local rand = math.random(1,9)
			if rand == 9 then 
				local pos = GetEntityCoords(ped)
				TriggerServerEvent("chekjobAnon", "Movimenti sospetti al porto di vendita illegale di prodotti.", pos)
				ESX.ShowNotification("Un lavoratore del porto ha ~r~segnalato~w~ la vendita illegale alla polizia.")
			else
				ESX.ShowNotification("Carico illegale venduto, nessuno ha notato niente nelle vicinanze.")
			end
		end
		
	end
	Wait(1000)
	possoVendere = true
end)

RegisterKey('keyboard', 'H', function()
    if nelMule ~= 0 and not IsPedRagdoll(PlayerPedId()) then
		local veh = nelMuleID
		if GetVehicleDoorAngleRatio(veh, 2) > 0.1 or GetVehicleDoorAngleRatio(veh, 3) > 0.1 or (GetVehicleDoorAngleRatio(veh, 5) > 0.1) then 
			local posVeh = GetEntityCoords(veh)
			--if GetDistanceBetween(vector3(posVeh.x, posVeh.y, posVeh.z-1.0)) < 3.5 then
			local x = GetEntityModel(veh)
			if x == GetHashKey('mule') then OpenCarico(nelMule, 11)
			elseif x == GetHashKey('speedo') or x == GetHashKey('bodhi2') or x == GetHashKey('slamvan') then OpenCarico(nelMule, 6)
			elseif x == GetHashKey('kamacho') then OpenCarico(nelMule, 5)
			elseif x == GetHashKey('rumpo') then OpenCarico(nelMule, 8)
			elseif x == GetHashKey('sandking') or x == GetHashKey('sandking2') then OpenCarico(nelMule, 7)
			elseif x == GetHashKey('mesa') or x == GetHashKey('regina') or x == GetHashKey('riata') or x == GetHashKey('moonbeam') then OpenCarico(nelMule, 2)
			elseif x == GetHashKey('contender') or x == GetHashKey('bobcatxl') or x == GetHashKey('ratloader2') or x == GetHashKey('youga2') then OpenCarico(nelMule, 4)
			elseif x == GetHashKey('rebel') or x == GetHashKey('rebel2') or x == GetHashKey('bison') or x == GetHashKey('kalahari') or x == GetHashKey('picador') then OpenCarico(nelMule, 3)
			elseif x == GetHashKey('minivan') or x == GetHashKey('ingot') or x == GetHashKey('mesa3') then OpenCarico(nelMule, 1)
			end
			-- mule speedo bodhi2 slamvan kamacho rumpo sandking sandking2 mesa regina riata moonbeam contender bobcatxl ratloader2 youga2 rebel rebel2 bison kalahari picador minivan ingot mesa3
			--end
		else
			local x = GetEntityModel(veh)
			if x == GetHashKey('dloader') or x == GetHashKey('suntrap') or x == GetHashKey('squalo') then OpenCarico(nelMule, 8)
			elseif x == GetHashKey('tug') then OpenCarico(nelMule, 11) 
			end
			--dloader suntrap squalo tug
		end
	end
end)

function GetNomeLabel(nome)
local finale = ''
if nome == 'alive_chicken' then finale = 'Pollo vivo'  
elseif nome == 'goldbar' then finale = 'Barre oro'
elseif nome == 'tomato' then finale = 'Pomodoro'  
elseif nome == 'packaged_chicken' then finale = 'Pollo vendibile'  
elseif nome == 'arancia' then finale = 'Arancia'
elseif nome == 'cash' then finale = 'Contanti' 
elseif nome == 'slaughtered_chicken' then finale = 'Pollo lavorato'
elseif nome == 'pizza' then finale = 'Pizza'
elseif nome == 'carne' then finale = 'Carne'
elseif nome == 'water' then finale = 'Acqua'
elseif nome == 'beer' then finale = 'Birra'
elseif nome == 'carneconiglio' then finale = 'Carne coniglio'
elseif nome == 'carnevolatile' then finale = 'Carne volatile'
elseif nome == 'pellicciacoyote' then finale = 'Pelliccia coyote'
elseif nome == 'pellicciaghepardo' then finale = 'Pelliccia ghepardo'
elseif nome == 'pellechinghiale' then finale = 'Pelle chinghiale'
elseif nome == 'milk' then finale = 'Latte'
elseif nome == 'tomato_juice' then finale = 'Sugo pomodoro'
elseif nome == 'succoarancia' then finale = 'Succo arancia'
elseif nome == 'maderaf' then finale = 'Legno fine'
elseif nome == 'maderag' then finale = 'Legno grande'
elseif nome == 'madera' then finale = 'Legno grezzo'
elseif nome == 'farina' then finale = 'Farina'
elseif nome == 'diamond' then finale = 'Diamante'
elseif nome == 'emerald' then finale = 'Smeraldo'
elseif nome == 'copper' then finale = 'Rame'
elseif nome == 'iron' then finale = 'Ferro'
elseif nome == 'steel' then finale = 'Acciaio'
elseif nome == 'carbone' then finale = 'Carbone'
elseif nome == 'WEAPON_PISTOL' then finale = 'Pistola'
elseif nome == 'mWEAPON_PISTOL' then finale = 'Munizioni Pistola'
elseif nome == 'WEAPON_MICROSMG' then finale = 'Micro SMG'
elseif nome == 'mWEAPON_MICROSMG' then finale = 'Munizioni Micro SMG'
elseif nome == 'WEAPON_PUMPSHOTGUN' then finale = 'Fucile a pompa'
elseif nome == 'mWEAPON_PUMPSHOTGUN' then finale = 'Munizioni Fucile a pompa'
else 
	finale = nome
end 
return finale
end

function OpenCarico(MULE, maxS)
	ESX.UI.Menu.CloseAll()		
	local elements = {}
	local plate = MULE
	if maxS == 11 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
		if CaricoVeicolo3[plate] == nil or CaricoVeicolo3[plate] == '' then table.insert(elements, {label = 'Slot 3: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 3: ' .. GetNomeLabel(CaricoVeicolo3[plate]) .. ' ' .. CaricoVeicoloQT3[plate], value = 'slot3'}) end
		if CaricoVeicolo4[plate] == nil or CaricoVeicolo4[plate] == '' then table.insert(elements, {label = 'Slot 4: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 4: ' .. GetNomeLabel(CaricoVeicolo4[plate]) .. ' ' .. CaricoVeicoloQT4[plate], value = 'slot4'}) end
		if CaricoVeicolo5[plate] == nil or CaricoVeicolo5[plate] == '' then table.insert(elements, {label = 'Slot 5: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 5: ' .. GetNomeLabel(CaricoVeicolo5[plate]) .. ' ' .. CaricoVeicoloQT5[plate], value = 'slot5'}) end
		if CaricoVeicolo6[plate] == nil or CaricoVeicolo6[plate] == '' then table.insert(elements, {label = 'Slot 6: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 6: ' .. GetNomeLabel(CaricoVeicolo6[plate]) .. ' ' .. CaricoVeicoloQT6[plate], value = 'slot6'}) end
		if CaricoVeicolo7[plate] == nil or CaricoVeicolo7[plate] == '' then table.insert(elements, {label = 'Slot 7: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 7: ' .. GetNomeLabel(CaricoVeicolo7[plate]) .. ' ' .. CaricoVeicoloQT7[plate], value = 'slot7'}) end
		if CaricoVeicolo8[plate] == nil or CaricoVeicolo8[plate] == '' then table.insert(elements, {label = 'Slot 8: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 8: ' .. GetNomeLabel(CaricoVeicolo8[plate]) .. ' ' .. CaricoVeicoloQT8[plate], value = 'slot8'}) end
		if CaricoVeicolo9[plate] == nil or CaricoVeicolo9[plate] == '' then table.insert(elements, {label = 'Slot 9: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 9: ' .. GetNomeLabel(CaricoVeicolo9[plate]) .. ' ' .. CaricoVeicoloQT9[plate], value = 'slot9'}) end
		if CaricoVeicolo10[plate] == nil or CaricoVeicolo10[plate] == '' then table.insert(elements, {label = 'Slot 10: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 10: ' .. GetNomeLabel(CaricoVeicolo10[plate]) .. ' ' .. CaricoVeicoloQT10[plate], value = 'slot10'}) end
		if CaricoVeicolo11[plate] == nil or CaricoVeicolo11[plate] == '' then table.insert(elements, {label = 'Slot 11: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 11: ' .. GetNomeLabel(CaricoVeicolo11[plate]) .. ' ' .. CaricoVeicoloQT11[plate], value = 'slot11'}) end
	elseif maxS == 8 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
		if CaricoVeicolo3[plate] == nil or CaricoVeicolo3[plate] == '' then table.insert(elements, {label = 'Slot 3: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 3: ' .. GetNomeLabel(CaricoVeicolo3[plate]) .. ' ' .. CaricoVeicoloQT3[plate], value = 'slot3'}) end
		if CaricoVeicolo4[plate] == nil or CaricoVeicolo4[plate] == '' then table.insert(elements, {label = 'Slot 4: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 4: ' .. GetNomeLabel(CaricoVeicolo4[plate]) .. ' ' .. CaricoVeicoloQT4[plate], value = 'slot4'}) end
		if CaricoVeicolo5[plate] == nil or CaricoVeicolo5[plate] == '' then table.insert(elements, {label = 'Slot 5: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 5: ' .. GetNomeLabel(CaricoVeicolo5[plate]) .. ' ' .. CaricoVeicoloQT5[plate], value = 'slot5'}) end
		if CaricoVeicolo6[plate] == nil or CaricoVeicolo6[plate] == '' then table.insert(elements, {label = 'Slot 6: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 6: ' .. GetNomeLabel(CaricoVeicolo6[plate]) .. ' ' .. CaricoVeicoloQT6[plate], value = 'slot6'}) end
		if CaricoVeicolo7[plate] == nil or CaricoVeicolo7[plate] == '' then table.insert(elements, {label = 'Slot 7: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 7: ' .. GetNomeLabel(CaricoVeicolo7[plate]) .. ' ' .. CaricoVeicoloQT7[plate], value = 'slot7'}) end
		if CaricoVeicolo8[plate] == nil or CaricoVeicolo8[plate] == '' then table.insert(elements, {label = 'Slot 8: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 8: ' .. GetNomeLabel(CaricoVeicolo8[plate]) .. ' ' .. CaricoVeicoloQT8[plate], value = 'slot8'}) end
	elseif maxS == 7 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
		if CaricoVeicolo3[plate] == nil or CaricoVeicolo3[plate] == '' then table.insert(elements, {label = 'Slot 3: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 3: ' .. GetNomeLabel(CaricoVeicolo3[plate]) .. ' ' .. CaricoVeicoloQT3[plate], value = 'slot3'}) end
		if CaricoVeicolo4[plate] == nil or CaricoVeicolo4[plate] == '' then table.insert(elements, {label = 'Slot 4: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 4: ' .. GetNomeLabel(CaricoVeicolo4[plate]) .. ' ' .. CaricoVeicoloQT4[plate], value = 'slot4'}) end
		if CaricoVeicolo5[plate] == nil or CaricoVeicolo5[plate] == '' then table.insert(elements, {label = 'Slot 5: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 5: ' .. GetNomeLabel(CaricoVeicolo5[plate]) .. ' ' .. CaricoVeicoloQT5[plate], value = 'slot5'}) end
		if CaricoVeicolo6[plate] == nil or CaricoVeicolo6[plate] == '' then table.insert(elements, {label = 'Slot 6: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 6: ' .. GetNomeLabel(CaricoVeicolo6[plate]) .. ' ' .. CaricoVeicoloQT6[plate], value = 'slot6'}) end
		if CaricoVeicolo7[plate] == nil or CaricoVeicolo7[plate] == '' then table.insert(elements, {label = 'Slot 7: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 7: ' .. GetNomeLabel(CaricoVeicolo7[plate]) .. ' ' .. CaricoVeicoloQT7[plate], value = 'slot7'}) end
	elseif maxS == 6 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
		if CaricoVeicolo3[plate] == nil or CaricoVeicolo3[plate] == '' then table.insert(elements, {label = 'Slot 3: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 3: ' .. GetNomeLabel(CaricoVeicolo3[plate]) .. ' ' .. CaricoVeicoloQT3[plate], value = 'slot3'}) end
		if CaricoVeicolo4[plate] == nil or CaricoVeicolo4[plate] == '' then table.insert(elements, {label = 'Slot 4: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 4: ' .. GetNomeLabel(CaricoVeicolo4[plate]) .. ' ' .. CaricoVeicoloQT4[plate], value = 'slot4'}) end
		if CaricoVeicolo5[plate] == nil or CaricoVeicolo5[plate] == '' then table.insert(elements, {label = 'Slot 5: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 5: ' .. GetNomeLabel(CaricoVeicolo5[plate]) .. ' ' .. CaricoVeicoloQT5[plate], value = 'slot5'}) end
		if CaricoVeicolo6[plate] == nil or CaricoVeicolo6[plate] == '' then table.insert(elements, {label = 'Slot 6: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 6: ' .. GetNomeLabel(CaricoVeicolo6[plate]) .. ' ' .. CaricoVeicoloQT6[plate], value = 'slot6'}) end
	elseif maxS == 5 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
		if CaricoVeicolo3[plate] == nil or CaricoVeicolo3[plate] == '' then table.insert(elements, {label = 'Slot 3: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 3: ' .. GetNomeLabel(CaricoVeicolo3[plate]) .. ' ' .. CaricoVeicoloQT3[plate], value = 'slot3'}) end
		if CaricoVeicolo4[plate] == nil or CaricoVeicolo4[plate] == '' then table.insert(elements, {label = 'Slot 4: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 4: ' .. GetNomeLabel(CaricoVeicolo4[plate]) .. ' ' .. CaricoVeicoloQT4[plate], value = 'slot4'}) end
		if CaricoVeicolo5[plate] == nil or CaricoVeicolo5[plate] == '' then table.insert(elements, {label = 'Slot 5: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 5: ' .. GetNomeLabel(CaricoVeicolo5[plate]) .. ' ' .. CaricoVeicoloQT5[plate], value = 'slot5'}) end
		if CaricoVeicolo6[plate] == nil or CaricoVeicolo6[plate] == '' then table.insert(elements, {label = 'Slot 6: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 6: ' .. GetNomeLabel(CaricoVeicolo6[plate]) .. ' ' .. CaricoVeicoloQT6[plate], value = 'slot6'}) end
	elseif maxS == 4 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
		if CaricoVeicolo3[plate] == nil or CaricoVeicolo3[plate] == '' then table.insert(elements, {label = 'Slot 3: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 3: ' .. GetNomeLabel(CaricoVeicolo3[plate]) .. ' ' .. CaricoVeicoloQT3[plate], value = 'slot3'}) end
		if CaricoVeicolo4[plate] == nil or CaricoVeicolo4[plate] == '' then table.insert(elements, {label = 'Slot 4: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 4: ' .. GetNomeLabel(CaricoVeicolo4[plate]) .. ' ' .. CaricoVeicoloQT4[plate], value = 'slot4'}) end
	elseif maxS == 3 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
		if CaricoVeicolo3[plate] == nil or CaricoVeicolo3[plate] == '' then table.insert(elements, {label = 'Slot 3: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 3: ' .. GetNomeLabel(CaricoVeicolo3[plate]) .. ' ' .. CaricoVeicoloQT3[plate], value = 'slot3'}) end
	elseif maxS == 2 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
		if CaricoVeicolo2[plate] == nil or CaricoVeicolo2[plate] == '' then table.insert(elements, {label = 'Slot 2: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 2: ' .. GetNomeLabel(CaricoVeicolo2[plate]) .. ' ' .. CaricoVeicoloQT2[plate], value = 'slot2'}) end
	elseif maxS == 1 then -- (E solo numero di scatole)
		if CaricoVeicolo[plate] == nil or CaricoVeicolo[plate] == '' then table.insert(elements, {label = 'Slot 1: Vuoto', value = 'vuoto'}) else table.insert(elements, {label = 'Slot 1: ' .. GetNomeLabel(CaricoVeicolo[plate]) .. ' ' .. CaricoVeicoloQT[plate], value = 'slot1'}) end
	end
	
	ExecuteCommand('e think4')
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_carico',
		{
			title    = 'Carico - Targa: ' .. plate,
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
	
	if data.current.value == 'vuoto' then menu.close() end
	
	if data.current.value == 'slot1' then CaricoInMano = CaricoVeicolo[plate] CaricoInManoQT = CaricoVeicoloQT[plate] CaricoVeicolo[plate] = '' CaricoVeicoloQT[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot2' then CaricoInMano = CaricoVeicolo2[plate] CaricoInManoQT = CaricoVeicoloQT2[plate] CaricoVeicolo2[plate] = '' CaricoVeicoloQT2[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico2', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot3' then CaricoInMano = CaricoVeicolo3[plate] CaricoInManoQT = CaricoVeicoloQT3[plate] CaricoVeicolo3[plate] = '' CaricoVeicoloQT3[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico3', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot4' then CaricoInMano = CaricoVeicolo4[plate] CaricoInManoQT = CaricoVeicoloQT4[plate] CaricoVeicolo4[plate] = '' CaricoVeicoloQT4[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico4', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot5' then CaricoInMano = CaricoVeicolo5[plate] CaricoInManoQT = CaricoVeicoloQT5[plate] CaricoVeicolo5[plate] = '' CaricoVeicoloQT5[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico5', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot6' then CaricoInMano = CaricoVeicolo6[plate] CaricoInManoQT = CaricoVeicoloQT6[plate] CaricoVeicolo6[plate] = '' CaricoVeicoloQT6[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico6', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot7' then CaricoInMano = CaricoVeicolo7[plate] CaricoInManoQT = CaricoVeicoloQT7[plate] CaricoVeicolo7[plate] = '' CaricoVeicoloQT7[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico7', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot8' then CaricoInMano = CaricoVeicolo8[plate] CaricoInManoQT = CaricoVeicoloQT8[plate] CaricoVeicolo8[plate] = '' CaricoVeicoloQT8[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico8', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot9' then CaricoInMano = CaricoVeicolo9[plate] CaricoInManoQT = CaricoVeicoloQT9[plate] CaricoVeicolo9[plate] = '' CaricoVeicoloQT9[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico9', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot10' then CaricoInMano = CaricoVeicolo10[plate] CaricoInManoQT = CaricoVeicoloQT10[plate] CaricoVeicolo10[plate] = '' CaricoVeicoloQT10[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico10', plate, '', 0) menu.close() 
	elseif data.current.value == 'slot11' then CaricoInMano = CaricoVeicolo11[plate] CaricoInManoQT = CaricoVeicoloQT11[plate] CaricoVeicolo11[plate] = '' CaricoVeicoloQT11[plate] = 0 TriggerServerEvent('esx_importexport:AggiornaCarico11', plate, '', 0) menu.close() 
	end
								
		end,
		function(data, menu)
			menu.close()
			ExecuteCommand('e c')
		end
	)	
end

--[[1]] RegisterNetEvent('esx_importexport:AggiornaCarico') AddEventHandler('esx_importexport:AggiornaCarico', function(plate, nome, qt) CaricoVeicolo[plate] = nome CaricoVeicoloQT[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico') AddEventHandler('esx_importexport:getCarico', function(nome, qt) CaricoVeicolo = nome CaricoVeicoloQT = qt end)
--[[2]] RegisterNetEvent('esx_importexport:AggiornaCarico2') AddEventHandler('esx_importexport:AggiornaCarico2', function(plate, nome, qt) CaricoVeicolo2[plate] = nome CaricoVeicoloQT2[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico2') AddEventHandler('esx_importexport:getCarico2', function(nome, qt) CaricoVeicolo2 = nome CaricoVeicoloQT2 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico3') AddEventHandler('esx_importexport:AggiornaCarico3', function(plate, nome, qt) CaricoVeicolo3[plate] = nome CaricoVeicoloQT3[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico3') AddEventHandler('esx_importexport:getCarico3', function(nome, qt) CaricoVeicolo3 = nome CaricoVeicoloQT3 = qt end)
--[[4]] RegisterNetEvent('esx_importexport:AggiornaCarico4') AddEventHandler('esx_importexport:AggiornaCarico4', function(plate, nome, qt) CaricoVeicolo4[plate] = nome CaricoVeicoloQT4[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico4') AddEventHandler('esx_importexport:getCarico4', function(nome, qt) CaricoVeicolo4 = nome CaricoVeicoloQT4 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico5') AddEventHandler('esx_importexport:AggiornaCarico5', function(plate, nome, qt) CaricoVeicolo5[plate] = nome CaricoVeicoloQT5[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico5') AddEventHandler('esx_importexport:getCarico5', function(nome, qt) CaricoVeicolo5 = nome CaricoVeicoloQT5 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico6') AddEventHandler('esx_importexport:AggiornaCarico6', function(plate, nome, qt) CaricoVeicolo6[plate] = nome CaricoVeicoloQT6[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico6') AddEventHandler('esx_importexport:getCarico6', function(nome, qt) CaricoVeicolo6 = nome CaricoVeicoloQT6 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico7') AddEventHandler('esx_importexport:AggiornaCarico7', function(plate, nome, qt) CaricoVeicolo7[plate] = nome CaricoVeicoloQT7[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico7') AddEventHandler('esx_importexport:getCarico7', function(nome, qt) CaricoVeicolo7 = nome CaricoVeicoloQT7 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico8') AddEventHandler('esx_importexport:AggiornaCarico8', function(plate, nome, qt) CaricoVeicolo8[plate] = nome CaricoVeicoloQT8[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico8') AddEventHandler('esx_importexport:getCarico8', function(nome, qt) CaricoVeicolo8 = nome CaricoVeicoloQT8 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico9') AddEventHandler('esx_importexport:AggiornaCarico9', function(plate, nome, qt) CaricoVeicolo9[plate] = nome CaricoVeicoloQT9[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico9') AddEventHandler('esx_importexport:getCarico9', function(nome, qt) CaricoVeicolo9 = nome CaricoVeicoloQT9 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico10') AddEventHandler('esx_importexport:AggiornaCarico10', function(plate, nome, qt) CaricoVeicolo10[plate] = nome CaricoVeicoloQT10[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico10') AddEventHandler('esx_importexport:getCarico10', function(nome, qt) CaricoVeicolo10 = nome CaricoVeicoloQT10 = qt end)
--[[3]] RegisterNetEvent('esx_importexport:AggiornaCarico11') AddEventHandler('esx_importexport:AggiornaCarico11', function(plate, nome, qt) CaricoVeicolo11[plate] = nome CaricoVeicoloQT11[plate] = qt end)
RegisterNetEvent('esx_importexport:getCarico11') AddEventHandler('esx_importexport:getCarico11', function(nome, qt) CaricoVeicolo11 = nome CaricoVeicoloQT11 = qt end)

--[[
RegisterCommand('getdoor', function()
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	print(GetVehicleDoorAngleRatio(veh, 2))
	print(GetVehicleDoorAngleRatio(veh, 3))
end, false)
]]

function DammiCarico(nome, qt)
	CaricoInMano = nome
	CaricoInManoQT = qt
end

RegisterNetEvent('esx_importexport:DammiCarico')
AddEventHandler('esx_importexport:DammiCarico', function(nome, qt)
	DammiCarico(nome, qt)
end)

--[[
-- SALVARE INFO SUL FILE
local loadFile= LoadResourceFile(GetCurrentResourceName(), "./import.json")
local information = {name = "w00pi the legend", age = 17, coolness = 1000}
SaveResourceFile(GetCurrentResourceName(), "import.json", json.encode(information), -1)

-- OTTENERE INFO DAL FILE
local loadFile= LoadResourceFile(GetCurrentResourceName(), "./import.json") 
local extract = {}
extract = json.decode(loadFile)
SaveResourceFile(GetCurrentResourceName(), "import.json", json.encode(extract), -1)
]]

function OpenImportEstero()
	ESX.UI.Menu.CloseAll()		
	local elements = {}
	
	TriggerServerEvent('esx_importexport:caricaingrosso')
	
	ESX.TriggerServerCallback('esx_importexport:getingrosso', function(ret)
		IngrossoImport = ret
	end)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(500)
	ExecuteCommand('e tablet')
	for k, v in pairs(IngrossoImport) do
	
		local nomeoggetto = GetNomeLabel(v.name)
		if nomeoggetto == '' then nomeoggetto = v.name end
	
		table.insert(elements, {label = nomeoggetto .. ' (' .. v.qt ..')', value = k})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_carico',
		{
			title    = 'Ingrosso Import',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
	
		local k = data.current.value 	
		CaricoInMano = IngrossoImport[k].name CaricoInManoQT = IngrossoImport[k].qt 	
		TriggerServerEvent('esx_importexport:elimina', k)
		
		menu.close() 
		FreezeEntityPosition(PlayerPedId(), false)
		ExecuteCommand('e c')
									
		end,
		function(data, menu)
			menu.close()
			ExecuteCommand('e c')
			FreezeEntityPosition(PlayerPedId(), false)
		end
	)	
end

--[[]]

-- VENDITA MARIA / VENDITA DROGA
local inVendita = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		-- VENDITA MARIA MATTINA	
		if not inVendita and GetDistanceBetween(vector3(1902.363, 597.371, 177.496)) < 2.5 then
			--DrawMarker(23, 1902.363, 597.371, 177.496+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(1902.363, 597.371, 177.496)) <= 2.5 then
				local hour = GetClockHours()
				if hour >= 0 and hour <= 13 then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~g~Carico Marijuana")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'erba20g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 110 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 110)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~g~Marijuana 20g ~w~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end				
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		-- VENDITA MARIA POMERIGGIO
		elseif not inVendita and GetDistanceBetween(vector3(1074.948, -2438.902, 29.602)) < 2.5 then
			--DrawMarker(23, 1074.948, -2438.902, 29.602+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(1074.948, -2438.902, 29.602)) <= 2.5 then
				local hour = GetClockHours()
				if hour > 13 and hour <= 19 then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~g~Carico Marijuana")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'erba20g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 150 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 150)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~g~Marijuana 20g ~w~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		-- VENDITA MARIA SERALE 
		elseif not inVendita and (GetDistanceBetween(vector3(-2166.371, 5197.372, 15.88)) < 2.5 or GetDistanceBetween(vector3(888.019, -953.674, 38.231)) < 2.5) then
			--DrawMarker(23, -2166.371, 5197.372, 15.88+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(-2166.371, 5197.372, 15.88)) <= 2.5 or GetDistanceBetween(vector3(888.019, -953.674, 38.231)) <= 2.5 then
				local hour = GetClockHours()
				local minute = GetClockMinutes()
				if (hour > 19 and hour <= 23 and minute < 59) then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~g~Carico Marijuana")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'erba20g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 200 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 200)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~g~Marijuana 20g ~w~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end				
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

--[[ ]]

-- VENDITA METH / VENDITA DROGA
local inVendita = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		-- VENDITA METH MATTINA	
		if not inVendita and GetDistanceBetween(vector3(1583.398, 2908.469, 55.949)) < 2.5 then
			--DrawMarker(23, 1902.363, 597.371, 177.496+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(1583.398, 2908.469, 55.949)) <= 2.5 then
				local hour = GetClockHours()
				if hour >= 0 and hour <= 13 then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~b~Carico Meth")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'meth10g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 180 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 180)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~b~Meth 10g ~w~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end				
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		-- VENDITA METH POMERIGGIO
		elseif not inVendita and GetDistanceBetween(vector3(742.157, 4169.83, 40.105)) < 2.5 then
			--DrawMarker(23, 1074.948, -2438.902, 29.602+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(742.157, 4169.83, 40.105)) <= 2.5 then
				local hour = GetClockHours()
				if hour > 13 and hour <= 19 then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~b~Carico Meth")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'meth10g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 150 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 150)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~b~Meth 10g ~w~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		-- VENDITA METH SERALE 
		elseif not inVendita and (GetDistanceBetween(vector3(-1948.13, 4471.063, 27.33)) < 2.5 or GetDistanceBetween(vector3(3561.151, 2566.271, 3.04)) < 2.5) then
			--DrawMarker(23, -2166.371, 5197.372, 15.88+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(-1948.13, 4471.063, 27.33)) <= 2.5 or GetDistanceBetween(vector3(3561.151, 2566.271, 3.04)) <= 2.5 then
				local hour = GetClockHours()
				local minute = GetClockMinutes()
				if (hour > 19 and hour <= 23 and minute < 59) then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~b~Carico Meth")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'meth10g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 220 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 220)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~b~Meth 10g ~w~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end				
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

--[[]]

--VENDITA COCA
local inVendita = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		-- VENDITA COCA MATTINA	
		if not inVendita and GetDistanceBetween(vector3(1227.357, -2907.464, 8.319)) < 2.5 then
			--DrawMarker(23, 1902.363, 597.371, 177.496+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(1227.357, -2907.464, 8.319)) <= 2.5 then
				local hour = GetClockHours()
				if hour >= 0 and hour <= 13 then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~h~Carico Cocaina")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'coca20' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 210 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 210)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~h~Cocaina 20g ~h~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end				
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		-- VENDITA COCA POMERIGGIO
		elseif not inVendita and GetDistanceBetween(vector3(1445.066, 6332.98, 24.341)) < 2.5 then
			--DrawMarker(23, 1074.948, -2438.902, 29.602+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(1445.066, 6332.98, 24.341)) <= 2.5 then
				local hour = GetClockHours()
				if hour > 13 and hour <= 19 then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~h~Carico Cocaina")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'meth10g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 170 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 170)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~h~Cocaina 20g ~h~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		-- VENDITA COCA SERALE 
		elseif not inVendita and (GetDistanceBetween(vector3(32.681, 3672.219, 39.838)) < 2.5 or GetDistanceBetween(vector3(1664.421, 5.532, 165.118)) < 2.5) then
			--DrawMarker(23, -2166.371, 5197.372, 15.88+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 50, false, true, 2, false, false, false, false)
			if GetDistanceBetween(vector3(32.681, 3672.219, 39.838)) <= 2.5 or GetDistanceBetween(vector3(1664.421, 5.532, 165.118)) <= 2.5 then
				local hour = GetClockHours()
				local minute = GetClockMinutes()
				if (hour > 19 and hour <= 23 and minute < 59) then	
					local ped = PlayerPedId()
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~h~Carico Cocaina")
					if IsControlJustReleased(0, 74) then					
						if CaricoInMano == 'meth10g' and CaricoInMano ~= nil then
							inVendita = true
							ESX.ShowNotification("Operazione in corso, attendere prego.")
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e clipboard')
							Wait(10000)
							ExecuteCommand('e kneel2')
							ExecuteCommand('e mechanic4')
							ESX.ShowNotification("Operazione quasi completata, attendere prego.")
							Wait(10000)
							ExecuteCommand('e c')
							ESX.ShowNotification("Hai venduto ~g~x" .. CaricoInManoQT .. " ~w~guadagnando " .. CaricoInManoQT * 270 .. "~g~$~w~.")
							TriggerServerEvent('deruba:DammiSoldi', CaricoInManoQT * 270)
							CaricoInManoQT = 0
							CaricoInMano = ''
							Wait(1000)
							FreezeEntityPosition(ped, false)
							inVendita = false
						else
							ESX.ShowNotification("Hai bisogno di un carico con dentro ~h~Cocaina 20g ~h~per vendere.")
							ExecuteCommand('e shrug')
						end				
					end				
				else
					ESX.ShowHelpNotification("Non sembra esserci niente a quest'ora.")
				end
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

--[[]]

-- VENDITA IMPORT AUTOMATICA
local messaggioVendita = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		--if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
			local ped = PlayerPedId()
			if GetDistanceBetween(vector3(-455.602, -2807.503, 5.0)) < 15.0 then
				DrawMarker(23, vector3(-455.602, -2807.503, 5.0+0.01), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5,0.5, 255, 255, 255, 100, false, true, 2, false, nil, nil, false)		
				if GetDistanceBetween(vector3(-455.602, -2807.503, 5.0)) < 2.5 then
					local prezzo = 0
					if CaricoInMano ~= '' and CaricoInMano ~= nil then
						-- Lista Items
						if CaricoInMano == 'alive_chicken' then prezzo = 10 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1') 
						elseif CaricoInMano == 'packaged_chicken' then prezzo = 35 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'carne' then prezzo = 20 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'carneconiglio' then prezzo = 15 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'carnevolatile' then prezzo = 35 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'pellicciacoyote' then prezzo = 55 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'pellicciaghepardo' then prezzo = 200 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'pellechinghiale' then prezzo = 125 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'tomato' then prezzo = 5 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'tomato_juice' then prezzo = 15 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'arancia' then prezzo = 5 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'succotomato' then prezzo = 15 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'maderag' then prezzo = 25 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'maderaf' then prezzo = 8 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'madera' then prezzo = 3 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'farina' then prezzo = 15 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'grano' then prezzo = 5 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'diamond' then prezzo = 250 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'emerald' then prezzo = 70 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'copper' then prezzo = 35 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'iron' then prezzo = 15 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'steel' then prezzo = 55 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')
						elseif CaricoInMano == 'milk' then prezzo = 15 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')	
						elseif CaricoInMano == 'beer' then prezzo = 5 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1')							
						else prezzo = 1 ESX.ShowHelpNotification('~INPUT_PICKUP~ Vendi il carico ' .. prezzo ..'~g~$ ~w~x1') end
					else
						if not messaggioVendita then 
							if not IsPedSittingInAnyVehicle(ped, false) then
								messaggioVendita = true ESX.ShowHelpNotification('Non hai un carico in mano da poter vendere.') 
							end	
						end
					end					
					if IsControlPressed(0, 38) and CaricoInMano ~= '' and CaricoInMano ~= nil and not IsPedSittingInAnyVehicle(ped, false) then						
						TriggerServerEvent('esx_importexport:add', CaricoInMano, CaricoInManoQT, prezzo)
						CaricoInMano = '' CaricoInManoQT = 0
						ESX.ShowHelpNotification('Carico ~b~venduto ~w~con successo.')
						ExecuteCommand('e portapacchiv')
						Citizen.Wait(3000)
					end
				else
					if messaggioVendita then messaggioVendita = false end
				end
			else
				Citizen.Wait(1000)
			end			
		--end
	end
end)

-- ESTERO CON PC UFFICIO
--[[
RegisterCommand('estero', function()
	if CaricoInMano ~= '' or CaricoInManoQT == nil then ESX.ShowHelpNotification('Operazione bloccata quando hai un carico in mano.') return end
	if GetDistanceBetween(vector3(1206.774, -3157.066, 4.528)) > 1.5 then ESX.ShowHelpNotification('Sei troppo distante da: ~b~Ufficio Estero') return end
	local ped = PlayerPedId()
	--if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
		SetEntityCoords(ped, 1206.774, -3157.066, 4.528)
		SetEntityHeading(ped, 182.827)
		OpenImportEstero()
	--end
end, false)
]]

RegisterCommand('estero', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'import' then ESX.ShowNotification('Non sei autorizzato a questa operazione.') return end
	if CaricoInMano ~= '' or CaricoInManoQT == nil then ESX.ShowHelpNotification('Operazione bloccata quando hai un carico in mano.') return end
	if GetDistanceBetween(vector3(-455.602, -2807.503, 5.0)) > 100.0 then ESX.ShowHelpNotification('Sei troppo distante da: ~b~Ingrosso Estero~w~, mappa aggiornata.') SetNewWaypoint(-455.602, -2807.503, 5.0) return end
	local ped = PlayerPedId()
	--if ESX.PlayerData.job and ESX.PlayerData.job.name == 'import' then
		--SetEntityCoords(ped, 1206.774, -3157.066, 4.528)
		--SetEntityHeading(ped, 182.827)
		--ExecuteCommand('e type4')
		OpenImportEstero()
	--end
end, false)

--[[]]

--[[
-- FUNZIONAVA MA MEGLIO I LOG DISCORD
RegisterCommand('storicoammu', function()
	local blocca = false
	local xPlayer = ESX.GetPlayerData()
	if xPlayer.job == nil then ESX.ShowNotification('Lavoro non rilevato, per favore contatta uno staffer.') return end
	if xPlayer.job.name ~= 'ammu' and xPlayer.job.grade < 3 then blocca = true end
	if xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'ammu' then blocca = true end
	if xPlayer.job.name == 'police' then blocca = false end
	if xPlayer.job.name == 'ammu' and xPlayer.job.grade > 2 then blocca = false end
	if blocca then 
		ESX.ShowNotification('Non sei autorizzato a questa operazione.') 
		ExecuteCommand('e no2')
	return end
	if GetDistanceBetween(vector3(-1284.3, -3419.728, 13.94)) > 50.0 then ESX.ShowHelpNotification('Sei troppo distante da: ~b~Container Aereoporto~w~, mappa aggiornata.') SetNewWaypoint(-1284.3, -3419.728, 13.94) return end
	OpenStoricoAmmu()
end, false)

function OpenStoricoAmmu()
	ESX.UI.Menu.CloseAll()		
	local elements = {}
	
	TriggerServerEvent('esx_importexport:caricaingrossoammu') 
	
	ESX.TriggerServerCallback('esx_importexport:getingrossoammu', function(ret)
		StoricoAmmunation = ret
	end)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(500)
	ExecuteCommand('e clipboard')
	for k, v in pairs(StoricoAmmunation) do
	
		local nomeoggetto = GetNomeLabel(v.name)
		if nomeoggetto == '' then nomeoggetto = v.name end	
		table.insert(elements, {label = nomeoggetto .. ' (' .. v.qt ..')', value = k})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_carico',
		{
			title    = 'Storico Spedizioni Armeria',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
		
		menu.close() 
		FreezeEntityPosition(PlayerPedId(), false)
		ExecuteCommand('e c')
									
		end,
		function(data, menu)
			menu.close()
			ExecuteCommand('e c')
			FreezeEntityPosition(PlayerPedId(), false)
		end
	)	
end
]]


--[[
function OpenCapoEstero()
	ESX.UI.Menu.CloseAll()		
	local elements = {}
	local ped = PlayerPedId()
	
	table.insert(elements, {label = 'Materie Prime',		value = 'prima'})	
	table.insert(elements, {label = 'Prodotti Finiti',		value = 'finiti'})
	table.insert(elements, {label = 'Legno / Minerali',		value = 'altro'})	
	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menuestero',
		{
			title    = 'Gestione Estero',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
		
		-- APRO MENU PER VEICOLI
		if data.current.value == 'prima' then 
			local elements = {}			
			table.insert(elements, {label = 'Gestione chiavi veicoli',		value = 'menuperso_lock1'})
			table.insert(elements, {label = '📌 Indietro',		value = 'indietro'})	
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'menu_perso',
				{
					title    = 'Menu Veicoli',
					align    = 'top-left',
					elements = elements
				},
				function(data, menu)
			
			if data.current.value == 'mieiveicoli' then ExecuteCommand('mieiveicoli') menu.close() end	
			if data.current.value == 'indietro' then OpenPersonnelMenu() end
									
				end,
				function(data, menu)
					menu.close()
				end
			)
		end	

		-- APRO MENU ALTRO
		if data.current.value == 'altro' then 
			local elements = {}			
			table.insert(elements, {label = 'Gestione Borsone',		value = 'borsone'})	
			table.insert(elements, {label = '📌 Indietro',		value = 'indietro'})	
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'menu_perso',
				{
					title    = 'ALTRO...',
					align    = 'top-left',
					elements = elements
				},
				function(data, menu)
			
			if data.current.value == 'borsone' then ExecuteCommand('bag') menu.close() end	
			if data.current.value == 'indietro' then OpenPersonnelMenu() end
									
				end,
				function(data, menu)
					menu.close()
				end
			)
		end		
	
	--if data.current.value == 'fatture' then ExecuteCommand('fatture') menu.close() end
							
		end,
		function(data, menu)
			menu.close()
		end
	)	
end
]]
