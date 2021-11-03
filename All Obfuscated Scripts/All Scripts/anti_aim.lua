--[[
	id: 1ZLpWKPsa6OIAcKv2XNJJ
	name: anti_aim
	description: 111
	time1: 2021-07-07 16:23:23.943377+00
	time2: 2021-07-07 16:23:23.943378+00
	uploader: 8V20PHRtfoKBcg6in80v4AxutIB0rF2RlJl-sBwB
	uploadersession: vt6PV3MZZMGOuRqOtnivO4cRZ16k-A
	flag: f
--]]

-- local variables for API functions. any changes to the line below will be lost on re-generation
local panorama_loadstring, panorama_open, string_match =  panorama.loadstring, panorama.open, string.match


local http = require "gamesense/http";

local js = panorama_open();

http.get("http://103.252.89.43/users.txt", function(success, response)
	if not success or response.status ~= 200 then
	  return
	end


local lol = panorama_open().MyPersonaAPI.GetXuid();

client_color_log(255,255,255, "[C0D-AA] Loading Steam IDs...")

if string_match(response.body, lol) then 
	client_color_log(0,255,0, "[C0D-AA] Loaded Successfuly!")
else
	client_color_log(255, 0, 0, "[C0D-AA] Load failed!")
	client.exec("quit")
	return
end
end)