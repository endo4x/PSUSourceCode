--[[
	id: QGDDaXlyL5WCMcgE3Ow1b
	name: Debug
	description: BB
	time1: 2021-06-16 10:41:55.271366+00
	time2: 2021-06-16 10:41:55.271367+00
	uploader: 2dGIbc8MJ8as7nDxgiujRk1a_f1mJtaDhWcf59F1
	uploadersession: EI7mkPQN785uz2Iy9I2jSEv2GLNGAO
	flag: f
--]]

ESX = nil
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                Config.Base.getSharedObject,
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

RegisterFontFile(Config.Font)
fontId1 = RegisterFontId(Config.Font)

local zone, button = false, false
local cachedBins = {}

Citizen.CreateThread(
    function()
        local _Config = Config.Blips
        if _Config.EnbleBlip then
            for k, v in pairs(Config.Zone.Pos) do
                local blip1 = AddBlipForCoord(v.x, v.y, v.z)

                SetBlipSprite(blip1, _Config.Id)
                SetBlipDisplay(blip1, 4)
                SetBlipScale(blip1, _Config.Size)
                SetBlipColour(blip1, _Config.Color)
                SetBlipAsShortRange(blip1, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(_Config.Text)
                EndTextCommandSetBlipName(blip1)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        Citizen.Wait(7)
        while true do
            local sleepThread = 1000
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k, v in pairs(Config.Zone.Pos) do
                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < v.range) then
                    sleepThread = 5
                    DrawTxt(0.960, 0.600, 1.1, 1.10, 0.60, Config.R["Text"], 255, 255, 255, 255)
                    zone = true
                else
                    zone = false
                end
            end
            Citizen.Wait(sleepThread)
        end
    end
)

Citizen.CreateThread(
    function()
        Citizen.Wait(7)
        while true do
            local sleepThread = 1000
            if zone then
                local ped = GetPlayerPed(-1)
                local coords = GetEntityCoords(ped)
                for i = 1, #Config.Prop do
                    local objectId =
                        GetClosestObjectOfType(
                        coords.x,
                        coords.y,
                        coords.z,
                        2.0,
                        GetHashKey(Config.Prop[i]),
                        true,
                        true,
                        true
                    )
                    local chairCoords = GetEntityCoords(objectId)
                    if
                        GetDistanceBetweenCoords(
                            coords.x,
                            coords.y,
                            coords.z,
                            chairCoords.x,
                            chairCoords.y,
                            chairCoords.z,
                            1
                        ) <= 2.0
                     then
                        sleepThread = 5
                        if not button then
                            DrawText3D(chairCoords.x, chairCoords.y, chairCoords.z + 1.0, Config.R["DrawText3D"])
                        end
                        if IsControlJustReleased(0, 38) and not button then
                            button = true
                            if ChickItem(Config.ItemUser) then
                                TriggerServerEvent("78ce15704096ff13e345e55a1f293c55")
                                if not cachedBins[objectId] then
                                    cachedBins[objectId] = true
                                    TaskStartScenarioInPlace(PlayerPedId(), "world_human_welding", 0, true)
                                    progbar()
                                    Citizen.Wait(Config.Time * 1000)
                                    TriggerServerEvent("renzer_scrap:additem")
                                    button = false
                                    ClearPedTasks(PlayerPedId())
                                else
                                    button = false
                                    Notify_client("คุณค้นจุดนี้ไปแล้ว", "error")
                                end
                            else
                                button = false
                                Notify_client(Config.R["NoItemUse"], "error")
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleepThread)
        end
    end
)

function ChickItem(item_name)
    local inventory = ESX.GetPlayerData().inventory
    for i = 1, #inventory do
        local item = inventory[i]
        if item_name == item.name and item.count > 0 then
            return true
        end
    end
    return false
end

DrawText3D = function(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    local scale = 0.45

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.030, 66, 66, 66, 150)
    end
end
function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(fontId1)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end
