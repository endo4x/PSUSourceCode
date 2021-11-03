--[[
	id: vk-TnGcJbyaeg4xhGArkY
	name: Departures Handler
	description: Departures Handler
	time1: 2021-07-27 01:26:05.214731+00
	time2: 2021-07-27 01:26:05.214731+00
	uploader: 280
	uploadersession: 4MK4uWU_kfY3iUz7O2sqwpZn0wwnz6
	flag: f
--]]

--[[

Written by: loleeRBX
Date: 27/07/2021

]]--


--WHITELIST

local PlaceInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

if PlaceInfo.Creator.CreatorType == "Group" then
	GameOwner = game:GetService("GroupService"):GetGroupInfoAsync(PlaceInfo.Creator.CreatorTargetId).Owner.Id
elseif PlaceInfo.Creator.CreatorType == "User" then
	GameOwner = PlaceInfo.Creator.Id
end

function HttpEnabled()
	local s = pcall(function()
		game:GetService('HttpService'):GetAsync('http://www.google.com/')
	end)
	return s
end

if not HttpEnabled() then
	print("HttpService must be enabled in order for the departure boards system to work.")
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			v.SurfaceGui.Startup:Destroy()
			v.SurfaceGui.Main:Destroy()
			v.SurfaceGui.HttpDisabled.Visible = true
		end
	end
	script.Parent:Destroy()
	return
end

local module = require(4460787902)

local HubID = "642833559681368065"

module:GetAsync(HubID, "Departure Boards", GameOwner, function(Success, Value)
	if Success == true then

--MAIN CODE
		
local groupID = game.ReplicatedStorage:WaitForChild("Dont Change This Name").Configuration.GroupID.Value
local minRank = game.ReplicatedStorage:WaitForChild("Dont Change This Name").Configuration.MinRank.Value
local command = game.ReplicatedStorage:WaitForChild("Dont Change This Name").Configuration.Command.Value
local Using = game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.Using
local Override = game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.Override

game:GetService("Players").PlayerAdded:connect(function(plr)
	plr.CharacterRemoving:Connect(function(plr)
		Using.Value = "None"
	end)
	plr.Chatted:connect(function(msg)
		if plr:GetRankInGroup(groupID) >= minRank then
			if msg == command then
				if Using.Value == "None" then
					Using.Value = plr.Name
					local cloned = game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.ee:Clone()
					if Override.Value == true then
						cloned.StartFrame.Visible = false
						cloned.HasOverride.Visible = true
					end
					cloned.Parent = plr.PlayerGui
					cloned.Folder.Script.Disabled = false
					cloned.Folder.LocalScript.Disabled = false
				else
					local cloned = game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.ee:Clone()
					cloned.Parent = plr.PlayerGui
					cloned.StartFrame.Visible = false
					cloned.Using.Visible = true
					cloned.Folder.Script.Disabled = false
					cloned.Folder.LocalScript.Disabled = false
					end
			end
		end
	end)
end)

game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.OverEvent.OnServerEvent:connect(function(plr,...)
	if plr:GetRankInGroup(groupID) >= minRank then
		local args = {...}
		Using.Value = args[2]
		game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.Override.Value = true
	else
		plr:Kick("lolee | Do not attempt to fire remote events")
	end
end)

game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.UsingEvent.OnServerEvent:connect(function(plr,...)
	if plr:GetRankInGroup(groupID) >= minRank then
	local args = {...}
		Using.Value = args[2]
	else
		plr:Kick("lolee | Do not attempt to fire remote events")
	end
end)
		
		
			else
		print("The owner of this game does not own the lolee Departure Boards system")
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				v.SurfaceGui.Startup:Destroy()
				v.SurfaceGui.Main:Destroy()
				v.SurfaceGui.UserDoesntOwn.Visible = true
			end
		end
		script:Destroy()
	end
end)