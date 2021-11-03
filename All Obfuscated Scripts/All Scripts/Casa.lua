--[[
	id: xNEqLrHGebygy4dj3hd3C
	name: Casa
	description: Client
	time1: 2021-06-23 12:34:19.711702+00
	time2: 2021-06-23 12:34:19.711702+00
	uploader: -G26-4_UXAJX1xFmLIxpWYgMiIm2tzjv-Th22D6g
	uploadersession: tiQzIznHbV_wMPwDdSbJecmEULoduK
	flag: f
--]]

local debug = false

-- side detection
SERVER = IsDuplicityVersion()
CLIENT = not SERVER

-- print("============ IS_SERVER:"..tostring(SERVER))
-- print("============ IS_CLIENT:"..tostring(CLIENT))

local modules = {}
function module(rsc, path) -- load a LUA resource file as module
    if path == nil then -- shortcut for vrp, can omit the resource parameter
        path = rsc
        rsc = GetCurrentResourceName()
    end

    local key = rsc..path

    if modules[key] then -- cached module
        return table.unpack(modules[key])
    else
        -- print(rsc, path..".lua", LoadResourceFile(rsc, path..".lua"))
     --  print(rsc)
     --  print(path..".lua")
        local f, err = load(LoadResourceFile(rsc, path..".lua"))
        if f then
            local ar = { pcall(f) }
            if ar[1] then
                table.remove(ar, 1)
                modules[key] = ar
                return table.unpack(ar)
            else
                modules[key] = nil
                print("~r~[aer_case] ~w~Error loading module "..rsc.."/"..path..":"..ar[2])
            end
        else
            print("~r~[aer_case] ~w~Error parsing module "..rsc.."/"..path..":"..err)
        end
    end
end

-- generate a task metatable (helper to return delayed values with timeout)
--- dparams: default params in case of timeout or empty cbr()
--- timeout: milliseconds, default 5000
function Task(callback, dparams, timeout) 
    if timeout == nil then timeout = 5000 end

    local r = {}
    r.done = false

    local finish = function(params) 
        if not r.done then
            if params == nil then params = dparams or {} end
            r.done = true
            callback(table.unpack(params))
        end
    end

    setmetatable(r, {__call = function(t,params) finish(params) end })
    SetTimeout(timeout, function() finish(dparams) end)

    return r
end

function DumpTable(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. DumpTable(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

function areturn(self, ...)
    self.r = {...}
    self.p:resolve(self.r)
end

-- create an async returner or a thread (Citizen.CreateThreadNow)
-- func: if passed, will create a thread, otherwise will return an async returner
function async(func)
    if func then
        Citizen.CreateThreadNow(func)
    else
        return setmetatable({ wait = wait, p = promise.new() }, { __call = areturn })
    end
end

function wait(self)
    local rets = Citizen.Await(self.p)

    if not rets then
        if self.r then
            rets = self.r
        else
            print("async wait(): Citizen.Await returned (nil) before the areturn call.")
        end
    end
  
    return table.unpack(rets, 1, table_maxn(rets))
end

-- table.maxn replacement
function table_maxn(t)
    local max = 0
    for k, v in pairs(t) do
        local n = tonumber(k)
        if n and n > max then max = n end
    end
    return max
end

local Luaoop = module("aer_case", "modules/Luaoop")
class = Luaoop.class
