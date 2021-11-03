--[[
	id: hux0wlqE7d8HGX3XTuZo8
	name: This is test script
	description: It is a client.lua
	time1: 2021-05-24 14:55:19.506054+00
	time2: 2021-05-24 14:55:19.506055+00
	uploader: OxDeUN5rs1EZZuAbYBR1bW0Hlwnyp7-WSB_DhpVH
	uploadersession: Y54RQCFvnIGvACtS-x5XOcRNzV7Z78
	flag: f
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
            Citizen.Wait(100)
        end
    end
)

local isFixing = false
local ragdoll = false
local currentMissions = {}

RegisterNetEvent("esx_electrician:blackoutState")

AddEventHandler(
    "onResourceStop",
    function(resource)
        if GetCurrentResourceName() ~= resource then
            return
        end

        for k, mission in pairs(currentMissions) do
            RemoveBlip(mission.Blip)
        end

        TriggerServerEvent("esx_electrician:setBlackoutState", false)
    end
)

RegisterNetEvent("esx_electrician:createBlackoutMission")
AddEventHandler(
    "esx_electrician:createBlackoutMission",
    function(missionSpots)
        Citizen.Wait(500)

        local blipOpt = Config.MissionOpt.Blip
        for k, mission in pairs(missionSpots) do
            local blip = createBlip(mission.pos, blipOpt.Name, blipOpt.Sprite, blipOpt.Color, 1.2, false, true)
            table.insert(
                currentMissions,
                {
                    pos = mission.pos,
                    isBroken = mission.isBroken,
                    Blip = blip
                }
            )
        end

        Citizen.CreateThreadNow(
            function()
                while GetConvarBool("vmenu_blackout_enabled") do
                    drawTxt(
                        0.5,
                        0.915,
                        0.5,
                        "Have some problem with the ~y~power generator~w~ and we need to fix it.",
                        255,
                        255,
                        255,
                        255
                    )
                    drawTxt(
                        0.5,
                        0.95,
                        0.5,
                        "It's only ~y~1 generator~w~ is ~r~broken~w~, try to find it out!",
                        250,
                        255,
                        255,
                        255
                    )
                    Citizen.Wait(5)
                end
            end
        )
    end
)

RegisterNetEvent("esx_electrician:onFixingSuccess")
AddEventHandler(
    "esx_electrician:onFixingSuccess",
    function(missionKey, fixerName)
        if not currentMissions[missionKey].isBroken then
            RemoveBlip(currentMissions[missionKey].Blip)
            table.remove(currentMissions, missionKey)
            return
        end

        for k, mission in pairs(currentMissions) do
            RemoveBlip(mission.Blip)
            currentMissions[k] = nil
        end

        TriggerEvent(
            "chat:addMessage",
            {
                args = {"Power generator has been fixed by " .. fixerName}
            }
        )
    end
)

RegisterNetEvent("esx_electrician:startFixing")
AddEventHandler(
    "esx_electrician:startFixing",
    function(missionId)
        local playerPed = PlayerPedId()

        isFixing = true
        FreezeEntityPosition(playerPed, true)
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

        local result =
            exports["xzero_skillcheck"]:startGameSync(
            {
                textTitle = "ซ่อมเครื่องจ่ายไฟ", -- ข้อความที่แสดง
                speedMin = 11, -- ความเร็วสุ่มตั้งแต่เท่าไหร่  (ยิ่งน้อยยิ่งเร็ว)
                speedMax = 13, -- ความเร็วสุ่มถึงเท่าไหร่    (ยิ่งน้อยยิ่งเร็ว)
                countSuccessMax = 1, -- กำหนดจำนวนครั้งที่สำเร็จ (เมื่อถึงเป้าจะ success)
                countFailedMax = 1 -- กำหนดจำนวนครั้งที่ล้มเหลว (เมื่อถึงเป้าจะ failed)
            }
        )

        if result.status then
            TriggerServerEvent("esx_electrician:fixingSuccess", missionId)
        else
            ragdoll = true
            Citizen.SetTimeout(
                10000,
                function()
                    ragdoll = false
                end
            )
            TriggerEvent(
                "chat:addMessage",
                {
                    args = {"You were shocked by electric from generator."}
                }
            )
        end

        isFixing = false
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
    end
)

-- Blackout State
Citizen.CreateThread(
    function()
        local markerOpt = Config.MissionOpt.Marker
        while true do
            local sleep = true

            if ESX ~= nil then
                if GetConvarBool("vmenu_blackout_enabled") and #currentMissions > 0 then
                    local playerPed = PlayerPedId()
                    local pedCoords = GetEntityCoords(playerPed)

                    for k, mission in pairs(currentMissions) do
                        if
                            GetDistanceBetweenCoords(
                                pedCoords.x,
                                pedCoords.y,
                                pedCoords.z,
                                mission.pos.x,
                                mission.pos.y,
                                mission.pos.z
                            ) <= markerOpt.DrawDistance
                         then
                            sleep = false
                        end

                        if not sleep then
                            DrawMarker(
                                1,
                                mission.pos.x,
                                mission.pos.y,
                                mission.pos.z - 1.5,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                1.5,
                                1.5,
                                1.5,
                                markerOpt.Color.R,
                                markerOpt.Color.G,
                                markerOpt.Color.B,
                                markerOpt.Color.A,
                                false,
                                true,
                                2,
                                nil,
                                nil,
                                false
                            )

                            if
                                GetDistanceBetweenCoords(
                                    pedCoords.x,
                                    pedCoords.y,
                                    pedCoords.z,
                                    mission.pos.x,
                                    mission.pos.y,
                                    mission.pos.z
                                ) <= 1.5
                             then
                                ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to Start fixing")

                                if not isFixing and not ragdoll and IsControlJustReleased(0, 38) then
                                    local playersInArea = ESX.Game.GetPlayersInArea(mission.pos, 1.5)

                                    if IsPedOnFoot(playerPed) then
                                        if #playersInArea <= 1 then
                                            TriggerEvent("esx_electrician:startFixing", k)
                                        else
                                            TriggerEvent(
                                                "chat:addMessage",
                                                {
                                                    args = {"You cannot fixing this while having other players nearby."}
                                                }
                                            )
                                        end
                                    else
                                        TriggerEvent(
                                            "chat:addMessage",
                                            {
                                                args = {"You cannot fixing this while in a vehicle."}
                                            }
                                        )
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if ragdoll then
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, false, false, false)
            end

            if sleep then
                Citizen.Wait(500)
            else
                Citizen.Wait(0)
            end
        end
    end
)

function createBlip(coords, name, sprite, color, scale, shortRange, flashed)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    SetBlipFlashes(blip, flashed)
    SetBlipAsShortRange(blip, shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)

    return blip
end

function removeBlips()
    for k, v in pairs(currentMissions) do
        RemoveBlip(v.Blip)
    end
end

function showHelpNotification(msg)
    AddTextEntry("HELP_NOTIFICATION", msg)
    BeginTextCommandDisplayHelp("HELP_NOTIFICATION")
    EndTextCommandDisplayHelp(0, false, false, -1)
end

function drawTxt(x, y, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(1)

    if (outline) then
        SetTextOutline()
    end

    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function drawText3D(coords, text, size, font)
    coords = vector3(coords.x, coords.y, coords.z)

    local camCoords = GetGameplayCamCoords()
    local distance = #(coords - camCoords)

    if not size then
        size = 1
    end
    if not font then
        font = 0
    end

    local scale = (size / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(font)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)

    SetDrawOrigin(coords, 0)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end
