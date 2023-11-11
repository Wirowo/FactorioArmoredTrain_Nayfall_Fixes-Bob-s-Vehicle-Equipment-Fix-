--------------------
--- TECHNOLOGIES ---
--------------------

-- Mk1 Tech
data:extend
({
	{
		type = "technology",
		name = ArmoredTrain.technologies.mk1.name,
		icon = "__Armored-train_Nayfall_Fixes__/prototype/technology/armored-train-technology-icon.png",
		icon_size = 128,
		-- Unlock recipes when technology researched
		effects = ArmoredTrain.technologies.mk1.effects,
		prerequisites = ArmoredTrain.technologies.mk1.prerequisites,
		unit = ArmoredTrain.technologies.mk1.unit,
		order = ArmoredTrain.technologies.mk1.order
	}
})

-- Base technologies
local baseTechs = data.raw["technology"]

-- Add minigun turrets to physical projectile technologies bonus
for _, tech in pairs(baseTechs) do
	-- Check if technology is a physical projectile buff
	if tech.name and string.find(tech.name, "physical%-projectile") then
		-- Copy gun turret effect
		local gunTurretEffect
		for _, effect in pairs(tech.effects) do
			if effect.turret_id and string.find(effect.turret_id, "turret") then
				gunTurretEffect = util.table.deepcopy(effect)
				break
			end
		end

		if gunTurretEffect then
			-- Iterate over all mod turrets
			for _, turret in pairs(ArmoredTrain.total.turrets) do
				-- Check if turret is a minigun
				if turret.name and string.find(turret.name, "minigun") then
					-- Changes turret name
					gunTurretEffect.turret_id = turret.name
					-- Insert turret on technology
					table.insert(tech.effects, gunTurretEffect)
				end
			end
		end
	end
end
