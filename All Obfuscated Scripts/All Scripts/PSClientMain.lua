--[[
	id: c6TSKunfhQSarpt_0Ve5R
	name: PS ClientMain
	description: ok
	time1: 2021-06-11 08:14:08.562939+00
	time2: 2021-06-11 08:14:08.562944+00
	uploader: 306
	uploadersession: VSD-hEgrXGbVPhj6KKVLLSmCHMD1Fw
	flag: f
--]]

-- Sources and functions might be taken from others

repeat
	wait()
until script.Parent:WaitForChild("CharacterSoundEvent")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Main = script.Parent
local Remote = Main:WaitForChild("CharacterSoundEvent")
local Resources = Main:WaitForChild("Stuff")
local RealBase = Main:WaitForChild("Main")
local Base = RealBase:WaitForChild("Base")
local Intro	= Base:WaitForChild("Intro")
local Middle = Intro:WaitForChild("Middle")
local Right	= Intro:WaitForChild("Right")
local Left = Intro:WaitForChild("Left")
local Change = Resources.Assets:WaitForChild("Change")
local Side = Base:WaitForChild("Side")
local Home = Base:WaitForChild("Home")
local Welcome = Home:WaitForChild("Welcome")
local List1 = Home:WaitForChild("List")
local List = List1:WaitForChild("List")["Scroll"]
local CreatorType = List:WaitForChild("CreatorType")
local GameName = List:WaitForChild("GameName")
local PlayersInt = List:WaitForChild("Players")
local CreatorName = List:WaitForChild("CreatorName")
local CommandsInt = List:WaitForChild("CommandsInt")
local JobID = List:WaitForChild("JobID")
local Genre = List:WaitForChild("Genre")
local GenreText = Genre:WaitForChild("Text")
local GameID = List:WaitForChild("GameID")
local GameVersion = List:WaitForChild("GameVersion")
local ServerTime = List:WaitForChild("ServerTime")
local ServerType = List:WaitForChild("ServerType")
local FPS = List:WaitForChild("FPS")
local Ping = List:WaitForChild("Ping")
local ScriptHub = Base:WaitForChild("ScriptHub")
local Commands = Base:WaitForChild("Commands")
local Bar = RealBase:WaitForChild("Bar")
local CMDBar = Bar:WaitForChild("CMDBar")
local Focus = Bar:WaitForChild("Focus")
local SBar = CMDBar:WaitForChild("SBar")
local SearchResults = CMDBar:WaitForChild("SearchResults")
local Scroll = ScriptHub:WaitForChild("ScrollingFrame")
local Search = ScriptHub:WaitForChild("Search")["Text"]
local Executor = Base:WaitForChild("Execution")
local Script = Executor:WaitForChild("Script")
local Source = Script:WaitForChild("Script_Box")
local Hidden = Script:WaitForChild("Hidden")
local Lines	= Script:WaitForChild("Line")
local Execute = Executor:WaitForChild("Execute")
local Clear = Executor:WaitForChild("Clear")
local Check = Executor:WaitForChild("Check")
local Checked = Check:WaitForChild("Checked")
local Logs = Base:WaitForChild("Logs")
local Output = Logs["Image"]:WaitForChild("Output")
local ClearOutput = Logs:WaitForChild("Clear")
local Settings = Base:WaitForChild("Settings")
local ServerWiseCheck = Settings["Execution"]["List"]:WaitForChild("ServerWise")
local ServerWiseChecked = ServerWiseCheck:WaitForChild("Checked")
local LuaCCheck = Settings["Execution"]["List"]:WaitForChild("LuaC")
local LuaCChecked = LuaCCheck:WaitForChild("Checked")
local ChatCmdsCheck = Settings["Commands"]["List"]:WaitForChild("Chat")
local AltBarCheck = Settings["Commands"]["List"]:WaitForChild("AltCmdBar")
local ChatCmdsChecked = ChatCmdsCheck:WaitForChild("Checked")
local Logger = Resources.Assets:WaitForChild("Logger")
local Tabs = Side:WaitForChild("Tabs")
local Header = Base:WaitForChild("Header")
local Alert = Base:WaitForChild("Alert")
local Exit = Header:WaitForChild("Exit")
local Minimize = Header:WaitForChild("Minimize")
local Time = Side:WaitForChild("Time")
local Admin = Main["Stuff"]:WaitForChild("Admin")
local Cmds = Admin:InvokeServer("getCMDS")
local Example = Resources:WaitForChild("Example")
local AlertRemote = Resources["Assets"]:WaitForChild("Alert")
local Helper = require(script:WaitForChild("Helper"))
local Pos = Home.Position
local CurrentPing = tick()
local ButtonsT = {}
local TabsT = {}
local FrameT = {}
local PageT	= false
local Toggle = false
local Server = true
local Client = false
local LuaU = true
local LuaC = false
local ChatCmds = false
local AltCmdBar = false
local Minimized = false
local TotalLines = 0
local Recent = nil
local RecentText = ""
local SpamCount = 1
local dragToggl = nil
local dragInput = nil
local dragStart = nil
local dragPos = nil
local studio = game:GetService("RunService"):IsStudio()
local lua_keywords	= {"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}
local global_env = {"getrawmetatable", "game", "workspace", "script", "math", "string", "table", "print", "wait", "BrickColor", "Color3", "next", "pairs", "ipairs", "select", "unpack", "Instance", "Vector2", "Vector3", "CFrame", "Ray", "UDim2", "Enum", "assert", "error", "warn", "tick", "loadstring", "_G", "shared", "getfenv", "setfenv", "newproxy", "setmetatable", "getmetatable", "os", "debug", "pcall", "ypcall", "xpcall", "rawequal", "rawset", "rawget", "tonumber", "tostring", "type", "typeof", "_VERSION", "coroutine", "delay", "require", "spawn", "LoadLibrary", "settings", "stats", "time", "UserSettings", "version", "Axes", "ColorSequence", "Faces", "ColorSequenceKeypoint", "NumberRange", "NumberSequence", "NumberSequenceKeypoint", "gcinfo", "elapsedTime", "collectgarbage", "PhysicalProperties", "Rect", "Region3", "Region3int16", "UDim", "Vector2int16", "Vector3int16"}
local unpack = unpack or table.unpack
local cache = {}
local memory, address = {states = {}, threads = {}}, 0x0000001
_G.cval = Player.Name

repeat
	game:GetService("RunService").RenderStepped:wait()
until Cmds

-- edited with <3 by nosyliam
local lua_keywords = {"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}
local global_env = {"getrawmetatable", "game", "workspace", "script", "math", "string", "table", "print", "wait", "BrickColor", "Color3", "next", "pairs", "ipairs", "select", "unpack", "Instance", "Vector2", "Vector3", "CFrame", "Ray", "UDim2", "Enum", "assert", "error", "warn", "tick", "loadstring", "_G", "shared", "getfenv", "setfenv", "newproxy", "setmetatable", "getmetatable", "os", "debug", "pcall", "ypcall", "xpcall", "rawequal", "rawset", "rawget", "tonumber", "tostring", "type", "typeof", "_VERSION", "coroutine", "delay", "require", "spawn", "LoadLibrary", "settings", "stats", "time", "UserSettings", "version", "Axes", "ColorSequence", "Faces", "ColorSequenceKeypoint", "NumberRange", "NumberSequence", "NumberSequenceKeypoint", "gcinfo", "elapsedTime", "collectgarbage", "PhysicalProperties", "Rect", "Region3", "Region3int16", "UDim", "Vector2int16", "Vector3int16"}

local Highlight = function(string, keywords)
	local K = {}
	local S = string
	local Token =
		{
			["="] = true,
			["."] = true,
			[","] = true,
			["("] = true,
			[")"] = true,
			["["] = true,
			["]"] = true,
			["{"] = true,
			["}"] = true,
			[":"] = true,
			["*"] = true,
			["/"] = true,
			["+"] = true,
			["-"] = true,
			["%"] = true,
			[";"] = true,
			["~"] = true
		}
	for i, v in pairs(keywords) do
		K[v] = true
	end
	S = S:gsub(".", function(c)
		if Token[c] ~= nil then
			return "\32"
		else
			return c
		end
	end)
	S = S:gsub("%S+", function(c)
		if K[c] ~= nil then
			return c
		else
			return (" "):rep(#c)
		end
	end)

	return S
end

local hTokens = function(string)
	local Token =
		{
			["="] = true,
			["."] = true,
			[","] = true,
			["("] = true,
			[")"] = true,
			["["] = true,
			["]"] = true,
			["{"] = true,
			["}"] = true,
			[":"] = true,
			["*"] = true,
			["/"] = true,
			["+"] = true,
			["-"] = true,
			["%"] = true,
			[";"] = true,
			["~"] = true
		}
	local A = ""
	string:gsub(".", function(c)
		if Token[c] ~= nil then
			A = A .. c
		elseif c == "\n" then
			A = A .. "\n"
		elseif c == "\t" then
			A = A .. "\t"
		else
			A = A .. "\32"
		end
	end)

	return A
end


local strings = function(string)
	local highlight = ""
	local quote = false
	string:gsub(".", function(c)
		if quote == false and c == "\"" then
			quote = true
		elseif quote == true and c == "\"" then
			quote = false
		end
		if quote == false and c == "\"" then
			highlight = highlight .. "\""
		elseif c == "\n" then
			highlight = highlight .. "\n"
		elseif c == "\t" then
			highlight = highlight .. "\t"
		elseif quote == true then
			highlight = highlight .. c
		elseif quote == false then
			highlight = highlight .. "\32"
		end
	end)

	return highlight
end

local comments = function(string)
	local ret = ""
	string:gsub("[^\r\n]+", function(c)
		local comm = false
		local i = 0
		c:gsub(".", function(n)
			i = i + 1
			if c:sub(i, i + 1) == "--" then
				comm = true
			end
			if comm == true then
				ret = ret .. n
			else
				ret = ret .. "\84"
			end
		end)
		ret = ret
	end)

	return ret
end

local numbers = function(string)
	local A = ""
	string:gsub(".", function(c)
		if tonumber(c) ~= nil then
			A = A .. c
		elseif c == "\n" then
			A = A .. "\n"
		elseif c == "\t" then
			A = A .. "\t"
		else
			A = A .. "\32"
		end
	end)

	return A
end

local getCurrentLineLength = function()
	local num = 0
	repeat
		num = num + 1
	until string.sub(Source.Text, Source.CursorPosition - num, Source.CursorPosition - num) == "\n" or (Source.CursorPosition - num <= 0)
	return num
end

local getCurrentLine = function()
	local lin = 1
	Source.Text:sub(1, Source.CursorPosition):gsub("\n", function()
		lin = lin + 1
	end)
	return lin
end

local getNumLines = function()
	local lin = 1
	Source.Text:gsub("\n", function()
		lin = lin + 1
	end)
	return lin
end

local getLongestLine = function()
	local longest, i = 0, 0
	for line in Source.Text:gmatch("([^\r\n]*)[\r\n]?") do
		longest = string.len(line) > longest and string.len(line) or longest
	end
	return longest
end

local getLineInset = function()
	local pos, lineInset = Source.CursorPosition, 0
	repeat
		pos = pos - 1
		lineInset = lineInset + 1
	until string.sub(Source.Text, pos, pos) == "\n" or pos <= 0
	return lineInset
end

local highlight_source = function(type)
	if type == "Text" or type == "CursorPosition" then
		Source.Text = Source.Text:gsub("\13", "")
		Source.Text = Source.Text:gsub("\t", "      ")
		local s = Source.Text
		Source.Keywords_.Text = Highlight(s, lua_keywords)
		Source.Globals_.Text = Highlight(s, global_env)
		Source.RemoteHighlight_.Text = Highlight(s, {"FireServer", "fireServer", "InvokeServer", "invokeServer"})
		Source.Tokens_.Text = hTokens(s)
		Source.Numbers_.Text = numbers(s)
		Source.Strings_.Text = strings(s)
		Lines.Text = ""
		for i = 1, getNumLines() do
			Lines.Text = Lines.Text .. i .. "\n"
		end
		Lines.Size = UDim2.new(0, 26, 0, math.max(10000, (15 * getNumLines()) + 5))
		Script.CanvasSize = UDim2.new(0, 8 * getLongestLine(), 0, (15 * getNumLines()) + 5)
		if Script.CanvasPosition.X < (8 * getCurrentLineLength())-276 then
			movedAway = false
		end
		local top = math.floor(Script.CanvasPosition.Y / 15) + 2
		local bottom = math.min(top + 16, getNumLines())
		if getCurrentLine() > bottom then
			Script.CanvasPosition = Script.CanvasPosition + Vector2.new(0, 15)
			if bottom == 15 then
				Script.CanvasPosition = Script.CanvasPosition + Vector2.new(0, 5)
			end
		end
		if getCurrentLine() < top then
			Script.CanvasPosition = Script.CanvasPosition + Vector2.new(0, -15)
		end
		if movedAway then
		elseif 8 * getCurrentLineLength() > 266 then
			Script.CanvasPosition = Vector2.new((8 * getCurrentLineLength())-266, Script.CanvasPosition.Y)
		else
			Script.CanvasPosition = Vector2.new(0, Script.CanvasPosition.Y)
		end
		if getCurrentLine() == getNumLines() and Source.TextBounds.Y > 240 and (not scrolledAway) then
			Script.CanvasPosition = Vector2.new(Script.CanvasPosition.X, (getNumLines() * 15) + 5)
		end
		Source.Size = UDim2.new(0, math.max((getLongestLine() * 8), 266) + 4, 0, math.max(getNumLines() * 15, 250))
		Lines.Position = UDim2.new(0, 0, 0, -Script.CanvasPosition.Y)
	end
end

local move_lines = function(type)
	if type == "CanvasPosition" then
		Lines.Position = UDim2.new(0, 0, 0, -Script.CanvasPosition.Y)
	end
end

local types = {
	LUA_TNONE = -1,
	LUA_TNIL = 0,
	LUA_TBOOLEAN = 1,
	LUA_TLIGHTUSERDATA = 2,
	LUA_TNUMBER = 3,
	LUA_TSTRING = 4,
	LUA_TTABLE = 5,
	LUA_TFUNCTION = 6,
	LUA_TUSERDATA = 7,
	LUA_TTHREAD = 8
}
local gcactions = {
	'LUA_GCSTOP',
	'LUA_GCRESTART',
	'LUA_GCCOLLECT',
	'LUA_GCCOUNT',
	'LUA_GCCOUNTB',
	'LUA_GCSTEP',
	'LUA_GCSETPAUSE',
	'LUA_GCSETSTEPMUL'
}
local sign = function(n)
	return n < 0 and -1 or n > 0 and 1 or 0
end
local gettype = function(...)
	if select('#', ...) == 0 then
		return types.LUA_TNONE
	elseif type(...) == 'nil' then
		return types.LUA_TNIL
	elseif type(...) == 'boolean' then
		return types.LUA_TBOOLEAN
	elseif type(...) == 'number' then
		return types.LUA_TNUMBER
	elseif type(...) == 'string' then
		return types.LUA_TSTRING
	elseif type(...) == 'table' then
		return types.LUA_TTABLE
	elseif type(...) == 'function' then
		return types.LUA_TFUNCTION
	elseif type(...) == 'userdata' and #... ~= 'fthread' then
		return types.LUA_TUSERDATA
	elseif type(...) == 'thread' or #... == 'fthread' then
		return types.LUA_TTHREAD
	end
	return types.LUA_TLIGHTUSERDATA
end
local push = function(L, v)
	L.stacksize = L.stacksize + 1
	L.stack[L.stacksize] = v
end
local getaddress = function()
	address = address + 0x01
	return string.format('0x%07x', address)
end
local stackKey = function(L, i)
	return (sign(i) == -1 and (L.stacksize + 1) + i) or i
end
local get = function(L, i)
	return L.stack[(sign(i) == -1 and (L.stacksize + 1) + i) or i]
end
local set = function(L, i, v)
	L.stack[(sign(i) == -1 and (L.stacksize + 1) + i) or i] = v
end
local shift = function(L, s, n)
	if sign(s) == -1 then
		for i = ((sign(n) == -1 and (L.stacksize + 1) + n) or n) + 1, L.stacksize do
			L.stack[i - 1] = L.stack[i]
		end
		set(L,  L.stacksize, nil)
		L.stacksize = L.stacksize - 1
	else
		local new = {}
		for i = (sign(n) == -1 and L.stacksize - n or n), L.stacksize do
			new[i + 1] = L.stack[i]
		end
		for k, v in next, new do
			L.stack[k] = v
		end
		set(L, n, nil)
		L.stacksize = L.stacksize + 1
	end
end
local pop = function(L, i)
	local val = get(L, i)
	set(L, i, nil)
	shift(L, -1, i)
	return val
end
local lua_functions = {
	LUA_MULTRET = -math.huge,
	luaL_newstate = function()
		local state = newproxy(true)
		getmetatable(state).__tostring = function() return 'state: ' .. memory[state] end
		getmetatable(state).__index = function(...) error('Lua state libraries not open (luaL_openlibs(L))', 0) end
		memory[state] = state
		return state
	end,
	luaL_openlibs = function(L)
		getmetatable(L).__index = {stack = {}, stacksize = 0, memory = {}}
		getmetatable(L).__newindex = getmetatable(L).__index
		return L
	end,
	luaL_loadstring = function(L, s)
		return loadstring(s)
	end,
	lua_close = function(L)
		memory[L] = nil
	end,
	lua_getglobal = function(L, g)
		push(L, getfenv(0)[g] or cache[g])
	end,
	lua_setglobal = function(L, n)
		cache[n] = get(L, -1)
	end,
	lua_getfenv = function(L, n)
		push(L, setmetatable(cache, {__index = getfenv(n)}))
	end,
	lua_setfenv = function(L, n)
		cache = {}
		local instr = pop(L, -1)
		setfenv(n, instr)
		push(L, (type(instr) ~= 'function' and type(instr) ~= 'thread' and type(instr) ~= 'userdata' and 0) or 1)
	end,
	lua_getfield = function(L, n, k)
		push(L, get(L, n)[k])
	end,
	lua_gettable = function(L, i)
		push(L, get(L, i)[pop(L, -1)])
	end,
	lua_getmetatable = function(L, n)
		if getmetatable(get(L, n)) and get(L, n) then
			push(L, getmetatable(get(L, n)))
		else
			return 0
		end
	end,
	lua_setmetatable = function(L, n)
		set(L, n, setmetatable(get(L, n), pop(L, -1)))
	end,
	lua_createtable = function(L, n)
		push(L, {})
	end,
	lua_settable = function(L, n)
		get(L, n)[pop(L, -2)] = pop(L, -1)
	end,
	lua_settop = function(L, n)
		if stackKey(L, n) < L.stacksize then
			for i = stackKey(L, n) + 1, L.stacksize do
				shift(L, -1, -1)
			end
		else
			for i = L.stacksize, stackKey(L, n) do
				push(L, nil)
			end
		end
	end,
	lua_pop = function(L, n)
		for i = 1, n do
			shift(L, -1, -1)
		end
	end,
	lua_setfield = function(L, n, k)
		get(L, n)[k] = pop(L, -1)
	end,
	lua_gettop = function(L)
		return L.stacksize
	end,
	lua_toboolean = function(L, n)
		return get(L, n) and 1 or 0
	end,
	lua_tointeger = function(L, n)
		return tonumber(get(L, n))
	end,
	lua_tonumber = function(L, n)
		return tonumber(get(L, n))
	end,
	lua_tostring = function(L, n)
		return tostring(get(L, n))
	end,
	lua_tolstring = function(L, n, len)
		return len and string.sub(get(L, n), 1, len) or tostring(get(L, n))
	end,
	lua_iscfunction = function(L, n)
		return pcall(string.dump, get(L, n)) and 1 or 0
	end,
	lua_isfunction = function(L, n)
		return L, type(get(L, n)) == 'function' and 1 or 0
	end,
	lua_isnil = function(L, n)
		return get(L, n) == nil and 1 or 0
	end,
	lua_isnoneornil = function(L, n)
		return get(L, n) == nil and 1 or 0
	end,
	lua_isthread = function(L, n)
		return type(get(L, n)) == 'thread' and 1 or 0
	end,
	lua_istable = function(L, n)
		return type(get(L, n)) == 'table' and 1 or 0
	end,
	lua_isuserdata = function(L, n)
		return type(get(L, n)) == 'userdata' and 1 or 0
	end,
	lua_isstring = function(L, n)
		return type(get(L, n)) == 'string' and 1 or 0
	end,
	lua_isnumber = function(L, n)
		return type(get(L, n)) == 'number' and 1 or 0
	end,
	lua_isboolean = function(L, n)
		return type(get(L, n)) == 'boolean' and 1 or 0
	end,
	lua_lessthan = function(L, n1, n2)
		return get(L, n1) < get(L, n2) and 1 or 0
	end,
	lua_equal = function(L, n1, n2)
		return get(L, n1) == get(L, n2) and 1 or 0
	end,
	lua_rawequal = function(L, n1, n2)
		return rawequal(n1, n2) and 1 or 0
	end,
	lua_rawgeti = function(L, i, n)
		return rawget(get(L, i), n)
	end,
	lua_rawseti = function(L, i, n)
		return rawset(get(L, i)), n, pop(L, -1)
	end,
	lua_gettop = function(L, i)
		return L.stacksize
	end,
	lua_next = function(L, i)
		local res = next(get(L, -1))
		push(L, res == nil and types.LUA_TNIL or res, i)
	end,
	lua_type = function(L, ...)
		return gettype(...)
	end,
	lua_typename = function(L, n)
		local tvalue = gettype(get(L, n))
		for typename, value in next, types do
			if tvalue == value then
				return typename
			end
		end
		return 'LUA_TNONE'
	end,
	lua_newthread = function(L, nresults)
		local thread = newproxy(true)
		local cache = {}
		local f = {}
		memory[L][thread] = getaddress()
		getmetatable(thread).__tostring = function() return 'fthread: ' .. memory[L][thread] end
		getmetatable(thread).__index = cache
		getmetatable(thread).__len = function(self) return 'fthread' end
		getmetatable(thread).__call = function(self, c)
			if not cache[c] then
				local rthread = coroutine.create(c)
				cache[rthread] = getaddress()
				cache[c] = rthread
				return rthread
			else
				return cache[c]
			end
		end
		push(L, thread)
	end,
	lua_yield = function(L, nresults)
		return select(coroutine.yield(), 1, nresults)
	end,
	lua_resume = function(L, narg)
		local f = L.stack[L.stacksize - narg]
		local t = L.stack[L.stacksize - narg - 1]
		local args, n = {}, 0
		for i = (L.stacksize + 1) - narg, L.stacksize do
			n = n + 1
			args[n] = L.stack[i]
		end
		for i = (L.stacksize + 1) - narg, L.stacksize do
			shift(L, -1, i)
		end
		local val = {pcall(coroutine.resume, t(f), unpack(args, 1, n))}
		local s, m = val[1], {select(2, unpack(val))}
		shift(L, -1, -1)
		shift(L, -1, -1)
		push(L, select(2, unpack(val)))
	end,
	lua_pushboolean = function(L, b)
		assert(type(b) == 'boolean', 'Argument type "' .. type(b) .. '" is incompatible with parameter of type boolean')
		push(L, b)
	end,
	lua_pushnil = function(L)
		push(L, nil)
	end,
	lua_pushnumber = function(L, n)
		assert(type(n) == 'number', 'Argument type "' .. type(n) .. '" is incompatible with parameter of type number')
		push(L, n)
	end,
	lua_pushstring = function(L, s)
		assert(type(s) == 'string', 'Argument type "' .. type(s) .. '" is incompatible with parameter of type string')
		push(L, s)
	end,
	lua_pushtable = function(L, t)
		assert(type(t) == 'table', 'Argument type "' .. type(t) .. '" is incompatible with parameter of type table')
		push(L, t)
	end,
	lua_pushvalue = function(L, n)
		push(L, get(L, n))
	end,
	lua_pushclosure = function(L, c)
		assert(type(c) == 'function', 'Argument type "' .. type(c) .. '" is incompatible with parameter of type function')
		push(L, c)
	end,
	lua_remove = function(L, n)
		pop(L, n)
		shift(L, -1, n)
	end,
	lua_insert = function(L, n)
		local element = get(L, -1)
		shift(L, 1, n)
		set(L, n, element)
	end,
	lua_pcall = function(L, nargs, nresults, errfunc)
		local f = L.stack[L.stacksize - nargs]
		local args, n = {}, 0
		for i = (L.stacksize + 1) - nargs, L.stacksize do
			n = n + 1
			args[n] = L.stack[i]
		end
		for i = (L.stacksize + 1) - nargs, L.stacksize do
			shift(L, -1, i)
		end
		local val = {pcall(f, unpack(args, 1, n))}
		local s, m = val[1], {select(2, unpack(val))}
		local r = {unpack(m, 1, nresults == -math.huge and #m or nresults)}
		shift(L, -1, -1)
		if not s and errfunc ~= 0 then
			push(L, get(L, errfunc)(m))
		else
			push(L, select(2, unpack(val)))
		end
	end,
	lua_call = function(L, nargs, nresults)
		local f = L.stack[L.stacksize - nargs]
		assert(type(f) == 'function', 'Unprotected error in call to Lua API (attempt to call a ' .. type(f) .. ' value)')
		local args, n = {}, 0
		for i = (L.stacksize + 1) - nargs, L.stacksize do
			n = n + 1
			args[n] = L.stack[i]
		end
		for i = (L.stacksize + 1) - nargs, L.stacksize do
			shift(L, -1, i)
		end
		local val = {f(unpack(args, 1, n))}
		local r = {unpack(val, 1, nresults == -math.huge and #val or nresults)}
		shift(L, -1, -1)
		push(L, unpack(r))
	end,
	emptystack = function(L)
		L.stack = {}
		L.stacksize = 0
	end
}

local function emu(scr)
	local L = luaL_newstate()
	luaL_openlibs(L)

	local function reconstruct_string(t, idx) 
		local ret = ""
		for i=idx,#t do
			ret = ret .. t[i] .. " "
		end
		return ret:sub(1, -2)
	end

	local function convert_number(str, pc)
		local res = tonumber(str)
		assert(type(res) == "number", "invalid number (pc = " .. tostring(pc) .. ")")
		return res
	end

	local pc = 1
	for line in scr:gmatch("([^\n]*)\n?") do
		local args = {}
		for arg in string.gmatch(line, "%S+") do table.insert(args, arg) end
		if #args >= 1 then
			if args[1] == "getglobal" then
				assert(#args >= 2, "invalid amount of arguments (getglobal, pc = " .. tostring(pc) .. ")")
				lua_getglobal(L, reconstruct_string(args, 2))
			elseif args[1] == "getfield" then
				assert(#args >= 3, "invalid amount of arguments (getfield, pc = " .. tostring(pc) .. ")")
				lua_getfield(L, convert_number(args[2], pc), reconstruct_string(args, 3))
			elseif args[1] == "setfield" then
				assert(#args >= 3, "invalid amount of arguments (setfield, pc = " .. tostring(pc) .. ")")
				lua_setfield(L, convert_number(args[2], pc), reconstruct_string(args, 3))
			elseif args[1] == "pushvalue" then
				assert(#args == 2, "invalid amount of arguments (pushvalue, pc = " .. tostring(pc) .. ")")
				lua_pushvalue(L, convert_number(args[2], pc))
			elseif args[1] == "pcall" then
				assert(#args == 4, "invalid amount of arguments (pcall, pc = " .. tostring(pc) .. ")")
				lua_pcall(L, convert_number(args[2], pc), convert_number(args[3], pc), convert_number(args[4], pc))
			elseif args[1] == "call" then
				assert(#args == 3, "invalid amount of arguments (call, pc = " .. tostring(pc) .. ")")
				lua_pcall(L, convert_number(args[2], pc), convert_number(args[3], pc))
			elseif args[1] == "pushnumber" then
				assert(#args == 2, "invalid amount of arguments (pushnumber, pc = " .. tostring(pc) .. ")")
				lua_pushnumber(L, convert_number(args[2], pc))
			elseif args[1] == "pushboolean" or args[1] == "pushbool" then
				assert(#args == 2, "invalid amount of arguments (pushboolean, pc = " .. tostring(pc) .. ")")
				if args[2] == "true" then
					lua_pushboolean(L, true)
				elseif args[2] == "false" then
					lua_pushboolean(L, false)
				else
					error("invalid boolean, pc = " .. tostring(pc))
				end
			elseif args[1] == "pushnil" then
				lua_pushnil(L)
			elseif args[1] == "pushstring" then
				assert(#args >= 2, "invalid amount of arguments (pushstring, pc = " .. tostring(pc) .. ")")
				lua_pushstring(L, reconstruct_string(args, 2))
			elseif args[1] == "settop" then
				assert(#args == 2, "invalid amount of arguments (settop, pc = " .. tostring(pc) .. ")")
				lua_settop(L, convert_number(args[2], pc))
			elseif args[1] == "remove" then
				assert(#args == 2, "invalid amount of arguments (remove, pc = " .. tostring(pc) .. ")")
				lua_remove(L, convert_number(args[2], pc))
			elseif args[1] == "pop" then
				assert(#args == 2, "invalid amount of arguments (pop, pc = " .. tostring(pc) .. ")")
				lua_pop(L, convert_number(args[2], pc))
			elseif args[1] == "emptystack" then
				emptystack(L)
			end
			pc = pc + 1
		end
	end

	lua_close(L)
end

local femu = setfenv(emu, setmetatable(lua_functions, {__index = getfenv(1)}))

local Tween = function(Object, Time, Style, Direction, Customization)
	if Style or Direction then
		game:GetService("TweenService"):Create(Object, TweenInfo.new(Time, Enum["EasingStyle"][Style], Enum["EasingDirection"][Direction]), Customization):Play()
	else
		game:GetService("TweenService"):Create(Object, TweenInfo.new(Time), Customization):Play()
	end
end

local updateInput = function(input)
	local Delta = input.Position - dragStart
	local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
	Tween(RealBase, .1, "Linear", "In", {Position = Position})
end

--[[function ToggleHide()
if Toggle == false then
	Toggle = true
	Tween(Switch, 0.1, "Linear", "InOut", {ImageColor3 = Color3.fromRGB(0, 170, 255)})
	Tween(Circle, 0.1, "Linear", "InOut", {Position = UDim2.new(0.475, 0, 0.084, 0)})
	Hidden.Visible = true
	Hidden.Text = string.rep("#", string.len(Source.Text))
	Source.TextTransparency = 1
elseif Toggle == true then
	Toggle = false
	Tween(Switch, 0.1, "Linear", "InOut", {ImageColor3 = Color3.fromRGB(84, 84, 84)})
	Tween(Circle, 0.1, "Linear", "InOut", {Position = UDim2.new(0.055, 0, 0.084, 0)})
	Hidden.Visible = false
	Hidden.Text	= ""
	Source.TextTransparency = 0
end
end]]

local AutoButtonColor = function(button, enter, leave)
	button.MouseEnter:Connect(function()
		if button:IsA("ImageButton") then
			Tween(button, .1, "Linear", "InOut", {ImageColor3 = enter})
		else
			Tween(button, .1, "Linear", "InOut", {BackgroundColor3 = enter})
		end
	end)

	button.MouseLeave:Connect(function()
		if button:IsA("ImageButton") then
			Tween(button, .1, "Linear", "InOut", {ImageColor3 = leave})
		else
			Tween(button, .1, "Linear", "InOut", {BackgroundColor3 = leave})
		end
	end)
end

local AutoLabelColor = function(label, enter, leave)
	label.MouseEnter:Connect(function()
		Tween(label, .1, "Linear", "InOut", {ImageColor3 = enter})
	end)

	label.MouseLeave:Connect(function()
		Tween(label, .1, "Linear", "InOut", {ImageColor3 = leave})
	end)
end

function ButtonClick(Button)
	Button.MouseButton1Click:Connect(function()
		Tween(Button, 0.05, "Linear", "InOut", {ImageColor3 = Color3.fromRGB(70, 70, 70)})
		wait(0.15)
		Tween(Button, 0.75, "Quad", "Out", {ImageColor3 = Color3.fromRGB(40, 40, 40)})
	end)
end

local Ripple = function(Button)
	Button.MouseButton1Down:Connect(function()
		local Mouse	= game:GetService("Players").LocalPlayer:GetMouse()
		local Diagonal = math.sqrt((Button.Size.X.Offset) ^ 2 + (Button.Size.Y.Offset) ^ 2)
		local Size = UDim2.new(0, Diagonal * 2.15, 0, Diagonal * 2.15)
		local X = (Mouse.X) - (Button.AbsolutePosition.X)
		local Y = (Mouse.Y) - (Button.AbsolutePosition.Y)
		local Circle = Resources.Circle:Clone()
		Circle.Parent = Button
		Circle.Position	= UDim2.new(0, X, 0, Y)
		Circle.ZIndex = Button.ZIndex + 2
		Button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				while game:GetService("RunService").RenderStepped:wait() do
					if Circle.Size	== Size then
						Tween(Circle, .3, "Linear", "Out", {ImageTransparency = 1})
						wait(1.2)
						Circle:Destroy()
						break
					end
				end
			end
		end)

		Button.MouseButton1Up:Connect(function()
			wait(.17)
			Tween(Circle, .3, "Linear", "Out", {ImageTransparency = 1})
			wait(1.2)
			Circle:Destroy()
		end)

		Tween(Circle, .4, "Linear", "Out", {Size = Size})
	end)
end

function MaterialButton(Button)
	local Others = script.Others
	for i,v in pairs(Others:GetChildren()) do
		if v.Name == "Material_Button_LUA" then
			local b = v:Clone()
			b.Disabled = false
			b.Parent = Button
		else
			v:Clone().Parent = Button
		end
	end
end

function AlertFunc()
	Tween(Alert, 0.25, "Quad", "Out", {Position = UDim2.new(0, 0, 0.14, 0)})
	wait(3)
	Tween(Alert, 0.25, "Quad", "Out", {Position = UDim2.new(0, 0, 0.08, 0)})
end

function ExecClient(scr)
	if scr ~= "" then
		local Success, Error = pcall(function() Helper:loadstring(scr)() end)
		if Success then
			Execute.Text = "Executed!"
			wait(1.5)
			Execute.Text = "Execute"
		else
			Helper:AsyncFunction(function() -- Same thing as spawn() but this is faster
				error(Error)
			end)
			AlertFunc()
		end
	end
end

function ExecLuaC(scr)
	if scr ~= "" then
		local Success, Error = pcall(function() femu(scr) end)
		if not Success then
			Helper:AsyncFunction(function() -- Same thing as spawn() but this is faster
				error(Error)
			end)
			AlertFunc()
		end
	end
end

function GetPlayer(p)
	if not p then
		return p
	elseif p:IsA("Player") then
		return p
	elseif p:IsA('NetworkReplicator') then
		local p = p:GetPlayer();		
		if p ~= nil and p:IsA('Player') then
			return p
		end
	end
end

function findInTable(tbl, str)
	if tbl == nil then
		return false
	end
	for index, value in pairs(tbl) do
		if value == str then
			return true
		end
	end
	return false
end

function getInTable(tbl, str)
	if tbl == nil then
		return false
	end
	for index, value in pairs(tbl) do
		if value == str then
			return value
		end
	end
	return false
end

function findCMD(Name)
	for index, Value in pairs(Cmds)do
		if string.lower(Value.NAME) == string.lower(Name) then
			return Value
		end
	end
end

function getSuggestion(Word)
	if Word then
		local t = {}
		for Index, Value in pairs(Cmds) do
			if Value.NAME:sub(1, #Word) == Word then
				return Value.NAME
			elseif string.lower(Value.NAME:sub(1, #Word)) == string.lower(Word) then
				return string.lower(Value.NAME)
			end
		end
	end
end

function getResults(Word)
	if Word then
		local t = {}
		for Index, Value in pairs(Cmds) do
			if string.lower(Value.NAME:sub(1, #Word)) == string.lower(Word) then
				if #t < 6 then
					table.insert(t, Value.NAME)
				end
			end
		end
		return t
	else
		return {}
	end
end

local wrappercache = setmetatable({}, {__mode = "k"})
local NewProxy = setmetatable({}, {__mode = "v"})

function wrap(real)
	for w,r in next,wrappercache do
		if r == real then
			return w
		end
	end
	if type(real) == "userdata" then
		NewProxy[1] = newproxy(true)
		local fake = NewProxy[1]
		local meta = getmetatable(fake)

		meta.__index = function(s,k)
			return wrap(real[k])
		end

		meta.__newindex = function(s,k,v)
			real[k] = v
		end

		meta.__tostring = function(s)
			return tostring(real)
		end

		wrappercache[fake] = real
		return meta
	elseif type(real) == "function" then
		local fake = function(...)
			local args = unwrap{...}
			local results = wrap{real(unpack(args))}
			return unpack(results)
		end
		wrappercache[fake] = real
		return fake
	elseif type(real) == "table" then
		local fake = {}
		for k,v in next,real do
			fake[k] = wrap(v)
		end
		return fake
	else
		return real
	end
end

function unwrap(wrapped)
	if type(wrapped) == "table" then
		local real = {}
		for k,v in next,wrapped do
			real[k] = unwrap(v)
		end
		return real
	else
		local real = wrappercache[wrapped]
		if real == nil then
			return wrapped
		end
		return real
	end
end

function AddOrSubtractColor3(Type, Obj, R, G, B)
	if Type == "Add" then
		return Color3.new(
			Obj.R + R/255,
			Obj.G + G/255,
			Obj.B + B/255
		)
	elseif Type == "Subtract" then
		return Color3.new(
			Obj.R - R/255,
			Obj.G - G/255,
			Obj.B - B/255
		)
	end
end

Ripple(Clear)
Ripple(Execute)
MaterialButton(ClearOutput)
--Ripple(ClearOutput)
AutoButtonColor(Clear, Color3.fromRGB(46, 46, 46), Color3.fromRGB(40, 40, 40))
AutoButtonColor(Execute, Color3.fromRGB(46, 46, 46), Color3.fromRGB(40, 40, 40))
AutoButtonColor(ClearOutput, Color3.fromRGB(46, 46, 46), Color3.fromRGB(40, 40, 40))
AutoLabelColor(Search.Parent, Color3.fromRGB(46, 46, 46), Color3.fromRGB(40, 40, 40))
highlight_source("Text")

Source.Changed:Connect(highlight_source)
Script.Changed:Connect(move_lines)
currentInset, movingUp, movingDown, scrolledAway, movedAway = 0, false, false, false, false
game:GetService("UserInputService").InputEnded:connect(function(inp)
	if not Source:IsFocused() then highlight_source("Text") end
	highlight_source("Text")
	if inp.UserInputType == Enum.UserInputType.Keyboard then
		if inp.KeyCode == Enum.KeyCode.Left then
			currentInset = getLineInset()
		elseif inp.KeyCode == Enum.KeyCode.Right then
			currentInset = getLineInset()
		elseif inp.KeyCode == Enum.KeyCode.Up then
			movingUp = false
		elseif inp.KeyCode == Enum.KeyCode.Down then
			movingDown = false
		end
	end
end)
game:GetService("UserInputService").InputChanged:connect(function(inp)
	if not Source:IsFocused() then return end
	if inp.UserInputType == Enum.UserInputType.TextInput then
		currentInset = getLineInset()
	elseif inp.KeyCode == Enum.KeyCode.Left then
		currentInset = getLineInset()
	elseif inp.KeyCode == Enum.KeyCode.Right then
		currentInset = getLineInset()
	end
	if inp.UserInputType == Enum.UserInputType.MouseWheel then
		scrolledAway = true
		Script.CanvasPosition = Script.CanvasPosition - Vector2.new(0, 15 * inp.Position.Z)
	end
end)
game:GetService("UserInputService").InputBegan:connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		currentInset = getLineInset()
		if (inp.Position.X >= Script.AbsolutePosition.X + Script.AbsoluteSize.X - 5 and inp.Position.X <= Script.AbsolutePosition.X + Script.AbsoluteSize.X) then
			scrolledAway = true
			Source:ReleaseFocus()
		end
		if (inp.Position.Y >= Script.AbsolutePosition.Y + Script.AbsoluteSize.Y - 5 and inp.Position.Y <= Script.AbsolutePosition.Y + Script.AbsoluteSize.Y) then
			movedAway = true
			Source:ReleaseFocus()
		end
	end
	if not Source:IsFocused() then return end
	highlight_source("Text")
	if inp.KeyCode == Enum.KeyCode.Return then
		Script.CanvasPosition = Vector2.new(0, Script.CanvasPosition.Y)
		scrolledAway = false
		movedAway = false
	elseif inp.KeyCode == Enum.KeyCode.Up then
		movingUp = true
		waitTime = 0.5
		local function move()
			local pos, pLen = Source.CursorPosition, 0
			repeat
				pos = pos - 1
			until (string.sub(Source.Text, pos, pos) == "\n") or (0 >= pos) -- Go to end of line
			if pos == 0 then wait(waitTime) return end
			repeat -- Go to the start of the previous line
				pos = pos - 1
				pLen = pLen + 1
			until (string.sub(Source.Text, pos, pos) == "\n") or (0 >= pos)
			local inset = currentInset
			Source.CursorPosition = pos + math.min(currentInset, pLen)
			wait(waitTime)
		end
		move()
		if movingUp == false then return end
		waitTime = 0.05
		repeat
			move()
		until movingUp == false
	elseif inp.KeyCode == Enum.KeyCode.Down then
		movingDown = true
		waitTime = 0.5
		local function move()
			local pos, pLen = Source.CursorPosition, 0
			repeat
				pos = pos - 1
			until string.sub(Source.Text, pos, pos) == "\n" or pos > string.len(Source.Text) or 0 >= pos
			repeat -- Go to the start of the next line
				pos = pos + 1
			until string.sub(Source.Text, pos, pos) == "\n" or pos > string.len(Source.Text)
			repeat -- Find length of the next line
				pLen = pLen + 1
			until string.sub(Source.Text, pos + pLen, pos + pLen) == "\n" or pos + pLen > string.len(Source.Text)
			if pos == 0 then wait(waitTime) return end
			local inset = currentInset
			Source.CursorPosition = pos + math.min(currentInset, pLen)
			wait(waitTime)
		end
		move()
		if movingDown == false then return end
		waitTime = 0.05
		repeat
			move()
		until movingDown == false	
	end
end)

wait()

Source.Text = "print(\"Hello world!\")"

for _,v in pairs(Tabs:GetChildren()) do
	if v:IsA("ImageButton") then
		table.insert(TabsT, v)
	end
end

for _,v in pairs(Base:GetChildren()) do
	if v:IsA("Frame") then
		table.insert(FrameT, v)
	end
end

function NewLine(Text, Type)
	local New = Resources.LogExample:Clone()
	local Lines = 1
	local ColorType = Color3.fromRGB(255,255,255)

	if Type == Enum.MessageType.MessageError then
		ColorType = Color3.fromRGB(255,50,50)
	elseif Type == Enum.MessageType.MessageWarning then
		ColorType = Color3.fromRGB(255,218,66)
	elseif Type == Enum.MessageType.MessageInfo then
		ColorType = Color3.fromRGB(0,162,255)
	elseif Type == Enum.MessageType.MessageOutput then
		ColorType = Color3.fromRGB(255,255,255)
	end

	New.TextColor3 = ColorType or Color3.fromRGB(255,255,255)
	New.Text = Text or "ERROR: UNABLE TO REACH MESSAGE"

	if Recent then
		if New.Text == RecentText and New.TextColor3 == Recent.TextColor3 then
			SpamCount = SpamCount + 1
			Recent.Text = Recent.Text .. " (x" .. SpamCount .. ")"
		else
			for _ in string.gmatch(Text, "[^\n]+") do
				Lines = Lines + 1
			end
			TotalLines = TotalLines + Lines
			New.Parent = Output["Frame"]
			Recent = New
			RecentText = New.Text
			SpamCount = 1
			New.Size = UDim2.new(1, 0, 0, 14 * Lines)
			Output.CanvasSize = UDim2.new(0, 0, 0, 14 * TotalLines)
		end
	else
		for _ in string.gmatch(Text, "[^\n]+") do
			Lines = Lines + 1
		end
		TotalLines = TotalLines + Lines
		New.Parent = Output["Frame"]
		New.Size = UDim2.new(1, 0, 0, 14 * Lines)
		Recent = New
		RecentText = New.Text
		Output.CanvasSize = Output.CanvasSize + UDim2.new(0, 0, 0, 14 * TotalLines)
		SpamCount = 1
	end
end

local NewCommandLine = function(Text)
	local New = Resources.LogExample:Clone()
	local Lines = 1
	local ColorType = Color3.fromRGB(255,255,255)
	local CommandOutput = Commands["Info"]:WaitForChild("Scroll")

	New.TextColor3 = ColorType or Color3.new(1, 1, 1)
	New.Text = Text or "ERROR: UNABLE TO REACH MESSAGE"

	if Recent then
		if New.Text == RecentText and New.TextColor3 == Recent.TextColor3 then
			SpamCount = SpamCount + 1
			Recent.Text = Recent.Text .. " (x" .. SpamCount .. ")"
		else
			for _ in string.gmatch(Text, "[^\n]+") do
				Lines = Lines + 1
			end
			TotalLines = TotalLines + Lines
			New.Parent = CommandOutput
			Recent = New
			RecentText = New.Text
			SpamCount = 1
			New.Size = UDim2.new(1, 0, 0, 14 * Lines)
			CommandOutput.CanvasSize = UDim2.new(0, 0, 0, 14 * TotalLines)
		end
	else
		for _ in string.gmatch(Text, "[^\n]+") do
			Lines = Lines + 1
		end
		TotalLines = TotalLines + Lines
		New.Parent = CommandOutput
		New.Size = UDim2.new(1, 0, 0, 14 * Lines)
		Recent = New
		RecentText = New.Text
		CommandOutput.CanvasSize = CommandOutput.CanvasSize + UDim2.new(0, 0, 0, 14 * TotalLines)
		SpamCount = 1
	end
end

local CheckCheckbox = function(Box)
	local Back		= Box:WaitForChild("Back")
	local Hide		= Box:WaitForChild("Hide")
	local Checkedd	= Box:WaitForChild("Checked")
	local Ripple	= Box:WaitForChild("Ripple")
	Back.Visible	= true
	Checkedd.Visible	= true
	Hide.Visible	= true
	Tween(Box, .1, nil, nil, {ImageColor3 = Color3.fromRGB(66, 66, 66)})
	wait(.05)
	Tween(Hide, .1, nil, nil, {Position = UDim2.new(.8, 0, .14, 0), Size = UDim2.new(0, 0, 0, 16)})
	Ripple.ImageColor3		= Color3.fromRGB(66, 66, 66)
end

local UncheckCheckbox = function(Box)
	local Back		= Box:WaitForChild("Back")
	local Hide		= Box:WaitForChild("Hide")
	local Checkedd	= Box:WaitForChild("Checked")
	local Ripple	= Box:WaitForChild("Ripple")
	Back.Visible	= false
	Checkedd.Visible	= false
	Hide.Visible	= false
	Hide.Position	= UDim2.new(.35, 0, .14, 0)
	Hide.Size		= UDim2.new(0, 12, 0, 16)
	Tween(Box, .1, nil, nil, {ImageColor3 = Color3.fromRGB(66, 66, 66)})
	Ripple.ImageColor3	= Color3.fromRGB(66, 66, 66)
end

Logger.OnClientEvent:Connect(function(Text, Type)
	NewLine(Text, Type)
end)

for i, v in pairs(List:GetChildren()) do
	if v:IsA("ImageLabel") then
		AutoLabelColor(v, Color3.fromRGB(40, 40, 40), Color3.fromRGB(35, 35, 35))
	end
end

CheckCheckbox(ServerWiseCheck)
Welcome.Text = "Welcome, " .. Player.Name .. "!"
CommandsInt.Text.Text = "Number of commands: " .. #Cmds
if game.CreatorType == Enum.CreatorType.Group then
	CreatorType.Text.Text = "Creator type: Group"
else
	CreatorType.Text.Text = "Creator type: User"
end
GameName.Text.Text = "Game name: " .. game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name
Helper:AsyncFunction(function() -- Same thing as spawn() but this is faster
	while true do
		PlayersInt.Text.Text = "Server size: " .. tostring(#Players:GetPlayers()) .. " / " .. tostring(Players.MaxPlayers)
		ServerTime.Text.Text = "Server time: " .. tostring(workspace.DistributedGameTime)
		FPS.Text.Text = "FPS: " .. tostring(workspace:GetRealPhysicsFPS())
		local ptick = tick()
		local result
		if not studio then
			result = Remote:InvokeServer({Function = "GetPingResult", Args = {}})
		else
			result = false
		end
		if result == true then
			local ctick = tick()
			local ttick = math.floor(((ctick - ptick) %86400*1000) + 0.5)
			Ping.Text.Text = "Ping: " .. ttick .. "ms"
		end
		Time.Text = os.date("%X")
		wait(0.5)
	end
end)
if game:GetService("RunService"):IsStudio() then
	CreatorName.Text.Text = "Creator name: " .. (Player.Name or "N/A")
else
	CreatorName.Text.Text = "Creator name: " .. Players:GetNameFromUserIdAsync(game.CreatorId)
end
JobID.Text.Text = "Job ID: " .. game.JobId
if not studio then
	ServerType.Text.Text = "Server Type: " .. Remote:InvokeServer({Function = "GetServerType", Args = {}})
else
	ServerType.Text.Text = "Server Type: Studio"
end
ypcall(function()
	pcall(function()
		if game.Genre == Enum.Genre.Adventure then
			GenreText.Text = "Genre: Adventure"
		elseif game.Genre == Enum.Genre.All then
			GenreText.Text = "Genre: All"
		elseif game.Genre == Enum.Genre.Fantasy then
			GenreText.Text = "Genre: Fantasy"
		elseif game.Genre == Enum.Genre.Funny then
			GenreText.Text = "Genre: Funny"
		elseif game.Genre == Enum.Genre.Ninja then
			GenreText.Text = "Genre: Ninja"
		elseif game.Genre == Enum.Genre.Pirate then
			GenreText.Text = "Genre: Pirate"
		elseif game.Genre == Enum.Genre.Scary then
			GenreText.Text = "Genre: Scary"
		elseif game.Genre == Enum.Genre.SciFi then
			GenreText.Text = "Genre: SciFi"
		elseif game.Genre == Enum.Genre.SkatePark then
			GenreText.Text = "Genre: Skate Park"
		elseif game.Genre == Enum.Genre.Sports then
			GenreText.Text = "Genre: Sports"
		elseif game.Genre == Enum.Genre.TownAndCity then
			GenreText.Text = "Genre: Town and City"
		elseif game.Genre == Enum.Genre.Tutorial then
			GenreText.Text = "Genre: Tutorial"
		elseif game.Genre == Enum.Genre.War then
			GenreText.Text = "Genre: War"
		elseif game.Genre == Enum.Genre.WildWest then
			GenreText.Text = "Genre: Wild West"
		else
			GenreText.Text = "Genre: N/A"
		end
	end)
end)
GameID.Text.Text = "Game ID: " .. tostring(game.GameId)
GameVersion.Text.Text = "Game version: " .. tostring(game.PlaceVersion)

RealBase.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragToggle = true
		dragStart = input.Position
		startPos = RealBase.Position
		input.Changed:Connect(function()
			if (input.UserInputState == Enum.UserInputState.End) then
				dragToggle = false
			end
		end)
	end
end)

RealBase.InputChanged:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if (input == dragInput and dragToggle) then
		updateInput(input)
	end
end)

-- Scripts 

local Scroll = ScriptHub:WaitForChild("ScrollingFrame")

function CreateObj(Obj, Prop)
	local a, b = pcall(function()
		Instance.new(Obj)
	end)
	if not a then
		return
	end
	local o = Instance.new(Obj)
	for p, v in pairs(Prop) do
		pcall(function()
			o[p] = v
		end)
	end
	return o
end

function HookContainer(obj, ncan, sepr, stt)
	if not obj:IsA("ScrollingFrame") and not ncan then
		return nil
	elseif obj:IsA("ScrollingFrame") then
		obj.CanvasSize = UDim2.new(0, 0, 0, 0)
	end

	local self = {}
	local seperation = 12
	self.main = obj
	self.drawX = 0
	self.drawY = stt or seperation/2
	self.drawHeight = 0
	self.sepr = sepr or seperation

	function self:MakeButton(sz, txt, func, ysz, cbgd)
		local xposoffset = 0
		local xposscale = self.drawX
		local xszoffset = 0
		local xszscale = sz
		if self.drawX ~= 0 then
			xszoffset = -5
			if sz + self.drawX > 0.998 then
				xszoffset = -10
			end
		elseif sz == 1 then
			local bzz = 4
			if ncan then
				bzz = 0
			end
			xszoffset = (-self.sepr) - bzz
			xposoffset = self.sepr/2
		else
			xszoffset = -4 + -(self.sepr/2)
			xposoffset = self.sepr/2
		end
		if not ysz then
			ysz = 20
		end
		local Button = CreateObj("ImageButton", {
			Parent = ScriptHub:WaitForChild("ScrollingFrame"),
			AutoButtonColor = false,
			ImageColor3 = Color3.fromRGB(40, 40, 40),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(xposscale, xposoffset, 0,  self.drawY),
			Size = UDim2.new(xszscale, xszoffset, 0, ysz),
			ClipsDescendants = true,
			ZIndex = 2,
			Image = "rbxassetid://2790382281",
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(4, 4, 252, 252),
			SliceScale = 1
		})
		local Text = CreateObj("TextLabel", {
			Parent = Button,
			Size = UDim2.new(1, 0, 1, 0),
			BorderSizePixel = 0,
			Name = "Text",
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			Text = txt,
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 2,
		})
		MaterialButton(Button)
		Button.MouseButton1Click:Connect(func)
		if ysz > self.drawHeight then
			self.drawHeight = ysz
		end
		self.drawX = self.drawX + sz
		if self.drawX > 0.998 then
			self.drawY = self.drawY + 3 + self.drawHeight
			self.drawX = 0
			self.drawHeight = 0
			if not ncan then
				self.main.CanvasSize = UDim2.new(0, 0, 0, self.drawY + 5)
			end
		end
		return Button
	end

	function self:addSpacing()
		self.drawY = self.drawY + 3
	end

	function self:center()
		local a,c,b = self.main.Position.X.Scale, self.main.Position.X.Offset, self.main.Size.Y.Offset
		self.main.Position=UDim2.new(a,c+2, 0.5, -(b/2))
	end

	function self:GetChildren()
		return self.main:GetChildren()
	end

	function self:getDrawY()
		return self.drawY
	end

	function self:setDrawY(y)
		self.drawY = y
	end

	return self
end

local Scripts = HookContainer(Scroll)
local Orgin = Scripts:getDrawY()
for i = 1, 2 do
	Scripts:addSpacing()
end
local ScriptList = Helper:GetScripts()
local Container = {}

table.sort(ScriptList, function(Index, Value)
	return Index < Value
end)

function MakeList(condition)
	for i,v in pairs(Scripts:GetChildren()) do
		if v:IsA("ImageButton") then
			v:Destroy()
		end
	end
	Scripts:setDrawY(Orgin)
	for i,v in pairs(ScriptList) do
		if string.find(string.lower(v), string.lower(condition)) or condition == "" or condition == string.rep(" ", string.len(condition)) then
			local scr = Scripts:MakeButton(1, v, function()
				Remote:InvokeServer({Function = "Execute", Args = {'require(0x15cf48749)("' .. v .. '", "' .. Player.Name .. '")'}})
			end, 19)
			scr.Name = v
		end
	end
end
MakeList("")

function RefreshList(condition)
	for i,v in pairs(ScriptList) do
		if string.find(string.lower(v), string.lower(condition)) and condition ~= "" and condition ~= string.rep(" ", string.len(condition)) then
			local Button = ScriptHub:WaitForChild("Cache")[v]
			if Button then
				Button.Parent = Scroll
				Button.Visible = false
			end
		else
			local Button = Scroll[v]
			Button.Parent = ScriptHub:WaitForChild("Cache")
			Button.Visible = false
		end
	end
end

-- Players
-- credit to topkek for the idea of the players tab ig

local PlayersFrame = Base:WaitForChild("Players")
local PlayersRem = Resources:WaitForChild("Players")
local PlayersSearch = PlayersFrame:WaitForChild("Search")
local PlayerValue = PlayersFrame:WaitForChild("Player")
local PlayerText = PlayersFrame.Search:WaitForChild("Text")
local Scroll = PlayersFrame:WaitForChild("Scroll")
local PlrSearch = PlayersFrame:WaitForChild("Search")
local List = Scroll.Functions.List
local Headshot = Scroll["Avatar"]:WaitForChild("Image")
local UsernameText = Scroll:WaitForChild("Name")
local IDText = Scroll:WaitForChild("ID")
local AgeText = Scroll:WaitForChild("Age")
local TeamText = Scroll:WaitForChild("Team")
local RAPText = Scroll:WaitForChild("RAP")
local HTTP = game:GetService("HttpService")
local ButtonsT = {}
local CurrentP

function getPlayerSuggestion(Word)
	if Word then
		local t = {}
		for Index, Value in pairs(Players:GetPlayers()) do
			if Value.Name:sub(1, #Word) == Word then
				return Value.Name
			elseif string.lower(Value.Name:sub(1, #Word)) == string.lower(Word) then
				return string.lower(Value.Name)
			end
		end
	end
end

local function GetTotalRAP(userId)
	local success, msg = pcall(function()
		local total = 0

		local function CollectRAP(cursor)
			local url = "https://inventory.rprxy.xyz/v1/users/" .. userId .. "/assets/collectibles?sortOrder=Asc&limit=100"

			if cursor then
				url = url .. "&cursor=" .. cursor
			end

			local data = HTTP:GetAsync(url)
			data = HTTP:JSONDecode(data)

			for i = 1, #data["data"] do
				pcall(function()
					total = total + data["data"][i]["recentAveragePrice"]
				end)
			end

			if data["nextPageCursor"] then
				CollectRAP(data["nextPageCursor"])
			end
		end

		CollectRAP()

		return total
	end)

	if not success then
		warn("ERROR: Unable to collect RAP; make sure HttpEnabled is turned on")
		return "N/A"
	else
		return msg
	end
end

function UpdatePlayer(plri)
	local plr = Players:FindFirstChild(plri)
	if not plr then
		warn("Couldn't find player!")
		UpdatePlayer(Player.Name)
	end
	local Team = plr.TeamColor
	if Team == nil then
		Team = "Neutral"
	else
		Team = tostring(Team)
	end
	Headshot.Image = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
	UsernameText.Text = plr.Name
	IDText.Text = "ID: " .. tostring(plr.UserId)
	AgeText.Text = "Age: " .. tostring(plr.AccountAge)
	TeamText.Text = "Team: " .. Team
	RAPText.Text = "RAP: " .. GetTotalRAP(plr.UserId)
	CurrentP = plr
	print(CurrentP.Name)
end

function GetButtonAttribute(button, attribute)
	local atr = button:GetAttribute(attribute)
	if atr then
		return atr
	else
		return nil
	end
end

function GetTextboxText(button)
	local Text = List[GetButtonAttribute(button, "TextBox")]
	if Text then
		return Text.Text
	else
		return nil
	end
end

for i,v in pairs(PlayersFrame.Scroll.Functions.List:GetChildren()) do
	if v:IsA("TextButton") then
		table.insert(ButtonsT, v)
	end
end

PlrSearch.Text:GetPropertyChangedSignal("Text"):Connect(function()
	PlrSearch.Text.SBar.Text = getPlayerSuggestion(PlrSearch.Text.Text) or ""
end)

PlrSearch.Text.FocusLost:Connect(function()
	UpdatePlayer(PlrSearch.Text.Text)
	PlrSearch.Text.Text = ""
end)

--[[PlayersFrame.Search.Text.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		for Idx, Val in next, Players:GetPlayers() do
			--if string.lower(string.sub(Val.Name, 1, #Search.Text)) == string.lower(Search.Text) then
			if Val.Name == Search.Text.Text then
				UpdatePlayer(Val.Name)
			end
			--end
		end
		PlayersFrame.Search.Text.Text = ""
	end
end)]]

for i,v in pairs(Scroll.Functions.List:GetChildren()) do
	if v:IsA("TextButton") then
		AutoButtonColor(v, Color3.fromRGB(45, 45, 45), Color3.fromRGB(40, 40, 40))
		Ripple(v)
	end
end

for i,v in pairs(Scroll.Functions.List:GetChildren()) do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			if GetTextboxText(v) ~= nil then
				PlayersRem:InvokeServer(CurrentP, v.Name, GetTextboxText(v))
			else
				PlayersRem:InvokeServer(CurrentP, v.Name)
			end
		end)
	end
end

UpdatePlayer(Player.Name)

--

--[[wait(.5)

Tween(Base, .5, "Quart", "Out", {Size = UDim2.new(0, 481, 0, 333)})

wait(.5)

-- Animating intro
for Index = 1, 3 do
	Tween(Left, .4, "Quart", "InOut", {Size = UDim2.new(0, 12, 0, 22), BackgroundColor3 = Color3.fromRGB(59, 141, 210)})
	wait(.41)
	Tween(Left, .4, "Quart", "InOut", {Size = UDim2.new(0, 12, 0, 12), BackgroundColor3 = Color3.fromRGB(136, 136, 140)})
	wait(.16)
	Tween(Middle, .4, "Quart", "InOut", {Size = UDim2.new(0, 12, 0, 22), BackgroundColor3 = Color3.fromRGB(59, 141, 210)})
	wait(.41)
	Tween(Middle, .4, "Quart", "InOut", {Size = UDim2.new(0, 12, 0, 12), BackgroundColor3 = Color3.fromRGB(136, 136, 140)})
	wait(.16)
	Tween(Right, .4, "Quart", "InOut", {Size = UDim2.new(0, 12, 0, 22), BackgroundColor3 = Color3.fromRGB(59, 141, 210)})
	wait(.41)
	Tween(Right, .4, "Quart", "InOut", {Size = UDim2.new(0, 12, 0, 12), BackgroundColor3 = Color3.fromRGB(136, 136, 140)})
	wait(.16)
end

Tween(Intro, .5, "Quint", "InOut", {ImageTransparency = 1})
Tween(Left, .5, "Quint", "InOut", {BackgroundTransparency = 1})
Tween(Middle, .5, "Quint", "InOut", {BackgroundTransparency = 1})
Tween(Right, .5, "Quint", "InOut", {BackgroundTransparency = 1})]]

Resources.Assets.ShowCmds.OnClientEvent:Connect(function()
	for i,v in pairs(Cmds) do
		NewCommandLine(v.DESC)
	end
end)

Execute.MouseButton1Click:Connect(function()
	if Server == true and Client == false and LuaC == false and LuaU == true then
		Remote:InvokeServer({Function = "Execute", Args = {Source.Text}})
	elseif Server == false and Client == true and LuaC == false and LuaU == true then
		local API = setmetatable({}, {
			__index = function(_, Func)
				return getfenv(0)[Func] or function(...)
					local Data = {}
					Data["Function"] = Func
					Data["Args"] = {...}
					return Remote:InvokeServer(Data)
				end
			end
		})
		API["LocalPlayer"] = Player
		API["Mouse"] = Player:GetMouse()
		API["loadstring"] = function(...)
			return Helper:loadstring(...)
		end
		API["LoadLibrary"] = function(...)
			return require(Resources["Assets"].LoadLibrary)(...)
		end
		API["getrawmetatable"] = function(...)
			return wrap(...)
		end
		local Success, Error = pcall(function() Helper:loadstring(Source.Text, API)() end)
		if not Success then
			Helper:AsyncFunction(function()
				error(Error)
			end)
			AlertFunc()
		end
	elseif Server == true and Client == false and LuaC == true and LuaU == false then
		Remote:InvokeServer({Function = "ExecuteLuaC", Args = {Source.Text}})
	elseif Server == false and Client == true and LuaC == true and LuaU == false then
		ExecLuaC(Source.Text)
	end
end)

Clear.MouseButton1Click:Connect(function()
	Source.Text = ""
	if Toggle == true then
		Hidden.Text = ""
	end
end)

--[[Switch.MouseButton1Click:Connect(function()
ToggleHide()
end)]]

Exit.MouseButton1Click:Connect(function()
	Bar:Destroy()
	Tween(RealBase, 0.25, "Quad", "Out", {Size = UDim2.new(0, 631, 0, 0)})
	wait(0.25)
	Main:Destroy()
end)

--[[Minimize.MouseButton1Click:Connect(function()
	if not Minimized then
		Minimized = true
		for _, v in pairs(Base:GetChildren()) do
			if v ~= Header then
				v.Visible = false
			end
		end
		Tween(Base, 0.5, "Quart", "Out", {Size = UDim2.new(0, 481, 0, 27)})
	else
		Minimized = false
		for _, v in pairs(Base:GetChildren()) do
			v.Visible = true
		end
		Tween(Base, 0.5, "Quart", "Out", {Size = UDim2.new(0, 481, 0, 333)})
	end
end)]]

Check.MouseButton1Click:Connect(function()
	if Toggle == false then
		CheckCheckbox(Check)
		Hidden.Visible = true
		Hidden.Text = string.rep("#", string.len(Source.Text))
		Source.TextTransparency = 1
		Toggle = true
	end
end)

Checked.MouseButton1Click:Connect(function()
	if Toggle == true then
		UncheckCheckbox(Check)
		Hidden.Visible = false
		Hidden.Text	= ""
		Toggle = false
		Source.TextTransparency = 0
	end
end)

ServerWiseCheck.MouseButton1Click:Connect(function()
	if Server == false then
		CheckCheckbox(ServerWiseCheck)
		Server = true
		Client = false
	end
end)

ServerWiseChecked.MouseButton1Click:Connect(function()
	if Server == true then
		UncheckCheckbox(ServerWiseCheck)
		Server = false
		Client = true
	end
end)

LuaCCheck.MouseButton1Click:Connect(function()
	if LuaC == false then
		CheckCheckbox(LuaCCheck)
		LuaU = false
		LuaC = true
	end
end)

LuaCChecked.MouseButton1Click:Connect(function()
	if LuaC == true then
		UncheckCheckbox(LuaCCheck)
		LuaU = true
		LuaC = false
	end
end)

AltBarCheck.MouseButton1Click:Connect(function()
	if AltCmdBar == false then
		CheckCheckbox(AltBarCheck)
		AltCmdBar = true
	end
end)

AltBarCheck["Checked"].MouseButton1Click:Connect(function()
	if AltCmdBar == false then
		UncheckCheckbox(AltBarCheck)
		AltCmdBar = false
	end
end)

ChatCmdsCheck.MouseButton1Click:Connect(function()
	if ChatCmds == false then
		CheckCheckbox(ChatCmdsCheck)
		ChatCmds = true
	end
end)

ChatCmdsChecked.MouseButton1Click:Connect(function()
	if ChatCmds == true then
		UncheckCheckbox(ChatCmdsCheck)
		ChatCmds = false
	end
end)

ClearOutput.MouseButton1Click:Connect(function()
	for i,v in pairs(Output["Frame"]:GetChildren()) do
		if not v:IsA("UIListLayout") then
			v:Destroy()
		end
	end
	TotalLines = 0
	Output.CanvasSize = UDim2.new(0, 0, 0, 0)
end)

-- Commands

CMDBar:GetPropertyChangedSignal("Text"):Connect(function()
	while CMDBar.Text:sub(1, 1):match("%s") do
		CMDBar.Text = CMDBar.Text:sub(2)
	end

	SBar.Text = ""
	local Return = ""
	local Command = CMDBar.Text:match("%S+")	
	local Position = UDim2.new(0, -32, 0, -23)
	SearchResults:ClearAllChildren()

	for Idx, Val in pairs(getResults(Command)) do
		local Result = Example:Clone()
		local Return = ""
		local foundCMD = findCMD(Val)		
		Result.Visible = true

		for Index, Value in pairs(foundCMD.ALIAS) do
			Return = Return .. Value
			if Value == nil or Value == "" or #foundCMD.ALIAS == 0 then
				Return = "N/A"
			else
				if Index < #foundCMD.ALIAS then
					Return	= Return .. ", "
				end
			end
		end

		if foundCMD.DESC ~= "" then
			Result.Name	= foundCMD.NAME
			Result["Text"].Text	= "     " .. foundCMD.DESC .. " | " .. Return
		else
			Result.Name	= foundCMD.NAME
			Result["Text"].Text	= "     " .. foundCMD.NAME
		end

		--Result.Position	= Position
		--Result.Parent = SearchResults
		SBar.Text = getSuggestion(Command) or ""

		--[[Tween(Result, .15, "Linear", "Out", {ImageTransparency = 0})
		Tween(Result.Text, .15, "Linear", "Out", {TextTransparency = 0})
		Tween(Result, .15, "Linear", "Out", {Position = Result.Position + UDim2.new(0, 0, 0, -02)})

		Position = Position + UDim2.new(0, 0, 0, -21)]]
	end
end)

Search:GetPropertyChangedSignal("Text"):Connect(function()
	MakeList(Search.Text)
end)

CMDBar.Focused:Connect(function()
	game:GetService("RunService").RenderStepped:wait()
	CMDBar.Text = ""
	Tween(Bar, .25, "Quad", "Out", {Position = UDim2.new(.5, 0, .946, 0)})
	wait(.26)
	Tween(Focus, .35, "Quad", "Out", {Size = UDim2.new(1, 0, 0, 28)})
end)

CMDBar.FocusLost:Connect(function(enterPressed)
	game:GetService("RunService").RenderStepped:wait()
	SearchResults:ClearAllChildren()
	Tween(Focus, .35, "Quad", "Out", {Size = UDim2.new(0, 0, 0, 28)})
	wait(.36)
	Tween(Bar, .25, "Quad", "Out", {Position = UDim2.new(.5, 0, .86, 0)})
	if enterPressed then
		Admin:InvokeServer(CMDBar.Text)
	end
	CMDBar.Text = ""
end)

Player.Chatted:Connect(function(Msg)
	if ChatCmds == true then
		if string.find(Msg, ";") then
			local Exe = string.gsub(Msg, ";", "")
			Admin:InvokeServer(Exe)
		end
	end
end)

Player:GetMouse().KeyDown:Connect(function(Key)
	if Key == ";" then
		CMDBar:CaptureFocus()
	end
end)

Source:GetPropertyChangedSignal("Text"):Connect(function()
	if Toggle == true then
		local Int = string.len(Source.Text)
		Hidden.Text = Hidden.Text .. string.rep("#", Int)
		print(Int)
	end
	local TextService = game:GetService("TextService")
	local TextSize = TextService:GetTextSize(Source.Text, Source.TextSize, Source.Font, Vector2.new(469, 242))
	Script.CanvasSize = UDim2.new(0, TextSize.X, 0, TextSize.Y)
end)

Helper:AsyncFunction(function()
	for i = 1, #TabsT do
		local Tab = TabsT[i]
		local Tab2 = Tab:FindFirstChildOfClass("ImageButton")
		local OSize = UDim2.new(0, 150, 0, 17)
		local Frame = Tab:WaitForChild("Frame")
		Tab.MouseEnter:Connect(function()
			Tween(Tab, 0.1, "Quad", "Out", {Size = UDim2.new(0, 152, 0, 19)})
		end)
		Tab.MouseLeave:Connect(function()
			Tween(Tab, 0.1, "Quad", "Out", {Size = OSize})
		end)
		Tab2.MouseButton1Click:Connect(function()
			for i,v in pairs(FrameT) do
				if v:GetAttribute("Tab") ~= Tab.Name then
					local ATab = Tabs[v:GetAttribute("Tab")]
					Helper:AsyncFunction(function()
						Tween(ATab, 0.25, "Linear", "Out", {ImageColor3 = Color3.fromRGB(58, 58, 58)})
						ATab:WaitForChild("UIGradient").Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 1),
							NumberSequenceKeypoint.new(1, 1)
						}
						wait(0.25)
						ATab:WaitForChild("UIGradient").Enabled = false
					end)
					Helper:AsyncFunction(function()
						if v.Position == UDim2.new(0, 158, 0, 26) then
							Tween(v, 0.35, "Quad", "Out", {Position = UDim2.new(1, 0, 0, 26)})
						end
						wait(0.35)
						v.Position = UDim2.new(-0.75, 0, 0, 26)
					end)
				elseif v:GetAttribute("Tab") == Tab.Name then
					Helper:AsyncFunction(function()
						Tween(Tab, 0.25, "Linear", "Out", {ImageColor3 = Color3.new(1, 1, 1)})
						Tab:WaitForChild("UIGradient").Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 0)
						}
						wait(0.24)
						Tab:WaitForChild("UIGradient").Enabled = true
					end)
					Tween(v, 0.35, "Quad", "Out", {Position = UDim2.new(0, 158, 0, 26)})
				end
			end
		end)
		local OFFSET_SPEED_X = 1.5
		local function onRenderStep(deltaTime)
			local GR = Tab:WaitForChild("UIGradient")
			local currentOffsetX = GR.Offset.X
			if currentOffsetX > 1 then
				GR.Offset = Vector2.new(-1, 0)
			else
				GR.Offset = Vector2.new(currentOffsetX + OFFSET_SPEED_X * deltaTime, 0)
			end
		end
		game:GetService("RunService").RenderStepped:Connect(onRenderStep)
	end
end)