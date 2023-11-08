-- Locomotive Mk1
ArmoredTrain.mk1.locomotives.armoredLocomotiveMk1 = {
    name = "armored-locomotive-mk1",
    -- x2 Compared to vanilla
    health = 2000,
    -- x2 Compared to vanilla
    weight = 4000,
    -- Almost x1,7 compared to vanilla
    maxPower = "1MW",
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
    },
    -- 10% More than vanilla
    resistances = {
        {
            type = "fire",
            decrease = 17,
            percent = 55
        },
        {
            type = "physical",
            decrease = 17,
            percent = 33
        },
        {
            type = "impact",
            decrease = 55,
            percent = 66
        },
        {
            type = "explosion",
            decrease = 17,
            percent = 33
        },
        {
            type = "acid",
            decrease = 4,
            percent = 22
        }
    }
}

-- Adds all mk1 locomotives to total locomotives
for _, locomotiveMk1 in pairs(ArmoredTrain.mk1.locomotives) do
    table.insert(ArmoredTrain.total.locomotives, locomotiveMk1)
end
