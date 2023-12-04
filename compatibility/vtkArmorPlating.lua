if mods["vtk-armor-plating"] then
    -- Add armor plating category to all grids
    for _, grid in pairs(ArmoredTrain.grids) do
        if grid.name then
            Utils.addEquipmentCategory(grid.name, "vtk-armor-plating")
        end
    end
end
