local locomotives = require("config.values.locomotivesValues")
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
