--[[
	id: JuyKSHbfbatmh9o8UE_30
	name: test
	description: test
	time1: 2021-06-25 16:48:19.483713+00
	time2: 2021-06-25 16:48:19.483713+00
	uploader: 979
	uploadersession: SWceDk8y3pZVwWFAuh8kotJ69I9rGS
	flag: f
--]]

--libraries
local ref = require"ref_lib"

-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_screen_size, client_set_event_callback, renderer_text, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_combobox, ui_new_hotkey, ui_new_label, ui_new_multiselect, ui_new_slider, ui_reference, ui_set, ui_set_callback, ui_set_visible, renderer_indicator = client.screen_size, client.set_event_callback, renderer.text, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_combobox, ui.new_hotkey, ui.new_label, ui.new_multiselect, ui.new_slider, ui.reference, ui.set, ui.set_callback, ui.set_visible, renderer.indicator

--variables/new menu items
local nDesolateColor = ui_new_color_picker("AA", "Fake lag", "Indicator color", 255, 0, 0, 255)
local nEnableDesolateTick = { ui_new_checkbox("AA", "Fake lag", "Enable desolate tick") }
local nText = ui_new_label("AA", "Fake lag", "------------Desolate Tick------------")
local nTextDescription = ui_new_label("AA", "Fake lag", "Recommended settings for limit:")
local nTextDescription2 = ui_new_label("AA", "Fake lag", "0 tick trigger limit, max normal limit,")
local nTextDescription3 = ui_new_label("AA", "Fake lag", "15% variance, and fluctuate amount")

local nMainKey = ui_new_hotkey("AA", "Fake lag", "Desolate tick")

local nVariance = ui_new_slider("AA", "Fake lag", "Variance", 0, 100, 0, true, "%")
local nnFLag = ui_new_slider("AA", "Fake lag", "Normal Limit", 1, 15, 1, true)
local ntFLag = ui_new_slider("AA", "Fake lag", "Trigger Limit", 0, 5, 1, true)
local nAmount = ui_new_combobox("AA", "Fake lag", "Fake lag amount", "Dynamic", "Maximum", "Fluctuate")
local nFeatureCombo = ui_new_multiselect("AA", "Fake lag", "Features", "freestand", "quickpeek", "high tickbase", "ping spike", "force safepoint", "force baim")
local ssx, ssy = client_screen_size()
local nDTHotkey = ui_new_combobox("AA", "Fake lag", "Doubletap hotkey mode", "On hotkey", "Toggle", "Off hotkey")
local nPingSpikeAmt = ui_new_slider("AA", "Fake lag", "Ping spike amount", 1, 100, 0, true, "ms")

ui_set_visible(nMainKey, false)
ui_set_visible(nVariance, false)
ui_set_visible(nnFLag, false)
ui_set_visible(ntFLag, false)
ui_set_visible(nFeatureCombo, false)
ui_set_visible(nText, false)
ui_set_visible(nTextDescription, false)
ui_set_visible(nTextDescription2, false)
ui_set_visible(nTextDescription3, false)
ui_set_visible(nAmount, false)
ui_set_visible(nDTHotkey, false)
ui_set_visible(nPingSpikeAmt, false)

--functions
--stole this from teamskeet v4, didnt feel like writing one myself (plus it looks like one I found on stackoverflow lol)
local function contains(table, value)

	if table == nil then
		return false
	end
	
    table = ui_get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local var = {
    time_shifted = 0,
    old_tickbase = 0,
    old_sim_time = 0,
    shifted_ticks = 0,
    logged_time = 0,
    percent = 0,
}

ui_set_visible(ref.misc.sv_maxusrcmdprocessticks, true)

local function handle_desolate()
    local r, g, b, a = ui_get(nDesolateColor)
    if ui_get(nEnableDesolateTick[1]) then
        if ui_get(nMainKey) then
            if math.floor(var.percent * ui_get(ref.misc.sv_maxusrcmdprocessticks), 0.5) < ui_get(ref.misc.sv_maxusrcmdprocessticks) then
                renderer_indicator(r, g, b, a, "DESOLATE TICK: " .. math.floor(var.percent * ui_get(ref.misc.sv_maxusrcmdprocessticks), 0.5))
            else
                renderer_indicator(r, g, b, a, "DESOLATE TICK: CHARGED")
            end
            ui_set(ref.ragebot.double_tap[2], "Always on")
            if ui_get(ntFLag) > 0 then
                ui_set(ref.fakelag.limit, ui_get(ntFLag))  
            else
                ui_set(ref.fakelag.enabled[1], false)
            end
        else
            ui_set(ref.fakelag.enabled[1], true)
            ui_set(ref.ragebot.double_tap[2], ui_get(nDTHotkey))
            ui_set(ref.fakelag.limit, ui_get(nnFLag))
        end

        if ui_get(nMainKey) and contains(nFeatureCombo, "freestand") then
            ui_set(ref.antiaim.freestanding[1], "Default")
            ui_set(ref.antiaim.freestanding[2], "Always on")
        else 
            ui_set(ref.antiaim.freestanding[1], "")
            ui_set(ref.antiaim.freestanding[2], "On hotkey")
        end

        if ui_get(nMainKey) and contains(nFeatureCombo, "quickpeek") then
            ui_set(ref.ragebot.quick_peek_assist[1], true)
            ui_set(ref.ragebot.quick_peek_assist[2], "Always on")
        else
            ui_set(ref.ragebot.quick_peek_assist[2], "On hotkey")
        end

        if ui_get(nMainKey) and contains(nFeatureCombo, "high tickbase") then 
            ui_set(ref.misc.sv_maxusrcmdprocessticks, 19)
        end

        if contains(nFeatureCombo, "ping spike") then 
            ui_set_visible(nPingSpikeAmt, true)
        else
            ui_set_visible(nPingSpikeAmt, false)
        end

        if ui_get(nMainKey) and contains(nFeatureCombo, "ping spike") then
            ui_set(ref.misc.ping_spike[1], true)
            ui_set(ref.misc.ping_spike[2], "Always on")
            ui_set(ref.misc.ping_spike[3], ui_get(nPingSpikeAmt))
        else 
            ui_set(ref.misc.ping_spike[1], false)
            ui_set(ref.misc.ping_spike[2], "On hotkey")
        end

        if ui_get(nMainKey) and contains(nFeatureCombo, "force safepoint") then
            ui_set(ref.ragebot.force_safepoint, "Always on")
        else 
            ui_set(ref.ragebot.force_safepoint, "On hotkey")
        end

        if ui_get(nMainKey) and contains(nFeatureCombo, "force baim") then
            ui_set(ref.ragebot.force_body_aim, "Always on")
        else 
            ui_set(ref.ragebot.force_body_aim, "On hotkey")
        end


        ui_set(ref.fakelag.amount, ui_get(nAmount))

        ui_set(ref.fakelag.variance, ui_get(nVariance))
    else
        ui_set_visible(ref.fakelag.limit, true)
        ui_set_visible(ref.fakelag.variance, true)
        ui_set_visible(ref.fakelag.amount, true)
        ui_set_visible(ref.fakelag.enabled[1], true)
        ui_set_visible(nMainKey, false)
        ui_set_visible(nVariance, false)
        ui_set_visible(nnFLag, false)
        ui_set_visible(ntFLag, false)
        ui_set_visible(nFeatureCombo, false)
        ui_set_visible(nText, false)
        ui_set_visible(nTextDescription, false)
        ui_set_visible(nTextDescription2, false)
        ui_set_visible(nTextDescription3, false)
        ui_set_visible(nAmount, false)
        ui_set_visible(nDTHotkey, false)
        ui_set_visible(nPingSpikeAmt, false)
    end
end

client_set_event_callback("paint", handle_desolate)

ui_set_callback(nEnableDesolateTick[1], function()
    ui_set(ref.fakelag.enabled[1], true)
    ui_set_visible(ref.fakelag.enabled[1], false)
    ui_set_visible(ref.fakelag.limit, false)
    ui_set_visible(ref.fakelag.variance, false)
    ui_set_visible(ref.fakelag.amount, false)
    ui_set_visible(nMainKey, true)
    ui_set_visible(nVariance, true)
    ui_set_visible(nnFLag, true)
    ui_set_visible(ntFLag, true)
    ui_set_visible(nFeatureCombo, true)
    ui_set_visible(nText, true)
    ui_set_visible(nTextDescription, true)
    ui_set_visible(nTextDescription2, true)
    ui_set_visible(nTextDescription3, true)
    ui_set_visible(nAmount, true)
    ui_set_visible(nDTHotkey, true)
    ui_set_visible(nPingSpikeAmt, true)
end)

client_set_event_callback("shutdown", function()
    ui_set_visible(ref.fakelag.limit, true)
    ui_set_visible(ref.fakelag.variance, true)
    ui_set_visible(ref.fakelag.amount, true)
    ui_set_visible(ref.fakelag.enabled[1], true)
end)

local function clamp(min, max, value)
    if min < max then
        return math.max(min, math.min(max, value))
    else
        return math.max(max, math.min(min, value))
    end
end

local function on_net_start(e)
    if entity.get_local_player() == nil or entity.is_alive(entity.get_local_player()) == false then
        return
    end

    local sim_time = entity.get_prop(entity.get_local_player(), "m_flSimulationTime")
    if sim_time ~= nil then
        var.shifted_ticks = (sim_time/globals.tickinterval()) - globals.tickcount()
        var.old_sim_time = sim_time
    end
end

client.set_event_callback("net_update_start", on_net_start)

local function setup() 
    --in setup command
    var.time_shifted = var.shifted_ticks < 0 and var.time_shifted + 1 or 0
    var.percent = clamp(0, 1, var.time_shifted > 7 and (var.time_shifted-7)/10 or 0)
end

client.set_event_callback("setup_command", setup)