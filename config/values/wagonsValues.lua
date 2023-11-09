------------------
----- WAGONS -----
------------------

-- Wagons auto generates for each turret

-- Wagon Mk1
for key, turret in pairs(ArmoredTrain.mk1.turrets) do
    ArmoredTrain.mk1.wagons[key] = {
        name = turret.name:gsub("-turret%-", "-wagon-"),
        utility = turret.utility,
        health = 1200, -- x2 Compared to vanilla
        weight = 2000, -- x2 Compared to vanilla
        inventorySize = 5,
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

-- Adds all mk1 wagons to total wagons
for _, wagonMk1 in pairs(ArmoredTrain.mk1.wagons) do
    table.insert(ArmoredTrain.total.wagons, wagonMk1)
end
