--[[
	id: Qb4xV6ZgFZSsgv5dBgPce
	name: Doomv4
	description: D4
	time1: 2021-06-29 20:04:13.226295+00
	time2: 2021-06-29 20:04:13.226296+00
	uploader: 843
	uploadersession: 6Nx4YZy4KJJl52BvAfNhUYKPY2atSc
	flag: f
--]]

local bit = require("bit")

local isAlpha = true

-- AA REFERENCES --
local aa_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled")
local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local freestanding_box, freestanding_key = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local leg_query = ui.reference("AA", "Other", "Leg movement")
local onshot_box, onshot_key = ui.reference("AA", "Other", "On shot anti-aim")
local slo_box, slo_key = ui.reference("AA", "Other", "Slow motion")
local jitter, jitter_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local bodyyaw, bodyyaw_slider = ui.reference("AA", "Anti-aimbot angles", "Body Yaw")
local peek_button, peek_hotkey = ui.reference("AA", "Other", "Fake peek")
local limit = ui.reference("AA", "Anti-aimbot angles", "Fake Yaw Limit")
local fake_lag_box, fl_key = ui.reference("AA", "Fake lag", "Enabled")
local fake_lag_limit = ui.reference("AA", "Fake lag", "Limit")
local fake_lag_amount = ui.reference("AA", "Fake lag", "Amount")
local fake_lag_variance = ui.reference("AA", "Fake lag", "Variance")
local freestanding_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")

-- RAGE REFERENCES -- 

local doubletap_button, doubletap_key = ui.reference("Rage", "Other", "Double tap")
local dtMode = ui.reference("Rage", "Other", "Double tap mode")
local damage_query = ui.reference("Rage", "Aimbot", "Minimum damage")
local duck_query = ui.reference("Rage", "Other", "Duck peek assist")
local quickPeek_box, quickPeek_key = ui.reference("Rage", "Other", "Quick peek assist")
local peek_box, peek_key = ui.reference("Rage", "Other", "Quick peek assist")

-- MISC REFERENCES -- 

local spike_box, spike_key ,spike_slider = ui.reference("Misc", "Miscellaneous", "Ping spike")
local gs_tag_reference = ui.reference("Misc", "Miscellaneous", "Clan tag spammer")
local cmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local hitboxes = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18}

-- LUA MENU -- 

ui.new_label("LUA", "B", " <-- [Doom] Anti Aim --> ")
ui.new_label("LUA", "B", "- - - -")
-- AA -- 
local enableDoomAA = ui.new_checkbox("LUA", "B", "[Doom] Enable Anti-Aim")
local antiBruteMode = ui.new_combobox("LUA", "B", "[AA] Anti-Brute Mode", {"Default", "Normalize"})
local betterHideShots = ui.new_checkbox("LUA", "B", "[AA] Better Hide Shots")
local maxDuckDelta = ui.new_checkbox("LUA", "B", "[AA] Max Delta on Crouch")
local slider_slowwalk = ui.new_slider("LUA", "B", "[AA] Slow Walk Speed", 1, 100, 100, true, "%")

ui.new_label("LUA", "B", " <-- [Doom] Ragebot -->")
ui.new_label("LUA", "B", "- - - -")
-- RAGEBOT- -
local enableDoomDT = ui.new_checkbox("LUA", "B", "[Doom] Enable Doubletap")
local enableDynamicDT = ui.new_checkbox("LUA", "B", "[DT] Dynamic Doubletap")
local doomDTmode = ui.new_combobox("LUA", "B", "[DT] Doubletap Mode", {"17 Tick", "18 Tick"})
local doomDTconsistency = ui.new_combobox("LUA", "B", "[DT] Doubletap Consistency", {"Consistent", "Faster"})
local enableIdealTick = ui.new_checkbox("LUA", "B", "[DT] Ideal DT Peek")

ui.new_label("LUA", "B", " <-- [Doom] Misc. -->")
ui.new_label("LUA", "B", "- - - -")
-- MISC -- 

local enableDoomClantag = ui.new_checkbox("LUA", "B", "[Doom] Clantag")



ui.set_visible(doomDTmode, false)

local alphaClantag = {'','d','d0','d00','do0','doo','doom', 'doom.','doom.a','doom.al','doom.alp',
                    'doom.alph', 'doom.alpha','doom.alph', 'doom.alp','doom.al','doom.a',
                    'doom.', 'doom', 'doo', 'do0', 'd00','d0o','doo','do','d',''}

local function doomTag()

    if ui.get(enableDoomClantag) then
        tagOn = true
    end

    if not ui.get(enableDoomClantag) and tagOn then
        client.set_clan_tag('')
        tagOn = false
    end
    
    ticks = globals.tickcount() / (#alphaClantag * 20)
    ticks = ticks - math.floor(ticks)

    stage = math.floor(ticks * #alphaClantag)

    if tagOn then
        if not (pStage == stage) then
            if isAlpha then
                client.set_clan_tag(alphaClantag[stage + 1])
            else
                client.set_clan_tag(alphaClantag[stage + 1])
            end
        end
    end

    pStage = stage

end

-- DYNAMIC VARS -- 

local aaState = 0
local bruteState = 0
local byaw_value = math.random(-100,-180)
local genVal     = math.random(0,180)
local normBruteSwitch = false
local lState = 1
local testState = 0
local doJitter = true
local currentDTMode = ''

local function setSpeed(newSpeed)
    if client.get_cvar("cl_sidespeed") == 450 and newSpeed == 450 then
        return
    end

    client.set_cvar("cl_sidespeed", newSpeed)
    client.set_cvar("cl_forwardspeed", newSpeed)
    client.set_cvar("cl_backspeed", newSpeed)
end

local function jitterManager()

    if doJitter then

        l = {math.random(-5,-10), math.random(20, 25)}

        jitterModes = {"Center"}

        if lState == #l then
            lState = 1
        end

        lState = lState + 1

        if not ui.get(slo_key) then

            ui.set(jitter_slider, l[lState])

            ui.set(jitter, jitterModes[math.random(1,#jitterModes)])

        else

            ui.set(jitter_slider, 2)

            ui.set(jitter, jitterModes[1])

        end

    end

    client.delay_call(0, jitterManager)

end

local function weaponFire(e)

    weapon = e.weapon
    userID = e.userid
    userID = client.userid_to_entindex(userID)
    localPlayer = entity.get_local_player()

    if(weapon == "weapon_flashbang" or weapon == "weapon_decoy" or weapon == "weapon_taser" or weapon == "weapon_knife" or weapon == "weapon_knife_t" or weapon == "weapon_hegrenade" or weapon == "weapon_incgrenade" or weapon == "weapon_molotov" or weapon == "weapon_smokegrenade") then
        return
    end

    if entity.is_alive(localPlayer) then

        if entity.is_enemy(userID) then

            if entity.is_alive(userID) then

                if not entity.is_dormant(userID) then

                    if bruteState > 3 then

                        bruteState = 0

                    end

                    bruteState      = bruteState + 1
                    if genVal > 0 then
                        byaw_value      = math.random(-180,-100)
                        genVal          = math.random(100,180)
                    else
                        byaw_value      = math.random(180,100)
                        genVal          = math.random(-100,-180)
                    end
                    normBruteSwitch = true

                end
            end
        end
    end

end

local function roundStart(e)

    bruteState      = 0

end

local function legAA()

    if math.random(0,100) <= 20 then
        ui.set(leg_query, "Always slide")

    else
        ui.set(leg_query, "Never slide")
        
    end

end

local function resetFunc()

    if ui.get(betterHideShots) then
        ui.set(fake_lag_box, true)
    end

    client.delay_call(((globals.chokedcommands()) / 1000), resetFunc)

end
local function doAntiBrute()

    if entity.get_local_player() == nil then return end

    ui.set(bodyyaw, 'Static')

    if ui.get(antiBruteMode) == 'Default' then
        if bruteState == 0 then
            ui.set(bodyyaw_slider, 25)
        
        elseif bruteState == 1 then
            ui.set(bodyyaw_slider, 5)

        elseif bruteState == 2 then
            ui.set(bodyyaw_slider, 15)

        else
            ui.set(bodyyaw_slider, 0)

        end
    end

    if bruteState < 3 then
        genVal = math.random(100,180)
    else
        genVal = math.random(-100,-180)
    end
    

    if normBruteSwitch and ui.get(antiBruteMode) == 'Normalize' then

        if genVal < 0 then
            byaw_value = byaw_value - 1

            if byaw_value <= genVal then
                normBruteSwitch = false
                byaw_value = genVal
            end
        else
            byaw_value = byaw_value + 1

            if byaw_value >= genVal then
                normBruteSwitch = false
                byaw_value = genVal
            end
        end

    end

    if not normBruteSwitch then
        byaw_value = genVal
    end

    ui.set(bodyyaw_slider, byaw_value)

end

local function otherAA()

    if ui.get(slo_key) then

        if aaState == 1 then
            idealLimit = math.random(30,33)

            ui.set(limit, idealLimit)
        elseif aaState == 2 then
            idealLimit = math.random(35,38)

            ui.set(limit, idealLimit)

        end

    else

        if aaState == 0 then
            idealLimit = 55
            ui.set(limit, idealLimit)

        else
            idealLimit = math.random(58,59)
            ui.set(limit, idealLimit)

        end

    end

end


local function autoAA()

    if ui.get(slo_key) then

        if aaState == 1 then
            idealLimit = math.random(31,34)

            ui.set(limit, idealLimit)
        elseif aaState == 2 then
            idealLimit = math.random(24,27)

            ui.set(limit, idealLimit)

        end

    else

        if aaState == 0 then
            idealLimit = 55
            ui.set(limit, idealLimit)

        else
            idealLimit = math.random(58,59)
            ui.set(limit, idealLimit)

        end

    end

end

local function bestAA()

    if not ui.get(enableDoomAA) then return client.delay_call(0, bestAA) end

    if entity.get_local_player() == nil then return client.delay_call(0, bestAA) end

    doJitter = true

    if (ui.get(maxDuckDelta)) and (entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.5) then
        ui.set(bodyyaw_slider, 176)
        ui.set(limit, 60)
        ui.set(jitter, "Off")
        doJitter = false
        return client.delay_call(0, bestAA)
    end

    if aaState >= 3 then
        aaState = 0
    end

    ui.set(yaw, 180)
    ui.set(pitch, 'Minimal')

    if not entity.is_alive(entity.get_local_player()) then return client.delay_call(0, bestAA) end

    local localWeapon = entity.get_esp_data(entity.get_local_player()).weapon_id

    if localWeapon == nil then return client.delay_call(0, bestAA) end

    if localWeapon == 38 or localWeapon == 11 then
        autoAA()
    else
        otherAA()
    end

    aaState = aaState + 1

    client.delay_call(((globals.chokedcommands() * 20) / 1000), legAA)
    client.delay_call(((globals.chokedcommands() * 18) / 1000), bestAA)

end

client.set_event_callback("setup_command",function(e)

    if aaState == 0 then

        e.allow_send_packet = false

    else

        e.allow_send_packet = true

    end

    local weaponn = entity.get_player_weapon()
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

end)

local function checkMenuVisibility()

    -- RESET VISIBILITY -- 
    -- AA --
    ui.set_visible(maxDuckDelta, false)
    ui.set_visible(betterHideShots, false)
    ui.set_visible(antiBruteMode, false)

    -- RAGEBOT -- 
    ui.set_visible(doomDTmode, false)
    ui.set_visible(enableDynamicDT, false)
    ui.set_visible(doomDTconsistency, false)
    ui.set_visible(enableIdealTick, false)

    if ui.get(enableDoomAA) then
        ui.set_visible(maxDuckDelta, true)
        ui.set_visible(betterHideShots, true)
        ui.set_visible(antiBruteMode, true)

    end

    if ui.get(enableDoomDT) then

        ui.set_visible(doomDTmode, true)
        ui.set_visible(enableDynamicDT, true)
        ui.set_visible(doomDTconsistency, true)
        ui.set_visible(enableIdealTick, true)

    end

    if ui.get(enableDynamicDT) then

        ui.set_visible(doomDTmode, false)

    end


end

local function doomDT()

    cvar.sv_maxusrcmdprocessticks:set_int(16)
    local local_player = entity.get_local_player()
    if not entity.is_alive(local_player) then return end

    local vx, vy, vz = entity.get_prop(local_player, "m_vecVelocity")
    local cur_speed = math.floor(math.sqrt((vx * vx) + (vy * vy))+0.5)

    if not ui.get(enableDoomDT) then return end

    if ui.get(doomDTconsistency) == 'Consistent' then

        dtBinary = 1
    else

        dtBinary = 0
    end

    -- DYNAMIC DT -- 

    if not ui.get(enableDynamicDT) then

        if cur_speed < 100 then

            ui.set(ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"), cvar.sv_maxusrcmdprocessticks:get_int() + 2)
            cvar.cl_clock_correction:set_int(dtBinary)
            ui.set(dtMode, 'Offensive')

            dynamicType = 'Instant'

            slowalking = true

        elseif cur_speed > 100 and cur_speed < 135 then

            ui.set(ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"), cvar.sv_maxusrcmdprocessticks:get_int() + 1)
            cvar.cl_clock_correction:set_int(dtBinary)
            ui.set(dtMode, 'Offensive')

            dynamicType = 'Ideal'

            walking = true

        elseif cur_speed > 135 then

            ui.set(ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"), cvar.sv_maxusrcmdprocessticks:get_int())
            cvar.cl_clock_correction:set_int(dtBinary)
            ui.set(dtMode, 'Offensive')

            dynamicType = 'Aggressive'

            running = true

        end
        return
    end

    -- STATIC DT -- 

    if ui.get(doomDTmode) == '17 Tick' then

        ui.set(ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"), cvar.sv_maxusrcmdprocessticks:get_int() + 1)
        cvar.cl_clock_correction:set_int(dtBinary)
        ui.set(dtMode, 'Offensive')

    return end

    ui.set(ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"), cvar.sv_maxusrcmdprocessticks:get_int() + 2)
    cvar.cl_clock_correction:set_int(dtBinary)
    ui.set(dtMode, 'Offensive')

end

local function idealTick()

    if restoreFreestanding then

        ui.set(freestanding_box, '')

    end

    restoreFreestanding = false

    if not entity.is_alive(entity.get_local_player()) then return end

    local localWeapon = entity.get_esp_data(entity.get_local_player()).weapon_id

    if localWeapon == nil then return end

    if localWeapon == 40 then

        if ui.get(quickPeek_key) then

            if ui.get(doubletap_key) then

                print(ui.set(freestanding_box, 'Default'))
                ui.set(freestanding_key, 'Always on')

                restoreFreestanding = true

            end

        end

    end

end

local function doHideShots()

    if ui.get(betterHideShots) then

        ui.set(fake_lag_box, false)

    end

end

local function main()

    checkMenuVisibility()
    doomTag()
    doAntiBrute()

    if ui.get(enableIdealTick) then
        idealTick()
    end

end

client.delay_call(0, bestAA)
client.delay_call(0, resetFunc)
client.delay_call(0, jitterManager)
client.set_event_callback("aim_fire", doHideShots)
client.set_event_callback("weapon_fire", weaponFire)
client.set_event_callback("player_death", roundStart)
client.set_event_callback("round_poststart", roundStart)
client.set_event_callback("setup_command", doomDT)
client.set_event_callback("paint", main)

client.set_event_callback("run_command", function()
    
    if not ui.get(slo_key) then
        setSpeed(450)
    else
        local final_val = 250 * ui.get(slider_slowwalk) / 100
        setSpeed(final_val)
    end
end)