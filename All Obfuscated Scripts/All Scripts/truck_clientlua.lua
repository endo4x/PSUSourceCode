--[[
	id: fEQKZeeXPViSkT7kPq9sG
	name: truck_client.lua
	description: asd
	time1: 2021-06-27 23:17:33.768558+00
	time2: 2021-06-27 23:17:33.768558+00
	uploader: 9D26QYAXY-_KkpZ_WxiDk_5EAkt05vWY7Nrua9im
	uploadersession: F_LNUIWFcWnqZAzNEkB2-YOIrDEeDw
	flag: f
--]]

-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 
player = nil
coords = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    while true do
		player = PlayerPedId()
		coords = GetEntityCoords(player)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		local sleep = true
		for k,v in pairs(Config.JobSpot) do
			local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.pos[1], v.pos[2], v.pos[3], false)
			if distance < 10.0 then
				sleep = false
				if distance < 2.0 then
					DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], Lang['job_draw_text'])
					if IsControlJustPressed(0, Config.KeyToStartJob) then
						if not isCop then
							ESX.TriggerServerCallback('t1ger_truckrobbery:copCount', function(cops)
								if cops >= Config.RequiredCops then
									ESX.TriggerServerCallback('t1ger_truckrobbery:getCooldown', function(cooldown)
										if cooldown == nil then
											ESX.TriggerServerCallback('t1ger_truckrobbery:getJobFees', function(hasMoney)
												if hasMoney then
													OpenHackFunction(v)
												else
													ShowNotifyESX(Lang['not_enough_money'])
												end
											end)
										else
											ShowNotifyESX((Lang['cooldown_time_left']:format(cooldown)))
										end
									end)
								else
									ShowNotifyESX(Lang['not_enough_police'])
								end
							end)
						else
							ShowNotifyESX(Lang['not_for_police'])
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

function OpenHackFunction(v)
	local player = GetPlayerPed(-1)
	local animDict = "mp_fbi_heist"
	local animName = "loop"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
	TaskPlayAnimAdvanced(player, animDict, animName, v.pos[1], v.pos[2], v.pos[3], 0.0, 0.0, v.heading, 3.0, 1.0, -1, 30, 1.0, 0, 0 )
	SetEntityHeading(player, v.heading)
	FreezeEntityPosition(player, true)
	exports['progressBars']:startUI((Config.HackDataTimer * 1000), Lang['progbar_hacking'])
	Citizen.Wait(Config.HackDataTimer * 1000)
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",Config.HackingBlocks,Config.HackingSeconds,HackCallback) 
end

function HackCallback(success)
	local player = GetPlayerPed(-1)
	ClearPedTasks(player)
    FreezeEntityPosition(player,false)
	TriggerEvent('mhacking:hide')
	if success then
		TriggerServerEvent('t1ger_truckrobbery:flashdrive')
		TriggerServerEvent('t1ger_truckrobbery:startJobSV')
	else
		TriggerServerEvent('t1ger_truckrobbery:flashdrive')
		ShowNotifyESX(Lang['hacking_failed'])
	end
end

	
ArmoredTruck = nil
StopTheJob = false
TruckDemolished = false
TruckIsExploded = false

RegisterNetEvent('t1ger_truckrobbery:truckRobberyJob')
AddEventHandler('t1ger_truckrobbery:truckRobberyJob',function(num)
	local player = GetPlayerPed(-1)
	local job = Config.TruckSpawn[num]
	Config.TruckSpawn[num].inUse = true
	TriggerServerEvent('t1ger_truckrobbery:SyncDataSV',Config.TruckSpawn)

	local TruckRobbed = false
	local ArmoredTruckSpawned = false
	local SecuritySpawned = false
	local Guards = {}
	local blip = CreateMissionBlip(job)
	local truckBlip = nil

	while not TruckRobbed do
		Citizen.Wait(1)
		local sleep = true
		if job.inUse then 
			local distance = 0
			if DoesEntityExist(ArmoredTruck) then 
				local truck_pos = GetEntityCoords(ArmoredTruck)
				distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, truck_pos.x, truck_pos.y, truck_pos.z, false)
			else
				distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, job.pos[1], job.pos[2], job.pos[3], false)
			end
			if distance < 100.0 then 
				sleep = false
				-- Spawn Job Vehicle:
				if distance < 100.0 and not ArmoredTruckSpawned then
					ClearAreaOfVehicles(job.pos[1], job.pos[2], job.pos[3], 10.0, false, false, false, false, false)
					ArmoredTruck = CreatedArmoredTruck(GetHashKey('stockade'), job.pos)
					ArmoredTruckSpawned = true
				end
				-- Spawn Security:
				if distance < 100.0 and ArmoredTruckSpawned and not SecuritySpawned then
					for i = 1, #job.security do
						Guards[i] = CreateGuardsInVeh(job.security[i])
					end
					SecuritySpawned = true
				end
				if ArmoredTruck ~= nil and ArmoredTruckSpawned and SecuritySpawned then
					if DoesBlipExist(blip) then RemoveBlip(blip) end
					if DoesEntityExist(ArmoredTruck) then 
						if not DoesBlipExist(truckBlip) then
							truckBlip = AddBlipForEntity(ArmoredTruck)
						end
						SetBlipSprite(truckBlip, 477)
						SetBlipColour(truckBlip, 5)
						SetBlipDisplay(truckBlip, 2)
						SetBlipScale(truckBlip, 0.60)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Инкасо")
						EndTextCommandSetBlipName(truckBlip)
					elseif DoesBlipExist(truckBlip) then
						RemoveBlip(truckBlip)
					end
				end
				if ArmoredTruckSpawned and SecuritySpawned then 
					local truck_pos = GetEntityCoords(ArmoredTruck) 
					local truck_dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, truck_pos.x, truck_pos.y, truck_pos.z, false)
					
					if truck_dist > 40.0 then
						DrawMissionText(Lang['reach_the_truck'])
					end

					if truck_dist < 40.0 and truck_dist > 5.0 and not TruckDemolished then
						local i = 0
						for k,v in pairs(job.security) do
							if DoesEntityExist(Guards[i]) then
								if not IsEntityDead(Guards[i]) then 
									DrawMissionText(Lang['kill_the_guards'])
								end
								if IsEntityDead(Guards[i]) and IsPedInAnyVehicle(Guards[i], true) then
									DeleteEntity(Guards[i])
								end
							end
							i = i + 1
						end
					end
					if truck_dist <= 5.0 and not TruckDemolished then
						local playerPed = GetPlayerPed(-1)
						local targetCoords = GetEntityCoords(playerPed)
						

						local closest_veh = GetClosestVehicle(coords.x, coords.y, coords.z, 20.0, 0, 70)
						if GetEntityModel(closest_veh) == GetHashKey('stockade') then
							local d1 = GetModelDimensions(GetEntityModel(closest_veh))
							local veh_pos = GetOffsetFromEntityInWorldCoords(closest_veh, 0.0,d1["y"]+0.60,0.0)
							local distVeh = GetDistanceBetweenCoords(veh_pos.x, veh_pos.y, veh_pos.z, coords.x, coords.y, coords.z, false);
							if distVeh < 2.0 then
								DrawText3Ds(veh_pos.x, veh_pos.y, veh_pos.z, Lang['open_truck_door'])
								if IsControlJustPressed(1, 47) then 
									ESX.TriggerServerCallback('t1ger_truckrobbery:c4truck', function(hasC4)
										if hasC4 then
									TriggerServerEvent('t1ger_truckrobbery:c4take')
									SetVehicleDoorShut(closest_veh, 2, 1)
									SetVehicleDoorShut(closest_veh, 3, 1)
									SetVehicleDoorShut(closest_veh, 5, 1)
									SetVehicleDoorShut(closest_veh, 6, 1)
									TriggerServerEvent('esx_outlawalert:policetruckrobbery')
									Wait(200)
									BlowTheTruckDoor()
								else
									ShowNotifyESX('Нямаш C4')
							end	
						end)
								end
							end
						end
					end

					if TruckIsExploded then
						truck_pos = GetEntityCoords(ArmoredTruck) 
						truck_dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, truck_pos.x, truck_pos.y, truck_pos.z, false)
		
						if truck_dist > 45.0 then
							Citizen.Wait(500)
						end
		
						if truck_dist < 4.5 then
							local closest_veh = GetClosestVehicle(coords.x, coords.y, coords.z, 20.0, 0, 70)
							if GetEntityModel(closest_veh) == GetHashKey('stockade') then
								local d2 = GetModelDimensions(GetEntityModel(closest_veh))
								local veh_pos = GetOffsetFromEntityInWorldCoords(closest_veh, 0.0,d2["y"]+0.60,0.0)
								local truck_dist = GetDistanceBetweenCoords(veh_pos.x, veh_pos.y, veh_pos.z, coords.x, coords.y, coords.z, false);
								if truck_dist < 2.0 then
									DrawText3Ds(veh_pos.x, veh_pos.y, veh_pos.z, Lang['rob_the_truck'])
									if IsControlJustPressed(1, 38) then
										RobbingTheMoney()
									end
								end
							end
						end
					end
				end

				if StopTheJob then
				
					Config.TruckSpawn[num].inUse = false
					Wait(150)
					TriggerServerEvent('t1ger_truckrobbery:SyncDataSV',Config.TruckSpawn)
					Citizen.Wait(500)
					SetEntityAsNoLongerNeeded(ArmoredTruck)
					if DoesBlipExist(truckBlip) then
						RemoveBlip(truckBlip)
					end
					local i = 0
					for k,v in pairs(job.security) do
						if DoesEntityExist(Guards[i]) then
							DeleteEntity(Guards[i])
						end
						i = i +1
					end
					ArmoredTruck = nil
					ArmoredTruckSpawned = false
					SecuritySpawned = false
					Guards = {}
					truckBlip = nil
					TruckDemolished = false
					TruckIsExploded = false
					StopTheJob = false
					TruckRobbed = true
					break
				end

			end
		end
		if sleep then Citizen.Wait(1000) end
	end
end)


-- Function to create job ped(s):
function CreateGuardsInVeh(guard)
	LoadModel(guard.ped)
	local NPC = CreatePedInsideVehicle(ArmoredTruck, 1, guard.ped, guard.seat, true, true)
	NetworkRegisterEntityAsNetworked(NPC)
	SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(NPC), true)
	SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(NPC), true)
	SetPedFleeAttributes(NPC, 0, false)
	SetPedCombatAttributes(NPC, 46, 1)
	SetPedCombatAbility(NPC, 100)
	SetPedCombatMovement(NPC, 2)
	SetPedCombatRange(NPC, 2)
	SetPedKeepTask(NPC, true)
	GiveWeaponToPed(NPC, GetHashKey(guard.weapon), 250, false, true)
	SetPedAsCop(NPC, true)
	SetPedDropsWeaponsWhenDead(NPC, false)
	TaskVehicleDriveWander(NPC, ArmoredTruck, 50.0, 443)
	SetPedArmour(NPC, 100)
	SetPedAccuracy(NPC, 60)
	SetEntityInvincible(NPC, false)
	SetEntityVisible(NPC, true)
	SetEntityAsMissionEntity(NPC)
	return NPC
end

function CreateMissionBlip(job)
	local blip = AddBlipForCoord(job.pos[1],job.pos[2],job.pos[3])
	SetBlipSprite(blip, 477)
	SetBlipColour(blip, 5)
	SetBlipDisplay(blip, 2)
	SetBlipScale(blip, 0.60)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Инкасо")
	EndTextCommandSetBlipName(blip)
	return blip
end

function BlowTheTruckDoor()
	if IsVehicleStopped(ArmoredTruck) then
		TruckDemolished = true
		
		RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
		while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
			Citizen.Wait(50)
		end
		
		if Config.NotfiyCops == true then
			NotifyPoliceFunction()
		end
		
		local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		local itemC4prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(itemC4prop, playerPed, GetPedBoneIndex(playerPed, 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
		SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"),true)
		Citizen.Wait(500)
		FreezeEntityPosition(playerPed, true)
		TaskPlayAnim(playerPed, 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		
		exports['progressBars']:startUI(5500, Lang['progbar_plant_c4'])
		Citizen.Wait(5500)
		
		ClearPedTasks(playerPed)
		DetachEntity(itemC4prop)
		AttachEntityToEntity(itemC4prop, ArmoredTruck, GetEntityBoneIndexByName(ArmoredTruck, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		FreezeEntityPosition(playerPed, false)
		Citizen.Wait(500)
		
		exports['progressBars']:startUI((Config.DetonateTimer * 1000), Lang['progbar_detonating'])	
		Citizen.Wait((Config.DetonateTimer * 1000))
		
		local TruckPos = GetEntityCoords(ArmoredTruck)
		SetVehicleDoorBroken(ArmoredTruck, 2, false)
		SetVehicleDoorBroken(ArmoredTruck, 3, false)
		AddExplosion(TruckPos.x,TruckPos.y,TruckPos.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
		ApplyForceToEntity(ArmoredTruck, 2, TruckPos.x,TruckPos.y,TruckPos.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
		TruckIsExploded = true
		ShowNotifyESX(Lang['begin_to_rob'])
	else
		ShowNotifyESX(Lang['truck_not_stopped'])
	end
end

function RobbingTheMoney()
	
	RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
	while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
		Citizen.Wait(50)
	end
	
	local playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(playerPed)
	
	local moneyBag = CreateObject(GetHashKey('prop_cs_heist_bag_02'),pos.x, pos.y,pos.z, true, true, true)
	AttachEntityToEntity(moneyBag, playerPed, GetPedBoneIndex(playerPed, 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(playerPed, true)
	
	exports['progressBars']:startUI((Config.RobTruckTimer * 1000), Lang['progbar_robbing'])
	Citizen.Wait((Config.RobTruckTimer * 1000))
	
	DeleteEntity(moneyBag)
	ClearPedTasks(playerPed)
	FreezeEntityPosition(playerPed, false)
	
	if Config.EnablePlayerMoneyBag == true then
		SetPedComponentVariation(playerPed, 5, 45, 0, 2)
	end
	
	TriggerServerEvent('t1ger_truckrobbery:jobReward')
	Citizen.Wait(1000)
	StopTheJob = true
end

function CreatedArmoredTruck(model, pos)
	print(pos[1],pos[2],pos[3])
	LoadModel(model)
    local vehicle = CreateVehicle(model, pos[1], pos[2], pos[3], 52.0, true, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleDoorsLockedForAllPlayers(vehicle, true)
    SetVehicleIsStolen(vehicle, false)
    SetVehicleIsWanted(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    SetVehicleFuelLevel(vehicle, 80.0)
	DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
	SetVehicleOnGroundProperly(vehicle)
    return vehicle
end

AddEventHandler('esx:onPlayerDeath', function(data)
	StopTheJob = true
end)


-----------------NPC SPAWNING + Menu-------------------

local coordonate = {
    {-1172.24, -2050.88, 13.44, "Карамфил [E]",250.0,0x91CA3E2C,"a_m_y_juggalo_01"}
}

local LicenseSelling = {
	{3821.2644042969, 4471.1196289062, 4.65, "Джони [E]",353.32241821289,0x91CA3E2C,"a_m_y_juggalo_01"}
}

Citizen.CreateThread(function()

    for _,v in pairs(coordonate) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()

    for _,v in pairs(LicenseSelling) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)




local menuoptions = {
	{label = "x1 Флашка - 2000$", value= 'flash_drive'},
	{label = "x1 C4 - 2500$", value= 'c4_bank'},
}

local licenseMenuOptions = {
	{label = "x1 Лиценз - 50 000$", value= 'license'},
}

function BuyMenu()
	isMenuOpen = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
		title = 'Предмети',
		align = 'left',
		elements = menuoptions
}, function(data, menu)
	menu.close()
	isMenuOpen = false

	if data.current.value == 'flash_drive' then
		TriggerServerEvent('t1ger_truckrobbery:buyflashdrive')
	end

	if data.current.value == 'c4_bank' then
		TriggerServerEvent('t1ger_truckrobbery:buyC4')
	end

end,
   function(data, menu)
	menu.close()
	isMenuOpen = false
   end)
end

function BuyLicenseMenu()
	isMenuOpen = true
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
		title = 'Лиценз',
		align = 'left',
		elements = licenseMenuOptions
}, function(data, menu)
	menu.close()
	isMenuOpen = false

	if data.current.value == 'license' then
		TriggerServerEvent('t1ger_truckrobbery:buyLicense')
	end

end,
   function(data, menu)
	menu.close()
	isMenuOpen = false
   end)
end

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        Citizen.Wait(0)
        for _,v in pairs(LicenseSelling) do
            x = v[1]
            y = v[2]
            z = v[3]
            if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 2.0)then
                DrawText3D(x,y,z+2.10, " "..v[4], 1.2, 1)

				if IsControlJustPressed(1, 38) then
					ShowNotifyESX(Lang['npcs_message'])
					BuyLicenseMenu()
				end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        Citizen.Wait(0)
        for _,v in pairs(coordonate) do
            x = v[1]
            y = v[2]
            z = v[3]
            if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 2.0)then
                DrawText3D(x,y,z+2.10, " "..v[4], 1.2, 1)

				if IsControlJustPressed(1, 38) then
					ShowNotifyESX(Lang['npcs_message'])
					BuyMenu()
				end
            end
        end
    end
end)


function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end



