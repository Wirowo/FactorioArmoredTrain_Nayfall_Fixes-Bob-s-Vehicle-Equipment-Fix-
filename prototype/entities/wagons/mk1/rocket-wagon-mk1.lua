local rocketWagonMk1 = ArmoredTrain.mk1.wagons.rocketMk1

------------
--- ITEM ---
------------

data:extend
({
	{
		type = "item",
		name = rocketWagonMk1.name,
		icon = "__Armored-train_Nayfall_Fixes__/assets/platforms/rocket/mk1/rocket-platform-mk1-icon.png",
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "transport",
		order = rocketWagonMk1.order,
		place_result = rocketWagonMk1.name,
		stack_size = rocketWagonMk1.stack_size
	}
})

--------------
--- RECIPE ---
--------------

data:extend
({
	{
		type = "recipe",
		name = rocketWagonMk1.name,
		enabled = false, -- default state (not researched)
		ingredients = rocketWagonMk1.recipe.ingredients,
		result = rocketWagonMk1.name
	}
})

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_rocket_wagon_mk1 = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])

-- Name
e_rocket_wagon_mk1.name = rocketWagonMk1.name

-- Inventory
e_rocket_wagon_mk1.inventory_size = rocketWagonMk1.inventory_size

-- Mining
e_rocket_wagon_mk1.minable =
{
	mining_time = 0.5,
	result = rocketWagonMk1.name
}

-- Animation
e_rocket_wagon_mk1.pictures =
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
e_rocket_wagon_mk1.horizontal_doors = nil
e_rocket_wagon_mk1.vertical_doors = nil

-- Minimap representation
e_rocket_wagon_mk1.minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/platforms/rocket/rocket-platform-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}
e_rocket_wagon_mk1.selected_minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/platforms/rocket/rocket-platform-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}

---------------
---- STATS ----
---------------

-- Hp
e_rocket_wagon_mk1.max_health = rocketWagonMk1
	.max_health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
e_rocket_wagon_mk1.weight = rocketWagonMk1.weight

-- Max speed
e_rocket_wagon_mk1.max_speed = rocketWagonMk1.max_speed

-- Braking force
e_rocket_wagon_mk1.braking_force = rocketWagonMk1.braking_force

-- Friction_force
e_rocket_wagon_mk1.friction_force = rocketWagonMk1.friction_force

-- Air resistance
e_rocket_wagon_mk1.air_resistance = rocketWagonMk1.air_resistance

-- Energy per hit point
e_rocket_wagon_mk1.energy_per_hit_point = rocketWagonMk1.energy_per_hit_point

-- Write result
data:extend
({
	e_rocket_wagon_mk1
})
