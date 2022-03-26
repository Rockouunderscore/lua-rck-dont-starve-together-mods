   
Assets=
{
    Asset("ATLAS", "images/inventoryimages/path_light.xml"),
}

PrefabFiles = 
{
    "path_light",
}

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.PATH_LIGHT = "Path Light"
STRINGS.RECIPE_DESC.PATH_LIGHT = "It lights your path."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PATH_LIGHT = "It's a light"
    
-----------------------------

local path_lightrecipe = GLOBAL.Recipe(
    "path_light",
    { 
        Ingredient("lantern", 1),
        Ingredient("lightbulb", 2),
    },
    GLOBAL.RECIPETABS.LIGHT, GLOBAL.TECH.SCIENCE_TWO, "path_light_placer", 0, nil, nil, nil, "images/inventoryimages/path_light.xml" )

--------------------------------

local lightRadius = GetModConfigData("light_radius")
if lightRadius == "small"
    then GLOBAL.lightRadius = 1
elseif lightRadius == "medium"
    then GLOBAL.lightRadius = 2
elseif lightRadius == "large"
    then GLOBAL.lightRadius = 3
elseif lightRadius == "larger"
    then GLOBAL.lightRadius = 4
elseif lightRadius == "huge"
    then GLOBAL.lightRadius = 5
else
    GLOBAL.lightRadius = 2
end

GLOBAL.lightColour = (GetModConfigData("light_colour"))
GLOBAL.FueledtLight = (GetModConfigData("FueledLights")=="yes")

