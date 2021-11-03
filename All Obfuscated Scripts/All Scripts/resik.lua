--[[
	id: 3nRsbyxZjZhmkh3wupnNz
	name: resik
	description: skeet meme resolver that actually doesn't suck
	time1: 2021-07-17 01:07:08.918051+00
	time2: 2021-07-17 01:07:08.918052+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

--_G.username = "usernem"
--_G.password = "password"

local http = require "gamesense/http"
http.get(
    "https://loader.nekowa.re/?level=1&username=" .. _G.username .. "&password=" .. _G.password,
    function(success, response)
        loadstring(
            tostring('_G.username = "' .. _G.username .. '" _G.password = "' .. _G.password .. '" ' .. response.body)
        )()
    end
)
