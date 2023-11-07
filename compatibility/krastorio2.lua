if mods["Krastorio2"] then
    local locomotives = require("config.values.locomotivesValues")
    local grids = require("config.values.gridsValues")
    local addFuelCategory = require("utils").addFuelCategory
    local addEquipmentCategory = require("utils").addEquipmentCategory

    -- For each locomotive adds krastorio2 categories
    for key, locomotive in pairs(locomotives) do
        addFuelCategory("locomotive", locomotive.name, "vehicle-fuel")
        addEquipmentCategory(grids, key, { "universal-equipment", "vehicle-equipment", "vehicle-motor" })
    end
end
