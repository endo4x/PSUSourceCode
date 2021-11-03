--[[
	id: GCEMK9WExyUcz7QgopLxI
	name: XD
	description: FINALLY
	time1: 2021-05-20 17:24:54.060662+00
	time2: 2021-05-20 17:24:54.060662+00
	uploader: IJyW72t-AZ5b6aFd5mp7hfwfiArT9VznkLuRhwlJ
	uploadersession: N7lLO0W7MVWsQIBLayGlsgA6etHt8c
	flag: f
--]]


--open and close


print("Welcome to SoulModders")

-- init
local library = loadstring(game:HttpGet("https://pastebin.com/raw/qwdPKKDN"))()
local venyx = library.new("Soulmodders", 5013109572)

 -- ==============================================================================================================================
            local rgbb = Color3.new(1, 0, 0)
            local textt = ""
            local custom_things = venyx:addPage("Custom Text", 5012544693)
            local custom_text = custom_things:addSection("Custom text")
            custom_text:addColorPicker(
                "The color of the text",
                rgbb,
                function(val)
                    rgbb = val
                end
            )
            custom_text:addTextbox(
                "What to say?",
                "",
                function(val)
                    textt = val
                end
            )
            custom_text:addButton(
                "Send the text",
                function()
                    local A_1 = {
                        [1] = getrenv()._G.Pass,
                        [2] = "Chatted",
                        [3] = textt,
                        [4] = rgbb
                    }
                    local Event = game:GetService("ReplicatedStorage").Remotes.Events
                    Event:FireServer(A_1)
                end
            )



-- 2 page
local page2 = venyx:addPage("Moves", 5012544693)
local section21 = page2:addSection("Asriel")
local section22 = page2:addSection("Xchara/Cross")
local section23 = page2:addSection("Sans")
local section24 = page2:addSection("Frisk")
local section25 = page2:addSection("Gt Frisk")
local section26 = page2:addSection("Gt chara")
local section27 = page2:addSection("ss chara")
local section28 = page2:addSection("Betty")
local section29 = page2:addSection("Undyne")


 
section22:addButton("summon knives", function()
	local A_1 = 
		{
			[1] = getrenv()._G.Pass, 
			[2] = "SummonKnivesChara", 
			[3] = "Spawn"
		}
	local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
	Event:InvokeServer(A_1)
end)

section26:addButton("special hell", function()
	local A_1 = 
		{
			[1] = getrenv()._G.Pass, 
			[2] = "AreaAttack", 
			[3] = "Start"
		}
	local Event = game:GetService("ReplicatedStorage").Remotes.CharaMoves
	Event:InvokeServer(A_1)
end)

section21:addButton("Shocker break it", function()
	local args = {
		[1] = {
			[1] = getrenv()._G.Pass,
			[2] = "ShockerBreaker",
			[3] = "Start"
		}
	}

	game:GetService("ReplicatedStorage").Remotes.AsrielMoves:InvokeServer(unpack(args))
end)

section21:addButton("HyperBeam", function()
	local args = {
		[1] = {
			[1] = getrenv()._G.Pass,
			[2] = "HyperBeam",
			[3] = "Fire"
		}
	}

	game:GetService("ReplicatedStorage").Remotes.AsrielMoves:InvokeServer(unpack(args))
end)

section27:addButton("Chaos Buster 1", function()
	local args = {
		[1] = {
			[1] = getrenv()._G.Pass,
			[2] = "ChaosBusterBlasters",
			[3] = "SummonOne",
			[4] = Vector3.new(1091.2574462891, -5.8583984375, 528.84344482422)
		}
	}

	game:GetService("ReplicatedStorage").Remotes.SFCharaMoves:InvokeServer(unpack(args))
end)

section27:addButton("Chaos Buster 4", function()
	local args = {
		[1] = {
			[1] = getrenv()._G.Pass,
			[2] = "ChaosBusterBlasters",
			[3] = "SummonEight",
			[4] = Vector3.new(1091.2574462891, -5.8583984375, 528.84344482422)
		}
	}

	game:GetService("ReplicatedStorage").Remotes.SFCharaMoves:InvokeServer(unpack(args))
end)

section21:addButton("Star Blazing", function()
	local args = {
		[1] = {
			[1] = getrenv()._G.Pass,
			[2] = "StarBlazing",
			[3] = "Start"
		}
	}

	game:GetService("ReplicatedStorage").Remotes.AsrielMoves:InvokeServer(unpack(args))
end)



-- first page
local page = venyx:addPage("Customs", 5012544693)
local section1 = page:addSection("InMenu Customs")
local section2 = page:addSection("Sans Customs")
local section3 = page:addSection("xtale Customs")
local section4 = page:addSection("All Characters")



section4:addKeybind("Toggle Keybind", Enum.KeyCode.One, function()
print("Activated Keybind")
venyx:toggle()
end, function()
print("Changed Keybind")
end)

	section1:addButton("Epic!Sans V2", function()
		local textonattack = true
		local godmode = true
		local autoblock = true
		local dead = false
		local pass = getrenv()._G.Pass
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer
		local uis = game:GetService("UserInputService")
		local mouse = game.Players.LocalPlayer:GetMouse()
		game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "XSans"
		if not localPlayer.Character then
			localPlayer.CharacterAdded:Wait()
		end
		wait(2)
		print("running main thingy idk")
		local humanoid = localPlayer.Character:WaitForChild("Humanoid")
		humanoid.Died:Connect(function()
			dead = true
			warn("dead how")
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,-10,0)
		end)
		local NormalPunchAnim = Instance.new("Animation")
		NormalPunchAnim.AnimationId = "rbxassetid://5776238345"
		local NormalPunchAnimTrack = humanoid:LoadAnimation(NormalPunchAnim)
		NormalPunchAnimTrack.Priority = Enum.AnimationPriority.Action
		NormalPunchAnimTrack.Looped = false

		-- Remove Animations/Attacks:
		local AnimationTracks = humanoid:GetPlayingAnimationTracks()
		repeat wait()
		until game.Players.LocalPlayer.Backpack:FindFirstChild("Main")
		game.Players.LocalPlayer.Backpack.Main:WaitForChild("XSansMoves"):Destroy()
		for i, track in pairs (AnimationTracks) do
			track:Stop()
		end

		spawn(function()
			wait(0.5)
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end)

		-- Music:

		local music = game.Players.LocalPlayer:WaitForChild("StarterPlaylist")["1Theme"]
		music.SoundId = "rbxassetid://6123744744"
		music.TimePosition = 0
		music.Looped = true
		music:Play()

		-- GodMode:

		spawn(function()
			wait(2)
			if godmode == true then
				while wait(0.1) do
					if dead == true then return end
					local A_1 = 
						{
							[1] = pass, 
							[2] = "InvFrames", 
							[3] = 0.5
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Events
					Event:FireServer(A_1)
				end
			end
		end)

		-- Auto Block:
		spawn(function()
			if autoblock == true then
				while wait(0.1) do
					if dead == true then return end
					local A_1 = 
						{
							[1] = pass, 
							[2] = "Blocking", 
							[3] = true
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Functions
					Event:InvokeServer(A_1)
				end
			end
		end)

		-- UnAnchor:

		spawn(function()
			while wait() do
				for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("Part") then
						v.Anchored = false
					end
				end
			end
		end)

		-- Talk Function:

		function talk(message)
			if dead == true then return end
			local A_1 = 
				{
					[1] = pass,
					[2] = "Chatted", 
					[3] = message, 
					[4] = Color3.new(128,0,128)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
		end

		game.Players.LocalPlayer.Chatted:Connect(function(msg)
			talk(msg)
		end)

		-- Attack Coolowns:

		local normalpunchcooldown = false
		local normalbarragecooldown = false
		local uppercutnormalcooldown = false
		local seriousbarragecooldown = false
		local uppercutseriouscooldown = false
		local seriouspunchcooldown = false

		-- Attacks:

		function seriouspunch()
			if seriouspunchcooldown == true then return end
			spawn(function()
				seriouspunchcooldown = true
				wait(5)
				seriouspunchcooldown = false
			end)
			if textonattack == true then
				talk("totally not from Won punch man serious punch!")
			end
			NormalPunchAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "RainbowExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.SwordSlash,
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function normalpunch()
			if normalpunchcooldown == true then return end
			spawn(function()
				normalpunchcooldown = true
				wait(0.3)
				normalpunchcooldown = false
			end)
			if textonattack == true then
				talk("Epic tap!")
			end
			NormalPunchAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "RainbowExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function tp()
			if game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value ~= nil then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Torso.CFrame * CFrame.new(0,0,5)
			else
				game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.p)
			end
		end

		function barragenormal()
			if normalbarragecooldown == true then return end
			if textonattack == true then
				talk("EPIC CONSECUTIVE BARRAGE!")
			end
			spawn(function()
				normalbarragecooldown = true
				wait(3)
				normalbarragecooldown = false
			end)
			local BarrageAnim = Instance.new("Animation")
			BarrageAnim.AnimationId = "rbxassetid://4800436094"
			local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
			BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
			BarrageAnimTrack.Looped = false
			BarrageAnimTrack:Play()
			wait(0.5)
			for i = 1,7 do
				spawn(function()
					for i,v in pairs(workspace:GetChildren()) do
						if v:FindFirstChild("Torso") then
							if v.Name ~= game.Players.LocalPlayer.Name then
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
									local A_1 = pass
									local A_2 = v
									local A_3 = 
										{
											["Type"] = "Normal", 
											["HitEffect"] = "ConstantExplosions", 
											["HurtAnimation"] = nil, 
											["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
											["CameraShake"] = "Bump", 
											["HitTime"] = 0, 
											["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
											["Sound"] = game:GetService("ReplicatedStorage").Sounds.HumanVoice, 
											["Damage"] = 10
										}
									local Event = game:GetService("ReplicatedStorage").Remotes.Damage
									Event:InvokeServer(A_1, A_2, A_3)
								end
							end
						end
					end
				end)
				wait(0.1)
			end
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "ConstantExplosions", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function barrageserious()
			if seriousbarragecooldown == true then return end
			if textonattack == true then
				talk("Consecutive TROLL BARRAGE- ORA ORA ORA!")
			end
			spawn(function()
				seriousbarragecooldown = true
				wait(3)
				seriousbarragecooldown = false
			end)
			local BarrageAnim = Instance.new("Animation")
			BarrageAnim.AnimationId = "rbxassetid://4800436094"
			local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
			BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
			BarrageAnimTrack.Looped = false
			BarrageAnimTrack:Play()
			wait(0.5)
			for i = 1,7 do
				spawn(function()
					for i,v in pairs(workspace:GetChildren()) do
						if v:FindFirstChild("Torso") then
							if v.Name ~= game.Players.LocalPlayer.Name then
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
									local A_1 = pass
									local A_2 = v
									local A_3 = 
										{
											["Type"] = "Normal", 
											["HitEffect"] = "HateExplosion", 
											["HurtAnimation"] = nil, 
											["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
											["CameraShake"] = "Bump", 
											["HitTime"] = 0, 
											["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
											["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
											["Damage"] = 10
										}
									local Event = game:GetService("ReplicatedStorage").Remotes.Damage
									Event:InvokeServer(A_1, A_2, A_3)
								end
							end
						end
					end
				end)
				wait(0.1)
			end
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "HateExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function uppercutnormal()
			if uppercutnormalcooldown == true then return end
			if textonattack == true then
				talk("normal epic pog tap")
			end
			spawn(function()
				uppercutnormalcooldown = true
				wait(2)
				uppercutnormalcooldown = false
			end)
			local UpperCutAnim = Instance.new("Animation")
			UpperCutAnim.AnimationId = "rbxassetid://4300091335"
			local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
			UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
			UpperCutAnimTrack.Looped = false
			UpperCutAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "SpearJusticeExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 25 + Vector3.new(0.01,50,0.01), 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.HeavySlash, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function uppercutserious()
			if uppercutseriouscooldown == true then return end
			if textonattack == true then
				talk("serious quake pog cut!")
			end
			spawn(function()
				uppercutseriouscooldown = true
				wait(2)
				uppercutseriouscooldown = false
			end)
			local UpperCutAnim = Instance.new("Animation")
			UpperCutAnim.AnimationId = "rbxassetid://4300091335"
			local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
			UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
			UpperCutAnimTrack.Looped = false
			UpperCutAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "SpearJusticeExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 70 + Vector3.new(0.01,100,0.01), 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Crack, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end
		local attacking = false
		uis.InputBegan:Connect(function(input,gpe)
			if dead == true then return end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.R then
					tp()
				end
				if attacking == true then return end
				if input.KeyCode == Enum.KeyCode.One then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					normalpunch()
				elseif input.KeyCode == Enum.KeyCode.Two then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					barragenormal()
				elseif input.KeyCode == Enum.KeyCode.Three then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					uppercutnormal()
				elseif input.KeyCode == Enum.KeyCode.Four then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					barrageserious()
				elseif input.KeyCode == Enum.KeyCode.Five then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					uppercutserious()
				elseif input.KeyCode == Enum.KeyCode.Six then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					seriouspunch()
				end
			end
		end)end)

section1:addButton("LB Sans", function()
	local phase = 1
	local inv = false
	local dead = false
	local holdbone = false
	local CAS = game:GetService("ContextActionService")
	local FREEZE_COMMAND  = "Stunned"
	CAS:UnbindAction(FREEZE_COMMAND)
	local pass = getrenv()._G.Pass
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local mouse = localPlayer:GetMouse()
	game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "Sans"
	if not localPlayer.Character then
		localPlayer.CharacterAdded:Wait()
	end
	wait(0.5)
	local root = localPlayer.Character.HumanoidRootPart
	wait(2)
	print("running main thingy idk")

	local humanoid = localPlayer.Character:WaitForChild("Humanoid")

	humanoid.Died:Connect(function()
		print("died")
		for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
			v:Destroy()
		end
		dead = true
		inv = false
	end)

	spawn(function()
		while wait() do
			if dead == true then break end
			local A_1 = 
				{
					[1] = pass, 
					[2] = "ChangeSetting", 
					[3] = "DeathScene", 
					[4] = false
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Functions
			Event:InvokeServer(A_1)
		end
	end)

	spawn(function()
		while wait() do
			if dead == true then break end
			if holdbone == true then
				if game.Players.LocalPlayer.Character.Bone.Transparency ~= 0 then
					local A_1 = 
						{
							[1] = getrenv()._G.Pass, 
							[2] = "SpawnBone", 
							[3] = true, 
							[4] = true
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
					Event:InvokeServer(A_1)
				end
			end
		end
	end)

	function hidebone()
		local A_1 = 
			{
				[1] = getrenv()._G.Pass, 
				[2] = "SpawnBone", 
				[3] = false, 
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
		Event:InvokeServer(A_1)
	end

	function bone(v)
		spawn(function()
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "SpawnBone", 
					[3] = v, 
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
			Event:InvokeServer(A_1)
		end)
	end

	function stun(val)
		if val == true then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
			CAS:BindActionAtPriority(
				FREEZE_COMMAND,
				function() 
					return Enum.ContextActionResult.Sink
				end,
				false,
				Enum.ContextActionPriority.High.Value,
				Enum.KeyCode.W,
				Enum.KeyCode.S,
				Enum.KeyCode.A,
				Enum.KeyCode.D,
				Enum.KeyCode.F,
				Enum.KeyCode.R,
				Enum.KeyCode.One,
				Enum.KeyCode.Two,
				Enum.KeyCode.Three,
				Enum.KeyCode.Four,
				Enum.KeyCode.Five,
				Enum.KeyCode.Six,
				Enum.KeyCode.Seven,
				Enum.KeyCode.Eight,
				Enum.KeyCode.Nine,
				Enum.KeyCode.Zero
			)
		elseif val == false then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
			CAS:UnbindAction(FREEZE_COMMAND)
		end
	end

	function unblock()
		spawn(function()
			for i = 1,5 do
				wait()
				local A_1 = 
					{
						[1] = pass, 
						[2] = "Blocking", 
						[3] = false
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Functions
				Event:InvokeServer(A_1)
			end
		end)
	end

	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "g" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BoneHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "WindHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SakuyaOrb",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BiggerBurstEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BigWindEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BurstEffect1",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)

	spawn(function()
		while true do
			if dead == true then break end
			wait()
			if inv == true then
				spawn(function()
					local A_1 = 
						{
							[1] = pass, 
							[2] = "InvFrames", 
							[3] = 0.5
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Events
					Event:FireServer(A_1)
				end)
			end
		end
	end)

	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "h" then
			if db == true then
				local args = {
					[1] = {
						[1] = getrenv()._G.Pass,
						[2] = "Telekinesis",
						[3] = "Special2",
						[4] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
					}
				}

				game:GetService("ReplicatedStorage").Remotes.SansMoves:InvokeServer(unpack(args))

			end
		end
	end)

	function hitnear()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Knockback", 
									["HitEffect"] = "BoneHitEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 1, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = nil, 
									["Damage"] = 0
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "g" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BoneHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "WindHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SakuyaOrb",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BiggerBurstEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BigWindEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BurstEffect1",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)

	function talk(text,color)
		if dead == true then return end
		local A_1 = 
			{
				[1] = getrenv()._G.Pass, 
				[2] = "Chatted", 
				[3] = text, 
				[4] = color
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Events
		Event:FireServer(A_1)
	end

	function getlockchar()
		local char = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		return char
	end

	function getlock()
		local pos = mouse.Hit.p
		if game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value ~= nil then
			pos = workspace:FindFirstChild(game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Name).Torso.Position
		end
		warn(pos)
		return pos
	end


	-- AMIMATIONS:

	local PunchAnim = Instance.new("Animation")
	PunchAnim.AnimationId = "rbxassetid://4357851278"
	local PunchAnimTrack = humanoid:LoadAnimation(PunchAnim)
	PunchAnimTrack.Priority = Enum.AnimationPriority.Action
	PunchAnimTrack.Looped = false

	local PunchAnim2 = Instance.new("Animation")
	PunchAnim2.AnimationId = "rbxassetid://4357872409"
	local PunchAnim2Track = humanoid:LoadAnimation(PunchAnim2)
	PunchAnim2Track.Priority = Enum.AnimationPriority.Action
	PunchAnim2Track.Looped = false

	local PunchAnim3 = Instance.new("Animation")
	PunchAnim3.AnimationId = "rbxassetid://4357890370"
	local PunchAnim3Track = humanoid:LoadAnimation(PunchAnim3)
	PunchAnim3Track.Priority = Enum.AnimationPriority.Action
	PunchAnim3Track.Looped = false

	local LastPunchAnim = Instance.new("Animation")
	LastPunchAnim.AnimationId = "rbxassetid://4357907686"
	local LastPunchAnimTrack = humanoid:LoadAnimation(LastPunchAnim)
	LastPunchAnimTrack.Priority = Enum.AnimationPriority.Action
	LastPunchAnimTrack.Looped = false

	local SleepAnim = Instance.new("Animation")
	SleepAnim.AnimationId = "rbxassetid://3877055653"
	local SleepAnimTrack = humanoid:LoadAnimation(SleepAnim)
	SleepAnimTrack.Priority = Enum.AnimationPriority.Action
	SleepAnimTrack.Looped = true
	--SleepAnimTrack:Play()

	local HurtAnim = Instance.new("Animation")
	HurtAnim.AnimationId = "rbxassetid://4460182501"
	local HurtAnimTrack = humanoid:LoadAnimation(HurtAnim)
	HurtAnimTrack.Priority = Enum.AnimationPriority.Action
	HurtAnimTrack.Looped = false
	--HurtAnimTrack:Play()

	local HurtGroundAnim = Instance.new("Animation")
	HurtGroundAnim.AnimationId = "rbxassetid://4416715001"
	local HurtGroundAnimTrack = humanoid:LoadAnimation(HurtGroundAnim)
	HurtGroundAnimTrack.Priority = Enum.AnimationPriority.Action
	HurtGroundAnimTrack.Looped = true
	--HurtGroundAnimTrack:Play()

	-- ATTACKS:
	function punch()
		PunchAnimTrack:Play()
		bone(true)
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Knockback", 
									["HitEffect"] = "BoneHitEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["Karma"] = 50,
									["HitTime"] = 1, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
			wait(0.5)
			bone(false)
		end)
	end

	function dunk()
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://6122095988"
		local animmTrack = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
		animmTrack.Priority = Enum.AnimationPriority.Action
		animmTrack.Looped = false
		animmTrack:Play()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getlockchar().HumanoidRootPart.CFrame * CFrame.new(0,0,3)
		talk("get dunked on.",Color3.new(1,1,1))
		for i = 1,7 do
			spawn(function()
				for i = 1,2 do
					local A_1 = pass
					local A_3 = 
						{
							["Type"] = "Normal", 
							["HitEffect"] = "SansLineBones", 
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
							["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector +  Vector3.new(0.001,0.001,0.001), 
							["Karma"] = 2, 
							["HitTime"] = 1, 
							["VictimCFrame"] = CFrame.new(0,0,0), 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.Hurt, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1,getlockchar(), A_3)
				end
			end)
			wait(0.17)
		end
		spawn(function()
			local A_1 = pass
			local A_2 = game:GetService("Workspace").NoStaminaDummy
			local A_3 = 
				{
					["Type"] = "Knockback", 
					["HitEffect"] = "BoneHitEffect", 
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector +  Vector3.new(0.001,25,0.001), 
					["Karma"] = 10, 
					["HitTime"] = 1, 
					["VictimCFrame"] = CFrame.new(0,0,0), 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1,getlockchar(), A_3)
		end)
	end

	function infkr()
		stun(true)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getlockchar().HumanoidRootPart.CFrame * CFrame.new(0,0,3)
		local target = getlockchar()
		holdbone = true
		local A_1 = pass
		local A_2 = target
		local A_3 = 
			{
				["Type"] = "Normal", 
				["HitEffect"] = "BoneHitEffect", 
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned, 
				["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
				["CameraShake"] = "Bump", 
				["HitTime"] = 5, 
				["Karma"] = 0,
				["VictimCFrame"] = nil, 
				["Sound"] = game:GetService("ReplicatedStorage").Sounds.Break, 
				["Damage"] = 10
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
		wait(1)
		for i = 1,8 do 
			spawn(function()
				local A_1 = pass
				local A_2 = target
				local A_3 = 
					{
						["Type"] = "Normal", 
						["HitEffect"] = "BoneHitEffect", 
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned, 
						["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
						["CameraShake"] = "Bump", 
						["HitTime"] = 5, 
						["Karma"] = 0,
						["VictimCFrame"] = nil, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
			end)
			local anim = math.random(1,3)
			if anim == 1 then
				PunchAnimTrack:Play()
			elseif anim == 2 then
				PunchAnim2Track:Play()
			elseif anim == 3 then
				PunchAnim3Track:Play()
			end
			wait(0.5)
		end
		LastPunchAnimTrack:Play()
		wait(0.3)
		stun(false)
		bone(false)
		local A_1 = pass
		local A_2 = target
		local A_3 = 
			{
				["Type"] = "Knockback", 
				["HitEffect"] = "BoneHitEffect", 
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
				["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
				["CameraShake"] = "Bump", 
				["HitTime"] = 2, 
				["Karma"] = math.huge,
				["VictimCFrame"] = nil, 
				["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
				["Damage"] = 10
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end

	function rainbowattack()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Knockback", 
									["HitEffect"] = "RainbowExplosion", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 1, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Fire, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	-- COOLDOWNS
	local punchcd = false
	local dunkcd = false
	local rainbowcd = false
	local infkrcd = false

	mouse.KeyDown:Connect(function(k)
		if dead == true then return end
		if game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored == true then return end
		if k == "z" then
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "GasterBlasters", 
					[3] = "SummonSpecial", 
					[4] = getlock()
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
			Event:InvokeServer(A_1)
		elseif k == "x" then
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "GasterBlasters", 
					[3] = "SummonEight", 
					[4] = getlock()
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
			Event:InvokeServer(A_1)
		elseif k == "c" then
			if dunkcd == true then return end
			spawn(function()
				dunkcd = true
				wait(5)
				dunkcd = false
			end)
			print("dunk")
			dunk()
		elseif k == "v" then
			if punchcd == true then return end
			spawn(function()
				punchcd = true
				wait(1)
				punchcd = false
			end)
			print("punch")
			punch()
		elseif k == "b" then
			if rainbowcd == true then return end
			spawn(function()
				rainbowcd = true
				wait(1)
				rainbowcd = false
			end)
			print("rainbowattack")
			rainbowattack()
		elseif k == "n" then
			if infkrcd == true then return end
			spawn(function()
				infkrcd = true
				wait(8)
				infkrcd = false
			end)
			print("inf kr")
			infkr()
		end
	end)

	-- Music:
	for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
		v:Destroy()
	end
	local music = Instance.new("Sound",game.Players.LocalPlayer:WaitForChild("StarterPlaylist"))
	music.Volume = 0.7
	music.SoundId = "rbxassetid://4628607656"
	music.Looped = true
	music:Play()
	print("musik gone")



	warn("Waiting For Phase 2")
	repeat wait()

	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 700
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	HurtAnimTrack:Play()
	phase = 2
	print("phase "..phase)
	music:Stop()
	wait(2)
	HurtGroundAnimTrack:Play()
	wait(1)
	talk("!?",Color3.new(0.5,0.5,0.5))
	wait(3)
	talk("heh.",Color3.new(0.5,0.5,0.5))
	wait(3)
	HurtGroundAnimTrack:Stop()
	wait()
	SleepAnimTrack:Play()
	talk("guess i have another shot at you, huh?",Color3.new(1,0,0))
	wait(3)
	talk("there's no point in giving up at this point.",Color3.new(0.5,0.5,0.5))
	wait(3)
	talk("and i can't screw up this last chance i've been given.",Color3.new(1,0,0))
	wait(5)
	talk("no matter what it takes...",Color3.new(0.5,0.5,0.5))
	wait(3)
	talk("i'll bring you to justice.",Color3.new(0.5,0.5,0.5))
	wait(3)
	talk("and i will make you suffer what we felt.",Color3.new(1,0,0))
	wait(4)
	talk("so, kiddo, get ready...",Color3.new(0.5,0.5,0.5))
	wait(4)
	talk("because you're about to get dunked on much harder than before.",Color3.new(1,0,0))
	wait(6)
	holdbone = true
	SleepAnimTrack:Stop()
	music.SoundId = "rbxassetid://4686555781"
	music.TimePosition = 0
	music:Play()
	inv = false
	unblock()
	stun(false)
	warn("Waiting For Phase 3")
	repeat wait()

	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 500
	music:Stop()
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	holdbone = false
	wait()
	hidebone()
	wait(2)
	talk("what just happened?",Color3.new(1,0,0))
	wait(3)
	talk("..?",Color3.new(0.5,0.5,0.5))
	wait(3)
	talk("oh hey there!",Color3.new(0.5,0.5,0.5))
	wait(2)
	talk("i see that you have finally arrived huh?",Color3.new(1,0,0))
	wait(3)
	talk("oh well, kid",Color3.new(0.5,0.5,0.5))
	wait(2)
	talk("you will now face something that you will hardly forget.",Color3.new(1,0,0))
	wait(5)
	talk("i have told you from many genocide routes before...",Color3.new(0.5,0.5,0.5))
	wait(5)
	talk("reset.",Color3.new(1,0,0))
	wait(1)
	talk("but you didn't listen to me.",Color3.new(0.5,0.5,0.5))
	wait(3)
	talk("you could have fixed all this in only a press of a button.",Color3.new(1,0,0))
	wait(5)
	talk("but now, it's too late.",Color3.new(0.5,0.5,0.5))
	wait(3)
	talk("now you will face our your consequences...",Color3.new(1,0,0))
	wait(4)
	talk("that driven you into this.",Color3.new(1,0,0))
	SleepAnimTrack:Play()
	music.SoundId = "rbxassetid://4739499225"
	music.TimePosition = 0
	music.Looped = false
	music:Play()
	wait(47)
	stun(false)
	SleepAnimTrack:Stop()
	wait(147)
	stun(true)
	wait(45)
	local A_1 = 
		{
			[1] = getrenv()._G.Pass, 
			[2] = "Reset"
		}
	local Event = game:GetService("ReplicatedStorage").Remotes.Functions
	Event:InvokeServer(A_1)
end)


section1:addButton("Asgore", function()
	local textonattack = false
	local godmode = true
	local autoblock = true
	local dead = false
	local pass = getrenv()._G.Pass
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local uis = game:GetService("UserInputService")
	local mouse = game.Players.LocalPlayer:GetMouse()
	game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "XSans"
	if not localPlayer.Character then
		localPlayer.CharacterAdded:Wait()
	end
	wait(2)
	print("running main thingy idk")
	local humanoid = localPlayer.Character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		dead = true
		warn("dead how")
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,-10,0)
	end)
	local NormalPunchAnim = Instance.new("Animation")
	NormalPunchAnim.AnimationId = "rbxassetid://5411089475"
	local NormalPunchAnimTrack = humanoid:LoadAnimation(NormalPunchAnim)
	NormalPunchAnimTrack.Priority = Enum.AnimationPriority.Action
	NormalPunchAnimTrack.Looped = false

	-- Remove Animations/Attacks:
	local AnimationTracks = humanoid:GetPlayingAnimationTracks()
	repeat wait()
	until game.Players.LocalPlayer.Backpack:FindFirstChild("Main")
	game.Players.LocalPlayer.Backpack.Main:WaitForChild("XSansMoves"):Destroy()
	for i, track in pairs (AnimationTracks) do
		track:Stop()
	end

	spawn(function()
		wait(0.5)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end)

	-- Music:

	local music = game.Players.LocalPlayer:WaitForChild("StarterPlaylist")["1Theme"]
	music.SoundId = "rbxassetid://511172361"
	music.TimePosition = 0
	music.Looped = true
	music:Play()

	-- GodMode:

	spawn(function()
		wait(2)
		if godmode == true then
			while wait(0.1) do
				if dead == true then return end
				local A_1 = 
					{
						[1] = pass, 
						[2] = "InvFrames", 
						[3] = 0.5
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
			end
		end
	end)

	-- Auto Block:
	spawn(function()
		if autoblock == true then
			while wait(0.1) do
				if dead == true then return end
				local A_1 = 
					{
						[1] = pass, 
						[2] = "Blocking", 
						[3] = true
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Functions
				Event:InvokeServer(A_1)
			end
		end
	end)

	-- UnAnchor:

	spawn(function()
		while wait() do
			for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA("Part") then
					v.Anchored = false
				end
			end
		end
	end)

	-- Talk Function:

	function talk(message)
		if dead == true then return end
		local A_1 = 
			{
				[1] = pass,
				[2] = "Chatted", 
				[3] = message, 
				[4] = Color3.new(0.9,0.9,0)
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Events
		Event:FireServer(A_1)
	end

	game.Players.LocalPlayer.Chatted:Connect(function(msg)
		talk(msg)
	end)

	-- Attack Coolowns:

	local normalpunchcooldown = false
	local normalbarragecooldown = false
	local uppercutnormalcooldown = false
	local seriousbarragecooldown = false
	local uppercutseriouscooldown = false
	local seriouspunchcooldown = false

	-- Attacks:

	function seriouspunch()
		if seriouspunchcooldown == true then return end
		spawn(function()
			seriouspunchcooldown = true
			wait(5)
			seriouspunchcooldown = false
		end)
		if textonattack == true then
			talk("Serious Punch")
		end
		NormalPunchAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "BigWindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function normalpunch()
		if normalpunchcooldown == true then return end
		spawn(function()
			normalpunchcooldown = true
			wait(0.3)
			normalpunchcooldown = false
		end)
		if textonattack == true then
			talk("Normal Punch")
		end
		NormalPunchAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "WindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function tp()
		if game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value ~= nil then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Torso.CFrame * CFrame.new(0,0,5)
		else
			game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.p)
		end
	end

	function barragenormal()
		if normalbarragecooldown == true then return end
		if textonattack == true then
			talk("Consecutive Normal Punch")
		end
		spawn(function()
			normalbarragecooldown = true
			wait(3)
			normalbarragecooldown = false
		end)
		local BarrageAnim = Instance.new("Animation")
		BarrageAnim.AnimationId = "rbxassetid://5411101340"
		local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
		BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
		BarrageAnimTrack.Looped = false
		BarrageAnimTrack:Play()
		wait(0.5)
		for i = 1,7 do
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "WindEffect", 
										["HurtAnimation"] = nil, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
			wait(0.1)
		end
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "WindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function barrageserious()
		if seriousbarragecooldown == true then return end
		if textonattack == true then
			talk("Consecutive Serious Punch")
		end
		spawn(function()
			seriousbarragecooldown = true
			wait(3)
			seriousbarragecooldown = false
		end)
		local BarrageAnim = Instance.new("Animation")
		BarrageAnim.AnimationId = "rbxassetid://5411103778"
		local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
		BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
		BarrageAnimTrack.Looped = false
		BarrageAnimTrack:Play()
		wait(0.5)
		for i = 1,7 do
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "BigWindEffect", 
										["HurtAnimation"] = nil, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
			wait(0.1)
		end
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "BigWindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function uppercutnormal()
		if uppercutnormalcooldown == true then return end
		if textonattack == true then
			talk("Normal Uppercut")
		end
		spawn(function()
			uppercutnormalcooldown = true
			wait(2)
			uppercutnormalcooldown = false
		end)
		local UpperCutAnim = Instance.new("Animation")
		UpperCutAnim.AnimationId = "rbxassetid://5411106079"
		local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
		UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
		UpperCutAnimTrack.Looped = false
		UpperCutAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "WindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 25 + Vector3.new(0.01,50,0.01), 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function uppercutserious()
		if uppercutseriouscooldown == true then return end
		if textonattack == true then
			talk("Serious Uppercut")
		end
		spawn(function()
			uppercutseriouscooldown = true
			wait(2)
			uppercutseriouscooldown = false
		end)
		local UpperCutAnim = Instance.new("Animation")
		UpperCutAnim.AnimationId = "rbxassetid://5411107197"
		local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
		UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
		UpperCutAnimTrack.Looped = false
		UpperCutAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "BigWindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 70 + Vector3.new(0.01,100,0.01), 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end
	local attacking = false
	uis.InputBegan:Connect(function(input,gpe)
		if dead == true then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.R then
				tp()
			end
			if attacking == true then return end
			if input.KeyCode == Enum.KeyCode.One then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				normalpunch()
			elseif input.KeyCode == Enum.KeyCode.Two then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				barragenormal()
			elseif input.KeyCode == Enum.KeyCode.Three then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				uppercutnormal()
			elseif input.KeyCode == Enum.KeyCode.Four then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				barrageserious()
			elseif input.KeyCode == Enum.KeyCode.Five then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				uppercutserious()
			elseif input.KeyCode == Enum.KeyCode.Six then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				seriouspunch()
			end
		end
	end)
end)





section1:addButton("Saitama", function()
	local textonattack = true
	local godmode = true
	local autoblock = true
	local dead = false
	local pass = getrenv()._G.Pass
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local uis = game:GetService("UserInputService")
	local mouse = game.Players.LocalPlayer:GetMouse()
	game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "XSans"
	if not localPlayer.Character then
		localPlayer.CharacterAdded:Wait()
	end
	wait(2)
	print("running main thingy idk")
	local humanoid = localPlayer.Character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		dead = true
		warn("dead how")
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,-10,0)
	end)
	local NormalPunchAnim = Instance.new("Animation")
	NormalPunchAnim.AnimationId = "rbxassetid://5776238345"
	local NormalPunchAnimTrack = humanoid:LoadAnimation(NormalPunchAnim)
	NormalPunchAnimTrack.Priority = Enum.AnimationPriority.Action
	NormalPunchAnimTrack.Looped = false

	-- Remove Animations/Attacks:
	local AnimationTracks = humanoid:GetPlayingAnimationTracks()
	repeat wait()
	until game.Players.LocalPlayer.Backpack:FindFirstChild("Main")
	game.Players.LocalPlayer.Backpack.Main:WaitForChild("XSansMoves"):Destroy()
	for i, track in pairs (AnimationTracks) do
		track:Stop()
	end

	spawn(function()
		wait(0.5)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end)

	-- Music:

	local music = game.Players.LocalPlayer:WaitForChild("StarterPlaylist")["1Theme"]
	music.SoundId = "rbxassetid://431438203"
	music.TimePosition = 0
	music.Looped = true
	music:Play()

	-- GodMode:

	spawn(function()
		wait(2)
		if godmode == true then
			while wait(0.1) do
				if dead == true then return end
				local A_1 = 
					{
						[1] = pass, 
						[2] = "InvFrames", 
						[3] = 0.5
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
			end
		end
	end)

	-- Auto Block:
	spawn(function()
		if autoblock == true then
			while wait(0.1) do
				if dead == true then return end
				local A_1 = 
					{
						[1] = pass, 
						[2] = "Blocking", 
						[3] = true
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Functions
				Event:InvokeServer(A_1)
			end
		end
	end)

	-- UnAnchor:

	spawn(function()
		while wait() do
			for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA("Part") then
					v.Anchored = false
				end
			end
		end
	end)

	-- Talk Function:

	function talk(message)
		if dead == true then return end
		local A_1 = 
			{
				[1] = pass,
				[2] = "Chatted", 
				[3] = message, 
				[4] = Color3.new(0.9,0.9,0)
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Events
		Event:FireServer(A_1)
	end

	game.Players.LocalPlayer.Chatted:Connect(function(msg)
		talk(msg)
	end)

	-- Attack Coolowns:

	local normalpunchcooldown = false
	local normalbarragecooldown = false
	local uppercutnormalcooldown = false
	local seriousbarragecooldown = false
	local uppercutseriouscooldown = false
	local seriouspunchcooldown = false

	-- Attacks:

	function seriouspunch()
		if seriouspunchcooldown == true then return end
		spawn(function()
			seriouspunchcooldown = true
			wait(5)
			seriouspunchcooldown = false
		end)
		if textonattack == true then
			talk("Serious Punch")
		end
		NormalPunchAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "BigWindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function normalpunch()
		if normalpunchcooldown == true then return end
		spawn(function()
			normalpunchcooldown = true
			wait(0.3)
			normalpunchcooldown = false
		end)
		if textonattack == true then
			talk("Normal Punch")
		end
		NormalPunchAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "WindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function tp()
		if game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value ~= nil then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Torso.CFrame * CFrame.new(0,0,5)
		else
			game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.p)
		end
	end

	function barragenormal()
		if normalbarragecooldown == true then return end
		if textonattack == true then
			talk("Consecutive Normal Punch")
		end
		spawn(function()
			normalbarragecooldown = true
			wait(3)
			normalbarragecooldown = false
		end)
		local BarrageAnim = Instance.new("Animation")
		BarrageAnim.AnimationId = "rbxassetid://4800436094"
		local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
		BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
		BarrageAnimTrack.Looped = false
		BarrageAnimTrack:Play()
		wait(0.5)
		for i = 1,7 do
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "WindEffect", 
										["HurtAnimation"] = nil, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
			wait(0.1)
		end
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "WindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function barrageserious()
		if seriousbarragecooldown == true then return end
		if textonattack == true then
			talk("Consecutive Serious Punch")
		end
		spawn(function()
			seriousbarragecooldown = true
			wait(3)
			seriousbarragecooldown = false
		end)
		local BarrageAnim = Instance.new("Animation")
		BarrageAnim.AnimationId = "rbxassetid://4800436094"
		local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
		BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
		BarrageAnimTrack.Looped = false
		BarrageAnimTrack:Play()
		wait(0.5)
		for i = 1,7 do
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "BigWindEffect", 
										["HurtAnimation"] = nil, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
			wait(0.1)
		end
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "BigWindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function uppercutnormal()
		if uppercutnormalcooldown == true then return end
		if textonattack == true then
			talk("Normal Uppercut")
		end
		spawn(function()
			uppercutnormalcooldown = true
			wait(2)
			uppercutnormalcooldown = false
		end)
		local UpperCutAnim = Instance.new("Animation")
		UpperCutAnim.AnimationId = "rbxassetid://4300091335"
		local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
		UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
		UpperCutAnimTrack.Looped = false
		UpperCutAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "WindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 25 + Vector3.new(0.01,50,0.01), 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	function uppercutserious()
		if uppercutseriouscooldown == true then return end
		if textonattack == true then
			talk("Serious Uppercut")
		end
		spawn(function()
			uppercutseriouscooldown = true
			wait(2)
			uppercutseriouscooldown = false
		end)
		local UpperCutAnim = Instance.new("Animation")
		UpperCutAnim.AnimationId = "rbxassetid://4300091335"
		local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
		UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
		UpperCutAnimTrack.Looped = false
		UpperCutAnimTrack:Play()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Normal", 
									["HitEffect"] = "BigWindEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 70 + Vector3.new(0.01,100,0.01), 
									["CameraShake"] = "Bump", 
									["HitTime"] = 0, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
									["Damage"] = 10
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end
	local attacking = false
	uis.InputBegan:Connect(function(input,gpe)
		if dead == true then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.R then
				tp()
			end
			if attacking == true then return end
			if input.KeyCode == Enum.KeyCode.One then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				normalpunch()
			elseif input.KeyCode == Enum.KeyCode.Two then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				barragenormal()
			elseif input.KeyCode == Enum.KeyCode.Three then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				uppercutnormal()
			elseif input.KeyCode == Enum.KeyCode.Four then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				barrageserious()
			elseif input.KeyCode == Enum.KeyCode.Five then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				uppercutserious()
			elseif input.KeyCode == Enum.KeyCode.Six then
				spawn(function()
					attacking = true
					wait(0)
					attacking = false
				end)
				seriouspunch()
			end
		end
	end)
end)

section2:addButton("bluebone lmb sans", function()
	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "x" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://5657141412"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 5,
					["Type"] = "Normal",
					["HitEffect"] = "SpearHitEffect",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 5,
					["Type"] = "Normal",
					["HitEffect"] = "SakuyaBar",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
		end
	end)
end)
section3:addButton("XGaster", function()
	local player = game.Players.LocalPlayer
	repeat wait() until player.Character.Humanoid
	local humanoid = player.Character.Humanoid
	local mouse = player:GetMouse()

	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "x" then
			if db == true then
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Overwrite", 
						[3] = "Summon"
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
				Event:InvokeServer(A_1)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "PurpleHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "PurpleHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "PurpleHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "PurpleHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "PurpleHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				wait(0.1)
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Chatted", 
						[3] = "ACT = [SUMMON KNIVES]", 
						[4] = Color3.new(1, 0.0784314, 1)
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "IntHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Overwrite", 
						[3] = "UnSummon"
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
				Event:InvokeServer(A_1)

			end
		end
	end)
	local player = game.Players.LocalPlayer
	repeat wait() until player.Character.Humanoid
	local humanoid = player.Character.Humanoid
	local mouse = player:GetMouse()


	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://3201766456"

	mouse.KeyDown:connect(function(key)
		if key == "z" then
			local playAnim = humanoid:LoadAnimation(anim)
			playAnim:Play()
			wait(3)
			playAnim:Stop()

		end
	end)

	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "z" then
			if db == true then
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "YellowHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				wait(0.1)
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Chatted", 
						[3] = "ACT = [SUMMON BARAGE]", 
						[4] = Color3.new(1, 0.0784314, 1)
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "IntHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "YellowHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "YellowHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "YellowHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "YellowHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "YellowHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "HateHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{	
						["HitTime"] = 0.5, 
						["Type"] = "Normal", 
						["HitEffect"] = "HateHitEffect",
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				db = false
				wait(1)
				db = true
			end
		end
	end)
	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "c" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Overwrite", 
					[3] = "Summon"
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
			Event:InvokeServer(A_1)

			game.Players:Chat[[[ACT] = [CONTROL =  SPAWN CHARACTER = INK!SANS   = FORCE SET SPAWN DELTA!SANS SPECIAL ATTACK]]


			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "FinalDeltaAttack",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Overwrite", 
					[3] = "UnSummon"
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
			Event:InvokeServer(A_1)

			game.Players:Chat[[[ACT] = [CONTROL =  SPAWN CHARACTER = INK!SANS   = FORCE SET SPAWN DELTA!SANS SPECIAL ATTACK]]


			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SakuyaOrb",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()

			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 1,
					["Type"] = "Normal",
					["HitEffect"] = "SansLineBones",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 5,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 5,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 5,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 5,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
		end
	end)

	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "v" then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SakuyaOrb",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "Knockback",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "Knockback",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "Knockback",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "Knockback",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "UndyingExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(100, 100, 100), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)
	section1:addButton("Epic!Sans V2", function()
		local textonattack = true
		local godmode = true
		local autoblock = true
		local dead = false
		local pass = getrenv()._G.Pass
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer
		local uis = game:GetService("UserInputService")
		local mouse = game.Players.LocalPlayer:GetMouse()
		game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "XSans"
		if not localPlayer.Character then
			localPlayer.CharacterAdded:Wait()
		end
		wait(2)
		print("running main thingy idk")
		local humanoid = localPlayer.Character:WaitForChild("Humanoid")
		humanoid.Died:Connect(function()
			dead = true
			warn("dead how")
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,-10,0)
		end)
		local NormalPunchAnim = Instance.new("Animation")
		NormalPunchAnim.AnimationId = "rbxassetid://5776238345"
		local NormalPunchAnimTrack = humanoid:LoadAnimation(NormalPunchAnim)
		NormalPunchAnimTrack.Priority = Enum.AnimationPriority.Action
		NormalPunchAnimTrack.Looped = false

		-- Remove Animations/Attacks:
		local AnimationTracks = humanoid:GetPlayingAnimationTracks()
		repeat wait()
		until game.Players.LocalPlayer.Backpack:FindFirstChild("Main")
		game.Players.LocalPlayer.Backpack.Main:WaitForChild("XSansMoves"):Destroy()
		for i, track in pairs (AnimationTracks) do
			track:Stop()
		end

		spawn(function()
			wait(0.5)
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end)

		-- Music:

		local music = game.Players.LocalPlayer:WaitForChild("StarterPlaylist")["1Theme"]
		music.SoundId = "rbxassetid://6123744744"
		music.TimePosition = 0
		music.Looped = true
		music:Play()

		-- GodMode:

		spawn(function()
			wait(2)
			if godmode == true then
				while wait(0.1) do
					if dead == true then return end
					local A_1 = 
						{
							[1] = pass, 
							[2] = "InvFrames", 
							[3] = 0.5
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Events
					Event:FireServer(A_1)
				end
			end
		end)

		-- Auto Block:
		spawn(function()
			if autoblock == true then
				while wait(0.1) do
					if dead == true then return end
					local A_1 = 
						{
							[1] = pass, 
							[2] = "Blocking", 
							[3] = true
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Functions
					Event:InvokeServer(A_1)
				end
			end
		end)

		-- UnAnchor:

		spawn(function()
			while wait() do
				for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("Part") then
						v.Anchored = false
					end
				end
			end
		end)

		-- Talk Function:

		function talk(message)
			if dead == true then return end
			local A_1 = 
				{
					[1] = pass,
					[2] = "Chatted", 
					[3] = message, 
					[4] = Color3.new(128,0,128)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
		end

		game.Players.LocalPlayer.Chatted:Connect(function(msg)
			talk(msg)
		end)

		-- Attack Coolowns:

		local normalpunchcooldown = false
		local normalbarragecooldown = false
		local uppercutnormalcooldown = false
		local seriousbarragecooldown = false
		local uppercutseriouscooldown = false
		local seriouspunchcooldown = false

		-- Attacks:

		function seriouspunch()
			if seriouspunchcooldown == true then return end
			spawn(function()
				seriouspunchcooldown = true
				wait(5)
				seriouspunchcooldown = false
			end)
			if textonattack == true then
				talk("totally not from Won punch man serious punch!")
			end
			NormalPunchAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "RainbowExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.SwordSlash,
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function normalpunch()
			if normalpunchcooldown == true then return end
			spawn(function()
				normalpunchcooldown = true
				wait(0.3)
				normalpunchcooldown = false
			end)
			if textonattack == true then
				talk("Epic tap!")
			end
			NormalPunchAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "RainbowExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function tp()
			if game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value ~= nil then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Torso.CFrame * CFrame.new(0,0,5)
			else
				game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.p)
			end
		end

		function barragenormal()
			if normalbarragecooldown == true then return end
			if textonattack == true then
				talk("EPIC CONSECUTIVE BARRAGE!")
			end
			spawn(function()
				normalbarragecooldown = true
				wait(3)
				normalbarragecooldown = false
			end)
			local BarrageAnim = Instance.new("Animation")
			BarrageAnim.AnimationId = "rbxassetid://4800436094"
			local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
			BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
			BarrageAnimTrack.Looped = false
			BarrageAnimTrack:Play()
			wait(0.5)
			for i = 1,7 do
				spawn(function()
					for i,v in pairs(workspace:GetChildren()) do
						if v:FindFirstChild("Torso") then
							if v.Name ~= game.Players.LocalPlayer.Name then
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
									local A_1 = pass
									local A_2 = v
									local A_3 = 
										{
											["Type"] = "Normal", 
											["HitEffect"] = "ConstantExplosions", 
											["HurtAnimation"] = nil, 
											["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
											["CameraShake"] = "Bump", 
											["HitTime"] = 0, 
											["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
											["Sound"] = game:GetService("ReplicatedStorage").Sounds.HumanVoice, 
											["Damage"] = 10
										}
									local Event = game:GetService("ReplicatedStorage").Remotes.Damage
									Event:InvokeServer(A_1, A_2, A_3)
								end
							end
						end
					end
				end)
				wait(0.1)
			end
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "ConstantExplosions", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function barrageserious()
			if seriousbarragecooldown == true then return end
			if textonattack == true then
				talk("Consecutive TROLL BARRAGE- ORA ORA ORA!")
			end
			spawn(function()
				seriousbarragecooldown = true
				wait(3)
				seriousbarragecooldown = false
			end)
			local BarrageAnim = Instance.new("Animation")
			BarrageAnim.AnimationId = "rbxassetid://4800436094"
			local BarrageAnimTrack = humanoid:LoadAnimation(BarrageAnim)
			BarrageAnimTrack.Priority = Enum.AnimationPriority.Action
			BarrageAnimTrack.Looped = false
			BarrageAnimTrack:Play()
			wait(0.5)
			for i = 1,7 do
				spawn(function()
					for i,v in pairs(workspace:GetChildren()) do
						if v:FindFirstChild("Torso") then
							if v.Name ~= game.Players.LocalPlayer.Name then
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
									local A_1 = pass
									local A_2 = v
									local A_3 = 
										{
											["Type"] = "Normal", 
											["HitEffect"] = "HateExplosion", 
											["HurtAnimation"] = nil, 
											["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.01, 
											["CameraShake"] = "Bump", 
											["HitTime"] = 0, 
											["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
											["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
											["Damage"] = 10
										}
									local Event = game:GetService("ReplicatedStorage").Remotes.Damage
									Event:InvokeServer(A_1, A_2, A_3)
								end
							end
						end
					end
				end)
				wait(0.1)
			end
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "HateExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Objects.Moves.Kamehameha.Sound.Explosion, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function uppercutnormal()
			if uppercutnormalcooldown == true then return end
			if textonattack == true then
				talk("normal epic pog tap")
			end
			spawn(function()
				uppercutnormalcooldown = true
				wait(2)
				uppercutnormalcooldown = false
			end)
			local UpperCutAnim = Instance.new("Animation")
			UpperCutAnim.AnimationId = "rbxassetid://4300091335"
			local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
			UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
			UpperCutAnimTrack.Looped = false
			UpperCutAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "SpearJusticeExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 25 + Vector3.new(0.01,50,0.01), 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.HeavySlash, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end

		function uppercutserious()
			if uppercutseriouscooldown == true then return end
			if textonattack == true then
				talk("serious quake pog cut!")
			end
			spawn(function()
				uppercutseriouscooldown = true
				wait(2)
				uppercutseriouscooldown = false
			end)
			local UpperCutAnim = Instance.new("Animation")
			UpperCutAnim.AnimationId = "rbxassetid://4300091335"
			local UpperCutAnimTrack = humanoid:LoadAnimation(UpperCutAnim)
			UpperCutAnimTrack.Priority = Enum.AnimationPriority.Action
			UpperCutAnimTrack.Looped = false
			UpperCutAnimTrack:Play()
			spawn(function()
				for i,v in pairs(workspace:GetChildren()) do
					if v:FindFirstChild("Torso") then
						if v.Name ~= game.Players.LocalPlayer.Name then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
								local A_1 = pass
								local A_2 = v
								local A_3 = 
									{
										["Type"] = "Normal", 
										["HitEffect"] = "SpearJusticeExplosion", 
										["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
										["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 70 + Vector3.new(0.01,100,0.01), 
										["CameraShake"] = "Bump", 
										["HitTime"] = 0, 
										["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
										["Sound"] = game:GetService("ReplicatedStorage").Sounds.Crack, 
										["Damage"] = 10
									}
								local Event = game:GetService("ReplicatedStorage").Remotes.Damage
								Event:InvokeServer(A_1, A_2, A_3)
							end
						end
					end
				end
			end)
		end
		local attacking = false
		uis.InputBegan:Connect(function(input,gpe)
			if dead == true then return end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.R then
					tp()
				end
				if attacking == true then return end
				if input.KeyCode == Enum.KeyCode.One then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					normalpunch()
				elseif input.KeyCode == Enum.KeyCode.Two then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					barragenormal()
				elseif input.KeyCode == Enum.KeyCode.Three then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					uppercutnormal()
				elseif input.KeyCode == Enum.KeyCode.Four then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					barrageserious()
				elseif input.KeyCode == Enum.KeyCode.Five then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					uppercutserious()
				elseif input.KeyCode == Enum.KeyCode.Six then
					spawn(function()
						attacking = true
						wait(0)
						attacking = false
					end)
					seriouspunch()
				end
			end
		end)end)
end)

section4:addButton("Godmode (Dm antiiiic if not working)", function()
	while wait() do
		local args = {
			[1] = {
				[1] = getrenv()._G.Pass,
				[2] = "InvFrames",
				[3] = 4.5
			}
		}

		game:GetService("ReplicatedStorage").Remotes.Events:FireServer(unpack(args))
		for tryhard,mode in pairs(game:service("Players").LocalPlayer.character.HumanoidRootPart:GetChildren()) do
			if mode.Name == "Server" then
				mode.Name = "no"
				mode:Destroy()
			end
		end
		for i,v in pairs(game:service("Players").LocalPlayer.character:GetChildren()) do
			if v.Name == "Hit" then
				v.Name = "ae"
				v:Destroy()
			end
		end
	end
end)

section1:addButton("Dusttrust sans", function()
	local phase = 1
	local inv = false
	local dead = false
	local holdbone = false
	local CAS = game:GetService("ContextActionService")
	local FREEZE_COMMAND  = "Stunned"
	CAS:UnbindAction(FREEZE_COMMAND)
	local pass = getrenv()._G.Pass
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local mouse = localPlayer:GetMouse()
	game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "Sans"
	if not localPlayer.Character then
		localPlayer.CharacterAdded:Wait()
	end
	wait(0.5)
	local root = localPlayer.Character.HumanoidRootPart
	wait(2)
	print("running main thingy idk")

	local humanoid = localPlayer.Character:WaitForChild("Humanoid")

	humanoid.Died:Connect(function()
		print("died")
		for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
			v:Destroy()
		end
		dead = true
		inv = false
	end)

	spawn(function()
		while wait() do
			if dead == true then break end
			local A_1 = 
				{
					[1] = pass, 
					[2] = "ChangeSetting", 
					[3] = "DeathScene", 
					[4] = false
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Functions
			Event:InvokeServer(A_1)
		end
	end)

	spawn(function()
		while wait() do
			if dead == true then break end
			if holdbone == true then
				if game.Players.LocalPlayer.Character.Bone.Transparency ~= 0 then
					local A_1 = 
						{
							[1] = getrenv()._G.Pass, 
							[2] = "SpawnBone", 
							[3] = true, 
							[4] = true
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
					Event:InvokeServer(A_1)
				end
			end
		end
	end)

	function hidebone()
		local A_1 = 
			{
				[1] = getrenv()._G.Pass, 
				[2] = "SpawnBone", 
				[3] = false, 
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
		Event:InvokeServer(A_1)
	end

	function bone(v)
		spawn(function()
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "SpawnBone", 
					[3] = v, 
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
			Event:InvokeServer(A_1)
		end)
	end

	function stun(val)
		if val == true then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
			CAS:BindActionAtPriority(
				FREEZE_COMMAND,
				function() 
					return Enum.ContextActionResult.Sink
				end,
				false,
				Enum.ContextActionPriority.High.Value,
				Enum.KeyCode.W,
				Enum.KeyCode.S,
				Enum.KeyCode.A,
				Enum.KeyCode.D,
				Enum.KeyCode.F,
				Enum.KeyCode.R,
				Enum.KeyCode.One,
				Enum.KeyCode.Two,
				Enum.KeyCode.Three,
				Enum.KeyCode.Four,
				Enum.KeyCode.Five,
				Enum.KeyCode.Six,
				Enum.KeyCode.Seven,
				Enum.KeyCode.Eight,
				Enum.KeyCode.Nine,
				Enum.KeyCode.Zero
			)
		elseif val == false then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
			CAS:UnbindAction(FREEZE_COMMAND)
		end
	end

	function unblock()
		spawn(function()
			for i = 1,5 do
				wait()
				local A_1 = 
					{
						[1] = pass, 
						[2] = "Blocking", 
						[3] = false
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Functions
				Event:InvokeServer(A_1)
			end
		end)
	end



	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "h" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BoneHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "WindHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SakuyaOrb",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BiggerBurstEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BigWindEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BurstEffect1",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)

	spawn(function()
		while true do
			if dead == true then break end
			wait()
			if inv == true then
				spawn(function()
					local A_1 = 
						{
							[1] = pass, 
							[2] = "InvFrames", 
							[3] = 0.5
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Events
					Event:FireServer(A_1)
				end)
			end
		end
	end)

	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "h" then
			if db == true then
				local args = {
					[1] = {
						[1] = getrenv()._G.Pass,
						[2] = "Telekinesis",
						[3] = "Special2",
						[4] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
					}
				}

				game:GetService("ReplicatedStorage").Remotes.SansMoves:InvokeServer(unpack(args))

			end
		end
	end)

	function hitnear()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Knockback", 
									["HitEffect"] = "BoneHitEffect", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 1, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = nil, 
									["Damage"] = 0
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "g" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BoneHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "WindHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SakuyaOrb",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BiggerBurstEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BigWindEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BurstEffect1",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)

	function talk(text,color)
		if dead == true then return end
		local A_1 = 
			{
				[1] = getrenv()._G.Pass, 
				[2] = "Chatted", 
				[3] = text, 
				[4] = color
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Events
		Event:FireServer(A_1)
	end

	function getlockchar()
		local char = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		return char
	end

	function getlock()
		local pos = mouse.Hit.p
		if game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value ~= nil then
			pos = workspace:FindFirstChild(game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Name).Torso.Position
		end
		warn(pos)
		return pos
	end


	-- AMIMATIONS:

	local PunchAnim = Instance.new("Animation")
	PunchAnim.AnimationId = "rbxassetid://4357851278"
	local PunchAnimTrack = humanoid:LoadAnimation(PunchAnim)
	PunchAnimTrack.Priority = Enum.AnimationPriority.Action
	PunchAnimTrack.Looped = false

	local PunchAnim2 = Instance.new("Animation")
	PunchAnim2.AnimationId = "rbxassetid://4357872409"
	local PunchAnim2Track = humanoid:LoadAnimation(PunchAnim2)
	PunchAnim2Track.Priority = Enum.AnimationPriority.Action
	PunchAnim2Track.Looped = false

	local PunchAnim3 = Instance.new("Animation")
	PunchAnim3.AnimationId = "rbxassetid://4357890370"
	local PunchAnim3Track = humanoid:LoadAnimation(PunchAnim3)
	PunchAnim3Track.Priority = Enum.AnimationPriority.Action
	PunchAnim3Track.Looped = false

	local LastPunchAnim = Instance.new("Animation")
	LastPunchAnim.AnimationId = "rbxassetid://4357907686"
	local LastPunchAnimTrack = humanoid:LoadAnimation(LastPunchAnim)
	LastPunchAnimTrack.Priority = Enum.AnimationPriority.Action
	LastPunchAnimTrack.Looped = false

	local SleepAnim = Instance.new("Animation")
	SleepAnim.AnimationId = "rbxassetid://3877055653"
	local SleepAnimTrack = humanoid:LoadAnimation(SleepAnim)
	SleepAnimTrack.Priority = Enum.AnimationPriority.Action
	SleepAnimTrack.Looped = true
	--SleepAnimTrack:Play()

	local HurtAnim = Instance.new("Animation")
	HurtAnim.AnimationId = "rbxassetid://4460182501"
	local HurtAnimTrack = humanoid:LoadAnimation(HurtAnim)
	HurtAnimTrack.Priority = Enum.AnimationPriority.Action
	HurtAnimTrack.Looped = false
	--HurtAnimTrack:Play()

	local HurtGroundAnim = Instance.new("Animation")
	HurtGroundAnim.AnimationId = "rbxassetid://4416715001"
	local HurtGroundAnimTrack = humanoid:LoadAnimation(HurtGroundAnim)
	HurtGroundAnimTrack.Priority = Enum.AnimationPriority.Action
	HurtGroundAnimTrack.Looped = true
	--HurtGroundAnimTrack:Play()

	-- MOVES
	--zmove
	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "z" then
			if db == true then
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				wait(0.1)
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Chatted", 
						[3] = "...", 
						[4] = Color3.new(1, 0, 0)
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
				wait(1.5)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}

				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				db = false
				wait(8)
				db = true
			end
		end
	end)
	--xmove
	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "x" then
			if db == true then
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "BettyAttackHitEffect",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.FinalPunchHurt, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "RainbowExplosion",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.FinalPunchHurt, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				wait(0.1)
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Chatted", 
						[3] = "i didnt know where to go, what to do... then one idea came up my mind", 
						[4] = Color3.new(1, 0, 0.0156863)
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
				wait(1.5)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "RainbowExplosion",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.FinalPunchHurt, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				db = false
				wait(1)
				db = true
			end
		end
	end)

	--cmove

	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "c" then
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "CrossLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(100, 100, 100), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)

	--vmove

	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "g" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "RainbowExplosion",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "ConstantExplosions",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "HateHitEffect",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(100, 100, 100), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)



	-- Music:
	for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
		v:Destroy()
	end
	local music = Instance.new("Sound",game.Players.LocalPlayer:WaitForChild("StarterPlaylist"))
	music.Volume = 0.7
	music.SoundId = "rbxassetid://5972286369"
	music.Looped = true
	music:Play()
	print("musik gone")



	warn("Waiting For Phase 2")
	repeat wait()

	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 700
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	HurtAnimTrack:Play()
	phase = 2
	print("phase "..phase)
	music:Stop()
	wait(2)
	talk("you think you are good enough to kill me in only one blow??",Color3.new(1,0,0))
	wait(3)
	talk("im not that weak",Color3.new(1,0,0))
	wait(3)
	talk("you will have to do more then stab me with that old rusty knife",Color3.new(1,0,0))
	wait(6)
	holdbone = false
	SleepAnimTrack:Stop()
	music.SoundId = "rbxassetid://6069012922"
	music.TimePosition = 0
	music:Play()
	inv = false
	unblock()
	stun(false)
	warn("Waiting For Phase 3")
	repeat wait()

	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 500
	music:Stop()
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	holdbone = true
	wait()
	hidebone()
	wait(3)
	talk("ALPHYS DETERMINATION SHINES INTO SANS SOUL",Color3.new(1,0,0))
	wait(4)
	SleepAnimTrack:Play()
	music.SoundId = "rbxassetid://5858116342"
	music.TimePosition = 0
	music.Looped = false
	music:Play()
	wait(1)
	stun(false)
	SleepAnimTrack:Stop()
	wait(200)
	stun(true)
	wait(5)

	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	HurtAnimTrack:Play()
	phase = 2
	print("phase "..phase)
	music:Stop()
	wait(2)
	talk("you think you are good enough to kill me in only one blow??",Color3.new(1,0,0))
	wait(3)
	talk("im not that weak",Color3.new(1,0,0))
	wait(3)
	talk("you will have to do more then stab me with that old rusty knife",Color3.new(1,0,0))
	wait(6)
	holdbone = false
	SleepAnimTrack:Stop()
	music.SoundId = "rbxassetid://6069012922"
	music.TimePosition = 0
	music:Play()
	inv = false
	unblock()
	stun(false)
	warn("Waiting For Phase 4")
	repeat wait()

		canmove = false
	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 500
	music:Stop()
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	holdbone = true
	wait()
	hidebone()
	wait(3)
	talk("You feel fear.",Color3.new(1,0,0))
	wait(3)
	talk("You feel scared.",Color3.new(1,0,0))
	wait(3)
	talk("You feel eer ie",Color3.new(1,0,0))
	wait(3)
	talk("You think something is wrong.",Color3.new(1,0,0))
	wait(3)
	SleepAnimTrack:Stop()
	music.SoundId = "rbxassetid://5881326660"
	music.TimePosition = 0
	canmove = true
	local A_1 = 
		{
			[1] = getrenv()._G.Pass, 
			[2] = "Reset"
		}
	local Event = game:GetService("ReplicatedStorage").Remotes.Functions
	Event:InvokeServer(A_1)
end)
section1:addButton("Mirrored Dust", function()
	local phase = 1
	local inv = false
	local dead = false
	local holdbone = false
	local CAS = game:GetService("ContextActionService")
	local FREEZE_COMMAND  = "Stunned"
	CAS:UnbindAction(FREEZE_COMMAND)
	local pass = getrenv()._G.Pass
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local mouse = localPlayer:GetMouse()
	game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "Sans"
	if not localPlayer.Character then
		localPlayer.CharacterAdded:Wait()
	end
	wait(0.5)
	local root = localPlayer.Character.HumanoidRootPart
	wait(2)
	print("running main thingy idk")

	local humanoid = localPlayer.Character:WaitForChild("Humanoid")

	humanoid.Died:Connect(function()
		print("died")
		for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
			v:Destroy()
		end
		dead = true
		inv = false
	end)

	spawn(function()
		while wait() do
			if dead == true then break end
			local A_1 = 
				{
					[1] = pass, 
					[2] = "ChangeSetting", 
					[3] = "DeathScene", 
					[4] = false
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Functions
			Event:InvokeServer(A_1)
		end
	end)

	spawn(function()
		while wait() do
			if dead == true then break end
			if holdbone == true then
				if game.Players.LocalPlayer.Character.Bone.Transparency ~= 0 then
					local A_1 = 
						{
							[1] = getrenv()._G.Pass, 
							[2] = "SpawnBone", 
							[3] = true, 
							[4] = true
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
					Event:InvokeServer(A_1)
				end
			end
		end
	end)

	function hidebone()
		local A_1 = 
			{
				[1] = getrenv()._G.Pass, 
				[2] = "SpawnBone", 
				[3] = false, 
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
		Event:InvokeServer(A_1)
	end

	function bone(v)
		spawn(function()
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "SpawnBone", 
					[3] = v, 
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
			Event:InvokeServer(A_1)
		end)
	end

	function stun(val)
		if val == true then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
			CAS:BindActionAtPriority(
				FREEZE_COMMAND,
				function() 
					return Enum.ContextActionResult.Sink
				end,
				false,
				Enum.ContextActionPriority.High.Value,
				Enum.KeyCode.W,
				Enum.KeyCode.S,
				Enum.KeyCode.A,
				Enum.KeyCode.D,
				Enum.KeyCode.F,
				Enum.KeyCode.R,
				Enum.KeyCode.One,
				Enum.KeyCode.Two,
				Enum.KeyCode.Three,
				Enum.KeyCode.Four,
				Enum.KeyCode.Five,
				Enum.KeyCode.Six,
				Enum.KeyCode.Seven,
				Enum.KeyCode.Eight,
				Enum.KeyCode.Nine,
				Enum.KeyCode.Zero
			)
		elseif val == false then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
			CAS:UnbindAction(FREEZE_COMMAND)
		end
	end

	function unblock()
		spawn(function()
			for i = 1,5 do
				wait()
				local A_1 = 
					{
						[1] = pass, 
						[2] = "Blocking", 
						[3] = false
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Functions
				Event:InvokeServer(A_1)
			end
		end)
	end



	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "h" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BoneHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "WindHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SakuyaOrb",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SpearHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "CrossLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BiggerBurstEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SpearJusticeExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BigWindEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "CrossLineBones", 
					["HitEffect"] = "BurstEffect1",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)

	spawn(function()
		while true do
			if dead == true then break end
			wait()
			if inv == true then
				spawn(function()
					local A_1 = 
						{
							[1] = pass, 
							[2] = "InvFrames", 
							[3] = 0.5
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Events
					Event:FireServer(A_1)
				end)
			end
		end
	end)

	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "y" then
			if db == true then
				local args = {
					[1] = {
						[1] = getrenv()._G.Pass,
						[2] = "Telekinesis",
						[3] = "Special2",
						[4] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
					}
				}

				game:GetService("ReplicatedStorage").Remotes.SansMoves:InvokeServer(unpack(args))

			end
		end
	end)

	function hitnear()
		spawn(function()
			for i,v in pairs(workspace:GetChildren()) do
				if v:FindFirstChild("Torso") then
					if v.Name ~= game.Players.LocalPlayer.Name then
						if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character["Right Leg"].Position).Magnitude <= 10 then
							local A_1 = pass
							local A_2 = v
							local A_3 = 
								{
									["Type"] = "Knockback", 
									["HitEffect"] = "KnifeHitEffect4", 
									["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
									["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
									["CameraShake"] = "Bump", 
									["HitTime"] = 1, 
									["VictimCFrame"] = v.HumanoidRootPart.CFrame, 
									["Sound"] = nil, 
									["Damage"] = 0
								}
							local Event = game:GetService("ReplicatedStorage").Remotes.Damage
							Event:InvokeServer(A_1, A_2, A_3)
						end
					end
				end
			end
		end)
	end

	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "g" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BoneHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "WindHitEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SakuyaOrb",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "SansLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BigWindEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BiggerBurstEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "CrossLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "BigWindEffect",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 2, 
					["Type"] = "Knockback", 
					["HitEffect"] = "RainbowExplosion",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(1, 1, 1), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)

	function talk(text,color)
		if dead == true then return end
		local A_1 = 
			{
				[1] = getrenv()._G.Pass, 
				[2] = "Chatted", 
				[3] = text, 
				[4] = color
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Events
		Event:FireServer(A_1)
	end

	function getlockchar()
		local char = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		return char
	end

	function getlock()
		local pos = mouse.Hit.p
		if game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value ~= nil then
			pos = workspace:FindFirstChild(game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Name).Torso.Position
		end
		warn(pos)
		return pos
	end


	-- AMIMATIONS:

	local PunchAnim = Instance.new("Animation")
	PunchAnim.AnimationId = "rbxassetid://4357851278"
	local PunchAnimTrack = humanoid:LoadAnimation(PunchAnim)
	PunchAnimTrack.Priority = Enum.AnimationPriority.Action
	PunchAnimTrack.Looped = false

	local PunchAnim2 = Instance.new("Animation")
	PunchAnim2.AnimationId = "rbxassetid://4357872409"
	local PunchAnim2Track = humanoid:LoadAnimation(PunchAnim2)
	PunchAnim2Track.Priority = Enum.AnimationPriority.Action
	PunchAnim2Track.Looped = false

	local PunchAnim3 = Instance.new("Animation")
	PunchAnim3.AnimationId = "rbxassetid://4357890370"
	local PunchAnim3Track = humanoid:LoadAnimation(PunchAnim3)
	PunchAnim3Track.Priority = Enum.AnimationPriority.Action
	PunchAnim3Track.Looped = false

	local LastPunchAnim = Instance.new("Animation")
	LastPunchAnim.AnimationId = "rbxassetid://4357907686"
	local LastPunchAnimTrack = humanoid:LoadAnimation(LastPunchAnim)
	LastPunchAnimTrack.Priority = Enum.AnimationPriority.Action
	LastPunchAnimTrack.Looped = false

	local SleepAnim = Instance.new("Animation")
	SleepAnim.AnimationId = "rbxassetid://3877055653"
	local SleepAnimTrack = humanoid:LoadAnimation(SleepAnim)
	SleepAnimTrack.Priority = Enum.AnimationPriority.Action
	SleepAnimTrack.Looped = true
	--SleepAnimTrack:Play()

	local HurtAnim = Instance.new("Animation")
	HurtAnim.AnimationId = "rbxassetid://4460182501"
	local HurtAnimTrack = humanoid:LoadAnimation(HurtAnim)
	HurtAnimTrack.Priority = Enum.AnimationPriority.Action
	HurtAnimTrack.Looped = false
	--HurtAnimTrack:Play()

	local HurtGroundAnim = Instance.new("Animation")
	HurtGroundAnim.AnimationId = "rbxassetid://4416715001"
	local HurtGroundAnimTrack = humanoid:LoadAnimation(HurtGroundAnim)
	HurtGroundAnimTrack.Priority = Enum.AnimationPriority.Action
	HurtGroundAnimTrack.Looped = true
	--HurtGroundAnimTrack:Play()

	-- MOVES
	--zmove
	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "z" then
			if db == true then
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				wait(0.1)
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Chatted", 
						[3] = "ez sit down  ez ez ez ez ez ze ze ", 
						[4] = Color3.new(1, 0, 0)
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
				wait(1.5)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "CrossLineBones",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}

				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				db = false
				wait(8)
				db = true
			end
		end
	end)
	--xmove
	local m = game.Players.LocalPlayer:GetMouse()
	db = true
	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "x" then
			if db == true then
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "ConstantExplosions",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.FinalPunchHurt, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "RainbowExplosion",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.FinalPunchHurt, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				wait(0.1)
				local A_1 = 
					{
						[1] = getrenv()._G.Pass, 
						[2] = "Chatted", 
						[3] = "i killed them all, now it's youre turn...", 
						[4] = Color3.new(1, 0, 0.0156863)
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Events
				Event:FireServer(A_1)
				wait(1.5)
				local A_1 = getrenv()._G.Pass
				local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
				local A_3 = 
					{
						["HitTime"] = 1, 
						["Type"] = "Normal", 
						["HitEffect"] = "RainbowExplosion",  
						["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.FinalPunchHurt, 
						["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
						["Damage"] = 10
					}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
				Event:InvokeServer(A_1, A_2, A_3)
				db = false
				wait(1)
				db = true
			end
		end
	end)

	--cmove

	m.keyDown:connect(function(k)
		k = k:lower()
		if k == "c" then
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "KnifeHitEffect4",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "BoneHitEffect",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "HateHitEffect",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "ConstantExplosions",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "CrossLineBones",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(100, 100, 100), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)



	--vmove

	AnimationId = '0'
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	bind = "g" -- has to be lowercase


	mouse.KeyDown:connect(function(key)
		if key == bind then
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "RainbowExplosion",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "ConstantExplosions",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			k:AdjustSpeed(1)
			local args = {
				[1] = getrenv()._G.Pass,
				[2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
				[3] = {
					["HitTime"] = 20,
					["Type"] = "Normal",
					["HitEffect"] = "HateHitEffect",
					["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
					["Velocity"] = Vector3.new(0, 0, -1),
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Damage"] = 10
				}
			}

			game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
			wait(1)
			k:Stop()

			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{
					["HitTime"] = 1, 
					["Type"] = "Knockback", 
					["HitEffect"] = "KnockBack",  
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SlideOnGround,  
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
					["Velocity"] = Vector3.new(100, 100, 100), 
					["CombatInv"] = true,
					["Damage"] = 35
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
		end
	end)



	-- Music:
	for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
		v:Destroy()
	end
	local music = Instance.new("Sound",game.Players.LocalPlayer:WaitForChild("StarterPlaylist"))
	music.Volume = 0.7
	music.SoundId = "rbxassetid://5972286369"
	music.Looped = true
	music:Play()
	print("musik gone")



	warn("Waiting For Phase 2")
	repeat wait()

	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 700
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	HurtAnimTrack:Play()
	phase = 2
	print("phase "..phase)
	music:Stop()
	wait(2)
	talk("you think you are good enough to kill me in only one blow??",Color3.new(1,0,0))
	wait(3)
	talk("im not that weak",Color3.new(1,0,0))
	wait(3)
	talk("you will have to do more then stab me with that old rusty knife",Color3.new(1,0,0))
	wait(6)
	holdbone = false
	SleepAnimTrack:Stop()
	music.SoundId = "rbxassetid://4645974767"
	music.TimePosition = 0
	music:Play()
	inv = false
	unblock()
	stun(false)
	warn("Waiting For Phase 3")
	repeat wait()

	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 500
	music:Stop()
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	holdbone = true
	wait()
	hidebone()
	wait(3)
	talk("perish..",Color3.new(1,0,0))
	wait(4)
	SleepAnimTrack:Play()
	music.SoundId = "rbxassetid://4645974767"
	music.TimePosition = 0
	music.Looped = false
	music:Play()
	wait(1)
	stun(false)
	SleepAnimTrack:Stop()
	wait(200)
	stun(true)
	wait(5)

	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	HurtAnimTrack:Play()
	phase = 2
	print("phase "..phase)
	music:Stop()
	wait(2)
	talk("..",Color3.new(1,0,0))
	wait(3)
	talk("im not that weak",Color3.new(1,0,0))
	wait(3)
	talk("you will have to do more then that to kill me.",Color3.new(1,0,0))
	wait(6)
	holdbone = false
	SleepAnimTrack:Stop()
	music.SoundId = "rbxassetid://4645974767"
	music.TimePosition = 0
	music:Play()
	inv = false
	unblock()
	stun(false)
	warn("Waiting For Phase 4")
	repeat wait()

		canmove = false
	until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 500
	music:Stop()
	inv = true
	hitnear()
	spawn(function()
		wait()
		local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf * CFrame.new(0,-40,0)
		wait(0.3)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
	end)
	wait(0.4)
	stun(true)
	holdbone = true
	wait()
	hidebone()
	wait(3)
	talk("this is the end.",Color3.new(1,0,0))
	wait(3)
	talk("insanity..",Color3.new(1,0,0))
	wait(3)
	talk("",Color3.new(1,0,0))
	wait(3)
	talk("You think something is wrong.",Color3.new(1,0,0))
	wait(3)
	SleepAnimTrack:Stop()
	music.SoundId = "rbxassetid://4645974767"
	music.TimePosition = 0
	canmove = true

section4:addKeybind("Toggle Keybind", Enum.KeyCode.One, function()
print("Activated Keybind")
venyx:toggle()
end, function()
print("Changed Keybind")
end)


section3:addButton("Revenge Papyrus", function()

local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local mouse = player:GetMouse()


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://3201766456"

mouse.KeyDown:connect(function(key)
	if key == "z" then
		local playAnim = humanoid:LoadAnimation(anim)
		playAnim:Play()
		wait(3)
		playAnim:Stop()

	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "so", 
					[4] = Color3.new(1, 0, 0)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 10, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "Ill teach you a lesson you wont forget", 
					[4] = Color3.new(1, 0, 0)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 15, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 20, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 13, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)
local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local mouse = player:GetMouse()


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://3207868272"

mouse.KeyDown:connect(function(key)
	if key == "x" then
		local playAnim = humanoid:LoadAnimation(anim)
		playAnim:Play()
		wait(3)
		playAnim:Stop()

	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "x" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "Nyeh Heh heh", 
					[4] = Color3.new(1, 1, 1)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.InGround, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)
local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local mouse = player:GetMouse()


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://4062755689"

mouse.KeyDown:connect(function(key)
	if key == "c" then
		local playAnim = humanoid:LoadAnimation(anim)
		playAnim:Play()
		wait(3)
		playAnim:Stop()

	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "c" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "You need someone to teach you good manners", 
					[4] = Color3.new(1, 1, 1)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.InGround, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)
AnimationId = '0'
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
bind = "v" -- has to be lowercase


mouse.KeyDown:connect(function(key)
if key == bind then
game.Players:Chat[[This is a lesson!]]


local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
game.Players:Chat[[GIVE ME SANS BACK!!!!!]]
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "SpearJusticeExplosion",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
game.Players:Chat[[JUST GIVE ME HIM BACK!]]
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "ConstantExplosions",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "HateExplosion",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
			end
			end)
end)
end)



local page = venyx:addPage("Customs 2", 5012544693)
local section7 = page:addSection("Main Menu customs")
local section8 = page:addSection("XTale Customs")
local section9 = page:addSection("SansCustoms")





section7:addButton("Underplayer (Full)", function()

_G.Died = 0
_G.Phase2 = false
_G.Done = false
_G.Underplayer = true

local Anim = Instance.new("Animation")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
bind1 = "z" --done
bind2 = "x" --redo
bind3 = "c" --done
bind4 = "v" --done
bind5 = "h" --done
bind6 = "g" --done
bind7 = "j" -- done
bind8 = "t"
local plr = game.Players.LocalPlayer

function checkdied()
    if _G.Died >= 3 then
        _G.Underplayer = false
        print("died")
        _G.Died = 0
        _G.Phase2 = false
        _G.Done = false
    elseif _G.Died < 3 then
       print("Haven't died yet")
       _G.Phase2 = true
   end
end

function checkphase()
    if _G.Phase2 == true and _G.Done == false then
        _G.Done = true
        print("DETERMINATION LOADED")
        wait(19)
        talk("FILE 999999 LOADED", 0.72549, 0, 0.0117647)
        wait(2)
        talk(plr.Name.."'s ATTACK CHANGED TO 100",0.72549, 0, 0.0117647)
        wait(4)
        talk(plr.Name.."'s DEFENSE CHANGED TO 200",0.72549, 0, 0.0117647)
    elseif _G.Phase2 == false then
        print("PHASE 2 IS FALSE")
    end
end

function talk(message, color3)
	color3 = color3 or "1,1,1"
	local A_1 = 
		{
			[1] = getrenv()._G.Pass,
			[2] = "Chatted", 
			[3] = message,
			[4] = Color3.new(color3)
		}
	local Event = game:GetService("ReplicatedStorage").Remotes.Events
	Event:FireServer(A_1)
end
plr.Chatted:Connect(function(msg)
    if _G.Underplayer == true then
        talk(msg, 0.72549, 0, 0.0117647)
    end
end)

if _G.Underplayer == true and _G.Died < 2 then
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
    game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "XSans"
    wait(1)
    plr.Character.Humanoid.Died:Connect(function()
        _G.Died = _G.Died + 1
        checkdied()
        checkphase()
    end)
    wait(2)
    talk("I am not frisk or chara.", 0.72549, 0, 0.0117647)
    wait(4)
    talk("You can call me... PLAYER.", 0.72549, 0, 0.0117647)
    mouse.KeyDown:Connect(function(input)
        if input == bind6 and _G.Underplayer == true then
            local locked = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
            local lockedplr = workspace[locked.Name]
            local A_1 = 
                {
                    [1] = getrenv()._G.Pass, 
                    [2] = "Teleport", 
                    [3] = CFrame.new(lockedplr.HumanoidRootPart.Position)
                }
            local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            player.Character.HumanoidRootPart.Anchored = true
            Event:InvokeServer(A_1)
            wait(1)
            player.Character.HumanoidRootPart.Anchored = false
            local args = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 25,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "KnifeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 0
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            wait(1)
            talk("Greetings.", 0.72549, 0, 0.0117647)
            wait(2)
            talk("Wanna know what just happened?", 0.72549, 0, 0.0117647)
            wait(4)
            talk("Monsters above this FUN numerical value are all my friends.", 0.72549, 0, 0.0117647)
            wait(6)
            talk("You didn't show any mercy to them...", 0.72549, 0, 0.0117647)
            wait(5)
            talk("So don't you dare think anyone would show mercy to you.", 1, 0, 0.0156863)
            wait(2)
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            local args2 = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 1,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "CrossLineBones",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 10
                }
            }

            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.1)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.1)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.1)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.1)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.1)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.1)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.1)
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://ANIMATIONIDHERE"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            local args3 = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 10,
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "SpearJusticeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(100, 75, 100),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 35
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args3))
        elseif input == bind5 and _G.Underplayer == true then
            local locked = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
            local lockedplr = workspace[locked.Name]
            local A_1 = 
                {
                    [1] = getrenv()._G.Pass, 
                    [2] = "Teleport", 
                    [3] = CFrame.new(lockedplr.HumanoidRootPart.Position)
                }
            local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            player.Character.HumanoidRootPart.Anchored = true
            Event:InvokeServer(A_1)
            wait(1)
            player.Character.HumanoidRootPart.Anchored = false
            local args = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 35,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "KnifeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 0
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            talk("Even the friend who helped you do the last hit is gone now.", 0.72549, 0, 0.0117647)
            wait(4)
            talk("There is nothing left for us here.", 0.72549, 0, 0.0117647)
            wait(4)
            talk("Let us erase this pointless world.", 0.72549, 0, 0.0117647)
            wait(4)
            talk("You don't want to? You still want to go back to this world?", 0.72549, 0, 0.0117647)
            wait(4)
            talk("But you have no souls to give me.", 0.72549, 0, 0.0117647)
            wait(3)
            talk("However you still have something I want.", 0.72549, 0, 0.0117647)
            wait(3)
            talk("Give this to me and I will let you go back.", 0.72549, 0, 0.0117647)
            wait(3)
            talk("...Why won't you choose?", 0.72549, 0, 0.0117647)
            wait(4)
            talk("You just don't wanna be taken advantage of huh?", 0.72549, 0, 0.0117647)
            wait(5)
            talk("How about I trade this with you?", 0.72549, 0, 0.0117647)
            local A_2 = 
                {
                    [1] = getrenv()._G.Pass,
                    [2] = "Overwrite", 
                    [3] = "Summon"
                }
            local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            Event:InvokeServer(A_2)
            wait(4)
            talk("DEALED.", 1, 0, 0.0156863)
            local A_3 = 
                {
                    [1] = getrenv()._G.Pass,
                    [2] = "Overwrite", 
                    [3] = "UnSummon"
                }
            local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            Event:InvokeServer(A_3)
            wait(1)
            local args3 = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 10,
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "SpearJusticeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(25, 75, 25),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 35
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args3))
        elseif input == bind3 and _G.Underplayer == true then
            local args = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 25,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "KnifeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 0
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            talk("I'm not just human...", 0.72549, 0, 0.0117647)
            wait(3)
            talk("I copied codes from other characters too. Like sans, flowey, and a few others.", 0.72549, 0, 0.0117647)
            wait(5)
            talk("Watch.", 0.72549, 0, 0.0117647)
            wait(1)
            local A_1 = 
                {
                    [1] = getrenv()._G.Pass, 
                    [2] = "CrossBlaster"
                }
            local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            local A_2 = 
                {
                    [1] = getrenv()._G.Pass, 
                    [2] = "Overwrite", 
                    [3] = "OverwriteKnives", 
                    [4] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
                }
            local Event1 = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            Event1:InvokeServer(A_2)
            Event:InvokeServer(A_1)
        elseif input == bind1 and _G.Underplayer == true then
            local args = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 25,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "KnifeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 0
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            talk("As you once said in a timeline... I'm just a dirty hacker.", 1, 0, 0.0156863)
            wait(5)
            local args2 = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 5,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "CrossLineBones",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 10
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            Anim.AnimationId = "rbxassetid://5079313442"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            Anim.AnimationId = "rbxassetid://5079319635"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            Anim.AnimationId = "rbxassetid://5079313442"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            Anim.AnimationId = "rbxassetid://5079319635"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            Anim.AnimationId = "rbxassetid://5079313442"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            Anim.AnimationId = "rbxassetid://5079319635"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            wait(0.5)
            Anim.AnimationId = "rbxassetid://5079333382"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(0.5)
            local args3 = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 3,
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "SpearJusticeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 500, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 35
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args3))
        elseif input == bind2 and _G.Underplayer == true then
            talk("Lets lower those stats a bit.", 0.72549, 0, 0.0117647)
            wait(2)
            local A_1 = 
                {
                    [1] = getrenv()._G.Pass, 
                    [2] = "Overwrite", 
                    [3] = "LowerAttack", 
                    [4] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
                }
            local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            Event:InvokeServer(A_1)
        elseif input == bind4 and _G.Underplayer == true then
            talk("Friendliness pellets!", 1, 0.835294, 0)
            local A_1 = 
                {
                    [1] = getrenv()._G.Pass, 
                    [2] = "Overwrite", 
                    [3] = "Heal"
                }
            local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
            Event:InvokeServer(A_1)
        elseif input == bind7 and _G.Underplayer == true then
            local locked = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
            local lockedplr = workspace[locked.Name]
            local args = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 20,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "KnifeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 0
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            talk("Fine. I'll just have to crash your client.", 0.72549, 0, 0.0117647)
            wait(4)
            local args2 = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 5,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "CrossLineBones",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(0, 0, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 10
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(0.25)
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args2))
            wait(1)
            local args3 = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 10,
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "SpearJusticeExplosion",
                    ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
                    ["Velocity"] = Vector3.new(1000, 1000, 1000),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 35
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args3))
            talk("I've erased all traces of '"..lockedplr.Name.."' from this world line.", 0.72549, 0, 0.0117647)
        elseif input == bind8 and _G.Underplayer == true then
            local locked = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
            local lockedplr = workspace[locked.Name]
            local taunts = 
                    {
                    "So... I see your name is '"..lockedplr.Name.."'.",
                    "Your love is pretty high. You'll have to pay for that.",
                    "Your wondering why my love is so high? I don't really know.",
                    "Man, your a bit rough but doesn't hurt me.",
                    "Lets see... So your attack is "..lockedplr.Data.Attack.Value..". Intresting.",
                    "I see your a "..game.Players[locked.Name].PlayerData.CurrentCharacter.Value..". Nice.",
                    "Your defense is "..lockedplr.Data.Defense.Value..".",
                    "I see your health is at "..lockedplr.Humanoid.Health.."."
                    }
            if lockedplr.Type.Value == "Betty" then
                local BettyTaunts = {
                    "So... I see your name is '"..lockedplr.Name.."'.",
                    "Your love is pretty high. You'll have to pay for that.",
                    "Your wondering why my love is so high? I don't really know.",
                    "Man, your a bit rough but doesn't hurt me.",
                    "Lets see... So your attack is "..lockedplr.Data.Attack.Value..". Intresting.",
                    "I see your a "..game.Players[locked.Name].PlayerData.CurrentCharacter.Value..". Nice.",
                    "Your defense is "..lockedplr.Data.Defense.Value..".",
                    "I see you've taken "..lockedplr.SoulsTaken.Value.." souls.",
                    "I see your health is at "..lockedplr.Humanoid.Health.."."
                    }
                talk(BettyTaunts[math.random(1, #BettyTaunts)], 0.72549, 0, 0.0117647)
            elseif lockedplr.Type.Value == "Frisk" then
                local FriskTaunts = {
                    "So... I see your name is '"..lockedplr.Name.."'.",
                    "Your love is pretty high. You'll have to pay for that.",
                    "Your wondering why my love is so high? I don't really know.",
                    "Man, your a bit rough but doesn't hurt me.",
                    "Lets see... So your attack is "..lockedplr.Data.Attack.Value..". Intresting.",
                    "I see your a "..game.Players[locked.Name].PlayerData.CurrentCharacter.Value..". Nice.",
                    "Your defense is "..lockedplr.Data.Defense.Value..".",
                    "Hm. Your dodge chance is "..lockedplr.DodgeChance.Value.."",
                    "Why do you still try to end this perfect timeline?",
                    "I see your health is at "..lockedplr.Humanoid.Health.."."
                    }
                talk(FriskTaunts[math.random(1, #FriskTaunts)], 0.72549, 0, 0.0117647)
            elseif lockedplr.Type.Value == "XSans" then
                    local XSans = {
                    "So... I see your name is '"..lockedplr.Name.."'.",
                    "Your love is pretty high. You'll have to pay for that.",
                    "Your wondering why my love is so high? I don't really know.",
                    "Man, your a bit rough but doesn't hurt me.",
                    "Lets see... So your attack is "..lockedplr.Data.Attack.Value..". Intresting.",
                    "I see your a "..game.Players[locked.Name].PlayerData.CurrentCharacter.Value..". Nice.",
                    "Your defense is "..lockedplr.Data.Defense.Value..".",
                    "Don't you dare let that human out.",
                    "Give up. Your determination won't last long.",
                    "I see your health is at "..lockedplr.Humanoid.Health.."."
                    }
                talk(XSans[math.random(1, #XSans)], 0.72549, 0, 0.0117647)
            elseif lockedplr.Type.Value == "Bunny" then
                    local BunnyTaunt = {
                    "So... I see your name is '"..lockedplr.Name.."'.",
                    "Your love is pretty high. You'll have to pay for that.",
                    "Your wondering why my love is so high? I don't really know.",
                    "Man, your a bit rough but doesn't hurt me.",
                    "Lets see... So your attack is "..lockedplr.Data.Attack.Value..". Intresting.",
                    "I see your a "..game.Players[locked.Name].PlayerData.CurrentCharacter.Value..". Nice.",
                    "Your defense is "..lockedplr.Data.Defense.Value..".",
                    "You aren't apart of any known AU...",
                    "Give up! My determination is stronger than your's!",
                    "I see your health is at "..lockedplr.Humanoid.Health.."."
                    }
                talk(BunnyTaunt[math.random(1, #BunnyTaunt)], 0.72549, 0, 0.0117647)
            elseif lockedplr.Type.Value == "Sans" then
                    local SansTaunt = {
                    "So... I see your name is '"..lockedplr.Name.."'.",
                    "Your love is pretty high. You'll have to pay for that.",
                    "Your wondering why my love is so high? I don't really know.",
                    "Man, your a bit rough but doesn't hurt me.",
                    "Lets see... So your attack is "..lockedplr.Data.Attack.Value..". Intresting.",
                    "I see your a "..game.Players[locked.Name].PlayerData.CurrentCharacter.Value..". Nice.",
                    "Your defense is "..lockedplr.Data.Defense.Value..".",
                    "Oh sans, I could bring you the perfect timeline if you'd stop attacking.",
                    "Sans, i'm not the human your looking for.",
                    "I see your health is at "..lockedplr.Humanoid.Health.."."
                    }
                talk(SansTaunt[math.random(1, #SansTaunt)], 0.72549, 0, 0.0117647)
            elseif lockedplr.Type.Value == "GTFrisk" then
                    local FriskTaunt = {
                    "So... I see your name is '"..lockedplr.Name.."'.",
                    "Your love is pretty high. You'll have to pay for that.",
                    "Your wondering why my love is so high? I don't really know.",
                    "Man, your a bit rough but doesn't hurt me.",
                    "Lets see... So your attack is "..lockedplr.Data.Attack.Value..". Intresting.",
                    "I see your a "..game.Players[locked.Name].PlayerData.CurrentCharacter.Value..". Nice.",
                    "Your defense is "..lockedplr.Data.Defense.Value..".",
                    "Your just glitching your timeline even more.",
                    "I've been looking forward to meeting you.",
                    "I see your health is at "..lockedplr.Humanoid.Health.."."
                    }
                talk(FriskTaunt[math.random(1, #FriskTaunt)], 0.72549, 0, 0.0117647)
            end
            talk(taunts[math.random(1, #taunts)], 0.72549, 0, 0.0117647)
        end
    end)
elseif _G.Underplayer == false or _G.Underplayer == nil then
    print("LOL THE SCRIPT IS OFF STUPID USE _G.Undeplayer = true TO MAKE IT WORK 5 IQ BEING")
end
end)
   
   
section8:addButton("Disbelief Papyrus Phase 2", function()
    local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local mouse = player:GetMouse()


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://3201766456"

mouse.KeyDown:connect(function(key)
	if key == "z" then
		local playAnim = humanoid:LoadAnimation(anim)
		playAnim:Play()
		wait(3)
		playAnim:Stop()

	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "so", 
					[4] = Color3.new(1, 0, 0)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 10, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "Ill teach you a lesson you wont forget", 
					[4] = Color3.new(1, 0, 0)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 15, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 20, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 5, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 13, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)
local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local mouse = player:GetMouse()


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://3207868272"

mouse.KeyDown:connect(function(key)
	if key == "x" then
		local playAnim = humanoid:LoadAnimation(anim)
		playAnim:Play()
		wait(3)
		playAnim:Stop()

	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "x" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "Nyeh Heh heh", 
					[4] = Color3.new(1, 1, 1)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.InGround, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)
local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local mouse = player:GetMouse()


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://4062755689"

mouse.KeyDown:connect(function(key)
	if key == "c" then
		local playAnim = humanoid:LoadAnimation(anim)
		playAnim:Play()
		wait(3)
		playAnim:Stop()

	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "c" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			wait(0.1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Chatted", 
					[3] = "You need someone to teach you good manners", 
					[4] = Color3.new(1, 1, 1)
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Events
			Event:FireServer(A_1)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "IntHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.InGround, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
				local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			local A_1 = getrenv()._G.Pass
			local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			local A_3 = 
				{	
					["HitTime"] = 2, 
					["Type"] = "Normal", 
					["HitEffect"] = "YellowHitEffect",
					["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
					["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
					["Damage"] = 10
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)
AnimationId = '0'
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
bind = "v" -- has to be lowercase


mouse.KeyDown:connect(function(key)
if key == bind then
game.Players:Chat[[This is a lesson!]]


local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "KnifeHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
game.Players:Chat[[GIVE ME SANS BACK!!!!!]]
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "SpearJusticeExplosion",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
game.Players:Chat[[JUST GIVE ME HIM BACK!]]
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "ConstantExplosions",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4820768545"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "HateExplosion",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
			end
end)
end)
section7:addButton("Undyne the True Hero", function()
	--Spawner
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "Undyne"

--Music
for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
	v:Destroy()
end
local music = Instance.new("Sound",game.Players.LocalPlayer:WaitForChild("StarterPlaylist"))
music.Volume = 0.7
music.SoundId = "rbxassetid://3143843068"
music.Looped = true
music:Play()

--hold spear
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "t" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local args = {
				[1] = {
					[1] = getrenv()._G.Pass,
					[2] = "SpawnWeapon",
					[3] = true
				}
			}

			game:GetService("ReplicatedStorage").Remotes.UndyneMoves:InvokeServer(unpack(args))

			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)

--remove spear
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "y" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local args = {
				[1] = {
					[1] = getrenv()._G.Pass,
					[2] = "SpawnWeapon",
					[3] = false
				}
			}

			game:GetService("ReplicatedStorage").Remotes.UndyneMoves:InvokeServer(unpack(args))

			local Event = game:GetService("ReplicatedStorage").Remotes.Damage
			Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(1)
			db = true
		end
	end
end)

--attacks

--undyne z
	local player = game.Players.LocalPlayer
		repeat wait() until player.Character.Humanoid
		local humanoid = player.Character.Humanoid
		local mouse = player:GetMouse()
	
	
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://3201766456"
	
		mouse.KeyDown:connect(function(key)
			if key == "z" then
				local playAnim = humanoid:LoadAnimation(anim)
				playAnim:Play()
				wait(3)
				playAnim:Stop()
	
			end
		end)
	
		local m = game.Players.LocalPlayer:GetMouse()
		db = true
		m.keyDown:connect(function(k)
			k = k:lower()
			if k == "z" then
				if db == true then
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "PinkWind",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					wait(0.1)
					local A_1 = 
						{
							[1] = getrenv()._G.Pass, 
							[2] = "Chatted", 
							[3] = "You will have to try a little harder to beat me", 
							[4] = Color3.new(1, 0, 0)
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Events
					Event:FireServer(A_1)
					wait(0.1)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "SpearJusticeExplosion",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Events
					Event:FireServer(A_1)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
					{
					    ["HitTime"] = 0.5, 
					    ["Type"] = "Knockback", 
					    ["HitEffect"] = "UndyingExplosion", 
					    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
					    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback,
					    ["Velocity"] = Vector3.new(100, 100, 100), 
					    ["Damage"] = 10
					}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					db = false
					wait(8)
					db = true
				end
			end
			end)


--Special
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "g" then
		if db == true then
			local A_1 = getrenv()._G.Pass
			local args = {
				[1] = {
					[1] = getrenv()._G.Pass,
					[2] = "Spear",
					[3] = "Special"
				}
			}

			game:GetService("ReplicatedStorage").Remotes.UndyneMoves:InvokeServer(unpack(args))
			db = false
			wait(1)
			db = true
		end
	end
end)

--xmove 
	local player = game.Players.LocalPlayer
		repeat wait() until player.Character.Humanoid
		local humanoid = player.Character.Humanoid
		local mouse = player:GetMouse()
	
	
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://4064062039"
	
		mouse.KeyDown:connect(function(key)
			if key == "x" then
				local playAnim = humanoid:LoadAnimation(anim)
				playAnim:Play()
				wait(3)
				playAnim:Stop()
	
			end
		end)
	
		local m = game.Players.LocalPlayer:GetMouse()
		db = true
		m.keyDown:connect(function(k)
			k = k:lower()
			if k == "x" then
				if db == true then
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
					{
					    ["HitTime"] = 0.5, 
					    ["Type"] = "Knockback", 
					    ["HitEffect"] = "UndyingExplosion", 
					    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
					    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback,
					    ["Velocity"] = Vector3.new(100, 100, 100), 
					    ["Damage"] = 10
					}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					db = false
					wait(1)
					db = true
				end
			end
			end)
			
--cmove
	local player = game.Players.LocalPlayer
		repeat wait() until player.Character.Humanoid
		local humanoid = player.Character.Humanoid
		local mouse = player:GetMouse()
	
	
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://3207868272"
	
		mouse.KeyDown:connect(function(key)
			if key == "c" then
				local playAnim = humanoid:LoadAnimation(anim)
				playAnim:Play()
				wait(3)
				playAnim:Stop()
	
			end
		end)
	
		local m = game.Players.LocalPlayer:GetMouse()
		db = true
		m.keyDown:connect(function(k)
			k = k:lower()
			if k == "c" then
				if db == true then
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
						{
							["HitTime"] = 0.5, 
							["Type"] = "Normal", 
							["HitEffect"] = "LightHitEffect2",  
							["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.SpGrab, 
							["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
							["Damage"] = 10
						}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					local A_1 = getrenv()._G.Pass
					local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
					local A_3 = 
					{
					    ["HitTime"] = 0.5, 
					    ["Type"] = "Knockback", 
					    ["HitEffect"] = "UndyingExplosion", 
					    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
					    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback,
					    ["Velocity"] = Vector3.new(100, 100, 100), 
					    ["Damage"] = 10
					}
					local Event = game:GetService("ReplicatedStorage").Remotes.Damage
					Event:InvokeServer(A_1, A_2, A_3)
					db = false
					wait(1)
					db = true
				end
			end
			end)
end)

section7:addButton("Cat Lover But Better (P To Spawn)", function()


local pass = getrenv()._G.Pass
print("Script Made By antiiiic ")
print("Press P To spawn")
function sound(mustype)
	local music = mustype
	local target = game.Players.LocalPlayer.Character
	local musicname = music.Name
	local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "PlaySound", 
	[3] = music
}
local Event = game:GetService("ReplicatedStorage").Remotes.Functions
Event:InvokeServer(A_1)
	local a = music:Clone()
	a.Name = "LocalPlayingMusic"
	a.Parent = target.Head
	a:Play()
end


function stun(stuntime)
local a = Instance.new("StringValue",game.Players.LocalPlayer.Character)
a.Name = "Hit"
game.Debris:AddItem(a,stuntime)
end
function unstun()
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.Name == "Hit" and v.ClassName == "StringValue" then
v:Destroy()
end
end
end

function talk(text,color)
if dead == true then return end
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "Chatted", 
	[3] = text, 
	[4] = color
}
local Event
if game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Eventa") then
Event = game:GetService("ReplicatedStorage").Remotes.Eventa
else
Event = game:GetService("ReplicatedStorage").Remotes.Events
end
Event:FireServer(A_1)
end
local talkvoice = "6"
local godmode = false
local dead = false
local runningscript = false
local clonedname

spawn(function()
while game:GetService("RunService").Stepped:Wait() do
if godmode == true then
spawn(function()
local A_1 = 
    {
        [1] = pass, 
        [2] = "InvFrames", 
        [3] = 4
    }
local Event
if game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Eventa") then
Event = game:GetService("ReplicatedStorage").Remotes.Eventa
else
Event = game:GetService("ReplicatedStorage").Remotes.Events
end
Event:FireServer(A_1)
end)
end
end
end)

local CAS = game:GetService("ContextActionService")
local FREEZE_COMMAND  = "CantAttack"
CAS:BindActionAtPriority(
    FREEZE_COMMAND,
    function() 
        return Enum.ContextActionResult.Sink
    end,
    false,
    Enum.ContextActionPriority.High.Value,
    Enum.KeyCode.R,
    Enum.KeyCode.E,
    Enum.KeyCode.Q,
    Enum.KeyCode.One,
    Enum.KeyCode.Two,
    Enum.KeyCode.Three,
    Enum.KeyCode.Four,
    Enum.KeyCode.Five,
    Enum.KeyCode.Six,
    Enum.KeyCode.Seven,
    Enum.KeyCode.Eight,
    Enum.KeyCode.Nine,
    Enum.KeyCode.Zero
    )
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "p" then
spawn(function()
game.Players.LocalPlayer.CharacterAdded:Connect(function()
local head = game.Players.LocalPlayer.Character:WaitForChild("Head")
head.DescendantAdded:Connect(function(a)
if a.Name == "PName" then
clonedname = a:Clone()
a.Name = "crash bypass"
for i = 1,10 do
pcall(function()
if runningscript == false then
a:Destroy()
end
end)
wait()
end
end
end)
end)
end)
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("CharacterSelection") then
game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "SFChara"
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
end
local safrhsutgsdsfis = game.Players.LocalPlayer.PlayerGui:WaitForChild("UI")
wait(3)

		local Player = game.Players.LocalPlayer
		local Backpack = Player.Backpack
		Player.Character.RealKnife2:Remove()
		Player.Character.Scarf:Remove()
for i,v in pairs(game.Players.LocalPlayer:WaitForChild("StarterPlaylist"):GetChildren()) do
v:Destroy()
end
local music = Instance.new("Sound",game.Players.LocalPlayer:WaitForChild("StarterPlaylist"))
music.Volume = 0.7
music.SoundId = "rbxassetid://6328493051 "
music.Looped = true
music:Play()
runningscript = true
wait()
clonedname.Parent = game.Players.LocalPlayer.Character.Head.HealthBar.Frame
spawn(function()
while wait() do
game.Players.LocalPlayer.Character.Head.HealthBar.Frame["crash bypass"].Text = "Cat Lover 100000"
end                                                                                  
end)
game.Players.LocalPlayer.PlayerGui.UI.Ui.ManaBar.Bar.BackgroundColor3 = Color3.new(0,255,255)
game.Players.LocalPlayer.PlayerGui.UI.Ui.StaminaBar.Bar.BackgroundColor3 = Color3.new(0,255,255)
game.Players.LocalPlayer.PlayerGui.UI.Ui.Info.Attack.TextColor3 = Color3.new(0,255,255)
game.Players.LocalPlayer.PlayerGui.UI.Ui.Info.Defense.TextColor3 = Color3.new(0,255,255)
game.Players.LocalPlayer.Character.Head.HealthBar.Frame.HP.TextColor3 = Color3.new(0,255,255)
game.Players.LocalPlayer.Character.Head.HealthBar.Frame.HealthLabel.TextColor3 = Color3.new(0,255,255)
game.Players.LocalPlayer.PlayerGui.UI.Ui.Info.ServerInfo:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.Info.ServerInfo2:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.StaminaBar.ImageLabel:Destroy()
game:getService("RunService"):BindToRenderStep("",0,function()
if game.ReplicatedStorage.Remotes:FindFirstChild("Eventa") then
local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "InvFrames",
        [3] = 2
    }
}
game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args))
end
end)

game:getService("RunService"):BindToRenderStep("",0,function()
if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("DeathParticle") then
game.workspace.lbmusicok:Stop()
dead = true
CAS:UnbindAction(FREEZE_COMMAND)
warn("death.")
end
end)

local pass = getrenv()._G.Pass

if not game.Players.LocalPlayer:FindFirstChild("modded sans") then
game.Players.LocalPlayer.Character.Dodge:Clone().Parent = game.Players.LocalPlayer
game.Players.LocalPlayer.Dodge.Name = "modded sans"
end

if not game.Players.LocalPlayer:FindFirstChild("yes sus") then
if game.Players.LocalPlayer.Character:FindFirstChild("Dodge") then
game.Players.LocalPlayer.Character.Dodge:Clone().Parent = game.Players.LocalPlayer
game.Players.LocalPlayer.Dodge.Name = "yes sus"
else
local e = Instance.new("BoolValue",game.Players.LocalPlayer)
e.Name = "yes sus"
end
end

if not game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
game.Players.LocalPlayer.Backpack.Main:Clone().Parent = game.Players.LocalPlayer["modded sans"]
end

if game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
for i, v in pairs(game:GetService("Players").LocalPlayer["modded sans"]:GetChildren()) do
v.Parent = game.Players.LocalPlayer["yes sus"]
end
end

if not game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
if game.Players.LocalPlayer["yes sus"]:FindFirstChild("Main") then
game.Players.LocalPlayer["yes sus"].Main.Parent = game:GetService("Players").LocalPlayer["modded sans"]
end
end

if game.Players.LocalPlayer:FindFirstChild("StarterPlaylist") then
if game.Players.LocalPlayer.StarterPlaylist:FindFirstChild("1Megalovania") then
game.Players.LocalPlayer.StarterPlaylist["1Megalovania"]:Destroy()
end
end

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Idle:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Walk:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Run:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Fall:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Jump:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Block:Destroy()

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat.Light1:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat.Light2:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat.Light3:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat.Light4:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat.Light5:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat.Light6:Destroy()

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat)
Anim.Name = "Light1"
Anim.AnimationId = "rbxassetid://4929661098 "

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat)
Anim.Name = "Light2"
Anim.AnimationId = "rbxassetid://4929665831 "

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat)
Anim.Name = "Light3"
Anim.AnimationId = "rbxassetid://4929661098 "

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat)
Anim.Name = "Light4"
Anim.AnimationId = "rbxassetid://4929665831 "

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat)
Anim.Name = "Light5"
Anim.AnimationId = "rbxassetid://3918680404"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.ModuleScript.Animations.BladesCombat)
Anim.Name = "Light6"
Anim.AnimationId = "rbxassetid://5079852240"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Animation.Name = "Idle"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Idle.AnimationId = "rbxassetid://4900761581"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Animation.Name = "Walk"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Walk.AnimationId = "rbxassetid://4370512420"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Animation.Name = "Run"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Run.AnimationId = "rbxassetid://4576074471"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Animation.Name = "Fall"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Fall.AnimationId = "rbxassetid://5111359205"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Animation.Name = "Jump"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Jump.AnimationId = "rbxassetid://3198665507"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Animation.Name = "Block"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Animations.Block.AnimationId = "rbxassetid://5657245133"

game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Parent = game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra
game.Players.LocalPlayer.PlayerGui.CharaIndicator.Parent = game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra

for i,v in pairs(game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.CharaIndicator:GetChildren()) do
v:Destroy()
end

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["1"].TextLabel.Text = "Z"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["1"].Time.Value = 10

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["2"].TextLabel.Text = "X"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["2"].Time.Value = 5

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["3"].TextLabel.Text = "C"
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["3"].Time.Value = 5

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["4"].TextLabel.Text = "V"

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["5"].TextLabel.Text = "B"

game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["3"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["4"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["5"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SFCharaMoves.Extra.MoveDebounceShower.Moves1["6"]:Destroy()

game.Players.LocalPlayer.Backpack.Main:Destroy()

local AnimationTracks = game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()
for i, track in pairs (AnimationTracks) do
	track:Stop()
end
game.Players.LocalPlayer["modded sans"].Main:Clone().Parent = game.Players.LocalPlayer.Backpack
game.Players.LocalPlayer.Character.Head.ChildAdded:Connect(function(c)
if c.Name == "TextBar" then
if game.Players.LocalPlayer.Character.Head:FindFirstChild("Voice") then
game.Players.LocalPlayer.Character.Head:FindFirstChild("Voice"):Destroy()
end
c.TextLabel.Changed:Connect(function(prop)
if c.TextLabel.Text == "*" then return end
if prop == "Text" then
local snd = game.ReplicatedStorage.Resources.Character.Voices["Voice8"]
spawn(function()
	local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "PlaySound", 
	[3] = snd
}
local Event = game:GetService("ReplicatedStorage").Remotes.Functions
Event:InvokeServer(A_1)
	local a = snd:Clone()
	game.Debris:AddItem(a,1)
	a.Name = "LocalPlayingMusic"
	a.Parent = game.Players.LocalPlayer.Character.Head
	a:Play()
end)
end
end)
end
end)

local ts = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")

local char = player.Character
local hum = char:WaitForChild("Humanoid")
local hrp = hum.RootPart

local playing, completed = Enum.PlaybackState.Playing, Enum.PlaybackState.Completed
local style, dir = Enum.EasingStyle.Sine, Enum.EasingDirection.InOut

local sin = Instance.new("NumberValue") --remember, the NumberValue; it will act as the "time" for our curve
local isSprinting = Instance.new("BoolValue") --aah, finally it came in use

local dur, durSprint = 0.3, 0.3 
local ti, tiSprint = TweenInfo.new(dur, style, dir, 0, true), TweenInfo.new(durSprint, style, dir, 0, true)
local oneTween, oneSprintTween = ts:Create(sin, ti, {Value = 0.6}), ts:Create(sin, tiSprint, {Value = 0.6})


local offset, maxRandomBounds = 0.8, 0.8


local point0, point2 = Vector3.new(offset, 0, 0), Vector3.new(-offset, 0, 0) 


local point1 = Vector3.new(0, -offset, 0)
local ti2 = TweenInfo.new(dur / 1.6, style, dir)
local tweenBack = ts:Create(hum, ti2, {CameraOffset = Vector3.new(0, 0, 0)})


local begTween = ts:Create(hum, ti2, {CameraOffset = point0}) 


local counter, counterInc = 1, 0.1
local running = false

local function curve(t, p0, p1, p2)
	
   
	if t == 0 then return p0 elseif t == 1 then return p2 end
	return (((1 - t)^2) * p0) + (2 * (1 - t) * t * p1) + (t^2 * p2)

end

local function sprint()
	
    --just make sure the tween's not playing so we don't interrupt it
	if oneTween.PlaybackState ~= playing and isSprinting.Value == false then 
			
		oneTween:Play() 
				
	end
			
	if oneSprintTween.PlaybackState ~= playing and isSprinting.Value == true then
			
        
		oneSprintTween:Play() 
				
	end
	
end
game:GetService("RunService").RenderStepped:Connect(function(deltaTime)	
		


	if hum.MoveDirection:Dot(hum.MoveDirection) > 0 then
	
      
		if (not running) then begTween:Play() running = true end


		if begTween.PlaybackState == completed then 	if sin.Value == 0 then
				
				counter = counter + counterInc 
               
				point1 = Vector3.new(math.clamp(math.noise(counter), -maxRandomBounds, maxRandomBounds), -offset, 0)
				
               
				local coro = coroutine.wrap(sprint) 
				coro()
				
			end

		
			hum.CameraOffset = curve(sin.Value, point0, point1, point2)
				
		end
			
	else 
					
		tweenBack:Play() 
		oneTween:Cancel() 
		oneSprintTween:Cancel()
		sin.Value = 0
		running = false 
			
	end
			
end)

for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
			v.Name="Noob"..i
		end
		local personpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
		local playerName = game.Players.LocalPlayer.Name
		local Waiter = false
		local player = game.Players.LocalPlayer
		local uis = game:GetService("UserInputService")
		local damage = game.ReplicatedStorage.Remotes.Damage
		local Players = game.Players
		local LocalPlayer = Players.LocalPlayer;
		local u2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
		local HumanoidRootPart = u2:WaitForChild("HumanoidRootPart");
		local player = game.Players.LocalPlayer
		local character = player.Character
		local remote = game.ReplicatedStorage.Remotes.Functions
		local pass = getrenv()._G.Pass
		local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
		local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]
		local ClientMusicVariable = true
		local remot = game:GetService("ReplicatedStorage").Remotes.Functions
		local LeftCombo = 0
		local TimeToAttack = .9
		local Delayy = .25
		local LastComboCD = 2.2
		local Cooldown = false
		local remote = game.ReplicatedStorage.Remotes.Damage
		local UserId = game.Players.LocalPlayer.UserId
		local FaceLessMoves = Instance.new("BindableEvent") or game.Players[game.Players.LocalPlayer.Name].Backpack:FindFirstChild("RemoteFolder")[UserId]

		FaceLessMoves.Name = 'FaceLessMoves'

		if not(game.Players[game.Players.LocalPlayer.Name].Backpack:FindFirstChild("RemoteFolder"))then 
			local NewRemoteFolder = Instance.new("Folder")
			NewRemoteFolder.Name = "RemoteFolder"
			NewRemoteFolder.Parent = game.Players[game.Players.LocalPlayer.Name].Backpack
			FaceLessMoves.Parent = NewRemoteFolder
		end


		FaceLessMoves.Event:Connect(function()
			local gettem = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
			tostring(gettem)
			local epic = game.Workspace[tostring(gettem)]
			local target = epic.Torso.Position
			LeftCombo = LeftCombo + 1
			print(tostring(LeftCombo))
end)

game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(function()
if dead == false then
local A_1 = 
{
	[1] = pass, 
	[2] = "ChangeSetting", 
	[3] = "DeathScene", 
	[4] = false
}
local Event = game:GetService("ReplicatedStorage").Remotes.Functions
Event:InvokeServer(A_1)
end
end)
end
end)
function firstattack()
local cdshow = game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves1["1"]
local attackedplayer = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
stun(math.huge)
cdshow.Start.Value = true
local lasthumposition = game.Players.LocalPlayer.Character.Torso.Position
local successfullhit = false
attackedplayer.ChildAdded:Connect(function(j)
if successfullhit == true then return end
if j.Name == "Hit" and j.Value == game.Players.LocalPlayer.Name then
if attackedplayer:FindFirstChild("Dodge") and attackedplayer.Data.Mana.Value ~= 0 then

else
successfullhit = true
end
end
end)
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5770352035"
local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
track.Looped = false
track:Play()
local pass = getrenv()._G.Pass
local A_1 = pass
local A_2 = attackedplayer
local A_3 = 
    {
        ["Type"] = "Knockback", 
        ["HitEffect"] = nil, 
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.001, 
        ["CameraShake"] = "Bump", 
        ["HitTime"] = 3, 
        ["CombatInv"] = true,
        ["VictimCFrame"] = nil, 
        ["Sound"] = nil, 
        ["Damage"] = 10
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
wait(0.3)
if successfullhit == false then 
unstun()
cdshow.Start.Value = false
cdshow.Activated.Value = true
wait()
cdshow.Activated.Value = false
return 
end
wait(.5)
sound(game.ReplicatedStorage.RogueSounds.EnergyDash)
local bv = Instance.new("BodyVelocity",game.Players.LocalPlayer.Character.Torso)
bv.MaxForce = Vector3.new(1,1,1) * math.huge
bv.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 1
for i = 1,10 do
spawn(function()
local randomhit = math.random(1,3)
local anim = Instance.new("Animation")
if randomhit == 1 then
anim.AnimationId = "rbxassetid://4820768545"
elseif randomhit == 2 then
anim.AnimationId = "rbxassetid://4820768545"
elseif randomhit == 3 then
anim.AnimationId = "rbxassetid://4820768545"
end
local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
track.Looped = false
track:Play()
sound(game.ReplicatedStorage.RogueSounds.DaggerHit)
local A_1 = pass
local A_2 = attackedplayer
local A_3 = 
    {
        ["Type"] = "Normal", 
        ["HitEffect"] = "IntHitEffect", 
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations["Hurt"..randomhit], 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 1, 
        ["CameraShake"] = "Bump", 
        ["HitTime"] = 3, 
        ["CombatInv"] = true,
        ["VictimCFrame"] = nil, 
        ["Sound"] = nil, 
        ["Damage"] = 10
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end)
wait(0.3)
end
wait(0.3)
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5667210178"
local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
track.Looped = false
track:Play(0.5,1,0.2)
wait(0.4)
spawn(function()
local A_1 = pass
local A_2 = attackedplayer
local A_3 = 
    {
        ["Type"] = "Knockback", 
        ["HitEffect"] = nil, 
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
        ["CameraShake"] = "Bump", 
        ["HitTime"] = 1, 
        ["CombatInv"] = true,
        ["VictimCFrame"] = nil, 
        ["Sound"] = nil, 
        ["Damage"] = 30
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
sound(game.ReplicatedStorage.Sounds.Knockback)
end)
wait(1.5)
unstun()
bv:Destroy()
cdshow.Start.Value = false
cdshow.Activated.Value = true
wait()
cdshow.Activated.Value = false
end


function secondattack()
local cdshow = game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves1["2"]
local attackedplayer = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
stun(math.huge)
cdshow.Start.Value = true
sound(game.ReplicatedStorage.RogueSounds.EnergyDash)
local bv = Instance.new("BodyVelocity",game.Players.LocalPlayer.Character.Torso)
bv.MaxForce = Vector3.new(1,1,1) * math.huge
bv.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 0
for i = 1,10 do
spawn(function()
local randomhit = math.random(1,3)
local anim = Instance.new("Animation")
if randomhit == 1 then
anim.AnimationId = "rbxassetid://5667210178"
elseif randomhit == 2 then
anim.AnimationId = "rbxassetid://5667210178"
elseif randomhit == 3 then
anim.AnimationId = "rbxassetid://5667210178"
end
local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
track.Looped = false
track:Play()
track:Play()
local pass = getrenv()._G.Pass
local A_1 = pass
local A_2 = attackedplayer
local A_3 = 
    {
        ["Type"] = "Knockback", 
        ["HitEffect"] = nil, 
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.001, 
        ["CameraShake"] = "Bump", 
        ["HitTime"] = 3, 
        ["CombatInv"] = true,
        ["VictimCFrame"] = nil, 
        ["Sound"] = nil, 
        ["Damage"] = 10
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end)
wait(0.3)
end
wait(0.3)
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5667210178"
local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
track.Looped = false
track:Play(0.5,1,0.2)
wait(0.4)
spawn(function()
local A_1 = pass
local A_2 = attackedplayer
local A_3 = 
    {
        ["Type"] = "Knockback", 
        ["HitEffect"] = nil, 
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
        ["CameraShake"] = "Bump", 
        ["HitTime"] = 1, 
        ["CombatInv"] = true,
        ["VictimCFrame"] = nil, 
        ["Sound"] = nil, 
        ["Damage"] = 30
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
sound(game.ReplicatedStorage.Sounds.Knockback)
end)
wait(1.5)
unstun()
bv:Destroy()
cdshow.Start.Value = false
cdshow.Activated.Value = true
wait()
cdshow.Activated.Value = false
wait(1)
if successfullhit == false then 
unstun()
cdshow.Start.Value = false
cdshow.Activated.Value = true
wait()
cdshow.Activated.Value = false
return 
end

wait(0.15)
end
wait(1.5)
repeat 
wait()
until game.Players.LocalPlayer.Character ~= nil
mouse.KeyDown:Connect(function(k)
if dead == true then return end
if game.Players.LocalPlayer.Character:FindFirstChild("Hit") then return end
if k == "z" then
if game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves1["1"].TextLabel.TextColor3 == Color3.new(0,255,255) then return end
if game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value == nil then return end
firstattack()
elseif k == "x" then
if game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves1["2"].TextLabel.TextColor3 == Color3.new(0,255,255) then return end
if game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value == nil then return end
secondattack()
end
end)


section8:addButton("Better X Gaster", function()
 local plr = game.Players.LocalPlayer.Name
game.Workspace:WaitForChild(plr)
 local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5101233182"

local playAnim = humanoid:LoadAnimation(anim)
function button()
playAnim:Play()
end


 local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5101202405"

local playAnim = humanoid:LoadAnimation(anim)
function HandOut()
playAnim:Play()
end
function HandStop()
playAnim:Stop()
end

game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Chat")
wait(2)
game.Players.LocalPlayer.Character.Head.Voice:Destroy()
game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.BackgroundColor3 = Color3.new(0.8, 0, 1)
game.Players.LocalPlayer:WaitForChild("StarterPlaylist")
game.Players.LocalPlayer.StarterPlaylist["1Theme"]:Destroy()
local Sound = Instance.new("Sound")
Sound.Parent = game.Players.LocalPlayer.StarterPlaylist
Sound.Volume = 2
Sound.Playing = true
Sound.Looped = true
Sound.SoundId = "rbxassetid://5126469548"
Sound.Name = "1XGaster"
game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Run.AnimationId = "rbxassetid://5941660121"
game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Idle.AnimationId = "rbxassetid://4684237024"
game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Walk.AnimationId = "rbxassetid://4684281026"
HandOut()
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
local Sound = Instance.new("Sound")
Sound.Parent = game.Players.LocalPlayer.Character.Head
Sound.Volume = 5
Sound.Playing = false
Sound.Looped = false
Sound.SoundId = "rbxassetid://4459132147"
Sound.Name = "Voice"
Sound.PlaybackSpeed = 0.7
wait(0.5)
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "Chatted", 
	[3] = "Ugh...", 
	[4] = Color3.new(1, 0, 0)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
wait(1.5)
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "Chatted", 
	[3] = "Finally.", 
	[4] = Color3.new(1, 0, 0)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
wait(1.5)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "UnSummon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
HandStop()
local player = game.Players.LocalPlayer

local g = game.Players.LocalPlayer.Character
g.CrossBone:Destroy()
g.CrossBone2:Destroy()
player.Chatted:connect(function(msg)
game.Players.LocalPlayer.Character.Head:WaitForChild("TextBar")
game.Players.LocalPlayer.Character.Head.TextBar.TextLabel.Changed:connect(function()
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "PlaySound", 
	[3] = game:GetService("ReplicatedStorage").Resources.Character.Voices.Voice6,
}
local Event = game:GetService("ReplicatedStorage").Remotes.Functions
Event:InvokeServer(A_1)
wait(0.2)
end)
end)

game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Run2.AnimationId = "rbxassetid://5941660121"
game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Idle2.AnimationId = "rbxassetid://4684237024"
game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Walk2.AnimationId = "rbxassetid://4684281026"

local uis=game:GetService("UserInputService");
uis.InputBegan:connect(function(input)
    if input.KeyCode==Enum.KeyCode.E then
        print("Funny Overwrite");
game.Players.LocalPlayer.Character.Head:WaitForChild("TextBar")
local A_1 = 
{
    [1] = getrenv()._G.Pass, 
    [2] = "Chatted", 
    [3] = "ACT = [OVERWRITE]", 
    [4] = Color3.new(0.8, 0, 1)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
game.Players.LocalPlayer.Character:WaitForChild("XSansKnifeSummon")
game.Players.LocalPlayer.Character.XSansKnifeSummon:Destroy()
game.Players.LocalPlayer.Character:WaitForChild("CrossSansBlade")
game.Players.LocalPlayer.Character.CrossSansBlade:Destroy()
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
local b = game.Players.LocalPlayer.Character.OverwriteButton.OverwriteButton
b.Sound.Volume = 10
b.PlaybackSpeed = 0.5
HandOut()
    end
end)

 
uis.InputEnded:connect(function(input)
    if input.KeyCode==Enum.KeyCode.E then
        print("Returned");
        HandStop()
game.Players.LocalPlayer.Character.OverwriteButton:Destroy()
    end
end)


local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "x" then
		if db == true then
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
wait(0.5)
local A_1 = 
{
    [1] = getrenv()._G.Pass, 
    [2] = "Chatted", 
    [3] = "ACT = [CRASH]", 
    [4] = Color3.new(0.8, 0, 1)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
    ["HitTime"] = 20, 
    ["Type"] = "Knockback", 
    ["HitEffect"] = "KnifeHitEffect", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 100, -100), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "UnSummon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
			db = false
			wait(1)
			db = true
		end
	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "c" then
		if db == true then
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
wait(0.5)
local A_1 = 
{
    [1] = getrenv()._G.Pass, 
    [2] = "Chatted", 
    [3] = "ACT = [CONTROL]", 
    [4] = Color3.new(0.8, 0, 1)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
    ["HitTime"] = 10, 
    ["Type"] = "Normal", 
    ["HitEffect"] = " ", 
    ["HurtAnimation"] = game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Run, 
    ["Velocity"] = Vector3.new(-35, 0, 35), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "UnSummon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
			db = false
			wait(1)
			db = true
		end
	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "b" then
		if db == true then
local A_1 = 
{
    [1] = getrenv()._G.Pass, 
    [2] = "Chatted", 
    [3] = "ACT = [NEW TIMELINE]", 
    [4] = Color3.new(0.8, 0, 1)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
wait(0.5)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
wait(0.5)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "UnSummon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
			db = false
			wait(1)
			db = true
		end
	end
end)

 local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5667194069"
local playAnim = humanoid:LoadAnimation(anim)
function finish()
playAnim:Play()
playAnim:AdjustSpeed(0.5)
end
 local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://4800436094"
local playAnim = humanoid:LoadAnimation(anim)
function mudamuda()
playAnim:Play()
playAnim.TimePosition = 0.5
playAnim:AdjustSpeed(1)
end

function mudastop()
playAnim:Stop()
end
local userInputService = game:GetService("UserInputService")

userInputService.InputBegan:Connect(function(input, isTyping)
    if not isTyping then
        if input.KeyCode == Enum.KeyCode.Y then
            if not pressed then
                pressed = true
local A_1 = 
{
    [1] = getrenv()._G.Pass, 
    [2] = "Chatted", 
    [3] = "ACT = [SHADOW BARRAGE]", 
    [4] = Color3.new(0.8, 0, 1)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
                repeat wait()
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
    ["HitTime"] = 2.5, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "HateHitEffect", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
    ["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
mudamuda()
                until not pressed
            end
        end
    end
end)


userInputService.InputEnded:Connect(function(input, isTyping)
    if not isTyping then
        if input.KeyCode == Enum.KeyCode.Y then
            pressed = false
mudastop()
print("Barrage done")
        end
    end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "m" then
		if db == true then
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
wait(0.5)
local A_1 = 
{
    [1] = getrenv()._G.Pass, 
    [2] = "Chatted", 
    [3] = "ACT = [DANCE]", 
    [4] = Color3.new(0.8, 0, 1)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
    ["HitTime"] = 108.643, 
    ["Type"] = "Normal", 
    ["HitEffect"] = " ", 
    ["HurtAnimation"] = game.Players.LocalPlayer.Backpack.Main.XSansMoves.Animations.Run, 
    ["Velocity"] = Vector3.new(0, 0.1, 0), 
    ["Sound"] = game:GetService("StarterGui").GameOver["Sound2"],
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local Sound = Instance.new("Sound")
Sound.Parent = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Head
Sound.Volume = 0.5
Sound.PlaybackSpeed = 1.5
Sound.Playing = true
Sound.Looped = false
Sound.SoundId = "rbxassetid://305138647"
Sound.Name = "Dance"
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "UnSummon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
			db = false
			wait(1)
			db = true
		end
	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "h" then
		if db == true then
local A_1 = 
{
    [1] = getrenv()._G.Pass, 
    [2] = "Chatted", 
    [3] = "ACT = [BLACK HOLE]", 
    [4] = Color3.new(0.8, 0, 1)
}
local Event = game:GetService("ReplicatedStorage").Remotes.Events
Event:FireServer(A_1)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
wait(0.5)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
{
    ["HitTime"] = 0, 
    ["Type"] = "Normal", 
    ["HitEffect"] = "Arena", 
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
    ["Velocity"] = Vector3.new(0, 0.00001, 0), 
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch, 
    ["Damage"] = 0
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
wait(0.5)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "UnSummon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
			db = false
			wait(1)
			db = true
		end
	end
end)

local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "Summon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
wait(0.6)
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "Overwrite", 
	[3] = "Heal"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
wait(1)
local A_1 = 
{
	[1] = getrenv()._G.Pass,
	[2] = "Overwrite", 
	[3] = "UnSummon"
}
local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
Event:InvokeServer(A_1)
			db = false
			wait(1)
			db = true
		end
	end
end)
end)
end)





section9:addButton("Sans last breath 2.0", function()
    game:getService("RunService"):BindToRenderStep("",0,function()
if game.ReplicatedStorage.Remotes:FindFirstChild("Eventa") then
local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "InvFrames",
        [3] = 2
    }
}
game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args))
end
end)

game:getService("RunService"):BindToRenderStep("",0,function()
if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("DeathParticle") then
game.workspace.lbmusicok:Stop()
end
end)

local sound = Instance.new("Sound", game.Workspace)
sound.Name = "lbmusicok"
game.workspace.lbmusicok.SoundId = "rbxassetid://4686555781"
game.workspace.lbmusicok.Looped = true
game.workspace.lbmusicok.Volume = 2

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "p" then
local pass = getrenv()._G.Pass

if not game.Players.LocalPlayer:FindFirstChild("modded sans") then
game.Players.LocalPlayer.Character.Dodge:Clone().Parent = game.Players.LocalPlayer
game.Players.LocalPlayer.Dodge.Name = "modded sans"
end

if not game.Players.LocalPlayer:FindFirstChild("yes sus") then
game.Players.LocalPlayer.Character.Dodge:Clone().Parent = game.Players.LocalPlayer
game.Players.LocalPlayer.Dodge.Name = "yes sus"
end

if not game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
for i, v in pairs(game:GetService("Players"):GetChildren()) do
if v.Backpack:FindFirstChild("Main") then
if v.Backpack.Main:FindFirstChild("SansMoves") then
if v.Name ~= game.Players.LocalPlayer.Name then
v.Backpack.Main:Clone().Parent = game.Players.LocalPlayer["modded sans"]
end
end
end
end
end

if game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
for i, v in pairs(game:GetService("Players").LocalPlayer["modded sans"]:GetChildren()) do
v.Parent = game.Players.LocalPlayer["yes sus"]
end
end

if not game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
if game.Players.LocalPlayer["yes sus"]:FindFirstChild("Main") then
game.Players.LocalPlayer["yes sus"].Main.Parent = game:GetService("Players").LocalPlayer["modded sans"]
end
end

game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block:Destroy()

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Idle"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle.AnimationId = "rbxassetid://4458837452"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Walk"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk.AnimationId = "rbxassetid://4458849950"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Run"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run.AnimationId = "rbxassetid://4370518984"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Fall"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall.AnimationId = "rbxassetid://5111359205"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Jump"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump.AnimationId = "rbxassetid://3198665507"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Block"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block.AnimationId = "rbxassetid://5973908948"

game.Players.LocalPlayer.PlayerGui.SansIndicator:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower:Destroy()
game.Players.LocalPlayer.Character.Head.HealthBar.Frame.Health:Destroy()
game.Players.LocalPlayer.Character.Head.HealthBar.Frame.StaminaBar.Bar:Destroy()

game.Players.LocalPlayer.Backpack.Main:Destroy()
game.Players.LocalPlayer["modded sans"].Main:Clone().Parent = game.Players.LocalPlayer.Backpack

game:GetService("ReplicatedStorage").Remotes.Events.Name = "Eventa"

if game.Players.LocalPlayer:FindFirstChild("StarterPlaylist") then
if game.Players.LocalPlayer.StarterPlaylist:FindFirstChild("1Megalovania") then
game.Players.LocalPlayer.StarterPlaylist["1Megalovania"]:Destroy()
end
end

local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "C̶a̴n̸ ̶y̵o̸u̵ ̶i̶m̵a̶g̸i̷n̵e̷ ̴i̴t̴?̷",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args))
wait(3)
local args1 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "A̶ ̴w̶o̷r̵l̵d̴ ̵i̷n̸ ̸w̶h̴i̸c̷h̴ ̶e̵v̷e̴r̴y̴o̷n̷e̴ ̴i̷s̸ ̶a̵t̸ ̵p̵e̶a̸c̴e̶.̸",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args1))
wait(5)
local args2 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "A̵ ̵w̸o̴r̴l̸d̴,̸ ̶i̶n̵ ̴w̸h̵i̴c̴h̴ ̶n̷o̵ ̵o̵n̸e̶ ̶h̶a̶s̸ ̷t̷o̶ ̴d̴i̷e̵.̴",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args2))
wait(5)
local args3 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "A̵ ̷p̶e̶r̷f̵e̷c̴t̶ ̶w̵o̵r̵l̸d̶ ̴l̴i̶k̵e̷ ̴t̴h̵a̴t̵ ̶c̵a̵n̸ ̶e̵x̵i̸s̵t̴.̸.̶",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args3))
game.workspace.lbmusicok.SoundId = "rbxassetid://4686555781"
game.workspace.lbmusicok:Play()
wait(6)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "W̸i̸t̷h̵o̶u̴t̶ Y̵̧̙͆̀Ọ̵̞́̓̕Ư̶͎̩̭͕.",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(4)
game.Players.LocalPlayer.Character.Torso.Anchored = true
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
	{
		["Type"] = "Knockback", 
		["HitEffect"] = "UndyingExplosion", 
		["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.KnockUp, 
		["Velocity"] = Vector3.new(0.0001,10,0.0001),
		["CameraShake"] = "Bump", 
        ["Karma"] = 0,
		["HitTime"] = 0, 
		["VictimCFrame"] = nil, 
		["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
		["Damage"] = 1
	}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
wait(1.5)
game.Players.LocalPlayer.Character.Torso.Anchored = false
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "Im Alive?",
        [4] = Color3.new(0.9,0.3,0.9)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))

game:GetService("ReplicatedStorage").Remotes.Eventa.Name = "Events"
game.Players.LocalPlayer.PlayerGui.SansIndicator:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower:Destroy()

-- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "SpawnBone",
        [3] = true
    }
}

game:GetService("ReplicatedStorage").Remotes.SansMoves:InvokeServer(unpack(args))
game.Players.LocalPlayer.Character.Bone.Part.ParticleEmitter:Destroy()

game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"]:Destroy()

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light1"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"].AnimationId = "rbxassetid://4357851278"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light2"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"].AnimationId = "rbxassetid://4357872409"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light3"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"].AnimationId = "rbxassetid://4357890370"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light4"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"].AnimationId = "rbxassetid://4357902460"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light5"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"].AnimationId = "rbxassetid://4357907686"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Idle"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle.AnimationId = "rbxassetid://5028878836"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Walk"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk.AnimationId = "rbxassetid://5096023358"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Run"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run.AnimationId = "rbxassetid://4370518984"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Fall"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall.AnimationId = "rbxassetid://5111359205"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Jump"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump.AnimationId = "rbxassetid://3198665507"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Block"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block.AnimationId = "rbxassetid://5973908948"

game.Players.LocalPlayer.Backpack.Main:Destroy()
game.Players.LocalPlayer["modded sans"].Main:Clone().Parent = game.Players.LocalPlayer.Backpack

repeat wait()

until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 700

game:GetService("ReplicatedStorage").Remotes.Events.Name = "Eventa"
game.workspace.lbmusicok.SoundId = "rbxassetid://4662280588"
game.workspace.lbmusicok:Play()

local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "..?",
        [4] = Color3.new(0.8,0.8,0.8)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "oh hey there!",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(2)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "you've finally arrived huh?",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "well kid, its time to show you something you will hardly forget",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(4)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "i've told you from many routes before...",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3.5)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "RESET",
        [4] = Color3.new(1,1,0.4)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(2)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "you could have fixed it all, but now its too late",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "now you will see why they say",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(4)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "B̸e̴w̸a̴r̵e̵ ̸o̴f̶ ̵t̵h̴e̷ ̵m̴a̴n̶ ̴w̸h̵o̴ ̵s̶p̶e̵a̸k̷s̵ ̶i̵n̷ ̶h̷a̴n̵d̴s̷",
        [4] = Color3.new(0.3,0.3,0.3)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(5.5)
game.Players.LocalPlayer.Character.Torso.Anchored = true
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
	{
		["Type"] = "Knockback", 
		["HitEffect"] = "SpearJusticeExplosion", 
		["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.KnockUp, 
		["Velocity"] = Vector3.new(0.0001,10,0.0001),
		["CameraShake"] = "Bump", 
        ["Karma"] = 0,
		["HitTime"] = 2, 
		["VictimCFrame"] = nil, 
		["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
		["Damage"] = 1
	}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
wait(1.5)
game.Players.LocalPlayer.Character.Torso.Anchored = false
game.Players.LocalPlayer.Character.Bone:Destroy()

game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"]:Destroy()

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light1"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"].AnimationId = "rbxassetid://5667194069"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light2"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"].AnimationId = "rbxassetid://5667196296"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light3"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"].AnimationId = "rbxassetid://5667206665"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light4"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"].AnimationId = "rbxassetid://5667210178"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light5"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"].AnimationId = "rbxassetid://5667215116"

game.Players.LocalPlayer.PlayerGui.SansIndicator:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower:Destroy()

game.Players.LocalPlayer.Backpack.Main:Destroy()
game.Players.LocalPlayer["modded sans"].Main:Clone().Parent = game.Players.LocalPlayer.Backpack

game:GetService("ReplicatedStorage").Remotes.Eventa.Name = "Events"
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "z" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
    {
    ["HitTime"] = 8, 
    ["Type"] = "Knockback", 
    ["HitEffect"] = "SansLineBones",  
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.LayingDown,  
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
    ["Velocity"] = Vector3.new(0.00001,0.01,0.00001), 
    ["CombatInv"] = true,
    ["Karma"] = 10,
    ["Damage"] = 35
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "x" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "GasterBlasters", 
	[3] = "SummonSpecial", 
	[4] = game.workspace[game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Name].Torso.Position
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "c" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "Telekinesis", 
	[3] = "Special", 
	[4] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "v" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
	{
		["Type"] = "Normal", 
		["HitEffect"] = "BoneHitEffect", 
		["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.KnockUp, 
		["Velocity"] = Vector3.new(0.0001,50,0.0001),
		["CameraShake"] = "Bump", 
        ["Karma"] = 50,
		["HitTime"] = 2, 
		["VictimCFrame"] = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.HumanoidRootPart.CFrame, 
		["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
		["Damage"] = 10
	}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "b" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://6122095988"
local animmTrack = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
animmTrack.Priority = Enum.AnimationPriority.Action
animmTrack.Looped = false
animmTrack:Play()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
wait(0.15)
local A_1 = getrenv()._G.Pass
local A_3 = 
{
	["Type"] = "Normal", 
	["HitEffect"] = "SansLineBones", 
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
	["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector +  Vector3.new(0.001,0.001,0.001), 
	["Karma"] = 2, 
	["HitTime"] = 4, 
	["CombatInv"] = true,
	["VictimCFrame"] = CFrame.new(0,0,0), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.Hurt, 
	["Damage"] = 1
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1,game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value, A_3)

local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "get dunked on!",
        [4] = Color3.new(0.8,0.8,0.8)
    }
}

game:GetService("ReplicatedStorage").Remotes.Events:FireServer(unpack(args4))
wait(1.3)
for i = 1,7 do
spawn(function()
for i = 1,3 do
local A_1 = getrenv()._G.Pass
local A_3 = 
{
	["Type"] = "Knockback", 
	["HitEffect"] = "SansLineBones", 
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
	["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector +  Vector3.new(0.001,0.001,0.001), 
	["Karma"] = 2, 
	["HitTime"] = 1, 
	["CombatInv"] = true,
	["VictimCFrame"] = CFrame.new(0,0,0), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.Hurt, 
	["Damage"] = 40
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1,game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value, A_3)
end
end)
wait(0.4)
end
spawn(function()
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["Type"] = "Knockback", 
	["HitEffect"] = "BoneHitEffect", 
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
	["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50 +  Vector3.new(0,10,0), 
	["Karma"] = 10, 
	["HitTime"] = 1, 
	["CombatInv"] = true,
	["VictimCFrame"] = CFrame.new(0,0,0), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick, 
	["Damage"] = 40
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "n" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5770352035"
local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
track.Looped = false
track:Play()
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
    {
        ["Type"] = "Knockback", 
        ["HitEffect"] = nil, 
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.001, 
        ["CameraShake"] = "Bump", 
        ["HitTime"] = 3, 
        ["CombatInv"] = true,
        ["VictimCFrame"] = nil, 
        ["Sound"] = nil, 
        ["Damage"] = 10
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end
end
end
end)

section9:addButton("Sans last breath 2.0", function()
game:getService("RunService"):BindToRenderStep("",0,function()
if game.ReplicatedStorage.Remotes:FindFirstChild("Eventa") then
local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "InvFrames",
        [3] = 2
    }
}
game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args))
end
end)

game:getService("RunService"):BindToRenderStep("",0,function()
if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("DeathParticle") then
game.workspace.lbmusicok:Stop()
end
end)

local sound = Instance.new("Sound", game.Workspace)
sound.Name = "lbmusicok"
game.workspace.lbmusicok.SoundId = "rbxassetid://4686555781"
game.workspace.lbmusicok.Looped = true
game.workspace.lbmusicok.Volume = 2

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "p" then
local pass = getrenv()._G.Pass

if not game.Players.LocalPlayer:FindFirstChild("modded sans") then
game.Players.LocalPlayer.Character.Dodge:Clone().Parent = game.Players.LocalPlayer
game.Players.LocalPlayer.Dodge.Name = "modded sans"
end

if not game.Players.LocalPlayer:FindFirstChild("yes sus") then
game.Players.LocalPlayer.Character.Dodge:Clone().Parent = game.Players.LocalPlayer
game.Players.LocalPlayer.Dodge.Name = "yes sus"
end

if not game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
for i, v in pairs(game:GetService("Players"):GetChildren()) do
if v.Backpack:FindFirstChild("Main") then
if v.Backpack.Main:FindFirstChild("SansMoves") then
if v.Name ~= game.Players.LocalPlayer.Name then
v.Backpack.Main:Clone().Parent = game.Players.LocalPlayer["modded sans"]
end
end
end
end
end

if game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
for i, v in pairs(game:GetService("Players").LocalPlayer["modded sans"]:GetChildren()) do
v.Parent = game.Players.LocalPlayer["yes sus"]
end
end

if not game.Players.LocalPlayer["modded sans"]:FindFirstChild("Main") then
if game.Players.LocalPlayer["yes sus"]:FindFirstChild("Main") then
game.Players.LocalPlayer["yes sus"].Main.Parent = game:GetService("Players").LocalPlayer["modded sans"]
end
end

game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block:Destroy()

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Idle"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle.AnimationId = "rbxassetid://4458837452"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Walk"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk.AnimationId = "rbxassetid://4458849950"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Run"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run.AnimationId = "rbxassetid://4370518984"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Fall"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall.AnimationId = "rbxassetid://5111359205"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Jump"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump.AnimationId = "rbxassetid://3198665507"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Block"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block.AnimationId = "rbxassetid://5973908948"

game.Players.LocalPlayer.PlayerGui.SansIndicator:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower:Destroy()
game.Players.LocalPlayer.Character.Head.HealthBar.Frame.Health:Destroy()
game.Players.LocalPlayer.Character.Head.HealthBar.Frame.StaminaBar.Bar:Destroy()

game.Players.LocalPlayer.Backpack.Main:Destroy()
game.Players.LocalPlayer["modded sans"].Main:Clone().Parent = game.Players.LocalPlayer.Backpack

game:GetService("ReplicatedStorage").Remotes.Events.Name = "Eventa"

if game.Players.LocalPlayer:FindFirstChild("StarterPlaylist") then
if game.Players.LocalPlayer.StarterPlaylist:FindFirstChild("1Megalovania") then
game.Players.LocalPlayer.StarterPlaylist["1Megalovania"]:Destroy()
end
end

local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "C̶a̴n̸ ̶y̵o̸u̵ ̶i̶m̵a̶g̸i̷n̵e̷ ̴i̴t̴?̷",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args))
wait(3)
local args1 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "A̶ ̴w̶o̷r̵l̵d̴ ̵i̷n̸ ̸w̶h̴i̸c̷h̴ ̶e̵v̷e̴r̴y̴o̷n̷e̴ ̴i̷s̸ ̶a̵t̸ ̵p̵e̶a̸c̴e̶.̸",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args1))
wait(5)
local args2 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "A̵ ̵w̸o̴r̴l̸d̴,̸ ̶i̶n̵ ̴w̸h̵i̴c̴h̴ ̶n̷o̵ ̵o̵n̸e̶ ̶h̶a̶s̸ ̷t̷o̶ ̴d̴i̷e̵.̴",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args2))
wait(5)
local args3 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "A̵ ̷p̶e̶r̷f̵e̷c̴t̶ ̶w̵o̵r̵l̸d̶ ̴l̴i̶k̵e̷ ̴t̴h̵a̴t̵ ̶c̵a̵n̸ ̶e̵x̵i̸s̵t̴.̸.̶",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args3))
game.workspace.lbmusicok.SoundId = "rbxassetid://4686555781"
game.workspace.lbmusicok:Play()
wait(6)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "W̸i̸t̷h̵o̶u̴t̶ Y̵̧̙͆̀Ọ̵̞́̓̕Ư̶͎̩̭͕.",
        [4] = Color3.new(0.2,0.2,0.2)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(4)
game.Players.LocalPlayer.Character.Torso.Anchored = true
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
	{
		["Type"] = "Knockback", 
		["HitEffect"] = "UndyingExplosion", 
		["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.KnockUp, 
		["Velocity"] = Vector3.new(0.0001,10,0.0001),
		["CameraShake"] = "Bump", 
        ["Karma"] = 0,
		["HitTime"] = 0, 
		["VictimCFrame"] = nil, 
		["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
		["Damage"] = 1
	}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
wait(1.5)
game.Players.LocalPlayer.Character.Torso.Anchored = false
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "Im Alive?",
        [4] = Color3.new(0.9,0.3,0.9)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))

game:GetService("ReplicatedStorage").Remotes.Eventa.Name = "Events"
game.Players.LocalPlayer.PlayerGui.SansIndicator:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower:Destroy()

-- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "SpawnBone",
        [3] = true
    }
}

game:GetService("ReplicatedStorage").Remotes.SansMoves:InvokeServer(unpack(args))
game.Players.LocalPlayer.Character.Bone.Part.ParticleEmitter:Destroy()

game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"]:Destroy()

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light1"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"].AnimationId = "rbxassetid://4357851278"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light2"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"].AnimationId = "rbxassetid://4357872409"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light3"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"].AnimationId = "rbxassetid://4357890370"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light4"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"].AnimationId = "rbxassetid://4357902460"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light5"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"].AnimationId = "rbxassetid://4357907686"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Idle"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Idle.AnimationId = "rbxassetid://5028878836"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Walk"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Walk.AnimationId = "rbxassetid://5096023358"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Run"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Run.AnimationId = "rbxassetid://4370518984"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Fall"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Fall.AnimationId = "rbxassetid://5111359205"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Jump"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Jump.AnimationId = "rbxassetid://3198665507"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Animation.Name = "Block"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.Animations.Block.AnimationId = "rbxassetid://5973908948"

game.Players.LocalPlayer.Backpack.Main:Destroy()
game.Players.LocalPlayer["modded sans"].Main:Clone().Parent = game.Players.LocalPlayer.Backpack

repeat wait()

until game.Players.LocalPlayer.Character.Data.Stamina.Value <= 700

game:GetService("ReplicatedStorage").Remotes.Events.Name = "Eventa"
game.workspace.lbmusicok.SoundId = "rbxassetid://4662280588"
game.workspace.lbmusicok:Play()

local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "..?",
        [4] = Color3.new(0.8,0.8,0.8)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "oh hey there!",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(2)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "you've finally arrived huh?",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "well kid, its time to show you something you will hardly forget",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(4)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "i've told you from many routes before...",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3.5)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "RESET",
        [4] = Color3.new(1,1,0.4)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(2)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "you could have fixed it all, but now its too late",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(3)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "now you will see why they say",
        [4] = Color3.new(0.7,0.7,0.7)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(4)
local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "B̸e̴w̸a̴r̵e̵ ̸o̴f̶ ̵t̵h̴e̷ ̵m̴a̴n̶ ̴w̸h̵o̴ ̵s̶p̶e̵a̸k̷s̵ ̶i̵n̷ ̶h̷a̴n̵d̴s̷",
        [4] = Color3.new(0.3,0.3,0.3)
    }
}

game:GetService("ReplicatedStorage").Remotes.Eventa:FireServer(unpack(args4))
wait(5.5)
game.Players.LocalPlayer.Character.Torso.Anchored = true
local A_1 = getrenv()._G.Pass
local A_2 = game.Players.LocalPlayer.Character
local A_3 = 
	{
		["Type"] = "Knockback", 
		["HitEffect"] = "SpearJusticeExplosion", 
		["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.KnockUp, 
		["Velocity"] = Vector3.new(0.0001,10,0.0001),
		["CameraShake"] = "Bump", 
        ["Karma"] = 0,
		["HitTime"] = 2, 
		["VictimCFrame"] = nil, 
		["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
		["Damage"] = 1
	}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
wait(1.5)
game.Players.LocalPlayer.Character.Torso.Anchored = false
game.Players.LocalPlayer.Character.Bone:Destroy()

game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"]:Destroy()
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"]:Destroy()

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light1"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light1"].AnimationId = "rbxassetid://5667194069"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light2"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light2"].AnimationId = "rbxassetid://5667196296"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light3"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light3"].AnimationId = "rbxassetid://5667206665"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light4"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light4"].AnimationId = "rbxassetid://5667210178"

local Anim = Instance.new("Animation", game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat)
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat.Animation.Name = "Light5"
game.Players.LocalPlayer["modded sans"].Main.SansMoves.ModuleScript.Animations.BladesCombat["Light5"].AnimationId = "rbxassetid://5667215116"

game.Players.LocalPlayer.PlayerGui.SansIndicator:Destroy()
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower:Destroy()

game.Players.LocalPlayer.Backpack.Main:Destroy()
game.Players.LocalPlayer["modded sans"].Main:Clone().Parent = game.Players.LocalPlayer.Backpack

game:GetService("ReplicatedStorage").Remotes.Eventa.Name = "Events"
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "z" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
    {
    ["HitTime"] = 8, 
    ["Type"] = "Knockback", 
    ["HitEffect"] = "SansLineBones",  
    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.LayingDown,  
    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
    ["Velocity"] = Vector3.new(0.00001,0.01,0.00001), 
    ["CombatInv"] = true,
    ["Karma"] = 10,
    ["Damage"] = 35
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "x" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "GasterBlasters", 
	[3] = "SummonSpecial", 
	[4] = game.workspace[game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.Name].Torso.Position
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "c" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = 
{
	[1] = getrenv()._G.Pass, 
	[2] = "Telekinesis", 
	[3] = "Special", 
	[4] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "v" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
	{
		["Type"] = "Normal", 
		["HitEffect"] = "BoneHitEffect", 
		["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.KnockUp, 
		["Velocity"] = Vector3.new(0.0001,50,0.0001),
		["CameraShake"] = "Bump", 
        ["Karma"] = 50,
		["HitTime"] = 2, 
		["VictimCFrame"] = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.HumanoidRootPart.CFrame, 
		["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback, 
		["Damage"] = 10
	}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "b" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://6122095988"
local animmTrack = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
animmTrack.Priority = Enum.AnimationPriority.Action
animmTrack.Looped = false
animmTrack:Play()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
wait(0.15)
local A_1 = getrenv()._G.Pass
local A_3 = 
{
	["Type"] = "Normal", 
	["HitEffect"] = "SansLineBones", 
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
	["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector +  Vector3.new(0.001,0.001,0.001), 
	["Karma"] = 2, 
	["HitTime"] = 4, 
	["CombatInv"] = true,
	["VictimCFrame"] = CFrame.new(0,0,0), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.Hurt, 
	["Damage"] = 1
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1,game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value, A_3)

local args4 = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Chatted",
        [3] = "get dunked on!",
        [4] = Color3.new(0.8,0.8,0.8)
    }
}

game:GetService("ReplicatedStorage").Remotes.Events:FireServer(unpack(args4))
wait(1.3)
for i = 1,7 do
spawn(function()
for i = 1,3 do
local A_1 = getrenv()._G.Pass
local A_3 = 
{
	["Type"] = "Knockback", 
	["HitEffect"] = "SansLineBones", 
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1, 
	["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector +  Vector3.new(0.001,0.001,0.001), 
	["Karma"] = 2, 
	["HitTime"] = 1, 
	["CombatInv"] = true,
	["VictimCFrame"] = CFrame.new(0,0,0), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.Hurt, 
	["Damage"] = 40
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1,game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value, A_3)
end
end)
wait(0.4)
end
spawn(function()
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["Type"] = "Knockback", 
	["HitEffect"] = "BoneHitEffect", 
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
	["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 50 +  Vector3.new(0,10,0), 
	["Karma"] = 10, 
	["HitTime"] = 1, 
	["CombatInv"] = true,
	["VictimCFrame"] = CFrame.new(0,0,0), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick, 
	["Damage"] = 40
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end)
end
end
end
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:connect(function(key)
    if key == "n" then
if game.Players.LocalPlayer.Character:FindFirstChild("Type") then
if game.Players.LocalPlayer.Character.Type.Value == "Sans" then
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://5770352035"
local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
track.Looped = false
track:Play()
local A_1 = getrenv()._G.Pass
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
    {
        ["Type"] = "Knockback", 
        ["HitEffect"] = nil, 
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2, 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 0.001, 
        ["CameraShake"] = "Bump", 
        ["HitTime"] = 3, 
        ["CombatInv"] = true,
        ["VictimCFrame"] = nil, 
        ["Sound"] = nil, 
        ["Damage"] = 10
    }
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
end
end
end
end)
end)
end)

local page = venyx:addPage("trolling", 5012544693)
local section12 = page:addSection("DamageRemotes")

section12:addButton("RainbowExplosion (Require Be Close)", function()
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "RainbowExplosion",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)



section12:addButton("RainbowExplosion (Require Be Close)", function()


local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "RainbowExplosion",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)


section12:addButton("SpearJusticeExplosion (Require Be Close)", function()


local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "SpearJusticeExplosion",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)


section12:addButton("SansLineBones (Require Be Close)", function()


local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "SansLineBones",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)

section12:addButton("CrossLineBones (Require Be Close)", function()


local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "CrossLineBones",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)


section12:addButton("IntHitEffect (Require Be Close)", function()

local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "IntHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)


section12:addButton("TriangleAttackHitEffect (Require Be Close)", function()


local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "TriangleAttackHitEffect",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)



section12:addButton("ConstantExplosions (Require Be Close)", function()


local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "ConstantExplosions",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)

section12:addButton("ConstantExplosions (Require Be Close)", function()


local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 20,
        ["Type"] = "Normal",
        ["HitEffect"] = "ConstantExplosions2",
        ["VictimCFrame"] = CFrame.new(Vector3.new(957.38525390625, -2.7168080806732, 271.31875610352), Vector3.new(0.90182185173035, 0.0016235302900895, 0.43210506439209)),
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Stunned,
        ["Velocity"] = Vector3.new(0, 0, -1),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
wait(1)
k:Stop()
end)


local section11 = page:addSection("Insta Kill")
section11:addButton("Kill All (Require SFChara)", function()
game:getService("RunService"):BindToRenderStep("",0,function()
for i, v in pairs(game:GetService("Players"):GetChildren()) do
if game.workspace:FindFirstChild(v.Name) then
-- Script generated by SimpleSpy - credits to exx#9394

function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end

local args = {
    [1] = {
        [1] = getrenv()._G.Pass,
        [2] = "Knives",
        [3] = "Hit3",
        [4] = v.Character.Head,
        [5] = v.Character.Head.CFrame,
        [6] = math.huge
    }
}

game:GetService("ReplicatedStorage").Remotes.SFCharaMoves:InvokeServer(unpack(args))
end
end
end)
end)
