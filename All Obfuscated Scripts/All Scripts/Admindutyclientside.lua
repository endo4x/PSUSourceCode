--[[
	id: QNaaAR32oZ48DED31EGu8
	name: Admin duty client side
	description: Admin duty client side
	time1: 2021-05-24 02:31:22.624502+00
	time2: 2021-05-24 02:31:22.624503+00
	uploader: fBZ7JE4HlNXVYKdmQhUI8c0AeYPNu-IoVaUNGlsE
	uploadersession: MhzULNaGxjfRzpekKGntbkcuVgfNei
	flag: f
--]]

local authorized = false

---------------- DON'T TOUCH THIS ----------------
local adminduty = false
local bigjump = false
local godmode = false
local invisible = false
local speed = false
local fly = false
-------------------------------------------------

CreateThread(
    function()
        while ESX == nil do
            Wait(1000)
        end
        Wait(2000)
        while true do
            if authorized == false then
                ESX.TriggerServerCallback(
                    "asdasd_getauthorized_adminduty",
                    function(authorizedserver)
                        authorized = json.decode(authorizedserver)
                    end
                )
            end
            Wait(2000)
        end
    end
)
------------------------------------------

ESX = nil
local basic = {}

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

local adminonduty = {}
local players = {}
local nearplayersdata = {{0}}
local dutytime = 0

RegisterNetEvent("asdasd_adminduty_setadminonduty")
AddEventHandler(
    "asdasd_adminduty_setadminonduty",
    function(adminondutys)
        if authorized == true then
            adminonduty = adminondutys
            adminduty = isonduty()
            if adminduty then
                if Xtreme.useadminped then
                    local ped = Xtreme.adminpeds[getmygroup()]
                    print(ped)
                    loadadminped(ped)
                end
            else
                if Xtreme.useadminped then
                    loadplayerskin()
                    ESX.TriggerServerCallback(
                        "esx_skin:getPlayerSkin",
                        function(skin)
                            TriggerEvent("skinchanger:loadSkin", skin)
                        end
                    )
                    TriggerEvent("esx:restoreLoadout")
                end
                adminduty = false
                bigjump = false
                godmode = false
                invisible = false
                speed = false
                fly = false
                dutytime = 0
            end
        end
    end
)

function getmygroup()
    for _, v in ipairs(adminonduty) do
        if GetPlayerServerId(PlayerId()) == v.serverid then
            return v.playergroup
        end
    end
    return false
end

function isonduty()
    for _, v in ipairs(adminonduty) do
        if GetPlayerServerId(PlayerId()) == v.serverid then
            return true
        end
    end
    return false
end

function loadplayerskin()
    local hash = GetHashKey("mp_m_freemode_01")

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(0)
    end

    SetPlayerModel(PlayerId(), hash)
    TriggerEvent("esx:restoreLoadout")
end

function loadadminped(pedmodel)
    local hash = GetHashKey(pedmodel)

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(0)
    end

    SetPlayerModel(PlayerId(), hash)
    TriggerEvent("esx:restoreLoadout")
end

Citizen.CreateThread(
    function()
        while true do
            if adminduty then
                dutytime = dutytime + 1
            end
            Wait(1000)
        end
    end
)

function totime(secondsArg)
    local hours = math.floor(secondsArg / 3600)
    local remainder = secondsArg % 3600
    local minutes = math.floor(remainder / 60)
    local seconds = remainder % 60

    return hours, minutes, seconds
end

Citizen.CreateThread(
    function()
        while not ESX do
            Citizen.Wait(50)
        end

        while true do
            Wait(1000)
            for _, player in ipairs(GetActivePlayers()) do
                if NetworkIsPlayerActive(player) and GetPlayerPed(player) ~= GetPlayerPed(-1) then
                    ped = GetPlayerPed(player)
                    blip = GetBlipFromEntity(ped)
                    gamertag =
                        CreateMpGamerTag(
                        GetPlayerPed(player),
                        GetPlayerName(player) .. " | " .. GetPlayerServerId(player),
                        false,
                        false,
                        "",
                        0
                    )

                    if adminduty then
                        SetMpGamerTagVisibility(gamertag, 0, true)
                        SetMpGamerTagVisibility(gamertag, 2, true)
                        SetMpGamerTagAlpha(gamertag, 2, 255)
                        if not DoesBlipExist(blip) then
                            blip = AddBlipForEntity(ped)
                            SetBlipSprite(blip, 1)
                            SetBlipNameToPlayerName(blip, player)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                        end
                    else
                        SetMpGamerTagVisibility(gamertag, 0, false)
                        SetMpGamerTagVisibility(gamertag, 2, false)
                        RemoveBlip(blip)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            sleep = 5
            if fly then
                if IsControlJustPressed(0, 22) then
                    while not IsControlJustReleased(0, 22) do
                        local playerped = GetPlayerPed(-1)
                        local coords = GetEntityCoords(playerped)
                        SetEntityCoords(playerped, coords + vector3(0, 0, 1.0))
                        TaskParachute(playerped, 1)
                        SetParachuteTaskThrust(playerped, 0.1)
                        Wait(5)
                    end
                end
            end
            Wait(sleep)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            sleep = 1000
            local playerped = GetPlayerPed(-1)
            if invisible then
                SetEntityVisible(playerped, false)
            else
                SetEntityVisible(playerped, true)
            end
            Wait(sleep)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            sleep = 500
            local playerped = PlayerId()
            if bigjump then
                sleep = 5
                SetSuperJumpThisFrame(playerped)
            end

            if godmode then
                sleep = 5
                SetPlayerInvincible(playerped, true)
                SetPedCanRagdoll(GetPlayerPed(-1), false)
                SetPlayerFallDistance(playerped, 99999.0)
            end

            if speed then
                sleep = 5
                SetRunSprintMultiplierForPlayer(playerped, 1.8)
                SetPedMoveRateOverride(GetPlayerPed(-1), 1.8)
                ResetPlayerStamina(palyerped)
            end
            Wait(sleep)
        end
    end
)

Citizen.CreateThread(
    function()
        while ESX == nil do
            Citizen.Wait(50)
        end
        while true do
            sleep = 1000
            nearplayersdata = {{0}}
            local meped = GetPlayerPed(-1)
            local mepedcoords = GetEntityCoords(meped)
            local jatekosid = PlayerId()
            players = ESX.Game.GetPlayersInArea(mepedcoords, 20.0)
            nearplayersdata = players
            table.insert(nearplayersdata, jatekosid)
            Citizen.Wait(sleep)
        end
    end
)

Citizen.CreateThread(
    function()
        while not ESX do
            Citizen.Wait(50)
        end

        loadtexture("adminlogo")

        while true do
            sleep = 1000
            for i, value in ipairs(adminonduty) do
                for i2, value2 in ipairs(nearplayersdata) do
                    if GetPlayerServerId(value2) == value.serverid then
                        sleep = 5
                        local targetPed, targetPedCords = getplayerinfo(jatekosid, value.serverid, value2)
                        if value.atag then
                            local x, y, z = table.unpack(targetPedCords)
                            DrawMarker(
                                9,
                                x,
                                y,
                                z + 1.5,
                                0.0,
                                0.0,
                                0.0,
                                90.0,
                                90.0,
                                0.0,
                                1.0,
                                1.0,
                                0.0,
                                255,
                                255,
                                255,
                                244,
                                false,
                                false,
                                2,
                                true,
                                "adminlogo",
                                "logo",
                                false
                            )
                            ASDASD3DTEXT(
                                targetPedCords,
                                GetPlayerName(targetped) .. " " .. Xtreme.admingroups[value.playergroup],
                                0.4
                            )
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end
)

function ASDASD3DTEXT(vector, text, textscale)
    local x, y, z = table.unpack(vector)
    SetTextScale(textscale, textscale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 200)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z + 1.0, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function getplayerinfo(jatekosid, adminid, value2)
    if jatekosid == adminid then
        targetPed = GetPlayerPed(-1)
        targetPedCords = GetEntityCoords(targetPed)
        return targetPed, targetPedCords
    else
        targetPed = GetPlayerPed(value2)
        targetPedCords = GetEntityCoords(targetPed)
        return targetPed, targetPedCords
    end
end

function loadtexture(texture)
    if not HasStreamedTextureDictLoaded(texture) then
        RequestStreamedTextureDict(texture, true)
        while not HasStreamedTextureDictLoaded(texture) do
            Citizen.Wait(1)
        end
    end
end

--------------- NUI -------------------------
Citizen.CreateThread(
    function()
        while true do
            if authorized == true then
                if IsControlJustReleased(0, 212) then
                    openUI()
                end
            end
            Citizen.Wait(5)
        end
    end
)

function openUI(source)
    local _source = source
    local playerName = GetPlayerName(_source)
    local group = GetPlayerGroup(_source)

    ESX.TriggerServerCallback(
        "xtreme_admindutygetinfo",
        function(data)
            local steamavatar = string.gsub(data.mydata.steamid, "steam:", "")

            local hours, minutes, seconds = totime(dutytime)
            if seconds > 0 then
                data.mydata.admintime = seconds .. " másodperc"
            end
            if minutes > 0 then
                data.mydata.admintime = minutes .. " perc " .. seconds .. " másodperc"
            end
            if hours > 0 then
                data.mydata.admintime = hours .. " óra " .. minutes .. " perc " .. seconds .. " másodperc"
            end

            SendNUIMessage(
                {
                    action = "asd",
                    steamid = steamavatar,
                    mydata = data.mydata,
                    usersdata = data.usersdata
                }
            )
            SetNuiFocus(true, true)
        end
    )
end

RegisterNUICallback(
    "onCloseMenu",
    function()
        SetNuiFocus(false, false)
    end
)

RegisterNUICallback(
    "logoon",
    function()
        TriggerServerEvent("xtreme_adminduty_logo")
    end
)

RegisterNUICallback(
    "dutyoff",
    function()
        TriggerServerEvent("xtreme_adminduty", dutytime)
    end
)

RegisterNUICallback(
    "dutyon",
    function()
        TriggerServerEvent("xtreme_adminduty")
    end
)

RegisterNUICallback(
    "jumpon",
    function()
        if adminduty then
            bigjump = true
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "jumpoff",
    function()
        if adminduty then
            bigjump = false
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "godmodeoff",
    function()
        if adminduty then
            godmode = false
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "godmodeon",
    function()
        if adminduty then
            godmode = true
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "invisibleoff",
    function()
        if adminduty then
            invisible = false
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "invisibleon",
    function()
        if adminduty then
            invisible = true
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "speedoff",
    function()
        if adminduty then
            speed = false
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "speedon",
    function()
        if adminduty then
            speed = true
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "flyoff",
    function()
        if adminduty then
            fly = false
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)

RegisterNUICallback(
    "flyon",
    function()
        if adminduty then
            fly = true
        else
            ESX.ShowNotification("~r~Nem vagy adminszolgálatban!")
        end
    end
)
