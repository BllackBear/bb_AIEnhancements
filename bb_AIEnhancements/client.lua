-- Adjust the following values based on your preferences
local HighSpeedDrivingStyle = 786603 -- Driving style for higher speeds
local HighSpeedMaxCruiseSpeedIncrease = 2.0 -- Maximum cruise speed increase at higher speeds
local LowSpeedDrivingStyle = 1074528293 -- Driving style for lower speeds
local UpdateInterval = 1000 -- Delay between updates in milliseconds

-- Main loop
Citizen.CreateThread(function()
    while true do
        -- Get all vehicles in the world
        local vehicles = GetGamePool("CVehicle")

        for _, vehicle in ipairs(vehicles) do
            -- Check if the vehicle is AI-controlled
            if IsEntityAVehicle(vehicle) and not IsEntityDead(vehicle) and not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                -- Get the vehicle's speed
                local speed = GetEntitySpeed(vehicle)

                -- Adjust AI driving behavior based on the speed
                if speed > 15.0 then
                    SetDriveTaskDrivingStyle(vehicle, HighSpeedDrivingStyle)
                    SetDriveTaskMaxCruiseSpeed(vehicle, speed + HighSpeedMaxCruiseSpeedIncrease)
                else
                    SetDriveTaskDrivingStyle(vehicle, LowSpeedDrivingStyle)
                    SetDriveTaskMaxCruiseSpeed(vehicle, GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
                end
            end
        end

        Citizen.Wait(UpdateInterval)
    end
end)
