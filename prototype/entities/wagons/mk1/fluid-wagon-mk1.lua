local fluidWagonMk1 = ArmoredTrain.mk1.wagons.fluidMk1

------------
--- ITEM ---
------------

data:extend
({
    {
        type = "item",
        name = fluidWagonMk1.name,
        icon = "__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/wagon-mk1-icon.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "transport",
        order = fluidWagonMk1.order,
        place_result = fluidWagonMk1.name,
        stack_size = fluidWagonMk1.stack_size
    }
})

--------------
--- RECIPE ---
--------------

data:extend
({
    {
        type = "recipe",
        name = fluidWagonMk1.name,
        enabled = false, -- default state (not researched)
        ingredients = fluidWagonMk1.recipe.ingredients,
        result = fluidWagonMk1.name
    }
})

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_fluid_wagon_mk1 = table.deepcopy(data.raw["fluid-wagon"]["fluid-wagon"])

-- Name
e_fluid_wagon_mk1.name = fluidWagonMk1.name

-- Capacity
e_fluid_wagon_mk1.capacity = fluidWagonMk1.capacity

-- Mining
e_fluid_wagon_mk1.minable =
{
    mining_time = fluidWagonMk1.mining_time,
    result = fluidWagonMk1.name
}

-- Animation
e_fluid_wagon_mk1.pictures = {
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
                "__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-01.png",
                "__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-02.png",
                "__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-03.png",
                "__Armored-train_Nayfall_Fixes__/assets/wagons/mk1/sprites/wagon-mk1-04.png"
            }
        }
    }
}
e_fluid_wagon_mk1.horizontal_doors = nil
e_fluid_wagon_mk1.vertical_doors = nil

---------------
---- STATS ----
---------------

-- Hp
e_fluid_wagon_mk1.max_health = fluidWagonMk1
    .max_health -- Same as turret hp (Critical component or will be destroyed using old script)	

-- Weight
e_fluid_wagon_mk1.weight = fluidWagonMk1.weight

-- Max speed
e_fluid_wagon_mk1.max_speed = fluidWagonMk1.max_speed

-- Braking force
e_fluid_wagon_mk1.braking_force = fluidWagonMk1.braking_force

-- Friction_force
e_fluid_wagon_mk1.friction_force = fluidWagonMk1.friction_force

-- Air resistance
e_fluid_wagon_mk1.air_resistance = fluidWagonMk1.air_resistance

-- Energy per hit point
e_fluid_wagon_mk1.energy_per_hit_point = fluidWagonMk1.energy_per_hit_point

-- Write result
data:extend
({
    e_fluid_wagon_mk1
})
