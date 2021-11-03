--[[
	id: jAEC9kC_44CT_1JzUji45
	name: capo.lua V1 no auth [DEV ONLY]
	description: no auth [DEV ONLY]\nV1 27/05
	time1: 2021-05-26 22:02:50.563905+00
	time2: 2021-05-26 22:02:50.563905+00
	uploader: Xinqom_IzPMJ2wxbNEZCZcVEMNlEvZPrCaV0kn0-
	uploadersession: n1pautn3bUKwKtYWYfT9SPgNxC-T71
	flag: f
--]]

local http = require "gamesense/http"
local check = false
local vali = false
local steamid = entity.get_steam64(entity.get_local_player( ))
local hx, hy = client.screen_size()
local hwid2 = hx + hy * 237
local h, m, s =  client.system_time()
local seconds1 = m * 60
local seconds2 = h * 60 * 60
local seconds = seconds1 + seconds2 + s
local session = seconds

function GetHWID()
    local a=require("ffi")or error("Failed to require FFI, please make sure Allow unsafe scripts is enabled!",2)a.cdef[[
    typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
    typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
]]local b=a.typeof("void***")local c=client.create_interface("filesystem_stdio.dll","VBaseFileSystem011")or error(_debug and"Failed to get VBaseFileSystem011 interface"or"error",2)local d=a.cast(b,c)or error(_debug and"Failed to cast rawfilesystem to filesystem"or"error",2)local e=a.cast("file_exists_t",d[0][10])or error(_debug and"Failed to cast file_exists_t"or"error",2)local f=a.cast("get_file_time_t",d[0][13])or error(_debug and"Failed to cast get_file_time_t"or"error",2)local function g()for h=65,90 do local i=string.char(h)..":\\Windows\\Setup\\State\\State.ini"if e(d,i,"ROOT")then return i end end;return nil end;local i=g()or error(_debug and"Failed to bruteforce system directory"or"error",2)local j=f(d,i,"ROOT")or error(_debug and"get_file_time failed"or"error",2)local k=j*2;return k;
end
local hwid = GetHWID()
local hwidfinal = hwid + hwid2

http.get("https://capo.network/?apiKey=penis1&action=hwid&hwid=" .. hwidfinal, function(success, response)
  if not success or response.status ~= 200 then
    return
  end
local data = json.parse(response.body) 
local status = data[1].status
local message = data[1].msg

if message == "hwid valid" then

else
client.exec("exit")
while 1 == 1 do
print("CRASH CRASH")
print(message)
end

end
end)

if steamid == nil then
client.log("join a game to activate lua")
else
http.get("https://capo.network/?apiKey=penis1&action=vali&hwid=" .. hwidfinal .. "&id=" .. steamid, function(success, response)
  if not success or response.status ~= 200 then
    return
  end
local dat = json.parse(response.body) 
local status2 = dat[1].status
local message2 = dat[1].msg
if status2 == "success" then
client.color_log(200, 50, 50, message2)
check = true
else
client.exec("exit")
while 1 == 1 do
print("CRASH")
end
end
end)
end

if steamid == nil then
else
vali = true

end





local bodyyaw3, yaw = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local bodyyaw, bodyyaw2 = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local jyaw, jyawslide = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local fyawlimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local freestanding = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local freestanding2, freestanding3 = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_get_players, entity_is_alive = entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.get_players, entity.is_alive, bit_band

local mp, mp2, mp3 = ui.reference("RAGE", "Aimbot", "Multi-point")
local en, en2 = ui.reference("RAGE", "Aimbot", "Enabled")
local qs, qs2 = ui.reference("RAGE", "Other", "Quick stop")
local dt, dt2 = ui.reference("RAGE", "Other", "Double tap")
local qus = ui.reference("RAGE", "Other", "Quick stop options")
--the stuff we need to begin with
local ragetxt = ui.new_label("AA", "Fake lag", "<-- HELIOS V1 by capo -->")
local enabled = ui.new_checkbox("AA", "Fake lag", "Enable auto hvh")
local color  = ui.new_color_picker("AA", "Fake lag", "Indicator color", 255, 255, 255, 255)
--fixed the multiselect stupid stuff and now its combobox
local ragetxt = ui.new_label("RAGE", "Aimbot", "AUTO HVH ACTIVE")
local ragetxt2 = ui.new_label("RAGE", "Other", "AUTO HVH ACTIVE")
local option = ui.new_combobox("AA", "Fake lag", "Options", "Disabled", "auto hvh")

local ideal = ui.new_checkbox("AA", "Anti-aimbot angles", "auto hvh")
local wm = ui.new_checkbox("AA", "Fake lag", "helios watermark")
local idealoption = ui.new_combobox("AA", "Anti-aimbot angles", "auto aa modes", "High", "Low", "dodge")
local idealinvert = ui.new_hotkey("AA", "Anti-aimbot angles", "Inverter")
local idealepeek = ui.new_hotkey("AA", "Anti-aimbot angles", "Advanced E Peek")

ui.set(ui.reference("AA", "Fake lag", "Enable auto hvh"), true)
ui.set_visible(ui.reference("AA", "Fake lag", "Enable auto hvh"), false)




--lets see what we have active // tropics did this 
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


--setting the function for tables
local function setTableVisibility(table, state)
    for i=1, #table do
        ui.set_visible(table[i], state)
    end
end

local function handleGUI()
    local enabled = ui.get(enabled)
    setTableVisibility({color, option}, enabled)
    setTableVisibility({back, left, right}, enabled and ui.get(option) == "Disabled")
    ui.set_visible(ideal, enabled and ui.get(option) == "auto hvh")
    local setactive = ui.get(ideal)
    setTableVisibility({idealinvert, idealoption, idealepeek}, setactive and ui.get(option), "auto hvh")
end

--locals for manual aa and indicators
local leftReady = false
local rightReady = false
local mode = "back"
local screen = {client.screen_size()}
local center = {screen[1]/2, screen[2]/2}
local pos1 = 0
local pos2 = screen[2]/2

local function runCommand()
    if ui.get(enabled) == false then
        return
    end
    local player_weapon = entity.get_player_weapon( entity.get_local_player( ) )
    local weapon = bit.band( 65535, entity.get_prop( player_weapon, "m_iItemDefinitionIndex" ) )
	
    if ui.get(option) == "auto hvh" then
	
	-- auto rage START
	if ui.get(ideal) then	
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Target selection"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Target Hitbox"), false)
				ui.set_visible(mp, false)
				ui.set_visible(mp2, false)
				ui.set_visible(mp3, false)
				ui.set_visible(ragetxt, true)
				ui.set_visible(ragetxt2, true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Multi-point scale"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Prefer safe point"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Automatic fire"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Automatic penetration"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Silent aim"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Minimum damage"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Maximum FOV"), false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Remove recoil"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Accuracy boost"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set_visible(qs, false)
				ui.set_visible(qs2, false)
				ui.set_visible(qus, false)
				ui.set_visible(ui.reference("RAGE", "Other", "Anti-aim correction"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Prefer body aim"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Prefer body aim disablers"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Prefer body aim"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap mode"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap hit chance"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap fake lag limit"), false)
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap quick stop"), false)

				
				
				-- AUTO SNIPER
				if weapon == 11 or 38 then
				
				ui.set(ui.reference("RAGE", "Aimbot", "Target selection"), "Highest damage")
				ui.set(ui.reference("RAGE", "Aimbot", "Target Hitbox"), "Head", "Chest", "Stomach", "Feet")
				ui.set(mp, "Head", "Chest", "Stomach")
				ui.set(mp2, "Always on")
				ui.set(mp3, "High")
				ui.set(ui.reference("RAGE", "Aimbot", "Multi-point scale"), 67)
				ui.set(ui.reference("RAGE", "Aimbot", "Prefer safe point"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), "")
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Silent aim"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), 68)
				if ui.get(dt) then
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 40)
				else
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 21)
				end
				ui.set(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Maximum FOV"), 180)
				ui.set(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set(ui.reference("RAGE", "Other", "Accuracy boost"), "Maximum")
				ui.set(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set(qs, true)
				ui.set(qs2, "Always on")
				ui.set(qus, "Move between shots", "Ignore molotov", "Taser")
				ui.set(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim disablers"), "Target shot fired", "Low damage", "Safe point headshot")
				ui.set(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set(dt, true)
				ui.set(ui.reference("RAGE", "Other", "Double tap mode"), "Defensive")
				ui.set(ui.reference("RAGE", "Other", "Double tap quick stop"), "Move between shots")
				ui.set(ui.reference("RAGE", "Other", "Double tap fake lag limit"), 2)
				ui.set(ui.reference("RAGE", "Other", "Double tap hit chance"), 45)
				
				end
				
				if weapon == 40 then
				ui.set(ui.reference("RAGE", "Aimbot", "Target selection"), "Highest damage")
				ui.set(ui.reference("RAGE", "Aimbot", "Target Hitbox"), "Head", "Chest", "Stomach", "Feet")
				ui.set(mp, "Head", "Chest", "Stomach")
				ui.set(mp2, "Always on")
				ui.set(mp3, "High")
				ui.set(ui.reference("RAGE", "Aimbot", "Multi-point scale"), 68)
				ui.set(ui.reference("RAGE", "Aimbot", "Prefer safe point"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), "")
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Silent aim"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), 86)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 71)
				ui.set(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Maximum FOV"), 180)
				ui.set(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set(ui.reference("RAGE", "Other", "Accuracy boost"), "Maximum")
				ui.set(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set(qs, true)
				ui.set(qs2, "Always on")
				ui.set(qus, "Move between shots", "Ignore molotov", "Taser")
				ui.set(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim"), false)
				ui.set(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set(dt, false)
				
				end

				if weapon == 64 then
				-- scout end
				
				-- revolver
				
				ui.set(ui.reference("RAGE", "Aimbot", "Target selection"), "Highest damage")
				ui.set(ui.reference("RAGE", "Aimbot", "Target Hitbox"), "Head", "Chest", "Stomach", "Feet")
				ui.set(mp, "Head", "Chest", "Stomach")
				ui.set(mp2, "Always on")
				ui.set(mp3, "High")
				ui.set(ui.reference("RAGE", "Aimbot", "Multi-point scale"), 63)
				ui.set(ui.reference("RAGE", "Aimbot", "Prefer safe point"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), "")
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Silent aim"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), 72)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 31)
				ui.set(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Maximum FOV"), 180)
				ui.set(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set(ui.reference("RAGE", "Other", "Accuracy boost"), "Maximum")
				ui.set(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set(qs, true)
				ui.set(qs2, "Always on")
				ui.set(qus, "Slow motion", "Ignore molotov", "Taser")
				ui.set(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim"), false)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim disablers"), "Target shot fired")
				ui.set(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set(dt, false)
				end
				if weapon == 9 then
				-- revolver end
				
				-- awp
				
				ui.set(ui.reference("RAGE", "Aimbot", "Target selection"), "Highest damage")
				ui.set(ui.reference("RAGE", "Aimbot", "Target Hitbox"), "Head", "Chest", "Stomach", "Feet")
				ui.set(mp, "Head", "Chest", "Stomach")
				ui.set(mp2, "Always on")
				ui.set(mp3, "High")
				ui.set(ui.reference("RAGE", "Aimbot", "Multi-point scale"), 64)
				ui.set(ui.reference("RAGE", "Aimbot", "Prefer safe point"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), "")
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Silent aim"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), 92)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 100)
				ui.set(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Maximum FOV"), 180)
				ui.set(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set(ui.reference("RAGE", "Other", "Accuracy boost"), "Maximum")
				ui.set(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set(qs, true)
				ui.set(qs2, "Always on")
				ui.set(qus, "Move between shots", "Ignore molotov", "Taser")
				ui.set(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim disablers"), "")
				ui.set(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set(dt, false)
				
				end
				-- awp end
				if weapon == 1 then
				
				ui.set(ui.reference("RAGE", "Aimbot", "Target selection"), "Highest damage")
				ui.set(ui.reference("RAGE", "Aimbot", "Target Hitbox"), "Head", "Chest", "Stomach", "Feet")
				ui.set(mp, "Head", "Chest", "Stomach")
				ui.set(mp2, "Always on")
				ui.set(mp3, "High")
				ui.set(ui.reference("RAGE", "Aimbot", "Multi-point scale"), 60)
				ui.set(ui.reference("RAGE", "Aimbot", "Prefer safe point"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), "")
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Silent aim"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), 60)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 31)
				ui.set(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Maximum FOV"), 180)
				ui.set(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set(ui.reference("RAGE", "Other", "Accuracy boost"), "Maximum")
				ui.set(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set(qs, true)
				ui.set(qs2, "Always on")
				ui.set(qus, "Move between shots", "Ignore molotov", "Taser")
				ui.set(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim"), false)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim disablers"), "")
				ui.set(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set(ui.reference("RAGE", "Other", "Double tap"), true)
				ui.set(ui.reference("RAGE", "Other", "Double tap mode"), "Defensive")
				ui.set(ui.reference("RAGE", "Other", "Double tap quick stop"), "Move between shots")
				ui.set(ui.reference("RAGE", "Other", "Double tap fake lag limit"), 5)
				ui.set(ui.reference("RAGE", "Other", "Double tap hit chance"), 55)
				
				end
				-- deagle end
					
				if weapon == 31 then
				
				
				-- pistols
				
				ui.set(ui.reference("RAGE", "Aimbot", "Target selection"), "Highest damage")
				ui.set(ui.reference("RAGE", "Aimbot", "Target Hitbox"), "Head", "Chest", "Stomach", "Feet")
				ui.set(mp, "Head", "Chest", "Stomach")
				ui.set(mp2, "Always on")
				ui.set(mp3, "High")
				ui.set(ui.reference("RAGE", "Aimbot", "Multi-point scale"), 65)
				ui.set(ui.reference("RAGE", "Aimbot", "Prefer safe point"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), "")
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Silent aim"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), 70)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 100)
				ui.set(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Maximum FOV"), 180)
				ui.set(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set(ui.reference("RAGE", "Other", "Accuracy boost"), "Maximum")
				ui.set(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set(qs, true)
				ui.set(qs2, "Always on")
				ui.set(qus, "Slow motion", "Ignore molotov", "Taser")
				ui.set(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim"), false)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim disablers"), "")
				ui.set(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set(ui.reference("RAGE", "Other", "Double tap"), true)
				ui.set(ui.reference("RAGE", "Other", "Double tap mode"), "Defensive")
				ui.set(ui.reference("RAGE", "Other", "Double tap quick stop"), "Move between shots")
				ui.set(ui.reference("RAGE", "Other", "Double tap fake lag limit"), 5)
				ui.set(ui.reference("RAGE", "Other", "Double tap hit chance"), 55)
				
				end
				-- pistols end

				else
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap hit chance"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap fake lag limit"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap quick stop"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Double tap mode"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Force body aim on peek"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Prefer body aim disablers"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Prefer body aim"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set_visible(qus, true)
				ui.set_visible(qs, true)
				ui.set_visible(qs2, true)
				ui.set_visible(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set_visible(ragetxt, false)
				ui.set_visible(ragetxt2, false)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Target selection"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Target Hitbox"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Multi-point"), true)
				ui.set_visible(mp, true)
				ui.set_visible(mp2, true)
				ui.set_visible(mp3, true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Multi-point scale"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Prefer safe point"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Automatic fire"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Automatic penetration"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Silent aim"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Minimum damage"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Reduce aim step"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Maximum FOV"), true)
				ui.set_visible(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Accuracy boost"), true)
				ui.set_visible(ui.reference("RAGE", "Other", "Delay shot"), true)
				
				ui.set(ui.reference("RAGE", "Aimbot", "Target selection"), "Cycle")
				ui.set(ui.reference("RAGE", "Aimbot", "Target Hitbox"), "Head")
				ui.set(mp, "")
				ui.set(mp2, "Always on")
				ui.set(mp3, "High")
				ui.set(ui.reference("RAGE", "Aimbot", "Multi-point scale"), 50)
				ui.set(ui.reference("RAGE", "Aimbot", "Prefer safe point"), true)
				ui.set(ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"), "Head")
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic fire"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Automatic penetration"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Silent aim"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum hit chance"), 1)
				ui.set(ui.reference("RAGE", "Aimbot", "Minimum damage"), 1)
				ui.set(ui.reference("RAGE", "Aimbot", "Reduce aim step"), false)
				ui.set(ui.reference("RAGE", "Aimbot", "Maximum FOV"), 10)
				ui.set(ui.reference("RAGE", "Aimbot", "Log misses due to spread"), true)
				ui.set(ui.reference("RAGE", "Other", "Accuracy boost"), "Medium")
				ui.set(ui.reference("RAGE", "Other", "Delay shot"), false)
				ui.set(qs, true)
				ui.set(qs2, "Always on")
				ui.set(qus, "")
				ui.set(ui.reference("RAGE", "Other", "Anti-aim correction"), true)
				ui.set(ui.reference("RAGE", "Other", "Remove recoil"), true)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim"), false)
				ui.set(ui.reference("RAGE", "Other", "Prefer body aim disablers"), "")
				ui.set(ui.reference("RAGE", "Other", "Force body aim on peek"), false)
				ui.set(dt, true)
				ui.set(ui.reference("RAGE", "Other", "Double tap mode"), "Defensive")
				ui.set(ui.reference("RAGE", "Other", "Double tap quick stop"), "")
				ui.set(ui.reference("RAGE", "Other", "Double tap fake lag limit"), 1)
				ui.set(ui.reference("RAGE", "Other", "Double tap hit chance"), 1)
				
				ui.set_visible(bodyyaw2, false)
				ui.set_visible(pitch, false)
				ui.set_visible(bodyyaw, false)
				ui.set_visible(yaw, false)
				ui.set_visible(yawbase, false)
				ui.set_visible(jyaw, false)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Edge yaw"), false)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Yaw"), false)
				ui.set_visible(freestanding2, false)
				ui.set_visible(freestanding3, false)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Enabled"), false)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"), false)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"), false)
								ui.set_visible(ui.reference("AA", "Fake lag", "Limit"), false)
				ui.set_visible(ui.reference("AA", "Fake lag", "Amount"), false)
				ui.set_visible(ui.reference("AA", "Fake lag", "Variance"), false)
				end
				--auto rage END
				
				
				

        if ui.get(idealoption) == "High" then
            if ui.get(idealinvert) then
                ui.set(yaw, -30)
                ui.set(bodyyaw2, -60)
                ui.set(fyawlimit, 41)
                ui.set(bodyyaw, "Static")
                ui.set(yawbase, "At targets")
                ui.set(pitch, "Minimal")
                ui.set(freestanding, true)
            else
                ui.set(yaw, 30)
                ui.set(bodyyaw2, 60)
                ui.set(fyawlimit, 41)
                ui.set(bodyyaw, "Static")
                ui.set(yawbase, "At targets")
                ui.set(pitch, "Minimal")
                ui.set(freestanding, true)
            end
        end
        if ui.get(idealoption) == "Low" then
            if ui.get(idealinvert) then
                ui.set(yaw, -2)
                ui.set(bodyyaw2, -118)
                ui.set(fyawlimit, 24)
                ui.set(bodyyaw, "Static")
                ui.set(yawbase, "At targets")
                ui.set(pitch, "Minimal")
                ui.set(freestanding, true)
            else
                ui.set(yaw, 4)
                ui.set(bodyyaw2, 101)
                ui.set(fyawlimit, 24)
                ui.set(bodyyaw, "Static")
                ui.set(yawbase, "At targets")
                ui.set(pitch, "Minimal")
                ui.set(freestanding, true)
            end
        end
        if ui.get(idealoption) == "dodge" then
		if entity.is_alive(entity.get_local_player()) then
            ui.set(yaw, math.random(-11, 17))
			ui.set(bodyyaw3, "180")
            ui.set(bodyyaw2, 0)
            ui.set(fyawlimit, math.random(27, 57))
            ui.set(bodyyaw, "Opposite")
            ui.set(freestanding, false)
            ui.set(pitch, "Minimal")
			ui.set(ui.reference("AA", "Fake lag", "Limit"), math.random(5, 14))
			ui.set(ui.reference("AA", "Fake lag", "Amount"), "Maximum")
			ui.set(ui.reference("AA", "Fake lag", "Enabled"), true)
else
				ui.set(yaw, 30)
                ui.set(bodyyaw2, 60)
                ui.set(fyawlimit, 41)
                ui.set(bodyyaw, "Static")
                ui.set(yawbase, "At targets")
                ui.set(pitch, "Minimal")
                ui.set(freestanding, true)
end
        end
        if ui.get(idealepeek) then
            ui.set(yaw, 180)
            ui.set(bodyyaw2, 133)
            ui.set(bodyyaw, "Static")
            ui.set(fyawlimit, 48)
            ui.set(pitch, "Off")
        else return
        end
    else 
				ui.set_visible(bodyyaw2, true)
				ui.set_visible(pitch, true)
				ui.set_visible(bodyyaw, true)
				ui.set_visible(yawbase, true)
				ui.set_visible(jyaw, true)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Edge yaw"), true)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Yaw"), true)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Enabled"), true)
				ui.set_visible(freestanding2, true)
				ui.set_visible(freestanding3, true)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"), true)
				ui.set_visible(ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"), true)
				ui.set_visible(ui.reference("AA", "Fake lag", "Limit"), true)
				ui.set_visible(ui.reference("AA", "Fake lag", "Amount"), true)
				ui.set_visible(ui.reference("AA", "Fake lag", "Variance"), true)
	end
end

local function paint()
    if ui.get(enabled) == false then
        return
    end
    
    local lp = entity.get_local_player()

    if lp == nil or entity.is_alive(lp) == false then
        return
    end

    local color_g = {ui.get(color)}

local player_weapon = entity.get_player_weapon( entity.get_local_player( ) )
    local weapon = bit.band( 65535, entity.get_prop( player_weapon, "m_iItemDefinitionIndex" ) )
	
	if ui.get(wm) then
	renderer.gradient(pos1 + 30, pos2 - 50, 300, 12, color_g[1], color_g[2], color_g[3], 255, color_g[1], color_g[2], color_g[3], 20, false)
	renderer.text(pos1 + 180, pos2 - 44, color_g[1], color_g[2], color_g[3], 255, "cb+", 0, "HELIOS" )
	renderer.gradient(pos1 + 30, pos2 + 50, 300, 12, color_g[1], color_g[2], color_g[3], 20, color_g[1], color_g[2], color_g[3], 255, false)
	renderer.text(pos1 + 40, pos2 - 30, color_g[1], color_g[2], color_g[3], 255, "+", 0, "AA-Mode:" )
	renderer.text(pos1 + 40, pos2 - 12, color_g[1], color_g[2], color_g[3], 255, "+", 0, "E-Peak:" )
	if ui.get(ideal) then
	if ui.get(idealepeek) then
	renderer.text(pos1 + 200, pos2 - 12, 5, 255, 5, 255, "+", 0, "True" )
	else
	renderer.text(pos1 + 200, pos2 - 12, 255, 5, 5, 255, "+", 0, "False" )
	end
	if ui.get(idealoption) == "dodge" then
	renderer.text(pos1 + 200, pos2 - 30, 5, 255, 5, 255, "+", 0, "Dodge" )
	
	elseif ui.get(idealoption) == "High" then
	renderer.text(pos1 + 200, pos2 - 30, 5, 255, 5, 255, "+", 0, "High" )
	
	elseif ui.get(idealoption) == "Low" then
	renderer.text(pos1 + 200, pos2 - 30, 5, 255, 5, 255, "+", 0, "Low" )
	else
	renderer.text(pos1 + 200, pos2 - 30, 255, 5, 5, 255, "+", 0, "None" )
	end
	else
	renderer.text(pos1 + 200, pos2 - 30, 255, 5, 5, 255, "+", 0, "None" )
	end
	end
	
    if ui.get(ideal) then
	
        if ui.get(idealinvert) then
            renderer.text(center[1] + 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "cb+", 0, ">" )
            renderer.text(center[1] - 43, center[2] - 3, 45, 45, 45, 255, "cb+", 0, "<" )
        else
            renderer.text(center[1] - 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "cb+", 0, "<" )
            renderer.text(center[1] + 43, center[2] - 3, 45, 45, 45, 255, "cb+", 0, ">" )
        end
        renderer.text(center[1], center[2] + 23, color_g[1], color_g[2], color_g[3], color_g[4], "cb", 0, "HELIOS" )
		
		if weapon == 11 then
		renderer.text(center[1], center[2] + 43, 0, 219, 22, 255, "cb", 0, "autosniper cfg" )
		end
		if weapon == 38 then
		renderer.text(center[1], center[2] + 43, 0, 219, 22, 255, "cb", 0, "autosniper cfg" )
		end
		if weapon == 9 then
		renderer.text(center[1], center[2] + 43, 0, 219, 22, 255, "cb", 0, "awp cfg" )
		end
		if weapon == 40 then
		renderer.text(center[1], center[2] + 43, 0, 219, 22, 255, "cb", 0, "scout cfg" )
		end
		if weapon == 64 then
		renderer.text(center[1], center[2] + 43, 0, 219, 22, 255, "cb", 0, "revolver cfg" )
		end
		if weapon == 1 then
		renderer.text(center[1], center[2] + 43, 0, 219, 22, 255, "cb", 0, "deagle cfg" )
		end
		if weapon == 31 then
		renderer.text(center[1], center[2] + 43, 0, 219, 22, 255, "cb", 0, "zeus cfg" )
		end
    end
end
local globals_realtime = globals.realtime
local globals_curtime = globals.curtime
local globals_maxplayers = globals.maxplayers
local globals_tickcount = globals.tickcount
local globals_tickinterval = globals.tickinterval
local globals_mapname = globals.mapname

local client_set_event_callback = client.set_event_callback
local client_console_log = client.log
local client_console_cmd = client.exec
local client_userid_to_entindex = client.userid_to_entindex
local client_get_cvar = client.get_cvar
local client_draw_debug_text = client.draw_debug_text
local client_draw_hitboxes = client.draw_hitboxes
local client_random_int = client.random_int
local client_random_float = client.random_float
local client_draw_text = client.draw_text
local client_draw_rectangle = client.draw_rectangle
local client_draw_line = client.draw_line
local client_world_to_screen = client.world_to_screen
local client_delay_call = client.delay_call
local client_visible = client.visible

local ui_new_checkbox = ui.new_checkbox
local ui_new_slider = ui.new_slider
local ui_new_button = ui.new_button
local ui_new_combobox = ui.new_combobox
local ui_new_multiselect = ui.new_multiselect
local ui_new_hotkey = ui.new_hotkey
local ui_set = ui.set
local ui_get = ui.get
local ui_set_visible = ui.set_visible

local entity_get_local_player = entity.get_local_player
local entity_get_all = entity.get_all
local entity_get_players = entity.get_players
local entity_get_classname = entity.get_classname
local entity_set_prop = entity.set_prop
local entity_get_prop = entity.get_prop
local entity_is_enemy = entity.is_enemy
local entity_get_player_name = entity.get_player_name
local entity_get_player_weapon = entity.get_player_weapon

local table_concat = table.concat
local table_insert = table.insert
local to_number = tonumber
local math_floor = math.floor
local table_remove = table.remove
local string_format = string.format

local delay = 0.03

local primary_weapons = {
	{name='-', command=""},
	{name='AWP', command="buy awp; "},
	{name='Auto-Sniper', command="buy scar20; buy g3sg1; "},
	{name='Scout', command="buy ssg08; "},
	{name='Negev', command="buy negev; "}
}

local secondary_weapons = {
	{name='-', command=""},
	{name='R8 Revolver / Deagle', command="buy deagle; "},
	{name='Dual Berettas', command="buy elite; "},
	{name='FN57 / Tec9 / CZ75-Auto', command="buy fn57; "}
}

local gear_weapons = {
	{name='Kevlar', command="buy vest; "},
	{name='Helmet', command="buy vesthelm; "},
	{name='Defuse Kit', command="buy defuser; "},
	{name='Grenade', command="buy hegrenade; "},
	{name='Molotov', command="buy incgrenade; "},
	{name='Smoke', command="buy smokegrenade; "},
	{name='Flashbang (x2)', command="buy flashbang; "},
	{name='Taser', command="buy taser; "},
}

local function get_names(table)
	local names = {}
	for i=1, #table do
		table_insert(names, table[i]["name"])
	end
	return names
end

local function get_command(table, name)
	for i=1, #table do
		if table[i]["name"] == name then
			return table[i]["command"]
		end
	end
end

local buybot_enabled = ui_new_checkbox("MISC", "Miscellaneous", "Auto-Buy")
local buybot_primary = ui_new_combobox("MISC", "Miscellaneous", "Auto-Buy: Primary", get_names(primary_weapons))
local buybot_pistol = ui_new_combobox("MISC", "Miscellaneous", "Auto-Buy: Secondary", get_names(secondary_weapons))
local buybot_gear = ui_new_multiselect("MISC", "Miscellaneous", "Auto-Buy: Gear", get_names(gear_weapons))

local function on_enabled_change()
	local enabled = ui_get(buybot_enabled)
	ui_set_visible(buybot_primary, enabled)
	ui_set_visible(buybot_pistol, enabled)
	ui_set_visible(buybot_gear, enabled)
end
on_enabled_change()
ui.set_callback(buybot_enabled, on_enabled_change)

local function run_buybot(e)
	local userid = e.userid
	if userid ~= nil then
		if client_userid_to_entindex(userid) ~= entity_get_local_player() then
			return
		end
	end

	if not ui_get(buybot_enabled) then
		return
	end

	local primary = ui_get(buybot_primary)
	local pistol = ui_get(buybot_pistol)
	local gear = ui_get(buybot_gear)

	local commands = {}

	table_insert(commands, get_command(primary_weapons, primary))
	table_insert(commands, get_command(secondary_weapons, pistol))
	
	for i=1, #gear do
		table_insert(commands, get_command(gear_weapons, gear[i]))
	end

	table_insert(commands, "use weapon_knife;")

	local command = table_concat(commands, "")
	client_console_cmd(command)
	--client_delay_call(delay, client_console_cmd, command)

end
if vali == true then
client.set_event_callback("paint", paint)
client.set_event_callback("run_command", runCommand) 
client.set_event_callback("paint_ui", handleGUI)
client_set_event_callback("player_spawn", run_buybot)
end