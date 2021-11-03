--[[
	id: pknQQ1dw235BncIVIaWsA
	name: AegisCloud7
	description: AegisCloud7
	time1: 2021-06-07 12:02:46.506586+00
	time2: 2021-06-07 12:02:46.506587+00
	uploader: 1MZZVPT0tsVlgj051NaNLe7l9doxVJqrAji2UzZr
	uploadersession: ow6ifAGCQJKn1m1rOvhPpKVpwEu_jr
	flag: f
--]]

local ffi = require "ffi"
local user = {
    username = database.read("aegisusername") or "username",
    password = database.read("aegispassword") or "password"
}
local string_len, tostring, ffi_string = string.len, tostring, ffi.string

local http = require "gamesense/http" or error("请去论坛订阅Http库 https://gamesense.pub/forums/viewtopic.php?id=19253")
local M = {}
local token = ""
local native_GetClipboardTextCount = vtable_bind("vgui2.dll", "VGUI_System010", 7, "int(__thiscall*)(void*)")
local native_SetClipboardText = vtable_bind("vgui2.dll", "VGUI_System010", 9, "void(__thiscall*)(void*, const char*, int)")
local native_GetClipboardText = vtable_bind("vgui2.dll", "VGUI_System010", 11, "int(__thiscall*)(void*, int, const char*, int)")

local new_char_arr = ffi.typeof("char[?]")

function M.get()
    local len = native_GetClipboardTextCount()
    if len > 0 then
        local char_arr = new_char_arr(len)
        native_GetClipboardText(0, char_arr, len)
        return ffi_string(char_arr, len - 1)
    end
end
M.paste = M.get

function M.set(text)
    text = tostring(text)
    native_SetClipboardText(text, string_len(text))
end
M.copy = M.set

local function getRandom(n)
    local t = {
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    }
    local s = ""
    for i = 1, n do
        s = s .. t[math.random(#t)]
    end;
    return s
end;

local Steam64 = getRandom(64)

local NetError = 0

local xiaozheng = {}
local string = string

local server = {
    "MainServer",
    "StandbyServer02",
    "StandbyServer03",
    "StandbyServer04",
    "StandbyServer05",
    "StandbyServer06",
    "StandbyServer07",
    "StandbyServer08",
    "StandbyServer09",
}

local serverAddr = {
    MainServer = "http://aegis.xiaozhengkeji.com:11050/",
    StandbyServer02 = "http://aegis.xiaozhengkeji.com:11052/",
    StandbyServer03 = "http://aegis.xiaozhengkeji.com:11053/",
    StandbyServer04 = "http://aegis.xiaozhengkeji.com:11054/",
    StandbyServer05 = "http://aegis.xiaozhengkeji.com:11055/",
    StandbyServer06 = "http://aegis.xiaozhengkeji.com:11056/",
    StandbyServer07 = "http://aegis.xiaozhengkeji.com:11057/",
    StandbyServer08 = "http://aegis.xiaozhengkeji.com:11058/",
    StandbyServer09 = "http://aegis.xiaozhengkeji.com:11059/"
}

local menu = {
    ServerSelect = ui.new_combobox("LUA", "B", "AegisCloud By XiaoZhengRS", server),
    AegisCloudUserName = ui.new_textbox("LUA", "B", "UserName"),
    AegisCloudPassWord = ui.new_textbox("LUA", "B", "PassWord"),
    CloudGroupList,
    Login,
}

local base_api = "http://aegis.xiaozhengkeji.com:11050/"

xiaozheng.__code = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/',
};
xiaozheng.__decode = {}
for k, v in pairs(xiaozheng.__code) do
    xiaozheng.__decode[string.byte(v, 1)] = k - 1
end

function xiaozheng.encode(text)
    local len = string.len(text)
    local left = len % 3
    len = len - left
    local res = {}
    local index = 1
    for i = 1, len, 3 do
        local a = string.byte(text, i)
        local b = string.byte(text, i + 1)
        local c = string.byte(text, i + 2)
        -- num = a<<16 + b<<8 + c
        local num = a * 65536 + b * 256 + c
        for j = 1, 4 do
            --tmp = num >> ((4 -j) * 6)
            local tmp = math.floor(num / (2 ^ ((4 - j) * 6)))
            --curPos = tmp&0x3f
            local curPos = tmp % 64 + 1
            res[index] = xiaozheng.__code[curPos]
            index = index + 1
        end
    end
    
    if left == 1 then
        xiaozheng.__left1(res, index, text, len)
    elseif left == 2 then
        xiaozheng.__left2(res, index, text, len)
    end
    return table.concat(res)
end

function xiaozheng.__left2(res, index, text, len)
    local num1 = string.byte(text, len + 1)
    num1 = num1 * 1024 --lshift 10
    local num2 = string.byte(text, len + 2)
    num2 = num2 * 4 --lshift 2
    local num = num1 + num2
    
    local tmp1 = math.floor(num / 4096)--rShift 12
    local curPos = tmp1 % 64 + 1
    res[index] = xiaozheng.__code[curPos]
    
    local tmp2 = math.floor(num / 64)
    curPos = tmp2 % 64 + 1
    res[index + 1] = xiaozheng.__code[curPos]
    
    curPos = num % 64 + 1
    res[index + 2] = xiaozheng.__code[curPos]
    
    res[index + 3] = "="
end

function xiaozheng.__left1(res, index, text, len)
    local num = string.byte(text, len + 1)
    num = num * 16
    
    tmp = math.floor(num / 64)
    local curPos = tmp % 64 + 1
    res[index] = xiaozheng.__code[curPos]
    
    curPos = num % 64 + 1
    res[index + 1] = xiaozheng.__code[curPos]
    
    res[index + 2] = "="
    res[index + 3] = "="
end

function xiaozheng.decode(text)
    local len = string.len(text)
    local left = 0
    if string.sub(text, len - 1) == "==" then
        left = 2
        len = len - 4
    elseif string.sub(text, len) == "=" then
        left = 1
        len = len - 4
    end
    
    local res = {}
    local index = 1
    local decode = xiaozheng.__decode
    for i = 1, len, 4 do
        local a = decode[string.byte(text, i)]
        local b = decode[string.byte(text, i + 1)]
        local c = decode[string.byte(text, i + 2)]
        local d = decode[string.byte(text, i + 3)]
        
        --num = a<<18 + b<<12 + c<<6 + d
        local num = a * 262144 + b * 4096 + c * 64 + d
        
        local e = string.char(num % 256)
        num = math.floor(num / 256)
        local f = string.char(num % 256)
        num = math.floor(num / 256)
        res[index] = string.char(num % 256)
        res[index + 1] = f
        res[index + 2] = e
        index = index + 3
    end
    
    if left == 1 then
        xiaozheng.__decodeLeft1(res, index, text, len)
    elseif left == 2 then
        xiaozheng.__decodeLeft2(res, index, text, len)
    end
    return table.concat(res)
end

function xiaozheng.__decodeLeft1(res, index, text, len)
    local decode = xiaozheng.__decode
    local a = decode[string.byte(text, len + 1)]
    local b = decode[string.byte(text, len + 2)]
    local c = decode[string.byte(text, len + 3)]
    local num = a * 4096 + b * 64 + c
    
    local num1 = math.floor(num / 1024) % 256
    local num2 = math.floor(num / 4) % 256
    res[index] = string.char(num1)
    res[index + 1] = string.char(num2)
end

function xiaozheng.__decodeLeft2(res, index, text, len)
    local decode = xiaozheng.__decode
    local a = decode[string.byte(text, len + 1)]
    local b = decode[string.byte(text, len + 2)]
    local num = a * 64 + b
    num = math.floor(num / 16)
    res[index] = string.char(num)
end



local function log(log)
    client.color_log(0, 125, 255, "[AegisCloud]: " .. log)
end




local function AF2()
    http.get(base_api .. "cloud/skeet/vf2?steam=" .. Steam64 .. "&token=" .. token, {}, function(success, data)
        if data.status == 200 then
            local temp = json.parse(data.body)
            if temp.code == 20000 then
                NetError = 0
            else
                log("NetError")
                NetError = NetError + 1
                if NetError > 15 then
                    client.reload_active_scripts()
                end
            end
        else
            log("NetError")
            NetError = NetError + 1
            if NetError > 15 then
                client.reload_active_scripts()
            end
        end
    
    end)
end

local function loadLua(LuaData)
    log("Start Loading Lua -> " .. LuaData)
    http.get(base_api .. "cloud/skeet/load/lua?token=" .. token .. "&luaTag=" .. LuaData .. "&xkey=10086xzkj", {}, function(success, data)
        if data.status == 200 then
            local temp = json.parse(data.body)
            if temp.code == 20000 then
                local temp_lua = xiaozheng.decode(temp.data.content)
                local tep_ = loadstring(temp_lua)
                tep_()
            end
        end
    end)
end




local function segmentationGroupList(GroupList)
    for i = 1, #GroupList do
        loadLua(GroupList[i])
    end

end

local function refLua(groupName)
    http.get(base_api .. "cloud/skeet/load?token=" .. token .. "&groupName=" .. groupName, {}, function(success, data)
        if data.status == 200 then
            local temp = json.parse(data.body)
            if temp.code == 20000 then
                ui.new_button("LUA", "B", "Load->" .. groupName, function()
                    segmentationGroupList(temp.data)
                end)
            
            end
        end
    end)
end



local function CloudStart()
    refLua(ui.get(menu.CloudGroupList))
    ui.set_callback(menu.CloudGroupList, function()
        log("Packet Switching->" .. ui.get(menu.CloudGroupList))
        refLua(ui.get(menu.CloudGroupList))
    end)
end

local function login()
    user.username = ui.get(menu.AegisCloudUserName)
    user.password = ui.get(menu.AegisCloudPassWord)
    http.post(base_api .. "user/login", {params = user}, function(success, data)
        if data.status == 200 then
            local temp = json.parse(data.body)
            if temp.code == 20000 then
                log(temp.msg)
                token = temp.data.tokenValue
                database.write("aegisusername", user.username)
                database.write("aegispassword", user.password)
                ui.set_visible(menu.AegisCloudUserName, false)
                ui.set_visible(menu.AegisCloudPassWord, false)
                log("User Authentication->" .. token)
                http.get(base_api .. "cloud/skeet/verification?steam=" .. Steam64 .. "&token=" .. token, {}, function(success, data)
                    if data.status == 200 then
                        local temp = json.parse(data.body)
                        menu.CloudGroupList = ui.new_combobox("LUA", "B", "GroupList", temp.data)
                        if temp.code == 20000 then
                            log("Login successfully!")
                            log("HI! " .. temp.msg)
                            ui.set_visible(menu.Login, false)
                            CloudStart()
                        end
                    end
                    client.set_event_callback("player_death", AF2)
                end)
            end
        end
    end)
end

local function init()
    client.exec("clear")
    log("Welcome Use AegisCloud Load!")
    log("CloudServer->" .. ui.get(menu.ServerSelect))
    ui.set_callback(menu.ServerSelect, function()
        if ui.get(menu.ServerSelect) == "MainServer" then
            base_api = serverAddr.MainServer;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer02" then
            base_api = serverAddr.StandbyServer02;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer03" then
            base_api = serverAddr.StandbyServer03;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer04" then
            base_api = serverAddr.StandbyServer04;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer05" then
            base_api = serverAddr.StandbyServer05;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer06" then
            base_api = serverAddr.StandbyServer06;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer07" then
            base_api = serverAddr.StandbyServer07;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer08" then
            base_api = serverAddr.StandbyServer08;
        end
        if ui.get(menu.ServerSelect) == "StandbyServer09" then
            base_api = serverAddr.StandbyServer09;
        end
        log("CutCloudServer->" .. ui.get(menu.ServerSelect))
    end)
    ui.set(menu.AegisCloudUserName, user.username)
    ui.set(menu.AegisCloudPassWord, user.password)
    menu.Login = ui.new_button("LUA", "B", "Login", login)
end

init()
