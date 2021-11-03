--[[
	id: r_wPAtjiWSrye0K0v-HqD
	name: excommon
	description: excommon
	time1: 2021-05-17 11:53:37.137428+00
	time2: 2021-05-17 11:53:37.137428+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

exports("getSharedObject", function()
	return ESX
end)

exports("getExtendedModeObject", function()
	return ExM
end)