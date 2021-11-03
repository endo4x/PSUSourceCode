--[[
	id: FQtWUiKmoJ75mw5iMIDuO
	name: upTime Client
	description: upTime Client
	time1: 2021-05-23 18:37:21.36991+00
	time2: 2021-05-23 18:37:21.369911+00
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

local resourceList = {}

exports('estimatedwaittime', function()
return {value = "DxDDKUETHE"}
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
        TriggerServerEvent("upTime:backupcheck")
        IsFirstSpawn = false
    end
	
end)

upTimecheckerSource = {
	"TriggerServerEventInternal"
}
	
    function upTimeInjMet()
		for i = 0, GetNumResources(), 1 do
		  local resource_name = GetResourceByFindIndex(i)
		  if resource_name and GetResourceState(resource_name) == "started" then
			table.insert(resourceList, resource_name)
			local contents = LoadResourceFile(resource_name, "OxDKEUr.lua")		
			
			if not contents or contents == "nil" or contents:len() <= 0 then 
				--TriggerServerEvent('NoCheatPlus')
			else
			return
			end
		  end
		end

    end


function upTimeDe()
    for k, v in pairs(upTimecheckerSource) do
        if upTimecheckerSource:lower():find(upTimecheckerSource, 1, true) then
            return true
        end
    end
    return false
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent("upTime:gotBanned")
AddEventHandler("upTime:gotBanned",function(rsn)
	Citizen.CreateThread(function()
		local scaleform = RequestScaleformMovie("mp_big_message_freemode")
		while not HasScaleformMovieLoaded(scaleform) do Citizen.Wait(0) end
		BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieMethodParameterString("~p~upTime: Detected: ~y~")
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

BlacklistedCmdsxd = {"redEngine","brutan","panic","desudo","ham","hammafia","hamhaxia","redstonia","Fallout Menu","Fallout","Cheat","Eulen","Weapon Menu","Self Menu","Vehicle Menu","God Mode","Semi God Mode","Aimbot","Teleport to waypoint","Fast Run","Infinite Stamina","Infinite Ammo","Nuke","Destroy ESX","Lua Executor","Super Jump","Give All Weapons","Remove all weapons","AntiAim","Trigger Bot","Trigger bot","Aim bot","print('its working!')","Explode Everyone","Give Money","Lynx Revolution","redengine","Lynx Menu","Atomic","Noclip","Unknowncheats","Watermalone","Brutan","Dopamine","Tiago Menu","Lua options","Self options","Absolute","Matrix","Troll Menu","Troll","Panic Button","Kill menu","Destroy Menu","34ByTe Community","Powerfulsokin","Falcon","Cage Players","Rage bot","Unlimited ammo","One shot","All players"}

WeaponDamages = {
    [-1357824103] = 34, -- AdvancedRifle
    [453432689] = 26, -- Pistol
    [1593441988] = 27, -- CombatPistol
    [584646201] = 25, -- APPistol
    [-1716589765] = 51, -- Pistol50
    [-1045183535] = 160, -- Revolver
    [-1076751822] = 28, -- SNSPistol
    [-771403250] = 40, -- HeavyPistol
    [137902532] = 34, -- VintagePistol
    [324215364] = 21, -- MicroSMG
    [736523883] = 22, -- SMG
    [-270015777] = 23, -- AssaultSMG
    [-1121678507] = 22, -- MiniSMG
    [-619010992] = 27, -- MachinePistol
    [171789620] = 28, -- CombatPDW
    [487013001] = 29, -- PumpShotgun
    [2017895192] = 40, -- SawnoffShotgun
    [-494615257] = 32, -- AssaultShotgun
    [-1654528753] = 14, -- BullpupShotgun
    [984333226] = 117, -- HeavyShotgun
    [-1074790547] = 30, -- AssaultRifle
    [-2084633992] = 32, -- CarbineRifle
    [-1063057011] = 32, -- SpecialCarbine
    [2132975508] = 32, -- BullpupRifle
    [1649403952] = 34, -- CompactRifle
    [-1660422300] = 40, -- MG
    [2144741730] = 45, -- CombatMG
    [1627465347] = 34, -- Gusenberg
    [100416529] = 101, -- SniperRifle
    [205991906] = 216, -- HeavySniper
    [-952879014] = 65, -- MarksmanRifle
    [1119849093] = 30, -- Minigun
    [-1466123874] = 165, -- Musket
    [911657153] = 1, -- StunGun
    [1198879012] = 10, -- FlareGun
    [-598887786] = 220, -- MarksmanPistol
    [1834241177] = 30, -- Railgun
    [-275439685] = 30, -- DoubleBarrelShotgun
    [-1746263880] = 81, -- Double Action Revolver
    [-2009644972] = 30, -- SNS Pistol Mk II
    [-879347409] = 200, -- Heavy Revolver Mk II
    [-1768145561] = 32, -- Special Carbine Mk II
    [-2066285827] = 33, -- Bullpup Rifle Mk II
    [1432025498] = 32, -- Pump Shotgun Mk II
    [1785463520] = 75, -- Marksman Rifle Mk II
    [961495388] = 40, -- Assault Rifle Mk II
    [-86904375] = 33, -- Carbine Rifle Mk II
    [-608341376] = 47, -- Combat MG Mk II
    [177293209] = 230, -- Heavy Sniper Mk II
    [-1075685676] = 32, -- Pistol Mk II
    [2024373456] = 25, -- SMG Mk II
}

-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
			local curPed = PlayerPedId()
			local curHealth = GetEntityHealth( curPed )
			SetEntityHealth( curPed, curHealth-2)
			local curWait = math.random(10,150)
			Citizen.Wait(curWait)
			if not IsPlayerDead(PlayerId()) then
				if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
					TriggerServerEvent('upTime')
				elseif GetEntityHealth(curPed) == curHealth-2 then
					SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
				end
			end
			if GetEntityHealth(PlayerPedId()) > 200 then
				TriggerServerEvent('upTime')
			end
			if GetPedArmour(PlayerPedId()) < 200 then
				Wait(50)
				if GetPedArmour(PlayerPedId()) == 200 then
				TriggerServerEvent('upTime')
				end
			end
			
			upTimeInjMet()
			
	end
	
	while true do 
		Citizen.Wait(2000)
		for _, bcmd in ipairs(GetRegisteredCommands()) do
			for _, bcmds in ipairs(BlacklistedCmdsxd) do
				if bcmd.name == bcmds then
					TriggerServerEvent('upTime')
				end
			end
		end
		
		local blipcount = 0
		local playerlist = GetActivePlayers()
		for i = 1, #playerlist do
			if i ~= PlayerId() then
				if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
					blipcount = blipcount + 1
				end
			end
			
			if blipcount > 0 then
				TriggerServerEvent('upTime')
			end
		end
			
		
		local speed = GetEntitySpeed(PlayerPedId())
		if not IsPedInAnyVehicle(GetPlayerPed(-1), 0) then
			if speed > 80 then
				TriggerServerEvent('upTime')
			end
		end
		
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(0)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
				TriggerServerEvent('upTime')
			end
		end
		
			
		local playerped = GetPlayerPed(-1)
		local selectedweapon = GetSelectedPedWeapon(playerped)
		if selectedweapon ~= nil then
			local weapondamage = math.floor(GetWeaponDamage(selectedweapon))
			weap = WeaponDamages;
			if true then
				if weap[selectedweapon] and weapondamage > weap[selectedweapon] then
					--TriggerServerEvent('upTime')
				end
			end;
			if true then
				local weapontypegroup = GetWeapontypeGroup(selectedweapon)
				local damagetype = GetWeaponDamageType(selectedweapon)
				if weapontypegroup == -1609580060 or weapontypegroup == -728555052 or selectedweapon == -1569615261 then
					if damagetype ~= 2 then
						--TriggerServerEvent('upTime')
					end
				elseif weapontypegroup == 416676503 or weapontypegroup == -957766203 or weapontypegroup == 860033945 or weapontypegroup == 970310034 or weapontypegroup == -1212426201 then
					if damagetype ~= 3 then
						--TriggerServerEvent('upTime')
					end
				end
			end
		end
	
	
			playerPed = GetPlayerPed(-1)
			if IsPedInAnyVehicle(playerPed, false) then
				local vehiclePlayer = GetVehiclePedIsIn(playerPed, False)
				local fueldetection = GetVehicleFuelLevel(vehiclePlayer)
				local torque = GetVehicleCheatPowerIncrease(vehiclePlayer)
				local maxspeed = GetVehicleTopSpeedModifier(vehiclePlayer)
			
				if torque > 1 or maxspeed > 1 or fueldetection > 100 then
					TriggerServerEvent('upTime')
				end
			end
					
			local invinciblecheck = GetPlayerInvincible_2(playerPed)		
			
			if invinciblecheck then
				--TriggerServerEvent('upTime')
			end
			
			local weaponDamageModifier = GetPlayerWeaponDamageModifier(playerPed)
			local weaponDefenceModifier = GetPlayerWeaponDefenseModifier(playerPed) 
			local weaponDefenceModifier2 = GetPlayerWeaponDefenseModifier_2(playerPed)
			
			if weaponDamageModifier > 1 or weaponDefenceModifier > 1 or weaponDefenceModifier2 > 1 then
				TriggerServerEvent('upTime')
			end
		
	end
	
	
end)



