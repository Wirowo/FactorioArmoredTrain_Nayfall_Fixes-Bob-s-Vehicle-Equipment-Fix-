local modsFiles = {
    "krastorio2",
    "rampantArsenal",
    "vtkArmorPlating"
}

for _, mod in pairs(modsFiles) do
    require(mod)
end