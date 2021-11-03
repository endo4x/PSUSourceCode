--[[
	id: EoqRhSlCsFIpEDQ4QQ0tI
	name: Nothing
	description: Nothing
	time1: 2021-05-19 10:03:43.582871+00
	time2: 2021-05-19 10:03:43.582872+00
	uploader: 2651
	uploadersession: TCdOFEe_Varwjef_knRQ6mEYI1UUrC
	flag: f
--]]

local entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
local ipairs, assert, pairs, next, tostring, tonumber, setmetatable, unpack, type, getmetatable, pcall, error = ipairs, assert, pairs, next, tostring, tonumber, setmetatable, unpack, type, getmetatable, pcall, error
--end of local variables

--setting requirements we need
local images = require "gamesense/images";
local csgo_weapons = require "gamesense/csgo_weapons"
local js = panorama.open();
local ffi = require "ffi";
local bit = require "bit";
local http = require "gamesense/http";
local clipboard = require 'gamesense/clipboard';
local steamid64 = js.MyPersonaAPI.GetXuid()
local version = "13/05/2021"

local enter = (function()
    local enter = {callback_registered = false, maximum_count = 7, data = {}, svg_texture = [[]]}
    local svg_size = { w = 10, h = 30}
    local svg = renderer.load_svg(enter.svg_texture, svg_size.w, svg_size.h)
    function enter:register_callback()
        if self.callback_registered then return end
        client.set_event_callback('paint_ui', function()
            local screen = {client.screen_size()}
            local color = {27, 27, 27}
            local d = 5;
            local data = self.data;
            for f = #data, 1, -1 do
                data[f].time = data[f].time - globals.frametime()
                local alpha, h = 255, 0;
                local _data = data[f]
                if _data.time < 0 then
                    table.remove(data, f)
                else
                    local time_diff = _data.def_time - _data.time;
                    local time_diff = time_diff > 1 and 1 or time_diff;
                    if _data.time < 0.5 or time_diff < 0.5 then
                        h = (time_diff < 1 and time_diff or _data.time) / 0.5;
                        alpha = h * 255;
                        if h < 0.2 then
                            d = d + 15 * (1.0 - h / 0.2)
                        end
                    end
                    local text_data = {renderer.measure_text("dc", _data.draw)}
                    local screen_data = {
                        screen[1] / 2 - text_data[1] / 2 - 7, screen[2] - screen[2] / 200 * 12.4 + d
                    }
                    renderer.rectangle(screen_data[1] - 2500, screen_data[2] - 1500, text_data[1] + 5000, 5008, color[1], color[2],color[3], alpha <= 135 and alpha or 135)
                    renderer.line(screen_data[1] - 30, screen_data[2] - 450, screen_data[1] - 30, screen_data[2] - 20 + 72, 155, 0, alpha <= 50 and alpha or 50)
                    renderer.text(screen_data[1] + text_data[1] / 2 + 3, screen_data[2] - 530, 255, 255, 255, alpha, 'dcb', nil, _data.draw)
                    renderer.texture(svg, screen_data[1] - svg_size.w/2 - 5, screen_data[2] - svg_size.h/2 - 535, svg_size.w, svg_size.h, 72, 155, 194, alpha)
                    d = d - 50
                end
            end
            self.callback_registered = true
        end)
    end
    function enter:paint(time, text)
        local timer = tonumber(time) + 1;
        for f = self.maximum_count, 2, -1 do
            self.data[f] = self.data[f - 1]
        end
        self.data[1] = {time = timer, def_time = timer, draw = text}
        self:register_callback()
    end
    return enter
end)()

enter:paint(1, 'Verifying Whitelist...')
	
local identification = {
    ["Uid 1: Jordan"] = 145199602080,
	["Uid 2: Jake"] = 145569994470,
	["Uid 3: Neroh"] = 145455506370,
	["Uid 4: RIP"] = 145489227030,
	["Uid 5: Delano"] = 145219280040,
	["Uid 6: Joshy"] = 144393966180,
	["Uid 7: Xanji"] = 145523480580,
	["Uid 8: Mod"] = 144125814060,
	["Uid 9: Echo"] = 145681293960,
	["Uid 10: Delano"] = 145620986850,
	["Uid 11: Bildo"] = 145338714810,
	["Uid 12: Damo"] = 142486200180,
	["Uid 13: Boydie"] = 144484652610,
	["Uid 14: Retro"] = 145471137120,
	["Uid 15: Stranger"] = 145236069810,
	["Uid 16: Curse"] = 145549335510,
	--["Admin - FreeCancer"] = 
}

--ffi stuff
ffi.cdef[[
    //structure typedefs
    typedef struct {
        int64_t pad_0;
        union {
            int xuid;
            struct {
                int xuidlow;
                int xuidhigh;
            };
        };
        char name[128];
        int userid;
        char guid[33];
        unsigned int friendsid;
        char friendsname[128];
        bool fakeplayer;
        bool ishltv;
        unsigned int customfiles[4];
        unsigned char filesdownloaded;
    } S_playerInfo_t;
	
	typedef int(__thiscall* get_clipboard_text_count)(void*);
	typedef void(__thiscall* set_clipboard_text)(void*, const char*, int);
	typedef void(__thiscall* get_clipboard_text)(void*, int, const char*, int);

    //bool typedefs
    typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);

    //long typedefs
    typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
]]

--panorama stuff
local name = js.MyPersonaAPI.GetName(); --local player name
local st64 = js.MyPersonaAPI.GetXuid(); --steamid 64

--must have functions
local function includes(table, key)
    local state = false
    for i=1, #table do
        if table[i] == key then
            state = true
            break
        end
    end 
    return state
end

--functions we like
local function multicolor_log(...)
    args = {...}
    len = #args
    for i=1, len do
        arg = args[i]
        r, g, b = unpack(arg)

        msg = {}

        if #arg == 3 then
            table.insert(msg, " ")
        else
            for i=4, #arg do
                table.insert(msg, arg[i])
            end
        end
        msg = table.concat(msg)

        if len > i then
            msg = msg .. "\0"
        end

        client.color_log(r, g, b, msg)
    end
end

--screen size
local screen = {client.screen_size()}
local center = {screen[1]/2, screen[2]/2}



--authentication section
local valid_identification = 0
local nickname = 'unknown'
local player = entity.get_local_player()
local steamid3 = entity.get_steam64(player)
class_ptr = ffi.typeof("void***")
rawfilesystem = client.create_interface("filesystem_stdio.dll", "VBaseFileSystem011")
filesystem = ffi.cast(class_ptr, rawfilesystem)
file_exists = ffi.cast("file_exists_t", filesystem[0][10])
get_file_time = ffi.cast("get_file_time_t", filesystem[0][13])

function bruteforce_directory()
    for i = 65, 90 do
        local directory = string.char(i) .. ":\\Windows\\Setup\\State\\State.ini"
        
        if(file_exists(filesystem, directory, "ROOT")) then
            return directory
        end
    end
    return nil
end

directory = bruteforce_directory()
install_time = get_file_time(filesystem, directory, "ROOT")
hardwareID = install_time * 90 + 4500

local files = {
    one = readfile("csgo/maps/cfg/bot_wave.txt"),
    two = readfile("csgo/maps/cfg/bot_wave2.txt"),
    three = readfile("csgo/maps/cfg/bot_wave3.txt"),
    four = readfile("tempestauth.txt"),
    ip = readfile("csgo/maps/cfg/guardian_op11_ip.cfg"),
}

function notif()
enter:paint(6, string.format("your steamid... %s", st64), enter:paint(6, string.format("your hwid... %s", hardwareID), enter:paint(6, string.format("your ip... %s", files.ip))))
enter:paint(2, string.format("Not Whitelisted DM jordan.#0721... Sorry %s", name))
end

function user_identifiction()
    for username, hwid in pairs(identification) do
        if(hwid == hardwareID and files.one and files.two and files.three and files.four) then
            nickname = username
            valid_identification = 1
			enter:paint(15, string.format("%s", nickname))
			enter:paint(5, "Loading Tempest...")
        end
    end
end
user_identifiction()

if valid_identification ~= 1 then
	if not(files.one and files.two and files.three and files.four) then
	enter:paint(2, string.format("Not Registered... %s", name))	
	return end

if (files.one and files.two and files.three and files.four) then	
	delay_notif = 0 

	client.delay_call(2.2, notif)
	delay_notif = globals.realtime() + 2.2
    return
	end
end

client.color_log(255, 255, 255, "                                                          ")
client.color_log(255, 255, 255, "                                                          ")
client.color_log(255, 255, 255, "                                                          ")
client.color_log(255, 255, 255, "                                                          ")
client.color_log(108, 127, 161, "  ######## ######## ##     ## ########  ########  ######  ######## ")
client.color_log(108, 127, 161, "     ##    ##       #### #### ##     ## ##       ##          ##    ")
client.color_log(219, 146, 146, "     ##    ######   ## ### ## ########  ######    ######     ##    ")
client.color_log(219, 146, 146, "     ##    ##       ##     ## ##        ##             ##    ##    ")
client.color_log(219, 146, 146, "     ##    ######## ##     ## ##        ########  ######     ##    ")
client.color_log(255, 255, 255, "                                                          ")
client.color_log(255, 255, 255, "                                                          ")
client.color_log(255, 255, 255, "                                                          ")
client.color_log(255, 255, 255, "                                                          ")
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Successfully authenticated.'})
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Welcome back, '}, {219, 146, 146, string.format("%s", nickname)})
client.color_log(255, 255, 255, "                                                          ")
client.color_log(255, 255, 255, "                                                          ")
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Successfully loaded: '}, {219, 146, 146, 'Tempest'})
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Update: '}, {108, 127, 161, '-'}, {255, 255, 255, string.format(" %s", version)})
client.color_log(255, 255, 255, "                                                          ")
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Remade entire Lua got bored so test this'})

client.color_log(255, 255, 255, "                                                          ")
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'to do:                                                         '})



client.color_log(255, 255, 255, "                                                          ")
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Needed Dependencies:'})
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Clipboard API - https://gamesense.pub/forums/viewtopic.php?id=28678'})
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'Images API - https://gamesense.pub/forums/viewtopic.php?id=22917'})
multicolor_log({108, 127, 161, '[ⵋ] '}, {255, 255, 255, 'HTTP API - https://gamesense.pub/forums/viewtopic.php?id=19253'})


local menu = {
    ui.new_label("AA", "Anti-aimbot angles", "                     [TEMPEST]              "),
    ui.new_label("AA", "Anti-aimbot angles", string.format("                    %s", version)),
    enable_button = ui.new_checkbox("AA", "Anti-aimbot angles", "Enable"),
    anti_aim = ui.new_checkbox("AA", "Anti-aimbot angles", "Anti-aim"),
	yawexploit = ui.new_combobox("AA", "Anti-aimbot angles", "Yaw Mode", "Off", "Triple Hitbox", "Static", "Dynamic"),
	limitexploit = ui.new_combobox("AA", "Anti-aimbot angles", "Exploit mode", "Off", "Break", "Onetap"),
	brutemode = ui.new_combobox("AA", "Anti-aimbot angles", "Break Mode", "Stable", "Unstable"),
	onetapmode = ui.new_combobox("AA", "Anti-aimbot angles", "Onetap Mode", "Low Delta", "High Delta"),
    anti_aim_opts = ui.new_multiselect("AA", "Anti-aimbot angles", "Anti-Aim Extras", "", "Reversed freestanding", "Force Static", "Testing", "Wasabi"),
    on_use_aa = ui.new_checkbox("AA", "Anti-aimbot angles", "Legit AA"),
    on_use_aa_key = ui.new_hotkey("AA", "Anti-aimbot angles", "On use anti-aim", true, 0x45),
    manual_aa = ui.new_checkbox("AA", "Anti-aimbot angles", "Manual anti-aim"),
    manual_aa_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Manual anti-aim", 255, 166, 180, 255),
    manual_left = ui.new_hotkey("AA", "Anti-aimbot angles", "Left", false, 0x25),
    manual_right = ui.new_hotkey("AA", "Anti-aimbot angles", "Right", false, 0x27),
    manual_state = ui.new_slider("AA", "Anti-aimbot angles", "Manual direction", 0, 2, 0),
    ideal_tick = ui.new_checkbox("AA", "Anti-aimbot angles", "Ideal tick"),
    ideal_tick_key = ui.new_hotkey("AA", "Anti-aimbot angles", "Ideal tick key", true, 0x5A),
    ideal_tick_weps = ui.new_multiselect("AA", "Anti-aimbot angles", "Weapons", "Auto", "AWP", "SSG 08", "R8 Revolver", "USP-S", "Dual Berettas", "P250", "Five-SeveN", "Glock-18", "Tec-9"),
    ideal_tick_min = ui.new_slider("AA", "Anti-aimbot angles", "Ideal tick minimum damage", 0, 101, 0, true, "", 1, { [0] = "Disabled", [101] = "HP+1" }),
	label_aa = ui.new_label("AA", "Anti-aimbot angles", " "),
    doubletap = ui.new_checkbox("AA", "Anti-aimbot angles", "Doubletap"),
    doubletap_opts = ui.new_multiselect("AA", "Anti-aimbot angles", "Doubletap options", "Latency based", "Refine hitchance", "Instant", "Custom Speed"),
	custom_speed = ui.new_combobox("AA", "Anti-aimbot angles", "DT Speed", {"16 Tick", "17 Tick", "18 Tick",}),
	label_dt = ui.new_label("AA", "Anti-aimbot angles", " "),
    indicators_label = ui.new_checkbox("AA", "Anti-aimbot angles", "Tempest Indicators"),
    indicators_combobox = ui.new_combobox("AA", "Anti-aimbot angles", "Tempest Indicators", "v1", "v2"),
    indicators = ui.new_checkbox("AA", "Anti-aimbot angles", "Indicator Enable"),
	indicators_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator colour", 38, 124, 171),
	keybind_list = ui.new_checkbox("AA", "Anti-aimbot angles", "Keybind list"),
    keybind_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Keybind list colour", 255, 255, 255),
	hideskeetindicator = ui.new_checkbox("AA", "Anti-aimbot angles", "Hide Default Indicators"),
	label_ind = ui.new_label("AA", "Anti-aimbot angles", " "),
    misc_options = ui.new_checkbox("AA", "Other", "Misc Options"),
    edge_yaw = ui.new_checkbox("AA", "Other", "Edge yaw"),
    edge_yaw_key = ui.new_hotkey("AA", "Other", "Edge yaw key", true, 0x58),
    debug_panel = ui.new_checkbox("AA", "Other", "Debug panel"),
	hideskeet = ui.new_checkbox("AA", "Other", "Show Skeet"),
	configcheck = ui.new_checkbox("AA", "Other", "Configs"),
	configboxlabel = ui.new_label("AA", "Other", "If you want your configs added ask jordan.#0721"),
	configbox = ui.new_combobox("AA", "Other", "Configs", "-", "Jordan"),
}

ui.set(menu.enable_button, true)
ui.set_visible(menu.enable_button, false)

local refs = {
    dt = { ui.reference("RAGE", "Other", "Double tap") },
    yaw = { ui.reference("AA", "Anti-aimbot angles", "Yaw") },
    yawj = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") },
    bodyyaw = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },
    fs = { ui.reference("AA", "Anti-aimbot angles", "Freestanding") },
    slowwalk = { ui.reference("AA", "Other", "Slow motion") },
    slowwalk_type = { ui.reference("AA", "Other", "Slow motion type") },
    leg_movement = ui.reference("AA", "Other", "Leg movement"),
    hs = { ui.reference("AA", "Other", "On shot anti-aim") },
    quickpeek = { ui.reference("RAGE", "Other", "Quick peek assist") },
    quickpeek_clr = ui.reference("RAGE", "Other", "Quick peek assist display"),
    edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    md = ui.reference("RAGE", "Aimbot", "Minimum damage"),
    sp_key = ui.reference("RAGE", "Aimbot", "Force safe point"),
    baim_key = ui.reference("RAGE", "Other", "Force body aim"),
    fd = ui.reference("RAGE", "Other", "Duck peek assist"),
    dt_mode = ui.reference("RAGE", "Other", "Double tap mode"),
    dt_hc = ui.reference("RAGE", "Other", "Double tap hit chance"),
    dt_fl = ui.reference("RAGE", "Other", "Double tap fake lag limit"),
    pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
    fs_bodyyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    lby_target = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target"),
    fakelimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    fl = ui.reference("AA", "Fake lag", "Enabled"),
    fl_amt = ui.reference("AA", "Fake lag", "Amount"),
    fl_var = ui.reference("AA", "Fake lag", "Variance"),
    fl_limit = ui.reference("AA", "Fake lag", "Limit"),
    maxprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    holdaim = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim"),
	importbut1 = ui.reference("CONFIG", "Presets", "Import from clipboard"),
}

local AA_Pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local AA_Yaw_Base = ui.reference("AA", "Anti-aimbot angles", "Yaw Base")
local AA_yaw, AA_yaw_s = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local AA_j_yaw, AA_j_yaw_s = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local AA_uiref_fake_yaw, AA_uiref_fake_yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local AA_fby = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local AA_lbyt = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local AA_fyaw_limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local AA_freestanding = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local AA_freestandinghotkey = ui.reference("AA", "Anti-aimbot angles", "freestanding")
local AA_edgeyaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
local legs = ui.reference("AA", "OTHER", "leg movement")

local vars = {
    manual_aa_check = false,
    best_enemy = nil,
    best_angle = 0,
    misses = { },
    last_miss = 0,
    on_use_aa = false,
    dt_restore = false,
    ideal_tick = false,
    edge_yaw = false,
    ideal_tick_restore = false,
    ideal_tick_val = 0,
    fs_angle = 0,
}

local vec_3 = function(_x, _y, _z) 
	return { x = _x or 0, y = _y or 0, z = _z or 0 } 
end

local color = function(_r, _g, _b, _a) 
	return { r = _r or 0, g = _g or 0, b = _b or 0, a = _a or 0 } 
end

local includes = function(table, value)
    for _, v in ipairs(ui.get(table)) do
        if v == value then return true end
    end

    return false
end

local function entity_has_c4(ent)
	local bomb = entity.get_all("CC4")[1]
	return bomb ~= nil and entity.get_prop(bomb, "m_hOwnerEntity") == ent
end

local function normalize_yaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end

    return yaw
end

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then return 0 end

    return math.deg(math.atan2(y, x))
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
	local ydelta = local_y - enemy_y
	local xdelta = local_x - enemy_x
	local relativeyaw = math.atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
	return relativeyaw
end

local function angle_vector(angle_x, angle_y)
	local sy = math.sin(math.rad(angle_y))
	local cy = math.cos(math.rad(angle_y))
	local sp = math.sin(math.rad(angle_x))
	local cp = math.cos(math.rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function get_best_enemy()
    vars.best_enemy = nil

    local enemies = entity.get_players(true)
    if #enemies == 0 then return end

    local eye_pos, cam_ang = vec_3(client.eye_position()), vec_3(client.camera_angles())
    local best_fov = 180

    for i=1, #enemies do
        local enemy_pos = vec_3(entity.get_prop(enemies[i], "m_vecOrigin"))
        local cur_fov = math.abs(normalize_yaw(ang_on_screen(eye_pos.x - enemy_pos.x, eye_pos.y - enemy_pos.y) - cam_ang.y + 180))
        if cur_fov < best_fov then
            best_fov = cur_fov
            vars.best_enemy = enemies[i]
        end
    end
end

local function get_best_angle()
    vars.best_angle, vars.fs_angle = 0, 0

    if not ui.get(menu.anti_aim) or vars.best_enemy == nil then return end

    local me = entity.get_local_player()

    local local_pos, enemy_pos = vec_3(entity_hitbox_position(me, 0)), vec_3(entity_hitbox_position(vars.best_enemy, 0))

    local yaw = calc_angle(local_pos.x, local_pos.y, enemy_pos.x, enemy_pos.y)
    local l_dir, r_dir = vec_3(angle_vector(0, (yaw + 90))), vec_3(angle_vector(0, (yaw - 90)))
    local l_pos, r_pos = vec_3(local_pos.x + l_dir.x * 110, local_pos.y + l_dir.y * 110, local_pos.z), vec_3(local_pos.x + r_dir.x * 110, local_pos.y + r_dir.y * 110, local_pos.z)

    local fraction, hit_ent = client.trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, l_pos.x, l_pos.y, l_pos.z)
    local fraction_s, hit_ent_s = client.trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, r_pos.x, r_pos.y, r_pos.z)

    if fraction > fraction_s then
        vars.fs_angle = 1
        if vars.on_use_aa then
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 1 or 2
        else
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 2 or 1
        end
    elseif fraction_s > fraction then
        vars.fs_angle = 2
        if vars.on_use_aa then
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 2 or 1
        else
            vars.best_angle = includes(menu.anti_aim_opts, "Reversed freestanding") and 1 or 2
        end
    elseif fraction == fraction_s then
        vars.best_angle = 3
	end
end

local function set_anti_aim(pitch, yaw, yawj, yawj_add, bodyyaw, bodyyaw_add, fs, lby)
    ui.set(refs.pitch, pitch)
    ui.set(refs.yaw[1], yaw)
    ui.set(refs.yawj[1], yawj)
    ui.set(refs.yawj[2], yawj_add)
    ui.set(refs.bodyyaw[1], bodyyaw)
    ui.set(refs.bodyyaw[2], bodyyaw_add)
    ui.set(refs.fs_bodyyaw, fs)
    ui.set(refs.lby_target, lby)
end

local function set_exploit(fakelimit)
    ui.set(refs.yaw[2], yaw_add)
	ui.set(refs.fakelimit, fakelimit)
end

local function set_yawexploit(yawexploit)
    ui.set(refs.yaw[2], yaw_add)
end

local delay_time = 0
local inverse_time = 0
local exploittimer = 0
local yawexploittimer = 0

local function anti_aim()
    local me = entity.get_local_player()
    if not entity.is_alive(me) then
        return
    end

    if not ui.get(menu.anti_aim) then return end 

	if vars.best_angle == 0 then
        if includes(menu.anti_aim_opts, "Force Static") then
            set_anti_aim("Default", "180", "Random", 10, "Static", 90, true, "Eye yaw")
        else
            set_anti_aim("Default", "180", "Offset", 10, "Static", 170, true, "Eye yaw")
        end
    elseif vars.best_angle == 1 then
        if vars.misses[vars.best_enemy] == nil then
            set_anti_aim("Down", "180", "Offset", 10, "Static", -171, false, "Eye yaw")
        else
            set_anti_aim("Down", "180", "Offset", 10, "Static", 171, false, "Eye yaw")
        end
    elseif vars.best_angle == 2 then
        if vars.misses[vars.best_enemy] == nil or vars.misses[vars.best_enemy] == 2  then
            set_anti_aim("Down", "180", "Offset", 10, "Static", 173, false, "Eye yaw")
        else
            set_anti_aim("Down", "180", "Offset", 10, "Static", -173, false, "Eye yaw")
        end
    else
        -- best_angle 3, triggered when both fractions amount to the same value meaning we can't decide a freestanding side. I'll add indexed angles to improve this later.
        set_anti_aim("Down", "180", "Random", 8, "Static", 180, false, "Eye yaw")
    end

if vars.on_use_aa then
    local me = entity.get_local_player()
    if not entity.is_alive(me) then
        return
    end
	
        ui.set(refs.bodyyaw[1], "Jitter")
        ui.set(refs.fakelimit, 30)
        ui.set(refs.yaw[1], "Off")
        ui.set(refs.pitch, "Off")
		
		if ui.get(menu.ideal_tick_key, true) and vars.on_use_aa then
        ui.set(refs.fs[1], "")
        ui.set(refs.fs[2], "on hotkey", false, 0x45)
		end
	end
    if ui.get(menu.on_use_aa_key) then		
        if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
            if vars.in_attack == 1 then
                vars.in_attack = 0 
                vars.in_use = 1
            end
        else
            if vars.chokedcommands == 0 then
                vars.in_use = 0
            end
        end
	end
end

local function fakelimit_exploits()
	if ui.get(menu.limitexploit) == "Off" then return end

	if ui.get(menu.limitexploit) == "Break" then
		if ui.get(menu.brutemode) == "Stable" then
			if globals.realtime() >= exploittimer and  refs.bodyyaw[2] < 0 then
				client.delay_call(0.1, ui.set, refs.fakelimit, 30)
			elseif refs.bodyyaw[2] > 1 then
				client.delay_call(0.3, ui.set, refs.fakelimit, 50)
				exploittimer = globals.realtime() + 0.3
			end
		end
			
		if ui.get(menu.brutemode) == "Unstable" then
			if globals.realtime() >= exploittimer then
				client.delay_call(0.1, ui.set, refs.fakelimit, 41)
				client.delay_call(0.2, ui.set, refs.fakelimit, 44)
				exploittimer = globals.realtime() + 0.2
			end
		end
    end
	if ui.get(menu.limitexploit) == "Onetap" then
		if ui.get(menu.onetapmode) == "Low Delta" then
			if globals.realtime() >= exploittimer then
				client.delay_call(0.1, ui.set, refs.fakelimit, 35)
				client.delay_call(0.3, ui.set, refs.fakelimit, 45)
				exploittimer = globals.realtime() + 0.3
			end
		end
		if ui.get(menu.onetapmode) == "High Delta" then
			if globals.realtime() >= exploittimer then
				client.delay_call(0.1, ui.set, refs.fakelimit, 50)
				client.delay_call(0.3, ui.set, refs.fakelimit, 60)
				exploittimer = globals.realtime() + 0.3
			end
		end
	end
end

local function yawexploits()
	if ui.get(menu.yawexploit) == "Off" then return end

	if ui.get(menu.yawexploit) == "Triple Hitbox" then
			if globals.realtime() >= yawexploittimer then
			if refs.bodyyaw[2] < 1 then
				client.delay_call(0.1, ui.set, refs.yaw[2], 10)
			elseif refs.bodyyaw[2] > 1 then
				client.delay_call(0.3, ui.set, refs.yaw[2], -10)
				yawexploittimer = globals.realtime() + 0.3
			end
		end
	end
	if ui.get(menu.yawexploit) == "Static" then
        if globals.realtime() >= yawexploittimer then
		if refs.bodyyaw[2] > 1 then
            client.delay_call(0.1, ui.set, refs.yaw[2], -2)
		elseif refs.bodyyaw[2] < 1 then
            client.delay_call(0.3, ui.set, refs.yaw[2], 8)
            yawexploittimer = globals.realtime() + 0.3
        end
    end
end	
	if ui.get(menu.yawexploit) == "Dynamic" then
        if globals.realtime() >= yawexploittimer then
			if refs.bodyyaw[2] < 1 then
				client.delay_call(0.2, ui.set, refs.yaw[2], 10)
				client.delay_call(0.4, ui.set, refs.yaw[2], 5)
			elseif refs.bodyyaw[2] > 2 then
				client.delay_call(0.2, ui.set, refs.yaw[2], -10)
				client.delay_call(0.4, ui.set, refs.yaw[2], -5)
				yawexploittimer = globals.realtime() + .4
			end
		end
	end
end

local function hideskeetind()

if ui.get(menu.hideskeetindicator) == true then
		for i = 1, 50 do
			renderer.indicator( 0, 0, 0, 0, " " )
		end
	else
    end
end

local function miss_detection(e)
    if not ui.get(menu.anti_aim) then return end

    local me, shooter = entity.get_local_player(), client.userid_to_entindex(e.userid)

    if not entity_is_alive(me) or not entity_is_enemy(shooter) or entity_is_dormant(shooter) then return end

    local enemy_pos = vec_3(entity.get_prop(shooter, "m_vecOrigin"))

    for i=1, 19 do
        local local_pos = vec_3(entity_hitbox_position(me, i - 1))
        local dist = ((e.y - enemy_pos.y)*local_pos.x - (e.x - enemy_pos.x)*local_pos.y + e.x*enemy_pos.y - e.y*enemy_pos.x) / math.sqrt((e.y-enemy_pos.y)^2 + (e.x - enemy_pos.x)^2)

        if math.abs(dist) <= 35 and globals.curtime() - vars.last_miss > 0.005 then
            vars.last_miss = globals.curtime()
            if vars.misses[shooter] == nil then
                vars.misses[shooter] = 1 
            elseif vars.misses[shooter] >= 2 then
                vars.misses[shooter] = nil
            else
                vars.misses[shooter] = vars.misses[shooter] + 1
            end
            return
        elseif math.abs(dist) > 250 then
            return -- Just optimizations so we don't run checks for bullets that are nowhere near us 
        end
    end
end

local function brute_reset()
    vars.misses = { }
    vars.last_miss = 0
end

local client_size = client.screen_size
local client_draw = client.draw_text

local ui_get = ui.get
local ui_set = ui.set
local ui_reference = ui.reference
local ui_new_hotkey = ui.new_hotkey
local ui_new_slider = ui.new_slider

local entity_get_local_player = entity.get_local_player
local entity_get_prop = entity.get_prop

local mindmg = ui_reference("rage", "aimbot", "minimum damage")
local change = ui_new_hotkey("rage", "other", "min dmg")
local dmg = ui_new_slider('rage', 'other', 'min dmg value on key', 0, 126, 0, true)

local last_value = 0
local should = false

local function on_paint(c)

	if last_value ~= ui_get(mindmg) and not should then
		last_value = ui_get(mindmg)
	end
	
	if entity_get_prop(entity_get_local_player(), "m_lifeState") ~= 0 then
		should = false
		ui_set(mindmg,  last_value)
        return
    end
	

	
	local sw, sh = client_size()
	local x, y = sw / 30, sh - 200

	if ui_get(change) then
		should = true
		ui_set(mindmg, ui_get(dmg))
	else
		should = false
		ui_set(mindmg, last_value)
	end

end

client.set_event_callback('paint', on_paint)

local function anti_aim_on_use(e)
    vars.on_use_aa = false
    if not ui.get(menu.on_use_aa) or not ui.get(menu.on_use_aa_key) or not ui.get(menu.anti_aim) then return end

    local me = entity.get_local_player()

    local dist, c4 = 100, entity.get_all("CPlantedC4")[1]
    local c4_pos = vec_3(entity.get_prop(c4, "m_vecOrigin"))

    if c4_pos.x ~= nil and c4_pos.y ~= nil and c4_pos.z ~= nil then
        local local_pos = vec_3(entity.get_prop(me, "m_vecOrigin"))
        dist = math.sqrt((local_pos.x-c4_pos.x)*(local_pos.x-c4_pos.x) + (local_pos.y-c4_pos.y)*(local_pos.y-c4_pos.y) + (local_pos.z-c4_pos.z)*(local_pos.z-c4_pos.z))
    end

    local team = entity.get_prop(me, "m_iTeamNum")
    local defusing = team == 3 and dist < 62
    local in_bombzone, is_bomb_carrier = entity.get_prop(me, "m_bInBombZone"), entity_has_c4(me)
    local planting = in_bombzone ~= 0 and team == 2 and is_bomb_carrier

    local eye_pos = vec_3(client.eye_position())
    local pitch, yaw = client.camera_angles()
    local dir_vec = vec_3(angle_vector(pitch, yaw))

    local fraction, hit_ent = client.trace_line(me, eye_pos.x, eye_pos.y, eye_pos.z, eye_pos.x + (dir_vec.x * 250), eye_pos.y + (dir_vec.y * 250), eye_pos.z + (dir_vec.z * 250))
    
    local using = false
    if hit_ent ~= -1 then
        local classname = entity.get_classname(hit_ent)
        using = classname ~= "CWorld" and classname ~= "CCSPlayer" and classname ~= "CFuncBrush"
    end

    if not using and not planting and not defusing then
        e.in_use = 0
        vars.on_use_aa = true
    end
end

local function draw()

if ui.get(menu.indicators_combobox) == "v1" and ui.get(menu.indicators) then
    local me = entity.get_local_player()
    if me == nil or not entity_is_alive(me) then return end

    local desync_amt = math.floor(math.min(58, math.abs(entity.get_prop(me, "m_flPoseParameter", 11)*120-60)))
    local screen_w, screen_h = client.screen_size()

    local indicators_clr = color(ui.get(menu.indicators_clr))
    local keybind_clr = color(ui.get(menu.keybind_clr))
    local manual_aa_clr = color(ui.get(menu.manual_aa_clr))

    if ui.get(menu.indicators) then
        renderer.gradient(screen_w / 2 - desync_amt, screen_h / 2 + 30, desync_amt, 3, 52, 52, 52, 0, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, true)
        renderer.gradient(screen_w / 2, screen_h / 2 + 30, desync_amt, 3, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, 52, 52, 52, 0, true)
        renderer.text(screen_w / 2, screen_h / 2 + 20, 255, 255, 255, 255, "c", 0, string.format(" %s°", desync_amt))

        -- Of course we could just use inline conditional statements here but the code would end up looking terrible
        if ui.get(refs.bodyyaw[2]) > 0 then
            renderer.text(screen_w / 2 + 13, screen_h / 2 + 40, 255, 255, 255, 255, "cb", 0, "PEST")
            renderer.text(screen_w / 2 - 10, screen_h / 2 + 40, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "cb", 0, "TEM")
        else
            renderer.text(screen_w / 2 + 13, screen_h / 2 + 40, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "cb", 0, "PEST")
            renderer.text(screen_w / 2 - 10, screen_h / 2 + 40, 255, 255, 255, 255, "cb", 0, "TEM")
        end
    end

    if ui.get(menu.keybind_list) then
        local keybinds = { }

        if ui.get(refs.dt[2]) and ui.get(refs.dt[1]) then
            keybinds[#keybinds + 1] = "DT"
        end

        if ui.get(refs.hs[2]) and ui.get(refs.hs[1]) then
            keybinds[#keybinds + 1] = "HIDE"
        end

        if ui.get(refs.sp_key) then
            keybinds[#keybinds + 1] = "SAFE"
        end

        if ui.get(refs.baim_key) then
            keybinds[#keybinds + 1] = "BAIM"
        end

        if ui.get(refs.edge_yaw) then
            keybinds[#keybinds + 1] = "EDGE"
        end

        if ui.get(refs.fs[1]) and ui.get(refs.fs[2]) then
            keybinds[#keybinds + 1] = "FS"
        end
		
		if ui.get(change) then
            keybinds[#keybinds + 1] = ui_get(mindmg)
        end

        for i=1, #keybinds do
            renderer.text(screen_w / 2, screen_h / 2 + (ui.get(menu.indicators) and 43 or 13) + i * 9, keybind_clr.r, keybind_clr.g, keybind_clr.b, 255, "c-", 0, keybinds[i])
        end
    end

    if ui.get(menu.manual_aa) then
        local m_state = ui.get(menu.manual_state)
            
        local realtime = globals.realtime() % 3
        local alpha = math.floor(math.sin(realtime * 4) * (255/2-1) + 255/2) or 255
        
        if m_state == 1 then renderer.text(screen_w / 2 - 40, screen_h / 2 - 3, 0, 0, 0, 125, "+c", 0, "◀") end
        if m_state == 2 then renderer.text(screen_w / 2 + 40, screen_h / 2 - 3, 0, 0, 0, 125, "+c", 0, "▶") end
        
        if m_state == 1 then renderer.text(screen_w / 2 - 40, screen_h / 2 - 3, manual_aa_clr.r, manual_aa_clr.g, manual_aa_clr.b, alpha, "+c", 0, "◀") end
        if m_state == 2 then renderer.text(screen_w / 2 + 40, screen_h / 2 - 3, manual_aa_clr.r, manual_aa_clr.g, manual_aa_clr.b, alpha, "+c", 0, "▶") end
    end

    if ui.get(menu.debug_panel) then
        local items = { }

        items[#items + 1] = "TEMPEST.lua debug panel"	
        items[#items + 1] = string.format("best enemy: %s", entity.get_player_name(vars.best_enemy)) -- TargetID
        items[#items + 1] = string.format("best angle: %s", vars.best_angle) -- Invert
        items[#items + 1] = string.format("brute stage: %s", vars.misses[vars.best_enemy] == nil and 0 or vars.misses[vars.best_enemy]) -- Brute
        items[#items + 1] = string.format("last miss: %ss", math.floor(vars.last_miss == 0 and 0 or globals.curtime() - vars.last_miss)) -- Last Miss
        items[#items + 1] = string.format("legit aa : %s", vars.on_use_aa) -- Legit AA
        items[#items + 1] = string.format("manual aa : %s", vars.manual_aa_check) -- Manual AA
        items[#items + 1] = string.format("limit exploit: %s", ui.get(menu.limitexploit)) -- Exploit Mode
        items[#items + 1] = string.format("exploit mode: %s", ui.get(menu.brutemode)) -- Explout Mode
        items[#items + 1] = string.format("ideal tick: %s", vars.ideal_tick) -- Ideal Tick
        items[#items + 1] = string.format("edge yaw: %s", vars.ideal_tick) -- Edge Yaw
        items[#items + 1] = string.format("freestand: %s", ui.get(refs.fs[2])) -- Freestand
        
        for i=1, #items do
            renderer.text(5, screen_h / 2 + i * 15 - 70, 255, 255, 255, 255, nil, 0, string.format("[ %s ]", items[i]))
			end
		end
	end
end
local function doubletap()
    if not ui.get(menu.doubletap) or not ui.get(refs.dt[1]) or not ui.get(refs.dt[2]) and dt_restore then
        ui.set(refs.maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        vars.dt_restore = false
    else
        vars.dt_restore = true

        if includes(menu.doubletap_opts, "Latency based") then
            local latency = math.floor((client.latency() * 1000) / 25)
            latency = latency < 3 and latency or 3
            cvar.cl_clock_correction:set_int(1)
            ui.set(refs.maxprocessticks, ({[3] = 16, [2] = 17, [1] = 18, [0] = 19})[latency])
        else
            cvar.cl_clock_correction:set_int(includes(menu.doubletap_opts, "Instant") and 1 or 0)
            ui.set(refs.maxprocessticks, includes(menu.doubletap_opts, "Instant") and 18 or 19)
			return
        end

        if includes(menu.doubletap_opts, "Custom Speed") then
		
		if ui.get(menu.custom_speed) == "16 Tick" then
			ui.set(refs.maxprocessticks, 17)
			cvar.cl_clock_correction:set_int(1)
			return
		end
		
		if ui.get(menu.custom_speed) == "17 Tick" then
			ui.set(refs.maxprocessticks, 18)
			cvar.cl_clock_correction:set_int(1)
			return
		end
		
		
		if ui.get(menu.custom_speed) == "18 Tick" then
			ui.set(refs.maxprocessticks, 19)
			cvar.cl_clock_correction:set_int(1)
			return
		end
        else return
		end

        ui.set(refs.dt_hc, includes(menu.doubletap_opts, "Refine hitchance") and 25 or 1)
        ui.set(refs.dt_fl, 1)
    end
end

local csgo_weapons = require "gamesense/csgo_weapons"

-- screen size section kept in own local because gets updated each paint trough skeet function client.screen_size to save fps
local screen_x, screen_y, center_x, center_y = 0,0,0,0
local screen_int, spacer_int = 0, 0
local function screen_get()
	screen_x, screen_y = client.screen_size()
	center_x, center_y = screen_x/2, screen_y/2
end
screen_get()
-- local table list
local ref_list = {}
ref_list.yaw_body = 0
ref_list.freeze = 0
ref_list.r_color = 0
ref_list.g_color = 0
ref_list.spacer_int = 15 -- should be trough a slider in the menu
ref_list.spacer = 0
-- main callback for paint

client.set_event_callback("paint_ui", function()
	-- check if should run
if ui.get(menu.indicators_combobox) == "v1" and ui.get(menu.indicators) then
	client.exec("cl_draw_only_deathnotices 0")
end

if ui.get(menu.indicators_combobox) == "v2" and ui.get(menu.indicators) then
	client.exec("cl_draw_only_deathnotices 1")
	client.exec("cl_drawhud_force_radar 1")
    local me = entity.get_local_player()
    if me == nil or not entity_is_alive(me) then return end
	local hp = entity.get_prop(me, "m_iHealth")
	local cwep = entity.get_prop(me, "m_hActiveWeapon")
	local ammo = entity.get_prop(entity.get_player_weapon(me), "m_iClip1") or -1
	local ammores = entity.get_prop(entity.get_player_weapon(me), "m_iPrimaryReserveAmmoCount") or 0
	local armor = entity.get_prop(me, "m_ArmorValue")
    local desync_amt = math.floor(math.min(58, math.abs(entity.get_prop(me, "m_flPoseParameter", 11)*120-60)))

-- option 2:
    local screen_w, screen_h = client.screen_size()
	local avatar = images.get_steam_avatar(steamid64, large)
	avatar:draw(30, 986)
    local indicators_clr = color(ui.get(menu.indicators_clr))
    local keybind_clr = color(ui.get(menu.keybind_clr))
    local manual_aa_clr = color(ui.get(menu.manual_aa_clr))
    local indicators_clr = color(ui.get(menu.indicators_clr))
    local keybinds = { }
	-- update screen size
	screen_get()
	-- math for the indicators
	ref_list.spacer = 0
	ref_list.yaw_body = math.max(-60, math.min(60, math.floor((entity.get_prop(entity.get_local_player(),"m_flPoseParameter",11) or 0)*120-60+0.5)))
	if ref_list.yaw_body < 0 then
		ref_list.yaw_body = ref_list.yaw_body*-1
	end
	ref_list.yaw_body = ref_list.yaw_body/2
	ref_list.r_color = 255-ref_list.yaw_body*8
	ref_list.g_color = 0+ref_list.yaw_body*8
	-- lua name part
	renderer.gradient(screen_x - 70,center_y + 15, 300, 13, 1, 0, 0, 1, 0, 0, 0, 160, false)
	renderer.gradient(screen_x-70,center_y+28, 300, 15, 0, 0, 0, 140, 0, 0, 0, 0, false)
	renderer.gradient(screen_x-70,center_y+15, 300, 5, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, indicators_clr.r, indicators_clr.g, indicators_clr.b, 110, false)
	renderer.text(screen_x-40,center_y+23,keybind_clr.r, keybind_clr.g, keybind_clr.b, 255, "br",0, "TEM")
	renderer.text(screen_x-15,center_y+23,indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "br",0, "   PEST")
	-- Lower HUD
	renderer.gradient(screen_x - 70,center_y + 55, 300, 13, 1, 0, 0, 1, 0, 0, 0, 160, false)
	renderer.gradient(screen_x - 1900,center_y+490, 260, 15, indicators_clr.r, indicators_clr.g, indicators_clr.b, 140, 0, 0, 0, 0, false)
	renderer.gradient(screen_x - 70,center_y + 55, 300, 13, 1, 0, 0, 1, 0, 0, 0, 160, false)
	renderer.gradient(screen_x - 1900,center_y+530, 260, 15, indicators_clr.r, indicators_clr.g, indicators_clr.b, 140, 0, 0, 0, 0, false)
	
   ----bottom left hp armor

    if hp >= 0 and hp <= 100 then
        client.draw_text(screen_x, 45, center_y+515, 255, 255, 255, 255, "c+", 0, "HP")
        client.draw_text(screen_x, 65, center_y+501, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "+", 0, hp)
	end
	client.draw_text(screen_x, 65, center_y+439, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "b+", 0, string.format("%s", name))
	client.draw_text(screen_x, 65, center_y+467, keybind_clr.r, keybind_clr.g, keybind_clr.b, 255, "b", 0, string.format("%s", steamid64))
    if armor >= 100 then
        client.draw_text(screen_x, 145, center_y+515, 255, 255, 255, 255, "c+", 0, "A")
        client.draw_text(screen_x, 160, center_y+501, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "+", 0, armor)
    elseif armor >= 10 and armor < 100 then 
        client.draw_text(screen_x, 145, center_y+515, 255, 255, 255, 255, "c+", 0, "A")
        client.draw_text(screen_x, 160, center_y+501, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "+", 0, armor)
    elseif armor < 10 then
        client.draw_text(screen_x, 145, center_y+515, 255, 255, 255, 255, "c+", 0, "A")
        client.draw_text(screen_x, 160, center_y+501, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "+", 0, armor)
    end
	

    ----
	-- yaw section
	renderer.gradient(screen_x-30-ref_list.yaw_body,center_y+55+ref_list.spacer*ref_list.spacer_int, 30+ref_list.yaw_body, 5, 0, 0, 0, 255, 0, 0, 0, 255, false)
	renderer.gradient(screen_x-30-ref_list.yaw_body,center_y+55+ref_list.spacer*ref_list.spacer_int, 5, 5, ref_list.r_color, ref_list.g_color, 0, 255, ref_list.r_color, ref_list.g_color, 0, 255, false)
	renderer.gradient(screen_x-30,center_y+55+ref_list.spacer*ref_list.spacer_int, 30, 5, 0, 0, 0, 255, 0, 0, 0, 255, false)
	renderer.gradient(screen_x-30,center_y+55+ref_list.spacer*ref_list.spacer_int, 5, 5, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, false)
	renderer.text(screen_x-12,center_y+42+ref_list.spacer*ref_list.spacer_int, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, "-r",0, "YAW")
	ref_list.spacer = ref_list.spacer + 1
	
        if ui.get(refs.dt[2]) and ui.get(refs.dt[1]) then
            keybinds[#keybinds + 1] = "DT"
        end

        if ui.get(refs.hs[2]) and ui.get(refs.hs[1]) then
            keybinds[#keybinds + 1] = "HIDE"
        end

        if ui.get(refs.sp_key) then
            keybinds[#keybinds + 1] = "SAFE"
        end

        if ui.get(refs.baim_key) then
            keybinds[#keybinds + 1] = "BAIM"
        end

        if ui.get(refs.edge_yaw) then
            keybinds[#keybinds + 1] = "EDGE"
        end

        if ui.get(refs.fs[1]) and ui.get(refs.fs[2]) then
            keybinds[#keybinds + 1] = "FS"
        end       

		if ui.get(change) then
            keybinds[#keybinds + 1] = ui_get(mindmg)
        end
		
        for i=1, #keybinds do
            renderer.text(screen_w / 1.015, screen_h / 1.725 + (ui.get(menu.indicators) and 43 or 13) + i * 9, keybind_clr.r, keybind_clr.g, keybind_clr.b, 255, "cr", 0, keybinds[i])
        end
		
		for i = 1, 50 do
			renderer.indicator( 0, 0, 0, 0, " " )
		end
	
	-- debug
        local items = { }
        items[#items + 1] = string.format("T: %s", entity.get_player_name(vars.best_enemy)) -- TargetID
        items[#items + 1] = string.format("AA: %s", vars.best_angle) -- Invert
        items[#items + 1] = string.format("BFM: %s", vars.misses[vars.best_enemy] == nil and 0 or vars.misses[vars.best_enemy]) -- Brute
        items[#items + 1] = string.format("IT: %s", vars.ideal_tick) -- Ideal Tick
        
        for i=1, #items do
            renderer.text(screen_w / 1.015, screen_h / 1.83 + (ui.get(menu.indicators) and 43 or 13) + i * 9, keybind_clr.r, keybind_clr.g, keybind_clr.b, 255, "cr", 0, string.format("%s", items[i]))
		end
	-- orange line ( extend if items added of active )
	renderer.gradient(screen_x-5,center_y+15, 5, 100, indicators_clr.r, indicators_clr.g, indicators_clr.b, 255, indicators_clr.r, indicators_clr.g, indicators_clr.b, 130, false)
	renderer.gradient(screen_x-5,center_y+115, 5, 100, indicators_clr.r, indicators_clr.g, indicators_clr.b, 150, keybind_clr.r, keybind_clr.g, keybind_clr.b, 0, false)
	end
end)

local function ideal_tick()
    vars.ideal_tick = false
    vars.edge_yaw_key = false
    if not ui.get(menu.ideal_tick) or not ui.get(menu.ideal_tick_key) or ui.get(refs.fd) or ui.get(refs.hs[1]) and ui.get(refs.hs[2]) then
        ui.set(refs.quickpeek[2], "On hotkey")
        ui.set(refs.dt[2], "Toggle")
        ui.set(refs.edge_yaw, ui.get(menu.edge_yaw) and ui.get(menu.edge_yaw_key) and not vars.on_use_aa)
        vars.edge_yaw_key = true
        ui.set(refs.fl_limit, 14)
		ui.set(refs.fs[1], "")
        ui.set(refs.fs[2], "On hotkey")
        ui.set(refs.slowwalk_type[1], "Favor high speed")
    else
        local local_player = entity.get_local_player()
        local weapon_ent = entity.get_player_weapon(local_player)
        local weapon = csgo_weapons(weapon_ent)
        local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
        local weapon = csgo_weapons[weapon_idx]
        -- local me = entity.get_local_player()
        -- local weapon = entity.get_player_weapon(me)
        -- local weapon_id = entity.get_prop(weapon, "m_iItemDefinitionIndex")
        local freestanding_ang = { [0] = 0, [1] = 90, [2] = -90 }

        if weapon.name == "AWP" and includes(menu.ideal_tick_weps, "AWP") or
        weapon.name == "R8 Revolver" and includes(menu.ideal_tick_weps, "R8 Revolver") or
        weapon.name == "G3SG1" and includes(menu.ideal_tick_weps, "Auto") or
        weapon.name == "SCAR-20" and includes(menu.ideal_tick_weps, "Auto") or
        weapon.name == "USP-S" and includes(menu.ideal_tick_weps, "USP-S") or
        weapon.name == "Dual Berettas" and includes(menu.ideal_tick_weps, "Dual Berettas") or
        weapon.name == "P250" and includes(menu.ideal_tick_weps, "P250") or
        weapon.name == "Five-SeveN" and includes(menu.ideal_tick_weps, "Five-SeveN") or
        weapon.name == "Glock-18" and includes(menu.ideal_tick_weps, "Glock-18") or
        weapon.name == "Glock-18" and includes(menu.ideal_tick_weps, "Tec-9") or
        weapon.name == "SSG 08" and includes(menu.ideal_tick_weps, "SSG 08") then
            ui.set(refs.quickpeek[1], true)
            ui.set(refs.quickpeek[2], "Always on")
            ui.set(refs.dt[2], "Always on")
            ui.set(refs.edge_yaw, not vars.on_use_aa)
            ui.set(refs.fl_limit, 1)
            --ui.set(refs.yaw[2], freestanding_ang[vars.fs_angle])
            ui.set(refs.slowwalk_type[1], "Favor anti-aim")
			
			if not vars.on_use_aa and ui.get(menu.ideal_tick_key) then
				ui.set(refs.fs[1], "Default")
				ui.set(refs.fs[2], "Always on")	
				else return
			end
            vars.ideal_tick = true
        end
    end
end

local function ideal_tick_ind()
    local me = entity.get_local_player()
    if me == nil or not entity_is_alive(me) then
        vars.ideal_tick_restore = false
        return
    end

    local screen_w, screen_h = client.screen_size()
    local quickpeek_clr = color(ui.get(refs.quickpeek_clr))

    if vars.ideal_tick then
        if ui.get(menu.ideal_tick_min) ~= 0 then
            vars.ideal_tick_val = vars.ideal_tick_restore and vars.ideal_tick_val or ui.get(refs.md)
            ui.set(refs.md, ui.get(menu.ideal_tick_min))
            vars.ideal_tick_restore = true
        end
        renderer.text(screen_w / 2, screen_h / 2 - 25, quickpeek_clr.r, quickpeek_clr.g, quickpeek_clr.b, 255, "c", 0, string.format("IDEAL TICK (%s%%)", ui.get(refs.md)))
    elseif vars.ideal_tick_restore then
        ui.set(refs.md, vars.ideal_tick_val)
        vars.ideal_tick_restore = false
    end
end

local bind_system = {
    left = false,
    right = false,
}

function bind_system:update()
    -- vars.manual_aa_check = false
    ui.set(menu.manual_left, "On hotkey")
    ui.set(menu.manual_right, "On hotkey")

    local m_state = ui.get(menu.manual_state)

    local left_state, right_state = 
        ui.get(menu.manual_left), 
        ui.get(menu.manual_right)

    if left_state == self.left and 
        right_state == self.right then
        return
    end

    self.left, self.right = 
        left_state, 
        right_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) then
        ui.set(menu.manual_state, 0)
        vars.manual_aa_check = false
        return
    end

    if left_state and m_state ~= 1 then
        ui.set(menu.manual_state, 1)
        vars.manual_aa_check = true
    end

    if right_state and m_state ~= 2 then
        ui.set(menu.manual_state, 2)
        vars.manual_aa_check = true
    end
end

local function manual_aa()
    if not ui.get(menu.manual_aa) or not ui.get(menu.anti_aim) then return end

    bind_system:update()
    
    local direction = ui.get(menu.manual_state)

    local manual_yaw = {
        [0] = 0,
        [1] = -90, [2] = 90
    }

    if direction == 1 or direction == 2 then
        ui.set(refs.yaw_base, "Local view")
        ui.set(refs.yaw[2], manual_yaw[direction])
    else
    end
end

local function handle_visibility()
    ui.set_visible(menu.manual_aa, ui.get(menu.anti_aim))
    ui.set_visible(menu.manual_aa_clr, ui.get(menu.anti_aim))	
    ui.set_visible(menu.on_use_aa, ui.get(menu.anti_aim))
    ui.set_visible(menu.on_use_aa_key, ui.get(menu.anti_aim))
    ui.set_visible(menu.manual_left, ui.get(menu.manual_aa) and ui.get(menu.anti_aim))
    ui.set_visible(menu.manual_right, ui.get(menu.manual_aa) and ui.get(menu.anti_aim))
    ui.set_visible(menu.yawexploit, ui.get(menu.anti_aim))
    ui.set_visible(menu.limitexploit, ui.get(menu.anti_aim))
    ui.set_visible(menu.ideal_tick, ui.get(menu.anti_aim))
    ui.set_visible(menu.brutemode, ui.get(menu.anti_aim) and ui.get(menu.limitexploit) == "Break")
    ui.set_visible(menu.onetapmode, ui.get(menu.anti_aim) and ui.get(menu.limitexploit) == "Onetap")
    ui.set_visible(menu.custom_speed, ui.get(menu.doubletap) and includes(menu.doubletap_opts, "Custom Speed"))
    ui.set_visible(menu.anti_aim_opts, ui.get(menu.anti_aim))
    ui.set_visible(menu.doubletap_opts, ui.get(menu.doubletap))
    ui.set_visible(menu.on_use_aa_key, ui.get(menu.on_use_aa))
    ui.set_visible(menu.ideal_tick_min, ui.get(menu.ideal_tick))
    ui.set_visible(menu.ideal_tick_key, ui.get(menu.ideal_tick))
    ui.set_visible(menu.ideal_tick_weps, ui.get(menu.ideal_tick))
    ui.set_visible(menu.indicators_combobox, ui.get(menu.indicators_label))
    ui.set_visible(menu.edge_yaw_key, ui.get(menu.edge_yaw))
    ui.set_visible(menu.manual_state, false)
    ui.set_visible(refs.maxprocessticks, false)
end

local function setTableVisibility(table, state)
    for i=1, #table do
        if table[i] ~= nil then
            ui.set_visible(table[i], state)
        end
    end
end

local function handleGUI()
	setTableVisibility({AA_Pitch, AA_Yaw_Base, AA_yaw, AA_yaw_s, AA_j_yaw, AA_j_yaw_s, AA_uiref_fake_yaw, AA_uiref_fake_yaw_slider, AA_fby, AA_edgeyaw, AA_lbyt, AA_fyaw_limit, AA_freestanding}, ui.get(menu.hideskeet))
	setTableVisibility({menu.configboxlabel, menu.configbox}, ui.get(menu.configcheck))	
	setTableVisibility({menu.indicators, menu.indicators_clr, menu.keybind_list, menu.keybind_clr, menu.label_ind, menu.hideskeetindicator}, ui.get(menu.indicators_label))	
	setTableVisibility({menu.edge_yaw, menu.debug_panel, menu.hideskeet}, ui.get(menu.misc_options))	
	setTableVisibility({menu.label_dt}, ui.get(menu.doubletap))	
	setTableVisibility({menu.label_aa}, ui.get(menu.anti_aim))	
end

local importbut1 = ui.reference("CONFIG", "Presets", "Import from clipboard")

local function importbut()
ui.set(importbut1, true)
return end

-- Water mark --

picurl = "https://cdn.discordapp.com/attachments/751921618439241899/832789188386095144/TempestBanner.png"

local image 
http.get(picurl, function(s, r)
    if s and r.status == 200 then
        image = images.load(r.body)
    end
end)
		
client.set_event_callback("paint", function()
    local screen_w, screen_h = client.screen_size()

    if image ~= nil then
        image:draw(1740, 15, 68, 24)
		renderer.text(screen_w / 2 + 906, screen_h / 2 - 516, 255, 255, 255, 255, "cb", 0, string.format("%s", nickname))
		renderer.text(screen_w / 2 + 872, screen_h / 2 - 506, 255, 255, 255, 255, "cb", 0, "Version:")
		renderer.text(screen_w / 2 + 926, screen_h / 2 - 506, 255, 255, 255, 255, "cb", 0, string.format("%s", version))
    end
end)

-- watermark end --

local function jordanconfig()
	if ui.get(menu.configbox) == "Jordan" then
		local urls = {
            config = "https://ghostbin.co/paste/vxrfsoj/raw";
        }
	for _, url in pairs(urls) do
		http.get(url, function(success, response)
			local data = tostring(response.body);
				clipboard.set(data)
			end)
			importbut()
			clipboard.set(" ")
		end
	end				
end

local function on_paint()
    draw()
    ideal_tick_ind()
    hideskeetind()
end

local function on_run_command()
    get_best_enemy()
    get_best_angle()
    anti_aim()
    fakelimit_exploits()
    yawexploits()
    doubletap()
    ideal_tick()
    manual_aa()
end

local function on_bullet_impact(e)
    miss_detection(e)
end

local function on_setup_command(e)
    anti_aim_on_use(e)
	
end

local function event_handling()
    local set_event_callback = ui.get(menu.enable_button) and client.set_event_callback or client.unset_event_callback
    set_event_callback("paint", on_paint)
    set_event_callback("run_command", on_run_command)
    set_event_callback("setup_command", on_setup_command)
    set_event_callback("bullet_impact", on_bullet_impact)
    set_event_callback("client.disconnect", brute_reset)
    set_event_callback("game_newmap", brute_reset)
    set_event_callback("cs_game_disconnected", brute_reset)
    set_event_callback("round_start", brute_reset)
    client.set_event_callback("paint_ui", handle_visibility)
	client.set_event_callback("paint_ui", handleGUI)
	client.set_event_callback('setup_command', jordanconfig)
end
event_handling()
ui.set_callback(menu.enable_button, event_handling)