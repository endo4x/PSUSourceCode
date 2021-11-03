--[[
	id: 4Ooc86usIMK1Jmnp9A2Pl
	name: 4
	description: 132
	time1: 2021-06-26 02:36:39.277228+00
	time2: 2021-06-26 02:36:39.277229+00
	uploader: d8EWlDT4PMRavyWovXahxCimsEWFBSD5OUmmJ3P3
	uploadersession: Vi7ZxVHDLrqvkHKzCf-kf38NKihILy
	flag: f
--]]

local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local sv_maxtick_slider = ui.new_slider("AA","Fake lag", "[JangTG] Maximum Tick Setting", 4, 62, 16)
client.set_event_callback("setup_command", function()
    ui.set(sv_maxusrcmdprocessticks,ui.get(sv_maxtick_slider))
end)
local fakelag_cob_1 = ui.new_combobox("AA","Fake lag", "[JangTG] Fake Lag Mode Setting Mode","Dynamic","Maximum","Fluctuate","Dynamic/Maximum")
local fakelag_mode_ref = ui.reference("AA", "Fake lag", "Amount")
client.set_event_callback("setup_command", function()
    if ui.get(fakelag_cob_1)~="Dynamic/Maximum"then
        ui.set(fakelag_mode_ref,ui.get(fakelag_cob_1))
    else
        local random =client.random_int(0, 10)
        if random > 5 then
            ui.set(fakelag_mode_ref,"Dynamic")
        else
            ui.set(fakelag_mode_ref,"Maximum")
        end
    end
end)


local onfire_waiting_value =ui.new_slider("AA","Fake lag", "[JangTG] On Fire Fake lag Limit Waiting Time", 1, 2000, 300,true,"ms")

local fakelag_cob = ui.new_combobox("AA","Fake lag", "[JangTG] Fake Lag Limit Setting Random Mode","Fixed","Random","On Shoot","Static")
local fixed_value =ui.new_slider("AA","Fake lag", "[JangTG] Fixed Fake lag Limit Value", 3, 60, 14)
local fixed_minimum =ui.new_slider("AA","Fake lag", "[JangTG] Fixed Fake lag Limit Minimum Value", 3, 60, 14)
local fixed_maximum =ui.new_slider("AA","Fake lag", "[JangTG] Fixed Fake lag Limit Maximum Value", 3, 60, 14)

local random_minimum =ui.new_slider("AA","Fake lag", "[JangTG] Random Fake lag Limit Minimum Value", 3, 60, 14)
local random_maximum =ui.new_slider("AA","Fake lag", "[JangTG] Random Fake lag Limit Maximum Value", 3, 60, 14)

local static_value =ui.new_slider("AA","Fake lag", "[JangTG] Static Fake lag Limit Value", 3, 60, 14)

local on_shoot_value = ui.new_slider("AA","Fake lag", "[JangTG] On Shoot Fake lag Limit Value", 1, 60, 6)
client.set_event_callback("paint_ui", function()
    if ui.get(fakelag_cob)=="Fixed" then
        ui.set_visible(fixed_value, true)
        ui.set_visible(fixed_minimum, true)
        ui.set_visible(fixed_maximum, true)
        ui.set_visible(random_minimum, false)
        ui.set_visible(random_maximum, false)
        ui.set_visible(static_value, false)
        ui.set_visible(on_shoot_value, false)
    elseif ui.get(fakelag_cob)=="Random" then
        ui.set_visible(fixed_value, false)
        ui.set_visible(fixed_minimum, false)
        ui.set_visible(fixed_maximum, false)
        ui.set_visible(random_minimum, true)
        ui.set_visible(random_maximum, true)
        ui.set_visible(static_value, false)
        ui.set_visible(on_shoot_value, false)
    elseif ui.get(fakelag_cob)=="On Shoot" then
        ui.set_visible(fixed_value, false)
        ui.set_visible(fixed_minimum, false)
        ui.set_visible(fixed_maximum, false)
        ui.set_visible(random_minimum, false)
        ui.set_visible(random_maximum, false)
        ui.set_visible(static_value, false)
        ui.set_visible(on_shoot_value, true)
    elseif ui.get(fakelag_cob)=="Static" then
        ui.set_visible(fixed_value, false)
        ui.set_visible(fixed_minimum, false)
        ui.set_visible(fixed_maximum, false)
        ui.set_visible(random_minimum, false)
        ui.set_visible(random_maximum, false)
        ui.set_visible(static_value, true)
        ui.set_visible(on_shoot_value, false)
    end
end)



aim_fire = 1
client.set_event_callback("aim_fire", function()
    aim_fire = 0
    client.delay_call(ui.get(onfire_waiting_value)/1000, function()
        aim_fire = 1
    end)  
end)

local fl_limit_ref = ui.reference("AA", "Fake lag", "Limit")
client.set_event_callback("setup_command", function()
    if aim_fire == 0 then
        ui.set(fl_limit_ref,math.min(ui.get(sv_maxtick_slider)-1, ui.get(on_shoot_value)))
    else
        if ui.get(fakelag_cob)=="Fixed" then
            local random = client.random_int(0, 10)
            if random >5 then
                ui.set(fl_limit_ref,math.min(ui.get(sv_maxtick_slider)-1, ui.get(fixed_value)))
            else
                ui.set(fl_limit_ref,math.min(ui.get(sv_maxtick_slider)-1, client.random_int(ui.get(fixed_minimum), ui.get(fixed_maximum))))
            end
        elseif ui.get(fakelag_cob)=="Random" then
            ui.set(fl_limit_ref,math.min(ui.get(sv_maxtick_slider)-1, client.random_int(ui.get(random_minimum), ui.get(random_maximum))))
        elseif ui.get(fakelag_cob)=="Static" then
            ui.set(fl_limit_ref,math.min(ui.get(sv_maxtick_slider)-1, ui.get(static_value)))
        end
    end
end)


local double_tap_chk = ui.new_checkbox("RAGE","Other", "[JangTG] Unsafe Double Tap")
function set_unsafe()
    if ui.get(double_tap_chk)then
        cvar.cl_clock_correction:set_int(0)
    else
        cvar.cl_clock_correction:set_int(1)
    end
end
set_unsafe()
ui.set_callback(double_tap_chk, set_unsafe)


local TickDelay = globals.tickcount()
client.set_event_callback("setup_command", function(cmd)
  if TickDelay < globals.tickcount() then
    cmd.allow_send_packet = true
    TickDelay = globals.tickcount() + ui.get(fl_limit_ref) 
  else
    cmd.allow_send_packet = false
  end
end)




local fakelag_var_ref =ui.reference("AA", "Fake lag", "Variance")
local fakelag_ena,fakelag_hot = ui.reference("AA", "Fake lag", "Enabled")
client.set_event_callback("paint_ui", function()
ui.set_visible(fl_limit_ref, false)
ui.set_visible(fakelag_mode_ref, false)
ui.set_visible(fakelag_var_ref, false)
ui.set(fakelag_ena,true)
ui.set(fakelag_hot,"Always on")
ui.set_visible(fakelag_ena, false)
ui.set_visible(fakelag_hot, false)
end)

client.set_event_callback("shutdown", function()
    ui.set_visible(fl_limit_ref, true)
ui.set_visible(fakelag_mode_ref, true)
ui.set_visible(fakelag_var_ref, true)
ui.set_visible(fakelag_ena, true)
ui.set_visible(fakelag_hot, true)
cvar.cl_clock_correction:set_int(1)
ui.set(sv_maxusrcmdprocessticks,16)
end)