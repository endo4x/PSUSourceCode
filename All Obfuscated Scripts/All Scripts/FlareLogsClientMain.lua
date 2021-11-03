--[[
	id: VgF-xr50kV0ujxrgBE3oE
	name: FlareLogs Client Main
	description: FlareLogs Client Main
	time1: 2021-04-23 14:51:29.384705+00
	time2: 2021-04-23 14:51:29.384706+00
	uploader: tSbAvUajQsu9yW5a9YXFmo8HYkBudZ3VI6Z6XhG8
	uploadersession: xlYitmxkVZPuv187Kd8BoaxCGVLPEr
	flag: f
--]]

ESX                    = nil
local PlayerData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function sanitize(string)
    return string:gsub('%@', '')
end

exports('sanitize', function(string)
    sanitize(string)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
	TriggerServerEvent("esx:playerconnected")
end)

AddEventHandler("playerSpawned", function(spawn)
    if IsFirstSpawn and Config.backup_kick_method then
        TriggerServerEvent("el_bwh:backupcheck")
        IsFirstSpawn = false
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local isJacking = true
local isStolen = true
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsPedInAnyVehicle(GetPlayerPed(-1)))then
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
			if(IsVehicleStolen(vehicle) and isStolen )then
				Wait(1000)
				TriggerServerEvent("esx:jackingcar",GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
				isStolen = false
			end
		else
			isStolen = true
			vehicle = nil
		end

		if(IsPedJacking(GetPlayerPed(-1))) then
				if(settings.LogPedJacking == true and isJacking) then
					local playerPed = GetPlayerPed(-1)
					local coords    = GetEntityCoords(playerPed)

					local vehicle = nil

					if IsPedInAnyVehicle(playerPed) then
						vehicle = GetVehiclePedIsIn(playerPed)

					else
						vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)

					end
					Wait(1000)
					TriggerServerEvent("esx:jackingcar",GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

					isJacking = false
					vehicle = nil

				end
		else
			isJacking = true
		end




	end
end)





local isIncarPolice = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
				if(settings.LogEnterPoliceVehicle == true and not isIncarPolice and PlayerData.job.name ~= "police") then
					TriggerServerEvent("esx:enterpolicecar",GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))
					isIncarPolice = true
				end

		else
			isIncarPolice = false
		end

	end
end)




local isIncar = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)


		if(IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then

				if(settings.LogEnterPoliceVehicle == true and not isIncar) then

					for i=1, #blacklistedModels, 1 do

						if(blacklistedModels[i] == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))then
							TriggerServerEvent("esx:enterblacklistedcar",GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))
							isIncar = true
						end
					end
				end
		else
			isIncar = false
		end

	end
end)



WeaponNames = {
	[tostring(GetHashKey('WEAPON_UNARMED'))] = 'Ongewapend',
	[tostring(GetHashKey('GADGET_PARACHUTE'))] = 'Parachute',
	[tostring(GetHashKey('WEAPON_KNIFE'))] = 'Mes',
	[tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Gummi knuppel',
	[tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hamer',
	[tostring(GetHashKey('WEAPON_BAT'))] = 'Honkbalknuppel',
	[tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Koevoet',
	[tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
	[tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Fles',
	[tostring(GetHashKey('WEAPON_DAGGER'))] = 'Antieke cavalerie dolk',
	[tostring(GetHashKey('WEAPON_HATCHET'))] = 'Bijl',
	[tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Boksbeugel',
	[tostring(GetHashKey('WEAPON_MACHETE'))] = 'Kapmes',
	[tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Zaklamp',
	[tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switchblade',
	[tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Strijdbijl',
	[tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Pool keu',
	[tostring(GetHashKey('WEAPON_PIPEWRENCH'))] = 'Moersleutel',
	[tostring(GetHashKey('WEAPON_STONE_HATCHET'))] = 'Stenen bijl',

	[tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistool',
	[tostring(GetHashKey('WEAPON_PISTOL_MK2'))] = 'Pistool Mk2',
	[tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistool',
	[tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistool .50	',
	[tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistool',
	[tostring(GetHashKey('WEAPON_SNSPISTOL_MK2'))] = 'SNS Pistool Mk2',
	[tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistool',
	[tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistool',
	[tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistool',
	[tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Heavy Revolver',
	[tostring(GetHashKey('WEAPON_REVOLVER_MK2'))] = 'Heavy Revolver Mk2',
	[tostring(GetHashKey('WEAPON_DOUBLEACTION'))] = 'Double-Action Revolver',
	[tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistool',
	[tostring(GetHashKey('WEAPON_STUNGUN'))] = 'Taser',
	[tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare-pistool (CloudFlare/GroundFlare Pistool)',
	[tostring(GetHashKey('WEAPON_RAYPISTOL'))] = 'Up-n-Atomizer',

	[tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
	[tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machinegeweer',
	[tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
	[tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
	[tostring(GetHashKey('WEAPON_SMG_MK2'))] = 'SMG Mk2	',
	[tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
	[tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
	[tostring(GetHashKey('WEAPON_MG'))] = 'MG',
	[tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG	',
	[tostring(GetHashKey('WEAPON_COMBATMG_MK2'))] = 'Combat MG Mk2',
	[tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg Sweeper',
	[tostring(GetHashKey('WEAPON_RAYCARBINE'))] = 'Onheilige Doodbrenger',

	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE_MK2'))] = 'Assault Rifle Mk2',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE_MK2'))] = 'Carbine Rifle Mk2',
	[tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE_MK2'))] = 'Special Carbine Mk2',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE_MK2'))] = 'Bullpup Rifle Mk2',
	[tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',

	[tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER_MK2'))] = 'Heavy Sniper Mk2',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE_MK2'))] = 'Marksman Rifle Mk2',

	[tostring(GetHashKey('WEAPON_GRENADE'))] = 'Granaat',
	[tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'C4',
	[tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Mijn (Proximity C4)',
	[tostring(GetHashKey('WAPAON_PIPEBOMB'))] = 'Pijpbom',
	[tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Traangas',
	[tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
	[tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
	[tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Brandblusser',
	[tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerrycan',
	[tostring(GetHashKey('WEAPON_BALL'))] = 'Bal',
	[tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Sneeuwbal',
	[tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',

	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
	[tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
	[tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
	[tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
	[tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
	[tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RAYMINIGUN'))] = 'Widowmaker',

	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN_MK2'))] = 'Pump Shotgun Mk2',
	[tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-off Shotgun',
	[tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
	[tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
	[tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
	[tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
	[tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
	[tostring(GetHashKey('WEAPON_SWEEPERSHOTGUN'))] = 'Sweeper Shotgun',

	[tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Rookgranaatwerper',
	[tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
	[tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
	[tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [voertuig]',
	[tostring(GetHashKey('OBJECT'))] = 'Object',
	[tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tankkanon',
	[tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Raketten',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
	[tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
	[tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Geramd door een auto',
	[tostring(GetHashKey('WEAPON_FIRE'))] = 'Vuur',
	[tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Heli Crash',
	[tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Overreden door een auto',
	[tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Geraakt door waterkanon (Eindhoven)',
	[tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Uitputting',
	[tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosie',
	[tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Elektrisch hek',
	[tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bloeden',
	[tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Verdinking in auto',
	[tostring(GetHashKey('WEAPON_DROWNING'))] = 'Verdrinken',
	[tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Prikkeldraad',
	[tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Voertuig Raketten',
	[tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Wieken',
	[tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Luchtverdedigingskanon',
	[tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Dier',
	[tostring(GetHashKey('WEAPON_COUGAR'))] = 'Poema'
}


Citizen.CreateThread(function()
	local DeathReason, Killer, DeathCauseHash, Weapon

	while true do
		Citizen.Wait(0)
		if IsEntityDead(PlayerPedId()) then
			Citizen.Wait(500)
			local PedKiller = GetPedSourceOfDeath(PlayerPedId())
			local killername = GetPlayerName(PedKiller)
			DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			Weapon = WeaponNames[tostring(DeathCauseHash)]

			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
			end

			if (Killer == PlayerId()) then
				DeathReason = 'heeft zelfmoord gepleegd'
			elseif (Killer == nil) then
				DeathReason = 'stierf'
			else
				if IsMelee(DeathCauseHash) then
					DeathReason = 'vermoord'
				elseif IsTorch(DeathCauseHash) then
					DeathReason = 'verbrand'
				elseif IsKnife(DeathCauseHash) then
					DeathReason = 'neergestoken'
				elseif IsPistol(DeathCauseHash) then
					DeathReason = 'neergeschoten'
				elseif IsSub(DeathCauseHash) then
					DeathReason = 'doorzeven'
				elseif IsRifle(DeathCauseHash) then
					DeathReason = 'rifled'
				elseif IsLight(DeathCauseHash) then
					DeathReason = 'machine gunned'
				elseif IsShotgun(DeathCauseHash) then
					DeathReason = 'verpulverd'
				elseif IsSniper(DeathCauseHash) then
					DeathReason = 'gesniped'
				elseif IsHeavy(DeathCauseHash) then
					DeathReason = 'vernietigd'
				elseif IsMinigun(DeathCauseHash) then
					DeathReason = 'aan repen gesneden'
				elseif IsBomb(DeathCauseHash) then
					DeathReason = 'gebombardeerd'
				elseif IsVeh(DeathCauseHash) then
					DeathReason = 'gemaaid'
				elseif IsVK(DeathCauseHash) then
					DeathReason = 'met de grond gelijk gemaakt'
				else
					DeathReason = 'gedood'
				end
			end

			if DeathReason == 'heeft zelfmoord gepleegd' or DeathReason == 'stierf' then
				TriggerServerEvent('playerDied',1,PlayerId(),_Killer,DeathReason,Weapon)
					if Weapon then _Weapon = Weapon else _Weapon = "N/A" end if Killer then _killer = Killer else _killer = "N/A" end
			else
				TriggerServerEvent('playerDied',2,PlayerId(),GetPlayerServerId(Killer),DeathReason,Weapon)
					if Weapon then _Weapon = Weapon else _Weapon = "N/A" end if Killer then _killer = Killer else _killer = "N/A" end
			end
			Killer = nil
			DeathReason = nil
			DeathCauseHash = nil
			Weapon = nil
		end
		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(0)
		end
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		local playerped = GetPlayerPed(-1)

		if IsPedShooting(playerped) then
			TriggerServerEvent('playerShotWeapon', WeaponNames[tostring(GetSelectedPedWeapon(playerped))])
			Citizen.Wait(0)
		end
	end

end)

function hashToWeapon(hash)
	return weapons[hash]
end


function IsMelee(Weapon)
	local Weapons = {'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsTorch(Weapon)
	local Weapons = {'WEAPON_MOLOTOV'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsKnife(Weapon)
	local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsPistol(Weapon)
	local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSub(Weapon)
	local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRifle(Weapon)
	local Weapons = {'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsLight(Weapon)
	local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsShotgun(Weapon)
	local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSniper(Weapon)
	local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsHeavy(Weapon)
	local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsMinigun(Weapon)
	local Weapons = {'WEAPON_MINIGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsBomb(Weapon)
	local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVeh(Weapon)
	local Weapons = {'VEHICLE_WEAPON_ROTORS'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVK(Weapon)
	local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end



function GetPlayerByEntityID(id)
	for i=0,256 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end











RegisterNetEvent("el_bwh:gotBanned")
AddEventHandler("el_bwh:gotBanned",function(rsn)
	Citizen.CreateThread(function()
		local scaleform = RequestScaleformMovie("mp_big_message_freemode")
		while not HasScaleformMovieLoaded(scaleform) do Citizen.Wait(0) end
		BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieMethodParameterString("~r~BANNED")
		PushScaleformMovieMethodParameterString(rsn)
		PushScaleformMovieMethodParameterInt(5)
		EndScaleformMovieMethod()
		PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS")
		ClearDrawOrigin()
		ESX.UI.HUD.SetDisplay(0)
		while true do
			Citizen.Wait(0)
			DisableAllControlActions(0)
			DisableFrontendThisFrame()
			local ped = GetPlayerPed(-1)
			ESX.UI.Menu.CloseAll()
			SetEntityCoords(ped, 0, 0, 0, 0, 0, 0, false)
			FreezeEntityPosition(ped, true)
			DrawRect(0.0,0.0,2.0,2.0,0,0,0,255)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
		SetScaleformMovieAsNoLongerNeeded(scaleform)
	end)
end)

RegisterNetEvent("mother_fucker2:stopscript")
AddEventHandler('mother_fucker2:stopscript', function()

    if (GetCurrentResourceName() == "FlareLogs") then

        print('working')

    else
       StopResource(GetCurrentResourceName())
        print('notworking')

    end

end)
