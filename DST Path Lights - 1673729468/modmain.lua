
Assets={
	Asset("ATLAS", "images/inventoryimages/path_light.xml"),
	Asset("IMAGE", "images/inventoryimages/path_light.tex")
}

PrefabFiles = 
{
	"path_light"
}

-- STRINGS = GLOBAL.STRINGS
-- RECIPETABS = GLOBAL.RECIPETABS
-- Recipe = GLOBAL.Recipe
-- Ingredient = GLOBAL.Ingredient
-- TECH = GLOBAL.TECH
local env = env
-- GLOBAL.setfenv(1, GLOBAL)

GLOBAL.STRINGS.NAMES.PATH_LIGHT = "Path Light"
GLOBAL.STRINGS.RECIPE_DESC.PATH_LIGHT = "It lights your path."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PATH_LIGHT = "It's a light"

-----------------------------

local rec = env.AddRecipe(
	"path_light", --prefab name
	{
		Ingredient("lantern", 1),
		Ingredient("lightbulb", 2)
	}, -- ingredient list
	GLOBAL.RECIPETABS.LIGHT, -- recipe tab
	GLOBAL.TECH.SCIENCE_TWO, -- tech level
	"path_light_placer", -- placer of the recipe
	0, -- range to closest object
	nil, -- i honestly dont know what this does
	nil, -- same here
	nil, -- same here
	"images/inventoryimages/path_light.xml", -- inventory image
	"path_light.tex" -- object image?
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

