--[[
	id: iFp7PnY2y-E64iUkyvSPY
	name: CheckMeIn Module 1
	description: Handles loading of the system
	time1: 2021-06-30 13:45:04.825701+00
	time2: 2021-06-30 13:45:04.825703+00
	uploader: 5S3cjSTB1Yq31QCwXLe3Tz9eqAiVbz2wgoUDCF4a
	uploadersession: 1okjSel_CB3azkChqA87HmukVBEOgD
	flag: f
--]]

return function(Config)

if Config then
	Config.Parent = script
	Config.Name = 'Options'
else
	warn("No config provided; using default config")
	script.DefaultConfig.Name = 'Options'
end

local licenceCheck = require(4943420040)()
local hasLicense = false
local LicenseType = ''

if licenceCheck == 1 then
	hasLicense = true
	LicenseType = 'Standard'
elseif licenceCheck == 2 then
	hasLicense = true
	LicenseType = 'Enterprise'
end

_G.CheckMeIn = {}
_G.CheckMeIn.LicenseType = LicenseType


if hasLicense then
	if LicenseType == 'Standard' then
		script.Options.Enterprise:Destroy()
		script.DefaultConfig.EnterpriseNotOwned:Clone().Parent = script.Options
		script.Options.EnterpriseNotOwned.Name = 'Enterprise'
	end

	local Server = script.CheckMeIn
	Server.Parent = game.ServerScriptService

	local Tools = Instance.new('Folder')
	Tools.Name = 'CheckMeIn Tools'
	Tools.Parent = game.ServerStorage

	workspace.CheckMeIn.Tools["Player Card"].Parent = Tools
	workspace.CheckMeIn.Tools["Staff Card"].Parent = Tools

	script['CheckMeIn Communication'].Parent = game:GetService('ReplicatedStorage')

	if LicenseType == 'Enterprise' then
		require(script.Mainframe.Services.Discord):Initialize()
		require(script.Mainframe.Services.Points):Initialize(true)
	end
	require(script.Mainframe.Services.RoomBoards):Initialize()
	require(script.Mainframe.Services.Database):Initialize(true)
	require(script.Mainframe.Services.KeepTools):Initialize(true)
	require(script.Mainframe.Services.UI):Initialize(true)
	require(script.Mainframe.Services.Cache):Initialize(true)
	require(script.Mainframe.Services.ClientCode):Initialize(true)
	require(script.Mainframe.Services.LiveGamepass):Initialize(true)
	spawn(function() require(script.Mainframe.Services.Doors):Initialize(true) end)
	local CacheServer = require(script.Mainframe.Services.Cache)

	local C = game:GetService('ReplicatedStorage')['CheckMeIn Communication']
	C.Service.GetConfig.OnServerInvoke = function(WhosAsking,Ent)
		if Ent then
			local C = require(Config.Enterprise)
			C.Points = nil
			return C
		end
		local C = require(Config)
		C.Points = nil
		return C
	end

	C.Service.CheckIn.OnServerEvent:Connect(function(Employee,Player,Type,Num)
		warn('Check in request received')
		require(script.Mainframe.Functions.Service):CheckIn(Player,Employee,Type,Num)
	end)
	C.Service.CheckOut.OnServerEvent:Connect(function(Employee,Player)
		warn('Check out request received')
		require(script.Mainframe.Functions.Service):CheckOut(Player,Employee)
	end)
	C.Service.SelfCheckIn.OnServerEvent:Connect(function(Player,Type,ID)
		require(script.Mainframe.Functions.Service):SelfCheckIn(Player,Type,ID)
	end)
	C.Service.SelfCheckOut.OnServerEvent:Connect(function(Player,ID)
		require(script.Mainframe.Functions.Service):SelfCheckOut(Player,ID)
	end)
	C.Service.GetTutorialState.OnServerInvoke = function(WhosAsking)
		return require(script.Mainframe.Services.Points):GetTutorialState(WhosAsking)
	end
	C.Service.SetTutorialState.OnServerEvent:Connect(function(Player,new)
		require(script.Mainframe.Services.Points):SetTutorialState(Player,new)
	end)
	C.Service.Feedback.OnServerEvent:Connect(function(Player,txt)
		require(script.Mainframe.Services.Discord):PostFeedback(Player,txt)
	end)
	C.Rooms.GetType.OnServerInvoke = function(WhosAsking)
		return LicenseType
	end
	C.Service.GetRoomData.OnServerInvoke = function(WhosAsking)
		local isEmployee = CacheServer:IsReceptionist(WhosAsking)
		print(isEmployee)
		if isEmployee then
			return require(script.Mainframe.Services.Database):GetAllRooms()
		end
		return false
	end
	C.Service.SetDnD.OnServerEvent:Connect(function(Player,newValue)
		warn('received dnd')
		local R = require(script.Mainframe.Services.Database):GetPlayerRoom(Player)
		if R then
			warn('r true')
			require(script.Mainframe.Services.Doors):ToggleDnD(R,newValue)
			game:GetService('ReplicatedStorage')['CheckMeIn Communication'].Service.SyncRM:FireClient(Player,R,'DnD',newValue)
		else
			warn('r false')
		end
	end)
	C.Service.SetPM.OnServerEvent:Connect(function(Player,newValue)
		warn('received pm')
		local R = require(script.Mainframe.Services.Database):GetPlayerRoom(Player)
		if R then
			warn('r true')
			require(script.Mainframe.Services.Doors):TogglePM(R,newValue)
			game:GetService('ReplicatedStorage')['CheckMeIn Communication'].Service.SyncRM:FireClient(Player,R,'PM',newValue)
		else
			warn('r false')
		end
	end)
	
	warn("CheckMeIn 4.0 loaded\
This is an early build and does not represent the final product\
Designed and made by wind_o\
With help from xeu100, DataIsLoading and Kampfkarren\
© smartTech 2020")

else
	warn("CheckMeIn 4.0 failed to load\
A license is required to use this product.\
Please contact wind_o for more information.")
end


end