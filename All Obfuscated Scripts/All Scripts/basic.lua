--[[
	id: d76V0GUPUtXcv7nP0lrwQ
	name: basic
	description: basic
	time1: 2021-05-17 11:52:54.902576+00
	time2: 2021-05-17 11:52:54.902577+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

--==--==--==--==--==--==--==--==
-- Here We Go :)  :* - TEST11 --
--==--==--==--==--==--==--==--==

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

------------------------BLIPS

local blips = {
	{title="Church",colour = 47, id = 305, x = -1678.865,  y = -297.577,  z = 51.81211},
}      

Citizen.CreateThread(function()
      for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.7)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
      end
end)

--OYNUYORDC

Citizen.CreateThread(function()
	while true do			
		SetDiscordAppId(798967162818789446)
		SetDiscordRichPresenceAsset('reborns3')
		SetRichPresence('ID:' .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) .. ' | ' .. GetPlayerName(PlayerId()) .. ' | REBORN ZOMBIE 3. SEZON')
        SetDiscordRichPresenceAssetText('reborns3')
		Citizen.Wait(7*1000)
	end
end)

------------------------THUMBNAIL

AddEventHandler('onClientMapStart', function()
    Citizen.CreateThread(function()
      local display = true
  
      TriggerEvent('logo:display', true)
    end)
  end)
  
  RegisterNetEvent('logo:display')
  AddEventHandler('logo:display', function(value)
    SendNUIMessage({
      type = "logo",
      display = value
    })
  end)
  
  function ShowInfo(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
  end

  -------------------------------

local crouched = false
local InAction = false
local mp_pointing = false
local keyPressed = false
local isDead = false
local zirhGiyildi = false
local zirhKontrolSuresi = 60000
announcestring = false
lastfor = 5

------------İŞARETET

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    --SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing",0.70, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    --SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(5)
        if once then
            once = false
        end
        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
				if IsPedArmed(GetPlayerPed(-1), 7) then
				else
					Wait(200)
					if not IsControlPressed(0, 29) then
						keyPressed = true
						startPointing()
						mp_pointing = true
					else
						keyPressed = true
						while IsControlPressed(0, 29) do
							Wait(50)
						end
					end
				end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)

---------------ZIRH

RegisterNetEvent('sb_armour:armor')
AddEventHandler('sb_armour:armor', function()
	local playerPed = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(playerPed)
    if Config.debugSystem == 1 then
        TriggerServerEvent('SB:debugSystem',false,"sb_armour","sb_armour:armor",0,"client")
    end
      
    if GetPedArmour(GetPlayerPed(-1)) == 50 then
        ESX.ShowNotification("Zaten zırhın var!")
    else
		if IsPedInAnyVehicle(playerPed) then 
			if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) or (GetPedInVehicleSeat(veh, 0) == GetPlayerPed(-1)) or (GetPedInVehicleSeat(veh, 1) == GetPlayerPed(-1)) or (GetPedInVehicleSeat(veh, 2) == GetPlayerPed(-1)) then
				TriggerServerEvent('sb_armour:armorremove')
				TriggerEvent("mythic_progbar:client:progress", {
					name = "armor_giyme",
					duration = 5000,
					label = "Zırh Giyiliyor...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missheistdockssetup1clipboard@idle_a",
						anim = "idle_a",
					},
				}, function(status)
					if not status then        
						SetPedArmour(GetPlayerPed(-1), 0)
						ClearPedBloodDamage(GetPlayerPed(-1))
						ResetPedVisibleDamage(GetPlayerPed(-1))
						ClearPedLastWeaponDamage(GetPlayerPed(-1))
						ResetPedMovementClipset(GetPlayerPed(-1), 0)

						
						SetPedArmour(GetPlayerPed(-1), 50)
						StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
						ESX.ShowNotification("Zırh Giyildi!")
						zirhGiyildi = true
					else
						StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
						Citizen.Wait(500)
						TriggerServerEvent('sb_armour:armoradd')
					end
				end)   
			else
				ESX.ShowNotification("Bunu bu koltukta yapamazsın.")
			end 
		else
			
			TriggerServerEvent('sb_armour:armorremove')
			TriggerEvent("mythic_progbar:client:progress", {
				name = "armor_giyme",
				duration = 5000,
				label = "Zırh Giyiliyor...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a",
				},
			}, function(status)
				if not status then        
					SetPedArmour(GetPlayerPed(-1), 0)
					ClearPedBloodDamage(GetPlayerPed(-1))
					ResetPedVisibleDamage(GetPlayerPed(-1))
					ClearPedLastWeaponDamage(GetPlayerPed(-1))
					ResetPedMovementClipset(GetPlayerPed(-1), 0)

					
					SetPedArmour(GetPlayerPed(-1), 50)
					StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
					ESX.ShowNotification("Zırh Giyildi!")
					zirhGiyildi = true
				else
					StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
					Citizen.Wait(500)
					TriggerServerEvent('sb_armour:armoradd')
				end
			end)
		end
		if Config.ZirhGiy == 1 then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 11,  ['bproof_2'] = 1})
				else
					TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 13,  ['bproof_2'] = 1})
					
				end
			end)
		end
  	end
end)

RegisterNetEvent('sb_armour:heavyarmor')
AddEventHandler('sb_armour:heavyarmor', function()
	local playerPed = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(playerPed)
    if Config.debugSystem == 1 then
        TriggerServerEvent('SB:debugSystem',false,"sb_armour","sb_armour:heavyarmor",0,"client")
    end
      
    if GetPedArmour(GetPlayerPed(-1)) == 100 then
        ESX.ShowNotification("Zaten zırhın var!")
    else
		if IsPedInAnyVehicle(playerPed) then 
			if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) or (GetPedInVehicleSeat(veh, 0) == GetPlayerPed(-1)) or (GetPedInVehicleSeat(veh, 1) == GetPlayerPed(-1)) or (GetPedInVehicleSeat(veh, 2) == GetPlayerPed(-1)) then
				TriggerServerEvent('sb_armour:heavyarmorremove')
				TriggerEvent("mythic_progbar:client:progress", {
					name = "armor_giyme",
					duration = 15000,
					label = "Zırh Giyiliyor...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missheistdockssetup1clipboard@idle_a",
						anim = "idle_a",
					},
				}, function(status)
					if not status then
						SetPedArmour(GetPlayerPed(-1), 0)
						ClearPedBloodDamage(GetPlayerPed(-1))
						ResetPedVisibleDamage(GetPlayerPed(-1))
						ClearPedLastWeaponDamage(GetPlayerPed(-1))
						ResetPedMovementClipset(GetPlayerPed(-1), 0)

						
						StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
						SetPedArmour(GetPlayerPed(-1), 100)
						ESX.ShowNotification("Ağır Zırh Giyildi!")
						zirhGiyildi = true
					else
						StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
						Citizen.Wait(500)
						TriggerServerEvent('sb_armour:heavyarmoradd')
					end
				end)    
			else
				ESX.ShowNotification("Bunu bu koltukta yapamazsın.")
			end 
		else
			TriggerServerEvent('sb_armour:heavyarmorremove')
				TriggerEvent("mythic_progbar:client:progress", {
					name = "armor_giyme",
					duration = 15000,
					label = "Zırh Giyiliyor...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missheistdockssetup1clipboard@idle_a",
						anim = "idle_a",
					},
				}, function(status)
					if not status then
						SetPedArmour(GetPlayerPed(-1), 0)
						ClearPedBloodDamage(GetPlayerPed(-1))
						ResetPedVisibleDamage(GetPlayerPed(-1))
						ClearPedLastWeaponDamage(GetPlayerPed(-1))
						ResetPedMovementClipset(GetPlayerPed(-1), 0)

						
						StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
						SetPedArmour(GetPlayerPed(-1), 100)
						ESX.ShowNotification("Ağır Zırh Giyildi!")
						zirhGiyildi = true
					else
						StopAnimTask(PlayerPedId(), 'missheistdockssetup1clipboard@idle_a', 'idle_a', 1.0)
						Citizen.Wait(500)
						TriggerServerEvent('sb_armour:heavyarmoradd')
					end
				end) 
			end
		if Config.ZirhGiy == 1 then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 11,  ['bproof_2'] = 1})
				else
					TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 13,  ['bproof_2'] = 1})
					
				end
			end)
		end
    --SetPedArmour(GetPlayerPed(-1), 100)
    --zirhGiyildi = true
  	end
end)

RegisterNetEvent('F3:firstArmour')
AddEventHandler('F3:firstArmour', function(parameter)
    if Config.debugSystem == 1 then
        TriggerServerEvent('SB:debugSystem',false,"sb_armour","F3:firstArmour",0,"client")
    end
    Citizen.Wait(7500)
    local zirh = parameter
    SetPedArmour(GetPlayerPed(-1),zirh)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if zirhGiyildi then
            --print("Zirh Giyildi")
            TriggerServerEvent('F3:sendArmourData', GetPedArmour(PlayerPedId()))
            Citizen.Wait(zirhKontrolSuresi)
        end
    end
end)

----------------ÇÖMELME

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 2 )
        local ped = GetPlayerPed(-1)

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( crouched == true ) then 
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false 
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end )

-------------------DUYURU

RegisterNetEvent('announce')
announcestring = false
AddEventHandler('announce', function(msg)
	announcestring = msg
	PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
	Citizen.Wait(lastfor * 1000)
	announcestring = false
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~y~DUYURU")
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		if announcestring then
			scaleform = Initialize("mp_big_message_freemode")
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	end
end)

----------YAN KOLTUK SCRIPTI

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("yan", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it

--KILLER

RegisterNetEvent('showNotification')
AddEventHandler('showNotification', function(text)
	ShowNotification(text)
end)
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end
Citizen.CreateThread(function()
    -- main loop thing
	alreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and not alreadyDead then
			killer = GetPedKiller(playerPed)
			killername = false
			for _, player in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(player) and GetPlayerPed(player) ~= PlayerPedId() then
					if killer == GetPlayerPed(player) then
						killername = GetPlayerName(player)
					end		
				end		
			end
			if killer == playerPed then
				TriggerServerEvent('playerDied',0,0)
			elseif killername then
				TriggerServerEvent('playerDied',killername,1)
			end
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
	end
end)

--NOSIREN

SirenToggle = false
Citizen.CreateThread(function()
	while true do
   		sleep = 1000
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			sleep = 2
			if IsControlJustPressed(1, 86) then
				Vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
				if GetPedInVehicleSeat(Vehicle, -1) == GetPlayerPed(-1) then                      
					PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
					SirenToggle = true
					TriggerServerEvent('SilentSiren', SirenToggle)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('updateSirens')
AddEventHandler('updateSirens', function(PID, Toggle)
	local Veh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(PID)), false)
	DisableVehicleImpactExplosionActivation(Veh, Toggle)
end)

--DESTROYEDVEHICLES

AddEventHandler("gameEventTriggered", function(name, args)
	if name == "CEventNetworkVehicleUndrivable" then
		local entity, destoyer, weapon = table.unpack(args)
		Citizen.Wait(5000)
		if not IsEntityInWater(entity) then
			SetEntityAsMissionEntity(entity, false, false) -- 
			DeleteEntity(entity) --
			--print(string.format("VEHICLE %d destroyed by %d (%d)", entity, destoyer, weapon))
		else
		end
	end
end)

--FIXKIT

RegisterNetEvent('t11:Fixkit')
AddEventHandler('t11:Fixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	if IsPedInAnyVehicle(playerPed, false) then		
		local veh = GetVehiclePedIsIn(playerPed)
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			TriggerServerEvent('t11:fixkitremove')
			TriggerEvent("mythic_progbar:client:progress", {
				name = "armor_giyme",
				duration = 4000,
				label = "Araç Tamir Ediliyor...",
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
					SetVehicleFixed(veh)
					SetVehicleDeformationFixed(veh)
					SetVehicleUndriveable(veh, false)
					ESX.ShowNotification("Aracı Tamir Ettin!")
				else
					Citizen.Wait(500)
					TriggerServerEvent('t11:fixkitadd')
				end
			end)
		else
			ESX.ShowNotification("Aracı tamir etmek için sürücüsü olman lazım!")
		end
	else
		ESX.ShowNotification("Kullanmak için araçta olman lazım!")
	end
end)

--CLEANVEHİCLE

RegisterNetEvent('cleanmyride')
AddEventHandler('cleanmyride', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	SetVehicleDirtLevel(vehicle, 0.1)
end)

--PList

RegisterNetEvent('t11:openScoreBoard')
AddEventHandler('t11:openScoreBoard', function()
	openOnlinePlayers()
end)

function openOnlinePlayers()
	ESX.TriggerServerCallback('t11:getOnlinePlayersForScoreBoard', function(oyuncular)
		local elements = {}
		local totalPlayer = 0
		
		for k,v in ipairs(oyuncular) do
			totalPlayer = totalPlayer + 1
			
		end
		table.insert(elements, {label = "<span style='color:#f4cc52;'> Toplam Oyuncu Sayısı: ".. totalPlayer.. "</span>" , value = "total"})
		for k,v in ipairs(oyuncular) do
			--table.insert(elements, {label = "ID: " .. oyuncular[k].id .. " " .. oyuncular[k].ismi, value = oyuncular[k].id}) 
			
			table.insert(elements, {label = oyuncular[k].ismi, value = oyuncular[k].id}) 
			totalPlayer = totalPlayer + 1
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'onlinePlayers',{title = "AKTIF OYUNCULAR",align = 'left',elements = elements,},function(data, menu)
		end,function(data, menu)menu.close()end)
	end)
end

--WOMANHEALTHFIX

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if GetEntityMaxHealth(GetPlayerPed(-1)) ~= 200 then
            SetEntityMaxHealth(GetPlayerPed(-1), 200)
            SetEntityHealth(GetPlayerPed(-1), 200)
        end
    end
end)

--WEAP

Weapons = {  -- Blacklistte bulunan silahları buraya giriyoruz.Silah kodlarına buradan ulaşabilirsiniz. / https://wiki.rage.mp/index.php?title=Weapons
	"WEAPON_STUNGUN",
	"WEAPON_RAYPISTOL",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_WEAPON_BZGAS",
	"WEAPON_MOLOTOV",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_PIPEBOMB",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_FLARE",
	"WEAPON_PETROLCAN",
	"WEAPON_RAILGUN",
	"WEAPON_RPG",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WAEPON_HEAVYSNIPER_MK2",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_CROWBAR",
	"WEAPON_GOLFCLUB",
	"WEAPON_BAT",
	"WEAPON_HAMMER",
	"WEAPON_NIGHTSTICK",
	"WEAPON_BATTLEAXE",
	"WEAPON_WRENCH",
	"WEAPON_DAGGER",
	"WEAPON_SWITCHBLADE",
	"WEAPON_MACHETE",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE",
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local player = PlayerPedId()
		for k,v in pairs(Weapons) do
			local player = PlayerPedId()
			local weapon = GetHashKey(v)
			if HasPedGotWeapon(player, weapon, false) == 1 then
				RemoveWeaponFromPed(player, weapon)
			end
		end
    end
end)

--==--==--==--==--==--==
-- End :( :* - TEST11 --
--==--==--==--==--==--==