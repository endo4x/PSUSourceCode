--[[
	id: WZpVnsqqRhGFC7Y_YG4qL
	name: BW Bypass
	description: BW Bypass
	time1: 2021-07-23 15:01:51.181691+00
	time2: 2021-07-23 15:01:51.181692+00
	uploader: hRyCRTTuLGJ4_-BcaNZIgtkElq34yq6a96UU_yZu
	uploadersession: 8_5hVjsYEzdq3uVFw2cthJRuiowORw
	flag: f
--]]

local function gettablelen(tbl)
    local ok = 1
    for i,v in pairs(tbl) do
        ok = ok + 1
    end
    return ok
end

local function getmainanticheat()
    for i,v in pairs(getloadedmodules()) do
        if v.Name == "ModuleScript" then
            local succeeded, result = pcall(getsenv, v)
    
            if succeeded and gettablelen(result) > 50 then
                return v
            end
        end
    end
end

local function find_item_obfuscation(itemname)
    for i,v in pairs(getsenv(getmainanticheat())) do
        if v == itemname then return i end
    end
end

local Keywords = {
    find_item_obfuscation("MSH_MrPoopMan"),
    find_item_obfuscation("16,CameraInput"),
    find_item_obfuscation("12,Bypass"),
    find_item_obfuscation(",Changed"),
    find_item_obfuscation(",Removed"),
    find_item_obfuscation(",Added"),
    find_item_obfuscation("Connected"),
    find_item_obfuscation("resume"),
    find_item_obfuscation("MaxHealth")
}

local function GetFunctions()
    local functions = {}
    for i,v in pairs(Keywords) do
        for _,gc in next, getgc() do
            if type(gc) == "function" and islclosure(gc) and not is_synapse_function(gc) then
                for gamer, time in next, debug.getconstants(gc) do
                    if time == v then
                        table.insert(functions, gc)
                    end
                end
            end
        end
    end
    return functions
end

local funcs = GetFunctions()

for i,v in pairs(funcs) do
    local hook hook = hookfunction(v, function() end)
end

--print("Hooked ".. #funcs.. " functions!")