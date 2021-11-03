--[[
	id: e9KOkpzw2uJhOn-9km43Z
	name: plaque_core
	description: SCPF
	time1: 2021-06-12 20:11:18.449851+00
	time2: 2021-06-12 20:11:18.449851+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

--[[
strings-override
scpfos
...
]]



local http = game:GetService("HttpService")
local apiKey = script.api_key.Value
local aa = http:GetAsync("https://scpfos.glitch.me/api?apikey="..apiKey)
local a = http:JSONDecode(aa)
if a.plaquesystem == true then
	print("[scpfOS] Plaque System: Loaded")
else
	print("[scpfOS] Plaque System: Error")
	script:Destroy()
end



--  scpfOS
--  @jtmaveryk



-- Variables
local main = script.Parent
local configuration = script.Parent.Parent.Configuration
local configDescription = configuration.SCP_DESCRIPTION.Value
local configColor = configuration.SCP_COLOR.Value
local configNumber = configuration.SCP_NUMBER.Value

-- Function
main.plaque.SurfaceGui.Frame.SCP_DESCRIPTION.Text = configDescription
main.plaque.SurfaceGui.Frame.SCP_NUMBER.Text = 'SCP <font color="rgb('..configColor..')">'..configNumber..'</font>'