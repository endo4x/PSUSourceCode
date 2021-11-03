--[[
	id: SAYekXnUs1mFBfr8xEgG7
	name: zonesScramble
	description: zonesScramble
	time1: 2021-05-22 14:36:30.231925+00
	time2: 2021-05-22 14:36:30.231925+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('KKBGaYWAm', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('akOAwEOOO')
AddEventHandler('akOAwEOOO', function(xPlayer)
	PlayerData = xPlayer
end)


if Config.SafeZoneRadioBlip then
	for k, v in pairs(Config.SafeZoneCoords) do
		blip = AddBlipForRadius(v.x, v.y, v.z, v.radio)
		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, 69)
		SetBlipAlpha (blip, 170)
	end
end

if Config.RedZoneRadioBlip then
	for k, v in pairs(Config.RedZoneCoords) do
		blip1 = AddBlipForRadius(v.x, v.y, v.z, v.radio)
		SetBlipHighDetail(blip1, true)
		SetBlipColour(blip1, 1)
		SetBlipAlpha (blip1, 170)
	end
end

if Config.BlueZoneRadioBlip then
	for k, v in pairs(Config.BlueZoneCoords) do
		blip3 = AddBlipForRadius(v.x, v.y, v.z, v.radio)
		SetBlipHighDetail(blip3, true)
		SetBlipColour(blip3, 25)
		SetBlipAlpha (blip3, 200)
	end
end

if Config.BossZoneRadioBlip then
	for k, v in pairs(Config.BossZoneCoords) do
		blip3 = AddBlipForRadius(v.x, v.y, v.z, v.radio)
		SetBlipHighDetail(blip3, true)
		SetBlipColour(blip3, 40)
		SetBlipAlpha (blip3, 200)
	end
end

Citizen.CreateThread(function()
	for k, v in pairs(Config.BlueZoneCoords) do
		farmzone = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipScale(farmzone, 0.8)
		SetBlipSprite(farmzone, 110)
		SetBlipColour(farmzone, 4)
		SetBlipAsShortRange(farmzone, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Farm Bölgesi")
		EndTextCommandSetBlipName(farmzone)
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.RedZoneCoords) do
		redzone = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipScale(redzone, 0.7)
		SetBlipSprite(redzone, 313)
		SetBlipColour(redzone, 4)
		SetBlipAsShortRange(redzone, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Kırmızı Bölge")
		EndTextCommandSetBlipName(redzone)
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.SafeZoneCoords) do
		safezone = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipScale(safezone, 0.7)
		SetBlipSprite(safezone, 59)
		SetBlipColour(safezone, 5)
		SetBlipDisplay(safezone, 3)
		SetBlipAsShortRange(safezone, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Güvenli Bölge")
		EndTextCommandSetBlipName(safezone)
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.BossZoneCoords) do
		bosszone = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipScale(bosszone, 0.7)
		SetBlipSprite(bosszone, 630)
		SetBlipColour(bosszone, 75)
		SetBlipAsShortRange(bosszone, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Boss Bölgesi")
		EndTextCommandSetBlipName(bosszone)
	end
end)

if Config.NoPeds then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
	    	SetVehicleDensityMultiplierThisFrame(0.0)
			SetPedDensityMultiplierThisFrame(0.0)
			SetRandomVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
			local playerPed = GetPlayerPed(-1)
			local pos = GetEntityCoords(playerPed) 
			RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
			SetGarbageTrucks(0)
			SetRandomBoats(0)

			for k, v in pairs(Config.SafeZoneCoords) do
				for i, entity in pairs(entitys) do
					pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
					if(Vdist(pedX, pedY, pedZ, v.x, v.y, v.z) < 150)then
						SetEntityHealth(entity, 0)
						SetEntityAsNoLongerNeeded(entity)
						DeleteEntity(entity)
						table.remove(entitys, i)
					end
				end
			end
		end
	end)
end


-----COLLISION & SAFE

StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')

stat = false
function togglePassive(status)
	if not stat == status then
		TriggerServerEvent("OAIFMYgCn", status)
		stat = status
	end
end

function SafeZone()
	SetPlayerLockon(PlayerId(), true)
	SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
	SetEntityCanBeDamaged(GetPlayerPed(-1), false)
	SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
	SetEntityInvincible(GetPlayerPed(-1), true)
	SetPlayerInvincible(PlayerId(), true)
		DisableControlAction(0, 24,true)
		DisableControlAction(0, 70,true)
		DisableControlAction(0, 69,true)
		DisableControlAction(0, 91,true)
		DisableControlAction(0, 92,true)
		DisableControlAction(0, 257,true)
		DisableControlAction(0, 346,true)
		DisableControlAction(0, 347,true)
		DisableControlAction(0, 68,true)
		DisableControlAction(0, 140,true)
		DisableControlAction(0, 114,true)
end

function FarmZone()
	SetPlayerLockon(PlayerId(), true)
	SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
	SetEntityInvincible(GetPlayerPed(-1), true)
	SetPlayerInvincible(PlayerId(), true)
	ClearPedLastWeaponDamage(GetPlayerPed(-1))
	SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
	SetEntityCanBeDamaged(GetPlayerPed(-1), false)
	SetEntityInvincible(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 1)
	NetworkSetFriendlyFireOption(false)
end

function Falling()
	SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
	SetEntityInvincible(GetPlayerPed(-1), true)
	SetPlayerInvincible(PlayerId(), true)
	ClearPedLastWeaponDamage(GetPlayerPed(-1))
	SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
	SetEntityCanBeDamaged(GetPlayerPed(-1), false)
end

function NormalZone()
	SetPlayerLockon(PlayerId(), false)
	SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
	SetEntityInvincible(GetPlayerPed(-1), false)
	SetPlayerInvincible(PlayerId(), false)
	ClearPedLastWeaponDamage(GetPlayerPed(-1))
	SetEntityCanBeDamaged(GetPlayerPed(-1), true)
	NetworkSetFriendlyFireOption(true)
end

Citizen.CreateThread(function()
	while true do
		if 
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 342.4698, -1398.107, 32.50964, true) < 125 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2132.95, 4782.288, 40.44, true) < 125 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1468.519, 6357.824, 23.25, true) < 125 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2768.77, 3473.263, 55.51377, true) < 150 or --IKEA
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 324.984, -211.1148, 54.11214, true) < 150 or --MOTEL
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1678.865, -297.577, 51.81211, true) < 150  
			then --GODAÇ
				SafeZone()
				sleep = 5
		elseif --SilahlıSafeKasılmaBölgesi
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1896.6, 3826.557, 32.6, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2869.6, 4631.3, 49.1, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1426.6, 1116.7, 114.6, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 246.4, 2791.3, 43.9, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -860.2, -780.9, 20.60, true) < 75 then --GODAÇ
			FarmZone()
			sleep = 100
		elseif IsPedFalling(GetPlayerPed(-1)) then
			Falling()
			sleep = 5
		else --GODKAPA
			NormalZone()
			sleep = 100
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		if 
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 342.4698, -1398.107, 32.50964, true) < 150 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2132.95, 4782.288, 40.44, true) < 150 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1468.519, 6357.824, 23.25, true) < 150 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2768.77, 3473.263, 55.51377, true) < 150 or --IKEA
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 324.984, -211.1148, 54.11214, true) < 150 or --MOTEL
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1678.865, -297.577, 51.81211, true) < 150 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1896.6, 3826.557, 32.6, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2869.6, 4631.3, 49.1, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1426.6, 1116.7, 114.6, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 246.4, 2791.3, 43.9, true) < 75 or
			GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -860.2, -780.9, 20.60, true) < 75
			then --GODAÇ
				togglePassive(true)
			else
				togglePassive(false)
		end
		Citizen.Wait(3000)
	end
end)