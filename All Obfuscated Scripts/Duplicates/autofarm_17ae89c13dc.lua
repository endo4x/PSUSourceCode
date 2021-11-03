--[[
	id: xQVUK-1s7nEMpAjbXyjMD
	name: autofarm
	description: lol
	time1: 2021-04-25 03:57:13.580855+00
	time2: 2021-04-25 03:57:13.580856+00
	uploader: v0QsllQQKjaGMjxe6gf1IVJQV7XSSFKORVs_u3Nx
	uploadersession: GtCJf5fkShmk0WulmN9nDBkI0zarZF
	flag: f
--]]

_G.lfautofarm = true

while _G.lfautofarm do
    wait(6)
for i,v in pairs(workspace:GetDescendants()) do
            if v:IsA("ClickDetector") then
                fireclickdetector(v)
            end
end
    end