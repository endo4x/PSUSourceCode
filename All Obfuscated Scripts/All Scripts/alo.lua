--[[
	id: WE9c5hap3D6bXp2KtJILz
	name: alo
	description: QBCore = nil\n\nCitizen.CreateThread(function()\n    while true do\n        Citizen.Wait(10)\n        if QBCore == nil then\n            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)\n            Citizen.Wait(200)\n        end\n    end\nend)\n\nlocal isLoggedIn = false\nlocal AlertActive = false\nPlayerData = {}\nPlayerJob = {}\n\n-- Code\n\nCitizen.CreateThread(function()\n    Wait(100)\n    if QBCore.Functions.GetPlayerData() ~= nil then\n        PlayerData = QBCore.Functions.GetPlayerData()\n        PlayerJob = PlayerData.job\n    end\nend)\n\nRegisterNetEvent('QBCore:Client:OnJobUpdate')\nAddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)\n    PlayerJob = JobInfo\n    if JobInfo.name == "police" then\n        if PlayerJob.onduty then\n            PlayerJob.onduty = false\n        end\n    end\n    PlayerJob.onduty = true\nend)\n\nRegisterNetEvent('QBCore:Client:OnPlayerLoaded')\nAddEventHandler('QBCore:Client:OnPlayerLoaded', function()\n    isLoggedIn = true\n    PlayerData =  QBCore.Functions.GetPlayerData()\n    PlayerJob = QBCore.Functions.GetPlayerData().job\nend)\n\nRegisterNetEvent('qb-policealerts:ToggleDuty')\nAddEventHandler('qb-policealerts:ToggleDuty', function(Duty)\n    PlayerJob.onduty = Duty\nend)\n\nRegisterNetEvent('qb-policealerts:client:AddPoliceAlert')\nAddEventHandler('qb-policealerts:client:AddPoliceAlert', function(data, forBoth)\n    if forBoth then\n        if (PlayerJob.name == "police" or PlayerJob.name == "doctor" or PlayerJob.name == "ambulance") and PlayerJob.onduty then\n            if data.alertTitle == "حالة طارئة" or data.alertTitle == "خطف أو قتل" or data.alertTitle == "اصابة طبيعية" or data.alertTitle == "وحدة نقل" or data.alertTitle == "Officer Help" or data.alertTitle == "Officer Down" or data.alertTitle == "Officer Transfer" then\n                TriggerServerEvent("InteractSound_SV:PlayOnSource", "emergency", 0.7)\n            else\n                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)\n            end\n            data.callSign = data.callSign ~= nil and data.callSign or PlayerData.metadata["callsign"]\n            data.alertId = math.random(11111, 99999)\n            SendNUIMessage({\n                action = "add",\n                data = data,\n            })\n        end\n    else\n        if (PlayerJob.name == "police" and PlayerJob.onduty) then\n            if data.alertTitle == "Assistance collegue" or data.alertTitle == "Assistence ambulance" or data.alertTitle == "Assistence Doctor" or data.alertTitle == "mbulance down"  then\n                TriggerServerEvent("InteractSound_SV:PlayOnSource", "emergency", 0.7)\n            else\n                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)\n            end\n            data.callSign = data.callSign ~= nil and data.callSign or PlayerData.metadata["callsign"]\n            data.alertId = math.random(11111, 99999)\n            SendNUIMessage({\n                action = "add",\n                data = data,\n            })\n        end \n    end\n\n    AlertActive = true\n    SetTimeout(data.timeOut, function()\n        AlertActive = false\n    end)\nend)\n\nCitizen.CreateThread(function()\n    while true do\n        if AlertActive then\n            if IsControlJustPressed(0, Keys["LEFTALT"]) then\n                SetNuiFocus(true, true)\n                SetNuiFocusKeepInput(true, false)\n                SetCursorLocation(0.965, 0.12)\n                MouseActive = true\n            end\n        end\n\n        if MouseActive then\n            if IsControlJustReleased(0, Keys["LEFTALT"]) then\n                SetNuiFocus(false, false)\n                SetNuiFocusKeepInput(false, false)\n                MouseActive = false\n            end\n        end\n\n        Citizen.Wait(6)\n    end\nend)\n\nRegisterNUICallback('SetWaypoint', function(data)\n    local coords = data.coords\n\n    SetNewWaypoint(coords.x, coords.y)\n    QBCore.Functions.Notify('تم التحديد على الموقع')\n    SetNuiFocus(false, false)\n    SetNuiFocusKeepInput(false, false)\n    MouseActive = false\nend)\n
	time1: 2021-06-29 19:58:57.498023+00
	time2: 2021-06-29 19:58:57.498024+00
	uploader: 7Vk2U3wbWee9e1aaWoX05IZFUUrGlGg3pzjDlVdi
	uploadersession: ZixYShBkqwItvMdgTu7s_189BjcO16
	flag: f
--]]


QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

-- Code

local PlayerJob


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true

    QBCore.Functions.TriggerCallback('qb-EMSScoreboard:server:GetConfig', function(config)
        Config.IllegalActions = config
    end)
end)

local scoreboardOpen = false

local PlayerOptin = {}

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

GetClosestPlayer = function()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

GetPlayersFromCoords = function(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}

    if coords == nil then
		coords = GetEntityCoords(GetPlayerPed(-1))
    end
    if distance == nil then
        distance = 5.0
    end
    for _, player in pairs(players) do
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)
		if targetdistance <= distance then
			table.insert(closePlayers, player)
		end
    end
    
    return closePlayers
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, Config.OpenKey) then
            if QBCore.Functions.GetPlayerData().job.name == "doctor" or QBCore.Functions.GetPlayerData().job.name == "ambulance"  then
                if not scoreboardOpen then
                QBCore.Functions.TriggerCallback('qb-EMSScoreboard:server:GetPlayersArrays', function(playerList)
                    QBCore.Functions.TriggerCallback('qb-EMSScoreboard:server:GetActivity', function(cops, ambulance)
                        QBCore.Functions.TriggerCallback('qb-EMSScoreboard:server:getcopdata', function(copsdata)
                            PlayerOptin = playerList
                            Config.CurrentCops = cops
                            SendNUIMessage({
                                action = "open",
                                players = GetCurrentPlayers(),
                                maxPlayers = Config.MaxPlayers,
                                requiredCops = Config.IllegalActions,
                                currentCops = Config.CurrentCops,
                                currentAmbulance = ambulance,
                                copdataofficer = copsdata, 
                            })
                            scoreboardOpen = true
                        end)
                    end)
                end)
            end
            end
        end

        if IsControlJustReleased(0, Config.OpenKey) then
            if scoreboardOpen then
                SendNUIMessage({
                    action = "close",
                })
                scoreboardOpen = false
            end
        end

        Citizen.Wait(3)
    end
end)

function GetCurrentPlayers()
    local TotalPlayers = 0

    for _, player in ipairs(GetActivePlayers()) do
        TotalPlayers = TotalPlayers + 1
    end

    return TotalPlayers
end


