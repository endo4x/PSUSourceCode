--[[
	id: XjaxuQs_js5R2DWoAbWSX
	name: caca_st
	description: stg
	time1: 2021-05-05 20:22:27.541483+00
	time2: 2021-05-05 20:22:27.541484+00
	uploader: kUkTOL37Z_pljmMWprHM33zRuAnu1SjVlzRLXH-Q
	uploadersession: 2thCVY6KxT39gAp3dbufDY88XejIKb
	flag: f
--]]

currentStage = 0
currentVeh = nil
vehModel = nil

stageInstallProgress = -1

installingStage = 0

stageSpeeds = {
	[1] = 5,
	[2] = 9,
	[3] = 13,
	[4]	= 17,
	[5] = 21,
	[6] = 25
}

stageLoc = {115.65642547607,6605.7353515625,31.932878494263}
stagePWarp = {122.52454376221,6596.4438476563,31.999629974365,135.46794128418}

carSpawnLoc = {144.51370239258,6639.703125,31.583368301392,141.68730163574}

function tvRP.setCarCurrentStage(theStage)
	currentStage = tonumber(theStage)
end

function tvRP.deleteStargerCar()
	DeleteEntity(currentVeh)
	currentVeh = nil
end

function stages_DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function tvRP.applyCarStage(installStage, vehicleModel)
	currentVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	SetEntityCoords(currentVeh, stageLoc[1], stageLoc[2], stageLoc[3])
	FreezeEntityPosition(currentVeh, true)
	vehModel = vehicleModel
	Citizen.CreateThread(function()
		while DoesEntityExist(currentVeh) do
			Citizen.Wait(25)
			SetEntityHeading(currentVeh, GetEntityHeading(currentVeh)+1 %360)
			SetVehicleDoorOpen(currentVeh, 4, false)
		end
	end)
	SetVehicleDoorShut(currentVeh, 4, false)
	
	installingStage = installStage
	
	stageInstallProgress = 0
	
	SetEntityCoords(GetPlayerPed(-1), stagePWarp[1], stagePWarp[2], stagePWarp[3])
	SetEntityHeading(GetPlayerPed(-1), stagePWarp[4])
end

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 200)
        SetTextDropshadow(0, 0, 0, 0, 200)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if(installingStage ~= 0)then
			if(stageInstallProgress < 100)then
				stageInstallProgress = stageInstallProgress + 1
			elseif(stageInstallProgress == 100)then
				stageInstallProgress = 0
				vRPserver.applyStages({installingStage, vehModel})
				installingStage = 0
				SetEntityCoords(currentVeh, carSpawnLoc[1], carSpawnLoc[2], carSpawnLoc[3])
				SetEntityHeading(currentVeh, carSpawnLoc[4])
				FreezeEntityPosition(currentVeh, false)
				currentVeh = nil
				vehModel = nil
			end
		end
	end
end)

function stage_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(7)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if(GetDistanceBetweenCoords(coords.x, coords.y, coords.z, stageLoc[1], stageLoc[2], stageLoc[3], true) <= 25.0)then
			if(currentVeh ~= nil)then
				DrawText3D(stageLoc[1], stageLoc[2], stageLoc[3]+1.4, "~g~Instalare: ~y~Stage "..installingStage.."\n~g~Progres: ~r~"..stageInstallProgress.."%", 2.5, 1)
			else
				DrawText3D(stageLoc[1], stageLoc[2], stageLoc[3]+0.3, "~g~Instalare Stage-uri", 2.0, 7)
			end
			DrawMarker(1, stageLoc[1], stageLoc[2], stageLoc[3]-1.0, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 0.5, 0, 255, 0, 180, 0, 0, 0, 0)
			if(GetDistanceBetweenCoords(coords.x, coords.y, coords.z, stageLoc[1], stageLoc[2], stageLoc[3], true) <= 2.5)then
				veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				if(currentVeh == nil)then
					if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) and (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
						local ok, vtype, name = tvRP.getNearestOwnedVehicle(7)
						if ok then					
							stages_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a accesa meniul de ~g~Stage-uri")
							if(IsControlJustReleased(1, 51))then
								vRPserver.showCarStagesMenu({GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false))})
							end
						else
							stages_DisplayHelpText("~r~Pentru a pune stage-uri ai nevoie de o masina personala!")
						end
					else
						stages_DisplayHelpText("~r~~r~Pentru a pune stage-uri ai nevoie de o masina personala!")
					end
				else
					stages_DisplayHelpText("~r~Asteapta pana mecanicii termina de lucrat la masina de pe stand!")
				end
			end
		end
		
		veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) and (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			if(currentStage ~= 0)then
				stage_drawTxt(1.29, 1.43, 1.0,1.0,0.3, "~w~Stage: ~g~"..currentStage, 255, 255, 255, 255)
				SetVehicleEnginePowerMultiplier(veh, stageSpeeds[currentStage] + 0.001)
			end
		end
	end
end)