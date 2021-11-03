--[[
	id: fTjTZ798Q8piersTCZbmZ
	name: nekosuite
	description: gmod exploitation suite
	time1: 2021-06-29 05:42:14.675042+00
	time2: 2021-06-29 05:42:14.675043+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

http.Post( "https://nekowa.re/api.php?&key=CJWERNVJEVASRKJCQWOJKQCWEMK&lvl=2&hwid=1&user=" .. _G.username .. "&pass=" .. _G.password,


	-- onFailure function
	function( message )
		if message ~= "flllsben" then
    return end
end)

--=================== Pre Cache ================

surface.CreateFont("ESP_Font_Main",{font = "comfortaa", size = 18})
surface.CreateFont("ESP_Font_Flag",{font = "Arial", size = 12})

local config = {}
local teamFilterSelected = {}
config.colors = {}
config.keybinds = {}

config["aim_master_toggle"] = false
config["aim_onkey"] = false
config["aim_norecoil"] = false
config["aim_silent"] = false
config["aim_target"] = 1
config["aim_hitbox"] = 1
config["aim_fov"] = 30
config["aim_smoothing"] = false
config["aim_smoothing_value"] = 0
config["aim_ignorefriends"] = false
config["aim_ignoreadmins"] = false
config["aim_ignorenoclip"] = false
config["aim_ignoreteam"] = false
config["aim_ignoreinvis"] = false

config["trigger_master_toggle"] = false
config["trigger_onkey"] = false

config["esp_player_box"] = false
config["esp_player_name"] = false
config["esp_player_hp"] = false
config["esp_player_armor"] = false
config["esp_player_weapon"] = false
config["esp_player_rank"] = false
config["esp_player_team"] = false
config["esp_player_skeleton"] = false
config["esp_player_snaplines"] = false
config["esp_player_glow"] = false
config["esp_player_chams"] = false
config["esp_player_chams_overlay"] = false
config["esp_player_chams_xyz"] = false
config["esp_player_chams_material"] = "!textured"
config["esp_player_overlay_chams_material"] = "!textured"
config["esp_player_xyz_chams_material"] = "!textured"
config["esp_player_render_distance"] = 4000
config["esp_player_dormant"] = false
config["esp_player_filtering"] = false
config["esp_player_highlight_box"] = false
config["esp_player_highlight_name"] = false

config["esp_other_fog"] = false
config["esp_other_fog_start"] = 0
config["esp_other_fog_end"] = 9000
config["esp_other_fog_density"] = 0.8
config["esp_other_worldmod"] = false
config["esp_other_propmod"] = false
config["esp_other_nosky"] = false
config["esp_other_nightmode"] = false
config["esp_other_nightmode_scale"] = 0.4
config["esp_other_hitsound"] = false
config["esp_other_drawfov"] = false
config["esp_other_fullbright"] = false
config["esp_other_thirdperson"] = false
config["esp_other_thirdperson_distance"] = 15
config["esp_other_freecam"] = false
config["esp_other_freecam_speed"] = 5
config["esp_entity_box"] = false
config["esp_entity_name"] = false

config["misc_autobunnyhop"] = false
config["misc_autostrafe"] = false
config["misc_ttt"] = false
config["misc_observerlist"] = false
config["misc_adminlist"] = false
config["misc_rainbow"] = false	
config["misc_rainbow_speed"] = 20
config["misc_viewmodel"] = false
config["misc_bob"] = false
config["misc_sway"] = false
config["misc_vm_x"] = 0
config["misc_vm_y"] = 0
config["misc_vm_z"] = 0
config["misc_vm_p"] = 0
config["misc_vm_ya"] = 0
config["misc_vm_r"] = 0

config["config_name"] = nil

config.colors["esp_player_box"] = "255 255 255 255"
config.colors["esp_player_name"] = "255 255 255 255"
config.colors["esp_player_hp"] = "0 255 0 255"
config.colors["esp_player_armor"] = "66 138 245 255"
config.colors["esp_player_weapon"] = "255 255 255 255"
config.colors["esp_player_rank"] = "255 0 0 255"
config.colors["esp_player_skeleton"] = "255 255 255 255"
config.colors["esp_player_snaplines"] = "255 255 255 255"
config.colors["esp_player_glow"] = "0 140 255 255"
config.colors["esp_player_chams"] = "30 111 146 255"
config.colors["esp_player_chams_overlay"] = "255 255 255 255"
config.colors["esp_player_chams_xyz"] = "0 63 160 63"
config.colors["esp_player_highlight_box"] = "0 255 0 255"
config.colors["esp_player_highlight_name"] = "0 255 0 255"
config.colors["esp_other_fog"] = "118 144 184 255"
config.colors["esp_other_worldmod"] = "255 255 255 255"
config.colors["esp_other_propmod"] = "255 255 255 255"
config.colors["esp_other_drawfov"] = "255 255 255 255"
config.colors["esp_entity_box"] = "255 255 255 255"
config.colors["esp_entity_name"] = "255 255 255 255"

config.keybinds["aim_onkey_key"] = 0
config.keybinds["trigger_onkey_key"] = 0
config.keybinds["menu_key"] = 72
config.keybinds["logger_key"] = 0
config.keybinds["panic_key"] = 0
config.keybinds["thirdperson_key"] = 0
config.keybinds["freecam_key"] = 0

config["friends"] = {}
config["entities"] = {}

local hooks = {}

local verifyconfig = config

local frame, frameX, frameY, sheet, colorWindow, teamList, teamFilter, teamFilterWasOpen, teamFilterEnable, teamFilterX, teamFilterY, pList, pListWasOpen, entityFrame, entityFrameX, entityFrameY, entityFrameWasOpen, cfgDropdown, chamFrame, chamFrameX, chamFrameY, chamFrameWasOpen
local activeTab
local ss = false
local loadedCfg = {}
local editingText = false
local observingPlayers = {}
observingPlayers.watcher = {}
observingPlayers.spec = {}
local onlineStaff = {}
local staffRanks = {"tmod", "trialmod", "trialmoderator", "tmoderator", "mod", "moderator", "smod", "smoderator", "seniormod", "seniormoderator", "jadmin", "junioradmin", "leadadmin", "headadmin", "trialadmin", "sadmin", "senioradmin", "owner", "developer", "manager", "staff"}
local files, dir = file.Find( "timeshack/*.json", "DATA" )
local frametime, deviation = engine.ServerFrameTime()
local intp, toggledelay3, toggledelayN = false, false, false
local NoclipPos, NoclipAngles, NoclipOn, NoclipX, NoclipY, NoclipDuck, NoclipJump = LocalPlayer():EyePos(), LocalPlayer():GetAngles(), false, 0, 0, false, false

CreateMaterial("textured", "VertexLitGeneric")
CreateMaterial("flat", "UnLitGeneric")
CreateMaterial("wireframe", "VertexLitGeneric", {
	["$wireframe"] = 1
})

local ChamMaterials = {
	["Platinum"] = "models/player/shared/ice_player",
	["Gold"] = "models/player/shared/gold_player",
	["Alien"] = "models/XQM/LightLinesRed_tool",
	["Flesh"] = "models/flesh",
	["Molten"] = "models/props_lab/Tank_Glass001",
	["Glass"] = "models/props_combine/com_shield001a",
	["Plasma"] = "models/props_combine/portalball001_sheet",
	["Water"] = "models/props_combine/stasisshield_sheet",
	["Fire"] = "models/shadertest/shader4",
	["Glow"] = "Models/effects/splodearc_sheet", -- LOOK AT OVERLAY
	["Reactor"] = "Models/effects/comball_tape",
	["Galaxy"] = "Models/effects/comball_sphere",
	["Water 2"] = "models/shadertest/shader3",
	["Chrome"] = "debug/env_cubemap_model",
	["Untextured"] = "1",
	["Wireframe"] = "!wireframe",
	["Flat"] = "!flat",
	["Textured"] = "!textured"
}

--=================== Misc Functions ================

local function RandomString() return tostring(math.random(-9999999999, 9999999999)) end

local cObs, cStaff = RandomString(), RandomString()

local function DisableWorldModulation()

	for k, v in pairs( Entity( 0 ):GetMaterials() ) do
   		Material( v ):SetVector( "$color", Vector(1, 1, 1) )
   		Material( v ):SetFloat( "$alpha", 1 )
	end

end

local function DisablePropModulation()

	for k, v in pairs(ents.FindByClass("prop_physics")) do
		v:SetColor(Color(255, 255, 255, 255))
		v:SetRenderMode( RENDERMODE_NORMAL )
	end

end

local function UpdateVisibleChamMaterial(cvar, old, new)
	if table.HasValue(ChamMaterials, new) then
		config["esp_player_chams_material"] = new
	end
end

local function UpdateOverlayChamMaterial(cvar, old, new)
	if table.HasValue(ChamMaterials, new) then
		config["esp_player_overlay_chams_material"] = new
	end
end

local function UpdateInvisibleChamMaterial(cvar, old, new)
	if table.HasValue(ChamMaterials, new) then
		config["esp_player_xyz_chams_material"] = new
	end
end

CreateClientConVar("th_setmat", "!textured")
cvars.AddChangeCallback("th_setmat", UpdateVisibleChamMaterial, "update_chams")
CreateClientConVar("th_setoverlaymat", "!textured")
cvars.AddChangeCallback("th_setoverlaymat", UpdateOverlayChamMaterial, "update_chams_overlay")
CreateClientConVar("th_setxyzmat", "!textured")
cvars.AddChangeCallback("th_setxyzmat", UpdateInvisibleChamMaterial, "update_chams_xyz")

local function AddHook(event, name, func)
	hooks[name] = event
	hook.Add(event, name, func)
end

local function VerifyConfig()
	for k, v in pairs(verifyconfig) do
		if config[k] == nil then
			config[k] = verifyconfig[k]
			MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "The config value ", Color(255, 0, 0), k, Color(222, 222, 222), " was nil. To prevent errors in the cheat it has been set to the default value automatically. Please make sure to save your config with your desired settings to prevent this in the future.")
		end
	end
	for k, v in pairs(verifyconfig.colors) do
		if config.colors[k] == nil then
			if k == "config_name" then return end
			config.colors[k] = verifyconfig.colors[k]
			MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "The colour config value ", Color(255, 0, 0), k, Color(222, 222, 222), " was nil. To prevent errors in the cheat it has been set to the default value automatically. Please make sure to save your config with your desired settings to prevent this in the future.")
		end
	end
	for k, v in pairs(verifyconfig.keybinds) do
		if config.keybinds[k] == nil then
			config.keybinds[k] = verifyconfig.keybinds[k]
			MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "The keybind config value ", Color(255, 0, 0), k, Color(222, 222, 222), " was nil. To prevent errors in the cheat it has been set to the default value automatically. Please make sure to save your config with your desired settings to prevent this in the future.")
		end
	end
end

local function GetENTPos ( Ent )
	if Ent:IsValid() then 
		local Points = {
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z )
		}
		local MaxX, MaxY, MinX, MinY
		local V1, V2, V3, V4, V5, V6, V7, V8
		local isVis
		for k, v in pairs( Points ) do
			local ScreenPos = Ent:LocalToWorld( v ):ToScreen()
			isVis = ScreenPos.visible
			if MaxX != nil then
				MaxX, MaxY, MinX, MinY = math.max( MaxX, ScreenPos.x ), math.max( MaxY, ScreenPos.y), math.min( MinX, ScreenPos.x ), math.min( MinY, ScreenPos.y)
			else
				MaxX, MaxY, MinX, MinY = ScreenPos.x, ScreenPos.y, ScreenPos.x, ScreenPos.y
			end

			if V1 == nil then
				V1 = ScreenPos
			elseif V2 == nil then
				V2 = ScreenPos
			elseif V3 == nil then
				V3 = ScreenPos
			elseif V4 == nil then
				V4 = ScreenPos
			elseif V5 == nil then
				V5 = ScreenPos
			elseif V6 == nil then
				V6 = ScreenPos
			elseif V7 == nil then
				V7 = ScreenPos
			elseif V8 == nil then
				V8 = ScreenPos
			end
		end
		return MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8, isVis
	end
end

local fakeRT = GetRenderTarget( "fakeRT" .. os.time(), ScrW(), ScrH() )
 
AddHook("RenderScene", RandomString(), function( vOrigin, vAngle, vFOV )
	if ( !gui.IsConsoleVisible() && !gui.IsGameUIVisible() ) || ss then
	    local view = {
	        x = 0,
	        y = 0,
	        w = ScrW(),
	        h = ScrH(),
	        dopostprocess = true,
	        origin = vOrigin,
	        angles = vAngle,
	        fov = vFOV,
	        drawhud = true,
	        drawmonitors = true,
	        drawviewmodel = true
	    }
	 
	    render.RenderView( view )
	    render.CopyTexture( nil, fakeRT )
	 
	    cam.Start2D()
	        hook.Run( "CheatHUDPaint" )
	    cam.End2D()

	    render.SetRenderTarget( fakeRT )
	 
	    return true
	end
end )
 
AddHook("ShutDown", RandomString(), function()
    render.SetRenderTarget()
end )

local renderv = render.RenderView
local renderc = render.Clear
local rendercap = render.Capture
local rendercappix = render.CapturePixels
local vguiworldpanel = vgui.GetWorldPanel
render.CapturePixels = function() return end
 
local function screengrab()
	if ss then return end
	ss = true
 
	renderc( 0, 0, 0, 255, true, true )
	renderv( {
		origin = LocalPlayer():EyePos(),
		angles = LocalPlayer():EyeAngles(),
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH(),
		dopostprocess = true,
		drawhud = true,
		drawmonitors = true,
		drawviewmodel = true
	} )
 
	local vguishits = vguiworldpanel()
 
	if IsValid( vguishits ) then
		vguishits:SetPaintedManually( true )
	end
 
	timer.Simple( 0.1, function()
		vguiworldpanel():SetPaintedManually( false )
		ss = false
	end)
end
 
render.Capture = function(data)
	screengrab()
	local cap = rendercap( data )
	return cap
end

local function ValidateESP(ply)
	if ply:IsBot() or ply:IsPlayer() then
		local IsDormant = false
		if config["esp_player_dormant"] then
			IsDormant = ply:IsDormant()
		end
		if ( IsValid(ply) && ply != LocalPlayer() && ply:Alive() && ply:GetPos():Distance(LocalPlayer():GetPos()) <= config["esp_player_render_distance"] && !IsDormant ) then
			if !table.IsEmpty(teamFilterSelected) && config["esp_player_filter"] then
				for k, v in pairs(teamFilterSelected) do
					if team.GetName(ply:Team()) == v then
						return true
					end
				end
			else
				return true
			end
		else
			return false
		end
	end
end

local function ValidateAimbot(ply)
	if ply:IsBot() or ply:IsPlayer() then
		if config["aim_ignorefriends"] then
			if table.HasValue(config["friends"], ply:SteamID()) then
				return false
			end
		end
		if ( IsValid(ply) && ply != LocalPlayer() && ply:Alive() && ply:Team() != TEAM_SPECTATOR && !ply:IsDormant() && ply:GetPos():Distance(LocalPlayer():GetPos()) <= config["esp_player_render_distance"] ) then
			if !table.IsEmpty(teamFilterSelected) && config["esp_player_filter"] then
				for k, v in pairs(teamFilterSelected) do
					if team.GetName(ply:Team()) == v then
						return true
					end
				end
			else
				return true
			end
		else
			return false
		end
	end
end

local playerTable = {}

AddHook("Think", RandomString(), function()
	for k, v in pairs(player.GetAll()) do
		if ValidateESP(v) && !table.HasValue(playerTable, v) then
			table.insert(playerTable, v)
		elseif !ValidateESP(v) && table.HasValue(playerTable, v) then
			table.RemoveByValue(playerTable, v)
		end
	end
end)

local function CloseFrame()
	frameX, frameY = frame:GetPos()
	RememberCursorPosition()
	frame:Remove()
	frame = false
end

local function SaveConfig()

	if cfgDropdown:GetSelected() == nil then return end
	
	local cfg = cfgDropdown:GetSelected()
	local JSONconfig = util.TableToJSON(config, true)
	file.Write("timeshack/"..cfg, JSONconfig)

	MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "Saved Config - ", Color(255, 0, 0), cfg, "\n")

end

local function LoadDefault()

	local JSONconfig = file.Read("timeshack/default.json", "DATA")
	config = util.JSONToTable(JSONconfig)

	VerifyConfig()

	loadedCfg[0] = "default.json"
	for k, v in ipairs(files) do
		if v == "default.json" then
			loadedCfg[1] = k
		end
	end

	MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "Loaded Default Config\n")

end

local function LoadConfig()

	if cfgDropdown:GetSelected() == nil then return end

	local cfg = cfgDropdown:GetSelected()
	local JSONconfig = file.Read("timeshack/"..cfg, "DATA")
	config = util.JSONToTable(JSONconfig)

	VerifyConfig()

	loadedCfg[0] = cfg
	for k, v in ipairs(files) do
		if v == cfg then
			loadedCfg[1] = k
		end
	end

	MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "Loaded Config - ", Color(255, 0, 0), cfg, "\n")

	CloseFrame()
	CreateTimeGUI()

end


local function CreateConfig()

	if config["config_name"] == nil then return end
	
	if file.Exists("timeshack/"..config["config_name"]..".json", "DATA") then return end

	local JSONconfig = util.TableToJSON(config, true)
	file.CreateDir("timeshack")
	file.Write("timeshack/"..config["config_name"]..".json", JSONconfig)

	MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "Created Config - ", Color(255, 0, 0), config["config_name"], "\n")

	CloseFrame()
	CreateTimeGUI()

end


local function DeleteConfig()

	if cfgDropdown:GetSelected() == nil then return end
	
	local cfg = cfgDropdown:GetSelected()
	file.Delete("timeshack/"..cfg)

	loadedCfg = {}

	MsgC(Color(61, 149, 217), "\n[Nekowa.re] ", Color(222, 222, 222), "Deleted Config - ", Color(255, 0, 0), cfg, "\n")

	CloseFrame()
	CreateTimeGUI()

end

for k, v in ipairs(files) do
	if string.lower(v) == "default.json" then
		LoadDefault()
	end
end

local function Unload()
	if frame then
		frame:Remove()
	end
	if teamFilter then
		teamFilter:Remove()
	end
	if colorWindow then
		colorWindow:Remove()
	end
	if pList then
		pList:Remove()
	end
	if entityFrame then
		entityFrame:Remove()
	end
	if chamFrame then
		chamFrame:Remove()
	end
	for k, v in pairs(hooks) do
		hook.Remove(v, k)
	end
	timer.Remove(cObs)
	timer.Remove(cStaff)
	for k, v in pairs(player.GetAll()) do
		v:SetRenderMode(0)
	end
	DisableWorldModulation()
	DisablePropModulation()
	cvars.RemoveChangeCallback("th_setmat", "update_chams")
	cvars.RemoveChangeCallback("th_setxyzmat", "update_chams_xyz")
	cvars.RemoveChangeCallback("th_setoverlaymat", "update_chams_overlay")
	print("Unloaded the cheat.")
end

local function CheckObservers()

	if !config["misc_observerlist"] then return end

	observingPlayers = {}
	observingPlayers.watcher = {}
	observingPlayers.spec = {}

	for k, v in pairs(player.GetAll()) do
	    if v:IsValid() and v != LocalPlayer() then
	        local Trace = {}
	        Trace.start  = LocalPlayer():EyePos() + Vector(0, 0, 32)
	        Trace.endpos = v:EyePos() + Vector(0, 0, 32)
	        Trace.filter = {v, LocalPlayer()}
	        TraceRes = util.TraceLine(Trace)
	        if !TraceRes.Hit then
	            if (v:EyeAngles():Forward():Dot((LocalPlayer():EyePos() - v:EyePos())) > math.cos(math.rad(45))) then
	                if !table.HasValue(observingPlayers.watcher, v) then table.insert(observingPlayers.watcher, v ) end
	            end
	        end
	    end
	    if v:GetObserverTarget() == LocalPlayer() then
	    	if !table.HasValue(observingPlayers.spec, v) then table.insert(observingPlayers.spec, v) end
	    end
	end
end

timer.Create(cObs, 0.5, 0, CheckObservers)

local function UpdateOnlineStaff()
	onlineStaff = {}
	for k, v in ipairs(player.GetAll()) do
		if v:IsValid() && v:IsSuperAdmin() then
			if !table.HasValue(onlineStaff, v) then
				table.insert(onlineStaff, v)
			end
		elseif v:IsValid() && v:IsAdmin() then
			if !table.HasValue(onlineStaff, v) then
				table.insert(onlineStaff, v)
			end
		elseif v:IsValid() && table.HasValue(staffRanks, v:GetUserGroup()) then
			if !table.HasValue(onlineStaff, v) then
				table.insert(onlineStaff, v)
			end
		end
	end
end

timer.Create(cStaff, 5, 0, UpdateOnlineStaff)

--=================== GUI Item Functions ================

local function CreateCheckBox(lbl, x, y, cfg, col, par)

	local checkBox = vgui.Create("DCheckBoxLabel", par)
	checkBox:SetText(lbl)
	checkBox:SetPos(x, y)
	checkBox:SetValue( config[cfg] )
	function checkBox:OnChange( bVal )
		config[cfg] = bVal
	end
	
	if col then
		local cx, cy = checkBox:GetPos()
		local colorPicker = vgui.Create("DImageButton", par)
		colorPicker:SetImage("icon16/color_wheel.png")
		colorPicker:SetSize(16, 16)
		colorPicker:SetPos(cx + checkBox:GetWide() + 5, y - 1)
		function colorPicker:DoClick()

			if IsValid(colorWindow) then
				colorWindow:Remove()
			end
			colorWindow = vgui.Create("DFrame")
			colorWindow:SetSize(300, 225)
			colorWindow:SetTitle(lbl.." - Color Picker")
			local frameX, frameY = frame:GetPos()
			if frameX + 350 > ScrW() then
				colorWindow:Center()
			else
				colorWindow:SetPos(frameX + 350, frameY)
			end
			colorWindow:MakePopup()

			local colorSelector = vgui.Create("DColorMixer", colorWindow)
			colorSelector:Dock(FILL)
			colorSelector:DockPadding(5, 5, 5, 5)
			colorSelector:SetPalette(false)
			colorSelector:SetColor(string.ToColor(config.colors[cfg]))
			function colorSelector:ValueChanged(val)
				local r = tostring(val.r)
				local g = tostring(val.g)
				local b = tostring(val.b)
				local a = tostring(val.a)
				local col = r.." "..g.." "..b.." "..a
				config.colors[cfg] = col
			end
		end
	end
end

local function CreateLabel(lbl, x, y, par)

	local label = vgui.Create("DLabel", par)
	label:SetText(lbl)
	local w, h = label:GetTextSize()
	label:SetSize(w, h)
	label:SetPos(x, y)

end

local function CreateSlider(lbl, x, y, cfg, min, max, dec, par)

	local sliderLabel = vgui.Create("DLabel", par)
	sliderLabel:SetText(lbl)
	local w, h = sliderLabel:GetTextSize()
	sliderLabel:SetWide(w)
	sliderLabel:SetPos(x, y - h / 8)

	local slider = vgui.Create("DNumSlider", par)
	slider:SetWide(490)
	slider:SetPos(x - 210, y + 10)
	slider:SetMin(min)
	slider:SetMax(max)
	slider:SetTooltip(lbl)
	slider:SetDefaultValue(config[cfg])
	slider:ResetToDefaultValue()
	slider:SetDecimals(dec)
	function slider:OnValueChanged()
		config[cfg] = slider:GetValue()
	end

end

local function CreateDropdown(lbl, x, y, choices, cfg, par)

	local dropdownLabel = vgui.Create("DLabel", par)
	dropdownLabel:SetText(lbl)
	local w, h = dropdownLabel:GetTextSize()
	dropdownLabel:SetWide(w)
	dropdownLabel:SetPos(x, y - h / 8)

	local dropdown = vgui.Create("DComboBox", par)
	dropdown:SetSize(200, 20)
	dropdown:SetPos(x, y + 20)
	for k, v in ipairs(choices) do
		dropdown:AddChoice(v)
	end
	dropdown:SetSortItems(false)
	dropdown:ChooseOptionID(config[cfg])
	function dropdown:OnSelect(index, value, data)
		config[cfg] = index
	end
end

local function CreateKeybind(x, y, cfg, par)

	local keyBind = vgui.Create("DBinder", par)
	keyBind:SetValue(config.keybinds[cfg])
 	keyBind:SetSize(80, 16)
 	keyBind:SetPos(x, y)
 	keyBind.OnChange = function()
 		config.keybinds[cfg] = keyBind:GetValue()
 	end
end

local function CreateButton(lbl, tooltip, fnc, x, y, par)

	local button = vgui.Create("DButton", par)
	button:SetSize(150, 20)
	button:SetPos(x, y)
	button:SetText(lbl)
	button:SetTooltip(tooltip)
	function button:DoClick()
		fnc()
	end
end

local function CreateTextInput(lbl, cfg, x, y, chars, par)

	textInput = vgui.Create("DTextEntry", par)
	textInput:SetSize(200, 20)
	textInput:SetPos(x, y)
	textInput:IsMultiline( false )
	textInput:SetMaximumCharCount(chars)
	textInput:SetPlaceholderText(lbl)
	textInput.Think = function()
		if textInput:IsEditing() then
			editingText	= true
		else
			editingText = false
		end
		config[cfg] = textInput:GetValue()
	end 
end

local function CreateFilterPanel()

	if !teamFilter then

		teamFilter = vgui.Create("DFrame")
		teamFilter:SetSize(300, 200)
		teamFilter:SetTitle("Filter By Teams")
		if teamFilterX == nil or teamFilterY == nil then
			teamFilter:Center()
		else
			teamFilter:SetPos(teamFilterX, teamFilterY)
		end
		teamFilter:MakePopup()
		function teamFilter:OnClose()
			teamFilterX, teamFilterY = teamFilter:GetPos()
			teamFilter = false
			config["esp_player_filter"] = teamFilterEnable:GetChecked()
			for k, v in pairs(teamList:GetSelected()) do
				if !table.HasValue(teamFilterSelected, v:GetValue(1)) then
					table.insert(teamFilterSelected, v:GetValue(1))
				end
			end
		end

		teamFilterEnable = vgui.Create("DCheckBoxLabel", teamFilter)
		teamFilterEnable:Dock(TOP)
		teamFilterEnable:DockMargin(10, 10, 10, 0)
		teamFilterEnable:SetText("Enable Team Based Filtering")
		if config["esp_player_filtering"] then
			teamFilterEnable:SetValue( true )
		end
		function teamFilterEnable:OnChange(bval)
			config["esp_player_filtering"] = bval
		end

		teamList = vgui.Create("DListView", teamFilter)
		teamList:Dock(FILL)
		teamList:DockMargin(10, 10, 10, 10)
		teamList:SetMultiSelect(true)
		teamList:AddColumn("Teams")
		teamList:SetSortable(true)

		for k, v in pairs(team.GetAllTeams()) do
			if !( team.GetName(k) == team.GetName(TEAM_CONNECTING) ) then
				teamList:AddLine(team.GetName(k))
			end
		end
		if !table.IsEmpty(teamFilterSelected) then
			for k, v in pairs(teamFilterSelected) do
				for i, line in ipairs(teamList:GetLines()) do
					if line:GetValue(1) == v then
						teamList:SelectItem(line)
						break
					end
				end
			end
		end
		teamFilterSelected = {}
	end
end

local function CreatePlayerList()

	if !pList then

		pList = vgui.Create("DFrame")
		pList:SetSize(475, 200)
		local frameW, frameH = frame:GetPos()
		if frameW - 50 < 0 then
			pList:Center()
		else
			pList:SetPos(frameW - 525, frameH)
		end
		pList:SetTitle("Players List")
		pList:MakePopup()
		function pList:OnClose()
			pList = false
		end

		local dlist = vgui.Create("DListView", pList)
		dlist:DockMargin(0, 0, 150, 0)
		dlist:Dock(FILL)
		dlist:SetMultiSelect(false)
		dlist:AddColumn("Name")
		dlist:AddColumn("Steam ID")
		dlist:AddColumn("Rank")

		for k, v in ipairs(player.GetAll()) do
			if v != LocalPlayer() then
				dlist:AddLine(v:Name(), v:SteamID(), v:GetUserGroup())
			end
		end

		local profile = vgui.Create("DButton", pList)
		profile:SetSize(130, 20)
		profile:SetPos(335, 29)
		profile:SetText("Open Profile")
		profile:SetTooltip("Opens the selected players steam profile.")
		function profile:DoClick()
			if dlist:GetSelectedLine() != nil then
				local _, line = dlist:GetSelectedLine()
				player.GetBySteamID(line:GetColumnText(2)):ShowProfile()
			end
		end

		local steamid = vgui.Create("DButton", pList)
		steamid:SetSize(130, 20)
		steamid:SetPos(335, 54)
		steamid:SetText("Copy SteamID")
		steamid:SetTooltip("Copies the selected players SteamID.")
		function steamid:DoClick()
			if dlist:GetSelectedLine() != nil then
				local _, line = dlist:GetSelectedLine()
				SetClipboardText(line:GetColumnText(2))
				chat.AddText(Color(61, 149, 217), "[Nekowa.re] ", Color(222, 222, 222), "SteamID copied to clipboard.")
			end
		end

		local friend = vgui.Create("DCheckBoxLabel", pList)
		friend:SetText("Friend")
		friend:SetPos(335, 79)
		friend:SetValue( false )
		function friend:OnChange( bVal )
			if dlist:GetSelectedLine() != nil then
				local _, line = dlist:GetSelectedLine()
				if bVal then
					if table.HasValue(config["friends"], line:GetColumnText(2)) then return
					else table.insert(config["friends"], line:GetColumnText(2)) end
				else
					if table.HasValue(config["friends"], line:GetColumnText(2)) then
						table.RemoveByValue(config["friends"], line:GetColumnText(2))
					end
				end
			end
		end

		function dlist:OnRowSelected(ind, line)
			if table.HasValue(config["friends"], line:GetColumnText(2)) then
				friend:SetValue(true)
			else
				friend:SetValue(false)
			end
		end
	end
end

local function CreateEntityList()

	if !entityFrame then

		entityFrame = vgui.Create("DFrame")
		entityFrame:SetSize(400, 200)
		entityFrame:SetTitle("Entity ESP")
		if entityFrameX == nil or entityFrameY == nil then
			entityFrame:Center()
		else
			entityFrame:SetPos(entityFrameX, entityFrameY) 
		end
		entityFrame:MakePopup()
		function entityFrame:OnClose()
			entityFrameX, entityFrameY = entityFrame:GetPos()
			entityFrame = false
		end

		local entList = vgui.Create("DListView", entityFrame)
		entList:DockMargin(0, 0, 100, 0)
		entList:Dock(FILL)
		entList:SetMultiSelect(false)
		entList:AddColumn("Entities")

		for k, v in ipairs(ents.GetAll()) do
			local good = true
			for k, line in ipairs( entList:GetLines() ) do
    			if line:GetValue( 1 ) == v:GetClass() then good = false break end
			end
			if v:GetClass() != "worldspawn" && v:GetClass() != "player" && v:GetOwner() != LocalPlayer() && good then
				entList:AddLine(v:GetClass())
			end
		end

		local enable = vgui.Create("DCheckBoxLabel", entityFrame)
		enable:SetText("Enable ESP")
		enable:SetPos(305, 30)
		enable:SetValue( false )
		function enable:OnChange( bVal )
			if entList:GetSelectedLine() != nil then
				local _, line = entList:GetSelectedLine()
				if bVal then
					if table.HasValue(config["entities"], line:GetColumnText(1)) then return
					else table.insert(config["entities"], line:GetColumnText(1)) end
				else
					if table.HasValue(config["entities"], line:GetColumnText(1)) then
						table.RemoveByValue(config["entities"], line:GetColumnText(1))
					end
				end
			end
		end

		CreateCheckBox("Box ESP", 305, 50, "esp_entity_box", true, entityFrame)
		CreateCheckBox("Name ESP", 305, 70, "esp_entity_name", true, entityFrame)

		function entList:OnRowSelected(ind, line)
			if table.HasValue(config["entities"], line:GetColumnText(1)) then
				enable:SetValue(true)
			else
				enable:SetValue(false)
			end
			
		end
	end
end

local function CreateMaterialList()

	if !chamFrame then

		chamFrame = vgui.Create("DFrame")
		chamFrame:SetSize(400, 425)
		chamFrame:SetTitle("Cham Materials")
		if chamFrameX == nil or chamFrameY == nil then
			chamFrame:Center()
		else
			chamFrame:SetPos(chamFrameX, chamFrameY) 
		end
		chamFrame:MakePopup()
		function chamFrame:OnClose()
			chamFrameX, chamFrameY = chamFrame:GetPos()
			chamFrame = false
		end

		local sPanel = vgui.Create("DScrollPanel", chamFrame)
		sPanel:Dock(FILL)

		local visChams = vgui.Create("ControlPanel", sPanel)
		visChams:Dock(TOP)
		visChams:SetName("Visible Chams")
		visChams:MatSelect("th_setmat", ChamMaterials, true, 50, 50)

		local overlayChams = vgui.Create("ControlPanel", sPanel)
		overlayChams:Dock(TOP)
		overlayChams:SetName("Overlay Chams")
		overlayChams:MatSelect("th_setoverlaymat", ChamMaterials, true, 50, 50)

		local invisChams = vgui.Create("ControlPanel", sPanel)
		invisChams:Dock(TOP)
		invisChams:SetName("Invisible Chams")
		invisChams:MatSelect("th_setxyzmat", ChamMaterials, true, 50, 50)

	end
end

--=================== Create GUI ================

function CreateTimeGUI()

	files, dir = file.Find( "timeshack/*.json", "DATA" )

	frame = vgui.Create("DFrame")
	frame:SetSize(320, 400)
	if frameX == nil or frameY == nil then
		frame:Center()
	else
		frame:SetPos(frameX, frameY)
	end
	frame:SetTitle("Nekowa.re")
	frame:MakePopup()
	frame:ShowCloseButton(false)

	sheet = vgui.Create("DPropertySheet", frame)
	sheet:Dock(FILL)

	local aim = vgui.Create("DScrollPanel", sheet)
	local aimsbar = aim:GetVBar()
	function aimsbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function aimsbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function aimsbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function aimsbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	sheet:AddSheet("Aimbot", aim, "icon16/bomb.png")

	local visplayer = vgui.Create("DScrollPanel", sheet)
	local playerbar = visplayer:GetVBar()
	function playerbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function playerbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function playerbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function playerbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	sheet:AddSheet("Player", visplayer, "icon16/user.png")

	local visother = vgui.Create("DScrollPanel", sheet)
	local otherbar = visother:GetVBar()
	function otherbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function otherbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function otherbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function otherbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	sheet:AddSheet("Other", visother, "icon16/world.png")

	local misc = vgui.Create("DScrollPanel", sheet)
	local miscbar = misc:GetVBar()
	function miscbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function miscbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function miscbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function miscbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	sheet:AddSheet("Misc", misc, "icon16/cog.png")

	local config = vgui.Create("DScrollPanel", sheet)
	local configbar = config:GetVBar()
	function configbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function configbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function configbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function configbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	sheet:AddSheet("Config", config, "icon16/database.png")
	sheet:SwitchToName(activeTab)
	for k, v in pairs(sheet:GetItems()) do
		function v.Tab:OnDepressed()
			activeTab = v.Name
		end
	end

	CreateCheckBox("Enable Aimbot", 10, 10, "aim_master_toggle", false, aim)
	CreateCheckBox("Aimbot On Key", 10, 30, "aim_onkey", false, aim)
	CreateKeybind(110, 30, "aim_onkey_key", aim)
	CreateCheckBox("No-Recoil", 10, 50, "aim_norecoil", false, aim)
	CreateCheckBox("Silent Aim (Unsafe)", 10, 70, "aim_silent", false, aim)
	CreateDropdown("Target Selection", 10, 90, {"Crosshair", "Closest Distance", "Lowest Health"}, "aim_target", aim)
	CreateDropdown("Hitbox Selection", 10, 130, {"Hitscan", "Head", "Body"}, "aim_hitbox", aim)
	CreateSlider("Aimbot FOV", 10, 180, "aim_fov", 0, 180, 0, aim)
	CreateCheckBox("Aimbot Smoothing", 10, 222, "aim_smoothing", false, aim)
	CreateSlider("Smoothing Scale", 10, 240, "aim_smoothing_value", 0, 2, 2, aim)
	CreateCheckBox("Ignore Friends", 10, 280, "aim_ignorefriends", false, aim)
	CreateCheckBox("Ignore Staff", 10, 300, "aim_ignoreadmins", false, aim)
	CreateCheckBox("Ignore Noclipping", 10, 320, "aim_ignorenoclip", false, aim)
	CreateCheckBox("Ignore Same Team", 10, 340, "aim_ignoreteam", false, aim)
	CreateCheckBox("Ignore Non-Visible", 10, 360, "aim_ignoreinvis", false, aim)

	CreateCheckBox("Enable Triggerbot", 10, 400, "trigger_master_toggle", false, aim)
	CreateCheckBox("Triggerbot On Key", 10, 420, "trigger_onkey", false, aim)
	CreateKeybind(130, 420, "trigger_onkey_key", aim)

	CreateCheckBox("Box ESP", 10, 10, "esp_player_box", true, visplayer)
	CreateCheckBox("Name ESP", 10, 30, "esp_player_name", true, visplayer)
	CreateCheckBox("HP ESP", 10, 50, "esp_player_hp", true, visplayer)
	CreateCheckBox("Armor ESP", 10, 70, "esp_player_armor", true, visplayer)
	CreateCheckBox("Weapon ESP", 10, 90, "esp_player_weapon", true, visplayer)
	CreateCheckBox("Rank ESP", 10, 110, "esp_player_rank", true, visplayer)
	CreateCheckBox("Team ESP", 10, 130, "esp_player_team", false, visplayer)
	CreateCheckBox("Skeleton ESP", 10, 150, "esp_player_skeleton", true, visplayer)
	CreateCheckBox("Snaplines", 10, 170, "esp_player_snaplines", true, visplayer)
	CreateCheckBox("Glow ESP", 10, 190, "esp_player_glow", true, visplayer)
	CreateCheckBox("Player Chams", 10, 210, "esp_player_chams", true, visplayer)
	CreateCheckBox("Player Chams Overlay", 10, 230, "esp_player_chams_overlay", true, visplayer)
	CreateCheckBox("Player Chams XYZ", 10, 250, "esp_player_chams_xyz", true, visplayer)
	CreateButton("Cham Material", "Opens the cham material selector.", CreateMaterialList, 10, 270, visplayer)
	CreateSlider("ESP Max Render Distance", 10, 290, "esp_player_render_distance", 500, 10000, 0, visplayer)
	CreateCheckBox("Hide Dormant Players", 10, 330, "esp_player_dormant", false, visplayer)
	CreateCheckBox("Highlight Friends Box", 10, 350, "esp_player_highlight_box", true, visplayer)
	CreateCheckBox("Highlight Friends Name", 10, 370, "esp_player_highlight_name", true, visplayer)

	CreateCheckBox("Fog Modulation", 10, 10, "esp_other_fog", true, visother)
	CreateSlider("Fog Start", 10, 30, "esp_other_fog_start", 0, 50000, 0, visother)
	CreateSlider("Fog End", 10, 70, "esp_other_fog_end", 0, 50000, 0, visother)
	CreateSlider("Fog Density", 10, 110, "esp_other_fog_density", 0, 1, 1, visother)
	CreateCheckBox("World Modulation", 10, 150, "esp_other_worldmod", true, visother)
	CreateCheckBox("Prop Modulation", 10, 170, "esp_other_propmod", true, visother)
	CreateCheckBox("Remove Skybox", 10, 190, "esp_other_nosky", false, visother)
	CreateCheckBox("Nightmode", 10, 210, "esp_other_nightmode", false, visother)
	CreateSlider("Nightmode Scale", 10, 230, "esp_other_nightmode_scale", 0, 1, 1, visother)
	CreateCheckBox("Hitsound", 10, 270, "esp_other_hitsound", false, visother)
	CreateCheckBox("Draw Aimbot FOV", 10, 290, "esp_other_drawfov", true, visother)
	CreateCheckBox("Fullbright", 10, 310, "esp_other_fullbright", false, visother)
	CreateCheckBox("Thirdperson", 10, 330, "esp_other_thirdperson", false, visother)
	CreateKeybind(100, 330, "thirdperson_key", visother)
	CreateSlider("Thirdperson Distance", 10, 350, "esp_other_thirdperson_distance", 5, 50, 0, visother)
	CreateCheckBox("Freecam", 10, 390, "esp_other_freecam", false, visother)
	CreateKeybind(100, 390, "freecam_key", visother)
	CreateSlider("Freecam Speed", 10, 410, "esp_other_freecam_speed", 1, 10, 0, visother)
	CreateButton("Entity List", "Open the entity list menu.", CreateEntityList, 10, 455, visother)

	CreateCheckBox("Auto Bunnyhop", 10, 10, "misc_autobunnyhop", false, misc)
	CreateCheckBox("Auto Strafe", 10, 30, "misc_autostrafe", false, misc)
	CreateCheckBox("Reveal TTT/Murder Info", 10, 50, "misc_ttt", false, misc)
	CreateCheckBox("Observer List", 10, 70, "misc_observerlist", false, misc)
	CreateCheckBox("Admin List", 10, 90, "misc_adminlist", false, misc)
	CreateCheckBox("Auto Click", 10, 110, "misc_autoclick", false, misc)
	CreateCheckBox("Rainbow Physgun", 10, 130, "misc_rainbow", false, misc)
	CreateSlider("Rainbow Speed", 10, 150, "misc_rainbow_speed", 1, 100, 0, misc)
	CreateButton("Player List", "Open the player list menu.", CreatePlayerList, 10, 190, misc)
	CreateButton("Filter Teams", "The filter will be applied when the filter menu is closed. This filter applies to ESP and Aimbot.", CreateFilterPanel, 10, 215, misc)
	CreateCheckBox("Viewmodel Changer", 10, 240, "misc_viewmodel", false, misc)
	CreateCheckBox("Remove Bob", 10, 260, "misc_bob", false, misc)
	CreateCheckBox("Remove Sway", 10, 280, "misc_sway", false, misc)
	CreateSlider("Viewmodel X", 10, 300, "misc_vm_x", -50, 50, 0, misc)
	CreateSlider("Viewmodel Y", 10, 340, "misc_vm_y", -30, 30, 0, misc)
	CreateSlider("Viewmodel Z", 10, 380, "misc_vm_z", -20, 20, 0, misc)
	CreateSlider("Viewmodel Pitch", 10, 420, "misc_vm_p", -90, 90, 0, misc)
	CreateSlider("Viewmodel Yaw", 10, 460, "misc_vm_ya", -90, 90, 0, misc)
	CreateSlider("Viewmodel Roll", 10, 500, "misc_vm_r", -90, 90, 0, misc)

	CreateLabel("Menu Keybind", 10, 10, config)
	CreateKeybind(10, 30, "menu_key", config)
	local usercfgs = {}
	cfgDropdown = vgui.Create("DComboBox", config)
	cfgDropdown:SetSize(200, 20)
	cfgDropdown:SetPos(10, 50)
	if loadedCfg[0] != nil then
		cfgDropdown:ChooseOption(loadedCfg[0], loadedCfg[1])
	end
	for k, v in ipairs(files) do
		cfgDropdown:AddChoice(v)
	end
	cfgDropdown:SetSortItems(false)

	CreateButton("Save Config", "Save Config.", SaveConfig, 10, 75, config)
	CreateButton("Load Config", "Load Config.", LoadConfig, 10, 100, config)
	CreateButton("Create Config", "Create Config.", CreateConfig, 10, 125, config)
	CreateButton("Delete Config", "Delete Config.", DeleteConfig, 10, 150, config)
	CreateTextInput("Config Name", "config_name", 10, 175, 16, config)
	CreateButton("Unload", "Fully unloads the cheat.", Unload, 10, 200, config)
	CreateLabel("Unload Key", 10, 225, config)
	CreateKeybind(10, 245, "panic_key", config)

	if teamFilterWasOpen then
		CreateFilterPanel()
		teamFilterWasOpen = false
	end
	if pListWasOpen then
		CreatePlayerList()
		pListWasOpen = false
	end
	if entityFrameWasOpen then
		CreateEntityList()
		entityFrameWasOpen = false
	end
	if chamFrameWasOpen then
		CreateMaterialList()
		chamFrameWasOpen = false
	end

end

-- ===================== GUI Logic

AddHook("Think", RandomString(), function()
    if config.keybinds["menu_key"] != 0 && input.IsKeyDown(config.keybinds["menu_key"]) && !insertdown && !config["menu_key"] then
		if teamFilter then
			teamFilterX, teamFilterY = teamFilter:GetPos()
			config["esp_player_filter"] = teamFilterEnable:GetChecked()
			for k, v in pairs(teamList:GetSelected()) do
				if !table.HasValue(teamFilterSelected, v:GetValue(1)) then
					table.insert(teamFilterSelected, v:GetValue(1))
				end
			end
			teamFilter:Remove()
			teamFilterWasOpen = true
			teamFilter = false
		end
		if entityFrame then
			entityFrameX, entityFrameY = entityFrame:GetPos()
			entityFrame:Remove()
			entityFrameWasOpen = true
			entityFrame = false
		end
		if chamFrame then
			chamFrameX, chamFrameY = chamFrame:GetPos()
			chamFrame:Remove()
			chamFrameWasOpen = true
			chamFrame = false
		end
		if colorWindow then
			colorWindow:Remove()
			colorWindow = false
		end
		if pList then
			pList:Remove()
			pListWasOpen = true
			pList = false
		end
		if frame then
			CloseFrame()
		else
			CreateTimeGUI()
			RestoreCursorPosition()
		end
    end
    if config.keybinds["logger_key"] != 0 && input.IsKeyDown(config.keybinds["logger_key"]) && !homedown && !config["logger_key"] then
		if !exploit_menu:IsVisible() then
			gui.EnableScreenClicker(true)
			RestoreCursorPosition()
			exploit_menu:MakePopup()
			exploit_menu:SetVisible(true)
		else
			RememberCursorPosition()
			gui.EnableScreenClicker(false)
			exploit_menu:Hide()
			exploit_menu:SetVisible(false)
		end
	end
	insertdown = input.IsKeyDown(config.keybinds["menu_key"])
	homedown = input.IsKeyDown(config.keybinds["logger_key"])
	panicdown = input.IsKeyDown(config.keybinds["panic_key"])
	if !panicdown && input.IsKeyDown(config.keybinds["panic_key"]) && config.keybinds["panic_key"] != 0 then
		Unload()
	end
end)

--===================================
--=================================== Visuals
--===================================
-- ======================= ESP

local bones = {
	{ S = "ValveBiped.Bip01_Head1", E = "ValveBiped.Bip01_Neck1" },
	{ S = "ValveBiped.Bip01_Neck1", E = "ValveBiped.Bip01_Spine4" },
	{ S = "ValveBiped.Bip01_Spine4", E = "ValveBiped.Bip01_Spine2" },
	{ S = "ValveBiped.Bip01_Spine2", E = "ValveBiped.Bip01_Spine1" },
	{ S = "ValveBiped.Bip01_Spine1", E = "ValveBiped.Bip01_Spine" },
	{ S = "ValveBiped.Bip01_Spine", E = "ValveBiped.Bip01_Pelvis" },
	{ S = "ValveBiped.Bip01_Spine2", E = "ValveBiped.Bip01_L_UpperArm" },
	{ S = "ValveBiped.Bip01_L_UpperArm", E = "ValveBiped.Bip01_L_Forearm" },
	{ S = "ValveBiped.Bip01_L_Forearm", E = "ValveBiped.Bip01_L_Hand" },
	{ S = "ValveBiped.Bip01_Spine2", E = "ValveBiped.Bip01_R_UpperArm" },
	{ S = "ValveBiped.Bip01_R_UpperArm", E = "ValveBiped.Bip01_R_Forearm" },
	{ S = "ValveBiped.Bip01_R_Forearm", E = "ValveBiped.Bip01_R_Hand" },
	{ S = "ValveBiped.Bip01_Pelvis", E = "ValveBiped.Bip01_L_Thigh" },
	{ S = "ValveBiped.Bip01_L_Thigh", E = "ValveBiped.Bip01_L_Calf" },
	{ S = "ValveBiped.Bip01_L_Calf", E = "ValveBiped.Bip01_L_Foot" },
	{ S = "ValveBiped.Bip01_L_Foot", E = "ValveBiped.Bip01_L_Toe0" },
	{ S = "ValveBiped.Bip01_Pelvis", E = "ValveBiped.Bip01_R_Thigh" },
	{ S = "ValveBiped.Bip01_R_Thigh", E = "ValveBiped.Bip01_R_Calf" },
	{ S = "ValveBiped.Bip01_R_Calf", E = "ValveBiped.Bip01_R_Foot" },
	{ S = "ValveBiped.Bip01_R_Foot", E = "ValveBiped.Bip01_R_Toe0" },
}

AddHook("CheatHUDPaint", RandomString(), function()
	if !ss then
		for k, v in ipairs(player.GetAll()) do
			if ValidateESP(v) then
				local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8, isVis = GetENTPos( v )
				if isVis then
					if config["esp_player_box"] then
						if config["esp_player_highlight_box"] then
							if table.HasValue(config["friends"], v:SteamID()) then
								surface.SetDrawColor(string.ToColor(config.colors["esp_player_highlight_box"]))
							else
								surface.SetDrawColor(string.ToColor(config.colors["esp_player_box"]))
							end
						else
							surface.SetDrawColor(string.ToColor(config.colors["esp_player_box"]))
						end
						surface.DrawLine( MaxX, MaxY, MinX, MaxY )
						surface.DrawLine( MaxX, MaxY, MaxX, MinY )
						surface.DrawLine( MinX, MinY, MaxX, MinY )
						surface.DrawLine( MinX, MinY, MinX, MaxY )
					end
					if config["esp_player_name"] then
						surface.SetFont("ESP_Font_Main")
						local w, h = surface.GetTextSize(v:Nick())
						local col
						if config["esp_player_highlight_name"] then
							if table.HasValue(config["friends"], v:SteamID()) then
								col = string.ToColor(config.colors["esp_player_highlight_name"])
							else
								col = string.ToColor(config.colors["esp_player_name"])
							end
						else
							col = string.ToColor(config.colors["esp_player_name"])
						end
						draw.SimpleTextOutlined(v:Nick(), "ESP_Font_Main", MaxX-(MaxX-MinX)/2-w/2, MinY-1, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
					end
					if config["esp_player_hp"] then
						local hpMultiplier = v:Health() / v:GetMaxHealth()
						hpMultiplier = math.Clamp(hpMultiplier, 0, 1)
						local barLen = MinY - MaxY
						barlen = barLen * hpMultiplier
						local appliedBar = (MinY - MaxY) - barlen
						surface.SetFont("ESP_Font_Flag")
						local w, h = surface.GetTextSize(v:Health())
						draw.SimpleTextOutlined(v:Health(), "ESP_Font_Flag", MinX-w-6, MinY+10, string.ToColor(config.colors["esp_player_hp"]), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
						surface.SetDrawColor(0, 0, 0, 100)
						surface.DrawLine( MinX-2, MinY, MinX-2, MaxY )
						surface.DrawLine( MinX-3, MinY, MinX-3, MaxY )
						surface.SetDrawColor(0, 255, 0)
						surface.DrawLine( MinX-2, MinY-appliedBar, MinX-2, MaxY )
						surface.DrawLine( MinX-3, MinY-appliedBar, MinX-3, MaxY )
					end
					if config["esp_player_armor"] then
						local yOffset
						if config["esp_player_hp"] then
							yOffset = 20
						else
							yOffset = 10
						end
						surface.SetFont("ESP_Font_Flag")
						local w, h = surface.GetTextSize(v:Armor())
						if v:Armor() != 0 then
							draw.SimpleTextOutlined(v:Armor(), "ESP_Font_Flag", MinX-w-6, MinY+yOffset, string.ToColor(config.colors["esp_player_armor"]), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
						end
					end
					if config["esp_player_weapon"] then
						surface.SetFont("ESP_Font_Flag")
						if IsValid(v:GetActiveWeapon()) then
							local w, h = surface.GetTextSize(v:GetActiveWeapon():GetPrintName())
							draw.SimpleTextOutlined(v:GetActiveWeapon():GetPrintName(), "ESP_Font_Flag", MaxX-(MaxX-MinX)/2-w/2, MaxY+12, string.ToColor(config.colors["esp_player_weapon"]), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
						end
					end
					if config["esp_player_rank"] then
						local yOffset
						if config["esp_player_weapon"] then
							yOffset = 24
						else
							yOffset = 12
						end
						surface.SetFont("ESP_Font_Flag")
						local w, h = surface.GetTextSize(v:GetUserGroup())
						draw.SimpleTextOutlined(v:GetUserGroup(), "ESP_Font_Flag", MaxX-(MaxX-MinX)/2-w/2, MaxY+yOffset, string.ToColor(config.colors["esp_player_rank"]), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
					end
					if config["esp_player_team"] then
						local yOffset
						if config["esp_player_weapon"] && config["esp_player_rank"] then
							yOffset = 36
						elseif ( config["esp_player_weapon"] && !config["esp_player_rank"] ) || ( !config["esp_player_weapon"] && config["esp_player_rank"] ) then
							yOffset = 24
						else
							yOffset = 12
						end
						local teamColor = team.GetColor(v:Team())
						surface.SetFont("ESP_Font_Flag")
						local w, h = surface.GetTextSize(team.GetName(v:Team()))
						draw.SimpleTextOutlined(team.GetName(v:Team()), "ESP_Font_Flag", MaxX-(MaxX-MinX)/2-w/2, MaxY+yOffset, teamColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
					end
					if config["esp_player_snaplines"] then
						surface.SetDrawColor( string.ToColor(config.colors["esp_player_snaplines"]))
						surface.DrawLine( ScrW() / 2 - 1, ScrH() , MaxX - ( MaxX - MinX ) / 2 - 1, MaxY )
					end
					if config["esp_player_skeleton"] then
						for _, b in pairs( bones ) do
							if v:LookupBone(b.S) != nil && v:LookupBone(b.E) != nil then
								local spos, epos = v:GetBonePosition(v:LookupBone(b.S)):ToScreen(), v:GetBonePosition(v:LookupBone(b.E)):ToScreen()
								if spos.visible && epos.visible then
									surface.SetDrawColor( string.ToColor(config.colors["esp_player_skeleton"]) )
									surface.DrawLine( spos.x, spos.y, epos.x, epos.y )
								end
							end
						end
					end
					if config["aim_master_toggle"] && config["esp_other_drawfov"] && config["aim_fov"] < 90 then
						local X1 = math.tan( math.rad( config["aim_fov"] ) / 1.25 )
						local X2 = math.tan( math.rad( LocalPlayer():GetFOV() / 2 ) )
						local r = X1 / X2
						local pxR = r * ( ScrW() / 2 )
						surface.DrawCircle(ScrW() / 2, ScrH() / 2, pxR, string.ToColor(config.colors["esp_other_drawfov"]))
					end
					if v.Traitor then
						surface.SetFont("ESP_Font_Flag")
						local w, h = surface.GetTextSize("Traitor")
						draw.SimpleTextOutlined("Traitor", "ESP_Font_Flag", MaxX+5, MinY + h, Color(255, 0, 0) , TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
					end
					if config["misc_ttt"] && engine.ActiveGamemode() == "murder" then
						if v:HasWeapon("weapon_mu_knife") then
							surface.SetFont("ESP_Font_Flag")
							local w, h = surface.GetTextSize("Murderer")
							draw.SimpleTextOutlined("Murderer", "ESP_Font_Flag", MaxX+5, MinY + h, Color(255, 0, 0) , TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))	
						end 	
					end
				end
			end
		end
		for k, v in ipairs(ents.GetAll()) do
			if table.HasValue(config["entities"], v:GetClass()) then
				if v && v:GetOwner() != LocalPlayer() && IsValid(v) && v:GetPos():Distance(LocalPlayer():GetPos()) <= config["esp_player_render_distance"] then
					local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8, isVis = GetENTPos( v )
					if config["esp_entity_box"] then
						surface.SetDrawColor(string.ToColor(config.colors["esp_entity_box"]))
						surface.DrawLine( MaxX, MaxY, MinX, MaxY )
						surface.DrawLine( MaxX, MaxY, MaxX, MinY )
						surface.DrawLine( MinX, MinY, MaxX, MinY )
						surface.DrawLine( MinX, MinY, MinX, MaxY )
					end
					if config["esp_entity_name"] then
						surface.SetFont("ESP_Font_Flag")
						local w, h = surface.GetTextSize(v:GetClass())
						draw.SimpleTextOutlined(v:GetClass(), "ESP_Font_Flag", MaxX-(MaxX-MinX)/2-w/2, MinY-1, string.ToColor(config.colors["esp_entity_name"]), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
					end
				end
			end
		end
		if config["misc_observerlist"] then
			for k, v in ipairs(observingPlayers.watcher) do
				if IsValid(v) then
					surface.SetFont("ESP_Font_Main")
					local nameWidth, nameHeight = surface.GetTextSize("Observer: "..v:Name())
					draw.SimpleText("Observer: "..v:Name(), "ESP_Font_Main", ScrW() - nameWidth - 2, 0 + (15 * ( k - 1 ) ), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end
			end
			for k, v in ipairs(observingPlayers.spec) do
				if IsValid(v) then
	 				surface.SetFont("ESP_Font_Main")
					local nameWidth, nameHeight = surface.GetTextSize("Spectator: "..v:Name())
					draw.SimpleText("Spectator: "..v:Name(), "ESP_Font_Main", ScrW() - nameWidth - 2, -15 + (15 * #observingPlayers.watcher) + (15 * k - 1), Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end
			end
		end
		if config["misc_adminlist"] then
			for k, v in ipairs(onlineStaff) do
				if IsValid(v) then
					local a
					if v:IsSuperAdmin() then a = "Superadmin" elseif v:IsAdmin() then a = "Admin" else a = v:GetUserGroup() end
					surface.SetFont("ESP_Font_Main")
					local nameWidth, nameHeight = surface.GetTextSize(v:Name().." ("..a..")")
					draw.SimpleText(v:Name().." ("..a..")", "ESP_Font_Main", 2, 0 + (15 * ( k - 1 ) ), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end
			end
		end
	end
end)

-- ======================= Glow

AddHook("PreDrawHalos", RandomString(), function()
	if !ss then
		if config["esp_player_glow"] then
			halo.Add(playerTable, string.ToColor(config.colors["esp_player_glow"]), 1, 1, 2, true, true)
		end
	end
end)

-- ======================= Chams

AddHook("RenderScreenspaceEffects", RandomString(), function()

	local colorFix = (1 / 255)
	local chamColVis = string.ToColor(config.colors["esp_player_chams"])
	local chamColOver = string.ToColor(config.colors["esp_player_chams_overlay"])
	local chamColInvis = string.ToColor(config.colors["esp_player_chams_xyz"])
	chamColInvis.a = math.Clamp(chamColInvis.a, 0, 254)
	local chamMatVis = config["esp_player_chams_material"]
	local chamMatOver = config["esp_player_overlay_chams_material"]
	local chamsMatInvis = config["esp_player_xyz_chams_material"]

	if ss then
		cam.Start3D( EyePos(), EyeAngles() )
			for k, v in ipairs(ents.GetAll()) do
				if IsValid(v) then
					render.MaterialOverride()
					cam.IgnoreZ(false)
					v:SetRenderMode(0)
					v:SetColor(color_white)
					v:DrawModel()
				end
			end
		cam.End3D()
		return
	end

	if config["esp_player_chams_xyz"] then
		cam.Start3D( EyePos(), EyeAngles() )
			for k, v in ipairs(player.GetAll()) do	
				if ValidateESP(v) then
					cam.IgnoreZ(true)
					render.SetColorModulation( chamColInvis.r * colorFix, chamColInvis.g * colorFix, chamColInvis.b * colorFix )
					render.SetBlend( chamColInvis.a * colorFix)
					render.MaterialOverride(Material(chamsMatInvis))
					v:SetRenderMode(1)
					v:DrawModel()
					cam.IgnoreZ(false)
					render.SetColorModulation(1, 1, 1)
					render.SetBlend(1)
					render.MaterialOverride()
					v:DrawModel()
				end
			end
		cam.End3D()
	end
	if config["esp_player_chams"] then
		cam.Start3D( EyePos(), EyeAngles() )
			for k, v in ipairs(player.GetAll()) do
				if ValidateESP(v) then
					render.SetColorModulation( chamColVis.r * colorFix, chamColVis.g * colorFix, chamColVis.b * colorFix )
					render.SetBlend( chamColVis.a * colorFix)
					render.MaterialOverride(Material(chamMatVis))
					v:SetRenderMode(1)
					v:SetColor(Color(255, 255, 255, 0))
					v:DrawModel()
				end
			end
		cam.End3D()
	end
	if config["esp_player_chams_overlay"] then
		cam.Start3D( EyePos(), EyeAngles() )
			for k, v in ipairs(player.GetAll()) do
				if ValidateESP(v) then
					render.SetColorModulation( chamColOver.r * colorFix, chamColOver.g * colorFix, chamColOver.b * colorFix )
					render.SetBlend( chamColOver.a * colorFix)
					render.MaterialOverride(Material(chamMatOver))
					v:SetRenderMode(1)
					v:DrawModel()
				end
			end
		cam.End3D()
	end
	if !config["esp_player_chams"] && !config["esp_player_chams_xyz"] then
		for k, v in pairs(player.GetAll()) do
			v:SetRenderMode(0)
		end
	end
end)

-- ======================= Fog

AddHook("SetupWorldFog", RandomString(), function()
	if !ss then
		if config["esp_other_fog"] then
			local col = string.ToColor(config.colors["esp_other_fog"])

			render.FogMode( MATERIAL_FOG_LINEAR )
			render.FogStart(config["esp_other_fog_start"])
			render.FogEnd(config["esp_other_fog_end"])
			render.FogMaxDensity(config["esp_other_fog_density"])
			render.FogColor(col.r, col.g, col.b)

			return true
		end
	end
end)

AddHook("SetupSkyboxFog", RandomString(), function( skyboxscale )
	if !ss then
		if config["esp_other_fog"] then

			local col = string.ToColor(config.colors["esp_other_fog"])

			render.FogMode( MATERIAL_FOG_LINEAR )
			render.FogStart(config["esp_other_fog_start"] * skyboxscale)
			render.FogEnd(config["esp_other_fog_end"] * skyboxscale)
			render.FogMaxDensity(config["esp_other_fog_density"])
			render.FogColor(col.r, col.g, col.b)

			return true
		end
	end
end)

-- ======================= Modulation

local OldWorldModState, OldWorldModColor, OldPropModState, OldPropModColor, LastFrameSS = config["esp_other_worldmod"], config.colors["esp_other_worldmod"], config["esp_other_propmod"], config.colors["esp_other_propmod"], false

local function UpdateWorldModulation()

	local col = string.ToColor(config.colors["esp_other_worldmod"])

	for k, v in pairs( Entity( 0 ):GetMaterials() ) do
   		Material( v ):SetVector( "$color", Vector(col.r * (1 / 255), col.g * (1 / 255), col.b * (1 / 255)) )
   		Material( v ):SetFloat( "$alpha", col.a * (1 / 255) )
	end

end

local function UpdatePropModulation()

	local col = string.ToColor(config.colors["esp_other_propmod"])

	for k, v in pairs(ents.FindByClass("prop_physics")) do
		v:SetRenderMode( RENDERMODE_TRANSCOLOR )
		v:SetColor(col)
	end

end

AddHook("Think", RandomString(), function()

	if ss then 
		if config["esp_other_worldmod"] then
			DisableWorldModulation()
		end
		if config["esp_other_propmod"] then
			DisablePropModulation()
		end
		LastFrameSS = true
	end
	if LastFrameSS then
		if config["esp_other_worldmod"] then
			UpdateWorldModulation()
		end
		if config["esp_other_propmod"] then
			UpdatePropModulation()
		end
		LastFrameSS = false
	end

	if OldWorldModState != config["esp_other_worldmod"] && config["esp_other_worldmod"] then
		UpdateWorldModulation()
		OldWorldModState, OldWorldModColor = config["esp_other_worldmod"], config.colors["esp_other_worldmod"]
	elseif OldWorldModState != config["esp_other_worldmod"] && !config["esp_other_worldmod"] then
		DisableWorldModulation()
		OldWorldModState, OldWorldModColor = config["esp_other_worldmod"], config.colors["esp_other_worldmod"]
	end
	if OldWorldModColor != config.colors["esp_other_worldmod"] && config["esp_other_worldmod"] then
		UpdateWorldModulation()
		OldWorldModState, OldWorldModColor = config["esp_other_worldmod"], config.colors["esp_other_worldmod"]
	end

	if OldPropModState != config["esp_other_propmod"] && config["esp_other_propmod"] then
		UpdatePropModulation()
		OldPropModState, OldPropModColor = config["esp_other_propmod"], config.colors["esp_other_propmod"]
	elseif OldPropModState != config["esp_other_propmod"] && !config["esp_other_propmod"] then
		DisablePropModulation()
		OldPropModState, OldPropModColor = config["esp_other_propmod"], config.colors["esp_other_propmod"]
	end
	if OldPropModColor != config.colors["esp_other_propmod"] && config["esp_other_propmod"] then
		UpdatePropModulation()
		OldPropModState, OldPropModColor = config["esp_other_propmod"], config.colors["esp_other_propmod"]
	end
	
end)

if config["esp_other_worldmod"] then
	UpdateWorldModulation()
end
if config["esp_other_propmod"] then
	UpdatePropModulation()
end

--=================================== No Sky

AddHook("PreDrawSkyBox", RandomString(), function()

	if config["esp_other_nosky"] then
		return true
	else
		return false
	end

end)

--=================================== Nightmode

AddHook("RenderScreenspaceEffects", RandomString(), function()
	if !ss then
		if config["esp_other_nightmode"] then
			local nightmode = {
				[ "$pp_colour_addr" ] = 55 * (1 / 255),
				[ "$pp_colour_addg" ] = 45 * (1 / 255),
				[ "$pp_colour_addb" ] = 66 * (1 / 255),
				[ "$pp_colour_brightness" ] = -0.2,
				[ "$pp_colour_contrast" ] = config["esp_other_nightmode_scale"],
				[ "$pp_colour_colour" ] = 1,
				[ "$pp_colour_mulr" ] = 0,
				[ "$pp_colour_mulg" ] = 0,
				[ "$pp_colour_mulb" ] = 0
			}
			DrawColorModify( nightmode )
		end
	end
end)

--=================================== Hitsound

	
AddHook("ScalePlayerDamage", RandomString(), function(ply, group, dmginfo)
	if config["esp_other_hitsound"] then
		if dmginfo:GetAttacker() == LocalPlayer() then
			surface.PlaySound("garrysmod/balloon_pop_cute.wav")
		end
	end
end)

--=================================== Fullbright


local LightingModeChanged = false
AddHook("PreRender", RandomString(), function()
	if !ss then
		if config["esp_other_fullbright"] then
			render.SetLightingMode( 1 )
			LightingModeChanged = true
		end
	end
end )

local function EndOfLightingMod()
	if LightingModeChanged then
		render.SetLightingMode( 0 )
		LightingModeChanged = false
	end
end
AddHook("PostRender", RandomString(), EndOfLightingMod)
AddHook("PreDrawHUD", RandomString(), EndOfLightingMod)

--=================================== Camera Modifications


AddHook("CalcView", RandomString(), function(ply, pos, ang, fov)
	if ss then return end
	if config["esp_other_freecam"] && NoclipOn then
		local inspeed, infw, inback, inleft, inright = input.GetKeyCode(input.LookupBinding("+speed")), input.GetKeyCode(input.LookupBinding("+forward")), input.GetKeyCode(input.LookupBinding("+back")), input.GetKeyCode(input.LookupBinding("+moveleft")), input.GetKeyCode(input.LookupBinding("+moveright"))
		-- Had to do it like this instead of LocalPlayer():KeyDown(IN_FORWARD) etc because for some reason that would get stuck on true sometimes after moving and then toggeling, cba to figure it out so this works as a fix.
		local Camera = {}
		local Speed = config["esp_other_freecam_speed"]
		local MouseAngs = Angle( NoclipY, NoclipX, 0 )
		if input.IsKeyDown(inspeed) then
			Speed = Speed * 5
		end
		if input.IsKeyDown(infw) then
			NoclipPos = NoclipPos+(MouseAngs:Forward()*Speed)
		end
		if input.IsKeyDown(inback) then
			NoclipPos = NoclipPos-(MouseAngs:Forward()*Speed)
		end
		if input.IsKeyDown(inleft) then
			NoclipPos = NoclipPos-(MouseAngs:Right()*Speed)
		end
		if input.IsKeyDown(inright) then
			NoclipPos = NoclipPos+(MouseAngs:Right()*Speed)
		end
		if NoclipJump then
			NoclipPos = NoclipPos+Vector(0,0,Speed)
		end
		if NoclipDuck then
			NoclipPos = NoclipPos-Vector(0,0,Speed)
		end
		Camera.origin = NoclipPos
		Camera.angles = MouseAngs
		Camera.fov = FOV
		Camera.drawviewer = true
		return Camera
	end
	if config["esp_other_thirdperson"] && intp then
		local Camera = {}
		Camera.origin = pos - ( ang:Forward() * (config["esp_other_thirdperson_distance"] * 10) ) 
		Camera.angles = ang
		Camera.fov = fov
		Camera.drawviewer = true
		return Camera
	end
	if config["aim_norecoil"] && !intp && !NoclipOn then
		local Camera = {}
		Camera.angles = LocalPlayer():EyeAngles()
		return Camera 
	end
end)

--===================================
--=================================== Aimbot
--===================================

--=================================== No Recoil
 
local OEyeAngles = OEyeAngles or FindMetaTable( "Player" ).SetEyeAngles

FindMetaTable( "Player" ).SetEyeAngles = function( self, angle )

    if ( string.find( string.lower( debug.getinfo( 2 ).short_src ), "/weapons/" ) ) and config["aim_norecoil"] then return end

    OEyeAngles( self, angle )

end

--=================================== CreateMove (Aimbot, Triggerbot, BHop, AutoStrafe, Autofire, Misc Calcs)

local predictedWeapons = {
	["weapon_crossbow"] = 3110;
}

local pred, realAng

local function FixMovement(cmd, fa)
	
	local vec = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), 0)
	local vel = math.sqrt(vec.x * vec.x + vec.y * vec.y)
	local mang = vec:Angle()
	local yaw = cmd:GetViewAngles().y - fa.y + mang.y

	if ( ( cmd:GetViewAngles().p + 90 ) % 360 ) > 180 then
		yaw = 180 - yaw
	end

	yaw = ( ( yaw + 180 ) % 360 ) - 180

	cmd:SetForwardMove( math.cos( math.rad( yaw ) ) * vel )
	cmd:SetSideMove( math.sin( math.rad( yaw ) ) * vel )

end

local function GetAngleDiffrence(from, to)

	local ang, aim

	ang = from:Forward()
	aim = to:Forward()

	return math.deg( math.acos( aim:Dot(ang) / aim:LengthSqr() ) )

end

local function HitScan(v)
	local bones = {}
	local centerx, centery = ScrW() / 2, ScrH() / 2
	local BPHead, BPUpperChest, BPChest, BPLowerChest, BPPelvis, HeadDis, UpperChestDis, ChestDis, LowerChestDis, PelvisDis

	if v:LookupBone("ValveBiped.Bip01_Head1") != nil then
		BPHead = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Head1"))
		HeadDis = math.sqrt((centerx - BPHead:ToScreen().x) * (centerx - BPHead:ToScreen().x) + (centery - BPHead:ToScreen().y) * (centery - BPHead:ToScreen().y))
		table.insert(bones, HeadDis)
	end
	if v:LookupBone("ValveBiped.Bip01_Spine4") != nil then
		BPUpperChest = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine4"))
		UpperChestDis = math.sqrt((centerx - BPUpperChest:ToScreen().x) * (centerx - BPUpperChest:ToScreen().x) + (centery - BPUpperChest:ToScreen().y) * (centery - BPUpperChest:ToScreen().y))
		table.insert(bones, UpperChestDis)
	end
	if v:LookupBone("ValveBiped.Bip01_Spine2") != nil then
		BPChest = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine2"))
		ChestDis = math.sqrt((centerx - BPChest:ToScreen().x) * (centerx - BPChest:ToScreen().x) + (centery - BPChest:ToScreen().y) * (centery - BPChest:ToScreen().y))
		table.insert(bones, ChestDis)
	end
	if v:LookupBone("ValveBiped.Bip01_Spine1") != nil then
		BPLowerChest = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine1"))
		LowerChestDis = math.sqrt((centerx - BPLowerChest:ToScreen().x) * (centerx - BPLowerChest:ToScreen().x) + (centery - BPLowerChest:ToScreen().y) * (centery - BPLowerChest:ToScreen().y))
		table.insert(bones, LowerChestDis)
	end
	if v:LookupBone("ValveBiped.Bip01_Pelvis") != nil then
		BPPelvis = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Pelvis"))
		PelvisDis = math.sqrt((centerx - BPPelvis:ToScreen().x) * (centerx - BPPelvis:ToScreen().x) + (centery - BPPelvis:ToScreen().y) * (centery - BPPelvis:ToScreen().y))
		table.insert(bones, PelvisDis)
	end

	if table.IsEmpty(bones) then return v:LocalToWorld(v:OBBCenter()) + pred end

	local ClosestBone = math.min(unpack(bones))
	if ClosestBone == HeadDis then
		AimSpot = BPHead + Vector(0, 0, 1) + pred
		AimBone = "Head"
	elseif ClosestBone == UpperChestDis then
		AimSpot = BPUpperChest + pred
		AimBone = "Upper Chest"
	elseif ClosestBone == ChestDis then
		AimSpot = BPChest + pred
		AimBone = "Chest"
	elseif ClosestBone == LowerChestDis then
		AimSpot = BPLowerChest + pred
		AimBone = "Lower Chest"
	elseif ClosestBone == PelvisDis then
		AimSpot = BPPelvis + pred
		AimBone = "Pelvis"
	else
		AimSpot = v:LocalToWorld(v:OBBCenter()) + pred
	end	
	return AimSpot
end

local function Prediction(v, pos)
	local ply = LocalPlayer()
	if ( type( v:GetVelocity() ) == "Vector" ) then
		local dis, wep = v:GetPos():Distance( ply:GetPos() ), ( ply.GetActiveWeapon && IsValid( ply:GetActiveWeapon() ) && ply:GetActiveWeapon():GetClass() )
		if ( wep && predictedWeapons[ wep ]  ) then
			local t = dis / predictedWeapons[ wep ]
			return ( pos + v:GetVelocity() * t )
		end
		return pos
	end
	return pos
end

local function GetIgnorePlayers( ply )

	if config["aim_ignoreadmins"] then
		if table.HasValue(onlineStaff, ply) then
			return false
		end
	end
	if config["aim_ignorenoclip"] then
		if ply:GetMoveType() == MOVETYPE_NOCLIP then
			return false
		end
	end
	if config["aim_ignoreteam"] then
		if ply:Team() == LocalPlayer():Team() then
			return false
		end
	end

	return true
end

local function isVisible( v )

	if !config["aim_ignoreinvis"] then
		return true
	end

	local ply = LocalPlayer()
	
	local pos = v:LocalToWorld(v:OBBCenter())
	
	local trace = { 
		start = ply:GetShootPos(), 
		endpos = pos, 
		filter = { ply, v }, 
		mask = MASK_SHOT
	}
	local tr = util.TraceLine( trace )
	
	if( !tr.Hit ) then
		return true
	end
	return false
end

local function Smoothing( ang )
	if ( config["aim_smoothing_value"] == 0 ) then return ang end
	local speed, ply = RealFrameTime() / ( config["aim_smoothing_value"] / 10 ), LocalPlayer()
	local angl = LerpAngle( speed, ply:EyeAngles(), ang )
	return Angle( angl.p, angl.y, 0 )
end

AddHook("CreateMove", RandomString(), function(ucmd)
	if config["aim_silent"] then
		if(!realAng) then realAng = ucmd:GetViewAngles() end
		realAng = realAng + Angle(ucmd:GetMouseY() * .023, ucmd:GetMouseX() * -.023, 0)
		realAng.x = math.NormalizeAngle(realAng.x)
		realAng.p = math.Clamp(realAng.p, -89, 89)
		if ucmd:CommandNumber() == 0 then ucmd:SetViewAngles(realAng) return end
	else
		if ucmd:CommandNumber() == 0 then return end
	end
	if config["esp_other_freecam"] then
		if config.keybinds["freecam_key"] == 0 then 
			NoclipOn = true
		elseif ( ( ( config.keybinds["freecam_key"] >= 107 && config.keybinds["freecam_key"] <= 113 ) && input.IsMouseDown(config.keybinds["freecam_key"] ) && !toggledelayN ) || input.IsKeyDown(config.keybinds["freecam_key"]) && !toggledelayN ) then
			if NoclipOn then	
				NoclipOn = false
				toggledelayN = true
				timer.Simple(0.5, function() toggledelayN = false end)
			else
				NoclipOn = true
				NoclipPos, NoclipAngles = LocalPlayer():EyePos(), ucmd:GetViewAngles()
				NoclipY, NoclipX = ucmd:GetViewAngles().x, ucmd:GetViewAngles().y
				toggledelayN = true
				timer.Simple(0.5, function() toggledelayN = false end)
			end
		end
		if NoclipOn then
			ucmd:ClearMovement()
			if ucmd:KeyDown(IN_JUMP) then
				ucmd:RemoveKey(IN_JUMP)
				NoclipJump = true
			elseif NoclipJump then
				NoclipJump = false
			end
			if ucmd:KeyDown(IN_DUCK) then
				ucmd:RemoveKey(IN_DUCK)
				NoclipDuck = true
			elseif NoclipDuck then
				NoclipDuck = false
			end
			NoclipX = NoclipX-(ucmd:GetMouseX()/10)
			if NoclipY+(ucmd:GetMouseY()/10) > 89 then NoclipY = 89 elseif NoclipY+(ucmd:GetMouseY()/10) < -89 then NoclipY = -89 else NoclipY = NoclipY+(ucmd:GetMouseY()/10) end
			ucmd:SetViewAngles(NoclipAngles)
		end
	elseif NoclipOn == true then
		NoclipOn = false
	end

	if config["esp_other_thirdperson"] then
		if config.keybinds["thirdperson_key"] == 0 then 
			intp = true
		elseif ( ( ( config.keybinds["thirdperson_key"] >= 107 && config.keybinds["thirdperson_key"] <= 113 ) && input.IsMouseDown(config.keybinds["thirdperson_key"] ) && !toggledelay3 || input.IsKeyDown(config.keybinds["thirdperson_key"]) && !toggledelay3 ) ) then
			intp = !intp
			toggledelay3 = true
			timer.Simple(0.5, function() toggledelay3 = false end)
		end
	end
	if ( frame ) && not gui.IsConsoleVisible() && not gui.IsGameUIVisible() && not editingText && not NoclipOn then
		local ply = LocalPlayer()
		local f, b, l, r, j, d = input.GetKeyCode(input.LookupBinding("+forward")), input.GetKeyCode(input.LookupBinding("+back")), input.GetKeyCode(input.LookupBinding("+moveleft")), input.GetKeyCode(input.LookupBinding("+moveright")), input.GetKeyCode(input.LookupBinding("+jump")), input.GetKeyCode(input.LookupBinding("+duck"))
		if input.IsKeyDown( f ) then ucmd:SetForwardMove( ply:GetMaxSpeed() ) end
		if input.IsKeyDown( b ) then ucmd:SetForwardMove( -ply:GetMaxSpeed() ) end
		if input.IsKeyDown( r ) then ucmd:SetSideMove( ply:GetMaxSpeed() ) end
		if input.IsKeyDown( l ) then ucmd:SetSideMove( -ply:GetMaxSpeed() ) end
		if input.IsKeyDown( d ) then ucmd:SetButtons( IN_DUCK ) end
		if input.IsKeyDown( j ) then ucmd:SetButtons( IN_JUMP ) end
	end
	if config["misc_autostrafe"] then
		local ply = LocalPlayer()
		if ply:GetMoveType() == MOVETYPE_LADDER || ply:GetMoveType() == MOVETYPE_NOCLIP then return end
		if ucmd:KeyDown( IN_JUMP ) then
			if ucmd:GetMouseX() < 0 then
				ucmd:SetSideMove(-450)
			elseif ucmd:GetMouseX() > 0 then
				ucmd:SetSideMove(450)
			end
		end
	end
	if config["misc_autobunnyhop"] then
		local ply = LocalPlayer()
		if ply:GetMoveType() == MOVETYPE_LADDER || ply:GetMoveType() == MOVETYPE_NOCLIP then return end
		if ucmd:KeyDown( IN_JUMP ) then
			if !ply:OnGround() then
				ucmd:SetButtons( ucmd:GetButtons() - IN_JUMP )
			end
		end
	end
	if config["misc_autoclick"] then
		if LocalPlayer():Alive() && IsValid(LocalPlayer():GetActiveWeapon()) && LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
			if LocalPlayer():KeyDown( IN_ATTACK ) then ucmd:RemoveKey(IN_ATTACK) end
		end
	end
	if config["aim_master_toggle"] then
		if !config["aim_onkey"] || ( config.keybinds["aim_onkey_key"] != 0 && ( ( config.keybinds["aim_onkey_key"] >= 107 && config.keybinds["aim_onkey_key"] <= 113 ) && input.IsMouseDown(config.keybinds["aim_onkey_key"]) ) || input.IsKeyDown(config.keybinds["aim_onkey_key"]) ) && !frame then
			if !LocalPlayer():Alive() then return end
			if IsValid(LocalPlayer():GetActiveWeapon()) && LocalPlayer():GetActiveWeapon():Clip1() != 0 then
			local centerx, centery = ScrW() / 2, ScrH() / 2
			local PlayerDistance, NewPlayerDistance, PlayerHealth, NewPlayerHealth, playerCenter, newPlayerCenter = math.huge, math.huge, math.huge, math.huge, math.huge, math.huge
				for k, v in pairs(player.GetAll()) do
					if ValidateAimbot(v) and GetIgnorePlayers(v) then
						if isVisible(v) then
							local tarFrames, plyFrames = RealFrameTime() / ( 1 / frametime ), RealFrameTime() / ( 1 / frametime ) 
							pred = v:GetVelocity() * tarFrames - LocalPlayer():GetVelocity() * plyFrames
							local LOS, AimP, InFOV = false, false, false
							local CurAngle = ucmd:GetViewAngles()
							local CurPos = LocalPlayer():GetShootPos()
							local AimSpot

							if config["aim_hitbox"] == 1 then

								AimSpot = HitScan(v)

							elseif config["aim_hitbox"] == 2 && v:LookupBone("ValveBiped.Bip01_Head1") != nil then

								AimSpot = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Head1")) + Vector(0, 0, 1) + pred

							elseif config["aim_hitbox"] == 3 && v:LookupBone("ValveBiped.Bip01_Pelvis") != nil then

								AimSpot = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Pelvis")) + pred

							else

								AimSpot = v:LocalToWorld(v:OBBCenter()) + pred

							end

							if IsValid(LocalPlayer():GetActiveWeapon()) && LocalPlayer():GetActiveWeapon():GetClass() == "weapon_crossbow" then
								AimSpot = Prediction(v, AimSpot)
							end

							local FinAngle = ( AimSpot - CurPos ):Angle()
							FinAngle:Normalize()

							if config["aim_target"] == 1 then
								if math.sqrt((AimSpot:ToScreen().x - centerx) * (AimSpot:ToScreen().x - centerx) + (AimSpot:ToScreen().y - centery) * (AimSpot:ToScreen().y - centery)) < playerCenter then newPlayerCenter = math.sqrt((AimSpot:ToScreen().x - centerx) * (AimSpot:ToScreen().x - centerx) + (AimSpot:ToScreen().y - centery) * (AimSpot:ToScreen().y - centery)) AimP = true end
							elseif config["aim_target"] == 2 then
								if v:Health() < PlayerHealth then NewPlayerHealth = v:Health() AimP = true end
							elseif config["aim_target"] == 3 then
								if LocalPlayer():GetPos():Distance(v:GetPos()) < PlayerDistance then NewPlayerDistance = LocalPlayer():GetPos():Distance(v:GetPos()) AimP = true end
							end
							local angDiff = GetAngleDiffrence(CurAngle, FinAngle)
							angDiff = math.abs(math.NormalizeAngle(angDiff))
							if angDiff < config["aim_fov"] then
								InFOV = true 
							end

							if AimP && InFOV then
								if config["aim_smoothing"] && (IsValid(LocalPlayer():GetActiveWeapon()) && LocalPlayer():GetActiveWeapon():GetClass() != "weapon_crossbow" ) then
									playerCenter = newPlayerCenter
									PlayerHealth = NewPlayerHealth
									PlayerDistance = NewPlayerDistance
									ucmd:SetViewAngles(Smoothing(FinAngle))
									if config["aim_silent"] then
										FixMovement(ucmd, realAng)
									end
								else
									playerCenter = newPlayerCenter
									PlayerHealth = NewPlayerHealth
									PlayerDistance = NewPlayerDistance
									ucmd:SetViewAngles(FinAngle)
									if config["aim_silent"] then
										FixMovement(ucmd, realAng)
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if config["trigger_master_toggle"] then
		if !config["trigger_onkey"] || ( config.keybinds["trigger_onkey_key"] && ( ( config.keybinds["trigger_onkey_key"] >= 107 && config.keybinds["trigger_onkey_key"] <= 113 ) && input.IsMouseDown(config.keybinds["trigger_onkey_key"]) ) || input.IsKeyDown(config.keybinds["trigger_onkey_key"]) ) && !frame then
			if IsValid(LocalPlayer()) && LocalPlayer():Alive() then
				if IsValid(LocalPlayer():GetActiveWeapon()) && LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
					local tr = LocalPlayer():GetEyeTraceNoCursor()
					if tr.Entity:IsPlayer() then
						ply = tr.Entity
						if ValidateAimbot(ply) then
							if ucmd:KeyDown( IN_ATTACK2 ) && ucmd:KeyDown( IN_DUCK ) then 
								ucmd:SetButtons( IN_DUCK + IN_ATTACK2 + IN_ATTACK )
								timer.Simple( 0.05, function() RunConsoleCommand( "-attack" ) end ) 
							elseif ucmd:KeyDown( IN_DUCK ) then 
								ucmd:SetButtons( IN_DUCK + IN_ATTACK )
								timer.Simple( 0.05, function() RunConsoleCommand( "-attack" ) end )
							elseif ucmd:KeyDown( IN_ATTACK2 ) then 
								ucmd:SetButtons( IN_ATTACK2 + IN_ATTACK )
								timer.Simple( 0.05, function() RunConsoleCommand( "-attack" ) end ) 
							else
								ucmd:SetButtons( IN_ATTACK ) 
								timer.Simple( 0.05, function() RunConsoleCommand( "-attack" ) end )
							end
						end
					end
				end
			end
		end
	end
end)

--===================================
--=================================== Misc
--===================================

--=================================== TTT

for _,v in ipairs(player.GetAll()) do
    v.Traitor = nil
end

AddHook("Think", RandomString(), function()
	if config["misc_ttt"] && engine.ActiveGamemode() == "terrortown" then
	    if GAMEMODE.round_state != ROUND_ACTIVE then
	        for _,v in ipairs(player.GetAll()) do
                v.Traitor = nil
	        end
	        return
	    end
	    for _, v in ipairs( player.GetAll() ) do
	        if IsValid(v) && v:IsTerror() && !v:IsDetective() && !v.Traitor && v != LocalPlayer() then
	            for _, w in ipairs(v:GetWeapons()) do
	            	if w and w.CanBuy and table.HasValue(w.CanBuy, ROLE_TRAITOR) && w.AutoSpawnable == false then
	            		v.Traitor = true
	            		chat.AddText(Color(61, 149, 217), "[Nekowa.re] ", Color(222, 222, 222), v:Nick(),  " is a ", Color(255,0,0), "TRAITOR", Color(222, 222, 222), " with a ", Color(0, 255, 0), w:GetClass() .. "!")
	            	end
	            end
	        end
	    end
	end
end)

--=================================== Rainbow Physgun

AddHook("Think", RandomString(), function()
	if !ss then
		if config["misc_rainbow"] then
			local col = HSVToColor( ( CurTime() * config["misc_rainbow_speed"] ) % 360, 1, 1 )
			if LocalPlayer():Alive() && IsValid(LocalPlayer():GetActiveWeapon()) && LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then
				LocalPlayer():SetWeaponColor( Color(col.r, col.g, col.b):ToVector() )
			end
		end
	end
end)

--=================================== Viewmodel Changer

AddHook("CalcViewModelView", RandomString(), function(Weapon, ViewModel, OldPos, OldAngle, EyePos, EyeAngle)

	if ss then return end
	if !config["misc_viewmodel"] then return end
	
	if config["misc_bob"] then
		EyeAngle = OldAngle
	end
	if config["misc_sway"] then
		EyePos = OldPos
	end

	local OverridePos = Vector(config["misc_vm_x"], config["misc_vm_y"], config["misc_vm_z"])
	local OverrideAngle = Angle(config["misc_vm_p"], config["misc_vm_ya"], config["misc_vm_r"])

	EyeAngle = EyeAngle * 1

	EyeAngle:RotateAroundAxis(EyeAngle:Right(), OverrideAngle.x * 1.0)
	EyeAngle:RotateAroundAxis(EyeAngle:Up(), OverrideAngle.y * 1.0)
	EyeAngle:RotateAroundAxis(EyeAngle:Forward(), OverrideAngle.z* 1.0)

	EyePos = EyePos + OverridePos.x * EyeAngle:Right() * 1.0
	EyePos = EyePos + OverridePos.y * EyeAngle:Forward() * 1.0
	EyePos = EyePos + OverridePos.z * EyeAngle:Up() * 1.0 

	return EyePos, EyeAngle

end)

--==================== Injection Welcome Message Thing

print("\n")
MsgC(Color(61, 149, 217), "████████╗██╗███╗░░░███╗███████╗██╗░██████╗  ██╗░░██╗░█████╗░░█████╗░██╗░░██╗\n╚══██╔══╝██║████╗░████║██╔════╝╚█║██╔════╝  ██║░░██║██╔══██╗██╔══██╗██║░██╔╝\n░░░██║░░░██║██╔████╔██║█████╗░░░╚╝╚█████╗░  ███████║███████║██║░░╚═╝█████═╝░\n░░░██║░░░██║██║╚██╔╝██║██╔══╝░░░░░░╚═══██╗  ██╔══██║██╔══██║██║░░██╗██╔═██╗░\n░░░██║░░░██║██║░╚═╝░██║███████╗░░░██████╔╝  ██║░░██║██║░░██║╚█████╔╝██║░╚██╗\n░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝╚══════╝░░░╚═════╝░  ╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝\n")

notification.AddLegacy("Successfully Loaded Nekowa.re - Welcome " .. LocalPlayer():Nick() .. " | " .. os.date("%I:%M %p"), NOTIFY_HINT, 5)
surface.PlaySound( "buttons/button15.wav" )
