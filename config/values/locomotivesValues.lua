local armoredLocomotives = {}

-- Locomotive Mk1
armoredLocomotives.armoredMk1 = {
    name = "armored-locomotive-mk1",
    health = 2000,
    weight = 20000,
    maxPower = "4MW",
    stackSize = 5,
    burner = {
        effectivity = 1,
        fuelInventorySize = 5
    },
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
    }
}

return armoredLocomotives
