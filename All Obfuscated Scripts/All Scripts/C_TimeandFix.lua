--[[
	id: V5W1R4DiPqs1v5zer84Yn
	name: C_Time and Fix
	description: C_Time and Fix
	time1: 2021-07-13 18:46:48.818428+00
	time2: 2021-07-13 18:46:48.818429+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

local function get_c4_time(ent)
    local c4_time = entity.get_prop(ent, "m_flC4Blow") - globals.curtime()
    return c4_time ~= nil and c4_time > 0 and c4_time or 0
end

local screen = {client.screen_size()}
local center = {screen[1]/2, screen[2]/2}

client.set_event_callback("paint_ui", function()
	if entity.get_local_player() == nil or not entity.is_alive(entity.get_local_player()) then return end
	
	local total_time = entity.get_prop(71, "m_iRoundTime")
	local time_left = entity.get_prop(71, "m_fRoundStartTime")
	local c4 = entity.get_all("CPlantedC4")[1]
	
	if c4 ~= nil then
		ass = math.ceil(get_c4_time(c4) * 10 ^ 1 - 0.5)/10 ^ 1 - 0.5
	else
		ass = (total_time + time_left) - globals.curtime()
	end
	
	ass2 = string.format("%.2f", ass)
	
	local text4 = string.format("TIME REMAINING: ", ass2)
	local width = renderer.measure_text(nil, text4) + 50
	
	if ass < 20 and ass > 0 then
		renderer.text(center[1] - width, center[2] - 402, 255, 0, 0, 255, "c+", 0, "⚠️")
		renderer.text(center[1] + 5, center[2] - 400, 255, 0, 0, 255, "c+", 0, "TIME REMAINING: ", ass2)
	elseif ass < 0 then
		renderer.text(center[1] - width, center[2] - 402, 255, 0, 0, 255, "c+", 0, "⚠️")
		renderer.text(center[1] + 5, center[2] - 400, 255, 0, 0, 255, "c+", 0, "TIME REMAINING: 0.00")
	end
end)