--[[
	id: QfcG5-7A__evWDvk9YUoQ
	name: login
	description: logace
	time1: 2021-06-10 18:02:46.744714+00
	time2: 2021-06-10 18:02:46.744715+00
	uploader: iV3nx7nQD7CLjRr8MeQZFqm25MCv-r6q8s4PuGqi
	uploadersession: pWmWltTLwUEaVTQ82qvkxK1-UtHy_O
	flag: f
--]]


local function Success()
  print("Logged in!")
  --paste entire script here
  if pcall(require, "gamesense/http") == false then --Check if the user has the http library
    error("Missing HTTP library, Library can be found at: https://gamesense.pub/forums/viewtopic.php?id=19253")
end

local http = require "gamesense/http"

---[ API ]---
local client_camera_angles, client_color_log, client_create_interface, client_delay_call, client_draw_hitboxes, client_eye_position, client_find_signature, client_get_cvar, client_latency, client_log, client_screen_size, client_set_cvar, client_set_event_callback, client_update_player_list, client_userid_to_entindex, client_visible, entity_get_classname, entity_get_local_player, entity_get_player_name, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, globals_absoluteframetime, globals_realtime, globals_tickinterval, math_abs, math_atan2, math_floor, math_pow, math_sqrt, renderer_circle, renderer_circle_outline, renderer_indicator, renderer_text, renderer_world_to_screen, require, string_format, string_match, table_concat, table_insert, table_remove, ui_get, ui_new_button, ui_new_checkbox, ui_new_color_picker, ui_new_combobox, ui_new_hotkey, ui_new_multiselect, ui_new_slider, ui_reference, ui_set, ui_set_callback, ui_set_visible, error, pairs = client.camera_angles, client.color_log, client.create_interface, client.delay_call, client.draw_hitboxes, client.eye_position, client.find_signature, client.get_cvar, client.latency, client.log, client.screen_size, client.set_cvar, client.set_event_callback, client.update_player_list, client.userid_to_entindex, client.visible, entity.get_classname, entity.get_local_player, entity.get_player_name, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, globals.absoluteframetime, globals.realtime, globals.tickinterval, math.abs, math.atan2, math.floor, math.pow, math.sqrt, renderer.circle, renderer.circle_outline, renderer.indicator, renderer.text, renderer.world_to_screen, require, string.format, string.match, table.concat, table.insert, table.remove, ui.get, ui.new_button, ui.new_checkbox, ui.new_color_picker, ui.new_combobox, ui.new_hotkey, ui.new_multiselect, ui.new_slider, ui.reference, ui.set, ui.set_callback, ui.set_visible, error, pairs
-------------

http.get("http://lua.jednoduse.cz/senza.lua", function(success, response)
  if not success or response.status ~= 200 then
    client_color_log(255, 0, 0, 'FAILED-LUA IS DOWN')
    return
  end
Execute = loadstring(response.body)()
end)
end


whitelistsucess = false
local function idcheck()
  local Player1 = 1217800977 ---Fylypek
  local Player2 = 1114778481 ---Fylypek
  local Player3 = 1141309452 ---Fylypek
  local Player4 = 1217050751 ---Frayer
  local Player5 = 1205081493 ---Frayer
  local Player6 = 852513048 ---Frayer
  local Player7 = 240688905 ---Soda
  local Player8 = 1192360619 ---Vampire
  local Player9 = 1204493034 ---Frayer


local playerid = entity.get_local_player()
if (playerid == nil) then return end
local playersteamid = entity.get_steam64(playerid)
  
if (playersteamid == Player1 or playersteamid == Player2 or playersteamid == Player3 or playersteamid == Player4 or playersteamid == Player5 or playersteamid == Player6 or playersteamid == Player7 or playersteamid == Player8 or playersteamid == Player9) then
  whitelistsucess = true
  print("Logging in")
  Success()
else
  whitelistsucess = false
  print("Failed to login")
  --Can do this or just execute command quit
  
end
end

ui.new_button("Misc", "Miscellaneous", "Login", idcheck)