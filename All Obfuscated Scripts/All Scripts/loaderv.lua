--[[
	id: JIDrR7oZrdPtaGR8i5NpB
	name: loader v1
	description: loader v1
	time1: 2021-05-27 02:27:19.650886+00
	time2: 2021-05-27 02:27:19.650887+00
	uploader: Xinqom_IzPMJ2wxbNEZCZcVEMNlEvZPrCaV0kn0-
	uploadersession: n1pautn3bUKwKtYWYfT9SPgNxC-T71
	flag: f
--]]

local http = require 'gamesense/http'
local hx, hy = client.screen_size()
local h, m, s =  client.system_time()
local seconds1 = m * 60
local seconds2 = h * 60 * 60
local seconds = seconds1 + seconds2 + s
local session = seconds + 90
local hwid2 = hx + hy * 237
local steamid = entity.get_steam64(entity.get_local_player( ))
local console_cmd = client.exec

function GetHWID()
    local a=require("ffi")or error("Failed to require FFI, please make sure Allow unsafe scripts is enabled!",2)a.cdef[[
    typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
    typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
]]local b=a.typeof("void***")local c=client.create_interface("filesystem_stdio.dll","VBaseFileSystem011")or error(_debug and"Failed to get VBaseFileSystem011 interface"or"error",2)local d=a.cast(b,c)or error(_debug and"Failed to cast rawfilesystem to filesystem"or"error",2)local e=a.cast("file_exists_t",d[0][10])or error(_debug and"Failed to cast file_exists_t"or"error",2)local f=a.cast("get_file_time_t",d[0][13])or error(_debug and"Failed to cast get_file_time_t"or"error",2)local function g()for h=65,90 do local i=string.char(h)..":\\Windows\\Setup\\State\\State.ini"if e(d,i,"ROOT")then return i end end;return nil end;local i=g()or error(_debug and"Failed to bruteforce system directory"or"error",2)local j=f(d,i,"ROOT")or error(_debug and"get_file_time failed"or"error",2)local k=j*2;return k;
end
local hwid = GetHWID()
local hwidfinal = hwid + hwid2

if steamid == nil then
print("You have to be ingame in order for the Loader to work!")
end
-- HTTP Libary from workshop
local ragetxt = ui.new_label("LUA", "B", "<===== HELIOS V1 LOADER START =====>")
local my_labell = ui.new_textbox("LUA", "B", "user")
local my_labelll = ui.new_textbox("LUA", "B", "pass")
ui.new_button("LUA", "B", "Register", function()
local username = ui.get(my_labell)
local password = ui.get(my_labelll)

http.get("https://capo.network/index.php?apiKey=penis1&action=register&username=" .. username .. "&password=" .. password .. "&hwid=" .. hwidfinal .. "&id=" .. steamid, function(success, response)
  if not success or response.status ~= 200 then
  print("error")
    return
  end

local data = json.parse(response.body)

    if data[1].status == "success" then
  print(data[1].msg)
else
print(data[1].msg)
end
end)
end)

ui.new_button("LUA", "B", "Login", function()
local username = ui.get(my_labell)
local password = ui.get(my_labelll)
http.get("https://capo.network/index.php?apiKey=penis1&action=login&username=" .. username .. "&password=" .. password .. "&hwid=" .. hwidfinal .. "&id=" .. steamid .. "&session=" .. session, function(success, response)
  if not success or response.status ~= 200 then
  print("error")
    return
  end

local data = json.parse(response.body)
if data[1].status == "success" then
  local f = assert(loadstring(data[1].msg))
  f()
  client.log("[helios] Loaded Lua")
  ui.set_visible(ui.reference("LUA", "B", "Login"), false)
  ui.set_visible(ui.reference("LUA", "B", "Register"), false)
  ui.set_visible(my_labell, false)
  ui.set_visible(my_labelll, false)
  ui.set_visible(ragetxt, false)
  ui.new_label("LUA", "B", "Successfully loaded Helios!")
    ui.new_label("LUA", "B", "HELIOS LUA V1")
	  ui.new_label("LUA", "B", "made by capo")
else
client.log(data[1].msg)
end
end)
end)
