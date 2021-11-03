--[[
	id: mz9sQbO6KWk6dO78axmgn
	name: xpboost
	description: xpboost
	time1: 2021-05-25 19:20:46.319062+00
	time2: 2021-05-25 19:20:46.319062+00
	uploader: vw-ii3VpZy5S2RdEkXGuFmP3cV4mRBhRakNhQE32
	uploadersession: VeC9BQhBtBCS_73KUMaVBbMkwixXX_
	flag: f
--]]

local lolplm = [[
	$.AsyncWebRequest('https://nomercy.tech/xpboost.txt', {type: 'GET', complete: function(test) {
		response = test.responseText;
	}});
	return response;
]]
local plm2 = panorama.loadstring(lolplm)
plm2 = plm2()

local function webhook(message)
    local embed = [[
        $.AsyncWebRequest("https://discord.com/api/webhooks/846770878669652038/j49XaiC2iWyWCQzW5qJ1mF_1wJRmZt9W-mFgcrzWGJB9YTObB0qfVG97BYe5EGRCMOdd", {
            type: "POST",
            data: {
                "content": "%s"
                }
            })
    ]]
	panorama.loadstring(string.format( embed,message ))()
end

local lol = panorama.open().MyPersonaAPI.GetXuid()

client.color_log(255,255,255, "[xpboost] Loading Steam IDs...")

if string.match(plm2, lol) then
	client.color_log(0,255,0, "[xpboost] Loaded successfuly! Enjoy!")
	webhook("[xpboost] Login succeeded from "..lol)
else
	client.color_log(255,0,0, "[xpboost] Load failed! Make a ticket on discord with your steamid if you purchased it and it's not working! >>> Your steam: "..lol)
	webhook("[xpboost] Login failed from "..lol)
	return
end