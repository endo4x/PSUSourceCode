--[[
	id: 380Ashu5mMOkYNGOT3h_X
	name: Tie System
	description: emperormicah tie whitelist
	time1: 2021-07-04 07:15:16.005657+00
	time2: 2021-07-04 07:15:16.005658+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

local http = game:GetService("HttpService")
local apiKey = script.api_key.Value
local aa = http:GetAsync("https://scpfos.glitch.me/api?apikey="..apiKey)
local a = http:JSONDecode(aa)
if a.tiesystem == true then
	print("[scpfOS] Tie System: Loaded")
else
	print("[scpfOS] Tie System: Error")
	script:Destroy()
end








wait()
local player1
local unenterable = false
local debris={
objects={};
events={};

}
local TieExplosion = game:service'ServerStorage':WaitForChild'TieExplosion'
function WeldDescendants(x,b)
	local w={}
	for i,v in pairs(x:GetDescendants()) do
		if b~=v and v:IsA'BasePart' and v.Name~='CameraEffect' then
			w[#w+1]=v
		end
	end
	for i,v in pairs(w) do
		local x = Instance.new('Weld',v)
		x.C0 = v.CFrame:inverse()
		x.C1 = b.CFrame:inverse()
		x.Part0 = v
		x.Part1 = b
	end
	for i,v in pairs(w) do
		v.Anchored = false
	end
	b.Anchored = false
end
WeldDescendants(script.Parent,script.Parent.FPCam)

local lightflasher = 0

local engineon = false

function toggleengine(state)
	if engineon~=state then
		engineon = state
	end
	if engineon then
	--	script.Parent.Head.BillboardGui.Enabled = false
		--script.Parent.Head.BillboardGui.ColorFrame.ImageColor3 = player1.TeamColor.Color
		script.Parent.Head.EngineDeactivate:Stop()
		script.Parent.Head.EngineActivate:Play()
		coroutine.resume(coroutine.create(function()
			wait(2)
			script.Parent.Head.EngineActive.Volume = 0.5
		end))
	else
	--	script.Parent.Head.BillboardGui.Enabled = false
		script.Parent.Head.EngineActivate:Stop()
		script.Parent.Head.EngineDeactivate:Play()
		script.Parent.Head.EngineActive.Volume = 0
	end
end


function kickout(player)
	toggleengine(false)
	--script.Parent.Healther.Head.EngineDeactivate:Play()
--	script.Parent.Healther.Head.EngineActive.Volume = 0
	for i,v in pairs(debris.objects) do
		if v.Name == 'Client' then
			pcall(function()v.Exit:FireClient(player)end)
			game:service'Debris':AddItem(v,10)
		else
			v:Destroy()
		end
	end
	for i,v in pairs(debris.events) do
		v:disconnect()
	end
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild'Humanoid'
		if humanoid then
			humanoid.PlatformStand = false
		end
	end
	lightflasher = 0
	--script.Parent.LeftMachineGun.Lights.PointLight.Enabled = false
	--script.Parent.LeftMachineGun.Lights.Reflectance = 1
	--script.Parent.LeftMachineGun.Lights.Color = Color3.new(0,0,0)
	player1=nil
	wait()
	if character then
		character:SetPrimaryPartCFrame(CFrame.new(script.Parent.FPCam.CFrame.p)*CFrame.new(0,-8,0))
	end
	script.Parent.FPCam.CanBeEntered.Value = true
end


function hitpart(hit)
		local hum = hit.Parent:FindFirstChild'Humanoid'
		if not hum then
			hum = hit.Parent.Parent:FindFirstChild'Humanoid'
		end
		if hum and hum:IsA'Humanoid' then
			hum:TakeDamage(250)
			if hum:FindFirstChild'DamageIndicator' then
				hum.DamageIndicator:Fire(script.Parent:GetModelCFrame())
			end
			if player1 then
				game.ReplicatedStorage.HitMarker:FireClient(player1)
			end
		end
end

function flashlights()
	--script.Parent.LeftMachineGun.Lights.Reflectance = 0
--	script.Parent.LeftMachineGun.Lights.PointLight.Enabled = true
	while true and tick()<lightflasher do
	--	script.Parent.LeftMachineGun.Lights.Color = Color3.new(1,1,1)
	--	script.Parent.LeftMachineGun.Lights.PointLight.Color = Color3.new(1,1,1)
		wait(.2)
		--script.Parent.LeftMachineGun.Lights.Color = Color3.new(1,0,0)
		--script.Parent.LeftMachineGun.Lights.PointLight.Color = Color3.new(1,0,0)
	end
end

function initialize(player)
	--script.Parent.Healther.Torso.ParticleEmitter.Enabled = true
	--[[coroutine.resume(coroutine.create(function()
		wait(5)
		script.Parent.Healther.Torso.ParticleEmitter.Enabled = false
		if player1 == player then
			script.Parent.Healther.Head.EngineActive.Volume = .5
		end
	end))]]
	script.Parent.FPCam.CanBeEntered.Value = false
	lightflasher = tick() + 5
	coroutine.resume(coroutine.create(flashlights))
	local char = player.Character
	char.PrimaryPart.CFrame = script.Parent.FPCam.CFrame
	local humanoid = char:FindFirstChild'Humanoid'
	humanoid.PlatformStand = true
	local weld = Instance.new('Weld',script.Parent.FPCam)
	weld.Part0 = script.Parent.TorsoPosition
	weld.Part1 = char.PrimaryPart
	debris.objects[#debris.objects+1]=weld
	local client = script.Client:clone()
	client.Tie.Value = script.Parent
	client.Parent = char
	wait()
	client.Disabled = false
	debris.objects[#debris.objects+1]=client
	debris.events[#debris.events+1] = player.AncestryChanged:connect(function()
		kickout(player)
	end)
	debris.events[#debris.events+1] = player.Changed:connect(function()
		if player.Character~=char then
			kickout(player)
		end
	end)
	debris.events[#debris.events+1] = client.HitPart.OnServerEvent:connect(function(player,hit)
		if player == player1 then
			hitpart(hit)
		end
	end)
	debris.events[#debris.events+1] = client.EngineEvent.OnServerEvent:connect(function(player,ison)
		if player == player1 then
			toggleengine(ison)
		end
	end)
	debris.events[#debris.events+1]=script.Parent.Humanoid.DamageIndicator.Event:connect(function(cf)
		client.IndicateDamage:FireClient(player,cf)
	end)
	debris.events[#debris.events+1]= client.Crashed.OnServerEvent:connect(function(player)
		if player == player1 then
			script.Parent.Humanoid:TakeDamage(400)
		end
	end)
end

function caninteract(player)
	if player and player.Character and player.Character.PrimaryPart then
		if player.Character:FindFirstChild'Humanoid' and player.Character.Humanoid:IsA'Humanoid' then
			return true
		end
	end
	return false
end

local edeb = 0
function EClicked(player)
	if time()<edeb then return end
	edeb = time()+3
	if caninteract(player) then
		if player == player1 then
				kickout(player)
		elseif not unenterable then
			if player1 == nil then
				player1 = player
				initialize(player)
			end
		end
	end
end

_G.ButtonBindEHooks[#_G.ButtonBindEHooks+1]={script.Parent.FPCam,EClicked,35,'enter tie'}

local rtb=game:service'ReplicatedStorage'.RenderTieBullet
rtb.OnServerEvent:connect(function(player,tie,hit1,hit2)
	if tie == script.Parent then
		for i,v in pairs(game:service'Players':GetPlayers()) do
			if v~=player then
				rtb:FireClient(v,tie,player.Character,script.Parent.LeftMachineGun,script.Parent.RightMachineGun,hit1,hit2)
			end
		end
	end
end)

script.Parent.Humanoid.Changed:Connect(function()
	if not script.Parent.Humanoid.PlatformStand then
		script.Parent.Humanoid.PlatformStand=true
	end
end)
script.Parent.Humanoid.PlatformStand=true

script.Parent.Humanoid.Died:Connect(function()
	game:service'ReplicatedStorage'.ShakeCam:FireAllClients(script.Parent:GetModelCFrame().p)
	script.Parent.Head.Explosion:Play()
	if player1 then
		pcall(function()player1.Character:BreakJoints()end)
		kickout(player1)
	end
	local center = script.Parent:GetModelCFrame()
	for i,v in pairs(script.Parent:GetDescendants()) do
		if v:IsA'BasePart' then
			v.Anchored = false
			v.CanCollide = false
			local vel = Instance.new('BodyVelocity',v)
			vel.Velocity = CFrame.new(center.p,v.CFrame.p).lookVector*Vector3.new(500,500,500)
			game:service'Debris':AddItem(vel,1)
		elseif v:IsA'Weld' then
			v:Destroy()
		end
	end
	local deatheffect = TieExplosion:clone()
	deatheffect.Parent = workspace
	deatheffect.CFrame = center
	for i,v in pairs(deatheffect:children()) do
		v.Enabled = true
	end
	game:service'Debris':AddItem(script.Parent,10)
	wait(2.5)
	for i,v in pairs(deatheffect:children()) do
		v.Enabled = false
	end
	game:service'Debris':AddItem(deatheffect,10)
end)

script.Parent.Head.EngineActive:Play()