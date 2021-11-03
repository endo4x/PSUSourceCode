--[[
	id: tVTuJ_oodMKJe0HfHRv-I
	name: brick of death
	description: bricky
	time1: 2021-06-24 05:01:48.190363+00
	time2: 2021-06-24 05:01:48.190364+00
	uploader: IQg4mqx2nSqrNhhwqQJQsRA3fOoYnpcEj54PHKBi
	uploadersession: hrJZcYB7Y83eOX4_GMxyxZ9urLsWM0
	flag: f
--]]

local kek = Instance.new("Part",workspace)
kek.Size = Vector3.new(5,5,5)
kek.CFrame = CFrame.new(0,0,0)
kek.BrickColor = BrickColor.new(0,0,0)
local smoky = Instance.new("Smoke",kek)
smoky.Color = Color3.new(0,0,0)
smoky.Size = Vector3.new(2.5,70,2.5)
local firey = Instance.new("Fire",kek)
firey.Color = Color3.new(0,0,0)
firey.SecondaryColor = Color3.new(0,0,0)
firey.Size = Vector3.new(10,180,10)
local sparkles = Instance.new("Sparkles",kek)
sparkles.SparkleColor = Color3.new(0,0,0)
function eef(hydro)
    local ass = hydro.Parent
    if ass:FindFirstChild"Humanoid" then
        local message = Instance.new("Message",game.Workspace)
        wait(3)
        message.Text = "HAHAHA u have stepped on the part of death die fool"
        wait(3)
        message:Destroy()
        ass.Humanoid.Health = 0
    end
end
eef(game.Players.LocalPlayer.Character.Head)
kek.Touched:Connect(eef)