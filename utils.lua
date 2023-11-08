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

-- Function to add a new equipment category toa grid
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

-- Test
Utils.setEntityData = function(entity, data)
    if not entity or not entity.valid then
        return nil
    end

    local unit_number = entity.unit_number
    local entity_name = entity.name

    if not unit_number and not entity_name then
        return nil
    end

    if not global._entity_data then
        global._entity_data = {}
    end

    local function are_equal(entity_a, entity_b)
        if entity_a == nil then
            return entity_a == entity_b
        elseif entity_a == entity_b then
            return true
        elseif entity_a.equals and entity_a:equals(entity_b) then
            return true
        else
            return false
        end
    end

    if unit_number then
        global._entity_data[unit_number] = data
    else
        if not global._entity_data[entity_name] then
            global._entity_data[entity_name] = {}
        end

        local entity_category = global._entity_data[entity_name]

        for i = #entity_category, 1, -1 do
            local entity_data = entity_category[i]
            if not entity_data.entity.valid then
                table.remove(entity_category, i)
            end
            if are_equal(entity_data.entity, entity) then
                local prev = entity_data.data
                if data then
                    entity_data.data = data
                else
                    table.remove(entity_category, i)
                end
                return prev
            end
        end

        table.insert(entity_category, { entity = entity, data = data })
    end

    return nil
end

return Utils