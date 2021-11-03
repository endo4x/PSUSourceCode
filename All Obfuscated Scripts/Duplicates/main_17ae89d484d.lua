--[[
	id: _hBRwAseg1DbUVEKmySkX
	name: main
	description: main
	time1: 2021-05-12 09:07:39.380846+00
	time2: 2021-05-12 09:07:39.380847+00
	uploader: N-jXzeZS6oIjI8r0Bj2T0MQLZfS_rwgVeb64Gt8E
	uploadersession: 2npRlbj9ii5-sLy8PCktD-HWguiDX-
	flag: t
--]]

ESX = nil

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(100)
        end
        ESX.PlayerData = ESX.GetPlayerData()
    end
)

for k, v in pairs(Config.item) do
    local onSpawn = false
    local HandObject = nil
    RegisterNetEvent("" .. v.itemname .. ":SPAWN")
    AddEventHandler(
        "" .. v.itemname .. ":SPAWN",
        function(CurrentZone)
            if not onSpawn then
                HandObject = CreateObject(GetHashKey(CurrentZone.Model), x, y, z, true, true, true)
                AttachEntityToEntity(
                    HandObject,
                    GetPlayerPed(-1),
                    GetPedBoneIndex(GetPlayerPed(-1), CurrentZone.Bone),
                    CurrentZone.xPos,
                    CurrentZone.yPos,
                    CurrentZone.zPos,
                    CurrentZone.xRot,
                    CurrentZone.yRot,
                    CurrentZone.zRot,
                    true,
                    true,
                    false,
                    true,
                    0,
                    true
                )
                onSpawn = true
            else
                DeleteObject(HandObject)
                onSpawn = false
            end
        end
    )
end

local countobj = 0
RegisterNetEvent("KT:DELETALL")
AddEventHandler(
    "KT:DELETALL",
    function()
        countobj = 0
        --	print("DelProp")
        while true do
            Wait(0)
            if countobj < 50 then
                countobj = countobj + 1
                for k, v in pairs(Config.item) do
                    local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 10.0, 0.0)
                    local coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 10.0, 0.0, 0.0)
                    local clobj =
                        GetClosestObjectOfType(
                        coords.x,
                        coords.y,
                        coords.z,
                        100.0 --[[ number ]],
                        GetHashKey(v.Model) --[[ Hash ]],
                        false --[[ boolean ]],
                        false --[[ boolean ]],
                        false --[[ boolean ]]
                    )
                    if IsEntityAttachedToAnyPed(clobj) then
                        --					print(clobj)
                    else
                        --					print("DelProp "..clobj)
                        DeleteObject(clobj)
                    end
                    local clobj2 =
                        GetClosestObjectOfType(
                        coords2.x,
                        coords2.y,
                        coords2.z,
                        100.0 --[[ number ]],
                        GetHashKey(v.Model) --[[ Hash ]],
                        false --[[ boolean ]],
                        false --[[ boolean ]],
                        false --[[ boolean ]]
                    )
                    if IsEntityAttachedToAnyPed(clobj2) then
                        --					print(clobj2)
                    else
                        --					print("DelProp "..clobj)
                        DeleteObject(clobj2)
                    end
                end
            else
                break
            end
        end
    end
)
