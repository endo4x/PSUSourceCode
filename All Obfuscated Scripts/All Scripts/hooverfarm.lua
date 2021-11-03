--[[
	id: Koc9DAn0mmB67BSY569E6
	name: hooverfarm
	description: very poggers
	time1: 2021-04-23 17:40:48.848484+00
	time2: 2021-04-23 17:40:48.848485+00
	uploader: yDWCUfHEXdXQy9l5CgTsWC_sPzlMFoY1xx9_-uLG
	uploadersession: R2Dy3LZDT_KOlB1npD_0JIm_h4lHwj
	flag: f
--]]

local Client = game:GetService("Players").LocalPlayer
repeat
    wait()
until game:IsLoaded()
local Module = {}

function Module.Load(Discord, Config)
    if Discord == "https://discord.com/invite/efb7YAmpQZ" and (game.PlaceId == 2809202155 or game.PlaceId == 4643697430) then
        warn(
            "\n(-------------)\nHoover-farm (v 0.0.05)\nChangelog:\nN/A\nCredits:\nDiscord: Introvert#1337\nReason: Help with Bypass\nDiscord: Hoover#0829\nReason: Creation of script.\n(-------------)"
        )
        local Rainbow_Stuff, MeshIds, Active, InvisActive = {}, {}, {}, false
        local getscriptclosure = get_script_function or getscriptclosure
        local Krnl = KRNL_LOADED and true or false

        local Commands_Functions = {
            ["Invisible"] = function()
                local Character = game:GetService("Players").LocalPlayer.Character
                if Character:FindFirstChild("LowerTorso") and Character.LowerTorso:FindFirstChild("Root") and not Krnl then
                    delay(
                        0.1,
                        function()
                            Character.LowerTorso.Root:Destroy()
                        end
                    )
                end
            end,
            ["Godmode"] = function()
                local Character = game:GetService("Players").LocalPlayer.Character
                if Character:FindFirstChild("BindableFunction") then
                    Character["BindableFunction"]:Destroy()
                end
            end,
            ["Reset"] = function()
                local Character = game:GetService("Players").LocalPlayer.Character
                if Character:FindFirstChild("Head") then
                    Character["Head"]:Destroy()
                end
            end,
            ["Arcade"] = function()
                if not Active["Arcade"] then
                    Active["Arcade"] = true
                    wait(0.25)
                    game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(
                        "EndDialogue",
                        {["NPC"] = "Item Machine", ["Option"] = "Option1", ["Dialogue"] = "Dialogue1"}
                    )
                    wait(0.25)
                    Active["Arcade"] = false
                end
            end,
            ["Shinytron69"] = function()
                local Player = game:GetService("Players").LocalPlayer
                Player:WaitForChild("PlayerStats")

                local function Item(ItemName)
                    game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(
                        "EndDialogue",
                        {["NPC"] = ItemName, ["Option"] = "Option1", ["Dialogue"] = "Dialogue2"}
                    )
                end

                local function Learn(SkillName)
                    game:GetService("Players").LocalPlayer.Character.RemoteFunction:InvokeServer(
                        "LearnSkill",
                        {["Skill"] = SkillName, ["SkillTreeType"] = "Character"}
                    )
                end

                while wait() do
                    if Active["ShinyFarm"] == false then
                        if Player.PlayerStats.Stand.Value == "None" then
                            if Player:FindFirstChild("PityCount") then
                                local Storage = Player.PityCount.Value
                            else
                                Storage = nil
                            end

                            Learn("Agility I")
                            Learn("Agility II")
                            Learn("Agility III")
                            Learn("Worthiness I")
                            Learn("Worthiness II")

                            repeat
                                wait()
                            until Player.Character and Player.Character:FindFirstChild("Humanoid") and
                                Player.Character.Humanoid.Health > 50 and
                                Player.Character:FindFirstChildOfClass("RemoteEvent")

                            wait(1.25)

                            if not Player.Backpack:FindFirstChild("Mysterious Arrow") then
                                break
                            end

                            Item("Mysterious Arrow")

                            repeat
                                wait(0.125)
                            until Player.PlayerStats.Stand.Value ~= "None"

                            if
                                (Storage ~= nil and Player:FindFirstChild("PityCount") and
                                    Player.PityCount.Value < Storage)
                             then
                                Active["ShinyFarm"] = false

                                warn("Got a shiny " .. Player.PlayerStats.Stand.Value .. "!")
                            elseif (Player:FindFirstChild("PityCount") and Player.PityCount.Value > 0) then
                                warn("Stand log: " .. Player.PlayerStats.Stand.Value)

                                wait(0.1)

                                if not Player.Backpack:FindFirstChild("Rokakaka") then
                                    break
                                end

                                Item("Rokakaka")

                                repeat
                                    wait(0.125)
                                until Player.PlayerStats.Stand.Value == "None"
                                wait(1)
                            elseif not Player:FindFirstChild("PityCount") then
                                repeat
                                    wait(0.125)
                                until Player:FindFirstChild("PityCount")

                                warn("Stand log: " .. Player.PlayerStats.Stand.Value)

                                wait(0.1)

                                if not Player.Backpack:FindFirstChild("Rokakaka") then
                                    break
                                end

                                Item("Rokakaka")

                                repeat
                                    wait(0.125)
                                until Player.PlayerStats.Stand.Value == "None"
                            end
                        else
                            Active["ShinyFarm"] = false
                            break
                        end
                    else
                        Active["ShinyFarm"] = false
                        break
                    end
                end
            end
        }

        local Commands = {
            ["invis"] = Commands_Functions.Invisible,
            ["invisible"] = Commands_Functions.Invisible,
            ["die"] = Commands_Functions.Reset,
            ["reset"] = Commands_Functions.Reset,
            ["invincible"] = Commands_Functions.Godmode,
            ["god"] = Commands_Functions.Godmode,
            ["godmode"] = Commands_Functions.Godmode,
            ["shinyfarm"] = Commands_Functions.Shinytron69,
            ["standfarm"] = Commands_Functions.Shinytron69,
            ["shiny farm"] = Commands_Functions.Shinytron69,
            ["stand farm"] = Commands_Functions.Shinytron69,
            ["arc"] = Commands_Functions.Arcade,
            ["arcade"] = Commands_Functions.Arcade
        }

        Client.Chatted:Connect(
            function(MSG)
                for Comm, Path in pairs(Commands) do
                    if string.lower(MSG) == "/e " .. tostring(Comm) then
                        Path()
                        break
                    end
                end
            end
        )
        local function LoadBypasses()
            local mt = getrawmetatable(game)

            local namecall = mt.__namecall

            setreadonly(mt, false)
            if not krnl or krnl and Config.KRNL_Test then
                mt.__namecall =
                    newcclosure(
                    function(self, ...)
                        local args = {...}
                        if getnamecallmethod() == "FireServer" and args[1] == "Reset" and InvisActive then
                            return
                        end
                        return namecall(self, ...)
                    end
                )
            end

            local oldNewIndex = mt.__newindex

            mt.__newindex =
                newcclosure(
                function(tbl, idx, new)
                    if tbl == game:GetService("ReplicatedStorage").ItemSpawn and idx == "OnClientInvoke" then
                        local OldInvoke = new
                        new = function(...)
                            local Arguments = {...}
                            pcall(
                                function()
                                    if tostring(Arguments[2].Replica) then
                                        if Config.LogConsole == true and not Config.Unwanted_Items[Arguments[2].Replica] then
                                            warn(
                                                "\n(-------------)\nA " ..
                                                    tostring(Arguments[2].Replica) ..
                                                        " Has Spawned!\n[Despawns in 15 minutes.]\n(-------------)"
                                            )
                                        end
                                    end
                                    if tonumber(Arguments[2].RenderRange) then
                                        Arguments[2].RenderRange = math.huge
                                    end
                                end
                            )
                            return OldInvoke(...)
                        end
                    end

                    return oldNewIndex(tbl, idx, new)
                end
            )

            setreadonly(mt, true)

            local getscriptclosure = get_script_function or getscriptclosure

            getscriptclosure(game:GetService("ReplicatedFirst"):WaitForChild("ItemSpawn"))()
        end

        local MeshId = {}
        for _, Item in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Tool_Replicas"):GetChildren()) do
            if Item:FindFirstChildOfClass("MeshPart") then
                MeshId[Item:FindFirstChildOfClass("MeshPart").MeshId] = Item.Name
            elseif
                Item:FindFirstChildOfClass("Part") and
                    Item:FindFirstChildOfClass("Part"):FindFirstChildOfClass("SpecialMesh")
             then
                MeshId[Item:FindFirstChildOfClass("Part"):FindFirstChildOfClass("SpecialMesh").MeshId] = Item.Name
            end
        end

        local function ConfirmAsync(InstancePart)
            if InstancePart:IsA("MeshPart") then
                for MeshId, Name in pairs(MeshId) do
                    if MeshId == InstancePart.MeshId then
                        if
                            InstancePart.Material == Enum.Material.ForceField and
                                (Name == "Rokakaka" or Name == "Pure Rokakaka")
                         then
                            return "Pure Rokakaka"
                        elseif
                            InstancePart:FindFirstChildOfClass("Attachment") and
                                (Name == "Lucky Arrow" or Name == "Mysterious Arrow")
                         then
                            return "Lucky Arrow"
                        elseif
                            InstancePart.Material ~= Enum.Material.ForceField and
                                (Name == "Rokakaka" or Name == "Pure Rokakaka")
                         then
                            return "Rokakaka"
                        elseif
                            not InstancePart:FindFirstChildOfClass("Attachment") and
                                (Name == "Lucky Arrow" or Name == "Mysterious Arrow")
                         then
                            return "Mysterious Arrow"
                        end
                        return Name
                    end
                end
            elseif InstancePart:IsA("Part") and InstancePart:FindFirstChildOfClass("SpecialMesh") then
                for MeshId, Name in pairs(MeshId) do
                    if MeshId == InstancePart:FindFirstChildOfClass("SpecialMesh").MeshId then
                        if
                            InstancePart.Material == Enum.Material.ForceField and
                                (Name == "Rokakaka" or Name == "Pure Rokakaka")
                         then
                            return "Pure Rokakaka"
                        elseif
                            InstancePart:FindFirstChildOfClass("Attachment") and
                                (Name == "Lucky Arrow" or Name == "Mysterious Arrow")
                         then
                            return "Lucky Arrow"
                        elseif
                            InstancePart.Material ~= Enum.Material.ForceField and
                                (Name == "Rokakaka" or Name == "Pure Rokakaka")
                         then
                            return "Rokakaka"
                        elseif
                            not InstancePart:FindFirstChildOfClass("Attachment") and
                                (Name == "Lucky Arrow" or Name == "Mysterious Arrow")
                         then
                            return "Mysterious Arrow"
                        end
                        return Name
                    end
                end
            end

            return false
        end

        LoadBypasses()

        workspace:WaitForChild("Item_Spawns"):WaitForChild("Items").ChildAdded:Connect(
            function(Model)
                if Model.PrimaryPart then
                    local Status = ConfirmAsync(Model.PrimaryPart)
                    if Status ~= false and not Config.Unwanted_Items[Status] then
                        local SFX = Instance.new("Sound", workspace)

                        if Status == "Lucky Arrow" then
                            SFX.SoundId = Config.Lucky_SFX["SoundId"]
                            SFX.Volume = Config.Lucky_SFX["Volume"]
                        else
                            local Number = math.random(1, #Config.NotificationSFX)
                            SFX.SoundId = Config.NotificationSFX[Number]["SoundId"]
                            SFX.Volume = Config.NotificationSFX[Number]["Volume"]
                        end

                        SFX:Play()

                        local ESP_BillBoard = Instance.new("BillboardGui", Model.PrimaryPart)
                        ESP_BillBoard.AlwaysOnTop = true
                        ESP_BillBoard.Enabled = true
                        ESP_BillBoard.MaxDistance = math.huge
                        ESP_BillBoard.Size = UDim2.new(0, 120, 0, 30)
                        ESP_BillBoard.Active = true

                        local TextLabel = Instance.new("TextLabel", ESP_BillBoard)
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.Size = UDim2.new(0, 80, 0, 20)
                        TextLabel.TextScaled = true
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.Text = Status
                        TextLabel.TextXAlignment = "Center"
                        TextLabel.TextYAlignment = "Center"

                        game:GetService("Debris"):AddItem(SFX, 10)

                        Rainbow_Stuff[TextLabel] = {
                            grad = Instance.new("UIGradient", TextLabel),
                            counter = 0,
                            w = math.pi / 12,
                            CS = {},
                            num = 15,
                            frames = 0
                        }
                    end
                end
            end
        )

        game:GetService("RunService").Heartbeat:Connect(
            function()
                if
                    Client.Character and Client.Character:FindFirstChild("LowerTorso") and
                        not Client.Character.LowerTorso:FindFirstChild("Root")
                 then
                    if InvisActive ~= true then
                        InvisActive = true
                    end
                    Client.Character.Humanoid.WalkSpeed = 110
                    Client.Character.Humanoid.JumpPower = 200
                elseif
                    Client.Character and Client.Character:FindFirstChild("LowerTorso") and
                        Client.Character.LowerTorso:FindFirstChild("Root") and
                        InvisActive ~= false
                 then
                    InvisActive = false
                end
                for a, Values in pairs(Rainbow_Stuff) do
                    if Values.grad then
                        if Values and Values.grad ~= nil then
                            if math.fmod(Values.frames, 2) == 0 then
                                for i = 0, Values.num do
                                    local c =
                                        Color3.fromRGB(
                                        127 * math.sin(Values.w * i + Values.counter) + 128,
                                        127 * math.sin(Values.w * i + 2 * math.pi / 3 + Values.counter) + 128,
                                        127 * math.sin(Values.w * i + 4 * math.pi / 3 + Values.counter) + 128
                                    )
                                    table.insert(Values.CS, i + 1, ColorSequenceKeypoint.new(i / Values.num, c))
                                end
                                Values.grad.Color = ColorSequence.new(Values.CS)
                                Values.CS = {}
                                Values.counter = Values.counter + math.pi / 40
                                if (Values.counter >= math.pi * 2) then
                                    Values.counter = 0
                                end
                            end
                            if Values.frames >= 1000 then
                                Values.frames = 0
                            end
                            Values.frames = Values.frames + 1
                        end
                    else
                        Rainbow_Stuff[a] = nil
                    end
                end
            end
        )
    end
end

return Module
