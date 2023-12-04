local cargoWagonMk1 = ArmoredTrain.mk1.wagons.cargoMk1

------------
--- ITEM ---
------------

data:extend
({
    {
        type = "item",
        name = cargoWagonMk1.name,
        icon = "__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/platform-mk1-icon.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "transport",
        order = cargoWagonMk1.order,
        place_result = cargoWagonMk1.name,
        stack_size = cargoWagonMk1.stack_size
    }
})

--------------
--- RECIPE ---
--------------

data:extend
({
    {
        type = "recipe",
        name = cargoWagonMk1.name,
        enabled = false, -- default state (not researched)
        ingredients = cargoWagonMk1.recipe.ingredients,
        result = cargoWagonMk1.name
    }
})

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_cargo_wagon_mk1 = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])

-- Name
e_cargo_wagon_mk1.name = cargoWagonMk1.name

-- Inventory
e_cargo_wagon_mk1.inventory_size = cargoWagonMk1.inventory_size

-- Mining
e_cargo_wagon_mk1.minable =
{
    mining_time = cargoWagonMk1.mining_time,
    result = cargoWagonMk1.name
}

-- Animation
e_cargo_wagon_mk1.pictures = {
    layers = {
        {
            priority = "very-low",
            width = 256,
            height = 256,
            back_equals_front = false, --means to not rotate mirroring
            direction_count = 128,     --means to add aditional frames
            allow_low_quality_rotation = true,
            line_length = 32,
            lines_per_file = 1,
            shift = { 0.4, -1.25 },
            filenames =
            {
                "__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-01.png",
                "__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-02.png",
                "__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-03.png",
                "__Armored-train_Nayfall_Fixes__/assets/platforms/mk1/sprites/platform-mk1-04.png"
            }
        }
    }
}
e_cargo_wagon_mk1.horizontal_doors = nil
e_cargo_wagon_mk1.vertical_doors = nil

---------------
---- STATS ----
---------------

-- Hp
e_cargo_wagon_mk1.max_health = cargoWagonMk1
    .max_health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
e_cargo_wagon_mk1.weight = cargoWagonMk1.weight

-- Max speed
e_cargo_wagon_mk1.max_speed = cargoWagonMk1.max_speed

-- Braking force
e_cargo_wagon_mk1.braking_force = cargoWagonMk1.braking_force

-- Friction_force
e_cargo_wagon_mk1.friction_force = cargoWagonMk1.friction_force

-- Air resistance
e_cargo_wagon_mk1.air_resistance = cargoWagonMk1.air_resistance

-- Energy per hit point
e_cargo_wagon_mk1.energy_per_hit_point = cargoWagonMk1.energy_per_hit_point

-- Write result
data:extend
({
    e_cargo_wagon_mk1
})
