local cannonWagonMk1 = ArmoredTrain.mk1.wagons.cannonMk1

------------
--- ITEM ---
------------

data:extend
({
	{
		type = "item",
		name = cannonWagonMk1.name,
		icon = "__Armored-train_Nayfall_Fixes__/assets/wagons/cannon/mk1/cannon-wagon-mk1-icon.png",
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "transport",
		order = cannonWagonMk1.order,
		place_result = cannonWagonMk1.name,
		stack_size = cannonWagonMk1.stack_size
	}
})

--------------
--- RECIPE ---
--------------

data:extend
({
	{
		type = "recipe",
		name = cannonWagonMk1.name,
		enabled = false, -- default state (not researched)
		ingredients = cannonWagonMk1.recipe.ingredients,
		result = cannonWagonMk1.name
	}
})

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_cannon_wagon_mk1 = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])

-- Name
e_cannon_wagon_mk1.name = cannonWagonMk1.name

-- Inventory
e_cannon_wagon_mk1.inventory_size = cannonWagonMk1.inventory_size

-- Mining
e_cannon_wagon_mk1.minable =
{
	mining_time = cannonWagonMk1.mining_time,
	result = cannonWagonMk1.name
}

-- Animation
e_cannon_wagon_mk1.pictures =
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
e_cannon_wagon_mk1.horizontal_doors = nil
e_cannon_wagon_mk1.vertical_doors = nil

-- Minimap representation
e_cannon_wagon_mk1.minimap_representation =
{
	filename = "__Armored-train_Nayfall_Fixes__/assets/wagons/cannon/cannon-wagon-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}
e_cannon_wagon_mk1.selected_minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/wagons/cannon/cannon-wagon-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}

---------------
---- STATS ----
---------------

-- Hp
e_cannon_wagon_mk1.max_health = cannonWagonMk1
	.max_health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
e_cannon_wagon_mk1.weight = cannonWagonMk1.weight

-- Max speed
e_cannon_wagon_mk1.max_speed = cannonWagonMk1.max_speed

-- Braking force
e_cannon_wagon_mk1.braking_force = cannonWagonMk1.braking_force

-- Friction_force
e_cannon_wagon_mk1.friction_force = cannonWagonMk1.friction_force

-- Air resistance
e_cannon_wagon_mk1.air_resistance = cannonWagonMk1.air_resistance

-- Energy per hit point
e_cannon_wagon_mk1.energy_per_hit_point = cannonWagonMk1.energy_per_hit_point

-- Write result
data:extend
({
	e_cannon_wagon_mk1
})
