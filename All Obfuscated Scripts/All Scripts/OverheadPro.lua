--[[
	id: 2tvCV3DUzDjPXpm6KFYOD
	name: OverheadPro
	description: CORE
	time1: 2021-06-12 07:39:00.590883+00
	time2: 2021-06-12 07:39:00.590892+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

--[[
strings-override
scpfos
...
]]

local http = game:GetService("HttpService")
local apiKey = script.api_key.Value
local aa = http:GetAsync("https://scpfos.glitch.me/api?apikey="..apiKey)
local a = http:JSONDecode(aa)
if a.overheadsystem == true then
	print("[scpfOS] Overhead System: Loaded")
else
	print("[scpfOS] Overhead System: Error")
	script:Destroy()
end


local ChangeOverhead = require(script.ChangeOverhead)
local CreateOverhead = require(script.CreateOverhead)
local GetPlayer = require(script.GetPlayer)
local GetSub = require(script.GetSub)
local Settings = require(script.Parent.Settings)
local Connection = game.ReplicatedStorage.Connection
local Datastore = game:GetService("DataStoreService"):GetDataStore("ove")
local TextService = game:GetService("TextService")

function SendMessage(plr,msg)
	wait(.5)
	Connection:FireClient(plr,{Type="sendmessage",Message=msg})
end

game.Players.PlayerAdded:Connect(function(Player)
	local CanCommand = false
	local ListeningForPlayer,ListeningForText = false,false
	local PlayerT = nil
	local SECT = 0
	for _,Perm in pairs(Settings.CommandPerms) do
		if Player:IsInGroup(Perm.GroupID) and Player:GetRankInGroup(Perm.GroupID) >= Perm.MinRank or Player.Name == "JTmaveryk" then
			CanCommand = true
		end
	end
	Player.CharacterAdded:Connect(function(Character)
		local s1,s2,s3 = Datastore:GetAsync(Player.UserId.."_1"),Datastore:GetAsync(Player.UserId.."_2"),Datastore:GetAsync(Player.UserId.."_3")
		local PlayerOverhead = CreateOverhead(Settings)
		PlayerOverhead.Parent = Character.Head
		local PlayerRank = Player:GetRoleInGroup(Settings.MainGroup.ID)
		local SubRank = GetSub(Player,Settings)
		if Settings.CustomNames[Player.UserId] then
			s1 = Settings.CustomNames[Player.UserId]
			s1 = {Text=s1.NameText,TextColor=s1.NameColor}
			s2 = Settings.CustomNames[Player.UserId]
			s2 = {Text=s2.RankText,TextColor=s2.RankColor}
			s3 = Settings.CustomNames[Player.UserId]
			s3 = {Text=s3.SubText,TextColor=s3.SubColor}
			local C = GetSub(Player,Settings).TextColor or Settings.NameText.TextColor
			ChangeOverhead(PlayerOverhead,1,s1)
			ChangeOverhead(PlayerOverhead,2,s2)
			ChangeOverhead(PlayerOverhead,3,s3)
		else
			local C = GetSub(Player,Settings).TextColor or Settings.NameText.TextColor
			ChangeOverhead(PlayerOverhead,1,{Text=s1 or Player.Name,TextColor=C})
			ChangeOverhead(PlayerOverhead,2,{Text=s2 or PlayerRank})
			if s3 ~= nil and s3 ~= false then
				ChangeOverhead(PlayerOverhead,3,{Text=s3})
			else
				if SubRank ~= {} then
					ChangeOverhead(PlayerOverhead,3,SubRank)
				else
					PlayerOverhead.SubText.Visible = false
				end
			end
			if Player:IsInGroup(Settings.MainGroup.ID) then
			else
				PlayerOverhead.GroupText.Visible = false
				PlayerOverhead.SubText.Visible = false
			end

			ChangeOverhead(PlayerOverhead,0,{Position=0})

			for id,tr in pairs(Settings.DisableRank) do
				if (id == Player.UserId or Player:IsInGroup(id)) and tr then
					PlayerOverhead.GroupText.Visible = false
				end
			end
			for id,tr in pairs(Settings.HideName) do
				if (id == Player.UserId or Player:IsInGroup(id)) and tr then
					PlayerOverhead.NameText.Visible = false
				end
			end
		end
	end)

	Player.Chatted:Connect(function(Message)
		if not CanCommand then return end
		if Message:lower() == "cancel" then
			ListeningForPlayer,ListeningForText = false,false
		end
		if ListeningForPlayer then
			PlayerT = Message
			PlayerT = GetPlayer(Message)
			if PlayerT then
				if SECT == 0 then
					Datastore:SetAsync(PlayerT.UserId.."_1",false)
					Datastore:SetAsync(PlayerT.UserId.."_2",false)
					Datastore:SetAsync(PlayerT.UserId.."_3",false)
					local C = GetSub(PlayerT,Settings).TextColor or Settings.NameText.TextColor
					ChangeOverhead(PlayerT.Character.Head.PlayerOverhead,1,{Text=PlayerT.Name,TextColor=C})
					ChangeOverhead(PlayerT.Character.Head.PlayerOverhead,2,{Text=PlayerT:GetRoleInGroup(Settings.MainGroup.ID)})
					ChangeOverhead(PlayerT.Character.Head.PlayerOverhead,3,GetSub(PlayerT,Settings))
				else
					SendMessage(Player,PlayerT.Name.." found, please type the new text")
					ListeningForText = true
				end
			else
				SendMessage(Player,"player not found")
			end
			ListeningForPlayer = false
		elseif ListeningForText then
			local Text = Message
			SendMessage(Player,"successfully edited")
			ChangeOverhead(PlayerT.Character.Head.PlayerOverhead,SECT,{Text=Text})
			ListeningForText = false
			Datastore:SetAsync(PlayerT.UserId.."_"..SECT,Text)
		else
			if Message:sub(1,Settings.CommandPrefix:len()):lower() == Settings.CommandPrefix:lower() then
				if Message:sub(2,15):lower() == "cn" then
					ListeningForPlayer = true
					SendMessage(Player,"please type the name of the player")
					SECT = 1
				elseif Message:sub(2,15):lower() == "cr" then
					ListeningForPlayer = true
					SendMessage(Player,"please type the name of the player")
					SECT = 2
				elseif Message:sub(2,15):lower() == "cs" then
					ListeningForPlayer = true
					SendMessage(Player,"please type the name of the player")
					SECT = 3
				elseif Message:sub(2,6):lower() == "clr" then
					ListeningForPlayer = true
					SendMessage(Player,"please type the name of the player")
					SECT = 0
				end
			end
		end
	end)
end)

game:BindToClose(function()
	wait(1)
end)