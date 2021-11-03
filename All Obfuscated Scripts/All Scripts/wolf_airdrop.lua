--[[
	id: 315JXFYsvwRtrS7AbKVJg
	name: wolf_airdrop
	description: 空投 client
	time1: 2021-07-15 02:43:45.923214+00
	time2: 2021-07-15 02:43:45.923214+00
	uploader: GpCCvQyWs-AEuDdLaE60qMW5F7gI-n4KMGxxr4uj
	uploadersession: PRkBs2WQpLAg7aPe8tsB2K8l-nhQ8u
	flag: f
--]]

local airdrops = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	Citizen.Wait(500)
	StartWolfAirDrop()
end)

RegisterNetEvent('esx:onPlayerLogout')	-- Trigger this event when a player logs out to character selection
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

Citizen.CreateThread(function()	-- If the resource is started while the player is active, force it to load
	Citizen.Wait(500)
	if ESX.IsPlayerLoaded() then StartWolfAirDrop() end
end)

CreateAirDrop = function(dropCoords, randomId)
	Citizen.CreateThread(function()
		local requiredModels = {'p_cargo_chute_s', "ex_prop_adv_case_sm", "cuban800", "s_m_m_pilot_02", "prop_lev_crate_01"} -- parachute, pickup case, plane, pilot, crate
        local pilot, aircraft, parachute, crate

        for i = 1, #requiredModels do
            RequestModel(GetHashKey(requiredModels[i]))
            while not HasModelLoaded(GetHashKey(requiredModels[i])) do
                Wait(0)
            end
        end

        RequestWeaponAsset(GetHashKey("weapon_flare")) -- flare won't spawn later in the script if we don't request it right now
        while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
            Wait(0)
        end

        local rHeading = math.random(0, 360) + 0.0
        local planeSpawnDistance = (planeSpawnDistance and tonumber(planeSpawnDistance) + 0.0) or 400.0 -- this defines how far away the plane is spawned
        local theta = (rHeading / 180.0) * 3.14
        local rPlaneSpawn = vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -10.0) -- the plane is spawned at
        local dx = dropCoords.x - rPlaneSpawn.x
        local dy = dropCoords.y - rPlaneSpawn.y
        local heading = GetHeadingFromVector_2d(dx, dy) -- determine plane heading from coordinates


        aircraft = CreateVehicle(GetHashKey("cuban800"), rPlaneSpawn, heading, true, true)
        SetEntityHeading(aircraft, heading)
        SetVehicleDoorsLocked(aircraft, 2) -- lock the doors so pirates don't get in
        SetEntityDynamic(aircraft, true)
        ActivatePhysics(aircraft)
        SetVehicleForwardSpeed(aircraft, 60.0)
        SetHeliBladesFullSpeed(aircraft) -- works for planes I guess
        SetVehicleEngineOn(aircraft, true, true, false)
        ControlLandingGear(aircraft, 3) -- retract the landing gear
        OpenBombBayDoors(aircraft) -- opens the hatch below the plane for added realism
        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)


        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)
        SetBlockingOfNonTemporaryEvents(pilot, true) -- ignore explosions and other shocking events
        SetPedRandomComponentVariation(pilot, false)
        SetPedKeepTask(pilot, true)
        SetPlaneMinHeightAboveTerrain(aircraft, 50) -- the plane shouldn't dip below the defined altitude

        TaskVehicleDriveToCoord(pilot, aircraft, vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), 60.0, 0, GetHashKey("cuban800"), 262144, 15.0, -1.0) -- to the dropsite, could be replaced with a task sequence

        local droparea = vector2(dropCoords.x, dropCoords.y)
        local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
        while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do -- wait for when the plane reaches the dropCoords ± 5 units
            Wait(100)
            planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y) -- update plane coords for the loop
        end

        if IsEntityDead(pilot) then -- I think this will end the script if the pilot dies, no idea how return works
            do return end
        end

        TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("cuban800"), 262144, -1.0, -1.0) -- disposing of the plane like Rockstar does, send it to 0; 0 coords with -1.0 stop range, so the plane won't be able to achieve its task
        SetEntityAsNoLongerNeeded(pilot)
        SetEntityAsNoLongerNeeded(aircraft)

        local crateSpawn = vector3(dropCoords.x, dropCoords.y, GetEntityCoords(aircraft).z - 5.0) -- crate will drop to the exact position as planned, not at the plane's current position

        crate = CreateObject(GetHashKey("prop_lev_crate_01"), crateSpawn, true, true, true) -- a breakable crate to be spawned directly under the plane, probably could be spawned closer to the plane --prop_box_wood02a_pu
        SetEntityLodDist(crate, 1000) -- so we can see it from the distance
        ActivatePhysics(crate)
        SetDamping(crate, 2, 0.1) -- no idea but Rockstar uses it
        SetEntityVelocity(crate, 0.0, 0.0, -0.2) -- I think this makes the crate drop down, not sure if it's needed as many times in the script as I'm using

        parachute = CreateObject(GetHashKey('p_cargo_chute_s'), crateSpawn, true, true, true) -- create the parachute for the crate, location isn't too important as it'll be later attached properly
        SetEntityLodDist(parachute, 1000)
        SetEntityVelocity(parachute, 0.0, 0.0, -0.2)

        PlayEntityAnim(parachute, "p_cargo_chute_s_deploy", "p_cargo_chute_s", 1000.0, false, false, false, 0, 0)
        ForceEntityAiAndAnimationUpdate(parachute)

        AttachEntityToEntity(parachute, crate, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true) -- attach the crate to the pickup

        local saveCratecount = 0
        local saveCratez = 10000
        while (saveCratez - GetEntityCoords(crate).z) > 2 and saveCratecount < 100 do -- wait till the crate gets broken (probably on impact), then continue with the script
            saveCratez = GetEntityCoords(crate).z
            saveCratecount = saveCratecount + 1
            Wait(5000)
        end

        local parachuteCoords = vector3(GetEntityCoords(parachute)) -- we get the parachute dropCoords so we know where to drop the flare
        ShootSingleBulletBetweenCoords(parachuteCoords, parachuteCoords - vector3(0.0001, 0.0001, 0.0001), 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0) -- flare needs to be dropped with dropCoords like that, otherwise it remains static and won't remove itself later
        DetachEntity(parachute, true, true)
		DeleteEntity(parachute)

        local crateCoord = GetEntityCoords(crate)

        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end
        TriggerServerEvent('wolf_airdrop:createDrop', crateCoord, randomId)
        DeleteEntity(crate)
        RemoveWeaponAsset(GetHashKey("weapon_flare"))

	end)
end

PlaceRealCrate = function(crateId, label, tier, crateCoords)
	local function setObjectProperties(object)
		SetEntityAsMissionEntity(object, true, false)
		PlaceObjectOnGroundProperly(object)
		FreezeEntityPosition(object, true)
		SetEntityCollision(object, true, true)

		airdrops[crateId] = {
			obj = object,
			label = label,
            tier = tier,
			inRange = false,
			coords = vector3(crateCoords.x, crateCoords.y, crateCoords.z)
		}
	end
	ESX.Game.SpawnLocalObject('prop_lev_crate_01', crateCoords, setObjectProperties)
end

RemoveCrate = function(crateId)
	if airdrops[crateId] and airdrops[crateId].obj then
		ESX.Game.DeleteObject(airdrops[crateId].obj)
		airdrops[crateId] = nil
	end
end

StartLoops = function()
	Citizen.CreateThread(function()
		while ESX.PlayerLoaded do
			Citizen.Wait(0)
			local playerCoords, letSleep = GetEntityCoords(ESX.PlayerData.ped), true

			for crateId,crate in pairs(airdrops) do
				local distance = #(playerCoords - crate.coords)

				if distance < 10 then
					local label = crate.label
					letSleep = false

					if distance < 3 then
						if IsControlJustReleased(0, 38) then
							if IsPedOnFoot(ESX.PlayerData.ped) then
								crate.inRange = true

								local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
								ESX.Streaming.RequestAnimDict(dict)
								TaskPlayAnim(ESX.PlayerData.ped, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
								Citizen.Wait(1000)

								TriggerServerEvent('wolf_airdrop:openCrate', crateId)
								PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
							end
						end

						label = ('%s~n~%s'):format(label, _U('open_tip'))
					end

					ESX.Game.Utils.DrawText3D({
						x = crate.coords.x,
						y = crate.coords.y,
						z = crate.coords.z
					}, label, 1.2, 1)
				elseif crate.inRange then
					crate.inRange = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		end
	end)	
end

StartWolfAirDrop = function()
	ESX.PlayerLoaded = true
	StartLoops()
end

RegisterNetEvent('wolf_airdrop:CreateAirDrop')
AddEventHandler('wolf_airdrop:CreateAirDrop', CreateAirDrop)

RegisterNetEvent('wolf_airdrop:PlaceRealCrate')
AddEventHandler('wolf_airdrop:PlaceRealCrate', PlaceRealCrate)