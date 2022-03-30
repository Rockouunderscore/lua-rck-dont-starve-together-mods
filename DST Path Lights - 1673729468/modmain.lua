
Assets={
    Asset("ATLAS", "images/inventoryimages/path_light.xml"),
}

PrefabFiles = 
{
    "path_light",
}

-- STRINGS = GLOBAL.STRINGS
-- RECIPETABS = GLOBAL.RECIPETABS
-- Recipe = GLOBAL.Recipe
-- Ingredient = GLOBAL.Ingredient
-- TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.PATH_LIGHT = "Path Light"
GLOBAL.STRINGS.RECIPE_DESC.PATH_LIGHT = "It lights your path."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PATH_LIGHT = "It's a light"

-----------------------------

local path_lightrecipe = GLOBAL.Recipe(
    "path_light",
    {
        GLOBAL.Ingredient("lantern", 1),
        GLOBAL.Ingredient("lightbulb", 2),
    },
    GLOBAL.RECIPETABS.LIGHT,
    GLOBAL.TECH.SCIENCE_TWO,
    "path_light_placer",
    0,
    nil,
    nil,
    nil,
    "images/inventoryimages/path_light.xml"
)

--------------------------------

local light_radius = GetModConfigData("light_radius")
if light_radius == "small"
    then GLOBAL.lightRadius = 1
elseif light_radius == "medium"
    then GLOBAL.lightRadius = 2
elseif light_radius == "large"
    then GLOBAL.lightRadius = 3
elseif light_radius == "larger"
    then GLOBAL.lightRadius = 4
elseif light_radius == "huge"
    then GLOBAL.lightRadius = 5
else
    GLOBAL.lightRadius = 2
end

GLOBAL.lightColour = (GetModConfigData("light_colour"))
GLOBAL.FueledtLight = (GetModConfigData("FueledLights")=="yes")

