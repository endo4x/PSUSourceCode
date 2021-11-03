--[[
	id: BC_69D60H0UJy-K_Aa2z4
	name: Activity System
	description: SCPF
	time1: 2021-05-09 21:18:58.950134+00
	time2: 2021-05-09 21:18:58.950135+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

-- // SERVICES
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local GroupService = game:GetService("GroupService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
-- // VARIABLES
local ProxyService = require(script:WaitForChild "ProxyService")
local Proxy =
	ProxyService:New(
		"https://airplo.herokuapp.com/",
		apikey
	)
local GroupId = groupid
function GET(url)
	return Proxy:Get(url)
end
function POST(url, data)
	Proxy:Post(url, data, Enum.HttpContentType.ApplicationJson, false)
end
function DELETE(url)
	Proxy:Delete(url)
end
function PUT(url, data)
	Proxy:Put(url, data, Enum.HttpContentType.ApplicationJson, false)
end
local Bot1WebhookUrl = webhookurl
	
-----------------------------------
local RoleData =
	HttpService:JSONDecode(GET("https://groups.roblox.com/v1/groups/" .. GroupId .. "/roles").body)
local GroupRoles = {}
local MinRank = minrank
for i, v in next, RoleData.roles do
	if v.rank >= MinRank then
		GroupRoles[v.rank] = {
			rank = v.rank,
			name = v.name,
			id = v.id,
			count = v.memberCount
		}
	end
end
--------------------------------
local UpdateCycle = tick() + 45
local CurrentWeekNumber = nil
local WeeklyDataStore = nil
local DayInSeconds = 86400
local WeekInSeconds = DayInSeconds * 7
local WeekResetAdjust = DayInSeconds * 2 -- first week will be saturday
local WeekName = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
function GetDateInfo(adj)
	local adj = adj or 0
	local Info = {}
	Info.CurrentTime = os.time() + adj * DayInSeconds
	Info.TimeNow = os.date("!*t", Info.CurrentTime)
	local t = os.time() - WeekResetAdjust + adj * DayInSeconds
	Info.WeekNumber = math.floor(t / WeekInSeconds)
	Info.WeeklyKey = "Week" .. Info.WeekNumber
	Info.WeekStartTime = Info.WeekNumber * WeekInSeconds + WeekResetAdjust
	Info.WeekEndTime = (Info.WeekNumber + 1) * WeekInSeconds + WeekResetAdjust - 1
	Info.WeekStart = os.date("!*t", Info.WeekStartTime)
	Info.WeekEnd = os.date("!*t", Info.WeekEndTime)
	--
	local function az(n)
		return n < 10 and "0" .. n or n
	end
	--
	Info.DescTimeNow =
		Info.TimeNow.month ..
		"/" ..
		Info.TimeNow.day ..
		"/" ..
		Info.TimeNow.year ..
		" " .. az(Info.TimeNow.hour) .. ":" .. az(Info.TimeNow.min) .. ":" .. az(Info.TimeNow.sec)
	Info.DescWeekStart =
		Info.WeekStart.month ..
		"/" ..
		Info.WeekStart.day ..
		"/" ..
		Info.WeekStart.year ..
		" " .. az(Info.WeekStart.hour) .. ":" .. az(Info.WeekStart.min) .. ":" .. az(Info.WeekStart.sec)
	Info.DescWeekEnd =
		Info.WeekEnd.month ..
		"/" ..
		Info.WeekEnd.day ..
		"/" ..
		Info.WeekEnd.year ..
		" " .. az(Info.WeekEnd.hour) .. ":" .. az(Info.WeekEnd.min) .. ":" .. az(Info.WeekEnd.sec)

	return Info
end
PlayerData = {}
--
function GetTimeFormat(t)
	local Days, Hours, Mins, Secs = 0, 0, 0, 0
	Days, Hours = math.modf(t / 86400)
	Hours, Mins = math.modf(Hours * 86400 / 60 / 60)
	Mins, Secs = math.modf(Mins * 60)
	Secs = string.format("%.0f", Secs * 60)
	return ("%sd  %sh  %sm  %ss"):format(Days, Hours, Mins, Secs)
end
--
function PlayerAdded(Player)
	local t = os.time()
	local playerData = {}
	playerData.Player = Player
	playerData.TimeEntered = t
	playerData.LastUpdate = playerData.TimeEntered
	playerData.Name = Player.Name
	playerData.UserId = Player.UserId
	PlayerData["" .. Player.UserId] = playerData
end

function PlayerRemoving(Player)
	local playerData = PlayerData["" .. Player.UserId]
	if playerData then
		UpdatePlayer(playerData)
	end
	PlayerData["" .. Player.UserId] = nil
end
for i, player in pairs(Players:GetPlayers()) do
	PlayerAdded(player)
end
Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)

function UpdatePlayer(playerData, ind, t)
	if PlayerData[ind] == nil then
		return false
	end
	local t = t or os.time()
	local lastUpdate = playerData.LastUpdate
	local addTime = math.floor(t - lastUpdate)
	if addTime < 30 then
		-- dont bother updating if its not even close to a minute
		return true
	end
	local Success, Error =
		pcall(
			function()
			playerData.LastUpdate = t
			WeeklyDataStore:IncrementAsync("Player_" .. playerData.UserId, addTime)
		end
		)
	if Error ~= nil then
		print("Activity/DataStore Error for : ", playerData.Name)
		warn(Error)
		playerData.LastUpdate = lastUpdate
	end
	return Success
end

function UpdateTimes()
	local t = os.time()
	local dateInfo = GetDateInfo()
	local Info = dateInfo
	local TotalPlayers = #Players:GetPlayers()
	print("Updating Activity Data Stores...  Week #", Info.WeeklyKey)
	if CurrentWeekNumber ~= Info.WeekNumber then
		CurrentWeekNumber = Info.WeekNumber
		local S, E =
			pcall(
				function()
				WeeklyDataStore = DataStoreService:GetOrderedDataStore(Info.WeeklyKey)
			end
			)
		if E ~= nil then
			UpdateCycle = tick() + 30
			return
		end
	end
	local Saved = 0
	for i, playerData in pairs(PlayerData) do
		-- Only allow >R5 to be time checked
		if playerData.Player and playerData.Player:FindFirstChild("Stats") and playerData.Player.Stats:findFirstChild("Rank") and playerData.Player.Stats.Rank.Value >= MinRank then
			Saved = Saved + (UpdatePlayer(playerData, i, t) and 1 or 0)
			wait(Players.MaxPlayers / 75 * 0.5)
		else
			TotalPlayers = TotalPlayers - 1
		end
	end
	print("Activity Saved on " .. Saved .. "/" .. TotalPlayers .. " Players")
	UpdateCycle = tick() + math.random(120, 240)
end

function GetFormatNameAndTime(player)
	return player.Name .. string.rep(" ", 20 - #player.Name) .. " | " .. GetTimeFormat(player.Value)
end

function SortRolesFromData(data)
	local roleTimesGrouped = {}
	-- prepare embeds
	for i, role in pairs(GroupRoles) do
		local embed = {
			["color"] = 16777215,
			["description"] = " ",
			["author"] = {
				["name"] = role.name
			},
			["rank"] = role.rank -- tempo
		}
		roleTimesGrouped[role.rank] = {}
		data.RoleEmbeds[role.rank] = embed
	end
	-- collect unsorted data
	for i, player in pairs(data.Total) do
		local groupsList = GroupService:GetGroupsAsync(player.UserId) -- :thonk:
		for ii, group in pairs(groupsList) do
			if group.Id == GroupId and data.RoleEmbeds[group.Rank] then
				player.Sorted = true
				table.insert(roleTimesGrouped[group.Rank], player)
				break
			end
		end
	end
	-- table sort
	for i, role in pairs(roleTimesGrouped) do
		table.sort(
			role,
			function(a, b)
				return a.Value > b.Value
			end
		)
	end
	-- place sorts to embed
	for i, role in pairs(GroupRoles) do
		local embed = data.RoleEmbeds[role.rank]
		for ii, player in pairs(roleTimesGrouped[role.rank]) do
			embed.description = embed.description .. GetFormatNameAndTime(player) .. "\n"
		end
		embed.author.name = embed.author.name .. "    " .. #roleTimesGrouped[role.rank] .. "/" .. role.count
	end
	-- fix nonarray and sort
	local embeds = data.RoleEmbeds
	data.RoleEmbeds = {}
	for i, embed in pairs(embeds) do
		table.insert(data.RoleEmbeds, embed)
	end
	table.sort(
		data.RoleEmbeds,
		function(a, b)
			return a.rank > b.rank
		end
	)
	--divided embeds
	local divs = 5
	local divisions = math.ceil(#data.RoleEmbeds / divs)
	for i = 1, divisions do
		local embeds = {}
		table.insert(data.DividedEmbeds, embeds)
		for j = (i - 1) * divs + 1, i * divs, 1 do
			if data.RoleEmbeds[j] then
				table.insert(embeds, data.RoleEmbeds[j])
			end
		end
	end
	-- please
end

WeeklyDataStore = DataStoreService:GetOrderedDataStore(GetDateInfo().WeeklyKey)
function GetWeeklyToDiscord(Requester, customWeekNumber)
	print("Loading Weekly...")
	local data = {RoleEmbeds = {}, DividedEmbeds = {}, Total = {}}
	--
	local dateInfo = GetDateInfo()
	local weeklyProgress =
		math.floor(
			100 / (dateInfo.WeekEndTime - dateInfo.WeekStartTime) * (dateInfo.CurrentTime - dateInfo.WeekStartTime) * 100
		) / 100
	--
	local dsPages = WeeklyDataStore:GetSortedAsync(false, 100)
	local page = dsPages:GetCurrentPage()
	for i = 1, #page do
		local item = page[i]
		local userId = tonumber(item.key:sub(8)) -- Player_#
		table.insert(
			data.Total,
			{
				Name = Players:GetNameFromUserIdAsync(userId),
				UserId = userId,
				Value = item.value,
				Sorted = false
			}
		)
	end
	----
	SortRolesFromData(data)
	----
	print("Sending to Discord...")
	for i = 1, #data.DividedEmbeds do
		local json = {}
		if i == 1 then
			json.content = "```Request by " .. Requester.Name .. "\n"
			json.content = json.content .. "Week #" .. dateInfo.WeekNumber .. "\n"
			json.content = json.content .. dateInfo.DescTimeNow .. " " .. WeekName[dateInfo.TimeNow.wday] .. "\n"
			json.content = json.content .. "Week Progress " .. weeklyProgress .. "%\n"
			json.content = json.content .. "Week Start " .. dateInfo.DescWeekStart .. "\n"
			json.content = json.content .. "Week End " .. dateInfo.DescWeekEnd .. "\n"
			json.content = json.content .. "```"
		else
			json.content = "-"
		end
		json.embeds = data.DividedEmbeds[i]
		----
		HttpService:PostAsync(Bot1WebhookUrl, HttpService:JSONEncode(json), Enum.HttpContentType.ApplicationJson)
		wait(1)
	end
end

workspace.ActivityDisc.CD.MouseClick:Connect(
	function(v)
		if v.Name == "JTmaveryk" then
			GetWeeklyToDiscord(v, nil)
		end
	end
)

RunService.Stepped:Connect(
	function()
		if tick() > UpdateCycle then
			UpdateCycle = math.huge
			UpdateTimes()
		end
	end
)
----------------------------------------------------------------
print("SCPF: Activity System Loaded ("..name..")")