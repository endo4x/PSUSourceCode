--[[
	id: k4dtnDqRlcnZS2epxcShM
	name: ksubi_autobuy
	description: Very fast autobuy for CS:GO HvH
	time1: 2021-07-08 18:13:36.106684+00
	time2: 2021-07-08 18:13:36.106686+00
	uploader: KuFGslhKMQ5K3wc8VwQhYL3HSWjjg1IvuumBras5
	uploadersession: dwCs4j725gfbBPX4Eeu0IILKhwVSoC
	flag: f
--]]

slot0 = require("ffi")

require("ksubi_library")
slot0.cdef([[
	typedef void*(__thiscall* getnetchannel_t)(void*); //78
	typedef float(__thiscall* getlatency_t)(void*, int); //9
]])

slot3 = slot0.cast(slot0.typeof("void***"), client.create_interface("engine.dll", "VEngineClient014"))
slot2 = slot0.cast("getnetchannel_t", slot3[0][78])
waittime = 0
slot4 = 1
slot5 = 2

function get_latency(a)
	local uv0 = slot0
	slot1 = uv0.cast(uv0.typeof("void***"), slot2(slot3))

	return uv0.cast("getlatency_t", slot1[0][9])(slot1, a)
end

slot6 = ui.new_checkbox("LUA", "B", "Autobuy")
slot7 = ui.new_combobox("LUA", "B", "Autobuy weapon", {
	"Auto-sniper",
	"AWP",
	"SSG08",
})
slot8 = {
	["Auto-sniper"] = {
		"buy scar20;",
		5000
	},
	AWP = {
		"buy awp;",
		4750
	},
	SSG08 = {
		"buy ssg08;",
		1700
	}
}
slot9 = 0
slot10 = false

function slot11()
	if not ui.get(slot6) then return end

	local slot0 = entity.get_local_player()
	local slot1 = string.format("%s%s", "", slot8[ui.get(slot7)][1])
	local slot2 = slot8[ui.get(slot7)][2]

	if slot2 <= entity.get_prop(slot0, "m_iAccount") then
		client.exec(slot1)
		client.color_log(0, 255, 0, "[ksubi] Attempted to autobuy weapons. ", globals.curtime())
	else
		client.color_log(255, 0, 0, "[ksubi] Insufficient funds for autobuy.")
	end
end

client.set_event_callback("paint", function ()
	local slot1, slot2, slot3 = GetRemoteFramerate(native_GetNetChannelInfo())
	if not bought and waittime <= globals.curtime() + get_latency(slot2) / 1000 then
		slot11()
		client.delay_call(slot1 * 10, slot11)
		client.delay_call(0.01, slot11)
		client.delay_call(0.05, slot11)
		client.delay_call(0.1, slot11)

		bought = true
	end
end)
client.set_event_callback("round_end", function (...)
	waittime = globals.curtime() + cvar.mp_round_restart_delay:get_float()
	bought = false
end)
client.set_event_callback("round_prestart", function (...)
	print("Prestart: ", globals.curtime())

	if not uv0 then
		slot11()
		client.delay_call(0.01, slot11)
		client.delay_call(0.05, slot11)
		client.delay_call(0.1, slot11)

		uv0 = true
	end
end)
client.set_event_callback("player_connect_full", function (plr)
	if client.userid_to_entindex(plr) == entity.get_local_player() then
		waittime = 0
		bought = false
	end
end)