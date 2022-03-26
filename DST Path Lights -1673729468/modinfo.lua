
name = "DST Path Lights"
description = "My costum verison of DST path light. I added a light radius option and you can place them anywhere without restriction"
author = "Rockou_"
version = "1.0.5"

forumthread = ""

priority = 0.346962879
dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

api_version = 10

icon_atlas = "path_light.xml"
icon = "path_light.tex"

configuration_options =
{
    {
        name = "",
        label = "",
        options =
            {
                {description = "", data = 0},
            },
        default = 0,
    },

    {
        name = "light_colour",
        label = "Light Colour",
        hover = "Change the light colour",
        options =
            {
                {description = "Blue", data = "blue"},
                {description = "Red", data = "red"},
                {description = "Green", data = "green"},
                {description = "White", data = "white"},
            },
        default = "white",
    },
    
    {
        name = "light_radius",
        label = "Light Radius",
        hover = "Change the light radius",
        options =
            {
                {description = "Small", data = "small"},
                {description = "Medium", data = "medium"},
                {description = "Large", data = "large"},
                {description = "Larger", data = "larger"},
                {description = "Huge", data = "huge"},
            },
        default = "medium",
    },

    {
        name = "FueledLights",
        label = "Fueled?",
        options =
            {
                {description = "Yes", data = true},
                {description = "No", data = false},
            },
        default = 0,
    },
}