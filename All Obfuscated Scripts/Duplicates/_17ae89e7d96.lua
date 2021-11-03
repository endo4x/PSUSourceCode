--[[
	id: 0prKjJ8q_bKsAbwuLGcK4
	name: 2
	description: 123
	time1: 2021-06-26 02:35:03.005283+00
	time2: 2021-06-26 02:35:03.005283+00
	uploader: d8EWlDT4PMRavyWovXahxCimsEWFBSD5OUmmJ3P3
	uploadersession: Vi7ZxVHDLrqvkHKzCf-kf38NKihILy
	flag: f
--]]

local cool = ui.new_combobox("AA", "Anti-aimbot angles", "Lower body yaw target", "Off", "Opposite", "Eye yaw", "Sway")
ui.set_visible(cool, false)
--[[local function refresh_nearbies()
    client.delay_call(0.001, refresh_nearbies)
    client.log("ddssad")
end
refresh_nearbies()]]

--uis
local ui_get, ui_set, ui_ref = ui.get, ui.set, ui.reference
local ui_new_checkbox = ui.new_checkbox
local ui_new_hotkey = ui.new_hotkey
local ui_new_combobox = ui.new_combobox
local ui_new_slider = ui.new_slider
local ui_multiselect = ui.new_multiselect
local ui_new_color_picker = ui.new_color_picker
local ui_reference = ui.reference
local ui_set_visible = ui.set_visible
local set_callback = ui.set_callback
--

--client
local client_log = client.log
local client_camera_angles = client.camera_angles
local client_trace_bullet = client.trace_bullet
local client_draw_text = client.draw_text
local client_screensize = client.screen_size
local set_event_callback = client.set_event_callback
local delay_call = client.delay_call
local client_trace_line = client.trace_line
local client_latency = client.latency
--

--globals
local globals_curtime = globals.curtime
local globals_realtime = globals.realtime
local g_tickcount = globals.tickcount
local interval_per_tick = globals.tickinterval
--

--entity
local entity_is_alive = entity.is_alive
local get_prop = entity.get_prop
local set_prop = entity.set_prop
local get_local_player = entity.get_local_player
local entity_is_enemy = entity.is_enemy
local get_player_weapon = entity.get_player_weapon
local entity_get_player_weapon = entity.get_player_weapon
local entity_get_players = entity.get_players
local entity_hitbox_position = entity.hitbox_position
--

--math locals

--

--Script locals

local multi_exec = function(func, list)
    if func == nil then
        return
    end

    for ref, val in pairs(list) do
        func(ref, val)
    end
end

--multi select function

local function contains(tab, val)
    for index, value in ipairs(ui_get(tab)) do
        if value == val then 
            return true 
        end
    end
    return false
end
--


--menu items

--RAGE tab
local r_rage, r_ragehk = ui_reference("RAGE", "Aimbot", "Enabled")
local r_mindmg = ui_reference("RAGE", "Aimbot", "Minimum Damage")
local r_fakeduck = ui_reference("RAGE", "Other", "Duck peek assist")
local r_dt, r_dthk = ui_reference("RAGE", "Other", "Double tap")

--Anti-aim tab
local refk_limit = ui_reference("aa", "Fake lag", "Limit")
local r_pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch")
local r_yawb = ui_reference("AA", "Anti-aimbot angles", "Yaw Base")
local r_yaw, r_yawsli = ui_reference("AA", "Anti-aimbot angles", "Yaw")
local r_jittype, r_jittsli = ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")
local r_bodyyaw, r_bodyyawsli = ui_reference("AA", "Anti-aimbot angles", "Body Yaw")
local r_check_lby = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local r_lbyt = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local r_fake_yaw_slider = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local r_edge_yaw = ui_reference("AA", "Anti-aimbot angles", "Edge yaw")
local r_freestanding, r_freestanding_hotkey = ui_reference("AA", "Anti-aimbot angles", "Freestanding")
--OTHER tab
local slow_motion, slow_motion_hk = ui_reference("aa", "Other", "Slow motion")
local onshotaa, onshotaa_hk = ui_reference("aa", "Other", "On shot anti-aim")
--

local data = {
    chock = 0,
    use4 = 0,
    use5 = 0,
    use6 = 0,
    rstime = 0,
    rstime2 = 0,
    save = "0",
    hurts = false,
    idir = "Right",
    cond = "Standing",
    cond_backup = "Standing",
}

local ui_heaven = ui_new_checkbox("AA", "Anti-aimbot angles", "Enable JangTG AA")
local info2 = ui.new_label('AA', 'Anti-aimbot angles', '--------------------------')
local ui_enable_graph = ui_new_checkbox("AA", "Anti-aimbot angles", "Visual elements")
local ui_enable_ind = ui_new_checkbox("AA", "Anti-aimbot angles", "Desync indicator ")
local ui_color = ui_new_color_picker("AA", "Anti-aimbot angles", "Desync color", "0", "115", "255", "255")
local dragging = (
    function()
        local a={}
        local b,c,d,e,f,g,h,i,j,k,l,m,n,o,dg;
        local p={__index={drag=function(self,...)
            local q,r=self:get()
            local s,t=a.drag(q,r,...)
            if q~=s or r~=t then 
                self:set(s,t)
            end;
            return s,t 
        end,
        set=function(self,q,r)
            local j,k=client.screen_size()ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res)end,
        get=function(self)
            local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k 
        end}}
        function a.new(u,v,w,x)x=x or 10000;
            local j,k=client.screen_size()
            local y=ui.new_slider("LUA","A",u.." window position",0,x,v/j*x)
            local z=ui.new_slider("LUA","A","\n"..u.." window position y",0,x,w/k*x)
            ui.set_visible(y,false)
            ui.set_visible(z,false)
            return setmetatable({name=u,x_reference=y,y_reference=z,res=x},p)
        end;
        function a.drag(q,r,A,B,C,D,E)
            if globals.framecount()~=b then 
                c=ui.is_menu_open()
                f,g=d,e;
                d,e=ui.mouse_position()
                i=h;
                h=client.key_state(0x01)==true;
                m=l;
                l={}
                o=n;
                n=false;
                j,k=client.screen_size()
            end;        
            if c and i~=nil then 
                if(not i or o) and h and f>q and g>r and f<q+A and g<r+B then 
                    n=true;
                    q,r=q+d-f,r+e-g;
                    if not D then 
                        q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r))
                    end
                end             
                if f>=q and g>=r and f<=q+A and g<=r+B then
                    dg = true 
                else
                    dg = false 
                end
            else 
                f,g,d,e = 0,0,0,0
                dg = false
            end;         
            table.insert(l,{q,r,A,B})
            return q,r,A,B 
        end;
        function a.match() return dg end;
    return a
end)()

local hk_dragger = dragging.new("Ind", 500, 600)
local ui_debug = ui_new_checkbox("AA", "Anti-aimbot angles", "Unhide debug information")
local ui_l_r_hotkey = ui_new_hotkey("AA", "Anti-aimbot angles", "Desync key")
local ml_dir = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual Left key")
local mr_dir = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual Right key")

local info = ui.new_label('AA', 'Anti-aimbot angles', '--------------------------')
local conditions = {"Default", "Standing", "Moving", "Slow walking", "In air", "Double tap", "Fakeduck"}
local ui_cond = ui_new_checkbox("AA", "Anti-aimbot angles", "Customize conditions")
local cond_combo_select = ui.new_combobox("AA", "Anti-aimbot angles", "Conditions settings", conditions)
local combo_select = ui.new_combobox("AA", "Anti-aimbot angles", "Desync direction settings", "Left", "Right", "At targets")

local break_m = {"On shot"--[[ , "On hurt"]]}
local break_j = {"Yaw jitter", "Body yaw jitter"}
local psive_cond = {"Yaw jitter", "Body yaw jitter", "Desync smoothness"}

local lua = {
    location = { "AA", "Anti-aimbot angles" },
    condition = "Standing"
}

function lua:call_menu(func, name, label, ...)
    if ( type(func) ~= "function" ) then error("invalid callback") return end

    local final_name = name ~= nil and name .. "\n" .. label or "\n" .. label

    return func(self.location[1], self.location[2], final_name, ...)
end

local master_dir = {
    ["Left"] = {
        conds = {
            ["Default"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "L - Default fallback condition.", "l_heaven_check_cond"),
                dys_select = lua:call_menu(ui.new_combobox, "L - Desync target selection", "ls_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "L - Real yaw slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "L - Fake yaw slider ", "ls_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "L - Passive settings", "rs_heaven_dys_passiv", psive_cond), 
                dys_yawjit = lua:call_menu(ui.new_combobox, "L - Yaw jitter options", "ls_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "L - Yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "L - Body yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),                   
                dys_smooth = lua:call_menu(ui.new_combobox, "L - Desync smoothness", "ls_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "L - Invert smooth direction", "ls_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "L - Smooth Speed", "ls_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "L - Yaw smoothness", "ls_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "L - Break yaw methods (●)", "ls_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "L - Break yaw on shot (●)", "ls_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "L - Enable Jitter on shot (●)", "ls_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "L - Jitter on shot methods (●)", "ls_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "L - Yaw jitter on shot (●)", "ls_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "L - Body yaw jitter on shot (●)", "ls_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "L - Break to left", "ls_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "L - Break to right", "ls_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "L - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "L - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "L - Refresh 'Opposite' desync in x ms", "ls_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "L - Overlay 'Eye yaw' desync in x ms", "ls_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "L - Loop in x ms", "ls_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },            
            ["Standing"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "L - Enable Standing condition", "ls_heaven_check_stand"),
                dys_select = lua:call_menu(ui.new_combobox, "LS - Desync target selection", "ls_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "LS - Real yaw slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "LS - Fake yaw slider ", "ls_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "LS - Passive settings", "rs_heaven_dys_passiv", psive_cond),    
                dys_yawjit = lua:call_menu(ui.new_combobox, "LS - Yaw jitter options", "ls_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "LS - Yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "LS - Body yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),                 
                dys_smooth = lua:call_menu(ui.new_combobox, "LS - Desync smoothness", "ls_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "LS - Invert smooth direction", "ls_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "LS - Smooth Speed", "ls_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "LS - Yaw smoothness", "ls_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "LS - Break yaw methods (●)", "ls_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "LS - Break yaw on shot (●)", "ls_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "LS - Enable Jitter on shot (●)", "ls_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "LS - Jitter on shot methods (●)", "ls_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "LS - Yaw jitter on shot (●)", "ls_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "LS - Body yaw jitter on shot (●)", "ls_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "LS - Break to left", "ls_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "LS - Break to right", "ls_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "LS - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "LS - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "LS - Refresh 'Opposite' desync in x ms", "ls_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "LS - Overlay 'Eye yaw' desync in x ms", "ls_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "LS - Loop in x ms", "ls_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["Moving"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "L - Enable Moving condition", "lm_heaven_check_move"),
                dys_select = lua:call_menu(ui.new_combobox, "LM - Desync target selection", "lm_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "LM - Real yaw slider ", "lm_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "LM - Fake yaw slider ", "lm_heaven_yaw_fake", 0, 60, 60, true,"°"),   
                dys_passive_stings = lua:call_menu(ui_multiselect, "LM - Passive settings", "rs_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "LM - Yaw jitter options", "ls_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "LM - Yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "LM - Body yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),                    
                dys_smooth = lua:call_menu(ui.new_combobox, "LM - Desync smoothness", "lm_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "LM - Invert smooth direction", "lm_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "LM - Smooth Speed", "lm_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "LM - Yaw smoothness", "lm_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "LM - Break yaw methods (●)", "lm_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "LM - Break yaw on shot (●)", "lm_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "LM - Enable Jitter on shot (●)", "lm_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "LM - Jitter on shot methods (●)", "lm_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "LM - Yaw jitter on shot (●)", "lm_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "LM - Body yaw jitter on shot (●)", "lm_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "LM - Break to left", "lm_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "LM - Break to right", "lm_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "LM - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "LM - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "LM - Refresh 'Opposite' desync in x ms", "lm_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "LM - Overlay 'Eye yaw' desync in x ms", "lm_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "LM - Loop in x ms", "lm_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["Slow walking"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "L - Enable Slow walking condition", "lsw_heaven_check_sw"),
                dys_select = lua:call_menu(ui.new_combobox, "Lsw - Desync target selection", "lsw_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Lsw - Real yaw slider ", "lsw_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Lsw - Fake yaw slider ", "lsw_heaven_yaw_fake", 0, 60, 60, true,"°"),  
                dys_passive_stings = lua:call_menu(ui_multiselect, "Lsw - Passive settings", "rs_heaven_dys_passiv", psive_cond),   
                dys_yawjit = lua:call_menu(ui.new_combobox, "Lsw - Yaw jitter options", "ls_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Lsw - Yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Lsw - Body yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),                    
                dys_smooth = lua:call_menu(ui.new_combobox, "Lsw - Desync smoothness", "lsw_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Lsw - Invert smooth direction", "lsw_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Lsw - Smooth Speed", "lsw_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Lsw - Yaw smoothness", "lsw_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Lsw - Break yaw methods (●)", "lsw_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Lsw - Break yaw on shot (●)", "lsw_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Lsw - Enable Jitter on shot (●)", "lsw_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Lsw - Jitter on shot methods (●)", "lsw_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Lsw - Yaw jitter on shot (●)", "lsw_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Lsw - Body yaw jitter on shot (●)", "lsw_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "Lsw - Break to left", "lsw_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Lsw - Break to right", "lsw_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Lsw - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Lsw - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "Lsw - Refresh 'Opposite' desync in x ms", "lsw_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Lsw - Overlay 'Eye yaw' desync in x ms", "lsw_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Lsw - Loop in x ms", "lsw_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["In air"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "L - Enable In air condition", "lair_heaven_check_inair"),
                dys_select = lua:call_menu(ui.new_combobox, "Lair - Desync target selection", "lair_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Lair - Real yaw slider ", "lair_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Lair - Fake yaw slider ", "lair_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "Lair - Passive settings", "rs_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "Lair - Yaw jitter options", "ls_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Lair - Yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Lair - Body yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),                   
                dys_smooth = lua:call_menu(ui.new_combobox, "Lair - Desync smoothness", "lair_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Lair - Invert smooth direction", "lair_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Lair - Smooth Speed", "lair_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Lair - Yaw smoothness", "lair_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Lair - Break yaw methods (●)", "lair_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Lair - Break yaw on shot (●)", "lair_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Lair - Enable Jitter on shot (●)", "lair_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Lair - Jitter on shot methods (●)", "lair_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Lair - Yaw jitter on shot (●)", "lair_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Lair - Body yaw jitter on shot (●)", "lair_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "Lair - Break to left", "lair_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Lair - Break to right", "lair_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Lair - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Lair - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "Lair - Refresh 'Opposite' desync in x ms", "lair_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Lair - Overlay 'Eye yaw' desync in x ms", "lair_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Lair - Loop in x ms", "lair_heaven_test6", 1, 110, 57, true, "s", 0.01),            
            },
            ["Double tap"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "L - Enable Double tap condition", "ldt_heaven_check_dt"),
                dys_select = lua:call_menu(ui.new_combobox, "Ldt - Desync target selection", "ldt_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Ldt - Real yaw slider ", "ldt_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Ldt - Fake yaw slider ", "ldt_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "Ldt - Passive settings", "rs_heaven_dys_passiv", psive_cond), 
                dys_yawjit = lua:call_menu(ui.new_combobox, "Ldt - Yaw jitter options", "ls_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Ldt - Yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Ldt - Body yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),                    
                dys_smooth = lua:call_menu(ui.new_combobox, "Ldt - Desync smoothness", "ldt_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Ldt - Invert smooth direction", "ldt_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Ldt - Smooth Speed", "ldt_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Ldt - Yaw smoothness", "ldt_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Ldt - Break yaw methods (●)", "ldt_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Ldt - Break yaw on shot (●)", "ldt_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Ldt - Enable Jitter on shot (●)", "ldt_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Ldt - Jitter on shot methods (●)", "ldt_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Ldt - Yaw jitter on shot (●)", "ldt_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Ldt - Body yaw jitter on shot (●)", "ldt_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "Ldt - Break to left", "ldt_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Ldt - Break to right", "ldt_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Ldt - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Ldt - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "Ldt - Refresh 'Opposite' desync in x ms", "ldt_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Ldt - Overlay 'Eye yaw' desync in x ms", "ldt_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Ldt - Loop in x ms", "ldt_heaven_test6", 1, 110, 57, true, "s", 0.01),            
            },
            ["Fakeduck"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "L - Enable Fakeduck condition", "lfd_heaven_check_fd"),
                dys_select = lua:call_menu(ui.new_combobox, "Lfd - Desync target selection", "lfd_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Lfd - Real yaw slider ", "lfd_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Lfd - Fake yaw slider ", "lfd_heaven_yaw_fake", 0, 60, 60, true,"°"),  
                dys_passive_stings = lua:call_menu(ui_multiselect, "Lfd - Passive settings", "rs_heaven_dys_passiv", psive_cond), 
                dys_yawjit = lua:call_menu(ui.new_combobox, "Lfd - Yaw jitter options", "ls_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Lfd - Yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Lfd - Body yaw jitter slider ", "ls_heaven_yaw_s", -180, 180, 0, true,"°"),                      
                dys_smooth = lua:call_menu(ui.new_combobox, "Lfd - Desync smoothness", "lfd_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Lfd - Invert smooth direction", "lfd_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Lfd - Smooth Speed", "lfd_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Lfd - Yaw smoothness", "lfd_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Lfd - Break yaw methods (●)", "lfd_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Lfd - Break yaw on shot (●)", "lfd_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Lfd - Enable Jitter on shot (●)", "lfd_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Lfd - Jitter on shot methods (●)", "lfd_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Lfd - Yaw jitter on shot (●)", "lfd_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Lfd - Body yaw jitter on shot (●)", "lfd_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "Lfd - Break to left", "lfd_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Lfd - Break to right", "lfd_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Lfd - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Lfd - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "Lfd - Refresh 'Opposite' desync in x ms", "lfd_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Lfd - Overlay 'Eye yaw' desync in x ms", "lfd_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Lfd - Loop in x ms", "lfd_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
        },
    },

    ["Right"] = {
        conds = {
            ["Default"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "R - Default fallback condition.", "r_heaven_check_cond"),
                dys_select = lua:call_menu(ui.new_combobox, "R - Desync target selection", "rs_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "R - Real yaw slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "R - Fake yaw slider ", "rs_heaven_yaw_fake", 0, 60, 60, true,"°"),         
                dys_passive_stings = lua:call_menu(ui_multiselect, "R - Passive settings", "rs_heaven_dys_passiv", psive_cond), 
                dys_yawjit = lua:call_menu(ui.new_combobox, "R - Yaw jitter options", "rs_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "R - Yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "R - Body yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                dys_smooth = lua:call_menu(ui.new_combobox, "R - Desync smoothness", "rs_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "R - Invert smooth direction", "rs_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "R - Smooth Speed", "rs_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "R - Yaw smoothness", "rs_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "R - Break yaw methods (●)", "rs_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "R - Break yaw on shot (●)", "rs_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "R - Enable Jitter on shot (●)", "rs_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "R - Jitter on shot methods (●)", "rs_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "R - Yaw jitter on shot (●)", "rs_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "R - Body yaw jitter on shot (●)", "rs_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "R - Break to left", "rs_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "R - Break to right", "rs_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "R - Left fake yaw Opposite", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "R - Right fake yaw Eye yaw ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),
                test4 = lua:call_menu(ui.new_slider, "R - Refresh 'Opposite' desync in x ms", "rs_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "R - Overlay 'Eye yaw' desync in x ms", "rs_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "R - Loop in x ms", "rs_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },            
            ["Standing"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "R - Enable Standing condition", "rs_heaven_check_stand"),
                dys_select = lua:call_menu(ui.new_combobox, "RS - Desync target selection", "rs_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "RS - Real yaw slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "RS - Fake yaw slider ", "rs_heaven_yaw_fake", 0, 60, 60, true,"°"),  
                dys_passive_stings = lua:call_menu(ui_multiselect, "RS - Passive settings", "rs_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "RS - Yaw jitter options", "rs_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "RS - Yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "RS - Body yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),                    
                dys_smooth = lua:call_menu(ui.new_combobox, "RS - Desync smoothness", "rs_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "RS - Invert smooth direction", "rs_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "RS - Smooth Speed", "rs_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "RS - Yaw smoothness", "rs_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "RS - Break yaw methods (●)", "rs_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "RS - Break yaw on shot (●)", "rs_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "RS - Enable Jitter on shot (●)", "rs_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "RS - Jitter on shot methods (●)", "rs_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "RS - Yaw jitter on shot (●)", "rs_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "RS - Body yaw jitter on shot (●)", "rs_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "RS - Break to left", "rs_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "RS - Break to right", "rs_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "RS - Left fake yaw Opposite ", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "RS - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "RS - Refresh 'Opposite' desync in x ms", "rs_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "RS - Overlay 'Eye yaw' desync in x ms", "rs_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "RS - Loop in x ms", "rs_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["Moving"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "R - Enable Moving condition", "rs_heaven_check_move"),
                dys_select = lua:call_menu(ui.new_combobox, "RM - Desync target selection", "rm_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "RM - Real yaw slider ", "rm_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "RM - Fake yaw slider ", "rm_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "RM - Passive settings", "rs_heaven_dys_passiv", psive_cond),
                dys_yawjit = lua:call_menu(ui.new_combobox, "RM - Yaw jitter options", "rs_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "RM - Yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "RM - Body yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),                
                dys_smooth = lua:call_menu(ui.new_combobox, "RM - Desync smoothness", "rm_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "RM - Invert smooth direction", "rm_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "RM - Smooth Speed", "rm_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "RM - Yaw smoothness", "rm_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "RM - Break yaw methods (●)", "rm_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "RM - Break yaw on shot (●)", "rm_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "RM - Enable Jitter on shot (●)", "rm_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "RM - Jitter on shot methods (●)", "rm_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "RM - Yaw jitter on shot (●)", "rm_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "RM - Body yaw jitter on shot (●)", "rm_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "RM - Break to left", "rm_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "RM - Break to right", "rm_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "RM - Left fake yaw Opposite ", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "RM - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "RM - Refresh 'Opposite' desync in x ms", "rm_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "RM - Overlay 'Eye yaw' desync in x ms", "rm_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "RM - Loop in x ms", "rm_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["Slow walking"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "R - Enable Slow walking condition", "rs_heaven_check_slowwalk"),
                dys_select = lua:call_menu(ui.new_combobox, "Rsw - Desync target selection", "rsw_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Rsw - Real yaw slider ", "rsw_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Rsw - Fake yaw slider ", "rsw_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "Rsw - Passive settings", "rs_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "Rsw - Yaw jitter options", "rs_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Rsw - Yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Rsw - Body yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),                  
                dys_smooth = lua:call_menu(ui.new_combobox, "Rsw - Desync smoothness", "rsw_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Rsw - Invert smooth direction", "rsw_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Rsw - Smooth Speed", "rsw_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Rsw - Yaw smoothness", "rsw_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Rsw - Break yaw methods (●)", "rsw_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Rsw - Break yaw on shot (●)", "rsw_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Rsw - Enable Jitter on shot (●)", "rsw_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Rsw - Jitter on shot methods (●)", "rsw_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Rsw - Yaw jitter on shot (●)", "rsw_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Rsw - Body yaw jitter on shot (●)", "rsw_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "Rsw - Break to left", "rsw_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Rsw - Break to right", "rsw_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Rsw - Left fake yaw Opposite ", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Rsw - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "Rsw - Refresh 'Opposite' desync in x ms", "rsw_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Rsw - Overlay 'Eye yaw' desync in x ms", "rsw_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Rsw - Loop in x ms", "rsw_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["In air"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "R - Enable In air condition", "rs_heaven_check_inair"),
                dys_select = lua:call_menu(ui.new_combobox, "Rair - Desync target selection", "rair_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Rair - Real yaw slider ", "rair_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Rair - Fake yaw slider ", "rair_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "Rair - Passive settings", "rs_heaven_dys_passiv", psive_cond), 
                dys_yawjit = lua:call_menu(ui.new_combobox, "Rair - Yaw jitter options", "rs_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Rair - Yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Rair - Body yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),                   
                dys_smooth = lua:call_menu(ui.new_combobox, "Rair - Desync smoothness", "rair_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Rair - Invert smooth direction", "rair_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Rair - Smooth Speed", "rair_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Rair - Yaw smoothness", "rair_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Rair - Break yaw methods (●)", "rair_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Rair - Break yaw on shot (●)", "rair_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Rair - Enable Jitter on shot (●)", "rair_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Rair - Jitter on shot methods (●)", "rair_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Rair - Yaw jitter on shot (●)", "rair_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Rair - Body yaw jitter on shot (●)", "rair_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Rair - Left fake yaw Opposite ", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Rair - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                yaw_l = lua:call_menu(ui.new_slider, "Rair - Break to left", "rair_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Rair - Break to right", "rair_heaven_yaw_r", -180, 180, 23, true,"°"),
                test4 = lua:call_menu(ui.new_slider, "Rair - Refresh 'Opposite' desync in x ms", "rair_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Rair - Overlay 'Eye yaw' desync in x ms", "rair_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Rair - Loop in x ms", "rair_heaven_test6", 1, 110, 57, true, "s", 0.01),            
            },
            ["Double tap"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "R - Enable Double tap condition", "rs_heaven_check_dt"),
                dys_select = lua:call_menu(ui.new_combobox, "Rdt - Desync target selection", "rdt_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Rdt - Real yaw slider ", "rdt_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Rdt - Fake yaw slider ", "rdt_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "Rdt - Passive settings", "rs_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "Rdt - Yaw jitter options", "rs_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Rdt - Yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Rdt - Body yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),                  
                dys_smooth = lua:call_menu(ui.new_combobox, "Rdt - Desync smoothness", "rdt_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Rdt - Invert smooth direction", "rdt_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Rdt - Smooth Speed", "rdt_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Rdt - Yaw smoothness", "rdt_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Rdt - Break yaw methods (●)", "rdt_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Rdt - Break yaw on shot (●)", "rdt_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Rdt - Enable Jitter on shot (●)", "rdt_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Rdt - Jitter on shot methods (●)", "rdt_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Rdt - Yaw jitter on shot (●)", "rdt_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Rdt - Body yaw jitter on shot (●)", "rdt_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "Rdt - Break to left", "rdt_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Rdt - Break to right", "rdt_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Rdt - Left fake yaw Opposite ", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Rdt - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "Rdt - Refresh 'Opposite' desync in x ms", "rdt_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Rdt - Overlay 'Eye yaw' desync in x ms", "rdt_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Rdt - Loop in x ms", "rdt_heaven_test6", 1, 110, 57, true, "s", 0.01),            
            },
            ["Fakeduck"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "R - Enable Fakeduck condition", "rs_heaven_check_fd"),
                dys_select = lua:call_menu(ui.new_combobox, "Rfd - Desync target selection", "rfd_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "Rfd - Real yaw slider ", "rfd_heaven_yaw_s", -180, 180, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "Rfd - Fake yaw slider ", "rfd_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "Rfd - Passive settings", "rs_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "Rfd - Yaw jitter options", "rs_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "Rfd - Yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "Rfd - Body yaw jitter slider ", "rs_heaven_yaw_s", -180, 180, 0, true,"°"),                  
                dys_smooth = lua:call_menu(ui.new_combobox, "Rfd - Desync smoothness", "rfd_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "Rfd - Invert smooth direction", "rfd_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "Rfd - Smooth Speed", "rfd_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "Rfd - Yaw smoothness", "rfd_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "Rfd - Break yaw methods (●)", "rfd_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "Rfd - Break yaw on shot (●)", "rfd_heaven_yaw_bs", 0, 60, 30, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "Rfd - Enable Jitter on shot (●)", "rfd_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "Rfd - Jitter on shot methods (●)", "rfd_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "Rfd - Yaw jitter on shot (●)", "rfd_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "Rfd - Body yaw jitter on shot (●)", "rfd_heaven_yaw_jb", -180, 180, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "Rfd - Break to left", "rfd_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "Rfd - Break to right", "rfd_heaven_yaw_r", -180, 180, 23, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "Rfd - Left fake yaw Opposite ", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "Rfd - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "Rfd - Refresh 'Opposite' desync in x ms", "rfd_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "Rfd - Overlay 'Eye yaw' desync in x ms", "rfd_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "Rfd - Loop in x ms", "rfd_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
        },     
    },    

    ["At targets"] = {
        conds = {
            ["Default"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "TGT - Default fallback condition.", "atd_heaven_check_cond"),
                dys_select = lua:call_menu(ui.new_combobox, "TGT - Desync target selection", "atd_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "TGT - Real yaw slider ", "atd_heaven_yaw_s", -20, 20, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "TGT - Fake yaw slider ", "atd_heaven_yaw_fake", 0, 60, 60, true,"°"),         
                dys_passive_stings = lua:call_menu(ui_multiselect, "TGT - Passive settings", "atd_heaven_dys_passiv", psive_cond), 
                dys_yawjit = lua:call_menu(ui.new_combobox, "TGT - Yaw jitter options", "atd_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "TGT - Yaw jitter slider ", "atd_heaven_yaw_jits", -60, 60, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "TGT - Body yaw jitter slider ", "atd_heaven_yaw_bjits", -180, 180, 0, true,"°"),
                dys_smooth = lua:call_menu(ui.new_combobox, "TGT - Desync smoothness", "atd_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "TGT - Invert smooth direction", "atd_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "TGT - Smooth Speed", "atd_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "TGT - Yaw smoothness", "atd_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "TGT - Break yaw methods (●)", "atd_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "TGT - Break yaw on shot (●)", "atd_heaven_yaw_bs", 0, 30, 0, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "TGT - Enable Jitter on shot (●)", "atd_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "TGT - Jitter on shot methods (●)", "atd_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "TGT - Yaw jitter on shot (●)", "atd_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "TGT - Body yaw jitter on shot (●)", "atd_heaven_yaw_jb", -60, 60, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "TGT - Break to left", "atd_heaven_yaw_l", -30, 30, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "TGT - Break to right", "atd_heaven_yaw_r", -30, 30, 0, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "TGT - Left fake yaw Opposite", "atd_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "TGT - Right fake yaw Eye yaw ", "atd_heaven_yaw_faker", 0, 60, 60, true,"°"),
                test4 = lua:call_menu(ui.new_slider, "TGT - Refresh 'Opposite' desync in x ms", "atd_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "TGT - Overlay 'Eye yaw' desync in x ms", "atd_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "TGT - Loop in x ms", "atd_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },            
            ["Standing"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "TGT - Enable Standing condition", "ats_heaven_check_stand"),
                dys_select = lua:call_menu(ui.new_combobox, "TGTS - Desync target selection", "ats_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "TGTS - Real yaw slider ", "ats_heaven_yaw_s", -20, 20, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "TGTS - Fake yaw slider ", "ats_heaven_yaw_fake", 0, 60, 60, true,"°"),  
                dys_passive_stings = lua:call_menu(ui_multiselect, "TGTS - Passive settings", "ats_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "TGTS - Yaw jitter options", "ats_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "TGTS - Yaw jitter slider ", "ats_heaven_yaw_jits", -60, 60, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "TGTS - Body yaw jitter slider ", "ats_heaven_yaw_bjits", -180, 180, 0, true,"°"),                    
                dys_smooth = lua:call_menu(ui.new_combobox, "TGTS - Desync smoothness", "ats_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "TGTS - Invert smooth direction", "ats_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "TGTS - Smooth Speed", "ats_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "TGTS - Yaw smoothness", "ats_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "TGTS - Break yaw methods (●)", "ats_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "TGTS - Break yaw on shot (●)", "ats_heaven_yaw_bs", 0, 30, 0, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "TGTS - Enable Jitter on shot (●)", "ats_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "TGTS - Jitter on shot methods (●)", "ats_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "TGTS - Yaw jitter on shot (●)", "ats_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "TGTS - Body yaw jitter on shot (●)", "ats_heaven_yaw_jb", -60, 60, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "TGTS - Break to left", "ats_heaven_yaw_l", -30, 30, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "TGTS - Break to right", "ats_heaven_yaw_r", -30, 30, 0, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "TGTS - Left fake yaw Opposite ", "ats_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "TGTS - Right fake yaw Eye yaw  ", "ats_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "TGTS - Refresh 'Opposite' desync in x ms", "ats_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "TGTS - Overlay 'Eye yaw' desync in x ms", "ats_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "TGTS - Loop in x ms", "ats_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["Moving"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "TGT - Enable Moving condition", "atrm_heaven_check_move"),
                dys_select = lua:call_menu(ui.new_combobox, "TGTM - Desync target selection", "atrm_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "TGTM - Real yaw slider ", "atrm_heaven_yaw_s", -20, 20, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "TGTM - Fake yaw slider ", "atrm_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "TGTM - Passive settings", "atrm_heaven_dys_passiv", psive_cond),
                dys_yawjit = lua:call_menu(ui.new_combobox, "TGTM - Yaw jitter options", "atrm_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "TGTM - Yaw jitter slider ", "atrm_heaven_yaw_jits", -60, 60, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "TGTM - Body yaw jitter slider ", "atrm_heaven_yaw_bjits", -180, 180, 0, true,"°"),                
                dys_smooth = lua:call_menu(ui.new_combobox, "TGTM - Desync smoothness", "atrm_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "TGTM - Invert smooth direction", "atrm_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "TGTM - Smooth Speed", "atrm_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "TGTM - Yaw smoothness", "atrm_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "TGTM - Break yaw methods (●)", "atrm_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "TGTM - Break yaw on shot (●)", "atrm_heaven_yaw_bs", 0, 30, 0, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "TGTM - Enable Jitter on shot (●)", "atrm_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "TGTM - Jitter on shot methods (●)", "atrm_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "TGTM - Yaw jitter on shot (●)", "atrm_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "TGTM - Body yaw jitter on shot (●)", "atrm_heaven_yaw_jb", -60, 60, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "TGTM - Break to left", "atrm_heaven_yaw_l", -30, 30, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "TGTM - Break to right", "atrm_heaven_yaw_r", -30, 30, 0, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "TGTM - Left fake yaw Opposite ", "rs_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "TGTM - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "TGTM - Refresh 'Opposite' desync in x ms", "atrm_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "TGTM - Overlay 'Eye yaw' desync in x ms", "atrm_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "TGTM - Loop in x ms", "atrm_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["Slow walking"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "TGT - Enable Slow walking condition", "atsw_heaven_check_slowwalk"),
                dys_select = lua:call_menu(ui.new_combobox, "TGTsw - Desync target selection", "atsw_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "TGTsw - Real yaw slider ", "atsw_heaven_yaw_s", -20, 20, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "TGTsw - Fake yaw slider ", "atsw_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "TGTsw - Passive settings", "atsw_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "TGTsw - Yaw jitter options", "atsw_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "TGTsw - Yaw jitter slider ", "atsw_heaven_yaw_jits", -60, 60, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "TGTsw - Body yaw jitter slider ", "atsw_heaven_yaw_bjits", -180, 180, 0, true,"°"),                  
                dys_smooth = lua:call_menu(ui.new_combobox, "TGTsw - Desync smoothness", "atsw_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "TGTsw - Invert smooth direction", "atsw_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "TGTsw - Smooth Speed", "atsw_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "TGTsw - Yaw smoothness", "atsw_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "TGTsw - Break yaw methods (●)", "atsw_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "TGTsw - Break yaw on shot (●)", "atsw_heaven_yaw_bs", 0, 30, 0, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "TGTsw - Enable Jitter on shot (●)", "atsw_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "TGTsw - Jitter on shot methods (●)", "atsw_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "TGTsw - Yaw jitter on shot (●)", "atsw_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "TGTsw - Body yaw jitter on shot (●)", "atsw_heaven_yaw_jb", -60, 60, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "TGTsw - Break to left", "atsw_heaven_yaw_l", -30, 30, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "TGTsw - Break to right", "atsw_heaven_yaw_r", -30, 30, 0, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "TGTsw - Left fake yaw Opposite ", "atsw_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "TGTsw - Right fake yaw Eye yaw  ", "rs_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "TGTsw - Refresh 'Opposite' desync in x ms", "atsw_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "TGTsw - Overlay 'Eye yaw' desync in x ms", "atsw_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "TGTsw - Loop in x ms", "atsw_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
            ["In air"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "TGT - Enable In air condition", "atair_heaven_check_inair"),
                dys_select = lua:call_menu(ui.new_combobox, "TGTair - Desync target selection", "atair_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "TGTair - Real yaw slider ", "atair_heaven_yaw_s", -20, 20, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "TGTair - Fake yaw slider ", "atair_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "TGTair - Passive settings", "atair_heaven_dys_passiv", psive_cond), 
                dys_yawjit = lua:call_menu(ui.new_combobox, "TGTair - Yaw jitter options", "atair_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "TGTair - Yaw jitter slider ", "atair_heaven_yaw_jits", -60, 60, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "TGTair - Body yaw jitter slider ", "atair_heaven_yaw_bjits", -180, 180, 0, true,"°"),                   
                dys_smooth = lua:call_menu(ui.new_combobox, "TGTair - Desync smoothness", "atair_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "TGTair - Invert smooth direction", "atair_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "TGTair - Smooth Speed", "atair_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "TGTair - Yaw smoothness", "atair_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "TGTair - Break yaw methods (●)", "atair_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "TGTair - Break yaw on shot (●)", "atair_heaven_yaw_bs", 0, 30, 0, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "TGTair - Enable Jitter on shot (●)", "atair_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "TGTair - Jitter on shot methods (●)", "atair_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "TGTair - Yaw jitter on shot (●)", "atair_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "TGTair - Body yaw jitter on shot (●)", "atair_heaven_yaw_jb", -60, 60, 0, true, "°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "TGTair - Left fake yaw Opposite ", "atair_h30en30w_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "TGTair - Right fake yaw Eye yaw  ", "rs_heav30ya30ak0", 0, 60, 60, true,"°"),                
                yaw_l = lua:call_menu(ui.new_slider, "TGTair - Break to left", "atair_heaven_yaw_l", -180, 180, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "TGTair - Break to right", "atair_heaven_yaw_r", -180, 180, 23, true,"°"),
                test4 = lua:call_menu(ui.new_slider, "TGTair - Refresh 'Opposite' desync in x ms", "atair_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "TGTair - Overlay 'Eye yaw' desync in x ms", "atair_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "TGTair - Loop in x ms", "atair_heaven_test6", 1, 110, 57, true, "s", 0.01),            
            },
            ["Double tap"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "TGT - Enable Double tap condition", "atdt_heaven_check_dt"),
                dys_select = lua:call_menu(ui.new_combobox, "TGTdt - Desync target selection", "atdt_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "TGTdt - Real yaw slider ", "atdt_heaven_yaw_s", -20, 20, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "TGTdt - Fake yaw slider ", "atdt_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "TGTdt - Passive settings", "atdt_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "TGTdt - Yaw jitter options", "atdt_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "TGTdt - Yaw jitter slider ", "atdt_heaven_yaw_jits", -60, 60, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "TGTdt - Body yaw jitter slider ", "atdt_heaven_yaw_bjits", -180, 180, 0, true,"°"),                  
                dys_smooth = lua:call_menu(ui.new_combobox, "TGTdt - Desync smoothness", "atdt_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "TGTdt - Invert smooth direction", "atdt_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "TGTdt - Smooth Speed", "atdt_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "TGTdt - Yaw smoothness", "atdt_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "TGTdt - Break yaw methods (●)", "atdt_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "TGTdt - Break yaw on shot (●)", "atdt_heaven_yaw_bs", 0, 30, 0, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "TGTdt - Enable Jitter on shot (●)", "atdt_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "TGTdt - Jitter on shot methods (●)", "atdt_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "TGTdt - Yaw jitter on shot (●)", "atdt_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "TGTdt - Body yaw jitter on shot (●)", "atdt_heaven_yaw_jb", -60, 60, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "TGTdt - Break to left", "atdt_heaven_yaw_l", -30, 30, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "TGTdt - Break to right", "atdt_heaven_yaw_r", -30, 30, 0, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "TGTdt - Left fake yaw Opposite ", "atdt_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "TGTdt - Right fake yaw Eye yaw  ", "atdt_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "TGTdt - Refresh 'Opposite' desync in x ms", "atdt_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "TGTdt - Overlay 'Eye yaw' desync in x ms", "atdt_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "TGTdt - Loop in x ms", "atdt_heaven_test6", 1, 110, 57, true, "s", 0.01),            
            },
            ["Fakeduck"] = {
                check_cond = lua:call_menu(ui_new_checkbox, "TGT - Enable Fakeduck condition", "atfd_heaven_check_fd"),
                dys_select = lua:call_menu(ui.new_combobox, "TGTfd - Desync target selection", "atfd_heaven_dys_select", "Eye yaw", "Opposite", "Both"),
                yaw_s = lua:call_menu(ui.new_slider, "TGTfd - Real yaw slider ", "atfd_heaven_yaw_s", -20, 20, 0, true,"°"),
                yaw_fake = lua:call_menu(ui.new_slider, "TGTfd - Fake yaw slider ", "atfd_heaven_yaw_fake", 0, 60, 60, true,"°"),    
                dys_passive_stings = lua:call_menu(ui_multiselect, "TGTfd - Passive settings", "atfd_heaven_dys_passiv", psive_cond),  
                dys_yawjit = lua:call_menu(ui.new_combobox, "TGTfd - Yaw jitter options", "atfd_heaven_dys_select", "Off", "Offset", "Center" ,"Random"),
                yawjit_s = lua:call_menu(ui.new_slider, "TGTfd - Yaw jitter slider ", "atfd_heaven_yaw_jits", -60, 60, 0, true,"°"),
                byawjit_s = lua:call_menu(ui.new_slider, "TGTfd - Body yaw jitter slider ", "atfd_heaven_yaw_bjits", -180, 180, 0, true,"°"),                  
                dys_smooth = lua:call_menu(ui.new_combobox, "TGTfd - Desync smoothness", "atfd_heaven_dys_smooth", "None", "Default", "Sway"),
                check_sid = lua:call_menu(ui_new_checkbox, "TGTfd - Invert smooth direction", "atfd_heaven_check_sid"),
                s_smooth = lua:call_menu(ui.new_slider, "TGTfd - Smooth Speed", "atfd_heaven_s_smooth", 1, 25, 10, true, "x", 0.1),
                yaw_smooth = lua:call_menu(ui.new_slider, "TGTfd - Yaw smoothness", "atfd_heaven_yaw_smooth", -60, 60, 0, true, "°", 1, {[0] = "Off"}),
                dys_break = lua:call_menu(ui_multiselect, "TGTfd - Break yaw methods (●)", "atfd_heaven_dys_break", break_m),
                yaw_bs = lua:call_menu(ui.new_slider, "TGTfd - Break yaw on shot (●)", "atfd_heaven_yaw_bs", 0, 30, 0, true, "°"),
                check_bj = lua:call_menu(ui_new_checkbox, "TGTfd - Enable Jitter on shot (●)", "atfd_heaven_check_bj"),
                dys_jitter = lua:call_menu(ui_multiselect, "TGTfd - Jitter on shot methods (●)", "atfd_heaven_dys_jitter", break_j),
                yaw_yj = lua:call_menu(ui.new_slider, "TGTfd - Yaw jitter on shot (●)", "atfd_heaven_yaw_yj", -180, 180, 0, true, "°"),
                yaw_jb = lua:call_menu(ui.new_slider, "TGTfd - Body yaw jitter on shot (●)", "atfd_heaven_yaw_jb", -60, 60, 0, true, "°"),
                yaw_l = lua:call_menu(ui.new_slider, "TGTfd - Break to left", "atfd_heaven_yaw_l", -30, 30, 1, true, "°"),
                yaw_r = lua:call_menu(ui.new_slider, "TGTfd - Break to right", "atfd_heaven_yaw_r", -30, 30, 0, true,"°"),
                yaw_fake_l = lua:call_menu(ui.new_slider, "TGTfd - Left fake yaw Opposite ", "atfd_heaven_yaw_fakel", 0, 60, 60, true,"°"),
                yaw_fake_r = lua:call_menu(ui.new_slider, "TGTfd - Right fake yaw Eye yaw  ", "atfd_heaven_yaw_faker", 0, 60, 60, true,"°"),                
                test4 = lua:call_menu(ui.new_slider, "TGTfd - Refresh 'Opposite' desync in x ms", "atfd_heaven_test4", 1, 109, 56, true, "s", 0.01),
                test5 = lua:call_menu(ui.new_slider, "TGTfd - Overlay 'Eye yaw' desync in x ms", "atfd_heaven_test5", 1, 109, 1, true, "s", 0.01),
                test6 = lua:call_menu(ui.new_slider, "TGTfd - Loop in x ms", "atfd_heaven_test6", 1, 110, 57, true, "s", 0.01),
            },
        },     
    }     

}
print(master_dir)
--client.set_event_callback("run_command", function() callbacks[TABLE_EVENTS["ON_CHANGE"]] = function(t, k, v) print("Changed " .. k) end end)

local label_text, info_text = '',''
local check_default = false

local dys_hurt, dis_b_shot = false, true

local handle_visibility = function( )
    local enabled = ui.get(ui_heaven)
    ui.set_visible(combo_select, enabled)    
    ui.set_visible(cond_combo_select, enabled and ui_get(ui_cond)) 

    for column, _ in pairs(master_dir) do
        local dir_m = ui.get(combo_select) == column
        for cond, _ in pairs(master_dir[column]) do
            for label, _ in pairs(master_dir[column].conds) do
                local cond_match = ui.get(cond_combo_select) == label
                for v_call, f_call in pairs(master_dir[column].conds[label]) do 
                    local cond_tab = ui_get(cond_combo_select)  
                    local c_cv
                    if cond_tab == "Default" then
                        c_cv = true
                    else
                        c_cv = ui.get(master_dir[column].conds[label].check_cond)
                    end
                    if ui_get(ui_cond) then
                        if data.idir ~= "None" then
                            ui.set(master_dir[column].conds["Default"].check_cond, ui.get(master_dir[data.idir].conds[data.cond_backup].check_cond))
                        end
                        check_default = ui_get(master_dir[ui.get(combo_select)].conds["Default"].check_cond)        
                    else
                        cond_tab = "Default"
                        ui_set(cond_combo_select, "Default")
                    end                  
                    --print(ui.get(master_dir[data.idir].conds[data.cond_backup].check_cond))
                    local c_cdef = ui_get(cond_combo_select) == "Default" and true or false
                    local s_default = ui_get(master_dir[column].conds[label].dys_smooth) == "Default"
                    local dys_both = ui_get(master_dir[column].conds[label].dys_select) == "Both"
                    local dys_s = ui_get(master_dir[column].conds[label].dys_smooth) ~= "None"
                    local dys_j = ui.get(master_dir[column].conds[label].check_bj)
                    local dys_yj = contains(master_dir[column].conds[label].dys_jitter, break_j[1])
                    local dys_bj = contains(master_dir[column].conds[label].dys_jitter, break_j[2])
                    local cond_on = ui_get(ui_cond)       
                    local dys_break_shot = contains(master_dir[column].conds[label].dys_break, break_m[1])
                    local dys_yaw_jit = contains(master_dir[column].conds[label].dys_passive_stings, psive_cond[1])
                    local dys_yaw_jit_val = ui_get(master_dir[column].conds[label].dys_yawjit) ~= "Off"
                    local dys_byaw_jit = contains(master_dir[column].conds[label].dys_passive_stings, psive_cond[2])
                    local dys_smoth = contains(master_dir[column].conds[label].dys_passive_stings, psive_cond[3])                   
                                
                    --client.log("----------DEBUG----------- ", globals.realtime())
                    --client.log(check_conds, " - ",ui.get(combo_select), " - ", cond_tab, " >> ",column, " -> ",cond, " - ", label, " - " , v_call ," - ", f_call, " -->" ,dir_m, " - ", cond_match)
                    --client.log("----------------------")
                    ui.set_visible(master_dir[column].conds[label].check_cond, enabled and dir_m and cond_match and not c_cdef)
                    ui.set_visible(master_dir[column].conds[label].dys_select, enabled and dir_m and cond_match and c_cv )
                    ui.set_visible(master_dir[column].conds[label].dys_smooth, enabled and dir_m and cond_match and c_cv and dys_smoth)
                    ui.set_visible(master_dir[column].conds[label].check_sid, enabled and dir_m and cond_match and c_cv and dys_s and s_default and dys_smoth)
                    ui.set_visible(master_dir[column].conds[label].dys_passive_stings, enabled and dir_m and cond_match and c_cv )
                    ui.set_visible(master_dir[column].conds[label].dys_yawjit, enabled and dir_m and cond_match and c_cv and dys_yaw_jit)
                    ui.set_visible(master_dir[column].conds[label].yawjit_s, enabled and dir_m and cond_match and c_cv and dys_yaw_jit and dys_yaw_jit_val)
                    ui.set_visible(master_dir[column].conds[label].byawjit_s, enabled and dir_m and cond_match and c_cv and dys_byaw_jit)
                    ui.set_visible(master_dir[column].conds[label].s_smooth, enabled and dir_m and cond_match and c_cv and dys_s and dys_smoth)
                    ui.set_visible(master_dir[column].conds[label].yaw_smooth, enabled and dir_m and cond_match and c_cv and dys_s and dys_smoth)
                    ui.set_visible(master_dir[column].conds[label].dys_break, enabled and dir_m and cond_match and c_cv and not dis_b_shot and cond_tab ~= "Standing" and cond_tab ~= "Fakeduck" and cond_tab ~= "In air")
                    ui.set_visible(master_dir[column].conds[label].check_bj, enabled and dir_m and cond_match and c_cv and not dis_b_shot and dys_break_shot and cond_tab ~= "Standing" and cond_tab ~= "Fakeduck" and cond_tab ~= "In air")
                    ui.set_visible(master_dir[column].conds[label].dys_jitter, enabled and dir_m and cond_match and c_cv and dys_j and not dis_b_shot and dys_break_shot and cond_tab ~= "Standing" and cond_tab ~= "Fakeduck" and cond_tab ~= "In air")
                    ui.set_visible(master_dir[column].conds[label].yaw_jb, enabled and dir_m and cond_match and c_cv and dys_bj and dys_j and not dis_b_shot and dys_break_shot and cond_tab ~= "Standing" and cond_tab ~= "Fakeduck" and cond_tab ~= "In air")
                    ui.set_visible(master_dir[column].conds[label].yaw_yj, enabled and dir_m and cond_match and c_cv and dys_yj and dys_j and not dis_b_shot and dys_break_shot and cond_tab ~= "Standing" and cond_tab ~= "Fakeduck" and cond_tab ~= "In air")
                    ui.set_visible(master_dir[column].conds[label].yaw_bs, enabled and dir_m and cond_match and c_cv and not dis_b_shot and dys_break_shot and cond_tab ~= "Standing" and cond_tab ~= "Fakeduck" and cond_tab ~= "In air" and ui_get(combo_select) ~= "At targets")
                    ui.set_visible(master_dir[column].conds[label].yaw_s, enabled and dir_m and cond_match and c_cv and not dys_both )
                    ui.set_visible(master_dir[column].conds[label].yaw_fake, enabled and dir_m and cond_match and c_cv and not dys_both )
                    ui.set_visible(master_dir[column].conds[label].yaw_l, enabled and dir_m and cond_match and c_cv and dys_both )
                    ui.set_visible(master_dir[column].conds[label].yaw_r, enabled and dir_m and cond_match and c_cv and dys_both )
                    ui.set_visible(master_dir[column].conds[label].yaw_fake_l, enabled and dir_m and cond_match and c_cv and dys_both )
                    ui.set_visible(master_dir[column].conds[label].yaw_fake_r, enabled and dir_m and cond_match and c_cv and dys_both )                    
                    ui.set_visible(master_dir[column].conds[label].test4, enabled and dir_m and cond_match and c_cv and dys_both )
                    ui.set_visible(master_dir[column].conds[label].test5, enabled and dir_m and cond_match and c_cv and dys_both )
                    ui.set_visible(master_dir[column].conds[label].test6, enabled and dir_m and cond_match and c_cv and dys_both )
                end
            end
        end         
    end
end

local function vis_conditions()
    local v = ui_get(ui_heaven)
    multi_exec(ui_set_visible, {
        [ui_enable_graph] = v,
        [ui_enable_ind] = v and ui_get(ui_enable_graph) ,
        [ui_debug] = v,
        [ui_color] = v and ui_get(ui_enable_graph) and ui_get(ui_enable_ind) ,
        [combo_select] = v,
        [ui_l_r_hotkey] = v,
        [ml_dir] = v,
        [mr_dir] = v,
        [info] = v,
        [info2] = v and (dis_correct or dis_b_shot),
        [ui_cond] = v,
    })
end    
vis_conditions()

local dir = {
    L_press = false,
    R_press = false,
}

local c_al, c_ar ,al, ar = true, true, false, false
local saved_press = ""
local function L_save_dir()
    saved_press = "L"
end
local function R_save_dir()
    saved_press = "R"
end
local function get_antiaim_dir()
    if not ui_get(ui_heaven) then return end    

    ui_set(ml_dir, "On hotkey")
    ui_set(mr_dir, "On hotkey")

    if not ui_get(ml_dir) then c_al = true end
    if not ui_get(mr_dir) then c_ar = true end

    if ui_get(ml_dir) and not dir.L_press and c_al then
        dir.L_press = true
        c_al = false
        L_save_dir()
    elseif ui_get(ml_dir) and dir.L_press and c_al then
        dir.L_press = false
        c_al = false 
        L_save_dir()
    end

    if ui_get(mr_dir) and not dir.R_press and c_ar then
        c_ar = false
        dir.R_press = true
        R_save_dir()
    elseif ui_get(mr_dir) and dir.R_press and c_ar then
        dir.R_press = false
        c_ar = false 
        R_save_dir()
    end   

    if dir.L_press and dir.R_press and saved_press == "L" then
        al, ar = false, false
        dir.L_press = false
    elseif dir.L_press and dir.R_press and saved_press == "R" then
        al, ar = false, false
        dir.R_press = false
    end

    if not dir.L_press and not dir.R_press and saved_press == "L" then
        al, ar = false, false
        dir.R_press = false
    elseif not dir.L_press and not dir.R_press and saved_press == "R" then
        al, ar = false, false
        dir.L_press = false
    end    

    if dir.L_press and not dir.R_press then
        if saved_press == "L" then
            al, ar = true, false
        elseif saved_press == "R" then
            al, ar = false, true
            dir.R_press = true
            dir.L_press = false
        end     
    elseif dir.R_press and not dir.L_press then
        if saved_press == "R" then
            al, ar = false, true
        elseif saved_press == "L" then
            al, ar = true, false
            dir.L_press = true  
            dir.R_press = false            
        end            
    end
end

local a_to_p, a_to_b, atb2, atp_dot_atb, t = 0,0,0,0,0
local function GetClosestPoint(A, B, P)
    a_to_p = { P[1] - A[1], P[2] - A[2] }
    a_to_b = { B[1] - A[1], B[2] - A[2] }

    atb2 = a_to_b[1]^2 + a_to_b[2]^2

    atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
    t = atp_dot_atb / atb2
    
    return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end

local c_fake = 0
client.set_event_callback("bullet_impact", function(c)
    if ui_get(ui_heaven) and entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
        
            if math.abs(delta_2d) < 32 then
                c_fake = c_fake + 1
            end
        end
    end
end)

--[[client.set_event_callback("player_hurt", function(e)
    if e.userid == nil and not dys_hurt then return end
    if data.hurts then return end
    local get_hitgroup = e.hitgroup
    if client.userid_to_entindex(e.userid) == get_local_player() then
        --if get_hitgroup == 1 or get_hitgroup == 5 or get_hitgroup == 6 then
            data.hurts = true
            if not ui_get(ui_l_r_hotkey) then
                hurt_val = math.random(-45, 11)
            else
                hurt_val = math.random(-11, 45)
            end
            ui.set(r_bodyyaw, "Static")
            ui.set(r_bodyyawsli, hurt_val)
        --end
    end
end)]]
local in_move = false
local velocity = function()
    local x, y, z = entity.get_prop(get_local_player(), "m_vecVelocity");
    if math.sqrt(x^2 + y^2) >= 8 then
        in_move = true
    else
        in_move = false
    end
    return math.sqrt(x^2 + y^2),in_move, (z^2 > 0) and true or false;
end

local fix_out, fix_in, time_fix = -0.42, 0, 0
local shot_active = false
local get_dys_break = false
client.set_event_callback("weapon_fire", function(e)
    if not ui_get(ui_heaven) then return end
    local PKQ = client.userid_to_entindex(e.userid)
    if PKQ ~= get_local_player() then return end
    if -fix_out < globals.realtime() * time_fix then fix_in = globals.realtime() + fix_out end 
    if velocity() <= 30 then return end

    if not get_dys_break or (ar or al) then return end
    if data.idir == "Right" then 
        ui.set(r_bodyyawsli, -60) 
        ui_set(r_yawsli, ui.get(master_dir["Right"].conds[data.cond].yaw_bs)) 
    elseif data.idir == "Left" then
        ui.set(r_bodyyawsli, 60) 
        ui_set(r_yawsli, -ui.get(master_dir["Left"].conds[data.cond].yaw_bs)) 
    end
end)
local r_hold = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim")
local dis_correct = true
local process_dt = false
client.set_event_callback("net_update_end", function()
    if dis_correct then return end
    local off_correct = { pcall(ui_reference,"AA", "Other", "Disable On shot interpolation") }
    if not off_correct[1] then return end
    if ui_get(r_dthk) and not ui_get(r_fakeduck) then if process_dt then ui_set(r_hold, true) process_dt = false end return end
    if ui_get(off_correct[2]) or dis_b_shot and not ui_get(ui_heaven) then return end
    ui_set(r_hold, false)
    process_dt = true
end)

set_event_callback("paint", function(c)
    fix_out = 0.32

    vis_conditions()

    --check dir modes
    local ids = { pcall(ui_reference, 'AA', 'Other', '[heaven.lua] Fake-lag heaven') }
    local on_correct = { pcall(ui_reference,"AA", "Other", "hold aim") }

    if not ids[1] then
        info_text = 'Warning: [heaven.lua] Fake-lag heaven not found.'
        dis_b_shot = true
        return
    end

    if not ui_get(ids[2]) then
        info_text = 'Warning: Fake-lag heaven lua is disabled.'
        dis_b_shot = true
    else
        if ui_get(on_correct[2]) then
            dis_correct = false
            dis_b_shot = false
        else
            dis_correct = true
            dis_b_shot = true
            info_text = 'Info: On-shot correction is disabled.'
        end
    end
    label_text = string.format('Current desync state: %s %s %s', data.idir,"-",data.cond)
    ui_set(info, label_text)
    ui_set(info2, info_text)
    -- 

end)
local in_air = false
local key_press = true
set_event_callback("setup_command", function(cmd)
    if not ui_get(ui_heaven) then return end
    
    if client.key_state(0x01) and key_press then
        client.delay_call(0.08, handle_visibility)
        key_press = false
    elseif not client.key_state(0x01) then
        key_press = true
    end
    local _, _, vel_air = velocity()
    local in_jump = cmd.in_jump
    if in_jump == 1 or vel_air then
        in_air = true
    else
        in_air = false
    end
end)

local lbyyawR , lbyyawL =  0, 0
local manual_dir = 0
local smooth = 0
local smooth_speed = 0
local hurt_val = 0
local final_limit = 0
local vel, in_move, _ = 0,false, 0
local check_state = "Local view"
set_event_callback("run_command", function(fl)    
    if not ui.get(ui_heaven) then return end
    get_antiaim_dir()
    vel, in_move, _ = velocity()
    if fl.chokedcommands > 0 then data.chock = fl.chokedcommands end

   local swap_fake = ui_get(ui_l_r_hotkey) and 1 or 2
   --client_log(c_fake)
   if ui_get(r_yawb) ~= "At targets" then
        if ui_get(ui_l_r_hotkey) then
            hurt_val = c_fake > 0 and 60 or -60
        else
            hurt_val = c_fake < 0 and -60 or 60
        end
    end
    if ui_get(refk_limit) >= 2 and fl.chokedcommands > 1 then final_limit = ui_get(refk_limit) else data.chock = 1 final_limit = math.random(0, 1) end
    --ui.set(r_yawsli, ui_get(yaw_sli))
    data.idir = ui_get(r_yawb) == "At targets" and "At targets" or ui_get(ui_l_r_hotkey) and "Left" or "Right"  

    data.cond_backup = not ui_get(ui_cond) and "Default" or in_air and "In air" or ui_get(r_fakeduck) and "Fakeduck" or ui_get(r_dthk) and "Double tap" or ui_get(slow_motion_hk) and in_move and "Slow walking" or in_move and "Moving" or "Standing"
    if not check_default or not ui_get(ui_cond) then 
        data.cond = "Default"
    elseif check_default and ui_get(ui_cond) then
        data.cond = not ui_get(ui_cond) and "Default" or in_air and "In air" or ui_get(r_fakeduck) and "Fakeduck" or ui_get(r_dthk) and "Double tap" or ui_get(slow_motion_hk) and in_move and "Slow walking" or in_move and "Moving" or "Standing"
    end
    lbyyawR = ui_get(master_dir[data.idir].conds[data.cond].yaw_r)
    lbyyawL = ui_get(master_dir[data.idir].conds[data.cond].yaw_l)
    data.use4 = ui_get(master_dir[data.idir].conds[data.cond].test4) / 100 
    data.use5 = ui_get(master_dir[data.idir].conds[data.cond].test5) / 100 
    data.use6 = ui_get(master_dir[data.idir].conds[data.cond].test6) / 100

    if data.hurts then ui.set(r_yaw, "180") ui.set(r_bodyyaw, "Static") data.hurts = false end
    if globals.realtime() >= data.rstime2 and data.chock == final_limit and not data.hurts then
        --client.log("reset " .. data.chock .. "  " ..  globals.realtime() ) 
        if (ar or al) then 
            if ui_get(r_yawb) == "At targets" then
                ui_set(r_yawb, "Local view")
                check_state = "At targets"
            end
            local manual_dir_set = ar and 90 or al and -90
            ui_set(r_yawsli, manual_dir_set)
        elseif not ar or not al then
            if check_state == "At targets" then
                ui_set(r_yawb, check_state)
                check_state = "Local view"
            end
            if ui.get(master_dir[data.idir].conds[data.cond].check_bj) and fix_in > globals.realtime() then
                if velocity() >= 30 then
                    if contains(master_dir[data.idir].conds[data.cond].dys_jitter, break_j[1]) then
                        ui_set(r_jittype, "Offset")
                        ui_set(r_jittsli, ui.get(master_dir[data.idir].conds[data.cond].yaw_yj))
                    end
                    if contains(master_dir[data.idir].conds[data.cond].dys_jitter, break_j[2]) then
                        ui.set(r_bodyyaw, "Jitter")
                        ui_set(r_bodyyawsli, ui.get(master_dir[data.idir].conds[data.cond].yaw_jb))
                    end
                end
            elseif fix_in < globals.realtime() then
                c_fake = 0
                if not contains(master_dir[data.idir].conds[data.cond].dys_passive_stings, psive_cond[2]) then
                    ui_set(r_bodyyawsli, hurt_val) 
                end    

                local b_yaw_state = contains(master_dir[data.idir].conds[data.cond].dys_passive_stings, psive_cond[2]) and "Jitter" or ui_get(r_yawb) == "At targets" and "Opposite" or "Static"
                ui_set(r_bodyyaw, b_yaw_state)
                local fs_yaw_state = ui_get(r_yawb) == "At targets" and true or false
                ui_set(r_check_lby, fs_yaw_state)

                
                if --[[not data.hurts]] not contains(master_dir[data.idir].conds[data.cond].dys_passive_stings, psive_cond[2]) then
                    ui_set(r_yaw, "180")
                else
                    ui_set(r_bodyyawsli, ui.get(master_dir[data.idir].conds[data.cond].byawjit_s))
                end
                if ui_get(master_dir[data.idir].conds[data.cond].dys_yawjit) == "Off" or not contains(master_dir[data.idir].conds[data.cond].dys_passive_stings, psive_cond[1]) then
                    ui_set(r_jittype, "Off")
                    ui_set(r_jittsli, 0)
                else
                    ui_set(r_jittype, ui.get(master_dir[data.idir].conds[data.cond].dys_yawjit))
                    ui_set(r_jittsli, ui.get(master_dir[data.idir].conds[data.cond].yawjit_s))
                end            
            end                
            manual_dir = 0
            if ui_get(master_dir[data.idir].conds[data.cond].dys_select) == "Both" then
                client.delay_call(data.use4, ui.set, r_lbyt, "Opposite")
                client.delay_call(data.use4, ui.set, r_yawsli, ui.get(master_dir[data.idir].conds[data.cond].yaw_r))
                client.delay_call(data.use4, ui.set, r_fake_yaw_slider, ui.get(master_dir[data.idir].conds[data.cond].yaw_fake_r))

                client.delay_call(data.use5, ui.set, r_lbyt, "Eye yaw")
                client.delay_call(data.use5, ui.set, r_yawsli, ui.get(master_dir[data.idir].conds[data.cond].yaw_l))
                client.delay_call(data.use5, ui.set, r_fake_yaw_slider, ui.get(master_dir[data.idir].conds[data.cond].yaw_fake_l))

               data.rstime2 = globals.realtime() + data.use6
            else
                ui_set(r_fake_yaw_slider, ui.get(master_dir[data.idir].conds[data.cond].yaw_fake))
                ui_set(r_lbyt, ui_get(master_dir[data.idir].conds[data.cond].dys_select))
                if fix_in < globals.realtime() then
                    ui_set(r_yawsli, math.max(-180, math.min(180, ui.get(master_dir[data.idir].conds[data.cond].yaw_s)+smooth)))
                end
            end            
            if ui_get(master_dir[data.idir].conds[data.cond].dys_smooth) == "None" or not contains(master_dir[data.idir].conds[data.cond].dys_passive_stings, psive_cond[3]) then
                smooth = 0
                smooth_speed = 0.1
            else
                if ui.get(master_dir[data.idir].conds[data.cond].yaw_smooth) == 0 then return end  
                smooth_speed = g_tickcount() * ui.get(master_dir[data.idir].conds[data.cond].s_smooth) / 10
                if ui_get(master_dir[data.idir].conds[data.cond].dys_smooth) == "Default" then   
                    if ui.get(master_dir[data.idir].conds[data.cond].check_sid) then
                        smooth = (-smooth_speed%ui.get(master_dir[data.idir].conds[data.cond].yaw_smooth))
                    else
                        smooth = (smooth_speed%ui.get(master_dir[data.idir].conds[data.cond].yaw_smooth))
                    end
                end     
                
                if ui_get(master_dir[data.idir].conds[data.cond].dys_smooth) == "Sway" then
                    local y_smooth = ui.get(master_dir[data.idir].conds[data.cond].yaw_smooth)
                    local g_smooth = math.abs((smooth_speed%ui.get(master_dir[data.idir].conds[data.cond].yaw_smooth)))
                    if g_smooth >= math.abs(y_smooth) - g_smooth then
                        smooth = (-smooth_speed%y_smooth * 2)
                    elseif g_smooth <= math.abs(y_smooth) then
                        smooth = (smooth_speed%y_smooth * 2)
                    end
                end
            end
        end
    end
    --client_log(ui_get(r_yawsli), " ", random_hurt, " ", data.hurts)
end)

local function setMath(int, max, declspec)
    local int = (int > max and max or int)
    local tmp = max / int;
    local i = (declspec / tmp)
    i = (i >= 0 and math.floor(i + 0.5) or math.ceil(i - 0.5))
    return i
end

local shot_circle, rv_circle = 0, 0
local break_anim, break_ranim = 0, 0
local function arrow_ind(c)
    if not ui_get(ui_heaven) or get_local_player() == nil or not entity_is_alive(get_local_player()) then 
        data.idir = "None"
        shot_circle = 0
        rv_circle = 0
        return
    end  

    if not ui_get(ui_enable_graph) then return end

    local get_x, get_y = hk_dragger:get()
    local scrsize_x, scrsize_y = client_screensize()
    local cen_x, cen_y = (scrsize_x * 0.5), (scrsize_y * 0.5)

    --all indicator calculations
    time_fix = 255 * 0.04 * globals.frametime()
    local body_pos = entity.get_prop(get_local_player(), "m_flPoseParameter", 11)
    local body_yaw = math.max(-60, math.min(60, body_pos*120-60+0.5))
    local p_yaw = body_yaw / 60 * 100
    if body_yaw < 0 then p_yaw = -p_yaw end
    local text_fake = body_yaw < 0 and -body_yaw or body_yaw
    local alpha = 1 + math.sin(math.abs(-math.pi + (globals.realtime() * (1 / 0.5)) % (math.pi * 2))) * 219  
    local f_alpha = 1 + math.sin(math.abs(-math.pi + (globals.realtime()) % (math.pi * 2))) * 120  
    local pulse = 8 + math.sin(math.abs(-math.pi + (globals.realtime() * (0.6 / 1)) % (math.pi * 2))) * 12
    if fix_in > globals.realtime() then shot_circle = (setMath(fix_in - globals.realtime(), fix_out , 40) * 0.004) else shot_circle = 0 end  
    --
    local text = string.format('DESYNC: %s°', string.format("%.f", text_fake)--[[,string.format("%.f", p_yaw), "%" , ui_get(ui_l_r_hotkey) and "R" or "L"]])
    local h, w = 36, 200
    local ind_match = dragging.match() and 200 or 0
    local r, g, b, a = ui_get(ui_color)
    local white_anim = shot_circle * 620
    local ind_r, ind_g, ind_b, ind_a = math.min(255, r + white_anim), math.min(255, g + white_anim),math.min(255, b + white_anim), math.min(255, a + white_anim) 
    local ind_dr, ind_dg, ind_db = math.min(255, 187 + break_ranim ), math.min(255, 128 - break_anim),math.min(255, 255 - break_anim)

    --renderer.rectangle(2 + get_x, get_y, w, h, 20, 20, 20, 255) 

    --renderer.text(5 + get_x, 2 + get_y, 255, 255, 255, 255, '', 0, text)   
    client.draw_gradient(ctx, get_x, get_y-2, 40 + pulse*5, 2, ind_r, ind_g, ind_b, 255, 25, 25, 25, 5, true)   -- top
    client.draw_gradient(ctx, get_x, get_y, pulse + ind_match, h, ind_r, ind_g, ind_b, 255, 25, 25, 25, 5, true)   --pulse
    client.draw_gradient(ctx, get_x + 5, get_y, w, 16, 0, 0, 0, 255, 10, 10, 10, 30, true)    -- top bar text

    client.draw_gradient(ctx, get_x + 5, get_y + 19, w, 16, 0, 0, 0, 255, 10, 10, 10, 30, true)    -- bottom bar text
    client.draw_gradient(ctx, get_x + 5, get_y+16, (w / 60) * text_fake, 3, 20, 20, 20, 255, ind_dr, ind_dg, ind_db, 220 , true)    -- dys bar text
    client.draw_gradient(ctx, get_x, get_y, w, h, 30, 30, 30, 200, 10, 10, 10, 10, true)        --interno
    client.draw_gradient(ctx, get_x, get_y + h, 120 + pulse*3, 3, ind_r, ind_g, ind_b, 255, 25, 25, 25, 20, true) -- bottom
    client.draw_gradient(ctx, get_x, get_y - 1, pulse, h+1, ind_r, ind_g, ind_b, 255, 25, 25, 25, 5, true)      --rosa lado  

    renderer.text(get_x + 8,get_y + 2, 187, 128, 255, 255, '', 0, text)
    if ar then
        renderer.text(get_x + 85,get_y + 2, 255, 255, 255, 255, '', 0, "DIR: M-RIGHT")
    elseif al then
        renderer.text(get_x + 85,get_y + 2, 255, 255, 255, 255, '', 0, "DIR: M-LEFT")
    else
        renderer.text(get_x + 85,get_y + 2, 255, 255, 255, 255, '', 0, "DIR: ", ui_get(r_yawb) == "At targets" and "AT-TGT" or ui_get(ui_l_r_hotkey) and "LEFT" or "RIGHT")
    end
    renderer.text(get_x + 158,get_y + 2, 128, 183, 255, 255, '', 0, "HEAVEN")    

    renderer.text(get_x + 8,get_y + 21, 187, 128, 255, 255, '', 0, "Curr. cond: ", data.cond)
    renderer.text(get_x + 132,get_y + 21, 128, 183, 255, 255, '', 0, "Velocity: ", math.floor(vel))

    --renderer.circle_outline(x, y, r, g, b, a, radius, start_degrees, percentage, thickness)

   if ui_get(ui_enable_ind) then
        if not al and not ar then
            if ui_get(r_yawb) == "Local view" then
                if data.idir == "Right" then
                    renderer.circle_outline(cen_x + smooth / 5, cen_y, ind_r, ind_g, ind_b, alpha, 40, 325 - shot_circle * 362, 0.2 + shot_circle , 6)
                elseif data.idir == "Left" then  
                    renderer.circle_outline(cen_x + smooth / 5, cen_y, ind_r, ind_g, ind_b, alpha, 40, 145, 0.2 + shot_circle, 6)
                end
            else
                local _, cyaw = client_camera_angles()
                local _, yaw = entity.get_prop(get_local_player(), "m_angAbsRotation")
                renderer.circle_outline(cen_x + smooth / 5, cen_y, ind_r, ind_g, ind_b, alpha, 40, (-yaw - body_yaw + cyaw) - 101 - shot_circle * 120, 0.08 + shot_circle * 0.65, 6)    
            end
        end

        if not al and not ar then

            if data.idir ~= "None" then
                get_dys_break = contains(master_dir[data.idir].conds[data.cond].dys_break, break_m[1])
            end
            if get_dys_break and not dis_b_shot and fix_in > globals.realtime() then
                if body_yaw > 45 and ui_get(ui_l_r_hotkey) or body_yaw < -45 and not ui_get(ui_l_r_hotkey) then
                    client_draw_text(c, cen_x +3 , cen_y +45, 255, 10, 30, setMath(fix_in - globals.realtime(), fix_out , 255), "c", 0, "BREAK") 
                    break_anim = setMath(fix_in - globals.realtime(), fix_out , 120)
                    break_ranim = setMath(fix_in - globals.realtime(), fix_out , 68)
                    --renderer.rectangle(5 + get_x,get_y + 15, w, 1, 255, 10, 30, setMath(fix_in - globals.realtime(), fix_out , 120))
                end
            elseif dis_b_shot then
                renderer.rectangle(3 + w + get_x, get_y -1 , 1, h, 255, 10, 30, f_alpha)
            end
        else
            if al then
                renderer.circle_outline(cen_x, cen_y, ind_r, ind_g, ind_b, alpha, 40, 120, 0.35 + shot_circle, 6)
            elseif ar then
                renderer.circle_outline(cen_x, cen_y, ind_r, ind_g, ind_b, alpha, 40, 295 - shot_circle * 362, 0.35 + shot_circle , 6)
            end 
        end 
    end
    hk_dragger:drag(w+5, h*1.15)
end
set_event_callback("paint", arrow_ind)

local update_check = ui_new_checkbox("AA", "Anti-aimbot angles", "Check up")
ui_set_visible(update_check, false)
local function vis_call()
    local should_on = not ui_get(ui_heaven) or ui_get(ui_debug)
    ui_set_visible(r_yaw, should_on)
    ui_set_visible(r_yawsli, should_on)
    ui_set_visible(r_jittype, should_on)
    ui_set_visible(r_jittsli, should_on)
    ui_set_visible(r_check_lby, should_on)
    ui_set_visible(r_lbyt, should_on)
    ui_set_visible(r_fake_yaw_slider, should_on)
    ui_set_visible(r_edge_yaw, should_on)
    ui_set_visible(r_freestanding, should_on)
    ui_set_visible(r_freestanding_hotkey, should_on)
    ui_set_visible(r_bodyyaw, should_on)
    ui_set_visible(r_bodyyawsli, should_on)

end
vis_call()
handle_visibility()
ui.set_callback(update_check, vis_call)

ui.set_callback(ui_heaven, function() 
    ui.set(update_check, true) 
    client.delay_call(0.01, ui_set, update_check, false) 
    handle_visibility() 
    vis_call() 
end)
client.set_event_callback("run_command", vis_call)

client.color_log(255, 255, 255, "       欢迎使用 姜太公 Anti Aim lua")
client.color_log(255, 255, 255, "       version: v2.0.1")
client.color_log(255, 255, 255, "       beta ( beta测试版本 ) ")
