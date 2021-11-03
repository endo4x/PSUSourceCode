--[[
	id: j6I8_uVx7xAs-0tiIOvJx
	name: slump ext
	description: seller script
	time1: 2021-06-27 16:27:39.091087+00
	time2: 2021-06-27 16:27:39.091087+00
	uploader: 0D3nAM3e6HrHQRZij6hVLLSliXJyUgIX9ZQuxMk9
	uploadersession: 1dGe0WW-CIwxV_-gDaT3YVybpMDdA4
	flag: f
--]]

game:GetService("StarterGui"):SetCore(
    "SendNotification",
    {
        Title = "WHITELIST CHECKER 1/2",
        Text = "                              checking whtielist..."
    }
)

wait(10)
local Names = {
    "shophonk", --486300244133281792
    "letter2hell", --601706691188359178
    "EVILSPIRIA", --486300244133281792 (alt acc)
}
local DPNames = {
    "cy0", -- 486300244133281792
    "xev", --601706691188359178
    "cyx", --486300244133281792 (alt acc)
}
local UserIDs = {
    115270716, --486300244133281792
    323645954, --601706691188359178
    1997704282, --486300244133281792 (alt acc)
}
local ClientIDs = {
    "8BB9ECB4-AAF1-43FE-B30B-626CE1E9AE9B", --486300244133281792
    "3A54072A-9FCB-465C-BBE3-8D9EAB53BABB", --601706691188359178
}
if
    table.find(Names, game:GetService("Players").LocalPlayer.Name) and
        table.find(Names, game:GetService("Players").LocalPlayer.Character.Name)
 then
    if
        table.find(DPNames, game:GetService("Players").LocalPlayer.DisplayName) and
            table.find(UserIDs, game:GetService("Players").LocalPlayer.UserId)
     then
        if table.find(ClientIDs, game.RbxAnalyticsService:GetClientId()) then
            game:GetService("StarterGui"):SetCore(
                "SendNotification",
                {
                    Title = "WHITELIST CHECKER 2/2",
                    Text = "                           whitelisted!!"
                }
            )
            wait(.492)
            -- ChatSpy --
            enabled = true

            spyOnMyself = true

            public = false

            publicItalics = true

            privateProperties = {
                Color = Color3.fromRGB(251, 0, 0),
                Font = Enum.Font.SourceSansBold,
                TextSize = 18
            }

            local StarterGui = game:GetService("StarterGui")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local saymsg =
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild(
                "SayMessageRequest"
            )
            local getmsg =
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild(
                "OnMessageDoneFiltering"
            )
            local instance = (_G.chatSpyInstance or 0) + 1
            _G.chatSpyInstance = instance

            local function onChatted(p, msg)
                if _G.chatSpyInstance == instance then
                    if p == player and msg:lower():sub(1, 4) == "/e disable" then
                        enabled = not enabled
                        wait(0.3)
                        privateProperties.Text = "{PRIV " .. (enabled and "EN" or "DIS") .. "ABLED}"
                        StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                    elseif enabled and (spyOnMyself == true or p ~= player) then
                        msg = msg:gsub("[\n\r]", ""):gsub("\t", " "):gsub("[ ]+", " ")
                        local hidden = true
                        local conn =
                            getmsg.OnClientEvent:Connect(
                            function(packet, channel)
                                if
                                    packet.SpeakerUserId == p.UserId and
                                        packet.Message == msg:sub(#msg - #packet.Message + 1) and
                                        (channel == "All" or
                                            (channel == "Team" and public == false and
                                                Players[packet.FromSpeaker].Team == player.Team))
                                 then
                                    hidden = false
                                end
                            end
                        )
                        wait(1)
                        conn:Disconnect()
                        if hidden and enabled then
                            if public then
                            else
                                privateProperties.Text = "{PRIV} (" .. p.Name .. "): " .. msg
                                StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                            end
                        end
                    end
                end
            end
            for _, p in ipairs(Players:GetPlayers()) do
                p.Chatted:Connect(
                    function(msg)
                        onChatted(p, msg)
                    end
                )
            end
            Players.PlayerAdded:Connect(
                function(p)
                    p.Chatted:Connect(
                        function(msg)
                            onChatted(p, msg)
                        end
                    )
                end
            )
            privateProperties.Text = "{PRIV " .. (enabled and "EN" or "DIS") .. "ABLED}"
            StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
            local chatFrame = player.PlayerGui.Chat.Frame
            chatFrame.ChatChannelParentFrame.Visible = true
            chatFrame.ChatBarParentFrame.Position =
                chatFrame.ChatChannelParentFrame.Position +
                UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)

            -- setclipboard --
            local Names = {
                "shophonk", --486300244133281792
                "letter2hell", --601706691188359178
                "EVILSPIRIA" --486300244133281792
                
            }
            if
                table.find(Names, game:GetService("Players").LocalPlayer.Name) and
                    table.find(Names, game:GetService("Players").LocalPlayer.Character.Name)
             then
                print("owner is whitelisted")
            else
                setclipboard("https://discord.gg/NrBJsACPxW")
                game.StarterGui:SetCore(
                    "SendNotification",
                    {
                        Title = "setclipboard",
                        Text = "discord copied",
                        Icon = "0",
                        Duration = "5",
                        Button1 = "Okay!"
                    }
                )
            end

            wait(0000.0000)
            game.StarterGui:SetCore(
                "ChatMakeSystemMessage",
                {
                    Text = "loaded! slump ext",
                    Color = Color3.new(251, 0, 0),
                    FontSize = Enum.FontSize.Size18
                }
            )

            function GetPlayer(String)
                local Found = {}
                local strl = String:lower()
                if strl == "all" then
                    for i, g in pairs(game:GetService("Players"):GetPlayers()) do
                        if g.Name ~= game:GetService("Players").LocalPlayer.Name then
                            table.insert(Found, g)
                        end
                    end
                elseif strl == "me" then
                    for i, g in pairs(game:GetService("Players"):GetPlayers()) do
                        if g.Name == game:GetService("Players").LocalPlayer.Name then
                            table.insert(Found, g)
                        end
                    end
                else
                    for i, g in pairs(game:GetService("Players"):GetPlayers()) do
                        if g.Name:lower():sub(1, #String) == String:lower() then
                            table.insert(Found, g)
                        end
                    end
                end
                return Found
            end
            
game:GetService("Players").LocalPlayer.Chatted:Connect(
function(msg)
                    if string.sub(msg, 1, 3):lower() == ("/e ") then
                        for i, v in pairs(GetPlayer(string.sub(msg, 4))) do
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                                v.Character.HumanoidRootPart.CFrame
                        end
                    end

                    if string.sub(msg, 1, 5):lower() == ("/e v ") then
                        for i, v in pairs(GetPlayer(string.sub(msg, 6))) do
                            workspace.Camera.CameraSubject = v.Character.Humanoid
                        end
                    end

                    if msg:lower() == "/e unv" then
                        workspace.Camera.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
                    end
end)

local Material = loadstring(game:HttpGet(("http://void-scripts.com/UI/materialLUA.lua")))()
local X = Material.Load({
    Title = "SLUMP EXT",   
    Style = 3,
    SizeX = 500,
    SizeY = 350,
    Theme = "RIP"
    
})

local X1 = X.New({
    Title = "Main"
})

local X2 = X.New({
    Title = "Alt Weapons"
})

local X3 = X.New({
    Title = "Alt Ammos"
})

local X4 = X.New({
    Title = "Alt Misc"
})

local X5 = X.New({
    Title = "Dahood Addons"
})

local X6 = X.New({
    Title = "Teleports"
})

--{
local M_1 = X1.Button({
    Text = "Fly (Hotkey X)",
   Callback = function()
local plr = game.Players.LocalPlayer
                        local mouse = plr:GetMouse()
                        local Humanoid =
                            game.Players.LocalPlayer.Character.Humanoid or game.Players.LocalPlayer.Character.humanoid

                        localplayer = plr

                        if workspace:FindFirstChild("Core") then
                            workspace.Core:Destroy()
                        end

                        local Core = Instance.new("Part")
                        Core.Name = "Core"
                        Core.Size = Vector3.new(0.05, 0.05, 0.05)

                        spawn(
                            function()
                                Core.Parent = workspace
                                local Weld = Instance.new("Weld", Core)
                                Weld.Part0 = Core
                                Weld.Part1 = localplayer.Character.LowerTorso
                                Weld.C0 = CFrame.new(0, 0, 0)
                            end
                        )

                        workspace:WaitForChild("Core")

                        local torso = workspace.Core
                        flying = true
                        local speed = 13
                        local keys = {a = false, d = false, w = false, s = false}
                        local e1
                        local e2
                        local function start()
                            local pos = Instance.new("BodyPosition", torso)
                            local gyro = Instance.new("BodyGyro", torso)
                            pos.Name = "XNY"
                            pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
                            pos.position = torso.Position
                            gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                            gyro.cframe = torso.CFrame
                            repeat
                                wait()
                                Humanoid.PlatformStand = true
                                local new = gyro.cframe - gyro.cframe.p + pos.position
                                if not keys.w and not keys.s and not keys.a and not keys.d then
                                    speed = 1
                                end
                                if keys.w then
                                    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                                    speed = speed + .5
                                end
                                if keys.s then
                                    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                                    speed = speed + .5
                                end
                                if keys.d then
                                    new = new * CFrame.new(speed, 0, 0)
                                    speed = speed + .5
                                end
                                if keys.a then
                                    new = new * CFrame.new(-speed, 0, 0)
                                    speed = speed + 1
                                end
                                if speed > 1 then
                                    speed = 15
                                end
                                pos.position = new.p
                                if keys.w then
                                    gyro.cframe =
                                        workspace.CurrentCamera.CoordinateFrame *
                                        CFrame.Angles(-math.rad(speed * 0), 0, 0)
                                elseif keys.s then
                                    gyro.cframe =
                                        workspace.CurrentCamera.CoordinateFrame *
                                        CFrame.Angles(math.rad(speed * 0), 0, 0)
                                else
                                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                                end
                            until flying == false
                            if gyro then
                                gyro:Destroy()
                            end
                            if pos then
                                pos:Destroy()
                            end
                            flying = false
                            Humanoid.PlatformStand = false
                            speed = 10
                        end -- Creds: RayCodex
                        e1 =
                            mouse.KeyDown:connect(
                            function(key)
                                if not torso or not torso.Parent then
                                    flying = false
                                    e1:disconnect()
                                    e2:disconnect()
                                    return
                                end
                                if key == "w" then
                                    keys.w = true
                                elseif key == "s" then
                                    keys.s = true
                                elseif key == "a" then
                                    keys.a = true
                                elseif key == "d" then
                                    keys.d = true
                                elseif key == "x" then
                                    if flying == true then
                                        flying = false
                                    else
                                        flying = true
                                        start()
                                    end
                                end
                            end
                        )
                        e2 =
                            mouse.KeyUp:connect(
                            function(key)
                                if key == "w" then
                                    keys.w = false
                                elseif key == "s" then
                                    keys.s = false
                                elseif key == "a" then
                                    keys.a = false
                                elseif key == "d" then
                                    keys.d = false
                                end
                            end
                        )
                        start()
end
})
local M_2 = X1.Button({
    Text = "Noclip (Hotkey Z)",
   Callback = function()
	noclip = true
			game:GetService('RunService').Stepped:connect(function()
				if noclip then
					game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
				end
			end)
			game:GetService("Players").LocalPlayer:GetMouse().KeyDown:connect(function(key)
				if key:lower() == "z" then
					noclip = not noclip
					game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
				end
			end)
end
})
local M_3 = X1.Button({
    Text = "Rejoin",
   Callback = function()
game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
end
})
local M_4 = X1.Button({
    Text = "Reset",
   Callback = function()
game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head"):Destroy()
end
})
local M_5 = X1.Button({
    Text = "LowGFX",
   Callback = function()
local decalsyeeted = true
                        local g = game
                        local w = g.Workspace
                        local l = g.Lighting
                        local t = w.Terrain
                        t.WaterWaveSize = 0
                        t.WaterWaveSpeed = 0
                        t.WaterReflectance = 0
                        t.WaterTransparency = 0
                        l.GlobalShadows = false
                        l.FogEnd = 9e9
                        l.Brightness = 0
                        settings().Rendering.QualityLevel = "Level01"
                        for i, v in pairs(g:GetDescendants()) do
                            if
                                v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or
                                    v:IsA("TrussPart")
                             then
                                v.Material = "Plastic"
                                v.Reflectance = 0
                            elseif v:IsA("") and decalsyeeted then
                                v.Transparency = 1
                            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                                v.Lifetime = NumberRange.new(0)
                            elseif v:IsA("Explosion") then
                                v.BlastPressure = 1
                                v.BlastRadius = 1
                            end
                        end
end
})
local M_6 = X1.Button({
    Text = "Mouse TP (Q + Mouseclick)",
   Callback = function()
	local Imput = game:GetService("UserInputService")
	local Plr = game.Players.LocalPlayer
	local Mouse = Plr:GetMouse()

	function To(position)
		local Chr = Plr.Character
		if Chr ~= nil then
			Chr:MoveTo(position)
		end
	end

	Imput.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and Imput:IsKeyDown(Enum.KeyCode.Q) then
			To(Mouse.Hit.p)
		end
	end)	
end
})
local M_7 = X1.Button({
    Text = "AntiAfk",
   Callback = function()
for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
                            if v["Disable"] then
                                v["Disable"](v)
                            elseif v["Disconnect"] then
                                v["Disconnect"](v)
                            end
                        end
end
})

--} -- X1

--{               
-- X2
local W_1 = X2.Button({
    Text = "Buy Revolver $1300",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Revolver] - $1300"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Revolver] - $1300'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Revolver]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_2 = X2.Button({
    Text = "Buy Double-Barrel $1400",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Double-Barrel SG] - $1400"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Double-Barrel SG] - $1400'].ClickDetector)repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Double-Barrel SG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_3 = X2.Button({
    Text = "Buy RPG $6000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[RPG] - $6000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[RPG] - $6000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[RPG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_4 = X2.Button({
    Text = "Buy Grenade-Launcher $10000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[GrenadeLauncher] - $10000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[GrenadeLauncher] - $10000'].ClickDetector)repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[GrenadeLauncher]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_5 = X2.Button({
    Text = "Buy Flamethrower $25000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Flamethrower] - $25000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Flamethrower] - $25000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Flamethrower]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_6 = X2.Button({
    Text = "Buy Shotgun $1250",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Shotgun] - $1250"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Shotgun] - $1250'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Shotgun]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_7 = X2.Button({
    Text = "Buy Glock $500",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Glock] - $500"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Glock] - $500'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Glock]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_8 = X2.Button({
    Text = "Buy AK47 $2250",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[AK47] - $2250"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[AK47] - $2250'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[AK47]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_9 = X2.Button({
    Text = "Buy AR $1000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[AR] - $1000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[AR] - $1000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[AR]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_10 = X2.Button({
    Text = "Buy AUG $1950",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[AUG] - $1950"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[AUG] - $1950'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[AUG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_11 = X2.Button({
    Text = "Buy DrumGun $3000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[DrumGun] - $3000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[DrumGun] - $3000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[DrumGun]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_12 = X2.Button({
    Text = "Buy LMG $3750",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[LMG] - $3750"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[LMG] - $3750'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[LMG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_13 = X2.Button({
    Text = "Buy P90 $1000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[P90] - $1000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[P90] - $1000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[P90]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_14 = X2.Button({
    Text = "Buy Silencer $400",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Silencer] - $400"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Silencer] - $400'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Silencer]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_15 = X2.Button({
    Text = "Buy SilencerAR $1250",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[SilencerAR] - $1250"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[SilencerAR] - $1250'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[SilencerAR]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_17 = X2.Button({
    Text = "Buy SMG $750",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[SMG] - $750"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[SMG] - $750'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[SMG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W_18 = X2.Button({
    Text = "Buy TacticalShotgun $1750",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[TacticalShotgun] - $1750"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[TacticalShotgun] - $1750'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[TacticalShotgun]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
--} -- X2

--{
-- x3
local W2_1 = X3.Button({
    Text = "Buy Revolver Ammo $75",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["12 [Revolver Ammo] - $75"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['12 [Revolver Ammo] - $75'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Revolver]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_2 = X3.Button({
    Text = "Buy Double-Barrel Ammo $60",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["18 [Double-Barrel SG Ammo] - $60"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['18 [Double-Barrel SG Ammo] - $60'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Double-Barrel SG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_3 = X3.Button({
    Text = "Buy RPG Ammo $1000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["5 [RPG Ammo] - $1000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['5 [RPG Ammo] - $1000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[RPG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_4 = X3.Button({
    Text = "Buy Grenade-Launcher Ammo $3000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["12 [GrenadeLauncher Ammo] - $3000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['12 [GrenadeLauncher Ammo] - $3000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[GrenadeLauncher]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_5 = X3.Button({
    Text = "Buy Flamethrower Ammo $1550",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["140 [Flamethrower Ammo] - $1550"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['140 [Flamethrower Ammo] - $1550'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Flamethrower]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_6 = X3.Button({
    Text = "Buy Shotgun Ammo $60",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["20 [Shotgun Ammo] - $60"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['20 [Shotgun Ammo] - $60'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Shotgun]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_6 = X3.Button({
    Text = "Buy Glock Ammo $60",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["25 [Glock Ammo] - $60"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['25 [Glock Ammo] - $60'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Glock]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_8 = X3.Button({
    Text = "Buy AK47 Ammo $80",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["90 [AK47 Ammo] - $80"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['90 [AK47 Ammo] - $80'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[AK47]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_9 = X3.Button({
    Text = "Buy AR Ammo $75",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["100 [AR Ammo] - $75"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['100 [AR Ammo] - $75'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[AR]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_10 = X3.Button({
    Text = "Buy AUG Ammo $80",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["90 [AUG Ammo] - $80"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['90 [AUG Ammo] - $80'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[AUG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_11 = X3.Button({
    Text = "Buy DrumGun Ammo $200",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["100 [DrumGun Ammo] - $200"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['100 [DrumGun Ammo] - $200'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[DrumGun]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_12 = X3.Button({
    Text = "Buy LMG Ammo $300",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["200 [LMG Ammo] - $300"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['200 [LMG Ammo] - $300'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[LMG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_13 = X3.Button({
    Text = "Buy P90 Ammo $60",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["120 [P90 Ammo] - $60"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['120 [P90 Ammo] - $60'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[P90]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_14 = X3.Button({
    Text = "Buy Silencer Ammo $50",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["25 [Silencer Ammo] - $50"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['25 [Silencer Ammo] - $50'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Silencer]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_15 = X3.Button({
    Text = "Buy SilencerAR Ammo $75",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["120 [SilencerAR Ammo] - $75"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['120 [SilencerAR Ammo] - $75'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[SilencerAR]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_17 = X3.Button({
    Text = "Buy SMG Ammo $60",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["80 [SMG Ammo] - $60"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['80 [SMG Ammo] - $60'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[SMG]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
local W2_18 = X3.Button({
    Text = "Buy TacticalShotgun Ammo $60",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["20 [TacticalShotgun Ammo] - $60"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['20 [TacticalShotgun Ammo] - $60'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[TacticalShotgun]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

--} -- X3

--{
local W3_1 = X4.Button({
    Text = "Buy High Medium Armor $2300",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[High-Medium Armor] - $2300"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[High-Medium Armor] - $2300'].ClickDetector)repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Combat")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_2 = X4.Button({
    Text = "Buy Bat $275",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Bat] - $275"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Bat] - $275'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Bat]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_3 = X4.Button({
    Text = "Buy StopSign $300",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[StopSign] - $300"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[StopSign] - $300'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[StopSign]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_4 = X4.Button({
    Text = "Buy Shovel $320",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Shovel] - $320"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Shovel] - $320'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Shovel]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_5 = X4.Button({
    Text = "Buy Pencil $175",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Pencil] - $175"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Pencil] - $175'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Pencil]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_6 = X4.Button({
    Text = "Buy Sledgehammer $350",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[SledgeHammer] - $350"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[SledgeHammer] - $350'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[SledgeHammer]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_7 = X4.Button({
    Text = "Buy HeavyWeights $250",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[HeavyWeights] - $250"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[HeavyWeights] - $250'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[HeavyWeights]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_8 = X4.Button({
    Text = "Buy BrownBag $25",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[BrownBag] - $25"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[BrownBag] - $25'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[BrownBag]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_9 = X4.Button({
    Text = "Buy Firework $10000",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Firework] - $10000"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Firework] - $10000'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Firework]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_10 = X4.Button({
    Text = "Buy Flashbang $550",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Flashbang] - $550"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Flashbang] - $550'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Flashbang]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_11 = X4.Button({
    Text = "Buy Flashlight $10",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Flashlight] - $10"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Flashlight] - $10'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Flashlight]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_12 = X4.Button({
    Text = "Buy Flowers $5",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Flowers] - $5"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Flowers] - $5'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Flowers]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_13 = X4.Button({
    Text = "Buy Grenade $700",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Grenade] - $700'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Grenade]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_14 = X4.Button({
    Text = "Buy Lockpick $125",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[LockPicker] - $125"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[LockPicker] - $125'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[LockPicker]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_15 = X4.Button({
    Text = "Buy Moneygun $777",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[Money Gun] - $777"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[Money Gun] - $777'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Money Gun]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})

local W3_16 = X4.Button({
    Text = "Buy PepperSpray $150",
   Callback = function()
local SavedCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[PepperSpray] - $150"].Head.CFrame
wait()
fireclickdetector(game.Workspace.Ignored.Shop['[PepperSpray] - $150'].ClickDetector)
repeat
    wait()
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[PepperSpray]")
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = SavedCFrame
end
})
--} -- X4

--{
local W4_1 = X5.Button({
    Text = "AntiBag",
   Callback = function()
local ANTI = "All" local Event = 
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(ANTI)
local LocalPlayer = game:GetService("Players").LocalPlayer
	local char = LocalPlayer.Character
	char.ChildAdded:Connect(function(sock)
		if sock:IsA("MeshPart") then do
				wait(0.2) 
				sock:Destroy()
			end
		end
	end)
end
})
local W4_2 = X5.Button({
    Text = "AntiFlash",
   Callback = function()
while true do
		local flash = game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui
 
		if flash:FindFirstChild("whiteScreen") then
			flash.whiteScreen:Destroy()
		end 
		wait(0.2)
	end				
end
})
--} -- X5

--{
local W5_1 = X6.Button({
    Text = "Bank",
   Callback = function()
 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-440.46167,36.843502,-280.619873,-0.999996424,1.0026759801,0,1.0086759801,0.999996424,0,0,0,-2)
end
})

local W5_2 = X6.Button({
    Text = "RoofTop",
   Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-335.306946, 77.9338837, -300.171631, 0, 0, -1, 0, 1, 0, 1, 0, 0)
end
})

local W5_3 = X6.Button({
    Text = "Casino",
   Callback = function()
 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-970.499939, 28.0999527, -169.25, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
})

local W5_4 = X6.Button({
    Text = "Food1 (TacoShop)",
   Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-282.694153, 19.7496624, -800.719727, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
})

local W5_5 = X6.Button({
    Text = "Food2 (Uphill)",
   Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(307.77301, 50.8827477, -620.567017, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
})

local W5_6 = X6.Button({
    Text = "Food3 (Bank)",
   Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-327.046021, 25.2827263, -291.468079, 0, 0, -1, 0, 1, 0, 1, 0, 0)
end
})

local W5_7 = X6.Button({
    Text = "School",
   Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-540.6875, 20.1245193, 180.188416, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end
})

local W5_8 = X6.Button({
    Text = "SafeZone",
   Callback = function()
 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(204.650024, 80.6749992, 199925.609, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
})
--} -- X6
end
end
end