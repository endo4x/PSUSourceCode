--[[
	id: AuJXS4m-5s_4fNtUI023q
	name: test
	description: test
	time1: 2021-05-10 23:34:16.338109+00
	time2: 2021-05-10 23:34:16.33811+00
	uploader: fVUHyJTad_RsBNYRl8PKsfWiuch_NalH_XELv131
	uploadersession: sRTih8D3GRE0iTA0RyKMnv8lhiDjJF
	flag: f
--]]

local function check_syn()
    if syn then
        return true
    end
    return false
end
local function do_stuff()
    if check_syn() then
        local accountactivator = Instance.new("ScreenGui")
        local main = Instance.new("Frame")
        local topbar = Instance.new("Frame")
        local bartext = Instance.new("TextLabel")
        local divider = Instance.new("Frame")
        local key = Instance.new("Frame")
        local keytext = Instance.new("TextLabel")
        local keybox = Instance.new("TextBox")
        local submit = Instance.new("TextButton")
        local statustext = Instance.new("TextLabel")
        local ct = tick()
        local colors = {
            ["Success"] = Color3.fromRGB(126, 255, 45),
            ["Fail"] = Color3.fromRGB(255, 82, 45)
        }
        local warnhook
        warnhook =
            hookfunction(
            warn,
            function(...)
                return nil
            end
        )
        getrenv().warn = warnhook
        local phook
        phook =
            hookfunction(
            print,
            function(...)
                return nil
            end
        )
        getrenv().print = phook
        local rconsoleprinthook
        rconsoleprinthook =
            hookfunction(
            rconsoleprint,
            function(...)
                return nil
            end
        )
        local rconsolewarnhook
        rconsolewarnhook =
            hookfunction(
            rconsolewarn,
            function(...)
                return nil
            end
        )
        local rconsoleerrhook
        rconsoleerrhook =
            hookfunction(
            rconsoleerr,
            function(...)
                return nil
            end
        )
        local function ActivateAccount(key)
            local url = "https://sexscript.xyz/account/ActivateUser.php"
            key = tostring(key)
            local res =
                syn.request(
                {
                    Url = url,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["EType"] = "usermode/game"
                    },
                    Body = game:GetService("HttpService"):JSONEncode({account_key = key})
                }
            )
            if res.StatusCode == 200 then
                local response_str = tostring(res.Body)

                if string.match(response_str, "error: 1") then
                    statustext.TextColor3 = colors["Fail"]
                    statustext.Text = "error 1: synx header fail"
                elseif string.match(response_str, "error: 2") then
                    statustext.TextColor3 = colors["Fail"]
                    statustext.Text = "error 2: invalid key"
                elseif string.match(response_str, "error: 3") then
                    statustext.TextColor3 = colors["Fail"]
                    statustext.Text = "error 3: invalid key"
                elseif string.match(response_str, "error: 4") then
                    statustext.TextColor3 = colors["Fail"]
                    statustext.Text = "error 4: db fail"
                elseif string.match(response_str, "error: 5") then
                    statustext.TextColor3 = colors["Fail"]
                    statustext.Text = "error 4: already active account"
                elseif string.match(response_str, "error: 6") then
                    statustext.TextColor3 = colors["Fail"]
                    statustext.Text = "error 6: db failure"
                elseif string.match(response_str, "error: 7") then
                    statustext.TextColor3 = colors["Fail"]
                    statustext.Text = "error 7: unknown"
                elseif string.match(response_str, "status: 1") then
                    statustext.TextColor3 = colors["Success"]
                    statustext.Text = "Account activated!"
                    wait(0.5)
                    game.Players.LocalPlayer:kick(
                        "Activation Success!\n\nYou may now use the hub with the given loadstring.\n\nHappy sexing!\nhttps://discord.gg/nfyRpttaxM (sexhub public)\n"
                    )
                    if not isfolder("sexscript") then
                        makefolder("sexscript")
                    end
                    writefile("sexscript/authkey.json", game:service("HttpService"):JSONEncode({account_key = key}))
                end
            else
                statustext.TextColor3 = colors["Fail"]
                statustext.Text = "Site down"
            end
        end
        local function DrawGui()
            accountactivator.Name = "accountactivator"
            syn.protect_gui(accountactivator)
            accountactivator.Parent = game.CoreGui
            accountactivator.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            main.Name = "main"
            main.Parent = accountactivator
            main.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
            main.BorderSizePixel = 0
            main.ZIndex = 1
            main.Size = UDim2.new(0, 500, 0, 225)
            main.Position = UDim2.new(0.5, -(main.Size.X["Offset"] / 2), 0.5, -(main.Size.Y["Offset"] / 2))

            topbar.Name = "topbar"
            topbar.Parent = main
            topbar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            topbar.BorderSizePixel = 0
            topbar.Size = UDim2.new(0, 500, 0, 40)

            bartext.Name = "bartext"
            bartext.Parent = topbar
            bartext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            bartext.BackgroundTransparency = 1.000
            bartext.BorderSizePixel = 0
            bartext.Position = UDim2.new(0, 5, 0, 0)
            bartext.Size = UDim2.new(0, 495, 0, 40)
            bartext.Font = Enum.Font.Ubuntu
            bartext.TextSize = 26.000
            bartext.TextStrokeTransparency = 0.000
            bartext.TextXAlignment = Enum.TextXAlignment.Left
            bartext.RichText = true
            bartext.Text =
                '<b><font color="#ff00ff">sex</font></b><font color="#C8C8C8">hub</font>  <b><font color="#C2C2C2">--</font></b>  <font color="#47A2FF">account activator</font>'

            divider.Name = "divider"
            divider.Parent = topbar
            divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            divider.BorderSizePixel = 0
            divider.Position = UDim2.new(0, 0, 1, 0)
            divider.Size = UDim2.new(0, 499, 0, 1)

            key.Name = "key"
            key.Parent = main
            key.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            key.BackgroundTransparency = 1.000
            key.BorderSizePixel = 0
            key.Position = UDim2.new(0, 5, 0.180952415, 0)
            key.Size = UDim2.new(0, 495, 0, 184)

            keytext.Name = "keytext"
            keytext.Parent = key
            keytext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            keytext.BackgroundTransparency = 1.000
            keytext.BorderSizePixel = 0
            keytext.Size = UDim2.new(0, 125, 0, 60)
            keytext.Font = Enum.Font.Ubuntu
            keytext.Text = "Enter key:"
            keytext.TextColor3 = Color3.fromRGB(255, 255, 255)
            keytext.TextSize = 18.000
            keytext.TextStrokeTransparency = 0.000
            keytext.TextXAlignment = Enum.TextXAlignment.Left

            keybox.Name = "keybox"
            keybox.Parent = key
            keybox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
            keybox.BorderColor3 = Color3.fromRGB(255, 255, 255)
            keybox.Position = UDim2.new(0.222222224, 0, 0.0692712963, 0)
            keybox.Size = UDim2.new(0, 375, 0, 40)
            keybox.Font = Enum.Font.Ubuntu
            keybox.PlaceholderColor3 = Color3.fromRGB(255, 0, 251)
            keybox.Text = ""
            keybox.TextColor3 = Color3.fromRGB(0, 230, 255)
            keybox.TextSize = 18.000
            keybox.TextStrokeTransparency = 0.000

            submit.Name = "submit"
            submit.Parent = key
            submit.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
            submit.BorderColor3 = Color3.fromRGB(255, 255, 255)
            submit.Position = UDim2.new(0, 5, 0.354999989, 0)
            submit.Size = UDim2.new(0, 480, 0, 50)
            submit.Font = Enum.Font.Ubuntu
            submit.Text = "Activate Account"
            submit.TextColor3 = Color3.fromRGB(0, 255, 157)
            submit.TextSize = 18.000

            statustext.Name = "statustext"
            statustext.Parent = key
            statustext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            statustext.BackgroundTransparency = 1.000
            statustext.BorderSizePixel = 0
            statustext.Position = UDim2.new(0.00808080845, 0, 0.668478251, 0)
            statustext.Size = UDim2.new(0, 480, 0, 50)
            statustext.Font = Enum.Font.Ubuntu
            statustext.Text = ""
            statustext.TextColor3 = Color3.fromRGB(17, 255, 0)
            statustext.TextSize = 18
        end
        DrawGui()
        submit.Activated:connect(
            function()
                if tick() - ct > 2 then
                    ct = tick()
                    ActivateAccount(keybox.Text)
                end
            end
        )
    else
        game.Players.LocalPlayer:kick("Your exploit isn't supported.")
    end
end
do_stuff()
