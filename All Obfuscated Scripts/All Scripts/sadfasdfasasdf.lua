--[[
	id: nS2egBHljYR1-9IC0ZNyO
	name: sadfasdfasasdf
	description: asdasdfasdf
	time1: 2021-05-17 00:42:01.342982+00
	time2: 2021-05-17 00:42:01.342982+00
	uploader: 286
	uploadersession: nQYa-6eonv5yHPW7T8Z_lyYTwblgs2
	flag: f
--]]

local ply = game:GetService("Players").LocalPlayer

-- WalkSpeed no cool inf stamina
local ply = game.Players.LocalPlayer
ply.Character.Humanoid.WalkSpeed = 100
ply.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    ply.Character.Humanoid.WalkSpeed = 100
end)

ply.Character.Info.CursedEnergy.Changed:Connect(function()
    ply.Character.Info.CursedEnergy.Value = ply.Character.Info.CursedEnergyMax.Value
end)

local waitt;
waitt = hookfunction(getrenv().wait, function()
    return game:GetService("RunService").RenderStepped:wait()    
end)

local quest = {
    ["Curse Spirit[Rank:4]"] = {
        ["quest"] = workspace.NPC.GojoRank4.HumanoidRootPart
    },
    ["Curse Spirit[Rank:3]"] = {
        ["quest"] = workspace.NPC.GojoRank3.HumanoidRootPart
    },
    ["Curse Spirit[Rank:2]"] = {
        ["quest"] = workspace.NPC.GojoRank2.HumanoidRootPart
    },
    ["Curse Spirit[Rank:1]"] = {
        ["quest"] = workspace.NPC.GojoRank1.HumanoidRootPart
    },
}

local questList = {}
for i, _ in next, quest do
    table.insert(questList, i)
end

local toolt = {}
for _, v in pairs(ply.Backpack:GetChildren()) do
    if v:IsA("Tool") then table.insert(toolt, v.Name) end
end
for _, v in pairs(ply.Character:GetChildren()) do
    if v:IsA("Tool") then table.insert(toolt, v.Name) end
end

function nearest(name)
    local Distance, Closest = math.huge, nil;
    for i, v in pairs(game:GetService("Workspace").LivingThing:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == name then
            local newDistance = ply:DistanceFromCharacter(v.HumanoidRootPart.Position)
            if newDistance < Distance then
                Closest = v
                Distance = newDistance
            end
        end
    end
    return Closest, Distance
end

function attack()
    spawn(function()
        for i = 1, 4 do
            ply.Character.Combat.Combat.Attack:FireServer(i)
        end
    end)
end

function farm(mon)
    ply.Character.HumanoidRootPart.CFrame = nearest(mon).HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
    attack()
end

function equip(toolname)
    pcall(function()
        ply.Character.Humanoid:EquipTool(ply.Backpack[toolname])
    end)
end

function getquest(name)
    if ply.Quest.QuestValue.Value == 0 and ply.Quest.QuestTarget.Value == 0 then
        wait(1.5)
        local dispel = "Dispel " .. name:gsub("%[", " "):gsub("%]", "")
        ply.Character.HumanoidRootPart.CFrame = quest[name]["quest"].CFrame * CFrame.new(0, 0, 4)
        game:GetService("ReplicatedStorage").Remote.Quest:FireServer(dispel, ply.PlayerGui.Dialog.Frame, {"RespawnOnDead", "numericText", "PlayerInvite", "Interface", "SkillUI", "Fast Travel"}, "Town1", false)
    elseif ply.Quest.QuestValue.Value == ply.Quest.QuestTarget.Value and (ply.Quest.QuestValue.Value ~= 0 and ply.Quest.QuestTarget.Value ~= 0) then
        wait(1)
        game:GetService("ReplicatedStorage").Remote.SendQuest:FireServer(false)
    end
end

local questvalue = ""
local autofarm = false
local tool = ""

-- ui
local library = loadstring(game:HttpGet("https://polarhub.xyz/DOFATSUPERNOOB.lua"))()
local w = library:NewWindow("PROJECT CURSE")
local wns1 = w:NewSection("Farm")

wns1:CreateDropdown("Quest", questList, 1,function(t)
    questvalue = t
end)

wns1:CreateDropdown("Tools", toolt, 1,function(t)
    tool = t
end)

wns1:CreateToggle("AutoFarm", function(b)
    autofarm = b
end)

-- autofarm
spawn(function()
    while game:GetService("RunService").RenderStepped:wait() do
        if autofarm and questvalue then
            pcall(function()
                getquest(questvalue)
                equip(tool)
                farm(questvalue)
            end)
        end
    end
end)

-- change state
game:GetService("RunService").RenderStepped:Connect(function()
    if autofarm then
        ply.Character.Humanoid:ChangeState(11)
    end
end)
