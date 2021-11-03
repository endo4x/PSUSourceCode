--[[
	id: s9aBwRjb86k4VVUIQkzda
	name: weapon cfgs
	description: wep cfg
	time1: 2021-07-09 20:25:31.468776+00
	time2: 2021-07-09 20:25:31.468777+00
	uploader: KuFGslhKMQ5K3wc8VwQhYL3HSWjjg1IvuumBras5
	uploadersession: dwCs4j725gfbBPX4Eeu0IILKhwVSoC
	flag: f
--]]

-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_delay_call, client_error_log, client_set_event_callback, entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_is_alive, globals_realtime, pairs, string_format, error, rawget, next, ipairs, renderer_indicator, string_char, table_concat, table_insert, tostring, select, tonumber, setmetatable, ui_get, ui_is_menu_open, ui_new_checkbox, ui_new_combobox, ui_new_hotkey, ui_new_slider, ui_new_string, ui_reference, ui_set, ui_set_callback, ui_set_visible, unpack, pcall = client.delay_call, client.error_log, client.set_event_callback, entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.is_alive, globals.realtime, pairs, string.format, error, rawget, next, ipairs, renderer.indicator, string.char, table.concat, table.insert, tostring, select, tonumber, setmetatable, ui.get, ui.is_menu_open, ui.new_checkbox, ui.new_combobox, ui.new_hotkey, ui.new_slider, ui.new_string, ui.reference, ui.set, ui.set_callback, ui.set_visible, unpack, pcall

local json = (function() local a={_version="0.1.2"}local b;local c={["\\"]="\\\\",["\""]="\\\"",["\b"]="\\b",["\f"]="\\f",["\n"]="\\n",["\r"]="\\r",["\t"]="\\t"}local d={["\\/"]="/"}for e,f in pairs(c)do d[f]=e end;local function g(h)return c[h]or string_format("\\u%04x",h:byte())end;local function i(j)return"null"end;local function k(j,l)local m={}l=l or{}if l[j]then error("circular reference")end;l[j]=true;if rawget(j,1)~=nil or next(j)==nil then local n=0;for e in pairs(j)do if type(e)~="number"then error("invalid table: mixed or invalid key types")end;n=n+1 end;if n~=#j then error("invalid table: sparse array")end;for o,f in ipairs(j)do table_insert(m,b(f,l))end;l[j]=nil;return"["..table_concat(m,",").."]"else for e,f in pairs(j)do if type(e)~="string"then error("invalid table: mixed or invalid key types")end;table_insert(m,b(e,l)..":"..b(f,l))end;l[j]=nil;return"{"..table_concat(m,",").."}"end end;local function p(j)return'"'..j:gsub('[%z\1-\31\\"]',g)..'"'end;local function q(j)if j~=j or j<=-math.huge or j>=math.huge then error("unexpected number value '"..tostring(j).."'")end;return string_format("%.14g",j)end;local r={["nil"]=i,["table"]=k,["string"]=p,["number"]=q,["boolean"]=tostring}b=function(j,l)local s=type(j)local t=r[s]if t then return t(j,l)end;error("unexpected type '"..s.."'")end;function a.encode(j)return b(j)end;local u;local function v(...)local m={}for o=1,select("#",...)do m[select(o,...)]=true end;return m end;local w=v(" ","\t","\r","\n")local x=v(" ","\t","\r","\n","]","}",",")local y=v("\\","/",'"',"b","f","n","r","t","u")local z=v("true","false","null")local A={["true"]=true,["false"]=false,["null"]=nil}local function B(C,D,E,F)for o=D,#C do if E[C:sub(o,o)]~=F then return o end end;return#C+1 end;local function G(C,D,H)local I=1;local J=1;for o=1,D-1 do J=J+1;if C:sub(o,o)=="\n"then I=I+1;J=1 end end;error(string_format("%s at line %d col %d",H,I,J))end;local function K(n)local t=math.floor;if n<=0x7f then return string_char(n)elseif n<=0x7ff then return string_char(t(n/64)+192,n%64+128)elseif n<=0xffff then return string_char(t(n/4096)+224,t(n%4096/64)+128,n%64+128)elseif n<=0x10ffff then return string_char(t(n/262144)+240,t(n%262144/4096)+128,t(n%4096/64)+128,n%64+128)end;error(string_format("invalid unicode codepoint '%x'",n))end;local function L(M)local N=tonumber(M:sub(3,6),16)local O=tonumber(M:sub(9,12),16)if O then return K((N-0xd800)*0x400+O-0xdc00+0x10000)else return K(N)end end;local function P(C,o)local Q=false;local R=false;local S=false;local T;for U=o+1,#C do local V=C:byte(U)if V<32 then G(C,U,"control character in string")end;if T==92 then if V==117 then local W=C:sub(U+1,U+5)if not W:find("%x%x%x%x")then G(C,U,"invalid unicode escape in string")end;if W:find("^[dD][89aAbB]")then R=true else Q=true end else local h=string_char(V)if not y[h]then G(C,U,"invalid escape char '"..h.."' in string")end;S=true end;T=nil elseif V==34 then local M=C:sub(o+1,U-1)if R then M=M:gsub("\\u[dD][89aAbB]..\\u....",L)end;if Q then M=M:gsub("\\u....",L)end;if S then M=M:gsub("\\.",d)end;return M,U+1 else T=V end end;G(C,o,"expected closing quote for string")end;local function X(C,o)local V=B(C,o,x)local M=C:sub(o,V-1)local n=tonumber(M)if not n then G(C,o,"invalid number '"..M.."'")end;return n,V end;local function Y(C,o)local V=B(C,o,x)local Z=C:sub(o,V-1)if not z[Z]then G(C,o,"invalid literal '"..Z.."'")end;return A[Z],V end;local function _(C,o)local m={}local n=1;o=o+1;while 1 do local V;o=B(C,o,w,true)if C:sub(o,o)=="]"then o=o+1;break end;V,o=u(C,o)m[n]=V;n=n+1;o=B(C,o,w,true)local a0=C:sub(o,o)o=o+1;if a0=="]"then break end;if a0~=","then G(C,o,"expected ']' or ','")end end;return m,o end;local function a1(C,o)local m={}o=o+1;while 1 do local a2,j;o=B(C,o,w,true)if C:sub(o,o)=="}"then o=o+1;break end;if C:sub(o,o)~='"'then G(C,o,"expected string for key")end;a2,o=u(C,o)o=B(C,o,w,true)if C:sub(o,o)~=":"then G(C,o,"expected ':' after key")end;o=B(C,o+1,w,true)j,o=u(C,o)m[a2]=j;o=B(C,o,w,true)local a0=C:sub(o,o)o=o+1;if a0=="}"then break end;if a0~=","then G(C,o,"expected '}' or ','")end end;return m,o end;local a3={['"']=P,["0"]=X,["1"]=X,["2"]=X,["3"]=X,["4"]=X,["5"]=X,["6"]=X,["7"]=X,["8"]=X,["9"]=X,["-"]=X,["t"]=Y,["f"]=Y,["n"]=Y,["["]=_,["{"]=a1}u=function(C,D)local a0=C:sub(D,D)local t=a3[a0]if t then return t(C,D)end;G(C,D,"unexpected character '"..a0 .."'")end;function a.decode(C)if type(C)~="string"then error("expected argument of type string, got "..type(C))end;local m,D=u(C,B(C,1,w,true))D=B(C,D,w,true)if D<=#C then G(C,D,"trailing garbage")end;return m end;return a end)()
local weapons = ((function() local a={}local type,b=type,bit.band;local c,d={},{}local e,f={[1]={"deagle",1,250,0,"Desert Eagle",0,0,1.0,0.87,2.2},[2]={"elite",1,250,0,"Dual Berettas",0,0,1.0,2.9,3.77},[3]={"fiveseven",1,250,0,"Five-SeveN",0,0,1.0,0.93,2.27},[4]={"glock",1,250,0,"Glock-18",0,0,1.1,0.93,2.27},[7]={"ak47",2,250,0,"AK-47",0,0,1.0,1.17,2.43},[8]={"aug",2,250,0,"AUG",0,0,1.17,1.53,3.77},[9]={"awp",2,250,0,"AWP",0,0,1.25,2.0,3.67},[10]={"famas",2,250,0,"FAMAS",0,0,1.0,1.63,3.3},[11]={"g3sg1",2,250,0,"G3SG1",0,0,1.0,2.6,4.67},[13]={"galilar",2,250,0,"Galil AR",0,0,1.1,1.17,3.03},[14]={"m249",3,250,0,"M249",0,0,1.1,3.73,5.7},[16]={"m4a1",2,250,0,"M4A4",0,0,1.13,1.37,3.07},[17]={"mac10",4,250,0,"MAC-10",0,0,1.0,1.27,2.57},[19]={"p90",4,250,0,"P90",0,0,1.0,1.97,3.37},[23]={"mp5sd",4,250,0,"MP5-SD",0,0,1.0,1.97,2.94},[24]={"ump45",4,250,0,"UMP-45",0,0,1.0,1.5,3.43},[25]={"xm1014",3,250,0,"XM1014",0,0,1.0,0.53,4.22},[26]={"bizon",4,250,0,"PP-Bizon",0,0,1.1,1.17,2.43},[27]={"mag7",3,250,0,"MAG-7",0,0,1.0,1.07,2.47},[28]={"negev",3,250,0,"Negev",0,0,1.1,3.83,5.7},[29]={"sawedoff",3,250,0,"Sawed-Off",0,0,1.0,0.55,4.22},[30]={"tec9",1,250,0,"Tec-9",0,0,1.0,1.33,2.57},[31]={"taser",5,250,0,"Zeus x27",0,0,-1,-1,-1},[32]={"hkp2000",1,250,0,"P2000",0,0,1.0,0.97,2.27},[33]={"mp7",4,250,0,"MP7",0,0,1.0,1.43,3.13},[34]={"mp9",4,250,0,"MP9",0,0,1.2,0.87,2.13},[35]={"nova",3,250,0,"Nova",0,0,1.0,0.54,4.74},[36]={"p250",1,250,0,"P250",0,0,1.0,0.93,2.27},[37]={"shield",1,250,0,"Ballistic Shield",0,0,-1,-1,-1},[38]={"scar20",2,250,0,"SCAR-20",0,0,1.0,1.4,3.07},[39]={"sg556",2,250,0,"SG 553",0,0,1.0,1.03,2.77},[40]={"ssg08",2,250,0,"SSG 08",0,0,1.0,1.97,3.7},[42]={"knife",6,250,0,"Knife",0,0,-1,-1,-1},[43]={"flashbang",7,250,0,"Flashbang",0,0,-1,-1,-1},[44]={"hegrenade",7,250,0,"High Explosive Grenade",0,0,-1,-1,-1},[45]={"smokegrenade",7,250,0,"Smoke Grenade",0,0,-1,-1,-1},[46]={"molotov",7,250,0,"Molotov",0,0,-1,-1,-1},[47]={"decoy",7,250,0,"Decoy Grenade",0,0,-1,-1,-1},[48]={"incgrenade",7,250,0,"Incendiary Grenade",0,0,-1,-1,-1},[49]={"c4",8,250,0,"C4 Explosive",0,0,-1,-1,-1},[50]={"item_kevlar",5,250,0,"Kevlar Vest",0,0,-1,-1,-1},[51]={"item_assaultsuit",5,250,0,"Kevlar + Helmet",0,0,-1,-1,-1},[52]={"item_heavyassaultsuit",5,250,0,"Heavy Assault Suit",0,0,-1,-1,-1},[55]={"item_defuser",5,250,0,"Defuse Kit",0,0,-1,-1,-1},[56]={"item_cutters",5,250,0,"Rescue Kit",0,0,-1,-1,-1},[59]={"knife_t",6,250,0,"Knife",0,0,-1,-1,-1},[60]={"m4a1_silencer",2,250,0,"M4A1-S",0,0,1.13,1.37,3.07},[61]={"usp_silencer",1,250,0,"USP-S",0,0,1.0,0.97,2.17},[63]={"cz75a",1,250,0,"CZ75-Auto",0,0,1.83,1.53,2.73},[64]={"revolver",1,250,0,"R8 Revolver",0,0,1.17,1.97,2.27},[74]={"melee",6,250,0,"Knife",0,0,-1,-1,-1},[500]={"bayonet",6,250,0,"Bayonet",0,0,-1,-1,-1},[503]={"knife_css",6,250,0,"Classic Knife",0,0,-1,-1,-1},[505]={"knife_flip",6,250,0,"Flip Knife",0,0,-1,-1,-1},[506]={"knife_gut",6,250,0,"Gut Knife",0,0,-1,-1,-1},[507]={"knife_karambit",6,250,0,"Karambit",0,0,-1,-1,-1},[508]={"knife_m9_bayonet",6,250,0,"M9 Bayonet",0,0,-1,-1,-1},[509]={"knife_tactical",6,250,0,"Huntsman Knife",0,0,-1,-1,-1},[512]={"knife_falchion",6,250,0,"Falchion Knife",0,0,-1,-1,-1},[514]={"knife_survival_bowie",6,250,0,"Bowie Knife",0,0,-1,-1,-1},[515]={"knife_butterfly",6,250,0,"Butterfly Knife",0,0,-1,-1,-1},[516]={"knife_push",6,250,0,"Shadow Daggers",0,0,-1,-1,-1},[517]={"knife_cord",6,250,0,"Paracord Knife",0,0,-1,-1,-1},[518]={"knife_canis",6,250,0,"Survival Knife",0,0,-1,-1,-1},[519]={"knife_ursus",6,250,0,"Ursus Knife",0,0,-1,-1,-1},[520]={"knife_gypsy_jackknife",6,250,0,"Navaja Knife",0,0,-1,-1,-1},[521]={"knife_outdoor",6,250,0,"Nomad Knife",0,0,-1,-1,-1},[522]={"knife_stiletto",6,250,0,"Stiletto Knife",0,0,-1,-1,-1},[523]={"knife_widowmaker",6,250,0,"Talon Knife",0,0,-1,-1,-1},[525]={"knife_skeleton",6,250,0,"Skeleton Knife",0,0,-1,-1,-1},[5027]={"studded_bloodhound_gloves",9,250,0,"Bloodhound Gloves",0,0,-1,-1,-1},[5028]={"t_gloves",9,250,0,"Default T Gloves",0,0,-1,-1,-1},[5029]={"ct_gloves",9,250,0,"Default CT Gloves",0,0,-1,-1,-1},[5030]={"sporty_gloves",9,250,0,"Sport Gloves",0,0,-1,-1,-1},[5031]={"slick_gloves",9,250,0,"Driver Gloves",0,0,-1,-1,-1},[5032]={"leather_handwraps",9,250,0,"Hand Wraps",0,0,-1,-1,-1},[5033]={"motorcycle_gloves",9,250,0,"Moto Gloves",0,0,-1,-1,-1},[5034]={"specialist_gloves",9,250,0,"Specialist Gloves",0,0,-1,-1,-1},[5035]={"studded_hydra_gloves",9,250,0,"Hydra Gloves",0,0,-1,-1,-1}},{"secondary","rifle","heavy","smg","equipment","melee","grenade","c4","clothing_hands"}for g,h in pairs(e)do local i,j=("weapon_"..h[1]):gsub("weapon_item_","item_"),f[h[2]]c[g]={console_name=i,idx=g,type=j,max_speed=h[3],price=h[4],name=h[5],primary_clip_size=h[6],cycletime=h[7]}d[i]=c[g]end;a.weapons=setmetatable(c,{__call=function(k,g)end,__index=function(k,g)if type(g)=="string"then return d[g]elseif type(g)=="number"then g=b(g,0xFFFF)return rawget(c,g)end end})return a end)()).weapons
local bit_band = bit.band

--min damage override
local mindmg_reference = ui_reference("RAGE", "Aimbot", "Minimum damage")

local slider_tooltips = {[0] = "Auto"}
for i=101, 126 do
	slider_tooltips[i] = "HP+" .. i-100 .. "    "
end

local hotkey_modes = {
	[0] = "always on",
	[1] = "on hotkey",
	[2] = "toggle",
	[3] = "off hotkey"
}

local override_enabled_reference = ui_new_checkbox("RAGE", "Other", "Override minimum damage")
local override_hotkey_reference = ui_new_hotkey("RAGE", "Other", "Override minimum damage key", true)
local override_value_reference = ui_new_slider("RAGE", "Other", "Minimum damage (Override)", 0, 126, 2, true, nil, 1, slider_tooltips)
local override_hotkey_raise_reference = ui_new_hotkey("RAGE", "Other", "Raise override minimum damage key", true)
local override_hotkey_lower_reference = ui_new_hotkey("RAGE", "Other", "Lower override minimum damage key", true)

local function on_override_enabled_changed()
	local enabled = ui_get(override_enabled_reference)
	ui_set_visible(override_value_reference, enabled)
	ui_set_visible(override_hotkey_raise_reference, enabled)
	ui_set_visible(override_hotkey_lower_reference, enabled)
end
ui_set_callback(override_enabled_reference, on_override_enabled_changed)
on_override_enabled_changed()

local hotkey_delay = 0.08

local raise_last, lower_last
local override_active_prev, value_prev = false

local function on_paint_override()
	local override_active = ui_get(override_enabled_reference) and ui_get(override_hotkey_reference) and entity_is_alive(entity_get_local_player())

	if override_active then
		if not override_active_prev then
			value_prev = ui_get(mindmg_reference)
		end
		local value = ui_get(override_value_reference)
		local realtime = globals_realtime()

		if value < 126 and ui_get(override_hotkey_raise_reference) and (raise_last == nil or realtime > raise_last+hotkey_delay) then
			value = value + 1
			raise_last = realtime
			ui_set(override_value_reference, value)
		elseif value > 0 and ui_get(override_hotkey_lower_reference) and (lower_last == nil or realtime > lower_last+hotkey_delay) then
			value = value - 1
			lower_last = realtime
			ui_set(override_value_reference, value)
		end

		renderer_indicator(255, 255, 255, 255, slider_tooltips[value] or value)

		ui_set(mindmg_reference, value)
	elseif override_active_prev then
		if value_prev ~= nil then
			-- client.log("restored to ", value_prev)
			ui_set(mindmg_reference, value_prev)
			value_prev = nil
		end
	end
	override_active_prev = override_active
end

local weapons_no_group = {
	[weapons["weapon_knife"]] = true,
	-- [weapons["weapon_knifegg"]] = true,
	-- [weapons["weapon_knife_t"]] = true,
}

for idx, weapon in pairs(weapons) do
	if weapon.type == "melee" or weapon.type == "grenade" then
		weapons_no_group[weapon] = true
	end
end

local weapon_groups = {
	["Autosniper"] = {weapons["weapon_scar20"], weapons["weapon_g3sg1"]},
	["AWP"] = {weapons["weapon_awp"]},
	["Scout"] = {weapons["weapon_ssg08"]},
	["R8 Revolver"] = {weapons["weapon_revolver"]},
	["Deagle"] = {weapons["weapon_deagle"]},
	["Pistol"] = {"secondary"},
	["SMG"] = {"smg"},
	["Automatic"] = {"rifle"},
	["Other"] = {},
	["Taser"] = {weapons["weapon_taser"]}
}
local weapon_groups_reference = {}

local function get_keys(tbl)
	local result = {}
	for key, value in pairs(tbl) do
		table_insert(result, key)
	end
	return result
end

--get references to all default items
local references_names_default = {
	target_selection = "Target selection",
	target_hitbox = "Target hitbox",
	avoid_unsafe_hitboxes = "Avoid unsafe hitboxes",
	[{"multipoint", "multipoint_hotkey", "multipoint_type"}] = "Multi-point",
	multipoint_scale = "Multi-point scale",
	prefer_safe_point = "Prefer safe point",
	force_safe_point = "Force safe point",
	automatic_penetration = "Automatic penetration",
	min_hitchance = "Minimum hit chance",
	min_damage = "Minimum damage",
	maximum_fov = "Maximum FOV",

	--other
	accuracy_boost = {"RAGE", "Other", "Accuracy boost"},
	accuracy_boost_options = {"RAGE", "Other", "Accuracy boost options"},
	delay_shot = "Delay shot",
	[{"quickstop", "quickstop_hotkey"}] = {"RAGE", "Other", "Quick stop"},
	quickstop_options = {"RAGE", "Other", "Quick stop options"},
	prefer_bodyaim = {"RAGE", "Other", "Prefer body aim"},
	prefer_bodyaim_disablers = {"RAGE", "Other", "Prefer body aim disablers"},
	[{"double_tap"}] = {"RAGE", "Other", "Double tap"},
	double_tap_mode = {"RAGE", "Other", "Double tap mode"},
	min_damage_override = {"RAGE", "Other", "Minimum damage (Override)"},

	-- aa
	[{"on_shot_antiaim"}] = {"AA", "Other", "On shot anti-aim"},
	[{"fake_peek"}] = {"AA", "Other", "Fake peek"}
}

local references_default = {}
for ids, references_values in pairs(references_names_default) do
	if type(references_values) == "string" then
		references_values = {"RAGE", "Aimbot", references_values}
	end
	if type(ids) == "string" then
		ids = {ids}
	end
	
		local success, err = pcall(function()
		local references = {ui_reference(unpack(references_values))}
		for i=1, #ids do
			if ids[i] ~= "_" then
				references_default[ids[i]] = references[i]
			end
		end
	end)
	if not success then
		-- client_error_log("Failed to initialize ", ids[1], ": ", err)
	end
end

local weapon_groups_lookup = setmetatable({}, {__index = function(_, key) return weapons_no_group[key] == nil and "Other" or nil end})

for group_name, group_weapons in pairs(weapon_groups) do
	--client.log(group_name, " ", inspect(group_weapons))
	for i=1, #group_weapons do
		local wpn = group_weapons[i]
		if type(wpn) == "table" then
			weapon_groups_lookup[wpn] = group_name
		else
			for idx, weapon in pairs(weapons) do
				if weapon.type == wpn then
					--rawget to bypass the metatable __index
					if rawget(weapon_groups_lookup, weapon) == nil then
						weapon_groups_lookup[weapon] = group_name
					end
				end
			end
		end
end
	weapon_groups_reference[group_name] = ui_new_string("weapon configs: " .. group_name, "{}")
end

--for idx, name in pairs(idx_to_console_name) do
--	client.log(name, " resolves to ", weapon_groups_lookup[idx])
--end

local setup_reference = ui_new_checkbox("RAGE", "Other", "Weapon configs setup complete")
local enabled_reference = ui_new_checkbox("RAGE", "Other", "Weapon configs")
local active_group_reference = ui_new_combobox("RAGE", "Other", "\nActive weapon group", get_keys(weapon_groups))
ui_set_visible(setup_reference, false)

local enabled_prev
local function on_enabled_changed()
	local enabled = ui_get(enabled_reference)
	ui_set_visible(active_group_reference, enabled)
		enabled_prev = enabled
end
ui_set_callback(enabled_reference, on_enabled_changed)
on_enabled_changed()

local function save()
	if not ui_get(enabled_reference) then
		return
	end

	local active_group = ui_get(active_group_reference)

	local data = {}
	local success, data2 = pcall(json.decode, ui_get(weapon_groups_reference[active_group]))
	if success then
		data = data2
	end

	for id, reference in pairs(references_default) do
		if id == "min_damage" and override_active_prev then
			data[id] = {value_prev}
		else
			data[id] = {ui_get(reference)}
		end
	end
	ui_set(weapon_groups_reference[active_group], json.encode(data))
end

local function load()
	if not ui_get(enabled_reference) then
		return
	end

	local active_group = ui_get(active_group_reference)

	local success, data = pcall(json.decode, ui_get(weapon_groups_reference[active_group]))
	if success then
		for id, value in pairs(data) do
			if id == "min_damage" and override_active_prev then
				value_prev = value[1]
			else
				if #value >= 2 and type(value[1]) == "boolean" and type(value[2]) == "number" then
					-- hotkeys
					value = {hotkey_modes[value[2]]}
				elseif (active_group == "Other" or active_group == "Taser") and (id == "on_shot_antiaim" or id == "on_shot_antiaim_hotkey" or id == "double_tap" or id == "double_tap_hotkey") then
					value = nil
				end
				if value ~= nil and references_default[id] then
					local success, err = pcall(ui_set, references_default[id], unpack(value))
					if not success then
						-- client_error_log("Failed to apply ", id, ": ", err)
					end
				end
			end
		end
	else
		client_error_log("Failed to decode json: " .. data)
	end
end
ui_set_callback(active_group_reference, load)
load()

local function task()
	save()
	client_delay_call(0.25, task)
end
task()

local weapon_type_prev
local function on_run_command(e)
	if not ui_get(enabled_reference) then
		return
	end

	local menu_open = ui_is_menu_open()

	local local_player = entity_get_local_player()
	if local_player == nil then
		return
	end

	local weapon = entity_get_player_weapon(local_player)
	if weapon == nil then
		return
	end

	local idx = entity_get_prop(weapon, "m_iItemDefinitionIndex")
	local weapon_type = weapon_groups_lookup[weapons[idx]]

	if weapon_type ~= nil and weapon_type ~= weapon_type_prev then
		ui_set(active_group_reference, weapon_type)
		load()
	end

	weapon_type_prev = weapon_type
end
client_set_event_callback("run_command", on_run_command)
local function on_paint()
	on_paint_override()
end
client_set_event_callback("paint", on_paint)

return {
	load = load,
	save = save,
}