-- Generates locomotive stats depending on tier
local generateLocomotiveStats = function(tier)
    local incrementalStats = {
        name = "armored-locomotive-mk" .. tier,
        max_health = 1000 + (1000 * tier),
        weight = 2000 + (500 * tier),
        max_speed = 1.2 - (0.1 * tier),
        max_power = 400 + (200 * tier) .. "kW",
        braking_force = 10 + (5 * tier),
        reversing_power_modifier = 0.6 + (0.1 * tier),
        friction_force = 0.50 - (0.05 * tier),
        air_resistance = 0.0075 - (0.001 * tier),
        energy_per_hit_point = 5 + (2 * tier),
        order = "a[train-system]-l[locomotive_mk" .. string.format("%02d", tier) .. "]",
        resistances = {
            {
                type = "fire",
                decrease = 15 + (5 * tier),
                percent = 50 - (5 * tier)
            },
            {
                type = "physical",
                decrease = 15 + (5 * tier),
                percent = 30 - (3 * tier)
            },
            {
                type = "impact",
                decrease = 50 + (10 * tier),
                percent = 60 - (5 * tier)
            },
            {
                type = "explosion",
                decrease = 15 + (5 * tier),
                percent = 30 - (3 * tier)
            },
            {
                type = "acid",
                decrease = 3 + tier,
                percent = 20 - (2 * tier)
            }
        }
    }

    return incrementalStats
end

-----------------------
----- LOCOMOTIVES -----
-----------------------

-- Is the same for all locomotives
local baseProperties = {
    stackSize = 5,
    mining_time = 0.5,
    burner = {
        fuel_categories = { "chemical" },
        effectivity = 1,
        fuelInventorySize = 5
    }
}

-- Locomotive Mk1
ArmoredTrain.mk1.locomotives.armoredLocomotiveMk1 = {
    grid = {
        width = 6,
        height = 6
    },
    recipe = {
        ingredients = {
            { "steel-plate",        60 },
            { "electronic-circuit", 10 },
            { "engine-unit",        40 }
        }
    },
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.locomotives.armoredLocomotiveMk1, baseProperties)
table.deep_extend(ArmoredTrain.mk1.locomotives.armoredLocomotiveMk1, generateLocomotiveStats(1)) -- Generates mk1 locomotive stats

-- Adds all mk1 locomotives to total locomotives
for _, locomotiveMk1 in pairs(ArmoredTrain.mk1.locomotives) do
    table.insert(ArmoredTrain.total.locomotives, locomotiveMk1)
end
