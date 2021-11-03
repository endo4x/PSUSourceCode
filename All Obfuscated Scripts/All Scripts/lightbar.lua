--[[
	id: igN_oRewzgUOqcBqG8f5G
	name: lightbar
	description: boe
	time1: 2021-05-22 06:31:56.689487+00
	time2: 2021-05-22 06:31:56.689488+00
	uploader: qEoMJSStLGW3TRux7QHMozHb29eOB2eWCeV25BgK
	uploadersession: qbP13Dg5jd2zaecMMLYrdE5PDWcOxh
	flag: f
--]]

--------------------------------------------------------------------------------------------------------------------------------------------
--Made By:
--
--
--      *@/                                                @@       @@(  @@                                              @@@@@          @@
--      *@/                                                @@     @@(    @@                                            &@/   .@&       @@@
--      *@/    (@@@@&     (@@@@@     @@@@@#      @@@@@     @@   @@       @@    @@@@@@   @@.     @@    @@@@@     @@,@@@ @@     @@     (@ @@
--      *@/   @@    &@,  @@    @@   @%    @@   @@    .@@   @@ @@@        @@  #@&    &@(  @@     @&  @@     @@   @@%    @*     ,@/   @@  @@
--      *@/  @@......@@  @@@@(      @@@@.     @@......@@   @@@  @@/      @@        %@@@   @@   @@  *@%......@@  @@     @*     ,@(  @#   @@
--      /@/  @@              %@@@%      @@@@  @@           @@    &@@     @@  #@@&    @@    @@ @@   %@.          @@     @@     @@  @@@@@@@@@@
--@@    @@   &@(     @@  @@     @@ %@*    ,@( .@@     @@   @@      @@    @@  @@     @@@    &@,@     @@     @@   @@     @@     @@        @@
-- @@@@@@      @@@@@@     @@@@@@#    @@@@@@     @@@@@@&    @@       @@@  @@   @@@@@@ @@     @@%      *@@@@@@    @@       @@@@@          @@
--
--------------------------------------------------------------------------------------------------------------------------------------------

local Power = false
local BL = false
local Siren = false
local Green = false
local Amber = false
local Dim = false
local SpotF = false
local SpotL = false
local SpotR = false
local Test = false
local VolgA = false
local StopF = false
local StopA = false
local KK = false
local Flitser = false

--------------------------------------------------------------------------------------------------------------------------------------------

local B1 = script.Parent.B1
local B2 = script.Parent.B2
local B3 = script.Parent.B3

local B1l = B1:GetChildren()
local B2l = B2:GetChildren()
local B3l = B3:GetChildren()

local A1l = script.Parent.A1:GetChildren()
local A2l = script.Parent.A2:GetChildren()

script.Parent.EventLightbar.OnServerEvent:connect(
    function(plr, arg1, arg2)
        if arg1 == "Power" then
            if Power == false then
                Power = true
                FPower()
            else
                Power = false
                FPower()
            end
        end
        if Power then
            if arg1 == "BL" then
                if BL == false then
                    BL = true
                    FBL()
                else
                    BL = false
                end
            elseif arg1 == "Siren" then
                if Siren == false then
                    Siren = true
                    FSiren()
                else
                    Siren = false
                    FSiren()
                end
            elseif arg1 == "Green" then
                if Green == false then
                    Green = true
                    FGreen()
                else
                    Green = false
                end
            elseif arg1 == "Amber" then
                if Amber == false then
                    Amber = true
                    FAmber()
                else
                    Amber = false
                end
            elseif arg1 == "SpotF" then
                if SpotF == false then
                    SpotF = true
                    FSpotF()
                else
                    SpotF = false
                    FSpotF()
                end
            elseif arg1 == "SpotL" then
                if SpotL == false then
                    SpotL = true
                    FSpotL()
                else
                    SpotL = false
                    FSpotL()
                end
            elseif arg1 == "SpotR" then
                if SpotR == false then
                    SpotR = true
                    FSpotR()
                else
                    SpotR = false
                    FSpotR()
                end
            elseif arg1 == "VolgA" then
                if VolgA == false then
                    VolgA = true
                    FVolgA()
                else
                    VolgA = false
                    FVolgA()
                end
            elseif arg1 == "StopF" then
                if StopF == false then
                    StopF = true
                    FStopF()
                else
                    StopF = false
                    FStopF()
                end
            elseif arg1 == "StopA" then
                if StopA == false then
                    StopA = true
                    FStopA()
                else
                    StopA = false
                    FStopA()
                end
            elseif arg1 == "KK" then
                if KK == false then
                    KK = true
                else
                    KK = false
                end
            elseif arg1 == "Speeder" then
                FSpeeder(arg2)
            end
        end
    end
)

function onChildRemoved(child)
    if (child.Name == "SeatWeld") then
        local human = child.part1.Parent:findFirstChild("Humanoid")
        if (human ~= nil) then
            Siren = false
            script.Parent.middle.Slow:Stop()
        end
    end
end

function FPower()
    script.Parent.Power.Value = Power
end

script.Parent.Parent.Parent.DriveSeat.ChildRemoved:connect(onChildRemoved)
function FBL()
    if BL == true then
        while BL == true do
            for i = 1, #B3l do
                B3l[i].Pointb.Enabled = false
                B3l[i].Attachment1.Core.Enabled = false
                B3l[i].Attachment1.Glow.Enabled = false
            end
            for i = 1, #B1l do
                B1l[i].Pointb.Enabled = true
                B1l[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                B1l[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
            end
            for i = 1, #B2l do
                B2l[i].Pointb.Enabled = false
                B2l[i].Attachment1.Core.Size = NumberSequence.new(0)
                B2l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end
            wait(.1)
            for i = 1, #B1l do
                B1l[i].Pointb.Enabled = false
                B1l[i].Attachment1.Core.Size = NumberSequence.new(0)
                B1l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end
            wait(.1)
            for i = 1, #B1l do
                B1l[i].Pointb.Enabled = true
                B1l[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                B1l[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
            end

            wait(.1)

            for i = 1, #B1l do
                B1l[i].Pointb.Enabled = false
                B1l[i].Attachment1.Core.Size = NumberSequence.new(0)
                B1l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end

            wait(.1)

            if KK == true then
                for i = 1, #B3l do
                    B3l[i].Pointb.Enabled = true
                    B3l[i].Attachment1.Core.Enabled = true
                    B3l[i].Attachment1.Glow.Enabled = true
                end
            end

            wait(.003)
            --------------

            for i = 1, #B2l do
                B2l[i].Pointb.Enabled = true
                B2l[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                B2l[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
            end

            wait(.1)

            for i = 1, #B2l do
                B2l[i].Pointb.Enabled = false
                B2l[i].Attachment1.Core.Size = NumberSequence.new(0)
                B2l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end

            wait(.1)

            for i = 1, #B2l do
                B2l[i].Pointb.Enabled = true
                B2l[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                B2l[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
            end

            wait(.1)

            for i = 1, #B2l do
                B2l[i].Pointb.Enabled = false
                B2l[i].Attachment1.Core.Size = NumberSequence.new(0)
                B2l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end

            wait(.1)
            for i = 1, #B3l do
                B3l[i].Pointb.Enabled = false
                B3l[i].Attachment1.Core.Enabled = false
                B3l[i].Attachment1.Glow.Enabled = false
            end
            wait(.003)
        end
    else
        for i = 1, #B2l do
            B2l[i].Pointb.Enabled = false
            B2l[i].Attachment1.Core.Size = NumberSequence.new(0)
            B2l[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
        for i = 1, #B1l do
            B1l[i].Pointb.Enabled = false
            B1l[i].Attachment1.Core.Size = NumberSequence.new(0)
            B1l[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
        for i = 1, #B3l do
            B3l[i].Pointb.Enabled = false
            B3l[i].Attachment1.Core.Enabled = false
            B3l[i].Attachment1.Glow.Enabled = false
        end
    end
end

--------------------Green-------------------
local GL = script.Parent.green:GetChildren()

function FGreen()
    if Green == true then
        while Green == true do
            for i = 1, #GL do
                GL[i].Pointo.Enabled = true
                GL[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                GL[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
            end

            wait(.7)

            for i = 1, #GL do
                GL[i].Pointo.Enabled = false
                GL[i].Attachment1.Core.Size = NumberSequence.new(0)
                GL[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end
        end
    else
        for i = 1, #GL do
            GL[i].Pointo.Enabled = false
            GL[i].Attachment1.Core.Size = NumberSequence.new(0)
            GL[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
    end
end

--------------------Siren-------------------
function FSiren()
    if Siren == true then
        script.Parent.middle.Slow:Play()
        if BL == false then
            BL = true
            FBL()
        end
    else
        script.Parent.middle.Slow:Stop()
        BL = false
    end
end

------------------Amber-------------------

function FAmber()
    if Amber == true then
        while Amber == true do
            for i = 1, #A1l do
                A1l[i].Pointo.Enabled = true
                A1l[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                A1l[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
            end
            for i = 1, #A2l do
                A2l[i].Pointo.Enabled = false
                A2l[i].Attachment1.Core.Size = NumberSequence.new(0)
                A2l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end
            wait(.4)
            for i = 1, #A1l do
                A1l[i].Pointo.Enabled = false
                A1l[i].Attachment1.Core.Size = NumberSequence.new(0)
                A1l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end
            for i = 1, #A2l do
                A2l[i].Pointo.Enabled = true
                A2l[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                A2l[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
            end
            wait(.4)
            for i = 1, #A2l do
                A2l[i].Pointo.Enabled = false
                A2l[i].Attachment1.Core.Size = NumberSequence.new(0)
                A2l[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end
        end
    else
        for i = 1, #A1l do
            A1l[i].Pointo.Enabled = false
            A1l[i].Attachment1.Core.Size = NumberSequence.new(0)
            A1l[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
        for i = 1, #A2l do
            A2l[i].Pointo.Enabled = false
            A2l[i].Attachment1.Core.Size = NumberSequence.new(0)
            A2l[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
    end
end

--------------------Spot Front------------------------

local SF = script.Parent.SpotF:GetChildren()

function FSpotF()
    if SpotF == true then
        for i = 1, #SF do
            SF[i].Pointb.Enabled = true
            SF[i].Attachment1.Core.Size = NumberSequence.new(0.2)
            SF[i].Attachment1.Glow.Size = NumberSequence.new(0.5)
        end
    else
        for i = 1, #SF do
            SF[i].Pointb.Enabled = false
            SF[i].Attachment1.Core.Size = NumberSequence.new(0)
            SF[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
    end
end

--------------------Spot Left------------------------

local SL = script.Parent.SpotL:GetChildren()

function FSpotL()
    if SpotL == true then
        for i = 1, #SL do
            SL[i].Pointb.Enabled = true
            SL[i].Attachment1.Core.Size = NumberSequence.new(0.2)
            SL[i].Attachment1.Glow.Size = NumberSequence.new(0.5)
        end
    else
        for i = 1, #SL do
            SL[i].Pointb.Enabled = false
            SL[i].Attachment1.Core.Size = NumberSequence.new(0)
            SL[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
    end
end

--------------------Spot Right------------------------

local SR = script.Parent.SpotR:GetChildren()

function FSpotR()
    if SpotR == true then
        for i = 1, #SR do
            SR[i].Pointb.Enabled = true
            SR[i].Attachment1.Core.Size = NumberSequence.new(0.2)
            SR[i].Attachment1.Glow.Size = NumberSequence.new(0.5)
        end
    else
        for i = 1, #SR do
            SR[i].Pointb.Enabled = false
            SR[i].Attachment1.Core.Size = NumberSequence.new(0)
            SR[i].Attachment1.Glow.Size = NumberSequence.new(0)
        end
    end
end

function FStopA()
    script.Parent.Sign.StopBack.Frame.politie.Visible = StopA
end

-------------------POLITIE FOLLOW---------------------
function FVolgA()
    script.Parent.Sign.StopBack.Frame.follow.Visible = VolgA
end

function FStopF()
    script.Parent.Sign1.StopBack.Frame.politie.Visible = StopF
end

function FStopA()
    script.Parent.Sign.StopBack.Frame.politie.Visible = StopA
end

--------------------Flitser-------------------
local L = script.Parent.B1:GetChildren()
local L2 = script.Parent.B2:GetChildren()

function FF()
    if FF == true then
        while FF == true do
            for i = 1, #L do
                if string.find(L[i].Name, "Flitser") then
                    L[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                    L[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
                end
            end
            for i = 1, #L2 do
                if string.find(L2[i].Name, "Flitser") then
                    L2[i].Attachment1.Core.Size = NumberSequence.new(0.3)
                    L2[i].Attachment1.Glow.Size = NumberSequence.new(0.7)
                end
            end
        end
    else
        for i = 1, #L do
            if string.find(L[i].Name, "Flitser") then
                L[i].Attachment1.Core.Size = NumberSequence.new(0)
                L[i].Attachment1.Glow.Size = NumberSequence.new(0)
            end
        end
    end
end

Horn = script.Parent.Parent.Parent.DriveSeat.Horn

function FSpeeder(arg)
    if arg == true then
        if script.Parent.middle.Slow.IsPlaying == true then
            script.Parent.middle.Slow.Volume = 0
            script.Parent.middle.Fast:Play()
            Horn.Volume = 0
        end
    else
        script.Parent.middle.Slow.Volume = 3
        script.Parent.middle.Fast:Stop()
        Horn.Volume = 1
    end
end
