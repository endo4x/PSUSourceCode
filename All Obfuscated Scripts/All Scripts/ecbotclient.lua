--[[
	id: S_pT05HQgpOLZi2N0-Iz2
	name: ecbotclient
	description: ecbotclient
	time1: 2021-04-28 06:07:21.373181+00
	time2: 2021-04-28 06:07:21.373181+00
	uploader: ak0lGyLZ6GFw-6RsuD4MS7dWYDsbhNfcBEH9xwNG
	uploadersession: Cx7wE-WQ390wuIPtgBTToCCd7m_qDA
	flag: f
--]]

ESX                           = nil
local PlayerData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
	TriggerServerEvent("esx:playerconnected")


end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    local lastPedAimed

    while true do
        Citizen.Wait(1000)
        local letSleep = true
        local playerPed = PlayerPedId()
        if DoesEntityExist(playerPed) then
            if IsPedArmed(playerPed, 4) then
                letSleep = false

                local isAiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
                if isAiming and targetPed ~= lastPedAimed then
                    lastPedAimed = targetPed

                    if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) then
                        if IsPedAPlayer(targetPed) then
                            local targetId = NetworkGetPlayerIndexFromPed(targetPed)

                            if targetId then
                                local pedId = GetPlayerServerId(targetId)
                                
                                if pedId and (pedId > 0) then
                                    TriggerServerEvent('aimlogs:log', pedId)
                                end
                            end
                        end
                    end
                end
            end
        end

        if letSleep then
            Wait(1000)
        end
    end 
end)


Citizen.CreateThread(function()
	local DeathReason, Killer, DeathCauseHash, Weapon

	while true do
		Citizen.Wait(5)
		if IsEntityDead(PlayerPedId()) then
			Citizen.Wait(500)
			local PedKiller = GetPedSourceOfDeath(PlayerPedId())
			DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			Weapon = WeaponNames[tostring(DeathCauseHash)]

			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
			end
			
			if (Killer == PlayerId()) then
				DeathReason = '自殺'
			elseif (Killer == nil) then
				DeathReason = '死亡'
			else
				if IsMelee(DeathCauseHash) then
					DeathReason = 'murdered'
				elseif IsTorch(DeathCauseHash) then
					DeathReason = 'torched'
				elseif IsKnife(DeathCauseHash) then
					DeathReason = 'knifed'
				elseif IsPistol(DeathCauseHash) then
					DeathReason = 'pistoled'
				elseif IsSub(DeathCauseHash) then
					DeathReason = 'riddled'
				elseif IsRifle(DeathCauseHash) then
					DeathReason = 'rifled'
				elseif IsLight(DeathCauseHash) then
					DeathReason = 'machine gunned'
				elseif IsShotgun(DeathCauseHash) then
					DeathReason = 'pulverized'
				elseif IsSniper(DeathCauseHash) then
					DeathReason = 'sniped'
				elseif IsHeavy(DeathCauseHash) then
					DeathReason = 'obliterated'
				elseif IsMinigun(DeathCauseHash) then
					DeathReason = 'shredded'
				elseif IsBomb(DeathCauseHash) then
					DeathReason = 'bombed'
				elseif IsVeh(DeathCauseHash) then
					DeathReason = 'mowed over'
				elseif IsVK(DeathCauseHash) then
					DeathReason = 'flattened'
				else
					DeathReason = 'killed'
				end
			end
			
			if DeathReason == '自殺' or DeathReason == '死亡' then
				TriggerServerEvent('DiscordBot:playerDied', GetPlayerName(PlayerId()) .. ' ' .. DeathReason, Weapon,nil)
			else
				TriggerServerEvent('DiscordBot:playerDied', GetPlayerName(Killer) .. ' ' .. DeathReason .. ' ' .. GetPlayerName(PlayerId()) .. '.', Weapon,GetPlayerServerId(Killer))
			end
			Killer = nil
			DeathReason = nil
			DeathCauseHash = nil
			Weapon = nil
		end
		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(5)
		end
	end
end)

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

RegisterNetEvent('ecbot:screenshot')
AddEventHandler('ecbot:screenshot', function(name)
  exports['screenshot-basic']:requestScreenshotUpload(Discordscreenshot, 'files[]', function(data)
  local image = json.decode(data)
  TriggerServerEvent('DiscordBot:test', Discordscreenshot2, 'ScreenShot', '**管理員執行:** '..name,'**玩家名稱:** '..GetPlayerName(PlayerId())..'\n**玩家ID: **'..GetPlayerServerId(PlayerId()), 16753920,image.attachments[1].url)
  end)
end)

function screenshottriggerkey(key)
  exports['screenshot-basic']:requestScreenshotUpload(Discordscreenshot, 'files[]', function(data)
  local image = json.decode(data)
  TriggerServerEvent('DiscordBot:test', Discordscreenshot2, 'ScreenShot', '**觸發Key:** '..key,'**玩家名稱:** '..GetPlayerName(PlayerId())..'\n**玩家ID: **'..GetPlayerServerId(PlayerId()), 16753920,image.attachments[1].url)
  end)
end

Citizen.CreateThread(function()
	local nowtest = screenshotkey
	while true do
		Citizen.Wait(0)
		for i in pairs(nowtest) do
			if IsControlJustPressed(0, nowtest[i]) then
				screenshottriggerkey(nowtest[i])
			end
		end
	end
end)

-- RegisterCommand('screen', function()
    -- exports['screenshot-basic']:requestScreenshot(function(data)
        -- TriggerEvent('chat:addMessage', { template = '<img src="{0}" style="max-width: 300px;" />', args = { data } })
    -- end)
-- end)