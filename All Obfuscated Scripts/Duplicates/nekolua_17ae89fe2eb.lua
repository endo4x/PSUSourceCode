--[[
	id: MT6od6FWFYqLXEDzDNtNP
	name: nekolua1
	description: level 1 auth of skeet lua
	time1: 2021-06-26 23:42:40.88753+00
	time2: 2021-06-26 23:42:40.887531+00
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
