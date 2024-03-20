carhud = true

RegisterCommand(p.command, function(source, args, rawCommand)
    if carhud then
        carhud = false
        lib.notify({
            title = p.turnedoff,
            type = 'success'
        })
    else
        carhud = true
        lib.notify({
            title = p.turnedon,
            type = 'success'
        })
    end
end)


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
                    if p.speedo == 'kmh' and carhud then
                        local speed = pyorisus(GetEntitySpeed(cache.vehicle) * 3.6)
                        local fuel = round(GetVehicleFuelLevel(cache.vehicle), 1)
                        if p.usefuel then
                            lib.showTextUI(('%s km/h     \n     %s: %s'):format(speed, p.fuel, fuel), {
                                position = "right-center",
                                icon = 'tachometer',
                            })
                        else
                            lib.showTextUI(('%s km/h'):format(speed), {
                                position = "right-center",
                                icon = 'tachometer',
                            })   
                        end
                    elseif p.speedo == 'mph' and carhud then
                        local speed = pyorisus(GetEntitySpeed(cache.vehicle) * 2.23694)
                        local fuel = round(GetVehicleFuelLevel(cache.vehicle), 1)
                        if p.usefuel then
                            lib.showTextUI(('%s MPH     \n     %s: %s'):format(speed, p.fuel, fuel), {
                                position = "right-center",
                                icon = 'tachometer',
                            })
                        else 
                            lib.showTextUI(('%s MPH'):format(speed), {
                                position = "right-center",
                                icon = 'tachometer',
                            })
                        end
                    else
                        lib.hideTextUI()
                    end
                end
            end
            lib.hideTextUI()
        end)
    end
end)

