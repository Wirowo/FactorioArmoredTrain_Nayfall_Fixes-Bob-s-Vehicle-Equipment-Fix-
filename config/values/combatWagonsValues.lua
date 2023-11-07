local turrets = require("config.values.turretsValues")
local combatWagons = {}

-- Wagons auto generates for each turret

WagonsMk1Health = 1200

-- Wagon Mk1
for key, turret in pairs(turrets) do
    combatWagons[key] = {
        name = turret.name:gsub("-turret%-", "-wagon-"),
        -- x2 Compared to vanilla
        health = WagonsMk1Health,
        -- x2 Compared to vanilla
        weight = 2000,
        stackSize = 5,
        recipe = turret.recipe,
        -- 10% More than vanilla
        resistances = {
            {
                type = "fire",
                decrease = 17,
                percent = 55
            },
            {
                type = "physical",
                decrease = 17,
                percent = 33
            },
            {
                type = "impact",
                decrease = 55,
                percent = 66
            },
            {
                type = "explosion",
                decrease = 17,
                percent = 33
            },
            {
                type = "acid",
                decrease = 4,
                percent = 22
            }
        }
    }
end

return combatWagons
