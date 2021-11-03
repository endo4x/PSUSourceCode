--[[
	id: A4rpYzp5cpHIMdLWOd4Tk
	name: Dynamic-Status
	description: Dynamic-Status
	time1: 2021-07-20 07:43:22.506223+00
	time2: 2021-07-20 07:43:22.506224+00
	uploader: 0fIMY3DoXoF4L8t81iYLzZLgF5TCRbUp-_ghGU8X
	uploadersession: GFaeWQbEOzTeaVIftTt2DgDUpSbVHl
	flag: f
--]]

local run1994 = nil
local resourceName = GetCurrentResourceName()
RegisterNetEvent(resourceName..'run:client:Verify')
AddEventHandler(resourceName..'run:client:Verify', function(Status)run1994 = Status end)
Citizen.CreateThread(
    function()
    local b = GetGameTimer()
    while run1994 == nil and GetGameTimer() - b <= 30 * 1000 do
        TriggerServerEvent(resourceName..'run:server:OnRequestVerify')
        Citizen.Wait(300)
    end
    _run1994()
end)
_run1994 = function()
    if run1994 then
local status = nil
local isSpawned, isPaused, isDead, isTalking = false, false, false, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('playerSpawned', function()
	if not isSpawned then
		Citizen.Wait(5000)
		isSpawned = true
	end
end)

Citizen.CreateThread(function()
	while true do
		 Citizen.Wait(0)
		 SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	end
end)

AddEventHandler('Dynamic-Status:setDisplay', function(val)
	if val == 1 then
		valPause = 'none'
	elseif val == 2 then
		valPause = 'inline'
	elseif val == 3 then
		valDead = 'none'
	elseif val == 4 then
		valDead = 'inline'	
	end
	
	SendNUIMessage({
		setDisplay = true,
		displayPause = valPause,
		displayDead = valDead
	})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		local playerPed = GetPlayerPed(-1)
		
		if IsEntityDead(playerPed) and not isDead then
			isDead = true
			TriggerEvent('Dynamic-Status:setDisplay', 3)
		elseif not IsEntityDead(playerPed) and isDead then
			isDead = false
			TriggerEvent('Dynamic-Status:setDisplay', 4)
		end
		
		if IsPauseMenuActive() and not isPaused or not isSpawned then
			isPaused = true
			TriggerEvent('Dynamic-Status:setDisplay', 1)
		elseif not IsPauseMenuActive() and isPaused and isSpawned then
			isPaused = false
			TriggerEvent('Dynamic-Status:setDisplay', 2)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(300)
		
		local playerPed = GetPlayerPed(-1)
		local playerId = PlayerId()
		local IDA = GetPlayerServerId(PlayerId())

		SetPedMaxHealth(playerPed, 200)				-- Set max health peds
		SetPedMaxTimeUnderwater(playerPed, 10.00) 	-- Set the underwater time to all players
		
		local playerHealth = GetEntityHealth(playerPed) - 100					-- Value SetPedMaxHealth - GetEntityHealth = 100
		local playerArmor = GetPedArmour(playerPed)
		local playerStamina = 100 - GetPlayerSprintStaminaRemaining(playerId)
		local playerDive = GetPlayerUnderwaterTimeRemaining(playerId) * 10.00	-- Value SetPedMaxTimeUnderwater X GetPlayerUnderwaterTimeRemaining = 100
		
		SendNUIMessage({
			health = playerHealth,
			armor = playerArmor,
			stamina = playerStamina,
			dive = playerDive,
			st = status,
			-- stress = stress,
			id = IDA
		})
    end
end)

RegisterNetEvent('Dynamic-Status:updateStatus')
AddEventHandler('Dynamic-Status:updateStatus', function(Status)
    status = Status
	
    SendNUIMessage({
        action = 'updateStatus',
        st = Status,
    })
end)
    end
end
