fx_version "cerulean"
game "gta5"

author "hugov <https://github.com/hugovrtt>"
description "An script for anchored boat"
version "1.0.0"

files {
    "locales/*.json",
    "framework/*.lua"
}

shared_scripts {
    "config.lua",
    "request.lua"
}

client_scripts {
    "framework/*.lua",
    "client.lua"
}