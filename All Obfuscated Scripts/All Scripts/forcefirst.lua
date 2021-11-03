--[[
	id: N6bMPMG58J78zPh-vnjt5
	name: forcefirst1
	description: ChubbyDev
	time1: 2021-05-28 22:20:54.370385+00
	time2: 2021-05-28 22:20:54.370386+00
	uploader: YA0nO7Jc5RClAPCp-trgMz-xoJknXCq9GiQzKjMf
	uploadersession: v02oULHj7BtVE4BTKih8kbv6Zqda5o
	flag: f
--]]

CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for _, iter in ipairs({1, 2, 3, 4, 6, 7, 8, 9, 13, 17, 18}) do
                HideHudComponentThisFrame(iter)
            end

            local ped = PlayerPedId()

            local inVehicle = IsPedInAnyVehicle(ped, false)
            if not show then
                HideHudComponentThisFrame(14)
                local aiming, shooting = IsControlPressed(0, 25), IsPedShooting(ped)
                if aiming or shooting then
                    if shooting and not aiming then
                        isShooting = true
                        aimTimer = 0
                    else
                        isShooting = false
                    end

                    if not isAiming then
                        isAiming = true

                        lastCamera = GetFollowPedCamViewMode()
                        if lastCamera ~= 4 then
                            SetFollowPedCamViewMode(4)
                        end
                    elseif GetFollowPedCamViewMode() ~= 4 then
                        SetFollowPedCamViewMode(4)
                    end
                elseif isAiming then
                    local off = true
                    if isShooting then
                        off = false
                        aimTimer = aimTimer + 20
                        if aimTimer == 3000 then
                            isShooting = false
                            aimTimer = 0
                            off = true
                        end
                    end

                    if off then
                        isAiming = false
                        if lastCamera ~= 4 then
                            SetFollowPedCamViewMode(lastCamera)
                        end
                    end
                elseif not inVehicle then
                    DisableControlAction(0, 24, true)
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 141, true)
                    DisableControlAction(0, 142, true)
                    DisableControlAction(0, 257, true)
                    DisableControlAction(0, 263, true)
                    DisableControlAction(0, 264, true)
                end
            end

            if inVehicle then
                local vehicle = GetVehiclePedIsIn(ped, false)
                if DoesVehicleHaveWeapons(vehicle) == 1 then
                    local vehicleWeapon, vehicleWeaponHash = GetCurrentPedVehicleWeapon(playerped)
                    if vehicleWeapon == 1 then
                        DisableVehicleWeapon(true, vehicleWeaponHash, vehicle, playerPed)
                        SetCurrentPedVehicleWeapon(playerPed, 0xA2719263)
                    end
                end

                DisableControlAction(0, 354, true)
                DisableControlAction(0, 351, true)
                DisableControlAction(0, 350, true)
                DisableControlAction(0, 357, true)
            end
        end
    end
)
