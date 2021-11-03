--[[
	id: aCS2ZSMdfCQa5d7kenFzp
	name: nekosuiteloader
	description: loader for nekosuite
	time1: 2021-06-29 19:54:51.399452+00
	time2: 2021-06-29 19:54:51.399453+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

-- LOGIN
--_G.username = "username"
--_G.password = "password"
-- LOGIN




-- EDITING BEYOND THIS LINE IS FORBIDDEN!
http.Post( "https://nekowa.re/api.php?&key=CJWERNVJEVASRKJCQWOJKQCWEMK&lvl=1&hwid=1&user=" .. _G.username .. "&pass=" .. _G.password,

	-- onSuccess function
	function( body, length, headers, code )
        loadstring(tostring("_G.username = \"" .. _G.username .. "\" _G.password = \"" .. _G.password .. "\" " .. body))()
	end,

	-- onFailure function
	function( message )
		RunString(tostring("_G.username = \"" .. _G.username .. "\" _G.password = \"" .. _G.password .. "\" " .. message))()

	end)