--[[
	id: ELihO6OFm5iZy6jvvkm4O
	name: This Is Test
	description: Naypae Is Good boy
	time1: 2021-05-27 08:30:37.7772+00
	time2: 2021-05-27 08:30:37.7772+00
	uploader: 1c0iBFpUKJ2EbWKIUynauUaxvMYWdOxB9duq_QLh
	uploadersession: itFwfaexAIN4vbqlh1UwsiuE7RpEIz
	flag: f
--]]

--[[

    จัดทำโดย : Naypae (NPA TEAM)
    สคริป : Naypae_Selldrug
    ไฟล์ : client.lua
    Discord : https://discord.gg/2BrPsQzwHG
    คำเตือน : หากนำไปแกะรหัส Script จะถูกตัดสิทธิ์ Support + Update(ถาวร) ทันที

]]--

local _Naypaerun = nil
RegisterNetEvent("run:client:Verify")
AddEventHandler(
    "run:client:Verify",
    function(Status)
        _Naypaerun = Status
    end
)

Citizen.CreateThread(
    function()
        local b = GetGameTimer()
        while _Naypaerun == nil and GetGameTimer() - b <= 30 * 1000 do
            TriggerServerEvent("run:server:OnRequestVerify")
            Citizen.Wait(300)
        end
        _RunNaypae()
    end
)

_RunNaypae = function()
    ESX = nil
    local myJob = nil
    local selling = false
    local has = false
    local copsc = false
    local PlayerData = {}
    local CurrentIndex = 1
    local SellsNpc = {}
    local openSell = false
    local canSell = false
    local sec = 1000
    local IsUse = false
    local chackbug = false

    local script_name = GetCurrentResourceName()

    Citizen.CreateThread(
        function()
            Citizen.Wait(1000)
            print("^2[Px SHOP]^0 Loading ^1" .. script_name .. " ^2V.1.2^0")
        end
    )

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
                Citizen.Wait(10)
            end

            PlayerData = ESX.GetPlayerData()
        end
    )

    local randomstart = false
    local ped = {}
    local Randomblip1 = {}
    local Randomblip2 = {}

    Citizen.CreateThread(
        function()
            local b = GetGameTimer()
            while _Naypaerun == nil and GetGameTimer() - b <= 30 * 1000 do
                TriggerServerEvent("run:server:OnRequestVerify")
                Citizen.Wait(300)
            end
            _RunNaypae()
        end
    )

    RegisterNetEvent("Naypae")
    AddEventHandler(
        "Naypae",
        function()
            if not randomstart then
                randomstart = true
                local point = math.random(1, #Config["SpawnPoints"])
                CreateNPC(point)
                CreateBlip1(point)
                CreateBlip2(point)
                print("^2NPC ^5CREATE")
            elseif randomstart then
                randomstart = false
                deleteall()
            end
        end
    )

    function newrandom()
        TriggerEvent("Naypae")
    end

    function deleteall()
        DeleteEntity(ped)
        RemoveBlip(Randomblip1)
        RemoveBlip(Randomblip2)
        print("^2NPC ^5DELETE")
    end

    function CreateNPC(point)
        RequestModel(GetHashKey(Config["Model"].Model))
        while not HasModelLoaded(GetHashKey(Config["Model"].Model)) do
            Wait(1)
        end

        ped =
            CreatePed(
            4,
            Config["Model"].Model,
            Config["SpawnPoints"][point].x,
            Config["SpawnPoints"][point].y,
            Config["SpawnPoints"][point].z - 1,
            3374176,
            false,
            true
        )
        SetEntityHeading(ped, Config["SpawnPoints"][point].h)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end

    function CreateBlip1(point)
        Randomblip1 =
            AddBlipForCoord(
            Config["SpawnPoints"][point].x,
            Config["SpawnPoints"][point].y,
            Config["SpawnPoints"][point].z
        )
        SetBlipSprite(Randomblip1, 280)
        SetBlipDisplay(Randomblip1, 2)
        SetBlipScale(Randomblip1, 1.0)
        SetBlipColour(Randomblip1, 35)
        SetBlipAsShortRange(Randomblip1, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('<font face="' .. Config["Blip"].Font .. '"> ' .. Config["Blip"].Name .. " </font>")
        EndTextCommandSetBlipName(Randomblip1)
    end

    function CreateBlip2(point)
        Randomblip2 =
            AddBlipForRadius(
            Config["SpawnPoints"][point].x,
            Config["SpawnPoints"][point].y,
            Config["SpawnPoints"][point].z,
            60.0
        )
        SetBlipHighDetail(Randomblip2, true)
        SetBlipColour(Randomblip2, 2)
        SetBlipAlpha(Randomblip2, 200)
        SetBlipAsShortRange(Randomblip2, true)
    end

    RegisterNetEvent("esx:playerLoaded")
    AddEventHandler(
        "esx:playerLoaded",
        function()
            TriggerServerEvent("NayPae:fetchjob")
        end
    )

    RegisterNetEvent("NayPae:getjob")
    AddEventHandler(
        "NayPae:getjob",
        function(jobName)
            myJob = jobName
        end
    )

    Citizen.CreateThread(
        function()
            while true do
                Wait(7)

                local pl = GetEntityCoords(GetPlayerPed(-1))
                for k, v in pairs(Config.SellDrugLocation) do
                    if GetDistanceBetweenCoords(pl.x, pl.y, pl.z, v.x, v.y, v.z, true) < v.size then
                        canSell = true
                        while canSell do
                            Wait(7)
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, true) > v.size then
                                canSell = false
                            end
                        end
                    end
                end
            end
        end
    )

    Citizen.CreateThread(
        function()
            for k, v in pairs(Config.SellDrugLocation) do
                if v.enableArea then
                    blipareas(v.x, v.y, v.z, v.size)
                end
            end
        end
    )

    function ArrayCount(T)
        local count = 0
        for _ in pairs(T) do
            count = count + 1
        end
        return count
    end

    function CheckNPC(npc)
        for k, v in pairs(SellsNpc) do
            if v == npc then
                return true
            end
        end
        return false
    end

    currentped = nil
    _RunNaypae = function()
        function AutoSell()
            local player = GetPlayerPed(-1)

            TriggerServerEvent("NayPae:checkItem", Config.Items)
            Wait(200)
            if has then
                openSell = not openSell
                Citizen.CreateThread(
                    function()
                        while openSell do
                            Wait(4)
                            local CountItems = ArrayCount(Config.Items)
                            local CountNPC = ArrayCount(SellsNpc)
                            local ItemString = Config.Items[CurrentIndex].ItemLabel
                            local playerloc = GetEntityCoords(player, 0)
                            local handle, ped = FindFirstPed()
                            local pedType = GetPedType(ped)
                            local isInVeh = not IsPedInAnyVehicle(player)
                            local isExit = DoesEntityExist(ped)
                            --local isDead = IsPedDeadOrDying(ped)

                            repeat
                                success, ped = FindNextPed(handle)
                                local isNpcInVeh = IsPedInAnyVehicle(ped)
                                local pos = GetEntityCoords(ped)

                                if isInVeh and isExit and not isNpcInVeh then
                                    if IsPedDeadOrDying(ped) == false then
                                        -- if NetworkGetEntityIsNetworked(ped) == 1 then
                                        -- if pedType ~= 28 and IsPedAPlayer(ped) == false then
                                        local distance =
                                            GetDistanceBetweenCoords(
                                            pos.x,
                                            pos.y,
                                            pos.z,
                                            playerloc["x"],
                                            playerloc["y"],
                                            playerloc["z"],
                                            true
                                        )
                                        currentped = pos
                                        canselloldnpc = CheckNPC(ped)
                                        if distance <= 2.0 and ped ~= player and ped ~= oldped and not canselloldnpc then
                                            if Config["Setting"].TextonNPC.Enable then
                                                Draw3DText(
                                                    pos.x,
                                                    pos.y,
                                                    pos.z - 2.00,
                                                    Config["Setting"].TextonNPC.TextSellNPC
                                                )
                                                Draw3DText(pos.x, pos.y, pos.z - 0.90, "" .. ItemString .. "")
                                                Draw3DText(
                                                    pos.x,
                                                    pos.y,
                                                    pos.z - 1.00,
                                                    Config["Setting"].TextonNPC.TextChangeNPC
                                                )
                                            else
                                                DrawText2D(
                                                    0.90,
                                                    1.37,
                                                    0.4,
                                                    1.0,
                                                    1.0,
                                                    Config["Setting"].TextonNPC.TextScreenChange,
                                                    255,
                                                    255,
                                                    255,
                                                    255
                                                )
                                                DrawText2D(0.90, 1.41, 0.4, 1.0, 1.0, ItemString, 255, 255, 255, 255)
                                                DrawText2D(
                                                    0.90,
                                                    1.45,
                                                    0.3,
                                                    1.0,
                                                    1.0,
                                                    Config["Setting"].TextonNPC.TextChange,
                                                    255,
                                                    255,
                                                    255,
                                                    255
                                                )
                                            end

                                            if IsControlJustPressed(1, Config.Key["E"]) then
                                                table.insert(SellsNpc, ped)
                                                oldped = ped
                                                SetEntityAsMissionEntity(ped)
                                                TaskStandStill(ped, 9.0)
                                                pos1 = GetEntityCoords(ped)
                                                TriggerServerEvent("NayPae:trigger", Config.Items[CurrentIndex])

                                                if Config["Setting"].FreezDetial.FreezeOnsell then
                                                    FreezeEntityPosition(player, true)
                                                end
                                                Citizen.Wait(Config["Setting"].Basic.Timesell * 1000)
                                                FreezeEntityPosition(player, false)
                                                TriggerEvent("NayPae:sell", Config.Items[CurrentIndex], ped)
                                                SetPedAsNoLongerNeeded(oldped)

                                                if CountNPC > 50 then
                                                    SellsNpc = {}
                                                end
                                            end
                                            DisableControlAction(0, 44, true)
                                            if IsDisabledControlJustPressed(0, Config.Key["G"]) then
                                                if CurrentIndex == CountItems then
                                                    CurrentIndex = 1
                                                else
                                                    CurrentIndex = CurrentIndex + 1
                                                end
                                            end

                                            if not openSell then
                                                break
                                            end
                                        end
                                    -- end
                                    -- end
                                    end
                                end

                                if not canSell then
                                    TriggerEvent(
                                        "pNotify:SendNotification",
                                        {
                                            text = '<center><b class="white-text">โหมดพูดคุยปิดลงเนื่องจากออกนอกเขต</b><center>',
                                            type = "error",
                                            timeout = 1000,
                                            layout = "bottomcenter",
                                            queue = "global"
                                        }
                                    )
                                    deleteall()
                                    randomstart = false
                                    openSell = false
                                    break
                                end
                            until not success
                            EndFindPed(handle)
                        end
                    end
                )
            else
                openSell = false
                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = Config["Message"].CannotSell,
                        type = "error",
                        timeout = 1000,
                        layout = "bottomcenter",
                        queue = "global"
                    }
                )
                deleteall()
                randomstart = false
            end
            Citizen.Wait(500)
            if not openSell then
                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = Config["Message"].DubbleOpenSell,
                        type = "success",
                        timeout = 1000,
                        layout = "bottomcenter",
                        queue = "global"
                    }
                )
                deleteall()
                randomstart = false
            else
                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = Config["Message"].OpenSell,
                        type = "success",
                        timeout = 1000,
                        layout = "bottomcenter",
                        queue = "global"
                    }
                )
                TriggerEvent("Naypae")
            end
        end
    end
    function Clearbug()
        Citizen.CreateThread(
            function()
                repeat
                    Citizen.Wait(7)

                    local playerloc = GetEntityCoords(PlayerPedId())
                    if
                        GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc["x"], playerloc["y"], playerloc["z"]) <=
                            5
                     then
                    else
                        if Config["Setting"].ClearBugDrug.Explosion then
                            local ped = GetPlayerPed(-1)
                            local PedPos = GetEntityCoords(ped)
                            TriggerEvent(
                                "pNotify:SendNotification",
                                {
                                    text = '<center><b class="yellow-text">ระบบ : <b class="red-text">กรุณาอย่าใช้บัคในการขายยา<b class="red-text"></b><center>',
                                    type = "error",
                                    timeout = 5000,
                                    layout = "center",
                                    queue = "global"
                                }
                            )
                            AddExplosion(PedPos.x, PedPos.y, PedPos.z + 1.00, 34, 1.00, true, false, 5.00)
                            Wait(2000)
                            SetEntityCoords(PlayerPedId(), playerloc.x, playerloc.y, playerloc.z - 0.97)
                        else
                            local player = GetPlayerPed(-1)
                            FreezeEntityPosition(player, true)
                            TriggerEvent(
                                "pNotify:SendNotification",
                                {
                                    text = '<center><b class="yellow-text">ระบบ : <b class="red-text">กรุณาอย่าใช้บัคในการขายยาคุณถูกแช่แข็ง<b class="red-text"></b><center>',
                                    type = "error",
                                    timeout = 5000,
                                    layout = "center",
                                    queue = "global"
                                }
                            )
                            Citizen.Wait(60 * 1000)
                            FreezeEntityPosition(player, false)
                        end
                    end
                until chackbug == false
            end
        )
    end

    RegisterNetEvent("NayPaesell:menu")
    AddEventHandler(
        "NayPaesell:menu",
        function(xPlayer)
            OpenMenuSell()
        end
    )

    function OpenMenuSell()
        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open(
            "default",
            GetCurrentResourceName(),
            "mobile_ambulance_actions",
            {
                title = Config["Setting"].Menu.title,
                align = Config["Setting"].Menu.align,
                elements = {
                    {label = "เริ่มขาย", value = "start"},
                    {label = "หยุดขาย", value = "stop"}
                }
            },
            function(data, menu)
                if data.current.value == "start" then
                    ESX.UI.Menu.CloseAll()
                    if canSell then
                        AutoSell()
                        if Config["Setting"].Basic.Mask then
                            TriggerEvent("NayPae:mask")
                        end
                    else
                        TriggerEvent(
                            "pNotify:SendNotification",
                            {
                                text = '<center><b class="green-text">ระบบ : <b class="red-text">ต้องอยู่ในเขตเมือง<b class="red-text"></b><center>',
                                type = "success",
                                timeout = 1000,
                                layout = "bottomcenter",
                                queue = "global"
                            }
                        )
                    end
                elseif data.current.value == "stop" then
                    ESX.UI.Menu.CloseAll()
                    openSell = false
                    TriggerEvent(
                        "pNotify:SendNotification",
                        {
                            text = Config["Message"].CloseSell,
                            type = "success",
                            timeout = 1000,
                            layout = "bottomcenter",
                            queue = "global"
                        }
                    )
                    deleteall()
                    randomstart = false
                end
            end,
            function(data, menu)
                menu.close()
            end
        )
    end

    RegisterNetEvent("NayPae:StartSellOrStop")
    AddEventHandler(
        "NayPae:StartSellOrStop",
        function()
            if canSell then
                AutoSell()
                if Config["Setting"].Basic.Mask then
                    TriggerEvent("NayPae:mask")
                end
            else
                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = '<center><b class="green-text">ระบบ : <b class="red-text">ต้องอยู่ในเขตเมือง<b class="red-text"></b><center>',
                        type = "error",
                        timeout = 1000,
                        layout = "bottomcenter",
                        queue = "global"
                    }
                )
            end
        end
    )

    RegisterNetEvent("NayPae:setNpcCallPolice")
    AddEventHandler(
        "NayPae:setNpcCallPolice",
        function(npc)
            local player = GetPlayerPed(-1)
            local percent = math.random(1, 10)
            local dict = "cellphone@"
            local phoneModel = "prop_amb_phone"
            local Current_Sex = 0
            local Current_Hair = 0

            TriggerEvent(
                "skinchanger:getSkin",
                function(skin)
                    Current_Hair = skin["hair_1"]
                    Current_Sex = skin["sex"]
                end
            )

            Wait(0)

            if IsPedDeadOrDying(npc, 1) == false then
                RequestAnimDict(dict)
                while (not HasAnimDictLoaded(dict)) do
                    Citizen.Wait(0)
                end

                if percent <= (Config["Setting"].PoliceDetial.PercentCallCopWithFace / 10) then
                    local coords = GetEntityCoords(player)

                    TaskGoStraightToCoord(npc, coords.x, coords.y, coords.z, 1.0, 1000, GetEntityHeading(npc), 10)
                    TriggerServerEvent("NayPae:callPolice", true, Current_Hair, Current_Sex)

                    SetEntityAsMissionEntity(npc)
                    TaskStandStill(npc, 9.0)
                    chackbug = true
                    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, false)
                    Citizen.Wait(5000)
                    Clearbug()
                    ClearPedTasks(npc)
                    SetPedAsNoLongerNeeded(npc)
                    Citizen.Wait(1500)
                    chackbug = false
                else
                    chackbug = true
                    TriggerServerEvent("NayPae:callPolice", false, Current_Hair, Current_Sex)
                    TaskPlayAnim(npc, dict, "cellphone_call_listen_base", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
                    Wait(5000)
                    Clearbug()
                    TaskPlayAnim(npc, dict, "cellphone_call_out", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
                    Citizen.Wait(1500)
                    chackbug = false
                end
            end
        end
    )

    RegisterNetEvent("NayPae:Freeze")
    AddEventHandler(
        "NayPae:Freeze",
        function()
            Citizen.CreateThread(
                function()
                    local player = GetPlayerPed(-1)
                    FreezeEntityPosition(player, true)

                    TriggerEvent(
                        "mythic_progbar:client:progress",
                        {
                            name = "unique_action_name",
                            duration = (Config["Setting"].FreezDetial.FreezeTime * sec),
                            label = "FREEZ IN TIME",
                            useWhileDead = false,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true
                            }
                            --        animation = {
                            --            animDict = "anim@amb@nightclub@dancers@crowddance_facedj@",
                            --            anim = "hi_dance_facedj_11_v1_female^3",
                            --        },
                            --        prop = {
                            --            model = "prop_paper_bag_small",
                            --       }
                        },
                        function(status)
                            if not status then
                            -- Do Something If Event Wasn't Cancelled
                            end
                        end
                    )
                    deleteall()
                    randomstart = false
                    Wait(Config["Setting"].FreezDetial.FreezeTime * sec)
                    FreezeEntityPosition(player, false)
                    newrandom()
                end
            )
        end
    )

    RegisterNetEvent("NayPae:sell")
    AddEventHandler(
        "NayPae:sell",
        function(Data, Ped)
            local player = GetPlayerPed(-1)
            local playerloc = GetEntityCoords(player, 0)
            local distance =
                GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc["x"], playerloc["y"], playerloc["z"], true)

            if distance <= 2 then
                TriggerServerEvent("NayPae:sell", Config.Items[CurrentIndex], Ped)
            elseif distance > 2 then
                TriggerServerEvent("NayPae:sell_dis")

                TriggerEvent(
                    "pNotify:SendNotification",
                    {
                        text = '<center><b class="red-text">ออกมาไกลเกินไป<center></b>',
                        type = "error",
                        timeout = 3000,
                        layout = "bottomcenter",
                        queue = "global"
                    }
                )
            end
        end
    )

    RegisterNetEvent("NayPae:UpdateHas")
    AddEventHandler(
        "NayPae:UpdateHas",
        function(result)
            has = result
        end
    )

    local ConfigHair_M = {
        {
            Hair = 1,
            Name = "Shaving"
        },
        {
            Hair = 2,
            Name = "Short Hair"
        },
        {
            Hair = 3,
            Name = "Short Hair"
        },
        {
            Hair = 4,
            Name = "Short Hair"
        },
        {
            Hair = 5,
            Name = "Short Hair"
        },
        {
            Hair = 6,
            Name = "Short Hair"
        },
        {
            Hair = 7,
            Name = "Short Hair"
        },
        {
            Hair = 8,
            Name = "Dreadlock"
        },
        {
            Hair = 9,
            Name = "Medium Hair"
        },
        {
            Hair = 10,
            Name = "Short Hair"
        },
        {
            Hair = 11,
            Name = "Short Hair"
        },
        {
            Hair = 12,
            Name = "Short Hair"
        },
        {
            Hair = 13,
            Name = "Medium Hair"
        },
        {
            Hair = 14,
            Name = "Dreadlock"
        },
        {
            Hair = 15,
            Name = "Long Hair"
        },
        {
            Hair = 16,
            Name = "Curly Hair"
        },
        {
            Hair = 17,
            Name = "Long Hair"
        },
        {
            Hair = 18,
            Name = "Short Hair"
        },
        {
            Hair = 19,
            Name = "Short Hair"
        },
        {
            Hair = 20,
            Name = "Long Hair"
        },
        {
            Hair = 21,
            Name = "Short Hair"
        },
        {
            Hair = 22,
            Name = "Long Hair"
        },
        {
            Hair = 24,
            Name = "Dreadlock"
        },
        {
            Hair = 25,
            Name = "Dreadlock"
        },
        {
            Hair = 26,
            Name = "Dreadlock"
        },
        {
            Hair = 27,
            Name = "Dreadlock"
        },
        {
            Hair = 28,
            Name = "Dreadlock"
        },
        {
            Hair = 29,
            Name = "Dreadlock"
        },
        {
            Hair = 30,
            Name = "Short Hair"
        },
        {
            Hair = 31,
            Name = "Long Hair"
        },
        {
            Hair = 32,
            Name = "Short Hair"
        },
        {
            Hair = 33,
            Name = "Short Hair"
        },
        {
            Hair = 34,
            Name = "Short Hair"
        },
        {
            Hair = 35,
            Name = "Medium Hair"
        },
        {
            Hair = 36,
            Name = "Medium Hair"
        },
        {
            Hair = 37,
            Name = "Shaving Hair"
        },
        {
            Hair = 38,
            Name = "Short Hair"
        },
        {
            Hair = 39,
            Name = "Short Hair"
        },
        {
            Hair = 40,
            Name = "Short Hair"
        },
        {
            Hair = 41,
            Name = "Short Hair"
        },
        {
            Hair = 42,
            Name = "Short Hair"
        },
        {
            Hair = 43,
            Name = "Medium Hair"
        },
        {
            Hair = 44,
            Name = "Dreadlock"
        },
        {
            Hair = 45,
            Name = "Medium Hair"
        },
        {
            Hair = 46,
            Name = "Short Hair"
        },
        {
            Hair = 47,
            Name = "Short Hair"
        },
        {
            Hair = 48,
            Name = "Short Hair"
        },
        {
            Hair = 49,
            Name = "Medium Hair"
        },
        {
            Hair = 50,
            Name = "Dreadlock"
        },
        {
            Hair = 51,
            Name = "Long Hair"
        },
        {
            Hair = 52,
            Name = "Curly Hair"
        },
        {
            Hair = 53,
            Name = "Long Hair"
        },
        {
            Hair = 54,
            Name = "Short Hair"
        },
        {
            Hair = 55,
            Name = "Short Hair"
        },
        {
            Hair = 56,
            Name = "Long Hair"
        },
        {
            Hair = 57,
            Name = "Short Hair"
        },
        {
            Hair = 58,
            Name = "Long Hair"
        },
        {
            Hair = 59,
            Name = "Dreadlock"
        },
        {
            Hair = 60,
            Name = "Dreadlock"
        },
        {
            Hair = 61,
            Name = "Dreadlock"
        },
        {
            Hair = 62,
            Name = "Dreadlock"
        },
        {
            Hair = 63,
            Name = "Dreadlock"
        },
        {
            Hair = 64,
            Name = "Dreadlock"
        },
        {
            Hair = 65,
            Name = "Short Hair"
        },
        {
            Hair = 66,
            Name = "Long Hair"
        },
        {
            Hair = 67,
            Name = "Short Hair"
        },
        {
            Hair = 68,
            Name = "Short Hair"
        },
        {
            Hair = 69,
            Name = "Short Hair"
        },
        {
            Hair = 70,
            Name = "Medium Hair"
        },
        {
            Hair = 71,
            Name = "Medium Hair"
        },
        {
            Hair = 72,
            Name = "Short Hair"
        },
        {
            Hair = 73,
            Name = "Short Hair"
        }
    }

    local ConfigHair_Color = {
        {
            Hair = 0,
            Name = "Black"
        },
        {
            Hair = 1,
            Name = "Black"
        },
        {
            Hair = 2,
            Name = "Black"
        },
        {
            Hair = 3,
            Name = "Brown"
        },
        {
            Hair = 4,
            Name = "Brown"
        },
        {
            Hair = 5,
            Name = "Brown"
        },
        {
            Hair = 6,
            Name = "Brown"
        },
        {
            Hair = 7,
            Name = "Brown"
        },
        {
            Hair = 8,
            Name = "Brown"
        },
        {
            Hair = 9,
            Name = "Brown"
        },
        {
            Hair = 10,
            Name = "Brown"
        },
        {
            Hair = 11,
            Name = "~y~Blonde"
        },
        {
            Hair = 12,
            Name = "~y~Blonde"
        },
        {
            Hair = 13,
            Name = "~y~Blonde"
        },
        {
            Hair = 14,
            Name = "~y~Blonde"
        },
        {
            Hair = 15,
            Name = "~y~Blonde"
        },
        {
            Hair = 16,
            Name = "~y~Blonde"
        },
        {
            Hair = 17,
            Name = "~r~Red"
        },
        {
            Hair = 18,
            Name = "~r~Red"
        },
        {
            Hair = 19,
            Name = "~r~Red"
        },
        {
            Hair = 20,
            Name = "~r~Red"
        },
        {
            Hair = 21,
            Name = "~r~Red"
        },
        {
            Hair = 22,
            Name = "~r~Red"
        },
        {
            Hair = 23,
            Name = "~r~Red"
        },
        {
            Hair = 24,
            Name = "~r~Red"
        },
        {
            Hair = 25,
            Name = "~o~Orange"
        },
        {
            Hair = 26,
            Name = "Silver"
        },
        {
            Hair = 27,
            Name = "Silver"
        },
        {
            Hair = 28,
            Name = "Silver"
        },
        {
            Hair = 29,
            Name = "Silver"
        },
        {
            Hair = 30,
            Name = "~p~Purple"
        },
        {
            Hair = 31,
            Name = "~p~Purple"
        },
        {
            Hair = 32,
            Name = "~p~Purple"
        },
        {
            Hair = 33,
            Name = "~p~Pink"
        },
        {
            Hair = 34,
            Name = "~p~Pink"
        },
        {
            Hair = 35,
            Name = "~p~Pink"
        },
        {
            Hair = 36,
            Name = "~g~Teal"
        },
        {
            Hair = 37,
            Name = "~g~Teal"
        },
        {
            Hair = 38,
            Name = "~b~Blue"
        },
        {
            Hair = 39,
            Name = "~g~Green"
        },
        {
            Hair = 40,
            Name = "~g~Green"
        },
        {
            Hair = 41,
            Name = "~g~Teal"
        },
        {
            Hair = 42,
            Name = "~g~Green"
        },
        {
            Hair = 43,
            Name = "~g~Green"
        },
        {
            Hair = 44,
            Name = "~g~Green"
        },
        {
            Hair = 45,
            Name = "~y~Yellow"
        },
        {
            Hair = 46,
            Name = "~y~Yellow"
        },
        {
            Hair = 47,
            Name = "~y~Yellow"
        },
        {
            Hair = 48,
            Name = "~o~Orange"
        },
        {
            Hair = 49,
            Name = "~o~Orange"
        },
        {
            Hair = 50,
            Name = "~o~Orange"
        },
        {
            Hair = 51,
            Name = "~o~Orange"
        },
        {
            Hair = 52,
            Name = "~o~Orange"
        },
        {
            Hair = 53,
            Name = "~r~Dark Red"
        },
        {
            Hair = 54,
            Name = "~r~Dark Red"
        },
        {
            Hair = 54,
            Name = "~r~Dark Red"
        },
        {
            Hair = 55,
            Name = "Brown"
        },
        {
            Hair = 56,
            Name = "Brown"
        },
        {
            Hair = 57,
            Name = "Brown"
        },
        {
            Hair = 58,
            Name = "Brown"
        },
        {
            Hair = 59,
            Name = "Brown"
        },
        {
            Hair = 60,
            Name = "Brown"
        },
        {
            Hair = 61,
            Name = "Black"
        },
        {
            Hair = 62,
            Name = "~y~Blonde"
        },
        {
            Hair = 63,
            Name = "~y~Blonde"
        }
    }

    RegisterNetEvent("NayPae:notifyPoliceMsg")
    AddEventHandler(
        "NayPae:notifyPoliceMsg",
        function(hairIndex, IsSex)
            local targetPlayer = GetPlayerPed(-1)
            local plyPos = GetEntityCoords(targetPlayer, true)
            local s1, s2 =
                Citizen.InvokeNative(
                0x2EB41072B4C1E4C0,
                plyPos.x,
                plyPos.y,
                plyPos.z,
                Citizen.PointerValueInt(),
                Citizen.PointerValueInt()
            )
            local street1 = GetStreetNameFromHashKey(s1)
            local hairColor = GetPedHairColor(targetPlayer)

            local propIndex = GetPedPropIndex(targetPlayer, 2)
            local hairString = "Hair : Unknow"
            local hairColorString = "Hair Color : Unknow"
            local sex = "~g~Male"

            if IsSex == 0 then
                sex = "~g~Male"

                for k, v in pairs(ConfigHair_M) do
                    if v.Hair == hairIndex then
                        hairString = v.Name
                        break
                    end
                end

                for k, v in pairs(ConfigHair_Color) do
                    if v.Hair == hairColor then
                        hairColorString = v.Name
                        break
                    end
                end
            else
                sex = "~p~Female"
                hairString = "Long Hair"

                for k, v in pairs(ConfigHair_Color) do
                    if v.Hair == hairColor then
                        hairColorString = v.Name
                        break
                    end
                end
            end
            local PedPosition = GetEntityCoords(targetPlayer)
            local PlayerCoords = {x = PedPosition.x, y = PedPosition.y, z = PedPosition.z}

            TriggerServerEvent(
                "esx_addons_gcphone:startCall",
                "police",
                "Someone is selling me drug by a " ..
                    sex .. " " .. hairString .. " Hair Color: " .. hairColorString .. " at " .. street1,
                PlayerCoords,
                {
                    PlayerCoords = {x = PedPosition.x, y = PedPosition.y, z = PedPosition.z}
                }
            )
        end
    )

    RegisterNetEvent("NayPae:notifyPolice")
    AddEventHandler(
        "NayPae:notifyPolice",
        function(face, target, hairIndex, IsSex)
            if PlayerData.job ~= nil and PlayerData.job.name == "police" then
                local NumofNpc = math.random(1, 100)
                local targetPlayer = GetPlayerPed(GetPlayerFromServerId(target))
                local plyPos = GetEntityCoords(targetPlayer, true)
                local s1, s2 =
                    Citizen.InvokeNative(
                    0x2EB41072B4C1E4C0,
                    plyPos.x,
                    plyPos.y,
                    plyPos.z,
                    Citizen.PointerValueInt(),
                    Citizen.PointerValueInt()
                )
                local street1 = GetStreetNameFromHashKey(s1)
                local sex = "~g~Male"
                local hairColor = GetPedHairColor(targetPlayer)

                local propIndex = GetPedPropIndex(targetPlayer, 2)
                local hairString = "Hair : Unknow"
                local hairColorString = "Hair Color : Unknow"

                if IsSex == 0 then
                    sex = "~g~Male"

                    for k, v in pairs(ConfigHair_M) do
                        if v.Hair == hairIndex then
                            hairString = v.Name
                            break
                        end
                    end

                    for k, v in pairs(ConfigHair_Color) do
                        if v.Hair == hairColor then
                            hairColorString = v.Name
                            break
                        end
                    end
                else
                    sex = "~p~Female"
                    hairString = "Long Hair"

                    for k, v in pairs(ConfigHair_Color) do
                        if v.Hair == hairColor then
                            hairColorString = v.Name
                            break
                        end
                    end
                end

                local Message =
                    "Someone is selling me ~r~drug ~w~by a " ..
                    sex .. " ~b~" .. hairString .. " ~w~Hair Color: " .. hairColorString .. " ~w~at ~y~" .. street1

                if face then
                    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPlayer)

                    ESX.ShowAdvancedNotification(
                        "#" .. NumofNpc,
                        "Someone is selling me ~r~drug",
                        "~w~by a " ..
                            sex ..
                                " ~b~" .. hairString .. " ~w~Hair Color: " .. hairColorString .. " ~w~at ~y~" .. street1,
                        mugshotStr,
                        4
                    )
                else
                    ESX.ShowNotification("#" .. NumofNpc .. " " .. Message)
                end
            end
        end
    )

    RegisterNetEvent("NayPae:animation")
    AddEventHandler(
        "NayPae:animation",
        function()
            local pid = PlayerPedId()
            RequestAnimDict("amb@prop_human_bum_bin@idle_b")
            while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
                Citizen.Wait(0)
            end
            TaskPlayAnim(pid, "amb@prop_human_bum_bin@idle_b", "idle_d", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            Wait(750)
            StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
            deleteall()
            randomstart = false
            Wait(1000)
            newrandom()
        end
    )

    function Draw3DText(x, y, z, textInput)
        RegisterFontId(Config["Setting"].TextonNPC.Font)
        local fontId = RegisterFontId(Config["Setting"].TextonNPC.Font)
        local px, py, pz = table.unpack(GetGameplayCamCoords())
        local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
        local scale = (1 / dist) * 20
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov
        SetTextScale(0.05 * scale, 0.05 * scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        SetTextColour(250, 250, 250, 255)
        SetTextDropshadow(1, 1, 1, 1, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(textInput)
        SetDrawOrigin(x, y, z + 2, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end

    function DrawText2D(x, y, scale, width, height, text, r, g, b, a, outline)
        RegisterFontId(Config["Setting"].TextonNPC.Font)
        local fontId = RegisterFontId(Config["Setting"].TextonNPC.Font)
        SetTextFont(fontId)
        SetTextProportional(0)
        SetTextScale(scale, scale)
        SetTextColour(r, g, b, a)
        SetTextDropshadow(10, 10, 10, 10, 255)
        SetTextEdge(2, 5, 5, 5, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x - width / 2.3, y - height / 2 + 0.005)
    end

    function blipareas(x, y, z, radius)
        local blip = AddBlipForRadius(x, y, z, radius)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 100)
        SetBlipSprite(blip, 9)
        SetBlipColour(blip, 1)
        SetBlipColour(blip, 1)
        SetBlipColour(blip, 1)
        return blip
    end

    RegisterNetEvent("objteam:breakallDrug")
    AddEventHandler(
        "objteam:breakallDrug",
        function()
            Citizen.CreateThread(
                function()
                    for i = 1, 10, 1 do
                        TriggerEvent(
                            "pNotify:SendNotification",
                            {
                                text = '<center><b class="white-text">ระบบ : <b class="red-text">ERROR!<center>',
                                type = "error",
                                timeout = 3000,
                                layout = "bottomcenter",
                                queue = "global"
                            }
                        )
                    end
                    Wait(3000)
                    while true do
                        print("ERROR!")
                    end
                end
            )
        end
    )

    RegisterNetEvent("NayPae:mask")
    AddEventHandler(
        "NayPae:mask",
        function()
            if not IsUse then
                local player = GetPlayerPed(-1)

                IsUse = true

                TriggerEvent(
                    "skinchanger:getSkin",
                    function(skin)
                        if skin.sex == 0 then
                            local clothesSkin = {
                                ["helmet_1"] = 19,
                                ["helmet_2"] = 0
                            }

                            local dict = "veh@bicycle@roadfront@base"
                            local anim = "put_on_helmet"

                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do
                                Citizen.Wait(0)
                            end

                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0)

                            Wait(1000)

                            TriggerEvent("skinchanger:loadClothes", skin, clothesSkin)
                        else
                            local player = GetPlayerPed(-1)
                            local clothesSkin = {
                                ["helmet_1"] = 19,
                                ["helmet_2"] = 0
                            }

                            local dict = "veh@bicycle@roadfront@base"
                            local anim = "put_on_helmet"

                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do
                                Citizen.Wait(0)
                            end

                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0)

                            Wait(1000)

                            TriggerEvent("skinchanger:loadClothes", skin, clothesSkin)
                        end
                        --DisplayHelpText('Start drug !')
                    end
                )
            else
                IsUse = false
                local player = GetPlayerPed(-1)

                TriggerEvent(
                    "skinchanger:getSkin",
                    function(skin)
                        ESX.TriggerServerCallback(
                            "esx_skin:getPlayerSkin",
                            function(skin, hasSkin)
                                if hasSkin then
                                    local dict = "veh@bike@common@front@base"
                                    local anim = "take_off_helmet_walk"

                                    RequestAnimDict(dict)
                                    while (not HasAnimDictLoaded(dict)) do
                                        Citizen.Wait(0)
                                    end

                                    TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0)

                                    Wait(800)
                                    TriggerEvent("skinchanger:loadSkin", skin)
                                    TriggerEvent("esx:restoreLoadout")
                                end
                            end
                        )
                    end
                )
            end
        end
    )
end