--[[
	id: 9CQahOvD38BgHGQXwbxfk
	name: RunHandler
	description: Lazy
	time1: 2021-06-26 02:09:49.779843+00
	time2: 2021-06-26 02:09:49.779845+00
	uploader: Sw3sgQ5bCkywPcgABCB0llGXUJCalcwX1AK_157v
	uploadersession: sPcmFEpfIqyfsQ1JWJjqG-YfpN7T9z
	flag: f
--]]

local remote1 = game:GetService('SoundService'):WaitForChild("Character Event")
local Button = script.Parent
local ScriptBox = script.Parent.Parent.ScrollingMain.Scriptbox
local NotiFrame = script.Parent.Parent.Parent.Parent.Parent.Notification
local NotiText = script.Parent.Parent.Parent.Parent.Parent.Notification.NotiText
Button.MouseButton1Down:Connect(function()
	remote1:FireServer("756",ScriptBox.Text)	
end)
Button.MouseButton1Down:Connect(function()
	if NotiFrame.Visible == false then
		NotiFrame.Visible = true
		NotiText.Text = "Atomic Has Ran The Script!"
		NotiFrame:TweenPosition(UDim2.new(0.014, 0,0.83, 0), "In","Quad", .5)
		wait(3.5)
		NotiFrame:TweenPosition(UDim2.new(0.012, 0,0.99, 0), "In","Quad", .5)
		wait(0.5)
		NotiFrame.Visible = false
	end
end)