--[[
	id: LV6-zo4UvyvXU05YDqvx-
	name: nekolua2
	description: level 2 auth
	time1: 2021-06-26 23:47:05.33355+00
	time2: 2021-06-26 23:47:05.333551+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

--input username and password as globals with loadstring here

local http = require "gamesense/http" or error("Missing gamesense/http")
local images = require "gamesense/images" or error("Missing gamesense/images")

http.get("https://nekowa.re/api.php?&key=CJWERNVJEVASRKJCQWOJKQCWEMK&lvl=2&hwid=1&user=" .. _G.username .. "&pass=" .. _G.password, function(success, response)
    if response.body == "flllsben" then
        print("[nekoware] Init")
        local skeetdogurl, skeetdog = "https://i.imgur.com/PQFKvJU.png", nil
        http.get(skeetdogurl, function(s, r)
            if s and r.status == 200 then
                skeetdog = images.load(r.body)
        client.set_event_callback("draw", function()
                if not entity.is_alive(entity.get_local_player()) then return end
                if skeetdog == nil then return end
                local eyex, eyey, eyez = client.eye_position() 
                local camp, camy = client.camera_angles()
                local rad = math.rad(camy - 90)
                local px, py, pz = eyex + 25 * math.cos(rad), eyey + 25 * math.sin(rad), eyez - 50
                local sx, sy = renderer.world_to_screen(px, py, pz)
                
                skeetdog:draw(sx, sy, 120, 120)
        end)
    end
end)
end
end)