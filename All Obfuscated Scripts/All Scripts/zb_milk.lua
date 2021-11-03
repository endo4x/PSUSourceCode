--[[
	id: dV507m9o4i3hYvAkrg9_e
	name: zb_milk
	description: lavoro latte
	time1: 2021-04-24 14:15:38.916636+00
	time2: 2021-04-24 14:15:38.916637+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

local Props = {}
local isPickingUp, isProcessing = false, false
local Propsno = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.zones.milk.coords, true) < 50 then
			SpawnProps()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.zones.process.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('Procress'))
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					Process()
			end
		else
			Citizen.Wait(500)
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		for index, value in pairs(Config.AnimalPositions) do
			DrawMarker(20, value.x, value.y, value.z+1.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 240,230,140, 165, 1,0, 0,1)	
		end
		
	end
end)

function Process()
	isProcessing = true

	--TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = _U('Processcoming') })
	
	local timeLeft = Config.WaitProcess
	local playerPed = PlayerPedId()
	local ped = GetPlayerPed(-1)

	exports['mythic_progbar']:Progress({
		name = 'chicken_action',
		duration = Config.WaitTimePickup,
		label = _U('Processcoming'),
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		},
		animation = {
				animDict = Config.animalDirectory3,
				anim = 'put_down_case',
				--flags = 49,
				},
		prop = {
			model = 'prop_apple_box_02',
			bone = 57005,
			coords = { x = 0.11, y = 0.0145, z =  0.02 },
			rotation = { x = 240.0, y = 150.0, z = 90.0 },
			}
		},  function(status)
			TriggerServerEvent('crossbite_milk:process')
		end)
	FreezeEntityPosition(ped, true)
	Wait(10000)
	FreezeEntityPosition(ped, false)
	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		
		
		

		for i=1, #Props, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), false) < 2 then
				nearbyObject, nearbyID = Props[i], i
			end
		end

			
		if nearbyObject and IsPedOnFoot(playerPed) then
				DisableControlAction(0, 24, true) -- Attack
				DisableControlAction(0, 257, true) -- Attack 2
				DisableControlAction(0, 25, true) -- Aim
				DisableControlAction(0, 263, true) -- Melee Attack 1
				DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
			
		
			
				if not isPickingUp then
					ESX.ShowHelpNotification(_U('Milk'))
				end

					if IsControlJustReleased(0, 38) and not isPickingUp then
						ESX.TriggerServerCallback('crossbite_milk:haveItem', function(haveItem)
							if haveItem then
								isPickingUp = true

								ESX.TriggerServerCallback('crossbite_milk:canPickUp', function(canPickUp)
										
										if canPickUp then
											--TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_GARDENER_PLANT', 0, false)
											while not HasAnimDictLoaded(Config.animalDirectory1) and not HasAnimDictLoaded(Config.animalDirectory2) do
												Citizen.Wait(0)
											end
											
											--TaskPlayAnim(PlayerPedId(), Config.animalDirectory1 ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
											Citizen.Wait(100)
											
											TaskPlayAnim(PlayerPedId(), Config.animalDirectory2 ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
											exports['mythic_progbar']:Progress({
											name = 'milk_action',
											duration = Config.WaitTimePickup,
											label = _U('Processcoming'),
											useWhileDead = false,
											canCancel = true,
											controlDisables = {
												disableMovement = true,
												disableCarMovement = true,
												disableMouse = false,
												disableCombat = true,
											},
											animation = {
												animDict = Config.animalDirectory1,
												anim = 'base',
												--flags = 49,
											},
											prop = {
												model = 'prop_bucket_01b',
												bone = 60309,
												coords = { x = 0.0, y = 0.1, z = 0.5 },
												rotation = { x = 364.0, y = 180.0, z = 90.0 },
											}
											},  function(status)
													TriggerServerEvent('crossbite_milk:pickedUp')
											end)
											
											Citizen.Wait(8000)
											ClearPedTasks(playerPed)
											Citizen.Wait(1)
											ClearPedTasksImmediately(PlayerPedId())
											FreezeEntityPosition(PlayerPedId(), false)
							
											
										end

										isPickingUp = false
									
								end, 'milk')
							
							else
									ESX.ShowNotification(_U('Needbuy'))
							end
							
						end, 'milk_engine')
					end
		else
			Citizen.Wait(500)
		end

	end

end)
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Props) do
			DeleteEntity(v)
		end
	end
end)

function SpawnProps()
	while Propsno < Config.Props do
		Citizen.Wait(0)
		for index, value in pairs(Config.AnimalPositions) do
			local Animal = CreatePed(5, GetHashKey(Config.animalname), value.x, value.y, value.z, 0.0, true, false)
			--DrawMarker(20, value.x, value.y, value.z+1.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 240,230,140, 165, 1,0, 0,1)	
			--DrawMarker(20, value.x, value.y, value.z+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
		  	
			
			--TaskWanderStandard(Animal, true, true)
			--SetEntityAsMissionEntity(Animal, true, true)
			table.insert(Props, Animal)
			Propsno = Propsno + 1
			Citizen.Wait(500)
			FreezeEntityPosition(Animal, true)
			SetEntityInvincible(Animal,true)
			SetEntityOnlyDamagedByPlayer(Animal, false)
			SetEntityCanBeDamaged(Animal, false)
			SetPedCanRagdoll(Animal, false)
			ClearPedBloodDamage(Animal)
			ResetPedVisibleDamage(Animal)
		end
		
	end

end
