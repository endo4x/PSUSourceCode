--[[
	id: fmxdpFB_j0B2TpWecyB1P
	name: mm
	description: mmm
	time1: 2021-07-25 21:15:51.648502+00
	time2: 2021-07-25 21:15:51.648503+00
	uploader: FO9lbykFs1TN694D81gA71aCD3-e5Q7ryRr098kq
	uploadersession: lL0KSTTqW0oOtQXcu-pLH4WTe3CfRr
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
ESX = nil
local eventpassword = ""
local durchsucht = false


Citizen.CreateThread(function()
	TriggerServerEvent('gvrp_fuck8888')

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('gvrp_fuck8888')
AddEventHandler('gvrp_fuck8888', function(pass)
	if eventpassword == "" then
		eventpassword = pass
	end
end)

RegisterCommand("opentrunk", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
            SetVehicleDoorOpen(veh, 5, false, false)

    end
end, false)


Citizen.CreateThread(function()
  local dict = "anim@mp_player_intmenu@key_fob@"
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
      Citizen.Wait(0)
  end
  while true do
    Citizen.Wait(0)
	if (IsControlJustPressed(1, 1086)) then
		
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local hasAlreadyLocked = false
    cars = ESX.Game.GetVehiclesInArea(coords, 30)
    local carstrie = {}
    local cars_dist = {}		
    notowned = 0

    
    if #cars == 0 then
        TriggerEvent('diamond_notification:showNotification', 'Es sind keine deiner Fahrzeuge in der nähe.')
    else
        for j=1, #cars, 1 do
            local coordscar = GetEntityCoords(cars[j])
            local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
            table.insert(cars_dist, {cars[j], distance})
        end
        for k=1, #cars_dist, 1 do
            local z = -1
            local distance, car = 999
            for l=1, #cars_dist, 1 do
                if cars_dist[l][2] < distance then
                    distance = cars_dist[l][2]
                    car = cars_dist[l][1]
                    z = l
                end
            end
            if z ~= -1 then
                table.remove(cars_dist, z)
                table.insert(carstrie, car)
            end
        end
        for i=1, #carstrie, 1 do
            local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
            print(plate)

            ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
                if owner and hasAlreadyLocked ~= true then
                    local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
                    vehicleLabel = GetLabelText(vehicleLabel)
                    local lock = GetVehicleDoorLockStatus(carstrie[i])
                    if lock == 1 or lock == 0 then
                        SetVehicleDoorShut(carstrie[i], 0, false)
                        SetVehicleDoorShut(carstrie[i], 1, false)
                        SetVehicleDoorShut(carstrie[i], 2, false)
                        SetVehicleDoorShut(carstrie[i], 3, false)
                        SetVehicleDoorsLocked(carstrie[i], 2)
                        PlayVehicleDoorCloseSound(carstrie[i], 1)
                        TriggerEvent('diamond_notification:showNotificationred', 'Du hast dein Fahrzeug abgeschlossen.')
                        if not IsPedInAnyVehicle(PlayerPedId(), true) then
                            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                        end
                        SetVehicleLights(carstrie[i], 2)
                        Citizen.Wait(150)
                        SetVehicleLights(carstrie[i], 0)
                        Citizen.Wait(150)
                        SetVehicleLights(carstrie[i], 2)
                        Citizen.Wait(150)
                        SetVehicleLights(carstrie[i], 0)
                        hasAlreadyLocked = true
                    elseif lock == 2 then
                        SetVehicleDoorsLocked(carstrie[i], 1)
                        PlayVehicleDoorOpenSound(carstrie[i], 0)
                        TriggerEvent('diamond_notification:showNotificationgreen', 'Du hast dein Fahrzeug aufgeschlossen.')
                        if not IsPedInAnyVehicle(PlayerPedId(), true) then
                            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                        end
                        SetVehicleLights(carstrie[i], 2)
                        Citizen.Wait(150)
                        SetVehicleLights(carstrie[i], 0)
                        Citizen.Wait(150)
                        SetVehicleLights(carstrie[i], 2)
                        Citizen.Wait(150)
                        SetVehicleLights(carstrie[i], 0)
                        hasAlreadyLocked = true
                    end
                else
                    notowned = notowned + 1
                end
                if notowned == #carstrie then
                    TriggerEvent('diamond_notification:showNotification', 'Es sind keine deiner Fahrzeuge in der nähe.')
                end	
            end, plate)
			end
			end
    end
  end
end)



RegisterCommand("closetrunk", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
            SetVehicleDoorShut(veh, 5, false)

    end
end, false)


RegisterNetEvent('xmenugivemoney')
AddEventHandler('xmenugivemoney', function()     

    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    ESX.TriggerServerCallback('patron_inventory:loadTarget', function(data)
        TriggerEvent('notifications', "#00ff00", "", "Bargeld: " .. data.money .. "$")

    end)
end)



RegisterNetEvent('stabilze')
AddEventHandler('stabilze', function()        

    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")


    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        TriggerEvent("notifications", "red", "BENACHRICHTIGUNG", "Kein Spieler in der Nähe!")
    else
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        local health = GetEntityHealth(closestPlayerPed)

        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then

                if health == 100 then
                    local playerPed = PlayerPedId()
                    TriggerEvent("patron_inventory:progressbar", {
                        name = "unique_action_name",
                        duration = 10000,
                        label = "",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "amb@medic@standing@tendtodead@idle_a",
                            anim = "idle_a",
                        }
                    }, function(status)
                        if not status then
                            TriggerServerEvent("player_menu:uwe", GetPlayerServerId(closestPlayer))
                            TriggerEvent("notifications", "red", "BENACHRICHTIGUNG", "Du hast einen Spieler stabilisiert!")
                            TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')


                        end
                    end)        
        
            
                end
            else
                TriggerEvent("notifications", "red", "BENACHRICHTIGUNG", "Du hast kein Medikit!")
            end


        end, 'medikit')
    end

end)

RegisterNetEvent('durchsuchen')
AddEventHandler('durchsuchen', function()    

	durchsucht = not durchsucht
    local playerPed = GetPlayerPed(-1)
	TriggerEvent("patron_inventory:progressbar", 5000)
	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	Citizen.Wait(6000)
	ClearPedTasksImmediately(playerPed)
	durchsucht = false
end)

--Keys blockieren beim Durhsuchen
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if durchsucht then
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 74, true)
			DisableControlAction(0, 2, true) 
			DisableControlAction(0, 263, true) 
			DisableControlAction(0, 45, true) 
			DisableControlAction(0, 22, true) 
			DisableControlAction(0, 44, true) 
			DisableControlAction(0, 37, true) 
			DisableControlAction(0, 288,  true) 
			DisableControlAction(0, 289, true) 
			DisableControlAction(0, 170, true) 
			DisableControlAction(0, 167, true) 
            DisableControlAction(1, 254, true)
            DisableControlAction(0, 47, true)  
        end
    end
end)

RegisterNetEvent("bens_cuff_item:checkCuff")
AddEventHandler("bens_cuff_item:checkCuff", function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        ESX.TriggerServerCallback("bens_cuff_item:isCuffed",function(cuffed)
            if not cuffed2 then
                TriggerServerEvent("bens_cuff_item:handcuff",GetPlayerServerId(player),true)
            else
                TriggerServerEvent("bens_cuff_item:handcuff",GetPlayerServerId(player),false)
            end
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'busted', 1.0)
        end,GetPlayerServerId(player))
    else
        exports['grv_notify']:SendAlert('error', 'Keine Spieler in der Nähe')
    end
end)

RegisterNetEvent('givemoney')
AddEventHandler('givemoney', function()        

    TriggerEvent("showGiveMoney")
end)


RegisterNetEvent('ausweis')
AddEventHandler('ausweis', function()    
    

    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        TriggerEvent("notifications","red","", "Kein Spieler in der Nähe!")
        TriggerEvent("PommesMitDoener:sendSound")
      else
        TriggerEvent("notifications", "red", "", "Du hast jemandem deinen Ausweis gezeigt!")
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))

      end
end)

RegisterNetEvent('ausweisnehmen')
AddEventHandler('ausweisnehmen', function()  

        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestDistance > 1.0 then
		TriggerEvent('notifications', "#ff0000", "", "Kein Spieler in der Nähe!")
        else
            TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(closestPlayer), GetPlayerServerId(PlayerId()))
        TriggerEvent("notifications", "red", "", "Du hast von jemandem den Ausweis genommen!")
        end
end)

local naheid = 0
local isFesselt = false
RegisterNetEvent('kabelbinder')
AddEventHandler('kabelbinder', function()     

    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        TriggerEvent("notifications","red","", "Kein Spieler in der Nähe!")
    else
	naheid = GetPlayerServerId(closestPlayer)
        TriggerServerEvent('bens_cuff_item:handcuff', GetPlayerServerId(closestPlayer))

    end

end)


RegisterNetEvent('bolzen')
AddEventHandler('bolzen', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local playerPed = PlayerPedId()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        ESX.ShowNotification("Kein Spieler in der Nähe!")
    else
        TriggerServerEvent('esx_police:uncuffhurensohn', GetPlayerServerId(closestPlayer))

    end

end)


RegisterNetEvent('PommesMitWasser:handcuff')
AddEventHandler('PommesMitWasser:handcuff', function(source)

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if not isFesselt then
	if source == GetPlayerServerId(closestPlayer) then
        TriggerServerEvent('PommesMitWasser:trytoget', GetPlayerServerId(closestPlayer))
		naheid = 0
	else
			naheid = 0

	end

    else
		if source == GetPlayerServerId(closestPlayer) then

        TriggerServerEvent('PommesMitWasser:trytoweg', GetPlayerServerId(closestPlayer))
		naheid = 0
	else
			naheid = 0

	end
	end
	local playerPed = PlayerPedId()

end)

RegisterNetEvent('PommesMitWasser:handcuffweg')
AddEventHandler('PommesMitWasser:handcuffweg', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()


        isFesselt = false    
        ClearPedTasks(PlayerPedId())
        local playerPed = PlayerPedId()


                ClearPedSecondaryTask(playerPed)
                SetEnableHandcuffs(playerPed, false)
                DisablePlayerFiring(playerPed, false)
                SetPedCanPlayGestureAnims(playerPed, true)

            end)
RegisterCommand('sd', function(source, args)

	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)	
end, false)

RegisterNetEvent("wurfel")
AddEventHandler("wurfel", function(zahl)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local argString = table.concat(args, " ")

  if closestPlayer ~= -1 and closestDistance <= 3.0 then
      TriggerServerEvent('wurfel', GetPlayerServerId(closestPlayer), zahl)
  else
      TriggerEvent("notifications", "#ff3d3d", "FEHLER", "Es konnte kein Spieler gefunden werden.")
  end
end)

RegisterNetEvent('viagra')
AddEventHandler('viagra', function()
	local playerPed = GetPlayerPed(-1)

	TriggerEvent("mythic_progressbar:client:progress", {
		name = "unique_action_name",
		duration = 5000,
		label = "",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@heists@narcotics@funding@gang_idle",
			anim = "gang_chatting_idle01",
		}
	}, function(status)
		if not status then
			RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
			while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
				Citizen.Wait(0)
			end
			dui = CreateDui("https://gvrp.eu/viagra.mp3", 1, 1)
			TriggerEvent("spawnpaardinger")
			Citizen.Wait(1000)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(GetPlayerPed(-1), true)
			SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
			SetPedIsDrunk(GetPlayerPed(-1), true)
			DoScreenFadeIn(1000)
			Citizen.Wait(126000)
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			ClearTimecycleModifier()
			ResetScenarioTypesEnabled()
			ResetPedMovementClipset(GetPlayerPed(-1), 0)
			SetPedIsDrunk(GetPlayerPed(-1), false)
			SetPedMotionBlur(GetPlayerPed(-1), false)	


		end
	end)       

end)
RegisterNetEvent("geheimebox")
AddEventHandler("geheimebox", function()
			dui = CreateDui("https://ucp.gvrp.eu/geheim.mp3", 1, 1)

end)
RegisterNetEvent("mysterybox")
AddEventHandler("mysterybox", function()
			dui = CreateDui("https://ucp.gvrp.eu/gnome.mp4", 1, 1)

end)
local peniscount = 0
RegisterNetEvent("auas")
AddEventHandler("auas", function()
			dui = CreateDui("https://ucp.gvrp.eu/paula.mp3", 1, 1)

end)
RegisterNetEvent('mmdma')
AddEventHandler('mmdma', function()
	local playerPed = GetPlayerPed(-1)

	TriggerEvent("mythic_progressbar:client:progress", {
		name = "unique_action_name",
		duration = 5000,
		label = "",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@heists@narcotics@funding@gang_idle",
			anim = "gang_chatting_idle01",
		}
	}, function(status)
		if not status then
			RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
			while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
				Citizen.Wait(0)
			end
			dui = CreateDui("https://gvrp.eu/mmdma.mp3", 1, 1)
			peniscount = 0
			TriggerEvent("spawnmmdma")
			Citizen.Wait(1000)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetTimecycleModifier("drug_flying_base")
			SetPedMotionBlur(GetPlayerPed(-1), true)
			SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
			SetPedIsDrunk(GetPlayerPed(-1), true)
			DoScreenFadeIn(1000)
			Citizen.Wait(135000)
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			ClearTimecycleModifier()
			ResetScenarioTypesEnabled()
			ResetPedMovementClipset(GetPlayerPed(-1), 0)
			SetPedIsDrunk(GetPlayerPed(-1), false)
			SetPedMotionBlur(GetPlayerPed(-1), false)	


		end
	end)       

end)
RegisterNetEvent('spawnmmdma')
AddEventHandler('spawnmmdma', function()
if peniscount < 5 then
peniscount = peniscount + 1
	model = "a_f_m_fatwhite_01"
	x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(model)
	while not HasModelLoaded(model) do
	  Wait(1)
	end
	ped =  CreatePed(4, model,x-2,y-2,z-1, 3374176, false, true)
Wait(2000)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedFleeAttributes(ped, 0, 0)

SetPedKeepTask(ped, true)

SetEntityInvincible(ped, true)

Wait(20000)
DeleteEntity(ped)
Wait(500)
TriggerEvent("spawnmmdma")


end
end)

RegisterNetEvent('spawnpaardinger')
AddEventHandler('spawnpaardinger', function()
	model = "a_f_m_bodybuild_01"
	x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(model)
	while not HasModelLoaded(model) do
	  Wait(1)
	end
	ped =  CreatePed(4, model,x-2,y-2,z-1, 3374176, false, true)
Wait(2000)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedFleeAttributes(ped, 0, 0)

SetPedKeepTask(ped, true)

SetEntityInvincible(ped, true)

Wait(20000)
DeleteEntity(ped)
Wait(500)
TriggerEvent("spawnpaardinger2")



end)

RegisterNetEvent('spawnpaardinger2')
AddEventHandler('spawnpaardinger2', function()
	model = "a_f_y_hippie_01"
	x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(model)
	while not HasModelLoaded(model) do
	  Wait(1)
	end
	ped =  CreatePed(4, model,x-2,y-2,z-1, 3374176, false, true)
Wait(2000)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
SetPedFleeAttributes(ped, 0, 0)

SetEntityInvincible(ped, true)

Wait(20000)
DeleteEntity(ped)
Wait(500)
TriggerEvent("spawnpaardinger3")



end)

RegisterNetEvent('spawnpaardinger3')
AddEventHandler('spawnpaardinger3', function()
	model = "s_m_y_clown_01"
	x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(model)
	while not HasModelLoaded(model) do
	  Wait(1)
	end
	ped =  CreatePed(4, model,x-2,y-2,z-1, 3374176, false, true)
Wait(2000)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
SetPedFleeAttributes(ped, 0, 0)

SetEntityInvincible(ped, true)

Wait(20000)
DeleteEntity(ped)
Wait(500)
TriggerEvent("spawnpaardinger4")



end)

RegisterNetEvent('spawnpaardinger4')
AddEventHandler('spawnpaardinger4', function()
	model = "s_m_y_clown_01"
	x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(model)
	while not HasModelLoaded(model) do
	  Wait(1)
	end
	ped =  CreatePed(4, model,x-2,y-2,z-1, 3374176, false, true)
Wait(2000)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
SetPedFleeAttributes(ped, 0, 0)

SetEntityInvincible(ped, true)

Wait(20000)
DeleteEntity(ped)
Wait(500)
TriggerEvent("spawnpaardinger5")



end)


RegisterNetEvent('spawnpaardinger5')
AddEventHandler('spawnpaardinger5', function()
	model = "s_m_y_clown_01"
	x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(model)
	while not HasModelLoaded(model) do
	  Wait(1)
	end
	ped =  CreatePed(4, model,x-2,y-2,z-1, 3374176, false, true)
Wait(2000)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
TaskGoToEntity(ped, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
SetPedKeepTask(ped, true)
SetPedFleeAttributes(ped, 0, 0)

SetEntityInvincible(ped, true)

Wait(20000)
DeleteEntity(ped)
Wait(500)



end)
RegisterNetEvent('PommesMitWasser:handcuffdran')
AddEventHandler('PommesMitWasser:handcuffdran', function(pw)
if not pw == eventpassword then
TriggerServerEvent("fuck8888", eventpassword)
return
end
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    isFesselt = true
	if naheid == GetPlayerServerId(closestPlayer) then
    TriggerServerEvent('PommesMitWasser:removekabelbinder', GetPlayerServerId(closestPlayer))
	naheid = 0
	end
    local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isFesselt then

			RequestAnimDict('anim@move_m@prisoner_cuffed')
			while not HasAnimDictLoaded('anim@move_m@prisoner_cuffed') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
            FreezeEntityPosition(playerPed, false)
		else

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
		end
	end)

end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isFesselt then

			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1


			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee


			if IsEntityPlayingAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('anim@move_m@prisoner_cuffed', function()
					TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('licenses')
AddEventHandler('licenses', function()         

    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
                local player, distance = ESX.Game.GetClosestPlayer()

                if distance ~= -1 and distance <= 3.0 then                    
                    TriggerServerEvent('grv_lizenzen:load', GetPlayerServerId(player))
                else
                    TriggerServerEvent('grv_lizenzen:load', GetPlayerServerId(PlayerId()))
                end

end)

RegisterNetEvent('supportid')
AddEventHandler('supportid', function()  
	
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
	local player, distance = ESX.Game.GetClosestPlayer()

	if distance ~= -1 and distance <= 3.0 then                    
		TriggerEvent("notifications","grey","", "Support-ID vom Spieler: " .. GetPlayerServerId(player))

	else
		TriggerEvent("notifications","red","", "Kein Spieler in der Nähe!")

	end

end)

local ss = false


AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end
 
    
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
 
        if IsControlJustPressed(0, 73) then
		        local player, closestDistance = ESX.Game.GetClosestPlayer()

            if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
            if player == -1 or closestDistance > 1.0 then
            else
            TriggerServerEvent("openPlayerXMenu")
            end
            end
        end
    end
end)

