--[[
	id: QbeufqNc9kQs0_3HYI3E8
	name: headbaim
	description: 123
	time1: 2021-05-20 08:10:13.931884+00
	time2: 2021-05-20 08:10:13.931884+00
	uploader: 4539
	uploadersession: Lrnvh5BkzLajMPyH6uMYJFFiiKHob-
	flag: f
--]]

local layer = require("ffi")
local success, surface = pcall(require, 'gamesense/surface')
local surface_measure_text, surface_draw_text = surface.measure_text, surface.draw_text
if not success then
    error('\n\n - 滚去订阅数据库 \n - https://gamesense.pub/forums/viewtopic.php?id=18793\n')
end

layer.cdef([[
    typedef void*(__thiscall* get_client_entity_t)(void*, int); // 3
    typedef void*(__thiscall* get_client_networkable_t)(void*, int); // 0
    typedef void*(__thiscall* get_client_unknown_t)(void*); // 0
    typedef void*(__thiscall* get_client_renderable_t)(void*); // 2
    typedef const void*(__thiscall* get_model_t)(void*); // 8
    typedef void*(__thiscall* get_studio_model_t)(void*, const void*); // 32
    typedef int(__fastcall* get_sequence_activity_t)(void*, void*, int);

    struct animation_layer_t {
        char pad20[24];
        uint32_t m_nSequence;
        float m_flPrevCycle;
        float m_flWeight;
        char pad20[8];
        float m_flCycle;
        void *m_pOwner;
        char pad_0038[ 4 ];
    };

    struct ccsweaponinfo_t
    {
        char    pad_0008[17];
        int	    m_max_clip;
    };
    typedef struct ccsweaponinfo_t*(__thiscall* get_ccs_weapon_info_t)(void*);
]])

local slot2 = layer.typeof("void***")
local rawentityl = layer.cast("void***", client.create_interface("client_panorama.dll", "VClientEntityList003") or error("VClientEntityList003 wasnt found", 2)) or error("rawientitylist is nil", 2)
local castplayernetwork = layer.cast("get_client_networkable_t", rawentityl[0][0]) or error("get_client_entity is nil", 2)
local castgetclient = layer.cast("get_client_entity_t", rawentityl[0][3]) or error("get_client_entity is nil", 2)
local rawivmodelinfo = layer.cast("get_studio_model_t", (layer.cast('void***', client.create_interface("engine.dll", "VModelInfoClient004")) or error("rawivmodelinfo is nil", 2))[0][32])



local function slot10(slot0)
	if slot0 then
		slot0 = layer.cast(uv1, slot0)

		if layer.cast("get_client_unknown_t", rawentityl[0][0])(slot0) or error("error getting client unknown", 2) then
			slot2 = layer.cast(uv1, slot2)

			if layer.cast("get_client_renderable_t", castgetclient[0][5])('void***') or error("error getting client renderable", 2) then
				slot3 = layer.cast(uv1, slot3)

				return layer.cast("get_model_t", slot3[0][8])(slot3) or error("error getting model_t", 2)
			end
		end
	end
end

local function wtfisthis(this1, this2, this3)
	this4 = layer.cast(uv1, this1)

	if uv2(uv3, uv4(this2)) == nil then
		return -1
	end

	return layer.cast("get_sequence_activity_t", client.find_signature("client_panorama.dll", "U\\x8b\\xecS\\x8b]V\\x8b\\xf1\\x83"))(this1, this4, this3)
end

local function get_anim(this1, this2)
	return layer.cast("struct animation_layer_t**", layer.cast("char*", layer.cast(uv1, this1)) + 10624)[0][this2 or 1]
end

layer.cdef([[
	typedef struct  {
		float x;
		float y;
		float z;
	}vec3_t;
    struct animstate_s
	{
		void *pThis;
		char pad2[91];
		void* pBaseEntity; //0x60
		void* pActiveWeapon; //0x64
		void* pLastActiveWeapon; //0x68
		float m_flLastClientSideAnimationUpdateTime; //0x6C
		int m_iLastClientSideAnimationUpdateFramecount; //0x70
		float m_flEyePitch; //0x74
		float m_flEyeYaw; //0x78
		float m_flPitch; //0x7C
		float m_flGoalFeetYaw; //0x80
		float m_flCurrentFeetYaw; //0x84
		float m_flCurrentTorsoYaw; //0x88
		float m_flUnknownVelocityLean; //0x8C //changes when moving/jumping/hitting ground
		float m_flLeanAmount; //0x90
		char pad4[4]; //NaN
		float m_flFeetCycle; //0x98 0 to 1
		float m_flFeetYawRate; //0x9C 0 to 1
		float m_fUnknown2;
		float m_fDuckAmount; //0xA4
		float m_fLandingDuckAdditiveSomething; //0xA8
		float m_fUnknown3; //0xAC
		vec3_t m_vOrigin; //0xB0, 0xB4, 0xB8
		vec3_t m_vLastOrigin; //0xBC, 0xC0, 0xC4
		float m_vVelocityX; //0xC8
		float m_vVelocityY; //0xCC
		char pad5[4];
		float m_flUnknownFloat1; //0xD4 Affected by movement and direction
		char pad6[8];
		float m_flUnknownFloat2; //0xE0 //from -1 to 1 when moving and affected by direction
		float m_flUnknownFloat3; //0xE4 //from -1 to 1 when moving and affected by direction
		float m_unknown; //0xE8
		float speed_2d; //0xEC
		float flUpVelocity; //0xF0
		float m_flSpeedNormalized; //0xF4 //from 0 to 1
		float m_flFeetSpeedForwardsOrSideWays; //0xF8 //from 0 to 2. something  is 1 when walking, 2.something when running, 0.653 when crouch walking
		float m_flFeetSpeedUnknownForwardOrSideways; //0xFC //from 0 to 3. something
		float m_flTimeSinceStartedMoving; //0x100
		float m_flTimeSinceStoppedMoving; //0x104
		unsigned char m_bOnGround; //0x108
		unsigned char m_bInHitGroundAnimation; //0x109
		char pad7[10];
		float m_flLastOriginZ; //0x114
		float m_flHeadHeightOrOffsetFromHittingGroundAnimation; //0x118 from 0 to 1, is 1 when standing
		float m_flStopToFullRunningFraction; //0x11C from 0 to 1, doesnt change when walking or crouching, only running
		char pad8[4]; //NaN
		float m_flUnknownFraction; //0x124 affected while jumping and running, or when just jumping, 0 to 1
		char pad9[4]; //NaN
		float m_flUnknown3;
		char pad10[528];
	};
]])

local function animstate(this)
	if (layer.cast(layer.typeof("void***"), get_anim(uv1, this) or error("get_client_entity returned nil", 2)) or error("couldn't cast entity", 2)) ~= nil then
		return layer.cast("struct animstate_s**", layer.cast("char*", slot2) + 14592)[0] or error("ent_ptr is nil", 2)
	end
end

local _resolver = "Predict"
local p_r,p_g,p_b = 255,100,100

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
local color_log = client.color_log
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

--refs
local p_list = ui.reference('PLAYERS', 'Players', 'Player list')
local p_reset = ui.reference('PLAYERS', 'Players', 'Reset all')

local pl_fakebody, pl_fakebodysli = ui.reference('PLAYERS', 'Adjustments', 'Force body yaw')

local pl_rctive = ui.reference('PLAYERS', 'Adjustments', 'Correction active')

local pl_ovraa = ui.reference('PLAYERS', 'Adjustments', 'Override prefer body aim')
local pl_sp = ui.reference('PLAYERS', 'Adjustments', 'Override safe point')
--

local player_data = {}
local function reset_all()

    ui_set(p_reset, true)

    client.update_player_list()

    for i=1, 64, 1 do
        player_data[i] = {
            miss_shot = 0,
            bodyyaw = 0,
            bodybo = 0,
            cres = 0,
            missdef = 0,
            missbsc = 0,
            missdis = 0,
            maxmiss = 0,
            hurtdef = 0,
            hurtbsc = 0,
            hurtdis = 0,
            hurtgeneric = 0,
            body_aim = 0,
            miss_player_name = "",
            resolver_state = "",
            abres_state = "",
        }
    end
end
reset_all()

--menu locals
local ui_heaven = ui_new_checkbox("RAGE", "Other", "Headbaim match")
local ui_color = ui_new_color_picker("RAGE", "Other", "Resmatch ind color", "194", "102", "255", "200")
local ui_debuglog = ui_new_checkbox("RAGE", "Other", "Enable debug log (console)")
local indicator = ui_new_checkbox("RAGE", "Other", "Playerlist indicator")
local debug = ui_new_checkbox("RAGE", "Other", "Player indicator")
local ui_resetround = ui_new_checkbox("RAGE", "Other", "Reset data each round")
local ui_reset = ui.new_button("RAGE", "Other", "Reset cache", function() reset_all() return color_log(245, 229, 56,"[404 project] Reset data!") end)
local combo_settings = ui.new_combobox("RAGE", "Other", "headbaim settings:", "DEBUG")

local miss_label = ui.new_label('PLAYERS', 'Adjustments', string.format('Missed due prediction: %s', '0'))
local miss_label1 = ui.new_label('PLAYERS', 'Adjustments', string.format('Missed due prefer: %s', '0'))
local miss_label2 = ui.new_label('PLAYERS', 'Adjustments', string.format('Hit in force: %s', '0'))
--
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
local hk_dragger = dragging.new("res ind", 600, 500)

local function vis()
    local v = ui_get(ui_heaven)
    ui.set_visible(ui_debuglog, v)
    ui.set_visible(ui_color, v)
    ui.set_visible(ui_resetround, v)
    ui.set_visible(ui_reset, v)
    ui.set_visible(combo_settings, v)
    ui.set_visible(miss_label, v)
    ui.set_visible(miss_label1, v)
    ui.set_visible(miss_label2, v)
    ui_set_visible(indicator, v)
    ui_set_visible(debug, v)
end

local angle = {
    normalize_yaw = function(yaw)
        while yaw > 180 do yaw = yaw - 360 end
        while yaw < -180 do yaw = yaw + 360 end

        return yaw
    end,

    angle_to_vec = function(pitch, yaw)
        local deg2rad = math.pi / 180.0

        local p, y = deg2rad*pitch, deg2rad*yaw
        local sp, cp, sy, cy = sin(p), cos(p), sin(y), cos(y)
        return cp*cy, cp*sy, -sp
    end,

    vector_angles = function(x1, y1, z1, x2, y2, z2)
        --https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/mathlib/mathlib_base.cpp#L535-L563
        local origin_x, origin_y, origin_z
        local target_x, target_y, target_z
        if x2 == nil then
            target_x, target_y, target_z = x1, y1, z1
            origin_x, origin_y, origin_z = client.eye_position()
            if origin_x == nil then
                return
            end
        else
            origin_x, origin_y, origin_z = x1, y1, z1
            target_x, target_y, target_z = x2, y2, z2
        end

        --calculate delta of vectors
        local delta_x, delta_y, delta_z = target_x-origin_x, target_y-origin_y, target_z-origin_z

        if delta_x == 0 and delta_y == 0 then
            return (delta_z > 0 and 270 or 90), 0
        else
            --calculate yaw
            local yaw = math.deg(math.atan2(delta_y, delta_x))

            --calculate pitch
            local hyp = math.sqrt(delta_x*delta_x + delta_y*delta_y)
            local pitch = math.deg(math.atan2(-delta_z, hyp))

            return pitch, yaw
        end
    end,

    is_player_moving = function(ent)
        local vec_vel = { get_prop(ent, 'm_vecVelocity') }
        local velocity = math.floor(math.sqrt(vec_vel[1]^2 + vec_vel[2]^2) + 0.5)

        return velocity > 1
    end,

    predict_positions = function(posx, posy, posz, ticks, ent)
        local x, y, z = get_prop(ent, 'm_vecVelocity')

        for i = 0, ticks, 1 do
            posx = posx + x * interval_per_tick()
            posy = posy + y * interval_per_tick()
            posz = posz + z * interval_per_tick() + 9.81 * interval_per_tick() * interval_per_tick() / 2
        end

        return posx, posy, posz
    end
}

--Script locals
local multi_exec = function(func, list)
    if func == nil then
        return
    end

    for ref, val in pairs(list) do
        func(ref, val)
    end
end
local backwards_to_me = false
local enemy_bpos = 0
local bodynum = { -30 , 30 }
local p_correct = {[0] = true , [1] = false }
local pl_body = { [0] = '-', [1] = 'On', [2] = 'Force' }
local c_cache = {}
local e_data = {}
local target_name = ""
local callback_pl = function(me, e)
    if not ui_get(ui_heaven) then return end
    local e_data = player_data[e]
    local c_cache = player_data[e]
    local eye_pos = { client.eye_position() }

    -- math calc
    local defpercentage = math.floor(e_data.hurtdef/(e_data.missdef+e_data.hurtdef+1)*100)
    local bscpercentage = math.floor(e_data.hurtbsc/(e_data.missbsc+e_data.hurtbsc+1)*100)
    local dispercentage = math.floor(e_data.hurtdis/(e_data.missdis+e_data.hurtdis+1)*100)
    local h_percentage = {defpercentage, bscpercentage, dispercentage}
    local maxhold, max = 1, h_percentage[1]
    local max_percentage = 0
    for k, v in ipairs(h_percentage) do
        if h_percentage[k] > max then
            maxhold, max = k, v
        end
    end

    local abs_origin = { get_prop(e, 'm_vecAbsOrigin') }
    local ang_abs = { get_prop(e, 'm_angAbsRotation') }
    local ang_fake = { get_prop(e, "m_flPoseParameter", 11) }

    local pitch, yaw = angle.vector_angles(abs_origin[1], abs_origin[2], abs_origin[2], eye_pos[1], eye_pos[2], eye_pos[3])
    local yaw_degress = math.ceil(math.abs(angle.normalize_yaw(yaw - ang_abs[2] - math.floor((ang_fake[1] / 2)*100))))
    local yaw_fake = math.floor(math.abs(angle.normalize_yaw(ang_fake[1]*100)))

    backwards_to_me = yaw_degress > 120 + yaw_fake or yaw_degress < 120 - 30
    enemy_bpos = yaw_fake

    e_data.bodyyaw = -1

    --if e_data.miss_shot > 0 then

    if ui_get(combo_settings) == "DEBUG" then
        local maxmisshold = e_data.maxmiss % 5
        if maxmisshold <= 1 then
            if maxmisshold == 0 then
                e_data.cres = 0
                e_data.bodybo = 1
                ui_set(pl_ovraa, pl_body[e_data.cres])
                ui_set(pl_rctive, p_correct[e_data.bodybo])
            elseif maxmisshold == 1 then
                e_data.bodybo = 0
                ui_set(pl_rctive, p_correct[e_data.bodybo])
            end
        elseif maxmisshold == 2 then
                e_data.cres = 1
                e_data.bodybo = 0
                ui_set(pl_ovraa, pl_body[e_data.cres])
                ui_set(pl_rctive, p_correct[e_data.bodybo])
        elseif maxmisshold > 2 then
            if maxmisshold == 3 then
                e_data.cres = 2
                e_data.bodybo = 0
                ui_set(pl_ovraa, pl_body[e_data.cres])
                ui_set(pl_rctive, p_correct[e_data.bodybo])
            elseif maxmisshold == 4 then
                e_data.bodybo = 1
                ui_set(pl_rctive, p_correct[e_data.bodybo])
            end
        end
    end

    if ui_get(pl_ovraa, pl_body[e_data.cres]) == "-" then
        _resolver = "PREDICT"
        p_r,p_g,p_b = 255,100,100
    elseif ui_get(pl_ovraa, pl_body[e_data.cres]) == "On" then
         _resolver = "PREFER"
         p_r,p_g,p_b = 100,100,255
    elseif ui_get(pl_ovraa, pl_body[e_data.cres]) == "Force" then
         _resolver = "FORCE"
         p_r,p_g,p_b = 100,255,100
    end

    if ui_get(ui_debuglog) then
        if c_cache[e_data.cres] ~= e_data.cres then
            color_log(194, 102, 255,"[404 project] Set " .. entity.get_player_name(e) .. " to " .. string.format('%s', _resolver) .. ".")
            c_cache[e_data.cres] = e_data.cres

        end
    end
end

local function setMath(int, max, declspec)
    local int = (int > max and max or int)
    local tmp = max / int;
    local i = (declspec / tmp)
    i = (i >= 0 and math.floor(i + 0.5) or math.ceil(i - 0.5))
    return i
end

local fix_out, fix_in, time_fix = -0.42, 0, 0
local get_miss = function(e)
    if not ui_get(ui_heaven) then return end
    if e.reason == "?" then
        if -fix_out < globals.realtime() * time_fix then fix_in = globals.realtime() + fix_out end
        local e_data = player_data[e.target]
        e_data.miss_shot = e_data.miss_shot + 1
        if pl_body[e_data.cres] == "On" then
            e_data.missdef = e_data.missdef + 1
        elseif pl_body[e_data.cres] == "-" then
            e_data.missdis = e_data.missdis + 1
        else
            e_data.missbsc = e_data.missbsc + 1
        end
        e_data.maxmiss = e_data.maxmiss + 1
        e_data.miss_player_name = entity.get_player_name(player_data[e.target])
        if ui_get(ui_debuglog) then
            color_log(255, 100, 100,"[404 project] Missed " .. entity.get_player_name(e.target) .. " due to resolver." .. "(using: " .. string.format('%s', _resolver) .. " mode)")
        end
    end
end

local get_hit = function(e)
    if not ui_get(ui_heaven) then return end
    local attacker_id = client.userid_to_entindex(e.attacker)
    if attacker_id == nil then return end
    if attacker_id ~= entity.get_local_player() then return end
    local target_id = client.userid_to_entindex(e.userid)
    local e_data = player_data[target_id]
    client.log(e_data)
    if e.hitgroup == 1 then
        if pl_body[e_data.cres] == "-" then
            e_data.hurtdef = e_data.hurtdef + 1
        elseif pl_body[e_data.cres] == "On" then
            e_data.hurtdis = e_data.hurtdis + 1
        else
            e_data.hurtbsc = e_data.hurtbsc + 1
        end
    else
        e_data.hurtgeneric = e_data.hurtgeneric + 1
    end
end


client.set_event_callback('cs_game_disconnected', reset_all)
client.set_event_callback('game_newmap', reset_all)
client.set_event_callback('aim_miss', get_miss)
client.set_event_callback('player_hurt', get_hit)
local miss_animshot = 0
local t_data = 0
local handle = {}

local function hsv_to_rgb(h, s, v, a)
    local r, g, b
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
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

client.set_event_callback('paint', function()
    if not ui_get(ui_heaven) then
        ui_set_visible(indicator, false)
        ui_set_visible(debug, false)
        ui_set_visible(ui_color, false)
        ui_set_visible(ui_resetround, false)
        ui_set_visible(ui_reset, false)
        ui_set_visible(combo_settings, false)
        ui_set_visible(miss_label, false)
        ui_set_visible(miss_label1, false)
        return
    end
    client.update_player_list()
    fix_out = 0.8

    local get_x, get_y = hk_dragger:get()
    local tget_x, tget_y = hk_dragger:get()
    local scrsize_x, scrsize_y = client_screensize()
    local r, g, b, a = ui_get(ui_color)
    local pulse = 8 + math.sin(math.abs(-math.pi + (globals.realtime() * (0.6 / 1)) % (math.pi * 2))) * 12
    local alpha = 1 + math.sin(math.abs(-math.pi + (globals.realtime() * (1 / 0.5)) % (math.pi * 2))) * 219
    local h, w = 17, 206
    local th, tw = 34, 206
    if fix_in > globals.realtime() then miss_animshot = (setMath(fix_in - globals.realtime(), fix_out , 40) * 0.004) else miss_animshot = 0 end
    local red_anim = miss_animshot * 1595
    local ind_r, ind_g, ind_b, ind_a = math.max(0, math.min(255, r + math.floor(red_anim))), math.max(0, math.min(255, g - math.floor(red_anim))),math.max(0, math.min(255, b - math.floor(red_anim))),math.max(0, math.min(255, a + math.floor(red_anim)))
    local ind_match = dragging.match() and 200 or 0
    local verdana = surface.create_font('verdana', 13, 700, { 0x200 --[[ Outline ]] })
    local verdana1 = surface.create_font('verdana', 9, 200, { 0x200 --[[ Outline ]] })
    local me = entity.get_local_player()
    local players = entity.get_players(true)
    local pl_cache = ui_get(p_list)
    local pitch1, yaw1 = client.camera_angles()
    pitch1 = math.random(90,75)
    yaw2 = yaw1 + 180


    if ui.get(indicator) then

    client.draw_gradient(ctx, get_x, get_y-2, 235, 2, ind_r, ind_g, ind_b, 255, ind_r, ind_g, ind_b, 255, true)   -- top
    client.draw_gradient(ctx, get_x, get_y, 5, h, ind_r, ind_g, ind_b, 255, ind_r, ind_g, ind_b, 3, true)   --pulse
    client.draw_gradient(ctx, get_x + 235, get_y, -5, h, ind_r, ind_g, ind_b, 255, ind_r, ind_g, ind_b, 3, true)
    client.draw_gradient(ctx, get_x+235, get_y+17, -235, 2, ind_r, ind_g, ind_b, 255, ind_r, ind_g, ind_b, 255, true)   -- top

    --line 1
    surface_draw_text(get_x + 8,get_y + 2, r, g, b, a, verdana, "HEADBAIM")
    surface_draw_text(get_x + 155,get_y + 2, g, b, r, a, verdana, "404 project")

    end
    for i=1, #players do
        ui_set(p_list, players[i])

        handle = ui_get(p_list)
        if handle ~= nil and entity.is_enemy(handle) then

            local e_data = player_data[handle]
            callback_pl(me, handle)
            local origin = { get_prop(handle, 'm_vecAbsOrigin') }
            --client.register_esp_flag()

            if origin[1] ~= nil then
                local astate = layer.new("struct animstate_s")
                local eye_pos = { client.eye_position() }
                local x1, y1, x2, y2, alpha_multiplier = entity.get_bounding_box(handle)
                local rainbow_r, rainbow_g, rainbow_b = func_rgb_rainbowize((2 / 15), 1)
                if x1 ~= nil and alpha_multiplier > 0 then
                    if y1 - 2 ~= nil then

                        if e_data.resolver_state == "-" then
                            _resolver = "PREDICT"
                            p_r,p_g,p_b = 255,100,100
                        elseif e_data.resolver_state == "ON" then
                            _resolver = "PREFER"
                            p_r,p_g,p_b = 100,100,255
                        elseif e_data.resolver_state == "Force" then
                            _resolver = "FORCE"
                            p_r,p_g,p_b = 100,255,100
                        end
                            if ui.get(debug) then
                                renderer.text(7 + x1 + (x2 - x1), (y1-2), 0, 255, 255, 255, "c-", 0, string.format('%s', _resolver))
                            end
                            tget_y = tget_y + 18
                            th = th + 18
                            if ui.get(indicator) then
                            local get_name = entity.get_player_name(handle)
                            local name_len = string.len(get_name)
                            local name = ""
                            if name_len > 15 then
                                local lenth = name_len - 15
                                name = get_name:sub(1, name_len - lenth) .. "..."
                            else
                                name = get_name
                            end
                            surface_draw_text(get_x + 22,tget_y +1, r, g, b, a, verdana, "Target: ")
                            surface_draw_text(get_x + 70,tget_y +1,  b, g, r, a, verdana, name)
                            surface_draw_text(get_x + 168,tget_y+1, p_r, p_g, p_b, 255, verdana, string.format('%s', _resolver))
                            local c_r = ui_get(pl_rctive, p_correct[e_data.bodybo]) and 100 or 255
                            local c_g = ui_get(pl_rctive, p_correct[e_data.bodybo]) and 255 or 100
                            local c_b = ui_get(pl_rctive, p_correct[e_data.bodybo]) and 100 or 100
                    
                            surface_draw_text(get_x + 8,tget_y+1, p_r, p_g, p_b, 255, verdana, string.format( i ))
                        end
                    end
                end
            end
        end
    end
    if ui.get(indicator) then
    if th == 34 then
        surface_draw_text(get_x + 80,get_y + 2, 100, 255, 100, alpha, verdana, "WAITING")
    else
        surface_draw_text(get_x + 88,get_y + 2, 255, 100, 100, alpha, verdana, "ACTIVE")
    end
end



    hk_dragger:drag(w+5, h + th - 34)


    if pl_cache ~= nil then
        ui_set(p_list, pl_cache)
        ui_set(miss_label, string.format('Hit Prediction: %s | Hit PREFER: %s | Hit FORCE: %s', player_data[pl_cache].hurtdef,player_data[pl_cache].hurtdis,player_data[pl_cache].hurtbsc))
        ui_set(miss_label1, string.format('Prediction %s: %.1f | PREFER %s: %.1f | FORCE %s: %.1f',
        "%",
        (player_data[pl_cache].hurtdef/(player_data[pl_cache].missdef +player_data[pl_cache].hurtdef+1)*100) or 0,
        "%",
        (player_data[pl_cache].hurtdis/(player_data[pl_cache].missdis +player_data[pl_cache].hurtdis+1)*100) or 0,
        "%",
        (player_data[pl_cache].hurtbsc/(player_data[pl_cache].missbsc +player_data[pl_cache].hurtbsc+1)*100) or 0))
        ui_set(miss_label2, string.format('Miss Prediction: %s | Miss PREFER: %s | Miss FORCE: %s | Max miss: %s', player_data[pl_cache].missdef, player_data[pl_cache].missdis, player_data[pl_cache].missbsc, player_data[pl_cache].maxmiss % 3))
    end
end)

local function r_end()
    if not ui_get(ui_resetround) then return end
    reset_all()
end

client.set_event_callback("round_prestart", r_end)
vis()
set_callback(ui_heaven, vis)