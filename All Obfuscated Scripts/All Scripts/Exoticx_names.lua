--[[
	id: Mqto6kPko2i2PvJTz4FsG
	name: Exoticx_names
	description: Exoticx_names
	time1: 2021-06-03 09:16:46.425883+00
	time2: 2021-06-03 09:16:46.425884+00
	uploader: Q331ngUdHeqAoT4Xbi9equ_csUeEJgEZHC-_YBm2
	uploadersession: 3mKKYDrwidTB93pHLn3le174OVJLYB
	flag: t
--]]

local disPlayerNames = 20
local playerSource = 0
local ESPON = false
local PlayersTagV = {}

RegisterNetEvent("ESPNAMEFN")
AddEventHandler(
    "ESPNAMEFN",
    function()
        if ESPON == false then
            disPlayerNames = 100
            print("esp on")
            ESPON = true
        else
            disPlayerNames = 20
            print("esp off")
            ESPON = false
        end
    end
)

RegisterNetEvent("hlrangef")
AddEventHandler(
    "hlrangef",
    function()
        disPlayerNames = 9999
    end
)

local defaultColor = {r = 245, g = 245, b = 245, a = 255}
local armorColor = {r = 50, g = 170, b = 250, a = 200}
local bgColor = {r = 0, g = 0, b = 0, a = 100}

local function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000
    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
    return result
end

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

        while true do
            local closep = false
            local MyCamCoords = GetGameplayCamCoords()
            local localFPS = 1 / GetFrameTime()
            local localPl = PlayerId()
            local ra = RGBRainbow(1.0)
            local Freeaim, AimedAtEntity = GetEntityPlayerIsFreeAimingAt(localPl)

            for _, id in ipairs(GetActivePlayers()) do
                if id ~= localPl then
                    local ped = GetPlayerPed(id)
                    local playerHead =
                        GetPedBoneCoords(ped, 12844, 0, 0, 0) + vector3(0, 0, 0.7) + (GetEntityVelocity(ped) / localFPS)
                    local distance = math.floor(#(MyCamCoords - playerHead))
                    if
                        ESPON and distance < disPlayerNames and
                            World3dToScreen2d(playerHead.x, playerHead.y, playerHead.z)
                     then
                        closep = true
                        SetPedMaxHealth(ped, 200)
                        --local v 		= (GetPlayerTagV(id) and ""..GetPlayerTagV(id).."" or "")
                        --local vip 		= GetPlayerTagV(id)
                        local talking = NetworkIsPlayerTalking(id)
                        local healthtx = GetEntityHealth(ped)

                        SetDrawOrigin(playerHead, false)

                        local sizeOffset = math.max(1 - distance / 20, 0.5)
                        RegisterFontFile("FontTH")
                        fontId = RegisterFontId("FontTH")
                        SetTextFont(fontId)

                        --if vip then
                        --SetTextColour(ra.r, ra.g, ra.b, 255)
                        --end
                        SetTextScale(0.0, 0.4 * sizeOffset)
                        SetTextCentre(true)
                        SetTextOutline()
                        SetTextEntry("STRING")
                        AddTextComponentString(
                            string.format("~w~HP : ~g~" .. healthtx - 100 .. "~s~~n~") ..
                                "~c~[ ~w~" ..
                                    GetPlayerServerId(id) ..
                                        "~c~ ]~r~ | " ..
                                            "~s~" ..
                                                string.sub(GetPlayerName(id), 1, 44) ..
                                                    (talking and "~n~~b~Talking..." or "")
                        )
                        DrawText(0.0, 0.0)
                        --if ped == AimedAtEntity then

                        local Health = GetEntityHealth(ped)
                        local Armor = GetPedArmour(ped)
                        local healthPercent = math.min(math.max((Health - 100) / 100, 0.0), 1.0)
                        local armorPercent = math.min(math.max(Armor / 100, 0.0), 1.0)
                        local armorBar = ESX.Math.Round(150 * armorPercent) * sizeOffset
                        local line = 1

                        --if vip then
                        line = line + 1
                        --end
                        if talking then
                            line = line + 1
                        end

                        GTAN_DrawRectangle(
                            -75 * sizeOffset,
                            40 * (sizeOffset * line),
                            armorBar,
                            18 * sizeOffset,
                            armorColor.r,
                            armorColor.g,
                            armorColor.b,
                            armorColor.a
                        )
                        GTAN_DrawRectangle(
                            -75 * sizeOffset + armorBar,
                            40 * (sizeOffset * line),
                            sizeOffset * 150 - armorBar,
                            sizeOffset * 18,
                            bgColor.r,
                            bgColor.g,
                            bgColor.b,
                            bgColor.a
                        )
                        GTAN_DrawRectangle(
                            -71 * sizeOffset,
                            (44 - (line)) * (sizeOffset * line),
                            142 * healthPercent * sizeOffset,
                            10 * sizeOffset,
                            250,
                            50,
                            50,
                            200
                        )
                    end
                    ClearDrawOrigin()
                --end
                end
            end
            if not closep then
                Citizen.Wait(500)
            end
            Citizen.Wait(0)
        end
    end
)

function GTAN_DrawRectangle(xPos, yPos, wSize, hSize, r, g, b, alpha)
    local _width, _height = GetScreenActiveResolution()
    local ratio = _width / _height
    local width = _height * ratio
    local w = wSize / width
    local h = hSize / _height
    local x = (xPos / width) + w * 0.5
    local y = (yPos / _height) + h * 0.5

    DrawRect(x, y, w, h, r, g, b, alpha)
end
