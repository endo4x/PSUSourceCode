--[[
	id: uLDnncBMS8mdmXsk-8_XF
	name: KMAR Ranktab
	description: HRP kmar ranktab
	time1: 2021-07-24 00:50:29.501411+00
	time2: 2021-07-24 00:50:29.501412+00
	uploader: qEoMJSStLGW3TRux7QHMozHb29eOB2eWCeV25BgK
	uploadersession: qbP13Dg5jd2zaecMMLYrdE5PDWcOxh
	flag: f
--]]

game.Players.PlayerAdded:connect(function(p)
	p.CharacterAdded:connect(function(char)
		wait(1.15)
		local plr = game.Players:findFirstChild(char.Name)

		if plr.TeamColor ~= BrickColor.new("Sand blue") then 
			return
		else 
			if plr:GetRankInGroup(8497220) <= 1 then
				morph(char, "👮Marechaussee der 4e klasse", "Right Arm", "Right Arm")
				morph(char, "👮Marechaussee der 4e klasse", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 5 then
				morph(char, "👮Marechaussee der 3e klasse", "Right Arm", "Right Arm")
				morph(char, "👮Marechaussee der 3e klasse", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 10 then
				morph(char, "👮Marechaussee der 2e klasse", "Right Arm", "Right Arm")
				morph(char, "👮Marechaussee der 2e klasse", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 15 then
				morph(char, "👮Marechaussee der 1e klasse", "Right Arm", "Right Arm")
				morph(char, "👮Marechaussee der 1e klasse", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 20 then
				morph(char, "👮Wachtmeester", "Right Arm", "Right Arm")
				morph(char, "👮Wachtmeester", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 25 then
				morph(char, "👮Wachtmeester der 1e klasse", "Right Arm", "Right Arm")
				morph(char, "👮Wachtmeester der 1e klasse", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 30 then
				morph(char, "👮Opperwachtmeester", "Right Arm", "Right Arm")
				morph(char, "👮Opperwachtmeester", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 35 then
				morph(char, "👮Adjudant-Onderofficier", "Right Arm", "Right Arm")
				morph(char, "👮Adjudant-Onderofficier", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 40 then
				morph(char, "👮?Kornet", "Right Arm", "Right Arm")
				morph(char, "👮Kornet", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 45 then
				morph(char, "👮Tweede Luitenant", "Right Arm", "Right Arm")
				morph(char, "👮Tweede Luitenant", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 50 then
				morph(char, "👮Eerste Luitenant", "Right Arm", "Right Arm")
				morph(char, "👮Eerste Luitenant", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 55 then
				morph(char, "👮Kapitein", "Right Arm", "Right Arm")
				morph(char, "👮Kapitein", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 60 then
				morph(char, "👮Majoor", "Right Arm", "Right Arm")
				morph(char, "👮Majoor", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 65 then
				morph(char, "👮Luitenant-Kolonel", "Right Arm", "Right Arm")
				morph(char, "👮Luitenant-Kolonel", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 70 then
				morph(char, "⭐Kolonel", "Right Arm", "Right Arm")
				morph(char, "⭐Kolonel", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 75 then
				morph(char, "⭐Brigadegeneraal", "Right Arm", "Right Arm")
				morph(char, "⭐Brigadegeneraal", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) == 80 then
				morph(char, "⭐Generaal-Majoor", "Right Arm", "Right Arm")
				morph(char, "⭐Generaal-Majoor", "Left Arm", "Left Arm")
			elseif plr:GetRankInGroup(8497220) >= 85 then
				morph(char, "⭐Luitenant-Generaal", "Right Arm", "Right Arm")
				morph(char, "⭐Luitenant-Generaal", "Left Arm", "Left Arm")
			end
		end
	end)
end)

function removehats(character)
	local a = character:GetChildren()
	for i=1, #a do
		if a[i].ClassName == "Accessory" then
			a[i]:Destroy()
		end
	end
end

function GiveClothes(character, kind)
	local main = game.ReplicatedStorage.RankTapsModel.KMAR:FindFirstChild(kind)
	local pnts = main.Pants
	local shirt = main.Shirt

	if not character:findFirstChild("Shirt") then 
		shirt:Clone().Parent = character
	else character:findFirstChild("Shirt"):Destroy()
		shirt:Clone().Parent = character
	end

	if not character:findFirstChild("Pants") then 
		pnts:Clone().Parent = character
	else character:findFirstChild("Pants"):Destroy()
		pnts:Clone().Parent = character
	end
end


function morph(character, kind, loc, part)
	local main = game.ReplicatedStorage.RankTapsModel.KMAR:FindFirstChild(kind)
	if character:findFirstChild("Humanoid") ~= nil then
		local g = main:FindFirstChild(loc):Clone()
		g.Parent = character
		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
				local W = Instance.new("Weld")
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
			end
			local Y = Instance.new("Weld")
			Y.Part0 = character:FindFirstChild(part)
			Y.Part1 = g.Middle
			Y.C0 = CFrame.new(0, 0, 0)
			Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			if h[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "WedgePart" or C[i].className == "MeshPart" then
				h[i].Anchored = false
				h[i].CanCollide = false
			end
		end
	end
end