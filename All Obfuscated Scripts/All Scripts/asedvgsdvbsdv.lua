--[[
	id: f4bMsCjf_zp8Audgfm2Yc
	name: asedvgsdvbsdv
	description: avasdvasdv
	time1: 2021-06-22 05:01:28.723142+00
	time2: 2021-06-22 05:01:28.723143+00
	uploader: UNFLoUJg1ObsPgBSKSN02huJBW76IXWE_T_cKOui
	uploadersession: P_KzzPpvCYhcStl0klxbcX7Ve6bT4y
	flag: f
--]]

setsimulationradius(math.pow(math.huge,math.huge))
local Logs = {}
local Pushers = {}
local GetMouse = Game.Players.LocalPlayer:GetMouse()
for i, v in pairs(workspace:GetDescendants()) do
	if v:IsA("Part") and v.Anchored == false and v.Name == "WoodSection" or v:IsA("Part") and v:IsDescendantOf(game.Workspace.Stores) and v:FindFirstChildOfClass("Decal") then
		table.insert(Logs, v)
		v.Massless = true
		v.CanCollide = false
		if v:FindFirstChildOfClass("BodyPosition") ~= nil then
			v:FindFirstChildOfClass("BodyPosition"):Destroy()
		end
	end
end
for i, v in pairs(Logs) do
	local Pusher = Instance.new("BodyPosition", v)
	table.insert(Pushers, Pusher)
	Pusher.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
end
for i, Pusher in pairs(Pushers) do
	Pusher.Position = Game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, 0, 0))
end
GetMouse.KeyDown:connect(function(button)
	if button == "p" then
		for _, Pusher in pairs(Pushers) do
			Pusher:Destroy()
		end
	end
end)
game.StarterGui:SetCore("SendNotification", {
Title = "Wood Fucker";
Text = "Made by: Shawn#2000";
Duration = 7; })