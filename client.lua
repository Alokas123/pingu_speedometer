function round(n)
    return math.floor(n * 10 + 0.5) / 10
end

function pyorisus(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(player, false)
        if IsPedInAnyVehicle(player, false) and (GetSeatPedIsTryingToEnter(player) == -1 or GetPedInVehicleSeat(vehicle, -1) == player) and GetIsVehicleEngineRunning(vehicle) then
            local kmh = pyorisus(GetEntitySpeed(vehicle) * 3.6)
            local fuel = round(GetVehicleFuelLevel(vehicle), 1)
            lib.showTextUI(kmh .. " km/h     \n     bensaa: " .. fuel, {
                position = "right-center",
                icon = 'tachometer',
            })
        else
            lib.hideTextUI()
        end
    end
end)
