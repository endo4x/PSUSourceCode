--[[
	id: BAywgQ5fXlnjZOC70NiF0
	name: QQ_Watermark
	description: QQ_Watermark
	time1: 2021-05-04 05:42:30.175361+00
	time2: 2021-05-04 05:42:30.175362+00
	uploader: 1928
	uploadersession: DLGgUHrAc4FzPyeougySgWEmSoT4iM
	flag: f
--]]

local success, images = pcall(require, 'gamesense/images')
if not success then error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=22917", 2) end

local http_success, http = pcall(require, 'gamesense/http')
if not http_success then error("Subscribe (HTTP Library) https://gamesense.pub/forums/viewtopic.php?id=19253", 2) end

local QQ = "897331069"
local avatar = ""

local url = string.format("https://q1.qlogo.cn/g?b=qq&nk=%d&s=640", QQ)
http.get(url, function(success, response)
    if not success or response.status ~= 200 then error("Failed!", 2) end
    avatar = response.body
end)

local playername = "Hana" --panorama.open().MyPersonaAPI.GetName()

local b = (function()
    local c = {}
    local d, e, f, g, h, i, j, k, l, m, n, o, p, q
    local r = {__index = {drag = function(self, ...)
                local s, t = self:get()
                local u, v = c.drag(s, t, ...)
                if s ~= u or t ~= v then
                    self:set(u, v)
                end
                return u, v
            end, set = function(self, s, t)
                local l, m = client.screen_size()
                ui.set(self.x_reference, s / l * self.res)
                ui.set(self.y_reference, t / m * self.res)
            end, get = function(self)
                local l, m = client.screen_size()
                return ui.get(self.x_reference) / self.res * l, ui.get(self.y_reference) / self.res * m
            end}}
    function c.new(w, x, y, z)
        z = z or 10000
        local l, m = client.screen_size()
        local A = ui.new_slider("LUA", "A", w .. " pos", 0, z, x / l * z)
        local B = ui.new_slider("LUA", "A", "\n" .. w .. " pos 2", 0, z, y / m * z)
        ui.set_visible(A, false)
        ui.set_visible(B, false)
        return setmetatable({name = w, x_reference = A, y_reference = B, res = z}, r)
    end
    function c.drag(s, t, C, D, E, F, G)
        if globals.framecount() ~= d then
            e = ui.is_menu_open()
            h, i = f, g
            f, g = ui.mouse_position()
            k = j
            j = client.key_state(0x01) == true
            o = n
            n = {}
            q = p
            p = false
            l, m = client.screen_size()
        end
        if e and k ~= nil then
            if (not k or q) and j and h > s and i > t and h < s + C and i < t + D then
                p = true
                s, t = s + f - h, t + g - i
                if not F then
                    s = math.max(0, math.min(l - C, s))
                    t = math.max(0, math.min(m - D, t))
                end
            end
        end
        table.insert(n, {s, t, C, D})
        return s, t, C, D
    end
    return c
end)()

local x, y = client.screen_size()
local H = b.new("Running WaterMarks", x - 475, 30)
local I = ui.new_checkbox("Config", "Presets", "Enabled WaterMark")
local J = ui.new_color_picker("Config", "Presets", "\n Watermark Color", 0, 255, 255, 255)
local L = ui.new_checkbox("Config", "Presets", "WaterMark Rainbows")
local M = ui.new_label("Config", "Presets", "WaterMark Format Colors")
local N = ui.new_color_picker("Config", "Presets", "\n Watermark Fonts Color", 255, 255, 255, 255)
local O = ui.new_checkbox("Config", "Presets", "WaterMark Lines Draw")
local P = 0
local Q = {}
local R = 0
ui.set(I, true)
local function S(j, u, x, c)
    local t, i, d
    local k = math.floor(j * 6)
    local h = j * 6 - k
    local r = x * (1 - u)
    local s = x * (1 - h * u)
    local v = x * (1 - (1 - h) * u)
    k = k % 6
    if k == 0 then
        t, i, d = x, v, r
    elseif k == 1 then
        t, i, d = s, x, r
    elseif k == 2 then
        t, i, d = r, x, v
    elseif k == 3 then
        t, i, d = r, s, x
    elseif k == 4 then
        t, i, d = v, r, x
    elseif k == 5 then
        t, i, d = x, r, s
    end
    return t * 255, i * 255, d * 255, c * 255
end
local function T(U, V)
    local t, i, d, c = S(globals.realtime() * U, 1, 1, 1)
    t = t * V
    i = i * V
    d = d * V
    return t, i, d
end
local function W()
    local X, Y = globals.realtime(), globals.absoluteframetime()
    if Y > 0 then
        table.insert(Q, 1, Y)
    end
    local Z = #Q
    if Z == 0 then
        return 0
    end
    local _ = 0
    local k = 0
    while _ < 0.5 do
        k = k + 1
        _ = _ + Q[k]
        if k >= Z then
            break
        end
    end
    _ = _ / k
    while k < Z do
        k = k + 1
        table.remove(Q)
    end
    local a0 = 1 / _
    local a1 = X - R
    if math.abs(a0 - P) > 4 or a1 > 1 then
        P = a0
        R = X
    else
        a0 = P
    end
    return math.floor(a0 + 0.5)
end

client.set_event_callback("paint_ui", function(g)
        ui.set_visible(M, ui.get(I))
        ui.set_visible(N, ui.get(I))
        ui.set_visible(J, ui.get(I) and not ui.get(L))
        if not ui.get(I) then return end
        local a2, a3 = H:get()
        local a4, a5, a6, a7 = ui.get(J)
        local a8, a9, aa, ab = ui.get(N)
        local ac, ad, ae = T(2 / 10, 1)

        local af = { client.system_time() }
        if avatar:len() < 1000 then return end
        local ak = images.load(avatar)
        local ag = string.format("%02d:%02d", af[1], af[2])
        local ai = "[Gamesense] Welcome: " .. playername .. " | FPS: " .. W() .. " | Time: " .. ag
        local aj = renderer.measure_text(nil, ai) + 3
        --renderer.circle_outline(a2 + 10, a3 + 15, 40, 40, 17, 255, 30, 0, 1, 2)
        renderer.rectangle(a2 - 65, a3 - 8, 110, 110, 17, 17, 17, 255)
        renderer.rectangle(a2 + 20, a3 + 30, aj + 60, 30, 17, 17, 17, 255)
        renderer.text(a2 + 45, a3 + 39, a8, a9, aa, ab, "b", 0, ai)
        if ui.get(O) then
            renderer.gradient(
                a2 + 45,
                a3 + 30,
                aj + 34,
                1,
                ui.get(L) and ac or a4,
                ui.get(L) and ad or a5,
                ui.get(L) and ae or a6,
                ui.get(L) and 255 or a7,
                ui.get(L) and ae or a4,
                ui.get(L) and ad or a5,
                ui.get(L) and ac or a6,
                ui.get(L) and 255 or a7,
                true)
            renderer.gradient(
                a2 + 45,
                a3 + 60,
                aj + 34,
                1,
                ui.get(L) and ae or a4,
                ui.get(L) and ad or a5,
                ui.get(L) and ac or a6,
                ui.get(L) and 255 or a7,
                ui.get(L) and ac or a4,
                ui.get(L) and ad or a5,
                ui.get(L) and ae or a6,
                ui.get(L) and 255 or a7,
                true)
            renderer.gradient(
                a2 + aj + 65 + 14,
                a3 + 30,
                1,
                31,
                ui.get(L) and ae or a4,
                ui.get(L) and ad or a5,
                ui.get(L) and ac or a6,
                ui.get(L) and 255 or a7,
                ui.get(L) and ae or a4,
                ui.get(L) and ad or a5,
                ui.get(L) and ac or a6,
                ui.get(L) and 255 or a7,
                true)
        end
    ak:draw(a2 - 60, a3 - 3, nil, 100)
    H:drag(aj + 10, 40)
end)