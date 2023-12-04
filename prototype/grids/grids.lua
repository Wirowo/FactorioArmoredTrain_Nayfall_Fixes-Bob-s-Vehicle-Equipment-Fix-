-------------
--- GRIDS ---
-------------

-- Upload generated grids
for _, grid in pairs(ArmoredTrain.grids) do
    data:extend({ grid })
end

-- For each locomotive adds his expected grid
for _, locomotive in pairs(ArmoredTrain.total.locomotives) do
    Utils.changeGrid("locomotive", locomotive.name, locomotive.name .. "-grid")
end

-- For each wagon adds his expected grid
for _, wagon in pairs(ArmoredTrain.total.wagons) do
    if wagon.name then
        -- Get tier number
        local tier = tonumber(wagon.name:match("mk(%d+)"))
        -- Is not a utility wagon?
        if not wagon.utility then
            Utils.changeGrid("cargo-wagon", wagon.name, ArmoredTrain.bases.grids.turretWagon .. tier .. "-grid")
        else
            -- Is not a fluid wagon?
            if not string.find(wagon.name, "fluid") then
                Utils.changeGrid("cargo-wagon", wagon.name, ArmoredTrain.bases.grids.utilityWagon .. tier .. "-grid")
            else
                Utils.changeGrid("fluid-wagon", wagon.name, ArmoredTrain.bases.grids.fluidWagon .. tier .. "-grid")
            end
        end
    end
end
