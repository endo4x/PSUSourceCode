--[[
	id: Muw21d4cytY8Do8y-2SrH
	name: Berry Bush Counter
	description: Yeah
	time1: 2021-04-27 17:41:58.077815+00
	time2: 2021-04-27 17:41:58.077815+00
	uploader: 2111
	uploadersession: EpkmsGQ04QjAe5jJSSu9_d9SIw7_H9
	flag: f
--]]

print"Made by Ruichao"
berry = 0
local Island = workspace.Islands:FindFirstChild(game.Players.LocalPlayer.UserId .. "-island")
for i,v in pairs(Island.Blocks:GetChildren()) do
    if v.Name == "berryBush" then
        berry = berry+1
    end
end
berryinv = game.Players.LocalPlayer.StarterGear.berryBushSeeds.Amount.Value
berrytotal = berry+berryinv
berrysellfor = game.Players.LocalPlayer.Backpack.berryHarvested.Amount.Value*22
print("You have " .. berrytotal .. " berry bushes!, " .. berry .. " placed, and " .. berryinv..  " in your inventory! As well as that, you can sell all of your berries for " .. berrysellfor .. " coins!")