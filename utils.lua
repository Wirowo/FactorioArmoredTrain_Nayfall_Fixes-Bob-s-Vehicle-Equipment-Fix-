Utils = {}

-- Function to check if an element exists in a table
Utils.tableContains = function(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- Function to add a new fuel category
Utils.addFuelCategory = function(entityType, entityName, finalLocation, newCategories)
    if data.raw[entityType][entityName] then
        local actualCategoriesTable = data.raw[entityType][entityName][finalLocation].fuel_categories
        local newCategoriesTable = {}

        -- Make a copy of actual categories on a new table
        for _, category in pairs(actualCategoriesTable) do
            table.insert(newCategoriesTable, category)
        end

        -- Check the type of newCategories
        if type(newCategories) == "string" then
            -- If it's a string, add it to the new table
            table.insert(newCategoriesTable, newCategories)
        elseif type(newCategories) == "table" then
            -- If it's a table, add its elements to the new table
            for _, newCategory in pairs(newCategories) do
                if not Utils.tableContains(newCategoriesTable, newCategory) then
                    table.insert(newCategoriesTable, newCategory)
                end
            end
        end

        data.raw[entityType][entityName][finalLocation].fuel_categories = newCategoriesTable
    end
end

-- Function to add a new equipment category to a grid
Utils.addEquipmentCategory = function(gridName, newCategories)
    if data.raw["equipment-grid"][gridName] then
        local actualCategoriesTable = data.raw["equipment-grid"][gridName].equipment_categories
        local newCategoriesTable = {}

        -- Make a copy of actual categories on a new table
        for _, category in pairs(actualCategoriesTable) do
            table.insert(newCategoriesTable, category)
        end

        -- Check the type of newCategories
        if type(newCategories) == "string" then
            -- If it's a string, add it to the new table
            table.insert(newCategoriesTable, newCategories)
        elseif type(newCategories) == "table" then
            -- If it's a table, add its elements to the new table
            for _, newCategory in pairs(newCategories) do
                if not Utils.tableContains(newCategoriesTable, newCategory) then
                    table.insert(newCategoriesTable, newCategory)
                end
            end
        end

        data.raw["equipment-grid"][gridName].equipment_categories = newCategoriesTable
    end
end

-- Function to change or add a grid
Utils.changeGrid = function(entityType, entityName, gridName)
    if data.raw[entityType][entityName] then
        data.raw[entityType][entityName].equipment_grid = gridName
    end
end

return Utils
