--[[
	id: TvlTk11MV1d1QVKEZxo2W
	name: 123
	description: 12313
	time1: 2021-07-05 23:44:21.033068+00
	time2: 2021-07-05 23:44:21.033069+00
	uploader: 2dDk5X5bQ5m-WsISYF2bN5Qf_NwTuvrcmZkaOS-S
	uploadersession: j7ovzjm9yNMeRzQ--8rrURFQiWzM9R
	flag: f
--]]

   --Author：skyness1337
    --逻辑套用
    local success, surface = pcall(require, 'gamesense/surface')
    local surface_measure_text, surface_draw_text = surface.measure_text, surface.draw_text
    if not success then
        error('\n\n - 滚去订阅数据库 \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n')
    end
    local csgo_weapons = require "gamesense/csgo_weapons" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=18807/", 2)
    local images = require "gamesense/images" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=22917/", 2)
    local verdana = surface.create_font('verdana', 12, 400, { 0x200 --[[ Outline ]] })
    local custom_font = surface.create_font('Small Pixel', 8, 400, { 0x200 --[[ Outline ]] })
    require 'bit'

    --ui归类
    local active = true
if active then
    local client_camera_angles, client_latency, client_screen_size, client_set_event_callback, entity_get_local_player, entity_get_player_resource, entity_get_player_weapon, entity_get_prop, entity_hitbox_position, entity_is_alive, globals_chokedcommands, globals_curtime, globals_tickcount, globals_tickinterval, math_abs, math_ceil, math_floor, math_max, math_min, renderer_gradient, renderer_indicator, renderer_load_svg, renderer_measure_text, renderer_rectangle, renderer_text, renderer_texture, table_insert, tonumber, unpack, pairs, type = client.camera_angles, client.latency, client.screen_size, client.set_event_callback, entity.get_local_player, entity.get_player_resource, entity.get_player_weapon, entity.get_prop, entity.hitbox_position, entity.is_alive, globals.chokedcommands, globals.curtime, globals.tickcount, globals.tickinterval, math.abs, math.ceil, math.floor, math.max, math.min, renderer.gradient, renderer.indicator, renderer.load_svg, renderer.measure_text, renderer.rectangle, renderer.text, renderer.texture, table.insert, tonumber, unpack, pairs, type
    local globals_realtime, globals_absoluteframetime, globals_chokedcommands, globals_oldcommandack, globals_tickcount, globals_commandack, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.chokedcommands, globals.oldcommandack, globals.tickcount, globals.commandack, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
    local  entity_get_players, client_eye_position, client_trace_bullet, client_scale_damage, entity_get_classname = entity.get_players, client.eye_position, client.trace_bullet, client.scale_damage, entity.get_classname 
    local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect, ui_is_menu_open, ui_new_hotkey, ui_set, ui_update, ui_menu_size, ui_name, ui_menu_position, ui_set_callback, ui_new_button, ui_new_label, ui_new_string, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect, ui.is_menu_open, ui.new_hotkey, ui.set, ui.update, ui.menu_size, ui.name, ui.menu_position, ui.set_callback, ui.new_button, ui.new_label, ui.new_string, ui.get
    local script = {
        menu = { "AA", "Anti-aimbot angles" },
        active = true,
    }

    local antiaims_mode = { 

    ["Epoch"] = {
        yaw = {
            [1] = false,  -- yaw角度 
            [true] = -5,    
            [false] = -5
        },
        yaw_jt = {
            [1] = "Offset", -- yaw jitter类型
            [2] = 5     -- yaw jitter角度
        },
        byaw = {
            [1] = "Static",   --body yaw类型
            [2] = true,
            [true] = 90,      --body yaw角度
            [false] = -90     --body yaw角度(abf)
        }
        }, 
        
        --以下是jitter条件下角度
        ["JITTER"] = {
            yaw = {
                [1] = false,
                [true] = -8,    -- yaw角度
                [false] = -8
            },
            yaw_jt = {
                [1] = "Offset",   -- yaw jitter类型
                [2] = 5        -- yaw jitter角度
            },
            byaw = {
                [1] = "Jitter",   --body yaw类型
                [2] = true,
                [true] = 0,    --body yaw角度
                [false] = 0    --body yaw角度(abf)
            }
            }         
        }
    
        

    local manual_aa = {
        "Override manual left", "Override manual right", "Override manual back"
    }


    local fr_disablers = {
        "On duck",
        "On fake duck",
        "On slow motion",
        "In air"
    }

    local byaw_conditions = {
        "Off",
        "Reverse",
        "Smart"
    }

    local anti_bf_conditions = {
        "On hit",
        "On miss",
        "On shot"
    }

    local anti_aim_indication = {
        "Off",
        "Style 1",
        "Style 2",
    }

    local text_indication = {
        "Off",
        "Style 1",
        "Style 2",
    }

    local other_indicators = {
        "Yaw status", 
        "Current status", 
        "Doubletap", 
        "Min damage", 
        "Fakeduck", 
        "Hideshots", 
        "Force body aim", 
        "Force safepoint", 
    }

    local jitter_conditions = {
        "Jitter on dormant",
        "Jitter when vulnerable",    
    }


    local copy_aa_mode = {}
    local text_font_copy = {}

    for i, k in pairs(antiaims_mode) do
        table.insert(copy_aa_mode, i)
        table.sort(copy_aa_mode)
    end


    function script:call(func, name, ...)
        if func == nil then
            return
        end

        local end_name = name[2] or ""

        if name[1] ~= nil then
            end_name = end_name ~= "" and (end_name .. " ") or end_name
            end_name = end_name .. "\n " .. name[1]
        end

        return func(self.menu[1], self.menu[2], end_name, ...)
    end

    local function includes(table, key)
        for i=1, #table do
            if table[i] == key then
                return true
            end
        end
        return false
    end

    local active = script:call(ui.new_checkbox, { "active", "Enable Epoch antiaim" })
    local modeswitch = ui.new_combobox("AA", "Anti-Aimbot Angles", "Mode", {"-" ,"Anti-Aim", "Exploits", "Misc", "Visual"})
    --anti-aim
    local condition = script:call(ui.new_combobox, { "condition", "Anti-aim mode" }, copy_aa_mode)
    local edge_yaw = script:call(ui.new_hotkey, { "edge_yaw", "Smart edge yaw" })
    local freestanding = script:call(ui.new_hotkey, { "freestanding", "Freestanding" })
    local freestand_disablers = script:call(ui.new_multiselect, { "freestand_disablers", 'Freestand disablers' }, fr_disablers)
    local manual_inverter = script:call(ui.new_hotkey, { "manual_inverter", "Manual Inverter" })
    local dangerous = script:call(ui.new_hotkey, { "dangerous", "Slow motion dodge" })
    local randomize_fake_limit = script:call(ui.new_hotkey, { "randomize_fake_limit", "Randomize fake limit" })
    local legit_aa_on_e = script:call(ui.new_checkbox, { "legit_aa_on_e", "Legit anti-aim on use key" })
    local manual_anti_aims = script:call(ui.new_multiselect, { "manual_anti_aims", "Manual anti-aim" }, manual_aa)
    local manual_state = script:call(ui.new_slider, { "manual_state", nil }, 0, 3, 0)
    local manual_left = script:call(ui.new_hotkey, { "manual_left", manual_aa[1] })
    local manual_right = script:call(ui.new_hotkey, { "manual_right", manual_aa[2] })
    local manual_back = script:call(ui.new_hotkey, { "manual_back", manual_aa[3] })
    local byaw_cond = script:call(ui.new_combobox, { "byaw_cond", "Adaptive body yaw freestanding" }, byaw_conditions)
    local antibf_cond = script:call(ui.new_multiselect, { "antibf_cond", "Anti-bruteforce conditions" }, anti_bf_conditions)
    local jt_vis = script:call(ui.new_multiselect, { "jt_vis", "Jitter conditions" }, jitter_conditions)
    --visual
    local anti_aim_indicators = script:call(ui.new_combobox, { "anti_aim_indication", "Arrows styles" }, anti_aim_indication)
    local manual_arrows = script:call(ui.new_checkbox, {"manual aa indicators", "Manual aa indicators"})
    local anti_aim_indicators_color1 = script:call(ui.new_color_picker, { "anti_aim_indication_color1", "Manual anti-aim arrows color" }, 0, 255, 255, 255)
    local body_arrows = script:call(ui.new_checkbox, {"body yaw indicators", "Body yaw indicators"})
    local anti_aim_indicators_color = script:call(ui.new_color_picker, { "anti_aim_indication_color2", "Body yaw arrows color" }, 255, 0, 0, 255)
    local peek_arrows = script:call(ui.new_checkbox, {"On peek indicators", "On peek indicators"})
    local arr_dst = script:call(ui.new_slider, { "arr_dst", "Arrow distance" }, 1, 40, 12, true, "%")
    local text_indicators = script:call(ui.new_combobox, { "text_ind", "Text indicators" }, text_indication)
    local other_indication = script:call(ui.new_multiselect, { "other_indication", 'Indicators list' }, other_indicators)
    local other_indication_dst = script:call(ui.new_slider, { "other_indication_dst", "Indicators list distance" }, 0, 60, 0)
    --misc
    local hide_default_inds = ui.new_checkbox("AA", "Anti-aimbot angles", "Hide default indicators")
    local camcollsion = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Disable Cam Collision")
    local new_slider = ui.new_slider("AA", "Anti-Aimbot Angles", "Thirdperson delta", 0, 150, 150)
    local epochtag_enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "Epoch tag")
    --exploits
    local betterfl = ui.new_checkbox("AA", "Anti-aimbot angles", "Adaptive fakelag")
    local onshotadaptive = ui.new_checkbox("AA", "Anti-aimbot angles", "Automatic on shot(Scout/Awp)")
    local enable_slide = ui.new_checkbox("AA", "Anti-aimbot angles", "Better leg movement")
    local fake_up = ui.new_checkbox("AA", "Anti-aimbot angles", "Fake up on land")
    local anti_knife = ui.new_checkbox("AA", "Anti-aimbot angles", "Anti-knife")


    local compare = function(tab, val)
        for i = 1, #tab do
            if tab[i] == val then
                return true
            end
        end

        return false
    end

    local duration = 40
    local clantags = {
     "E"
    , "Ep"
    , "Epo"
    , "Epoc"
    , "Epoch"
    , "Epoch"
    , "Epoch"
    , "Epoch"
    , "poch"
    , "och"
    , "ch"
    , "h"
    , "E"
    , }

    label1 = ui.new_label("AA", "Anti-aimbot angles", "|────────────────────────────────|")
    label2 = ui.new_label("AA", "Anti-aimbot angles", "                         Epoch                    ")
    label3 = ui.new_label("AA", "Anti-aimbot angles", "         Owned by Get1ose & W3G           ")



    label4 = ui.new_label("AA", "Anti-aimbot angles", "         Last Updated:2021-7-5")
    label5 = ui.new_label("AA", "Anti-aimbot angles", "                         Epoch                    ")
    label6 = ui.new_label("AA", "Anti-aimbot angles", "|────────────────────────────────|")

    -- REFERENCE
    aa_active = ui.reference("AA", "Anti-aimbot angles", "Enabled")
    pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
    base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
    yaw, yaw_num = ui.reference("AA", "Anti-aimbot angles", "Yaw")
    yaw_jt, yaw_jt_num = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
    body, body_num = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
    limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
    fl_active = ui.reference("AA", "Fake lag", "Enabled")
    fr_bodyyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
    fr, fr_hk = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
    edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
    slowmo, slowmo_key = ui.reference("AA", "Other", "Slow motion")
    safe = ui.reference("RAGE", "Aimbot", "Force safe point")
    baim = ui.reference("RAGE", "Other", "Force body aim")
    ref_sp_key = ui.reference("RAGE", "Aimbot", "Force SAFE point")
    ref_baim_key = ui.reference("RAGE", "Other", "Force body aim")
    fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
    onshot, onshot_hk = ui.reference("AA", "Other", "On shot anti-aim")
    dtap, dtap_hk = ui.reference("RAGE", "Other", "Double tap")
    mindmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
    fakelag = ui.reference("AA", "Fake lag", "Limit")
    default_reference = ui.reference("MISC", "Miscellaneous", "Clan tag spammer")
    ref_fakelag_limit = ui.reference ("AA", "Fake lag", "Limit")
    ref_fl_amt = ui.reference("AA", "Fake lag", "Amount")
    ref_fl_var = ui.reference("AA", "Fake lag", "Variance")
    quick_peek_box, quick_peek_key = ui.reference( "Rage", "Other", "Quick peek assist" )
    ground_ticks, end_time = 1, 0


    --组名
local clantag_prev
function run_tag_animation()
if ui.get(epochtag_enabled) then
  local cur = math.floor(globals.tickcount() / duration) % #clantags
  local clantag = clantags[cur+1]

  if clantag ~= clantag_prev then
    clantag_prev = clantag
    client.set_clan_tag(clantag)
  end
  end
end


client.set_event_callback("run_command", function(c)
    chokedcmds = c.chokedcommands 
end)

local was_enabled = false
local function on_run_command(c)
    if ui.get(epochtag_enabled) then
        if (chokedcmds == 0) or not (entity.is_alive(entity.get_local_player())) then
            run_tag_animation()
            was_enabled = true
        end
    elseif (not ui.get(epochtag_enabled) and not ui.get(default_reference)) and was_enabled then
        client.set_clan_tag("\0")
        was_enabled = false
    end
end
client.set_event_callback("paint", on_run_command)

    -- CONTROLLERS
    local ffi_cache = { }
    local invoke_cache = function(b, c, d)
        local e = function(f, g, h)
            local i = {
                [0] = 'always on',
                [1] = 'on hotkey',
                [2] = 'toggle',
                [3] = 'off hotkey'
            }
            local j = tostring(f)
            local k = ui.get(f)
            local l = type(k)
            local m, n = ui.get(f)
            local o = n ~= nil and n or (l == 'boolean' and tostring(k) or k)
            ffi_cache[j] = ffi_cache[j] or o;
            if g then
                ui.set(f, n ~= nil and i[h] or h)
            else
                if ffi_cache[j] ~= nil then
                    local p = ffi_cache[j]
                    if l == 'boolean' then
                        if p == 'true' then p = true end
                        if p == 'false' then p = false end
                    end
                    ui.set(f, n ~= nil and i[p] or p)
                    ffi_cache[j] = nil
                end
            end
        end;
        if type(b) == 'table' then
            for q, r in pairs(b) do e(q, r[1], r[2]) end
        else
            e(b, c, d)
        end
    end
    local set_vis = function(table)
        for i, k in pairs(table) do
            ui.set_visible(i, k)
        end 
    end

    local get_color = function(number, max, i)
        local Colors = {
            { 255, 0, 0 }, { 237, 27, 3 }, { 235, 63, 6 }, { 229, 104, 8 },
            { 228, 126, 10 }, { 220, 169, 16 }, { 213, 201, 19 }, { 176, 205, 10 }, { 124, 195, 13 }
        }

        local math_num = function(int, max, declspec)
            local int = (int > max and max or int)
            local tmp = max / int;

            if not declspec then declspec = max end

            local i = (declspec / tmp)
            i = (i >= 0 and math_floor(i + 0.5) or math_ceil(i - 0.5))

            return i
        end

        i = math_num(number, max, #Colors)

        return
            Colors[i <= 1 and 1 or i][1], 
            Colors[i <= 1 and 1 or i][2],
            Colors[i <= 1 and 1 or i][3],
            i
    end
    
    --color log
    local function multicolor_log(...)
        args = { ... }
        len = #args
        for i = 1, len do
            arg = args[i]
            r, g, b = unpack(arg)
    
            msg = {}
    
            if #arg == 3 then
                table.insert(msg, " ")
            else
                for i = 4, #arg do
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

    --freestanding
    local brute = {
        indexed_angle = 0,
        best_angle = 0,
        hit_reverse = { },
        yaw_status = "DEFAULT",
        status = "STANDING",
    }

    local function normalize_yaw(yaw)
        while yaw > 180 do yaw = yaw - 360 end
        while yaw < -180 do yaw = yaw + 360 end
        return yaw
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
    
    local function ang_on_screen(x, y)
        if x == 0 and y == 0 then return 0 end
    
        return math.deg(math.atan2(y, x))
    end
    
    local vec_3 = function(_x, _y, _z) 
        return { x = _x or 0, y = _y or 0, z = _z or 0 } 
    end
    
    local function angle_vector(angle_x, angle_y)
        local sy = math.sin(math.rad(angle_y))
        local cy = math.cos(math.rad(angle_y))
        local sp = math.sin(math.rad(angle_x))
        local cp = math.cos(math.rad(angle_x))
        return cp * cy, cp * sy, -sp
    end
    
    local function get_damage(me, enemy, x, y,z)
        local ex = { }
        local ey = { }
        local ez = { }
        ex[0], ey[0], ez[0] = entity_hitbox_position(enemy, 1)
        ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
        ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
        ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
        ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
        ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
        ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
        local bestdamage = 0
        local bent = nil
        for i=0, 6 do
            local ent, damage = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
            if damage > bestdamage then
                bent = ent
                bestdamage = damage
            end
        end
        return bent == nil and client_scale_damage(me, 1, bestdamage) or bestdamage
    end
    
    local function is_auto_vis(local_player,lx,ly,lz,px,py,pz)
        entindex,dmg = client_trace_bullet(local_player,lx,ly,lz,px,py,pz)
        if entindex == nil then
            return false
        end
        if entindex == local_player then
            return false
        end
        if not entity_is_enemy(entindex) then
            return false
        end
            if dmg >  ref_md then
                return true
            else
                return false
            end
    end
    
    local function trace_positions(px,py,pz,px1,py1,pz1,px2,py2,pz2,lx2,ly2,lz2)
        if is_auto_vis(local_player,lx2,ly2,lz2,px,py,pz) then
            return true
        end
        if is_auto_vis(local_player,lx2,ly2,lz2,px1,py1,pz1) then
            return true
        end
        if is_auto_vis(local_player,lx2,ly2,lz2,px2,py2,pz2) then
            return true
        end
        return false
    end
    
    local function extrapolate_position(xpos,ypos,zpos,ticks,ent)
        x,y,z = entity_get_prop(ent, "m_vecVelocity")
        for i=0, ticks do
            xpos =  xpos + (x*globals_tickinterval())
            ypos =  ypos + (y*globals_tickinterval())
            zpos =  zpos + (z*globals_tickinterval())
        end
        return xpos,ypos,zpos
    end
    
    local function get_best_enemy()
        -- We store the best target in a global variable so we don't have to re run the calculations every time we want to find the best target.
        best_enemy = nil
    
        local enemies = entity_get_players(true)
        local best_fov = 180
    
        local lx, ly, lz = client_eye_position()
        local view_x, view_y, roll = client_camera_angles()
        
        for i=1, #enemies do
            local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
            local cur_fov = math.abs(normalize_yaw(ang_on_screen(lx - cur_x, ly - cur_y) - view_y + 180))
            if cur_fov < best_fov then
                best_fov = cur_fov
                best_enemy = enemies[i]
            end
        end
    end

    local vec_3 = function(_x, _y, _z) 
        return { x = _x or 0, y = _y or 0, z = _z or 0 } 
    end

    local function ticks_to_time(ticks)
        return globals.tickinterval() * ticks
    end
    
    local function will_peek()
        local enemies = entity.get_players(true)
        if (#enemies == 0) then
            return false
        end
    
        local me = entity.get_local_player()
        local predicted = ui.get(ui.reference("aa", "Fake lag", "Limit"))
    
        local eye_pos = vec_3(client.eye_position())
        local vel_prop_local = vec_3(entity.get_prop(me, "m_vecVelocity"))
        local local_vel = math.sqrt(vel_prop_local.x^2+vel_prop_local.y^2)
    
      
    
        local pred_eye_pos = vec_3(eye_pos.x + vel_prop_local.x * ticks_to_time(predicted), eye_pos.y + vel_prop_local.y * ticks_to_time(predicted), eye_pos.z + vel_prop_local.z * ticks_to_time(predicted))
    
        for i = 1, #enemies do
            local player = enemies[i]
    
            local vel_prop = vec_3(entity.get_prop(player, "m_vecVelocity"))
            local origin = vec_3(entity.get_prop(player, "m_vecOrigin"))
            local pred_origin = vec_3(origin.x + vel_prop.x * ticks_to_time(16), origin.y + vel_prop.y * ticks_to_time(16), origin.x + vel_prop.x * ticks_to_time(16))
    
            entity.get_prop(player, "m_vecOrigin", pred_origin)
    
            local head_origin = vec_3(entity.hitbox_position(player, 0))
            local pred_head_origin = vec_3(head_origin.x + vel_prop.x * ticks_to_time(16), head_origin.y + vel_prop.y * ticks_to_time(16), head_origin.z + vel_prop.z * ticks_to_time(16))
            local trace_entity, damage = client.trace_bullet(me, pred_eye_pos.x, pred_eye_pos.y, pred_eye_pos.z, pred_head_origin.x, pred_head_origin.y, pred_head_origin.z)
    
            entity.get_prop(player, "m_vecOrigin", origin)
    
            local current_player = player
    
            if damage > 0 and entity.is_alive(current_player) then
                if player ~= current_player then
                    return false
                end
    
                current_player = player
                return true
            end
        end
    
        return false
    end
    
    local function get_best_angle()
        -- Since we run this from run_command no need to check if we are alive or anything.
        local me = entity_get_local_player()
    
        brute.best_angle = 0
    
        if not ui_get(active) then return end
    
        if best_enemy == nil then return end
    
        local lx, ly, lz = client_eye_position()
        local view_x, view_y, roll = client_camera_angles()
        
        local e_x, e_y, e_z = entity_hitbox_position(best_enemy, 0)
    
        local yaw = calc_angle(lx, ly, e_x, e_y)
        local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
        local rend_x = lx + rdir_x * 15
        local rend_y = ly + rdir_y * 15
                
        local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
        local lend_x = lx + ldir_x * 15
        local lend_y = ly + ldir_y * 15
                
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
            if ui_get(active) and ui_get(byaw_cond) ~= "Off" then
                brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 1 or 2)
            else
                brute.best_angle = 1
            end
        elseif r2damage > l2damage or rdamage > ldamage then
            if ui_get(active) and ui_get(byaw_cond) ~= "Off" then
                brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 2 or 1)
            else
                brute.best_angle = 2
            end
        end
    end

    
    --on peek判定
    peeking = false
    unpeek = false
    is_peeking = false
    local is_peeking = function(cmd)

        local lp = entity.get_local_player()
        local pos = { client.eye_position() }
        local vel = { entity.get_prop(lp, "m_vecVelocity") }
        local idx = entity.get_prop(entity.get_player_weapon(lp), "m_iItemDefinitionIndex")
        local speed = 220
        local slider = 128

        predicted_pos = { pos[1] + (vel[1]/speed)*slider, pos[2] + (vel[2]/speed)*slider, pos[3] + (vel[3]/speed)*slider }
        for k, v in pairs(entity.get_players(true)) do
            local head = { entity.hitbox_position(v, 0) }
            local pelvis = { entity.hitbox_position(v, 2) }
            local _, head_ent = client.trace_line(lp, predicted_pos[1], predicted_pos[2], predicted_pos[3], head[1], head[2], head[3])
            local _, pelvis_ent = client.trace_line(lp, predicted_pos[1], predicted_pos[2], predicted_pos[3], pelvis[1], pelvis[2], pelvis[3])

            if head_ent == v or pelvis_ent == v then
                local _, head_ent = client.trace_line(lp, pos[1], pos[2], pos[3], head[1], head[2], head[3])
                local _, pelvis_ent = client.trace_line(lp, pos[1], pos[2], pos[3], pelvis[1], pelvis[2], pelvis[3])
                if head_ent ~= v and pelvis_ent ~= v then
                        peeking = true
                    break
                end
            else
                peeking = false
            end
            peeking = false
        end

    end
    client.set_event_callback("setup_command", is_peeking)

    --判定dt
    local function doubletap_charged()
        -- Make sure we have doubletap enabled, are holding our doubletap key & we aren't fakeducking.
        if not ui_get(dtap) or not ui_get(dtap_hk) or ui_get(fakeduck) then return false end
    
        -- Get our local player.
        local me = entity_get_local_player()
    
        -- Sanity checks on local player (since paint & a few other events run even when dead).
        if me == nil or not entity_is_alive(me) then return false end
    
        -- Get our local players weapon.
        local weapon = entity_get_prop(me, "m_hActiveWeapon")
    
        -- Make sure that it is valid.
        if weapon == nil then return false end
    
        -- Basic definitions used to calculate if we have recently shot or swapped weapons.
        local next_attack = entity_get_prop(me, "m_flNextAttack") + 0.25
        local next_primary_attack = entity_get_prop(weapon, "m_flNextPrimaryAttack") + 0.5
    
        -- Make sure both values are valid.
        if next_attack == nil or next_primary_attack == nil then return false end
    
        -- Return if both are under 0 meaning our doubletap is charged / we can fire (you can also use these values as a 2nd return parameter to get the charge %).
        return next_attack - globals_curtime() < 0 and next_primary_attack - globals_curtime() < 0
    end

    --dormant
    local dormant
    local function get_primary()
        local l_player = entity_get_local_player()
        local players = entity.get_players(true)
    
        local lx, ly, lz = entity.get_prop(l_player, "m_vecOrigin")
    
        local closest_player = {}
        local closest_distance = math.huge
        for i = 1, #players do
            local ent = players[i]
            local x, y, z = entity.get_prop(ent, "m_vecOrigin")
            local distance = math.sqrt((lx-x) ^ 2 + (ly-y) ^ 2 + (lz-z) ^ 2)
            if distance <= closest_distance then
                closest_player[1] = ent
                closest_player[2] = distance
                return closest_player[1], closest_player[2]
            end
        end
    end
    
    local function on_Draw()
        local primary_player, player_distance = get_primary()
        if not entity.is_dormant(primary_player) then
            dormant = false
        else
            dormant = true
        end
    end
    client.set_event_callback("paint", on_Draw)

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
    client.set_event_callback('setup_command', setup_command)
    
   --滑步
    local slidewalk = ui.reference("AA", "Other", "Leg movement")


    client.set_event_callback("net_update_end", function()
        if ui.get(enable_slide) then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
        end
    end)

    client.set_event_callback("run_command", function(ctx)
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
    end)

    --落地抬头
    client.set_event_callback("pre_render", function()
        if entity.is_alive(entity.get_local_player()) then
            
            if ui.get(fake_up) and ui_get(active) then
                local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1)
        
                if on_ground == 1 then
                    ground_ticks = ground_ticks + 1
                else
                    ground_ticks = 0
                    end_time = globals.curtime() + 1
                end 
            
                if ground_ticks > ui.get(fakelag)+1 and end_time > globals.curtime() then
                    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
                end
            end
        end 
    end)

    --反背刺
    local event_handler_functions = {
        [true]  = client.set_event_callback,
        [false] = client.unset_event_callback,
    }

    local function get_distance(x1, y1, z1, x2, y2, z2)
        return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
    end

    local function on_run_command()
        local players = entity.get_players(true)
        local lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
        local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
        for i=1, #players do
            local x, y, z = entity.get_prop(players[i], "m_vecOrigin")
            local distance = get_distance(lx, ly, lz, x, y, z)
            local weapon = entity.get_player_weapon(players[i])
            if entity.get_classname(weapon) == "CKnife" and distance <= 164 then
                ui.set(yaw_slider,180)
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

    --cam_collision
    ui.set_callback(new_slider, function()
        slider = ui.get(new_slider)
    client.exec("cam_idealdist ", slider)
    end)
    ui.set_callback(camcollsion, function()
        client.set_event_callback("paint", function()
        if ui.get(camcollsion) and ui.get(active)then 
            client.exec("cam_collision 0")
        else
            client.exec("cam_collision 1")
        end
    end)
    end)

    --visible func
    local menu_callback = function()

        local visible = ui_get(active)
        local manual = ui_get(manual_anti_aims)

        set_vis({
            [aa_active] = visible,
            [modeswitch] = visible,
            [condition] = false,

            [label1] = visible and ui_get(modeswitch) == "-",
            [label2] = visible and ui_get(modeswitch) == "-",
            [label3] = visible and ui_get(modeswitch) == "-",
            [label4] = visible and ui_get(modeswitch) == "-",
            [label5] = visible and ui_get(modeswitch) == "-",
            [label6] = visible and ui_get(modeswitch) == "-",

            [dangerous] = visible and ui_get(modeswitch) == "Anti-Aim",
            [legit_aa_on_e] = visible and ui_get(modeswitch) == "Anti-Aim",
            [manual_anti_aims] = visible and ui_get(modeswitch) == "Anti-Aim",
            [manual_state] = false,
            [manual_left] = visible and compare(ui_get(manual_anti_aims), manual_aa[1] ) and ui_get(modeswitch) == "Anti-Aim",
            [manual_right] = visible and compare(ui_get(manual_anti_aims), manual_aa[2] ) and ui_get(modeswitch) == "Anti-Aim",
            [manual_back] = visible and compare(ui_get(manual_anti_aims), manual_aa[3] ) and ui_get(modeswitch) == "Anti-Aim",
            [randomize_fake_limit] = visible and ui_get(modeswitch) == "Anti-Aim",
            [edge_yaw] = visible and ui_get(modeswitch) == "Anti-Aim",
            [freestanding] = visible and ui_get(modeswitch) == "Anti-Aim",
            [freestand_disablers] = visible and ui_get(freestanding) and ui_get(modeswitch) == "Anti-Aim",
            [manual_inverter] = false,
            [byaw_cond] = visible and ui_get(modeswitch) == "Anti-Aim",
            [antibf_cond] = visible and ui_get(modeswitch) == "Anti-Aim",
            [jt_vis] = visible and ui_get(modeswitch) == "Anti-Aim",

            [anti_aim_indicators] = visible and ui_get(modeswitch) == "Visual",
            [manual_arrows] = visible and ui_get(modeswitch) == "Visual" and ui.get(anti_aim_indicators) ~= "Off",
            [body_arrows] = visible and ui_get(modeswitch) == "Visual" and ui.get(anti_aim_indicators) ~= "Off",
            [peek_arrows] = visible and ui_get(modeswitch) == "Visual" and ui.get(anti_aim_indicators) ~= "Off",
            [anti_aim_indicators_color] = visible and ui_get(modeswitch) == "Visual" and ui.get(body_arrows), 
            [anti_aim_indicators_color1] = visible and ui_get(modeswitch) == "Visual" and ui.get(manual_arrows),
            [arr_dst] = visible and ui_get(anti_aim_indicators) and ui_get(modeswitch) == "Visual" and ui.get(anti_aim_indicators) ~= "Off",
            [text_indicators] = visible and ui_get(modeswitch) == "Visual",
            [other_indication] = visible and ui_get(modeswitch) == "Visual" and ui.get(text_indicators) ~= "Off",
            [other_indication_dst] = visible and #ui_get(other_indication) > 0 and ui_get(modeswitch) == "Visual",

            [hide_default_inds] = visible and ui_get(modeswitch) == "Misc",
            [epochtag_enabled] = visible and ui_get(modeswitch) == "Misc",
            [camcollsion] = visible and ui_get(modeswitch) == "Misc",
            [new_slider] = visible and ui_get(modeswitch) == "Misc" and ui.get(camcollsion),

            [onshotadaptive] = visible and ui_get(modeswitch) == "Exploits",
            [enable_slide] = visible and ui_get(modeswitch) == "Exploits",
            [betterfl] = visible and ui_get(modeswitch) == "Exploits",
            [anti_knife] = visible and ui_get(modeswitch) == "Exploits",
            [fake_up] = visible and ui_get(modeswitch) == "Exploits",

            [pitch] = not visible,
            [base] = not visible,
            [yaw] = not visible,
            [yaw_num] = not visible,
            [yaw_jt] = not visible,
            [yaw_jt_num] = not visible,
            [body] = not visible,
            [body_num] = not visible,
            [limit] = not visible,
            [fr_bodyyaw] = not visible,
            [fr] = not visible,
            [fr_hk] = not visible,
            [edge] = not visible
        })  
    end

    ui.set_callback(active, menu_callback)
    ui.set_callback(manual_anti_aims, menu_callback)
    ui.set_callback(freestanding, menu_callback)
    ui.set_callback(anti_aim_indicators, menu_callback)
    ui.set_callback(text_indicators, menu_callback)
    ui.set_callback(other_indication, menu_callback)
    menu_callback()

    local bind_system = {
        left = false,
        right = false,
        back = false,
        forward = false,
    }

    function bind_system:update()
        ui_set(manual_left, "On hotkey")
        ui_set(manual_right, "On hotkey")
        ui_set(manual_back, "On hotkey")

        local m_state = ui_get(manual_state)

        local left_state, right_state, back_state = 
            ui_get(manual_left) and compare(ui_get(manual_anti_aims), manual_aa[1] ), 
            ui_get(manual_right) and compare(ui_get(manual_anti_aims), manual_aa[2] ),
            ui_get(manual_back) and compare(ui_get(manual_anti_aims), manual_aa[3] )

        if left_state == self.left and 
            right_state == self.right and
            back_state == self.back then
            return
        end

        self.left, self.right, self.back = 
            left_state, 
            right_state,
            back_state
            

        if (left_state and m_state == 1) or (right_state and m_state == 2) or (back_state and m_state == 3) then
            ui_set(manual_state, 0)
            ui_set(base, "At targets")
            return
        end

        if left_state and m_state ~= 1 then
            ui_set(manual_state, 1)
            ui_set(base, "Local view")
        end

        if right_state and m_state ~= 2 then
            ui_set(manual_state, 2)
            ui_set(base, "Local view")
        end

        if back_state and m_state ~= 3 then
            ui_set(manual_state, 3)
            ui_set(base, "At targets")
        end

    end
    --setup_anti-aims
    local get_flags = function(cm)
        local state = "Standing"
        local me = entity_get_local_player()

        local flags = entity_get_prop(me, "m_fFlags")
        local x, y, z = entity_get_prop(me, "m_vecVelocity")
        local velocity = math.floor(math.min(10000, math.sqrt(x^2 + y^2) + 0.5))

        if bit.band(flags, 1) ~= 1 or (cm and cm.in_jump == 1) then state = "Air" else
            if velocity > 1 or (cm.sidemove ~= 0 or cm.forwardmove ~= 0) then
                if ui_get(slowmo) and ui_get(slowmo_key) then 
                    state = "Slow walk"
                else
                    state = "Moving"
                end
            else
                state = "Standing"
            end
        end

        return {
            velocity = velocity,
            state = state
        }
    end

    local fake_limit = 60
    local is_invertor = false

    local should_swap = false
    local it = 0

    local function GetClosestPoint(A, B, P)
        local a_to_p = { P[1] - A[1], P[2] - A[2] }
        local a_to_b = { B[1] - A[1], B[2] - A[2] }

        local atb2 = a_to_b[1]^2 + a_to_b[2]^2

        local atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
        local t = atp_dot_atb / atb2

        return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
    end

    local aa_side = {
        left = false,
        right = false,
        default = true
    }

    local time = 0

    local bf_time = 10

    client.set_event_callback("bullet_impact", function(c) -- on miss
        if compare(ui_get(antibf_cond), anti_bf_conditions[2]) and entity.is_alive(entity.get_local_player()) then
            local ent = client.userid_to_entindex(c.userid)
            if not entity.is_dormant(ent) and entity.is_enemy(ent) then
                local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
                ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
                local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
                local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
                local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
                local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
            
                if math.abs(delta_2d) < 32 then
                    it = it + 1
                    if aa_side.left == false then
                        aa_side.left = true
                        aa_side.right = false
                    elseif aa_side.right == false then
                        aa_side.left = false
                        aa_side.right = true
                    end
                    time = globals.realtime() + bf_time
                    --should_swap = not should_swap
                end
            end
        end
    end)
    local hitgroup_names = { "generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
    client.set_event_callback("player_hurt", function(c) -- on hit
        local victim = client.userid_to_entindex(c.userid)
        local shooter = client.userid_to_entindex(c.attacker)

        if entity.is_enemy(shooter) and victim == entity.get_local_player() and compare(ui_get(antibf_cond), anti_bf_conditions[1]) then
            local hitbox_hit = hitgroup_names[c.hitgroup + 1]

            if hitbox_hit ~= "left leg" and hitbox_hit ~= "right leg" and hitbox_hit ~= "head" then
                it = it + 1
                if aa_side.left == false then
                    aa_side.left = true
                    aa_side.right = false
                elseif aa_side.right == false then
                    aa_side.left = false
                    aa_side.right = true
                end
                time = globals.realtime() + bf_time
            end
        end
    end)

    client.set_event_callback("aim_fire", function(c) -- on shot
        if compare(ui_get(antibf_cond), anti_bf_conditions[3]) then
            it = it + 1
            if aa_side.left == false then
                aa_side.left = true
                aa_side.right = false
            elseif aa_side.right == false then
                aa_side.left = false
                aa_side.right = true
            end
            time = globals.realtime() + bf_time
        end
    end)

    local function reset_anti_bf()
        it = 0
        aa_side = {
            left = false,
            right = false,
            default = true
        }
    end

    client.set_event_callback("round_end", reset_anti_bf)

    local is_dynamic = false
    local e_peek = false
    local should_freestand = false

    local function get_entities(enemy_only, alive_only)
    	local enemy_only = enemy_only ~= nil and enemy_only or false
        local alive_only = alive_only ~= nil and alive_only or true

        local result = {}

        local me = entity_get_local_player()
        local player_resource = entity_get_player_resource()

    	for player = 1, globals.maxplayers() do
    		if entity_get_prop(player_resource, 'm_bConnected', player) == 1 then
                local is_enemy, is_alive = true, true

    			if enemy_only and not entity.is_enemy(player) then is_enemy = false end
    			if is_enemy then
    				if alive_only and entity_get_prop(player_resource, 'm_bAlive', player) ~= 1 then is_alive = false end
    				if is_alive then table_insert(result, player) end
    			end
    		end
    	end

    	return result
    end

    local enemy_visible = false

    client.set_event_callback("setup_command", function(e)

        local masterswitch = ui_get(active)

        local manual_dir = ui_get(manual_state)

        local data = antiaims_mode[ui_get(condition)]
        local cmd = get_flags(e)

        -- LEGIT AA 

        local me = entity.get_local_player()
        local wpn = entity.get_player_weapon(me)

        if ui_get(legit_aa_on_e) then
            if wpn ~= nil and entity.get_classname(wpn) == 'CC4' then
                if e.in_attack == 1 then
                    e.in_attack = 0
                    e.in_use = 1
                    e_peek = false
                end
            else
                if e.chokedcommands == 0 and e.in_use == 1 then
                    e.in_use = 0 
                    e_peek = true
                end
                if e.chokedcommands > 0 and e.in_use == 0 then
                    e_peek = false
                end
            end
        end 
        if e.chokedcommands == 0 and ui_get(randomize_fake_limit) then
            fake_limit = client.random_int(25, 55)
        elseif not ui_get(randomize_fake_limit) then
            fake_limit = 48
        end


        -- FREESTANDING 

        should_freestand = ui_get(freestanding)

        if #ui_get(freestand_disablers) > 0 then
            if e.in_duck == 1 and compare(ui_get(freestand_disablers), fr_disablers[1] ) and not ui_get(fakeduck) then
                should_freestand = false
            elseif compare(ui_get(freestand_disablers), fr_disablers[2] ) and ui_get(fakeduck) then
                should_freestand = false
            elseif compare(ui_get(freestand_disablers), fr_disablers[3] ) and cmd.state == custom_fake_limit[2] then
                should_freestand = false
            elseif compare(ui_get(freestand_disablers), fr_disablers[4] ) and cmd.state == "Air" then
                should_freestand = false
            end
        end

        local me = entity.get_local_player()
        if not ui.get(active) or not entity.is_alive(me) then
            return
        end
        if ui.get(betterfl) then
            if cmd.state == "Moving" then
                ui.set(ref_fl_amt, "Maximum")
                ui.set(ref_fakelag_limit, 14)
                ui.set(ref_fl_var, math.random(15,40))
            elseif cmd.state == "Slow walk" then
                ui.set(ref_fl_amt, "Dynamic")
                ui.set(ref_fakelag_limit, math.random(10,14))
                ui.set(ref_fl_var, math.random(5,20))
            elseif cmd.state == "Air" then
                ui.set(ref_fl_amt, "Fluctuate")
                ui.set(ref_fakelag_limit, 14)
                ui.set(ref_fl_var, math.random(15,25))
            elseif cmd.state == "Standing" then
                ui.set(ref_fl_amt, "Dynamic")
                ui.set(ref_fakelag_limit, 14)
                ui.set(ref_fl_var, math.random(2,35))
            end
        end

        -- FREESTAND BYAW
                if  brute.best_angle == 1 then
                    brute.yaw_status = "DYNAMIC" 
                    if ui_get(byaw_cond) == byaw_conditions[2] then
                        is_invertor = true
                    elseif ui_get(byaw_cond) == byaw_conditions[3] then
                        is_invertor = false
                    elseif ui_get(byaw_cond) == byaw_conditions[0] then
                        is_dynamic = false
                        is_invertor = ui_get(manual_inverter)
                    end
                end 
                if  brute.best_angle == 2 then 
                    brute.yaw_status = "DYNAMIC" 
                    if ui_get(byaw_cond) == byaw_conditions[2] then
                        is_invertor = false
                        is_dynamic = true
                    elseif ui_get(byaw_cond) == byaw_conditions[3] then
                        is_invertor = true
                        is_dynamic = true
                    elseif ui_get(byaw_cond) == byaw_conditions[0] then
                        is_dynamic = false
                        is_invertor = ui_get(manual_inverter)
                    end 
                end
                if  brute.best_angle == 0 then 
                    brute.yaw_status = "DYNAMIC" 
                end
                --print(is_invertor)

        -- ANTI BRUTEFORCE
        if it ~= 0 then
            if aa_side.right and is_invertor == false then
                is_invertor = true
            end

            if aa_side.left and is_invertor == true then
                is_invertor = false
            end

            if time < globals.realtime() then reset_anti_bf() end
        end
        --[[
            if aa_side.right == false and aa_side.left == false then is_invertor = false end
            if aa_side.right and not aa_side.left then is_invertor = true end
            if not aa_side.right and aa_side.left then is_invertor = false end
        ]]

        local current_yaw = ({
            [0] = data.yaw[1] and data.yaw[is_invertor] or data.yaw[false],
            [1] = -80, [2] = 60, [3] = 0
        })[manual_dir]


        local current_byaw = {
            [1] = data.byaw[1],
            [2] = data.byaw[2] and data.byaw[is_invertor] or data.byaw[false]
        }

        local yawjt = {
            [1] = data.yaw_jt[1],
            [2] = data.yaw_jt[2]

        }

      
        if ui_get(byaw_cond) == "Off" then
            ui_set(condition, "JITTER")
            fake_limit = 40
            brute.yaw_status = "JITTER"
        else ui_set(condition, "EPOCH")
        end

        if includes(ui_get(jt_vis), "Jitter on dormant") and dormant == true then
            current_byaw[1] = "Jitter"
            current_byaw[2] = 0
            brute.yaw_status = "DORMANT"
        elseif includes(ui_get(jt_vis), "Jitter when vulnerable") and will_peek() then
            current_byaw[1] = "Jitter"
            current_byaw[2] = 0
            brute.yaw_status = "JITTER"
        end

        if ui_get(dangerous) then
            current_yaw = 3     ---slow walk yaw角度
            yawjt[1] = "offset"     ---slow walk yawjitter 模式
            yawjt[2] = 6     ---slow walk yawjitter 角度
            current_byaw[1] = "jitter"     ---slow walk bodyyaw 模式
            current_byaw[2] = 113     ---slow walk bodyyaw 度数
            fake_limit = math.random(30,38)      ---low body yaw limit
            brute.yaw_status = "DODGE"
        end
       
        if cmd.state == "Moving" then
            brute.status = "MOVING"
        elseif cmd.state == "Air" then
            brute.status = "AIR"
        elseif cmd.state == "Standing" then
            brute.status = "STANDING"
        elseif cmd.state == "Slow walk" then
            brute.status = "SLOWMOTION"
        end



        invoke_cache({
            [pitch] = { masterswitch, "Default" },
            [yaw] = { masterswitch, "180" },
            [yaw_num] = { masterswitch, current_yaw },
            [yaw_num] = { masterswitch, current_yaw },
            [yaw_jt] = { masterswitch, yawjt[1] },
            [yaw_jt_num] = { masterswitch, yawjt[2] },
            [body] = { masterswitch, current_byaw[1] },
            [body_num] = { masterswitch, current_byaw[2] },
            [limit] = { masterswitch, fake_limit },
            [edge] = { masterswitch, ui_get(edge_yaw) and manual_dir == 0 },
            [fr] = { masterswitch, (should_freestand and manual_dir == 0) and "Default" or "-" },
            [fr_hk] = { masterswitch, (should_freestand and manual_dir == 0) and "Always on" or "On hotkey" },
        })


    end)
    local w, h = client.screen_size()

    local normalize_yaw = function(angle)
        angle = (angle % 360 + 360) % 360
        return angle > 180 and angle - 360 or angle
    end

    local x, y = client.screen_size()

    --renderer some indicators
    client.set_event_callback("paint", function(e)
        bind_system:update()
        menu_callback()
        ui_set(manual_inverter, "toggle")

        local me = entity_get_local_player()
        --ENEMY VISIBLE
        local players = get_entities(true, true)
        for i=1, #players do
            local player = players[i]

            enemy_visible = entity.get_esp_data(player).alpha > 0
        end

        if not entity.is_alive(me) or not ui_get(active) then
            enemy_visible = false
            return
        end

        -- AA STUFF
        local _, camera_yaw = client_camera_angles()
        local _, rotation = entity_get_prop(me, 'm_angAbsRotation')
        local body_pos = entity_get_prop(me, "m_flPoseParameter", 11) or 0
        local realtime = globals_realtime() % 3
        local alpha = math.floor(math.sin(realtime * 4) * (255/2-1) + 255/2) or 255
        local body_yaw = math_max(-60, math_min(60, body_pos*120-60+0.5))
        body_yaw = (body_yaw < 1 and body_yaw > 0.0001) and math_floor(body_yaw, 1) or body_yaw

        if camera_yaw ~= nil and rotation ~= nil and 60 < math_abs(normalize_yaw(camera_yaw-(rotation+body_yaw))) then
            body_yaw = -body_yaw
        end

        local abs_yaw = math.abs(body_yaw)

        local side = body_yaw < 0 and 2 or (body_yaw > 0.999 and 1 or 0)


        local r, g, b, a = ui_get(anti_aim_indicators_color)
        local r1, g1, b1, a1 = ui_get(anti_aim_indicators_color1)
        local m_state = ui_get(manual_state)
        local distance = (w/2) / 210 * ui_get(arr_dst)

            if ui.get(anti_aim_indicators) == "Style 1" and ui.get(body_arrows) then
                if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                    if m_state == 0 or m_state == 3 then
                        renderer.text(w/2 - distance, h/2, 255,255,255, 70, "c+", 0, "<")
                        renderer.text(w/2 + distance, h/2, 255,255,255, 70, "c+", 0, ">")
                        if side == 2 then
                            renderer.text(w/2 - distance, h/2, r, g, b, a, "c+", 0, "<")
                        elseif ui.get(peek_arrows) and side == 2 and (peeking) then
                            renderer.text(w/2 + distance, h/2, r, g, b, a, "c+", 0, "<<")
                        end
                        if side == 1 then
                            renderer.text(w/2 + distance, h/2, r, g, b, a, "c+", 0, ">")
                        end
                        if ui.get(peek_arrows) and side == 1 and (peeking) then  
                            renderer.text(w/2 + distance + 10, h/2, r, g, b, a, "c+", 0, ">")
                        elseif ui.get(peek_arrows) and side == 2 and (peeking) then  
                            renderer.text(w/2 - distance - 10, h/2, r, g, b, a, "c+", 0, "<")
                        end
                    end
                end
            end
            if ui.get(anti_aim_indicators) == "Style 1" and ui.get(manual_arrows) and m_state ~= 0 then
                renderer.text(w/2 - distance, h/2, 255,255,255, 70, "c+", 0, "<")
                renderer.text(w/2 + distance, h/2, 255,255,255, 70, "c+", 0, ">")
                if m_state == 1 then
                    renderer.text(w/2 - distance, h/2, r1, g1, b1, alpha, "c+", 0, "<")
                end
                if m_state == 2 then
                    renderer.text(w/2 + distance, h/2, r1, g1, b1, alpha, "c+", 0, ">")
                end  
            end

            if ui.get(anti_aim_indicators) == "Style 2" and ui.get(body_arrows)then
                if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                    if m_state == 0 or m_state == 3 then
                        renderer.text(w/2 - distance, h/2, 255,255,255, 70, "c+", 0, "‹")
                        renderer.text(w/2 + distance, h/2, 255,255,255, 70, "c+", 0, "›")
                        if side == 2 then
                            renderer.text(w/2 - distance, h/2, r, g, b, a, "c+", 0, "‹")
                        end
                        if side == 1 then
                            renderer.text(w/2 + distance, h/2, r, g, b, a, "c+", 0, "›")
                        end 
                        if ui.get(peek_arrows) and side == 1 and (peeking) then  
                            renderer.text(w/2 + distance + 10, h/2, r, g, b, a, "c+", 0, "›")
                        elseif ui.get(peek_arrows) and side == 2 and (peeking) then  
                            renderer.text(w/2 - distance - 10, h/2, r, g, b, a, "c+", 0, "‹")
                        end
                    end 
                end
            end
            if ui.get(anti_aim_indicators) == "Style 2" and ui.get(manual_arrows) and m_state ~= 0 then
                renderer.text(w/2 - distance, h/2, 255,255,255, 70, "c+", 0, "‹")
                renderer.text(w/2 + distance, h/2, 255,255,255, 70, "c+", 0, "›")
                if m_state == 1 then
                    renderer.text(w/2 - distance, h/2, r1, g1, b1, alpha, "c+", 0, "‹")
                end
                if m_state == 2 then
                    renderer.text(w/2 + distance, h/2, r1, g1, b1, alpha, "c+", 0, "›")
                end  
            end
        


        --end

        ---指示器
        if not entity_is_alive(entity_get_local_player()) then return end
        local h_index = 0
        local w, h = client_screen_size()
        local weapon = entity_get_player_weapon(me)
        local next_attack = math_max(entity_get_prop(weapon, "m_flNextPrimaryAttack") or 0, entity_get_prop(me, "m_flNextAttack") or 0)
        local next_primary_attack = entity_get_prop(weapon, "m_flNextPrimaryAttack") + 0.5
        local time = next_attack - globals_curtime()
        local local_player = entity.get_local_player()
        local active_weapon = entity.get_player_weapon(local_player) == nil and 1 or entity.get_player_weapon(local_player)
        local weapon_idx = entity_get_player_weapon(entity.get_local_player())
        local weapon = csgo_weapons[entity.get_prop(active_weapon, "m_iItemDefinitionIndex")]
        if weapon == nil then return end
        local weapon_name = entity_get_classname(weapon_idx)
        local weapon_icon = images.get_weapon_icon(weapon)
        local bullet_icon = images.get_panorama_image("icons/ui/bullet_burst.svg")
        local bullet_icon2 = images.get_panorama_image("icons/ui/bullet_burst_outline.svg")
        local bullet_icon3 = images.get_panorama_image("icons/ui/bullet.svg")
        local weapon_w, weapon_h = weapon_icon:measure()
        local bullet_w, bullet_h = bullet_icon:measure()
        local alpha1 = math.floor(math.sin(globals_realtime() * 12) * (255/2-1) + 255/2) or 255

        
        if e_peek then brute.yaw_status =  "LEGIT AA" end

        if ui_get(manual_state) == 1 then 
            brute.yaw_status = "MANUAL LEFT" 
        elseif ui_get(manual_state) == 2 then 
            brute.yaw_status =  "MANUAL RIGHT" 
        end

        get_color = function()
            local colors = { 209, 139, 230, 255 }



            if brute.yaw_status == "DORMANT" then colors = { 223, 145, 155, 255 } end

            if brute.yaw_status == "JITTER" then colors = { 223, 245, 255, 255 } end

            if ui_get(manual_state) == 1  or ui_get(manual_state) == 2 then colors = { r1, g1, b1, 255 } end

            if ui_get(dangerous) then colors = { 177, 151, 255, alpha } end
            
            if e_peek then colors = { 23, 145, 255, 255 } end

            return unpack(colors) 
        end
        color = { get_color() }

        if ui.get(randomize_fake_limit) then
            renderer.text(w/2 , h/2 + 400, 135, 231, 255, alpha, "cb", 0, "ADAPTIVE FAKE LIMIT")
        end

    

        if ui.get(text_indicators)== "Style 1" then

            if includes(ui_get(other_indication), "Yaw status") then
                surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 215, 114, 44, 255, verdana, "EPOCH")
                h_index = h_index + 1
                    surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), color[1], color[2], color[3], color[4], verdana, string.format("AA | %s", brute.yaw_status))
                    h_index = h_index + 1
            end

            if includes(ui_get(other_indication), "Current status") then
                surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 144, 124, 244, 255, verdana, string.format("STATUS | %s", brute.status))
                h_index = h_index + 1
            end

            if includes(ui_get(other_indication), "Doubletap") and ui_get(dtap_hk) and ui_get(dtap) then
                if doubletap_charged() then
                    surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 154, 255, 31, 255, verdana,  "DT")
                else
                    surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 54, 31, 255, verdana,  "DT")
                    renderer.circle_outline(w / 2 + 40, h / 2 + 37 + (h_index * 12) + ui.get(other_indication_dst), 255, 54, 31, 255, 5, 0, time, 2.5)	
                end
                h_index = h_index + 1
            elseif includes(ui_get(other_indication), "Doubletap") and not ui_get(dtap_hk) or not ui_get(dtap) then
                surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 98, 245, 203, 255, verdana,  "FL : ")
                renderer.gradient(w / 2 + 37 , h / 2 + 34 + (h_index * 12) + ui.get(other_indication_dst) , math.min(OldChoke*2 ), 6, 255, 255, 255, 255, 125, 125, 125, 50, true)
                h_index = h_index + 1
            end

            if includes(ui_get(other_indication), "Min damage") then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 255, 255, 255, verdana, string.format('DMG : ' ))
                surface_draw_text(w / 2 + 47 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 255, 255, 255, verdana,  string.format( ui.get(mindmg)))
                h_index = h_index + 1 
            end
    
            if includes(ui_get(other_indication), "Fakeduck") and ui_get(fakeduck) then
                local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 215, 114, 44, alpha, verdana,  "DUCK")
                h_index = h_index + 1
            end
    
            if includes(ui_get(other_indication), "Force safepoint") and ui_get(ref_sp_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 125, 225, 255, verdana,  "SAFE")
                h_index = h_index + 1
            end
    
            if includes(ui.get(other_indication), "Force body aim") and ui.get(ref_baim_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst),225, 225, 112, 255, verdana,  "BAIM")
                h_index = h_index + 1
            end
    
            if includes(ui_get(other_indication), "Hideshots") and ui_get(onshot) and ui_get(onshot_hk) then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 154, 255, 31, alpha, verdana,  "ON-SHOT")
                h_index = h_index + 1
            end

        elseif ui.get(text_indicators)== "Style 2" then

            if includes(ui_get(other_indication), "Yaw status") then
                surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 215, 114, 44, 255, custom_font, "EPOCH")

                h_index = h_index + 1
                    surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), color[1], color[2], color[3], color[4], custom_font, string.format("AA  |  %s ", brute.yaw_status))
                    h_index = h_index + 1
            end

            if includes(ui_get(other_indication), "Current status") then
                surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 144, 124, 244, 255, custom_font, string.format("STATUS  |  %s", brute.status))
                h_index = h_index + 1
            end

            if includes(ui_get(other_indication), "Doubletap") and ui_get(dtap_hk) and ui_get(dtap) then
                if doubletap_charged() then
                    surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 154, 255, 31, 255, custom_font,  "DT")
                else
                    surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 54, 31, 255, custom_font,  "DT")
                    renderer.circle_outline(w / 2 + 38, h / 2 + 35 + (h_index * 12) + ui.get(other_indication_dst), 255, 54, 31, 255, 5, 0, time, 1.5)	
                end
                h_index = h_index + 1
            elseif includes(ui_get(other_indication), "Doubletap") and not ui_get(dtap_hk) or not ui_get(dtap) then
                surface_draw_text(w / 2 + 15, h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 98, 245, 203, 255, custom_font,  "FL : ")
                renderer.gradient(w / 2 + 35 , h / 2 + 32 + (h_index * 12) + ui.get(other_indication_dst) , math.min(OldChoke*2 ), 6, 255, 255, 255, 255, 125, 125, 125, 50, true)
                h_index = h_index + 1
            end
    
            if includes(ui_get(other_indication), "Min damage") then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 255, 255, 255, custom_font, string.format('DMG : ' ))
                surface_draw_text(w / 2 + 47 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 255, 255, 255, custom_font,  string.format( ui.get(mindmg)))
                h_index = h_index + 1 
            end
    
            if includes(ui_get(other_indication), "Fakeduck") and ui_get(fakeduck) then
                local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 215, 114, 44, alpha, custom_font,  "DUCK")
                h_index = h_index + 1
            end
    
            if includes(ui_get(other_indication), "Force safepoint") and ui_get(ref_sp_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 255, 125, 225, 255, custom_font,  "SAFE")
                h_index = h_index + 1
            end
    
            if includes(ui.get(other_indication), "Force body aim") and ui.get(ref_baim_key) then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst),225, 225, 112, 255, custom_font,  "BAIM")
                h_index = h_index + 1
            end
    
            if includes(ui_get(other_indication), "Hideshots") and ui_get(onshot) and ui_get(onshot_hk) then
                surface_draw_text(w / 2 + 15 , h / 2 + 30 + (h_index * 12) + ui.get(other_indication_dst), 154, 255, 31, alpha, custom_font,  "ON-SHOT")
                h_index = h_index + 1
            end
        end
        
        if ui_get(hide_default_inds) then
            for i = 1, 400 do
                renderer.indicator(0, 0, 0, 0, " ")
            end
        end
    end)


    client.set_event_callback("run_command", function(c)
        if ui.get(onshotadaptive) then
            local local_player = entity.get_local_player()
                if local_player ~= nil then
                    local weapon = entity.get_player_weapon(local_player)
                        local item = entity.get_prop(weapon, "m_iItemDefinitionIndex")
                        if item ~= nil then
                        if(item == 40 or item == 9) then 
                        ui.set(onshot, true)
                        ui.set(onshot_hk, "Always On")
                        else
                        ui.set(onshot_hk, "Toggle") 
                    end
                end
            end
        end
    end)
    
    brute.reset = function()
        brute.indexed_angle = 0
        brute.best_angle = 0
    end
    client_set_event_callback("run_command", function()
        if not ui_get(active) then return end
        get_best_enemy()
        get_best_angle()
    end)
    client_set_event_callback("player_death", function(e)
        if not ui_get(active) then return end
        brute.reset()
    end)

    client_set_event_callback("round_start", function()
        if not ui_get(active) then return end
        
        brute.reset()
    end)

    client_set_event_callback("client_disconnect", function()
        if not ui_get(active) then return end

        brute.reset()
    end)

    client_set_event_callback("game_newmap", function()
        if not ui_get(active) then return end

        brute.reset()
    end)

    client_set_event_callback("cs_game_disconnected", function()
        if not ui_get(active) then return end

        brute.reset()
    end)
end
