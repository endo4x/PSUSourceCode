--[[
	id: sh06pf2ynKiXdrM0rcmnY
	name: 1
	description: 1
	time1: 2021-04-26 17:50:23.164413+00
	time2: 2021-04-26 17:50:23.164414+00
	uploader: v0QsllQQKjaGMjxe6gf1IVJQV7XSSFKORVs_u3Nx
	uploadersession: GtCJf5fkShmk0WulmN9nDBkI0zarZF
	flag: f
--]]

while wait(0.1) do
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.DealerJob:GetDescendants()) do
        if v.ClassName == "TextButton" then
            pcall(function()
                firesignal(v.MouseButton1Click)
                for x,y in pairs(getconnections(v.MouseButton1Click)) do
                    y.Function()
                    y:Fire()
                    y.Fire()
                end
            end)
        end
end
end
