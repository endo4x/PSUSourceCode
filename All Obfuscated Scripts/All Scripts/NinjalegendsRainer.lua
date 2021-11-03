--[[
	id: xA0zkdEeogrN1_meV6LvU
	name: Ninja legends 2 - Rainer
	description: Epic gamer script yes
	time1: 2021-05-02 10:02:03.714754+00
	time2: 2021-05-02 10:02:03.714755+00
	uploader: IdsqEvH47eelHweCwiHw-thyjj7Ys0R53H1__LJX
	uploadersession: PyOruT8lwPOMPS8dGFNKwO0IPjU-GA
	flag: f
--]]

if AntiSkidsSystemForPitzzaLovers7854938hibro then
    local Library =
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Fersploit hub v3 - Rainer - Ninja legends 2", "Ocean")
    local Tab1 = Window:NewTab("Farm")
    local Tab2 = Window:NewTab("Auto buy")
    local Tab4 = Window:NewTab("Teleports")
    local Tab5 = Window:NewTab("Other stuff")
    local Tab3 = Window:NewTab("Credits")
    local Section1 = Tab1:NewSection("Farm")
    local Section2 = Tab2:NewSection("Auto buy - Main stuff")
    local Section3 = Tab3:NewSection("Credits:")
    local Section4 = Tab3:NewSection("Ferripro#0001 - Scripts")
    local Section5 = Tab3:NewSection("xHeptc - Ui lib")
    local Section6 = Tab3:NewSection("This script hub is made only for rainer")
    local Section7 = Tab3:NewSection("https://rainerexploit.xyz/")
    local Section8 = Tab2:NewSection("Auto buy - Pets")
    local Section9 = Tab4:NewSection("Unlock all islands")
    local Section10 = Tab4:NewSection("Teleports")
    local Section11 = Tab5:NewSection("Other stuff")

    Section1:NewToggle(
        "Auto swing",
        "This will farm elements automatically",
        function(state1)
            if state1 then
                _G.swing = true
                while _G.swing and wait() do
                    local args = {
                        [1] = "swingBlade"
                    }

                    game:GetService("Players").LocalPlayer.saberEvent:FireServer(unpack(args))
                end
            else
                _G.swing = false
            end
        end
    )

    Section1:NewToggle(
        "Auto sell",
        "This will sell your elements automatically",
        function(state2)
            if state2 then
                _G.autosell = true
                while _G.autosell and wait() do
                    -- Transparency of the sell circle
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleFakeInner.Transparency = 1
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleInner.Transparency = 1
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleFakeInner.HexTexture.Transparency = 1
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleFakeInner.SurfaceLight.Range = 0
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleFakeInner.areaParticle.Enabled = false -- idk why did i put this but ye, it seems like this particle does nothing but to be sure i disable it...

                    -- tp circle to -160.820587, 173.091904, 201.154694 ( cuz why not :D )
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleFakeInner.CFrame =
                        CFrame.new(-160.820587, 173.091904, 201.154694)
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleInner.CFrame =
                        CFrame.new(-160.820587, 173.091904, 201.154694)

                    -- tp cicle to you and because of the other tp it will sell cuz of the moviment
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleFakeInner.CFrame =
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                    game.workspace["sellAreaCircles"].sellAreaCircle.circleInner.CFrame =
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                end
            else
                _G.autosell = false
            end
        end
    )

    Section1:NewToggle(
        "Auto collect coins and fragments",
        "Kinda bad but ye (;",
        function(autocollect)
            if autocollect then
                _G.gay = true

                while _G.gay do
                    for i, v in pairs(game.Workspace.spawnedCoins["Shuriken City"].whichCoin:GetChildren()) do
                        if v.Name == "positionValue" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Value)
                            wait(0.01)
                        end
                    end
                end
            else
                _G.gay = false
            end
        end
    )

    Section2:NewToggle(
        "Auto buy swords",
        "This will buy swords automatically",
        function(state3)
            if state3 then
                _G.buyswords = true
                while _G.buyswords and wait() do
                    local ohString1 = "buyAllItems"
                    local ohTable2 = {
                        ["whichItems"] = "Swords",
                        ["whichPlanet"] = "Planet Chaos"
                    }

                    game:GetService("Players").LocalPlayer.saberEvent:FireServer(ohString1, ohTable2)
                end
            else
                _G.buyswords = false
            end
        end
    )

    Section2:NewToggle(
        "Auto buy crystals",
        "This will buy crystals automatically",
        function(state4)
            if state4 then
                _G.autobuycrystals = true
                while _G.autobuycrystals and wait() do
                    local ohString1 = "buyAllItems"
                    local ohTable2 = {
                        ["whichItems"] = "Crystals",
                        ["whichPlanet"] = "Planet Chaos"
                    }

                    game:GetService("Players").LocalPlayer.saberEvent:FireServer(ohString1, ohTable2)
                end
            else
                _G.autobuycrystals = false
            end
        end
    )

    Section2:NewToggle(
        "Auto buy skills",
        "This will buy skills automatically",
        function(state5)
            if state5 then
                _G.buyskills = true
                while _G.buyskills and wait() do
                    local args = {
                        [1] = "buyAllItems",
                        [2] = {
                            ["whichItems"] = "Skills",
                            ["whichPlanet"] = "Ground"
                        }
                    }

                    game:GetService("Players").LocalPlayer.saberEvent:FireServer(unpack(args))
                end
            else
                _G.buyskills = false
            end
        end
    )

    Section2:NewToggle(
        "Auto buy Evolutions",
        "This will buy Evolutions automatically",
        function(state15)
            if state15 then
                _G.buyEvolution = true
                while _G.buyEvolution and wait() do
                    local argument_1 = "buyEvolution"
                    local argument_2 = game:GetService("ReplicatedStorage").Evolutions.Ground["Spirit Warrior"]
                    local argument_3 = game:GetService("ReplicatedStorage").Evolutions.Ground["Dragon Enforcer"]
                    local argument_4 = game:GetService("ReplicatedStorage").Evolutions.Ground["Elite Soul Hunter"]
                    local argument_5 = game:GetService("ReplicatedStorage").Evolutions.Ground["Awoken Samurai"]
                    local argument_6 = game:GetService("ReplicatedStorage").Evolutions.Ground["Mystic Horizons Master"]
                    local argument_7 = game:GetService("ReplicatedStorage").Evolutions.Ground["Dark Galaxy Assasin"]
                    local argument_8 = game:GetService("ReplicatedStorage").Evolutions.Ground["Relentless Gladiator"]
                    local argument_9 = game:GetService("ReplicatedStorage").Evolutions.Ground["Unleashed Cyberninja"]
                    local argument_10 =
                        game:GetService("ReplicatedStorage").Evolutions.Ground["Ancient Millennium Beast"]
                    local argument_11 = game:GetService("ReplicatedStorage").Evolutions.Ground["Infinity Overlord"]
                    local argument_12 = game:GetService("ReplicatedStorage").Evolutions.Ground["Starstrike Megalith"]
                    local argument_13 = game:GetService("ReplicatedStorage").Evolutions.Ground["Underworld Golem"]
                    local argument_14 = game:GetService("ReplicatedStorage").Evolutions.Ground["Dark Universe Hunter"]
                    local argument_15 = game:GetService("ReplicatedStorage").Evolutions.Ground["Dual Eternity Legends"]
                    local Event = game:GetService("Players").LocalPlayer.saberEvent
                    Event:FireServer(argument_1, argument_2)
                    Event:FireServer(argument_1, argument_3)
                    Event:FireServer(argument_1, argument_4)
                    Event:FireServer(argument_1, argument_5)
                    Event:FireServer(argument_1, argument_6)
                    Event:FireServer(argument_1, argument_7)
                    Event:FireServer(argument_1, argument_8)
                    Event:FireServer(argument_1, argument_9)
                    Event:FireServer(argument_1, argument_10)
                    Event:FireServer(argument_1, argument_11)
                    Event:FireServer(argument_1, argument_12)
                    Event:FireServer(argument_1, argument_13)
                    Event:FireServer(argument_1, argument_14)
                    Event:FireServer(argument_1, argument_15)
                end
            else
                _G.buyEvolution = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Electro Orb",
        "This will buy the Electro Orb automatically",
        function(state6)
            if state6 then
                _G.ElectroOrbe = true
                while _G.ElectroOrbe and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Electro Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.ElectroOrbe = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Astral Orb",
        "This will buy the Astral Orb automatically",
        function(state7)
            if state7 then
                _G.AstralOrb = true
                while _G.AstralOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Astral Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.AstralOrb = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Sky Tempest Orb",
        "This will buy the Sky Tempest Orb automatically",
        function(state8)
            if state8 then
                _G.SkyTempestOrb = true
                while _G.SkyTempestOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Sky Tempest Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.SkyTempestOrb = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Mystic Fusion Orb",
        "This will buy the Mystic Fusion Orb automatically",
        function(state9)
            if state9 then
                _G.MysticFusionOrb = true
                while _G.MysticFusionOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Mystic Fusion Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.MysticFusionOrb = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Dark Supernova Orb",
        "This will buy the Dark Supernova Orb automatically",
        function(state10)
            if state10 then
                _G.DarkSupernovaOrb = true
                while _G.DarkSupernovaOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Dark Supernova Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.DarkSupernovaOrb = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Omega Genesis Orb",
        "This will buy the Omega Genesis Orb automatically",
        function(state11)
            if state11 then
                _G.OmegaGenesisOrb = true
                while _G.OmegaGenesisOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Omega Genesis Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.OmegaGenesisOrb = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Secret Shadows Orb",
        "This will buy the Secret Shadows Orb automatically",
        function(state12)
            if state12 then
                _G.SecretShadowsOrb = true
                while _G.SecretShadowsOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Secret Shadows Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.SecretShadowsOrb = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Forgotten Legends Orb",
        "This will buy the Forgotten Legends Orb automatically",
        function(state13)
            if state13 then
                _G.ForgottenLegendsOrb = true
                while _G.ForgottenLegendsOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Forgotten Legends Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.ForgottenLegendsOrb = false
            end
        end
    )

    Section8:NewToggle(
        "Auto buy Lightning Storm Orb",
        "This will buy the Lightning Storm Orb automatically",
        function(state14)
            if state14 then
                _G.LightningStormOrb = true
                while _G.LightningStormOrb and wait() do
                    local Argument_1 = "openOrb"
                    local Argument_2 = game:GetService("Workspace").petOrbs["Lightning Storm Orb"]
                    local Remote = game:GetService("ReplicatedStorage").rEvents.openOrbRemote
                    Remote:InvokeServer(Argument_1, Argument_2)
                end
            else
                _G.LightningStormOrb = false
            end
        end
    )

    Section9:NewButton(
        "Unlock all islands",
        "This will unlock all the islands",
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.02320886, 1485.73071, 92.155365) -- Planet Zephyr
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.93885231, 3075.3811, 98.3603363) -- Planet Inferno
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2.4789362, 4699.43506, 90.875267) -- Planet Omega
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(14.0379725, 6329.90625, 76.4663086) -- Planet Elemental
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3.10461903, 8647.16992, 87.5167313) -- Planet Chaos
        end
    )

    Section10:NewButton(
        "Zephyr",
        "",
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.02320886, 1485.73071, 92.155365)
        end
    )

    Section10:NewButton(
        "Inferno",
        "",
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.93885231, 3075.3811, 98.3603363)
        end
    )

    Section10:NewButton(
        "Omega",
        "",
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2.4789362, 4699.43506, 90.875267)
        end
    )

    Section10:NewButton(
        "Elemental",
        "",
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(14.0379725, 6329.90625, 76.4663086)
        end
    )

    Section10:NewButton(
        "Chaos",
        "",
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3.10461903, 8647.16992, 87.5167313)
        end
    )

    Section11:NewButton(
        "Max double jumps",
        "This will make you give you 50 double jumps",
        function()
            game.Players.LocalPlayer.multiJumpCount.Value = "50"
        end
    )

    Section11:NewButton(
        "Anti Afk",
        "Use this if you want to be afk +20 min",
        function()
            local VirtualUser = game:service "VirtualUser"
            game:service "Players".LocalPlayer.Idled:connect(
                function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end
            )
        end
    )

    Section11:NewButton(
        "Disable Popups",
        "This will disable all the popus",
        function()
            game:GetService("Players").LocalPlayer.PlayerGui.statEffectsGui.Enabled =
                not game:GetService("Players").LocalPlayer.PlayerGui.statEffectsGui.Enabled
        end
    )

    Section7:NewButton(
        "Copy Rainer Link",
        "This will copy the rainer download link",
        function()
            setclipboard("https://rainerexploit.xyz/")
        end
    )
else
    while true do
    end
end
