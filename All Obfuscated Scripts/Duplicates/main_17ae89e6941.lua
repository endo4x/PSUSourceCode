--[[
	id: RoPeFi9BJNtSbdksF9ncy
	name: main
	description: test
	time1: 2021-06-02 20:08:57.118403+00
	time2: 2021-06-02 20:08:57.118404+00
	uploader: qEoMJSStLGW3TRux7QHMozHb29eOB2eWCeV25BgK
	uploadersession: qbP13Dg5jd2zaecMMLYrdE5PDWcOxh
	flag: f
--]]

local vals = script.Parent.Patterns
local buttons = script.Parent.Parent.Parent.Parent["Politie"].DriveSeat.EDSC.Control

script.Parent.LightEvent.OnServerEvent:Connect(function(player, st1, st2)
	if st1 == "BL" then
		if st2 == true then
			vals.DBL_on.Value = true
			vals.GRL_on.Value = true
			vals.WTD_on.Value = true
			vals.WTG_on.Value = true
		elseif st2 == false then
			vals.DBL_on.Value = false
			vals.GRL_on.Value = false
			vals.WTD_on.Value = false
			vals.WTG_on.Value = false	
		end					
		elseif st1 == "AM" then
		if st2 == true then
			vals.AMB_on.Value = true
			vals.DBL_on.Value = false
			vals.GRL_on.Value = false
			vals.WTD_on.Value = false
			vals.WTG_on.Value = false
			vals.SRN_on.Value = false
		elseif st2 == false then
			vals.AMB_on.Value = false
		end
	elseif st1 == "SR" then
		if st2 == true then
			vals.SRN_on.Value = true
			vals.DBL_on.Value = true
			vals.GRL_on.Value = true
			vals.WTD_on.Value = true
			vals.WTG_on.Value = true
		elseif st2 == false then
			vals.SRN_on.Value = false
		end
	end	
end)