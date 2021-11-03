--[[
	id: rK_KsplnNn-VxBDCrlWRO
	name: 卡比獸s
	description: 卡比獸s
	time1: 2021-05-01 00:56:39.230697+00
	time2: 2021-05-01 00:56:39.230697+00
	uploader: ak0lGyLZ6GFw-6RsuD4MS7dWYDsbhNfcBEH9xwNG
	uploadersession: Cx7wE-WQ390wuIPtgBTToCCd7m_qDA
	flag: f
--]]

local allow = false
PerformHttpRequest( "https://nightcat.cc/ecbot.txt", function( err, text, headers )
	-- Wait to reduce spam 
	Citizen.Wait( 5000 )

	-- Get the current resource version 
	
	if ( text ~= nil ) then 
		print( "  ||    當前: " .. text )
		if ( text == 'free' ) then
			allow = true
		else
			allow = false
			print( "  ||    ^2現在不允許使用!")
		end
	else 
		print( "  ||    無法連接伺服器" )
	end 
	print('^6Discord: ^1Apple#8888')
end)

ESX = nil
local ItemsLabels = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()
	
	print('^6Discord: ^1Apple#8888')
	
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
		elseif WebHook:lower() == 'kill' then
			WebHook = DiscordWebhookKillinglogs
		elseif not Webhook:find('discordapp.com/api/webhooks') then
			print('ToDiscord event called without a specified webhook!')
			return nil
		end
		
		if Image:lower() == 'steam' then
			Image = UserAvatar
			if GetIDFromSource('steam', Source) then
				if allow then
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
			end
		elseif Image:lower() == 'user' then
			Image = UserAvatar
		else
			Image = SystemAvatar
		end
	end
	if allow then
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
	end
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
	if allow then
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, embeds = connect}), {['Content-Type'] = 'application/json'})
	end
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
	return '\nsteam : (['..identifiers.steam..'](https://steamcommunity.com/profiles/'..guid..'))'
end

function getdiscord2 (source)
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

local ip = identifiers.ip
if string.match(ip, "ip:") then
	ip = string.sub(ip, 4)
end
	return '\n**Discord:** '..discord..'\n**SteamID:** ['..identifiers.steam..'](https://steamcommunity.com/profiles/'..guid..')'..'\n**License:** '..identifiers.license..'\n**IP:** ['..ip..'](https://www.ip-tracker.org/locator/ip-lookup.php?ip='..ip..')'
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
AddEventHandler('DiscordBot:playerDied', function(message, Weapon,target,xyz)
	local _source = source
	if Weapon then
		message = message .. ' [' .. Weapon .. ']'
	end
	if target ~= 'no' then
	local _target = target
	TriggerEvent('DiscordBot:ToDiscord', DiscordKillWebhook, '殺人紀錄', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'```'..message ..'```'..'\n位置:'..xyz..""..'\n擊殺者:'..GetPlayerName(_target)..getdiscord(_target).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	else
	TriggerEvent('DiscordBot:ToDiscord', DiscordKillWebhook, '殺人紀錄', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'```'..message ..'```'..'\n位置:'..xyz.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
	end
end)

RegisterServerEvent('esx_shop:buyItem')
AddEventHandler('esx_shop:buyItem', function(itemName, price)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	if xPlayer.get('money') >= price then
	if sourceItem.limit == -1 or sourceItem.count < sourceItem.limit then

	TriggerEvent('DiscordBot:ToDiscord', DiscordBuyItem, '購買物品', '購買者:'..GetPlayerName(_source)..getdiscord(_source)..'\n1個'..ItemsLabels[itemName].."\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
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
	TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBill, '公職開單', '(被開單者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n金額:'..amount..'\n(開單者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'mechanic' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordMechanicBill, '公職開單', '(被開單者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n金額:'..amount..'\n(開單者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'taxi' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordtaxiBill, '公職開單', '(被開單者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n金額:'..amount..'\n(開單者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'mafia' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordmafiaBill, '公職開單', '(被開單者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n金額:'..amount..'\n(開單者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'grove' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordgroveBill, '公職開單', '(被開單者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n金額:'..amount..'\n(開單者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'ambulance' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordambulanceBill, '公職開單', '(被開單者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n金額:'..amount..'\n(開單者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
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
				TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBody, '搜身紀錄', '(被搜者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n物品內容 : '..itemCount..' 個 '..ESX.Items[itemName]..'\n(搜身者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
			end
		end

	elseif itemType == 'item_account' then
		TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBody, '搜身紀錄', '(被搜者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n物品內容 : 黑錢 $'..itemCount..'\n(搜身者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		local weaponLabel = ESX.GetWeaponLabel(itemName)
		TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBody, '搜身紀錄', '(被搜者)steam : ('..GetPlayerName(_target)..')'..getdiscord(_target)..'\n物品內容 : '..weaponLabel..'子彈'..itemCount..'枚\n(搜身者)steam : ('..GetPlayerName(_source)..')'..getdiscord(_source).."\n📅日期:".. os.date("%Y/%m/%d %X"), 16711680)
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
	TriggerEvent('DiscordBot:ToDiscord', DiscordgarageBill, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_mechanicjob:getStockItem')
AddEventHandler('esx_mechanicjob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', DiscordgarageBill, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
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
	TriggerEvent('DiscordBot:ToDiscord', Discordmafiagarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_mafiajob:getStockItem')
AddEventHandler('esx_mafiajob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordmafiagarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_grovejob:putStockItems')
AddEventHandler('esx_grovejob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_grove', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordgrovegarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_grovejob:getStockItem')
AddEventHandler('esx_grovejob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_grove', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordgrovegarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_taxijob:putStockItems')
AddEventHandler('esx_taxijob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordtaxigarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_taxijob:getStockItem')
AddEventHandler('esx_taxijob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordtaxigarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordpolicegarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordpolicegarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
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
	TriggerEvent('DiscordBot:ToDiscord', Discordtaxigarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_ambulancejob:getFridgeStockItem')
AddEventHandler('esx_ambulancejob:getFridgeStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino_fridge', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordtaxigarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
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
	TriggerEvent('DiscordBot:ToDiscord', Discordambulancegarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordambulancegarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n'..count..'個'..item.label.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('bank:tran7777sfer')
AddEventHandler('bank:tran7777sfer', function(target, amount)
    local _source = source
    local sourcexPlayer = ESX.GetPlayerFromId(_source)
    local taragexPlayer = ESX.GetPlayerFromId(tarage)
    local balance = sourcexPlayer.getAccount('bank').money
    if _source == tarage then
	else
            if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
            else
				TriggerEvent('DiscordBot:ToDiscord', DiscordBankWebhook, '銀行轉帳', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n交易金額 : $'..amount..'\n交易選項:轉帳\n剩餘金額 : '..sourcexPlayer.getMoney()..""..'\n(轉帳)steam : '..GetPlayerName(_target)..getdiscord(_target)..'\n交易金額 : $'..amount..'\n交易選項:轉帳\n剩餘金額 : '..taragexPlayer.getMoney()..'\n'.."\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
			end
   end

end)

RegisterServerEvent('bank:dep7777osit')
AddEventHandler('bank:dep7777osit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
	else
		TriggerEvent('DiscordBot:ToDiscord', DiscordBankWebhook3, '銀行存款', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n交易金額 : $'..amount..'\n交易選項:存款\n剩餘金額 : '..xPlayer.getMoney()..'\n'.."\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)	
	end
end)

RegisterServerEvent('bank:withd7777raw')
AddEventHandler('bank:withd7777raw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
	else
		TriggerEvent('DiscordBot:ToDiscord', DiscordBankWebhook2, '銀行提款', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n交易金額 : $'..amount..'\n交易選項:提款\n剩餘金額 : '..xPlayer.getMoney()..'\n'.."\n📅日期:".. os.date("%Y/%m/%d %X"), 56108)
	end
end)

RegisterServerEvent('ecbot:rob')
AddEventHandler('ecbot:rob', function(source, place)
	local _source = source
	if place == "超商" then
	TriggerEvent('DiscordBot:ToDiscord', Discordrob1, '搶劫', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n位置 : '..place.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif place == "銀行" then
	TriggerEvent('DiscordBot:ToDiscord', Discordrob2, '搶劫', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n位置 : '..place.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif place == "珠寶" then
	TriggerEvent('DiscordBot:ToDiscord', Discordrob3, '搶劫', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n位置 : '..place.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif place == "公款" then
	TriggerEvent('DiscordBot:ToDiscord', Discordrob4, '搶劫', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n位置 : '..place.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif place == "走私車" then
	TriggerEvent('DiscordBot:ToDiscord', Discordrob5, '搶劫', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n位置 : '..place.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif place == "走私槍" then
	TriggerEvent('DiscordBot:ToDiscord', Discordrob6, '搶劫', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n位置 : '..place.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif place == "海上搶劫" then
	TriggerEvent('DiscordBot:ToDiscord', Discordrob7, '搶劫', 'steam : '..GetPlayerName(_source)..getdiscord(_source)..'\n位置 : '..place.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
end)

RegisterServerEvent('ecbot:payBill')
AddEventHandler('ecbot:payBill', function(source,amount,name,identifier,job)
	if job == 'police' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordPoliceBill2, '繳單紀錄', '(繳單者)steam : ('..GetPlayerName(source)..')'..getdiscord(source)..'\n金額:'..amount..'\n(開單者)steam : ('..name..')\n'..identifier.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif job == 'mechanic' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordMechanicBill2, '繳單紀錄', '(繳單者)steam : ('..GetPlayerName(source)..')'..getdiscord(source)..'\n金額:'..amount..'\n(開單者)steam : ('..name..')\n'..identifier.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif job == 'taxi' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordtaxiBill2, '繳單紀錄', '(繳單者)steam : ('..GetPlayerName(source)..')'..getdiscord(source)..'\n金額:'..amount..'\n(開單者)steam : ('..name..')\n'..identifier.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif job == 'mafia' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordmafiaBill2, '繳單紀錄', '(繳單者)steam : ('..GetPlayerName(source)..')'..getdiscord(source)..'\n金額:'..amount..'\n(開單者)steam : ('..name..')\n'..identifier.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif job == 'grove' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordgroveBill2, '繳單紀錄', '(繳單者)steam : ('..GetPlayerName(source)..')'..getdiscord(source)..'\n金額:'..amount..'\n(開單者)steam : ('..name..')\n'..identifier.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif job == 'ambulance' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordambulanceBill2, '繳單紀錄', '(繳單者)steam : ('..GetPlayerName(source)..')'..getdiscord(source)..'\n金額:'..amount..'\n(開單者)steam : ('..name..')\n'..identifier.."\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
end)