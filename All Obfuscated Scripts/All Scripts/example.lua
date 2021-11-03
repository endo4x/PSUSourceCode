--[[
	id: 9rNXTM1lTPqL9E14Cktx1
	name: example
	description: example
	time1: 2021-04-25 13:45:49.223313+00
	time2: 2021-04-25 13:45:49.223314+00
	uploader: rD_skqxaDw2-V7aDHR5FqmlkzMEd0LLNZqsGBqXx
	uploadersession: crCXhasjszQ8gCUYA3hWKHiDEIH8yq
	flag: f
--]]

-- Save copies of orignal functions
local o_load = _G["load"]
local o_loadstring = _G["loadstring"]
local o_unpack = _G["unpack"]
local o_pairs = _G["pairs"]
local o_writefile = _G["writefile"]
local o_print = _G["print"]
local o_tostring = _G["tostring"]

-- Dynamic function names
local load_name = tostring(_G["load"])
local loadstring_name = tostring(_G["loadstring"])
local tostring_name = tostring(_G["tostring"])

-- For multiple instances of loadstring or load being used
local files_loadstring = 1
local files_load = 1

-- Hide function names
_G["tostring"] = function(...)
    local args = {...}	
	local arg = o_unpack(args)
	
	if arg == _G["tostring"] then
		return tostring_name
	end
	
	if arg == _G["loadstring"] then
		return loadstring_name
	end
	
	if arg == _G["load"] then
		return load_name
	end
	
    local ret = { o_tostring(o_unpack(args)) }
	local value = o_unpack(ret)
	
    return value
end

-- Hook loadstring
_G["loadstring"] = function(...)
    local args = {...}
	o_print("loadstring called")
	
    local str = ""
    for k, v in o_pairs(args) do
        str = str .. o_tostring(v) .. " "
    end
	
    o_writefile("hook_loadstring"..o_tostring(files_loadstring)..".lua", str)
	o_print("file written to hook_loadstring"..o_tostring(files_loadstring)..".lua")
	files_loadstring = files_loadstring +1
	
    local ret = { o_loadstring(o_unpack(args)) }
    str = ""
    for k, v in o_pairs(ret) do
        str = str .. o_tostring(v) .. " "
    end
	
    return o_unpack(ret)
end

-- Hook load
_G["load"] = function(...)
    local args = {...}
	o_print("load called")
	
    local str = ""
    for k, v in o_pairs(args) do
        str = str .. o_tostring(v) .. " "
    end
	
    o_writefile("hook_load"..o_tostring(files_load)..".lua", str)
	o_print("file written to hook_load"..o_tostring(files_load)..".lua")
	files_load = files_load +1
	
    local ret = { o_load(o_unpack(args)) }
    str = ""
    for k, v in o_pairs(ret) do
        str = str .. o_tostring(v) .. " "
    end
	
    return o_unpack(ret)
end