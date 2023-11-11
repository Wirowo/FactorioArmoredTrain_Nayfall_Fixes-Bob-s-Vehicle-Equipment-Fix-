-- Change file name to enable migrations! (Took me 2 days to find this out)

for index, force in pairs(game.forces) do
	if force.technologies["armored-train-turret-wagons-MK1"].researched then
		force.recipes["armored-locomotive-mk1"].enabled = true
		force.recipes["armored-cargo-wagon-mk1"].enabled = true
		force.recipes["armored-fluid-wagon-mk1"].enabled = true
		force.recipes["minigun-wagon-mk1"].enabled = true
		force.recipes["rocket-wagon-mk1"].enabled = true
		force.recipes["cannon-wagon-mk1"].enabled = true
		force.recipes["flamethrower-wagon-mk1"].enabled = true
		force.recipes["radar-wagon-mk1"].enabled = true
	end
end
