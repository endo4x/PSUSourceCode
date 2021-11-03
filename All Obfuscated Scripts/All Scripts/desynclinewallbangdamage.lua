--[[
	id: 2rgsS3tcY79lyC1gxvaR1
	name: desync line + wallbang damage
	description: skeet lua to display wallbang damage and desync line
	time1: 2021-06-15 23:15:59.455499+00
	time2: 2021-06-15 23:15:59.4555+00
	uploader: WkCX2HSLxGf7Ee50kdrXY3vt1b3MRjsTt990y2gs
	uploadersession: 5jakiHCrw8YEQ9my_AkQStQqCAorF0
	flag: f
--]]

-- Credits:
-- Salvatore anti-aim lib https://gamesense.pub/forums/viewtopic.php?id=29665
-- Gloutoblop for the wallbang damage https://gamesense.pub/forums/viewtopic.php?pid=277239
-- Yordz for helping me with the math aswell as other things https://gamesense.pub/forums/profile.php?id=4788
-- Astolfo for the original design of this indicator https://gamesense.pub/forums/viewtopic.php?pid=272723#p272723

local aa = require 'gamesense/antiaim_funcs' -- get it here https://gamesense.pub/forums/viewtopic.php?id=29665

local new_checkbox = ui.new_checkbox
local new_colorpicker = ui.new_color_picker
local ui_get = ui.get
local screen_width, screen_height = client.screen_size()
local local_player = entity.get_local_player()
local weapon = entity.get_player_weapon(local_player)
local aa_toggle = ui.reference("AA", "Anti-aimbot angles", "Enabled")

local CheckBox = new_checkbox("VISUALS", "Other Esp", "Wallbang Indicator")
local colorpicker = new_colorpicker("VISUALS", "Other Esp", 0, 81, 255, 255)

local wpn_ignored = { -- weapon blacklist
    'CKnife',
    'CWeaponTaser',
    'CC4',
    'CHEGrenade',
    'CSmokeGrenade',
    'CMolotovGrenade',
    'CSensorGrenade',
    'CFlashbang',
    'CDecoyGrenade',
    'CIncendiaryGrenade'
}
local function contains(tbl, val) 
    for i=1,#tbl do 
        if tbl[i] == val then 
            return true 
        end
    end 
    return false 
end
local function angle_forward(angle) 
    local sin_pitch = math.sin(math.rad(angle[1]))
    local cos_pitch = math.cos(math.rad(angle[1]))
    local sin_yaw = math.sin(math.rad(angle[2]))
    local cos_yaw = math.cos(math.rad(angle[2]))

    return {        
        cos_pitch * cos_yaw,
        cos_pitch * sin_yaw,
        -sin_pitch
    }
end

local function Draw_Indicator()
    if not ui_get(CheckBox) then return end 
    local local_player = entity.get_local_player()
    local weapon = entity.get_player_weapon(local_player)
    if weapon == nil or contains(wpn_ignored, entity.get_classname(weapon)) then
        return
    end
    local screen_width, screen_height = client.screen_size()
    local pitch, yaw = client.camera_angles()
    local fwd = angle_forward({ pitch, yaw, 0 })
    local start_pos = { client.eye_position() }
    local fraction = client.trace_line(local_player, start_pos[1], start_pos[2], start_pos[3], start_pos[1] + (fwd[1] * 8192), start_pos[2] + (fwd[2] * 8192), start_pos[3] + (fwd[3] * 8192))
    local ent, dmg 
    if fraction < 1 then
        local end_pos = {
            start_pos[1] + (fwd[1] * (8192 * fraction + 128)),
            start_pos[2] + (fwd[2] * (8192 * fraction + 128)),
            start_pos[3] + (fwd[3] * (8192 * fraction + 128)),
        }

        ent, dmg = client.trace_bullet(local_player, start_pos[1], start_pos[2], start_pos[3], end_pos[1], end_pos[2], end_pos[3])

        if ent == nil then
            ent = -1
        end
    end
    local delta = aa.get_desync(1)
    delta = math.abs (math.floor(delta+ 0.5))
    local desyncmult = delta / 57
    if desyncmult < 0 then
        desyncmult = 0
      elseif desyncmult > 1 then
        desyncmult = 1
      end
    local baroffset = 130 * desyncmult
    local r,g,b,a = ui_get(colorpicker)
    renderer.rectangle(screen_width / 2 - 65, screen_height / 2 - 2 + 25 - math.abs(math.sin(globals.curtime()* 3) * 6), 130, 2, 0, 0, 0, 150)
    if ui_get(aa_toggle) then
        renderer.rectangle(screen_width / 2 - baroffset / 2, screen_height / 2 + 25 - 2 - math.abs(math.sin(globals.curtime()* 3) * 6), baroffset, 2, r, g, b, a)
    end
    renderer.rectangle(screen_width / 2 - 65, screen_height / 2 + 25 - math.abs(math.sin(globals.curtime ()* 3) * 6), 130, 20, 0, 0, 0, 100)
    renderer.text(screen_width / 2 - 2, screen_height / 2 + 13 + 25 - 5 - math.abs(math.sin(globals.curtime()*3) * 6), 255, 255, 255, 255, "c", 0, "Wallbang Damage: "..dmg)
end
client.set_event_callback("paint", Draw_Indicator)