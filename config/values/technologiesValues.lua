------------------------
----- TECHNOLOGIES -----
------------------------

-- Technology mk1
ArmoredTrain.technologies.mk1 = {
    name = "armored-train-turret-wagons-MK1",
    prerequisites = { "gun-turret", "military", "railway" },
    effects = {}, -- Added dynamically
    unit =
    {
        count = 100,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
        },
        time = 20
    },
    order = "e-g"
}

-- Adds mk1 locomotives
for _, locomotive in pairs(ArmoredTrain.mk1.locomotives) do
    if locomotive.name then
        table.insert(ArmoredTrain.technologies.mk1.effects, {
            type = "unlock-recipe",
            recipe = locomotive.name
        })
    end
end

-- Adds mk1 wagons
for _, wagon in pairs(ArmoredTrain.mk1.wagons) do
    if wagon.name then
        table.insert(ArmoredTrain.technologies.mk1.effects, {
            type = "unlock-recipe",
            recipe = wagon.name
        })
    end
end
