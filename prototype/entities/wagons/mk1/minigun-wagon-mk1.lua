local minigunWagonMk1 = ArmoredTrain.mk1.wagons.minigunMk1

------------
--- ITEM ---
------------

data:extend
({
	{
		type = "item",
		name = minigunWagonMk1.name,
		icon = "__Armored-train_Nayfall_Fixes__/assets/platforms/minigun/mk1/minigun-platform-mk1-icon.png",
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "transport",
		order = minigunWagonMk1.order,
		place_result = minigunWagonMk1.name,
		stack_size = minigunWagonMk1.stack_size
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
local e_minigun_wagon_mk1 = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])

-- Name
e_minigun_wagon_mk1.name = minigunWagonMk1.name

-- Inventory
e_minigun_wagon_mk1.inventory_size = minigunWagonMk1.inventory_size

-- Mining
e_minigun_wagon_mk1.minable =
{
	mining_time = 0.5,
	result = minigunWagonMk1.name
}

-- Animation
e_minigun_wagon_mk1.pictures =
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
				"__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-01.png",
				"__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-02.png",
				"__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-03.png",
				"__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-04.png"
			}
		}
	}
}
e_minigun_wagon_mk1.horizontal_doors = nil
e_minigun_wagon_mk1.vertical_doors = nil

-- Minimap representation
e_minigun_wagon_mk1.minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/platforms/minigun/minigun-platform-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}
e_minigun_wagon_mk1.selected_minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/platforms/minigun/minigun-platform-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}

---------------
---- STATS ----
---------------

-- Hp
e_minigun_wagon_mk1.max_health = minigunWagonMk1
	.max_health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
e_minigun_wagon_mk1.weight = minigunWagonMk1.weight

-- Max speed
e_minigun_wagon_mk1.max_speed = minigunWagonMk1.max_speed

-- Braking force
e_minigun_wagon_mk1.braking_force = minigunWagonMk1.braking_force

-- Friction_force
e_minigun_wagon_mk1.friction_force = minigunWagonMk1.friction_force

-- Air resistance
e_minigun_wagon_mk1.air_resistance = minigunWagonMk1.air_resistance

-- Energy per hit point
e_minigun_wagon_mk1.energy_per_hit_point = minigunWagonMk1.energy_per_hit_point

-- Write result
data:extend
({
	e_minigun_wagon_mk1
})
