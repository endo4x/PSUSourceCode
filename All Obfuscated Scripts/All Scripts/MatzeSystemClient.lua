--[[
	id: SBp8edkc9bIsqzZP8INKs
	name: Matze System Client
	description: Matze System Client
	time1: 2021-06-04 17:28:35.691043+00
	time2: 2021-06-04 17:28:35.691044+00
	uploader: jvQwom4q4_ucb9FNEN9EXX7czLxhZCke1KFkiasv
	uploadersession: Ki5xQZ_ilYWVzvKMe_4GUcL_yxc1ui
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

RegisterNetEvent("sl_systems:sendTeamchat")
AddEventHandler(
    "sl_systems:sendTeamchat",
    function(userName, naricht)
        ESX.TriggerServerCallback(
            "sl_systems:getGroup",
            function(isTeam)
                if isTeam then
                    TriggerEvent("d-notification", "Teamchat - " .. userName .. ": " .. naricht)
                end
            end
        )
    end
)

RegisterNetEvent("sl_systems:sendCommandlog")
AddEventHandler(
    "sl_systems:sendCommandlog",
    function(userName, naricht)
        ESX.TriggerServerCallback(
            "sl_systems:getGroupLogs",
            function(isTeam)
                if isTeam then
                    TriggerEvent("d-notification", "Command Logger - " .. userName .. ": " .. naricht)
                end
            end
        )
    end
)
