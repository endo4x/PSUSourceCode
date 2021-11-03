--[[
	id: 39PX3OyMmTj4XjCGgIeCj
	name: moneywash_obf
	description: asd
	time1: 2021-06-27 23:14:49.801688+00
	time2: 2021-06-27 23:14:49.801688+00
	uploader: 9D26QYAXY-_KkpZ_WxiDk_5EAkt05vWY7Nrua9im
	uploadersession: F_LNUIWFcWnqZAzNEkB2-YOIrDEeDw
	flag: f
--]]

-- local menuOpen = false
-- local wasOpen = false

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)

-- 		if GetDistanceBetweenCoords(coords, Config.CircleZones.MoneyWash.coords, true) < 5 then
-- 			if not menuOpen then
-- 				ESX.ShowHelpNotification(_U('moneywash_prompt'))

-- 				if IsControlJustReleased(0, Keys['E']) then
-- 					if Config.MoneyWashLicenseEnabled then
-- 						CheckMoneyWashLicense()
-- 					else
-- 						wasOpen = true
-- 						OpenMoneyWash()
-- 					end
-- 				end
-- 			else
-- 				Citizen.Wait(500)
-- 			end
-- 		--[[else
-- 			if wasOpen then
-- 				wasOpen = false
-- 				ESX.UI.Menu.CloseAll()
-- 			end

-- 			Citizen.Wait(500)--]]
-- 		end
-- 	end
-- end)

-- function CheckMoneyWashLicense()

-- 	ESX.TriggerServerCallback('esx_illegal:CheckMoneyWashLicense', function(cb)
-- 		if cb then
-- 			wasOpen = true
-- 			OpenMoneyWash()
-- 		else
-- 			ESX.ShowNotification(_U('need_license'))
-- 		end
-- 	end)
-- end

-- function OpenMoneyWash()
-- 	ESX.UI.Menu.CloseAll()
-- 	local elements = {
-- 		{label = _U('moneywash_wash'), value = 'moneywash_wash'}
-- 	}
-- 	menuOpen = true

-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
-- 		title    = _U('moneywash_title'),
-- 		align    = 'top-left',
-- 		elements = elements
-- 	}, function(data, menu)
-- 		if data.current.value == 'moneywash_wash' then
-- 			TriggerServerEvent('esx_illegal:Wash')
-- 		end
-- 	end, function(data, menu)
-- 		menu.close()
-- 		menuOpen = false
-- 	end)
-- end

-- AddEventHandler('onResourceStop', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		if menuOpen then
-- 			ESX.UI.Menu.CloseAll()
-- 		end
-- 	end
-- end)