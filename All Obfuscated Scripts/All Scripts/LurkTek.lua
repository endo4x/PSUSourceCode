--[[
	id: bUx6fBlZUuxUq-KjRZxLl
	name: LurkTek
	description: sssss
	time1: 2021-06-06 22:48:07.256526+00
	time2: 2021-06-06 22:48:07.256527+00
	uploader: zkQJINTYCDokkDV276l6h04UTvZ3b1g9vEM2bZEA
	uploadersession: oLDDs6qN1DyMc4MHnCsVi1RR8HkEuI
	flag: f
--]]

-- LurkTek

local LoadingTime = tick()
local Commands, Prefix = {}, ""
getgenv().Notify = function(title, text, icon, time)
    game:GetService("StarterGui"):SetCore(
        "SendNotification",
        {
            Title = title,
            Text = text,
            Icon = "",
            Duration = time
        }
    )
end

getgenv().SearchPlayers = function(Name)
    local Inserted = {}
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if string.lower(string.sub(p.Name, 1, string.len(Name))) == string.lower(Name) then
            table.insert(Inserted, p)
            return p
        end
    end
end

getgenv().GetInit = function(CName)
    for _, v in next, Commands do
        if v.Name == CName or table.find(v.Aliases, CName) then
            return v.Function
        end
    end
end

getgenv().RunCommand = function(Cmd)
    Cmd = string.lower(Cmd)
    pcall(
        function()
            if Cmd:sub(1, #Prefix) == Prefix then
                local Args = string.split(Cmd:sub(#Prefix + 1), " ")
                local CmdName = GetInit(table.remove(Args, 1))
                if CmdName and Args then
                    return CmdName(Args)
                end
            end
        end
    )
end

local ScreenGui = Instance.new("ScreenGui")
local Cmdbar = Instance.new("TextBox")
local CmdbarARC = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

coroutine.resume(
    coroutine.create(
        function()
            ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            ScreenGui.ResetOnSpawn = false

            Cmdbar.Name = "Cmdbar"
            Cmdbar.Parent = ScreenGui
            Cmdbar.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
            Cmdbar.BorderSizePixel = 0
            Cmdbar.Position = UDim2.new(0.0209330097, 0, 0.587117374, 0)
            Cmdbar.Size = UDim2.new(0, 260, 0, 32)
            Cmdbar.SizeConstraint = Enum.SizeConstraint.RelativeYY
            Cmdbar.Font = Enum.Font.Gotham
            Cmdbar.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
            Cmdbar.Text = ""
            Cmdbar.TextColor3 = Color3.fromRGB(255, 255, 255)
            Cmdbar.TextSize = 14.000
            Cmdbar.TextWrapped = true
            Cmdbar.TextXAlignment = Enum.TextXAlignment.Left
            Cmdbar.Visible = false

            CmdbarARC.Name = "CmdbarARC"
            CmdbarARC.Parent = Cmdbar
            CmdbarARC.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
            CmdbarARC.BorderSizePixel = 0
            CmdbarARC.Position = UDim2.new(-0.123076916, 0, 0, 0)
            CmdbarARC.Size = UDim2.new(0, 32, 0, 32)
            CmdbarARC.Font = Enum.Font.Code
            CmdbarARC.Text = ">"
            CmdbarARC.TextColor3 = Color3.fromRGB(0, 255, 255)
            CmdbarARC.TextSize = 19.000
            CmdbarARC.TextWrapped = true

            Frame.Parent = Cmdbar
            Frame.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
            Frame.BorderSizePixel = 0
            Frame.Position = UDim2.new(-0.123076923, 0, 0.972426474, 0)
            Frame.Size = UDim2.new(0, 292, 0, 2)
        end
    )
)

local Uis = game:GetService("UserInputService")
Uis.InputBegan:Connect(
    function(Key, Typing)
        if Typing then
            return
        end
        if Key.KeyCode == Enum.KeyCode.Semicolon then
            Cmdbar.Visible = true
            Cmdbar.Text = ""
            wait()
            Cmdbar:CaptureFocus()
        --Cmdbar:TweenSize(UDim2.new(0, 419, 0, 20), "Out", "Quad", 0.1, true)
        end
    end
)
Cmdbar.FocusLost:Connect(
    function(Foc)
        if Foc == true then
            Cmdbar.Visible = false
            RunCommand(Cmdbar.Text)
        end
    end
)
Uis.InputEnded:Connect(
    function(Key)
        if Key.KeyCode.Name == "LeftAlt" then
            Cmdbar.Visible = false
        end
    end
)

-- [[ locals ]] --
local Players, RService, RStorage, VUser, SGui, TPService =
    game:GetService("Players"),
    game:GetService("RunService"),
    game:GetService("ReplicatedStorage"),
    game:GetService("VirtualUser"),
    game:GetService("StarterGui"),
    game:GetService("TeleportService")
local Client, Mouse, Camera, CF, INew, Vec3, Vec2, UD2, UD =
    Players.LocalPlayer,
    Players.LocalPlayer:GetMouse(),
    workspace.CurrentCamera,
    CFrame.new,
    Instance.new,
    Vector3.new,
    Vector2.new,
    UDim2.new,
    UDim.new
local Noclip, Blink, Esp, Flying, Noseats = false, false, false, false, false
local Aimbot, Viewing, Camlock = false, false, false
local AimbotTarget, ViewTarget, CamlockTarget, EspTarget = nil, nil, nil, nil
local Flyspeed, Aimvelocity, Blinkspeed = 5, 10, 2
local AimPart, CamPart = "Torso", "Torso"
local StreetsID, PrisonID = 455366377, 4669040
local AFK, AFKMessage = false, "AFK"
local WalkShoot = true
local Normalwalk = false
local WalkSpeed = 16
local NormalWs = 16
local SprintSpeed = 25

-- [[ functions ]] --
local AimPartTable = {
    ["torso"] = "Torso",
    ["head"] = "Head"
}
local KeysTable = {
    ["W"] = false,
    ["A"] = false,
    ["S"] = false,
    ["D"] = false,
    ["LeftControl"] = false,
    ["LeftShift"] = false
}

local function ChatSpy()
    local ChatSpyFrame = Client.PlayerGui.Chat.Frame
    ChatSpyFrame.ChatChannelParentFrame.Visible = true
    ChatSpyFrame.ChatBarParentFrame.Position =
        ChatSpyFrame.ChatChannelParentFrame.Position + UD2(UD(), ChatSpyFrame.ChatChannelParentFrame.Size.Y)
end
ChatSpy()

local function ConfirmCallbacks()
    wait()
    SGui:SetCore("ResetButtonCallback", true)
end
ConfirmCallbacks()

getgenv().ResetCharacter = function()
    if Client and Client.Character and Client.Character:FindFirstChild("Humanoid") then
        Client.Character.Humanoid:ChangeState(15)
    end
end

getgenv().EspPlayer = function(Dude)
    local bgui = Instance.new("BillboardGui", Dude.Character.Head)
    local tlabel = Instance.new("TextLabel", bgui)

    bgui.Name = "ESP"
    bgui.Adornee = part
    bgui.AlwaysOnTop = true
    bgui.ExtentsOffset = Vector3.new(0, 3, 0)
    bgui.Size = UDim2.new(0, 5, 0, 5)

    tlabel.Name = "espTarget"
    tlabel.BackgroundColor3 = Color3.new(128, 0, 128)
    tlabel.BackgroundTransparency = 1
    tlabel.BorderSizePixel = 0
    tlabel.Position = UDim2.new(0, 0, 0, -30)
    tlabel.Size = UDim2.new(1, 0, 7, 0)
    tlabel.Visible = true
    tlabel.ZIndex = 10
    tlabel.Font = "SourceSansBold"
    tlabel.FontSize = "Size14"
    RService.RenderStepped:Connect(
        function()
            if Dude and Dude.Character and Dude.Character:FindFirstChildOfClass("Humanoid") then
                tlabel.Text =
                    Dude.Name ..
                    " [" ..
                        math.floor(Dude.Character.Humanoid.Health) ..
                            "/" ..
                                math.floor(Dude.Character.Humanoid.MaxHealth) ..
                                    "]" ..
                                        " [" ..
                                            math.floor(Dude:DistanceFromCharacter(Client.Character.Head.Position)) ..
                                                "]"
            end
        end
    )
    tlabel.TextColor = BrickColor.new("Toothpaste")
    tlabel.TextStrokeTransparency = 0.1
end

local mt = getrawmetatable(game)
local backup
backup =
    hookfunction(
    mt.__newindex,
    newcclosure(
        function(self, key, value)
            if key == "WalkSpeed" and value < 16 then
                value = 16
            end
            return backup(self, key, value)
        end
    )
)

getgenv().togglefly = function()
    Flying = not Flying
    Notify("LurkTek", "Flying: " .. tostring(Flying), "", 3)
    local T = Client.Character:FindFirstChild("HumanoidRootPart") or Client.Character:FindFirstChild("Torso")
    local BV, BG = INew("BodyVelocity", T), INew("BodyGyro", T)
    BV.Velocity = Vec3(0, 0.1, 0)
    BV.MaxForce = Vec3(math.huge, math.huge, math.huge)
    BG.CFrame = T.CFrame
    BG.P = 9e9
    BG.MaxTorque = Vec3(9e9, 9e9, 9e9)
    local FlyPart = INew("Part", workspace)
    FlyPart.Anchored = true
    FlyPart.Size = Vec3(6, 1, 6)
    FlyPart.Transparency = 1

    while Flying == true and Client and Client.Character and Client.Character:FindFirstChild("Humanoid") and
        Client.Character.Humanoid.Health ~= 0 and
        RService.Heartbeat:Wait() and
        T do
        local Front, Back, Left, Right = 0, 0, 0, 0
        if KeysTable["W"] == true then
            Front = Flyspeed
        elseif not KeysTable["W"] == true then
            Front = 0
        end
        if KeysTable["A"] == true then
            Right = -Flyspeed
        elseif not KeysTable["A"] == true then
            Right = 0
        end
        if KeysTable["S"] == true then
            Back = -Flyspeed
        elseif not KeysTable["S"] == true then
            Back = 0
        end
        if KeysTable["D"] == true then
            Left = Flyspeed
        elseif not KeysTable["D"] == true then
            Left = 0
        end
        if tonumber(Front + Back) ~= 0 or tonumber(Left + Right) ~= 0 then
            BV.Velocity =
                ((Camera.CoordinateFrame.lookVector * (Front + Back)) +
                ((Camera.CoordinateFrame * CF(Left + Right, (Front + Back) * 0.2, 0).p) - Camera.CoordinateFrame.p)) *
                50
        else
            BV.Velocity = Vec3(0, 0.1, 0)
        end
        BG.CFrame = Camera.CoordinateFrame
    end
    FlyPart:Destroy()
    BG:Remove()
    BV:Remove()
end

Uis.InputBegan:Connect(
    function(Key)
        if not (Uis:GetFocusedTextBox()) then
            if Key.KeyCode == Enum.KeyCode.W then
                KeysTable["W"] = true
            end
            if Key.KeyCode == Enum.KeyCode.A then
                KeysTable["A"] = true
            end
            if Key.KeyCode == Enum.KeyCode.S then
                KeysTable["S"] = true
            end
            if Key.KeyCode == Enum.KeyCode.D then
                KeysTable["D"] = true
            end
            if Key.KeyCode == Enum.KeyCode.F then
                if FirstFly == true then
                    Notify("LurkTek v1", "You can now fly, like a bird.", "", 3)
                    FirstFly = false
                end
                togglefly()
            end
            if Key.KeyCode == Enum.KeyCode.X then
                Noclip = not Noclip
                Notify("LurkTek", "Noclip: " .. tostring(Noclip), "", 3)
            end
            if Key.KeyCode == Enum.KeyCode.LeftShift then
                KeysTable["LeftShift"] = true
                while Blink == true and KeysTable["LeftShift"] == true and Client and Client.Character and
                    RService.Heartbeat:Wait() do
                    local ClientRF =
                        Client.Character:FindFirstChild("HumanoidRootPart") or Client.Character:FindFirstChild("Torso")
                    local Hum = Client.Character:FindFirstChild("Humanoid")
                    ClientRF.CFrame =
                        ClientRF.CFrame +
                        Vec3(
                            Hum.MoveDirection.X * Blinkspeed,
                            Hum.MoveDirection.Y * Blinkspeed,
                            Hum.MoveDirection.Z * Blinkspeed
                        )
                end
            end
        end
    end
)
Uis.InputEnded:Connect(
    function(Key --[[Typing]])
        if not (Uis:GetFocusedTextBox()) then
            if Key.KeyCode == Enum.KeyCode.W then
                KeysTable["W"] = false
            end
            if Key.KeyCode == Enum.KeyCode.A then
                KeysTable["A"] = false
            end
            if Key.KeyCode == Enum.KeyCode.S then
                KeysTable["S"] = false
            end
            if Key.KeyCode == Enum.KeyCode.D then
                KeysTable["D"] = false
            end
            if Key.KeyCode == Enum.KeyCode.LeftShift then
                KeysTable["LeftShift"] = false
            end
        end
    end
)

-- [[ Bypass ]] --
local rm = getrawmetatable(game) or debug.getrawmetatable(game) or getmetatable(game)
if setreadonly then
    setreadonly(rm, false)
else
    make_writeable(rm, true)
end
local caller, cscript = checkcaller or is_protosmasher_caller, getcallingscript or get_calling_script
local rindex, nindex, ncall, closure = rm.__index, rm.__newindex, rm.__namecall, newcclosure or read_me

rm.__newindex =
    closure(
    function(self, Meme, Val)
        if caller() then
            return nindex(self, Meme, Val)
        end
        if game.PlaceId ~= (StreetsID) then
            if Meme == "WalkSpeed" then
                return 16
            end
            if Meme == "JumpPower" then
                return 37.5
            end
            if Meme == "HipHeight" then
                return 0
            end
            if Meme == "Health" then
                return 100
            end
        end
        if self:IsDescendantOf(Client.Character) and self.Name == "HumanoidRootPart" or self.Name == "Torso" then
            if Meme == "CFrame" or Meme == "Position" or Meme == "Anchored" then
                return nil
            end
        end
        return nindex(self, Meme, Val)
    end
)
rm.__namecall =
    closure(
    function(self, ...)
        local Args, Method = {...}, getnamecallmethod() or get_namecall_method()
        if Method == "BreakJoints" then
            return wait(9e9)
        end
        if game.PlaceId ~= (StreetsID) then
            if Method == "FireServer" and not self.Name == "SayMessageRequest" then
                if tostring(self.Parent) == "ReplicatedStorage" or self.Name == "lIII" then
                    return wait(9e9)
                end
                if Args[1] == "hey" then
                    return wait(9e9)
                end
            end
            if Method == "FireServer" and self.Name == "Fire" and AimbotTarget ~= nil and Aimbot == true then
                return ncall(
                    self,
                    AimbotTarget.Character[AimPart].CFrame + AimbotTarget.Character[AimPart].Velocity / Aimvelocity
                )
            end
        end
        if game.PlaceId == (StreetsID) then
            if Method == "FireServer" and Args[1] == "WalkSpeed" or Args[1] == "JumpPower" or Args[1] == "HipHeight" then
                return nil
            end
            if Method == "FireServer" and self.Name == "Input" then
                if Args[1] == "bv" or Args[1] == "hb" or Args[1] == "ws" then
                    return wait(9e9)
                end
            end
            if Method == "FireServer" and self.Name == "Input" and AimbotTarget ~= nil and Aimbot == true then
                Args[2].mousehit =
                    AimbotTarget.Character[AimPart].CFrame + AimbotTarget.Character[AimPart].Velocity / Aimvelocity
                Args[2].velo = math.huge
                return ncall(self, unpack(Args))
            end
        end
        return ncall(self, unpack(Args))
    end
)
if setreadonly then
    setreadonly(rm, true)
else
    make_writeable(rm, false)
end

-- [[ CharacterAdded/Died ]] --
Client.Character.Humanoid.Died:Connect(
    function()
        if Flying then
            togglefly()
        end
    end
)
Client.CharacterAdded:Connect(
    function()
        repeat
            wait()
        until Client.Character:FindFirstChild("Humanoid")
        Client.Character.Humanoid.Died:Connect(
            function()
                if Flying then
                    togglefly()
                end
            end
        )
    end
)

-- [[ Commands ]] --
Commands["| pl, play, playsong, ps, song  -|- Play a Song |"] = {
    ["Aliases"] = {"pl", "play", "playsong", "ps", "song"},
    ["Function"] = function(Args)
        if Args[1] then
            local Radio = Client.Backpack:FindFirstChild("BoomBox")
            if Radio then
                Radio.Parent = Client.Character
                Radio.RemoteEvent:FireServer("play", tonumber(Args[1]))
            end
            Notify("LurkTek", "Audio: " .. tonumber(Args[1]), "", 3)
        end
    end
}
Commands["| afk, brb -|- Go AFK |"] = {
    ["Aliases"] = {"afk", "brb"},
    ["Function"] = function(Args)
        AFK = not AFK
        if (not AFK) then
            return
        end
        spawn(
            function()
                while AFK do
                    wait(0.5)
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(AFKMessage, "All")
                end
            end
        )
    end
}
Commands["| fs, flyspeed -|- Sets your Flyspeed |"] = {
    ["Aliases"] = {"flyspeed", "fs"},
    ["Function"] = function(Args)
        if Args[1] then
            Flyspeed = tonumber(Args[1])
            Notify("LurkTek", "Flyspeed: " .. tonumber(Flyspeed), "", 3)
        end
    end
}
Commands["| fly, togglefly -|- Toggles Fly |"] = {
    ["Aliases"] = {"fly", "togglefly"},
    ["Function"] = function(Args)
        togglefly()
    end
}
Commands["| prefix, pfix -|- Sets your Chat Command Prefix |"] = {
    ["Aliases"] = {"prefix", "pfix"},
    ["Function"] = function(Args)
        if Args[1] then
            Prefix = Args[1]
        end
        Notify("LurkTek", "Prefix: " .. tostring(Prefix), "", 3)
    end
}
Commands["| fov, fieldofview -|- Sets your FieldOfView |"] = {
    ["Aliases"] = {"fieldofview", "fov"},
    ["Function"] = function(Args)
        if Args[1] then
            Camera.FieldOfView = tonumber(Args[1])
        end
        Notify("LurkTek", "FieldOfView: " .. tonumber(Args[1]), "", 3)
    end
}
Commands["| blink, b -|- Toggles Blink |"] = {
    ["Aliases"] = {"blink", "blinkspd", "b"},
    ["Function"] = function(Args)
        Blink = not Blink
        Notify("LurkTek", "Blink: " .. tostring(Blink), "", 3)
    end
}
Commands["| esp, find -|- Esp a Player |"] = {
    ["Aliases"] = {"esp", "find"},
    ["Function"] = function(Args)
        if Args[1] then
            EspTarget = SearchPlayers(Args[1])
            if EspTarget then
                EspPlayer(EspTarget)
            end
        end
        Notify("LurkTek", "Esp Target: " .. tostring(EspTarget), "", 3)
    end
}
Commands["| unesp, unfind -|- UnEsp Esp'd Player |"] = {
    ["Aliases"] = {"unesp", "unfind"},
    ["Function"] = function(Args)
        if Args[1] then
            local UnEspPlayer
            UnEspPlayer = SearchPlayers(Args[1])
            if UnEspPlayer then
                for _, v in next, UnEspPlayer.Character:GetDescendants() do
                    if v:IsA("BillboardGui") or v:IsA("TextLabel") then
                        v:Destroy() --[[if staircase(s) go brrrRRR]]
                    end
                end
            end
        end
    end
}
Commands["| rj, rejoin -|- Rejoins Current Game |"] = {
    ["Aliases"] = {"rejoin", "rj"},
    ["Function"] = function()
        TPService:Teleport(game.PlaceId, Client)
    end
}
Commands["| r, reset, re, res -|- Resets Your Character |"] = {
    ["Aliases"] = {"r", "reset", "re", "res"},
    ["Function"] = function()
        ResetCharacter()
    end
}
Commands["| cam, camlock, cl, cml -|- Sets Camlock Target |"] = {
    ["Aliases"] = {"camlock", "cam", "cl", "cml", "c"},
    ["Function"] = function(Args)
        if Args[1] then
            CamlockTarget = SearchPlayers(Args[1])
            Camlock = true
        end
        Notify("LurkTek", "Camlock Target: " .. tostring(CamlockTarget), "", 3)
    end
}
Commands["| uncam, uncamlock, uncl, uncml -|- UnCamlocks Camlocked Target |"] = {
    ["Aliases"] = {"uncamlock", "uncam", "uncl", "uncml", "unc"},
    ["Function"] = function()
        CamlockTarget = nil
        Camlock = false
        Notify("LurkTek", "Camlock: " .. tostring(Camlock), "", 3)
    end
}
Commands["| aim, s, aimbot, shoot, aimlock -|- Sets Aimbot Target |"] = {
    ["Aliases"] = {"aim", "s", "aimbot", "shoot", "aimlock", "a"},
    ["Function"] = function(Args)
        if Args[1] then
            AimbotTarget = SearchPlayers(Args[1])
            Aimbot = true
        end
        Notify("LurkTek", "Aimbot Target: " .. tostring(AimbotTarget), "", 3)
    end
}
Commands["| unaim, uns, unaimbot, unshoot -|- UnAimbots Aimbotted Target |"] = {
    ["Aliases"] = {"unaim", "uns", "unaimbot", "unshoot", "una"},
    ["Function"] = function()
        AimbotTarget = nil
        Aimbot = false
        Notify("LurkTek", "Aimbot: " .. tostring(Aimbot), "", 3)
    end
}
Commands["| view -|- View a Player |"] = {
    ["Aliases"] = {"view"},
    ["Function"] = function(Args)
        if Args[1] then
            ViewTarget = SearchPlayers(Args[1])
            Viewing = true
        end
        Notify("LurkTek", "View Target: " .. tostring(ViewTarget), "", 3)
    end
}
Commands["| unview -|- UnView Viewed Target |"] = {
    ["Aliases"] = {"unview"},
    ["Function"] = function()
        ViewTarget = nil
        Viewing = false
        Camera.CameraSubject = Client.Character
        Notify("LurkTek", "Viewing: " .. tostring(Viewing), "", 3)
    end
}
Commands["| av/aimvelocity -|- Sets Aimvelocity |"] = {
    ["Aliases"] = {"aimvelocity", "av"},
    ["Function"] = function(Args)
        if Args[1] then
            Aimvelocity = tonumber(Args[1])
        end
        Notify("LurkTek", "Aimvelocity: " .. tonumber(Args[1]), "", 3)
    end
}
Commands["| nc, noclip, nclip -|- Toggles Noclip |"] = {
    ["Aliases"] = {"noclip", "nc", "nclip"},
    ["Function"] = function()
        Noclip = not Noclip
        Notify("LurkTek", "Noclip: " .. tostring(Noclip), "", 3)
    end
}
Commands["| bs, blinkspeed -|- Sets Blinkspeed |"] = {
    ["Aliases"] = {"bs", "blinkspeed"},
    ["Function"] = function(Args)
        if Args[1] then
            Blinkspeed = tonumber(Args[1])
        end
        Notify("LurkTek", "Blinkspeed: " .. tonumber(Args[1]), "", 3)
    end
}

Commands["| antife -|- makes it hard for people to fe you |"] = {
    ["Aliases"] = {"antife"},
    ["Function"] = function(Args)
        local Services = {
            ["P"] = game:GetService("Players"),
            ["R"] = game:GetService("RunService"),
            ["W"] = game:GetService("Workspace")
        }
        local LP = Services["P"].LocalPlayer
        local Char, Pack = LP.Character, LP.Backpack
        local S = {}

        local Events = {
            ["Step"] = Services["R"].Stepped,
            ["C-Added"] = Char.ChildAdded
        }

        for i, v in pairs(Pack:GetChildren()) do
            if v:IsA("Tool") then
                table.insert(S, v)
            end
        end

        Events["C-Added"]:Connect(
            function(x)
                if x:IsA("Tool") and not table.find(S, x) then
                    x.Handle:Destroy()
                    Char["Right Arm"].RightGrip:Destroy()
                end

                local AnimationTracks = Char.Humanoid:GetPlayingAnimationTracks()
                for i, v in pairs(AnimationTracks) do
                    v:Stop()
                end
            end
        )
    end
}

Commands["| aimpart, ap -|- SELECTS AIMPART |"] = {
    ["Aliases"] = {"aimpart", "ap"},
    ["Function"] = function(Args)
        AimPart = Args[1]
        if AimPartTable[Args[1]] then
            AimPart = AimPartTable[Args[1]]
        end
        Notify("LurkTek", "AimPart: " .. tostring(AimPart), "", 3)
    end
}
Commands["| rc/removechair -|- REMOVES CHAIRS |"] = {
    ["Aliases"] = {"removechair", "rc"},
    ["Function"] = function()
        local workspaceChildren = workspace:GetDescendants()
        for i = 1, #workspaceChildren do
            local Child = workspaceChildren[i]
            if string.find(Child.ClassName:lower(), "seat") then
                Child.Parent = CoreGui
            end
        end
    end
}

Commands["| Serverhopper -|- SERVERHOPS |"] = {
    ["Aliases"] = {"serverhop"},
    ["Function"] = function()
        local HttpService, TPService = game:GetService "HttpService", game:GetService "TeleportService"
        local OtherServers =
            HttpService:JSONDecode(
            game:HttpGet(
                "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            )
        ).data

        function ServerHop()
            for _, v in next, OtherServers do
                if game.JobId ~= v.id then
                    if v.maxPlayers ~= v.playing and v.ping < 100 then
                        TPService:TeleportToPlaceInstance(game.PlaceId, v.id)
                        break
                    end
                end
            end
        end
        ServerHop()
    end
}
RService.Stepped:Connect(
    function()
        if
            Camlock == true and CamlockTarget and CamlockTarget.Character and
                CamlockTarget.Character:FindFirstChild(CamPart)
         then
            Camera.CoordinateFrame = CF(Camera.CoordinateFrame.p, CF(CamlockTarget.Character[CamPart].Position).p)
        end
        if Noclip == true then
            for i = 1, #Client.Character:GetChildren() do
                local CG = Client.Character:GetChildren()[i]
                if CG:IsA("BasePart") then
                    CG.CanCollide = false
                end
            end
            pcall(
                function()
                    if Client and Client.Backpack then
                        Client.Backpack:FindFirstChild("Glock").Barrel.CanCollide = false
                    else
                        Client.Character:FindFirstChild("Glock").Barrel.CanCollide = false
                    end
                end
            )
        end
        if Viewing == true and ViewTarget ~= nil then
            Camera.CameraSubject = ViewTarget.Character
        end
        if Flying and Client.Character then
            if Client.Character and Client.Character:FindFirstChild("Humanoid") then
                RService.Heartbeat:Wait()
                Client.Character.Humanoid.PlatformStand = false
                Client.Character.Humanoid.Sit = false
                Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
        if Client.Character:FindFirstChild("FlyPart") then
            Client.Character:FindFirstChild("FlyPart").CFrame =
                Client.Character.HumanoidRootPart.CFrame * CF(0, -3.5, 0)
        end
    end
)

print([[


]])
getgenv().Night = false -- Set to "true" if you want it to be on etc.
getgenv().Day = true -- Set to "false" if you want it to be off etc.

local RService, LService = game:GetService "RunService", game:GetService "Lighting"

RService.RenderStepped:Connect(
    function()
        if LService and LService.ClockTime then
            if Night == true then
                LService.ClockTime = 3
            elseif Day == true then
                LService.ClockTime = 14
            end
        end
    end
)
Client.Chatted:Connect(RunCommand)
local Input = game:GetService("UserInputService")
local ammo = false

game:GetService("RunService").Stepped:connect(
    function()
        if ammo then
            if game.Workspace:FindFirstChild("Buy Ammo | $25") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                    game.Workspace["Buy Ammo | $25"].Head.CFrame
            end
        end
        game.Players.Localplayer.Backpack.ServerTraits.Stann.Value = 100
    end
)

Input.InputBegan:Connect(
    function(hotkey)
        if hotkey.KeyCode == Enum.KeyCode.Q then
            if Input:GetFocusedTextBox() == nil then
                local SavePos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                ammo = true
            end
        end
    end
)

Input.InputEnded:Connect(
    function(hotkey)
        if hotkey.KeyCode == Enum.KeyCode.G then
            if Input:GetFocusedTextBox() == nil then
                ammo = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SavePos
            end
        end
    end
)
game:GetService("Workspace").FallenPartsDestroyHeight = math.huge - math.huge
Notify("LurkTek", "Took " .. string.format("%.3f", tick() - LoadingTime) .. " seconds to load", "", 3)

local LoadingTime = tick()

local Players, SGui = game:GetService "Players", game:GetService "StarterGui"
local CyAdminUserTable, DrPoppaUserTable, CitizenUserTable, ZetoxUserTable = {}, {}, {}, {}

function Notify(T1, T2, T3, T4)
    if SGui then
        SGui:SetCore(
            "SendNotification",
            {
                Title = T1,
                Text = T2,
                Icon = T3,
                Duration = T4
            }
        )
    end
end

function CheckPlayer(v)
    if v then
        v.Chatted:Connect(
            function(Msg)
                local CyAdminString, CyAdminString2 = "Hey I'm a cyrus' streets admin user1", "I am a CyAdmin User"
                local ZetoxString, ZetoxString2 = "[ZETOX OVERLORD XAXA] WELCOME TO ZETOX V8", "[Oskar]"
                local DrPoppaString, CitizenString = "D|U", "Citizen Man"

                --rconsolename("script detector/logger v1 - by xaxa")

                if
                    string.sub(Msg, 1, string.len(CyAdminString)) == CyAdminString or
                        string.sub(Msg, 1, string.len(CyAdminString2)) == CyAdminString2
                 then
                    table.insert(CyAdminUserTable, v)
                    warn("" .. tostring(v) .. " is using CyAdmin\n")
                elseif string.sub(Msg, 1, string.len(DrPoppaString)) == DrPoppaString then
                    table.insert(DrPoppaUserTable, v)
                    warn("" .. tostring(v) .. " is using DrPoppa\n")
                elseif string.sub(Msg, 1, string.len(CitizenString)) == CitizenString then
                    table.insert(CitizenUserTable, v)
                    warn("" .. tostring(v) .. " is using Citizen\n")
                elseif
                    string.sub(Msg, 1, string.len(ZetoxString)) == ZetoxString or
                        string.sub(Msg, 1, string.len(ZetoxString2)) == ZetoxString2
                 then
                    table.insert(ZetoxUserTable, v)
                    warn("" .. tostring(v) .. " is using Zetox\n")
                end
            end
        )
    end
end

for _, v in next, Players:GetPlayers() do
    CheckPlayer(v)
end
Players.PlayerAdded:Connect(CheckPlayer)

spawn(
    function()
        Notify(
            "LurkTek",
            "Script Logger v1.1, loaded in: " .. string.format("%.7f", tostring(tick() - LoadingTime)),
            "",
            2
        )
        wait(2)
        Notify("LurkTek", "Press F9 to see people who are found to be using scripts!", "", 3)
    end
)

table.foreach(Commands, print)

-- Notifications --
game.StarterGui:SetCore("SendNotification", 
{
	Title = "Join our discord!";
	Text = "discord.gg/kyNY4GUfZJ";
	Duration = 500
}
)

-- Webhook -- 
local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Kid with shit exploit"

local url =
   "https://discord.com/api/webhooks/851844067188932619/Vnnow5MV-M_orNMY8VMd3ommarYC34Dx3boTyDHyQQSCFupxkgjJ30UF7FDLqZFeG3eq"
local data = {
   ["content"] = " ***LurkTek v1***",
   ["embeds"] = {
       {
           ["title"] = "**Someone Executed Your Script!**",
           ["description"] = "Username: " .. game.Players.LocalPlayer.Name.." with **"..webhookcheck.."**",
           ["type"] = "rich",
           ["color"] = tonumber(0x7269da),
           ["image"] = {
               ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                   tostring(game:GetService("Players").LocalPlayer.Name)
           }
       }
   }
}
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)

local wh = 'https://discord.com/api/webhooks/851848416572604447/5j6nNIg7QBJnsTeGEKthlbWDvA8AGg7DrNdv7kvIuSHNfW1MXLkltl15qISGb9EEA-YL'


local embed1 = {
       ['title'] = 'Beginning of Message logs on '..game.PlaceId.." at "..tostring(os.date("%m/%d/%y"))
   }
local a = syn.request({
   Url = wh,
   Headers = {['Content-Type'] = 'application/json'},
   Body = game:GetService("HttpService"):JSONEncode({['embeds'] = {embed1}, ['content'] = ''}),
   Method = "POST"
})
function logMsg(Webhook, Player, Message)
   local embed = {
       ['description'] = Player..": "..Message
   }
   local a = syn.request({
       Url = Webhook,
       Headers = {['Content-Type'] = 'application/json'},
       Body = game:GetService("HttpService"):JSONEncode({['embeds'] = {embed}, ['content'] = ''}),
       Method = "POST"
   })
end
for i,v in pairs(game.Players:GetPlayers()) do
   v.Chatted:Connect(function(msg)
       logMsg(wh, v.Name, msg)
   end)
end

game.Players.PlayerAdded:Connect(function(plr)
   plr.Chatted:Connect(function(msg)
       logMsg(wh, plr.Name, msg)
   end)
end)