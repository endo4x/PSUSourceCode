--[[
	id: aDdqvsmWivAsAQriA-9M2
	name: [BETA] Stands Awakening
	description: Beta
	time1: 2021-05-24 15:19:56.557644+00
	time2: 2021-05-24 15:19:56.557644+00
	uploader: bQwHIkoYzcMxbLIoHCbfbNERhJuCodh4nFwK8trQ
	uploadersession: ki6Tb7_PLwnOJE_jUhhOriIElDcxCJ
	flag: f
--]]

y = game.Workspace.ROBLOX_aIternate:WaitForChild("HumanoidRootPart")
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
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x.CFrame
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