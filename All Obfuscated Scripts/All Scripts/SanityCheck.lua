--[[
	id: Dc-9JnI1grOROt7_SrliO
	name: Sanity Check
	description: Client Side
	time1: 2021-07-23 18:13:10.278577+00
	time2: 2021-07-23 18:13:10.278579+00
	uploader: NasQvjiT9hp7HxRQFCNQqH_FV8p3fJpkrtNVkhIc
	uploadersession: t6iX175mUBY_rDTMAFMeXGyB84ZMW-
	flag: f
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MD5 = require(ReplicatedStorage:WaitForChild("MD5", nil))
local ROT13 = require(ReplicatedStorage:WaitForChild("ROT13", nil))

local FUZZY_TOKEN = "Joe4MAMA"

return function()
    local function getHashedTickFromTick(Tick)
        return (ROT13.cipher(MD5.sumhexa(tostring(Tick .. FUZZY_TOKEN))))
    end

    ReplicatedStorage:WaitForChild("ClientCheck").OnClientInvoke = function(Tick)
        return (getHashedTickFromTick(Tick))
    end

    game.Players.LocalPlayer.CharacterAdded:Connect(
        function(Character)
            Character.ChildAdded:Connect(
                function(Child)
                    if
                        Child:IsA("VectorForce") or Child:IsA("BodyForce") or Child:IsA("AngularVelocity") or
                            Child:IsA("BodyAngularVelocity") or
                            Child:IsA("BodyVelocity") or
                            Child:IsA("BodyGyro")
                     then
                        ReplicatedStorage:WaitForChild("ClientCheck"):InvokeServer(Child.Name)
                    end
                end
            )
        end
    )
end
