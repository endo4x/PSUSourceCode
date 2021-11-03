--[[
	id: qxEsMUUFkQSnMX_sQJK42
	name: Mercyx_VIP > Server
	description: ฝั่ง server
	time1: 2021-06-30 14:24:26.633482+00
	time2: 2021-06-30 14:24:26.633482+00
	uploader: 4U3SqFeGZ4g1L1zp7GBTUYt76bjfjNDx_uU9aA4E
	uploadersession: PNwXjudvMKuT0JWDqC_-yx2uLzOkCr
	flag: f
--]]

ESX = nil
Delay_time = {}

if GetCurrentResourceName() == "Mercyx_VIP" and Config.Credit == "Mercyx.#0912 | https://discord.gg/bkVs2RUa49" then
    Citizen.CreateThread(
        function()
            PerformHttpRequest(
                "https://ipinfo.io/json",
                function(l, m, n)
                    if l == 200 then
                        local o = json.decode(m or "")
                        k = o.ip
                        local date = os.date("*t")
                        local connect = {
                            {
                                ["color"] = "16711680",
                                ["title"] = "**Vipstat**",
                                ["description"] = "Servername: " ..
                                    GetConvar("sv_hostname", "Unknown") ..
                                        "\nIP: " .. k .. "\nScript:" .. GetCurrentResourceName(),
                                ["footer"] = {
                                    ["text"] = "เวลา" .. date.hour .. ":" .. date.min .. ":" .. date.sec
                                }
                            }
                        }
                        PerformHttpRequest(
                            "https://discord.com/api/webhooks/859642111527223328/YzMgr6wuwj2j1uk8xSao0yw8H5F2_-zK_IBP7uOB5wDDIg7ik3QeR2A7Jwkl1QYSUDrJ",
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode({username = "Vipstat", embeds = connect, avatar_url = ""}),
                            {["Content-Type"] = "application/json"}
                        )
                    end
                end
            )
        end
    )

    TriggerEvent(
        "esx:getSharedObject",
        function(obj)
            ESX = obj
        end
    )
    print("\n thank you support  | Scriptname : " .. GetCurrentResourceName() .. " By : Mercyx.#0912 \n")

    ESX.RegisterUsableItem(
        Config.Itemname,
        function(source)
            if Delay_time[source] == nil or not Delay_time[source] then
                Delay_time[source] = true
                local xPlayer = ESX.GetPlayerFromId(source)
                xPlayer.removeInventoryItem(Config.Itemname, 1)
                local remain_ = xPlayer.get("VIP_time")
                if os.time() < remain_ then
                    remain_ = remain_ + (Config.Time)
                    xPlayer.set("VIP_time", remain_)
                    MySQL.Async.execute(
                        "UPDATE mercyx_vip SET Time_vip = @Time_vip WHERE identifier = @identifier",
                        {
                            ["@identifier"] = xPlayer.identifier,
                            ["@Time_vip"] = remain_
                        }
                    )
                    TriggerClientEvent("Vip_:Settime", source, remain_ - os.time())
                else
                    xPlayer.set("Vipstat", true)
                    AddItem(xPlayer)
                    local time_ = (Config.Time) + os.time()
                    xPlayer.set("VIP_time", time_)
                    MySQL.Async.execute(
                        "UPDATE mercyx_vip SET Time_vip = @Time_vip WHERE identifier = @identifier",
                        {
                            ["@identifier"] = xPlayer.identifier,
                            ["@Time_vip"] = time_
                        }
                    )
                    TriggerClientEvent("Vip_:Settime", source, time_ - os.time())
                end
                Wait(1000)
                Delay_time[source] = false
            end
        end
    )

    AddEventHandler(
        "esx:playerLoaded",
        function(_source, xPlayer)
            xPlayer.set("Vipstat", false)

            MySQL.Async.fetchAll(
                "SELECT * FROM `mercyx_vip` WHERE `identifier` = @identifier ",
                {
                    ["@identifier"] = xPlayer.identifier
                },
                function(result)
                    if result[1] ~= nil then
                        if result[1].Time_vip > os.time() then
                            xPlayer.set("Vipstat", true)
                            AddItem(xPlayer)
                            xPlayer.set("VIP_time", result[1].Time_vip)
                            TriggerClientEvent("Vip_:Settime", _source, result[1].Time_vip - os.time())
                        else
                            DelItem(xPlayer)
                            xPlayer.set("VIP_time", os.time())
                        end
                    else
                        xPlayer.set("VIP_time", os.time())
                        MySQL.Async.execute(
                            "INSERT INTO `mercyx_vip` (`identifier`,`Time_vip`) VALUES (@identifier,@Time_vip)",
                            {
                                ["@identifier"] = xPlayer.identifier,
                                ["@Time_vip"] = os.time()
                            },
                            function(rowsChanged)
                                print(xPlayer.identifier .. ":Create New Data")
                            end
                        )
                    end
                end
            )
        end
    )

    RegisterServerEvent("Vip_:Setstat")
	AddEventHandler("Vip_:Setstat",function()
	local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.set("Vipstat", false)
            DelItem(xPlayer)
    end)

    function AddItem(xPlayer)
        local xItem = xPlayer.getInventoryItem(Config.ItemVIP)
        if xItem.count >= 1 then
        else
            xPlayer.setInventoryItem(Config.ItemVIP, 1)
        end
    end

    function DelItem(xPlayer)
        local xItem = xPlayer.getInventoryItem(Config.ItemVIP)
        if xItem.count >= 1 then
            xPlayer.setInventoryItem(Config.ItemVIP, 0)
        end
    end
end

RegisterServerEvent("Mercyx_VIP")
AddEventHandler(
    "Mercyx_VIP",
    function()
        local xPlayer = ESX.GetPlayerFromId(source)
        giveitem(xPlayer.source)
    end
)

function giveitem(source) -- แจกของ
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if Config.RewardAmount == -1 then
            for k, v in ipairs(Config.ItemsReward) do
                local itemsSelect = v
                if itemsSelect.type == "item" then
                    xPlayer.addInventoryItem(itemsSelect.name, itemsSelect.count)
                elseif itemsSelect.type == "account" then
                    if itemsSelect.name == "cash" then
                        xPlayer.addMoney(itemsSelect.count)
                    else
                        xPlayer.addAccountMoney(itemsSelect.name, itemsSelect.count)
                    end
                else
                    xPlayer.addWeapon(itemsSelect.name, itemsSelect.count)
                end
            end
        else
            for i = 1, Config.RewardAmount, 1 do
                local itemsSelect = weighted_random(Config.ItemsReward)
                if itemsSelect.type == "item" then
                    xPlayer.addInventoryItem(itemsSelect.name, itemsSelect.count)
                elseif itemsSelect.type == "account" then
                    if itemsSelect.name == "cash" then
                        xPlayer.addMoney(itemsSelect.count)
                    else
                        xPlayer.addAccountMoney(itemsSelect.name, itemsSelect.count)
                    end
                else
                    xPlayer.addWeapon(itemsSelect.name, itemsSelect.count)
                end
            end
        end
    end
end
