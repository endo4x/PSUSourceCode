--[[
	id: n5VCjLeo-6om-ASwqTl-1
	name: resiklibloader
	description: the loader that loads the required libraries
	time1: 2021-07-17 01:13:23.898695+00
	time2: 2021-07-17 01:13:23.898702+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

-- change api=logs in the http get link to whatever library you need or whatever you give me lol, logs = resolver/logs.lua etc etc you get my saying.


local http = require "gamesense/http"
http.get(
    "https://loader.nekowa.re/&api=logs&username=" .. _G.username .. "&password=" .. _G.password,
    function(success, response)
        local logs = loadstring(
                        tostring('_G.username = "' .. _G.username .. '" _G.password = "' .. _G.password .. '" ' .. response.body)
        )()
    end
)