local hideTextUI = function()
    lib.hideTextUI()
end

---@param text string
local showTextUI = function(text)
    lib.showTextUI(text, {
        position = p.position,
        icon = 'tachometer'
    })
end

---@param title string
local notify = function(title)
    lib.notify({
        title = title,
        type = 'success'
    })
end

local carhud = true
RegisterCommand(p.command, function()
    if carhud then
        carhud = false
        notify(p.locale.turnedoff)
    else
        carhud = true
        notify(p.locale.turnedon)
    end
end, false)

local function round(n)
    return math.floor(n * 10 + 0.5) / 10
end

local function pyorisus(n)
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
                        local fuel = round(GetVehicleFuelLevel(cache.vehicle))
                        if p.usefuel then
                            showTextUI(('%s km/h     \n     %s: %s'):format(speed, p.locale.fuel, fuel))
                        else
                            showTextUI(('%s km/h'):format(speed))
                        end
                    elseif p.speedo == 'mph' and carhud then
                        local speed = pyorisus(GetEntitySpeed(cache.vehicle) * 2.23694)
                        local fuel = round(GetVehicleFuelLevel(cache.vehicle))
                        if p.usefuel then
                            showTextUI(('%s MPH     \n     %s: %s'):format(speed, p.locale.fuel, fuel))
                        else
                            showTextUI(('%s MPH'):format(speed))
                        end
                    else
                        hideTextUI()
                    end
                end
            end
            hideTextUI()
        end)
    end
end)

