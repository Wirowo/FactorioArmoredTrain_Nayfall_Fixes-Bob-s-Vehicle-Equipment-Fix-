local locomotivesMk1 = {
    "armored-locomotive-mk1"
}

for _, locomotive in pairs(locomotivesMk1) do
    require("mk1." .. locomotive)
end
