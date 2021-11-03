--[[
	id: M1q-YQFS-EqtjyjdcceJe
	name: Register_Client
	description: Register_Client
	time1: 2021-07-18 21:06:09.80122+00
	time2: 2021-07-18 21:06:09.80122+00
	uploader: jwSAFiyGDZZngdEUyC9KXjXc3kZsqwbIcIgS4G-8
	uploadersession: nL5L49evOF_jJlNEUrxixZuZeT-pDw
	flag: f
--]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShilovepizzaaredObjilovepizzaect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local display = false
local isDead = false
local isRegistered = false

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

RegisterNetEvent('nui:on')
AddEventHandler('nui:on', function()
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('nui:off')
AddEventHandler('nui:off', function()
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

AddEventHandler('playerSpawned', function(event)
  ESX.TriggerServerCallback('register:check', function(callback)
	if callback then
		TriggerEvent('nui:off')
		isRegistered = true
	else
		TriggerEvent('nui:on')
		isRegistered = false
	end
  end)
end)

RegisterNUICallback('save', function(data, cb)

	if isRegistered then
		
	else
		if data.sex == "M" or data.sex == "F" or data.sex == "m" or data.sex == "f" then
			TriggerServerEvent('register:set', data)
		end
	end

end)

Citizen.CreateThread(function()
	while true do
		if display then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		end
		Citizen.Wait(0)
	end
end)