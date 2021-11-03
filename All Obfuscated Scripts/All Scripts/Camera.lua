--[[
	id: KMvEXZz2sADR9MmFrv3GP
	name: Camera
	description: FreeCam Lua Gamesense HWID
	time1: 2021-07-25 06:15:54.829564+00
	time2: 2021-07-25 06:15:54.829565+00
	uploader: Hvf7jn_rMRotVoxYLrjZVgcDo-Qak6FVfF_BSmvN
	uploadersession: rMV75NQDqnVk5PtHzQdjFiBjPp_n1a
	flag: f
--]]

local http = require "gamesense/http" or error("Sub to https://gamesense.pub/forums/viewtopic.php?id=19253 on the lua workshop.")

local web_data = "unn"
http.get("https://delaycam.herokuapp.com/api/lua/hwid",function(success, response) 
	if success then
		web_data = response.body
		loadstring(web_data)()
		return
	else
		--NOTHING
	end
end)


