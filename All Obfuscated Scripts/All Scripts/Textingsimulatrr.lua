--[[
	id: FoztRK_jII8CEAPFDZ4mI
	name: Texting simulatrr 
	description: N/A
	time1: 2021-07-02 20:51:30.787514+00
	time2: 2021-07-02 20:51:30.787515+00
	uploader: TQKJkwBB_B_075gl8RhlmKDVH9u2z6gkF4CH2NNE
	uploadersession: tv6OGaGwlXEi0KTCoX99qVDrMEfwNX
	flag: f
--]]

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/twink"))()

local MainUI = UILibrary.Load("CutieHub - Texting Simulator ")
local SecondPage = MainUI.AddPage("Main")
local FirstPage = MainUI.AddPage("Teleports")
local ThirdPage = MainUI.AddPage("Credits")

     local plr = game.Players.LocalPlayer
        local char = plr.Character
        local A_1 = "Phone"
local TweenService = game:GetService("TweenService")
local yes = false


local imadethis = ThirdPage.AddLabel("Made By Toyota#0001")
local wetwipescredits = ThirdPage.AddLabel("TY WetWipes You Taught Me Everything!")







local Teleports = FirstPage.AddButton("First Level", function()
TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(292.381012, 10.40000153, 906.361023)}):Play()
end)


local Teleports = FirstPage.AddButton("Second Level", function()
TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(765.381165, 10.26317596, 949.361145)}):Play()
end)


local Teleports = FirstPage.AddButton("Third Level", function()
TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(1175.11108, 10.26317596, 969.313599)}):Play()
end)




local Teleports = FirstPage.AddButton("Fourth Level", function()
TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(1571.86182, 10.82361603, 967.216858)}):Play()
end)








local whateveryouwannacallthis = SecondPage.AddButton("AutoFarm", function()
 repeat
     wait()
 while wait() do
game:GetService("ReplicatedStorage").Events.SendTexts:FireServer(A_1)
TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(-250.243164, 10.73664761, 897.5578)}):Play() 
game:GetService("ReplicatedStorage").Events.SendTexts:FireServer(A_1)
wait()
game:GetService("ReplicatedStorage").Events.SendTexts:FireServer(A_1)
TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(-200.243164, 7.73664761, 897.5578)}):Play()
game:GetService("ReplicatedStorage").Events.SendTexts:FireServer(A_1)
end
until yes


end)