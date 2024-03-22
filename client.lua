---@param title string
local function notify(title)
    lib.notify({
        title = title,
        type = 'success'
    })
end

local carhud = true
RegisterCommand(p.command, function()
    carhud = not carhud
    notify(carhud and p.locale.turnedon or p.locale.turnedoff)
end, false)

---@param n number
local function round(n)
    return math.floor(n * 10 + 0.5) / 10
end

---@param n number
local function pyorisus(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

local useKilo <const> = p.speedo == 'kmh';
local speedUnit <const> = useKilo and 'km/h' or 'MPH'

lib.onCache('vehicle', function(vehicle)
    if vehicle then
        CreateThread(function()
            while cache.vehicle do
                if GetIsVehicleEngineRunning(cache.vehicle) then
                    if carhud then
                        local speed <const> = pyorisus(GetEntitySpeed(cache.vehicle) * (useKilo and 3.6 or 2.23694))
                        local text = ('%s %s'):format(speed, speedUnit);
                        if p.usefuel then
                            text = ('%s %s  \n %s: %s'):format(speed, speedUnit, p.locale.fuel, round(GetVehicleFuelLevel(cache.vehicle)))
                        end

                        lib.showTextUI(text, {
                            position = p.position,
                            icon = 'tachometer'
                        })
                    else
                        lib.hideTextUI()
                    end
                end
                Wait(100)
            end
            lib.hideTextUI()
        end)
    end
end)