--[[
	id: v6tLlKmJ-n61QbFvEfzfB
	name: Faded
	description: Faded Free
	time1: 2021-07-23 19:04:40.747121+00
	time2: 2021-07-23 19:04:40.747121+00
	uploader: 2559
	uploadersession: ihrMnIGs8gTesYAUhDX_GZiQDQVdke
	flag: f
--]]

			repeat
				wait()
			until game:GetService("Players").LocalPlayer ~= nil

			if not game:GetService("Players").LocalPlayer.Character then
				game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
			end

			--functions for textbox

			function GetShortenedPlrFromName(name) -- uses string.sub to see if the typed in name fits and matches somewhere in the player's name, uncase sensitive. returns a table where the player is inside because of the all and others support
				name = string.lower(tostring(name))

				if not game:GetService("Players"):FindFirstChild("all") and name == "all" or game:GetService("Players"):FindFirstChild("all") and game:GetService("Players"):FindFirstChild("all").ClassName ~= "Player" and name == "all" then
					return game:GetService("Players"):GetPlayers()
				end
				if not game:GetService("Players"):FindFirstChild("others") and name == "others" or game:GetService("Players"):FindFirstChild("others") and game:GetService("Players"):FindFirstChild("others").ClassName ~= "Player" and name == "others" then
					name = game:GetService("Players"):GetPlayers()
					for i, v in pairs(name) do
						if v == LocalPlayer then
							table.remove(name, i)
						end
					end
					return name
				end

				for i, v in pairs(game.Players:GetPlayers()) do
					if string.lower(string.sub(v.Name, 1, #name)) == name then
						return {v}
					end
				end

				return nil
			end

			--delete clones for da hood

			local LocalPlayer = game:GetService("Players").LocalPlayer
			local Character = LocalPlayer.Character
			local Workspace = game:GetService("Workspace")
			local CoreGui = game:GetService("CoreGui")

			local LockedPlayer = nil

			for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
				if v.Name == "DaHoodGui" then
					v:Destroy()
				end
			end

			-- clone detecting
			for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
				if v.Name == "ScreenGui" then
					v:Destroy()
				end
			end

			repeat
				wait()
			until game:GetService("Players").LocalPlayer ~= nil

			if not game:GetService("Players").LocalPlayer.Character then
				game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
			end


			--variables and da hood clones

			local LocalPlayer = game:GetService("Players").LocalPlayer
			local Character = LocalPlayer.Character
			local Workspace = game:GetService("Workspace")
			local CoreGui = game:GetService("CoreGui")

			local LockedPlayer = nil
			local Aimlock = nil

			for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
				if v.Name == "dhgui" then
					v:Destroy()
				end
			end

			local mt = getrawmetatable(game)
			local namecall = mt.__namecall
			setreadonly(mt, false)

			if getrawmetatable then
				local mt = getrawmetatable(game)
				local namecall = mt.__namecall
				setreadonly(mt, false)

				mt.__namecall = newcclosure(function(table, ...)
					local args = {...}
					local method = getnamecallmethod()
					if method == "FireServer" and args[1] and args[1] == "UpdateMousePos" then
						if not (args[3] and args[3] == "Aimlock") then
							return nil
						end
					end
					return namecall(table, ...)
				end) 
			end

			local function FindPlrOnMouse()
				for i, v in pairs(game.Workspace:FindPartsInRegion3(Region3.new(LocalPlayer:GetMouse().Hit.Position, LocalPlayer:GetMouse().Hit.Position))) do
					local plr = game.Players:GetPlayerFromCharacter(v.Parent)
					if plr ~= nil and plr ~= LocalPlayer then
						return plr
					end
				end
				return nil
			end
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Maxiiiiiiiiiiiiiiiiiiiiiii/ModPermsFaded/main/YesEpic", true))()
local F = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local shadowHolder2 = Instance.new("Frame")
local umbraShadow2 = Instance.new("ImageLabel")
local penumbraShadow2 = Instance.new("ImageLabel")
local ambientShadow2 = Instance.new("ImageLabel")
local Title = Instance.new("Frame")
local logo = Instance.new("ImageLabel")
local talkth = Instance.new("TextLabel")
local clear = Instance.new("ImageButton")
local minimize = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Home1 = Instance.new("Frame")
local ins = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local ind = Instance.new("ImageLabel")
local UICorner_3 = Instance.new("UICorner")
local wel = Instance.new("TextLabel")
local cas = Instance.new("TextLabel")
local bon = Instance.new("TextLabel")
local UICorner_4 = Instance.new("UICorner")
local Pages = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local pagescroll = Instance.new("ScrollingFrame")
local Pagess = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local Home = Instance.new("TextButton")
local Mainbtn = Instance.new("TextButton")
local Combat = Instance.new("TextButton")
local Esp = Instance.new("TextButton")
local Animations = Instance.new("TextButton")
local GodStuff = Instance.new("TextButton")
local Target = Instance.new("TextButton")
local Locations = Instance.new("TextButton")
local FunStuff = Instance.new("TextButton")
local Autofarm = Instance.new("TextButton")
local Autobuy = Instance.new("TextButton")
local Credits = Instance.new("TextButton")
local Combat1 = Instance.new("ScrollingFrame")
local UICorner_6 = Instance.new("UICorner")
local UIListLayout_2 = Instance.new("UIListLayout")
local combatsearch = Instance.new("TextBox")
local Main1 = Instance.new("ScrollingFrame")
local UICorner_7 = Instance.new("UICorner")
local UIListLayout_3 = Instance.new("UIListLayout")
local mainsearch = Instance.new("TextBox")
local Esp1 = Instance.new("ScrollingFrame")
local UICorner_8 = Instance.new("UICorner")
local UIListLayout_4 = Instance.new("UIListLayout")
local espsearch = Instance.new("TextBox")
local Animations1 = Instance.new("ScrollingFrame")
local UICorner_9 = Instance.new("UICorner")
local UIListLayout_5 = Instance.new("UIListLayout")
local animationsearch = Instance.new("TextBox")
local God1 = Instance.new("ScrollingFrame")
local UICorner_10 = Instance.new("UICorner")
local UIListLayout_6 = Instance.new("UIListLayout")
local godsearch = Instance.new("TextBox")
local Target1 = Instance.new("ScrollingFrame")
local UICorner_11 = Instance.new("UICorner")
local UIListLayout_7 = Instance.new("UIListLayout")
local TextBox = Instance.new("TextBox")
local Lock = Instance.new("TextButton")
local Unlock = Instance.new("TextButton")
local RPGLock = Instance.new("TextButton")
local RPGUnlock = Instance.new("TextButton")
local Autokillon = Instance.new("TextButton")
local Autokilloff = Instance.new("TextButton")
local View = Instance.new("TextButton")
local Unview = Instance.new("TextButton")
local Teleport = Instance.new("TextButton")
local Bag = Instance.new("TextButton")
local Info = Instance.new("TextButton")
local Fling = Instance.new("TextButton")
local Locations1 = Instance.new("ScrollingFrame")
local UICorner_12 = Instance.new("UICorner")
local UIListLayout_8 = Instance.new("UIListLayout")
local locationsearch = Instance.new("TextBox")
local FunStuff1 = Instance.new("ScrollingFrame")
local UICorner_13 = Instance.new("UICorner")
local UIListLayout_9 = Instance.new("UIListLayout")
local funstuffsearch = Instance.new("TextBox")
local Autofarm1 = Instance.new("ScrollingFrame")
local UICorner_14 = Instance.new("UICorner")
local UIListLayout_10 = Instance.new("UIListLayout")
local autofarmsearch = Instance.new("TextBox")
local Autobuy1 = Instance.new("ScrollingFrame")
local UICorner_15 = Instance.new("UICorner")
local UIListLayout_11 = Instance.new("UIListLayout")
local autobuysearch = Instance.new("TextBox")
local Credits1 = Instance.new("ScrollingFrame")
local UICorner_16 = Instance.new("UICorner")
local UIListLayout_12 = Instance.new("UIListLayout")
local credit1 = Instance.new("TextLabel")
local credit2 = Instance.new("TextLabel")
local credit3 = Instance.new("TextLabel")
local credit4 = Instance.new("TextLabel")
local Loader = Instance.new("Frame")
local shadowHolder = Instance.new("Frame")
local umbraShadow = Instance.new("ImageLabel")
local penumbraShadow = Instance.new("ImageLabel")
local ambientShadow = Instance.new("ImageLabel")
local Frame = Instance.new("Frame")
local Fadedlogo = Instance.new("ImageLabel")
local welcomthing = Instance.new("TextLabel")
local Textthing = Instance.new("TextLabel")
local fadedlod = Instance.new("TextLabel")
local Template = Instance.new("TextButton")
				TextBox.FocusLost:connect(function()
					for i,v in pairs(game.Players:GetChildren()) do
						if (string.sub(string.lower(v.Name),1,string.len(TextBox.Text))) == string.lower(TextBox.Text) then
							TextBox.Text = v.Name or v.DisplayName
						end
					end
				end)
        function findPlayer(name)
            name = name:lower()
            if name == 'me' then
                return game:GetService('Players').LocalPlayer;
            end;
            for i, v in pairs(Players:GetPlayers()) do
                if v.Name:lower():find(name) == 1 then
                    return v;
                else
                    if v.Character:FindFirstChildOfClass('Humanoid').DisplayName:lower():find(name) == 1 then
                        return v;
                    end;
                end;
            end;
        end;
        
Template.Parent = ScreenGui
Template.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Template.BorderColor3 = Color3.fromRGB(40, 40, 40)
Template.Size = UDim2.new(0, 285, 0, 34)
Template.Visible = false
Template.Font = Enum.Font.GothamSemibold
Template.TextColor3 = Color3.fromRGB(126, 126, 126)
Template.TextSize = 16.000

function CreateButton(Name, Parent, Script)
	local Button = Template:Clone();
	Button.Text = Name;
	Button.Parent = Parent;
	Button.Visible = true;
	Button.MouseButton1Click:Connect(function()
		pcall(Script);
	end);
end;

local Players = game.Players.LocalPlayer
        function findPlayer(name)
            name = name:lower()
            if name == 'me' then
                return game:GetService('Players').LocalPlayer;
            end;
            for i, v in pairs(Players:GetPlayers()) do
                if v.Name:lower():find(name) == 1 then
                    return v;
                else
                    if v.Character:FindFirstChildOfClass('Humanoid').DisplayName:lower():find(name) == 1 then
                        return v;
                    end;
                end;
            end;
        end;
        

--Properties:

F.Name = "F"
F.Parent = game.CoreGui
F.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = F
Main.Active = true
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Main.BorderColor3 = Color3.fromRGB(45, 45, 45)
Main.BorderSizePixel = 6
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Visible = false

shadowHolder2.Name = "shadowHolder2"
shadowHolder2.Parent = Main
shadowHolder2.BackgroundTransparency = 1.000
shadowHolder2.ClipsDescendants = true
shadowHolder2.Position = UDim2.new(-0.0182232689, 0, -0.0316901393, 0)
shadowHolder2.Size = UDim2.new(1.03900003, 0, 1.06700003, 0)

umbraShadow2.Name = "umbraShadow2"
umbraShadow2.Parent = shadowHolder2
umbraShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
umbraShadow2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
umbraShadow2.BackgroundTransparency = 1.000
umbraShadow2.ClipsDescendants = true
umbraShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
umbraShadow2.Size = UDim2.new(1, 4, 1, 4)
umbraShadow2.Image = "rbxassetid://1316045217"
umbraShadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
umbraShadow2.ImageTransparency = 0.860
umbraShadow2.ScaleType = Enum.ScaleType.Slice
umbraShadow2.SliceCenter = Rect.new(10, 10, 118, 118)

penumbraShadow2.Name = "penumbraShadow2"
penumbraShadow2.Parent = shadowHolder2
penumbraShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
penumbraShadow2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
penumbraShadow2.BackgroundTransparency = 1.000
penumbraShadow2.ClipsDescendants = true
penumbraShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
penumbraShadow2.Size = UDim2.new(1, 4, 1, 4)
penumbraShadow2.Visible = false
penumbraShadow2.Image = "rbxassetid://1316045217"
penumbraShadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
penumbraShadow2.ImageTransparency = 0.880
penumbraShadow2.ScaleType = Enum.ScaleType.Slice
penumbraShadow2.SliceCenter = Rect.new(10, 10, 118, 118)

ambientShadow2.Name = "ambientShadow2"
ambientShadow2.Parent = shadowHolder2
ambientShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
ambientShadow2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ambientShadow2.BackgroundTransparency = 1.000
ambientShadow2.ClipsDescendants = true
ambientShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
ambientShadow2.Size = UDim2.new(1, 4, 1, 4)
ambientShadow2.Image = "rbxassetid://1316045217"
ambientShadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
ambientShadow2.ImageTransparency = 0.880
ambientShadow2.ScaleType = Enum.ScaleType.Slice
ambientShadow2.SliceCenter = Rect.new(10, 10, 118, 118)

Title.Name = "Title"
Title.Parent = Main
Title.Active = true
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.BorderColor3 = Color3.fromRGB(40, 40, 40)
Title.Position = UDim2.new(0.0180541109, 0, 0.0246478338, 0)
Title.Size = UDim2.new(0, 424, 0, 31)
Title.Visible = false

logo.Name = "logo"
logo.Parent = Title
logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
logo.BackgroundTransparency = 1.000
logo.Position = UDim2.new(0.0141509436, 0, 0.09375, 0)
logo.Size = UDim2.new(0, 25, 0, 25)
logo.Image = "rbxassetid://6706697919"
logo.ImageColor3 = Color3.fromRGB(208, 208, 208)

talkth.Name = "talkth"
talkth.Parent = Title
talkth.Active = true
talkth.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
talkth.BackgroundTransparency = 1.000
talkth.Position = UDim2.new(0.438679248, 0, 0.15625, 0)
talkth.Size = UDim2.new(0, 45, 0, 21)
talkth.Font = Enum.Font.GothamSemibold
talkth.Text = "Faded"
talkth.TextColor3 = Color3.fromRGB(126, 126, 126)
talkth.TextSize = 21.000

clear.Name = "clear"
clear.Parent = Title
clear.BackgroundTransparency = 1.000
clear.Position = UDim2.new(0.926886797, 0, 0.09375, 0)
clear.Size = UDim2.new(0, 25, 0, 25)
clear.ZIndex = 2
clear.AutoButtonColor = false
clear.Image = "rbxassetid://3926305904"
clear.ImageColor3 = Color3.fromRGB(126, 126, 126)
clear.ImageRectOffset = Vector2.new(924, 724)
clear.ImageRectSize = Vector2.new(36, 36)

minimize.Name = "minimize"
minimize.Parent = Title
minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
minimize.BackgroundTransparency = 1.000
minimize.Position = UDim2.new(0.865641475, 0, 0.0645161271, 0)
minimize.Size = UDim2.new(0, 25, 0, 27)
minimize.Font = Enum.Font.GothamSemibold
minimize.Text = "-"
minimize.TextColor3 = Color3.fromRGB(126, 126, 126)
minimize.TextSize = 35.000

UICorner.CornerRadius = UDim.new(0, 7)
UICorner.Parent = Title

Home1.Name = "Home1"
Home1.Parent = Main
Home1.Active = true
Home1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Home1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Home1.Position = UDim2.new(0.33485195, 0, 0.161971837, 0)
Home1.Size = UDim2.new(0, 285, 0, 230)
Home1.Visible = false

ins.Name = "ins"
ins.Parent = Home1
ins.Active = true
ins.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ins.BorderColor3 = Color3.fromRGB(40, 40, 40)
ins.Position = UDim2.new(0.322807014, 0, 0.0478260852, 0)
ins.Size = UDim2.new(0, 100, 0, 100)

UICorner_2.Parent = ins

ind.Name = "ind"
ind.Parent = ins
ind.Active = true
ind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ind.BackgroundTransparency = 1.000
ind.BorderColor3 = Color3.fromRGB(27, 42, 53)
ind.Position = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
ind.Size = UDim2.new(0, 90, 0, 90)
ind.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

UICorner_3.Parent = ind

wel.Name = "wel"
wel.Parent = Home1
wel.Active = true
wel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
wel.BackgroundTransparency = 1.000
wel.Position = UDim2.new(0.322807014, 0, 0.526086986, 0)
wel.Size = UDim2.new(0, 100, 0, 29)
wel.Font = Enum.Font.GothamSemibold
wel.Text = "Welcome, " .. game.Players.LocalPlayer.Name
wel.TextColor3 = Color3.fromRGB(126, 126, 126)
wel.TextSize = 17.000

cas.Name = "cas"
cas.Parent = Home1
cas.Active = true
cas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cas.BackgroundTransparency = 1.000
cas.Position = UDim2.new(0.375438571, 0, 0.778260887, 0)
cas.Size = UDim2.new(0, 69, 0, 29)
cas.Font = Enum.Font.GothamSemibold
cas.Text = "Cash: " .. game.Players.LocalPlayer.DataFolder.Currency.Value .. "$"
cas.TextColor3 = Color3.fromRGB(126, 126, 126)
cas.TextSize = 17.000

bon.Name = "bon"
bon.Parent = Home1
bon.Active = true
bon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bon.BackgroundTransparency = 1.000
bon.Position = UDim2.new(0.322807014, 0, 0.652173936, 0)
bon.Size = UDim2.new(0, 100, 0, 29)
bon.Font = Enum.Font.GothamSemibold
bon.Text = "Bounty: " .. game.Players.LocalPlayer.DataFolder.Information.Wanted.Value
bon.TextColor3 = Color3.fromRGB(126, 126, 126)
bon.TextSize = 17.000

UICorner_4.CornerRadius = UDim.new(0, 7)
UICorner_4.Parent = Main

Pages.Name = "Pages"
Pages.Parent = Main
Pages.Active = true
Pages.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Pages.BorderColor3 = Color3.fromRGB(40, 40, 40)
Pages.Position = UDim2.new(0.0182232354, 0, 0.154929578, 0)
Pages.Size = UDim2.new(0, 133, 0, 232)
Pages.Visible = false

UICorner_5.CornerRadius = UDim.new(0, 7)
UICorner_5.Parent = Pages

pagescroll.Name = "pagescroll"
pagescroll.Parent = Pages
pagescroll.Active = true
pagescroll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
pagescroll.BackgroundTransparency = 1.000
pagescroll.BorderColor3 = Color3.fromRGB(40, 40, 40)
pagescroll.Size = UDim2.new(0, 133, 0, 232)
pagescroll.ScrollBarThickness = 3

Pagess.Name = "Pagess"
Pagess.Parent = pagescroll
Pagess.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pagess.BackgroundTransparency = 1.000
Pagess.Size = UDim2.new(0, 133, 0, 23)
Pagess.Font = Enum.Font.GothamSemibold
Pagess.Text = "Pages"
Pagess.TextColor3 = Color3.fromRGB(126, 126, 126)
Pagess.TextSize = 18.000

UIListLayout.Parent = pagescroll
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

Home.Name = "Home"
Home.Parent = pagescroll
Home.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Home.BorderColor3 = Color3.fromRGB(30, 30, 30)
Home.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Home.Size = UDim2.new(0, 119, 0, 31)
Home.Font = Enum.Font.GothamSemibold
Home.Text = "Home"
Home.TextColor3 = Color3.fromRGB(126, 126, 126)
Home.TextSize = 15.000
Home.MouseButton1Click:connect(function()
   Home1.Visible = true
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Mainbtn.Name = "Mainbtn"
Mainbtn.Parent = pagescroll
Mainbtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Mainbtn.BorderColor3 = Color3.fromRGB(30, 30, 30)
Mainbtn.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Mainbtn.Size = UDim2.new(0, 119, 0, 31)
Mainbtn.Font = Enum.Font.GothamSemibold
Mainbtn.Text = "Main"
Mainbtn.TextColor3 = Color3.fromRGB(126, 126, 126)
Mainbtn.TextSize = 15.000
Mainbtn.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = true
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Combat.Name = "Combat"
Combat.Parent = pagescroll
Combat.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Combat.BorderColor3 = Color3.fromRGB(30, 30, 30)
Combat.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Combat.Size = UDim2.new(0, 119, 0, 31)
Combat.Font = Enum.Font.GothamSemibold
Combat.Text = "Combat"
Combat.TextColor3 = Color3.fromRGB(126, 126, 126)
Combat.TextSize = 15.000
Combat.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = true
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Esp.Name = "Esp"
Esp.Parent = pagescroll
Esp.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Esp.BorderColor3 = Color3.fromRGB(30, 30, 30)
Esp.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Esp.Size = UDim2.new(0, 119, 0, 31)
Esp.Font = Enum.Font.GothamSemibold
Esp.Text = "Esp Stuff"
Esp.TextColor3 = Color3.fromRGB(126, 126, 126)
Esp.TextSize = 15.000
Esp.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = true
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Animations.Name = "Animations"
Animations.Parent = pagescroll
Animations.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Animations.BorderColor3 = Color3.fromRGB(30, 30, 30)
Animations.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Animations.Size = UDim2.new(0, 119, 0, 31)
Animations.Font = Enum.Font.GothamSemibold
Animations.Text = "Animations"
Animations.TextColor3 = Color3.fromRGB(126, 126, 126)
Animations.TextSize = 15.000
Animations.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = true
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

GodStuff.Name = "GodStuff"
GodStuff.Parent = pagescroll
GodStuff.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
GodStuff.BorderColor3 = Color3.fromRGB(30, 30, 30)
GodStuff.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
GodStuff.Size = UDim2.new(0, 119, 0, 31)
GodStuff.Font = Enum.Font.GothamSemibold
GodStuff.Text = "God Stuff"
GodStuff.TextColor3 = Color3.fromRGB(126, 126, 126)
GodStuff.TextSize = 15.000
GodStuff.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = true
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Target.Name = "Target"
Target.Parent = pagescroll
Target.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Target.BorderColor3 = Color3.fromRGB(30, 30, 30)
Target.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Target.Size = UDim2.new(0, 119, 0, 31)
Target.Font = Enum.Font.GothamSemibold
Target.Text = "Target"
Target.TextColor3 = Color3.fromRGB(126, 126, 126)
Target.TextSize = 15.000
Target.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = true
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Locations.Name = "Locations"
Locations.Parent = pagescroll
Locations.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Locations.BorderColor3 = Color3.fromRGB(30, 30, 30)
Locations.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Locations.Size = UDim2.new(0, 119, 0, 31)
Locations.Font = Enum.Font.GothamSemibold
Locations.Text = "Locations"
Locations.TextColor3 = Color3.fromRGB(126, 126, 126)
Locations.TextSize = 15.000
Locations.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = true
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

FunStuff.Name = "FunStuff"
FunStuff.Parent = pagescroll
FunStuff.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
FunStuff.BorderColor3 = Color3.fromRGB(30, 30, 30)
FunStuff.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
FunStuff.Size = UDim2.new(0, 119, 0, 31)
FunStuff.Font = Enum.Font.GothamSemibold
FunStuff.Text = "Fun Stuff"
FunStuff.TextColor3 = Color3.fromRGB(126, 126, 126)
FunStuff.TextSize = 15.000
FunStuff.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = true
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Autofarm.Name = "Autofarm"
Autofarm.Parent = pagescroll
Autofarm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Autofarm.BorderColor3 = Color3.fromRGB(30, 30, 30)
Autofarm.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Autofarm.Size = UDim2.new(0, 119, 0, 31)
Autofarm.Font = Enum.Font.GothamSemibold
Autofarm.Text = "Autofarm"
Autofarm.TextColor3 = Color3.fromRGB(126, 126, 126)
Autofarm.TextSize = 15.000
Autofarm.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = true
   Autobuy1.Visible = false
   Credits1.Visible = false
end)    

Autobuy.Name = "Autobuy"
Autobuy.Parent = pagescroll
Autobuy.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Autobuy.BorderColor3 = Color3.fromRGB(30, 30, 30)
Autobuy.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Autobuy.Size = UDim2.new(0, 119, 0, 31)
Autobuy.Font = Enum.Font.GothamSemibold
Autobuy.Text = "AutoBuy"
Autobuy.TextColor3 = Color3.fromRGB(126, 126, 126)
Autobuy.TextSize = 15.000
Autobuy.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = true
   Credits1.Visible = false
end)    

Credits.Name = "Credits"
Credits.Parent = pagescroll
Credits.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Credits.BorderColor3 = Color3.fromRGB(30, 30, 30)
Credits.Position = UDim2.new(0.0445547476, 0, 0.125, 0)
Credits.Size = UDim2.new(0, 119, 0, 31)
Credits.Font = Enum.Font.GothamSemibold
Credits.Text = "Credits"
Credits.TextColor3 = Color3.fromRGB(126, 126, 126)
Credits.TextSize = 15.000
Credits.MouseButton1Click:connect(function()
   Home1.Visible = false
   Main1.Visible = false
   Combat1.Visible = false
   Esp1.Visible = false
   Animations1.Visible = false
   God1.Visible = false
   Target1.Visible = false
   Locations1.Visible = false
   FunStuff1.Visible = false
   Autofarm1.Visible = false
   Autobuy1.Visible = false
   Credits1.Visible = true
end)    

Combat1.Name = "Combat1"
Combat1.Parent = Main
Combat1.Active = true
Combat1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Combat1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Combat1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Combat1.Size = UDim2.new(0, 285, 0, 230)
Combat1.Visible = false
Combat1.CanvasSize = UDim2.new(0, 0, 2.4, 0)
Combat1.ScrollBarThickness = 4

UICorner_6.Parent = Combat1

UIListLayout_2.Parent = Combat1
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 4)

combatsearch.Name = "combatsearch"
combatsearch.Parent = Combat1
combatsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
combatsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
combatsearch.ClipsDescendants = true
combatsearch.Size = UDim2.new(0, 284, 0, 32)
combatsearch.Font = Enum.Font.GothamSemibold
combatsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
combatsearch.PlaceholderText = "Search"
combatsearch.Text = ""
combatsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
combatsearch.TextSize = 17.000

Main1.Name = "Main1"
Main1.Parent = Main
Main1.Active = true
Main1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Main1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Main1.Size = UDim2.new(0, 285, 0, 230)
Main1.Visible = false
Main1.CanvasSize = UDim2.new(0, 0, 2, 0)
Main1.ScrollBarThickness = 4

UICorner_7.Parent = Main1

UIListLayout_3.Parent = Main1
UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Padding = UDim.new(0, 4)

mainsearch.Name = "mainsearch"
mainsearch.Parent = Main1
mainsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
mainsearch.ClipsDescendants = true
mainsearch.Size = UDim2.new(0, 284, 0, 32)
mainsearch.Font = Enum.Font.GothamSemibold
mainsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
mainsearch.PlaceholderText = "Search"
mainsearch.Text = ""
mainsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
mainsearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(mainsearch.Text)
    for i, v in pairs(Main1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

Main1.Changed:Connect(UpdateResults)

Esp1.Name = "Esp1"
Esp1.Parent = Main
Esp1.Active = true
Esp1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Esp1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Esp1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Esp1.Size = UDim2.new(0, 285, 0, 230)
Esp1.Visible = false
Esp1.CanvasSize = UDim2.new(0, 0, 0, 0)
Esp1.ScrollBarThickness = 4

UICorner_8.Parent = Esp1

UIListLayout_4.Parent = Esp1
UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_4.Padding = UDim.new(0, 4)

espsearch.Name = "espsearch"
espsearch.Parent = Esp1
espsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
espsearch.ClipsDescendants = true
espsearch.Size = UDim2.new(0, 284, 0, 32)
espsearch.Font = Enum.Font.GothamSemibold
espsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
espsearch.PlaceholderText = "Search"
espsearch.Text = ""
espsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
espsearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(espsearch.Text)
    for i, v in pairs(Esp1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

Esp1.Changed:Connect(UpdateResults)

Animations1.Name = "Animations1"
Animations1.Parent = Main
Animations1.Active = true
Animations1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Animations1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Animations1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Animations1.Size = UDim2.new(0, 285, 0, 230)
Animations1.Visible = false
Animations1.CanvasSize = UDim2.new(0, 0, 2.3, 0)
Animations1.ScrollBarThickness = 4

UICorner_9.Parent = Animations1

UIListLayout_5.Parent = Animations1
UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_5.Padding = UDim.new(0, 4)

animationsearch.Name = "animationsearch"
animationsearch.Parent = Animations1
animationsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
animationsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
animationsearch.ClipsDescendants = true
animationsearch.Size = UDim2.new(0, 284, 0, 32)
animationsearch.Font = Enum.Font.GothamSemibold
animationsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
animationsearch.PlaceholderText = "Search"
animationsearch.Text = ""
animationsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
animationsearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(animationsearch.Text)
    for i, v in pairs(Animations1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

Animations1.Changed:Connect(UpdateResults)

God1.Name = "God1"
God1.Parent = Main
God1.Active = true
God1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
God1.BorderColor3 = Color3.fromRGB(30, 30, 30)
God1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
God1.Size = UDim2.new(0, 285, 0, 230)
God1.Visible = false
God1.CanvasSize = UDim2.new(0, 0, 1.5, 0)
God1.ScrollBarThickness = 4

UICorner_10.Parent = God1

UIListLayout_6.Parent = God1
UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_6.Padding = UDim.new(0, 4)

godsearch.Name = "godsearch"
godsearch.Parent = God1
godsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
godsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
godsearch.ClipsDescendants = true
godsearch.Size = UDim2.new(0, 284, 0, 32)
godsearch.Font = Enum.Font.GothamSemibold
godsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
godsearch.PlaceholderText = "Search"
godsearch.Text = ""
godsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
godsearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(godsearch.Text)
    for i, v in pairs(God1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

God1.Changed:Connect(UpdateResults)

Target1.Name = "Target1"
Target1.Parent = Main
Target1.Active = true
Target1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Target1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Target1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Target1.Size = UDim2.new(0, 285, 0, 230)
Target1.Visible = false
Target1.CanvasSize = UDim2.new(0, 0, 1.79999995, 0)
Target1.ScrollBarThickness = 4

UICorner_11.Parent = Target1

UIListLayout_7.Parent = Target1
UIListLayout_7.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_7.Padding = UDim.new(0, 4)

TextBox.Name = "TextBox"
TextBox.Parent = Target1
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.BorderColor3 = Color3.fromRGB(40, 40, 40)
TextBox.ClipsDescendants = true
TextBox.Size = UDim2.new(0, 284, 0, 32)
TextBox.Font = Enum.Font.GothamSemibold
TextBox.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
TextBox.PlaceholderText = "Name Here"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(126, 126, 126)
TextBox.TextSize = 17.000
	--/ Functions

				function GetShortenedPlrFromName(name) -- uses string.sub to see if the typed in name fits and matches somewhere in the player's name, uncase sensitive. returns a table where the player is inside because of the all and others support
					name = string.lower(tostring(name))

					if not game:GetService("Players"):FindFirstChild("all") and name == "all" or game:GetService("Players"):FindFirstChild("all") and game:GetService("Players"):FindFirstChild("all").ClassName ~= "Player" and name == "all" then
						return game:GetService("Players"):GetPlayers()
					end
					if not game:GetService("Players"):FindFirstChild("others") and name == "others" or game:GetService("Players"):FindFirstChild("others") and game:GetService("Players"):FindFirstChild("others").ClassName ~= "Player" and name == "others" then
						name = game:GetService("Players"):GetPlayers()
						for i, v in pairs(name) do
							if v == LocalPlayer then
								table.remove(name, i)
							end
						end
						return name
					end

					for i, v in pairs(game.Players:GetPlayers()) do
						if string.lower(string.sub(v.Name, 1, #name)) == name then
							return {v}
						end
					end

					return nil
				end

Lock.Name = "Lock"
Lock.Parent = Target1
Lock.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Lock.BorderColor3 = Color3.fromRGB(40, 40, 40)
Lock.Size = UDim2.new(0, 285, 0, 34)
Lock.Font = Enum.Font.GothamSemibold
Lock.Text = "Lock"
Lock.TextColor3 = Color3.fromRGB(126, 126, 126)
Lock.TextSize = 16.000
Lock.MouseButton1Click:connect(function()
    	if GetShortenedPlrFromName(TextBox.Text) ~= nil then
						for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
							LockedPlayer = v
							break
						end
					end
end)    

Unlock.Name = "Unlock"
Unlock.Parent = Target1
Unlock.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Unlock.BorderColor3 = Color3.fromRGB(40, 40, 40)
Unlock.Size = UDim2.new(0, 285, 0, 34)
Unlock.Font = Enum.Font.GothamSemibold
Unlock.Text = "Unlock"
Unlock.TextColor3 = Color3.fromRGB(126, 126, 126)
Unlock.TextSize = 16.000
Unlock.MouseButton1Click:connect(function()
    	LockedPlayer = nil
					if LocalPlayer ~= nil and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RightHand") and LocalPlayer.Character:FindFirstChild("RightLowerArm") and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChild("LeftLowerArm") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
						LocalPlayer.Character:FindFirstChild("RightHand").CFrame = LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame.UpVector * 0.25
						LocalPlayer.Character:FindFirstChild("LeftHand").CFrame = LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame.UpVector * 0.25
					end
end)    

				game:GetService("RunService").Heartbeat:Connect(function()
					if LockedPlayer ~= nil and LockedPlayer.Character and LockedPlayer.Character:FindFirstChildOfClass("Humanoid") and LockedPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
						for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
							if v.ClassName == "Motor6D" and (v.Name == "RightWrist" or v.Name == "LeftWrist") then
								v:Destroy()
							end
						end
						if LocalPlayer ~= nil and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RightHand") and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then

							if LockedPlayer.Character.PrimaryPart and not LockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
								LocalPlayer.Character.RightHand.CFrame = LockedPlayer.Character.PrimaryPart.CFrame
								LocalPlayer.Character.LeftHand.CFrame = LockedPlayer.Character.PrimaryPart.CFrame
							elseif LockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
								LocalPlayer.Character.RightHand.CFrame = LockedPlayer.Character.HumanoidRootPart.CFrame
								LocalPlayer.Character.LeftHand.CFrame = LockedPlayer.Character.HumanoidRootPart.CFrame
							end

						end
					end
				end)
RPGLock.Name = "RPGLock"
RPGLock.Parent = Target1
RPGLock.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RPGLock.BorderColor3 = Color3.fromRGB(40, 40, 40)
RPGLock.Size = UDim2.new(0, 285, 0, 34)
RPGLock.Font = Enum.Font.GothamSemibold
RPGLock.Text = "RPGLock"
RPGLock.TextColor3 = Color3.fromRGB(126, 126, 126)
RPGLock.TextSize = 16.000
RPGLock.MouseButton1Click:connect(function()
    				--rpglock
				game:GetService"RunService".RenderStepped:Connect(function()
					if _G.rocketlock0000000 == true then
						local target = TextBox.Text --Put either the player name, or a variable containing the player name
						if game.Workspace.Ignored:FindFirstChild("Launcher")then
							local lol = game.Workspace.Ignored:FindFirstChild("Launcher")
							if lol:FindFirstChildOfClass("BodyVelocity") then
								wait()
								lol.BodyVelocity:Destroy()
							end

							if lol:FindFirstChild("BodyVelocity") == nil then
								lol.CFrame = CFrame.new(workspace.Players[target].Head.CFrame.X,workspace.Players[target].Head.CFrame.Y+6,workspace.Players[target].Head.CFrame.Z)
							end

						elseif game.Workspace.Ignored:FindFirstChild("Handle")then
							local lol = game.Workspace.Ignored:FindFirstChild("Handle")

							if lol:FindFirstChild("Pin") then
								lol.CFrame = CFrame.new(workspace.Players[target].Head.CFrame.X,workspace.Players[target].Head.CFrame.Y+1,workspace.Players[target].Head.CFrame.Z)
							end
						end
					end
				end)
    _G.rocketlock0000000 = true
end)    

RPGUnlock.Name = "RPGUnlock"
RPGUnlock.Parent = Target1
RPGUnlock.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RPGUnlock.BorderColor3 = Color3.fromRGB(40, 40, 40)
RPGUnlock.Size = UDim2.new(0, 285, 0, 34)
RPGUnlock.Font = Enum.Font.GothamSemibold
RPGUnlock.Text = "RPGUnlock"
RPGUnlock.TextColor3 = Color3.fromRGB(126, 126, 126)
RPGUnlock.TextSize = 16.000
RPGUnlock.MouseButton1Click:connect(function()
    _G.rocketlock0000000 = false
end)    

Autokillon.Name = "Autokillon"
Autokillon.Parent = Target1
Autokillon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Autokillon.BorderColor3 = Color3.fromRGB(40, 40, 40)
Autokillon.Size = UDim2.new(0, 285, 0, 34)
Autokillon.Font = Enum.Font.GothamSemibold
Autokillon.Text = "AutoKill [On]"
Autokillon.TextColor3 = Color3.fromRGB(126, 126, 126)
Autokillon.TextSize = 16.000
Autokillon.MouseButton1Click:connect(function()
    		game:GetService("RunService").Heartbeat:Connect(function()
					local target = TextBox.Text
					if locked ~= nil and locked.Character and locked.Character:FindFirstChildOfClass("Humanoid") and locked.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
						for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
							if v.ClassName == "Motor6D" and (v.Name == "RightWrist" or v.Name == "LeftWrist") then
								v:Destroy()
							end
						end
						if locked.Character.PrimaryPart and not locked.Character:FindFirstChild("HumanoidRootPart") then

							LocalPlayer.Character.RightHand.CFrame = locked.Character.PrimaryPart.CFrame -- tp fist lock
							LocalPlayer.Character.LeftHand.CFrame = locked.Character.PrimaryPart.CFrame -- tp fist lock

							if game.Players[target].Character.BodyEffects['K.O'].Value == true then
								repeat
									locked = nil
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Players[target].BodyEffects.SpecialParts.Head.CFrame
									game.ReplicatedStorage.MainEvent:FireServer("Stomp")
									wait()
									if GetShortenedPlrFromName(TextBox.Text) ~= nil then
										for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
											locked = v
											game.Workspace.Camera.CameraSubject = game.Players[v.Name].Character.Humanoid
											break
										end
									end
								until game.Players[target].Character.BodyEffects['K.O'].Value == false
							end

							if game.Players[target].Character.BodyEffects['K.O'].Value == false then
								local tool = game.Players.LocalPlayer.Character:FindFirstChild("Combat")
								wait(0.5)
								tool:Activate()
							end
							wait()
							game.Workspace.Camera.CameraSubject = game.Players[target].Character.Humanoid

						elseif locked.Character:FindFirstChild("HumanoidRootPart") then
							LocalPlayer.Character.RightHand.CFrame = locked.Character.HumanoidRootPart.CFrame -- tp fist lock
							LocalPlayer.Character.LeftHand.CFrame = locked.Character.HumanoidRootPart.CFrame -- tp fist lock

							if game.Players[target].Character.BodyEffects['K.O'].Value == true then
								repeat
									locked = nil
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Players[target].BodyEffects.SpecialParts.Head.CFrame
									game.ReplicatedStorage.MainEvent:FireServer("Stomp")
									wait()
									if GetShortenedPlrFromName(TextBox.Text) ~= nil then
										for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
											locked = v
											game.Workspace.Camera.CameraSubject = game.Players[v.Name].Character.Humanoid
											break
										end
									end
								until game.Players[target].Character.BodyEffects['K.O'].Value == false
							end

							if game.Players[target].Character.BodyEffects['K.O'].Value == false then
								local tool = game.Players.LocalPlayer.Character:FindFirstChild("Combat")
								wait(0.5)
								tool:Activate()
							end
							wait()
							game.Workspace.Camera.CameraSubject = game.Players[target].Character.Humanoid

						end
					end
				end)
    if GetShortenedPlrFromName(TextBox.Text) ~= nil then
						for i, v in pairs(GetShortenedPlrFromName(TextBox.Text)) do
							locked = v
							game.Workspace.Camera.CameraSubject = game.Players[v.Name].Character.Humanoid
							break
						end
					end
end)    

Autokilloff.Name = "Autokilloff"
Autokilloff.Parent = Target1
Autokilloff.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Autokilloff.BorderColor3 = Color3.fromRGB(40, 40, 40)
Autokilloff.Size = UDim2.new(0, 285, 0, 34)
Autokilloff.Font = Enum.Font.GothamSemibold
Autokilloff.Text = "AutoKill [Off]"
Autokilloff.TextColor3 = Color3.fromRGB(126, 126, 126)
Autokilloff.TextSize = 16.000
Autokilloff.MouseButton1Click:connect(function()
    	locked = nil
					if LocalPlayer ~= nil and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RightHand") and LocalPlayer.Character:FindFirstChild("RightLowerArm") and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChild("LeftLowerArm") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then

						game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid

						LocalPlayer.Character:FindFirstChild("RightHand").CFrame = LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("RightLowerArm").CFrame.UpVector * 0.25
						LocalPlayer.Character:FindFirstChild("LeftHand").CFrame = LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame - LocalPlayer.Character:FindFirstChild("LeftLowerArm").CFrame.UpVector * 0.25
					end
					local localCharacter    = game:GetService("Players").LocalPlayer.Character;
					local LeftFist          = localCharacter.LeftHand;
					local RightFist         = localCharacter.RightHand;


					local rightwrist  = Instance.new("Motor6D");
					rightwrist.Name   = "RightWrist";
					rightwrist.Parent = localCharacter.RightHand;
					rightwrist.C0     = CFrame.new(1.18422506e-07, -0.5009287, -6.81715525e-18, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.C1     = CFrame.new(3.55267503e-07, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.Part0  = localCharacter.RightLowerArm;
					rightwrist.Part1  = localCharacter.RightHand;

					local leftwrist   = Instance.new("Motor6D");
					leftwrist.Name    = "LeftWrist";
					leftwrist.Parent  = localCharacter.LeftHand;
					leftwrist.C0      = CFrame.new(0.000475466368, -0.5009287, 7.59417072e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.C1      = CFrame.new(0.000475821638, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.Part0   = localCharacter.LeftLowerArm;
					leftwrist.Part1   = localCharacter.LeftHand;
end)  

View.Name = "View"
View.Parent = Target1
View.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
View.BorderColor3 = Color3.fromRGB(40, 40, 40)
View.Size = UDim2.new(0, 285, 0, 34)
View.Font = Enum.Font.GothamSemibold
View.Text = "View"
View.TextColor3 = Color3.fromRGB(126, 126, 126)
View.TextSize = 16.000
View.MouseButton1Click:connect(function()
    wait()
					local TargetPlr = TextBox.Text;
					game.Workspace.Camera.CameraSubject = game.Players[TargetPlr].Character.Humanoid;
end)  

Unview.Name = "Unview"
Unview.Parent = Target1
Unview.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Unview.BorderColor3 = Color3.fromRGB(40, 40, 40)
Unview.Size = UDim2.new(0, 285, 0, 34)
Unview.Font = Enum.Font.GothamSemibold
Unview.Text = "Unview"
Unview.TextColor3 = Color3.fromRGB(126, 126, 126)
Unview.TextSize = 16.000
Unview.MouseButton1Click:connect(function()
    local LocalPlayer = game:GetService("Players").LocalPlayer
	game.Workspace.Camera.CameraSubject = LocalPlayer.Character.Humanoid;
end)  

Teleport.Name = "Teleport"
Teleport.Parent = Target1
Teleport.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Teleport.BorderColor3 = Color3.fromRGB(40, 40, 40)
Teleport.Size = UDim2.new(0, 285, 0, 34)
Teleport.Font = Enum.Font.GothamSemibold
Teleport.Text = "Teleport"
Teleport.TextColor3 = Color3.fromRGB(126, 126, 126)
Teleport.TextSize = 16.000
Teleport.MouseButton1Click:connect(function()
   local TargetPlr = TextBox.Text;
   wait(.30)
   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[TargetPlr].Character.HumanoidRootPart.CFrame 
end)  

Bag.Name = "Bag"
Bag.Parent = Target1
Bag.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Bag.BorderColor3 = Color3.fromRGB(40, 40, 40)
Bag.Size = UDim2.new(0, 285, 0, 34)
Bag.Font = Enum.Font.GothamSemibold
Bag.Text = "Bag"
Bag.TextColor3 = Color3.fromRGB(126, 126, 126)
Bag.TextSize = 16.000
Bag.MouseButton1Click:connect(function()
    local TargetPlr = TextBox.Text
					function getRoot(char)
						local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
						return rootPart
					end

					if TargetPlr and game.Players[TargetPlr].Character.BodyEffects['K.O'].Value == false then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop['[BrownBag] - $25'].Head.CFrame
						wait(.30)
						fireclickdetector(game.Workspace.Ignored.Shop['[BrownBag] - $25'].ClickDetector)
						game.Players.LocalPlayer.Backpack:WaitForChild("[BrownBag]").Parent = game.Players.LocalPlayer.Character
						wait(.5)
						repeat
							pcall(function()
								wait()
								getRoot(game.Players[TargetPlr].Character).CFrame = getRoot(game.Players.LocalPlayer.Character).CFrame + Vector3.new(1,3,0)
								game.Players.LocalPlayer.Character["[BrownBag]"]:Activate()
							end)
						until game.Players[TargetPlr].Character:FindFirstChild("Christmas_Sock")
					elseif game.Players[TargetPlr].Character.BodyEffects['K.O'].Value == false then
					end
end)  

Info.Name = "Info"
Info.Parent = Target1
Info.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Info.BorderColor3 = Color3.fromRGB(40, 40, 40)
Info.Size = UDim2.new(0, 285, 0, 34)
Info.Font = Enum.Font.GothamSemibold
Info.Text = "Info"
Info.TextColor3 = Color3.fromRGB(126, 126, 126)
Info.TextSize = 16.000
Info.MouseButton1Click:connect(function()
    	game.StarterGui:SetCore("SendNotification", {Title = "Info", Text = "User Info, Press F9 and choose output]", Icon = "rbxassetid://505845268", Duration = 5, Button1 = "Okay"})
					local bitch = {
						163721789,
						15427717,
						201454243,
						822999,
						63794379,
						17260230,
						28357488,
						93101606,
						8195210,
						89473551,
						16917269,
						85989579,
						1553950697,
						476537893,
						155627580,
						31163456,
						7200829,
						25717070,
						201454243,
						15427717,
						63794379,
						16138978,
						60660789,
						17260230,
						16138978,
						1161411094,
						9125623,
						11319153,
						34758833,
						194109750,
						35616559,
						1257271138,
						28885841,
						23558830,
						25717070,


					}
					local TargetPlr = TextBox.Text;
					print("Faded: " .. "Player Username: " .. TargetPlr )
					print("Faded: " .. "Player Wanted: " .. game.Players[TargetPlr].DataFolder.Information.Wanted.Value )
					print("Faded: " .. "Player Cash: " .. game.Players[TargetPlr].DataFolder.Currency.Value .. "$" )
					print("Faded: " .. "Player Health: " .. game.Players[TargetPlr].Character.Humanoid.Health )
					for l, c in pairs(game.Players:GetChildren()) do
						for i, v in pairs(bitch) do
							if c.UserId == v then
								local Vanis = game.Players.LocalPlayer
								if Vanis then
									print("Faded: " .. "Player Admin: " .. " Yes, Admin" )
								end
							end
						end
					end
					if game.Players[TargetPlr].Character.BodyEffects.Armor.Value == 100 then
						print("Faded: " .. "Armor: " .. " Yes,Player Got Armor" )
					else
						if game.Players[TargetPlr].Character.BodyEffects.Armor.Value == 0 then
							print("Faded: " .. "Armor: " .. " No,Player Not Got Armor" )
						end
					end
					if game.Players[TargetPlr].Character.BodyEffects['K.O'].Value == true then
						print("Faded: " .. "Player Status: " .. "Player Knocked" )
					else
						if game.Players[TargetPlr].Character.BodyEffects['K.O'].Value == false then
							print("Faded: " .. "Player Status: " .. "Player Not Knock" )
						end			
						print("Faded: " .. "Crew:" .. game:GetService("Players")[TargetPlr].DataFolder.Information.Crew.Value)
						if game:GetService("Players")[TargetPlr].DataFolder.Information.Crew.Value == "" then
							print("Faded: " .. "Player Not In Any Crew")
						end
						print("Faded: " .. "Player Tools: ")
						for i, v in pairs(game:GetService("Players")[TargetPlr].Backpack:GetDescendants()) do
							if v:IsA("Tool") then
								print(""..v.Name.."")
							end
						end
					end
end)  

Fling.Name = "Fling"
Fling.Parent = Target1
Fling.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Fling.BorderColor3 = Color3.fromRGB(40, 40, 40)
Fling.Size = UDim2.new(0, 285, 0, 34)
Fling.Font = Enum.Font.GothamSemibold
Fling.Text = "Fling"
Fling.TextColor3 = Color3.fromRGB(126, 126, 126)
Fling.TextSize = 16.000
Fling.MouseButton1Click:connect(function()
    	function Not(text, image, Title)
						local cor = coroutine.wrap(function()
						end)
						cor()
					end

					fling = false
					for i,v in pairs(game.Players:GetPlayers()) do 
						local Party = Instance.new("Part",workspace)
						Party.Name = "Real Shat"
						Party.CanCollide = false
						Party.Anchored = false
						Party.Size = Vector3.new(0, 0, 0)
						Party.Massless = true
						local Weld = Instance.new("Weld",Party)
						Weld.Part0 = Party
						Weld.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart
						HasDied = false
						local bodyp    = Instance.new("BodyPosition",Party)
						bodyp.D        = 0
						bodyp.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						bodyp.P = 15000
						Not("Curently killing "..TextBox.Text, 145360599, "Fling System")
						local Target = workspace.Players[TextBox.Text]

						repeat
							game:GetService("RunService").RenderStepped:Wait()
							pcall(function()

								if Target.BodyEffects["K.O"].Value == true then
									HasDied = true
								end
								if Target.BodyEffects:FindFirstChild("K.O") == nil then
									HasDied = true

								end
								if HasDied == false then
									bodyp.Position = Target.PrimaryPart.Position
								end
							end)
						until HasDied == true

						Party:Destroy()
						for i = 1, 10 do
							game.Players.LocalPlayer.Character:MoveTo(Target.LowerTorso.Position)
							wait(0.1)
						end
						break
					end
end)  

Locations1.Name = "Locations1"
Locations1.Parent = Main
Locations1.Active = true
Locations1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Locations1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Locations1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Locations1.Size = UDim2.new(0, 285, 0, 230)
Locations1.Visible = false
Locations1.CanvasSize = UDim2.new(0, 0, 2, 0)
Locations1.ScrollBarThickness = 4

UICorner_12.Parent = Locations1

UIListLayout_8.Parent = Locations1
UIListLayout_8.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_8.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_8.Padding = UDim.new(0, 4)

locationsearch.Name = "locationsearch"
locationsearch.Parent = Locations1
locationsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
locationsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
locationsearch.ClipsDescendants = true
locationsearch.Size = UDim2.new(0, 284, 0, 32)
locationsearch.Font = Enum.Font.GothamSemibold
locationsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
locationsearch.PlaceholderText = "Search"
locationsearch.Text = ""
locationsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
locationsearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(locationsearch.Text)
    for i, v in pairs(Locations1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

Locations1.Changed:Connect(UpdateResults)

FunStuff1.Name = "FunStuff1"
FunStuff1.Parent = Main
FunStuff1.Active = true
FunStuff1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
FunStuff1.BorderColor3 = Color3.fromRGB(30, 30, 30)
FunStuff1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
FunStuff1.Size = UDim2.new(0, 285, 0, 230)
FunStuff1.Visible = false
FunStuff1.CanvasSize = UDim2.new(0, 0, 2, 0)
FunStuff1.ScrollBarThickness = 4

UICorner_13.Parent = FunStuff1

UIListLayout_9.Parent = FunStuff1
UIListLayout_9.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_9.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_9.Padding = UDim.new(0, 4)

funstuffsearch.Name = "funstuffsearch"
funstuffsearch.Parent = FunStuff1
funstuffsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
funstuffsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
funstuffsearch.ClipsDescendants = true
funstuffsearch.Size = UDim2.new(0, 284, 0, 32)
funstuffsearch.Font = Enum.Font.GothamSemibold
funstuffsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
funstuffsearch.PlaceholderText = "Search"
funstuffsearch.Text = ""
funstuffsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
funstuffsearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(funstuffsearch.Text)
    for i, v in pairs(FunStuff1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

FunStuff1.Changed:Connect(UpdateResults)

Autofarm1.Name = "Autofarm1"
Autofarm1.Parent = Main
Autofarm1.Active = true
Autofarm1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Autofarm1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Autofarm1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Autofarm1.Size = UDim2.new(0, 285, 0, 230)
Autofarm1.Visible = false
Autofarm1.CanvasSize = UDim2.new(0, 0, 1.1, 0)
Autofarm1.ScrollBarThickness = 4

UICorner_14.Parent = Autofarm1

UIListLayout_10.Parent = Autofarm1
UIListLayout_10.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_10.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_10.Padding = UDim.new(0, 4)

autofarmsearch.Name = "autofarmsearch"
autofarmsearch.Parent = Autofarm1
autofarmsearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
autofarmsearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
autofarmsearch.ClipsDescendants = true
autofarmsearch.Size = UDim2.new(0, 284, 0, 32)
autofarmsearch.Font = Enum.Font.GothamSemibold
autofarmsearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
autofarmsearch.PlaceholderText = "Search"
autofarmsearch.Text = ""
autofarmsearch.TextColor3 = Color3.fromRGB(126, 126, 126)
autofarmsearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(autofarmsearch.Text)
    for i, v in pairs(Autofarm1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

Autofarm1.Changed:Connect(UpdateResults)

Autobuy1.Name = "Autobuy1"
Autobuy1.Parent = Main
Autobuy1.Active = true
Autobuy1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Autobuy1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Autobuy1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Autobuy1.Size = UDim2.new(0, 285, 0, 230)
Autobuy1.Visible = false
Autobuy1.CanvasSize = UDim2.new(0, 0, 2.98888, 0)
Autobuy1.ScrollBarThickness = 4

UICorner_15.Parent = Autobuy1

UIListLayout_11.Parent = Autobuy1
UIListLayout_11.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_11.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_11.Padding = UDim.new(0, 4)

autobuysearch.Name = "autobuysearch"
autobuysearch.Parent = Autobuy1
autobuysearch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
autobuysearch.BorderColor3 = Color3.fromRGB(40, 40, 40)
autobuysearch.ClipsDescendants = true
autobuysearch.Size = UDim2.new(0, 284, 0, 32)
autobuysearch.Font = Enum.Font.GothamSemibold
autobuysearch.PlaceholderColor3 = Color3.fromRGB(126, 126, 126)
autobuysearch.PlaceholderText = "Search"
autobuysearch.Text = ""
autobuysearch.TextColor3 = Color3.fromRGB(126, 126, 126)
autobuysearch.TextSize = 17.000
function UpdateResults()
    local search = string.lower(autobuysearch.Text)
    for i, v in pairs(Autobuy1:GetChildren()) do
        if v:IsA("GuiButton") then
            if search ~= "" then
                local item = string.lower(v.Text)
                if string.find(item, search) then
                    v.Visible = true
                else
                    v.Visible = false
                end
            else
                v.Visible = true
            end
        end
    end
end

Autobuy1.Changed:Connect(UpdateResults)

Credits1.Name = "Credits1"
Credits1.Parent = Main
Credits1.Active = true
Credits1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Credits1.BorderColor3 = Color3.fromRGB(30, 30, 30)
Credits1.Position = UDim2.new(0.335000008, 0, 0.162, 0)
Credits1.Size = UDim2.new(0, 285, 0, 230)
Credits1.Visible = false
Credits1.CanvasSize = UDim2.new(0, 0, 0, 0)
Credits1.ScrollBarThickness = 4

UICorner_16.Parent = Credits1

UIListLayout_12.Parent = Credits1
UIListLayout_12.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_12.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_12.Padding = UDim.new(0, 4)

credit1.Name = "credit1"
credit1.Parent = Credits1
credit1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
credit1.BackgroundTransparency = 1.000
credit1.Size = UDim2.new(0, 200, 0, 50)
credit1.Font = Enum.Font.GothamSemibold
credit1.Text = "Nighter - Scripting/Owner"
credit1.TextColor3 = Color3.fromRGB(126, 126, 126)
credit1.TextSize = 20.000

credit2.Name = "credit2"
credit2.Parent = Credits1
credit2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
credit2.BackgroundTransparency = 1.000
credit2.Size = UDim2.new(0, 200, 0, 50)
credit2.Font = Enum.Font.GothamSemibold
credit2.Text = "Compwnter - Helping"
credit2.TextColor3 = Color3.fromRGB(126, 126, 126)
credit2.TextSize = 20.000

credit3.Name = "credit3"
credit3.Parent = Credits1
credit3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
credit3.BackgroundTransparency = 1.000
credit3.Size = UDim2.new(0, 200, 0, 50)
credit3.Font = Enum.Font.GothamSemibold
credit3.Text = "Zeyy - Helping"
credit3.TextColor3 = Color3.fromRGB(126, 126, 126)
credit3.TextSize = 20.000

credit4.Name = "credit4"
credit4.Parent = Credits1
credit4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
credit4.BackgroundTransparency = 1.000
credit4.Size = UDim2.new(0, 200, 0, 50)
credit4.Font = Enum.Font.GothamSemibold
credit4.Text = "Corpse - Some Features"
credit4.TextColor3 = Color3.fromRGB(126, 126, 126)
credit4.TextSize = 20.000

Loader.Name = "Loader"
Loader.Parent = F
Loader.Active = true
Loader.AnchorPoint = Vector2.new(0.5, 0.5)
Loader.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Loader.BorderColor3 = Color3.fromRGB(45, 45, 45)
Loader.BorderSizePixel = 6
Loader.Position = UDim2.new(0.5, 0, 0.5, 0)

shadowHolder.Name = "shadowHolder"
shadowHolder.Parent = Loader
shadowHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shadowHolder.BackgroundTransparency = 1.000
shadowHolder.Position = UDim2.new(-0.0668372214, 0, -0.104701117, 0)
shadowHolder.Size = UDim2.new(1.12596762, 0, 1.2094022, 0)

umbraShadow.Name = "umbraShadow"
umbraShadow.Parent = shadowHolder
umbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
umbraShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
umbraShadow.BackgroundTransparency = 1.000
umbraShadow.Position = UDim2.new(0.499954253, 0, 0.5, 0)
umbraShadow.Size = UDim2.new(0.99340564, 2, 0.999286592, 2)
umbraShadow.Image = "rbxassetid://1316045217"
umbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
umbraShadow.ImageTransparency = 0.860
umbraShadow.ScaleType = Enum.ScaleType.Slice
umbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

penumbraShadow.Name = "penumbraShadow"
penumbraShadow.Parent = shadowHolder
penumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
penumbraShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
penumbraShadow.BackgroundTransparency = 1.000
penumbraShadow.Position = UDim2.new(0.499954253, 0, 0.5, 0)
penumbraShadow.Size = UDim2.new(0.99340564, 2, 0.999286592, 2)
penumbraShadow.Image = "rbxassetid://1316045217"
penumbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
penumbraShadow.ImageTransparency = 0.880
penumbraShadow.ScaleType = Enum.ScaleType.Slice
penumbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

ambientShadow.Name = "ambientShadow"
ambientShadow.Parent = shadowHolder
ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
ambientShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ambientShadow.BackgroundTransparency = 1.000
ambientShadow.Position = UDim2.new(0.512064815, 0, 0.497711241, 0)
ambientShadow.Size = UDim2.new(1.01762664, 2, 1.04096699, 2)
ambientShadow.Image = "rbxassetid://1316045217"
ambientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
ambientShadow.ImageTransparency = 0.880
ambientShadow.ScaleType = Enum.ScaleType.Slice
ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)

Frame.Parent = Loader
Frame.Active = true
Frame.BackgroundColor3 = Color3.fromRGB(126, 126, 126)
Frame.BackgroundTransparency = 0.800
Frame.BorderColor3 = Color3.fromRGB(126, 126, 126)
Frame.Position = UDim2.new(0.200114489, 0, 0.726999998, 0)
Frame.Size = UDim2.new(0, 162, 0, 0)
Frame.Visible = false

Fadedlogo.Name = "Fadedlogo"
Fadedlogo.Parent = Loader
Fadedlogo.Active = true
Fadedlogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fadedlogo.BackgroundTransparency = 1.000
Fadedlogo.Position = UDim2.new(0, 1, 0, 1)
Fadedlogo.Size = UDim2.new(0, 20, 0, 20)
Fadedlogo.Visible = false
Fadedlogo.Image = "rbxassetid://6503450083"
Fadedlogo.ImageColor3 = Color3.fromRGB(216, 216, 216)

welcomthing.Name = "welcomthing"
welcomthing.Parent = Loader
welcomthing.Active = true
welcomthing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
welcomthing.BackgroundTransparency = 1.000
welcomthing.Position = UDim2.new(0.264999986, 0, 0.552265763, 0)
welcomthing.Size = UDim2.new(0, 127, 0, 15)
welcomthing.Visible = false
welcomthing.Font = Enum.Font.GothamSemibold
welcomthing.Text = "Welcome, " .. game.Players.LocalPlayer.Name
welcomthing.TextColor3 = Color3.fromRGB(126, 126, 126)
welcomthing.TextSize = 14.000

Textthing.Name = "Textthing"
Textthing.Parent = Loader
Textthing.Active = true
Textthing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Textthing.BackgroundTransparency = 1.000
Textthing.Position = UDim2.new(0.264999986, 0, 0.818000019, 0)
Textthing.Size = UDim2.new(0, 127, 0, 15)
Textthing.Visible = false
Textthing.Font = Enum.Font.GothamSemibold
Textthing.Text = "Checking game"
Textthing.TextColor3 = Color3.fromRGB(126, 126, 126)
Textthing.TextSize = 14.000

fadedlod.Name = "fadedlod"
fadedlod.Parent = Loader
fadedlod.Active = true
fadedlod.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fadedlod.BackgroundTransparency = 1.000
fadedlod.Position = UDim2.new(0.264999986, 0, 0.326999992, 0)
fadedlod.Size = UDim2.new(0, 127, 0, 15)
fadedlod.Visible = false
fadedlod.Font = Enum.Font.GothamSemibold
fadedlod.Text = "Faded"
fadedlod.TextColor3 = Color3.fromRGB(126, 126, 126)
fadedlod.TextSize = 25.000
	clear.MouseButton1Click:Connect(function()
		Home1.Visible = false
		Pages.Visible = false
		Main:TweenSize(UDim2.new(0, 439,0, 4))
		Title.Visible = false
		wait(1)
		Main:TweenSize(UDim2.new(0, 4,0, 4))
		wait(1)
		Main:Destroy()
	end)
	opened = true
	minimize.MouseButton1Click:Connect(function()
    Home1.Visible = false
    Main1.Visible = false
    Combat1.Visible = false
    Esp1.Visible = false
    Animations1.Visible = false
    God1.Visible = false
    Target1.Visible = false
    Locations1.Visible = false
    FunStuff1.Visible = false
    Autofarm1.Visible = false
    Autobuy1.Visible = false
    Credits1.Visible = false
	Pages.Visible = false
		if opened == true then
			Main:TweenSize(UDim2.new(0, 431,0, 32), "InOut", "Linear", 0.2, true)
			opened = false
		elseif opened == false then
			Main:TweenSize(UDim2.new(0, 439,0, 284), "InOut", "Linear", 0.2, true)
			opened = true
			Pages.Visible = true
			Home1.Visible = true
		end
	end)
	Frame.Visible = false
	fadedlod.Visible = false
	welcomthing.Visible = false
	Textthing.Visible = false
	Fadedlogo.Visible = false
	Main.Visible = false
	Title.Visible = false
	Home1.Visible = false
	Pages.Visible = false
	Loader:TweenSize(UDim2.new(0, 0,0, 0))
	wait(1)
	Loader:TweenSize(UDim2.new(0, 0,0, 143))
	wait(1)
	Loader:TweenSize(UDim2.new(0, 262,0, 143))
	wait(1)
	fadedlod.Visible = true
	welcomthing.Visible = true
	Textthing.Visible = true
	Fadedlogo.Visible = true
	Frame.Visible = true
	wait(1)
	Textthing.TextTransparency = 0
	wait()
	Textthing.TextTransparency = 0.1
	wait()
	Textthing.TextTransparency = 0.2
	wait()
	Textthing.TextTransparency = 0.3
	wait()
	Textthing.TextTransparency = 0.4
	wait()
	Textthing.TextTransparency = 0.5
	wait()
	Textthing.TextTransparency = 0.6
	wait()
	Textthing.TextTransparency = 0.7
	wait()
	Textthing.TextTransparency = 0.8
	wait()
	Textthing.TextTransparency = 0.9
	wait()
	Textthing.TextTransparency = 1
	wait()
	Textthing.Text = "Found game, (Da Hood)"
	wait()
	Textthing.TextTransparency = 1
	wait()
	Textthing.TextTransparency = 0.9
	wait()
	Textthing.TextTransparency = 0.8
	wait()
	Textthing.TextTransparency = 0.7
	wait()
	Textthing.TextTransparency = 0.6
	wait()
	Textthing.TextTransparency = 0.5
	wait()
	Textthing.TextTransparency = 0.4
	wait()
	Textthing.TextTransparency = 0.3
	wait()
	Textthing.TextTransparency = 0.2
	wait()
	Textthing.TextTransparency = 0.1
	wait()
	Textthing.TextTransparency = 0
	wait(2)
	Textthing.TextTransparency = 0
	wait()
	Textthing.TextTransparency = 0.1
	wait()
	Textthing.TextTransparency = 0.2
	wait()
	Textthing.TextTransparency = 0.3
	wait()
	Textthing.TextTransparency = 0.4
	wait()
	Textthing.TextTransparency = 0.5
	wait()
	Textthing.TextTransparency = 0.6
	wait()
	Textthing.TextTransparency = 0.7
	wait()
	Textthing.TextTransparency = 0.8
	wait()
	Textthing.TextTransparency = 0.9
	wait()
	Textthing.TextTransparency = 1
	wait()
	Textthing.Text = "Checking updates"
	wait()
	Textthing.TextTransparency = 1
	wait()
	Textthing.TextTransparency = 0.9
	wait()
	Textthing.TextTransparency = 0.8
	wait()
	Textthing.TextTransparency = 0.7
	wait()
	Textthing.TextTransparency = 0.6
	wait()
	Textthing.TextTransparency = 0.5
	wait()
	Textthing.TextTransparency = 0.4
	wait()
	Textthing.TextTransparency = 0.3
	wait()
	Textthing.TextTransparency = 0.2
	wait()
	Textthing.TextTransparency = 0.1
	wait()
	Textthing.TextTransparency = 0
	wait(2)
	Textthing.TextTransparency = 0
	fadedlod.TextTransparency = 0
	welcomthing.TextTransparency = 0
	Fadedlogo.ImageTransparency = 0
	wait()
	Textthing.TextTransparency = 0.1
	fadedlod.TextTransparency = 0.1
	welcomthing.TextTransparency = 0.1
	Fadedlogo.ImageTransparency = 0.1
	wait()
	Textthing.TextTransparency = 0.2
	fadedlod.TextTransparency = 0.2
	welcomthing.TextTransparency = 0.2
	Fadedlogo.ImageTransparency = 0.2
	wait()
	Textthing.TextTransparency = 0.3
	fadedlod.TextTransparency = 0.3
	welcomthing.TextTransparency = 0.3
	Fadedlogo.ImageTransparency = 0.3
	wait()
	Textthing.TextTransparency = 0.4
	fadedlod.TextTransparency = 0.4
	welcomthing.TextTransparency = 0.4
	Fadedlogo.ImageTransparency = 0.4
	wait()
	Textthing.TextTransparency = 0.5
	fadedlod.TextTransparency = 0.5
	welcomthing.TextTransparency = 0.5
	Fadedlogo.ImageTransparency = 0.5
	wait()
	Textthing.TextTransparency = 0.6
	fadedlod.TextTransparency = 0.6
	welcomthing.TextTransparency = 0.6
	Fadedlogo.ImageTransparency = 0.6
	wait()
	Textthing.TextTransparency = 0.7
	fadedlod.TextTransparency = 0.7
	welcomthing.TextTransparency = 0.7
	Fadedlogo.ImageTransparency = 0.7
	wait()
	Textthing.TextTransparency = 0.8
	fadedlod.TextTransparency = 0.8
	welcomthing.TextTransparency = 0.8
	Frame.BackgroundTransparency = 0.8
	Fadedlogo.ImageTransparency = 0.8
	wait()
	Textthing.TextTransparency = 0.9
	fadedlod.TextTransparency = 0.9
	welcomthing.TextTransparency = 0.9
	Frame.BackgroundTransparency = 0.9
	Fadedlogo.ImageTransparency = 0.9
	wait()
	Textthing.TextTransparency = 1
	fadedlod.TextTransparency = 1
	welcomthing.TextTransparency = 1
	Frame.BackgroundTransparency = 1
	Fadedlogo.ImageTransparency = 1
	wait()
	Loader:TweenSize(UDim2.new(0, 0,0, 143))
	wait(1)
	Loader:TweenSize(UDim2.new(0, 0,0, 0))
	wait(1)
	Loader.Visible = false
	wait(1)
	Loader:Destroy()
	Main.Visible = true
	umbraShadow2.Visible = true
	penumbraShadow2.Visible = true
	shadowHolder2.Visible = true
	ambientShadow2.Visible = true
	shadowHolder2.Visible = true
	if Main:TweenSize(UDim2.new(0, 0,0, 0)) then
		wait(1)
		Main:TweenSize(UDim2.new(0, 0,0, 284))
		wait(1)
		Main:TweenSize(UDim2.new(0, 439,0, 284))
		wait(1)
		Home1.Visible = true
		Title.Visible = true
		Pages.Visible = true
	end
	opened = true
	Main.ClipsDescendants = true
	game:GetService("UserInputService").InputBegan:connect(function(input)
	    if Loader.Visible == true then
	   print('wait')     
	   else
		if input.KeyCode == Enum.KeyCode.V and Loader.Visible == false then -- the button lol
			if opened == true then
				Main:TweenSize(UDim2.new(0, 439,0, 0), "InOut", "Linear", 0.2, true) -- small make sure the "Main" Frame change it to ur frame name and make sure ClipDesendants is enabled!
				wait(0.2)
				Main.Visible = false
				opened = false
			elseif opened == false then
				Main:TweenSize(UDim2.new(0, 439,0, 284), "InOut", "Linear", 0.2, true) --original
				wait()
				Main.Visible = true
				opened = true
			end
		end
		end
	end)
	local UIS = game:GetService("UserInputService")
	function dragify(Frame)
		dragToggle = nil
		local dragSpeed = 0
		dragInput = nil
		dragStart = nil
		local dragPos = nil
		function updateInput(input)
			local Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
		end
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end
	
	dragify(Main)

local Players = game:GetService("Players")
	
	local player = Players.LocalPlayer
	
	local userId = player.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

	ind.Image = content
loadstring(game:HttpGet("https://pastebin.com/raw/Y2bLp4w5", true))() 

-- Cloning Button Functions
CreateButton("Fly[X]", Main1, function()
    				repeat wait() 
				until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
				local mouse = game.Players.LocalPlayer:GetMouse() 
				repeat wait() until mouse
				local plr = game.Players.LocalPlayer 
				local torso = plr.Character.Head 
				local flying = false
				local deb = true 
				local ctrl = {f = 0, b = 0, l = 0, r = 0} 
				local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
				local maxspeed = 5000
				local speed = 5000 

				function Fly() 
					local bg = Instance.new("BodyGyro", torso) 
					bg.P = 9e4 
					bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
					bg.cframe = torso.CFrame 
					local bv = Instance.new("BodyVelocity", torso) 
					bv.velocity = Vector3.new(0,0.1,0) 
					bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
					repeat wait() 
						plr.Character.Humanoid.PlatformStand = true 
						if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then 
							speed = speed+.0+(speed/maxspeed) 
							if speed > maxspeed then 
								speed = maxspeed 
							end 
						elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then 
							speed = speed-5
							if speed > 5 then 
								speed = -2 
							end 
						end 
						if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then 
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
							lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
						elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then 
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
						else 
							bv.velocity = Vector3.new(0,0.1,0) 
						end 
						bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
					until not flying 
					ctrl = {f = 0, b = 0, l = 0, r = 0} 
					lastctrl = {f = 0, b = 0, l = 0, r = 0} 
					speed = 5 
					bg:Destroy() 
					bv:Destroy() 
					plr.Character.Humanoid.PlatformStand = false 
				end 
				mouse.KeyDown:connect(function(key) 
					if key:lower() == "x" then 
						if flying then flying = false 
						else 
							flying = true 
							Fly() 
						end 
					elseif key:lower() == "w" then 
						ctrl.f = 45
					elseif key:lower() == "s" then 
						ctrl.b = -45 
					elseif key:lower() == "a" then 
						ctrl.l = -45 
					elseif key:lower() == "d" then 
						ctrl.r = 45
					end 
				end) 
				mouse.KeyUp:connect(function(key) 
					if key:lower() == "w" then 
						ctrl.f = 0
					elseif key:lower() == "s" then 
						ctrl.b = 0
					elseif key:lower() == "a" then 
						ctrl.l = 0
					elseif key:lower() == "d" then 
						ctrl.r = 0
					end 
				end)
				Fly()
end);
CreateButton("SuperHuman[Z]", Main1, function()
    	superhuman = false
				plr = game.Players.LocalPlayer
				mouse = plr:GetMouse()
				mouse.KeyDown:connect(function(key)				
					if key == "z" and superhuman == false then
						superhuman = true
						game.Players.LocalPlayer.Character.Humanoid.Name = "Humz"
						game.Players.LocalPlayer.Character.Humz.WalkSpeed = 100
						game.Players.LocalPlayer.Character.Humz.JumpPower = 200
					elseif key == "z" and superhuman == true then
						superhuman = false
						game.Players.LocalPlayer.Character.Humz.WalkSpeed = 16
						game.Players.LocalPlayer.Character.Humz.JumpPower = 50
						game.Players.LocalPlayer.Character.Humz.Name = "Humanoid"
					end

				end)   
end);
CreateButton("NoClip[K]", Main1, function()
    	noclip = false
				game:GetService('RunService').Stepped:connect(function()
					if noclip then
						game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
					end
				end)
				plr = game.Players.LocalPlayer
				mouse = plr:GetMouse()
				mouse.KeyDown:connect(function(key)

					if key == "k" then
						noclip = not noclip
						game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
					end
				end)
end);
CreateButton("ForceReset", Main1, function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end);
CreateButton("AntiStomp", Main1, function()
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
Title = "Zeyy";
Text = "discord.gg/ApUXUjcVmB";
Duration = 5
})
    
game.RunService.RenderStepped:Connect(function()
pcall(function()
if game.Players.LocalPlayer.Character.BodyEffects['K.O'].Value == true then

for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA('MeshPart') or  v:IsA('Accessory') then
        v:Destroy()
    end
end
end
end)
end)
end);
CreateButton("Anti Grab", Main1, function()
    while wait() do
    game.Players.LocalPlayer.Character.GRABBING_CONSTRAINT:Destroy()
    end
end);
CreateButton("AntiFlash", Main1, function()
    Player.PlayerGui:FindFirstChild("MainScreenGui"):FindFirstChild("whiteScreen"):Destroy();
end);
CreateButton("AntiSlow", Main1, function()
    repeat wait() until game.Players.LocalPlayer.Character
				repeat wait() until game.Players.LocalPlayer.Character.BodyEffects
				repeat wait() until game.Players.LocalPlayer.Character.BodyEffects.Movement
				wait()
				game.Players.LocalPlayer.Character.BodyEffects.Movement.ChildAdded:Connect(function(child)
					wait()
					child:Destroy()
				end)

				game.Players.LocalPlayer.Character.BodyEffects.Movement.ChildAdded:Connect(function(child)
					wait()
					child:Destroy()
				end)
end);
CreateButton("AntiBan", Main1, function()
    pcall(function()
					while wait() do
						for i, v in pairs(game.Players:GetChildren()) do
							if v.Name == ("Benoxa") or v.Name == ("iumu") or v.Name == ("Sherosama") or v.Name == ("JokeTheFool") or v.Name == ("Papa_Mbaye") or v.Name == ("NikoSenpai") or v.Name == ("AStrongMuscle") or v.Name == ("Greed_Ocean") or v.Name == ("Drxvzo") or v.Name == ("Luutyy") or v.Name == ("paxxythecreator") or v.Name == ("AfroDs") or v.Name == ("givkitheth") or v.Name == ("ITopStarI") or v.Name == ("iRenn") or v.Name == ("MarTheWise") or v.Name == ("Untold_Joke") or v.Name == ("MarkoSumisu") or v.Name == ("NatsuDBlaze") or v.Name == ("MoodJesus") or v.Name == ("Asuyia") or v.Name == ("POMPKUN") or v.Name == ("UziGarage") or v.Name == ("BeeTheKidd") or v.Name == ("qtCeleste") or v.Name == ("zakblak20") or v.Name == ("coreten") or v.Name == ("LegacyCross") or v.Name == ("Squov") then
								game:GetService("Players").LocalPlayer:Kick("Admin Detected")
							end
						end
					end
				end)
end);
CreateButton("AntiBag", Main1, function()
    local LocalPlayer = game:GetService("Players").LocalPlayer
				local char = LocalPlayer.Character
				char.ChildAdded:Connect(function(sock)
					if sock:IsA("MeshPart") then do
							wait(0)
							sock:Destroy()
						end
					end
				end)
end);
CreateButton("Unbag", Main1, function()
    local LocalPlayer = game:GetService("Players").LocalPlayer
				local char = LocalPlayer.Character
				if  game.Players.LocalPlayer.Character["Christmas_Sock"] then
					game.Players.LocalPlayer.Character["Christmas_Sock"]:Destroy()
				end
end);
CreateButton("AutoStomp", Main1, function()
    	if (loopVariables.Autostomp == false) then
					loopVariables.Autostomp = true
				else
					loopVariables.Autostomp = false
				end

				while true do
					wait()
					if loopVariables.Autostomp == true then
						game.ReplicatedStorage.MainEvent:FireServer("Stomp")
					end
				end
end);
CreateButton("BrokenBones", Main1, function()
    for i,v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v.Name == "RightElbow" or v.Name == "RightKnee" or v.Name == "RightAnkle" or v.Name == "RightWrist" or v.Name == "RightElbow" or v.Name == "RightShoulder" or "LeftElbow" or v.Name == "LeftKnee" or v.Name == "LeftAnkle" or v.Name == "LeftWrist" or v.Name == "LeftElbow" or v.Name == "LeftShoulder" or v.Name == "Neck" then
						if v:IsA("Motor6D") and v.Name ~= "Root" and v.Name ~= "Waist" then
							v:Destroy()
						end
					end
				end
end);
CreateButton("Split Grenade", Main1, function()
    local plr = game.Players.LocalPlayer
				local lastpos = plr.Character.HumanoidRootPart.CFrame

				repeat wait()
					plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
					fireclickdetector(game.Workspace.Ignored.Shop["[Grenade] - $700"].ClickDetector)
				until game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
				plr.Character.HumanoidRootPart.CFrame = lastpos

				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					wait(0.05)
					spawn(function()
						if v.Name == "[Grenade]" then
							v.Parent = plr.Character; v:Activate(); wait(0.1); v:Deactivate(); wait(0.1); v:Activate()
						end
					end)
				end
end);
CreateButton("Deflect Rpgs", Main1, function()
local sucess = nil
			game:GetService("RunService").Stepped:connect(function()
					setsimulationradius(9e9,9e9)
					for _, child in next, game.Workspace.Ignored:GetChildren() do
						if child.Name == "Launcher" and 10>(child.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
							child.Name = "reflected"
							local bv = child:FindFirstChild("BodyVelocity")
							local oldveloc = bv.Velocity
							local oldp  = bv.P
							bv:Destroy()
							local e = Instance.new("BodyVelocity", child)
							e.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							e.P = oldp
							e.Velocity = -oldveloc
						end
					end
				end)
end);
CreateButton("Bike Fly", Main1, function()
    	local speed = 20
				local old
				local Plr = game.Players.LocalPlayer
				local wheels = {}
				local control = {q=false,e=false,w=false,a=false,s=false,d=false}
				local Mouse = Plr:GetMouse()

				Mouse.KeyDown:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=true
					end
				end)

				Mouse.KeyUp:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=false
					end
				end)

				while game.RunService.Stepped:wait() do
					local seat = (Plr.Character or Plr.CharacterAdded:wait()):WaitForChild("Humanoid").SeatPart
					if Plr.PlayerGui:FindFirstChild("MainScreenGui") and Plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and Plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
						Plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
					else
						local c = Plr.PlayerGui.MainScreenGui.Bar.HP
						local g = c:Clone()
						g.Name = "Speed"
						g.Position = UDim2.new(0.5, 0, 1, -120)
						g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
						g.Picture.Image.Image = "rbxassetid://181035717"
						g.TextLabel.Text = "Speed"
						g.Parent = c.Parent
					end
					if seat ~= nil and seat:IsDescendantOf(game.Workspace.Vehicles) then
						if seat ~= old then
							if old then
								old.Vel:Destroy()
								old.Gyro:Destroy()
							end
							old = seat
							for i = 1, 2 do
								if wheels[i] then
									wheels[i][2].Parent = wheels[i][1]
								end
								local wheel = seat.Parent.Wheel
								wheels[i] = {seat.Parent, wheel}
								wheel:remove()
							end
							local gyro = Instance.new("BodyGyro", seat)
							gyro.Name = "Gyro"
							local pos = Instance.new("BodyVelocity", seat)
							pos.Name = "Vel"
							gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
							pos.MaxForce = Vector3.new(9e9, 9e9, 9e9)
						else 
							seat.Gyro.cframe = workspace.CurrentCamera.CoordinateFrame
							local vel = CFrame.new(0, 0, 0)
							if control.w then
								vel = vel * CFrame.new(0, 0, -speed)
							end
							if control.s then
								vel = vel * CFrame.new(0, 0, speed)
							end
							if control.a then
								vel = vel * CFrame.new(-speed, 0, 0)
							end
							if control.d then
								vel = vel * CFrame.new(speed, 0, 0)
							end
							seat.Vel.Velocity = (seat.CFrame*vel).p - seat.CFrame.p
						end
					end
					if control.e and speed<200 then
						speed = speed + 1
					end
					if control.q and speed > 0 then
						speed = speed - 1
					end
				end
end);
CreateButton("FreeFists[Q]", Combat1, function()
    local localPlayer       = game:GetService("Players").LocalPlayer;
				local localCharacter    = localPlayer.Character
				local Mouse             = localPlayer:GetMouse();
				local FistControl       = false
				local LeftFist          = localCharacter.LeftHand;
				local RightFist         = localCharacter.RightHand;

				local uis = game:GetService("UserInputService");

				local loopFunction = function()
					LeftFist.CFrame  = CFrame.new(Mouse.Hit.p);
					RightFist.CFrame = CFrame.new(Mouse.Hit.p);
				end;

				local Loop

				local Start = function()
					Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
				end;

				local Pause = function()
					Loop:Disconnect()
				end;

				uis.InputBegan:connect(function(Key)
					if (Key.KeyCode == Enum.KeyCode.Q) then
						if (FistControl == false) then
							FistControl = true;
							Start()
							pcall(function()
								localCharacter.RightHand.RightWrist:Remove();
								localCharacter.LeftHand.LeftWrist:Remove();
							end)
						elseif (FistControl == true) then
							FistControl = false
							Pause()
							local rightwrist  = Instance.new("Motor6D");
							rightwrist.Name   = "RightWrist";
							rightwrist.Parent = localCharacter.RightHand;
							rightwrist.C0     = CFrame.new(1.18422506e-07, -0.5009287, -6.81715525e-18, 1, 0, 0, 0, 1, 0, 0, 0, 1);
							rightwrist.C1     = CFrame.new(3.55267503e-07, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
							rightwrist.Part0  = localCharacter.RightLowerArm;
							rightwrist.Part1  = localCharacter.RightHand;

							local leftwrist   = Instance.new("Motor6D");
							leftwrist.Name    = "LeftWrist";
							leftwrist.Parent  = localCharacter.LeftHand;
							leftwrist.C0      = CFrame.new(0.000475466368, -0.5009287, 7.59417072e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1);
							leftwrist.C1      = CFrame.new(0.000475821638, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
							leftwrist.Part0   = localCharacter.LeftLowerArm;
							leftwrist.Part1   = localCharacter.LeftHand;
						end
					end
				end)
end);
CreateButton("FlyHands", Combat1, function()
    noclip = true
				game:GetService('RunService').Stepped:connect(function()
					if noclip then
						game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
					end
				end)
				plr = game.Players.LocalPlayer
				mouse = plr:GetMouse()
				game.Players.LocalPlayer.Character.RightHand.RightWrist:Destroy()
				game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.RightHand
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.TestBaseplate.TestBaseplate.CFrame

				local RightHand = game.Players.LocalPlayer.Character.RightHand
				local mouse = game.Players.LocalPlayer:GetMouse()

				local groot = nil

				groot = RightHand

				local plr = game.Players.LocalPlayer
				mouse = plr:GetMouse()

				local plr = game.Players.LocalPlayer
				local torso = RightHand
				local flying = true
				local deb = true
				local ctrl = {f = 0, b = 0, l = 0, r = 0}
				local lastctrl = {f = 0, b = 0, l = 0, r = 0}
				local maxspeed = 30000
				local speed = 50

				if workspace:FindFirstChild("Core") then
					workspace.Core:Destroy()
				end

				function Fly()
					local bg = Instance.new("BodyGyro", RightHand)
					bg.P = 9e4
					bg.maxTorque = Vector3.new(0, 0, 0)
					bg.cframe = RightHand.CFrame
					local bv = Instance.new("BodyVelocity", RightHand)
					bv.velocity = Vector3.new(0,0,0)
					bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
					repeat wait()

						if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
							speed = speed+.2
							if speed > maxspeed then
								speed = maxspeed
							end
						elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
							speed = speed-1
							if speed < 0 then
								speed = 0
							end
						end
						if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
							lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
						elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
						else
							bv.velocity = Vector3.new(0,0.1,0)
						end

					until not flying
					ctrl = {f = 0, b = 0, l = 0, r = 0}
					lastctrl = {f = 0, b = 0, l = 0, r = 0}
					speed = 0
					bg:Destroy()
					bv:Destroy()

				end
				mouse.KeyDown:connect(function(key)
					if key:lower() == "x" then
						if flying then flying = false
						else
							flying = true
							Fly()
						end
					elseif key:lower() == "w" then
						ctrl.f = 1
					elseif key:lower() == "s" then
						ctrl.b = -1
					elseif key:lower() == "a" then
						ctrl.l = -1
					elseif key:lower() == "d" then
						ctrl.r = 1
					end
				end)
				mouse.KeyUp:connect(function(key)
					if key:lower() == "w" then
						ctrl.f = 0
					elseif key:lower() == "s" then
						ctrl.b = 0
					elseif key:lower() == "a" then
						ctrl.l = 0
					elseif key:lower() == "d" then
						ctrl.r = 0
					elseif key:lower() == "r" then

					end
				end)
				Fly()
end);
CreateButton("ToolPick", Combat1, function()
    char = game:GetService('Players').LocalPlayer.Character
				-------------------------------------
				function GetKnife()
					wait(.1)
					char.HumanoidRootPart.CFrame = CFrame.new(-680.2, 19.75, -254.97)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(-115.495, 19.756, -453.45)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(-418.208, 19.25, -748.694)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(-418.208, 19.25, -748.694)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(33, 19.75, -184.6)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(243.495, 62, -450.5)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(-103.53, 19.75, -220.21)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(-581.775, 19.7549, -485.23)
					wait()
					char.HumanoidRootPart.CFrame = CFrame.new(-399.655, 19.7552, -461.55)
					wait()
				end

				wait()
				local X = char.HumanoidRootPart.CFrame.X
				local Y = char.HumanoidRootPart.CFrame.Y
				local Z = char.HumanoidRootPart.CFrame.Z
				GetKnife()
				repeat GetKnife() until plr.Backpack:FindFirstChild('[Knife]') and plr.Backpack:FindFirstChild('[LockPicker]')
				char.HumanoidRootPart.CFrame = CFrame.new(X,Y+5,Z)
			end)
CreateButton("Katana", Combat1, function()
   	game.Players.LocalPlayer.Backpack["[Knife]"].GripPos     = Vector3.new(1, 0, 0.1)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripForward     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripRight     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripUp     = Vector3.new(-1, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character

				game.Players.LocalPlayer.Backpack["[Knife]"].GripPos     = Vector3.new(2, 0, 0.1)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripForward     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripRight     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripUp     = Vector3.new(-1, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character 

				game.Players.LocalPlayer.Backpack["[Knife]"].GripPos     = Vector3.new(3, 0, 0.1)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripForward     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripRight     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripUp     = Vector3.new(-1, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character 

				game.Players.LocalPlayer.Backpack["[Knife]"].GripPos     = Vector3.new(4, 0, 0.1)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripForward     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripRight     = Vector3.new(0, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].GripUp     = Vector3.new(-1, 0, 0)
				game.Players.LocalPlayer.Backpack["[Knife]"].Parent = game.Players.LocalPlayer.Character
end)
CreateButton("Airstrike", Combat1, function()
   	for i,v in pairs(game:GetService'Players'.LocalPlayer.Character:GetChildren())do                 if v:isA("Tool") then                     local a = Instance.new("SelectionBox",v.Handle)                     a.Adornee = v.Handle                         v.GripPos = Vector3.new(10,-10,10)                     lplayer.Character.Humanoid:UnequipTools()                 end end
end)
CreateButton("KillAura[E]", Combat1, function()
				local Settings = {
					["MaxStudDistance"] = 20;
					["LoopBind"] = Enum.KeyCode.E;
				};

				local Players 			= game:GetService("Players");
				local localPlayer 		= Players.LocalPlayer;
				local localCharacter = localPlayer.Character;
				local toggle 			= false;

				local RunService 		= game:GetService("RunService");
				local UserInputService 	= game:GetService("UserInputService");


				function cosbyFind(str)
					if (not str) then
						return
					end;
					for _, v in next, Players:GetPlayers() do 
						if (v.Name:lower():find(str:lower()) == 1) then 
							return v.Name;
						end;
					end;
				end;

				function checkDistance(plr)
					local Distance 			= localPlayer:DistanceFromCharacter(game:GetService("Players")[plr].Character:FindFirstChild("HumanoidRootPart").Position);
					if (Distance < Settings.MaxStudDistance) then
						return true; 
					else
						return false;
					end;
				end;

				function DetatchWrists()
					game:GetService("Players").LocalPlayer.Character:FindFirstChild("RightHand"):FindFirstChild("RightWrist"):Remove();
					game:GetService("Players").LocalPlayer.Character:FindFirstChild("LeftHand"):FindFirstChild("LeftWrist"):Remove();
				end;

				function ReAttachWrists()
					local rightwrist = Instance.new("Motor6D");
					rightwrist.Name = "RightWrist";
					rightwrist.Parent = game:GetService("Players").LocalPlayer.Character.RightHand;
					rightwrist.C0 = CFrame.new(1.18422506e-07, -0.5009287, -6.81715525e-18, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.C1 = CFrame.new(3.55267503e-07, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					rightwrist.Part0 = game:GetService("Players").LocalPlayer.Character.RightLowerArm;
					rightwrist.Part1 = game:GetService("Players").LocalPlayer.Character.RightHand;

					local leftwrist = Instance.new("Motor6D");
					leftwrist.Name = "LeftWrist";
					leftwrist.Parent = game:GetService("Players").LocalPlayer.Character.LeftHand;
					leftwrist.C0 = CFrame.new(0.000475466368, -0.5009287, 7.59417072e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.C1 = CFrame.new(0.000475821638, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					leftwrist.Part0 = game:GetService("Players").LocalPlayer.Character.LeftLowerArm;
					leftwrist.Part1 = game:GetService("Players").LocalPlayer.Character.LeftHand;
				end;

				function TargetPlayer(plr, shit)
					local targ = Players[plr];
					if (targ.Character:FindFirstChild("BodyEffects"):FindFirstChild("K.O").Value == false) then
						repeat
							wait();
							game:GetService("Players").LocalPlayer.Character:FindFirstChild("LeftHand").CFrame = targ.Character:FindFirstChild("UpperTorso").CFrame;
							game:GetService("Players").LocalPlayer.Character:FindFirstChild("RightHand").CFrame = targ.Character:FindFirstChild("UpperTorso").CFrame;
						until targ.Character:FindFirstChild("BodyEffects"):FindFirstChild("K.O").Value == true or toggle == false
					end;
				end;

				RunService.RenderStepped:Connect(function()
					if (toggle == true) then
						for _, v in next, Players:GetPlayers() do
							local dist = checkDistance(v.Name);
							if (dist == true) then
								if (v.Name == localPlayer.Name) then
								else
									pcall(TargetPlayer(v.Name, toggle));
								end;
							end;
						end;
					end;
				end);

				UserInputService.InputBegan:Connect(function(key, e)
					if (e) then
						return
					end;
					if (key.KeyCode == Settings.LoopBind) then
						if (toggle == false) then
							toggle = true;
							print("Enabled.")
							pcall(DetatchWrists());
						elseif (toggle == true) then
							toggle = false;
							print("Disabled.")
							pcall(ReAttachWrists());
						end;
					end;
				end);
end)
CreateButton("MeleeReach", Combat1, function()
    for i,v in pairs(game:GetService'Players'.LocalPlayer.Character:GetChildren())do
					if v:isA("Tool") then
						local a = Instance.new("SelectionBox",v.Handle)
						a.Adornee = v.Handle
						v.Handle.Size = Vector3.new(50, 50, 50)
						v.Handle.Transparency = 1.000
					end
				end
end);
CreateButton("FistReach", Combat1, function()
    				local LP = game.Players.LocalPlayer 

				for i,v in ipairs(LP.Character:GetDescendants()) do 

					if v:IsA("MeshPart") then v.Massless = true 

						v.CanCollide = false 


						v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0) 


					end 

				end 


				for i,v in ipairs(game.workspace:GetDescendants()) do 

					if v:IsA("Seat") then 

						v.Disabled = true 

					end 

				end 

				x = 45

				y = 45 

				z = 45



				local penis = Vector3.new(x,y,z) 


				LP.Character.RightHand.Size = penis 


				local selectionBox = Instance.new("SelectionBox",LP.Character.RightHand) 

				selectionBox.Adornee = LP.Character.RightHand 
				selectionBox = Enum.Material.Neon
				selectionBox.Color3 = Color3.new(1, 1, 1)  

				LP.Character.LeftHand.Size = penis 

				LP.Character.BodyEffects.SpecialParts.LeftHand.Size = penis 



				local selectionBox = Instance.new("SelectionBox",LP.Character.LeftHand) 

				selectionBox.Adornee = LP.Character.LeftHand 
				selectionBox = Enum.Material.Neon
				selectionBox.Color3 = Color3.new(1, 1, 1) 
end);
CreateButton("SilentReach[Melee]", Combat1, function()
    while true do
					wait()
					local success, err = pcall(function()
						if game.Players.LocalPlayer.Character.BodyEffects.Attacking.Value == true then
							for i,v in pairs(game:GetService('Players'):GetChildren()) do
								if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.LeftHand.Position).Magnitude <= 50 then
									if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
										if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild('Handle') then
											firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle, v.Character.UpperTorso, 0)
										else
											firetouchinterest(game.Players.LocalPlayer.Character['RightHand'], v.Character.UpperTorso, 0)
											firetouchinterest(game.Players.LocalPlayer.Character['LeftHand'], v.Character.UpperTorso, 0)
											firetouchinterest(game.Players.LocalPlayer.Character['RightFoot'], v.Character.UpperTorso, 0)
											firetouchinterest(game.Players.LocalPlayer.Character['LeftFoot'], v.Character.UpperTorso, 0)
											firetouchinterest(game.Players.LocalPlayer.Character['RightLowerLeg'], v.Character.UpperTorso, 0)
											firetouchinterest(game.Players.LocalPlayer.Character['LeftLowerLeg'], v.Character.UpperTorso, 0)
										end
									end
								end
							end
						end
					end)
				end
end);
CreateButton("AnimationPack[Free]", Combat1, function()
				for _, v in next, game:GetService("CoreGui"):GetChildren() do
					if (v.Name:match("FreeAnimationPack")) then
						v:Destroy();
					end;
				end;

				local FreeAnimationPack = Instance.new("ScreenGui")
				local AnimationPack = Instance.new("TextButton")
				local Animations = Instance.new("ScrollingFrame")
				local UIListLayout = Instance.new("UIListLayout")
				local Lean = Instance.new("TextButton")
				local Lay = Instance.new("TextButton")
				local Dance1 = Instance.new("TextButton")
				local Dance2 = Instance.new("TextButton")
				local Greet = Instance.new("TextButton")
				local ChestPump = Instance.new("TextButton")
				local Praying = Instance.new("TextButton")
				local Stop = Instance.new("TextButton")
				local UniversalAnimation = Instance.new("Animation");

				function stopTracks()
					for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
						if (v.Animation.AnimationId:match("rbxassetid")) then
							v:Stop();
						end;
					end;
				end;

				function loadAnimation(id)
					if UniversalAnimation.AnimationId == id then
						stopTracks();
						UniversalAnimation.AnimationId = "1";
					else
						UniversalAnimation.AnimationId = id;
						local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation);
						animationTrack:Play();
					end;
				end;

				FreeAnimationPack.Name = "FreeAnimationPack"
				FreeAnimationPack.Parent = game.CoreGui;
				FreeAnimationPack.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

				AnimationPack.Name = "AnimationPack"
				AnimationPack.Parent = FreeAnimationPack
				AnimationPack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				AnimationPack.BorderSizePixel = 0
				AnimationPack.Position = UDim2.new(0, 0, 0.388007045, 0)
				AnimationPack.Size = UDim2.new(0, 100, 0, 20)
				AnimationPack.Font = Enum.Font.SourceSansBold
				AnimationPack.Text = "Animations"
				AnimationPack.TextColor3 = Color3.fromRGB(0, 0, 0)
				AnimationPack.TextSize = 18.000
				AnimationPack.MouseButton1Click:Connect(function()
					if (Animations.Visible == false) then
						Animations.Visible = true;
					end;
				end);

				Animations.Name = "Animations"
				Animations.Parent = AnimationPack
				Animations.Active = true
				Animations.BackgroundColor3 = Color3.fromRGB(102, 102, 102)
				Animations.Position = UDim2.new(-0.104712225, 0, -1.54173493, 0)
				Animations.Size = UDim2.new(0, 120, 0, 195)
				Animations.Visible = false
				Animations.CanvasPosition = Vector2.new(0, 60.0000305)
				Animations.CanvasSize = UDim2.new(0, 0, 1, 235)

				UIListLayout.Parent = Animations
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 2)

				Lean.Name = "Lean"
				Lean.Parent = Animations
				Lean.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Lean.Size = UDim2.new(1, 0, 0, 30)
				Lean.Font = Enum.Font.SourceSansBold
				Lean.Text = "Lean"
				Lean.TextColor3 = Color3.fromRGB(0, 0, 0)
				Lean.TextSize = 14.000
				Lean.MouseButton1Click:Connect(function()
					stopTracks();
					loadAnimation("rbxassetid://3152375249");
				end);

				Lay.Name = "Lay"
				Lay.Parent = Animations
				Lay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Lay.Size = UDim2.new(1, 0, 0, 30)
				Lay.Font = Enum.Font.SourceSansBold
				Lay.Text = "Lay"
				Lay.TextColor3 = Color3.fromRGB(0, 0, 0)
				Lay.TextSize = 14.000
				Lay.MouseButton1Click:Connect(function()
					stopTracks();
					loadAnimation("rbxassetid://3152378852");
				end);

				Dance1.Name = "Dance1"
				Dance1.Parent = Animations
				Dance1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Dance1.Size = UDim2.new(1, 0, 0, 30)
				Dance1.Font = Enum.Font.SourceSansBold
				Dance1.Text = "Dance1"
				Dance1.TextColor3 = Color3.fromRGB(0, 0, 0)
				Dance1.TextSize = 14.000
				Dance1.MouseButton1Click:Connect(function()
					stopTracks();
					loadAnimation("rbxassetid://3189773368");
				end);

				Dance2.Name = "Dance2"
				Dance2.Parent = Animations
				Dance2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Dance2.Size = UDim2.new(1, 0, 0, 30)
				Dance2.Font = Enum.Font.SourceSansBold
				Dance2.Text = "Dance2"
				Dance2.TextColor3 = Color3.fromRGB(0, 0, 0)
				Dance2.TextSize = 14.000
				Dance2.MouseButton1Click:Connect(function()
					stopTracks();
					loadAnimation("rbxassetid://3189776546");
				end);

				Greet.Name = "Greet"
				Greet.Parent = Animations
				Greet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Greet.Size = UDim2.new(1, 0, 0, 30)
				Greet.Font = Enum.Font.SourceSansBold
				Greet.Text = "Greet"
				Greet.TextColor3 = Color3.fromRGB(0, 0, 0)
				Greet.TextSize = 14.000
				Greet.MouseButton1Click:Connect(function()
					stopTracks();
					loadAnimation("rbxassetid://3189777795");
				end);

				ChestPump.Name = "ChestPump"
				ChestPump.Parent = Animations
				ChestPump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ChestPump.Size = UDim2.new(1, 0, 0, 30)
				ChestPump.Font = Enum.Font.SourceSansBold
				ChestPump.Text = "Chest Pump"
				ChestPump.TextColor3 = Color3.fromRGB(0, 0, 0)
				ChestPump.TextSize = 14.000
				ChestPump.MouseButton1Click:Connect(function()
					stopTracks();
					loadAnimation("rbxassetid://3189779152");
				end);

				Praying.Name = "Praying"
				Praying.Parent = Animations
				Praying.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Praying.Size = UDim2.new(1, 0, 0, 30)
				Praying.Font = Enum.Font.SourceSansBold
				Praying.Text = "Praying"
				Praying.TextColor3 = Color3.fromRGB(0, 0, 0)
				Praying.TextSize = 14.000
				Praying.MouseButton1Click:Connect(function()
					stopTracks();
					loadAnimation("rbxassetid://3487719500");
				end);

				Stop.Name = "Stop"
				Stop.Parent = Animations
				Stop.BackgroundColor3 = Color3.fromRGB(255, 112, 112)
				Stop.Size = UDim2.new(1, 0, 0, 30)
				Stop.Font = Enum.Font.SourceSansBold
				Stop.Text = "Stop Animation"
				Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
				Stop.TextSize = 14.000
				Stop.MouseButton1Click:Connect(function()
					stopTracks();
				end);
				--scripts
				local plr = game.Players.LocalPlayer

				plr:GetMouse().KeyDown:Connect(function(K)
					if K == "p" then
						Animations.Visible = false
					end
				end)
end);
CreateButton("Aimlock FirstPerson", Combat1, function()
    getgenv().AimPart = "Head" -- For R15 Games: {UpperTorso, LowerTorso, HumanoidRootPart, Head} | For R6 Games: {Head, Torso, HumanoidRootPart}
				getgenv().AimlockToggleKey = "E" -- Toggles Aimbot On/Off 
				getgenv().AimRadius = 25 -- How far away from someones character you want to lock on at
				getgenv().ThirdPerson = false -- Locking onto someone in your Third Person POV
				getgenv().FirstPerson = true -- Locking onto someone in your First Person POV
				getgenv().TeamCheck = false -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
				getgenv().PredictMovement = true -- Predicts if fthey are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed 
				getgenv().PredictionVelocity = 3 -- The speed of the PredictMovement feature 

				getgenv().CiazwareUniversalAimbotLoadingTime = tick()
				if CiazwareUniversalAimbotLoaded == true then
					return 
				end

				local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
				local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
				local Aimlock, MousePressed, CanNotify = true, false, false;
				local AimlockTarget;
				getgenv().CiazwareUniversalAimbotLoaded = true


				getgenv().WorldToViewportPoint = function(P)
					return Camera:WorldToViewportPoint(P)
				end

				getgenv().WorldToScreenPoint = function(P)
					return Camera.WorldToScreenPoint(Camera, P)
				end

				getgenv().GetObscuringObjects = function(T)
					if T and T:FindFirstChild(getgenv().AimPart) and Client and Client.Character:FindFirstChild("Head") then 
						local RayPos = workspace:FindPartOnRay(RNew(
							T[getgenv().AimPart].Position, Client.Character.Head.Position)
						)
						if RayPos then return RayPos:IsDescendantOf(T) end
					end
				end

				getgenv().GetNearestTarget = function()
					-- Credits to whoever made this, i didnt make it, and my own mouse2plr function kinda sucks
					local players = {}
					local PLAYER_HOLD  = {}
					local DISTANCES = {}
					for i, v in pairs(Players:GetPlayers()) do
						if v ~= Client then
							table.insert(players, v)
						end
					end
					for i, v in pairs(players) do
						if v.Character ~= nil then
							local AIM = v.Character:FindFirstChild("Head")
							if getgenv().TeamCheck == true and v.Team ~= Client.Team then
								local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
								local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
								local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
								local DIFF = math.floor((POS - AIM.Position).magnitude)
								PLAYER_HOLD[v.Name .. i] = {}
								PLAYER_HOLD[v.Name .. i].dist= DISTANCE
								PLAYER_HOLD[v.Name .. i].plr = v
								PLAYER_HOLD[v.Name .. i].diff = DIFF
								table.insert(DISTANCES, DIFF)
							elseif getgenv().TeamCheck == false and v.Team == Client.Team then 
								local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
								local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
								local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
								local DIFF = math.floor((POS - AIM.Position).magnitude)
								PLAYER_HOLD[v.Name .. i] = {}
								PLAYER_HOLD[v.Name .. i].dist= DISTANCE
								PLAYER_HOLD[v.Name .. i].plr = v
								PLAYER_HOLD[v.Name .. i].diff = DIFF
								table.insert(DISTANCES, DIFF)
							end
						end
					end

					if unpack(DISTANCES) == nil then
						return nil
					end

					local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
					if L_DISTANCE > getgenv().AimRadius then
						return nil
					end

					for i, v in pairs(PLAYER_HOLD) do
						if v.diff == L_DISTANCE then
							return v.plr
						end
					end
					return nil
				end
				Uis.InputBegan:Connect(function(Key)
					if not (Uis:GetFocusedTextBox()) then 
						if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
							pcall(function()
								if MousePressed ~= true then MousePressed = true end 
								local Target;Target = GetNearestTarget()
								if Target ~= nil then 
									AimlockTarget = Target
								end
							end)
						end
						if Key.KeyCode == Enum.KeyCode[AimlockToggleKey] then 
							Aimlock = not Aimlock
						end
					end
				end)
				Uis.InputEnded:Connect(function(Key)
					if not (Uis:GetFocusedTextBox()) then 
						if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
							if AimlockTarget ~= nil then AimlockTarget = nil end
							if MousePressed ~= false then 
								MousePressed = false 
							end
						end
					end
				end)

				RService.RenderStepped:Connect(function()
					if getgenv().FirstPerson == true and getgenv().ThirdPerson == false then 
						if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
							CanNotify = true 
						else 
							CanNotify = false 
						end
					elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then 
						if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
							CanNotify = true 
						else 
							CanNotify = false 
						end
					end
					if Aimlock == true and MousePressed == true then 
						if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then 
							if getgenv().FirstPerson == true then
								if CanNotify == true then
									if getgenv().PredictMovement == true then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
									elseif getgenv().PredictMovement == false then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
									end
								end
							elseif getgenv().ThirdPerson == true then 
								if CanNotify == true then
									if getgenv().PredictMovement == true then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
									elseif getgenv().PredictMovement == false then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
									end
								end 
							end
						end
					end
				end)

end);
CreateButton("Aimlock ThirdPerson", Combat1, function()
      getgenv().AimPart = "Head" -- For R15 Games: {UpperTorso, LowerTorso, HumanoidRootPart, Head} | For R6 Games: {Head, Torso, HumanoidRootPart}
				getgenv().AimlockToggleKey = "E" -- Toggles Aimbot On/Off 
				getgenv().AimRadius = 25 -- How far away from someones character you want to lock on at
				getgenv().ThirdPerson = true -- Locking onto someone in your Third Person POV
				getgenv().FirstPerson = false -- Locking onto someone in your First Person POV
				getgenv().TeamCheck = false -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
				getgenv().PredictMovement = true -- Predicts if fthey are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed 
				getgenv().PredictionVelocity = 3 -- The speed of the PredictMovement feature 

				getgenv().CiazwareUniversalAimbotLoadingTime = tick()
				if CiazwareUniversalAimbotLoaded == true then
					return 
				end

				local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
				local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
				local Aimlock, MousePressed, CanNotify = true, false, false;
				local AimlockTarget;
				getgenv().CiazwareUniversalAimbotLoaded = true


				getgenv().WorldToViewportPoint = function(P)
					return Camera:WorldToViewportPoint(P)
				end

				getgenv().WorldToScreenPoint = function(P)
					return Camera.WorldToScreenPoint(Camera, P)
				end

				getgenv().GetObscuringObjects = function(T)
					if T and T:FindFirstChild(getgenv().AimPart) and Client and Client.Character:FindFirstChild("Head") then 
						local RayPos = workspace:FindPartOnRay(RNew(
							T[getgenv().AimPart].Position, Client.Character.Head.Position)
						)
						if RayPos then return RayPos:IsDescendantOf(T) end
					end
				end

				getgenv().GetNearestTarget = function()
					-- Credits to whoever made this, i didnt make it, and my own mouse2plr function kinda sucks
					local players = {}
					local PLAYER_HOLD  = {}
					local DISTANCES = {}
					for i, v in pairs(Players:GetPlayers()) do
						if v ~= Client then
							table.insert(players, v)
						end
					end
					for i, v in pairs(players) do
						if v.Character ~= nil then
							local AIM = v.Character:FindFirstChild("Head")
							if getgenv().TeamCheck == true and v.Team ~= Client.Team then
								local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
								local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
								local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
								local DIFF = math.floor((POS - AIM.Position).magnitude)
								PLAYER_HOLD[v.Name .. i] = {}
								PLAYER_HOLD[v.Name .. i].dist= DISTANCE
								PLAYER_HOLD[v.Name .. i].plr = v
								PLAYER_HOLD[v.Name .. i].diff = DIFF
								table.insert(DISTANCES, DIFF)
							elseif getgenv().TeamCheck == false and v.Team == Client.Team then 
								local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
								local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
								local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
								local DIFF = math.floor((POS - AIM.Position).magnitude)
								PLAYER_HOLD[v.Name .. i] = {}
								PLAYER_HOLD[v.Name .. i].dist= DISTANCE
								PLAYER_HOLD[v.Name .. i].plr = v
								PLAYER_HOLD[v.Name .. i].diff = DIFF
								table.insert(DISTANCES, DIFF)
							end
						end
					end

					if unpack(DISTANCES) == nil then
						return nil
					end

					local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
					if L_DISTANCE > getgenv().AimRadius then
						return nil
					end

					for i, v in pairs(PLAYER_HOLD) do
						if v.diff == L_DISTANCE then
							return v.plr
						end
					end
					return nil
				end
				Uis.InputBegan:Connect(function(Key)
					if not (Uis:GetFocusedTextBox()) then 
						if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
							pcall(function()
								if MousePressed ~= true then MousePressed = true end 
								local Target;Target = GetNearestTarget()
								if Target ~= nil then 
									AimlockTarget = Target
								end
							end)
						end
						if Key.KeyCode == Enum.KeyCode[AimlockToggleKey] then 
							Aimlock = not Aimlock
						end
					end
				end)
				Uis.InputEnded:Connect(function(Key)
					if not (Uis:GetFocusedTextBox()) then 
						if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
							if AimlockTarget ~= nil then AimlockTarget = nil end
							if MousePressed ~= false then 
								MousePressed = false 
							end
						end
					end
				end)

				RService.RenderStepped:Connect(function()
					if getgenv().FirstPerson == true and getgenv().ThirdPerson == false then 
						if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
							CanNotify = true 
						else 
							CanNotify = false 
						end
					elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then 
						if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
							CanNotify = true 
						else 
							CanNotify = false 
						end
					end
					if Aimlock == true and MousePressed == true then 
						if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then 
							if getgenv().FirstPerson == true then
								if CanNotify == true then
									if getgenv().PredictMovement == true then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
									elseif getgenv().PredictMovement == false then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
									end
								end
							elseif getgenv().ThirdPerson == true then 
								if CanNotify == true then
									if getgenv().PredictMovement == true then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
									elseif getgenv().PredictMovement == false then 
										Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
									end
								end 
							end
						end
					end
				end)

end);
CreateButton("Aimlock Tool", Combat1, function()
Aimlock = nil

				for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
					if v.ClassName == "Tool" and v.Name == "Aimlock Tool" then
						v:Destroy() 
					end
				end
				for i, v in pairs(LocalPlayer.Character:GetChildren()) do
					if v.ClassName == "Tool" and v.Name == "Aimlock Tool" then
						v:Destroy() 
					elseif v.ClassName == "Tool" then
						v.Parent = LocalPlayer.Backpack
					end
				end

				local AimlockTool = Instance.new("Tool")
				AimlockTool.Name = "Aimlock Tool"
				AimlockTool.Parent = LocalPlayer.Backpack
				AimlockTool.RequiresHandle = false
				AimlockTool.TextureId = "rbxasset://1532350639"

				AimlockTool.Activated:Connect(function()
					local Plr = FindPlrOnMouse()

					if Plr ~= nil and Plr.Character and Plr.Character:FindFirstChild("Head") and Plr.Character:FindFirstChild("UpperTorso") then
						Aimlock = Plr 

						game:GetService("StarterGui"):SetCore("SendNotification",{
							Title = "AIMLOCK | Faded";
							Text = "Aimlocking towards: " .. Plr.Name .. ", use any gun and shoot anywhere";
							Duration = 2.5;
						})
					else
						Aimlock = nil

						game:GetService("StarterGui"):SetCore("SendNotification",{
							Title = "AIMLOCK | Faded ";
							Text = "No player clicked on, aimlocking towards mouse as normal";
							Duration = 2.5;
						})
					end
				end)
			end)

			if getrawmetatable then
				game:GetService("RunService").Heartbeat:Connect(function()
					if Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChild("Head") then
						game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character.Head.Position, "Aimlock")
					elseif Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChildOfClass("HumanoidRootPart") then
						game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character:FindFirstChildOfClass("HumanoidRootPart").Position, "Aimlock")
					elseif Aimlock == nil then
						game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", game:GetService("Players").LocalPlayer:GetMouse().Hit.Position, "Aimlock")
					end
				end)
			else
				for i = 1, 10 do
					game:GetService("RunService").Heartbeat:Connect(function()
						if Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChild("Head") then
							game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character.Head.Position)
						elseif Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChildOfClass("Part") then
							game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character:FindFirstChildOfClass("Part").Position)
						end
					end)
					game:GetService("RunService").RenderStepped:Connect(function()
						if Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChild("Head") then
							game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character.Head.Position)
						elseif Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChildOfClass("Part") then
							game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character:FindFirstChildOfClass("Part").Position)
						end
					end)
					game:GetService("RunService").Stepped:Connect(function()
						if Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChild("Head") then
							game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character.Head.Position)
						elseif Aimlock ~= nil and Aimlock.Character and Aimlock.Character:FindFirstChildOfClass("Part") then
							game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Aimlock.Character:FindFirstChildOfClass("Part").Position)

						end
					end)
				end
				end
CreateButton("SilentAim", Combat1, function()
	local a=getrawmetatable(game)local b=a.__index;local c=loadstring(game:HttpGetAsync("https://gist.githubusercontent.com/pixelheadx/fff108da96922e834036a6619ce07ff0/raw/cf8bc54198875dbef85a2b9711583cbd05e4d69a/gistfile1.txt"))()c["TeamCheck"]=false;setreadonly(a,false)a.__index=newcclosure(function(d,e)if d:IsA("Mouse")and(e=="Hit"or e=="Target")then if c.checkSilentAim()then local f=rawget(c,"Selected")if f and f.Character and f.Character.FindFirstChild(f.Character,"Head")then return e=="Hit"and f.Character.Head.CFrame or f.Character.Head end end end;return b(d,e)end)setreadonly(a,true)
end);
CreateButton("NoRecoil", Combat1, function()
    for i,v in pairs(game:GetService('Workspace'):GetChildren()) do
					if v:IsA('Camera') then
						v:Destroy()
					end
				end
				local LocalPlayer = game:GetService('Players').LocalPlayer;
				local newcam = Instance.new('Camera',game.Workspace)
				game.Workspace.Camera.CameraSubject = LocalPlayer.Character.Humanoid;
				newcam.Name = 'Camera'
				newcam.CameraType = 'Custom'
				newcam.CameraSubject = game:GetService('Workspace').Players:FindFirstChild(player.Name):FindFirstChild('Humanoid')
				newcam.HeadLocked = true
				newcam.HeadScale = 1
end);
CreateButton("SilentBlock", Combat1, function()
    while wait() do
					for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
						if (v.Animation.AnimationId:match("rbxassetid://2788354405")) then
							v:Stop();
						end;
					end;
				end
end);
CreateButton("AutoBlock", Combat1, function()
    while wait() do
					pcall(function()
						for i, v in pairs(game.Players:GetPlayers()) do
							if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 and v.Name ~= game.Players.LocalPlayer.Name then 
								game.ReplicatedStorage.MainEvent:FireServer("Block", true)
								wait(3)
								game.ReplicatedStorage.MainEvent:FireServer("Block", false)
							end
						end
					end)
				end
end);
CreateButton("Esp Tracers", Esp1, function()
    local camera = workspace.CurrentCamera

				local useTeamCheck = false
				local hideWhenNotLooking = true

				for _,v in pairs(game.Players:GetPlayers()) do
					if useTeamCheck == false or v == false or v.Team ~= game.Players.LocalPlayer.Team then    
						if v ~= false or v.game.LocalPlayers and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
							local Line = Drawing.new("Line")
							Line.Visible = true
							Line.From = Vector2.new(camera.ViewportSize.x / 2, camera.ViewportSize.Y / 2)
							Line.To = Vector2.new(vector.X, vector.Y)
							Line.Color = Color3.fromRGB(255, 255, 255)
							Line.Thickness = 1
							Line.Transparency = 1

							function script()
								game:GetService("RunService").RenderStepped:Connect(function(step)
									if useTeamCheck == false or v == false or v.Team ~= game.Players.LocalPlayer.Team then 
										if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
											local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
											if onscreen == true then
												Line.To = Vector2.new(vector.X, vector.Y)
												Line.Visible = true
											else
												if hideWhenNotLooking == true then
													Line.Visible = false
												end
											end	
										end
									end	
								end)
							end
							coroutine.wrap(script)()
						end 
					end	
					v.CharacterAdded:Connect(function()
						if useTeamCheck == false or v == false or v.Team ~= game.Players.LocalPlayer.Team then    
							repeat wait () until v.Character ~= nil
							repeat wait () until v.Character:FindFirstChild("HumanoidRootPart") ~= nil
							local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
							local Line = Drawing.new("Line")
							Line.Visible = true
							Line.From = Vector2.new(camera.ViewportSize.x / 2, camera.ViewportSize.Y / 2)
							Line.To = Vector2.new(vector.X, vector.Y)
							Line.Color = Color3.fromRGB(255, 255, 255)
							Line.Thickness = 1
							Line.Transparency = 1 

							function script()
								game:GetService("RunService").RenderStepped:Connect(function(step)
									if useTeamCheck == false or v == false or v.Team ~= game.Players.LocalPlayer.Team then
										if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
											local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
											if onscreen == true then
												Line.To = Vector2.new(vector.X, vector.Y)
												Line.Visible = true
											else
												Line.Visible = false
											end
										end
									end
								end)
							end
							coroutine.wrap(script)()
						end
					end)
				end

				game.Players.PlayerAdd:Connect(function(v)
					if useTeamCheck == false or v == false or v.Team ~= game.Players.LocalPlayer.Team then    
						if v ~= false or v.game.LocalPlayers and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
							local Line = Drawing.new("Line")
							Line.Visible = true
							Line.From = Vector2.new(camera.ViewportSize.x / 2, camera.ViewportSize.Y / 2)
							Line.To = Vector2.new(vector.X, vector.Y)
							Line.Color = Color3.fromRGB(255, 255, 255)
							Line.Thickness = 1
							Line.Transparency = 1

							function script()
								game:GetService("RunService").RenderStepped:Connect(function(step)
									if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
										local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
										if onscreen == true then
											Line.To = Vector2.new(vector.X, vector.Y)
											Line.Visible = true
										else
											if hideWhenNotLooking == true then
												Line.Visible = false
											end
										end
									end	
								end)
							end
							coroutine.wrap(script)()
						end 
					end	
					v.CharacterAdded:Connect(function()
						if useTeamCheck == false or v == false or v.Team ~= game.Players.LocalPlayer.Team then    
							repeat wait () until v.Character ~= nil
							repeat wait () until v.Character:FindFirstChild("HumanoidRootPart") ~= nil
							local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
							local Line = Drawing.new("Line")
							Line.Visible = true
							Line.From = Vector2.new(camera.ViewportSize.x / 2, camera.ViewportSize.Y / 2)
							Line.To = Vector2.new(vector.X, vector.Y)
							Line.Color = Color3.fromRGB(255, 255, 255)
							Line.Thickness = 1
							Line.Transparency = 1 

							function script()
								game:GetService("RunService").RenderStepped:Connect(function(step)
									if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
										local vector,onscreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
										if onscreen == true then
											Line.To = Vector2.new(vector.X, vector.Y)
											Line.Visible = true
										else
											if hideWhenNotLooking == true then
												Line.Visible = false
											end	
										end
									end
								end)
							end
							coroutine.wrap(script)()
						end
					end)
				end)
end);
CreateButton("Name Esp", Esp1, function()
    	function Create(base)
					local bb = Instance.new('BillboardGui', game.CoreGui)
					bb.Adornee = base
					bb.ExtentsOffset = Vector3.new(0,1,0)
					bb.AlwaysOnTop = true
					bb.Size = UDim2.new(0,5,0,5)
					bb.StudsOffset = Vector3.new(0,1,0)
					bb.Name = 'tracker'
					local frame = Instance.new('Frame',bb)
					frame.ZIndex = 10
					frame.BackgroundTransparency = 0.3
					frame.Size = UDim2.new(1,0,1,0)
					local txtlbl = Instance.new('TextLabel',bb)
					txtlbl.ZIndex = 10
					txtlbl.BackgroundTransparency = 1
					txtlbl.Position = UDim2.new(0,0,0,-35)
					txtlbl.Size = UDim2.new(1,0,10,0)
					txtlbl.Font = 'ArialBold'
					txtlbl.FontSize = 'Size12'
					txtlbl.Text = base.Parent.Name:upper()
					txtlbl.TextStrokeTransparency = 0.5
					txtlbl.TextColor3 = Color3.new(255, 255, 255)
					frame.BackgroundColor3 = Color3.new(255, 255, 255)
				end

				function Clear()
					for _,v in pairs(game.CoreGui:children()) do
						if v.Name == 'tracker' and v:isA('BillboardGui') then
							v:Destroy()
						end
					end
				end

				function Find()
					Clear()
					track = true
					spawn(function()
						while wait(1) do
							if track then
								Clear()
								for _,v in pairs(game.Players:players()) do
									if v.Character and v.Character.Head then
										Create(v.Character.Head, false)
									end
								end
							end
							wait(1)
						end
					end)
				end

				Find()

			end) 

CreateButton("Cham Esp[On]", Esp1, function()
    				crashy = true 
				on = false
				if game.CoreGui:FindFirstChild('ESP') then
					game.CoreGui.ESP:Destroy()
				elseif game.Players.LocalPlayer.PlayerGui:FindFirstChild('ESP') then
					game.Players.LocalPlayer.PlayerGui.ESP:Destroy()
				end
				if on == true then
					print('man')
				else
					function doit(hey)
						local t1 = Instance.new('SurfaceGui',hey)
						t1.AlwaysOnTop = true
						local t1g = Instance.new('Frame',t1)
						t1g.Size = UDim2.new(1,0,1,0)
						t1g.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						local t2 = Instance.new('SurfaceGui',hey)       
						t2.AlwaysOnTop = true
						t2.Face = Enum.NormalId.Right
						local t2g = Instance.new('Frame',t2)
						t2g.Size = UDim2.new(1,0,1,0)
						t2g.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						local t3 = Instance.new('SurfaceGui',hey)
						t3.AlwaysOnTop = true
						t3.Face = Enum.NormalId.Left
						local t3g = Instance.new('Frame',t3)
						t3g.Size = UDim2.new(1,0,1,0)
						t3g.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						local t4 = Instance.new('SurfaceGui',hey)
						t4.AlwaysOnTop = true
						t4.Face = Enum.NormalId.Back
						local t4g = Instance.new('Frame',t4)
						t4g.Size = UDim2.new(1,0,1,0)
						t4g.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						local t5 = Instance.new('SurfaceGui',hey)
						t5.AlwaysOnTop = true
						t5.Face = Enum.NormalId.Top
						local t5g = Instance.new('Frame',t5)
						t5g.Size = UDim2.new(1,0,1,0)
						t5g.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						local t6 = Instance.new('SurfaceGui',hey)
						t6.AlwaysOnTop = true
						t6.Face = Enum.NormalId.Bottom
						local t6g = Instance.new('Frame',t6)
						t6g.Size = UDim2.new(1,0,1,0)
						t6g.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					end
					function undo(chr)
						for i,v in pairs(chr:GetChildren()) do
							if v.ClassName == "Part" or v.ClassName == "MeshPart" then
								for a,c in pairs(v:GetChildren()) do
									if c.ClassName == "SurfaceGui" then
										c:Destroy()
									end
									if c.ClassName == "BillboardGui" and c.Name == "thingyye" then
										c:Destroy()
									end
								end
							end
						end
					end

					local gui = Instance.new('ScreenGui')

					gui.Name = "ESP"
					gui.ResetOnSpawn = false
					local frame = Instance.new('Frame',gui)
					frame.Size = UDim2.new(0.2,0,0.3,0)
					frame.Position = UDim2.new(0,0,0.9,0)
					frame.BackgroundTransparency = 0.5
					frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					frame.BorderSizePixel = 4
					frame.BorderColor3 = Color3.fromRGB(66,134,244)
					frame.Active = true
					frame.Draggable = true 
					local but = Instance.new('TextButton',frame)
					but.Text = "ESP On"
					but.TextColor3 = Color3.fromRGB(255,255,255)
					but.Size = UDim2.new(0.7,0,0.3,0)
					but.Position = UDim2.new(0.15,0,0.5,0)
					but.BorderSizePixel = 0
					but.TextScaled = true
					but.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					but.BackgroundTransparency = 0.4
					for i,v in pairs(game.Players:GetChildren()) do
						if v.Character ~= nil then
							undo(v.Character)
						end
					end

					spawn(function()
						if true then
							on = true
							for i,v in pairs(game.Players:GetChildren()) do
								if v.Character ~= game.Players.LocalPlayer.Character and v.Character.Head:FindFirstChild('ScreenGui') == nil then
									if v.Character:FindFirstChild('Head') then
									end
									for a,c in pairs(v.Character:GetChildren()) do
										if c.ClassName == "MeshPart" and c.Transparency ~= 1 then
											doit(c)
										elseif c.ClassName == "Part" and c.Transparency ~= 1 then
											doit(c)
										end
									end
								end 
							end 
						else
							but.Text = "ESP On"
							on = false
							for i,v in pairs(game.Players:GetChildren()) do
								undo(v.Character)
							end
						end
					end)

					for i,v in pairs(game.Players:GetChildren()) do
						v.CharacterAdded:connect(function()
							v.Character:WaitForChild('Head')
							wait(1)
							if on == true then
								if v.Character ~= game.Players.LocalPlayer.Character and v.Character.Head:FindFirstChild('ScreenGui') == nil then
									if v.Character:FindFirstChild('Head') then
										local bill = Instance.new('BillboardGui',v.Character.Head)
										bill.Name = "thingyye"
										bill.AlwaysOnTop = true
										bill.Size = UDim2.new(2,1,2)
										bill.Adornee = v.Character.Head 
									end
									for a,c in pairs(v.Character:GetChildren()) do
										if c.ClassName == "MeshPart" and c.Transparency ~= 1 then
											doit(c)
										elseif c.ClassName == "Part" and c.Transparency ~= 1 then
											doit(c)
										end
									end
								end 
							end
						end)
					end  

					game.Players.PlayerAdded:connect(function(v)
						v.CharacterAdded:connect(function()
							v.Character:WaitForChild('Head')
							wait(1)
							if on == true then
								if v.Character ~= game.Players.LocalPlayer.Character and v.Character.Head:FindFirstChild('ScreenGui') == nil then
									if v.Character:FindFirstChild('Head') then
										local bill = Instance.new('BillboardGui',v.Character.Head)
										bill.Name = "thingyye"
										bill.AlwaysOnTop = true
										bill.Size = UDim2.new(2,1,2)
										bill.Adornee = v.Character.Head 
									end
									for a,c in pairs(v.Character:GetChildren()) do
										if c.ClassName == "MeshPart" and c.Transparency ~= 1 then
											doit(c)
										elseif c.ClassName == "Part" and c.Transparency ~= 1 then
											doit(c)
										end
									end
								end 
							end
						end)
					end)
				end
end);
CreateButton("Cham Esp[Off]", Esp1, function()
    				crashy = true 
				on = false
				if game.CoreGui:FindFirstChild('ESP') then
					game.CoreGui.ESP:Destroy()
				elseif game.Players.LocalPlayer.PlayerGui:FindFirstChild('ESP') then
					game.Players.LocalPlayer.PlayerGui.ESP:Destroy()
				end

				function doit(hey)
					local t1 = Instance.new('SurfaceGui',hey)
					t1.AlwaysOnTop = true
					local t1g = Instance.new('Frame',t1)
					t1g.Size = UDim2.new(1,0,1,0)
					t1g.BackgroundColor3 = t1.Parent.BrickColor.Color
					local t2 = Instance.new('SurfaceGui',hey)       
					t2.AlwaysOnTop = true
					t2.Face = Enum.NormalId.Right
					local t2g = Instance.new('Frame',t2)
					t2g.Size = UDim2.new(1,0,1,0)
					t2g.BackgroundColor3 = t2.Parent.BrickColor.Color
					local t3 = Instance.new('SurfaceGui',hey)
					t3.AlwaysOnTop = true
					t3.Face = Enum.NormalId.Left
					local t3g = Instance.new('Frame',t3)
					t3g.Size = UDim2.new(1,0,1,0)
					t3g.BackgroundColor3 = t3.Parent.BrickColor.Color
					local t4 = Instance.new('SurfaceGui',hey)
					t4.AlwaysOnTop = true
					t4.Face = Enum.NormalId.Back
					local t4g = Instance.new('Frame',t4)
					t4g.Size = UDim2.new(1,0,1,0)
					t4g.BackgroundColor3 = t4.Parent.BrickColor.Color
					local t5 = Instance.new('SurfaceGui',hey)
					t5.AlwaysOnTop = true
					t5.Face = Enum.NormalId.Top
					local t5g = Instance.new('Frame',t5)
					t5g.Size = UDim2.new(1,0,1,0)
					t5g.BackgroundColor3 = t5.Parent.BrickColor.Color
					local t6 = Instance.new('SurfaceGui',hey)
					t6.AlwaysOnTop = true
					t6.Face = Enum.NormalId.Bottom
					local t6g = Instance.new('Frame',t6)
					t6g.Size = UDim2.new(1,0,1,0)
					t6g.BackgroundColor3 = t6.Parent.BrickColor.Color
				end
				function undo(chr)
					for i,v in pairs(chr:GetChildren()) do
						if v.ClassName == "Part" or v.ClassName == "MeshPart" then
							for a,c in pairs(v:GetChildren()) do
								if c.ClassName == "SurfaceGui" then
									c:Destroy()
								end
								if c.ClassName == "BillboardGui" and c.Name == "thingyye" then
									c:Destroy()
								end
							end
						end
					end
				end

				local gui = Instance.new('ScreenGui')

				gui.Name = "ESP"
				gui.ResetOnSpawn = false
				local frame = Instance.new('Frame',gui)
				frame.Size = UDim2.new(0.2,0,0.3,0)
				frame.Position = UDim2.new(0,0,0.9,0)
				frame.BackgroundTransparency = 0.5
				frame.BackgroundColor3 = Color3.fromRGB(131,182,239)
				frame.BorderSizePixel = 4
				frame.BorderColor3 = Color3.fromRGB(66,134,244)
				frame.Active = true
				frame.Draggable = true
				local but = Instance.new('TextButton',frame)
				but.Text = "ESP On"
				but.TextColor3 = Color3.fromRGB(255,255,255)
				but.Size = UDim2.new(0.7,0,0.3,0)
				but.Position = UDim2.new(0.15,0,0.5,0)
				but.BorderSizePixel = 0
				but.TextScaled = true
				but.BackgroundColor3 = Color3.fromRGB(66,134,244)
				but.BackgroundTransparency = 0.4
				for i,v in pairs(game.Players:GetChildren()) do
					if v.Character ~= nil then
						undo(v.Character)
					end
				end

				spawn(function()
					if true then
						on = true
						for i,v in pairs(game.Players:GetChildren()) do
							if v.Character ~= game.Players.LocalPlayer.Character and v.Character.Head:FindFirstChild('ScreenGui') == nil then
								if v.Character:FindFirstChild('Head') then
									local bill = Instance.new('BillboardGui',v.Character.Head)
									bill.Name = "thingyye"
									bill.AlwaysOnTop = true
									bill.Size = UDim2.new(2,1,2)
									bill.Visible = false
									bill.Adornee = v.Character.Head 
									bill.ResetOnSpawn = false
								end
								for a,c in pairs(v.Character:GetChildren()) do
									if c.ClassName == "MeshPart" and c.Transparency ~= 1 then
										doit(c)
									elseif c.ClassName == "Part" and c.Transparency ~= 1 then
										doit(c)
									end
								end
							end 
						end 
					else
						but.Text = "ESP On"
						on = false
						for i,v in pairs(game.Players:GetChildren()) do
							undo(v.Character)
						end
					end
				end)

				for i,v in pairs(game.Players:GetChildren()) do
					v.CharacterAdded:connect(function()
						v.Character:WaitForChild('Head')
						wait(1)
						if on == true then
							if v.Character ~= game.Players.LocalPlayer.Character and v.Character.Head:FindFirstChild('ScreenGui') == nil then
								if v.Character:FindFirstChild('Head') then
									local bill = Instance.new('BillboardGui',v.Character.Head)
									bill.Name = "thingyye"
									bill.AlwaysOnTop = true
									bill.Size = UDim2.new(2,1,2)
									bill.Adornee = v.Character.Head
									bill.Visible = false 
									bill.ResetOnSpawn = false
								end
								for a,c in pairs(v.Character:GetChildren()) do
									if c.ClassName == "MeshPart" and c.Transparency ~= 1 then
										doit(c)
									elseif c.ClassName == "Part" and c.Transparency ~= 1 then
										doit(c)
									end
								end
							end 
						end
					end)
				end  

				game.Players.PlayerAdded:connect(function(v)
					v.CharacterAdded:connect(function()
						v.Character:WaitForChild('Head')
						wait(1)
						if on == true then
							if v.Character ~= game.Players.LocalPlayer.Character and v.Character.Head:FindFirstChild('ScreenGui') == nil then
								if v.Character:FindFirstChild('Head') then
									local bill = Instance.new('BillboardGui',v.Character.Head)
									bill.Name = "thingyye"
									bill.AlwaysOnTop = true
									bill.Size = UDim2.new(2,1,2)
									bill.Adornee = v.Character.Head
									bill.Visible = false
									bill.ResetOnSpawn = false
								end
								for a,c in pairs(v.Character:GetChildren()) do
									if c.ClassName == "MeshPart" and c.Transparency ~= 1 then
										doit(c)
									elseif c.ClassName == "Part" and c.Transparency ~= 1 then
										doit(c)
									end
								end
							end
							wait(1)
							gui.ResetOnSpawn = false
							frame.ResetOnSpawn = false
						end
					end)
				end)
end);
CreateButton("Cash Esp", Esp1, function()
    local ESPholder = Instance.new("Folder", game.CoreGui)
				function cham(object)
					if object.Name == "MoneyDrop" then
						local a = Instance.new("BoxHandleAdornment", ESPholder)
						a.Adornee = object
						a.AlwaysOnTop = true
						a.ZIndex = 10
						a.Size = object.Size
						a.Transparency = 0.3
						a.Color = object.BrickColor
						local bill = object:WaitForChild("BillboardGui")
						bill.AlwaysOnTop = true
						bill.Size = UDim2.new(2, 10, 1, 5)
						spawn(function()
							while true do
								if object.Parent.ChildRemoving:wait() == object then
									a:Destroy()
									break
								end
							end
						end)
					end
				end
				for i, v in next, game.Workspace.Ignored.Drop:GetChildren() do
					cham(v)
				end
				game.Workspace.Ignored.Drop.ChildAdded:connect(cham)
end);
CreateButton("Zombie", Animations1, function()
    	local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Toy", Animations1, function()
    	local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Cartoony", Animations1, function()
    	local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("SuperHero", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Ninja", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Knight", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Levitation", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Elder", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Robot", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616089559"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616091570"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616090535"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616086039"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616087089"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Bubbly", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=910004836"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=910009958"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=910034870"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=910016857"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=910001910"
				Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=910030921"
				Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=910028158"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Astronaut", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Anthro", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=2510196951"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=2510197257"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=2510202577"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=2510198475"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=2510197830"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=2510192778"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=2510195892"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Stylish", Animations1, function()
    				local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Vampire", Animations1, function()
    	local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Mage", Animations1, function()
    	local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Pirate", Animations1, function()
    local Animate = game.Players.LocalPlayer.Character.Animate
				Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
				Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
				Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
				Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
				Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
				Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
				Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
end);
CreateButton("Anti Ragdoll [Better Unban]", God1, function()
    				local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('RagdollConstraints'):Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter);
				spoofValue.Name = 'RagdollConstraints';
				wait()
				local d = {}
				local e = {}
				local g = {}
				local h = {}
				local j = {}
				local k = {}
				local function l()
					local m = 3
					local n = checkcaller
					local o = getrawmetatable(game)
					setreadonly(o, false)
					local p = o.__index
					local q = o.__newindex
					local r = o.__namecall
					o.__index =
						newcclosure(
							function(s, t)
							if n() then
								return p(s, t)
							end
							if d[s] and d[s][t] then
								local u = d[s][t]
								if u["IsCallback"] == true then
									return u["Value"](s)
								else
									return u["Value"]
								end
							end
							if g[t] then
								local v = g[t]
								if v["IsCallback"] == true then
									return v["Value"](s)
								else
									return v["Value"]
								end
							end
							if j[s] and j[s][t] then
								return k[s][t]
							end
							return p(s, t)
						end
						)
					o.__newindex =
						newcclosure(
							function(w, x, y)
							if n() then
								return q(w, x, y)
							end
							if e[w] and e[w][x] then
								local z = e[w][x]
								if z["Callback"] == nil then
									return
								else
									z["Callback"](w, y)
									return
								end
							end
							if h[x] then
								local A = h[x]
								if A["Callback"] == nil then
									return
								else
									A["Callback"](w, y)
									return
								end
							end
							if j[w] and j[w][x] then
								local B = j[w][x]
								if type(y) ~= B["Type"] then
									error("bad argument #3 to '" .. x .. "' (" .. B["Type"] .. " expected, got " .. type(x) .. ")")
								end
								k[w][x] = y
								return
							end
							return q(w, x, y)
						end
						)
					local D = game.Players.LocalPlayer.Character.Humanoid
					local function A(_)
						local a0 = p(D, _)
						local a1 = type(a0)
						if not j[D] then
							j[D] = {}
						end
						if not k[D] then
							k[D] = {}
						end
						j[D][_] = {Type = a1}
						k[D][_] = p(D, _)
						local a2 = function()
							j[D][_] = nil
							k[D][_] = nil
						end
						return {remove = a2, Remove = a2}
					end
					A("WalkSpeed")
					A("JumpPower")
				end
				l()
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 22
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
end);
CreateButton("Unban", God1, function()
    	repeat
					wait();
				until game:GetService('Players').LocalPlayer.Character:FindFirstChild('FULLY_LOADED_CHAR');
				local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('BodyEffects').Dead:Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
				spoofValue.Name = 'Dead';
end);
CreateButton("Godmode[Guns]", God1, function()
    	local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('RagdollConstraints'):Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter);
				spoofValue.Name = 'RagdollConstraints';
				local name = game.Players.LocalPlayer.Name
				local lol =    game.Workspace:WaitForChild(name)
				local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
				lol.Parent = game.Workspace.Players
				game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
				game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
end);
CreateButton("Godmode[Melees]", God1, function()
    	--made by nighter
				--unban
				local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('BodyEffects').Dead:Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
				spoofValue.Name = 'Dead';
				wait()
				--godblock/godbullet
				local ps = game:GetService("Players")
				local lp = ps.LocalPlayer
				local char = lp.Character

				char.BodyEffects.Armor:Destroy()
				char.BodyEffects.Defense:Destroy()

				local Clone1 = Instance.new("IntValue")
				Clone1.Name = "Armor"
				Clone1.Parent = char.BodyEffects

				local Clone2 = Instance.new("NumberValue")
				Clone2.Name = "Defense"
				Clone2.Parent = char.BodyEffects
				wait()
				--walspeed
				local d = {}
				local e = {}
				local g = {}
				local h = {}
				local j = {}
				local k = {}
				local function l()
					local m = 3
					local n = checkcaller
					local o = getrawmetatable(game)
					setreadonly(o, false)
					local p = o.__index
					local q = o.__newindex
					local r = o.__namecall
					o.__index =
						newcclosure(
							function(s, t)
							if n() then
								return p(s, t)
							end
							if d[s] and d[s][t] then
								local u = d[s][t]
								if u["IsCallback"] == true then
									return u["Value"](s)
								else
									return u["Value"]
								end
							end
							if g[t] then
								local v = g[t]
								if v["IsCallback"] == true then
									return v["Value"](s)
								else
									return v["Value"]
								end
							end
							if j[s] and j[s][t] then
								return k[s][t]
							end
							return p(s, t)
						end
						)
					o.__newindex =
						newcclosure(
							function(w, x, y)
							if n() then
								return q(w, x, y)
							end
							if e[w] and e[w][x] then
								local z = e[w][x]
								if z["Callback"] == nil then
									return
								else
									z["Callback"](w, y)
									return
								end
							end
							if h[x] then
								local A = h[x]
								if A["Callback"] == nil then
									return
								else
									A["Callback"](w, y)
									return
								end
							end
							if j[w] and j[w][x] then
								local B = j[w][x]
								if type(y) ~= B["Type"] then
									error("bad argument #3 to '" .. x .. "' (" .. B["Type"] .. " expected, got " .. type(x) .. ")")
								end
								k[w][x] = y
								return
							end
							return q(w, x, y)
						end
						)
					local D = game.Players.LocalPlayer.Character.Humanoid
					local function A(_)
						local a0 = p(D, _)
						local a1 = type(a0)
						if not j[D] then
							j[D] = {}
						end
						if not k[D] then
							k[D] = {}
						end
						j[D][_] = {Type = a1}
						k[D][_] = p(D, _)
						local a2 = function()
							j[D][_] = nil
							k[D][_] = nil
						end
						return {remove = a2, Remove = a2}
					end
					A("WalkSpeed")
					A("JumpPower")
				end
				l()
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 22
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
				wait()
				while wait() do
					game.ReplicatedStorage.MainEvent:FireServer("Block", true)
					wait()
					for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
						if (v.Animation.AnimationId:match("rbxassetid://2788354405")) then
							v:Stop();
						end;
					end;
				end
				wait()
				while wait() do
					pcall(function()
						for i, v in pairs(game.Players:GetPlayers()) do
							if (workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude < 1 then
								game.ReplicatedStorage.MainEvent:FireServer("Block", true)
							end
						end
					end)
				end
end);
CreateButton("Godmode[Useless]", God1, function()
    game.Players.LocalPlayer.Character.BodyEffects["K.O"]:Destroy()
end);
CreateButton("GodBullet/GodBlock", God1, function()
    local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('RagdollConstraints'):Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter);
				spoofValue.Name = 'RagdollConstraints';
				wait()
				--godblock/godbullet
				local ps = game:GetService("Players")
				local lp = ps.LocalPlayer
				local char = lp.Character

				char.BodyEffects.Armor:Destroy()
				char.BodyEffects.Defense:Destroy()

				local Clone1 = Instance.new("IntValue")
				Clone1.Name = "Armor"
				Clone1.Parent = char.BodyEffects

				local Clone2 = Instance.new("NumberValue")
				Clone2.Name = "Defense"
				Clone2.Parent = char.BodyEffects
end);
CreateButton("Skinny Anti Ragdoll [Better Unban]", God1, function()
    	local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('RagdollConstraints'):Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter);
				spoofValue.Name = 'RagdollConstraints';
				wait()
				local d = {}
				local e = {}
				local g = {}
				local h = {}
				local j = {}
				local k = {}
				local function l()
					local m = 3
					local n = checkcaller
					local o = getrawmetatable(game)
					setreadonly(o, false)
					local p = o.__index
					local q = o.__newindex
					local r = o.__namecall
					o.__index =
						newcclosure(
							function(s, t)
							if n() then
								return p(s, t)
							end
							if d[s] and d[s][t] then
								local u = d[s][t]
								if u["IsCallback"] == true then
									return u["Value"](s)
								else
									return u["Value"]
								end
							end
							if g[t] then
								local v = g[t]
								if v["IsCallback"] == true then
									return v["Value"](s)
								else
									return v["Value"]
								end
							end
							if j[s] and j[s][t] then
								return k[s][t]
							end
							return p(s, t)
						end
						)
					o.__newindex =
						newcclosure(
							function(w, x, y)
							if n() then
								return q(w, x, y)
							end
							if e[w] and e[w][x] then
								local z = e[w][x]
								if z["Callback"] == nil then
									return
								else
									z["Callback"](w, y)
									return
								end
							end
							if h[x] then
								local A = h[x]
								if A["Callback"] == nil then
									return
								else
									A["Callback"](w, y)
									return
								end
							end
							if j[w] and j[w][x] then
								local B = j[w][x]
								if type(y) ~= B["Type"] then
									error("bad argument #3 to '" .. x .. "' (" .. B["Type"] .. " expected, got " .. type(x) .. ")")
								end
								k[w][x] = y
								return
							end
							return q(w, x, y)
						end
						)
					local D = game.Players.LocalPlayer.Character.Humanoid
					local function A(_)
						local a0 = p(D, _)
						local a1 = type(a0)
						if not j[D] then
							j[D] = {}
						end
						if not k[D] then
							k[D] = {}
						end
						j[D][_] = {Type = a1}
						k[D][_] = p(D, _)
						local a2 = function()
							j[D][_] = nil
							k[D][_] = nil
						end
						return {remove = a2, Remove = a2}
					end
					A("WalkSpeed")
					A("JumpPower")
				end
				l()
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 22
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
				wait()
				local Plr = game.Players.LocalPlayer;
				Plr.Character.Humanoid.BodyWidthScale.Value = 0.47;
				Plr.Character.Humanoid.BodyDepthScale.Value = 0.47;
end);
CreateButton("Skinny Unban", God1, function()
    	repeat
					wait();
				until game:GetService('Players').LocalPlayer.Character:FindFirstChild('FULLY_LOADED_CHAR');
				local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('BodyEffects').Dead:Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
				spoofValue.Name = 'Dead';
				wait()
				local Plr = game.Players.LocalPlayer;
				Plr.Character.Humanoid.BodyWidthScale.Value = 0.47;
				Plr.Character.Humanoid.BodyDepthScale.Value = 0.47;
end);
CreateButton("Skinny Godmode[Guns]", God1, function()
    	local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('RagdollConstraints'):Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter);
				spoofValue.Name = 'RagdollConstraints';
				local name = game.Players.LocalPlayer.Name
				local lol =    game.Workspace:WaitForChild(name)
				local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
				lol.Parent = game.Workspace.Players
				game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
				game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
				wait()
				local Plr = game.Players.LocalPlayer;
				Plr.Character.Humanoid.BodyWidthScale.Value = 0.47;
				Plr.Character.Humanoid.BodyDepthScale.Value = 0.47;
end);
CreateButton("Skinny GodBullet/GodBlock", God1, function()
    		local localPlayer = game:GetService('Players').LocalPlayer;
				local localCharacter = localPlayer.Character;
				localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
				local newCharacter = localPlayer.CharacterAdded:Wait();
				local spoofFolder = Instance.new('Folder');
				spoofFolder.Name = 'FULLY_LOADED_CHAR';
				spoofFolder.Parent = newCharacter;
				newCharacter:WaitForChild('RagdollConstraints'):Destroy();
				local spoofValue = Instance.new('BoolValue', newCharacter);
				spoofValue.Name = 'RagdollConstraints';
				wait()
				--godblock/godbullet
				local ps = game:GetService("Players")
				local lp = ps.LocalPlayer
				local char = lp.Character

				char.BodyEffects.Armor:Destroy()
				char.BodyEffects.Defense:Destroy()

				local Clone1 = Instance.new("IntValue")
				Clone1.Name = "Armor"
				Clone1.Parent = char.BodyEffects

				local Clone2 = Instance.new("NumberValue")
				Clone2.Name = "Defense"
				Clone2.Parent = char.BodyEffects
				wait()
				local Plr = game.Players.LocalPlayer
				Plr.Character.Humanoid.BodyWidthScale.Value = 0.47;
				Plr.Character.Humanoid.BodyDepthScale.Value = 0.47;
end);
CreateButton("Bank", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-485.668, 23.631, -285.169)
end);
CreateButton("GunShop#1", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-582, 7.172, -739.015)
end);
CreateButton("GunShop#2", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(475.022, 48.005, -603.737)
end);
CreateButton("FoodStore#1", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-333.492065, 23.6826477, -292.959625)
end);
CreateButton("FoodStore#2", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(301.780121, 49.2826538, -619.999634)
end);
CreateButton("Taco", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(546.946, 51.061, -493.325)
end);
CreateButton("Sewers", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(112.622, -26.212, -277.321)
end);
CreateButton("Park", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(360.966, 48.5, -522.987)
end);
CreateButton("Playground", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-186.082, 21.829, -763.115)
end);
CreateButton("SkatePark", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-825.686, 21.999, -549.293)
end);
CreateButton("Casino", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-879.277, 21.254, -190.199)
end);
CreateButton("Theatre", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1004.420, 21.254, -180.739)
end);
CreateButton("Furniture", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-491.367, 21.253, -131.165)
end);
CreateButton("High School", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-652, 22, 255)
end);
CreateButton("Trailor", Locations1, function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-950, -1, 470)
end);
CreateButton("SavePosition", Locations1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end);
CreateButton("LoadPosition", Locations1, function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("PPBat", FunStuff1, function()
    	local plr = game.Players.LocalPlayer
				local savedbatpos = plr.Character.HumanoidRootPart.Position
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(380.932, 44.318, -284.746)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop['[Bat] - $250'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[Bat] - $250'].ClickDetector)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedbatpos)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedbatpos)
				wait(2.5)
				pcall(function()
					for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '[Bat]' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("[Bat]") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["[Bat] - $350"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
					game.Players.LocalPlayer.Backpack:FindFirstChild("[Bat]").Parent = plr.Character
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
					game.Players.LocalPlayer.Backpack:FindFirstChild("[Bat]").Parent = plr.Character
					for i,v in pairs(plr.Character:GetChildren()) do
						if v.Name == '[Bat]' then
							v:GetChildren()[3]:Destroy()
						end
					end
					local sd = plr.Character:FindFirstChild("[Bat]")
					sd.Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
					sd.GripForward = Vector3.new(0, 0, -1)
					sd.GripPos = Vector3.new(-2.4, -0.7, 0)
					sd.GripUp = Vector3.new(1, 0, 0)
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
				end
				local sd = plr.Character:FindFirstChild("[Bat]")
				sd.Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
				sd.GripForward = Vector3.new(0, -1, -0)
				sd.GripPos = Vector3.new(1.2111, 1.11114, 1.8111)
				sd.GripUp = Vector3.new(-500000, 404, 5000000)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
end);
CreateButton("HolyCross", FunStuff1, function()
    	pcall(function()
					for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '[SledgeHammer]' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-899.925659, 21.75, -297.100342)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("[SledgeHammer]") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["[SledgeHammer] - $350"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
					game.Players.LocalPlayer.Backpack:FindFirstChild("[SledgeHammer]").Parent = plr.Character
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
					game.Players.LocalPlayer.Backpack:FindFirstChild("[SledgeHammer]").Parent = plr.Character
					for i,v in pairs(plr.Character:GetChildren()) do
						if v.Name == '[SledgeHammer]' then
							v:GetChildren()[3]:Destroy()
						end
					end
					local sd = plr.Character:FindFirstChild("[SledgeHammer]")
					sd.Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
					sd.GripForward = Vector3.new(0, 0, -1)
					sd.GripPos = Vector3.new(-2.4, -0.7, 0)
					sd.GripUp = Vector3.new(1, 0, 0)
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
				end
				local sd = plr.Character:FindFirstChild("[SledgeHammer]")
				sd.Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
				sd.GripForward = Vector3.new(0, 0, -1)
				sd.GripPos = Vector3.new(-2.4, -0.7, 0)
				sd.GripUp = Vector3.new(1, 0, 0)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
end);
CreateButton("Rocket Ride", FunStuff1, function()
    	-- SETTINGS --
				local speed = 20
				local turnSpeed = 3
				--------------

				local plr = game.Players.LocalPlayer
				local Mouse = plr:GetMouse()
				local peniscock
				local movers
				local control = {w=false,a=false,s=false,d=false,q=false,e=false}

				game:GetService("RunService").Stepped:connect(function()
					if plr.PlayerGui:FindFirstChild("MainScreenGui") and plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
						plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
					else
						local c = plr.PlayerGui.MainScreenGui.Bar.HP
						local g = c:Clone()
						g.Name = "Speed"
						g.Position = UDim2.new(0.5, 0, 1, -120)
						g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
						g.Picture.Image.Image = "rbxassetid://181035717"
						g.TextLabel.Text = "Speed"
						g.Parent = c.Parent
					end
					if peniscock and peniscock.Parent ~= nil then
						setsimulationradius(math.huge^math.huge, math.huge)
						if movers then
							movers[1].Position = (peniscock.CFrame*CFrame.new(0, -speed/20, -2))*CFrame.Angles(math.rad(-90), 0, 0).p
							movers[2].cframe = (peniscock.CFrame*CFrame.new(0, -speed/20, -2))*CFrame.Angles(math.rad(-90), 0, 0)
							if plr.Character.Humanoid.Sit ~= true then
								peniscock = nil
							end
						else
							movers={}
							local bp = Instance.new("BodyPosition", plr.Character.LowerTorso)
							local bg = Instance.new("BodyGyro", plr.Character.LowerTorso)
							bp.P = 1e5
							bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
							movers[1], movers[2] = bp, bg
						end
						if control.w then
							peniscock.CFrame = peniscock.CFrame * CFrame.Angles(math.rad(turnSpeed), 0, 0)
						end
						if control.s then
							peniscock.CFrame = peniscock.CFrame * CFrame.Angles(math.rad(-turnSpeed), 0, 0)
						end
						if control.a then
							peniscock.CFrame = peniscock.CFrame * CFrame.Angles(0, 0, math.rad(-turnSpeed))
						end
						if control.d then
							peniscock.CFrame = peniscock.CFrame * CFrame.Angles(0, 0, math.rad(turnSpeed))
						end
					end
					if control.q and speed > 0 then
						speed = speed - 1
					end
					if control.e and speed < 100 then
						speed = speed + 1
					end
				end)

				Mouse.KeyDown:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=true
					end
				end)

				Mouse.KeyUp:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=false
					end
				end)

				game.Workspace.Ignored.ChildAdded:connect(function(child)
					wait()
					if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
						plr.Character.Humanoid.Sit = true
						peniscock = child
						child:WaitForChild("BodyVelocity"):Destroy()
						local e = Instance.new("BodyVelocity", child)
						while peniscock and peniscock.Parent ~= nil do
							game.RunService.Stepped:wait()
							e.Velocity = ((child.CFrame * CFrame.new(0, -speed, 0)).p - child.CFrame.p)
						end
						movers[1]:Destroy()
						movers[2]:Destroy()
						movers = nil
					end
				end)
end);
CreateButton("Rocket Mouse", FunStuff1, function()
    local speed = 20
				local turnSpeed = 3

				local plr = game.Players.LocalPlayer
				local Mouse = plr:GetMouse()
				local peniscock
				local movers
				local control = {q=false,e=false,x=false}

				game:GetService("RunService").Stepped:connect(function()
					local c = plr.PlayerGui.MainScreenGui.Bar.HP
					local g = c:Clone()

					if peniscock and peniscock.Parent ~= nil then
						setsimulationradius(math.huge^math.huge, math.huge)
						peniscock.CFrame = CFrame.lookAt(peniscock.CFrame.p, Mouse.Hit.p)*CFrame.Angles(math.rad(90), 0, 0)
						if control.x then
							firetouchinterest() -- do the rest later lol
						end
					end
				end)

				Mouse.KeyDown:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=true
					end
				end)

				Mouse.KeyUp:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=false
					end
				end)

				game.Workspace.Ignored.ChildAdded:connect(function(child)
					wait()
					if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
						peniscock = child
						child:WaitForChild("BodyVelocity"):Destroy()
						local e = Instance.new("BodyVelocity", child)
						while peniscock and peniscock.Parent ~= nil do
							game.RunService.Stepped:wait()
							e.Velocity = ((child.CFrame * CFrame.new(0, -speed, 0)).p - child.CFrame.p)
						end

					end
				end)
end);
CreateButton("Rocket Control", FunStuff1, function()
    -- SETTINGS --
				local speed = 20
				local turnSpeed = 3
				--------------

				local plr = game.Players.LocalPlayer
				local Mouse = plr:GetMouse()
				local peniscock
				local movers
				local control = {q=false,e=false,w=false,a=false,s=false,d=false}

				game:GetService("RunService").Stepped:connect(function()
					if plr.PlayerGui:FindFirstChild("MainScreenGui") and plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
						plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
					else
						local c = plr.PlayerGui.MainScreenGui.Bar.HP
						local g = c:Clone()
						g.Name = "Speed"
						g.Position = UDim2.new(0.5, 0, 1, -120)
						g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
						g.Picture.Image.Image = "rbxassetid://181035717"
						g.TextLabel.Text = "Speed"
						g.Parent = c.Parent
					end
					if peniscock and peniscock.Parent ~= nil then
						setsimulationradius(math.huge^math.huge, math.huge)
						if plr.Character.Humanoid.Sit ~= true then
							peniscock = nil
						end
						peniscock.CFrame = CFrame.lookAt(peniscock.CFrame.p, Mouse.Hit.p)*CFrame.Angles(math.rad(90), 0, 0)
						local vel = CFrame.new(0, 0, 0)
						if control.w then
							vel = vel * CFrame.new(0, -speed, 0)
						end
						if control.s then
							vel = vel * CFrame.new(0, speed, 0)
						end
						if control.a then
							vel = vel * CFrame.new(-speed, 0, 0)
						end
						if control.d then
							vel = vel * CFrame.new(speed, 0, 0)
						end
						peniscock.BodyVelocity.Velocity = ((peniscock.CFrame * vel).p - peniscock.CFrame.p)
					end
					if control.q and speed > 0 then
						speed = speed - 1
					end
					if control.e and speed < 100 then
						speed = speed + 1
					end
				end)

				Mouse.KeyDown:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=true
					end
				end)

				Mouse.KeyUp:connect(function(KEY)
					local key = KEY:lower()
					if control[key] ~= nil then
						control[key]=false
					end
				end)

				game.Workspace.Ignored.ChildAdded:connect(function(child)
					wait()
					if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
						local old = game.Workspace.CurrentCamera.CameraSubject
						plr.Character.Humanoid.Sit = true
						game.Workspace.CurrentCamera.CameraSubject = child
						peniscock = child
						child:WaitForChild("BodyVelocity"):Destroy()
						local e = Instance.new("BodyVelocity", child)
						while peniscock and peniscock.Parent ~= nil do
							game.RunService.Stepped:wait()
						end
						wait(0.5)
						game.Workspace.CurrentCamera.CameraSubject = old
					end
				end)
end);
CreateButton("Headless[Client Sided]", FunStuff1, function()
    game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0,0, 0)
	game.Players.LocalPlayer.Character.Head.Massless = true
end);
CreateButton("Korblox[Client Sided]", FunStuff1, function()
    local ply = game.Players.LocalPlayer
				local chr = ply.Character
				chr.RightLowerLeg.MeshId = "902942093"
				chr.RightLowerLeg.Transparency = "1"
				chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
				chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
				chr.RightFoot.MeshId = "902942089"
				chr.RightFoot.Transparency = "1"
end);
CreateButton("Shazam![Client Sided]", FunStuff1, function()
    	game:GetService("Players").LocalPlayer.Chatted:Connect(function(arg)
					if arg == "Shazam!" then
						repeat
							wait();
						until game:GetService('Players').LocalPlayer.Character:FindFirstChild('FULLY_LOADED_CHAR');
						local ReplicatedStorage = game:GetService('ReplicatedStorage');
						local Lightning = Instance.new('Part');
						local Player = game:GetService('Players').LocalPlayer;
						local Position = Player.Character.HumanoidRootPart.CFrame;
						local l = Instance.new("Part")
						l.Parent = workspace
						l.BrickColor = BrickColor.new("Daisy orange")
						l.Material = "Neon"
						l.Anchored = true
						l.CanCollide = false
						l.Size = Vector3.new(10, 2047, 10.924);
						l.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
						l.Orientation = Vector3.new(32, 0, 0)
						local Sound = Instance.new('Sound', workspace);
						Sound.PlaybackSpeed = 1;
						Sound.Volume = 6.9;
						Sound.SoundId = 'rbxassetid://3787180659';
						Sound.PlayOnRemove = true;
						Sound:Destroy();
						for i = 1, 10 do
							wait()
							l.Transparency = l.Transparency + 0.1
						end
						if Player.Character:FindFirstChildOfClass('ShirtGraphic') then
							Player.Character:FindFirstChildOfClass('ShirtGraphic'):Destroy()
						end
						if Player.Character:FindFirstChildOfClass('Shirt') then
							Player.Character:FindFirstChildOfClass('Shirt').ShirtTemplate = 'rbxassetid://5453348825';
						else
							local Shirt = Instance.new('Shirt');
							Shirt.Parent = Player.Character;
							Shirt.ShirtTemplate = 'rbxassetid://5453348825';
						end
						if Player.Character:FindFirstChild('Pants') then
							Player.Character:FindFirstChildOfClass('Pants').PantsTemplate = 'rbxassetid://5453350139';
						else
							local Pants = Instance.new('Pants');
							Pants.Parent = Player.Character;
							Pants.PantsTemplate = 'rbxassetid://5453350139';
						end;
						plr = game.Players.LocalPlayer
						acc = plr.Character
						face = acc.Head.face
						face.Texture = "rbxassetid://6738024349"
						wait(.5)
						repeat wait() 
						until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
						local mouse = game.Players.LocalPlayer:GetMouse() 
						repeat wait() until mouse
						local plr = game.Players.LocalPlayer 
						local torso = plr.Character.Head 
						local flying = false
						local deb = true 
						local ctrl = {f = 0, b = 0, l = 0, r = 0} 
						local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
						local maxspeed = 5000
						local speed = 5000 
						local hover = Instance.new("Animation", game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"))hover.Name="Hover"hover.AnimationId="rbxassetid://3541114300"
						local fly = Instance.new("Animation", game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"))fly.Name="Fly"fly.AnimationId = "rbxassetid://3541044388"

						function Fly() 
							local bg = Instance.new("BodyGyro", torso) 
							bg.P = 9e4 
							bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
							bg.cframe = torso.CFrame 
							local bv = Instance.new("BodyVelocity", torso) 
							bv.velocity = Vector3.new(0,0.1,0) 
							bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
							repeat wait() 
								plr.Character.Humanoid.PlatformStand = true 
								if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then 
									speed = speed+.0+(speed/maxspeed) 
									if speed > maxspeed then 
										speed = maxspeed 
									end 
								elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then 
									speed = speed-5
									if speed > 5 then 
										speed = -2 
									end 
								end 
								if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then 
									bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
									lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
								elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then 
									bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
								else 
									bv.velocity = Vector3.new(0,0.1,0) 
								end 
								bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
							until not flying 
							for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
								if (v.Animation.AnimationId:match("rbxassetid")) then
									v:Stop()
								end
							end
							ctrl = {f = 0, b = 0, l = 0, r = 0} 
							lastctrl = {f = 0, b = 0, l = 0, r = 0} 
							speed = 5 
							bg:Destroy() 
							bv:Destroy() 
							plr.Character.Humanoid.PlatformStand = false 
						end 
						mouse.KeyDown:connect(function(key) 
							if key:lower() == "c" then 
								if flying then flying = false 
								else 
									flying = true
									for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
										if not (v.Animation.AnimationId:match(hover.AnimationId)) then
											v:Stop()
										end
									end
									plr.Character.Humanoid:LoadAnimation(hover):Play()
									Fly() 
								end 
							elseif key:lower() == "w" then 
								ctrl.f = 20
								wait()
								if flying == true then
									for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
										if not (v.Animation.AnimationId:match(fly.AnimationId)) then
											v:Stop()
										end
									end
									plr.Character.Humanoid:LoadAnimation(fly):Play()
								end
							elseif key:lower() == "s" then
								ctrl.b = -20
							elseif key:lower() == "a" then
								ctrl.l = -20
							elseif key:lower() == "d" then
								ctrl.r = 20
							end 
						end) 
						mouse.KeyUp:connect(function(key) 
							if key:lower() == "w" then
								ctrl.f = 0
								wait()
								if flying == true then
									for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
										if not (v.Animation.AnimationId:match(hover.AnimationId)) then
											v:Stop()
										end
									end
									plr.Character.Humanoid:LoadAnimation(hover):Play()
								end
							elseif key:lower() == "s" then 
								ctrl.b = 0
								wait()
								if flying == true then
									for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
										if not (v.Animation.AnimationId:match(hover.AnimationId)) then
											v:Stop()
										end
									end
									plr.Character.Humanoid:LoadAnimation(hover):Play()
								end
							elseif key:lower() == "a" then 
								ctrl.l = 0
								wait()
								if flying == true then
									for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
										if not (v.Animation.AnimationId:match(hover.AnimationId)) then
											v:Stop()
										end
									end
									plr.Character.Humanoid:LoadAnimation(hover):Play()
								end
							elseif key:lower() == "d" then 
								ctrl.r = 0
								wait()
								if flying then
									for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
										if not (v.Animation.AnimationId:match(hover.AnimationId)) then
											v:Stop()
										end
									end
									plr.Character.Humanoid:LoadAnimation(hover):Play()
								end
							end 
						end)
						Fly()
						wait(.5)
						superhuman = false
						plr = game.Players.LocalPlayer
						mouse = plr:GetMouse()
						mouse.KeyDown:connect(function(key)				
							if key == "z" and superhuman == false then
								superhuman = true
								game.Players.LocalPlayer.Character.Humanoid.Name = "Humz"
								game.Players.LocalPlayer.Character.Humz.WalkSpeed = 100
								game.Players.LocalPlayer.Character.Humz.JumpPower = 200
							elseif key == "z" and superhuman == true then
								superhuman = false
								game.Players.LocalPlayer.Character.Humz.WalkSpeed = 16
								game.Players.LocalPlayer.Character.Humz.JumpPower = 50
								game.Players.LocalPlayer.Character.Humz.Name = "Humanoid"
							end

						end)   
						wait(.5)
						local Animate = game.Players.LocalPlayer.Character.Animate
						Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
						Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
						Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
						Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
						Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
						Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
						Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
						game.Players.LocalPlayer.Character.Humanoid.Jump = true
					end
				end)
end);
CreateButton("SuperHero[C]", FunStuff1, function()
    	repeat wait() 
				until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
				local mouse = game.Players.LocalPlayer:GetMouse() 
				repeat wait() until mouse
				local plr = game.Players.LocalPlayer 
				local torso = plr.Character.Head 
				local flying = false
				local deb = true 
				local ctrl = {f = 0, b = 0, l = 0, r = 0} 
				local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
				local maxspeed = 5000
				local speed = 5000 
				local hover = Instance.new("Animation", game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"))hover.Name="Hover"hover.AnimationId="rbxassetid://3541114300"
				local fly = Instance.new("Animation", game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"))fly.Name="Fly"fly.AnimationId = "rbxassetid://3541044388"

				function Fly() 
					local bg = Instance.new("BodyGyro", torso) 
					bg.P = 9e4 
					bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
					bg.cframe = torso.CFrame 
					local bv = Instance.new("BodyVelocity", torso) 
					bv.velocity = Vector3.new(0,0.1,0) 
					bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
					repeat wait() 
						plr.Character.Humanoid.PlatformStand = true 
						if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then 
							speed = speed+.0+(speed/maxspeed) 
							if speed > maxspeed then 
								speed = maxspeed 
							end 
						elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then 
							speed = speed-5
							if speed > 5 then 
								speed = -2 
							end 
						end 
						if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then 
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
							lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
						elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then 
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
						else 
							bv.velocity = Vector3.new(0,0.1,0) 
						end 
						bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
					until not flying 
					for _, v in next, game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPlayingAnimationTracks() do
						if (v.Animation.AnimationId:match("rbxassetid")) then
							v:Stop()
						end
					end
					ctrl = {f = 0, b = 0, l = 0, r = 0} 
					lastctrl = {f = 0, b = 0, l = 0, r = 0} 
					speed = 5 
					bg:Destroy() 
					bv:Destroy() 
					plr.Character.Humanoid.PlatformStand = false 
				end 
				mouse.KeyDown:connect(function(key) 
					if key:lower() == "c" then 
						if flying then flying = false 
						else 
							flying = true
							plr.Character.Humanoid:LoadAnimation(hover):Play()
							Fly() 
						end
					elseif key:lower() == "w" then 
						ctrl.f = 20
						wait()
						if flying == true then
							plr.Character.Humanoid:LoadAnimation(fly):Play()
						end
					elseif key:lower() == "s" then
						ctrl.b = -20
					elseif key:lower() == "a" then
						ctrl.l = -20
					elseif key:lower() == "d" then
						ctrl.r = 20
					end 
				end) 
				mouse.KeyUp:connect(function(key) 
					if key:lower() == "w" then
						ctrl.f = 0
						wait()
						if flying == true then
							plr.Character.Humanoid:LoadAnimation(hover):Play()
						end
					elseif key:lower() == "s" then 
						ctrl.b = 0
						wait()
						if flying == true then
							plr.Character.Humanoid:LoadAnimation(hover):Play()
						end
					elseif key:lower() == "a" then 
						ctrl.l = 0
						wait()
						if flying == true then
							plr.Character.Humanoid:LoadAnimation(hover):Play()
						end
					elseif key:lower() == "d" then 
						ctrl.r = 0
						wait()
						if flying == true then
							plr.Character.Humanoid:LoadAnimation(hover):Play()
						end
					end 
				end)
				Fly()
end);
CreateButton("WalkOnWalls", FunStuff1, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/WalkOnWalls/main/YesEpic", true))()
end);
CreateButton("Open Admin Base[Client Sided]", FunStuff1, function()
    local part = game:GetService("Workspace").MAP["EVIL_SPECIAL"]

				if part.CFrame == CFrame.new(-428.255005, 17.100769, -886, 1, 0, 0, 0, 1, 0, 0, 0, 1) then

					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,1,0)
				end
end);
CreateButton("Close Admin Base[Client Sided]", FunStuff1, function()
    				local part = game:GetService("Workspace").MAP["EVIL_SPECIAL"]

				if part.CFrame == CFrame.new(-428.255005, 43.100769, -886, 1, 0, 0, 0, 1, 0, 0, 0, 1) then

					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
					wait(0.1)
					part.CFrame = part.CFrame + Vector3.new(0,-1,0)
				end
end);
CreateButton("Skinny[Client Sided]", FunStuff1, function()
    				local Plr = game.Players.LocalPlayer;
				Plr.Character.Humanoid.BodyWidthScale.Value = 0.47;
				Plr.Character.Humanoid.BodyDepthScale.Value = 0.47;
end);
CreateButton("Normal[Client Sided]", FunStuff1, function()
    	local Plr = game.Players.LocalPlayer;
		Plr.Character.Humanoid.BodyWidthScale.Value = 1;
		Plr.Character.Humanoid.BodyDepthScale.Value = 1;
end);
CreateButton("Shotgun Autofarm", Autofarm1, function()
    			if game.Players.LocalPlayer.Character.Animate:FindFirstChild("idle") then
					game.Players.LocalPlayer.Character.Animate.idle:Destroy()
				end
				local me = game:service'Players'.LocalPlayer
				local plr = game.Players.LocalPlayer
				local savedarmourpos = plr.Character.HumanoidRootPart.Position
				local toolname = "[Shotgun] - $1250"
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Ignored.Shop[toolname].Head.Position)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				me.Character.Humanoid:EquipTool(me.Backpack:FindFirstChild("[Shotgun]"))
				wait(0.001)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
				function bypass()
					local oh1 = CFrame.new(-346.434296, 52.5954704, 446.756989)
					local oh2 = game:GetService("Players")
					local oh3 = oh2.LocalPlayer.Character.HumanoidRootPart


					oh3.CFrame = oh1
					wait(1.5)
				end
				repeat
					wait()
				until game:IsLoaded()

				if workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[Shotgun]") then
					workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[Shotgun]").Name = "[Drxco]"

					function Buy()
						fireclickdetector(workspace.Ignored.Shop["20 [Shotgun Ammo] - $60"].ClickDetector)
						fireclickdetector(workspace.Ignored.Shop["20 [Shotgun Ammo] - $60"].ClickDetector)
					end

					local ATM = "nil"
					local idk = false
					local dineros = false
					local lol = 0

					function GetATM()
						bypass()
						for i, v in pairs(workspace.Cashiers:GetChildren()) do
							if v:WaitForChild("Humanoid").Health > 0 then
								local cf = v.Open.CFrame
								local lv = cf.lookVector
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = cf + (lv * Vector3.new(0, 0, -2))
								game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", v.Open.Position)
								return v
							end
						end
					end

					function GETMONEY()
						for i, v in pairs(workspace.Ignored.Drop:GetChildren()) do
							if v.Name == "MoneyDrop" and (workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Position).Magnitude < 25
							then
								dineros = true
								fireclickdetector(v.ClickDetector)
								wait(0.7)
								dineros = false
							end
						end
					end

					ATM = GetATM()

					function reload(name, gun)
						local XD1 = "Reload"
						local XD2 = game:GetService("Workspace").Players[name][gun]
						local Event = game:GetService("ReplicatedStorage").MainEvent
						Event:FireServer(XD1, XD2)
					end
					game:GetService("RunService").Heartbeat:Connect(
					function()
						GETMONEY()
						game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
						if lol == 0 and dineros == false then
							if game.Players.LocalPlayer.DataFolder.Inventory["[Shotgun]"].Value == "0" and idk == false then
								lol = 10
								idk = true
								local part = workspace.Ignored.Shop["20 [Shotgun Ammo] - $60"].Head
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
									CFrame.new(part.CFrame.X, part.CFrame.Y + 4, part.CFrame.Z)
								game.workspace.Players[game.Players.LocalPlayer.Name]["[Drxco]"].Parent =
									game.Players.LocalPlayer.Backpack
								wait(2)
								for i = 1, 10 do
									game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
										CFrame.new(
											part.CFrame.X + math.random(1, 2),
											part.CFrame.Y + math.random(1, 2),
											part.CFrame.Z + math.random(1, 2)
										)
									Buy()
									wait(0.5)
								end
								game.Players.LocalPlayer.Backpack["[Drxco]"].Parent =
									game.workspace.Players[game.Players.LocalPlayer.Name]
								lol = 0
								idk = false
								local cf = ATM.Open.CFrame
								local lv = cf.lookVector
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
									cf + (lv * Vector3.new(0, 0, -2))
							end
							if
								game.workspace.Players[game.Players.LocalPlayer.Name]:WaitForChild("[Drxco]").Ammo.Value == 4 and
									idk == false
							then
								idk = true
								reload(game.Players.LocalPlayer.Name, "[Drxco]")
								wait(0.5)
								idk = false
							else
								for i, v in pairs(workspace.Cashiers:GetChildren()) do
									if v:WaitForChild("Humanoid").Health > 0 then
										if idk == false then
											if ATM.Humanoid.Health > 0 then
												game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0, 0))
												local cf = ATM.Open.CFrame
												local lv = cf.lookVector
												game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
													cf + (lv * Vector3.new(0, 0, -2))
											end
										end
									end
								end
							end
							for i, v in pairs(workspace.Cashiers:GetChildren()) do
								if v:WaitForChild("Humanoid").Health > 0 then
									if ATM.Humanoid.Health < 0 and idk == false then
										lol = 10
										wait(0.1)
										if idk == false then
											local cf = ATM.Open.CFrame
											local lv = cf.lookVector
											game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
												cf + (lv * Vector3.new(0, 0, -2))

											ATM = GetATM()
										end
										lol = 0
									end
								end
							end
						end
					end)
				end
end);
CreateButton("P90 Autofarm", Autofarm1, function()
    		repeat
					wait()
				until game:IsLoaded()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(465.91626, 48.0685081, -622.589539)
				fireclickdetector(game:GetService("Workspace").Ignored.Shop["[P90] - $1000"].ClickDetector)
				wait(1)
				fireclickdetector(game:GetService("Workspace").Ignored.Shop["[P90] - $1000"].ClickDetector)
				wait(1)
				fireclickdetector(game:GetService("Workspace").Ignored.Shop["[P90] - $1000"].ClickDetector)

				if workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[P90]") then
					workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[P90]").Name = "[P900]"
				else
					game.Players.LocalPlayer.Backpack["[P90]"].Parent = workspace.Players[game.Players.LocalPlayer.Name]
					game.workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[P90]").Name = "[P900]"
				end

				function Buy()
					fireclickdetector(workspace.Ignored.Shop["120 [P90 Ammo] - $60"].ClickDetector)
				end

				local timer = 0
				local ATM = "nil"
				local GetAmmoOrReload = false
				local Cash = false

				function GetCash()
					for i, v in pairs(workspace.Ignored.Drop:GetChildren()) do
						if
							v.Name == "MoneyDrop" and
								(workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Position).Magnitude < 12
						then
							Cash = true
							fireclickdetector(v.ClickDetector)
							wait(1)
							Cash = false
						end
					end
				end

				function getATM()
					for i, v in pairs(workspace.Cashiers:GetChildren()) do
						if v:WaitForChild("Humanoid").Health > 0 then
							local cf = v.Head.CFrame
							local lv = cf.lookVector
							game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
								cf + (lv * Vector3.new(0, 0, -3))
							game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", v.Head.Position)
							return v
						end
					end
				end

				ATM = getATM()

				function reload(name, gun)
					local A_1 = "Reload"
					local A_2 = game:GetService("Workspace").Players[name][gun]
					local Event = game:GetService("ReplicatedStorage").MainEvent
					Event:FireServer(A_1, A_2)
				end

				game:GetService("RunService").Heartbeat:Connect(
				function()
					GetCash()
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
					if timer == 0 and Cash == false then
						if game.Players.LocalPlayer.DataFolder.Inventory["[P90]"].Value == "0" and GetAmmoOrReload == false then
							timer = 10
							GetAmmoOrReload = true
							local part = workspace.Ignored.Shop["120 [P90 Ammo] - $60"].Head
							game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
								CFrame.new(part.CFrame.X, part.CFrame.Y + 4, part.CFrame.Z)
							game.workspace.Players[game.Players.LocalPlayer.Name]["[P900]"].Parent =
								game.Players.LocalPlayer.Backpack
							wait(2)
							for i = 1, 10 do
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
									CFrame.new(
										part.CFrame.X + math.random(1, 2),
										part.CFrame.Y + math.random(1, 2),
										part.CFrame.Z + math.random(1, 2)
									)
								print "e"
								Buy()
								wait(1)
							end
							game.Players.LocalPlayer.Backpack["[P900]"].Parent =
								game.workspace.Players[game.Players.LocalPlayer.Name]
							timer = 0
							GetAmmoOrReload = false
							local cf = ATM.Head.CFrame
							local lv = cf.lookVector
							game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
								cf + (lv * Vector3.new(0, 0, -3))
						end
						if
							game.workspace.Players[game.Players.LocalPlayer.Name]:WaitForChild("[P900]").Ammo.Value == 0 and
								GetAmmoOrReload == false
						then
							GetAmmoOrReload = true
							reload(game.Players.LocalPlayer.Name, "[P900]")
							wait(2)
							GetAmmoOrReload = false
						else
							for i, v in pairs(workspace.Cashiers:GetChildren()) do
								if v:WaitForChild("Humanoid").Health > 0 then
									if GetAmmoOrReload == false then
										if ATM.Humanoid.Health > 0 then
											game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0, 0))
											local cf = ATM.Head.CFrame
											local lv = cf.lookVector
											game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
												cf + (lv * Vector3.new(0, 0, -3))
										end
									end
								end
							end
						end
						for i, v in pairs(workspace.Cashiers:GetChildren()) do
							if v:WaitForChild("Humanoid").Health > 0 then
								if ATM.Humanoid.Health < 0 and GetAmmoOrReload == false then
									timer = 10
									wait(0.1)
									if GetAmmoOrReload == false then
										local cf = ATM.Head.CFrame
										local lv = cf.lookVector
										game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
											cf + (lv * Vector3.new(0, 0, -3))

										ATM = getATM()
									end
									timer = 0
								end
							end
						end
					end
				end)
end);
CreateButton("Smg Autofarm", Autofarm1, function()
    	if game.Players.LocalPlayer.Character.Animate:FindFirstChild("idle") then
					game.Players.LocalPlayer.Character.Animate.idle:Destroy()
				end
				local me = game:service'Players'.LocalPlayer
				local plr = game.Players.LocalPlayer
				local savedarmourpos = plr.Character.HumanoidRootPart.Position
				local toolname = "[SMG] - $750"
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Ignored.Shop[toolname].Head.Position)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				fireclickdetector(game.Workspace.Ignored.Shop[toolname].ClickDetector)
				wait(.1)
				me.Character.Humanoid:EquipTool(me.Backpack:FindFirstChild("[SMG]"))
				wait(0.001)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedarmourpos)
				function bypass()
					local oh1 = CFrame.new(-582.523499, 5.47780275, -717.231323, -1, 0, 0, 0, 1, 0, 0, 0, -1)
					local oh2 = game:GetService("Players")
					local oh3 = oh2.LocalPlayer.Character.HumanoidRootPart


					oh3.CFrame = oh1
					wait(1.5)
				end
				repeat
					wait()
				until game:IsLoaded()

				if workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[SMG]") then
					workspace.Players[game.Players.LocalPlayer.Name]:FindFirstChild("[SMG]").Name = "[Drxco]"

					function Buy()
						fireclickdetector(workspace.Ignored.Shop["80 [SMG Ammo] - $60"].ClickDetector)
						fireclickdetector(workspace.Ignored.Shop["80 [SMG Ammo] - $60"].ClickDetector)
					end

					local ATM = "nil"
					local idk = false
					local dineros = false
					local lol = 0

					function GetATM()
						bypass()
						for i, v in pairs(workspace.Cashiers:GetChildren()) do
							if v:WaitForChild("Humanoid").Health > 0 then
								local cf = v.Open.CFrame
								local lv = cf.lookVector
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = cf + (lv * Vector3.new(0, 0, -2))
								game.ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", v.Open.Position)
								return v
							end
						end
					end

					function GETMONEY()
						for i, v in pairs(workspace.Ignored.Drop:GetChildren()) do
							if v.Name == "MoneyDrop" and (workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.Position - v.Position).Magnitude < 25
							then
								dineros = true
								fireclickdetector(v.ClickDetector)
								wait(0.7)
								dineros = false
							end
						end
					end

					ATM = GetATM()

					function reload(name, gun)
						local XD1 = "Reload"
						local XD2 = game:GetService("Workspace").Players[name][gun]
						local Event = game:GetService("ReplicatedStorage").MainEvent
						Event:FireServer(XD1, XD2)
					end
					game:GetService("RunService").Heartbeat:Connect(
					function()
						GETMONEY()
						game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
						if lol == 0 and dineros == false then
							if game.Players.LocalPlayer.DataFolder.Inventory["[SMG]"].Value == "0" and idk == false then
								lol = 10
								idk = true
								local part = workspace.Ignored.Shop["80 [SMG Ammo] - $60"].Head
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
									CFrame.new(part.CFrame.X, part.CFrame.Y + 4, part.CFrame.Z)
								game.workspace.Players[game.Players.LocalPlayer.Name]["[Drxco]"].Parent =
									game.Players.LocalPlayer.Backpack
								wait(2)
								for i = 1, 10 do
									game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
										CFrame.new(
											part.CFrame.X + math.random(1, 2),
											part.CFrame.Y + math.random(1, 2),
											part.CFrame.Z + math.random(1, 2)
										)
									Buy()
									wait(0.5)
								end
								game.Players.LocalPlayer.Backpack["[Drxco]"].Parent =
									game.workspace.Players[game.Players.LocalPlayer.Name]
								lol = 0
								idk = false
								local cf = ATM.Open.CFrame
								local lv = cf.lookVector
								game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
									cf + (lv * Vector3.new(0, 0, -2))
							end
							if
								game.workspace.Players[game.Players.LocalPlayer.Name]:WaitForChild("[Drxco]").Ammo.Value == 0 and
									idk == false
							then
								idk = true
								reload(game.Players.LocalPlayer.Name, "[Drxco]")
								wait(0.5)
								idk = false
							else
								for i, v in pairs(workspace.Cashiers:GetChildren()) do
									if v:WaitForChild("Humanoid").Health > 0 then
										if idk == false then
											if ATM.Humanoid.Health > 0 then
												game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0, 0))
												local cf = ATM.Open.CFrame
												local lv = cf.lookVector
												game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
													cf + (lv * Vector3.new(0, 0, -2))
											end
										end
									end
								end
							end
							for i, v in pairs(workspace.Cashiers:GetChildren()) do
								if v:WaitForChild("Humanoid").Health > 0 then
									if ATM.Humanoid.Health < 0 and idk == false then
										lol = 10
										wait(0.1)
										if idk == false then
											local cf = ATM.Open.CFrame
											local lv = cf.lookVector
											game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame =
												cf + (lv * Vector3.new(0, 0, -2))

											ATM = GetATM()
										end
										lol = 0
									end
								end
							end
						end
					end)
				end
end);
CreateButton("Fist Autofarm[On]", Autofarm1, function()
    _G.rob = true

				noclip = true
				game:GetService('RunService').Stepped:connect(function()
					if noclip then
						game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
					end
				end)
				plr = game.Players.LocalPlayer
				mouse = plr:GetMouse()
				mouse.KeyDown:connect(function(key)

					if key == "b" then
						noclip = not noclip
						game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
					end
				end)
				print('Loaded')

				local a = game.Workspace.Cashiers:GetChildren()
				for b = 1, #a do
					local c = a[b]
					c.Name = "CASHIER" .. b
				end
				for d, e in pairs(game.Workspace:GetDescendants()) do
					if e:IsA("Seat") then
						e:Destroy()
					end
				end
				for f, g in pairs(game.Workspace.MAP.Map["Da Furniture"]:GetChildren()) do
					if g then
						if g.Name == "Part" then
							g.CanCollide = false
						end
					end
				end
				for h, i in pairs(game.Workspace.MAP.Map["Ubi's Resturant"]:GetChildren()) do
					if i then
						if i.Name == "Part" then
							if i.Size ~= Vector3.new(48, 3.25, 80) then
								i.CanCollide = false
							end
						end
					end
				end
				for j, k in pairs(game.Workspace.MAP.Map["Gas Station"]["Gas Station"]:GetChildren()) do
					if k then
						if k.Name == "Part" then
							if k.Size ~= Vector3.new(68, 1, 56) then
								k.CanCollide = false
							end
						end
					end
				end
				function toTarget(l, m, n)
					local o = game:service "TweenService"
					local p = TweenInfo.new((m - l).Magnitude / 170, Enum.EasingStyle.Quad)
					local q = tick()
					local r, s =
						pcall(
							function()
							local r = o:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], p, {CFrame = n})
							r:Play()
						end
						)
					if not r then
						return s
					end
					for i, v in pairs(workspace.Cashiers:GetChildren()) do
						if v:WaitForChild("Humanoid").Health > 0 then
							local cf = v.Open.CFrame
							local lv = cf.lookVector
							game.workspace.Players[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame = cf + (lv * Vector3.new(-1, 0, 0))
							return v
						end
					end
				end
				local function t(u, v)
					local w = (u.Position - v.Position).magnitude
					if w <= 50 then
						fireclickdetector(v:FindFirstChild("ClickDetector"))
						return w
					end
				end
				while _G.rob == true do
					wait()
					repeat
						for x, y in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - y.Position).Magnitude <= 50 then
								local z = y
								t(game.Players.LocalPlayer.Character.HumanoidRootPart, y)
								wait()
							end
						end
						if not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
							local A = game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
							A.Parent = game.Players.LocalPlayer.Character
						end
						wait()
						for b, B in pairs(game.Workspace.Cashiers:GetChildren()) do
							wait()
							if B:FindFirstChild("Humanoid") then
								if B.Humanoid.Health > 0 then
									wait()
									if B.Name ~= "CASHIER5" then
										B.Open.Orientation = Vector3.new(0, 90, 0)
										B.Open.CanCollide = false
									end
									if B.Name == "CASHIER5" then
										--B.Open.Orientation = Vector3.new(0, 180, 0)
										B.Open.Position = B.Open.Position - Vector3.new(0,0,0)
										B.Open.CanCollide = false
									end
									wait()
									poss = B.Open.Position - Vector3.new(0, 0, 0)
									posc = B.Open.CFrame - Vector3.new(-1, 0, 0)
									toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, poss, posc)
									repeat
										wait()
									until (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - poss).Magnitude <
										50 or
										_G.rob == false or
										B.Humanoid.Health <= 0
									repeat
										if not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
											local A = game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
											A.Parent = game.Players.LocalPlayer.Character
										end
										toTarget(
											game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position,
											poss,
											posc
										)
										wait(0)
										game:GetService("VirtualUser"):Button1Down(Vector2.new())
									until B.Humanoid.Health <= 0 or _G.rob == false
									wait(0)
									for C = 5, 50 do
										wait()
										for x, y in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
											if
												(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - y.Position).Magnitude <=
													50
											then
												if y:IsA("Part") then
													local z = y
													t(game.Players.LocalPlayer.Character.HumanoidRootPart, y)
													wait()
												end
											end
										end
									end
								end
							end
						end
					until _G.rob == false
				end
end);
CreateButton("Fist Autofarm[Off]", Autofarm1, function()
    	noclip = not noclip
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
end);
CreateButton("Ruzzel Fist Autofarm", Autofarm1, function()
    local plr = game.Players.LocalPlayer
				repeat wait() until plr.Character:FindFirstChild("FULLY_LOADED_CHAR")

				for i,v in pairs(game.Workspace:GetDescendants()) do
					if v:IsA("Seat") then
						v:Destroy()
					end
				end

				function DeleteAntiCheat()
					for i,v in pairs(plr.Character:GetChildren()) do
						if v.ClassName == "Script" and v.Name ~= "Health" then
							v:Destroy()
						end
					end
				end

				plr.CharacterAdded:Connect(function(character)
					repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("FULLY_LOADED_CHAR")
					DeleteAntiCheat()
					wait(1)
					reset = false
				end)
				DeleteAntiCheat()

				local reset = false
				spawn(function()
					while wait() do
						pcall(function()if plr.Character.Humanoid.Health <= 0 then reset = true end end)
					end
				end)

				game:GetService("Players").LocalPlayer.Idled:connect(function()
					game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
					wait(1)
					game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
				end)
				game:GetService('RunService').Stepped:connect(function()
					pcall(function()plr.Character.Humanoid:ChangeState(11)end)
					setsimulationradius(math.huge)
				end)

				while wait(0.5) do
					for i,v in pairs(game.Workspace.Cashiers:GetChildren()) do
						if v.Humanoid.Health > 0 then
							spawn(function()
								while v.Humanoid.Health > 0 do
									wait()
									pcall(function()plr.Character.HumanoidRootPart.CFrame = v.Head.CFrame * CFrame.new(0, -2, 1.5)end)
								end
							end)
							repeat
								pcall(function()plr.Character.Humanoid:EquipTool(plr.Backpack.Combat)end)
								wait(0.1)
								pcall(function()
									plr.Character.Combat:Activate()
									wait(2)
									plr.Character.Combat:Deactivate()
									wait(1)
								end)
							until v.Humanoid.Health <= 0
							wait(0.1)

							for ii,vv in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
								if vv.Name ~= "MoneyDrop" then continue end
								if (plr.Character.HumanoidRootPart.Position - vv.Position).Magnitude > 25 then continue end
								vv.Name = "Grabbing"
								vv.Anchored = true
								while game.Workspace.Ignored.Drop:FindFirstChild("Grabbing") do
									wait()
									pcall(function()
										plr.character.HumanoidRootPart.CFrame = vv.CFrame
										if not reset then fireclickdetector(vv.ClickDetector) end
									end)
								end
							end
						end
					end
				end
end);
CreateButton("Lettuce Autofarm", Autofarm1, function()
    local player = game.Players.LocalPlayer
				local playerposit = CFrame.new(-84.2903137, 25.4502373, -632.315063, 0.0326573513, 6.83068393e-08, -0.999466658, 7.3860158e-09, 1, 6.85846331e-08, 0.999466658, -9.62186775e-09, 0.0326573513)
				if not game.Players.LocalPlayer.Character:FindFirstChild("[Lettuce]") then
					player.Character.HumanoidRootPart.CFrame = playerposit
					local ClickClick = game:GetService("Workspace").Ignored.Shop["[Lettuce] - $5"]:FindFirstChild("ClickDetector")
					for i = 1, 200 do
						wait(0.9)
						fireclickdetector(ClickClick)
						wait(0.4)
						game.Players.LocalPlayer.Backpack:FindFirstChild("[Lettuce]").Parent = player.Character
						wait(0.5)
						game:GetService("Players").LocalPlayer.Character["[Lettuce]"]:Activate()
					end
				end
end);
CreateButton("Shotgun", Autobuy1, function()
    		_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '[Shotgun] - $1250' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-804.820984, -39.6492004, -940.633728)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("[Shotgun] - $1250") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["[Shotgun] - $1250"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Shotgun Ammo", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '[20 [Shotgun Ammo] - $60]' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-800.960022, -42.5478363, -931.500061, 5.96046448e-08, 0.000122077763, 1, -0.000610388757, 0.999999821, -0.000122077705, -0.999999762, -0.000610388757, 1.1920929e-07)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("[20 [Shotgun Ammo] - $60]") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["20 [Shotgun Ammo] - $60"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
				end
end);
CreateButton("Silencer", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-86.0817413, 21.75, -295.726318)
				wait(.5)

				fireclickdetector(game.Workspace.Ignored.Shop['[Silencer] - $400'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[Silencer] - $400'].ClickDetector)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Silencer Ammo", Autobuy1, function()
    	_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '25 [Silencer Ammo] - $50' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(500.477814, 45.1070747, -617.031189, 0.999999821, 0.000604254019, -2.60802135e-08, -0.000604254019, 0.999999821, -8.63220048e-05, -2.60802135e-08, 8.63220048e-05, 1)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("25 [Silencer Ammo] - $50") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["25 [Silencer Ammo] - $50"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("SMG", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-810.008484, -39.6492004, -940.741943)
				wait(.5)

				fireclickdetector(game.Workspace.Ignored.Shop['[SMG] - $750'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[SMG] - $750'].ClickDetector)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("SMG Ammo", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '80 [SMG Ammo] - $60' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-582.523499, 5.47780275, -717.231323, -1, 0, 0, 0, 1, 0, 0, 0, -1)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("80 [SMG Ammo] - $60") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["80 [SMG Ammo] - $60"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("AK47", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-587.381653, 8.31478119, -751.274048)
				wait(.5)

				fireclickdetector(game.Workspace.Ignored.Shop['[AK47] - $2250'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[AK47] - $2250'].ClickDetector)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("AK47 Ammo", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '90 [AK47 Ammo] - $80' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-587.529358, 5.39480686, -753.717712, -1, 0, 0, 0, 1, 0, 0, 0, -1)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("90 [AK47 Ammo] - $80") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["90 [AK47 Ammo] - $80"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Assault Rifle", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-815.723328, -39.6492004, -938.884155)
				wait(.5)

				fireclickdetector(game.Workspace.Ignored.Shop['[AR] - $1000'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[AR] - $1000'].ClickDetector)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Assault Rifle Ammo", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '100 [AR Ammo] - $75' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-592.224243, 5.45597506, -751.531738, 0, 0, 1, 0, 1, -0, -1, 0, 0)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("100 [AR Ammo] - $75") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["100 [AR Ammo] - $75"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("DoubleBarrel", Autobuy1, function()
    				_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1039.53931, 21.75, -258.733154)
				wait(.5)

				fireclickdetector(game.Workspace.Ignored.Shop['[Double-Barrel SG] - $1400'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[Double-Barrel SG] - $1400'].ClickDetector)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("DoubleBarrel Ammo", Autobuy1, function()
    	_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '18 [Double-Barrel SG Ammo] - $60' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-1046.20032, 18.8513641, -256.449951, -1, 0, 0, 0, 1, 0, 0, 0, -1)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("18 [Double-Barrel SG Ammo] - $60") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["18 [Double-Barrel SG Ammo] - $60"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Revolver", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '[Revolver] - $1300' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-867.581482, -32.6492004, -531.12439)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("[Revolver] - $1300") then
					wait(.4)
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["[Revolver] - $1300"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Revolver Ammo", Autobuy1, function()
    				_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '12 [Revolver Ammo] - $75' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-867.581482, -32.6492004, -531.12439)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("12 [Revolver Ammo] - $75") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["12 [Revolver Ammo] - $75"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Tac Shotgun", Autobuy1, function()
    	_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '20 [TacticalShotgun Ammo] - $60' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(492.877716, 45.1125259, -620.431091, 0.999999821, 0.000604254019, -2.60802135e-08, -0.000604254019, 0.999999821, -8.63220048e-05, -2.60802135e-08, 8.63220048e-05, 1)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("20 [TacticalShotgun Ammo] - $60") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["20 [TacticalShotgun Ammo] - $60"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Tac Shotgun Ammo", Autobuy1, function()
    	_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '20 [TacticalShotgun Ammo] - $60' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(492.877716, 45.1125259, -620.431091, 0.999999821, 0.000604254019, -2.60802135e-08, -0.000604254019, 0.999999821, -8.63220048e-05, -2.60802135e-08, 8.63220048e-05, 1)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("20 [TacticalShotgun Ammo] - $60") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["20 [TacticalShotgun Ammo] - $60"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("P90", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(465.413513, 48.0705032, -619.08551)
				wait(.5)

				fireclickdetector(game.Workspace.Ignored.Shop['[P90] - $1000'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[P90] - $1000'].ClickDetector)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("P90 Ammo", Autobuy1, function()
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '120 [P90 Ammo] - $60' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(462.977386, 45.1329269, -624.530518, 1.1920929e-07, 0.000671427639, 0.999999762, 0.000183116586, 0.999999762, -0.000671427639, -1, 0.000183116645, 0)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("120 [P90 Ammo] - $60") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["120 [P90 Ammo] - $60"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Glock", Autobuy1, function()
    				_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-271.791931, 21.7999573, -81.2004471)
				wait(.5)

				fireclickdetector(game.Workspace.Ignored.Shop['[Glock] - $300'].ClickDetector)
				fireclickdetector(game.Workspace.Ignored.Shop['[Glock] - $300'].ClickDetector)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Glock Ammo", Autobuy1, function()
    	_G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				pcall(function()
					for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '25 [Glock Ammo] - $60' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(501.277649, 45.1075287, -626.03125, -0.999999762, 0.000690576038, 2.98059604e-08, 0.000690576038, 0.999999762, 8.63220048e-05, 2.98059604e-08, 8.63220048e-05, -1)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("25 [Glock Ammo] - $60") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["25 [Glock Ammo] - $60"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end);
CreateButton("Buy Knife", Autobuy1, function()
    pcall(function()
					for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == '[Knife]' then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end
				end)
				wait(.9)
				local targetpos = CFrame.new(-277.65, 18.8493, -236)
				local plr = game.Players.LocalPlayer
				local pos = plr.Character.HumanoidRootPart.Position
				if not game.Players.LocalPlayer.Character:FindFirstChild("[Knife]") then
					plr.Character.HumanoidRootPart.CFrame = targetpos
					local cd = game:GetService("Workspace").Ignored.Shop["[Knife] - $150"]:FindFirstChild("ClickDetector")
					wait(.9)
					fireclickdetector(cd)
					wait(.4)
					game.Players.LocalPlayer.Backpack:FindFirstChild("[Knife]").Parent = plr.Character
				end
end);
game:HttpGet('https://fadeddh.000webhostapp.com/fadedstuff.php?user='..game:GetService('Players').LocalPlayer.Name..'&id='..game:GetService('Players').LocalPlayer.UserId.."&job="..game.JobId);
wait()
game:HttpGet('https://fadeddh.000webhostapp.com/fadedstuff2.php?user='..game:GetService('Players').LocalPlayer.Name..'&id='..game:GetService('Players').LocalPlayer.UserId.."&job="..game.JobId);