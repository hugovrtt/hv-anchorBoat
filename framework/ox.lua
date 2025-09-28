local GetEntityCoords = GetEntityCoords
local PlayerPedId = PlayerPedId

local _function = {}

function _function.sendNotification(message, type)
    if not message or not type then return end

    lib.notify({
        title = _CONFIG.notification.title,
        description = message,
        type = type
    })
end

function _function.getClosestBoat()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local closestBoat, closestBoatCoords = lib.getClosestVehicle(plyCoords, 3.0, true)
    local distance = #(plyCoords - closestBoatCoords)
    if distance <= 3.0 then
        return closestBoat
    end
end

function _function.locale(translation)
    if not translation then return end

    lib.locale()

    return locale(translation)
end

return _function