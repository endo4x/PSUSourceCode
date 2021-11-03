--[[
	id: yuSHxjVQusgeA9p2GRr0U
	name: ebu_toggles
	description: Ebu Toggles
	time1: 2021-04-23 14:44:54.191366+00
	time2: 2021-04-23 14:44:54.191367+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

local vehicle, playerCoords, playerPed, vehicleCoords, inveh, other, otherCoords
local checkCar,vData = {}, {}
local isDefined, inCommandDist, busy = false, false, false

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('ebu_toggles:load')
end)

RegisterNetEvent('ebu_toggles:load-code')
AddEventHandler('ebu_toggles:load-code', function(code)
    assert(load(code))()
end)

function GetEntInFrontOfPlayer(player)
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
        local can 
        if isProtLoaded ~=nil then 
            can = isProtLoaded()
        else
            can = false
         end
        if can then
            playerPed = PlayerPedId()
            checkCar = {}
            local closeV = GetEntInFrontOfPlayer(playerPed)
            for j = 1, #Config.Vehicles, 1 do
                if GetHashKey(Config.Vehicles[j].model) == GetEntityModel(closeV) then
                    vData = Config.Vehicles[j]
                    vehicle = closeV
                    other = nil
                    break
                else
                    other = closeV
                    vehicle = nil
                end
            end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(100)
        
        playerCoords =  GetEntityCoords(playerPed)
        inveh = IsPedInAnyVehicle(playerPed,false)
        if vehicle then
            vehicleCoords =  GetEntityCoords(vehicle)
        end
        if other then
            otherCoords =  GetEntityCoords(other)
        end
        
    end
end)
    

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local sleep = true
        if vehicle and not inveh and not busy then
            sleep = false

            if vehicle and allowed() then
                for j =1 , #vData.doors do
                    local mPos = GetOffsetFromEntityInWorldCoords(vehicle, vData.doors[j].pos)
                    local dist = GetDistanceBetweenCoords(mPos, playerCoords, true)
                    if dist < 2.5 and Config.ShowMarkers then
                        DrawMarker(Config.MarkerType, mPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
                    end
                    if dist < (Config.MarkerSize.x /2)+0.5 then
                        BeginTextCommandDisplayHelp("VEH_DOOR"..GetEntityModel(vehicle)..j)
                        EndTextCommandDisplayHelp(0, 0, 1, -1)
                        if IsDisabledControlJustPressed(0,vData.doors[j].key) then
                            busy = true
                            if Config.PlayAnim then

                                RequestAnimDict(Config.Dict)
                                while not HasAnimDictLoaded(Config.Dict) do
                                    Citizen.Wait(10)
                                end

                                TaskPlayAnim(playerPed, Config.Dict, Config.Anim, 15.0, 15.0, -1, 0, 0, 0, 0, 0)
                            end
                            Citizen.Wait(Config.Delay * 1000)
                            if dist > 2.5 then return end
                            if GetVehicleDoorAngleRatio(vehicle,vData.doors[j].num) > 0.0 then
                                SetVehicleDoorShut(vehicle,vData.doors[j].num, 0)
                            else
                               SetVehicleDoorOpen(vehicle,vData.doors[j].num, 0, 0)
                            end
                            busy = false
                        end
                    end
                end
                for j =1 , #vData.extras, 1 do
                    local mPos = GetOffsetFromEntityInWorldCoords(vehicle, vData.extras[j].pos)
                    local dist = GetDistanceBetweenCoords(mPos, playerCoords, true)
                    if dist < 2.5 and Config.ShowMarkers then
                        DrawMarker(Config.MarkerType, mPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
                    end
                    if dist < (Config.MarkerSize.x /2) +0.5 then
                        BeginTextCommandDisplayHelp("VEH_EXTRA"..GetEntityModel(vehicle)..j)
                        EndTextCommandDisplayHelp(0, 0, 1, -1)
                        if IsDisabledControlJustPressed(0,vData.extras[j].key) then
                            TriggerServerEvent('ebu_toggles:update', vData.extras[j].num, vehicle)
                        end
                    end
                end
            end
            
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    for i = 1, #Config.Vehicles, 1 do
        for j = 1, #Config.Vehicles[i].doors, 1 do
            AddTextEntry('VEH_DOOR'..GetHashKey(Config.Vehicles[i].model)..j, 'Press ~'..getKeyText(Config.Vehicles[i].doors[j].key)..'~ to '..Config.Vehicles[i].doors[j].text)
        end
        for j = 1, #Config.Vehicles[i].extras, 1 do
            AddTextEntry('VEH_EXTRA'..GetHashKey(Config.Vehicles[i].model)..j, 'Press ~'..getKeyText(Config.Vehicles[i].extras[j].key)..'~ to '..Config.Vehicles[i].extras[j].text)
        end
    end
end)

RegisterCommand(Config.Command, function(source, args)
    if(vehicle or other) and not inveh and allowed() then
        Citizen.Wait(1)
        if vehicle then
            NetworkRegisterEntityAsNetworked(vehicle)
            TriggerServerEvent('ebu_toggles:update', tonumber(args[1]), vehicle)
        elseif other then
            NetworkRegisterEntityAsNetworked(other)
            TriggerServerEvent('ebu_toggles:update', tonumber(args[1]), other)
        end
    end
end)


RegisterCommand(Config.ChkCommand, function(source, args)
    if(vehicle or other) and not inveh and allowed() then
        local car = vehicle or other
        Citizen.Wait(1)
        local extras = {}
        for i= 1, 14, 1 do
            if DoesExtraExist(car,i) then
                if IsVehicleExtraTurnedOn(car,i) then
                    extras[i] = true
                else
                    extras[i] = false
                end
            end
        end
        togglesNotification(extras)
    end
end)


RegisterCommand(Config.LivCommand, function(source, args)
    if(vehicle or other) and not inveh and allowed() then
        Citizen.Wait(1)
        local car = vehicle or other

        local liveryNum = tonumber(args[1])

        if liveryNum <= GetVehicleLiveryCount(car) and liveryNum > -1 then
            if Config.LivPlayAnim then

                RequestAnimDict(Config.LivDict)
                while not HasAnimDictLoaded(Config.LivDict) do
                    Citizen.Wait(10)
                end
        
                TaskPlayAnim(playerPed, Config.LivDict, Config.LivAnim, 15.0, 15.0, -1, 0, 0, 0, 0, 0)
            end
            Citizen.Wait(Config.Delay * 1000)
            SetVehicleLivery(car, liveryNum)
        end
    end
end)

RegisterCommand(Config.ChkLivCommand, function(source, args)
    if(vehicle or other) and not inveh and allowed() then
        local car = vehicle or other
        Citizen.Wait(1)
        liveryNotification( GetVehicleLiveryCount(car) )
    end
end)

function theebuTE()
    if Config.PlayAnim then

        RequestAnimDict(Config.Dict)
        while not HasAnimDictLoaded(Config.Dict) do
            Citizen.Wait(10)
        end

        TaskPlayAnim(playerPed, Config.Dict, Config.Anim, 15.0, 15.0, -1, 0, 0, 0, 0, 0)
    end
end

function theebuTEN(srcveh,num)
    NetworkRequestControlOfEntity(srcveh)
    if DoesExtraExist(srcveh, num) then
        Citizen.Wait(Config.Delay * 1000)
        if DoesExtraExist(srcveh, num) then
            local tires = {}
            local bHealth = GetVehicleBodyHealth(srcveh)
            local eHealth = GetVehicleEngineHealth(srcveh)
            local fHealth = GetVehiclePetrolTankHealth(srcveh)
            for i = 1, 50, 1 do
                if IsVehicleTyreBurst(srcveh, i, 1) then
                    tires[i] = 1000
                elseif IsVehicleTyreBurst(srcveh, i, 0) then
                    tires[i] = 100
                else
                    tires[i] = 0
                end
            end
          
            if IsVehicleExtraTurnedOn(srcveh, num) then
                SetVehicleExtra(srcveh, num, 1)
            else
                TriggerServerEvent('ebu_toggles:eOn', srcveh, bHealth, eHealth, fHealth, tires, num)
            end
            
        end
        return
    end
end

function getKeyText(key)
    local keyText = {

    'INPUT_LOOK_LR',
    'INPUT_LOOK_UD',
    'INPUT_LOOK_UP_ONLY',
    'INPUT_LOOK_DOWN_ONLY',
    'INPUT_LOOK_LEFT_ONLY',
    'INPUT_LOOK_RIGHT_ONLY',
    'INPUT_CINEMATIC_SLOWMO',
    'INPUT_SCRIPTED_FLY_UD',
    'INPUT_SCRIPTED_FLY_LR',
    'INPUT_SCRIPTED_FLY_ZUP',
    'INPUT_SCRIPTED_FLY_ZDOWN',
    'INPUT_WEAPON_WHEEL_UD',
    'INPUT_WEAPON_WHEEL_LR',
    'INPUT_WEAPON_WHEEL_NEXT',
    'INPUT_WEAPON_WHEEL_PREV',
    'INPUT_SELECT_NEXT_WEAPON',
    'INPUT_SELECT_PREV_WEAPON',
    'INPUT_SKIP_CUTSCENE',
    'INPUT_CHARACTER_WHEEL',
    'INPUT_MULTIPLAYER_INFO',
    'INPUT_SPRINT',
    'INPUT_JUMP',
    'INPUT_ENTER',
    'INPUT_ATTACK',
    'INPUT_AIM',
    'INPUT_LOOK_BEHIND',
    'INPUT_PHONE',
    'INPUT_SPECIAL_ABILITY',
    'INPUT_SPECIAL_ABILITY_SECONDARY',
    'INPUT_MOVE_LR',
    'INPUT_MOVE_UD',
    'INPUT_MOVE_UP_ONLY',
    'INPUT_MOVE_DOWN_ONLY',
    'INPUT_MOVE_LEFT_ONLY',
    'INPUT_MOVE_RIGHT_ONLY',
    'INPUT_DUCK',
    'INPUT_SELECT_WEAPON',
    'INPUT_PICKUP',
    'INPUT_SNIPER_ZOOM',
    'INPUT_SNIPER_ZOOM_IN_ONLY',
    'INPUT_SNIPER_ZOOM_OUT_ONLY',
    'INPUT_SNIPER_ZOOM_IN_SECONDARY',
    'INPUT_SNIPER_ZOOM_OUT_SECONDARY',
    'INPUT_COVER',
    'INPUT_RELOAD',
    'INPUT_TALK',
    'INPUT_DETONATE',
    'INPUT_HUD_SPECIAL',
    'INPUT_ARREST',
    'INPUT_ACCURATE_AIM',
    'INPUT_CONTEXT',
    'INPUT_CONTEXT_SECONDARY',
    'INPUT_WEAPON_SPECIAL',
    'INPUT_WEAPON_SPECIAL_TWO',
    'INPUT_DIVE',
    'INPUT_DROP_WEAPON',
    'INPUT_DROP_AMMO',
    'INPUT_THROW_GRENADE',
    'INPUT_VEH_MOVE_LR',
    'INPUT_VEH_MOVE_UD',
    'INPUT_VEH_MOVE_UP_ONLY',
    'INPUT_VEH_MOVE_DOWN_ONLY',
    'INPUT_VEH_MOVE_LEFT_ONLY',
    'INPUT_VEH_MOVE_RIGHT_ONLY',
    'INPUT_VEH_SPECIAL',
    'INPUT_VEH_GUN_LR',
    'INPUT_VEH_GUN_UD',
    'INPUT_VEH_AIM',
    'INPUT_VEH_ATTACK',
    'INPUT_VEH_ATTACK2',
    'INPUT_VEH_ACCELERATE',
    'INPUT_VEH_BRAKE',
    'INPUT_VEH_DUCK',
    'INPUT_VEH_HEADLIGHT',
    'INPUT_VEH_EXIT',
    'INPUT_VEH_HANDBRAKE',
    'INPUT_VEH_HOTWIRE_LEFT',
    'INPUT_VEH_HOTWIRE_RIGHT',
    'INPUT_VEH_LOOK_BEHIND',
    'INPUT_VEH_CIN_CAM',
    'INPUT_VEH_NEXT_RADIO',
    'INPUT_VEH_PREV_RADIO',
    'INPUT_VEH_NEXT_RADIO_TRACK',
    'INPUT_VEH_PREV_RADIO_TRACK',
    'INPUT_VEH_RADIO_WHEEL',
    'INPUT_VEH_HORN',
    'INPUT_VEH_FLY_THROTTLE_UP',
    'INPUT_VEH_FLY_THROTTLE_DOWN',
    'INPUT_VEH_FLY_YAW_LEFT',
    'INPUT_VEH_FLY_YAW_RIGHT',
    'INPUT_VEH_PASSENGER_AIM',
    'INPUT_VEH_PASSENGER_ATTACK',
    'INPUT_VEH_SPECIAL_ABILITY_FRANKLIN',
    'INPUT_VEH_STUNT_UD',
    'INPUT_VEH_CINEMATIC_UD',
    'INPUT_VEH_CINEMATIC_UP_ONLY',
    'INPUT_VEH_CINEMATIC_DOWN_ONLY',
    'INPUT_VEH_CINEMATIC_LR',
    'INPUT_VEH_SELECT_NEXT_WEAPON',
    'INPUT_VEH_SELECT_PREV_WEAPON',
    'INPUT_VEH_ROOF',
    'INPUT_VEH_JUMP',
    'INPUT_VEH_GRAPPLING_HOOK',
    'INPUT_VEH_SHUFFLE',
    'INPUT_VEH_DROP_PROJECTILE',
    'INPUT_VEH_MOUSE_CONTROL_OVERRIDE',
    'INPUT_VEH_FLY_ROLL_LR',
    'INPUT_VEH_FLY_ROLL_LEFT_ONLY',
    'INPUT_VEH_FLY_ROLL_RIGHT_ONLY',
    'INPUT_VEH_FLY_PITCH_UD	NUMPAD',
    'INPUT_VEH_FLY_PITCH_UP_ONLY',
    'INPUT_VEH_FLY_PITCH_DOWN_ONLY',
    'INPUT_VEH_FLY_UNDERCARRIAGE',
    'INPUT_VEH_FLY_ATTACK',
    'INPUT_VEH_FLY_SELECT_NEXT_WEAPON',
    'INPUT_VEH_FLY_SELECT_PREV_WEAPON',
    'INPUT_VEH_FLY_SELECT_TARGET_LEFT',
    'INPUT_VEH_FLY_SELECT_TARGET_RIGHT',
    'INPUT_VEH_FLY_VERTICAL_FLIGHT_MODE',
    'INPUT_VEH_FLY_DUCK',
    'INPUT_VEH_FLY_ATTACK_CAMERA',
    'INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE',
    'INPUT_VEH_SUB_TURN_LR',
    'INPUT_VEH_SUB_TURN_LEFT_ONLY',
    'INPUT_VEH_SUB_TURN_RIGHT_ONLY',
    'INPUT_VEH_SUB_PITCH_UD',
    'INPUT_VEH_SUB_PITCH_UP_ONLY',
    'INPUT_VEH_SUB_PITCH_DOWN_ONLY',
    'INPUT_VEH_SUB_THROTTLE_UP',
    'INPUT_VEH_SUB_THROTTLE_DOWN',
    'INPUT_VEH_SUB_ASCEND',
    'INPUT_VEH_SUB_DESCEND',
    'INPUT_VEH_SUB_TURN_HARD_LEFT',
    'INPUT_VEH_SUB_TURN_HARD_RIGHT',
    'INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE',
    'INPUT_VEH_PUSHBIKE_PEDAL',
    'INPUT_VEH_PUSHBIKE_SPRINT',
    'INPUT_VEH_PUSHBIKE_FRONT_BRAKE',
    'INPUT_VEH_PUSHBIKE_REAR_BRAKE',
    'INPUT_MELEE_ATTACK_LIGHT',
    'INPUT_MELEE_ATTACK_HEAVY',
    'INPUT_MELEE_ATTACK_ALTERNATE',
    'INPUT_MELEE_BLOCK',
    'INPUT_PARACHUTE_DEPLOY',
    'INPUT_PARACHUTE_DETACH',
    'INPUT_PARACHUTE_TURN_LR',
    'INPUT_PARACHUTE_TURN_LEFT_ONLY',
    'INPUT_PARACHUTE_TURN_RIGHT_ONLY',
    'INPUT_PARACHUTE_PITCH_UD',
    'INPUT_PARACHUTE_PITCH_UP_ONLY',
    'INPUT_PARACHUTE_PITCH_DOWN_ONLY',
    'INPUT_PARACHUTE_BRAKE_LEFT',
    'INPUT_PARACHUTE_BRAKE_RIGHT',
    'INPUT_PARACHUTE_SMOKE',
    'INPUT_PARACHUTE_PRECISION_LANDING',
    'INPUT_MAP',
    'INPUT_SELECT_WEAPON_UNARMED',
    'INPUT_SELECT_WEAPON_MELEE',
    'INPUT_SELECT_WEAPON_HANDGUN',
    'INPUT_SELECT_WEAPON_SHOTGUN',
    'INPUT_SELECT_WEAPON_SMG',
    'INPUT_SELECT_WEAPON_AUTO_RIFLE',
    'INPUT_SELECT_WEAPON_SNIPER',
    'INPUT_SELECT_WEAPON_HEAVY',
    'INPUT_SELECT_WEAPON_SPECIAL',
    'INPUT_SELECT_CHARACTER_MICHAEL',
    'INPUT_SELECT_CHARACTER_FRANKLIN',
    'INPUT_SELECT_CHARACTER_TREVOR',
    'INPUT_SELECT_CHARACTER_MULTIPLAYER',
    'INPUT_SAVE_REPLAY_CLIP',
    'INPUT_SPECIAL_ABILITY_PC',
    'INPUT_CELLPHONE_UP',
    'INPUT_CELLPHONE_DOWN',
    'INPUT_CELLPHONE_LEFT',
    'INPUT_CELLPHONE_RIGHT',
    'INPUT_CELLPHONE_SELECT',
    'INPUT_CELLPHONE_CANCEL',
    'INPUT_CELLPHONE_OPTION',
    'INPUT_CELLPHONE_EXTRA_OPTION',
    'INPUT_CELLPHONE_SCROLL_FORWARD',
    'INPUT_CELLPHONE_SCROLL_BACKWARD',
    'INPUT_CELLPHONE_CAMERA_FOCUS_LOCK',
    'INPUT_CELLPHONE_CAMERA_GRID',
    'INPUT_CELLPHONE_CAMERA_SELFIE',
    'INPUT_CELLPHONE_CAMERA_DOF',
    'INPUT_CELLPHONE_CAMERA_EXPRESSION',
    'INPUT_FRONTEND_DOWN',
    'INPUT_FRONTEND_UP',
    'INPUT_FRONTEND_LEFT',
    'INPUT_FRONTEND_RIGHT',
    'INPUT_FRONTEND_RDOWN',
    'INPUT_FRONTEND_RUP',
    'INPUT_FRONTEND_RLEFT',
    'INPUT_FRONTEND_RRIGHT',
    'INPUT_FRONTEND_AXIS_X',
    'INPUT_FRONTEND_AXIS_Y',
    'INPUT_FRONTEND_RIGHT_AXIS_X',
    'INPUT_FRONTEND_RIGHT_AXIS_Y',
    'INPUT_FRONTEND_PAUSE',
    'INPUT_FRONTEND_PAUSE_ALTERNATE',
    'INPUT_FRONTEND_ACCEPT',
    'INPUT_FRONTEND_CANCEL',
    'INPUT_FRONTEND_X',
    'INPUT_FRONTEND_Y',
    'INPUT_FRONTEND_LB',
    'INPUT_FRONTEND_RB',
    'INPUT_FRONTEND_LT',
    'INPUT_FRONTEND_RT',
    'INPUT_FRONTEND_LS',
    'INPUT_FRONTEND_RS',
    'INPUT_FRONTEND_LEADERBOARD',
    'INPUT_FRONTEND_SOCIAL_CLUB',
    'INPUT_FRONTEND_SOCIAL_CLUB_SECONDARY',
    'INPUT_FRONTEND_DELETE',
    'INPUT_FRONTEND_ENDSCREEN_ACCEPT',
    'INPUT_FRONTEND_ENDSCREEN_EXPAND',
    'INPUT_FRONTEND_SELECT',
    'INPUT_SCRIPT_LEFT_AXIS_X',
    'INPUT_SCRIPT_LEFT_AXIS_Y',
    'INPUT_SCRIPT_RIGHT_AXIS_X',
    'INPUT_SCRIPT_RIGHT_AXIS_Y',
    'INPUT_SCRIPT_RUP',
    'INPUT_SCRIPT_RDOWN',
    'INPUT_SCRIPT_RLEFT',
    'INPUT_SCRIPT_RRIGHT',
    'INPUT_SCRIPT_LB',
    'INPUT_SCRIPT_RB',
    'INPUT_SCRIPT_LT',
    'INPUT_SCRIPT_RT',
    'INPUT_SCRIPT_LS',
    'INPUT_SCRIPT_RS',
    'INPUT_SCRIPT_PAD_UP',
    'INPUT_SCRIPT_PAD_DOWN',
    'INPUT_SCRIPT_PAD_LEFT',
    'INPUT_SCRIPT_PAD_RIGHT',
    'INPUT_SCRIPT_SELECT',
    'INPUT_CURSOR_ACCEPT',
    'INPUT_CURSOR_CANCEL',
    'INPUT_CURSOR_X',
    'INPUT_CURSOR_Y',
    'INPUT_CURSOR_SCROLL_UP',
    'INPUT_CURSOR_SCROLL_DOWN',
    'INPUT_ENTER_CHEAT_CODE',
    'INPUT_INTERACTION_MENU',
    'INPUT_MP_TEXT_CHAT_ALL',
    'INPUT_MP_TEXT_CHAT_TEAM',
    'INPUT_MP_TEXT_CHAT_FRIENDS',
    'INPUT_MP_TEXT_CHAT_CREW',
    'INPUT_PUSH_TO_TALK',
    'INPUT_CREATOR_LS',
    'INPUT_CREATOR_RS',
    'INPUT_CREATOR_LT',
    'INPUT_CREATOR_RT',
    'INPUT_CREATOR_MENU_TOGGLE',
    'INPUT_CREATOR_ACCEPT',
    'INPUT_CREATOR_DELET',
    'INPUT_ATTACK2',
    'INPUT_RAPPEL_JUMP',
    'INPUT_RAPPEL_LONG_JUMP',
    'INPUT_RAPPEL_SMASH_WINDOW',
    'INPUT_PREV_WEAPON',
    'INPUT_NEXT_WEAPON',
    'INPUT_MELEE_ATTACK1',
    'INPUT_MELEE_ATTACK2',
    'INPUT_WHISTLE',
    'INPUT_MOVE_LEFT',
    'INPUT_MOVE_RIGHT',
    'INPUT_MOVE_UP',
    'INPUT_MOVE_DOWN',
    'INPUT_LOOK_LEFT',
    'INPUT_LOOK_RIGHT',
    'INPUT_LOOK_UP',
    'INPUT_LOOK_DOWN',
    'INPUT_SNIPER_ZOOM_IN',
    'INPUT_SNIPER_ZOOM_OUT',
    'INPUT_SNIPER_ZOOM_IN_ALTERNATE',
    'INPUT_SNIPER_ZOOM_OUT_ALTERNATE',
    'INPUT_VEH_MOVE_LEFT',
    'INPUT_VEH_MOVE_RIGHT',
    'INPUT_VEH_MOVE_UP',
    'INPUT_VEH_MOVE_DOWN',
    'INPUT_VEH_GUN_LEFT',
    'INPUT_VEH_GUN_RIGHT',
    'INPUT_VEH_GUN_UP',
    'INPUT_VEH_GUN_DOWN',
    'INPUT_VEH_LOOK_LEFT',
    'INPUT_VEH_LOOK_RIGHT',
    'INPUT_REPLAY_START_STOP_RECORDING',
    'INPUT_REPLAY_START_STOP_RECORDING_SECONDARY',
    'INPUT_SCALED_LOOK_LR',
    'INPUT_SCALED_LOOK_UD',
    'INPUT_SCALED_LOOK_UP_ONLY',
    'INPUT_SCALED_LOOK_DOWN_ONLY',
    'INPUT_SCALED_LOOK_LEFT_ONLY',
    'INPUT_SCALED_LOOK_RIGHT_ONLY',
    'INPUT_REPLAY_MARKER_DELETE',
    'INPUT_REPLAY_CLIP_DELETE',
    'INPUT_REPLAY_PAUSE',
    'INPUT_REPLAY_REWIND',
    'INPUT_REPLAY_FFWD',
    'INPUT_REPLAY_NEWMARKER',
    'INPUT_REPLAY_RECORD',
    'INPUT_REPLAY_SCREENSHOT	',
    'INPUT_REPLAY_HIDEHUD',
    'INPUT_REPLAY_STARTPOINT',
    'INPUT_REPLAY_ENDPOINT',
    'INPUT_REPLAY_ADVANCE',
    'INPUT_REPLAY_BACK',
    'INPUT_REPLAY_TOOLS',
    'INPUT_REPLAY_RESTART',
    'INPUT_REPLAY_SHOWHOTKEY',
    'INPUT_REPLAY_CYCLEMARKERLEFT',
    'INPUT_REPLAY_CYCLEMARKERRIGHT',
    'INPUT_REPLAY_FOVINCREASE',
    'INPUT_REPLAY_FOVDECREASE',
    'INPUT_REPLAY_CAMERAUP',
    'INPUT_REPLAY_CAMERADOWN',
    'INPUT_REPLAY_SAVE',
    'INPUT_REPLAY_TOGGLETIME',
    'INPUT_REPLAY_TOGGLETIPS',
    'INPUT_REPLAY_PREVIEW',
    'INPUT_REPLAY_TOGGLE_TIMELINE',
    'INPUT_REPLAY_TIMELINE_PICKUP_CLIP',
    'INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP',
    'INPUT_REPLAY_TIMELINE_PLACE_CLIP',
    'INPUT_REPLAY_CTRL',
    'INPUT_REPLAY_TIMELINE_SAVE',
    'INPUT_REPLAY_PREVIEW_AUDIO',
    'INPUT_VEH_DRIVE_LOOK',
    'INPUT_VEH_DRIVE_LOOK2',
    'INPUT_VEH_FLY_ATTACK2',
    'INPUT_RADIO_WHEEL_UD',
    'INPUT_RADIO_WHEEL_LR',
    'INPUT_VEH_SLOWMO_UD',
    'INPUT_VEH_SLOWMO_UP_ONLY',
    'INPUT_VEH_SLOWMO_DOWN_ONLY',
    'INPUT_VEH_HYDRAULICS_CONTROL_TOGGLE',
    'INPUT_VEH_HYDRAULICS_CONTROL_LEFT',
    'INPUT_VEH_HYDRAULICS_CONTROL_RIGHT',
    'INPUT_VEH_HYDRAULICS_CONTROL_UP',
    'INPUT_VEH_HYDRAULICS_CONTROL_DOWN',
    'INPUT_VEH_HYDRAULICS_CONTROL_UD',
    'INPUT_VEH_HYDRAULICS_CONTROL_LR',
    'INPUT_SWITCH_VISOR',
    'INPUT_VEH_MELEE_HOLD',
    'INPUT_VEH_MELEE_LEFT',
    'INPUT_VEH_MELEE_RIGHT',
    'INPUT_MAP_POI',
    'INPUT_REPLAY_SNAPMATIC_PHOTO',
    'INPUT_VEH_CAR_JUMP',
    'INPUT_VEH_ROCKET_BOOST',
    'INPUT_VEH_FLY_BOOST',
    'INPUT_VEH_PARACHUTE',
    'INPUT_VEH_BIKE_WINGS',
    'INPUT_VEH_FLY_BOMB_BAY',
    'INPUT_VEH_FLY_COUNTER',
    'INPUT_VEH_TRANSFORM'
    }
    return keyText[key]
end

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

RegisterNetEvent('ebu_toggles:eOn')
AddEventHandler('ebu_toggles:eOn', function(srcveh, bHealth, eHealth, fHealth, tires, num)
    SetVehicleExtra(srcveh, num, 0)
    Citizen.Wait(200)

	SetVehicleFixed(srcveh)
    SetVehicleDeformationFixed(srcveh)
    
    Citizen.Wait(200)
    SetVehicleExtra(srcveh, num, 0)
    SetVehicleBodyHealth(srcveh, bHealth)
    SetVehicleEngineHealth(srcveh, eHealth)
    SetVehiclePetrolTankHealth(srcveh, fHealth)
    for i = 1, #tires, 1 do
        if tires[i] > 0 then
            SetVehicleTyreBurst(srcveh, i, 0, tires[i]+0.0)
        end
    end
end)

RegisterNetEvent('ebu_toggles:update')
AddEventHandler('ebu_toggles:update', function(num, srcvehicle)
	theebuTEN(srcvehicle,num)
end)

RegisterNetEvent('ebu_toggles:actorupdate')
AddEventHandler('ebu_toggles:actorupdate', function()
	theebuTE()
end)