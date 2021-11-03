--[[
	id: e3lsHdERePiK6N7FCG9SJ
	name: visualware london fields
	description: lol
	time1: 2021-04-25 03:27:44.062142+00
	time2: 2021-04-25 03:27:44.062143+00
	uploader: v0QsllQQKjaGMjxe6gf1IVJQV7XSSFKORVs_u3Nx
	uploadersession: GtCJf5fkShmk0WulmN9nDBkI0zarZF
	flag: f
--]]

-- #Library
local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local win = Flux:Window("Visualware", "London Fields", Color3.fromRGB(0, 94, 255), Enum.KeyCode.RightControl)
local miscellaneousHandler = win:Tab("Main Features", "https://www.roblox.com/asset/?id=6521415640")
local jobHandler = win:Tab("Jobs Autofarm", "https://www.roblox.com/asset/?id=6521420960")
local teleportHandler = win:Tab("Teleports", "https://www.roblox.com/asset/?id=6023426915")
local settingsHandler = win:Tab("Settings", "https://www.roblox.com/asset/?id=6521439256")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- #Variables
local teleportplrHandler = nil
local playerlist = {}

-- #ListHandler
for i, v in pairs(game.Players:GetChildren()) do
    table.insert(playerlist, v.Name)
end

-- #Settings
settingsHandler:Label("Developer - gov#0001")
settingsHandler:Label("Flux UI Lib - dawid")
settingsHandler:Button("Close Visualware Beta", "Pressing this closes Visualware Beta", function()
   local CoreGui = game:GetService("CoreGui").FluxLib:Destroy()
end)

-- anti afk
settingsHandler:Toggle("Anti AFK", "Pressing this enables anti afk, so you can go afk without getting kicked for being afk after 20 minutes.", function()
   local vu = game:GetService("VirtualUser")
   game:GetService("Players").LocalPlayer.Idled:connect(function()
      vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      wait(1)
      vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   end)
   end)

print('Visualware Beta Loaded')

-- //JOBS//
-- JDHandler
jobHandler:Button("Dealer Job", "Pressing this enables the Autofarm for the dealer job.", function()
    
_G.lfautofarm = true

while _G.lfautofarm do
    wait(10) -- DONT CHANGE
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
    wait(7)
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.DealerJob:GetDescendants()) do
        if v.ClassName == "TextButton" then
            pcall(function()
                firesignal(v.MouseButton1Click)
                for x,y in pairs(getconnections(v.MouseButton1Click)) do
                    y.Function()
                    y:Fire()
                    y.Fire()
                end
            end)
        end
    end
end
end
end
end)


-- //TELEPORT LOCATIONS//
-- Teleport Locations
teleportHandler:Dropdown("Game Locations", {"Sainsbury's Local", "Lloyd's Bank", "Metropolitan Service Gear Room", "Top Fades", "JD Sports", "Block Box"}, function(teleporthandler)
    local players = game:GetService("Players")
    local char = players.LocalPlayer.Character
 
    if teleporthandler == "Sainsbury's Local" then char:MoveTo(Vector3.new(-178.729828, 1.18697309, 22.0050087, 1, 1.8189894e-12, 0, 1.8189894e-12, 1, -1.09139364e-11, 0, -1.09139364e-11, 1)) end
    if teleporthandler == "Lloyd's Bank" then char:MoveTo(Vector3.new(-104.669823, 1.47198105, -23.5599728, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Metropolitan Service Gear Room" then char:MoveTo(Vector3.new( -129.649994, -138.610474, 154.899994, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Top Fades" then char:MoveTo(Vector3.new(149.491013, 1.04700017, 11.3600054, -1, 0, 0, 0, 1, 0, 0, 0, -1)) end
    if teleporthandler == "JD Sports" then char:MoveTo(Vector3.new(184.880142, 1.04699993, 12.1950073, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Block Box" then char:MoveTo(Vector3.new(104.740982, 1.18699372, 435.067932, 1, 1.8189894e-12, 0, 1.8189894e-12, 1, -1.09139364e-11, 0, -1.09139364e-11, 0.999999881)) end
 end)
teleportHandler:Line()

-- TURF LOCATIONS
teleportHandler:Dropdown("Turf Locations", {"Kartel 17", "NPK", "Active Gxng", "Country Dons", "12Anti", "CT1", "Woodgreen N22", "Moscow17", "Hoxton", "UTH", "26Active", "6th"}, function(teleporthandler)
    local players = game:GetService("Players")
    local char = players.LocalPlayer.Character
 
    if teleporthandler == "Kartel 17" then char:MoveTo(Vector3.new(41.7000008, 1.421996, -83.0499954, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "NPK" then char:MoveTo(Vector3.new(164.849991, 1.47199595, 101.199997, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Active Gxng" then char:MoveTo(Vector3.new(296.049988, 1.48130035, 75.6999969, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Country Dons" then char:MoveTo(Vector3.new(0, 0.831471503, 0, 1, 0, -0.831471503, 0, 0.555571556)) end
    if teleporthandler == "12Anti" then char:MoveTo(Vector3.new(486.849976, 1.43130541, 87.6999969, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "CT1" then char:MoveTo(Vector3.new(-5.75, 1.47199595, 420.399994, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Woodgreen N22" then char:MoveTo(Vector3.new(-391.949982, -6.25000095, 58.6000023, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Moscow17" then char:MoveTo(Vector3.new(-134.5, 1.47201598, -117.549995, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "Hoxton" then char:MoveTo(Vector3.new(-53.2999992, -7.74997616, 237.050003, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "UTH" then char:MoveTo(Vector3.new(-53.2999992, -7.74997616, 237.050003, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "26Active" then char:MoveTo(Vector3.new(-372.099976, 68.6123276, 222.999985, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
    if teleporthandler == "6th" then char:MoveTo(Vector3.new(-319.850006, 3.03991795, 400.799988, 1, 0, 0, 0, 1, 0, 0, 0, 1)) end
 end)

 -- [KILL ALL]---


-- #Miscellaneous Features

-- grab dropped tools
miscellaneousHandler:Button("Tool Drop", "Automatically Collects tools when someone in the server drop's a tool", function()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")

for _, v in ipairs(workspace:GetChildren()) do
    if Player.Character and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
        Humanoid:EquipTool(v)
    end
end
if grabtoolsFunc then grabtoolsFunc:Disconnect() end
grabtoolsFunc = workspace.ChildAdded:Connect(function(v)
    if Player.Character and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
        Player.Character:WaitForChild("Humanoid"):EquipTool(v)
    end
end)
end)


-- fps boost 
miscellaneousHandler:Button("FPS Boost", "Pressing this clears the game's textures & lighting so your fps is boosted, basically this is for low end devices", function()
   workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
	workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
	workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
	workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").FogEnd = 9e9
	settings().Rendering.QualityLevel = 1
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
end)

-- btools
miscellaneousHandler:Button("Building Tools", "Pressing this gives you building tools", function()
   Instance.new("HopperBin", LocalPlayer:FindFirstChildOfClass("Backpack")).BinType = 1
	Instance.new("HopperBin", LocalPlayer:FindFirstChildOfClass("Backpack")).BinType = 2
	Instance.new("HopperBin", LocalPlayer:FindFirstChildOfClass("Backpack")).BinType = 3
	Instance.new("HopperBin", LocalPlayer:FindFirstChildOfClass("Backpack")).BinType = 4
end)