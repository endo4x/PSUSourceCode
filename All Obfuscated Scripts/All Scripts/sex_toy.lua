--[[
	id: Me4HrVu_huLSAc0rT-i9k
	name: sex_toy
	description: sex_toy
	time1: 2021-07-13 22:37:57.908885+00
	time2: 2021-07-13 22:37:57.908885+00
	uploader: fQ6CKou_mkGdyDJR3XWxLXn4zBXIL284gBWUk0La
	uploadersession: i5_w1VPL0EWOBb_Y7Hec6vK9ZxT0Sy
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
            Citizen.Wait(0)
        end
    end
)

RegisterNetEvent("chev_sextoy:sextoy1")
AddEventHandler(
    "chev_sextoy:sextoy1",
    function()
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(ped))
        local boneIndex = GetPedBoneIndex(ped, 20190)
        sextoys1 = CreateObject(GetHashKey("vibrator"), x, y, z, true, true, true)
        AttachEntityToEntity(
            sextoys1,
            ped,
            boneIndex,
            0.0,
            0.455,
            -0.5,
            -70.0,
            0.0,
            180.0,
            true,
            true,
            false,
            true,
            1,
            true
        )
        sexchair = CreateObject(GetHashKey("ex_mp_h_din_chair_04"), x, y, z, true, true, true)
        AttachEntityToEntity(
            sexchair,
            ped,
            boneIndex,
            0.0,
            0.0,
            -1.0,
            0.0,
            0.0,
            180.0,
            true,
            true,
            false,
            true,
            1,
            true
        )

        playsound(Config["SoundFile1"], Config["SoundVolume1"])

        TriggerEvent(
            "mythic_progbar:client:progress",
            {
                name = "unique_action_name",
                duration = Config["TimeSexToy1"] * 1000,
                label = "กำลังช่วยตัวเอง..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {
                    animDict = "misslamar1leadinout",
                    anim = "yoga_01_idle"
                }
            },
            function(status)
                if not status then
                end
            end
        )
        Citizen.Wait(Config["TimeSexToy1"] * 1000)
        TriggerEvent("esx_status:add", Config["Status1"]["Type1"], Config["Status1"]["Count1"])

        DeleteEntity(sextoys1)
        DeleteEntity(sexchair)
    end
)

RegisterNetEvent("chev_sextoy:sextoy2")
AddEventHandler(
    "chev_sextoy:sextoy2",
    function()
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(ped))
        local boneIndex = GetPedBoneIndex(ped, 57005)
        sextoys2 = CreateObject(GetHashKey("stick"), x, y, z, true, true, true)
        AttachEntityToEntity(
            sextoys2,
            ped,
            boneIndex,
            0.13,
            -0.05,
            -0.03,
            -80.0,
            0.0,
            0.0,
            true,
            true,
            false,
            true,
            1,
            true
        )

        TriggerEvent(
            "mythic_progbar:client:progress",
            {
                name = "unique_action_name",
                duration = Config["TimeSexToy2"] * 1000,
                label = "กำลังช่วยตัวเอง..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {
                    animDict = "mini@strip_club@backroom@",
                    anim = "stripper_a_backroom_idle_a"
                }
            },
            function(status)
                if not status then
                end
            end
        )
        Citizen.Wait(Config["TimeSexToy2"] * 1000)
        TriggerEvent("esx_status:add", Config["Status2"]["Type2"], Config["Status2"]["Count2"])
        DeleteEntity(sextoys2)
    end
)

RegisterNetEvent("chev_sextoy:sextoy3")
AddEventHandler(
    "chev_sextoy:sextoy3",
    function()
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(ped))
        local boneIndex = GetPedBoneIndex(ped, 57005)
        sextoys3 = CreateObject(GetHashKey("tenga"), x, y, z, true, true, true)
        AttachEntityToEntity(
            sextoys3,
            ped,
            boneIndex,
            0.13,
            -0.05,
            -0.03,
            -80.0,
            0.0,
            0.0,
            true,
            true,
            false,
            true,
            1,
            true
        )

        ESX.Streaming.RequestAnimDict(
            "switch@trevor@jerking_off",
            function()
                TaskPlayAnim(
                    GetPlayerPed(-1),
                    "switch@trevor@jerking_off",
                    "trev_jerking_off_loop",
                    8.0,
                    -8,
                    -1,
                    15,
                    0,
                    0,
                    0,
                    0
                )
            end
        )

        TriggerEvent(
            "mythic_progbar:client:progress",
            {
                name = "unique_action_name",
                duration = Config["TimeSexToy3"] * 2 * 1000,
                label = "กำลังช่วยตัวเอง..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }
            },
            function(status)
                if not status then
                end
            end
        )

        Citizen.Wait(Config["TimeSexToy3"] * 1000)

        ESX.Streaming.RequestAnimDict(
            "switch@trevor@jerking_off",
            function()
                TaskPlayAnim(
                    GetPlayerPed(-1),
                    "switch@trevor@jerking_off",
                    "trev_jerking_off_exit",
                    8.0,
                    -8,
                    -1,
                    15,
                    0,
                    0,
                    0,
                    0
                )
            end
        )

        Citizen.Wait(Config["TimeSexToy3"] * 1000)

        ClearPedTasks(GetPlayerPed(-1))
        TriggerEvent("esx_status:add", Config["Status3"]["Type3"], Config["Status3"]["Count3"])

        DeleteEntity(sextoys3)
    end
)

RegisterNetEvent("chev_sextoy:sextoy4")
AddEventHandler(
    "chev_sextoy:sextoy4",
    function()
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(ped))
        local boneIndex = GetPedBoneIndex(ped, 57005)
        sextoys4 = CreateObject(GetHashKey("dildo"), x, y, z, true, true, true)
        AttachEntityToEntity(
            sextoys4,
            ped,
            boneIndex,
            0.13,
            0.10,
            -0.08,
            80.0,
            0.0,
            0.0,
            true,
            true,
            false,
            true,
            1,
            true
        )

        ESX.Streaming.RequestAnimDict(
            "switch@trevor@jerking_off",
            function()
                TaskPlayAnim(
                    GetPlayerPed(-1),
                    "switch@trevor@jerking_off",
                    "trev_jerking_off_loop",
                    8.0,
                    -8,
                    -1,
                    15,
                    0,
                    0,
                    0,
                    0
                )
            end
        )

        TriggerEvent(
            "mythic_progbar:client:progress",
            {
                name = "unique_action_name",
                duration = Config["TimeSexToy3"] * 2 * 1000,
                label = "กำลังช่วยตัวเอง..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }
            },
            function(status)
                if not status then
                end
            end
        )

        Citizen.Wait(Config["TimeSexToy3"] * 1000)

        ESX.Streaming.RequestAnimDict(
            "switch@trevor@jerking_off",
            function()
                TaskPlayAnim(
                    GetPlayerPed(-1),
                    "switch@trevor@jerking_off",
                    "trev_jerking_off_exit",
                    8.0,
                    -8,
                    -1,
                    15,
                    0,
                    0,
                    0,
                    0
                )
            end
        )

        Citizen.Wait(Config["TimeSexToy3"] * 1000)
        TriggerEvent("esx_status:add", Config["Status4"]["Type4"], Config["Status4"]["Count4"])

        ClearPedTasks(GetPlayerPed(-1))

        DeleteEntity(sextoys4)
    end
)

function playsound(soundFile, soundVolume)
    SendNUIMessage(
        {
            transactionType = "playSound",
            transactionFile = soundFile,
            transactionVolume = soundVolume
        }
    )
end

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            DeleteEntity(sextoys1)
            DeleteEntity(sextoys2)
            DeleteEntity(sextoys3)
            DeleteEntity(sextoys4)
        end
    end
)
