--[[
	id: eYRCnGhR87DVJ8R4EM3-8
	name: AA (2).lua
	description: AA (2).lua
	time1: 2021-05-07 11:54:07.772376+00
	time2: 2021-05-07 11:54:07.772376+00
	uploader: KJx65YCFVQjSZlf0LyNIEoPj1prkYDaiVO2NQJKT
	uploadersession: sRDkW1RM9GuHmeTSdfgfKu38rWgJY5
	flag: f
--]]

--local variables for API functions. Generated using https://github.com/sapphyrus/gamesense-lua/blob/master/generate_api.lua
local notify = {}
notify.__index = notify
notify.invoke_callback = function(timeout)
    return setmetatable({active = false, delay = 0, laycoffset = -11, layboffset = -11}, notify)
end
notify.setup_color = function(color, sec_color)
    if type(color) ~= "table" then
        notify:setup()
        return
    end
    if notify.color == nil then
        notify:setup()
    end
    if color ~= nil then
        notify.color[1] = color
    end
    if sec_color ~= nil then
        notify.color[2] = sec_color
    end
end
notify.add = function(time, is_right, ...)
    if notify.color == nil then
        notify:setup()
    end
    table.insert(
        notify.__list,
        {
            ["tick"] = globals.tickcount(),
            ["invoke"] = notify.invoke_callback(),
            ["text"] = {...},
            ["time"] = time,
            ["color"] = notify.color,
            ["right"] = is_right,
            ["first"] = false
        }
    )
end
function notify:setup()
    notify.color = {{0, 150, 255}, {0, 0, 0}}
    if notify.__list == nil then
        notify.__list = {}
        client.delay_call(
            0.05,
            function()
            end
        )
    end
end
function notify:listener()
    local count_left = 0
    local count_right = 0
    local old_tick = 0
    if notify.__list == nil then
        notify:setup()
    end
    for i = 1, #notify.__list do
        local layer = notify.__list[i]
        if layer.tick ~= old_tick then
            notify:setup()
        end
        if layer.right == true then
            layer.invoke:show_right(count_right, layer.color, layer.text)
            if layer.invoke.active then
                count_right = count_right + 1
            end
        else
            layer.invoke:show(count_left, layer.color, layer.text)
            if layer.invoke.active then
                count_left = count_left + 1
            end
        end
        if layer.first == false then
            layer.invoke:start(layer.time)
            notify.__list[i]["first"] = true
        end
        old_tick = layer.tick
    end
end
function notify:start(timeout)
    self.active = true
    self.delay = globals.realtime() + timeout
end
function notify:get_text_size(lines_combo)
    local x_offset_text = 0
    for i = 1, #lines_combo do
        local r, g, b, message = unpack(lines_combo[i])
        local width, height = renderer.measure_text("", message)
        x_offset_text = x_offset_text + width
    end
    return x_offset_text
end
function notify:string_ends_with(str, ending)
    return ending == "" or str:sub(-(#ending)) == ending
end
function notify:multicolor_text(x, y, flags, lines_combo)
    local line_height_temp = 0
    local x_offset_text = 0
    local y_offset = 0
    for i = 1, #lines_combo do
        local r, g, b, message = unpack(lines_combo[i])
        message = message .. "\0"
        renderer.text(x + x_offset_text, y + y_offset, r, g, b, 255, flags, 0, message)
        if self:string_ends_with(message, "\0") then
            local width, height = renderer.measure_text(flags, message)
            x_offset_text = x_offset_text + width
        else
            x_offset_text = 0
            y_offset = y_offset + line_height_temp
        end
    end
end
function notify:show(count, color, text)
    if self.active ~= true then
        return
    end
    local x, y = client.screen_size()
    local y = 5 + (27 * count)
    local text_w, text_h = self:get_text_size(text)
    local max_width = text_w
    local max_width = max_width < 150 and 150 or max_width
    if color == nil then
        color = self.color
    end
    local factor = 255 / 25 * globals.frametime()
    if globals.realtime() < self.delay then
        if self.laycoffset < max_width then
            self.laycoffset = self.laycoffset + (max_width - self.laycoffset) * factor
        end
        if self.laycoffset > max_width then
            self.laycoffset = max_width
        end
        if self.laycoffset > max_width / 1.09 then
            if self.layboffset < max_width - 6 then
                self.layboffset = self.layboffset + ((max_width - 6) - self.layboffset) * factor
            end
        end
        if self.layboffset > max_width - 6 then
            self.layboffset = max_width - 6
        end
    else
        if self.layboffset > -11 then
            self.layboffset = self.layboffset - (((max_width - 5) - self.layboffset) * factor) + 0.01
        end
        if self.layboffset < (max_width - 11) and self.laycoffset >= 0 then
            self.laycoffset = self.laycoffset - (((max_width + 1) - self.laycoffset) * factor) + 0.01
        end
        if self.laycoffset < 0 then
            self.active = false
        end
    end
    renderer.rectangle(
        self.laycoffset - self.laycoffset,
        y,
        self.laycoffset + 16,
        25,
        color[1][1],
        color[1][2],
        color[1][3],
        255
    )
    renderer.rectangle(
        self.layboffset - self.laycoffset,
        y,
        self.layboffset + 22,
        25,
        color[2][1],
        color[2][2],
        color[2][3],
        255
    )
    self:multicolor_text(self.layboffset - max_width + 11, y + 6, "", text)
end
function notify:show_right(count, color, text)
    if self.active ~= true then
        return
    end
    local x, y = client.screen_size()
    local y = 1 + (26 * count)
    local text_w, text_h = self:get_text_size(text)
    local max_width = text_w + 22
    local max_width = max_width < 150 and 150 or max_width
    if color == nil then
        color = self.color
    end
    local factor = 255 / 25 * globals.frametime()
    if globals.realtime() < self.delay then
        if self.laycoffset < max_width then
            self.laycoffset = self.laycoffset + (max_width - self.laycoffset) * factor
        end
        if self.laycoffset > max_width then
            self.laycoffset = max_width
        end
        if self.laycoffset > max_width / 1.09 then
            if self.layboffset < max_width - 6 then
                self.layboffset = self.layboffset + ((max_width - 6) - self.layboffset) * factor
            end
        end
        if self.layboffset > max_width - 6 then
            self.layboffset = max_width - 6
        end
    else
        if self.layboffset > 0 then
            self.layboffset = self.layboffset - (((max_width - 5) - self.layboffset) * factor) + 0.01
        end
        if self.layboffset < (max_width - 11) and self.laycoffset >= 0 then
            self.laycoffset = self.laycoffset - (((max_width + 1) - self.laycoffset) * factor) + 0.01
        end
        if self.laycoffset < 0 then
            self.active = false
        end
    end
    renderer.gradient(
        x - self.laycoffset + 3,
        y,
        self.laycoffset + 3 + self.laycoffset,
        25,
        0,
        120,
        255,
        255,
        255,
        0,
        255,
        255,
        true
    )
    self:multicolor_text(x - self.layboffset + 10, y + 6, "", text)
end
local client_userid_to_entindex,
    client_set_event_callback,
    client_screen_size,
    client_trace_bullet,
    client_unset_event_callback,
    client_color_log,
    client_reload_active_scripts,
    client_scale_damage,
    client_get_cvar,
    client_camera_position,
    client_create_interface,
    client_random_int,
    client_latency,
    client_set_clan_tag,
    client_find_signature,
    client_log,
    client_timestamp,
    client_delay_call,
    client_trace_line,
    client_register_esp_flag,
    client_get_model_name,
    client_system_time,
    client_visible,
    client_exec,
    client_key_state,
    client_set_cvar,
    client_unix_time,
    client_error_log,
    client_draw_debug_text,
    client_update_player_list,
    client_camera_angles,
    client_eye_position,
    client_draw_hitboxes,
    client_random_float =
    client.userid_to_entindex,
    client.set_event_callback,
    client.screen_size,
    client.trace_bullet,
    client.unset_event_callback,
    client.color_log,
    client.reload_active_scripts,
    client.scale_damage,
    client.get_cvar,
    client.camera_position,
    client.create_interface,
    client.random_int,
    client.latency,
    client.set_clan_tag,
    client.find_signature,
    client.log,
    client.timestamp,
    client.delay_call,
    client.trace_line,
    client.register_esp_flag,
    client.get_model_name,
    client.system_time,
    client.visible,
    client.exec,
    client.key_state,
    client.set_cvar,
    client.unix_time,
    client.error_log,
    client.draw_debug_text,
    client.update_player_list,
    client.camera_angles,
    client.eye_position,
    client.draw_hitboxes,
    client.random_float
local entity_get_local_player,
    entity_is_enemy,
    entity_get_bounding_box,
    entity_get_all,
    entity_set_prop,
    entity_is_alive,
    entity_get_steam64,
    entity_get_classname,
    entity_get_player_resource,
    entity_get_esp_data,
    entity_is_dormant,
    entity_get_player_name,
    entity_get_game_rules,
    entity_get_origin,
    entity_hitbox_position,
    entity_get_player_weapon,
    entity_get_players,
    entity_get_prop =
    entity.get_local_player,
    entity.is_enemy,
    entity.get_bounding_box,
    entity.get_all,
    entity.set_prop,
    entity.is_alive,
    entity.get_steam64,
    entity.get_classname,
    entity.get_player_resource,
    entity.get_esp_data,
    entity.is_dormant,
    entity.get_player_name,
    entity.get_game_rules,
    entity.get_origin,
    entity.hitbox_position,
    entity.get_player_weapon,
    entity.get_players,
    entity.get_prop
local globals_realtime,
    globals_absoluteframetime,
    globals_chokedcommands,
    globals_oldcommandack,
    globals_tickcount,
    globals_commandack,
    globals_lastoutgoingcommand,
    globals_curtime,
    globals_mapname,
    globals_tickinterval,
    globals_framecount,
    globals_frametime,
    globals_maxplayers =
    globals.realtime,
    globals.absoluteframetime,
    globals.chokedcommands,
    globals.oldcommandack,
    globals.tickcount,
    globals.commandack,
    globals.lastoutgoingcommand,
    globals.curtime,
    globals.mapname,
    globals.tickinterval,
    globals.framecount,
    globals.frametime,
    globals.maxplayers
local ui_new_slider,
    ui_new_combobox,
    ui_reference,
    ui_set_visible,
    ui_new_textbox,
    ui_new_color_picker,
    ui_new_checkbox,
    ui_mouse_position,
    ui_new_listbox,
    ui_new_multiselect,
    ui_is_menu_open,
    ui_new_hotkey,
    ui_set,
    ui_update,
    ui_menu_size,
    ui_name,
    ui_menu_position,
    ui_set_callback,
    ui_new_button,
    ui_new_label,
    ui_new_string,
    ui_get =
    ui.new_slider,
    ui.new_combobox,
    ui.reference,
    ui.set_visible,
    ui.new_textbox,
    ui.new_color_picker,
    ui.new_checkbox,
    ui.mouse_position,
    ui.new_listbox,
    ui.new_multiselect,
    ui.is_menu_open,
    ui.new_hotkey,
    ui.set,
    ui.update,
    ui.menu_size,
    ui.name,
    ui.menu_position,
    ui.set_callback,
    ui.new_button,
    ui.new_label,
    ui.new_string,
    ui.get
local dragging =
    (function()
    local a = {}
    local b, c, d, e, f, g, h, i, j, k, l, m, n, o
    local p = {
        __index = {
            drag = function(self, ...)
                local q, r = self:get()
                local s, t = a.drag(q, r, ...)
                if q ~= s or r ~= t then
                    self:set(s, t)
                end
                return s, t
            end,
            set = function(self, q, r)
                local j, k = client.screen_size()
                ui.set(self.x_reference, q / j * self.res)
                ui.set(self.y_reference, r / k * self.res)
            end,
            get = function(self)
                local j, k = client.screen_size()
                return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
            end
        }
    }
    function a.new(u, v, w, x)
        x = x or 10000
        local j, k = client.screen_size()
        local y = ui.new_slider("LUA", "A", u .. " window position", 0, x, v / j * x)
        local z = ui.new_slider("LUA", "A", "\n" .. u .. " window position y", 0, x, w / k * x)
        ui.set_visible(y, false)
        ui.set_visible(z, false)
        return setmetatable({name = u, x_reference = y, y_reference = z, res = x}, p)
    end
    function a.drag(q, r, A, B, C, D, E)
        if globals.framecount() ~= b then
            c = ui.is_menu_open()
            f, g = d, e
            d, e = ui.mouse_position()
            i = h
            h = client.key_state(0x01) == true
            m = l
            l = {}
            o = n
            n = false
            j, k = client.screen_size()
        end
        if c and i ~= nil then
            if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                n = true
                q, r = q + d - f, r + e - g
                if not D then
                    q = math.max(0, math.min(j - A, q))
                    r = math.max(0, math.min(k - B, r))
                end
            end
        end
        table.insert(l, {q, r, A, B})
        return q, r, A, B
    end
    return a
end)()

--end of local variables
--skyness#4221
--skyness#4221
--skyness#4221
--逻辑套用
local me = entity_get_local_player()
local success, surface = pcall(require, "gamesense/surface")
local anti_aim = require "gamesense/antiaim_funcs"
local surface_measure_text, surface_draw_text = surface.measure_text, surface.draw_text
if not success then
    error("\n\n - 滚去订阅数据库 \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n")
end
if not anti_aim then
    error("\n\n - 滚去订阅数据库 \n - https://gamesense.pub/forums/viewtopic.php?id=29665\n")
end
local verdana = surface.create_font("verdana", 12, 400, {0x200 --[[ Outline ]]})
local verdana2 = surface.create_font("Bahnschrift", 13, 400, {0x200 --[[ Outline ]]})
local verdana3 = surface.create_font("verdana", 13, 400, {0x200 --[[ Outline ]]})
local verdana4 = surface.create_font("verdana", 18, 700, {0x80 --[[ Outline ]]})
local custom_font = surface.create_font("Small Pixel", 8, 400, {0x200 --[[ Outline ]]})
local custom_font1 = surface.create_font("Small Pixel", 14, 400, {0x200 --[[ Outline ]]})
--lua抬头指标
local function draw_container(x, y, w, h, header, a)
    local c = {10, 60, 40, 40, 40, 60, 20}

    for i = 0, 6, 1 do
        renderer.rectangle(x + i, y + i, w - (i * 2), h - (i * 2), c[i + 1], c[i + 1], c[i + 1], a)
    end

    if header then
        local x_inner, y_inner = x + 7, y + 7
        local w_inner = w - 14

        renderer.gradient(x_inner, y_inner - 1, math.floor(w_inner / 2), 1, m_r, m_g, m_b, a, mt_r, mt_g, mt_b, a, true)
        renderer.gradient(
            x_inner + math.floor(w_inner / 2),
            y_inner - 1,
            math.ceil(w_inner / 2),
            1,
            mt_r,
            mt_g,
            mt_b,
            a,
            m_r,
            m_g,
            m_b,
            a,
            true
        )

        local a_lower = a
        renderer.gradient(
            x_inner,
            y_inner,
            math.floor(w_inner / 2),
            1,
            59,
            175,
            222,
            a_lower,
            202,
            70,
            205,
            a_lower,
            true
        )
        renderer.gradient(
            x_inner + math.floor(w_inner / 2),
            y_inner,
            math.ceil(w_inner / 2),
            1,
            202,
            70,
            205,
            a_lower,
            201,
            227,
            58,
            a_lower,
            true
        )
    end
end

function skyness_menu_addtitions()
    local scrsize_x, scrsize_y = client.screen_size()
    local center_x, center_y = scrsize_x / 2, scrsize_y / 2
    local scrleft_x, scrleft_y = ((scrsize_x - scrsize_x) + 1), ((scrsize_y - scrsize_y) + 1)
    local c = {10, 60, 40, 40, 40, 60, 20}
    local menu_x, menu_y = ui.menu_position()
    local mouse_x, mouse_y = ui.mouse_position()
    local menu_w, menu_h = ui.menu_size()
    local h = 54
    local conmid_x, conmid_y = (menu_x + (menu_w / 2)), menu_y - h / 2
    if ui.is_menu_open() then
        draw_container(menu_x, menu_y - h, menu_w, h - 4, true, 255)
        client.draw_text(c, conmid_x, conmid_y - 2, 59, 175, 222, 255, "bc+", 0, "404 PROJECT V5")
        client.draw_text(
            c,
            (menu_x + menu_w) - 59,
            conmid_y + 6,
            201,
            227,
            58,
            255,
            "bc-",
            0,
            "welcome,",
            entity.get_player_name(me)
        )
        client.draw_text(c, (menu_x) + 70, conmid_y + 6, 202, 70, 205, 255, "bc-", 0, "What's done is done.")
    end
end
client.set_event_callback("paint_ui", skyness_menu_addtitions)

-- LUA library requirements
local http = require "gamesense/http"
local images = require "gamesense/images"
require "bit"
--[[
    Menu items
]]
local override_antiaim = ui_new_checkbox("AA", "Anti-aimbot angles", " » Cmon this is the best aa lua -_-")
label1 = ui_new_label("AA", "Anti-aimbot angles", "(●)AA FUNCTIONS")
local adaptive_fs = ui_new_checkbox("AA", "Anti-aimbot angles", "Ideal body yaw freestanding")
local manual_aa = ui_new_checkbox("AA", "Anti-aimbot angles", "Manual anti-aim")
local manual_aa_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Override anti-aim", 255, 255, 255, 255)
local manual_left = ui_new_hotkey("AA", "Anti-aimbot angles", " < Override manual left")
local manual_right = ui_new_hotkey("AA", "Anti-aimbot angles", " > Override manual right")
local manual_back = ui_new_hotkey("AA", "Anti-aimbot angles", " v Override manual back")
local manual_state = ui_new_slider("AA", "Anti-aimbot angles", "Manual direction", 0, 2, 0)
local change_aa = ui_new_checkbox("AA", "Anti-aimbot angles", "Slow motion dodge")
local aa_on_key =
    ui_new_combobox(
    "AA",
    "Anti-aimbot angles",
    "Dodge anti-aim motion",
    {"Static", "Low delta", "Random delta", "High delta"}
)
local change_aa_on_key = ui.new_hotkey("AA", "Anti-aimbot angles", "Dodge keybind", true)
local legit_aa_use = ui_new_checkbox("AA", "Anti-aimbot angles", "Legit anti-aim on use key")
local legit_aa_on_key = ui.new_hotkey("AA", "Anti-aimbot angles", "Legit anti-aim rebind")
local eyeyaw_dt = ui_new_checkbox("AA", "Anti-aimbot angles", "Force eye yaw on DT")
label2 = ui_new_label("AA", "Anti-aimbot angles", "(●)MISC FUNCTIONS")
local enable_slide = ui.new_checkbox("AA", "Anti-aimbot angles", "Better leg movement")
local fake_up = ui.new_checkbox("AA", "Anti-aimbot angles", "Fake up on land")
local backtrack = ui.new_checkbox("AA", "Anti-aimbot angles", "Extented backtrack")
local anti_knife = ui.new_checkbox("AA", "Anti-aimbot angles", "Anti-knife")
local hide_default_inds = ui_new_checkbox("AA", "Anti-aimbot angles", "Hide default indicators")
local projecttag_enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "404 clan tag")
local duration = 40
local clantags = {
    "     [404 YAW]",
    "     [404 YAW]",
    "     [404 YAW]",
    " |             ",
    " 4|             ",
    " 40|             ",
    " 404|             ",
    " 404 |             ",
    " 404 p|             ",
    " 404 pr|             ",
    " 404 pro|             ",
    " 404 proj|             ",
    " 404 proje|             ",
    " 404 projec|             ",
    " 404 project|             ",
    " 404 project |             ",
    " 404 project |             ",
    " 404 project|             ",
    " 404 projec|             ",
    " 404 proje|             ",
    " 404 proj|             ",
    " 404 pro|             ",
    " 404 pr|             ",
    " 404 p|             ",
    " 404 |             ",
    " 404|             ",
    " 40|             ",
    " 4|             ",
    " |             ",
    "     [404 YAW]",
    "     [404 YAW]",
    "     [404 YAW]"
}
label3 = ui_new_label("AA", "Anti-aimbot angles", "(●)VISUAL FUNCTIONS")
local manual_arrows = ui_new_checkbox("AA", "Anti-aimbot angles", "Manual aa indicators")
local side_arrows = ui_new_checkbox("AA", "Anti-aimbot angles", "Body yaw arrows")
local side_arrows_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Body yaw arrows color", 255, 255, 255, 255)
local on_peek_arrows = ui_new_checkbox("AA", "Anti-aimbot angles", "On peek indicators")
local on_peek_arrows_clr =
    ui_new_color_picker("AA", "Anti-aimbot angles", "On peek indicators color", 255, 255, 255, 255)
local indicator_arrow =
    ui_new_combobox("AA", "Anti-aimbot angles", "Crosshair indicators style", {"Style 1", "Style 2", "Style 3"})
local arrows_offset = ui.new_slider("AA", "Anti-aimbot angles", "Arrows distance", -20, 60, 10)
local indicator_type = ui_new_combobox("AA", "Anti-aimbot angles", "Indicator type", "Right crosshair")
local font_type = ui_new_combobox("AA", "Anti-aimbot angles", "Font style", {"Style 1", "Style 2", "Style 3"})
local indicators =
    ui_new_multiselect(
    "AA",
    "Anti-aimbot angles",
    "Indicator list",
    "Yaw status",
    "Doubletap",
    "Min damage",
    "Fakeduck",
    "Hideshots",
    "Force body aim",
    "Force safepoint",
    "Backtrack",
    "Desync"
)
local indicator_info_clr = ui_new_color_picker("AA", "Anti-aimbot angles", "Indicator color1", 255, 255, 255, 255)
local indicator_info_clr1 = ui_new_color_picker("AA", "Anti-aimbot angles", "Indicator color2", 255, 255, 255, 255)
local indicators_offset = ui.new_slider("AA", "Anti-aimbot angles", "Indicators distance", -20, 60, 10)
local fps_prev = 0
local frametimes = {}
local last_update_time = 0
--加载提示
showed_welcome, welcome_curtime = false, 0
local BR0KENz = {
    logs = {}
}
function insert_log(text)
    if globals.realtime() - welcome_curtime > 6 and showed_welcome then
        table.insert(BR0KENz.logs, {["log_text"] = text, ["time"] = globals.realtime()})
    end
end
local screenx, screeny = client.screen_size()
function clamp(...)
    local s = {...}
    table.sort(s)
    return s[2]
end
local function clamp(min, max, value)
    if min < max then
        return math.min(max, math.max(min, value))
    else
        return math.min(min, math.max(max, value))
    end
end

local function hsv_to_rgb(h, s, v, a)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6

    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    elseif i == 5 then
        r, g, b = v, p, q
    end

    return r * 255, g * 255, b * 255, a * 255
end

local function func_rgb_rainbowize(frequency, rgb_split_ratio)
    local r, g, b, a = hsv_to_rgb(globals.realtime() * frequency, 1, 1, 1)
    r = r * rgb_split_ratio
    g = g * rgb_split_ratio
    b = b * rgb_split_ratio
    return r, g, b
end

local function accumulate_fps()
    local rt, ft = globals.realtime(), globals.absoluteframetime()
    if ft > 0 then
        table.insert(frametimes, 1, ft)
    end

    local count = #frametimes
    if count == 0 then
        return 0
    end

    local accum = 0
    local i = 0
    while accum < 0.5 do
        i = i + 1
        accum = accum + frametimes[i]
        if i >= count then
            break
        end
    end

    accum = accum / i
    while i < count do
        i = i + 1
        table.remove(frametimes)
    end

    local fps = 1 / accum
    local time_since_update = rt - last_update_time
    if math.abs(fps - fps_prev) > 4 or time_since_update > 1 then
        fps_prev = fps
        last_update_time = rt
    else
        fps = fps_prev
    end

    return math.floor(fps + 0.5)
end
local ffi = require("ffi")
local raw_engine = client.create_interface("engine.dll", "VEngineClient014")
local engine = ffi.cast(ffi.typeof("void***"), raw_engine)[0]

ffi.cdef [[
    typedef void* (__thiscall* get_net_channel)(void*);
    typedef float (__thiscall* get_avg_loss)(void*, int);
    typedef float (__thiscall* get_avg_data)(void*, int);
]]

local get_loss = function()
    local raw_net = ffi.cast("get_net_channel", engine[78])(raw_engine)
    if not raw_net then
        return 0.0
    end

    local net = ffi.cast(ffi.typeof("void***"), raw_net)[0]
    local loss = 0.0

    loss = loss + ffi.cast("get_avg_loss", net[11])(raw_net, 0)
    loss = loss + ffi.cast("get_avg_loss", net[11])(raw_net, 1)

    return loss * 100
end

client.set_event_callback(
    "paint",
    function()
        local w, h = client_screen_size()
        if ui.get(override_antiaim) then
            local loss = math.floor(get_loss() + 0.5)
            local rainbow_r, rainbow_g, rainbow_b = func_rgb_rainbowize((2 / 10), 1)
            local rainbow_r1, rainbow_g1, rainbow_b1 = func_rgb_rainbowize((1 / 10), 1)
            local system_time = {client.system_time()}
            local steam_avatar = images.get_steam_avatar(entity.get_steam64(entity.get_local_player()))
            local actual_time = string.format("%02d:%02d:%02d", system_time[1], system_time[2], system_time[3])
            local ping_spike_value = string.format("%.f", math.min(999, client.latency() * 1000))
            local text = "[404 project] User: Inap  <admin> | Update: 2021/4/24"
            local text1 =
                "PING  :  " ..
                ping_spike_value ..
                    "  LOSS  :  " .. loss .. "  FPS  :  " .. accumulate_fps() .. "  TIME  :  " .. actual_time
            local height = renderer.measure_text(nil, text)
            surface_draw_text(w / 2 - 160, h / 2 + 15 + 500, rainbow_r1, rainbow_g1, rainbow_b1, 255, verdana3, text)
            renderer.gradient(
                w / 2 - 165,
                h / 2 + 6 + 500,
                height + 65,
                1,
                rainbow_r,
                rainbow_g,
                rainbow_b,
                255,
                rainbow_b,
                rainbow_g,
                rainbow_r,
                255,
                true
            )
            renderer.gradient(
                w / 2 - 165,
                h / 2 + 36 + 500,
                height + 65,
                1,
                rainbow_b,
                rainbow_g,
                rainbow_r,
                255,
                rainbow_r,
                rainbow_g,
                rainbow_b,
                255,
                true
            )
            renderer.gradient(
                w / 2 - 205 + height + 105,
                h / 2 + 6 + 500,
                1,
                31,
                rainbow_b,
                rainbow_g,
                rainbow_r,
                255,
                rainbow_b,
                rainbow_g,
                rainbow_r,
                255,
                true
            )
            renderer.gradient(
                w / 2 - 165,
                h / 2 + 6 + 500,
                1,
                31,
                rainbow_r,
                rainbow_g,
                rainbow_b,
                255,
                rainbow_b,
                rainbow_g,
                rainbow_r,
                255,
                true
            )
            local height1 = renderer.measure_text(nil, text1)
            surface_draw_text(w / 2 - 170, h / 2 + 480, rainbow_g, rainbow_r, rainbow_b, 255, custom_font1, text1)
        end
    end
)

--[[
    Menu references
]]
ref_md = ui_reference("RAGE", "Aimbot", "Minimum damage")
ref_sp_key = ui_reference("RAGE", "Aimbot", "Force SAFE point")
ref_baim_key = ui_reference("RAGE", "Other", "Force body aim")
ref_fd = ui_reference("RAGE", "Other", "Duck peek assist")
ref_dt, ref_dt_key = ui_reference("RAGE", "Other", "Double tap")
ref_dt_mode = ui_reference("RAGE", "Other", "Double tap mode")
ref_dt_hc = ui_reference("RAGE", "Other", "Double tap hit chance")
ref_dt_fl = ui_reference("RAGE", "Other", "Double tap fake lag limit")
ref_pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch")
ref_yaw, ref_yawadd = ui_reference("AA", "Anti-aimbot angles", "Yaw")
ref_yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base")
ref_yawj, ref_yawjadd = ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")
edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
ref_bodyyaw, ref_bodyyawadd = ui_reference("AA", "Anti-aimbot angles", "Body yaw")
ref_fs_bodyyaw = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
ref_lby_target = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target")
ref_fakelimit = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit")
ref_free, ref_freekey = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
ref_hs, ref_hs_key = ui_reference("AA", "Other", "On shot anti-aim")
ref_fl = ui_reference("AA", "Fake lag", "Enabled")
ref_fl_amt = ui_reference("AA", "Fake lag", "Amount")
ref_fl_var = ui_reference("AA", "Fake lag", "Variance")
ref_fl_limit = ui_reference("AA", "Fake lag", "Limit")
mindmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
ref_maxprocessticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
default_reference = ui.reference("MISC", "Miscellaneous", "Clan tag spammer")
dt_hit_chance = ui.reference("RAGE", "Other", "Double tap hit chance")
fakelag = ui.reference("AA", "Fake lag", "Limit")
ping, pinghotkey, pingslider = ui.reference("Misc", "Miscellaneous", "Ping spike")
ground_ticks, end_time = 1, 0

--组名
--组名
local clantag_prev
function run_tag_animation()
    if ui.get(projecttag_enabled) then
        local cur = math.floor(globals.tickcount() / duration) % #clantags
        local clantag = clantags[cur + 1]

        if clantag ~= clantag_prev then
            clantag_prev = clantag
            client.set_clan_tag(clantag)
        end
    end
end

client.set_event_callback(
    "run_command",
    function(c)
        chokedcmds = c.chokedcommands
    end
)

local was_enabled = false
local function on_run_command(c)
    if ui.get(projecttag_enabled) then
        if (chokedcmds == 0) or not (entity.is_alive(entity.get_local_player())) then
            run_tag_animation()
            was_enabled = true
        end
    elseif (not ui.get(projecttag_enabled) and not ui.get(default_reference)) and was_enabled then
        client.set_clan_tag("\0")
        was_enabled = false
    end
end
client.set_event_callback("paint", on_run_command)

local best_enemy = nil

local brute = {
    yaw_status = "4 0 4",
    indexed_angle = 0,
    last_miss = 0,
    best_angle = 0,
    misses = {},
    hit_reverse = {}
}

local function includes(table, key)
    for i = 1, #table do
        if table[i] == key then
            return true
        end
    end
    return false
end

local wnd = {
    x = database.read("dt_x") or 250,
    y = database.read("dt_y") or 25,
    w = 150,
    dragging = false,
    rx = 0
}

local function normalize_yaw(yaw)
    while yaw > 180 do
        yaw = yaw - 360
    end
    while yaw < -180 do
        yaw = yaw + 360
    end
    return yaw
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
    local ydelta = local_y - enemy_y
    local xdelta = local_x - enemy_x
    local relativeyaw = math.atan(ydelta / xdelta)
    relativeyaw = normalize_yaw(relativeyaw * 180 / math.pi)
    if xdelta >= 0 then
        relativeyaw = normalize_yaw(relativeyaw + 180)
    end
    return relativeyaw
end

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then
        return 0
    end

    return math.deg(math.atan2(y, x))
end

local vec_3 = function(_x, _y, _z)
    return {x = _x or 0, y = _y or 0, z = _z or 0}
end

local function angle_vector(angle_x, angle_y)
    local sy = math.sin(math.rad(angle_y))
    local cy = math.cos(math.rad(angle_y))
    local sp = math.sin(math.rad(angle_x))
    local cp = math.cos(math.rad(angle_x))
    return cp * cy, cp * sy, -sp
end

local function get_damage(me, enemy, x, y, z)
    local ex = {}
    local ey = {}
    local ez = {}
    ex[0], ey[0], ez[0] = entity_hitbox_position(enemy, 1)
    ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
    ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
    ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
    ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
    ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
    ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
    local bestdamage = 0
    local bent = nil
    for i = 0, 6 do
        local ent, damage = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
        if damage > bestdamage then
            bent = ent
            bestdamage = damage
        end
    end
    return bent == nil and client_scale_damage(me, 1, bestdamage) or bestdamage
end

local function is_auto_vis(local_player, lx, ly, lz, px, py, pz)
    entindex, dmg = client_trace_bullet(local_player, lx, ly, lz, px, py, pz)
    if entindex == nil then
        return false
    end
    if entindex == local_player then
        return false
    end
    if not entity_is_enemy(entindex) then
        return false
    end
    if dmg > ref_md then
        return true
    else
        return false
    end
end

local function trace_positions(px, py, pz, px1, py1, pz1, px2, py2, pz2, lx2, ly2, lz2)
    if is_auto_vis(local_player, lx2, ly2, lz2, px, py, pz) then
        return true
    end
    if is_auto_vis(local_player, lx2, ly2, lz2, px1, py1, pz1) then
        return true
    end
    if is_auto_vis(local_player, lx2, ly2, lz2, px2, py2, pz2) then
        return true
    end
    return false
end

local function extrapolate_position(xpos, ypos, zpos, ticks, ent)
    x, y, z = entity_get_prop(ent, "m_vecVelocity")
    for i = 0, ticks do
        xpos = xpos + (x * globals_tickinterval())
        ypos = ypos + (y * globals_tickinterval())
        zpos = zpos + (z * globals_tickinterval())
    end
    return xpos, ypos, zpos
end

local function get_best_enemy()
    -- We store the best target in a global variable so we don't have to re run the calculations every time we want to find the best target.
    best_enemy = nil

    local enemies = entity_get_players(true)
    local best_fov = 180

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()

    for i = 1, #enemies do
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math.abs(normalize_yaw(ang_on_screen(lx - cur_x, ly - cur_y) - view_y + 180))
        if cur_fov < best_fov then
            best_fov = cur_fov
            best_enemy = enemies[i]
        end
    end
end

local function get_best_angle()
    -- Since we run this from run_command no need to check if we are alive or anything.
    local me = entity_get_local_player()

    brute.best_angle = 0

    if not ui_get(override_antiaim) then
        return
    end

    if best_enemy == nil then
        return
    end

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()

    local e_x, e_y, e_z = entity_hitbox_position(best_enemy, 0)

    local yaw = calc_angle(lx, ly, e_x, e_y)
    local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
    local rend_x = lx + rdir_x * 10
    local rend_y = ly + rdir_y * 10

    local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
    local lend_x = lx + ldir_x * 10
    local lend_y = ly + ldir_y * 10

    local r2dir_x, r2dir_y, r2dir_z = angle_vector(0, (yaw + 90))
    local r2end_x = lx + r2dir_x * 100
    local r2end_y = ly + r2dir_y * 100

    local l2dir_x, l2dir_y, l2dir_z = angle_vector(0, (yaw - 90))
    local l2end_x = lx + l2dir_x * 100
    local l2end_y = ly + l2dir_y * 100

    local ldamage = get_damage(me, best_enemy, rend_x, rend_y, lz)
    local rdamage = get_damage(me, best_enemy, lend_x, lend_y, lz)

    local l2damage = get_damage(me, best_enemy, r2end_x, r2end_y, lz)
    local r2damage = get_damage(me, best_enemy, l2end_x, l2end_y, lz)

    if l2damage > r2damage or ldamage > rdamage then
        if ui_get(adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 1 or 2)
        else
            brute.best_angle = 1
        end
    elseif r2damage > l2damage or rdamage > ldamage then
        if ui_get(adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 2 or 1)
        else
            brute.best_angle = 2
        end
    end
end

local function doubletap_charged()
    -- Make sure we have doubletap enabled, are holding our doubletap key & we aren't fakeducking.
    if not ui_get(ref_dt) or not ui_get(ref_dt_key) or ui_get(ref_fd) then
        return false
    end

    -- Get our local player.
    local me = entity_get_local_player()

    -- Sanity checks on local player (since paint & a few other events run even when dead).
    if me == nil or not entity_is_alive(me) then
        return false
    end

    -- Get our local players weapon.
    local weapon = entity_get_prop(me, "m_hActiveWeapon")

    -- Make sure that it is valid.
    if weapon == nil then
        return false
    end

    -- Basic definitions used to calculate if we have recently shot or swapped weapons.
    local next_attack = entity_get_prop(me, "m_flNextAttack") + 0.25
    local next_primary_attack = entity_get_prop(weapon, "m_flNextPrimaryAttack") + 0.5

    -- Make sure both values are valid.
    if next_attack == nil or next_primary_attack == nil then
        return false
    end

    -- Return if both are under 0 meaning our doubletap is charged / we can fire (you can also use these values as a 2nd return parameter to get the charge %).
    return next_attack - globals_curtime() < 0 and next_primary_attack - globals_curtime() < 0
end

local nonweapons_c = {
    "CKnife",
    "CHEGrenade",
    "CMolotovGrenade",
    "CIncendiaryGrenade",
    "CFlashbang",
    "CDecoyGrenade",
    "CSmokeGrenade",
    "CWeaponTaser",
    "CC4"
}

local multi_exec = function(func, list)
    if func == nil then
        return
    end

    for ref, val in pairs(list) do
        func(ref, val)
    end
end

local compare = function(tab, val)
    for i = 1, #tab do
        if tab[i] == val then
            return true
        end
    end

    return false
end

local bind_system = {
    LEFT = false,
    RIGHT = false,
    BACK = false
}

multi_exec(
    ui_set_visible,
    {
        [manual_aa_clr] = false,
        [manual_left] = false,
        [manual_right] = false,
        [manual_back] = false,
        [manual_state] = false
    }
)

function bind_system:update()
    ui_set(manual_left, "On hotkey")
    ui_set(manual_right, "On hotkey")
    ui_set(manual_back, "On hotkey")

    local m_state = ui_get(manual_state)

    local left_state, right_state, back_state = ui_get(manual_left), ui_get(manual_right), ui_get(manual_back)

    if left_state == self.LEFT and back_state == self.BACK and right_state == self.RIGHT then
        return
    end

    self.LEFT, self.RIGHT, self.BACK = left_state, right_state, back_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) then
        ui_set(manual_state, 0)
        return
    end

    if left_state and m_state ~= 1 then
        ui_set(manual_state, 1)
    end

    if right_state and m_state ~= 2 then
        ui_set(manual_state, 2)
    end
    if back_state and m_state ~= 0 then
        ui_set(manual_state, 0)
    end
end

local on_manual_enabled = function(e, menu_call)
    local state = not ui_get(manual_aa)
    multi_exec(
        ui_set_visible,
        {
            [manual_aa_clr] = not state,
            [manual_left] = not state,
            [manual_right] = not state,
            [manual_back] = not state,
            [manual_state] = false
        }
    )
end

ui_set_callback(manual_aa, on_manual_enabled)

local function manual_aa_sc()
    if not ui_get(manual_aa) then
        return
    end

    local direction = ui_get(manual_state)

    local manual_yaw = {
        [0] = 0,
        [1] = -90,
        [2] = 90
    }

    if direction == 1 or direction == 2 then
        ui_set(ref_yaw_base, "Local view")
    else
        ui_set(ref_yaw_base, "At targets")
    end

    ui_set(ref_yawadd, manual_yaw[direction])
end

local function manual_aa_paint()
    on_manual_enabled(true, true)
    bind_system:update()

    local me = entity_get_local_player()
    local w, h = client_screen_size()

    if not entity_is_alive(me) or not ui_get(manual_aa) then
        return
    end

    local r, g, b, a = ui_get(manual_aa_clr)
    local m_state = ui_get(manual_state)

    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a / 2 - 1) + a / 2) or a

    if m_state == 2 and ui_get(indicator_arrow) == "Style 1" and ui_get(manual_arrows) then
        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "<")
    end
    if m_state == 1 and ui_get(indicator_arrow) == "Style 1" and ui_get(manual_arrows) then
        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, ">")
    end

    if m_state == 1 and ui_get(indicator_arrow) == "Style 1" and ui_get(manual_arrows) then
        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "<")
    end
    if m_state == 2 and ui_get(indicator_arrow) == "Style 1" and ui_get(manual_arrows) then
        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, r, g, b, alpha, "+c", 0, ">")
    end

    if m_state == 2 and ui_get(indicator_arrow) == "Style 2" and ui_get(manual_arrows) then
        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "‹")
    end
    if m_state == 1 and ui_get(indicator_arrow) == "Style 2" and ui_get(manual_arrows) then
        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "›")
    end

    if m_state == 1 and ui_get(indicator_arrow) == "Style 2" and ui_get(manual_arrows) then
        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "‹")
    end
    if m_state == 2 and ui_get(indicator_arrow) == "Style 2" and ui_get(manual_arrows) then
        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "›")
    end

    if m_state == 2 and ui_get(indicator_arrow) == "Style 3" and ui_get(manual_arrows) then
        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "⮘")
    end
    if m_state == 1 and ui_get(indicator_arrow) == "Style 3" and ui_get(manual_arrows) then
        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, 125, 125, 125, alpha, "+c", 0, "⮚")
    end

    if m_state == 1 and ui_get(indicator_arrow) == "Style 3" and ui_get(manual_arrows) then
        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "⮘")
    end
    if m_state == 2 and ui_get(indicator_arrow) == "Style 3" and ui_get(manual_arrows) then
        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, r, g, b, alpha, "+c", 0, "⮚")
    end
end

local function set_anti_aim(type)
    if type == "JITTER" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Offset")
        ui_set(ref_yawjadd, -10)
        ui_set(ref_bodyyaw, "JITTER")
        ui_set(ref_bodyyawadd, 0)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 28)
    elseif type == "RIGHT" then
        ui_set(ref_yaw, "180")
        ui.set(ref_yawadd, -6)
        ui.set(ref_yawj, "Offset")
        ui.set(ref_yawjadd, 6)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_bodyyawadd, -176)
        ui_set(ref_fs_bodyyaw, false)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 60)
    elseif type == "LEFT" then
        ui_set(ref_yaw, "180")
        ui.set(ref_yawadd, 3)
        ui.set(ref_yawj, "Offset")
        ui.set(ref_yawjadd, 6)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_bodyyawadd, 128)
        ui_set(ref_fs_bodyyaw, false)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 60)
    elseif type == "IDEAL RIGHT" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Offset")
        ui_set(ref_yawjadd, math.random(5, 8))
        ui_set(ref_bodyyaw, "Jitter")
        ui_set(ref_bodyyawadd, 44)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Opposite")
        ui_set(ref_fakelimit, math.random(32, 43))
    elseif type == "IDEAL LEFT" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Offset")
        ui_set(ref_yawjadd, math.random(5, 8))
        ui_set(ref_bodyyaw, "Jitter")
        ui_set(ref_bodyyawadd, 100)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Opposite")
        ui_set(ref_fakelimit, math.random(32, 43))
    elseif type == "FAKE YAW" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyawadd, 170)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 24)
    elseif type == "LOW DELTA" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, -4)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 170)
        ui_set(ref_fs_bodyyaw, false)
        ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 24)
    elseif type == "RANDOM DELTA" then
        ui.set(ref_yawadd, 0)
        ui.set(ref_yawj, "Offset")
        ui.set(ref_yawjadd, 6)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_bodyyawadd, 95)
        ui_set(ref_fs_bodyyaw, false)
        ui.set(ref_lby_target, "Opposite")
        ui.set(ref_fakelimit, math.random(51, 58))
    elseif type == "HIGH DELTA" then
        ui.set(ref_yawadd, -5)
        ui.set(ref_yawj, "Offset")
        ui.set(ref_yawjadd, 11)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_bodyyawadd, 28)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 28)
    elseif type == "STATIC" then
        ui.set(ref_yawadd, 3)
        ui.set(ref_yawj, "Offset")
        ui.set(ref_yawjadd, 6)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_bodyyawadd, 128)
        ui.set(ref_lby_target, "Eye yaw")
        ui.set(ref_fakelimit, 60)
    elseif type == "LEGIT AA" then
        ui.set(ref_pitch, "Off")
        ui.set(ref_yawadd, 180)
        ui.set(ref_bodyyaw, "Static")
        ui.set(ref_bodyyawadd, 90)
        ui_set(ref_fs_bodyyaw, true)
        ui.set(ref_lby_target, "Sway")
        ui.set(ref_fakelimit, math.random(57, 60))
    end
end

local function anti_aim()
    brute.yaw_status = "4 0 4"
    if not ui_get(override_antiaim) then
        return
    end

    if ui_get(manual_aa) and ui_get(manual_state) == 1 then
        brute.yaw_status = "MANUAL LEFT"
        set_anti_aim("FAKE YAW")
        return
    elseif ui_get(manual_aa) and ui_get(manual_state) == 2 then
        brute.yaw_status = "MANUAL RIGHT"
        set_anti_aim("FAKE YAW")
        return
    end

    if ui.get(adaptive_fs) then
        if brute.best_angle == 0 then
            if best_enemy == nil then
                brute.yaw_status = "JITTER"
                brute.indexed_angle = 0
                set_anti_aim("JITTER")
            elseif brute.indexed_angle ~= 0 then
                if brute.indexed_angle == 1 then
                    if brute.misses[best_enemy] == nil then
                        brute.yaw_status = "IDEAL YAW"
                        set_anti_aim("IDEAL RIGHT")
                    elseif brute.misses[best_enemy] == 1 then
                        brute.yaw_status = "IDEAL YAW "
                        set_anti_aim("IDEAL LEFT")
                    else
                        brute.yaw_status = "IDEAL YAW"
                        set_anti_aim("IDEAL RIGHT")
                    end
                else
                    if brute.misses[best_enemy] == nil then
                        brute.yaw_status = "IDEAL YAW "
                        set_anti_aim("IDEAL LEFT")
                    else
                        brute.yaw_status = "IDEAL YAW"
                        set_anti_aim("IDEAL RIGHT")
                    end
                end
            end
        elseif brute.best_angle == 1 then
            brute.indexed_angle = 1
            if brute.misses[best_enemy] == nil then
                brute.yaw_status = "BODY RIGHT"
                set_anti_aim("RIGHT")
            elseif brute.misses[best_enemy] == 1 then
                brute.yaw_status = "PEEK LEFT"
                set_anti_aim("LEFT")
            else
                brute.yaw_status = "BODY RIGHT"
                set_anti_aim("RIGHT")
            end
        else
            brute.indexed_angle = 2
            if brute.misses[best_enemy] == nil then
                brute.yaw_status = "BODY LEFT"
                set_anti_aim("LEFT")
            elseif brute.misses[best_enemy] == 1 then
                brute.yaw_status = "PEEK RIGHT"
                set_anti_aim("RIGHT")
            else
                brute.yaw_status = "BODY LEFT"
                set_anti_aim("LEFT")
            end
        end
        if ui_get(aa_on_key) == "Low delta" and ui.get(change_aa) and ui_get(change_aa_on_key) then
            brute.yaw_status = "LOW DELTA"
            set_anti_aim("LOW DELTA")
        elseif ui_get(aa_on_key) == "Random delta" and ui.get(change_aa) and ui_get(change_aa_on_key) then
            brute.yaw_status = "RANDOM DELTA"
            set_anti_aim("RANDOM DELTA")
        elseif ui_get(aa_on_key) == "High delta" and ui.get(change_aa) and ui_get(change_aa_on_key) then
            brute.yaw_status = "HIGH DELTA"
            set_anti_aim("HIGH DELTA")
        elseif ui_get(aa_on_key) == "Static" and ui.get(change_aa) and ui_get(change_aa_on_key) then
            brute.yaw_status = "STATIC"
            set_anti_aim("STATIC")
        end
        if ui_get(eyeyaw_dt) then
            if ui_get(ref_dt_key) and ui_get(ref_dt) and not client.key_state(0x45) then
                ui.set(ref_lby_target, "Eye yaw")
            elseif not ui_get(ref_dt_key) and not ui_get(ref_dt) and client.key_state(0x45) then
                ui.set(ref_lby_target, "Opposite")
            end
        end
        if ui_get(legit_aa_use) and client.key_state(0x45) then
            brute.yaw_status = "LEGIT AA"
        end
        if ui_get(legit_aa_on_key) then
            brute.yaw_status = "LEGIT AA"
            set_anti_aim("LEGIT AA")
        elseif not ui_get(legit_aa_on_key) then
            ui.set(ref_pitch, "Default")
        end
    end
end

--fl指示器
local OldChoke = 0
local toDraw4 = 0
local toDraw3 = 0
local toDraw2 = 0
local toDraw1 = 0
local toDraw0 = 0
local function setup_command(cmd)
    if cmd.chokedcommands < OldChoke then --sent
        toDraw0 = toDraw1
        toDraw1 = toDraw2
        toDraw2 = toDraw3
        toDraw3 = toDraw4
        toDraw4 = OldChoke
    end

    OldChoke = cmd.chokedcommands
end
client.set_event_callback("setup_command", setup_command)
local notes_pos = function(b)
    local c = function(d, e)
        local f = {}
        for g in pairs(d) do
            table.insert(f, g)
        end
        table.sort(f, e)
        local h = 0
        local i = function()
            h = h + 1
            if f[h] == nil then
                return nil
            else
                return f[h], d[f[h]]
            end
        end
        return i
    end
    local j = {
        get = function(k)
            local l, m = 0, {}
            for n, o in c(package.cnotes) do
                if o == true then
                    l = l + 1
                    m[#m + 1] = {n, l}
                end
            end
            for p = 1, #m do
                if m[p][1] == b then
                    return k(m[p][2] - 1)
                end
            end
        end,
        set_state = function(q)
            package.cnotes[b] = q
            table.sort(package.cnotes)
        end,
        unset = function()
            client.unset_event_callback("shutdown", callback)
        end
    }
    client.set_event_callback(
        "shutdown",
        function()
            if package.cnotes[b] ~= nil then
                package.cnotes[b] = nil
            end
        end
    )
    if package.cnotes == nil then
        package.cnotes = {}
    end
    return j
end
local note = notes_pos "b_aa_indicators.v1"
local g_paint_handler = function()
    local w, h = client_screen_size()
    local s_r, s_g, s_b, s_a = ui_get(side_arrows_clr)
    local b_r, b_g, b_b, b_a = ui_get(on_peek_arrows_clr)
    local _, camera_yaw = client.camera_angles()
    local _, rotation = entity.get_prop(me, "m_angAbsRotation")
    local body_pos = entity.get_prop(me, "m_flPoseParameter", 11) or 0
    local body_yaw = math.max(-60, math.min(60, body_pos * 120 - 60 + 0.5))
    body_yaw = (body_yaw < 1 and body_yaw > 0.0001) and math.floor(body_yaw, 1) or body_yaw
    if camera_yaw ~= nil and rotation ~= nil and 60 < math.abs(normalize_yaw(camera_yaw - (rotation + body_yaw))) then
        body_yaw = -body_yaw
    end
    local is_active = entity.is_alive(me)
    if not is_active then
        locals = {
            last_choke = 0,
            lby_next_think = 0
        }
    end
    local abs_yaw = math.abs(body_yaw)
    local side = body_yaw < 0 and ">" or (body_yaw > 0.999 and "<" or "-")
    if not is_active then
        return
    end

    -- aa箭头指示
    if not entity_is_alive(entity_get_local_player()) then
        return
    end
    if ui_get(side_arrows) then
        if ui_get(indicator_arrow) == "Style 1" and ui.get(adaptive_fs) then
            if not ui_get(manual_aa) or ui_get(manual_state) == 0 then
                if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                    if body_yaw < 0 then
                        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, 125, 125, 125, 125, "cb+", 0, ">")
                        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, s_r, s_g, s_b, s_a, "cb+", 0, "<")
                    else
                        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, s_r, s_g, s_b, s_a, "cb+", 0, ">")
                        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, 125, 125, 125, 125, "cb+", 0, "<")
                    end
                    if
                        ui.get(on_peek_arrows) and ui.get(adaptive_fs) and brute.yaw_status == "BODY LEFT" and
                            body_yaw < 0
                     then
                        renderer.text(w / 2 - 50 - ui.get(arrows_offset), h / 2, b_r, b_g, b_b, b_a, "cb+", 0, "<")
                    elseif
                        ui.get(on_peek_arrows) and ui.get(adaptive_fs) and brute.yaw_status == "BODY RIGHT" and
                            body_yaw > 0.999
                     then
                        renderer.text(w / 2 + 50 + ui.get(arrows_offset), h / 2, b_r, b_g, b_b, b_a, "cb+", 0, ">")
                    end
                end
            end
        end
        if ui_get(indicator_arrow) == "Style 2" and ui.get(adaptive_fs) then
            if not ui_get(manual_aa) or ui_get(manual_state) == 0 then
                if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                    if body_yaw < 0 then
                        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, 125, 125, 125, 125, "c+", 0, "›")
                        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, s_r, s_g, s_b, s_a, "c+", 0, "‹")
                    else
                        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, s_r, s_g, s_b, s_a, "c+", 0, "›")
                        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, 125, 125, 125, 125, "c+", 0, "‹")
                    end
                    if
                        ui.get(on_peek_arrows) and ui.get(adaptive_fs) and brute.yaw_status == "BODY LEFT" and
                            body_yaw < 0
                     then
                        renderer.text(w / 2 - 50 - ui.get(arrows_offset), h / 2, b_r, b_g, b_b, b_a, "c+", 0, "‹")
                    elseif
                        ui.get(on_peek_arrows) and ui.get(adaptive_fs) and brute.yaw_status == "BODY RIGHT" and
                            body_yaw > 0.999
                     then
                        renderer.text(w / 2 + 50 + ui.get(arrows_offset), h / 2, b_r, b_g, b_b, b_a, "c+", 0, "›")
                    end
                end
            end
        end
        if ui_get(indicator_arrow) == "Style 3" and ui.get(adaptive_fs) then
            if not ui_get(manual_aa) or ui_get(manual_state) == 0 then
                if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                    if body_yaw < 0 then
                        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, 125, 125, 125, 125, "c+", 0, "⮚")
                        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, s_r, s_g, s_b, s_a, "c+", 0, "⮘")
                    else
                        renderer.text(w / 2 + 40 + ui.get(arrows_offset), h / 2, s_r, s_g, s_b, s_a, "c+", 0, "⮚")
                        renderer.text(w / 2 - 40 - ui.get(arrows_offset), h / 2, 125, 125, 125, 125, "c+", 0, "⮘")
                    end
                    if
                        ui.get(on_peek_arrows) and ui.get(adaptive_fs) and brute.yaw_status == "BODY LEFT" and
                            body_yaw < 0
                     then
                        renderer.text(w / 2 - 50 - ui.get(arrows_offset), h / 2, b_r, b_g, b_b, b_a, "c+", 0, "⮘")
                    elseif
                        ui.get(on_peek_arrows) and ui.get(adaptive_fs) and brute.yaw_status == "BODY RIGHT" and
                            body_yaw > 0.999
                     then
                        renderer.text(w / 2 + 50 + ui.get(arrows_offset), h / 2, b_r, b_g, b_b, b_a, "c+", 0, "⮚")
                    end
                end
            end
        end
    end
end
client.set_event_callback("paint", g_paint_handler)
local function draw()
    if not entity_is_alive(entity_get_local_player()) then
        return
    end
    local r, g, b, a = ui_get(indicator_info_clr)
    local r1, g1, b1, a1 = ui_get(indicator_info_clr1)
    local w, h = client_screen_size()
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a / 2 - 1) + a / 2) or a
    local me = entity.get_local_player()
    local screen_size = {client.screen_size()}
    local camera_angles = {client.camera_angles()}
    local anti_aim = require "gamesense/antiaim_funcs"
    local by = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(1) - 120)
    local fy = anti_aim.normalize_angle(camera_angles[2] - anti_aim.get_body_yaw(2) - 120)
    local h_index = 0
    if ui.get(indicator_type) == "Right crosshair" then
        if ui.get(font_type) == "Style 1" then
            if includes(ui_get(indicators), "Yaw status") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana,
                    "AA"
                )
                surface_draw_text(
                    w / 2 + 30,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    255,
                    255,
                    255,
                    255,
                    verdana,
                    " | "
                )
                surface_draw_text(
                    w / 2 + 40,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    verdana,
                    brute.yaw_status
                )
                h_index = h_index + 1
            end
            if includes(ui_get(indicators), "Doubletap") and ui_get(ref_dt_key) and ui_get(ref_dt) then
                if doubletap_charged() then
                    surface_draw_text(
                        w / 2 + 15,
                        h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                        154,
                        255,
                        31,
                        255,
                        verdana,
                        "DT"
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        0,
                        0,
                        0,
                        alpha,
                        6,
                        -90,
                        1,
                        4
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        154,
                        255,
                        31,
                        alpha,
                        5,
                        -90,
                        1,
                        2
                    )
                else
                    surface_draw_text(
                        w / 2 + 15,
                        h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                        255,
                        54,
                        31,
                        255,
                        verdana,
                        "DT"
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        0,
                        0,
                        0,
                        255,
                        6,
                        -90,
                        1,
                        4
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        255,
                        54,
                        31,
                        255,
                        5,
                        -90,
                        math.random(0, 1),
                        2
                    )
                end
                h_index = h_index + 1
            elseif includes(ui_get(indicators), "Doubletap") and not ui_get(ref_dt_key) or not ui_get(ref_dt) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana,
                    "FL : "
                )
                renderer.gradient(
                    w / 2 + 35,
                    h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                    math.min(OldChoke * 2),
                    6,
                    r,
                    g,
                    b,
                    255,
                    125,
                    125,
                    125,
                    50,
                    true
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Min damage") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana,
                    string.format("DMG : ")
                )
                surface_draw_text(
                    w / 2 + 47,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    verdana,
                    string.format(ui.get(mindmg))
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Desync") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana,
                    string.format("DESYNC : ")
                )
                renderer.circle_outline(
                    w / 2 + 74,
                    h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                    15,
                    15,
                    15,
                    150,
                    6,
                    0,
                    1,
                    4
                )
                renderer.circle_outline(
                    w / 2 + 74,
                    h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    6,
                    by,
                    0.1,
                    4
                )
                renderer.circle_outline(
                    w / 2 + 74,
                    h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    6,
                    fy,
                    0.1,
                    4
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Fakeduck") and ui_get(ref_fd) then
                local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    215,
                    114,
                    44,
                    alpha,
                    verdana,
                    "DUCK"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Force safepoint") and ui_get(ref_sp_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    255,
                    125,
                    225,
                    255,
                    verdana,
                    "SAFE"
                )
                h_index = h_index + 1
            end

            if includes(ui.get(indicators), "Force body aim") and ui.get(ref_baim_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    225,
                    225,
                    112,
                    255,
                    verdana,
                    "BAIM"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Hideshots") and ui_get(ref_hs) and ui_get(ref_hs_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    154,
                    255,
                    31,
                    alpha,
                    verdana,
                    "ON-SHOT"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Backtrack") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana,
                    string.format("BACKTRACK")
                )
                if ui.get(backtrack) and ui.get(ping) then
                    renderer.gradient(
                        w / 2 + 15,
                        h / 2 + 50 + (h_index * 12) + ui.get(indicators_offset),
                        math.min(math.random(5, 19) * math.random(1, 3)),
                        2,
                        r,
                        g,
                        b,
                        255,
                        r,
                        g,
                        b,
                        125,
                        true
                    )
                else
                    renderer.gradient(
                        w / 2 + 15,
                        h / 2 + 50 + (h_index * 12) + ui.get(indicators_offset),
                        math.min(math.random(5, 12) * math.random(1, 3)),
                        2,
                        r,
                        g,
                        b,
                        255,
                        r,
                        g,
                        b,
                        125,
                        true
                    )
                end
                h_index = h_index + 1
            end
        end
        if ui.get(font_type) == "Style 2" then
            if includes(ui_get(indicators), "Yaw status") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana2,
                    "AA"
                )
                surface_draw_text(
                    w / 2 + 30,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    255,
                    255,
                    255,
                    255,
                    verdana2,
                    " | "
                )
                surface_draw_text(
                    w / 2 + 40,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    verdana2,
                    brute.yaw_status
                )
                h_index = h_index + 1
            end
            if includes(ui_get(indicators), "Doubletap") and ui_get(ref_dt_key) and ui_get(ref_dt) then
                if doubletap_charged() then
                    surface_draw_text(
                        w / 2 + 15,
                        h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                        154,
                        255,
                        31,
                        255,
                        verdana2,
                        "DT"
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        0,
                        0,
                        0,
                        alpha,
                        6,
                        -90,
                        1,
                        4
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        154,
                        255,
                        31,
                        alpha,
                        5,
                        -90,
                        1,
                        2
                    )
                else
                    surface_draw_text(
                        w / 2 + 15,
                        h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                        255,
                        54,
                        31,
                        255,
                        verdana2,
                        "DT"
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        0,
                        0,
                        0,
                        255,
                        6,
                        -90,
                        1,
                        4
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                        255,
                        54,
                        31,
                        255,
                        5,
                        -90,
                        math.random(0, 1),
                        2
                    )
                end
                h_index = h_index + 1
            elseif includes(ui_get(indicators), "Doubletap") and not ui_get(ref_dt_key) or not ui_get(ref_dt) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana2,
                    "FL : "
                )
                renderer.gradient(
                    w / 2 + 35,
                    h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                    math.min(OldChoke * 2),
                    6,
                    r,
                    g,
                    b,
                    255,
                    125,
                    125,
                    125,
                    50,
                    true
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Min damage") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana2,
                    string.format("DMG : ")
                )
                surface_draw_text(
                    w / 2 + 47,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    verdana2,
                    string.format(ui.get(mindmg))
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Desync") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana2,
                    string.format("DESYNC : ")
                )
                renderer.circle_outline(
                    w / 2 + 72,
                    h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                    15,
                    15,
                    15,
                    150,
                    6,
                    0,
                    1,
                    4
                )
                renderer.circle_outline(
                    w / 2 + 72,
                    h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    6,
                    by,
                    0.1,
                    4
                )
                renderer.circle_outline(
                    w / 2 + 72,
                    h / 2 + 42 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    6,
                    fy,
                    0.1,
                    4
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Fakeduck") and ui_get(ref_fd) then
                local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    215,
                    114,
                    44,
                    alpha,
                    verdana2,
                    "DUCK"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Force safepoint") and ui_get(ref_sp_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    255,
                    125,
                    225,
                    255,
                    verdana2,
                    "SAFE"
                )
                h_index = h_index + 1
            end

            if includes(ui.get(indicators), "Force body aim") and ui.get(ref_baim_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    225,
                    225,
                    112,
                    255,
                    verdana2,
                    "BAIM"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Hideshots") and ui_get(ref_hs) and ui_get(ref_hs_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    154,
                    255,
                    31,
                    alpha,
                    verdana2,
                    "ON-SHOT"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Backtrack") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    verdana2,
                    string.format("BACKTRACK")
                )
                if ui.get(backtrack) and ui.get(ping) then
                    renderer.gradient(
                        w / 2 + 15,
                        h / 2 + 50 + (h_index * 12) + ui.get(indicators_offset),
                        math.min(math.random(5, 19) * math.random(1, 3)),
                        2,
                        r,
                        g,
                        b,
                        255,
                        r,
                        g,
                        b,
                        125,
                        true
                    )
                else
                    renderer.gradient(
                        w / 2 + 15,
                        h / 2 + 50 + (h_index * 12) + ui.get(indicators_offset),
                        math.min(math.random(5, 12) * math.random(1, 3)),
                        2,
                        r,
                        g,
                        b,
                        255,
                        r,
                        g,
                        b,
                        125,
                        true
                    )
                end
                h_index = h_index + 1
            end
        end
        if ui.get(font_type) == "Style 3" then
            if includes(ui_get(indicators), "Yaw status") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    custom_font,
                    "AA"
                )
                surface_draw_text(
                    w / 2 + 30,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    255,
                    255,
                    255,
                    255,
                    custom_font,
                    " | "
                )
                surface_draw_text(
                    w / 2 + 40,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    custom_font,
                    brute.yaw_status
                )
                h_index = h_index + 1
            end
            if includes(ui_get(indicators), "Doubletap") and ui_get(ref_dt_key) and ui_get(ref_dt) then
                if doubletap_charged() then
                    surface_draw_text(
                        w / 2 + 15,
                        h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                        154,
                        255,
                        31,
                        255,
                        custom_font,
                        "DT"
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                        0,
                        0,
                        0,
                        alpha,
                        6,
                        -90,
                        1,
                        4
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                        154,
                        255,
                        31,
                        alpha,
                        5,
                        -90,
                        1,
                        2
                    )
                else
                    surface_draw_text(
                        w / 2 + 15,
                        h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                        255,
                        54,
                        31,
                        255,
                        custom_font,
                        "DT"
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                        0,
                        0,
                        0,
                        255,
                        6,
                        -90,
                        1,
                        4
                    )
                    renderer.circle_outline(
                        w / 2 + 38,
                        h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                        255,
                        54,
                        31,
                        255,
                        5,
                        -90,
                        math.random(0, 1),
                        2
                    )
                end
                h_index = h_index + 1
            elseif includes(ui_get(indicators), "Doubletap") and not ui_get(ref_dt_key) or not ui_get(ref_dt) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    custom_font,
                    "FL : "
                )
                renderer.gradient(
                    w / 2 + 35,
                    h / 2 + 37 + (h_index * 12) + ui.get(indicators_offset),
                    math.min(OldChoke * 2),
                    6,
                    r,
                    g,
                    b,
                    255,
                    125,
                    125,
                    125,
                    50,
                    true
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Min damage") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    custom_font,
                    string.format("DMG : ")
                )
                surface_draw_text(
                    w / 2 + 47,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    custom_font,
                    string.format(ui.get(mindmg))
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Desync") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    custom_font,
                    string.format("DESYNC : ")
                )
                renderer.circle_outline(
                    w / 2 + 68,
                    h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                    15,
                    15,
                    15,
                    150,
                    6,
                    0,
                    1,
                    4
                )
                renderer.circle_outline(
                    w / 2 + 68,
                    h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    6,
                    by,
                    0.1,
                    4
                )
                renderer.circle_outline(
                    w / 2 + 68,
                    h / 2 + 39 + (h_index * 12) + ui.get(indicators_offset),
                    r,
                    g,
                    b,
                    a,
                    6,
                    fy,
                    0.1,
                    4
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Fakeduck") and ui_get(ref_fd) then
                local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    215,
                    114,
                    44,
                    alpha,
                    custom_font,
                    "DUCK"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Force safepoint") and ui_get(ref_sp_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    255,
                    125,
                    225,
                    255,
                    custom_font,
                    "SAFE"
                )
                h_index = h_index + 1
            end

            if includes(ui.get(indicators), "Force body aim") and ui.get(ref_baim_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    225,
                    225,
                    112,
                    255,
                    custom_font,
                    "BAIM"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Hideshots") and ui_get(ref_hs) and ui_get(ref_hs_key) then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    154,
                    255,
                    31,
                    alpha,
                    custom_font,
                    "ON-SHOT"
                )
                h_index = h_index + 1
            end

            if includes(ui_get(indicators), "Backtrack") then
                surface_draw_text(
                    w / 2 + 15,
                    h / 2 + 35 + (h_index * 12) + ui.get(indicators_offset),
                    r1,
                    g1,
                    b1,
                    a1,
                    custom_font,
                    string.format("BACKTRACK")
                )
                if ui.get(backtrack) and ui.get(ping) then
                    renderer.gradient(
                        w / 2 + 15,
                        h / 2 + 48 + (h_index * 12) + ui.get(indicators_offset),
                        math.min(math.random(5, 19) * math.random(1, 3)),
                        2,
                        r,
                        g,
                        b,
                        255,
                        r,
                        g,
                        b,
                        125,
                        true
                    )
                else
                    renderer.gradient(
                        w / 2 + 15,
                        h / 2 + 48 + (h_index * 12) + ui.get(indicators_offset),
                        math.min(math.random(5, 12) * math.random(1, 3)),
                        2,
                        r,
                        g,
                        b,
                        255,
                        r,
                        g,
                        b,
                        125,
                        true
                    )
                end
                h_index = h_index + 1
            end
        end
    end

    if ui.get(hide_default_inds) then
        for i = 1, 400 do
            renderer.indicator(0, 0, 0, 0, " ")
        end
    end
end

brute.impact = function(e)
    if not ui_get(override_antiaim) then
        return
    end

    local me = entity_get_local_player()

    -- Since bullet_impact gets triggered even while we're dead having this check is a good idea.
    if not entity_is_alive(me) then
        return
    end

    local shooter_id = e.userid
    local shooter = client_userid_to_entindex(shooter_id)

    -- Distance calculations can sometimes bug when the entity is dormant hence the 2nd check.
    if not entity_is_enemy(shooter) or entity_is_dormant(shooter) then
        return
    end

    local lx, ly, lz = entity_hitbox_position(me, "head_0")

    local ox, oy, oz = entity_get_prop(me, "m_vecOrigin")
    local ex, ey, ez = entity_get_prop(shooter, "m_vecOrigin")

    local dist = ((e.y - ey) * lx - (e.x - ex) * ly + e.x * ey - e.y * ex) / math.sqrt((e.y - ey) ^ 2 + (e.x - ex) ^ 2)

    -- 32 is our miss detection radius and the 2nd check is to avoid adding more than 1 miss for a singular bullet (bullet_impact gets called mulitple times per shot).
    if math.abs(dist) <= 32 and globals_curtime() - brute.last_miss > 0.015 then
        brute.last_miss = globals_curtime()
        if brute.misses[shooter] == nil then
            brute.misses[shooter] = 1
        elseif brute.misses[shooter] >= 2 then
            brute.misses[shooter] = nil
        else
            brute.misses[shooter] = brute.misses[shooter] + 1
        end
    end
end

--增强回溯

client.set_event_callback(
    "run_command",
    function(c)
        if ui.get(backtrack) then
            local local_player = entity.get_local_player()
            if local_player ~= nil then
                local weapon = entity.get_player_weapon(local_player)
                local item = entity.get_prop(weapon, "m_iItemDefinitionIndex")
                if item ~= nil then
                    if (item == 40 or item == 9 or item == 38 or item == 11) then -- scar20
                        ui.set(ping, true)
                        ui.set(pingslider, 199)
                        ui.set(pinghotkey, "Always On")
                    else
                        ui.set(ping, false)
                        ui.set(pingslider, 1)
                        ui.set(pinghotkey, "On hotkey")
                    end
                end
            end
        end
    end
)

--落地抬头
client.set_event_callback(
    "pre_render",
    function()
        if entity.is_alive(entity.get_local_player()) then
            if ui.get(fake_up) then
                local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1)

                if on_ground == 1 then
                    ground_ticks = ground_ticks + 1
                else
                    ground_ticks = 0
                    end_time = globals.curtime() + 1
                end

                if ground_ticks > ui.get(fakelag) + 1 and end_time > globals.curtime() then
                    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
                end
            end
        end
    end
)

--反背刺
local event_handler_functions = {
    [true] = client.set_event_callback,
    [false] = client.unset_event_callback
}

local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
end

local function on_run_command()
    local players = entity.get_players(true)
    local lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
    local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
    for i = 1, #players do
        local x, y, z = entity.get_prop(players[i], "m_vecOrigin")
        local distance = get_distance(lx, ly, lz, x, y, z)
        local weapon = entity.get_player_weapon(players[i])
        if entity.get_classname(weapon) == "CKnife" and distance <= 164 then
            ui.set(yaw_slider, 180)
        end
    end
end

local function on_script_toggle_change()
    local state = ui.get(anti_knife)
    local handle_event = event_handler_functions[state]
    handle_event("run_command", on_run_command)
end

on_script_toggle_change()
ui.set_callback(anti_knife, on_script_toggle_change)

--debug indicator
function void_logs()
    if not showed_welcome then
        table.insert(BR0KENz.logs, {["log_text"] = "Loading...", ["time"] = globals.realtime()})
        table.insert(BR0KENz.logs, {["log_text"] = "404 project v5", ["time"] = globals.realtime()})
        table.insert(BR0KENz.logs, {["log_text"] = "Welcome", ["time"] = globals.realtime()})
        table.insert(BR0KENz.logs, {["log_text"] = "Successfully loaded", ["time"] = globals.realtime()})
        table.insert(BR0KENz.logs, {["log_text"] = "Updated: 24/04/2021", ["time"] = globals.realtime()})
        welcome_curtime = globals.realtime()
        showed_welcome = true
    end
    local logs = BR0KENz.logs
    local size = 0

    for i = 1, #logs do
        if globals.realtime() - logs[i].time > 5 or i > 8 then
            table.remove(logs, i)
            return
        end

        local anim_time = globals.realtime() - logs[i].time
        local alpha = clamp(0, 255 * (anim_time), 255)
        if anim_time >= 4 then
            alpha = math.abs(clamp(0, 255 * (anim_time - 4), 255) - 255)
            alpha2 = math.abs(clamp(0, 100 * (anim_time - 4), 100) - 100)
        end

        renderer.gradient(
            screenx - 5,
            screeny / 2 + (i * 15),
            -(renderer.measure_text("", logs[i].log_text) + 10),
            14,
            255,
            132,
            0,
            alpha,
            255,
            0,
            255,
            255,
            true
        )
        renderer.text(
            (screenx - 10) - renderer.measure_text("", logs[i].log_text),
            screeny / 2 + i * 15,
            255,
            255,
            255,
            255,
            "",
            nil,
            logs[i].log_text
        )

        size = renderer.measure_text("", logs[i].log_text)
        renderer.rectangle(
            (screenx - 5) - (renderer.measure_text("", logs[i].log_text) + 10),
            screeny / 2 + 12 + (i * 15),
            clamp(0, size * (anim_time / 4), size),
            2,
            255,
            255,
            255,
            anim_time >= 4 and alpha2 or 100
        )
    end
end

--滑步
local legs_ref = ui.reference("AA", "OTHER", "leg movement")

slidewalk = ui.reference("AA", "other", "leg movement")

client.set_event_callback(
    "net_update_end",
    function()
        if ui.get(enable_slide) then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
        end
    end
)

client.set_event_callback(
    "run_command",
    function(ctx)
        if ui.get(enable_slide) then
            p = client.random_int(1, 3)
            if p == 1 then
                ui.set(slidewalk, "Off")
            elseif p == 2 then
                ui.set(slidewalk, "Always slide")
            elseif p == 3 then
                ui.set(slidewalk, "Off")
            end
            ui.set_visible(slidewalk, false)
        else
            ui.set_visible(slidewalk, true)
        end
    end
)

brute.reset = function()
    brute.indexed_angle = 0
    brute.last_miss = 0
    brute.best_angle = 0
    brute.misses = {}
end

brute.death = function(e)
    if not ui_get(override_antiaim) then
        return
    end

    local victim_id = e.userid
    local victim = client_userid_to_entindex(victim_id)

    if victim ~= entity_get_local_player() then
        return
    end

    local attacker_id = e.attacker
    local attacker = client_userid_to_entindex(attacker_id)

    if not entity_is_enemy(attacker) then
        return
    end

    if not e.headshot then
        return
    end

    if brute.misses[attacker] == nil or (globals_curtime() - brute.last_miss < 0.06 and brute.misses[attacker] == 1) then
        if brute.hit_reverse[attacker] == nil then
            brute.hit_reverse[attacker] = true
        else
            brute.hit_reverse[attacker] = nil
        end
    end
end

local function legit_aa(e)
    if ui_get(legit_aa_use) and e.in_use == 1 then
        if entity_get_classname(entity_get_player_weapon(entity_get_local_player())) == "CC4" then
            return
        end

        if e.in_attack == 1 then
            e.in_use = 1
        end

        if e.chokedcommands == 0 then
            e.in_use = 0
        end
    end
end

local string_meta = getmetatable("")

function string_meta:__index(key)
    local val = string[key]
    if (val) then
        return val
    elseif (tonumber(key)) then
        return self:sub(key, key)
    end
end

local function main()
    -- Our main function where we do our base authentication and event callbacks.

    client_set_event_callback(
        "paint",
        function()
            if not ui_get(override_antiaim) then
                return
            end

            draw()
            manual_aa_paint()
        end
    )

    client_set_event_callback(
        "run_command",
        function()
            if not ui_get(override_antiaim) then
                return
            end

            get_best_enemy()
            get_best_angle()
            manual_aa_sc()
            anti_aim()
        end
    )

    client_set_event_callback(
        "setup_command",
        function(e)
            if not ui_get(override_antiaim) then
                return
            end

            legit_aa(e)
        end
    )

    client_set_event_callback(
        "bullet_impact",
        function(e)
            if not ui_get(override_antiaim) then
                return
            end

            brute.impact(e)
        end
    )

    client_set_event_callback(
        "player_death",
        function(e)
            if not ui_get(override_antiaim) then
                return
            end

            brute.death(e)
        end
    )

    client_set_event_callback(
        "round_start",
        function()
            if not ui_get(override_antiaim) then
                return
            end

            dt_latency = client.latency() * 1000
            brute.reset()
        end
    )

    client_set_event_callback(
        "client_disconnect",
        function()
            if not ui_get(override_antiaim) then
                return
            end

            brute.reset()
        end
    )

    client_set_event_callback(
        "game_newmap",
        function()
            if not ui_get(override_antiaim) then
                return
            end

            brute.reset()
        end
    )

    client_set_event_callback(
        "cs_game_disconnected",
        function()
            if not ui_get(override_antiaim) then
                return
            end

            brute.reset()
        end
    )

    client_set_event_callback(
        "shutdown",
        function()
            ui_set(ref_maxprocessticks, 16)
            cvar.cl_clock_correction:set_int(1)
            database.write("dt_x", wnd.x)
            database.write("dt_y", wnd.y)
        end
    )
end
main()
function set_visible_on_elements()
    ui.set_visible(ref_pitch, not ui.get(override_antiaim))
    ui.set_visible(ref_yaw, not ui.get(override_antiaim))
    ui.set_visible(ref_yaw_base, not ui.get(enable_slide))
    ui.set_visible(ref_yawadd, not ui.get(override_antiaim))
    ui.set_visible(ref_yawj, not ui.get(override_antiaim))
    ui.set_visible(ref_yawjadd, not ui.get(override_antiaim))
    ui.set_visible(ref_bodyyawadd, not ui.get(override_antiaim))
    ui.set_visible(ref_bodyyaw, not ui.get(override_antiaim))
    ui.set_visible(ref_fakelimit, not ui.get(override_antiaim))
    ui.set_visible(ref_lby_target, not ui.get(override_antiaim))
    ui.set_visible(ref_fs_bodyyaw, not ui.get(override_antiaim))
    ui.set_visible(ref_free, not ui.get(override_antiaim))
    ui.set_visible(ref_freekey, not ui.get(override_antiaim))
    ui.set_visible(edge_yaw, not ui.get(override_antiaim))
    ui.set_visible(change_aa, ui.get(override_antiaim))
    ui.set_visible(aa_on_key, ui.get(change_aa) and ui.get(override_antiaim))
    ui.set_visible(change_aa_on_key, ui.get(change_aa) and ui.get(override_antiaim))
    ui.set_visible(adaptive_fs, ui.get(override_antiaim))
    ui.set_visible(indicator_info_clr, ui.get(override_antiaim))
    ui.set_visible(fake_up, ui.get(override_antiaim))
    ui.set_visible(manual_aa, ui.get(override_antiaim))
    ui.set_visible(manual_aa_clr, ui.get(override_antiaim) and ui.get(manual_aa))
    ui.set_visible(manual_left, ui.get(override_antiaim) and ui.get(manual_aa))
    ui.set_visible(manual_right, ui.get(override_antiaim) and ui.get(manual_aa))
    ui.set_visible(manual_back, ui.get(override_antiaim) and ui.get(manual_aa))
    ui.set_visible(legit_aa_use, ui.get(override_antiaim))
    ui.set_visible(legit_aa_on_key, ui.get(override_antiaim))
    ui.set_visible(anti_knife, ui.get(override_antiaim))
    ui.set_visible(side_arrows, ui.get(override_antiaim))
    ui.set_visible(side_arrows_clr, ui.get(override_antiaim) and ui.get(side_arrows))
    ui.set_visible(indicator_arrow, ui.get(override_antiaim))
    ui.set_visible(indicator_type, ui.get(override_antiaim))
    ui.set_visible(indicators, ui.get(override_antiaim))
    ui.set_visible(font_type, ui.get(override_antiaim))
    ui.set_visible(label1, ui.get(override_antiaim))
    ui.set_visible(label2, ui.get(override_antiaim))
    ui.set_visible(label3, ui.get(override_antiaim))
    ui.set_visible(backtrack, ui.get(override_antiaim))
    ui.set_visible(on_peek_arrows, ui.get(override_antiaim))
    ui.set_visible(on_peek_arrows_clr, ui.get(override_antiaim) and ui.get(on_peek_arrows))
    ui.set_visible(enable_slide, ui.get(override_antiaim))
    ui.set_visible(eyeyaw_dt, ui.get(override_antiaim))
    ui.set_visible(manual_arrows, ui.get(override_antiaim))
    ui.set_visible(arrows_offset, ui.get(override_antiaim))
    ui.set_visible(hide_default_inds, ui.get(override_antiaim))
    ui.set_visible(projecttag_enabled, ui.get(override_antiaim))
    ui.set_visible(indicator_info_clr1, ui.get(override_antiaim))
    ui.set_visible(indicators_offset, ui.get(override_antiaim))
end

client.set_event_callback("paint_menu", set_visible_on_elements)
client.set_event_callback("paint", set_visible_on_elements)
client.set_event_callback("paint_ui", void_logs)
