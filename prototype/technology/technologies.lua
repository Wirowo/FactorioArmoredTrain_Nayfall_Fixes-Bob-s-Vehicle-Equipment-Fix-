--------------------
--- TECHNOLOGIES ---
--------------------

-- Mk1 Tech

local techEffectMk1 = {}

-- Adds mk1 locomotives
for _, locomotive in pairs(ArmoredTrain.mk1.locomotives) do
	if locomotive.name then
		table.insert(techEffectMk1, {
			type = "unlock-recipe",
			recipe = locomotive.name
		})
	end
end

-- Adds mk1 wagons
for _, wagon in pairs(ArmoredTrain.mk1.wagons) do
	if wagon.name then
		table.insert(techEffectMk1, {
			type = "unlock-recipe",
			recipe = wagon.name
		})
	end
end

data:extend
({
	{
		type = "technology",
		name = "armored-train-turret-wagons",
		icon = "__Armored-train_Nayfall_Fixes__/prototype/technology/armored-train-technology-icon.png",
		icon_size = 128,
		-- Unlock recipes when technology researched
		effects = techEffectMk1,
		prerequisites = { "gun-turret", "military", "railway" },
		unit =
		{
			count = 100,
			ingredients =
			{
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack",   1 }
			},
			time = 20
		},
		order = "e-g"
	}
})

-- Base technologies
local baseTech = data.raw["technology"]

-- Add minigun turrets to physical projectile technologies bonus
for _, tech in pairs(baseTech) do
	-- Check if technology is a physical projectile buff
	if tech.name and string.find(tech.name, "physical%-projectile") then
		-- Iterate over all mod turrets
		for _, turret in pairs(ArmoredTrain.total.turrets) do
			-- Check if turret is a minigun
			if turret.name and string.find(turret.name, "minigun") then
				-- Insert turret on technology
				table.insert(tech.effects, {
					type = "turret-attack",
					turret_id = turret.name,
					modifier = 0.1
				})
			end
		end
	end
end
