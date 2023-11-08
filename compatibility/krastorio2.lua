if mods["Krastorio2"] then
    -- Adds krastorio2 fuel categories to all locomotives
    for _, locomotive in pairs(ArmoredTrain.total.locomotives) do
        if locomotive.name then
            Utils.addFuelCategory("locomotive", locomotive.name, "burner", "vehicle-fuel")
        end
    end

    -- Adds krastorio2 fuel category to radar turrets
    for _, turret in pairs(ArmoredTrain.total.turrets) do
        if turret.name and string.find(turret.name, "radar") then
            Utils.addFuelCategory("radar", turret.name, "energy_source", "vehicle-fuel")
        end
    end

    -- Adds krastorio2 categories to all grids
    for _, grid in pairs(ArmoredTrain.grids) do
        if grid.name then
            -- Is locomotive?
            if string.find(grid.name, "locomotive") then
                Utils.addEquipmentCategory(grid.name,
                    { "universal-equipment", "vehicle-equipment", "vehicle-motor" })
                -- Is turret?
            elseif string.find(grid.name, "turret") then
                Utils.addEquipmentCategory(grid.name, {
                    "universal-equipment",
                    "vehicle-equipment",
                })
                -- Else(Is utility)
            else
                Utils.addEquipmentCategory(grid.name, {
                    "universal-equipment",
                    "vehicle-equipment",
                    "robot-interaction-equipment",
                    "vehicle-robot-interaction-equipment",
                })
            end
        end
    end
end
