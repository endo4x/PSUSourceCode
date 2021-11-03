--[[
	id: WB5jUXieCFot_c3aMinXC
	name: Mick_Shop
	description: .___  ___.  __    ______  __  ___ \n|   \\/   | |  |  /      ||  |/  / \n|  \\  /  | |  | |  ,----'|  '  /  \n|  |\\/|  | |  | |  |     |    <   \n|  |  |  | |  | |  `----.|  .  \\  \n|__|  |__| |__|  \\______||__|\\__\\ \n                                  
	time1: 2021-07-05 00:13:01.541185+00
	time2: 2021-07-05 00:13:01.541185+00
	uploader: qM-Jnj-6i0FFNdVXQYDMw11-OpX9F4pJUBMdwVv8
	uploadersession: 1CYO4PI2i6lbkmxTphRDoXjrMJEX_4
	flag: t
--]]

local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end
 
 
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
  
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    
    if car ~= 0 and (wasInCar or IsCar(car)) then
      wasInCar = true
             if isUiOpen == false and not IsPlayerDead(PlayerId()) then
                SendNUIMessage({
            	   displayWindow = 'true'
            	   })
                isUiOpen = true 			
            end

      if beltOn then DisableControlAction(0, 75) end

      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)
      
      if speedBuffer[2] ~= nil 
         and not beltOn
         and GetEntitySpeedVector(car, true).y > 1.0  
         and speedBuffer[1] > 19.25 
         and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
         
        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(1)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end
        
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
        
      if IsControlJustReleased(0, 29) and GetLastInputMethod(0) then
        beltOn = not beltOn 
        if beltOn then 
		  TriggerEvent('pNotify:SendNotification', {text = "<center><b style='color:green; font-size:12;'>คาดเข็มขัดนิรภัยแล้ว</font></center>", type = "success", timeout = 1400, layout = "bottomCenter"})
		  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'buckle', 0.9)
		  SendNUIMessage({
		    displayWindow = 'false'
		    })
		  isUiOpen = true 
		else 
		  TriggerEvent('pNotify:SendNotification', {text = "<center><b style='color:red; font-size:12;'>ปลดเข็มขัดนิรภัยแล้ว</font></center>", type = "error", timeout = 1400, layout = "bottomCenter"}) 
		  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'unbuckle', 0.9)
		  SendNUIMessage({
		     displayWindow = 'true'
		     })
		  isUiOpen = true  
		end
      end
      
    elseif wasInCar then
      wasInCar = false
      beltOn = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
             if isUiOpen == true and not IsPlayerDead(PlayerId()) then
                SendNUIMessage({
            	   displayWindow = 'false'
            	   })
                isUiOpen = false 
            end
    end
    
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if IsPlayerDead(PlayerId()) and isUiOpen == true then
            SendNUIMessage({
                    displayWindow = 'false'
               })
            isUiOpen = false
        end    

    end
end)   