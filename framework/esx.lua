local LoadResourceFile = LoadResourceFile
local GetCurrentResourceName = GetCurrentResourceName
local GetEntityCoords = GetEntityCoords
local IsThisModelABoat = IsThisModelABoat
local exports = exports
local GetEntityModel = GetEntityModel
local PlayerPedId = PlayerPedId

local _function = {}

function _function.sendNotification(message, type)
    if not message or not type then return end

    ESX.ShowNotification(message, type, 3000)
end

function _function.getClosestBoat()
    local closestBoat, distance = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    if distance <= 3.0 and IsThisModelABoat(GetEntityModel(closestBoat)) then
        return closestBoat
    end
end

local locales = json.decode(LoadResourceFile(GetCurrentResourceName(), ("/locales/%s.json"):format(_CONFIG.locale)))
function _function.locale(translation)
    if not translation then return end

    if locales[translation] then
        return locales[translation]
    end
    return translation
end

return _function