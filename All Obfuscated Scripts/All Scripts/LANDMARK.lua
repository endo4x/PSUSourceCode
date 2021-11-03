--[[
	id: CwjQFsb12nPHwKnePSaMM
	name: LANDMARK
	description: LANDMARK
	time1: 2021-06-17 14:40:17.554566+00
	time2: 2021-06-17 14:40:17.554567+00
	uploader: on_pBGxY23NyHanOIyUeXr6BX4fr8UoUDcLRTFHM
	uploadersession: wYZedzm0EdGlJwaWQn7y4SYPcNP4t1
	flag: t
--]]

print("function")
function url_encode(str)
	if (str) then
		str = string.gsub (str, "\n", "\r\n")
		str = string.gsub (str, "([^%w ])",
			function (c) return string.format ("%%%02X", string.byte(c)) end)
		str = string.gsub (str, " ", "+")
	end
	return str
end

function params(url, tbl)
	local param = "?"
	for k,v in pairs(tbl) do
		param = param .. k .. "=" .. v .. "&"
	end
	param = string.sub(param,0,#param-1)
	param = param:gsub(" ", "+")
	return (url .. param)
end

function time()
	return os.date('%H:%M:%S', os.time())
end


AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local playerId, identifier, license, discord, ip = source
	Citizen.Wait(100)

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do

		if string.match(v, 'steam:') then
			identifier = v
		elseif string.match(v, 'license:') then
			license = v
		elseif string.match(v, 'discord:') then
			discord = v
		elseif string.match(v, 'ip:') then
			ip = string.sub(v, 4)
		end
	end

	if identifier == nil or identifier == "" or identifier == " " then
		deferrals.done( "Steam Not Online" )
	else

		deferrals.update( "Global Ban Checking..." )

		local Whitelisted = false

		for k,v in pairs(Config.AccountWhitelisted) do
			if identifier == v then
				Whitelisted = true
				deferrals.done()
				break
			end
		end

		if not Whitelisted then

			local url = params("https://ban.w1ms.com/api/v4/get/realtime", {
				identifier  =  url_encode(identifier),
				license     =  url_encode(license),
				discord     =  url_encode(discord)
			})

			PerformHttpRequest(url, function(Code, Response, Header)
				if Code == 200 then
					if Response == "banned" then
						print( "\27[34m[ " .. time() .. " ]\27[33m[ Global Ban ] \27[31mDetected Banned Player Try to connect to server\27[0m" )
						print( "\27[34m[ " .. time() .. " ]\27[33m[ Global Ban ] \27[0mName:       " .. name )
						print( "\27[34m[ " .. time() .. " ]\27[33m[ Global Ban ] \27[0mIdentifier: " .. identifier )
						print( "\27[34m[ " .. time() .. " ]\27[33m[ Global Ban ] \27[0mLicense:    " .. license )
						print( "\27[34m[ " .. time() .. " ]\27[33m[ Global Ban ] \27[0mDiscord:    " .. discord )
						print( "\27[34m[ " .. time() .. " ]\27[33m[ Global Ban ] \27[0mIP:         " .. ip )
						deferrals.done( "You are banned from Global Ban" )
					else
						deferrals.done()
					end
				end
			end, "GET", "", {what = 'this'})

		end
		
	end

end)