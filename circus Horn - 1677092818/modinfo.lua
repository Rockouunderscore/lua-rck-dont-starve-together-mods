-- This information tells other players more about the mod
name = "circus Horn"
description = "Circus song - A request from a friend"
author = "Rockou_"
version = "1.0.9" -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- Character mods need this set to true
all_clients_require_mod = false
client_only_mod = true

-- The mod's tags displayed on the server list
server_filter_tags = {}

configuration_options = { 
    {
        name = "sound",
        label = "Sound setting",
        hover = "Settings dont work now, need manual changes",
        options = {
            {description = "Fucking normies, Reee", data = "0"},
            {description = "REEE", data = "1"},
            {description = "MLG Horn", data = "2"},
            {description = "circus song", data = "3"},
        },
        default = "3"
    },
}