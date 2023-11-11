local radarWagonMk1 = ArmoredTrain.mk1.wagons.radarMk1

------------
--- ITEM ---
------------

data:extend
({
	{
		type = "item",
		name = radarWagonMk1.name,
		icon = "__Armored-train_Nayfall_Fixes__/assets/platforms/radar/mk1/radar-platform-mk1-icon.png",
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "transport",
		order = radarWagonMk1.order,
		place_result = radarWagonMk1.name,
		stack_size = radarWagonMk1.stack_size
	}
})

--------------
--- RECIPE ---
--------------

data:extend
({
	{
		type = "recipe",
		name = radarWagonMk1.name,
		enabled = false, -- default state (not researched)
		ingredients = radarWagonMk1.recipe.ingredients,
		result = radarWagonMk1.name
	}
})

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_radar_wagon_mk1 = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])

-- Name
e_radar_wagon_mk1.name = radarWagonMk1.name

-- Inventory
e_radar_wagon_mk1.inventory_size = radarWagonMk1.inventory_size

-- Mining
e_radar_wagon_mk1.minable =
{
	mining_time = 0.5,
	result = radarWagonMk1.name
}

-- Animation
e_radar_wagon_mk1.pictures =
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
		},
		--DECORATIVES
		{
			priority = "very-low",
			width = 96,       --72
			height = 140,     --57
			back_equals_front = false, --means to not rotate mirroring
			direction_count = 128, --means to add aditional frames
			allow_low_quality_rotation = true,
			line_length = 32,
			lines_per_file = 1,
			--shift = {0.0, -2.2},
			shift = { 0.2, -1.35 },
			scale = 0.675,
			filenames =
			{
				"__Armored-train_Nayfall_Fixes__/assets/turrets/radar/mk1/sprites/radar-mk1-01-fix.png",
				"__Armored-train_Nayfall_Fixes__/assets/turrets/radar/mk1/sprites/radar-mk1-02-fix.png",
				"__Armored-train_Nayfall_Fixes__/assets/turrets/radar/mk1/sprites/radar-mk1-03-fix.png",
				"__Armored-train_Nayfall_Fixes__/assets/turrets/radar/mk1/sprites/radar-mk1-04-fix.png"
			}
		}
	}
}
e_radar_wagon_mk1.horizontal_doors = nil
e_radar_wagon_mk1.vertical_doors = nil

-- Minimap representation
e_radar_wagon_mk1.minimap_representation =
{
	filename = "__Armored-train_Nayfall_Fixes__/assets/platforms/radar/radar-platform-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}
e_radar_wagon_mk1.selected_minimap_representation =
{
	filename =
	"__Armored-train_Nayfall_Fixes__/assets/platforms/radar/radar-platform-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5
}

---------------
---- STATS ----
---------------

-- Hp
e_radar_wagon_mk1.max_health = radarWagonMk1
	.max_health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
e_radar_wagon_mk1.weight = radarWagonMk1.weight

-- Max speed
e_radar_wagon_mk1.max_speed = radarWagonMk1.max_speed

-- Braking force
e_radar_wagon_mk1.braking_force = radarWagonMk1.braking_force

-- Friction_force
e_radar_wagon_mk1.friction_force = radarWagonMk1.friction_force

-- Air resistance
e_radar_wagon_mk1.air_resistance = radarWagonMk1.air_resistance

-- Energy per hit point
e_radar_wagon_mk1.energy_per_hit_point = radarWagonMk1.energy_per_hit_point

-- Write result
data:extend
({
	e_radar_wagon_mk1
})
