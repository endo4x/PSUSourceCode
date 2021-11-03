--[[
	id: E7he_vgq992QD1aP8ky20
	name: System UPD8
	description: update of system lua 
	time1: 2021-06-22 23:09:07.424724+00
	time2: 2021-06-22 23:09:07.424725+00
	uploader: hnNPbegf_x_KvNuAW01zweMZHwhh0U5EzinSZ3El
	uploadersession: Nx2o45AL5P5r1ISXrL-UIBiNYAkliT
	flag: f
--]]

--[[///////////////////////////////// START OF GLOBALS /////////////////////////////////]]

local cache = {
    fPlayerRealAngle = 1,
    fPlayerDesyncAngle = 1,
    fDesyncAmount = 1,
    fVelocity = 0,
    iNextLBYUpdateTime = 0,
    iTankAngle = 1,
    iRattleAmount = 1,
    iBruteTimer = 0,
    iPresetTimer = false,
    bBruteSwap = false,

}

local originRecords = {}
local last = {}

local fonts = {
    sidebar = draw.CreateFont("Palatino Bold", 26, 999),
    watermark = draw.CreateFont("Consolas Bold", 23, 999),
    arrows = draw.CreateFont("Tahoma Bold", 36, 999),
    crosshair = draw.CreateFont("Verdana", 13, 999),
    delta = draw.CreateFont("Calibri Italic", 16, 999)
}
--[[///////////////////////////////// END OF GLOBALS /////////////////////////////////]]

--[[///////////////////////////////// START OF GUI /////////////////////////////////]]
local gui_main_ref = gui.Reference("MENU")

local gui_tab = gui.Tab(gui.Reference("Ragebot"), "system", "SYSTEM")
local gui_gbox_aa = gui.Groupbox(gui_tab, "Anti-Aim Main", 16, 16, 296, 5)
local gui_gbox_aa_sway = gui.Groupbox(gui_tab, "Sway Settings", 326, 16, 296, 5)
local gui_gbox_aa_fakedesync = gui.Groupbox(gui_tab, "Fake Desync Settings", 326, 16, 296, 5)
local gui_gbox_aa_pjitter = gui.Groupbox(gui_tab, "pJitter Settings", 326, 16, 296, 5)
local gui_gbox_aa_presets = gui.Groupbox(gui_tab, "Preset Settings", 326, 16, 296, 5)
local gui_gbox_aa_rattle = gui.Groupbox(gui_tab, "Rattle Settings", 326, 16, 296, 5)
local gui_gbox_antibrute = gui.Groupbox(gui_tab, "Anti-Bruteforce", 16, 282, 296, 5)
local gui_gbox_aa_extra = gui.Groupbox(gui_tab, "Anti-Aim Extra", 326, 282, 296, 5)
local gui_gbox_aa_fakewalk = gui.Groupbox(gui_tab, "Fakewalk", 326, 504, 296, 5)

local gui_gbox_visuals = gui.Groupbox(gui_tab, "Visuals", 16, 504, 296, 5)

local gui_mbox_indicators = gui.Multibox(gui_gbox_visuals, "Indicators")

local gui_window_desync_log = gui.Window("desync.log", "Desync Log", 250, 250, 74, 25)
local gui_window_antibrute_timer = gui.Window("antibrute.timer", "Anti-Bruteforce Timer", 250, 450, 175, 20)


local ui_aa = {
    mode = gui.Combobox(gui_gbox_aa, "aa.mode", "Anti-Aim Mode", "Off", "Sway", "Fake Desync", "pJitter", "Rattle", "Presets"),
    lby_mode = gui.Combobox(gui_gbox_aa, "aa.lby.mode", "LBY Mode", "Default", "Micromovement", "Anti-Flick", "Fake-Flick"),
    freestand_mode = gui.Combobox(gui_gbox_aa, "aa.freestand.mode", "Freestanding Mode", "Default", "Hide", "Peek"),
}

local ui_aa_extra = {
    legbreak = gui.Checkbox(gui_gbox_aa_extra, "aa.legbreak", "Leg Breaker", 0),
    lagback = gui.Checkbox(gui_gbox_aa_extra, "aa.lagback", "Auto-Peek Lagback", 0)
}

local ui_sway = {
    speed = gui.Slider(gui_gbox_aa_sway, "aa.sway.speed", "Speed", 3, 2, 12),
    range = gui.Slider(gui_gbox_aa_sway, "aa.sway.range", "Range", 58, 1, 58),
}

local ui_rattle = {
    gui.Text(gui_gbox_aa_rattle, "Rattle cannot be customized (yet!).")
}

local ui_fakedesync = {
    gui.Text(gui_gbox_aa_fakedesync, "Fake Desync cannot be customized.")
    --[[    speed = gui.Slider(gui_gbox_aa_fakedesync, "aa.fakedesync.speed", "Speed", 3, 2, 12),
    yaw = gui.Combobox(gui_gbox_aa_fakedesync, "aa.fakedesync.yaw", "Yaw Offset", "Default", "Extended")]]
}

local ui_pjitter = {
    mode = gui.Combobox(gui_gbox_aa_pjitter, "aa.pjitter.mode", "Yaw Mode", "Default", "Random"),
    range = gui.Slider(gui_gbox_aa_pjitter, "aa.pjitter.range", "Yaw Range", 10, 1, 180),
    desync_mode = gui.Combobox(gui_gbox_aa_pjitter, "aa.pjitter.desync.mode", "Desync Mode", "Default", "Random", "Sway"),
    desync_range = gui.Slider(gui_gbox_aa_pjitter, "aa.pjitter.desync.range", "Desync Range", 29, 1, 58),
}

local ui_presets = {
    mode = gui.Combobox(gui_gbox_aa_presets, "aa.presets.mode", "Preset Mode", "Default", "Alt 1", "Alt 2", "Alt 3", "Alt 4", "Alt 5", "Alt 6"),
    gui.Text(gui_gbox_aa_presets, "Presets cannot be customized.")
}

local ui_fakewalk = {
    mode = gui.Combobox(gui_gbox_aa_fakewalk, "aa.fakewalk.mode", "Fakewalk Mode", "Off", "Default"),
    key = gui.Keybox(gui_gbox_aa_fakewalk, "aa.fakewalk.key", "Fakewalk Key", "c")
}

local ui_antibruteforce = {
    mode = gui.Combobox(gui_gbox_antibrute, "aa.antibruteforce.mode", "Mode", "Off", "Swap", "Mixed Delta"),
    time = gui.Slider(gui_gbox_antibrute, "aa.antibruteforce.time", "Time (Seconds)", 2, 1, 8),
    manual = gui.Keybox(gui_gbox_antibrute, "aa.antibruteforce.manual", "Manual Swap", "Mouse3")
}

local ui_visuals = {
    crosshair = gui.Combobox(gui_gbox_visuals, "visuals.crosshair", "Custom Crosshair", "Off", "Default", "Simple"),
    hitsound = gui.Checkbox(gui_gbox_visuals, "visuals.hitsound", "Custom Hitsound", 0),
    desync_log = gui.Checkbox(gui_mbox_indicators, "visuals.desync.log", "Desync Log", 0),
    lagcomp = gui.Checkbox(gui_mbox_indicators, "visuals.lagcomp", "Breaking Lag Compensation", 0),
    delta = gui.Checkbox(gui_mbox_indicators, "visuals.delta", "Delta Range", 0),
    antibrute = gui.Checkbox(gui_mbox_indicators, "visuals.antibrute.timer", "Anti-Bruteforce Timer", 0),
    hideshots = gui.Checkbox(gui_mbox_indicators, "visuals.hideshots", "Hideshots", 0),
    predictive = gui.Checkbox(gui_mbox_indicators, "visuals.predictive", "Predictive", 0),
    doubletap = gui.Checkbox(gui_mbox_indicators, "visuals.doubletap", "Double-Tap", 0),
    hitchance = gui.Checkbox(gui_mbox_indicators, "visuals.hitchance", "Hitchance", 0),
    mindmg = gui.Checkbox(gui_mbox_indicators, "visuals.mindamage", "Minimum Damage", 0),
}

local ui_colors = {
    crosshair_color = gui.ColorPicker(ui_visuals.crosshair, "visuals.crosshair.color", "Crosshair Color", 255, 255, 25, 255),
    desync_log_color = gui.ColorPicker(ui_visuals.desync_log, "visuals.desync.log.color", "Desync Log Color", 255, 255, 255, 255),
    lagcomp_color = gui.ColorPicker(ui_visuals.lagcomp, "visuals.lagcomp.color", "Lag Compensation Color", 120, 255, 125, 255),
    lagcomp_breaking_color = gui.ColorPicker(ui_visuals.lagcomp, "visuals.lagcomp.breaking.color", "Breaking Lag Compensation Color", 255, 120, 125, 255),
    lowdelta = gui.ColorPicker(ui_visuals.delta, "visuals.delta.low.color", "Low Delta Color", 255, 128, 77, 255),
    neutraldelta = gui.ColorPicker(ui_visuals.delta, "visuals.delta.neutral.color", "Neutral Delta Color", 77, 255, 77, 255),
    highdelta = gui.ColorPicker(ui_visuals.delta, "visuals.delta.high.color", "High Delta Color", 0, 255, 255, 255),

}

local function handleUserInterface()
    local baseMode = ui_aa.mode:GetValue()
    local lbyMode = ui_aa.lby_mode:GetValue()
    local antibruteforceMode = ui_antibruteforce.mode:GetValue()

    local tabs = {
        [1] = gui_gbox_aa_sway,
        [2] = gui_gbox_aa_fakedesync,
        [3] = gui_gbox_aa_pjitter,
        [4] = gui_gbox_aa_rattle,
        [5] = gui_gbox_aa_presets
    }

    for k, v in pairs(tabs) do
        v:SetInvisible(k ~= baseMode)
    end

end

--[[///////////////////////////////// END OF GUI /////////////////////////////////]]

--[[///////////////////////////////// START OF UTILITY /////////////////////////////////]]

local function split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local function sway(offset, speed)
    return math.cos(globals.RealTime() * speed or 2) * offset
end

local function getBreakTime(time)
    return globals.CurTime() + (globals.TickInterval() * time) > cache.iNextLBYUpdateTime
end

local function setDesync(val)
    local mode = ui_aa.freestand_mode:GetValue()

    if mode == 0 then
        gui.SetValue("rbot.antiaim.base.rotation", val)
    elseif mode == 1 then
        gui.SetValue("rbot.antiaim.base.rotation", val)
        gui.SetValue("rbot.antiaim.left.rotation", val)
        gui.SetValue("rbot.antiaim.right.rotation", -val)
    elseif mode == 2 then
        gui.SetValue("rbot.antiaim.base.rotation", -val)
        gui.SetValue("rbot.antiaim.left.rotation", -val)
        gui.SetValue("rbot.antiaim.right.rotation", val)
    end

end

local function setReal(val)
    local mode = ui_aa.freestand_mode:GetValue()

    if mode == 0 then
        gui.SetValue("rbot.antiaim.base", val)
    elseif mode == 1 then
        gui.SetValue("rbot.antiaim.base", val)
        gui.SetValue("rbot.antiaim.left", val)
        gui.SetValue("rbot.antiaim.right", -val)
    elseif mode == 2 then
        gui.SetValue("rbot.antiaim.base", -val)
        gui.SetValue("rbot.antiaim.left", -val)
        gui.SetValue("rbot.antiaim.right", val)
    end
end

local function pointDistFromLine(x1, x2, p)
    local sub1 = Vector3(p.x - x1.x, p.y - x1.y, p.z - x1.z);
    local sub2 = Vector3(p.x - x2.x, p.y - x2.y, p.z - x2.z);

    local den = Vector3(x2.x - x1.x, x2.y - x1.y, x2.z - x1.z);

    return sub1:Cross(sub2):Length() / den:Length();
end

local function getWeapon(mef)

    local weapon_list = {
        [1] = "hpistol",[2] = "pistol",[3] = "pistol",[4] = "pistol",[7] = "rifle",[8] = "rifle", [9] = "sniper", [10] = "rifle",[11] = "asniper",[13] = "rifle",
        [14] = "lmg",[16] = "rifle",[17] = "smg",[19] = "smg",[23] = "smg",[24] = "smg",[25] = "shotgun",[26] = "smg",[28] = "lmg",[30] = "pistol",
        [32] = "pistol",[33] = "smg",[34] = "smg",[36] = "pistol",[38] = "asniper",[39] = "rifle", [40] = "scout", [60] = "rifle",[61] = "pistol",[63] = "pistol",
    }

    local lp = entities.GetLocalPlayer()
    local wep = lp:GetWeaponID()
    if not weapon_list[wep] then return "nil" end

    if not mef then
        return tostring(weapon_list[wep])
    elseif mef == "hc" then
        return gui.GetValue("rbot.accuracy.weapon." .. weapon_list[wep] .. ".hitchance")
    elseif mef == "dmg" then
        return gui.GetValue("rbot.accuracy.weapon." .. weapon_list[wep] .. ".mindmg")
    elseif mef == "dt" then
        return gui.GetValue("rbot.accuracy.weapon." .. weapon_list[wep] .. ".doublefire") > 0
    elseif mef == "pred" then
        return gui.GetValue("rbot.hitscan.advanced." .. weapon_list[wep] .. ".predictive")
    end
end

local function handleDesyncInfo(cmd)

    if not cmd.sendpacket then
        cache.fPlayerDesyncAngle = cmd.viewangles.y
    else
        cache.fPlayerRealAngle = cmd.viewangles.y
        table.insert(originRecords, entities.GetLocalPlayer():GetAbsOrigin())
    end

    cache.fDesyncAmount = math.min(58, math.ceil(math.floor(cache.fPlayerDesyncAngle) - math.floor(cache.fPlayerRealAngle)) / 2.1)
end

function draw.Bar(x1, y1, x2, y2, percent, color_outline, color_fill)

    draw.Color(color_outline[1], color_outline[2], color_outline[3], color_outline[4])
    draw.OutlinedRect(x1, y1, x2, y2)

    draw.Color(color_fill[1], color_fill[2], color_fill[3], color_fill[4])
    draw.FilledRect(x1 + 1, y1 + 1, (x1 - 1) + (x2 - x1) * percent * 0.01, y2 - 1)

end

--[[///////////////////////////////// END OF UTILITY /////////////////////////////////]]

--[[///////////////////////////////// START OF ANTI-AIM /////////////////////////////////]]

local function handleLegBreak()

    if not ui_aa_extra.legbreak:GetValue() then return end

    if globals.TickCount() % 9 == 0 then
        gui.SetValue("misc.slidewalk", 1)
    else
        gui.SetValue("misc.slidewalk", 0)
    end
end

local function handleAntiBrute()
    local desync = gui.GetValue("rbot.antiaim.base.rotation")
    local mode = ui_antibruteforce.mode:GetValue()

    local swap = cache.bBruteSwap
    if not swap then return end
    if mode == 0 then
        return
    elseif mode == 1 then
        setDesync( -desync)
    elseif mode == 2 then
        if desync >= 0 then
            setDesync(math.random(-58, -29))
        else
            setDesync(math.random(29, 58))
        end
    end

    cache.bBruteSwap = false

end


local function handleSway()
    if ui_aa.mode:GetValue() ~= 1 then return end
    local range = ui_sway.range:GetValue()
    local speed = ui_sway.speed:GetValue()
    setDesync(sway(range, speed))
end

local function handleFakeDesync(cmd)
    if ui_aa.mode:GetValue() ~= 2 then return end

    if cmd.tick_count % 5 == 0 then
        setReal(179)
        setDesync(1)
    else
        setReal(180)
        setDesync(0)
    end

end

local function handlepJitter()
    if ui_aa.mode:GetValue() ~= 3 then return end

    local mode = ui_pjitter.mode:GetValue()
    local range = ui_pjitter.range:GetValue()
    local desyncmode = ui_pjitter.desync_mode:GetValue()
    local desyncrange = ui_pjitter.desync_range:GetValue()

    local desync = gui.GetValue("rbot.antiaim.base.rotation")
    local yaw = tonumber(split(gui.GetValue("rbot.antiaim.base"), " ")[1])

    if mode == 0 then
        if yaw >= 0 then
            setReal(-180 + range)
        else
            setReal(180 - range)
        end
    elseif mode == 1 then
        if yaw >= 0 then
            setReal(math.random(-180, -180 + range))
        else
            setReal(math.random(180- range, 180))
        end
    end

    if desyncmode == 0 then
        if desync >= 0 then
            setDesync( -desyncrange)
        else
            setDesync(desyncrange)
        end
    elseif desyncmode == 1 then
        if desync >= 0 then
            setDesync(math.random(1, -desyncrange))
        else
            setDesync(math.random(1, desyncrange))
        end
    elseif desyncmode == 2 then
        setDesync(sway(desyncrange, 4))
    end
end

local function handleRattle()
    if ui_aa.mode:GetValue() ~= 4 then return end
    local amt = gui.GetValue("rbot.antiaim.base.rotation")

    if cache.iRattleAmount < 58 then
        cache.iRattleAmount = cache.iRattleAmount + 1
        if amt % 2 == 0 then
            setDesync(cache.iRattleAmount)
        else
            setDesync(-cache.iRattleAmount)
        end
    else
        cache.iRattleAmount = 0
    end

end

local function handlePresets(cmd)
    if ui_aa.mode:GetValue() ~= 5 then return end
    local switch = cmd.tick_count % 5 == 0
    local mode = ui_presets.mode:GetValue()

    local angz = {
        [0] = {-174, -39, 167, 27},
        {-180, -58, 168, 27},
        {174, -27, -167, 9},
        {-165, -29, 180, 47},
        {177, -43, -168, 19},
        {180, 44, -166, 55},
        {180, 28, 170, 38},

    }

    for i = 1, #angz do
        if switch then
            setReal(angz[mode][1])
            setDesync(angz[mode][2])
        else
            setReal(angz[mode][3])
            setDesync(angz[mode][4])
        end
    end

end

local function handleLBYUpdate()
    local mask = ui_aa.lby_mode:GetValue()
    local lp = entities.GetLocalPlayer()
    if not lp or not lp:IsAlive() then return end
    cache.fVelocity = Vector3(lp:GetPropFloat("localdata", "m_vecVelocity[0]"), lp:GetPropFloat("localdata", "m_vecVelocity[1]"), lp:GetPropFloat("localdata", "m_vecVelocity[2]")):Length2D()
    local ttu = cache.iNextLBYUpdateTime - globals.CurTime()
    if not cache.fVelocity then return end
    local onGround = bit.band(lp:GetPropInt("m_fFlags"), 1) ~= 0;
    if not onGround then return end

    if cache.fVelocity > 0.1 then
        cache.iNextLBYUpdateTime = globals.CurTime() + 0.22
    else
        if getBreakTime(0) then
            cache.iNextLBYUpdateTime = globals.CurTime() + 1.1
        end
    end

    if mask == 0 then
        gui.SetValue("rbot.antiaim.advanced.antialign", 0)
    elseif mask == 1 then
        gui.SetValue("rbot.antiaim.advanced.antialign", 1)
    elseif mask == 2 then
        if ttu < .01 then
            gui.SetValue("rbot.antiaim.advanced.antialign", 1)
        else
            gui.SetValue("rbot.antiaim.advanced.antialign", 0)
        end
    elseif mask == 3 then
        if ttu > 0.1 then
            gui.SetValue("rbot.antiaim.advanced.antialign", 0)
        else
            gui.SetValue("rbot.antiaim.advanced.antialign", 1)
        end
    end

end

local function handleFakeWalk(cmd)
    if not ( ui_fakewalk.mode:GetValue() > 0) or ( ui_fakewalk.key:GetValue() == 0 or nil) then return end
    local lp = entities.GetLocalPlayer()
    if input.IsButtonDown(ui_fakewalk.key:GetValue()) then
        if cmd.sendpacket then
            cheat.RequestSpeedBurst()
            gui.SetValue("rbot.antiaim.base", 180)
        else
            lp:SetProp('m_flLowerBodyYawTarget', -lp:GetProp('m_flLowerBodyYawTarget'))
            gui.SetValue("rbot.antiaim.base.rotation", -gui.GetValue("rbot.antiaim.base.rotation"))
            gui.SetValue("rbot.antiaim.base", 180 - math.abs(gui.GetValue("rbot.antiaim.base.rotation")))
        end
    end

end

--[[///////////////////////////////// END OF ANTI-AIM /////////////////////////////////]]

local function handleIndicators()

    local lp = entities.GetLocalPlayer()
    if not lp or not lp:IsAlive() then return end

    local w, h = draw.GetScreenSize()

    if ui_antibruteforce.mode:GetValue() > 0 then
        local x, y = gui_window_antibrute_timer:GetValue()

        if cache.iBruteTimer >= globals.CurTime() then
            draw.Bar(x + 8, y + 30, x + 208, y + 40, (cache.iBruteTimer - globals.CurTime()) * 100 / ui_antibruteforce.time:GetValue(), {255, 255, 255, 255}, {255, 0, 0, 255})
            draw.Color(0, 0, 0, 255)
            draw.TextShadow(x + ((cache.iBruteTimer - globals.CurTime()) * 208 / ui_antibruteforce.time:GetValue()), y + 30, string.format( "%2.1f", cache.iBruteTimer - globals.CurTime()))
        end
    end


    if ui_visuals.hideshots:GetValue() or ui_visuals.predictive:GetValue() or ui_visuals.hitchance:GetValue() or ui_visuals.mindmg:GetValue() then
        local wep = lp:GetPropEntity('m_hActiveWeapon')
        if not wep then return end
        if not getWeapon() then return end

        draw.SetFont(fonts.sidebar)

--[[    hideshots = gui.Checkbox(gui_mbox_indicators, "visuals.hideshots", "Hideshots", 0),
--    predictive = gui.Checkbox(gui_mbox_indicators, "visuals.predictive", "Predictive", 0),
--    hitchance = gui.Checkbox(gui_mbox_indicators, "visuals.hitchance", "Hitchance", 0),
--    mindmg = gui.Checkbox(gui_mbox_indicators, "visuals.mindamage", "Minimum Damage", 0),]]

        local indicators = {
            [1] = { "HIDE", gui.GetValue("rbot.antiaim.condition.shiftonshot"), ui_visuals.hideshots:GetValue() },
            [2] = { "DTAP", getWeapon('dt'), ui_visuals.doubletap:GetValue()},
            [3] = { "PRED", getWeapon('pred'), ui_visuals.predictive:GetValue()},
            [4] = { "HC: " .. getWeapon('hc') .. "%", 1, ui_visuals.hitchance:GetValue()},
            [5] = { "MD: -" .. getWeapon('dmg'), 1, ui_visuals.mindmg:GetValue()},

        }

        for k, v in pairs(indicators) do
            if v[2] then
                draw.Color(59, 235, 9, 255)
            else
                draw.Color(235, 59, 9, 255)
            end
            if v[3] then
                draw.TextShadow(5, h * .66 - (21 * k), v[1])
            end
        end
    end

    if ui_visuals.delta:GetValue() then
        draw.SetFont(fonts.delta)
        local deltas = {
            ["Low Delta"] = { math.abs(cache.fDesyncAmount) < 22, { ui_colors.lowdelta:GetValue() } },
            ["Neutral"] = { math.abs(cache.fDesyncAmount) > 22 and math.abs(cache.fDesyncAmount) < 38, { ui_colors.neutraldelta:GetValue() }},
            ["High Delta"] = { math.abs(cache.fDesyncAmount) > 38, { ui_colors.highdelta:GetValue() } },
        }

        local x, y = w / 2, h / 2
        for k, v in pairs(deltas) do
            if v[1] then
                draw.Color(v[2][1], v[2][2], v[2][3])
                draw.TextShadow(x + 5, y + 15, k)
            end
        end
    end

    if ui_visuals.lagcomp:GetValue() then
        local lc = {
            { ui_colors.lagcomp_color:GetValue() },
            { ui_colors.lagcomp_breaking_color:GetValue() }
        }
        draw.SetFont(fonts.delta)
        if originRecords[1] ~= nil and originRecords[2] ~= nil then
            local delta = Vector3(originRecords[2].x - originRecords[1].x, originRecords[2].y - originRecords[1].y, originRecords[2].z - originRecords[1].z)
            delta = delta:Length2D()^2
            local x, y = w / 2, h / 2
            if delta < 4096 then
                draw.Color(lc[1][1], lc[1][2], lc[1][3], lc[1][4])
            else
                draw.Color(lc[2][1], lc[2][2], lc[2][3], lc[2][4])
            end
            draw.TextShadow(x + 5, y + 30, "LC " .. math.floor(delta))
            if originRecords[3] ~= nil then
                table.remove(originRecords, 1)
            end
        end
    end

    if ui_visuals.desync_log:GetValue() then
        draw.SetFont(fonts.crosshair)
        local x, y = gui_window_desync_log:GetValue()
        local c1, c2, c3, c4 = ui_colors.desync_log_color:GetValue()

        draw.Color(c1, c2, c3, c4)
        if #last < 6 then
            table.insert(last, math.max(-58, math.min(58, math.ceil(cache.fDesyncAmount))))
        else
            if math.ceil(cache.fDesyncAmount) ~= last[#last] then
                table.remove(last, #last - 5)
            end
        end

        for k, v in ipairs(last) do
            if  k == 6 then
                draw.TextShadow(x + 25, y + 30 +(k * 12), ">[" .. v .. "]")
            else

                draw.TextShadow(x + 25, y + 30 +(k * 12), "[" .. v .. "]")
            end
        end
    end
end

local function handleXhair()

    local w, h = draw.GetScreenSize();
    local x, y = w / 2, h / 2

    local lp = entities.GetLocalPlayer()

    draw.SetFont(fonts.watermark)
    draw.Color(255,255,255, 255)
    draw.TextShadow(5, 5 , "SYSTEM")

    if ui_visuals.crosshair:GetValue() == 1 then
        if not lp then return end
        local c1, c2, c3, c4 = ui_colors.crosshair_color:GetValue()
        local zoomed = lp:GetPropBool("m_bIsScoped")

        if zoomed and (lp ~= nil) then
            lp:SetPropBool(false, "m_bIsScoped")
            for i = 1, 14 do
                draw.Color(c1, c2, c3, math.max(c4, 100) - (i * 6))
                draw.FilledRect(x - 1, y - 60 + (i * 2), x + 1, y - 120 - (i * 4)) -- top
                draw.FilledRect(x - 1, y + 60 - (i * 2), x + 1, y + 120 + (i * 4)) -- bottom

                draw.FilledRect(x + 120 + (i * 4), y + 1, x + 60 - (i * 2), y - 1) -- right
                draw.FilledRect(x - 120 - (i * 4), y + 1, x - 60 + (i * 2), y - 1) -- left
            end
        end
    elseif ui_visuals.crosshair:GetValue() == 2 then

        if not lp then return end
        local zoomed = lp:GetPropBool("m_bIsScoped")

        if zoomed then
            lp:SetPropBool(false, "m_bIsScoped")
            draw.Color(0, 0, 0, 255)
            draw.FilledRect(x - 250, y, x + 250, y - 1)
            draw.FilledRect(x - 1, y - 250, x, y + 250)
            draw.FilledCircle(x, y, 4)
            draw.Color(255, 255, 255, 255)
            draw.FilledCircle(x, y, 2)
        end
    end
end

callbacks.Register("FireGameEvent", function(event)

    if ( event:GetName() == "player_hurt" ) then
        local ME = client.GetLocalPlayerIndex()
        local INT_UID = event:GetInt( "userid" )
        local INT_ATTACKER = event:GetInt( "attacker" )
        local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID )
        local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER )

        if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
            if ui_visuals.hitsound:GetValue() then
                gui.SetValue("esp.world.hiteffects.sound", 0)
                client.Command( "playvol weapons\\scar20\\scar20_boltback 1", true )
                client.Command( "playvol training\\timer_bell 0.5", true )
            end

        end
    end

    if ( event:GetName() == 'weapon_fire' ) then
        if ui_aa_extra.lagback:GetValue() then
            local INT_UID = event:GetInt( "userid" )
            local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID )
            if input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.autopeekkey")) and ( INDEX_Victim == client.GetLocalPlayerIndex() )  then
                cheat.RequestSpeedBurst()
            end
        end
        entities.GetLocalPlayer()
    end

    if (event:GetName() == 'bullet_impact') then
        local entity = entities.GetByUserID(event:GetInt("userid"))
        if (ui_antibruteforce.mode:GetValue() > 0 ) and (entity:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber()) then
            local shooter_pos = entity:GetHitboxPosition('Head')
            local local_player_pos = entities.GetLocalPlayer():GetHitboxPosition('Head')
            local bullet_hit_pos = Vector3(event:GetFloat('x'), event:GetFloat('y'), event:GetFloat('z'))
            if pointDistFromLine(shooter_pos, bullet_hit_pos, local_player_pos) < 100 then
                cache.iBruteTimer = globals.CurTime() + ui_antibruteforce.time:GetValue()
                cache.bBruteSwap = true
            end
        end
    end

end)

callbacks.Register("Draw", function()
    local antibrute_mode = ui_antibruteforce.mode:GetValue()

    if not (cache.iBruteTimer >= globals.CurTime()) then
        handleSway()
        handlepJitter()
        handleRattle()
        handleLBYUpdate()
    end

    handleUserInterface()
    handleIndicators()
    handleXhair()
    handleLegBreak()

    if ui_antibruteforce.manual:GetValue() ~= 0 and input.IsButtonPressed(ui_antibruteforce.manual:GetValue()) then
        cache.iBruteTimer = globals.CurTime() + ui_antibruteforce.time:GetValue()
        cache.bBruteSwap = true
    end

    gui_window_desync_log:SetActive(gui_main_ref:IsActive() and ui_visuals.desync_log:GetValue() or 0)
    gui_window_antibrute_timer:SetActive(gui_main_ref:IsActive() and ui_visuals.antibrute:GetValue() or 0)

end)

callbacks.Register("CreateMove", function(cmd)
    handleDesyncInfo(cmd)
    if cache.iBruteTimer >= globals.CurTime() then
        handleAntiBrute()
    else
        handleFakeDesync(cmd)
        handlePresets(cmd)
        handleFakeWalk(cmd)
    end

end)