------------------
--- CATEGORIES ---
------------------
data:extend({
    {
        type = "equipment-category",
        name = "defense-equipment"
    },
    {
        type = "equipment-category",
        name = "energy-equipment"
    }
})


-- Added extra category to vanilla equipment
-- Defense
table.insert(data.raw["active-defense-equipment"]["discharge-defense-equipment"].categories, "defense-equipment")
table.insert(data.raw["active-defense-equipment"]["personal-laser-defense-equipment"].categories, "defense-equipment")
table.insert(data.raw["energy-shield-equipment"]["energy-shield-equipment"].categories, "defense-equipment")
table.insert(data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"].categories, "defense-equipment")
-- Energy
table.insert(data.raw["battery-equipment"]["battery-equipment"].categories, "energy-equipment")
table.insert(data.raw["battery-equipment"]["battery-mk2-equipment"].categories, "energy-equipment")
table.insert(data.raw["generator-equipment"]["fusion-reactor-equipment"].categories, "energy-equipment")
table.insert(data.raw["solar-panel-equipment"]["solar-panel-equipment"].categories, "energy-equipment")
