--[[
	id: 0qCC-aESEWkCV44Yc7KX1
	name: version
	description: 版本管理
	time1: 2021-06-09 02:00:44.8319+00
	time2: 2021-06-09 02:00:44.831901+00
	uploader: GpCCvQyWs-AEuDdLaE60qMW5F7gI-n4KMGxxr4uj
	uploadersession: PRkBs2WQpLAg7aPe8tsB2K8l-nhQ8u
	flag: f
--]]

local License = GetConvar("wolf_airdrop_license")
local PluginName = 'wolf_airdrop'
local checkLicense = false
-- version check
Citizen.CreateThread(function()
		SetConvarServerInfo(PluginName, "V"..Config.versionCheck)
		local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
		if vRaw and Config.versionCheck then
			local v = json.decode(vRaw)
			PerformHttpRequest(
				'https://bnsw.tech/fivem/'..PluginName..'/version.json',
				function(code, res, headers)
					if code == 200 then
						local rv = json.decode(res)
						if rv.version ~= v.version then
							print(
								([[^1

-------------------------------------------------------
Plugin: %s
NewVersion: %s
ChangeLog: %s
-------------------------------------------------------
^0]]):format(						PluginName,
									rv.version,
									rv.changelog
								)
							)
						end
					else
						print(PluginName..' Can Not Do VersionCheck')
					end
				end,
				'GET'
			)
		end
	end
)

Citizen.CreateThread(function()
	PerformHttpRequest('https://bnsw.tech/fivem/'..PluginName..'/hook_'..License..'.json', function(code, res, headers)
		if code == 200 then
			local rs = json.decode(res)
			PerformHttpRequest(rs['validation'].ipCheckService, function(code, res2, headers)
				if code == 200 then
					local ServerIP = res2
					local ServerName = GetConvar("sv_hostname")
					local color = "#FFFFFF"
					local message = ([[
		ServerName: %s
		ServerIP: %s
		Version: %s
		License: %s
		]]):format(ServerName, ServerIP, Config.versionCheck, License)
					Discord(rs['discordhook'].webhook, message, color, rs['discordhook'].FooterText, rs['discordhook'].botusername, rs['discordhook'].Title)
				elseif rs['validation'].ipCheck then
					local ServerName = GetConvar("sv_hostname")
					local color = "#FFFFFF"
					local message = ([[
		ServerName: %s
		ServerIP: Unreachable
		ipCheck: Needed
		Version: %s
		License: %s
		]]):format(ServerName, Config.versionCheck, License)
					Discord(rs['discordhook'].webhook, message, color, rs['discordhook'].FooterText, rs['discordhook'].botusername, rs['discordhook'].Title)
				else
					local ServerName = GetConvar("sv_hostname")
					local color = "#FFFFFF"
					local message = ([[
		ServerName: %s
		ServerIP: Unreachable
		Version: %s
		License: %s
		]]):format(ServerName, Config.versionCheck, License)
					Discord(rs['discordhook'].webhook, message, color, rs['discordhook'].FooterText, rs['discordhook'].botusername, rs['discordhook'].Title)
				end
			end,'GET')
		end
	end,'GET')
end)

Citizen.CreateThread(function()
	PerformHttpRequest('https://bnsw.tech/fivem/'..PluginName..'/hook_'..License..'.json', function(code, res, headers)
		if code == 200 then
			local rs = json.decode(res)
			PerformHttpRequest(rs['validation'].ipCheckService, function(code, ServerIP, headers)
				if code ~= 200 or not rs['validation'].ipCheck then
					checkLicense = true
				elseif code == 200 and rs['validation'].ipCheck and rs['validation'][ServerIP] then
					checkLicense = true
				else
					print('Plugin can not verify, please contact Discord: boringwolf#0905.')
				end
			end,'GET')
		else
			print('Plugin can not verify, please contact Discord: boringwolf#0905.')
		end
	end,'GET')
end)

AddEventHandler(PluginName..':verify', function(cb)
	cb(checkLicense)
end)


function Discord(url, message, color, FooterText, username, title)
	if string.find(color,"#") then _color = tonumber(color:gsub("#",""),16) else _color = color end
  	PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({
		username = username, 
		embeds = {{
			["color"] = _color, 
			["title"] = title,
			["description"] = "".. message .."",
			["footer"] = {
				["text"] = FooterText..os.date("%x %X %p"),
			},
		}}
	}), { 
		['Content-Type'] = 'application/json' 
	})
end