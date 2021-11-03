--[[
	id: 9BEl7oSft-IdvrrOb1-52
	name: poop
	description: s
	time1: 2021-05-24 14:39:19.147035+00
	time2: 2021-05-24 14:39:19.147036+00
	uploader: 914
	uploadersession: LLJ_UhqXp2crsMlDA0JnhAnVxN_epQ
	flag: f
--]]

if not _ or not _ == "Made by Vexxi / Dаvid#2586" then return end
local Services = setmetatable({}, {
    __index = function(self, k)
        return game:GetService(k)
    end
})
local Players = Services.Players
local UserInputService = Services.UserInputService
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

UserInputService.InputBegan:Connect(function(Input, Gpe)
    if Gpe then return end
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        local Player, Character; local Target = Mouse.Target
        Player = (Target.Parent:IsA("Accessory") and Players:GetPlayerFromCharacter(Target.Parent.Parent)) or Players:GetPlayerFromCharacter(Target.Parent)
        if Player then
            Character = Player.Character
            if Character then
                if Character:FindFirstChild("BoomBox") then
                    for _, BoomBox in pairs(Character:GetChildren()) do
                        if BoomBox.Name == "BoomBox" and BoomBox:IsA("Tool") then
                            local Sound = BoomBox:FindFirstChild("Sound", true)
                            Sound.Playing = false
                            if Sound then
                                Sound.Playing = false
                            end
                        end
                    end
                else
                    if Player.Backpack:FindFirstChild("BoomBox") then
                        for _, BoomBox in pairs(Player.Backpack:GetChildren()) do
                            if BoomBox.Name == "BoomBox" and BoomBox:IsA("Tool") then
                                local Sound = BoomBox:FindFirstChild("Sound", true)
                                Sound.Playing = false
                                if Sound then
                                    Sound.Playing = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)