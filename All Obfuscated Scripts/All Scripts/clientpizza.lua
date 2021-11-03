--[[
	id: B-htf3rl3RBFUFWvqkDXv
	name: client-pizza
	description: client-pizza
	time1: 2021-06-11 13:57:57.58418+00
	time2: 2021-06-11 13:57:57.584181+00
	uploader: CPUG6VTvptq0yUHZMqFjxaXUceBN5FGMrRUsQ6ST
	uploadersession: ViA8IomNgnZ5bOlTCpE1Puo4WP439R
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
feijontsPizza = Tunnel.getInterface("feijonts_pizza")
vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")
------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------
local ComecarTrabalho = {-563.4,285.94,85.38}
local MotoSpawn = {-560.22,301.56,83.16}
local Recepcao = {-564.22,278.24,83.14}
local Bar = {-560.33,284.67,82.18}
------------------------------------------------------------------------------------------------------------
-- ROTAS
------------------------------------------------------------------------------------------------------------
local Entregas = {
	[1] = {['x'] = -310.44, ['y'] = 222.52, ['z'] = 87.93 }, 
	[2] = {['x'] = 325.97, ['y'] = 537.32, ['z'] = 153.86 }, 
	[3] = {['x'] = 641.36, ['y'] = 260.97, ['z'] = 103.3 }, 
	[4] = {['x'] = 1394.67, ['y'] = 1141.7, ['z'] = 114.62 }, 
	[5] = {['x'] = 1172.24, ['y'] = -377.0, ['z'] = 68.23 }, 
	[6] = {['x'] = 321.35, ['y'] = -197.54, ['z'] = 54.23 }, 
	[7] = {['x'] = 1139.28, ['y'] = -961.8, ['z'] = 47.53 }, 
	[8] = {['x'] = 1331.98, ['y'] = -1642.09, ['z'] = 52.12 }, 
	[9] = {['x'] = -1750.11, ['y'] = -697.2, ['z'] = 10.18 }, 
	[10] = {['x'] = -1269.35, ['y'] = -1296.04, ['z'] = 4.01 }, 
	[11] = {['x'] = -142.26, ['y'] = -1697.98, ['z'] = 30.77 }, 
	[12] = {['x'] = -20.52, ['y'] = -1858.37, ['z'] = 25.41 }, 
	[13] = {['x'] = 279.57, ['y'] = -2043.29, ['z'] = 19.77 }, 
	[14] = {['x'] = -1960.8, ['y'] = 212.11, ['z'] = 86.81 }, 
	[15] = {['x'] = -1673.05, ['y'] = 386.2, ['z'] = 89.35 }, 
	[16] = {['x'] = -773.5, ['y'] = 311.87, ['z'] = 85.7 }, 
	[17] = {['x'] = 318.23, ['y'] = 562.0, ['z'] = 154.54 }, 
	[18] = {['x'] = 659.57, ['y'] = 593.24, ['z'] = 129.06 }, 
	[19] = {['x'] = 1385.73, ['y'] = -593.04, ['z'] = 74.49 }, 
	[20] = {['x'] = -1130.17, ['y'] = 783.98, ['z'] = 163.89 }, 
	[21] = {['x'] = -746.9, ['y'] = 808.6, ['z'] = 215.03 }, 
	[22] = {['x'] = -185.25, ['y'] = 591.67, ['z'] = 197.83 }, 
	[23] = {['x'] = -1643.7, ['y'] = -988.15, ['z'] = 13.02 }, 
	[24] = {['x'] = -294.72, ['y'] = -828.3, ['z'] = 32.42 }, 
	[25] = {['x'] = -1750.25, ['y'] = -697.0, ['z'] = 10.18 }, 
	[26] = {['x'] = 736.61,	['y'] = 132.46,	['z'] = 80.72},
	[27] = {['x'] = 814.87,	['y'] = -1636.05,['z'] = 30.99},
	[28] = {['x'] = -1383.27,['y'] = 266.98,['z'] = 61.24},
	[29] = {['x'] = -746.92,['y'] = 808.73,['z'] = 214.82},
	[30] = {['x'] = -430.16,['y'] = 1204.82,['z'] = 325.76}
}
------------------------------------------------------------------------------------------------------------
-- CÓDIGO
------------------------------------------------------------------------------------------------------------
local etapa = 0
local trabalhando = false
local pizzasNaMoto = 0
local entrega = false
local blip = false
local pizzaNaMao = false
local sorteado = math.random(1, #Entregas)

Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
		local ped = PlayerPedId()
        if etapa == 0 and not trabalhando then 
            local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), ComecarTrabalho[1], ComecarTrabalho[2], ComecarTrabalho[3], true)
			if dist < 15 then
				timeDistance = 4
                DrawMarker(21,ComecarTrabalho[1], ComecarTrabalho[2], ComecarTrabalho[3],0,0,0,0,0,0,0.5,0.5,0.5,235, 209, 66,150,1,0,0,1)	
				if dist <= 0.6 then
					timeDistance = 4
					DrawText3D(ComecarTrabalho[1], ComecarTrabalho[2], ComecarTrabalho[3], "PRESSIONE ~y~[E] ~w~PARA COMEÇAR A TRABALHAR", 255,255,255)
					if IsControlJustPressed(0,38) then
						timeDistance = 4
						vRP.CarregarObjeto("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",49,60309)
						FreezeEntityPosition(ped, true)
						Wait(3000)
						FreezeEntityPosition(ped, false)
						ClearPedTasksImmediately(ped)
						vRP._DeletarObjeto()
						trabalhando = true
						TriggerEvent('Notify','sucesso','Você entrou em serviço na: <b>Pizzaria</b>')
						etapa = 1
					end
                end
            end
		end
		
		if etapa == 1 then
			timeDistance = 1
			local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), Recepcao[1], Recepcao[2], Recepcao[3], true)
			DrawMarker(21,Recepcao[1], Recepcao[2], Recepcao[3],0,0,0,0,0,0,0.5,0.5,0.5,235, 209, 66,150,1,0,0,1)	
			drawTxt("VÁ ATÉ A RECEPÇÃO E SOLICITE SUA ~g~MOTO DE SERVIÇO", 4,0.5,0.97,0.50,255,255,255,180)
			if dist <= 0.6 then
				timeDistance = 1
				DrawText3D(Recepcao[1], Recepcao[2], Recepcao[3], "PRESSIONE ~y~[E] ~w~PARA SOLICITAR SUA MOTO", 255,255,255)
				if IsControlJustPressed(0,38) then -- [E]
					timeDistance = 4
					if not IsAnyVehicleNearPoint(MotoSpawn[1], MotoSpawn[2], MotoSpawn[3]-1, 20) then
						etapa = 2
						SpawnMoto()
					else
						TriggerEvent('Notify','negado','Livre a área antes de solicitar sua moto de serviço.')
					end
				end
			end
		end
		if etapa == 2 then
			timeDistance = 2
			local posMotinha = GetEntityCoords(motinha)
			DrawMarker(0,posMotinha[1], posMotinha[2], posMotinha[3]+1.6,0,0,0,0,0,0,0.5,0.5,0.5,235, 209, 66,200,1,0,0,1)
			if GetVehiclePedIsIn(ped, false) == motinha and GetPedInVehicleSeat(motinha,-1) == ped then
				timeDistance = 2
				etapa = 3
			end
		end
		if etapa == 3 then
			timeDistance = 2
			local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), Bar[1], Bar[2], Bar[3], true)
			DrawMarker(21,Bar[1], Bar[2], Bar[3],0,0,0,0,0,0,0.5,0.5,0.5,235, 209, 66,150,1,0,0,1)	
			drawTxt("VÁ ATÉ O OUTRO LADO E PEGUE O ~g~PEDIDO", 4,0.5,0.97,0.50,255,255,255,180)
			if dist <= 0.5 then
				timeDistance = 4
				DrawText3D(Bar[1], Bar[2], Bar[3], "PRESSIONE ~y~[E] ~w~PARA PEGAR O PEDIDO", 255,255,255)
				if IsControlJustPressed(0, 38) then
					timeDistance = 4
					FreezeEntityPosition(ped, true)
					SetEntityCoords(ped, Bar[1], Bar[2], Bar[3]-1)
					SetEntityHeading(ped, 76.00)
					Wait(200)
					vRP._playAnim(false,{{"pickup_object","pickup_low"}},false)
					Wait(2000)
					vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,28422, 0.0, -0.15, -0.15, 0.0, 0.0, 0.0)
					loaddict("anim@heists@box_carry@")
					TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
					FreezeEntityPosition(ped, false)
					etapa = 4
				end
			end
		end
		if etapa == 4 then
			timeDistance = 4
			local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(motinha), true)
			local xm, ym, zm = table.unpack(GetEntityCoords(motinha))
			if pizzasNaMoto + 1 <= 3 then
				timeDistance = 4
				drawTxt("CARREGUE A ~y~MOTO ~w~COM O PEDIDO", 4,0.5,0.97,0.50,255,255,255,180)
				if dist <= 1 then
					timeDistance = 4
					DrawText3D(xm, ym, zm, "PRESSIONE ~y~[E] ~w~PARA CARREGAR A MOTO", 255,255,255)
					if IsControlJustPressed(0, 38) then
						timeDistance = 4
						if pizzasNaMoto == 0 then
							pizzinha1 = CreateObject(GetHashKey("prop_pizza_box_02"),0,0,0,true,true,true)
							AttachEntityToEntity(pizzinha1,motinha,GetEntityBoneIndexByName(motinha,"platelight"),0.0,0.25,0.2,0.0,0.0,0.0,false,false,false,true,2,true)
							-- print('Colocada 1')
							etapa = 3
						elseif pizzasNaMoto == 1 then
							timeDistance = 4
							pizzinha2 = CreateObject(GetHashKey("prop_pizza_box_02"),0,0,0,true,true,true)
							AttachEntityToEntity(pizzinha2,motinha,GetEntityBoneIndexByName(motinha,"platelight"),0.0,0.25,0.26,0.0,0.0,0.0,false,false,false,true,2,true)
							-- print('Colocada 2')
							etapa = 3
						elseif pizzasNaMoto == 2 then
							timeDistance = 4
							pizzinha3 = CreateObject(GetHashKey("prop_pizza_box_02"),0,0,0,true,true,true)
							AttachEntityToEntity(pizzinha3,motinha,GetEntityBoneIndexByName(motinha,"platelight"),0.0,0.25,0.32,0.0,0.0,0.0,false,false,false,true,2,true)
							-- print('Colocada 3')
						end
						pizzasNaMoto = pizzasNaMoto + 1
						ClearPedTasksImmediately(ped)
						vRP._DeletarObjeto()
					end
				end
			else
				etapa = 5
				TriggerEvent('Notify','importante','Você pegou pedidos suficentes, vá entregá-los.')
			end 
		end
		if etapa == 5 then
			timeDistance = 4
			local xm, ym, zm = table.unpack(GetEntityCoords(motinha))
			if pizzasNaMoto > 0 then
				timeDistance = 4
				local distMoto = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(motinha), true)
				local distPonto = GetDistanceBetweenCoords(GetEntityCoords(ped), Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z, true)
				if not blip then
					CriandoBlip(Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z)
					blip = true
				end

				if distPonto < 15 then
					timeDistance = 4
					DrawMarker(21,Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z,0,0,0,0,0,0,0.5,0.5,0.5, 235, 209, 66, 255, 1,0,0,1)
					if distPonto < 1.5 and pizzaNaMao then
						timeDistance = 4
						DrawText3D(Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z, "PRESSIONE ~y~[E] ~w~PARA ENTREGAR O PEDIDO", 255,255,255)
						if IsControlJustPressed(0,38) then
							timeDistance = 4
							ClearPedTasksImmediately(ped)
							vRP._DeletarObjeto()
							vRP._playAnim(false,{{"pickup_object","pickup_low"}},false)
							feijontsPizza.gerarRecompensa()
							Wait(2000)
							DeleteObject(pizzaNoChao)
							sorteado = math.random(1, #Entregas)
							pizzaNaMao = false
							pizzasNaMoto = pizzasNaMoto - 1
							if blip then
								RemoveBlip(blips)
								blip = false
							end
							
						end
					end
				end

				if distMoto <= 1.5 and not pizzaNaMao and not IsPedInVehicle(ped, motinha, false) then
					timeDistance = 4
					DrawText3D(xm, ym, zm, "PRESSIONE ~y~[E] ~w~PARA PEGAR A PIZZA", 255,255,255)
					if IsControlJustPressed(0, 38) then
						timeDistance = 4
						if pizzasNaMoto == 3 then
							DeleteObject(pizzinha3)
						elseif pizzasNaMoto == 2 then
							DeleteObject(pizzinha2)
						elseif pizzasNaMoto == 1 then
							DeleteObject(pizzinha1)
						end
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,28422, 0.0, -0.15, -0.15, 0.0, 0.0, 0.0)
						loaddict("anim@heists@box_carry@")
						TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
						pizzaNaMao = true
					end
				end
			else
				-- VOLTA PRA PEGAR MAIS PIZZA
				etapa = 3
				TriggerEvent('Notify','aviso','Você acabou as entregas, volte até o restaurante para pegar mais pedidos.')
			end
		end
		Citizen.Wait(timeDistance)
    end
end)
------------------------------------------------------------------------------------------------------------
-- CANCELAR
------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local ped = PlayerPedId()
    while true do
        local timeDistance = 500
		if trabalhando then
			timeDistance = 4
			if IsControlJustPressed(0, 168) then -- [F7]
				timeDistance = 4
				trabalhando = false
				etapa = 0
				TriggerEvent('Notify','aviso','Você saiu de serviço da: <b>Pizzaria</b>')
				if DoesEntityExist(motinha) then                                
					SetEntityAsMissionEntity(motinha,true,true)
					deleteCar(motinha)
				end
				FreezeEntityPosition(ped, false)
				ClearPedTasksImmediately(ped)
				vRP._DeletarObjeto()
				if DoesEntityExist(pizzinha1) then
					DeleteObject(pizzinha1)
					DeleteObject(pizzinha2)
					DeleteObject(pizzinha3)
				end
				if blip then
					RemoveBlip(blips)
					blip = false
				end
				pizzasNaMoto = 0
			end
		end
		Citizen.Wait(timeDistance)
    end
end)
------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
------------------------------------------------------------------------------------------------------------
function CriandoBlip(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,162)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega")
	EndTextCommandSetBlipName(blips)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.35, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 55, 55, 55, 68)
    end
end

function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(10)
	end
end

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function SpawnMoto()
    local mhash = GetHashKey('pcj')
    modelRequest('pcj')
    motinha = CreateVehicle(mhash,MotoSpawn[1], MotoSpawn[2], MotoSpawn[3]-1,52.65,true,false)
	DecorSetInt(nveh,"GamemodeCar",955)
    SetVehicleHasBeenOwnedByPlayer(motinha,true)
    SetVehicleNumberPlateText(motinha,vRP.getRegistrationNumber())
    SetVehicleOnGroundProperly(motinha)
    SetEntityAsMissionEntity(motinha,true,true)
    SetModelAsNoLongerNeeded(mhash)
end