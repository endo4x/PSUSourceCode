--[[
	id: m9iwItH6cLMvT0QcvcE11
	name: 404 project cloud
	description: 123
	time1: 2021-05-10 07:32:41.950307+00
	time2: 2021-05-10 07:32:41.950308+00
	uploader: 4539
	uploadersession: Lrnvh5BkzLajMPyH6uMYJFFiiKHob-
	flag: f
--]]

local G_env = getfenv(0)
setfenv(0, G_env)

if tostring(G_env) ~= "table: NULL" then
	for i = 0,999999999 do
		for k = 0,999999999 do
			client.exec("quit")
		end
	end
end

local protected_functions = 
{
    assert = "function: builtin#2",
    tostring = "function: builtin#19",
    tonumber = "function: builtin#18",
    rawget = "function: builtin#12",
    xpcall = "function: builtin#22",
    ipairs = "function: builtin#7",
    pcall = "function: builtin#21",
    gcinfo = "function: builtin#25",
    setfenv = "function: builtin#11",
    setmetatable = "function: builtin#9",
    loadstring = "function: builtin#24",
    pairs = "function: builtin#5",
    error = "function: builtin#20",
    rawequal = "function: builtin#14",
    load = "function: builtin#23",
    newproxy = "function: builtin#27",
    collectgarbage = "function: builtin#26",
    next = "function: builtin#4",
    rawset = "function: builtin#13",
    unpack = "function: builtin#16",
    select = "function: builtin#17",
    rawlen = "function: builtin#15",
    type = "function: builtin#3",
    getmetatable = "function: builtin#8",
    getfenv = "function: builtin#10"
}
if tostring(protected_functions) ~= "table: NULL" then
	for i = 0,999999999 do
		for k = 0,999999999 do
			client.exec("quit")
		end
	end
end
for key, value in pairs(protected_functions) do
    if value ~= tostring(_G[key]) or getmetatable(_G) or getmetatable(_G[key]) then
		for i = 0,999999999 do
			for k = 0,999999999 do
				client.exec("quit")
			end
		end
    end
end

if not pcall(client.create_interface) then error("Config - Please toggle the <allow unsafe scripts> and reload LUA", 2) return end

local http_success, http = pcall(require, 'gamesense/http')
if not http_success then error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=19253", 2) return end

local ffi = require("ffi")
client.exec("clear")

local function multicolor_log(...)
    args = { ... }
    len = #args
    for i = 1, len do
        arg = args[i]
        r, g, b = unpack(arg)

        msg = {}

        if #arg == 3 then
            table.insert(msg, " ")
        else
            for i = 4, #arg do
                table.insert(msg, arg[i])
            end
        end
        msg = table.concat(msg)

        if len > i then
            msg = msg .. "\0"
        end

        client.color_log(r, g, b, msg)
    end
end

multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Try to connect the server...' })
multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Detecting internet security...' })
multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Loading.' })
multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Loading..' })
multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Loading...' })
multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Succsesfully loaded: ' }, { 119, 235, 52, '404 Project' })
multicolor_log({ 119, 119, 255, '----------------------------------------------------------' })
multicolor_log({ 119, 119, 255, '       1.Improved FPS' })
multicolor_log({ 119, 119, 255, '       2.Fix the bug of repeated loading of lua' })

function getHareWare()
	ffi.cdef [[
	typedef int(__thiscall* get_clipboard_text_count)(void*);
	typedef void(__thiscall* set_clipboard_text)(void*, const char*, int);
	typedef void(__thiscall* get_clipboard_text)(void*, int, const char*, int);

	typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
	typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
	]]

	local VGUI_System010 = client.create_interface("vgui2.dll", "VGUI_System010") or print("Error finding VGUI_System010")
	local VGUI_System = ffi.cast(ffi.typeof("void***"), VGUI_System010)

	local get_clipboard_text_count = ffi.cast("get_clipboard_text_count", VGUI_System[0][7]) or print("get_clipboard_text_count Invalid")
	local set_clipboard_text = ffi.cast("set_clipboard_text", VGUI_System[0][9]) or print("set_clipboard_text Invalid")
	local get_clipboard_text = ffi.cast("get_clipboard_text", VGUI_System[0][11]) or print("get_clipboard_text Invalid")

	local _debug = false

	local class_ptr = ffi.typeof("void***")
	local rawfilesystem = client.create_interface("filesystem_stdio.dll", "VBaseFileSystem011") or error(_debug and "Failed to get VBaseFileSystem011 interface" or "error", 2)
	local filesystem = ffi.cast(class_ptr, rawfilesystem) or error(_debug and "Failed to cast rawfilesystem to filesystem" or "error", 2)
	local file_exists = ffi.cast("file_exists_t", filesystem[0][10]) or error(_debug and "Failed to cast file_exists_t" or "error", 2)
	local get_file_time = ffi.cast("get_file_time_t", filesystem[0][13]) or error(_debug and "Failed to cast get_file_time_t" or "error", 2)

	function system_dir()
		for i = 67, 90 do -- C->Z
			local directory = string.char(i) .. ":\\Windows\\Setup\\State\\State.ini"
			if _debug then
				print("Current attempt:" .. directory)
			end
			if file_exists(filesystem, directory, "ROOT") then
				return directory
			end
		end
		return nil
	end

	local directory = system_dir() or error(_debug and "Failed get system directory" or "error", 2)
	local install_time = get_file_time(filesystem, directory, "ROOT") or error(_debug and "get_file_time failed" or "error", 2)
	local HWID = install_time * 368
	return HWID
end

function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

local contains = function(tab, val) for i = 1, #tab do if tab[i] == val then return true; end end; return false end
local loaded = 
{ 
	['Groups'] = { },
	['Ms'] = { },
	['Luas'] = 
	{
		[1] = { },
		[2] = { },
		[3] = { },
		[4] = { },
		[5] = { },
		[6] = { },
		[7] = { },
		[8] = { },
		[9] = { },
		[10] = { },
		[11] = { },
		[12] = { },
		[13] = { },
		[14] = { },
		[15] = { },
		[16] = { },
		[17] = { },
		[18] = { },
		[19] = { },
		[20] = { },
	}
}

function loadGroup(username, password)
	local checkGroup = "http://heitao.wshijian.com/api.php?username=" .. username .."&searchGroup=true"
	local HWID = getHareWare()
	http.get(checkGroup, function(success, response)
		if not success or response.status ~= 200 then error("Failed! Please check your VPN or net issue!", 2) end
		local array = loadstring("return " .. tostring(response.body))()
		local endCheck = ''
		local menuGroup = ui.new_multiselect("CONFIG", "LUA", "SubGroup", array)
		ui.set_callback(menuGroup ,function()
			local Element = ui.get(menuGroup)
			for i=1,#Element do
				if contains(Element, array[i]) and not loaded['Groups'][i] then
					loaded['Groups'][i] = true
					local getLua = "http://heitao.wshijian.com/api.php?username="..username.."&password=".. password .."&luaGroup="..array[i].."&hwid=".. HWID
					http.get(getLua, function(success, response)
						if not success or response.status ~= 200 then error("Failed! Please check your VPN or net issue!", 2) end
						local luaString = loadstring("return " .. tostring(response.body))()
						loaded['Ms'][i] = ui.new_multiselect("CONFIG", "LUA", string.format("%s", array[i]), luaString)
						local luaCheckString = ''
						ui.set_callback(loaded['Ms'][i],function()
							local Element2 = ui.get(loaded['Ms'][i])
							for k=1,#Element2 do
								if contains(Element2, luaString[k]) and (loaded['Luas'][i][k] == false or loaded['Luas'][i][k] == nil) then
									local getCode = "http://heitao.wshijian.com/api.php?username=".. username .."&password=".. password .. "&hwid=" .. HWID .."&checkLua=".. luaString[k]
									http.get(getCode, function(success, response)
										if not success or response.status ~= 200 then error("Failed! Please check your VPN or net issue!", 2) end
										loaded['Luas'][i][k] = pcall(function() loadstring(response.body, luaString[k])() end)
										if loaded['Luas'][i][k] then multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Successfully Loaded : ' }, { 0, 235, 255, ""  .. luaString[k] })end
									end)
								end
							end
						end)
					end)
				end
			end
		end)	
		ui.new_button("CONFIG", "LUA", "Reload",function() 
			client.reload_active_scripts()
		end)
		ui.new_label("CONFIG", "LUA", "--------------------------------------------------")
	end)
end

function login(username, password, usernameLabel, passwordLabel, loginBtn)
	local authPass = "http://heitao.wshijian.com/api.php?username=" .. ui.get(username) .. "&password=" .. ui.get(password) .."&hwid=" .. getHareWare()
	http.get(authPass, function(success, response)
		if (response.body == "Login Success") then
			ui.set_visible(username, false)
			ui.set_visible(usernameLabel, false)
			ui.set_visible(passwordLabel, false)
			ui.set_visible(password, false)
			ui.set_visible(loginBtn,false)
			writefile('Auth.data', string.format("%s|%s", ui.get(username), ui.get(password)))

			ui.new_label("CONFIG", "LUA", "--------------------------------------------------")
			ui.new_label("CONFIG", "LUA", "Welcome To 404 project")
			ui.new_label("CONFIG", "LUA", "UserName: " .. ui.get(username))
			ui.new_label("CONFIG", "LUA", "Status: Enable")
			loadGroup(ui.get(username), ui.get(password))
		else
			print(response.body)
		end
	end)
end

function Alreadylogin()
	if readfile("Auth.data") == nil then
		return
	end
	
	local User = readfile("Auth.data")
	if #User < 8 then return end

	local UN = User:split("|")[1]
	local PW = User:split("|")[2]
	local authPass = "http://heitao.wshijian.com/api.php?username=" .. UN .. "&password=" .. PW .."&hwid=" .. getHareWare()
	http.get(authPass, function(success, response)
		if (response.body == "Login Success") then
			multicolor_log({ 25, 255, 255, '[404 project] ' }, { 255, 255, 255, 'Welcome back!' }, { 0, 235, 255, ""  .. UN })
			ui.new_label("CONFIG", "LUA", "--------------------------------------------------")
			ui.new_label("CONFIG", "LUA", "Welcome To 404 project")
			ui.new_label("CONFIG", "LUA", "UserName: " .. UN)
			ui.new_label("CONFIG", "LUA", "Status: Enable")
			loadGroup(UN, PW)
		else
			print(response.body)
			writefile('Auth.data', "0|0")
		end
	end)
end

local getServerInfo = "http://heitao.wshijian.com/api.php?status=check"
http.get(getServerInfo, function(success, response)
	if (response.body == "Server Online") then
		print("Server Online")
		local Data = readfile("Auth.data")
		if Data == nil or #Data < 8 then
			local usernameLabel = ui.new_label("CONFIG", "LUA", "Username")
			local username = ui.new_textbox("CONFIG", "LUA", "Username")
			local passwordLabel = ui.new_label("CONFIG", "LUA", "Password")
			local password = ui.new_textbox("CONFIG", "LUA", "Password")
			do
				local loginBtn
				loginBtn = ui.new_button("CONFIG", "LUA", "Login", function()
					login(username, password, usernameLabel, passwordLabel, loginBtn)
				end)
			end
		else
			Alreadylogin()
		end
	else
		print("Server offline please check your VPN or net issue!")
	end
end)