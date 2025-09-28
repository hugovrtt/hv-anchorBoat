_CONFIG = {}

_CONFIG.locale = "fr" -- en, fr, de, es, pt

_CONFIG.framework = "standalone" -- standalone, esx, ox (ox_lib), qb

_CONFIG.ox_target = GetResourceState("ox_target") == "started" and true or false

_CONFIG.notification = {
    title = "Information",
}

if _CONFIG.ox_target then
    _CONFIG.boatModels = {
        "avisa",
        "dinghy",
        "dinghy2",
        "dinghy3",
        "dinghy4",
        "dinghy5",
        "jetmax",
        "kosatka",
        "longfin",
        "marquis",
        "patrolboat",
        "predator",
        "seashark",
        "seashark2",
        "seashark3",
        "speeder",
        "speeder2",
        "squalo",
        "submersible",
        "submersible2",
        "suntrap",
        "toro",
        "toro2",
        "tropic",
        "tropic2",
        "tug"
    }
end