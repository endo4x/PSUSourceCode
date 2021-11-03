--[[
	id: vZXqU0s5tvoOtSzglt24S
	name: a320 main server
	description: a
	time1: 2021-05-14 23:53:54.731297+00
	time2: 2021-05-14 23:53:54.731297+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
polaris best
best a320neo i swear
alyss was here
hi mom!
go buy more stuff ok thx <3
]]
local run = true
if game["Run Service"]:IsStudio() then
	warn("Polaris | The A320neo doesn't work in studio! Please try ingame.")
	run = false
	script.Parent.Parent:Destroy()
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
	script.Parent.Parent:Destroy()
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
			["title"] = "Someone used the A320neo without being whitelisted!",
			["description"] = "The game with id ["..gameid.."](https://roblox.com/games/"..gameid..") has used the A320neo without being whitelisted! Take action!",
			["color"] = 16711680,
			["author"] = {
				["name"] = "Whitelist Alert! - Owner ID: "..tostring(gameOwner)..""
			},
			["footer"] = {
				["text"] = "- A320neo"
			}
		}
	}
}
MessageData = http:JSONEncode(MessageData)
whitelistapi:GetAsync(HubID, "Airbus A320neo", gameOwner, function(Success, Value)
	if Success == false then
		http:PostAsync(WebhookURL,MessageData)
		warn("Polaris | You don't own the Airbus A320neo! Unloading!")
		run = false
		script.Parent.Parent:Destroy()
	end
end)
if run == true then
	local Settings = require(script.Settings.Value)
	function giveTool(weldchild)
		wait(0.1)
		if weldchild:IsA("Weld") and weldchild.Name == "SeatWeld" then
			local findhuman = weldchild.Part1.Parent:FindFirstChild("Humanoid")
			if (findhuman ~= nil) then
				local player = game.Players:GetPlayerFromCharacter(findhuman.Parent)
				if (player ~=nil) then
					if player:GetRankInGroup(Settings.GroupId) >= Settings.FOMinRank then
						gui = script.Parent["FO GUi"]:Clone() -- Change toolname to what tool you want to be given
						gui.Parent = player.PlayerGui
					else
						local jump = script.Jump
						jump.Parent = player.PlayerGui
						jump.Disabled = false
						wait(0.05)
						jump.Disabled = true
						jump.Parent = script
					end
				end
			end 
		end
	end

	function removeTool()
		if (gui ~= nil) then
			gui:Remove()
		end
	end

	script.Parent.ChildAdded:Connect(giveTool)
	script.Parent.ChildRemoved:Connect(removeTool)
	-- engines
	local eng1 = false
	local eng2 = false
	local gears = false
	local door1 = false
	local door2 = false
	local door3 = false
	local door4 = false
	local cargo = false
	local f1 = false
	local spolier = false
	local reverse = false
	local taxi = false
	local strobe = false
	local tail = false
	local nav = false
	local ld = false
	local beacon = false
	local apu = false
	local interior = false
	local anim = script.locate.Value
	local lighting = script.Lights.Value
	anim.BACKLEFT_M.Motor.DesiredAngle = 1.5
	anim.BACKRIGHT_M.Motor.DesiredAngle = -1.5

	local function lightsoff()
		if taxi then
			lighting.TAXI.Value.Light.Enabled = false
			lighting.TAXI.Value.Beam.Enabled = false
			lighting.TAXI.Value.Material = Enum.Material.SmoothPlastic
			taxi = false
		end
		if tail then
			lighting.TAIL.Light.Enabled = false
			tail = false
		end
		if strobe then
			lighting.STROBE.Strobing.Disabled = true
			for i,v in pairs(lighting.STROBE:GetChildren()) do
				if v:IsA("Part") then
					v.PointLight.Enabled = false
					v.Light.Enabled = false
				end
			end
			strobe = false
		end
		if nav then
			for i,v in pairs(lighting.NAV:GetChildren()) do
				if v:IsA("Part") then
					v.PointLight.Enabled = false
					v.Light.Enabled = false
				end
			end
			nav = false
		end
		if ld then
			for i,v in pairs(lighting.LD:GetChildren()) do
				if v:IsA("Part") then
					v.Beam.Enabled = false
					v.Light.Enabled = false
					v.Material = Enum.Material.SmoothPlastic
				end
			end
			ld = false
		end
		if beacon then
			lighting.BEACON.Beacon.Disabled = true
			for i,v in pairs(lighting.BEACON:GetChildren()) do
				if v:IsA("Part") then
					v.PointLight.Enabled = false
					v.Light.Enabled = false
					lighting.Model:FindFirstChild(v.Name).Material = Enum.Material.SmoothPlastic
				end
			end
			beacon = false
		end
	end
	local function interiorset(onoff)
		if onoff == true then
			for i,v in pairs(anim.CeilingLights.Blue:GetChildren()) do
				v.Material = Enum.Material.Neon
			end
			for i,v in pairs(anim.CeilingLights.White:GetChildren()) do
				v.Material = Enum.Material.Neon
				v.Transparency = 0.4
			end
			anim.CeilingLights.LightPart.SurfaceLight.Enabled = true
			interior = true
		else
			for i,v in pairs(anim.CeilingLights.Blue:GetChildren()) do
				v.Material = Enum.Material.SmoothPlastic
			end
			for i,v in pairs(anim.CeilingLights.White:GetChildren()) do
				v.Material = Enum.Material.SmoothPlastic
				v.Transparency = 0
			end
			anim.CeilingLights.LightPart.SurfaceLight.Enabled = false
			interior = false
		end
	end
	if not Settings.APUEngineLock then
		interiorset(true)
	end
	script.Parent.values.events.eng1.OnServerEvent:Connect(function(plr)
		if eng1 == true then
			eng1 = false
			local ani = script.locate.Value
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG1.StatusLight.ImageColor3 = Color3.new(255,255,0)
			for i = 1, 20 do
				ani.ENG1_M.Motor.MaxVelocity = ani.ENG1_M.Motor.MaxVelocity - 0.005
				wait(1.5)
			end
			eng1 = false
			if eng2 == false then
				anim.Values.Engine.Value = false
			end
			if Settings.APUEngineLock then
				if not eng2 and not apu then
					lightsoff()
					interiorset(false)
				end
			end
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG1.StatusLight.ImageColor3 = Color3.new(1, 0, 0)
		elseif eng1 == false then
			eng1 = true
			local ani = script.locate.Value
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG1.StatusLight.ImageColor3 = Color3.new(255,255,0)
			for i = 1, 20 do
				ani.ENG1_M.Motor.MaxVelocity = ani.ENG1_M.Motor.MaxVelocity + 0.005
				wait(1.5)
			end
			anim.Values.Engine.Value = true
			if Settings.APUEngineLock then
				if not interior then
					interiorset(true)
				end
			end
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG1.StatusLight.ImageColor3 = Color3.new(0, 1, 0)
		end
	end)

	script.Parent.values.events.eng2.OnServerEvent:Connect(function(plr)
		if eng2 == true then
			eng2 = false
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG2.StatusLight.ImageColor3 = Color3.new(255,255,0)
			local ani = script.locate.Value
			for i = 1, 20 do
				ani.ENG2_M.Motor.MaxVelocity = ani.ENG1_M.Motor.MaxVelocity - 0.005
				wait(1.5)
			end
			eng2 = false
			if eng1 == false then
				anim.Values.Engine.Value = false
			end
			if Settings.APUEngineLock then
				if not eng1 and not apu then
					lightsoff()
					interiorset(false)
				end
			end
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG2.StatusLight.ImageColor3 = Color3.new(1, 0, 0)
		elseif eng2 == false then
			eng2 = true
			local ani = script.locate.Value
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG2.StatusLight.ImageColor3 = Color3.new(255,255,0)
			for i = 1, 20 do
				ani.ENG2_M.Motor.MaxVelocity = ani.ENG1_M.Motor.MaxVelocity + 0.005
				wait(1.5)
			end
			if Settings.APUEngineLock then
				if not interior then
					interiorset(true)
				end
			end
			anim.Values.Engine.Value = true
			plr.PlayerGui:FindFirstChild("FO GUi").ENGINES.ENG2.StatusLight.ImageColor3 = Color3.new(0, 1, 0)
		end
	end)

	-- gears 

	script.Parent.values.events.gear.OnServerEvent:Connect(function(plr, args)
		if args == "ifewofjqpfiw0fqwf0qw0ef4wofoef0wkfewfmfpoefeqpofikel" then
			if gears == true then
				gears = false
				plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Gears.StatusLight.ImageColor3 = Color3.new(255,255,0)
				anim.FRONTLEFT_M.Motor.DesiredAngle = 1.5
				anim.FRONTRIGHT_M.Motor.DesiredAngle = -1.5
				anim.BG1_M.Motor.DesiredAngle = 1.5
				anim.BG2_M.Motor.DesiredAngle = -1.2
				anim.BACKLEFT_M.Motor.DesiredAngle = 1.5
				anim.BACKRIGHT_M.Motor.DesiredAngle = -1.5
				wait(5)
				anim.FG_M.Motor.DesiredAngle = 0
				anim.BGR_M.Motor.DesiredAngle = 0
				anim.BGL_M.Motor.DesiredAngle = 0
				wait(2)
				for i,v in pairs(script.Plane.Value.Animations.BackGear.Main.Left.Disappaear:GetChildren()) do
					v.Transparency = 0
				end
				for i,v in pairs(script.Plane.Value.Animations.BackGear.Main.Right.RightGear.Model:GetChildren()) do
					v.Transparency = 0
				end

				wait(3)
				anim.FRONTLEFT_M.Motor.DesiredAngle = 0
				anim.FRONTRIGHT_M.Motor.DesiredAngle = 0
				anim.BG1_M.Motor.DesiredAngle = 0
				anim.BG2_M.Motor.DesiredAngle = 0
				wait(5)
				plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Gears.StatusLight.ImageColor3 = Color3.new(0, 1, 0)
			elseif gears == false then
				gears = true
				plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Gears.StatusLight.ImageColor3 = Color3.new(255,255,0)
				anim.FRONTLEFT_M.Motor.DesiredAngle = 1.5
				anim.FRONTRIGHT_M.Motor.DesiredAngle = -1.5
				anim.BG1_M.Motor.DesiredAngle = 1.5
				anim.BG2_M.Motor.DesiredAngle = -1.2
				wait(5)
				anim.FG_M.Motor.DesiredAngle = -1.5
				anim.BGL_M.Motor.DesiredAngle = -1.2
				anim.BGR_M.Motor.DesiredAngle = 1.2
				wait(2)
				for i,v in pairs(script.Plane.Value.Animations.BackGear.Main.Left.Disappaear:GetChildren()) do
					v.Transparency = 1
				end
				for i,v in pairs(script.Plane.Value.Animations.BackGear.Main.Right.RightGear.Model:GetChildren()) do
					v.Transparency = 1
				end
				wait(3)
				anim.BACKLEFT_M.Motor.DesiredAngle = 0
				anim.BACKRIGHT_M.Motor.DesiredAngle = 0
				anim.FRONTLEFT_M.Motor.DesiredAngle = 0
				anim.FRONTRIGHT_M.Motor.DesiredAngle = 0
				anim.BG1_M.Motor.DesiredAngle = 0
				anim.BG2_M.Motor.DesiredAngle = 0
				wait(5)
				plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Gears.StatusLight.ImageColor3 = Color3.new(1, 0, 0)
			end
		end
	end)


	-- doors

	local D1During = false
	script.Parent.values.events.door1.OnServerEvent:Connect(function(plr)
		if not D1During then
			if door1 == true then
				door1 = false
				D1During = true
				for i = 1,150 do
					anim.D1_M.Motor.C1 = anim.D1_M.Motor.C1 * CFrame.new(0.023,0,0)
					wait(0.009)
				end
				for i = 1,30 do
					anim.D1_M.Motor.C1 = anim.D1_M.Motor.C1 * CFrame.new(0,0,-0.010)
					wait(0.009)
				end
				D1During = false
			elseif door1 == false then
				door1 = true
				D1During = true
				for i = 1,30 do
					anim.D1_M.Motor.C1 = anim.D1_M.Motor.C1 * CFrame.new(0,0,0.010)
					wait(0.009)
				end
				for i = 1,150 do
					anim.D1_M.Motor.C1 = anim.D1_M.Motor.C1 * CFrame.new(-0.023,0,0)
					wait(0.009)
				end
				D1During = false
			end
		end
	end)
	local D2During = false
	script.Parent.values.events.door2.OnServerEvent:Connect(function(plr)
		if not D2During then
			if door2 == true then
				door2 = false
				D2During = true
				for i = 1,150 do
					anim.D2_M.Motor.C1 = anim.D2_M.Motor.C1 * CFrame.new(0.023,0,0)
					wait(0.009)
				end

				for i = 1,30 do
					anim.D2_M.Motor.C1 = anim.D2_M.Motor.C1 * CFrame.new(0,0,0.015)
					wait(0.009)
				end

				D2During = false
			elseif door2 == false then
				door2 = true
				D2During = true
				for i = 1,30 do
					anim.D2_M.Motor.C1 = anim.D2_M.Motor.C1 * CFrame.new(0,0,-0.015)
					wait(0.009)
				end

				for i = 1,150 do
					anim.D2_M.Motor.C1 = anim.D2_M.Motor.C1 * CFrame.new(-0.023,0,0)
					wait(0.009)
				end

				D2During = false
			end
		end
	end)
	local D3During = false
	script.Parent.values.events.door3.OnServerEvent:Connect(function(plr)
		if not D3During then
			if door3 == true then
				door3 = false
				D3During = true

				for i = 1,150 do
					anim.D3_M.Motor.C1 = anim.D3_M.Motor.C1 * CFrame.new(0.023,0,-0.005)
					wait(0.009)
				end
				for i = 1,30 do
					anim.D3_M.Motor.C1 = anim.D3_M.Motor.C1 * CFrame.new(0,0,-0.015)
					wait(0.009)
				end
				D3During = false
			elseif door3 == false then
				door3 = true
				D3During = true
				for i = 1,30 do
					anim.D3_M.Motor.C1 = anim.D3_M.Motor.C1 * CFrame.new(0,0,0.015)
					wait(0.009)
				end
				for i = 1,150 do
					anim.D3_M.Motor.C1 = anim.D3_M.Motor.C1 * CFrame.new(-0.023,0,0.005)
					wait(0.009)
				end

				D3During = false
			end
		end
	end)
	local D4During = false
	script.Parent.values.events.door4.OnServerEvent:Connect(function(plr)
		if not D4During then
			if door4 == true then
				door4 = false
				D4During = true
				for i = 1,150 do
					anim.D4_M.Motor.C1 = anim.D4_M.Motor.C1 * CFrame.new(0.023,0,0.005)
					wait(0.009)
				end
				for i = 1,30 do
					anim.D4_M.Motor.C1 = anim.D4_M.Motor.C1 * CFrame.new(0,0,0.015)
					wait(0.009)
				end

				D4During = false
			elseif door4 == false then
				door4 = true
				D4During = true
				for i = 1,30 do
					anim.D4_M.Motor.C1 = anim.D4_M.Motor.C1 * CFrame.new(0,0,-0.015)
					wait(0.009)
				end

				for i = 1,150 do
					anim.D4_M.Motor.C1 = anim.D4_M.Motor.C1 * CFrame.new(-0.023,0,-0.005)
					wait(0.009)
				end

				D4During = false
			end
		end
	end)
	script.Parent.values.events.cargo.OnServerEvent:Connect(function(plr)
		if cargo == false then
			anim.C1_M.Motor.DesiredAngle = -2.5
			anim.C2_M.Motor.DesiredAngle = -2.5
			cargo = true
		elseif cargo == true then
			anim.C1_M.Motor.DesiredAngle = 0
			anim.C2_M.Motor.DesiredAngle = 0
		end
	end)
	local status = script.stats
	local durflaps = false
	script.Parent.values.events.FlapPlus.OnServerEvent:Connect(function(plr)
		if durflaps == false then
			if status.Value == 0 then
				durflaps = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Plus.Visible = false
				anim.F1_M.Motor.DesiredAngle = -0.2
				anim.F2_M.Motor.DesiredAngle = -0.2
				anim.F3_M.Motor.DesiredAngle = -0.2
				anim.F4_M.Motor.DesiredAngle = -0.2
				for i = 1,110 do
					anim.F1_M.Motor.C1 = anim.F1_M.Motor.C1 * CFrame.new(-0.007,0,0)
					anim.F4_M.Motor.C1 = anim.F4_M.Motor.C1 * CFrame.new(-0.001,0,0)
					wait(0.009)
				end
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Plus.Visible = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Minus.Visible = true
				status.Value = 1
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Current.Text = "1"
				durflaps = false
			elseif status.Value == 1 then
				durflaps = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Plus.Visible = false
				anim.F1_M.Motor.DesiredAngle = -0.4
				anim.F2_M.Motor.DesiredAngle = -0.4
				anim.F3_M.Motor.DesiredAngle = -0.4
				anim.F4_M.Motor.DesiredAngle = -0.4
				wait(3.5)
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Plus.Visible = true
				status.Value = 2
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Current.Text = "2"
				durflaps = false
			elseif status.Value == 2 then
				durflaps = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Plus.Visible = false
				anim.F1_M.Motor.DesiredAngle = -0.6
				anim.F2_M.Motor.DesiredAngle = -0.6
				anim.F3_M.Motor.DesiredAngle = -0.6
				anim.F4_M.Motor.DesiredAngle = -0.6
				wait(3.5)
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Plus.Visible = true
				status.Value = 3
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Current.Text = "3"
				durflaps = false
			end
		end
	end)


	script.Parent.values.events.FlapMinus.OnServerEvent:Connect(function(plr)
		if durflaps == false then
			if status.Value == 3 then
				durflaps = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Minus.Visible = false
				anim.F1_M.Motor.DesiredAngle = -0.4
				anim.F2_M.Motor.DesiredAngle = -0.4
				anim.F3_M.Motor.DesiredAngle = -0.4
				anim.F4_M.Motor.DesiredAngle = -0.4
				wait(3.5)
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Minus.Visible = true
				status.Value = 2
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Current.Text = "2"
				durflaps = false
			elseif status.Value == 2 then
				durflaps = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Minus.Visible = false
				anim.F1_M.Motor.DesiredAngle = -0.2
				anim.F2_M.Motor.DesiredAngle = -0.2
				anim.F3_M.Motor.DesiredAngle = -0.2
				anim.F4_M.Motor.DesiredAngle = -0.2
				wait(3.5)
				status.Value = 1
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Minus.Visible = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Current.Text = "1"
				durflaps = false
			elseif status.Value == 1 then
				durflaps = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Minus.Visible = false
				anim.F1_M.Motor.DesiredAngle = -0
				anim.F2_M.Motor.DesiredAngle = -0
				anim.F3_M.Motor.DesiredAngle = -0
				anim.F4_M.Motor.DesiredAngle = -0
				for i = 1,110 do
					anim.F1_M.Motor.C1 = anim.F1_M.Motor.C1 * CFrame.new(0.007,0,0)
					anim.F4_M.Motor.C1 = anim.F4_M.Motor.C1 * CFrame.new(0.001,0,0)
					wait(0.009)
				end
				status.Value = 0
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Minus.Visible = true
				plr.PlayerGui:FindFirstChild("FO GUi").MAIN.Flaps.Current.Text = "0"	
				durflaps = false
			end
		end
	end)




	script.Parent.values.events.spoiler.OnServerEvent:Connect(function(plr)
		if spolier == true then
			spolier = false
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Spoilers.StatusLight.ImageColor3 = Color3.new(255,255,0)
			anim.LS1_M.Motor.DesiredAngle = 0
			anim.LS2_M.Motor.DesiredAngle = 0
			anim.LS3_M.Motor.DesiredAngle = 0
			anim.LS4_M.Motor.DesiredAngle = 0
			anim.RS1_M.Motor.DesiredAngle = 0
			anim.RS2_M.Motor.DesiredAngle = 0
			anim.RS3_M.Motor.DesiredAngle = 0
			anim.RS4_M.Motor.DesiredAngle = 0
			wait(5)
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Spoilers.StatusLight.ImageColor3 = Color3.new(1, 0, 0)
		elseif spolier == false then
			spolier = true
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Spoilers.StatusLight.ImageColor3 = Color3.new(255,255,0)
			anim.LS1_M.Motor.DesiredAngle = 0.5
			anim.LS2_M.Motor.DesiredAngle = 0.5
			anim.LS3_M.Motor.DesiredAngle = 0.5
			anim.LS4_M.Motor.DesiredAngle = 0.5
			anim.RS1_M.Motor.DesiredAngle = 0.5
			anim.RS2_M.Motor.DesiredAngle = 0.5
			anim.RS3_M.Motor.DesiredAngle = 0.5
			anim.RS4_M.Motor.DesiredAngle = 0.5
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Spoilers.StatusLight.ImageColor3 = Color3.new(0, 1, 0)

		end
	end)


	script.Parent.values.events.REVERSE.OnServerEvent:Connect(function(plr)
		if reverse == true then
			reverse = false
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Reverse.StatusLight.ImageColor3 = Color3.new(255,255,0)
			for i = 1,21 do
				anim.E2REV_M.Motor.C1 = anim.E2REV_M.Motor.C1 * CFrame.new(-0.05,0,0)
				anim.E1REV_M.Motor.C1 = anim.E1REV_M.Motor.C1 * CFrame.new(-0.05,0,0)
				wait(0.01)
			end
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Reverse.StatusLight.ImageColor3 = Color3.new(1,0,0)
		elseif reverse == false then
			reverse = true
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Reverse.StatusLight.ImageColor3 = Color3.new(255,255,0)
			for i = 1,21 do
				anim.E2REV_M.Motor.C1 = anim.E2REV_M.Motor.C1 * CFrame.new(0.05,0,0)
				anim.E1REV_M.Motor.C1 = anim.E1REV_M.Motor.C1 * CFrame.new(0.05,0,0)
				wait(0.01)
			end
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.Reverse.StatusLight.ImageColor3 = Color3.new(0,255,0)
		end
	end)



	--lighting
	local function lighttoggle(light)
		if light == "Taxi" then
			if taxi == false then
				lighting.TAXI.Value.Light.Enabled = true
				lighting.TAXI.Value.Beam.Enabled = true
				lighting.TAXI.Value.Material = Enum.Material.Neon
				taxi = true
			else
				lighting.TAXI.Value.Light.Enabled = false
				lighting.TAXI.Value.Beam.Enabled = false
				lighting.TAXI.Value.Material = Enum.Material.SmoothPlastic
				taxi = false
			end
		elseif light == "Tail" then
			if tail == false then
				lighting.TAIL.Light.Enabled = true
				tail = true
			else
				lighting.TAIL.Light.Enabled = false
				tail = false
			end
		elseif light == "Strobe" then
			if strobe == false then
				lighting.STROBE.Strobing.Disabled = false
				strobe = true
			else
				lighting.STROBE.Strobing.Disabled = true
				for i,v in pairs(lighting.STROBE:GetChildren()) do
					if v:IsA("Part") then
						v.PointLight.Enabled = false
						v.Light.Enabled = false
					end
				end
				strobe = false
			end
		elseif light == "Nav" then
			if nav == false then
				for i,v in pairs(lighting.NAV:GetChildren()) do
					if v:IsA("Part") then
						v.PointLight.Enabled = true
						v.Light.Enabled = true
					end
				end
				nav = true
			else
				for i,v in pairs(lighting.NAV:GetChildren()) do
					if v:IsA("Part") then
						v.PointLight.Enabled = false
						v.Light.Enabled = false
					end
				end
				nav = false
			end
		elseif light == "LD" then
			if ld == false then
				for i,v in pairs(lighting.LD:GetChildren()) do
					if v:IsA("Part") then
						v.Beam.Enabled = true
						v.Light.Enabled = true
						v.Material = Enum.Material.Neon
					end
				end
				ld = true
			else
				for i,v in pairs(lighting.LD:GetChildren()) do
					if v:IsA("Part") then
						v.Beam.Enabled = false
						v.Light.Enabled = false
						v.Material = Enum.Material.SmoothPlastic
					end
				end
				ld = false
			end
		elseif light == "Beacon" then
			if beacon == false then
				lighting.BEACON.Beacon.Disabled = false
				beacon = true
			else
				lighting.BEACON.Beacon.Disabled = true
				for i,v in pairs(lighting.BEACON:GetChildren()) do
					if v:IsA("Part") then
						v.PointLight.Enabled = false
						v.Light.Enabled = false
						lighting.Model:FindFirstChild(v.Name).Material = Enum.Material.SmoothPlastic
					end
				end
				beacon = false
			end
		end
	end
	script.Parent.values.events.Lights.OnServerEvent:Connect(function(plr, light)
		if Settings.APUEngineLock then
			if apu or eng1 or eng2 then
				lighttoggle(light)
			end
		else
			lighttoggle(light)
		end
	end)
	local TS = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(
		3, 
		Enum.EasingStyle.Linear, 
		Enum.EasingDirection.Out, 
		0, 
		false, 
		0 
	)
	local apuup = {}
	apuup.Volume = 0.5
	apuup.PlaybackSpeed = 1
	local apudown = {}
	apudown.Volume = 0
	apudown.PlaybackSpeed = 0
	script.Parent.values.events.APU.OnServerEvent:Connect(function(plr)
		if apu == false then
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.APU.StatusLight.ImageColor3 = Color3.new(255,255,0)
			anim.APU.APU:Play()
			local tween = TS:Create(anim.APU.APU, tweenInfo, apuup)	
			tween:Play()
			wait(3)
			anim.APU.Contrail.Enabled = true
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.APU.StatusLight.ImageColor3 = Color3.new(0,255,0)
			anim.Values.APU.Value = true
			apu = true
			if Settings.APUEngineLock then
				if not interior then
					interiorset(true)
				end
			end
		else
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.APU.StatusLight.ImageColor3 = Color3.new(255,255,0)
			local tween = TS:Create(anim.APU.APU, tweenInfo, apudown)	
			tween:Play()
			wait(3)
			plr.PlayerGui:FindFirstChild("FO GUi").Mechanisms.APU.StatusLight.ImageColor3 = Color3.new(255,0,0)
			anim.APU.APU:Stop()
			anim.APU.Contrail.Enabled = false
			anim.Values.APU.Value = false
			apu = false
			if Settings.APUEngineLock then
				if not eng2 and not eng1 then
					lightsoff()
					interiorset(false)
				end
			end
		end
	end)
end