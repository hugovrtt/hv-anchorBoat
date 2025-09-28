local GetVehiclePedIsIn = GetVehiclePedIsIn
local IsEntityTouchingEntity = IsEntityTouchingEntity
local PlayerPedId = PlayerPedId
local IsBoatAnchored = IsBoatAnchored
local GetEntityModel = GetEntityModel
local IsThisModelABoat = IsThisModelABoat
local SetBoatAnchor = SetBoatAnchor
local CanAnchorBoatHereIgnorePlayers = CanAnchorBoatHereIgnorePlayers
local SetForceLowLodAnchorMode = SetForceLowLodAnchorMode
local SetBoatRemainsAnchoredWhilePlayerIsDriver = SetBoatRemainsAnchoredWhilePlayerIsDriver
local GetEntitySpeed = GetEntitySpeed
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetResourceState = GetResourceState
local IsEntityAPed = IsEntityAPed
local SetVehicleMaxSpeed = SetVehicleMaxSpeed

local _function = request "framework.standalone" -- framework.standalone, framework.esx, framework.ox, framework.qb

local convertSpeed = _CONFIG.locale == "en" and 2.236936 or 3.6
local maxSpeed = _CONFIG.locale == "en" and 6.21371 or 10.0

local function anchorBoat(boat, toggle)
    SetForceLowLodAnchorMode(boat, toggle)
    SetBoatRemainsAnchoredWhilePlayerIsDriver(boat, toggle)
    SetBoatAnchor(boat, toggle)
end

local function notify(locale, type)
    _function.sendNotification(_function.locale(locale), type)
end

function SetBoatAnchor_2(boat)
    local playerPed = PlayerPedId()
    boat = boat or GetVehiclePedIsIn(playerPed, false)

    if not boat or boat <= 0 then
        local closestBoat = _function.getClosestBoat()
        if not closestBoat then notify("nothing_boat", "error") return end

        if IsEntityTouchingEntity(playerPed, closestBoat) then
            local hasDriver = GetPedInVehicleSeat(closestBoat, -1)
            if hasDriver and IsEntityAPed(hasDriver) then notify("has_driver", "info") return end
            boat = closestBoat
        end
    end
    
    local toggle = IsBoatAnchored(boat)

    if IsThisModelABoat(GetEntityModel(boat)) then
        if not toggle then
            if CanAnchorBoatHereIgnorePlayers(boat) then
                if (GetEntitySpeed(boat) * convertSpeed) >= maxSpeed then notify("boat_too_fast", "info") return end

                anchorBoat(boat, not toggle)
                notify("anchored_boat", "sucess") return
            end
            notify("boat_dont_anchored", "info") return
        end
        anchorBoat(boat, false)
        notify("unanchored_boat", "sucess") return
    end
    notify("model_not_boat", "error")
end

if _CONFIG.ox_target then
    if GetResourceState("ox_target") ~= "started" then print("You have not started the ox_target resource") return end

    exports.ox_target:addModel(_CONFIG.boatModels, {
        label = _function.locale("target_anchor_boat"),
        distance = 3.0,
        icon = "fa-solid fa-anchor",
        iconColor = "white",
        onSelect = function(data)
            SetBoatAnchor_2(data.entity)
        end
    })
end

RegisterCommand("anchorBoat", function()
    SetBoatAnchor_2()
end, false)

exports("SetBoatAnchor", SetBoatAnchor_2)