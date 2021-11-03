--[[
	id: EzuMgJqDwvNq6Q3mW4Mo6
	name: Dupe
	description: Dupe
	time1: 2021-05-09 11:37:19.041639+00
	time2: 2021-05-09 11:37:19.04164+00
	uploader: 2111
	uploadersession: EpkmsGQ04QjAe5jJSSu9_d9SIw7_H9
	flag: f
--]]

for i, v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
    if v.Name == "Amount" then
        v.Value = v.Value * 2
    end
end
