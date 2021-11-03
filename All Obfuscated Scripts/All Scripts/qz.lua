--[[
	id: P6SJUzxd8cSULMMDTB2hJ
	name: qz
	description: qz
	time1: 2021-05-17 01:05:50.191434+00
	time2: 2021-05-17 01:05:50.191435+00
	uploader: fVUHyJTad_RsBNYRl8PKsfWiuch_NalH_XELv131
	uploadersession: sRTih8D3GRE0iTA0RyKMnv8lhiDjJF
	flag: f
--]]

local ui_table = _G["sexscript"]["UI"]
local library = ui_table[1]
local tab = ui_table[2]

-- Put at top of script:
local players_distance_table = {}
local pstructure
local vehiclestructure
local function ReturnPlayerStructure()
	local t = {}
	for _,v in pairs(getrenv()._G.PlayerList) do
	    if tostring(v) ~= tostring(game.Players.LocalPlayer) then
			table.insert(t, v.Character)
		end
	end
	return t
end
local function GetPlayerFromStructure(player)
	for _,v in pairs(ReturnPlayerStructure()) do
		if tostring(v) == tostring(player) then
			return v
		end
	end
	return nil
end
local function GetVehicleStructure()
	for _,v in pairs(workspace:GetDescendants()) do
		local name = tostring(v)
		if name == "jeep" or name == "ambulance" or name == "truck" or name == "minivan" or name == "police_car" then
			return v.Parent
		end
	end
end
local function GetBushStructure()
    for k,v in pairs(workspace["game_assets"]:GetDescendants()) do
        if tostring(v) == "bush" then
            return v.Parent
        end
    end
end
local function GetServerName()
	for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
		if v.ClassName == "TextLabel" then
			if string.match(v.Text, "Server Name: ") then
				return v.Text
			end
		end
	end
end
local function GetServerText()
	for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
		if v.ClassName == "TextLabel" then
			if string.match(v.Text, "Server Name: ") then
				return v
			end
		end
	end
end
local DISTANCE_UPDATE_DELAY = 200

local server_text = GetServerText()
local old_server_name = GetServerName()
local bush_folder = GetBushStructure()
local vehiclestructure = GetVehicleStructure()

local input_service = game:GetService("UserInputService")
local starter_gui = game:GetService("StarterGui")
local core_gui = game.CoreGui
local players = game:GetService("Players")
local camera_object = workspace.CurrentCamera
local runservice = game:GetService("RunService")
local local_player = game.Players.LocalPlayer
local mouse = local_player:GetMouse()
local lpname = local_player.Name
local defaultcolor = {0, 0, 255}
local defaultmaterial = "ForceField"
local health_colors = {
    ["Red"] = Color3.fromRGB(255,39,39),
    ["Orange"] = Color3.fromRGB(255,191,39),
    ["Green"] = Color3.fromRGB(155,255,39)
}
-- ESP Defaults
local esp_range = {["Min"] = 0,["Default"] = 1000,["Max"] = 10000}
local esp_font = "SourceSansSemibold"
local esp_font_size = {["Min"] = 8, ["Default"] = 12, ["Max"] = 24}
local y_offset_tags = 14
local health_colors = {
    ["Red"] = Color3.fromRGB(255,39,39),
    ["Orange"] = Color3.fromRGB(255,191,39),
    ["Green"] = Color3.fromRGB(155,255,39)
}
-- Chams Defaults
local chams_transparency = {["Min"] = 0, ["Default"] = 0.5, ["Max"] = 1}
-- Health Bar Defaults
local health_bars_width = {["Min"] = 1, ["Default"] = 3, ["Max"] = 5}
-- Tracer Defaults
local tracer_thickness = {["Min"] = 0.1, ["Default"] = 1, ["Max"] = 3}
local tracer_transparency = {["Min"] = 0, ["Default"] = 0.75, ["Max"] = 1}
local tracer_origin_default = "Bottom"
local viewport_size = workspace.CurrentCamera.ViewportSize
local start_point = (viewport_size.X / 2)
local tracer_origins = {
    ["Bottom"] = Vector2.new((viewport_size.X / 2), (viewport_size.Y + 30)),
    ["Top"] = Vector2.new((viewport_size.X / 2), 30),
    ["Mouse"] = Vector2.new((viewport_size.X / 2), (viewport_size.Y / 2))
}
-- Crosshair defaults
local crosshair_transparency = {["Min"] = 0, ["Default"] = 0, ["Max"] = 1}
local crosshair_thickness = {["Min"] = 0, ["Default"] = 2, ["Max"] = 4}
local crosshair_size = {["Min"] = 0, ["Default"] = 10, ["Max"] = 30}
-- Game defaults
local fastfire = {["Min"] = 0, ["Default"] = 500, ["Max"] = 10000}
local aimbot_fov = {["Min"] = 25, ["Default"] = 100, ["Max"] = 1000}
local walkspeed = {["Min"] = 0, ["Default"] = 50, ["Max"] = 100}
local jumppower = {["Min"] = 0, ["Default"] = 50, ["Max"] = 200}
local custom_daytime = {["Min"] = 0, ["Default"] = 12, ["Max"] = 24}
local v3mins = {["Min"] = -6, ["Default"] = 0, ["Max"] = 6}
local timeinms = {["Min"] = 25, ["Default"] = 200, ["Max"] = 500}
local crosshairsize = {["Min"] = 0, ["Default"] = 10, ["Max"] = 50}

local dt = game.Players.LocalPlayer.PlayerScripts.GunController.Data
local data_clone = game.ReplicatedStorage.GunData:Clone()
local hs_sound_1 = dt.Headshot:Clone()
local hs_sound_2 = dt.Headshot2:Clone()
local hitmark = dt.Hitmarker:Clone()
hs_sound_1.Parent = core_gui["sexstorage"]
hs_sound_2.Parent = core_gui["sexstorage"]
hitmark.Parent = core_gui["sexstorage"]
data_clone.Parent = core_gui["sexstorage"]
do -- util functions
	local li = {
		"PoliceVest",
		"MilvestBlack",
		"MilvestGrey",
		"MilvestTan",
		"MakeshiftBodyArmor",
		"MakeshiftBodyArmorWorld",

		"MilitaryHelmet",
		"MopedHelmet",
		"MakeshiftHelmet",

		--[["GhillieShirt",
		"DeputyShirt",
		"ConvictShirt",
		"PastorShirt",
		"ScrubsShirt",
		"BlueSuit",
		"GrayTShirt",
		"RedTShirt",
		"BlackTShirt",
		"ArcticTacticalShirt",
		"GreyTacticalShirt",
		"TanTacticalShirt",
		"BlackTacticalShirt",
		"WoodlandsTacticalShirt",
		"WetlandsTacticalShirt",
		"BluePlaidShirt",
		"PlaidShirt",
		"TanPlaidShirt",
		"BlackPlaidShirt",
		"Punisher",
		"BlackNLTShirt",
		"BlackSkullTShirt",]]

		--[["GreenCargoPants",
		"BrownPants",
		"GhilliePants",
		"GrayJeans",
		"ConvictPants",
		"ScrubsPants",
		"BlueSlacks",
		"KhakiJeans",
		"WhiteJeans",
		"BlackJeans",
		"TanTacticalPants",
		"BlackTacticalPants",
		"GreyTacticalPants",
		"ArcticTacticalPants",
		"WetlandsTacticalPants",
		"WoodlandsTacticalPants",
		"BlueJeans",]]

		--[["WhiteSneakers",
		"RedSneakers",
		"BrownBoots",
		"BlackBoots",
		"DressShoes",
		"BrownCowboyBoots",
		"TanCowboyBoots",]]

		"DeputyHat",
		"FirefighterHelmet",
		"WhiteBeanie",
		"BlackBeanie",
		"MilHelmetNV",
		"MilHelmet",
		"SkiMask",
		"BrownCowboyHat",
		"TanCowboyHat",
		"Fez",
		"Fedora",
		"SummerHat",
		"Flowerpot",
		"RiotHelmet",
		"PumpkinHelmet",
		"GreenCap",
		"RedCap",
		"BlueCap",

		"NightVision",
		"BlackTintAviators",
		"WeldingGoggles",
		"WeldingMask",
		"Monocle",

		"BlackFaceMask",
		"SkullBandana",
		"RedBandana",
		"BlueBandana",
		"BlackBandana",
		"OofdMask",

		"MilitaryHarness",
		"BlackLeatherBelt",
		"BrownLeatherBelt",
		"GreyLeatherBelt",
		"BrownFannyPack",
		"BrownFannyPackWorld"
	}
	function IsGear(name)
		name = tostring(name)
		for _,v in pairs(li) do
			if tostring(v) == name then
				return true
			end
		end
		return false
	end
	function table_to_hsv(t)
        if typeof(t) == "table" then
            local c = Color3.fromHSV(t[1]/360,t[2]/255,t[3])
            return c
        else
            return t
        end
    end
	function ParseNames(str)
		-- Attachments
		str = tostring(str)
		if str == nil then
			return "~"
		elseif str == "MilvestTan" then
			return "Tan Vest"
		elseif str == "MilvestBlack" then
			return "Black Vest"
		elseif str == "MilvestGrey" then
			return "Grey Vest"
		elseif str == "MilitaryHelmet" then
			return "Mili Helm"
		elseif str == "MilHelmet" then
			return "Mili Helm"
		elseif str == "MilHelmetNV" then
			return "Mili Helm"
		elseif str == "WhiteBeanie" then
			return "Beanie"
		elseif str == "BlackBeanie" then
			return "Beanie"
		elseif str == "MopedHelmet" then
			return "Moped"
		elseif str == "BrownCowboyHat" then
			return "Cowboy Hat"
		elseif str == "TanCowboyHat" then
			return "Cowboy Hat"
		elseif str == "PumpkinHelmet" then
			return "Pumpkin"
		elseif str == "NightVision" then
			return "NV"
		elseif str == "BlackTintAviators" then
			return "Aviators"
		elseif str == "WeldingGoggles" then
			return "Welding"
		elseif str == "WeldingMask" then
			return "Weld Mask"
		elseif str == "BlackFaceMask" then
			return "Facemask"
		elseif str == "BlackBandana" then
			return "Bandana"
		elseif str == "BlueBandana" then
			return "Bandana"
		elseif str == "RedBandana" then
			return "Bandana"
		elseif str == "MilitaryHarness" then
			return "Mil Harness"
		elseif str == "BrownFannyPack" then
			return "Fanny Pack"
		elseif tostring(str) == "nil" then
			return "~"
	    elseif string.match(str, "OspreySuppressor") then
	        return "Osprey"
	    elseif string.match(str, "SniperScope16x") then
	        return "16x"
	    elseif string.match(str, "SniperScope8x") then
	        return "8x"
	    elseif string.match(str, "SniperScope8xAlt") then
	        return "8x"
	    elseif string.match(str, "RedDot") then
	        return "Red Dot"
	    elseif string.match(str, "MakeShiftSuppressor") then
	        return "Bad Suppressor"
		elseif string.match(str, "MakeshiftSuppressor") then
			return "Bad Suppressor"
		elseif string.match(str, "MakeshiftScope") then
			return "Bad Scope"
		-- Tools
		elseif string.match(str, "HatchetMakeshift") then
	        return "Hatchet"
		elseif string.match(str, "FireAxe") then
	        return "Fire Axe"
		--Guns
	    elseif string.match(str, "HuntingRifle") then
	        return "R700"
		elseif string.match(str, "DesertEagle") then
	        return "Deagle"
		-- Utilities
	    elseif string.match(str, "GrenadeFlash") then
	        return "Flash"
	    elseif string.match(str, "GrenadeSmoke") then
	        return "Smoke"
	    elseif string.match(str, "GrenadeFrag") then
	        return "Frag"
	    end
	    return str
	end
	function GetPlayersWeapon(player)
        local pstring = tostring(player)
        if IsAlive(pstring) then
            local p = game.Players[pstring]
            if p:FindFirstChild("CurrentSelected") then
                local slot_selected = p.CurrentSelected.Value
                if p:FindFirstChild("GunInventory") and p.GunInventory:FindFirstChild("Slot" .. tostring(slot_selected)) then
                    local weapon = p.GunInventory["Slot" .. tostring(slot_selected)].Value
                    return tostring(weapon)
                end
            end
        else
            if pstring == game.Players.LocalPlayer.Name then
                local p = game.Players[pstring]
                if p:FindFirstChild("CurrentSelected") then
                    local slot_selected = p.CurrentSelected.Value
                    if p:FindFirstChild("GunInventory") and p.GunInventory:FindFirstChild("Slot" .. tostring(slot_selected)) then
                        local weapon = p.GunInventory["Slot" .. tostring(slot_selected)].Value
                        return tostring(weapon)
                    end
                end
            end
        end
        return "Fists"
    end
    function RandomString(length)
        local res = ""
        for i = 1, length do
            res = res .. string.char(math.random(97, 122))
        end
        return res
    end
    function NumToMs(n)
        if type(n) == "number" then
            return n/1000
        end
        return nil
    end
    function round(val, decimal)
        if (decimal) then
            return math.floor((val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
        else
            return math.floor(val + 0.5)
        end
    end
    function WrapFunction(time, func)
		local desiredInterval = time/1000
		local counter = 0
		game:GetService("RunService").Heartbeat:Connect(function(step)
			counter = counter + step
			if counter >= desiredInterval then
				counter = counter - desiredInterval
				func()
			end
		end)
    end
    -- UTIL FUNCTIONS (REPLACE/UPDATE THESE DEPENDING ON GAME)
	function IsTeammate(player)
        if game.Players:FindFirstChild(tostring(player)) then
            if local_player.Team ~= nil and local_player.Team == game.Players[tostring(player)].Team then
                return true
            end
        end
        return false
    end
	function IsAlive(player)

		player = tostring(player)
		local pobj = GetPlayerFromStructure(player)
		if pobj ~= nil and not (player == game.Players.LocalPlayer.Name) then
			if pobj:FindFirstChild("Head") then
				return true
			end
		end
		return false
	end
	function GetPlayerHead(player)
		player = tostring(player)
		local pobj = GetPlayerFromStructure(player)
		if pobj ~= nil and not (player == game.Players.LocalPlayer.Name) then
			local head = pobj:FindFirstChild("Head")
			if head ~= nil then
				return head
			end
		end
		return nil
	end
	function GetHealth(player)
		player = tostring(player)
		if IsAlive(player) and not (player == game.Players.LocalPlayer.Name) then
			local pobj = GetPlayerFromStructure(player)
			local humanoid = pobj:FindFirstChild("Humanoid")
			if humanoid ~= nil then
				return humanoid.Health
			end
		end
		return 0
	end
    function IsPlayer(player)
		local name = tostring(player)
        if game.Players:FindFirstChild(name) then
            return true
        end
        return false
    end
	function IsInventoryOpen()
        if local_player.PlayerGui.GameUI.Character.Visible then
            return true
        end
        return false
    end
end
WrapFunction(100, GetPlayerStructure)
_G.aimoffset = 0.26
_G.settings = {
	gui_toggle_key = "Insert",
	ui_theme = "Default",

	REMOVE_FOLIAGE_ON_INJECT = false,
    TRANSPARENT_BUSHES = false,
    GRASS_ENABLED = false,
	HIDE_SERVER_NAME_ON_INJECT = false,

	ESP_ENABLED = false,
	ESP_FONT = esp_font,
	ESP_FONT_OUTLINED = false,
	ESP_NAME_FILLED = false,
	ESP_FONT_SIZE = esp_font_size["Default"],
	ESP_RANGE = esp_range["Default"],
	ESP_NAMETAGS_TEAMCOLOR = false,
	ESP_NAME_FRIENDLY_COLOR = defaultcolor,
	ESP_NAME_ENEMY_COLOR = defaultcolor,
	ESP_DISTANCE_COLOR = defaultcolor,
	ESP_WEAPON_COLOR = defaultcolor,

	CHAMS_ENABLED = false,
	CHAMS_TEAMCHECK = false,
	CHAMS_TRANSPARENCY = chams_transparency["Default"],
	CHAMS_MATERIAL = defaultmaterial,
	CHAMS_FRIENDLY_COLOR = defaultcolor,
	CHAMS_ENEMY_COLOR = defaultcolor,

	SKELETON_CHAMS_ENABLED = false,
	SKELETON_CHAMS_COLOR = defaultcolor,

	HEALTH_BARS_ENABLED = false,
	HEALTH_BARS_WIDTH = health_bars_width["Default"],
	HEALTH_BARS_STYLE = "Left Side", -- ["Left Side", "Right Side", "Top", "Bottom"]
	HEALTH_BARS_HEALTH_BAR_COLOR = defaultcolor,
	HEALTH_BARS_DAMAGED_BAR_COLOR = defaultcolor,

	BOX_ESP_ENABLED = false,
	BOX_ESP_OUTLINE = false,
	BOX_ESP_OUTLINE_COLOR = {255,255,0},
	BOX_ESP_STYLE = "Box", -- ["Box", "Corners", "Long Corners"]
	BOX_ESP_TEAMCHECK = false,
	BOX_ESP_FRIENDLY_COLOR = defaultcolor,
	BOX_ESP_ENEMY_COLOR = defaultcolor,

	SNAPLINES_ENABLED = false,
	SNAPLINES_SNAP_MODE = "All", -- ["Target", "All", "Enemy"]
	SNAPLINES_THICKNESS = tracer_thickness["Default"],
	SNAPLINES_TRANSPARENCY = tracer_transparency["Default"],
	SNAPLINES_TEAMCHECK = false,
	SNAPLINES_FRIENDLY_COLOR = defaultcolor,
	SNAPLINES_ENEMY_COLOR = defaultcolor,
	SNAPLINES_TARGET_COLOR = defaultcolor,
	SNAPLINES_ORIGIN = tracer_origin_default,
	SNAPLINES_HEAD_POINT_ENABLED = false,
	SNAPLINES_HEAD_POINT_FRIENDLY_COLOR = defaultcolor,
	SNAPLINES_HEAD_POINT_ENEMY_COLOR = defaultcolor,
	SNAPLINES_HEAD_POINT_TARGET_COLOR = defaultcolor,

	WALKSPEED_ENABLED = false,
	WALKSPEED = walkspeed["Default"],
	WALKSPEED_TOGGLE_KEY = "Z",
	LAG_SPEED_ENABLED = false,
    LAG_SPEED = walkspeed["Default"],
    LAG_SPEED_DELAY = timeinms["Default"],
	SHOW_EXPANDED_HITBOX = false,
	GO_UNDER_MAP = false,
	TELESCOPIC_NECK = false,
	TELESCOPIC_NECK_MATCH_HEIGHT = false,
	CROUCH_HEIGHT_OFFSET = 100,
	NO_LEG_FRACTURES = false,
	NO_JUMP_COOLDOWN = false,

	ALWAYS_DAYTIME = false,
    CUSTOM_DAYTIME = false,
    FULL_BRIGHT = false,
    CUSTOM_DAYTIME_VALUE = custom_daytime["Default"],
    NO_FOG = false,
    CUSTOM_LIGHTING_COLOR = false,
    LIGHTING_COLOR = defaultcolor,
    CUSTOM_SKYBOX_ENABLED = false,
    CUSTOM_SKYBOX = "Missing Textures",

    AIMBOT_ENABLED = false,
    AIMBOT_PREDICITION = false,
    AIMBOT_FOV = aimbot_fov["Default"],
    AIMBOT_PART = "Head",
	AIMBOT_KEY = "F",

	FOV_CIRCLE_ENABLED = false,
    FOV_CIRCLE_COLOR = defaultcolor,
    FOV_CIRCLE_RAINBOW = false,
    FOV_CIRCLE_SHAPE = "Circle",

	CUSTOM_HITMARKER_NOISE = false,
	CUSTOM_HEADSHOT_NOISE = false,

	THICK_BULLET = false,

	NO_AIMCONE = false,
	NO_CAMERA_BOB = false,

	CUSTOM_GUN_OFFSET = false,
    CUSTOM_GUN_OFFSET_VECTOR_X = 0,
    CUSTOM_GUN_OFFSET_VECTOR_Y = 0,
    CUSTOM_GUN_OFFSET_VECTOR_Z = 0,
	INFO_BOARD_ENABLED = false,
	PLAYER_HEALTH_BAR = false,

	LANDMINE_ESP_ENABLED = false,
	LANDMINE_ESP_COLOR = defaultcolor,
	LANDMINE_ESP_RANGE = esp_range["Default"],
	LANDMINE_ESP_FONT = esp_font,
	LANDMINE_ESP_FONT_OUTLINED = false,
	LANDMINE_ESP_FONT_SIZE = esp_font_size["Default"],

	LANDMINE_BOXES_ENABLED = false,
	LANDMINE_BOXES_COLOR = defaultcolor,
	LANDMINE_BOXES_RANGE = esp_range["Default"],
	LANDMINE_BOXES_TYPE = "Box",
	LANDMINE_BOXES_OUTLINED = false,

	GRENADE_ESP_ENABLED = false,
	GRENADE_ESP_COLOR = defaultcolor,
	GRENADE_ESP_RANGE = esp_range["Default"],
	GRENADE_ESP_FONT = esp_font,
	GRENADE_ESP_FONT_OUTLINED = false,
	GRENADE_ESP_FONT_SIZE = esp_font_size["Default"],

	GRENADE_BOXES_ENABLED = false,
	GRENADE_BOXES_COLOR = defaultcolor,
	GRENADE_BOXES_RANGE = esp_range["Default"],
	GRENADE_BOXES_TYPE = "Box",
	GRENADE_BOXES_OUTLINED = false,

	VEHICLE_ESP_ENABLED = false,
	VEHICLE_ESP_COLOR = defaultcolor,
	VEHICLE_ESP_RANGE = esp_range["Default"],
	VEHICLE_ESP_FONT = esp_font,
	VEHICLE_ESP_FONT_OUTLINED = false,
	VEHICLE_ESP_FONT_SIZE = esp_font_size["Default"],

	VEHICLE_BOXES_ENABLED = false,
	VEHICLE_BOXES_COLOR = defaultcolor,
	VEHICLE_BOXES_RANGE = esp_range["Default"],
	VEHICLE_BOXES_TYPE = "Box",
	VEHICLE_BOXES_OUTLINED = false,

	PLAYER_BODY_ESP_ENABLED = false,
	PLAYER_BODY_ESP_COLOR = defaultcolor,
	PLAYER_BODY_ESP_RANGE = esp_range["Default"],
	PLAYER_BODY_ESP_FONT = esp_font,
	PLAYER_BODY_ESP_FONT_OUTLINED = false,
	PLAYER_BODY_ESP_FONT_SIZE = esp_font_size["Default"],

	PLAYER_BODY_BOXES_ENABLED = false,
	PLAYER_BODY_BOXES_COLOR = defaultcolor,
	PLAYER_BODY_BOXES_RANGE = esp_range["Default"],
	PLAYER_BODY_BOXES_TYPE = "Box",
	PLAYER_BODY_BOXES_OUTLINED = false,

	PLAYER_BODY_CHAMS_ENABLED = false,
	PLAYER_BODY_CHAMS_TRANSPARENCY = chams_transparency["Default"],
	PLAYER_BODY_CHAMS_MATERIAL = defaultmaterial,
	PLAYER_BODY_CHAMS_COLOR = defaultcolor,

	CUSTOM_GUN_COLOR_ENABLED = false,
    CUSTOM_GUN_COLOR = defaultcolor,
    CUSTOM_GUN_TRANSPARENCY = chams_transparency["Default"],
    CUSTOM_GUN_MATERIAL = "Plastic",

    CUSTOM_CHARACTER_COLOR_ENABLED = false,
    CUSTOM_CHARACTER_COLOR = defaultcolor,
    CUSTOM_CHARACTER_TRANSPARENCY = chams_transparency["Default"],
    CUSTOM_CHARACTER_MATERIAL = "Plastic",
    CUSTOM_SKIN_COLOR_ENABLED = false,
    CUSTOM_SKIN_COLOR = defaultcolor,
    CUSTOM_SKIN_TRANSPARENCY = chams_transparency["Default"],
    CUSTOM_SKIN_MATERIAL = "Plastic"
}
do -- ac bypass
	local function GetClientGameScript()
		for _,o in pairs(game.ReplicatedFirst.GameClient:GetChildren()) do
			if string.len(tostring(o)) > 20 and o.ClassName == "LocalScript" then
				return o
			end
		end
	end
	local client_game = GetClientGameScript()
	local waithook
	waithook = hookfunction(getrenv().wait, function(...)
		if not checkcaller() and tostring(getcallingscript()) == client_game.Name then
			return waithook(math.huge)
		end
		return waithook(...)
	end)
	local function disable_connections(signal,name)
		local con = getconnections(signal)
		for _,c in pairs(con) do
			c:Disable()
		end
	end
	disable_connections(game:GetService("ScriptContext").Error, "ScriptContextError")
end
do -- FOV Circle Stuff
    getgenv().fovcircle = Drawing.new("Circle")
    getgenv().fovsquare = Drawing.new("Square")
    _G.globalrainbow = nil
    local viewport_size = camera_object.ViewportSize
    local midx = (viewport_size.X / 2)
    local midy = (viewport_size.Y / 2)
    local center_of_screen_v = Vector2.new(midx, midy)
    fovcircle.Position = center_of_screen_v
    fovsquare.Position = center_of_screen_v
    function clearFOVCircle()
        fovcircle.Visible = false
        fovsquare.Visible = false
    end
    local function SetFOVCircleColor(i)
        if _G.settings.FOV_CIRCLE_RAINBOW then
            fovcircle.Color = Color3.fromHSV(i, 1, 1)
            fovsquare.Color = Color3.fromHSV(i, 1, 1)
        end
    end
    local FOV_CIRCLE_RAINBOW =
        coroutine.wrap(
        function()
            while true do
                for i = 0, 1, 0.01 do
                    _G.globalrainbow = Color3.fromHSV(i, 1, 1)
                    SetFOVCircleColor(i)
                    wait(0.07)
                end
            end
        end
    )
    FOV_CIRCLE_RAINBOW()
    function RedrawFOVCircle(state)
        clearFOVCircle()
        if state then
            fovsquare.Position = Vector2.new(midx - (_G.settings.AIMBOT_FOV*2 / 2), midy - (_G.settings.AIMBOT_FOV*2 / 2))
            if _G.settings.FOV_CIRCLE_SHAPE == "Circle" then
                fovcircle.Visible = true
                if not _G.settings.FOV_CIRCLE_RAINBOW then
                    fovcircle.Color = table_to_hsv(_G.settings.FOV_CIRCLE_COLOR)
                end
                fovcircle.NumSides = 32
                fovcircle.Thickness = 1.25
                fovcircle.Radius = _G.settings.AIMBOT_FOV
                fovsquare.Visible = false
            else
                fovsquare.Visible = true
                if not _G.settings.FOV_CIRCLE_RAINBOW then
                    fovsquare.Color = table_to_hsv(_G.settings.FOV_CIRCLE_COLOR)
                end
                fovsquare.Thickness = 1.25
                fovsquare.Size = Vector2.new(_G.settings.AIMBOT_FOV*2, _G.settings.AIMBOT_FOV*2)
                fovcircle.Visible = false
            end
        end
    end
end
do -- Lighting
    local lighting = game.Lighting
    local backup_table = {
        ["Ambient"] = lighting.Ambient,
        ["ColorShift_Top"] = lighting.ColorShift_Top,
        ["ColorShift_Bottom"] = lighting.ColorShift_Bottom,
        ["OutdoorAmbient"] = lighting.OutdoorAmbient,
        ["FogStart"] = lighting.FogStart,
        ["FogEnd"] = lighting.FogEnd
    }
    local UPDATE_LIGHTING =
        game:GetService("RunService").Heartbeat:Connect(
        function()
            if _G.settings.ALWAYS_DAYTIME then
                lighting.TimeOfDay = "12:00:00"
            end

            if _G.settings.CUSTOM_DAYTIME then
                lighting.TimeOfDay = _G.settings.CUSTOM_DAYTIME_VALUE
            end

            if _G.settings.NO_FOG then
                lighting.FogEnd = math.huge
                lighting.FogStart = math.huge
            else
                lighting.FogEnd = backup_table["FogEnd"]
                lighting.FogStart = backup_table["FogStart"]
            end

            if _G.settings.CUSTOM_LIGHTING_COLOR then
                lighting.Ambient = table_to_hsv(_G.settings.LIGHTING_COLOR)
                lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
                lighting.ColorShift_Bottom = table_to_hsv(_G.settings.LIGHTING_COLOR)
                lighting.OutdoorAmbient = table_to_hsv(_G.settings.LIGHTING_COLOR)
            else
                lighting.Ambient = backup_table["Ambient"]
                lighting.ColorShift_Top = backup_table["ColorShift_Top"]
                lighting.ColorShift_Bottom = backup_table["ColorShift_Bottom"]
                lighting.OutdoorAmbient = backup_table["OutdoorAmbient"]
            end
            if _G.settings.FULL_BRIGHT then
                lighting.Brightness = 10
            end
        end
    )
    local function UpdateNoFog()
        if _G.settings.NO_FOG then
            if lighting:FindFirstChild("Atmosphere") then
                lighting.Atmosphere.Parent = game.ReplicatedFirst
            end
        else
            if game.ReplicatedFirst:FindFirstChild("Atmosphere") then
                lighting.Atmosphere.Parent = lighting
            end
        end
    end
    WrapFunction(500, UpdateNoFog)
end
do -- Drawing stuff
	if Drawing and syn then
		local max_gui_distance = 400
		update_function_list = {}
	    local use_settings = _G.settings -- change to settings table
		local start_offset = -36
		local y_offset = 12
		local x_offset_amt = 1.3
		do -- Snaplines
	        snapline_table = {}
	        function RemoveSnaplines()
	            for k,t in pairs(snapline_table) do
	                if type(t) == "table" then
	                    for item,val in pairs(t) do
	                        if item == "Snapline" or item == "Triangle" then
	                            val:Remove()
	                        end
	                    end
	                    t = {}
	                end
	            end
	            snapline_table = {}
	        end
	        function CreateSnaplines()
	            RemoveSnaplines()
	            if use_settings.SNAPLINES_ENABLED then
	                for _,player in pairs(players:GetPlayers()) do
	                    if IsPlayer(player) and tostring(player) ~= lpname then
	                        local line = Drawing.new("Line")
	                        line.Thickness = use_settings.SNAPLINES_THICKNESS
	                        line.Transparency = use_settings.SNAPLINES_TRANSPARENCY
	                        local triangle = Drawing.new("Triangle")
	                        triangle.Filled = true
	                        if use_settings.SNAPLINES_TEAMCHECK then
	                            local is_team = IsTeammate(player)
	                            if is_team then
	                                line.Color = table_to_hsv(use_settings.SNAPLINES_FRIENDLY_COLOR)
	                                triangle.Color = table_to_hsv(use_settings.SNAPLINES_HEAD_POINT_FRIENDLY_COLOR)
	                            else
	                                line.Color = table_to_hsv(use_settings.SNAPLINES_ENEMY_COLOR)
	                                triangle.Color = table_to_hsv(use_settings.SNAPLINES_HEAD_POINT_ENEMY_COLOR)
	                            end
	                        else
	                            line.Color = table_to_hsv(use_settings.SNAPLINES_FRIENDLY_COLOR)
	                            triangle.Color = table_to_hsv(use_settings.SNAPLINES_HEAD_POINT_FRIENDLY_COLOR)
	                        end
	                        line.Visible = false
	                        table.insert(snapline_table, {
	                            ["Name"] = tostring(player),
	                            ["Team"] = IsTeammate(player),
	                            ["Snapline"] = line,
	                            ["Triangle"] = triangle
	                        })
	                    end
	                end
	            end
	        end
	        function UpdateSnaplinePositions()
	            if use_settings.SNAPLINES_ENABLED then
	                for k,t in pairs(snapline_table) do
	                    if type(t) == "table" then
	                        local player = t["Name"]
	                        local snapline = t["Snapline"]
	                        local triangle = t["Triangle"]
	                        local team = t["Team"]
	                        distance = nil or players_distance_table[tostring(player)]
	                        if IsAlive(player) and distance ~= nil and distance <= use_settings.ESP_RANGE then

	                            local passes = false
	                            if use_settings.SNAPLINES_SNAP_MODE == "All" then
	                                passes = true
	                            elseif use_settings.SNAPLINES_SNAP_MODE == "Enemy" then
	                                if team == false then
	                                    passes = true
	                                end
	                            elseif use_settings.SNAPLINES_SNAP_MODE == "Target" then
	                                if tostring(player) == tostring(_G.closestplayer) then
	                                    passes = true
	                                end
	                            end

	                            local head = GetPlayerHead(player)
	                            local vec3, on_screen = camera_object:WorldToScreenPoint(head.Position)
	                            if on_screen and passes then
	                                snapline.Visible = true
	                                if use_settings.SNAPLINES_HEAD_POINT_ENABLED then
	                                    triangle.Visible = true
	                                else
	                                    triangle.Visible = false
	                                end
	                                snapline.To = Vector2.new(vec3.X, vec3.Y + 27)
	                                triangle.PointA = Vector2.new(vec3.X, vec3.Y + 32)
	                                triangle.PointB = Vector2.new(vec3.X - 5, vec3.Y + 28)
	                                triangle.PointC = Vector2.new(vec3.X + 5, vec3.Y + 28)
	                                if string.match(use_settings.SNAPLINES_ORIGIN, "Bottom") then
	                                    snapline.From = tracer_origins["Bottom"]
	                                elseif string.match(use_settings.SNAPLINES_ORIGIN, "Mouse") then
	                                    snapline.From = tracer_origins["Mouse"]
	                                elseif string.match(use_settings.SNAPLINES_ORIGIN, "Top") then
	                                    snapline.From = tracer_origins["Top"]
	                                else
	                                    snapline.From = tracer_origins["Bottom"]
	                                end
	                            else
	                                snapline.Visible = false
	                                triangle.Visible = false
	                            end
	                        else
	                            snapline.Visible = false
	                            triangle.Visible = false
	                        end
	                    end
	                end
	            end
	        end
	        function UpdateSnaplineValues()
	            if use_settings.SNAPLINES_ENABLED then
	                for k,t in pairs(snapline_table) do
	                    if type(t) == "table" then

	                        local player = t["Name"]
	                        local is_team = t["Team"]
	                        local snapline = t["Snapline"]
	                        local triangle = t["Triangle"]
	                        local isrenderdestroyed = pcall(function() local a = snapline.Visible;local b = triangle.Visible; end)
	                        if isrenderdestroyed then
	                            snapline.Transparency = use_settings.SNAPLINES_TRANSPARENCY
	                            snapline.Thickness = use_settings.SNAPLINES_THICKNESS
	                            triangle.Transparency = table_to_hsv(use_settings.SNAPLINES_TRANSPARENCY)

	                            if _G.closestplayer ~= nil and tostring(player) == tostring(_G.closestplayer) then
	                                snapline.Color = table_to_hsv(use_settings.SNAPLINES_TARGET_COLOR)
	                                triangle.Color = table_to_hsv(use_settings.SNAPLINES_HEAD_POINT_FRIENDLY_COLOR)
	                            else
	                                if use_settings.SNAPLINES_TEAMCHECK then
	                                    if is_team then
	                                        snapline.Color = table_to_hsv(use_settings.SNAPLINES_FRIENDLY_COLOR)
	                                        triangle.Color = table_to_hsv(use_settings.SNAPLINES_HEAD_POINT_FRIENDLY_COLOR)
	                                    else
	                                        snapline.Color = table_to_hsv(use_settings.SNAPLINES_ENEMY_COLOR)
	                                        triangle.Color = table_to_hsv(use_settings.SNAPLINES_HEAD_POINT_ENEMY_COLOR)
	                                    end
	                                else
	                                    snapline.Color = table_to_hsv(use_settings.SNAPLINES_FRIENDLY_COLOR)
	                                    triangle.Color = table_to_hsv(use_settings.SNAPLINES_HEAD_POINT_FRIENDLY_COLOR)
	                                end
	                            end

	                            if is_team ~= IsTeammate(player) then
	                                CreateSnaplines()
	                            end
	                        end
	                    end
	                end
	            end
	        end
	        WrapFunction(100, UpdateSnaplineValues)
	        local function CheckPlayerChange()
	            if use_settings.SNAPLINES_ENABLED and ((#players:GetChildren() - 1) ~= #snapline_table) then
	                CreateSnaplines()
	            end
	        end
	        WrapFunction(250, CheckPlayerChange)
	        runservice:BindToRenderStep("snapline_update_pos", 999, UpdateSnaplinePositions)
	    end
		do -- Health Bars
			local hp_bar_table = {}
			local green = Color3.fromRGB(0,255,30)
			local red = Color3.fromRGB(255,68,0)
			healthbar_playeradd_function = players.PlayerDisconnecting:Connect(function()end)
			local width = 2
			local height = 0.12
			local offset = 0.025
			local gui_size = UDim2.new(7, 0, 5.75, 0)
			local color = Color3.fromRGB(255,255,255)

			function GetPlayerFromHPTable(player)
				for k,v in pairs(hp_bar_table) do
					for j,i in pairs(v) do
						if tostring(j) == tostring(player) then
							if i ~= nil and i.Parent ~= nil then
								return i
							end
						end
					end
				end
			end
			function DrawHealthBar(player)
				player = tostring(player)
				local pobj = GetPlayerFromStructure(player)
				local root = pobj:FindFirstChild("HumanoidRootPart")
				if pobj ~= nil and root ~= nil then
					if GetHealth(player) > 0 then
						local health = GetHealth(player)
						local board = Instance.new("BillboardGui")
						syn.protect_gui(board)
						board.Parent = root
						board.Name = "healthbargui"
						board.Size = gui_size
						board.MaxDistance = ((max_gui_distance/2) / 0.28)
						board.DistanceLowerLimit = 5
						board.DistanceUpperLimit = 5
						table.insert(hp_bar_table, {[player] = board})

						board.AlwaysOnTop = true
						local healthbarframe = Instance.new("Frame", board)
						healthbarframe.BorderSizePixel = 0
						healthbarframe.Name = "HPFRAME"
						healthbarframe.BackgroundColor3 = table_to_hsv(use_settings.HEALTH_BARS_HEALTH_BAR_COLOR)
						healthbarframe.BackgroundTransparency = 1
						local health_bar = Instance.new("Frame", healthbarframe)
						health_bar.BorderSizePixel = 0
						health_bar.Name = "HEALTH_BAR"
						health_bar.BackgroundColor3 = table_to_hsv(use_settings.HEALTH_BARS_HEALTH_BAR_COLOR)
						health_bar.ZIndex = 1001
						health_bar.BorderColor3 = Color3.fromRGB(0,0,0)
						local damaged_bar = Instance.new("Frame", healthbarframe)
						damaged_bar.BorderSizePixel = 0
						damaged_bar.Name = "DAMAGED_BAR"
						damaged_bar.BackgroundColor3 = table_to_hsv(use_settings.HEALTH_BARS_DAMAGED_BAR_COLOR)
						damaged_bar.BorderSizePixel = 1
						damaged_bar.BorderColor3 = Color3.fromRGB(0,0,0)
						damaged_bar.ZIndex = 1000
						local width = use_settings.HEALTH_BARS_WIDTH
						if use_settings.HEALTH_BARS_STYLE == "Left Side" then
							board.StudsOffset = Vector3.new(0,0,0)
							healthbarframe.Size = UDim2.new(0, width, 1, 0)
							healthbarframe.Position = UDim2.new(0, 0, 0, 0)
							health_bar.Position = UDim2.new(0, 0, 0, 0)
							damaged_bar.Position = UDim2.new(0, 0, 0, 0)
							health_bar.Size = UDim2.new(0, width, health/100, 0)
							damaged_bar.Size = UDim2.new(0, width, 1, 0)
						elseif use_settings.HEALTH_BARS_STYLE == "Right Side" then
							healthbarframe.Size = UDim2.new(0, width, 1, 0)
							board.StudsOffset = Vector3.new(0,0,0)
							healthbarframe.Position = UDim2.new(1, -width, 0, 0)
							health_bar.Position = UDim2.new(1, -width, 0, 0)
							damaged_bar.Position = UDim2.new(1, -width, 0, 0)
							health_bar.Size = UDim2.new(0, width, health/100, 0)
							damaged_bar.Size = UDim2.new(0, width, 1, 0)
						elseif use_settings.HEALTH_BARS_STYLE == "Top" then
							board.StudsOffset = Vector3.new(0,1.25,0)
							healthbarframe.Size = UDim2.new(1, 0, 0, width)
							healthbarframe.Position = UDim2.new(0, 0, 0, 0)
							health_bar.Position = UDim2.new(0, 0, 0, 0)
							damaged_bar.Position = UDim2.new(0, 0, 0, 0)
							health_bar.Size = UDim2.new(health/100, 0, 0, width)
							damaged_bar.Size = UDim2.new(1, 0, 0, width)
						elseif use_settings.HEALTH_BARS_STYLE == "Bottom" then
							board.StudsOffset = Vector3.new(0,-2,0)
							healthbarframe.Size = UDim2.new(1, 0, 0, width)
							healthbarframe.Position = UDim2.new(0, 0, 1, -width)
							health_bar.Position = UDim2.new(0, 0, 1, -width)
							damaged_bar.Position = UDim2.new(0, 0, 1, -width)
							health_bar.Size = UDim2.new(health/100, 0, 0, width)
							damaged_bar.Size = UDim2.new(1, 0, 0, width)
						end
						local hpchange
						hpchange = pobj.Humanoid.Changed:Connect(
							function(p)
								if p == "Health" then
									if IsAlive(player) then
										local health = GetHealth(player)
										if use_settings.HEALTH_BARS_STYLE == "Bottom" or use_settings.HEALTH_BARS_STYLE == "Top" then
											health_bar.Size = UDim2.new(health/100, 0, 0, width)
										elseif use_settings.HEALTH_BARS_STYLE == "Right Side" or use_settings.HEALTH_BARS_STYLE == "Left Side" then
											health_bar.Size = UDim2.new(0, width, health/100, 0)
										end
									end
								end
							end
						)
					end
				end
			end
			function RemoveHealthBars()
				for key,player in pairs(players:GetChildren()) do
					if IsAlive(player) then
						local board = GetPlayerFromHPTable(player)
						if board ~= nil and board.Parent ~= nil then
							board:Destroy()
						end
					end
				end
				hp_bar_table = {}
				healthbar_playeradd_function:Disconnect()
			end
			function DrawBarAll()
				RemoveHealthBars()
				if use_settings.HEALTH_BARS_ENABLED then
					healthbar_playeradd_function = players.ChildAdded:Connect(function(child)
						wait()
						if IsAlive(child) and tostring(child) ~= tostring(local_player) then
							DrawHealthBar(child)
						end
					end)
					for i,people in pairs(players:GetChildren()) do
						if tostring(people) ~= tostring(local_player) then
							if IsAlive(people) and use_settings.HEALTH_BARS_ENABLED then
								DrawHealthBar(people)
							end
						end
					end
				end
			end
		end
		do -- Box ESP
	        box_playeradd_function = players.PlayerDisconnecting:Connect(function()end)
	        local width = 2
	        local height = 0.12
	        local offset = 0.025
	        local stud_offset = Vector3.new(0, -0.25, 0)
	        local color = Color3.fromRGB(255,255,255)
			local box_esp_table = {}

	        function DrawBox(player)
				local name = tostring(player)
				local pobj = GetPlayerFromStructure(name)
	            if pobj ~= nil and name ~= local_player.Name then
	                if use_settings.BOX_ESP_TEAMCHECK then
	                    local ist = IsTeammate(player)
	                    if ist then
	                        color = table_to_hsv(use_settings.BOX_ESP_FRIENDLY_COLOR)
	                    else
	                        color = table_to_hsv(use_settings.BOX_ESP_ENEMY_COLOR)
	                    end
	                else
	                    color = table_to_hsv(use_settings.BOX_ESP_FRIENDLY_COLOR)
	                end
	                local board
					local use_borders = 0
					if use_settings.BOX_ESP_OUTLINE then
						use_borders = 1
					end
					local bordercolor = table_to_hsv(use_settings.BOX_ESP_OUTLINE_COLOR)
					local root = pobj.HumanoidRootPart
					if use_settings.BOX_ESP_STYLE == "Corners" then
	                    local gui_size = UDim2.new(5, 0, 6.25, 0)
	                    board = Instance.new("BillboardGui")
						syn.protect_gui(board)
						board.DistanceLowerLimit = 5
						board.DistanceUpperLimit = 5
						board.Parent = root
	                    board.Name = "boxesp"
	                    board.Size = gui_size
	                    board.StudsOffset = Vector3.new(0, 0, 0)
	                    board.AlwaysOnTop = true
						table.insert(box_esp_table, {[tostring(player)] = board})
						board.MaxDistance = (max_gui_distance / 0.28)
	                    do -- top left
	                        local top_side = Instance.new("Frame", board)
	                        top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = Color3.fromRGB(0,0,0)
	                        top_side.Name = "topleft_side"
	                        top_side.BackgroundColor3 = color
	                        top_side.Size = UDim2.new(height, 0, 0, width)
	                        top_side.Position = UDim2.new(0, 0, 0, 0)

	                        local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
	                        top_down.Name = "topleft_down"
	                        top_down.BackgroundColor3 = color
	                        top_down.Size = UDim2.new(0, width, height - offset, 0)
	                        top_down.Position = UDim2.new(0, 0, 0, 0)
	                    end
	                    do -- bottom left
	                        local top_side = Instance.new("Frame", board)
							top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = bordercolor
	                        top_side.Name = "bottomleft_side"
	                        top_side.BackgroundColor3 = color
	                        top_side.Size = UDim2.new(height, 0, 0, width)
	                        top_side.Position = UDim2.new(0, 0, 1, -width)

	                        local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
	                        top_down.Name = "bottomleft_down"
	                        top_down.BackgroundColor3 = color
	                        top_down.Size = UDim2.new(0, 3, height - offset, 0)
	                        top_down.Position = UDim2.new(0, 0, 1 - (height - offset), 0)
	                    end
	                    do -- top right
	                        local top_side = Instance.new("Frame", board)
							top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = bordercolor
	                        top_side.Name = "topright_side"
	                        top_side.BackgroundColor3 = color
	                        top_side.Size = UDim2.new(height, 0, 0, width)
	                        top_side.Position = UDim2.new(1 - height, 0, 0, 0)

	                        local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
	                        top_down.Name = "topright_down"
	                        top_down.BackgroundColor3 = color
	                        top_down.Size = UDim2.new(0, width, height - offset, 0)
	                        top_down.Position = UDim2.new(1, -3, 0, 0)
	                    end
	                    do -- bottom right
	                        local top_side = Instance.new("Frame", board)
							top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = bordercolor
	                        top_side.Name = "bottomright_side"
	                        top_side.BackgroundColor3 = color
	                        top_side.Size = UDim2.new(height, 0, 0, width)
	                        top_side.Position = UDim2.new(1 - height, 0, 1, -width)

	                        local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
	                        top_down.Name = "bottomright_down"
	                        top_down.BackgroundColor3 = color
	                        top_down.Size = UDim2.new(0, 3, height - offset, 0)
	                        top_down.Position = UDim2.new(1, -width, 1 - (height - offset), 0)
	                    end
					elseif use_settings.BOX_ESP_STYLE == "Long Corners" then
						local gui_size = UDim2.new(5, 0, 6.25, 0)
						board = Instance.new("BillboardGui")
						syn.protect_gui(board)
						board.DistanceLowerLimit = 5
						board.DistanceUpperLimit = 5
						board.Parent = root
						board.Name = "boxesp"
						board.Size = gui_size
						board.StudsOffset = Vector3.new(0, 0, 0)
						board.AlwaysOnTop = true
						table.insert(box_esp_table, {[tostring(player)] = board})
						board.MaxDistance = (max_gui_distance / 0.28)
						do -- top left
							height = 0.26
							local top_side = Instance.new("Frame", board)
							top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = bordercolor
							top_side.Name = "topleft_side"
							top_side.BackgroundColor3 = color
							top_side.Size = UDim2.new(height, 0, 0, width)
							top_side.Position = UDim2.new(0, 0, 0, 0)

							local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
							top_down.Name = "topleft_down"
							top_down.BackgroundColor3 = color
							top_down.Size = UDim2.new(0, width, height - offset, 0)
							top_down.Position = UDim2.new(0, 0, 0, 0)
						end
						do -- bottom left
							local top_side = Instance.new("Frame", board)
							top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = bordercolor
							top_side.Name = "bottomleft_side"
							top_side.BackgroundColor3 = color
							top_side.Size = UDim2.new(height, 0, 0, width)
							top_side.Position = UDim2.new(0, 0, 1, -width)

							local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
							top_down.Name = "bottomleft_down"
							top_down.BackgroundColor3 = color
							top_down.Size = UDim2.new(0, 3, height - offset, 0)
							top_down.Position = UDim2.new(0, 0, 1 - (height - offset), 0)
						end
						do -- top right
							local top_side = Instance.new("Frame", board)
							top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = bordercolor
							top_side.Name = "topright_side"
							top_side.BackgroundColor3 = color
							top_side.Size = UDim2.new(height, 0, 0, width)
							top_side.Position = UDim2.new(1 - height, 0, 0, 0)

							local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
							top_down.Name = "topright_down"
							top_down.BackgroundColor3 = color
							top_down.Size = UDim2.new(0, width, height - offset, 0)
							top_down.Position = UDim2.new(1, -3, 0, 0)
						end
						do -- bottom right
							local top_side = Instance.new("Frame", board)
							top_side.BorderSizePixel = use_borders
							top_side.BorderColor3 = bordercolor
							top_side.Name = "bottomright_side"
							top_side.BackgroundColor3 = color
							top_side.Size = UDim2.new(height, 0, 0, width)
							top_side.Position = UDim2.new(1 - height, 0, 1, -width)

							local top_down = Instance.new("Frame", board)
							top_down.BorderSizePixel = use_borders
							top_down.BorderColor3 = bordercolor
							top_down.Name = "bottomright_down"
							top_down.BackgroundColor3 = color
							top_down.Size = UDim2.new(0, 3, height - offset, 0)
							top_down.Position = UDim2.new(1, -width, 1 - (height - offset), 0)
						end
	                elseif use_settings.BOX_ESP_STYLE == "Box" then
	                    local gui_size = UDim2.new(4, 0, 6.1, 0)
	                    board = Instance.new("BillboardGui")
	                    board.Name = "boxesp"
						syn.protect_gui(board)
						board.DistanceLowerLimit = 5
						board.DistanceUpperLimit = 5
						board.Parent = root
	                    board.Size = gui_size
	                    board.StudsOffset = stud_offset
	                    board.AlwaysOnTop = true
						board.MaxDistance = (max_gui_distance / 0.28)
						table.insert(box_esp_table, {[name] = board})
	                    do -- top
	                        local top = Instance.new("Frame", board)
	                        top.BorderSizePixel = use_borders
							top.BorderColor3 = bordercolor
	                        top.Name = "top"
	                        top.BackgroundColor3 = color
	                        top.Size = UDim2.new(0.99, 0, 0, 1)
	                        top.Position = UDim2.new(0, 0, 0, 0)
	                    end
	                    do -- bottom
	                        local bottom = Instance.new("Frame", board)
	                        bottom.BorderSizePixel = use_borders
							bottom.BorderColor3 = bordercolor
	                        bottom.Name = "bottom"
	                        bottom.BackgroundColor3 = color
	                        bottom.Size = UDim2.new(0.99, 1, 0, 1)
	                        bottom.Position = UDim2.new(0, 0, 0.99, 0)
	                    end
	                    do -- left
	                        local left = Instance.new("Frame", board)
							left.BorderColor3 = bordercolor
	                        left.BorderSizePixel = use_borders
	                        left.Name = "left"
	                        left.BackgroundColor3 = color
	                        left.Size = UDim2.new(0, 1, 0.99, 0)
	                        left.Position = UDim2.new(0, 0, 0, 0)
	                    end
	                    do -- right
	                        local right = Instance.new("Frame", board)
							right.BorderColor3 = bordercolor
	                        right.BorderSizePixel = use_borders
	                        right.Name = "right"
	                        right.BackgroundColor3 = color
	                        right.Size = UDim2.new(0, 1, 0.99, 0)
	                        right.Position = UDim2.new(0.99, 0, 0, 0)
	                    end
	                end
	            end
	        end
			function GetPlayerFromBoxTable(player)
				for k,v in pairs(box_esp_table) do
					for j,i in pairs(v) do
						if tostring(j) == tostring(player) then
							if i ~= nil and i.Parent ~= nil then
								return i
							end
						end
					end
				end
			end
			function UpdateBoxESPColor()
				for _,v in pairs(players:GetChildren()) do
					if IsAlive(v) then
						local name = tostring(v)
						local board = GetPlayerFromBoxTable(name)
						if board ~= nil and board.Parent ~= nil then
							for j,k in pairs(board:GetChildren()) do
								if k:IsA("Frame") then
									local name = tostring(v)
									if use_settings.BOX_ESP_TEAMCHECK then
										local ist = IsTeammate(v)
										if not ist then
											k.BackgroundColor3 = table_to_hsv(use_settings.BOX_ESP_ENEMY_COLOR)
										end
									else
										k.BackgroundColor3 = table_to_hsv(use_settings.BOX_ESP_FRIENDLY_COLOR)
									end
									local use_borders = 0
									if use_settings.BOX_ESP_OUTLINE then
										use_borders = 1
									end
									k.BorderSizePixel = use_borders
									k.BorderColor3 = table_to_hsv(use_settings.BOX_ESP_OUTLINE_COLOR)
								end
							end
						end
					end
				end
			end
			function RemoveBoxes()
				box_playeradd_function:Disconnect()
				for _,v in pairs(players:GetChildren()) do
					if IsAlive(v) then
						local name = tostring(v)
						local board = GetPlayerFromBoxTable(name)
						if board ~= nil and board.Parent ~= nil then
							board:Destroy()
						end
					end
				end
				box_esp_table = {}
			end
	        function DrawBoxAll()
	            RemoveBoxes()
	            if use_settings.BOX_ESP_ENABLED then
	                box_playeradd_function = players.ChildAdded:Connect(function(child)
						wait()
	                    if IsAlive(child) and tostring(child) ~= tostring(local_player) then
	                        DrawBox(child)
	                    end
	                end)
	                for i,people in pairs(players:GetChildren()) do
	                    if IsAlive(people) and people.Name ~= local_player.Name and use_settings.BOX_ESP_ENABLED then
	                        DrawBox(people)
							UpdateBoxESPColor()
	                    end
	                end
	            end
	        end
			function UpdateTagsAllPlayers()
				RemoveBoxes()
				DrawBoxAll()
				UpdateBoxESPColor()
			end
	    end
		do -- ESP Nametags
			esp_table = {}
			esp_nametag_function = players.PlayerDisconnecting:Connect(function()end)
			function DrawTags(player)
				player = tostring(player)
				local pobj = GetPlayerFromStructure(player)
				if pobj ~= nil and IsAlive(player) and name ~= lpname and not (pobj.HumanoidRootPart:FindFirstChild("player_esp")) then
					color = table_to_hsv(use_settings.ESP_NAME_FRIENDLY_COLOR)
					if use_settings.ESP_NAMETAGS_TEAMCOLOR then
						local targ = game.Players[player]
						local team = targ.Team
						if team ~= nil then
							color = game.Teams[tostring(team)].TeamColor.Color
						else
							color = table_to_hsv(use_settings.ESP_NAME_FRIENDLY_COLOR)
						end
					end
					local board
					local use_borders = 0
					if not use_settings.ESP_FONT_OUTLINED then
						use_borders = 1
					end
					local wep = ParseNames(GetPlayersWeapon(player))
					local x_offset = (string.len(wep) + 11) * x_offset_amt
					local head = pobj.HumanoidRootPart
					local board = Instance.new("BillboardGui")
					board.Name = "player_esp"
					syn.protect_gui(board)
					board.Parent = head
					board.Size = UDim2.new(0, 125, 0, 300)
					board.StudsOffset = Vector3.new(0, 2, 0)
					board.DistanceLowerLimit = 5
					board.DistanceUpperLimit = 5
					board.AlwaysOnTop = true
					if (use_settings.ESP_RANGE) < 1 then
						board.MaxDistance = 1
					else
						board.MaxDistance = (use_settings.ESP_RANGE/0.28)
					end

					-- -20 + start_offset
					local nametag = Instance.new("TextLabel", board)
					nametag.Name = "name"
					nametag.BackgroundTransparency = 1
					nametag.TextStrokeTransparency = use_borders
					nametag.Size = UDim2.new(1, 0, 1, 0)
					nametag.Font = use_settings.ESP_FONT
					nametag.TextSize = use_settings.ESP_FONT_SIZE
					nametag.TextColor3 = color
					nametag.Text = player
					nametag.Position = UDim2.new(0,0,0,start_offset)

					local health = Instance.new("TextLabel", board)
					health.Name = "health"
					health.BackgroundTransparency = 1
					health.TextStrokeTransparency = use_borders
					health.Size = UDim2.new(1, 0, 1, 0)
					health.Position = UDim2.new(0,-x_offset,0,(start_offset + y_offset))
					health.Font = use_settings.ESP_FONT
					health.TextSize = use_settings.ESP_FONT_SIZE

					local dist = Instance.new("TextLabel", board)
					dist.Name = "dist"
					dist.BackgroundTransparency = 1
					dist.TextStrokeTransparency = use_borders
					dist.Size = UDim2.new(1, 0, 1, 0)
					dist.Position = UDim2.new(0,0,0,(start_offset + (y_offset*2)))
					dist.Font = use_settings.ESP_FONT
					dist.TextSize = use_settings.ESP_FONT_SIZE
					dist.TextColor3 = table_to_hsv(use_settings.ESP_DISTANCE_COLOR)

					local weapon = Instance.new("TextLabel", board)
					weapon.Name = "weapon"
					weapon.BackgroundTransparency = 1
					weapon.TextStrokeTransparency = use_borders
					weapon.Size = UDim2.new(1, 0, 1, 0)
					weapon.Font = use_settings.ESP_FONT
					weapon.TextSize = use_settings.ESP_FONT_SIZE
					weapon.TextColor3 = table_to_hsv(use_settings.ESP_WEAPON_COLOR)
					weapon.Text = wep
					weapon.Position = UDim2.new(0,x_offset,0,(start_offset + y_offset))
					local hp = round(GetHealth(player), 1)
					health.Text = "" .. tostring(hp) .. "%" .. ""
					if hp >= 80 then
						health.TextColor3 = health_colors["Green"]
					elseif hp >= 50 then
						health.TextColor3 = health_colors["Orange"]
					else
						health.TextColor3 = health_colors["Red"]
					end

					hpchange = pobj.Humanoid.Changed:Connect(
						function(p)
							if p == "Health" then
								if IsAlive(player) then
									local hp = round(GetHealth(player), 1)
									health.Text = "" .. tostring(hp) .. "%" .. ""
									if hp >= 80 then
										health.TextColor3 = health_colors["Green"]
									elseif hp >= 50 then
										health.TextColor3 = health_colors["Orange"]
									else
										health.TextColor3 = health_colors["Red"]
									end
								end
							end
						end
					)
					table.insert(esp_table, {[tostring(player)] = board})
				end
			end
			function GetPlayerFromESPTable(player)
				for k,v in pairs(esp_table) do
					for j,i in pairs(v) do
						if tostring(j) == tostring(player) then
							if i ~= nil and i.Parent ~= nil then
								return i
							end
						end
					end
				end
			end
			function RemoveTags()
				esp_nametag_function:Disconnect()
				for _,v in pairs(players:GetChildren()) do
					if IsAlive(v) then
						local name = tostring(v)
						local board = GetPlayerFromESPTable(name)
						if board ~= nil and board.Parent ~= nil then
							board:Destroy()
						end
					end
				end
				esp_table = {}
			end
			function UpdateTagsAll(player)
				local board = GetPlayerFromESPTable(tostring(player))
				if IsAlive(player) and board ~= nil and board.Parent ~= nil then
					if (use_settings.ESP_RANGE) < 1 then
						board.MaxDistance = 1
					else
						board.MaxDistance = (use_settings.ESP_RANGE/0.28)
					end

					local nametag = board["name"]
					local dist = board["dist"]
					local health = board["health"]
					local weapon = board["weapon"]

					local ist = IsTeammate(player)
					nametag.TextColor3 = table_to_hsv(use_settings.ESP_NAME_FRIENDLY_COLOR)
					if use_settings.ESP_TEAMCHECK then
						if not ist then
							nametag.TextColor3 = table_to_hsv(use_settings.ESP_NAME_ENEMY_COLOR)
						end
					end
					dist.TextColor3 = table_to_hsv(use_settings.ESP_DISTANCE_COLOR)
					weapon.TextColor3 = table_to_hsv(use_settings.ESP_WEAPON_COLOR)

					nametag.TextSize = use_settings.ESP_FONT_SIZE
					dist.TextSize = use_settings.ESP_FONT_SIZE
					health.TextSize = use_settings.ESP_FONT_SIZE
					weapon.TextSize = use_settings.ESP_FONT_SIZE

					local is_border = 0
					if not use_settings.ESP_FONT_OUTLINED then
						is_border = 1
					end

					local wep = ParseNames(GetPlayersWeapon(player))
					local x_offset = (string.len(wep) + 11) * x_offset_amt

					nametag.Position = UDim2.new(0,0,0,start_offset)
					health.Position = UDim2.new(0,-x_offset,0,(start_offset + y_offset))
					dist.Position = UDim2.new(0,0,0,(start_offset + (y_offset*2)))
					weapon.Position = UDim2.new(0,x_offset,0,(start_offset + y_offset))

					nametag.TextStrokeTransparency = is_border
					dist.TextStrokeTransparency = is_border
					health.TextStrokeTransparency = is_border
					weapon.TextStrokeTransparency = is_border

					nametag.Font = use_settings.ESP_FONT
					dist.Font = use_settings.ESP_FONT
					health.Font = use_settings.ESP_FONT
					weapon.Font = use_settings.ESP_FONT
				end
			end
			function UpdateTagsAllPlayers()
				for k,v in pairs(players:GetChildren()) do
					if IsPlayer(v) and IsAlive(v) and v.Name ~= lpname then
						UpdateTagsAll(v)
					end
				end
			end
			function DrawTagsAll()
				RemoveTags()
				if use_settings.ESP_ENABLED then
					esp_nametag_function = players.ChildAdded:Connect(function(child)
						wait()
						if IsPlayer(child) and tostring(child) ~= local_player.Name then
							DrawTags(child)
						end
					end)
					for i,people in pairs(players:GetChildren()) do
						local name = tostring(people)
						warn("Attempting ESP tags draw for " .. name)
						if IsAlive(name) and name ~= lpname then
							print("  !")
							DrawTags(people)
						end
						UpdateTagsAllPlayers()
					end
				end
				UpdateTagsAllPlayers()
			end
		end
		do -- Skeleton Chams
            skeletonchams_playeradd_function = players.PlayerDisconnecting:Connect(function()end)
			local s_chams_table = {}
			local sdecen_table = {}
            local faces = {"Front", "Back", "Left", "Right"}
            local function CheckPart(obj)
                if obj.Name == "fakehead" or (obj:IsA("Part") or obj:IsA("MeshPart")) and obj.Name ~= "HumanoidRootPart" and obj.Name ~= "Head" and (string.match(obj.Name, "Arm") or string.match(obj.Name, "Left") or string.match(obj.Name, "Torso") or string.match(obj.Name, "Hand") or string.match(obj.Name, "Foot")) then
					return true
                end
                return false
            end
            function DrawSkeletonChams(player)
				local name = tostring(player)
				local pobj = GetPlayerFromStructure(player)
                if IsAlive(player) and pobj ~= nil and name ~= local_player.Name then
                    for i,part in pairs(pobj:GetChildren()) do
                        if CheckPart(part) then
                            DrawSkeletonChamsPart(part)
                        end
                    end
                end
            end
            function RemoveSkeletonChams()
                skeletonchams_playeradd_function:Disconnect()
				for _,gui in pairs(s_chams_table) do
                    if gui ~= nil and gui.Parent ~= nil then
						gui:Destroy()
					end
                end
				for _,con in pairs(sdecen_table) do
					con:Disconnect()
				end
				s_chams_table = {}
            end
            function UpdateSkeletonChamsColor()
                for _,gui in pairs(s_chams_table) do
                    if gui ~= nil and gui.Parent ~= nil then
						gui.cham.BackgroundColor3 = use_settings.SKELETON_CHAMS_COLOR
					end
                end
            end
            function DrawSkeletonChamsPart(obj)
                local objname = tostring(obj)
                for i=0,3 do
                    surface = Instance.new("SurfaceGui")
                    syn.protect_gui(surface)
                    surface.Parent = obj
                    surface.Name = "skeleton_chams"
                    surface.Face = Enum.NormalId[faces[i + 1]]
                    surface.AlwaysOnTop = true
					table.insert(s_chams_table, surface)
                    frame = Instance.new("Frame",surface)
					frame.Name = "cham"
                    frame.Size = UDim2.new(0.065, 0, 0.85, 0)
                    frame.Position = UDim2.new(0.4,0,0,0)
                    frame.BorderSizePixel = 0
                    frame.ZIndex = 999
                    frame.BackgroundColor3 = table_to_hsv(use_settings.SKELETON_CHAMS_COLOR)
                end
            end
            function DrawSkeletonChamsAll()
                RemoveSkeletonChams()
                skeletonchams_playeradd_function = players.ChildAdded:Connect(function(child)
                    if use_settings.SKELETON_CHAMS_ENABLED and IsAlive(child) and not tostring(child) ~= local_player.Name then
                        wait()
                        DrawSkeletonChams(child)
                    end
                end)
                for i,people in pairs(players:GetChildren()) do
					local pobj = GetPlayerFromStructure(people)
                    if pobj ~= nil and IsAlive(people) and tostring(people) ~= local_player.Name then
                        if use_settings.SKELETON_CHAMS_ENABLED then
                            DrawSkeletonChams(people)
							local con = pobj.DescendantAdded:connect(function(c)
								wait()
								if tostring(c) == "fakehead" then
									DrawSkeletonChamsAll()
								end
							end)
							table.insert(sdecen_table, con)
                        end
                    end
                end
            end
        end
		do -- Visible Chams
	        chams_playeradd_function = players.PlayerDisconnecting:Connect(function()end)
			local descen_add_table  = {}
	        local function CheckPart(obj)
	            if (obj:IsA("Part") or obj:IsA("MeshPart")) and obj.Name ~= "HumanoidRootPart" and obj.Name ~= "Head" then
	                return true
	            end
	            return false
	        end
	        function DrawChams(player)
	                for i,part in pairs(player:GetDescendants()) do
	                    if CheckPart(part) then
	                        DrawChamsPart(part)
	                   end
	               end
	        end
	        function RemoveChams()
	            chams_playeradd_function:Disconnect()
				for _,v in pairs(descen_add_table) do
					v:Disconnect()
				end
	        end
	        function UpdateChamsColorPlayer(player)
	            for k,p in pairs(players:GetChildren()) do
					local pobj = GetPlayerFromStructure(player)
	                if pobj ~= nil and IsAlive(p) and tostring(p) == tostring(player) then
	                    for _,o in pairs(pobj:GetDescendants()) do
							if CheckPart(o) then
								if use_settings.CHAMS_TEAMCHECK then
									local ist = IsTeammate(p)
									if not ist then
										o.Color = table_to_hsv(use_settings.CHAMS_ENEMY_COLOR)
									else
										o.Color = table_to_hsv(use_settings.CHAMS_FRIENDLY_COLOR)
									end
								else
									o.Color = table_to_hsv(use_settings.CHAMS_FRIENDLY_COLOR)
								end
								o.Transparency = use_settings.CHAMS_TRANSPARENCY
								o.Material = use_settings.CHAMS_MATERIAL
							end
	                    end
	                end
	            end
	        end
	        function UpdateChamsColor()
	            for _,player in pairs(players:GetChildren()) do
					UpdateChamsColorPlayer(player)
	            end
	        end
	        function DrawChamsPart(obj)
				if CheckPart(obj) then
					if use_settings.CHAMS_TEAMCHECK then
						local ist = IsTeammate(p)
						if not ist then
							obj.Color = table_to_hsv(use_settings.CHAMS_ENEMY_COLOR)
						else
							obj.Color = table_to_hsv(use_settings.CHAMS_FRIENDLY_COLOR)
						end
					else
						obj.Color = table_to_hsv(use_settings.CHAMS_FRIENDLY_COLOR)
					end
					obj.Transparency = use_settings.CHAMS_TRANSPARENCY
					obj.Material = use_settings.CHAMS_MATERIAL
				end
	        end
	        function DrawChamsAll()
	            RemoveChams()
	            chams_playeradd_function = players.ChildAdded:Connect(function(child)
	                if use_settings.CHAMS_ENABLED and IsPlayer(child) and not tostring(child) ~= tostring(local_player) then
	               		wait()
	                	DrawChams(child)
	                end
	            end)
	            for i,people in pairs(players:GetChildren()) do
					local pobj = GetPlayerFromStructure(people)
	                if pobj ~= nil and IsAlive(people) and tostring(people) ~= local_player.Name then
	                    if use_settings.CHAMS_ENABLED then
	                        wait()
	                        DrawChams(people)
							local con = pobj.DescendantAdded:connect(function(c)
								UpdateChamsColorPlayer(people)
							end)
							table.insert(descen_add_table, con)
	                    end
	                end
	            end
	        end
	    end
		do -- Folder chams/esp
			function CreateFolderESP(control_var_name, folder, item_name, item_part_name, item_color_var, esp_range, esp_font_type, esp_font_outlined, esp_font_size, use_render_check, required_parent_name, offset, find_recursive)
				find_recursive = find_recursive or false
				if folder ~= nil and folder.Parent ~= nil then
					local stud_offset = offset or Vector3.new(0, -0.25, 0)
					local use_render_check = use_render_check or false
					local tags_table = {}
					local folder_child_added = players.PlayerDisconnecting:Connect(function()end)

					local control_var_name = tostring(control_var_name)
					local esp_font_type = tostring(esp_font_type)
					local esp_font_outlined = tostring(esp_font_outlined)
					local item_color_var = tostring(item_color_var)
					local esp_range = tostring(esp_range)
					local esp_font_size = tostring(esp_font_size)
					local partname = tostring(item_part_name)
					local esp_name = tostring(control_var_name) .. "_ESP"
					local function IsCorrectObject(object)
						if string.len(required_parent_name) == 0 then
							if tostring(object) == partname or object:FindFirstChild(partname) then
								return true
							end
						else
							local pname = tostring(object)
							if pname == required_parent_name or tostring(object.Parent) == pname then
								return true
							end
						end
						return false
					end
					local function DrawFolderTags(object)
						local name = tostring(object)
						if not (object:FindFirstChild(esp_name)) then
							color = table_to_hsv(use_settings[item_color_var])
							local board
							local use_borders = 0
							if not use_settings[esp_font_outlined] then
								use_borders = 1
							end
							local part = object
							local board = Instance.new("BillboardGui")
							board.Name = esp_name
							syn.protect_gui(board)
							board.Parent = part
							board.Size = UDim2.new(0, 125, 0, 300)
							board.StudsOffset = stud_offset
							board.DistanceLowerLimit = 5
							board.DistanceUpperLimit = 5
							board.AlwaysOnTop = true
							table.insert(tags_table, board)
							if (use_settings[esp_range]) < 1 then
								board.MaxDistance = 1
							else
								board.MaxDistance = (use_settings[esp_range]/0.28)
							end
							-- -20 + start_offset
							local nametag = Instance.new("TextLabel", board)
							nametag.Name = "name"
							nametag.BackgroundTransparency = 1
							nametag.TextStrokeTransparency = use_borders
							nametag.Size = UDim2.new(1, 0, 1, 0)
							nametag.Font = use_settings[esp_font_type]
							nametag.TextSize = use_settings[esp_font_size]
							nametag.TextColor3 = color
							if item_name == "Vehicle" then
								nametag.Text = item_name .. "  (" .. tostring(object.Parent.Parent) .. ")"
							else
								nametag.Text = item_name
							end
							if control_var_name == "VEHICLE_ESP_ENABLED" then
								nametag.Position = UDim2.new(0,0,0,start_offset - 20)
							else
								nametag.Position = UDim2.new(0,0,0,start_offset)
							end

							local dist = Instance.new("TextLabel", board)
							dist.Name = "dist"
							dist.BackgroundTransparency = 1
							dist.TextStrokeTransparency = use_borders
							dist.Size = UDim2.new(1, 0, 1, 0)
							if control_var_name == "VEHICLE_ESP_ENABLED" then
								dist.Position = UDim2.new(0,0,0,y_offset + (start_offset - 20))
							else
								dist.Position = UDim2.new(0,0,0,y_offset + start_offset)
							end

							dist.Font = use_settings[esp_font_type]
							dist.TextSize = use_settings[esp_font_size]
							dist.TextColor3 = color
							dist.Text = "0.0m"
							if item_name == "Vehicle" then
								nametag.ZIndex = 0
								dist.ZIndex = 0
							else
								nametag.ZIndex = 1
								dist.ZIndex = 1
							end
						end
					end
					local function RemoveCustomTags()
						folder_child_added:Disconnect()
						for _,v in pairs(tags_table) do
							if v ~= nil and v.Parent ~= nil then
								v:Destroy()
							end
						end
						tags_table = {}
					end
					local function UpdateCustomTagsAll()
						for _,board in pairs(tags_table) do
							if board ~= nil and board.Parent ~= nil then

								if (use_settings[esp_range]) < 1 then
									board.MaxDistance = 1
								else
									board.MaxDistance = (use_settings[esp_range]/0.28)
								end

								local nametag = board["name"]
								local dist = board["dist"]

								nametag.TextColor3 = table_to_hsv(use_settings[item_color_var])
								dist.TextColor3 = table_to_hsv(use_settings[item_color_var])

								local fs = use_settings[esp_font_size]
								nametag.TextSize = fs
								dist.TextSize = fs

								local is_border = 0
								if not use_settings[esp_font_outlined] then
									is_border = 1
								end

								nametag.TextStrokeTransparency = is_border
								dist.TextStrokeTransparency = is_border

								nametag.Font = use_settings[esp_font_type]
								dist.Font = use_settings[esp_font_type]
							end
						end
					end
					local function DrawCustomTagsAll()
						RemoveCustomTags()
						if use_settings[control_var_name] then
							folder_child_added = folder.ChildAdded:Connect(function(child)
								wait()
								if IsCorrectObject(child) then
									DrawFolderTags(child)
								end

							end)
							for i,object in pairs(folder:GetChildren()) do

								if find_recursive then
									local hasobj = object:FindFirstChild(partname, true)
									if hasobj then
										DrawFolderTags(hasobj)
									end
								else
									if IsCorrectObject(object) then
										DrawFolderTags(object)
									end
								end
								UpdateCustomTagsAll()
							end
						end
					end
					local function UpdateCustomDistances()
						if use_settings[control_var_name] then
							for _,board in pairs(tags_table) do
								if board ~= nil and board.Parent ~= nil then
									local dist = board["dist"]
									local object = board.Parent
									if find_recursive then
										object = object
									else
										object = object:FindFirstChild(partname, true)
									end
									if dist ~= nil and object ~= nil then
										vector, onScreen = camera_object:WorldToScreenPoint(object.Position)
										if onScreen then
											local stud_dist = local_player:DistanceFromCharacter(object.Position)
											stud_dist = (stud_dist * 0.28)
											stud_dist = round(stud_dist, 1)
											dist.Text = tostring(stud_dist) .. "m"
										end
									end
								end
							end
						end
					end
					WrapFunction(325, UpdateCustomDistances)
					if use_render_check then
						local rendered_objects = 0
						local function GetRenderedObjects()
							local n = 0
							for _,object in pairs(folder:GetChildren()) do
 								if control_var_name == "LANDMINE_ESP_ENABLED" then
									if tostring(object) == "PLACEABLE_LANDMINE" then
										if find_recursive then
											if object:FindFirstChild(partname, true) then
												n = n + 1
											end
										else
											if IsCorrectObject(object) then
												n = n + 1
											end
										end
									end
								else
									if find_recursive then
										if object:FindFirstChild(partname, true) then
											n = n + 1
										end
									else
										if IsCorrectObject(object) then
											n = n + 1
										end
									end
								end
							end
							return n
						end
						local function RenderCheck()
							local objs = GetRenderedObjects()
							if objs > rendered_objects then
								rendered_objects = objs
								DrawCustomTagsAll()
							end
						end
						WrapFunction(125, RenderCheck)
					end
					return {
						["Draw"] = DrawCustomTagsAll,
						["Update"] = UpdateCustomTagsAll
					}
				end
			end
			function CreateBoxesForFolder(control_var_name, folder, item_part_name, item_color_var, box_range, box_type, box_outlined, box_size, use_render_check, required_parent_name, soffset, find_recursive)
				find_recursive = find_recursive or false
				local stud_offset = soffset or Vector3.new(0, -0.25, 0)
				local use_render_check = use_render_check or false
				local box_objectadd_event = players.PlayerDisconnecting:Connect(function()end)
				local custom_box_table = {}
				local width = 2
				local height = 0.12
				local offset = 0.025
				local color = Color3.fromRGB(255,255,255)

				local control_var_name = tostring(control_var_name)
				local item_color_var = tostring(item_color_var)
				local box_range = tostring(box_range)
				local box_outlined = tostring(box_outlined)
				local box_type = tostring(box_type)
				local partname = tostring(item_part_name)

				local function IsCorrectObject(object)
					if string.len(required_parent_name) == 0 then
						if tostring(object) == partname or object:FindFirstChild(partname, true) then
							return true
						end
					else
						local pname = tostring(object)
						if pname == required_parent_name or tostring(object.Parent) == pname then
							return true
						end
					end
					return false
				end
				local function DrawCustomBox(object)
					if IsCorrectObject(object) and (not object:FindFirstChild("boxesp")) then
						color = table_to_hsv(use_settings[item_color_var])
						local board
						local use_borders = 0
						if use_settings[box_outlined] then
							use_borders = 1
						end
						local part = object

						local gui_size = box_size
						if use_settings[box_type] == "Corners" then
							local gui_size = box_size
							board = Instance.new("BillboardGui")
							syn.protect_gui(board)

							board.DistanceLowerLimit = 5
							board.DistanceUpperLimit = 5
							board.Parent = part
							board.Name = "boxesp"
							board.Size = gui_size
							stud_offset = soffset or Vector3.new(0, 0, 0)
							board.StudsOffset = stud_offset
							board.AlwaysOnTop = true
							if (use_settings[box_range]) < 1 then
								board.MaxDistance = 1
							else
								board.MaxDistance = (use_settings[box_range]/0.28)
							end

							table.insert(custom_box_table, board)
							do -- top left
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "topleft_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(0, 0, 0, 0)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "topleft_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, width, height - offset, 0)
								top_down.Position = UDim2.new(0, 0, 0, 0)
							end
							do -- bottom left
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "bottomleft_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(0, 0, 1, -width)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "bottomleft_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, 3, height - offset, 0)
								top_down.Position = UDim2.new(0, 0, 1 - (height - offset), 0)
							end
							do -- top right
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "topright_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(1 - height, 0, 0, 0)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "topright_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, width, height - offset, 0)
								top_down.Position = UDim2.new(1, -3, 0, 0)
							end
							do -- bottom right
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "bottomright_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(1 - height, 0, 1, -width)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "bottomright_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, 3, height - offset, 0)
								top_down.Position = UDim2.new(1, -width, 1 - (height - offset), 0)
							end
						elseif use_settings[box_type] == "Long Corners" then
							board = Instance.new("BillboardGui")
							syn.protect_gui(board)
							board.DistanceLowerLimit = 5
							board.DistanceUpperLimit = 5
							board.Parent = part
							board.Name = "boxesp"
							board.Size = gui_size
							stud_offset = soffset or Vector3.new(0, 0, 0)
							board.StudsOffset = stud_offset
							board.AlwaysOnTop = true
							if (use_settings[box_range]) < 1 then
								board.MaxDistance = 1
							else
								board.MaxDistance = (use_settings[box_range]/0.28)
							end
							table.insert(custom_box_table, board)
							do -- top left
								height = 0.26
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "topleft_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(0, 0, 0, 0)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "topleft_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, width, height - offset, 0)
								top_down.Position = UDim2.new(0, 0, 0, 0)
							end
							do -- bottom left
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "bottomleft_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(0, 0, 1, -width)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "bottomleft_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, 3, height - offset, 0)
								top_down.Position = UDim2.new(0, 0, 1 - (height - offset), 0)
							end
							do -- top right
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "topright_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(1 - height, 0, 0, 0)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "topright_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, width, height - offset, 0)
								top_down.Position = UDim2.new(1, -3, 0, 0)
							end
							do -- bottom right
								local top_side = Instance.new("Frame", board)
								top_side.BorderSizePixel = use_borders
								top_side.BorderColor3 = Color3.fromRGB(0,0,0)
								top_side.Name = "bottomright_side"
								top_side.BackgroundColor3 = color
								top_side.Size = UDim2.new(height, 0, 0, width)
								top_side.Position = UDim2.new(1 - height, 0, 1, -width)

								local top_down = Instance.new("Frame", board)
								top_down.BorderSizePixel = use_borders
								top_down.BorderColor3 = Color3.fromRGB(0,0,0)
								top_down.Name = "bottomright_down"
								top_down.BackgroundColor3 = color
								top_down.Size = UDim2.new(0, 3, height - offset, 0)
								top_down.Position = UDim2.new(1, -width, 1 - (height - offset), 0)
							end
						elseif use_settings[box_type] == "Box" then
							local gui_size = box_size
							board = Instance.new("BillboardGui")
							board.Name = "boxesp"
							syn.protect_gui(board)
							board.DistanceLowerLimit = 5
							board.DistanceUpperLimit = 5
							board.Parent = part
							board.Size = gui_size
							board.StudsOffset = stud_offset
							board.AlwaysOnTop = true
							if (use_settings[box_range]) < 1 then
								board.MaxDistance = 1
							else
								board.MaxDistance = (use_settings[box_range]/0.28)
							end
							table.insert(custom_box_table, board)
							do -- top
								local top = Instance.new("Frame", board)
								top.BorderSizePixel = use_borders
								top.BorderColor3 = Color3.fromRGB(0,0,0)
								top.Name = "top"
								top.BackgroundColor3 = color
								top.Size = UDim2.new(0.99, 0, 0, 1)
								top.Position = UDim2.new(0, 0, 0, 0)
							end
							do -- bottom
								local bottom = Instance.new("Frame", board)
								bottom.BorderSizePixel = use_borders
								bottom.BorderColor3 = Color3.fromRGB(0,0,0)
								bottom.Name = "bottom"
								bottom.BackgroundColor3 = color
								bottom.Size = UDim2.new(0.99, 1, 0, 1)
								bottom.Position = UDim2.new(0, 0, 0.99, 0)
							end
							do -- left
								local left = Instance.new("Frame", board)
								left.BorderColor3 = Color3.fromRGB(0,0,0)
								left.BorderSizePixel = use_borders
								left.Name = "left"
								left.BackgroundColor3 = color
								left.Size = UDim2.new(0, 1, 0.99, 0)
								left.Position = UDim2.new(0, 0, 0, 0)
							end
							do -- right
								local right = Instance.new("Frame", board)
								right.BorderColor3 = Color3.fromRGB(0,0,0)
								right.BorderSizePixel = use_borders
								right.Name = "right"
								right.BackgroundColor3 = color
								right.Size = UDim2.new(0, 1, 0.99, 0)
								right.Position = UDim2.new(0.99, 0, 0, 0)
							end
						end
					end
				end
				local function UpdateCustomBoxESPColor()
					for _,board in pairs(custom_box_table) do
						if board ~= nil and board.Parent ~= nil then

							if (use_settings[box_range]) < 1 then
								board.MaxDistance = 1
							else
								board.MaxDistance = (use_settings[box_range]/0.28)
							end

							for j,k in pairs(board:GetChildren()) do
								if k:IsA("Frame") then

									k.BackgroundColor3 = table_to_hsv(use_settings[item_color_var])
									local use_borders = 0
									if use_settings[box_outlined] then
										use_borders = 1
									end
									k.BorderSizePixel = use_borders
									k.BorderColor3 = Color3.fromRGB(0,0,0)

								end
							end
						end
					end
				end
				local function RemoveCustomBoxes()
					box_objectadd_event:Disconnect()
					for _,board in pairs(custom_box_table) do
						if board ~= nil and board.Parent ~= nil then
							board:Destroy()
						end
					end
					custom_box_table = {}
				end
				local function DrawCustomBoxAll()
					RemoveCustomBoxes()
					if use_settings[control_var_name] then
						box_objectadd_event = folder.ChildAdded:Connect(function(child)
							wait()
							if IsCorrectObject(child) then
								DrawCustomBox(child)
							end
						end)
						for i,object in pairs(folder:GetChildren()) do
							if find_recursive then
								local hasobj = object:FindFirstChild(partname, true)
								if hasobj then
									DrawCustomBox(hasobj)
								end
							else
								if IsCorrectObject(object) then
									DrawCustomBox(object)
								end
							end
							UpdateCustomBoxESPColor()
						end
					end
				end
				if use_render_check then
					local rendered_objects = 0
					local function GetRenderedObjects()
						local n = 0
						for _,object in pairs(folder:GetChildren()) do
							if IsCorrectObject(object) then
								n = n + 1
							end
						end
						return n
					end
					local function RenderCheck()
						local objs = GetRenderedObjects()
						if objs > rendered_objects then
							rendered_objects = objs
							DrawCustomBoxAll()
						end
					end
					WrapFunction(125, RenderCheck)
				end
				return {
					["Draw"] = DrawCustomBoxAll,
					["Update"] = UpdateCustomBoxESPColor
				}
			end
			function CreateVisibleChamsForFolder(control_var_name, folder, object_name, chams_color_var, chams_material, chams_transparency, use_render_check)
				local use_render_check = use_render_check or false
				local object_chams_event = players.PlayerDisconnecting:Connect(function()end)
				local event_table  = {}
				local control_var_name = tostring(control_var_name)
				local chams_color_var = tostring(chams_color_var)
				local chams_material = tostring(chams_material)
				local chams_transparency = tostring(chams_transparency)

				local function CustomCheckPart(obj)
					if (obj:IsA("Part") or obj:IsA("MeshPart")) and not (tostring(obj) == "main" or string.lower(tostring(obj)) == "flies" or obj:FindFirstChild("PointLight")) then
						return true
					end
					return false
				end

				local function IsValidModel(object)
					if tostring(object) == object_name then
						return true
					end
					return false
				end

				local function DrawCustomChamsPart(obj)
					if tostring(obj) ~= "main" then
						obj.Color = table_to_hsv(use_settings[chams_color_var])
						obj.Transparency = use_settings[chams_transparency]
						obj.Material = use_settings[chams_material]
					end
				end

				local function DrawCustomChams(object)
					for i, part in pairs(object:GetDescendants()) do
						if CustomCheckPart(part) then
							DrawCustomChamsPart(part)
						end
					end
				end

				local function RemoveCustomChams()
					object_chams_event:Disconnect()
					for _,event in pairs(event_table) do
						event:Disconnect()
					end
				end

				local function UpdateCustomChamsColor()
					for k,p in pairs(folder:GetChildren()) do
						if IsValidModel(p) then
							if CustomCheckPart(p) then
								p.Color = table_to_hsv(use_settings[chams_color_var])
								p.Transparency = use_settings[chams_transparency]
								p.Material = use_settings[chams_material]
							end
							for _,o in pairs(p:GetDescendants()) do
								if CustomCheckPart(o) then

									o.Color = table_to_hsv(use_settings[chams_color_var])
									o.Transparency = use_settings[chams_transparency]
									o.Material = use_settings[chams_material]

								end
							end
						end
					end
				end

				local function UpdateCustomChamsColorForModel(model)
					for k, p in pairs(model:GetDescendants()) do
						if CustomCheckPart(p) then
							p.Color = table_to_hsv(use_settings[chams_color_var])
							p.Transparency = use_settings[chams_transparency]
							p.Material = use_settings[chams_material]
						end
					end
				end

				local function DrawCustomChamsAll()
					RemoveCustomChams()
					object_chams_event = folder.ChildAdded:Connect(function(child)
						wait()
						if tostring(child) == "RagDoll" then
							wait(1)
						end
						if use_settings[control_var_name] and IsValidModel(child) then
							DrawCustomChams(child)
						end
					end)
					for i,object in pairs(folder:GetChildren()) do
						if IsValidModel(object) and use_settings[control_var_name] then
							DrawCustomChams(object)
							local con = object.DescendantAdded:connect(function(c)
								UpdateCustomChamsColorForModel(object)
							end)
							table.insert(event_table, con)
						end
					end
				end

				if use_render_check then
					local rendered_objects = 0
					local function GetRenderedObjects()
						local n = 0
						for _,object in pairs(folder:GetChildren()) do
							if IsValidModel(object) then
								n = n + 1
							end
						end
						return n
					end
					local function RenderCheck()
						local objs = GetRenderedObjects()
						if objs > rendered_objects then
							rendered_objects = objs
							DrawCustomChamsAll()
						end
					end
					WrapFunction(125, RenderCheck)
				end

				return {
					["Draw"] = DrawCustomChamsAll,
					["Update"] = UpdateCustomChamsColor
				}
			end
		end
		function DrawAll()
			wait(1/1000)
			CreateSnaplines()
			wait(1/1000)
			DrawBarAll()
			wait(1/1000)
			DrawTagsAll()
			wait(1/1000)
			UpdateTagsAllPlayers()
			wait(1/1000)
			DrawBoxAll()
			wait(1/1000)
			DrawSkeletonChamsAll()
			wait(1/1000)
			DrawChamsAll()
			wait(1/1000)
			for _,f in pairs(update_function_list) do
				if typeof(f) == "function" and islclosure(f) then
					wait(1/1000)
					f()
				end
			end
	    end
		local rendered_players = 0
		function CompareRenderedPlayers()
			local new_rendered_players = 0
			for _,v in pairs(players:GetChildren()) do
				if IsAlive(v) and tostring(v) ~= lpname then
					new_rendered_players = new_rendered_players + 1
				end
			end
			if new_rendered_players ~= rendered_players then
				rendered_players = new_rendered_players
				DrawAll()
			end
		end
		WrapFunction(2500, CompareRenderedPlayers)
	    local kp = game:GetService("UserInputService").InputBegan:Connect(function(pressed)
	        if pressed.KeyCode == Enum.KeyCode.Delete then
	            DrawAll()
	        end
	    end)
		local function UpdateDistanceTable()
			players_distance_table = {}
			for indx, player in pairs(players:GetChildren()) do
				local name = tostring(player)
				local head = GetPlayerHead(name)
				if IsAlive(player) and name ~= lpname and head ~= nil then
					local stud_dist = local_player:DistanceFromCharacter(head.Position)
					stud_dist = (stud_dist * 0.28)
					players_distance_table[tostring(player)] = round(stud_dist, 1)
					local t = GetPlayerFromESPTable(player)
					if t ~= nil then
						local board = t
						if board.Parent ~= nil then
							local dist = board["dist"]
							local weapon = board["weapon"]
							local name = board["name"]
							dist.Text = "" .. tostring(players_distance_table[tostring(player)]) .. "m"
							weapon.Text = ParseNames(GetPlayersWeapon(player))
							if use_settings.ESP_NAMETAGS_TEAMCOLOR then
								local targ = game.Players[tostring(player)]
								local team = targ.Team
								if team ~= nil then
									name.TextColor3 = game.Teams[tostring(team)].TeamColor.Color
								else
									name.TextColor3 = table_to_hsv(use_settings.ESP_NAME_FRIENDLY_COLOR)
								end
							else
								name.TextColor3 = table_to_hsv(use_settings.ESP_NAME_FRIENDLY_COLOR)
							end
						end
					end
				end
			end
		end
		WrapFunction(DISTANCE_UPDATE_DELAY, UpdateDistanceTable)
	end
end
do -- Game hacks
	local_player.ChildAdded:connect(function(child)
		wait()
		if _G.settings.NO_LEG_FRACTURES and tostring(child) == "broken_leg" then
			child:Destroy()
		end
	end)
	_G.WS_TOGGLE = false
    w_held = false
    s_held = false
    a_held = false
    d_held = false
    x_held = false
	leftalt_held = false
    local last_pos = Vector3.new()
    local function MapSpeed(n)
        return (n/100)*(-1)
    end
    function KeyPress(inputObject,gameProcessedEvent)
      if inputObject.KeyCode == Enum.KeyCode.W and gameProcessedEvent == false then
          w_held = true
      end
      if inputObject.KeyCode == Enum.KeyCode.X and gameProcessedEvent == false then
          x_held = true
          last_pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
      end
	  if inputObject.KeyCode == Enum.KeyCode.LeftAlt and gameProcessedEvent == false then
          leftalt_held = true
          last_pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
      end
      if inputObject.KeyCode == Enum.KeyCode.S and gameProcessedEvent == false then
          s_held = true
      end
      if inputObject.KeyCode == Enum.KeyCode.A and gameProcessedEvent == false then
          a_held = true
      end
      if inputObject.KeyCode == Enum.KeyCode.D and gameProcessedEvent == false then
          d_held = true
      end
    end
    function ReleaseKey(inputObject,gameProcessedEvent)
        if inputObject.KeyCode == Enum.KeyCode.W and gameProcessedEvent == false then
            w_held = false
        end
        if inputObject.KeyCode == Enum.KeyCode.S and gameProcessedEvent == false then
            s_held = false
        end
        if inputObject.KeyCode == Enum.KeyCode.A and gameProcessedEvent == false then
            a_held = false
        end
        if inputObject.KeyCode == Enum.KeyCode.D and gameProcessedEvent == false then
            d_held = false
        end
        if inputObject.KeyCode == Enum.KeyCode.X and gameProcessedEvent == false then
            x_held = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pos
        end
		if inputObject.KeyCode == Enum.KeyCode.LeftAlt and gameProcessedEvent == false then
            leftalt_held = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pos
        end
    end
    game:GetService("UserInputService").InputBegan:connect(KeyPress)
    game:GetService("UserInputService").InputEnded:connect(ReleaseKey)
	local teleheight = CFrame.new(0, 8, 0)
    game:GetService("RunService").Heartbeat:connect(
        function()
            if (w_held == true or s_held == true or a_held == true or d_held == true) and _G.settings.WALKSPEED_ENABLED and _G.WS_TOGGLE then
                local mspeed = MapSpeed(_G.settings.WALKSPEED)
                if w_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, (mspeed)) -- forward
                end
                if s_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, (-mspeed)) -- back
                end
                if d_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new((-mspeed), 0, 0) -- right
                end
                if a_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new((mspeed), 0, 0)-- left
                end
            end
            if x_held and _G.settings.GO_UNDER_MAP then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pos * CFrame.new(0, -5.25, 0)
            elseif leftalt_held and _G.settings.TELESCOPIC_NECK then
				if _G.settings.TELESCOPIC_NECK_MATCH_HEIGHT then
					if _G.closestplayer ~= nil and IsAlive(_G.closestplayer) then
						local head = GetPlayerHead(_G.closestplayer)
						if head then
							local lcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
							local new_cframe = CFrame.new(lcframe.X, head.Position.Y, lcframe.Z)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = new_cframe
						end
					else
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pos * CFrame.new(0, _G.settings.CROUCH_HEIGHT_OFFSET, 0)
					end
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pos * CFrame.new(0, _G.settings.CROUCH_HEIGHT_OFFSET, 0)
				end
			end
        end
    )
	local newindex = getrawmetatable(game).__newindex
    setreadonly(getrawmetatable(game), false)
    getrawmetatable(game).__newindex = function(t, i, v)
        if checkcaller() and string.match(tostring(i), "JumpPower") then
            if _G.settings.JUMPPOWER_ENABLED then
                return newindex(t, i, _G.settings.JUMPPOWER)
            end
        end
        return newindex(t, i, v)
    end
	local function LagSpeed()
        if _G.settings.LAG_SPEED_ENABLED and (not _G.settings.WALKSPEED_ENABLED) then
            if (w_held == true or s_held == true or a_held == true or d_held == true) then
                local mspeed = MapSpeed(_G.settings.LAG_SPEED)
                if w_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, (mspeed)) -- forward
                end
                if s_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, (-mspeed)) -- back
                end
                if d_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new((-mspeed), 0, 0) -- right
                end
                if a_held then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new((mspeed), 0, 0)-- left
                end
            end
        end
    end
    local LagSpeedRunner = coroutine.wrap(function()
        while true do
            wait(_G.settings.LAG_SPEED_DELAY/1000)
            LagSpeed()
        end
    end)
    LagSpeedRunner()

	function Action(Object, Function) if Object ~= nil then Function(Object); end end
    infinite_jump_input = input_service.InputBegan:connect(function(UserInput)
        if UserInput.KeyCode == Enum.KeyCode.Space then
            if _G.settings.INFINITE_JUMP then
                Action(local_player.Character.Humanoid, function(self)
                    if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                        Action(self.Parent.HumanoidRootPart, function(self)
                            self.Velocity = Vector3.new(0, _G.settings.JUMPPOWER + 10, 0);
                        end)
                    end
                end)
            end
        end
    end)
	_G.NO_CLIP_TOGGLED = false
    game:GetService("RunService").Heartbeat:Connect(function()
        if _G.NO_CLIP_TOGGLED and _G.settings.NO_CLIP_ENABLED then
            local_player.Character.Humanoid:ChangeState(11)
        end
    end)
end
do -- Aimbot Module
    _G.NO_CLIP_TOGGLED = false
    _G.closestplayer = nil
    function GetPlayerClosestToMouse(fov)
        local smallest_dist = 5000
        local current_player = nil
        local mouse = local_player:GetMouse()
        local mousepos = Vector2.new(mouse.X, mouse.Y)
        local camera = camera_object
        local distances = {}
        for _,pl in pairs(players:GetChildren()) do
			pl = tostring(pl)
			local pobj = GetPlayerFromStructure(pl)
            if pobj ~= nil and IsAlive(pl) and tostring(pl) ~= tostring(local_player) and GetHealth(pl) > 0 and not IsTeammate(pl) then
                local aimpart = _G.settings.AIMBOT_PART
                local vector
                local onScreen
                local part
                local head = GetPlayerHead(pl)
                if aimpart == "Head" then
                    part = head.Position
                    vector, onScreen = camera:WorldToScreenPoint(head.Position)
                else
                    part = pstructure[tostring(pl)].UpperTorso.Position
                    vector, onScreen = camera:WorldToScreenPoint(pobj.UpperTorso.Position)
                end
                local stud_dist = local_player:DistanceFromCharacter(part)
                local studs_to_meters = (stud_dist * 0.28)
                studs_to_meters = round(studs_to_meters, 1)
                if onScreen and studs_to_meters <= _G.settings.ESP_RANGE then
                    v = Vector2.new(vector.X, vector.Y)
                    d = math.sqrt(math.pow(mousepos.X - v.X, 2) + math.pow(mousepos.Y - v.Y, 2))
                    if fov == 0 then
                        table.insert(distances, {pl, d})
                    else
                        if d <= fov then
                            table.insert(distances, {pl, d})
                        end
                    end
                end
            end
        end
        for _,value in pairs(distances) do
            if value[2] < smallest_dist then
                smallest_dist = value[2]
                current_player = value[1]
            end
        end
        return current_player
    end
    local player = local_player
    local mouse = player:GetMouse()
    local screensizex = mouse.ViewSizeX
    local screensizey = mouse.ViewSizeY
    local midx = screensizex / 2
    local midy = screensizey / 2
    local vps = camera_object.ViewportSize
    local vpsx = vps.X
    local vpsy = vps.Y
    local screencenterx = vpsx / 2
    local screencentery = vpsy / 2
    _G.aimspeed = 2
    local AimAt = function(x, y)
        local aimatx
        local aimaty
        if x ~= 0 then
            if x > screencenterx then
                aimatx = -(screencenterx - x)
                aimatx = aimatx / _G.aimspeed
                if aimatx + screencenterx > screencenterx * 2 then
                    aimatx = 0
                end
            end
            if x < screencenterx then
                aimatx = x - screencenterx
                aimatx = aimatx / _G.aimspeed
                if aimatx + screencenterx < 0 then
                    aimatx = 0
                end
            end
        end

        if y ~= 0 then
            if y > screencentery then
                aimaty = -(screencentery - y)
                aimaty = aimaty / _G.aimspeed
                if aimaty + screencentery > screencentery * 2 then
                    aimaty = 0
                end
            end
            if y < screencentery then
                aimaty = y - screencentery
                aimaty = aimaty / _G.aimspeed
                if aimaty + screencentery < 0 then
                    aimaty = 0
                end
            end
        end
        return aimatx, aimaty
	end
    local function DoAimbot()
		local sp = tostring(_G.closestplayer)
        if _G.closestplayer ~= nil and IsAlive(sp) and not IsInventoryOpen() then
            local moveamountx = midx - mouse.X
            local moveamounty = midy - mouse.Y
            local closesthead = GetPlayerHead(sp)
            if closesthead then
				local pobj = GetPlayerFromStructure(sp)
				if _G.settings.AIMBOT_PART == "Torso" then
					closesthead = pobj.HumanoidRootPart
				end
                local p = camera_object:WorldToScreenPoint(closesthead.Position)
                local dist = players_distance_table[sp] or 0
				local min = 30
                if dist < 100 then
                    min = 32
                end
                if _G.settings.AIMBOT_PREDICITION then
					min = min - (players_distance_table[tostring(_G.closestplayer)] * 0.02)
                    local bulletspeed = game["blockstorage"].GunData[GetPlayersWeapon(local_player.Name)].Stats.BulletSettings
                    if bulletspeed:FindFirstChild("BulletSpeed") then
                        min = min + (bulletspeed.BulletSpeed.Value * 0.007)
                        if players_distance_table[sp] > 200 then
                            min = min - (players_distance_table[sp] * 0.06)
                            --min = min - (bulletspeed.BulletSpeed.Value * 0.014)
                        elseif players_distance_table[sp] > 400 then
                            min = min - (players_distance_table[sp] * 0.1)
                            --min = min - (bulletspeed.BulletSpeed.Value * 0.2)
                        else
                            --min = min - (bulletspeed.BulletSpeed.Value * 0.02)
                        end
                        min = min - math.pow((5750-bulletspeed.BulletSpeed.Value), _G.aimoffset)
                    else
                        --min = min - (1500 * 0.003)
                        min = min - math.pow((5750-1500), _G.aimoffset)
                    end
                end
				--local hrroot = pstructure[tostring(_G.closestplayer)].HumanoidRootPart
                --local human = pstructure[tostring(_G.closestplayer)].Humanoid
                --local movedir = (hrroot.CFrame:inverse()*CFrame.new(Vector3.new(0,-1,0),human.MoveDirection)).LookVector

                local x_offset_movement = 0
                local z_offset_movement = 0
                --[[if movedir.X > 0.2 then
                    x_offset_movement = 20
                elseif movedir.X < -0.2 then
                    x_offset_movement = -20
                end

                if movedir.Z > 0.2 then
                    z_offset_movement = -10
                elseif movedir.Z < -0.2 then
                    z_offset_movement = 10
                end]]
				local xdistancetohead, ydistancetohead = AimAt(p.X + x_offset_movement, p.Y + min + z_offset_movement)
                mousemoverel(moveamountx + xdistancetohead, moveamounty + ydistancetohead)
            end
        end
    end
    _G.holding_right_click = false
    function onKeyPress(inputObject, gameProcessed)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton2 and not _G.KEY_TO_TARGET then
            _G.holding_right_click = true
        end
    end
    function onKeyRelease(inputObject, gameProcessed)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
            _G.holding_right_click = false
        end
    end
    game:GetService("UserInputService").InputBegan:connect(onKeyPress)
    game:GetService("UserInputService").InputEnded:connect(onKeyRelease)

    _G.is_holding_aim_key = false
    local releasefunc
    local pressfunc
    aimbotservice =
        game:GetService("RunService").RenderStepped:Connect(
        function()
            if _G.settings.AIMBOT_ENABLED and _G.holding_right_click then
                DoAimbot()
            end
        end
    )
    local function GetNearestTarget()
		if _G.closestplayer ~= nil then
			if IsAlive(_G.closestplayer) and GetHealth(_G.closestplayer) <= 0  then
				_G.closestplayer = nil
			end
		end
		local t = GetPlayerClosestToMouse(_G.settings.AIMBOT_FOV)
		_G.closestplayer = t
	end
    WrapFunction(10, GetNearestTarget)
end
do

	local RandomNewHook
	RandomNewHook = hookfunction(getrenv().Random.new, function(seed)
		if _G.settings.NO_AIMCONE and tostring(getcallingscript()) == "GunController" then
			return {NextNumber = function() return 0 end}
		end
		return RandomNewHook(seed)
	end)

	local mt = getrawmetatable(game)
	local backupindex = mt.__index
	setreadonly(mt, false)
	local sacam = workspace["game_assets"].Camera
	local camscript = local_player.PlayerScripts.CustomCamera
	local bob_offset = Vector3.new(0,0,0)
	mt.__index =
	    newcclosure(
	    function(t, k)
			if tostring(t) == "BobOffset" and tostring(k) == "Value" then
				if _G.settings.NO_CAMERA_BOB then
					return bob_offset
				end
			elseif tostring(t) == "AllowAutoJump" and tostring(k) == "Value" then
				if _G.settings.NO_JUMP_COOLDOWN then
					return true
				else
					return false
				end
			end
	        return backupindex(t, k)
	    end
	) -- gun mods
end
do -- big heads
	_G.HeadSize = Vector3.new(6.15,6.15,6.15)
    local function doheads()
        if _G.settings.THICK_BULLET then
            for _,v in pairs(players:GetChildren()) do
				local pobj = GetPlayerFromStructure(v)
				if pobj ~= nil and IsAlive(v) then
					if pobj:FindFirstChild("Head") then
						if not pobj:FindFirstChild("fakehead") then
							local head = pobj.Head
							local newhead = head:Clone()
							newhead.Parent = v
							newhead.Name = "fakehead"
							newhead.Transparency = 0
							newhead.Size = Vector3.new(2, 1, 1)
							head.CanCollide = false
							head.Transparency = 0.99
							head.Size = _G.HeadSize
							for _,v in pairs(head:GetChildren()) do
								if v:IsA("Decal") then
									v:Destroy()
								end
							end
							--UpdateChamsColorPlayer(v)
						else
							local head = pobj.Head
							if head.Size == Vector3.new(1, 1, 1) then
								head.CanCollide = false
								head.Transparency = 0.99
								head.Size = _G.HeadSize
							end
							--UpdateChamsColorPlayer(v)
						end
					end
				end
            end
        else
            for _,v in pairs(players:GetChildren()) do
				local pobj = GetPlayerFromStructure(v)
                if v.Name ~= local_player.Name and pobj ~= nil and pobj:FindFirstChild("Head") then
                    local head = pobj.Head
                    head.CanCollide = false
                    head.Transparency = 0
                    head.Size = Vector3.new(2,1,1)
                end
            end
        end
    end
    WrapFunction(750, doheads)
end
do -- custom sounds
    function ChangeSounds()
        if _G.settings.CUSTOM_HEADSHOT_NOISE then
            local_player.PlayerScripts.GunController.Data.Headshot.Volume = 10
            local_player.PlayerScripts.GunController.Data.Headshot2.Volume = 10

            local_player.PlayerScripts.GunController.Data.Headshot.SoundId = _G["sexscript"]["headshot_1"]
            local_player.PlayerScripts.GunController.Data.Headshot2.SoundId = _G["sexscript"]["headshot_1"]
        else
            local_player.PlayerScripts.GunController.Data.Headshot.Volume = 3
            local_player.PlayerScripts.GunController.Data.Headshot2.Volume = 3
            local_player.PlayerScripts.GunController.Data.Headshot.SoundId = core_gui["sexstorage"].Headshot.SoundId
            local_player.PlayerScripts.GunController.Data.Headshot2.SoundId = core_gui["sexstorage"].Headshot2.SoundId
        end
        if _G.settings.CUSTOM_HITMARKER_NOISE then
            local_player.PlayerScripts.GunController.Data.Hitmarker.Volume = 10
            local_player.PlayerScripts.GunController.Data.Hitmarker.SoundId = _G["sexscript"]["headshot_2"]
        else
            local_player.PlayerScripts.GunController.Data.Hitmarker.Volume = 3
            local_player.PlayerScripts.GunController.Data.Hitmarker.SoundId = core_gui["sexstorage"].Hitmarker.SoundId
        end
    end
    WrapFunction(500, ChangeSounds)
end
do -- remove fucking beam lights
	local lightfolder = workspace.IgnoreList
	for _,v in pairs(lightfolder:GetChildren()) do
		if tostring(v) == "BeamLight" then
			v:Destroy()
		end
	end
	lightfolder.ChildAdded:connect(function(c)
		wait()
		if tostring(c) == "BeamLight" then
			c:Destroy()
		end
	end)
end
do -- custom gun/skin color
    function ChangeCustomColors()
        local cam = workspace.CurrentCamera
        if cam:FindFirstChild("CurrentWeapon") then
            local cweapon = cam:FindFirstChild("CurrentWeapon")
            local larm = cweapon:FindFirstChild("Left Arm").ViewModel.Skin
            local rarm = cweapon:FindFirstChild("Right Arm").ViewModel.Skin
            local gun = cweapon:FindFirstChild("Weapon")
            local selected = local_player.CurrentSelected.Value
            local slot = local_player.GunInventory["Slot" .. tostring(selected)]
            local function GetReticle()
                local a = slot.AttachmentReticle.Value
                if a ~= nil then
                    return true
                end
                return false
            end
            local has_reticle = GetReticle()
			if _G.settings.CUSTOM_GUN_COLOR then
                for k,v in pairs(gun:GetDescendants()) do
                    if v.ClassName == "MeshPart" then
                        if v.Name == "AttachmentReticleNil" then
                            if has_reticle then
                                v.Transparency = 1
                            else
                                v.Transparency = 0
                            end
                        else
                            v.Material = _G.settings.CUSTOM_GUN_MATERIAL
                            v.Color = table_to_hsv(_G.settings.CUSTOM_GUN_COLOR)
                            v.Transparency = _G.settings.CUSTOM_GUN_TRANSPARENCY
                        end
                    end
                end
            end
            if _G.settings.CUSTOM_CHARACTER_COLOR_ENABLED then
                for v,k in pairs(workspace[local_player.Name]:GetDescendants()) do
                    if k.ClassName == "MeshPart" or k.ClassName == "Part" or k.ClassName == "Mesh" or k.ClassName == "UnionOperation" then
                        pcall(function()
                            if k.Name == "HumanoidRootPart" then
                                k.Transparency = 1
                            else
                                k.Transparency = _G.settings.CUSTOM_CHARACTER_TRANSPARENCY
                            end
                            k.Material = _G.settings.CUSTOM_CHARACTER_MATERIAL
                            k.Color = table_to_hsv(_G.settings.CUSTOM_CHARACTER_COLOR)
                        end)
                    end
                end
            end
            if _G.settings.CUSTOM_SKIN_COLOR then
				pcall(function()

					larm.Material = _G.settings.CUSTOM_SKIN_MATERIAL
					rarm.Material = _G.settings.CUSTOM_SKIN_MATERIAL
					larm.Transparency = _G.settings.CUSTOM_SKIN_TRANSPARENCY
					rarm.Transparency = _G.settings.CUSTOM_SKIN_TRANSPARENCY
					larm.Color = table_to_hsv(_G.settings.CUSTOM_SKIN_COLOR)
					rarm.Color = table_to_hsv(_G.settings.CUSTOM_SKIN_COLOR)

				end)
            end
        end
    end
    workspace.CurrentCamera.ChildAdded:connect(function()
        wait()
        ChangeCustomColors()
    end)
    workspace.CurrentCamera.ChildRemoved:connect(function()
        wait()
        ChangeCustomColors()
    end)
end
do -- custom gun offsets
    local offset_table = {
        ["new_offset"] = Vector3.new(0,0,0),
        ["Vector"] = Vector3.new(0.45, -0.3, -2.2),
        ["UMP45"] = Vector3.new(0.45, -0.3, -2.2),
        ["AMG"] = Vector3.new(0.55, -0.2, -2.5),
        ["AR15"] = Vector3.new(0.5, -0.15, -1.9),
        ["Crossbow"] = Vector3.new(0.45, -0.15, -1.8),
        ["DesertEagle"] = Vector3.new(0.775, -0.213, -2.9),
        ["Fists"] = Vector3.new(-0.1, 0.75, 0.5),
        ["Glock"] = Vector3.new(0.55, -0.25, -2.2),
        ["GrenadeFlash"] = Vector3.new(0, 0.5, -0.6),
        ["GrenadeSmoke"] = Vector3.new(0, 0.5, -0.6),
        ["GrenadeFrag"] = Vector3.new(0, 0.5, -0.6),
        ["HuntingRifle"] = Vector3.new(0.45, -0.15, -1.8),
        ["Kar98k"] = Vector3.new(0.45, -0.25, -1.8),
        ["M1911"] = Vector3.new(0.55, -0.25, -1.8),
        ["M40A5"] = Vector3.new(0.45, -0.15, -2.2),
        ["M4A1"] = Vector3.new(0.6, -0.135, -2),
        ["MRAD"] = Vector3.new(0.45, -0.25, -1.8),
        ["MVP"] = Vector3.new(0.6, -0.15, -1.8),
        ["Mossberg"] = Vector3.new(0.45, -0.25, -1.8),
        ["Revolver"] = Vector3.new(0.6, -0.2, -2),
        ["SCAR"] = Vector3.new(0.6, -0.15, -1.9),
        ["Shotgun"] = Vector3.new(0.45, -0.25, -1.8),
        ["Skorpion"] = Vector3.new(0.5, -0.25, -2.1)
    }
    local gun_folder = game.ReplicatedStorage.GunData
    function ChangeOffsets()
        offset_table["new_offset"] = Vector3.new(_G.settings.CUSTOM_GUN_OFFSET_VECTOR_X,_G.settings.CUSTOM_GUN_OFFSET_VECTOR_Y,_G.settings.CUSTOM_GUN_OFFSET_VECTOR_Z)
        if _G.settings.CUSTOM_GUN_OFFSET then
            for k,v in pairs(gun_folder:GetDescendants()) do
                if v:FindFirstChild("Offset") and offset_table[tostring(v.Parent)] ~= nil then
                    --print("Set offset of " .. tostring(v.Parent) .. " to new offset.")
                    pcall(function() v.Offset.Value = offset_table["new_offset"] end)
                end
            end
        else
            for k,v in pairs(gun_folder:GetDescendants()) do
                if v:FindFirstChild("Offset") and offset_table[tostring(v.Parent)] ~= nil then
                    --print("Set offset of " .. tostring(v.Parent) .. " to old offset.")
                    pcall(function() v.Offset.Value = offset_table[tostring(v.Parent)] end)
                end
            end
        end
    end
end
do -- player info panel // health bar // crosshair
	local playerinfoboard = Instance.new("ScreenGui")
	local backdrop = Instance.new("Frame")
	local insideframe = Instance.new("Frame")
	local player_name = Instance.new("TextLabel")
	local info = Instance.new("Frame")
	local geartext = Instance.new("TextLabel")
	local gear = Instance.new("Frame")
	local function CreateInfoPanel()
		playerinfoboard.Name = "playerinfoboard"
		playerinfoboard.Parent = game.CoreGui
		playerinfoboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		playerinfoboard.DisplayOrder = 1
		playerinfoboard.Enabled = false

		backdrop.Name = "backdrop"
		backdrop.Parent = playerinfoboard
		backdrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		backdrop.BorderColor3 = Color3.fromRGB(255, 255, 255)
		backdrop.Size = UDim2.new(0, 400, 0, 250)
		backdrop.Position = UDim2.new(0, viewport_size.X - 425, 0, 15)
		backdrop.Style = Enum.FrameStyle.RobloxRound

		insideframe.Name = "insideframe"
		insideframe.Parent = backdrop
		insideframe.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		insideframe.BackgroundTransparency = 0.600
		insideframe.BorderSizePixel = 0
		insideframe.Position = UDim2.new(-0.00989432167, 0, -0.00881750695, 0)
		insideframe.Size = UDim2.new(0, 390, 0, 238)

		player_name.Name = "player_name"
		player_name.Parent = insideframe
		player_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		player_name.BackgroundTransparency = 1.000
		player_name.Position = UDim2.new(0.0294117648, 0, 0, 0)
		player_name.Size = UDim2.new(0, 330, 0, 30)
		player_name.Font = Enum.Font.GothamBold
		player_name.Text = ""
		player_name.TextColor3 = Color3.fromRGB(255, 255, 255)
		player_name.TextSize = 20.000
		player_name.TextWrapped = true
		player_name.TextXAlignment = Enum.TextXAlignment.Left

		info.Name = "info"
		info.Parent = insideframe
		info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		info.BackgroundTransparency = 1.000
		info.BorderSizePixel = 0
		info.Position = UDim2.new(0.0497737005, 0, 0.126050428, 0)
		info.Size = UDim2.new(0, 370, 0, 210)
	end
	local function CreateNewElementFrame(info_table)
		local sample_element = Instance.new("Frame")
		local index = Instance.new("TextLabel")
		local ammo = Instance.new("TextLabel")
		local weapon = Instance.new("TextLabel")
		local attachment = Instance.new("TextLabel")

		local idx = info_table["Index"]
		local wepname = info_table["Weapon"]
		local ammomag = info_table["AmmoMag"]
		local ammores = info_table["AmmoReserve"]
		local scope = info_table["Scope"]
		local muzzle = info_table["Muzzle"]
		sample_element.Name = "element" .. tostring(idx)
		sample_element.Parent = info
		sample_element.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sample_element.BackgroundTransparency = 1.000
		sample_element.BorderSizePixel = 0
		sample_element.Size = UDim2.new(0, 355, 0, 30)
		sample_element.Position = UDim2.new(0, 0, 0, 30 * (tonumber(idx) - 1))
		index.Name = "index"
		index.Parent = sample_element
		index.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		index.BackgroundTransparency = 1.000
		index.Size = UDim2.new(0, 20, 0, 30)
		index.Font = Enum.Font.GothamSemibold
		index.Text = "[" .. tostring(idx) .. "]"
		index.TextColor3 = Color3.fromRGB(255, 255, 255)
		index.TextSize = 14.000
		index.TextXAlignment = Enum.TextXAlignment.Left
		ammo.Name = "ammo"
		ammo.Parent = sample_element
		ammo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ammo.BackgroundTransparency = 1.000
		ammo.Position = UDim2.new(0, 120, 0, 0)
		ammo.Size = UDim2.new(0, 70, 0, 30)
		ammo.Font = Enum.Font.GothamSemibold
		ammo.TextColor3 = Color3.fromRGB(255, 255, 255)
		ammo.TextSize = 14.000
		ammo.TextXAlignment = Enum.TextXAlignment.Left
		ammo.RichText = true
		ammo.Text = ""
		if wepname ~= "Fists" then
			local rt_str = "<b><font color=\"#DDDDDD\">[</font></b> "
			rt_str = rt_str .. "<font color=\"#0076FF\">" .. tostring(ammomag) .. "</font>"
			rt_str = rt_str .. "<b><font color=\"#DDDDDD\"> / </font></b> "
			rt_str = rt_str .. "<font color=\"#0076FF\">" .. tostring(ammores) .. "</font>"
			rt_str = rt_str .. "<b><font color=\"#DDDDDD\"> ]</font></b> "
			ammo.Text = rt_str
		end
		weapon.Name = "weapon"
		weapon.Parent = sample_element
		weapon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		weapon.BackgroundTransparency = 1.000
		weapon.Position = UDim2.new(0, 25, 0, 0)
		weapon.Size = UDim2.new(0, 90, 0, 30)
		weapon.Font = Enum.Font.GothamSemibold
		weapon.Text = wepname
		weapon.TextColor3 = Color3.fromRGB(255, 0, 100)
		weapon.TextSize = 14.000
		weapon.TextXAlignment = Enum.TextXAlignment.Left
		if wepname == "Fists" then
			weapon.Text = "None"
			weapon.TextColor3 = Color3.fromRGB(200, 200, 200)
		end

		attachment.Name = "attachment"
		attachment.Parent = sample_element
		attachment.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		attachment.BackgroundTransparency = 1.000
		attachment.Position = UDim2.new(0, 210, 0, 0)
		attachment.Size = UDim2.new(0, 165, 0, 30)
		attachment.Font = Enum.Font.GothamSemibold
		attachment.TextColor3 = Color3.fromRGB(255, 255, 255)
		attachment.TextSize = 14.000
		attachment.TextXAlignment = Enum.TextXAlignment.Left
		attachment.RichText = true
		attachment.Text = ""
		if wepname ~= "Fists" then
			local rt_str = "<b><font color=\"#DDDDDD\">[</font></b> "
			rt_str = rt_str .. "<font color=\"#0076FF\">" .. scope .. "</font>"
			rt_str = rt_str .. "<b><font color=\"#DDDDDD\"> / </font></b> "
			rt_str = rt_str .. "<font color=\"#0076FF\">" .. muzzle .. "</font>"
			rt_str = rt_str .. "<b><font color=\"#DDDDDD\"> ]</font></b> "
			attachment.Text = rt_str
		end
	end
	local function GetPlayerGear(player)
		if IsAlive(player) then
			local pname = tostring(player)
			local gear_t = {}
			local pobj = GetPlayerFromStructure(player)
			for _,v in pairs(pobj:GetChildren()) do
				local n = tostring(v)
				if IsGear(n) then
					table.insert(gear_t, n)
				end
			end
			if #gear_t > 0 then
				local n = 0
				local max = 0
				local rt_str = "<b><font color=\"#DDDDDD\">[</font></b> "
				for i,gear in pairs(gear_t) do
					max = max + 1
				end
				for i,gear in pairs(gear_t) do
					n = n + 1
					rt_str = rt_str .. "<font color=\"#D8AEFF\">" .. ParseNames(gear) .. "</font>"
					if not (n == max) then
						rt_str = rt_str .. "<b><font color=\"#DDDDDD\">/</font></b> "
					end
				end
				rt_str = rt_str .. "<b><font color=\"#DDDDDD\"> ]</font></b>"
				return rt_str
			end
		end
		return ""
	end
	CreateInfoPanel()
	local function RedrawInfoBoard()
		local player = _G.closestplayer
		local pname = tostring(_G.closestplayer)
		if _G.settings.INFO_BOARD_ENABLED and player ~= nil and IsAlive(player) then
			playerinfoboard.Enabled = true
			player_name.Text = pname
			for _,item in pairs(info:GetChildren()) do
				if item:IsA("Frame") then
					item:Destroy()
				end
			end
			local function GetAttach(slotvar)
				if slotvar:FindFirstChild("AttachmentMuzzle") then
					if slotvar.AttachmentMuzzle.Value ~= nil then
						return slotvar.AttachmentMuzzle.Value
					else
						return "~"
					end
				end
				return "~"
			end
			local function GetReticle(slotvar)
				if slotvar:FindFirstChild("AttachmentReticle") then
					if slotvar.AttachmentReticle.Value ~= nil then
						return slotvar.AttachmentReticle.Value
					else
						return "~"
					end
				end
				return "~"
			end
			local p = game.Players[pname]
			for i = 1,6 do
				local slot = p.GunInventory["Slot" .. tostring(i)]
				local sval = tostring(slot.Value)
				local row_data = {
					["Index"] = i,
                    ["Weapon"] = ParseNames(sval),
                    ["AmmoMag"] = slot.BulletsInMagazine.Value,
                    ["AmmoReserve"] = slot.BulletsInReserve.Value,
                    ["Scope"] = ParseNames(GetReticle(slot)),
                    ["Muzzle"] = ParseNames(GetAttach(slot))
                }
				CreateNewElementFrame(row_data)
				local gear = Instance.new("Frame")
				gear.Name = "gear"
				gear.Parent = info
				gear.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				gear.BackgroundTransparency = 1.000
				gear.BorderSizePixel = 0
				gear.Position = UDim2.new(0, 0, 0, 180)
				gear.Size = UDim2.new(0, 355, 0, 30)
				local geartext = Instance.new("TextLabel")
				geartext.Name = "geartext"
				geartext.Parent = gear
				geartext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				geartext.BackgroundTransparency = 1.000
				geartext.Position = UDim2.new(0, 0, 0, -2)
				geartext.Size = UDim2.new(0, 370, 0, 30)
				geartext.Font = Enum.Font.Gotham
				geartext.TextColor3 = Color3.fromRGB(255, 255, 255)
				geartext.TextSize = 12.000
				geartext.TextXAlignment = Enum.TextXAlignment.Left
				geartext.RichText = true
				geartext.Text = GetPlayerGear(pname)
			end
		else
			playerinfoboard.Enabled = false
		end
	end
	WrapFunction(160, RedrawInfoBoard)
	local healthbargui = Instance.new("ScreenGui")
	local background = Instance.new("Frame")
	local healthbarframe = Instance.new("Frame")
	local health = Instance.new("Frame")
	local function CreateHealthBar()
		healthbargui.Name = "healthbargui"
		healthbargui.Parent = game.CoreGui
		healthbargui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		healthbargui.Enabled = false
		background.Name = "background"
		background.Parent = healthbargui
		background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		background.Size = UDim2.new(0, 410, 0, 12)
		background.Position = UDim2.new(0.5, (-400 / 2), 0.5, (-12 / 2))
		background.Style = Enum.FrameStyle.RobloxRound

		healthbarframe.Name = "healthbarframe"
		healthbarframe.Parent = background
		healthbarframe.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		healthbarframe.BorderSizePixel = 0
		healthbarframe.Position = UDim2.new(0, 0, -0.711000025, 0)
		healthbarframe.Size = UDim2.new(0, 400, 0, 7)

		health.Name = "health"
		health.Parent = background
		health.BackgroundColor3 = Color3.fromRGB(39, 255, 1)
		health.BorderSizePixel = 0
		health.Position = UDim2.new(0, 0, -0.711000025, 0)
		health.Size = UDim2.new(0, 400, 0, 7)
	end
	CreateHealthBar()
	local u = 0
	function UpdateHealthBar()
		if _G.settings.PLAYER_HEALTH_BAR then
			if k == 1 then
				k = 0
				healthbargui.Enabled = true
			end
			if _G.closestplayer ~= nil then

				local hp = GetHealth(_G.closestplayer)
				local perc = hp*4
				background.Position = UDim2.new(0.5, (-400 / 2), 0.5, ((-_G.settings.AIMBOT_FOV) - 60))
				health.Size = UDim2.new(0, perc, 0, 7)
			else
				k = 1
				healthbargui.Enabled = false
			end
		else
			if k == 0 then
				k = 1
				healthbargui.Enabled = false
			end
		end
	end
	WrapFunction(60, UpdateHealthBar)
end
do -- server name hiding
	function ToggleServerNames()
		if _G.settings.HIDE_SERVER_NAME_ON_INJECT then
			server_text.Text = "Server Name: <b><font color=\"#F0AAFF\">sexserver</font></b>"
		else
			server_text.Text = old_server_name
		end
	end
end
do -- show custom hitbox
	local custom_hitbox_part = Instance.new("Part", workspace)
	custom_hitbox_part.Name = "hbox"
	custom_hitbox_part.Shape = "Ball"
	custom_hitbox_part.CanCollide = false
	custom_hitbox_part.Material = "Neon"
	custom_hitbox_part.Transparency = 1
	custom_hitbox_part.Color = Color3.fromRGB(255,13,112)
	custom_hitbox_part.Size = _G.HeadSize
	local k = 1
    game:GetService("RunService").RenderStepped:Connect(
    function()
        if _G.settings.SHOW_EXPANDED_HITBOX then
            if k == 1 then
				custom_hitbox_part.Transparency = 0.98
				k = 0
			end
			if local_player.Character then
				local v3 = local_player.Character.Head.Position
				custom_hitbox_part.Position = v3
			end
        else
			if k == 0 then
				k = 1
				custom_hitbox_part.Transparency = 1
			end
		end
    end)
end
local UI_TABLE_DATA = {}
do -- gui
	local section_color = Color3.fromRGB(255,255,255)
	library:Setup()
	library:SetVisibility(false)
	do -- Config stuffs
	    if not readfile then
	        game.Players.LocalPlayer:kick("Your exploit does not have readfile")
	    end
	    local config = "sexscript/quarantinez.json"
	    local config_exists =
	        pcall(
	        function()
	            readfile(config)
	        end
	    )
	    function save_config()
	        _G.settings.gui_toggle_key = _G.toggle_gui_bind["key"]
	        writefile(config, game:service("HttpService"):JSONEncode(_G.settings))
	    end
	    if not config_exists then
	        writefile(config, game:service("HttpService"):JSONEncode(_G.settings))
	    else
	        local newsettings = game:service("HttpService"):JSONDecode(readfile(config))
	        for _, v in pairs(newsettings) do
	            if _G.settings[tostring(_)] ~= nil then
	                _G.settings[tostring(_)] = v
	            end
	        end
	    end
	end
	do -- settings tab
		local settings_tab = tab:Create("Settings", _G["assets"]["settings"])
		settings_tab:Section("GUI Settings")
		settings_tab:Button(
		    "Save Config",
		    "SAVE_CONFIG",
		    _G,
		    function()
		        save_config()
		    end
		)
		settings_tab:KeybindButton(
			"Menu Toggle",
			"toggle_gui_bind",
			_G.settings.gui_toggle_key,
			_G,
			function()
				_G.settings.gui_toggle_key = _G.toggle_gui_bind["key"]
				library:Toggle()
			end
		)
		settings_tab:ItemList(
			"UI Theme", "UI_THEME", _G,
			theme_list_table,
			_G.settings.ui_theme,
			function() library:SetTheme(_G["UI_THEME"]["selected_value"]);_G.settings.ui_theme = _G["UI_THEME"]["selected_value"]; end
		)
		settings_tab:Checkbox(
			"Hide Server Name",
			"HIDE_SERVER_NAME_ON_INJECT",
			_G.settings.HIDE_SERVER_NAME_ON_INJECT,
			_G,
			function()
				_G.settings.HIDE_SERVER_NAME_ON_INJECT = _G["HIDE_SERVER_NAME_ON_INJECT"]
				ToggleServerNames()
			end
		)
		settings_tab:Section("FPS")
		settings_tab:Checkbox(
			"Remove Trees on Inject",
			"REMOVE_FOLIAGE_ON_INJECT",
			_G.settings.REMOVE_FOLIAGE_ON_INJECT,
			_G,
			function()
				_G.settings.REMOVE_FOLIAGE_ON_INJECT = _G["REMOVE_FOLIAGE_ON_INJECT"]
			end
		)
		settings_tab:Button(
			"Remove Trees",
			"REMOVE_FOLIAGE",
			_G,
			function()
				for _,v in pairs(workspace.world_assets.StaticObjects.Foliage:GetChildren()) do
					v:Destroy()
				end
			end
		)
		settings_tab:Checkbox(
			"Transparent Bushes",
			"TRANSPARENT_BUSHES",
			_G.settings.TRANSPARENT_BUSHES,
			_G,
			function()
				_G.settings.TRANSPARENT_BUSHES = _G["TRANSPARENT_BUSHES"]
				if _G.settings.TRANSPARENT_BUSHES then
					for _,bush in pairs(bush_folder:GetChildren()) do
						bush.Transparency = 0.7
					end
				else
					for _,bush in pairs(bush_folder:GetChildren()) do
						bush.Transparency = 0
					end
				end
			end
		)
		settings_tab:Checkbox(
			"Grass Disabled",
			"GRASS_ENABLED",
			_G.settings.GRASS_ENABLED,
			_G,
			function()
				_G.settings.GRASS_ENABLED = _G["GRASS_ENABLED"]
				sethiddenproperty(workspace.Terrain, "Decoration", not _G.settings.GRASS_ENABLED)
			end
		)
	end
	do -- aimbot
		RedrawFOVCircle(_G.settings.FOV_CIRCLE_ENABLED)
		local aimbot_tab = tab:Create("Aimbot", _G["assets"]["crosshair"])
		aimbot_tab:Section("Aim")
		aimbot_tab:Checkbox(
			"Aimbot Enabled",
			"AIMBOT_ENABLED",
			_G.settings.AIMBOT_ENABLED,
			_G,
			function()
				_G.settings.AIMBOT_ENABLED = _G["AIMBOT_ENABLED"]
			end
		)
		aimbot_tab:Checkbox(
			"Drop Predicition",
			"AIMBOT_PREDICITION",
			_G.settings.AIMBOT_PREDICITION,
			_G,
			function()
				_G.settings.AIMBOT_PREDICITION = _G["AIMBOT_PREDICITION"]
			end
		)
		aimbot_tab:ItemList(
			"Aim Bone",
			"AIMBOT_PART",
			_G,
			{
				{
					["Name"] = "Head",
					["NameColor"] = Color3.fromRGB(60, 183, 250),
					["Callback"] = function()end
				},
				{
					["Name"] = "Torso",
					["NameColor"] = Color3.fromRGB(60, 183, 250),
					["Callback"] = function()end
				}
			},
			_G.settings.AIMBOT_PART,
			function()
				_G.settings.AIMBOT_PART = _G["AIMBOT_PART"]["selected_value"]
			end
		)
		aimbot_tab:ValueSlider(
			"Aimbot FOV",
			"AIMBOT_FOV",
			_G,
			aimbot_fov["Min"],
			aimbot_fov["Max"],
			_G.settings.AIMBOT_FOV,
			function()
				_G.settings.AIMBOT_FOV = _G["AIMBOT_FOV"]
				RedrawFOVCircle(_G.settings.FOV_CIRCLE_ENABLED)
				UpdateHealthBar()
			end
		)
		aimbot_tab:Section("FOV Circle")
		aimbot_tab:Checkbox(
			"FOV Circle Enabled",
			"FOV_CIRCLE_ENABLED",
			_G.settings.FOV_CIRCLE_ENABLED,
			_G,
			function()
				_G.settings.FOV_CIRCLE_ENABLED = _G["FOV_CIRCLE_ENABLED"]
				RedrawFOVCircle(_G.settings.FOV_CIRCLE_ENABLED)
			end
		)
		aimbot_tab:ItemList(
			"Shape",
			"FOV_CIRCLE_SHAPE",
			_G,
			{
				{
					["Name"] = "Circle",
					["NameColor"] = Color3.fromRGB(60, 183, 250),
					["Callback"] = function()
					end
				},
				{
					["Name"] = "Square",
					["NameColor"] = Color3.fromRGB(60, 183, 250),
					["Callback"] = function()
					end
				}
			},
			_G.settings.FOV_CIRCLE_SHAPE,
			function()
				_G.settings.FOV_CIRCLE_SHAPE = _G["FOV_CIRCLE_SHAPE"]["selected_value"]
				RedrawFOVCircle(_G.settings.FOV_CIRCLE_ENABLED)
			end
		)
		aimbot_tab:Checkbox(
			"FOV Circle Rainbow",
			"FOV_CIRCLE_RAINBOW",
			_G.settings.FOV_CIRCLE_RAINBOW,
			_G,
			function()
				_G.settings.FOV_CIRCLE_RAINBOW = _G["FOV_CIRCLE_RAINBOW"]
				RedrawFOVCircle(_G.settings.FOV_CIRCLE_ENABLED)
			end
		)
		aimbot_tab:ColorPicker(
			"Circle Color",
			"FOV_CIRCLE_COLOR",
			_G,
			table_to_hsv(_G.settings.FOV_CIRCLE_COLOR),
			function()
				_G.settings.FOV_CIRCLE_COLOR = _G["FOV_CIRCLE_COLOR"]["selected_value"]
				RedrawFOVCircle(_G.settings.FOV_CIRCLE_ENABLED)
			end
		)
	end
	do -- gun mods
            local gunmods = tab:Create("Gun Mods", _G["assets"]["gun"])
            gunmods:Section("Gun Mods")
            gunmods:Checkbox(
                "Remove Aimcone",
                "NO_AIMCONE",
                _G.settings.NO_AIMCONE,
                _G,
                function()
                    _G.settings.NO_AIMCONE = _G["NO_AIMCONE"]
                end
            )
			gunmods:Checkbox(
                "Thick Bullet",
                "THICK_BULLET",
                _G.settings.THICK_BULLET,
                _G,
                function()
                    _G.settings.THICK_BULLET = _G["THICK_BULLET"]
                end
            )
			gunmods:Checkbox(
                "Remove Camera Bob",
                "NO_CAMERA_BOB",
                _G.settings.NO_CAMERA_BOB,
                _G,
                function()
                    _G.settings.NO_CAMERA_BOB = _G["NO_CAMERA_BOB"]
                end
            )
			gunmods:Section("Custom Gun Offsets")
			gunmods:Checkbox(
                "Custom Gun Offset",
                "CUSTOM_GUN_OFFSET",
                _G.settings.CUSTOM_GUN_OFFSET,
                _G,
                function()
                    _G.settings.CUSTOM_GUN_OFFSET = _G["CUSTOM_GUN_OFFSET"]
                end
            )
            gunmods:ValueSlider(
                "Offset X",
                "CUSTOM_GUN_OFFSET_VECTOR_X",
                _G,
                v3mins["Min"],
                v3mins["Max"],
                _G.settings.CUSTOM_GUN_OFFSET_VECTOR_X,
                function()
                    _G.settings.CUSTOM_GUN_OFFSET_VECTOR_X = _G["CUSTOM_GUN_OFFSET_VECTOR_X"]
                    local x = math.random(1,6)
                    if x == 1 then
                        ChangeOffsets()
                    end
                end
            )
            gunmods:ValueSlider(
                "Offset Y",
                "CUSTOM_GUN_OFFSET_VECTOR_Y",
                _G,
                v3mins["Min"],
                v3mins["Max"],
                _G.settings.CUSTOM_GUN_OFFSET_VECTOR_Y,
                function()
                    _G.settings.CUSTOM_GUN_OFFSET_VECTOR_Y = _G["CUSTOM_GUN_OFFSET_VECTOR_Y"]
                    local x = math.random(1,6)
                    if x == 1 then
                        ChangeOffsets()
                    end
                end
            )
            gunmods:ValueSlider(
                "Offset Z",
                "CUSTOM_GUN_OFFSET_VECTOR_Z",
                _G,
                v3mins["Min"],
                v3mins["Max"],
                _G.settings.CUSTOM_GUN_OFFSET_VECTOR_Z,
                function()
                    _G.settings.CUSTOM_GUN_OFFSET_VECTOR_Z = _G["CUSTOM_GUN_OFFSET_VECTOR_Z"]
                    local x = math.random(1,6)
                    if x == 1 then
                        ChangeOffsets()
                    end
                end
            )
            gunmods:Section("Custom Sounds")
            gunmods:Checkbox(
                "Custom Headshot Noise",
                "CUSTOM_HEADSHOT_NOISE",
                _G.settings.CUSTOM_HEADSHOT_NOISE,
                _G,
                function()
                    _G.settings.CUSTOM_HEADSHOT_NOISE = _G["CUSTOM_HEADSHOT_NOISE"]
                    ChangeSounds()
                end
            )
            gunmods:Checkbox(
                "Custom Hitmarker Noise",
                "CUSTOM_HITMARKER_NOISE",
                _G.settings.CUSTOM_HITMARKER_NOISE,
                _G,
                function()
                    _G.settings.CUSTOM_HITMARKER_NOISE = _G["CUSTOM_HITMARKER_NOISE"]
                    ChangeSounds()
                end
            )
    end
	do -- esp tags
		-- _G["sexscript"]["FontList"]
		local esptags = tab:Create("ESP", _G["assets"]["eye"])
		esptags:Section("Nametags")
		esptags:Checkbox(
            "ESP Enabled",
            "ESP_ENABLED",
            _G.settings.ESP_ENABLED,
            _G,
            function()
                _G.settings.ESP_ENABLED = _G["ESP_ENABLED"]
                DrawTagsAll()
            end
        )
		esptags:ItemList(
            "ESP Font",
            "ESP_FONT",
            _G,
            _G["sexscript"]["FontList"],
            _G.settings.ESP_FONT,
            function()
                _G.settings.ESP_FONT = _G["ESP_FONT"]["selected_value"]
                UpdateTagsAllPlayers()
            end
        )
		esptags:Checkbox(
            "ESP Teamcolor",
            "ESP_NAMETAGS_TEAMCOLOR",
            _G.settings.ESP_NAMETAGS_TEAMCOLOR,
            _G,
            function()
                _G.settings.ESP_NAMETAGS_TEAMCOLOR = _G["ESP_NAMETAGS_TEAMCOLOR"]
                UpdateTagsAllPlayers()
            end
        )
        esptags:Checkbox(
            "ESP Font Outlined",
            "ESP_FONT_OUTLINED",
            _G.settings.ESP_FONT_OUTLINED,
            _G,
            function()
                _G.settings.ESP_FONT_OUTLINED = _G["ESP_FONT_OUTLINED"]
                UpdateTagsAllPlayers()
            end
        )
        esptags:ValueSlider(
            "ESP Font Size",
            "ESP_FONT_SIZE",
            _G,
            esp_font_size["Min"],
            esp_font_size["Max"],
            _G.settings.ESP_FONT_SIZE,
            function()
                _G.settings.ESP_FONT_SIZE = _G["ESP_FONT_SIZE"]
                UpdateTagsAllPlayers()
            end
        )
        esptags:ValueSlider(
            "ESP Range",
            "ESP_RANGE",
            _G,
            esp_range["Min"],
            esp_range["Max"],
            _G.settings.ESP_RANGE,
            function()
                _G.settings.ESP_RANGE = _G["ESP_RANGE"]
                UpdateTagsAllPlayers()
            end
        )
        esptags:ColorPicker(
            "Name Color",
            "ESP_NAME_FRIENDLY_COLOR",
            _G,
            table_to_hsv(_G.settings.ESP_NAME_FRIENDLY_COLOR),
            function()
                _G.settings.ESP_NAME_FRIENDLY_COLOR = _G["ESP_NAME_FRIENDLY_COLOR"]["selected_value"]
                UpdateTagsAllPlayers()
            end
        )
        esptags:ColorPicker(
            "Distance Color",
            "ESP_DISTANCE_COLOR",
            _G,
            table_to_hsv(_G.settings.ESP_DISTANCE_COLOR),
            function()
                _G.settings.ESP_DISTANCE_COLOR = _G["ESP_DISTANCE_COLOR"]["selected_value"]
                UpdateTagsAllPlayers()
            end
        )
		esptags:ColorPicker(
            "Weapon Color",
            "ESP_WEAPON_COLOR",
            _G,
            table_to_hsv(_G.settings.ESP_WEAPON_COLOR),
            function()
                _G.settings.ESP_WEAPON_COLOR = _G["ESP_WEAPON_COLOR"]["selected_value"]
                UpdateTagsAllPlayers()
            end
        )
	end
	do -- healthbars / box esp
		local visuals = tab:Create("Player Visuals", _G["assets"]["eye"])
        visuals:Section("Health Bars")
        visuals:Checkbox(
            "Health Bars Enabled",
            "HEALTH_BARS_ENABLED",
            _G.settings.HEALTH_BARS_ENABLED,
            _G,
            function()
                _G.settings.HEALTH_BARS_ENABLED = _G["HEALTH_BARS_ENABLED"]
                DrawBarAll()
            end
        )
        visuals:ValueSlider(
            "Health Bar Width",
            "HEALTH_BARS_WIDTH",
            _G,
            health_bars_width["Min"],
            health_bars_width["Max"],
            _G.settings.HEALTH_BARS_WIDTH,
            function()
                _G.settings.HEALTH_BARS_WIDTH = _G["HEALTH_BARS_WIDTH"]
                DrawBarAll()
            end
        )
        visuals:ItemList(
            "Bar Style",
            "HEALTH_BARS_STYLE",
            _G,
            {
                {
                    ["Name"] = "Left Side",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Right Side",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Top",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Bottom",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                }
            },
            _G.settings.HEALTH_BARS_STYLE,
            function()
                _G.settings.HEALTH_BARS_STYLE = _G["HEALTH_BARS_STYLE"]["selected_value"]
                DrawBarAll()
            end
        )
        visuals:ColorPicker(
            "Health Color",
            "HEALTH_BARS_HEALTH_BAR_COLOR",
            _G,
            table_to_hsv(_G.settings.HEALTH_BARS_HEALTH_BAR_COLOR),
            function()
                _G.settings.HEALTH_BARS_HEALTH_BAR_COLOR = _G["HEALTH_BARS_HEALTH_BAR_COLOR"]["selected_value"]
                DrawBarAll()
            end
        )
        visuals:ColorPicker(
            "Damaged Color",
            "HEALTH_BARS_DAMAGED_BAR_COLOR",
            _G,
            table_to_hsv(_G.settings.HEALTH_BARS_DAMAGED_BAR_COLOR),
            function()
                _G.settings.HEALTH_BARS_DAMAGED_BAR_COLOR = _G["HEALTH_BARS_DAMAGED_BAR_COLOR"]["selected_value"]
                DrawBarAll()
            end
        )
		visuals:Section("Box ESP")
        visuals:Checkbox(
            "Box ESP Enabled",
            "BOX_ESP_ENABLED",
            _G.settings.BOX_ESP_ENABLED,
            _G,
            function()
                _G.settings.BOX_ESP_ENABLED = _G["BOX_ESP_ENABLED"]
                DrawBoxAll()
            end
        )
		visuals:Checkbox(
            "Box Outline",
            "BOX_ESP_OUTLINE",
            _G.settings.BOX_ESP_OUTLINE,
            _G,
            function()
                _G.settings.BOX_ESP_OUTLINE = _G["BOX_ESP_OUTLINE"]
                UpdateBoxESPColor()
            end
        )
		visuals:ColorPicker(
            "Outline Color",
            "BOX_ESP_OUTLINE_COLOR",
            _G,
            table_to_hsv(_G.settings.BOX_ESP_OUTLINE_COLOR),
            function()
                _G.settings.BOX_ESP_OUTLINE_COLOR = _G["BOX_ESP_OUTLINE_COLOR"]["selected_value"]
                UpdateBoxESPColor()
            end
        )
        visuals:ItemList(
            "Box Style",
            "BOX_ESP_STYLE",
            _G,
            {
                {
                    ["Name"] = "Box",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Corners",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Long Corners",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                }
            },
            _G.settings.BOX_ESP_STYLE,
            function()
                _G.settings.BOX_ESP_STYLE = _G["BOX_ESP_STYLE"]["selected_value"]
                DrawBoxAll()
            end
        )
        visuals:ColorPicker(
            "Box Color",
            "BOX_ESP_FRIENDLY_COLOR",
            _G,
            table_to_hsv(_G.settings.BOX_ESP_FRIENDLY_COLOR),
            function()
                _G.settings.BOX_ESP_FRIENDLY_COLOR = _G["BOX_ESP_FRIENDLY_COLOR"]["selected_value"]
                UpdateBoxESPColor()
            end
        )
		visuals:Section("Frame Chams")
        visuals:Checkbox(
            "Frame Chams Enabled",
            "SKELETON_CHAMS_ENABLED",
            _G.settings.SKELETON_CHAMS_ENABLED,
            _G,
            function()
                _G.settings.SKELETON_CHAMS_ENABLED = _G["SKELETON_CHAMS_ENABLED"]
                DrawSkeletonChamsAll()
            end
        )
        visuals:ColorPicker(
            "Frame Color",
            "SKELETON_CHAMS_COLOR",
            _G,
            table_to_hsv(_G.settings.SKELETON_CHAMS_COLOR),
            function()
                _G.settings.SKELETON_CHAMS_COLOR = _G["SKELETON_CHAMS_COLOR"]["selected_value"]
                UpdateSkeletonChamsColor()
            end
        )
		visuals:Section("Chams")
		visuals:Checkbox(
            "Chams Enabled",
            "CHAMS_ENABLED",
            _G.settings.CHAMS_ENABLED,
            _G,
            function()
                _G.settings.CHAMS_ENABLED = _G["CHAMS_ENABLED"]
                DrawChamsAll()
            end
        )
		visuals:ValueSlider(
            "Chams Transparency",
            "CHAMS_TRANSPARENCY",
            _G,
            chams_transparency["Min"],
            chams_transparency["Max"],
            _G.settings.CHAMS_TRANSPARENCY,
            function()
                _G.settings.CHAMS_TRANSPARENCY = _G["CHAMS_TRANSPARENCY"]
                UpdateChamsColor()
            end
        )
		visuals:ItemList(
            "Material",
            "CHAMS_MATERIAL",
            _G,
            _G["sexscript"]["MaterialList"],
            _G.settings.CHAMS_MATERIAL,
            function()
                _G.settings.CHAMS_MATERIAL = _G["CHAMS_MATERIAL"]["selected_value"]
                UpdateChamsColor()
            end
        )
		visuals:ColorPicker(
            "Chams Color",
            "CHAMS_FRIENDLY_COLOR",
            _G,
            table_to_hsv(_G.settings.CHAMS_FRIENDLY_COLOR),
            function()
                _G.settings.CHAMS_FRIENDLY_COLOR = _G["CHAMS_FRIENDLY_COLOR"]["selected_value"]
                UpdateChamsColor()
            end
        )
		visuals:Section("")
		visuals:Section("")
		visuals:Section("")
		visuals:Section("")
        visuals:Section("Snaplines")
        visuals:Checkbox(
            "Snaplines Enabled",
            "SNAPLINES_ENABLED",
            _G.settings.SNAPLINES_ENABLED,
            _G,
            function()
                _G.settings.SNAPLINES_ENABLED = _G["SNAPLINES_ENABLED"]
                show_notification_bool("Snaplines", _G.settings.SNAPLINES_ENABLED)
                DrawAll()
            end
        )
        visuals:ItemList(
            "Snap Mode",
            "SNAPLINES_SNAP_MODE",
            _G,
            {
                {
                    ["Name"] = "Target",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "All",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                }
            },
            _G.settings.SNAPLINES_SNAP_MODE,
            function()
                _G.settings.SNAPLINES_SNAP_MODE = _G["SNAPLINES_SNAP_MODE"]["selected_value"]
                UpdateSnaplineValues()
            end
        )
        visuals:ValueSlider(
            "Snaplines Thickness",
            "SNAPLINES_THICKNESS",
            _G,
            tracer_thickness["Min"],
            tracer_thickness["Max"],
            _G.settings.SNAPLINES_THICKNESS,
            function()
                _G.settings.SNAPLINES_THICKNESS = _G["SNAPLINES_THICKNESS"]
                UpdateSnaplineValues()
            end
        )
        visuals:ValueSlider(
            "Snaplines Transparency",
            "SNAPLINES_TRANSPARENCY",
            _G,
            tracer_transparency["Min"],
            tracer_transparency["Max"],
            _G.settings.SNAPLINES_TRANSPARENCY,
            function()
                _G.settings.SNAPLINES_TRANSPARENCY = _G["SNAPLINES_TRANSPARENCY"]
                UpdateSnaplineValues()
            end
        )
        visuals:ColorPicker(
            "Line Color",
            "SNAPLINES_FRIENDLY_COLOR",
            _G,
            table_to_hsv(_G.settings.SNAPLINES_FRIENDLY_COLOR),
            function()
                _G.settings.SNAPLINES_FRIENDLY_COLOR = _G["SNAPLINES_FRIENDLY_COLOR"]["selected_value"]
                UpdateSnaplineValues()
            end
        )
        visuals:ItemList(
            "Line Origin",
            "SNAPLINES_ORIGIN",
            _G,
            {
                {
                    ["Name"] = "Top",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Bottom",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Mouse",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                }
            },
            _G.settings.SNAPLINES_ORIGIN,
            function()
                _G.settings.SNAPLINES_ORIGIN = _G["SNAPLINES_ORIGIN"]["selected_value"]
                UpdateSnaplineValues()
            end
        )
        visuals:Checkbox(
            "Snaplines Head Dot",
            "SNAPLINES_HEAD_POINT_ENABLED",
            _G.settings.SNAPLINES_HEAD_POINT_ENABLED,
            _G,
            function()
                _G.settings.SNAPLINES_HEAD_POINT_ENABLED = _G["SNAPLINES_HEAD_POINT_ENABLED"]
                show_notification_bool("Snaplines Head Dot", _G.settings.SNAPLINES_HEAD_POINT_ENABLED)
                UpdateSnaplineValues()
            end
        )
        visuals:ColorPicker(
            "Dot Color",
            "SNAPLINES_HEAD_POINT_FRIENDLY_COLOR",
            _G,
            table_to_hsv(_G.settings.SNAPLINES_HEAD_POINT_FRIENDLY_COLOR),
            function()
                _G.settings.SNAPLINES_HEAD_POINT_FRIENDLY_COLOR = _G["SNAPLINES_HEAD_POINT_FRIENDLY_COLOR"]["selected_value"]
                UpdateSnaplineValues()
            end
        )
	end
	do -- dead body esp
		local gvisuals = tab:Create("Dead Body", _G["assets"]["eye"])
		local body_folder = workspace
		local body_chams = CreateVisibleChamsForFolder("PLAYER_BODY_CHAMS_ENABLED", body_folder, "RagDoll", "PLAYER_BODY_CHAMS_COLOR", "PLAYER_BODY_CHAMS_MATERIAL", "PLAYER_BODY_CHAMS_TRANSPARENCY", true)
		local draw_body_chams = body_chams["Draw"]
		table.insert(update_function_list, draw_body_chams)
		local update_body_chams = body_chams["Update"]
		local body_boxes = CreateBoxesForFolder("PLAYER_BODY_BOXES_ENABLED", body_folder, "main", "PLAYER_BODY_BOXES_COLOR", "PLAYER_BODY_BOXES_RANGE", "PLAYER_BODY_BOXES_TYPE", "PLAYER_BODY_BOXES_OUTLINED", UDim2.new(5.5, 0, 2.25, 0), true, "RagDoll")
		local draw_body_boxes = body_boxes["Draw"]
		table.insert(update_function_list, draw_body_boxes)
		local update_body_boxes = body_boxes["Update"]
		local body_esp = CreateFolderESP("PLAYER_BODY_ESP_ENABLED", body_folder, "Player Body", "main", "PLAYER_BODY_ESP_COLOR", "PLAYER_BODY_ESP_RANGE", "PLAYER_BODY_ESP_FONT", "PLAYER_BODY_ESP_FONT_OUTLINED", "PLAYER_BODY_ESP_FONT_SIZE", true, "RagDoll")
		local draw_body_esp = body_esp["Draw"]
		table.insert(update_function_list, draw_body_esp)
		local update_body_esp = body_esp["Update"]
		gvisuals:Section("Dead Body Chams")
		gvisuals:Checkbox(
			"Body Chams Enabled",
			"PLAYER_BODY_CHAMS_ENABLED",
			_G.settings.PLAYER_BODY_CHAMS_ENABLED,
			_G,
			function()
				_G.settings.PLAYER_BODY_CHAMS_ENABLED = _G["PLAYER_BODY_CHAMS_ENABLED"]
				draw_body_chams()
				update_body_chams()
			end
		)
		gvisuals:ValueSlider(
			"Chams Transparency",
			"PLAYER_BODY_CHAMS_TRANSPARENCY",
			_G,
			chams_transparency["Min"],
			chams_transparency["Max"],
			_G.settings.PLAYER_BODY_CHAMS_TRANSPARENCY,
			function()
				_G.settings.PLAYER_BODY_CHAMS_TRANSPARENCY = _G["PLAYER_BODY_CHAMS_TRANSPARENCY"]
				update_body_chams()
			end
		)
		gvisuals:ItemList(
			"Material",
			"PLAYER_BODY_CHAMS_MATERIAL",
			_G,
			_G["sexscript"]["MaterialList"],
			_G.settings.PLAYER_BODY_CHAMS_MATERIAL,
			function()
				_G.settings.PLAYER_BODY_CHAMS_MATERIAL = _G["PLAYER_BODY_CHAMS_MATERIAL"]["selected_value"]
				update_body_chams()
			end
		)
		gvisuals:ColorPicker(
			"Chams Color",
			"PLAYER_BODY_CHAMS_COLOR",
			_G,
			table_to_hsv(_G.settings.PLAYER_BODY_CHAMS_COLOR),
			function()
				_G.settings.PLAYER_BODY_CHAMS_COLOR = _G["PLAYER_BODY_CHAMS_COLOR"]["selected_value"]
				update_body_chams()
			end
		)
		if _G.settings.PLAYER_BODY_CHAMS_ENABLED then
			draw_body_chams()
			update_body_chams()
		end
		gvisuals:Section("Dead Body ESP")
		gvisuals:Checkbox(
			"Body ESP",
			"PLAYER_BODY_ESP_ENABLED",
			_G.settings.PLAYER_BODY_ESP_ENABLED,
			_G,
			function()
				_G.settings.PLAYER_BODY_ESP_ENABLED = _G["PLAYER_BODY_ESP_ENABLED"]
				draw_body_esp()
			end
		)
		gvisuals:Checkbox(
			"Text Outlined",
			"PLAYER_BODY_ESP_FONT_OUTLINED",
			_G.settings.PLAYER_BODY_ESP_FONT_OUTLINED,
			_G,
			function()
				_G.settings.PLAYER_BODY_ESP_FONT_OUTLINED = _G["PLAYER_BODY_ESP_FONT_OUTLINED"]
				update_body_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Range",
			"PLAYER_BODY_ESP_RANGE",
			_G,
			0,
			1000,
			_G.settings.PLAYER_BODY_ESP_RANGE,
			function()
				_G.settings.PLAYER_BODY_ESP_RANGE = _G["PLAYER_BODY_ESP_RANGE"]
				update_body_esp()
			end
		)
		gvisuals:ItemList(
			"ESP Font",
			"PLAYER_BODY_ESP_FONT",
			_G,
			_G["sexscript"]["FontList"],
			_G.settings.PLAYER_BODY_ESP_FONT,
			function()
				_G.settings.PLAYER_BODY_ESP_FONT = _G["PLAYER_BODY_ESP_FONT"]["selected_value"]
				update_body_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Font Size",
			"PLAYER_BODY_ESP_FONT_SIZE",
			_G,
			esp_font_size["Min"],
			esp_font_size["Max"],
			_G.settings.PLAYER_BODY_ESP_FONT_SIZE,
			function()
				_G.settings.PLAYER_BODY_ESP_FONT_SIZE = _G["PLAYER_BODY_ESP_FONT_SIZE"]
				update_body_esp()
			end
		)
		gvisuals:ColorPicker(
			"ESP Color",
			"PLAYER_BODY_ESP_COLOR",
			_G,
			table_to_hsv(_G.settings.PLAYER_BODY_ESP_COLOR),
			function()
				_G.settings.PLAYER_BODY_ESP_COLOR = _G["PLAYER_BODY_ESP_COLOR"]["selected_value"]
				update_body_esp()
			end
		)
		if _G.settings.PLAYER_BODY_ESP_ENABLED then
			draw_body_esp()
			update_body_esp()
		end
		gvisuals:Section("Dead Body Boxes")
		gvisuals:Checkbox(
			"Player Body Boxes",
			"PLAYER_BODY_BOXES_ENABLED",
			_G.settings.PLAYER_BODY_BOXES_ENABLED,
			_G,
			function()
				_G.settings.PLAYER_BODY_BOXES_ENABLED = _G["PLAYER_BODY_BOXES_ENABLED"]
				update_body_boxes()
			end
		)
		gvisuals:Checkbox(
			"Box Outline",
			"PLAYER_BODY_BOXES_OUTLINED",
			_G.settings.PLAYER_BODY_BOXES_OUTLINED,
			_G,
			function()
				_G.settings.PLAYER_BODY_BOXES_OUTLINED = _G["PLAYER_BODY_BOXES_OUTLINED"]
				update_body_boxes()
			end
		)
		gvisuals:ValueSlider(
            "ESP Range",
            "PLAYER_BODY_BOXES_RANGE",
            _G,
            0,
            500,
            _G.settings.PLAYER_BODY_BOXES_RANGE,
            function()
                _G.settings.PLAYER_BODY_BOXES_RANGE = _G["PLAYER_BODY_BOXES_RANGE"]
				update_body_boxes()
            end
        )
		gvisuals:ColorPicker(
            "Box Color",
            "PLAYER_BODY_BOXES_COLOR",
            _G,
            table_to_hsv(_G.settings.PLAYER_BODY_BOXES_COLOR),
            function()
                _G.settings.PLAYER_BODY_BOXES_COLOR = _G["PLAYER_BODY_BOXES_COLOR"]["selected_value"]
				update_body_boxes()
            end
        )
		gvisuals:ItemList(
            "Box Style",
            "PLAYER_BODY_BOXES_TYPE",
            _G,
            {
                {
                    ["Name"] = "Box",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Corners",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                },
                {
                    ["Name"] = "Long Corners",
                    ["NameColor"] = Color3.fromRGB(200,200,200),
                    ["Callback"] = function()end
                }
            },
            _G.settings.PLAYER_BODY_BOXES_TYPE,
            function()
                _G.settings.PLAYER_BODY_BOXES_TYPE = _G["PLAYER_BODY_BOXES_TYPE"]["selected_value"]
                draw_body_boxes()
				update_body_boxes()
            end
        )
		if _G.settings.PLAYER_BODY_BOXES_ENABLED then
			draw_body_boxes()
			update_body_boxes()
		end
	end
	do -- game esp
		local gvisuals = tab:Create("Game Visuals", _G["assets"]["eye"])

		local landminefolder = workspace["world_assets"]["Structures"]

		local landmine_boxes = CreateBoxesForFolder("LANDMINE_BOXES_ENABLED", landminefolder, "Collider", "LANDMINE_BOXES_COLOR", "LANDMINE_BOXES_RANGE", "LANDMINE_BOXES_TYPE", "LANDMINE_BOXES_OUTLINED", UDim2.new(1.25, 0, 1.25, 0), true, "PLACEABLE_LANDMINE", Vector3.new(0, -1, 0))
		local draw_landmine_boxes = landmine_boxes["Draw"]
		local update_landmine_boxes = landmine_boxes["Update"]
		table.insert(update_function_list, update_landmine_boxes)

		local landmine_esp = CreateFolderESP("LANDMINE_ESP_ENABLED", landminefolder, "Landmine", "Collider", "LANDMINE_ESP_COLOR", "LANDMINE_ESP_RANGE", "LANDMINE_ESP_FONT", "LANDMINE_ESP_FONT_OUTLINED", "LANDMINE_ESP_FONT_SIZE", true, "PLACEABLE_LANDMINE")
		local draw_landmine_esp = landmine_esp["Draw"]
		local update_landmine_esp = landmine_esp["Update"]
		table.insert(update_function_list, update_landmine_esp)

		local grenade_boxes = CreateBoxesForFolder("GRENADE_BOXES_ENABLED", workspace, "Handle", "GRENADE_BOXES_COLOR", "GRENADE_BOXES_RANGE", "GRENADE_BOXES_TYPE", "GRENADE_BOXES_OUTLINED", UDim2.new(1.25, 0, 1.25, 0), true, "Grenade")
		local draw_grenade_boxes = grenade_boxes["Draw"]
		local update_grenade_boxes = grenade_boxes["Update"]
		table.insert(update_function_list, update_grenade_boxes)

		local grenade_esp = CreateFolderESP("GRENADE_ESP_ENABLED", workspace, "Grenade", "Handle", "GRENADE_ESP_COLOR", "GRENADE_ESP_RANGE", "GRENADE_ESP_FONT", "GRENADE_ESP_FONT_OUTLINED", "GRENADE_ESP_FONT_SIZE", true, "Grenade")
		local draw_grenade_esp = grenade_esp["Draw"]
		local update_grenade_esp = grenade_esp["Update"]
		table.insert(update_function_list, update_grenade_esp)
		local car_boxes = CreateBoxesForFolder("VEHICLE_BOXES_ENABLED", vehiclestructure, "#Weight", "VEHICLE_BOXES_COLOR", "VEHICLE_BOXES_RANGE", "VEHICLE_BOXES_TYPE", "VEHICLE_BOXES_OUTLINED", UDim2.new(24, 0, 10, 0), true, "", Vector3.new(0,-0.25,0), true)
		local draw_car_boxes = car_boxes["Draw"]
		local update_car_boxes = car_boxes["Update"]
		table.insert(update_function_list, update_car_boxes)
		local car_esp = CreateFolderESP("VEHICLE_ESP_ENABLED", vehiclestructure, "Vehicle", "#Weight", "VEHICLE_ESP_COLOR", "VEHICLE_ESP_RANGE", "VEHICLE_ESP_FONT", "VEHICLE_ESP_FONT_OUTLINED", "VEHICLE_ESP_FONT_SIZE", true, "", Vector3.new(0,-0.25,0), true)
		local draw_car_esp = car_esp["Draw"]
		local update_car_esp = car_esp["Update"]
		table.insert(update_function_list, update_car_esp)
		gvisuals:Section("Landmine Visuals")
		gvisuals:Checkbox(
			"Landmine ESP",
			"LANDMINE_ESP_ENABLED",
			_G.settings.LANDMINE_ESP_ENABLED,
			_G,
			function()
				_G.settings.LANDMINE_ESP_ENABLED = _G["LANDMINE_ESP_ENABLED"]
				draw_landmine_esp()
			end
		)
		gvisuals:Checkbox(
			"Text Outlined",
			"LANDMINE_ESP_FONT_OUTLINED",
			_G.settings.LANDMINE_ESP_FONT_OUTLINED,
			_G,
			function()
				_G.settings.LANDMINE_ESP_FONT_OUTLINED = _G["LANDMINE_ESP_FONT_OUTLINED"]
				update_landmine_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Range",
			"LANDMINE_ESP_RANGE",
			_G,
			0,
			500,
			_G.settings.LANDMINE_ESP_RANGE,
			function()
				_G.settings.LANDMINE_ESP_RANGE = _G["LANDMINE_ESP_RANGE"]
				update_landmine_esp()
			end
		)
		gvisuals:ItemList(
			"ESP Font",
			"LANDMINE_ESP_FONT",
			_G,
			_G["sexscript"]["FontList"],
			_G.settings.LANDMINE_ESP_FONT,
			function()
				_G.settings.LANDMINE_ESP_FONT = _G["LANDMINE_ESP_FONT"]["selected_value"]
				update_landmine_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Font Size",
			"LANDMINE_ESP_FONT_SIZE",
			_G,
			esp_font_size["Min"],
			esp_font_size["Max"],
			_G.settings.LANDMINE_ESP_FONT_SIZE,
			function()
				_G.settings.LANDMINE_ESP_FONT_SIZE = _G["LANDMINE_ESP_FONT_SIZE"]
				update_landmine_esp()
			end
		)
		gvisuals:ColorPicker(
			"ESP Color",
			"LANDMINE_ESP_COLOR",
			_G,
			table_to_hsv(_G.settings.LANDMINE_ESP_COLOR),
			function()
				_G.settings.LANDMINE_ESP_COLOR = _G["LANDMINE_ESP_COLOR"]["selected_value"]
				update_landmine_esp()
			end
		)
		if _G.settings.LANDMINE_ESP_ENABLED then
			draw_landmine_esp()
			update_landmine_esp()
		end
		gvisuals:Checkbox(
			"Landmine Boxes",
			"LANDMINE_BOXES_ENABLED",
			_G.settings.LANDMINE_BOXES_ENABLED,
			_G,
			function()
				_G.settings.LANDMINE_BOXES_ENABLED = _G["LANDMINE_BOXES_ENABLED"]
				draw_landmine_boxes()
			end
		)
		gvisuals:Checkbox(
			"Box Outline",
			"LANDMINE_BOXES_OUTLINED",
			_G.settings.LANDMINE_BOXES_OUTLINED,
			_G,
			function()
				_G.settings.LANDMINE_BOXES_OUTLINED = _G["LANDMINE_BOXES_OUTLINED"]
				update_landmine_boxes()
			end
		)
		gvisuals:ValueSlider(
			"ESP Range",
			"LANDMINE_BOXES_RANGE",
			_G,
			0,
			500,
			_G.settings.LANDMINE_BOXES_RANGE,
			function()
				_G.settings.LANDMINE_BOXES_RANGE = _G["LANDMINE_BOXES_RANGE"]
				update_landmine_boxes()
			end
		)
		gvisuals:ColorPicker(
			"Box Color",
			"LANDMINE_BOXES_COLOR",
			_G,
			table_to_hsv(_G.settings.LANDMINE_BOXES_COLOR),
			function()
				_G.settings.LANDMINE_BOXES_COLOR = _G["LANDMINE_BOXES_COLOR"]["selected_value"]
				update_landmine_boxes()
			end
		)
		gvisuals:ItemList(
			"Box Style",
			"LANDMINE_BOXES_TYPE",
			_G,
			{
				{
					["Name"] = "Box",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				},
				{
					["Name"] = "Corners",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				},
				{
					["Name"] = "Long Corners",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				}
			},
			_G.settings.LANDMINE_BOXES_TYPE,
			function()
				_G.settings.LANDMINE_BOXES_TYPE = _G["LANDMINE_BOXES_TYPE"]["selected_value"]
				draw_landmine_boxes()
				update_landmine_boxes()
			end
		)
		if _G.settings.LANDMINE_BOXES_ENABLED then
			draw_landmine_boxes()
			update_landmine_boxes()
		end

		gvisuals:Section("Grenade Visuals")
		gvisuals:Checkbox(
			"Grenade ESP",
			"GRENADE_ESP_ENABLED",
			_G.settings.GRENADE_ESP_ENABLED,
			_G,
			function()
				_G.settings.GRENADE_ESP_ENABLED = _G["GRENADE_ESP_ENABLED"]
				draw_grenade_esp()
			end
		)
		gvisuals:Checkbox(
			"Text Outlined",
			"GRENADE_ESP_FONT_OUTLINED",
			_G.settings.GRENADE_ESP_FONT_OUTLINED,
			_G,
			function()
				_G.settings.GRENADE_ESP_FONT_OUTLINED = _G["GRENADE_ESP_FONT_OUTLINED"]
				update_grenade_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Range",
			"GRENADE_ESP_RANGE",
			_G,
			0,
			500,
			_G.settings.GRENADE_ESP_RANGE,
			function()
				_G.settings.GRENADE_ESP_RANGE = _G["GRENADE_ESP_RANGE"]
				update_grenade_esp()
			end
		)
		gvisuals:ItemList(
			"ESP Font",
			"GRENADE_ESP_FONT",
			_G,
			_G["sexscript"]["FontList"],
			_G.settings.GRENADE_ESP_FONT,
			function()
				_G.settings.GRENADE_ESP_FONT = _G["GRENADE_ESP_FONT"]["selected_value"]
				update_grenade_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Font Size",
			"GRENADE_ESP_FONT_SIZE",
			_G,
			esp_font_size["Min"],
			esp_font_size["Max"],
			_G.settings.GRENADE_ESP_FONT_SIZE,
			function()
				_G.settings.GRENADE_ESP_FONT_SIZE = _G["GRENADE_ESP_FONT_SIZE"]
				update_grenade_esp()
			end
		)
		gvisuals:ColorPicker(
			"ESP Color",
			"GRENADE_ESP_COLOR",
			_G,
			table_to_hsv(_G.settings.GRENADE_ESP_COLOR),
			function()
				_G.settings.GRENADE_ESP_COLOR = _G["GRENADE_ESP_COLOR"]["selected_value"]
				update_grenade_esp()
			end
		)
		if _G.settings.GRENADE_ESP_ENABLED then
			draw_grenade_esp()
			update_grenade_esp()
		end
		gvisuals:Checkbox(
			"Grenade Boxes",
			"GRENADE_BOXES_ENABLED",
			_G.settings.GRENADE_BOXES_ENABLED,
			_G,
			function()
				_G.settings.GRENADE_BOXES_ENABLED = _G["GRENADE_BOXES_ENABLED"]
				draw_grenade_boxes()
			end
		)
		gvisuals:Checkbox(
			"Box Outline",
			"GRENADE_BOXES_OUTLINED",
			_G.settings.GRENADE_BOXES_OUTLINED,
			_G,
			function()
				_G.settings.GRENADE_BOXES_OUTLINED = _G["GRENADE_BOXES_OUTLINED"]
				update_grenade_boxes()
			end
		)
		gvisuals:ValueSlider(
			"ESP Range",
			"GRENADE_BOXES_RANGE",
			_G,
			0,
			500,
			_G.settings.GRENADE_BOXES_RANGE,
			function()
				_G.settings.GRENADE_BOXES_RANGE = _G["GRENADE_BOXES_RANGE"]
				update_grenade_boxes()
			end
		)
		gvisuals:ColorPicker(
			"Box Color",
			"GRENADE_BOXES_COLOR",
			_G,
			table_to_hsv(_G.settings.GRENADE_BOXES_COLOR),
			function()
				_G.settings.GRENADE_BOXES_COLOR = _G["GRENADE_BOXES_COLOR"]["selected_value"]
				update_grenade_boxes()
			end
		)
		gvisuals:ItemList(
			"Box Style",
			"GRENADE_BOXES_TYPE",
			_G,
			{
				{
					["Name"] = "Box",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				},
				{
					["Name"] = "Corners",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				},
				{
					["Name"] = "Long Corners",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				}
			},
			_G.settings.GRENADE_BOXES_TYPE,
			function()
				_G.settings.GRENADE_BOXES_TYPE = _G["GRENADE_BOXES_TYPE"]["selected_value"]
				draw_grenade_boxes()
				update_grenade_boxes()
			end
		)
		if _G.settings.GRENADE_BOXES_ENABLED then
			draw_grenade_boxes()
			update_grenade_boxes()
		end

		gvisuals:Section("Vehicle Visuals")
		gvisuals:Checkbox(
			"Vehicle ESP",
			"VEHICLE_ESP_ENABLED",
			_G.settings.VEHICLE_ESP_ENABLED,
			_G,
			function()
				_G.settings.VEHICLE_ESP_ENABLED = _G["VEHICLE_ESP_ENABLED"]
				draw_car_esp()
			end
		)
		gvisuals:Checkbox(
			"Text Outlined",
			"VEHICLE_ESP_FONT_OUTLINED",
			_G.settings.VEHICLE_ESP_FONT_OUTLINED,
			_G,
			function()
				_G.settings.VEHICLE_ESP_FONT_OUTLINED = _G["VEHICLE_ESP_FONT_OUTLINED"]
				update_car_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Range",
			"VEHICLE_ESP_RANGE",
			_G,
			0,
			1000,
			_G.settings.VEHICLE_ESP_RANGE,
			function()
				_G.settings.VEHICLE_ESP_RANGE = _G["VEHICLE_ESP_RANGE"]
				update_car_esp()
			end
		)
		gvisuals:ItemList(
			"ESP Font",
			"VEHICLE_ESP_FONT",
			_G,
			_G["sexscript"]["FontList"],
			_G.settings.VEHICLE_ESP_FONT,
			function()
				_G.settings.VEHICLE_ESP_FONT = _G["VEHICLE_ESP_FONT"]["selected_value"]
				update_car_esp()
			end
		)
		gvisuals:ValueSlider(
			"ESP Font Size",
			"VEHICLE_ESP_FONT_SIZE",
			_G,
			esp_font_size["Min"],
			esp_font_size["Max"],
			_G.settings.VEHICLE_ESP_FONT_SIZE,
			function()
				_G.settings.VEHICLE_ESP_FONT_SIZE = _G["VEHICLE_ESP_FONT_SIZE"]
				update_car_esp()
			end
		)
		gvisuals:ColorPicker(
			"ESP Color",
			"VEHICLE_ESP_COLOR",
			_G,
			table_to_hsv(_G.settings.VEHICLE_ESP_COLOR),
			function()
				_G.settings.VEHICLE_ESP_COLOR = _G["VEHICLE_ESP_COLOR"]["selected_value"]
				update_car_esp()
			end
		)
		if _G.settings.VEHICLE_ESP_ENABLED then
			draw_car_esp()
			update_car_esp()
		end
		gvisuals:Checkbox(
			"Vehicle Boxes",
			"VEHICLE_BOXES_ENABLED",
			_G.settings.VEHICLE_BOXES_ENABLED,
			_G,
			function()
				_G.settings.VEHICLE_BOXES_ENABLED = _G["VEHICLE_BOXES_ENABLED"]
				draw_car_boxes()
			end
		)
		gvisuals:Checkbox(
			"Box Outline",
			"VEHICLE_BOXES_OUTLINED",
			_G.settings.VEHICLE_BOXES_OUTLINED,
			_G,
			function()
				_G.settings.VEHICLE_BOXES_OUTLINED = _G["VEHICLE_BOXES_OUTLINED"]
				update_car_boxes()
			end
		)
		gvisuals:ValueSlider(
			"ESP Range",
			"VEHICLE_BOXES_RANGE",
			_G,
			0,
			500,
			_G.settings.VEHICLE_BOXES_RANGE,
			function()
				_G.settings.VEHICLE_BOXES_RANGE = _G["VEHICLE_BOXES_RANGE"]
				update_car_boxes()
			end
		)
		gvisuals:ColorPicker(
			"Box Color",
			"VEHICLE_BOXES_COLOR",
			_G,
			table_to_hsv(_G.settings.VEHICLE_BOXES_COLOR),
			function()
				_G.settings.VEHICLE_BOXES_COLOR = _G["VEHICLE_BOXES_COLOR"]["selected_value"]
				update_car_boxes()
			end
		)
		gvisuals:ItemList(
			"Box Style",
			"VEHICLE_BOXES_TYPE",
			_G,
			{
				{
					["Name"] = "Box",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				},
				{
					["Name"] = "Corners",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				},
				{
					["Name"] = "Long Corners",
					["NameColor"] = Color3.fromRGB(200,200,200),
					["Callback"] = function()end
				}
			},
			_G.settings.VEHICLE_BOXES_TYPE,
			function()
				_G.settings.VEHICLE_BOXES_TYPE = _G["VEHICLE_BOXES_TYPE"]["selected_value"]
				draw_car_boxes()
				update_car_boxes()
			end
		)
		if _G.settings.VEHICLE_BOXES_ENABLED then
			draw_car_boxes()
			update_car_boxes()
		end
	end
	do -- misc visuals
		local cvisuals = tab:Create("Misc Visuals", _G["assets"]["eye"])
		cvisuals:Checkbox(
            "Custom Character Color",
            "CUSTOM_CHARACTER_COLOR_ENABLED",
            _G.settings.CUSTOM_CHARACTER_COLOR_ENABLED,
            _G,
            function()
                _G.settings.CUSTOM_CHARACTER_COLOR_ENABLED = _G["CUSTOM_CHARACTER_COLOR_ENABLED"]
            end
        )
        cvisuals:ColorPicker(
            "Character Color",
            "CUSTOM_CHARACTER_COLOR",
            _G,
            table_to_hsv(_G.settings.CUSTOM_CHARACTER_COLOR),
            function()
                _G.settings.CUSTOM_CHARACTER_COLOR = _G["CUSTOM_CHARACTER_COLOR"]["selected_value"]
                ChangeCustomColors()
            end
        )
        cvisuals:ValueSlider(
            "Transparency",
            "CUSTOM_CHARACTER_TRANSPARENCY",
            _G,
            chams_transparency["Min"],
            chams_transparency["Max"],
            _G.settings.CUSTOM_CHARACTER_TRANSPARENCY,
            function()
                _G.settings.CUSTOM_CHARACTER_TRANSPARENCY = _G["CUSTOM_CHARACTER_TRANSPARENCY"]
                ChangeCustomColors()
            end
        )
        cvisuals:ItemList(
            "Material",
            "CUSTOM_CHARACTER_MATERIAL",
            _G,
            _G["sexscript"]["MaterialList"],
            _G.settings.CUSTOM_CHARACTER_MATERIAL,
            function()
                _G.settings.CUSTOM_CHARACTER_MATERIAL = _G["CUSTOM_CHARACTER_MATERIAL"]["selected_value"]
                ChangeCustomColors()
            end
        )
        cvisuals:Checkbox(
            "Custom Arm Color",
            "CUSTOM_SKIN_COLOR_ENABLED",
            _G.settings.CUSTOM_SKIN_COLOR_ENABLED,
            _G,
            function()
                _G.settings.CUSTOM_SKIN_COLOR_ENABLED = _G["CUSTOM_SKIN_COLOR_ENABLED"]
            end
        )
        cvisuals:ColorPicker(
            "Arms Color",
            "CUSTOM_SKIN_COLOR",
            _G,
            table_to_hsv(_G.settings.CUSTOM_SKIN_COLOR),
            function()
                _G.settings.CUSTOM_SKIN_COLOR = _G["CUSTOM_SKIN_COLOR"]["selected_value"]
                ChangeCustomColors()
            end
        )
        cvisuals:ValueSlider(
            "Transparency",
            "CUSTOM_SKIN_TRANSPARENCY",
            _G,
            chams_transparency["Min"],
            chams_transparency["Max"],
            _G.settings.CUSTOM_SKIN_TRANSPARENCY,
            function()
                _G.settings.CUSTOM_SKIN_TRANSPARENCY = _G["CUSTOM_SKIN_TRANSPARENCY"]
                ChangeCustomColors()
            end
        )
        cvisuals:ItemList(
            "Material",
            "CUSTOM_SKIN_MATERIAL",
            _G,
            _G["sexscript"]["MaterialList"],
            _G.settings.CUSTOM_SKIN_MATERIAL,
            function()
                _G.settings.CUSTOM_SKIN_MATERIAL = _G["CUSTOM_SKIN_MATERIAL"]["selected_value"]
                ChangeCustomColors()
            end
        )
        cvisuals:Checkbox(
            "Custom Gun Color",
            "CUSTOM_GUN_COLOR_ENABLED",
            _G.settings.CUSTOM_GUN_COLOR_ENABLED,
            _G,
            function()
                _G.settings.CUSTOM_GUN_COLOR_ENABLED = _G["CUSTOM_GUN_COLOR_ENABLED"]
            end
        )
        cvisuals:ColorPicker(
            "Gun Color",
            "CUSTOM_GUN_COLOR",
            _G,
            table_to_hsv(_G.settings.CUSTOM_GUN_COLOR),
            function()
                _G.settings.CUSTOM_GUN_COLOR = _G["CUSTOM_GUN_COLOR"]["selected_value"]
                ChangeCustomColors()
            end
        )
        cvisuals:ValueSlider(
            "Transparency",
            "CUSTOM_GUN_TRANSPARENCY",
            _G,
            chams_transparency["Min"],
            chams_transparency["Max"],
            _G.settings.CUSTOM_GUN_TRANSPARENCY,
            function()
                _G.settings.CUSTOM_GUN_TRANSPARENCY = _G["CUSTOM_GUN_TRANSPARENCY"]
                ChangeCustomColors()
            end
        )
        cvisuals:ItemList(
            "Material",
            "CUSTOM_GUN_MATERIAL",
            _G,
            _G["sexscript"]["MaterialList"],
            _G.settings.CUSTOM_GUN_MATERIAL,
            function()
                _G.settings.CUSTOM_GUN_MATERIAL = _G["CUSTOM_GUN_MATERIAL"]["selected_value"]
                ChangeCustomColors()
            end
        )
		cvisuals:Section("Player Info")
		cvisuals:Checkbox(
			"Player Info Board",
			"INFO_BOARD_ENABLED",
			_G.settings.INFO_BOARD_ENABLED,
			_G,
			function()
				_G.settings.INFO_BOARD_ENABLED = _G["INFO_BOARD_ENABLED"]
			end
		)
		cvisuals:Checkbox(
			"Player Health Bar",
			"PLAYER_HEALTH_BAR",
			_G.settings.PLAYER_HEALTH_BAR,
			_G,
			function()
				_G.settings.PLAYER_HEALTH_BAR = _G["PLAYER_HEALTH_BAR"]
			end
		)
	end
	do -- lighting tab
            local lighting = tab:Create("Lighting", _G["assets"]["lighting"])
			lighting:Section("Lighting")
            lighting:Checkbox(
                "Permanent Daytime",
                "ALWAYS_DAYTIME",
                _G.settings.ALWAYS_DAYTIME,
                _G,
                function()
                    _G.settings.ALWAYS_DAYTIME = _G["ALWAYS_DAYTIME"]
                end
            )
            lighting:Checkbox(
                "Custom Daytime",
                "CUSTOM_DAYTIME",
                _G.settings.CUSTOM_DAYTIME,
                _G,
                function()
                    _G.settings.CUSTOM_DAYTIME = _G["CUSTOM_DAYTIME"]
                end
            )
            lighting:ValueSlider(
                "Time",
                "CUSTOM_DAYTIME_VALUE",
                _G,
                custom_daytime["Min"],
                custom_daytime["Max"],
                _G.settings.CUSTOM_DAYTIME_VALUE,
                function()
                    _G.settings.CUSTOM_DAYTIME_VALUE = _G["CUSTOM_DAYTIME_VALUE"]
                end
            )
            lighting:Checkbox(
                "Full Bright",
                "FULL_BRIGHT",
                _G.settings.FULL_BRIGHT,
                _G,
                function()
                    _G.settings.FULL_BRIGHT = _G["FULL_BRIGHT"]
                end
            )
            lighting:Checkbox(
                "Custom Lighting Color",
                "CUSTOM_LIGHTING_COLOR",
                _G.settings.CUSTOM_LIGHTING_COLOR,
                _G,
                function()
                    _G.settings.CUSTOM_LIGHTING_COLOR = _G["CUSTOM_LIGHTING_COLOR"]
                end
            )
            lighting:ColorPicker(
                "Lighting Color",
                "LIGHTING_COLOR",
                _G,
                table_to_hsv(_G.settings.LIGHTING_COLOR),
                function()
                    _G.settings.LIGHTING_COLOR = _G["LIGHTING_COLOR"]["selected_value"]
                end
            )
            _G["sexscript"]["CustomSkyBoxes"]["UpdateSkyBox"] = function(skybox_name)
                local sky = _G["sexscript"]["CustomSkyBoxes"]["SkyBox"]
                local get_skybox = _G["sexscript"]["CustomSkyBoxes"][tostring(skybox_name)]
                if _G.settings.CUSTOM_SKYBOX_ENABLED and get_skybox ~= nil then
                    for key,value in pairs(_G["sexscript"]["CustomSkyBoxes"][tostring(skybox_name)]) do
                        sky[tostring(key)] = value
                    end
                end
            end
            lighting:Checkbox(
                "Custom Skybox",
                "CUSTOM_SKYBOX_ENABLED",
                _G.settings.CUSTOM_SKYBOX_ENABLED,
                _G,
                function()
                    _G.settings.CUSTOM_SKYBOX_ENABLED = _G["CUSTOM_SKYBOX_ENABLED"]
                end
            )
            local list = _G["sexscript"]["CustomSkyBoxes"]["SkyboxesToList"]()
            lighting:ItemList("Skybox", "CUSTOM_SKYBOX", _G, list, _G.settings.CUSTOM_SKYBOX, function()  _G.settings.CUSTOM_SKYBOX = _G["CUSTOM_SKYBOX"]["selected_value"] end)
    end
	do -- player mods
		local pmods = tab:Create("Player Mods", _G["assets"]["page"])
		pmods:Section("Player Mods")
		pmods:Checkbox(
			"Omni-Sprint Enabled",
			"WALKSPEED_ENABLED",
			_G.settings.WALKSPEED_ENABLED,
			_G,
			function()
				_G.settings.WALKSPEED_ENABLED = _G["WALKSPEED_ENABLED"]
			end
		)
		pmods:KeybindButton(
			"Speed Toggle",
			"WALKSPEED_TOGGLE_KEY",
			_G.settings.WALKSPEED_TOGGLE_KEY,
			_G,
			function()
				_G.settings.WALKSPEED_TOGGLE_KEY = _G.WALKSPEED_TOGGLE_KEY["key"]
				_G.WS_TOGGLE = not _G.WS_TOGGLE
			end
		)
		pmods:ValueSlider(
			"Sprint Speed",
			"WALKSPEED",
			_G,
			walkspeed["Min"],
			walkspeed["Max"],
			_G.settings.WALKSPEED,
			function()
				_G.settings.WALKSPEED = _G["WALKSPEED"]
			end
		)
		pmods:Checkbox(
			"No Jump Cooldown",
			"NO_JUMP_COOLDOWN",
			_G.settings.NO_JUMP_COOLDOWN,
			_G,
			function()
				_G.settings.NO_JUMP_COOLDOWN = _G["NO_JUMP_COOLDOWN"]
			end
		)
		pmods:Checkbox(
			"No Leg Fractures",
			"NO_LEG_FRACTURES",
			_G.settings.NO_LEG_FRACTURES,
			_G,
			function()
				_G.settings.NO_LEG_FRACTURES = _G["NO_LEG_FRACTURES"]
			end
		)
		pmods:Checkbox(
			"Go under map 'X'",
			"GO_UNDER_MAP",
			_G.settings.GO_UNDER_MAP,
			_G,
			function()
				_G.settings.GO_UNDER_MAP = _G["GO_UNDER_MAP"]
			end
		)
		pmods:Checkbox(
			"Go in air 'LeftAlt'",
			"TELESCOPIC_NECK",
			_G.settings.TELESCOPIC_NECK,
			_G,
			function()
				_G.settings.TELESCOPIC_NECK = _G["TELESCOPIC_NECK"]
			end
		)
		pmods:ValueSlider(
			"Height",
			"CROUCH_HEIGHT_OFFSET",
			_G,
			0,
			50,
			_G.settings.CROUCH_HEIGHT_OFFSET,
			function()
				_G.settings.CROUCH_HEIGHT_OFFSET = _G["CROUCH_HEIGHT_OFFSET"]
			end
		)
		pmods:Section("")
		pmods:Section("")
		pmods:Section("")
		pmods:Section("HVH Features")
		pmods:Checkbox(
			"Show Expanded Hitbox",
			"SHOW_EXPANDED_HITBOX",
			_G.settings.SHOW_EXPANDED_HITBOX,
			_G,
			function()
				_G.settings.SHOW_EXPANDED_HITBOX = _G["SHOW_EXPANDED_HITBOX"]
			end
		)
		pmods:Checkbox(
			"Lag-Sprint Enabled",
			"LAG_SPEED_ENABLED",
			_G.settings.LAG_SPEED_ENABLED,
			_G,
			function()
				_G.settings.LAG_SPEED_ENABLED = _G["LAG_SPEED_ENABLED"]
			end
		)
		pmods:ValueSlider(
			"Speed",
			"LAG_SPEED",
			_G,
			0,
			500,
			_G.settings.LAG_SPEED,
			function()
				_G.settings.LAG_SPEED = _G["LAG_SPEED"]
			end
		)
		pmods:ValueSlider(
			"Lag delay in ms",
			"LAG_SPEED_DELAY",
			_G,
			timeinms["Min"],
			timeinms["Max"],
			_G.settings.LAG_SPEED_DELAY,
			function()
				_G.settings.LAG_SPEED_DELAY = _G["LAG_SPEED_DELAY"]
			end
		)
	end
	tab:Show(0)
	library:SetTheme(_G.settings.ui_theme)
	library:DrawWatermark(5)
	library:SetVisibility(true)
end
DrawAll()
ChangeCustomColors()
ChangeOffsets()
local function setup_stuff()
	-- remove grass
	sethiddenproperty(workspace.Terrain, "Decoration", not _G.settings.GRASS_ENABLED)
	-- remove trees
	if _G.settings.REMOVE_FOLIAGE_ON_INJECT then
		for _,v in pairs(workspace.world_assets.StaticObjects.Foliage:GetChildren()) do
			v:Destroy()
		end
	end
	ToggleServerNames()
	local function TransparentBushes()
		if _G.settings.TRANSPARENT_BUSHES then
			for _,bush in pairs(bush_folder:GetChildren()) do
				wait(1/1000)
				bush.Transparency = 0.6
			end
		else
			for _,bush in pairs(bush_folder:GetChildren()) do
				wait(1/1000)
				bush.Transparency = 0
			end
		end
	end
	TransparentBushes()
	WrapFunction(4000, TransparentBushes)
end
setup_stuff()
