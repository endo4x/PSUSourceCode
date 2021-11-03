--[[
	id: CDLpadWgITtF83KlzSDob
	name: Catalog Hell GUI
	description: catalog hell scripts
	time1: 2021-05-22 19:08:23.257697+00
	time2: 2021-05-22 19:08:23.257698+00
	uploader: x2YKWhGC4LHGq4S2VfpLKzlDtrctPVfOolF1yRom
	uploadersession: KD-DiVqt2siTNKRAvHgM-jPfHZ2JhF
	flag: f
--]]

--[[
Made by Cielle
discord.gg/9c53xbzwx8
]]


Hitlist = {}
local File = pcall(function()
	Hitlist = game:GetService('HttpService'):JSONDecode(readfile("Hitlist.json"))
end)
if not File then
    local Hitlist = {
    	12345,
    	12345,
		12345,
	}
	writefile("Hitlist.json", game:GetService('HttpService'):JSONEncode(Hitlist))
end
NightmareUsersStopped = 0
local File = pcall(function()
	NightmareUsersStopped = tonumber(game:GetService('HttpService'):JSONDecode(readfile("NightmareUsersStopped.json")))
end)
if not File then
	writefile("NightmareUsersStopped.json", game:GetService('HttpService'):JSONEncode(tostring(NightmareUsersStopped)))
end

AntiFF = true
HealPad = true
ProtectSpawn = true
AntiRocketOn = false
AntiCrash = true
AntiVoid = true
AntiDim = true
AntiNightmare = true
AntiLoadSteal = true
HitlistEnabled = true
AntiSK = false
YeetNightmare = true
--You can change the variables above but don't touch the ones below
AntiRocketBlacklist = {}
TargetList = {}
QueueKillFF = {}
QueueKillDIM = {}
QueueKillNightmare = {}
SkidList = {}
SpawnProtectnotify = {}
CrashGears = {
	"Ferdinand",
	"DragonCompanion",
	"BabyNessieMount",
	"Wasp",
	"RamMount",
	"ElkMount",
	"SharkMount",
}
DimGears = {
	"GlossyRPG ",
	"RPG",
	"Gamaboi",
	"AviatorWatch",
}
NearbyDistance = 50
Lag = false
on = false
CBring = false
Voided = false
Anchored = false
Cleanup = false
MuteBoombox = false
GrimgoldSpam = false
ChartSpam = false
LoadSpam = false

if not game:IsLoaded() then
    game.Loaded:wait()
end
repeat game:GetService("RunService").RenderStepped:Wait() until game:GetService("Players").LocalPlayer

if game.Players.LocalPlayer.Name == "Butter_2453" then
	Hitlist = {
		19131678, --tannersnake
		701899777, --Zeithorn
		1435037464, --G4KC (Zeithorn's alt)
		2025161053, --NoelFazePlayz
		1847997952, --XUndefeatCheater666X
		1030824613, --TimeyXX
		1938171386, --imlostmyacclol
		--1535877844, --dansker_progirl
		1715057098, --Spelling_Disorder
		421976380, --AliveKelly128 (diegalan's alt)
		2294635353, --sprayoptional
		1994520162, --ICanN0tSpeak
		1795268098, --Acceptmt
		363908611, --HandMeDown1
		2323727965, --AnkIeGeneral
		2326617848, --FallenVinIsHorrible
		216392090, --Iron_hop
		98910172, --jacktaylor32
		1778617036, --Donaldduckplazroblox
		90357699, --jamesonlangston8805
		--1753951107, --auvtp
		932949286, --Hackpro227
		63618866, --GMTRocker
		103589038, --nickexo200
		10542735, --firemomo45
		70161287, --Digital_Crush
		2337030492, --Ibludadbe3
		1748663286, --skotadish
		103749473, --gghosti
		1843402554, --AzFqker
		953311041, --reddstone148
		104800197, --ProbabLie
		772840306, --XoDonYT
		275531220, --Xloaxe
		581654542, --AIexGaming12YT
		2399165884, --shutup99876457546
		1498320390, --xDEADxXxROSE
		21770470, --Qriminal
		2406699690, --l8thaI
		1965013600, --WelcomeRobloxboi
		1065731707, --CorruptBladee
		449204720, --DogWispererDog
		97661203, --marcuskaasik (DogWispererDog's alt)
		1120576186, --xyaniss1000x
		907558498, --GentlemanOfRobloxia
		135828534, --meliodaszi
		2033874348, --r3s1st4nce
		28927931, --OnDefault
		1691298465, --ChickenAlfredoPiece
		2210643123, --fromgameup
		941540486, --bowserjrink20
		457730889, --BankrollFX
		13637205, --xan360 (BankrollFX's alt)
		51042063, --HaYourANoob (BankrollFX's alt)
		130282691, --2ndDeveloper (BankrollFX's alt)
		23515309, --dhvour
		99253353, --VoIphis
		1988359500, --SkullCracker_15
		41892134, --Iolstop
		1410410324, --oofJ_Jfoo
		2453754712, --JohnSmith_153
		2367252154, --HACKGGUVBF7837634
		2442907106, --TypeNull011
		1345765776, --Cxkkiez_MmOon1
		467867175, --xAlbii
		2041485799, --aqlite
		2413158942, --Unknown37098304720
		1188829853, --NoneOfficial
		2457602193, --JohnSmith_154
		242821386, --Jason735976
		869342894, --TVGODSS
		119297507, --Rigumberto
		2462932139, --UnknxwnStile (Hackpro227's alt)
		2491107932, --DaBabyPower_2466 (Hackpro227's alt)
		106865338, --DottyShark31762
		2225126103, --Xruskal
		2338452387, --penguin_overlord0
		288775605, --POPTARTSAREYUMMM (penguin_overlord0's alt)
		363178372, --gamer71400
		76742175, --XavierTheImaginary
		1468205313, --1astoftheTimelords
		2493281300, --x14x14x14x14x14x
		2512740938, --Educated_Skid003
		734679072, --0uail
		2533236246, --0SZES
		1986596710, --Villzite
		30967727, --PigDriver
		2314954166, --MikeTheSpoogGobbler
		2587704753, --BubbaGumpWasTaken
		173196091, --calster26
		232134185, --pikachu030508
		2053362437, --ObamasFirstName8
		25378367, --Asirilin
		1772054131, --stylishfox_x
		1574335070, --Xx_ZeroTwoPowerxX
		1582309885, --iiMrMk
		1604640180, --littleLiam3yrold
		2283555285, --Yuroshina (Probably OaspreyAlt's alt)
	}
end

for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
	v:Disable()
end
if game.PlaceId ~= 26838733 then
	wait(9e9)
end

spawn(function()
	while game:GetService("RunService").RenderStepped:Wait() do
		pcall(function()
			if not game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") and not game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper") then
				game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(169602103)
			end
		end)
	end
end)

function Rocket(RocketTarget)
	spawn(function()
		local RocketJumper = game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") or game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper")
		if RocketTarget.Character:FindFirstChild("Humanoid").Health >= 1 and RocketTarget.Character:FindFirstChild("Head") then
			RocketJumper.FireRocket:FireServer(Vector3.new(0, -9e9, 0), RocketTarget.Character.Head.Position)
			wait(.07)
			clean()
		end
	end)
end

function LoopVoid()
	spawn(function()
		while Voided do
			game:GetService("RunService").RenderStepped:Wait()
			for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") or v.Name == "Humanoid" then
					v:Destroy()
				end
			end
		end
	end)
end

function Time()
	local HOUR = math.floor((tick() % 86400) / 3600)
	local MINUTE = math.floor((tick() % 3600) / 60)
	local SECOND = math.floor(tick() % 60)
	local AP = HOUR > 11 and 'PM' or 'AM'
	HOUR = (HOUR % 12 == 0 and 12 or HOUR % 12)
	HOUR = HOUR < 10 and '0' .. HOUR or HOUR
	MINUTE = MINUTE < 10 and '0' .. MINUTE or MINUTE
	SECOND = SECOND < 10 and '0' .. SECOND or SECOND
	return HOUR .. ':' .. MINUTE .. ':' .. SECOND
end

game.Players.LocalPlayer.CharacterAdded:Connect(function()
	if Voided then
		game:GetService("RunService").RenderStepped:Wait()
		for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") or v.Name == "Humanoid" then
				v:Destroy()
			end
		end
	end
end)

tab = [[

]]
logo = [[
 _____         _          _                   _   _        _  _ 
/  __ \       | |        | |                 | | | |      | || |
| /  \/  __ _ | |_  __ _ | |  ___    __ _    | |_| |  ___ | || |
| |     / _` || __|/ _` || | / _ \  / _` |   |  _  | / _ \| || |
| \__/\| (_| || |_| (_| || || (_) || (_| |   | | | ||  __/| || |
 \____/ \__,_| \__|\__,_||_| \___/  \__, |   \_| |_/ \___||_||_|
                                     __/ |                      
                                    |___/                       
]]
if syn then
	if getgenv().ConsoleOpen ~= true then
		rconsoleclear()
		rconsoleprint('@@LIGHT_MAGENTA@@')
		rconsoleprint("This script was written by Cielle.")
		rconsoleprint(tab)
		rconsoleprint("discord.gg/9c53xbzwx8")
		rconsoleprint(tab..tab)
		rconsoleprint('@@RED@@')
		rconsoleprint(logo)
		rconsoleprint('@@CYAN@@')
		rconsoleprint(tab)
	end
	syn.queue_on_teleport(game:HttpGet('https://0paste.com/254441.txt'))
	spawn(function()
		while wait() do
			if Time() ~= CurrentTime then
				rconsolename(Time() .. " | Catalog Hell Logs | " .. "Nightmare Users Killed: " .. game:GetService('HttpService'):JSONDecode(readfile("NightmareUsersStopped.json")))
				CurrentTime = Time()
			end
		end
	end)
	
	function notify(msg)
		rconsoleprint(tab)
		rconsoleprint(Time() .. " - " .. msg)
		rconsoleprint(tab)
	end
else
	ChatL = Instance.new("ScreenGui")
	Main = Instance.new("Frame")
	Boarder = Instance.new("Frame")
	title = Instance.new("TextLabel")
	hidebtn = Instance.new("TextButton")
	clear = Instance.new("TextButton")
	Holder = Instance.new("ScrollingFrame")
	text = Instance.new("TextLabel")
	open = Instance.new("TextButton")
	Padding = 5;
	nextPosition = UDim2.new(0, 0, 0, Padding);
	
	ChatL.Name = "ChatL"
	ChatL.Parent = game.CoreGui
	ChatL.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	Main.Name = "Main"
	Main.Parent = ChatL
	Main.BackgroundColor3 = Color3.new(0.231373, 0.231373, 0.231373)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0, 0, 0.6, 0)
	Main.Size = UDim2.new(0.2, 0, 0.2, 0)
	
	Boarder.Name = "Boarder"
	Boarder.Parent = Main
	Boarder.BackgroundColor3 = Color3.new(0.329412, 0.329412, 0.329412)
	Boarder.Size = UDim2.new(0, 382.5, 0, 31)
	
	title.Name = "title"
	title.Parent = Boarder
	title.BackgroundColor3 = Color3.new(1, 1, 1)
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0.262411356, 0, 0, 0)
	title.Size = UDim2.new(0, 200, 0, 31)
	title.Font = Enum.Font.SourceSans
	title.Text = "Catalog Hell Logs"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextScaled = true
	title.TextSize = 14
	title.TextWrapped = true
	
	hidebtn.Name = "hidebtn"
	hidebtn.Parent = Boarder
	hidebtn.BackgroundColor3 = Color3.new(1, 1, 1)
	hidebtn.BackgroundTransparency = 1
	hidebtn.Position = UDim2.new(0.827423155, 0, 0, 0)
	hidebtn.Size = UDim2.new(0, 73, 0, 31)
	hidebtn.Font = Enum.Font.SourceSans
	hidebtn.Text = "Hide"
	hidebtn.TextColor3 = Color3.new(0, 0, 0)
	hidebtn.TextScaled = true
	hidebtn.TextSize = 14
	hidebtn.TextWrapped = true
	hidebtn.MouseButton1Click:connect(function()
		Main.Visible = false
		open.Visible = true
	end)
	
	clear.Name = "clear"
	clear.Parent = Boarder
	clear.BackgroundColor3 = Color3.new(0.317647, 0.317647, 0.317647)
	clear.Size = UDim2.new(0, 102, 0, 31)
	clear.Font = Enum.Font.SourceSans
	clear.Text = "Clear"
	clear.TextColor3 = Color3.new(1, 1, 1)
	clear.TextScaled = true
	clear.TextSize = 14
	clear.TextWrapped = true
	clear.MouseButton1Click:connect(function()
		Holder:ClearAllChildren()
		nextPosition = UDim2.new(0, 0, 0, 0);
	end)
	
	Holder.Name = "Holder"
	Holder.Parent = Main
	Holder.BackgroundColor3 = Color3.new(1, 1, 1)
	Holder.BackgroundTransparency = 1
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0, 0, 0.14, 0)
	Holder.Size = UDim2.new(1, 0, 0.875, 0)
	Holder.CanvasSize = UDim2.new(0, 0, 10, 0)
	
	text.Name = "text"
	text.Parent = Holder
	text.BackgroundColor3 = Color3.new(1, 1, 1)
	text.BackgroundTransparency = 1
	text.Position = UDim2.new(-0.059101671, 0, -7.47442245e-05, 0)
	text.Size = UDim2.new(0, 300, 0, 30)
	text.Font = Enum.Font.SourceSans
	text.TextColor3 = Color3.new(1, 1, 1)
	text.TextScaled = true
	text.TextSize = 18
	text.TextWrapped = true
	
	open.Name = "open"
	open.Parent = ChatL
	open.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	open.Position = UDim2.new(0, 0, 0.7495, 0)
	open.Size = UDim2.new(0.05, 0, 0.05, 0)
	open.Visible = false
	open.Font = Enum.Font.SourceSans
	open.Text = "Open Logs"
	open.TextColor3 = Color3.new(0, 0, 0)
	open.TextScaled = true
	open.TextSize = 14
	open.TextWrapped = true
	open.MouseButton1Click:connect(function()
		Main.Visible = true
		open.Visible = false
	end)
	
	function notify(msg)
		colour = Color3.fromRGB(255,255,255)
		if string.sub(msg, 1,1) == ":" or string.sub(msg,1,1) == ";" then
			colour = Color3.fromRGB(255,0,0)
		elseif string.sub(msg,1,2) == "/w" or string.sub(msg,1,7) == "/whisper" or string.sub(msg,1,5) == "/team" or string.sub(msg,1,2) == "/t" then
			colour = Color3.fromRGB(0,0,255)
		else
			colour = Color3.fromRGB(255,255,255)
		end
		ObjectElement = text:Clone();
		ObjectElement.Text = Time() .. " | " .. msg
		ObjectElement.Position = nextPosition;
		ObjectElement.Parent = Holder;
		nextPosition = nextPosition + UDim2.new(0, 0 , 0, ObjectElement.Size.Y.Offset + Padding)
	end
	
	text:Destroy()
end
game:GetService("Players").PlayerAdded:Connect(function(v)
	if LockOnJoin and not table.find(TargetList, v.Name) then
		table.insert(TargetList, v.Name)
		notify(v.Name .. " is now locked into the target list.")
	end
	if syn then
		if table.find(Hitlist, v.UserId) or table.find(TargetList, v.Name) or v.Name == Target then
			rconsoleprint('@@CYAN@@')
		else
			rconsoleprint('@@WHITE@@')
		end
	end
	notify(v.Name .. " joined the server.")
	if syn then
		rconsoleprint('@@CYAN@@')
	end
	wait()
	pcall(function()
		if workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("ForceField") then
			workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("ForceField"):Destroy()
		end
	end)
end)

game:GetService("Players").PlayerRemoving:Connect(function(v)
	if v == game.Players.LocalPlayer then
		ServerLeavePause = true
	end
	if not ServerLeavePause then
		if syn then
			if table.find(Hitlist, v.UserId) or table.find(TargetList, v.Name) or v.Name == Target then
				rconsoleprint('@@CYAN@@')
			else
				rconsoleprint('@@WHITE@@')
			end
		end
		notify(v.Name .. " left the server.")
		if syn then
			rconsoleprint('@@CYAN@@')
		end
	end
end)

Page = 1
page1 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page2 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page3 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page4 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page5 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page6 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page7 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page8 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
page9 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)

page2.Enabled = false
page3.Enabled = false
page4.Enabled = false
page5.Enabled = false
page6.Enabled = false
page7.Enabled = false
page8.Enabled = false
page9.Enabled = false

local base = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local tb = Instance.new("TextBox", base)
tb.Size = UDim2.new(0.15, 0, 0.08, 0)
tb.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
tb.TextScaled = true
tb.TextWrapped = true
tb.Text = "Target Name"
tb.Position = UDim2.new(0.025, 0, 0.925, 0)
tb:GetPropertyChangedSignal("Text"):Connect(function()
	local plr = getPlayer(tb.Text)
	Target = plr.Name
end)
spawn(function()
	while wait() do
		if tb.Text == "" then
			wait(5)
			if tb.Text == "" then
				tb.Text = "Target Name"
			end
		end
	end
end)
if syn then
	local log = Instance.new("TextButton", base)
	log.Size = UDim2.new(0.05, 0, 0.05, 0)
	log.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	log.TextScaled = true
	log.TextWrapped = true
	log.Text = "Clear Logs"
	log.Position = UDim2.new(0, 0, 0.7495, 0)
	log.MouseButton1Click:Connect(function()
		rconsoleclear()
		rconsoleprint('@@LIGHT_MAGENTA@@')
		rconsoleprint("This script was written by Cielle.")
		rconsoleprint(tab)
		rconsoleprint("discord.gg/9c53xbzwx8")
		rconsoleprint('@@CYAN@@')
		rconsoleprint(tab..tab..tab)
	end)
end
local Enter = false
local Tip = Instance.new("TextLabel", base)
Tip.Size = UDim2.new(0.05, 0, 0.05, 0)
Tip.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Tip.TextScaled = true
Tip.TextWrapped = true
Tip.Text = "Click on this textbox to enter the target's name."
Tip.Position = UDim2.new(0, 0, 0, 0)
Tip.Visible = false
tb.MouseEnter:Connect(function()
    Tip.Visible = true
    Enter = true
end)
tb.MouseLeave:Connect(function()
    Tip.Visible = false
    Enter = false
end)
game.Players.LocalPlayer:GetMouse().Move:Connect(function()
    if Enter then
        Tip.Position = UDim2.new(0,game.Players.LocalPlayer:GetMouse().X,0,game.Players.LocalPlayer:GetMouse().Y)
    end
end)

function getPlayer(shortcut)
	local player = nil
	local g = game.Players:GetPlayers()
	for i = 1, #g do
		if string.lower(string.sub(g[i].Name, 1, string.len(shortcut))) == string.lower(shortcut) then
			player = g[i]
			break
		end
	end
	return player
end

local LeftArrow = Instance.new("TextButton", base)
LeftArrow.Size = UDim2.new(0.015, 0, 0.125, 0)
LeftArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
LeftArrow.TextScaled = true
LeftArrow.TextWrapped = true
LeftArrow.Text = "<"
LeftArrow.Position = UDim2.new(0, 0, 0.8, 0)
LeftArrow.MouseButton1Click:Connect(function()
    if Page == 1 then
        LeftArrow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        LeftArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        wait(.05)
        LeftArrow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        LeftArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    elseif Page == 2 then
        Page = 1
        page1.Enabled = true
        page2.Enabled = false
    elseif Page == 3 then
        Page = 2
        page2.Enabled = true
        page3.Enabled = false
    elseif Page == 4 then
        Page = 3
        page3.Enabled = true
        page4.Enabled = false
    elseif Page == 5 then
        Page = 4
        page4.Enabled = true
        page5.Enabled = false
    elseif Page == 6 then
        Page = 5
        page5.Enabled = true
        page6.Enabled = false
    elseif Page == 7 then
        Page = 6
        page6.Enabled = true
        page7.Enabled = false
    elseif Page == 8 then
        Page = 7
        page7.Enabled = true
        page8.Enabled = false
    elseif Page == 9 then
        Page = 8
        page8.Enabled = true
        page9.Enabled = false
	end
end)

local RightArrow = Instance.new("TextButton", base)
RightArrow.Size = UDim2.new(0.015, 0, 0.125, 0)
RightArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
RightArrow.TextScaled = true
RightArrow.TextWrapped = true
RightArrow.Text = ">"
RightArrow.Position = UDim2.new(0.185, 0, 0.8, 0)
RightArrow.MouseButton1Click:Connect(function()
    if Page == 1 then
        Page = 2
        page1.Enabled = false
        page2.Enabled = true
    elseif Page == 2 then
        Page = 3
        page2.Enabled = false
        page3.Enabled = true
    elseif Page == 3 then
        Page = 4
        page3.Enabled = false
        page4.Enabled = true
    elseif Page == 4 then
        Page = 5
        page4.Enabled = false
        page5.Enabled = true
    elseif Page == 5 then
        Page = 6
        page5.Enabled = false
        page6.Enabled = true
    elseif Page == 6 then
        Page = 7
        page6.Enabled = false
        page7.Enabled = true
    elseif Page == 7 then
        Page = 8
        page7.Enabled = false
        page8.Enabled = true
    elseif Page == 8 then
        Page = 9
        page8.Enabled = false
        page9.Enabled = true
    elseif Page == 9 then
        RightArrow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        RightArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        wait(.05)
        RightArrow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        RightArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    end
end)

local TargetLock = Instance.new("TextButton", base)
TargetLock.Size = UDim2.new(0.025, 0, 0.08, 0)
TargetLock.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
TargetLock.TextScaled = true
TargetLock.TextWrapped = true
TargetLock.Text = "Lock Target"
TargetLock.Position = UDim2.new(0.175, 0, 0.925, 0)
TargetLock.MouseButton1Click:Connect(function()
	pcall(function()
		if tb.Text == "" or tb.Text == "Target Name" or tb.Text == "All" then
			game.StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = "[Catalog Hell]: Enter a target's name in the textbox first.",
			})
			TargetLock.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			wait(.05)
			TargetLock.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
			wait(.05)
			TargetLock.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			wait(.05)
			TargetLock.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
		else
			if not table.find(TargetList, Target) then
				table.insert(TargetList, Target)
				notify(Target .. " is now locked into the target list.")
				tb.Text = "Target Name"
			end
		end
	end)
end)

local ClearTargets = Instance.new("TextButton", base)
ClearTargets.Size = UDim2.new(0.025, 0, 0.08, 0)
ClearTargets.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
ClearTargets.TextScaled = true
ClearTargets.TextWrapped = true
ClearTargets.Text = "Clear Targets"
ClearTargets.Position = UDim2.new(0, 0, 0.925, 0)
ClearTargets.MouseButton1Click:Connect(function()
    pcall(function()
		TargetList = {}
		notify("Target list cleared.")
	end)
end)

------------------------------ page 1 ------------------------------

local P1Button1CLR = Instance.new("TextButton", page1)
P1Button1CLR.Size = UDim2.new(0.040, 0, 0.025, 0)
P1Button1CLR.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P1Button1CLR.TextScaled = true
P1Button1CLR.TextWrapped = true
P1Button1CLR.Text = "CLR"
P1Button1CLR.Position = UDim2.new(0.015, 0, 0.8, 0)
P1Button1CLR.MouseButton1Click:Connect(function()
	AntiRocketBlacklist = {}
	notify("AntiRocket blacklist cleared.")
end)

local P1Button1 = Instance.new("TextButton", page1)
P1Button1.Size = UDim2.new(0.090, 0, 0.025, 0)
if AntiRocketOn then
	P1Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P1Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P1Button1.TextScaled = true
P1Button1.TextWrapped = true
P1Button1.Text = "Anti-Rocket"
P1Button1.Position = UDim2.new(0.055, 0, 0.8, 0)
P1Button1.MouseButton1Click:Connect(function()
	AntiRocketOn = not AntiRocketOn
	if AntiRocketOn then
		P1Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		AntiRockets()
	else
		if active then
			P1Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			active = false
		end
	end
end)

local P1Button1BL = Instance.new("TextButton", page1)
P1Button1BL.Size = UDim2.new(0.040, 0, 0.025, 0)
P1Button1BL.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P1Button1BL.TextScaled = true
P1Button1BL.TextWrapped = true
P1Button1BL.Text = "BL"
P1Button1BL.Position = UDim2.new(0.145, 0, 0.8, 0)
P1Button1BL.MouseButton1Click:Connect(function()
	if tb.Text == "All" or tb.Text == "" or tb.Text == "Target Name" then
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: Enter username of player in the textbox first.",
		})
	else
		pcall(function()
			for i, v in pairs(game.Players:GetChildren()) do
				if not table.find(AntiRocketBlacklist, v.Name) and v.Name == Target then
					notify(v.Name .. " is now blacklisted from AntiRocket.")
					table.insert(AntiRocketBlacklist, v.Name)
				end
			end
		end)
	end
end)

local P1Button2 = Instance.new("TextButton", page1)
P1Button2.Size = UDim2.new(0.17, 0, 0.025, 0)
if getgenv().StopInstaVoid then
	P1Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
else
	P1Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	Voided = true
	LoopVoid()
end
P1Button2.TextScaled = true
P1Button2.TextWrapped = true
P1Button2.Text = "Void"
P1Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P1Button2.MouseButton1Click:Connect(function()
	if Voided then
		P1Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		Voided = false
		game:GetService('ReplicatedStorage').Remotes.SetRigType:FireServer(Enum.HumanoidRigType.R6)
	else
		P1Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		Voided = true
		LoopVoid()
	end
end)

local P1Button3 = Instance.new("TextButton", page1)
P1Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
P1Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P1Button3.TextScaled = true
P1Button3.TextWrapped = true
P1Button3.Text = "Anchor"
P1Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P1Button3.MouseButton1Click:Connect(function()
	Anchored = not Anchored
	if Anchored then
		P1Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		spawn(function()
			while Anchored do
				game:GetService("RunService").RenderStepped:Wait()
				pcall(function()
					if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0 then
						game:GetService('ReplicatedStorage').Remotes.SetRigType:FireServer(Enum.HumanoidRigType.R6)
						game.Players.LocalPlayer.CharacterAdded:Wait()
						wait(.5)
					end
				end)
			end
		end)
		Pos = game.Players.LocalPlayer.Character.Head.Position
		RootPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		platform1 = Instance.new("Part")
		platform1.Name = "Platform"
		platform1.Anchored = true
		platform1.Size = Vector3.new(5.5, 1, 5.5)
		platform1.Transparency = 1
		platform1.Position = Pos - Vector3.new(0, 5, 0)
		platform1.Parent = workspace
		repeat
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Sit == true then
					game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Sit = false
				end
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Part") then
						v.Velocity = Vector3.new(0,0,0)
					end
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("TripScript") then
					game.Players.LocalPlayer.Character:FindFirstChild("TripScript"):Remove()
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RootPos
			end)
		until Anchored == false
	else
		P1Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		platform1:Remove()
	end
end)

local P1Button4 = Instance.new("TextButton", page1)
P1Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
P1Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P1Button4.TextScaled = true
P1Button4.TextWrapped = true
P1Button4.Text = "Mute Boombox"
P1Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P1Button4.MouseButton1Click:Connect(function()
	MuteBoombox = not MuteBoombox
	if MuteBoombox then
		P1Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while MuteBoombox do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v.Character:FindFirstChild("SuperFlyGoldBoombox") or v.Character:FindFirstChild("BoomboxGearThree") then
						if v.Character:FindFirstChildOfClass("Tool").Handle:FindFirstChildOfClass("Sound").Playing == true then
							v.Character:FindFirstChildOfClass("Tool").Handle:FindFirstChildOfClass("Sound"):Stop()
						end
					end
				end
			end)
		end
	else
		P1Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P1Button5 = Instance.new("TextButton", page1)
P1Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
P1Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P1Button5.TextScaled = true
P1Button5.TextWrapped = true
P1Button5.Text = "CBring"
P1Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P1Button5.MouseButton1Click:Connect(function()
	CBring = not CBring
	if CBring then
		P1Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		if tb.Text == "All" then
		else
			tb.Text = Target
		end
		if syn then
			while CBring do
				game:GetService("RunService").RenderStepped:Wait()
				pcall(function()
					local Handle = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle
					if Handle and Handle:FindFirstChildOfClass("TouchTransmitter") then
						for i, v in pairs(game.Players:GetChildren()) do
							if tb.Text == "All" then
								if v ~= game.Players.LocalPlayer and v.Name == Target or table.find(TargetList, v.Name) then
									spawn(function()
										if v.Character:FindFirstChildOfClass("ForceField") and v.Character:FindFirstChildOfClass("ForceField").Name ~= "Invincibility" and not v.Character:FindFirstChild("BatControls") and not v.Character:FindFirstChild("ShieldSphere") then
											for i,c in pairs(v.Character:GetChildren()) do
												if c:IsA("BasePart") and c.Name == "Right Arm" then
													c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
												end
											end
										else
											for i,c in pairs(v.Character:GetChildren()) do
												if c:IsA("BasePart") then
													c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
												end
											end
										end
									end)
								end
							else
								if v ~= game.Players.LocalPlayer and v.Name == Target or table.find(TargetList, v.Name) then
									spawn(function()
										if v.Character:FindFirstChildOfClass("ForceField") and v.Character:FindFirstChildOfClass("ForceField").Name ~= "Invincibility" and not v.Character:FindFirstChild("BatControls") and not v.Character:FindFirstChild("ShieldSphere") then
											for i,c in pairs(v.Character:GetChildren()) do
												if c:IsA("BasePart") and c.Name == "Right Arm" then
													c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
												end
											end
										else
											for i,c in pairs(v.Character:GetChildren()) do
												if c:IsA("BasePart") then
													c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
												end
											end
										end
									end)
								end
							end
						end
					end
				end)
			end
		else
			while CBring do
				game:GetService("RunService").RenderStepped:Wait()
				pcall(function()
					local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
					if Tool and Tool.Handle:FindFirstChildOfClass("TouchTransmitter") then
						local CBringPos = Tool.Handle.CFrame
						if tb.Text == "All" then
							for _, v in pairs(game.Players:GetChildren()) do
								if v ~= game.Players.LocalPlayer then
									local TargetCharacter = game.Players:FindFirstChild(v.Name).Character
									if TargetCharacter:FindFirstChildOfClass("Tool") then
										TargetCharacter:FindFirstChildOfClass("Tool"):Destroy()
									end
									for i, Limb in pairs(TargetCharacter:GetDescendants()) do
										if Limb:IsA("BasePart") and Limb ~= "HumanoidRootPart" then
											if TargetCharacter.Humanoid.Health >= 1 then
												Limb:BreakJoints()
												Limb.Anchored = true
												Limb.CanCollide = false
												Limb.CFrame = CBringPos
											elseif Limb and TargetCharacter.Humanoid.Health <= 0 then
												Limb:Destroy()
											end
										end
									end
								end
							end
						else
							for _, v in pairs(game.Players:GetChildren()) do
								if v ~= game.Players.LocalPlayer and v.Name == Target or table.find(TargetList, v.Name) then
									local TargetCharacter = game.Players:FindFirstChild(v.Name).Character
									if TargetCharacter:FindFirstChildOfClass("Tool") then
										TargetCharacter:FindFirstChildOfClass("Tool"):Destroy()
									end
									for i, Limb in pairs(TargetCharacter:GetDescendants()) do
										if Limb:IsA("BasePart") and Limb ~= "HumanoidRootPart" then
											if TargetCharacter.Humanoid.Health >= 1 then
												Limb:BreakJoints()
												Limb.Anchored = true
												Limb.CanCollide = false
												Limb.CFrame = CBringPos
											elseif Limb and TargetCharacter.Humanoid.Health <= 0 then
												Limb:Destroy()
											end
										end
									end
								end
							end
						end
					end
				end)
			end
		end
	else
		P1Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

------------------------------ page 2 ------------------------------

local P2Button1LeftArrow = Instance.new("TextButton", page2)
P2Button1LeftArrow.Size = UDim2.new(0.040, 0, 0.025, 0)
P2Button1LeftArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P2Button1LeftArrow.TextScaled = true
P2Button1LeftArrow.TextWrapped = true
P2Button1LeftArrow.Text = "<"
P2Button1LeftArrow.Position = UDim2.new(0.015, 0, 0.8, 0)
P2Button1LeftArrow.MouseButton1Click:Connect(function()
	tb.Text = Target
	if workspace:FindFirstChild(Target.."'s Cloud").OutfitGiver:FindFirstChild("Previous") then
		fireclickdetector(workspace:FindFirstChild(Target.."'s Cloud").OutfitGiver:FindFirstChild("Previous").ClickDetector)
	end
end)

local P2Button1 = Instance.new("TextButton", page2)
P2Button1.Size = UDim2.new(0.090, 0, 0.025, 0)
P2Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P2Button1.TextScaled = true
P2Button1.TextWrapped = true
P2Button1.Text = "Steal Load"
P2Button1.Position = UDim2.new(0.055, 0, 0.8, 0)
P2Button1.MouseButton1Click:Connect(function()
	tb.Text = Target
	if workspace:FindFirstChild(Target.."'s Cloud").OutfitGiver:FindFirstChild("Click here to unlock this feature") then
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: Player doesn't own OutfitGiver gamepass.",
		})
	elseif workspace:FindFirstChild(Target.."'s Cloud").OutfitGiver:FindFirstChild("Load") then
		fireclickdetector(workspace:FindFirstChild(Target.."'s Cloud").OutfitGiver.Load.Head.ClickDetector)
	else
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: Load button not found.",
		})
	end
end)

local P2Button1RightArrow = Instance.new("TextButton", page2)
P2Button1RightArrow.Size = UDim2.new(0.040, 0, 0.025, 0)
P2Button1RightArrow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P2Button1RightArrow.TextScaled = true
P2Button1RightArrow.TextWrapped = true
P2Button1RightArrow.Text = ">"
P2Button1RightArrow.Position = UDim2.new(0.145, 0, 0.8, 0)
P2Button1RightArrow.MouseButton1Click:Connect(function()
	tb.Text = Target
	if workspace:FindFirstChild(Target.."'s Cloud").OutfitGiver:FindFirstChild("Next") then
		fireclickdetector(workspace:FindFirstChild(Target.."'s Cloud").OutfitGiver.Next.ClickDetector)
	end
end)

local P2Button2 = Instance.new("TextButton", page2)
P2Button2.Size = UDim2.new(0.17, 0, 0.025, 0)
if AntiCrash then
	P2Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P2Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P2Button2.TextScaled = true
P2Button2.TextWrapped = true
P2Button2.Text = "Anti-Crash"
P2Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P2Button2.MouseButton1Click:Connect(function()
	AntiCrash = not AntiCrash
	if AntiCrash then
		P2Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		StartAntiCrash()
	else
		P2Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		Crasherlist = {}
	end
end)

local P2Button3 = Instance.new("TextButton", page2)
P2Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
if AntiLoadSteal then
	P2Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: AntiLoadSteal: Keep in mind that your first load in slot 1 is at risk, only the other loads are safe.",
    })
else
	P2Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P2Button3.TextScaled = true
P2Button3.TextWrapped = true
P2Button3.Text = "Anti-LoadSteal"
P2Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P2Button3.MouseButton1Click:Connect(function()
	AntiLoadSteal = not AntiLoadSteal
	if AntiLoadSteal then
		P2Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: AntiLoadSteal: Keep in mind that your first load in slot 1 is at risk, only the other loads are safe.",
		})
		while AntiLoadSteal do
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if not workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").OutfitGiver:FindFirstChild("1 of 10") then
					for i, v in pairs(game.Players:GetChildren()) do
						if v ~= game.Players.LocalPlayer and (v.Character:FindFirstChild"HumanoidRootPart".Position - workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").OutfitGiver.Load.Head.Position).magnitude <= 40 then
							fireclickdetector(workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").OutfitGiver.Previous.ClickDetector)
						end
					end
				end
			end)
		end
	else
		P2Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)
spawn(function()
	if AntiLoadSteal then
		while AntiLoadSteal do
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if not workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").OutfitGiver:FindFirstChild("1 of 10") then
					for i, v in pairs(game.Players:GetChildren()) do
						if v ~= game.Players.LocalPlayer and (v.Character:FindFirstChild"HumanoidRootPart".Position - workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").OutfitGiver.Load.Head.Position).magnitude <= 40 then
							fireclickdetector(workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").OutfitGiver.Previous.ClickDetector)
						end
					end
				end
			end)
		end
	end
end)


local P2Button4 = Instance.new("TextButton", page2)
P2Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
if AntiVoid then
	P2Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	spawn(function()
		while AntiVoid do
			pcall(function()
				for i, v in pairs(game.Workspace:GetDescendants()) do
					if v.Name == "Part" or v.Name == "Baseplate" or v.Name == "Union" then
						if v.Velocity ~= Vector3.new(0, 0, 0) then
							v.Velocity = Vector3.new(0, 0, 0)
						end
					end
				end
			end)
			wait(1)
		end
	end)
else
	P2Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P2Button4.TextScaled = true
P2Button4.TextWrapped = true
P2Button4.Text = "Anti-Void"
P2Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P2Button4.MouseButton1Click:Connect(function()
	AntiVoid = not AntiVoid
	if AntiVoid then
		P2Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while AntiVoid do
			pcall(function()
				for i, v in pairs(game.Workspace:GetDescendants()) do
					if v.Name == "Part" or v.Name == "Baseplate" or v.Name == "Union" then
						if v.Velocity ~= Vector3.new(0, 0, 0) then
							v.Velocity = Vector3.new(0, 0, 0)
						end
					end
				end
			end)
			wait(1)
		end
	else
		P2Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P2Button5 = Instance.new("TextButton", page2)
P2Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
if Cleanup then
	P2Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P2Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P2Button5.TextScaled = true
P2Button5.TextWrapped = true
P2Button5.Text = "Cleanup"
P2Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P2Button5.MouseButton1Click:Connect(function()
	Cleanup = not Cleanup
	if Cleanup then
		P2Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while Cleanup do
			for i, v in pairs (workspace:GetChildren()) do
				if v:IsA("Part") then
					if v.Anchored == false then
						v:Destroy()
					end
				end
			end
			clean()
			wait(1)
		end
	else
		P2Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

------------------------------ page 3 ------------------------------

local P3Button1 = Instance.new("TextButton", page3)
P3Button1.Size = UDim2.new(0.17, 0, 0.025, 0)
if ProtectSpawn then
	P3Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P3Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P3Button1.TextScaled = true
P3Button1.TextWrapped = true
P3Button1.Text = "Spawn Protect"
P3Button1.Position = UDim2.new(0.015, 0, 0.8, 0)
P3Button1.MouseButton1Click:Connect(function()
	ProtectSpawn = not ProtectSpawn
	if ProtectSpawn then
		P3Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		P3Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P3Button2 = Instance.new("TextButton", page3)
P3Button2.Size = UDim2.new(0.17, 0, 0.025, 0)
P3Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P3Button2.TextScaled = true
P3Button2.TextWrapped = true
P3Button2.Text = "Lag"
P3Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P3Button2.MouseButton1Click:Connect(function()
	Lag = not Lag
	if Lag then
		if not Voided then
			P3Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
			game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.CatalogScreenGui.Enabled = false
			if not game.Players.LocalPlayer.Backpack:FindFirstChild("SnowGlobe") then
				repeat
					game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(19111894)
					wait()
				until game.Players.LocalPlayer.Backpack:FindFirstChild("SnowGlobe")
			end
			while Lag do
				game:GetService("RunService").RenderStepped:Wait()
				if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health >= 1 then
					for count = 1,10 do
						game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("SnowGlobe"))
						game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
					end
				end
			end
		else
			Lag = false
			game.StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = "[Catalog Hell]: Can't lag while voided.",
			})
		end
	else
		if game.Players.LocalPlayer.Backpack:FindFirstChild("SnowGlobe") then
			repeat
				game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(19111894)
				wait()
			until not game.Players.LocalPlayer.Backpack:FindFirstChild("SnowGlobe")
		end
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.CatalogScreenGui.Enabled = true
		P3Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P3Button3 = Instance.new("TextButton", page3)
P3Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
if AntiNightmare then
	P3Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P3Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P3Button3.TextScaled = true
P3Button3.TextWrapped = true
P3Button3.Text = "Anti-Blackhole"
P3Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P3Button3.MouseButton1Click:Connect(function()
	AntiNightmare = not AntiNightmare
	if AntiNightmare then
		P3Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		spawn(function()
			while AntiNightmare do
				game:GetService("RunService").RenderStepped:Wait()
				spawn(function()
					for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
						if v.Name == "Black Hole Gravitation" then
							v:Destroy()
							for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
								if v:IsA("Part") then
									v.Velocity = Vector3.new(0,0,0)
								end
							end
						end
					end
				end)
				spawn(function()
					if workspace:FindFirstChild("Black Hole") then
						workspace:FindFirstChild("Black Hole"):Destroy()
					end
				end)
			end
		end)
	else
		P3Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

if AntiNightmare then
	P3Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	spawn(function()
		while AntiNightmare do
			game:GetService("RunService").RenderStepped:Wait()
			spawn(function()
				for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
					if v.Name == "Black Hole Gravitation" then
						v:Destroy()
						for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.Velocity = Vector3.new(0,0,0)
							end
						end
					end
				end
			end)
			spawn(function()
				if workspace:FindFirstChild("Black Hole") then
					workspace:FindFirstChild("Black Hole"):Destroy()
				end
			end)
		end
	end)
else
	P3Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end

local P3Button4 = Instance.new("TextButton", page3)
P3Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
if ChartSpam then
	P3Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P3Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P3Button4.TextScaled = true
P3Button4.TextWrapped = true
P3Button4.Text = "Perm-Chart"
P3Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P3Button4.MouseButton1Click:Connect(function()
	ChartSpam = not ChartSpam
	if ChartSpam then
		P3Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		spawn(function()
			Chart = "ChartreusePeriastron"
			while ChartSpam do
				if not game.Players.LocalPlayer.Backpack:FindFirstChild(Chart) and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health >= 1 then
					game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(80661504)
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health >= 1 then
					game.Players.LocalPlayer.Backpack:FindFirstChild(Chart).Parent = game.Players.LocalPlayer.Character
					game:GetService("Players").LocalPlayer.Character.ChartreusePeriastron.Remote:FireServer(Enum.KeyCode.Q)
					game.Players.LocalPlayer.Character:FindFirstChild(Chart).Parent = game.Players.LocalPlayer.Backpack
					game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(80661504)
					repeat
						game:GetService("RunService").RenderStepped:Wait()
					until not game.Players.LocalPlayer.Character:FindFirstChild("ShieldScript")
				else
					game:GetService("RunService").RenderStepped:Wait()
				end
			end
		end)
	else
		P3Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P3Button5 = Instance.new("TextButton", page3)
P3Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
if GrimgoldSpam then
	P3Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P3Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P3Button5.TextScaled = true
P3Button5.TextWrapped = true
P3Button5.Text = "Grimgold Radar Spam"
P3Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P3Button5.MouseButton1Click:Connect(function()
	GrimgoldSpam = not GrimgoldSpam
	if GrimgoldSpam then
		P3Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while GrimgoldSpam do
			wait()
			if Voided then
				GrimgoldSpam = false
				P3Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			end
			Grimgold = "GrimgoldPeriastron"
			if not game.Players.LocalPlayer.Backpack:FindFirstChild(Grimgold) and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health >= 1 then
				repeat
					game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(73829193)
				until game.Players.LocalPlayer.Backpack:FindFirstChild(Grimgold)
			end
			if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health >= 1 then
				game.Players.LocalPlayer.Backpack:FindFirstChild(Grimgold).Parent = game.Players.LocalPlayer.Character
				game:GetService("Players").LocalPlayer.Character.GrimgoldPeriastron.Remote:FireServer(Enum.KeyCode.Q)
				game.Players.LocalPlayer.Character:FindFirstChild(Grimgold).Parent = game.Players.LocalPlayer.Backpack
				game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(73829193)
			end
		end
	else
		P3Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

------------------------------ page 4 ------------------------------

local P4Button1 = Instance.new("TextButton", page4)
P4Button1.Size = UDim2.new(0.17, 0, 0.025, 0)
P4Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P4Button1.TextScaled = true
P4Button1.TextWrapped = true
P4Button1.Text = "Regen"
P4Button1.Position = UDim2.new(0.015, 0, 0.8, 0)
P4Button1.MouseButton1Click:Connect(function()
	if not Voided and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health >= 1 then
		if not game.Players.LocalPlayer.Backpack:FindFirstChild("OverseerwrathSword") then
			repeat
				game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(483308034)
				wait()
			until game.Players.LocalPlayer.Backpack:FindFirstChild("OverseerwrathSword")
		end
		for count = 1, 50 do
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("OverseerwrathSword"))
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
		end
		wait()
		if not game.Players.LocalPlayer.Backpack:FindFirstChild("PowerFist") then
			repeat
				game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(65469882)
				wait()
			until game.Players.LocalPlayer.Backpack:FindFirstChild("PowerFist")
		end
		for count = 1, 50 do
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("PowerFist"))
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
		end
		wait()
		game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(483308034)
	end
end)

local P4Button2 = Instance.new("TextButton", page4)
P4Button2.Size = UDim2.new(0.17, 0, 0.025, 0)
P4Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P4Button2.TextScaled = true
P4Button2.TextWrapped = true
P4Button2.Text = "Reset"
P4Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P4Button2.MouseButton1Click:Connect(function()
	if Voided then
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: Can't reset while voided.",
		})
		P4Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        P4Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        wait(.05)
        P4Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        P4Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	else
		game:GetService('ReplicatedStorage').Remotes.SetRigType:FireServer(Enum.HumanoidRigType.R6)
	end
end)

local P4Button3 = Instance.new("TextButton", page4)
P4Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
P4Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P4Button3.TextScaled = true
P4Button3.TextWrapped = true
P4Button3.Text = "Crash"
P4Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P4Button3.MouseButton1Click:Connect(function()
	for i, v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "Union" then
			v.Velocity = (Vector3.new(0, 0, 0))
		end
	end
	if Voided then
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: Can't crash while voided.",
		})
		P4Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        P4Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        wait(.05)
        P4Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(.05)
        P4Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	else
		spawn(function()
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
			repeat
				game:GetService("RunService").RenderStepped:Wait()
				pcall(function()
					local unionPos = workspace:WaitForChild(game.Players.LocalPlayer.Name .. "'s Cloud", 10):FindFirstChildOfClass('SpawnLocation').Position + Vector3.new(8, 0, 16.5)
					game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(unionPos) + Vector3.new(0, 5.1, 0))
				end)
			until game.Players.LocalPlayer.Character:FindFirstChild("DragonCompanion")
		end)
		if not game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("SillyGuitar") then
			repeat
				game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(57229371)
				wait()
			until game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("SillyGuitar")
		end
		if not game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("DragonCompanion") then
			repeat
				game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(1320966824)
				wait()
			until game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("DragonCompanion")
		end
		if workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.Knob.BrickColor ~= BrickColor.new("Bright green") then
			fireclickdetector(workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.ClickDetector)
		end
		game.Players.LocalPlayer.Backpack:WaitForChild("SillyGuitar").Parent = game.Players.LocalPlayer.Character
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 then
			repeat
				game:GetService("RunService").RenderStepped:Wait()
			until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health >= 1
		end
		wait(.5)
		game.Players.LocalPlayer.Backpack:WaitForChild("DragonCompanion").Parent = game.Players.LocalPlayer.Character
	end
end)

local P4Button4 = Instance.new("TextButton", page4)
P4Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
P4Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P4Button4.TextScaled = true
P4Button4.TextWrapped = true
P4Button4.Text = "Steal Target's Roblox Outfit"
P4Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P4Button4.MouseButton1Click:Connect(function()
	game:GetService("ReplicatedStorage").Remotes.BecomeAvatar:FireServer(game.Players:FindFirstChild(Target).UserId)
end)

local P4Button5 = Instance.new("TextButton", page4)
P4Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
P4Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P4Button5.TextScaled = true
P4Button5.TextWrapped = true
P4Button5.Text = "Teleport to Target's Spawn"
P4Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P4Button5.MouseButton1Click:Connect(function()
	if Voided then
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: Can't teleport while Voided.",
		})
	else
		for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("Part") then
				v.Velocity = Vector3.new(0,0,0)
			end
		end
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild(Target.."'s Cloud").Union.CFrame * CFrame.new(-15, 20, 0)
	end
end)

------------------------------ page 5 ------------------------------

local P5Button1 = Instance.new("TextButton", page5)
P5Button1.Size = UDim2.new(0.17, 0, 0.025, 0)
P5Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P5Button1.TextScaled = true
P5Button1.TextWrapped = true
P5Button1.Text = "Punish"
P5Button1.Position = UDim2.new(0.015, 0, 0.8, 0)
P5Button1.MouseButton1Click:Connect(function()
	spawn(function()
		game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(261439002)
	end)
	spawn(function()
		game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(96669943)
	end)
	pcall(function()
		game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
		game.Players.LocalPlayer.Backpack:WaitForChild("WintersGreatSword").Parent = game.Players.LocalPlayer.Character
		local Handle = game.Players.LocalPlayer.Character:WaitForChild("WintersGreatSword").Handle
		if Handle then
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= game.Players.LocalPlayer and v.Name == Target then
					repeat
						wait()
						pcall(function()
							for i,c in pairs(v.Character:GetChildren()) do
								if c:IsA("BasePart") then
									c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
								end
							end
						end)
					until v.Character:FindFirstChild("Ice Block")
				end
			end
		end
	end)
	
	game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
	game.Players.LocalPlayer.Backpack:WaitForChild("SpartanSword").Parent = game.Players.LocalPlayer.Character
	game.Players.LocalPlayer.Character.SpartanSword.Input:FireServer("Mouse2",false,CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)))
	game.Players.LocalPlayer.Character.SpartanSword.Input:FireServer("Mouse1",false)
	game.Players.LocalPlayer.Character.SpartanSword.Input:FireServer("Mouse1",true)
	
	spawn(function()
		repeat
			wait()
			game.Players.LocalPlayer.Character.SpartanSword.Input:FireServer("Mouse1",true)
		until workspace:FindFirstChild(Target):FindFirstChild("KickedScript")
	end)
	
	wait(.75)
	pcall(function()
		local Handle = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle
		if Handle and Handle:FindFirstChildOfClass("TouchTransmitter") then
			pcall(function()
				repeat
					wait()
					for i,c in pairs(workspace:FindFirstChild(Target):GetChildren()) do
						if c:IsA("BasePart") then
							c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
						end
					end
				until workspace:FindFirstChild(Target):FindFirstChild("KickedScript")
			end)
		end
	end)
	
	spawn(function()
		game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(96669943)
	end)
	spawn(function()
		game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(261439002)
	end)
end)

local P5Button2 = Instance.new("TextButton", page5)
P5Button2.Size = UDim2.new(0.17, 0, 0.025, 0)
P5Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P5Button2.TextScaled = true
P5Button2.TextWrapped = true
P5Button2.Text = "Regen (HealPads)"
P5Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P5Button2.MouseButton1Click:Connect(function()
	HealPad = not HealPad
	if HealPad then
		P5Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while HealPad do
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
					for i, v in pairs(game.Players:GetChildren()) do
						if workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("HealingPad") then
							wait()
							spawn(function()
								firetouchinterest(game.Players.LocalPlayer.Character.Head, workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("HealingPad"), 0)
							end)
						end
					end
				end
			end)
		end
	else
		P5Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)
spawn(function()
	if HealPad then
		P5Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while HealPad do
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
					for i, v in pairs(game.Players:GetChildren()) do
						if workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("HealingPad") then
							wait()
							spawn(function()
								firetouchinterest(game.Players.LocalPlayer.Character.Head, workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("HealingPad"), 0)
							end)
						end
					end
				end
			end)
		end
	else
		P5Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P5Button3 = Instance.new("TextButton", page5)
P5Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
P5Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P5Button3.TextScaled = true
P5Button3.TextWrapped = true
P5Button3.Text = "Anti-Skid"
P5Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P5Button3.MouseButton1Click:Connect(function()
	AntiSkid = not AntiSkid
	if AntiSkid then
		P5Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while AntiSkid do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					local hand = game.Players[v.Name].Character
					local backpack = game.Players[v.Name].Backpack
					Gear1 = backpack:FindFirstChild("KorbloxSwordAndShield") or hand:FindFirstChild("KorbloxSwordAndShield")
					Gear2 = backpack:FindFirstChild("NeonNinjaSword") or hand:FindFirstChild("NeonNinjaSword")
					Gear3 = backpack:FindFirstChild("SkullCracker") or hand:FindFirstChild("SkullCracker")
					Gear4 = backpack:FindFirstChild("SkullMace") or hand:FindFirstChild("SkullMace")
					Gear5 = backpack:FindFirstChild("Icedagger") or hand:FindFirstChild("Icedagger")
					if v ~= game.Players.LocalPlayer and Gear1 and Gear2 and Gear3 and Gear4 and Gear5 then
						if not table.find(SkidList, v.Name) then
							notify(v.Name .. " is using the leaked CBring script.")
							table.insert(SkidList, v.Name)
						end
						Rocket(v)
					end
				end
			end)
		end
	else
		P5Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P5Button4 = Instance.new("TextButton", page5)
P5Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
P5Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P5Button4.TextScaled = true
P5Button4.TextWrapped = true
P5Button4.Text = "Horn Spam"
P5Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P5Button4.MouseButton1Click:Connect(function()
	HornSpam = not HornSpam
	if HornSpam then
		P5Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while HornSpam do
			wait(.225)
			spawn(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("KOSSGustHorn") then
					game:GetService("Players").LocalPlayer.Character.KOSSGustHorn.RemoteEvent:FireServer("DO THE THING!!!")
				end
			end)
		end
	else
		P5Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P5Button5 = Instance.new("TextButton", page5)
P5Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
if AntiDim then
	P5Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	spawn(function()
		while AntiDim do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >= 1 then
						local Torso = v.Character:FindFirstChild("Torso")
						if Torso and Torso.Anchored == true and not v.Character:FindFirstChild("Invincibility") and not v.Character:FindFirstChild("TelaThornScript") and not v.Character:FindFirstChild("Ice Block") then
							if not table.find(QueueKillDIM, v.Name) then
								for i, DimGear in pairs(DimGears) do
									if v.Backpack:FindFirstChild(DimGear) then
										table.insert(QueueKillDIM, v.Name)
										spawn(function()
											repeat
												wait(1.5)
												if Torso.Anchored == true then
													Rocket(v)
												end
											until v.Character.Humanoid.Health <= 0 or Torso.Anchored == false
											if v.Character.Humanoid.Health <= 0 then
												notify(v.Name .. " tried to do dim.")
											end
											QueueKillDIM = {}
										end)
									end
								end
							end
						end
					end
				end
			end)
		end
	end)
else
	P5Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P5Button5.TextScaled = true
P5Button5.TextWrapped = true
P5Button5.Text = "Anti-Dim"
P5Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P5Button5.MouseButton1Click:Connect(function()
	AntiDim = not AntiDim
	if AntiDim then
		P5Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while AntiDim do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >= 1 then
						local Torso = v.Character:FindFirstChild("Torso")
						if Torso and Torso.Anchored == true and not v.Character:FindFirstChild("Invincibility") and not v.Character:FindFirstChild("TelaThornScript") and not v.Character:FindFirstChild("Ice Block") then
							if not table.find(QueueKillDIM, v.Name) then
								for i, DimGear in pairs(DimGears) do
									if v.Backpack:FindFirstChild(DimGear) then
										table.insert(QueueKillDIM, v.Name)
										spawn(function()
											repeat
												wait(1.5)
												if Torso.Anchored == true then
													Rocket(v)
												end
											until v.Character.Humanoid.Health <= 0 or Torso.Anchored == false
											if v.Character.Humanoid.Health <= 0 then
												notify(v.Name .. " tried to do dim.")
											end
											QueueKillDIM = {}
										end)
									end
								end
							end
						end
					end
				end
			end)
		end
	else
		P5Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

------------------------------ page 6 ------------------------------

local P6Button1 = Instance.new("TextButton", page6)
P6Button1.Size = UDim2.new(0.17, 0, 0.025, 0)
if AntiFF then
	P6Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	spawn(function()
		while AntiFF do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer then
						if not table.find(QueueKillFF, v.Name) and v.Character:FindFirstChild("Sword of the Behemoth") and v.Character.Humanoid.Health >= 1 then
							table.insert(QueueKillFF, v.Name)
							spawn(function()
								repeat
									Rocket(v)
									wait(1)
								until v.Character.Humanoid.Health <= 0 or not v.Character:FindFirstChild("Sword of the Behemoth")
								if v.Character.Humanoid.Health <= 0 then
									notify(v.Name .. " tried to use behemoth.")
								end
								QueueKillFF = {}
							end)
						end
					end
				end
			end)
		end
	end)
	if syn then
		spawn(function()
			pcall(function()
				FFUserFound = false
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >= 1 then
						if v.Character:FindFirstChildOfClass("ForceField") and v.Character:FindFirstChildOfClass("ForceField").Name ~= "Invincibility" and not v.Character:FindFirstChild("BatControls") and not v.Character:FindFirstChild("ShieldSphere") then
							FFUserFound = true
							notify(v.Name .. " has FF.")
							repeat
								game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped)
								pcall(function()
									if game.Players.LocalPlayer.Character.Humanoid.Health >= 1 and game.Players.LocalPlayer.Character:FindFirstChild("Right Arm") then
										local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild("BeamSword") or game.Players.LocalPlayer.Character:FindFirstChild("BeamSword")
										local Handle = Tool and Tool.FindFirstChild(Tool, "Handle")
										if not Tool then
											game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(92142829)
										end
										if not game.Players.LocalPlayer.Character:FindFirstChild("BeamSword") then
											game.Players.LocalPlayer.Backpack:WaitForChild("BeamSword")
											Tool.Parent = game.Players.LocalPlayer.Character
										end
										for i,c in pairs(v.Character:GetChildren()) do
											if c:IsA("BasePart") and c.Name == "Right Arm" then
												c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
											end
										end
									end
								end)
							until not v.Character:FindFirstChild("Right Arm") or v.Character.Humanoid.Health <= 0 or (v.Character:FindFirstChild("Right Arm").Position - v.Character:FindFirstChild("Torso").Position).magnitude >= 2.2
						end
					end
				end
				if FFUserFound then
					notify("FF users killed.")
					game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(92142829)
				end
			end)
		end)
	end
else
	P6Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P6Button1.TextScaled = true
P6Button1.TextWrapped = true
P6Button1.Text = "Anti-FF"
P6Button1.Position = UDim2.new(0.015, 0, 0.8, 0)
P6Button1.MouseButton1Click:Connect(function()
	AntiFF = not AntiFF
	if AntiFF then
		P6Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		spawn(function()
			while AntiFF do
				wait()
				pcall(function()
					for i, v in pairs(game.Players:GetChildren()) do
						if v ~= game.Players.LocalPlayer then
							if not table.find(QueueKillFF, v.Name) and v.Character:FindFirstChild("Sword of the Behemoth") and v.Character.Humanoid.Health >= 1 then
								table.insert(QueueKillFF, v.Name)
								spawn(function()
									repeat
										Rocket(v)
										wait(1)
									until v.Character.Humanoid.Health <= 0 or not v.Character:FindFirstChild("Sword of the Behemoth")
									if v.Character.Humanoid.Health <= 0 then
										notify(v.Name .. " tried to use behemoth.")
									end
									QueueKillFF = {}
								end)
							end
						end
					end
				end)
			end
		end)
		if syn then
			spawn(function()
				pcall(function()
					FFUserFound = false
					for i, v in pairs(game.Players:GetChildren()) do
						if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >= 1 then
							if v.Character:FindFirstChildOfClass("ForceField") and v.Character:FindFirstChildOfClass("ForceField").Name ~= "Invincibility" and not v.Character:FindFirstChild("BatControls") and not v.Character:FindFirstChild("ShieldSphere") then
								FFUserFound = true
								notify(v.Name .. " has FF.")
								table.insert(QueueKillFF, v.Name)
								repeat
									game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped)
									pcall(function()
										if game.Players.LocalPlayer.Character.Humanoid.Health >= 1 and game.Players.LocalPlayer.Character:FindFirstChild("Right Arm") then
											local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild("BeamSword") or game.Players.LocalPlayer.Character:FindFirstChild("BeamSword")
											local Handle = Tool and Tool.FindFirstChild(Tool, "Handle")
											if not Tool then
												game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(92142829)
											end
											if not game.Players.LocalPlayer.Character:FindFirstChild("BeamSword") then
												game.Players.LocalPlayer.Backpack:WaitForChild("BeamSword")
												Tool.Parent = game.Players.LocalPlayer.Character
											end
											for i,c in pairs(v.Character:GetChildren()) do
												if c:IsA("BasePart") and c.Name == "Right Arm" then
													c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
												end
											end
										end
									end)
								until not v.Character:FindFirstChild("Right Arm") or v.Character.Humanoid.Health <= 0 or (v.Character:FindFirstChild("Right Arm").Position - v.Character:FindFirstChild("Torso").Position).magnitude >= 2.2
							end
						end
					end
					if FFUserFound then
						notify("FF users killed.")
						game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(92142829)
					end
				end)
			end)
		end
	else
		P6Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P6Button2 = Instance.new("TextButton", page6)
P6Button2.Size = UDim2.new(0.17, 0, 0.025, 0)
P6Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P6Button2.TextScaled = true
P6Button2.TextWrapped = true
P6Button2.Text = "Fast Rockets (beta)"
P6Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P6Button2.MouseButton1Click:Connect(function()
	FastRockets = not FastRockets
	if FastRockets then
		P6Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		spawn(function()
			while FastRockets do game:GetService("RunService").Heartbeat:wait()
				settings().Physics.AllowSleep = false
				settings().Physics.ThrottleAdjustTime = math.huge-math.huge
				 setsimulationradius(1e9, 1e9)
				game:GetService("RunService").Stepped:wait()
			end
		end)
		while FastRockets do
			game:GetService("RunService").Stepped:wait()
			spawn(function()
				for i, v in pairs (workspace:GetChildren()) do
					if v.Name == "Rocket" and v:FindFirstChild("RocketPropulsion") then
						v.RocketPropulsion.MaxSpeed = 40000
					end
				end
			end)
		end
	else
		P6Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P6Button3 = Instance.new("TextButton", page6)
P6Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
P6Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P6Button3.TextScaled = true
P6Button3.TextWrapped = true
P6Button3.Text = "Rocket Rain"
P6Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P6Button3.MouseButton1Click:Connect(function()
	RocketRain = not RocketRain
	if RocketRain then
		P6Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while RocketRain do
			wait()
			pcall(function()
				local RocketJumper = game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") or game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper")
				local Randomness1 = math.random(-250, 250)
				local Randomness2 = math.random(-250, 250)
				RocketJumper.FireRocket:FireServer(Vector3.new(Randomness1, 0, Randomness2), Vector3.new(Randomness1, 500, Randomness2))
			end)
		end
	else
		P6Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P6Button4 = Instance.new("TextButton", page6)
P6Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
P6Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
P6Button4.TextScaled = true
P6Button4.TextWrapped = true
P6Button4.Text = "Spawn ForceField"
P6Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P6Button4.MouseButton1Click:Connect(function()
	fireclickdetector(workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.ClickDetector)
end)
spawn(function()
	while wait() do
		pcall(function()
			if workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.Knob.BrickColor == BrickColor.new("Bright green") then
				P6Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			elseif workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.Knob.BrickColor == BrickColor.new("Bright red") then
				P6Button4.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			end
		end)
	end
end)

local P6Button5 = Instance.new("TextButton", page6)
P6Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
if LoadSpam then
	P6Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
else
	P6Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P6Button5.TextScaled = true
P6Button5.TextWrapped = true
P6Button5.Text = "Load Spam"
P6Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P6Button5.MouseButton1Click:Connect(function()
	LoadSpam = not LoadSpam
	if LoadSpam then
		P6Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		for i, v in pairs(game.Players:GetChildren()) do
			spawn(function()
				while LoadSpam do
					wait()
					for count = 1, 9 do
						if not LoadSpam then
							break
						end
						wait(.3)
						fireclickdetector(workspace:FindFirstChild(v.Name.."'s Cloud").OutfitGiver.Next.ClickDetector)
					end
					for count = 1, 9 do
						if not LoadSpam then
							break
						end
						wait(.3)
						fireclickdetector(workspace:FindFirstChild(v.Name.."'s Cloud").OutfitGiver.Previous.ClickDetector)
					end
				end
			end)
		end
	else
		P6Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

------------------------------ page 7 ------------------------------

local P7Button1 = Instance.new("TextButton", page7)
P7Button1.Size = UDim2.new(0.17, 0, 0.025, 0)
P7Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P7Button1.TextScaled = true
P7Button1.TextWrapped = true
P7Button1.Text = "SK (melee)"
P7Button1.Position = UDim2.new(0.015, 0, 0.8, 0)
P7Button1.MouseButton1Click:Connect(function()
	SK = not SK
	if SK then
		P7Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		spawn(function()
			while SK do
				game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped)
				if game.Players:FindFirstChild(Target) then
					pcall(function()
						game:GetService("RunService").RenderStepped:Wait()
						local sword = "BatKnightBatSword"
						if game.Players.LocalPlayer.Character:FindFirstChild(sword) then
						elseif not game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild(sword) and not game.Players.LocalPlayer.Character:FindFirstChild(sword) then
							game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(17680660)
						end
						game.Players.LocalPlayer.Backpack:FindFirstChild(sword).Parent = game.Players.LocalPlayer.Character
					end)
				end
			end
		end)
		while SK do
			game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped)
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Sit == true then
					game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Sit = false
				end
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Part") then
						v.Velocity = Vector3.new(0,0,0)
					end
				end
				if game.Players:FindFirstChild(Target) then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild(Target.."'s Cloud").Union.CFrame + Vector3.new(-2.5, 4, 0)
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").Union.CFrame + Vector3.new(0, 4, 0)
				end
			end)
		end
	else
		P7Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P7Button2 = Instance.new("TextButton", page7)
P7Button2.Size = UDim2.new(0.085, 0, 0.025, 0)
P7Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P7Button2.TextScaled = true
P7Button2.TextWrapped = true
P7Button2.Text = "Kill Aura"
P7Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P7Button2.MouseButton1Click:Connect(function()
	RocketWithinDistance = not RocketWithinDistance
	if RocketWithinDistance then
		P7Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while RocketWithinDistance do
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer then
						if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 50 then
							Rocket(v)
						end
					end
				end
			end)
		end
	else
		P7Button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P7Button2Extension = Instance.new("TextBox", page7)
P7Button2Extension.Size = UDim2.new(0.085, 0, 0.025, 0)
P7Button2Extension.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P7Button2Extension.TextScaled = true
P7Button2Extension.TextWrapped = true
P7Button2Extension.Text = "Kill Aura distance (Default is 50)"
P7Button2Extension.Position = UDim2.new(0.1, 0, 0.825, 0)
P7Button2Extension:GetPropertyChangedSignal("Text"):Connect(function()
	NearbyDistance = tonumber(P7Button2Extension.Text)
end)

local P7Button3 = Instance.new("TextButton", page7)
P7Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
P7Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P7Button3.TextScaled = true
P7Button3.TextWrapped = true
P7Button3.Text = "Lock Target On Join"
P7Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P7Button3.MouseButton1Click:Connect(function()
	LockOnJoin = not LockOnJoin
	if LockOnJoin then
		P7Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		P7Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

local P7Button4 = Instance.new("TextButton", page7)
P7Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
P7Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P7Button4.TextScaled = true
P7Button4.TextWrapped = true
P7Button4.Text = "Boost FPS"
P7Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P7Button4.MouseButton1Click:Connect(function()
	pcall(function()
		local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
		local g = game
		local w = g:GetService("Workspace")
		local l = g:GetService("Lighting")
		local t = w.Terrain
		t.WaterWaveSize = 0
		t.WaterWaveSpeed = 0
		t.WaterReflectance = 0
		t.WaterTransparency = 0
		l.GlobalShadows = false
		l.FogEnd = 9e9
		for i, v in pairs(g:GetDescendants()) do
			if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
				v.Material = "Plastic"
				v.Reflectance = 0
			elseif v:IsA("Decal") and decalsyeeted then
				v.Transparency = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA("Explosion") then
				v.BlastPressure = 1
				v.BlastRadius = 1
			end
		end
	end)
end)

local P7Button5 = Instance.new("TextButton", page7)
P7Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
if YeetNightmare then
	P7Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	spawn(function()
		while YeetNightmare do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer then
						if not table.find(QueueKillNightmare, v.Name) and v.Character:FindFirstChild("NightmareDragonSlayerSword") and v.Character.Humanoid.Health >= 1 then
							table.insert(QueueKillNightmare, v.Name)
							spawn(function()
								repeat
									Rocket(v)
									wait(1)
								until v.Character.Humanoid.Health <= 0 or not v.Character:FindFirstChild("NightmareDragonSlayerSword")
								if v.Character.Humanoid.Health <= 0 then
									notify(v.Name .. " tried to use nightmare.")
									NightmareUsersStopped = tonumber(game:GetService('HttpService'):JSONDecode(readfile("NightmareUsersStopped.json"))) + 1
									writefile("NightmareUsersStopped.json", game:GetService('HttpService'):JSONEncode(tostring(NightmareUsersStopped)))
								end
								QueueKillNightmare = {}
							end)
						end
					end
				end
			end)
		end
	end)
else
	P7Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end
P7Button5.TextScaled = true
P7Button5.TextWrapped = true
P7Button5.Text = "Kill Nightmare Users"
P7Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P7Button5.MouseButton1Click:Connect(function()
	YeetNightmare = not YeetNightmare
	if YeetNightmare then
		P7Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while YeetNightmare do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer then
						if not table.find(QueueKillNightmare, v.Name) and v.Character:FindFirstChild("NightmareDragonSlayerSword") and v.Character.Humanoid.Health >= 1 then
							table.insert(QueueKillNightmare, v.Name)
							spawn(function()
								repeat
									Rocket(v)
									wait(1)
								until v.Character.Humanoid.Health <= 0 or not v.Character:FindFirstChild("NightmareDragonSlayerSword")
								if v.Character.Humanoid.Health <= 0 then
									notify(v.Name .. " tried to use nightmare.")
									NightmareUsersStopped = tonumber(game:GetService('HttpService'):JSONDecode(readfile("NightmareUsersStopped.json"))) + 1
									writefile("NightmareUsersStopped.json", game:GetService('HttpService'):JSONEncode(tostring(NightmareUsersStopped)))
								end
								QueueKillNightmare = {}
							end)
						end
					end
				end
			end)
		end
	else
		P7Button5.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

------------------------------ page 8 ------------------------------

local P8Button1 = Instance.new("TextButton", page8)
P8Button1.Size = UDim2.new(0.17, 0, 0.025, 0)
P8Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P8Button1.TextScaled = true
P8Button1.TextWrapped = true
P8Button1.Text = "FF"
P8Button1.Position = UDim2.new(0.015, 0, 0.8, 0)
P8Button1.MouseButton1Click:Connect(function()
	if not Voided and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health >= 1 then
		Pos = game.Players.LocalPlayer.Character.Head.Position
		RootPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

		if not game.Players.LocalPlayer.Backpack:FindFirstChild('Sword of the Behemoth') then
			game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(93725362)
		end
			
		if not game.Players.LocalPlayer.Backpack:FindFirstChild('SwordOfLight') then
			game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(77443461)
		end 
		
		if not game.Players.LocalPlayer.Backpack:FindFirstChild('SwordOfDarkness') then
			game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(77443491)
		end

		platform2 = Instance.new("Part")
		platform2.Name = "Platform"
		platform2.Anchored = true
		platform2.Size = Vector3.new(5.5, 1, 5.5)
		platform2.Transparency = 1
		platform2.Position = Pos - Vector3.new(0, 5, 0)
		platform2.Parent = workspace
		spawn(function()
			repeat
				game:GetService("RunService").RenderStepped:Wait()
				pcall(function()
					for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
						if v:IsA("Part") then
							v.Velocity = Vector3.new(0,0,0)
						end
					end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RootPos
				end)
			until not game.Players.LocalPlayer.Backpack:FindFirstChild('SwordOfDarkness') and not game.Players.LocalPlayer.Character:FindFirstChild('SwordOfDarkness')
			platform2:Remove()
		end)

		repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChild('Sword of the Behemoth') and game.Players.LocalPlayer.Backpack:FindFirstChild('SwordOfLight') and game.Players.LocalPlayer.Backpack:FindFirstChild('SwordOfDarkness')
		local sol = game.Players.LocalPlayer.Backpack.SwordOfLight
		local sod = game.Players.LocalPlayer.Backpack.SwordOfDarkness
		local behe = game.Players.LocalPlayer.Backpack['Sword of the Behemoth']
		
		behe.Parent = game.Players.LocalPlayer.Character
		wait(0.2)
		behe:FindFirstChild('Click'):FireServer(true, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
		wait(15.5)
		behe:FindFirstChild('Click'):FireServer(false, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
		wait(3.5)
		game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(93725362)
		wait(1.5)
		sol.Parent = game.Players.LocalPlayer.Character
		sol:FindFirstChild('Remote'):FireServer(Enum.KeyCode.E)
		wait(2)
		game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(77443461)
		sod.Parent = game.Players.LocalPlayer.Character
		sod:FindFirstChild('Remote'):FireServer(Enum.KeyCode.Q)
		wait(1.5)
		game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(77443491)
		
		for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v.Name == 'LeapForce' then
				v:Destroy()
			end
		end
	end
end)

local P8Button2 = Instance.new("TextButton", page8)
P8Button2.Size = UDim2.new(0.17, 0, 0.025, 0)
P8Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P8Button2.TextScaled = true
P8Button2.TextWrapped = true
P8Button2.Text = "MED"
P8Button2.Position = UDim2.new(0.015, 0, 0.825, 0)
P8Button2.MouseButton1Click:Connect(function()
	if not Voided then
		if not game.Players.LocalPlayer.Backpack:FindFirstChild("Hard Breaker") and not game.Players.LocalPlayer.Character:FindFirstChild("Hard Breaker") then
			game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(83704179)
			game.Players.LocalPlayer.Backpack:WaitForChild("Hard Breaker").Parent = game.Players.LocalPlayer.Character
		elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Hard Breaker") then
			game.Players.LocalPlayer.Backpack:FindFirstChild("Hard Breaker").Parent = game.Players.LocalPlayer.Character
		end
		local Handle = game.Players.LocalPlayer.Character:FindFirstChild("Hard Breaker").Handle
		if Handle:FindFirstChild("Mesh") then
			Handle:FindFirstChild("Mesh"):Destroy()
		end
		pcall(function()
			if Handle then
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >=1 then
						for i,b in pairs(v.Character:GetChildren()) do
							if b:IsA("Accessory") then
								spawn(function()
									if b:FindFirstChild("Handle") then
										b.Handle = ((b.Handle.IsA(b.Handle, "BasePart") and firetouchinterest(Handle, b.Handle, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, b.Handle, 0)) and nil) or b.Handle) or b.Handle
									end
								end)
							end
						end
					end
				end
			end
		end)
		wait(.5)
		game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(83704179)
	end
end)

local P8Button3 = Instance.new("TextButton", page8)
P8Button3.Size = UDim2.new(0.17, 0, 0.025, 0)
P8Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P8Button3.TextScaled = true
P8Button3.TextWrapped = true
P8Button3.Text = "Loop MED"
P8Button3.Position = UDim2.new(0.015, 0, 0.85, 0)
P8Button3.MouseButton1Click:Connect(function()
	MED = not MED
	if MED then
		P8Button3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		while MED do
			wait(.25)
			pcall(function()
				if not game.Players.LocalPlayer.Backpack:FindFirstChild("Hard Breaker") and not game.Players.LocalPlayer.Character:FindFirstChild("Hard Breaker") then
					game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(83704179)
					game.Players.LocalPlayer.Backpack:WaitForChild("Hard Breaker").Parent = game.Players.LocalPlayer.Character
				elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Hard Breaker") then
					game.Players.LocalPlayer.Backpack:FindFirstChild("Hard Breaker").Parent = game.Players.LocalPlayer.Character
				end
			end)
			pcall(function()
				local Handle = game.Players.LocalPlayer.Character:FindFirstChild("Hard Breaker").Handle
				if Handle:FindFirstChild("Mesh") then
					Handle:FindFirstChild("Mesh"):Destroy()
				end
				if Handle then
					for i, v in pairs(game.Players:GetChildren()) do
						if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >=1 then
							for i,b in pairs(v.Character:GetChildren()) do
								if b:IsA("Accessory") then
									spawn(function()
										if b:FindFirstChild("Handle") and not b.Handle:FindFirstChildOfClass("BodyForce") then
											b.Handle = ((b.Handle.IsA(b.Handle, "BasePart") and firetouchinterest(Handle, b.Handle, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, b.Handle, 0)) and nil) or b.Handle) or b.Handle
										end
									end)
								end
							end
						end
					end
				end
			end)
		end
	else
		P8Button3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if game.Players.LocalPlayer.Backpack:FindFirstChild("Hard Breaker") or game.Players.LocalPlayer.Character:FindFirstChild("Hard Breaker") then
			wait(.5)
			game:GetService('ReplicatedStorage').Remotes.ToggleAsset:InvokeServer(83704179)
		end
	end
end)

local P8Button4 = Instance.new("TextButton", page8)
P8Button4.Size = UDim2.new(0.17, 0, 0.025, 0)
P8Button4.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P8Button4.TextScaled = true
P8Button4.TextWrapped = true
P8Button4.Text = "Blind"
P8Button4.Position = UDim2.new(0.015, 0, 0.875, 0)
P8Button4.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(92142829)
	game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(69210321)
	if tb.Text == "All" then
		pcall(function()
			game.Players.LocalPlayer.Backpack:FindFirstChild("BeamSword").Parent = game.Players.LocalPlayer.Character
			local Handle = game.Players.LocalPlayer.Character:WaitForChild("BeamSword").Handle
			if workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.Knob.BrickColor == BrickColor.new("Bright green") then
				fireclickdetector(workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.ClickDetector)
			end
			if Handle then
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer then
						repeat
							wait()
							pcall(function()
								for i,c in pairs(v.Character:GetChildren()) do
									if c:IsA("BasePart") then
										c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
									end
								end
							end)
						until v.Character.Humanoid.Health <= 0
					end
				end
			end
		end)
	else
		pcall(function()
			game.Players.LocalPlayer.Backpack:FindFirstChild("BeamSword").Parent = game.Players.LocalPlayer.Character
			local Handle = game.Players.LocalPlayer.Character:WaitForChild("BeamSword").Handle
			if workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.Knob.BrickColor == BrickColor.new("Bright green") then
				fireclickdetector(workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.ClickDetector)
			end
			if Handle then
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer and v.Name == Target then
						repeat
							wait()
							pcall(function()
								for i,c in pairs(v.Character:GetChildren()) do
									if c:IsA("BasePart") then
										c = ((c.IsA(c, "BasePart") and firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
									end
								end
							end)
						until v.Character.Humanoid.Health <= 0
					end
				end
			end
		end)
	end
	game.Players.LocalPlayer.Backpack:WaitForChild("HadesStaff").Parent = game.Players.LocalPlayer.Character
	if tb.Text ~= "All" then
		wait(2)
	end
	mouse1click()
	if tb.Text == "All" then
		pcall(function()
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= game.Players.LocalPlayer then
					spawn(function()
						local Part = workspace:WaitForChild("Part")
						repeat
							pcall(function()
								for i,c in pairs(v.Character:GetChildren()) do
									if c:IsA("BasePart") then
										c = ((c.IsA(c, "BasePart") and firetouchinterest(Part, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Part, c, 0)) and nil) or c) or c
									end
								end
							end)
							wait()
						until not Part
					end)
				end
			end
		end)
	else
		pcall(function()
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= game.Players.LocalPlayer and v.Name == Target then
					spawn(function()
						local Part = workspace:WaitForChild("Part")
						repeat
							pcall(function()
								for i,c in pairs(v.Character:GetChildren()) do
									if c:IsA("BasePart") then
										c = ((c.IsA(c, "BasePart") and firetouchinterest(Part, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Part, c, 0)) and nil) or c) or c
									end
								end
							end)
							wait()
						until not Part
					end)
				end
			end
		end)
	end
	wait(3)
	game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(92142829)
	game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(69210321)
	if workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.Knob.BrickColor == BrickColor.new("Bright red") then
		fireclickdetector(workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").ForceFieldLever.ClickDetector)
	end
end)

local P8Button5 = Instance.new("TextButton", page8)
P8Button5.Size = UDim2.new(0.17, 0, 0.025, 0)
P8Button5.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
P8Button5.TextScaled = true
P8Button5.TextWrapped = true
P8Button5.Text = "Unblind"
P8Button5.Position = UDim2.new(0.015, 0, 0.9, 0)
P8Button5.MouseButton1Click:Connect(function()
	for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
		if v.Name == "DarknessGui" or v.Name == "ScreenFog" then
			v:Destroy()
		end
	end
end)

------------------------------ page 9 ------------------------------

local P9Button1 = Instance.new("TextButton", page9)
P9Button1.Size = UDim2.new(0.17, 0, 0.025, 0)
P9Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
P9Button1.TextScaled = true
P9Button1.TextWrapped = true
P9Button1.Text = "PINK"
P9Button1.Position = UDim2.new(0.015, 0, 0.8, 0)
P9Button1.MouseButton1Click:Connect(function()
	pink = not pink
	if pink then
		P9Button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		if not game.Players.LocalPlayer.Backpack:FindFirstChild("Charming Blade") then
			game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(106064277)
			game.Players.LocalPlayer.Backpack:FindFirstChild("Charming Blade").Parent = game.Players.LocalPlayer.Character
		end
		
		if not game.Players.LocalPlayer.Character:FindFirstChild("Charming Blade") then
			game.Players.LocalPlayer.Backpack:WaitForChild("Charming Blade").Parent = game.Players.LocalPlayer.Character
		end
		
		spawn(function()
			while pink do
				wait(.25)
				pcall(function()
					if not game.Players.LocalPlayer.Character:FindFirstChild("Charming Blade"):FindFirstChild("Handle") then
						game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(106064277)
						game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(106064277)
						game.Players.LocalPlayer.Backpack:FindFirstChild("Charming Blade").Parent = game.Players.LocalPlayer.Character
					end
				end)
			end
		end)
		
		pcall(function()
			local Handle = game.Players.LocalPlayer.Character:FindFirstChild("Charming Blade").Handle
			for i, v in pairs(workspace:GetDescendants()) do
				spawn(function()
					if v.Parent.Name == "ForceField" or v.Name == "ForceField" or v.Name == "Black Hole" or v.Name == "NightmareDragonSlayerSword" or v.Parent.Name == "NightmareDragonSlayerSword" or v.Name == "Handle" and v.Parent == workspace then
						v:Destroy()
					elseif tostring(v.Color) ~= "255, 102, 204" then
						if not v.Parent:FindFirstChildOfClass("Humanoid") then
							if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") or v:IsA("UnionOperation") or v:IsA("WedgePart") then
								v = ((firetouchinterest(Handle, v, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, v, 0)) and nil) or v) or v
							end
						end
					end
				end)
			end
		end)
	else
		P9Button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(106064277)
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

workspace.DescendantAdded:Connect(function(v)
	local Handle = game.Players.LocalPlayer.Character:FindFirstChild("Charming Blade").Handle
	if Handle and pink then
		pcall(function()
			if v.Parent.Name == "ForceField" or v.Name == "ForceField" or v.Name == "Black Hole" or v.Name == "NightmareDragonSlayerSword" or v.Parent.Name == "NightmareDragonSlayerSword" or v.Name == "Handle" and v.Parent == workspace then
				v:Destroy()
			elseif v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") or v:IsA("UnionOperation") or v:IsA("WedgePart") and tostring(v.Color) ~= "255, 102, 204" then
				v = ((firetouchinterest(Handle, v, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, v, 0)) and nil) or v) or v
			end
		end)
		pcall(function()
			for i, c in pairs(v:GetDescendants()) do
				if c.Parent.Name == "ForceField" or c.Name == "ForceField" or c.Name == "Black Hole" or c.Name == "NightmareDragonSlayerSword" or c.Parent.Name == "NightmareDragonSlayerSword" or c.Name == "Handle" and c.Parent == workspace then
					c:Destroy()
				elseif c:IsA("Part") or c:IsA("Union") or c:IsA("MeshPart") or c:IsA("CornerWedgePart") or c:IsA("TrussPart") or c:IsA("UnionOperation") or c:IsA("WedgePart") and tostring(c.Color) ~= "255, 102, 204" then
					c = ((firetouchinterest(Handle, c, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, c, 0)) and nil) or c) or c
				end
			end
		end)
	end
end)

game.StarterGui:SetCore("SendNotification", {
	Duration = 45;
	Title = "Catalog Hell";
	Text = 'Type "All" in the textbox to target everyone, press Z to toggle ON/OFF.';
	Button1 = "Dismiss";
})
game.StarterGui:SetCore("ChatMakeSystemMessage", {
	Text = '[Catalog Hell]: Press Z to toggle killing ON/OFF',
	Color = Color3.new(255, 0, 255)
})

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:connect(function(key)
	if key == "z" then
		on = not on
		if on then
			if tb.Text == "All" then
			else
				tb.Text = Target
			end
			tb.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			if tb.Text == "All" then
				start2()
			else
				start1()
			end
		else
			tb.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		end
	end
end)

function clean()
	for i, v in pairs (workspace:GetChildren()) do
		if v.Name == "Explosion" then
			v:Destroy()
		elseif v.Name == "Rocket" then
			v:Destroy()
		end
	end
end

function StartAntiCrash()
	spawn(function()
		Crasherlist = {}
		while AntiCrash do
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer then
						for i, CrashGear in pairs(CrashGears) do
							if v.Backpack:FindFirstChild(CrashGear) or v.Character:FindFirstChild(CrashGear) or v.Character:FindFirstChild(CrashGear) then
								spawn(function()
									if not table.find(Crasherlist, v.Name) then
										notify(v.Name .. " has a crash gear.")
										table.insert(Crasherlist, v.Name)
										
									end
								end)
								Rocket(v)
							elseif v.Character:FindFirstChild("ChartreusePeriastron") and v.Backpack:FindFirstChild("OmegaRainbowSword") and not v.Character:FindFirstChild("ShieldScript") then
								spawn(function()
									if not table.find(Crasherlist, v.Name) then
										notify(v.Name .. " has a crash gear.")
										table.insert(Crasherlist, v.Name)
										
									end
								end)
								Rocket(v)
							end
						end
					end
				end
			end)
		end
	end)
end
if AntiCrash then
	StartAntiCrash()
end

function AntiRockets()
	active = true
	spawn(function()
		while game:GetService("RunService").RenderStepped:Wait() do
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer and not table.find(AntiRocketBlacklist, v.Name) and game.Players:FindFirstChild(v.Name) then
						if v.Backpack:FindFirstChild("RocketJumper") or v.Character:FindFirstChild("RocketJumper") then
							if active == true then
								if not Voided then
									notify(v.Name .. " has Rocket Jumper, Anti-Rocket voided you.")
									Voided = true
									P1Button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
									LoopVoid()
								end
							end
						end
					end
				end
			end)
		end
	end)
end
if AntiRocketOn then
	AntiRockets()
end

function start1()
	while on do
		game:GetService("RunService").RenderStepped:Wait()
		pcall(function()
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= game.Players.LocalPlayer then
					if v.Name == Target or table.find(TargetList, v.Name) then
						Rocket(v)
					end
				end
			end
		end)
	end
end

function start2()
	spawn(function()
		while on do
			wait()
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= game.Players.LocalPlayer then
						Rocket(v)
					end
				end
			end)
		end
	end)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

spawn(function()
	pcall(function()
		for i,v in pairs(game.Players:GetChildren()) do
			if workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("ForceField") then
				workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("ForceField"):Destroy()
			elseif workspace:FindFirstChild(v.Name.."'s Cloud").ForceFieldLever.Knob.BrickColor ~= BrickColor.new("Bright green") then
				spawn(function()
					repeat
						wait()
					until workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("ForceField")
					workspace:FindFirstChild(v.Name.."'s Cloud"):FindFirstChild("ForceField"):Destroy()
				end)
			end
		end
	end)
end)

spawn(function()
	HitlistTargets = {}
	while true do
		game:GetService("RunService").RenderStepped:Wait()
		pcall(function()
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= game.Players.LocalPlayer and table.find(Hitlist, v.UserId) then
					spawn(function()
						if not table.find(HitlistTargets, v) then
							notify("HITLIST: " .. v.Name)
							table.insert(HitlistTargets, v)
						end
					end)
					Rocket(v)
				end
			end
		end)
	end
end)

spawn(function()
	while wait(.125) do
		pcall(function()
			for i, v in pairs(game.Players:GetChildren()) do
				spawn(function()
					pcall(function()
						if ProtectSpawn then
							if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >= 1 and (v.Character:FindFirstChild"HumanoidRootPart".Position - workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").Union.Position).magnitude <= 25 then
								Rocket(v)
							elseif v ~= game.Players.LocalPlayer and not table.find(SpawnProtectnotify, v.Name) and v.Character.Humanoid.Health <= 0 and (v.Character:FindFirstChild"HumanoidRootPart".Position - workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cloud").Union.Position).magnitude <= 25 and v.Character:FindFirstChild("HumanoidRootPart").Position.Y >= 306.3 then
								notify(v.Name .. " tried to enter your spawn.")
								table.insert(SpawnProtectnotify, v.Name)
							end
							if table.find(SpawnProtectnotify, v.Name) and v.Character.Humanoid.Health >= 1 then
								SpawnProtectnotify = {}
							end
						end
					end)
				end)
			end
			spawn(function()
				pcall(function()
					if workspace.MapModel:FindFirstChild("WaterKill") then
						workspace.MapModel:FindFirstChild("WaterKill"):Destroy()
					end
				end)
			end)
		end)
	end
end)
