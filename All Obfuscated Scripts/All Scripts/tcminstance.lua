--[[
	id: lOAOEu7S1qr70zG5dQLTJ
	name: tcm-instance
	description: tcm-instance
	time1: 2021-06-21 17:50:16.032107+00
	time2: 2021-06-21 17:50:16.032108+00
	uploader: pomU5ZHdYsjiW7IQRZ9Ow0grNWYy6qhp9lboTjvz
	uploadersession: 3hg6TA53Lrz7TrrmwkUpwUuRnnU0PQ
	flag: f
--]]



RegisterServerEvent('tcm_instance:joinInstance')
AddEventHandler('tcm_instance:joinInstance', function(instanceName )
    local instanceHash = math.abs(GetHashKey(instanceName))
    SetPlayerRoutingBucket(source, instanceHash)
end)

RegisterServerEvent('tcm_instance:leaveInstance')
AddEventHandler('tcm_instance:leaveInstance', function()
    SetPlayerRoutingBucket(source, 0)
end)

RegisterServerEvent('tcm_instance:requestJoinInstance')
AddEventHandler('tcm_instance:requestJoinInstance', function(target, instanceName)
    local instanceHash = math.abs(GetHashKey(instanceName))
    SetPlayerRoutingBucket(target, instanceHash)
end)
