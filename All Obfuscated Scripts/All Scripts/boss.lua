--[[
	id: ajgnCHzYGtxlwNfuCX1Ui
	name: boss
	description: boss
	time1: 2021-05-17 11:47:31.706834+00
	time2: 2021-05-17 11:47:31.706835+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

ESX = nil
local PlayerLoaded = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

local walks = {
	"move_m@drunk@verydrunk",
	"move_m@drunk@moderatedrunk",
	"move_m@drunk@a",
	"anim_group_move_ballistic",
	"move_lester_CaneUp",
}

local BossKilled = true

AddEventHandler('esx:onPlayerSpawn', function()
	while not PlayerLoaded do
		Citizen.Wait(100)
	end
	Citizen.Wait(900000)
	BossKilled = false
	ESX.ShowNotification("~r~BOSS ~w~artık spawn olabilir!")
end)

bossentity = {}

Citizen.CreateThread(function()
	AddRelationshipGroup("zombie")
	SetRelationshipBetweenGroups(0, GetHashKey("zombie"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(2, GetHashKey("PLAYER"), GetHashKey("zombie"))
    while true do
		local coords = GetEntityCoords(PlayerPedId())
        Citizen.Wait(5000)
        if  GetDistanceBetweenCoords(coords, 2939.38, 2787.3, 39.9, true) < 75 or
			GetDistanceBetweenCoords(coords, 1060.138, 2359.93, 44.449, true) < 75 or
			GetDistanceBetweenCoords(coords, -1117.8, 4924.3, 218.2, true) < 75 or
			GetDistanceBetweenCoords(coords, -164.38, -825.5, 31.12, true) < 75 or
			GetDistanceBetweenCoords(coords, -1111.5, -1614.6, 4.3, true) < 75
		then
			if #bossentity < 1 and not BossKilled then
				TriggerEvent('t11:spawnBoss')
			else
			
			end
		else
			
		end	
    end
end)

RegisterNetEvent("t11:spawnBoss")
AddEventHandler("t11:spawnBoss", function()
	if #bossentity < 1 then
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		BossEntityModel = "A_F_M_FATCULT_01"
		BossEntityModel = string.upper(BossEntityModel)
		RequestModel(GetHashKey(BossEntityModel))
		while not HasModelLoaded(GetHashKey(BossEntityModel)) or not HasCollisionForModelLoaded(GetHashKey(BossEntityModel)) do
			Wait(1)
		end
		
		local posX = x
		local posY = y
		local posZ = z + 999.0

		repeat
			Wait(1)
			posX = x + math.random(-Config.MaxSpawnDistance, Config.MaxSpawnDistance)
			posY = y + math.random(-Config.MaxSpawnDistance, Config.MaxSpawnDistance)
			_,posZ = GetGroundZFor_3dCoord(posX+.0,posY+.0,z,1)					
			playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			if posX > playerX - Config.MinSpawnDistance and posX < playerX + Config.MinSpawnDistance or posY > playerY - Config.MinSpawnDistance and posY < playerY + Config.MinSpawnDistance then
				canSpawn = false
				break
			else
				canSpawn = true
			end
		until canSpawn
		bentity = CreatePed(4, GetHashKey(BossEntityModel), posX, posY, posZ, 0.0, false, false)
		ESX.ShowNotification("Bir ~r~Boss ~w~spawn oldu!")
		walk = walks[math.random(1, #walks)]
		RequestAnimSet(walk)
		while not HasAnimSetLoaded(walk) do
			Citizen.Wait(1)
		end
		--BossDynamics
		SetEntityHealth(bentity, 1000)
		SetEntityMaxHealth(bentity, 1000)
		SetPedSuffersCriticalHits(bentity, false)
		SetPedCanRagdoll(bentity, false)
		SetPedMovementClipset(bentity, walk, 1.0)
		TaskWanderStandard(bentity, 1.0, 10)
		SetCanAttackFriendly(bentity, true, true)
		SetPedCanEvasiveDive(bentity, false)
		SetPedRelationshipGroupHash(bentity, GetHashKey("zombie"))
		SetPedCombatAbility(bentity, 0)
		SetPedCombatRange(bentity,1)
		SetPedCombatMovement(bentity, 3)
		SetPedAccuracy(bentity, 25)
		SetPedSeeingRange(bentity, 1000000.0)
		SetPedHearingRange(bentity, 1000000.0)
		SetPedAlertness(bentity,3)
		SetPedIsDrunk(bentity, true)
		SetPedConfigFlag(bentity,100,1)
		ApplyPedDamagePack(bentity,"BigHitByVehicle", 0.0, 9.0)
		ApplyPedDamagePack(bentity,"SCR_Dumpster", 0.0, 9.0)
		ApplyPedDamagePack(bentity,"SCR_Torture", 0.0, 9.0)
		DisablePedPainAudio(bentity, true)
		StopPedSpeaking(bentity,true)
		SetEntityAsMissionEntity(bentity, true, true)
		table.insert(bossentity, bentity)
		NetworkSetEntityInvisibleToNetwork(bentity, true)			
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		for i, bentity in pairs(bossentity) do
			if not DoesEntityExist(bentity) then
				SetEntityAsNoLongerNeeded(bentity)
				table.remove(bossentity, i)
			else
				local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				local pedX, pedY, pedZ = table.unpack(GetEntityCoords(bentity, true))	
					
				if pedX < playerX - Config.DespawnDistance or pedX > playerX + Config.DespawnDistance or pedY < playerY - Config.DespawnDistance or pedY > playerY + Config.DespawnDistance then
					local model = GetEntityModel(bentity)
					SetEntityAsNoLongerNeeded(bentity)
					SetModelAsNoLongerNeeded(model)
					table.remove(bossentity, i)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for i, bentity in pairs(bossentity) do
			TaskGoToEntity(bentity, GetPlayerPed(-1), -1, 0.0, 1.7, 1073741824, 0)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		sleep = 1000
		for i, bentity in pairs(bossentity) do
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			bX, bY, bZ = table.unpack(GetEntityCoords(bentity, true))
			if DoesEntityExist(bentity) then
				if(Vdist(playerX, playerY, playerZ, bX, bY, bZ) < 30)then
					sleep = 2
					DrawText3D(bX, bY, bZ + 1, 0.30, "~w~ BOSS")
				end
			end
		end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        for i, bentity in pairs(bossentity) do
	       	playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(bentity, true))
			if IsPedDeadOrDying(bentity, 1) == 1 then
			else
				if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 0.6)then
					if IsPedRagdoll(bentity, 1) ~= 1 then
						if not IsPedGettingUp(bentity) then
							RequestAnimDict("misscarsteal4@actor")
							TaskPlayAnim(bentity,"misscarsteal4@actor","stumble",1.0, 1.0, 500, 9, 1.0, 0, 0, 0)
							local playerPed = (GetPlayerPed(-1))
							local maxHealth = GetEntityMaxHealth(playerPed)
							local health = GetEntityHealth(playerPed)
							local newHealth = math.min(maxHealth, math.floor(health - maxHealth / 15))
							SetEntityHealth(playerPed, newHealth)
							Wait(2000)	
							TaskGoToEntity(bentity, GetPlayerPed(-1), -1, 0.0, 1.3, 1073741824, 0)
						end
					end
				end
			end
		end
    end
end)

if Config.ZombieDropLoot then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			for i, bentity in pairs(bossentity) do
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(bentity, true))
				if DoesEntityExist(bentity) == false then
					table.remove(bossentity, i)
				end
				if IsPedDeadOrDying(bentity, 1) == 1 then
					if GetPedSourceOfDeath(bentity) == PlayerPedId() then
						ESX.ShowNotification("Bir ~r~BOSS ~w~öldürdün! Yeni bir ~r~BOSS ~w~ ortalama ~y~15 ~w~ dakika sonra çıkacak!")
						if not IsPedInAnyVehicle(PlayerPedId(), false) then
							if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 2.25) then
								DrawText3D(pedX, pedY, pedZ + 0.35, 0.30, "~r~[E]~w~ LOOT BOSS")
								if IsControlJustReleased(1, 51) then
									if DoesEntityExist(GetPlayerPed(-1)) then
										BossKilled = true
										Boss = Config.Boss[math.random(1, #Config.Boss)]
										vipBoss = Config.vipBoss[math.random(1, #Config.vipBoss)]
										if vipuser then
											randomEXP = math.random(1000, 1500)
											exports.t11_newLevel:addExp(randomEXP)
											TriggerServerEvent('t11_zombie:ilbrxde', vipBoss)
										else
											randomEXP = math.random(900, 1250)
											exports.t11_newLevel:addExp(randomEXP)
											TriggerServerEvent('t11_zombie:ilbrxde', Boss)
										end
										DeleteEntity(bentity)
										ClearPedSecondaryTask(GetPlayerPed(-1))
										local model = GetEntityModel(bentity)
										SetEntityAsNoLongerNeeded(bentity)
										SetModelAsNoLongerNeeded(model)
										table.remove(bossentity, i)
										Citizen.Wait(900000)
										BossKilled = false
										ESX.ShowNotification('Yeni ~r~Boss ~w~artık spawn olabilir!')
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function DrawText3D(x, y, z, scale, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    -- local scale = 0.35
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 490
        DrawRect(_x, _y + 0.0120, 0.05 + factor, 0.025, 33, 33, 33, 200)
    end
end
