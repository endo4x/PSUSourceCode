--[[
	id: IZUtvTQMU3D1eR3jDfusS
	name: new weapons
	description: 123
	time1: 2021-05-20 08:04:00.742189+00
	time2: 2021-05-20 08:04:00.742189+00
	uploader: 4539
	uploadersession: Lrnvh5BkzLajMPyH6uMYJFFiiKHob-
	flag: f
--]]

local targetSelection = ui.reference("RAGE", "Aimbot", "Target selection")
local targetHitbox = ui.reference("RAGE", "Aimbot", "Target hitbox")
local multiPoint = {ui.reference("RAGE", "Aimbot", "Multi-point")}
local multiPointScale = ui.reference("RAGE", "Aimbot", "Multi-point scale")
local force_safe_hitbox = ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes")
local preferSafePoint = ui.reference("RAGE", "Aimbot", "Prefer safe point")
local forceSafePoint = ui.reference("RAGE", "Aimbot", "Force safe point")
local automaticFire = ui.reference("RAGE", "Aimbot", "Automatic fire")
local automaticWall = ui.reference("RAGE", "Aimbot", "Automatic penetration")
local slientAim = ui.reference("RAGE", "Aimbot", "Silent aim")
local minimumHC = ui.reference("RAGE", "Aimbot", "Minimum hit chance")
local minimumMD = ui.reference("RAGE", "Aimbot", "Minimum damage")
local autoScope = ui.reference("RAGE", "Aimbot", "Automatic scope")
local reduceAimStep = ui.reference("RAGE", "Aimbot", "Reduce aim step")
local maxFOV = ui.reference("RAGE", "Aimbot", "Maximum FOV")
local logMissesDueToSpread = ui.reference("RAGE", "Aimbot", "Log misses due to spread")
local removeRecoil = ui.reference("RAGE", "Other", "Remove recoil")
local delayShot = ui.reference("RAGE", "Other", "Delay shot")
local quickStop = {ui.reference("RAGE", "Other", "Quick stop")}
local quickStopOptions = ui.reference("RAGE", "Other", "Quick stop options")
local quickPeekAssist = {ui.reference("RAGE", "Other", "Quick peek assist")}
local quickPeekAssistColor = ui.reference("RAGE", "Other", "Quick peek assist display")
local resolver = ui.reference("RAGE", "Other", "Anti-aim correction")
local resolverOverride = ui.reference("RAGE", "Other", "Anti-aim correction override")
local preferBodyAim = {ui.reference("RAGE", "Other", "Prefer body aim"), ui.reference("RAGE", "Other", "Prefer body aim disablers")}
local forceBodyAim = ui.reference("RAGE", "Other", "Force body aim")
local forceBodyAimPeek = ui.reference("RAGE", "Other", "Force body aim on peek")
local doubleTaps = {ui.reference("RAGE", "Other", "Double tap")}
local doubleTapsOptions = ui.reference("RAGE", "Other", "Double tap mode")
local doubleTapsHitChance = ui.reference("RAGE", "Other", "Double tap hit chance")
local doubleTapsFL = ui.reference("RAGE", "Other", "Double tap fake lag limit")
local doubleTapsQS = ui.reference("RAGE", "Other", "Double tap quick stop")
local accuracyBoost = ui.reference("RAGE", "Other", "Accuracy boost")
local duckPeekAssist = ui.reference("RAGE", "Other", "Duck peek assist")
local lowFpsThing = ui.reference("RAGE", "Aimbot", "Low FPS mitigations")
local aimItrems = {targetSelection, targetHitbox, multiPoint[1], multiPoint[2], multiPoint[3], multiPointScale, preferSafePoint, forceSafePoint, lowFpsThing, automaticFire, automaticWall, slientAim, minimumHC, minimumMD, autoScope, reduceAimStep, maxFOV, logMissesDueToSpread} 
local otheItems = {removeRecoil, quickStop[1], quickStop[2], quickStopOptions, quickPeekAssist[1], quickPeekAssist[2], quickPeekAssistColor, resolver, resolverOverride, preferBodyAim[1], preferBodyAim[2], forceBodyAim, forceBodyAimPeek, doubleTaps[1], doubleTaps[2], doubleTapsOptions, doubleTapsHitChance, doubleTapsFL, doubleTapsQS}
local lp = entity.get_local_player
local screen = {client.screen_size()}
local center = {screen[1]/2, screen[2]/2}

local function includes(table, key)
    for i=1, #table do
        if table[i] == key then
            return true, i
        end
    end
    return false, nil
end

local function multi_select(tab, val)
	for index, value in ipairs(ui.get(tab)) do
		if value == val then
			return true
		end
	end

	return false
end

local function setVis(table, state)
    for i=1, #table do
        ui.set_visible(table[i], state)
    end
end

local weaponNames = {"Global", "Auto", "Scout", "Awp", "Heavy pistol", "Pistol", "Submachine gun", "Shotguns", "Taser"}
local weaponClasses = {{nil}, {"CWeaponG3SG1", "CWeaponSCAR20"}, {"CWeaponSSG08"}, {"CWeaponAWP"}, {"CDEagle"}, {"CWeaponHKP2000", "CWeaponGlock", "CWeaponFiveSeven", "CWeaponElite", "CWeaponTec9", "CWeaponP250"}, {"CWeaponMAC10", "CWeaponMP7", "CWeaponUMP45", "CWeaponP90", "CWeaponBizon", "CWeaponMP9"}, {"CWeaponNOVA", "CWeaponXM1014", "CWeaponMag7", "CWeaponSawedoff"}, {"CWeaponTaser"}}
local damageIdx  = { [0] = "Auto", [101] = "HP + 1", [102] = "HP + 2", [103] = "HP + 3", [104] = "HP + 4", [105] = "HP + 5", [106] = "HP + 6", [107] = "HP + 7", [108] = "HP + 8", [109] = "HP + 9", [110] = "HP + 10", [111] = "HP + 11", [112] = "HP + 12", [113] = "HP + 13", [114] = "HP + 14", [115] = "HP + 15", [116] = "HP + 16", [117] = "HP + 17", [118] = "HP + 18", [119] = "HP + 19", [120] = "HP + 20", [121] = "HP + 21", [122] = "HP + 22", [123] = "HP + 23", [124] = "HP + 24", [125] = "HP + 25", [126] = "HP + 26" }

local weapons = {}

local menuPos = {"Rage", "Other"}

local branding = ui.new_label(menuPos[1], menuPos[2], "404 project adaptive weapons")
local currentWeapon = ui.new_combobox(menuPos[1], menuPos[2], "Weapon", weaponNames)

for i=1, #weaponNames do
    local name = weaponNames[i]
    weapons[i] = {
        weapon = name,
        enable = ui.new_checkbox(menuPos[1], menuPos[2], "Enable " .. name .. " config"),
        targetselect = ui.new_combobox(menuPos[1], menuPos[2], "Target selection \n " .. name, {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}),
        targethitbox = ui.new_multiselect(menuPos[1], menuPos[2], "Target hitbox \n " .. name, {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        multipoint = ui.new_multiselect(menuPos[1], menuPos[2], "Multi-point \n " .. name, {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        multipointmode = ui.new_combobox(menuPos[1], menuPos[2], "\n Multi-point " .. name, {"Low", "Medium", "High"}),
        multipointscale = ui.new_slider(menuPos[1], menuPos[2], "Multi-point scale \n" .. name, 24, 100, ui.get(multiPointScale), true, "%", 1, {[24] = "Auto"}),
        unsafe = ui.new_multiselect(menuPos[1], menuPos[2], "Avoid unsafe hitboxes \n " .. name, {"Head", "Chest", "Stomach", "Arms", "Legs"}),
        accboost = ui.new_combobox(menuPos[1], menuPos[2], "Accuracy boost \n" .. name, {"Maximum", "High", "Medium", "Low", "Off"}),
        prefersafe = ui.new_checkbox(menuPos[1], menuPos[2], "Prefer safe point \n " .. name),
        forcesafe = ui.new_hotkey(menuPos[1], menuPos[2], "Force safe point \n" .. name), 
        hitchance = ui.new_slider(menuPos[1], menuPos[2], "Hit chance \n" .. name, 0, 100, 75, true, "%"),
        mindmg = ui.new_slider(menuPos[1], menuPos[2], "Minimum damage \n" .. name, 0, 126, 35, true, "", 1, damageIdx),
        special = ui.new_multiselect(menuPos[1], menuPos[2], "Extras \n" .. name, {"No-scope hit chance", "In-air hit chance", "In-air damage", "Visible minimum damage", "DT minimum damage", "DT hit chance", "Hotkey minimum damage", "Hitbox override"}),
        noscope = ui.new_slider(menuPos[1], menuPos[2], "No-scope hit chance \n" .. name, 0, 100, 50, true, "%"),
        noscopeRange = ui.new_slider(menuPos[1], menuPos[2], "Max no-scope distance \n" .. name, 10, 101, 75, true, "ft", 1, {[101] = "nolimit"}),
        inair = ui.new_slider(menuPos[1], menuPos[2], "In-air hit chance \n" .. name, 0, 100, 25, true, "%"),
        dthitchance = ui.new_slider(menuPos[1], menuPos[2], "DT hit chance \n" .. name, 0, 100, 60, true, "%"),
        inairdmg = ui.new_slider(menuPos[1], menuPos[2], "In-air minimum damage \n" .. name, 0, 126, 25, true, "", 1, damageIdx),
        vismindmg = ui.new_slider(menuPos[1], menuPos[2], "Visible minimum damage \n" .. name, 0, 126, 25, true, "", 1, damageIdx),
        dtmindmg = ui.new_slider(menuPos[1], menuPos[2], "DT minimum damage \n" .. name, 0, 126, 45, true, "", 1, damageIdx),
        hkmindmg = ui.new_slider(menuPos[1], menuPos[2], "Hotkey minimum damage \n" .. name, 0, 126, 10, true, "", 1, damageIdx),
        hk = ui.new_hotkey(menuPos[1], menuPos[2], "Hotkey \n minimum damage " .. name, true),
        hktargethitbox = ui.new_multiselect(menuPos[1], menuPos[2], "Hitbox override \n " .. name, {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
        hktarget = ui.new_hotkey(menuPos[1], menuPos[2], "Hotkey \n target hitbox damage " .. name, true),
        quickstop = ui.new_checkbox(menuPos[1], menuPos[2], "Quick stop \n" .. name),
        quickstopKey = ui.new_hotkey(menuPos[1], menuPos[2], "Quick stop key \n" .. name, true),
        quickstopOptions = ui.new_multiselect(menuPos[1], menuPos[2], "Quick stop optons \n" .. name, {"Early", "Slow motion", "Duck", "Fake duck", "Move between shots", "Ignore molotov", "Taser"}),
        doubletapStopOptions = ui.new_multiselect(menuPos[1], menuPos[2], "Double tap quick stop \n" .. name, {"Slow motion", "Duck", "Move between shots"}),
        preferbody = ui.new_checkbox(menuPos[1], menuPos[2], "Prefer body aim \n" .. name),
        preferbodyDisablers = ui.new_multiselect(menuPos[1], menuPos[2], "Prefer body aim disablers \n" .. name, {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage"}),
        delayshot = ui.new_checkbox(menuPos[1], menuPos[2], "Delay shot \n" .. name), 
        delayshotkey = ui.new_hotkey(menuPos[1], menuPos[2], "Delay shot key \n" .. name, true),
        forceBody = ui.new_multiselect(menuPos[1], menuPos[2], "Force body aim conditions \n" .. name, {"Always on", "Peek", "DT", "Hotkey"}),
        forcebodyhk = ui.new_hotkey(menuPos[1], menuPos[2], "Force body aim hotkey \n" .. name, true)

    }
end

local indicators = ui.new_checkbox(menuPos[1], menuPos[2], "Indicators")
local indicators_sel = ui.new_multiselect(menuPos[1], menuPos[2], "Indicator mode", "Crosshair damage", "Minimum damage", "Minimum hitchance", "Crosshair hitchance", "Crosshair mix")
local color = ui.new_color_picker(menuPos[1], menuPos[2], "Indicators color", 75, 75, 255, 255)

local function handleVis()
    for i=1, #weapons do
        local state = weapons[i].weapon == ui.get(currentWeapon)
        if weapons[i].weapon == weaponNames[1] then
            ui.set_visible(weapons[i].enable, false)    
            ui.set(weapons[i].enable, true)
        else
            ui.set_visible(weapons[i].enable, state)
        end
        
        local actualState = ui.get(weapons[i].enable) and state
        ui.set_visible(weapons[i].targetselect, actualState)
        ui.set_visible(weapons[i].targethitbox, actualState)
        ui.set_visible(weapons[i].multipoint, actualState)
        ui.set_visible(weapons[i].multipointmode, actualState and #ui.get(weapons[i].multipoint) ~= 0)
        ui.set_visible(weapons[i].multipointscale, actualState and #ui.get(weapons[i].multipoint) ~= 0)
        ui.set_visible(weapons[i].unsafe, actualState)
        ui.set_visible(weapons[i].prefersafe, actualState)
        ui.set_visible(weapons[i].forcesafe, actualState)
        ui.set_visible(weapons[i].hitchance, actualState)
        ui.set_visible(weapons[i].mindmg, actualState)
        ui.set_visible(weapons[i].special, actualState)
        ui.set_visible(weapons[i].noscope, actualState and includes(ui.get(weapons[i].special), "No-scope hit chance"))
        ui.set_visible(weapons[i].noscopeRange, actualState and includes(ui.get(weapons[i].special), "No-scope hit chance"))
        ui.set_visible(weapons[i].inair, actualState and includes(ui.get(weapons[i].special), "In-air hit chance"))
        ui.set_visible(weapons[i].dthitchance, actualState and includes(ui.get(weapons[i].special), "DT hit chance"))
        ui.set_visible(weapons[i].inairdmg, actualState and includes(ui.get(weapons[i].special), "In-air damage"))
        ui.set_visible(weapons[i].vismindmg, actualState and includes(ui.get(weapons[i].special), "Visible minimum damage"))
        ui.set_visible(weapons[i].dtmindmg, actualState and includes(ui.get(weapons[i].special), "DT minimum damage"))
        ui.set_visible(weapons[i].hk, actualState and includes(ui.get(weapons[i].special), "Hotkey minimum damage"))
        ui.set_visible(weapons[i].hkmindmg, actualState and includes(ui.get(weapons[i].special), "Hotkey minimum damage"))
        ui.set_visible(weapons[i].hktargethitbox, actualState and includes(ui.get(weapons[i].special), "Hitbox override"))
        ui.set_visible(weapons[i].hktarget, actualState and includes(ui.get(weapons[i].special), "Hitbox override"))
        ui.set_visible(weapons[i].quickstop, actualState)
        ui.set_visible(weapons[i].quickstopKey, actualState and ui.get(weapons[i].quickstop))
        ui.set_visible(weapons[i].quickstopOptions, actualState and ui.get(weapons[i].quickstop))
        ui.set_visible(weapons[i].doubletapStopOptions, actualState and ui.get(weapons[i].quickstop))
        ui.set_visible(weapons[i].preferbody, actualState and (includes(ui.get(weapons[i].targethitbox), "Chest") or includes(ui.get(weapons[i].targethitbox), "Stomach")))
        ui.set_visible(weapons[i].preferbodyDisablers, actualState and ui.get(weapons[i].preferbody) and (includes(ui.get(weapons[i].targethitbox), "Chest") or includes(ui.get(weapons[i].targethitbox), "Stomach")))
        ui.set_visible(weapons[i].forceBody, actualState)
        ui.set_visible(weapons[i].forcebodyhk, actualState and includes(ui.get(weapons[i].forceBody), "Hotkey"))
        ui.set_visible(weapons[i].delayshot, actualState)
        ui.set_visible(weapons[i].delayshotkey, actualState and ui.get(weapons[i].delayshot))
        ui.set_visible(weapons[i].accboost, actualState)
    end
    ui.set_visible(color, ui.get(indicators))
    ui.set_visible(indicators_sel, ui.get(indicators))
end
local activeConfig = "Global"
local oldActiveWeapon = "Global"

local function isVisible(lpOrigin, ent)
    if ent == nil or entity.is_alive(ent) == false or lp() == nil or entity.is_alive(lp()) == false then
        return false
    end

    if lpOrigin[1] == nil then
        return false
    end

    for i=1, 18 do
        local target = {entity.hitbox_position(ent, i)}

        if target[1] == nil then
            return false
        end

        local trace = {client.trace_line(lp(), lpOrigin[1], lpOrigin[2], lpOrigin[3], target[1], target[2], target[3])}

        if trace[2] == ent then
            return true
        end
    end
    return false
end

local normalPreferBaims = {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage"}

local function normalize_yaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end
    return yaw
end

local function calc_angle(localplayerxpos, localplayerypos, enemyxpos, enemyypos)
	local ydelta = localplayerypos - enemyypos
	local xdelta = localplayerxpos - enemyxpos
    local relativeyaw = math.atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
    return relativeyaw
end

local function getDistance(from, to)
    local delta = {from[1] - to[1], from[2] - to[2]}
    return math.sqrt(delta[1] * delta[1] + delta[2] * delta[2])
end

local function convertToFeet(units)
    units = units * 0.0254 --Meters
    return units * 3.281
end

local function getClosestTarget()
    local enemies = entity.get_players(true)

    local closest = nil
    local distance = math.huge

    for i=1, #enemies do
        local origin = {entity.get_origin(lp())}
        local eOrigin = {entity.get_origin(enemies[i])}
        if origin[1] ~= nil and eOrigin[1] ~= nil then
            local dist = getDistance(origin, eOrigin)
            if dist < distance then
                distance = dist
                closest = enemies[i]
            end
        end
    end
    if closest ~= nil then
        return closest, convertToFeet(distance)
    else
        return nil, 0
    end
end

local function calculate_angle(x, y, ex, ey)
    local delta = {x - ex, y - ey}
    local yaw = math.atan(delta[2] / delta[1])
    yaw = normalize_yaw(yaw * 180 / math.pi)
    if delta[1] >= 0 then
        yaw = normalize_yaw(yaw + 180)
    end
    return yaw
end

local function vec3_angles(source, destination)
    local vec3_delta = {
        source[1] - destination[1],
        source[2] - destination[2],
        source[3] - destination[3],
    }

    local distances = math.sqrt(vec3_delta[1] * vec3_delta[1] + vec3_delta[2] * vec3_delta[2])

    local angle_pitch = math.atan(vec3_delta[2]/distances) * (180/math.pi)
    local angle_yaw = math.atan(vec3_delta[2]/vec3_delta[1]) * (180/math.pi)

    if vec3_delta[1] > 0 then
        angle_yaw = angle_yaw + 180
    end

    return {angle_pitch, angle_yaw}
end

local oldSimTime = 0
local shiftTicks = 0

local function netUpdateEnd()
    if lp() == nil or entity.is_alive(lp()) == false then
        return
    end

    local tickInt = globals.tickinterval()
    local tickCount = globals.tickcount()

    local simTime = entity.get_prop(lp(), "m_flSimulationTime") or 0

    if simTime == nil then
        return
    end

    if simTime ~= oldSimTime then
        shiftTicks = (simTime/tickInt) - tickCount
        oldSimTime = simTime
    end
end

local function clamp(min, max, value)
    if min < max then
        return math.max(min, math.min(max, value))
    else
        return math.max(max, math.min(min, value))
    end
end

local function predict(origin, player, amount, limit)
    local head = origin
    local vec = {entity.get_prop(player, "m_vecVelocity")}
    local clamped_vec = {clamp(-limit, limit, vec[1]), clamp(-limit, limit, vec[2]), clamp(-limit, limit, vec[3])}
    return {head[1] + clamped_vec[1] * amount, head[2] + clamped_vec[2] * amount, head[3]}
end


local function handleWeapons()
    if lp() == nil and entity.is_alive(lp()) == false then
        return
    end

    local weapon = entity.get_player_weapon(lp())
    if weapon == nil then
        return
    end

    local classWeapon = entity.get_classname(weapon)
    if classWeapon == nil then
        return
    end

    local weaponIdx = nil

    --Search through weapons to see if they're being held and enabled in the menu, if the item thats being held is not enabled then it will use global settings
    for i=2, #weaponClasses do
        local weaponClass = weaponClasses[i]

        if ui.get(weapons[i].enable) then
            for w=1, #weaponClass do
                if weaponClass[w] == classWeapon then
                    weaponIdx = i
                    break
                end
            end
        end

        if weaponIdx == i then --We have already found what weapon we're using no need to keep cycling
            break
        end
    end

    --Set to nil to global config
    activeConfig = weaponNames[weaponIdx == nil and 1 or weaponIdx]

    if activeConfig ~= oldActiveWeapon then
        ui.set(currentWeapon, activeConfig)
        oldActiveWeapon = activeConfig
    end

    local contains, i = includes(weaponNames, activeConfig)
    if contains then
        ui.set(targetSelection, ui.get(weapons[i].targetselect))
        if includes(ui.get(weapons[i].special), "Hitbox override") then
            if ui.get(weapons[i].hktarget) then
                ui.set(targetHitbox, #ui.get(weapons[i].hktargethitbox) == 0 and {"Head"} or ui.get(weapons[i].hktargethitbox))
            else
                ui.set(targetHitbox, #ui.get(weapons[i].targethitbox) == 0 and {"Head"} or ui.get(weapons[i].targethitbox))
            end
        else
            ui.set(targetHitbox, #ui.get(weapons[i].targethitbox) == 0 and {"Head"} or ui.get(weapons[i].targethitbox))
        end
        ui.set(multiPoint[1], #ui.get(weapons[i].multipoint) == 0 and {} or ui.get(weapons[i].multipoint))
        ui.set(multiPoint[3], ui.get(weapons[i].multipointmode))
        ui.set(multiPointScale, ui.get(weapons[i].multipointscale))
        ui.set(preferSafePoint, ui.get(weapons[i].prefersafe))

        local to_set_hc = ui.get(weapons[i].hitchance)

        --No scope hit chance
        if includes(ui.get(weapons[i].special), "No-scope hit chance") then
            local weaponidxs = {11,38,9,40}
            local weapon = entity.get_player_weapon(lp())
            if weapon ~= nil then
                local weapon_idx = entity.get_prop(weapon, "m_iItemDefinitionIndex") or 0
                local scoped = includes(weaponidxs, weapon_idx) and (entity.get_prop(lp(), "m_bIsScoped") or 0) == 1

                local target, distance = getClosestTarget()
                local range = ui.get(weapons[i].noscopeRange) ~= 101 and ui.get(weapons[i].noscopeRange) or math.huge

                if not scoped and range >= distance then
                    ui.set(autoScope, false)
                    to_set_hc = ui.get(weapons[i].noscope)
                else
                    ui.set(autoScope, true)
                end
            end
        else
            ui.set(autoScope, true)
        end

        --In air
        if includes(ui.get(weapons[i].special), "In-air hit chance") then
            local air = bit.band(entity.get_prop(lp(), "m_fFlags") or 0, 1) == 0
            if air then
                to_set_hc = ui.get(weapons[i].inair)
            end
        end

 
        --Set HC
        ui.set(minimumHC, to_set_hc)

        --Double tap hit chance is just the menu item
        if includes(ui.get(weapons[i].special), "DT hit chance") then
            ui.set(doubleTapsHitChance, ui.get(weapons[i].dthitchance))
        end

        local to_set_md = ui.get(weapons[i].mindmg)
        if includes(ui.get(weapons[i].special), "Visible minimum damage") then
            --Time to search through all enemies to see if they're visible
            local enemies = entity.get_players(true)
            local origin = {client.eye_position()}
            local predictive_origin = predict(origin, lp(), 1, 35)
            --Found enemy visible 
            for e=1, #enemies do
                if isVisible(origin, enemies[e]) or isVisible(predictive_origin, enemies[e]) then
                    to_set_md = ui.get(weapons[i].vismindmg) 
                    break
                end
            end
        end

        --Double tap override
        if includes(ui.get(weapons[i].special), "DT minimum damage") then
            local weapon = entity.get_player_weapon(lp())
            local nextFire = math.max(entity.get_prop(weapon, "m_flNextPrimaryAttack") or 0, entity.get_prop(lp(), "m_flNextAttack") or 0)
            if shiftTicks < 0 and nextFire < globals.curtime() and globals.chokedcommands() <= ui.get(doubleTapsFL) then
                to_set_md = ui.get(weapons[i].dtmindmg)
            end
        end

        if includes(ui.get(weapons[i].special), "In-air damage") then
            local air = bit.band(entity.get_prop(lp(), "m_fFlags") or 0, 1) == 0
            if air then
                to_set_md = ui.get(weapons[i].inairdmg)
            end
        end
        
        --Hotkey
        if includes(ui.get(weapons[i].special), "Hotkey minimum damage") then
            if ui.get(weapons[i].hk) then
                to_set_md = ui.get(weapons[i].hkmindmg)
            end
        end



        --Set md
        ui.set(minimumMD, to_set_md)

        --Set outstop
        ui.set(quickStop[1], ui.get(weapons[i].quickstop) and ui.get(weapons[i].quickstopKey))
        ui.set(weapons[i].quickstopKey, "Always on")
        ui.set(quickStopOptions, ui.get(weapons[i].quickstopOptions))
        ui.set(doubleTapsQS, ui.get(weapons[i].quickstop) and ui.get(weapons[i].doubletapStopOptions) or {})

        --Handle prefer body aim
        ui.set(preferBodyAim[1], ui.get(weapons[i].preferbody))

        --Run disablers
        ui.set(preferBodyAim[2], ui.get(weapons[i].preferbodyDisablers))

        local shouldFBaim = false

        --Always on
        if includes(ui.get(weapons[i].forceBody), "Always on") then
            shouldFBaim = true
        end

        --Force body aim on peek is already a feature so we just set it here
        ui.set(forceBodyAimPeek, includes(ui.get(weapons[i].forceBody), "Peek"))

        --Force body aim on first double tap
        if includes(ui.get(weapons[i].forceBody), "DT") then
            local weapon = entity.get_player_weapon(lp())
            local nextFire = math.max(entity.get_prop(weapon, "m_flNextPrimaryAttack") or 0, entity.get_prop(lp(), "m_flNextAttack") or 0)
            if shiftTicks < 0 and nextFire < globals.curtime() and globals.chokedcommands() <= ui.get(doubleTapsFL) then
                shouldFBaim = true
            end
        end

        --On hotkey
        if includes(ui.get(weapons[i].forceBody), "Hotkey") then
            if ui.get(weapons[i].forcebodyhk) then
                shouldFBaim = true
            end
        end

        --Set
        ui.set(forceBodyAim, shouldFBaim and "Always on" or "On hotkey")
        ui.set(force_safe_hitbox,ui.get(weapons[i].unsafe))
        ui.set(delayShot, ui.get(weapons[i].delayshot) and ui.get(weapons[i].delayshotkey))
        ui.set(accuracyBoost, ui.get(weapons[i].accboost))
    end
end

client.set_event_callback("paint", function(e)
    local client_screen_size = client.screen_size
	local w, h = client_screen_size()
    local r, g, b, a = ui.get(color)
    local h_index = 0
    if not entity.is_alive(entity.get_local_player()) then
		return
	end
    local md = ui.get(minimumMD)
    local hc = ui.get(minimumHC)
    if damageIdx[md] ~= nil then
        md = damageIdx[md]
    end
    if ui.get(indicators) then
        if multi_select(indicators_sel, "Minimum damage") then
            --Debug indicators
            renderer.indicator(r, g, b, a , "DMG->" .. md)
        end
        if multi_select(indicators_sel, "Minimum hitchance") then
            --Debug indicators
            renderer.indicator(r, g, b, a , "HC->" .. hc)
        end
        local client_screen_size = client.screen_size
        local w, h = client_screen_size()
        if multi_select(indicators_sel, "Crosshair damage") then
            renderer.text(w / 2 , h / 2+25 + (h_index * 12), r, g, b, a , "cb",0, "DMG->" .. md)
            h_index = h_index + 1
        end
        if multi_select(indicators_sel, "Crosshair hitchance") then
            renderer.text(w / 2 , h / 2+25 + (h_index * 12), r, g, b, a , "cb",0, "HC->" .. hc)
            h_index = h_index + 1
        end
        if multi_select(indicators_sel, "Crosshair mix") then
            renderer.text(w / 2 , h / 2+25 + (h_index * 12), r, g, b, a , "cb",0, "D:" .. md.." | H:"..hc)
            h_index = h_index + 1
        end
    end
end)

local misses = ui.new_checkbox("Rage", "aimbot", "Log misses")
local hits = ui.new_checkbox("Rage", "aimbot", "Log hits")
local ffi = require("ffi")
ffi.cdef[[
typedef void***(__thiscall* FindHudElement_t)(void*, const char*);
typedef void(__cdecl* ChatPrintf_t)(void*, int, int, const char*, ...);
]]

local signature_gHud = "\xB9\xCC\xCC\xCC\xCC\x88\x46\x09"
local signature_FindElement = "\x55\x8B\xEC\x53\x8B\x5D\x08\x56\x57\x8B\xF9\x33\xF6\x39\x77\x28"

local match = client.find_signature("client_panorama.dll", signature_gHud) or error("sig1 not found")
local hud = ffi.cast("void**", ffi.cast("char*", match) + 1)[0] or error("hud is nil")

match = client.find_signature("client_panorama.dll", signature_FindElement) or error("FindHudElement not found")
local find_hud_element = ffi.cast("FindHudElement_t", match)
local hudchat = find_hud_element(hud, "CHudChat") or error("CHudChat not found")

local chudchat_vtbl = hudchat[0] or error("CHudChat instance vtable is nil")
local print_to_chat = ffi.cast("ChatPrintf_t", chudchat_vtbl[27])

--[[
\x01 - white
\x02 - red
\x03 - purple
\x04 - green
\x05 - yellow green
\x06 - light green
\x07 - light red
\x08 - gray
\x09 - light yellow
\x0A - gray
\x0C - dark blue
\x10 - gold
]]
function print_chat(text)
	print_to_chat(hudchat, 0, 0, text)
end

local function on_aim_hit(e)
	if ui.get(hits) then

        local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
        local group = hitgroup_names[e.hitgroup + 1] or "?"

        local target_name = entity.get_player_name(e.target)
       
		local entityHealth = entity.get_prop(e.target, "m_iHealth")
		print_chat(" \x08<\x10404 project\x08>" .."\x06hit ".. "\x0Atarget: \x04" .. string.lower(target_name) .. "\x0A hitbox: \x05" .. group .. "\x0A hp: \x09" .. entityHealth .. "\x0A hc: \x09" .. string.format("%d", e.hit_chance) .. "%")
    end
end

local function on_aim_miss(e)
	if ui.get(misses) and e ~= nil then

    local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
    local group = hitgroup_names[e.hitgroup + 1] or "?"
    local target_name = entity.get_player_name(e.target)
    local reason
	local entityHealth = entity.get_prop(e.target, "m_iHealth")
	if (entityHealth == nil) or (entityHealth <= 0) then
		client.log("The player was killed prior to your shot being able to land")
	return
	end
    if e.reason == "?" then
    	reason = "resolver"
    else
    	reason = e.reason
    end
		print_chat(" \x08<\x10404 project\x08>" .. "\x07missed \x04" .. string.lower(target_name) .. "\x04's " .. " \x05" .. group .. "\x01 due to \x02" .. reason.. "\x0A hc: \x09" .. string.format("%d", e.hit_chance) .. "%")
    end
end


client.set_event_callback('aim_hit', on_aim_hit)
client.set_event_callback('aim_miss', on_aim_miss)
client.set_event_callback("paint_ui", handleVis)
client.set_event_callback("run_command", handleWeapons)
client.set_event_callback("net_update_end", netUpdateEnd)