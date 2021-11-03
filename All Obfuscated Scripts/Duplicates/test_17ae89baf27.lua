--[[
	id: ja010ZR55NJRCdmm_2ywz
	name: test
	description: test
	time1: 2021-04-23 14:45:21.517759+00
	time2: 2021-04-23 14:45:21.51776+00
	uploader: 7b01wQSKyAWq8W955n6uwdw9BcyQIa6KuAVNTO9q
	uploadersession: MD1bhwJv60oCrleh_1Js2GWWJG5hb5
	flag: f
--]]

ESX = nil
script_name = GetCurrentResourceName()
TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

local script_name2
local CanUseScript = false
local CustomerName = nil
local SM_WEBHOOK = nil
Citizen.CreateThread(
    function()
        local MyIpserver = "Unknown"
        PerformHttpRequest(
            "https://api.myip.com/",
            function(b, c, d)
                if b == 200 then
                    local e = json.decode(c)
                    MyIpserver = e.ip
                end
                PerformHttpRequest(
                    "http://112.121.151.214/SmFivem/sm_scripts/customs.json",
                    function(err, text, header)
                        local data = json.decode(text)
                        version_lasted = data.version
                        SM_WEBHOOK = data.webhook
                        for k, v in pairs(data.Script) do
                            if script_name == v.script_name then
                                CustomerName = v.customer_name
                                if v.status then
                                    CanUseScript = true
                                else
                                    CanUseScript = false
                                end
                            end
                        end
                    end,
                    "GET",
                    json.encode({}),
                    {["Content-Type"] = "application/json"}
                )

                Citizen.Wait(500)
                SEND_DISCORD(MyIpserver, CustomerName)
                if CanUseScript then
                    print(("[^2%s^7] ^0Thank You ^3%s!^0 for buy script^7"):format(script_name, CustomerName))
                else
                    print(("[^2%s^7] ^0Thank You ^1%s!^0 for buy script^7"):format(script_name, CustomerName))
                    local a = math.random(99999)
                    script_name = script_name .. "" .. a
                end
            end
        )
    end
)

SEND_DISCORD = function(MyIpserver, CustomerName)
    local connect = {}
    local Logic = tonumber(string.len(GetConvar("sv_hostname", "Unknown")))
    if CustomerName == nil then
        CustomerName = "Fake Customer"
    end
    if Logic < 250 then
        connect = {
            {
                ["color"] = 2205575,
                ["title"] = "Server: " ..
                    GetConvar("sv_hostname", "Unknown") ..
                        "\nScript: " ..
                            script_name ..
                                "\nVersion: " ..
                                    version_current .. "\nIP: " .. MyIpserver .. "\nCustomer: " .. CustomerName .. "",
                ["description"] = "",
                ["footer"] = {
                    ["text"] = "เวลา: " .. os.date("%X") .. " - " .. os.date("%x") .. ""
                }
            }
        }
    else
        connect = {
            {
                ["color"] = 2205575,
                ["title"] = "Script: " .. script_name .. "\nIP: " .. MyIpserver .. "\nCustomer: " .. CustomerName .. "",
                ["description"] = "",
                ["footer"] = {
                    ["text"] = "เวลา: " .. os.date("%X") .. " - " .. os.date("%x") .. ""
                }
            }
        }
    end
    PerformHttpRequest(
        SM_WEBHOOK,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}),
        {["Content-Type"] = "application/json"}
    )
end

RegisterServerEvent(script_name .. ":requestSynced")
AddEventHandler(
    script_name .. ":requestSynced",
    function(target, id)
        local requester = target
        local accepted = source

        TriggerClientEvent(script_name .. ":playSynced", accepted, requester, id, "Accepter")
        TriggerClientEvent(script_name .. ":playSynced", requester, accepted, id, "Requester")
    end
)
