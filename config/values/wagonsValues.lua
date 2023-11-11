-- Generates cargo wagon stats depending on tier
local generateWagonStats = function(tier)
    local incrementalStats = {
        max_health = 600 + (600 * tier),
        weight = 1000 + (250 * tier),
        max_speed = 1.5 - (0.1 * tier),
        braking_force = 3 + (1 * tier),
        friction_force = 0.50 - (0.05 * tier),
        air_resistance = 0.01 - (0.001 * tier),
        energy_per_hit_point = 5 + (2 * tier),
        order = "a[train-system]-l[wagon_mk" .. string.format("%02d", tier) .. "]",
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

------------------
----- WAGONS -----
------------------

-- Wagons auto generates for each turret

-- Is the same for all turret wagons
local turretWagonBaseProperties = {
    stack_size = 5,
    mining_time = 0.5,
    inventory_size = 5,
}

-- Is the same for all cargo wagons
local cargoWagonBaseProperties = {
    stack_size = 5,
    mining_time = 0.5,
    inventory_size = 20
}

-- Is the same for all fluid wagons
local fluidWagonBaseProperties = {
    stack_size = 5,
    mining_time = 0.5,
    capacity = 12500
}

-- Turret wagon Mk1
for key, turret in pairs(ArmoredTrain.mk1.turrets) do
    ArmoredTrain.mk1.wagons[key] = {
        name = turret.name:gsub("-turret%-", "-wagon-"),
        utility = turret.utility,
        recipe = turret.recipe,
    }

    -- Adds remaining stats
    table.deep_extend(ArmoredTrain.mk1.wagons[key], turretWagonBaseProperties)
    table.deep_extend(ArmoredTrain.mk1.wagons[key], generateWagonStats(1)) -- Generates mk1 wagons stats
end

-- Cargo wagon Mk1
ArmoredTrain.mk1.wagons.cargoMk1 = {
    name = "armored-cargo-wagon-mk1",
    utility = true,
    recipe = {
        ingredients = {
            { "iron-gear-wheel", 20 },
            { "iron-plate",      40 },
            { "steel-plate",     40 }
        }
    }
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.wagons.cargoMk1, cargoWagonBaseProperties)
table.deep_extend(ArmoredTrain.mk1.wagons.cargoMk1, generateWagonStats(1)) -- Generates mk1 wagons stats

-- Fluid wagon Mk1
ArmoredTrain.mk1.wagons.fluidMk1 = {
    name = "armored-fluid-wagon-mk1",
    utility = true,
    recipe = {
        ingredients = {
            { "iron-gear-wheel", 20 },
            { "steel-plate",     32 },
            { "pipe",            16 },
            { "storage-tank",    2 }
        }
    }
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.wagons.fluidMk1, fluidWagonBaseProperties)
table.deep_extend(ArmoredTrain.mk1.wagons.fluidMk1, generateWagonStats(1)) -- Generates mk1 wagons stats

-- Adds all mk1 wagons to total wagons
for _, wagonMk1 in pairs(ArmoredTrain.mk1.wagons) do
    table.insert(ArmoredTrain.total.wagons, wagonMk1)
end
