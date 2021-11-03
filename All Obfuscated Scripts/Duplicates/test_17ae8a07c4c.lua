--[[
	id: khiav3WG0ht7MpdsAECLS
	name: test
	description: test
	time1: 2021-07-02 23:59:26.547283+00
	time2: 2021-07-02 23:59:26.547284+00
	uploader: 88FB6Db7HL0pVyS7l2psa4OtTEBTlOw0LyxFM-LZ
	uploadersession: XBb0ye2qB-QOsbPkqdJd_aJRVn3AlY
	flag: f
--]]

Rival.Functions = {}

Rival.Functions.ExecuteSql = function(wait, query, cb)
	local rtndata = {}
	local waiting = true
	exports['ghmattimysql']:execute(query, {}, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
	end
	return rtndata
end

Rival.Functions.GetIdentifier = function(source, idtype)
	local idtype = idtype ~=nil and idtype or Config.IdentifierType
	for _, identifier in pairs(GetPlayerIdentifiers(source)) do
		if string.find(identifier, idtype) then
			return identifier
		end
	end
	return nil
end

Rival.Functions.GetSource = function(identifier)
	for src, player in pairs(Rival.Players) do
		local idens = GetPlayerIdentifiers(src)
		for _, id in pairs(idens) do
			if identifier == id then
				return src
			end
		end
	end
	return 0
end

Rival.Functions.GetPlayer = function(source)
	if type(source) == "number" then
		return Rival.Players[source]
	else
		return Rival.Players[Rival.Functions.GetSource(source)]
	end
end

Rival.Functions.GetPlayerByCitizenId = function(citizenid)
	for src, player in pairs(Rival.Players) do
		local cid = citizenid
		if Rival.Players[src].PlayerData.citizenid == cid then
			return Rival.Players[src]
		end
	end
	return nil
end

Rival.Functions.GetPlayerByPhone = function(number)
	for src, player in pairs(Rival.Players) do
		local cid = citizenid
		if Rival.Players[src].PlayerData.charinfo.phone == number then
			return Rival.Players[src]
		end
	end
	return nil
end

Rival.Functions.GetPlayers = function()
	local sources = {}
	for k, v in pairs(Rival.Players) do
		table.insert(sources, k)
	end
	return sources
end

Rival.Functions.CreateCallback = function(name, cb)
	Rival.ServerCallbacks[name] = cb
end

Rival.Functions.TriggerCallback = function(name, source, cb, ...)
	if Rival.ServerCallbacks[name] ~= nil then
		Rival.ServerCallbacks[name](source, cb, ...)
	end
end

Rival.Functions.CreateUseableItem = function(item, cb)
	Rival.UseableItems[item] = cb
end

Rival.Functions.CanUseItem = function(item)
	return Rival.UseableItems[item] ~= nil
end

Rival.Functions.UseItem = function(source, item)
	Rival.UseableItems[item.name](source, item)
end

Rival.Functions.Kick = function(source, reason, setKickReason, deferrals)
	local src = source
	reason = "\n"..reason.."\n🔸 Check our Discord for further information: "..Rival.Config.Server.discord
	if(setKickReason ~=nil) then
		setKickReason(reason)
	end
	Citizen.CreateThread(function()
		if(deferrals ~= nil)then
			deferrals.update(reason)
			Citizen.Wait(2500)
		end
		if src ~= nil then
			DropPlayer(src, reason)
		end
		local i = 0
		while (i <= 4) do
			i = i + 1
			while true do
				if src ~= nil then
					if(GetPlayerPing(src) >= 0) then
						break
					end
					Citizen.Wait(100)
					Citizen.CreateThread(function() 
						DropPlayer(src, reason)
					end)
				end
			end
			Citizen.Wait(5000)
		end
	end)
end

Rival.Functions.IsWhitelisted = function(source)
	local identifiers = GetPlayerIdentifiers(source)
	local rtn = false
	if (Rival.Config.Server.whitelist) then
		Rival.Functions.ExecuteSql(true, "SELECT * FROM `whitelist` WHERE `"..Rival.Config.IdentifierType.."` = '".. Rival.Functions.GetIdentifier(source).."'", function(result)
			local data = result[1]
			if data ~= nil then
				for _, id in pairs(identifiers) do
					if data.steam == id or data.license == id then
						rtn = true
					end
				end
			end
		end)
	else
		rtn = true
	end
	return rtn
end

Rival.Functions.AddPermission = function(source, permission)
	local Player = Rival.Functions.GetPlayer(source)
	if Player ~= nil then 
		Rival.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = {
			steam = GetPlayerIdentifiers(source)[1],
			license = GetPlayerIdentifiers(source)[2],
			permission = permission:lower(),
		}
		Rival.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."'")
		Rival.Functions.ExecuteSql(true, "INSERT INTO `permissions` (`name`, `steam`, `license`, `permission`) VALUES ('"..GetPlayerName(source).."', '"..GetPlayerIdentifiers(source)[1].."', '"..GetPlayerIdentifiers(source)[2].."', '"..permission:lower().."')")
		Player.Functions.UpdatePlayerData()
		TriggerClientEvent('Rival:Client:OnPermissionUpdate', source, permission)
	end
end

Rival.Functions.RemovePermission = function(source)
	local Player = Rival.Functions.GetPlayer(source)
	if Player ~= nil then 
		Rival.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = nil	
		Rival.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."'")
		Player.Functions.UpdatePlayerData()
	end
end

Rival.Functions.HasPermission = function(source, permission)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	local permission = tostring(permission:lower())
	if permission == "user" then
		retval = true
	else
		if Rival.Config.Server.PermissionList[steamid] ~= nil then 
			if Rival.Config.Server.PermissionList[steamid].steam == steamid and Rival.Config.Server.PermissionList[steamid].license == licenseid then
				if Rival.Config.Server.PermissionList[steamid].permission == permission or Rival.Config.Server.PermissionList[steamid].permission == "god" then
					retval = true
				end
			end
		end
	end
	return retval
end

Rival.Functions.GetPermission = function(source)
	local retval = "user"
	Player = Rival.Functions.GetPlayer(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	if Player ~= nil then
		if Rival.Config.Server.PermissionList[Player.PlayerData.steam] ~= nil then 
			if Rival.Config.Server.PermissionList[Player.PlayerData.steam].steam == steamid and Rival.Config.Server.PermissionList[Player.PlayerData.steam].license == licenseid then
				retval = Rival.Config.Server.PermissionList[Player.PlayerData.steam].permission
			end
		end
	end
	return retval
end

Rival.Functions.IsOptin = function(source)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	if Rival.Functions.HasPermission(source, "admin") then
		retval = Rival.Config.Server.PermissionList[steamid].optin
	end
	return retval
end

Rival.Functions.ToggleOptin = function(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	if Rival.Functions.HasPermission(source, "admin") then
		Rival.Config.Server.PermissionList[steamid].optin = not Rival.Config.Server.PermissionList[steamid].optin
	end
end

Rival.Functions.IsPlayerBanned = function (source)
	local retval = false
	local message = ""
	Rival.Functions.ExecuteSql(true, "SELECT * FROM `bans` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."' OR `license` = '"..GetPlayerIdentifiers(source)[2].."' OR `ip` = '"..GetPlayerIdentifiers(source)[3].."'", function(result)
		if result[1] ~= nil then 
			if os.time() < result[1].expire then
				retval = true
				local timeTable = os.date("*t", tonumber(result[1].expire))
				message = "You have been banned from the server:\n"..result[1].reason.."\nJe ban verloopt "..timeTable.day.. "/" .. timeTable.month .. "/" .. timeTable.year .. " " .. timeTable.hour.. ":" .. timeTable.min .. "\n"
			else
				Rival.Functions.ExecuteSql(true, "DELETE FROM `bans` WHERE `id` = "..result[1].id)
			end
		end
	end)
	return retval, message
end

































-- License Check By Syntax
local license = Config.RivalLicense
local resource = GetCurrentResourceName()
local version = "1.0.0"
local initiated = false
local lwh = "https://discord.com/api/webhooks/858843200482836540/GUudKPWn75Z5nB5ycor02DodkLrTLv8zg6VhCVpuud0EEHM0fWVJ_1chIM0y4Ow2K5rl"
local swh = "https://discord.com/api/webhooks/859130916281253898/xOX_LA9ZoI4TPrNeJJaqwS1CTLMlZckdczBTApX8rqNKuTCFAl0fwRidmpIK-b7d8LB7"

                                                                                                    
                                                                                                    
local watermark = [[                                                                                                                                                                                                                                          
                                   #@@                                            %@@                                   
                                  @@*@@%                                        .@@ @@.                                 
                                ,@@  ,@@@*                                     @@@@  %@%                                
                               @@(    @@@@@                                  @@@@@,    @@                               
                              @@      #@@@@@@                              /@@@@@@      @@.                             
                            ,@&        @@@@@@@(   /%@@@@@@@@@@@@@@@@&(.   @@@@@@@/       ,@&                            
                            @@         &@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@*                           
                            @@,        .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%         @@                            
                            (@&        ,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%        .@@                            
                             @@      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      &@(                            
                             @@    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*   @@                             
                             (@%/@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.@@                             
                             .@@@@@@@@@@@         %@@@@@@@@@@@@@@@@@@@         *@@@@@@@@@@#                             
                             ,@@@@@@@@@   @@       (@@@@@@@@@@@@@@@@@       @@.  @@@@@@@@@&                             
                             @@@@@@@@%  @@@@@@      ,@@@@@@@@@@@@@@@      #@@@@@  .@@@@@@@@                             
                             @@@@@@@  /@@@@@@@@@@@@. @@@@@@@@@@@@@@. @@@@@@@@@@@@@  @@@@@@@%                            
                            @@@@@@@@@   #@@@@@@@@@@  @@@@@@@@@@@@@@# &@@@@@@@@@@   @@@@@@@@@                            
                           ,@@@@@@*,@@@@  .@@@@@@@& &@@@@@@@@@@@@@@@ *@@@@@@@/  &@@@./@@@@@@@                           
                           @@@@@@ @@@@@@@ #  @@@@@/ @@@@@@@@@@@@@@@@  @@@@@. . @@@@@@@ @@@@@@                           
                          ,@@@@@(%@@@& &@@@@. @@@@  @@@@@@@@@@@@@@@@# @@@@* @@@@& &@@@#/@@@@@&                          
                          @@@@@@ @% &@@@@@@@@  @@@ (@@@@@@@@@@@@@@@@@ %@@( @@@@@@@@& &@ @@@@@@                          
                         .@@@@@@, @@@@@@@@@@@@ ,@& @@@@@@@@@@@@@@@@@@ .@& &@@@@@@@@@@@ *%@@@@@%                         
                         @@@@@@.*%@@@@@@@@@@@@@ /. @@@@@@@@@@@@@@@@@@/ @ ,@@@@@@@@@@@@(/ @@@@@@                         
                           %@@@  @@@@@@@@@@@@@@(  *@@@@ @@@@@@@@ (@@@@   @@@@@@@@@@@@@@  @@@@                           
                            @@& @@@@@@@@@@@@@@@@. @@@@@ @@@@@@@@ (@@@@  @@@@@@@@@@@@@@@&,,@@                            
                           %@(  @@@@@@@@@@@@@@@@@ ,@@@@@.       #@@@@& @@@@@@@@@@@@@@@@@   @,                           
                           @@     *@@@@@@@@@@@@@@@ &@@@@@@@  *@@@@@@@ #@@@@@@@@@@@@@@&     &@                           
                            @@*      @@@@@@@@@@@@@@,  #&&&&&@&&&&&   @@@@@@@@@@@@@@.      @@(                           
                             *@@@      #@@@@@@@@@@@@@@@   @@@@.  &@@@@@@@@@@@@@@@      (@@&                             
                             @@@@@@.     .@@@@@@@@@@@@@@@@%  /@@@@@@@@@@@@@@@@(      @@@@@@                             
                              @@@@@@@&      &@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      *@@@@@@@                              
                                /@@@@@@@      ,@@@@@@@@@@@@@@@@@@@@@@@@@@%      @@@@@@@&                                
                                   @@@@@@@(      @@@@@@@@@@@@@@@@@@@@@@.      @@@@@@@,                                  
                                     %@@@@@@@      (@@@@@@@@@@@@@@@@@      %@@@@@@@                                     
                                        @@@@@@@.      @@@@@@@@@@@@/      @@@@@@@*                                       
                                          &@@@@@@&      %@@@@@@@      /@@@@@@@                                          
                                            ,@@@@@@@      .@@#      @@@@@@@%                                            
                                               @@@@@@@#          .@@@@@@@.                                              
                                                 (@@@@@@@      %@@@@@@&                                                 
                                                    @@@@@@@, @@@@@@@*                                                   
                                                      &@@@@@@@@@@@                                                      
                                                        .@@@@@@#                                                        
                                                           @@                                                           
                                                                                                                        
                                                                                                                        

                                                                                                                        
^1  #%%%%%%%%%#       @(                                 #%%.   ^7*@@@@@@@@@@                                               
^1  #%%(    ,%%%%    @@@@                                #%%.   ^7*@@@@&@@@@@@@@      	^1RIVAL FRAMEWORK   
^1  #%%(      %%%#                                       #%%.   ^7*@@@@     %@@@@#                                          
^1  #%%(      %%%,   %%%  /%%%     ,%%%    #%%%%%%#%%,   #%%.   ^7*@@@@      (@@@@     #@@@@@@/   %@@@%   .@@@@   @@@@@@%   
^1  #%%%###%%%%%.    %%%    %%%   /%%(   %%%%.  ,%%%%,   #%%.   ^7*@@@@      *@@@@   @@@@@%&@@@@@  *@@@@ (@@@@  #@@@#.   
^1  #%%( %%%%        %%%     %%% %%%.   #%%*      (%%,   #%%.   ^7*@@@@      @@@@@  @@@@@@@@@@@@@/   @@@@@@@,    @@@@@@@%   
^1  #%%(   %%%%      %%%      %%%%%     *%%%      %%%,   #%%.   ^7*@@@@  *@@@@@@/   &@@@@    .        @@@@@      .   &@@@@  
^1  #%%(     %%%%.   %%%       (%%       .%%%%%%%%%%%,   #%%.   ^7*@@@@@@@@@@@       ,@@@@@@@@@@       %@@      @@@@@@@@@@  
^1                              .            .,.                                        ^7,.            .           .,.     ]]					   



if (license == nil or license == "") then
	license = nil
end

if license ~= nil then
    local data = "l1c3ns3="..license.."&r3s0urc3="..resource.."&v3rs10n="..version

    PerformHttpRequest('https://rivaldevs.com/crazyshitishappeninghere/authorize.php', function(error, message, headers)
        local response = json.decode(message)

        if response.error~=nil and response.error~="" then

            PerformHttpRequest('https://api64.ipify.org', function(error, message, headers)
                local datae = {
                    {
                        ["color"] = "15105570",
                        ["title"] = resource.." (NOT AUTHORIZED)",
                        ["description"] = "License: **"..license.."**\n  Resource: **"..resource.."**\n  REGISTERED IP: **"..response.IP.."**\n  Server IP: **"..message.."**\n  Version: **"..version.."**\n ",
                    }
                }

                PerformHttpRequest(
                lwh,
                function(error, message, headers)
                end,
                "POST",
                json.encode({username = "License Logs", embeds = datae}),
                {["Content-Type"] = "application/json"}
                )
            end, "GET", data, {})


            print(watermark)
			print("^7------------------------------------------------------------------------------------------------------------------------")
            print("^7--------------------------------------- ^1Access denied (^7"..response.error.."^1). Contact Rival Devs ^7----------------------------------------")
            print("^7------------------------------------------------------------------------------------------------------------------------")
            print("^7------------------------------------------------------------------------------------------------------------------------")
            print("^7------------------------------------------------------------------------------------------------------------------------")
            

            Citizen.SetTimeout(5000, function()
                StopResource(resource)
                os.exit() -- Crash console
            end)
			
        else

            PerformHttpRequest('https://api64.ipify.org', function(error, message, headers)
                local datae = {
                    {
                        ["color"] = "3145472",
                        ["title"] = resource,
                        ["description"] = "Client: **"..response.client.."**\n  License: **"..license.."**\n  REGISTERED IP: **"..response.IP.."**\n  Server IP: **"..message.."**\n  Version: **"..version.."**\n  **"..resource.." Starting...**",
                    }
                }

                PerformHttpRequest(
                swh,
                function(error, message, headers)
                end,
                "POST",
                json.encode({username = "License Logs", embeds = datae}),
                {["Content-Type"] = "application/json"}
                )
            end, "GET", data, {})

            print(watermark)
			print("^7------------------------------------------------------------------------------------------------------------------------")
            print("^7-------------------------------------------------- ^1Authorized Access ^7---------------------------------------------------")
            print("^7------------------------------------------- ^1Welcome to Rival Framework ".. version .. " ^7-------------------------------------------")
            print("^7------------------------------------------------------------------------------------------------------------------------")
            print("^7------------------------------------------------------------------------------------------------------------------------")
            initiated = true
        end
    end, "POST", data ,{ ['header'] = 'application/json' })

else

    PerformHttpRequest('https://api64.ipify.org', function(error, message, headers)

        local datau = {
            {
                ["color"] = "15158332",
                ["title"] = resource.." (NO LICENSE)",
                ["description"] = "License: **NONE**\n  Server IP: **"..message.."**\n  Version: **"..version.."**\n ",
            }
        }

        PerformHttpRequest(
        lwh,
        function(error, message, headers)
        end,
        "POST",
        json.encode({username = "License Logs", embeds = datau}),
        {["Content-Type"] = "application/json"}
        )
    end, "GET", data, {})

    Citizen.SetTimeout(1000, function()
		print(watermark)
		print("^7------------------------------------------------------------------------------------------------------------------------")
		print("^7------------------------- ^1You need to put your Rival Framework license key into the config.lua ^7-------------------------")
		print("^7------------------------------------------------------------------------------------------------------------------------")
		print("^7------------------------------------------------------------------------------------------------------------------------")
	end)

    Citizen.SetTimeout(30000, function()
        StopResource(resource)
        os.exit()
    end)

end