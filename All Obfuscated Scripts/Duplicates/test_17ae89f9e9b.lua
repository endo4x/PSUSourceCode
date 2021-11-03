--[[
	id: eQMYWF5JUsIxUurM91fsx
	name: test
	description: test
	time1: 2021-06-29 17:52:23.619295+00
	time2: 2021-06-29 17:52:23.619296+00
	uploader: qHDEs4yWa1bJXx--jH-R8ECu-7UMQJL4BgQsCfij
	uploadersession: bZAZOK87Hvi9naHBg1cDC-Vq2WjDfg
	flag: f
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPclient = Tunnel.getInterface("vRP", "kingdomsc_breaktime")
vRPclient2 = Tunnel.getInterface("kingdomsc_breaktime", "kingdomsc_breaktime")
vRP = Proxy.getInterface("vRP")
vRPts = {}
Tunnel.bindInterface("kingdomsc_breaktime", vRPts)

function dlog(title, message, webhook)
	local connect = {
        {
            ["color"] = 10682368,
            ["title"] = "**"..title.."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Made With ❤️ By aحmad#1158 - "..os.date('!%H:%M:%S')
            },
        }
    }
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = config.discord_log_username, avatar_url = config.discord_log_avatar, embeds = connect }), { ['Content-Type'] = 'application/json' })
end

local BreakTime = 0
local BreakEnable = false

vRP.registerMenuBuilder({config.BreakTime_Menu_Parent, function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
      local choices = {}
      if vRP.hasPermission({user_id, config.EnableBreakTime_Permission}) then
        choices["وقت الراحة"] = {startBreakTime, "تفعيل / ايقاف وقت الراحة"}
      end
      add(choices)
    end
end})
function startBreakTime(player, choice)
    if (BreakEnable) then
        vRP.request({player, "متأكد من إيقاف وقت الراحة؟", 30, function(player, ok)
            if (ok) then
                BreakEnable = false
                BreakTime = 0
                TriggerClientEvent("kingdomsc_breaktime:client:stopBreakTime", -1)
                dlog("ايقاف وقت الراحة", "Player : "..GetPlayerName(player).." | "..vRP.getUserId({player}).."\nCanceled Break Time", config.webhook)
            end
        end})
    else
        vRP.prompt({player, "مدة وقت الراحة (دقيقة):", "", function(player, btime)
            btime = tonumber(btime)
            if (btime ~= nil and btime > 0) then
                vRP.request({player, "متأكد من تفعيل وقت الراحة لمدة "..btime.." دقيقة", 30, function(player, ok)
                    if (ok) then
                        BreakTime = btime
                        BreakEnable = true
                        enableBreakTime()
                        TriggerClientEvent("kingdomsc_breaktime:client:startBreakTime", -1, btime, true)
                        dlog("تفعيل وقت الراحة", "Player : "..GetPlayerName(player).." | "..vRP.getUserId({player}).."\nActive Break Time : "..btime, config.webhook)
                    end
                end})
            end
        end})
    end
end
function enableBreakTime()
	Citizen.CreateThread(function()
		while BreakEnable do
			if BreakTime <= 0 then
				TriggerClientEvent("kingdomsc_breaktime:client:stopBreakTime", -1)
				BreakEnable = false
				break
			end
			TriggerClientEvent("kingdomsc_breaktime:client:updateBreakTime", -1, BreakTime)
			Citizen.Wait(60000)
            BreakTime = BreakTime - 1
		end
	end)
end
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if first_spawn then
        if BreakEnable then
            TriggerClientEvent("kingdomsc_breaktime:client:startBreakTime", source, BreakTime, false)
        end
    end
end)