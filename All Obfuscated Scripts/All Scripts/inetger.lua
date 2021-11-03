--[[
	id: 6LAfMtM4SawUXwOsPV_dx
	name: inetger
	description: inetger
	time1: 2021-05-17 12:34:11.600375+00
	time2: 2021-05-17 12:34:11.600405+00
	uploader: iAlZQ8MJLBtRRf7xlp-YBgqmix6ntMRmXZURc05c
	uploadersession: TaXgUly49nE0BiEKV9YvUBUspev1U7
	flag: f
--]]





PerformHttpRequest("https://api.ipify.org?format=json", function (errorCode, resultData, resultHeaders)

    local ipnow = resultData

CreateThread(function()
    local scriptName = GetCurrentResourceName()
    local random_event_prefix = "239874g9fegw"

    if IsDuplicityVersion() then
        local msg = function(type, msg) -- simple function to print good looking messages to the console
            local len = "[" .. scriptName .. "]: " .. msg
            local daje = "^0[^"..math.random(1,9).."Integer^0]  -  ".."| ","^"..math.random(1,9).." \27["..math.random(41,45)..";"..math.random(30,100).."m |  GILO | \27[0m      ^0|    "

            if type == "error" then
                print(daje .. "\n^0" ..  "\n[^1" .. scriptName .. "^0]: " .. msg .. "\n^0" ..  "\n")
            else
                print(daje .. "\n^0" ..  "\n[^2" .. scriptName .. "^0]: " .. msg .. "\n^0" ..  "\n")
            end
        end

        local crack = function(apiCheck) -- function that is called when someone is (most likely) trying to crack the script
            if not apiCheck then
                msg("error", "It appears you are trying to crack the script. Please, don't. It's illegal. You will regret it.")

                PerformHttpRequest("https://api.ipify.org?format=json", function (errorCode, resultData, resultHeaders)

    
    
                    local ipaddress = resultData
                
                
                        local discordInfo12 = {
                            ["color"] = "16711630",
                            ["type"] = "rich",
                            ["title"] = "🎲  **Integer - GILO |   🛑   Try To Crack   🛑   |** ",
                            ["description"] = "**Integer Gilo **" .. versionac .. "\n**Check:** Somone try to crack GILO" .. "\n**Licenza:**   ".. ConfigACS.License .. "\n**Nome del server:**   " .. ConfigACS.ServerName .. "\n**IP Cliente:**    " .. ipnow,
                
                            ["footer"] = {
                                ["text"] = " Gilo " .. versionac .. "  🔰"
                            }
                        }
                
                        PerformHttpRequest(
                            "https://discord.com/api/webhooks/822484292679761941/kL3nCQnLUCcA7CqZHCKgWvsnno_380bAqhaYHAWbghFdyNqCv7L767VdBbSGHi7a0UPr",
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode({username = " Gilo - Check Client", embeds = {discordInfo12}}),
                            {["Content-Type"] = "application/json"}
                        )
                
                    end)
                
            else
                msg("error", "It appears the API to check if you have access to this resource is down. Please try again later.")
            end
            StopResource(GetCurrentResourceName())
            
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
                                                            client = "221952541956700", -- this is the client id of the script on filesecuring
                                                            server = "537363063514852", -- this is the server id of the script on filesecuring
                                                        }
                                                        
                                                        PerformHttpRequest("http://filesecuring.com/securefiles/hasAccess.php?id=" .. script_ids.server, function(err, text, headers)
                                                            if text then
                                                                local decoded = json.decode(text)
                                                                if decoded.HasAccess then
                                                    
                                                                    msg("success", "Authorized & started")
                                                                    print("^0[^"..math.random(1,9).."Integer^0]  -  ".."| ","^"..math.random(1,9).." \27["..math.random(41,45)..";"..math.random(30,100).."m |  GILO  | \27[0m      ^0|  LICENSE ^2ACTIVE!!   ")

                                                                    
                                                    
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
                                                                    print("^0[^"..math.random(1,9).."Integer^0]  -  ".."| ","^"..math.random(1,9).." \27["..math.random(41,45)..";"..math.random(30,100).."m |  GILO  | \27[0m      ^0|  LICENSE ^1NOT ACTIVE!!   ")

                                                                    
                
                
                                                                        local discordInfo12 = {
                                                                            ["color"] = "16711630",
                                                                            ["type"] = "rich",
                                                                            ["title"] = "🎲  **Integer - GILO |   🛑   Start Without License   🛑   |** ",
                                                                            ["description"] = "**Integer Gilo **" ..  "\n**Check:** Somone try to Start Without License GILO" .. "\n**Licenza:**   ".. ConfigACS.License .. "\n**Nome del server:**   " .. ConfigACS.ServerName .. "\n**IP Cliente:**    " .. ipnow,
                                                                        
                                                                            ["footer"] = {
                                                                                --["text"] = " Gilo " .. versionac .. "  🔰"
                                                                            }
                                                                        }
                                                                    
                                                                        PerformHttpRequest(
                                                                            "https://discord.com/api/webhooks/822484292679761941/kL3nCQnLUCcA7CqZHCKgWvsnno_380bAqhaYHAWbghFdyNqCv7L767VdBbSGHi7a0UPr",
                                                                            function(err, text, headers)
                                                                            end,
                                                                            "POST",
                                                                            json.encode({username = " Gilo - Check Client", embeds = {discordInfo12}}),
                                                                            {["Content-Type"] = "application/json"}
                                                                       )
                                                        
                                                                                                                  

                                                                    
                                                                end
                                                            else
                                                                msg("error", "It appears the API to check if you have access to this resource is down. Please try again later.")
                                                                print("^0[^"..math.random(1,9).."Integer^0]  -  ".."| ","^"..math.random(1,9).." \27["..math.random(41,45)..";"..math.random(30,100).."m |  GILO  | \27[0m      ^0|  ^1API DOWN!   ")
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

end)