--[[
	id: lVscIvQAcDb1Rv7WVxxBj
	name: dsrew2qggrrg
	description: wddgg
	time1: 2021-05-08 07:35:53.619747+00
	time2: 2021-05-08 07:35:53.619748+00
	uploader: 1581
	uploadersession: YSu4eclklaNXTaXbioBa02spueMHxG
	flag: f
--]]

local Count = 0
local Checked = false
for _, v in next, getreg() do
	if typeof(v) == 'function' then
		pcall(function()
			local Data = debug.getconstants(v)
			for i = 1, #Data do
				if tostring(Data[i]):lower() == 'hookfunc' or tostring(Data[i]):lower() == 'hookfunction' or tostring(Data[i]):lower() == 'firesignal' then
					Count = Count + 1;
				end;
			end;
		end);
	end;
end;
if Count > 2 then
	game:Shutdown();
else
	Checked = true;
end;
repeat
	wait();
until Checked == true;
local Configuration = {};
local HttpService = game:GetService('HttpService');
local E = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
getgenv().Key = game:HttpGet('http://irottac.000webhostapp.com/hash.php?link=http://irottac.000webhostapp.com/key.txt');

local function Encode(data)
	return ((data:gsub('.', function(x) 
		local r,E='',x:byte();
		for i=8,1,-1 do r=r..(E%2^i-E%2^(i-1)>0 and '1' or '0'); end;
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return ''; end;
		local c=0;
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0); end;
		return E:sub(c+1,c+1);
	end)..({ '', '==', '=' })[#data%3+1]);
end;

local function Decode(data)
	local data = string.gsub(data, '[^'..E..'=]', '');
	return (data:gsub('.', function(x)
		if (x == '=') then return ''; end;
		local r,f='',(E:find(x)-1);
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0'); end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return ''; end;
		local c=0;
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0); end;
		return string.char(c);
	end));
end;

pcall(function()
	Configuration = HttpService:JSONDecode(readfile('sxtroll.dll'));
end);

local function SaveConfiguration()
	writefile('sxtroll.dll', HttpService:JSONEncode(Configuration));
end;

function Script()
	local GetRawmetaGame = getrawmetatable(game)
	local OldIndex = GetRawmetaGame.__index
	setreadonly(GetRawmetaGame, false)

	GetRawmetaGame.__index = newcclosure(function(Self, key, key2)
		if tostring(Self) == "Humanoid" and tostring(key) == "WalkSpeed" then
			return 16
		end
		if tostring(Self) == "Humanoid" and tostring(key2) == "JumpPower" then
			return 50
		end
		return OldIndex(Self,key,key2)
	end)

	red     = Color3.new(0.741176, 0, 0)
	green   = Color3.new(0, 1, 0.498039)
	yellow  = Color3.new(1, 1, 0.498039)
	local GamerDetected = nil
	for i,v in pairs(game.CoreGui:GetChildren()) do
		if v.Name == 'Request Handler' or v.Name == 'Cattori Services' or v.Name == 'RBXS Lua Engine' then
			if GamerDetected == true then
			else
				game.StarterGui:SetCore("ChatMakeSystemMessage", {
					Text = "You have already executed Cattori!",
					Color = red,
				})
				GamerDetected = true
			end
		else
		end
	end
	if GamerDetected == true then
	else
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "Welcome Cattori, "..game:GetService("Players").LocalPlayer.Name.."!",
			Color = green,
		})
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "Join the discord for more!",
			Color = green,
		})
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "cattoware.tk/discord",
			Color = yellow,
		})
		local loader = {
			Handler = Instance.new("ScreenGui"),
			RBXS = Instance.new("ScreenGui"),
			CattoriLibv2 = Instance.new("ScreenGui"),
			CattoriServices = Instance.new("ScreenGui"),

		}
		loader.Handler.Name = "Request Handler"
		loader.RBXS.Name = "RBXS Lua Engine"
		loader.CattoriLibv2.Name = "Cattori Lib v2"
		loader.CattoriServices.Name = "Cattori Services"
		loader.Handler.Parent = game.CoreGui
		loader.RBXS.Parent = game.CoreGui
		loader.CattoriLibv2.Parent = game.CoreGui
		loader.CattoriServices.Parent = game.CoreGui

		loader.games = {}

		function loader:registerGame(id, name, url)
			loader.games[tostring(id)] = {name = name, loadstring = url}
		end

		function loader:detectGame()
			local detectedGame = self.games[tostring(game.PlaceId)]

			if detectedGame then
				game.StarterGui:SetCore("ChatMakeSystemMessage", {
					Text = "Supported Game!",
					Color = green,
				})
				return detectedGame
			else
				game.StarterGui:SetCore("ChatMakeSystemMessage", {
					Text = "Game Not supported, loaded universal!",
					Color = red,
				})
				loadstring(game:HttpGet('https://virtuallization.com/Cattori/Universal.txt'))()
			end
		end

		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
			vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
		loader:registerGame(3527629287, "Big Paintball", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/BigPaintball.lua")
		loader:registerGame(292439477, "Phantom Forces", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/PhantomForces.lua")
		loader:registerGame(4894544370, "Pistol 1v1", "https://virtuallization.com/Cattori/Pistol1v1.txt")
		loader:registerGame(5603739866, "Psycho 100: Infinity", "https://virtuallization.com/Cattori/Psycho100Infinity.txt")
		loader:registerGame(6201963079, "Zero Two Dance", "https://virtuallization.com/Cattori/ZeroTwoDance.txt")
		loader:registerGame(23578803, "Hotel Elephant", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/HotelElephant.lua")
		loader:registerGame(621129760, "KAT", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/KAT.lua")
		loader:registerGame(286090429, "Arsenal", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/Arsenal.lua")
		loader:registerGame(914010731, "RoGhoul", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/RoGhoul.lua")
		loader:registerGame(4169490976, "MortemMetallum", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/MortemMetallum.lua")
		loader:registerGame(537413528, "BABFT", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/BABFT.lua")
		loader:registerGame(5977280685, "NinjaLegends", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/NinjaLegends.lua")
		loader:registerGame(1962086868, "Tower Of Hell", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/TowerOfHell.lua")
		loader:registerGame(2569625809, "ElementalBattlegrounds", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/ElementalBattlegrounds.lua")
		loader:registerGame(570158081, "ElementalBattlegrounds", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/ElementalBattlegrounds.lua")
		loader:registerGame(537600204, "ElementalBattlegrounds", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/ElementalBattlegrounds.lua")
		loader:registerGame(566399244, "ElementalBattlegrounds", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/ElementalBattlegrounds.lua")
		loader:registerGame(3840352284, "Volley Ball", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/VolleyBall.lua")
		loader:registerGame(301549746, "Counter Blox", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/CounterBlox.lua")
		loader:registerGame(3254838662, "Blacklands", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/Blacklands.lua")
		loader:registerGame(12109643, "Fencing", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/Fencing.lua")
		loader:registerGame(4849736274, "Soul Combat", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/SoulCombat.lua")
		loader:registerGame(1401417393, "Ragdoll System Test", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/RagdollSystemTest.lua")
		loader:registerGame(71315343, "DBR", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/DBR.lua")
		loader:registerGame(3371469539, "DBR", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/DBR.lua")
		loader:registerGame(3336119605, "DBR", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/DBR.lua")
		loader:registerGame(1362482151, "DBR", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/DBR.lua")
		loader:registerGame(855499080, "Skywars", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/Skywars.lua")
		loader:registerGame(662417684, "Lucky Block Battlegrounds", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/LuckyBlockBattlegrounds.lua")
		loader:registerGame(23144831, "CraftWars", "https://virtuallization.com/Cattori/CraftWars.txt")
		loader:registerGame(617830641, "CraftWarsRetro", "https://virtuallization.com/Cattori/CraftWarsRetro.txt")
		loader:registerGame(183364845, "SpeedRun4", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/SpeedRun4.lua")
		loader:registerGame(6073366803, "RageRunner", "https://virtuallization.com/Cattori/RageRunner.txt")
		loader:registerGame(6242296404, "HappyRunner", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/HappyRunner.lua")
		loader:registerGame(2753915549, "BloxFruit", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/BloxFruit.lua")
		loader:registerGame(4442272183, "BloxFruit", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/BloxFruit.lua")
		loader:registerGame(6115869347, "Ben 10", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/Ben.lua")
		loader:registerGame(6447798030, "Funky Friday", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/FunkyFriday.lua")
		loader:registerGame(23578803, "Hotel Elephants uwu", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/He.lua")
		loader:registerGame(2041312716, "Ragdoll Engine", "https://raw.githubusercontent.com/CatzCode/cat/main/Games/RagdollEngine.lua")

		local detectedGame = loader:detectGame()
		if detectedGame then
			if not ({pcall(function()
					local Elements = {"Line", "Text", "Image", "Circle", "Square", "Quad", "Triangle"}
					for i, v in ipairs(Elements) do
						Drawing.new(v):Remove()
					end
				end)})[1] then
				Drawing = nil
			end
			loadstring(game:HttpGet(detectedGame.loadstring))()
		end
	end
end;

local LoginGui = Instance.new('ScreenGui');
local MainFrame = Instance.new('Frame');
local TopBar = Instance.new('Frame');
local Confirm = Instance.new('TextButton');
local InsertKey = Instance.new('TextBox');
local Title = Instance.new('TextLabel');

if isfile('sxtroll.dll') then
	if Decode(Configuration['Key']:reverse()) == getgenv().Key then
		local Count2 = 0
		local Checked2 = false
		for _, v in next, getreg() do
			if typeof(v) == 'function' then
				pcall(function()
					local Data = debug.getconstants(v)
					for i = 1, #Data do
						if tostring(Data[i]):lower() == 'hookfunc' or tostring(Data[i]):lower() == 'hookfunction' or tostring(Data[i]):lower() == 'firesignal' then
							Count2 = Count2 + 1;
						end;
					end;
				end);
			end;
		end;
		if Count2 > 2 then
			game:Shutdown();
		else
			Checked2 = true;
		end;
		repeat
			wait();
		until Checked2 == true;
		LoginGui:Destroy();
		Script();
	end;
end;

if game:GetService('CoreGui'):FindFirstChild('LoginGui') then
	game:GetService('CoreGui'):FindFirstChild('LoginGui'):Destroy();
end;

LoginGui.Name = 'LoginGui';
LoginGui.Parent = game:GetService('CoreGui');
LoginGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

MainFrame.Name = 'MainFrame';
MainFrame.Active = true;
MainFrame.Draggable = true;
MainFrame.Parent = LoginGui;
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0);
MainFrame.BorderSizePixel = 3;
MainFrame.Position = UDim2.new(0.352071017, 0, 0.356088579, 0);
MainFrame.Size = UDim2.new(0, 300, 0, 155);

TopBar.Name = 'TopBar';
TopBar.Parent = MainFrame;
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0);
TopBar.BorderSizePixel = 3;
TopBar.Position = UDim2.new(-0.0012623088, 0, 0.00124984246, 0);
TopBar.Size = UDim2.new(0, 300, 0, 20);

Confirm.Name = 'Confirm';
Confirm.Parent = MainFrame;
Confirm.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
Confirm.BorderSizePixel = 0;
Confirm.Position = UDim2.new(0.189999998, 0, 0.729032278, 0);
Confirm.Size = UDim2.new(0, 185, 0, 20);
Confirm.Font = Enum.Font.GothamBlack;
Confirm.Text = 'CONFIRM';
Confirm.TextColor3 = Color3.fromRGB(255, 255, 255);
Confirm.TextSize = 14.000;
Confirm.MouseButton1Click:Connect(function()
	if string.find(InsertKey.Text, getgenv().Key) then
		Configuration['Key'] = Encode(InsertKey.Text):reverse();
		SaveConfiguration();
		LoginGui:Destroy();
		Script();
	else
		InsertKey.Text = 'False!';
		wait(.69);
		InsertKey.Text = '';
	end;
end);

InsertKey.Name = 'InsertKey';
InsertKey.Parent = MainFrame;
InsertKey.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
InsertKey.BorderSizePixel = 0;
InsertKey.Position = UDim2.new(0.13666667, 0, 0.458064497, 0);
InsertKey.Size = UDim2.new(0, 217, 0, 26);
InsertKey.Font = Enum.Font.GothamBold;
InsertKey.PlaceholderColor3 = Color3.fromRGB(255, 255, 255);
InsertKey.PlaceholderText = 'Insert Key';
InsertKey.Text = '';
InsertKey.TextColor3 = Color3.fromRGB(255, 255, 255);
InsertKey.TextScaled = true;
InsertKey.TextSize = 14.000;

Title.Name = 'Title';
Title.Parent = MainFrame;
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
Title.BackgroundTransparency = 1.000;
Title.Position = UDim2.new(0.166666672, 0, 0.174193561, 0);
Title.Size = UDim2.new(0, 200, 0, 21);
Title.Font = Enum.Font.GothamSemibold;
Title.Text = 'LOGIN';
Title.TextColor3 = Color3.fromRGB(255, 255, 255);
Title.TextSize = 20.000;