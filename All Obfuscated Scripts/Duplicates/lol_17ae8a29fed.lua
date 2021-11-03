--[[
	id: P_fQpx1nTwaBRXk4xsXB_
	name: lol
	description: a
	time1: 2021-07-27 03:15:55.375905+00
	time2: 2021-07-27 03:15:55.375906+00
	uploader: rewkx8R5s1Hr6xFLdQwPyEnu3e3VmtElFPHXezmd
	uploadersession: u1JdBzGEvOSLlnPEZXUE37Zu36O2Mx
	flag: f
--]]

local nTree = 1
local Closest
local ClosestMag
local destination = Vector3.new()
local player = game.Players.LocalPlayer.Character.HumanoidRootPart
local Player1 = game.Players.LocalPlayer
local human = game.Players.LocalPlayer.Character.Humanoid
local Body = game.Players.LocalPlayer.Character.HumanoidRootPart
local data = game.ReplicatedStorage.Events.RequestData:InvokeServer()
local rep = game:service "ReplicatedStorage"
local eat = game.ReplicatedStorage.Events.UseBagItem
local playerGui = Player1:WaitForChild("PlayerGui")
_G.tree = false
_G.ping = 1000
local amt = 1
_G.Farming = true
_G.Pickup = true
local eatFirst = "Apple" -- this is what it will look to eat first
local foodMatch = {"cooked", "berry", "apple", "pear", "coconut", "fruit"}
-- local destination = Vector3.new(-545.23620605469, 312.95153808594, -1190.4654541016)
--local destination = game.Workspace.here.Position
--local destination2 = game.Workspace.XD.Position

local tweenService = game:GetService("TweenService")
local mainGui = playerGui:WaitForChild("MainGui")
local secondaryGui = playerGui:WaitForChild("SecondaryGui")
local spawnGui = playerGui:WaitForChild("SpawnGui")
local maxPrompts = 3
local noteSerializer = 1
local debris = game:GetService("Debris")

local createnotif = function(text, color, duration, delayTime)
    wait(delayTime or 0)
    duration = duration or 1
    local fadeLength = 2
    local totalNotes = #mainGui.Subordinates.Prompts.Feed:GetChildren() - 2
    if totalNotes >= maxPrompts then
        local lowestNote, noteLevel = nil, math.huge
        for _, v in next, mainGui.Subordinates.Prompts.Feed:GetChildren() do
            if v:IsA("TextLabel") then
                if v.LayoutOrder < noteLevel then
                    lowestNote, noteLevel = v, v.LayoutOrder
                end
            end
        end
        if lowestNote then
            lowestNote:Destroy()
        end
    end

    local notification = mainGui.Subordinates.Prompts.Templates.TextLabel:Clone()
    notification.Text = text
    notification.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    notification.LayoutOrder = noteSerializer
    noteSerializer = noteSerializer + 1

    -- if the number of Prompts is too large, remove the one with the lowest value
    notification.Parent = mainGui.Subordinates.Prompts.Feed
    notification.Visible = true
    debris:AddItem(notification, duration + fadeLength)

    local tweenInfo =
        TweenInfo.new(fadeLength, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, duration or 1)
    local goals = {
        BackgroundTransparency = 1,
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }
    local tween = tweenService:Create(notification, tweenInfo, goals)
    tween:Play()
end

local pathservice = game:GetService("PathfindingService")
wait()

_G.data = game.ReplicatedStorage.Events.RequestData:InvokeServer()
local itemData = require(game.ReplicatedStorage.Modules.ItemData)
local Player1 = game.Players.LocalPlayer

rep.Events.UpdateData.OnClientEvent:connect(
    function(newData)
        _G.data = newData
    end
)

-- for i,v in pairs(itemData["Apple Tree"].multiPickup) do
--     print(itemData[v].load)
--     end

getSpace = function()
    for i = 1, amt do
        for _, v in pairs(workspace.Deployables:GetChildren()) do
            if v.Name == "Campfire" then
                game.ReplicatedStorage.Events.InteractStructure:FireServer(v, "Leaves")
                game.ReplicatedStorage.Events.InteractStructure:FireServer(v, "Leaves")
                game.ReplicatedStorage.Events.InteractStructure:FireServer(v, "Leaves")
                game.ReplicatedStorage.Events.InteractStructure:FireServer(v, "Log")
                game.ReplicatedStorage.Events.InteractStructure:FireServer(v, "Log")
            end
        end
    end
end

Applebruh = function()
    local data = game.ReplicatedStorage.Events.RequestData:InvokeServer()
    for i, v in pairs(data.inventory) do
        if v.name == "Apple" then
            if v.quantity >= 200 then
                --	print("More than 200 apples")
                return true
            elseif v.quantity < 200 then
                --	print("Less than 200 apples")
                return false
            end
        end
    end
end

local CalculateLoad = function()
    local data = game.ReplicatedStorage.Events.RequestData:InvokeServer()
    local playerLoad = 0
    local maxLoad
    if data.armor.bag and data.armor.bag ~= "none" then
        maxLoad = itemData[data.armor.bag].maxLoad
    else
        maxLoad = 50
    end
    for _, v in next, data.inventory do
        if v.quantity and itemData[v.name] then
            playerLoad = playerLoad + (v.quantity * (itemData[v.name].load or 1))
        end
    end
    return playerLoad, maxLoad
end

CanBearLoad = function(itemName)
    local xd = 1
    local anticipatedLoad = 5
    local playerLoad, maxLoad = CalculateLoad()
    if (playerLoad + anticipatedLoad) <= maxLoad or anticipatedLoad == 0 then
        return true
    else
        return false
    end
end

function getFood()
    for i, v in next, _G.data.inventory do
        local name, quan = v.name, v.quantity
        if eatFirst and eatFirst:lower() == name:lower() then
            return name
        end
        for _, match in next, foodMatch do
            if name:lower():find(match) then
                return name
            end
        end
    end
end
local Pickup = function(Character)
    local Objects
    local myPos = Character.HumanoidRootPart.Position
    local Objects = {}
    for i, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("Pickup") ~= nil and v.ClassName == "Part" and v.Name == "Essence" then
            local Pos = v.Position
            local Distance = (myPos - Pos).magnitude
            if Distance < 40 then
                table.insert(Objects, v)
            end
        elseif
            v:FindFirstChild("Pickup") ~= nil and v:FindFirstChild("Part") ~= nil and v.Part.ClassName == "Part" and
                v.Name == "Essence"
         then
            local Pos = v.Part.Position
            local Distance = (myPos - Pos).magnitude
            if Distance < 40 then
                table.insert(Objects, v)
            end
        elseif v:FindFirstChild("Pickup") ~= nil and v.ClassName == "UnionOperation" and v.Name == "Essence" then
            local Pos = v.Position
            local Distance = (myPos - Pos).magnitude
            if Distance < 40 then
                table.insert(Objects, v)
            end
        end
    end
    for i, v in pairs(Objects) do
        if _G.Pickup then
            for i = 1, 1 do
                v.Position = myPos
                game:GetService("ReplicatedStorage").Events.Pickup:FireServer(v)
            end
        end
    end
end
local function getPath(TargetPoint)
    local path = pathservice:CreatePath()
    path:ComputeAsync(Body.Position, TargetPoint)
    return path
end

function createDots(TargetPoint)
    local path = getPath(TargetPoint)
    for _, waypoint in pairs(path:GetWaypoints()) do
        local part = Instance.new("Part")
        part.Shape = "Ball"
        part.Material = "Neon"
        part.Size = Vector3.new(0.6, 0.6, 0.6)
        part.Position = waypoint.Position
        part.Anchored = true
        part.CanCollide = false
        part.Parent = game.Workspace
    end
end

local function walkTo(TargetPoint, path)
    local distance
    -- createDots(TargetPoint)
    for _, waypoint in pairs(path:GetWaypoints()) do
        --// Added detection to see if player is frozen by anti-cheat. This should stop you from getting kicked now.
        if Body.Part.Anchored == true then -- anti cheat anchors this part when you're frozen
            warn("Frozen By Anti-Cheat Stopping") -- Skips iteration of loop.
        else -- if it's not anchored or if it's nil or something then we wanna keep tp
            Body.CFrame = CFrame.new(waypoint.Position)
            wait(0.3)
        end
    end
end

local getClosestTree = function(number)
    for i, v in pairs(game.Workspace.Resources:GetChildren()) do
        local tmp
        local Found = false
        local distance = 300
        local partpos
        if v.Name == "Sun Tree" or v.Name == "Sun Shrub" and v.Parent ~= "Contents" then
            if v.Name == "Sun Shrub" then
                partpos = "Stump"
            elseif v.Name == "Sun Tree" then
                partpos = "Reference"
            end
            if (v:FindFirstChild(partpos).Position - Body.Position).magnitude < 300 then
                if Closest then
                    tmp = (player.Position - v[partpos].Position).magnitude
                    if tmp < ClosestMag then
                        Closest = v
                        ClosestMag = tmp
                    end
                else
                    Closest = v
                    ClosestMag = (player.Position - v[partpos].Position).magnitude
                end
            end
        end
    end
    if Closest then
        if Closest.Name == "Sun Tree" then
            Closest.Name = "Sun Tree" .. tostring(number)
            destination = Closest.Reference.Position - Vector3.new(-5, 0, -5)
            print(Closest)
        elseif Closest.Name == "Sun Shrub" then
            Closest.Name = "Sun Shrub" .. tostring(number)
            destination = Closest:WaitForChild("Stump").Position - Vector3.new(-5, 0, -5)
            print(Closest)
        end
    else
        return
    end
end

local brokenTree = function(number)
    for i, v in pairs(game.Workspace.Resources:GetChildren()) do
        if v.Name == "Sun Tree" .. tostring(number) or v.Name == "Sun Shrub" .. tostring(number) then
            if "Sun Tree" .. tostring(number) == v.Name or "Sun Shrub" .. tostring(number) == v.Name then
                return true
            elseif v.Name ~= "Sun Tree" .. tostring(number) or v.Name ~= "Sun Shrub" .. tostring(number) then
                return false
            end
        end
    end
end

local function checkdistance(d)
    if (Body.Position - d).magnitude < 5 then
        return true
    elseif (Body.Position - d).magnitude > 5 then
        return false
    end
end

local AncientTree = function()
    if game.Workspace.Resources:FindFirstChild("Ancient Tree") then
        return true
    elseif not game.Workspace.Resources:FindFirstChild("Ancient Tree") then
        return false
    end
end

local StopCrash =
    coroutine.create(
    function()
        local sentText = false
        while true do
            local pingObject = stats():WaitForChild("PerformanceStats"):WaitForChild("Ping") -- get ping ez
            local ping = pingObject:GetValue()
            wait()
            if ping >= _G.ping then
                if not sentText then
                    createnotif("Ping has spiked, stopping scripts", Color3.fromRGB(170, 0, 0), 1, 0)
                    --print("Ping above" .. " " .. _G.ping .. " " .. "Stopping all scripts")
                    sentText = true
                end
                _G.Pickup = false
            elseif ping < _G.ping then
                if sentText then
                    --print("Ping is back to normal. Re-running scripts.")
                    sentText = false
                end
                _G.Pickup = true
            end
        end
    end
)

coroutine.resume(StopCrash)

local antilag2 = true

local function startFarm()
    local data = game.ReplicatedStorage.Events.RequestData:InvokeServer()
    if _G.Farming then
        while _G.tree do
            if _G.Farming then
                if _G.data.stats.food < 50 then
                    --print("eating")
                    eat:FireServer(getFood())
                end
                local func =
                    coroutine.create(
                    function()
                        if antilag2 then
                            wait(0.5)
                            antilag2 = false
                        elseif not antilag2 then
                            wait(0.5)
                            antilag2 = true
                        end
                    end
                )
                coroutine.resume(func)
                if antilag2 then
                    if not CanBearLoad("Apple Tree") then
                        if not Applebruh() then
                            getSpace()
                        end
                    end
                    if _G.Pickup then
                        for _, v in pairs(workspace:GetChildren()) do
                            if
                                v.Name == "Apple Tree" and
                                    (Player1.Character.Head.Position - v.PrimaryPart.Position).magnitude < 40
                             then
                                if CanBearLoad("Apple Tree") then
                                    game.ReplicatedStorage.Events.Pickup:FireServer(v)
                                end
                            end
                        end
                        for _, v in pairs(workspace.Deployables:GetChildren()) do
                            if
                                v.Name == "Plant Box" and
                                    (Player1.Character.Head.Position - v.PrimaryPart.Position).magnitude < 40
                             then
                                if CanBearLoad("Apple Tree") then
                                    game.ReplicatedStorage.Events.InteractStructure:FireServer(v, "Apple")
                                end
                            end
                        end
                    end
                end
                if AncientTree() then
                    _G.tree = false
                end
                wait()
                if not brokenTree(nTree) then
                    nTree = nTree + 1
                    Closest = nil
                    getClosestTree(nTree)
                end
                local path = getPath(destination)
                if not checkdistance(destination) then
                    walkTo(destination, path)
                end
                if Closest then
                    if Closest.Name == "Sun Tree" .. tostring(nTree) then
                        game.ReplicatedStorage.Events.SwingTool:FireServer({Closest:WaitForChild("Reference")})
                    elseif Closest.Name == "Sun Shrub" .. tostring(nTree) then
                        game.ReplicatedStorage.Events.SwingTool:FireServer({Closest:WaitForChild("Stump")})
                    else
                        print("no reference or stump")
                    end
                end
            end
        end
    end
end

--game.Workspace.Resources.ChildAdded:connect(function(child)
--	if child.Name == "Sun Tree" then

--	end
--end)

local AutoPickup =
    coroutine.create(
    function()
        while true do
            wait(0.001)
            Pickup(game.Players.LocalPlayer.Character)
        end
        if _G.data.level == 100 then
            _G.Farming = false
            print("Reached level 100 should stop.. maybe not? lets see xd")
        end
    end
)

coroutine.resume(AutoPickup)

local hitancientfast =
    coroutine.create(
    function()
        while true do
            wait()
            if AncientTree() then
                game.ReplicatedStorage.Events.SwingTool:FireServer(
                    {
                        game:GetService("Workspace").Resources["Ancient Tree"].Reference,
                        game:GetService("Workspace").Resources["Ancient Tree"].Trunk
                    }
                )
            end
        end
    end
)
coroutine.resume(hitancientfast)

local antilag = true

createnotif(
    "Auto Farm Made By Vexcility FUCK the sensitive little snowflake shit mods",
    Color3.fromRGB(0, 255, 0),
    5,
    0
)

while true do
    wait()
    if _G.Farming then
        if _G.data.stats.food < 50 then
            eat:FireServer(getFood())
        end
        local func =
            coroutine.create(
            function()
                if antilag then
                    wait(0.5)
                    antilag = false
                elseif not antilag then
                    wait(0.5)
                    antilag = true
                end
            end
        )
        coroutine.resume(func)
        if antilag then
            if not CanBearLoad("Apple Tree") then
                if not Applebruh() then
                    getSpace()
                end
            end
            if _G.Pickup then
                for _, v in pairs(workspace:GetChildren()) do
                    if
                        v.Name == "Apple Tree" and
                            (Player1.Character.Head.Position - v.PrimaryPart.Position).magnitude < 40
                     then
                        if CanBearLoad("Apple Tree") then
                            game.ReplicatedStorage.Events.Pickup:FireServer(v)
                        end
                    end
                end
                for _, v in pairs(workspace.Deployables:GetChildren()) do
                    if
                        v.Name == "Plant Box" and
                            (Player1.Character.Head.Position - v.PrimaryPart.Position).magnitude < 40
                     then
                        if CanBearLoad("Apple Tree") then
                            game.ReplicatedStorage.Events.InteractStructure:FireServer(v, "Apple")
                        end
                    end
                end
            end
        end
        if AncientTree() then
            destination1 = Vector3.new(-545.23620605469, 312.95153808594, -1190.4654541016)
            _G.tree = false
            local path = getPath(destination1)
            if not checkdistance(destination1) then
                walkTo(destination1, path)
            end
        elseif not AncientTree() then
            _G.tree = true
        end
        startFarm()
    end
end
