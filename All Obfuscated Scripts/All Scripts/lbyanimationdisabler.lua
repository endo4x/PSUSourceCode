--[[
	id: 0cdtjdHGcZp6MP9oMiY6t
	name: lby animation disabler
	description: disables lby animation while slowwalking
	time1: 2021-07-26 03:44:24.938905+00
	time2: 2021-07-26 03:44:24.938906+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

local check = ui.new_checkbox("AA", "Anti-aimbot angles", "[nekoware] Disable LBY animator")
local key = ui.new_hotkey("AA", "Anti-aimbot angles", "[nekoware] Disable LBY animator", true)
local yaw_base, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local body_base, body_slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local cool = ui.new_combobox("AA", "Anti-aimbot angles", "Lower body yaw target", "Off", "Opposite", "Eye yaw", "Sway")
ui.set_visible(cool, false)
local lby_target = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local limit_ref = ui.reference("AA", "Fake lag", "Limit")
local on_shot = ui.reference("AA", "Other", "On shot anti-aim")
local aa_limit_ref = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")

local state = false
client.set_event_callback("setup_command", function(c)
    if ui.get(check) then
        -- setup
        c.allow_send_packet = false 
        local limit = ui.get(limit_ref)
        ui.set(limit_ref, (ui.get(on_shot) and math.min(limit, 5) or limit))
        ui.set(body_base, "Static")
        ui.set(body_slider, 0)
        ui.set(yaw_base, "180")
        --ui.set(aa_limit_ref, 0)
        if mode == "Default" then
            state = false
        end
        
        -- main stuff
        if c.chokedcommands == limit then
            ui.set(yaw_slider, 0)
            if mode == "Jitter" then
                state = not state
            end
        elseif c.chokedcommands == limit-1 then
            ui.set(yaw_slider, (state and 120 or -120))
        else
                ui.set(yaw_slider, (state and -120 or 120))
        end
    end
end)