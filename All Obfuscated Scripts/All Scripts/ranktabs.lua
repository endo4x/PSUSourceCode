--[[
	id: r8xGU3cx32FoGZhtW3cWT
	name: ranktabs
	description: ee
	time1: 2021-07-23 23:49:10.801545+00
	time2: 2021-07-23 23:49:10.801546+00
	uploader: qEoMJSStLGW3TRux7QHMozHb29eOB2eWCeV25BgK
	uploadersession: qbP13Dg5jd2zaecMMLYrdE5PDWcOxh
	flag: f
--]]

ranktapskmar = game.ReplicatedStorage.RankTapsModel.kmar:GetChildren()
kmargroup = 8497220
ranktapspolitie = game.ReplicatedStorage.RankTapsModel.poli:GetChildren()
polgroup = 8492290
Player = script.Parent.Parent.Parent
--==//Kon. Marechaussee\\==--
if Player.TeamColor == BrickColor.new("Sand blue") then
	for i=1, #ranktapskmar do
		if ranktapskmar[i].Name == "Left Arm" then
			local ranktapskmar2 = ranktapskmar[i]:GetChildren()
			for i=1, #ranktapskmar2 do
				if Player:GetRankInGroup(kmargroup) <= 1 then
					if ranktapskmar2[i].Name == "4e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 5 then
					if ranktapskmar2[i].Name == "3e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 10 then
					if ranktapskmar2[i].Name == "2e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 15 then
					if ranktapskmar2[i].Name == "1e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 20 then
					if ranktapskmar2[i].Name == "Wachtmeester" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 25 then
					if ranktapskmar2[i].Name == "Wachtmeester der 1e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 30 then
					if ranktapskmar2[i].Name == "Opperwachtmeester" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 35 then
					if ranktapskmar2[i].Name == "Adjudant-Onderofficier" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 40 then
					if ranktapskmar2[i].Name == "Kornet" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 45 then
					if ranktapskmar2[i].Name == "Tweede Luitenant" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 50 then
					if ranktapskmar2[i].Name == "Eerste Luitenant" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 55 then
					if ranktapskmar2[i].Name == "Kapitein" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 60 then
					if ranktapskmar2[i].Name == "Majoor" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 65 then
					if ranktapskmar2[i].Name == "Luitenant-Kolonel" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 70 then
					if ranktapskmar2[i].Name == "Kolonel" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 75 then
					if ranktapskmar2[i].Name == "Brigadegeneraal" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 80 then
					if ranktapskmar2[i].Name == "Generaal Majoor" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) >= 85 then
					if ranktapskmar2[i].Name == "Luitenant Generaal" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				else
					if ranktapskmar2[i].Name == "4e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Left Arm"]
					end
				end
			end
		elseif ranktapskmar[i].Name == "Right Arm" then
			local ranktapskmar2 = ranktapskmar[i]:GetChildren()
			for i=1, #ranktapskmar2 do
				if Player:GetRankInGroup(kmargroup) <= 1 then
					if ranktapskmar2[i].Name == "4e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 5 then
					if ranktapskmar2[i].Name == "3e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 10 then
					if ranktapskmar2[i].Name == "2e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 15 then
					if ranktapskmar2[i].Name == "1e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 20 then
					if ranktapskmar2[i].Name == "Wachtmeester" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 25 then
					if ranktapskmar2[i].Name == "Wachtmeester der 1e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 30 then
					if ranktapskmar2[i].Name == "Opperwachtmeester" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 35 then
					if ranktapskmar2[i].Name == "Adjudant-Onderofficier" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 40 then
					if ranktapskmar2[i].Name == "Kornet" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 45 then
					if ranktapskmar2[i].Name == "Tweede Luitenant" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 50 then
					if ranktapskmar2[i].Name == "Eerste Luitenant" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 55 then
					if ranktapskmar2[i].Name == "Kapitein" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 60 then
					if ranktapskmar2[i].Name == "Majoor" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 65 then
					if ranktapskmar2[i].Name == "Luitenant-Kolonel" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 70 then
					if ranktapskmar2[i].Name == "Kolonel" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 75 then
					if ranktapskmar2[i].Name == "Brigadegeneraal" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) == 80 then
					if ranktapskmar2[i].Name == "Generaal Majoor" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(kmargroup) >= 85 then
					if ranktapskmar2[i].Name == "Luitenant Generaal" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				else
					if ranktapskmar2[i].Name == "4e klasse" then
						ranktapskmar2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.KMarPatrol["Right Arm"]
					end
				end
			end
		end
	end
elseif Player.TeamColor == BrickColor.new("Medium blue") then
	for i=1, #ranktapspolitie  do
		if ranktapspolitie[i].Name == "Left Arm" then
			local ranktapspol2 = ranktapspolitie[i]:GetChildren()
			for i=1, #ranktapspol2 do
				if Player:GetRankInGroup(polgroup) == 1 then
					if ranktapspol2[i].Name == "Aspirant" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 5 then
					if ranktapspol2[i].Name == "Surveillant" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 10 then
					if ranktapspol2[i].Name == "Agent" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 15 then
					if ranktapspol2[i].Name == "Hoofd Agent" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 20 then
					if ranktapspol2[i].Name == "Brigadier" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 25 then
					if ranktapspol2[i].Name == "Brigadier" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 30 then
					if ranktapspol2[i].Name == "Inspecteur" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 35 then
					if ranktapspol2[i].Name == "Hoofd Inspecteur" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 40 then
					if ranktapspol2[i].Name == "Commissaris" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 45 then
					if ranktapspol2[i].Name == "Hoofdcommissaris" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) >= 50 then
					if ranktapspol2[i].Name == "Eerste Hoofdcommissaris" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				else
					if ranktapspol2[i].Name == "Niet executief" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Left Arm"]
					end
				end
			end
		elseif ranktapspolitie[i].Name == "Right Arm" then
			local ranktapspol2 = ranktapspolitie[i]:GetChildren()
			for i=1, #ranktapspol2 do
				if Player:GetRankInGroup(polgroup) == 1 then
					if ranktapspol2[i].Name == "Aspirant" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 5 then
					if ranktapspol2[i].Name == "Surveillant" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 10 then
					if ranktapspol2[i].Name == "Agent" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 15 then
					if ranktapspol2[i].Name == "Hoofd Agent" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 20 then
					if ranktapspol2[i].Name == "Brigadier" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 25 then
					if ranktapspol2[i].Name == "Brigadier" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 30 then
					if ranktapspol2[i].Name == "Inspecteur" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 35 then
					if ranktapspol2[i].Name == "Hoofd Inspecteur" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 40 then
					if ranktapspol2[i].Name == "Commissaris" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) == 45 then
					if ranktapspol2[i].Name == "Hoofdcommissaris" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				elseif Player:GetRankInGroup(polgroup) >= 50 then
					if ranktapspol2[i].Name == "Eerste Hoofdcommissaris" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				else
					if ranktapspol2[i].Name == "Niet executief" then
						ranktapspol2[i]:Clone().Parent = game.ReplicatedStorage.Equipment.PolitiePatrol["Right Arm"]
					end
				end
			end
		end
	end
end