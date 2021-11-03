--[[
	id: 6QVkym8ax3hfGGY-l1Qi2
	name: Main
	description: Mheehub.lua
	time1: 2021-03-17 09:27:11.244443+00
	time2: 2021-03-17 09:27:11.244445+00
	uploader: 581
	uploadersession: yoU3O2vCuENB1K7in4CocoHEBDwk-W
	flag: f
--]]

--loading ui
do 
    local ui = game:GetService("CoreGui"):FindFirstChild("Mheehub")
    if ui then
        ui:Destroy()
    end
end

-- Instances:

local Mheehub = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local account_circle = Instance.new("ImageButton")
local TextLabel = Instance.new("TextLabel")
local MainCheck = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local stats = Instance.new("TextLabel")
local clear_all = Instance.new("ImageButton")
local Pig = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")
local Pigger = Instance.new("TextLabel")
local UICorner_4 = Instance.new("UICorner")



Mheehub.Name = "Mheehub"
Mheehub.Parent = game.CoreGui
Mheehub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling



Main.Name = "Main"
Main.Parent = Mheehub
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.ClipsDescendants = true
Main.Size = UDim2.new(0, 0, 0, 0)

UICorner.Parent = Main

account_circle.Name = "account_circle"
account_circle.Parent = Main
account_circle.BackgroundTransparency = 1.000
account_circle.Position = UDim2.new(0.0175267123, 0, 0.0586609319, 0)
account_circle.Size = UDim2.new(0, 25, 0, 25)
account_circle.ZIndex = 2
account_circle.Image = "rbxassetid://3926307971"
account_circle.ImageRectOffset = Vector2.new(124, 204)
account_circle.ImageRectSize = Vector2.new(36, 36)

TextLabel.Parent = Main
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Position = UDim2.new(0.083783783, 0, 0.0583333336, 0)
TextLabel.Size = UDim2.new(0, 79, 0, 25)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.Text = game.Players.LocalPlayer.Name
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

MainCheck.Name = "MainCheck"
MainCheck.Parent = Main
MainCheck.ClipsDescendants = true
MainCheck.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainCheck.Position = UDim2.new(0.0540540554, 0, 0.333333343, 0)
MainCheck.Size = UDim2.new(0,0,0,0)

UICorner_2.CornerRadius = UDim.new(0, 10)
UICorner_2.Parent = MainCheck

stats.Name = "stats"
stats.Parent = MainCheck
stats.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
stats.BackgroundTransparency = 1.000
stats.Position = UDim2.new(0.217522636, 0, 0.0909090936, 0)
stats.Size = UDim2.new(0, 185, 0, 12)
stats.Font = Enum.Font.TitilliumWeb
stats.Text = "Stats : Check" -- Stats : Check
stats.TextColor3 = Color3.fromRGB(255, 255, 255)
stats.TextSize = 25.000

clear_all.Name = "clear_all"
clear_all.Parent = MainCheck
clear_all.BackgroundTransparency = 1.000
clear_all.Position = UDim2.new(0.269133747, 0, -0.0106470287, 0)
clear_all.Size = UDim2.new(0, 25, 0, 25)
clear_all.ZIndex = 2
clear_all.Image = "rbxassetid://3926305904"
clear_all.ImageRectOffset = Vector2.new(484, 764)
clear_all.ImageRectSize = Vector2.new(36, 36)

Pig.Name = "Pig"
Pig.Parent = MainCheck
Pig.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pig.Position = UDim2.new(0.117824771, 0, 0.636363626, 0)
Pig.Size = UDim2.new(0, 251, 0, 11)
Pig.Font = Enum.Font.SourceSans
Pig.TextColor3 = Color3.fromRGB(0, 0, 0)
Pig.TextSize = 14.000
Pig.Text = ""

UICorner_3.Parent = Pig

Pigger.Name = "Pigger"
Pigger.Parent = MainCheck
Pigger.BackgroundColor3 = Color3.fromRGB(18, 255, 6)
Pigger.Position = UDim2.new(0.117824771, 0, 0.636363626, 0)
Pigger.Size = UDim2.new(0,0,0,11) --0, 11, 0, 11
Pigger.Font = Enum.Font.SourceSans
Pigger.TextColor3 = Color3.fromRGB(0, 0, 0)
Pigger.Text = ""
Pigger.TextSize = 14.000

UICorner_4.Parent = Pigger

-- Check HookFunction
if syn then
    local function CountClosures()
        local Count = 0
        for i,v in next, getreg() do
            if typeof(v) == 'function' and is_synapse_function(v) and typeof(i) == 'string' and i:len() == 16 then
                Count = Count + 1
            end
        end
        return Count > 53
    end
    
    local Check = CountClosures()
    if Check then
        game.Players.LocalPlayer:Kick("Anti Hook")
        wait(0.2)
		
        for i = 1,math.huge do
            print("LOL")
        end
    end
end

spawn(function ()
    while true do
        wait()
        for index , value in pairs(game:GetService("CoreGui"):GetChildren()) do
            if value.ClassName == "ScreenGui" or value.Name == "_fhspy" then
                for indexv1 , valuev1 in pairs(value:GetChildren()) do
                    if valuev1.ClassName == "Folder" and valuev1.Name == "Templates" then
                        game:GetService("Players").LocalPlayer:Kick("Anti FrostHook")
                    end
                end
            end
        end
    end
end)

Main:TweenSize(UDim2.new(0, 370, 0, 120),Enum.EasingDirection.Out, Enum.EasingStyle.Bounce,.7,true) 
wait(.6)
MainCheck:TweenSize(UDim2.new(0, 331, 0, 66),Enum.EasingDirection.Out, Enum.EasingStyle.Back,.5,true) 
wait(.6)
Pigger:TweenSize(UDim2.new(0, 10, 0, 11),Enum.EasingDirection.Out, Enum.EasingStyle.Quart,.3,true) 
wait(.5)
Pigger:TweenSize(UDim2.new(0, 20, 0, 11),Enum.EasingDirection.Out, Enum.EasingStyle.Quart,.3,true) 
wait(.5)

-- Varible
local http_request_all = http_request or request or HttpPost or syn.request
local HttpServ = game:GetService('HttpService')

-- Api Check
if key == "" then
    for i = 1,math.huge do
        print("lol")
    end
end

local Api = http_request_all({
    Url = "http://43.228.86.252:3500/user/"..key,
    Method = "GET"
}).Body
local decodeApi = HttpServ:JSONDecode(Api)

if not decodeApi.data then
	Pigger.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	Pigger:TweenSize(UDim2.new(0, 251, 0, 11),Enum.EasingDirection.Out, Enum.EasingStyle.Quart,.3,true) 
	wait(.5)
    print("Not Found")
end
-- Check Key in api
if decodeApi.message == "Key Not Found" then
    for i = 1,math.huge do
        print("lol")
    end
end

if not decodeApi.data then
    for i = 1,math.huge do
        print("lol")
    end
end

-- Api Hwid
local HwidBody = http_request_all({
    Url = 'https://httpbin.org/get',
    Method = 'GET'
}).Body

local decodeHwid = game:GetService('HttpService'):JSONDecode(HwidBody)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint", "Krnl-Hwid", "krnl-hwid", "Electronid", "Flux-Fingerprint"}
local hwid = ""

for i, v in next, hwid_list do
    if decodeHwid.headers[v] then
        hwid = decodeHwid.headers[v];
        break
    end
end

-- Update Hwid
if decodeApi.data.hwid == "Unknown" then
    game.Players.LocalPlayer:Kick("Add Whitelist Success\nExecute Script Again")
    http_request_all({
        Url = "http://43.228.86.252/mheehub/changehwid.php?key="..key.."&hwid="..hwid,
        Method = "GET"
    })
    local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	else
		return 
	end
end

Pigger:TweenSize(UDim2.new(0, 30, 0, 11),Enum.EasingDirection.Out, Enum.EasingStyle.Quart,.3,true) 
wait(.5)
Pigger:TweenSize(UDim2.new(0, 70, 0, 11),Enum.EasingDirection.Out, Enum.EasingStyle.Quart,.3,true) 
wait(.5)
Pigger:TweenSize(UDim2.new(0, 200, 0, 11),Enum.EasingDirection.Out, Enum.EasingStyle.Quart,.3,true) 
wait(.5)
Pigger:TweenSize(UDim2.new(0, 251, 0, 11),Enum.EasingDirection.Out, Enum.EasingStyle.Quart,.3,true) 
wait(.5)
Main:TweenSize(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.Out, Enum.EasingStyle.Bounce,.7,true) 
wait(2)

Mheehub:Destroy()
repeat wait() until  game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character  or Main:TweenSize(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.Out, Enum.EasingStyle.Bounce,.7,true) 





-- game  


function kingpiece()


	
		local mt = getrawmetatable(game)
		local plrs = game.Players.LocalPlayer.Character.HumanoidRootPart
		setreadonly(mt, false)
		local oldIndex = mt.__newindex
		mt.__newindex = newcclosure(function(self, m, a)
			if self == plrs and m == "CFrame" and not checkcaller() then
				return nil
			end
			return oldIndex(self, m, a)
		end) 

	----------------------------------------------------
	local f = {
		autofarm = false;
		Buso = false;
		ken = false;
		GodMode = false ; 
		Newworld = false;
		Logia = false ; 
		speed = 1000 ; 
		Dragon = false ; 
	} 
	

	local LocalPlayer = game:service'Players'.LocalPlayer
		
	local vs = game:GetService("VirtualUser")
	
	local weapon = {}
	for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
		if v.ClassName == "Tool" then --หา tool ใน class backpack
			table.insert(weapon, v.Name) --เอาชื่อ tool ไปใส่ไว้ใน weapon_w
		end
	end
	
	local Playeresv2 = {}
			for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
				   if v.Name ~= game:GetService("Players").LocalPlayer.Name then
					table.insert(Playeresv2, v.Name)
				end
			end
	
	local Islandsxd = {}
	for i, v in pairs(game:GetService("Workspace").Island:GetChildren()) do
		if v:FindFirstChild("Model") then 
			table.insert(Islandsxd, v.Name) 
		end
	end
	
	
	function equip()
		local tool = LocalPlayer:WaitForChild"Backpack":FindFirstChild(wapons)
		wait()
		LocalPlayer.Character.Humanoid:EquipTool(tool)
	end

	local VLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/BunnySalf/Pls-Don-t-Crack-me-Pls/main/Polar.Don't.Crack.Me")()
	local W = VLib:AddWindow("King piece")
	local m1 = W:AddTab("Auto Farm", "http://www.roblox.com/asset/?id=6031302950")
	local m2 = W:AddTab("Auto Stats", "http://www.roblox.com/asset/?id=6034333280")
	local m3 = W:AddTab("Teleport ", "http://www.roblox.com/asset/?id=6034407069")
	local m4 = W:AddTab("DF Sniper ", "http://www.roblox.com/asset/?id=6034989550")
	local m5 = W:AddTab("Player ", "http://www.roblox.com/asset/?id=6034287594")
	
	
	-- Home -- 
	local b = m1:AddSection("Auto Farm")
	local Skillxx = m1:AddSection("Auto Skills")
	local b3 = m2:AddSection("Auto Stats")
	local b4 = m3:AddSection("Teleport Islands")
	local b5 = m4:AddSection("Frits Collect")
	local b6 = m5:AddSection("Farm Players")
	
	
	if game.PlaceId == 4520749081  then
	
	local drop = b:AddDropdown("Select Weapons",weapon,function(t)
		wapons = t 
	  
	end)
	
	b:AddButton("Refesh",function ()
		drop:Clear()
	for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
			if v.ClassName == "Tool" then
				drop:Add(v.Name)
			end
		end
	end)
	
	
	b:AddSwitch("Auto Lvl Farm",false,function(t)
		f.autofarm = t 
		spawn(function ()
			while wait() do 
				if f.autofarm then 
					pcall(function()
						autofarm()
					end)
				end
			end
		end)
	end)


	b:AddSwitch("Auto Farm Dragon",false,function(t)
		f.Dragon = t 
		spawn(function ()
			while wait() do 
				if f.Dragon then 
					pcall(function()
						farmdragon()
					end)
				end
			end
		end)
	end)


	_G.distantss = 3 
	b:AddSlider("Distants NPC",3,15,function(t)
		_G.distantss = t 
	end)

	function gox2()
		if not  game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Map") then 
			positon_npc2 =   CFrame.new(8578.68066, 214.971329, 682.620422)
			monxx =  "Fishman Soldier [Lv. 2150]" 
			exxxx = "Exp 130K"
		end
	end
--[[
	
	b:AddSwitch("Auto New World",function(t)
		f.Newworld = t 
		spawn(function()
			while  wait() do
				if f.Newworld then 
				pcall(function ()
					if game:GetService("Players").LocalPlayer.PlayerStats.lvl.Value >= 2250 then
						f.autofarm = false
						if  game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == false then 
							gox2()
							LocalPlayer.Character.HumanoidRootPart.CFrame = positon_npc2
						vs:CaptureController()
						vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
						wait(1.7)
						for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
							if string.find(v2.Name, "Accept") then
								v2.Position = UDim2.new(0, -5000 ,0, -5000)
								v2.Size = UDim2.new(2000, 2000, 2000, 2000)
								v2.BackgroundTransparency = 1
								Click()
								end
							end
					elseif   game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible  == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text ~= exxxx   then 
						checklevel()
						LocalPlayer.Character.HumanoidRootPart.CFrame = positon_npc
								vs:CaptureController()
								vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
										wait(1.7)
						for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
							if string.find(v2.Name, "Accept") then
									v2.Position = UDim2.new(0, -5000 ,0, -5000)
										v2.Size = UDim2.new(2000, 2000, 2000, 2000)
											v2.BackgroundTransparency = 1
												Click()
										end
									end
				elseif game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text == exxxx   then 
					
						if not  game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Map")  then 
								print("dont have ")
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2884.12451, 44.9235954, 13894.8086)
	
								for i,v in pairs(game:GetService("Workspace").Monster:GetDescendants()) do 
										if	v.Name ==  monxx	and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then  
												repeat  wait()
													pcall(function()
												   equip()
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, _G.distantss)
													vs:CaptureController()
													vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
												 end)
												until v.Humanoid.Health == 0  or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Map")
											
										   
											elseif   game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Map")  then 
												print(" have ")
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2884.12451, 44.9235954, 13894.8086)
											vs:CaptureController()
											vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
											wait(1.7)
											for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
												if string.find(v2.Name, "Accept") then
													v2.Position = UDim2.new(0, -5000 ,0, -5000)
													v2.Size = UDim2.new(2000, 2000, 2000, 2000)
													v2.BackgroundTransparency = 1
													Click()
													end
												end
	
							elseif  game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == false then   
	
								for i2 , v2 in pairs(game:GetService("Workspace").AntiTPNPC:GetChildren()) do
									if v2.Name == "Elite Pirate" and v2:FindFirstChild("HumanoidRootPart") then 
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame  = v2.HumanoidRootPart.CFrame
										wait(1)
									game:GetService("ReplicatedStorage").Remotes.Functions.CheckQuest:InvokeServer( workspace.AntiTPNPC["Elite Pirate"])
										wait(1)
										for i3,v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
											if string.find(v3.Name, "Accept") then
												v3.Position = UDim2.new(0, -5000 ,0, -5000)
													v3.Size = UDim2.new(2000, 2000, 2000, 2000)
														v3.BackgroundTransparency = 1
															Click()
															
														end
													end
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
			end)
		end)
	

]]
	
	
	local f1 = b:AddFolder("Haki More")
	
	
	f1:AddSwitch("Auto Buso",false,function (t)
		f.Buso = t 
	end)
	
	f1:AddSwitch("Auto Ken",false,function (t)
		f.ken  = t 
	end)
	
	f1:AddSwitch("Auto GodMode",false,function (t)
		f.GodMode  = t 
	end)
	
	
	
	Skillxx:AddSwitch("Auto Skill",false,function(t)
		_G.Enabelskill = t 
	end)
	
	Skillxx:AddSwitch("Skill Z",false,function(t)
		_G.Z = t 
	end)
	
	Skillxx:AddSwitch("Skill X",false,function(t)
		_G.X = t 
	end)
	
	Skillxx:AddSwitch("Skill C",false,function(t)
		_G.C = t 
	end)
	

	
	
	local countstats = b3:AddLabel("Points : 0")
	spawn(function()
			while wait() do 
				countstats:Re("Points : " ..game:GetService("Players").LocalPlayer.PlayerStats.Points.value)
		end
	end)
	
	b3:AddSwitch("Melee",false,function(t)
		_G.Melee = t 
	end)
	
	b3:AddSwitch("Defense",false,function(t)
		_G.Defense = t 
	end)
	
	b3:AddSwitch("Sword",false,function(t)
		_G.Sword = t 
	end)
	
	b3:AddSwitch("Power Fruits",false,function(t)
		_G.Fruits = t 
	end)
	
	
	local landss = {}
	for i , v in pairs(game:GetService("Workspace").SpawnPoints:GetChildren()) do 
		if v:IsA("Part") then 
			table.insert(landss , v.Name ) 
		end
	end
	b4:AddDropdown("TP Island",landss,function(t)
		lands = t 
	end)
	
	
		
	b4:AddButton("Teleport",function()
		for i , v in pairs(game:GetService("Workspace").SpawnPoints:GetChildren()) do 
			if v.Name == lands then 
				LocalPlayer.Character.HumanoidRootPart.CFrame =  v.CFrame
			end
		end
		
		end)
	
	b5:AddButton("Collect Fruits",function()
		for _,v in next, game:GetService("Workspace"):GetChildren() do
		if v:IsA("Tool") then
			v.Handle.CFrame  =  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
		end
		end
	end)
	
	b5:AddSwitch("Auto Collet Fruits",false,function(t)
		_G.collet = t 
		spawn(function()
			while  wait() do
				if _G.collet then 
					pcall(function()
						for _,v in next, game:GetService("Workspace"):GetChildren() do
							if v:IsA("Tool") then
									v.Handle.CFrame  =  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
							end
						end
					end)
				end
			end
		end)
	end)
	
	
	
	end
	
	
	if game.PlaceId == 6381829480 then 
	
		local drop = b:AddDropdown("Select Weapons",weapon,function(t)
			wapons = t 
		  
		end)
		
		b:AddButton("Refesh",function ()
			drop:Clear()
		for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
				if v.ClassName == "Tool" then
					drop:Add(v.Name)
				end
			end
		end)
		
		
		b:AddSwitch("Auto Lvl Farm",false,function(t)
			f.autofarm = t 
			spawn(function ()
				while wait() do 
					if f.autofarm then 
						pcall(function()
							autofarm2()
						end)
					end
				end
			end)
		end)
		
		b:AddSwitch("Auto Farm Dragon",false,function(t)
			f.Dragon = t 
			spawn(function ()
				while wait() do 
					if f.Dragon then 
						pcall(function()
							farmdragon()
						end)
					end
				end
			end)
		end)

		_G.distantss = 3 
		b:AddSlider("Distants NPC",3,15,function(t)
			_G.distantss = t 
		end)
		
		local f1 = b:AddFolder("Haki More")
		
		
		f1:AddSwitch("Auto Buso",false,function (t)
			f.Buso = t 
		end)
		
		f1:AddSwitch("Auto Ken",false,function (t)
			f.ken  = t 
		end)
		
		f1:AddSwitch("Auto GodMode",false,function (t)
			f.GodMode  = t 
		end)
		
		
		
	--[[
	
		Skillxx:AddSwitch("Auto Skill",function(t)
			_G.Enabelskill = t 
		end)
		
	
	]]
		Skillxx:AddSwitch("Skill Z",false,function(t)
			_G.Z = t 
		end)
		
		Skillxx:AddSwitch("Skill X",false,function(t)
			_G.X = t 
		end)
		
		Skillxx:AddSwitch("Skill C",false,function(t)
			_G.C = t 
		end)
		
		Skillxx:AddSwitch("Skill V",false,function(t)
			_G.V = t 
		end)
		
		Skillxx:AddSwitch("Skill E",false,function(t)
			_G.E = t 
		end)
		
		
		local countstats = b3:AddLabel("Points : 0")
		spawn(function()
				while wait() do 
					countstats:Re("Points : " ..game:GetService("Players").LocalPlayer.PlayerStats.Points.value)
			end
		end)
		
		b3:AddSwitch("Melee",false,function(t)
			_G.Melee = t 
		end)
		
		b3:AddSwitch("Defense",false,function(t)
			_G.Defense = t 
		end)
		
		b3:AddSwitch("Sword",false,function(t)
			_G.Sword = t 
		end)
		
		b3:AddSwitch("Power Fruits",false,function(t)
			_G.Fruits = t 
		end)
		
		
		local landss = {}
		for i , v in pairs(game:GetService("Workspace").SpawnPoints:GetChildren()) do 
			if v:IsA("Part") then 
				table.insert(landss , v.Name ) 
			end
		end
		b4:AddDropdown("TP Island",landss,function(t)
			lands = t 
		end)
		
		
		b4:AddButton("Teleport",function()
		for i , v in pairs(game:GetService("Workspace").SpawnPoints:GetChildren()) do 
			if v.Name == lands then 
				LocalPlayer.Character.HumanoidRootPart.CFrame =  v.CFrame
			end
		end
		
		end)
		
		b5:AddButton("Collect Fruits",function()
			for _,v in next, game:GetService("Workspace"):GetChildren() do
			if v:IsA("Tool") then
				v.Handle.CFrame  =  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
			end
			end
		end)
		
		b5:AddSwitch("Auto Collet Fruits",false,function(t)
			_G.collet = t 
			spawn(function()
				while  wait() do
					if _G.collet then 
						pcall(function()
							for _,v in next, game:GetService("Workspace"):GetChildren() do
								if v:IsA("Tool") then
										v.Handle.CFrame  =  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
								end
							end
						end)
					end
				end
			end)
		end)
		
	
		
	end
	
	local RefreshComvattap =b6:AddDropdown("Select Players", Playeresv2, function(t) Playeresv2 = t end)
	b6:AddButton("Refesh Players",function ()
		RefreshComvattap:Clear()
			for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
				if v.Name ~= game:GetService("Players").LocalPlayer.Name then
				RefreshComvattap:Add(v.Name)
			end
		end
	end)
	
	b6:AddButton("Teleport Players", function()
		for i, v in pairs(game:GetService"Players":GetPlayers()) do
			if v.Name == Playeresv2 then
				game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.HumanoidRootPart.Position)
			end
		end
	end)
	
	b6:AddSwitch("Teleport", function(t)
		Teleport = t
		spawn(function()
			while wait() do
				if Teleport then
					for i, v in pairs(game:GetService"Players":GetPlayers()) do
						if v.Name == Playeresv2 then
							game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.HumanoidRootPart.Position) * CFrame.new(0, 0, _G.Distantpalyer)
							noclip()
						end
					end
				end
			end
		end)
	end)
	
	_G.Distantpalyer = 3 
	b6:AddSlider("Distants",0,15,3,function(t)
		_G.Distantpalyer = t 
	end)
	
	
	b6:AddSwitch("Inf Jump",false, function(t)
		_G.Inf = t
		spawn(function()
			while wait() do
				if _G.Inf then
					pcall(function()
				--	game:GetService("Players").LocalPlayer.Backpack.GeppoNew.cds.Changed:connect(function()
						game:GetService("Players").LocalPlayer.Backpack.GeppoNew.cds.Value = 6
					end)				
				end
			end
		end)
	end)
	
	
	local f2 = b6:AddFolder("ESP Function")
	
	-- ESP -- 
	local e = {
		enabled = false ;
		Tracers = false ;
		Distance = false ; 
		NAME = false ; 
	}
	
	
	pcall(function()
		
		Camera = game:GetService("Workspace").CurrentCamera
		RunService = game:GetService("RunService")
		camera = workspace.CurrentCamera
		Bottom = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
	
		function GetPoint(vector3)
			local vector, onScreen = camera:WorldToScreenPoint(vector3)
			return {Vector2.new(vector.X,vector.Y),onScreen,vector.Z}
		end
		
		function MakeESP(model)
			local CurrentParent = model.Parent
		
			local TopL = Drawing.new("Line")
			local BottomL = Drawing.new("Line")
			local LeftL = Drawing.new("Line")
			local RightL = Drawing.new("Line")
			local Tracer = Drawing.new("Line")
			local Display = Drawing.new("Text")
	
			coroutine.resume(coroutine.create(function()
				while model.Parent == CurrentParent do
					
					local Distance = (Camera.CFrame.Position - model.HumanoidRootPart.Position).Magnitude
					local GetP = GetPoint(model.Head.Position)
					local headps = model.Head.CFrame
					
					if e.enabled and GetP[2] then
						
						-- Calculate Cords
						local topright = headps * CFrame.new(3,0.5, 0)
						local topleft = headps * CFrame.new(-3,0.5, 0)
						local bottomleft = headps * CFrame.new(-3,-7,0)
						local bottomright = headps * CFrame.new(3,-7,0)
						topright = GetPoint(topright.p)[1]
						topleft = GetPoint(topleft.p)[1]
						bottomleft = GetPoint(bottomleft.p)[1]
						bottomright = GetPoint(bottomright.p)[1]
	
						local teamcolor = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
						TopL.Color, BottomL.Color, RightL.Color, LeftL.Color = teamcolor, teamcolor, teamcolor, teamcolor
						TopL.From, BottomL.From, RightL.From, LeftL.From = topleft, bottomleft, topright, topleft
						TopL.To, BottomL.To, RightL.To, LeftL.To = topright, bottomright, bottomright, bottomleft
						TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = true, true, true, true
					else
						TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = false, false, false, false
					end
					
					if e.enabled and e.Tracers and GetP[2] then
						Tracer.Color = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
						Tracer.From = Bottom
						Tracer.To = GetPoint(headps.p)[1]
						Tracer.Thickness = 1.5
						Tracer.Visible = true
					else
						Tracer.Visible = false
					end
					
					if e.enabled and  e.Distance and GetP[2] then
						Display.Visible = true
						Display.Position = GetPoint(headps.p + Vector3.new(0,0.5,0))[1]
						Display.Center = true
						Display.Text = tostring(math.floor(Distance)).." studs"
					else
						Display.Visible = false
					end
					
					RunService.RenderStepped:Wait()
				end
		
				TopL:Remove()
				BottomL:Remove()
				RightL:Remove()
				LeftL:Remove()
				Tracer:Remove()
				Display:Remove()
			
			end))
		end
		
		for _, Player in next, game:GetService("Players"):GetChildren() do
			if Player.Name ~= game.Players.LocalPlayer.Name then
				MakeESP(Player.Character)
				Player.CharacterAdded:Connect(function()
					delay(0.5, function()
						MakeESP(Player.Character)
					end)
				end)
			end	
		end
		
		game:GetService("Players").PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function()
				delay(0.5, function()
					MakeESP(player.Character)
				end)
			end)
		end)
		
	end)
	
	
	f2:AddSwitch("Enabled ", false,function(t)
		e.enabled = t 
	end)
	
	f2:AddSwitch("Tracers", false,function(t)
		e.Tracers = t 
	end)
	
	f2:AddSwitch("Distance Players",false, function(t)
		e.Distance = t 
	end)
	
	f2:AddSwitch("Name Player",false, function(t)
		e.NAME = t 
		spawn(function()
			wait()
			if e.NAME == true then
				local Holder = Instance.new("Folder", game.CoreGui)
				Holder.Name = "ESP"
				local Box = Instance.new"BoxHandleAdornment"
				Box.Name = "nilBox"
				Box.Size = Vector3.new(4, 7, 4)
				Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
				Box.Transparency = 1e3
				Box.ZIndex = 0
				Box.AlwaysOnTop = false
				Box.Visible = false
				local NameTag = Instance.new"BillboardGui"
				NameTag.Name = "nilNameTag"
				NameTag.Enabled = false
				NameTag.Size = UDim2.new(0, 200, 0, 50)
				NameTag.AlwaysOnTop = true
				NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
				local Tag = Instance.new("TextLabel", NameTag)
				Tag.Name = "Tag"
				Tag.BackgroundTransparency = 1
				Tag.Position = UDim2.new(0, -50, 0, 0)
				Tag.Size = UDim2.new(0, 300, 0, 20)
				Tag.TextSize = 20
				Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
				Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
				Tag.TextStrokeTransparency = 0.4
				Tag.Text = "nil"
				Tag.Font = Enum.Font.SourceSansBold
				Tag.TextScaled = false
				local LoadCharacter = function(v)
					repeat wait() until v.Character ~= nil
					v.Character:WaitForChild"Humanoid"
					local vHolder = Holder:FindFirstChild(v.Name)
					vHolder:ClearAllChildren()
					local b = Box:Clone()
					b.Name = v.Name .. "Box"
					b.Adornee = v.Character
					b.Parent = vHolder
					local t = NameTag:Clone()
					t.Name = v.Name .. "NameTag"
					t.Enabled = true
					t.Parent = vHolder
					t.Adornee = v.Character:WaitForChild("Head", 5)
					if not t.Adornee then return UnloadCharacter(v) end
					t.Tag.Text = v.Name
					b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
					t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
					local Update
					local UpdateNameTag = function()
						if not pcall(function()
							v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
							t.Tag.Text = v.Name .. "\n" .. (maxh ~= 0 and tostring(math.floor(h / maxh * 100)) or "0") .. "%  " .. tostring(h) .. "/" .. tostring(maxh)
						end) then Update:Disconnect() end
					end
					UpdateNameTag()
					Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
				end
				local UnloadCharacter = function(v)
					local vHolder = Holder:FindFirstChild(v.Name)
					if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then vHolder:ClearAllChildren() end
				end
				local LoadPlayer = function(v)
					local vHolder = Instance.new("Folder", Holder)
					vHolder.Name = v.Name
					v.CharacterAdded:Connect(function() pcall(LoadCharacter, v) end)
					v.CharacterRemoving:Connect(function() pcall(UnloadCharacter, v) end)
					v.Changed:Connect(function(prop)
						if prop == "TeamColor" then
							UnloadCharacter(v)
							wait()
							LoadCharacter(v)
						end
					end)
					LoadCharacter(v)
				end
				local UnloadPlayer = function(v)
					UnloadCharacter(v)
					local vHolder = Holder:FindFirstChild(v.Name)
					if vHolder then vHolder:Destroy() end
				end
				for i, v in pairs(game:GetService"Players":GetPlayers()) do spawn(function() pcall(LoadPlayer, v) end) end
				game:GetService"Players".PlayerAdded:Connect(function(v) pcall(LoadPlayer, v) end)
				game:GetService"Players".PlayerRemoving:Connect(function(v) pcall(UnloadPlayer, v) end)
				game:GetService"Players".LocalPlayer.NameDisplayDistance = 0
			else pcall(function() game.CoreGui.ESP:Remove() end) end
		end)
	end)
	
	
	
	-- Ckick 
	function Click()
		vs:CaptureController()
		vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
	end
	
	--Check quest 
	
	function checklevel()
		for i,v in pairs(LocalPlayer.PlayerStats:GetChildren()) do
			if v.Name == "lvl" then
				local lvl = v.value
				if lvl >= 1 and lvl < 10 then
					
					positon_npc = CFrame.new(2013.94, 47.6536, -1809.01)
					positon_island = CFrame.new(2071.33, 50.6025, -1852.72)
					monname = "Soldier [Lv. 1]"
					dfmon = "Exp 143"
	
					elseif lvl >= 10 and lvl < 20 then
						
						positon_npc = CFrame.new(2381.66, 47.395, -1666.55)
						positon_island = CFrame.new(2071.33, 50.6025, -1852.72)
						monname = "Clown Pirate [Lv. 10]"
						dfmon = "Exp 1.43K"
					  
	
						elseif lvl >= 20 and lvl < 30 then
							
							positon_npc = CFrame.new(2300.72, 47.4191, -1854.5)
							positon_island = CFrame.new(2071.33, 50.6025, -1852.72)
							monname = "Smoky [Lv. 20]"
							dfmon = "Exp 2.86K"
						   
	
							elseif lvl >= 30 and lvl < 50 then
							
								positon_npc = CFrame.new(2021.49, 47.5355, -2006.91)
								positon_island = CFrame.new(2071.33, 50.6025, -1852.72)
								monname = "Tashi [Lv. 30]"
								dfmon = "Exp 4.29K"
								
	
								elseif lvl >= 50 and lvl < 75 then
									
									positon_npc = CFrame.new(3964.87, 9.38482, 177.044)
									positon_island = CFrame.new(3880.79, 10.2437, 125.918)
									monname = "Clown Pirate [Lv. 50]"
									dfmon = "Exp 7.15K"
								   
	
									elseif lvl >= 75 and lvl < 100 then
									
										positon_npc = CFrame.new(4262.72, 9.57842, 245.489)
										positon_island = CFrame.new(3880.79, 10.2437, 125.918)
										monname = "The Clown [Lv. 75]"
										dfmon = "Exp 10.72K"
									   
	
										elseif lvl >= 100 and lvl < 120 then
											
											positon_npc = CFrame.new(1920.64, 12.6999, 1178.09)
											positon_island = CFrame.new(1857.83, 14.2861, 1129.86)
											monname = "Commander [Lv. 100]"
											dfmon = "Exp 14.3K"
											
	
											elseif lvl >= 120 and lvl < 145 then
											
												positon_npc = CFrame.new(1732.9, 38.9306, 1216.87)
												positon_island = CFrame.new(1857.83, 14.2861, 1129.86)
												monname = "Captain [Lv. 120]"
												dfmon = "Exp 17.16K"
												
												elseif lvl >= 145 and lvl < 180 then
												
													positon_npc = CFrame.new(1621.68, 51.3228, 1399.05)
													positon_island = CFrame.new(1857.83, 14.2861, 1129.86)
													monname = "Axe-Hand [Lv. 145]"
													dfmon = "Exp 20.73K"
												   
	
													elseif lvl >= 180 and lvl < 200 then
													
														positon_npc = CFrame.new(3846.41, 10.3289, 3329.13)
														positon_island = CFrame.new(3928.54, 11.5746, 3168.91)
														monname = "Fishman [Lv. 180]"
														dfmon = "Exp 25.74K"
														
	
														elseif lvl >= 200 and lvl < 230 then
													
															positon_npc = CFrame.new(4132.45, 10.36, 3122.68)
															positon_island = CFrame.new(3928.54, 11.5746, 3168.91)
															monname = "Karate Fishman [Lv. 200]"
															dfmon = "Exp 28.6K"
															
	
															elseif lvl >= 230 and lvl < 250 then
														
																positon_npc = CFrame.new(4374.8, 10.381, 3230.97)
																positon_island = CFrame.new(3928.54, 11.5746, 3168.91)
																monname = "SharkMan [Lv. 230]"
																dfmon = "Exp 32.5K"
															   
	
																elseif lvl >= 250 and lvl < 300 then
																
																	positon_npc = CFrame.new(-50.4521, 49.2931, -85.4636)
																	positon_island = CFrame.new(-27.3382, 99.729, 83.6776)
																	monname = "Trainer Chef [Lv. 250]"
																	dfmon = "Exp 35.75K"
																	
	
																	elseif lvl >= 300 and lvl < 350 then
															
																		positon_npc = CFrame.new(40.3571, 99.0627, -45.6973)
																		positon_island = CFrame.new(-27.3382, 99.729, 83.6776)
																		monname = "Dark Leg [Lv. 300]"
																		dfmon = "Exp 42.9K"
																		
	
																		elseif lvl >= 350 and lvl < 400 then
																	
																			positon_npc = CFrame.new(-42.252, 50.7658, 112.858)
																			positon_island = CFrame.new(-27.3382, 99.729, 83.6776)
																			monname = "Weapon Man [Lv. 350]"
																			dfmon = "Exp 50.05K"
																		   
																			
																			elseif lvl >= 400 and lvl < 450 then
																				
																				positon_npc = CFrame.new(-2482.71, 27.5497, 1770.03)
																				positon_island = CFrame.new(-2948.12, 29.3863, 1970.99)
																				monname = "Snow Soldier [Lv. 400]"
																				dfmon = "Exp 57.2K"
																				
	
																				elseif lvl >= 450 and lvl < 500 then
																			
																					positon_npc = CFrame.new(-3034.83, 17.3489, 1423.52)
																					positon_island = CFrame.new(-2948.12, 29.3863, 1970.99)
																					monname = "King Snow [Lv. 450]"
																					dfmon = "Exp 64.34K"
																				  
	
																					elseif lvl >= 500 and lvl < 525 then
																				
																						positon_npc = CFrame.new(-2939.76, 27.3347, 1942.33)
																						positon_island = CFrame.new(-2948.12, 29.3863, 1970.99)
																						monname = "Heavy Man [Lv. 500]"
																						dfmon = "Exp 71.5K"
																						
	
																						elseif lvl >= 525 and lvl < 625 then
																					
																							positon_npc = CFrame.new(1809.37, 10.617, 3756.29)
																							positon_island = CFrame.new(1852.2, 11.015, 3603.9)
																							monname = "Candle Man [Lv. 525]"
																							dfmon = "Exp 75.07K"
																						   
	
																							elseif lvl >= 625 and lvl < 725 then
																						
																								positon_npc = CFrame.new(1478.36, 10.5669, 3620.42)
																								positon_island = CFrame.new(1852.2, 11.015, 3603.9)
																								monname = "Bomb Man [Lv. 625]"
																								dfmon = "Exp 89.37K"
																							  
	
																								elseif lvl >= 725 and lvl < 800 then
																							
																									positon_npc = CFrame.new(1573.67, 43.6353, 3687.43)
																									positon_island = CFrame.new(1852.2, 11.015, 3603.9)
																									monname = "King of Sand [Lv. 725]"
																									dfmon = "Exp 103.67K"
																								   
	
																									elseif lvl >= 800 and lvl < 850 then
																									
																										positon_npc = CFrame.new(-798.058777, 540.120483, 5268.14258)
																										positon_island = CFrame.new(231.853, 2702.01, 4779.07)
																										monname = "Sky Soldier [Lv. 800]"
																										dfmon = "Exp 114.4K"
																									   
	
																										elseif lvl >= 850 and lvl < 900 then
																									
																											positon_npc = CFrame.new(-823.31366, 544.841003, 4839.33643)
																											positon_island = CFrame.new(231.853, 2702.01, 4779.07)
																											monname = "Ball Man [Lv. 850]"
																											dfmon = "Exp 121.55K"
																										   
	
																											elseif lvl >= 900 and lvl < 1000 then
																											
																												positon_npc = CFrame.new(-900.407104, 544.831421, 5182.35059)
																												positon_island = CFrame.new(231.853, 2702.01, 4779.07)
																												monname = "Rumble Man [Lv. 900]"
																												dfmon = "Exp 128.69K"
																												
	
																												elseif lvl >= 1000 and lvl <= 1100 then
																											
																													positon_npc = CFrame.new(8300.96, 12.0145, 5612.27)
																													positon_island = CFrame.new(8173.73, 11.1977, 5677.74)
																													monname = "Soldier [Lv. 1000]"
																													dfmon = "Exp 143K"
																													
	
																													elseif lvl >= 1100 and lvl <= 1150 then
																												
																														positon_npc = CFrame.new(8169.99, 10.8235, 5522.18)
																														positon_island = CFrame.new(8173.73, 11.1977, 5677.74)
																														monname = "Leader [Lv. 1100]"
																														dfmon = "Exp 157.3K"
																														
	
																														elseif lvl >= 1150 and lvl < 1250 then
																														
																															positon_npc = CFrame.new(8255.37, 10.5516, 6102.26)
																															positon_island = CFrame.new(8173.73, 11.1977, 5677.74)
																															monname = "Pasta [Lv. 1150]"
																															dfmon = "Exp 164.45K"
																														   
	
																															elseif lvl >= 1250 and lvl < 1325 then
																															
																																positon_npc = CFrame.new(3684.67, 10.3509, 7102.08)
																																positon_island = CFrame.new(3818.83, 17.8524, 6403.13)
																																monname = "Wolf [Lv. 1250]"
																																dfmon = "Exp 178.75K"
																															   
	
																																elseif lvl >= 1325 and lvl < 1400 then
																															
																																	positon_npc = CFrame.new(4061.87, 10.3851, 6853.03)
																																	positon_island = CFrame.new(3818.83, 17.8524, 6403.13)
																																	monname = "Giraffe [Lv. 1325]"
																																	dfmon = "Exp 189.47K"
																																   
	
																																	elseif lvl >= 1400 and lvl < 1500 then
																																
																																		positon_npc = CFrame.new(3755.23, 10.3764, 7282.42)
																																		positon_island =  CFrame.new(3755.23, 10.3764, 7282.42)
																																		monname = "Leo [Lv. 1400]"
																																		dfmon = "Exp 200.2K"
																																	   
	
																																		elseif lvl >= 1500 and lvl < 1600 then
																																	
																																			positon_npc = CFrame.new(-777.934, 47.3934, 8476.07)
																																			positon_island = CFrame.new(-1085.42, 226.929, 8384.01)
																																			monname = "Zombie [Lv. 1500]"
																																			dfmon = "Exp 214.5K"
																																		   
	
																																			elseif lvl >= 1600 and lvl < 1750 then
																																		
																																				positon_npc = CFrame.new(-723.048, 83.183, 8358.15)
																																				positon_island = CFrame.new(-1085.42, 226.929, 8384.01)
																																				monname = "Shadow Master [Lv. 1600]"
																																				dfmon = "Exp 228.8K"
																																				
	
																																				elseif lvl >= 1750 and lvl < 1800 then
																																				
																																					positon_npc = CFrame.new(8416.14, 49.3627, 1087.94)
																																					positon_island = CFrame.new(8414.93, 51.0101, 1107.74)
																																					monname = "New World Pirate [Lv. 1750]"
																																					dfmon = "Exp 250.25K"
																																					
	
																																					elseif lvl >= 1800 and lvl < 1850 then
																																					positon_npc = CFrame.new(8549.26, 49.3028, 523.807)
																																						positon_island = CFrame.new(8414.93, 51.0101, 1107.74)
																																						monname = "Rear Admiral [Lv. 1800]"
																																						dfmon = "Exp 257.39K"
																																						
	
																																						elseif lvl >= 1850 and lvl < 1925 then
																																					
																																							positon_npc = CFrame.new(8069.6, 50.7477, 441.114)
																																							positon_island = CFrame.new(8414.93, 51.0101, 1107.74)
																																							monname = "True Karate Fishman [Lv. 1850]"
																																							dfmon = "Exp 264.55K"
	
																																						elseif lvl >= 1925 and lvl < 2000 then
																																					
																																							positon_npc = CFrame.new(7939.62, 49.531, 625.957)
																																							positon_island = CFrame.new(8414.93, 51.0101, 1107.74)
																																							monname = "Quake Woman [Lv. 1925]"
																																							dfmon = "Exp 275.27K"
																																						 
	
																																						elseif lvl >= 2000 and lvl < 2050 then
																																				
																																							positon_npc = CFrame.new(2973.27, 41.2809, 13350.1)
																																							positon_island = CFrame.new(2931.24561, 40.2974319, 13341.3916)
																																							monname = "Fishman [Lv. 2000]"
																																							dfmon = "Exp 286K"
																																						
	
																																						elseif lvl >= 2050 and lvl < 2100 then
																																						
																																							positon_npc = CFrame.new(2781.55, 41.2385, 13615.7)
																																							positon_island = CFrame.new(2931.24561, 40.2974319, 13341.3916)
																																							monname = "Combat Fishman [Lv. 2050]"
																																							dfmon = "Exp 293.14K"
																																						   
	
																																						elseif lvl >= 2100 and lvl < 2150 then
																																						
																																							positon_npc = CFrame.new(3294.55, 41.2377, 13794.5)
																																							positon_island = CFrame.new(2931.24561, 40.2974319, 13341.3916)
																																							monname = "Sword Fishman [Lv. 2100]"
																																							dfmon = "Exp 300.3K"
																																							
	
																																						elseif lvl >= 2150 and lvl < 2200 then
																																						
																																							positon_npc = CFrame.new(3020.31, 41.2462, 13886.7)
																																							positon_island = CFrame.new(2931.24561, 40.2974319, 13341.3916)
																																							monname = "Fishman Soldier [Lv. 2150]"
																																							dfmon = "Exp 306.8K"
																																							
	
																																						elseif lvl >= 2200  then
																																						
																																							positon_npc = CFrame.new(2785.57, 41.2428, 13822.6)
																																					   --     positon_island = CFrame.new(2931.24561, 40.2974319, 13341.3916)
																																							monname = "Seasoned Fishman [Lv. 2200]"
																																							dfmon = "Exp 314.6K"
																	 
	
																							   
	
	
	
	
	
																								   
	
					end 
	
				end
	
			end
		end
		
		function checklevel2()
			for i,v in pairs(LocalPlayer.PlayerStats:GetChildren()) do
				if v.Name == "lvl" then
					local 	lvl = v.value
				if lvl >= 2250 and lvl < 2300 then
					  
					positon_npc = CFrame.new(1355.75598, 75.3113251, -2125.26758)
					positon_island = CFrame.new(380.019226, 75.3614197, -2517.06372)
					monname = "Beast Pirate [Lv. 2250]"
					dfmon = "Exp 321.75K"
					elseif lvl >= 2300 and lvl < 2350 then
					   
						positon_npc = CFrame.new(171.650833, 75.3600922, -4821.69678)
						positon_island = CFrame.new(668.55304, 75.3620071, -5521.15332)
						monname = "Beast Pirate [Lv. 2300]"
						dfmon = "Exp 328.9K"
					elseif lvl >= 2350 and lvl < 2400 then
						  
							positon_npc = CFrame.new(114.04335, 75.3616562, -4692.52734)
							positon_island = CFrame.new(-160.065582, 75.3613586, -5296.27637)
							monname = "Snake Man [Lv. 2350]"
							dfmon = "Exp 336.05K"
						elseif lvl >= 2400 and lvl < 2450 then
					  
							positon_npc = CFrame.new(-2123.74463, 75.3615112, -4905.64551)
							positon_island = CFrame.new(-1943.97339, 75.4127502, -4823.91455)
							monname = "Bandit Beast Pirate [Lv. 2400]"
							dfmon = "Exp 343.2K"
						elseif lvl >= 2450 and lvl < 2500 then
					   
							positon_npc = CFrame.new(-2754.89453, 75.3720627, -5292.63672)
							positon_island = CFrame.new(-2746.59204, 75.4125977, -5575.7832)
							monname = "Powerful Beast Pirate [Lv. 2450]"
							dfmon = "Exp 350.35K"
						elseif lvl >= 2500 and lvl < 2550 then
						   
							positon_npc = CFrame.new(-3020.65527, 75.3616638, -4928.26465)
							positon_island = CFrame.new(-3358.5127, 75.4119568, -5084.94629)
							monname = "Violet Samurai [Lv. 2500]"
							dfmon = "Exp 357.5K"
						elseif lvl >= 2550 and lvl < 2600 then
						
							positon_npc = CFrame.new(-950.084167, 75.3615112, -1812.16357)
							positon_island = CFrame.new(-1233.93835, 75.3613586, -2156.09863)
							monname = "Rabbit Man [Lv. 2550]"
							dfmon = "Exp 364.65K"
						elseif lvl >= 2600 and lvl < 2650 then
						 
							positon_npc = CFrame.new(-2481.13818, 75.5030518, -1533.70093)
							positon_island = CFrame.new(-2481.13818, 75.5030518, -1533.70093)
							monname = "Bat Man [Lv. 2600]"
							dfmon = "Exp 371.8K"
						elseif lvl >= 2650 and lvl < 2700 then
						 
							positon_npc = CFrame.new(-2826.58105, 75.5312729, -1261.92773)
							positon_island = CFrame.new(-3198.95972, 75.3694153, -1485.84583)
							monname = "Kitsune Samurai [Lv. 2650]"
							dfmon = "Exp 378.95K"
						elseif lvl >= 2700 and lvl < 2750 then
					 
							positon_npc = CFrame.new(0.522339582, 75.3689575, 268.757629)
							positon_island = CFrame.new(349.632355, 75.3689575, 531.271973)
							monname = "Elite Beast Pirate [Lv. 2700]"
							dfmon = "Exp 386.1K"
						elseif lvl >= 2750 and lvl < 2800 then
					 
							positon_npc = CFrame.new(394.579468, 106.564766, -257.578766)
							positon_island = CFrame.new(348.942719, 75.3689575, -15.4442644)
							monname = "Elite Beast Pirate [Lv. 2750]"
							dfmon = "Exp 393.25K"
						elseif lvl >= 2800 and lvl < 2850 then
					  
							positon_npc = CFrame.new(773.021851, 75.8552704, 528.129883)
							positon_island = CFrame.new(846.642578, 75.3689575, 167.41568)
							monname = "Bear Man [Lv. 2800]"
							dfmon = "Exp 400.4K"
						elseif lvl >= 2850 and lvl < 2900 then
						 
							positon_npc = CFrame.new(-2634.29028, 75.3723145, 1130.99622)
							positon_island = CFrame.new(-3315.2063, 75.4277954, 1092.38184)
							monname = "Magician [Lv. 2850]"
							dfmon = "Exp 407.55K"
						elseif lvl >= 2900 and lvl < 2950 then
					 
							positon_npc = CFrame.new(-4675.52002, 75.3739853, 2111.34985)
							positon_island = CFrame.new(-5011.47803, 75.4294434, 1676.17847)
							monname = "Pachy Woman [Lv. 2900]"
							dfmon = "Exp 414.7K"
							
						elseif lvl >= 2950 and lvl < 3000 then
						  
							positon_npc = CFrame.new(-1428.98584, 74.7768402, 4110.82275)
							positon_island = CFrame.new(-929.036926, 74.7368317, 4239.02197)
							monname = "Kappa [Lv. 2950]"
							dfmon = "Exp 421.85K"

						elseif lvl >= 3000  and lvl < 3025  then  
							positon_npc = CFrame.new(-4279.48779, 74.7265396, 4559.93066)
							positon_island = CFrame.new(-4682.72266, 74.7820282, 4630.65381)
							monname = "Mammoth Man [Lv. 3000]"
							dfmon = "Exp 429K"
						elseif lvl >= 3025 and lvl < 3075 then 
							positon_npc = CFrame.new(-3816.5459, 56.498436, 9891.29688)
							positon_island = CFrame.new(-3816.5459, 56.498436, 9891.29688)
							monname = "Skull Pirate [Lv. 3050]"
							dfmon = "Exp 436.15K"
						elseif lvl > 3075  then
							positon_npc  = CFrame.new(-3031.73584, 56.0529976, 9854.94824)
							positon_island  = CFrame.new(-3031.73584, 56.0529976, 9854.94824)
							monname = "Elite Skeleton [Lv. 3100]"
							dfmon = "Exp 443.3K"
					end 
	
				end
	
			end
		end
				--[[
	
			for i3,v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do 
						if string.find(v3.Name, "Decline") then
							v3.BackgroundTransparency = 1
							end
					end
					for i4,v4 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do 
						if string.find(v4.Name, "TextFrame") then
							v4.BackgroundTransparency = 1
							end
					end
					for i3,v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do 
						if string.find(v3.Name, "Decline") then
							v3.BackgroundTransparency = 1
							end
					end
					for i4,v4 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do 
						if string.find(v4.Name, "Dialogue") then
							v4.Position = UDim2.new(0, -999999999 ,0, -99999999999)
							end
					end
					for i5,v5 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do 
						if string.find(v5.Name, "LevelRequire") then
							v5.BackgroundTransparency = 1
							end
					end
	
	
				]]
	
	-- Auto Farm 
	function autofarm()
	   
		if  game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == false then 
			checklevel()
			LocalPlayer.Character.HumanoidRootPart.CFrame = positon_npc
		vs:CaptureController()
		vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
		wait(1.7)
		for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
			if string.find(v2.Name, "Accept") then
				v2.Position = UDim2.new(0, -5000 ,0, -5000)
				v2.Size = UDim2.new(2000, 2000, 2000, 2000)
				v2.BackgroundTransparency = 1
				Click()
				end
			end
	elseif   game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible  == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text ~= dfmon   then 
		checklevel()
		LocalPlayer.Character.HumanoidRootPart.CFrame = positon_npc
				vs:CaptureController()
				vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
						wait(1.7)
		for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
			if string.find(v2.Name, "Accept") then
					v2.Position = UDim2.new(0, -5000 ,0, -5000)
						v2.Size = UDim2.new(2000, 2000, 2000, 2000)
							v2.BackgroundTransparency = 1
								Click()
						end
					end
		elseif game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text == dfmon   then 
			
	--[[
			elseif game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text == dfmon   then 
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = positon_island
	]]
					for i,v in pairs(game:GetService("Workspace").Monster:GetDescendants()) do 
							if	v.Name ==  monname 	and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then  
									repeat  wait()
										LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0, _G.distantss)
										equip()
										vs:CaptureController()
										vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
									if ( LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position ).magnitude <= 3 then 
								--		if _G.Enabelskill then 
											if _G.Z then 
												game:GetService("Players").LocalPlayer.Character[wapons].Z:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)		
											if _G.X then 
												game:GetService("Players").LocalPlayer.Character[wapons].X:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
											if _G.C then 
												game:GetService("Players").LocalPlayer.Character[wapons].C:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
											if _G.V then 
												game:GetService("Players").LocalPlayer.Character[wapons].V:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
											if _G.E then 
												game:GetService("Players").LocalPlayer.Character[wapons].E:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
															end
														end
													end				
												end
											end
										end	
									
									until v.Humanoid.Health == 0 or f.autofarm== false or  game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == false 
							end
						end
					end
			 
			end
	
	-- 2 world 
	function autofarm2()
	   
		if  game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == false then 
			checklevel2()
			LocalPlayer.Character.HumanoidRootPart.CFrame =  positon_npc
		vs:CaptureController()
		vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
		wait(1.7)
		for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
			if string.find(v2.Name, "Accept") then
				v2.Position = UDim2.new(0, -5000 ,0, -5000)
				v2.Size = UDim2.new(2000, 2000, 2000, 2000)
				v2.BackgroundTransparency = 1
				Click()
				end
			end
	elseif   game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible  == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text ~= dfmon   then 
		checklevel2()
		LocalPlayer.Character.HumanoidRootPart.CFrame =  positon_npc
				vs:CaptureController()
				vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
						wait(1.7)
		for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
			if string.find(v2.Name, "Accept") then
					v2.Position = UDim2.new(0, -5000 ,0, -5000)
						v2.Size = UDim2.new(2000, 2000, 2000, 2000)
							v2.BackgroundTransparency = 1
								Click()
						end
					end
			elseif game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text == dfmon   then 
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = positon_island
			
					for i,v in pairs(game:GetService("Workspace").Monster:GetDescendants()) do 
							if	v.Name ==  monname 	and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then  
									repeat  wait()
										LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0, _G.distantss)
										equip()
										vs:CaptureController()
										vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
									if ( LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position ).magnitude <= 5 then 
									--	if _G.Enabelskill then 
											if _G.Z == true then 
												game:GetService("Players").LocalPlayer.Character[wapons].Z:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)		
											if _G.X == true then 
												game:GetService("Players").LocalPlayer.Character[wapons].X:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
											if _G.C == true then 
												game:GetService("Players").LocalPlayer.Character[wapons].C:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
											if _G.V == true then 
												game:GetService("Players").LocalPlayer.Character[wapons].V:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
											if _G.E == true then 
												game:GetService("Players").LocalPlayer.Character[wapons].E:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
															end
														end
													end				
												end
											end
										end	
									
									until v.Humanoid.Health == 0 or f.autofarm== false or  game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == false 
							end
						end
					end
			 
			end
	
	function farmdragon()
		pcall(function()
			if  game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("DragonGem") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("DragonGem") then 
			  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3392.06885, 51.4613953, 11660.8857)
				else
						   for i,v in pairs(game:GetService("Workspace").Monster:GetDescendants()) do 
							   if v.Name == "Dragon [Lv. 5000]" then 
								   repeat wait()
									LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0, _G.distantss)
									equip()
									vs:CaptureController()
									vs:ClickButton1(Vector2.new(0, 0), game:GetService("Workspace").Camera.CFrame)
								if ( LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position ).magnitude <= 5 then 
								--	if _G.Enabelskill then 
										if _G.Z == true then 
											game:GetService("Players").LocalPlayer.Character[wapons].Z:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)		
										if _G.X == true then 
											game:GetService("Players").LocalPlayer.Character[wapons].X:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
										if _G.C == true then 
											game:GetService("Players").LocalPlayer.Character[wapons].C:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
										if _G.V == true then 
											game:GetService("Players").LocalPlayer.Character[wapons].V:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
										if _G.E == true then 
											game:GetService("Players").LocalPlayer.Character[wapons].E:InvokeServer(v.HumanoidRootPart.CFrame, v.HumanoidRootPart.CFrame)
														end
													end
												end				
											end
										end
									end	
								  until v.Humanoid.Heath == 0 or not f.Dragon 
						end
					end
				end
			end)
	end

			--[[
	
	  
		function newworld()
			checklevel()
			if game:GetService("Players").LocalPlayer.PlayerStats.lvl.Value >= 2250  then 
				f.autofarm = false 
				if  game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == false then 
					checklevel()
						Click()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = positon_npc
							Click()
									wait(1)
							for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
									if string.find(v2.Name, "Accept") then
										v2.Position = UDim2.new(0, -5000 ,0, -5000)
										v2.Size = UDim2.new(2000, 2000, 2000, 2000)
										v2.BackgroundTransparency = 1
										Click()
									end
								end
				elseif   game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible  == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text ~= dfmon   then 
				checklevel()
					Click()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = positon_npc
							Click()
								wait(1)
				for i2,v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
					if string.find(v2.Name, "Accept") then
							v2.Position = UDim2.new(0, -5000 ,0, -5000)
								v2.Size = UDim2.new(2000, 2000, 2000, 2000)
									v2.BackgroundTransparency = 1
										Click()
								end
							end
						elseif game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.Quest.QuestBoard.exp.Text == dfmon   then 
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = positon_island
			
					end
				end
			end
	
			]]
	
			-- Map 
			--[[
	
	if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Map")  then 
					print("Map")
						for i2 , v2 in pairs(game:GetService("Workspace").AntiTPNPC:GetChildren()) do
							if v2.Name == "Elite Pirate" and v2:FindFirstChild("HumanoidRootPart") then 
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame  = v2.HumanoidRootPart.CFrame
								wait(1)
							game:GetService("ReplicatedStorage").Remotes.Functions.CheckQuest:InvokeServer( workspace.AntiTPNPC["Elite Pirate"])
								wait(1)
								for i3,v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
									if string.find(v3.Name, "Accept") then
										v3.Position = UDim2.new(0, -5000 ,0, -5000)
										v3.Size = UDim2.new(2000, 2000, 2000, 2000)
										v3.BackgroundTransparency = 1
										Click()
	
											
													end
												end
											end
										end
									end
	
			]]
	-- noclip 
	function noclip() LocalPlayer.Character.Humanoid:ChangeState(11) end
	
	
	
	-- auto buso 
	function autobuso()
		for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v.Name == "Haki" and v.Value == 0 then
					game:GetService("Players").LocalPlayer.Character.Services.Client.BusoEvent:FireServer()
					end   
				end
			end
		
	
	--auto ken 
	function ken()
		for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v.Name == "KenHaki" and v.Value == 0 then
		game:GetService("Players").LocalPlayer.Character.Services.Client.KenEvent:InvokeServer(false)
		game:GetService("Players").LocalPlayer.Character.Services.Client.KenEvent:InvokeServer(true)

			end
		end
	end
	
	
	
	
	--NoClip
	game:GetService('RunService').Stepped:connect(function()
	if f.autofarm  then
		pcall(function()
			game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
		end)
	end
	end)
	
	spawn(function()
	while  wait(0.75) do
		if f.Buso then 
			pcall(function()
				autobuso()
			end)
		end
	end
	end)
	spawn(function()
	while  wait() do
		if f.ken then 
			pcall(function()
				ken()
			end)
		end
	end
	end)
	spawn(function()
	while  wait() do
		if f.GodMode then 
			pcall(function()
				local e = LocalPlayer.Character.KenHaki:Clone()
					LocalPlayer.Character.KenHaki:Destroy() 	
					e.Parent = LocalPlayer.Character
				end)
			end
		end
	end)
	
	spawn(function()
		while  wait() do
	pcall(function()
		    if _G.Melee then 
            LocalPlayer.PlayerGui.Stats.Button.StatsFrame.Melee.RemoteEvent:FireServer(1)
            elseif  _G.Defense  then		
                LocalPlayer.PlayerGui.Stats.Button.StatsFrame.Defense.RemoteEvent:FireServer(1)
			elseif  _G.Sword  then
                LocalPlayer.PlayerGui.Stats.Button.StatsFrame.Sword.RemoteEvent:FireServer(1)
			elseif  _G.Fruits  then
                LocalPlayer.PlayerGui.Stats.Button.StatsFrame:FindFirstChild("Devil Fruit").RemoteEvent:FireServer(1)

                end
			end)
		end
	end)
end


function BloxFruits()
    

local mt = getrawmetatable(game)
local old = mt.__namecall

setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
if getnamecallmethod() == "Kick" then
    return nil 
end
return old(self, ...)
end)
-- varable 
local plr  = game.Players.LocalPlayer 
local LocalPlayer = game.Players.LocalPlayer
local getweapon = {}
local getboss = {}
local getplayers = {}
local oldworlds = 2753915549
local newworlds = 4442272183
local get 
--Get Table 
for i , v in pairs(plr.Backpack:GetChildren()) do 
    if v:IsA("Tool") then
        table.insert( getweapon, v.Name )
    end
end
for i , v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do 
    if string.find(v.Name,"Boss") then
        table.insert( getboss, v.Name)
    end
end
for i , v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
    if string.find(v.Name,"Boss") then
        table.insert( getboss, v.Name)
    end
end
for i , v in pairs(game:GetService("Players"):GetPlayers()) do 
    if v.Name ~= plr.Name then
        table.insert( getplayers, v.Name )
    end
end
-- OOP
local setting = {
    selectweapons = nil ;
    autofarm = false ; 
    Newworld = false ; 
    mobaura = false ; 
    Buso  = false ; 
    Observation  = false ; 
    Mastery = false ; 
    GunFarm = false ; 
    Super = false ; 
    z = false ; 
    x = false ; 
    c = false ; 
    v = false  ;
    Melee = false ; 
    Defense = false ; 
    Gun = false ; 
    Sword = false ; 
    Fruit = false ;
    Noclip = false ;
    Dash = false ; 
    Inf = false ;
    Race = nil ; 
    Walk = false ; 
    chestesp = false ; 
    Devilesp = false ;
    Playeresp = false ;
    TpPlayers = false ; 
    selectplayer= false ;
    equip = true ;
    EctoPlasm = false ; 
    Rengoku = false ;
    factory = false ;
    Raid = false ;
    KillAll = false ; 
    Distance = 20 ; 
    HitBox = 40 ; 
    HideBox = false , 1 ; 
    Color  = false ; 
    shop = nil ;
    Legendary = false ; 
    flower = false ; 
    Chest = false ; 
    df = false ;
    Distance2 = 20 ; 
    HitBox2 = 40 ; 
    HideBox2 = false ; 
    buyhaki  = false ; 
    ClickPlayer = false  ;
    
}
-- OOP 
local settingboss = {
    selectboss = nil ; 
    BossFarm = false ;
}

--Set Value 
local function setvalue()
    for i , v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
        if v:FindFirstChild("OriginalSize") then
            v.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
        end
    end   
end
-- Tp 
local function tp(pos)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end

local function click()
        game:GetService"VirtualUser":CaptureController()
        game:GetService"VirtualUser":Button1Down(Vector2.new(1.28e3, 672))
end
--inf 
local originalstam = LocalPlayer.Character.Energy.Value

local function equip()
    if setting.equip then
        pcall(function()
    local tool = LocalPlayer:WaitForChild"Backpack":FindFirstChild(setting.selectweapons)
			wait()
		LocalPlayer.Character.Humanoid:EquipTool(tool)
        wait()
        end)
    end
end

--Dash 
local function NoDodgeCool()
		for i, v in next, getgc() do
			if game.Players.LocalPlayer.Character.Dodge then
				if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Dodge then
					for i2, v2 in next, getupvalues(v) do
						if tostring(v2) == "0.4" then
                            repeat wait()
								setupvalue(v, i2, 0)
							until not setting.Dash
					end
				end
			end
		end
	end
end

local function bosst()
    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    sethiddenproperty(l,"Technology",2)
    sethiddenproperty(t,"Decoration",false)
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end


--noclip 
local function noclip()
game:GetService('RunService').Stepped:connect(function()
    if setting.Noclip  then
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end)
    end
end)
end

local function SuperHuman()
        pcall(function()
            repeat wait()
                setting.equip = false 
            until game:IsLoaded() or not setting.Super
        
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Combat" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                            game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                        )
                        game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyBlackLeg", true)
                        game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyBlackLeg")
                    elseif v.Name == "Black Leg" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                            game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                        )
                        if v.Level.Value > 299 then
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyFishmanKarate", true)
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyFishmanKarate")
                        end
                    elseif v.Name == "Fishman Karate" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                            game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                        )
                        if v.Level.Value > 299 then
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyElectro", true)
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyElectro")
                        end
                    elseif v.Name == "Electro" then 
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                            game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                        )
                        if v.Level.Value > 299 then
                            if game:GetService("Players").LocalPlayer.Data.Fragments.Value >= 1500 then
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                            else
                                local args = {
                                    [1] = "Candies",
                                    [2] = "Buy",
                                    [3] = 2,
                                    [4] = 2
                                }
            
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        end
                    elseif v.Name == "Dragon Claw" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                            game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                        )
                        if v.Level.Value > 299 then
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuySuperhuman", true)
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuySuperhuman")
                        end
                    elseif v.Name == "Superhuman" then
                        if v.Level.Value < 330 then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                            )
                        else
                            if v.Level.Value > 329 and game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Saddi") then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                    game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Saddi")
                                )
                            elseif v.Level.Value > 329 and game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Wando") then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                    game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Wando")
                                )
                            elseif
                                v.Level.Value > 329 and game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Shisui")
                             then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                    game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Shisui")
                                )
                            elseif
                                v.Level.Value > 329 and game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Rengoku")
                             then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                    game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Rengoku")
                                )
                            end
                        end
                    end
                end
            
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") then
                        if v.Name == "Combat" then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                            )
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyBlackLeg", true)
                            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyBlackLeg")
                        elseif v.Name == "Black Leg" then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                            )
                            if v.Level.Value > 299 then
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyFishmanKarate", true)
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyFishmanKarate")
                            end
                        elseif v.Name == "Fishman Karate" then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                            )
                            if v.Level.Value > 299 then
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyElectro", true)
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuyElectro")
                            end
                        elseif v.Name == "Electro" then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                            )
                            if v.Level.Value > 299 then
                                if game:GetService("Players").LocalPlayer.Data.Fragments.Value >= 1500 then
                                    game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                                    game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                                else
                                    local args = {
                                        [1] = "Candies",
                                        [2] = "Buy",
                                        [3] = 2,
                                        [4] = 2
                                    }
            
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                end
                            end
                        elseif v.Name == "Dragon Claw" then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                            )
                            if v.Level.Value > 299 then
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuySuperhuman", true)
                                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("BuySuperhuman")
                            end
                        elseif v.Name == "Superhuman" then
                            if v.Level.Value < 330 then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                    game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild(tostring(v.Name))
                                )
                            else
                                if v.Level.Value > 329 and game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Saddi") then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                        game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Saddi")
                                    )
                                elseif
                                    v.Level.Value > 329 and
                                        game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Wando")
                                 then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                        game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Wando")
                                    )
                                elseif
                                    v.Level.Value > 329 and
                                        game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Shisui")
                                 then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                        game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Shisui")
                                    )
                                elseif
                                    v.Level.Value > 329 and
                                        game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Rengoku")
                                 then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                        game.Players.LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Rengoku")
                                    )
                                end
                            end
                        end
                    end
                end
                    
    end)
end
-- check Level
local function check()
if LocalPlayer.Data.Level.Value >= 1 and LocalPlayer.Data.Level.Value < 10 then
    _G.mobs = "Bandit [Lv. 5]"
    _G.quests = "BanditQuest1"
    _G.number = 1
    _G.CFrames = CFrame.new(1.06014978e3, 16.3627415, 1.54901746e3)
    _G.CFrames2 = CFrame.new(1.06014978e3, 16.3627415, 1.54901746e3)
    _G.TextQuest  =  [[Reward:
$350
250 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 10 and LocalPlayer.Data.Level.Value < 15 then
    _G.mobs = "Monkey [Lv. 14]"
    _G.quests = "JungleQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(-1.60033948e3, 36.8521385, 154.441147)
    _G.CFrames2 = CFrame.new(-1.60033948e3, 36.8521385, 154.441147)
    _G.TextQuest  =  [[Reward:
$800
1,800 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 15 and LocalPlayer.Data.Level.Value < 30 then
    _G.mobs = "Gorilla [Lv. 20]"
    _G.quests = "JungleQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(-1.60033948e3, 36.8521385, 154.441147)
    _G.CFrames2 = CFrame.new(-1.19886169e3, 7.72019768, -448.769073)
    _G.TextQuest  =  [[Reward:
$1,200
3,500 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 30 and LocalPlayer.Data.Level.Value < 40 then
    _G.mobs = "Pirate [Lv. 35]"
    _G.quests = "BuggyQuest1"
    _G.number = 1
    _G.CFrames = CFrame.new(-1.13908765e3, 4.75205183, 3.82917944e3)
    _G.CFrames2 = CFrame.new(-1.20318994e3, 4.75205088, 3.92060791e3)
    _G.TextQuest  =  [[Reward:
$3,000
10,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 40 and LocalPlayer.Data.Level.Value < 60 then
    _G.mobs = "Brute [Lv. 45]"
    _G.quests = "BuggyQuest1"
    _G.number = 2
    _G.CFrames = CFrame.new(-1.13908765e3, 4.75205183, 3.82917944e3)
    _G.CFrames2 = CFrame.new(-1.13908765e3, 4.75205183, 3.82917944e3)
    _G.TextQuest  =  [[Reward:
$3,500
18,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 60 and LocalPlayer.Data.Level.Value < 75 then
    _G.mobs = "Desert Bandit [Lv. 60]"
    _G.quests = "DesertQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(896.537903, 6.43846416, 4.39149805e3)
    _G.CFrames2 = CFrame.new(896.537903, 6.43846416, 4.39149805e3)
    _G.TextQuest = [[Reward:
$4,000
35,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 75 and LocalPlayer.Data.Level.Value < 90 then
    _G.mobs = "Desert Officer [Lv. 70]"
    _G.quests = "DesertQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(896.537903, 6.43846416, 4.39149805e3)
    _G.CFrames2 = CFrame.new(1554.25818, 14.5773706, 4371.47461)
    _G.TextQuest  =  [[Reward:
$4,500
50,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 90 and LocalPlayer.Data.Level.Value < 100 then
    _G.mobs = "Snow Bandit [Lv. 90]"
    _G.quests = "SnowQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(1.38792114e3, 87.272789, -1.29902271e3)
    _G.CFrames2 = CFrame.new(1.38792114e3, 87.272789, -1.29902271e3)
    _G.TextQuest  =  [[Reward:
$5,000
70,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 100 and LocalPlayer.Data.Level.Value < 120 then
    _G.mobs = "Snowman [Lv. 100]"
    _G.quests = "SnowQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(1.38830383e3, 87.272789, -1.29802197e3)
    _G.CFrames2 = CFrame.new(1.38830383e3, 87.272789, -1.29802197e3)
    _G.TextQuest = [[Reward:
$5,500
120,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 120 and LocalPlayer.Data.Level.Value < 150 then
    _G.mobs = "Chief Petty Officer [Lv. 120]"
    _G.quests = "MarineQuest2"
    _G.number = 1
    _G.CFrames = CFrame.new(-5.03755664e3, 28.6520386, 4.3252334e3)
    _G.CFrames2 = CFrame.new(-5.03755664e3, 28.6520386, 4.3252334e3)
    _G.TextQuest  =  [[Reward:
$6,000
180,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 150 and LocalPlayer.Data.Level.Value < 175 then
    _G.mobs = "Sky Bandit [Lv. 150]"
    _G.quests = "SkyQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(-4.84038623e3, 717.669556, -2.62047339e3)
    _G.CFrames2 = CFrame.new(-4.84038623e3, 717.669556, -2.62047339e3)
    _G.TextQuest  =  [[Reward:
$7,000
250,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 175 and LocalPlayer.Data.Level.Value < 225 then
    _G.mobs = "Dark Master [Lv. 175]"
    _G.quests = "SkyQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(-4.84038623e3, 717.669556, -2.62047339e3)
    _G.CFrames2 = CFrame.new(-5234.87695, 388.777374, -2252.17627)
    _G.TextQuest  =  [[Reward:
$7,500
350,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 225 and LocalPlayer.Data.Level.Value < 275 then
    _G.mobs = "Toga Warrior [Lv. 225]"
    _G.quests = "ColosseumQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(-1.57867053e3, 7.38933945, -2.98601147e3)
    _G.CFrames2 = CFrame.new(-1917.01782, 7.63233376, -2786.5769)
    _G.TextQuest  =  [[Reward:
$7,000
700,000 Exp.]]
    
elseif LocalPlayer.Data.Level.Value >= 275 and LocalPlayer.Data.Level.Value < 300 then
    _G.mobs = "Gladiator [Lv. 275]"
    _G.quests = "ColosseumQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(-1.57867053e3, 7.38933945, -2.98601147e3)
    _G.CFrames2 = CFrame.new(-1352.78735, 7.78580666, -3253.1687)
    _G.TextQuest  =  [[Reward:
$7,500
1,000,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 300 and LocalPlayer.Data.Level.Value < 330 then
    _G.mobs = "Military Soldier [Lv. 300]"
    _G.quests = "MagmaQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(-5.31524072e3, 12.2367964, 8.5163584e3)
    _G.CFrames2 = CFrame.new(-5470.58447, 8.59067631, 8387.4082)
    _G.TextQuest  =  [[Reward:
$8,250
1,300,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 330 and LocalPlayer.Data.Level.Value < 375 then
    _G.mobs = "Military Spy [Lv. 330]"
    _G.quests = "MagmaQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(-5.31524072e3, 12.2367964, 8.5163584e3)
    _G.CFrames2 = CFrame.new(-5470.58447, 8.59067631, 8387.4082)
    _G.TextQuest  =  [[Reward:
$8,500
1,850,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 375 and LocalPlayer.Data.Level.Value < 400 then
    _G.mobs = "Fishman Warrior [Lv. 375]"
    _G.quests = "FishmanQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(6.11216563e4, 18.4716396, 1.56745764e3)
    _G.CFrames2 = CFrame.new(6.11216563e4, 18.4716396, 1.56745764e3)
    _G.TextQuest  =  [[Reward:
$8,750
2,500,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 400 and LocalPlayer.Data.Level.Value < 450 then
    _G.mobs = "Fishman Commando [Lv. 400]"
    _G.quests = "FishmanQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(6.11216563e4, 18.4716396, 1.56745764e3)
    _G.CFrames2 = CFrame.new(6.11216563e4, 18.4716396, 1.56745764e3)
    _G.TextQuest  =  [[Reward:
$9,000
3,000,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 450 and LocalPlayer.Data.Level.Value < 475 then
    _G.mobs = "God's Guard [Lv. 450]"
    _G.quests = "SkyExp1Quest"
    _G.number = 1
    _G.CFrames = CFrame.new(-4.72214258e3, 845.277161, -1.95168347e3)
    _G.CFrames2 = CFrame.new(-4.72214258e3, 845.277161, -1.95168347e3)
    _G.TextQuest  =  [[Reward:
$8,750
3,800,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 475 and LocalPlayer.Data.Level.Value < 525 then
    _G.mobs = "Shanda [Lv. 475]"
    _G.quests = "SkyExp1Quest"
    _G.number = 2
    _G.CFrames = CFrame.new(-7.860271e3, 5.54549316e3, -380.006348)
    _G.CFrames2 =  CFrame.new(-7.860271e3, 5.54549316e3, -380.006348)
    _G.TextQuest  = [[Reward:
$9,000
4,300,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 525 and LocalPlayer.Data.Level.Value < 550 then
    _G.mobs = "Royal Squad [Lv. 525]"
    _G.quests = "SkyExp2Quest" 
    _G.number = 1
    _G.CFrames = CFrame.new(-7.90521094e3, 5.63596387e3, -1.4119386e3)
    _G.CFrames2 =  CFrame.new(-7.90521094e3, 5.63596387e3, -1.4119386e3)
    _G.TextQuest  =  [[Reward:
$9,500
4,600,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 550 and LocalPlayer.Data.Level.Value < 625 then
    _G.mobs = "Royal Soldier [Lv. 550]"
    _G.quests = "SkyExp2Quest"
    _G.number = 2
    _G.CFrames = CFrame.new(-7.90521094e3, 5.63596387e3, -1.4119386e3)
    _G.CFrames2 =  CFrame.new(-7.90521094e3, 5.63596387e3, -1.4119386e3)
    _G.TextQuest  = [[Reward:
$9,750
5,000,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 625 and LocalPlayer.Data.Level.Value < 650 then
    _G.mobs = "Galley Pirate [Lv. 625]"
    _G.quests = "FountainQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(5.25814258e3, 38.5011406, 4.05052905e3)
    _G.CFrames2 =  CFrame.new(5.25814258e3, 38.5011406, 4.05052905e3)
    _G.TextQuest  =   [[Reward:
$10,000
5,800,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 650 and LocalPlayer.Data.Level.Value < 700 then
    _G.mobs = "Galley Captain [Lv. 650]"
    _G.quests = "FountainQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(5.25814258e3, 38.5011406, 4.05052905e3)
    _G.CFrames2 =  CFrame.new(6.06417139e3, 38.5011406, 4.773271e3)
    _G.TextQuest  =  [[Reward:
$10,000
6,300,000 Exp.]]      

elseif LocalPlayer.Data.Level.Value >= 700 and LocalPlayer.Data.Level.Value < 725 then
    
     _G.mobs = "Raider [Lv. 700]"
     _G.quests = "Area1Quest"
     _G.number = 1
     _G.CFrames = CFrame.new(-427.970856, 72.9705429, 1.83693616e3)
     _G.CFrames2 =  CFrame.new(-266.674194, 39.4630127, 2392.21802)
     _G.TextQuest  =  [[Reward:
$10,250
6,750,000 Exp.]]       

elseif LocalPlayer.Data.Level.Value >= 725 and LocalPlayer.Data.Level.Value < 775 then

    _G.mobs = "Mercenary [Lv. 725]"
    _G.quests = "Area1Quest"
    _G.number = 2
    _G.CFrames = CFrame.new(-429.543518, 71.7699966, 1836.18188)
    _G.CFrames2 =  CFrame.new(-1096.73694, 79.8822098, 1153.51636)
    _G.TextQuest  =  [[Reward:
$10,500
7,000,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 775 and LocalPlayer.Data.Level.Value < 800 then
    
    _G.mobs = "Swan Pirate [Lv. 775]"
    _G.quests = "Area2Quest"
    _G.number = 1
    _G.CFrames = CFrame.new(637.798523, 78.0720291, 918.235291)
    _G.CFrames2 =  CFrame.new(867.75415, 121.582191, 1239.41675)
    _G.TextQuest  =  [[Reward:
$10,750
7,500,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 800 and LocalPlayer.Data.Level.Value < 875 then

    _G.mobs = "Factory Staff [Lv. 800]"
    _G.quests = "Area2Quest"
    _G.number = 2
    _G.CFrames = CFrame.new(637.798523, 78.0720291, 918.235291)
    _G.CFrames2 =   CFrame.new(170.191833, 73.0685425, -177.433014)
    _G.TextQuest  =  [[Reward:
$11,000
8,250,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 875 and LocalPlayer.Data.Level.Value < 900 then
    
    _G.mobs = "Marine Lieutenant [Lv. 875]"
    _G.quests = "MarineQuest3"
    _G.number = 1
    _G.CFrames = CFrame.new(-2.44188135e3, 73.0161057, -3.21721118e3)
    _G.CFrames2 =  CFrame.new(-2.44188135e3, 73.0161057, -3.21721118e3)
    _G.TextQuest  =  [[Reward:
$11,250
9,000,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 900 and LocalPlayer.Data.Level.Value < 950 then
    
    _G.mobs = "Marine Captain [Lv. 900]"
    _G.quests = "MarineQuest3"
    _G.number = 2
    _G.CFrames = CFrame.new(-2.44188135e3, 73.0161057, -3.21721118e3)
    _G.CFrames2 =  CFrame.new(-2.44188135e3, 73.0161057, -3.21721118e3)
    _G.TextQuest  =  [[Reward:
$11,500
10,500,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 950 and LocalPlayer.Data.Level.Value < 975 then

    _G.mobs = "Zombie [Lv. 950]"
    _G.quests = "ZombieQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(-5.49496582e3, 48.4801292, -794.118958)
    _G.CFrames2 =  CFrame.new(-5.49496582e3, 48.4801292, -794.118958)
    _G.TextQuest  =  [[Reward:
$11,750
11,000,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 975 and LocalPlayer.Data.Level.Value < 1e3 then

    _G.mobs = "Vampire [Lv. 975]"
    _G.quests = "ZombieQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(-5.49496582e3, 48.4801292, -794.118958)
    _G.CFrames2 =   CFrame.new(-6046.26709, 6.40270138, -1334.14502)
    _G.TextQuest  =  [[Reward:
$12,000
12,000,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1e3 and LocalPlayer.Data.Level.Value < 1.05e3 then

    _G.mobs = "Snow Trooper [Lv. 1000]"
    _G.quests = "SnowMountainQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(608.807007, 401.426544, -5.37181055e3)
    _G.CFrames2 =   CFrame.new(608.807007, 401.426544, -5.37181055e3)
    _G.TextQuest  = [[Reward:
$12,250
13,000,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 1.05e3 and LocalPlayer.Data.Level.Value < 1.1e3 then
    _G.mobs = "Winter Warrior [Lv. 1050]"
    _G.quests = "SnowMountainQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(608.807007, 401.426544, -5.37181055e3)
    _G.CFrames2 =  CFrame.new(608.807007, 401.426544, -5.37181055e3)
    _G.TextQuest  =  [[Reward:
$12,500
14,200,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1.1e3 and LocalPlayer.Data.Level.Value < 1125 then
    
    _G.mobs = "Lab Subordinate [Lv. 1100]"
    _G.quests = "IceSideQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(-6.06274072e3, 15.9517622, -4.90399512e3)
    _G.CFrames2 = CFrame.new(-6.06274072e3, 15.9517622, -4.90399512e3)
    _G.TextQuest  =  [[Reward:
$12,250
15,500,000 Exp.]]


elseif LocalPlayer.Data.Level.Value >= 1125 and LocalPlayer.Data.Level.Value < 1150 then
                
        _G.mobs = "Horned Warrior [Lv. 1125]"
        _G.quests = "IceSideQuest"
        _G.number = 2
        _G.CFrames = CFrame.new(-6.06274072e3, 15.9517622, -4.90399512e3)
        _G.CFrames2 =  CFrame.new(-5721.96826, 15.9517603, -5652.21582)
        _G.TextQuest  =  [[Reward:
$12,500
16,800,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1.175e3 and LocalPlayer.Data.Level.Value < 1.2e3 then

    _G.mobs = "Magma Ninja [Lv. 1175]"
    _G.quests = "FireSideQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(-5428.58936, 15.9775658, -5298.06055)
    _G.CFrames2 = CFrame.new(-5428.58936, 15.9775658, -5298.06055)
    _G.TextQuest  =  [[Reward:
$12,250
18,000,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1.2e3 and LocalPlayer.Data.Level.Value < 1.25e3 then
    
    _G.mobs = "Lava Pirate [Lv. 1200]"
    _G.quests = "FireSideQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(-5428.58936, 15.9775658, -5298.06055)
    _G.CFrames2 =  CFrame.new(-5428.58936, 15.9775658, -5298.06055)
    _G.TextQuest  = [[Reward:
$12,500
20,000,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1.25e3 and LocalPlayer.Data.Level.Value < 1.275e3 then

    _G.mobs = "Ship Deckhand [Lv. 1250]"
    _G.quests = "ShipQuest1"
    _G.number = 1
    _G.CFrames = CFrame.new(1.0395896e3, 125.057129, 3.29108906e4)
    _G.CFrames2 =  CFrame.new(1.0395896e3, 125.057129, 3.29108906e4)
    _G.TextQuest  =  [[Reward:
$12,250
23,000,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 1.275e3 and LocalPlayer.Data.Level.Value < 1.3e3 then

    _G.mobs = "Ship Engineer [Lv. 1275]"
    _G.quests = "ShipQuest1"
    _G.number = 2
    _G.CFrames = CFrame.new(1.0395896e3, 125.057129, 3.29108906e4)
    _G.CFrames2 =  CFrame.new(1.0395896e3, 125.057129, 3.29108906e4)
    _G.TextQuest  =  [[Reward:
$12,500
24,500,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1.3e3 and LocalPlayer.Data.Level.Value < 1.325e3 then

    _G.mobs = "Ship Steward [Lv. 1300]"
    _G.quests = "ShipQuest2"
    _G.number = 1
    _G.CFrames = CFrame.new(970.568787, 125.057129, 3.32465313e4)
    _G.CFrames2 =  CFrame.new(928.537048, 129.55603, 33444.5352)
    _G.TextQuest  =  [[Reward:
$12,250
26,500,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1.325e3 and LocalPlayer.Data.Level.Value < 1.35e3 then

    _G.mobs = "Ship Officer [Lv. 1325]"
    _G.quests = "ShipQuest2"
    _G.number = 2
    _G.CFrames = CFrame.new(970.568787, 125.057129, 3.32465313e4)
    _G.CFrames2 =   CFrame.new(970.568787, 125.057129, 3.32465313e4)
    _G.TextQuest  =  [[Reward:
$12,500
28,500,000 Exp.]]

elseif LocalPlayer.Data.Level.Value >= 1.35e3 and LocalPlayer.Data.Level.Value < 1.375e3 then

    _G.mobs = "Arctic Warrior [Lv. 1350]"
    _G.quests = "FrostQuest"
    _G.number = 1
    _G.CFrames = CFrame.new(5.66797949e3, 28.1767731, -6.48296484e3)
    _G.CFrames2 =   CFrame.new(5.66797949e3, 28.1767731, -6.48296484e3)
    _G.TextQuest  =  [[Reward:
$12,250
30,000,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 1.375e3 and LocalPlayer.Data.Level.Value < 1425 then
    _G.mobs = "Snow Lurker [Lv. 1375]"
    _G.quests = "FrostQuest"
    _G.number = 2
    _G.CFrames = CFrame.new(5.66797949e3, 28.1767731, -6.48296484e3)
    _G.CFrames2 =   CFrame.new(5.66797949e3, 28.1767731, -6.48296484e3)
    _G.TextQuest  =  [[Reward:
$12,500
32,000,000 Exp.]]
    elseif LocalPlayer.Data.Level.Value >= 1425 and LocalPlayer.Data.Level.Value < 1450 then
    _G.mobs = "Sea Soldier [Lv. 1425]"
    _G.quests = "ForgottenQuest"
    _G.number = 1
    _G.CFrames =  CFrame.new(-3053.67822, 236.846329, -10144.7432)
    _G.CFrames2 =    CFrame.new(-3053.67822, 236.846329, -10144.7432)
    _G.TextQuest  =  [[Reward:
$12,250
33,500,000 Exp.]]
elseif LocalPlayer.Data.Level.Value >= 1450 and LocalPlayer.Data.Level.Value < math.huge then
    _G.mobs = "Water Fighter [Lv. 1450]"
    _G.quests = "ForgottenQuest"
    _G.number = 2
    _G.CFrames =  CFrame.new(-3053.67822, 236.846329, -10144.7432)
    _G.CFrames2 =    CFrame.new(-3053.67822, 236.846329, -10144.7432)
    _G.TextQuest  =  [[Reward:
$12,500
35,500,000 Exp.]]
    end
end


local function warpmon(Onemob)
    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == _G.mobs and v:FindFirstChild("HumanoidRootPart")  then
            if v.Humanoid.Health > 0 then 
                v.HumanoidRootPart.Size = Vector3.new(setting.HitBox,setting.HitBox,setting.HitBox)
                    v.HumanoidRootPart.CanCollide = false
            if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 500 then 
                    v.HumanoidRootPart.CFrame = Onemob

                end
            end
        end
    end
end

local function gunbring(gunxd)
        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == _G.mobs and v:FindFirstChild("HumanoidRootPart")  then
                if v.Humanoid.Health > 0 then 
                    v.HumanoidRootPart.Size = Vector3.new(10,10,10)
                        v.HumanoidRootPart.CanCollide = false
                if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 500 then 
                        v.HumanoidRootPart.CFrame = gunxd
    

                end
            end
        end
    end
end

game:GetService('RunService').Stepped:connect(function()
    if setting.Newworld or  setting.mobaura or setting.autofarm or settingboss.BossFarm or setting.EctoPlasm or setting.Rengoku or setting.TpPlayers or setting.Raid  then
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end)
    end
end)

local function farmnewworld()
    pcall(function()
        check()
    game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("TravelDressrosa")

    if LocalPlayer.Data.Level.Value >= 700 then
        setting.autofarm = false
        game:GetService"ReplicatedStorage".Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
            game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("DressrosaQuestProgress")
        tp(CFrame.new(1.34794409e3, 37.3493423, -1.32581873e3))

        for _, k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if k:IsA("Tool") and k.Name == "Key" then
                k.Parent = game:GetService("Players").LocalPlayer.Character
                end
            end
        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
            game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("Buso")
            end
            wait(0.75)
        pcall(function()
            for i, v in pairs(game:GetService"Workspace".Enemies:GetChildren()) do
                if v:FindFirstChild"HumanoidRootPart" and v.Humanoid.Health > 0 then
                    if v.Name == "Ice Admiral [Lv. 700] [Boss]" then
                    v.HumanoidRootPart.Size = Vector3.new(40.40,40)
                        repeat wait() 
                                    click()
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, setting.Distance, 0)
                            
                        until v.Humanoid.Health == 0 or setting.Newworld  == false 
                        game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("TravelDressrosa")
                            end
                        end
                    end
                end)
            end
    end)
end

local function autofarm()
    check()
    if plr.PlayerGui.Main.Quest.Visible == false then
        tp(_G.CFrames)  
        wait(1)
        repeat  wait()
            game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("StartQuest", _G.quests, _G.number)	
        until  plr.PlayerGui.Main.Quest.Visible == true or not  setting.autofarm 

        -- Check Text quest 
    elseif   plr.PlayerGui.Main.Quest.Visible and plr.PlayerGui.Main.Quest.Container.QuestReward.Title.Text ~= _G.TextQuest   then 
        tp(_G.CFrames)  
            wait(1)
        repeat  wait()
            game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("StartQuest", _G.quests, _G.number)	
        until  plr.PlayerGui.Main.Quest.Visible == true or not  setting.autofarm 
    end
        -- check Done 
    if plr.PlayerGui.Main.Quest.Visible  and plr.PlayerGui.Main.Quest.Container.QuestReward.Title.Text == _G.TextQuest  then 
      --  tp(_G.CFrames2) -- tp check 
        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
           -- tp(_G.CFrames2)    -- last tp 
           if not game:GetService("Workspace").Enemies:FindFirstChild(_G.mobs) then 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.CFrames2 
            end
            if v.Name == _G.mobs   then  -- find mob 
                 setting.HideBox =  1
                 v.HumanoidRootPart.Size = Vector3.new(setting.HitBox,setting.HitBox, setting.HitBox) 
                 v.HumanoidRootPart.CanCollide = false
                 v.HumanoidRootPart.Transparency =  setting.HideBox
                 v.HumanoidRootPart.Color = _G.ColorPlayers
                 if  v.Humanoid.Health > 0  then 
                 repeat wait()
                    if setting.equip then
                        equip()
                    end

                    setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
                    tp(v.HumanoidRootPart.CFrame * CFrame.new(0, setting.Distance, 0))
                    warpmon(v.HumanoidRootPart.CFrame)
                    click()
                    
                    if  setting.Super  then
                        setting.equip = false 
                        setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
                        warpmon(v.HumanoidRootPart.CFrame)
                        SuperHuman()
                    else
                          setting.equip = true 
                    end

                    if  setting.Mastery then
                        local 	MaxHealth = (v.Humanoid.Health/v.Humanoid.MaxHealth) * 100
                        if MaxHealth < 12 then
                            plr.Character.Humanoid:UnequipTools()
                            plr.Backpack[plr.Data.DevilFruit.Value].Parent = plr.Character --ถือ ผลเอง

                            local args = { [1] = v.HumanoidRootPart.Position }
                            game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteEvent:FireServer(unpack(args))

                            local args = { [1] = false }
                            game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteEvent:FireServer(unpack(args))
                            
                            game:GetService('VirtualUser'):CaptureController()

                            local string_1 = "Z"
                            local Target = game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteFunction
                            Target:InvokeServer(string_1)  
                            game:GetService('VirtualUser'):SetKeyDown('0x7a')
                            game:GetService('VirtualUser'):SetKeyUp('0x7a')

 
                            local string_1 = "X"
                            local Target = game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteFunction
                            Target:InvokeServer(string_1) 	
                            game:GetService('VirtualUser'):CaptureController()

                            game:GetService('VirtualUser'):SetKeyDown('0x78')
                            game:GetService('VirtualUser'):SetKeyUp('0x78')

    
                            local string_1 = "C"
                            local Target = game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteFunction
                            Target:InvokeServer(string_1)
                            game:GetService('VirtualUser'):CaptureController()

                            game:GetService('VirtualUser'):SetKeyDown('0x63')
                            game:GetService('VirtualUser'):SetKeyUp('0x63')

          
                            local string_1 = "V"
                            local Target = game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteFunction
                            game:GetService('VirtualUser'):CaptureController()
                            Target:InvokeServer(string_1)
                            game:GetService('VirtualUser'):SetKeyDown('0x76')
                            game:GetService('VirtualUser'):SetKeyUp('0x76')
                        end
                    end

                    if setting.GunFarm then
                        local 	MaxHealth = (v.Humanoid.Health/v.Humanoid.MaxHealth) * 100
                        for i2 , v2 in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                            if v2:IsA("Tool") and  v2:FindFirstChild("RemoteFunctionShoot") then
                                if MaxHealth < 12 then
                                setting.equip = false 
                                       game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                                       v2.Parent = game.Players.LocalPlayer.Character
                                for i3,v3 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                      if v3:IsA("Tool") and  v3:FindFirstChild("RemoteFunctionShoot") then
                                              v.HumanoidRootPart.Size = Vector3.new(10,10,10)
                                              repeat wait()
                                                setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
                                                gunbring(v.HumanoidRootPart.CFrame)
                                               tp(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                               tp(CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position))
                                                v3.RemoteFunctionShoot:InvokeServer(v.HumanoidRootPart.Position, v.HumanoidRootPart)
                                              until v.Humanoid.Health == 0 or not setting.GunFarm
                                        end
                                    end
                                 end
                            end
                        end
                    else
                        setting.equip = true 
                    end

                    if ( LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position ).magnitude <= 60 then 
                        if setting.z  then
					    plr.Character[setting.selectweapons ].RemoteEvent:FireServer(v.HumanoidRootPart.Position)
						plr.Character[setting.selectweapons ].RemoteFunction:InvokeServer("Z")
                        local virtualUser = game:GetService('VirtualUser')
					    virtualUser:CaptureController()

						virtualUser:SetKeyDown('0x7a')
						virtualUser:SetKeyUp('0x7a')

						if setting.x then 

                        plr.Character[setting.selectweapons ].RemoteEvent:FireServer(v.HumanoidRootPart.Position)
                        plr.Character[setting.selectweapons ].RemoteFunction:InvokeServer("X")
						local virtualUser = game:GetService('VirtualUser')
						virtualUser:CaptureController()

						virtualUser:SetKeyDown('0x78')
						virtualUser:SetKeyUp('0x78')

						if setting.c  then 

						plr.Character[setting.selectweapons ].RemoteEvent:FireServer(v.HumanoidRootPart.Position)
						plr.Character[setting.selectweapons ].RemoteFunction:InvokeServer("C")
						local virtualUser = game:GetService('VirtualUser')
						virtualUser:CaptureController()
												
						virtualUser:SetKeyDown('0x63')
						virtualUser:SetKeyUp('0x63')

                        if setting.v  then

                            plr.Character[setting.selectweapons ].RemoteEvent:FireServer(v.HumanoidRootPart.Position)
						    plr.Character[setting.selectweapons ].RemoteFunction:InvokeServer("V")
                            game:GetService('VirtualUser'):SetKeyDown('0x76')
                            game:GetService('VirtualUser'):SetKeyUp('0x76')
                                    end
                                end
                            end           
                        end
                    end
                 until v.Humanoid.Health == 0 or plr.PlayerGui.Main.Quest.Visible == false  or not setting.autofarm 
                end
            end
        end
    end
end

local function buso()
    if not plr.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("Buso")
    end
end

local function aura()
    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Humanoid.Health > 0 then 
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Transparency = 0.9
                v.HumanoidRootPart.Size = Vector3.new(35,35,35)
                if (LocalPlayer.Character.HumanoidRootPart.Position  - v.HumanoidRootPart.Position  ).magnitude <= 40 then 
                    repeat wait()
                            click()
                   tp(v.HumanoidRootPart.CFrame * CFrame.new(0, setting.Distance, 0))
                        until v.Humanoid.Health == 0 or not setting.mobaura
            end
        elseif setting.mobaura == false then
            v.HumanoidRootPart.CanCollide = true
            v.HumanoidRootPart.Transparency = 1
        end
    end
end

-- Script New world --
local function check2()
	if settingboss.selectboss  == "Diamond" then
		_G.bossmon = "Diamond [Lv. 750] [Boss]"
		_G.quests = "Area1Quest"
		_G.number = 3
		_G.CFrames = CFrame.new(-427.932526, 72.9705429, 1.83660828e3)
		_G.CFrames2 =   CFrame.new(-1727.29871, 198.496109, -101.298378)
		_G.TextQuest  =  [[Reward:
$25,000
9,000,000 Exp.]]
	elseif settingboss.selectboss  == "Jeremy" then
		_G.bossmon = "Jeremy [Lv. 850] [Boss]"
		_G.quests = "Area2Quest"
		_G.number = 3
		_G.CFrames = CFrame.new(636.524414, 73.070549, 916.877502)
		_G.CFrames2 =  CFrame.new(2074.29419, 448.931, 884.717834)
		_G.TextQuest  =  [[Reward:
$25,000
11,500,000 Exp.]]
	elseif settingboss.selectboss  == "Fajita" then
		 _G.bossmon = "Fajita [Lv. 925] [Boss]"
		 _G.quests = "MarineQuest3"
		 _G.number = 3
		 _G.CFrames = CFrame.new(-2.44242554e3, 73.0161057, -3.21721606e3)
		 _G.CFrames2 =   CFrame.new(-2233.80591, 72.9661407, -4221.52979)
		 _G.TextQuest  =  [[Reward:
$25,000
15,000,000 Exp.]]
	elseif settingboss.selectboss  == "Smoke Admiral" then
		_G.bossmon = "Smoke Admiral [Lv. 1150] [Boss]"
		_G.quests = "IceSideQuest"
		_G.number = 3
		_G.CFrames = CFrame.new(-6.06273242e3, 15.9517622, -4.90400195e3)
		_G.CFrames2 =   CFrame.new(-5107.87305, 23.7314606, -5339.19922)
		_G.TextQuest  =  [[Reward:
$20,000
25,000,000 Exp.]]
	elseif settingboss.selectboss  == "Ice Admiral" then
		_G.bossmon = "Awakened Ice Admiral [Lv. 1400] [Boss]"
		_G.quests = "FrostQuest"
		_G.number = 3
		_G.CFrames = CFrame.new(5.66873193e3, 28.1767349, -6.48364307e3)
		_G.CFrames2 =   CFrame.new(6409.90918, 344.959076, -6900.8291)
		_G.TextQuest  =  [[Reward:
$20,000
36,000,000 Exp.]]

	elseif settingboss.selectboss  == "Tide Keeper"  then 
		_G.bossmon = "Tide Keeper [Lv. 1475] [Boss]"
		_G.quests = "ForgottenQuest"
		_G.number = 3
		_G.CFrames =  CFrame.new(-3053.67822, 236.846329, -10144.7432)
		_G.CFrames2 =  CFrame.new(-3670.87476, 77.0048981, -11336.6514)
		_G.TextQuest = [[Reward:
$12,500
38,000,000 Exp.]]
	end
end


local function bossfarm()
    check2()
    if plr.PlayerGui.Main.Quest.Visible == false then
        tp(_G.CFrames)  
        wait(1)
        repeat  wait()
            game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("StartQuest", _G.quests, _G.number)	
        until  plr.PlayerGui.Main.Quest.Visible == true or not  settingboss.BossFarm

        -- Check Text quest 
    elseif   plr.PlayerGui.Main.Quest.Visible and plr.PlayerGui.Main.Quest.Container.QuestReward.Title.Text ~= _G.TextQuest   then 
        tp(_G.CFrames)  
            wait(1)
        repeat  wait()
            game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("StartQuest", _G.quests, _G.number)	
        until  plr.PlayerGui.Main.Quest.Visible == true or not  settingboss.BossFarm
        -- check Done 
    elseif plr.PlayerGui.Main.Quest.Visible  and plr.PlayerGui.Main.Quest.Container.QuestReward.Title.Text == _G.TextQuest  then 
      --  tp(_G.CFrames2) -- tp check 
        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
           -- tp(_G.CFrames2)    -- last tp 
           if not game:GetService("Workspace").Enemies:FindFirstChild(_G.bossmon) then 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.CFrames2 
            end
            if v.Name == _G.bossmon then  -- find mob 
                print(settingboss.selectboss)
                 v.HumanoidRootPart.Size = Vector3.new(setting.HitBox,setting.HitBox, setting.HitBox) 
                 v.HumanoidRootPart.CanCollide = false
                 v.HumanoidRootPart.Transparency = 0.8
                 if  v.Humanoid.Health > 0  then 
                 repeat wait()
                    if setting.equip then
                        equip()
                    end
                    setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
                    tp(v.HumanoidRootPart.CFrame * CFrame.new(0, setting.Distance, 0))
                    warpmon(v.HumanoidRootPart.CFrame)
                    click()
                    
                    if  setting.Super  then
                        setting.equip = false 
                        setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
                        warpmon(v.HumanoidRootPart.CFrame)
                        SuperHuman()
                    else
                        setting.equip = true
                    end

                    if  setting.Mastery then
                        local 	MaxHealth = (v.Humanoid.Health/v.Humanoid.MaxHealth) * 100
                        if MaxHealth < 12 then
                            plr.Character.Humanoid:UnequipTools()
                            plr.Backpack[plr.Data.DevilFruit.Value].Parent = plr.Character --ถือ ผลเอง

                            local args = { [1] = v.HumanoidRootPart.Position }
                            game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteEvent:FireServer(unpack(args))

                            local args = { [1] = false }
                            game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteEvent:FireServer(unpack(args))
                            
                            local string_1 = "Z"
                            local Target = game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteFunction
                            Target:InvokeServer(string_1)  
                            
                            local string_1 = "X"
                            local Target = game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteFunction
                            Target:InvokeServer(string_1) 	
                        
                            local string_1 = "C"
                            local Target = game:GetService"Workspace".Characters[plr.Name][plr.Data.DevilFruit.Value].RemoteFunction
                            Target:InvokeServer(string_1)
                        end
                    end
                    if ( LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position ).magnitude <= 60 then 
                        if setting.z  then
                        local virtualUser = game:GetService('VirtualUser')
					    virtualUser:CaptureController()

						virtualUser:SetKeyDown('0x7a')
						virtualUser:SetKeyUp('0x7a')
					    plr.Character[setting.selectweapons ].RemoteEvent:FireServer(v.HumanoidRootPart.Position)
						plr.Character[setting.selectweapons ].RemoteFunction:InvokeServer("Z")

						if setting.x then 
						local virtualUser = game:GetService('VirtualUser')
						virtualUser:CaptureController()

						virtualUser:SetKeyDown('0x78')
						virtualUser:SetKeyUp('0x78')
                        plr.Character[setting.selectweapons ].RemoteEvent:FireServer(v.HumanoidRootPart.Position)
                        plr.Character[setting.selectweapons ].RemoteFunction:InvokeServer("X")

						if setting.c  then 
						local virtualUser = game:GetService('VirtualUser')
						virtualUser:CaptureController()
												
						virtualUser:SetKeyDown('0x63')
						virtualUser:SetKeyUp('0x63')
						plr.Character[setting.selectweapons ].RemoteEvent:FireServer(v.HumanoidRootPart.Position)
						plr.Character[setting.selectweapons ].RemoteFunction:InvokeServer("C")
                                end
                            end           
                        end
                    end
                 until v.Humanoid.Health == 0 or plr.PlayerGui.Main.Quest.Visible == true or not settingboss.BossFarm
                end
            end
        end
    end
end


local function factoryfarm()
    if game.Workspace.Enemies:FindFIrstChild("Core") then
        setting.autofarm  = false 
        tp(CFrame.new(429.760712, 211.406876, -426.705841))
    elseif game.ReplicatedStorage:FindFirstChild("Core") then
        setting.autofarm = false 
        tp(CFrame.new(429.760712, 211.406876, -426.705841))
    end
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == "Core" and  v.Humanoid.Health > 0 then
            repeat wait()
                tp(v.HumanoidRootPart.CFrame * CFrame.new(0,0,0))
                click()
              until v.Humanoid.Health == 0 or not setting.factory
          end
     end
end

local function	shipbring(Onemob3)
	for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		if string.find(v.Name ,"Ship") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head")  then
			if v.Humanoid.Health > 0 then 
				v.HumanoidRootPart.Size = Vector3.new(40, 40, 40)
					v.HumanoidRootPart.CanCollide = false
						v.Head.CanCollide = false
			if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then 
					v.HumanoidRootPart.CFrame = Onemob3

				end
			end
		end
	end
end

local function Rengobring(Onemob4)
        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Snow Lurker [Lv. 1375]"  and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head")  then
                if v.Humanoid.Health > 0 then 
                    v.HumanoidRootPart.Size = Vector3.new(setting.HitBox,setting.HitBox, setting.HitBox) 
                        v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
            --		if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 50000000 then 
                        v.HumanoidRootPart.CFrame = Onemob4
    
                --	endw
            end
        end
    end
end

local function Rengokufarm()
   tp(CFrame.new(5593.21533, 28.6305828, -6759.47266))
	for i , v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
		if v.Name == "Snow Lurker [Lv. 1375]"  then 
			if v.Humanoid.Health > 0 then 
                v.HumanoidRootPart.Size = Vector3.new(setting.HitBox,setting.HitBox, setting.HitBox) 
				v.HumanoidRootPart.CanCollide = false
			repeat wait()
                equip()
				click()
				tp(v.HumanoidRootPart.CFrame * CFrame.new(0, setting.Distance, 0))
				setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
				Rengobring(v.HumanoidRootPart.CFrame)
--[[
                    if  setting.Super  then
                    setting.equip = false 
                    setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
                    Rengobring(v.HumanoidRootPart.CFrame)
                    SuperHuman()
                end
]]
			until v.Humanoid.Health == 0  or not setting.Rengoku
			end
		end
	end
end

local function Ectofarm()
	tp(CFrame.new(803.598572, 40.4428749, 33053.0547))
	for i , v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
		if string.find(v.Name ,"Ship")  then 
			if v.Humanoid.Health > 0 then 
                v.HumanoidRootPart.Size = Vector3.new(setting.HitBox,setting.HitBox, setting.HitBox) 
				v.HumanoidRootPart.CanCollide = false
			repeat wait()
                equip()
				click()
				tp(v.HumanoidRootPart.CFrame * CFrame.new(0, setting.Distance, 0))
				if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 20 then 
				setsimulationradius(10000000000,10000000000)  
				shipbring(v.HumanoidRootPart.CFrame)
				end
            --[[
                    if  setting.Super  then
                    setting.equip = false 
                    setsimulationradius(10000000000000000000000000,10000000000000000000000000)  
                    shipbring(v.HumanoidRootPart.CFrame)
                    SuperHuman()
                end
            ]]
			until v.Humanoid.Health == 0 or not setting.EctoPlasm
			end
		end
	end
end

local function espchest()
local checkxd
local CheckRemovexd
   if setting.chestesp then
    for i, v in pairs(workspace:GetChildren()) do
        if v:IsA"Part" and v.Name == "Chest1" then
            local BillboardGui = Instance.new"BillboardGui"
            local TextLabel = Instance.new"TextLabel"
            BillboardGui.Parent = v
            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            BillboardGui.Active = true
            BillboardGui.AlwaysOnTop = true
            BillboardGui.LightInfluence = 1
            BillboardGui.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Parent = BillboardGui
            TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = "Chest1"
            TextLabel.TextColor3 = Color3.fromRGB(252, 172, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
        end
        if v:IsA"Part" and v.Name == "Chest2" then
            local BillboardGui = Instance.new"BillboardGui"
            local TextLabel = Instance.new"TextLabel"
            BillboardGui.Parent = v
            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            BillboardGui.Active = true
            BillboardGui.AlwaysOnTop = true
            BillboardGui.LightInfluence = 1
            BillboardGui.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Parent = BillboardGui
            TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = "Chest2"
            TextLabel.TextColor3 = Color3.fromRGB(252, 172, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
        end
        if v:IsA"Part" and v.Name == "Chest3" then
            local BillboardGui = Instance.new"BillboardGui"
            local TextLabel = Instance.new"TextLabel"
            BillboardGui.Parent = v
            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            BillboardGui.Active = true
            BillboardGui.AlwaysOnTop = true
            BillboardGui.LightInfluence = 1
            BillboardGui.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Parent = BillboardGui
            TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = "Chest3"
            TextLabel.TextColor3 = Color3.fromRGB(252, 172, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
        end
    end
    checkxd = game:GetService('Workspace').ChildAdded:Connect(function(tool)
        if tool:IsA("Part") then
            local BillboardGui = Instance.new("BillboardGui")
            local TextLabel = Instance.new("TextLabel")
            BillboardGui.Parent = tool
            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            BillboardGui.Active = true
            BillboardGui.AlwaysOnTop = true
            BillboardGui.LightInfluence = 1
            BillboardGui.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Parent = BillboardGui
            TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(0, 100, 0, 25)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = tool.Name
            TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
            TextLabel.TextStrokeTransparency = 0.4
            TextLabel.TextColor3 = Color3.fromRGB(252, 172, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
        end
    end)
    CheckRemovexd = game:GetService('Workspace').ChildRemoved:Connect(function(toolremove)
        toolremove.BillboardGui:Destroy()
    end)
end
if setting.chestesp == false  then
    for i, v in pairs(workspace:GetDescendants()) do if string.find(v.Name, "BillboardGui") then v:Destroy() end end
end
end

local function espdf()
    local CheckAdd
    local CheckRemove 
    if setting.Devilesp  then
        for i, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool")  then
                if v.Fruit then
                    local BillboardGui = Instance.new("BillboardGui")
                    local TextLabel = Instance.new("TextLabel")
                    BillboardGui.Parent = v.Fruit
                    BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                    BillboardGui.Active = true
                    BillboardGui.AlwaysOnTop = true
                    BillboardGui.LightInfluence = 1
                    BillboardGui.Size = UDim2.new(0, 100, 0, 25)
					
                    TextLabel.Parent = BillboardGui
                    TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Size = UDim2.new(0, 100, 0, 25)
                    TextLabel.Font = Enum.Font.SourceSans
                    TextLabel.Text = v.Name
                    TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                    TextLabel.TextStrokeTransparency = 0.4
                    TextLabel.TextColor3 = Color3.fromRGB(255,80,60)
                    TextLabel.TextScaled = true
                    TextLabel.TextSize = 14
                    TextLabel.TextWrapped = true
                end
            end
            if v:IsA("Model") and v.Name == "Fruit " then
                if v.Handle then
                    local BillboardGui = Instance.new("BillboardGui")
                    local TextLabel = Instance.new("TextLabel")
                    BillboardGui.Parent = v
                    BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                    BillboardGui.Active = true
                    BillboardGui.AlwaysOnTop = true
                    BillboardGui.LightInfluence = 1
                    BillboardGui.Size = UDim2.new(0, 100, 0, 25)
                    TextLabel.Parent = BillboardGui
                    TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Size = UDim2.new(0, 100, 0, 25)
                    TextLabel.Font = Enum.Font.SourceSans
                    TextLabel.Text = "Fruit"
                    TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                    TextLabel.TextStrokeTransparency = 0.4
                    TextLabel.TextColor3 = Color3.fromRGB(255,80,60)
                    TextLabel.TextScaled = true
                    TextLabel.TextSize = 14
                    TextLabel.TextWrapped = true
                end
            end
        end
        CheckAdd = game:GetService('Workspace').ChildAdded:Connect(function(tool)
            if string.find(tool.Name, "Handle") then
                local BillboardGui = Instance.new("BillboardGui")
                local TextLabel = Instance.new("TextLabel")
                BillboardGui.Parent = tool.Fruit
                BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                BillboardGui.Active = true
                BillboardGui.AlwaysOnTop = true
                BillboardGui.LightInfluence = 1
                BillboardGui.Size = UDim2.new(0, 100, 0, 25)
                TextLabel.Parent = BillboardGui
                TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
                TextLabel.BackgroundTransparency = 1
                TextLabel.BorderSizePixel = 0
                TextLabel.Size = UDim2.new(0, 100, 0, 25)
                TextLabel.Font = Enum.Font.SourceSans
                TextLabel.Text = tool.Name
                TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                TextLabel.TextStrokeTransparency = 0.4
                TextLabel.TextColor3 = Color3.fromRGB(255,80,60)
                TextLabel.TextScaled = true
                TextLabel.TextSize = 14
                TextLabel.TextWrapped = true
            end
        end)
        CheckRemove = game:GetService('Workspace').ChildRemoved:Connect(function(toolremove)
            toolremove.Fruit.BillboardGui:Destroy()
        end)
    end
    if setting.Devilesp  == false then
        for i, v in pairs(workspace:GetDescendants()) do if string.find(v.Name, "BillboardGui") then v:Destroy() end end
    end
end

local function floweresp()
    if setting.flower == true then
		for i, v in pairs(workspace:GetChildren()) do
			if v:IsA"Part" and v.Name == "Flower1" then
				local BillboardGui = Instance.new"BillboardGui"
				local TextLabel = Instance.new"TextLabel"
				BillboardGui.Parent = v
				BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				BillboardGui.Active = true
				BillboardGui.AlwaysOnTop = true
				BillboardGui.LightInfluence = 1
				BillboardGui.Size = UDim2.new(0, 100, 0, 25)
				TextLabel.Parent = BillboardGui
				TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.Size = UDim2.new(0, 100, 0, 25)
				TextLabel.Font = Enum.Font.SourceSans
				TextLabel.Text = "Blue Flower"
				TextLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
				TextLabel.TextScaled = true
				TextLabel.TextSize = 14
				TextLabel.TextWrapped = true
			end
			if v:IsA"Part" and v.Name == "Flower2" then
				local BillboardGui = Instance.new"BillboardGui"
				local TextLabel = Instance.new"TextLabel"
				BillboardGui.Parent = v
				BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				BillboardGui.Active = true
				BillboardGui.AlwaysOnTop = true
				BillboardGui.LightInfluence = 1
				BillboardGui.Size = UDim2.new(0, 100, 0, 25)
				TextLabel.Parent = BillboardGui
				TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.Size = UDim2.new(0, 100, 0, 25)
				TextLabel.Font = Enum.Font.SourceSans
				TextLabel.Text = "Red Flower"
				TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
				TextLabel.TextScaled = true
				TextLabel.TextSize = 14
				TextLabel.TextWrapped = true
			end
		end
	end
	if  setting.flower == false then
		for i, v in pairs(workspace:GetDescendants()) do if string.find(v.Name, "BillboardGui") then v:Destroy() end end
	end
end

local function nameesp()
    spawn(function()
        wait()
        if setting.Playeresp == true then
            local Holder = Instance.new("Folder", game.CoreGui)
            Holder.Name = "ESP"
            local Box = Instance.new"BoxHandleAdornment"
            Box.Name = "nilBox"
            Box.Size = Vector3.new(4, 7, 4)
            Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
            Box.Transparency = 1e3
            Box.ZIndex = 0
            Box.AlwaysOnTop = false
            Box.Visible = false
            local NameTag = Instance.new"BillboardGui"
            NameTag.Name = "nilNameTag"
            NameTag.Enabled = false
            NameTag.Size = UDim2.new(0, 200, 0, 50)
            NameTag.AlwaysOnTop = true
            NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
            local Tag = Instance.new("TextLabel", NameTag)
            Tag.Name = "Tag"
            Tag.BackgroundTransparency = 1
            Tag.Position = UDim2.new(0, -50, 0, 0)
            Tag.Size = UDim2.new(0, 300, 0, 20)
            Tag.TextSize = 20
            Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
            Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
            Tag.TextStrokeTransparency = 0.4
            Tag.Text = "nil"
            Tag.Font = Enum.Font.SourceSansBold
            Tag.TextScaled = false
            local LoadCharacter = function(v)
                repeat wait() until v.Character ~= nil
                v.Character:WaitForChild"Humanoid"
                local vHolder = Holder:FindFirstChild(v.Name)
                vHolder:ClearAllChildren()
                local b = Box:Clone()
                b.Name = v.Name .. "Box"
                b.Adornee = v.Character
                b.Parent = vHolder
                local t = NameTag:Clone()
                t.Name = v.Name .. "NameTag"
                t.Enabled = true
                t.Parent = vHolder
                t.Adornee = v.Character:WaitForChild("Head", 5)
                if not t.Adornee then return UnloadCharacter(v) end
                t.Tag.Text = v.Name
                b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                local Update
                local UpdateNameTag = function()
                    if not pcall(function()
                        v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        t.Tag.Text = v.Name .. "\n" .. (maxh ~= 0 and tostring(math.floor(h / maxh * 100)) or "0") .. "%  " .. tostring(h) .. "/" .. tostring(maxh)
                    end) then Update:Disconnect() end
                end
                UpdateNameTag()
                Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
            end
            local UnloadCharacter = function(v)
                local vHolder = Holder:FindFirstChild(v.Name)
                if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then vHolder:ClearAllChildren() end
            end
            local LoadPlayer = function(v)
                local vHolder = Instance.new("Folder", Holder)
                vHolder.Name = v.Name
                v.CharacterAdded:Connect(function() pcall(LoadCharacter, v) end)
                v.CharacterRemoving:Connect(function() pcall(UnloadCharacter, v) end)
                v.Changed:Connect(function(prop)
                    if prop == "TeamColor" then
                        UnloadCharacter(v)
                        wait()
                        LoadCharacter(v)
                    end
                end)
                LoadCharacter(v)
            end
            local UnloadPlayer = function(v)
                UnloadCharacter(v)
                local vHolder = Holder:FindFirstChild(v.Name)
                if vHolder then vHolder:Destroy() end
            end
            for i, v in pairs(game:GetService"Players":GetPlayers()) do spawn(function() pcall(LoadPlayer, v) end) end
            game:GetService"Players".PlayerAdded:Connect(function(v) pcall(LoadPlayer, v) end)
            game:GetService"Players".PlayerRemoving:Connect(function(v) pcall(UnloadPlayer, v) end)
            game:GetService"Players".LocalPlayer.NameDisplayDistance = 0
        else pcall(function() game.CoreGui.ESP:Remove() end) end
    end)
end

local function killall()
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
			repeat wait()
				v.Humanoid.Health = 0
					setsimulationradius(10000,10000)  
			until v.Humanoid.Health == 0 or not setting.KillAll
		end
	end
end

local function  autoraid()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
        if v:FindFirstChild("AwakenedMoves") then
            if v.Name == "Flame-Flame" then
                _G.Select	= "Flame"
        
            elseif v.Name == "Ice-Ice" then
                _G.Select = "Ice"
            
            elseif v.Name == "Quake-Quake" then
                _G.Select = "Quake"
            
            elseif v.Name == "Light-Light" then
                _G.Select = "Light"
            
            elseif v.Name == "Dark-Dark" then
                _G.Select = "Dark"
            
            elseif v.Name == "String-String" then
                _G.Select = "String"
                    
            elseif  v.Name == "Rumble-Rumble" then
                _G.Select = "Rumble"
            end
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer( "RaidsNpc","Select",_G.Select)
        end
    end
    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") then
            fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
    
     end				
end

local function autokillall()
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
			repeat wait()
                 if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 500 then 
                    v.Humanoid.Health = 0
                  end
					setsimulationradius(10000,10000)  
			until v.Humanoid.Health == 0 or not setting.KillAll
		end
	end
end

local function hideboxclass()
    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == _G.mobs  then
            v.Character.HumanoidRootPart.Color = _G.ColorPlayers
            v.Character.HumanoidRootPart.Transparency = setting.HideBox
            v.Character.HumanoidRootPart.CanCollide = false
        end
    end
end
local VLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/BunnySalf/Pls-Don-t-Crack-me-Pls/main/Polar.Don't.Crack.Me")()
local W = VLib:AddWindow("BF PAID")
local m1 = W:AddTab("Auto Farm", "http://www.roblox.com/asset/?id=6035047380")
local m2 = W:AddTab("Auto Stats","http://www.roblox.com/asset/?id=6031079151")
local m3 = W:AddTab("LocalPlayer","http://www.roblox.com/asset/?id=6035053288")
local m4 = W:AddTab("ESP","http://www.roblox.com/asset/?id=6035056512")
local m5 = W:AddTab("Combat","http://www.roblox.com/asset/?id=6035181864")
local m6 = W:AddTab("Teleport","http://www.roblox.com/asset/?id=6034304898")
local m7 = W:AddTab("Setting","http://www.roblox.com/asset/?id=6031280882")

local farm = m1:AddSection("Farm")
local boss = m1:AddSection("Boss Farm")
local stats = m2:AddSection("Stats")
local Local = m3:AddSection("LocalPlayer")
local esp = m4:AddSection("ESP")
local com = m5:AddSection("Combat")
local set =m7:AddSection("Setting")
local set2 = m7:AddSection("Setting FarmPlayer")
local is = m6:AddSection("Teleport")
local is2 = m6:AddSection("TP NPCS")
local item = m3:AddSection("Game Shop")


local RefeshTarget = farm:AddLabel("Target : Name Mob")
spawn(function()
    while wait() do
        if setting.autofarm then
            pcall(function()
                RefeshTarget:Re("Target : ".._G.mobs)
            end)
        end
    end
end)

local refeshweapon = farm:AddDropdown("Select Weapon",getweapon,function(weaponfunction)
    setting.selectweapons = weaponfunction
end)

farm:AddButton("Refresh",function ()
    refeshweapon:Clear()
    for i ,v in pairs(plr.Backpack:GetChildren()) do
        if v.ClassName == "Tool" then
            refeshweapon:Add(v.Name)
        end
    end
end)

farm:AddSwitch("Level Farm",false,function (farm)
    setting.autofarm = farm 
    spawn(function ()
        while  wait() do
            if setting.autofarm then
              pcall(function()
                autofarm()
              end)
            end
        end
    end)
end)

if game.PlaceId == oldworlds  then
    farm:AddSwitch("Auto New Worlds",function (New)
        setting.Newworld = New
        spawn(function()
            while  wait() do
                if setting.Newworld then
                    pcall(function()
                        farmnewworld()
                    end)
                end
            end
        end)
    end)
end


farm:AddSwitch("Mob Aura",false,function (Aura)
    setting.mobaura = Aura
    spawn(function ()
        while  wait() do
            if setting.mobaura then
                pcall(function()
                    aura()
                end)
            end
        end
    end)
end)

farm:AddSwitch("Auto Buso",false,function (Buso)
    setting.Buso = Buso
    spawn(function()
        while  wait() do
            if setting.Buso then
                pcall(function ()
                    buso()
                end)
            end
        end
    end)
end)

farm:AddSwitch("Auto Observation",false,function (Observations)
    setting.Observation = Observations
    spawn(function()
        while  wait() do
            if setting.Observation then
                pcall(function ()
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken",true)
                end)
            end
        end
    end)
end)

-- Boss Farm 


if game.PlaceId == newworlds then
    local RefreshBoss = boss:AddDropdown("Select Boss", {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Smoke Admiral",
        "Ice Admiral",
        "Tide Keeper"
    },function ( boss )
        settingboss.selectboss = boss
    end)
    
    
    boss:AddSwitch("Boss Farm",function(farmboss)
        settingboss.BossFarm = farmboss
        spawn(function()
            while  wait() do
                if settingboss.BossFarm then
                  -- pcall(function()
                    bossfarm()
              --  end)
                end
            end
        end)
    end)
end

local Other = boss:AddFolder("Other Farm")

if game.PlaceId == oldworlds  then
    Other:AddSwitch("Mastery Farm",false,function (Mastery)
        setting.Mastery = Mastery
    end)
    
    Other:AddSwitch("Gun Farm",false,function (gun)
        setting.GunFarm = gun
    end)
    
    Other:AddSwitch("Superhuman Farm",false,function (Superhuman)
        setting.Super = Superhuman
    end)
else
    Other:AddSwitch("Mastery Farm",false,function (Mastery)
        setting.Mastery = Mastery
    end)
    
    Other:AddSwitch("Gun Farm",false,function (gun)
        setting.GunFarm = gun
    end)
    
    Other:AddSwitch("Superhuman Farm",false,function (Superhuman)
        setting.Super = Superhuman
    end)
    Other:AddSwitch("Factory Farm ",false,function(v)
        setting.factory = v 
        spawn(function ()
            while  wait() do
                pcall(function ()
                    factoryfarm()
                end)
            end
        end)
    end)
    Other:AddSwitch("EctoPlasm Farm", false,function(t) 
        setting.EctoPlasm = t 
        spawn(function()
            while  wait() do
                if setting.EctoPlasm then
                    pcall(function()
                        Ectofarm()
                    end)
                end
            end
        end)
    end)
    Other:AddSwitch("Rengoku Farm",false, function(t) 
       setting.Rengoku  = t 
       spawn(function ()
           while  wait() do
               if setting.Rengoku then
                   pcall(function ()
                    Rengokufarm()
                   end)
               end
           end
       end)
    end)
end

local s = boss:AddFolder("Auto Skill")

s:AddSwitch("Auto Skill Z",false,function(Z)
    setting.z = Z
end)

s:AddSwitch("Auto Skill X",false,function(X)
    setting.x = X
end)

s:AddSwitch("Auto SKill C",false,function(C)
    setting.c = C
end)

s:AddSwitch("Auto SKill V",false,function(C)
    setting.v = C
end)


-- Auto Stats 
local refeshstats = stats:AddLabel("Point")
spawn(function()
    while  wait() do
        pcall(function() 
            refeshstats:Re("Point : "..plr.Data.Points.Value )
        end)
    end
end)

stats:AddSwitch("Melee",false,function (m)
    setting.Melee = m 
end)

stats:AddSwitch("Sword",false,function (m)
    setting.Sword = m 
end)

stats:AddSwitch("Defense",false,function (m)
    setting.Defense = m 
end)

stats:AddSwitch("Gun",false,function (m)
    setting.Gun = m 
end)

stats:AddSwitch("Demon Fruits",false,function (m)
    setting.Fruit = m 
end)

-- Add Stats 
spawn(function()
	while wait() do
		if  setting.Melee  then
			game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("AddPoint", "Melee", 1)
		end
		if  setting.Defense  then
			game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("AddPoint", "Defense", 1)
		end
		if  setting.Sword then
			game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("AddPoint", "Sword", 1)
		end
		if  setting.Gun  then
			game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("AddPoint", "Gun", 1)
		end
		if  setting.Fruit  then
			game:GetService"ReplicatedStorage".Remotes["CommF_"]:InvokeServer("AddPoint", "Demon Fruit", 1)
		end
	end
end)

-- LocalPlayer


local Time = Local:AddLabel("Server Time")
spawn(function( ... )
    while wait() do 
        Time:Re("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
    end
end)
spawn(function()
    while true do
       UpdateTime()
       game:GetService("RunService").RenderStepped:Wait()
    end
end)
function UpdateTime() 
    GameTime = math.floor(workspace.DistributedGameTime+0.5)
    Hour = math.floor(GameTime/(60^2))%24
    Minute = math.floor(GameTime/(60^1))%60
    Second = math.floor(GameTime/(60^0))%60
    end
    

Local:AddSwitch("Anti AFK",false,function ()
    spawn(function()
        while  wait() do
            pcall(function()
                game:GetService"Players".LocalPlayer.Idled:Connect(function()
                    game:GetService"VirtualUser":CaptureController()
                    game:GetService"VirtualUser":ClickButton2(Vector2.new())
                end)
            end)
        end
    end)
end)

Local:AddSwitch("Noclip",false,function(v)
    setting.Noclip = v 
    spawn(function()
        while  wait() do
            if setting.Noclip then 
                noclip()
            end
        end
    end)
end)

Local:AddSwitch("No Dash CD",false,function(v)
    setting.Dash = v 
    spawn(function()
        while  wait() do
            if setting.Dash then
                pcall(function ()
                    NoDodgeCool()
                end)
            end
        end
    end)
end)

Local:AddSwitch("Inf Stamina",false,function(v)
    setting.Inf = v 
    spawn(function()
        if setting.Inf then
            LocalPlayer.Character.Energy.Changed:connect(function() 
                LocalPlayer.Character.Energy.Value = originalstam 
            end)
        end
    end)
end)

Local:AddDropdown("Change Race",{"Human","Mink","Fishman","Skypien","Cyborg"},function(v)
    setting.Noclip = v 
    spawn(function()
        plr.Data.Race.Value = setting.Noclip
    end)
end)

Local:AddButton("FPS",function()
    bosst()
end)

item:AddDropdown("Select Items", {"BlackbeardReward","Electro","FishmanKarate","BlackLeg","Superhuman","Geppo","Buso","Soru"},function(item)
    setting.shop = item
end)

item:AddButton("Buy",function()
    if setting.shop == "BlackbeardReward" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    elseif setting.shop == "Electro" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BuyElectro")
    elseif setting.shop == "FishmanKarate" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BuyFishmanKarate")
    elseif setting.shop == "BlackLeg" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BuyBlackLeg")
    elseif setting.shop == "Superhuman" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BuySuperhuman")
    elseif setting.shop == "Geppo" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BuyHaki", "Geppo")
    elseif setting.shop == "Buso" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BuyHaki", "Buso")
    elseif setting.shop == "Soru" then
        game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("BuyHaki", "Soru")
    end
end)

if game.PlaceId == oldworlds then

    item:AddDropdown("Select DF", {
        "Bomb-Bomb",
        "Spike-Spike",
        "Chop-Chop",
        "Spring-Spring",
        "Smoke-Smoke",
        "Flame-Flame",
        "Ice-Ice",
        "Sand-Sand",
        "Dark-Dark",
        "Light-Light",
        "Rubber-Rubber",
        "Barrier-Barrier",
        "Magma-Magma",
        "Quake-Quake",
        "Human-Human: Buddha",
        "String-String",
        "Bird-Bird: Phoenix",
        "Rumble-Rumble",
        "Paw-Paw",
        "Gravity-Gravity",
        "Dough-Dough",
        "Control-Control",
        "Dragon-Dragon"
    }, function(t) _G.DF = t end)
    item:AddSwitch("Fruits Sniper", false,function(t)
        _G.Sniper = t
        spawn(function()
            while wait() do
                if _G.Sniper then
                    pcall(function()
                        if LocalPlayer.PlayerGui.Main.FruitShop.Container.Current.ScrollingFrame[_G.DF].Price.Text == " Out of Stock" then print" Out of Stock"
                        else
                            pcall(function()
                                game:GetService"ReplicatedStorage".Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.DF)
                            end)
                        end
                    end)
                end
            end
        end)
    end)
else
    item:AddSwitch("Auto Buy Legendary Sword",false,function(t)
        setting.Legendary = t 
        spawn(function ()
            while wait() do 
                if  setting.Legendary then 
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
                    end)
                end
            end
        end)
    end)
    
    item:AddDropdown("Select DF", {
        "Bomb-Bomb",
        "Spike-Spike",
        "Chop-Chop",
        "Spring-Spring",
        "Smoke-Smoke",
        "Flame-Flame",
        "Ice-Ice",
        "Sand-Sand",
        "Dark-Dark",
        "Light-Light",
        "Rubber-Rubber",
        "Barrier-Barrier",
        "Magma-Magma",
        "Quake-Quake",
        "Human-Human: Buddha",
        "String-String",
        "Bird-Bird: Phoenix",
        "Rumble-Rumble",
        "Paw-Paw",
        "Gravity-Gravity",
        "Dough-Dough",
        "Control-Control",
        "Dragon-Dragon"
    }, function(t) _G.DF = t end)
    item:AddSwitch("Fruits Sniper", function(t)
        _G.Sniper = t
        spawn(function()
            while wait() do
                if _G.Sniper then
                    pcall(function()
                        if LocalPlayer.PlayerGui.Main.FruitShop.Container.Current.ScrollingFrame[_G.DF].Price.Text == " Out of Stock" then print" Out of Stock"
                        else
                            pcall(function()
                                game:GetService"ReplicatedStorage".Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.DF)
                            end)
                        end
                    end)
                end
            end
        end)
    end)
    
    item:AddSwitch("Auto Buy Color Haki",false,function (v)
        setting.buyhaki = v
        spawn(function()
            while  wait() do
                if setting.buyhaki then
                    pcall(function ()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ColorsDealer","2")
                    end)
                end
            end
        end)
    end)
end


if 4442272183 then
    Local:AddButton("Teleport To Old World",function()
       local args = {
          [1] = "TravelMain" -- OLD WORLD to NEW WORLD
       }
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
 else
    Local:AddButton("Teleport To NewWorld",false,function()
       local args = {
          [1] = "TravelDressrosa" -- NEW WORLD to OLD WORLD
       }
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
end
Local:AddButton("Open Devil Shop",function()
    game.Players.localPlayer.PlayerGui.Main.FruitShop.Visible = true
end)

Local:AddButton("Open Inventory",function()
    game.Players.localPlayer.PlayerGui.Main.Inventory.Visible = true
end)

Local:AddButton("Infinitestam", function()
    LocalPlayer.Character.Energy.Changed:connect(function() LocalPlayer.Character.Energy.Value = originalstam end)
end)

Local:AddButton("Respawn", function()
    local Character = LocalPlayer.Character
    Character.HumanoidRootPart:Destroy()
end)

Local:AddButton("Rejoin Sever", function()
    game:GetService"TeleportService":Teleport(4.442272183e9, LocalPlayer)
end)


-- esp function 

esp:AddSwitch("Chest",false,function(c)
    setting.chestesp = c 
    spawn(function()
       pcall(function()
            espchest()
        end)
    end)
end)

esp:AddSwitch("DevilFruits",false,function(c)
    setting.Devilesp = c 
    spawn(function()
        pcall(function ()
            espdf()
         end)
    end)
end)
if game.PlaceId == newworlds then

esp:AddSwitch("Flower",false,function (value)
    setting.flower = value
    spawn(function()
        floweresp()
    end)
end)

end
esp:AddSwitch("Players",false,function(c)
    setting.Playeresp = c 
    nameesp()
end)


local e = {
    enabled = false ;
    Tracers = false ;
    Distance = false ; 
    NAME = false ; 
}


pcall(function()
	
	Camera = game:GetService("Workspace").CurrentCamera
	RunService = game:GetService("RunService")
	camera = workspace.CurrentCamera
	Bottom = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)

	function GetPoint(vector3)
		local vector, onScreen = camera:WorldToScreenPoint(vector3)
		return {Vector2.new(vector.X,vector.Y),onScreen,vector.Z}
	end
	
	function MakeESP(model)
		local CurrentParent = model.Parent
	
		local TopL = Drawing.new("Line")
		local BottomL = Drawing.new("Line")
		local LeftL = Drawing.new("Line")
		local RightL = Drawing.new("Line")
		local Tracer = Drawing.new("Line")
		local Display = Drawing.new("Text")

        coroutine.resume(coroutine.create(function()
			while model.Parent == CurrentParent do
				
				local Distance = (Camera.CFrame.Position - model.HumanoidRootPart.Position).Magnitude
                local GetP = GetPoint(model.Head.Position)
                local headps = model.Head.CFrame
                
				if e.enabled and GetP[2] then
					
                    -- Calculate Cords
                    local topright = headps * CFrame.new(3,0.5, 0)
                    local topleft = headps * CFrame.new(-3,0.5, 0)
                    local bottomleft = headps * CFrame.new(-3,-7,0)
                    local bottomright = headps * CFrame.new(3,-7,0)
					topright = GetPoint(topright.p)[1]
					topleft = GetPoint(topleft.p)[1]
					bottomleft = GetPoint(bottomleft.p)[1]
					bottomright = GetPoint(bottomright.p)[1]

                    local teamcolor = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
                    TopL.Color, BottomL.Color, RightL.Color, LeftL.Color = teamcolor, teamcolor, teamcolor, teamcolor
                    TopL.From, BottomL.From, RightL.From, LeftL.From = topleft, bottomleft, topright, topleft
                    TopL.To, BottomL.To, RightL.To, LeftL.To = topright, bottomright, bottomright, bottomleft
					TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = true, true, true, true
				else
					TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = false, false, false, false
                end
                
				if e.enabled and e.Tracers and GetP[2] then
					Tracer.Color = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
					Tracer.From = Bottom
					Tracer.To = GetPoint(headps.p)[1]
					Tracer.Thickness = 1.5
					Tracer.Visible = true
				else
					Tracer.Visible = false
                end
                
				if e.enabled and  e.Distance and GetP[2] then
					Display.Visible = true
					Display.Position = GetPoint(headps.p + Vector3.new(0,0.5,0))[1]
					Display.Center = true
					Display.Text = tostring(math.floor(Distance)).." studs"
				else
					Display.Visible = false
                end
                
				RunService.RenderStepped:Wait()
			end
	
			TopL:Remove()
			BottomL:Remove()
			RightL:Remove()
			LeftL:Remove()
			Tracer:Remove()
			Display:Remove()
        
        end))
    end
    
	for _, Player in next, game:GetService("Players"):GetChildren() do
		if Player.Name ~= game.Players.LocalPlayer.Name then
			MakeESP(Player.Character)
			Player.CharacterAdded:Connect(function()
				delay(0.5, function()
					MakeESP(Player.Character)
				end)
			end)
		end	
	end
	
	game:GetService("Players").PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            delay(0.5, function()
                MakeESP(player.Character)
            end)
		end)
	end)
	
end)


esp:AddSwitch("Enabled ", false,function(t)
    e.enabled = t 
end)

esp:AddSwitch("Tracers",false, function(t)
    e.Tracers = t 
end)

esp:AddSwitch("Distance Players",false, function(t)
    e.Distance = t 
end)



-- Player Farm -- 
local RefreshComvattap = com:AddDropdown("Select Players", getplayers, function(t) setting.selectplayer = t end)
com:AddButton("Refesh Players",function ()
	RefreshComvattap:Clear()
		for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
			if v.Name ~= game:GetService("Players").LocalPlayer.Name then
			RefreshComvattap:Add(v.Name)
		end
	end
end)

com:AddButton("Teleport Players", function()
	for i, v in pairs(game:GetService"Players":GetPlayers()) do
		if v.Name == setting.selectplayer then
			tp(CFrame.new(v.Character.HumanoidRootPart.Position))
		end
	end
end)

com:AddSwitch("Teleport", false,function(t)
	setting.TpPlayers = t
	spawn(function()
		while wait() do
			if setting.TpPlayers then
                pcall(function()
				for i, v in pairs(game:GetService"Players":GetPlayers()) do
					if v.Name == setting.selectplayer then
                            v.Character.HumanoidRootPart.Size = Vector3.new(setting.HitBox2,setting.HitBox2, setting.HitBox)
                            repeat wait()
                              tp(CFrame.new(v.Character.HumanoidRootPart.Position) * CFrame.new(0, setting.Distance2, 0))
                            until v.Humanoid.Health == 0 or not setting.TpPlayers
                        end
                    end
                end)
            end
		end
	end)
end)

com:AddSwitch("Auto Click",false,function (t)
    setting.ClickPlayer = t 
    spawn(function()
        while  wait() do
            if setting.ClickPlayer then
                pcall(function ()
                    click()
                end)
            end
        end
    end)
end)

set:AddLabel("Setting Farm")

set:AddSlider("Distance Farm",20,50,function(value)
    setting.Distance = value 
end)

set:AddSlider("Hitbox Farm",10,100,function(value)
    setting.HitBox = value
end)

set:AddSwitch("Show HitBox",false,function (v)
    setting.HideBox = v 
    spawn(function()
            if  setting.HideBox == true then  setting.HideBox = 0.7
            elseif  setting.HideBox == false then  setting.HideBox = 1 end
    end)
end)

set:AddColorpicker("Color Hitbox", Color3.fromRGB(255, 0, 0), function(t) 
    _G.ColorPlayers = t 
end)

set2:AddLabel("Setting FarmPlayer")

set2:AddSlider("Distance Farm",20,50,function(value)
    setting.Distance2 = value 
end)

set2:AddSlider("Hitbox Farm",10,100,function(value)
    setting.HitBox2 = value
end)

set2:AddSwitch("Show HitBox",false,function (v)
    setting.HideBox2 = v 
    spawn(function()
        if  setting.HideBox2 == true then  setting.HideBox2 = 0.7
        elseif  setting.HideBox2 == false then  setting.HideBox2 = 1 end
end)
end)

set2:AddColorpicker("Color Hitbox", Color3.fromRGB(255, 0, 0), function(t) 
    _G.ColorPlayers2 = t 
end)

is:AddSwitch("Ctrl+Click to Teleport",false, function(bool)
    _G.Teleport = bool
    LocalPlayer:GetMouse().Button1Down:connect(function()
        if _G.Teleport == true then
            if not game:GetService"UserInputService":IsKeyDown(Enum.KeyCode.LeftControl) then return end
            if not LocalPlayer:GetMouse().Target then return end
            LocalPlayer.Character:MoveTo(LocalPlayer:GetMouse().Hit.p)
        end
    end)
end)
is:AddButton("Level Quest", function() 
    spawn(function ()
        check()
        tp(_G.CFrames)
    end)
end)
if game.PlaceId== oldworlds then 
is:AddButton("Windmill", function()
	tp(CFrame.new(1.02758875e3, 19.3245106, 1.36728564e3, -0.987686276, 0, -0.156449571, 0, 1, 0, 0.156449571, 0, -0.987686276))
end)
is:AddButton("Marine Start", function()
	tp(CFrame.new(-2.5733374e3, 6.88881826, 2.04699817e3, 0.0315897427, -3.02629779e-8, 0.99950093, -1.61048472e-8, 1, 3.0787092e-8, -0.99950093, -1.70693664e-8, 0.0315897427))
end)
is:AddButton("Middle Town", function()
	tp(CFrame.new(-582.941345, 6.70024586, 1.71393726e3, 0.965929627, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, 0.965929627))
end)
is:AddButton("Desert", function()
	tp(CFrame.new(1.09414587e3, 5.28642607, 4.19288721e3, -0.499959469, 0, -0.866048813, 0, 1, 0, 0.866048813, 0, -0.499959469))
end)
is:AddButton("Underwater City", function()
	tp(CFrame.new(6.13486992e4, 19.4723511, 1.4759884e3, 0.999977648, 3.390076e-9, -6.68252772e-3, -3.52019325e-9, 1, -1.94595113e-8, 6.68252772e-3, 1.94826004e-8, 0.999977648))
end)
is:AddButton("Pirate Village", function()
	tp(CFrame.new(-1.12014856e3, 4.60001373, 3.85531763e3, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627))
end)
is:AddButton("Jungle", function()
	tp(CFrame.new(-1.25514795e3, 11.7000084, 349.906677, -0.173624277, 0, 0.984811902, 0, 1, 0, -0.984811902, 0, -0.173624277))
end)
is:AddButton("Skylands 1", function()
	tp(CFrame.new(-4.96783691e3, 718.535278, -2.62384326e3, 0.499959469, -0, -0.866048813, 0, 1, -0, 0.866048813, 0, 0.499959469))
end)
is:AddButton("Skylands 2", function()
	tp(CFrame.new(-7.94689844e3, 5.54635449e3, -318.856445, 0.998631775, -0, -0.0522932447, 0, 1, -0, 0.0522932447, 0, 0.998631775))
end)
is:AddButton("Magma Village", function()
	tp(CFrame.new(-5.19335498e3, 5.43863821, 8.56956348e3, 0.951068401, 0, 0.308980465, 0, 1, 0, -0.308980465, 0, 0.951068401))
end)
is:AddButton("Frozen Village ", function()
	tp(CFrame.new(1.18563379e3, 7.15136719, -1.14336987e3, -0.484826207, 0, 0.874610603, 0, 1, 0, -0.874610603, 0, -0.484826207))
end)
is:AddButton("Colosseum", function()
	tp(CFrame.new(-1.33294006e3, 6.35386896, -2.89656055e3, -0.66911006, 0, 0.743163466, 0, 1, 0, -0.743163466, 0, -0.66911006))
end)
is:AddButton("Fountain City", function()
	tp(CFrame.new(5.15863184e3, 4.06925201, 4.02894678e3, -0.406715393, 0, 0.913554907, 0, 1, 0, -0.913554907, 0, -0.406715393))
end)
is:AddButton("Military Fortress", function()
	tp(CFrame.new(-4.8289751e3, 20.6520367, 4.37435791e3, -0.921316385, 5.66178571e-9, 0.388813794, -1.90244229e-8, 1, -5.96411383e-8, -0.388813794, -6.23453147e-8, -0.921316385))
end)
is:AddButton("Prison", function()
	tp(CFrame.new(5.13659277e3, 3.53421545, 785.520813, 0.392495215, 1.79353155e-8, -0.919754028, 5.72389602e-9, 1, 2.19427321e-8, 0.919754028, -1.38769947e-8, 0.392495215))
end)
is:AddButton("Mob Island", function()
	tp(CFrame.new(-2.85020068e3, 7.39224768, 5.35499268e3, -0.954083323, -1.62498637e-8, 0.299541265, -5.51723023e-9, 1, 3.66759672e-8, -0.299541265, 3.33392904e-8, -0.954083323))
end)


is2:AddButton("DF Seller",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-923.255066, 7.67800522, 1608.61011)
end)
is2:AddButton("Ability Teacher",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1491.01807, 37.3749809, -1413.83044)
end)
is2:AddButton("Remove DF",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5664.80469, 64.6776581, 867.85907)
end)
is2:AddButton("Dark Step",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-987.873047, 13.7778397, 3989.4978)
end)
is2:AddButton("Electro",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5389.49561, 13.283, -2149.80151)
end)
is2:AddButton("Fishamn Karate",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(61581.8047, 18.8965912, 987.832703)
end)
is2:AddButton("Nearest Boat Dealer",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(61581.8047, 18.8965912, 987.832703)
end)
is2:AddButton("Nearest Spawnpoint",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(61581.8047, 18.8965912, 987.832703)
end)
else
    is:AddButton("Dungeon", function()
		tp(CFrame.new(-6.43873535e3, 250.619553, -4.50150684e3))
	end)
	is:AddButton("First Spot", function()
		tp(CFrame.new(-67.0509338, 19.2767277, 2.83498779e3, 1, 7.76118512e-8, -3.35330207e-13, -7.76118512e-8, 1, -2.36616815e-9, 3.3514657e-13, 2.36616815e-9, 1))
	end)
	is:AddButton("Greenbit", function()
		tp(CFrame.new(-2.13560938e3, 72.9661179, -2.75881592e3, -0.5592103, -9.12921507e-8, 0.829025805, -5.33625588e-8, 1, 7.41246637e-8, -0.829025805, -2.78766343e-9, -0.5592103))
	end)
	is:AddButton("Kingdom Of Rose", function()
		tp(CFrame.new(-113.551056, 73.0320206, 1.37018738e3, 1, -1.20148673e-8, -4.40259876e-14, 1.20148673e-8, 1, 3.67901376e-10, 4.4021566e-14, -3.67901376e-10, 1))
	end)
	is:AddButton("Bar", function()
		tp(CFrame.new(-385.250916, 73.0200806, 297.388397, 1, -9.75934995e-8, -1.78137805e-14, 9.75934995e-8, 1, 2.98880209e-9, 1.75220929e-14, -2.98880209e-9, 1))
	end)
	is:AddButton("Graveyard", function()
		tp(CFrame.new(-5.49156445e3, 48.4801941, -684.113831, 0.79861635, -2.41049247e-9, -0.601840496, 1.9694657e-9, 1, -1.39180567e-9, 0.601840496, -7.37854222e-11, 0.79861635))
	end)
	is:AddButton("Snow Mountain", function()
		tp(CFrame.new(295.549164, 401.421936, -5.41741211e3, -4.09396705e-14, 6.50770815e-8, -1, 2.92780147e-8, 1, 6.50770815e-8, 1, -2.92780147e-8, -4.28449966e-14))
	end)
	is:AddButton("Circle Island Fire", function()
		tp(CFrame.new(-5.56113721e3, 15.9517593, -4.93466699e3, 0.309060872, 4.06433216e-8, -0.951042235, 4.83603113e-9, 1, 4.43071286e-8, 0.951042235, -1.82928694e-8, 0.309060872))
	end)
	is:AddButton("Circle Island Ice", function()
		tp(CFrame.new(-5.88635791e3, 15.9517593, -4.9682207e3, -0.5592103, 3.84204935e-9, 0.829025805, 7.14764914e-10, 1, -4.15227808e-9, -0.829025805, -1.72943804e-9, -0.5592103))
	end)
	is:AddButton("Usoap Island", function()
		tp(CFrame.new(4.71080713e3, 8.15071201, 2.85339404e3, 0.275356203, 7.57489786e-8, -0.961342275, -1.03474305e-8, 1, 7.58312098e-8, 0.961342275, -1.09331717e-8, 0.275356203))
	end)
	is:AddButton("Poneglyph Island", function()
		tp(CFrame.new(-5.08502832e3, 3.2208631, 2.38904297e3, 4.09607135e-4, -7.3521818e-8, 0.99999994, 1.00133191e-8, 1, 7.35177252e-8, -0.99999994, 9.98320449e-9, 4.09607135e-4))
	end)
	is:AddButton("Dark Arena", function()
		tp(CFrame.new(3.8070979e3, 14.6501827, -3.45219849e3, 1, 4.30262794e-8, 5.26477157e-14, -4.30262794e-8, 1, 1.93717398e-8, -5.18142217e-14, -1.93717398e-8, 1))
	end)
	is:AddButton("Mansion", function()
		tp(CFrame.new(-393.302521, 331.860657, 686.779663, 0.999992251, -8.19652541e-8, -3.94392852e-3, 8.20098975e-8, 1, 1.11590106e-8, 3.94392852e-3, -1.14823653e-8, 0.999992251))
	end)
	is:AddButton("Swan's Room", function()
		tp(CFrame.new(2.29369995e3, 15.1520376, 663.099609, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	end)
	is:AddButton("Factory", function()
		tp(CFrame.new(243.200958, 73.0679779, -245.467484, 0.692750692, 2.10652065e-8, -0.721177161, 3.04285597e-9, 1, 3.2132391e-8, 0.721177161, -2.44541756e-8, 0.692750692))
	end)
	is:AddButton("Coloseum", function()
		tp(CFrame.new(-1.83641101e3, 45.7947006, 1.36023706e3, 1, 1.46615706e-8, 1.59280954e-13, -1.46615706e-8, 1, 3.27130394e-8, -1.5880133e-13, -3.27130394e-8, 1))
	end)
	is:AddButton("Lab", function()
		tp(CFrame.new(-6.24665381e3, 16.2000637, -5.00837695e3, -0.28876254, 2.32198065e-8, 0.957400739, -9.56394146e-8, 1, -5.30988586e-8, -0.957400739, -1.06898206e-7, -0.28876254))
	end)
    is:AddButton("IceCastle",function()
       tp(CFrame.new(5592.97217, 57.5749969, -6573.59131))
    end)
	is:AddButton("ForgottenIsland",function()
		tp(CFrame.new(-3034.93188, 238.87204, -10206.9521))
	end)

    is2:AddButton("Dragon Berath",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(703.372986, 186.985474, 654.522034)
    end)
    is2:AddButton("Greedy Elf",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6483.86279, 250.645477, -4448.9624)
    end)
    is2:AddButton("Awakening Expert",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-458.130219, 16.0778408, 273.82959)
    end)
    is2:AddButton("Nerd",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-401.783722, 73.0859299, 262.306702)
    end)
    is2:AddButton("Bar Manager",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-385.84726, 73.0458984, 316.088806)
    end)
    is2:AddButton("Blox Fruits Dealer",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-443.422607, 76.1261749, 344.904755)
    end)
    is2:AddButton("Weapons Storage",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(120.183121, 19.302536, 2849.427)
    end)
    is2:AddButton("Trevor",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-341.498322, 331.886444, 643.024963)
    end)
    is2:AddButton("Santa",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-408.225067, 321.897308, 774.253662)
    end)
    is2:AddButton("Enhancement Editor",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-346.820221, 72.9856339, 1194.36218)
    end)
    is2:AddButton("Pirate Recruiter",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-428.072998, 72.949501, 1445.32422)
    end)
    is2:AddButton("Chemist",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2777.45288, 72.9919434, -3572.25732)
    end)
    is2:AddButton("Cyborg",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(629.146851, 312.3078, -531.624146)
    end)
    is2:AddButton("Factory",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(430.989227, 211.117249, -433.162994)
    end)
    is2:AddButton("Ghoul Mark",function ()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(635.172546, 125.976357, 33219.832)
    end)
    is2:AddButton("Guashiem",function ( ... )
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(937.953003, 181.483368, 33277.9297)
    end)
    is2:AddButton("El Admin",function ( ... )
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1322.46912, 130.111481, 33134.707)
    end)
end

if game.PlaceId ==   4442272183 then
    
local R = W:AddTab("Raid","http://www.roblox.com/asset/?id=6031229361") 
local raid = R:AddSection("Raid Farm")

    --raid farm 
raid:AddSwitch("Auto Raid",false,function (v)
    setting.Raid =  v
    spawn(function ()
        while  wait() do
            if setting.Raid then
                pcall(function ()
                    autoraid()
                end)
            end
        end
    end)
end)

raid:AddSwitch("Kill All",false,function (v)
    setting.KillAll = v 
    spawn(function ()
        while  wait() do
            if setting.KillAll then
                pcall(function ()
                    killall()
                end)
            end
        end
    end)
end)

raid:AddButton("Room",function ()
    tp(CFrame.new(-6.43873535e3, 250.619553, -4.50150684e3))
end)

-- auto raid script 
spawn(function()
    while wait() do
        if setting.Raid then
            pcall(function()            
                        for i,v in pairs(game:GetService("Workspace").Map.RaidMap:GetDescendants()) do
                            if v.Name == "RaidIsland1"  then
                        
                                LocalPlayer.Character.HumanoidRootPart.CFrame = v.EnemySpawner.CFrame *  CFrame.new(0,100,0)
                            end
                        end

    
                            for i2,v2 in pairs(game:GetService("Workspace").Map.RaidMap:GetDescendants()) do
                                if v2.Name == "RaidIsland2"  then
                               
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = v2.EnemySpawner.CFrame *  CFrame.new(0,100,0)
                                end 
                            end
                                 --   island = 2
                     
                            for i3,v3 in pairs(game:GetService("Workspace").Map.RaidMap:GetDescendants()) do
                                if v3.Name == "RaidIsland3" then
                            
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = v3.EnemySpawner.CFrame*  CFrame.new(0,100,0)
                                end
                            end
                                --    island = 3
                          
                           
                            for i4,v4 in pairs(game:GetService("Workspace").Map.RaidMap:GetDescendants()) do
                                if v4.Name == "RaidIsland4"  then
                       
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = v4.EnemySpawner.CFrame*  CFrame.new(0,100,0)
                                end
                            end
                               --     island = 4
                         

                            for i5,v5 in pairs(game:GetService("Workspace").Map.RaidMap:GetDescendants()) do
                                if v5.Name == "RaidIsland5"  then
                       
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = v5.EnemySpawner.CFrame*  CFrame.new(0,100,0)
                                end
                            end
                               --     island = 4
                       
                            for i6 , v6 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                                if v6.Name == "Mysterious Entity" then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener","Awaken")
                                else
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Teleport")

                                end
                                    end
         
                end)
            end
        end
    end)	
    
spawn(function ( )
    while  wait() do
        if setting.Raid then
            pcall(function ()
                autokillall()
            end)
        end
    end
end)

-- Show Hitbox -- 
spawn(function()
    while wait() do
        if setting.HideBox then
            pcall(function ()
                for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v.Name == _G.mobs then
                        v.HumanoidRootPart.Transparency =  setting.HideBox
                        v.HumanoidRootPart.Color = _G.ColorPlayers
                    end
                end
            end)
        end
    end
end)

-- Show Hitbox Players
spawn(function()
    while wait() do
        if setting.HideBox2 then
            pcall(function()
                for i, v in pairs(game:GetService"Players":GetPlayers()) do
                    if v.Name ~= game:GetService"Players".LocalPlayer.Name then
                        v.Character.HumanoidRootPart.Color = _G.ColorPlayers2
                        v.Character.HumanoidRootPart.Transparency = setting.HideBox2
                        v.Character.HumanoidRootPart.CanCollide = false
                    end
                end
            end)
        end
    end
end)
end







end


--anime Mania 
function Anime()
	
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(name, ...)
    if tostring(getnamecallmethod()):lower() == "kick" then
        return
    elseif getnamecallmethod() == "FireServer" and tostring(name) == "Ban" then
        return
    end
return old(name, ...)
end)



repeat wait() until game.Loaded
local plr = game:service'Players'.LocalPlayer

local setting = {
    farm = false;
    skill = false;
    destants = -7 ;
}		



local VLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/BunnySalf/Pls-Don-t-Crack-me-Pls/main/Polar.Don't.Crack.Me")()
local W = VLib:AddWindow("MHEEHUB")
local m1 = W:AddTab("Auto Farm", "http://www.roblox.com/asset/?id=6031302950")

local b = m1:AddSection("Auto Farm")


local count =  b:AddLabel("Wave Count")
spawn(function()
    while true  do wait()
        count:Re(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Wave.Text)
    end
end)

if game.PlaceId == 6284881984 then 
local listroom = {}
for i , v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Matchmaking.MatchmakingFrame.CreateFrame.Maruto:GetDescendants()) do 
    if v.Name == "LocationName" and not string.match(v.Text ,"Name") then 
            table.insert(listroom, v.Text)
         end
    end
local listre =  b:AddDropdown("List Room",listroom,function(var)
        _G.listroomxd = var
    end)   
b:AddButton("Refesh Room",function()
    listre:Clear()
    for i , v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Matchmaking.MatchmakingFrame.CreateFrame.Maruto:GetDescendants()) do 
        if v.Name == "LocationName" and not string.match(v.Text ,"Name") then 
                table.insert(listroom, v.Text)
			listre:Add(v.Text)
		end
	end
end)

end
b:AddSwitch("Auto Farm",false,function(var)
    setting.farm = var  
end)

b:AddSwitch("Auto Skills",false,function(var)
    setting.skill = var
end)

b:AddSlider("Destants",20,-20,function(var)
    setting.destants = tonumber(var)
end)

b:AddButton("Use All Code ",function()
    code()
end)

function autoskills()
game:GetService("Players").LocalPlayer.Backpack.Input.Remote:FireServer({"Skill","1"})
    game:GetService("Players").LocalPlayer.Backpack.Input.Remote:FireServer({"Skill","2"})
        game:GetService("Players").LocalPlayer.Backpack.Input.Remote:FireServer({"Skill","3"})
            game:GetService("Players").LocalPlayer.Backpack.Input.Remote:FireServer({"Skill","4"})
end

function	warpmon(Onemob)
    for i, v in pairs( game:GetService("Workspace").Living:GetChildren()) do
        if v.Name ~= game:GetService"Players".LocalPlayer.Name and v:FindFirstChild("Status") and v.Humanoid.Health > 0   then
            if v.Humanoid.Health > 0 then 
                    v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                            v.HumanoidRootPart.CFrame = Onemob
           	    end
            end
        end
end


function autofarm()
    if game.PlaceId == 6284881984 then
    game:GetService("ReplicatedStorage").Remotes.CreateRoom:InvokeServer(_G.listroomxd,"")
    game:GetService("ReplicatedStorage").Remotes.BeginRoom:FireServer()
        for i = 1, 20 do
            i = i + 1
            wait(1)
            if i == 20 then
                game:GetService("ReplicatedStorage").Remotes.CreateRoom:InvokeServer(_G.listroomxd,"")
                game:GetService("ReplicatedStorage").Remotes.BeginRoom:FireServer()
            end
        end
    elseif game.PlaceId == 6314042276  then
    local Liveing = game:GetService("Workspace").Living
    for i , v in pairs(Liveing:GetChildren()) do 
        if v.Name ~= game:GetService"Players".LocalPlayer.Name and v:FindFirstChild("Status") and v.Humanoid.Health > 0   then
            repeat wait()
            setsimulationradius(10000000,10000000)  
      --      warpmon(v.HumanoidRootPart.CFrame )     
            plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, setting.destants , 0)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
            until v.Humanoid.Health == 0 or not setting.farm
                end
            end
        end
end

spawn(function()
    while  wait() do
        if setting.farm then
            pcall(function()
                local Liveing = game:GetService("Workspace").Living
                for i , v in pairs(Liveing:GetChildren()) do 
                    if v.Name ~= game:GetService"Players".LocalPlayer.Name and v:FindFirstChild("Status") and v.Humanoid.Health > 0   then
                        if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <= 15 then  
                            plr.Backpack.Input.Remote:FireServer({'Light'})   
                        end
                    end
                end
            end)
        end
    end
end)

spawn(function ()
    while  wait() do
        if setting.farm then 
            pcall(function()
                autofarm()
            end)
        end
    end
end)

spawn(function()
    while  wait() do
        if setting.skill then 
            pcall(function()
                autoskills()
            end)
        end
    end
end)



game:GetService("RunService").RenderStepped:Connect(function()
   if setting.farm then 
    plr.Character.Humanoid:ChangeState(11)
   end
end)
 
function code()

game:GetService("ReplicatedStorage").Remotes.SubmitCode:InvokeServer("Dessi")
game:GetService("ReplicatedStorage").Remotes.SubmitCode:InvokeServer("Aricku")
game:GetService("ReplicatedStorage").Remotes.SubmitCode:InvokeServer("SPGBlackStar")
game:GetService("ReplicatedStorage").Remotes.SubmitCode:InvokeServer("IFOLLOWEDYOU")
game:GetService("ReplicatedStorage").Remotes.SubmitCode:InvokeServer("REAPER?")
	end
end


function Millennium()

local plr = game:GetService("Players").LocalPlayer

function click()     

    local table_1 = {
        ["Mobs"] = {
            [1] = 'Village Bandit'
        },
        ["Animation"] = 'Animation',
        ["Player"] = 'MheeX7',
        ["Speed"] = 1,
        ["ID"] = 26503394,
        ["Complete"] = {
            ["fire"] = 'function: 0x00000000db7c1c5e',
            ["wait"] = 'function: 0x000000005481c10e',
            ["connect"] = 'function: 0x000000009ac6ffa6'
        },
        ["State"] = 'Running',
        ["Arguments"] = {
    
        },
        ["Name"] = 'PunchLMB1',
        ["Replication"] = {
    
        },
        ["Input"] = 'LMB',
        ["Length"] = 1,
        ["Cancelled"] = {
            ["fire"] = 'function: 0x00000000e542b3b6',
            ["wait"] = 'function: 0x00000000e6b92916',
            ["connect"] = 'function: 0x00000000960fa67e'
        },
        ["Time"] = 1616707056.9912
    };
    local Target = game:GetService("ReplicatedStorage").Core.Combat.CombatController;
    Target:FireServer(table_1);   

end

function remotequest()
    local table_1 = {
        ["Type"] = 'Quest',
        ["ID"] =  'Level'..tostring(_G.NPC)..'Quest',
        ["MinimumLevel"] = 1,
        ["Job"] = 'AcceptDialogue'
    };
    local Target = game:GetService("ReplicatedStorage").Remotes.ClientE;
    Target:FireServer(table_1);    
end




function equip()
		local tool = plr:WaitForChild"Backpack":FindFirstChild( _G.weapon )
		wait()
		plr.Character.Humanoid:EquipTool(tool)
end

local VLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/BunnySalf/Hentai/main/Light%20haha")()
local W = VLib:AddWindow("MHEEHUB")
local m1 = W:AddTab("Auto Farm", "http://www.roblox.com/asset/?id=6031302950")

local b = m1:AddSection("Auto Farm")
local b2 = m1:AddSection("Auto Stats")

local Flags = {
    autofarm = false;
    aura = false ;
    fruitscoo = false ;
    tp = 2000;
}

local tween
    function toTarget(pos, targetPos, targetCFrame)
        local tween_s = game:service"TweenService"
        local info = TweenInfo.new((targetPos - pos).Magnitude/Flags.tp, Enum.EasingStyle.Quad)
        local tic_k = tick()
        local tween, err = pcall(function()
            tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = targetCFrame})
                tween:Play()
        end)
        if not tween then return err end
    end

local weaponlist = {} 
for i , v in pairs(plr.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        table.insert(weaponlist ,v.Name )
    end
end
local drop =  b:AddDropdown("Select Weapons",weaponlist,function(key)
    _G.weapon = key 
  
end)

b:AddButton("Refesh",function ()
    drop:Clear()
for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" then
            drop:Add(v.Name)
        end
    end
end)

b:AddSwitch("Auto Level Farm",false,function(key)
    Flags.autofarm = key
end)

b:AddSlider("Speed Tp",2000,5000,function(key)
    Flags.tp = key 
end)

b:AddSwitch("Kill Aura (Puch)",false,function(key)
    Flags.aura = key
end)

b:AddSwitch("Auto Collect Fruits",false,function(key)
    Flags.fruitscoo = key
    spawn(function()
        while wait() do
            if Flags.fruitscoo then
                for _,v in next, game:GetService("Workspace"):GetChildren() do
                    if v:IsA("Tool") then
                            v.Handle.CFrame  =  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
                    end
                end
            end
        end
    end)
end) 



local poss = b2:AddLabel("Point : "..game:GetService("Players").LocalPlayer.PlayerValues.AttributePoints.Value)
spawn(function()
    while true do wait()
        pcall(function()
            poss:Re("Point : "..game:GetService("Players").LocalPlayer.PlayerValues.AttributePoints.Value)
        end)
    end
end)


b2:AddSwitch("Strength",false,function(key)
    _G.Streng = key
end)

b2:AddSwitch("Sword",false,function(key)
    _G.Sword = key
end)

b2:AddSwitch("Endurance",false,function(key)
    _G.Endurance = key
end)

b2:AddSwitch("Gun",false,function(key)
    _G.Gun = key
end)

b2:AddSwitch("DevilFruits",false,function(key)
    _G.DevilFruits = key
end)



function check()
    for i , v in pairs(plr.PlayerValues:GetChildren()) do 
        if v.Name == "Level" then 
            local lvl = v.Value
            if lvl > 1 and lvl < 15 then
                _G.NPC = 1
            elseif lvl  >= 15 and lvl < 35 then 
                _G.NPC = 15
            elseif lvl  >= 35 and lvl < 45 then 
                _G.NPC = 35
            elseif lvl  >= 45 and lvl < 75 then 
                _G.NPC =  45
            elseif lvl  >= 75 and lvl < 100 then 
                _G.NPC =  75
            elseif lvl  >= 100 and lvl < 160 then 
                _G.NPC =  100
            elseif lvl  >= 160 and lvl < 210 then 
                _G.NPC =  160
            elseif lvl  >= 210 and lvl < 250 then 
                _G.NPC =  210
            elseif lvl  >= 250 and lvl < 260 then 
                _G.NPC =  250
            elseif lvl  >= 350 and lvl < 480 then 
                _G.NPC =  350
            elseif lvl  >= 480 and lvl < math.huge then 
                _G.NPC =  480
            end
        end
    end
end 

function farm()
    pcall(function ()
    check()
    if plr.PlayerGui.Interface.QuestUpdater.Visible ==  false then
        remotequest()
    elseif plr.PlayerGui.Interface.QuestUpdater.Visible then
        for i2 , v2 in pairs(plr.PlayerValues.Quests:GetDescendants()) do
            if v2.Name == "QuestContributors" then
                  namex = v2.Value
            for i,  v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
                if v.Name ==  namex then
                    if v.Humanoid.Health > 0 then         
                    repeat wait()
                        toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,0,3)  )       
                        plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
                        if ( plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position ).magnitude <= 10 then 
                            if Flags.aura then
                                equip()
                            click()
                            end
                        end
                    until v.Humanoid.Health == 0 or not Flags.autofarm or  plr.PlayerGui.Interface.QuestUpdater.Visible ==  false
                            end
                        end
                    end
                end 
            end
        end        
    end)
end




spawn(function()
    while wait() do 
        if  Flags.autofarm then
            farm()
        end
    end
end)


game:GetService('RunService').Stepped:connect(function()
    if  Flags.autofarm then
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end)
    end
end)

--auto stats 
spawn(function()
    while wait() do 
        pcall(function()
            if _G.Streng then
local args = {
    [1] = {
        ["Value"] = 1,
        ["Name"] = "Strength",
        ["Job"] = "UpgradeAttribute"
    }
}
game:GetService("ReplicatedStorage").Remotes.ClientE:FireServer(unpack(args))
            elseif  _G.Sword then                 
local args = {
    [1] = {
        ["Value"] = 1,
        ["Name"] = "Sword",
        ["Job"] = "UpgradeAttribute"
    }
}

game:GetService("ReplicatedStorage").Remotes.ClientE:FireServer(unpack(args))

            elseif   _G.Endurance  then    
local args = {
    [1] = {
        ["Value"] = 1,
        ["Name"] = "Endurance",
        ["Job"] = "UpgradeAttribute"
    }
}

game:GetService("ReplicatedStorage").Remotes.ClientE:FireServer(unpack(args))

            elseif   _G.Gun  then         
local args = {
    [1] = {
        ["Value"] = 1,
        ["Name"] = "Gun",
        ["Job"] = "UpgradeAttribute"
    }
}

game:GetService("ReplicatedStorage").Remotes.ClientE:FireServer(unpack(args))

            elseif _G.DevilFruit then
local args = {
    [1] = {
        ["Value"] = 1,
        ["Name"] = "DevilFruit",
        ["Job"] = "UpgradeAttribute"
    }
}

game:GetService("ReplicatedStorage").Remotes.ClientE:FireServer(unpack(args))


            end
        end)
    end
end)

end

function arsanel()
	


    local plr = game:service'Players'.LocalPlayer
    
    
    local a = {
        enabled = false;
        wallcheck = false ;
        freeforall = false ;
        radius = false ;
        Xray = false ;
        spawns = false ; 
        killall == false;
    }
    
    local players = game:GetService("Players")
    local client = players.LocalPlayer
    local inputservice = game:GetService("UserInputService")
    local mouse = client:GetMouse()
    local runservice = game:GetService("RunService")
    local aim = false
    
    function GetMouse()
        return Vector2.new(mouse.X, mouse.Y)
    end
    
    inputservice.InputBegan:Connect(function(key)
        if key.UserInputType == Enum.UserInputType.MouseButton2 then
            aim = true
        end
    end)
    
    inputservice.InputEnded:Connect(function(key)
        if key.UserInputType == Enum.UserInputType.MouseButton2 then
            aim = false
        end
    end)
    

    function FreeForAll(targetplayer)
        if a.freeforall == false then
            if client.Team == targetplayer.Team then return false
            else return true end
        else return true end
    end
    
    function NotObstructing(destination, ignore)
        if a.wallcheck then
            Origin = workspace.CurrentCamera.CFrame.p
            CheckRay = Ray.new(Origin, destination- Origin)
            Hit = workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
            return Hit == nil
        else
            return true
        end
    end
    
    function GetClosestToCuror()
        MousePos = GetMouse()
        Radius = a.radius
        Closest = math.huge
        Target = nil
        for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if FreeForAll(v) then
                if v.Character:FindFirstChild("Head") and v ~= game.Players.LocalPlayer then
                    Point,OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.Head.Position)
                    clientchar = client.Character
                    if OnScreen and NotObstructing(v.Character.Head.Position,{clientchar,v.Character}) then
                        Distance = (Vector2.new(Point.X,Point.Y) - MousePos).magnitude
                        if Distance < math.min(Radius,Closest) then
                            Closest = Distance
                            Target = v
                        end
                    end
                end
            end
        end
        return Target
    end 
    
    runservice.RenderStepped:Connect(function()
        if a.enabled == false or aim == false then return end
        ClosestPlayer = GetClosestToCuror()
        if ClosestPlayer then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,ClosestPlayer.Character.Head.CFrame.p)
        end
    end)


    
    local VLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/BunnySalf/Pls-Don-t-Crack-me-Pls/main/Polar.Don't.Crack.Me")()

    local W = VLib:AddWindow("MHEEHUB")

    local m1 = W:AddTab("Auto Farm", "http://www.roblox.com/asset/?id=6031302950")

    local b = m1:AddSection("Aim Bot","http://www.roblox.com/asset/?id=6023426915")
    local b2 = m1:AddSection("ESP","http://www.roblox.com/asset/?id=6023426915")

    -- Aimbot -- 
    local  circle = Drawing.new("Circle")
    b:AddSwitch("Aimbot ",false, function(t)
        a.enabled = t 
        spawn(function()
            pcall(function()
                while  wait() do
                if a.enabled then   
                    circle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
                    circle.Color = Color3.fromRGB(240, 240, 240)
                    circle.Thickness = 2
                    circle.NumSides = 500
                    circle.Radius =  a.radius
                    circle.Visible = true
                    circle.Filled = false   
            
    
                elseif  a.enabled == false  then
                         circle.Visible = false
                
        end
    end
            end) 
        end)
    end)
 

    a.radius = 50 
    b:AddSlider("FOV Circle",50,1000,function(t)
        a.radius = tonumber(t)
    end)

    b:AddSwitch("Kill All",false,function (t)
           a.killall = t 
           spawn(function ()
               while  wait() do
                   if a.killall then
                       pcall(function ()
                        Kill()
                       end)
                   end
               end
           end)
    end)


    
    b:AddSwitch("Xray", false,function(t)
        a.Xray = t 
        spawn(function()
            if a.Xray then
                for i,v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and not v.Parent.Parent:FindFirstChild("Humanoid") then
                        v.Transparency = v.Transparency + 0.5
                    end
                end
            else
                for i,v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and not v.Parent.Parent:FindFirstChild("Humanoid") then
                        v.Transparency = v.Transparency - 0.5
                    end
                end
            end
        end)
    end)
    
    b:AddSwitch("Fast Respawn",false,function(bool)
        a.spawns = bool
        spawn(function()
            while  wait() do
            if a.spawns then 
                pcall(function()
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Cam") then
                    game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()
                    end 
                end)
                end
            end
        end)
    end)
    
    local b5 = b:AddFolder("Misc") 
    b5:AddSwitch("Auto Deploy",false,function (t)
        getgenv().Deploy = t
        spawn(function ()
            while  wait() do
                if Deploy then
                    pcall(function ()
                    if not game:GetService("Workspace"):FindFirstChild(plr.Name) then
                            game:GetService("ReplicatedStorage").Events.SpawnMe:FireServer()
                    end            
                end)
                end
            end
        end)
    end)

    b5:AddSwitch("Auto Farm",false,function (t)
        getgenv().Autofarm = t
        spawn(function ()
            while  wait() do
                if Autofarm then
                   pcall(function ()
                        Kill()
                        checkname()
                   end)
                end
            end
        end)
    end)

    b5:AddButton("Rejoin Sever",function ()
        game:GetService("TeleportService"):Teleport(286090429, plr) 
    end)

    -- ESP -- 
    local e = {
        enabled = false ;
        Tracers = false ;
        Distance = false ; 
        NAME = false ; 
    }
    
    
    pcall(function()
        
        Camera = game:GetService("Workspace").CurrentCamera
        RunService = game:GetService("RunService")
        camera = workspace.CurrentCamera
        Bottom = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
    
        function GetPoint(vector3)
            local vector, onScreen = camera:WorldToScreenPoint(vector3)
            return {Vector2.new(vector.X,vector.Y),onScreen,vector.Z}
        end
        
        function MakeESP(model)
            local CurrentParent = model.Parent
        
            local TopL = Drawing.new("Line")
            local BottomL = Drawing.new("Line")
            local LeftL = Drawing.new("Line")
            local RightL = Drawing.new("Line")
            local Tracer = Drawing.new("Line")
            local Display = Drawing.new("Text")
    
            coroutine.resume(coroutine.create(function()
                while model.Parent == CurrentParent do
                    
                    local Distance = (Camera.CFrame.Position - model.HumanoidRootPart.Position).Magnitude
                    local GetP = GetPoint(model.Head.Position)
                    local headps = model.Head.CFrame
                    
                    if e.enabled and GetP[2] then
                        
                        -- Calculate Cords
                        local topright = headps * CFrame.new(3,0.5, 0)
                        local topleft = headps * CFrame.new(-3,0.5, 0)
                        local bottomleft = headps * CFrame.new(-3,-7,0)
                        local bottomright = headps * CFrame.new(3,-7,0)
                        topright = GetPoint(topright.p)[1]
                        topleft = GetPoint(topleft.p)[1]
                        bottomleft = GetPoint(bottomleft.p)[1]
                        bottomright = GetPoint(bottomright.p)[1]
    
                        local teamcolor = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
                        TopL.Color, BottomL.Color, RightL.Color, LeftL.Color = teamcolor, teamcolor, teamcolor, teamcolor
                        TopL.From, BottomL.From, RightL.From, LeftL.From = topleft, bottomleft, topright, topleft
                        TopL.To, BottomL.To, RightL.To, LeftL.To = topright, bottomright, bottomright, bottomleft
                        TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = true, true, true, true
                    else
                        TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible = false, false, false, false
                    end
                    
                    if e.enabled and e.Tracers and GetP[2] then
                        Tracer.Color = game:GetService("Players")[model.Name].TeamColor.Color or Color3.fromRGB(0,0,0)
                        Tracer.From = Bottom
                        Tracer.To = GetPoint(headps.p)[1]
                        Tracer.Thickness = 1.5
                        Tracer.Visible = true
                    else
                        Tracer.Visible = false
                    end
                    
                    if e.enabled and  e.Distance and GetP[2] then
                        Display.Visible = true
                        Display.Position = GetPoint(headps.p + Vector3.new(0,0.5,0))[1]
                        Display.Center = true
                        Display.Text = tostring(math.floor(Distance)).." studs"
                    else
                        Display.Visible = false
                    end
                    
                    RunService.RenderStepped:Wait()
                end
        
                TopL:Remove()
                BottomL:Remove()
                RightL:Remove()
                LeftL:Remove()
                Tracer:Remove()
                Display:Remove()
            
            end))
        end
        
        for _, Player in next, game:GetService("Players"):GetChildren() do
            if Player.Name ~= game.Players.LocalPlayer.Name then
                MakeESP(Player.Character)
                Player.CharacterAdded:Connect(function()
                    delay(0.5, function()
                        MakeESP(Player.Character)
                    end)
                end)
            end	
        end
        
        game:GetService("Players").PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                delay(0.5, function()
                    MakeESP(player.Character)
                end)
            end)
        end)
        
    end)
    
    
    b2:AddSwitch("Enabled ", false,function(t)
        e.enabled = t 
    end)
    
    b2:AddSwitch("Tracers",false, function(t)
        e.Tracers = t 
    end)
    
    b2:AddSwitch("Distance Players", false,function(t)
        e.Distance = t 
    end)
    
    b2:AddSwitch("Name Player", false,function(t)
        e.NAME = t 
        spawn(function()
            wait()
            if e.NAME == true then
                local Holder = Instance.new("Folder", game.CoreGui)
                Holder.Name = "ESP"
                local Box = Instance.new"BoxHandleAdornment"
                Box.Name = "nilBox"
                Box.Size = Vector3.new(4, 7, 4)
                Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
                Box.Transparency = 1e3
                Box.ZIndex = 0
                Box.AlwaysOnTop = false
                Box.Visible = false
                local NameTag = Instance.new"BillboardGui"
                NameTag.Name = "nilNameTag"
                NameTag.Enabled = false
                NameTag.Size = UDim2.new(0, 200, 0, 50)
                NameTag.AlwaysOnTop = true
                NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
                local Tag = Instance.new("TextLabel", NameTag)
                Tag.Name = "Tag"
                Tag.BackgroundTransparency = 1
                Tag.Position = UDim2.new(0, -50, 0, 0)
                Tag.Size = UDim2.new(0, 300, 0, 20)
                Tag.TextSize = 20
                Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
                Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
                Tag.TextStrokeTransparency = 0.4
                Tag.Text = "nil"
                Tag.Font = Enum.Font.SourceSansBold
                Tag.TextScaled = false
                local LoadCharacter = function(v)
                    repeat wait() until v.Character ~= nil
                    v.Character:WaitForChild"Humanoid"
                    local vHolder = Holder:FindFirstChild(v.Name)
                    vHolder:ClearAllChildren()
                    local b = Box:Clone()
                    b.Name = v.Name .. "Box"
                    b.Adornee = v.Character
                    b.Parent = vHolder
                    local t = NameTag:Clone()
                    t.Name = v.Name .. "NameTag"
                    t.Enabled = true
                    t.Parent = vHolder
                    t.Adornee = v.Character:WaitForChild("Head", 5)
                    if not t.Adornee then return UnloadCharacter(v) end
                    t.Tag.Text = v.Name
                    b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                    t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                    local Update
                    local UpdateNameTag = function()
                        if not pcall(function()
                            v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                            t.Tag.Text = v.Name .. "\n" .. (maxh ~= 0 and tostring(math.floor(h / maxh * 100)) or "0") .. "%  " .. tostring(h) .. "/" .. tostring(maxh)
                        end) then Update:Disconnect() end
                    end
                    UpdateNameTag()
                    Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
                end
                local UnloadCharacter = function(v)
                    local vHolder = Holder:FindFirstChild(v.Name)
                    if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then vHolder:ClearAllChildren() end
                end
                local LoadPlayer = function(v)
                    local vHolder = Instance.new("Folder", Holder)
                    vHolder.Name = v.Name
                    v.CharacterAdded:Connect(function() pcall(LoadCharacter, v) end)
                    v.CharacterRemoving:Connect(function() pcall(UnloadCharacter, v) end)
                    v.Changed:Connect(function(prop)
                        if prop == "TeamColor" then
                            UnloadCharacter(v)
                            wait()
                            LoadCharacter(v)
                        end
                    end)
                    LoadCharacter(v)
                end
                local UnloadPlayer = function(v)
                    UnloadCharacter(v)
                    local vHolder = Holder:FindFirstChild(v.Name)
                    if vHolder then vHolder:Destroy() end
                end
                for i, v in pairs(game:GetService"Players":GetPlayers()) do spawn(function() pcall(LoadPlayer, v) end) end
                game:GetService"Players".PlayerAdded:Connect(function(v) pcall(LoadPlayer, v) end)
                game:GetService"Players".PlayerRemoving:Connect(function(v) pcall(UnloadPlayer, v) end)
                game:GetService"Players".LocalPlayer.NameDisplayDistance = 0
            else pcall(function() game.CoreGui.ESP:Remove() end) end
        end)
    end)
    
    -- Gun Mods -- 
    local g = {
        NoRecoilVar = false ;
        InfAmmoVar = false ; 
        AutomaticModeVar = false ;
        NoSpreadVar = false ; 
        wallbangenabled = false ; 
        Gun = false ; 
        Hand = false ; 
        Projectile = false ; 
    }
    
    
    local gm = getrawmetatable(game)            -- gets metatable of game
    setreadonly(gm,false)                       -- Makes it writable
    local OldIndex = gm.__index                 -- Save old index so we can return it if condition is not met
    gm.__index = newcclosure(function(self,i)   -- Make new index method with a C function making it undetectable
        if i == "Clips" and e.wallbangenabled then                    -- Check if index was clips meaning thats the ammo we want to spoof
            return workspace.Map                -- Then we just return workspace.map so that the bullet doesnt stop when it comes in contact
        end
        return OldIndex(self,i)                 -- If its not met we just return old index we saved
    end)
    
    local a
    local b
    for i,v in next, getgc() do
      if (type(v) == 'function') and (debug.getinfo(v).name == 'firebullet') then
         a = getfenv(v);
         b = v
      end
    end
    
    game:GetService("RunService").Heartbeat:Connect(function()
        if e.InfAmmoVar then
            debug.setupvalue(b,5,420)
        end
        if e.InfAmmoVar or e.NoRecoilVar or e.AutomaticModeVar or e.AutomaticModeVar then
            a.DISABLED = false
            a.DISABLED2 = false
        end
        if e.NoRecoilVar then
            a.currentspread = 0
        end
        if e.NoRecoilVar then
            a.recoil = 0
        end
        if e.AutomaticModeVar then
            a.mode = "automatic"
        end
    end)
    
    local b3 = b2:AddFolder("Gun Mod")
    
--[[
        b3:AddSwitch("WallBang", function(t)
        e.wallbangenabled = t 
    end)
]]
    
    b3:AddSwitch("No Recoil", false,function(t)
        e.NoRecoilVar = t 
    end)
    
    b3:AddSwitch("Inf Ammo",false, function(t)
        e.InfAmmoVar = t 
    end)
    
--[[
    b3:AddSwitch("Automatic", function(t)
        e.AutomaticModeVar = t 
    end)

]]
    
    b3:AddSwitch("No Spread",false,function(t)
        e.NoSpreadVar = t 
    end)
    
    
    b3:AddSwitch("Rainbow Gun",false,function(bool)
        e.Gun = bool
    end)
    
    b3:AddSwitch("Rainbow Hand",false,function(bool)
        e.Hand  = bool
    end)
    
    b3:AddSwitch("Rainbow Projectile",false,function(bool)
        e.Projectile = bool
    end)
    

    -- Rainbow Gub 
    counter = 0
    function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
    spawn(function()
        while  wait() do
            pcall(function()
            if e.Gun then 
                    for i,v in pairs(game:GetService("Workspace").Camera.Arms:GetDescendants()) do
                        if v:IsA("MeshPart") then
                            v.Color = Color3.fromHSV(zigzag(counter),1,1)
                            counter = counter + 0.0009
                        end
                    end
                end
                if e.Han then
                    for i,v in pairs(game:GetService("Workspace").Camera.Arms:GetDescendants()) do
                    if v:IsA("Part") then
                        v.Color = Color3.fromHSV(zigzag(counter),1,1)
                        counter = counter + 0.0009
                        end
                    end
                end
                if e.Projectile  then
                    for i,v in pairs(game:GetService("Workspace")["Ray_Ignore"]:GetDescendants()) do
                        if v:IsA("MeshPart") then
                            v.Color = Color3.fromHSV(zigzag(counter),1,1)
                            counter = counter + 0.0009
                        end
                        if v:IsA("Part") then
                            v.Color = Color3.fromHSV(zigzag(counter),1,1)
                            counter = counter + 0.0009
                        end
                    end
                end
            end)
            end
    end)
    
    function noclip() game:GetService"Players".LocalPlayer.Character.Humanoid:ChangeState(11) end    

function Kill()
        local Gun = game.ReplicatedStorage.Weapons:FindFirstChild(game.Players.LocalPlayer.NRPBS.EquippedTool.Value);
        local Crit = math.random() > .6 and true or false;
            for i,v in pairs(game.Players:GetPlayers()) do
                if v and v.Character and v.Character:FindFirstChild("Head") then
                    local Distance = (game.Players.LocalPlayer.Character.Head.Position - v.Character.Head.Position).magnitude
                for i  = 1,10 do wait()
                    game.ReplicatedStorage.Events.HitPart:FireServer(v.Character.Head,
                    v.Character.Head.Position + Vector3.new(math.random(), math.random(), math.random()),
                    Gun.Name,
                    Crit and 2 or 1,
                    Distance,
                    Backstab,
                    Crit,
                    false,
                    1,
                    false,
                    Gun.FireRate.Value,
                    Gun.ReloadTime.Value,
                    Gun.Ammo.Value,
                    Gun.StoredAmmo.Value,
                    Gun.Bullets.Value,
                    Gun.EquipTime.Value,
                    Gun.RecoilControl.Value,
                    Gun.Auto.Value,
                    Gun['Speed%'].Value,
                    game.ReplicatedStorage.wkspc.DistributedTime.Value);
            end
        end
    end
end

function checkname()
    if not game:GetService("Workspace"):FindFirstChild(plr.Name) then
        game:GetService("ReplicatedStorage").Events.SpawnMe:FireServer()
    end         
end

--[[
    b:AddSwitch("Kill All",function (t)
           a.killall = t 
           spawn(function ()
               while  wait() do
                   if a.killall then
                       pcall(function ()
                        game:GetService("Players").LocalPlayer:GetMouse().KeyDown:connect(function(k)
                            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                                if v.Character then
                                    if v.Team ~= game:GetService("Players").LocalPlayer.Team then
                                        if v ~= game:GetService("Players").LocalPlayer then
                                             repeat wait()
                                                v.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.Head.CFrame * CFrame.new(0,0,-5)
                                                getsenv(game:GetService("Players").LocalPlayer["PlayerGui"]["GUI"]["Client"]).firebullet()
                                            
                                        
                                             until  not a.killall       
                                            end            
                                    end
                                end
                            end
                         end)
                       end)
                   end
               end
           end)
    end)

]]
--[[
	function Kill()
        local Gun = game.ReplicatedStorage.Weapons:FindFirstChild(game.Players.LocalPlayer.NRPBS.EquippedTool.Value);
        local Crit = math.random() > .6 and true or false;
            for i,v in pairs(game.Players:GetPlayers()) do
                if v and v.Character and v.Character:FindFirstChild("Head") then
                    local Distance = (game.Players.LocalPlayer.Character.Head.Position - v.Character.Head.Position).magnitude
                repeat
					wait()
                    game.ReplicatedStorage.Events.HitPart:FireServer(v.Character.Head,
                    v.Character.Head.Position + Vector3.new(math.random(), math.random(), math.random()),
                    Gun.Name,
                    Crit and 2 or 1,
                    Distance,
                    Backstab,
                    Crit,
                    false,
                    1,
                    false,
                    Gun.FireRate.Value,
                    Gun.ReloadTime.Value,
                    Gun.Ammo.Value,
                    Gun.StoredAmmo.Value,
                    Gun.Bullets.Value,
                    Gun.EquipTime.Value,
                    Gun.RecoilControl.Value,
                    Gun.Auto.Value,
                    Gun['Speed%'].Value,
                    game.ReplicatedStorage.wkspc.DistributedTime.Value);
							
				until not a.killall or not  Autofarm
            
        end
    end
end
]]
end


function gpo()
    
if  game:GetService("Players").LocalPlayer.PlayerGui.HUD.Verson.Text == "Version 3.69" then 

    game:GetService"Players".LocalPlayer.Idled:Connect(function()
        game:GetService"VirtualUser":CaptureController()
        game:GetService"VirtualUser":ClickButton2(Vector2.new())
    end)
    
    local plr = game:GetService("Players").LocalPlayer
    local checklocal  = "Stats"..game.Players.LocalPlayer.Name
    local checklvl = game:GetService("ReplicatedStorage")[checklocal].Stats.Level.Value
    local checkspawn = game:GetService("ReplicatedStorage")[checklocal].Stats.SpawnPoint.Value
    local f = {
        autofarm = false; 
        Puch = false;
        distantsxd = 5 ; 
        Block = false ; 
        Punch = false ; 
        weapons = nil ; 
        high = 20 ; 
        distants =  5 ; 
        Strength =  false ; 
        Stamina = false  ;
        Defense = false ; 
        GunMastery = false ; 
        SwordMastery = false ; 
        Set = false ; 
        FallDel = false ; 
        FallDamge = false ; 
        selectisland = nil ; 
        tpisland = false ; 
        spawnboat = false ; 
        selecttype = false ;
        shipfarm = false ; 
        Dungeon = false ; 
        HughhDungeon = false;
        Reset = false ;
        Speddisland = false ; 
        buso = false ; 
        antiow = false 

    }
    -- setting farm 
    local sf =  {
        selecttype = nil ; 
        high = 0 ; 
        distants =  0 
    }
    
    
    -- Get Mon
    local GetMon = {}
    local GetWeapon = {}
    local GetQuest = {}
    local questCFrame 
    local argone 
    local argtwo
    local name
    local mob2
    local j 
    local mob 
    local npctool
    local Enemies = {}
    local SecondCFrame
    local town 
    f.weapons = "Melee"
    f.high = 0
    f.distants = 0 
    sf.selecttype = "Melee"
    f.HughhDungeon = 50
    f.Speddisland = 80
    
    for i , v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            table.insert( GetWeapon, v.Name )
        end
    end
    
    
    
    
    
    -- defaults stats 
    local function defaultstats()
        local taget = nil 
        for i , v in pairs(game:GetService("ReplicatedStorage")[checklocal].Stats:GetChildren()) do 
            if v.Name == "SkillPoints" then
                taget = v.Value
            end
        end
        return taget 
    end
    
--bypass
    for i,v in next, getgc() do 
        if type(v) == 'function' and getfenv(v).script == game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('MeleeScript') then
                if  pcall(function() getconstant(v, 75) end) == true then
                                j = v
                        end 
                    end
                end

 

    -- Tween 
    local tween2
    local function toTarget(pos, targetPos, targetCFrame)
        local tween_s = game:service"TweenService"
        local info = TweenInfo.new((targetPos - pos).Magnitude/70 , Enum.EasingStyle.Quad)
        local tic_k = tick()
        local tween, err = pcall(function()
            tween2 = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = targetCFrame})
            tween2:Play()
        end)
        if not tween then return err end
    end
    
    local tween3
    function tweenMoveRage2(model, target)
        spawn(function()
            if target and model then
                local tweenservice = game:service'TweenService'
                local Info = TweenInfo.new(
                    ((model:GetPrimaryPartCFrame().Position - target.Position).magnitude)/ f.Speddisland, -- 80
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0 
                )
                tween3 = tweenservice:Create(model.PrimaryPart, Info, {CFrame = (target) * CFrame.new(0,0,0)})
                tween3:Play()
            end
        end)
    end

    local tween
    function tweenMoveRage(model, target)
        spawn(function()
            if target and model then
                local tweenservice = game:service'TweenService'
                local Info = TweenInfo.new(
                    ((model:GetPrimaryPartCFrame().Position - target.Position).magnitude)/ 70, -- 80
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0 
                )
                tween = tweenservice:Create(model.PrimaryPart, Info, {CFrame = (target) * CFrame.new(0,0,0)})
                tween:Play()
            end
        end)
    end
    
    local function click()
        for i,v in next, getgc() do
            if type(v) == 'function' and getfenv(v).script == game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('MeleeScript') then
                if  pcall(function() getconstant(v, 85) end) == true then
                        j=v
                end 
            end
        end
        
        local a = game:GetService("UserInputService"):GetGamepadState(Enum.UserInputType.Gamepad1)[1]
        a.UserInputType = Enum.UserInputType.MouseButton1
        j(a,v)
    end
    
    
    local function severhop()
        local x = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                x[#x + 1] = v.id
            end
        end
        if #x > 0 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
        else
            return notify("Serverhop","Couldn't find a server.")
        end
    end

    do 
        for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
            if v.Name == "A33" then 
                        v:Destroy() 
                end
            end
        end
local    function Xxmon()
    if not game.workspace.Camera:FindFirstChild("A33") then
            local Part = Instance.new("Part")
                Part.Size = Vector3.new(10,1,10)
                    Part.Parent = game.workspace.Camera
                        Part.Name = "A33"
                             Part.CanCollide = false
                                Part.Anchored = true
                         end  
        for i1,v1 in pairs(game.workspace.Camera:GetChildren()) do
            if v1.Name == "A33" then
                    v1.CanCollide = true
                        v1.Anchored = true
                             v1.Transparency = 1
                                v1.CFrame = game.Players.LocalPlayer.Character:FindFirstChild("LeftFoot").CFrame *CFrame.new(0,0,0)
                    end
                end   
            end
            
local function xxxmon()
    do 
        for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
            if v.Name == "A333" then 
                        v:Destroy() 
                end
            end
        end
    function Xxmon()
        if not game.workspace.Camera:FindFirstChild("A33") then
            local Part = Instance.new("Part")
                Part.Size = Vector3.new(0.1,0.1,0.1)
                    Part.Parent = game.workspace.Camera
                        Part.Name = "A333"
                             Part.CanCollide = false
                                Part.Anchored = true
                         end  
        for i1,v1 in pairs(game.workspace.Camera:GetChildren()) do
            if v1.Name == "A333" then
                    v1.CanCollide = true
                        v1.Anchored = true 
                             v1.Transparency = 0
                                v1.CFrame = game:GetService("Workspace").NPCs[mob]:FindFirstChild("HumanoidRootPart").CFrame *CFrame.new(0,20,0)
                    end
                end   
            end
end

    local function checkquest()
        local xd = nil ; 
        for i , v in pairs(game:GetService("ReplicatedStorage")["Stats"..game.Players.LocalPlayer.Name].Stats:GetChildren()) do 
               if v.Name == "Level" then 
                   xd = v.Value 
                   if xd >= 1 and xd < 10 then
                    argtwo = "Help Raphtalia"
                    mob = "Bandit"
                    name = "Daph"
                    questCFrame = CFrame.new(1013.60693, 8.99998856, 1228.94653)
                    SecondCFrame = CFrame.new(1013.60693, 8.99998856, 1228.94653)
                    town = "Town of Beginnings"
                elseif  xd >= 10 and xd < 30 then
                    argtwo = "Help Noah"
                    mob = "Desert Bandit"
                    name = "Noah"
                    questCFrame =  CFrame.new(-1405.77832, 10.4348574, 1120.0719)
                    SecondCFrame =  CFrame.new(-1405.77832, 10.4348574, 1120.0719)
                    town = "Sandora"
            --[[
                        elseif checklvl > 20 and checklvl < 40 then
                    argtwo = "Take down Lucid"
                    mob = "Desert Bandit"
                    name = "Noah"
                    questCFrame =  CFrame.new(-1392.4707, 10.4348574, 1221.5061)
            ]]
                elseif  xd>= 30 and xd < 50 then
                    argtwo = "Help Robert"
                    mob = "Corrupt Marine"
                    name = "Robert"
                    questCFrame = CFrame.new(-707.312134, 10.9474678, -4492.15234) 
                    SecondCFrame =  CFrame.new(-707.312134, 10.9474678, -4492.15234) 
                    town = "Shell's Town"
                elseif  xd >=50 and xd < 80 then
                    argtwo = "Help Zen"
                    mob = "Zou Inhabitant"
                    name = "Zen"
                    questCFrame = CFrame.new(-4453.58398, 6.99241638, -2528.81421)
                    SecondCFrame = CFrame.new(-4453.58398, 6.99241638, -2528.81421)
                    town = "Island Of Zou"
            --[[
                    elseif  checklvl >= 80 and checklvl < 105 then
                    argtwo = "Help Rice"
                    mob = "Krieg Pirate"
                    name = "Chef Rice"
                    questCFrame =  CFrame.new(-3907.26563, 6.31296635, -5520.44727)
            
            ]]
                elseif  xd >=80 and xd < 105 then
                    argtwo = "Help Waby"
                    mob = "Saw Shark Pirate"
                    name = "Waby"
                    questCFrame =  CFrame.new(349.163574, 12.2988644, -13287.4395)
                    SecondCFrame = CFrame.new(349.163574, 12.2988644, -13287.4395)
                    town = "Arlong Park"
                elseif  xd>= 105 and xd < 130 then
                    argtwo = "Help vego"
                    mob = "Sky District Bandit"
                    name = "Vego"
                    questCFrame =  CFrame.new(9405.07129, 1540.85876, -10305.7881)
                    SecondCFrame =   CFrame.new(9405.07129, 1540.85876, -10305.7881)
                    town = "Land of the Sky"
                elseif  xd>= 130 and xd < 150 then
                    argtwo = "Help zhen"
                    mob = "Castle Guard"
                    name = "Zhen"
                    questCFrame  =  CFrame.new(9671.98047, 1818.97168, -11290.5049)
                    SecondCFrame =  CFrame.new(9671.98047, 1818.97168, -11290.5049)
                    town = "Land of the Sky"
                elseif  xd>= 150 and xd < 160 then
                    argtwo = "Help bibby"
                    mob = "Malcolm's Undermen" 
                    name = "Bibby"
                    questCFrame  =  CFrame.new(9944.17578, 1700.78296, -9793.67383)
                    SecondCFrame =  CFrame.new(10072.8115, 1779.48315, -9941.08105)
                     town = "Land of the Sky"
                elseif  checklvl>= 160 and checklvl < 260 then
                    argtwo = "Help Miska"
                    mob = "Gravito's Undermen" 
                    name = "Miska"
                    questCFrame  =  CFrame.new(2508.57983, 41.4681244, -15541.7012)
                    SecondCFrame =  CFrame.new(2508.57983, 41.4681244, -15541.7012)
                    town = "Gravito's Fort"

                    elseif  xd >= 260 and xd < math.huge then
                    argtwo = "Help becky"
                    mob = "Fishman Karate User" 
                    name = "Becky"
                    questCFrame  =  CFrame.new(7734.50391, -2175.8313, -17223.1699)
                    SecondCFrame =  CFrame.new(7734.50391, -2175.8313, -17223.1699)
                    town = "Fishman Island"
    --[[
                    elseif  xd >= 260 and xd < 325 then
                    argtwo = "Help Dabo"
                    mob = "Mini Bunny" 
                    name = "Dabo"
                    questCFrame  =  CFrame.new(-10628.4824, 50.9498558, -7392.7168)
                    SecondCFrame =  CFrame.new(-10628.4824, 50.9498558, -7392.7168)
                    
    ]]
                end
            end
        end
        return xd 
    end
    
    local function checkmobpunch()
            if checklvl >= 1 and checklvl < 10 then
             argtwo = "Help Raphtalia"
             mob2 = "Bandit"
             name = "Daph"
             questCFrame = CFrame.new(1013.60693, 8.99998856, 1228.94653)
             SecondCFrame = CFrame.new(1013.60693, 8.99998856, 1228.94653)
         elseif  checklvl >= 10 and checklvl < 30 then
             argtwo = "Help Noah"
             mob2 = "Desert Bandit"
             name = "Noah"
             questCFrame =  CFrame.new(-1405.77832, 10.4348574, 1120.0719)
             SecondCFrame =  CFrame.new(-1405.77832, 10.4348574, 1120.0719)
     --[[
                 elseif checklvl > 20 and checklvl < 40 then
             argtwo = "Take down Lucid"
             mob = "Desert Bandit"
             name = "Noah"
             questCFrame =  CFrame.new(-1392.4707, 10.4348574, 1221.5061)
     ]]
         elseif  checklvl >= 30 and checklvl < 50 then
             argtwo = "Help Robert"
             mob2 = "Corrupt Marine"
             name = "Robert"
             questCFrame = CFrame.new(-707.312134, 10.9474678, -4492.15234) 
             SecondCFrame =  CFrame.new(-707.312134, 10.9474678, -4492.15234) 
         elseif  checklvl >=50 and checklvl < 80 then
             argtwo = "Help Zen"
             mob2 = "Zou Inhabitant"
             name = "Zen"
             questCFrame = CFrame.new(-4453.58398, 6.99241638, -2528.81421)
             SecondCFrame = CFrame.new(-4453.58398, 6.99241638, -2528.81421)
     --[[
             elseif  checklvl >= 80 and checklvl < 105 then
             argtwo = "Help Rice"
             mob = "Krieg Pirate"
             name = "Chef Rice"
             questCFrame =  CFrame.new(-3907.26563, 6.31296635, -5520.44727)
     
     ]]
         elseif  checklvl >=80 and checklvl < 105 then
             argtwo = "Help Waby"
             mob2 = "Saw Shark Pirate"
             name = "Waby"
             questCFrame =  CFrame.new(349.163574, 12.2988644, -13287.4395)
             SecondCFrame = CFrame.new(349.163574, 12.2988644, -13287.4395)
         elseif  checklvl>= 105 and checklvl < 130 then
             argtwo = "Help vego"
             mob2 = "Sky District Bandit"
             name = "Vego"
             questCFrame =  CFrame.new(9405.07129, 1540.85876, -10305.7881)
             SecondCFrame =   CFrame.new(9405.07129, 1540.85876, -10305.7881)
         elseif  checklvl>= 130 and checklvl < 150 then
             argtwo = "Help zhen"
             mob2 = "Castle Guard"
             name = "Zhen"
             questCFrame  =  CFrame.new(9671.98047, 1818.97168, -11290.5049)
             SecondCFrame =  CFrame.new(9671.98047, 1818.97168, -11290.5049)
         elseif  checklvl>= 150 and checklvl < 160 then
             argtwo = "Help bibby"
             mob = "Malcolm's Undermen" 
             name = "Bibby"
             questCFrame  =  CFrame.new(9944.17578, 1700.78296, -9793.67383)
             SecondCFrame =  CFrame.new(10072.8115, 1779.48315, -9941.08105)
         elseif  checklvl>= 160 and checklvl < 190 then
             argtwo = "Help Miska"
             mob2 = "Gravito's Undermen" 
             name = "Miska"
             questCFrame  =  CFrame.new(2508.57983, 41.4681244, -15541.7012)
             SecondCFrame =  CFrame.new(2508.57983, 41.4681244, -15541.7012)
    
             elseif  checklvl >= 190 and checklvl < 326 then
             argtwo = "Help becky"
             mob2 = "Fishman Karate User" 
             name = "Becky"
             questCFrame  =  CFrame.new(7734.50391, -2175.8313, -17223.1699)
             SecondCFrame =  CFrame.new(7734.50391, -2175.8313, -17223.1699)
    
    --[[
             elseif  xd >= 260 and xd < 325 then
             argtwo = "Help Dabo"
             mob = "Mini Bunny" 
             name = "Dabo"
             questCFrame  =  CFrame.new(-10628.4824, 50.9498558, -7392.7168)
             SecondCFrame =  CFrame.new(-10628.4824, 50.9498558, -7392.7168)
             
    ]]
         end
    end

spawn(function()
    while wait() do 
        if f.autofarm or f.shipfarm or  f.tpisland or f.Dungeon  then 
            repeat wait()
                pcall(function()
                    Xxmon()
                end)
            until not f.autofarm or not f.shipfarm or not f.tpisland or not f.Dungeon 
        end
    end
end)

    spawn(function()
        while wait() do 
            if f.autofarm then 
            pcall(function()
                checkquest()
            end)
            end
        end
    end)
    
    
    local function check()
        local nametown = nil 
         for i , v in pairs(game:GetService("Workspace").Islands:GetChildren()) do 
            if v:IsA("Model") then 
                nametown = v.Name 
                end
         end  
      return nametown
    end
    
    local function chages(Stats)
        for i , v in pairs(game:GetService("Workspace").Islands[check()]:GetDescendants()) do 
            if v:IsA("Part") then 
              --  if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 100 then   
               -- setsimulationradius(1000000,100000)
                     v.CanCollide = Stats 
              --  end
            end
        end
     end
    
    local function equip()
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name == f.weapons and v:IsA("Tool") then
                v.Parent = game.Players.LocalPlayer.Character
            end
         end
    end
    
    
local function autofarm()  

    if checklvl >= 1 and checklvl < 260  then
        if game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value == "None" then
            tweenMoveRage(game.Players.LocalPlayer.Character, questCFrame, true)
          for _ , check in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
              if check.Name ==   name then
                  if (check.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <= 10 then     
                      chages(true)
                      game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest",argtwo})
                  end
              end
          end
        elseif game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value ~= argtwo then
            local args = {
                [1] = {
                    [1] = "quit"
                }
            }
            game:GetService("ReplicatedStorage").Events.Quest:InvokeServer(unpack(args))
                tweenMoveRage(game.Players.LocalPlayer.Character, questCFrame, true)
              for _ , check in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                  if check.Name ==   name then
                      if (check.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <= 10 then     
                          chages(true)
                          game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest",argtwo})
                      end
                  end
              end
      elseif game:GetService("ReplicatedStorage")[checklocal].Stats.SpawnPoint.Value ~= town then
        for i , v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
            if v.Name == "Robo" then 
                    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame *CFrame.new(0,0,0))
                    if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude < 5 then
                        local args = {
                            [2] = workspace.NPCs.Robo
                        }
                        game:GetService("ReplicatedStorage").Events.SetSpawn:FireServer(unpack(args))
                    end
            end
        end
      elseif  game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value ~= "None" and game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value == argtwo  and game:GetService("ReplicatedStorage")[checklocal].Stats.SpawnPoint.Value == town  then
          chages(false)
          tweenMoveRage(game.Players.LocalPlayer.Character, SecondCFrame, true)
              for i , v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                      if not game:GetService("Workspace").NPCs:FindFirstChild(mob) then 
                          tweenMoveRage(game.Players.LocalPlayer.Character, SecondCFrame, true)
                      end
                  if v.Name == mob  then 
                      if v.Humanoid.Health > 0 then 
                          if checklvl >= 1 and checklvl < 260 then 
                          repeat wait()
                        
                              toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame *CFrame.new(0,sf.high,sf.distants))
                            if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude < 20 then
                                plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,sf.high,sf.distants)
                              --  plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
                            end
                             --   plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
                                  equip()
                              
                          until v.Humanoid.Health == 0 or not f.autofarm or game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value == "None"  or checklvl == 260
                        end
                    end
                end
            end
        end
    -- end frist farm 
    elseif checklvl >= 260 and checklvl < 326  then
      --  print(checklvl.."ผ่าน")
           if not game:GetService("Workspace").Islands:FindFirstChild("Fishman Island") then
                tweenMoveRage(game.Players.LocalPlayer.Character, CFrame.new(5639.33057, -96.2169037, -16610.9043), true)
            elseif game:GetService("Workspace").Islands:FindFirstChild("Fishman Island") then
    
                if game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value == "None" then
                    tweenMoveRage(game.Players.LocalPlayer.Character, questCFrame, true)
                  for _ , check in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                      if check.Name ==  name then
                          if (check.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <= 10 then     
                              chages(true)
                              game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest",argtwo})
                          end
                      end
                  end
    
        elseif game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value ~= argtwo then
                    local args = {
                        [1] = {
                            [1] = "quit"
                        }
                    }
                    game:GetService("ReplicatedStorage").Events.Quest:InvokeServer(unpack(args))
                tweenMoveRage(game.Players.LocalPlayer.Character, questCFrame, true)
                    for _ , check in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                        if check.Name ==   name then
                            if (check.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <= 4 then     
                                chages(true)
                                game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest",argtwo})
                            end
                        end
                    end

        elseif game:GetService("ReplicatedStorage")[checklocal].Stats.SpawnPoint.Value ~= town then
                    for i , v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                        if v.Name == "Robo" then 
                                toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame *CFrame.new(0,0,0))
                                if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude < 5 then
                                    local args = {
                                        [2] = workspace.NPCs.Robo
                                    }
            
                                    game:GetService("ReplicatedStorage").Events.SetSpawn:FireServer(unpack(args))
                                end
                        end
                    end
        elseif  game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value ~= "None" and game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value == argtwo  and game:GetService("ReplicatedStorage")[checklocal].Stats.SpawnPoint.Value == town  then            
          chages(false)
          tweenMoveRage(game.Players.LocalPlayer.Character, SecondCFrame, true)
            for i , v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                    if not game:GetService("Workspace").NPCs:FindFirstChild(mob) then 
                          tweenMoveRage(game.Players.LocalPlayer.Character, SecondCFrame, true)
                     end
                  if v.Name == mob  then 
                      if v.Humanoid.Health > 0 then 
                          if checklvl >= 260 and checklvl < 326 then 
                          --    print(checklvl.."สอง")
                          --    print("1")
                          repeat wait()                     
                    
                              toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,sf.high,sf.distants))  
                              if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude < 20 then
                                plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,sf.high,sf.distants)
                              --  plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
                            end   
                              equip()
                          
                          until v.Humanoid.Health == 0 or not f.autofarm or game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value == "None"  or checklvl == 326
                        end
                    end
                end
            end
        end
    end
end
    
    
                
    --[[
                                    elseif checklvl >= 260 and checklvl < 325 then 
                                    if  game:GetService("Workspace").NPCs:FindFirstChild("Elo The Bunny") and not  game:GetService("Workspace").NPCs:FindFirstChild("Mini Bunny") then 
                                        for _ , n in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                                            if n.Name == "Elo The Bunny" then 
                                                if n.Humanoid.Health > 0 then 
                                                repeat wait()                        
                                                    autoblox()
                                                    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,n.HumanoidRootPart.Position,n.HumanoidRootPart.CFrame * CFrame.new(0,sf.high,sf.distants))  
                                                    equip()
                                                until v.Humanoid.Health == 0 or not f.autofarm or  game:GetService("Workspace").NPCs:FindFirstChild("Mini Bunny") 
                                           for _2 , m in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                                                if m.Name == "Elo The Bunny" then 
                                                    if v.Humanoid.Health > 0 then 
                                                            repeat wait()
                                                                autoblox()
                                                                toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,sf.high,sf.distants))  
                                                                equip()
                                                            until v.Humanoid.Health == 0 or not f.autofarm or game:GetService("ReplicatedStorage")[checklocal].Quest.CurrentQuest.Value == "None" 
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
    ]]
      
end
    --[[
        local function NearMob()
        local target = nil
        checkquest()
        for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
            pcall(function()
                if v.Name == mob then
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 and v:FindFirstChild("HumanoidRootPart") then
                    target = v
                    end
                end
            end)
        end
        return target
    end
    ]]
    
    local function puchship()
            pcall(function()
                --     checkmobpunch()
                     for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                      --   if v:FindFirstChild("HumanoidRootPart") then 
                            if string.find( v.Name , "Captain" ) then 
                       --  if (v.HumanoidRootPart.Position  - plr.Character.HumanoidRootPart.Position).magnitude <= 500 then   
                                 if v.Humanoid.Health > 0 then
                                 repeat wait()
                                     game:GetService("ReplicatedStorage").Events.GunManager:FireServer("fire",{
                                         ["Start"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
                                         ["Gun"] = "Rifle",
                                         ["go"] = "no",
                                         ["Position"] = v.Head.Position
                                     })
                                 
                                 game:GetService("ReplicatedStorage").Events.GunManager.gunFunctions:InvokeServer("reload",{["Gun"] = "Rifle"})
                                 until  v.Humanoid.Health == 0 or not f.shipfarm 
                                    --     end
                               --      end
                                 end
                             end
                         end
                     end)  
                
    end
    
    
    --4OxV1uX
    

        local function setspawn()

            for i , v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                if v.Name == "Robo" then
                toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,0,-3))  
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
                if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <= 5 then    
                    chages(true)
                    local args = {
                        [2] = workspace.NPCs.Robo
                    }
                    
                    game:GetService("ReplicatedStorage").Events.SetSpawn:FireServer(unpack(args))
                    end
                end
            end
        end
    

    
    
    
    
    local listIsland = {
        "Coco island",
        "Island Of Zou",
        "Gravito's Fost",
        "Land of the Sky",
        "Marine Base G-1",
        "Fishman Cave",
        "Sell's Town",
        "Restaurant Baratie",
        "Elo's Island",
        "Colosseum",
        "Orange Town",
        "Traders Lounge",
        "Roca island",
        "Fishman island",
        "Marine Forst F-1",
        "Sphinx island",
        "Town of Beginnings",
        "Sandora",
        "Arlong Park",
        "Mysterious Cliiff",
        "Kori Island"
    
    }
    
    local function tpisland()
        if   f.selectisland  == "Coco island" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character, CFrame.new(-4222.34863, 94.5981903, -15582.6738), true)
        elseif   f.selectisland  == "Island Of Zou" then
            tweenMoveRage2(game.Players.LocalPlayer.Character, CFrame.new(-4335.18506, 6.99242496, -2559.26025), true)
        elseif   f.selectisland  ==  "Kori Island" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character, CFrame.new(-6601.96729, 169.482346, 1998.25537), true)
        elseif   f.selectisland  ==  "Gravito's Fost" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(2670.85181, 8.01797485, -15293.2334), true)
        elseif   f.selectisland  ==    "Land of the Sky" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character, CFrame.new(9025.79199, 1438.64258, -10552.0313), true)
        elseif   f.selectisland  ==  "Marine Base G-1" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-9951.64258, 72.0304642, -14952.9824), true)
        elseif   f.selectisland  ==  "Fishman Cave" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(5672.22559, 4.07501173, -16458.3281), true)
        elseif   f.selectisland  ==    "Sell's Town"then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-538.462585, 6.94743681, -4440.98584), true)
        elseif   f.selectisland  ==     "Restaurant Baratie"then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-3909.02417, 50.4191856, -5601.65625), true)
        elseif   f.selectisland  ==     "Elo's Island" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-10297.6172, 22.2074223, -7398.1748), true)
        elseif   f.selectisland  ==  "Colosseum" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-2034.56519, 6.85396147, -7627.70508), true)
        elseif   f.selectisland  ==   "Orange Town" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-7001.85352, 5.30034208, -5386.11621), true)
        elseif   f.selectisland  ==    "Roca island" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(5260.05859, 4.38517189, -5071.80713), true)
        elseif   f.selectisland  ==    "Fishman island" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(8000.65869, -2153.83228, -17014.0195), true)
        elseif   f.selectisland  ==     "Marine Forst F-1" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(2896.00342, 18.8515148, -1000.05145), true)
        elseif   f.selectisland  ==    "Sphinx island" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-6330.76709, 41.2856674, -10139.1074), true)
        elseif   f.selectisland  ==     "Town of Beginnings" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(957.090942, 12.6915455, 1181.60474), true)
        elseif   f.selectisland  ==      "Sandora" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(-1236.39404, 15.6557522, 1169.77612), true)
        elseif   f.selectisland  ==        "Arlong Park" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(673.448853, 10.9988632, -13111.1924), true)
        elseif   f.selectisland  ==       "Mysterious Cliiff" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character,CFrame.new(2201.09351, 236.644012, -8610.41406), true)
        elseif   f.selectisland  ==       "Kori Island" then 
            tweenMoveRage2(game.Players.LocalPlayer.Character, CFrame.new(-6595.62793, 180.451584, 1994.75623), true)
        end
    end
    
    local function createpartship()
        do 
            for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                if v.Name == "A3" then 
                    v:Destroy() 
                end
            end
        end
             
        if not game.workspace.Camera:FindFirstChild("A3") then
            local Part = Instance.new("Part")
            Part.Size = Vector3.new(10,1.5,10)
            Part.Parent = game.workspace.Camera
            Part.Name = "A3"
        end
                                  
        for i1,v1 in pairs(game.workspace.Camera:GetChildren()) do
            if v1.Name == "A3" then
                v1.CanCollide = true
                v1.Anchored = true
                v1.Transparency = 1
                v1.CFrame = game:GetService("Workspace").Ships[game.Players.LocalPlayer.Name.."Ship"].Head.CFrame * CFrame.new(0,50,0)
                    end
                end     
            end

    local function spawnpart()
        do 
            for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                if v.Name == "Spawn" then 
                    v:Destroy() 
                end
            end
        end
                if not game.workspace.Camera:FindFirstChild("Spawn") then
                    local Part = Instance.new("Part")
                    Part.Size = Vector3.new(10,0.5,10)
                    Part.Parent = game.workspace.Camera
                    Part.Name = "Spawn"
                end
                                          
            for i1,v1 in pairs(game.workspace.Camera:GetChildren()) do
                if v1.Name == "Spawn" then
                        v1.CanCollide = true
                        v1.Anchored = true
                        v1.Transparency = 1
                        v1.CFrame = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,-1,0)
            end
        end                 
    end
            
    local function parthead()
        do 
            for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                if v.Name == "HeadFarm" then 
                    v:Destroy() 
                end
            end
        end
        for i , v in pairs(game:GetService("Workspace").Ships.NPC:GetDescendants()) do 
            if v.Name == 'Head' then 
                
                if not game.workspace.Camera:FindFirstChild("HeadFarm") then
                    local Part = Instance.new("Part")
                    Part.CanCollide = true
                    Part.Anchored = true
                    Part.Size = Vector3.new(10,0.5,10)
                    Part.Parent = game.workspace.Camera
                    Part.Name = "HeadFarm"
                end
                                          
                for i1,v1 in pairs(game.workspace.Camera:GetChildren()) do
                    if v1.Name == "HeadFarm" then
                        v1.CanCollide = true
                        v1.Anchored = true
                        v1.Transparency = 1
                        v1.CFrame = v.CFrame * CFrame.new(-10,5,1)
                            end
                        end     
                    
            end
        end                
    end
    local function dungeonpart()
        do 
            for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                if v.Name == "DungeonFarm" then 
                    v:Destroy() 
                end
            end
        end
        for i , v in pairs(game:GetService("Workspace").Islands:GetDescendants()) do 
            if v.Name == 'SpawnPoint' then 
                
                if not game.workspace.Camera:FindFirstChild("DungeonFarm") then
                    local Part = Instance.new("Part")
                    Part.CanCollide = true
                    Part.Anchored = true
                    Part.Size = Vector3.new(10,1,10)
                    Part.Parent = game.workspace.Camera
                    Part.Name = "DungeonFarm"
                end
                                          
                for i1,v1 in pairs(game.workspace.Camera:GetChildren()) do
                    if v1.Name == "DungeonFarm" then
                        v1.CanCollide = true
                        v1.Anchored = true
                        v1.Transparency = 1
                        v1.CFrame = v.CFrame * CFrame.new(0,f.HughhDungeon,10)
                            end
                        end     
                    
            end
        end                
    end

        local function prefectblox()
    
        for i , v in pairs(game:GetService("Workspace").Projectiles.NPC:GetDescendants()) do 
            if v:IsA("MeshPart") then 
                local playpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                if (v.Position - playpos).magnitude < 10  then
                        game:GetService("ReplicatedStorage").Events.Block:InvokeServer(true,"Melee")
                end
            end
        end
    end

    --[[
        local function Fall()
        for i , v in next,game.Players.LocalPlayer.Character:GetChildren() do 
            if v.Name == "FallDamage" then
                v:Destroy()
            end
        end
    end
    
    ]]
    
    --[[
        spawn(function()
        while wait() do 
                if f.autofarm then
                    for i , v in pairs(game:GetService("Workspace").Islands[check()]:GetChildren()) do 
                        if v:IsA("Part") then 
                            if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 100 then   
                                 v.CanCollide = false 
                            end
                        end
                    end
                elseif f.autofarm == false  then
                    for i , v in pairs(game:GetService("Workspace").Islands[check()]:GetChildren()) do 
                        if v:IsA("Part") then 
                            if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 100 then   
                                 v.CanCollide = true 
                        end
                    end
                end
            end
        end
    end)
    ]]
    
    --[[
        spawn(function ()
        while true do wait()
            if f.autofarm then
                pcall(function ()
                        for i , v in pairs(game:GetService("Workspace").Islands[check()]:GetChildren()) do 
                            if v:IsA("Part") then 
                                if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 100 then   
                                     v.CanCollide = false 
                                end
                            end
                        end
                end)
            end
        end
    end)
    ]]
    --[[
    -- Script generated by SimpleSpy - credits to exx#9394
    
    game:GetService("ReplicatedStorage").Events.ShipEvents.Spawn:InvokeServer()
    
    game:GetService("Workspace").Islands["Sky Islands"].SpawnPoint
    
    ]]
    
    local VLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/BunnySalf/Pls-Don-t-Crack-me-Pls/main/Polar.Don't.Crack.Me")()
    local W = VLib:AddWindow("GPO Paid")
    local m1 = W:AddTab("Auto Farm", "http://www.roblox.com/asset/?id=6031302950")
    local m2 = W:AddTab("Auto Stats","http://www.roblox.com/asset/?id=6031243328")
    local m3 = W:AddTab("Teleport","http://www.roblox.com/asset/?id=6031079158")
    local m4 = W:AddTab("Ship Farm",'http://www.roblox.com/asset/?id=6031265971')
    local m5 = W:AddTab("Dungeon Farm",'http://www.roblox.com/asset/?id=6034684949')
    
    local b = m1:AddSection("Auto Farm") 
    local bs  = m1:AddSection("Setting Farm")
    local b2 = m2:AddSection("Auto Stats")
    local b3 = m3:AddSection("List Npc Weapons")
    local b4 = m4:AddSection("Ship Farm")
    local b5 = m5:AddSection("Dungeon")
    
    
    local GetNewWeapons = b:AddDropdown("Seclect Weapon",GetWeapon,function (weapon)
        f.weapons = weapon
    end)
    
    b:AddButton("Refesh Weapon",function ()
        GetNewWeapons:Clear()
        for i, v in ipairs(plr.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                GetNewWeapons:Add(v.Name)
            end
        end
    end)
    
    b:AddSwitch("Auto Farm",false,function(t)
        f.autofarm = t 
        if f.autofarm == false then
            tween2:Cancel()
        end
    spawn(function ()
        pcall(function ()
        while f.autofarm  do wait()
                    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                       
                        chages(false)
                        local bv = Instance.new("BodyVelocity")
                        bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                        bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                        bv.Velocity = Vector3.new(0,0,0)
                        game:GetService("Workspace").Islands.ChildAdded:connect(function(a)
                            for i , v in pairs(a:GetDescendants()) do 
                                if v:IsA("Part") then 
                                    if f.autofarm then 
                                        v.CanCollide = false 
                                        else
                                            v.CanCollide = true 
                                    end
                                end
                            end
                        end)
                    end  
                end
        end)
    end)
    spawn(function ()
        pcall(function ()
        while wait() do 
            if f.autofarm == false then 
                chages(true)
                    for i , v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                        if v.Name == "BodyVelocity" then
                                v:Destroy()  
            
                    end
                end
                end
            end
        end)
    end)
    
        spawn(function()
            while f.autofarm   do wait()
                  pcall(function ()
                     autofarm()
                  end)
            end
        end)
        
    end)
local j 
local p 
for i,v in next, getgc() do 
    if type(v) == 'function' and getfenv(v).script == game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('MeleeScript') then
            if  pcall(function() getconstant(v, 75) end) == true then
                    j = v
        end 
    end
end


    b:AddSwitch("Auto Punch",false,function(t)
        f.Puch = t 
        spawn(function ()
            while  wait() do
                if f.Puch then
                    pcall(function()
                        if sf.selecttype == "Melee" then     
                            local a = game:GetService("UserInputService"):GetGamepadState(Enum.UserInputType.Gamepad1)[1]
                            a.UserInputType = Enum.UserInputType.MouseButton1
                            j(a) 
                    elseif sf.selecttype == "Rifle" then
                        checkquest()
                            for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                                if v.Name == mob then
                                if (v.HumanoidRootPart.Position  - plr.Character.HumanoidRootPart.Position).magnitude <= 500 then   
                                        if v.Humanoid.Health > 0 then
                                        repeat wait()
                                            game:GetService("ReplicatedStorage").Events.GunManager:FireServer("fire",{
                                                ["Start"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
                                                ["Gun"] =   f.weapons ,
                                                ["go"] = "no",
                                                ["Position"] = v.Head.Position
                                            })
                                            local args = {
                                                [1] = "reload",
                                                [2] = {
                                                ["Gun"] = "Rifle"
                                                }
                                                }
                                                game:GetService("ReplicatedStorage").Events.GunManager.gunFunctions:InvokeServer(unpack(args))
                                        until  v.Humanoid.Health == 0 or not f.autofarm or not f.Puch 
                                    end
                                end
                            end
                        end
                    end
                 end)
                end
            end
        end)
        spawn(function()
            while wait(5) do 
                if f.Puch then 
                    if sf.selecttype == "Melee" then                       
                        for i,v in next, getgc() do 
                            if type(v) == 'function' and getfenv(v).script == game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('MeleeScript') then
                                    if  pcall(function() getconstant(v, 75) end) == true then
                                            j = v
                                end 
                            end
                        end
                    end
                end
            end
        end)
    end)

    
    b:AddSwitch("Delete Fall Damge",true,function (t)
        f.FallDamge = t 
        spawn(function ()
            while wait() do
                if f.FallDamge then
                    pcall(function ()
                        game:GetService("Workspace").PlayerCharacters[game.Players.LocalPlayer.Name].FallDamage.Disabled =  f.FallDamge
                    end)
                end
            end
        end)
    end)
    
--[[
    
            b:AddSwitch("Auto Set Spawn",false,function (t)
        f.Set = t 
        spawn(function ()
            while wait() do
                if f.Set  then
                    pcall(function ()
                        setspawn()
                    end)
                end
            end
        end)
    
        spawn(function ()
        pcall(function ()
            if f.Set   then
                    chages(false)
                 
                end
            end)
    end)
    spawn(function ()
        pcall(function ()
                if f.Set == false  then 
                    chages(true)
                
                        
                end
            end)
        end)
    end)
 
]]

--[[
        b:AddSwitch("Auto Haki",false,function(t)
        f.buso = t 
        spawn(function()
            while wait() do 
                if f.buso then 
                    pcall(function ()
                        if not game.Players.LocalPlayer.Character:FindFirstChild("BusoMelee") then 
                            game:GetService("ReplicatedStorage").Events.Haki:FireServer("Buso")             
                       end
                    end)
                end
            end
        end)
    end)
]]
    
    b:AddSwitch("Auto Block",true,function(t)
        f.Block = t    
        spawn(function()
            while wait(0.1) do 
                if f.Block then 
               --     pcall(function()
                        for i , v in pairs(game:GetService("Workspace").Projectiles.NPC:GetDescendants()) do 
                            if v:IsA("MeshPart") then 
                                local playpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                                if (v.Position - playpos).magnitude < 20  then
                                        game:GetService("ReplicatedStorage").Events.Block:InvokeServer(true,"Melee")
  
                                end
                            end
                        end
                 --   end)
                end
            end    
        end)

        spawn(function ()
            while wait(0.1) do 
                if f.Block then 
            --        pcall(function()
                        for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                            for i,b in pairs(v:GetChildren()) do
                                    if b.Name == "attacking" then
                                    local playpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                                    local npcpos = b.Parent.HumanoidRootPart.Position
                                    if (npcpos - playpos).magnitude < 10  then
                                        game:GetService("ReplicatedStorage").Events.Block:InvokeServer(true,"Melee")
                                    end
                                end
                            end
                        end
                  --  end)
                end
            end
        end)
    end)

    b:AddSwitch("Anti Admin",true,function(v)
        f.antiow = v 
        spawn(function()
            while wait() do 
                if f.antiow then 
                    local ownerId = game.CreatorId
                    game:GetService'Players'.PlayerAdded:Connect(function(player)
                    if player.UserId  == name then
                    game:GetService'Players'.LocalPlayer:Kick()
                    end
                    end)
                end
            end
        end)
    end)
    
    bs:AddDropdown("Select Type",{"Melee","Rifle"},function (t)
        sf.selecttype = t
    end)
    
    bs:AddSlider("High",0,100,function(Dis)
        sf.high = Dis 
    end)
    
    bs:AddSlider("Distance NPC",0,4,function(Dis)
        sf.distants = Dis 
    end)
    
    --[[
        b:AddButton("Server Hop",function ()
        severhop()
    end)
    
    ]]
    

    local checkxd = b2:AddLabel("Point : ".. game:GetService("ReplicatedStorage")[checklocal].Stats.SkillPoints.Value)
    
    spawn(function ()
        while wait() do
            pcall(function ()
                checkxd:Re("Point : "..  game:GetService("ReplicatedStorage")[checklocal].Stats.SkillPoints.Value)
            end)
        end
    end)
    
    b2:AddSwitch("Strength",false,function (stats)
        f.Strength = stats
    end)
    
    b2:AddSwitch("Stamina",false,function (stats)
        f.Stamina = stats
    end)
    
    b2:AddSwitch("Defense",false,function (stats)
        f.Defense = stats
    end)
    
    b2:AddSwitch("Gun Mastery",false,function (stats)
        f.GunMastery = stats
    end)
    
    b2:AddSwitch("Sword Mastery",false,function (stats)
        f.SwordMastery = stats
    end)
    
    -- stats script 
    spawn(function ()
        while wait(0.1) do
            if f.Strength then
                local args = {
                    [1] = "Strength",
                    [3] = 1
                }

                game:GetService("ReplicatedStorage").Events.stats:FireServer(unpack(args))

            elseif f.Stamina then
                local args = {
                    [1] = "Stamina",
                    [3] = 1
                }

                game:GetService("ReplicatedStorage").Events.stats:FireServer(unpack(args))
            elseif f.Defense then
                local args = {
                    [1] = "Defense",
                    [3] = 1
                }

                game:GetService("ReplicatedStorage").Events.stats:FireServer(unpack(args))
            elseif f.GunMastery then
                local args = {
                    [1] = "GunMastery",
                    [3] = 1
                }

                game:GetService("ReplicatedStorage").Events.stats:FireServer(unpack(args))

            elseif f.SwordMastery then
                local args = {
                    [1] = "SwordMastery",
                    [3] = 1
                }

                game:GetService("ReplicatedStorage").Events.stats:FireServer(unpack(args))
            end
        end
    end)

    
    --weapon
    b3:AddDropdown("Island Tp",listIsland,function (t)
        f.selectisland = t 
    
    end)
    
    b3:AddSwitch("TP Island",false,function(t)
        f.tpisland =  t 
        spawn(function ()
            pcall(function ()
            while f.tpisland  do wait()
                        if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("N") then
                            chages(false)
                            local bv = Instance.new("BodyVelocity")
                            bv.Name = "N"
                            bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                            bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                            bv.Velocity = Vector3.new(0,0,0)
                            game:GetService("Workspace").Islands.ChildAdded:connect(function(a)
                                for i , v in pairs(a:GetDescendants()) do 
                                    if v:IsA("Part") then 
                                        if f.tpisland then 
                                            v.CanCollide = false 
                                            else
                                                v.CanCollide = true 
                                        end
                                    end
                                end
                            end)
                        end  

                    end
                end)
            end)
        spawn(function ()
            pcall(function ()
            while f.tpisland == false   do wait()
                            chages(true)
                            for i , v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                                if v.Name == "N" then
                                        v:Destroy()  
                    
                            end
                        end
                    end
            end)
        end)
        spawn(function ()
            if f.tpisland then 
                tpisland();
            else
                tween:Cancel()
            end
        end)
    end)
    
    b3:AddSlider("Tp Speed",0,100,function (t)
        f.Speddisland = t 
    end)

    local findcf =  tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
    local setcf
    
    local checkxd = b4:AddLabel(findcf)
    
    
    
    b4:AddButton("Set Respawn",function()
        for i , v in pairs(plr.Character:GetChildren()) do 
            if v.Name == "HumanoidRootPart" then 
                 setcf = v.Position
                 checkxd:Re(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position))
                 spawnpart()
            end
        end
    end)
    
    

    --game:GetService("ReplicatedStorage").Events.Tools:InvokeServer("equip","Rowboat")
    b4:AddSwitch("Boat Resawn",false,function(t)
        f.spawnboat  = t 
        spawn(function()
            while wait() do 
             if f.spawnboat then 
                pcall(function()
                        if not game:GetService("Workspace").Ships:FindFirstChild(game.Players.LocalPlayer.Name.."Ship") then 
                            for _ , s in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                                if s.Name == "Spawn" then 
                                    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,s.Position,s.CFrame * CFrame.new(0,5,0))  
                                    if (s.Position - plr.Character.HumanoidRootPart.Position).magnitude < 20 then 
                                        local args = {
                                            [1] = "true"
                                        }

                                        game:GetService("ReplicatedStorage").Events.ShipEvents.Spawn:InvokeServer(unpack(args))
                                    end      
                                end
                            end

                        if game:GetService("Workspace").Ships:FindFirstChild(game.Players.LocalPlayer.Name.."Ship") then 
                            createpartship()
                            for i ,  v  in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                                if v.Name == "A3" then 
                                        toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.Position,v.CFrame * CFrame.new(0,5,0))  
                                        if (v.Position - plr.Character.HumanoidRootPart.Position).magnitude < 5 then 
                                                tween:Cancel()
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
            spawn(function()
                while wait() do 
                    pcall(function ()
                        if not game:GetService("Workspace").Ships:FindFirstChild(game.Players.LocalPlayer.Name.."Ship") then 
                            for i ,v  in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                                if v.Name =="A3" then 
                                    v:Destroy()
                                end
                            end
                        end
                    end)
                end
            end)

        --noclip
--[[
            spawn(function ()
            pcall(function ()
            while f.spawnboat  do wait()

                            if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("xxxXd") then
                            chages(false)
                            local bv = Instance.new("BodyVelocity")
                            bv.Name = "xxxXd"
                            bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                            bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                            bv.Velocity = Vector3.new(0,0,0)
                            
                        end  

                    end
            end)
        end)
        spawn(function ()
            pcall(function ()
            while f.spawnboat == false   do wait()
                    chages(true)

                            for i , v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                            if v.Name == "xxxXd" then
                                v:Destroy()  
                        end
                    end

                end
            end)
        end)
]]
    --[[
            spawn(function ()
            pcall(function ()
            while f.spawnboat == false   do wait()
                            chages(true)
                            for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do
                                if v.Name == "A3" then
                                     v:Destroy()  
                    
                            end
                        end
                    end
            end)
        end)
    ]]
        spawn(function()
            while f.spawnboat == false do 
                wait()
                tween2:Cancel()
            end
        end)
    end)
    
    --[[
        b4:AddDropdown("Ship Farm Type",{"Single Farm"},function(type)
        f.selecttype = type 
    end)
    ]]
    --[[
        

local f1 = b4:AddFolder("Switch Ship")
local sw = {
    Caravel = false ; 
    Rowboat = false ; 
    Gunboat = false ; 
    Brig = false ; 
    Coffin = false ; 
    Striker = false ; 
    Hoverboard = false ; 
    Flamingo = false ; 
}

f1:AddSwitch("Caravel",function(x)
    sw.Caravel = x 
end)

f1:AddSwitch("Rowboat",function(x)
    sw.Rowboat = x 
end)

f1:AddSwitch("Gunboat",function(x)
    sw.Gunboat = x 
end)

f1:AddSwitch("Brig",function(x)
    sw.Brig = x 
end)

f1:AddSwitch("Coffin Boat",function(x)
    sw.Coffin = x 
end)
    
f1:AddSwitch("Striker",function(x)
    sw.Striker = x 
end)

f1:AddSwitch("Flamingo Boat",function(x)
    sw.Flamingo = x 
end)

f1:AddSwitch("Hoverboard",function(x)
    sw.CaHoverboardravel = x 
end)
    ]]

b4:AddSwitch("Ship Farm (All)",false,function(farm)
        f.shipfarm = farm 
        spawn(function()
            while wait() do 
                if f.shipfarm then 
                    pcall(function()             
                        if game.Workspace.NPCs:FindFirstChild("Pirate Captain") or game.Workspace.NPCs:FindFirstChild("Marine Captain")   then  
                         --  parthead()
                           for i , v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                                if  string.find(v.Name,"Captain")  then  --v.Name == "HeadFarm" and v:IsA("Part")
                                   -- if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude < 1000 then 
                                    repeat wait()
                                       
                                         toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,0,-40) )  
                                         
                          --[[
                                            if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 5 then 
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,3,0)
                                            plr.Character.HumanoidRootPart.Anchored = true 
                                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
                                        end  
                          ]]                         
                                    until  not f.shipfarm 
                                   -- end
                                end
                            end
    --[[
                            elseif  not  game.Workspace.NPCs:FindFirstChild("Pirate Captain") and not  game.Workspace.NPCs:FindFirstChild("Marine Captain")  then 
                            for _, c in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                                if c:FindFirstChild("Humanoid") then 
                                    repeat  wait()
                                        c.Humanoid.Health = 0 
                                    until not f.shipfarm
                                end
                            end
                        end
    ]]  
                    
                        end
                    end)
                end
            end
    end)
    spawn(function()
        while wait() do 
            if f.shipfarm then
                pcall(function()
                    if  not  game.Workspace.NPCs:FindFirstChild("Pirate Captain") and not  game.Workspace.NPCs:FindFirstChild("Marine Captain")  then 
                        for i ,  v  in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                            if v.Name == "A3" then 
                            repeat wait()       
                                   
                                    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.Position,v.CFrame * CFrame.new(0,5,0) )  
                            until not f.shipfarm or game.Workspace.NPCs:FindFirstChild("Pirate Captain") or game.Workspace.NPCs:FindFirstChild("Marine Captain") 
                            end
                        end
                    end
                end)
            end
        end
    end)
    spawn(function ()
        while wait() do
            if f.shipfarm then 
                pcall(function()
                    puchship()
                end)
            end
        end
    end)
                     --[[
                            elseif  game.Workspace.NPCs:FindFirstChild("Marine Captain")  then  
                                for i , v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
                                    if string.find(v.Name,"Captain") then 
                                        repeat wait()
                                            toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,0,-30) )  
                                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, v.HumanoidRootPart.Position)
                                        until  not f.shipfarm 
                                        
                                    end
                                end
                        elseif not  game.Workspace.NPCs:FindFirstChild("Pirate Captain")  then  
                        local myship = game:GetService("Workspace").Ships[game.Players.LocalPlayer.Name.."Ship"]
                        for i ,  v  in pairs( game:GetService("Workspace").Ships[game.Players.LocalPlayer.Name.."Ship"]:GetChildren()) do 
                            if v:IsA("MeshPart") then 
                                repeat wait()
                                   
                                    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.Position,v.CFrame * CFrame.new(0,50,0) )  
                                until not f.shipfarm
                            end
                        end
                        elseif not   game.Workspace.NPCs:FindFirstChild("Marine Captain")  then  
                        local myship = game:GetService("Workspace").Ships[game.Players.LocalPlayer.Name.."Ship"]
                        for i ,  v  in pairs(myship:GetDescendants()) do 
                            if v:IsA("MeshPart") then 
                                repeat wait()
                                   
                                    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.Position,v.CFrame * CFrame.new(0,50,0))  
                                until not f.shipfarm
                            end
                        end
                     ]]
    
            spawn(function ()
                pcall(function ()
                while f.shipfarm  do wait()
                            if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                                chages(false)
                                local bv = Instance.new("BodyVelocity")
                                bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                                bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                                bv.Velocity = Vector3.new(0,0,0)
                                
                            end  
                        end
                end)
            end)
            spawn(function ()
                pcall(function ()
                while f.shipfarm == false   do wait()
                                chages(true)
                                for i , v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                                    if v.Name == "BodyVelocity" then
                                            v:Destroy()  
                        
                                end
                            end
                        end
                end)
            end)
    --[[
        
    ]]
    end)
    
    -- Dungeon 
    b5:AddSlider("High Adjuter",1,120,function(high)
        f.HughhDungeon = high
    end)
    
    b5:AddSwitch("Dungeon Farm",false,function(farm)
        f.Dungeon = farm 
        spawn(function()
                while true do wait()
                    if f.Dungeon then 
                        pcall(function ()
                            dungeonpart()
                            for i , v in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                                if v.Name == "DungeonFarm" then 
                                    repeat wait()
                                        toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,v.Position,v.CFrame * CFrame.new(0,3.5,0) )  
                                    until v.Humanoid.Health == 0 or not f.Dungeon
                                end
                            end
                        end)
                    end
                end
    --[[
                    if not game.workspace.Camera:FindFirstChild("A3") then
                    local Part = Instance.new("Part")                                  
                        Part.Size = Vector3.new(10,0.8,10)
                            Part.Parent = game.workspace.Camera
                                Part.Name = "A3"
                            end  
                for i1,v1 in pairs(game.workspace.Camera:GetChildren()) do
                   if v1.Name == "A3" then
                            v1.CanCollide = true
                                v1.Anchored = true
                                v1.Transparency = 0
                                    v1.CFrame = game:GetService("Workspace").Islands["Sky Islands"].SpawnPoint.CFrame *CFrame.new(0,f.HughhDungeon,0)
                    end
                end  
            end
    ]]
    end)
    
        --[[
                while wait() do
            if f.Dungeon then 
                for _ , c in pairs(game:GetService("Workspace").Camera:GetChildren()) do 
                    if c.Name == "A3" then 
                     repeat wait()
                         toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,c.Position,c.CFrame * CFrame.new(0,0,0) )  
                     until f.Dungeon == false 
                    end
                 end
            end
        end
        ]]
        spawn(function()
            while wait() do 
                if f.Dungeon then 
                    pcall(function()
                        for i , v in pairs(game:GetService("Workspace").NPCs:GetDescendants()) do 
                            if v:FindFirstChild("HumanoidRootPart") then 
                                repeat wait()
                                    game:GetService("ReplicatedStorage").Events.GunManager:FireServer("fire",{
                                        ["Start"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
                                        ["Gun"] = "Rifle",
                                        ["go"] = "no",
                                        ["Position"] = v.HumanoidRootPart.Position
                                    })                               
                                    local args = {
                                        [1] = "reload",
                                        [2] = {
                                        ["Gun"] = "Rifle"
                                        }
                                        }
                                        game:GetService("ReplicatedStorage").Events.GunManager.gunFunctions:InvokeServer(unpack(args))
                                until  not f.Dungeon or v.Humanoid.Health == 0 
                            end
                        end
                    end)
                end
            end    
        end
    )
    
    spawn(function ()
        pcall(function ()
        while f.Dungeon  do wait()
                    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("xxx") then
                        chages(false)
                        local bv = Instance.new("BodyVelocity")
                        bv.Name = "xxx"
                        bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                        bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                        bv.Velocity = Vector3.new(0,0,0)
                        
                    end  
                end
        end)
    end)
    spawn(function ()
        pcall(function ()
        while f.Dungeon == false   do wait()
                        chages(true)
                        for i , v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                            if v.Name == "xxx" then
                                    v:Destroy()  
                
                        end
                    end
                end
        end)
    end)
    --[[
    
    ]]

        spawn(function()
        while wait() do 
            if f.Dungeon then 
                pcall(function()
                    prefectblox()
                end)
            end
        end
    end)

    end)
    
    b5:AddSwitch("Reset After Wave 25",false,function(Clear)
        f.Reset = Clear
        spawn(function()
            while wait() do 
                if f.Reset then 
                    local j 
                    for i , v in pairs(game:GetService("Players").MheeX10.PlayerGui.Matchmake:GetChildren()) do 
                        if v.Name == "Wave" then 
                          j = v.Text
                          if j == "Wave 26" then 
                            f.Dungeon = false 
                          end
                        end
                    end
                end
            end
        end)
    end)
elseif game:GetService("Players").LocalPlayer.PlayerGui.HUD.Verson.Text ~= "Version 3.69" then 
    game.Players.LocalPlayer:Kick("Game Update Version \n Pls Join Sever New Version or Wait For Updated")
end


end






-- Check Whitelist System
if decodeApi.data.userkey == key then
    if decodeApi.data.hwid == hwid then
        if decodeApi.data.discord_id == id then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BunnySalf/PIGGY/main/Toggle",true))()
            local request = request or http_request or (syn and syn.request)
                if not request then return end
                local start = 6463
                local invCode = 'Zh9B7wrgtJ'
                for i = start-10, start+1 do
                    spawn(function()
                        pcall(function()
                            request({Url = "http://127.0.0.1:"..tostring(i).."/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({["cmd"] = "INVITE_BROWSER",["nonce"] = game:GetService("HttpService"):GenerateGUID(false),["args"] = {["invite"] = {["code"] = invCode,},["code"] = invCode}})})
                        end)
                    end)
                end
            if game.PlaceId == 4520749081  then
                kingpiece()  
            elseif game.PlaceId == 6381829480 then 
                kingpiece()
            elseif game.PlaceId == 286090429  then
                    arsanel()  
                elseif game.PlaceId == 4442272183 then 
                        BloxFruits()
                    elseif game.PlaceId == 2753915549 then 
                         BloxFruits()
                    elseif game.PlaceId == 6284881984  then
                            Anime()
                        elseif game.PlaceId == 6314042276 then 
                            Anime()
                        elseif game.PlaceId == 5835263912 then
                            Millennium()
                        elseif game.PlaceId == 1730877806 then 
                                gpo()
                        elseif game.PlaceId == 3978370137 then 
                                gpo()
                        else
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/BunnySalf/PIGGY/main/Toggle",true))()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/BunnySalf/Hentai/main/MHEEHUB",true))()
            end
        else
            game.Players.LocalPlayer:Kick("Id Not Correct")
        end
    else
        game.Players.LocalPlayer:Kick("Hwid Not Match")
    end
else
    game.Players.LocalPlayer:Kick("Key Not Match")
end