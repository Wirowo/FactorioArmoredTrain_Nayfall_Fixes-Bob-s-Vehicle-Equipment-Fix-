if mods["RampantArsenal"] then
    -- Adds rampant arsenal categories to all grids
    for _, grid in pairs(ArmoredTrain.grids) do
        if grid.name then
            -- Is locomotive?
            if string.find(grid.name, "locomotive") then
                Utils.addEquipmentCategory(grid.name,
                    { "noInventory", "movement" })
                -- Is turret?
            elseif string.find(grid.name, "turret") then
                Utils.addEquipmentCategory(grid.name, {
                    "noInventory"
                })
                -- Is fluid?
            elseif string.find(grid.name, "fluid") then
                Utils.addEquipmentCategory(grid.name, {
                    "noInventory"
                })
            else -- Else(Is utility)
                Utils.addEquipmentCategory(grid.name, {
                    "immobile",
                    "noInventory",
                })
            end
        end
    end
end
