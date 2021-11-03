--[[
	id: qTmO-24Zj7N-wJwr0ELrZ
	name: poop
	description: 4/24/21
	time1: 2021-04-25 05:02:12.516755+00
	time2: 2021-04-25 05:02:12.516756+00
	uploader: AL2r8xi1iIeKD9Fo3pcvSYqzFSzmzcQJVhUodV24
	uploadersession: DPNrQWpexLFTQnSXNEhrHQfmkR-mxE
	flag: f
--]]

--region ffi
-- credits: Valve Corporation, lua.org, "none"

--
-- todo; add asserts
--       add handling for div by 0
--       change vector normalize
--       add Vector2 and Angle files / implementation
--

-- localize vars

local type         = type;
local setmetatable = setmetatable;
local tostring     = tostring;
local js = panorama.open()
local persona_api = js.MyPersonaAPI
local name = persona_api.GetName()
local get_database = database.read( "release" )
client.color_log(255, 255, 255, "|--------------------------------------------------------|")
client.color_log(21, 235, 220,  "                       Welcome " .. get_database.username .. "!            ")
client.color_log(215, 115, 222, "                    Tibzzy#5021 on Discord                ")
client.color_log(235, 221, 21,  "                    Last Updated: 4/25/2021.              ")
client.color_log(255, 255, 255, "|--------------------------------------------------------|")

--comes with manual aa
--first try // deadline 2 weeks (i'll just update it from now no recode and maybe bugfixes)
--not customizable just hardcoded

local ref = {
	aa_enable = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
	lowerbody = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target"),
	yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
	fyawlimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
	pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
	freestanding_byaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
	safe_point = ui.reference("RAGE", "Aimbot", "Force safe point"),
	double_tap_mode = ui.reference("RAGE", "Other", "Double tap mode"),
	double_tap_fake_lag_limit = ui.reference("RAGE", "Other", "Double tap fake lag limit"),
	double_tap_hc = ui.reference("RAGE", "Other", "Double tap hit chance"),
	fake_variance = ui.reference("AA", "Fake lag", "Variance"),
	fake_lag = ui.reference("AA", "Fake lag", "Limit"),
	fake_lag_type = ui.reference("AA", "Fake lag", "Amount"),
	legmovement = ui.reference("AA", "OTHER", "leg movement"),
	tickstoprocess = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
	tomi = ui.reference("Rage", "Other", "Force body aim"),
	fakeduck = ui.reference("Rage", "Other", "Duck peek assist"),
	onShot = {ui.reference("AA", "Other", "On shot anti-aim")},
	edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
}

local labels = {
	label0 = ui.new_label("AA", "Anti-aimbot angles", "--------------------------------------------------------------"),
	label = ui.new_label("AA", "Anti-aimbot angles", "                Artemis | Tibzzy#5021 on discord               "),
}

local mshit = {
	active = ui.new_checkbox("AA", "Anti-aimbot angles", 'Watermark'),
	color_picker = ui.new_color_picker("AA", "Anti-aimbot angles", 'Watermark color picker', 194, 87, 116, 255),
	autobuy = ui.new_checkbox("AA", "Anti-aimbot angles", "Fastest Autobuy"),
	autobuy_options = ui.new_combobox("AA", "Anti-aimbot angles", "Autobuy:", { "AWP", "SCOUT", }),
	faster_dt = ui.new_checkbox("AA", "Anti-aimbot angles", "Faster Doubletap"),
	adaptive_dt = ui.new_checkbox("AA", "Anti-aimbot angles", "Ping Based Doubletap"),
	TwinTower_enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "Clantag"),
	enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "Enable AA"),

	--fixed the multiselect stupid stuff and now its combobox
	option = ui.new_combobox("AA", "Anti-aimbot angles", "AA Options", "Manual AA"),
	back = ui.new_hotkey("AA", "Anti-aimbot angles", "Back Hotkey"),
	left = ui.new_hotkey("AA", "Anti-aimbot angles", "Left Hotkey"),
	right = ui.new_hotkey("AA", "Anti-aimbot angles", "Right Hotkey"),
	forward = ui.new_hotkey("AA", "Anti-aimbot angles", "Forward Hotkey"),
	ideal = ui.new_checkbox("AA", "Anti-aimbot angles", "Ideal Yaw"),
	idealoption = ui.new_combobox("AA", "Anti-aimbot angles", "AA Mode", "Normal", "Low Delta", "Opposite", "Jitter", "EHold", "Crouched"),
	antibrute = ui.new_checkbox("AA", "Anti-aimbot angles", "Anti-bruteforce"),
	enable = ui.new_checkbox("AA", "Anti-aimbot angles", "Better body freestanding"),
	mode = ui.new_combobox("AA", "Anti-aimbot angles", "Body freestanding mode", { "Hide real", "Hide fake" }),
	legit_e_key = ui.new_checkbox("AA", "Anti-aimbot angles", "Legit AA on E"),
	leg_breaker = ui.new_checkbox("AA", "Other", "Leg movement"),

	indicator_enable = ui.new_combobox("AA", "Anti-aimbot angles", "Indicators", { "On", "Off" }),
	extra_indicators = ui.new_checkbox("AA", "Anti-aimbot angles", "Extra Skeet Indicators"),
	visual_arrows = ui.new_checkbox("AA", "Anti-aimbot angles", "Arrow Indication"),
	desync = ui.new_checkbox("AA", "Anti-aimbot angles", "Desync Indicator"),
	desync_where = ui.new_combobox("AA", "Anti-aimbot angles", "Desync Indicator Location", "At Crosshair", "At Indicators"),
	x_slider = ui.new_slider("VISUALS", "Other ESP", "Desync Indicator X offset", 0, 960, 87),
	y_slider = ui.new_slider("VISUALS", "Other ESP", "Desync Indicator Y offset", 0, 540, 20),
	visual_text = ui.new_checkbox("AA", "Anti-aimbot angles", "Text Indication"),
	indicators = ui.new_multiselect("AA", "Anti-aimbot angles", "Indicator list", "AA States", "Doubletap", "Fakeduck", "Safepoint", "Hideshots", "Force body aim", "Fakelag", "Desync Bar"),

	label = ui.new_label("AA", "Anti-aimbot angles", "Manual AA Arrows Color"),
	color  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color", 194, 87, 116, 255),
	label2 = ui.new_label("AA", "Anti-aimbot angles", "Artemis Indicator Color"),
	color2  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color2", 147, 52, 235, 255),

	label3 = ui.new_label("AA", "Anti-aimbot angles", "Normal AA Type Color"),
	color3  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color3", 98, 52, 235, 255),

	label4 = ui.new_label("AA", "Anti-aimbot angles", "Opposite AA Type Color"),
	color4  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color4", 255, 59, 59, 255),

	label5 = ui.new_label("AA", "Anti-aimbot angles", "Low Delta AA Type Color"),
	color5  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color5", 66, 66, 245, 255),

	label6 = ui.new_label("AA", "Anti-aimbot angles", "Jitter AA Type Color"),
	color6  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color6", 235, 52, 153, 255),

	label15 = ui.new_label("AA", "Anti-aimbot angles", "Crouched AA Type Color"),
	color15  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color14", 158, 235, 52, 255),

	label7 = ui.new_label("AA", "Anti-aimbot angles", "Legit AA Type Color"),
	color7  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color7", 52, 128, 235, 255),

	label9 = ui.new_label("AA", "Anti-aimbot angles", "Doubletap (Not Charged Color)"),
	color9  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color9", 254, 148, 148, 255),

	label10 = ui.new_label("AA", "Anti-aimbot angles", "Doubletap (Charged Color)"),
	color10 = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color10", 148, 252, 153, 255),

	label11 = ui.new_label("AA", "Anti-aimbot angles", "Fakeduck Color"),
	color11  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color11", 255, 255, 255, 255),

	label12 = ui.new_label("AA", "Anti-aimbot angles", "Safepoint Color"),
	color12  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color12", 255, 255, 255, 255),

	label13 = ui.new_label("AA", "Anti-aimbot angles", "Hideshots Color"),
	color13  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color13", 255, 255, 255, 255),

	label14 = ui.new_label("AA", "Anti-aimbot angles", "Force body aim Color"),
	color14  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color13", 255, 255, 255, 255),

	label8 = ui.new_label("AA", "Anti-aimbot angles", "FakeLag Color"),
	color8  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color8", 255, 255, 255, 255),

	label16 = ui.new_label("AA", "Anti-aimbot angles", "Bar Color"),
	color16 = ui.new_color_picker("AA", "Anti-aimbot angles", 'Bar Color', 255, 255, 255, 255),
	label17 = ui.new_label("AA", "Anti-aimbot angles", "Second Bar Color"),
	color17 = ui.new_color_picker("AA", "Anti-aimbot angles", 'Second Color Bar', 255, 255, 255, 255),

}

--getting locals for ui.set
local yaw2, yaw = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local bodyyaw, bodyyaw2 = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local jyaw, jyawslide = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local freestanding, freestanding_key = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local double_tap, double_tap_key = ui.reference("RAGE", "Other", "Double tap")

local slowwalk_checkbox, slowwalk_hotkey = ui.reference("AA", "Other", "Slow motion")
local ref_hide_shots, ref_hide_shots_hk = ui.reference("AA", "Other", "On shot anti-aim")
local quick_peek_box, quick_peek_key = ui.reference( "Rage", "Other", "Quick peek assist" )
local client_set_clan_tag = client.set_clan_tag
local oldTick = globals.tickcount()
---endregion


--==--==--=-{ Watermark } --==--==--=-

local nickname = get_database.username
local ctag = 'Artemis'

-- Things
local ffi = require 'ffi'
local interface_ptr = ffi.typeof('void***')
local latency_ptr = ffi.typeof('float(__thiscall*)(void*, int)')

local rawivengineclient = client.create_interface('engine.dll', 'VEngineClient014') or error('VEngineClient014 wasnt found', 2)
local ivengineclient = ffi.cast(interface_ptr, rawivengineclient) or error('rawivengineclient is nil', 2)

local get_net_channel_info = ffi.cast('void*(__thiscall*)(void*)', ivengineclient[0][78]) or error('ivengineclient is nil')
local is_in_game = ffi.cast('bool(__thiscall*)(void*)', ivengineclient[0][26]) or error('is_in_game is nil')

local notes = (function(b)local c=function(d,e)local f={}for g in pairs(d)do table.insert(f,g)end;table.sort(f,e)local h=0;local i=function()h=h+1;if f[h]==nil then return nil else return f[h],d[f[h]]end end;return i end;local j={get=function(k)local l,m=0,{}for n,o in c(package.cnotes)do if o==true then l=l+1;m[#m+1]={n,l}end end;for p=1,#m do if m[p][1]==b then return k(m[p][2]-1)end end end,set_state=function(q)package.cnotes[b]=q;table.sort(package.cnotes)end,unset=function()client.unset_event_callback('shutdown',callback)end}client.set_event_callback('shutdown',function()if package.cnotes[b]~=nil then package.cnotes[b]=nil end end)if package.cnotes==nil then package.cnotes={}end;return j end)('a_watermark')

local paint_handler = function()
    notes.set_state(ui.get(mshit.active))
    notes.get(function(id)
        local sys_time = { client.system_time() }
        local actual_time = string.format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

        local text = string.format('%s | %s | %s', ctag, nickname, actual_time)

        if is_in_game(is_in_game) == true then
            local INetChannelInfo = ffi.cast(interface_ptr, get_net_channel_info(ivengineclient)) or error('netchaninfo is nil')
            local get_avg_latency = ffi.cast(latency_ptr, INetChannelInfo[0][10])
            local latency = get_avg_latency(INetChannelInfo, 0) * 1000
            local tick = 1/globals.tickinterval()
			local ticks = ui.get(ref.tickstoprocess)
            
			if ui.get(ref.tickstoprocess) == 62 then
				text = string.format('%s | %s | Ticks Shifted: 16 | Ping: %dms | %dTick | %s', ctag, nickname, latency, tick, actual_time)
			else
				text = string.format('%s | %s | Ticks Shifted: %d | Ping: %dms | %dTick | %s', ctag, nickname, ticks, latency, tick, actual_time)
			end
			
        local r, g, b, a = ui.get(mshit.color_picker)
        local h, w = 18, renderer.measure_text(nil, text) + 8
        local x, y = client.screen_size(), 10 + (25*id)

        x = x - w - 10

        renderer.rectangle(x, y, w, 2, r, g, b, 255)
        renderer.rectangle(x, y + 2, w, h, 17, 17, 17, a)
        renderer.text(x+4, y + 4, 255, 255, 255, 255, '', 0, text)
    end
	end)
end

client.set_event_callback('paint_ui', paint_handler)

--==--==--=-{ Watermark } --==--==--=-

--==--==--=-{ Auto Buy } --==--==--=-
local bought
local test = 0

function jew()
if not ui.get(mshit.autobuy) then return end
local weapon_name = entity.get_classname(entity.get_player_weapon(entity.get_local_player()))

	if entity.is_alive(entity.get_local_player()) then
		if ui.get(mshit.autobuy_options) == "AWP" then
			if weapon_name ~= "CWeaponAWP" then
				client.exec("buy awp;")
				client.color_log(3, 252, 119, "[Artemis] Tried buying awp at: ", globals.curtime())
			end
		elseif ui.get(mshit.autobuy_options) == "SCOUT" then
			if weapon_name ~= "CWeaponSSG08" then
				client.exec("buy ssg08;")
				client.color_log(3, 252, 119, "[Artemis] Tried buying scout at: ", globals.curtime())
			end
		end
	end
end

client.set_event_callback("paint", function ()
	penis = ui.get(mshit.autobuy)
	ui.set_visible(mshit.autobuy_options, penis)
	if not bought then
		client.delay_call(test - 0.03, jew)
		client.delay_call(test - 0.01, jew)
		client.delay_call(test, jew)
		client.delay_call(test + 0.01, jew)
		bought = true
	end
end)

client.set_event_callback("round_end", function ()
if not ui.get(mshit.autobuy) then return end
	bought = false
	test = cvar.mp_round_restart_delay:get_float()
end)

client.set_event_callback("round_prestart", function ()
if not ui.get(mshit.autobuy) then return end
	print("Preround: ", globals.curtime())
	jew()
	client.delay_call(0.00001, jew)
	client.delay_call(0.00003, jew)
	client.delay_call(0.00005, jew)
end)

client.set_event_callback("player_connect_full", function (plr)
	if client.userid_to_entindex(plr) == entity.get_local_player() then
		test = 0
		bought = false
	end
end)

--==--==--=-{ Auto Buy } --==--==--=-
--the stuff we need to begin with

local function GetClosestPoint(A, B, P)
    local a_to_p = { P[1] - A[1], P[2] - A[2] }
    local a_to_b = { B[1] - A[1], B[2] - A[2] }

    local atb2 = a_to_b[1]^2 + a_to_b[2]^2

    local atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
    local t = atp_dot_atb / atb2
    
    return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end

function round(num, numDecimalPlaces)
	local mult = 1^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local byawamtnormal = 141 --standing
local eholdaa = 120 -- ehold 180, 90 -- moving
local eholdaa2 = 90 --standing
local byawamtopposite = 90 --moving 48 112 --120 -90 --41 --42 really good 180 --24
local byawamtjitter = 98 --101 --air --45 is ok --47 GOOD NOT FAKELAG
local byawamtjitter2 = 97 -- FAKELAG AIR --24
local crouched = 90 -- crouch
local lowdelta = 31 --slowwalking 31
local lowdeltabrute = 180
local lowdeltabrute2 = 90

local lby = 0
local lby1 = 0
local lby2 = 0
local lby3 = 0
local lby4 = 0
local lby5 = 0
local lby6 = 0
local lby7 = 0
local lby8 = 0
local lby9 = 0

local des = 1
local des1 = 1
local des2 = 1
local des3 = 1
local des4 = 1
local des5 = 1
local des6 = 1
local des7 = 1
local des8 = 1
local des9 = 1

local ass = 0
local side = 0
local faggot = 0
local faggot2 = 0
local cracker = 0
local randomidea = 0
local randomidea2 = 0

local function flip()
	if entity.is_alive(entity.get_local_player()) then
		if ui.get(mshit.idealoption) == "EHold" then
			des9 = -des9
			--client.color_log(255,255,255, "E-Hold Still")
		elseif ui.get(mshit.idealoption) == "Crouched" then
			des7 = -des7
			--client.color_log(255,255,255, "Crouching")
		elseif ui.get(mshit.idealoption) == "Low Delta" then
			des3 = -des3
			des4 = -des4
			des6 = -des6
			--client.color_log(255,255,255, "Slowwalking")
		elseif ui.get(mshit.idealoption) == "Opposite" then
			des1 = -des1
			--client.color_log(255,255,255, "Running")
		elseif ui.get(mshit.idealoption) == "Normal" then
			des = -des
			--client.color_log(255,255,255, "Standing")
		elseif ui.get(mshit.idealoption) == "Jitter" then
			des2 = -des2
			--client.color_log(255,255,255, "Air")
		end
	end
end

local function flip2()
	if entity.is_alive(entity.get_local_player()) then
		if ui.get(mshit.idealoption) == "Crouched" then
			des7 = -des7
			--client.color_log(255,0,0, "Crouching")
		elseif ui.get(mshit.idealoption) == "Opposite" then
			des1 = -des1
			--client.color_log(255,0,0, "Running")
		elseif ui.get(mshit.idealoption) == "Normal" then
			des = -des
			--client.color_log(255,0,0, "Standing")
		elseif ui.get(mshit.idealoption) == "Jitter" then
			des2 = -des2
			des8 = -des8
			--client.color_log(255,0,0, "Air")
		end
	end
end

local function flip3()
	if entity.is_alive(entity.get_local_player()) then
		if ui.get(mshit.idealoption) == "Low Delta" then
			des3 = -des3
			des4 = -des4
			des6 = -des6
			--client.color_log(0,255,0, "Slowwalking")
		elseif ui.get(mshit.idealoption) == "Opposite" then
			des1 = -des1
			--client.color_log(0,255,0, "Running")
		end
	end
end

local function reset()
	des = 1
	des1 = 1
	des2 = 1
	des3 = 1
	des4 = 1
	des5 = 1
	des6 = 1
	des7 = 1
	des8 = 1
	des9 = 1
end

local function ass_reset()
	ass = 0
end

local function faggot_reset()
	faggot = 0
	des3 = 1
	des4 = 1
	des6 = 1
end

local function cracker_reset()
	cracker = 0
end

local function randomidea_reset()
	randomidea = 0
end

local function randomidea2_reset()
	randomidea2 = 0
end

local function desync_on()
	ui.set(ref.aa_enable, true)
end

local function desync_off()
	ui.set(ref.aa_enable, false)
end

--==--==--=-{ FAKE LAG SHIT } --==--==--=-

local OldChoke = 0
--local toDraw5 = 0
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
		--toDraw5 = ui.get(ref.fake_variance)
	end
	OldChoke = cmd.chokedcommands
end

client.set_event_callback('setup_command', setup_command)

--==--==--=-{ FAKE LAG SHIT } --==--==--=-

--==--==--=-{ Anti-bruteforce } --==--==--=-
client.set_event_callback("bullet_impact", function(c)
    if ui.get(mshit.antibrute) then
        if entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
                if math.abs(delta_2d) < 75 then
                    if ui.get(mshit.idealoption) == "Low Delta" then
                        if faggot <= 2 then
                            client.color_log(0, 255, 0, faggot)
                        end
                        
                        if faggot >= 2 then --proper 2
                            faggot_reset()
                            --client.color_log(255, 0, 255, "Reset")
                        else
                            faggot = faggot + 1
                        end
                    else                
                        if cracker >= 2 then
                            cracker_reset()
                        else
                            cracker = cracker + 1
                        end
                        client.delay_call(2, cracker_reset)
                    end
                    flip()	
					--client.delay_call(2, faggot_reset)
                    --client.color_log(255, 0, 255, "Attempted Anti-Brute")
                end
            end
        end
    end
end)

--[[
local function dist_from_3dline(shooter, e)
	local x, y, z = entity.hitbox_position(shooter, 0)
	local x1, y1, z1 = client.eye_position()

	return ((e.y - y)*x1 - (e.x - x)*y1 + e.x*y - e.y*x) / math.sqrt((e.y-y)^2 + (e.x - x)^2)
end

client.set_event_callback("bullet_impact", function(e)
	local plocal = entity.get_local_player()
	local shooter = client.userid_to_entindex(e.userid)

	if not entity.is_enemy(shooter) or not entity.is_alive(plocal) then
		return
	end

	local d = dist_from_3dline(shooter, e)

	if math.abs(d) < 75 then
		if ui.get(mshit.idealoption) == "Low Delta" then
			if faggot <= 2 then
				client.color_log(0, 255, 0, faggot)
			end
						
			if faggot >= 2 then --proper 2
				faggot_reset()
				--client.color_log(255, 0, 255, "Reset")
			else
				faggot = faggot + 1
			end
		else				
			if cracker >= 1 then
				cracker_reset()
			else
				cracker = cracker + 1
			end
		end
		flip()
		--client.color_log(255, 0, 255, "Attempted Anti-Brute")
	end
end)
--]]

local function on_player_hurt(e)
	if not ui.get(mshit.antibrute) then
		return
	end
	
	if not entity.is_alive(entity.get_local_player()) then return end

	if client.userid_to_entindex(e.userid) == entity.get_local_player() then
		if ui.get(mshit.idealoption) == "Low Delta" then				
			if faggot <= 2 then
				client.color_log(255, 0, 0, faggot)
			end
							
			if faggot >= 2 then --proper 2
				faggot_reset()
				--client.color_log(255, 0, 255, "Reset")
			else
				faggot = faggot + 1
			end
		else
			if cracker >= 1 then
				cracker_reset()
			else
				cracker = cracker + 1
			end
		end
		flip3()
	end
end
client.set_event_callback("player_hurt", on_player_hurt)


local function keybind()
	if ui.get(ref_hide_shots) and ui.get(ref_hide_shots_hk) then check_hide_shots = true else check_hide_shots = false end
	if ui.get(double_tap) and ui.get(double_tap_key) then check_double_tap = true else check_double_tap = false end
	if ui.get(ref.fakeduck) then check_fake_duck = true else check_fake_duck = false end
end
client.set_event_callback('setup_command', keybind)

local function aimFire()
	if not ui.get(mshit.enabled) then return end
	if ui.get(holding_e) then return end

	if not check_double_tap and check_hide_shots or check_fake_duck then else
		if OldChoke <= 1 then
			client.delay_call(0.01, desync_off)
			client.delay_call(0.01, desync_on)
			pitch3, yaw3 = client.camera_angles()
			pitch2 = math.random(75, 90)
			pitch2 = math.random(75, 90)
			pitch2 = math.random(75, 90)
			pitch2 = math.random(75, 90)
			pitch2 = math.random(75, 90)
			pitch2 = math.random(75, 90)
			--client.color_log(255, 0, 255, pitch3)
		end
	end
end

--==--==--=-{ Anti-bruteforce } --==--==--=-

--==--==--=-{ Legit AA on E } --==--==--=-


holding_e = ui.new_checkbox("AA", "Anti-aimbot angles", "Holding E")
ui.set_visible(holding_e, false)

local csgo_weapons = require "gamesense/csgo_weapons"

local function entity_has_c4(ent)
	local bomb = entity.get_all("CC4")[1]
	return bomb ~= nil and entity.get_prop(bomb, "m_hOwnerEntity") == ent
end

local function distance3d(x1, y1, z1, x2, y2, z2)
	return math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
end

local var = {
	classnames = {
	"CWorld",
	"CCSPlayer",
	"CFuncBrush"
	},
}

local function aa_on_use(c)
	if ui.get(mshit.legit_e_key) then
		local plocal = entity.get_local_player()
		
		local distance = 100
		local bomb = entity.get_all("CPlantedC4")[1]
		local bomb_x, bomb_y, bomb_z = entity.get_prop(bomb, "m_vecOrigin")

		if bomb_x ~= nil then
			local player_x, player_y, player_z = entity.get_prop(plocal, "m_vecOrigin")
			distance = distance3d(bomb_x, bomb_y, bomb_z, player_x, player_y, player_z)
		end
		
		local team_num = entity.get_prop(plocal, "m_iTeamNum")
		local defusing = team_num == 3 and distance < 62

		local on_bombsite = entity.get_prop(plocal, "m_bInBombZone")

		local has_bomb = entity_has_c4(plocal)
		local trynna_plant = on_bombsite ~= 0 and team_num == 2 and has_bomb and not ui.get(mshit.legit_e_key)
		
		local px, py, pz = client.eye_position()
		local pitch2, yaw = client.camera_angles()
	
		local sin_pitch = math.sin(math.rad(pitch2))
		local cos_pitch = math.cos(math.rad(pitch2))
		local sin_yaw = math.sin(math.rad(yaw))
		local cos_yaw = math.cos(math.rad(yaw))

		local dir_vec = { cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch }

		local fraction, entindex = client.trace_line(plocal, px, py, pz, px + (dir_vec[1] * 8192), py + (dir_vec[2] * 8192), pz + (dir_vec[3] * 8192))

		local using = true

		if entindex ~= nil then
			for i=0, #var.classnames do
				if entity.get_classname(entindex) == var.classnames[i] then
					using = false
				end
			end
		end

		if not using and not trynna_plant and not defusing then
			c.in_use = 0
		end
		
		if client.key_state(0x45) then
			ui.set(holding_e, true)
			ui.set(ref.pitch, "Off")
		else
			ui.set(holding_e, false)
			pitch_int = math.random(1, 3)
			if pitch_int == 1 then
				ui.set(ref.pitch, "down")
			end
			if pitch_int == 3 then
				ui.set(ref.pitch, "default")
			end
			if pitch_int == 2 then
				ui.set(ref.pitch, "minimal")
			end
		end
	end
end

local function on_setup_command(c)
	aa_on_use(c)
end

client.set_event_callback("setup_command", on_setup_command)
--==--==--=-{ Legit AA on E } --==--==--=-

--==--==--=-{ Doubletap } --==--==--=-

local function doubletap_charged()
    -- Make sure we have doubletap enabled, are holding our doubletap key & we aren't fakeducking.
    if not ui.get(double_tap) or not ui.get(double_tap_key) or ui.get(ref.fakeduck) then return false end

    -- Get our local player.
    local me = entity.get_local_player()

    -- Sanity checks on local player (since paint & a few other events run even when dead).
    if me == nil or not entity.is_alive(me) then return false end

    -- Get our local players weapon.
    local weapon = entity.get_prop(me, "m_hActiveWeapon")

    -- Make sure that it is valid.
    if weapon == nil then return false end

    -- Basic definitions used to calculate if we have recently shot or swapped weapons.
    local next_attack = entity.get_prop(me, "m_flNextAttack") + 0.25
    local next_primary_attack = entity.get_prop(weapon, "m_flNextPrimaryAttack") + 0.5

    -- Make sure both values are valid.
    if next_attack == nil or next_primary_attack == nil then return false end

    -- Return if both are under 0 meaning our doubletap is charged / we can fire (you can also use these values as a 2nd return parameter to get the charge %).
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end

local dt_latency = 0
local function doubletap()
    if not ui.get(mshit.faster_dt) then return end
	
    ui.set(ref.double_tap_fake_lag_limit, 1)
	ui.set_visible(ref.tickstoprocess, false)

    if ui.get(ref.fakeduck) or ui.is_menu_open() or not ui.get(double_tap_key) then
        ui.set(ref.tickstoprocess, 16)
		cvar.cl_clock_correction:set_int(1)
    elseif ui.get(quick_peek_box) and ui.get(quick_peek_key) then
		ui.set(ref.tickstoprocess, 17)
	else
        if ui.get(mshit.adaptive_dt) then
            if dt_latency <= 20 then
                ui.set(ref.tickstoprocess, 18)
            elseif dt_latency <= 40 then
                ui.set(ref.tickstoprocess, 18)
            elseif dt_latency <= 65 then
                ui.set(ref.tickstoprocess, 18)
            elseif dt_latency <= 95 then
                ui.set(ref.tickstoprocess, 17)
            else
                ui.set(ref.tickstoprocess, 17)
            end
        else
            ui.set(ref.tickstoprocess, 62)
            cvar.cl_clock_correction:set_int(0)
        end
    end
end
client.set_event_callback("run_command", doubletap)

--==--==--=-{ Doubletap } --==--==--=-

--==--==--=-{ Clantag } --==--==--=-

local TwinTowerClantag = 
{
	"",
    "A",
    "Ar",
    "Art",
    "Arte",
    "Artem",
    "Artemi",
    "Artemis",
    "Artemis ",
    "Artemis ",
    "Artemis ",
    "Artemis",
	"Artemi",
	"Artem",
    "Arte",
    "Art",
    "Ar",
    "A",
    "",
} 
local cur = 1

local function get_twint(e)
    if (ui.get(mshit.TwinTower_enabled)) then
        if globals.tickcount() - oldTick > 5 then
            cur = math.floor(globals.curtime() % 19 + 1)
            client_set_clan_tag(TwinTowerClantag[cur])
            oldTick = globals.tickcount()
        end
    end
end
client.set_event_callback("player_connect_full", function(e)
    oldTick = globals.tickcount()
end)
client.set_event_callback("paint", get_twint)

--==--==--=-{ Clantag } --==--==--=-

--==--==--=-{ GUI Handling } --==--==--=-

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

local function handleGUI()

	ui.set_visible(ref.tickstoprocess, false)
	
    if ui.get(mshit.enabled) then
		ui.set_visible(ref.pitch, false)
		ui.set_visible(ref.yawbase, false)
		ui.set_visible(yaw, false)
		ui.set_visible(yaw2, false)
		ui.set_visible(bodyyaw, false)
		ui.set_visible(bodyyaw2, false)
		ui.set_visible(jyaw, false)
		ui.set_visible(jyawslide, false)
		ui.set_visible(ref.lowerbody, false)
		ui.set_visible(ref.fyawlimit, false)
		ui.set_visible(ref.freestanding_byaw, false)
		ui.set_visible(mshit.idealoption, true)
	else
		ui.set_visible(mshit.idealoption, false)
	end
	
	nigga = ui.get(mshit.faster_dt)
	ui.set_visible(mshit.adaptive_dt, nigga)
	
	turnedon = ui.get(mshit.desync)
	ui.set_visible(mshit.desync_where, turnedon)
	ui.set_visible(mshit.x_slider, turnedon)
	ui.set_visible(mshit.y_slider, turnedon)

	ui.set_visible(mshit.ideal, false)
	
	if ui.get(mshit.enabled) then
		ui.set(mshit.antibrute, true)
		ui.set(mshit.enable, true)			
		ui.set(mshit.legit_e_key, true)
		--ui.set(mshit.leg_breaker, true)

		if entity.is_alive(entity.get_local_player()) then
			if ui.get(holding_e) then -- freestanding modes on legit e are opposite than other modes
				if des9 == 1 then
					ui.set(mshit.mode, "Hide real")
				else
					ui.set(mshit.mode, "Hide fake")
				end
			elseif (bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1) then
				if (duck == true) then
					if des7 == 1 then
						ui.set(mshit.mode, "Hide fake")
					else
						ui.set(mshit.mode, "Hide real")
					end
				else
					if ui.get(slowwalk_hotkey) and move == true then
						if faggot == 0 then
							if des3 == 1 then
								ui.set(mshit.mode, "Hide fake")
							else
								ui.set(mshit.mode, "Hide real")
							end
						elseif faggot == 1 then
							if des6 == 1 then
								ui.set(mshit.mode, "Hide fake")
							else
								ui.set(mshit.mode, "Hide real")
							end
						elseif faggot == 2 then
							if des4 == 1 then
								ui.set(mshit.mode, "Hide fake")
							else
								ui.set(mshit.mode, "Hide real")
							end
						end
					else
						if move == true then
							if des1 == 1 then
								ui.set(mshit.mode, "Hide real")
							else
								ui.set(mshit.mode, "Hide fake")
							end
						else
							if des == 1 then
								ui.set(mshit.mode, "Hide fake")
							else
								ui.set(mshit.mode, "Hide real")
							end
						end
					end
				end
			else
				if check_double_tap and doubletap_charged or check_hide_shots or ui.get(ref.fake_lag) < 10 then
					if des2 == 1 then
						ui.set(mshit.mode, "Hide fake")	
					else
						ui.set(mshit.mode, "Hide real")
					end
				else
					--if randomidea2 > 8 then
						--if des8 == 1 then
							--ui.set(mshit.mode, "Hide real")
						--else
							--ui.set(mshit.mode, "Hide fake")
						--end
					--else
						if des8 == 1 then
							ui.set(mshit.mode, "Hide fake")
						else
							ui.set(mshit.mode, "Hide real")
						end
					--end
				end
			end
		end
	
	else
		ui.set(mshit.antibrute, false)
		ui.set(mshit.enable, false)
		ui.set(mshit.legit_e_key, false)
		--ui.set(mshit.leg_breaker, false)
	end
	
	if ui.get(mshit.indicator_enable) == "On" then
		ui.set_visible(mshit.extra_indicators, true)
		ui.set_visible(mshit.visual_arrows, true)
		ui.set_visible(mshit.visual_text, true)
		ui.set_visible(mshit.desync, true)
		ui.set_visible(mshit.desync_where, true)
		ui.set_visible(mshit.x_slider, true)
		ui.set_visible(mshit.y_slider, true)
	else
		ui.set_visible(mshit.extra_indicators, false)
		ui.set_visible(mshit.visual_arrows, false)
		ui.set_visible(mshit.visual_text, false)
		ui.set_visible(mshit.desync, false)
		ui.set_visible(mshit.desync_where, false)
		ui.set_visible(mshit.x_slider, false)
		ui.set_visible(mshit.y_slider, false)
	end
	
	if ui.get(mshit.indicator_enable) == "On" and ui.get(mshit.visual_arrows) then
		ui.set_visible(mshit.color, true)
		ui.set_visible(mshit.label, true)
	else
		ui.set_visible(mshit.color, false)
		ui.set_visible(mshit.label, false)
	end
	
	ui.set_visible(mshit.enable, false)
	ui.set_visible(mshit.idealoption, false)
	ui.set_visible(mshit.antibrute, false)
	ui.set_visible(mshit.mode, false)
	ui.set_visible(mshit.legit_e_key, false)
	ui.set_visible(mshit.leg_breaker, true)
end

local function handleGUI2()
	if ui.get(mshit.indicator_enable) == "On" and ui.get(mshit.visual_text) then
		ui.set_visible(mshit.indicators, true)
		ui.set_visible(mshit.color2, true)
		ui.set_visible(mshit.label2, true)
		if includes(ui.get(mshit.indicators), "AA States") then
			ui.set_visible(mshit.color3, true)
			ui.set_visible(mshit.label3, true)
			ui.set_visible(mshit.color4, true)
			ui.set_visible(mshit.label4, true)
			ui.set_visible(mshit.color5, true)
			ui.set_visible(mshit.label5, true)
			ui.set_visible(mshit.color6, true)
			ui.set_visible(mshit.label6, true)
			ui.set_visible(mshit.color7, true)
			ui.set_visible(mshit.label7, true)
			ui.set_visible(mshit.color15, true)
			ui.set_visible(mshit.label15, true)
		else
			ui.set_visible(mshit.color3, false)
			ui.set_visible(mshit.label3, false)
			ui.set_visible(mshit.color4, false)
			ui.set_visible(mshit.label4, false)
			ui.set_visible(mshit.color5, false)
			ui.set_visible(mshit.label5, false)
			ui.set_visible(mshit.color6, false)
			ui.set_visible(mshit.label6, false)
			ui.set_visible(mshit.color7, false)
			ui.set_visible(mshit.label7, false)
			ui.set_visible(mshit.color15, false)
			ui.set_visible(mshit.label15, false)
		end
		if includes(ui.get(mshit.indicators), "Desync Bar") then
			ui.set_visible(mshit.label16, true)
			ui.set_visible(mshit.color16, true)
			ui.set_visible(mshit.label17, true)
			ui.set_visible(mshit.color17, true)			
		else
			ui.set_visible(mshit.label16, false)
			ui.set_visible(mshit.color16, false)
			ui.set_visible(mshit.label17, false)
			ui.set_visible(mshit.color17, false)	
		end
		if includes(ui.get(mshit.indicators), "Doubletap") then
			ui.set_visible(mshit.color9, true)
			ui.set_visible(mshit.label9, true)
			ui.set_visible(mshit.color10, true)
			ui.set_visible(mshit.label10, true)
		else
			ui.set_visible(mshit.color9, false)
			ui.set_visible(mshit.label9, false)
			ui.set_visible(mshit.color10, false)
			ui.set_visible(mshit.label10, false)
		end
		if includes(ui.get(mshit.indicators), "Fakeduck") then
			ui.set_visible(mshit.color11, true)
			ui.set_visible(mshit.label11, true)
		else
			ui.set_visible(mshit.color11, false)
			ui.set_visible(mshit.label11, false)
		end
		if includes(ui.get(mshit.indicators), "Safepoint") then
			ui.set_visible(mshit.color12, true)
			ui.set_visible(mshit.label12, true)
		else
			ui.set_visible(mshit.color12, false)
			ui.set_visible(mshit.label12, false)
		end
		if includes(ui.get(mshit.indicators), "Hideshots") then
			ui.set_visible(mshit.color13, true)
			ui.set_visible(mshit.label13, true)
		else
			ui.set_visible(mshit.color13, false)
			ui.set_visible(mshit.label13, false)
		end
		if includes(ui.get(mshit.indicators), "Force body aim") then
			ui.set_visible(mshit.color14, true)
			ui.set_visible(mshit.label14, true)
		else
			ui.set_visible(mshit.color14, false)
			ui.set_visible(mshit.label14, false)
		end
		if includes(ui.get(mshit.indicators), "Fakelag") then
			ui.set_visible(mshit.color8, true)
			ui.set_visible(mshit.label8, true)
		else
			ui.set_visible(mshit.color8, false)
			ui.set_visible(mshit.label8, false)
		end
	else
		ui.set_visible(mshit.indicators, false)
		ui.set_visible(mshit.color2, false)
		ui.set_visible(mshit.label2, false)
		ui.set_visible(mshit.color3, false)
		ui.set_visible(mshit.label3, false)
		ui.set_visible(mshit.color4, false)
		ui.set_visible(mshit.label4, false)
		ui.set_visible(mshit.color5, false)
		ui.set_visible(mshit.label5, false)
		ui.set_visible(mshit.color6, false)
		ui.set_visible(mshit.label6, false)
		ui.set_visible(mshit.color7, false)
		ui.set_visible(mshit.label7, false)
		ui.set_visible(mshit.color8, false)
		ui.set_visible(mshit.label8, false)
		ui.set_visible(mshit.color9, false)
		ui.set_visible(mshit.label9, false)
		ui.set_visible(mshit.color10, false)
		ui.set_visible(mshit.label10, false)
		ui.set_visible(mshit.color11, false)
		ui.set_visible(mshit.label11, false)
		ui.set_visible(mshit.color12, false)
		ui.set_visible(mshit.label12, false)
		ui.set_visible(mshit.color13, false)
		ui.set_visible(mshit.label13, false)
		ui.set_visible(mshit.color14, false)
		ui.set_visible(mshit.label14, false)
		ui.set_visible(mshit.color15, false)
		ui.set_visible(mshit.label15, false)
		ui.set_visible(mshit.color16, false)
		ui.set_visible(mshit.label16, false)
		ui.set_visible(mshit.color17, false)
		ui.set_visible(mshit.label17, false)
	end
	
	if ui.get(mshit.enabled) then
		ui.set_visible(mshit.option, true)
		ui.set_visible(mshit.back, true)
		ui.set_visible(mshit.left, true)
		ui.set_visible(mshit.right, true)
		ui.set_visible(mshit.forward, true)
		ui.set_visible(mshit.indicator_enable, true)
	else
		ui.set_visible(mshit.option, false)
		ui.set_visible(mshit.back, false)
		ui.set_visible(mshit.left, false)
		ui.set_visible(mshit.right, false)
		ui.set_visible(mshit.forward, false)
		ui.set_visible(mshit.indicator_enable, false)
		ui.set_visible(mshit.color, false)
		ui.set_visible(mshit.label, false)
		ui.set_visible(mshit.color2, false)
		ui.set_visible(mshit.label2, false)
		ui.set_visible(mshit.color3, false)
		ui.set_visible(mshit.label3, false)
		ui.set_visible(mshit.color4, false)
		ui.set_visible(mshit.label4, false)
		ui.set_visible(mshit.color5, false)
		ui.set_visible(mshit.label5, false)
		ui.set_visible(mshit.color6, false)
		ui.set_visible(mshit.label6, false)
		ui.set_visible(mshit.color7, false)
		ui.set_visible(mshit.label7, false)
		ui.set_visible(mshit.color8, false)
		ui.set_visible(mshit.label8, false)
		ui.set_visible(mshit.color9, false)
		ui.set_visible(mshit.label9, false)
		ui.set_visible(mshit.color10, false)
		ui.set_visible(mshit.label10, false)
		ui.set_visible(mshit.color11, false)
		ui.set_visible(mshit.label11, false)
		ui.set_visible(mshit.color12, false)
		ui.set_visible(mshit.label12, false)
		ui.set_visible(mshit.color13, false)
		ui.set_visible(mshit.label13, false)
		ui.set_visible(mshit.color14, false)
		ui.set_visible(mshit.label14, false)
		ui.set_visible(mshit.color15, false)
		ui.set_visible(mshit.label15, false)
		ui.set_visible(mshit.color16, false)
		ui.set_visible(mshit.label16, false)
		ui.set_visible(mshit.color17, false)
		ui.set_visible(mshit.label17, false)
	end
end

--==--==--=-{ GUI Handling } --==--==--=-

--==--==--=-{ Better Body Yaw } --==--==--=-

local data = {
    side = 1,
    last_side = 0,

    last_hit = 0,
}

local on_setup_command = function(cmd)
    -- Get local player
    local me = entity.get_local_player()

    -- If our local player is invalid or if we're dead, return
    if not me or entity.get_prop(me, "m_lifeState") ~= 0 then
        return
    end
    
    -- Get the server's current time
    local now = globals.curtime()

    -- Get what mode our freestanding is using
    local _mode = ui.get(mshit.mode)

    -- Get some properties
    local x, y, z = client.eye_position()
    local _, yaw = client.camera_angles()

    -- Create a table where the trace data will be stored
    local trace_data = {left = 0, right = 0}

    for i = yaw - 90, yaw + 90, 30 do
        -- I don't know an alternative for continue so..
        -- Don't do any calculations if the current angle is equal to our yaw
        -- This means that this is the center point and thus it doesn't contribute to the calculations
        if i ~= yaw then
            -- Convert our yaw to radians in order to do further calculations
            local rad = math.rad(i)

            -- Calculate our destination point
            local px, py, pz = x + 256 * math.cos(rad), y + 256 * math.sin(rad), z

            -- Trace a line from our eye position to the previously calculated point
            local fraction = client.trace_line(me, x, y, z, px, py, pz)
            local side = i < yaw and "left" or "right"

            -- Add the trace's fraction to the trace table
            trace_data[side] = trace_data[side] + fraction
        end
    end

    -- Get which side has the lowest fraction amount, which means that it is closer to us.
    data.side = trace_data.left < trace_data.right and 1 or 2

    -- If our side didn't change from the last tick then there's no need to update our anti-aim
    if data.side == data.last_side then
        return
    end

    -- If it did change, then update our cached side to do further checks
    data.last_side = data.side

    -- Get the fake angle's maximum length and calculate what our next body offset should be
    lby = _mode == "Hide fake" and (data.side == 1 and byawamtnormal or -byawamtnormal) or (data.side == 1 and -byawamtnormal or byawamtnormal)
	lby1 = _mode == "Hide fake" and (data.side == 1 and byawamtopposite or -byawamtopposite) or (data.side == 1 and -byawamtopposite or byawamtopposite)
	lby2 = _mode == "Hide fake" and (data.side == 1 and byawamtjitter or -byawamtjitter) or (data.side == 1 and -byawamtjitter or byawamtjitter)
	lby3 = _mode == "Hide fake" and (data.side == 1 and lowdelta or -lowdelta) or (data.side == 1 and -lowdelta or lowdelta)
	lby4 = _mode == "Hide fake" and (data.side == 1 and lowdeltabrute or -lowdeltabrute) or (data.side == 1 and -lowdeltabrute or lowdeltabrute)
	lby5 = _mode == "Hide fake" and (data.side == 1 and eholdaa or -eholdaa) or (data.side == 1 and -eholdaa or eholdaa)
	lby6 = _mode == "Hide fake" and (data.side == 1 and lowdeltabrute2 or -lowdeltabrute2) or (data.side == 1 and -lowdeltabrute2 or lowdeltabrute2)
	lby7 = _mode == "Hide fake" and (data.side == 1 and crouched or -crouched) or (data.side == 1 and -crouched or crouched)
	lby8 = _mode == "Hide fake" and (data.side == 1 and byawamtjitter2 or -byawamtjitter2) or (data.side == 1 and -byawamtjitter2 or byawamtjitter2)
	lby9 = _mode == "Hide fake" and (data.side == 1 and eholdaa2 or -eholdaa2) or (data.side == 1 and -eholdaa2 or eholdaa2)
end

local handle_menu_visibility = function(self)
    -- Get if the script is enabled and determine if we should set or unset the callbacks
    enabled = ui.get(self)
    callback = enabled and client.set_event_callback or client.unset_event_callback

    -- Update the other elements' visibility
    ui.set_visible(mshit.mode, mshit.enabled)

    -- Register/Unregister our callbacks
    callback("setup_command", on_setup_command)
end

-- Execute this whenever the script is first enabled
handle_menu_visibility(mshit.enable)
---endregion

---region callbacks
-- Register the UI callbacks
ui.set_callback(mshit.enable, handle_menu_visibility)
ui.set_callback(mshit.mode, function(self)
    -- Set the last side to '0' so the anti-aim updates
    data.last_side = 0
end)
---endregion

--==--==--=-{ Better Body Yaw } --==--==--=-

--==--==--=-{ Anti-Log } --==--==--=-

local function faggotAdd()
	if ass == 1 then
		faggot = 2
	else
		faggot = 1
	end
	
	ass = faggot
end

function antilog(e)
get_local_player = entity.get_local_player
userid_to_entindex = client.userid_to_entindex

    victim_userid, attacker_userid = e.userid, e.attacker
    victim_entindex   = userid_to_entindex(victim_userid)
    if victim_entindex == get_local_player() then
		faggotAdd()
		client.color_log(0, 0, 255, faggot)
		flip2()
		
		if cracker >= 1 then
			cracker_reset()
		else
			cracker = cracker + 1
		end
    end
end
client.set_event_callback('player_death', antilog)

client.set_event_callback("player_connect_full", function ()
	reset()
end)

client.set_event_callback("round_start", function()
	des = 1
	des1 = 1
	des7 = 1
	des9 = 1
end)
--==--==--=-{ Anti-Log } --==--==--=-

client.set_event_callback("net_update_end", function()
if not entity.is_alive(entity.get_local_player()) then return end
if not ui.get(mshit.enable) then return end
if not ui.get(mshit.leg_breaker) then return end
	entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0) --legs
	--entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 6) --air
end)

--locals for manual aa and indicators
local leftReady = false
local rightReady = false
local forwardReady = false
local mode = "back"
local screen = {client.screen_size()}
local center = {screen[1]/2, screen[2]/2}

--==--==--=-{ Manual and Normal AA } --==--==--=-

local function antiAim()
    if not ui.get(mshit.enabled) then return end
	
	--[[
	if ui.get(ref.fake_variance) < 25 then
		ui.set(ref.fake_variance, ui.get(ref.fake_variance) + 1)
	else
		ui.set(ref.fake_variance, 15)
	end--]]
	
	velocity = { entity.get_prop(entity.get_local_player(), "m_vecVelocity") }
    speed = math.sqrt(velocity[1]*velocity[1]+velocity[2]*velocity[2])
	duck_ammount = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
	local move
	local duck
	
		randomidea = randomidea + 1
		
		randomidea2 = randomidea2 + 1
		
		if randomidea > 8 then
			randomidea_reset()
		end
		
		if randomidea2 > 32 then
			randomidea2_reset()
		end
		
		if duck_ammount >= 0.7 or ui.get(ref.fakeduck) then
			duck = true
		else
			duck = false
		end
		
		if ui.get(ref.fakeduck) then
			ui.set(ref.edge_yaw, true)
		else
			ui.set(ref.edge_yaw, false)
		end
	
		if speed < 15 then else	
			if ui.get(mshit.leg_breaker) then
				if (bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1) then
					if randomidea <= 4 then
						ui.set(ref.legmovement, "never slide")
					else
						ui.set(ref.legmovement, "always slide")
					end
				else 
					ui.set(ref.legmovement, "off")
				end
			end
		end
		
	if ui.get(freestanding_key) then
		if ui.get(holding_e) then
			ui.set(freestanding, "-")
		else
			ui.set(freestanding, "Default")
		end
	end
	
    if ui.get(mshit.option) == "Manual AA" then
		ui.set(yaw2, "180")
        if ui.get(mshit.back) then
            mode = "back"
        elseif ui.get(mshit.left) and leftReady then
            if mode == "left" then
                mode = "back"
            else
                mode = "left"
            end
            leftReady = false
        elseif ui.get(mshit.right) and rightReady then
            if mode == "right" then
                mode = "back"
            else
                mode = "right"
            end
            rightReady = false
		elseif ui.get(mshit.forward) and forwardReady then
            if mode == "forward" then
                mode = "back"
            else
                mode = "forward"
            end
            forwardReady = false
        end
    
        if ui.get(mshit.left) == false then
            leftReady = true
         end
    
        if ui.get(mshit.right) == false then
            rightReady = true
        end
		if ui.get(mshit.forward) == false then
            forwardReady = true
        end
        if mode == "back" then
		ui.set(ref.yawbase, "At targets")
		if ui.get(mshit.idealoption) == "Normal" then
            ui.set(yaw, 0) --9
			ui.set(jyaw, "Random") --Random
			ui.set(jyawslide, 0) --1
			if ui.get(mshit.enable) then
				ui.set(bodyyaw2, lby)
				ui.set(ref.freestanding_byaw, false)
			else
				ui.set(bodyyaw2, byawamtnormal)
				ui.set(ref.freestanding_byaw, true)
			end
            ui.set(ref.fyawlimit, 32) --32
            ui.set(ref.lowerbody, "Eye yaw")
            ui.set(bodyyaw, "Static") --Jitter
		end
		if ui.get(mshit.idealoption) == "EHold" then
			ui.set(ref.pitch, "Off")
            ui.set(yaw, 180) --9
            ui.set(jyaw, "Off") --Random
            ui.set(jyawslide, 0) --1
            if ui.get(mshit.enable) then
				ui.set(bodyyaw2, lby9)
				ui.set(ref.freestanding_byaw, true)
            else
				ui.set(bodyyaw2, eholdaa2)
				ui.set(ref.freestanding_byaw, true)
            end
            ui.set(ref.fyawlimit, 51) --30
            ui.set(ref.lowerbody, "Eye yaw") --Opposite
            ui.set(bodyyaw, "Opposite") --Jitter
		end
		if ui.get(mshit.idealoption) == "Crouched" then
            ui.set(yaw, 0) --9
			ui.set(jyaw, "Center") --Random
			ui.set(jyawslide, 0) --1
			if ui.get(mshit.enable) then
                ui.set(bodyyaw2, lby7)
				ui.set(ref.freestanding_byaw, false)
			else
				ui.set(bodyyaw2, crouched)
				ui.set(ref.freestanding_byaw, true)
			end
            ui.set(ref.fyawlimit, 37) --30
            ui.set(ref.lowerbody, "Eye yaw") --Opposite
            ui.set(bodyyaw, "Jitter") --Jitter
        end
		if ui.get(mshit.idealoption) == "Low Delta" then
			if faggot == 0 then
                ui.set(yaw, 5)
				ui.set(jyaw, "Random")
				ui.set(jyawslide, 1)
				if ui.get(mshit.enable) then
					ui.set(bodyyaw2, lby3)
					ui.set(ref.freestanding_byaw, false)
				else
					ui.set(bodyyaw2, lowdelta)
					ui.set(ref.freestanding_byaw, true)
				end
                ui.set(ref.fyawlimit, 15) --32
                ui.set(ref.lowerbody, "Eye yaw")
                ui.set(bodyyaw, "Jitter")
			elseif faggot == 2 then
				ui.set(yaw, 0)
				ui.set(jyaw, "Random")
				ui.set(jyawslide, 3)
				if ui.get(mshit.enable) then
					ui.set(bodyyaw2, lby4)
					ui.set(ref.freestanding_byaw, false)
				else
					ui.set(bodyyaw2, lowdeltabrute)
					ui.set(ref.freestanding_byaw, true)
				end
                ui.set(ref.fyawlimit, math.random(51, 54))
                ui.set(ref.lowerbody, "Eye yaw")
                ui.set(bodyyaw, "Static")
			elseif faggot == 1 then
                ui.set(yaw, 0)
                ui.set(jyaw, "Off")
                ui.set(jyawslide, 0)
                if ui.get(mshit.enable) then
					ui.set(bodyyaw2, lby6)
					ui.set(ref.freestanding_byaw, false)
                else
					ui.set(bodyyaw2, lowdeltabrute2)
					ui.set(ref.freestanding_byaw, true)
                end
                ui.set(ref.fyawlimit, 40) --15
                ui.set(ref.lowerbody, "Eye yaw")
                ui.set(bodyyaw, "Static")
            end
        end
        if ui.get(mshit.idealoption) == "Opposite" then
            ui.set(yaw, 0)
			ui.set(jyaw, "Off")
			ui.set(jyawslide, 12) --12
			if ui.get(mshit.enable) then
				ui.set(bodyyaw2, lby1)
				ui.set(ref.freestanding_byaw, false)
			else
				ui.set(bodyyaw2, byawamtopposite)
				ui.set(ref.freestanding_byaw, true)
			end
            ui.set(ref.fyawlimit, 59) --32
            ui.set(ref.lowerbody, "Eye yaw")
			ui.set(bodyyaw, "Jitter")
        end
		if ui.get(mshit.idealoption) == "Jitter" then
			if check_double_tap and doubletap_charged or check_hide_shots or ui.get(ref.fake_lag) < 10 then
				ui.set(yaw, 5)
				ui.set(jyaw, "Random")
				ui.set(jyawslide, -12)
				if ui.get(mshit.enable) then
					ui.set(bodyyaw2, lby2)			
					ui.set(ref.freestanding_byaw, false)
				else
					ui.set(bodyyaw2, byawamtjitter)	
					ui.set(ref.freestanding_byaw, true)
				end
				ui.set(bodyyaw, "Static")
				ui.set(ref.lowerbody, "Sway")
				ui.set(ref.fyawlimit, 60)
			else
				ui.set(yaw, 0) --3
				ui.set(jyaw, "Off") --Offset
				ui.set(jyawslide, 15) --5
				if ui.get(mshit.enable) then
					ui.set(bodyyaw2, math.random(-90, 90))			
					ui.set(ref.freestanding_byaw, false)
				else
					ui.set(bodyyaw2, math.random(-90, 90))
					ui.set(ref.freestanding_byaw, true)
				end				
				ui.set(bodyyaw, "Jitter")
				ui.set(ref.lowerbody, "Eye Yaw")
				ui.set(ref.fyawlimit, math.random(20, 60)) --26
			end
        end
        elseif mode == "left" then
			ui.set(ref.yawbase, "Local view")
			if ui.get(mshit.idealoption) == "EHold" then
				ui.set(yaw, 180)
			else
				ui.set(yaw, -90)
			end
			ui.set(jyaw, "Off")
			ui.set(bodyyaw2, 180)	
			ui.set(ref.freestanding_byaw, true)
			ui.set(bodyyaw, "Static")
			ui.set(ref.lowerbody, "Eye yaw")
			ui.set(ref.fyawlimit, 60)
        elseif mode == "right" then
			ui.set(ref.yawbase, "Local view")
            if ui.get(mshit.idealoption) == "EHold" then
				ui.set(yaw, 180)
			else
				ui.set(yaw, 90)
			end
			ui.set(jyaw, "Off")
			ui.set(bodyyaw2, 180)	
			ui.set(ref.freestanding_byaw, true)
			ui.set(bodyyaw, "Static")
			ui.set(ref.lowerbody, "Eye yaw")
			ui.set(ref.fyawlimit, 60)
		elseif mode == "forward" then
			ui.set(ref.yawbase, "At targets")
            ui.set(yaw, 180)
			ui.set(jyaw, "Off")
			ui.set(bodyyaw2, 180)	
			ui.set(ref.freestanding_byaw, true)
			ui.set(bodyyaw, "Static")
			ui.set(ref.lowerbody, "Eye yaw")
			ui.set(ref.fyawlimit, 60)
        end
    end
end

--==--==--=-{ Manual and Normal AA } --==--==--=-

--==--==--=-{ Indicators } --==--==--=-

local function paint()
    if not ui.get(mshit.enabled) then return end
	
	if ui.get(mshit.indicator_enable) == "Off" then
		return
	end
    
    lp = entity.get_local_player()
	h_index = 0

    if lp == nil or entity.is_alive(lp) == false then
        return
    end

    color_g = {ui.get(mshit.color)}
	color_g2 = {ui.get(mshit.color2)}
	color_g3 = {ui.get(mshit.color3)}
	color_g4 = {ui.get(mshit.color4)}
	color_g5 = {ui.get(mshit.color5)}
	color_g6 = {ui.get(mshit.color6)}
	color_g7 = {ui.get(mshit.color7)}
	color_g8 = {ui.get(mshit.color8)}
	color_g9 = {ui.get(mshit.color9)}
	color_g10 = {ui.get(mshit.color10)}
	color_g11 = {ui.get(mshit.color11)}
	color_g12 = {ui.get(mshit.color12)}
	color_g13 = {ui.get(mshit.color13)}
	color_g14 = {ui.get(mshit.color14)}
	color_g15 = {ui.get(mshit.color15)}
	color_g16 = {ui.get(mshit.color16)}
	color_g17 = {ui.get(mshit.color17)}
	
	if ui.get(mshit.visual_arrows) then
		if ui.get(mshit.option) == "Manual AA" then
			--renderer.text(center[1], center[2] + 43, 45, 45, 45, 75, "cb+", 0, "⮟" )
			renderer.text(center[1] - 43, center[2] - 3, 45, 45, 45, 75, "c+", 0, "⮜" )
			renderer.text(center[1] + 43, center[2] - 3, 45, 45, 45, 75, "c+", 0, "⮞" )

			--if mode == "back" then
				--renderer.text(center[1], center[2] + 43, color_g[1], color_g[2], color_g[3], color_g[4], "cb+", 0, "⮟" )
			if mode == "left" then
				renderer.text(center[1] - 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "c+", 0, "⮜" )
			elseif mode == "right" then
				renderer.text(center[1] + 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "c+", 0, "⮞" )
			end
		end
	end

	if ui.get(mshit.visual_text) then	
		renderer.text(center[1], center[2] + 17,  color_g2[1], color_g2[2], color_g2[3], color_g2[4], "-c", 0, "ARTEMIS  AA" )
		
		if includes(ui.get(mshit.indicators), "AA States") then
			if ui.get(mshit.idealoption) == "Normal" then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "-c", 0, "NORMAL" )
			elseif ui.get(mshit.idealoption) == "Low Delta" then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g5[1], color_g5[2], color_g5[3], color_g5[4], "-c", 0, "LOW DELTA" )
			elseif ui.get(mshit.idealoption) == "Opposite" then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g4[1], color_g4[2], color_g4[3], color_g4[4], "-c", 0, "OPPOSITE" )
			elseif ui.get(mshit.idealoption) == "Jitter" then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g6[1], color_g6[2], color_g6[3], color_g6[4], "-c", 0, "JITTER" )
			elseif ui.get(mshit.idealoption) == "EHold" then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g7[1], color_g7[2], color_g7[3], color_g7[4], "-c", 0, "LEGIT" )
			elseif ui.get(mshit.idealoption) == "Crouched" then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g15[1], color_g15[2], color_g15[3], color_g15[4], "-c", 0, "CROUCHED" )
			end
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Doubletap") and ui.get(double_tap_key) and ui.get(double_tap) then
			if doubletap_charged() then
				renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g10[1], color_g10[2], color_g10[3], color_g10[4], "c-", 0, "DOUBLETAP")
			else
				renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g9[1], color_g9[2], color_g9[3], color_g9[4], "c-", 0, "DOUBLETAP")
			end
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Fakeduck") and ui.get(ref.fakeduck) then
			local duck_amt = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g11[1], color_g11[2], color_g11[3], color_g11[4] - duck_amt * 155, "c-", 0, "DUCK")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Safepoint") and ui.get(ref.safe_point) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g12[1], color_g12[2], color_g12[3], color_g12[4], "c-", 0, "SAFE")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Hideshots") and ui.get(ref.onShot[1]) and ui.get(ref.onShot[2]) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g13[1], color_g13[2], color_g13[3], color_g13[4], "c-", 0, "HIDE")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Force body aim") and ui.get(ref.tomi) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g14[1], color_g14[2], color_g14[3], color_g14[4], "c-", 0, "BAIM")
			h_index = h_index + 1
		end
		
		if includes(ui.get(mshit.indicators), "Fakelag") then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g8[1], color_g8[2], color_g8[3], color_g8[4], "-c", 0, string.format('%i-%i-%i-%i-%i' ,toDraw4,toDraw3,toDraw2,toDraw1,toDraw0) )
			--renderer.text(center[1], center[2] + 37, color_g8[1], color_g8[2], color_g8[3], color_g8[4], "-c", 0, string.format('%i-%i-%i-%i-%i %d' ,toDraw4,toDraw3,toDraw2,toDraw1,toDraw0, toDraw5) )
			h_index = h_index + 1
		end
		
		if includes(ui.get(mshit.indicators), "Desync Bar") then
			local_player = entity.get_local_player()
			fyawlimit2 = math.max(-40, math.min(40, round((entity.get_prop(local_player, "m_flPoseParameter", 11) or 0)*120-60+0.5, 1)))
			
			renderer.text(center[1] + fyawlimit2, center[2] + 25 + (h_index * 8), color_g[1], color_g[2], color_g[3], color_g[4], "cb", 0, "|" )
			
			if ui.get(bodyyaw2) > 0 then
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), -fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
			else
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
				renderer.gradient(center[1] + 1, center[2] + 25 + (h_index * 8), -fyawlimit2, 2, color_g16[1], color_g16[2], color_g16[3], color_g16[4], color_g17[1], color_g17[2], color_g17[3], color_g17[4], true)
			end
			h_index = h_index + 1
		end
	end
	
	if ui.get(mshit.extra_indicators) then
		if ui.get(ref.onShot[1]) and ui.get(ref.onShot[2]) then
			cy = renderer.indicator(141, 232, 49, 255, "HS")+ui.get(mshit.y_slider)
		end
		
		if ui.get(ref.tomi) then
			cy = renderer.indicator(235, 146, 52, 255, "FB")+ui.get(mshit.y_slider)
		end
		
		if ui.get(ref.safe_point) then
			cy = renderer.indicator(50, 123, 168, 255, "SP")+ui.get(mshit.y_slider)
		end
	end
end
client.set_event_callback("paint", paint)

--==--==--=-{ Indicators } --==--==--=-

--==--==--=-{ Desync Indicator } --==--==--=-
local angle = 0
client.set_event_callback("setup_command", function(c)
	if c.chokedcommands == 0 then
		if c.in_use == 1 then
			angle = 0
		else
			angle = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))
		end
	end
end)

client.set_event_callback("paint", function()
	if ui.get(mshit.enabled) == false then
        return
    end

	if ui.get(mshit.indicator_enable) == "Off" then
		return
	end

	if ui.get(mshit.desync) and ui.get(yaw) ~= "Off" and entity.is_alive(entity.get_local_player()) then
		color = { 255-(angle*2.29824561404), angle*3.42105263158, angle*0.22807017543 }
		y = renderer.indicator(color[1], color[2], color[3], 255, "FAKE")+ui.get(mshit.y_slider)
		x = ui.get(mshit.x_slider)
		if (ui.get(mshit.desync_where) == "At Crosshair") then
		renderer.circle_outline(center[1], center[2], 0, 0, 0, 155, 4, 0, 1, 2)
		renderer.circle_outline(center[1], center[2], color[1], color[2], color[3], 255, 4, 0, angle*0.01754385964, 2)
		end
		if (ui.get(mshit.desync_where) == "At Indicators") then
		renderer.circle_outline(x, y, 0, 0, 0, 155, 10, 0, 1, 5)
		renderer.circle_outline(x, y, color[1], color[2], color[3], 255, 10, 0, angle*0.01754385964, 5)
		end
	end
end)
-- Anti-Knife

local event_handler_functions = {
    [true]  = client.set_event_callback,
    [false] = client.unset_event_callback,
}

local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

local function get_entities(enemy_only, alive_only)
	local enemy_only = enemy_only ~= nil and enemy_only or false
    local alive_only = alive_only ~= nil and alive_only or true
    
    local result = {}

    local me = entity.get_local_player()
    local player_resource = entity.get_player_resource()
    
	for player = 1, globals.maxplayers() do
		if entity.get_prop(player_resource, 'm_bConnected', player) == 1 then
            local is_enemy, is_alive = true, true
            
			if enemy_only and not entity.is_enemy(player) then is_enemy = false end
			if is_enemy then
				if alive_only and entity.get_prop(player_resource, 'm_bAlive', player) ~= 1 then is_alive = false end
				if is_alive then table.insert(result, player) end
			end
		end
	end

	return result
end

client.set_event_callback('run_command', function()
    local lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
	velocity = { entity.get_prop(entity.get_local_player(), "m_vecVelocity") }
    speed = math.sqrt(velocity[1]*velocity[1]+velocity[2]*velocity[2])
	duck_ammount = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
	local move
	local duck
		
	if duck_ammount >= 0.7 or ui.get(ref.fakeduck) then
		duck = true
	else
		duck = false
	end
	
	if speed < 35 then 
		--speed = 0 
		move = false
	else
		move = true
	end
	
    local enemies = get_entities(true, true)
    for i=1,#enemies do
        local player = enemies[i]
        local x, y, z = entity.get_prop(player, "m_vecOrigin")
        local distance = get_distance(lx, ly, lz, x, y, z)
        local weapon = entity.get_player_weapon(player)
		if not entity.is_alive(player) then 
			ui.set(mshit.idealoption, "EHold")
		else
			if ui.get(holding_e) or (entity.get_classname(weapon) == "CKnife" and distance <= 200) then
				ui.set(mshit.idealoption, "EHold")
			elseif (bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1) then
				if (duck == true) then
					ui.set(mshit.idealoption, "Crouched")
				else
					if ui.get(slowwalk_hotkey) and (move == true) then
						ui.set(mshit.idealoption, "Low Delta")
					else 
						if (move == true) then
							ui.set(mshit.idealoption, "Opposite")
						else
							ui.set(mshit.idealoption, "Normal")
						end
					end
				end
			else 
				ui.set(mshit.idealoption, "Jitter")
			end
		 end
    end
end)
--==--==--=-{ Desync Indicator } --==--==--=-

local label1 = ui.new_label("AA", "Anti-aimbot angles", "--------------------------------------------------------------")

--==--==--=-{ Shut Down Function } --==--==--=-

client.set_event_callback("shutdown", function()
	ui.set(ref.tickstoprocess, 16)
    cvar.cl_clock_correction:set_int(1)
	
	ui.set(ref.pitch, "Default")
	ui.set(yaw, 0) 
	ui.set(jyaw, "Random")
	ui.set(jyawslide, 0)
    ui.set(bodyyaw, "Static")
	ui.set(bodyyaw2, 0)
	ui.set(ref.freestanding_byaw, false)
	ui.set(ref.lowerbody, "Opposite")
	ui.set(ref.fyawlimit, 0)
	
	ui.set_visible(ref.aa_enable, true)
	ui.set_visible(ref.pitch, true)
	ui.set_visible(ref.yawbase, true)
	ui.set_visible(yaw, true)
	ui.set_visible(yaw2, true)
	ui.set_visible(bodyyaw, true)
	ui.set_visible(bodyyaw2, true)
	ui.set_visible(jyaw, true)
	ui.set_visible(jyawslide, true)
	ui.set_visible(ref.lowerbody, true)
	ui.set_visible(ref.fyawlimit, true)
	ui.set_visible(ref.freestanding_byaw, true)
end)

--[[client.color_log(255, 255, 255, "|--------------------------------------------------------|")
client.color_log(21, 235, 220,  "                Thank you " .. name .. "!                 ")
client.color_log(215, 115, 222, "               for trying out TibzzyTools.                ")
client.color_log(230, 94, 153,  "                 Hope to see you soon!                    ")   
client.color_log(255, 255, 255, "|--------------------------------------------------------|") --]]

--==--==--=-{ Shut Down Function } --==--==--=-

client.set_event_callback("round_start", function()
    dt_latency = client.latency() * 1000
end)
client.set_event_callback("aim_fire", aimFire)
client.set_event_callback("run_command", antiAim) 
client.set_event_callback("paint_ui", handleGUI)
client.set_event_callback("paint_ui", handleGUI2)