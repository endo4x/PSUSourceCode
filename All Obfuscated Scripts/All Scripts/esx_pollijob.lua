--[[
	id: N07XHOilmbcfSzOsH94dC
	name: esx_pollijob
	description: macello polli
	time1: 2021-04-24 16:37:50.0297+00
	time2: 2021-04-24 16:37:50.029701+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

local Keys = {
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

ESX                             = nil
Isworking = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	ScriptLoaded()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function ScriptLoaded()
	Citizen.Wait(1000)
	LoadMarkers()
end

local AnimalPositions = {
	{ x = 2377.8, y = 5054.0, z = 46.4 }, 
	{ x = 2370.11, y = 5049.95, z = 46.4 }, 
	{ x = 2376.8, y = 5060.18, z = 46.44 }, 
	{ x = 2384.6, y = 5059.4, z = 46.44 },
	{ x = 2386.1, y = 5048.0, z = 46.42 }, 
	{ x = 2376.88, y = 5043.4, z = 46.34 }
	--{ x = -1697.63, y = 4652.71, z = 22.2442 },
	--{ x = -1259.99, y = 5002.75, z = 151.36 },
	--{ x = -960.91, y = 5001.16, z = 183.0 },
}

local AnimalPositionstwo = {
	{ x = 2376.88, y = 5043.4, z = 46.34 }
	--{ x = 2385.79, y = 5054.08, z = 46.44 },
	--{ x = 2371.70, y = 5053.33, z = 46.44 }
	--{ x = -1377.29, y = 4864.31, z = 134.162 },
	--{ x = -1697.63, y = 4652.71, z = 22.2442 },
	--{ x = -1259.99, y = 5002.75, z = 151.36 },
	--{ x = -960.91, y = 5001.16, z = 183.0 },
}

local AnimalsInSession = {}

local Positions = {
	['StartHunting'] = { ['hint'] = '[E] Start working', ['x'] = 2385.14, ['y'] = 5032.64, ['z'] = 45.92 },
	['Sell'] = { ['hint'] = '[E] Sell', ['x'] = 964.30438232422, ['y'] = -2105.92578125, ['z'] = -311.463960647583 },
    ['Porkpack'] = { ['hint'] = '[E] Impachetta polli', ['x'] = -102.17, ['y'] = 6208.55, ['z'] = 31.02}
	--['SpawnATV'] = { ['x'] = -769.63067626953, ['y'] = 5592.7573242188, ['z'] = 33.48571395874 }
}

local OnGoingHuntSession = false
local HuntCar = nil

function LoadMarkers()

	Citizen.CreateThread(function()
		for index, v in ipairs(Positions) do
			if index ~= 'SpawnATV' then
				local StartBlip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(StartBlip, 442)
				SetBlipColour(StartBlip, 75)
				SetBlipScale(StartBlip, 0.7)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Hunting Spot')
				EndTextCommandSetBlipName(StartBlip)
			end
		end
	end)

	--LoadModel('blazer')
	LoadModel('a_c_hen')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			
			local plyCoords = GetEntityCoords(PlayerPedId())

			for index, value in pairs(Positions) do
				if value.hint ~= nil then

					if OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '[E] Smetti di lavorare'
					elseif not OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '[E] Inizia a lavorare'
					end

					local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)

					if distance < 5.0 then
						sleep = 5
						DrawM(value.hint, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
						if distance < 1.0 then
							if IsControlJustReleased(0, Keys['E']) then
								if index == 'StartHunting' then
									StartHuntingSession()
									Citizen.Wait(30000)
								elseif index == 'Porkpack' then
									Porkpack()
								else
									SellItems()
								end
							end
						end
					end

				end
				
			end
			Citizen.Wait(sleep)
		end
	end)
end

function Spawnpig()
	Citizen.CreateThread(function()
	
		for index, value in pairs(AnimalPositionstwo) do
			local Ped = PlayerPedId()
			
			Citizen.Wait(5000)
			local Animal = CreatePed(5, GetHashKey('a_c_hen'), value.x, value.y, value.z, 0.0, true, false)
			TaskSmartFleePed(Animal, Ped, 9000.0, -1, false, false)
			--TaskWanderStandard(Animal, true, true)
			--SetEntityAsMissionEntity(Animal, true, true)
			--Blips

			local AnimalBlip = AddBlipForEntity(Animal)
			SetBlipSprite(AnimalBlip, 153)
			SetBlipColour(AnimalBlip, 1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Hen - Animal')
			EndTextCommandSetBlipName(AnimalBlip)


			table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Isworking then
			DisableAllControlActions(0)
			--EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['E'], true)
			EnableControlAction(0, Keys['DELETE'], true)
			EnableControlAction(0, Keys['F2'], true)
			EnableControlAction(0, Keys['X'], true)
			--EnableControlAction(0, Keys['F1'], true)
		else
			Citizen.Wait(500)
		end
	end
end)

function StartHuntingSession()

	if OnGoingHuntSession then

		OnGoingHuntSession = false
		
		--SetPedAmmo(PlayerPedId(), "WEAPON_MUSKET", 0)
		--RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"), true, true)
		--RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), true, true)

		DeleteEntity(HuntCar)

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end

	else
		OnGoingHuntSession = true

		--Car

		--HuntCar = CreateVehicle(GetHashKey('blazer'), Positions['SpawnATV'].x, Positions['SpawnATV'].y, Positions['SpawnATV'].z, 169.79, true, false)

		--GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"),30, true, false)
		--GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"),0, true, false)

		--Animals

		Citizen.CreateThread(function()

				
			for index, value in pairs(AnimalPositions) do
				local Ped = PlayerPedId()
				local Animal = CreatePed(5, GetHashKey('a_c_hen'), value.x, value.y, value.z, 0.0, true, false)
				Citizen.Wait(1000)
				TaskSmartFleePed(Animal, Ped, 9000.0, -1, false, false)
				--TaskWanderStandard(Animal, true, true)
				--SetEntityAsMissionEntity(Animal, true, true)
				--Blips

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 153)
				SetBlipColour(AnimalBlip, 1)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Hen - Animal')
				EndTextCommandSetBlipName(AnimalBlip)


				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			end

			while OnGoingHuntSession do
				local sleep = 500
				--local Ped = PlayerPedId()
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

						--if AnimalHealth > 0 then
							--SetBlipColour(value.Blipid, 3)
						if PlyToAnimal < 2.0 then
							--TaskSmartFleePed(value.id, Ped, 9000.0, -1, false, false)
							sleep = 10
							
							ESX.Game.Utils.DrawText3D({x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z + 1}, '[E] Prendi Gallina', 0.4)

							if IsControlJustReleased(0, Keys['E']) then
								--if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
								if DoesEntityExist(value.id) then
									SetEntityHealth(value.id, 0)
									table.remove(AnimalsInSession, index)
									SlaughterAnimal(value.id)
									Spawnpig()
								end
								--else
								--	ESX.ShowNotification('You need to use the knife!')
								--end
							end
						end
					end
				end

				Citizen.Wait(sleep)

			end
				
		end)
	end
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	Isworking = true
	 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 5000,
							label = "Raccogliendo....",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
								},
								
							}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
						end)
	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())

	local AnimalWeight = math.random(10, 160) / 10

	-- ESX.ShowNotification('Hai squoiato il maiale e ottenuto la carne.')

	TriggerServerEvent('esx_pollijob:reward', AnimalWeight)
	
	Isworking = false
	
	DeleteEntity(AnimalId)
end

function SellItems()
    TriggerServerEvent('esx_pollijob:sell')
end

function Porkpack()
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
	 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 2500,
							label = "Impacchettamento...",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
								},
								
							}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
						end)
	Citizen.Wait(2500)
	ClearPedTasks(playerPed)
	TriggerServerEvent('esx_pollijob:porkpack')
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function DrawM(hint, type, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 0, 255, 150, false, true, 2, false, false, false, false)
end