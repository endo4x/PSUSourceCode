--[[
	id: KOrEaJmpU8OpqOLCw-o9j
	name: Ideal Tick
	description: ideal ticks
	time1: 2021-05-02 23:29:52.473311+00
	time2: 2021-05-02 23:29:52.473312+00
	uploader: 439
	uploadersession: ivCTVgC-5-7NOWS6O9StJhgFGdrXug
	flag: f
--]]

    local client_random_int, client_userid_to_entindex, entity_get_classname, entity_get_player_weapon, entity_is_enemy, globals_tickcount, ui_new_button = client.random_int, client.userid_to_entindex, entity.get_classname, entity.get_player_weapon, entity.is_enemy, globals.tickcount, ui.new_button
    local client_update_player_list, globals_curtime, math_random, ui_new_slider = client.update_player_list, globals.curtime, math.random, ui.new_slider
    local client_latency, client_set_event_callback, entity_get_local_player, entity_is_alive, math_floor, renderer_indicator, renderer_text, ui_get, ui_new_checkbox, ui_new_combobox, ui_new_hotkey, ui_new_label, ui_reference, ui_set, ui_set_visible = client.latency, client.set_event_callback, entity.get_local_player, entity.is_alive, math.floor, renderer.indicator, renderer.text, ui.get, ui.new_checkbox, ui.new_combobox, ui.new_hotkey, ui.new_label, ui.reference, ui.set, ui.set_visible

    --------------------------- References ---------------------------
    local pitch = ui_reference('AA', 'Anti-aimbot angles', 'Pitch')
    local yawbase = ui_reference('AA', 'Anti-aimbot angles', 'Yaw base')
    local yaw, yawslider = ui_reference('AA', 'Anti-aimbot angles', 'Yaw')
    local bodyyaw, slider = ui_reference('AA', 'Anti-aimbot angles', 'Body yaw')
    local target = ui_reference('AA', 'Anti-aimbot angles', 'Lower body yaw target')
    local fakeyawlimit = ui_reference('AA', 'Anti-aimbot angles', 'Fake yaw limit')
    local jitter, jitter_slider = ui_reference('AA', 'Anti-aimbot angles', 'Yaw jitter')
    local fsby = ui_reference('AA', 'Anti-aimbot angles', 'Freestanding body yaw')
    local fs = ui_reference('AA', 'Anti-aimbot angles', 'Freestanding')
    local ey = ui_reference('AA', 'Anti-aimbot angles', 'Edge yaw')
    local double_tap, double_tap_key = ui_reference('Rage','Other','Double tap')
    local dt_mode = ui_reference('Rage', 'Other', 'Double tap mode')
    local os = ui_reference('AA', 'Other', 'On shot anti-aim')
    local slowwalk = ui_reference('AA', 'Other', 'slow motion')
    local dtlimit = ui_reference('Rage','Other','Double tap fake lag limit')
    local fakeducking = ui_reference('RAGE', 'Other', 'Duck peek assist')
    local amount = ui_reference('AA', 'Fake lag', 'Amount')
    local limit = ui_reference('AA', 'Fake lag', 'Limit')
    local fl = ui.reference('AA', 'Fake lag', 'Enabled')
    local box, key = ui_reference( 'Rage', 'Other', 'Quick peek assist' )
    local sv_maxusrcmdprocessticks = ui_reference('MISC', 'Settings', 'sv_maxusrcmdprocessticks')

    --------------------------- Ideal Tick Stuff ---------------------------
    local ide = ui_new_checkbox('AA', 'Fake lag', '[Discombobulation] Ideal Tick')
    local idealtick = ui_new_hotkey('AA', 'Fake Lag', 'Ideal Tick Key')
	
	client_set_event_callback('setup_command', function(e)
    shot = true

    if ui.get(idealtick) then
        ui.set(dtlimit, 1)
        ui.set(dtlimit, 5)
        ui.set(dtlimit, 1)
        if shot then
            tick = globals_tickcount()

            shot = false
        else

            if globals_tickcount() > tick + 4 then
                ui.set(limit, restorefl)
            else
                ui.set(limit, 14)
            end
        end
    end
end)