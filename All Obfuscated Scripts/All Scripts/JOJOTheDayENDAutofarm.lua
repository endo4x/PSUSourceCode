--[[
	id: cbpOr65LBZTNzJBNHI7Xn
	name: JOJO: The Day END Autofarm
	description: Press E to stop, press R to resume
	time1: 2021-07-21 06:26:56.355802+00
	time2: 2021-07-21 06:26:56.355803+00
	uploader: bQwHIkoYzcMxbLIoHCbfbNERhJuCodh4nFwK8trQ
	uploadersession: ki6Tb7_PLwnOJE_jUhhOriIElDcxCJ
	flag: f
--]]

y = game.Workspace.The_FoIder:WaitForChild("HumanoidRootPart")
x = 0
local userInputService = game:GetService("UserInputService")
while true do
    while x < 1 do
        userInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- END AND PARENTHESES
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.E then
                    x = 1
                end
            end
        end)
        for _,v in pairs(game.Workspace:GetChildren()) do
        if string.match(v.ClassName, "Tool") then
            for _,x in pairs(v:GetChildren()) do
                if string.match(x.Name,"Handle") then
                    if y then
                        x.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        end
                    end
                end
            end
        end
        for _,v in pairs(game.Workspace:GetChildren()) do
            if string.match(v.Name, "Arrow") then
                for _,x in pairs(v:GetChildren()) do
                    if string.match(x.Name,"Meshes/Arrow_Cube") then
                        if y then
                            x.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        end
                    end
                end
            end
        end
        for _,v in pairs(game.Workspace:GetChildren()) do
            if string.match(v.Name, "Rokakaka Fruit") then
                for _,x in pairs(v:GetChildren()) do
                    if string.match(x.Name,"Meshes/Rokakakaka") then
                        if y then
                            x.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        end
                    end
                end
            end
        end
        wait(.1)
    end
    userInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- END AND PARENTHESES
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.R then
                x = 0
            end
        end
    end)
    wait(.1)
end