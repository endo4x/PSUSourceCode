--[[
	id: yGTyGUHxL0l_xMo2iOCwJ
	name: Script for Stands Awakening
	description: Auto Collect
	time1: 2021-05-17 02:14:20.711334+00
	time2: 2021-05-17 02:14:20.711335+00
	uploader: bQwHIkoYzcMxbLIoHCbfbNERhJuCodh4nFwK8trQ
	uploadersession: ki6Tb7_PLwnOJE_jUhhOriIElDcxCJ
	flag: f
--]]

x = 0
while x < 100 do
    for _,v in pairs(game.Workspace:GetChildren()) do
        if string.match(v.ClassName, "Tool") then
            for _,x in pairs(v:GetChildren()) do
                if string.match(x.Name,"Handle") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x.CFrame
                end
            end
        end
    end
    x = x+1
    wait(.1)
end