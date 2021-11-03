--[[
	id: fQROYo0eE5dHI9sgn89Xf
	name: Neues Admin IPAd Clinet Lua
	description: 32
	time1: 2021-06-27 01:28:24.95613+00
	time2: 2021-06-27 01:28:24.95613+00
	uploader: endILJ7HNjVIZCz1DajtBSeklWVeOgx1J3h9pS6d
	uploadersession: pPgYfyAQ9sdYSqaqndOnhd6Gu11Uxe
	flag: f
--]]

ESX = nil
local hudopen = false

--voice Settings
local isInRadio = false
local radioChannel = nil
local radioState = 0

print("started")

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNUICallback("trigger", function(data,cb)
    if data.event == "onWindowClosed" then
        SetNuiFocus(false,false)
        hudopen = false
    end
    if data.event == "componentEvent" then
    end
    if data.event == "componentTriggerServerEvent" then
        if data.args[1] == "SupportVehicleList" then
            if data.args[2] == "requestSupportVehicleList" then
                ESX.TriggerServerCallback('ipad:getVehicleDataFromName', function(data)
                    SendNUIMessage({
                        action = "responseVehicleList",
                        data = json.encode(data)
                    })
                end, data.args[3])
            end
        end
        if data.args[1] == "SupportVehicleProfile" then
            if data.args[2] == "requestVehicleData" then
                ESX.TriggerServerCallback('ipad:getVehicleData', function(data)
                    SendNUIMessage({
                        action = "responseVehicleData",
                        data = json.encode(data)
                    })
                end, data.args[3])
            end
            if data.args[2] == "SupportSetGarage" then
                ESX.TriggerServerCallback('ipad:supportSetVehicleInGarage', function(data)
                end, data.args[3], 1)
            end
        end
        if data.args[1] == "IpadDesktopApp" then
            if data.args[2] == "requestIpadApp" then
                local apps = {
                    {
                        name = "Support",
                        icon = "support_tickets.4cac8738.svg",
                        appName = "SupportOverviewApp"
                    },
                    {
                        name = "Fahrzeug",
                        icon = "vehicle_support.4a257081.svg",
                        appName = "SupportVehicleApp"
                    }
                }
                SendNUIMessage({
                    action = "responseIpadApps",
                    apps = json.encode(apps)
                })
            end
        end
        if data.args[1] == "SupportOpenTickets" then
            if data.args[2] == "requestOpenSupportTickets" then
                ESX.TriggerServerCallback('ipad:getOpenTickets', function(tickets)
                    SendNUIMessage({
                        action = "responseOpenTickets",
                        tickets = json.encode(tickets)
                    })
                end)
            end
            if data.args[2] == "acceptOpenSupportTicket" then
                ESX.TriggerServerCallback('ipad:acceptOpenSupportTicket', function()
                end, data.args[3])
            end
        end
        if data.args[1] == "SupportAcceptedTickets" then
            if data.args[2] == "requestAcceptedTickets" then
                ESX.TriggerServerCallback('ipad:getAcceptedTickets', function(tickets)
                    SendNUIMessage({
                        action = "responseAcceptedTickets",
                        tickets = json.encode(tickets)
                    })
                end)
            end
        end
        if data.args[1] == "SupportTicketOverview" then
            if data.args[2] == "closeTicket" then
                ESX.TriggerServerCallback('ipad:closeTicket', function()
                end, data.args[3])
            end
        end
        if data.args[1] == "SupportTicketOverview" then
            if data.args[2] == "supportTeleportToPlayer" then
                ESX.TriggerServerCallback('ipad:teleport', function()
                end, data.args[3])
            end
            if data.args[2] == "supportJobPlayer" then
                ESX.TriggerServerCallback('ipad:job', function()
                end, data.args[3])
            end
            if data.args[2] == "supportRevivePlayer" then
                ESX.TriggerServerCallback('ipad:revive', function()
                end, data.args[3])
            end
        end
    end
end)

RegisterNetEvent("checkplackputti")
AddEventHandler("checkplackputti", function()
    ESX.TriggerServerCallback('rw:getGroup', function(group)
        if group == "Projektleiter" or group == "Teamvertrauter" or group == "Manager" or group == "Superadmin" or group == "Admin" or group == "Moderator" or group == "Supporter" or group == "Guide" then
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
            SendNUIMessage({
                action = "showIpad"
            })
            hudopen = true
            DoPhoneAnimation2("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a")
            SetNuiFocus(true,true)
             end
    end)
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 344) then
            TriggerEvent("checkplackputti")
          --  ESX.TriggerServerCallback('rw:getGroup', function(group)
              --  if group == "Projektleiter" or group == "Teamvertrauter" or group == "Manager" or group == "Superadmin" or group == "Admin" or group == "Moderator" or group == "Supporter" or group == "Guide" then
    
          --  ESX.TriggerServerCallback('rw:getGroup', function(group)
        end
    end
end)
RegisterNUICallback("close", function(data,cb)
    SetNuiFocus(false,false)
    hudopen = false
    ClearPedTasks(PlayerPedId())
    PhoneData.AnimationData.lib = nil
    PhoneData.AnimationData.anim = nil
    CancelPhoneAnim()
end)