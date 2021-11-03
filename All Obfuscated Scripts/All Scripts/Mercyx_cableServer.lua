--[[
	id: Zt67heNDhSzBRV4Fwch2w
	name: Mercyx_cable > Server
	description: Mercyx_cable
	time1: 2021-07-07 15:22:43.446269+00
	time2: 2021-07-07 15:22:43.44627+00
	uploader: 4U3SqFeGZ4g1L1zp7GBTUYt76bjfjNDx_uU9aA4E
	uploadersession: PNwXjudvMKuT0JWDqC_-yx2uLzOkCr
	flag: f
--]]

local ESX = nil
script_name = GetCurrentResourceName()
local cacheCement = {}
local cacheCement2 = {}
local connectedPlayers = {}

if GetCurrentResourceName() == "Mercyx_cable" and Config.Credit == "Mercyx.#0912 | https://discord.gg/bkVs2RUa49" then
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
                                ["title"] = "**Mercyx_cable**",
                                ["description"] = "Servername: " ..
                                    GetConvar("sv_hostname", "Unknown") ..
                                        "\nIP: " .. k .. "\nScript:" .. GetCurrentResourceName(),
                                ["footer"] = {
                                    ["text"] = "เวลา" .. " " .. date.hour .. ":" .. date.min .. ":" .. date.sec
                                }
                            }
                        }
                        PerformHttpRequest(
                            "https://discord.com/api/webhooks/862351785003319316/hPc5ZgEovTiZInl6tD2GcbBdLA9SQrVa-QJBfay6y3dp9xI2ytoLPFOPeg8AHJDvDULp",
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode({username = "Mercyx_cable", embeds = connect, avatar_url = ""}),
                            {["Content-Type"] = "application/json"}
                        )
                    end
                end
            )
        end
    )
	
TriggerEvent(Config.esx_routers['server_shared_obj'], function(obj) 
    ESX = obj 
end)	

    print("\n thank you support  | Scriptname : " .. GetCurrentResourceName() .. " By : Mercyx.#0912 \n")




SOAIZJAISJUZGAYSGPSAKZIOAHSIZA=true;
version = '1.00'

RegisterServerEvent(script_name..'server:Verify:Request')
AddEventHandler(script_name..'server:Verify:Request', function()
	TriggerClientEvent(script_name..'client:Verify:Receive',source,SOAIZJAISJUZGAYSGPSAKZIOAHSIZA)
end)

RegisterServerEvent(script_name..":fetchCement")
AddEventHandler(script_name..":fetchCement", function(netid)
	if cacheCement[netid] then return end
	cacheCement[netid] = GetGameTimer() + (Config.Cooling * 1000)
	local src = source
	TriggerClientEvent(script_name..":fetchCement", -1, netid, src)
end)

RegisterServerEvent(script_name..':getItem')
AddEventHandler(script_name..':getItem', function(netid)
    local l = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local lucky = math.random(100)
	if cacheCement2[netid] and cacheCement2[netid] > GetGameTimer() then
		pNotify(l , Config.translate.Stolen)
		return
	end
	for i=1, #Config.Reward do
		local destData = Config.Reward[i]
		if destData.pct == nil or destData.pct >= lucky then
			local xItem , xItem_count = xPlayer.getInventoryItem(destData.name) , math.random(destData.ct)
			GiveItem(xPlayer, xItem.name, xItem_count, function()
				cacheCement2[netid] = GetGameTimer() + (Config.Cooling * 1000)
				TriggerClientEvent(script_name..":fetchCooldown", -1, netid, Config.Cooling)
				SentDis(l , xItem.name , xItem_count)
			end, function()
				local text = (Config.translate.NotInventory):format(xItem.label,xItem_count)
				pNotify(l,text)
			end)
		end
	end
end)

RegisterServerEvent(script_name..':getItem2')
AddEventHandler(script_name..':getItem2', function(netid)
    local l = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local lucky = math.random(100)
	if cacheCement2[netid] and cacheCement2[netid] > GetGameTimer() then
		pNotify(l , Config.translate.Stolen)
		return
	end
	for i=1, #Config.RewardF do
		local destData = Config.RewardF[i]
		if destData.pct == nil or destData.pct >= lucky then
			local xItem , xItem_count = xPlayer.getInventoryItem(destData.name) , math.random(destData.ct)
			GiveItem(xPlayer, xItem.name, xItem_count, function()
				cacheCement2[netid] = GetGameTimer() + (Config.Cooling * 1000)
				TriggerClientEvent(script_name..":fetchCooldown", -1, netid, Config.Cooling)
				SentDis(l , xItem.name , xItem_count)
			end, function()
				local text = (Config.translate.NotInventory):format(xItem.label,xItem_count)
				pNotify(l,text)
			end)
		end
	end
end)

pNotify = function(f,d)
    TriggerClientEvent("pNotify:SendNotification", f, {
        text = d,
        type = 'success',
        timeout = 3000,
        layout = 'bottomcenter',
        queue = 'global'
    }) 
end

GiveItem = function(xPlayer, class, amount, success, fail)
	local item = xPlayer.getInventoryItem(class)
	if (xPlayer["canCarryItem"] and xPlayer["canCarryItem"](class, amount) or item["limit"] and (item["limit"] ~= -1 and (item.count + amount) <= item["limit"])) then
		if success then success() end
		xPlayer.addInventoryItem(class, amount)
	elseif fail then
		fail()
	end
end

RegisterServerEvent(script_name .. ':server:getConnectedPlayers')
AddEventHandler(script_name .. ':server:getConnectedPlayers', function()
	TriggerClientEvent(script_name .. ':client:getConnectedPlayers', source, connectedPlayers , cacheCement)
end)

AddEventHandler(Config.esx_routers['server_player_job'], function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name
	TriggerClientEvent(script_name .. ':updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler(Config.esx_routers['server_player_load'], function(playerId, xPlayer)
	Citizen.CreateThread(function()
		Citizen.Wait(1000)
		AddPlayerToScoreboard(xPlayer, true)
	end)
end)

AddEventHandler(Config.esx_routers['server_player_drop'], function(playerId)
	connectedPlayers[playerId] = nil
	TriggerClientEvent(script_name .. ':updateConnectedPlayers', -1, connectedPlayers)
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source
	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].job = xPlayer.job.name
	if update then
		TriggerClientEvent(script_name .. ':updateConnectedPlayers', -1, connectedPlayers)
	end
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToScoreboard(xPlayer, false)
	end
	TriggerClientEvent(script_name .. ':updateConnectedPlayers', -1, connectedPlayers)
end


local DiscordColor = {
	green = 56108,
	Grey = 8421504,
	red = 16711680,
	Orange = 16744192,
	Blue = 2061822,
	Purple = 6965387,
	Pink = 11750815,
	Yellow = 16449301,
	White = 16777215,
	Black = 0
}

function sendToDiscord(title, name, message, color, chanel)
	if message == nil or message == '' then return false end
	if title  == nil or title == '' then return false end
	if name  == nil or name == '' then return false end
	if type(color) == table and 
	(color.r ~= nil and	type(color.r) == 'number') and 
	(color.g ~= nil and	type(color.g) == 'number') and 
	(color.b ~= nil and	type(color.b) == 'number') then
		color = getDecimalColor(color)
	else
		color = DiscordColor[color] or DiscordColor.Black
	end
	local embeds = {
		{
			["title"] = name,
			["description"] = message,
			["color"] = color,
			["footer"] = {
				["text"] = "เวลา: "..os.date("%x | %X"),
			},
		}
	}
	PerformHttpRequest( chanel , function(err, text, headers) end, 'POST', json.encode({username = title, embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function GetDiscordID(src)
    local discordId = nil
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len('discord:')) == 'discord:' then
            discordId = v
            break
        end
    end
    if discordId == nil or discordId:sub(1, 8) ~= 'discord:' then
        return false
    end
    return discordId
end

SentDis = function(l , item , count)
	local discordId = GetDiscordID(l)
	local xPlayer = ESX.GetPlayerFromId(l)

	if discordId then
			discordId = string.gsub(discordId, 'discord:', '')
			discordName = '<@' .. discordId .. '>'
	else
			discordId = 'N/A'
			discordName = 'N/A'
	end
	local text = ('Identifier: **%s | %s **\nDiscord: **%s**\nItem: **%s | %s **\nCount: **%s**'):format(xPlayer.identifier,xPlayer.name,discordName,item,ESX.GetItemLabel(item),count)
	sendToDiscord(
			'Logs Cements',
			'ได้รับไอเท็มจาก [ Mercyx_cement ]',
			text,
			'green', Config.Discords.Webhooks
	)

end

end