local grids = {}
local locomotives = require("config.values.locomotivesValues")

-- For each locomotive generates an equipment grid item
for key, locomotive in pairs(locomotives) do
    grids[key] = {
        type = "equipment-grid",
        name = locomotive.name .. "-grid",
        width = locomotive.grid.width,
        height = locomotive.grid.height,
        equipment_categories = { "defense-equipment", "energy-equipment" }
    }
end

return grids
