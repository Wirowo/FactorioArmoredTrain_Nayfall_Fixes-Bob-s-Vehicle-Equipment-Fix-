local wagonsMk1 = {
    "cannon-wagon-mk1",
    "flamethrower-wagon-mk1",
    "minigun-wagon-mk1",
    "radar-wagon-mk1",
    "rocket-wagon-mk1"
}

for _, wagon in pairs(wagonsMk1) do
    require("mk1." .. wagon)
end
