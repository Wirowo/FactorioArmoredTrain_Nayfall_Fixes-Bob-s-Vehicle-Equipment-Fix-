local generateCannonTurretStats = function(tier)
    local incrementalStats = {
        name = "cannon-turret-mk" .. tier,
        damage_modifier = 1.25 + (1.25 * (tier - 1)),
        cooldown = 60 / (1 + (0.25 * (tier - 1))), -- Shoots per second
    }
    return incrementalStats
end

local generateFlamethrowerTurretStats = function(tier)
    local incrementalStats = {
        name = "flamethrower-turret-mk" .. tier,
        damage_modifier = 1.25 + (1.25 * (tier - 1)),
    }
    return incrementalStats
end

local generateMinigunTurretStats = function(tier)
    local incrementalStats = {
        name = "minigun-turret-mk" .. tier,
        damage_modifier = 1.25 + (1.25 * (tier - 1)),
    }
    return incrementalStats
end

local generateRocketTurretStats = function(tier)
    local incrementalStats = {
        name = "rocket-turret-mk" .. tier,
        damage_modifier = 1.25 + (1.25 * (tier - 1)),
        cooldown = 60 / (1.5 + (0.50 * (tier - 1))), -- Shoots per second
    }
    return incrementalStats
end

local generateRadarTurretStats = function(tier)
    local incrementalStats = {
        name = "radar-turret-mk" .. tier,
        energy_usage = 100 + (50 * tier) .. "kW",
        energy_per_sector = 3.5 + (1.5 * tier) .. "MJ",
        max_distance_of_sector_revealed = 2 + (1 * tier),
        energy_per_nearby_scan = 85 - (15 * tier) .. "kJ",
        max_distance_of_nearby_sector_revealed = 1 + (0.5 * tier),
    }
    return incrementalStats
end

------------------
---- TURRETS -----
------------------

-- Is the same for all turrets
local baseProperties = {
    inventory_size = 3
}

-- MK1

-- Cannon
ArmoredTrain.mk1.turrets.cannonMk1 = {
    utility = false,
    range = 40,
    min_range = 10,
    -- Takes this to craft the wagon
    recipe = {
        ingredients = {
            { "iron-plate",       40 },
            { "steel-plate",      40 },
            { "iron-gear-wheel",  20 },
            { "engine-unit",      15 },
            { "advanced-circuit", 5 }
        }
    }
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.turrets.cannonMk1, baseProperties)
table.deep_extend(ArmoredTrain.mk1.turrets.cannonMk1, generateCannonTurretStats(1)) -- Generates mk1 cannon turret stats

-- Flamethrower
ArmoredTrain.mk1.turrets.flamethrowerMk1 = {
    utility = false,
    cooldown = 60 / 60, -- Same as vanilla
    range = 30,         -- Same as vanilla
    min_range = 6,      -- Same as vanilla
    -- Takes this to craft the wagon
    recipe = {
        ingredients = {
            { "iron-plate",      40 },
            { "steel-plate",     40 },
            { "iron-gear-wheel", 20 },
            { "engine-unit",     15 },
            { "pipe",            10 }
        }
    }
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.turrets.flamethrowerMk1, baseProperties)
table.deep_extend(ArmoredTrain.mk1.turrets.flamethrowerMk1, generateFlamethrowerTurretStats(1)) -- Generates mk1 flamethrower turret stats

-- Minigun
ArmoredTrain.mk1.turrets.minigunMk1 = {
    utility = false,
    cooldown = 60 / 10, -- Same as vanilla
    range = 35,
    -- Takes this to craft the wagon
    recipe = {
        ingredients = {
            { "iron-plate",      20 },
            { "steel-plate",     20 },
            { "iron-gear-wheel", 10 },
            { "engine-unit",     15 },
            { "copper-plate",    10 }
        }
    }
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.turrets.minigunMk1, baseProperties)
table.deep_extend(ArmoredTrain.mk1.turrets.minigunMk1, generateMinigunTurretStats(1)) -- Generates mk1 minigun turret stats

-- Rocket
ArmoredTrain.mk1.turrets.rocketMk1 = {
    utility = false,
    range = 50,
    min_range = 20,
    -- Takes this to craft the wagon
    recipe = {
        ingredients = {
            { "iron-plate",         20 },
            { "steel-plate",        20 },
            { "iron-gear-wheel",    10 },
            { "engine-unit",        15 },
            { "electronic-circuit", 20 }
        }
    }
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.turrets.rocketMk1, baseProperties)
table.deep_extend(ArmoredTrain.mk1.turrets.rocketMk1, generateRocketTurretStats(1)) -- Generates mk1 rocket turret stats

-- Radar
ArmoredTrain.mk1.turrets.radarMk1 = {
    utility = true,
    burner = {
        effectivity = 1,
        fuel_inventory_size = baseProperties.inventory_size
    },
    -- Takes this to craft the wagon
    recipe = {
        ingredients = {
            { "iron-plate",         20 },
            { "steel-plate",        20 },
            { "iron-gear-wheel",    10 },
            { "engine-unit",        15 },
            { "electronic-circuit", 5 }
        }
    }
}

-- Adds remaining stats
table.deep_extend(ArmoredTrain.mk1.turrets.radarMk1, generateRadarTurretStats(1)) -- Generates mk1 radar turret stats

-- Adds all mk1 turrets to total turrets
for _, turretMk1 in pairs(ArmoredTrain.mk1.turrets) do
    table.insert(ArmoredTrain.total.turrets, turretMk1)
end
