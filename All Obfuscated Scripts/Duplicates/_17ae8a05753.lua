--[[
	id: aNrHyuyHBky_iQ-Zg427e
	name: 5463434563
	description: 564356346534563
	time1: 2021-07-07 17:38:20.884659+00
	time2: 2021-07-07 17:38:20.884659+00
	uploader: 2dDk5X5bQ5m-WsISYF2bN5Qf_NwTuvrcmZkaOS-S
	uploadersession: j7ovzjm9yNMeRzQ--8rrURFQiWzM9R
	flag: f
--]]

--skyness#4221
--skyness#4221
--skyness#4221
--requires
local success, surface = pcall(require, 'gamesense/surface')
local surface_measure_text, surface_draw_text = surface.measure_text, surface.draw_text
local success = require "gamesense/surface" or error("Subscribe https://gamesense.pub/forums/viewtopic.php?id=18793/", 2)
local custom_font = surface.create_font('Small Pixel', 8, 400, { 0x200 --[[ Outline ]] })
-- references
local ref_fd = ui.reference("RAGE", "Other", "Duck peek assist")
local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local yaw, yawslider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local yawjitter, yawyjitterslider = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local bodyyaw, slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local freestandingbodyyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local ref_free, ref_freekey = ui.reference( "AA", "Anti-aimbot angles", "Freestanding")
local lowerbodyyaw = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local fakeyawlimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local edgeyaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local double_tap_fake_lag_limit = ui.reference("RAGE", "Other", "Double tap fake lag limit")
local double_tap_mode = ui.reference("RAGE", "Other", "Double tap mode")
local double_tap = { ui.reference("Rage", "Other", "Double tap") }
local quickpeekassist = { ui.reference("RAGE", "Other", "Quick peek assist") }
local fakelaglimit = ui.reference("AA", "Fake lag", "Limit")
local fakelagtype = ui.reference("AA", "Fake lag", "Amount") 
local slowmotion = { ui.reference("AA", "Other", "Slow motion") }
local ref_hs, ref_hs_key= ui.reference("AA", "Other", "On shot anti-aim")
local mindmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
--ui设计
local   enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "Enable zzTsk.ye AA")
local   overrideaa = ui.new_combobox("AA", "Anti-Aimbot Angles", "Override freestanding body yaw", "Normal", "Static-Jitter")
local   antiresolver = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Anti-Bruteforce")
local   legitaa = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Legit aa on E")
local   legit_aa_on_key = ui.new_hotkey("AA", "Anti-Aimbot Angles", "Legit aa rebind")
local   lowdeltakey =  ui.new_hotkey("AA", "Anti-Aimbot Angles", "Low delta on key")
local   manual_aa = ui.new_checkbox("AA", "Anti-aimbot angles", "Manual anti-aim")
local   manual_left = ui.new_hotkey("AA", "Anti-aimbot angles", " Manual left")
local   manual_right = ui.new_hotkey("AA", "Anti-aimbot angles", "Manual right")
local   manual_back = ui.new_hotkey("AA", "Anti-aimbot angles", "Manual back")
local   manual_state = ui.new_slider("AA", "Anti-aimbot angles", "Manual direction", 0, 2, 0)
local   enable_slide = ui.new_checkbox("AA", "Anti-aimbot angles", "Better leg movement")
local   idealtickkey = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Ideal tick")
local   overrideind = ui.new_combobox("AA", "Anti-Aimbot Angles", "Manual aa indicator", "-", "A", "B")
local   manual_aa_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color", 255, 255, 255, 255)
local   indicators = ui.new_multiselect("AA", "Anti-aimbot angles", "Indicators", "Yaw status", "Min damage", "Fakelag", "Fakeduck", "Hideshots", "Lua name")


ui.set_visible(sv_maxusrcmdprocessticks, true)
ui.set_visible(manual_state, false)
local function setTableVisibility(table, state)
    for i=1, #table do
        ui.set_visible(table[i], state)
    end
end
  
--ui可见
local function handleGUI()
    if ui.get(enabled) then
        ui.set_visible(pitch, false)
        ui.set_visible(yawbase, false)
        ui.set_visible(yawjitter, false)
        ui.set_visible(lowerbodyyaw, false)
        ui.set_visible(ref_free, false)
        ui.set_visible(ref_freekey, false)
        ui.set_visible(yaw, false)
        ui.set_visible(yawslider, false)
        ui.set_visible(yawyjitterslider, false)
        ui.set_visible(bodyyaw, false)
        ui.set_visible(fakeyawlimit, false)
        ui.set_visible(freestandingbodyyaw, false)
        ui.set_visible(slider, false)
        ui.set_visible(edgeyaw, false)
        
    end
    ui.set_visible(overrideaa, ui.get(enabled))
    ui.set_visible(antiresolver, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(legitaa, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(lowdeltakey, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(legit_aa_on_key, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(idealtickkey, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(indicators, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(enable_slide, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(manual_aa, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(manual_left, ui.get(enabled) and ui.get(overrideaa) and ui.get(manual_aa))
    ui.set_visible(manual_right, ui.get(enabled) and ui.get(overrideaa) and ui.get(manual_aa))
    ui.set_visible(manual_back, ui.get(enabled) and ui.get(overrideaa) and ui.get(manual_aa))
    ui.set_visible(overrideind, ui.get(enabled) and ui.get(overrideaa))
    ui.set_visible(manual_aa_clr, ui.get(enabled) and ui.get(overrideaa))


end


--手动aa覆盖


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







--legfucker
local legs_ref = ui.reference("AA", "OTHER", "leg movement")
local slidewalk = ui.reference("AA", "other", "leg movement")


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


--dialtick
local function idealtickfunc()
    if ui.get(idealtickkey) then
        if ui.get(double_tap[1]) and ui.get(double_tap[2]) then
            if ui.get(quickpeekassist[1]) and ui.get(quickpeekassist[2]) then
                ui.set(fakelaglimit, 1)
            else
                ui.set(fakelaglimit, 14)
            end
        end
    end
end

local function GetClosestPoint(A, B, P)
    local a_to_p = { P[1] - A[1], P[2] - A[2] }
    local a_to_b = { B[1] - A[1], B[2] - A[2] }

    local atb2 = a_to_b[1]^2 + a_to_b[2]^2

    local atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
    local t = atp_dot_atb / atb2
    
    return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end

local should_swap = false
local it = 0
local angles = { 60, 20, -60 }
client.set_event_callback("bullet_impact", function(c)
    if ui.get(antiresolver) and entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
        
            if math.abs(delta_2d) < 125 then
                it = it + 1
                should_swap = true
            end
        end
    end
end)

client.set_event_callback("run_command", function(c)
    if ui.get(antiresolver) and ui.get(enabled) and should_swap then
        local _combo = ui.get(antiresolver)
        if _combo then
            ui.set(slider, -ui.get(slider))
        end
        should_swap = false
    end
end)    

function round(num, numDecimalPlaces)
	local mult = 1^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end



client.set_event_callback("setup_command",function(e)
    local weaponn = entity.get_player_weapon()

    if ui.get(legitaa) then
        if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
            if e.in_attack == 1 then
                e.in_attack = 0 
                e.in_use = 1
            end
        else
            if e.chokedcommands == 0 then
                e.in_use = 0
            end
        end
        ui.set(freestandingbodyyaw, true)
end
end)

local mode = "Default"
--manual aa
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

multi_exec(ui.set_visible, {
    [manual_aa_clr] = false,
    [manual_left] = false,
    [manual_right] = false,
	[manual_back] = false,
    [manual_state] = false,
})

function bind_system:update()
    ui.set(manual_left, "On hotkey")
    ui.set(manual_right, "On hotkey")
	ui.set(manual_back, "On hotkey")

    local m_state = ui.get(manual_state)

    local left_state, right_state, back_state = 
        ui.get(manual_left), 
        ui.get(manual_right),
		ui.get(manual_back)

    if  left_state == self.LEFT and 
	    back_state == self.BACK and
        right_state == self.RIGHT then
        return
    end

    self.LEFT, self.RIGHT, self.BACK = left_state, right_state, back_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) then
        ui.set(manual_state, 0)
        return
    end

    if left_state and m_state ~= 1 then
        ui.set(manual_state, 1)
    end

    if right_state and m_state ~= 2 then
        ui.set(manual_state, 2)
    end
	if back_state and m_state ~= 0 then
        ui.set(manual_state, 0)
    end
end

local on_manual_enabled = function(e, menu_call)
    local state = not ui.get(manual_aa)
    multi_exec(ui.set_visible, {
        [manual_aa_clr] = not state,
        [manual_left] = not state,
        [manual_right] = not state,
		[manual_back] = not state,
        [manual_state] = false,
    })
end

ui.set_callback(manual_aa, on_manual_enabled)

local function manual_aa_sc()
    if not ui.get(manual_aa) then
        return
    end

    local direction = ui.get(manual_state)

    local manual_yaw = {
        [0] = 0,
        [1] = -90, [2] = 90
    }

    if direction == 1 or direction == 2 then
        ui.set(yawbase, "Local view")
    else
        ui.set(yawbase, "At targets")
    end

    ui.set(yawslider, manual_yaw[direction])
end




--aa逻辑

local function set_anti_aim(mode)

    if mode == "Normal" then
        ui.set(bodyyaw, "Static")--bodyyaw状态
        ui.set(fakeyawlimit, 52)
        ui.set(freestandingbodyyaw, true)
        ui.set(yawjitter, "Offset")--yaw jitter模式
        ui.set(yawyjitterslider, -12)--yaw jitter度数
    elseif mode == "Static-Jitter" then
        f = client.random_int(1, 2)--minmal down随机
            if f == 1 then
             ui.set(pitch, "Down")
            elseif f == 2 then
            ui.set(pitch, "Minimal")
            end
        s = client.random_int(1, 2)--jitter static随机
            if s == 1 then
                ui.set(bodyyaw, "Jitter")
            elseif s == 2 then
            ui.set(bodyyaw, "Static")
            end
        ui.set(fakeyawlimit, math.random(-6, 32))--fyl随机度数
        ui.set(freestandingbodyyaw, true)
        ui.set(yawjitter, "Center")
        ui.set(yawyjitterslider, 57)

    elseif type == "Override antiaim" then
        ui.set(ref_yaw, "180")
        ui.set(yawjitter, "Off")
        ui.set(yawyjitterslider, 0)
        ui.set(slider, 170)
        ui.set(freestandingbodyyaw, false)
        ui.set(lowerbodyyaw, "Eye yaw")
        ui.set(fakeyawlimit, 60)
    
    elseif mode == "Legit aa" then
        ui.set(pitch, "Off")
        ui.set(yawbase, "Local view")
        ui.set(yaw, "Off")
        ui.set(bodyyaw, "Static")
        ui.set(lowerbodyyaw, "Opposite")
        ui.set(fakeyawlimit, 60)
  
    
    elseif mode == "Lowdelta" then
        ui.set(fakeyawlimit, 31)
    else
        ui.set(fakeyawlimit, 60)
    end

end
local function anti_aim()
    on_manual_enabled(true, true)
    bind_system:update()
    mode = "Default"
    if not ui.get(enabled) then return end
    if ui.get(manual_aa) and ui.get(manual_state) == 1 then
        mode = "Manual left"
        set_anti_aim("Override antiaim")
        return
    elseif ui.get(manual_aa) and ui.get(manual_state) == 2 then
            mode = "Manual right"
            set_anti_aim("Override antiaim")
            return
    end
    if ui.get(legitaa) and client.key_state(0x45) then
        mode = "LegitAA" 
    end
    if ui.get(overrideaa) == "Normal"  then
        mode = "Normal" 
        set_anti_aim("Normal")
    elseif ui.get(overrideaa) == "Static-Jitter"  then
        mode = "Static-Jitter" 
        set_anti_aim("Static-Jitter")
    end
    if ui.get(legit_aa_on_key) then
        mode = "LegitAA"
        set_anti_aim("Legit aa")
    else ui.set(pitch, "Down")  
        ui.set(yaw, "180")
    end
    if ui.get(lowdeltakey)  then
        mode = "Lowdelta" 
        set_anti_aim("Lowdelta")
    else
        ui.set(fakeyawlimit, 58)
    end
end

            


local function includes(table, key)
    for i=1, #table do
        if table[i] == key then
            return true
        end
    end
    return false
end
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

--指示器
local function on_paint()
    on_manual_enabled(true, true)
    bind_system:update()
    local width, height = client.screen_size()
    local center_width = width/2
    local center_height = height/2
    local local_player = entity.get_local_player()
    local r, g, b, a = ui.get(manual_aa_clr)
    local m_state = ui.get(manual_state)
    if not entity.is_alive(local_player) then return end
    local h_index = 0
    if m_state == 2 and ui.get(overrideind)  == "A" then renderer.text(center_width - 40, center_height, 125, 125, 125, 125, "+c", 0, "<") end
    if m_state == 1 and ui.get(overrideind)  == "A" then renderer.text(center_width + 40, center_height, 125, 125, 125, 125, "+c", 0, ">") end

    if m_state == 1 and ui.get(overrideind)   == "A" then renderer.text(center_width - 40,center_height, r, g, b, a, "+c", 0, "<") end
    if m_state == 2 and ui.get(overrideind)   == "A" then renderer.text(center_width + 40, center_height, r, g, b, a, "+c", 0, ">") end

    if m_state == 2 and ui.get(overrideind)  == "B" then renderer.text(center_width - 40, center_height, 125, 125, 125, 125, "+c", 0, "‹") end
    if m_state == 1 and ui.get(overrideind)  == "B" then renderer.text(center_width + 40, center_height, 125, 125, 125, 125, "+c", 0, "›") end

    if m_state == 1 and ui.get(overrideind)   == "B" then renderer.text(center_width - 40,center_height, r, g, b, a, "+c", 0, "‹") end
    if m_state == 2 and ui.get(overrideind)   == "B" then renderer.text(center_width + 40, center_height, r, g, b, a, "+c", 0, "›") end

    if includes(ui.get(indicators), "Yaw status") then
        surface_draw_text(center_width  + 15, center_height + 35 + (h_index * 12), 240, 255, 255, 255, custom_font, "YAW")
        surface_draw_text(center_width  + 40, center_height + 35 + (h_index * 12), 240, 255, 255, 255, custom_font, mode)
        h_index = h_index + 1
    end
    if includes(ui.get(indicators), "Fakelag")  then
    surface_draw_text(center_width  + 15, center_height + 35 + (h_index * 12), 240, 255, 255, 255, custom_font,  "FL : ")
    renderer.gradient(center_width  + 37, center_height + 37 + (h_index * 12) , math.min(OldChoke*2 ), 6, 240, 255, 255, 255, 125, 125, 125, 125, true)
    h_index = h_index + 1
    if includes(ui.get(indicators), "Hideshots") and ui.get(ref_hs) and ui.get(ref_hs_key) then
        surface_draw_text(center_width  + 15, center_height + 35 + (h_index * 12), 240, 255, 255, 255, custom_font,  "ON-SHOT")
        h_index = h_index + 1
    end
    if includes(ui.get(indicators), "Fakeduck") and ui.get(ref_fd) then
        local duck_amt = entity.get_prop(local_player, "m_flDuckAmount")
        surface_draw_text(center_width  + 15, center_height + 35 + (h_index * 12), 240, 255, 255, 255, custom_font,  "DUCK")
        h_index = h_index + 1
    end
    if includes(ui.get(indicators), "Min damage") then
        surface_draw_text(center_width  + 15, center_height + 35 + (h_index * 12)  , 240, 255, 255, 255, custom_font, string.format(' ' ))
        surface_draw_text(center_width  + 15, center_height + 35 + (h_index * 12)  , 240, 255, 255, 255, custom_font,  string.format( ui.get(mindmg)))
        h_index = h_index + 1 
    end
    if includes(ui.get(indicators), "Lua name") then
        surface_draw_text(center_width  + 15, center_height + 35 + (h_index * 12)  , 240, 255, 255, 255, custom_font, "zzTsk.ye")
        h_index = h_index + 1 
    end
end
end

local function valid_user()
    return true;
end
client.set_event_callback("aim_miss", function(e)
end)
            
local first_time = true
local valid = false
            
if first_time then
    valid = valid_user()
    client.set_event_callback('paint', on_paint)
    client.set_event_callback('paint', idealtickfunc)
    client.set_event_callback("paint_ui", handleGUI)
    client.set_event_callback('run_command', anti_aim)  
    client.set_event_callback("run_command", manual_aa_sc)
end
            
if not valid then
    client.exec("quit")
end
