local turretsMk1 = {
    "cannon-turret-mk1",
    "flamethrower-turret-mk1",
    "minigun-turret-mk1",
    "radar-turret-mk1",
    "rocket-turret-mk1"
}

for _, turret in pairs(turretsMk1) do
    require("mk1." .. turret)
end
