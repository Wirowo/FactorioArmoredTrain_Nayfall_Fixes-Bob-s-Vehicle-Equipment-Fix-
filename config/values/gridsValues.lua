-----------------
----- GRIDS -----
-----------------

-- Here the grids are created, then uploaded on prototype/grids

-- For each locomotive generates the expected grid
for key, locomotive in pairs(ArmoredTrain.total.locomotives) do
    ArmoredTrain.grids[key] = {
        type = "equipment-grid",
        name = locomotive.name .. "-grid",
        width = locomotive.grid.width,
        height = locomotive.grid.height,
        equipment_categories = { "attack-equipment", "defense-equipment", "energy-equipment" }
    }
end

-- Add grids base name to easy access
ArmoredTrain.bases.grids.turretWagon = "turretWagonMk"
ArmoredTrain.bases.grids.utilityWagon = "utilityWagonMk"

-- Turret wagon mk1
ArmoredTrain.grids.turretWagonMk1 = {
    type = "equipment-grid",
    name = ArmoredTrain.bases.grids.turretWagon .. "1" .. "-grid",
    width = 4,
    height = 4,
    equipment_categories = { "defense-equipment", "energy-equipment" }
}

-- Utility wagon mk1
ArmoredTrain.grids.utilityWagonMk1 = {
    type = "equipment-grid",
    name = ArmoredTrain.bases.grids.utilityWagon .. "1" .. "-grid",
    width = 5,
    height = 5,
    equipment_categories = { "attack-equipment", "defense-equipment", "energy-equipment" }
}
