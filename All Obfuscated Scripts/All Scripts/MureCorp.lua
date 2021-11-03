--[[
	id: Zgq5qMrzXJ1k2RljyOVmL
	name: MureCorp
	description: Script by MureCorp
	time1: 2021-04-26 08:56:19.901841+00
	time2: 2021-04-26 08:56:19.901842+00
	uploader: zjRokNUHgtXoIjcSKOrV8aUl_GnxvVF2diovP8rZ
	uploadersession: ODpa6gm-YSPIU_3UAp0XtogXAk5hsR
	flag: f
--]]

local drugtype, selling = nil, false, 0
ESX = nil

blip = nil
blips = {}

displayTime = 300 -- Tiempo para que desaparezca el blip (en segundos)

Citizen.CreateThread(function()
  	while ESX == nil do
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(250)
  	end

  	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(250)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		  
		local distanceFromCityWeed = GetDistanceBetweenCoords(Config.CityPointWeed.x, Config.CityPointWeed.y, Config.CityPointWeed.z, playerloc['x'], playerloc['y'], playerloc['z'], true) -- Comprobación de venta de Marihuna en Grove Street
		
		local distanceFromCityWeed2 = GetDistanceBetweenCoords(Config.CityPointWeed2.x, Config.CityPointWeed2.y, Config.CityPointWeed2.z, playerloc['x'], playerloc['y'], playerloc['z'], true) -- Comprobación de venta de Marihuana en la playa

		local distanceFromCityMeta = GetDistanceBetweenCoords(Config.CityPointMeta.x, Config.CityPointMeta.y, Config.CityPointMeta.z, playerloc['x'], playerloc['y'], playerloc['z'], true) -- Comprobación de venta de Metafetamina en Sandy Shore

		local success
		repeat
			--Venta de Marihuana en Grove Street
			if distanceFromCityWeed < Config.DistanceFromCityWeed then 
				if ped ~= 0 and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then 
					local pedType = GetPedType(ped)
					if ped ~= oldped and not selling and (IsPedAPlayer(ped) == false and pedType ~= 28) then
						TriggerServerEvent('checkWeed')
						if drugtype ~= nil then
								
								local pos = GetEntityCoords(ped)
								DrawText3Ds(pos.x, pos.y, pos.z, 'Pulsa [~g~E~s~] para vender droga')
								if IsControlJustPressed(1, 86) then
									interact(drugtype)
								end
						else
							Wait(5000)
						end
					else
						Citizen.Wait(500)
					end
				end
			-- Venta de Marihuna en la playa
			elseif distanceFromCityWeed2 < Config.DistanceFromCityWeed2 then
				if ped ~= 0 and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then 
					local pedType = GetPedType(ped)
					if ped ~= oldped and not selling and (IsPedAPlayer(ped) == false and pedType ~= 28) then
						TriggerServerEvent('checkWeed')
						if drugtype ~= nil then
								
								local pos = GetEntityCoords(ped)
								DrawText3Ds(pos.x, pos.y, pos.z, 'Pulsa [~g~E~s~] para vender droga')
								if IsControlJustPressed(1, 86) then
									interact(drugtype)
								end
						else
							Wait(5000)
						end
					else
						Citizen.Wait(500)
					end
				end
			-- Venta de Metafetamina en Sandy Shore
			elseif distanceFromCityMeta < Config.DistanceFromCityMeta then
				if ped ~= 0 and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then 
					local pedType = GetPedType(ped)
					if ped ~= oldped and not selling and (IsPedAPlayer(ped) == false and pedType ~= 28) then
						TriggerServerEvent('checkMeth')
						if drugtype ~= nil then
								
								local pos = GetEntityCoords(ped)
								DrawText3Ds(pos.x, pos.y, pos.z, 'Pulsa [~g~E~s~] para vender droga')
								if IsControlJustPressed(1, 86) then
									interact(drugtype)
								end
						else
							Wait(5000)
						end
					else
						Citizen.Wait(500)
					end
				end
			end
		until not success
	end
end)

RegisterNetEvent('checkR')
AddEventHandler('checkR', function(drug)
  drugtype = drug
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = GetPlayerPed(-1)

		if not IsPedInAnyVehicle(playerPed) or not IsPedDeadOrDying(playerPed) then
			ped = GetPedInFront()
		else
			Citizen.Wait(1000)
		end
			
		Citizen.Wait(1000)
    end
end)

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 0.0, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

function interact(type)

	oldped, selling, drugtype = ped, true, nil
	SetEntityAsMissionEntity(ped)
	TaskStandStill(ped, 9.0)

	-- TriggerEvent('esx:showNotification', 'Comprobando que la venta es segura...')
	TriggerEvent("pNotify:SendNotification", { 
		text = "Comprobando que la venta es segura...", 
		timeout = 3000, type = "alert", 
		progressBar = false, 
		layout = "centerleft"
	})
	Citizen.Wait(3500)


	-- Checks the distance between the PED and the seller before continuing.
	if Config.DistanceCheck then
		if ped ~= oldped then
			-- TriggerEvent('esx:showNotification', 'Estáis muy alejados el comprador y tú como para hacer el trato')
			TriggerEvent("pNotify:SendNotification", { 
				text = "Estás muy alejado del comprador para hacer el trato...", 
				timeout = 3000, type = "alert", 
				progressBar = false, 
				layout = "centerleft"
			})

			SetPedAsNoLongerNeeded(oldped)
			selling = false
			return
		end
	end
	
	-- It all begins.
	local percent = math.random(1, 11)
	--local percent = 11		-- Opción de que siempre rechacen

	if percent <= 3 then
		-- TriggerEvent('esx:showNotification', 'El comprador no está interesado en esa mierda')
		TriggerEvent("pNotify:SendNotification", { 
			text = "El comprador no está interesado en esa mierda", 
			timeout = 3000, type = "alert", 
			progressBar = false, 
			layout = "centerleft"
		})
	elseif percent <= 10 then

		if Config.EnableAnimation == true then
			TriggerEvent("animation", source)
		end

		Wait(6500)
		TriggerServerEvent('caos_drogas:dodeal', type)
	else
		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
		local name = GetPlayerName(PlayerId())
		local ped = GetPlayerPed(PlayerId())
		local x, y, z = table.unpack(GetEntityCoords(ped, true))

		-- TriggerEvent('esx:showNotification', 'El comprador ha llamado a la policía')
		TriggerEvent("pNotify:SendNotification", { 
			text = "¡Shit! el comprador ha llamado a la policía...", 
			timeout = 3000, type = "error", 
			progressBar = false, 
			layout = "centerleft"
		})
		TriggerEvent('mureno_entornos:aviso_venta_droga', source)
	end
	
	selling = false
	SetPedAsNoLongerNeeded(oldped)
end

RegisterNetEvent('animation')
AddEventHandler('animation', function()
  	local pid = PlayerPedId()
  	--[[RequestAnimDict("amb@world_human_bum_standing@twitchy@idle_a")
  	while (not HasAnimDictLoaded("amb@world_human_bum_standing@twitchy@idle_a")) do Citizen.Wait(0) end
	TaskPlayAnim(pid,"amb@world_human_bum_standing@twitchy@idle_a","idle_c",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(6500)
	StopAnimTask(pid, "amb@world_human_bum_standing@twitchy@idle_a","idle_c", 1.0)]]
	TaskStartScenarioInPlace(pid, "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(6500)
	ClearPedTasks(PlayerPedId())
end)


RegisterNetEvent('caos_drogas:setBlip')
AddEventHandler('caos_drogas:setBlip', function(name, x, y, z, streetName)
	local playerCoords = GetEntityCoords(PlayerPedId())
	streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
	streetName = GetStreetNameFromHashKey(streetName)
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 51)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 3)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Venta de droga')
	EndTextCommandSetBlipName(blip)
	table.insert(blips, blip)
	Wait(displayTime * 1000)
	for i, blip in pairs(blips) do 
		RemoveBlip(blip)
	end
end)


-- NOTIFICACIÓN POSICIÓN AL MÓVIL DE LA LSPD
--[[
RegisterNetEvent('caos_drogas:policeNotify')
AddEventHandler('caos_drogas:policeNotify', function()
	if ESX.PlayerData.job.name == 'police' then
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
		local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		local streetName, crossing = GetStreetNameAtCoord(x, y, z)
		streetName = GetStreetNameFromHashKey(streetName)
		crossing = GetStreetNameFromHashKey(crossing)
		
		if crossing ~= nil then

		PedPosition        = GetEntityCoords(GetPlayerPed(-1))
		local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

		TriggerServerEvent('esx_addons_xenknight:startCall', 'police', "Alguien está vendiendo drogas en " .. streetName .. " y " .. crossing, PlayerCoords, {
		PlayerCoords = { 
			x = PedPosition.x,
			y = PedPosition.y,
			z = PedPosition.z
		},
		})
	else
		TriggerServerEvent('esx_addons_xenknight:startCall', 'police', "Alguien está vendiendo drogas en " .. streetName, PlayerCoords, {
		PlayerCoords = {
			x = PedPosition.x,
			y = PedPosition.y,
			z = PedPosition.z
		},
		})
		end
	end
end)
]]