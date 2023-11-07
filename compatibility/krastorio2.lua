if mods["Krastorio2"] then
    local addFuelCategory = require("utils").addFuelCategory
    local addEquipmentCategory = require("utils").addEquipmentCategory

    local locomotives = require("config.values.locomotivesValues")
    local turrets = require("config.values.turretsValues")
    local grids = require("config.values.gridsValues")

    -- For each locomotive adds krastorio2 categories
    for key, locomotive in pairs(locomotives) do
        addFuelCategory("locomotive", locomotive.name, "burner", "vehicle-fuel")
        addEquipmentCategory(grids, key, { "universal-equipment", "vehicle-equipment", "vehicle-motor" })
    end

    -- Adds karastorio2 equipment categories to Mk1 wagons
    addEquipmentCategory(grids, "wagonMk1", {
        "universal-equipment",
        "vehicle-equipment",
    })

    -- Adds karastorio2 equipment categories to Mk1 radar
    addEquipmentCategory(grids, "radarMk1", {
        "universal-equipment",
        "vehicle-equipment",
        "robot-interaction-equipment",
        "vehicle-robot-interaction-equipment",
    })

    -- Adds krastorio2 fuel category to radar turrets
    for _, turret in pairs(turrets) do
        if turret.name and string.find(turret.name, "radar") then
            addFuelCategory("radar", turret.name, "energy_source", "vehicle-fuel")
        end
    end
end
