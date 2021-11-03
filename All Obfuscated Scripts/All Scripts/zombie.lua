--[[
	id: N99sJcPUPmNK3_ku_DEC1
	name: zombie
	description: zombie
	time1: 2021-05-17 11:51:14.611733+00
	time2: 2021-05-17 11:51:14.611734+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

local vipuser = false
local viptext = "VIP UYE"
local viptextColor = {175, 77, 221, 0.2}
local screenPosX = 0.911
local screenPosY = 0.961

RegisterNetEvent('t11:setvip')
AddEventHandler('t11:setvip', function(parameter)
    Citizen.Wait(2500)
    if parameter == 1 then
		vipuser = true
		TriggerServerEvent('t11:activateVIP')
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				if vipuser then
					drawTxt(viptext, 0, viptextColor, 0.30, screenPosX, screenPosY)
				end
			end
		end)
	else
	end
end)

local Models = {
	"A_F_M_BEVHILLS_01",
	"A_F_M_BEACH_01",
	"A_M_M_AFRIAMER_01",
	"A_M_M_HILLBILLY_02",
	"A_M_M_PROLHOST_01",
	"A_M_M_SALTON_02",
	"A_M_Y_DHILL_01",
	"A_M_Y_SKATER_01",
	"MP_M_FIBSEC_01",
	"S_F_M_FEMBARBER",
	"S_M_M_AUTOSHOP_01",
	"A_M_Y_VINEWOOD_01",
	"S_M_M_MIGRANT_01",
	"S_M_M_UPS_01",
	"S_M_Y_AIRWORKER" ,
	"S_M_Y_PRISMUSCL_01", 
	"A_F_Y_BEACH_01",
	"G_F_Y_LOST_01",
	"A_M_Y_HIPSTER_01",
	"MP_F_FORGERY_01",
}

local walks = {
	"move_m@drunk@verydrunk",
	"move_m@drunk@moderatedrunk",
	"move_m@drunk@a",
	"anim_group_move_ballistic",
	"move_lester_CaneUp",
}

entitys = {}
local zombieses = true

Citizen.CreateThread(function()
	AddRelationshipGroup("zombie")
	SetRelationshipBetweenGroups(0, GetHashKey("zombie"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(2, GetHashKey("PLAYER"), GetHashKey("zombie"))

	while true do
		local coords = GetEntityCoords(PlayerPedId())
		sleep = 250
		Citizen.Wait(sleep)
		if Antizin then
			sleep=2500
		else
			if
				GetDistanceBetweenCoords(coords, 342.4698, -1398.107, 32.50964, true) < 125 or
				GetDistanceBetweenCoords(coords, 2132.95, 4782.288, 40.44, true) < 125 or
				GetDistanceBetweenCoords(coords, 1468.519, 6357.824, 23.25, true) < 125 or
				GetDistanceBetweenCoords(coords, 2768.77, 3473.263, 55.51377, true) < 150 or --IKEA
				GetDistanceBetweenCoords(coords, 324.984, -211.1148, 54.11214, true) < 150 or --MOTEL
				GetDistanceBetweenCoords(coords, -1678.865, -297.577, 51.81211, true) < 150 then
				Config.SpawnZombie = 1
				sleep = 1000
			else			
				if #entitys < Config.SpawnZombie then
					sleep = 250
					x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					EntityModel = Models[math.random(1, #Models)]
					EntityModel = string.upper(EntityModel)
					RequestModel(GetHashKey(EntityModel))
					while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
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
					entity = CreatePed(4, GetHashKey(EntityModel), posX, posY, posZ, 0.0, false, false)

					walk = walks[math.random(1, #walks)]
								
					RequestAnimSet(walk)
					while not HasAnimSetLoaded(walk) do
						Citizen.Wait(1)
					end
					
					SetPedMovementClipset(entity, walk, 1.0)
					TaskWanderStandard(entity, 1.0, 10)
					SetCanAttackFriendly(entity, true, true)
					SetPedCanEvasiveDive(entity, false)
					SetPedRelationshipGroupHash(entity, GetHashKey("zombie"))
					SetPedCombatAbility(entity, 0)
					SetPedCombatRange(entity,1)
					SetPedCombatMovement(entity, 3)
					SetPedAccuracy(entity, 25)
					SetPedSeeingRange(entity, 1000000.0)
					SetPedHearingRange(entity, 1000000.0)
					SetPedAlertness(entity,3)
					SetPedIsDrunk(entity, true)
					SetPedConfigFlag(entity,100,1)
					ApplyPedDamagePack(entity,"BigHitByVehicle", 0.0, 9.0)
					ApplyPedDamagePack(entity,"SCR_Dumpster", 0.0, 9.0)
					ApplyPedDamagePack(entity,"SCR_Torture", 0.0, 9.0)
					DisablePedPainAudio(entity, true)
					StopPedSpeaking(entity,true)
					SetEntityAsMissionEntity(entity, true, true)

					table.insert(entitys, entity)
					NetworkSetEntityInvisibleToNetwork(entity, true)
				end
			end

			for i, entity in pairs(entitys) do
				if not DoesEntityExist(entity) then
					SetEntityAsNoLongerNeeded(entity)
					table.remove(entitys, i)
				else
					local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					local pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))	
						
					if pedX < playerX - Config.DespawnDistance or pedX > playerX + Config.DespawnDistance or pedY < playerY - Config.DespawnDistance or pedY > playerY + Config.DespawnDistance then
						local model = GetEntityModel(entity)
						SetEntityAsNoLongerNeeded(entity)
						SetModelAsNoLongerNeeded(model)
						table.remove(entitys, i)
					end
				end
				if IsEntityInWater(entity) then
					local model = GetEntityModel(entity)
					SetEntityAsNoLongerNeeded(entity)
					SetModelAsNoLongerNeeded(model)
					DeleteEntity(entity)
					table.remove(entitys,i)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		for i, entity in pairs(entitys) do
			TaskGoToEntity(entity, GetPlayerPed(-1), -1, 0.0, 1.5, 1073741824, 0)
		end
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(25)
        for i, entity in pairs(entitys) do
	       	playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
			if IsPedDeadOrDying(entity, 1) == 1 then
				--none :v
			else
				if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 0.6)then
					if IsPedRagdoll(entity, 1) ~= 1 then
						if not IsPedGettingUp(entity) then
							
							RequestAnimDict("misscarsteal4@actor")
							TaskPlayAnim(entity,"misscarsteal4@actor","stumble",1.0, 1.0, 500, 9, 1.0, 0, 0, 0)
							local playerPed = (GetPlayerPed(-1))
							local maxHealth = GetEntityMaxHealth(playerPed)
							local health = GetEntityHealth(playerPed)
							local newHealth = math.min(maxHealth, math.floor(health - maxHealth / 80))
							SetEntityHealth(playerPed, newHealth)
							Wait(2000)	
							TaskGoToEntity(entity, GetPlayerPed(-1), -1, 0.0, 1.5, 1073741824, 0)
							
						end
					end
				end
			end
		end
    end
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		for i, entity in pairs(entitys) do
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(entity), true)
			if distance <= 15.0 and zombieses then
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 4, "zombie", 0.16)
				Citizen.Wait(34000)
			end
		end
	end
end)]]

if Config.ZombieDropLoot then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
			for i, entity in pairs(entitys) do
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
				if DoesEntityExist(entity) == false then
					table.remove(entitys, i)
				end
				if IsPedDeadOrDying(entity, 1) == 1 then
					if GetPedSourceOfDeath(entity) == PlayerPedId() then
						if not IsPedInAnyVehicle(PlayerPedId(), false) then
							if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 2.25) then
								DrawText3D(pedX, pedY, pedZ + 0.35, 0.30, "~r~[E]~w~ LOOT")
								if IsControlJustReleased(1, 51) then
									if DoesEntityExist(GetPlayerPed(-1)) then
										--Citizen.Wait(10)
										
										DeleteEntity(entity)
										ClearPedSecondaryTask(GetPlayerPed(-1))
										local model = GetEntityModel(entity)
										SetEntityAsNoLongerNeeded(entity)
										SetModelAsNoLongerNeeded(model)
										table.remove(entitys, i)

										randomChance = math.random(1, 100)
										
										coords = GetEntityCoords(PlayerPedId())
										pos = GetEntityCoords(GetPlayerPed(-1))
										if --REDZONE 
											GetDistanceBetweenCoords(coords, 57.00021, 3687.98, 39.75499, true) < 150 or --lostmc
											GetDistanceBetweenCoords(coords, -2248.747, 270.641, 174.605, true) < 200 or --uni
											GetDistanceBetweenCoords(coords, 414.9337, -984.8844, 29.4299, true) < 125 or --pd
											GetDistanceBetweenCoords(coords, -580.0094, 5337.854, 70.2145, true) < 150 or --kereste
											GetDistanceBetweenCoords(coords, -2408.059, 2704.258, 2.8702, true) < 200 or --bataklık
											GetDistanceBetweenCoords(coords, 681.1898, 561.9288, 129.046, true) < 150 or --ARENA
											GetDistanceBetweenCoords(coords, 2211.384, 2071.258, 132.0664, true) < 150
										then
											if vipuser then
												randomEXP = math.random(500, 800)
												exports.t11_newLevel:addExp(randomEXP)
												Config.SpawnZombie = 12
												Config.ProbabilityWeaponLoot = 9
												Config.ProbabilityHeavyWeaponLoot = 16
												Config.ProbabilityAccLoot = 23
												Config.ProbabilityMoneyLoot = 45 -- 3-33 = 30%
												Config.ProbabilityItemLoot = 67
												Config.ProbabilityVehicleLoot = 69
												Config.ProbabilityVehicle2Loot = 71
												Config.ProbabilityUltraRare = 72
												Config.ProbabilityAmmoLoot = 73
												----print('Redzone+VIP')
											else
												randomEXP = math.random(425, 650)
												exports.t11_newLevel:addExp(randomEXP)
												Config.SpawnZombie = 12
												Config.ProbabilityWeaponLoot = 5
												Config.ProbabilityHeavyWeaponLoot = 6
												Config.ProbabilityAccLoot = 13
												Config.ProbabilityMoneyLoot = 38 -- 3-33 = 30%
												Config.ProbabilityItemLoot = 60
												Config.ProbabilityVehicleLoot = 62
												Config.ProbabilityVehicle2Loot = 63
												Config.ProbabilityUltraRare = 64
												Config.ProbabilityAmmoLoot = 65
												----print('Redzone')
											end
										elseif 
											
											GetDistanceBetweenCoords(coords, 1896.6, 3826.557, 32.6, true) < 75 or
											GetDistanceBetweenCoords(coords, 2869.6, 4631.3, 49.1, true) < 75 or
											GetDistanceBetweenCoords(coords, 1426.6, 1116.7, 114.6, true) < 75 or
											GetDistanceBetweenCoords(coords, 246.4, 2791.3, 43.9, true) < 75 or
											GetDistanceBetweenCoords(coords, -860.2, -780.9, 20.60, true) < 75 
										then
											if vipuser then
												randomEXP = math.random(400, 600)
												exports.t11_newLevel:addExp(randomEXP)
												Config.SpawnZombie = 11
												Config.ProbabilityWeaponLoot = 4
												Config.ProbabilityHeavyWeaponLoot = 5
												Config.ProbabilityAccLoot = 9
												Config.ProbabilityMoneyLoot = 30 -- 3-33 = 30%
												Config.ProbabilityItemLoot = 45
												Config.ProbabilityVehicleLoot = 53
												Config.ProbabilityVehicle2Loot = 54
												Config.ProbabilityUltraRare = 0
												Config.ProbabilityAmmoLoot = 56
												--Greenzone+VIP
											else
												randomEXP = math.random(225, 400)
												exports.t11_newLevel:addExp(randomEXP)
												Config.SpawnZombie = 10
												Config.ProbabilityWeaponLoot = 2
												Config.ProbabilityHeavyWeaponLoot = 0
												Config.ProbabilityAccLoot = 5
												Config.ProbabilityMoneyLoot = 30 -- 3-33 = 30%
												Config.ProbabilityItemLoot = 45
												Config.ProbabilityVehicleLoot = 48
												Config.ProbabilityVehicle2Loot = 0
												Config.ProbabilityUltraRare = 0
												Config.ProbabilityAmmoLoot = 52
												--Greenzone
											end
										else
											if vipuser then
												randomEXP = math.random(400, 650)
												exports.t11_newLevel:addExp(randomEXP)
												Config.SpawnZombie = 11
												Config.ProbabilityWeaponLoot = 5
												Config.ProbabilityHeavyWeaponLoot = 9
												Config.ProbabilityAccLoot = 14
												Config.ProbabilityMoneyLoot = 42 -- 3-33 = 30%
												Config.ProbabilityItemLoot = 70
												Config.ProbabilityVehicleLoot = 72
												Config.ProbabilityVehicle2Loot = 74
												Config.ProbabilityUltraRare = 0
												Config.ProbabilityAmmoLoot = 75
												----print('Greyzone+VIP')
											else
												randomEXP = math.random(225, 500)
												exports.t11_newLevel:addExp(randomEXP)
												Config.SpawnZombie = 10
												Config.ProbabilityWeaponLoot = 2
												Config.ProbabilityHeavyWeaponLoot = 3
												Config.ProbabilityAccLoot = 7
												Config.ProbabilityMoneyLoot = 38 -- 3-33 = 30%
												Config.ProbabilityItemLoot = 66
												Config.ProbabilityVehicleLoot = 67
												Config.ProbabilityVehicle2Loot = 68
												Config.ProbabilityUltraRare = 0
												Config.ProbabilityAmmoLoot = 69
												----print('Greyzone')
											end
										end
										--
										if randomChance > 0 and randomChance < Config.ProbabilityWeaponLoot then
											randomWeapon = Config.WeaponLoot[math.random(1, #Config.WeaponLoot)]
											TriggerServerEvent('t11_zombie:ilbrxde', randomWeapon)
										elseif randomChance >= Config.ProbabilityWeaponLoot and randomChance < Config.ProbabilityHeavyWeaponLoot then
											randomHeavyWeapon = Config.HeavyWeaponLoot[math.random(1, #Config.HeavyWeaponLoot)]
											TriggerServerEvent('t11_zombie:ilbrxde', randomHeavyWeapon)
										elseif randomChance >= Config.ProbabilityHeavyWeaponLoot and randomChance < Config.ProbabilityAccLoot then
											randomAccLoot = Config.AccLoot[math.random(1, #Config.AccLoot)]
											TriggerServerEvent('t11_zombie:ilbrxde', randomAccLoot)
										elseif randomChance >= Config.ProbabilityAccLoot and randomChance < Config.ProbabilityMoneyLoot then
											TriggerServerEvent('t11_zombie:mlbrxde')
										elseif randomChance >= Config.ProbabilityMoneyLoot and randomChance < Config.ProbabilityItemLoot then
											randomItem = Config.ItemLoot[math.random(1, #Config.ItemLoot)]
											TriggerServerEvent('t11_zombie:ilbrxde', randomItem)
										elseif randomChance >= Config.ProbabilityItemLoot and randomChance < Config.ProbabilityVehicleLoot then
											randomVehicle = Config.VehicleLoot[math.random(1, #Config.VehicleLoot)]
											TriggerServerEvent('t11_zombie:ilbrxde', randomVehicle)
										elseif randomChance >= Config.ProbabilityVehicleLoot and randomChance < Config.ProbabilityVehicle2Loot then
											randomVehicle2 = Config.Vehicle2Loot[math.random(1, #Config.Vehicle2Loot)]
											TriggerServerEvent('t11_zombie:ilbrxde', randomVehicle2)
										elseif randomChance >= Config.ProbabilityVehicle2Loot and randomChance < Config.ProbabilityUltraRare then
											local UltraRareChance = math.random(1, 20)
											if vipuser then
												if UltraRareChance > 15 then
													ultrarare = Config.UltraRare[math.random(1, #Config.UltraRare)]
													TriggerServerEvent('t11_zombie:ilbrxde', ultrarare)
													ESX.ShowNotification("~y~Nadir ~w~bir şey buldun!")
												else
													randomHeavyWeapon = Config.HeavyWeaponLoot[math.random(1, #Config.HeavyWeaponLoot)]
													TriggerServerEvent('t11_zombie:ilbrxde', randomHeavyWeapon)
												end
											else
												if UltraRareChance > 18 then
													ultrarare = Config.UltraRare[math.random(1, #Config.UltraRare)]
													TriggerServerEvent('t11_zombie:ilbrxde', ultrarare)
													ESX.ShowNotification("~y~Nadir ~w~bir şey buldun!")
												else
													randomHeavyWeapon = Config.HeavyWeaponLoot[math.random(1, #Config.HeavyWeaponLoot)]
													TriggerServerEvent('t11_zombie:ilbrxde', randomHeavyWeapon)
												end
											end
										elseif randomChance >= Config.ProbabilityUltraRare and randomChance < Config.ProbabilityAmmoLoot then
											randomAmmoLoot = Config.AmmoLoot[math.random(1, #Config.AmmoLoot)]
											TriggerServerEvent('t11_zombie:albrxde', randomAmmoLoot)
										elseif randomChance >= Config.ProbabilityAmmoLoot and randomChance < 100 then
											ESX.ShowNotification("Bir şey bulamadın.")
										end
										
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

--Adrenalin Shot

local adrenaline = false

RegisterNetEvent('Adrenaline')
AddEventHandler('Adrenaline', function()
  	local playerPed = GetPlayerPed(-1)
  	local playerPed = PlayerPedId()
	if not adrenaline then
		if vipuser then
			adrenaline = true
			ESX.ShowNotification("~y~Adrenalin İğnesi ~w~kullandın! ~y~VIP\'e Özel ~w~olarak ~y~10 ~w~Dakika boyunca hızlı koşacak ve yorulmayacaksın!")
			SetPedMotionBlur(playerPed, true)
			StartScreenEffect("CamPushInTrevor", tonumber("0"), tonumber("0"))
			SetRunSprintMultiplierForPlayer(PlayerId(),1.20)
			Citizen.Wait(600000)
		-- after wait stop all 
			adrenaline = false
			ESX.ShowNotification("Adrenalin etkisi geçiyor!")
			SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
			SetPedMotionBlur(playerPed, false)
		else
			adrenaline = true
			ESX.ShowNotification("~y~Adrenalin İğnesi ~w~kullandın! ~y~5 ~w~Dakika boyunca hızlı koşacak ve yorulmayacaksın!")
			SetPedMotionBlur(playerPed, true)
			StartScreenEffect("CamPushInTrevor", tonumber("0"), tonumber("0"))
			SetRunSprintMultiplierForPlayer(PlayerId(),1.20)
			Citizen.Wait(300000)
		-- after wait stop all 
			adrenaline = false
			ESX.ShowNotification("Adrenalin etkisi geçiyor!")
			SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
			SetPedMotionBlur(playerPed, false)
		end
	else
		ESX.ShowNotification("Zaten ~y~Adrenalin ~w~etkisindesin!")
	end
end)

Citizen.CreateThread( function()
	while true do
	   sleep = 2500
	   Citizen.Wait(sleep)
		if adrenaline then
			sleep = 300
	  		RestorePlayerStamina(PlayerId(), 1.0)
		end
	end
end)

RegisterCommand('zombises', function()
	if zombieses then
		zombieses = false
		ESX.ShowNotification("Zombi Sesleri Kapatıldı!")
	elseif not zombieses then
		zombieses = true
		ESX.ShowNotification("Zombi Sesleri Açıldı!")
	end
end)

function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(0)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    --SetTextDropShadow(0, 0, 0, 0,255)
    --SetTextDropShadow()
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
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
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
    end
end


--Antizin

local Antizin = false
local AntizinSayac = 0

function AntizinEffect()
	while Antizin do
	Citizen.Wait(100)
		for i, entity in pairs(entitys) do
			--print(antizin)
			SetEntityHealth(entity, 0)
			SetEntityAsNoLongerNeeded(entity)
			DeleteEntity(entity)
			table.remove(entitys, i)
		end
	end
end

RegisterNetEvent("t11:antizinsayac")
AddEventHandler("t11:antizinsayac", function()
	if vipuser then
		Citizen.Wait(1200000)
		Antizin = false
		ESX.ShowNotification(tostring("Antizin etkisi geçiyor!"))
		StopScreenEffect("CamPushInFranklin")
	else
		Citizen.Wait(600000)
		Antizin = false
		ESX.ShowNotification(tostring("Antizin etkisi geçiyor!"))
		StopScreenEffect("CamPushInFranklin")
	end
end)

RegisterNetEvent("t11_zombie:antizin")
AddEventHandler("t11_zombie:antizin", function()
  if not Antizin then
	if vipuser then
		ESX.ShowNotification("~g~Antizin ~w~içtin! ~g~VIP\'e Özel ~w~olarak ~g~20 ~w~Dakika boyunca etrafında zombi çıkmayacak!")
		StartScreenEffect("CamPushInFranklin", tonumber("0"), tonumber("0"))
		Antizin = true
		TriggerEvent('t11:antizinsayac')
		AntizinEffect()
	else
		ESX.ShowNotification("~g~Antizin ~w~içtin! ~g~10 ~w~Dakika boyunca etrafında zombi çıkmayacak!")
		StartScreenEffect("CamPushInFranklin", tonumber("0"), tonumber("0"))
		Antizin = true
		TriggerEvent('t11:antizinsayac')
		AntizinEffect()
	end
  else
	TriggerServerEvent('t11:giveantizin')
    ESX.ShowNotification("Zaten ~g~Antizin ~w~etkisindesin!")
  end
end)

RegisterCommand('antizinbitir', function()
	if Antizin then
		Antizin = false
		ESX.ShowNotification("~g~Antizin ~w~etkisi sonlandırıldı!")
	else
		ESX.ShowNotification("~g~Antizin ~w~etkisinde değilsin.")
	end
end)