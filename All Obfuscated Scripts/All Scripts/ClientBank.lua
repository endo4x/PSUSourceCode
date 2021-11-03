--[[
	id: inEfXHjVGo142v7hKesMS
	name: Client Bank
	description: d
	time1: 2021-05-07 17:02:13.835927+00
	time2: 2021-05-07 17:02:13.835928+00
	uploader: hjUpFtDLN3QU7fmgHl1akB62vmzv5vuxNoYxovYG
	uploadersession: 8BNCl5BZgzO0vcVA2kC6uZozDH1K_4
	flag: f
--]]

local maquina, enBlindado, IsPushing, Robando, Sync, Trunk, conteo = false, false, false, false, false, false, false
local elevador1, elevador2, inVault, atDoor, inC4 = false, false, false, false, false
local StandObject, vault, stockade, vaultBlip, c4, count = nil, nil, nil, nil, nil, 0
local boveda, roboActivo, tunel, C4triggered, atTrolly = false, false, false, false, false
local AnimationData = {lib = "missfinale_c2ig_11", anim = "pushcar_offcliff_f"}
local doors = {door1R = false, door2R = false, door1L = false, door2L = false}
local PlayerData = {}
ESX = nil

QBCore = nil

RegisterFontFile("A9eelsh")
fontId = RegisterFontId("A9eelsh")

Citizen.CreateThread(
    function()
        while QBCore == nil do
            TriggerEvent(
                "QBCore:GetObject",
                function(obj)
                    QBCore = obj
                end
            )
            Citizen.Wait(0)
        end

        while QBCore.Functions.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        PlayerData = QBCore.Functions.GetPlayerData()

        QBCore.Functions.TriggerCallback(
            "union:status",
            function(data)
                TriggerEvent("spawn:sync", data)
            end
        )
    end
)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler(
    "QBCore:Client:OnJobUpdate",
    function(job)
        PlayerData.job = job
    end
)

RegisterNetEvent("as-cprob:client:PoliceAlertMessage")
AddEventHandler(
    "as-cprob:client:PoliceAlertMessage",
    function(title, coords, blip, etapId)
        if blip then
            if etapId == "bank" then
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                Citizen.Wait(100)
                PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                Citizen.Wait(100)
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                Citizen.Wait(100)
                PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                local detail1 = "The Golden bank"
                local camids = "31 | 32 | 33 | 34"
                local locationname = "Rockford Dr"
                local blipname = "The Golden bank"
                TriggerEvent(
                    "qb-policealerts:client:AddPoliceAlert",
                    {
                        timeOut = 5000,
                        alertTitle = title,
                        coords = {
                            x = coords.x,
                            y = coords.y,
                            z = coords.z
                        },
                        details = {
                            [1] = {
                                icon = '<i class="fas fa-gem"></i>',
                                detail = detail1
                            },
                            [2] = {
                                icon = '<i class="fas fa-globe-europe"></i>',
                                detail = locationname
                            }
                        },
                        callSign = QBCore.Functions.GetPlayerData().metadata["callsign"]
                    }
                )
                ---------------------------blip----------------------------
                local transG = 250
                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                local blipSprite = 313
                SetBlipSprite(blip, blipSprite)
                SetBlipColour(blip, 1)
                SetBlipDisplay(blip, 4)
                SetBlipAlpha(blip, transG)
                SetBlipScale(blip, 0.8)
                SetBlipAsShortRange(blip, false)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipname)
                EndTextCommandSetBlipName(blip)
                while transG ~= 0 do
                    Wait(180 * 4)
                    transG = transG - 1
                    SetBlipAlpha(blip, transG)
                    if transG == 0 then
                        SetBlipSprite(blip, 2)
                        RemoveBlip(blip)
                        return
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        if Config.Blips then
            blip = AddBlipForCoord(Config.StockadeDoor.x, Config.StockadeDoor.y, Config.StockadeDoor.z)
            SetBlipSprite(blip, 84)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Union Depository Heist")
            EndTextCommandSetBlipName(blip)
        end

        exports["bt-target"]:AddTargetModel(
            "prop_large_gold",
            {
                options = {
                    {
                        event = "union:grab",
                        icon = "fas fa-hands",
                        label = Config.Lang["grab_trolley"]
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionStockade",
            vector3(Config.StockadeDoor.x, Config.StockadeDoor.y, Config.StockadeDoor.z),
            3.9,
            3.9,
            {
                name = "UnionStockade",
                heading = Config.StockadeDoor.h,
                debugPoly = false,
                minZ = Config.StockadeDoor.z - 1.0,
                maxZ = Config.StockadeDoor.z + 1.0
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionStockadeTrunk",
            vector3(-5.2306041717529, -662.52868652344, 33.480575561523),
            5.9,
            7.9,
            {
                name = "UnionStockadeTrunk",
                heading = 184.55,
                debugPoly = false,
                minZ = 32.00,
                maxZ = 35.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "Union1",
            vector3(10.323327064514, -671.12463378906, 33.449569702148),
            3.9,
            3.9,
            {
                name = "Union1",
                heading = 5.60,
                debugPoly = false,
                minZ = 32.00,
                maxZ = 35.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "Union2",
            vector3(0.024759439751506, -705.65338134766, 16.131278991699),
            3.9,
            3.9,
            {
                name = "Union2",
                heading = 5.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionVault",
            vector3(-3.6113374233246, -686.68933105469, 16.130599975586),
            3.9,
            4.9,
            {
                name = "UnionVault",
                heading = 342.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionDoor4",
            vector3(-0.34970524907112, -672.06243896484, 16.130834579468),
            1.9,
            2.4,
            {
                name = "UnionDoor4",
                heading = 342.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionDoor3",
            vector3(-2.5013537406921, -677.59820556641, 16.130834579468),
            1.9,
            2.4,
            {
                name = "UnionDoor3",
                heading = 342.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionDoor2",
            vector3(3.0064339637756, -673.55706787109, 16.130828857422),
            1.9,
            2.4,
            {
                name = "UnionDoor2",
                heading = 342.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionDoor1",
            vector3(1.1386114358902, -679.07415771484, 16.130834579468),
            1.9,
            2.4,
            {
                name = "UnionDoor1",
                heading = 342.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "Trolley1",
            vector3(4.6465306282043, -679.90228271484, 16.130838394165),
            2.9,
            2.9,
            {
                name = "Trolley1",
                heading = 188.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "Trolley2",
            vector3(6.1812934875488, -674.46124267578, 16.130863189697),
            2.9,
            2.9,
            {
                name = "Trolley2",
                heading = 181.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "Trolley3",
            vector3(-6.0258188247681, -676.88635253906, 16.130838394165),
            2.9,
            2.9,
            {
                name = "Trolley3",
                heading = 8.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "Trolley4",
            vector3(-3.3287537097931, -671.33679199219, 16.130863189697),
            2.9,
            2.9,
            {
                name = "Trolley4",
                heading = 74.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionC4",
            vector3(6.3249225616455, -659.62976074219, 16.130836486816),
            1.9,
            4.9,
            {
                name = "UnionC4",
                heading = 339.20,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )

        exports["bt-polyzone"]:AddBoxZone(
            "UnionSync",
            vector3(6.5215892791748, -696.32232666016, 16.13129234314),
            9.9,
            12.9,
            {
                name = "UnionSync",
                heading = 342.60,
                debugPoly = false,
                minZ = 15.00,
                maxZ = 17.00
            }
        )
    end
)

RegisterNetEvent("c4:sync")
AddEventHandler(
    "c4:sync",
    function(data)
        C4triggered = true
        local handle = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, "des_finale_tunnel")
        local handle2 = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, "des_finale_vault")
        SetStateOfRayfireMapObject(handle, 4)
        SetStateOfRayfireMapObject(handle2, 4)
        Citizen.Wait(100)
        if #(GetEntityCoords(PlayerPedId()) - vector3(6.324, -659.62, 16.13)) < 100 then
            RequestNamedPtfxAsset("scr_josh3")
            while not HasNamedPtfxAssetLoaded("scr_josh3") do
                Citizen.Wait(1)
            end
            UseParticleFxAssetNextCall("scr_josh3")
            explo1 =
                StartParticleFxLoopedAtCoord(
                "scr_josh3_explosion",
                6.60,
                -658.55,
                15.38,
                0.0,
                0.0,
                0.0,
                3.0,
                false,
                false,
                false,
                0
            )
            SetStateOfRayfireMapObject(handle, 6)
            SetStateOfRayfireMapObject(handle2, 6)
            AddExplosion(
                6.3691420555115,
                -659.21508789063,
                16.130836486816,
                GetHashKey("EXPLOSION_TANKER"),
                2.0,
                true,
                false,
                2.0
            )
            PlaySoundFromCoord(-1, "MAIN_EXPLOSION_CHEAP", 6.60, -658.55, 15.38, 0, 0, 0, 0)
            Citizen.CreateThread(
                function()
                    Citizen.Wait(10)
                    while GetRayfireMapObjectAnimPhase(handle) > 0.0 do
                        Citizen.Wait(0)
                    end
                    while GetRayfireMapObjectAnimPhase(handle2) > 0.0 do
                        Citizen.Wait(0)
                    end
                end
            )
        end
    end
)

RegisterNetEvent("spawn:sync")
AddEventHandler(
    "spawn:sync",
    function(data)
        RemoveBlip(vaultBlip)
        vaultBlip = nil
        boveda = data.vault
        roboActivo = data.active
        vault =
            GetClosestObjectOfType(
            -1.727947,
            -686.5417,
            16.68913,
            2.0,
            GetHashKey("v_ilev_fin_vaultdoor"),
            false,
            false,
            false
        )
        if vault ~= 0 and vault ~= nil then
            if not boveda then
                FreezeEntityPosition(vault, true)
                StopAlarm("BIG_SCORE_HEIST_VAULT_ALARMS", -1)
            else
                FreezeEntityPosition(vault, false)
                if Config.TriggerAlarm then
                    while not PrepareAlarm("BIG_SCORE_HEIST_VAULT_ALARMS") do
                        Citizen.Wait(0)
                    end
                    StartAlarm("BIG_SCORE_HEIST_VAULT_ALARMS", 1)
                end
            end
        end
    end
)

RegisterNetEvent("bt-polyzone:enter")
AddEventHandler(
    "bt-polyzone:enter",
    function(name)
        if name == "UnionStockade" then
            enBlindado = true
            Stockade()
        elseif name == "UnionStockadeTrunk" then
            StockadeGold()
        elseif name == "UnionSync" then
            if not Sync then
                Sync = true
                QBCore.Functions.TriggerCallback(
                    "union:status",
                    function(data)
                        TriggerEvent("spawn:sync", data)
                    end
                )
            end
        elseif name == "Union1" then
            elevador1 = true
            TP1()
        elseif name == "Union2" then
            elevador2 = true
            TP2()
        elseif name == "UnionVault" then
            inVault = true
            VaultHack()
        elseif name == "UnionDoor1" then
            atDoor = true
            ThermiteDoor(Config.Doors.door1)
        elseif name == "UnionDoor2" then
            atDoor = true
            ThermiteDoor(Config.Doors.door2)
        elseif name == "UnionDoor3" then
            atDoor = true
            ThermiteDoor(Config.Doors.door3)
        elseif name == "UnionDoor4" then
            atDoor = true
            ThermiteDoor(Config.Doors.door4)
        elseif name == "Trolley1" then
            atTrolly = true
            Trolley3D()
        elseif name == "Trolley2" then
            atTrolly = true
            Trolley3D()
        elseif name == "Trolley3" then
            atTrolly = true
            Trolley3D()
        elseif name == "Trolley4" then
            atTrolly = true
            Trolley3D()
        elseif name == "UnionC4" then
            if Config.Tunnel then
                inC4 = true
                C4()
            end
        end
    end
)

RegisterNetEvent("bt-polyzone:exit")
AddEventHandler(
    "bt-polyzone:exit",
    function(name)
        if name == "UnionStockade" then
            enBlindado = false
        elseif name == "UnionStockadeTrunk" then
            Trunk = false
        elseif name == "Union1" then
            elevador1 = false
        elseif name == "Union2" then
            elevador2 = false
        elseif name == "UnionVault" then
            inVault = false
        elseif name == "UnionDoor1" then
            atDoor = false
        elseif name == "UnionDoor2" then
            atDoor = false
        elseif name == "UnionDoor3" then
            atDoor = false
        elseif name == "UnionDoor4" then
            atDoor = false
        elseif name == "Trolley1" then
            atTrolly = false
        elseif name == "Trolley2" then
            atTrolly = false
        elseif name == "Trolley3" then
            atTrolly = false
        elseif name == "Trolley4" then
            atTrolly = false
        elseif name == "UnionC4" then
            inC4 = false
        end
    end
)

function Stockade()
    LoadAnim("timetable@jimmy@doorknock@")
    Citizen.CreateThread(
        function()
            while enBlindado do
                Citizen.Wait(5)
                if PlayerData.job.name ~= Config.PoliceJobName and not roboActivo then
                    DrawText3Ds(1006.9895629883, -1556.1385498047, 31.022470474243, Config.Lang["knock_door"])
                    if IsControlJustPressed(0, 74) then
                        QBCore.Functions.TriggerCallback(
                            "union:cooldown",
                            function(cooldown)
                                if cooldown then
                                    QBCore.Functions.Notify(Config.Lang["cooldown_active"])
                                else
                                    if Config.StockadeItem then
                                        QBCore.Functions.TriggerCallback(
                                            "union:item",
                                            function(keycard)
                                                if keycard then
                                                    enBlindado = false
                                                    TaskPlayAnim(
                                                        PlayerPedId(),
                                                        "timetable@jimmy@doorknock@",
                                                        "knockdoor_idle",
                                                        1.0,
                                                        -1.0,
                                                        1.0,
                                                        0,
                                                        0,
                                                        0,
                                                        0,
                                                        0
                                                    )
                                                    Citizen.Wait(3500)
                                                    TriggerEvent("union:blindadoSpawn")
                                                else
                                                    QBCore.Functions.Notify(Config.Lang["missing_keycard"])
                                                end
                                            end,
                                            Config.StockadeItemName
                                        )
                                    else
                                        enBlindado = false
                                        TaskPlayAnim(
                                            PlayerPedId(),
                                            "timetable@jimmy@doorknock@",
                                            "knockdoor_idle",
                                            1.0,
                                            -1.0,
                                            1.0,
                                            0,
                                            0,
                                            0,
                                            0,
                                            0
                                        )
                                        Citizen.Wait(3500)
                                        TriggerEvent("union:blindadoSpawn")
                                    end
                                end
                            end
                        )
                    end
                end
            end
        end
    )
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
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
        end
    )
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

t1 = function()
    local vehicles = {}

    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end

    return vehicles
end

t2 = function(coords)
    local vehicles = t1()
    local closestDistance = -1
    local closestVehicle = -1
    local coords = coords

    if coords == nil then
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end

    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end

    return closestVehicle, closestDistance
end

function StockadeGold()
    local coords = GetEntityCoords(PlayerPedId())
    local stockadeVeh = t2(coords)
    if vaultBlip ~= nil then
        RemoveBlip(vaultBlip)
        vaultBlip = nil
    end
    if GetEntityModel(stockadeVeh) == GetHashKey("stockade") then
        stockadeCoords = GetEntityCoords(stockadeVeh)
        if #(coords - stockadeCoords) < 10 and not roboActivo then
            Trunk = true
            Citizen.CreateThread(
                function()
                    while Trunk do
                        Citizen.Wait(5)
                        DrawText3Ds(stockadeCoords.x, stockadeCoords.y, stockadeCoords.z, Config.Lang["open_trunk"])
                        if IsControlJustPressed(0, 74) then
                            Trunk = false
                            TriggerServerEvent("union:active", true)
                            SetVehicleDoorOpen(stockadeVeh, 2, false, false)
                            SetVehicleDoorOpen(stockadeVeh, 3, false, false)
                            Citizen.Wait(150)

                            SpawnGold()
                        end
                    end
                end
            )
        end
    end
end

t3 = function(entity, coords, cb)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)

    while not HasCollisionLoadedAroundEntity(entity) do
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        Citizen.Wait(0)
    end

    SetEntityCoords(entity, coords.x, coords.y, coords.z)

    if cb then
        cb()
    end
end

function TP1()
    Citizen.CreateThread(
        function()
            while elevador1 do
                Citizen.Wait(5)
                DrawText3Ds(11.936079025269, -668.87902832031, 34.149489593506, Config.Lang["elevator"])
                if IsControlJustPressed(0, 74) then
                    DoScreenFadeOut(1000)
                    Citizen.Wait(1500)
                    t3(PlayerPedId(), {x = -0.33, y = -706.79, z = 16.13, heading = 340.58})
                    Citizen.Wait(800)
                    DoScreenFadeIn(2600)
                end
            end
        end
    )
end

function TP2()
    Citizen.CreateThread(
        function()
            while elevador2 do
                Citizen.Wait(5)
                DrawText3Ds(2.162335395813, -704.53497314453, 16.431706237793, Config.Lang["elevator"])
                if IsControlJustPressed(0, 74) then
                    DoScreenFadeOut(1000)
                    Citizen.Wait(1500)
                    t3(PlayerPedId(), {x = 10.57, y = -671.01, z = 33.44, heading = 3.19})
                    Citizen.Wait(800)
                    DoScreenFadeIn(2600)
                end
            end
        end
    )
end

function VaultHack()
    if PlayerData.job.name == Config.PoliceJobName and boveda then
        Citizen.CreateThread(
            function()
                while inVault do
                    Citizen.Wait(5)
                    DrawText3Ds(-3.7042701244354, -687.25836181641, 16.130613327026, Config.Lang["police_vault"])
                    if IsControlJustPressed(0, 74) then
                        TriggerServerEvent("union:vault", false)
                        inVault = false
                    end
                end
            end
        )
    elseif PlayerData.job.name ~= Config.PoliceJobName and not boveda and roboActivo then
        Citizen.CreateThread(
            function()
                while inVault do
                    Citizen.Wait(5)
                    local ped = GetPlayerPed(-1)
                    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
                    DrawText3Ds(-3.7042701244354, -687.25836181641, 16.130613327026, Config.Lang["vault_hack"])
                    if IsControlJustPressed(0, 74) then
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", -1, true)
                        TriggerServerEvent(
                            "as-cprob:server:PoliceAlertMessage",
                            "البنك الذهبي",
                            plyCoords,
                            true,
                            "bank"
                        )
                        Citizen.Wait(3000)
                        TriggerEvent("mhacking:show")
                        TriggerEvent("mhacking:start", Config.HackBlocks, Config.HackTime, hackeoEvent)
                    end
                end
            end
        )
    end
end

function SpawnMoney()
    RequestModel("hei_prop_hei_cash_trolly_01")
    Citizen.Wait(100)
    Money1 = CreateObject(269934519, 5.061, -680.50, 15.13, 1, 0, 0) -- 1st Right
    Money2 = CreateObject(269934519, 6.32, -674.99, 15.13, 1, 0, 0) -- 2nd Right
    Money3 = CreateObject(269934519, -6.13, -676.20, 15.13, 1, 0, 0) -- 1st Left
    Money4 = CreateObject(269934519, -3.97, -671.06, 15.13, 1, 0, 0) -- 2nd Left
end

function ThermiteDoor(door)
    local coords = GetEntityCoords(PlayerPedId())
    local puerta = GetClosestObjectOfType(coords, 1.0, 3283274690, false, false, false)
    Citizen.CreateThread(
        function()
            while atDoor do
                Citizen.Wait(5)
                if door.locked then
                    if PlayerData.job.name ~= Config.PoliceJobName then
                        DrawText3Ds(door.x, door.y - 1.0, door.z + 1.0, Config.Lang["use_thermite"])
                        if IsControlJustPressed(0, 74) then
                            QBCore.Functions.TriggerCallback(
                                "union:item",
                                function(thermita)
                                    if thermita then
                                        TriggerEvent("union:usarTermita", puerta, door)
                                        atDoor = false
                                        door.locked = false
                                    else
                                        QBCore.Functions.Notify(Config.Lang["no_thermite"])
                                    end
                                end,
                                Config.ThermiteItemName
                            )
                        end
                    end
                end
            end
        end
    )
end

function Trolley3D()
    local coords = GetEntityCoords(PlayerPedId())
    Trolley = GetClosestObjectOfType(coords, 2.0, 269934519, false, false, false) -- 1st Right
    local TrolleyCoords = GetEntityCoords(Trolley)
    Citizen.CreateThread(
        function()
            while atTrolly do
                Citizen.Wait(5)
                DrawText3Ds(TrolleyCoords.x, TrolleyCoords.y, TrolleyCoords.z, Config.Lang["trolley_loot"])
                if IsControlJustPressed(0, 74) then
                    if roboActivo then
                        Lootear(Trolley)
                    end
                end
            end
        end
    )
end

function Lootear(MoneyTrolley)
    Grab2clear = false
    Grab3clear = false
    Money = MoneyTrolley
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    local function AnimDinero()
        local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(100)
        end
        local grabobj = CreateObject(grabmodel, pedCoords, true)

        FreezeEntityPosition(grabobj, true)
        SetEntityInvincible(grabobj, true)
        SetEntityNoCollisionEntity(grabobj, ped)
        SetEntityVisible(grabobj, false, false)
        AttachEntityToEntity(
            grabobj,
            ped,
            GetPedBoneIndex(ped, 60309),
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            false,
            false,
            false,
            false,
            0,
            true
        )
        local startedGrabbing = GetGameTimer()

        Citizen.CreateThread(
            function()
                while GetGameTimer() - startedGrabbing < 37000 do
                    Citizen.Wait(1)
                    DisableControlAction(0, 73, true)
                    if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
                        if not IsEntityVisible(grabobj) then
                            SetEntityVisible(grabobj, true, false)
                        end
                    end
                    if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                        if IsEntityVisible(grabobj) then
                            SetEntityVisible(grabobj, false, false)
                        end
                    end
                end
                DeleteObject(grabobj)
                TriggerServerEvent("union:MakeItRain")
                atTrolly = false
            end
        )
    end
    local emptyobj = 769923921

    if IsEntityPlayingAnim(Money, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
        return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and
        not HasModelLoaded(baghash) do
        Citizen.Wait(100)
    end
    while not NetworkHasControlOfEntity(Money) do
        Citizen.Wait(1)
        NetworkRequestControlOfEntity(Money)
    end
    GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    Grab1 =
        NetworkCreateSynchronisedScene(
        GetEntityCoords(Money),
        GetEntityRotation(Money),
        2,
        false,
        false,
        1065353216,
        0,
        1.3
    )
    NetworkAddPedToSynchronisedScene(
        ped,
        Grab1,
        "anim@heists@ornate_bank@grab_cash",
        "intro",
        1.5,
        -4.0,
        1,
        16,
        1148846080,
        0
    )
    NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(Grab1)
    Citizen.Wait(1500)
    AnimDinero()
    if not Grab2clear then
        Grab2 =
            NetworkCreateSynchronisedScene(
            GetEntityCoords(Money),
            GetEntityRotation(Money),
            2,
            false,
            false,
            1065353216,
            0,
            1.3
        )
        NetworkAddPedToSynchronisedScene(
            ped,
            Grab2,
            "anim@heists@ornate_bank@grab_cash",
            "grab",
            1.5,
            -4.0,
            1,
            16,
            1148846080,
            0
        )
        NetworkAddEntityToSynchronisedScene(
            GrabBag,
            Grab2,
            "anim@heists@ornate_bank@grab_cash",
            "bag_grab",
            4.0,
            -8.0,
            1
        )
        NetworkAddEntityToSynchronisedScene(
            Money,
            Grab2,
            "anim@heists@ornate_bank@grab_cash",
            "cart_cash_dissapear",
            4.0,
            -8.0,
            1
        )
        NetworkStartSynchronisedScene(Grab2)
        Citizen.Wait(37000)
    end
    if not Grab3clear then
        Grab3 =
            NetworkCreateSynchronisedScene(
            GetEntityCoords(Money),
            GetEntityRotation(Money),
            2,
            false,
            false,
            1065353216,
            0,
            1.3
        )
        NetworkAddPedToSynchronisedScene(
            ped,
            Grab3,
            "anim@heists@ornate_bank@grab_cash",
            "exit",
            1.5,
            -4.0,
            1,
            16,
            1148846080,
            0
        )
        NetworkAddEntityToSynchronisedScene(
            GrabBag,
            Grab3,
            "anim@heists@ornate_bank@grab_cash",
            "bag_exit",
            4.0,
            -8.0,
            1
        )
        NetworkStartSynchronisedScene(Grab3)
        NewTrolley = CreateObject(emptyobj, GetEntityCoords(Money) + vector3(0.0, 0.0, -0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(Money))
        while not NetworkHasControlOfEntity(Money) do
            Citizen.Wait(1)
            NetworkRequestControlOfEntity(Money)
        end
        DeleteObject(Money)
        while DoesEntityExist(Money) do
            Citizen.Wait(1)
            DeleteObject(Money)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
    end
    Citizen.Wait(1800)
    if DoesEntityExist(GrabBag) then
        DeleteEntity(GrabBag)
    end
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
    SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
end

function C4()
    if not C4triggered then
        Citizen.CreateThread(
            function()
                while inC4 do
                    Citizen.Wait(5)
                    DrawText3Ds(6.3691420555115, -659.21508789063, 16.130836486816, Config.Lang["use_c4"])
                    if IsControlJustPressed(0, 74) then
                        QBCore.Functions.TriggerCallback(
                            "union:item",
                            function(tieneC4)
                                if tieneC4 then
                                    inC4 = false
                                    TriggerEvent("union:ponerC4")
                                else
                                    QBCore.Functions.Notify(Config.Lang["no_c4"])
                                end
                            end,
                            Config.C4ItemName
                        )
                    end
                end
            end
        )
    end
end

function hackeoEvent(success)
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    TriggerEvent("mhacking:hide")
    if success then
        boveda = true
        inVault = false
        TriggerServerEvent("union:vault", true)
        TriggerServerEvent("union:log")
        DeleteObject(StandObject)
        SpawnMoney()
    end
    ClearPedTasksImmediately(ped)
end

function t4(animDict, cb)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)

        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(1)
        end
    end

    if cb ~= nil then
        cb()
    end
end

RegisterNetEvent("union:usarTermita")
AddEventHandler(
    "union:usarTermita",
    function(puerta, door)
        local playerPed = PlayerPedId()
        local doorCoords = GetEntityCoords(puerta)
        t4(
            "anim@heists@ornate_bank@thermal_charge",
            function(dict)
                if HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") then
                    local fwd, _, _, pos = GetEntityMatrix(playerPed)
                    local newPos = (fwd * 0.8) + pos
                    SetEntityCoords(playerPed, newPos.xy, newPos.z - 1)
                    FreezeEntityPosition(playerPed, true)
                    local rot, pos = GetEntityRotation(playerPed), GetEntityCoords(playerPed)
                    SetPedComponentVariation(playerPed, 5, -1, 0, 0)
                    local bag =
                        CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z, true, true, false)
                    local scene =
                        NetworkCreateSynchronisedScene(
                        pos.x,
                        pos.y,
                        pos.z,
                        rot.x,
                        rot.y,
                        rot.z,
                        2,
                        0,
                        0,
                        1065353216,
                        0,
                        1.3
                    )
                    SetEntityCollision(bag, 0, 1)
                    NetworkAddPedToSynchronisedScene(
                        playerPed,
                        scene,
                        "anim@heists@ornate_bank@thermal_charge",
                        "thermal_charge",
                        1.5,
                        -4.0,
                        1,
                        16,
                        1148846080,
                        0
                    )
                    NetworkAddEntityToSynchronisedScene(
                        bag,
                        scene,
                        "anim@heists@ornate_bank@thermal_charge",
                        "bag_thermal_charge",
                        4.0,
                        -8.0,
                        1
                    )
                    SetEntityCoords(playerPed, door.xt, door.yt, door.zt - 0.1)
                    NetworkStartSynchronisedScene(scene)
                    Citizen.Wait(1500)
                    pos = GetEntityCoords(playerPed)
                    local eHash = GetHashKey("hei_prop_heist_thermite")
                    explosives = CreateObject(eHash, pos.x, pos.y, pos.z + 0.2, 1, 1, 1)
                    SetEntityCollision(explosives, 0, 1)
                    AttachEntityToEntity(
                        explosives,
                        playerPed,
                        GetPedBoneIndex(playerPed, 28422),
                        0,
                        0,
                        0,
                        0,
                        0,
                        180.0,
                        1,
                        1,
                        0,
                        1,
                        1,
                        1
                    )
                    Citizen.Wait(4000)
                    SetEntityAsMissionEntity(bag, false, true)
                    DeleteObject(bag)
                    SetPedComponentVariation(playerPed, 5, 45, 0, 0)
                    DetachEntity(explosives, 1, 1)
                    FreezeEntityPosition(explosives, 1)
                    SetEntityCollision(explosives, 0, 1)
                    FreezeEntityPosition(playerPed, false)
                    TriggerServerEvent("union:ThermiteEffectSync", explosives)
                    Citizen.Wait(4000)
                    NetworkStopSynchronisedScene(scene)
                    DeleteObject(explosives)
                end
            end
        )
        TriggerServerEvent("union:doorsStatus", doorCoords, false)
    end
)

RegisterNetEvent("union:killblip")
AddEventHandler(
    "union:killblip",
    function()
        RemoveBlip(vaultBlip)
        vaultBlip = nil
    end
)

RegisterNetEvent("union:syncDoors")
AddEventHandler(
    "union:syncDoors",
    function(doorCoords, status)
        local door = GetClosestObjectOfType(doorCoords, 1.0, GetHashKey("v_ilev_fingate"), false, false, false)
        if door ~= 0 and door ~= nil then
            FreezeEntityPosition(door, status)
        end
    end
)

function t5(assetName, cb)
    if not HasNamedPtfxAssetLoaded(assetName) then
        RequestNamedPtfxAsset(assetName)

        while not HasNamedPtfxAssetLoaded(assetName) do
            Citizen.Wait(1)
        end
    end

    if cb ~= nil then
        cb()
    end
end

RegisterNetEvent("union:thermiteEffect")
AddEventHandler(
    "union:thermiteEffect",
    function(entity)
        if #(GetEntityCoords(PlayerPedId()) - vector3(0.18, -676.40, 16.13)) < 20 then
            t5(
                "scr_ornate_heist",
                function()
                    if HasNamedPtfxAssetLoaded("scr_ornate_heist") then
                        SetPtfxAssetNextCall("scr_ornate_heist")
                        explosiveEffect =
                            StartParticleFxLoopedOnEntity(
                            "scr_heist_ornate_thermal_burn",
                            entity,
                            0.0,
                            2.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            2.0,
                            0,
                            0,
                            0,
                            0
                        )
                        Citizen.Wait(4000)
                        StopParticleFxLooped(explosiveEffect, 0)
                    end
                end
            )
        end
    end
)

RegisterNetEvent("union:ponerC4")
AddEventHandler(
    "union:ponerC4",
    function()
        local playerPed = PlayerPedId()
        t4(
            "anim@heists@ornate_bank@thermal_charge",
            function(dict)
                if HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") then
                    local fwd, _, _, pos = GetEntityMatrix(playerPed)
                    local newPos = (fwd * 0.6) + pos
                    SetEntityCoords(playerPed, 6.3581008911133, -659.17010498047, 15.530838394165)
                    SetEntityHeading(playerPed, 344.31)
                    FreezeEntityPosition(playerPed, true)
                    local rot, pos = GetEntityRotation(playerPed), GetEntityCoords(playerPed)
                    SetPedComponentVariation(playerPed, 5, -1, 0, 0)
                    local bag =
                        CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z, true, true, false)
                    local scene =
                        NetworkCreateSynchronisedScene(
                        pos.x,
                        pos.y,
                        pos.z,
                        rot.x,
                        rot.y,
                        rot.z,
                        2,
                        0,
                        0,
                        1065353216,
                        0,
                        1.3
                    )
                    SetEntityCollision(bag, 0, 1)
                    NetworkAddPedToSynchronisedScene(
                        playerPed,
                        scene,
                        "anim@heists@ornate_bank@thermal_charge",
                        "thermal_charge",
                        1.5,
                        -4.0,
                        1,
                        16,
                        1148846080,
                        0
                    )
                    NetworkAddEntityToSynchronisedScene(
                        bag,
                        scene,
                        "anim@heists@ornate_bank@thermal_charge",
                        "bag_thermal_charge",
                        4.0,
                        -8.0,
                        1
                    )
                    NetworkStartSynchronisedScene(scene)
                    Citizen.Wait(1500)
                    pos = GetEntityCoords(playerPed)
                    local eHas211h = GetHashKey("ch_prop_ch_explosive_01a")
                    c4 = CreateObject(GetHashKey("stt_prop_c4_stack"), pos.x, pos.y, pos.z + 0.2, 1, 1, 1)
                    SetEntityCollision(c4, 0, 1)
                    AttachEntityToEntity(
                        c4,
                        playerPed,
                        GetPedBoneIndex(playerPed, 28422),
                        0,
                        0,
                        0,
                        0,
                        0,
                        180.0,
                        1,
                        1,
                        0,
                        1,
                        1,
                        1
                    )
                    Citizen.Wait(4000)
                    SetEntityAsMissionEntity(bag, false, true)
                    DeleteObject(bag)
                    SetPedComponentVariation(playerPed, 5, 45, 0, 0)
                    DetachEntity(c4, 1, 1)
                    SetEntityCoords(c4, 6.3581008911133, -659.17010498047, 16.130838394165)
                    FreezeEntityPosition(c4, 1)
                    SetEntityCollision(c4, 0, 1)
                    FreezeEntityPosition(playerPed, false)
                    NetworkStopSynchronisedScene(scene)
                    Countdown()
                end
            end
        )
    end
)

function Countdown()
    conteo = true
    count = Config.C4Time
    TriggerEvent("union:count")
    Citizen.CreateThread(
        function()
            while conteo do
                Citizen.Wait(100)
                count = count - 0.1
                if count < 0 then
                    conteo = false
                    TriggerServerEvent("union:c4")
                    Citizen.Wait(200)
                    DeleteObject(c4)
                    break
                end
            end
        end
    )
end

RegisterNetEvent("union:count")
AddEventHandler(
    "union:count",
    function()
        while conteo do
            Citizen.Wait(0)
            drawTxt(
                0.94,
                1.44,
                1.0,
                1.0,
                0.6,
                "C4: ~r~" .. math.ceil(count) .. "~w~ " .. Config.Lang["countdown"],
                255,
                255,
                255,
                255
            )
        end
    end
)

function SpawnGold()
    LoadModel("prop_large_gold")
    if StandObject == nil then
        StandObject = CreateObject(GetHashKey("prop_large_gold"), -5.21, -660.83, 33.48, true)
        PlaceObjectOnGroundProperly(StandObject)
        SetEntityHeading(StandObject, 92.45)
        FreezeEntityPosition(StandObject, true)
    end
end

RegisterNetEvent("union:grab")
AddEventHandler(
    "union:grab",
    function()
        local PlayerPed = GetPlayerPed(-1)
        local PlayerPos = GetEntityCoords(PlayerPed)
        local ClosestObject =
            GetClosestObjectOfType(PlayerPos.x, PlayerPos.y, PlayerPos.z, 3.0, GetHashKey("prop_large_gold"), 0, 0, 0)
        if StandObject ~= nil then
            if ClosestObject ~= nil and ClosestObject == StandObject then
                if not IsPushing then
                    TomarStand()
                end
            end
        end
    end
)

function TomarStand()
    local PlayerPed = GetPlayerPed(-1)
    IsPushing = true
    NetworkRequestControlOfEntity(StandObject)
    LoadAnim(AnimationData.lib)
    TaskPlayAnim(PlayerPed, AnimationData.lib, AnimationData.anim, 8.0, 8.0, -1, 50, 0, false, false, false)
    SetTimeout(
        150,
        function()
            AttachEntityToEntity(
                StandObject,
                PlayerPed,
                GetPedBoneIndex(PlayerPed, 28422),
                -0.45,
                -1.5,
                -0.47,
                180.0,
                180.0,
                270.0,
                false,
                false,
                false,
                false,
                1,
                true
            )
        end
    )
    FreezeEntityPosition(StandObject, false)
    RequestWalking("anim_group_move_ballistic")
    SetPedMovementClipset(PlayerPedId(), "anim_group_move_ballistic", 0.2)
    AnimLoop()
end

function AnimLoop()
    Citizen.CreateThread(
        function()
            while IsPushing do
                local PlayerPed = GetPlayerPed(-1)
                if not IsEntityPlayingAnim(PlayerPed, AnimationData.lib, AnimationData.anim, 3) then
                    LoadAnim(AnimationData.lib)
                    TaskPlayAnim(
                        PlayerPed,
                        AnimationData.lib,
                        AnimationData.anim,
                        8.0,
                        8.0,
                        -1,
                        50,
                        0,
                        false,
                        false,
                        false
                    )
                end
                if IsControlJustPressed(0, Config.GrabKey) then
                    DetachEntity(StandObject)
                    SetEntityCollision(StandObject, true, true)
                    ClearPedTasks(PlayerPed)
                    RemoveAnimSet("anim_group_move_ballistic")
                    ResetPedMovementClipset(PlayerPedId())
                    IsPushing = false
                end
                Citizen.Wait(5)
            end
        end
    )
end

t7 = function(coords, area)
    local vehicles = t1()
    local vehiclesInArea = {}

    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

        if distance <= area then
            table.insert(vehiclesInArea, vehicles[i])
        end
    end

    return vehiclesInArea
end

t8 = function(coords, radius)
    local vehicles = t7(coords, radius)

    return #vehicles == 0
end

function t9(modelHash, cb)
    modelHash = (type(modelHash) == "number" and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
    end

    if cb ~= nil then
        cb()
    end
end

t10 = function(modelName, coords, heading, cb)
    local model = (type(modelName) == "number" and modelName or GetHashKey(modelName))

    Citizen.CreateThread(
        function()
            t9(model)

            local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
            local id = NetworkGetNetworkIdFromEntity(vehicle)

            SetNetworkIdCanMigrate(id, true)
            SetEntityAsMissionEntity(vehicle, true, false)
            SetVehicleHasBeenOwnedByPlayer(vehicle, true)
            SetVehicleNeedsToBeHotwired(vehicle, false)
            SetModelAsNoLongerNeeded(model)

            RequestCollisionAtCoord(coords.x, coords.y, coords.z)

            while not HasCollisionLoadedAroundEntity(vehicle) do
                RequestCollisionAtCoord(coords.x, coords.y, coords.z)
                Citizen.Wait(0)
            end

            SetVehRadioStation(vehicle, "OFF")

            if cb then
                cb(vehicle)
            end
        end
    )
end

RegisterNetEvent("union:blindadoSpawn")
AddEventHandler(
    "union:blindadoSpawn",
    function()
        if t8(vector3(Config.StockadeSpawn.x, Config.StockadeSpawn.y, Config.StockadeSpawn.z), 5.0) then
            t10(
                "stockade",
                vector3(Config.StockadeSpawn.x, Config.StockadeSpawn.y, Config.StockadeSpawn.z),
                Config.StockadeSpawn.h,
                function(blindado)
                    SetVehicleCustomPrimaryColour(blindado, 255, 255, 255)
                    SetVehicleNumberPlateText(blindado, "GRUPPE-" .. tostring(math.random(1000, 9999)))
                    SetVehicleFuelLevel(blindado, 100.0)
                    SetVehicleBodyHealth(blindado, 1000.0)
                    SetVehicleEngineOn(blindado, true, true)
                    stockade = blindado
                    CurrentPlate = GetVehicleNumberPlateText(veh)
                    QBCore.Functions.Notify(Config.Lang["mission_started"])
                    vaultBlip = AddBlipForCoord(-3.61, -686.68, 16.13)
                    SetBlipRoute(vaultBlip, true)
                end
            )
        else
            QBCore.Functions.Notify(Config.Lang["parking_spot"])
        end
    end
)

RegisterNetEvent("union:notify")
AddEventHandler(
    "union:notify",
    function()
        QBCore.Functions.Notify(Config.Lang["rob_progress"])
        if Config.PoliceBlip then
            local alpha = 250
            local vaultBlip = AddBlipForCoord(-3.61, -686.68, 16.13)

            SetBlipHighDetail(vaultBlip, true)
            SetBlipSprite(vaultBlip, 84)
            SetBlipColour(vaultBlip, 1)
            SetBlipScale(vaultBlip, 0.8)
            SetBlipAlpha(vaultBlip, alpha)
            SetBlipAsShortRange(vaultBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Lang["rob_blip"])
            EndTextCommandSetBlipName(vaultBlip)

            while alpha ~= 0 do
                Citizen.Wait(440 * 4)
                alpha = alpha - 1
                SetBlipAlpha(vaultBlip, alpha)

                if alpha == 0 then
                    RemoveBlip(vaultBlip)
                    return
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            if StandObject ~= nil then
                DeleteObject(StandObject)
                ClearPedTasksImmediately(GetPlayerPed(-1))
                StopAlarm("BIG_SCORE_HEIST_VAULT_ALARMS", -1)
                RemoveBlip(vaultBlip)
                vaultBlip = nil
            end
        end
    end
)

function LoadAnim(animDict)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Citizen.Wait(1)
    end
end

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(0.40, 0.40)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end
