--[[
	id: viT_d4_K0gPHx_ENsYhFJ
	name: Shower System
	description: MDEV TECH
	time1: 2021-05-04 20:16:05.22733+00
	time2: 2021-05-04 20:16:05.227331+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

local module = {}
module.ShowerSystem = function(Screen)
	--MyPodStuff

	local HubID = "719299270339199077"
	local Product = "Shower System"
	local MainModel = Screen.SurfaceGui
	local OwnsLicense = false
	local myPod = require(4460787902)

	-- Services

	local http = game:GetService("HttpService")

	-- Whitelist Checker

	function httpe()
		local s = pcall(function()
			game:GetService('HttpService'):GetAsync('http://www.google.com/robots.txt') 
		end)
		return s
	end

	if httpe() == false then
		print("Enable HTTP Service to use this product!")
		script:Destroy()
	end

	local PlaceId = game.PlaceId
	local PlaceInfo = game:GetService("MarketplaceService"):GetProductInfo(PlaceId)
	local gameOwner = nil
	if game.CreatorType == Enum.CreatorType.Group then
		gameOwner = game:GetService("GroupService"):GetGroupInfoAsync(PlaceInfo.Creator.CreatorTargetId).Owner.Id
	else
		gameOwner = game.CreatorId
	end

	myPod:GetAsync(HubID, Product, gameOwner, function(Success, Value)
		if Success == false then
			if Screen.SurfaceGui.Frame:FindFirstChild("nolicense") then
				Screen.SurfaceGui.Frame.nolicense.Visible = true
			end
			Screen.SurfaceGui.Frame.Frame:Destroy()
			script.Parent:Destroy()
		else
			OwnsLicense = true
		end
	end)

	repeat wait() until OwnsLicense == true

	--Main Code


	--power

	local led = Screen.Parent.Model.Led
	local shower = Screen.Parent.Parent.Showerhead
	local water = shower.Union.ParticleEmitter
	local ind = Screen.SurfaceGui.Frame.Frame.Status
	local mist = Screen.Parent.Parent.Mist.Mist
	local TempVal = Screen.SurfaceGui.Frame.TempVal
	local Autocount = Screen.SurfaceGui.Frame.Autocount
	local enabled = Screen.SurfaceGui.Frame.WaterStatus
	local beep = Screen.beep
	local waternoise = shower.Union.Shower
	local debounce = false
	Screen.Parent.Model.Power.ClickDetector.MouseClick:Connect(function()
		if debounce == true then return end
		if enabled.Value == false then
			debounce = true
			enabled.Value = true
			Autocount.Value = 0
			Autocount.Script.Disabled = false
			beep:Play()
			led.BrickColor = BrickColor.new("Deep blue")
			ind.Text = "WATER ON"
			wait(1)
			shower.Led1.BrickColor = BrickColor.new("Royal purple")
			shower.Led1.Material = Enum.Material.Neon
			shower.Led2.BrickColor = BrickColor.new("Royal purple")
			shower.Led2.Material = Enum.Material.Neon
			shower.Led3.BrickColor = BrickColor.new("Royal purple")
			shower.Led3.Material = Enum.Material.Neon
			shower.Led4.BrickColor = BrickColor.new("Royal purple")
			shower.Led4.Material = Enum.Material.Neon
			wait(1)
			if TempVal.Value >= 30 then
				mist.Enabled = true
			end
			water.Enabled = true
			waternoise:Play()
		elseif enabled.Value == true then
			debounce = true
			enabled.Value = false
			Autocount.Script.Disabled = true
			beep:Play()
			led.BrickColor = BrickColor.new("Medium stone grey")
			wait(1)
			water.Enabled = false
			waternoise:Stop()
			ind.Text = "WATER OFF"
			wait(1)
			shower.Led1.BrickColor = BrickColor.new("Medium stone grey")
			shower.Led1.Material = Enum.Material.SmoothPlastic
			shower.Led2.BrickColor = BrickColor.new("Medium stone grey")
			shower.Led2.Material = Enum.Material.SmoothPlastic
			shower.Led3.BrickColor = BrickColor.new("Medium stone grey")
			shower.Led3.Material = Enum.Material.SmoothPlastic
			shower.Led4.BrickColor = BrickColor.new("Medium stone grey")
			shower.Led4.Material = Enum.Material.SmoothPlastic
			mist.Enabled = false
		end
		wait()
		debounce = false
	end)

	--tempdown

	local tempval = Screen.SurfaceGui.Frame.TempVal
	local tempread = Screen.SurfaceGui.Frame.Frame.Temp
	
	Screen.Parent.tempdown.SurfaceGui.TextButton.MouseButton1Click:Connect(function()
		if debounce == true then return end
		if tempval.Value ~= 10 then
			debounce = true
			Autocount.Value = 0
			beep:Play()
			tempval.Value = tempval.Value - 1
			tempread.Text = tempval.Value.."°C"
		end
		if tempval.Value == 29 then
			mist.Enabled = false
		end
		wait()
		debounce = false
	end)

	--flowdown

	local flow = Screen.SurfaceGui.Frame.Frame
	local flowval = Screen.SurfaceGui.Frame.FlowVal
	
	Screen.Parent.flowdown.SurfaceGui.TextButton.MouseButton1Click:Connect(function()
		if debounce == true then return end
		if flowval.Value == 5 then
			debounce = true
			beep:Play()
			flow.Flow5.Visible = false
			flowval.Value = 4
			water.Rate = 80
			waternoise.PlaybackSpeed = 1.75
			Autocount.Value = 0
		elseif flowval.Value == 4 then
			debounce = true
			beep:Play()
			flow.Flow4.Visible = false
			flowval.Value = 3
			water.Rate = 60
			waternoise.PlaybackSpeed = 1.5
			Autocount.Value = 0
		elseif flowval.Value == 3 then
			debounce = true
			beep:Play()
			flow.Flow3.Visible = false
			flowval.Value = 2
			water.Rate = 40
			waternoise.PlaybackSpeed = 1.25
			Autocount.Value = 0
		elseif flowval.Value == 2 then
			debounce = true
			beep:Play()
			flow.Flow2.Visible = false
			flowval.Value = 1
			water.Rate = 20
			waternoise.PlaybackSpeed = 1
			Autocount.Value = 0
		end
		wait(1)
		debounce = false
	end)

	--flowup

	local flow = Screen.SurfaceGui.Frame.Frame
	local flowval = Screen.SurfaceGui.Frame.FlowVal
	
	Screen.Parent.flowup.SurfaceGui.TextButton.MouseButton1Click:Connect(function()
		if debounce == true then return end
		if flowval.Value == 1 then
			debounce = true
			beep:Play()
			flow.Flow2.Visible = true
			flowval.Value = 2
			water.Rate = 40
			waternoise.PlaybackSpeed = 1.25
			Autocount.Value = 0
		elseif flowval.Value == 2 then
			debounce = true
			beep:Play()
			flow.Flow3.Visible = true
			flowval.Value = 3
			water.Rate = 60
			waternoise.PlaybackSpeed = 1.5
			Autocount.Value = 0
		elseif flowval.Value == 3 then
			debounce = true
			beep:Play()
			flow.Flow4.Visible = true
			flowval.Value = 4
			water.Rate = 80
			waternoise.PlaybackSpeed = 1.75
			Autocount.Value = 0
		elseif flowval.Value == 4 then
			debounce = true
			beep:Play()
			flow.Flow5.Visible = true
			flowval.Value = 5
			water.Rate = 100
			waternoise.PlaybackSpeed = 2
			Autocount.Value = 0
		end
		wait(1)
		debounce = false
	end)

	--tempup

	local status = Screen.SurfaceGui.Frame.Frame.Status
	local debounce = false
	
	Screen.Parent.tempup.SurfaceGui.TextButton.MouseButton1Click:Connect(function()
		if debounce == true then return end
		if tempval.Value ~= 45 then
			debounce = true
			Autocount.Value = 0
			beep:Play()
			tempval.Value = tempval.Value + 1
			tempread.Text = tempval.Value.."°C"
		end
		if tempval.Value == 30 and status.Text == "WATER ON" then
			mist.Enabled = true
		end
		wait()
		debounce = false
	end)
end
return module
