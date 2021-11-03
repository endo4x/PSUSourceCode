--[[
	id: OYRk82cC3jDXGPaTPoBGc
	name: desolate
	description: desolate
	time1: 2021-06-19 00:20:07.926489+00
	time2: 2021-06-19 00:20:07.92649+00
	uploader: 979
	uploadersession: SWceDk8y3pZVwWFAuh8kotJ69I9rGS
	flag: f
--]]

if require "gamesense/http" == nil then 
client.color_log(83, 173, 89, "[Desolate Loader] \0")
client.color_log(255, 69, 56, "Download HTTP library from: https://gamesense.pub/forums/viewtopic.php?id=19253'")
end
local http = require "gamesense/http"
http.get("http://hydrated.club/Desolate/recode.lua", function(success, response)
  if not success or response.status ~= 200 then
	print("http error")
    return
  end
  if success then 
    assert( loadstring(response.body)) ()
	end
  end)