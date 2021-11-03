--[[
	id: C5ZK9LJF2WtyHVG_HPfgn
	name: wat
	description: ddd
	time1: 2021-04-25 04:36:52.262526+00
	time2: 2021-04-25 04:36:52.262526+00
	uploader: 1821
	uploadersession: 9agiurInjFLJYEXY4tRC5f1V5ZkorI
	flag: f
--]]

local Options = getgenv().Options

pcall(function()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    if not getgenv().key then
        print("Please enter a key")
        return
    end
startTick = tick()
local localPlayer = game:GetService("Players").LocalPlayer
local http_request = http_request;
local function getExploit()
	local exploit = PSU_ENCRYPT_STRING("not supported")
	pcall(function() 
		if getexecutorname() == PSU_ENCRYPT_STRING("ScriptWare") then
			exploit = PSU_ENCRYPT_STRING("ScriptWare")
		end
	end)
	if syn and not is_sirhurt_closure and not pebc_execute then
		exploit = PSU_ENCRYPT_STRING("Synapse")
	end
    if is_sirhurt_closure then
        exploit = PSU_ENCRYPT_STRING("SirHurt")
    end
	return exploit
end

if getExploit() == "Synapse" then
	http_request = syn.request
	elseif getExploit() == "ScriptWare" then
    getupvalues = debug.getupvalues
	http_request = http.request
    elseif getExploit() == "SirHurt" then
        http_request = http_request;
    else
    localPlayer:Kick("Exploit not supported")
end

if (not http_request) then
	return game:GetService('Players').LocalPlayer:Kick('Unable to find proper request function')
end
local function isInTable(table, value)
    for i, v in pairs(table) do
        if v == value then
            return true
        end
    end
end

local games = {
    ["Arsenal"] = 286090429,
    ["KAT"] = 621129760,
    ["IslandRoyale"] = {
        1962086868,
        1320174999,
        3213501585,
        3210442546,
        3678591308,
        5778397818,
        5214060009,
        6582295389,
        6699748628
    }
}


local function getGame()
    for i, v in pairs(games) do
        if tostring(i) == "IslandRoyale" and isInTable(v, game.PlaceId) then
            return tostring(i)
        end
        if game.PlaceId == v then
            return tostring(i)
        end
    end
    return "universal"
end
-- // define hash function

local hash; do
    local MOD = 2^32
    local MODM = MOD-1
    local bxor = bit32.bxor;
    local band = bit32.band;
    local bnot = bit32.bnot;
    local rshift1 = bit32.rshift;
    local rshift = bit32.rshift;
    local lshift = bit32.lshift;
    local rrotate = bit32.rrotate;

    local str_gsub = string.gsub;
    local str_fmt = string.format;
    local str_byte = string.byte;
    local str_char = string.char;
    local str_rep = string.rep;

    local k = {
	    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
	    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
	    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
	    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
	    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
	    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
	    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
	    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
	    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
	    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
	    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
	    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
	    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
	    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
	    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
	    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
    }
    local function str2hexa(s)
        return (str_gsub(s, ".", function(c) return str_fmt("%02x", str_byte(c)) end))
    end
    local function num2s(l, n)
        local s = ""
        for i = 1, n do
            local rem = l % 256
            s = str_char(rem) .. s
            l = (l - rem) / 256
        end
        return s
    end
    local function s232num(s, i)
        local n = 0
        for i = i, i + 3 do n = n*256 + str_byte(s, i) end
        return n
        end
        local function preproc(msg, len)
        local extra = 64 - ((len + 9) % 64)
        len = num2s(8 * len, 8)
        msg = msg .. "\128" .. str_rep("\0", extra) .. len
        assert(#msg % 64 == 0)
        return msg
    end
    local function initH256(H)
        H[1] = 0x6a09e667
        H[2] = 0xbb67ae85
        H[3] = 0x3c6ef372
        H[4] = 0xa54ff53a
        H[5] = 0x510e527f
        H[6] = 0x9b05688c
        H[7] = 0x1f83d9ab
        H[8] = 0x5be0cd19
        return H
    end
    local function digestblock(msg, i, H)
        local w = {}
        for j = 1, 16 do w[j] = s232num(msg, i + (j - 1)*4) end
        for j = 17, 64 do
            local v = w[j - 15]
            local s0 = bxor(rrotate(v, 7), rrotate(v, 18), rshift(v, 3))
            v = w[j - 2]
            w[j] = w[j - 16] + s0 + w[j - 7] + bxor(rrotate(v, 17), rrotate(v, 19), rshift(v, 10))
        end
        local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
        for i = 1, 64 do
            local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))
            local maj = bxor(band(a, b), band(a, c), band(b, c))
            local t2 = s0 + maj
            local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))
            local ch = bxor(band(e, f), band(bnot(e), g))
            local t1 = h + s1 + ch + k[i] + w[i]
            h, g, f, e, d, c, b, a = g, f, e, d + t1, c, b, a, t1 + t2
        end
        H[1] = band(H[1] + a)
        H[2] = band(H[2] + b)
        H[3] = band(H[3] + c)
        H[4] = band(H[4] + d)
        H[5] = band(H[5] + e)
        H[6] = band(H[6] + f)
        H[7] = band(H[7] + g)
        H[8] = band(H[8] + h)
    end
    function hash(msg, t) 
        msg = preproc(msg, #msg)
        local H = initH256({})
        for i = 1, #msg, 64 do digestblock(msg, i, H) end
        return str2hexa(num2s(H[1], 4) .. num2s(H[2], 4) .. num2s(H[3], 4) .. num2s(H[4], 4) .. num2s(H[5], 4) .. num2s(H[6], 4) .. num2s(H[7], 4) .. num2s(H[8], 4))
    end
end
local function CountClosures()
    local upvalue = {}
    upvalue[1] = getupvalues(loadstring)['']
if getExploit() == PSU_ENCRYPT_STRING("Synapse") then
upvalue[2] = getupvalues(syn.request)['']
upvalue[3] = getupvalues(syn.crypt.custom.encrypt)['']
upvalue[4] = getupvalues(syn.crypt.custom.decrypt)['']
    for i,v in next, getreg() do
        if (type(v) == 'function') then
        for o,p in pairs(upvalue) do
            if getupvalues(v)[''] == p then
            return PSU_ENCRYPT_STRING("boink")
            end
        end
    end
    end
end
if getExploit() == PSU_ENCRYPT_STRING("SirHurt") then
    if tostring(getinfo(loadstring).nups) ~= PSU_ENCRYPT_STRING("23875") or tostring(getinfo(http_request).nups) ~= PSU_ENCRYPT_STRING("23875") or tostring(getinfo(AES_DECRYPT).nups) ~= PSU_ENCRYPT_STRING("23875") or tostring(getinfo(AES_ENCRYPT).nups) ~= PSU_ENCRYPT_STRING("23875") then
        return PSU_ENCRYPT_STRING("boink")
    end
end
	if getExploit() == PSU_ENCRYPT_STRING("Synapse") then
    local Count = 0
    for i,v in next, getreg() do
        if typeof(v) == 'function' and is_synapse_function(v) and typeof(i) == 'string' and i:len() == 16 then
            Count = Count + 1
      end
    end
    return Count > 53 and 53 < Count
	end
	return false
end
local function postDisc(content)
                content = game:GetService("HttpService"):JSONEncode(content)
                if getExploit() == "Synapse" then
                    local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
            local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")     
                local keyData = http_request({
                    Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                    Method = 'GET';
                    Headers = {
                        ["send"] = syn.crypt.custom.encrypt("bf-cbc", content, kid, diabetes);
                        };
                    
    })
elseif getExploit() == "SirHurt" then
    local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
            local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
    local keyData = http_request({
        Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
        Method = 'GET';
        Headers = {
            ["send"] = AES_ENCRYPT(content, kid, diabetes);
            };          
        })            
end
end

local function runscript()
    local Check = CountClosures()
    if Check == PSU_ENCRYPT_STRING("boink") or Check == nil then
        local content = {
            ["player"] = game:GetService("Players").LocalPlayer.Name,
            ["userid"] = game:GetService("Players").LocalPlayer.UserId,
            ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
            ["placeid"] = tostring(game.PlaceId),
            ["key"] = tostring(getgenv().key),
            ["response"] = PSU_ENCRYPT_STRING("Cracking"),
            ["cra"] = PSU_ENCRYPT_STRING("Cracking")
        }
        content = game:GetService("HttpService"):JSONEncode(content)
        if getExploit() == "Synapse" then

        local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
    local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")     

        local keyData = http_request({
            Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
            Method = 'GET';
            Headers = {
                ["send"] = syn.crypt.custom.encrypt("bf-cbc", content, kid, diabetes);
                };
           })
        elseif getExploit() == "SirHurt" then

            local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
    local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")

        local keyData = http_request({
            Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
            Method = 'GET';
            Headers = {
                ["send"] = AES_ENCRYPT(content, kid, diabetes); 
                };
           })
        end
           wait(1)
        PSU_CRASH()
    wait()
    while true do end
    elseif Check then
    PSU_CRASH()
    wait()
    while true do end
    end
local desid

local sidw = http_request({
        Url = ('https://kiwiscripts.xyz/TestFiles/sid.php?exploit=' .. getExploit());
        Method = 'GET';
})

if getExploit() == "Synapse" then
    local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
            local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")  
    desid = syn.crypt.custom.decrypt("bf-cbc", sidw.Body, kid, diabetes);
elseif getExploit() == "SirHurt" then
    local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
            local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
    
        desid = AES_DECRYPT(sidw.Body, kid, diabetes);
end

desid = PSU_ENCRYPT_STRING("identifier") .. hash(desid) .. PSU_ENCRYPT_STRING("kiwitime")

local sid

if getExploit() == "Synapse" then
    local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
            local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")  
    local sidu = syn.crypt.custom.encrypt("bf-cbc", desid, kid, diabetes);
    sid = string.gsub(sidu,"+","%%2B")
elseif getExploit() == "SirHurt" then
    local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
            local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
    
        local sidu = AES_ENCRYPT(desid, kid, diabetes);
        sid = string.gsub(sidu,"+","%%2B")
end

local data = http_request({
	Url = ('https://kiwiscripts.xyz/server.php?key=' .. getgenv().key .. '&exploit=' .. getExploit() .. '&sid=' .. sid .. '&game=' .. getGame());
	Method = 'GET';
})

if 1 == 2 then
    PSU_CRASH()
    while true do end
    error('boomer')
    game:GetService("Players").LocalPlayer:Kick("boomer")
    while true do
        for i = 1, math.huge do
            print(math.sqrt(i))
        end
    end
end
local Check = CountClosures()
            if Check == PSU_ENCRYPT_STRING("boink") or Check == nil then
                local content = {
                    ["player"] = game:GetService("Players").LocalPlayer.Name,
                    ["userid"] = game:GetService("Players").LocalPlayer.UserId,
                    ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
                    ["placeid"] = tostring(game.PlaceId),
                    ["key"] = tostring(getgenv().key),
                    ["response"] = PSU_ENCRYPT_STRING("Cracking"),
                    ["cra"] = PSU_ENCRYPT_STRING("Cracking")
                }
                content = game:GetService("HttpService"):JSONEncode(content)
                if getExploit() == "Synapse" then

                local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
            local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")     

                local keyData = http_request({
                    Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                    Method = 'GET';
                    Headers = {
                        ["send"] = syn.crypt.custom.encrypt("bf-cbc", content, kid, diabetes);
                        };
                   })
                elseif getExploit() == "SirHurt" then

                    local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
            local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
    
                local keyData = http_request({
                    Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                    Method = 'GET';
                    Headers = {
                        ["send"] = AES_ENCRYPT(content, kid, diabetes); 
                        };
                   })
                end
                   wait(1)
                PSU_CRASH()
            wait()
            while true do end
            elseif Check then
            PSU_CRASH()
            wait()
            while true do end
            end
if data.StatusCode == 200 then

    wl = true
    local unprocessed = data.Body;
    local split = string.split(data.Body,"DQZGuygW08cEGZBwXYzw")--, "HappyKiwiTime!~")
    local response = data.Body;

    if split[1] == "HappyKiwiTime!~" then
        if split[1] == "HappyKiwiTime!~" then
            local Check = CountClosures()
            if Check == PSU_ENCRYPT_STRING("boink") or Check == nil then
                local content = {
                    ["player"] = game:GetService("Players").LocalPlayer.Name,
                    ["userid"] = game:GetService("Players").LocalPlayer.UserId,
                    ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
                    ["placeid"] = tostring(game.PlaceId),
                    ["key"] = tostring(getgenv().key),
                    ["response"] = PSU_ENCRYPT_STRING("Cracking"),
                    ["cra"] = PSU_ENCRYPT_STRING("Cracking")
                }
                content = game:GetService("HttpService"):JSONEncode(content)

                if getExploit() == "Synapse" then

                    local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
                local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")     
    
                    local keyData = http_request({
                        Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                        Method = 'GET';
                        Headers = {
                            ["send"] = syn.crypt.custom.encrypt("bf-cbc", content, kid, diabetes);
                            };
                       })
                    elseif getExploit() == "SirHurt" then
    
                        local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
                local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
        
                    local keyData = http_request({
                        Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                        Method = 'GET';
                        Headers = {
                            ["send"] = AES_ENCRYPT(content, kid, diabetes); 
                            };
                       })
                    end
                   wait(1)
                PSU_CRASH()
            wait()
            while true do end
            elseif Check then
            PSU_CRASH()
            wait()
            while true do end
            end
        if 1 == 2 then
            PSU_CRASH()
            while true do end
    error('boomer')
    game:GetService("Players").LocalPlayer:Kick("boomer")
    for _, v in pairs(game:GetDescendants()) do
        spawn(function()
            pcall(require, v)
        end)
    end
        end
        if 1 ~= 1 then
            PSU_CRASH()
            while true do end
    error('boomer')
    game:GetService("Players").LocalPlayer:Kick("boomer")
    for _, v in pairs(game:GetDescendants()) do
        spawn(function()
            pcall(require, v)
        end)
    end
        end

        local Check = CountClosures()
            if Check == PSU_ENCRYPT_STRING("boink") or Check == nil then
                local content = {
                    ["player"] = game:GetService("Players").LocalPlayer.Name,
                    ["userid"] = game:GetService("Players").LocalPlayer.UserId,
                    ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
                    ["placeid"] = tostring(game.PlaceId),
                    ["key"] = tostring(getgenv().key),
                    ["response"] = PSU_ENCRYPT_STRING("Cracking"),
                    ["cra"] = PSU_ENCRYPT_STRING("Cracking")
                }
                content = game:GetService("HttpService"):JSONEncode(content)
                if getExploit() == "Synapse" then

                    local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
                local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")     
    
                    local keyData = http_request({
                        Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                        Method = 'GET';
                        Headers = {
                            ["send"] = syn.crypt.custom.encrypt("bf-cbc", content, kid, diabetes);
                            };
                       })
                    elseif getExploit() == "SirHurt" then
    
                        local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
                local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
        
                    local keyData = http_request({
                        Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                        Method = 'GET';
                        Headers = {
                            ["send"] = AES_ENCRYPT(content, kid, diabetes); 
                            };
                       })
                    end
                   wait(1)
                PSU_CRASH()
            wait()
            while true do end
            elseif Check then
            PSU_CRASH()
            wait()
            while true do end
            end
            local content = {
                ["player"] = game:GetService("Players").LocalPlayer.Name,
                ["userid"] = game:GetService("Players").LocalPlayer.UserId,
                ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
                ["placeid"] = tostring(game.PlaceId),
                ["key"] = tostring(getgenv().key),
                ["response"] = tostring(split[1]),
                ["cra"] = "Script Executed"
            }
            postDisc(content)

	    local consData = http_request({
	    Url = ('https://kiwiscripts.xyz/constantsdoawyiugdayuiowDGIOWADgaIOWdgo');
	    Method = 'GET';
        })
        constants = string.split(consData.Body, "|")


        print("\n:::    ::: ::::::::::: :::       ::: :::::::::::      :::     ::: ::::::::::: :::::::: ::::::::::: ::::::::  ::::    ::: \n:+:   :+:      :+:     :+:       :+:     :+:          :+:     :+:     :+:    :+:    :+:    :+:    :+:    :+: :+:+:   :+: \n+:+  +:+       +:+     +:+       +:+     +:+          +:+     +:+     +:+    +:+           +:+    +:+    +:+ :+:+:+  +:+ \n+#++:++        +#+     +#+  +:+  +#+     +#+          +#+     +:+     +#+    +#++:++#++    +#+    +#+    +:+ +#+ +:+ +#+ \n+#+  +#+       +#+     +#+ +#+#+ +#+     +#+           +#+   +#+      +#+           +#+    +#+    +#+    +#+ +#+  +#+#+# \n#+#   #+#      #+#      #+#+# #+#+#      #+#            #+#+#+#       #+#    #+#    #+#    #+#    #+#    #+# #+#   #+#+# \n###    ### ###########   ###   ###   ###########          ###     ########### ######## ########### ########  ###    #### \n")
            local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
            local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")        
            local Check = CountClosures()
            if Check == PSU_ENCRYPT_STRING("boink") or Check == nil then

                local content = {
                    ["player"] = game:GetService("Players").LocalPlayer.Name,
                    ["userid"] = game:GetService("Players").LocalPlayer.UserId,
                    ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
                    ["placeid"] = tostring(game.PlaceId),
                    ["key"] = tostring(getgenv().key),
                    ["response"] = PSU_ENCRYPT_STRING("Cracking"),
                    ["cra"] = PSU_ENCRYPT_STRING("Cracking")
                }
                content = game:GetService("HttpService"):JSONEncode(content)

                if getExploit() == "Synapse" then

                    
                    local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
                local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")     
    
                    local keyData = http_request({
                        Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                        Method = 'GET';
                        Headers = {
                            ["send"] = syn.crypt.custom.encrypt("bf-cbc", tostring(getgenv().key), kid, diabetes);
                            };
                       })
                    elseif getExploit() == "SirHurt" then
    
                        local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
                local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
        
                    local keyData = http_request({
                        Url = ('https://kiwiscripts.xyz/TestFiles/scripthandle.php?exploit=' .. getExploit());
                        Method = 'GET';
                        Headers = {
                            ["send"] = AES_ENCRYPT(tostring(getgenv().key), kid, diabetes); 
                            };
                       })
                    end
                   wait(1)
                PSU_CRASH()
            wait()
            while true do end
            elseif Check then
            PSU_CRASH()
            wait()
            while true do end
            end

            if getExploit() == "Synapse" then
                local kid = PSU_ENCRYPT_STRING("GENWsUbj09o3SgNYW2gEzl491zEHTs")
            local diabetes = PSU_ENCRYPT_STRING("pXbibIcs")      
            local uncrypt = syn.crypt.custom.decrypt(
            "bf-cbc",
            split[2],
            kid,
            diabetes)
            loadstring(uncrypt)();
            elseif getExploit() == "SirHurt" then
                local kid = PSU_ENCRYPT_STRING("VDMHyf7vtt/mvQ4J")
                local diabetes = PSU_ENCRYPT_STRING("dnJRRFBoeUVnMkRxTHdaaDRDUDBDUT09")
                local uncrypt = AES_DECRYPT(split[2], kid, diabetes)
                loadstring(uncrypt)();
            else
                print("how tf did this happen. Like, there is no way this should be possible...")
            end
            --local ready = uncrypt
            --[[
            if getGame() == "IslandRoyale" then
                ready = string.sub(uncrypt, 10)
            elseif getGame() == "Arsenal" then
                ready = string.sub(uncrypt, 10)
            elseif getGame() == "universal" then
                ready = string.sub(uncrypt, 10)
            end      
            --]]
            
        
    end
elseif response == "hwid mismatch" then
    local result = messagebox("It looks like your HWID doesn't match your key, would you like to reset your HWID? (You can do this once every 24 hours)", "HWID Reset", 4)
        if result == 6 then
            local data = http_request({
    Url = ('https://kiwiscripts.xyz/TestFiles/hwidReset.php?key=' .. getgenv().key);
    Method = 'GET';
})
local content = {
    ["player"] = game:GetService("Players").LocalPlayer.Name,
    ["userid"] = game:GetService("Players").LocalPlayer.UserId,
    ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
    ["placeid"] = tostring(game.PlaceId),
    ["key"] = tostring(getgenv().key),
    ["response"] = tostring(data.Body),
    ["cra"] = "Script Executed"
}

postDisc(content)
            print(tostring(data.Body))
            runscript()
            else
                local content = {
    ["player"] = game:GetService("Players").LocalPlayer.Name,
    ["userid"] = game:GetService("Players").LocalPlayer.UserId,
    ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
    ["placeid"] = tostring(game.PlaceId),
    ["key"] = tostring(getgenv().key),
    ["response"] = tostring(data.Body),
    ["cra"] = "Script Executed"
}
                postDisc(content)
                print("Well ok then, I guess you don't get to use the script :(")

        end
    else
        local content = {
            ["player"] = game:GetService("Players").LocalPlayer.Name,
            ["userid"] = game:GetService("Players").LocalPlayer.UserId,
            ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
            ["placeid"] = tostring(game.PlaceId),
            ["key"] = tostring(getgenv().key),
            ["response"] = tostring(data.Body),
            ["cra"] = "Script Executed"
        }
        postDisc(content)
        print(response)
    end
else
    local content = {
        ["player"] = game:GetService("Players").LocalPlayer.Name,
        ["userid"] = game:GetService("Players").LocalPlayer.UserId,
        ["game"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
        ["placeid"] = tostring(game.PlaceId),
        ["key"] = tostring(getgenv().key),
        ["response"] = tostring(data.Body),
        ["cra"] = "Script Executed"
    }
   postDisc(content)
    print("Website error")
end
end
runscript()
end)

