local radarTurretMk1 = ArmoredTrain.mk1.turrets.radarMk1
local radarWagonMk1 = ArmoredTrain.mk1.wagons.radarMk1

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_radar_mk1 = table.deepcopy(data.raw["radar"]["radar"])

-- Name
e_radar_mk1.name = radarTurretMk1.name

-- Flags
e_radar_mk1.flags =
{
	"player-creation", -- Can draw enemies
	"placeable-off-grid",
	"not-on-map",   -- Do not show on minimap
	"not-repairable",
	"not-deconstructable",
	"not-blueprintable"
}

-- Mining
e_radar_mk1.minable = nil

-- HP
e_radar_mk1.max_health = radarWagonMk1
	.max_health -- Same as platform hp (Critical component or will be destroyed using old script)

-- Resistance
e_radar_mk1.resistances = radarWagonMk1.resistances -- Prevent faster damage from turret

-- Collision
e_radar_mk1.collision_box = { { -1, -1 }, { 1, 1 } }
e_radar_mk1.collision_mask = { "object-layer" } -- Fix player stuck inside wagon forever
e_radar_mk1.selection_box = { { -1.25, -1.25 }, { 1.25, 1.25 } }

-- Radar parameters
e_radar_mk1.energy_per_sector = radarTurretMk1
	.energy_per_sector                                                                                     -- Default (devide by 7) "10MJ"	
e_radar_mk1.max_distance_of_sector_revealed = radarTurretMk1.max_distance_of_sector_revealed               -- Default 14
e_radar_mk1.max_distance_of_nearby_sector_revealed = radarTurretMk1.max_distance_of_nearby_sector_revealed -- Default 3
e_radar_mk1.energy_per_nearby_scan = radarTurretMk1
	.energy_per_nearby_scan                                                                                -- Default "250kJ"
e_radar_mk1.energy_source =
{
	type = "burner",
	fuel_categories = { "chemical" },
	effectivity = radarTurretMk1.burner.effectivity,
	emissions_per_minute = 1, -- 4
	fuel_inventory_size = radarTurretMk1.burner.fuel_inventory_size,
	smoke =
	{
		{
			name = "smoke",
			frequency = 2, -- 10
			position = { 0.7, -1.2 },
			starting_vertical_speed = 0.08,
			starting_frame_deviation = 15 -- 60
		}
	}
}
e_radar_mk1.energy_usage = radarTurretMk1.energy_usage --  "300kW"

-- Base picture
local blank_layers =
{
	layers =
	{
		{
			filename = "__Armored-train_Nayfall_Fixes__/assets/utils/fakeTransparent.png",
			direction_count = 1,
			height = 16,
			width = 16
		}
	}
}
e_radar_mk1.integration_patch = blank_layers
e_radar_mk1.pictures = blank_layers

-- Write result
data:extend
({
	e_radar_mk1
})
