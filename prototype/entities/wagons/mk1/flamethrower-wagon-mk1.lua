local flamethrowerWagonMk1 = ArmoredTrain.mk1.wagons.flamethrowerMk1

------------
--- ITEM ---
------------

data:extend
({
	{
		type = "item",
		name = flamethrowerWagonMk1.name,
		icon = "__Armored-train_Nayfall_Fixes__/assets/wagons/flamethrower/mk1/flamethrower-wagon-mk1-icon.png",
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "transport",
		order = flamethrowerWagonMk1.order,
		place_result = flamethrowerWagonMk1.name,
		stack_size = flamethrowerWagonMk1.stack_size
	}
})

--------------
--- RECIPE ---
--------------

data:extend
({
	{
		type = "recipe",
		name = flamethrowerWagonMk1.name,
		enabled = false, -- default state (not researched)
		ingredients = flamethrowerWagonMk1.recipe.ingredients,
		result = flamethrowerWagonMk1.name
	}
})

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_flamethrower_wagon_mk1 = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])

-- Name
e_flamethrower_wagon_mk1.name = flamethrowerWagonMk1.name

-- Inventory
e_flamethrower_wagon_mk1.inventory_size = flamethrowerWagonMk1.inventory_size

-- Mining
e_flamethrower_wagon_mk1.minable =
{
	mining_time = flamethrowerWagonMk1.mining_time,
	result = flamethrowerWagonMk1.name
}

-- Animation
e_flamethrower_wagon_mk1.pictures =
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
				"__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-01.png",
				"__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-02.png",
				"__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-03.png",
				"__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-04.png"
			}
		}
	}
}
e_flamethrower_wagon_mk1.horizontal_doors = nil
e_flamethrower_wagon_mk1.vertical_doors = nil

-- Minimap representation
e_flamethrower_wagon_mk1.minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/wagons/flamethrower/flamethrower-wagon-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}
e_flamethrower_wagon_mk1.selected_minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/wagons/flamethrower/flamethrower-wagon-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}

---------------
---- STATS ----
---------------

-- Hp
e_flamethrower_wagon_mk1.max_health = flamethrowerWagonMk1
	.max_health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
e_flamethrower_wagon_mk1.weight = flamethrowerWagonMk1.weight

-- Max speed
e_flamethrower_wagon_mk1.max_speed = flamethrowerWagonMk1.max_speed

-- Braking force
e_flamethrower_wagon_mk1.braking_force = flamethrowerWagonMk1.braking_force

-- Friction_force
e_flamethrower_wagon_mk1.friction_force = flamethrowerWagonMk1.friction_force

-- Air resistance
e_flamethrower_wagon_mk1.air_resistance = flamethrowerWagonMk1.air_resistance

-- Energy per hit point
e_flamethrower_wagon_mk1.energy_per_hit_point = flamethrowerWagonMk1.energy_per_hit_point

-- Write result
data:extend
({
	e_flamethrower_wagon_mk1
})
