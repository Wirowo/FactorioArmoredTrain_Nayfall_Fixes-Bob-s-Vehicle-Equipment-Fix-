local minigunWagonMk1 = ArmoredTrain.mk1.wagons.minigunMk1

------------
--- ITEM ---
------------

data:extend
({
	{
		type = "item",
		name = minigunWagonMk1.name,
		icon = "__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/minigun-platform-mk1-icon.png",
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "transport",
		order = "a[train-system]-l[platform_mk1_00]",
		place_result = minigunWagonMk1.name,
		stack_size = minigunWagonMk1.stackSize
	}
})

--------------
--- RECIPE ---
--------------

data:extend
({
	{
		type = "recipe",
		name = minigunWagonMk1.name,
		enabled = false, -- default state (not researched)
		ingredients = minigunWagonMk1.recipe.ingredients,
		result = minigunWagonMk1.name
	}
})

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local l_minigun_wagon_mk1 = util.table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])

-- Name
l_minigun_wagon_mk1.name = minigunWagonMk1.name

-- Icon
l_minigun_wagon_mk1.icon = "__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/minigun-platform-mk1-icon.png"
l_minigun_wagon_mk1.icon_size = 64
l_minigun_wagon_mk1.icon_mipmaps = 4

-- Inventory
l_minigun_wagon_mk1.inventory_size = minigunWagonMk1.inventorySize

-- Mining
l_minigun_wagon_mk1.minable =
{
	mining_time = 0.5,
	result = minigunWagonMk1.name
}

-- Hp
l_minigun_wagon_mk1.max_health = minigunWagonMk1
	.health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
l_minigun_wagon_mk1.weight = minigunWagonMk1.weight

-- Animation
l_minigun_wagon_mk1.pictures =
{
	layers =
	{
		{
			priority = "very-low",
			width = 256,
			height = 256,
			back_equals_front = false, --means to not rotate mirroring
			direction_count = 128, --means to add aditional frames
			allow_low_quality_rotation = true,
			line_length = 32,
			lines_per_file = 1,
			shift = { 0.4, -1.25 },
			filenames =
			{
				"__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/sprites/platform-mk1-01.png",
				"__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/sprites/platform-mk1-02.png",
				"__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/sprites/platform-mk1-03.png",
				"__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/sprites/platform-mk1-04.png"
			}
		}
	}
}
l_minigun_wagon_mk1.horizontal_doors = nil
l_minigun_wagon_mk1.vertical_doors = nil

-- Minimap representation
l_minigun_wagon_mk1.minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/minigun-platform-mk1-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}
l_minigun_wagon_mk1.selected_minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/minigun-platform-mk1/minigun-platform-mk1-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}

-- Write result
data:extend
({
	l_minigun_wagon_mk1
})
