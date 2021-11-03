--[[
	id: SFFkaBgbsaaNgKgMbnqiW
	name: Arsenal fersploit hub
	description: Yes epic
	time1: 2021-05-07 20:47:28.621967+00
	time2: 2021-05-07 20:47:28.621967+00
	uploader: IdsqEvH47eelHweCwiHw-thyjj7Ys0R53H1__LJX
	uploadersession: PyOruT8lwPOMPS8dGFNKwO0IPjU-GA
	flag: f
--]]

if AntiSkidsSystemForPitzzaLovers7854938hibro then
    local Library =
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Fersploit hub v3 - Rainer - Arsenal", "Ocean")
    local Tab1 = Window:NewTab("Functions")
    local Tab2 = Window:NewTab("ESP")
    local Tab3 = Window:NewTab("Credits")
    local Section1 = Tab1:NewSection("Main Functions")
    local Section10 = Tab1:NewSection("Other Functions")
    local Section2 = Tab2:NewSection("ESP")
    local Section3 = Tab3:NewSection("Credits:")
    local Section4 = Tab3:NewSection("Ferripro")
    local Section8 = Tab3:NewSection("Clinton")
    local Section9 = Tab3:NewSection("Lil-_French_-21 - Esp")
    local Section5 = Tab3:NewSection("xHeptc - Ui lib")
    local Section6 = Tab3:NewSection("This script hub is made only for rainer")
    local Section7 = Tab3:NewSection("https://rainerexploit.xyz/")

    Section1:NewSlider(
        "Walkspeed",
        "This will increse your speed",
        300,
        25,
        function(speedvalue)
            _G.Speed = speedvalue

            local Plrs = game:GetService("Players")

            local localplr = Plrs.LocalPlayer
            local localcharacter = localplr.Character

            if localcharacter then
                local CharacterHumanoid = localcharacter.Humanoid
                CharacterHumanoid.Changed:connect(
                    function()
                        CharacterHumanoid.WalkSpeed = _G.Speed
                    end
                )
                CharacterHumanoid.WalkSpeed = _G.Speed
            end

            localplr.CharacterAdded:connect(
                function(Char)
                    localcharacter = Char
                    repeat
                        wait()
                    until Char:FindFirstChild("Humanoid")
                    local CharacterHumanoid = Char.Humanoid
                    CharacterHumanoid.Changed:connect(
                        function()
                            CharacterHumanoid.WalkSpeed = _G.Speed
                        end
                    )
                    CharacterHumanoid.WalkSpeed = _G.Speed
                end
            )
        end
    )

    Section1:NewSlider(
        "JumpPower",
        "This will increse your Jump Power",
        300,
        25,
        function(Jumpvalue)
            _G.Jump = Jumpvalue

            local Plrs = game:GetService("Players")

            local localplr = Plrs.LocalPlayer
            local localcharacter = localplr.Character

            if localcharacter then
                local CharacterHumanoid = localcharacter.Humanoid
                CharacterHumanoid.Changed:connect(
                    function()
                        CharacterHumanoid.JumpPower = _G.Jump
                    end
                )
                CharacterHumanoid.JumpPower = _G.Jump
            end

            localplr.CharacterAdded:connect(
                function(Char)
                    localcharacter = Char
                    repeat
                        wait()
                    until Char:FindFirstChild("Humanoid")
                    local CharacterHumanoid = Char.Humanoid
                    CharacterHumanoid.Changed:connect(
                        function()
                            CharacterHumanoid.JumpPower = _G.Jump
                        end
                    )
                    CharacterHumanoid.JumpPower = _G.Jump
                end
            )
        end
    )

    Section1:NewButton(
        "Hitbox extender",
        "This will make the hitbox of the people bigger",
        function()
            function getplrsname()
                for i, v in pairs(game:GetChildren()) do
                    if v.ClassName == "Players" then
                        return v.Name
                    end
                end
            end
            local players = getplrsname()
            local plr = game[players].LocalPlayer
            coroutine.resume(
                coroutine.create(
                    function()
                        while wait(1) do
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        for _, v in pairs(game[players]:GetPlayers()) do
                                            if v.Name ~= plr.Name and v.Character then
                                                v.Character.LowerTorso.CanCollide = false
                                                v.Character.LowerTorso.Material = "Neon"
                                                v.Character.LowerTorso.Size = Vector3.new(15, 15, 15)
                                                v.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15)
                                                v.Character.LowerTorso.Transparency = 1
                                                v.Character.HumanoidRootPart.Transparency = 0.7
                                            end
                                        end
                                    end
                                )
                            )
                        end
                    end
                )
            )
        end
    )

    Section1:NewButton(
        "Wallbang",
        "You will be able to shoot people even if there is walls",
        function()
            local mt = getrawmetatable(game)
            local oldNamecall = mt.__namecall
            if setreadonly then
                setreadonly(mt, false)
            else
                make_writeable(mt, true)
            end
            local namecallMethod = getnamecallmethod or get_namecall_method
            local newClose = newcclosure or function(f)
                    return f
                end

            mt.__namecall =
                newClose(
                function(...)
                    local method = namecallMethod()
                    local args = {...}

                    if tostring(method) == "FindPartOnRayWithIgnoreList" then
                        table.insert(args[3], workspace.Map)

                        return oldNamecall(unpack(args))
                    end

                    return oldNamecall(...)
                end
            )

            if setreadonly then
                setreadonly(mt, true)
            else
                make_writeable(mt, false)
            end
        end
    )

    Section1:NewButton(
        "One shoot kill",
        "1 shoot = 1 kill ez to understand",
        function()
            local mt = getrawmetatable(game)
            local setreadonly = setreadonly or function(a, b)
                    if b then
                        make_writeable(a)
                    else
                        make_readonly(a)
                    end
                end
            setreadonly(mt, false)
            local idx, nidx, ncll = mt.__index, mt.__newindex, mt.__namecall

            mt.__namecall = function(object, ...)
                if tostring(object) == "BeanBoozled" then
                    if getnamecallmethod():find("Server") then
                        print("you got detected :flushed:")
                        return "lol"
                    end
                end
                if tostring(object) == "HitPart" then
                    if getnamecallmethod():find("Server") then
                        for i = 0, 13 do
                            ncll(object, ...)
                        end
                    end
                end
                return ncll(object, ...)
            end
        end
    )

    Section10:NewButton(
        "Rainbow Gun",
        "Not made by me but this is epic asf",
        function()
            local c = 1
            function zigzag(X)
                return math.acos(math.cos(X * math.pi)) / math.pi
            end
            game:GetService("RunService").RenderStepped:Connect(
                function()
                    if game.Workspace.Camera:FindFirstChild("Arms") then
                        for i, v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                            if v.ClassName == "MeshPart" then
                                v.Color = Color3.fromHSV(zigzag(c), 1, 1)
                                c = c + .0001
                            end
                        end
                    end
                end
            )
        end
    )

    Section10:NewButton(
        "Fly (Press e)",
        "Also not made by me but this is cool",
        function()
            repeat
                wait()
            until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and
                game.Players.LocalPlayer.Character:findFirstChild("Head") and
                game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
            local mouse = game.Players.LocalPlayer:GetMouse()
            repeat
                wait()
            until mouse
            local plr = game.Players.LocalPlayer
            local torso = plr.Character.Head
            local flying = false
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0

            function Fly()
                local bg = Instance.new("BodyGyro", torso)
                bg.P = 9e4
                bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.cframe = torso.CFrame
                local bv = Instance.new("BodyVelocity", torso)
                bv.velocity = Vector3.new(0, 0.1, 0)
                bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
                repeat
                    wait()
                    plr.Character.Humanoid.PlatformStand = true
                    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                        speed = speed + .5 + (speed / maxspeed)
                        if speed > maxspeed then
                            speed = maxspeed
                        end
                    elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                        speed = speed - 1
                        if speed < 0 then
                            speed = 0
                        end
                    end
                    if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                        bv.velocity =
                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) +
                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) -
                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                            speed
                        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                    elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                        bv.velocity =
                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) +
                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) -
                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                            speed
                    else
                        bv.velocity = Vector3.new(0, 0.1, 0)
                    end
                    bg.cframe =
                        game.Workspace.CurrentCamera.CoordinateFrame *
                        CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
                until not flying
                ctrl = {f = 0, b = 0, l = 0, r = 0}
                lastctrl = {f = 0, b = 0, l = 0, r = 0}
                speed = 0
                bg:Destroy()
                bv:Destroy()
                plr.Character.Humanoid.PlatformStand = false
            end
            mouse.KeyDown:connect(
                function(key)
                    if key:lower() == "e" then
                        if flying then
                            flying = false
                        else
                            flying = true
                            Fly()
                        end
                    elseif key:lower() == "w" then
                        ctrl.f = 1
                    elseif key:lower() == "s" then
                        ctrl.b = -1
                    elseif key:lower() == "a" then
                        ctrl.l = -1
                    elseif key:lower() == "d" then
                        ctrl.r = 1
                    end
                end
            )
            mouse.KeyUp:connect(
                function(key)
                    if key:lower() == "w" then
                        ctrl.f = 0
                    elseif key:lower() == "s" then
                        ctrl.b = 0
                    elseif key:lower() == "a" then
                        ctrl.l = 0
                    elseif key:lower() == "d" then
                        ctrl.r = 0
                    end
                end
            )
            Fly()
        end
    )

    Section10:NewTextBox(
        "Spam Chat",
        "Put on the textbox the message you want to spam",
        function(Text)
            while wait(3) do
                local ohString1 = Text
                local ohBoolean2 = false
                local ohNil3 = nil
                local ohBoolean4 = false
                local ohBoolean5 = true

                game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(
                    ohString1,
                    ohBoolean2,
                    ohNil3,
                    ohBoolean4,
                    ohBoolean5
                )
            end
        end
    )

    Section2:NewButton(
        "Enable ESP + Tracers",
        "Esp + Tracers nothing more to say",
        function()
            local ESPEnabled = true
            local DistanceEnabled = true
            local TracersEnabled = true

            pcall(
                function()
                    Camera = game:GetService("Workspace").CurrentCamera
                    RunService = game:GetService("RunService")
                    camera = workspace.CurrentCamera
                    Bottom = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    function GetPoint(vector3)
                        local vector, onScreen = camera:WorldToScreenPoint(vector3)
                        return {Vector2.new(vector.X, vector.Y), onScreen, vector.Z}
                    end
                    function MakeESP(model)
                        local CurrentParent = model.Parent
                        local TopL = Drawing.new("Line")
                        local BottomL = Drawing.new("Line")
                        local LeftL = Drawing.new("Line")
                        local RightL = Drawing.new("Line")
                        local Tracer = Drawing.new("Line")
                        local Display = Drawing.new("Text")
                        coroutine.resume(
                            coroutine.create(
                                function()
                                    while model.Parent == CurrentParent do
                                        local Distance =
                                            (Camera.CFrame.Position - model.HumanoidRootPart.Position).Magnitude
                                        local GetP = GetPoint(model.Head.Position)
                                        local headps = model.Head.CFrame
                                        if ESPEnabled and GetP[2] then
                                            local topright = headps * CFrame.new(3, 0.5, 0)
                                            local topleft = headps * CFrame.new(-3, 0.5, 0)
                                            local bottomleft = headps * CFrame.new(-3, -7, 0)
                                            local bottomright = headps * CFrame.new(3, -7, 0)
                                            topright = GetPoint(topright.p)[1]
                                            topleft = GetPoint(topleft.p)[1]
                                            bottomleft = GetPoint(bottomleft.p)[1]
                                            bottomright = GetPoint(bottomright.p)[1]
                                            local teamcolor =
                                                game:GetService("Players")[model.Name].TeamColor.Color or
                                                Color3.fromRGB(0, 0, 0)
                                            TopL.Color, BottomL.Color, RightL.Color, LeftL.Color =
                                                teamcolor,
                                                teamcolor,
                                                teamcolor,
                                                teamcolor
                                            TopL.From, BottomL.From, RightL.From, LeftL.From =
                                                topleft,
                                                bottomleft,
                                                topright,
                                                topleft
                                            TopL.To, BottomL.To, RightL.To, LeftL.To =
                                                topright,
                                                bottomright,
                                                bottomright,
                                                bottomleft
                                            TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible =
                                                true,
                                                true,
                                                true,
                                                true
                                        else
                                            TopL.Visible, BottomL.Visible, RightL.Visible, LeftL.Visible =
                                                false,
                                                false,
                                                false,
                                                false
                                        end
                                        if ESPEnabled and TracersEnabled and GetP[2] then
                                            Tracer.Color =
                                                game:GetService("Players")[model.Name].TeamColor.Color or
                                                Color3.fromRGB(0, 0, 0)
                                            Tracer.From = Bottom
                                            Tracer.To = GetPoint(headps.p)[1]
                                            Tracer.Thickness = 1.5
                                            Tracer.Visible = true
                                        else
                                            Tracer.Visible = false
                                        end
                                        if ESPEnabled and DistanceEnabled and GetP[2] then
                                            Display.Visible = true
                                            Display.Position = GetPoint(headps.p + Vector3.new(0, 0.5, 0))[1]
                                            Display.Center = true
                                            Display.Text = tostring(math.floor(Distance)) .. " Distance"
                                        else
                                            Display.Visible = false
                                        end
                                        RunService.RenderStepped:Wait()
                                    end
                                    TopL:Remove()
                                    BottomL:Remove()
                                    RightL:Remove()
                                    LeftL:Remove()
                                    Tracer:Remove()
                                    Display:Remove()
                                end
                            )
                        )
                    end
                    for _, Player in next, game:GetService("Players"):GetChildren() do
                        if Player.Name ~= game.Players.LocalPlayer.Name then
                            MakeESP(Player.Character)
                            Player.CharacterAdded:Connect(
                                function()
                                    delay(
                                        0.5,
                                        function()
                                            MakeESP(Player.Character)
                                        end
                                    )
                                end
                            )
                        end
                    end
                    game:GetService("Players").PlayerAdded:Connect(
                        function(player)
                            player.CharacterAdded:Connect(
                                function()
                                    delay(
                                        0.5,
                                        function()
                                            MakeESP(player.Character)
                                        end
                                    )
                                end
                            )
                        end
                    )
                end
            )
        end
    )

    Section7:NewButton(
        "Copy Rainer Link",
        "This will copy the rainer download link",
        function()
            setclipboard("https://rainerexploit.xyz/")
        end
    )
end
