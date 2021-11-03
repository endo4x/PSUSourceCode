--[[
	id: sWiL6HVd6pmDeIRNd1W0l
	name: New LSB game
	description: .
	time1: 2021-07-11 10:34:34.608628+00
	time2: 2021-07-11 10:34:34.608634+00
	uploader: 127
	uploadersession: O-7wZTcUY97RMRIsT50dyi_Jnu6yG1
	flag: f
--]]

local UIS = game:GetService("UserInputService")
game:GetService("Players").LocalPlayer.leaderstats.Level.Value = 100
UIS.InputBegan:Connect(
    function(input, x)
        if x then
            return
        end
        if input.KeyCode == Enum.KeyCode.Return then
            game.Players.LocalPlayer.Backpack.Force.events.push:FireServer("Push")
        elseif input.KeyCode == Enum.KeyCode.V then
            game.Players.LocalPlayer.Backpack.Force.events.heal:FireServer("Heal")
        elseif input.KeyCode == Enum.KeyCode.B then
            for i = 1, 50 do
                game.Players.LocalPlayer.Backpack.Force.events.lightning:FireServer()
                wait(.1)
            end
        end
    end
)

game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(
    function(health)
        if health < 100 then
            for i = 1, 15 do
                game.Players.LocalPlayer.Backpack.Force.events.heal:FireServer("Heal")
            end
        end
    end
)
