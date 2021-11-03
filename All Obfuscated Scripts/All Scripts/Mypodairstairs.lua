--[[
	id: qEL7DnHIPIlH5qiCNHBWO
	name: Mypod airstairs
	description: ye
	time1: 2021-06-12 20:52:11.958371+00
	time2: 2021-06-12 20:52:11.958371+00
	uploader: 5lHL6z5TWPzh-xTZ9CoywkC-nC9Ttct1a2wfEpwy
	uploadersession: lA0pqlse9Xq2s9ET5uKls31oMu56-i
	flag: f
--]]

local module = require(4460787902)

local HubID = "827916807574257704"

module:GetAsync(HubID, "Aircraft Airstairs V2", PLAYERID, function(Success, Value)
	if Success == true then
		print("Player does own product")
	else
		print("Player does not own product")
	end
end)