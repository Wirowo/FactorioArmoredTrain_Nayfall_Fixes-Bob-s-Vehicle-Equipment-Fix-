local locomotives = require("config.values.locomotivesValues")
local wagons = require("config.values.combatWagonsValues")
local grids = require("config.values.gridsValues")
local changeGrid = require("utils").changeGrid

-------------
--- GRIDS ---
-------------

-- Upload generated grids
for _, grid in pairs(grids) do
    data:extend({ grid })
end

-- For each locomotive adds his expected grid
for _, locomotive in pairs(locomotives) do
    changeGrid("locomotive", locomotive.name, locomotive.name .. "-grid")
end

-- For each wagon adds his expected grid
for _, wagon in pairs(wagons) do
    -- Mk1
    if wagon.name and string.find(wagon.name, "mk1") then
        changeGrid("cargo-wagon", wagon.name, "armoredWagonMk1-grid")
        -- Radar
        if wagon.name and string.find(wagon.name, "radar") then
            changeGrid("cargo-wagon", wagon.name, "armoredRadarMk1-grid")
        end
    end
end
