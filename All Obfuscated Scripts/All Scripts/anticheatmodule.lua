--[[
	id: ElS2VIowMwzG0zp62F85k
	name: anticheat module
	description: :D
	time1: 2021-07-25 03:21:37.81358+00
	time2: 2021-07-25 03:21:37.813581+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Settings = {
	ExemptGroupId = 7851108; --What group is the certain rank in.
	ExamptRankInt = 110; --What rank is the minimum to be exempt from anticheat?
}

local TrackedCharacters = {}
local Anticheat = {}
local Visuals = {}

local function VisualizeHitDetection(pointA,pointB,hit) -- For debugging.
	local line = Instance.new("Part")
	line.Parent = game.Workspace.Effects
	line.Anchored = true
	line.CanCollide = false
	local dist = (pointA-pointB).magnitude
	line.Size = Vector3.new(0.02,0.02,dist)
	line.CFrame = CFrame.new(pointA,pointB) * CFrame.new(0,0,-dist/2)
	line.Material = Enum.Material.Neon
	line.Transparency = 0.5
	if hit then
		line.Color = Color3.fromRGB(255,0,0)
	else
		line.Color = Color3.fromRGB(0,0,255)
	end
	table.insert(Visuals,line)
	game:GetService("Debris"):AddItem(line,1)
end

local function CheckSit()
	
end

function Anticheat.Initialize()
	Players.PlayerAdded:connect(function(player)
		player.CharacterAdded:connect(function(character)
			if player:GetRankInGroup(Settings.ExemptGroupId) < Settings.ExamptRankInt then
				TrackedCharacters[player] = {character,nil,Vector3.new(0,0,0),false,0,0,0}
			end
		end)
	end)
	RunService.Stepped:connect(function(_,deltaTime)
		local timeSinceLastStrike
		for player,trackerTable in pairs(TrackedCharacters) do
			if trackerTable[4] == false then
				local HRP
				if not trackerTable[2] then
					HRP = trackerTable[1]:FindFirstChild("HumanoidRootPart")
				end
				local humanoid = trackerTable[1]:FindFirstChildOfClass("Humanoid")
				if HRP and humanoid then
					local preventUpdate = false
					do --Teleport Patch
						if trackerTable[3] == Vector3.new(0,0,0) then
							trackerTable[3] = HRP.CFrame.p
						end
						local dist = (trackerTable[3]-HRP.CFrame.p).magnitude
						--print(dist)
						local velocity = HRP.Velocity.magnitude
						if dist > (velocity+5) and humanoid.SeatPart == nil and not game:GetService("CollectionService"):HasTag(HRP,"TeleportBypass") then
							HRP.CFrame = CFrame.new(trackerTable[3])
							trackerTable[5] = trackerTable[5] + 1
							warn("LEGODUPLO: WATCH[TELEPORT]: "..tostring(player.Name))
							--player:LoadCharacter()
							--[[coroutine.wrap(function()
								local function loopSet(owner)
									for _,part in pairs(trackerTable[1]:GetChildren()) do
										if part:IsA("BasePart") then
											part:SetNetworkOwner(owner)
										end
									end
								end
								loopSet(nil)
								wait(1)
								loopSet(player)
							end)()]]
							preventUpdate = true
						end
					end
					do -- NoClip Patch
						local pA = HRP.Position
						local pB = trackerTable[3]
						local ray = Ray.new(pB,pA-pB)
						--print(ray.Direction)
						local part,_,normal = game.Workspace:FindPartOnRay(ray,trackerTable[1],true,true)
						--VisualizeHitDetection(pA,pB,part)
						if part then
							if part.CanCollide == true and part:IsGrounded() and humanoid.SeatPart == nil then
								warn("LEGODUPLO: WATCH[NOCLIP]: "..tostring(player.Name))
								HRP.CFrame = CFrame.new(trackerTable[3]) + (normal*3)
								preventUpdate = true
								--player:LoadCharacter()
							end
						end
					end
					do -- Walkspeed patch coming soon?
					end
					if trackerTable[5] >= 5 then --5 Strike system that reloads the character after repeated attempts to teleport/noclip/walkspeed
						trackerTable[5] = 0
						--player:LoadCharacter()
						warn("LEGODUPLO: POTENTIAL EXPLOITER[STRIKE LIMIT]: "..tostring(player.Name))
					elseif trackerTable[5] > 0 then
						trackerTable[6] = trackerTable[6] + deltaTime
					end
					if trackerTable[6] >= 60 then --How long until timer is refreshed on strike system.
						trackerTable[6] = 0
						trackerTable[5] = 0
					end
					if preventUpdate ~= true then
						trackerTable[3] = HRP.CFrame.p
					end
				else
					local head = trackerTable[1]:FindFirstChild("Head")
					if head then
						trackerTable[1]:BreakJoints()
					end
				end
			end
		end
	end)
end

function Anticheat.ToggleIgnore(player,toggle) --Used for toggling things like teleporting players and such. Ignores players in this state.
	if player then
		local trackerTable = TrackedCharacters[player]
		if trackerTable then
			if toggle == true then
				trackerTable[3] = Vector3.new(0,0,0)
			end
			trackerTable[4] = toggle
		end
	end
end

return Anticheat