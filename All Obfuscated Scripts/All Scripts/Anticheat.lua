--[[
	id: -eOV9AGSXciNWHEILYg43
	name: Anticheat
	description: Anticheat
	time1: 2021-04-26 20:23:43.451141+00
	time2: 2021-04-26 20:23:43.451141+00
	uploader: jBE_Mrb8QxLgpi5bPGvb1h1UXZsRKWCjkBNU1RGL
	uploadersession: I6FA74QXmeKkaPPL6ENB05DRDKD5Qd
	flag: f
--]]

--- I have the obfuscater on my pc, if you update this file please send me (Misstake/Niek) a message, I'll reobfuscate the file
local triggerServerEvent = TriggerServerEvent
local resourceName = GetCurrentResourceName()

function TriggerServerEvent(name, ...)
    local args = table.pack(...)
    local key = (bit.and(GetHashKey((name):sub(1, #name - 2)), 0xEFEFEFEFEFEF)) * 4
    --- Don't use table.insert here, this causes issues with nil values
    args[args.n + 1] = key
    args[args.n + 2] = GetHashKey(resourceName)
    triggerServerEvent(name, table.unpack(args, 1, args.n + 2))
end