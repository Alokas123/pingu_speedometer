function round(n)
    return math.floor(n * 10 + 0.5) / 10
end

function pyorisus(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

lib.onCache('vehicle', function(vehicle)
    if vehicle then
        CreateThread(function()
            while cache.vehicle do
                Wait(100)
                if GetIsVehicleEngineRunning(cache.vehicle) then
                    if Config.Speedo == 'kmh' then
                    local speed = pyorisus(GetEntitySpeed(cache.vehicle) * 3.6)
                    local fuel = round(GetVehicleFuelLevel(cache.vehicle), 1)
                    lib.showTextUI(('%s km/h     \n     bensaa: %s'):format(speed, fuel), {
                        position = "right-center",
                        icon = 'tachometer',
                    })
                    elseif Config.Speedo == 'mph' then
                        local speed = pyorisus(GetEntitySpeed(cache.vehicle) * 2.23694)
                        local fuel = round(GetVehicleFuelLevel(cache.vehicle), 1)
                        lib.showTextUI(('%s MPH     \n     Fuel: %s'):format(speed, fuel), {
                            position = "right-center",
                            icon = 'tachometer',
                        })
                    else return
                    end
                end
            end
            lib.hideTextUI()
        end)
    end
end)
