--[[
	id: bcEw1CHlZMPQ4S3v0DvLU
	name: Tie System (Client)
	description: emperormicah tie stuff
	time1: 2021-07-04 07:17:24.044009+00
	time2: 2021-07-04 07:17:24.04401+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

local player = game:service'Players'.LocalPlayer
local character = player.Character
local primarypart = character.PrimaryPart
local uis = game:service'UserInputService'
local mouse = player:GetMouse()
local tie = script:WaitForChild('Tie').Value
local screech = script:WaitForChild('Screech')
local firstperson = false
local mousegui = script.MouseGui
local cc = script.ColorCorrection
cc.Parent = game.Lighting
local fmouse = {x=0,y=0}
local tieheat = 0

mousegui.Parent = player:FindFirstChild'PlayerGui'

local fpcam = tie:WaitForChild'FPCam'
local tpcam = tie:WaitForChild'TPCam'

local bodyvelocity = Instance.new('BodyVelocity',primarypart)
bodyvelocity.MaxForce = Vector3.new(40000000000,40000000000,40000000000)
local bodygyro = Instance.new('BodyGyro',primarypart)
bodygyro.MaxTorque = Vector3.new(4000000,4000000,4000000)

local speed = 0
transparency={}

function lerp(a, b, t)
    return a * (1-t) + (b*t)
end
local sidemove = 0
local zrot = 0


local battlemode = false
local cooldowndebounce = 0
local hasupped = 0
local engineon = false
local rspeed = 80
local enginedeb = 0
local CameraEffect = script:WaitForChild('CameraEffect')
CameraEffect.Parent = workspace.CurrentCamera
currentzoom = 0
basespeed=4.2
if player.Name=='JTmaveryk' then
	basespeed = 4
end
local rs=game:service'RunService'.RenderStepped:connect(function()
	pcall(function()
		for i,v in pairs(tie.Head.SoundGroup:children()) do
			v.Enabled = firstperson
		end
		for i,v in pairs(script.SoundGroup:children()) do
			v.Enabled = firstperson
		end
	end)
	local canmove = engineon and ((enginedeb-3)<=tick())
	if engineon then
		bodyvelocity.MaxForce = Vector3.new(40000000000,40000000000,40000000000)
		bodygyro.MaxTorque = Vector3.new(4000000,4000000,4000000)
	else
		bodyvelocity.MaxForce = Vector3.new(0,0,0)
		bodygyro.MaxTorque = Vector3.new(0,0,0)
	end
	cc.Enabled = battlemode
	if firstperson then
		workspace.CurrentCamera.CFrame = fpcam.CFrame*CFrame.Angles(0+math.rad(fmouse.y/70),math.rad(180)-math.rad(fmouse.x/70),0)*CFrame.new(0,0,-speed/300*3)
		workspace.CurrentCamera.FieldOfView = 70 + (speed/300*50)   - (currentzoom)
	else
		workspace.CurrentCamera.CFrame = tpcam.CFrame*CFrame.Angles(0+math.rad(fmouse.y/70),math.rad(180)-math.rad(fmouse.x/70),0)*CFrame.new(0,0,speed/300*32)
		workspace.CurrentCamera.FieldOfView = 90 + (speed/300*30)   - (currentzoom)
	end
	if b2d then
		currentzoom = lerp(currentzoom,20,.15)
	else
		currentzoom = lerp(currentzoom,0,.15)
	end
	uis.MouseIconEnabled = false
	uis.MouseBehavior = Enum.MouseBehavior.LockCenter
	mousegui.CenterMouse:TweenPosition(UDim2.new(.5,fmouse.x/10,.5,fmouse.y/10),nil,nil,.2,true)
	mousegui.MovingMouse:TweenPosition(UDim2.new(.5,fmouse.x,.5,fmouse.y),nil,nil,.1,true)
	mousegui.CenterMouse.Frame.Heat.Size = UDim2.new(0,tieheat,0,2)
	local sidemovet = 0
	if uis:IsKeyDown(Enum.KeyCode.E) then
		sidemovet = sidemovet + speed
	end
	if uis:IsKeyDown(Enum.KeyCode.Q) then
		sidemovet = sidemovet - speed
	end
	sidemove = lerp(sidemove,sidemovet,.15)
	local up = 0
	if hasupped<300 then
		up = up + 5
		hasupped = hasupped + 1
	end
	bodyvelocity.Velocity = (primarypart.CFrame*CFrame.Angles(0,math.rad(180),0)).lookVector*Vector3.new(basespeed*speed,basespeed*speed,basespeed*speed) + Vector3.new(sidemove*.25, up,0)
	if not uis:IsKeyDown(Enum.KeyCode.C) and canmove then
		local xdist = fmouse.x
		local ydist = fmouse.y
		local zrott = 0
		if uis:IsKeyDown(Enum.KeyCode.D) then
			zrott=zrott+.5/100*rspeed
		end
		if uis:IsKeyDown(Enum.KeyCode.A) then
			zrott=zrott-.5/100*rspeed
		end
		zrot = lerp(zrot,zrott,1/40)
		bodygyro.CFrame = primarypart.CFrame * CFrame.Angles(math.rad((ydist))/1000*rspeed,-math.rad((xdist))/1000*rspeed,zrot)
	end
	for i,v in pairs(character:GetDescendants()) do
		if v:IsA'BasePart' then
			if v.Transparency~=1 then
				transparency[v]=v.Transparency
				v.Transparency = 1
			end
		end
	end
	for i,v in pairs(tie:GetDescendants()) do
		if v:IsA'BasePart' and v.Name == 'MakeTransparent' then
			if battlemode then
				if not transparency[v] then
					transparency[v]=v.Transparency
					v.Transparency = 1
				end
			else
				if transparency[v] then
					v.Transparency = transparency[v]
					transparency[v] = nil
				end
			end
		elseif v:IsA'BasePart' then
			if battlemode then
				if not transparency[v] then
					transparency[v]=v.Transparency
					v.Transparency = (v.Transparency+1)*.85
				end
			else
				if transparency[v] then
					v.Transparency = transparency[v]
					transparency[v] = nil
				end
			end
		end
	end
	if canmove then
		if uis:IsKeyDown(Enum.KeyCode.W) then
			speed = speed+.6
		end
		if uis:IsKeyDown(Enum.KeyCode.S) then
			speed = speed-.6
		end
	end
	speed = math.min(math.max(speed,0),player.Name == 'JTmaveryk' and 300 or 100)--who doesnt want faster speed lol
	
	if tieheat > 0 and cooldowndebounce<=tick() then
		tieheat = tieheat-5
		cooldowndebounce = tick()+1/15
	end
	tieheat = math.ceil(tieheat)
	tieheat = math.max(tieheat,0)
	if (Vector3.new(0,0,0)-Vector3.new(fmouse.x,fmouse.y,0)).magnitude>290 and speed >= 90 and engineon then
		screech.Volume = lerp(screech.Volume,1,.2)
	else
		screech.Volume = lerp(screech.Volume,0,.05)
	end
	if not engineon then
		speed = 0
	end
	CameraEffect.CFrame = workspace.CurrentCamera.CFrame*CFrame.new(0,0,-5)
	CameraEffect.Sparks:Emit(speed*.5*(1/60))
	
	local vel = tie.Head.Velocity
	local mspd = math.max(math.abs(vel.X),math.abs(vel.Y),math.abs(vel.Z))
	if speed >= 90 and mspd < 90 then
		script.Crashed:FireServer()
	else
		--print'not crashing'
	end
	local hum = tie:FindFirstChild'Humanoid'
	if hum and hum.Health/hum.MaxHealth <= .4 then
		script.Alarm.Volume = 1
	else
		script.Alarm.Volume = 0
	end
--	_G.VehicleHealth.Set(hum.Health/hum.MaxHealth)
end)

function hitpart(part)
	script.HitPart:FireServer(part)
end
local shootdebounce=0
function shoot()
	if tieheat >= 90 then
		tieheat = 100
		cooldowndebounce = 0
		shootdebounce = tick()+5
	else
		cooldowndebounce = tick()+1
		tieheat = lerp(tieheat,100,.1)
	end
	local pos
	do
	local ray = workspace.CurrentCamera:ScreenPointToRay(mousegui.MovingMouse.AbsolutePosition.X + (45/2),mousegui.MovingMouse.AbsolutePosition.Y + (41/2),300)
	_,pos = workspace:FindPartOnRayWithWhitelist(ray,{},false,true)
	pos = (CFrame.new(tie.TPCam.CFrame.p,pos)*CFrame.new(0,0,-1000)).p
	end
	local hit1,hit2
	if pos then
		local rayr = Ray.new(tie.RightMachineGun.CFrame.p,(pos - tie.RightMachineGun.CFrame.p).unit*3000)
		local part,pos1 = workspace:FindPartOnRayWithIgnoreList(rayr,{tie,character,workspace.CurrentCamera},false,true)
		local rayl = Ray.new(tie.LeftMachineGun.CFrame.p,(pos - tie.LeftMachineGun.CFrame.p).unit*3000)
		local part,pos2 = workspace:FindPartOnRayWithIgnoreList(rayl,{tie,character,workspace.CurrentCamera},false,true)
		game:service'ReplicatedStorage'.LocalRenderTieBullet:Fire(tie,character,tie.LeftMachineGun,tie.RightMachineGun,pos1,pos2,hitpart)
		game:service'ReplicatedStorage'.RenderTieBullet:FireServer(tie,pos1,pos2)
	end
end

function OnMouseMoved(input)
	local unit = input.Delta
	fmouse.x = unit.x + fmouse.x
	fmouse.y = unit.y + fmouse.y
	if (Vector3.new(0,0,0)-Vector3.new(fmouse.x,fmouse.y,0)).magnitude>300 then
		local angle = CFrame.new(Vector3.new(0,0,0),Vector3.new(fmouse.x,fmouse.y,0))
		local newpos = CFrame.new(Vector3.new(0,0,0),Vector3.new(fmouse.x,fmouse.y,0))*CFrame.new(0,0,-300)
		fmouse.x = newpos.X
		fmouse.y = newpos.Y
	end
end

InputChangedConn = uis.InputChanged:connect(function(input, processed)
	if input.UserInputType == Enum.UserInputType.Touch then
	--	OnTouchChanged(input, processed)
	elseif input.UserInputType == Enum.UserInputType.MouseMovement then
		OnMouseMoved(input, processed)
	elseif input.UserInputType == Enum.UserInputType.MouseWheel then
	--	OnMouseWheel(input, processed)
	end
end)

mouse.KeyDown:connect(function(key)
	if key == 'b' and firstperson then
		battlemode = not battlemode
	elseif key == 'v' then
		firstperson = not firstperson
		if not firstperson then
			battlemode = false
		end
	else
		if enginedeb<tick() then
			if key == 'z' and engineon==false then
				enginedeb=tick()+5
				engineon=true
				script.EngineEvent:FireServer(engineon)
			elseif key == 'x'and engineon==true then
				enginedeb=tick()+5
				engineon=false
				script.EngineEvent:FireServer(engineon)
			end
		end
	end
end)

local mousebutton1down = false

mouse.Button1Down:connect(function()
	if tieheat == 100 then
		return
	end
	local id = math.random()
	mousebutton1down=id
	while mousebutton1down==id do
		if tieheat == 100 or shootdebounce>tick() then
			break
		end
		shoot()
		wait(.15)
	end
	--_G.RenderTieBullets(tie.LeftMachineGun,tie.RightMachineGun,hit1,hit2,print)
end)
mouse.Button1Up:connect(function()
	mousebutton1down=false
end)

mouse.Button2Down:connect(function()
	b2d=true
end)
mouse.Button2Up:connect(function()
	b2d=false
end)

script.Exit.OnClientEvent:Connect(function()
	--_G.VehicleHealth.Disable()
	InputChangedConn:disconnect()
	rs:disconnect()
	for i,v in pairs(transparency) do
		i.Transparency=v
	end
	mousegui:Destroy()
	bodygyro:Destroy()
	cc:Destroy()
	bodyvelocity:Destroy()
	workspace.CurrentCamera.FieldOfView = 70
	uis.MouseIconEnabled = true
	uis.MouseBehavior = Enum.MouseBehavior.Default
	script:Destroy()
end)

screech:Play()


script:WaitForChild('IndicateDamage').OnClientEvent:connect(function(cf)
	game:service'ReplicatedStorage':WaitForChild'DamageIndicator':Fire(cf)
end)

script.Alarm:Play()