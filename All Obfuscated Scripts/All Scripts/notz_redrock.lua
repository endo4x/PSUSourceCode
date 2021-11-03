--[[
	id: yLNkWyGOK8_ZXPZnwa_gJ
	name: notz_redrock
	description: TEST
	time1: 2021-07-20 06:29:33.582488+00
	time2: 2021-07-20 06:29:33.582489+00
	uploader: XQ6R5KnUV_DoyqONRMC-bnApisJYoiozyNl1vTvB
	uploadersession: rw6dzXYFosSRwf4nAJBUaC1DBvCEPD
	flag: f
--]]

ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

RegisterServerEvent("notz_redrock:pickedUp")
AddEventHandler(
    "notz_redrock:pickedUp",
    function()
        local xPlayer = ESX.GetPlayerFromId(source)
        local xItem = xPlayer.getInventoryItem(Config.ItemName)
        local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])
        --
        if xItem.limit ~= -1 and xItem.count >= xItem.limit then
            TriggerClientEvent(
                "pNotify:SendNotification",
                source,
                {
                    text = '<span class="red-text">' .. Config.ItemFull .. "</span> ",
                    type = "success",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "global"
                }
            )
        else
            if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
                xPlayer.setInventoryItem(xItem.name, xItem.limit)
            else
                xPlayer.addInventoryItem(xItem.name, xItemCount)
            end
            if Config.ItemBonus ~= nil then
                for k, v in pairs(Config.ItemBonus) do
                    if math.random(1, 100) <= v.Percent then
                        xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
                    end
                end
            end
        end
    end
)
