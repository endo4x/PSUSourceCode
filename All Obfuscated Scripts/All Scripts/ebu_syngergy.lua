--[[
	id: XGqW4X5TQc-3nt9QHrYHU
	name: ebu_syngergy
	description: ebu_syngergy
	time1: 2021-04-23 14:50:41.657851+00
	time2: 2021-04-23 14:50:41.657852+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

local u ={}
local d = {}
local curVeh = {}
local ped = GetPlayerPed(-1)
local attached = false
local axisnum = 4
local isValid = false
local inAnim = false
local remoteVeh = {}

local baggdsVehs = {
    [GetHashKey("libexcavator")] ={
        chkVal = 202199,
        axis = {
            { 
                door = 5,
                speed = 0.005
            },
            { 
                door = 4,
                speed = 0.005
            },
            { 
                door = 3,
                speed = 0.002,
                spin = true
            },
            { 
                door = 2,
                speed = 0.005
            }
        },
        toggles = {
            {
                num = 1
            }
        }
    },
    [GetHashKey("bct590")] ={
        chkVal = 202199,
        axis = {
            { 
                door = 5,
                speed = 0.005
            },
            { 
                door = 4,
                speed = 0.005
            },
            { 
                door = 3,
                speed = 0.002,
                spin = true
            },
            { 
                door = 2,
                speed = 0.005
            }
        },
        toggles = {
            {
                num = 1
            }
        }
    },
    [GetHashKey("bcbucket")] ={
        chkVal = 202199,
        axis = {
            { 
                door = 5,
                speed = 0.001
            },
            { 
                door = 4,
                speed = 0.001
            },
            { 
                door = 3,
                speed = 0.001,
                spin = true
            },
            { 
                door = 2,
                speed = 0.001,
                spin = true

            }
        },
        swapSeat = 'misc_a',
        extBone = 'door_dside_r',
        dict = 'anim@amb@yacht@rail@standing@female@variant_01@',
        anim = 'idle_b',
        dict2 = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
        anim2 = 'weed_stand_checkingleaves_idle_05_inspector',
        playingdict =  'anim@amb@yacht@rail@standing@female@variant_01@',
        playinganim = 'idle_b',
        animNum = 1,
        toggles = {
            {
                num = 1
            }
        }
    },
}

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
        disposeFunc(iter)
        return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function enum_veh()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetEntInFrontOfPlayer(player)
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
      RequestAnimDict(dict)
      Wait(10)
    end
  end

local function isPedDrivingValidVehicle()
    local vehicle = GetVehiclePedIsUsing(ped)
    for k, v in pairs(baggdsVehs) do
        if k == GetEntityModel(vehicle) and IsPedInAnyVehicle(ped, false) then
            if ((GetPedInVehicleSeat(vehicle, -1) == ped) or (curVeh.car and (GetPedInVehicleSeat(curVeh.car, curVeh.swapSeat) == ped))) --[[and GetEntityBoneIndexByName(vehicle, "misc_h") ~= -1 and v.chkVal == GetVehicleHandlingInt(vehicle, 'CHandlingData', 'nMonetaryValue')]] then
                curVeh = baggdsVehs[k]
                curVeh.car = vehicle
                return true	
            end
        elseif attached and k == GetEntityModel(GetVehiclePedIsIn(ped, true)) then
            curVeh = baggdsVehs[k]
            curVeh.car = vehicle
            return true	
        end
        if remoteVeh.car then
            curVeh = remoteVeh
            return true	

        end
    end
	return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        ped = GetPlayerPed(-1)

        if isPedDrivingValidVehicle() then
            isValid = true
        else
            isValid = false
        end
    end
end)

local busy = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isValid then
            for i = 1, axisnum, 1 do
                if u[i] then
                    local angle = GetVehicleDoorAngleRatio(curVeh.car, curVeh.axis[i].door)
                    if angle + curVeh.axis[i].speed > 0.999 then
                        if curVeh.axis[i].spin == true then
                            if angle + curVeh.axis[i].speed > 0.999 then
                                SetVehicleDoorControl(curVeh.car, curVeh.axis[i].door, 10000, 0.001)
                            end
                        else
                            SetVehicleDoorControl(curVeh.car, curVeh.axis[i].door, 500, 0.999)
                        end
                    else
                        SetVehicleDoorControl(curVeh.car, curVeh.axis[i].door, 500, angle + curVeh.axis[i].speed)
                    end

                elseif d[i] then
                    local angle = GetVehicleDoorAngleRatio(curVeh.car, curVeh.axis[i].door)
                    if angle - curVeh.axis[i].speed < 0.005 then
                        if curVeh.axis[i].spin == true then
                            if angle - curVeh.axis[i].speed < 0.005 then
                                SetVehicleDoorControl(curVeh.car, curVeh.axis[i].door, 10000, 0.999)
                            end
                        else
                            SetVehicleDoorControl(curVeh.car, curVeh.axis[i].door, 500, 0.005)
                        end
                    else
                        SetVehicleDoorControl(curVeh.car, curVeh.axis[i].door, 500, angle - curVeh.axis[i].speed)
                    end
                end
                if GetVehicleDoorAngleRatio(curVeh.car, curVeh.axis[i].door) <= 0.0 then
                    SetVehicleDoorControl(curVeh.car, curVeh.axis[i].door, 10000, 0.005)
                end
                if u[i] or d[i] then
                    
                    SetVehicleCurrentRpm(curVeh.car, 0.5)
                    SetVehicleSilent(curVeh.car, true)
                else
                    SetVehicleSilent(curVeh.car, false)
                end
            end
            if curVeh.swapSeat and attached then
                if curVeh.dict and curVeh.anim and inAnim == false then
                    inAnim = true
                    LoadAnim(curVeh.playingdict)
                    TaskPlayAnim(ped, curVeh.playingdict, curVeh.playinganim, 2.0, 2.0, -1, 1, 0, false, false, false)
                    RemoveAnimDict(curVeh.playingdict)
                end
            elseif attached == false and inAnim == true and curVeh.dict and curVeh.anim then
                ClearPedTasks(ped)
                inAnim = false
            end
        end
        if IsControlJustPressed(0, 23) then
            if not attached then
                local chkCar
                for car in enum_veh() do
                    for k, v in pairs(baggdsVehs) do
                        if k == GetEntityModel(car) then
                            if baggdsVehs[k].extBone then
                                local cvehicleCoords =  GetEntityCoords(car)
                                if GetDistanceBetweenCoords(GetEntityCoords(ped), GetWorldPositionOfEntityBone(car, GetEntityBoneIndexByName(car, baggdsVehs[k].extBone)), true) < 1.5 then
                                    chkCar = car
                                    remoteVeh = baggdsVehs[k]
                                    remoteVeh.car = chkCar
                                    break
                                end
                            end
                        end
                    end
                end
                if chkCar then
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), GetWorldPositionOfEntityBone(chkCar, GetEntityBoneIndexByName(chkCar, remoteVeh.extBone), true)) < 1.5 then
                        ClearPedTasks(ped)

                        
                        SetPedIntoVehicle(ped, remoteVeh.car, -1)
                        Citizen.Wait(20)
                        TaskLeaveVehicle(ped, remoteVeh.car, 16)
                        Citizen.Wait(10)

                        AttachEntityToEntity(ped, remoteVeh.car, GetEntityBoneIndexByName(remoteVeh.car, remoteVeh.swapSeat), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 0, 1, 0, 0, 1)

                        attached = true
                    end
                    
                end
                
            else
                DetachEntity(ped, 0, 1)
                ClearPedTasks(ped)
                attached = false
                remoteVeh = {}
            end
        end
        if attached and IsControlJustPressed(0, 34) and busy == false then
            Citizen.CreateThread(function()
                busy = true
                local pRot = GetEntityRotation(ped, 2)
                AttachEntityToEntity(ped, remoteVeh.car, GetEntityBoneIndexByName(remoteVeh.car, remoteVeh.swapSeat), 0.0, 0.0, 0.0, 0.0, 0.0, pRot.z + 45, 1, 0, 1, 0, 0, 1)
                Citizen.Wait(500)
                busy = false
            end)
        end
        if attached and IsControlJustPressed(0, 35) and busy == false then
            Citizen.CreateThread(function()
                busy = true
                local pRot = GetEntityRotation(ped, 2)
                AttachEntityToEntity(ped, remoteVeh.car, GetEntityBoneIndexByName(remoteVeh.car, remoteVeh.swapSeat), 0.0, 0.0, 0.0, 0.0, 0.0, pRot.z - 45, 1, 0, 1, 0, 0, 1)
                Citizen.Wait(500)
                busy = false
            end)
        end
        if attached and IsControlJustPressed(0, 32) then
            ClearPedTasks(ped)

            local newAnim = remoteVeh.animNum + 1
            if newAnim > 2 then newAnim = 1 end
            remoteVeh.animNum = newAnim
            if newAnim == 2 then
                remoteVeh.playingdict = remoteVeh.dict2
                remoteVeh.playinganim = remoteVeh.anim2
            elseif newAnim == 1 then
                remoteVeh.playingdict = remoteVeh.dict
                remoteVeh.playinganim = remoteVeh.anim
            end
            LoadAnim(remoteVeh.playingdict)
            TaskPlayAnim(ped, remoteVeh.playingdict, remoteVeh.playinganim, 2.0, 2.0, -1, 1, 0, false, false, false)
            RemoveAnimDict(remoteVeh.playingdict)
        end
    end
end)


for i = 1, axisnum, 1 do
    RegisterCommand('+angleUp'..i, function()
        if isValid then
            u[i] = true
        end
    end, false)
    RegisterCommand('-angleUp'..i, function()
        if isValid then
            u[i] = false
        end
    end, false)
    RegisterCommand('+angleDown'..i, function()
        if isValid then
            d[i] = true
        end
    end, false)
    RegisterCommand('-angleDown'..i, function()
        if isValid then
            d[i] = false
        end
    end, false)
end
--[[RegisterCommand('+toggleExtra', function()
    if isValid then
        if IsVehicleExtraTurnedOn(curVeh.car, 1) then
            SetVehicleExtra(curVeh.car, 1, 0)
        else
            SetVehicleExtra(curVeh.car, 1, 1)
        end
    end
end, false)

RegisterCommand('-toggleExtra', function()
end, false)]]
RegisterCommand('+swapSeat', function()
    if isValid then
        if curVeh.swapSeat then
            local ped = GetPlayerPed(-1)
            if GetPedInVehicleSeat(curVeh.car, -1) == ped and attached == false then
                TaskLeaveVehicle(ped, curVeh.car, 16)
                remoteVeh = curVeh
                Citizen.Wait(10)
                AttachEntityToEntity(ped, remoteVeh.car, GetEntityBoneIndexByName(remoteVeh.car, remoteVeh.swapSeat), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 0, 1, 0, 0, 1)

                attached = true
            elseif attached == true then
                DetachEntity(ped, 0, 1)
                Citizen.Wait(10)
                if IsVehicleSeatFree(remoteVeh.car, -1) then
                    SetPedIntoVehicle(ped, remoteVeh.car, -1)
                else
                    ClearPedTasks(ped)
                end
                remoteVeh = {}
                attached = false
            end
        end
    end
end, false)

RegisterCommand('-swapSeat', function()
end, false)

RegisterKeyMapping('+angleUp1', 'Axis1 +', 'keyboard', 'NUMPAD2')
RegisterKeyMapping('+angleDown1', 'Axis1 -', 'keyboard', 'NUMPAD8')
RegisterKeyMapping('+angleUp2', 'Axis2 +', 'keyboard', 'NUMPAD4')
RegisterKeyMapping('+angleDown2', 'Axis2 -', 'keyboard', 'NUMPAD6')
RegisterKeyMapping('+angleUp3', 'Axis3 +', 'keyboard', 'NUMPAD7')
RegisterKeyMapping('+angleDown3', 'Axis3 -', 'keyboard', 'NUMPAD9')
RegisterKeyMapping('+angleUp4', 'Axis4 +', 'keyboard', 'NUMPAD1')
RegisterKeyMapping('+angleDown4', 'Axis4 -', 'keyboard', 'NUMPAD3')
RegisterKeyMapping('+swapSeat', 'Swap seat', 'keyboard', 'DIVIDE')

--RegisterKeyMapping('+toggleExtra', 'Toggle Extra', 'keyboard', 'NUMPAD5')