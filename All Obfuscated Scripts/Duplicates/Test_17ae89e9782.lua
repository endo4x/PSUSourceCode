--[[
	id: xYkxuBTkpTTVN2UL_ivmC
	name: Test
	description: thing
	time1: 2021-06-04 00:21:00.641235+00
	time2: 2021-06-04 00:21:00.641236+00
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
--[[ Last synced 10/20/2020 07:27 || RoSync Loader ]]   