--[[
	id: A0ERO35aIdL8YivNz9uQc
	name: r3_pawnshop
	description: vendita item best
	time1: 2021-04-24 14:07:49.219885+00
	time2: 2021-04-24 14:07:49.219885+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if GetDistanceBetweenCoords(coords, vector3(Config.PawnshopLocation.x, Config.PawnshopLocation.y, Config.PawnshopLocation.z), true) < 1.5 then
			if Config.EnableOpeningHours then
				local ClockTime = GetClockHours()
				if Config.CloseHour < Config.OpenHour then
					if (ClockTime >= Config.OpenHour and ClockTime < 24) or (ClockTime <= Config.CloseHour -1 and ClockTime > 0) then
						if not menuOpen then
							Draw3DText(Config.PawnshopLocation.x, Config.PawnshopLocation.y, Config.PawnshopLocation.z, "~g~E~w~ - Per vendere gli oggetti")
							if IsControlJustReleased(0, 38) then
								wasOpen = true
								OpenPawnshop()
							end
						else
								Citizen.Wait(500)
						end
					else
						Draw3DText(Config.PawnshopLocation.x, Config.PawnshopLocation.y, Config.PawnshopLocation.z, "Il negozziante riceve, dalle ore ~r~" .. Config.OpenHour ..":00")
					end
				else
					if ClockTime >= Config.OpenHour and ClockTime <= Config.CloseHour - 1 then
						if not menuOpen then
							Draw3DText(Config.PawnshopLocation.x, Config.PawnshopLocation.y, Config.PawnshopLocation.z, "~g~E~w~ - Per vendere gli oggetti")
							if IsControlJustReleased(0, 38) then
								wasOpen = true
								OpenPawnshop()
							end
						else
								Citizen.Wait(500)
						end
					else
						Draw3DText(Config.PawnshopLocation.x, Config.PawnshopLocation.y, Config.PawnshopLocation.z, "Il negozziante riceve, dalle ore ~r~" .. Config.OpenHour ..":00")
					end
				end
			else
				if not menuOpen then
					Draw3DText(Config.PawnshopLocation.x, Config.PawnshopLocation.y, Config.PawnshopLocation.z, "~g~E~w~ - Per vendere gli oggetti")
					if IsControlJustReleased(0, 38) then
						wasOpen = true
						OpenPawnshop()
					end
				else
						Citizen.Wait(500)
				end
			end
		else
			if wasOpen then
				wasOpen = false
				ESX.UI.Menu.CloseAll()
			end

			Citizen.Wait(500)
		end
	end
end)

function OpenPawnshop()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.PawnshopItems[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, "€" .. ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pawnshop', {
		title    = "Vendita Oggetti Estratti",
		align    = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('r3_prospecting:sellItem', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- function CreateBlipCircle(coords, text, color, sprite)
-- 	blip = AddBlipForCoord(coords)

-- 	SetBlipSprite (blip, sprite)
-- 	SetBlipScale  (blip, 1.0)
-- 	SetBlipColour (blip, color)
-- 	SetBlipAsShortRange(blip, true)

-- 	BeginTextCommandSetBlipName("STRING")
-- 	AddTextComponentString(text)
-- 	EndTextCommandSetBlipName(blip)
-- end

Citizen.CreateThread(function()
	CreateBlipCircle(vector3(Config.PawnshopLocation.x, Config.PawnshopLocation.y, Config.PawnshopLocation.z), Config.PawnshopBlipText, Config.PawnshopBlipColor, Config.PawnshopBlipSprite)
end)

function Draw3DText(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
