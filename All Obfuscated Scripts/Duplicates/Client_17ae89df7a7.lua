--[[
	id: yn1vATY0vFn4RTBQHaQdU
	name: Client
	description: Client
	time1: 2021-05-22 22:52:45.562236+00
	time2: 2021-05-22 22:52:45.562237+00
	uploader: lqGTM7c9511nXgsYGn6GipciWzXeF4k1dlePPmkB
	uploadersession: kei8QVOxGrWrbSu-4mcMQRX3yAF2rK
	flag: f
--]]

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.event, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local block = false


function notify(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end


function animation()
        loadAnimDict( "missheist_agency2aig_13" )
       TaskPlayAnim(PlayerPedId(), "missheist_agency2aig_13", "pickup_briefcase", 8.0, 2.0, -1, 2, 0.0, 0, 0, 1)
        TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_KNEEL', 0, false)
        TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = Config.ProgressbarTime,
        label = Config.Progressbar,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@gangops@meeworgue@table@",
            anim = "player_search",
        }
    }, function(status)
end)
end


--Keys blockieren
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if block then
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 2, true) 
            DisableControlAction(0, 263, true) 
            DisableControlAction(0, 45, true) 
            DisableControlAction(0, 22, true) 
            DisableControlAction(0, 44, true) 
            DisableControlAction(0, 37, true) 
            DisableControlAction(0, 288, true) 
            DisableControlAction(0, 289, true) 
            DisableControlAction(0, 170, true) 
            DisableControlAction(0, 167, true) 
            DisableControlAction(1, 254, true)
            DisableControlAction(0, 47, true)  
            DisableControlAction(0, 73, true)  
            DisableControlAction(0, 105, true)  
            DisableControlAction(0, 120, true)  
            DisableControlAction(0, 154, true)  
            DisableControlAction(0, 186, true)  
            DisableControlAction(0, 252, true)
            DisableControlAction(0, 323, true)
            DisableControlAction(0, 337, true)
            DisableControlAction(0, 344, true)
            DisableControlAction(0, 353, true)
            DisableControlAction(0, 357, true)
        end
    end
end)


local display = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.positionx, Config.positiony, Config.positionz, true) < 5 then
            notify(Config.welcomeMessage)
            if IsControlJustPressed(0, 51) then
                SetDisplay(not display)
            end
        end
    end
end)



RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("kaufen", function(data)
    SetDisplay(false)
        TriggerServerEvent('j_itemverarbeiterxd:kaufen')
                  animation()
                  block = true
                Citizen.Wait(Config.LongWaitToCanUseKeyboard)
                    ClearPedTasks(PlayerPedId())
                    block = false

end)

RegisterNUICallback("error", function(data)
    ESX.ShowNotification(data.error)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end


RegisterNetEvent('j_notify')
AddEventHandler('j_notify', function(color, title, message)
    SendNUIMessage({
        type = "custom",
        color = color,
         title = title,
        message = message,
    })
  PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

end)


Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) 
        DisableControlAction(0, 2, display) 
        DisableControlAction(0, 142, display) 
        DisableControlAction(0, 18, display) 
        DisableControlAction(0, 322, display) 
        DisableControlAction(0, 106, display) 
    end
end)

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end
