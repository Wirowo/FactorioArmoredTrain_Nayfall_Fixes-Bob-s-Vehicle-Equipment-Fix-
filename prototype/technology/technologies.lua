local locomotives = require("config.values.locomotivesValues")
local turrets = require("config.values.turretsValues")
local wagons = require("config.values.combatWagonsValues")

local techEffect = {}

-- Adds locomotives
for _, locomotive in pairs(locomotives) do
	table.insert(techEffect, {
		type = "unlock-recipe",
		recipe = locomotive.name
	})
end

-- Adds wagons
for _, wagon in pairs(wagons) do
	table.insert(techEffect, {
		type = "unlock-recipe",
		recipe = wagon.name
	})
end

data:extend
({
	{
		type = "technology",
		name = "armored-train-turret-wagons",
		icon = "__Armored-train_Modified__/prototype/technology/armored-train-technology-icon.png",
		icon_size = 128,
		-- Unlock recipes when technology researched
		effects = techEffect,
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
		for _, turret in pairs(turrets) do
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
