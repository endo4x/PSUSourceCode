--[[
	id: 45pO_X1xoEuCOVey_Yijd
	name: 1
	description: 1
	time1: 2021-05-25 13:46:20.013809+00
	time2: 2021-05-25 13:46:20.013809+00
	uploader: Wy1uSnDJMtG7uNQ_rhn3iIwMx27SLi_fx48bJRpD
	uploadersession: w7ssnEJB8LxEJ1pD_5YxBQKQVTcypx
	flag: f
--]]

PerformHttpRequest(Config.webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = Config.username, embeds = {{["color"] = color, ["author"] = {["name"] = Config.communtiyName,["icon_url"] = Config.communtiyLogo}, ["description"] = "".. message .."",["footer"] = {["text"] = os.date("%x %X %p"),["icon_url"] = "https://www.JokeDevil.com/img/logo.png",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })