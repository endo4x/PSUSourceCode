--[[
	id: 0aFwHxQqslxW0MkV3SzVz
	name: autobuy.lua
	description: autobuy.lua
	time1: 2021-07-20 14:56:48.445522+00
	time2: 2021-07-20 14:56:48.445522+00
	uploader: W5O82ec_A3LcpaRoZ35sgJs24Y21lxrx5b4NJtLX
	uploadersession: fTDj-0CO-VZgYUal0k8vj7iutTnFAy
	flag: f
--]]

local primary_weapons = {
    {name = "-", command = ""},
    {name = "AWP", command = "buy awp; "},
    {name = "Auto-Sniper", command = "buy scar20; "},
    {name = "Scout", command = "buy ssg08; "},
    {name = "Negev", command = "buy negev; "},
    {name = "AUG / SG553", command = "buy aug; "},
    {name = "M4A4 / M4A1 / AK-47", command = "buy m4a1; "}
}

local secondary_weapons = {
    {name = "-", command = ""},
    {name = "R8 Revolver / Deagle", command = "buy deagle; "},
    {name = "Dual Berettas", command = "buy elite; "},
    {name = "FN57 / Tec9 / CZ75-Auto", command = "buy fn57; "}
}

local gear_weapons = {
    {name = "Kevlar", command = "buy vest; "},
    {name = "Helmet", command = "buy vesthelm; "},
    {name = "Defuse Kit", command = "buy defuser; "},
    {name = "Grenade", command = "buy hegrenade; "},
    {name = "Molotov", command = "buy incgrenade; "},
    {name = "Smoke", command = "buy smokegrenade; "},
    {name = "Flashbang (x2)", command = "buy flashbang; "},
    {name = "Taser", command = "buy taser; "}
}

local function get_names(table)
    local names = {}
    for i = 1, #table do
        names[i] = table[i].name
    end
    return unpack(names)
end

local function get_command(table, idx)
    return idx and table[idx + 1].command
end

local ref = gui.Groupbox(gui.Reference("misc", "enhancement"), "Auto Buy", 328, 312, 296, 0)
local buybot_primary = gui.Combobox(ref, "autobuy.primary", "Primary", get_names(primary_weapons))
local buybot_pistol = gui.Combobox(ref, "autobuy.secondary", "Secondary", get_names(secondary_weapons))

local gear_multi = gui.Multibox(ref, "Gear")
local buybot_gear = {}
local name = {get_names(gear_weapons)}
for i = 1, #name do
    local name = name[i]
    buybot_gear[i] = gui.Checkbox(gear_multi, ("%s.%s"):format("autobuy.gear", name:lower()):gsub("%s+", ""):gsub("%s+", ""), name, 0)
end

local buybot_min_money = gui.Slider(ref, "autobuy.minmoney", "Min Money", 1000, 0, 15000)

client.AllowListener("round_prestart")
client.AllowListener("player_spawn")

callbacks.Register(
    "FireGameEvent",
    function(e)
        local lp = entities.GetLocalPlayer()
        local en = e and e:GetName()
        if en == "round_prestart" or en == "player_spawn" then
            local userid = e:GetInt("userid")

            if lp and userid and client.GetPlayerIndexByUserID(userid) == lp:GetIndex() and lp:GetProp("m_iAccount") > buybot_min_money:GetValue() then
                local primary = buybot_primary:GetValue()
                local pistol = buybot_pistol:GetValue()
                local gear = {}
                for i = 1, #buybot_gear do
                    table.insert(gear, buybot_gear[i]:GetValue() and i - 1 or nil)
                end

                local commands = {}

                table.insert(commands, get_command(primary_weapons, primary))
                table.insert(commands, get_command(secondary_weapons, pistol))

                for i = 1, #gear do
                    table.insert(commands, get_command(gear_weapons, gear[i]))
                end

                table.insert(commands, "use weapon_knife;")

                client.Command(table.concat(commands, ""), true)
            end
        end
    end
)
