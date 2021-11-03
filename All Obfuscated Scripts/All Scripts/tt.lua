--[[
	id: jI9Tk2slmU3fFevDnRhXq
	name: tt
	description: tt
	time1: 2021-04-27 15:28:17.505301+00
	time2: 2021-04-27 15:28:17.505302+00
	uploader: kUkTOL37Z_pljmMWprHM33zRuAnu1SjVlzRLXH-Q
	uploadersession: 2thCVY6KxT39gAp3dbufDY88XejIKb
	flag: f
--]]


local pedDisplaying = {}

local function draw3dText(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)

    local scale = 200 / (GetGameplayCamFov() * dist)
    SetTextProportional(1)
    SetTextColour(250, 0, 0, 220)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextScale(0.0, 0.5 * scale)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local function displayText(ped, text)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)
    if dist <= 250 then
        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1
        local display = true
        Citizen.CreateThread(
            function()
                Wait(5000)
                display = false
            end
        )
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        local x, y, z = table.unpack(GetEntityCoords(ped))
        z = z + offset
        while display do
            draw3dText(vector3(x, y, z), text)
            Wait(0)
        end
        pedDisplaying[ped] = pedDisplaying[ped] - 1
    end
end

RegisterNetEvent("displaymessage")
AddEventHandler(
    "displaymessage",
    function(text, serverId)
        local player = GetPlayerFromServerId(serverId)
        if player ~= -1 or serverId == GetPlayerServerId(PlayerId()) then
            local ped = GetPlayerPed(player)
            displayText(ped, text)
        end
    end
)
