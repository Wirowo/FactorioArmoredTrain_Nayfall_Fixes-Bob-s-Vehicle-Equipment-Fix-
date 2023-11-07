local turrets = {}

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

return turrets
