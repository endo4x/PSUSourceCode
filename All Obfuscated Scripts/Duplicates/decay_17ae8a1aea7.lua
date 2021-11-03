--[[
	id: KFjyGDH04itxQXciYT4zg
	name: decay
	description: d
	time1: 2021-07-16 07:36:42.443277+00
	time2: 2021-07-16 07:36:42.443277+00
	uploader: 9DSq9MGcFn0-ljRVjxoMnfdlddZ34DzsGi7O3bvr
	uploadersession: gIE-RfJBN6h8XPU0m8mSwBsvp6tI90
	flag: f
--]]

local schar = string.char

local prefix = "4f0dd0ab86b6dc6110caaa744d38983c38a3149a526cbc2ae1"

local scripts = {
    {
        "key",
        "server",
        505688398481997,
        "41869ff72250d9990a13199ae08d43bc5334b9fd8ed26ef9f305d90e51f5ccf8ce586db8ca60852a8d328459a705eafe06fac54db00a2f63cbe843c87695f8773cd473ac2b491472686922eee1f9bcd67e8058c0f6ca182ad53674b29068bd2f0a76c267c3544264926a68216b69ffbe7ac37721795afb0b3d9813d2cdeb2c5912f4fa97ffc6f2488e6da2b287dd9fa00797349dceee01d1e61e7ce6de9dc269b7f03628a16b9fadbca789b96922a97a3800924b9c84f903612bc24911956a561e01c3952aebda359805ec61afd63b78e777390ba84fef78c8cf944b6209fb74729f97d64a522ea23101aba6baa9b96a8ce83a1795a30852eba26dbf44ac387f4dfc3db53d4d39bad0c32d91a5f2dcc90745a334cfed54e314cfaae65a20a2a6c48dc199949a527d7fdbbf205a37a4b34e8518b887dc90a20fa913473c32da82d440706ea55cd9fc1567fc398df94ac0d74a7a17f519eb395b74241b4d0f1999eda7bc38782740fe8699983d700a6f7f85ca70d4394d41d087416f8bffb71cef9e7c103b34274b1cf133f09eae259bef5635eee57b1fb6a1a01d33121f636aeb5fcab88da5850155ca0a76898f5476877078f5be778a9b2a1d8902ea0f1199c9da7401393d364ebe9a962079e0e0fafb6504595858942c3da0b527d2cde27a4869935198aeb1ac8bd9c4ca1b799aa076656894f6af2b6ee22707e8b89e85723e29791ef39b232fb2485af51861848328229962d8d304b38dcc9a99bf6f740a340410a5d606b503c743f30edbc0fb5b26b2076e63cc42934fe66138564c8c6799a94feb2a4cfd88f98a06e9d8e33deed14a756aed0bd5bd86d98cfaa6521a2f66b4ab35aa22636189fdbf0c8223750d1d81ba2e52f48ec9676420e055c7e8eef3a1053da019ed95733dc15042669ac308152c88f1aba6ea0eb0e0aa8f3de9249f87bacfbe7f831088b6022076eb46ad00c8524ee187809f7e511240346a58057d84d24f2768e2a83c2437e6217aca5f821bed42cf882e0b1a27e428bf07dc7272fa20300f7b93475b589fcbe2f3651b9102d7e29b0fadea09f705600402bb24a346fd969e936fda45605e194a92796451d5a5d7e1a4ef3dda60ef5c6beb91bd36b937eeae2fd0d0c0f471798eade52ae131915ab709e102495e7cce82abb4591c3db0f4e7a659178bfd9fd24d336ecaa7b4abd2d9d2bd6bbe66f2692c0f3b2adade6e45827866bef660d4fa5c7b6050bdbece659599c1cb4bef557e889eb7695fb01f212c10813d593712eae4d9b003d09f421d4721bf0d12ee86016b26fc4446c7dde923efe66b1210ebc0ad4342ab8528c4118dbc635c0cac3c0c296da2e8aa742acc11cff35f3415ad38616aaf6c6c153855dfb1da3674de8757bf042fabd070917b7192f51ef88a75a5523cb77d22d1110db1eafc3719ae90a3cae2497969446ef952dca9b9fabecc9a42492051ab51966924a2ca27efbff6fd7bada5f57fd938966cacd59c3d4785544f032f49720064eda2da405968c4593553eadff8ce6522df7395be2da9ab42bb953ae82932b1a93597e64ded64403084467e44f45a1910865fdd5ddd8ba3c9e55ace4e7390eddd52c51783aa6fac2a9088f1c822670dc591360b3b21ffda389e94b731aa69e01dee03a4514c764ca89483d94c7ae770c68cd80ba1660840fa6aa5f3ffd043cdca8aebe66b8d5fda3eb84e9318047f056d7765d1baf06f343d39a9e498b288adbe88dcb56488d2f8c092d583fb6ed15036383110515651f8d349b359afc06ad5fe048547c53d9c4c679e9c6cba33225488a44f1b64f64b9b7b57d1b28a91680073fc5ede376890c19857b87c0765fdf05c9a657a9e8d9c76803a6ee08a4d19"
    }
}

-- secret message for people dumping stuff
local text_thing_for_dump = {
    "hey, you!",
    "yes, you.",
    "you know who i am talking to.",
    "what you are doing is illegal.",
    "like, for real illegal.",
    "i will dmca the shit out of your discord / website / github whatever you choose to do with this.",
    "also, please note that this file is copyrighted.",
    "sharing it is illegal.",
    "hey",
    "do you have any friends?",
    "i have this strange feeling you are bullied"
}

local cracker = false
local oldtrace = Citizen.Trace
local started = false
local xload = load

msg = function(msg_type, txt)
    print(string.format("^%s%s: ^0%s", msg_type == "error" and "1" or "2", GetCurrentResourceName(), txt))
end

local load_thread = function()
    if IsDuplicityVersion() then -- server or client?
        -- server
        while not LicenseKeys do
            Wait(500)
        end
        
        msg("success", "Starting..")

        if cracker == false and _G.cracker == nil then
            if type(LicenseKeys) == "table" then
                local requests = {}
                local filesecuring_http_request = function(url, cb, method, data, headers)
                    local data = json.encode({
                        url = url,
                        method = method or "GET",
                        data = data or "",
                        headers = headers or {}
                    })

                    local request = Citizen.InvokeNative(0x8e8cc653, data, string.len(data), Citizen.ReturnResultAnyway(), Citizen.ResultAsInteger())

                    requests[request] = cb
                end
                AddEventHandler("__cfx_internal:httpResponse", function(request, status, body, headers)
                    if requests[request] then
                        requests[request](status, body, headers)
                    end
                end)

                local cl_load = {}
                filesecuring_http_request("https://filesecuring.com/securefiles/hasAccessLicense.php?why_are_you_cracking_my_stuff_you_idiot", function(x, y)
                    if y then
                        local decoded = json.decode(y or "{}")
                        if decoded and decoded.HasAccess == false and decoded.IP then
                            filesecuring_http_request("https://discord.com/?why_are_you_cracking_my_stuff_you_idiot", function(x, y)
                                if y then
                                    for k, v in pairs(scripts) do
                                        local script_name, script_type, script_id, script_code = table.unpack(v)
                                        local license = LicenseKeys[script_name]
                                        script_id = math.floor(script_id)

                                        if license and type(license) == "string" then

                                            local load_script = function(y)
                                                local code = ""
                                                for char in string.gmatch(y, "([^\\]+)") do 
                                                    code = code .. schar(tonumber(char))
                                                end

                                                if tonumber(code) then
                                                    local function decode(str)
                                                        local K, F = script_id, math.floor(16384) + tonumber(code)
                                                        return (str:gsub('%x%x', function(c)
                                                            local L = K % math.floor(274877906944)  -- 2^38
                                                            local H = (K - L) / math.floor(274877906944)
                                                            local M = H % math.floor(128)
                                                            c = tonumber(c, math.floor(16))
                                                            local m = (c + (H - M) / math.floor(128)) * (math.floor(2)*M + math.floor(1)) % math.floor(256)
                                                            K = L * F + H + c + m
                                                            
                                                            return schar(m)
                                                        end))
                                                    end

                                                    if script_type == "server" and not cracker then
                                                        xload(decode(script_code))()
                                                    elseif script_type == "client" then
                                                        table.insert(cl_load, decode(script_code))
                                                    end
                                                end
                                            end

                                            filesecuring_http_request("https://filesecuring.com/securefiles/hasAccessLicense.php?id=" .. script_id .. "&license=" .. license, function(x, y)
                                                if y and type(y) == "string" then
                                                    local decoded = json.decode(y) 
                                                    if decoded then
                                                        if decoded.HasAccess and decoded.IP then
                                                            filesecuring_http_request("https://filesecuring.com/securefiles/loadLicense.php?id=" .. script_id .. "&license=" .. license, function(x, y)
                                                                if y and type(y) == "string" then
                                                                    load_script(y)
                                                                end
                                                            end)
                                                        else
                                                            filesecuring_http_request("https://filesecuring.com/securefiles/hasAccess.php?id=" .. script_id, function(x, y)
                                                                if y and type(y) == "string" then
                                                                    local decoded = json.decode(y) 
                                                                    if decoded then
                                                                        if decoded.HasAccess and decoded.IP then
                                                                            filesecuring_http_request("https://filesecuring.com/securefiles/get.php?id=" .. script_id, function(x, y)
                                                                                if y and type(y) == "string" then
                                                                                    load_script(y)
                                                                                end
                                                                            end)
                                                                        else
                                                                            msg("error", "You do not have access to this script (" .. script_name .. "). Your license key might be invalid, or you recently switched ip address. IP addresses take up to 24 hours to reset.")
                                                                        end
                                                                    end
                                                                end
                                                            end)
                                                        end
                                                    else
                                                        msg("error", "API is down, try again later")
                                                    end
                                                else
                                                    msg("error", "API is down, try again later")
                                                end
                                            end)

                                            started = true
                                        end
                                    end
                                else
                                    msg("error", "Discord is down, try again later")
                                end
                            end)
                        else
                            msg("error", "It appears you are trying to crack this script.\nIf you are; good luck.\nIf you aren't; please message ^4wsh#4351#7785^0 on discord.")
                        end
                    else
                        msg("error", "API is down, try again later")
                    end
                end)

                RegisterNetEvent(prefix .. "server-request")
                AddEventHandler(prefix .. "server-request", function()
                    TriggerClientEvent(prefix .. "client-load", source, cl_load)
                end)

                msg("success", "Started.")
            else
                msg("error", "No license keys provided")
            end
        else
            msg("error", "It appears you are trying to crack this script.\nIf you are; good luck.\nIf you aren't; please message ^4wsh#4351#7785^0 on discord.")
            msg("error", "As a security measure, your license keys have been deleted.")
        end
    else
        -- client
        RegisterNetEvent(prefix .. "client-load")
        AddEventHandler(prefix .. "client-load", function(code)
            for k, v in pairs(code) do
                CreateThread(function()
                    load(v)()
                end)
            end
        end)

        CreateThread(function()
            while not NetworkIsSessionStarted() do
                Wait(500)
            end

            Wait(10000)
            TriggerServerEvent(prefix .. "server-request")
        end)
    end
end

CreateThread(function()
    if IsDuplicityVersion() then
        local start = os.clock()
        while os.clock() - start <= 10 do
            Wait(50)
            if cracker then
                if os and os.exit and type(os.exit) == "function" then
                    os.exit()
                end
                while true do
                    msg("error", "It appears you are trying to crack this script.\nIf you are; good luck.\nIf you aren't; please message ^4wsh#4351#7785^0 on discord.")
                    CreateThread(function()
                        while true do
                            for i = 1, 1000 do
                                _G[tostring(math.random(10^100))] = math.random(10^50)
                            end
                        end
                    end)
                end
            end
        end
    end
end)

CreateThread(function()
    if IsDuplicityVersion() then
        local checks = {
            print, error, oldtrace, load, tonumber,
            io.write, Citizen.InvokeNative, string.gmatch, schar, table.insert, json.decode, math.floor, json.encode, string.len, 
        }

        local loaded_check = false

        CreateThread(function()
            while not started do
                Wait(0)
                Citizen.Trace = function(err)
                    if err and type(err) == "string" and string.find(err, "assertion failed") then
                        cracker = true
                        print("did you really think that was gonna work?")
                    end
                end        

                if _G.xload then
                    cracker = true
                    break
                elseif xload ~= load then
                    cracker = true
                    break
                elseif _G.schar then
                    cracker = true
                end

                loaded_check = true
            end
            if _G.started then
                cracker = true
            end
        end)

        while not loaded_check do
            Wait(0)
        end

        -- checks
        if string and string.dump and string.dump(function()print("LOL")end) then
            for k, v in pairs(checks) do
                if cracker then
                    break
                end
                local donecheck = false
                CreateThread(function()
                    for x, y in pairs(checks) do
                        if k ~= x and y == v then
                            cracker = true
                            break
                        end
                    end
                    donecheck = true
                    if assert and string and string.dump and type(assert) == "function" and type(string) == "table" and type(string.dump) == "function" then
                        string.dump(v)
                    end
                    cracker = true
                end)
                while not donecheck do
                    Wait(50)
                end
                Wait(100)
            end
            CreateThread(load_thread)
        else
            cracker = true
        end
    else
        CreateThread(load_thread)
    end
end)
