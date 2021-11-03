--[[
	id: CWCjDYOVqEyW56Y119iGa
	name: Airsteps Controller
	description: Steps Controller 
	time1: 2021-06-12 17:53:38.94943+00
	time2: 2021-06-12 17:53:38.949431+00
	uploader: 5lHL6z5TWPzh-xTZ9CoywkC-nC9Ttct1a2wfEpwy
	uploadersession: lA0pqlse9Xq2s9ET5uKls31oMu56-i
	flag: f
--]]

vehicle = script.Parent.Steps.Value
main = vehicle.MainMoving
motorstuff = script.Parent.Steps.Value.Misc


local rs = game:GetService("RunService")

local hold = false

local turnRate = 0.09 -- radians/second

local turnRate2 = -0.09 -- radians/second


-- Raise/Lower Functions

function setRampRaiseT()
	hold = true
	while hold do
		motorstuff.StepMotor.A.Motor.DesiredAngle += turnRate * rs.Heartbeat:Wait()
		motorstuff.BasketMotor.A.Motor.DesiredAngle -= turnRate * rs.heartbeat:Wait()
	end
end

function setRampLowerT()
	hold = true
	while hold do
		motorstuff.StepMotor.A.Motor.DesiredAngle += turnRate2 * rs.Heartbeat:Wait()
		motorstuff.BasketMotor.A.Motor.DesiredAngle -= turnRate2 * rs.heartbeat:Wait()
	end
end

if motorstuff.StepMotor.A.Motor.DesiredAngle > 0.135 then
	motorstuff.StepMotor.A.Motor.DesiredAngle = 0.135
end

if motorstuff.BasketMotor.A.Motor.DesiredAngle < -0.135 then
	motorstuff.BasketMotor.A.Motor.DesiredAngle = -0.135
end

script.Parent.StepsUP.MouseButton1Down:Connect(setRampRaiseT)

script.Parent.StepsUP.MouseButton1Up:Connect(function() hold = false end)


script.Parent.StepsDOWN.MouseButton1Down:Connect(setRampLowerT)

script.Parent.StepsDOWN.MouseButton1Up:Connect(function() hold = false end)



-- Misc Functions

Generator = false

function StepGenerator()
	if Generator == false then
		script.Parent.Steps.Value.Body.Gen.Sound:Play()
		Generator = true
		
	elseif Generator == true then
		script.Parent.Steps.Value.Body.Gen.Sound:Stop()
		Generator = false
	end
end


script.Parent.StepsGenerator.MouseButton1Click:Connect(StepGenerator)


Lighting = false

function StepLighting()
	if Lighting == false then
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightLeft.SurfaceLight.Enabled = true
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightLeft.Material = Enum.Material.Neon
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightRight.SurfaceLight.Enabled = true
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightRight.Material = Enum.Material.Neon
		
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightLeft.Light.Light.Enabled = true
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightLeft.Light.SurfaceLight.Enabled = true
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightRight.Light.Light.Enabled = true
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightRight.Light.SurfaceLight.Enabled = true
		Lighting = true
		
	elseif Lighting == true then
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightLeft.SurfaceLight.Enabled = false
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightLeft.Material = Enum.Material.SmoothPlastic
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightRight.SurfaceLight.Enabled = false
		script.Parent.Steps.Value.Misc.StepMotor.Model.LightRight.Material = Enum.Material.SmoothPlastic
		
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightLeft.Light.Light.Enabled = false
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightLeft.Light.SurfaceLight.Enabled = false
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightRight.Light.Light.Enabled = false
		script.Parent.Steps.Value.Misc.BasketMotor.BeamLightRight.Light.SurfaceLight.Enabled = false
		Lighting = false
	end
end


script.Parent.StepsLighting.MouseButton1Click:Connect(StepLighting)

Anchored = false

function StepAnchor()
	if Anchored == false then
		script.Parent.Steps.Value.Misc.StepMotor.Main.Anchored = true
		Anchored = true
		
	elseif Anchored == true then
		script.Parent.Steps.Value.Misc.StepMotor.Main.Anchored = false
		Anchored = false
	end
end

script.Parent.StepsAnchor.MouseButton1Click:Connect(StepAnchor)

Beacon = false

function StepBeacon()
	if Beacon == false then
		script.Parent.Steps.Value.Body.Beacon.BeaconPart.Left.Enabled = true
		script.Parent.Steps.Value.Body.Beacon.BeaconPart.Right.Enabled = true
		script.Parent.Steps.Value.Body.Beacon.BeaconPart.Material = Enum.Material.Neon
		Beacon = true
		
	elseif Beacon == true then
		Beacon = false
		script.Parent.Steps.Value.Body.Beacon.BeaconPart.Left.Enabled = false
		script.Parent.Steps.Value.Body.Beacon.BeaconPart.Right.Enabled = false
		script.Parent.Steps.Value.Body.Beacon.BeaconPart.Material = Enum.Material.Glass
	end
end

script.Parent.StepsBeacon.MouseButton1Click:Connect(StepBeacon)


-- Preset Heights

function VuelaA320()
	motorstuff.StepMotor.A.Motor.DesiredAngle = 0.137
	motorstuff.BasketMotor.A.Motor.DesiredAngle = -0.137
end

script.Parent.VuelaA320.MouseButton1Click:Connect(VuelaA320)

function Alex737()
	motorstuff.StepMotor.A.Motor.DesiredAngle = -0.174
	motorstuff.BasketMotor.A.Motor.DesiredAngle = 0.174
end

script.Parent.Alex737.MouseButton1Click:Connect(Alex737)

function EWA320()
	motorstuff.StepMotor.A.Motor.DesiredAngle = 0
	motorstuff.BasketMotor.A.Motor.DesiredAngle = 0
end

script.Parent.EWA320.MouseButton1Click:Connect(EWA320)

function Lolee737()
	motorstuff.StepMotor.A.Motor.DesiredAngle = -0.035
	motorstuff.BasketMotor.A.Motor.DesiredAngle = 0.035
end

script.Parent.Lolee737.MouseButton1Click:Connect(Lolee737)

function Custom1()
	motorstuff.StepMotor.A.Motor.DesiredAngle = script.Parent.Steps.Value.EditMe.Custom1A.Value
	motorstuff.BasketMotor.A.Motor.DesiredAngle = script.Parent.Steps.Value.EditMe.Custom1B.Value
end

script.Parent.Custom1.MouseButton1Click:Connect(Custom1)

function Custom2()
	motorstuff.StepMotor.A.Motor.DesiredAngle = script.Parent.Steps.Value.EditMe.Custom2A.Value
	motorstuff.BasketMotor.A.Motor.DesiredAngle = script.Parent.Steps.Value.EditMe.Custom2B.Value
end

script.Parent.Custom2.MouseButton1Click:Connect(Custom2)