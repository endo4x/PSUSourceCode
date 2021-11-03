--[[
	id: -r-v4keCLxqbbErZnlRjA
	name: kkkpt3
	description: kkk
	time1: 2021-07-18 00:11:32.297542+00
	time2: 2021-07-18 00:11:32.297543+00
	uploader: fNFlwvflivk-D54KDyZoNSZDKhkd10_e9Z8RvIjN
	uploadersession: Imm8VphatoYqMtzoW5e0slIsq-4ivU
	flag: f
--]]

local savedCoords = {}
local AssistList = {}
local staffs = {}
local onesync = false

RegisterNetEvent("MunchAdminAssists:NewAssist")
AddEventHandler("MunchAdminAssists:NewAssist", function(data)
	local _source = source
	local newassist = {
		id = #AssistList+1,
		playername = GetPlayerName(_source),
		title = data.title,
		description = data.description,
		solved = false,
		screenshotLink = data.url,
		playerid = _source
	}
	AssistList[#AssistList+1] = newassist
	TriggerClientEvent("MunchAdminAssists:AddToList",-1,newassist)
	if Config.AssistWebhook2 then
		if Config.AssistWebhook2 ~= "" and Config.AssistWebhook2 ~= "YOUR_WEB_HOOK_HERE" then
			SendWebhook(newassist)
		end
	end
end)

RegisterNetEvent("MunchAdminAssists:GetAssists")
AddEventHandler("MunchAdminAssists:GetAssists", function()
	local _source = source
	local admin = Config.Admins
	if admin then
		staffs[_source] = true
		TriggerClientEvent("MunchAdminAssists:GetAssists",_source,AssistList,onesync,admin)
	end
end)

RegisterNetEvent("MunchAdminAssists:TeleportAssist")
AddEventHandler("MunchAdminAssists:TeleportAssist", function(kindaid,doit)
	local _source = source
	if staffs[_source] then
		if doit then
			local id = AssistList[kindaid].playerid
			if GetPlayerPing(id) > 0 then
				local player = id
				local pedl = GetPlayerPed(player)
				local pcoords = GetEntityCoords(pedl)
				local ped = GetPlayerPed(_source)
				SetEntityCoords(ped,pcoords.x,pcoords.y,pcoords.z)
			else
			    exports['mythic_notify']:DoHudText('inform', 'The Player Is No Longer in the Server.')
			end
			if not AssistList[kindaid].solved then
				AssistList[kindaid].solved = "kinda"
			end
			TriggerClientEvent("MunchAdminAssists:AssistSolved",-1,kindaid,AssistList[kindaid].solved)
		end
	else
		print("cheater cheater, pumpkin eater... id: ".._source)
    end
end)

RegisterNetEvent("MunchAdminAssists:AssistSolved")
AddEventHandler("MunchAdminAssists:AssistSolved", function(id,can)
	local _source = source
	if staffs[_source] then
		local assist = AssistList[id]
		if assist then
			if assist.solved ~= true or can then
				if can then
					if AssistList[id].solved == true then
						AssistList[id].solved = false
					else
						AssistList[id].solved = true
					end
				else
					AssistList[id].solved = true
				end
				TriggerClientEvent("MunchAdminAssists:AssistSolved",-1,id,AssistList[id].solved)
			end
		end
	else
		print("cheater cheater, pumpkin eater... id: ".._source)
	end
end)

function SendWebhook(data)
    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Requested Assist - mAdmin",
        ["image"] = {url = data.screenshotLink},
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Player Name:",
        value = data.playername,
        },
        {
        name = "In-Game ID:",
        value = data.playerid,
        },
        {
        name = "Stated Reason for Assistance:",
        value = data.description,
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.AssistWebhook2, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end


BanWebhookMenu = function(playerId,reason, duration)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local steamid  = ""
    local discord  = "Not Linked"

    if duration == 3600 then
        duration = "1 Hour"
    elseif duration == 10800 then
        duration = "3 Hours"
    elseif duration == 21600 then
        duration = "6 Hours"
    elseif duration == 43200 then
        duration = "12 Hours"
    elseif duration == 86400 then
        duration = "1 Day"
    elseif duration == 172800 then
        duration = "2 Days"
    elseif duration == 259200 then
        duration = "3 Days"
    elseif duration == 518400 then
        duration = "1 Week"
    elseif duration == 1123200 then
        duration = "2 Weeks"
    elseif duration == 2678400 then
        duration = "1 Month"
    elseif duration == 10444633200 then
        duration = "Permanent"
    end

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Banned - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Player Name:",
        value = "**"..name.."**",
        },
        {
        name = "Player ID:",
        value = "**"..playerId.."**",
        },
        {
        name = "Details:",
        value = "**"..reason.."**",
        },
        {
        name = "Ban Length:",
        value = "**"..duration.."**",
        },
		{
		name = "Steam Hex:",
		value = "**"..steamid.."**",
		},
		{
		name = "Discord:",
		value = "**"..discord.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.KickBanWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

OfflineBanMenu = function(playerId, reason, duration, name, steam, discord)

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Offline Banned - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Player Name:",
        value = "**"..name.."**",
        },
        {
        name = "Player ID:",
        value = "**"..playerId.."**",
        },
        {
        name = "Details:",
        value = "**"..reason.."**",
        },
        {
        name = "Ban Length:",
        value = "**"..duration.."**",
        },
		{
		name = "Steam Hex:",
		value = "**"..steamid.."**",
		},
		{
		name = "Discord:",
		value = "**"..discord.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.KickBanWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

KickWebhookMenu = function(playerId,reason)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Kicked - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Player Name:",
        value = "**"..name.."**",
        },
        {
        name = "Player ID:",
        value = "**"..playerId.."**",
        },
        {
        name = "Details:",
        value = "**"..reason.."**",
        },
		{
		name = "Steam Hex:",
		value = "**"..steamid.."**",
		},
		{
		name = "Discord:",
		value = "**"..discord.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.KickBanWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

ScreenshotWebhook = function(playerId)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local src = GetPlayerName(source)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Screenshotted - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Admin:",
        value = "**"..src.."**",
        },
        {
        name = "Player:",
        value = "**"..name.."**",
        },
        {
        name = "Steam Hex:",
        value = "**"..steamid.."**",
        },
        {
        name = "Discord:",
        value = "**"..discord.."**",
        },
		{
		name = "Player ID:",
		value = "**"..playerId.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.ScreenshotLogsWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

ReviveWebhook = function(playerId)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local src = GetPlayerName(source)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Revived - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Admin:",
        value = "**"..src.."**",
        },
        {
        name = "Player:",
        value = "**"..name.."**",
        },
        {
        name = "Steam Hex:",
        value = "**"..steamid.."**",
        },
        {
        name = "Discord:",
        value = "**"..discord.."**",
        },
		{
		name = "Player ID:",
		value = "**"..playerId.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.ReviveWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

ForceskinWebhook = function(playerId)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local src = GetPlayerName(source)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Force Skinned - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Admin:",
        value = "**"..src.."**",
        },
        {
        name = "Player:",
        value = "**"..name.."**",
        },
        {
        name = "Steam Hex:",
        value = "**"..steamid.."**",
        },
        {
        name = "Discord:",
        value = "**"..discord.."**",
        },
		{
		name = "Player ID:",
		value = "**"..playerId.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.ForceskinWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

FreezeWebhook = function(playerId)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local src = GetPlayerName(source)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Froze - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Admin:",
        value = "**"..src.."**",
        },
        {
        name = "Player:",
        value = "**"..name.."**",
        },
        {
        name = "Steam Hex:",
        value = "**"..steamid.."**",
        },
        {
        name = "Discord:",
        value = "**"..discord.."**",
        },
		{
		name = "Player ID:",
		value = "**"..playerId.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.FreezeWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

SlapWebhook = function(playerId)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local src = GetPlayerName(source)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Killed - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Admin:",
        value = "**"..src.."**",
        },
        {
        name = "Player:",
        value = "**"..name.."**",
        },
        {
        name = "Steam Hex:",
        value = "**"..steamid.."**",
        },
        {
        name = "Discord:",
        value = "**"..discord.."**",
        },
		{
		name = "Player ID:",
		value = "**"..playerId.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.SlapWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('munchadminv2:kickplayer')
AddEventHandler('munchadminv2:kickplayer', function(player, reason)
    if player ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.kick") and not IsPlayerAceAllowed(player, "mAdmin.immune") then
            KickWebhookMenu(player, "Kicked by: " ..GetPlayerName(source).. " for Reason: " ..reason)
            DropPlayer(player, "\n\nYou have been kicked from "..Config.ServerName.." \n\nKicked by: " ..GetPlayerName(source).. " \n\nReason: " ..reason.. "\n\nFor more information, join our discord: "..Config.Discord)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    end
end)

local banned = false

RegisterServerEvent('munchadminv2:banplayer')
AddEventHandler('munchadminv2:banplayer', function(player, reason, duration)

    if duration == 3600 then
        penis = "1 Hour"
    elseif duration == 10800 then
        penis = "3 Hours"
    elseif duration == 21600 then
        penis = "6 Hours"
    elseif duration == 43200 then
        penis = "12 Hours"
    elseif duration == 86400 then
        penis = "1 Day"
    elseif duration == 172800 then
        penis = "2 Days"
    elseif duration == 259200 then
        penis = "3 Days"
    elseif duration == 518400 then
        penis = "1 Week"
    elseif duration == 1123200 then
        penis = "2 Weeks"
    elseif duration == 2678400 then
        penis = "1 Month"
    elseif duration == 10444633200 then
        penis = "Permanent"
    end

    if player ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.ban") and not IsPlayerAceAllowed(player, "mAdmin.immune") then
            BanWebhookMenu(player, "Banned by: " ..GetPlayerName(source).. " for Reason: " ..reason, duration)
            TriggerEvent("munchadminv2:filterban", "\n\nYou have been banned from "..Config.ServerName..". \n\nBanned by: " ..GetPlayerName(source).. " \n\nReason: " ..reason.. "\n\nBan Length: " ..penis.. " \n\nFor more information, join our Discord: "..Config.Discord, player, duration)
            banned = true
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    end
end)

MoneyWebhook = function(playerId, money)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local src = GetPlayerName(source)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

local discordInfo = {
    ["color"] = "65793",
    ["type"] = "rich",
    ["title"] = "Player Set Money - mAdmin",
    ["footer"] = {
        ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
    },
    ["fields"] = {
    {
    name = "Admin:",
    value = "**"..src.."**",
    },
    {
    name = "Player:",
    value = "**"..name.."**",
    },
    {
    name = "Amount:",
    value = "**$"..money.."**",
    },
    {
    name = "Steam Hex:",
    value = "**"..steamid.."**",
    },
    {
    name = "Discord:",
    value = "**"..discord.."**",
    },
    {
    name = "Player ID:",
    value = "**"..playerId.."**",
    ["author"] = {
        ["name"] = 'Munch#3374',
        ["url"] = 'https://flogrownrp.com/',
        ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
    }
}
}
}

PerformHttpRequest(Config.MoneyWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

BankWebhook = function(playerId, bank)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local src = GetPlayerName(source)
    local steamid  = ""
    local discord  = "Not Linked"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local discordInfo = {
        ["color"] = "65793",
        ["type"] = "rich",
        ["title"] = "Player Set Bank - mAdmin",
        ["footer"] = {
            ["text"] = (os.date("munchdev.xyz | %B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
        {
        name = "Admin:",
        value = "**"..src.."**",
        },
        {
        name = "Player:",
        value = "**"..name.."**",
        },
        {
        name = "Amount:",
        value = "**$"..bank.."**",
        },
        {
        name = "Steam Hex:",
        value = "**"..steamid.."**",
        },
        {
        name = "Discord:",
        value = "**"..discord.."**",
        },
		{
		name = "Player ID:",
		value = "**"..playerId.."**",
        ["author"] = {
            ["name"] = 'Munch#3374',
            ["url"] = 'https://flogrownrp.com/',
            ["icon_url"] = 'https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png'
        }
    }
}
}

    PerformHttpRequest(Config.MoneyWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Munch Admin', avatar_url = "https://cdn.discordapp.com/attachments/862104763495874601/862124795591655454/M.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("munchadminv2:TookScreenshot")
	
RegisterServerEvent("munchadminv2:TakeScreenshot")
AddEventHandler('munchadminv2:TakeScreenshot', function(playerId)
    if playerId ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.screenshot") then
	        if scrinprogress then
		        TriggerClientEvent("chatMessage", source, { args = { "Admin Menu", 'Screenshot in progress' } })
		        return
	        end
	        scrinprogress = true
	        local src=source
            local playerId = playerId
    
            thistemporaryevent = AddEventHandler("munchadminv2:TookScreenshot", function(result)
                res = tostring(result)
                scrinprogress = false
                RemoveEventHandler(thistemporaryevent)
            end)
    
            TriggerClientEvent("munchadminv2:CaptureScreenshot", playerId, Config.ScreenshotsWebhook)
            ScreenshotWebhook(playerId)
            local timeoutwait = 0
            repeat
                timeoutwait=timeoutwait+1
                Wait(5000)
                if timeoutwait == 5 then
                    RemoveEventHandler(thistemporaryevent)
                    scrinprogress = false
                    TriggerClientEvent("chatMessage", src, { args = { "Admin Menu", "Screenshot Failed!" } })
                end
            until not scrinprogress
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
    end
end)

RegisterServerEvent("munchadminv2:openmenucheck")
AddEventHandler("munchadminv2:openmenucheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.openmenu") then
        TriggerClientEvent("munchadminv2:openmenu", source, true)
    else
        TriggerClientEvent("munchadminv2:openmenu", source, false)
    end
end)

RegisterServerEvent("munchadminv2:banplayercheck")
AddEventHandler("munchadminv2:banplayercheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.ban") then
        TriggerClientEvent("munchadminv2:bandamunch", source, true)
    else
        TriggerClientEvent("munchadminv2:bandamunch", source, false)
    end
end)

RegisterServerEvent("munchadminv2:reviveplayercheck")
AddEventHandler("munchadminv2:reviveplayercheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.revive") then
        TriggerClientEvent("munchadminv2:revivedamunch", source, true)
    else
        TriggerClientEvent("munchadminv2:revivedamunch", source, false)
    end
end)

RegisterServerEvent("munchadminv2:manageplayercheck")
AddEventHandler("munchadminv2:manageplayercheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.manage") then
        TriggerClientEvent("munchadminv2:managedamunch", source, true)
    else
        TriggerClientEvent("munchadminv2:managedamunch", source, false)
    end
end)

RegisterServerEvent("munchadminv2:freezeplayercheck")
AddEventHandler("munchadminv2:freezeplayercheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.freeze") then
        TriggerClientEvent("munchadminv2:freezedamunch", source, true)
    else
        TriggerClientEvent("munchadminv2:freezedamunch", source, false)
    end
end)

RegisterServerEvent("munchadminv2:gotobringplayercheck")
AddEventHandler("munchadminv2:gotobringplayercheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.revive") then
        TriggerClientEvent("munchadminv2:gotobringdamunch", source, true)
    else
        TriggerClientEvent("munchadminv2:gotobringdamunch", source, false)
    end
end)

RegisterServerEvent("munchadminv2:spawnvehiclecheck")
AddEventHandler("munchadminv2:spawnvehiclecheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.spawnvehicle") then
        TriggerClientEvent("munchadminv2:spawnvehicle", source, true)
    else
        TriggerClientEvent("munchadminv2:spawnvehicle", source, false)
    end
end)

RegisterServerEvent("munchadminv2:gotobringcheck")
AddEventHandler("munchadminv2:gotobringcheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.bring") then
        TriggerClientEvent("munchadminv2:gotobring", source, true)
    else
        TriggerClientEvent("munchadminv2:gotobring", source, false)
    end
end)

RegisterServerEvent("munchadminv2:noclipcheck")
AddEventHandler("munchadminv2:noclipcheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.noclip") then
        TriggerClientEvent("munchadminv2:noclip", source, true)
    else
        TriggerClientEvent("munchadminv2:noclip", source, false)
    end
end)

RegisterServerEvent("munchadminv2:godmodecheck")
AddEventHandler("munchadminv2:godmodecheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.godmode") then
        TriggerClientEvent("munchadminv2:godmode", source, true)
    else
        TriggerClientEvent("munchadminv2:godmode", source, false)
    end
end)

RegisterServerEvent("munchadminv2:invisibilitycheck")
AddEventHandler("munchadminv2:invisibilitycheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.invisibility") then
        TriggerClientEvent("munchadminv2:invisibility", source, true)
    else
        TriggerClientEvent("munchadminv2:invisibility", source, false)
    end
end)

RegisterServerEvent("munchadminv2:unbancheck")
AddEventHandler("munchadminv2:unbancheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.unban") then
        TriggerClientEvent("munchadminv2:unbanplayer", source, true)
    else
        TriggerClientEvent("munchadminv2:unbanplayer", source, false)
    end
end)

RegisterServerEvent("munchadminv2:custompedcheck")
AddEventHandler("munchadminv2:custompedcheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.customped") then
        TriggerClientEvent("munchadminv2:customped", source, true)
    else
        TriggerClientEvent("munchadminv2:customped", source, false)
    end
end)

RegisterServerEvent("munchadminv2:pedwipecheck")
AddEventHandler("munchadminv2:pedwipecheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.pedwipe") then
        TriggerClientEvent("munchadminv2:pedwipe", source, true)
    else
        TriggerClientEvent("munchadminv2:pedwipe", source, false)
    end
end)

RegisterServerEvent("munchadminv2:objectwipecheck")
AddEventHandler("munchadminv2:objectwipecheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.objectwipe") then
        TriggerClientEvent("munchadminv2:objectwipe", source, true)
    else
        TriggerClientEvent("munchadminv2:objectwipe", source, false)
    end
end)

RegisterServerEvent("munchadminv2:masswipecheck")
AddEventHandler("munchadminv2:masswipecheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.masswipe") then
        TriggerClientEvent("munchadminv2:masswipe", source, true)
    else
        TriggerClientEvent("munchadminv2:masswipe", source, false)
    end
end)

RegisterServerEvent("munchadminv2:carwipecheck")
AddEventHandler("munchadminv2:carwipecheck", function()
    if IsPlayerAceAllowed(source, "mAdmin.carwipe") then
        TriggerClientEvent("munchadminv2:carwipe", source, true)
    else
        TriggerClientEvent("munchadminv2:carwipe", source, false)
    end
end)

RegisterServerEvent('munchadminv2:setmoney')
AddEventHandler('munchadminv2:setmoney', function(player, money)
    if player ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.setmoney") then
            if (player) then
                if money then
                    TriggerEvent("es:getPlayerFromId", player, function(user)
                        if(user)then
                            user.setMoney(money)
                            MoneyWebhook(player, money)
                            TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'error', text = GetPlayerName(tonumber(player)) .. " 's cash has been set to " .. money, length = 5000})
                        end
                    end)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Incorrect Amount. - [mAdmin]', length = 5000})
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this. - [mAdmin]', length = 5000})
        end
    end
end)

RegisterServerEvent('munchadminv2:setbank')
AddEventHandler('munchadminv2:setbank', function(player, bank)
    if player ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.setbank") then
            if (player) then
                if bank then
                    TriggerEvent("es:getPlayerFromId", player, function(user)
                        if(user)then
                            user.setBankBalance(bank)
                            BankWebhook(player, bank)
                            TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'error', text = GetPlayerName(tonumber(player)) .. " 's bank has been set to " .. bank, length = 5000})
                        end
                    end)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Incorrect Amount. - [mAdmin]', length = 5000})
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    end
end)

RegisterServerEvent('munchadminv2:setgroup')
AddEventHandler('munchadminv2:setgroup', function(player, group)
    if player ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.setgroup") then
            if (player) then
                TriggerEvent("es:getAllGroups", function(groups)
    
                    if(group)then
                        TriggerEvent("es:getPlayerFromId", player, function(user)
                            ExecuteCommand('remove_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())
    
                            TriggerEvent("es:setPlayerData", player, "group", group, function(response, success)
                                TriggerClientEvent('es:setPlayerDecorator', player, 'group', tonumber(group), true)
                                TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'error', text = GetPlayerName(player) .. " has been set as " .. group, length = 5000})
    
                                ExecuteCommand('add_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())
                            end)
                        end)
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Incorrect Group. - [mAdmin]', length = 5000})
                    end
                end)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
    end
end)

RegisterServerEvent('munchadminv2:setpermissionlevel')
AddEventHandler('munchadminv2:setpermissionlevel', function(player, level)
    if player ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.setpermlevel") then
            if (player) then
                if level then
                    TriggerEvent("es:setPlayerData", tonumber(player), "permission_level", tonumber(level), function(response, success)
            
                        TriggerClientEvent('es:setPlayerDecorator', tonumber(player), 'rank', tonumber(level), true)
                        TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'error', text = GetPlayerName(tonumber(player)) .. " has been set to " .. level, length = 5000})
                    end)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Incorrect Level. - [mAdmin]', length = 5000})
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
    end
end)

TriggerEvent('es:addCommand', 'admin', function(source, args, user)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "[mAdmin] - Level: " .. tostring(user.get('permission_level')), length = 5000})
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "[mAdmin] - Group: " .. user.getGroup(), length = 5000})
end, {help = "Shows what admin level you are and what group you're in"})

TriggerEvent('es:addGroupCommand', 'announce', "admin", function(source, args, user)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 1.8vw; background-color: rgba(0, 255, 0, 0.5); border-radius: 3px;"><i class="fas fa-cog"></i> Announcement:<br> {1}<br></div>',
        args = { "ANNOUNCEMENT", table.concat(args, " ") }
    })
end, function(source, args, user)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})


RegisterServerEvent("munchadminv2:revive")
AddEventHandler('munchadminv2:revive', function(playerId)
    if playerId ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.revive") then
            ReviveWebhook(playerId)
            TriggerClientEvent("fgrp_ambulancejob:revive", playerId)
            TriggerClientEvent('visn_are:resetValues', playerId)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
    end
end)

RegisterServerEvent("munchadminv2:forceskin")
AddEventHandler('munchadminv2:forceskin', function(playerId)
    if playerId ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.forceskin") then
            ForceskinWebhook(playerId)
            TriggerClientEvent("betrayed_skins:defaultReset", playerId)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
    end
end)

RegisterServerEvent("munchadminv2:slap")
AddEventHandler('munchadminv2:slap', function(playerId)
    if playerId ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.slap") then
            SlapWebhook(playerId)
            TriggerClientEvent('munchadminv2:slap', playerId)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
    end
end)

RegisterServerEvent("munchadminv2:freeze")
AddEventHandler('munchadminv2:freeze', function(playerId, toggle)
    if playerId ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.freeze") then
            FreezeWebhook(playerId)
            TriggerClientEvent("munchadminv2:freeze", playerId, toggle)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
    end
end)

RegisterCommand("goto", function(source, args)
    if IsPlayerAceAllowed(source, "mAdmin.bring") then
        if args[1] then
            local ped = GetPlayerPed(tonumber(args[1]))
            local target = GetEntityCoords(ped)
            local myself = GetEntityCoords(GetPlayerPed(tonumber(source)))
            savedCoords[source] = myself
            TriggerClientEvent('munchadminv2:gotobring', source, target.x, target.y, target.z)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Incorrect Player ID. Usage: /goto id - [mAdmin]', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
    end
end, false)

RegisterServerEvent("munchadminv2:gotobutton")
AddEventHandler("munchadminv2:gotobutton", function(playerId)
    if playerId ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.bring") then
            if playerId then
                local ped = GetPlayerPed(tonumber(playerId))
                local target = GetEntityCoords(ped)
                local myself = GetEntityCoords(GetPlayerPed(tonumber(source)))
                savedCoords[source] = myself
                TriggerClientEvent('munchadminv2:gotobring', source, target.x, target.y, target.z)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player not found. - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    end
end)

RegisterCommand("goback", function(source, args)
    if IsPlayerAceAllowed(source, "mAdmin.bring") then
        local myselfCoords = savedCoords[source]
        TriggerClientEvent('munchadminv2:gotobring', source, myselfCoords.x, myselfCoords.y, myselfCoords.z)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
    end
end, false)

RegisterCommand("bring", function(source, args, rawCommand)
    local src = source
    if src ~= nil then
        local allowed = IsPlayerAceAllowed(src, "mAdmin.bring")
          if allowed then
            local tgt = tonumber(args[1])
            if tgt ~= nil and tgt > 0 then
                local tgtPed = GetPlayerPed(tgt)
                if tgtPed ~= nil then
                    local tgtCoords = GetEntityCoords(tgtPed)
                    local srcPed = GetPlayerPed(src)
                    local srcCoords = GetEntityCoords(srcPed)
                    savedCoords[tgt] = tgtCoords
                    TriggerClientEvent("munchadminv2:gotobring", tgt, srcCoords.x, srcCoords.y, srcCoords.z)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Player not found. - [mAdmin]', length = 5000})
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Player not found. - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
          end
    end
end, false)

RegisterServerEvent("munchadminv2:bringbutton")
AddEventHandler("munchadminv2:bringbutton", function(playerId)
    if playerId ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.bring") then
            if playerId then
                local targetId = tonumber(playerId)
                local target = GetPlayerPed(targetId)
                if target then
                    local ped = GetPlayerPed(tonumber(source))
                    local targetCoords = GetEntityCoords(target)
                    local playerCoords = GetEntityCoords(ped)
                    savedCoords[targetId] = targetCoords
                    TriggerClientEvent("munchadminv2:gotobring", targetId, playerCoords.x, playerCoords.y, playerCoords.z)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player not found. - [mAdmin]', length = 5000})
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player not found. - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    end
end)

RegisterCommand("sendback", function(source, args)
	if source ~= 0 then
        if IsPlayerAceAllowed(source, "mAdmin.bring") then
            if args[1] then
      			local targetId = tonumber(args[1])
      			local xtarget = GetPlayerPed(targetId)
      			if xtarget then
        			local playerCoords = savedCoords[targetId]
        			if playerCoords then
                        TriggerClientEvent("munchadminv2:gotobring", targetId, playerCoords.x, playerCoords.y, playerCoords.z)
                        savedCoords[targetId] = nil
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No previous location found. - [mAdmin]', length = 5000})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Player Not Found. - [mAdmin]', length = 5000})
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Incorrect Usage. /sendback [id] - [mAdmin]', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
	end
end, false)

RegisterCommand("carwipe", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "mAdmin.carwipe") then
        TriggerClientEvent("munchadminv2:utilone", -1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
    end
end, false)

RegisterCommand("assistlist", function(source, args, rawCommand)
        if IsPlayerAceAllowed(source, "mAdmin.assistmenu") then
		    AssistNUI(true)
	    else
		    exports['mythic_notify']:SendAlert('error', 'You Dont have permission to use this feature.', 5000)
	end
end, false)

RegisterCommand("entitywipe", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "mAdmin.masswipe") then
        TriggerClientEvent("munchadminv2:utilthree", -1)
        TriggerClientEvent("munchadminv2:utiltwo", -1)
        TriggerClientEvent("munchadminv2:utilone", -1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
    end
end, false)

CachedPlayers = {}

AddEventHandler('playerDropped', function(reason)
    if savedCoords[playerId] then
    	savedCoords[playerId] = nil
    end

    local steamid  = ""
    local license  = ""
    local discord  = ""
    local xbl      = ""
    local liveid   = ""
    local ip       = ""

    local src = source

    for k,v in pairs(GetPlayerIdentifiers(src))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end 
    end

    local discplayer = {
        id = src, 
        license = license, 
        steam = steamid, 
        live = liveid, 
        xbl = xbl, 
        discord = discord, 
        ip = ip, 
        name = GetPlayerName(src), 
        timegone = 180000
    }
    table.insert(CachedPlayers, discplayer)
end)

local BanList            = {}
local BanListLoad        = false
local joined = false

RegisterServerEvent('munchadminv2:offlinebanplayer')
AddEventHandler('munchadminv2:offlinebanplayer', function(player, license, steam, live, xbl, discord, ip, name, duration, reason)
    local durtext = ""
    local disc = ""
    if discord ~= "" then
        disc = "<@"..discord..">"
    else
        disc = "Not Linked"
    end

    if duration == 3600 then
        durtext = "1 Hour"
    elseif duration == 10800 then
        durtext = "3 Hours"
    elseif duration == 21600 then
        durtext = "6 Hours"
    elseif duration == 43200 then
        durtext = "12 Hours"
    elseif duration == 86400 then
        durtext = "1 Day"
    elseif duration == 172800 then
        durtext = "2 Days"
    elseif duration == 259200 then
        durtext = "3 Days"
    elseif duration == 518400 then
        durtext = "1 Week"
    elseif duration == 1123200 then
        durtext = "2 Weeks"
    elseif duration == 2678400 then
        durtext = "1 Month"
    elseif duration == 10444633200 then
        durtext = "Permanent"
    end

    if player ~= nil then
        if IsPlayerAceAllowed(source, "mAdmin.ban") and not IsPlayerAceAllowed(player, "mAdmin.immune") then
            menuban(player, license, steam, live, xbl, discord, ip, name, duration, "\n\nYou have been banned from "..Config.ServerName..". \n\nBanned by: " ..GetPlayerName(source).. " \n\nReason: " ..reason.. "\n\nBan Length: " ..durtext.. " \n\nFor more information, join our discord: "..Config.Discord, 0)
            OfflineBanMenu(player, "Banned by: " ..GetPlayerName(source).. " for Reason: " ..reason, durtext, name, steam, disc)
            banned = true
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
        end
    end
end)

RegisterServerEvent("munchadminv2:requestCachedPlayers")
AddEventHandler('munchadminv2:requestCachedPlayers', function()
	local src = source
	if IsPlayerAceAllowed(source,"mAdmin.ban") then
	    TriggerClientEvent("munchadminv2:fillCachedPlayers", src, CachedPlayers)
    end
end)

CreateThread(function()
	while true do
		Wait(1000)
		if BanListLoad == false then
			loadBanListMenu()
			if BanList ~= {} then
				print("Ban List Successfully Loaded.")
				BanListLoad = true
			else
				print("ERROR: Ban List did not load.")
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(600000)
		if BanListLoad == true then
			loadBanListMenu()
		end
	end
end)

RegisterServerEvent('munchadminv2:filterban')
AddEventHandler('munchadminv2:filterban', function(reason,servertarget,duration)
	local license,identifier,liveid,xblid,discord,playerip,target
	local duree     = duration
	local reason    = reason

	if tostring(source) == "" then
		target = tonumber(servertarget)
	else
		target = source
	end

	if target and target > 0 then
		local ping = GetPlayerPing(target)

		if ping and ping > 0 then
			if duree and duree then
				local playername = GetPlayerName(target)

				for k,v in ipairs(GetPlayerIdentifiers(target))do
					if string.sub(v, 1, string.len("license:")) == "license:" then
						license = v
					elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
						identifier = v
					elseif string.sub(v, 1, string.len("live:")) == "live:" then
						liveid = v
					elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
						xblid  = v
					elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
						discord = v
					elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
						playerip = v
					end
				end

				if duree then
					menuban(target,license,identifier,liveid,xblid,discord,playerip,playername,duree,reason,0)
					DropPlayer(target, reason, duration)
				end
			else
				print("Error: Invalid Time")
			end
		else
			print("Error: Player not online.")
		end
	else
		print("Error: Invalid ID.")
	end
end)

AddEventHandler('playerConnecting', function(playerName,setKickReason)
	local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	if (Banlist == {}) then
		Citizen.Wait(1000)
    end
    
    for _, dudes in pairs(CachedPlayers) do 
        if steamID == dudes.steam then
            table.remove(CachedPlayers, _)
            joined = true
        elseif license == dudes.license then
            table.remove(CachedPlayers, _)
            joined = true
        elseif xblid == dudes.xbl then
            table.remove(CachedPlayers, _)
            joined = true
        elseif playerip == dudes.ip then
            table.remove(CachedPlayers, _)
            joined = true
        elseif discord == dudes.discord then
            table.remove(CachedPlayers, _)
            joined = true
        elseif liveid == dudes.live then
            table.remove(CachedPlayers, _)
            joined = true
        end
    end

	for i = 1, #BanList, 1 do
		if 
			  ((tostring(BanList[i].license)) == tostring(license) 
			or (tostring(BanList[i].identifier)) == tostring(steamID) 
			or (tostring(BanList[i].liveid)) == tostring(liveid) 
			or (tostring(BanList[i].xblid)) == tostring(xblid) 
			or (tostring(BanList[i].discord)) == tostring(discord) 
			or (tostring(BanList[i].playerip)) == tostring(playerip)) 
		then

			if (tonumber(BanList[i].permanent)) == 1 then

				setKickReason("" .. BanList[i].reason .. " \n\nTime Remaining: " .. txtday .. " days, " .. txthrs .. " hours, & " .. txtminutes .. " minute(s).")
				CancelEvent()
				break

			elseif (tonumber(BanList[i].expires)) > os.time() then

				local tempsrestant     = (((tonumber(BanList[i].expires)) - os.time())/60)
				if tempsrestant >= 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = (day - math.floor(day)) * 24
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason("" .. BanList[i].reason .. " \n\nTime Remaining: " .. txtday .. " days, " .. txthrs .. " hours, & " .. txtminutes .. " minute(s).")					
						CancelEvent()
						break
				elseif tempsrestant >= 60 and tempsrestant < 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = tempsrestant / 60
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason("" .. BanList[i].reason .. " \n\nTime Remaining: " .. txtday .. " days, " .. txthrs .. " hours, & " .. txtminutes .. " minute(s).")
						CancelEvent()
						break
				elseif tempsrestant < 60 then
					local txtday     = 0
					local txthrs     = 0
					local txtminutes = math.ceil(tempsrestant)
						setKickReason("" .. BanList[i].reason .. " \n\nTime Remaining: " .. txtday .. " days, " .. txthrs .. " hours, & " .. txtminutes .. " minute(s).")
						CancelEvent()
						break
				end

			elseif (tonumber(BanList[i].expires)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then

				deletebanned(license)
				break
			end
		end
	end
end)

local thread = 500
Citizen.CreateThread(function()
    while true do
        for _, dplys in pairs(CachedPlayers) do 
            local timer = dplys.timegone
            while timer ~= 0 do
                thread = 0
                Citizen.Wait(100)
                timer = timer - 1
                if joined then
                    break
                end
                if banned then 
                    table.remove(CachedPlayers, _)
                    banned = false
                    break
                end
            end
            if timer == 0 then
                table.remove(CachedPlayers, _)
            end
        end
        Citizen.Wait(thread)
    end
end)

function menuban(player,license,identifier,liveid,xblid,discord,playerip,playername,duree,reason,permanent)
	local expires = duree
	local dateandtime = os.time()

	if expires < os.time() then
		expires = os.time()+expires
	end

	table.insert(BanList, {
		license    = license,
		identifier = identifier,
		liveid     = liveid,
		xblid      = xblid,
        discord    = discord,
        playername = playername,
		playerip   = playerip,
		reason     = reason,
		expires = expires,
		permanent  = permanent
	})

	MySQL.Async.execute('INSERT INTO mAdmin_bans (license,identifier,liveid,xblid,discord,playerip,playername,reason,expires,dateandtime,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername,@reason,@expires,@dateandtime,@permanent)', {
		['@license']          = license,
		['@identifier']       = identifier,
		['@liveid']           = liveid,
		['@xblid']            = xblid,
		['@discord']          = discord,
		['@playerip']         = playerip,
		['@playername'] = playername,
		['@reason']           = reason,
		['@expires']       = expires,
		['@dateandtime']           = dateandtime,
		['@permanent']        = permanent,
	}, function()
	end)

	BanListHistoryLoad = false
end

function loadBanListMenu()
	MySQL.Async.fetchAll('SELECT * FROM mAdmin_bans', {}, function(data)
		BanList = {}

		for i=1, #data, 1 do
			table.insert(BanList, {
				license    = data[i].license,
				identifier = data[i].identifier,
				liveid     = data[i].liveid,
				xblid      = data[i].xblid,
				discord    = data[i].discord,
				playerip   = data[i].playerip,
				reason     = data[i].reason,
				expires = data[i].expires,
				permanent  = data[i].permanent
			})
		end
	end)
end

RegisterServerEvent('munchadminv2:unban')
AddEventHandler('munchadminv2:unban', function(targetU)
	if IsPlayerAceAllowed(source, "mAdmin.unban") then
		MySQL.Async.fetchAll('SELECT * FROM mAdmin_bans WHERE identifier like @identifier', 
		{
			['@identifier'] = ("%"..targetU.."%")
		}, function(data)
			MySQL.Async.execute(
			'DELETE FROM mAdmin_bans WHERE identifier = @identifier',
			{
				['@identifier']  = data[1].identifier
			},
				function()
				loadBanListMenu()
			end)
		end)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have permission to do this! - [mAdmin]', length = 5000})
	end
end)

function deletebanned(license) 
	MySQL.Async.execute(
		'DELETE FROM mAdmin_bans WHERE license=@license',
		{
		  ['@license']  = license
		},
		function ()
			loadBanListMenu()
	end)
end

AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 10

RegisterServerEvent('vSync:requestSync')
AddEventHandler('vSync:requestSync', function()
    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(Config.Admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('freezetime', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            freezeTime = not freezeTime
            if freezeTime then
                exports['mythic_notify']:DoHudText('success', 'Time is now frozen. - [mAdmin]')
            else
                exports['mythic_notify']:DoHudText('error', 'Time is no longer frozen. - [mAdmin]')
            end
        else
            exports['mythic_notify']:DoHudText('error', 'You are not allowed to use this command. - [mAdmin]')
        end
    else
        freezeTime = not freezeTime
        if freezeTime then
            print("Time is now frozen.")
        else
            print("Time is no longer frozen.")
        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                exports['mythic_notify']:DoHudText('inform', 'Dynamic weather changes are now disabled.')
            else
                exports['mythic_notify']:DoHudText('inform', 'Dynamic weather changes are now enabled.')
            end
        else
            exports['mythic_notify']:DoHudText('error', 'You are not allowed to use this command. - [mAdmin]')
        end
    else
        DynamicWeather = not DynamicWeather
        if not DynamicWeather then
            print("Weather is now frozen.")
        else
            print("Weather is no longer frozen.")
        end
    end
end)

RegisterCommand('weather', function(source, args)
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print("Invalid syntax, correct syntax is: /weather <weathertype> ")
            return
        else
            for i,wtype in ipairs(AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print("Weather has been updated.")
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 10
                TriggerEvent('vSync:requestSync')
            else
                print("Invalid weather type, valid weather types are: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ")
            end
        end
    else
        if isAllowedToChange(source) then
            local validWeatherType = false
            if args[1] == nil then
                exports['mythic_notify']:DoHudText('error', '[ERROR] Invalid syntax! Use /weather <weatherType> instead!. - [mAdmin]')
            else
                for i,wtype in ipairs(AvailableWeatherTypes) do
                    if wtype == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    TriggerClientEvent('vSync:notify', source, 'Weather will change to: ' .. string.lower(args[1]) .. ".")
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 10
                    TriggerEvent('vSync:requestSync')
                else
                    exports['mythic_notify']:DoHudText('error', '[ERROR] Invalid weather type! Valid weather types are: EXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN. - [mAdmin]')
                end
            end
        else
            exports['mythic_notify']:DoHudText('error', '[ERROR] You do not have access to that command. - [mAdmin]')
            print('Access for command /weather denied.')
        end
    end
end, false)

RegisterCommand('blackout', function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print("Blackout is now enabled.")
        else
            print("Blackout is now disabled.")
        end
    else
        if isAllowedToChange(source) then
            blackout = not blackout
            if blackout then
                exports['mythic_notify']:DoHudText('success', 'Blackout is now Enabled - [mAdmin]')
            else
                exports['mythic_notify']:DoHudText('error', 'Blackout is now Disabled - [mAdmin]')
            end
            TriggerEvent('vSync:requestSync')
        end
    end
end)

RegisterCommand('morning', function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(9)
        exports['mythic_notify']:DoHudText('success', 'Time set to Morning - [mAdmin]')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('noon', function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(12)
        exports['mythic_notify']:DoHudText('success', 'Time set to Noon - [mAdmin]')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('evening', function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(18)
        exports['mythic_notify']:DoHudText('success', 'Time set to Evening - [mAdmin]')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('night', function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(23)
        exports['mythic_notify']:DoHudText('success', 'Time set to Night - [mAdmin]')
        TriggerEvent('vSync:requestSync')
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterCommand('time', function(source, args, rawCommand)
    if source == 0 then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            print("Time has changed to " .. argh .. ":" .. argm .. ".")
            TriggerEvent('vSync:requestSync')
        else
            print("Invalid syntax, correct syntax is: time <hour> <minute> !")
        end
    elseif source ~= 0 then
        if isAllowedToChange(source) then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
				local minute = math.floor((baseTime+timeOffset)%60)
                if minute < 10 then
                    newtime = newtime .. "0" .. minute
                else
                    newtime = newtime .. minute
                end
                TriggerClientEvent('vSync:notify', source, 'Time was changed to: ' .. newtime .. "!")
                TriggerEvent('vSync:requestSync')
            else
                exports['mythic_notify']:DoHudText('error', '[ERROR] Invalid syntax! Use /time <hour> <minute> instead!. - [mAdmin]')
            end
        else
            exports['mythic_notify']:DoHudText('error', '[ERROR] You do not have access to that Command!. - [mAdmin]')
            print('Access for command /time denied.')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(9000000)
        TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(1800000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("vSync:requestSync")
    if debugprint then
        print("[Munch] New random weather type has been generated: " .. CurrentWeather .. ".\n")
        print("[Munch] Resetting timer to 10 minutes.\n")
    end
end


