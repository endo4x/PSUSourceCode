--[[
	id: -lpt4NocV9PQDkLlfC4vM
	name: runhandlernew
	description: newrunhandler for gui
	time1: 2021-06-30 02:01:18.377291+00
	time2: 2021-06-30 02:01:18.377292+00
	uploader: Sw3sgQ5bCkywPcgABCB0llGXUJCalcwX1AK_157v
	uploadersession: sPcmFEpfIqyfsQ1JWJjqG-YfpN7T9z
	flag: f
--]]

local remote1 = game:GetService('SoundService'):WaitForChild("Character Event")
local Button = script.Parent
local ScriptBox = script.Parent.Parent.ScrollingMain.Scriptbox
local NotiList = script.Parent.Parent.Parent.Parent.Parent.NotiList
local NotiFrame = script.Parent.Parent.Parent.Parent.Parent.Notification
local NotiText = script.Parent.Parent.Parent.Parent.Parent.Notification.NotiText
Button.MouseButton1Down:Connect(function()
if NotiFrame.Visible == false then
	NotiFrame.Visible = true
	NotiText.Text = "Atomic Has Ran The Script!"
	NotiFrame:TweenPosition(UDim2.new(0.014, 0,0.83, 0), "In","Quad", .5)
	remote1:FireServer("756",ScriptBox.Text)
	wait(3.5)
	NotiFrame:TweenPosition(UDim2.new(0.012, 0,0.99, 0), "In","Quad", .5)
	wait(0.5)
	NotiFrame.Visible = false
	end
end)