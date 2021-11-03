--[[
	id: 4Xc9VUlvBYgs_qJ-QrM97
	name: Application System
	description: SCPF
	time1: 2021-05-16 20:22:00.860243+00
	time2: 2021-05-16 20:22:00.860244+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

local http = game:GetService("HttpService")
local aa = http:GetAsync("https://scpfos.glitch.me/api?apikey="..apiKey)
local a = http:JSONDecode(aa)
if a.applicationservice == true then
	print("[scpfOS] System Loaded")
else
	print("[scpfOS] Error Encountered")
	script:Destroy()
end


script.token.Value = string.reverse(token)
script.key.Value = string.reverse(key)

local ReplicatedStorageService = game:GetService("ReplicatedStorage")
local Trello = require(script.TrelloAPI)
local BoardID = Trello:GetBoardID(boardName)
local Chat = game:GetService("Chat")

local GroupId = groupId

local function Beautify(Table, User)
	local String = ""
	
	for i,v in pairs(Table.Questions) do
		String = String .. "\n **" .. v .. "** \n **A:** " .. Chat:FilterStringAsync(Table.Responses[i].."\n", User, User)
	end
	print(String)
	return String
end

ReplicatedStorageService:WaitForChild("AppSubmit").OnServerEvent:Connect(function(Player, AppData, ArgListID, ArgLabelId)
	local Clearance = Player:GetRoleInGroup(GroupId)
	local uid = tostring(Player.UserId)
	local revuid = string.reverse(uid)
	local ListId = Trello:GetListID(ArgListID, BoardID)
	
	--[[	
	local LabelId = Trello:GetLabelID("3", BoardID)	
	Trello:AddCard(tostring(revuid), "![Player Picture](https://www.roblox.com/headshot-thumbnail/image?width=100&height=100&format=png&userId="..tostring(Player.UserId)..") \n ["..Player.Name.." • "..tostring(Player.UserId).."](https://www.roblox.com/users/"..tostring(Player.UserId).."/profile) \n **Foundation Rank:** " .. tostring(Clearance) .. "\n \n \n **APPLICATION:** \n \n "..Beautify(AppData, Player), ListId, true, true, true, LabelId)
	]]
	
	local System = {}
	local Settings = {}

	Settings.Trello     = string.reverse(boardId);
	Settings.Key        = string.reverse(key);
	Settings.Token      = string.reverse(token);
	
	
	local http          = game:GetService("HttpService");
	

	local musget = http:PostAsync(
		'https://api.trello.com/1/cards/?key='..(Settings.Key)..'&token='..(Settings.Token), 
		http:JSONEncode({
			["name"] = tostring(revuid), 
			["desc"] = "![Player Picture](https://www.roblox.com/headshot-thumbnail/image?width=100&height=100&format=png&userId="..tostring(Player.UserId)..") \n ["..Player.Name.." • "..tostring(Player.UserId).."](https://www.roblox.com/users/"..tostring(Player.UserId).."/profile) \n **Foundation Rank:** " .. tostring(Clearance) .. "\n **Application:** " .. tostring(ArgListID) .. " \n \n \n **APPLICATION:** \n \n "..Beautify(AppData, Player),
			["due"] = {os.date('!*t').month, os.date('!*t').day, os.date('!*t').year},
			["dueComplete"] = true,
			["pos"] = "top",
			["idList"] = ListId,
			["idLabels"] = {ArgLabelId}}))
	wait(1)
	
	
	
	ReplicatedStorageService:WaitForChild("AppSubmit"):FireClient(Player, "Success")
end)