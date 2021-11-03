--[[
	id: IfbBHrfVyeQkIG4_Yp2Ga
	name: PS ServerMain
	description: ok
	time1: 2021-06-11 07:29:17.567032+00
	time2: 2021-06-11 07:29:17.567032+00
	uploader: 306
	uploadersession: VSD-hEgrXGbVPhj6KKVLLSmCHMD1Fw
	flag: f
--]]

--[[
strings-override

...
]]

-- Sources and functions might be taken from others
local Main = script.Parent
local RealBase = Main:WaitForChild("Main")
local Base = RealBase:WaitForChild("Base")
local Players = game:GetService("Players")
local Player = script.Parent.Parent.Parent
local Buttons = {}
local unpack = unpack or table.unpack
local cache = {}
local memory, address = {states = {}, threads = {}}, 0x0000001
local Resources = Main:WaitForChild("Dependencies")
local Client = Resources.Assets
local GUIs = Resources.GUIs
local Admin = Resources:WaitForChild("Admin")
local Admins = {}
local Text = Client:WaitForChild("Text")
local Remote = Instance.new("RemoteFunction", game.JointsService)
local wrappercache = setmetatable({}, {__mode = "k"})
local Functions = require(script.Required).PlayerFunctions
local ServerFunctions = require(script.Required).ServerFunctions
local Salted = {}
local EncodeCache = {}
local DecodeCache = {}

local GetRandom = function(pLen)
	local Len = (type(pLen) == "number" and pLen) or math.random(5,10) --// reru
	local Res = {}
	for Idx = 1, Len do
		Res[Idx] = string.format('%02x', math.random(255))
	end
	return table.concat(Res)
end

local Encrypt = function(str, key, cache)
	local cache = cache or EncodeCache or {}
	if not key or not str then
		return str
	elseif cache[key] and cache[key][str] then
		return cache[key][str]
	else
		local keyCache = cache[key] or {}
		local byte = string.byte
		local abs = math.abs
		local sub = string.sub
		local len = string.len
		local char = string.char
		local endStr = {}

		for i = 1,len(str) do
			local keyPos = (i%len(key))+1
			endStr[i] = string.char(((byte(sub(str, i, i)) + byte(sub(key, keyPos, keyPos)))%126) + 1)
		end

		endStr = table.concat(endStr)
		cache[key] = keyCache
		keyCache[str] = endStr
		return endStr
	end
end

local Decrypt = function(str, key, cache)
	local cache = cache or DecodeCache or {}
	if not key or not str then
		return str
	elseif cache[key] and cache[key][str] then
		return cache[key][str]
	else
		local keyCache = cache[key] or {}
		local byte = string.byte
		local abs = math.abs
		local sub = string.sub
		local len = string.len
		local char = string.char
		local endStr = {}

		for i = 1,len(str) do
			local keyPos = (i%len(key))+1
			endStr[i] = string.char(((byte(sub(str, i, i)) - byte(sub(key, keyPos, keyPos)))%126) - 1)
		end

		endStr = table.concat(endStr)
		cache[key] = keyCache
		keyCache[str] = endStr
		return endStr
	end
end

local Key = Encrypt(game.JobId, GetRandom())
local Val = Instance.new("StringValue", script.Parent.ClientMain)
Val.Value = Key
Remote.Name = "CharacterSoundEvent"

Salted.Functions = {}
Salted.Loadstring = require(script.Parent.ClientMain.Helper.LuaParser)
LoadScript = function(...)
	local ScriptBase = Resources.ScriptBase:Clone()
	ScriptBase.Parent = game:GetService("ServerScriptService")
	local Code = Instance.new("StringValue", ScriptBase)
	Code.Name = "Code"
	Code.Value = tostring(...)
	ScriptBase.Disabled = false
end
LoadLocal = function(...)
	local ScriptBase = Resources.LocalScriptBase:Clone()
	ScriptBase.Parent = Player.Character
	local Code = Instance.new("StringValue", ScriptBase)
	Code.Name = "Code"
	Code.Value = ...
	ScriptBase.Disabled = false
end
_G.loadstring = Salted.Loadstring
Salted.LoadLibrary = require(Client.LoadLibrary)
Salted.GetRawMetatable = function(real)
	local NewProxy = setmetatable({}, {__mode = "v"})
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
			return Salted.GetRawMetatable(real[k])
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
			local results = Salted.GetRawMetatable{real(unpack(args))}
			return unpack(results)
		end
		wrappercache[fake] = real
		return fake
	elseif type(real) == "table" then
		local fake = {}
		for k,v in next,real do
			fake[k] = Salted.GetRawMetatable(v)
		end
		return fake
	else
		return real
	end
end

Salted.Functions.Execute = function(Owner, key, Script)
	if key == Key then
		local API = setmetatable({}, {
			__index = function(_, Func)
				return getfenv(0)[Func] or function(...)
					return Salted.Functions[Func] and Salted.Functions[Func](Owner, ...) or warn(Func .. " is not a valid function!")
				end
			end
		})
		API["LocalPlayer"] = Player
		API["loadstring"] = function(...)
			return Salted.Loadstring(...)()
		end
		API["LoadLibrary"] = function(...)
			return Salted.LoadLibrary(...)
		end
		API["getrawmetatable"] = function(...)
			return Salted.GetRawMetatable(...)
		end

		return LoadScript(Script, API)
	else
		Owner:Kick("skid")
	end
end
Salted.Functions.ExecuteClient = function(Owner, key, Script)
	if key == Key then
		local API = setmetatable({}, {
			__index = function(_, Func)
				return getfenv(0)[Func] or function(...)
					return Salted.Functions[Func] and Salted.Functions[Func](Owner, ...) or warn(Func .. " is not a valid function!")
				end
			end
		})
		API["LocalPlayer"] = Player
		API["loadstring"] = function(...)
			return Salted.Loadstring(...)()
		end
		API["LoadLibrary"] = function(...)
			return Salted.LoadLibrary(...)
		end
		API["getrawmetatable"] = function(...)
			return Salted.GetRawMetatable(...)
		end

		return LoadLocal(Script, API)
	else
		Owner:Kick("skid")
	end
end
Salted.Functions.ClearScripts = function()
	for i,v in pairs(game:GetService("ServerScriptService"):GetChildren()) do
		if v:IsA("Script") and v.Name == "ScriptBase" then
			v:Destroy()
		end
	end
end
Salted.Functions.GetPingResult = function()
	return true
end
Salted.Functions.GetServerType = function()
	if game.PrivateServerId ~= "" then
		if game.PrivateServerOwnerId ~= 0 then
			return "VIP"
		else
			return "Reserved"
		end
	else
		return "Standard"
	end
end

local Healing = false
local Killing = false
local Locked  = false
local Noclip = false
local Jesusfly = false
local Swim = false
local Return
local BarText = ""
local LP
bans = {}
local commands = {}
local cache = {}
local split = " "
local CreatedItems = setmetatable({}, {__mode = "v"})
local Converter = script:WaitForChild("Converter")

Converter.Parent = nil

function getUserIdFromUsername(name)
	if cache[name] then return cache[name] end
	local player = Players:FindFirstChild(name)
	if player then
		cache[name] = player.UserId
		return player.UserId
	end
	local id
	pcall(function()
		id = Players:GetUserIdFromNameAsync(name)
	end)
	cache[name] = id
	return id
end

local findInTable = function(table, value, index)
	if table == nil then
		return false
	end
	if index == true then
		for idx, val in next, table do
			if string.sub(string.lower(tostring(val)), 1, string.len(tostring(value))) == string.lower(value) then
				return idx
			end
		end
	else
		for idx, val in next, table do
			if (string.lower(val) == string.lower(value)) then
				return true
			end
		end
	end
	return false
end

local getInTable = function(table, value)
	for index = 1, #table do
		if table[index]	== value then
			return index
		end
	end
	return false
end

local function CheckAdmin(Plr)
	if findInTable(Admins, Plr.Name) then
		return true
	elseif Plr.Name == LP.Name then
		return true
	end
end

local Insert = function(ID)
	return game:GetService("InsertService"):LoadAsset(ID):GetChildren()[1]
end

function Create(class, data) -- using adonis stuff bc im lazy
	local new = Instance.new(class) 
	if data then 
		if type(data) == "table" then
			local parent = data.Parent
			if Wrapped(parent) then parent = parent:GetObject() end
			data.Parent = nil

			for val,prop in pairs(data) do 
				new[val] = prop 
			end 

			if parent then
				new.Parent = parent
			end
		elseif type(data) == "userdata" then
			if Wrapped(data) then
				new.Parent = data:GetObject()
			else
				new.Parent = data
			end
		end
	end

	if new then
		table.insert(CreatedItems, new)
	end

	return new 
end

Wrapped = function(object)
	if getmetatable(object) == "PS_Proxy" then
		return true 
	else
		return false 
	end
end

UnWrap = function(object)
	if type(object) == "table" then
		local tab = {}
		for i,v in next,object do tab[i] = UnWrap(v) end
		return tab
	elseif Wrapped(object) then
		return object:GetObject()
	else
		return object
	end
end

function getTorso(plr)
	if plr.Character then
		if plr.Character:FindFirstChild('UpperTorso') then
			return plr.Character.UpperTorso
		elseif plr.Character:FindFirstChild('Torso') then
			return plr.Character.Torso
		else
			return nil
		end
	end
end

local function GetPlayers(plr, names, donterror)
	local players   = {};
	local isServer  = type(plr) ~= 'userdata';
	local parent = game:GetService("NetworkServer") or game:GetService("Players");

	local function getplr(p)
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

	if (plr == nil) and (not isServer) then
		for i,v in next, parent:GetChildren() do
			local p = getplr(v)
			table.insert(players,p)
		end
	elseif plr and not names then
		return {plr}
	elseif names then
		for s in names:gmatch('[^,]+') do
			local plrs = 0
			local function plus()
				plrs = plrs+1
			end

			local function randomPlayer()
				if #players>=#parent:GetChildren() then return end
				local rand = parent:GetChildren()[math.random(#parent:GetChildren())]
				local p=getplr(rand)
				for i,v in next, players do
					if(v==p.Name)then
						randomPlayer()
						return;
					end
				end
				table.insert(players,p)
				plus();
			end

			if string.lower(s)=='me' and plr then
				table.insert(players,plr)
				plus()
			elseif string.lower(s)=='all' or string.lower(s)=="everyone" then
				local everyone = true

				if everyone then
					for i,v in next, parent:GetChildren() do
						local p = getplr(v)
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s)=='others' then
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					if p~=plr then
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s)=='random' then
				randomPlayer();
				plus()
			elseif string.lower(s)=='friends' then
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					if p:IsFriendsWith(plr.userId) then
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s)=='nonfriends' then
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					if not p:IsFriendsWith(plr.userId) then
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s)=='nonprem' then
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					if p.MembershipType == Enum.MembershipType.None then
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s)=='prem' then
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					if p.MembershipType == Enum.MembershipType.Premium then
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s)=='bacons' then
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					local b=p.Character:FindFirstChild("Pal Hair")
					if b and b:IsA("Accessory") then
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s)=='noobs' then
				for i,v in next, parent:GetChildren() do
					local p =getplr(v)
					if p.AccountAge < 365 then
						table.insert(players,p)
						plus()
					end
				end
			elseif string.lower(s):sub(1,3)=='id-' then
				for i,v in next, parent:GetChildren() do
					local p = getplr(v)
					if tonumber(string.lower(s):sub(4)) then
						if p and p.userId==tonumber(string.lower(s):sub(4)) then
							table.insert(players,p)
							plus()
						end
					end
				end
			elseif string.lower(s):sub(1,5)=='team-' then
				for i,v in next, game:GetService("Teams"):GetChildren() do
					if v.Name:lower():sub(1,#s:sub(6))==string.lower(s):sub(6) then
						for k,m in next, parent:GetChildren() do
							local p=getplr(m)
							if p.TeamColor==v.TeamColor then
								table.insert(players,p)
								plus()
							end
						end
					end
				end
			elseif string.lower(s):sub(1,6)=='group-' then
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					if tonumber(string.lower(s):sub(7)) then
						if p:IsInGroup(tonumber(string.lower(s):sub(7))) then
							table.insert(players,p)
							plus()
						end
					end
				end
			elseif string.lower(s):sub(1,7)=="radius-" then
				local num = tonumber(string.lower(s):sub(8))
				if(num==nil)then
					error("Invalid number specified")
				end
				for i,v in next, parent:GetChildren() do
					local p=getplr(v)
					if p~=plr and plr:DistanceFromCharacter(p.Character.Head.Position)<=num then
						table.insert(players,p)
						plus()
					end
				end
			else
				for i,v in next, parent:GetChildren() do
					local p = getplr(v)
					if p and p.Name:lower():sub(1,#s)==string.lower(s) then
						table.insert(players,p)
						plus()
					end
				end
			end
			if plrs==0 and not donterror then end
		end
	end
	return players
end

local function C3(R, G, B)
	return Color3.new(R/255, G/255, B/255)
end

local function Refresh(p)
	local P = p
	local C = P.Character.HumanoidRootPart.CFrame
	local F = Instance.new("Folder", game:GetService("Lighting"))
	F.Name = p.Name .. " Tools"
	pcall(function()
		P.Character.Humanoid:UnequipTools()
	end)
	for index, value in pairs(P.Backpack:GetChildren()) do
		if (value:IsA("HopperBin") or value:IsA("Tool")) then
			value.Parent = F
		end
	end
	P:LoadCharacter()
	P.Character.HumanoidRootPart.CFrame = C
	for index, value in pairs(P.Character:GetChildren()) do
		if (value:IsA("ForceField")) then
			value:Destroy()
		end
	end
	P:WaitForChild("Backpack")
	P.Backpack:ClearAllChildren()
	for index, value in pairs(F:GetChildren()) do
		value:Clone().Parent = P.Backpack
	end
	F:Destroy()
end

local Root = {}
local CharIds={
	['doge']=257489726;
	['huge']=72648316;
	['cat']=319498905;
	['nerfzombie']=305897868;
	['dragon']=158186284;
	['pony']=255278956;
	['dog']=313515030;
	['gremlin']=180497645;
	['spider']=299861127;
	['tdm']=301507511;
	['deaddog']=306542926;
	['croc']=255119149;
	['robotspider']=285590061;
	['hedgehog']=228289069;
	['monster']=319386664;
	['chopper']=178339458;
	['zombie']=93601062;
	['meerkat']=267059049;
	['zombiedog']=121599935;
	['undeadknight']=180205370;
	['dragon2']=253023349;
	['skeleton']=53604463;
	['griffin']=215399493;
	['zombie2']=64630774;
	['babyfox']=220799053;
	['penguin']=170822767;
	['petdino']=190914205;
	['doggie']=82264079;
	['grimlock']=184869613;
	['monkay']=71536048;
	['chimera']=87350670;
	['troll']=88117081;
	['genie']=71006520;
	['dummy']=124120704;
	['ghost']=179296736;
	['bat']=180247488;
	['bug']=76117301;
}

function Root.CharModel(Player,Type)
	local m=Player.Character.Animate:clone()
	m.Disabled=true
	local c=Player.Character.Torso.CFrame
	Player.Character:ClearAllChildren()
	local d
	if Type~='epicfaic' then
		d=game:service'InsertService':LoadAsset(CharIds[Type:lower()]):children()[1]:children()
	else
		d=require(329132087):children()
	end
	for i,v in pairs(d) do
		v.Parent=Player.Character
	end
	Player.Character.Torso.CFrame=c
	if not Player.Character:FindFirstChild'Animate' then
		m.Parent=Player.Character
		wait()
		m.Disabled=false
	end
end

function Jiggle(Plr, Gender)
	local Jig = require(script.Jiggle)
	if Gender == "Female" then
		Jig:ExecFemale(Plr.Character)
	elseif Gender == "Male" then
		Jig:ExecMale(Plr.Character)
	end
end

local function Creeper(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Accessory') then
			v:destroy()
		end
	end
	PLAYER.Character.Torso.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(math.rad(90),math.rad(180),0)
	PLAYER.Character.Torso['Right Shoulder'].C0 = CFrame.new(0,-1.5,-.5) * CFrame.Angles(0,math.rad(90),0)
	PLAYER.Character.Torso['Left Shoulder'].C0 = CFrame.new(0,-1.5,-.5) * CFrame.Angles(0,math.rad(-90),0)
	PLAYER.Character.Torso['Right Hip'].C0 = CFrame.new(0,-1,.5) * CFrame.Angles(0,math.rad(90),0)
	PLAYER.Character.Torso['Left Hip'].C0 = CFrame.new(0,-1,.5) * CFrame.Angles(0,math.rad(-90),0)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new('Bright green')
		end
	end
end

function Scale(Plr, Int)
	if tonumber(Int)>50 then 
		Int = 50 
	end

	local num = tonumber(Int)

	local function sizePlayer(p)
		local char = p.Character
		local torso = char:FindFirstChild("Torso")
		local root = char:FindFirstChild("HumanoidRootPart")
		local welds = {}

		torso.Anchored = true
		torso.BottomSurface = 0
		torso.TopSurface = 0

		for i,v in pairs(char:GetChildren()) do
			if v:IsA("BasePart") then
				v.Anchored = true
			end
		end

		local function size(part)
			for i,v in pairs(part:GetChildren()) do
				if (v:IsA("Weld") or v:IsA("Motor") or v:IsA("Motor6D")) and v.Part1 and v.Part1:IsA("Part") then
					local p1 = v.Part1
					local c0 = {v.C0:components()}
					local c1 = {v.C1:components()}

					for i = 1,3 do
						c0[i] = c0[i]*num
						c1[i] = c1[i]*num
					end

					p1.Anchored = true
					v.Part1 = nil

					v.C0 = CFrame.new(unpack(c0)) 
					v.C1 = CFrame.new(unpack(c1))

					if p1.Name ~= 'Head' and p1.Name ~= 'Torso' then
						p1.formFactor = 3
						p1.Size = p1.Size*num
					elseif p1.Name ~= 'Torso' then
						p1.Anchored = true
						for k,m in pairs(p1:children()) do 
							if m:IsA('Weld') then 
								m.Part0 = nil 
								m.Part1.Anchored = true 
							end 
						end

						p1.formFactor = 3 
						p1.Size = p1.Size*num

						for k,m in pairs(p1:children()) do 
							if m:IsA('Weld') then 
								m.Part0 = p1 
								m.Part1.Anchored = false 
							end 
						end
					end

					if v.Parent == torso then 
						p1.BottomSurface = 0 
						p1.TopSurface = 0 
					end

					p1.Anchored = false
					v.Part1 = p1

					if v.Part0 == torso then 
						table.insert(welds,v) 
						p1.Anchored = true 
						v.Part0 = nil 
					end
				elseif v:IsA('CharacterMesh') then
					local bp = tostring(v.BodyPart):match('%w+.%w+.(%w+)')
					local msh = Instance.new('SpecialMesh')
				elseif v:IsA('SpecialMesh') and v.Parent ~= char.Head then 
					v.Scale = v.Scale*num
				end 
				size(v)
			end
		end

		size(char)

		torso.formFactor = 3
		torso.Size = torso.Size*num

		for i,v in pairs(welds) do 
			v.Part0 = torso 
			v.Part1.Anchored = false 
		end

		for i,v in pairs(char:GetChildren()) do 
			if v:IsA('BasePart') then 
				v.Anchored = false 
			end 
		end

		local weld = Instance.new('Weld',root) 
		weld.Part0 = root 
		weld.Part1 = torso

		local cape = char:findFirstChild("ADONIS_CAPE")
		if cape then
			cape.Size = cape.Size*num
		end
	end

	sizePlayer(Plr)
end

function Color(PLAYER, BCOLOR)
	for i,v in pairs(PLAYER.Character:GetChildren()) do if v:IsA('Shirt') or v:IsA('Pants') then v:destroy() elseif v:IsA('ShirtGraphic') then v.Archivable = false v.Graphic = '' end end
	for i,v in pairs(PLAYER.Character.Head:GetChildren()) do if v:IsA('Decal') then v:destroy() end end
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new(BCOLOR)
		elseif v:IsA('Accessory') then
			v.Handle.BrickColor = BrickColor.new(BCOLOR)
			for a,b in pairs(v.Handle:GetChildren()) do
				if b:IsA('SpecialMesh') then
					b.TextureId = ''
				end
			end
		end
	end
end

local function Shrek(PLAYER)
	Color(PLAYER, 'Bright green')
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') or v:IsA('CharacterMesh') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	for i,v in pairs(PLAYER.Character.Head:GetChildren()) do
		if v:IsA('Decal') or v:IsA('SpecialMesh') then
			v:destroy()
		end
	end
	if PLAYER.Character:FindFirstChild('Shirt Graphic') then
		PLAYER.Character['Shirt Graphic'].Archivable = false
		PLAYER.Character['Shirt Graphic'].Graphic = ''
	end
	local M = Instance.new('SpecialMesh', PLAYER.Character.Head)
	local S = Instance.new('Shirt', PLAYER.Character)
	local P = Instance.new('Pants', PLAYER.Character)
	M.MeshType = 'FileMesh'
	M.MeshId = 'rbxassetid://19999257'
	M.Offset = Vector3.new(-0.1, 0.1, 0)
	M.TextureId = 'rbxassetid://156397869'
	S.ShirtTemplate = 'rbxassetid://133078194'
	P.PantsTemplate = 'rbxassetid://133078204'
end

local function Duck(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'Torso' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 1
		elseif v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	local DUCK = Instance.new('SpecialMesh', PLAYER.Character.Torso)
	DUCK.MeshType = 'FileMesh'
	DUCK.MeshId = 'rbxassetid://9419831'
	DUCK.TextureId = 'rbxassetid://9419827'
	DUCK.Scale = Vector3.new(5, 5, 5)
	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Transparency = 1
	end
end

local function Dog(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	PLAYER.Character.Torso.Transparency = 1
	PLAYER.Character.Torso.Neck.C0 = CFrame.new(0, -0.5, -2) * CFrame.Angles(math.rad(90), math.rad(180), 0)
	PLAYER.Character.Torso['Right Shoulder'].C0 = CFrame.new(0.5, -1.5, -1.5) * CFrame.Angles(0, math.rad(90), 0)
	PLAYER.Character.Torso['Left Shoulder'].C0 = CFrame.new(-0.5, -1.5, -1.5) * CFrame.Angles(0, math.rad(-90), 0)
	PLAYER.Character.Torso['Right Hip'].C0 = CFrame.new(1.5, -1, 1.5) * CFrame.Angles(0, math.rad(90), 0)
	PLAYER.Character.Torso['Left Hip'].C0 = CFrame.new(-1.5, -1, 1.5) * CFrame.Angles(0, math.rad(-90), 0)
	local FakeTorso = Instance.new('Seat', PLAYER.Character)
	local BF = Instance.new('BodyForce', FakeTorso)
	local W = Instance.new('Weld', PLAYER.Character.Torso)
	FakeTorso.Name = 'FakeTorso'
	FakeTorso.TopSurface = 0
	FakeTorso.BottomSurface = 0
	FakeTorso.Size = Vector3.new(3,1,4)
	FakeTorso.BrickColor = BrickColor.new('Brown')
	FakeTorso.CFrame = PLAYER.Character.Torso.CFrame
	BF.Force = Vector3.new(0, FakeTorso:GetMass() * 196.25, 0)
	W.Part0 = PLAYER.Character.Torso
	W.Part1 = FakeTorso
	W.C0 = CFrame.new(0, -0.5, 0)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new('Brown')
		end
	end
end

local AlienH = Client:WaitForChild("Alien")

local function Alien(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		elseif v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new('Fossil')
		end
	end
	AlienH:Clone().Parent = PLAYER.Character
end

function DecalSpam(INSTANCE, ID)
	for i,v in pairs(INSTANCE:GetChildren()) do
		if v:IsA('BasePart') then
			spawn(function()
				local FACES = {'Back', 'Bottom', 'Front', 'Left', 'Right', 'Top'}
				local CURRENT_FACE = 1
				for i = 1, 6 do
					local DECAL = Instance.new('Decal', v)
					DECAL.Name = 'SSADecal'
					DECAL.Texture = 'rbxassetid://' .. ID - 1
					DECAL.Face = FACES[CURRENT_FACE]
					CURRENT_FACE = CURRENT_FACE + 1
				end
			end)
		end
		DecalSpam(v, ID)
	end
end

local function UnDecalSpam(INSTANCE)
	for i,v in pairs(INSTANCE:GetChildren()) do
		if v:IsA('BasePart') then
			for a,b in pairs(v:GetChildren()) do
				if b:IsA('Decal') and b.Name == 'SSADecal' then
					b:destroy()
				end
			end
		end
		UnDecalSpam(v)
	end
end

local function Cape(COLOR)
	if LP.Character:FindFirstChild('Cape') then LP.Character.Cape:destroy() end

	repeat wait() until LP and LP.Character and LP.Character:FindFirstChild('Torso')

	local T = LP.Character.Torso

	local C = Instance.new('Part', T.Parent)
	C.Name = 'cape_seth'
	C.Anchored = false
	C.CanCollide = false
	C.TopSurface = 0
	C.BottomSurface = 0
	C.BrickColor = BrickColor.new(COLOR)
	C.Material = 'Neon'
	C.Size = Vector3.new(0.2, 0.2, 0.2)

	local M = Instance.new('BlockMesh', C)
	M.Scale = Vector3.new(9, 17.5, 0.5)

	local M1 = Instance.new('Motor', C)
	M1.Part0 = C
	M1.Part1 = T
	M1.MaxVelocity = 1
	M1.C0 = CFrame.new(0, 1.75, 0) * CFrame.Angles(0, math.rad(90), 0)
	M1.C1 = CFrame.new(0, 1, .45) * CFrame.Angles(0, math.rad(90), 0)

	local WAVE = false

	repeat wait(1 / 44)
		local ANG = 0.2
		local oldMag = T.Velocity.magnitude
		local MV = 0.1

		if WAVE then
			ANG = ANG + ((T.Velocity.magnitude / 10) * 0.05) + 1
			WAVE = false
		else
			WAVE = false
		end
		ANG = ANG + math.min(T.Velocity.magnitude / 30, 1)
		M1.MaxVelocity = math.min((T.Velocity.magnitude / 10), 0.04) + MV
		M1.DesiredAngle = -ANG
		if M1.CurrentAngle < -0.05 and M1.DesiredAngle > -.05 then
			M1.MaxVelocity = 0.04
		end
		repeat
			wait()
		until M1.CurrentAngle == M1.DesiredAngle or math.abs(T.Velocity.magnitude - oldMag)  >= (T.Velocity.magnitude / 10) + 1
		if T.Velocity.magnitude < 0.1 then
			wait(0.1)
		end
	until not C or C.Parent ~= T.Parent
end

local function Infect(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		Instance.new('Folder', PLAYER.Character).Name = 'infected_seth'
		if v:IsA('Accessory') or v:IsA('Shirt') or v:IsA('Pants') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end

	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Texture = 'rbxassetid://7074882'
	end

	for i,v in pairs (PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			if v.Name == 'Head' or v.Name == 'Left Arm' or v.Name == 'Right Arm' then
				v.BrickColor = BrickColor.new('Medium green')
			elseif v.Name == 'Torso' or v.Name == 'Left Leg' or v.Name == 'Right Leg' then
				v.BrickColor = BrickColor.new('Brown')
			end
		end
	end

	local T = PLAYER.Character.Torso.Touched:connect(function(TC)
		if not TC.Parent:FindFirstChild('infected_seth') then
			local GPFC = Players:GetPlayerFromCharacter(TC.Parent)
			if GPFC then
				Infect(GPFC)
			end
		end
	end)
end

local function Hint(Plr, Msg)
	local G	= GUIs.Hint:Clone()
	G.Parent = Plr.PlayerGui
	G:WaitForChild("Message").Value	= Msg
	G:WaitForChild("Event").Disabled = false
end	

local function addcmd(name, desc, alias, func)
	commands[#commands+1]=
		{
			NAME	= name;
			DESC	= desc;
			ALIAS 	= alias;
			FUNC	= func;
		}
end

addcmd('ForceField' , "ForceField (plr)", {"ff"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Instance.new("ForceField", Val.Character)
			end)
		end)
	end
end)

addcmd('Unforcefield' , "Unforcefield (plr)", {"unff"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character:FindFirstChildOfClass("ForceField"):Destroy()
			end)
		end)
	end
end)

addcmd('Sound' , "Sound (id)", {"music"}, function(args)
	local t = args[2]
	for idx, val in pairs(workspace:GetDescendants()) do
		if val:IsA("Sound") or val.Name == "ViperSound" then
			val:Destroy()
		end
	end
	local S		= Instance.new("Sound", workspace)
	S.Name		= "ViperSound"
	S.Looped	= true
	S.SoundId	= "rbxassetid://" .. t
	S.Volume	= 1
	S:Play()
end)

addcmd('Distort' , "Distort (int)", {"dist"}, function(args)
	local t = args[2]
	for i,v in pairs(workspace:GetChildren())do
		if v:IsA("Sound") and v.Name == "ViperSound" then
			v:ClearAllChildren()
			local d = Instance.new('DistortionSoundEffect')
			d.Parent = v
			d.Level = tonumber(t)
			Hint(LP.PlayerGui, "Set distortion to " .. t)
		end
	end
end)

addcmd('Pitch' , "Pitch (int)", {}, function(args)
	local t = args[2]
	for i,v in pairs(workspace:GetChildren())do
		if v:IsA("Sound") and v.Name == "ViperSound" then
			v.Pitch = tonumber(t)
			Hint(LP.PlayerGui, "Set pitch to " .. t)
		end
	end
end)

addcmd('Volume' , "Volume (int)", {"vol"}, function(args)
	local t = args[2]
	for i,v in pairs(workspace:GetChildren())do
		if v:IsA("Sound") and v.Name == "ViperSound" then
			v.Volume = tonumber(t)
			Hint(LP.PlayerGui, "Set volume to " .. t)
		end
	end
end)

addcmd('Explode' , "Explode (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Instance.new("Explosion", Val.Character).Position = Val.Character.HumanoidRootPart.Position
			end)
		end)
	end
end)

addcmd('Neon' , "Neon (plr)", {"glow"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local char = Val.Character
				for _, child in pairs(char:GetChildren()) do
					if child.ClassName == "CharacterMesh" then
						child:Destroy()
					end
				end
				for _, child in pairs(char:GetChildren()) do
					if child.ClassName == "Shirt" then
						child:Destroy()
					end
				end
				for _, child in pairs(char:GetChildren()) do
					if child.ClassName == "Pants" then
						child:Destroy()
					end
				end
				for _, child in pairs(char:GetDescendants()) do
					if child.ClassName == "Part" then
						child.Material = "Neon"
					end
				end
			end)
		end)
	end
end)

addcmd('Glass' , "Glass (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local char = Val.Character
				for _, child in pairs(char:GetChildren()) do
					if child.ClassName == "CharacterMesh" then
						child:Destroy()
					end
				end
				for _, child in pairs(char:GetChildren()) do
					if child.ClassName == "Shirt" then
						child:Destroy()
					end
				end
				for _, child in pairs(char:GetChildren()) do
					if child.ClassName == "Pants" then
						child:Destroy()
					end
				end
				for _, child in pairs(char:GetDescendants()) do
					if child.ClassName == "Part" then
						child.Material = "Glass"
						child.Transparency = 0.3
					end
				end
			end)
		end)
	end
end)

addcmd('Whiteify' , "Whiteify (plr)", {"white"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local lplr = Val
				local bodyc = lplr.Character["Body Colors"]
				local color = "Institutional white"

				bodyc.HeadColor = BrickColor.new(color)
				bodyc.LeftArmColor = BrickColor.new(color)
				bodyc.LeftLegColor = BrickColor.new(color)
				bodyc.RightArmColor = BrickColor.new(color)
				bodyc.RightLegColor = BrickColor.new(color)
				bodyc.TorsoColor = BrickColor.new(color)
			end)
		end)
	end
end)

addcmd('Blackify' , "Blackify (plr)", {"black"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local lplr = Val
				local bodyc = lplr.Character["Body Colors"]
				local color = "Black"

				bodyc.HeadColor = BrickColor.new(color)
				bodyc.LeftArmColor = BrickColor.new(color)
				bodyc.LeftLegColor = BrickColor.new(color)
				bodyc.RightArmColor = BrickColor.new(color)
				bodyc.RightLegColor = BrickColor.new(color)
				bodyc.TorsoColor = BrickColor.new(color)
			end)
		end)
	end
end)

addcmd('StealTools' , "StealTools (plr)", {"stools"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i,v in pairs(Val.Backpack:GetChildren()) do
					if v:IsA("Tool") then
						v.Parent = LP.Backpack
					end
				end
			end)
		end)
	end
end)				

addcmd('Jail' , "Jail (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if not game.Workspace:FindFirstChild((Val.Name).."'s JAIL") then

					local NewJail = Client.JailFormat:Clone()
					NewJail:SetPrimaryPartCFrame(CFrame.new(Val.Character:WaitForChild("HumanoidRootPart").Position)*CFrame.new(0,1.6,0))
					NewJail.Name = (Val.Name).."'s JAIL"
					NewJail.Parent=  game.Workspace
					Val.Changed:connect(function(WC)
						if WC == "Parent" then
							NewJail:Destroy()
						end
					end)
					local JailDescendants = NewJail:GetChildren()
					local CFrameData = {}
					for _,Prt in pairs(NewJail:GetChildren()) do
						CFrameData[Prt] = Prt.CFrame
					end

					local JailPrimary = NewJail.PrimaryPart

					coroutine.wrap(function()
						while NewJail.Parent == game.Workspace do
							for _,Prt in pairs(JailDescendants) do
								Prt.Parent = NewJail
								pcall(function()
									Prt.CFrame = CFrameData[Prt]
								end)
							end

							coroutine.wrap(function()
								pcall(function()
									if (Val.Character:WaitForChild("HumanoidRootPart").Position - JailPrimary.Position ).magnitude > 4 then
										Val.Character:WaitForChild("HumanoidRootPart").CFrame =JailPrimary.CFrame
									end
								end)
							end)()
							wait(0.15)
						end
					end)()
				end
			end)
		end)
	end
end)

addcmd('Unjail' , "Unjail (plr)", {"nojail"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if game.Workspace:FindFirstChild((Val.Name).."'s JAIL") then
					game.Workspace:FindFirstChild((Val.Name).."'s JAIL"):Destroy()
				end
			end)
		end)
	end
end)

addcmd('Kill' , "Kill (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character:BreakJoints()
			end)
		end)
	end
end)

addcmd('Sink' , "Sink (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.HumanoidRootPart.RootJoint:Destroy()
			end)
		end)
	end
end)

addcmd('Fling' , "Fling (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local xran
				local zran
				repeat
					xran = math.random(-9999, 9999)
				until math.abs(xran) >= 5555
				repeat
					zran = math.random(-9999, 9999)
				until math.abs(zran) >= 5555
				Val.Character.Humanoid.Sit = true
				Val.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
				local BF = Instance.new("BodyForce", Val.Character.HumanoidRootPart)
				BF.Force = Vector3.new(xran*4, 9999*5, zran*4)
			end)
		end)
	end
end)

addcmd('Skydive' , "Skydive (plr)", {"sdive", "freefall"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local pchar = Val.Character
				if pchar:FindFirstChild("HumanoidRootPart") then
					pchar.HumanoidRootPart.CFrame = pchar.HumanoidRootPart.CFrame + Vector3.new(0,10000,0)
				end
			end)
		end)
	end
end)

addcmd('Seizure' , "Seizure (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local pchar = Val.Character
				if pchar:FindFirstChild("Seizure") then

				end
				local Seizure = Instance.new("StringValue", pchar)
				Seizure.Name = "Seizure"
				pchar.Humanoid.PlatformStand = true
				repeat wait()
					pchar.Torso.Velocity = Vector3.new(math.random(-10,10),-5,math.random(-10,10))
					pchar.Torso.RotVelocity = Vector3.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))
				until Seizure.Name == "NotSeizure"
			end)
		end)
	end
end)

addcmd('Unseizure' , "Unseizure (plr)", {"noseizure", "nosez"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local pchar = Val.Character
				if pchar:FindFirstChild("Seizure") then
					pchar.Humanoid.PlatformStand = false
					pchar.Seizure.Name = "NotSeizure"
					wait(0.1)
					pchar.NotSeizure:Destroy()
				end
			end)
		end)
	end
end)

addcmd('Freeze' , "Freeze (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i,v in pairs(Val.Character:GetChildren()) do
					if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
						v.Anchored = truelocal function Refresh(p)
							local P = p
							local C = P.Character.HumanoidRootPart.CFrame
							local F = Instance.new("Folder", game:GetService("Lighting"))
							F.Name = p.Name .. " Tools"
							pcall(function()
								P.Character.Humanoid:UnequipTools()
							end)
							for index, value in pairs(P.Backpack:GetChildren()) do
								if (value:IsA("HopperBin") or value:IsA("Tool")) then
									value.Parent = F
								end
							end
							P:LoadCharacter()
							P.Character.HumanoidRootPart.CFrame = C
							for index, value in pairs(P.Character:GetChildren()) do
								if (value:IsA("ForceField")) then
									value:Destroy()
								end
							end
							P:WaitForChild("Backpack")
							P.Backpack:ClearAllChildren()
							for index, value in pairs(F:GetChildren()) do
								value:Clone().Parent = P.Backpack
							end
							F:Destroy()
						end
					end
				end
			end)
		end)
	end
end)

addcmd('Thaw' , "Thaw (plr)", {"unfreeze", "nofreeze"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i,v in pairs(Val.Character:GetChildren()) do
					if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
						v.Anchored = false
					end
				end
			end)
		end)
	end
end)

addcmd('Respawn' , "Respawn (plr)", {"res"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val:LoadCharacter()
			end)
		end)
	end
end)

addcmd('Refresh' , "Refresh (plr)", {"re"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Fire' , "Fire (plr) (r) (g) (b)", {"burn"}, function(args)
	local t = args[2]
	local r = args[3]
	local g = args[4]
	local b = args[5]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i,v in pairs(Val.Character:GetChildren()) do
					if v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
						local Fire = Instance.new("Fire", v)
						if r and g and b then
							Fire.Color = C3(r, g, b)
							Fire.SecondaryColor = C3(r, g, b)
						end
					end
				end
			end)
		end)
	end
end)

addcmd('Unfire' , "Unfire (plr)", {"nofire"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i, v in next, Val.Character:GetDescendants() do
					if (v:IsA("Fire")) then
						v:Destroy()
					end
				end
			end)
		end)
	end
end)

addcmd('Sparkles', "Sparkles (plr) (r) (g) (b)", {"sp"}, function(args)
	local t = args[2]
	local r = args[3]
	local g = args[4]
	local b = args[5]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i,v in pairs(Val.Character:GetChildren()) do
					if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
						if r and g and b then
							Instance.new('Sparkles', v).Color = C3(r, g, b)
						else
							Instance.new('Sparkles', v)
						end
					end
				end
			end)
		end)
	end
end)		

addcmd('Unsparkles' , "Unsparkles (plr)", {"unsp"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i, v in next, Val.Character:GetDescendants() do
					if (v:IsA("Sparkles")) then
						v:Destroy()
					end
				end
			end)
		end)
	end
end)	

addcmd('Smoke', "Smoke (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Instance.new("Smoke", Val.Character.Torso)
			end)
		end)
	end
end)		

addcmd('Unsmoke' , "Unsmoke (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i, v in next, Val.Character:GetDescendants() do
					if (v:IsA("Smoke")) then
						v:Destroy()
					end
				end
			end)
		end)
	end
end)	

addcmd('God' , "God (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Humanoid.Health = math.huge
				Val.Character.Humanoid.MaxHealth = math.huge
			end)
		end)
	end
end)

addcmd('Semigod' , "Semigod (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Humanoid.Health = 9e9
				Val.Character.Humanoid.MaxHealth = 9e9
			end)
		end)
	end
end)

addcmd('Ungod' , "Ungod (plr)", {"nogod"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Humanoid.Health = 100
				Val.Character.Humanoid.MaxHealth = 100
			end)
		end)
	end
end)

addcmd('Heal' , "Heal (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Humanoid.Health = Val.Character.Humanoid.MaxHealth
			end)
		end)
	end
end)

addcmd('Loopheal' , "Loopheal (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Healing = true
				repeat
					Val.Character.Humanoid.Health = Val.Character.Humanoid.Health + Val.Character.Humanoid.MaxHealth
					game:GetService("RunService").Stepped:wait()
				until not Healing
			end)
		end)
	end
end)

addcmd('Unloopheal' , "Unloopheal (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Healing = false
			end)
		end)
	end
end)

addcmd('Loopkill' , "Loopkill (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Loopkill = true
				repeat
					Val.Character.Humanoid.Health = 0
					Val.Character.Humanoid.MaxHealth = 0
					game:GetService("RunService").Stepped:wait()
				until not Loopkill
			end)
		end)
	end
end)

addcmd('Unloopkill' , "Unloopkill", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Loopkill = false
			end)
		end)
	end
end)

addcmd('Name' , "Name (plr) (str)", {}, function(args)
	local t = args[2]
	local s = string.sub(BarText, 6 + string.len(t))
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if Val.Character and Val.Character:FindFirstChild("Head") then
					if Val.Character:FindFirstChild("Nickname") then
						Val.Character:FindFirstChild("Nickname"):Destroy()
					end
					local NickModel = Instance.new("Model",Val.Character)
					NickModel.Name = "Nickname"
					local Model = Instance.new("Model",NickModel)
					Model.Name = s or ""
					local Head = Instance.new("Part",Model)
					Head.Size = Vector3.new(1,1,1)
					Head.Transparency = 0.99
					Head.Name = "Head"
					local Weld = Instance.new("Weld",Model)
					Weld.Part0 =  Head
					Weld.Part1 = Val.Character:WaitForChild("Head")
					local Humanoid = Instance.new("Humanoid",Model)
					Val.Character.Humanoid.DisplayDistanceType = "None"
					local Script = Client.HideName:Clone()
					Script.Parent = Humanoid
				end
			end)
		end)
	end
end)

addcmd('Char' , "Char (plr) (str/id)", {}, function(args)
	local t = args[2]
	local s = string.sub(BarText, 7 + string.len(t))
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local id = tonumber(s)
				if not id then
					pcall(function()
						id = getUserIdFromUsername(s)
					end)
				end
				if id then
					Val.CharacterAppearanceId = id
					Refresh(Val)
				end
			end)
		end)
	end
end)

addcmd('Unchar' , "Unchar (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)	
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.CharacterAppearanceId = getUserIdFromUsername(Val.Name)
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Hat' , "Hat (plr) (id)", {}, function(args)
	local t = args[2]
	local id = args[3]
	local p = GetPlayers(LP, t)	
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Hat = Insert(id)
				Hat.Parent = Val.Character
			end)
		end)
	end
end)

addcmd('Gear' , "Gear (plr) (id)", {}, function(args)
	local t = args[2]
	local id = args[3]
	local p = GetPlayers(LP, t)	
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Gear = Insert(id)
				Gear.Parent = Val.Backpack
			end)
		end)
	end
end)

addcmd('Admin', "Admin (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)	
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if not CheckAdmin(Val) then
					table.insert(Admins, Val.Name)
				else
					Hint(LP, Val.Name .. " is already an admin!")
				end
			end)
		end)
	end
end)

addcmd('Unadmin', "Unadmin (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)	
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if CheckAdmin(Val) then
					table.remove(Admins, Val)
				end
			end)
		end)
	end
end)

addcmd('Jump' , "Jump (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Humanoid.Jump = true
			end)
		end)
	end
end)

addcmd('Sit' , "Sit (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Humanoid.Sit = true
			end)
		end)
	end
end)

addcmd('Remove' , "Remove (plr)", {"rem", "nil"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character:Destroy()
			end)
		end)
	end
end)

addcmd('Btools' , "Btools (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local B1 = Instance.new("HopperBin", Val.Backpack)
				local B2 = Instance.new("HopperBin", Val.Backpack)
				local B3 = Instance.new("HopperBin", Val.Backpack)
				B1.BinType = Enum.BinType.Clone
				B1.Name = "Copy"
				B1.TextureId = "rbxasset://Textures/Clone.png"
				B2.BinType = Enum.BinType.GameTool
				B2.Name = "Grab"
				B2.TextureId = "rbxasset://Textures/GameTool.png"
				B3.BinType = Enum.BinType.Hammer
				B3.Name = "Delete"
				B1.TextureId = "rbxasset://Textures/Hammer.png"
			end)
		end)
	end
end)

addcmd('F3X' , "F3X (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Client["Building Tools"]:Clone().Parent = Val.Backpack
			end)
		end)
	end
end)

addcmd('Naked' , "Naked (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for idx, val in pairs(Val.Character:GetChildren()) do
					if (val:IsA("Shirt") or val:IsA("Pants") or val:IsA("ShirtGraphic")) then
						val:Destroy()
					end
				end
			end)
		end)
	end
end)

addcmd('Invisible' , "Invisible (plr)", {"invis"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for idx, val in pairs(Val.Character:GetDescendants()) do
					if (val:IsA("Part") or val:IsA("Decal")) then
						val.Transparency = 1
					elseif (val:IsA("Accessory") and val:FindFirstChild("Handle")) then
						val.Handle.Transparency = 1
					end
				end
			end)
		end)
	end
end)

addcmd('Visible' , "Visible (plr)", {"vis"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for idx, val in pairs(Val.Character:GetDescendants()) do
					if (val:IsA("Part") or val:IsA("Decal")) then
						val.Transparency = 0
					elseif (val:IsA("Accessory") and val:FindFirstChild("Handle")) then
						val.Handle.Transparency = 0
					end
				end
			end)
			Val.Character.HumanoidRootPart.Transparency = 1
		end)
	end
end)

addcmd('View' , "View (plr)", {"spec"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local ViewScript = Client.View:Clone()
				ViewScript.Plr.Value = Val.Name
				ViewScript.Parent = LP.Character
				ViewScript.Disabled = false
			end)
		end)
	end
end)

addcmd('Control' , "Control (plr)", {},
	function(args)
		local t = args[2]
		local p = GetPlayers(LP, t)
		for Idx, Val in next, p do
			ypcall(function()
				pcall(function()
					if Val.Character then
						Val.Character.Humanoid.PlatformStand = true
						local w = Create("Weld", LP.Character.HumanoidRootPart)
						w.Part0 = LP.Character.HumanoidRootPart
						w.Part1 = Val.Character.HumanoidRootPart
						local w2 = Create("Weld", LP.Character.Head)
						w2.Part0 = LP.Character.Head
						w2.Part1 = Val.Character.Head
						local w3 = Create("Weld", LP.Character:findFirstChild("Right Arm"))
						w3.Part0 = LP.Character:findFirstChild("Right Arm")
						w3.Part1 = Val.Character:findFirstChild("Right Arm")
						local w4 = Create("Weld", LP.Character:findFirstChild("Left Arm"))
						w4.Part0 = LP.Character:findFirstChild("Left Arm")
						w4.Part1 = Val.Character:findFirstChild("Left Arm")
						local w5 = Create("Weld", LP.Character:findFirstChild("Right Leg"))
						w5.Part0 = LP.Character:findFirstChild("Right Leg")
						w5.Part1 = Val.Character:findFirstChild("Right Leg")
						local w6 = Create("Weld", LP.Character:findFirstChild("Left Leg"))
						w6.Part0 = LP.Character:findFirstChild("Left Leg")
						w6.Part1 = Val.Character:findFirstChild("Left Leg")
						LP.Character.Head.face:Destroy()
						for i, Val in pairs(Val.Character:children()) do
							if Val:IsA("BasePart") then
								Val.CanCollide = false
							end
						end
						for i, Val in pairs(LP.Character:children()) do
							if Val:IsA("BasePart") then
								Val.Transparency = 1
							elseif Val:IsA("Accoutrement") then
								Val:Destroy()
							end
						end
						Val.Character.Parent = LP.Character
						--Val.Character.Humanoid.Changed:connect(function() Val.Character.Humanoid.PlatformStand = true end)
					end
				end)
			end)
		end
	end)

addcmd('Camlock' , "Camlock (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.CameraMode = "LockFirstPerson"
			end)
		end)
	end
end)

addcmd('Uncamlock' , "Uncamlock (plr)", {"nocamlock"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.CameraMode = "Classic"
			end)
		end)
	end
end)

addcmd('Freecam' , "Freecam (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Freecam = Client.FreeCam:Clone()
				Freecam.Parent = Val.Character
				Freecam.Disabled = false
			end)
		end)
	end
end)

addcmd('Fixcam' , "Fixcam (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Fixcam = Client.FixCam:Clone()
				Fixcam.Parent = Val.Character
				Fixcam.Disabled = false
				if Val.Character:FindFirstChild("FreeCam") then
					Val.Character:FindFirstChild("FreeCam"):Destroy()
				end
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Antiban' , "AntiBan (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Meta = Salted.GetRawMetatable(Val)

				Meta.__newindex = function(s, k, v)
					if k == "Kick" then
						return nil
					end
				end
			end)
		end)
	end
end)

addcmd('Bring' , "Bring (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame
			end)
		end)
	end
end)

addcmd('Goto' , "Goto (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				LP.Character.HumanoidRootPart.CFrame = Val.Character.HumanoidRootPart.CFrame
			end)
		end)
	end
end)

addcmd('Tp', "Tp (plr1) (plr2)", {}, function(args)
	local t = args[2]
	local s = args[3]
	local p1, p2 = GetPlayers(LP, t), GetPlayers(LP, s)
	for Idx, Val in next, p1 do
		for Index, Value in next, p2 do
			if Val.Character and Value.Character then
				Val.Character.HumanoidRootPart.CFrame = Value.Character.Torso.CFrame
			end
		end
	end
end)

addcmd('Mute' , "Mute (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Mute		= Client.Mute:Clone()
				Mute.Parent		= Val.Backpack
				Mute.Disabled	= false
			end)
		end)
	end
end)

addcmd('Unmute' , "Unmute (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Unmute		= Client.Unmute:Clone()
				Unmute.Parent		= Val.Backpack
				Unmute.Disabled		= false
			end)
		end)
	end
end)

addcmd('Chill' , "Chill (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Head.face.Texture = "rbxassetid://7074749"
				local ChatScript = Client.RequestChat:Clone()
				ChatScript.Disabled = false
				ChatScript.Parent = Val.Character
				ChatScript.Message.Value = "Still chill still chill still chill"
			end)
		end)
	end
end)

addcmd('EpicFace' , "EpicFace (plr)", {"epic"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Head.face.Texture = "rbxassetid://42070872"
			end)
		end)
	end
end)

addcmd('TDM' , "TDM (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Root.CharModel(Val, 'tdm')
			end)
		end)
	end
end)

addcmd('Doge' , "Doge (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Root.CharModel(Val, 'doge')
			end)
		end)
	end
end)

addcmd('Sink' , "Sink (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.HumanoidRootPart.RootJoint:Destroy()
			end)
		end)
	end
end)

addcmd('Blind' , "Blind (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local GUI = GUIs.Blind:Clone()
				GUI.Parent = Val.PlayerGui
				GUI.Enabled = true
			end)
		end)
	end
end)

addcmd('Unblind' , "Unblind (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local GUI = Client.Unblind:Clone()
				GUI.Parent = Val.Character
				GUI.Disabled = false
			end)
		end)
	end
end)

addcmd('Blur' , "Blur (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local GUI = Client.Blur:Clone()
				GUI.Parent = Val.Character
				GUI.Disabled = false
			end)
		end)
	end
end)

addcmd('Unblur' , "Unblur (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local GUI = Client.Unblur:Clone()
				GUI.Parent = Val.Character
				GUI.Disabled = false
			end)
		end)
	end
end)

addcmd('Chat', "Chat (plr) (str)", {"say"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	local m = string.sub(BarText, 7 + string.len(t))
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local ChatScript = Client.RequestChat:Clone()
				ChatScript.Disabled = false
				ChatScript.Parent = Val.Character
				ChatScript.Message.Value = m
			end)
		end)
	end
end)

addcmd('Clone' , "Clone (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p  do
		ypcall(function()
			pcall(function()
				local pchar = Val.Character
				spawn(function()
					pchar.Archivable = true
					local clone = pchar:Clone()
					clone.Parent = workspace
					local cloneV = Instance.new("BoolValue")
					cloneV.Name = "isclone"
					cloneV.Parent = clone
					clone:MoveTo(pchar:GetModelCFrame().p)
					clone:MakeJoints()
					pchar.Archivable = false
				end)
			end)
		end)
	end
end)

addcmd('RemoveClones' , "RemoveClones", {"noclones"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for _, child in pairs( workspace:GetChildren()) do
					if child.Name == Val.Name and child:FindFirstChild('isclone') then
						child:Destroy()
					end
				end
			end)
		end)
	end
end)

addcmd('Time' , "Time (str)", {}, function(args)
	local t = args[2]
	ypcall(function()
		pcall(function()
			Hint(LP.PlayerGui, "Time set to " .. t)
			game:GetService("Lighting").ClockTime = t
		end)
	end)
end)

addcmd('Day' , "Day", {}, function(args)
	ypcall(function()
		pcall(function()
			game:GetService("Lighting").TimeOfDay = 15
		end)
	end)
end)

addcmd('Night' , "Night", {}, function(args)
	ypcall(function()
		pcall(function()
			game:GetService("Lighting").TimeOfDay = 0
		end)
	end)
end)

addcmd('Hipheight' , "Hipheight (plr) (int)", {"hiph"}, function(args)
	local t = args[2]
	local s = args[3]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if typeof(tonumber(t)) == "number" then
					LP.Character.Humanoid.HipHeight = tonumber(s)
				else
					Val.Character.Humanoid.HipHeight = tonumber(s)
				end
			end)
		end)
	end
end)

addcmd('Jumppower' , "Jumppower (plr) (int)", {"jp"}, function(args)
	local t = args[2]
	local s = args[3]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if typeof(tonumber(t)) == "number" then
					LP.Character.Humanoid.JumpPower = tonumber(s)
				else
					Val.Character.Humanoid.JumpPower = tonumber(s)
				end
			end)
		end)
	end
end)

addcmd('Walkspeed' , "Walkspeed (plr) (int)", {"ws", "speed"}, function(args)
	local t = args[2]
	local s = args[3]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if typeof(tonumber(t)) == "number" then
					LP.Character.Humanoid.WalkSpeed = tonumber(s)
				else
					Val.Character.Humanoid.WalkSpeed = tonumber(s)
				end
			end)
		end)
	end
end)

addcmd('Punish' , "Punish (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local pchar = Val.Character
				pchar.Parent = game:GetService("Lighting")
			end)
		end)
	end
end)

addcmd('Unpunish' , "Unpunish (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if game:GetService("Lighting"):FindFirstChild(Val.Name) then
					game:GetService("Lighting"):FindFirstChild(Val.Name).Parent = workspace
				end
			end)
		end)
	end
end)

addcmd('Glitch' , "Glitch (plr) (intensity)", {}, function(args)
	local t = args[2]
	local i = args[3]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local num = tonumber(i) or 15
				local scr = Resources.Assets.Glitcher:Clone()
				scr.Num.Value = num
				scr.Type.Value = "trippy"
				local new = scr:Clone()
				local torso = Val.Character:FindFirstChild("HumanoidRootPart")
				if torso then
					new.Parent = torso
					new.Name = "Glitchify"
					new.Disabled = false
				end
			end)
		end)
	end
end)

addcmd('Insane' , "Insane (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				for i,v in pairs(getTorso(p):GetChildren()) do
					if v:IsA("Motor6D") then
						spawn(function()
							while v do
								v.C0=v.C0*CFrame.Angles(math.random(-180,180),math.random(-180,180),math.random(-180,180))
								wait()
							end
						end)
					end
				end
			end)
		end)
	end
end)

FollowVal = false
addcmd('Annoy' , "Annoy (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if FollowVal == true then
					FollowVal = false; return
				else
					FollowVal = true
				end
				while FollowVal == true do
					Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
					wait()
				end
			end)
		end)
	end
end)

addcmd('Destroy' , "Destroy (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Hum = Val.Character:FindFirstChild("Humanoid")
				if Hum then
					Hum:Destroy()
				end
			end)
		end)
	end
end)

addcmd('Spin' , "Spin (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				spawn(function()
					local pchar = Val.Character
					for i,v in pairs(pchar.Torso:GetChildren()) do
						if v.Name == "Spinning" then
							v:Destroy()
						end
					end
					local Torso = pchar.Torso
					local BG = Instance.new("BodyGyro", Torso)
					BG.Name = "Spinning"
					BG.maxTorque = Vector3.new(0, math.huge, 0)
					BG.P = 11111
					BG.cframe = Torso.CFrame
					repeat wait(1/44)
						BG.CFrame = BG.CFrame * CFrame.Angles(0,math.rad(30),0)
					until not BG or BG.Parent ~= Torso
				end)
			end)
		end)
	end
end)

addcmd('Unspin' , "Unspin (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local pchar = Val.Character
				for i,v in pairs(pchar.Torso:GetChildren()) do
					if v.Name == "Spinning" then
						v:Destroy()
					end
				end
			end)
		end)
	end
end)

addcmd('Float' , "Float (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local C = Client.Float:Clone()
				C.Parent = Val.Character
				C.Disabled = false
			end)
		end)
	end
end)

addcmd('Unfloat' , "Unfloat (plr)", {"nofloat"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local C = Client.Unfloat:Clone()
				C.Parent = Val.Character
				C.Disabled = false
			end)
		end)
	end
end)

addcmd('LSD' , "LSD (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local GUI = GUIs.LSD:Clone()
				GUI.Parent = Val.PlayerGui
				GUI.Enabled = true
				GUI.Frame.LocalScript.Disabled = false
			end)
		end)
	end
end)

addcmd('Unlsd' , "Unlsd (plr)", {"nolsd"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local C = Client.unLSD:Clone()
				C.Parent = Val.Backpack
				C.Disabled = false
			end)
		end)
	end
end)

addcmd('Crash' , "Crash (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local C = Client.Crash:Clone()
				C.Parent = Val.Backpack
				C.Disabled = false
			end)
		end)
	end
end)

addcmd('CMDS' , "CMDS", {"commands"}, function(args)
	Resources.Assets.ShowCmds:FireAllClients()
end)

addcmd('H' , "H (str)", {"Hint"}, function(args)
	local s = string.sub(BarText, 2)
	pcall(function()
		for index, value in pairs(game:GetService("Players"):GetPlayers()) do
			local G	= GUIs.Hint:Clone()
			G.Parent = value.PlayerGui
			G:WaitForChild("Message").Value	= s
			G:WaitForChild("Event").Disabled = false
		end
	end)
end)

addcmd('SM' , "SM (str)", {}, function(args)
	local s = string.sub(BarText, 3)
	pcall(function()
		for index, value in pairs(game:GetService("Players"):GetPlayers()) do
			local G = GUIs.ServerMessage:Clone()
			G.Parent = value.PlayerGui
			G.SystemMessage:WaitForChild("Message").Value = s
			G.SystemMessage:WaitForChild("Event").Disabled = false
		end
	end)
end)

addcmd('M' , "M (str)", {}, function(args)
	local s = string.sub(BarText, 2)
	pcall(function()
		for index, value in pairs(game:GetService("Players"):GetPlayers()) do
			local G = GUIs.Message:Clone()
			G.Parent = value.PlayerGui
			G.Message.Message.Value = s
			G.Message:WaitForChild("Username").Value = LP.Name
			G.Message.Event.Disabled = false
		end
	end)
end)

addcmd('PM' , "PM (plr) (str)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	local s = string.sub(BarText, 5+string.len(t))
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local G = GUIs.PrivateMessage:Clone()
				G.Parent = Val.PlayerGui
				G.PrivateMessage.Message.Value = s
				G.PrivateMessage.Username.Value = LP.Name
				G.PrivateMessage.Event.Disabled = false
			end)
		end)
	end
end)

addcmd('Fly' , "Fly (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local C = Client.Fly:Clone()
				C.Parent = Val.Backpack
				C.Disabled = false
			end)
		end)
	end
end)

addcmd('Unfly', "Unfly (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local C = Client.Unfly:Clone()
				C.Parent = Val.Backpack
				C.Disabled = false
			end)
		end)
	end
end)

addcmd('NoClip' , "NoClip (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				spawn(function()
					if Val.Character:FindFirstChild("DisableNoclip") then
						for i,v in pairs(Val.Character:GetChildren()) do
							if v.Name == "DisableNoclip" then
								v:Destroy()
							end
						end
					end
					wait()
					local DisableNoclip = Instance.new("RemoteFunction", Val.Character)
					DisableNoclip.Name = "Disable"
					local NoclipScript = Client.Noclip:Clone()
					NoclipScript.Disable.Value = DisableNoclip
					NoclipScript.Parent = Val.Character
					NoclipScript.Disabled = false
				end)
			end)
		end)
	end
end)

addcmd('Clip' , "Clip (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Disable:InvokeClient(Val)
			end)
		end)
	end
end)

addcmd('Rocket', "Rocket (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local speed = 10
				local Part = Instance.new("Part")
				Part.Parent = Val.Character
				local SpecialMesh = Instance.new("SpecialMesh") 
				SpecialMesh.Parent = Part
				SpecialMesh.MeshId = "http://www.roblox.com/asset/?id=2251534" 
				SpecialMesh.MeshType = "FileMesh" 
				SpecialMesh.TextureId = "43abb6d081e0fbc8666fc92f6ff378c1" 
				SpecialMesh.Scale = Vector3.new(0.5,0.5,0.5)
				local Weld = Instance.new("Weld")
				Weld.Parent = Part
				Weld.Part0 = Part
				Weld.Part1 = Val.Character.HumanoidRootPart
				Weld.C0 = CFrame.new(0,-1,0)*CFrame.Angles(-1.5,0,0)
				local BodyVelocity = Instance.new("BodyVelocity")
				BodyVelocity.Parent = Part
				BodyVelocity.maxForce = Vector3.new(math.huge,math.huge,math.huge)
				BodyVelocity.velocity = Vector3.new(0,100*speed,0)
				wait(5)
				BodyVelocity:remove()
				Instance.new("Explosion",workspace).Position = Val.Character.HumanoidRootPart.Position
				Val.Character:BreakJoints()
			end)
		end)
	end
end)

addcmd('Sword' , "Sword (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Sword = Client.ClassicSword:Clone()
				Sword.Parent = Val.Backpack
			end)
		end)
	end
end)

addcmd('Unsword' , "Unsword (plr)", {"nosword"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p  do
		ypcall(function()
			pcall(function()
				if Val.Backpack:FindFirstChild("ClassicSword") then
					Val.Backpack:FindFirstChild("ClassicSword"):Destroy()
				end
			end)
		end)
	end
end)

addcmd('Duck' , "Duck (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Duck(Val)
			end)
		end)
	end
end)

addcmd('Unduck', "Unduck (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Alien' , "Alien (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Alien(Val)
			end)
		end)
	end
end)

addcmd('Unalien', "Unalien (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Infect' , "Infect (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Infect(Val)
			end)
		end)
	end
end)

addcmd('Uninfect', "Uninfect (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Dog' , "Dog (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Dog(Val)
			end)
		end)
	end
end)

addcmd('Undog', "Undog (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Shrek', "Shrek (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Shrek(Val)
			end)
		end)
	end
end)

addcmd('Unshrek', "Unshrek (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Refresh(Val)
			end)
		end)
	end
end)

addcmd('Creeper', "Creeper (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Creeper(Val)
			end)
		end)
	end
end)

addcmd('Uncreeper', "Uncreeper (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Refresh(Val)
			end)
		end)
	end
end)

addcmd("Size", "Size (plr) (int)", {}, function(args)
	local t = args[2]
	local n = string.sub(BarText, 6 + string.len(t))
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		if tonumber(n) > 50 then
			n = 50
		end

		local num = tonumber(n)

		local function sizePlayer(p)
			local char = p.Character
			local torso = char:FindFirstChild("Torso")
			local root = char:FindFirstChild("HumanoidRootPart")
			local welds = {}

			torso.Anchored = true
			torso.BottomSurface = 0
			torso.TopSurface = 0

			for i,v in pairs(char:GetChildren()) do
				if v:IsA("BasePart") then
					v.Anchored = true
				end
			end

			local function size(part)
				for i,v in pairs(part:GetChildren()) do
					if (v:IsA("Weld") or v:IsA("Motor") or v:IsA("Motor6D")) and v.Part1 and v.Part1:IsA("Part") then
						local p1 = v.Part1
						local c0 = {v.C0:components()}
						local c1 = {v.C1:components()}

						for i = 1,3 do
							c0[i] = c0[i]*num
							c1[i] = c1[i]*num
						end

						p1.Anchored = true
						v.Part1 = nil

						v.C0 = CFrame.new(unpack(c0)) 
						v.C1 = CFrame.new(unpack(c1))

						if p1.Name ~= 'Head' and p1.Name ~= 'Torso' then
							p1.formFactor = 3
							p1.Size = p1.Size*num
						elseif p1.Name ~= 'Torso' then
							p1.Anchored = true
							for k,m in pairs(p1:children()) do 
								if m:IsA('Weld') then 
									m.Part0 = nil 
									m.Part1.Anchored = true 
								end 
							end

							p1.formFactor = 3 
							p1.Size = p1.Size*num

							for k,m in pairs(p1:children()) do 
								if m:IsA('Weld') then 
									m.Part0 = p1 
									m.Part1.Anchored = false 
								end 
							end
						end

						if v.Parent == torso then 
							p1.BottomSurface = 0 
							p1.TopSurface = 0 
						end

						p1.Anchored = false
						v.Part1 = p1

						if v.Part0 == torso then 
							table.insert(welds,v) 
							p1.Anchored = true 
							v.Part0 = nil 
						end
					elseif v:IsA('CharacterMesh') then
						local bp = tostring(v.BodyPart):match('%w+.%w+.(%w+)')
						local msh = Create('SpecialMesh')
					elseif v:IsA('SpecialMesh') and v.Parent ~= char.Head then 
						v.Scale = v.Scale*num
					end 
					size(v)
				end
			end

			size(char)

			torso.formFactor = 3
			torso.Size = torso.Size*num

			for i,v in pairs(welds) do 
				v.Part0 = torso 
				v.Part1.Anchored = false 
			end

			for i,v in pairs(char:GetChildren()) do 
				if v:IsA('BasePart') then 
					v.Anchored = false 
				end 
			end

			local weld = Create('Weld',root) 
			weld.Part0 = root 
			weld.Part1 = torso
		end

		sizePlayer(p)
	end
end)

addcmd("ChatBypass", "ChatBypass (plr)", {nil}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				local Chat = Client:WaitForChild("ChatBypass"):Clone()
				Chat.Parent = Val.PlayerGui
				Chat.Disabled = false
			end)
		end)
	end
end)

addcmd('Kick' , "Kick (plr) (str)", {nil}, function(args)
	local t = args[2]
	local s = string.sub(BarText, 6 + string.len(t))
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if s then
					Val:Kick(s)
				else
					Val:Kick("You have been kicked from the game. You can rejoin.")
				end
			end)
		end)
	end
end)

addcmd('Ban' , "Ban (plr) (str)", {}, function(args)
	local t = args[2]
	local s = string.sub(BarText, 6 + string.len(t))
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if Val.Name ~= "Salted_Spagetti" and Val.Name ~= "cool_dude1990" then
					if s then
						Val:Kick("You have been banned from the server. Reason given: " .. s)
						table.insert(bans, Val.Name)
					else
						Val:Kick("You have been banned for idk why lol")
						table.insert(bans, Val.Name)
					end
				else
					LP:Kick("no")
				end
			end)
		end)
	end
end)

addcmd('Damage' , "Damage (plr) (int)", {}, function(args)
	local t = args[2]
	local i = args[3]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Val.Character.Humanoid.Health = Val.Character.Humanoid.Health - i
			end)
		end)
	end
end)

addcmd('Shutdown' , "Shutdown (str)", {}, function(args)
	local s = string.sub(BarText, 9)
	for _,v in pairs(game:GetService("Players"):GetPlayers()) do
		if s:match("%w") or s == nil or not s then 
			v:Kick("The server has been shutdown. Reason given: " .. s)
		else
			v:Kick("The server has been shutdown")
		end	
	end
end)

addcmd('Flood' , "Flood", {}, function(args)
	workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-100,-100,-100), Vector3int16.new(100,100,100)), 17, "Solid", "X")
end)

addcmd('DestroyServer' , "DestroyServer", {}, function(args)
	for i,v in next, workspace:GetDescendants() do
		if v:IsA("Decal") or v:IsA("Shirt") or v:IsA("Pants") then
			v:Destroy()
		elseif v:IsA("BasePart") then
			v.BrickColor = BrickColor.Random()
			v.Material = Enum.Material.DiamondPlate
			Instance.new("Fire", v)
			if not v.Parent:FindFirstChildOfClass("Humanoid") and not v.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				v.Anchored = not v.Anchored
				v.Position = Vector3.new(math.random(-100, 100), 0, math.random(-100, 100))
			end
		end
	end
	spawn(function()
		while wait() do
			Instance.new("Explosion", workspace).Position = Vector3.new(math.random(-1000, 1000), 0, math.random(-1000, 1000))
			workspace:FindFirstChildOfClass("Explosion"):Destroy()
			if tick % 2 == 0 then
				for i,v in next, workspace:GetDescendants() do
					if i > 5 then
						if math.random(1, i) == i then
							v:Destroy()
						end
					end
				end
			end
		end
	end)
	workspace.Gravity = -100
end)

addcmd('R6' , "R6 (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		require(Converter):R6(Val.Name)
	end
end)

addcmd('Girlify' , "Girlify (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				require(script.Girlify):Fire('ok', Val.Name)
			end)
		end)
	end
end)

addcmd('Van' , "Van (plr)", {}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				require(script.Van).Van('u fat', Val.Name)
			end)
		end)
	end
end)

addcmd('JiggleMale' , "JiggleMale (plr)", {"jigm"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		Jiggle(Val, "Male")
	end
end)

addcmd('JiggleFemale' , "JiggleFemale (plr)", {"jigf"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				Jiggle(Val, "Female")
			end)
		end)
	end
end)

addcmd('Quicksand' , "Quicksand (plr)", {"qs"}, function(args)
	local t = args[2]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				require(script.Quicksand)(Val)
			end)
		end)
	end
end)

addcmd('Clear' , "Clear", {}, function(args)
	for _,v in pairs(workspace:GetChildren()) do
		if not v:IsA("Terrain") and v ~= workspace.CurrentCamera and not Players:GetPlayerFromCharacter(v) and not v:IsA("RemoteFunction") and not v:IsA("RemoteEvent") then
			v:Destroy()
		elseif v:IsA("Terrain") then
			v:Clear()
			v:ClearAllChildren()
		end
	end
	local P		= Instance.new("Part", workspace)
	P.Anchored	= true
	P.FormFactor= "Symmetric"
	P.Size		= Vector3.new(1000, 1, 1000)
	P.Position	= Vector3.new(0, 0, 0)
	P.BrickColor= BrickColor.new("Bright green")
	P.Material	= "Grass"
	P.Locked	= true
end)

addcmd('Change' , "Change (plr) (stat) [str/int]", {}, function(args)
	local t = args[2]
	local s = args[3]
	local i	= args[4]
	local p = GetPlayers(LP, t)
	for Idx, Val in next, p do
		ypcall(function()
			pcall(function()
				if Val:FindFirstChild("leaderstats") then
					for Index, Value in pairs(Val.leaderstats:GetChildren()) do
						if string.lower(Value.Name) == string.lower(s) and Value:IsA("IntValue") or Value:IsA("NumberValue") then
							if i then
								Value.Value = tonumber(i)
							end
						elseif string.lower(Value.Name) == string.lower(s) and Value:IsA("StringValue") then
							Value.Value = tostring(i)
						end
					end
				end
			end)
		end)
	end
end)

addcmd('Serverlock' , "Serverlock", {}, function(args)
	Locked = true
end)

addcmd('Unserverlock' , "Unserverlock", {}, function(args)
	Locked = false
end)

local function splitString(str,delim)
	local broken = {}
	if delim == nil then delim = "," end
	for w in string.gmatch(str,"[^"..delim.."]+") do
		table.insert(broken,w)
	end
	return broken
end

Players.PlayerAdded:Connect(function(P)
	if Locked == true then
		P:Kick("The server you are trying to join has been serverlocked.")
	end
end)

local function findCmd(cmd_name)
	for i, v in next, commands do
		if v.NAME:lower() == cmd_name:lower() then
			return v			
		end
		for index, value in next, v.ALIAS do
			if value ~= nil and value ~= "" and value:lower() == cmd_name:lower() then
				return v
			end
		end	
	end
end

local function execcmd(command)
	local args = splitString(command, split)
	if args[1] == nil then return end
	local cmd = findCmd(args[1])
	if cmd then
		cmd.FUNC(args)
	end
end

local function checkHTTP()
	local Check = pcall(function()
		game:GetService("HttpService"):GetAsync("https://www.google.com/")
	end)
	if Check then
		return true
	else
		return false
	end
end

local function ohok(player, args1)
	LP = player
	BarText = args1
	if args1 == "getCMDS" then
		return commands
	else
		execcmd(args1)
	end
end

Admin.OnServerInvoke = ohok

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

function RandomPlayer()
	local Rand = Players:GetChildren()[math.random(#Players:GetChildren())]
	local P = GetPlayer(Rand)
	return P
end

function RunScript(bruh, skid)
	if skid == "me" or skid == "" then
		require(5655464266)(bruh, Player.Name)
	elseif skid == "others" then
		for Idx, Val in pairs(Players:GetPlayers()) do
			local P = GetPlayer(Val)
			if P ~= Player then
				require(5655464266)(bruh, P.Name)
			end
		end
	elseif skid == "all" then
		for Idx, Val in pairs(Players:GetPlayers()) do
			local P = GetPlayer(Val)
			require(5655464266)(bruh, P.Name)
		end
	elseif skid == "random" then
		require(5655464266)(bruh, RandomPlayer().Name)
	else
		for Idx, Val in next, Players:GetChildren() do
			local P = GetPlayer(Val)
			if string.lower(string.sub(P.Name, 1, #skid)) == string.lower(skid) then
				require(5655464266)(bruh, P.Name)
			end
		end
	end
end

-- Remote stuff

gt = getTorso

Salted.Functions.DoPlayer = function(cval, Plr, Func, ...)
	local plrs = GetPlayers(LP, Plr.Name)
	for i,v in next, plrs do
		Functions[Func](plrs[i], ...)
	end
end

Salted.Functions.ExecServer = function(Plr, Func, ...)
	ServerFunctions[Func](...)
end

Salted.Functions.GiveGear = function(cval, Plr, ID)
	require(2985662909):Fire("Gear", Plr, ID)
end

local modulesFolder = game:GetService("ServerScriptService"):WaitForChild("ChatServiceRunner")
local ChatService = require(modulesFolder:WaitForChild("ChatService"))
Salted.Functions.GetNameColor = function()
	return ChatService:GetSpeaker(Player.Name):GetExtraData("NameColor")
end

local function Handler(Plr, Data)
	if Data and Data.Function and Data.Args then
		if Salted.Functions[Data.Function] then
			return Salted.Functions[Data.Function](Plr, unpack(Data.Args)) or "Not Ret"
		end
		error(Data.Function .. " is not a function!")
	end
end

--

Remote.OnServerInvoke = Handler

--[[for i,v in pairs(Main.Base.ScriptHub:GetDescendants()) do
	if v:IsA("ImageButton") then
		table.insert(Buttons, v)
	end
end

for i = 1, #Buttons do
	local Button = Buttons[i]
	Button.MouseButton1Down:Connect(function()
		RunScript(Button.Name, Text.Value)
	end)
end]]

game:GetService("LogService").MessageOut:Connect(function(Text, Type)
	Client:WaitForChild("Logger"):FireAllClients(Text, Type)
end)