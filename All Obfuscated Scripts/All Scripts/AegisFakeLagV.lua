--[[
	id: j6jsAKr8u90Jq35krRGL4
	name: AegisFakeLagV01
	description: AegisFakeLagV01
	time1: 2021-06-10 13:04:55.139215+00
	time2: 2021-06-10 13:04:55.139217+00
	uploader: 1MZZVPT0tsVlgj051NaNLe7l9doxVJqrAji2UzZr
	uploadersession: ow6ifAGCQJKn1m1rOvhPpKVpwEu_jr
	flag: f
--]]

local MainMenu = {"AA","Fake lag"}

local function HSV_RGB(h, s, v, a)
    local r, g, b
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return r * 255, g * 255, b * 255, a * 255
end
local function rgb(speed, r_g_b)
    local r, g, b, a = HSV_RGB(globals.realtime() * speed, 1, 1, 1)
    r = r * r_g_b
    g = g * r_g_b
    b = b * r_g_b
    return r, g, b
end

local function isInAir()
    local fv = entity.get_prop(entity.get_local_player(), "m_flFallVelocity")
    if fv < -1 or fv > 1 then
        return true
    end
    return false
end

local function log(s)
	local r,g,b = rgb(50,1)
    client.color_log(r, g, b, "[AegisFakeLag]: " .. s .. " ")
end

log("Welcome To AegisFakeLag _VERSION 0.1 BATE")
log("Welcome To AegisFakeLag _VERSION 0.1 BATE")
log("Welcome To AegisFakeLag _VERSION 0.1 BATE")

local Skeet_FakeLag_CFG = {
	Amount = {"Dynamic","Maximum","Fluctuate"}
}

local Base_FakeLag = {
	["Player Static"] = {},
	["Player Move"] = {},
	["Air"] = {},
	["Duck"] = {},
	["Peek"] = {},
	["Attack"] = {}
}

--[[ 隐藏 ]]
local function setWeaponsV(ModeName, v)
	ui.set_visible(Base_FakeLag[ModeName].END, v)

	ui.set_visible(Base_FakeLag[ModeName].Amount_1, v)
	ui.set_visible(Base_FakeLag[ModeName].Variance_1, v)
	ui.set_visible(Base_FakeLag[ModeName].Limit_1, v)

	if ModeName == "Attack" then
		v = false
	end

	ui.set_visible(Base_FakeLag[ModeName].Amount_2, v)
	ui.set_visible(Base_FakeLag[ModeName].Variance_2, v)
	ui.set_visible(Base_FakeLag[ModeName].Limit_2, v)

	ui.set_visible(Base_FakeLag[ModeName].Amount_3, v)
	ui.set_visible(Base_FakeLag[ModeName].Variance_3, v)
	ui.set_visible(Base_FakeLag[ModeName].Limit_3, v)

	ui.set_visible(Base_FakeLag[ModeName].Amount_4, v)
	ui.set_visible(Base_FakeLag[ModeName].Variance_4, v)
	ui.set_visible(Base_FakeLag[ModeName].Limit_4, v)

	ui.set_visible(Base_FakeLag[ModeName].Amount_5, v)
	ui.set_visible(Base_FakeLag[ModeName].Variance_5, v)
	ui.set_visible(Base_FakeLag[ModeName].Limit_5, v)


end

local Reference = {
	Amount = ui.reference(MainMenu[1], MainMenu[2], "Amount"),
	Variance =  ui.reference(MainMenu[1], MainMenu[2], "Variance"),
	limit = ui.reference(MainMenu[1], MainMenu[2], "Limit"),
	Duck = ui.reference("RAGE", "Other", "Duck peek assist"),
}

local Aegis_FakeLag_Enabled = ui.new_checkbox(MainMenu[1], MainMenu[2], "Enable Aegis Fake Lag")

local Lag_Mode_Groups = {"Player Static","Player Move","Air","Duck","Peek","Attack"}

local Aegis_FakeLag_Player_Static = ui.new_checkbox(MainMenu[1], MainMenu[2], "FakeLag Player Static")
local Aegis_FakeLag_Player_Move = ui.new_checkbox(MainMenu[1], MainMenu[2], "FakeLag Player Move")
local Aegis_FakeLag_Attack = ui.new_checkbox(MainMenu[1], MainMenu[2], "FakeLag Attack")
local Aegis_FakeLag_Air = ui.new_checkbox(MainMenu[1], MainMenu[2], "FakeLag Air")
local Aegis_FakeLag_Duck = ui.new_checkbox(MainMenu[1], MainMenu[2], "FakeLag Duck")
local Aegis_FakeLag_Peek = ui.new_checkbox(MainMenu[1], MainMenu[2], "FakeLag Peek")
local Aegis_FakeLag_Peek_key = ui.new_hotkey(MainMenu[1], MainMenu[2], "FakeLag Peek key", true)


local Aegis_FakeLag_GroupList = ui.new_combobox(MainMenu[1], MainMenu[2], "FakeLag Mode Groups", Lag_Mode_Groups)





for i=1,#Lag_Mode_Groups do
	Base_FakeLag[Lag_Mode_Groups[i]].END = ui.new_checkbox(MainMenu[1], MainMenu[2], "Enable " .. Lag_Mode_Groups[i] .. " CFG")
	Base_FakeLag[Lag_Mode_Groups[i]].Amount_1 = ui.new_combobox(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Amount (X1)",Skeet_FakeLag_CFG.Amount)
	Base_FakeLag[Lag_Mode_Groups[i]].Variance_1 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Variance (X1)",0,100)
	Base_FakeLag[Lag_Mode_Groups[i]].Limit_1 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Limit (X1)",1,15)

	Base_FakeLag[Lag_Mode_Groups[i]].Amount_2 = ui.new_combobox(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Amount (X2)",Skeet_FakeLag_CFG.Amount)
	Base_FakeLag[Lag_Mode_Groups[i]].Variance_2 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Variance (X2)",0,100)
	Base_FakeLag[Lag_Mode_Groups[i]].Limit_2 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Limit (X2)",1,15)

	Base_FakeLag[Lag_Mode_Groups[i]].Amount_3 = ui.new_combobox(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Amount (X3)",Skeet_FakeLag_CFG.Amount)
	Base_FakeLag[Lag_Mode_Groups[i]].Variance_3 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Variance (X3)",0,100)
	Base_FakeLag[Lag_Mode_Groups[i]].Limit_3 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Limit (X3)",1,15)

	Base_FakeLag[Lag_Mode_Groups[i]].Amount_4 = ui.new_combobox(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Amount (X4)",Skeet_FakeLag_CFG.Amount)
	Base_FakeLag[Lag_Mode_Groups[i]].Variance_4 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Variance (X4)",0,100)
	Base_FakeLag[Lag_Mode_Groups[i]].Limit_4 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Limit (X4)",1,15)

	Base_FakeLag[Lag_Mode_Groups[i]].Amount_5 = ui.new_combobox(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Amount (X5)",Skeet_FakeLag_CFG.Amount)
	Base_FakeLag[Lag_Mode_Groups[i]].Variance_5 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Variance (X5)",0,100)
	Base_FakeLag[Lag_Mode_Groups[i]].Limit_5 = ui.new_slider(MainMenu[1], MainMenu[2],Lag_Mode_Groups[i].." Limit (X5)",1,15)

	setWeaponsV(Lag_Mode_Groups[i], false)
end


--[[ MainEnabled ]]
ui.set_callback(Aegis_FakeLag_Enabled, function()
	ui.set_visible(Aegis_FakeLag_GroupList, ui.get(Aegis_FakeLag_Enabled))
	ui.set_visible(Aegis_FakeLag_Player_Static, ui.get(Aegis_FakeLag_Enabled))
	ui.set_visible(Aegis_FakeLag_Player_Move, ui.get(Aegis_FakeLag_Enabled))
	ui.set_visible(Aegis_FakeLag_Attack, ui.get(Aegis_FakeLag_Enabled))
	ui.set_visible(Aegis_FakeLag_Air, ui.get(Aegis_FakeLag_Enabled))
	ui.set_visible(Aegis_FakeLag_Duck, ui.get(Aegis_FakeLag_Enabled))
	ui.set_visible(Aegis_FakeLag_Peek, ui.get(Aegis_FakeLag_Enabled))
	ui.set_visible(Aegis_FakeLag_Peek_key, ui.get(Aegis_FakeLag_Enabled))
	
	if not ui.get(Aegis_FakeLag_Enabled) then
		-- body
		for i=1,#Lag_Mode_Groups do
			setWeaponsV(Lag_Mode_Groups[i], false)
		end
	end
end)





local function upUI()
	for i=1,#Lag_Mode_Groups do
		if Lag_Mode_Groups[i] ~= ui.get(Aegis_FakeLag_GroupList) then
			setWeaponsV(Lag_Mode_Groups[i], false)
		end
	end
	setWeaponsV(ui.get(Aegis_FakeLag_GroupList), true)
end




local function refAUTOUI() 
	setWeaponsV("Player Static", ui.get(Aegis_FakeLag_Player_Static))
	setWeaponsV("Player Move", ui.get(Aegis_FakeLag_Player_Move))
	setWeaponsV("Air", ui.get(Aegis_FakeLag_Air))
	setWeaponsV("Duck", ui.get(Aegis_FakeLag_Duck))
	setWeaponsV("Peek", ui.get(Aegis_FakeLag_Peek))
	setWeaponsV("Attack", ui.get(Aegis_FakeLag_Attack))
end
ui.set_callback(Aegis_FakeLag_GroupList, function()
	refAUTOUI()
	upUI()
end)

upUI()
refAUTOUI()

ui.set_callback(Aegis_FakeLag_Player_Static,function ()
	refAUTOUI()
end)
ui.set_callback(Aegis_FakeLag_Player_Move,function ()
	refAUTOUI()
end)
ui.set_callback(Aegis_FakeLag_Air,function ()
	refAUTOUI()
end)
ui.set_callback(Aegis_FakeLag_Duck,function ()
	refAUTOUI()
end)
ui.set_callback(Aegis_FakeLag_Peek,function ()
	refAUTOUI()
end)
ui.set_callback(Aegis_FakeLag_Attack,function ()
	refAUTOUI()
end)


local PlayerX,PlayerY,PlayerZ


client.set_event_callback("setup_command", function() 
    if not ui.get(Aegis_FakeLag_Enabled) or not entity.is_alive(entity.get_local_player()) then
        return
    end
	local uOP = math.random(1,5)
	local var_Amount,var_Variance,var_Limit
	local ov_mode = "Player Static"
	local vPlayerX,vPlayerY,vPlayerZ
	if vPlayerX ~= PlayerX then
		if ui.get(Aegis_FakeLag_Player_Move) then
			ov_mode = "Player Move"
		end
	end
	PlayerX,PlayerY,PlayerZ = entity.get_origin(entity.get_local_player())

	if ui.get(Aegis_FakeLag_Air) and isInAir() then
		ov_mode = "Air"
	end

	if ui.get(Aegis_FakeLag_Duck) and ui.get(Reference.Duck) then
		ov_mode = "Duck"
	end

	if ui.get(Aegis_FakeLag_Peek) and ui.get(Aegis_FakeLag_Peek_key) then
		ov_mode = "Peek"
	end

	if ov_mode == "Player Move" then
		if not ui.get(Aegis_FakeLag_Player_Static) then
			return
		end
	end
	
	if uOP == 1 then
		var_Amount = ui.get(Base_FakeLag[ov_mode].Amount_1)
		var_Variance = ui.get(Base_FakeLag[ov_mode].Variance_1)
		var_Limit = ui.get(Base_FakeLag[ov_mode].Limit_1)
	end
	if uOP == 2 then
		var_Amount = ui.get(Base_FakeLag[ov_mode].Amount_2)
		var_Variance = ui.get(Base_FakeLag[ov_mode].Variance_2)
		var_Limit = ui.get(Base_FakeLag[ov_mode].Limit_2)
	end
	if uOP == 3 then
		var_Amount = ui.get(Base_FakeLag[ov_mode].Amount_3)
		var_Variance = ui.get(Base_FakeLag[ov_mode].Variance_3)
		var_Limit = ui.get(Base_FakeLag[ov_mode].Limit_3)
	end
	if uOP == 4 then
		var_Amount = ui.get(Base_FakeLag[ov_mode].Amount_4)
		var_Variance = ui.get(Base_FakeLag[ov_mode].Variance_4)
		var_Limit = ui.get(Base_FakeLag[ov_mode].Limit_4)
	end
	if uOP == 5 then
		var_Amount = ui.get(Base_FakeLag[ov_mode].Amount_5)
		var_Variance = ui.get(Base_FakeLag[ov_mode].Variance_5)
		var_Limit = ui.get(Base_FakeLag[ov_mode].Limit_5)
	end

	ui.set(Reference.Amount, var_Amount)
	ui.set(Reference.Variance, var_Variance)
	ui.set(Reference.limit, var_Limit)
end)

client.set_event_callback("weapon_fire", function(e) 
	local localplayer = entity.get_local_player()
	if not client.userid_to_entindex(e.userid) == localplayer then
		return
	end
	if not ui.get(Aegis_FakeLag_Attack) then
		return
	end
	local var_Amount = ui.get(Base_FakeLag["Attack"].Amount_1)
	local var_Variance = ui.get(Base_FakeLag["Attack"].Variance_1)
	local var_Limit = ui.get(Base_FakeLag["Attack"].Limit_1)
	ui.set(Reference.Amount, var_Amount)
	ui.set(Reference.Variance, var_Variance)
	ui.set(Reference.limit, var_Limit)
end)

--[[ gongji ]]
--[[ 
	静止不动 [Player Static]   [5种] [动态随机]
	移动时   [Player Move]     [5种] [动态随机]
	空中时   [Air]             [5种] [动态随机]
	假蹲时   [Duck]            [5种] [动态随机]
	Peek时   [Peek]            [5种] [动态随机]
	开枪时   [Attack]          [5种] [动态随机]
 ]]






