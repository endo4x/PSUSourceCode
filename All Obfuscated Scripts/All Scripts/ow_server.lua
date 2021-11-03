--[[
	id: 5HqEIom9GTPDxv6_rPrvq
	name: ow_server
	description: ow
	time1: 2021-07-02 17:34:46.171977+00
	time2: 2021-07-02 17:34:46.171978+00
	uploader: 985LVIpBLInVI96KutWdVMrMW3ixVJuydxoWXHQm
	uploadersession: Sr6ErrYIKBGdZhZo4Snl_sxQywgUxo
	flag: f
--]]

   OW['debuglog']("Launching OVERWATCH...","LOADED","green")
   if OS['AntiResourceRestart'] then
      function ResourceProtection()
         local ResourceProtectionCooldown = false
         OW['_AddEventHandler']('onServerResourceStop', function(resourceName)
            if not ResourceProtectionCooldown then
               OW['debuglog'](string['format']("^1disabled^0 for ^3%s^0 sec.", OS['AntiResourceRestartCooldown']), "AntiResourceRestart", "yellow")
               RP_Cooldown()
            end
         end)
         OW['_AddEventHandler']('onServerResourceStart', function(resourceName)
            if not ResourceProtectionCooldown then
               OW['debuglog'](string['format']("^1disabled^0 for ^3%s^0 sec.", OS['AntiResourceRestartCooldown']), "AntiResourceRestart", "yellow")
               RP_Cooldown()
            end
         end)
   
         function RP_Cooldown()
            ResourceProtectionCooldown = true
            OW['SetTimerOut'](OS['AntiResourceRestartCooldown'],function ()
               ResourceProtectionCooldown = false
               OW['debuglog']("enabled.", "AntiResourceRestart", "green")
            end)
         end
   
         OW['_RegisterServerEvent']("OW:ResourceProtection")
         OW['_AddEventHandler']("OW:ResourceProtection", function (resources)
            local source = source
            if not ResourceProtectionCooldown then
               if OS['AntiResourceRestartExecuteMode']['DISCORD_LOG'] then
                  OW['DiscordLog'](OS['ExplosionsDiscordLog'], "AntiResourceRestart", string['format']("Tried to restarting scripts\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Script-Name**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, resources) ,  OW['_tonumber']("16722176")) 
               end
               if OS['AntiResourceRestartExecuteMode']['CHAT_LOG'] then
                  OW['ChatLog'](string['format']("(%s | %s) Tried to restarting scripts.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
               end
               if OS['AntiResourceRestartExecuteMode']['MODE'] then
                  OW['execute'](source, OS['AntiResourceRestartExecuteMode']['MODE'], "Tried to restarting scripts.")
               end
            end
         end)
      end
      OW['SetTimerOut'](OS['AntiResourceRestartCooldown'], ResourceProtection)
   end
   
   if OS['OverWatchShield'] then
      local OverwatchShield_checker = {}
      local OverWatchShield_Warnsystem = {}
      local OverwatchShield_InProcess = false
      OW['_Citizen']['CreateThread'](function()
         while true do
            OW['_Citizen']['Wait'](OS['OverWatchShieldCheckIn'])
            if not OverwatchShield_InProcess then
               OverWatchShield_ST()
            else
               OW['_Citizen']['Wait'](OW['_tonumber']("5000"))
            end
         end
      end)
      function OverWatchShield_ST()
         OverwatchShield_InProcess = true
         for _, players in ipairs(OW['_GetPlayers']()) do
            OverwatchShield_checker[OW['_tonumber'](players)] = false
            OW['_Citizen']['Wait'](OW['_tonumber']("500"))
            OW['_TriggerClientEvent']('OW:S.H.I.E.L.D', OW['_tonumber']("-1"))
         end
         OverWatchShield_CT()
      end
      function OverWatchShield_CT()
         OW['_Citizen']['CreateThread'](function()
            OW['SetTimerOut'](OW['_tonumber']("5000"), function ()
               for xPlayer, Value in pairs(OverwatchShield_checker) do
                  if not Value then
                     OverWatchShield_Warn(xPlayer)
                  end
               end
            end)
            OverwatchShield_checker = {}
            OverwatchShield_InProcess = false
         end)
      end

      OW['_RegisterServerEvent']("OW:S.H.I.E.L.D")
      OW['_AddEventHandler']("OW:S.H.I.E.L.D", function (is_alive)
         local source = source
         if type(is_alive) == "boolean" then
            if OverwatchShield_checker[source] then
               OverwatchShield_checker[source] = is_alive
            end
         else
            OW['execute'](source, "GBAN", "Tried to spoof event.")
         end
      end)

      function OverWatchShield_Warn(source)
         if OverWatchShield_Warnsystem[source] then
            local getwarn = OverWatchShield_Warnsystem['warn']
            OverWatchShield_Warnsystem['warn'] = getwarn + 1
            local WarnCount = OverWatchShield_Warnsystem['warn']
            if WarnCount >= OS['OverWatchShieldWarnCount'] then
               if OS['OverWatchShieldExecuteMode']['DISCORD_LOG'] then
                  OW['DiscordLog'](OS['ExplosionsDiscordLog'], "OverWatchShield", string['format']("Player not connect to anticheat\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Explosion-Name**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, BlacklistedExplosions[args['explosionType']]['name']) ,  OW['_tonumber']("16722176")) 
               end
               if OS['OverWatchShieldExecuteMode']['CHAT_LOG'] then
                  OW['ChatLog'](string['format']("(%s | %s) Player not connect to anticheat.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
               end
               OW['execute'](source, OS['OverWatchShieldExecuteMode']['MODE'], "Player not connect to anticheat.")
            end
         else
            OverWatchShield_Warnsystem[source] = {}
            OverWatchShield_Warnsystem['warn'] = 1
         end
         OverWatchShield_TimeOut(source)
      end
      function OverWatchShield_TimeOut(source)
         local source = source
         OW['SetTimerOut'](OS['OverWatchShieldTimeOut'],function ()
            if OverWatchShield_Warnsystem[source] then
               OverWatchShield_Warnsystem[source] = nil
            end
         end)
      end
   end

   if OS['NetEventProtection'] then
      local NetEventProtection_checker = {}
      local NetEventProtection_Warnsystem = {}
      local NetEventProtection_InProcess = false
      function GetExplosion()
         local ExplosionFind = true
         while ExplosionFind do
            local randomNumber = math['random'](OW['_tonumber']("0"), OW['_tonumber']("37"))
            if BlacklistedExplosions[randomNumber] then
               if not BlacklistedExplosions[randomNumber]['detect'] then
                  ExplosionFind = false
                  return randomNumber
               end
            end
            OW['_Citizen']['Wait'](OW['_tonumber']("200"))
         end
      end
      local NetEventProtection_Explosion = GetExplosion()
      OW['_Citizen']['CreateThread'](function()
         while true do
            OW['_Citizen']['Wait'](OS['NetEventProtectionCheckIn'])
            if not NetEventProtection_InProcess then
               NetEventProtection_ST()
            else
               OW['_Citizen']['Wait'](OW['_tonumber']("5000"))
            end
         end
      end)

      function NetEventProtection_ST()
         NetEventProtection_InProcess = true
         for _, players in ipairs(OW['_GetPlayers']()) do
            NetEventProtection_checker[OW['_tonumber'](players)] = false
            OW['_Citizen']['Wait'](OW['_tonumber']("500"))
            OW['_TriggerClientEvent']('OW:NEP', OW['_tonumber']("-1"), NetEventProtection_Explosion)
         end
         NetEventProtection_CT()
      end


      function NetEventProtection_CT()
         OW['_Citizen']['CreateThread'](function()
            OW['SetTimerOut'](OW['_tonumber']("5000"), function ()
               for xPlayer, Value in pairs(NetEventProtection_checker) do
                  if not Value then
                     NetEventProtection_Warn(xPlayer)
                  end
               end
            end)
            NetEventProtection_checker = {}
            NetEventProtection_InProcess = false
            NetEventProtection_Explosion = GetExplosion()
         end)
      end

      OW['_AddEventHandler']('explosionEvent', function(source, args)
         if args['explosionType'] == NetEventProtection_Explosion then
			   NetEventProtection_checker[source] = true
         end
		end)

      function NetEventProtection_Warn(source)
         if NetEventProtection_Warnsystem[source] then
            local getwarn = NetEventProtection_Warnsystem['warn']
            NetEventProtection_Warnsystem['warn'] = getwarn + 1
            local WarnCount = NetEventProtection_Warnsystem['warn']
            if WarnCount >= OS['NetEventProtectionWarnCount'] then
               if OS['NetEventProtectionExecuteMode']['DISCORD_LOG'] then
                  OW['DiscordLog'](OS['ExplosionsDiscordLog'], "OverWatchShield", string['format']("player tried to bypass netevent\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Explosion-Name**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, BlacklistedExplosions[args['explosionType']]['name']) ,  OW['_tonumber']("16722176")) 
               end
               if OS['NetEventProtectionExecuteMode']['CHAT_LOG'] then
                  OW['ChatLog'](string['format']("(%s | %s) player tried to bypass netevent.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
               end
               OW['execute'](source, OS['NetEventProtectionExecuteMode']['MODE'], "player tried to bypass netevent.")
            end
         else
            NetEventProtection_Warnsystem[source] = {}
            NetEventProtection_Warnsystem['warn'] = 1
         end
         NetEventProtection_TimeOut(source)
      end
      function NetEventProtection_TimeOut(source)
         local source = source
         OW['SetTimerOut'](OS['OverWatchShieldTimeOut'],function ()
            if NetEventProtection_Warnsystem[source] then
               NetEventProtection_Warnsystem[source] = nil
            end
         end)
      end
   end

   if OS['ExplosionsDetection'] then
       OW['_AddEventHandler']('explosionEvent', function (source, args)
          OW['_CancelEvent']()
          local source = source
          if not OW['IsAccess'](source, OS['AdminAccess']) then
             if BlacklistedExplosions[args['explosionType']] then
               if BlacklistedExplosions[args['explosionType']]['detect'] then
                  if OS['ExplosionsExecuteMode']['DISCORD_LOG'] then
                     OW['DiscordLog'](OS['ExplosionsDiscordLog'], "Explostion", string['format']("Tried to create blacklist explostion\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Explosion-Name**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, BlacklistedExplosions[args['explosionType']]['name']) ,  OW['_tonumber']("16722176")) 
                  end
                  if OS['ExplosionsExecuteMode']['CHAT_LOG'] then
                     OW['ChatLog'](string['format']("(%s | %s) Tried to create blacklist explostion.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
                  end
                     OW['execute'](source, OS['ExplosionsExecuteMode']['MODE'], "Tried to create blacklist explostion.")
               end
             else
                if OS['ExplosionsExecuteMode']['DISCORD_LOG'] then
                   OW['DiscordLog'](OS['ExplosionsDiscordLog'], "Explostion", string['format']("Tried to create unknown explostion\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Explosion-Name**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, BlacklistedExplosions[args['explosionType']]['name']) ,  OW['_tonumber']("16745728")) 
                end
                if OS['ExplosionsExecuteMode']['CHAT_LOG'] then
                   OW['ChatLog'](string['format']("(%s | %s) Tried to create unknown explostion.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                end
             end
          end
       end)
    end
 
    if OS['ClearPedTasks'] then
       OW['_AddEventHandler']('clearPedTasksEvent', function (source, args)
          local source = source
          if not OW['IsAccess'](source, OS['AdminAccess']) and args['immediately'] then
             OW['_CancelEvent']()
             local PlayerPed = OW['_NetworkGetEntityFromNetworkId'](args['pedId'])
                 local target = OW['_NetworkGetEntityOwner'](PlayerPed)
             if OS['ClearPedTasksExecuteMode']['DISCORD_LOG'] then
                OW['DiscordLog'](OS['DetectionDiscordLog'], "ClearPedTasks", string['format']("Tried to clear another player tasks(Freeze Player)\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Target**: ``%s | %s``",(OW['_GetPlayerName'](source) or "NONE"), source, target, (OW['_GetPlayerName'](target) or "NONE")) , OW['_tonumber']("16745728")) 
             end
             if OS['ClearPedTasksExecuteMode']['CHAT_LOG'] then
                OW['ChatLog'](string['format']("(%s | %s) Tried to clear another player tasks(Freeze Player).", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
             end
             OW['execute'](source, OS['ClearPedTasksExecuteMode']['MODE'], "Tried to clear another player tasks(Freeze Player).")
          end
       end)
    end
 
    if OS['ChatManager'] then
       local ChatManager = {
          AntiSpam = {}
       }
       function ChatTimeOut(source)
          local source = source
          OW['_Citizen']['SetTimeout'](OS['ChatSpamTimeOut'],function ()
             if ChatManager['AntiSpam'][source] then
                ChatManager['AntiSpam'][source] = nil
             end
          end)
       end
 
       function SpamChecker(source)
          local source = source
          if ChatManager['AntiSpam'][source] then
             local numberof = ChatManager['AntiSpam'][source]['number']
             ChatManager['AntiSpam'][source]['number'] = numberof + 1
             local numberof = ChatManager['AntiSpam'][source]['number']
             ChatTimeOut(source)
             if numberof >= OS['ChatSpamCount'] then
                if OS['ChatManagerClear'] then
                   OW['_TriggerClientEvent']('chat:clear', OW['_tonumber']("-1"))
                end
                if OS['ChatSpamExecuteMode']['DISCORD_LOG'] then
                   OW['DiscordLog'](OS['DetectionDiscordLog'], "Chat Spam", string['format']("Spaming in chat\n**Username**: ``%s``\n**User-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source) , OW['_tonumber']("16745728")) 
                end
                if OS['ChatSpamExecuteMode']['CHAT_LOG'] then
                   OW['ChatLog'](string['format']("(%s | %s) Tried to spam chat.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                end
                OW['execute'](source, OS['ChatSpamExecuteMode']['MODE'], "Spaming in chat.")
                return true
             end
          else
             ChatManager['AntiSpam'][source] = {}
             ChatManager['AntiSpam'][source]['number'] = OW['_tonumber']("1")
          end
          return false
       end
 
       OW['_AddEventHandler']('chatMessage', function (source, name, message)
          local source = source
          if not OW['IsAccess'](source, OS['AdminAccess']) then
            if OS['ChatSpamProtection'] then
                local ChatChecker = SpamChecker(source)
                if not ChatChecker then
                   OW['_CancelEvent']()
                end
             end
             if OS['ChatFloodProtection'] then
                if string['len'](message) >= OS['ChatFloodCount'] then
                   OW['_CancelEvent']()
                   if OS['ChatFloodExecuteMode']['DISCORD_LOG'] then
                      OW['DiscordLog'](OS['DetectionDiscordLog'], "Flood Message", string['format']("Flooding in chat\n**Username**: ``%s``\n**User-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source) , OW['_tonumber']("16745728")) 
                   end
                   if OS['ChatFloodExecuteMode']['CHAT_LOG'] then
                      OW['ChatLog'](string['format']("(%s | %s) Flooding in chat.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                   end
                   if OS['ChatManagerClear'] then
                      OW['_TriggerClientEvent']('chat:clear', OW['_tonumber']("-1"))
                   end
                   OW['execute'](source, OS['ChatFloodExecuteMode']['MODE'], "Flooding in chat.")
                end
             end
             if OS['BlacklistedWords'] then
                for k,value in pairs(OS['BlacklistedWordsTable']) do
                   if string['match'](message:lower(), value:lower()) then
                      if OS['BlacklistedWordsExecuteMode']['DISCORD_LOG'] then
                         OW['DiscordLog'](OS['DetectionDiscordLog'], "blacklisted words", string['format']("Send blacklist words in chat\n**Username**: ``%s``\n**User-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source) , OW['_tonumber']("16745728")) 
                      end
                      if OS['BlacklistedWordsExecuteMode']['CHAT_LOG'] then
                         OW['ChatLog'](string['format']("(%s | %s) Send blacklist words in chat.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                      end
                      if OS['ChatManagerClear'] then
                         OW['_TriggerClientEvent']('chat:clear', OW['_tonumber']("-1"))
                      end
                      OW['execute'](source, OS['BlacklistedWordsExecuteMode']['MODE'], "Send blacklist words in chat.")
                      return OW['_CancelEvent']()
                   end
                end
             end
          end
       end)
    end

    if OS['EventManager'] then
        if OS['EventProtection'] then
           local EventProtection = {}
           function EPW(event, source, maxwarn, warntime, target, executex, playerchecker)
            if not OW['IsAccess'](source, OS['AdminAccess']) then
                if not playerchecker then
                    if EventProtection[source] then
                       local warns = EventProtection[source]['warn']
                       EventProtection[source]['warn'] = warns + 1
                       table['insert'](EventProtection[source]['events'], {event = event})
                       if EventProtection[source]['warn'] >= maxwarn then
                          local Events = EP_Events(EventProtection[source]['events'])
                          if executex['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "EventProtector", string['format']("Getting max warn for use protected event.\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Warns**: ``%s/%s``\nUsed events: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, EventProtection[source]['warn'], maxwarn, Events) , OW['_tonumber']("16745728")) 
                          end
                          if executex['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Getting max warn for use protected event.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                          end
                          OW['execute'](source, executex['MODE'], "Getting max warn for use protected event.")
                       end
                    else
                       EventProtection[source] = {}
                       EventProtection[source]['warn'] = 1
                       EventProtection[source]['events'] = {}
                       table['insert'](EventProtection[source]['events'], {event = event})
                    end
                else
                    if EventProtection[source] then
                       local checked = EP_Checker(source, target)  
                       if not checked then
                          local warns = EventProtection[source]['warn']
                          EventProtection[source]['warn'] = warns + 1
                          table['insert'](EventProtection[source]['events'], {event = event})
                          table['insert'](EventProtection[source]['players'], {target = target})
                       end
                       if EventProtection[source]['warn'] >= maxwarn then
                          local Events = EP_Events(EventProtection[source]['events'])
                          if executex['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "EventProtector", string['format']("Getting max warn for use protected event.\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Warns**: ``%s/%s``\nUsed events: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, EventProtection[source]['warn'], maxwarn, Events) , OW['_tonumber']("16745728")) 
                          end
                          if executex['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Getting max warn for use protected event.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                          end
                          OW['execute'](source, executex['MODE'], "Getting max warn for use protected event.")
                       end
                    else
                       EventProtection[source] = {}
                       EventProtection[source]['warn'] = 1
                       EventProtection[source]['players'] = {}
                       EventProtection[source]['events'] = {}
                       table['insert'](EventProtection[source]['events'], {event = event})
                       table['insert'](EventProtection[source]['players'], {target = target})
                    end
                end
                EP_Clear(source, warntime)
            end
           end
  
           function EP_Checker(source, target)
              local players = EventProtection[source]['players'] 
              if not players then return end
              for k,v in pairs(players) do
                 if v['target'] == target then
                    return true
                 end
              end
              return false
           end
  
           function EP_Events(table)
              local main = ""
              for k,v in pairs(table) do
                 main = main + "\n"
              end
              return main
           end
  
           function EP_Clear(source, warntime)
              local source = source
              OW['_Citizen']['SetTimeout'](warntime,function ()
                 if EventProtection[source] then
                    EventProtection[source] = nil
                 end
              end)
           end
  
           local function EventProtection(Method, Data)
              OW["_RegisterServerEvent"](Data['EventName'])
              if Method['WhitelistOnly'] then
                 OW['_AddEventHandler'](Data['EventName'], function ()
                    local source = source
                    if not OW['IsAccess'](source, OS['AdminAccess']) then
                       EPW(Data['EventName'], source, Data['MaxWarn'], Data['WarnTimeOut'], 0, Data['ExecuteMode'], false)
                    end
                 end)
              elseif Method['PlayerChecker'] then
                 OW['_AddEventHandler'](Data['EventName'], function (...)
                    local source = source
                    local Players = {}
                    local SelectKey = false
                    local IsTable = OW['TableChecker'](...)
                    if #IsTable >= 1 then
                       for k,v in pairs(IsTable) do
                          if v['type'] == "number" and not SelectKey then
                             SelectKey = true
                             EPW(Data['EventName'], source, Data['MaxWarn'], Data['WarnTimeOut'], v['value'], Data['ExecuteMode'], true)
                          end
                       end
                    end
                 end)
              elseif Method['StringChecker'] then
                 OW['_AddEventHandler'](Data['EventName'], function (...)
                    local source = source
                    local IsTable = OW['TableChecker'](...)
                    if #IsTable >= 1 then
                       for k,v in pairs(EventManager['EventProtector']['BlacklistedString']) do
                          for _,m in pairs(IsTable) do
                             local mval = OW['_tostring'](m['value'])
                             if string['match'](mval:lower(), v:lower()) then
                                EPW(Data['EventName'], source, Data['MaxWarn'], Data['WarnTimeOut'], 0, Data['ExecuteMode'], false)
                             end
                          end
                       end
                    end
                 end)
              elseif Method['DistanceChecker'] then
                 OW['_AddEventHandler'](Data['EventName'], function (...)
                    local source = source
                    local Target = 0
                    local SelectKey = false
                    local IsTable = OW['TableChecker'](...)
                    if #IsTable >= 1 then
                       for k,v in pairs(IsTable) do
                          if v['type'] == "number" and not SelectKey then
                             Target = v['value']
                             SelectKey = true
                             break
                          end
                       end
                       local sourcePed = OW['_GetPlayerPed'](source)
                       local sourceCoords = OW['_GetEntityCoords'](sourcePed)
                       local targetPed = OW['_GetPlayerPed'](Target)
                       local targetCoords = OW['_GetEntityCoords'](targetPed)
                       local basecoords = sourceCoords - targetCoords
                       if #basecoords > Data['Distance'] then
                          EPW(Data['EventName'], source, Data['MaxWarn'], Data['WarnTimeOut'], 0, Data['ExecuteMode'], false)
                       end
                    end
                 end)
              end
           end
           for k,v in pairs(EventManager['EventProtector']) do
              if k ~= "BlacklistedString" then
                EventProtection(v['Methods'], v)
              end
           end
        end
    end
    if OS['EventDetection'] then
        for k,v in pairs(EventManager['EventDetection']) do
           OW['_RegisterServerEvent'](v)  
           OW['_AddEventHandler'](v, function()
              OW['_CancelEvent']()
              local source = source
              if OS['EventDetectionExecuteMode']['DISCORD_LOG'] then
                 OW['DiscordLog'](OS['DetectionDiscordLog'], "EventDetection", string['format']("Tried to use detected event\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Even-name**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, v) , OW['_tonumber']("16745728")) 
              end
              if OS['EventDetectionExecuteMode']['CHAT_LOG'] then
                 OW['ChatLog'](string['format']("(%s | %s) Tried to use detected event.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
              end
              OW['execute'](source, OS['EventDetectionExecuteMode']['MODE'], string['format']("Tried to use detected event.\nEvent-name: %s", v))
           end)
        end
    end
    if OS['EntitiesManager'] then
        OW['_AddEventHandler']('entityCreating', function(entity)
           local entity = entity
           if not OW['_DoesEntityExist'](entity) then return end
           local source = OW['_NetworkGetEntityOwner'](entity)
           local GModel = OW['_GetEntityModel'](entity)
           local GType   = OW['_GetEntityType'](entity)
           if not OW['IsAccess'](source, OS['AdminAccess']) then
              if GType == OW['_tonumber']("1") then
                 if OS['EntitiesPedsDetection'] then
                    if OS['EntitiesPedsMethod'] == OW['_tonumber']("1") then
                       if not EntitiesManager['Peds'][GModel] then
                          OW['_CancelEvent']()
                          if OS['EntitiesPedsExecuteMode']['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "Entities Manager", string['format']("Tried to Spawn ped which is not Whitelist\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Model-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, GModel) , OW['_tonumber']("16745728")) 
                          end
                          if OS['EntitiesPedsExecuteMode']['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Tried to Spawn ped which is not Whitelist.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
                          end
                          OW['execute'](source, OS['EntitiesPedsExecuteMode']['MODE'], "Tried to Spawn ped which is not Whitelist")
                       end
                    elseif OS['EntitiesPedsMethod'] == OW['_tonumber']("2") then
                       if EntitiesManager['Peds'][GModel] then
                          OW['_CancelEvent']()
                          if OS['EntitiesPedsExecuteMode']['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "Entities Manager", string['format']("Tried to spawn blacklisted ped\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Ped-name**: ``%s``\n**Model-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, (EntitiesManager['Peds'][GModel]['name'] or "NONE"), GModel) , OW['_tonumber']("16745728")) 
                          end
                          if OS['EntitiesPedsExecuteMode']['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Tried to spawn blacklisted ped.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
                          end
                          OW['execute'](source, OS['EntitiesPedsExecuteMode']['MODE'], string['format']("Tried to spawn blacklist ped.\nPed-name: %s", (EntitiesManager['Peds'][GModel]['name'] or "NONE")))
                       end
                    end
                 end
              elseif GType == OW['_tonumber']("2") then
                 if OS['EntitiesVehiclesDetection'] then
                    if OS['EntitiesVehiclesMethod'] == OW['_tonumber']("1") then
                       if not EntitiesManager['Vehicles'][GModel] then
                          OW['_CancelEvent']()
                          if OS['EntitiesVehiclesExecuteMode']['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "Entities Manager", string['format']("Tried to Spawn vehicle which is not Whitelist\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Model-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, GModel) , OW['_tonumber']("16745728")) 
                          end
                          if OS['EntitiesVehiclesExecuteMode']['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Tried to Spawn vehicle which is not Whitelist.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
                          end
                          OW['execute'](source, OS['EntitiesVehiclesExecuteMode']['MODE'], "Tried to Spawn vehicle which is not Whitelist")
                       end
                    elseif OS['EntitiesVehiclesMethod'] == OW['_tonumber']("2") then
                       if EntitiesManager['Vehicles'][GModel] then
                          OW['_CancelEvent']()
                          if OS['EntitiesVehiclesExecuteMode']['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "Entities Manager", string['format']("Tried to spawn blacklisted vehicle\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Vehicle-name**: ``%s``\n**Model-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, (EntitiesManager['Vehicles'][GModel]['name'] or "NONE"), GModel) , OW['_tonumber']("16745728")) 
                          end
                          if OS['EntitiesVehiclesExecuteMode']['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Tried to spawn blacklisted vehicle.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
                          end
                          OW['execute'](source, OS['EntitiesVehiclesExecuteMode']['MODE'], string['format']("Tried to spawn blacklist vehicle.\nVehicle-name: %s", (EntitiesManager['Vehicles'][GModel]['name'] or "NONE")))
                       end
                    end
                 end
              elseif GType == OW['_tonumber']("3") then
                 if OS['EntitiesObjectsDetection'] then
                    if OS['EntitiesObjectsMethod'] == OW['_tonumber']("1") then
                       if not EntitiesManager['Objects'][GModel] then
                          OW['_CancelEvent']()
                          if OS['EntitiesObjectsExecuteMode']['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "Entities Manager", string['format']("Tried to Spawn object which is not Whitelist\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Model-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, GModel) , OW['_tonumber']("16745728")) 
                          end
                          if OS['EntitiesObjectsExecuteMode']['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Tried to Spawn object which is not Whitelist.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
                          end
                          OW['execute'](source, OS['EntitiesObjectsExecuteMode']['MODE'], "Tried to Spawn object which is not Whitelist.")
                       end
                    elseif OS['EntitiesObjectsMethod'] == OW['_tonumber']("2") then
                       if EntitiesManager['Objects'][GModel] then
                          OW['_CancelEvent']()
                          if OS['EntitiesObjectsExecuteMode']['DISCORD_LOG'] then
                             OW['DiscordLog'](OS['DetectionDiscordLog'], "Entities Manager", string['format']("Tried to spawn blacklisted object\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Object-name**: ``%s``\n**Model-ID**: ``%s``",(OW['_GetPlayerName'](source) or "NONE"), source, (EntitiesManager['Objects'][GModel]['name'] or "NONE"), GModel) , OW['_tonumber']("16745728")) 
                          end
                          if OS['EntitiesObjectsExecuteMode']['CHAT_LOG'] then
                             OW['ChatLog'](string['format']("(%s | %s) Tried to spawn blacklisted object.", source, (OW['_GetPlayerName'](source) or "NONE")), "red", true)
                          end
                          OW['execute'](source, OS['EntitiesObjectsExecuteMode']['MODE'], string['format']("Tried to spawn blacklist object.\nObject-name: %s", (EntitiesManager['Objects'][GModel]['name'] or "NONE")))
                       end
                    end
                 end
              end
           end
        end)
  
        local SProtect = {
           Peds = {},
           Vehciles = {},
           Objects = {}
        }
        function SpamProtection(source, entity, model, max_warn, time_out, detection, executemode, protected)
           if not SProtect[protected][source] then
              SProtect[protected][source] = {}
              table['insert'](SProtect[protected][source], { model = model , entity = entity})
           else
              table['insert'](SProtect[protected][source], { model = model , entity = entity})
           end
           local getwarn = 0
           for k,v in pairs(SProtect[protected][source]) do
              if not detection then
                 if v['model'] == model then
                    getwarn = getwarn + 1
                 end
              else
                 getwarn = getwarn + 1
              end
           end
           if getwarn >= max_warn then
              if not SProtect[protected][source] then return end
              for k,v in pairs(SProtect[protected][source]) do
                 if not OW['_DoesEntityExist'](v['entity']) then return end
                 local NetID = OW['_NetworkGetNetworkIdFromEntity'](v['entity'])
                 local GEntity = OW['_NetworkGetEntityFromNetworkId'](NetID)
                 OW['_DeleteEntity'](GEntity)
              end
              SProtect[protected][source] = nil
              if executemode['DISCORD_LOG'] then
                 OW['DiscordLog'](OS['DetectionDiscordLog'], "Spam Protection", string['format']("Tried to spam %s\n**Username**: ``%s``\n**User-ID**: ``%s``", protected, (OW['_GetPlayerName'](source) or "NONE"), source) , OW['_tonumber']("16745728")) 
              end
              if executemode['CHAT_LOG'] then
                 OW['ChatLog'](string['format']("(%s | %s) Tried to spam %s.", source, (OW['_GetPlayerName'](source) or "NONE"), protected), "red", true)
              end
              OW['execute'](source, executemode['MODE'], string['format']("Tried to spam %s.", protected))
           end
           CleanSpam(SProtect[protected][source], time_out)
        end
  
        function CleanSpam(player_table, time_out)
           OW['_Citizen']['SetTimeout'](time_out, function()
              if player_table then player_table = nil end
           end)
        end
  
        OW['_AddEventHandler']('entityCreating', function(entity)
           local entity = entity
           if not OW['_DoesEntityExist'](entity) then return end
           local source = OW['_NetworkGetEntityOwner'](entity)
           local GModel = OW['_GetEntityModel'](entity)
           local GType   = OW['_GetEntityType'](entity)
           if not OW['IsAccess'](source, OS['AdminAccess']) then
              if GType == OW['_tonumber']("1") then
                 if OS['PedSpamProtection'] then
                    SpamProtection(source, entity, GModel, OS['PedSpamMaxCount'], OS['PedSpamTimeOut'], OS['RandomPedSpamDetection'], OS['PedSpamExecuteMode'], "Peds")
                 end
              elseif GType == OW['_tonumber']("2") then
                 if OS['VehicleSpamProtection'] then
                    SpamProtection(source, entity, GModel, OS['VehicleSpamMaxCount'], OS['VehicleSpamTimeOut'], OS['RandomVehicleSpamDetection'], OS['VehicleSpamExecuteMode'], "Vehciles")
                 end
              elseif GType == OW['_tonumber']("3") then
                 if OS['ObjectSpamProtection'] then
                    SpamProtection(source, entity, GModel, OS['ObjectSpamMaxCount'], OS['ObjectSpamTimeOut'], OS['RandomObjectSpamDetection'], OS['ObjectSpamExecuteMode'], "Objects")
                 end
              end
           end
        end)
    end
    if OS['WeaponManager'] then
        if OS['giveWeaponDetection'] then
           OW['_AddEventHandler']('giveWeaponEvent', function (source, args)
              OW['_CancelEvent']()
              local source = source
              if not OW['IsAccess'](source, OS['AdminAccess']) then
                 local PlayerPed = OW['_NetworkGetEntityFromNetworkId'](args['pedId'])
                     local target = OW['_NetworkGetEntityOwner'](PlayerPed)
                 if OS['giveWeaponExecuteMode']['DISCORD_LOG'] then
                    OW['DiscordLog'](OS['DetectionDiscordLog'], "giveWeaponDetection", string['format']("Tried give weapon to another player\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Target**: ``%s | %s``",(OW['_GetPlayerName'](source) or "NONE"), source, target, (OW['_GetPlayerName'](target) or "NONE")) , OW['_tonumber']("16745728")) 
                 end
                 if OS['giveWeaponExecuteMode']['CHAT_LOG'] then
                    OW['ChatLog'](string['format']("(%s | %s) Tried give weapon to another player.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                 end
                 OW['execute'](source, OS['giveWeaponExecuteMode']['MODE'], "Tried give weapon to another player.")
              end
           end)
        end
        if OS['removeWeaponDetection'] then
         OW['_AddEventHandler']('removeWeaponEvent',function (source, args)
              OW['_CancelEvent']()
              local source = source
              if not OW['IsAccess'](source, OS['AdminAccess']) then
                 local PlayerPed = OW['_NetworkGetEntityFromNetworkId'](args['pedId'])
                     local target = OW['_NetworkGetEntityOwner'](PlayerPed)
                 if OS['removeWeaponExecuteMode']['DISCORD_LOG'] then
                    OW['DiscordLog'](OS['DetectionDiscordLog'], "RemoveWeaponDetection", string['format']("Tried remove weapon to another player\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Target**: ``%s | %s``",(OW['_GetPlayerName'](source) or "NONE"), source, target, (OW['_GetPlayerName'](target) or "NONE")) , OW['_tonumber']("16745728")) 
                 end
                 if OS['removeWeaponExecuteMode']['CHAT_LOG'] then
                    OW['ChatLog'](string['format']("(%s | %s) Tried remove weapon to another player.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                 end
                 OW['execute'](source, OS['removeWeaponExecuteMode']['MODE'], "Tried remove weapon to another player.")
              end
           end)
           if OS['removeAllWeaponDetection'] then
            OW['_AddEventHandler']('removeAllWeaponsEvent',function (source, args)
                 OW['_CancelEvent']()
                 local source = source
                 if not OW['IsAccess'](source, OS['AdminAccess']) then
                    local PlayerPed = OW['_NetworkGetEntityFromNetworkId'](args['pedId'])
                    local target = OW['_NetworkGetEntityOwner'](PlayerPed)
                    if OS['removeWeaponExecuteMode']['DISCORD_LOG'] then
                       OW['DiscordLog'](OS['DetectionDiscordLog'], "RemoveWeaponDetection", string['format']("Tried remove weapon to another player\n**Username**: ``%s``\n**User-ID**: ``%s``\n**Target**: ``%s | %s``",(OW['_GetPlayerName'](source) or "NONE"), source, target, (OW['_GetPlayerName'](target) or "NONE")) , OW['_tonumber']("16745728")) 
                    end
                    if OS['removeWeaponExecuteMode']['CHAT_LOG'] then
                       OW['ChatLog'](string['format']("(%s | %s) Tried remove weapon to another player.", source, (OW['_GetPlayerName'](source) or "NONE")), "orange", true)
                    end
                    OW['execute'](source, OS['removeWeaponExecuteMode']['MODE'], "Tried remove weapon to another player.")
                 end 
              end)
           end
        end
    end