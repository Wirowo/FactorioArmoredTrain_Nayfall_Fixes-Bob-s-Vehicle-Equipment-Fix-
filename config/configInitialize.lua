-- A representation of the mod data structure
ArmoredTrain = {
    mk1 = {
        locomotives = {},
        turrets = {},
        wagons = {},
    },
    -- Total entities added
    total = {
        locomotives = {},
        turrets = {},
        wagons = {}
    },
    grids = {},
    technologies = {},
    -- Place to store some data
    bases = {
        grids = {}
    }
}

-- Locomotives
require("values.locomotivesValues")

-- Turrets
require("values.turretsValues")

-- Wagons
require("values.wagonsValues")

-- Grids
require("values.gridsValues")

-- Technologies
require("values.technologiesValues")

return ArmoredTrain
