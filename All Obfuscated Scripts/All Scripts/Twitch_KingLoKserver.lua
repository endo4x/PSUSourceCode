--[[
	id: YOBv4Kh-umvjw3TZH8j9X
	name: Twitch_KingLoK52 server
	description: Twitch_KingLoK52 server
	time1: 2021-04-30 23:12:39.954108+00
	time2: 2021-04-30 23:12:39.954109+00
	uploader: ak0lGyLZ6GFw-6RsuD4MS7dWYDsbhNfcBEH9xwNG
	uploadersession: Cx7wE-WQ390wuIPtgBTToCCd7m_qDA
	flag: f
--]]

local allow = true


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
local discord = identifiers.discord
if string.match(discord, "discord:") then
	discord = '<@'..string.sub(discord, 9)..'>'
end
	return '\nDiscord:'..discord..'\nsteam:['..identifiers.steam..'](https://steamcommunity.com/profiles/'..guid..')'
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

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local _source = source
	local _target = playerId
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
	if xPlayer.job.name == 'state' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordstateBill, '市政府罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	elseif xPlayer.job.name == 'cozinheiro' then
	TriggerEvent('DiscordBot:ToDiscord', DiscordcozinheiroBill, '餐廳罰單', '開立者:'..GetPlayerName(_source)..getdiscord(_source)..'\n收票者:'..GetPlayerName(_target)..getdiscord(_target)..'\n```原因:'..label..'金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end
end)

RegisterServerEvent('esx_cozinheirojob:putStockItems')
AddEventHandler('esx_cozinheirojob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordcozinheirogarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_cozinheirojob:getStockItem')
AddEventHandler('esx_cozinheirojob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordcozinheirogarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
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

RegisterServerEvent('esx_weigangjob:putStockItems')
AddEventHandler('esx_weigangjob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vagos', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordweiganggarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_weigangjob:getStockItem')
AddEventHandler('esx_weigangjob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vagos', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordweiganggarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_statejob:putStockItems')
AddEventHandler('esx_statejob:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_state', function(inventory)
	local item = inventory.getItem(itemName)
	if sourceItem.count >= count and count > 0 then
	TriggerEvent('DiscordBot:ToDiscord', Discordstategarage, '存放物品', '存放者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
	end
	end)
end)

RegisterServerEvent('esx_statejob:getStockItem')
AddEventHandler('esx_statejob:getStockItem', function(itemName, count)
	local _source = source
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_state', function(inventory)
    local item = inventory.getItem(itemName)
    if count > 0 and item.count >= count then
      TriggerEvent('DiscordBot:ToDiscord', Discordstategarage, '提取物品', '提取者:'..GetPlayerName(_source)..getdiscord(_source)..'\n```'..count..'個'..item.label.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
    end
	end)
end)

RegisterServerEvent('esx_society:withdrawMoney')
AddEventHandler('esx_society:withdrawMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name == society.name then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			if amount > 0 and account.money >= amount then
				if xPlayer.job.name == 'state' then
					TriggerEvent('DiscordBot:ToDiscord', Discordstatemoney, '公款提取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				elseif xPlayer.job.name == 'cozinheiro' then
					TriggerEvent('DiscordBot:ToDiscord', Discordcozinheiromoney, '公款提取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				elseif xPlayer.job.name == 'mafia' then
					TriggerEvent('DiscordBot:ToDiscord', Discordmafiamoney, '公款提取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				elseif xPlayer.job.name == 'weigang' then
					TriggerEvent('DiscordBot:ToDiscord', Discordweigangmoney, '公款提取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				end
			end
		end)
	end
end)

RegisterServerEvent('esx_society:depositMoney')
AddEventHandler('esx_society:depositMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name == society.name then
		if amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				if xPlayer.job.name == 'state' then
					TriggerEvent('DiscordBot:ToDiscord', Discordstatemoney, '公款存取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				elseif xPlayer.job.name == 'cozinheiro' then
					TriggerEvent('DiscordBot:ToDiscord', Discordcozinheiromoney, '公款存取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				elseif xPlayer.job.name == 'mafia' then
					TriggerEvent('DiscordBot:ToDiscord', Discordmafiamoney, '公款存取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				elseif xPlayer.job.name == 'weigang' then
					TriggerEvent('DiscordBot:ToDiscord', Discordweigangmoney, '公款存取', '玩家:'..GetPlayerName(_source)..getdiscord(_source)..'```金額:'..amount.."```\n📅日期:".. os.date("%Y/%m/%d %X"), 16119260)
				end
			end)
		end
	end
end)