local grids = {}
local locomotives = require("config.values.locomotivesValues")

-- Here the grids are created, then uploaded on prototype/grids

-- For each locomotive generates an equipment grid item
for key, locomotive in pairs(locomotives) do
    grids[key] = {
        type = "equipment-grid",
        name = locomotive.name .. "-grid",
        width = locomotive.grid.width,
        height = locomotive.grid.height,
        equipment_categories = { "attack-equipment", "defense-equipment", "energy-equipment" }
    }
end

-- Wagon mk1
grids.wagonMk1 = {
    type = "equipment-grid",
    name = "armoredWagonMk1-grid",
    width = 4,
    height = 4,
    equipment_categories = { "defense-equipment", "energy-equipment" }
}

-- Radar mk1
grids.radarMk1 = {
    type = "equipment-grid",
    name = "armoredRadarMk1-grid",
    width = 4,
    height = 4,
    equipment_categories = { "attack-equipment", "defense-equipment", "energy-equipment" }
}

return grids
