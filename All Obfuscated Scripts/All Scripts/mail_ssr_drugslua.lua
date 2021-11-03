--[[
	id: FleyBYM_EDf7mb7hi0ZXD
	name: mail_ssr_drugs.lua
	description: asd
	time1: 2021-06-27 23:13:40.894314+00
	time2: 2021-06-27 23:13:40.894314+00
	uploader: 9D26QYAXY-_KkpZ_WxiDk_5EAkt05vWY7Nrua9im
	uploadersession: F_LNUIWFcWnqZAzNEkB2-YOIrDEeDw
	flag: f
--]]

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

function OpenBuyLicenseMenu(licenseName)
	menuOpen = true
	local license = Config.LicensePrices[licenseName]

	local elements = {
		{
			label = _U('license_no'),
			value = 'no'
		},

		{
			label = ('%s - <span style="color:green;">%s</span>'):format(license.label, _U('dealer_item', ESX.Math.GroupDigits(license.price))),
			value = licenseName,
			price = license.price,
			licenseName = license.label
		}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_shop', {
		title    = _U('license_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value ~= 'no' then
			ESX.TriggerServerCallback('esx_illegal:buyLicense', function(boughtLicense)
				if boughtLicense then
					ESX.ShowNotification(_U('license_bought', data.current.licenseName, ESX.Math.GroupDigits(data.current.price)))
				else
					ESX.ShowNotification(_U('license_bought_fail', data.current.licenseName))
				end
			end, data.current.value)
		else
			menu.close()
		end

	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

local openCraftMenu = false

RegisterNetEvent('esx_drugs:openDrugMakingMenu')
AddEventHandler('esx_drugs:openDrugMakingMenu', function(inventory)
	local elements = 
	{
		{ label = "Марихуана", value = 'makeMariuana'},
		{ label = "Кока", value = 'makeCoke'},
		{ label = "Хероин", value = 'makeHeroin'},
		{ label = "Амфети", value = 'makeMeth'},
		{ label = "LSD", value = 'makeLsd'},
		{ label = "Преработка на химикали", value = 'changeChems'},
	}

	-- Making sure that there is no open menus:
	ESX.UI.Menu.CloseAll()

	-- Menu:
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'drug_making_menu',
		{
			title	 = 'Преработка на наркотици',
			align	 = 'bottom-right',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'makeMariuana' then
				for i=1, #inventory, 1 do
					if inventory[i].name == "cannabis" then
						if inventory[i].count >= 1 then
							TriggerServerEvent('esx_drugs:addItemToPlayer', 'marijuana')
						else
							ESX.ShowNotification('Трябват ти ~g~(1) Канабис~s~', false, true, 140)
						end
					end
				end
			openCraftMenu = false
			elseif data.current.value == 'makeCoke' then
				for i=1, #inventory, 1 do
					if inventory[i].name == "coca_leaf" then
						if inventory[i].count >= 1 then
							TriggerServerEvent('esx_drugs:addItemToPlayer', 'coke')
						else
							ESX.ShowNotification('Трябват ти ~g~(1) Листа от Кока~s~', false, true, 140)
						end
					end
				end
			openCraftMenu = false
			elseif data.current.value == 'makeHeroin' then
				for i=1, #inventory, 1 do
					if inventory[i].name == "poppyresin" then
						if inventory[i].count >= 1 then
							TriggerServerEvent('esx_drugs:addItemToPlayer', 'heroin')
						else
							ESX.ShowNotification('Трябват ти ~g~(1) Маков Латекс~s~', false, true, 140)
						end
					end
				end
			openCraftMenu = false
			elseif data.current.value == 'makeMeth' then
				local HA = 0
				local SA = 0
				local SH = 0

				for i=1, #inventory, 1 do
					if inventory[i].name == "sodium_hydroxide" then
						SH = inventory[i].count
					elseif inventory[i].name == "sulfuric_acid" then
						SA = inventory[i].count
					elseif inventory[i].name == "hydrochloric_acid" then
						HA = inventory[i].count
					end
				end

				if HA > 0 and SA > 0 and SH > 0 then
					TriggerServerEvent('esx_drugs:addItemToPlayer', 'meth')
				else
					ESX.ShowNotification('Трябват ти ~g~(1) Солна Киселина~s~ ~g~(1) Сярна Киселина~s~ ~g~(1) Натриев Хидроксид~s~', false, true, 140)
				end
			openCraftMenu = false
			elseif data.current.value == 'makeLsd' then
				local LSA = 0
				local TH = 0

				for i=1, #inventory, 1 do
					if inventory[i].name == "lsa" then
						LSA = inventory[i].count
					elseif inventory[i].name == "thionyl_chloride" then
						TH = inventory[i].count
					end
				end

				if LSA > 0 and TH > 0 then
					TriggerServerEvent('esx_drugs:addItemToPlayer', 'lsd')
				else
					ESX.ShowNotification('Трябват ти ~g~(1) LSA~s~ ~g~(1) Тинол Хлорид~s~', false, true, 140)
				end
			openCraftMenu = false
			elseif data.current.value == 'changeChems' then
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'chem_menu',
					{
						title	 = 'Преработка на химикали',
						align	 = 'bottom-right',
						elements = {
							{ label = "LSA", value = 'makeLSA'},
							{ label = "Солна Киселина", value = 'makeHA'},
							{ label = "Сярна Киселина", value = 'makeSA'},
							{ label = "Натриев Хидроксид", value = 'makeSH'},
							{ label = "Тинол Хлорид", value = 'makeTH'},
						}
					},
					function(data, menu)
						if data.current.value == 'makeLSA' then
							for i=1, #inventory, 1 do
								if inventory[i].name == "chemicals" then
									if inventory[i].count >= 1 then
										TriggerServerEvent('esx_drugs:addItemToPlayer', 'lsa')
									else
										ESX.ShowNotification('Трябват ти ~g~(1) Химикали~s~', false, true, 140)
									end
								end
							end
						elseif data.current.value == 'makeHA' then
							for i=1, #inventory, 1 do
								if inventory[i].name == "chemicals" then
									if inventory[i].count >= 1 then
										TriggerServerEvent('esx_drugs:addItemToPlayer', 'hydrochloric_acid')
									else
										ESX.ShowNotification('Трябват ти ~g~(1) Химикали~s~', false, true, 140)
									end
								end
							end
						elseif data.current.value == 'makeSA' then
							for i=1, #inventory, 1 do
								if inventory[i].name == "chemicals" then
									if inventory[i].count >= 1 then
										TriggerServerEvent('esx_drugs:addItemToPlayer', 'sulfuric_acid')
									else
										ESX.ShowNotification('Трябват ти ~g~(1) Химикали~s~', false, true, 140)
									end
								end
							end
						elseif data.current.value == 'makeSH' then
							for i=1, #inventory, 1 do
								if inventory[i].name == "chemicals" then
									if inventory[i].count >= 1 then
										TriggerServerEvent('esx_drugs:addItemToPlayer', 'sodium_hydroxide')
									else
										ESX.ShowNotification('Трябват ти ~g~(1) Химикали~s~', false, true, 140)
									end
								end
							end
						elseif data.current.value == 'makeTH' then
							for i=1, #inventory, 1 do
								if inventory[i].name == "chemicals" then
									if inventory[i].count >= 1 then
										TriggerServerEvent('esx_drugs:addItemToPlayer', 'thionyl_chloride')
									else
										ESX.ShowNotification('Трябват ти ~g~(1) Химикали~s~', false, true, 140)
									end
								end
							end
						end
						menu.close()
						openCraftMenu = false
					end,
					function(data, menu)
						menu.close()
						openCraftMenu = false
					end)
			end
			menu.close()
		end
		, function(data, menu)
			menu.close()
			openCraftMenu = false
		end)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.Crafting.coords, true) < 0.50 or GetDistanceBetweenCoords(coords, vector3(2433.29, 4968.61, 42.34), true) < 0.5 then
			if not openCraftMenu then
				ESX.ShowHelpNotification('Натисни ~INPUT_CONTEXT~ за да започнеш ~b~преработката~s~.')

				if IsControlJustReleased(0, Keys['E']) then
					openCraftMenu = true
					TriggerServerEvent('esx_drugs:prepareMenu')
				end
			else
				Citizen.Wait(0)
			end
		else
			if openCraftMenu then
				openCraftMenu = false
				ESX.UI.Menu.CloseAll()
			end
			Citizen.Wait(0)
		end
	end
end)