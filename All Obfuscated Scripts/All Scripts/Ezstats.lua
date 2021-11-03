--[[
	id: 2vWSxsYky8z93Qe3AtYnd
	name: Ezstats
	description: Ezstats External UI Script
	time1: 2021-05-06 18:34:07.932539+00
	time2: 2021-05-06 18:34:07.93254+00
	uploader: 2705
	uploadersession: 7mrWIrirlYBMgp7m1nM2EEaUJPd4a0
	flag: f
--]]

local EZSTATS_READY = false

local get=function(x)return game:GetService(x)end local players=get'Players'local ws=get'Workspace'local rs=get'ReplicatedStorage'local rus=get'RunService'local uis=get'UserInputService'local coregui=get'CoreGui'local http=get'HttpService'local ts=get'TeleportService'local lighting=get'Lighting'local plr=players.LocalPlayer local char=(plr and(plr.Character or plr.CharacterAdded:Wait())or nil)local hrp=plr and(char:WaitForChild'HumanoidRootPart')or nil local hum=plr and(char:WaitForChild'Humanoid')or nil if plr then plr.CharacterAdded:Connect(function(c)char=c hrp=c:WaitForChild'HumanoidRootPart'hum=c:WaitForChild'Humanoid'end)end local cf=CFrame local v3=Vector3 local ud2=UDim2 local c3=Color3 local rgb=c3.fromRGB local step=rus.Stepped local rstep=rus.RenderStepped local heartbeat=rus.Heartbeat local function bind(k,callback)return uis.InputBegan:Connect(function(io,gpe)if Enum.UserInputType[k]then if io.UserInputType==Enum.UserInputType[k]then callback()end elseif Enum.KeyCode[k]then if io.KeyCode==Enum.KeyCode[k]then callback()end end end)end local function bindToStep(callback,doDebounce,debounceWait)local debounce=false step:Connect(function()if not debounce then debounce=doDebounce==nil callback()if debounceWait and doDebounce then wait(debounceWait)end debounce=false end end)end local function bindToRenderStep(callback,doDebounce,debounceWait)local debounce=false rstep:Connect(function()if not debounce then debounce=doDebounce==nil callback()if debounceWait and doDebounce then wait(debounceWait)end debounce=false end end)end local function bindToHeartbeat(callback,doDebounce,debounceWait)local debounce=false heartbeat:Connect(function()if not debounce then debounce=doDebounce==nil callback()if debounceWait and doDebounce then wait(debounceWait)end debounce=false end end)end local JSON={stringify=function(...)return http:JSONEncode(...)end;parse=function(...)return http:JSONDecode(...)end;}
local tws = get'TweenService'
local stats = get('Stats')
local plrgui = plr:WaitForChild('PlayerGui')
local mouse = plr:GetMouse()
local models = ws.Models
local values = rs.Values
local carrier = values.Carrier
local status = values.Status
local playtype = values.PlayType
local thrown = values.Thrown
local qb = values.QB
local cc = ws.CurrentCamera
local finishLine = models.LockerRoomA.FinishLine
local initVoting = plrgui.MainGui.InitVoting
local mainRemote = rs.Remotes.CharacterSoundEvent
local function getPing()
	return stats.PerformanceStats.Ping:GetValue()
end
local function getServerPing()
	return stats.Network.ServerStatsItem['Data Ping']:GetValue()
end
local function getPosInXSeconds(currentPos,direction,speed,seconds)
	local dist = speed * seconds
	local pos = currentPos+direction*dist
	return pos
end
local function getTime(dist,speed)return dist/speed end
local function getJumpHeightFromJumpPower()return hum.JumpPower^2/(2*ws.Gravity)end
local function removeVectorComponent(vector,component) if component:lower()=='y'then return vector*v3.new(1,0,1)elseif component:lower()=='x'then return vector*v3.new(0,1,1)elseif component:lower()=='z'then return vector*v3.new(1,1,0)end end
local function jump()
	hum.Jump = true
    keypress(0x20)
	wait()
    keyrelease(0x20)
end
-- websocket --
coroutine.resume(coroutine.create(function()
	if syn then
		repeat wait() until EZSTATS_READY
		local ws = syn.websocket.connect('ws://localhost:65535/')
		ws:Send('Connected!')
		ws.OnMessage:Connect(function(msg)
			local func, err = loadstring(msg)
			if err then
				warn(err)
			else
				func()
			end
		end)
	elseif pebc_execute then
		repeat wait() until EZSTATS_READY
		local ws = WebSocket.new('ws://localhost:65535/')
		ws:Send('Connected!')
		ws.OnMessage = function(msg)
			local func, err = loadstring(msg)
			if err then
				warn(err)
			else
				func()
			end
		end
	end
end))

wait(.1)

--[[ char.Humanoid.Died:Connect(function()
    game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId,game.JobId)
end) ]]



-- Default Values --
getgenv().ezstats = {
    catchreach = 0,
    mags_enabled = false,
    autoTacklePersuitEnabled = false,
    QbAimbotEnabled = false,
    kickerAimbotEnabled = false,
    walkspeed = 0,
    jumppower = 0,
	walkspeed_enabled = false,
	jumppower_enabled = false,
    autoblock_enabled = false,
    catchreach_offset = 0,
    nobounds_enabled = false,
    kickPower = 9.5,
	fly_enabled = false,
	flyspeed = 1,
	fly_keybind = 'F',
	tacklereach_enabled = false,
    tacklereach = 5,
    tacklereach_rate = 5,
	tacklereach_wait = .5,
	followcarrier_enabled = false,
	followcarrier_posUpdateDelay = .5,
	followcarrier_randomDelay = .5,
	followcarrier_randomFactorMin = -.25,
	followcarrier_randomFactorMax = 2,
	alwaysCanDive = false,
	divePowerEnabled = false,
	divePower = 0,
	antiCameraBlock = false,
	antiJam_enabled = false,
	ballTP_enabled = false,
	autoFlyToBall_maxDist = 35,
	autoFlyToBall_aggressiveness = 30,
	autoFlyToBall_dampening = 1,
	autoFlyToBall_inFrontDist = 50,
	ballTP_enabled = false,
	ballTP_maxDist = 15,
	ballTP_inFrontDist = 1,
	ballTP_delay = .05,
	ballTP_retryDelay = 1,
	spamdab = false,
	autocap = false,
	blockRangeEnabled = false,
	blockRange = 5,
	ballTP_method = 'Teleport',
	antiAdminEnabled = false,
	antiAdminMode = 'rejoin',
	antiAdminIgnoreList = {},
	instaScoreEnabled = false,
	autoJumpEnabled = false
}





-- ANTI ADMIN ---------------------------------------------------------------
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.antiAdminEnabled
	local admins = JSON.parse(game:HttpGet('http://ezstats.xyz/ff-admins',true))
	local function onAdminFound(admin)
		if ezstats.antiAdminEnabled then
			if ezstats.antiAdminMode == 'serverhop' then
				local f = ((syn and syn.queue_on_teleport) or queue_on_teleport or function()ts:Teleport(game.PlaceId)end)
				f("game.Loaded:wait()getgenv().adminName='" .. admin.Name .. "'loadstring(game:HttpGet('https://pastebin.com/raw/VLLCkQHt',true))()wait(15)game:GetService'TeleportService':Teleport(3694166020)")
				ts:Teleport(4996024512)
			elseif ezstats.antiAdminMode == 'rejoin' then
				ts:TeleportToPlaceInstance(game.PlaceId,game.JobId)
			end
		end
	end
	local function isAdmin(player)
		for _,v in pairs(admins) do
			if v.UserId == player.UserId and not ezstats.antiAdminIgnoreList[v.UserId] and not ezstats.antiAdminIgnoreList[v.Username] then
				return true
			end
		end
		return false
	end
	for _,v in pairs(players:GetPlayers()) do
		if isAdmin(v) then
			onAdminFound(v)
		end
	end
	players.PlayerAdded:Connect(function(player)
		if isAdmin(player) then
			onAdminFound(player)
		end
	end)
end))
-----------------------------------------------------------------------------








-- Functions
local function create(class,parent,props,children)
	props = props or {}
	children = children or {}
	parent = parent or nil
	local thing = Instance.new(class,parent)
		for i,v in pairs(props) do
		thing[i] = v
	end
	for _,v in pairs(children) do
		v.Parent = thing
	end
	return thing
end

-------------------------------

-- Bypass WalkSpeed and JumpPower Detection --
local ACBYPASS_HASRUN = false
local function ACBYPASS()
	if ACBYPASS_HASRUN then return end
	if not ACBYPASS_HASRUN then
		ACBYPASS_HASRUN = true
		local checkfunc = is_synapse_function or is_protosmasher_closure or function()return false end
		local gc = syn and getgc(true) or get_gc_objects()
		for i,v in next,gc do
			if type(v) == 'function' and islclosure(v) and not checkfunc(v) then
				for k,x in next,getconstants(v) do
					if x and tonumber(x) and ((tonumber(x) > 19 and tonumber(x) < 21) or (tonumber(x) > 49 and tonumber(x) < 51) )  then
						setconstant(v,k,100)
					end
				end
			end
		end
	end
end

ACBYPASS()

-- WalkSpeed --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.walkspeed_enabled
	while wait(.25) do
		if ezstats.walkspeed_enabled then
			if hum.WalkSpeed ~= math.clamp(ezstats.walkspeed,20,43) then
				hum.WalkSpeed = math.clamp(ezstats.walkspeed,20,43) -- max: 43
			end
		elseif hum.WalkSpeed > 20 then
			hum.WalkSpeed = 20
		end
	end
end))
-- JumpPower --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.jumppower_enabled
	while wait(.25) do
		if ezstats.jumppower_enabled then
			if hum.JumpPower ~= math.clamp(ezstats.jumppower,50,80) then
				hum.JumpPower = math.clamp(ezstats.jumppower,50,80) -- max: 80
			end
		elseif hum.JumpPower > 50 then
			hum.JumpPower = 50
		end
	end
end))

-- Tackle Reach --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.tacklereach_enabled
	while rstep:wait() do
		local lastpos = hrp.CFrame
		local bc = values.Carrier.Value
		if ezstats.tacklereach_enabled and values.Carrier.Value and values.Status.Value == 'InPlay' and bc and bc.Team ~= plr.Team and bc.Character and bc.Character:FindFirstChild('Humanoid') and bc.Character:FindFirstChild('HumanoidRootPart') then
			local char2 = bc.Character
			local hrp2 = char2:FindFirstChild('HumanoidRootPart')
			local hum2 = char2:FindFirstChild('Humanoid')
			local lastpos = hrp.CFrame
			local dist = (hrp.Position - hrp2.Position).Magnitude
			if dist <= ezstats.tacklereach then
				local pos = hrp2.Position+(hum2.MoveDirection*2)
				hrp.CFrame = CFrame.new(pos)
				wait(1/ezstats.tacklereach_rate)
				local diff = (hrp.Position-lastpos.p)
				hrp.CFrame = hrp.CFrame-diff
			end
			wait(ezstats.tacklereach_wait)
		end
	end
end))

-- Spam Dab (normal) --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.spamdab
	local anims = rs.Animations
	local dab = anims.Dab
	local track = hum:LoadAnimation(dab)
	local madeplay = false
	local mainGui = plr.PlayerGui.MainGui
	local debounce = false
	while true do
		if ezstats.spamdab then
			track = track or hum:LoadAnimation(dab)
			track:Play()
			track:AdjustSpeed(1)
			wait(0.15)
			track:Stop()
		else
			wait(.1)
		end
	end
end))

-- Auto tackle presuit --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.autoTacklePersuitEnabled
	while step:wait() do
		if ezstats.autoTacklePersuitEnabled then
			local bc = carrier.Value
			if bc and bc.Team ~= plr.Team and status.Value == 'InPlay' then
				local char2 = bc.Character
				if char2 then
					local hum2 = char2:FindFirstChild('Humanoid')
					local hrp2 = char2:FindFirstChild('HumanoidRootPart')
					if hum2 and hrp2 then
						--cc.CameraType = Enum.CameraType.Scriptable
						cc.CFrame = CFrame.new(cc.CFrame.p+v3.new(0,1,0),hrp2.Position)
						--cc.CameraType = Enum.CameraType.Custom
					end
				else
					wait(.25)
				end
			else
				wait(.25)
			end
		else
			wait(.25)
		end
	end
end))

-- Auto get up --
--[[ spawn(function()
    local function getup()
        if char then
            local hum = char:FindFirstChild('Humanoid')
            if hum then
                for _=1,10 do
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end
        end
    end
    while wait(0.5) do
        if ezstats.autogetup_enabled then
            getup()
        end
    end
end) ]]

-- No bounds --
coroutine.resume(coroutine.create(function()
    repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.nobounds_enabled
	while wait() do
		local s,e = pcall(function()
			if ezstats.nobounds_enabled then
				local bounds = workspace.Models:FindFirstChild('Boundaries')
				bounds:ClearAllChildren()
			end
		end)
		if not s then warn(e) end
	end
end))

-- FF forward pass script (throw the ball after you pass the line of scrimmage) --
coroutine.resume(coroutine.create(function()
    repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.illegalForwardPass_enabled
    local wall = workspace:WaitForChild('LineDownWall')
    local _wall = wall:Clone()
    _wall.Parent = workspace
    while wait() do
		_wall.Position = workspace:WaitForChild('LineDown').Position
		_wall.CanCollide = values.Status.Value == 'PrePlay'
        local hasball = (values.QB.Value == plr and values.Carrier.Value == plr)
        if ezstats.illegalForwardPass_enabled and wall and hasball and values.Status.Value == 'InPlay' then
            wall.Parent = nil
        else
            wall.Parent = workspace
        end
    end
end))

-- Autoblock
coroutine.resume(coroutine.create(function()
    repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.autoblock_enabled
    char:WaitForChild('BlockPart')

	local function modifyBlockRange(range)
		if char and hum and hrp then
			local blockPart = char:WaitForChild('BlockPart')
			if blockPart then
				blockPart.Size = Vector3.new(0.5,0.5,1)*range
			end
		end
	end

    --modifyBlockRange(20)
    
    local held = false
    local locked = false
    
    uis.InputBegan:Connect(function(k,gpe)
        if not gpe and k.KeyCode == Enum.KeyCode.X then
            held = true
        end
    end)

    uis.InputEnded:Connect(function(k)
        if k.KeyCode == Enum.KeyCode.X then
            held = false
        end
    end)
    
    local function blockPlr(plrname)
        modifyBlockRange(30)
        local plr2 = players:FindFirstChild(plrname)
        if plr2 then
            if --[[ values.Carrier.Value and ]] values.Status.Value == 'InPlay' and char and hrp and (not char:FindFirstChild('Football')) and plr2.Character and plr2.Character:FindFirstChild('HumanoidRootPart') then

                local hrp2 = plr2.Character:FindFirstChild('HumanoidRootPart')
            

                local distFromPlayer = (hrp2.Position-hrp.Position).Magnitude
                if distFromPlayer <= 15 then
                    local lv = hrp2.CFrame.lookVector*10
                    local pos1 = hrp.Position
                    --[[ if ((distFromPlayer <= 5 and held) == true) or ((locked and held and distFromPlayer <= 15) == true) then
                        if not locked then
                            locked = true
                        end
                        if not held then locked = false end
                        local pos2 = hrp2.Position+(lv.Unit*7)
                        pos2_dist = (hrp.Position - pos2).Magnitude
                        pos1 = ((pos2_dist <= 7 and pos2) or hrp2.Position)
                    end ]]
                    --hrp.CFrame = CFrame.new(pos1,hrp.Position+Vector3.new(-lv.X,0,-lv.Z))
                    local lastpos = hrp.Position
					--[[ for i=1,10 do ]]
						local cf1 = CFrame.new(pos1,v3.new(lastpos.X,hrp.Position.Y,lastpos.Z)+v3.new(-lv.X,0,-lv.Z))
						hrp.CFrame = cf1--hrp.CFrame:Lerp(cf1,i)
						--[[ rstep:wait()
					end ]]

                    mainRemote:fireServer("PlayerActions", "execBlock", plrname, 'Torso',nil);
                    mainRemote:fireServer("PlayerActions", "block",nil)
                    step:wait()
                    mainRemote:fireServer("PlayerActions", "blockTouchEnded", nil);
                end
            end
        end
        wait()
        modifyBlockRange(0)
    end
    
    local debounce = false
    
    while rstep:wait() do
        if not debounce then
            debounce = true
            if ezstats.autoblock_enabled then
                for i,v in pairs(players:GetPlayers()) do
                    if v.Team ~= plr.Team then
                        blockPlr(v.Name)
						rstep:wait()
                    end
                end
            end
            wait()
            debounce = false
        end
    end
end))

-- Block Range
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.blockRangeEnabled
    char:WaitForChild('BlockPart')
	local function modifyBlockRange(range)
		if char and hum and hrp then
			local blockPart = char:WaitForChild('BlockPart')
			if blockPart then
				blockPart.Size = Vector3.new(0.5,0.5,1)*range
			end
		end
	end
	while wait() do
		if ezstats.blockRangeEnabled then
			if char:WaitForChild('BlockPart').Size ~= Vector3.new(0.5,0.5,1)*ezstats.blockRange then
				modifyBlockRange(ezstats.blockRange)
			end
		else
			modifyBlockRange(10)
			wait()
		end
	end
end))

-- QB AIMBOT
coroutine.resume(coroutine.create(function()
    repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.QbAimbotEnabled
    local function throw(pos)
        if char and hum then
            local throwAnim = nil
            if hum then
                throwAnim = hum:LoadAnimation(rs.Animations.Throw)
                throwAnim.Name = "Throw"
            end
            local fbtool = char:WaitForChild('Football')
            local ballgui = plr.PlayerGui:FindFirstChild('BallGui') or fbtool.Handle.LocalScript.BallGui:Clone()
            local power = tonumber(ballgui:WaitForChild('Frame'):WaitForChild('Disp').Text or '80') or 80
            fbtool.Equipped:connect(function(p4)
                pos = pos or p4.Hit.p
                local Head14 = char:WaitForChild("Head")
                if Head14 and not throwAnim.IsPlaying and not hum.PlatformStand then
                    throwAnim:Play()
                    --wait(0.1)
                    --ballgui:Destroy()
                    local FireServer1 = fbtool:WaitForChild('Handle'):WaitForChild('RemoteEvent').FireServer
                    FireServer1(fbtool:WaitForChild('Handle'):WaitForChild('RemoteEvent'), "Clicked", Head14.CFrame.p, pos, power)
                end
            end)
        end
    end
    
    local function throwToPlayer(player)
        local char2 = player.Character
        local root2 = char2.HumanoidRootPart
        local mag = (char.HumanoidRootPart.CFrame.p - root2.CFrame.p).Magnitude
        local pos = root2.CFrame.p+char2.Humanoid.MoveDirection*30
        pos = pos+v3.new(0,mag,0)
        local success,err = pcall(function()
            throw(pos)
        end)
        if not success then
            warn(err)
        end
    end
    
    local selectionPart = Instance.new('Part')
    
    selectionPart.CanCollide = false
    selectionPart.Anchored = true
    selectionPart.Transparency = 0.75
    selectionPart.Size = v3.new(5,5,5)
    selectionPart.Material = Enum.Material.Neon
    selectionPart.Color = c3.new(1,0,0)
    
    local selection = nil
    
    local selectionPart_transparency = selectionPart.Transparency
    
    rstep:Connect(function()
        local success,err = pcall(function()
            if selection and values.Status.Value == 'InPlay' and values.QB.Value == plr then
                if selection:IsA('Part') then
                    selectionPart.Transparency = selectionPart_transparency
                    if ezstats.QbAimbotEnabled then
                        selectionPart.Parent = workspace
                        for _=1,10 do
                            selectionPart.CFrame = selection.CFrame
                        end
                    else
                        selectionPart.Transparency = 1
                    end
                end
            else
                selectionPart.Transparency = 1
            end
        end)
        if not success then warn(err) end
    end)
    
	local function ClosestPlayerToMouse()
		local target = nil
		local dist = math.huge
		for i,v in pairs(players:GetPlayers()) do
			if v.Name ~= plr.Name then
				if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.Team == plr.Team then
					local screenpoint = cc:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
					local check = (Vector2.new(mouse.X,mouse.Y)-Vector2.new(screenpoint.X,screenpoint.Y)).magnitude
					if check < dist then
						target  = v
						dist = check
					end
				end
			end
		end
		return target 
	end
    
    rstep:Connect(function()
        local success,err = pcall(function()
            if values.Status.Value == 'InPlay' and values.QB.Value ~= nil then
                if values.QB.Value == plr then
                    local targetplr = ClosestPlayerToMouse()
                    local char2 = targetplr.Character
                    if char2 then
                        if char2:FindFirstChild('Humanoid') then
                            selection = char2.HumanoidRootPart
                        end
                    end
                end
            end
        end)
        if not success then warn(err) end
    end)
    
    uis.InputBegan:Connect(function(k,gpe)
        if not gpe then
            if k.UserInputType == Enum.UserInputType.MouseButton1 and ezstats.QbAimbotEnabled then
                local teammates = {}
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v.Team == plr.Team and v ~= plr then
                        table.insert(teammates,v)
                    end
                end
                if rs.Values.Status.Value == 'InPlay' and rs.Values.QB.Value == plr then
                    local success,err = pcall(function()
                        throwToPlayer(getnearestplrtomouse())
                    end)
                    if not success then
                        warn(err)
                    end
                end
            end
        end
    end)
    
    local last = ezstats.QbAimbotEnabled
end))

-- Kicker Aimbot
coroutine.resume(coroutine.create(function()
    repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.kickerAimbotEnabled
	local function playclick()
		values.Ball.Value.RemoteEvent:fireServer('PlayClick')
	end
	local click_func = mouse1click or leftpress or(Input and Input.LeftClick()) or playclick
	local mousemove = mousemoveabs or function()end
	local function kick()
		if ezstats.kickerAimbotEnabled then
			repeat step:wait() until plr.PlayerGui:FindFirstChild('KickerGui')
			local kickerGui = plr.PlayerGui:FindFirstChild('KickerGui')
			local meter = kickerGui:FindFirstChild('Meter')
			local cursor = meter:FindFirstChild('Cursor')
			local mid = workspace.CurrentCamera.ViewportSize*Vector2.new(0.5,0.5)
			mousemove(mid.X,mid.Y)
			click_func()
			repeat step:wait() until cursor.Position.Y.Scale < 0.01--cursor.Position.Y.Scale == math.clamp(cursor.Position.Y.Scale,.001,.005)
			cursor.Position = UDim2.new(0,0,0.01,0)
			click_func()
			repeat step:wait() until cursor.Position.Y.Scale > .85
			cursor.Position = UDim2.new(0,0,0.9,0)
			click_func()
		end
	end
	if plr.PlayerGui:FindFirstChild('KickerGui') then wait(2) kick() end
	plr.PlayerGui.ChildAdded:Connect(function(c)
		if c.Name == 'KickerGui' then
			wait(2)
			kick()
		end
	end)
end))

-- Auto Hands
coroutine.resume(coroutine.create(function()
    repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.AutoHands
    while rstep:wait() do
		pcall(function()
			local fb = ws:FindFirstChild('Football')
			if fb then
				if values.Status.Value == 'InPlay' and values.QB.Value ~= plr and values.PlayType.Value == 'normal' and (hrp.Position - fb.Position).Magnitude <= 35 and ezstats.AutoHands then
					local controlsModule = require(plr.PlayerScripts.ClientMain.GameControls)
					controlsModule.Catch(nil,false)
				end
			elseif ezstats.AutoHands and values.Carrier.Value and values.QB.Value and values.QB.Value == values.Carrier.Value and values.Carrier.Value.Team ~= plr.Team and (values.QB.Value.Character.HumanoidRootPart.Position-hrp.Position).Magnitude <= 30 then
				repeat step:wait() until thrown.Value
			end
		end)
    end
end))

-- Mags
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.mags_enabled
    local Settings = {
        auto = false; -- If true, it will mag the ball automatically when it is near.
        maxDist = 100;
        minDist = 5;
    }
    Settings.minDist = Settings.minDist or 5
    Settings.maxDist = Settings.maxDist or 50
	local magpart = Instance.new('Part',workspace)
	magpart.Anchored = true
	magpart.CanCollide = false
	magpart.Size = v3.new(5,5,5)
	magpart.Transparency = 1
	magpart.Color = rgb(0,255,180)
	magpart.Name = ' '
	spawn(function()
		while wait() do
			if char and hrp and hum then
				magpart.CFrame = CFrame.new(hrp.Position)
			end
			if not magpart then
				magpart = Instance.new('Part',workspace)
				magpart.Anchored = true
				magpart.CanCollide = false
				magpart.Size = v3.new(5,5,5)
				magpart.Transparency = 1
				magpart.Color = rgb(0,255,180)
				magpart.Name = ' '
			end
		end
	end)
	local defaultCatchPartSize = char:WaitForChild('CatchRight').Size
	local function reset_catchpart()
		local catchRight = char:WaitForChild('CatchRight')
		local catchLeft = char:WaitForChild('CatchLeft')
		catchRight.Size = defaultCatchPartSize
		catchLeft.Size = defaultCatchPartSize
	end
	local function resize_catchpart(s)
		local catchRight = char:WaitForChild('CatchRight')
		local catchLeft = char:WaitForChild('CatchLeft')
		catchRight.Size = Vector3.new(s,s,s)
		catchLeft.Size = Vector3.new(s,s,s)
	end
	--reset_catchpart()
	plr.CharacterAdded:Connect(function()
		reset_catchpart()
	end)
	local function mag()
		if qb.Value == plr then return resize_catchpart(0) end
		local magging = true
		if not executedCount == getgenv().executed_count then return resize_catchpart(0) end
		local football = workspace:FindFirstChild('Football')
		if not football or values.Status.Value ~= 'InPlay' then return resize_catchpart(0) end
		--require(plr.PlayerScripts.ClientMain.GameControls).Catch(false)
		local ffbodyf = football:FindFirstChild('FFbodyf')
		if ffbodyf then
			ffbodyf:Destroy()
		end
		football.Size = v3.new(50,50,50)
		local atthrp = Instance.new('Attachment',magpart)
		atthrp.Position = Vector3.new(0,0,0)
		local att2 = Instance.new('Attachment',football)
		att2.Position = Vector3.new(0,0,0)
		local rope = Instance.new('RopeConstraint',magpart)
		rope.Attachment0 = att2
		rope.Attachment1 = atthrp
		rope.Restitution = 0
		rope.Thickness = 1
		rope.Visible = false
		rope.Length = .1
		repeat step:wait() until not football or football.Parent ~= workspace
		pcall(function()
			resize_catchpart(50)
		end)
		rope:Destroy()
		att2:Destroy()
		atthrp:Destroy()
		magging = false
		--print(rope ~= nil)
	end
	uis.InputBegan:Connect(function(k,gpe)
		if not gpe and k.KeyCode == Enum.KeyCode.C or k.UserInputType == Enum.UserInputType.MouseButton1 then
			if ezstats.mags_enabled then
				mag()
			end
		end
	end)
end))

-- FLY
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.fly_enabled
	local debris = get('Debris')
	local adminRE = rs:WaitForChild("Remotes"):WaitForChild("AdminRE")
	local flying = false
	-- Connections --
	local getconn = getconnections or get_signal_connections
	if getconn then
		local disconnect_all = disconnect_all or function(signal)
			for i,v in next,getconn(signal) do
				v:Disable()
			end
		end
		disconnect_all(char.ChildAdded)
		disconnect_all(char.DescendantAdded)
		disconnect_all(hum.ChildAdded)
		disconnect_all(hum.DescendantAdded)
		disconnect_all(hrp.ChildAdded)
		disconnect_all(hrp.DescendantAdded)
		wait()
	end
	local noclip_conn = nil
	local fly_conn = nil
	local flying = false
	local bv = nil
	local bg = nil
	local emptyVector3 = Vector3.new()
	local v3_Y1 = Vector3.new(0, 1, 0)
	local noclip_conn = nil
	local function disable_fly()
		flying = false
		debris:AddItem(bv, 0)
		debris:AddItem(bg, 0)
		if fly_conn then fly_conn:Disconnect() end
		if char and char:FindFirstChild("Animate") then
			char.Animate.Disabled = false
		end
	end
	local function fly()
		if fly_conn then fly_conn:Disconnect() end
		flying = true
		for _, v in ipairs(hum:GetPlayingAnimationTracks()) do
			v:Stop()
		end
		if char and char:FindFirstChild("Animate") then
			char.Animate.Disabled = true
		end
		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1, 1, 1) * 1000000
		bv.P = 1000000
		bv.Velocity = Vector3.new()
		bv.Name = "FFmover"
		bg = Instance.new("BodyGyro", hrp)
		bg.MaxTorque = Vector3.new(1, 1, 1) * 1000000
		bg.P = 1000000
		bg.D = 1000
		bg.CFrame = hrp.CFrame
		bg.Name = "FFmover"
		fly_conn = step:Connect(function()
			local camCF = cc.CFrame
			local md = hum.MoveDirection
			if md ~= emptyVector3 then
				local lv = camCF.lookVector
				local speedUnit = (CFrame.new(emptyVector3, md) * CFrame.Angles(math.pi / 2 * lv.Y * (md:Dot(camCF.upVector) * math.sign(-lv.Y)), 0, 0)).lookVector
				if hum.Jump then
					speedUnit = speedUnit + v3_Y1
				end
				bv.Velocity = speedUnit * hum.WalkSpeed * 2 * ezstats.flyspeed
			elseif hum.Jump then
				bv.Velocity = v3_Y1 * hum.WalkSpeed * 2 * ezstats.flyspeed
			else
				bv.Velocity = bv.Velocity * 0.9
			end
			bg.CFrame = camCF
		end)
	end
	coroutine.resume(coroutine.create(function()
		while wait() do
			plr.CameraMode = flying and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
			if not ezstats.fly_enabled and fly_conn then
				disable_fly()
			end
		end
	end))
	plr.CharacterAdded:Connect(function()
		wait(.1)
		if ezstats.fly_enabled then
			if flying then
				fly()
			else
				disable_fly()
			end
		end
	end)
	local function toggleFly()
		if ezstats.fly_enabled then
			if not flying then
				fly()
			else
				disable_fly()
			end
		end
	end
	uis.InputBegan:Connect(function(k,gpe)
		if not gpe and k.KeyCode == Enum.KeyCode[ezstats.fly_keybind] and ezstats.fly_enabled then
			toggleFly()
		end
	end)
end))

-- Anti Jam --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.antiJam_enabled
	local function setCollisionsForPart(v)
		coroutine.resume(coroutine.create(function()
			local isBasePart,_ = pcall(function()
				return v.CanCollide
			end)
			if isBasePart then
				local oldCanCollide = v.CanCollide
				while step:wait() and v:IsA('BasePart') do
					local enabled = ezstats and ezstats.antiJam_enabled or getgenv().antiJam_enabled
					if enabled and ws:FindFirstChild('Football') and status.Value == 'InPlay' and playtype.Value ~= 'fieldgoal' then
						v.CanCollide = false
					else
						v.CanCollide = oldCanCollide
					end
				end
			end
		end))
	end
	local function disablePlayerCollisions(player)
		local function disableCharacterCollisions(char2)
			for _,v in ipairs(char2:GetDescendants()) do
				if v:IsA('BasePart') then
					setCollisionsForPart(v)
				end
			end
			char2.DescendantAdded:Connect(function(v)
				setCollisionsForPart(v)
			end)
		end
		disableCharacterCollisions(player.Character or player.CharacterAdded:Wait())
		player.CharacterAdded:Connect(disableCharacterCollisions)
	end
	for _,v in pairs(players:GetPlayers()) do
		if v ~= plr then
			disablePlayerCollisions(v)
		end
	end
	players.PlayerAdded:Connect(disablePlayerCollisions)
end))

-- Auto Follow Carrier --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.followcarrier_enabled
	local randomFactor = 1
	coroutine.resume(coroutine.create(function()
		while true do
			if ezstats.followcarrier_randomFactorMin == 0 or ezstats.followcarrier_randomFactorMax == 0 then
				randomFactor = 0
			else
				local s,e = pcall(function()
					randomFactor = math.random(-ezstats.followcarrier_randomFactorMin,ezstats.followcarrier_randomFactorMax)
				end)
				if not s then randomFactor = 0 warn(e) end
			end
			wait(ezstats.followcarrier_randomDelay)
		end
	end))
	local function getTacklePos()
		local plr2 = carrier.Value
		if plr2 and status.Value == 'InPlay' then
			local char2 = plr2.Character
			if char2 then
				local hum2 = char2:FindFirstChild('Humanoid')
				local hrp2 = char2:FindFirstChild('HumanoidRootPart')
				local dist = (hrp2.Position-hrp.Position).Magnitude
				if dist > 30 then
					return hrp2.Position
				end
				local ping = getPing()+getServerPing()
				local time = getTime(dist,hum.WalkSpeed)+(ping/1000)
				local pos = getPosInXSeconds(hrp2.Position,hum2.MoveDirection,hum2.WalkSpeed+randomFactor,time)
				return pos
			end
		end
	end
	while wait(ezstats.followcarrier_posUpdateDelay) do
		local isQB = (qb.Value == plr and char:FindFirstChild('Football'))
		if ezstats.followcarrier_enabled then
			if carrier.Value and carrier.Value.Team ~= plr.Team and carrier.Value ~= plr and status.Value == 'InPlay' and not isQB then
				local pos = getTacklePos()
				hum:MoveTo(pos)
			end
		end
	end
end))

-- Dive Power --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.divePowerEnabled
	local torso = char:WaitForChild('Torso')
	local lastVel = torso.Velocity
	local debounce = false
	uis.InputBegan:Connect(function(k,gpe)
		if ezstats.divePowerEnabled and not gpe and k.KeyCode == Enum.KeyCode.E and not debounce and hum:GetState() == Enum.HumanoidStateType.Freefall then
			debounce = true
			local bf = create('BodyForce',hrp,{Name='FFmover'})
			local pow = ezstats.divePower/100*200
			bf.Force = torso.Velocity*Vector3.new(pow,0,pow)
			local t = tick()
			repeat step:wait() until hrp.Position.Y <= 3.5 or tick() - t >= 3
			bf:Destroy()
			debounce = false
		end
	end)
end))

-- Auto Teleport To Football --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.ballTP_enabled
	local function getball() return workspace:FindFirstChild('Football') end
	while step:wait() do
		if ezstats.ballTP_enabled then
			pcall(function()
				char['Catch Left'].Size = char['Catch Left'].Size.Unit*10
				char['Catch Right'].Size = char['Catch Right'].Size.Unit*10
			end)
			local balltppart = create('Part',ws,{
				Anchored = true,
				CanCollide = false,
				Transparency = 1,
				Size = v3.new(1,1,1)
			})
			local fb = getball()
			local function check1()
				return getball() and status.Value == 'InPlay' and qb.Value ~= plr
			end
			if check1() and (fb.Position-hrp.Position).Magnitude <= ezstats.ballTP_maxDist then
				balltppart.Position = fb.Position
				fb.Size = fb.Size.Unit*10
				local p1 = fb.Position
				wait(.1)
				local p2 = fb.Position
				local dir = (p2-p1).Unit
				local ping = getPing()*2+getServerPing()
				local att0 = create('Attachment',hrp)
				local att1 = create('Attachment',balltppart,{
					Position = pos
				})
				local rope = create('RopeConstraint',balltppart,{
					Length = 0,
					Restitution = 0,
					Attachment0 = att0,
					Attachment1 = att1,
					Enabled = true
				})
				repeat
					if playtype.Value == 'normal' then
						local p1 = fb.Position
						wait(.1)
						local p2 = fb.Position
						local dir = (p2-p1).Unit
						local pos = getPosInXSeconds(fb.Position,dir,fb.Velocity.Magnitude,ping/1000)
						balltppart.Position = pos
					else
						balltppart.Position = fb.Position
					end
					step:wait()
				until status.Value == 'DeadPlay' or not getball()
				att0:Destroy()
				att1:Destroy()
				rope:Destroy()
				balltppart:Destroy()
			end
		end
	end
end))

-- Free Auto Captain --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.autocap
	local function toFinish()
		local pos = finishLine.Position
		local lookAt = finishLine.Position+finishLine.CFrame.lookVector*-100
		lookAt = v3.new(lookAt.X,hrp.Position.Y,lookAt.Z)
		hrp.CFrame = CFrame.new(pos+v3.new(0,10,0),lookAt)
		hum:MoveTo(finishLine.Position,finishLine)
	end
	while wait() do
		if ezstats.autocap then
			repeat step:wait() until finishLine.Position.Y ~= 0
			wait(0.5)
			toFinish()
			repeat wait() until finishLine.Position.Y == 0
		else
			wait(.25)
		end
	end
end))

-- Insta Score --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.instaScoreEnabled
	local instaScoreOffset = Vector3.new(0,-10,0)
	local goalline1 = ws.LineGoal1
	local goalline2 = ws.LineGoal2
	while wait() do
		if ezstats.instaScoreEnabled then
			if char:FindFirstChild('Football') and status.Value == 'InPlay' then
				hrp.CFrame = CFrame.new((goalline1.Position+goalline1.Size/2)+instaScoreOffset+v3.new(math.random(-1,1),0,math.random(-5,5)))
				wait(1)
				hrp.CFrame = CFrame.new((goalline2.Position+goalline2.Size/2)+instaScoreOffset+v3.new(math.random(-1,1),0,math.random(-5,5)))
				wait(1)
			end
		end
	end
end))

-- Auto Jump --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.autoJumpEnabled
	while rstep:wait() do
		if ezstats.autoJumpEnabled then
			local fb = ws:FindFirstChild('Football')
			if status.Value == 'InPlay' and fb then
				local fbpos = fb.Position
				if fbpos.Y >= 7 and fbpos.Y <= hrp.Position.Y+getJumpHeightFromJumpPower()+10 then
					local distXZ = ( removeVectorComponent(fb.Position,'Y') - removeVectorComponent(hrp.Position,'Y') ).Magnitude
					local distX = ( fb.Position*v3.new(1,0,0) - hrp.Position*v3.new(1,0,0) ).Magnitude
					local distZ = ( fb.Position*v3.new(0,0,1) - hrp.Position*v3.new(0,0,1) ).Magnitude
					if distX <= 10 and distZ <= fb.Position.Y then
						jump()
					end
				end
			end
		end
	end
end))

-- Anti Lag --
coroutine.resume(coroutine.create(function()
	repeat wait(.25) until EZSTATS_READY and ezstats and ezstats.antiLagEnabled
	local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
	local lighting = game.Lighting
	local t = workspace.Terrain
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	lighting.GlobalShadows = false
	lighting.FogEnd = 9e9
	lighting.Brightness = 0
	sethiddenproperty(lighting,'Technology',Enum.Technology.Compatibility)
	settings().Rendering.QualityLevel = "Level03"
	for i, v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif (v:IsA("Decal") or v:IsA("Texture") and decalsyeeted) and v.Parent.Name ~= 'Football' then
			v.Transparency = 1
		elseif (v:IsA("ParticleEmitter") or v:IsA("Trail")) and v.Parent.Name ~= 'Football' then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
			v.Enabled = false
		elseif v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.TextureID = 10385902758728957
		end
	end
	for i, e in pairs(lighting:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end
	workspace:WaitForChild('Models'):WaitForChild('Stadium'):Destroy()
	workspace:WaitForChild('SkyWeather'):Destroy()
end))

wait(.1)

-- Stuck on bench fix --
for _,v in pairs(ws.Models.Field.Sidelines:GetDescendants()) do
	if v:IsA('Seat') then
		v.Parent.Parent = nil
		--v:Destroy()
	end
end

-- Height Barrier --
create('Part',ws,{
	Name = ' ',
	Anchored = true,
	CanCollide = true,
	Transparency = 1,
	Size = v3.new(ws.Models.Field.Ground.Size.X,5,ws.Models.Field.Ground.Size),
	Position = v3.new(0,25,0)
})

wait(.1)
EZSTATS_READY = true

wait(.1)

step:Connect(function()
	plr.ReplicationFocus = ws
	settings().Physics.AllowSleep = false
	if setsimulationradius then setsimulationradius(math.huge,math.huge*math.huge) end
end)

wait()