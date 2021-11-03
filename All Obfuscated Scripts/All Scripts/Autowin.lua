--[[
	id: XBWfbJDRooKLozwhSthj-
	name: Autowin
	description: for edits
	time1: 2021-05-18 12:35:20.641424+00
	time2: 2021-05-18 12:35:20.641424+00
	uploader: 2AJVlrWYkdET3h-Y3umisa4I5U5y7l0DsHCdc6z0
	uploadersession: CCzk6UqsR_rYWbFlXWnXfFyJe8SUCV
	flag: f
--]]

print("My Stuff Variables Are Good")

repeat
    wait()
until game:IsLoaded()

-- Variables
local plr = game.Players.LocalPlayer

if
    plr.Name == getgenv().MyAlts[1] or plr.Name == getgenv().MyAlts[2] or plr.Name == getgenv().MyAlts[3] or
        plr.Name == getgenv().MyAlts[4] or
        plr.Name == getgenv().MyAlts[5]
 then
    if game.PlaceId == 3499530718 then -- Rec Place ID
        repeat
            wait()
        until game:IsLoaded()

        local Player = game.Players:FindFirstChild(getgenv().MyMain)

        Player.Chatted:Connect(
            function(chat)
                if chat:match("xcourt1") then
                    game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                        "Join Court",
                        {["Team"] = "3", ["Court"] = "1"}
                    )
                end
            end
        )

        Player.Chatted:Connect(
            function(chat)
                if chat:match("xcourt2") then
                    game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                        "Join Court",
                        {["Team"] = "3", ["Court"] = "2"}
                    )
                end
            end
        )

        Player.Chatted:Connect(
            function(chat)
                if chat:match("xcourt3") then
                    game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                        "Join Court",
                        {["Team"] = "3", ["Court"] = "3"}
                    )
                end
            end
        )

        Player.Chatted:Connect(
            function(chat)
                if chat:match("xcourt4") then
                    game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                        "Join Court",
                        {["Team"] = "3", ["Court"] = "4"}
                    )
                end
            end
        )

        Player.Chatted:Connect(
            function(chat)
                if chat:match("xrejoin") then
                    game.ReplicatedStorage.GameRemotes.Leave:InvokeServer("Plaza")
                end
            end
        )

        Player.Chatted:Connect(
            function(chat)
                if chat:match("xleave") then
                    game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer("Leave Court")
                end
            end
        )

        print("In Rec, Calling Remotes.")

        z = game:GetService("Players")
        v = z[getgenv().MyMain]

        repeat
            wait()
        until game.Players:FindFirstChild(getgenv().MyAlts[1])

        print("Find First Child Worked")

        function createparty() -- Party Create
            local plr = game.Players.LocalPlayer
            if plr.Name == getgenv().MyAlts[1] then
                local args = {
                    [1] = "Start Party",
                    [2] = getgenv().PartyCode
                }
                game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(unpack(args))
            else
                print("Party Not Started")
            end
        end

        createparty()

        function partyjoin() -- Party Join
            local plr = game.Players.LocalPlayer
            wait(0.5)
            if plr.Name == getgenv().MyAlts[2] then
                local A_1 = "Join Party"
                local A_2 = getgenv().PartyCode
                local Event = game:GetService("ReplicatedStorage").GameRemotes.RecCommands
                Event:InvokeServer(A_1, A_2)
            end
            print("Alt 1 Joined")
            wait(0.5)
            if plr.Name == getgenv().MyAlts[3] then
                local A_1 = "Join Party"
                local A_2 = getgenv().PartyCode
                local Event = game:GetService("ReplicatedStorage").GameRemotes.RecCommands
                Event:InvokeServer(A_1, A_2)
            end
            print("Alt 2 Joined")
            wait(0.5)
            if plr.Name == getgenv().MyAlts[4] then
                local A_1 = "Join Party"
                local A_2 = getgenv().PartyCode
                local Event = game:GetService("ReplicatedStorage").GameRemotes.RecCommands
                Event:InvokeServer(A_1, A_2)
            end
            print("Alt 3 Joined")
            wait(0.5)
            if plr.Name == getgenv().MyAlts[5] then
                local A_1 = "Join Party"
                local A_2 = getgenv().PartyCode
                local Event = game:GetService("ReplicatedStorage").GameRemotes.RecCommands
                Event:InvokeServer(A_1, A_2)
            end
        end

        partyjoin()

        function autowin()
            game.Players.LocalPlayer.Values.InGame:GetPropertyChangedSignal("Value"):Connect(
                function()
                    if game.Players.LocalPlayer.Values.InGame.Value == true then
                        game.TeleportService:Teleport(2621503555)
                    end
                end
            )
        end

        autowin()

        for i = 1, 1 do
            Speed = getgenv().TweenSpeed
            local tween =
                game:GetService("TweenService"):Create(
                game.Players.LocalPlayer.Character.HumanoidRootPart,
                TweenInfo.new(Speed),
                {
                    CFrame = CFrame.new(0.331190109, 4.3794961, 0.231884748)
                }
            )
            tween:Play()
            tween.Completed:Wait()
        end

        while getgenv().Autowin do
            if
                game.Players.LocalPlayer:WaitForChild("Values").Party.Value == "" or
                    game.Players.LocalPlayer:WaitForChild("Values").Party.Value == " " or
                    game.Players.LocalPlayer:WaitForChild("Values").Party.Value == nil
             then
                print("Party Value Was Nil Rejoining Now")
                createparty()
                partyjoin()
            end
            wait(1)
            if v.Values.OnCourt.Value == 1 then
                print("Joining Court 1")

                Speed = getgenv().TweenSpeed
                local tween =
                    game:GetService("TweenService"):Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    TweenInfo.new(Speed),
                    {
                        CFrame = CFrame.new(-9.29612923, 4.45891666, -73.7739716)
                    }
                )
                tween:Play()
                tween.Completed:Wait()

                game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                    "Join Court",
                    {["Team"] = "3", ["Court"] = "1"}
                )
            end
            if v.Values.OnCourt.Value == 2 then
                Speed = getgenv().TweenSpeed
                local tween =
                    game:GetService("TweenService"):Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    TweenInfo.new(Speed),
                    {
                        CFrame = CFrame.new(-9.25432396, 4.45891666, 73.4090347)
                    }
                )
                tween:Play()
                tween.Completed:Wait()

                game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                    "Join Court",
                    {["Team"] = "3", ["Court"] = "2"}
                )
                print("Joining Court 2")
            end
            if v.Values.OnCourt.Value == 3 then
                print("Joining Court 3")

                Speed = getgenv().TweenSpeed
                local tween =
                    game:GetService("TweenService"):Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    TweenInfo.new(Speed),
                    {
                        CFrame = CFrame.new(8.33936119, 4.45891619, -74.6488495)
                    }
                )
                tween:Play()
                tween.Completed:Wait()

                game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                    "Join Court",
                    {["Team"] = "3", ["Court"] = "3"}
                )
            end
            if v.Values.OnCourt.Value == 4 then
                print("Joining Court 4")

                Speed = getgenv().TweenSpeed
                local tween =
                    game:GetService("TweenService"):Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    TweenInfo.new(Speed),
                    {
                        CFrame = CFrame.new(8.23485088, 4.45891619, 72.1952744)
                    }
                )
                tween:Play()
                tween.Completed:Wait()

                game:GetService("ReplicatedStorage").GameRemotes.RecCommands:InvokeServer(
                    "Join Court",
                    {["Team"] = "3", ["Court"] = "4"}
                )
            end
        end
    elseif game.PlaceId == 2846331718 then
        print("In Plaza, Joining Main.")
        repeat
            wait()
        until game:IsLoaded()
        while getgenv().Autowin do
            wait(1)
            if game.Players.LocalPlayer.Name == getgenv().MyAlts[1] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().MyAlts[2] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().MyAlts[3] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().MyAlts[4] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().MyAlts[5] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().ServerFillers[1] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().ServerFillers[2] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().ServerFillers[3] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().ServerFillers[4] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            elseif game.Players.LocalPlayer.Name == getgenv().ServerFillers[5] then
                game:GetService("ReplicatedStorage").GameRemotes.FriendCommands:InvokeServer(getgenv().MyMain, "Follow")
            end
        end
    end
end

repeat
    wait()
until game:IsLoaded() == true
if game.Players.LocalPlayer.Name == getgenv().MyAlts[1] then
    if game.PlaceId == 2621503555 then
        if game:IsLoaded() == true then
            rconsoleprint("@@YELLOW@@")
            rconsoleprint("[Client]: Attempt to select builds.\n")
            while not game:IsLoaded() do
                wait(2)
                end
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("Agreement")
                game.ReplicatedStorage.Remotes.Settings:InvokeServer("GetData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("GetMyPlayerData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("SelectMyPlayer", "2")

            wait(2)

            if game.PlaceId == 2621503555 then
                rconsoleprint("@@RED@@")
                rconsoleprint("[Game]: Attempts : 3\n")
                wait(1)
                rconsoleprint("[Game]: Attempts have FAILED!, rejoining.\n")
                game.TeleportService:Teleport(2621503555)
            else
                rconsoleprint("@@GREEN@@")
                rconsleprint("[Game]: Attempt Successful! \n")
            end
        end
    end
end

repeat
    wait()
until game:IsLoaded() == true
if game.Players.LocalPlayer.Name == getgenv().MyAlts[2] then
    if game.PlaceId == 2621503555 then
        if game:IsLoaded() == true then
            rconsoleprint("@@YELLOW@@")
            rconsoleprint("[Client]: Attempt to select builds.\n")
            while not game:IsLoaded() do
                wait(2)
                end
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("Agreement")
                game.ReplicatedStorage.Remotes.Settings:InvokeServer("GetData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("GetMyPlayerData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("SelectMyPlayer", "2")

            wait(2)

            if game.PlaceId == 2621503555 then
                rconsoleprint("@@RED@@")
                rconsoleprint("[Game]: Attempts : 3\n")
                wait(1)
                rconsoleprint("[Game]: Attempts have FAILED!, rejoining.\n")
                game.TeleportService:Teleport(2621503555)
            else
                rconsoleprint("@@GREEN@@")
                rconsleprint("[Game]: Attempt Successful! \n")
            end
        end
    end
end

repeat
    wait()
until game:IsLoaded() == true
if game.Players.LocalPlayer.Name == getgenv().MyAlts[3] then
    if game.PlaceId == 2621503555 then
        if game:IsLoaded() == true then
            rconsoleprint("@@YELLOW@@")
            rconsoleprint("[Client]: Attempt to select builds.\n")
            while not game:IsLoaded() do
                wait(2)
                end
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("Agreement")
                game.ReplicatedStorage.Remotes.Settings:InvokeServer("GetData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("GetMyPlayerData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("SelectMyPlayer", "2")

            wait(2)

            if game.PlaceId == 2621503555 then
                rconsoleprint("@@RED@@")
                rconsoleprint("[Game]: Attempts : 3\n")
                wait(1)
                rconsoleprint("[Game]: Attempts have FAILED!, rejoining.\n")
                game.TeleportService:Teleport(2621503555)
            else
                rconsoleprint("@@GREEN@@")
                rconsleprint("[Game]: Attempt Successful! \n")
            end
        end
    end
end

repeat
    wait()
until game:IsLoaded() == true
if game.Players.LocalPlayer.Name == getgenv().MyAlts[4] then
    if game.PlaceId == 2621503555 then
        if game:IsLoaded() == true then
            rconsoleprint("@@YELLOW@@")
            rconsoleprint("[Client]: Attempt to select builds.\n")
            while not game:IsLoaded() do
                wait(2)
                end
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("Agreement")
                game.ReplicatedStorage.Remotes.Settings:InvokeServer("GetData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("GetMyPlayerData")
                game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("SelectMyPlayer", "2")

            wait(2)

            if game.PlaceId == 2621503555 then
                rconsoleprint("@@RED@@")
                rconsoleprint("[Game]: Attempts : 3\n")
                wait(1)
                rconsoleprint("[Game]: Attempts have FAILED!, rejoining.\n")
                game.TeleportService:Teleport(2621503555)
            else
                rconsoleprint("@@GREEN@@")
                rconsleprint("[Game]: Attempt Successful! \n")
            end
        end
    end
end

repeat
    wait()
until game:IsLoaded() == true
if game.Players.LocalPlayer.Name == getgenv().MyAlts[5] then
    if game.PlaceId == 2621503555 then
        if game:IsLoaded() == true then
            rconsoleprint("@@YELLOW@@")
            rconsoleprint("[Client]: Attempt to select builds.\n")
            while not game:IsLoaded() do
            wait(2)
            end
            game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("Agreement")
            game.ReplicatedStorage.Remotes.Settings:InvokeServer("GetData")
            game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("GetMyPlayerData")
            game.ReplicatedStorage.Remotes.ServerCommand:InvokeServer("SelectMyPlayer", "2")

            wait(2)

            if game.PlaceId == 2621503555 then
                rconsoleprint("@@RED@@")
                rconsoleprint("[Game]: Attempts : 3\n")
                wait(1)
                rconsoleprint("[Game]: Attempts have FAILED!, rejoining.\n")
                game.TeleportService:Teleport(2621503555)
            else
                rconsoleprint("@@GREEN@@")
                rconsleprint("[Game]: Attempt Successful! \n")
            end
        end
    end
end

if game.PlaceId == 2846331718 then
    rconsoleprint("@@GREEN@@")
    rconsoleprint("[Game]: Attempt(s) Successful!\n")
end
