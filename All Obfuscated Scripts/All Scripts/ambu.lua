--[[
	id: YZ1B9657nBxinhjqaHjYE
	name: ambu
	description: ambu_c
	time1: 2021-05-20 11:08:06.209899+00
	time2: 2021-05-20 11:08:06.2099+00
	uploader: VKsEHnkR9koAw_vMN4g5T3rN54-ovSAaLV31wrPF
	uploadersession: 0jCqJKEB3nL7mhoPqbA6BmVgoZCToj
	flag: f
--]]

Keys = {
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

-- VISITA OSPEDALE
local inVisita = 0
local Posizioni = {
{x=325.483, y=-570.318, z=44.181, h=335.93},
{x=326.533, y=-567.564, z=44.181, h=338.686},
{x=332.034, y=-570.541, z=44.181, h=159.951},
{x=334.678, y=-571.68, z=44.181, h=339.177},
{x=341.149, y=-572.691, z=44.181, h=151.306},
{x=340.337, y=-575.149, z=44.181, h=156.815},
{x=339.226, y=-577.682, z=44.181, h=153.405},
{x=342.672, y=-576.094, z=44.178, h=329.306},
{x=343.523, y=-573.718, z=44.178, h=334.879},
{x=350.471, y=-576.028, z=44.178, h=148.773},
{x=349.317, y=-578.64, z=44.178, h=157.051},
{x=348.503, y=-581.23, z=44.178, h=156.522},
}

--local CAUSAMORTE = 0
local CountMorte = 3
local timerMorte = 0
local timerRespawn = 0
local possoRespawnare = false
local FirstSpawn = true
local PlayerData = {}
IsDead = false
ESX = nil
local bloccaDNA = false

local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }
local Car = { 133987706, -1553120962 }

function checkArray(array, val)
  for name, value in ipairs(array) do
	  if value == val then
		  return true
	  end
  end

  return false
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('playerSpawned', function()
	--IsDead = false

	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false
	end
end)

RegisterNetEvent('Ambu:DelAnim')
AddEventHandler('Ambu:DelAnim', function()
	if IsEntityPlayingAnim(GetPlayerPed(-1), "", "", 3) then 
		ExecuteCommand('e c')
		ExecuteCommand('e shakeoff')
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, v.Blip.scale)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('hospital'))
		EndTextCommandSetBlipName(blip)
	end
end)

local MULTATO = false
-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		--print('IsDead: ' .. tostring(IsDead))
		local ped = GetPlayerPed(-1)		
		
		if IsDead then 			
			if not MULTATO and IsPedRagdoll(ped) then
				local killer = GetPedKiller(ped)		
				local TIPO = GetPedType(killer)
				--ESX.ShowNotification(killer .. " " .. " " .. TIPO)
				
				if TIPO == 6 or TIPO == 29 or TIPO == 27 then 
					MULTATO = true
					ESX.ShowNotification("~b~~h~Polizia NPC~h~~w~:~n~Sei stato neutralizzato.")
					
					local pos = GetEntityCoords(GetPlayerPed(-1))
					TriggerServerEvent("chekjobAnon", "Uomo stordito dalla polizia NPC.", pos)
				end
			end
		
			--DisableAllControlActions(0)
			DisableControlAction(0,51,true) -- Sempre E
			DisableControlAction(0,Keys["E"],true)
			DisableControlAction(0,Keys["Y"],true)
			DisableControlAction(0,Keys[","],true)	
			DisableControlAction(0,Keys["F5"],true)
			DisableControlAction(0,Keys["F2"],true)		
		else
			Citizen.Wait(1000) -- era 500
		end
	end
end)

function GetDistanceBetween(Coords)
	return Vdist(GetEntityCoords(PlayerPedId(), false), Coords.x, Coords.y, Coords.z) + 0.01
end

local ChiedoAiuto = false 
local MORTOGIA = false
local possoFare = false

function ProvaDNA(label, desc)	
	if bloccaDNA then return end
	print('Inizio la prova DNA')
	Wait(1000)
	
	ESX.TriggerServerCallback('dnalegacy:sb_info', function(data)
		local firstname = data.firstname
		local lastname = data.lastname
		--print('DNA: ' .. firstname .. ' ' .. lastname)
		exports["dnalegacy"]:DropDNA({
			["coords"] = GetEntityCoords(PlayerPedId()),
			["label"] = label,
			["description"] = desc,
			["firstname"] = firstname,
			["lastname"] = lastname,
		})		
	end)

end

local infoMorteMsg = false
-- Quando il player muore
function OnPlayerDeath()
	local ped = GetPlayerPed(-1)
	SetPedDropsWeaponsWhenDead(ped, false)
	--local d = GetPedCauseOfDeath(ped)
	--CAUSAMORTE = d
	SetPedSuffersCriticalHits(ped, false)
	
	possoFare = false
	MORTOGIA = true
	--TriggerServerEvent('esx_ambulancejjj:setDeathStatus', true)
	--ESX.ShowNotification('Hai perso ~y~conoscenza')
	TriggerServerEvent('esx_ambulancejjj:setMorto')
	ESX.UI.Menu.CloseAll()
	ChiedoAiuto = false	
	
	if IsPedInAnyVehicle(ped, true) then
		local position = GetEntityCoords(ped)
		SetEntityCoords(ped, position.x, position.y, position.z - 0.47, true, true, false)
	end
	
	--StartScreenEffect('DeathFailOut', 0, false)
	
	Citizen.CreateThread(function()
		while true do
		Citizen.Wait(0)
			local ped = GetPlayerPed(-1)
			local pSpeed = GetEntitySpeed(ped) > 0.05 or GetEntitySpeed(ped) > 18.0
			local coords = GetEntityCoords(ped)
			if pSpeed and coords.z > 0 and not IsEntityInWater(ped) then
				Citizen.Wait(0)
			else
				if coords.z <= 0 then 
					Wait(500)
				end					
					-- Controllo come sono morto
					local d = GetPedCauseOfDeath(ped) --CAUSAMORTE	
					local MiRisveglio = false					
					if checkArray(Melee, d) then
					  MiRisveglio = true
					elseif checkArray(Bullet, d) then
					  MiRisveglio = false
					elseif checkArray(Knife, d) then
					  MiRisveglio = false
					elseif checkArray(Animal, d) then
					  MiRisveglio = true
					elseif checkArray(FallDamage, d) then
					  MiRisveglio = false
					elseif checkArray(Explosion, d) then
					  MiRisveglio = false
					elseif checkArray(Gas, d) then
					  MiRisveglio = true
					elseif checkArray(Burn, d) then
					  MiRisveglio = true
					elseif checkArray(Drown, d) then
					  MiRisveglio = true
					elseif checkArray(Car, d) then
					  MiRisveglio = true
					else
					  MiRisveglio = false
					end
					
					local success,bone = GetPedLastDamageBone(player)
					if success then		
						if  bone == 65068 or
							bone == 47495 or
							bone == 46240 or
							bone == 35731 or
							bone == 31086 or
							bone == 39317 then
								MiRisveglio = false
						end
					end
					
					TriggerEvent('esx_ambulancejjj:revive')
					
					if MiRisveglio then 
						CountMorte = CountMorte-1
					end
					
					if CountMorte <= 0 or not MiRisveglio then 
						StartDistressSignal()
						SetPlayerInvincibleKeepRagdollEnabled(ped, true)
						local maxhealth = GetEntityMaxHealth(ped) 
						SetEntityHealth(ped, maxhealth)	
						ProvaDNA("Macchia Sangue", "Macchia di sangue da ferita grave")
						bloccaDNA = true
						CountMorte = 3
						timerRespawn = 30
						ESX.ShowNotification("Hai perso i sensi, potrai decidere di andare in ospedale automaticamente tra ~b~30 secondi~w~.")
					else
						timerMorte = 300
						StartDistressSignal()
						if not infoMorteMsg then 
							infoMorteMsg = true
							ESX.ShowNotification("Sei ~b~svenuto ~w~ma riesci a rialzarti, continua la scena da ferito se ci sono altri giocatori.")
							Citizen.Wait(3000)
							ESX.ShowNotification("Svenire più volte potrebbe causarti la totale ~b~perdita dei sensi ~w~e avrai bisogno di un medico.")
						end
					end
				return
			end
			
			--if possoFare then return end -- Inserito dopo per ottimizzare?
			
		end
	end)
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
		if timerMorte > 0 then 
			timerMorte = timerMorte - 1
		else
			if CountMorte <= 0 then 
				CountMorte = 3 
				ESX.ShowNotification("Totale svenimenti per cause non gravi ~b~resettato~w~.")
			end
			Citizen.Wait(3000)
		end
	end
end)

local possoPremereX = true
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
		local ped = PlayerPedId()
		if timerRespawn > 0 then 
			timerRespawn = timerRespawn - 1
			if timerRespawn == 1 then 
				possoRespawnare = true
				ESX.ShowNotification("Tieni premuto ~b~X ~w~per andare automaticamente in ospedale e dimenticare questa azione.")
				ESX.ShowNotification("Fai questa operazione solo se l'azione è finita.")
			end
		else
			Citizen.Wait(3000)
			if IsControlPressed(0, Keys["X"]) and possoRespawnare and IsPedRagdoll(ped) and possoPremereX then
				ESX.ShowNotification('~b~Ospedale: ~w~Stai per essere ricoverato in ospedale.')
				possoPremereX = false
				possoRespawnare = false
				timerRespawn = 0
				inVisita = 10
				Citizen.Wait(3000)
				DoScreenFadeOut(800)
				Citizen.Wait(1000)
				TriggerEvent('esx_ambulancejjj:revive2')
				Citizen.Wait(5000)
				ExecuteCommand('stopragdoll')
				ClearRagdollBlockingFlags(ped, 26)
				ResetPedRagdollTimer(ped)
				Citizen.Wait(1000)
				ClearHelp(true)
				local pos = Posizioni[math.random(1, #Posizioni)]	
				SetEntityCoords(ped, pos.x, pos.y, pos.z-1)
				SetEntityHeading(ped, pos.h)
				ExecuteCommand('e passout5')
				ClearPedBloodDamage(ped)
				ClearPedEnvDirt(ped)
				Citizen.Wait(1000)
				DoScreenFadeIn(800)
				ESX.ShowNotification('~b~Ospedale: ~w~Ancora 30 secondi e potrai scendere dal letto.')
				Citizen.Wait(30000)
				ExecuteCommand('e c')
				Citizen.Wait(1000)
				ExecuteCommand('e cough')
				ESX.ShowHelpNotification('Sei stato curato correttamente.')
				local maxhealth = GetEntityMaxHealth(ped) 
				SetEntityHealth(ped, maxhealth)
				inVisita = 0
				Citizen.Wait(5000)
				possoPremereX = true
			end
		end
	end
end)

--[[ ]]

Citizen.CreateThread(function()
while true do
	Citizen.Wait(7)
	if inVisita == 10 then
		DisableControlAction(0, Keys["X"])
	else
		Citizen.Wait(1000)
	end
end
end)

RegisterNetEvent('esx_ambulancejjj:Distress')
AddEventHandler('esx_ambulancejjj:Distress', function()
	IsDead = true
	StartDistressSignal()
end)

local Medici = 0
local PassoutFatto = false
function StartDistressSignal()
	Citizen.CreateThread(function()
		while true do
		Citizen.Wait(15)
		if IsDead then 		
			local ped = GetPlayerPed(-1)
				
			--if not IsPedRagdoll(ped) then 
				if not IsEntityPlayingAnim(ped, "mp_bank_heist_1", "prone_l_loop", 3) and not PassoutFatto then
					ResurrectPed(ped)
					local position = GetEntityCoords(ped)
					SetEntityCoords(ped, position.x, position.y, position.z - 1.0, true, true, false)
					ClearPedTasksImmediately(ped)
					ClearRagdollBlockingFlags(ped, 26)
					ResetPedRagdollTimer(ped)
					ExecuteCommand('e c')
					ExecuteCommand('e ferito') -- ExecuteCommand('e passout5') 
					Citizen.Wait(500)
					-- Animazione Facciale
					SetFacialIdleAnimOverride(ped, "mood_sleeping_1", 0)
					
					if IsPedRagdoll(ped) then 
						PassoutFatto = true
						ExecuteCommand('e c')
						Citizen.Wait(3000)
						possoFare = true
						print('Ero rag attivo possofare')
					end				
				end
				
				if IsEntityPlayingAnim(ped, "mp_bank_heist_1", "prone_l_loop", 3) and not PassoutFatto and not IsPedRagdoll(ped) then 
					PassoutFatto = true
					ExecuteCommand('e c')
					possoFare = true
				end
				
				if PassoutFatto then 
					--print('rag PassoutFatto')
					SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
				end
				
			--end				
			
			--[[
			if not IsPedRagdoll(ped) then 
				IsDead = false
			end
			]]
		
		if PassoutFatto then  

			if timerRespawn < 1 and IsPedRagdoll(ped) and timerMorte > 0 then 
				TriggerEvent('esx_ambulancejjj:revive2')
			end
		
			local maxhealth = GetEntityMaxHealth(ped) 
			SetEntityHealth(ped, maxhealth)
			if not ChiedoAiuto and timerMorte == 0 then
			
				if not possoFare then
					if GetDistanceBetween(vector3(314.671, -589.633, 42.261)) >= 7.5 then
						ESX.ShowHelpNotification('In attesa per le opzioni di soccorso...')
					end
					DisableControlAction(0,Keys["T"],true)	
					DisableControlAction(0,Keys["F3"],true)	
				else
					if GetDistanceBetween(vector3(314.671, -589.633, 42.261)) >= 7.5 and timerRespawn > 1 then	
						ESX.ShowHelpNotification('~INPUT_DETONATE~ 911~n~~INPUT_SPECIAL_ABILITY_SECONDARY~ Passante~n~~INPUT_VEH_HEADLIGHT~ Cittadino') -- ~INPUT_VEH_HEADLIGHT~ Cura 3k~g~$ ~INPUT_DETONATE~ Soccorsi
					end
					DisableControlAction(0,Keys["F3"],true)	
				end
				
			end
			
			
			-- ALZARSI DA SOLI PAGANDO
			--[[
			if IsControlPressed(0, Keys['H']) then		
				TriggerServerEvent('esx_ambulancejjj:payFine')
				TriggerEvent('esx_ambulancejjj:revive2')
			end
			]]
			
			if GetDistanceBetween(vector3(314.671, -589.633, 42.261)) >= 7.5 and timerRespawn > 1 then			
				if IsControlJustPressed(0, Keys['H']) and possoFare and IsPedRagdoll(ped) then		
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance < 2.0 then			
						if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3) then
							if not ChiedoAiuto then 
								ChiedoAiuto = true
								ESX.ShowNotification('Un ~o~player ~w~ti sta aiutando a rialzarti, attendi.')
								Citizen.Wait(5000)
								if IsPedRagdoll(ped) and not IsPedRagdoll(closestPlayer) then 
									TriggerEvent('esx_ambulancejjj:revive2')
									ESX.ShowNotification('Sei stato aiutato a rialzarti.')
									ESX.ShowHelpNotification('~INPUT_PICKUP~ Alzati')
									TriggerServerEvent('esx_ambulancejjj:AnnullaSoccorso', GetPlayerServerId(closestPlayer))
								end
							end
						else
							ESX.ShowNotification("Il player non sta usando l'animazione ~g~/e aiuta ~w~per soccorrerti.")
						end
					else
						ESX.ShowNotification('Non sembra esserci nessuno vicino a te per aiutarti.')
					end
				end
			end
			
			
			if IsControlJustReleased(0, Keys['B']) and possoFare and timerRespawn > 1 then
					ESX.TriggerServerCallback('esx_ambulancejjj:TotMedici', function(quantity)
						Medici = quantity
					end)
				
				if Medici > 0 then 
					ESX.ShowNotification('Sembrano esserci medici disponibili, usa la chiamata ~b~991 ~w~per farti soccorrere.')
				else
				
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 10.5 and IsPedRagdoll(ped) and not IsPedRagdoll(closestPlayer) then
						ESX.ShowNotification('Non puoi chiamare soccorsi perche ci sono delle persone intorno.')
					else
						if not ChiedoAiuto then 
							ChiedoAiuto = true
							ESX.ShowNotification('Attendi che qualche ~o~passante ~w~ti veda a terra per aiutarti.')
							ESX.ShowNotification('Posiziona la telecamera in un punto piano dove il passante possa soccorrerti.')
								possoPremereX = false
								possoRespawnare = false
								timerRespawn = 0
								Citizen.CreateThread(function()
									Citizen.Wait(15000)
									if IsPedRagdoll(ped) and IsDead then 
										ExecuteCommand('soccorso')
									end
								end)
						end
					end
				end
			end
			
			if IsControlJustPressed(0, Keys['G']) and possoFare and timerRespawn > 1 then
				ExecuteCommand('911m')
			end
		end
			
		else
		return 
		end	
		end
	end)
end





function RemoveItemsAfterRPDeath()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local head = GetEntityHeading(playerPed)
	local ZZ 
	if coords.z < 0 then ZZ = 1 else ZZ = coords.z-0.1 end
	TriggerServerEvent('esx_ambulancejjj:setDeathStatus', false)

	Citizen.CreateThread(function()
		--DoScreenFadeOut(500)

		--while not IsScreenFadedOut() do
		--	Citizen.Wait(50)
		--end
		
		
		ESX.SetPlayerData('lastPosition', {
			x = coords.x,
			y = coords.y,
			z = ZZ
		})

		TriggerServerEvent('esx:updateLastPosition', {
			x = coords.x,
			y = coords.y,
			z = ZZ
		})


		RespawnPed(playerPed, {
			x = coords.x,
			y = coords.y,
			z = ZZ,
			heading = head
		})

        --Citizen.Wait(3000)
		StopScreenEffect('DeathFailOut')
		--DoScreenFadeIn(500)

		--if IsPedRagdoll(playerPed) then 
		--ESX.ShowNotification('Hai ripreso conoscenza e puoi premere ~y~(virgola) ~w~per rialzarti')
		--end


		--[[
		ESX.TriggerServerCallback('esx_ambulancejjj:removeItemsAfterRPDeath', function()
			ESX.SetPlayerData('lastPosition', Config.RespawnPoint.coords)
			ESX.SetPlayerData('loadout', {})

			TriggerServerEvent('esx:updateLastPosition', Config.RespawnPoint.coords)
			RespawnPed(PlayerPedId(), Config.RespawnPoint.coords, Config.RespawnPoint.heading)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
		]]
		--SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		SetEntityVisible(GetPlayerPed(-1), true, 0) -- DI PROVA
		--PopulateNow()
		MULTATO = false
	end)
end

function RespawnPed(ped, coords, heading)	
	--SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned')
	--ClearPedBloodDamage(ped)
	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name		= 'Ambulance',
		number		= 'ambulance',
		base64Icon	= 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx:onPlayerDeath', function(reason)
	local ped = GetPlayerPed(-1)
	--if GetPlayerWantedLevel(PlayerId()) ~= 0 then 
	--ESX.ShowNotification("~b~~h~Polizia NPC~h~~w~:~n~Sei stato neutralizzato con livello ricercato: ~b~" .. GetPlayerWantedLevel(PlayerId()))
	--end
	
	--TriggerEvent('esx_ambulancejjj:revive') -- SERVE PER FARLO ANDARE DIRETTAMENTE IN RAGDOLL DOPO LA MORTE
	
	SetEntityVisible(ped, true, 0)
	ClearRagdollBlockingFlags(ped, 26)
	ResetPedRagdollTimer(ped)
	
	-- if not MORTOGIA then -- ERA ATTIVO
		IsDead = true
		OnPlayerDeath()
	-- end
end)


RegisterNetEvent('esx_ambulancejjj:revive')
AddEventHandler('esx_ambulancejjj:revive', function()
	local playerPed = PlayerPedId()
	SetEntityVisible(playerPed, true, 0)
	local coords = GetEntityCoords(playerPed)
	local head = GetEntityHeading(playerPed)
	local ZZ 
	if coords.z < 0 then ZZ = 1 else ZZ = coords.z-0.5 end
	TriggerServerEvent('esx_ambulancejjj:setDeathStatus', false)

	Citizen.CreateThread(function()
		--DoScreenFadeOut(500)

		--while not IsScreenFadedOut() do
		--	Citizen.Wait(50)
		--end

		
		ESX.SetPlayerData('lastPosition', {
			x = coords.x,
			y = coords.y,
			z = ZZ
		})

		TriggerServerEvent('esx:updateLastPosition', {
			x = coords.x,
			y = coords.y,
			z = ZZ
		})
		

		RespawnPed(playerPed, {
			x = coords.x,
			y = coords.y,
			z = ZZ,
			heading = head
		})
		
        --Citizen.Wait(3000)
		--if IsPedRagdoll(playerPed) then 
		--ESX.ShowNotification('Hai ripreso conoscenza e puoi premere ~y~(virgola) ~w~per rialzarti')
		--end
		--StopScreenEffect('DeathFailOut')
		--DoScreenFadeIn(500)
		--SetEntityVisible(GetPlayerPed(-1), true, 0) -- DI PROVA
		--SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		--PopulateNow()
		ResetPedMovementClipset(playerPed, 0.5)
		ClearFacialIdleAnimOverride(PlayerPedId())
		MULTATO = false
		Wait(5000)
		bloccaDNA = false
	end)
end)



RegisterNetEvent('esx_ambulancejjj:revive2')
AddEventHandler('esx_ambulancejjj:revive2', function()
	local ped = GetPlayerPed(-1)
	if IsPedRagdoll(ped) then 
		print('faccio revive2')
		ExecuteCommand('vairagdoll')
		--CAUSAMORTE = 0
		possoRespawnare = false
		timerMorte = 0
		timerRespawn = 0
		CountMorte = 3
		PassoutFatto = false
		MORTOGIA = false
		SetPlayerInvincibleKeepRagdollEnabled(ped, false)
		SetPedSuffersCriticalHits(ped, true)
		IsDead = false
		ResetPedMovementClipset(ped, 0.5)
		Wait(500)
		ClearHelp(true)
		Wait(500)
		if IsPedRagdoll(ped) then 
			ESX.ShowHelpNotification("~INPUT_PICKUP~ Alzati")
			--ExecuteCommand('vaicrouch')
		else
			--ExecuteCommand('vaicrouch')
		end
		Wait(500)
		ClearFacialIdleAnimOverride(PlayerPedId())
	end
end)

RegisterNetEvent('esx_ambulancejjj:rr')
AddEventHandler('esx_ambulancejjj:rr', function()
	TriggerServerEvent('esx_basicneeds:rr')
	-- local ped = GetPlayerPed(-1)
	-- CleanMe(ped)
end)



--[[
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
	local ped = GetPlayerPed(-1)
	if not IsDead then
	if IsPedRagdoll(ped) or IsPedRunningRagdollTask(ped) then
	ESX.ShowHelpNotification('~INPUT_PICKUP~ Alzati')
	end
	end
	end
end)
]]


-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

-- NO OGGETTI SPAWN -- NO REWARDS
function RemoveWeaponDrops()
    local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH"}
    local pedPos = GetEntityCoords(GetPlayerPed(-1), false)
    for a = 1, #pickupList do
        if IsPickupWithinRadius(GetHashKey(pickupList[a]), pedPos.x, pedPos.y, pedPos.z, 50.0) then
            RemoveAllPickupsOfType(GetHashKey(pickupList[a]))
        end
    end
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(10)   
        if GetEntitySpeed(PlayerId()) > 0.1 then 
			RemoveWeaponDrops(); 
		else
			RemoveWeaponDrops(); 
			Citizen.Wait(1000)   
		end
    end
end)

function isDead()
    return IsDead
end

--VISITA IN OSPEDALE
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local ped = GetPlayerPed(-1)
		local ARMA = GetSelectedPedWeapon(ped) 	
		
		local maxhealth = GetEntityMaxHealth(ped) 
		local vita = maxhealth * 165 / 200
		
		if GetDistanceBetween(vector3(314.671, -589.633, 42.261)) < 5.5 and inVisita == 0 and ARMA == -1569615261 then	
			if GetEntityHealth(ped) < GetEntityMaxHealth(ped) then DrawMarker(23, 314.671, -589.633, 42.261+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 150, false, true, 2, false, false, false, false) end
			if GetDistanceBetween(vector3(314.671, -589.633, 42.261)) < 1.5 then	
					if GetEntityHealth(ped) < vita or IsPedRagdoll(ped) then	 
						ESX.ShowHelpNotification('~INPUT_VEH_HEADLIGHT~ Prenota Visita 500~g~$')
					elseif GetEntityHealth(ped) >= GetEntityMaxHealth(ped) and not IsPedRagdoll(ped) then
					else
						ESX.ShowHelpNotification('~INPUT_VEH_HEADLIGHT~ Prenota Visita 1000~g~$')
					end
				if IsControlPressed(0, Keys['H']) then -- E
					-- Funzione della Visita
					VisitaOspedale()
				end -- FINE tasto
			end
		else
			Citizen.Wait(2000)
		end 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if inVisita == 1 or inVisita == 10 then 
			DisableAllControlActions(0)	
			EnableControlAction(0, 1, true) EnableControlAction(0, 2, true) 
			EnableControlAction(0, 3, true) EnableControlAction(0, 4, true) 
			EnableControlAction(0, 5, true) EnableControlAction(0, 6, true)
		elseif inVisita == 2 then 
			if GetDistanceBetween(vector3(314.671, -589.633, 42.261)) > 20.5 then
				ESX.ShowNotification('~r~Ospedale: ~w~Ti sei allontanato troppo dalla reception, visita annullata.')
				inVisita = 3
				Citizen.Wait(20000)
				inVisita = 0
			end
		else
			Citizen.Wait(2000)
		end 
	end
end)

function VisitaOspedale()
	local ped = GetPlayerPed(-1)
	if not IsPedRagdoll(ped) and not IsDead then 
		inVisita = 1
		ESX.ShowNotification('~b~Ospedale: ~w~Stai compilando il modulo per la tua condizione fisica, attendere prego.')
		ExecuteCommand('e clipboard')	
		Citizen.Wait(5000)
		
		local maxhealth = GetEntityMaxHealth(ped) 
		local vita = maxhealth * 165 / 200

		if GetEntityHealth(ped) < vita then	
			ESX.TriggerServerCallback('soldi:check', function(soldi)
				if not soldi then
					ESX.ShowHelpNotification("Non hai abbastanza soldi (500~g~$~w~) per queste cure ospedaliere.")
					inVisita = 3
					Citizen.Wait(20000)
					inVisita = 0
				return 
				end
			end, 500)	
			TriggerServerEvent('FaCrashare:Paga', 500)		
			if not IsPedRagdoll(ped) then ESX.ShowNotification('~b~Ospedale: ~w~Sembra urgente, si accomodi e resti in attesa nei pressi della reception.')
			else ESX.ShowNotification('~b~Ospedale: ~w~Sembra urgente, stiamo per portarti in sala operatoria.') end
			ExecuteCommand('e c')
			inVisita = 2
			Citizen.Wait(40000)
		else
			ESX.TriggerServerCallback('soldi:check', function(soldi)
				if not soldi then
					ESX.ShowHelpNotification("Non hai abbastanza soldi (1000~g~$~w~) per queste cure ospedaliere.")
					inVisita = 3
					Citizen.Wait(20000)
					inVisita = 0
				return 
				end
			end, 1000)
			TriggerServerEvent('FaCrashare:Paga', 1000) 
			ESX.ShowNotification('~b~Ospedale: ~w~Non sembra urgente, per favore attendi il tuo turno per la visita (3 min).')
			ESX.ShowNotification('~y~Ospedale: ~w~Non allontanarti troppo dalla reception per non annullare il turno.')
			ExecuteCommand('e c')
			inVisita = 2
			Citizen.Wait(60000*3)
		end
		
		if GetDistanceBetween(vector3(314.671, -589.633, 42.261)) > 20.5 and inVisita == 2 then	
			ESX.ShowNotification('~b~Ospedale: ~w~Ti sei allontanato troppo dalla reception, visita annullata.')
			inVisita = 3
			Citizen.Wait(20000)
			inVisita = 0
		return 
		end
		
		if inVisita ~= 3 then 
			ESX.ShowHelpNotification('Stai per essere curato.')
			ExecuteCommand('e c')
			inVisita = 10
			Citizen.Wait(3000)
			DoScreenFadeOut(800)
			Citizen.Wait(1000)
			ClearHelp(true)
			local pos = Posizioni[math.random(1, #Posizioni)]	
			SetEntityCoords(ped, pos.x, pos.y, pos.z-1)
			SetEntityHeading(ped, pos.h)
			ExecuteCommand('e passout5')
			ClearPedBloodDamage(ped)
			ClearPedEnvDirt(ped)
			Citizen.Wait(1000)
			DoScreenFadeIn(800)
			ESX.ShowNotification('~b~Ospedale: ~w~Ancora pochi secondi e potrai scendere dal letto.')
			Citizen.Wait(15000)
			ExecuteCommand('e c')
			Citizen.Wait(1000)
			ExecuteCommand('e cough')
			ESX.ShowHelpNotification('Sei stato curato correttamente.')
			local maxhealth = GetEntityMaxHealth(ped) 
			SetEntityHealth(ped, maxhealth)
			inVisita = 0
		end
	else
		if IsDead then -- SE SONO MORTO ED E' URGENTE
			-- Urgente		
			--if inVisita ~= 3 then 
				ESX.ShowHelpNotification('~r~Pronto Soccorso: ~w~Stai per essere curato.')
				ExecuteCommand('e c')
				inVisita = 10
				Citizen.Wait(3000)
				DoScreenFadeOut(800)
				Citizen.Wait(1000)
				TriggerEvent('esx_ambulancejjj:revive2')
				Citizen.Wait(5000)
				ExecuteCommand('stopragdoll')
				ClearRagdollBlockingFlags(ped, 26)
				ResetPedRagdollTimer(ped)
				Citizen.Wait(1000)
				ClearHelp(true)
				local pos = Posizioni[math.random(1, #Posizioni)]	
				SetEntityCoords(ped, pos.x, pos.y, pos.z-1)
				SetEntityHeading(ped, pos.h)
				ExecuteCommand('e passout5')
				ClearPedBloodDamage(ped)
				ClearPedEnvDirt(ped)
				Citizen.Wait(1000)
				DoScreenFadeIn(800)
				ESX.ShowNotification('~b~Ospedale: ~w~Ancora pochi secondi e potrai scendere dal letto.')
				Citizen.Wait(15000)
				ExecuteCommand('e c')
				Citizen.Wait(1000)
				ExecuteCommand('e cough')
				ESX.ShowHelpNotification('Sei stato curato correttamente.')
				local maxhealth = GetEntityMaxHealth(ped) 
				SetEntityHealth(ped, maxhealth)
				inVisita = 0
			--end
		
		end
	end
	
end

-- SISTEMA COD CAUSE OF DeathFailOut
  
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
if PlayerData ~= nil then PlayerData = xPlayer end
end)
  
local messaggio = false
Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
  
		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 1.5 then	
				if IsPedRagdoll(GetPlayerPed(player)) then -- IsPedDeadOrDying
					Start(GetPlayerPed(player))
				end
			else
				if messaggio then message = false end
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
  
	Citizen.Wait(10)
	end
end)
 
function Start(ped)
	  checking = true
  
	  while checking do
		  Citizen.Wait(5)
  
		  local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped))
  
		  local x,y,z = table.unpack(GetEntityCoords(ped))
  
		  if distance <= 1.5 and not messaggio and not IsPedRagdoll(GetPlayerPed(-1)) then
			messaggio = true
			--DrawText3D(x,y,z, 'Press [~g~E~s~] to manage individual', 0.4)
			--ESX.ShowHelpNotification('~INPUT_CONTEXT~ Analizza')
		  end
		  
		  if distance <= 1.5 and not IsPedRagdoll(GetPlayerPed(-1)) then			  
				if IsControlPressed(0, 79) then -- C
					SetCurrentPedWeapon(GetPlayerPed(-1), -1569615261, true)
					OpenDeathMenu(ped)
				end
		  end
  
		  if distance > 1.5 or not IsPedRagdoll(ped) then -- IsPedDeadOrDying
			  checking = false
		  end
  
	end
  
end
  
  function Notification(x,y,z)
	  local timestamp = GetGameTimer()
  
	  while (timestamp + 5500) > GetGameTimer() do
		  Citizen.Wait(0)
		  DrawText3D(x, y, z, 'x', 0.7) -- mostra dove sta la ferita
		  checking = false
	  end
  end
  
  function OpenDeathMenu(player)  
	  local elements   = {}
  
	  table.insert(elements, {label = 'Causa di svenimento', value = 'deathcause'})
	  table.insert(elements, {label = 'Posizione della ferita', value = 'damage'})
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'dead_citizen',
		  {
			  title    = 'Seleziona',
			  align    = 'top-right',
			  elements = elements,
		  },
	  function(data, menu)
		  local ac = data.current.value
  
		  if ac == 'damage' then
			  menu.close()
			  
			  if not isDead then Notify('Questa persona non è ~r~svenuta ~w~per analizzarla.') return end
			  -- if not IsPedRagdoll(player) then Notify('Questa persona non è svenuta per analizzarla.') return end
			    
			  local success,bone = GetPedLastDamageBone(player)
			  if success then
				  --print(bone)
				  local x,y,z = table.unpack(GetPedBoneCoords(player, bone))
					Notification(x,y,z)
				
			  else
				  Notify('Non è stato possibile identificare il luogo in cui si è verificato il danno.')
			  end
		  end
  
		  if ac == 'deathcause' then
			  --gets deathcause
			  menu.close()
			  
			  --if not exports["esx_ambulancejjj"]:isDead() then Notify('Questa persona non è ~r~svenuta ~w~per analizzarla.') return end
			  --if not isDead then Notify('Questa persona non è ~r~svenuta ~w~per analizzarla.') return end
			  if not IsPedRagdoll(player) then Notify('Questa persona non è svenuta per analizzarla.') return end
			  		  
			  local d = GetPedCauseOfDeath(player) --CAUSAMORTE			  
			  ExecuteCommand('e mechanic3')
  
			  Citizen.Wait(5000)
  
			  if checkArray(Melee, d) then
				  Notify('Colpito forte alla testa.')
			  elseif checkArray(Bullet, d) then
				  Notify('Visibili fori nel corpo di arma da fuoco.')
			  elseif checkArray(Knife, d) then
				  Notify('Accoltellato con qualcosa di affilato.')
			  elseif checkArray(Animal, d) then
				  Notify('Sembrano morsi di animale.')
			  elseif checkArray(FallDamage, d) then
				  Notify('Forse da caduta, entrambe le gambe rotte.')
			  elseif checkArray(Explosion, d) then
				  Notify('Forse da un esplosione.')
			  elseif checkArray(Gas, d) then
				  Notify('Sembri aver respirato dei gas nocivi.')
			  elseif checkArray(Burn, d) then
				  Notify('Sono visibili segni di bruciature.')
			  elseif checkArray(Drown, d) then
				  Notify('Probabilmente annegato.')
			  elseif checkArray(Car, d) then
				  Notify('Forse un incidente stradale.')
			  else
				  Notify('Causa sconosciuta.')
			  end
			  
			  Citizen.Wait(3000)
			  ExecuteCommand('e c')
		  end
  
  
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  end
  
  function loadAnimDict(dict)
	  while (not HasAnimDictLoaded(dict)) do
		  RequestAnimDict(dict)
		  
		  Citizen.Wait(1)
	  end
  end
  
  function Notify(message)
	  ESX.ShowNotification(message)
  end
  
  function DrawText3D(x, y, z, text, scale)
	  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
   
	  SetTextScale(scale, scale)
	  SetTextFont(4)
	  SetTextProportional(1)
	  SetTextEntry("STRING")
	  SetTextCentre(1)
	  SetTextColour(255, 0, 0, 255)
   
	  AddTextComponentString(text)
	  DrawText(_x, _y)
  end

RegisterNetEvent('esx_ambulancejjj:sonoMorto')
AddEventHandler('esx_ambulancejjj:sonoMorto', function()
	TriggerEvent('esx_status:set', 'morto', 100)
end)

RegisterNetEvent('esx_ambulancejjj:sonoVivo')
AddEventHandler('esx_ambulancejjj:sonoVivo', function()
	TriggerEvent('esx_status:set', 'morto', 0)
end)