--[[
	id: eHFEzggvDWnRH2e6nYXY0
	name: ecbot
	description: ecbot
	time1: 2021-04-28 06:03:21.96167+00
	time2: 2021-04-28 06:03:21.961671+00
	uploader: ak0lGyLZ6GFw-6RsuD4MS7dWYDsbhNfcBEH9xwNG
	uploadersession: Cx7wE-WQ390wuIPtgBTToCCd7m_qDA
	flag: f
--]]

ESX = nil
local ItemsLabels = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()

	MySQL.Async.fetchAll(
		'SELECT * FROM items',
		{},
		function(result)

			for i=1, #result, 1 do
				ItemsLabels[result[i].name] = result[i].label
			end--

		end
	)

end)

local identifiers = {discord = "", steam = "", license = "", ip = "", live = "", xbl = ""}

local communtiylogo = "https://i.imgur.com/g4MXK06.png" --Must end with .png
AddEventHandler('playerConnecting', function()
    local num = GetNumPlayerIdentifiers(source)
for i = 0, num-1 do
    local a = GetPlayerIdentifier(source, i)
    local f = string.find(a, ":")
    if f then
        local b = string.sub(a, 1, f-1)
        identifiers[b] = a
    end
end
local israel = GetPlayerName(source)
local adamtest = GetPlayerLastMsg(source)
local guid = GetPlayerGuid(source)
local discord = identifiers.discord
if string.match(discord, "discord:") then
	discord = '<@'..string.sub(discord, 9)..'>'
end
local ip = identifiers.ip
if string.match(ip, "ip:") then
	ip = string.sub(ip, 4)
end

local connect = {
        {
            ["color"] = "12745742",
            ["title"] = "玩家連接",
            ["description"] = "[玩家名稱] **"..israel.."**\n[IP]: ["..ip.."](https://www.ip-tracker.org/locator/ip-lookup.php?ip="..ip..")\n [discord id]: "..discord.."\n [Rockstar Licensa]: **"..identifiers.license.."**\n[Steam id]: ["..identifiers.steam.."](https://steamcommunity.com/profiles/"..tonumber(GetIDFromSource('steam', source), 16)..")\n[Live id]: **"..identifiers.live.."**\n[xbl id]: **"..identifiers.xbl.."**",
            ["footer"] = {
                ["text"] = "登入紀錄",
                ["icon_url"] = communtiylogo,
            },
        }
    }

PerformHttpRequest(DiscordLoginWebHook, function(err, text, headers) end, 'POST', json.encode({username = "登入紀錄", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('DiscordBot:test')
AddEventHandler('DiscordBot:test', function(WebHook, Name,title, Message, color,image)
	if Message == nil or Message == '' then
		return nil
	end
	local connect = {
        {
            ["author"] = {
                ["name"] = "Apple#8888",
				["url"] = "https://discord.gg/8ZT2WUa",
				["icon_url"] = "https://i.imgur.com/QhH2MyN.png",
            },
			["color"] = color,
			["title"] = title,
            ["description"] = Message..getdiscord2(source),
			["image"] = {["url"] = image},
            ["footer"] = {
                ["text"] = "",
            },
        }
    }
	if allow then
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name,embeds = connect}), {['Content-Type'] = 'application/json'})
	end
end)

RegisterServerEvent('DiscordBot:ToDiscord2')
AddEventHandler('DiscordBot:ToDiscord2', function(WebHook, Name, Message, Image, External, Source, TTS)
	if Message == nil or Message == '' then
		return nil
	end
	if TTS == nil or TTS == '' then
		TTS = false
	end
	if External then
		if WebHook:lower() == 'chat' then
			WebHook = DiscordWebhookChat
		elseif WebHook:lower() == 'system' then
			WebHook = DiscordWebhookSystemInfos
		elseif WebHook:lower() == 'kill' then
			WebHook = DiscordWebhookKillinglogs
		elseif not Webhook:find('discordapp.com/api/webhooks') then
			print('ToDiscord event called without a specified webhook!')
			return nil
		end
		
		if Image:lower() == 'steam' then
			Image = UserAvatar
			if GetIDFromSource('steam', Source) then
				PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
					local SteamProfileSplitted = stringsplit(Content, '\n')
					for i, Line in ipairs(SteamProfileSplitted) do
						if Line:find('<avatarFull>') then
							Image = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
							return PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
						end
					end
				end)
			end
		elseif Image:lower() == 'user' then
			Image = UserAvatar
		else
			Image = SystemAvatar
		end
	end
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)

RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, color)
	if Message == nil or Message == '' then
		return nil
	end
	local connect = {
        {
            ["color"] = color,
            ["description"] = Message,
            ["footer"] = {
                ["text"] = "",
            },
        }
    }
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, embeds = connect}), {['Content-Type'] = 'application/json'})
end)

-- function getsteam (source)
    -- local _source = source
	-- local identifiers = {discord = "", steam = "", license = "", ip = "", live = "", xbl = ""}
	-- local num = GetNumPlayerIdentifiers(_source)
-- for i = 0, num-1 do
    -- local a = GetPlayerIdentifier(_source, i)
    -- local f = string.find(a, ":")
    -- if f then
        -- local b = string.sub(a, 1, f-1)
        -- identifiers[b] = a
    -- end
-- end
	-- return identifiers.steam
-- end

function getdiscord (source)
    local _source = source
	local identifiers = {discord = "", steam = "", license = "", ip = "", live = "", xbl = ""}
	local num = GetNumPlayerIdentifiers(_source)
	local guid = GetPlayerGuid(_source)
for i = 0, num-1 do
    local a = GetPlayerIdentifier(_source, i)
    local f = string.find(a, ":")
    if f then
        local b = string.sub(a, 1, f-1)
        identifiers[b] = a
    end
end
local discord = identifiers.discord
if string.match(discord, "discord:") then
	discord = '<@'..string.sub(discord, 9)..'>'
end
	return '\nDiscord:'..discord..'\nsteam:['..identifiers.steam..'](https://steamcommunity.com/profiles/'..guid..')'
end

RegisterServerEvent('aimlogs:log')
AddEventHandler('aimlogs:log', function(pedId)
    local _source = source
    local name = GetPlayerName(_source)
    local targetName = GetPlayerName(pedId)
    PerformHttpRequest(hook, function(err, text, headers) end, 'POST', json.encode({embeds={{title="__**Aim Logs**__",description="\nPlayer name: "..name.. "`[".._source.."]`\nIs aiming: "..targetName.." `["..pedId.."]`",color=16711680}}}), { ['Content-Type'] = 'application/json' })
end)


-- AddEventHandler('chatMessage', function(source, name, message)
	-- local _source = source
	
	-- PerformHttpRequest( DiscordChatWebHook, function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
-- end)
-- Chat
AddEventHandler('chatMessage', function(Source, Name, Message)
	local Webhook = DiscordChatWebHook; TTS = false

	--Removing Color Codes (^0, ^1, ^2 etc.) from the name and the message
	for i = 0, 9 do
		Message = Message:gsub('%^' .. i, '')
		Name = Name:gsub('%^' .. i, '')
	end
	
	--Splitting the message in multiple strings
	MessageSplitted = stringsplit(Message, ' ')
	
	--Checking if the message contains a blacklisted command
	-- if not IsCommand(MessageSplitted, 'Blacklisted') then
		--Checking if the message contains a command which has his own webhook
		-- if IsCommand(MessageSplitted, 'HavingOwnWebhook') then
			-- Webhook = GetOwnWebhook(MessageSplitted)
		-- end
		
		--Checking if the message contains a special command
		-- if IsCommand(MessageSplitted, 'Special') then
			-- MessageSplitted = ReplaceSpecialCommand(MessageSplitted)
		-- end
		
		---Checking if the message contains a command which belongs into a tts channel
		-- if IsCommand(MessageSplitted, 'TTS') then
			-- TTS = true
		-- end
		
		--Combining the message to one string again
		Message = ''
		
		for Key, Value in ipairs(MessageSplitted) do
			Message = Message .. Value .. ' '
		end
		
		--Adding the username if needed
		Message = Message:gsub('USERNAME_NEEDED_HERE', GetPlayerName(Source))
		
		--Adding the userid if needed
		Message = Message:gsub('USERID_NEEDED_HERE', Source)
		
		-- Shortens the Name, if needed
		if Name:len() > 23 then
			Name = Name:sub(1, 23)
		end

		--Getting the steam avatar if available
		local AvatarURL = UserAvatar
		if GetIDFromSource('steam', Source) then
			PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
				local SteamProfileSplitted = stringsplit(Content, '\n')
				for i, Line in ipairs(SteamProfileSplitted) do
					if Line:find('<avatarFull>') then
						AvatarURL = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
						TriggerEvent('DiscordBot:ToDiscord2', Webhook, Name .. ' [ID: ' .. Source .. ']', Message, AvatarURL, false, Source, TTS) --Sending the message to discord
						break
					end
				end
			end)
		else
			--Using the default avatar if no steam avatar is available
			TriggerEvent('DiscordBot:ToDiscord2', Webhook, Name .. ' [ID: ' .. Source .. ']', Message, AvatarURL, false, Source, TTS) --Sending the message to discord
		end
	-- end
end)

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for i, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for i, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for i, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	end
	return false
end

RegisterServerEvent('DiscordBot:playerDied')
AddEventHandler('DiscordBot:playerDied', function(message, Weapon,target)
	local _source = source
	if Weapon then
		message = message .. ' [' .. Weapon .. ']'
	end
	if target ~= nil then
	local _target = target
	TriggerEvent('DiscordBot:ToDiscord', DiscordKillWebhook, '殺人紀錄', '死者名稱:'..GetPlayerName(_source)..getdiscord(_source)..'\n擊殺者:'..GetPlayerName(_target)..getdiscord(_target)..'```'..message .."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	else
	TriggerEvent('DiscordBot:ToDiscord', DiscordKillWebhook, '殺人紀錄', '死者名稱:'..GetPlayerName(_source)..getdiscord(_source)..'```'..message .."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	end
end)

RegisterServerEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source
	local _target = target
	if type == 'item_standard' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordItemWebhook, '給予物品', '給予者:'..GetPlayerName(_source)..getdiscord(_source)..'\n接收者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```'..itemCount..' 個 '..ItemsLabels[itemName].."```\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
	elseif type == 'item_money' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordItemWebhook, '給予金錢', '給予者:'..GetPlayerName(_source)..getdiscord(_source)..'\n接收者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```現金 $'..itemCount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
	elseif type == 'item_weapon' then
	local weaponLabel = ESX.GetWeaponLabel(itemName)
		TriggerEvent('DiscordBot:ToDiscord', DiscordItemWebhook, '給予武器', '給予者:'..GetPlayerName(_source)..getdiscord(_source)..'\n接收者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```'..weaponLabel..'子彈 '..itemCount.." 枚```\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
	end
end)

RegisterServerEvent('esx_vehicleshop:setVehicleOwned')
AddEventHandler('esx_vehicleshop:setVehicleOwned', function (vehicleProps,vehicleData)
	local _source = source
	TriggerEvent('DiscordBot:ToDiscord', DiscordVehicleShop, '購買車輛', '購買者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車輛:'..vehicleData.model..'\n車牌:'..vehicleProps.plate..'\n價錢:'..vehicleData.price.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
end)

RegisterServerEvent('esx_shop:buyItem')
AddEventHandler('esx_shop:buyItem', function(itemName, price)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	if xPlayer.get('money') >= price then
	if sourceItem.limit == -1 or sourceItem.count < sourceItem.limit then

	TriggerEvent('DiscordBot:ToDiscord', DiscordBuyItem, '購買物品', '購買者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```1個'..ItemsLabels[itemName].."```\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
	end
	end
end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local _source = source
	local _target = playerId
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
	if xPlayer.job.name == 'police' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBill, '警察罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'mechanic' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordMechanicBill, '車業罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'casino' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordcasinoBill, '賭場罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'mafia' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordmafiaBill, 'mafia罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'vagos' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordvagosBill, 'vagos罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'ambulance' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordambulanceBill, '貓醫院罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	TriggerEvent('DiscordBot:ToDiscord', DiscordAllBill, '貓醫院罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
end)

RegisterServerEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, itemCount)
	local _source = source
	local _target = target
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'police' then
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
			else
				TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBody, '警察搜身', '警員:'..GetPlayerName(_source)..getdiscord(_source)..'\n市民:'..GetPlayerName(_target)..getdiscord(_target)..'\n```'..itemCount..' 個 '..ESX.Items[itemName].."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
			end
		end

	elseif itemType == 'item_account' then
		TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBody, '警察搜身', '警員:'..GetPlayerName(_source)..getdiscord(_source)..'\n市民:'..GetPlayerName(_target)..getdiscord(_target)..'\n```黑錢 $'..itemCount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		local weaponLabel = ESX.GetWeaponLabel(itemName)
		TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBody, '警察搜身', '警員:'..GetPlayerName(_source)..getdiscord(_source)..'\n市民:'..GetPlayerName(_target)..getdiscord(_target)..'\n```'..weaponLabel..'子彈'..itemCount.."枚```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	end
end)

RegisterServerEvent('esx_mechanicjob:putStockItems')
AddEventHandler('esx_mechanicjob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', DiscordgarageBill, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_mechanicjob:getStockItem')
AddEventHandler('esx_mechanicjob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', DiscordgarageBill, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_mafiajob:putStockItems')
AddEventHandler('esx_mafiajob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordmafiagarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_mafiajob:getStockItem')
AddEventHandler('esx_mafiajob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordmafiagarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_vagosjob:putStockItems')
AddEventHandler('esx_vagosjob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordvagosgarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_vagosjob:getStockItem')
AddEventHandler('esx_vagosjob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vagos', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordvagosgarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_casinojob:putStockItems')
AddEventHandler('esx_casinojob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordcasinogarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_casinojob:getStockItem')
AddEventHandler('esx_casinojob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordcasinogarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_ambulancejob:putFridgeStockItems')
AddEventHandler('esx_ambulancejob:putFridgeStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino_fridge', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordcasinogarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_ambulancejob:getFridgeStockItem')
AddEventHandler('esx_ambulancejob:getFridgeStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino_fridge', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordcasinogarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_ambulancejob:putStockItems')
AddEventHandler('esx_ambulancejob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordambulancegarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordambulancegarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_clothes:sellVehicle')
AddEventHandler('esx_clothes:sellVehicle', function(target, plate)
	local _source = source
	local _target = target
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
			['@identifier'] = xPlayer.identifier,
			['@plate'] = plate
		})
	if result[1] ~= nil then
	TriggerEvent('DiscordBot:ToDiscord', Discordcontract, '過戶車輛', '過戶人:'..GetPlayerName(_source)..getdiscord(_source)..'\n新車主:'..GetPlayerName(_target)..getdiscord(_target)..'\n```車牌:'..plate.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
end)

AddEventHandler('playerConnecting', function()
	TriggerEvent('DiscordBot:ToDiscord2', DiscordWebhookSystemInfos, '登入登出', '```css\n' .. GetPlayerName(source) .. ' 進入伺服器\n```', SystemAvatar, false)
end)

AddEventHandler('playerDropped', function(Reason)
	local _source = source
	TriggerEvent('DiscordBot:ToDiscord2', DiscordWebhookSystemInfos, '登入登出', '```fix\n' .. GetPlayerName(_source) .. ' 離開伺服器 (' .. Reason .. ')\n```', SystemAvatar, false)
end)

RegisterServerEvent('ecbot:getItem')
AddEventHandler('ecbot:getItem', function(source, type,plate, item, count)
	local _source = source
	if type == "item_standard" then
	TriggerEvent('DiscordBot:ToDiscord', Discordtrunk, '提取物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..count..'個'..ESX.GetItemLabel(item).."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif type == "item_account" then
	TriggerEvent('DiscordBot:ToDiscord', Discordtrunk, '提取物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n黑錢 $'..count.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	elseif type == "item_weapon" then
	TriggerEvent('DiscordBot:ToDiscord', Discordtrunk, '提取物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..ESX.GetWeaponLabel(item)..'子彈 '..count.." 枚```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	end
end)

RegisterServerEvent('ecbot:putItem')
AddEventHandler('ecbot:putItem', function(source, type,plate, item, count)
	local _source = source
	if type == "item_standard" then
	TriggerEvent('DiscordBot:ToDiscord', Discordtrunk, '存入物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..count..'個'..ESX.GetItemLabel(item).."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif type == "item_account" then
	TriggerEvent('DiscordBot:ToDiscord', Discordtrunk, '存入物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n黑錢 $'..count.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	elseif type == "item_weapon" then
	TriggerEvent('DiscordBot:ToDiscord', Discordtrunk, '存入物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..ESX.GetWeaponLabel(item)..'子彈 '..count.." 枚```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	end
end)

RegisterServerEvent('ecbot:ggetItem')
AddEventHandler('ecbot:ggetItem', function(source, type,plate, item, count)
	local _source = source
	if type == "item_standard" then
	TriggerEvent('DiscordBot:ToDiscord', Discordglovebox, '提取物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..count..'個'..ESX.GetItemLabel(item).."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif type == "item_account" then
	TriggerEvent('DiscordBot:ToDiscord', Discordglovebox, '提取物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n黑錢 $'..count.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	elseif type == "item_weapon" then
	TriggerEvent('DiscordBot:ToDiscord', Discordglovebox, '提取物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..ESX.GetWeaponLabel(item)..'子彈 '..count.." 枚```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	end
end)

RegisterServerEvent('ecbot:gputItem')
AddEventHandler('ecbot:gputItem', function(source, type,plate, item, count)
	local _source = source
	if type == "item_standard" then
	TriggerEvent('DiscordBot:ToDiscord', Discordglovebox, '存入物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..count..'個'..ESX.GetItemLabel(item).."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif type == "item_account" then
	TriggerEvent('DiscordBot:ToDiscord', Discordglovebox, '存入物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n黑錢 $'..count.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	elseif type == "item_weapon" then
	TriggerEvent('DiscordBot:ToDiscord', Discordglovebox, '存入物品', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'\n```車牌:'..plate..'\n'..ESX.GetWeaponLabel(item)..'子彈 '..count.." 枚```\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	end
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(target, amountt)
    local _source = source
	local _target = target
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(_target)
    local balance = 0
    if zPlayer ~= nil then
        balance = xPlayer.getAccount('bank').money
        if tonumber(_source) == tonumber(_target) then
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
            else
				TriggerEvent('DiscordBot:ToDiscord', DiscordBankWebhook, '銀行轉帳', '給予者:'..GetPlayerName(_source)..getdiscord(_source)..'\n接收者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```銀行 $'..amountt.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
            end
        end
    end

end)

RegisterServerEvent('aimlogs:log')
AddEventHandler('aimlogs:log', function(pedId)
    local _source = source
	TriggerEvent('DiscordBot:ToDiscord', Discordaimlog, '瞄準紀錄', '瞄準者:'..GetPlayerName(_source)..getdiscord(_source)..'\n被瞄準:'..GetPlayerName(pedId)..getdiscord(pedId).."\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
end)