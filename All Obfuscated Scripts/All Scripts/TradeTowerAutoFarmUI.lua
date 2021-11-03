--[[
	id: Kzl8cMakr4BwPP94vDoIq
	name: Trade Tower Auto Farm UI
	description: Trade Tower Auto Farm UI
	time1: 2021-06-24 05:48:22.366542+00
	time2: 2021-06-24 05:48:22.366542+00
	uploader: kbxlwele36ZEc-dSGC10i0BLeFXAyuz8hxxC9bc9
	uploadersession: etbrqEE7il1pFWk013w17bsZs5Mho8
	flag: f
--]]

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local UI = Material.Load({
     Title = "Trade Tower Auto Farm UI",
     Style = 3,
     SizeX = 300,
     SizeY = 250,
     Theme = "Light"
})

local Page = UI.New({
    Title = "Auto Clicker"
})

Page.Button({
    Text = "Auto Clicker",
    Callback = function()
       getgenv().autoclicker = true;

while wait() do
    if getgenv().autoclicker == true then
game:GetService("ReplicatedStorage").Events.Click:FireServer()
end
end
    end
})

Page.Button({
    Text = "Turn Off Auto Clicker",
    Callback = function()
        getgenv().autoclicker = false;    
    end
})

local Page2 = UI.New({
    Title = "Auto Crate Openers"
})

Page2.Button({
    Text = "Starter Case Opener",
    Callback = function()
        getgenv().starter = true;

while wait() do
    if getgenv().starter == true then
local args = {
    [1] = "Starter"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Starter Case Opener",
    Callback = function()
        getgenv().starter = false;    
    end
})

Page2.Button({
    Text = "Noobie Case Opener",
    Callback = function()
        getgenv().noobie = true;

while wait() do
    if getgenv().noobie == true then
local args = {
    [1] = "Noobie"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Noobie Case Opener",
    Callback = function()
        getgenv().noobie = false;    
    end
})

Page2.Button({
    Text = "Learning Case Opener",
    Callback = function()
                getgenv().learning = true;

while wait() do
    if getgenv().learning == true then
local args = {
    [1] = "Learning"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Learning Case Opener",
    Callback = function()
        getgenv().learning = false;    
    end
})

Page2.Button({
    Text = "Business Case Opener",
    Callback = function()
        getgenv().business = true;

while wait() do
    if getgenv().business == true then
local args = {
    [1] = "Business"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Business Case Opener",
    Callback = function()
        getgenv().business = false;    
    end
})

Page2.Button({
    Text = "Legendary Case Opener",
    Callback = function()
        getgenv().legendary = true;

while wait() do
    if getgenv().legendary == true then
local args = {
    [1] = "Legendary"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Legendary Case Opener",
    Callback = function()
        getgenv().legendary = false;    
    end
})

Page2.Button({
    Text = "Marcellus Case Opener",
    Callback = function()
        getgenv().marcellus = true;

while wait() do
    if getgenv().marcellus == true then
local args = {
    [1] = "Marcellus"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Marcellus Case Opener",
    Callback = function()
        getgenv().marcellus = false;    
    end
})

Page2.Button({
    Text = "Famous Case Opener",
    Callback = function()
        getgenv().famous = true;

while wait() do
    if getgenv().famous == true then
local args = {
    [1] = "Famous"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Famous Case Opener",
    Callback = function()
        getgenv().famous = false;    
    end
})

Page2.Button({
    Text = "Mythic Case Opener",
    Callback = function()
        getgenv().mythic = true;

while wait() do
    if getgenv().mythic == true then
local args = {
    [1] = "Mythic"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Mythic Case Opener",
    Callback = function()
        getgenv().mythic = false;    
    end
})

Page2.Button({
    Text = "Eirene",
    Callback = function()
        getgenv().eirene = true;

while wait() do
    if getgenv().eirene == true then
local args = {
    [1] = "Eirene"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end     
    end
})

Page2.Button({
    Text = "Turn Off Eirene Case Opener",
    Callback = function()
        getgenv().eirene = false;    
    end
})

Page2.Button({
    Text = "Aeschylus Case Opener",
    Callback = function()
        getgenv().aeschylus = true;

while wait() do
    if getgenv().aeschylus == true then
local args = {
    [1] = "Aeschylus"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Aeschylus Case Opener",
    Callback = function()
        getgenv().aeschylus = false;    
    end
})

Page2.Button({
    Text = "Olysseus Case Opener",
    Callback = function()
        getgenv().olysseus = true;

while wait() do
    if getgenv().olysseus == true then
local args = {
    [1] = "Olysseus"
}

game:GetService("ReplicatedStorage").Events.OpenCase:InvokeServer(unpack(args))
end
end    
    end
})

Page2.Button({
    Text = "Turn Off Olysseus Case Opener",
    Callback = function()
        getgenv().olysseus = false;    
    end
})

local Page3 = UI.New({
    Title = "Auto Upgrade"
})

Page3.Button({
    Text = "Auto Upgrade",
    Callback = function()
getgenv().Upgrader = true
while wait() do
    if getgenv().Upgrader == true then
local args = {
    [1] = "Upgrade"
}

game:GetService("ReplicatedStorage").Events.StoreActions:InvokeServer(unpack(args))

end
end
end
})

Page3.Button({
    Text = "Turn Off Auto Upgrade",
    Callback = function()
getgenv().Upgrader = false
end
})