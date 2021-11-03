--[[
	id: IfGtViQBODJIC_WTWOkln
	name: other controller
	description: yes
	time1: 2021-06-12 19:34:35.724601+00
	time2: 2021-06-12 19:34:35.724602+00
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

