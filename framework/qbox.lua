local LoadResourceFile = LoadResourceFile
local GetCurrentResourceName = GetCurrentResourceName
local GetEntityCoords = GetEntityCoords
local IsThisModelABoat = IsThisModelABoat
local exports = exports
local GetEntityModel = GetEntityModel
local PlayerPedId = PlayerPedId

local _function = {}
local qbx = exports.qbx_core

function _function.sendNotification(message, type)
    if not message or not type then return end

    qbx:Notify(message, type, 3000, "message", "top-left")
end

function _function.getClosestBoat()
    local vehicles = GetGamePool("CVehicle")
    local plyCoords = GetEntityCoords(PlayerPedId())
    for _,v in ipairs(vehicles) do
        local vehCoords = GetEntityCoords(v)
        local distance = #(plyCoords - vehCoords)
        if distance <= 3.0 and IsThisModelABoat(GetEntityModel(v)) then
            return v
        end
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