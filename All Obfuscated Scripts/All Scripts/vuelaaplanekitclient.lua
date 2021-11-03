--[[
	id: tIw08IAp_DFypHIEAkOqg
	name: vuela a320 planekit client
	description: vuela a320 planekit client
	time1: 2021-06-04 21:46:21.92965+00
	time2: 2021-06-04 21:46:21.929651+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
vuelllllllllllllllllllllllllllla
aegus
a320
yeegus a320
buy more stuff
sheeeeeeeeeeesh
http did nothing
i did everything
hi mom
]]
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local starterPlayer = game:GetService("StarterPlayer")

-- Vairables
local ALTITUDE_OFFSET = 7
local localPlayer = players.LocalPlayer
local mouse = localPlayer:GetMouse()
local isSetup = false
local mode = 0 -- 0: Taxi, 1: Fly, 2: Cruise, 3: Stall
local cameraMode = 0 -- 0: Plane (Default), 1: Cockpit 2: Rear Gear
local freeCamera = false
local reversing = false
local originalParent = nil
local plane = nil
local incrementThrottle = false
local decrementThrottle = false
local speed = 0
local desiredSpeed = 0
local increaseSpeed = 0
local maxSpeed = 0
local stallSpeed = 0
local config = nil
local remote = nil
local move = nil
local rotate = nil
local rotateTween = nil
local changeSpeedTween = nil
local stalling = false
local autopilot = false
local isRightClick = false
local camPart = Instance.new("Part")

-- Speed value (required for tweening the speed)
local speedValue = Instance.new("NumberValue")
speedValue:GetPropertyChangedSignal("Value"):Connect(function()
	speed = speedValue.Value
end)

-- Calculate tween time
function calculateTweenTime(current, desired)
	if current < desired then
		return (desired - current) / 10
	else
		return (current - desired) / 10
	end
end

-- Change speed
function changeSpeed(speed)
	desiredSpeed = speed
	
	local currentSpeed = speedValue.Value
	local duration = calculateTweenTime(currentSpeed, desiredSpeed)
	
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
	local tween = tweenService:Create(speedValue, tweenInfo, { Value = desiredSpeed })
	
	if changeSpeedTween and changeSpeedTween:IsA("Tween") then
		changeSpeedTween:Cancel()
	end
	
	changeSpeedTween = tween
	
	tween:Play()
end

-- Get KeyCode value (converts Enum.KeyCode.A to A)
function getKeyCodeName(keyCode)
	return tostring(keyCode):sub(14)
end

-- Setup handler
script.Setup.OnClientEvent:Connect(function(data)
	if data.config and data.remote and data.move and data.rotate then
		-- Set variables
		config = data.config
		remote = data.remote
		rotate = data.rotate
		move = data.move
		
		-- Set speed variables
		maxSpeed = data.config.Plane.Movement.MaxSpeed
		stallSpeed = data.config.Plane.Movement.StallSpeed
		increaseSpeed = maxSpeed / 100
		
		-- Parent plane to player
		originalParent = data.config.Plane.Objects.WeldModel.Parent
		plane = data.config.Plane.Objects.WeldModel
		--data.config.Plane.Objects.WeldModel.Parent = localPlayer.Character
		
		-- Set camera
		workspace.CurrentCamera.CameraType = Enum.CameraType.Attach
		workspace.CurrentCamera.CameraSubject = data.config.Plane.Objects.MainPart
		workspace.CurrentCamera.FieldOfView = 50
		localPlayer.CameraMaxZoomDistance = 2048
		
		-- Set controls in control UI
		script.Parent.controls.Frame.Anchor.keybind.Text = getKeyCodeName(data.config.Controls.Anchor):upper()
		script.Parent.controls.Frame.Brakes.keybind.Text = getKeyCodeName(data.config.Controls.Throttle.Break):upper()
		script.Parent.controls.Frame.Camera.keybind.Text = getKeyCodeName(data.config.Controls.Camera.Change):upper()
		script.Parent.controls.Frame.Cruise.keybind.Text = getKeyCodeName(data.config.Controls.Cruise):upper()
		script.Parent.controls.Frame.Freecam.keybind.Text = getKeyCodeName(data.config.Controls.Camera.Free):upper()
		script.Parent.controls.Frame.Reverse.keybind.Text = getKeyCodeName(data.config.Controls.Throttle.Reverse):upper()
		script.Parent.controls.Frame.ThrottleDown.keybind.Text = getKeyCodeName(data.config.Controls.Throttle.Down):upper()
		script.Parent.controls.Frame.ThrottleUp.keybind.Text = getKeyCodeName(data.config.Controls.Throttle.Up):upper()
		script.Parent.controls.Frame.InstantTakeoff.keybind.Text = getKeyCodeName(data.config.Controls.Throttle.InstantTakeoff):upper()
		script.Parent.controls.Frame.Controls.keybind.Text = getKeyCodeName(data.config.Controls.Controls):upper()
		
		isSetup = true
		
		warn("[vuela planekit]: client active")	
	end
end)

-- Player exited seat
localPlayer.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
	if not localPlayer.Character.Humanoid.Sit then
		isSetup = false
		
		-- Reset movement & rotation
		move.MaxForce = Vector3.new(math.huge, 0, math.huge)
		move.Velocity = Vector3.new(0, 0, 0)
		rotate.MaxTorque = Vector3.new(0, math.huge, 0)
		rotate.P = 150
		rotate.D = 150
		rotate.CFrame = config.Plane.Objects.MainPart.CFrame
		
		-- Unallocate plane parts
		if plane then
			--plane.Parent = originalParent
		end		
		
		-- Reset camera
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		workspace.CurrentCamera.CameraSubject = localPlayer.Character.Humanoid
		workspace.CurrentCamera.FieldOfView = 70
		localPlayer.CameraMaxZoomDistance = starterPlayer.CameraMaxZoomDistance
		
		-- Set anims
		local ok, err = pcall(function()
			script.Parent.ControlSurfaces.Anims.Value.RUDDER.Motor.DesiredAngle = 0
			script.Parent.ControlSurfaces.Anims.Value.R_AILERON.Motor.DesiredAngle = 0
			script.Parent.ControlSurfaces.Anims.Value.L_AILERON.Motor.DesiredAngle = 0
		end)
		
		if not ok then
			warn("[vuela planekit]: client error: " .. err)
		end
		
		-- Delete UI
		script.Parent:Destroy()
	end
end)

-- Mouse right click handler (start)
mouse.Button2Down:Connect(function()
	isRightClick = true
	
	if cameraMode == 1 then
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	end
end)

-- Mouse right click handler (end)
mouse.Button2Up:Connect(function()
	isRightClick = false
	
	if cameraMode == 1 then
		workspace.CurrentCamera.CameraType = Enum.CameraType.Attach
	end
end)

-- Input began handler
userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent then
		if input.KeyCode ~= Enum.KeyCode.Unknown then
			script.Activated:Play()
		end
		
		if input.KeyCode == config.Controls.Throttle.Up then
			incrementThrottle = true
		elseif input.KeyCode == config.Controls.Throttle.Down then
			decrementThrottle = true
		elseif input.KeyCode == config.Controls.Throttle.Reverse then
			reversing = not reversing
		elseif input.KeyCode == config.Controls.Throttle.InstantTakeoff then
			if changeSpeedTween and changeSpeedTween:IsA("Tween") then
				changeSpeedTween:Cancel()
			end
			
			desiredSpeed = stallSpeed + 1
			speedValue.Value = stallSpeed + 1
		elseif input.KeyCode == config.Controls.Throttle.Break then
			changeSpeed(0)
		elseif input.KeyCode == config.Controls.Camera.Change then
			if freeCamera then return end
			
			cameraMode = cameraMode + 1
			
			if cameraMode > 2 then
				cameraMode = 0
			end
			
			if cameraMode == 0 then
				-- Plane
				workspace.CurrentCamera.CameraType = Enum.CameraType.Attach
				workspace.CurrentCamera.CameraSubject = config.Plane.Objects.MainPart
				localPlayer.CameraMaxZoomDistance = 2048
			elseif cameraMode == 1 then
				-- Cockpit
				workspace.CurrentCamera.CameraType = Enum.CameraType.Attach
				workspace.CurrentCamera.CameraSubject = localPlayer.Character.Head
				localPlayer.CameraMaxZoomDistance = 0
				
				for _,part in next,localPlayer.Character:GetDescendants() do
					if part.Name ~= "HumanoidRootPart" and part:IsA("BasePart") and not part:IsDescendantOf(plane) then
						part.Transparency = 1
					end
				end
			elseif cameraMode == 2 then
				-- Rear Gear
				workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
				workspace.CurrentCamera.CameraSubject = config.Views.RearGear
				localPlayer.CameraMaxZoomDistance = 0
				
				for _,part in next,localPlayer.Character:GetDescendants() do
					if part.Name ~= "HumanoidRootPart" and part:IsA("BasePart") and not part:IsDescendantOf(plane) then
						part.Transparency = 0
					end
				end
			end
		elseif input.KeyCode == config.Controls.Camera.Free then
			freeCamera = not freeCamera
			autopilot = freeCamera
			cameraMode = 0			
			
			if not freeCamera then
				workspace.CurrentCamera.CameraType = Enum.CameraType.Attach
				workspace.CurrentCamera.CameraSubject = config.Plane.Objects.MainPart
				localPlayer.CameraMaxZoomDistance = 2048
			else
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
				workspace.CurrentCamera.CameraSubject = localPlayer.Character.Humanoid
				localPlayer.CameraMaxZoomDistance = 2048
				workspace.CurrentCamera.FieldOfView = 50
			end
		elseif input.KeyCode == config.Controls.Cruise then
			if mode == 1 then
				mode = 2
			elseif mode == 2 then
				mode = 1
			end
		elseif input.KeyCode == config.Controls.Anchor then
			remote:FireServer("ANCHOR")
		elseif input.KeyCode == config.Controls.Controls then
			script.Parent.controls.Visible = not script.Parent.controls.Visible
		end
	end
end)

-- Input end handler
userInputService.InputEnded:Connect(function(input)
	if input.KeyCode == config.Controls.Throttle.Up then
		incrementThrottle = false
	elseif input.KeyCode == config.Controls.Throttle.Down then
		decrementThrottle = false
	end
end)

-- Render handler (main loop)
runService.RenderStepped:Connect(function(step)
	if not isSetup then return end
	
	-- Increment throttle
	if incrementThrottle then
		if mode == 0 or mode == 1 then
			if (desiredSpeed + increaseSpeed) > maxSpeed then
				changeSpeed(maxSpeed)
			else
				changeSpeed(desiredSpeed + increaseSpeed)
			end
		end
	end
	
	-- Decrement throttle
	if decrementThrottle then
		if mode == 0 or mode == 1 then
			if (desiredSpeed - increaseSpeed) < 0 then
				changeSpeed(0)
			else
				changeSpeed(desiredSpeed - increaseSpeed)
			end
		end
	end
	
	-- Check for stall
	if mode == 0 then
		if game.Workspace:FindPartOnRay(Ray.new(config.Plane.Objects.MainPart.Position, Vector3.new(0, -(config.Plane.Objects.MainPart.Position.Y + 5 + (config.Plane.Objects.MainPart.Size.Y / 2)), 0)), plane) then -- should prob use world:Raycat()
			stalling = false
		else
			stalling = true
		end
	else
		stalling = false
	end
	
	-- Camera
	local function setCamera(obj)
		local x, y, z = obj.CFrame:ToEulerAnglesXYZ()

		camPart.CFrame = camPart.CFrame:Lerp(
			CFrame.new(
				(obj.CFrame - obj.CFrame.Position).Position
			) 
				* CFrame.Angles(obj.CFrame:ToEulerAnglesXYZ()),
			7 * step
		)

		workspace.CurrentCamera.CFrame = (
			CFrame.new(obj.CFrame.Position)
				* camPart.CFrame
				* CFrame.new(0, 0, 0)
				+ Vector3.new(0, 0, 0)
		)
	end
	
	if cameraMode > 0  then
		if cameraMode == 1 and not isRightClick then
			--setCamera(localPlayer.Character.Head)
		elseif cameraMode == 2 then
			setCamera(config.Views.RearGear)
		end
	end
	
	-- Bank
	local bank = (((mouse.ViewSizeX / 2) - mouse.X) / (mouse.ViewSizeX / 2)) * 90
	bank = bank < -90 and -90 or bank > 90 and 90 or bank
	bank = math.clamp(bank, -74, 74)
	
	-- Bank stat
	if mode ~= 0 then
		-- Rotation
		if rotateTween and rotateTween:IsA("Tween") then
			rotateTween:Cancel()
		end
		
		rotateTween = tweenService:Create(
			script.Parent.core.Bank.Main,
			TweenInfo.new(0.1144, Enum.EasingStyle.Quad),
			{
				Rotation = math.clamp(config.Plane.Objects.MainPart.Orientation.Z, -74, 74);
			}
		)
		
		rotateTween:Play()
		
		-- Position
		script.Parent.core.Bank.Main:TweenPosition(
			UDim2.fromScale(
				0.5,
				0.508 + math.clamp(config.Plane.Objects.MainPart.Orientation.X / 144, -0.31144, 0.31144)
			),
			Enum.EasingDirection.InOut,
			Enum.EasingStyle.Quad,
			0.1144,
			true
		)
	end
	
	-- Altitude stat
	script.Parent.core.Altitude.Bar.Value.Text = tostring(math.floor(config.Plane.Objects.MainPart.Position.Y - ALTITUDE_OFFSET))
	script.Parent.core.Altitude.Display.Slider:TweenPosition(
		UDim2.fromScale(
			0.5,
			0.5 + (0.00185 * math.floor(config.Plane.Objects.MainPart.Position.Y - ALTITUDE_OFFSET))
		),
		Enum.EasingDirection.InOut,
		Enum.EasingStyle.Quad,
		0.1144,
		true
	)
	
	-- Throttle stat
	script.Parent.core.Throttle.core.Slider.Value.Text = tostring(math.ceil(desiredSpeed / increaseSpeed))
	script.Parent.core.Throttle.core.Slider:TweenPosition(
		UDim2.fromScale(
			0.5,
			math.clamp(
				1 - (math.ceil(desiredSpeed / increaseSpeed) / 131),
				0.186,
				1
			)
		),
		Enum.EasingDirection.InOut,
		Enum.EasingStyle.Quad,
		0.1144,
		true
	)
	
	-- Speed stat
	script.Parent.core.Speed.Bar.Value.Text = math.floor(speed)--math.floor(config.Plane.Objects.MainPart.Velocity.Magnitude)
	script.Parent.core.Speed.Display.Slider:TweenPosition(
		UDim2.fromScale(
			0.5,
			1.61 + (0.0186 * math.floor(speed)) -- config.Plane.Objects.MainPart.Velocity.Magnitude
		),
		Enum.EasingDirection.InOut,
		Enum.EasingStyle.Quad,
		0.1144,
		true
	)
	
	-- Reverse stat
	if reversing then
		script.Parent.core.Throttle.core.Slider.Value.Visible = false
		script.Parent.core.Throttle.core.Slider.reverse.Visible = true
	else
		script.Parent.core.Throttle.core.Slider.Value.Visible = true
		script.Parent.core.Throttle.core.Slider.reverse.Visible = false
	end
	
	-- Calculate mode
	if (mode == 0 or mode == 1) and not reversing then
		if math.floor(speed) > math.floor(stallSpeed) then
			mode = 1
		else
			if mode ~= 0 then
				mode = 0
			end
		end
	end
	
	-- Movement
	if mode == 0 and not isRightClick then
		-- Taxi
		local times = 1
		
		if reversing then
			times = -times
		end
		
		move.Velocity = config.Plane.Objects.MainPart.CFrame.LookVector * times * speed
		
		if speed < 2 then
			move.MaxForce = Vector3.new(0, 0, 0)
			rotate.MaxTorque = Vector3.new(0, 0, 0)
		else
			move.MaxForce = Vector3.new(math.huge, 0, math.huge)
			rotate.MaxTorque = Vector3.new(0, math.huge, 0)
			
			if not autopilot then
				rotate.CFrame = CFrame.new(config.Plane.Objects.MainPart.Position, mouse.Hit.Position)
			end
		end
	elseif mode == 1 and not isRightClick then
		-- Fly		
		move.Velocity = config.Plane.Objects.MainPart.CFrame.LookVector * speed
		move.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

		rotate.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		
		if not autopilot then
			rotate.CFrame = mouse.Hit * CFrame.Angles(0, 0, math.rad(bank))
		end
	elseif mode == 2 then --  and not isRightClick
		-- Cruise
		move.Velocity = Vector3.new(0, 0, 0)

		rotate.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		rotate.CFrame = CFrame.Angles(0, config.Plane.Objects.MainPart.Orientation.Y - 3.5, 0)
	end
	
	-- Stall
	if stalling then
		script.Parent.stall.Visible = true
		
		move.MaxForce = Vector3.new(0,0,0)
		rotate.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		rotate.CFrame = mouse.Hit * CFrame.Angles(0, 0, math.rad(bank))
	else
		script.Parent.stall.Visible = false
	end
end)