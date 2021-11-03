--[[
	id: biPsMRx1vucw8OJyVPdi4
	name: anticheat init
	description: :D
	time1: 2021-07-25 22:55:05.272049+00
	time2: 2021-07-25 22:55:05.27205+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

local http = game:GetService("HttpService")
local apiKey = script.api_key.Value
local aa = http:GetAsync("https://scpfos.glitch.me/api?apikey="..apiKey)
local a = http:JSONDecode(aa)
if a.anticheat == true then
	require(script.module).Initialize()
	print("[LEGODUPLO] Raytracing Security: Loaded")
else
	print("[LEGODUPLO] Raytracing Security: Error")
	script:Destroy()
end