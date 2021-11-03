--[[
	id: k9lhsl_OokC9Dmde1yAQ2
	name: AN AIMLOCK
	description: TS Aimlock scriptssss
	time1: 2021-06-02 22:19:54.957417+00
	time2: 2021-06-02 22:19:54.957417+00
	uploader: zkQJINTYCDokkDV276l6h04UTvZ3b1g9vEM2bZEA
	uploadersession: oLDDs6qN1DyMc4MHnCsVi1RR8HkEuI
	flag: f
--]]

game.StarterGui:SetCore("SendNotification", 
{
	Title = "Shut yo stupid ass up";
	Text = "nigga this ain't a script lol";
	Duration = 7
}
)
game.StarterGui:SetCore("SendNotification", 
{
	Title = "JUST KIDDING";
	Text = "Press E on someone to aimlock on them";
	Duration = 7
}
)
getgenv().SelectTargetKey = "E" -- Must be Capital due to UserInputService
getgenv().AimPart = "Torso" -- Head or Torso, Dont do HumanoidRootPart
getgenv().AV = 7 -- Sets AimVelocity, if your ping is high make sure its 7-10 / if your ping is low make sure its 4-6

local Players, Uis, RService = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService")
local Client, Mouse, Camera, CF = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new;
local Aimlock, Selecting = true, false
local StreetsID, PrisonID = tonumber(455366377), tonumber(4669040);

Uis.InputBegan:Connect(function(Key, Typing)
	if Typing then return end 
	if Key.KeyCode == Enum.KeyCode[SelectTargetKey] then 
		Selecting = true
	end
end)
Uis.InputEnded:Connect(function(Key, Typing)
	if Typing then return end 
	if Key.KeyCode == Enum.KeyCode[SelectTargetKey] then 
		Selecting = false
	end
end)

RService.Stepped:Connect(function()
	if Selecting == true and Mouse.Target.Parent:FindFirstChild("Humanoid") and Mouse.Target.Parent ~= Client.Character then
		AimlockTarget = Players:FindFirstChild(Mouse.Target.Parent.Name)
		Notify("Reapers Aimlock", "Aimlock Target: "..tostring(AimlockTarget), "", 3)
	end
end)

local rm = getrawmetatable(game) or debug.getrawmetatable(game) or getmetatable(game);
local ncall = rm.__namecall 
setreadonly(rm, false)

rm.__namecall = newcclosure(function(self, ...)
	local Ag = {...}
	local Method = getnamecallmethod()
	if Method == "FireServer" and Aimlock == true then 
		if game.PlaceId ~= (PrisonID) and tostring(self) == "Input" and AimlockTarget ~= nil then
			Ag[2].mousehit = AimlockTarget.Character[AimPart].CFrame + AimlockTarget.Character[AimPart].Velocity/AV
			return ncall(self, unpack(Ag))
		end
		if game.PlaceId == (PrisonID) and tostring(self) == "Fire" and AimlockTarget ~= nil then
			return ncall(self, AimlockTarget.Character[AimPart].CFrame + AimlockTarget.Character[AimPart].Velocity/AV)
		end
	end
	return ncall(self, unpack(Ag))
end)
setreadonly(rm, true)

local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function()
    if game.Players.LocalPlayer.Character.Humanoid then
        --print("humanoid exists")
        if game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet") then
            print("bullet exists")
            if game.Players.LocalPlayer.Character.Humanoid.Bullet:findFirstChild("Trail") then
                print("trail exists")
                if game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Name == "BulletDone" then
                    print("bullet done")
                end
                if game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet"):findFirstChild("Trail").Lifetime < 0.21 then
                    print("success!")
                    game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Trail.Lifetime = 0.21
                    game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Trail.Transparency = NumberSequence.new(0)
                    game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Trail.Color = ColorSequence.new(Color3.fromRGB(196,40,28),Color3.fromRGB(196,40,28))
                    game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Name = "BulletDone"
                end
            end
        end
    end
end)

game:GetService("Workspace").FallenPartsDestroyHeight = -1000000000000000000000

while true do
    wait()
    game.Players.LocalPlayer.Character.Stamina.Value = 100
end
