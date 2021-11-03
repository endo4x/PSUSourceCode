--[[
	id: wKmrzyuG_WjzJEfKEAK6r
	name: 8t is on9
	description: 1
	time1: 2021-07-15 04:18:32.060802+00
	time2: 2021-07-15 04:18:32.060803+00
	uploader: 5XWld5ewvy55UlPBJpR9zqr0rYkQEe-yoKCo4liW
	uploadersession: aFqB7uaKk_Scq-xS9AECltWafdOlnT
	flag: f
--]]

--[[
    [ Credits ]
    gawky 
	8t
    NmcChris 
    sapphyrus 
    mlc 
    LCHFLY 
    77 
    Salvatore 

FiveFive
--]]

local anti_aim = require 'gamesense/antiaim_funcs'
local entitylib = require 'gamesense/entity'
local vector = require 'vector'
local active = ui.new_checkbox('CONFIG', 'Presets', 'Enable Anti-aim box')
local lable = ui.new_label('CONFIG', 'Presets', 'Anti-aim box color picker')
local color_picker = ui.new_color_picker('CONFIG', 'Presets', 'Anti-aim box color picker', 142, 165, 229, 55)
local onshot, onshotkey = ui.reference('aa', 'other', 'On shot anti-aim')
local third, thirdkey = ui.reference('VISUALS', 'Effects', 'Force third person (alive)')
local ALPHA = 255
function round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local normalize_yaw = function(angle)
	angle = (angle % 360 + 360) % 360
	return angle > 180 and angle - 360 or angle
end
local clamp = function(min, max, current)
	if min < max then
		return math.min(max, math.max(min, current))
	else
		return math.min(min, math.max(max, current))
	end
end

local lerp = function(from, to, percent)
	local yes = {}
	for i = 1, #from do
		yes[i] = from[i] + (to[i] - from[i]) * percent
	end
	return yes
end

local eye_position = function(index)
	local origin = {
		entity.get_origin(index)
	}
	if origin[1] == nil then
		return nil
	end
	local view_offset = {
		entity.get_prop(index, 'm_vecViewOffset')
	}
	if view_offset[1] == nil then
		return nil
	end

	return {
		origin[1],
		origin[2],
		origin[3] + 250
	}
end


local function angle_forward(angle)
	local sin_pitch = math.sin(math.rad(angle.x))
	local cos_pitch = math.cos(math.rad(angle.x))
	local sin_yaw   = math.sin(math.rad(angle.y))
	local cos_yaw   = math.cos(math.rad(angle.y))
	return vector(
        cos_pitch * cos_yaw,
        cos_pitch * sin_yaw,
        -sin_pitch
    )
end

local function angle_right(angle)
	local sin_pitch = math.sin( math.rad(angle.x))
	local cos_pitch = math.cos( math.rad(angle.x))
	local sin_yaw   = math.sin( math.rad(angle.y))
	local cos_yaw   = math.cos( math.rad(angle.y))
	local sin_roll  = math.sin( math.rad(angle.z))
	local cos_roll  = math.cos( math.rad(angle.z))
	return vector(
        -1.0 * sin_roll * sin_pitch * cos_yaw + -1.0 * cos_roll * -sin_yaw,
        -1.0 * sin_roll * sin_pitch * sin_yaw + -1.0 * cos_roll * cos_yaw,
        -1.0 * sin_roll * cos_pitch
    )
end

function vecotr_ma(start, scale, direction_x, direction_y, direction_z)
	return vector(start.x + scale * direction_x, start.y + scale * direction_y, start.z + scale * direction_z)
end

local old_view = {
	0,
	0
}
local last_view = 0
local target_view_add = 0
local transition_int = 0
local transition_percent = 0

local function paint_handler()
	local menu_active = ui.get(active)
	if not menu_active then
		return
	end
	local me = entity.get_local_player()
	if not entity.is_alive(me) then
		return
	end
	local camera_angles = {
		client.camera_angles()
	}
	local Colors = {
		{
			255,
			0,
			0
		},
		{
			237,
			27,
			3
		},
		{
			235,
			63,
			6
		},
		{
			229,
			104,
			8
		},
		{
			228,
			126,
			10
		},
		{
			220,
			169,
			16
		},
		{
			213,
			201,
			19
		},
		{
			176,
			205,
			10
		},
		{
			124,
			195,
			13
		}
	}
	local math_num = function(int, max, declspec)
		local int = (int > max and max or int)
		local tmp = max / int
		if not declspec then
			declspec = max
		end
		local i = (declspec / tmp)
		i = (i >= 0 and math.floor(i + 0.5) or math.ceil(i - 0.5))
		return i
	end
	local get_color = function(number, max)
		local i = math_num(number, max, #Colors)
		return
            Colors[i <= 1 and 1 or i][1], 
            Colors[i <= 1 and 1 or i][2],
            Colors[i <= 1 and 1 or i][3],
        i
	end
	local rs, gs, bs = get_color(math.abs(anti_aim.get_desync(1)), 28)
	local screensize = {
		client.screen_size()
	}
	local screensizex2, screensizey2 = screensize[1] / 2, screensize[2] / 2
	local _, rotation = entity.get_prop(me, 'm_angAbsRotation')
	local body_yaw_aa = math.max(-60, math.min(60, round((entity.get_prop(me, 'm_flPoseParameter', 11) or 0) * 120 - 60 + 0.5, 1)))
	body_yaw_aa = (body_yaw_aa < 1 and body_yaw_aa > 0.0001) and math.floor(body_yaw_aa, 1) or body_yaw_aa
	if camera_angles[2] ~= nil and rotation ~= nil and 60 < math.abs(normalize_yaw(camera_angles[2] - (rotation + body_yaw_aa))) then
		body_yaw_aa = -body_yaw_aa
	end
	local body_yaw_sp = math.max(0, math.min(60, round((entity.get_prop(me, 'm_flPoseParameter', 11) or 0) * 120 - 60 + 0.5, 1))) / 3
	local body_yaw_sp2 = math.max(-60, math.min(0, round((entity.get_prop(me, 'm_flPoseParameter', 11) or 0) * 120 - 60 + 0.5, 1))) / 3
	local body_yaw = math.max(-60, math.min(60, round((entity.get_prop(nil, 'm_flPoseParameter', 11) or 0) * 120 - 60 + 0.5, 1))) / 7
	local body_yaw_abs = math.abs(body_yaw_aa)
	local inc = (1000 / 2) * globals.frametime()
	local transition_int = clamp(0, 100, active and transition_int + inc or transition_int - inc)
	local transition_percent = transition_int / 100
	local local_eye_position = eye_position(me)
	if camera_angles[2] ~= last_view then
		target_view_add = target_view_add + normalize_yaw(camera_angles[2] - last_view)
		last_view = camera_angles[2]
	end
	local view_origin = {
		local_eye_position[1],
		local_eye_position[2],
		local_eye_position[3]
	}
	local transition_origin = lerp(local_eye_position, view_origin, transition_percent)
	local head_pos = {
		entity.hitbox_position(me, 0)
	}
	local wts_head = {
		renderer.world_to_screen(head_pos[1], head_pos[2], head_pos[3])
	}
	if wts_head[1] == nil then
		return
	end
	local pos = {
		wts_head[1] ,
		wts_head[2]
	}
	local w, h = 150, 30
	local r, g, b, a = ui.get(color_picker)
	local a = ALPHA > a and a or ALPHA
	local shiftcolor = {
		168,
		168,
		168,
		200
	}
	local realtime = globals.realtime() / 2
	local alpha = math.floor(math.sin(realtime * 4) * (shiftcolor[4] / 2) + shiftcolor[4] / 2)
	local checkonshot = ui.get(onshotkey) and ui.get(onshot)
	local textOS = string.format('OS:')
	local textcheck = renderer.measure_text(nil, textOS)
	local textTick = string.format('     ')
	local textTickcheck = renderer.measure_text(nil, textTick)
	local onshot_color = function(onshot_value)
		if checkonshot then
			return {
				124,
				195,
				13
			}
		end
		return {
			255,
			60,
			80
		}
	end
	local pc = onshot_color(checkonshot)
	local cn = 1
	local by = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(1) - 120)
	local fy = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(2) - 120)
	if menu_active then
		local entities = entitylib.get_all("CPredictedViewModel")
		for _, entidx in ipairs(entities) do
			local vector_origin = vector(entidx:get_origin())
			local view_punch_angle = vector(entitylib.get_local_player():get_prop("m_vecOrigin"))
			local aim_punch_angle = vector(entitylib.get_local_player():get_prop("m_vecOrigin"))
			local camera_angles = vector(client.camera_angles())
			local forward = angle_forward(camera_angles)
			local right = angle_right(view_punch_angle + aim_punch_angle)
			vector_origin = vecotr_ma(vector_origin, 10, right.x, right.y, right.z)
			vector_origin = vecotr_ma(vector_origin, 30, forward.x, forward.y, forward.z)
			local w2s_pos = vector(renderer.world_to_screen(vector_origin.x, vector_origin.y, vector_origin.z))
			if ui.get(third) and ui.get(thirdkey) then
				renderer.rectangle(w2s_pos.x + 50, w2s_pos.y + 100, w, 2, r, g, b, ALPHA)
				if anti_aim.get_tickbase_shifting() and anti_aim.get_double_tap() then
					renderer.rectangle(w2s_pos.x + 50, w2s_pos.y + 100, w, 70, 17, 17, 17, a)
					renderer.line(pos[1], pos[2] + 70, w2s_pos.x + 50, w2s_pos.y + 70 + 100, 255, 255, 255, 100)
				else
					renderer.rectangle(w2s_pos.x + 50, w2s_pos.y + 100, w, 60, 17, 17, 17, a)
					renderer.line(pos[1], pos[2] + 60, w2s_pos.x + 50, w2s_pos.y + 60 + 100, 255, 255, 255, 100)
				end
				renderer.text(w2s_pos.x + 3 + 50, w2s_pos.y + 4 + 1 * cn + 100, 255, 255, 255, 255, '-', 0, 'ANTI-AIMBOTDEBUG'); cn = cn + 1
				renderer.circle_outline(w2s_pos.x + 133 + 50, w2s_pos.y + 9 * cn + 100, 15, 15, 15, 125, 8, 0, 1, 2)
				renderer.circle_outline(w2s_pos.x + 133 + 50, w2s_pos.y + 9 * cn + 100, 150, 150, 150, 220, 8, by, 0.05, 2)
				renderer.circle_outline(w2s_pos.x + 133 + 50, w2s_pos.y + 9 * cn + 100, 45, 220, 220, 255, 8, fy, 0.1, 2);cn = cn + 1
				renderer.gradient(w2s_pos.x + 5 + 50, w2s_pos.y + 10 * cn + 100, 2, body_yaw , rs, gs, bs, 255, 0, 0, 0, 0, false)
				renderer.gradient(w2s_pos.x + 5 + 50, w2s_pos.y + 10 * cn + 100, 2, -body_yaw , rs, gs, bs, 255, 0, 0, 0, 0, false)
				renderer.text(w2s_pos.x + 10 + 50, w2s_pos.y + 8 * cn + 100, 255, 255, 255, 255, '', 0, 'FAKE (' .. body_yaw_abs .. '°)'); cn = cn + 1
				renderer.text(w2s_pos.x + 9 + 50, w2s_pos.y + 10 * cn + 100, 255, 255, 255, 255, '-', 0, 'SP:')
				renderer.rectangle(w2s_pos.x + 25 + 50, w2s_pos.y + 11 * cn - 1 + 100, 21, 6, 0, 0, 0, 150)
				renderer.rectangle(w2s_pos.x + 50 + 50, w2s_pos.y + 11 * cn - 1 + 100, 21, 6, 0, 0, 0, 150)
				renderer.rectangle(w2s_pos.x + 26 + 50, w2s_pos.y + 11 * cn + 100, anti_aim.get_body_yaw(1) % 19, 4, 142, 165, 229, 255)
				renderer.rectangle(w2s_pos.x + 51 + 50, w2s_pos.y + 11 * cn + 100, anti_aim.get_body_yaw(2) % 19, 4, 142, 165, 229, 255)
				if anti_aim.get_tickbase_shifting() and anti_aim.get_double_tap() then
					renderer.text(w2s_pos.x + 9 + 50, w2s_pos.y + 39 + textcheck + 100, 255, 255, 255, alpha, '-', 0, 'SHIFTING TICKBASE')
					renderer.text(w2s_pos.x + 119 + 50, w2s_pos.y + 10 * cn + textTickcheck + 1 + 100, 255, 255, 255, 255, '-', 0, textOS)
					renderer.text(w2s_pos.x + 115 + textcheck + 50, w2s_pos.y + 10 * cn + textTickcheck + 1 + 100, pc[1], pc[2], pc[3], 255, '-', 0, checkonshot and 'ON' or 'OFF')
				else
					renderer.text(w2s_pos.x + 119 + 50, w2s_pos.y + 10 * cn + 100, 255, 255, 255, 255, '-', 0, textOS)
					renderer.text(w2s_pos.x + 115 + textcheck + 50, w2s_pos.y + 10 * cn + 100, pc[1], pc[2], pc[3], 255, '-', 0, checkonshot and 'ON' or 'OFF')
				end
			end
		end
	end
end

client.set_event_callback('paint', paint_handler)