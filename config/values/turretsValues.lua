local turrets = {}

turrets.cannonMk1 = {
    name = "cannon-turret-mk1",
    damageModifier = 1.5,
    range = 40,
    minRange = 10,
    inventorySize = 3,
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

turrets.flamethrowerMk1 = {
    name = "flamethrower-turret-mk1",
    damageModifier = 1.5,
    range = 30,
    minRange = 6,
    inventorySize = 3,
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

turrets.minigunMk1 = {
    name = "minigun-turret-mk1",
    damageModifier = 1.5,
    range = 35,
    inventorySize = 3,
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

turrets.radarMk1 = {
    name = "radar-turret-mk1",
    energyUsage = "100kW",
    energyPerSector = "3.5MJ",
    maxDistanceOfSector = 2,
    energyPerNearbyScan = "85kJ",
    maxDistanceOfNearbySector = 1,
    burner = {
        effectivity = 1,
        fuelInventorySize = 3
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

turrets.rocketMk1 = {
    name = "rocket-turret-mk1",
    damageModifier = 1.5,
    range = 50,
    minRange = 20,
    inventorySize = 3,
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

return turrets
