--[[
	id: RGRb9vf46zAH2X7rK4lcB
	name: GUI Loader
	description: Loader script for the GUI
	time1: 2021-06-12 18:38:27.296384+00
	time2: 2021-06-12 18:38:27.296385+00
	uploader: 5lHL6z5TWPzh-xTZ9CoywkC-nC9Ttct1a2wfEpwy
	uploadersession: lA0pqlse9Xq2s9ET5uKls31oMu56-i
	flag: f
--]]

--[[ Created by Kratos232 ]]--

--[[
[Instructions]
 - Put the Script inside a Seat.
 - Remove the GUI already inside the Script (It's just an example).
 - Put your own GUI inside the script.
 - Re-name the GUI to "GUI" (Without the quotation marks " ")

It should work, but tell me if it doesn't.
--]] 



--[[ Main Script ]]--

Players = Game:GetService("Players")
Workspace = Game:GetService("Workspace")

Seat = script.Parent
GUI = script.GUI
Active = false
Player = nil
NewGui = nil

Seat.ChildAdded:connect(function(Child)
	if Active == false then
		if Child.Name == "SeatWeld" then
			Active = true
			Player = Players:GetPlayerFromCharacter(Child.Part1.Parent)
			if Player ~= nil then
				PlayerGui = Player:FindFirstChild("PlayerGui")
				if PlayerGui ~= nil then
					NewGui = GUI:Clone()
					NewGui.Parent = PlayerGui
				end
			end
		end
	end
end)

Seat.ChildRemoved:connect(function(child)
	if child.Name == "SeatWeld" then
		if Active == true then
			Active = false
			pcall(function() NewGui:Destroy() end)
			Player = nil
			NewGui = nil
		end
	end
end)
