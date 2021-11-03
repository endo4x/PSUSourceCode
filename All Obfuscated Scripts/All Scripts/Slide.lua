--[[
	id: nlcp_w4KtB0aC9KrOFLlx
	name: Slide
	description: Slide z
	time1: 2021-07-04 01:22:40.269952+00
	time2: 2021-07-04 01:22:40.269953+00
	uploader: fQ6CKou_mkGdyDJR3XWxLXn4zBXIL284gBWUk0La
	uploadersession: i5_w1VPL0EWOBb_Y7Hec6vK9ZxT0Sy
	flag: f
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


local timeLeft = Config["TimeGod"]
local godslide = false

RegisterNetEvent(GetCurrentResourceName()..":activeGod")
AddEventHandler(GetCurrentResourceName()..":activeGod", function()

	if not godslide then
		godslide = true
		timeLeft = Config["TimeGod"]

		Citizen.CreateThread(function() 
			while timeLeft > 0 do 

				timeLeft = timeLeft - 1
	
				if timeLeft <= 0 then
					godslide = false

				end
				Wait(1000)

			end
		end)
	
	
	
	
		Citizen.CreateThread(function() 
			while true do
			Wait(0)
			
				if timeLeft > 10 then
	
					DrawAdvancedNativeText(1.0235, 0.80755, 0.005, 0.0028, 0.464, "~y~TIME :~s~", 255, 255, 255, 255, 0, 0)

					DrawAdvancedNativeText(1.0525, 0.80755, 0.005, 0.0028, 0.464, ("~y~".. SecondsToClock(timeLeft) .."~s~"), 255, 255, 255, 255, 0, 0)
				elseif timeLeft	> 0 and timeLeft <= 10 then			
					DrawAdvancedNativeText(1.0235, 0.80755, 0.005, 0.0028, 0.464, "~r~TIME :~s~", 255, 255, 255, 255, 0, 0)

					DrawAdvancedNativeText(1.0525, 0.80755, 0.005, 0.0028, 0.464, ("~r~".. SecondsToClock(timeLeft) .."~s~"), 255, 255, 255, 255, 0, 0)
				end


				if timeLeft <= 0 then
					godslide = false
					break
				end
	
			end
		end)


	else
		timeLeft = timeLeft + Config["AddTime"]
		
	end

end)


function SecondsToClock(seconds)
	if seconds <= 0 then
		return "00:00";
	else
		mins = string.format("%02.f", math.floor(seconds / 60 - (math.floor(seconds / 3600) * 60)));
		secs = string.format("%02.f", math.floor(seconds - math.floor(seconds / 3600) * 3600 - mins * 60));
		return mins .. ":" .. secs
	end
end


function DrawAdvancedNativeText(x,y,w,h,sc, text, r,g,b,a,jus)
    SetTextFont(4)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(254, 254, 254, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		
		local ped = GetPlayerPed(-1)
		local ad = "missheistfbi3b_ig6_v2"
		local anim = "rubble_slide_gunman"

		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) and IsPedSprinting(ped) then

				if IsControlPressed(0, 141) then
				
					loadAnimDict(ad)
					SetPedMoveRateOverride(ped, 1.25)
					ClearPedSecondaryTask(ped)
					TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)

					if godslide then
						ApplyForceToEntityCenterOfMass(ped, 1, 35.0, 35.0, 0.8+5, true, true, true, true)
					else
						ApplyForceToEntityCenterOfMass(ped, 1, 0, 12.8, 0.8, true, true, true, true)
					end
				
					local particleDictionary = "core"
					local particleName = "ent_brk_sparking_wires_sp"
					local particleDictionary2 = "scr_trevor1"
					local particleName2 = "scr_trev1_trailer_boosh"

					local loopAmount = 1
					Wait(250)

					if godslide then
						RequestNamedPtfxAsset(particleDictionary2)
		
						while not HasNamedPtfxAssetLoaded(particleDictionary2) do
							Citizen.Wait(0)
						end
					else
						RequestNamedPtfxAsset(particleDictionary)
		
						while not HasNamedPtfxAssetLoaded(particleDictionary) do
							Citizen.Wait(0)
						end
					end
					
					local particleEffects = {}
					for x=0,loopAmount do
						if godslide then
							SetPtfxAssetNextCall(particleDictionary2)
						else
							SetPtfxAssetNextCall(particleDictionary)
						end

						if godslide then
							local particle = StartNetworkedParticleFxNonLoopedOnPedBone(particleName2,PlayerPedId(),0,0,0,0.0,0.0,0.0,24806,0.5,0,0,0)
						else
							local particle = StartNetworkedParticleFxNonLoopedOnPedBone(particleName,PlayerPedId(),0,0,0,0.0,0.0,0.0,24806,0.5,0,0,0)
						end
						table.insert(particleEffects, 1, particle)

						Citizen.Wait(0)
					end
	
					Citizen.Wait(80)
					for _,particle in pairs(particleEffects) do
	
						StopParticleFxLooped(particle, true)
						StopParticleFxLooped(particle2, true)
					end
					
					TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
					ClearPedSecondaryTask(ped)
					Wait(5000)


				end

			end
		end
	end

end)

function CheckItem (item_name)

	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  if item_name == item.name and item.count > 0 then

		return true
	  end
	end

	return false
end



function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end