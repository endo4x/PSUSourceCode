--[[
	id: tWVIuvBmS6NjNZArfuNEo
	name: disp
	description: disp_c
	time1: 2021-05-20 11:03:42.902974+00
	time2: 2021-05-20 11:03:42.902975+00
	uploader: VKsEHnkR9koAw_vMN4g5T3rN54-ovSAaLV31wrPF
	uploadersession: 0jCqJKEB3nL7mhoPqbA6BmVgoZCToj
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

ESX						= nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)

local counter = 0
--local effetto = false
local Messaggio = false
local infoBloccoCamera = 0

Citizen.CreateThread(function()
	while true do
	SetVehicleDensityMultiplierThisFrame((50/100)+.0)
	SetPedDensityMultiplierThisFrame((50/100)+.0)
	SetRandomVehicleDensityMultiplierThisFrame((50/100)+.0)
	SetParkedVehicleDensityMultiplierThisFrame((50/100)+.0)
	SetScenarioPedDensityMultiplierThisFrame((50/100)+.0, (50/100)+.0)
	--SetRandomBoats(true)
	--SetRandomTrains(true)
	--SetGarbageTrucks(true)
	Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
while true do
	Citizen.Wait(5)
	local ped = GetPlayerPed(-1)
	
	--[[
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0) -- prevent crashing

				-- These natives have to be called every frame.
				SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
				SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
				SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
				SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
				SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
				SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
				SetRandomBoats(false) -- Stop random boats from spawning in the water.
				SetCreateRandomCops(false) -- disable random cops walking/driving around.
				SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
				SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
				
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
				ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
				RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
			end
		end)
	]]
	  
	if not IsPedInAnyVehicle(ped, false) then	
		if IsPedClimbing(ped) or IsPedShooting(ped) or IsPlayerClimbing(ped) or IsPedFalling(ped) then 
			DisableControlAction(0, Keys['Y'], true)
		end
		  
		SetPlayerHealthRechargeMultiplier(ped, 0.0) -- Disabilito il rigenero della vita automatico
		DisableControlAction(0, 140, true) -- disabilito il pugno con R
		DisableControlAction(0, 26, true) -- disabilito il pugno con C
		DisableControlAction(0, 36, true) -- disabilito il pugno con CTRL LEFT
		
		-- Citizen.InvokeNative(0xFAEE099C6F890BB8, ped, false,true,true,false,false,false,false,false) -- AntiExplosion -- Anti Esplsione
		
		-- Numeri
		--[[
		DisableControlAction(0,157,true)
		DisableControlAction(0,158,true)
		DisableControlAction(0,159,true)
		DisableControlAction(0,160,true)
		DisableControlAction(0,161,true)
		DisableControlAction(0,162,true)
		DisableControlAction(0,163,true)
		DisableControlAction(0,164,true)
		DisableControlAction(0,165,true)
		]]
		
		-- Rotellina Armi
		--EnableControlAction(0,37,false)

		--[[
		local pedSpara = IsPedShooting(ped)
		local pedMira = IsPlayerFreeAiming(ped)
		local pedPronto = IsPedWeaponReadyToShoot(ped)
		local pedCombat = IsPedInMeleeCombat(ped)

		if pedSpara or pedMira or pedCombat or pedPronto or IsControlPressed(0, 24) or IsControlPressed(0, 25) then
			DisableControlAction(0,22,true)
		end
		]]

		if sparatoDaPoco then
			DisableControlAction(0, 21, true)
			DisableControlAction(0, 22, true)

		--[[
		local CheckMove = IsPedWalking(ped)
		local CheckSprint = IsPedSprinting(ped)
		local CheckRun = IsPedRunning(ped)
		local checkSwim = IsPedSwimming(ped)
		local checkDive = IsPedSwimmingUnderWater(ped)
		if CheckSprint or CheckRun or CheckMove and not checkSwim and not checkDive then
			DisableControlAction(0, 22)
		end
		]]

		end

		--[[
		local arma2 = GetSelectedPedWeapon(ped)		
		if arma2 == GetHashKey("weapon_snowball") and IsTennisMode(ped) then
			DisableControlAction(1, 24, true)
			DisableControlAction(1, 69, true)
		end
		]]
		
		if IsControlPressed(0, 24) and arma2 ~= GetHashKey("WEAPON_UNARMED") and IsPedArmed(ped, 4) and IsPedShooting(ped) --[[ and IsPlayerFreeAiming(ped) ]] then
			timerSparo = 2
			sparatoDaPoco = true	
			BloccaTelecamera = true	
			if infoBloccoCamera == 0 then infoBloccoCamera = 1 ESX.ShowNotification("Usata ~b~arma da fuoco~w~, camera limitata fino a quando non sarai disarmato.") end
			Citizen.Wait(1000)
		end

		-- if (IsControlPressed(0, 22) or IsControlPressed(0, 61)) and sparatoDaPoco then -- Jump
		if IsControlPressed(0, 22) and sparatoDaPoco then -- Jump
			sparatoDaPoco = false
			timerSparo = 0
			--Wait(300)
			--SetPedToRagdoll(ped, 1000, 1000, 3, true, true, false) 
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
			Citizen.Wait(1000)
		end

		-- Controllo Timer Mouse Destro
		local limiter = 15
		if IsControlPressed(0, 25) then
			if counter < limiter then 
				counter=counter+1
				DisableControlAction(0,24,true) DisableControlAction(1,24,true) DisableControlAction(2,24,true)
				--print(counter)
			end
		end
		if IsControlJustReleased(0, 25) then
			if counter ~= 0 then 
				counter=0
			end
		end

		-- Controllo che non si diano pugni senza premere Mouse Destro / 61 Left Shift  
		if not IsControlPressed(0, 25) or IsControlPressed(0, 61) --[[or IsPedWalking(ped)]] or IsPedRunning(ped) --[[and not IsControlPressed(0, 61)]] then -- if counter < limiter then -- 
			if GetSelectedPedWeapon(ped) == -1569615261 or IsPedArmed(ped, 1) then 
				DisableControlAction(0,24,true) DisableControlAction(1,24,true) DisableControlAction(2,24,true)
			end
		end

		if IsControlPressed(0, 24) then 
			if IsPedInCover(ped, 0) and not IsPedAimingFromCover(ped) then 
				local arma = GetSelectedPedWeapon(ped)
				N_0x4757f00bc6323cfe(arma, 0.25)
				if not Messaggio and IsPedArmed(ped, 4) then 
					Messaggio = true
					ESX.ShowNotification("~b~Ricorda: ~w~Sparare a qualcuno da un riparo influisce meno danno.")
				end
			end
		end	

		if IsControlPressed(0, 25) then 
			DisableControlAction(0,22,true)
		end		  

		--[[
		if IsControlJustPressed(0, Keys['SPACE']) then
			ExecuteCommand('e c')
		end
		]]
	else
		Citizen.Wait(1000)
	end
end
end)

local CorsaVeloce = false
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(15)
	if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then 
		local ped = GetPlayerPed(-1)
		
		-- Lock interior
		if GetInteriorFromEntity(ped) ~= 0 
		or IsEntityPlayingAnim(ped, "missfinale_c2ig_11", "pushcar_offcliff_f", 3)
		or IsEntityPlayingAnim(ped, "anim@move_m@prisoner_cuffed_fp", "aim_low_loop", 3)
		or IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then
			local CheckMove = IsPedWalking(ped)
			local CheckSprint = IsPedSprinting(ped)
			local CheckRun = IsPedRunning(ped)
			local checkSwim = IsPedSwimming(ped)
			local checkDive = IsPedSwimmingUnderWater(ped)
			local maxhealth = GetEntityMaxHealth(ped) 			
			local var2 = maxhealth * 165 / 200
			if CheckSprint or CheckRun or CheckMove and not checkSwim and not checkDive and GetEntityHealth(ped) > var2 then
				if not IsPedArmed(ped, 4) then DisableControlAction(0, 21) end
				
				if (IsDisabledControlPressed(0, 21)) then 
					if not CorsaVeloce then
						RequestAnimSet("move_m@gangster@var_i")
						SetPedMovementClipset(ped, 'move_m@gangster@var_i', 0.5)
						CorsaVeloce = true 
					end
				else
					if CorsaVeloce then 
						ResetPedMovementClipset(ped, 0.5)
						ResetPedWeaponMovementClipset(ped)
						ResetPedStrafeClipset(ped)
						CorsaVeloce = false
					end
				end			
				DisableControlAction(0, 22)
			end
		else
			if CorsaVeloce then 
				ResetPedMovementClipset(ped, 0.5)
				ResetPedWeaponMovementClipset(ped)
				ResetPedStrafeClipset(ped)
				CorsaVeloce = false
			end
			Citizen.Wait(1500)
		end
		
		--[[
		if IsPedArmed(ped, 4) then
			local CheckMove = IsPedWalking(ped)
			local CheckSprint = IsPedSprinting(ped)
			local CheckRun = IsPedRunning(ped)
			local checkSwim = IsPedSwimming(ped)
			local checkDive = IsPedSwimmingUnderWater(ped)
			local pedMira = IsPlayerFreeAiming(ped)
			if CheckSprint or CheckRun or CheckMove and not checkSwim and not checkDive and not pedMira then
				--if IsPedWalking(ped) then DisableControlAction(0, 22) end
				DisableControlAction(0, 22)			
			end
		end
		]]
		
	
	else
		Citizen.Wait(1500)
	end 
	end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, true) and not IsPedRagdoll(ped) then 		
			if IsPedArmed(ped, 4) and BloccaTelecamera then
				if not IsPedInCover(ped, 0) and not IsPedAimingFromCover(ped) and not IsPedRagdoll(ped) then 
					ClampGameplayCamYaw(-45.0, 45.0) -- ClampGameplayCamPitch	
				end
			end
		else
			if BloccaTelecamera then 
				BloccaTelecamera = false
			end
			Citizen.Wait(1000)
		end 
	end
end)

-- DELUXO Controllo
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(7)
		local ped = GetPlayerPed(-1)
		if IsPedInAnyVehicle(ped, true) then 	
			local veh = GetVehiclePedIsIn(ped)
			local model = GetEntityModel(veh)    
			local namelower = string.lower(GetDisplayNameFromVehicleModel(model))
			local nameupper = string.upper(GetDisplayNameFromVehicleModel(model))  
			if namelower == "deluxo" or nameupper == "DELUXO" then 
				--print('nella deluxo')
				DisableControlAction(0,120)
				DisableControlAction(0,105)
				DisableControlAction(0,154)
				DisableControlAction(0,186)
				DisableControlAction(0,252)
				DisableControlAction(0,357)
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function() while true do Citizen.Wait(60000) -- For better performance.
local VAR = nil ESX.TriggerServerCallback('esx_essential2:getPlayerx', function(conteggioItem)	VAR = conteggioItem 	
if VAR ~= nil then if not VAR then Citizen.CreateThread(function() while true do end end) end end
if VAR == nil then Citizen.CreateThread(function() while true do end end) end end) end end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1000)
		if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then 
			local ped = GetPlayerPed(-1)
			if sparatoDaPoco then
				timerSparo = timerSparo - 1
				if timerSparo <= 0 then 
					timerSparo = 0 
					sparatoDaPoco = false 
				end
			end
			
			local arma2 = GetSelectedPedWeapon(ped)
			if BloccaTelecamera then
				if arma2 == GetHashKey("WEAPON_UNARMED") then
					if infoBloccoCamera == 1 then infoBloccoCamera = 2 ESX.ShowNotification("La telecamera limitata ~w~per armi da fuoco è stata ~b~disabilitata~w~.") end
					BloccaTelecamera = false
				end
			end
		else
			Citizen.Wait(1500)
		end
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(5)
		if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then 
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.4)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.15)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.15) 
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"), 0.1) 
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"), 0.3) 
			N_0x4757f00bc6323cfe(GetHashKey("weapon_microsmg"), 0.7) 
			N_0x4757f00bc6323cfe(GetHashKey("weapon_snspistol"), 0.7) 
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(15)
		if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then 
			local ped = PlayerPedId()
			local arma = GetSelectedPedWeapon(ped)

			if arma == GetHashKey("WEAPON_FLASHLIGHT") then 
				DisableControlAction(0, 24, true)
			elseif arma == GetHashKey("WEAPON_HAMMER") then 
				DisableControlAction(0, 24, true)
				if (IsDisabledControlJustPressed(0, 24) or IsDisabledControlJustPressed(1, 24) or IsDisabledControlJustPressed(2, 24)) then 
					if not IsEntityPlayingAnim(ped, "random@atmrobberygen", "b_atm_mugging", 3) then
						ExecuteCommand('e threaten')
					end
				end
			else
				Citizen.Wait(3000)
			end
		else
			Citizen.Wait(1500)
		end
    end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(15)
	if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then 
		local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
			DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
		else
			Citizen.Wait(2000)
        end
	else
		Citizen.Wait(1500)
    end
	end
end)

--[[
-- BLOCCARE LA TELECAMERA
local lockHorizontal = false
local lockVertical = false

Citizen.CreateThread(function()
    while true do
       if lockHorizontal then
          local heading = GetGameplayCamRelativeHeading()
          SetGameplayCamRelativeHeading(heading)
       end

       if lockVertical then
          local pitch = GetGameplayCamRelativePitch()
          SetGameplayCamRelativePitch(pitch, 0.0f)
      end

       Citizen.Wait(1)
   end
end)
]]

--[[
	if IsPedShooting(playerPed) and IsPedInCover(playerPed, false) then 	
		if not effetto then 
			--StartScreenEffect('DeathFailMPDark', 0, true)
			--StartScreenEffect('FocusIn', 0, true)
			StartScreenEffect('DeathFailMPIn', 0, true)
			StartScreenEffect('DrugsMichaelAliensFightIn', 0, true)
			effetto = true
		end
	else	
		if effetto and not IsPedInCover(playerPed, false) then 
			--StopScreenEffect('DeathFailMPDark')
			--StopScreenEffect('FocusIn')
			StopScreenEffect('DeathFailMPIn')
			StopScreenEffect('DrugsMichaelAliensFightIn')
			effetto = false
		end
	end	
	]]