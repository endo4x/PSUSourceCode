--[[
	id: BblDcAUmWbb6d-o3BS8LB
	name: a220 fo
	description: asd
	time1: 2021-07-26 05:35:02.665201+00
	time2: 2021-07-26 05:35:02.665202+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
polaris best
a220
alyss was here
yes we know it took a year
hi mom!
go buy more stuff ok thx <3
sheeeeeeeeeeesh
]]
PSU_MAX_SECURITY_START()
local run = true
if game:GetService("RunService"):IsStudio() then
	warn("Polaris | The Airbus A220 doesn't work in studio! Please try ingame.")
	run = false
	script.Parent.Parent.Parent:Destroy()
end
local gameid = tostring(game.PlaceId)
local whitelistapi = require(4460787902)
local HubID = "713363099796766760"
local gameOwner = nil
function httpe()
	local s = pcall(function()
		game:GetService('HttpService'):GetAsync('http://www.google.com/robots.txt')
	end)
	return s
end

if httpe() == false then
	warn("Polaris | Please turn on HTTP service! Unloading!")
	run = false
	script.Parent.Parent.Parent:Destroy()
end
if game.CreatorType == Enum.CreatorType.Group then
	gameOwner = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
elseif game.CreatorType == Enum.CreatorType.User then
	gameOwner = game.CreatorId
end
local http = game:GetService("HttpService")
local WebhookURL = "https://discordapp.com/api/webhooks/765991028103577650/meFRrgTQng1dYpkBwD3_SPk8S2DeTfYrTFksNL8o2LmVkJEmuCxl2DH3JgnLfCQFp2m0"
local MessageData = {
	["embeds"] = {
		{
			["title"] = "Someone used the A220 without being whitelisted!",
			["description"] = "The game with id ["..gameid.."](https://roblox.com/games/"..gameid..") has used the A220 without being whitelisted! Take action!",
			["color"] = 16711680,
			["author"] = {
				["name"] = "Whitelist Alert! - Owner ID: "..tostring(gameOwner)..""
			},
			["footer"] = {
				["text"] = "- A220"
			}
		}
	}
}
MessageData = http:JSONEncode(MessageData)
whitelistapi:GetAsync(HubID, "Airbus A220", gameOwner, function(Success, Value)
	if Success == false then
		http:PostAsync(WebhookURL,MessageData)
		warn("Polaris | You don't own the Airbus A220! Unloading!")
		run = false
		script.Parent.Parent.Parent:Destroy()
	end
end)
if run == true then
    PSU_MAX_SECURITY_END()
	local event = script.FORE
	local motors = script.Motors.Value
	local red = Color3.fromRGB(116, 0, 0)
	local green = Color3.fromRGB(83, 116, 58)
	local apuup = {}
	apuup.Volume = 0.5
	apuup.PlaybackSpeed = 1
	local apudown = {}
	apudown.Volume = 0
	apudown.PlaybackSpeed = 0
	local tweenInfo = TweenInfo.new(
		3, 
		Enum.EasingStyle.Linear, 
		Enum.EasingDirection.Out, 
		0, 
		false, 
		0 
	)
	local oxymask = motors.Animations.Value.A220OxygenMask
	oxymask.Parent = game:GetService("ServerStorage")
	local nav = false
	local taxi = false
	local ld = false
	local beacon = false
	local strobe = false
	local logo = false
	local rt = false
	local spoilers = false
	local apu = false
	local e1 = false
	local e2 = false
	local slides = false
	local cabinsm = false
	local e1fire = false
	local e2fire = false
	local fdump = false
	local cargo = false
	local gears = true
	local oxygen = false
	local flaps = 0
	local gui = script.AdvancedFOGUI
	local Settings = require(script.Settings.Value)
	local function emerge(thing, bool)
		if bool == true then
			if thing == "Smoke" then
				for i,v in pairs(motors.EmergencySystem.SmokeParts:GetChildren()) do
					v.Smoke.Enabled = true
				end
			elseif thing == "Fuel" then
				for i,v in pairs(motors.EmergencySystem.FuelDumpParts:GetChildren()) do
					v.Fuel.Enabled = true
				end
			elseif thing == "Slides" then
				for i,v in pairs(motors.EmergencySystem.Slides:GetDescendants()) do
					if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
						if v.Name ~= "CollideFalse" then
							v.Transparency = 0
							v.CanCollide = true
						else
							v.Transparency = 0
							v.CanCollide = false
						end
					end
				end
				script.Sound:Play()
				motors.EmergencySystem.Slides.CanSlide.Value = true
			elseif thing == "OxyMask" then
				for i,plr in pairs(game:GetService("Players"):GetPlayers()) do
					plr.Character.Humanoid:AddAccessory(oxymask)
				end
			end
		elseif bool == false then
			if thing == "Smoke" then
				for i,v in pairs(motors.EmergencySystem.SmokeParts:GetChildren()) do
					v.Smoke.Enabled = false
				end
			elseif thing == "Fuel" then
				for i,v in pairs(motors.EmergencySystem.FuelDumpParts:GetChildren()) do
					v.Fuel.Enabled = false
				end
			end
		end
	end
	for i,v in pairs(motors.OxyRemovers:GetChildren()) do
		v.Touched:Connect(function(part)
			local plr = game:GetService("Players"):GetPlayerFromCharacter(part.Parent)
			if plr then
				for i,v in pairs(plr.Character.Humanoid:GetAccessories()) do
					if v.Name == oxymask.Name then
						v:Destroy()
					end
				end
			end
		end)
	end
	local TS = game:GetService("TweenService")
	local function toggler(onoff, thing)
		for i,v in pairs(thing:GetDescendants()) do
			if v:IsA("Beam") or v:IsA("SurfaceLight") or v:IsA("PointLight") or v:IsA("BillboardGui") then
				v.Enabled = onoff
			end
		end
	end
	local function engtween(mode, eng)
		local tweenInfo = TweenInfo.new(
			20, 
			Enum.EasingStyle.Linear, 
			Enum.EasingDirection.Out, 
			0, 
			false, 
			0 
		)
		if mode == true then
			motors.Animations.Value:FindFirstChild(eng).MAIN.ENG:Play()
			local up = {}
			up.Volume = 2
			up.PlaybackSpeed = 1
			local tween = TS:Create(motors.Animations.Value:FindFirstChild(eng).MAIN.ENG, tweenInfo, up)	
			tween:Play()
		else
			local down = {}
			down.Volume = 0
			down.PlaybackSpeed = 0
			local tween = TS:Create(motors.Animations.Value:FindFirstChild(eng).MAIN.ENG, tweenInfo, down)	
			tween:Play()
			wait(20)
			motors.Animations.Value:FindFirstChild(eng).MAIN.ENG:Stop()
		end
	end

	event.OnServerEvent:Connect(function(plr, thing, light, color)
		if thing == "NAV" then
			if nav == false then
				toggler(true, motors.Lights.NAV)
				event:FireClient(plr, thing, green)
				nav = true
			else
				toggler(false, motors.Lights.NAV)
				event:FireClient(plr, thing, red)
				nav = false
			end
		elseif thing == "TAXI" then
			if taxi == false then
				toggler(true, motors.Lights.TAXI.Value)
				event:FireClient(plr, thing, green)
				taxi = true
			else
				toggler(false, motors.Lights.TAXI.Value)
				event:FireClient(plr, thing, red)
				taxi = false
			end
		elseif thing == "LD" then
			if ld == false then
				toggler(true, motors.Lights.LD)
				event:FireClient(plr, thing, green)
				ld = true
			else
				toggler(false, motors.Lights.LD)
				event:FireClient(plr, thing, red)
				ld = false
			end
		elseif thing == "BEACON" then
			if beacon == false then
				motors.Lights.BEACON.Beacon.Disabled = false
				event:FireClient(plr, thing, green)
				beacon = true
			else
				motors.Lights.BEACON.Beacon.Disabled = true
				toggler(false, motors.Lights.BEACON)
				event:FireClient(plr, thing, red)
				beacon = false
			end
		elseif thing == "STROBE" then
			if strobe == false then
				motors.Lights.STROBE.Strobing.Disabled = false
				event:FireClient(plr, thing, green)
				strobe = true
			else
				motors.Lights.STROBE.Strobing.Disabled = true
				toggler(false, motors.Lights.STROBE)
				event:FireClient(plr, thing, red)
				strobe = false
			end
		elseif thing == "LOGO" then
			if logo == false then
				toggler(true, motors.Lights.TAIL)
				event:FireClient(plr, thing, green)
				logo = true
			else
				toggler(false, motors.Lights.TAIL)
				event:FireClient(plr, thing, red)
				logo = false
			end
		elseif thing == "RT" then
			if rt == false then
				rt = nil
				for i=1, 62 do
					motors.REV.Motor.C1 = motors.REV.Motor.C1 + Vector3.new(0,0,-0.02)
					wait(0.001)
				end
				event:FireClient(plr, thing, green)
				rt = true
			elseif rt == true then
				rt = nil
				for i=1, 62 do
					motors.REV.Motor.C1 = motors.REV.Motor.C1 + Vector3.new(0,0,0.02)
					wait(0.001)
				end
				event:FireClient(plr, thing, red)
				rt = false
			end
		elseif thing == "SPOILERS" then
			if spoilers == false then
				spoilers = nil
				motors.SP_2.Motor.DesiredAngle = -0.7
				motors.SP_1.Motor.DesiredAngle = -0.7
				repeat wait() until motors.SP_2.Motor.CurrentAngle <= -0.69
				event:FireClient(plr, thing, green)
				spoilers = true
			elseif spoilers == true then
				spoilers = nil
				motors.SP_2.Motor.DesiredAngle = 0
				motors.SP_1.Motor.DesiredAngle = 0
				repeat wait() until motors.SP_2.Motor.CurrentAngle >= -0.01
				event:FireClient(plr, thing, red)
				spoilers = false
			end
		elseif thing == "APU" then
			if apu == false then
				apu = nil
				local tween = TS:Create(motors.APU.APU, tweenInfo, apuup)	
				tween:Play()
				wait(3)
				motors.APU.Contrail.Enabled = true
				apu = true
				event:FireClient(plr, thing, green)
			elseif apu == true then
				apu = nil
				local tween = TS:Create(motors.APU.APU, tweenInfo, apudown)	
				tween:Play()
				wait(3)
				motors.APU.APU:Stop()
				motors.APU.Contrail.Enabled = false
				apu = false
				event:FireClient(plr, thing, red)
			end
		elseif thing == "E1" then
			if e1 == false then
				e1 = nil
				engtween(true, "E1")
				for i=1,200 do
					motors.E1.Motor.MaxVelocity = motors.E1.Motor.MaxVelocity+0.005
					wait(0.1)
				end
				event:FireClient(plr, thing, green)
				e1 = true
			elseif e1 == true then
				e1 = nil
				engtween(true, "E1")
				for i=1,200 do
					motors.E1.Motor.MaxVelocity = motors.E1.Motor.MaxVelocity-0.005
					wait(0.1)
				end
				event:FireClient(plr, thing, red)
				e1 = false
			end
		elseif thing == "E2" then
			if e2 == false then
				e2 = nil
				engtween(true, "E2")
				for i=1,200 do
					motors.E2.Motor.MaxVelocity = motors.E2.Motor.MaxVelocity+0.005
					wait(0.1)
				end
				event:FireClient(plr, thing, green)
				e2 = true
			elseif e2 == true then
				e2 = nil
				engtween(false, "E2")
				for i=1,200 do
					motors.E2.Motor.MaxVelocity = motors.E2.Motor.MaxVelocity-0.005
					wait(0.1)
				end
				event:FireClient(plr, thing, red)
				e2 = false
			end
		elseif thing == "SLIDES" then
			if slides == false then
				emerge("Slides", true)
				slides = true
				event:FireClient(plr, thing, green)
			end
		elseif thing == "CABINSM" then
			if cabinsm == false then
				emerge("Smoke", true)
				event:FireClient(plr, thing, green)
				cabinsm = true
			else
				emerge("Smoke", false)
				event:FireClient(plr, thing, red)
				cabinsm = false
			end
		elseif thing == "E1FIRE" then
			if e1fire == false then
				motors.EmergencySystem.FireParts.E1.Fire.Enabled = true
				event:FireClient(plr, thing, green)
				e1fire = true
			else
				motors.EmergencySystem.FireParts.E1.Fire.Enabled = false
				event:FireClient(plr, thing, red)
				e1fire = false
			end
		elseif thing == "E2FIRE" then
			if e2fire == false then
				motors.EmergencySystem.FireParts.E2.Fire.Enabled = true
				event:FireClient(plr, thing, green)
				e2fire = true
			else
				motors.EmergencySystem.FireParts.E2.Fire.Enabled = false
				event:FireClient(plr, thing, red)
				e2fire = false
			end
		elseif thing == "FDUMP" then
			if fdump == false then
				emerge("Fuel", true)
				event:FireClient(plr, thing, green)
				fdump = true
			else
				emerge("Fuel", false)
				event:FireClient(plr, thing, red)
				fdump = false
			end
		elseif thing == "DLOCK" then
			local val = motors.CanOpen
			if val.Value == false then
				val.Value = true
				event:FireClient(plr, thing, red)
			elseif val.Value == true then
				val.Value = false
				event:FireClient(plr, thing, green)
			end
		elseif thing == "GEARS" then
			if gears == true then
				gears = nil
				motors.LF_FGD.Motor.DesiredAngle = -1.5
				motors.RF_FGD.Motor.DesiredAngle = 1.5
				repeat wait() until motors.RF_FGD.Motor.CurrentAngle >= 1.49
				wait(0.2)
				motors.LGD.Motor.DesiredAngle = 1.57
				motors.LG.Motor.DesiredAngle = 1.25
				motors.Animations.Value.LB.GA_M.Motor.DesiredAngle = -1.3
				motors.Animations.Value.LB.GA2_M.Motor.DesiredAngle = 0.65
				motors.RGD.Motor.DesiredAngle = 1.57
				motors.RG.Motor.DesiredAngle = 1.25
				motors.Animations.Value.RB.GA_M.Motor.DesiredAngle = 1.3
				motors.Animations.Value.RB.GA2_M.Motor.DesiredAngle = -0.65
				motors.FG.Motor.DesiredAngle = 1.8
				repeat wait() until motors.FG.Motor.CurrentAngle >= 1.79
				motors.Animations.Value.RB.GD.GD.Transparency = 1
				motors.Animations.Value.LB.GD.GD.Transparency = 1
				motors.LF_FGD.Motor.DesiredAngle = 0
				motors.RF_FGD.Motor.DesiredAngle = 0
				motors.LR_FGD.Motor.DesiredAngle = 0
				motors.RR_FGD.Motor.DesiredAngle = 0
				repeat wait() until motors.RF_FGD.Motor.CurrentAngle <= 0.01
				event:FireClient(plr, thing, red)
				gears = false
			elseif gears == false then
				gears = nil
				motors.LF_FGD.Motor.DesiredAngle = -1.5
				motors.RF_FGD.Motor.DesiredAngle = 1.5
				motors.LR_FGD.Motor.DesiredAngle = -1.5
				motors.RR_FGD.Motor.DesiredAngle = 1.5
				repeat wait() until motors.RF_FGD.Motor.CurrentAngle >= 1.49
				wait(0.2)
				motors.LG.Motor.DesiredAngle = 0
				motors.LGD.Motor.DesiredAngle = 0
				motors.Animations.Value.LB.GA_M.Motor.DesiredAngle = 0
				motors.Animations.Value.LB.GA2_M.Motor.DesiredAngle = 0
				motors.RG.Motor.DesiredAngle = 0
				motors.RGD.Motor.DesiredAngle = 0
				motors.Animations.Value.RB.GA_M.Motor.DesiredAngle = 0
				motors.Animations.Value.RB.GA2_M.Motor.DesiredAngle = 0
				motors.FG.Motor.DesiredAngle = 0
				repeat wait() until motors.FG.Motor.CurrentAngle <= 0.01
				motors.LF_FGD.Motor.DesiredAngle = 0
				motors.Animations.Value.RB.GD.GD.Transparency = 0
				motors.Animations.Value.LB.GD.GD.Transparency = 0
				motors.RF_FGD.Motor.DesiredAngle = 0
				repeat wait() until motors.RF_FGD.Motor.CurrentAngle <= 0.01
				event:FireClient(plr, thing, green)
				gears = true
			end
		elseif thing == "FLAPSUP" then
			if flaps < 3 then
				local localflaps = flaps
				flaps = 10
				event:FireClient(plr, "FLAPS", "In Transit")
				local currdes = motors:FindFirstChild("FL_1").Motor.DesiredAngle
				for i=1,4 do
					motors:FindFirstChild("FL_"..tostring(i)).Motor.DesiredAngle = currdes + 0.13
				end
				repeat wait() until motors:FindFirstChild("FL_1").Motor.CurrentAngle >= currdes + 0.129
				flaps = localflaps + 1
				event:FireClient(plr, "FLAPS", flaps)
			end
		elseif thing == "FLAPSDOWN" then
			if flaps >= 1 and flaps <= 3 then
				local localflaps = flaps
				flaps = 10
				event:FireClient(plr, "FLAPS", "In Transit")
				local currdes = motors:FindFirstChild("FL_1").Motor.DesiredAngle
				for i=1,4 do
					motors:FindFirstChild("FL_"..tostring(i)).Motor.DesiredAngle = currdes - 0.13
				end
				repeat wait() until motors:FindFirstChild("FL_1").Motor.CurrentAngle >= currdes - 0.129
				flaps = localflaps - 1
				event:FireClient(plr, "FLAPS", flaps)
			end
		elseif thing == "OXYGEN" then
			if oxygen == false then
				emerge("OxyMask", true)
				oxygen = true
				event:FireClient(plr, thing, green)
			end
		elseif thing == "UPDATE" then
			if light == "FLAPS" then
				gui.InfoBar.Flaps.Value.Text = tostring(color)
			end
			for i,v in pairs(gui:GetDescendants()) do
				if v.Name == light.."IND" then
					v.BackgroundColor3 = color
				end
			end
		end
	end)

	motors.CARGO_PROX.ProximityPrompt.Triggered:Connect(function()
		if cargo == false then
			cargo = nil
			motors.CARGO_PROX.ProximityPrompt.Enabled = false
			motors.CARGO.Motor.DesiredAngle = 2.5
			repeat wait() until motors.CARGO.Motor.CurrentAngle >= 2.49
			cargo = true
			motors.CARGO_PROX.ProximityPrompt.ActionText = "Close"
			motors.CARGO_PROX.ProximityPrompt.Enabled = true
		elseif cargo == true then
			cargo = nil
			motors.CARGO_PROX.ProximityPrompt.Enabled = false
			motors.CARGO.Motor.DesiredAngle = 0
			repeat wait() until motors.CARGO.Motor.CurrentAngle <= 0.01
			cargo = false
			motors.CARGO_PROX.ProximityPrompt.ActionText = "Open"
			motors.CARGO_PROX.ProximityPrompt.Enabled = true
		end
	end)

	script.Parent.ChildAdded:Connect(function(part)
		if part:IsA("Weld") and part.Name == "SeatWeld" then
			local plr = game:GetService("Players"):GetPlayerFromCharacter(part.Part1.Parent)
			if plr:GetRankInGroup(Settings.GroupID) < Settings.FOMinRank then
				wait(0.1)
				plr.Character.Humanoid.Jump = true
			else
				gui:Clone().Parent = plr.PlayerGui
			end
		end
	end)
	script.Parent.ChildRemoved:Connect(function(part)
		if part:IsA("Weld") and part.Name == "SeatWeld" then
			local plr = game:GetService("Players"):GetPlayerFromCharacter(part.Part1.Parent)
			if plr.PlayerGui:FindFirstChild(gui.Name) then
				plr.PlayerGui:FindFirstChild(gui.Name):Destroy()
			end
		end
	end)
end