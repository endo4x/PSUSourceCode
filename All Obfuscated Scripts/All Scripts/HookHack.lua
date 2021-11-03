--[[
	id: yYUQZUWPLoMuu9P-bwFmA
	name: HookHack
	description: HookHack
	time1: 2021-07-25 05:05:53.464869+00
	time2: 2021-07-25 05:05:53.464869+00
	uploader: 1MZZVPT0tsVlgj051NaNLe7l9doxVJqrAji2UzZr
	uploadersession: ow6ifAGCQJKn1m1rOvhPpKVpwEu_jr
	flag: f
--]]

local o_load = _G["load"]
local o_loadstring = _G["loadstring"]
local o_unpack = _G["unpack"]
local o_pairs = _G["pairs"]
local o_writefile = _G["writefile"]
local o_print = _G["print"]
local o_tostring = _G["tostring"]

local load_name = tostring(_G["load"])
local loadstring_name = tostring(_G["loadstring"])
local tostring_name = tostring(_G["tostring"])

local files_loadstring = 1
local files_load = 1

o_print("hook ok!")

_G["loadstring"] = function(...)
    local args = {...}
	o_print("Hook")
    local str = ""
    for k, v in o_pairs(args) do
        str = str .. o_tostring(v) .. " "
    end
    o_writefile("temp/dump"..o_tostring(files_loadstring)..".lua", str)
	o_print("LUA To temp/dump"..o_tostring(files_loadstring)..".lua")
	files_loadstring = files_loadstring +1
    local ret = { o_loadstring(o_unpack(args)) }
    str = ""
    for k, v in o_pairs(ret) do
        str = str .. o_tostring(v) .. " "
    end
    return o_unpack(ret)
end