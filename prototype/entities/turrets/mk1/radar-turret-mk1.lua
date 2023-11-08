local radarTurretMk1 = ArmoredTrain.mk1.turrets.radarMk1
local radarWagonMk1 = ArmoredTrain.mk1.wagons.radarMk1

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local l_radar_mk1 = util.table.deepcopy(data.raw["radar"]["radar"])

-- Name
l_radar_mk1.name = radarTurretMk1.name

-- Flags
l_radar_mk1.flags =
{
	"player-creation", -- Can draw enemies
	"placeable-off-grid",
	"not-on-map",   -- Do not show on minimap
	"not-repairable",
	"not-deconstructable",
	"not-blueprintable"
}

-- Mining
l_radar_mk1.minable = nil

-- HP
l_radar_mk1.max_health = radarWagonMk1
	.health -- Same as platform hp (Critical component or will be destroyed using old script)

-- Resistance
l_radar_mk1.resistances = radarWagonMk1.resistances -- Prevent faster damage from turret

-- Collision
l_radar_mk1.collision_box = { { -1, -1 }, { 1, 1 } }
l_radar_mk1.collision_mask = { "object-layer" } -- Fix player stuck inside wagon forever
l_radar_mk1.selection_box = { { -1.25, -1.25 }, { 1.25, 1.25 } }

-- Radar parameters
l_radar_mk1.energy_per_sector = radarTurretMk1
	.energyPerSector                                                                          -- Default (devide by 7) "10MJ"	
l_radar_mk1.max_distance_of_sector_revealed = radarTurretMk1.maxDistanceOfSector              -- Default 14
l_radar_mk1.max_distance_of_nearby_sector_revealed = radarTurretMk1.maxDistanceOfNearbySector -- Default 3
l_radar_mk1.energy_per_nearby_scan = radarTurretMk1.energyPerNearbyScan                       -- Default "250kJ"
l_radar_mk1.energy_source =
{
	type = "burner",
	fuel_categories = { "chemical" },
	effectivity = radarTurretMk1.burner.effectivity,
	emissions_per_minute = 1, -- 4
	fuel_inventory_size = radarTurretMk1.burner.fuelInventorySize,
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
l_radar_mk1.energy_usage = radarTurretMk1.energyUsage --  "300kW"

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
l_radar_mk1.integration_patch = blank_layers
l_radar_mk1.pictures = blank_layers

-- Write result
data:extend
({
	l_radar_mk1
})
