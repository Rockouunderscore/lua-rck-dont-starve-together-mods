
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

local rec = env.AddRecipe2(
	"path_light", --prefab name - name
	{
		Ingredient("lantern", 1),
		Ingredient("lightbulb", 2)
	}, -- ingredient list - ingredients
	GLOBAL.TECH.SCIENCE_TWO, -- tech level - tech
	{
		min_spacing = 0,
		-- nounlock,
		-- numtogive,
		-- builder_tag,
		atlas = "images/inventoryimages/path_light.xml",
		image = "path_light.tex",
		-- testfn,
		-- product,
		-- build_mode,
		-- build_distance,
		placer = "path_light_placer",
	},
	{"LIGHT"} -- filter
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

